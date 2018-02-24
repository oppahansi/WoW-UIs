

local didLoad, o = LoadLibrary1("CommonParsingTooltip", 110, [[return (function(name) return CreateFrame("GameTooltip", name, nil, nil); end)]], nil);



if (didLoad == true) then
	local tooltip = o;
	
	
	-- When a tooltip is set to an item that isn't cached, it will lose its owner. To counter this, the owner must be re-evaluated prior to all "Set" methods.
	local UIParent = UIParent;
	for index, method in ipairs(
	  {
		"SetBagItem",					"SetAction",					"SetAuctionItem",			"SetAuctionSellItem",
		"SetBuybackItem",			"SetCraftItem",			"SetCraftSpell",				"SetGuildBankItem",
		"SetHyperlink",				"SetInboxItem",			"SetInventoryItem",		"SetLootItem",
		"SetLootRollItem",			"SetMerchantItem",		"SetPetAction",				"SetPlayerBuff",
		"SetQuestItem",				"SetQuestLogItem",	"SetQuestRewardSpell",	"SetSendMailItem",
		"SetShapeshift",				"SetSpell",					"SetTalent",						"SetTrackingSpell",
		"SetTradePlayerItem",		"SetTradeSkillItem",	"SetTradeTargetItem",	"SetTrainerService",
		"SetUnit",						"SetUnitBuff",				"SetUnitDebuff"
	  }
	) do
		local originalFunc = tooltip[method];
		tooltip[method] = function(self, ...)
			if (self:IsOwned(UIParent) == nil) then
				self:SetOwner(UIParent, "ANCHOR_NONE");
			end
			self.currentMoneyValue = nil;
			return originalFunc(self, ...);
		end
	end
	tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	
	
	tooltip:SetScript("OnTooltipAddMoney", (function(self, money) self.currentMoneyValue = money; end));
	
	
	local leftLines, rightLines = (tooltip.leftLines or {}), (tooltip.rightLines or {});
	tooltip.leftLines, tooltip.rightLines = leftLines, rightLines;
	
	local type = type;
	local rawget = rawget;
	local _G = _G;
	
	local metatable = {
		__index = function(self, key)
			if (type(key) == "number") then
				local line = _G["CommonParsingTooltip1Text" .. ((self == leftLines and "Left") or "Right") .. key];
				if (line ~= nil) then
					self[key] = line;
				end
				return line;
			else
				return rawget(self, key);
			end
		end
	};
	setmetatable(leftLines, metatable);
	setmetatable(rightLines, metatable);
	
	if (CommonParsingTooltip1TextLeft1 == nil) then
		-- The GameTooltip object seems to expect the first 8 lines to already be there, like with GameTooltipTemplate.
		for index = 1, 8 do
			tooltip:AddFontStrings(
			  tooltip:CreateFontString("CommonParsingTooltip1TextLeft" .. index),
			  tooltip:CreateFontString("CommonParsingTooltip1TextRight" .. index)
			);
		end
	end
end


o.SHOULD_LOAD = nil;

