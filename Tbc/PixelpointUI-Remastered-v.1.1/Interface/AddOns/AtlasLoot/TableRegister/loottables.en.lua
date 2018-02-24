--[[
loottables.en.lua
This file assigns a title to every loot table.  The primary use of this table
is in the search function, as when iterating through the loot tables there is no
inherant title to the loot table, given the origins of the mod as an Atlas plugin.
]]

--Invoke libraries
local BabbleFaction = LibStub("LibBabble-Faction-3.0"):GetLookupTable();
local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleClass = LibStub("LibBabble-Class-3.0"):GetLookupTable();
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

-- Using alchemy skill to get localized rank
local ALCHEMY, APPRENTICE = GetSpellInfo(2259);
local JOURNEYMAN = select(2, GetSpellInfo(3101));
local EXPERT = select(2, GetSpellInfo(3464));
local ARTISAN = select(2, GetSpellInfo(11611));
local MASTER = select(2, GetSpellInfo(28596));
local BLACKSMITHING = GetSpellInfo(2018);
local ARMORSMITH = GetSpellInfo(9788);
local WEAPONSMITH = GetSpellInfo(9787);
local AXESMITH = GetSpellInfo(17041);
local HAMMERSMITH = GetSpellInfo(17040);
local SWORDSMITH = GetSpellInfo(17039);
local ENCHANTING = GetSpellInfo(7411);
local ENGINEERING = GetSpellInfo(4036);
local GNOMISH = GetSpellInfo(20220);
local GOBLIN = GetSpellInfo(20221);
local JEWELCRAFTING = GetSpellInfo(25229);
local LEATHERWORKING = GetSpellInfo(2108);
local DRAGONSCALE = GetSpellInfo(10656);
local ELEMENTAL = GetSpellInfo(10658);
local TRIBAL = GetSpellInfo(10660);
local MINING = GetSpellInfo(2575);
local TAILORING = GetSpellInfo(3908);
local MOONCLOTH = GetSpellInfo(26798);
local SHADOWEAVE = GetSpellInfo(26801);
local SPELLFIRE = GetSpellInfo(26797);
local COOKING = GetSpellInfo(2550);
local FIRSTAID = GetSpellInfo(3273);

--Table of loot titles
AtlasLoot_TableNames = {};

-----------------------
--- WotLK Instances ---
-----------------------

