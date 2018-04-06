local K, C, L, _ = select(2, ...):unpack()
if C.Loot.AutoGreed ~= true or K.Level ~= MAX_PLAYER_LEVEL then return end

local pairs = pairs
local CreateFrame = CreateFrame
local GetItemInfo = GetItemInfo
local GetLootRollItemInfo = GetLootRollItemInfo

--	Auto greed & disenchant on green items(by Tekkub) and NeedTheOrb(by Myrilandell of Lothar)
local frame = CreateFrame("Frame")
frame:RegisterEvent("START_LOOT_ROLL")
frame:SetScript("OnEvent", function(self, event, id)
	local _, name, _, quality, BoP = GetLootRollItemInfo(id)
	if id and quality == 2 and not BoP then
		for i in pairs(K.NeedLoot) do
			local itemName = GetItemInfo(K.NeedLoot[i])
			if name == itemName and RollOnLoot(id, 1) then
				RollOnLoot(id, 1)
				return
			end
		end
		if RollOnLoot(id, 3) then
			RollOnLoot(id, 3)
		else
			RollOnLoot(id, 2)
		end
	end
end)