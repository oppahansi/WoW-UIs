if (GetLocale() == "koKR") then
-- Translated by acemage
-- Last Updated: 6/28/2007
-- missing some of black temple boss names.

local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();

	AtlasLootBossNames["AuchShadowLabyrinth"] = {
		" ".." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Grandmaster Vorpil"].." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")";
	};
end
