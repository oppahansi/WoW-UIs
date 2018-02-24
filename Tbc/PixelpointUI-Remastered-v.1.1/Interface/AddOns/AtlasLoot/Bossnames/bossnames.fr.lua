--[[
bossnames.fr.lua -- update 6 September 2007 (KKram & Trs)
This file gives the localised names of bosses needed in loot descriptions,
especially on tables from many locations where we need to indicate where the
loot came from.
]]

if (GetLocale() == "frFR") then

local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();

	AtlasLootBossNames["AuchShadowLabyrinth"] = {
		"Coeur-noir".." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Grandmaster Vorpil"].." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")";
	};
end