--------------------
--- BC Instances ---
--------------------

  --Keys
	AtlasLoot_TableNames["OldKeys"] = { "Keys", "AtlasLootItems" };
  --Auch: Auchenai Crypts
	AtlasLoot_TableNames["AuchCryptsShirrak"] = { BabbleBoss["Shirrak the Dead Watcher"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchCryptsShirrakHEROIC"] = { BabbleBoss["Shirrak the Dead Watcher"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchCryptsExarch"] = { BabbleBoss["Exarch Maladaar"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchCryptsExarchHEROIC"] = { BabbleBoss["Exarch Maladaar"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchCryptsAvatar"] = { AL["Avatar of the Martyred"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchCryptsTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Auchenai Crypts"]..")", "AtlasLootExpansionItems" };
  --Auch: Mana-Tombs
	AtlasLoot_TableNames["AuchManaPandemonius"] = { BabbleBoss["Pandemonius"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaPandemoniusHEROIC"] = { BabbleBoss["Pandemonius"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaTavarok"] = { BabbleBoss["Tavarok"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaTavarokHEROIC"] = { BabbleBoss["Tavarok"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaNexusPrince"] = { BabbleBoss["Nexus-Prince Shaffar"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaNexusPrinceHEROIC"] = { BabbleBoss["Nexus-Prince Shaffar"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaYor"] = { AL["Yor"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchManaTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Mana-Tombs"]..")", "AtlasLootExpansionItems" };
  --Auch: Sethekk Halls
	AtlasLoot_TableNames["AuchSethekkDarkweaver"] = { BabbleBoss["Darkweaver Syth"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchSethekkDarkweaverHEROIC"] = { BabbleBoss["Darkweaver Syth"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchSethekkTheSagaofTerokk"] = { "The Saga of Terokk", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchSethekkRavenGod"] = { BabbleBoss["Anzu"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchSethekkTalonKing"] = { BabbleBoss["Talon King Ikiss"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchSethekkTalonKingHEROIC"] = { BabbleBoss["Talon King Ikiss"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchSethekkTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Sethekk Halls"]..")", "AtlasLootExpansionItems" };
  --Auch: Shadow Labyrinth
	AtlasLoot_TableNames["AuchShadowHellmaw"] = { BabbleBoss["Ambassador Hellmaw"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowHellmawHEROIC"] = { BabbleBoss["Ambassador Hellmaw"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowBlackheart"] = { BabbleBoss["Blackheart the Inciter"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowBlackheartHEROIC"] = { BabbleBoss["Blackheart the Inciter"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowGrandmaster"] = { BabbleBoss["Grandmaster Vorpil"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowGrandmasterHEROIC"] = { BabbleBoss["Grandmaster Vorpil"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowMurmur"] = { BabbleBoss["Murmur"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowMurmurHEROIC"] = { BabbleBoss["Murmur"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowFirstFragmentGuardian"] = { "First Fragment Guardian", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["AuchShadowTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Shadow Labyrinth"]..")", "AtlasLootExpansionItems" };
  --The Black Temple
	AtlasLoot_TableNames["BTNajentus"] = { BabbleBoss["High Warlord Naj'entus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTSupremus"] = { BabbleBoss["Supremus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTGorefiend"] = { BabbleBoss["Teron Gorefiend"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTBloodboil"] = { BabbleBoss["Gurtogg Bloodboil"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTAkama"] = { BabbleBoss["Shade of Akama"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTEssencofSouls"] = { "Essence of Souls", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTShahraz"] = { BabbleBoss["Mother Shahraz"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTCouncil"] = { BabbleBoss["Illidari Council"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTIllidanStormrage"] = { BabbleBoss["Illidan Stormrage"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Black Temple"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["BTPatterns"] = { "BT Patterns/Plans", "AtlasLootExpansionItems" };
  --CFR: Serpentshrine Cavern
	AtlasLoot_TableNames["CFRSerpentHydross"] = { BabbleBoss["Hydross the Unstable"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSerpentKarathress"] = { BabbleBoss["Fathom-Lord Karathress"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSerpentMorogrim"] = { BabbleBoss["Morogrim Tidewalker"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSerpentLeotheras"] = { BabbleBoss["Leotheras the Blind"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSerpentLurker"] = { BabbleBoss["The Lurker Below"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSerpentVashj"] = { BabbleBoss["Lady Vashj"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSerpentTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Serpentshrine Cavern"]..")", "AtlasLootExpansionItems" };
  --CFR: Slave Pens
	AtlasLoot_TableNames["CFRSlaveMennu"] = { BabbleBoss["Mennu the Betrayer"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSlaveMennuHEROIC"] = { BabbleBoss["Mennu the Betrayer"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSlaveRokmar"] = { BabbleBoss["Rokmar the Crackler"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSlaveRokmarHEROIC"] = { BabbleBoss["Rokmar the Crackler"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSlaveQuagmirran"] = { BabbleBoss["Quagmirran"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSlaveQuagmirranHEROIC"] = { BabbleBoss["Quagmirran"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
  --CFR: The Steamvault
	AtlasLoot_TableNames["CFRSteamThespia"] = { BabbleBoss["Hydromancer Thespia"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamThespiaHEROIC"] = { BabbleBoss["Hydromancer Thespia"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamSecondFragmentGuardian"] = { "Second Fragment Guardian", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamSteamrigger"] = { BabbleBoss["Mekgineer Steamrigger"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamSteamriggerHEROIC"] = { BabbleBoss["Mekgineer Steamrigger"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamWarlord"] = { BabbleBoss["Warlord Kalithresh"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamWarlordHEROIC"] = { BabbleBoss["Warlord Kalithresh"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRSteamTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Steamvault"]..")", "AtlasLootExpansionItems" };
  --CFR: The Underbog
	AtlasLoot_TableNames["CFRUnderHungarfen"] = { BabbleBoss["Hungarfen"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderHungarfenHEROIC"] = { BabbleBoss["Hungarfen"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderGhazan"] = { BabbleBoss["Ghaz'an"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderGhazanHEROIC"] = { BabbleBoss["Ghaz'an"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderSwamplord"] = { BabbleBoss["Swamplord Musel'ek"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderSwamplordHEROIC"] = { BabbleBoss["Swamplord Musel'ek"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderStalker"] = { BabbleBoss["The Black Stalker"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CFRUnderStalkerHEROIC"] = { BabbleBoss["The Black Stalker"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
  --CoT: Old Hillsbrad Foothills
	AtlasLoot_TableNames["CoTHillsbradDrake"] = { BabbleBoss["Lieutenant Drake"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradDrakeHEROIC"] = { BabbleBoss["Lieutenant Drake"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradSkarloc"] = { BabbleBoss["Captain Skarloc"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradSkarlocHEROIC"] = { BabbleBoss["Captain Skarloc"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradHunter"] = { BabbleBoss["Epoch Hunter"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradHunterHEROIC"] = { BabbleBoss["Epoch Hunter"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Old Hillsbrad Foothills"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradThomasYance"] = { AL["Thomas Yance"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradAgedDalaranWizard"] = { "Aged Dalaran Wizard", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradDonCarlos"] = { AL["Don Carlos"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTHillsbradDonCarlosHEROIC"] = { AL["Don Carlos"], "AtlasLootExpansionItems" };
  --CoT: Black Morass
	AtlasLoot_TableNames["CoTMorassDeja"] = { BabbleBoss["Chrono Lord Deja"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTMorassDejaHEROIC"] = { BabbleBoss["Chrono Lord Deja"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTMorassTemporus"] = { BabbleBoss["Temporus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTMorassTemporusHEROIC"] = { BabbleBoss["Temporus"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTMorassAeonus"] = { BabbleBoss["Aeonus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTMorassAeonusHEROIC"] = { BabbleBoss["Aeonus"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["CoTMorassTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Black Morass"]..")", "AtlasLootExpansionItems" };
  --CoT: Hyjal Summit
	AtlasLoot_TableNames["MountHyjalWinterchill"] = { BabbleBoss["Rage Winterchill"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["MountHyjalAnetheron"] = { BabbleBoss["Anetheron"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["MountHyjalKazrogal"] = { BabbleBoss["Kaz'rogal"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["MountHyjalAzgalor"] = { BabbleBoss["Azgalor"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["MountHyjalArchimonde"] = { BabbleBoss["Archimonde"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["MountHyjalTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Hyjal Summit"]..")", "AtlasLootExpansionItems" };
  --Gruul's Lair
	AtlasLoot_TableNames["GruulsLairHighKingMaulgar"] = { BabbleBoss["High King Maulgar"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["GruulGruul"] = { BabbleBoss["Gruul the Dragonkiller"], "AtlasLootExpansionItems" };
  --HC: Blood Furnace
	AtlasLoot_TableNames["HCFurnaceMaker"] = { BabbleBoss["The Maker"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCFurnaceMakerHEROIC"] = { BabbleBoss["The Maker"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCFurnaceBroggok"] = { BabbleBoss["Broggok"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCFurnaceBroggokHEROIC"] = { BabbleBoss["Broggok"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCFurnaceBreaker"] = { BabbleBoss["Keli'dan the Breaker"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCFurnaceBreakerHEROIC"] = { BabbleBoss["Keli'dan the Breaker"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
  --HC: Magtheridon's Lair
	AtlasLoot_TableNames["HCMagtheridon"] = { BabbleBoss["Magtheridon"], "AtlasLootExpansionItems" };
  --HC: Ramparts
	AtlasLoot_TableNames["HCRampWatchkeeper"] = { BabbleBoss["Watchkeeper Gargolmar"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampWatchkeeperHEROIC"] = { BabbleBoss["Watchkeeper Gargolmar"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampOmor"] = { BabbleBoss["Omor the Unscarred"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampOmorHEROIC"] = { BabbleBoss["Omor the Unscarred"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampVazruden"] = { BabbleBoss["Vazruden"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampNazan"] = { BabbleBoss["Nazan"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampFelIronChest"] = { AL["Reinforced Fel Iron Chest"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCRampFelIronChestHEROIC"] = { AL["Reinforced Fel Iron Chest"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
  --HC: Shattered Halls
	AtlasLoot_TableNames["HCHallsNethekurse"] = { BabbleBoss["Grand Warlock Nethekurse"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsNethekurseHEROIC"] = { BabbleBoss["Grand Warlock Nethekurse"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsPorung"] = { BabbleBoss["Blood Guard Porung"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsOmrogg"] = { BabbleBoss["Warbringer O'mrogg"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsOmroggHEROIC"] = { BabbleBoss["Warbringer O'mrogg"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsKargath"] = { BabbleBoss["Warchief Kargath Bladefist"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsKargathHEROIC"] = { BabbleBoss["Warchief Kargath Bladefist"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsExecutioner"] = { "Shattered Hand Executioner", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["HCHallsTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Shattered Halls"]..")", "AtlasLootExpansionItems" };
  --Karazhan
	AtlasLoot_TableNames["KaraCharredBoneFragment"] = { "Charred Bone Fragment ("..AL["Quest Item"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraNamed"] = { "Servant's Quarter Animal Bosses", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraAttumen"] = { BabbleBoss["Attumen the Huntsman"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraMoroes"] = { BabbleBoss["Moroes"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraKeannaLog"] = { "Keanna's Log ("..AL["Quest Item"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraMaiden"] = { BabbleBoss["Maiden of Virtue"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraOperaEvent"] = { "Opera Event", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraCurator"] = { BabbleBoss["The Curator"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraIllhoof"] = { BabbleBoss["Terestian Illhoof"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraAran"] = { BabbleBoss["Shade of Aran"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraNetherspite"] = { BabbleBoss["Netherspite"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraNightbane"] = { BabbleBoss["Nightbane"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraChess"] = { BabbleBoss["Chess Event"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraPrince"] = { BabbleBoss["Prince Malchezaar"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["KaraTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Karazhan"]..")", "AtlasLootExpansionItems" };
  --Sunwell Isle: Magister's Terrace
	AtlasLoot_TableNames["SMTFireheart"] = { BabbleBoss["Selin Fireheart"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTFireheartHEROIC"] = { BabbleBoss["Selin Fireheart"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTVexallus"] = { BabbleBoss["Vexallus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTVexallusHEROIC"] = { BabbleBoss["Vexallus"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTDelrissa"] = { BabbleBoss["Priestess Delrissa"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTDelrissaHEROIC"] = { BabbleBoss["Priestess Delrissa"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTKaelthas"] = { BabbleBoss["Kael'thas Sunstrider"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTKaelthasHEROIC"] = { BabbleBoss["Kael'thas Sunstrider"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SMTTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Magisters' Terrace"]..")", "AtlasLootExpansionItems" };
  --Sunwell Plateau
	AtlasLoot_TableNames["SPKalecgos"] = { BabbleBoss["Kalecgos"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPBrutallus"] = { BabbleBoss["Brutallus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPFelmyst"] = { BabbleBoss["Felmyst"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPEredarTwins"] = { BabbleBoss["The Eredar Twins"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPMuru"] = { BabbleBoss["M'uru"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPKiljaeden"] = { BabbleBoss["Kil'jaeden"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Sunwell Plateau"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["SPPatterns"] = { "SP Patterns/Plans", "AtlasLootExpansionItems" };
  --TK: The Arcatraz
	AtlasLoot_TableNames["TKArcUnbound"] = { BabbleBoss["Zereketh the Unbound"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcUnboundHEROIC"] = { BabbleBoss["Zereketh the Unbound"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcThirdFragmentGuardian"] = { "Third Fragment Guardian", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcDalliah"] = { BabbleBoss["Dalliah the Doomsayer"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcDalliahHEROIC"] = { BabbleBoss["Dalliah the Doomsayer"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcScryer"] = { BabbleBoss["Wrath-Scryer Soccothrates"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcScryerHEROIC"] = { BabbleBoss["Wrath-Scryer Soccothrates"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcHarbinger"] = { BabbleBoss["Harbinger Skyriss"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcHarbingerHEROIC"] = { BabbleBoss["Harbinger Skyriss"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKArcTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Arcatraz"]..")", "AtlasLootExpansionItems" };
  --TK: The Botanica
	AtlasLoot_TableNames["TKBotSarannis"] = { BabbleBoss["Commander Sarannis"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotSarannisHEROIC"] = { BabbleBoss["Commander Sarannis"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotFreywinn"] = { BabbleBoss["High Botanist Freywinn"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotFreywinnHEROIC"] = { BabbleBoss["High Botanist Freywinn"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotThorngrin"] = { BabbleBoss["Thorngrin the Tender"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotThorngrinHEROIC"] = { BabbleBoss["Thorngrin the Tender"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotLaj"] = { BabbleBoss["Laj"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotLajHEROIC"] = { BabbleBoss["Laj"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotSplinter"] = { BabbleBoss["Warp Splinter"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotSplinterHEROIC"] = { BabbleBoss["Warp Splinter"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKBotTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Botanica"]..")", "AtlasLootExpansionItems" };
  --TK: The Eye
	AtlasLoot_TableNames["TKEyeAlar"] = { BabbleBoss["Al'ar"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKEyeVoidReaver"] = { BabbleBoss["Void Reaver"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKEyeSolarian"] = { BabbleBoss["High Astromancer Solarian"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKEyeKaelthas"] = { BabbleBoss["Kael'thas Sunstrider"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKEyeLegendaries"] = { "Legendary Items for Kael'thas Fight", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKEyeTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Eye"]..")", "AtlasLootExpansionItems" };
  --TK: The Mechanar
	AtlasLoot_TableNames["TKMechGyro"] = { BabbleBoss["Gatewatcher Gyro-Kill"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechIron"] = { BabbleBoss["Gatewatcher Iron-Hand"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechCacheoftheLegion"] = { "Cache of the Legion", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechCapacitus"] = { BabbleBoss["Mechano-Lord Capacitus"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechCapacitusHEROIC"] = { BabbleBoss["Mechano-Lord Capacitus"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechOverchargedManacell"] = { "Overcharged Manacell", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechSepethrea"] = { BabbleBoss["Nethermancer Sepethrea"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechSepethreaHEROIC"] = { BabbleBoss["Nethermancer Sepethrea"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechCalc"] = { BabbleBoss["Pathaleon the Calculator"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechCalcHEROIC"] = { BabbleBoss["Pathaleon the Calculator"].." ("..AL["Heroic"]..")", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["TKMechTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Mechanar"]..")", "AtlasLootExpansionItems" };
  --Zul'Aman
	AtlasLoot_TableNames["ZANalorakk"] = { BabbleBoss["Nalorakk"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZAAkilZon"] = { BabbleBoss["Akil'zon"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZAJanAlai"] = { BabbleBoss["Jan'alai"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZAHalazzi"] = { BabbleBoss["Halazzi"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZAMalacrass"] = { BabbleBoss["Hex Lord Malacrass"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZAZuljin"] = { BabbleBoss["Zul'jin"], "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZATimedChest"] = { "Timed Reward Chest", "AtlasLootExpansionItems" };
	AtlasLoot_TableNames["ZATrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Aman"]..")", "AtlasLootExpansionItems" };

-------------------------
--- Classic Instances ---
-------------------------

  --Keys
	AtlasLoot_TableNames["BCKeys"] = { "Keys", "AtlasLootExpansionItems" };
  --Blackfathom Deeps
	AtlasLoot_TableNames["BFDGhamoora"] = { BabbleBoss["Ghamoo-ra"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDLadySarevess"] = { BabbleBoss["Lady Sarevess"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDGelihast"] = { BabbleBoss["Gelihast"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDBaronAquanis"] = { BabbleBoss["Baron Aquanis"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDTwilightLordKelris"] = { BabbleBoss["Twilight Lord Kelris"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDOldSerrakis"] = { BabbleBoss["Old Serra'kis"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDAkumai"] = { BabbleBoss["Aku'mai"], "AtlasLootItems" };
	AtlasLoot_TableNames["BFDQuestItems"] = { AL["Quest Item"].." ("..BabbleZone["Blackfathom Deeps"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["BFDTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Blackfathom Deeps"]..")", "AtlasLootItems" };
  --Blackrock Mountain
	AtlasLoot_TableNames["BRMScarshieldQuartermaster"] = { AL["Scarshield Quartermaster"], "AtlasLootItems" };
  --Blackrock Depths
	AtlasLoot_TableNames["BRDPyron"] = { AL["Overmaster Pyron"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDLordRoccor"] = { BabbleBoss["Lord Roccor"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDHighInterrogatorGerstahn"] = { BabbleBoss["High Interrogator Gerstahn"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDArena"] = { "Ring of Law", "AtlasLootItems" };
	AtlasLoot_TableNames["BRDTheldren"] = { AL["Theldren"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDHoundmaster"] = { BabbleBoss["Houndmaster Grebmar"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDForgewright"] = { "Monument of Franclorn Forgewright", "AtlasLootItems" };
	AtlasLoot_TableNames["BRDPyromantLoregrain"] = { BabbleBoss["Pyromancer Loregrain"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDTheVault"] = { AL["The Vault"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDWarderStilgiss"] = { BabbleBoss["Warder Stilgiss"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDVerek"] = { BabbleBoss["Verek"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDFineousDarkvire"] = { BabbleBoss["Fineous Darkvire"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDLordIncendius"] = { BabbleBoss["Lord Incendius"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDBaelGar"] = { BabbleBoss["Bael'Gar"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDGeneralAngerforge"] = { BabbleBoss["General Angerforge"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDGolemLordArgelmach"] = { BabbleBoss["Golem Lord Argelmach"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDGuzzler"] = { "The Grim Guzzler", "AtlasLootItems" };
	AtlasLoot_TableNames["BRDFlamelash"] = { BabbleBoss["Ambassador Flamelash"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDPanzor"] = { BabbleBoss["Panzor the Invincible"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["BRDTomb"] = { "Summoner's Tomb", "AtlasLootItems" };
	AtlasLoot_TableNames["BRDLyceum"] = { AL["Shadowforge Flame Keeper"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDMagmus"] = { BabbleBoss["Magmus"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDPrincess"] = { BabbleBoss["Princess Moira Bronzebeard"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDImperatorDagranThaurissan"] = { BabbleBoss["Emperor Dagran Thaurissan"], "AtlasLootItems" };
	AtlasLoot_TableNames["BRDBSPlans"] = { "Blacksmith Plans".." ("..BabbleZone["Blackrock Depths"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["BRDTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Blackrock Depths"]..")", "AtlasLootItems" };
  --Lower Blackrock Spire
	AtlasLoot_TableNames["LBRSQuestItems"] = { BabbleZone["Lower Blackrock Spire"].." - "..AL["Quest Item"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSSpirestoneButcher"] = { BabbleBoss["Spirestone Butcher"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSOmokk"] = { BabbleBoss["Highlord Omokk"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSSpirestoneLord"] = { BabbleBoss["Spirestone Battle Lord"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSLordMagus"] = { BabbleBoss["Spirestone Lord Magus"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSVosh"] = { BabbleBoss["Shadow Hunter Vosh'gajin"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSVoone"] = { BabbleBoss["War Master Voone"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSGrayhoof"] = { BabbleBoss["Mor Grayhoof"].." ("..AL["Summon"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSGrimaxe"] = { BabbleBoss["Bannok Grimaxe"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSSmolderweb"] = { BabbleBoss["Mother Smolderweb"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSCrystalFang"] = { BabbleBoss["Crystal Fang"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSDoomhowl"] = { BabbleBoss["Urok Doomhowl"].." ("..AL["Summon"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSZigris"] = { BabbleBoss["Quartermaster Zigris"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSHalycon"] = { BabbleBoss["Halycon"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSSlavener"] = { BabbleBoss["Gizrul the Slavener"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSBashguud"] = { BabbleBoss["Ghok Bashguud"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSWyrmthalak"] = { BabbleBoss["Overlord Wyrmthalak"], "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSFelguard"] = { BabbleBoss["Burning Felguard"].." ("..AL["Rare"]..", "..AL["Random"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["LBRSTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Lower Blackrock Spire"]..")", "AtlasLootItems" };
  --Upper Blackrock Spire
	AtlasLoot_TableNames["UBRSEmberseer"] = { BabbleBoss["Pyroguard Emberseer"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSSolakar"] = { BabbleBoss["Solakar Flamewreath"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSFLAME"] = { AL["Father Flame"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSQuestItems"] = { AL["Quest Item"].." ("..BabbleZone["Upper Blackrock Spire"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSRunewatcher"] = { BabbleBoss["Jed Runewatcher"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSAnvilcrack"] = { BabbleBoss["Goraluk Anvilcrack"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSRend"] = { BabbleBoss["Warchief Rend Blackhand"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSGyth"] = { BabbleBoss["Gyth"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSBeast"] = { BabbleBoss["The Beast"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSValthalak"] = { BabbleBoss["Lord Valthalak"].." ("..AL["Summon"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSDrakkisath"] = { BabbleBoss["General Drakkisath"], "AtlasLootItems" };
	AtlasLoot_TableNames["UBRSTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Upper Blackrock Spire"]..")", "AtlasLootItems" };
  --Blackwing Lair
	AtlasLoot_TableNames["BWLRazorgore"] = { BabbleBoss["Razorgore the Untamed"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLVaelastrasz"] = { BabbleBoss["Vaelastrasz the Corrupt"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLLashlayer"] = { BabbleBoss["Broodlord Lashlayer"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLFiremaw"] = { BabbleBoss["Firemaw"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLDraconicForDummies"] = { "Draconic for Dummies Chapter VII", "AtlasLootItems" };
	AtlasLoot_TableNames["BWLEbonroc"] = { BabbleBoss["Ebonroc"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLFlamegor"] = { BabbleBoss["Flamegor"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLChromaggus"] = { BabbleBoss["Chromaggus"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLNefarian"] = { BabbleBoss["Nefarian"], "AtlasLootItems" };
	AtlasLoot_TableNames["BWLTrashMobs"] = { AL["Trash Mobs"].." ("..BabbleZone["Blackwing Lair"]..")", "AtlasLootItems" };
  --The Deadmines
	AtlasLoot_TableNames["TheDeadminesEntrance"] = { BabbleZone["The Deadmines"], "AtlasLootItems" };
	AtlasLoot_TableNames["TheDeadmines1"] = { BabbleZone["The Deadmines"], "AtlasLootItems" };
	AtlasLoot_TableNames["TheDeadmines2"] = { BabbleZone["The Deadmines"], "AtlasLootItems" };
  --Dire Maul East
	AtlasLoot_TableNames["DMEPusillin"] = { BabbleBoss["Pusillin"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMEZevrimThornhoof"] = { BabbleBoss["Zevrim Thornhoof"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMEHydro"] = { BabbleBoss["Hydrospawn"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMELethtendris"] = { BabbleBoss["Lethtendris"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMEPimgib"] = { BabbleBoss["Pimgib"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMEAlzzin"] = { BabbleBoss["Alzzin the Wildshaper"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMEIsalien"] = { BabbleBoss["Isalien"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMETrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Dire Maul (East)"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["DMBooks"] = { "Dire Maul Books", "AtlasLootItems" };
  --Dire Maul North
	AtlasLoot_TableNames["DMNGuardMoldar"] = { BabbleBoss["Guard Mol'dar"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNStomperKreeg"] = { BabbleBoss["Stomper Kreeg"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNGuardFengus"] = { BabbleBoss["Guard Fengus"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNThimblejack"] = { AL["Knot Thimblejack"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNGuardSlipkik"] = { BabbleBoss["Guard Slip'kik"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNCaptainKromcrush"] = { BabbleBoss["Captain Kromcrush"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNChoRush"] = { BabbleBoss["Cho'Rush the Observer"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNKingGordok"] = { BabbleBoss["King Gordok"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMNTRIBUTERUN"] = { AL["DM North Tribute Chest"], "AtlasLootItems" };
  --Dire Maul West
	AtlasLoot_TableNames["DMWTendrisWarpwood"] = { BabbleBoss["Tendris Warpwood"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWIllyannaRavenoak"] = { BabbleBoss["Illyanna Ravenoak"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWMagisterKalendris"] = { BabbleBoss["Magister Kalendris"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWTsuzee"] = { BabbleBoss["Tsu'zee"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWImmolthar"] = { BabbleBoss["Immol'thar"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWHelnurath"] = { BabbleBoss["Lord Hel'nurath"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWPrinceTortheldrin"] = { BabbleBoss["Prince Tortheldrin"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWShendralarProvisioner"] = { AL["Shen'dralar Provisioner"], "AtlasLootItems" };
	AtlasLoot_TableNames["DMWTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Dire Maul (West)"]..")", "AtlasLootItems" };
  --Gnomeregan
	AtlasLoot_TableNames["GnNamdoBizzfizzle"] = { AL["Namdo Bizzfizzle"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnTechbot"] = { BabbleBoss["Techbot"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnGrubbis"] = { BabbleBoss["Grubbis"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnViscousFallout"] = { BabbleBoss["Viscous Fallout"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnElectrocutioner6000"] = { BabbleBoss["Electrocutioner 6000"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnCrowdPummeler960"] = { BabbleBoss["Crowd Pummeler 9-60"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnDIAmbassador"] = { BabbleBoss["Dark Iron Ambassador"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["GnMekgineerThermaplugg"] = { BabbleBoss["Mekgineer Thermaplugg"], "AtlasLootItems" };
	AtlasLoot_TableNames["GnTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Gnomeregan"]..")", "AtlasLootItems" };
  --Maraudon
	AtlasLoot_TableNames["MaraNamelesProphet"] = { AL["The Nameles Prophet"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraKhanKolk"] = { BabbleBoss["Kolk"].." (The First Khan)", "AtlasLootItems" };
	AtlasLoot_TableNames["MaraKhanGelk"] = { BabbleBoss["Gelk"].." (The Second Khan)", "AtlasLootItems" };
	AtlasLoot_TableNames["MaraKhanMagra"] = { BabbleBoss["Magra"].." (The Third Khan)", "AtlasLootItems" };
	AtlasLoot_TableNames["MaraKhanVeng"] = { BabbleBoss["Veng"].." (The Fifth Khan)", "AtlasLootItems" };
	AtlasLoot_TableNames["MaraNoxxion"] = { BabbleBoss["Noxxion"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraRazorlash"] = { BabbleBoss["Razorlash"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraKhanMaraudos"] = { BabbleBoss["Maraudos"].." (The Forth Khan)", "AtlasLootItems" };
	AtlasLoot_TableNames["MaraLordVyletongue"] = { BabbleBoss["Lord Vyletongue"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraMeshlok"] = { BabbleBoss["Meshlok the Harvester"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraCelebras"] = { BabbleBoss["Celebras the Cursed"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraLandslide"] = { BabbleBoss["Landslide"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraTinkererGizlock"] = { BabbleBoss["Tinkerer Gizlock"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraRotgrip"] = { BabbleBoss["Rotgrip"], "AtlasLootItems" };
	AtlasLoot_TableNames["MaraPrincessTheradras"] = { BabbleBoss["Princess Theradras"], "AtlasLootItems" };
  --Molten Core
	AtlasLoot_TableNames["MCLucifron"] = { BabbleBoss["Lucifron"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCMagmadar"] = { BabbleBoss["Magmadar"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCGehennas"] = { BabbleBoss["Gehennas"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCGarr"] = { BabbleBoss["Garr"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCShazzrah"] = { BabbleBoss["Shazzrah"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCGeddon"] = { BabbleBoss["Baron Geddon"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCGolemagg"] = { BabbleBoss["Golemagg the Incinerator"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCSulfuron"] = { BabbleBoss["Sulfuron Harbinger"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCMajordomo"] = { BabbleBoss["Majordomo Executus"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCRagnaros"] = { BabbleBoss["Ragnaros"], "AtlasLootItems" };
	AtlasLoot_TableNames["MCRANDOMBOSSDROPPS"] = { "Random Boss Drops", "AtlasLootItems" };
	AtlasLoot_TableNames["MCTrashMobs"] = { AL["Trash Mobs"].." ("..BabbleZone["Molten Core"]..")", "AtlasLootItems" };
  --Naxxramas
	AtlasLoot_TableNames["NAXPatchwerk"] = { BabbleBoss["Patchwerk"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXGrobbulus"] = { BabbleBoss["Grobbulus"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXGluth"] = { BabbleBoss["Gluth"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXThaddius"] = { BabbleBoss["Thaddius"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXAnubRekhan"] = { BabbleBoss["Anub'Rekhan"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXGrandWidowFaerlina"] = { BabbleBoss["Grand Widow Faerlina"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXMaexxna"] = { BabbleBoss["Maexxna"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXInstructorRazuvious"] = { BabbleBoss["Instructor Razuvious"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXGothikderHarvester"] = { BabbleBoss["Gothik the Harvester"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXTheFourHorsemen"] = { BabbleBoss["The Four Horsemen"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXNothderPlaguebringer"] = { BabbleBoss["Noth the Plaguebringer"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXHeiganderUnclean"] = { BabbleBoss["Heigan the Unclean"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXLoatheb"] = { BabbleBoss["Loatheb"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXSapphiron"] = { BabbleBoss["Sapphiron"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXKelThuzard"] = { BabbleBoss["Kel'Thuzad"], "AtlasLootItems" };
	AtlasLoot_TableNames["NAXTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Naxxramas"]..")", "AtlasLootItems" };
  --Onyxia's Lair
	AtlasLoot_TableNames["Onyxia"] = { BabbleBoss["Onyxia"], "AtlasLootItems" };
  --Ragefire Chasm
	AtlasLoot_TableNames["RagefireChasm"] = { BabbleZone["Ragefire Chasm"], "AtlasLootItems" };
  --Razorfen Downs
	AtlasLoot_TableNames["RFDTutenkash"] = { BabbleBoss["Tuten'kash"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDHenryStern"] = { AL["Henry Stern"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDMordreshFireEye"] = { BabbleBoss["Mordresh Fire Eye"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDGlutton"] = { BabbleBoss["Glutton"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDRagglesnout"] = { BabbleBoss["Ragglesnout"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDAmnennar"] = { BabbleBoss["Amnennar the Coldbringer"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDPlaguemaw"] = { BabbleBoss["Plaguemaw the Rotting"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFDTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Razorfen Downs"]..")", "AtlasLootItems" };
  --Razorfen Kraul
	AtlasLoot_TableNames["RFKThorncurse"] = { AL["Aggem Thorncurse"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKDeathSpeakerJargba"] = { BabbleBoss["Death Speaker Jargba"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKRazorfenSpearhide"] = { AL["Razorfen Spearhide"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKOverlordRamtusk"] = { BabbleBoss["Overlord Ramtusk"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKAgathelos"] = { BabbleBoss["Agathelos the Raging"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKBlindHunter"] = { BabbleBoss["Blind Hunter"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKCharlgaRazorflank"] = { BabbleBoss["Charlga Razorflank"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKEarthcallerHalmgar"] = { BabbleBoss["Earthcaller Halmgar"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKRoogug"] = { AL["Roogug"], "AtlasLootItems" };
	AtlasLoot_TableNames["RFKTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Razorfen Kraul"]..")", "AtlasLootItems" };
  --The Ruins of Ahn'Qiraj
	AtlasLoot_TableNames["AQ20Kurinnaxx"] = { BabbleBoss["Kurinnaxx"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Andorov"] = { BabbleBoss["Lieutenant General Andorov"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20CAPTIAN"] = { "Rajaxx's Captains", "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Rajaxx"] = { BabbleBoss["General Rajaxx"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Moam"] = { BabbleBoss["Moam"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Buru"] = { BabbleBoss["Buru the Gorger"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Ayamiss"] = { BabbleBoss["Ayamiss the Hunter"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Ossirian"] = { BabbleBoss["Ossirian the Unscarred"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20Trash"] = { AL["Trash Mobs"].." (AQ20)", "AtlasLootItems" };
	AtlasLoot_TableNames["AQ20ClassBooks"] = { "AQ Class Books", "AtlasLootItems" };
	AtlasLoot_TableNames["AQEnchants"] = { "AQ Enchants", "AtlasLootItems" };
  --Scarlet Monestery - Armory
	AtlasLoot_TableNames["SMHerod"] = { BabbleBoss["Herod"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Scarlet Monastery"]..")", "AtlasLootItems" };
  --Scarlet Monestery - Cathedral
	AtlasLoot_TableNames["SMFairbanks"] = { BabbleBoss["High Inquisitor Fairbanks"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMMograine"] = { BabbleBoss["Scarlet Commander Mograine"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMWhitemane"] = { BabbleBoss["High Inquisitor Whitemane"], "AtlasLootItems" };
  --Scarlet Monestery - Graveyard
	AtlasLoot_TableNames["SMVishas"] = { BabbleBoss["Interrogator Vishas"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMIronspine"] = { BabbleBoss["Ironspine"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMAzshir"] = { BabbleBoss["Azshir the Sleepless"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMFallenChampion"] = { BabbleBoss["Fallen Champion"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMBloodmageThalnos"] = { BabbleBoss["Bloodmage Thalnos"], "AtlasLootItems" };
  --Scarlet Monestery - Library
	AtlasLoot_TableNames["SMHoundmasterLoksey"] = { BabbleBoss["Houndmaster Loksey"], "AtlasLootItems" };
	AtlasLoot_TableNames["SMDoan"] = { BabbleBoss["Arcanist Doan"], "AtlasLootItems" };
  --Scholomance
	AtlasLoot_TableNames["SCHOLOBloodStewardofKirtonos"] = { BabbleBoss["Blood Steward of Kirtonos"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOKirtonostheHerald"] = { BabbleBoss["Kirtonos the Herald"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOJandiceBarov"] = { BabbleBoss["Jandice Barov"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLORattlegore"] = { BabbleBoss["Rattlegore"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLODeathKnight"] = { BabbleBoss["Death Knight Darkreaver"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOMarduk"] = { BabbleBoss["Marduk Blackpool"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOVectus"] = { BabbleBoss["Vectus"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLORasFrostwhisper"] = { BabbleBoss["Ras Frostwhisper"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOKormok"] = { BabbleBoss["Kormok"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOInstructorMalicia"] = { BabbleBoss["Instructor Malicia"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLODoctorTheolenKrastinov"] = { BabbleBoss["Doctor Theolen Krastinov"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOLorekeeperPolkelt"] = { BabbleBoss["Lorekeeper Polkelt"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOTheRavenian"] = { BabbleBoss["The Ravenian"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOLordAlexeiBarov"] = { BabbleBoss["Lord Alexei Barov"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOLadyIlluciaBarov"] = { BabbleBoss["Lady Illucia Barov"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLODarkmasterGandling"] = { BabbleBoss["Darkmaster Gandling"], "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOQuestItems"] = { AL["Quest Item"].." ("..BabbleZone["Scholomance"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["SCHOLOTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Scholomance"]..")", "AtlasLootItems" };
  --Shadowfang Keep
	AtlasLoot_TableNames["BSFRethilgore"] = { AL["Rethilgore"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFFelSteed"] = { "Felsteed", "AtlasLootItems" };
	AtlasLoot_TableNames["BSFRazorclawtheButcher"] = { BabbleBoss["Razorclaw the Butcher"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFSilverlaine"] = { BabbleBoss["Baron Silverlaine"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFSpringvale"] = { BabbleBoss["Commander Springvale"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFOdotheBlindwatcher"] = { BabbleBoss["Odo the Blindwatcher"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFFenrustheDevourer"] = { BabbleBoss["Fenrus the Devourer"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFArugalsVoidwalker"] = { BabbleBoss["Arugal's Voidwalker"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFWolfMasterNandos"] = { BabbleBoss["Wolf Master Nandos"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFArchmageArugal"] = { BabbleBoss["Archmage Arugal"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFDeathswornCaptain"] = { BabbleBoss["Deathsworn Captain"], "AtlasLootItems" };
	AtlasLoot_TableNames["BSFQuestItems"] = { AL["Quest Item"].." ("..BabbleZone["Shadowfang Keep"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["BSFTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Shadowfang Keep"]..")", "AtlasLootItems" };
  --The Stockade
	AtlasLoot_TableNames["TheStockade"] = { BabbleZone["The Stockade"], "AtlasLootItems" };
  --Stratholme
	AtlasLoot_TableNames["STRATSkull"] = { BabbleBoss["Skul"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATStratholmeCourier"] = { "Mailbox Keys", "AtlasLootItems" };
	AtlasLoot_TableNames["STRATFrasSiabi"] = { BabbleBoss["Fras Siabi"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATAtiesh"] = { "Atiesh <Hand of Sargeras>", "AtlasLootItems" };
	AtlasLoot_TableNames["STRATHearthsingerForresten"] = { BabbleBoss["Hearthsinger Forresten"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATTheUnforgiven"] = { BabbleBoss["The Unforgiven"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATTimmytheCruel"] = { BabbleBoss["Timmy the Cruel"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATMalorsStrongbox"] = { AL["Malor's Strongbox"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATCrimsonHammersmith"] = { BabbleBoss["Crimson Hammersmith"].." ("..AL["Summon"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["STRATBSPlansSerenity"] = { "Plans: Serenity", "AtlasLootItems" };
	AtlasLoot_TableNames["STRATCannonMasterWilley"] = { BabbleBoss["Cannon Master Willey"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATArchivistGalford"] = { BabbleBoss["Archivist Galford"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATBalnazzar"] = { BabbleBoss["Balnazzar"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATSothosJarien"] = { AL["Sothos and Jarien"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATStonespine"] = { BabbleBoss["Stonespine"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATNerubenkan"] = { BabbleBoss["Nerub'enkan"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATBaronessAnastari"] = { BabbleBoss["Baroness Anastari"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATBlackGuardSwordsmith"] = { BabbleBoss["Black Guard Swordsmith"].." ("..AL["Summon"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["STRATBSPlansCorruption"] = { "Plans: Corruption", "AtlasLootItems" };
	AtlasLoot_TableNames["STRATMalekithePallid"] = { BabbleBoss["Maleki the Pallid"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATMagistrateBarthilas"] = { BabbleBoss["Magistrate Barthilas"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATRamsteintheGorger"] = { BabbleBoss["Ramstein the Gorger"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATBaronRivendare"] = { BabbleBoss["Baron Rivendare"], "AtlasLootItems" };
	AtlasLoot_TableNames["STRATTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Stratholme"]..")", "AtlasLootItems" };
  --Sunken Temple
	AtlasLoot_TableNames["STSpawnOfHakkar"] = { "Spawn of Hakkar", "AtlasLootItems" };
	AtlasLoot_TableNames["STTrollMinibosses"] = { "Troll Minibosses", "AtlasLootItems" };
	AtlasLoot_TableNames["STAtalalarion"] = { BabbleBoss["Atal'alarion"], "AtlasLootItems" };
	AtlasLoot_TableNames["STDreamscythe"] = { BabbleBoss["Dreamscythe"], "AtlasLootItems" };
	AtlasLoot_TableNames["STWeaver"] = { BabbleBoss["Weaver"], "AtlasLootItems" };
	AtlasLoot_TableNames["STAvatarofHakkar"] = { BabbleBoss["Avatar of Hakkar"], "AtlasLootItems" };
	AtlasLoot_TableNames["STJammalan"] = { BabbleBoss["Jammal'an the Prophet"], "AtlasLootItems" };
	AtlasLoot_TableNames["STOgom"] = { BabbleBoss["Ogom the Wretched"], "AtlasLootItems" };
	AtlasLoot_TableNames["STMorphaz"] = { BabbleBoss["Morphaz"], "AtlasLootItems" };
	AtlasLoot_TableNames["STHazzas"] = { BabbleBoss["Hazzas"], "AtlasLootItems" };
	AtlasLoot_TableNames["STEranikus"] = { BabbleBoss["Shade of Eranikus"], "AtlasLootItems" };
	AtlasLoot_TableNames["STTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Temple of Atal'Hakkar"]..")", "AtlasLootItems" };
  --Temple of Ahn'Qiraj
	AtlasLoot_TableNames["AQ40Skeram"] = { BabbleBoss["The Prophet Skeram"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Vem"] = { BabbleBoss["The Bug Family"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Sartura"] = { BabbleBoss["Battleguard Sartura"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Fankriss"] = { BabbleBoss["Fankriss the Unyielding"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Viscidus"] = { BabbleBoss["Viscidus"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Huhuran"] = { BabbleBoss["Princess Huhuran"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Emperors"] = { BabbleBoss["The Twin Emperors"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Ouro"] = { BabbleBoss["Ouro"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40CThun"] = { BabbleBoss["C'Thun"], "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Trash1"] = { AL["Trash Mobs"].." (AQ40)", "AtlasLootItems" };
	AtlasLoot_TableNames["AQ40Trash2"] = { AL["Trash Mobs"].." (AQ40)", "AtlasLootItems" };
	AtlasLoot_TableNames["AQOpening"] = { "AQ Opening Quest Line", "AtlasLootItems" };
  --Uldaman
	AtlasLoot_TableNames["UldMagreganDeepshadow"] = { AL["Magregan Deepshadow"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldTabletofRyuneh"] = { "Tablet of Ryun'eh", "AtlasLootItems" };
	AtlasLoot_TableNames["UldKromStoutarmChest"] = { AL["Krom Stoutarm's Chest"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldGarrettFamilyChest"] = { AL["Garrett Family Chest"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldShovelphlange"] = { BabbleBoss["Digmaster Shovelphlange"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldRevelosh"] = { BabbleBoss["Revelosh"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldBaelog"] = { BabbleBoss["Baelog"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldIronaya"] = { BabbleBoss["Ironaya"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldObsidianSentinel"] = { BabbleBoss["Obsidian Sentinel"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldAncientStoneKeeper"] = { BabbleBoss["Ancient Stone Keeper"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldGalgannFirehammer"] = { BabbleBoss["Galgann Firehammer"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldTabletofWill"] = { "Tablet of Will", "AtlasLootItems" };
	AtlasLoot_TableNames["UldShadowforgeCache"] = { "Shadowforge Cache", "AtlasLootItems" };
	AtlasLoot_TableNames["UldGrimlok"] = { BabbleBoss["Grimlok"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldArchaedas"] = { BabbleBoss["Archaedas"], "AtlasLootItems" };
	AtlasLoot_TableNames["UldTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Uldaman"]..")", "AtlasLootItems" };
  --Wailing Caverns
	AtlasLoot_TableNames["WCKalldanFelmoon"] = { AL["Kalldan Felmoon"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCMadMagglish"] = { BabbleBoss["Mad Magglish"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCTrigoretheLasher"] = { BabbleBoss["Trigore the Lasher"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["WCBoahn"] = { BabbleBoss["Boahn"].." ("..AL["Rare"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["WCLordCobrahn"] = { BabbleBoss["Lord Cobrahn"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCLadyAnacondra"] = { BabbleBoss["Lady Anacondra"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCKresh"] = { BabbleBoss["Kresh"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCLordPythas"] = { BabbleBoss["Lord Pythas"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCSkum"] = { BabbleBoss["Skum"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCLordSerpentis"] = { BabbleBoss["Lord Serpentis"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCVerdan"] = { BabbleBoss["Verdan the Everliving"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCMutanus"] = { BabbleBoss["Mutanus the Devourer"], "AtlasLootItems" };
	AtlasLoot_TableNames["WCDeviateFaerieDragon"] = { BabbleBoss["Deviate Faerie Dragon"], "AtlasLootItems" };
  --Zul'Farrak
	AtlasLoot_TableNames["ZFAntusul"] = { BabbleBoss["Antu'sul"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFThekatheMartyr"] = { BabbleBoss["Theka the Martyr"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFWitchDoctorZumrah"] = { BabbleBoss["Witch Doctor Zum'rah"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFNekrumGutchewer"] = { BabbleBoss["Nekrum Gutchewer"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFSezzziz"] = { BabbleBoss["Shadowpriest Sezz'ziz"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFDustwraith"] = { BabbleBoss["Dustwraith"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFSergeantBly"] = { BabbleBoss["Sergeant Bly"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFSandfury"] = { BabbleBoss["Sandfury Executioner"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFHydromancerVelratha"] = { BabbleBoss["Hydromancer Velratha"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFGahzrilla"] = { BabbleBoss["Gahz'rilla"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFChiefUkorzSandscalp"] = { BabbleBoss["Chief Ukorz Sandscalp"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFZerillis"] = { BabbleBoss["Zerillis"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZFTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Farrak"]..")", "AtlasLootItems" };
  --Zul'Gurub
	AtlasLoot_TableNames["ZGJeklik"] = { BabbleBoss["High Priestess Jeklik"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGVenoxis"] = { BabbleBoss["High Priest Venoxis"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGMarli"] = { BabbleBoss["High Priestess Mar'li"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGMandokir"] = { BabbleBoss["Bloodlord Mandokir"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGGrilek"] = { BabbleBoss["Gri'lek"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGHazzarah"] = { BabbleBoss["Hazza'rah"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGRenataki"] = { BabbleBoss["Renataki"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGWushoolay"] = { BabbleBoss["Wushoolay"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGGahzranka"] = { BabbleBoss["Gahz'ranka"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGThekal"] = { BabbleBoss["High Priest Thekal"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGArlokk"] = { BabbleBoss["High Priestess Arlokk"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGJindo"] = { BabbleBoss["Jin'do the Hexxer"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGHakkar"] = { BabbleBoss["Hakkar"], "AtlasLootItems" };
	AtlasLoot_TableNames["ZGMuddyChurningWaters"] = { "Muddy Churning Waters", "AtlasLootItems" };
	AtlasLoot_TableNames["ZGShared"] = { "Shared ZG Priest Drops", "AtlasLootItems" };
	AtlasLoot_TableNames["ZGTrash1"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Gurub"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["ZGTrash2"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Gurub"]..")", "AtlasLootItems" };
	AtlasLoot_TableNames["ZGEnchants"] = { "ZG Enchants", "AtlasLootItems" };

------------
--- Sets ---
------------

  --Arena PvP Sets, Season 1
	AtlasLoot_TableNames["ArenaDruid"] = { BabbleClass["Druid"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaHunter"] = { BabbleClass["Hunter"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaMage"] = { BabbleClass["Mage"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaPaladin"] = { BabbleClass["Paladin"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaPriest"] = { BabbleClass["Priest"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaRogue"] = { BabbleClass["Rogue"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaShaman"] = { BabbleClass["Shaman"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaWarlock"] = { BabbleClass["Warlock"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["ArenaWarrior"] = { BabbleClass["Warrior"].." - "..AL["Arena PvP Sets"], "AtlasLootGeneralPvPItems" };
  --Arena PvP Sets, Season 2
	AtlasLoot_TableNames["Arena2Druid"] = { BabbleClass["Druid"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Hunter"] = { BabbleClass["Hunter"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Mage"] = { BabbleClass["Mage"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Paladin"] = { BabbleClass["Paladin"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Priest"] = { BabbleClass["Priest"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Rogue"] = { BabbleClass["Rogue"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Shaman"] = { BabbleClass["Shaman"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Warlock"] = { BabbleClass["Warlock"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Warrior"] = { BabbleClass["Warrior"].." - "..AL["Arena 2 PvP Sets"], "AtlasLootGeneralPvPItems" };
  --Arena PvP Sets, Season 3
	AtlasLoot_TableNames["Arena3Druid"] = { BabbleClass["Druid"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Hunter"] = { BabbleClass["Hunter"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Mage"] = { BabbleClass["Mage"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Paladin"] = { BabbleClass["Paladin"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Priest"] = { BabbleClass["Priest"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Rogue"] = { BabbleClass["Rogue"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Shaman"] = { BabbleClass["Shaman"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Warlock"] = { BabbleClass["Warlock"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Warrior"] = { BabbleClass["Warrior"].." - "..AL["Arena 3 PvP Sets"], "AtlasLootGeneralPvPItems" };
  --Arena PvP Sets, Season 4
	AtlasLoot_TableNames["Arena4Druid"] = { BabbleClass["Druid"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Hunter"] = { BabbleClass["Hunter"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Mage"] = { BabbleClass["Mage"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Paladin"] = { BabbleClass["Paladin"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Priest"] = { BabbleClass["Priest"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Rogue"] = { BabbleClass["Rogue"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Shaman"] = { BabbleClass["Shaman"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Warlock"] = { BabbleClass["Warlock"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Warrior"] = { BabbleClass["Warrior"].." - "..AL["Arena 4 PvP Sets"], "AtlasLootGeneralPvPItems" };
  --Level 60 PvP Sets
	AtlasLoot_TableNames["PVPDruid"] = { BabbleClass["Druid"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPHunter"] = { BabbleClass["Hunter"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPMage"] = { BabbleClass["Mage"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPPaladin"] = { BabbleClass["Paladin"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPPriest"] = { BabbleClass["Priest"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPRogue"] = { BabbleClass["Rogue"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPShaman"] = { BabbleClass["Shaman"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPWarlock"] = { BabbleClass["Warlock"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPWarrior"] = { BabbleClass["Warrior"].." - "..AL["PvP Sets (Level 60)"], "AtlasLootGeneralPvPItems" };
  --Level 70 PvP Reputation Sets
	AtlasLoot_TableNames["PVP70RepDruid"] = { BabbleClass["Druid"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepHunter"] = { BabbleClass["Hunter"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepMage"] = { BabbleClass["Mage"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepPaladin"] = { BabbleClass["Paladin"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepPriest"] = { BabbleClass["Priest"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepRogue"] = { BabbleClass["Rogue"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepShaman"] = { BabbleClass["Shaman"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepWarlock"] = { BabbleClass["Warlock"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVP70RepWarrior"] = { BabbleClass["Warrior"].." - "..AL["PvP Reputation Sets"], "AtlasLootGeneralPvPItems" };
  --Vanilla WoW Sets
	AtlasLoot_TableNames["VWOWDeadmines"] = { AL["Defias Leather"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWWailingC"] = { AL["Embrace of the Viper"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWScarletM"] = { AL["Chain of the Scarlet Crusade"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWBlackrockD"] = { AL["The Gladiator"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWIronweave"] = { AL["Ironweave Battlesuit"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWScholo"] = { BabbleZone["Scholomance"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWStrat"] = { AL["The Postmaster"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWScourgeInvasion"] = { AL["Scourge Invasion"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWSpiderKiss"] = { AL["Spider's Kiss"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWDalRend"] = { AL["Dal'Rend's Arms"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWZulGurub"] = { BabbleZone["Zul'Gurub"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWShardOfGods"] = { AL["Shard of the Gods"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["VWOWSpiritofEskhandar"] = { AL["Spirit of Eskhandar"], "AtlasLootSetItems" };
  --The Burning Crusade Sets
	AtlasLoot_TableNames["TBCSets"] = { AL["Burning Crusade"], "AtlasLootSetItems" };
  --Crafted Sets - Blacksmithing
	AtlasLoot_TableNames["ImperialPlate"] = { AL["Imperial Plate"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TheDarksoul"] = { AL["The Darksoul"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FelIronPlate"] = { AL["Fel Iron Plate"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AdamantiteB"] = { AL["Adamantite Battlegear"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FlameG"] = { AL["Flame Guard"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantedAdaman"] = { AL["Enchanted Adamantite Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["KhoriumWard"] = { AL["Khorium Ward"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FaithFelsteel"] = { AL["Faith in Felsteel"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BurningRage"] = { AL["Burning Rage"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BloodsoulEmbrace"] = { AL["Bloodsoul Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FelIronChain"] = { AL["Fel Iron Chain"], "AtlasLootCrafting" };
  --Crafted Sets - Tailoring
	AtlasLoot_TableNames["BloodvineG"] = { AL["Bloodvine Garb"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["NeatherVest"] = { AL["Netherweave Vestments"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["ImbuedNeather"] = { AL["Imbued Netherweave"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["ArcanoVest"] = { AL["Arcanoweave Vestments"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TheUnyielding"] = { AL["The Unyielding"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["WhitemendWis"] = { AL["Whitemend Wisdom"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SpellstrikeInfu"] = { AL["Spellstrike Infusion"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BattlecastG"] = { AL["Battlecast Garb"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SoulclothEm"] = { AL["Soulcloth Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["PrimalMoon"] = { AL["Primal Mooncloth"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["ShadowEmbrace"] = { AL["Shadow's Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SpellfireWrath"] = { AL["Wrath of Spellfire"], "AtlasLootCrafting" };
  --Crafted Sets - Leatherworking
	AtlasLoot_TableNames["VolcanicArmor"] = { AL["Volcanic Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["IronfeatherArmor"] = { AL["Ironfeather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["StormshroudArmor"] = { AL["Stormshroud Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["DevilsaurArmor"] = { AL["Devilsaur Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BloodTigerH"] = { AL["Blood Tiger Harness"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["PrimalBatskin"] = { AL["Primal Batskin"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["WildDraenishA"] = { AL["Wild Draenish Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["ThickDraenicA"] = { AL["Thick Draenic Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FelSkin"] = { AL["Fel Skin"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SClefthoof"] = { AL["Strength of the Clefthoof"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["GreenDragonM"] = { AL["Green Dragon Mail"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlueDragonM"] = { AL["Blue Dragon Mail"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlackDragonM"] = { AL["Black Dragon Mail"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["ScaledDraenicA"] = { AL["Scaled Draenic Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FelscaleArmor"] = { AL["Felscale Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FelstalkerArmor"] = { AL["Felstalker Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["NetherFury"] = { AL["Fury of the Nether"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["PrimalIntent"] = { AL["Primal Intent"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["WindhawkArmor"] = { AL["Windhawk Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["NetherscaleArmor"] = { AL["Netherscale Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["NetherstrikeArmor"] = { AL["Netherstrike Armor"], "AtlasLootCrafting" };
  --ZG Sets
	AtlasLoot_TableNames["ZGDruid"] = { BabbleClass["Druid"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGHunter"] = { BabbleClass["Hunter"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGMage"] = { BabbleClass["Mage"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGPaladin"] = { BabbleClass["Paladin"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGPriest"] = { BabbleClass["Priest"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGRogue"] = { BabbleClass["Rogue"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGShaman"] = { BabbleClass["Shaman"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGWarlock"] = { BabbleClass["Warlock"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["ZGWarrior"] = { BabbleClass["Warrior"].." - "..AL["ZG Class Sets"], "AtlasLootSetItems" };
  --AQ20 Sets
	AtlasLoot_TableNames["AQ20Sets1"] = { AL["AQ20 Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["AQ20Sets2"] = { AL["AQ20 Class Sets"], "AtlasLootSetItems" };
  --AQ40 Sets
	AtlasLoot_TableNames["AQ40Sets1"] = { AL["AQ40 Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["AQ40Sets2"] = { AL["AQ40 Class Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["AQ40Sets3"] = { AL["AQ40 Class Sets"], "AtlasLootSetItems" };
  --Dungeon Set 1/2
	AtlasLoot_TableNames["T0Druid"] = { BabbleClass["Druid"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Hunter"] = { BabbleClass["Hunter"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Mage"] = { BabbleClass["Mage"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Paladin"] = { BabbleClass["Paladin"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Priest"] = { BabbleClass["Priest"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Rogue"] = { BabbleClass["Rogue"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Shaman"] = { BabbleClass["Shaman"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Warlock"] = { BabbleClass["Warlock"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T0Warrior"] = { BabbleClass["Warrior"].." - "..AL["Dungeon 1/2 Sets"], "AtlasLootSetItems" };
  --Dungeon Set 3
	AtlasLoot_TableNames["DS3Cloth"] = { AL["Dungeon Set 3"].." - "..BabbleInventory["Cloth"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["DS3Leather"] = { AL["Dungeon Set 3"].." - "..BabbleInventory["Leather"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["DS3Mail"] = { AL["Dungeon Set 3"].." - "..BabbleInventory["Mail"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["DS3Plate"] = { AL["Dungeon Set 3"].." - "..BabbleInventory["Plate"], "AtlasLootSetItems" };
  --T1/2Sets
	AtlasLoot_TableNames["T1T2Druid"] = { BabbleClass["Druid"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Hunter"] = { BabbleClass["Hunter"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Mage"] = { BabbleClass["Mage"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Paladin"] = { BabbleClass["Paladin"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Priest"] = { BabbleClass["Priest"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Rogue"] = { BabbleClass["Rogue"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Shaman"] = { BabbleClass["Shaman"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Warlock"] = { BabbleClass["Warlock"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T1T2Warrior"] = { BabbleClass["Warrior"].." - "..AL["Tier 1/2 Sets"], "AtlasLootSetItems" };
  --T3 Sets
	AtlasLoot_TableNames["T3Druid"] = { BabbleClass["Druid"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Hunter"] = { BabbleClass["Hunter"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Mage"] = { BabbleClass["Mage"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Paladin"] = { BabbleClass["Paladin"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Priest"] = { BabbleClass["Priest"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Rogue"] = { BabbleClass["Rogue"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Shaman"] = { BabbleClass["Shaman"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Warlock"] = { BabbleClass["Warlock"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T3Warrior"] = { BabbleClass["Warrior"].." - "..AL["Tier 3 Sets"], "AtlasLootSetItems" };
  --T4 Sets
	AtlasLoot_TableNames["T4Druid"] = { BabbleClass["Druid"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Hunter"] = { BabbleClass["Hunter"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Mage"] = { BabbleClass["Mage"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Paladin"] = { BabbleClass["Paladin"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Priest"] = { BabbleClass["Priest"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Rogue"] = { BabbleClass["Rogue"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Shaman"] = { BabbleClass["Shaman"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Warlock"] = { BabbleClass["Warlock"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T4Warrior"] = { BabbleClass["Warrior"].." - "..AL["Tier 4 Sets"], "AtlasLootSetItems" };
  --T5 Sets
	AtlasLoot_TableNames["T5Druid"] = { BabbleClass["Druid"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Hunter"] = { BabbleClass["Hunter"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Mage"] = { BabbleClass["Mage"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Paladin"] = { BabbleClass["Paladin"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Priest"] = { BabbleClass["Priest"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Rogue"] = { BabbleClass["Rogue"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Shaman"] = { BabbleClass["Shaman"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Warlock"] = { BabbleClass["Warlock"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T5Warrior"] = { BabbleClass["Warrior"].." - "..AL["Tier 5 Sets"], "AtlasLootSetItems" };
  --T6 Sets
	AtlasLoot_TableNames["T6Druid"] = { BabbleClass["Druid"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Druid2"] = { BabbleClass["Druid"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Hunter"] = { BabbleClass["Hunter"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Mage"] = { BabbleClass["Mage"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Paladin"] = { BabbleClass["Paladin"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Paladin2"] = { BabbleClass["Paladin"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Priest"] = { BabbleClass["Priest"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Rogue"] = { BabbleClass["Rogue"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Shaman"] = { BabbleClass["Shaman"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Shaman2"] = { BabbleClass["Shaman"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Warlock"] = { BabbleClass["Warlock"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["T6Warrior"] = { BabbleClass["Warrior"].." - "..AL["Tier 6 Sets"], "AtlasLootSetItems" };

------------------------
--- Misc Collections ---
------------------------

	AtlasLoot_TableNames["BlizzardCollectables1"] = { "Blizzard Collectables", "AtlasLootSetItems" };
	AtlasLoot_TableNames["CraftedWeapons1"] = { AL["Crafted Epic Weapons"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["CraftedWeapons2"] = { AL["Crafted Epic Weapons"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["HardModeCloth"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Cloth"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeLeather"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Leather"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeLeather2"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Leather"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeMail"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Mail"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModePlate"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Plate"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModePlate2"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Plate"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeCloaks"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Back"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeResist"] = { AL["Badge of Justice Rewards"].." - "..AL["Fire Resistance Gear"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeAccessories"] = { AL["Badge of Justice Rewards"].." - "..AL["Accessories"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeAccessories2"] = { AL["Badge of Justice Rewards"].." - "..AL["Accessories"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeRelic"] = { AL["Badge of Justice Rewards"].." - "..BabbleInventory["Relic"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeWeapons"] = { AL["Badge of Justice Rewards"].." - "..AL["Weapons"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeArena"] = { AL["Badge of Justice Rewards"].." - "..AL["Arena Reward"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["HardModeArena2"] = { AL["Badge of Justice Rewards"].." - "..AL["Arena Reward"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["Legendaries"] = { AL["Legendary Items"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["RareMounts1"] = { AL["Rare Mounts"].." - The Burning Crusade", "AtlasLootSetItems" };
	AtlasLoot_TableNames["RareMounts2"] = { AL["Rare Mounts"].." - Classic WoW", "AtlasLootSetItems" };
	AtlasLoot_TableNames["Tabards1"] = { AL["Tabards"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["Tabards2"] = { AL["Tabards"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["CardGame1"] = { AL["Upper Deck Card Game Items"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["CardGame2"] = { AL["Upper Deck Card Game Items"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["WorldEpics1"] = { AL["BoE World Epics"].." - "..AL["Level 30-39"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["WorldEpics2"] = { AL["BoE World Epics"].." - "..AL["Level 40-49"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["WorldEpics3"] = { AL["BoE World Epics"].." - "..AL["Level 50-60"], "AtlasLootSetItems" };
	AtlasLoot_TableNames["WorldEpics4"] = { AL["BoE World Epics"].." - "..AL["Level 70"], "AtlasLootSetItems" };

--------------------
--- World Bosses ---
--------------------

  --Azuregos
	AtlasLoot_TableNames["AAzuregos"] = { BabbleBoss["Azuregos"], "AtlasLootWBItems" };
  --Doom Lord Kazzak
	AtlasLoot_TableNames["DoomLordKazzak"] = { BabbleBoss["Doom Lord Kazzak"], "AtlasLootWBItems" };
  --Doomwalker
	AtlasLoot_TableNames["DDoomwalker"] = { BabbleBoss["Doomwalker"], "AtlasLootWBItems" };
  --Emrald Dragons
	AtlasLoot_TableNames["DEmeriss"] = { BabbleBoss["Emeriss"], "AtlasLootWBItems" };
	AtlasLoot_TableNames["DLethon"] = { BabbleBoss["Lethon"], "AtlasLootWBItems" };
	AtlasLoot_TableNames["DTaerar"] = { BabbleBoss["Taerar"], "AtlasLootWBItems" };
	AtlasLoot_TableNames["DYsondre"] = { BabbleBoss["Ysondre"], "AtlasLootWBItems" };
  --Highlord Kruul
	AtlasLoot_TableNames["KKruul"] = { AL["Highlord Kruul"], "AtlasLootWBItems" };

--------------
--- Events ---
--------------

  --Abyssal Council
	AtlasLoot_TableNames["Templars"] = { "Abyssal Council - Templars", "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Dukes"] = { "Abyssal Council - Dukes", "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["HighCouncil"] = { "Abyssal Council - High Council", "AtlasLootWorldEvents" };
  --Ethereum Prison
	AtlasLoot_TableNames["ArmbreakerHuffaz"] = { AL["Armbreaker Huffaz"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["FelTinkererZortan"] = { AL["Fel Tinkerer Zortan"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Forgosh"] = { AL["Forgosh"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Gulbor"] = { AL["Gul'bor"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["MalevustheMad"] = { AL["Malevus the Mad"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["PorfustheGemGorger"] = { AL["Porfus the Gem Gorger"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["WrathbringerLaztarash"] = { AL["Wrathbringer Laz-tarash"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["BashirStasisChambers"] = { AL["Bash'ir Landing Stasis Chambers"], "AtlasLootWorldEvents" };
  --Seasonal
	AtlasLoot_TableNames["Brewfest1"] = { AL["Brewfest"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Brewfest2"] = { AL["Brewfest"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["CorenDirebrew"] = { AL["Coren Direbrew"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ChildrensWeek"] = { AL["Children's Week"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Halloween1"] = { AL["Hallow's End"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Halloween2"] = { AL["Hallow's End"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["HeadlessHorseman"] = { AL["Headless Horseman"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["HarvestFestival"] = { AL["Harvest Festival"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["LunarFestival1"] = { AL["Lunar Festival"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["LunarFestival2"] = { AL["Lunar Festival"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["MidsummerFestival"] = { AL["Midsummer Fire Festival"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["LordAhune"] = { AL["Lord Ahune"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["LordAhuneHEROIC"] = { AL["Lord Ahune"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Noblegarden"] = { AL["Noblegarden"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Valentineday"] = { AL["Love is in the Air"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Winterviel1"] = { AL["Feast of Winter Veil"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Winterviel2"] = { AL["Feast of Winter Veil"], "AtlasLootWorldEvents" };
  --Skettis
	AtlasLoot_TableNames["DarkscreecherAkkarai"] = { AL["Darkscreecher Akkarai"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Karrog"] = { AL["Karrog"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["GezzaraktheHuntress"] = { AL["Gezzarak the Huntress"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["VakkiztheWindrager"] = { AL["Vakkiz the Windrager"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Terokk"] = { AL["Terokk"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["SkettisTalonpriestIshaal"] = { "Talonpriest Ishaal", "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["SkettisHazziksPackage"] = { "Hazzik's Package", "AtlasLootWorldEvents" };
  --Other
	AtlasLoot_TableNames["BashirLanding"] = { AL["Bash'ir Landing Skyguard Raid"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ElementalInvasion"] = { AL["Elemental Invasion"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["FishingExtravaganza"] = { AL["Stranglethorn Fishing Extravaganza"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["GurubashiArena"] = { AL["Gurubashi Arena Booty Run"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ScourgeInvasionEvent1"] = { AL["Scourge Invasion"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ScourgeInvasionEvent2"] = { "Scourge Invasion Bosses", "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Shartuul"] = { AL["Shartuul"], "AtlasLootWorldEvents" };
	
----------------------
--- WotLK Factions ---
----------------------
	
-------------------
--- BC Factions ---
-------------------

  --The Aldor
	AtlasLoot_TableNames["Aldor1"] = { BabbleFaction["The Aldor"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Aldor2"] = { BabbleFaction["The Aldor"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --Ashtongue Deathsworn
	AtlasLoot_TableNames["Ashtongue1"] = { BabbleFaction["Ashtongue Deathsworn"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Ashtongue2"] = { BabbleFaction["Ashtongue Deathsworn"], "AtlasLootRepItems" };
  --Cenarion Expedition
	AtlasLoot_TableNames["CExpedition1"] = { BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["CExpedition2"] = { BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --The Consortium
	AtlasLoot_TableNames["Consortium1"] = { BabbleFaction["The Consortium"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Consortium2"] = { BabbleFaction["The Consortium"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --Honor Hold
	AtlasLoot_TableNames["HonorHold1"] = { BabbleFaction["Honor Hold"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["HonorHold2"] = { BabbleFaction["Honor Hold"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --Keepers of Time
	AtlasLoot_TableNames["KeepersofTime1"] = { BabbleFaction["Keepers of Time"], "AtlasLootRepItems" };
  --Kurenai
	AtlasLoot_TableNames["Kurenai1"] = { BabbleFaction["Kurenai"], "AtlasLootRepItems" };
  --Lower City
	AtlasLoot_TableNames["LowerCity1"] = { BabbleFaction["Lower City"], "AtlasLootRepItems" };
  --Netherwing
	AtlasLoot_TableNames["Netherwing1"] = { BabbleFaction["Netherwing"], "AtlasLootRepItems" };
  --Ogri'la
	AtlasLoot_TableNames["Ogrila1"] = { BabbleFaction["Ogri'la"], "AtlasLootRepItems" };
  --The Scale of the Sands
	AtlasLoot_TableNames["ScaleSands1"] = { BabbleFaction["The Scale of the Sands"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["ScaleSands2"] = { BabbleFaction["The Scale of the Sands"], "AtlasLootRepItems" };
  --The Scryers
	AtlasLoot_TableNames["Scryer1"] = { BabbleFaction["The Scryers"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Scryer2"] = { BabbleFaction["The Scryers"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --The Sha'tar
	AtlasLoot_TableNames["Shatar1"] = { BabbleFaction["The Sha'tar"], "AtlasLootRepItems" };
  --Exalted with Cenarion Expedition, The Sha'tar and The Aldor/Scryers
	AtlasLoot_TableNames["ShattrathFlasks1"] = { "Shattrath Flasks", "AtlasLootRepItems" };
  --Sha'tari Skyguard
	AtlasLoot_TableNames["Skyguard1"] = { BabbleFaction["Sha'tari Skyguard"], "AtlasLootRepItems" };
  --Shattered Sun Offensive
	AtlasLoot_TableNames["SunOffensive1"] = { BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["SunOffensive2"] = { BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["SunOffensive3"] = { BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --Sporeggar
	AtlasLoot_TableNames["Sporeggar1"] = { BabbleFaction["Sporeggar"], "AtlasLootRepItems" };
  --Thrallmar
	AtlasLoot_TableNames["Thrallmar1"] = { BabbleFaction["Thrallmar"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Thrallmar2"] = { BabbleFaction["Thrallmar"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --Tranquillien
	AtlasLoot_TableNames["Tranquillien1"] = { BabbleFaction["Tranquillien"], "AtlasLootRepItems" };
  --The Violet Eye
	AtlasLoot_TableNames["VioletEye1"] = { BabbleFaction["The Violet Eye"], "AtlasLootRepItems" };

------------------------
--- Classic Factions ---
------------------------

  --Argent Dawn
	AtlasLoot_TableNames["Argent1"] = { BabbleFaction["Argent Dawn"]..": Token Hand-ins", "AtlasLootRepItems" };
	AtlasLoot_TableNames["Argent2"] = { BabbleFaction["Argent Dawn"], "AtlasLootRepItems" };
  --Bloodsail Buccaneers
	AtlasLoot_TableNames["Bloodsail1"] = { BabbleFaction["Bloodsail Buccaneers"], "AtlasLootRepItems" };
  --Brood of Nozdormu
	AtlasLoot_TableNames["AQBroodRings"] = { BabbleFaction["Brood of Nozdormu"], "AtlasLootRepItems" };
  --Cenarion Circle
	AtlasLoot_TableNames["Cenarion1"] = { BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Friendly"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Cenarion2"] = { BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Cenarion3"] = { BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Cenarion4"] = { BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --The Darkmoon Faire
	AtlasLoot_TableNames["Darkmoon1"] = { BabbleFaction["Darkmoon Faire"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Darkmoon2"] = { BabbleFaction["Darkmoon Faire"].." - "..BabbleInventory["Trinket"], "AtlasLootRepItems" };
  --The Defilers
	AtlasLoot_TableNames["Defilers"] = { BabbleFaction["The Defilers"], "AtlasLootRepItems" };
  --Frostwolf Clan
	AtlasLoot_TableNames["Frostwolf1"] = { BabbleFaction["Frostwolf Clan"], "AtlasLootRepItems" };
  --Hydraxian Waterlords
	AtlasLoot_TableNames["WaterLords1"] = { BabbleFaction["Hydraxian Waterlords"], "AtlasLootRepItems" };
  --Gelkis Clan Centaur
	AtlasLoot_TableNames["GelkisClan1"] = { BabbleFaction["Gelkis Clan Centaur"], "AtlasLootRepItems" };
  --The League of Arathor
	AtlasLoot_TableNames["LeagueofArathor"] = { BabbleFaction["The League of Arathor"], "AtlasLootRepItems" };
  --The Mag'har
	AtlasLoot_TableNames["Maghar1"] = { BabbleFaction["The Mag'har"], "AtlasLootRepItems" };
  --Magram Clan Centaur
	AtlasLoot_TableNames["MagramClan1"] = { BabbleFaction["Magram Clan Centaur"], "AtlasLootRepItems" };
  --Stormpike Guard
	AtlasLoot_TableNames["Stormpike1"] = { BabbleFaction["Stormpike Guard"], "AtlasLootRepItems" };
  --Thorium Brotherhood
	AtlasLoot_TableNames["Thorium1"] = { BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Thorium2"] = { BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };
  --Timbermaw Hold
	AtlasLoot_TableNames["Timbermaw"] = { BabbleFaction["Timbermaw Hold"], "AtlasLootRepItems" };
  --Wintersaber Trainers
	AtlasLoot_TableNames["Wintersaber1"] = { BabbleFaction["Wintersaber Trainers"], "AtlasLootRepItems" };
  --Zandalar Tribe
	AtlasLoot_TableNames["Zandalar1"] = { BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"], "AtlasLootRepItems" };
	AtlasLoot_TableNames["Zandalar2"] = { BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"], "AtlasLootRepItems" };

--------------
--- Trades ---
--------------

  --Alchemy
	AtlasLoot_TableNames["AlchemyApprentice1"] = { ALCHEMY..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyJourneyman1"] = { ALCHEMY..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyExpert1"] = { ALCHEMY..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyArtisan1"] = { ALCHEMY..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyArtisan2"] = { ALCHEMY..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyMaster1"] = { ALCHEMY..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyMaster2"] = { ALCHEMY..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyMaster3"] = { ALCHEMY..": "..MASTER, "AtlasLootCrafting" };
  --BlackSmithing
	AtlasLoot_TableNames["SmithingApprentice1"] = { BLACKSMITHING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingJourneyman1"] = { BLACKSMITHING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingExpert1"] = { BLACKSMITHING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingExpert2"] = { BLACKSMITHING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArtisan1"] = { BLACKSMITHING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArtisan2"] = { BLACKSMITHING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster1"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster2"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster3"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster4"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster5"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster6"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster7"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMaster8"] = { BLACKSMITHING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Armorsmith1"] = { ARMORSMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Weaponsmith1"] = { WEAPONSMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Axesmith1"] = { AXESMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Hammersmith1"] = { HAMMERSMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Swordsmith1"] = { SWORDSMITH, "AtlasLootCrafting" };
  --Enchanting
	AtlasLoot_TableNames["EnchantingApprentice1"] = { ENCHANTING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingJourneyman1"] = { ENCHANTING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingExpert1"] = { ENCHANTING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingExpert2"] = { ENCHANTING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingArtisan1"] = { ENCHANTING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingArtisan2"] = { ENCHANTING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingMaster1"] = { ENCHANTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingMaster2"] = { ENCHANTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingMaster3"] = { ENCHANTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingMaster4"] = { ENCHANTING..": "..MASTER, "AtlasLootCrafting" };
  --Engineering
	AtlasLoot_TableNames["EngineeringApprentice1"] = { ENGINEERING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringJourneyman1"] = { ENGINEERING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringExpert1"] = { ENGINEERING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringExpert2"] = { ENGINEERING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArtisan1"] = { ENGINEERING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArtisan2"] = { ENGINEERING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArtisan3"] = { ENGINEERING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMaster1"] = { ENGINEERING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMaster2"] = { ENGINEERING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMaster3"] = { ENGINEERING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMaster4"] = { ENGINEERING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Gnomish1"] = { GNOMISH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Goblin1"] = { GOBLIN, "AtlasLootCrafting" };
  --Jewelcrafing
	AtlasLoot_TableNames["JewelApprentice1"] = { JEWELCRAFTING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelJourneyman1"] = { JEWELCRAFTING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelExpert1"] = { JEWELCRAFTING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelArtisan1"] = { JEWELCRAFTING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster1"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster2"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster3"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster4"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster5"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster6"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMaster7"] = { JEWELCRAFTING..": "..MASTER, "AtlasLootCrafting" };
  --Leatherworking
	AtlasLoot_TableNames["LeatherApprentice1"] = { LEATHERWORKING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherJourneyman1"] = { LEATHERWORKING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherJourneyman2"] = { LEATHERWORKING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherExpert1"] = { LEATHERWORKING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherExpert2"] = { LEATHERWORKING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherArtisan1"] = { LEATHERWORKING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherArtisan2"] = { LEATHERWORKING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster1"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster2"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster3"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster4"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster5"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster6"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster7"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMaster8"] = { LEATHERWORKING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Dragonscale1"] = { DRAGONSCALE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Elemental1"] = { ELEMENTAL, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Tribal1"] = { TRIBAL, "AtlasLootCrafting" };
  --Mining
	AtlasLoot_TableNames["Mining1"] = { MINING, "AtlasLootCrafting" };
  --Tailoring
	AtlasLoot_TableNames["TailoringApprentice1"] = { TAILORING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringJourneyman1"] = { TAILORING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringJourneyman2"] = { TAILORING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringExpert1"] = { TAILORING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringExpert2"] = { TAILORING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArtisan1"] = { TAILORING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArtisan2"] = { TAILORING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArtisan3"] = { TAILORING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMaster1"] = { TAILORING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMaster2"] = { TAILORING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMaster3"] = { TAILORING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMaster4"] = { TAILORING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMaster5"] = { TAILORING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMaster6"] = { TAILORING..": "..MASTER, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Mooncloth1"] = { MOONCLOTH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Shadoweave1"] = { SHADOWEAVE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Spellfire1"] = { SPELLFIRE, "AtlasLootCrafting" };
  --Cooking
	AtlasLoot_TableNames["CookingApprentice1"] = { COOKING..": "..APPRENTICE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["CookingJourneyman1"] = { COOKING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["CookingJourneyman2"] = { COOKING..": "..JOURNEYMAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["CookingExpert1"] = { COOKING..": "..EXPERT, "AtlasLootCrafting" };
	AtlasLoot_TableNames["CookingArtisan1"] = { COOKING..": "..ARTISAN, "AtlasLootCrafting" };
	AtlasLoot_TableNames["CookingMaster1"] = { COOKING..": "..MASTER, "AtlasLootCrafting" };
  --FirstAid
	AtlasLoot_TableNames["FirstAid1"] = { FIRSTAID, "AtlasLootCrafting" };
	
-----------
--- PvP ---
-----------

  --Battlegrounds
   --Alterac Valley
	AtlasLoot_TableNames["AVMisc"] = { BabbleZone["Alterac Valley"].." "..AL["Misc. Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AVBlue"] = { BabbleZone["Alterac Valley"].." "..AL["Superior Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AVPurple"] = { BabbleZone["Alterac Valley"].." "..AL["Epic Rewards"], "AtlasLootBGItems" };
   --Arathi Basin
	AtlasLoot_TableNames["ABMisc"] = { BabbleZone["Arathi Basin"].." "..AL["Misc. Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB20291"] = { BabbleZone["Arathi Basin"].." "..AL["Level 20-29 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB20292"] = { BabbleZone["Arathi Basin"].." "..AL["Level 20-29 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB3039"] = { BabbleZone["Arathi Basin"].." "..AL["Level 30-39 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB40491"] = { BabbleZone["Arathi Basin"].." "..AL["Level 40-49 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB40492"] = { BabbleZone["Arathi Basin"].." "..AL["Level 40-49 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB5059"] = { BabbleZone["Arathi Basin"].." "..AL["Level 50-59 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["AB60"] = { BabbleZone["Arathi Basin"].." "..AL["Level 60 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["ABSets1"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"].." ("..BabbleInventory["Cloth"].."/"..BabbleInventory["Leather"]..")", "AtlasLootBGItems" };
	AtlasLoot_TableNames["ABSets2"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"].." ("..BabbleInventory["Mail"]..")", "AtlasLootBGItems" };
	AtlasLoot_TableNames["ABSets3"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"].." ("..BabbleInventory["Plate"]..")", "AtlasLootBGItems" };
   --Warsong Gulch
	AtlasLoot_TableNames["WSGMisc"] = { BabbleZone["Warsong Gulch"].." "..AL["Misc. Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["WSG1019"] = { BabbleZone["Warsong Gulch"].." "..AL["Level 10-19 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["WSG2029"] = { BabbleZone["Warsong Gulch"].." "..AL["Level 20-29 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["WSG3039"] = { BabbleZone["Warsong Gulch"].." "..AL["Level 30-39 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["WSG4049"] = { BabbleZone["Warsong Gulch"].." "..AL["Level 40-49 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["WSG5059"] = { BabbleZone["Warsong Gulch"].." "..AL["Level 50-59 Rewards"], "AtlasLootBGItems" };
	AtlasLoot_TableNames["WSG60"] = { BabbleZone["Warsong Gulch"].." "..AL["Level 60 Rewards"], "AtlasLootBGItems" };
  --World PvP
	AtlasLoot_TableNames["Hellfire"] = { BabbleZone["Hellfire Peninsula"]..": "..AL["Hellfire Fortifications"], "AtlasLootWorldPvPItems" };
	AtlasLoot_TableNames["Nagrand1"] = { BabbleZone["Nagrand"]..": "..AL["Halaa"], "AtlasLootWorldPvPItems" };
	AtlasLoot_TableNames["Nagrand2"] = { BabbleZone["Nagrand"]..": "..AL["Halaa"], "AtlasLootWorldPvPItems" };
	AtlasLoot_TableNames["Terokkar"] = { BabbleZone["Terokkar Forest"]..": "..AL["Spirit Towers"], "AtlasLootWorldPvPItems" };
	AtlasLoot_TableNames["Zangarmarsh"] = { BabbleZone["Zangarmarsh"]..": "..AL["Twin Spire Ruins"], "AtlasLootWorldPvPItems" };
  --Misc Other PvP
	AtlasLoot_TableNames["PvP60Accessories1"] = { AL["PvP Accessories (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP60Accessories2"] = { AL["PvP Accessories - Alliance (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP60Accessories3"] = { AL["PvP Accessories - Horde (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70Accessories1"] = { AL["PvP Accessories (Level 70)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70Accessories2"] = { AL["PvP Accessories (Level 70)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70NonSet1"] = { AL["PvP Non-Set Epics"]..": "..AL["Accessories"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70NonSet2"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Cloth"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70NonSet3"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Leather"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70NonSet4"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Mail"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PvP70NonSet5"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Plate"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPWeapons1"] = { AL["PvP Weapons (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["PVPWeapons2"] = { AL["PvP Weapons (Level 60)"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Weapons1"] = { AL["Arena Season 2 Weapons"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena2Weapons2"] = { AL["Arena Season 2 Weapons"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Weapons1"] = { AL["Arena Season 3 Weapons"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena3Weapons2"] = { AL["Arena Season 3 Weapons"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Weapons1"] = { AL["Arena Season 4 Weapons"], "AtlasLootGeneralPvPItems" };
	AtlasLoot_TableNames["Arena4Weapons2"] = { AL["Arena Season 4 Weapons"], "AtlasLootGeneralPvPItems" };

-------------
--- Other ---
-------------

  --Menus, the entry does nothing, but makes the generalised loot table code less complex
	AtlasLoot_TableNames["ABMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["AQ40SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["AQ20SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ZGSET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["PRE60SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["CRAFTSET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["CRAFTSET2"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["T6SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["T5SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["T4SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["T3SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["T1T2SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["T0SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["DS3SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["PVPSET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["PVPMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["CRAFTINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["PVP70RepSET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["PVP70NONSETEPICS"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ARENASET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ARENA2SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ARENA3SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ARENA4SET"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["REPMENU_AZEROTHPREBC"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["REPMENU_AZEROTHPOSTBC"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["REPMENU_OUTLAND"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["REPMENU_SHATTRATH"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["REPMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["SETMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["SKETTISMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["70TOKENMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["WORLDEPICS"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["WORLDEVENTMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["WSGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ETHEREUMMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ABYSSALMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["HONORMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ARENAMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ALCHEMYMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["SMITHINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ENCHANTINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["ENGINEERINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["JEWELCRAFTINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["LEATHERWORKINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["MININGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["TAILORINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["COOKINGMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["FIRSTAIDMENU"] = { "dummy", "dummy" };
	AtlasLoot_TableNames["WishList"] = { AL["WishList"], "AtlasLootCharDB" };
  --If all else fails!
	AtlasLoot_TableNames["EmptyInstance"] = { "AtlasLoot", "AtlasLootFallback" };