local K, _ = select(2, ...):unpack()

local _G = _G
local select = select
local find = string.find
local IsAltKeyDown = IsAltKeyDown
local GetItemInfo = GetItemInfo

-- Alt+Click to buy a stack
hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, ...)
	if IsAltKeyDown() then
		local itemLink = GetMerchantItemLink(self:GetID())
		if not itemLink then return end

		local maxStack = select(8, GetItemInfo(itemLink))
		if maxStack and maxStack > 1 then
			local numAvailable = select(5, GetMerchantItemInfo(self:GetID()))
			if numAvailable > -1 then
				BuyMerchantItem(self:GetID(), numAvailable)
			else
				BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
			end
		end
	end
end)