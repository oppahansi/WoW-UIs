--[[
bossnames.en.lua
This file gives the localised names of bosses needed in loot descriptions,
especially on tables from many locations where we need to indicate where the
loot came from.
]]
if (GetLocale() == 	"zhTW") then
local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

	AtlasLootBossNames["AuchAuchenaiCrypts"] = {
		BabbleBoss["Exarch Maladaar"].." ("..BabbleZone["Auchenai Crypts"]..")";
		AL["Avatar of the Martyred"].." ("..BabbleZone["Auchenai Crypts"]..")";
	};

	AtlasLootBossNames["AuchShadowLabyrinth"] = {
		BabbleBoss["Blackheart the Inciter"].." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Grandmaster Vorpil"].." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")";
	};

	AtlasLootBossNames["CFRTheSteamvault"] = {
		BabbleBoss["Hydromancer Thespia"].." ("..BabbleZone["The Steamvault"]..")";
		BabbleBoss["Warlord Kalithresh"].." ("..BabbleZone["The Steamvault"]..")";
	};

	AtlasLootBossNames["HCBloodFurnace"] = {
		BabbleBoss["Keli'dan the Breaker"].." ("..BabbleZone["The Blood Furnace"]..")";
	};

	AtlasLootBossNames["HCShatteredHalls"] = {
		BabbleBoss["Warbringer O'mrogg"].." ("..BabbleZone["The Shattered Halls"]..")";
		BabbleBoss["Warchief Kargath Bladefist"].." ("..BabbleZone["The Shattered Halls"]..")";
	};

	AtlasLootBossNames["TKMechanar"] = {
		BabbleBoss["Pathaleon the Calculator"].." ("..BabbleZone["The Mechanar"]..")";
	};

end
