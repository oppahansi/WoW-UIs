

local o = TooltipItemQuantities1; if (o.SHOULD_LOAD == nil) then return; end
local m = {};
local m_metatable;


local l_t_GetLocals; -- embedMeta, tooltipMethodWrappers, wrapperUpvalueSetter = ()
local l_SetWrapperUpvalueFunc; -- (newFunc)

local l_RegisterTooltip; -- (tooltip)

-- local l_m_GetItemQuantity; -- quantity, source = (self)

local l_OnTooltipItemMethodCalled; -- (methodName, tooltip, ...)

local l_GetQuantity_SetHyperlink; -- quantity = ()
local l_GetQuantity_SetInventoryItem; -- quantity = (unit, slot)
local l_GetQuantity_SetTradeSkillItem; -- quantity = (selectedSkill, id)


local l_TOOLTIP_QUANTITY_METHODS = {
	["SetAction"] = { quantityFunc = GetActionCount };
	["SetAuctionItem"] = { quantityFunc = GetAuctionItemInfo, returnIndex = 3 };
	["SetBagItem"] = { quantityFunc = GetContainerItemInfo, returnIndex = 2 };
	["SetCraftItem"] = { quantityFunc = GetCraftReagentInfo, returnIndex = 3 };
	["SetGuildBankItem"] = { quantityFunc = GetGuildBankItemInfo, returnIndex = 2 };
	["SetHyperlink"] = { quantityFunc = nil };
	["SetInboxItem"] = { quantityFunc = GetInboxItem, returnIndex = 3 };
	["SetInventoryItem"] = { quantityFunc = nil };
	["SetLootItem"] = { quantityFunc = GetLootSlotInfo, returnIndex = 3 };
	["SetLootRollItem"] = { quantityFunc = GetLootRollItemInfo, returnIndex = 3 };
	["SetMerchantItem"] = { quantityFunc = GetMerchantItemInfo, returnIndex = 4 };
	["SetQuestItem"] = { quantityFunc = GetQuestItemInfo, returnIndex = 3 };
	["SetQuestLogItem"] = { quantityFunc = GetQuestLogRewardInfo, returnIndex = 3, argsStartIndex = 2 };
	["SetTradePlayerItem"] = { quantityFunc = GetTradePlayerItemInfo, returnIndex = 3 };
	["SetTradeTargetItem"] = { quantityFunc = GetTradeTargetItemInfo, returnIndex = 3 };
	["SetTradeSkillItem"] = { quantityFunc = nil };
};

local l_TOOLTIP_METHOD_WRAPPERS;


do
	if (o.t_GetLocals ~= nil) then
		m_metatable, l_TOOLTIP_METHOD_WRAPPERS, l_SetWrapperUpvalueFunc = o.t_GetLocals();
	else
		m_metatable = (o.INSTANCE_METATABLE or {});
		o.INSTANCE_METATABLE = nil;
		l_TOOLTIP_METHOD_WRAPPERS = o.TOOLTIP_METHOD_WRAPPERS;
		o.TOOLTIP_METHOD_WRAPPERS = nil;
		if (l_TOOLTIP_METHOD_WRAPPERS == nil) then
			local wrappers = {};
			local realFunc;
			for methodName in pairs(l_TOOLTIP_QUANTITY_METHODS) do
				wrappers[methodName] = (function(...) return realFunc(methodName, ...); end);
			end
			function l_SetWrapperUpvalueFunc(newFunc)
				realFunc = newFunc;
			end
			l_TOOLTIP_METHOD_WRAPPERS = wrappers;
		else
			if (o.SetWrapperUpvalueFunc ~= nil) then
				l_SetWrapperUpvalueFunc = o.SetWrapperUpvalueFunc;
				o.SetWrapperUpvalueFunc = nil;
			end
		end
	end
	m_metatable.__index = m;
end




function l_t_GetLocals()
	l_t_GetLocals = nil;
	o.t_GetLocals = nil;
	
	return m_metatable, l_TOOLTIP_METHOD_WRAPPERS, l_SetWrapperUpvalueFunc;
end

o.t_GetLocals = l_t_GetLocals;




function l_RegisterTooltip(tooltip)
	if (tooltip.TooltipItemQuantities1 ~= nil) then
		return;
	end
	
	local hooks = {};
	for methodName, wrapper in pairs(l_TOOLTIP_METHOD_WRAPPERS) do
		hooks[methodName] = tooltip[methodName];
		tooltip[methodName] = wrapper;
	end
	
	local instance = { hooks = hooks };
	setmetatable(instance, m_metatable);
	tooltip.TooltipItemQuantities1 = instance;
end

o.RegisterTooltip = l_RegisterTooltip;




function m:GetItemQuantity()
	return self.quantity, self.sourceMethod;
end




do
	local select = select;
	
	function l_OnTooltipItemMethodCalled(methodName, tooltip, ...)
		local quantity = nil;
		
		local methodData = l_TOOLTIP_QUANTITY_METHODS[methodName];
		local argsStartIndex = methodData.argsStartIndex;
		local returnIndex = methodData.returnIndex;
		if (argsStartIndex ~= nil) then
			if (returnIndex ~= nil) then
				quantity = select(returnIndex, methodData.quantityFunc(select(argsStartIndex, ...)));
			else
				quantity = methodData.quantityFunc(select(argsStartIndex, ...));
			end
		else
			if (returnIndex ~= nil) then
				quantity = select(returnIndex, methodData.quantityFunc(...));
			else
				quantity = methodData.quantityFunc(...);
			end
		end
		
		local instance = tooltip.TooltipItemQuantities1;
		instance.quantity = (quantity or 0);
		instance.sourceMethod = methodName;
		return instance.hooks[methodName](tooltip, ...);
	end
	
	l_SetWrapperUpvalueFunc(l_OnTooltipItemMethodCalled);
end




do
	local tonumber = tonumber;
	
	function l_GetQuantity_SetHyperlink()
		return (tonumber(this.count) or 1);
	end
	
	l_TOOLTIP_QUANTITY_METHODS.SetHyperlink.quantityFunc = l_GetQuantity_SetHyperlink;
end


do
	local GetInventoryItemCount = GetInventoryItemCount;
	
	function l_GetQuantity_SetInventoryItem(unit, slot)
		local quantity = nil;
		if (slot > 17 and slot < 24) then
			-- This is a bag. GetInventoryItemCount will return the number of slots instead of 1.
			quantity = 1;
		else
			quantity = GetInventoryItemCount(unit, slot);
		end
		return quantity;
	end
	
	l_TOOLTIP_QUANTITY_METHODS.SetInventoryItem.quantityFunc = l_GetQuantity_SetInventoryItem;
end


do
	local mathceil = math.ceil;
	local GetTradeSkillReagentInfo = GetTradeSkillReagentInfo;
	local GetTradeSkillNumMade = GetTradeSkillNumMade;
	
	function l_GetQuantity_SetTradeSkillItem(selectedSkill, id)
		local quantity = nil;
		if (id ~= nil) then
			local _;
			_, _, quantity = GetTradeSkillReagentInfo(selectedSkill, id);
		else
			local minMade, maxMade = GetTradeSkillNumMade(selectedSkill);
			quantity = mathceil(((minMade or 2) + (maxMade or 0)) / 2);
		end
		return quantity;
	end
	
	l_TOOLTIP_QUANTITY_METHODS.SetTradeSkillItem.quantityFunc = l_GetQuantity_SetTradeSkillItem;
end

