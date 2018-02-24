

local o = VendorValues;
local m = {};
local m_metatable = { __index = m };


local l_t_OnConfigLoaded; -- (config)

local l_RegisterTooltip; -- (tooltip)
local l_h_OnTooltipSetItem; -- (tooltip)

local l_CreatePrefixText; -- prefixText = (baseID, quantity)

local l_SetupMoneyFrameOnHideHook; -- (moneyFrame)
local l_h_MoneyFrameOnHide; -- (moneyFrame)

-- local l_m_GetBaseID; -- baseID = (self, existingBaseID)

-- local l_m_AddVendorValue; -- money, moneyLine, separatorLine, currMoneyFrame = (self, baseID, quantity, r, g, b)
-- local l_m_UpdateQuantity; -- (self, newQuantity)
-- local l_m_GetVendorValue; -- money, moneyLine, separatorLine, currMoneyFrame = (self)

-- local l_m_CalculateAndCachePrice; -- price = (self, baseID)
-- local l_m_AddMoneyLine; -- (self, r, g, b)
-- local l_m_SetupMoneyLineInfo; -- (money, prefixText)


local GetItemInfo = GetItemInfo; -- CreatePrefixText, h_OnTooltipSetItem

local _G = _G; -- m_AddVendorValue, m_AddMoneyLine


local l_config;




function l_t_OnConfigLoaded(config)
	l_t_OnConfigLoaded = nil;
	o.t_Tooltips_OnConfigLoaded = nil;
	
	l_config = config;
end

o.t_Tooltips_OnConfigLoaded = l_t_OnConfigLoaded;




function l_RegisterTooltip(tooltip)
	if (tooltip.VendorValues ~= nil) then
		return;
	end
	
	TooltipItemQuantities1.RegisterTooltip(tooltip);
	
	local instance = {
	  parent = tooltip;
	  orig_OnTooltipSetItem = tooltip:GetScript("OnTooltipSetItem");
	};
	setmetatable(instance, m_metatable);
	tooltip:SetScript("OnTooltipSetItem", l_h_OnTooltipSetItem);
	tooltip.VendorValues = instance;
end

o.Tooltips_RegisterTooltip = l_RegisterTooltip;



do
	local MerchantFrame = MerchantFrame;
	
	function l_h_OnTooltipSetItem(tooltip)
		local instance = tooltip.VendorValues;
		local orig = instance.orig_OnTooltipSetItem;
		if (orig ~= nil) then orig(tooltip); end
		
		local baseID = instance:GetBaseID();
		if (baseID ~= nil) then
			-- If this isn't yet cached, the tooltip will be manipulating itself as the item becomes cached. Do not set up yet if so.
			if (GetItemInfo(baseID) ~= nil) then
				local quantity, source = tooltip.TooltipItemQuantities1:GetItemQuantity();
				if ((source ~= "SetBagItem" and source ~= "SetAction") or MerchantFrame:IsShown() == nil) then
					instance:AddVendorValue(baseID, quantity);
				end
			end
		end
	end
end




function l_CreatePrefixText(baseID, quantity)
	local prefix = nil;
	
	if (l_config.hidePrefix ~= true) then
		local _, _, _, _, _, _, _, maxStack = GetItemInfo(baseID);
		if (maxStack == 1 or maxStack == nil) then
			prefix = l_config.prefix;
		else
			prefix = l_config.prefixStack:format(quantity);
		end
	else
		prefix = (" ");
	end
	
	return prefix;
end




function l_SetupMoneyFrameOnHideHook(moneyFrame)
	if (moneyFrame.VendorValues_orig_OnHide == nil) then
		moneyFrame.VendorValues_orig_OnHide = (moneyFrame:GetScript("OnHide") or false);
		moneyFrame:SetScript("OnHide", l_h_MoneyFrame_OnHide);
	end
end


function l_h_MoneyFrame_OnHide(moneyFrame)
	SetMoneyFrameColor(moneyFrame:GetName(), 1.0, 1.0, 1.0);
	local orig = moneyFrame.VendorValues_orig_OnHide;
	if (orig) then orig(moneyFrame); end
end




do
	local tonumber = tonumber;
	local type = type;
	local stringmatch = string.match;
	
	function m:GetBaseID(existingBaseID)
		local baseID = nil;
		
		if (existingBaseID ~= nil) then
			if (type(existingBaseID) == "string") then
				baseID = tonumber(stringmatch(existingBaseID, "item:(%d+)"));
			else
				baseID = existingBaseID;
			end
		end
		
		if (baseID == nil) then
			local _, link = self.parent:GetItem();
			if (link ~= nil) then
				baseID = tonumber(stringmatch(link, "item:(%d+)", 13));
			end
		end
		
		return baseID;
	end
end




do
	local l_SEPARATOR = ("-=-=-=-=-=-=-=-=-");
	
	function m:AddVendorValue(baseID, quantity, r, g, b)
		baseID = self:GetBaseID(baseID, true);
		
		if (quantity == nil or quantity == 0) then
			quantity = 1;
		end
		if (r == nil and g == nil and b == nil) then
			r, g, b = l_config.textR, l_config.textG, l_config.textB;
		end
		
		local parent = self.parent;
		
		if (self.lastBaseID == baseID) then
			if (self.separatorLine ~= nil) then
				self.separatorLine:SetText("");
			end
			if (self.moneyLine ~= nil) then
				self.moneyLine:SetText("");
			end
			if (self.currMoneyFrame ~= nil) then
				self.currMoneyFrame:Hide();
				local newNum = parent.shownMoneyFrames;
				if (newNum ~= nil) then
					newNum = (newNum - 1);
					parent.shownMoneyFrames = ((newNum ~= 0 and newNum) or nil);
				end
			end
		end
		
		
		local separatorLine = nil;
		if (l_config.addSeparator == true) then
			parent:AddLine(l_SEPARATOR, r, g, b);
			separatorLine = _G[parent:GetName() .. "TextLeft" .. parent:NumLines()];
		end
		
		self:AddMoneyLine(r, g, b);
		local money = self:CalculateAndCachePrice(baseID);
		if (money ~= nil) then
			money = (money * quantity);
		end
		self:SetupMoneyLineInfo(money, l_CreatePrefixText(baseID, quantity));
		
		parent:Show();
		
		self.separatorLine = separatorLine;
		self.money = money;
		return self:GetVendorValue();
	end
end



function m:UpdateQuantity(newQuantity)
	local newMoney = (self.cachedPrice * newQuantity);
	self.money = newMoney;
	self:SetupMoneyLineInfo(newMoney, l_CreatePrefixText(self.lastBaseID, newQuantity));
end



function m:GetVendorValue()
	return self.money, self.moneyLine, self.separatorLine, self.currMoneyFrame;
end




do
	local GetSellValue = GetSellValue;
	
	function m:CalculateAndCachePrice(baseID)
		baseID = self:GetBaseID(baseID, true);
		
		local price;
		if (self.lastBaseID == baseID) then
			-- Avoid a database lookup.
			price = self.cachedPrice;
		else
			price = GetSellValue(baseID);
			self.lastBaseID = baseID;
			self.cachedPrice = price;
		end
		return price;
	end
end




function m:AddMoneyLine(r, g, b)
	local tooltip = self.parent;
	local tooltipName = tooltip:GetName();
	SetTooltipMoney(tooltip, 0);
	
	local moneyLine = _G[tooltipName .. "TextLeft" .. tooltip:NumLines()];
	self.moneyLine = moneyLine;
	moneyLine:SetTextColor(r, g, b);
	
	local moneyFrameName = (tooltipName .. "MoneyFrame" .. tooltip.shownMoneyFrames);
	local moneyFrame = _G[moneyFrameName];
	if (r ~= 1.0 or g ~= 1.0 or b ~= 1.0) then
		l_SetupMoneyFrameOnHideHook(moneyFrame);
	end
	self.currMoneyFrame = moneyFrame;
	moneyFrame:SetPoint("LEFT", moneyLine, "RIGHT", 4, 0);
	SetMoneyFrameColor(moneyFrameName, r, g, b);
end



do
	local loc_VALUE_NONE = ("<" .. NONE:lower() .. ">");
	local loc_VALUE_UNKNOWN = ("<" .. UNKNOWN:lower() .. ">");
	
	function m:SetupMoneyLineInfo(money, prefixText)
		local lineText = prefixText;
		local minWidth = -10;
		
		local moneyFrame = self.currMoneyFrame;
		if (money ~= nil) then
			if (money ~= 0) then
				moneyFrame:Show();
				MoneyFrame_Update(moneyFrame:GetName(), money);
				minWidth = (minWidth + moneyFrame:GetWidth());
			else
				moneyFrame:Hide();
				lineText = (lineText .. " " .. loc_VALUE_NONE);
			end
		else
			moneyFrame:Hide();
			lineText = (lineText .. " " .. loc_VALUE_UNKNOWN);
		end
		
		local moneyLine = self.moneyLine;
		moneyLine:SetText(lineText);
		minWidth = (minWidth + moneyLine:GetWidth());
		
		self.parent:SetMinimumWidth(minWidth);
	end
end

