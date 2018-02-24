local BabbleFaction = LibStub("LibBabble-Faction-3.0"):GetLookupTable();
local BabbleClass = LibStub("LibBabble-Class-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleInventory = LibStub("LibBabble-Inventory-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot"); 

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

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

AtlasLoot_ButtonRegistry = {
  --WoW Factions
	["Argent1"] = {
		Title = BabbleFaction["Argent Dawn"]..": "..AL["Token Hand-Ins"];
		Next_Page = "Argent2";
		Next_Title = BabbleFaction["Argent Dawn"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Argent2"] = {
		Title = BabbleFaction["Argent Dawn"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Exalted"];
		Prev_Page = "Argent1";
		Prev_Title = BabbleFaction["Argent Dawn"]..": "..AL["Token Hand-Ins"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Bloodsail1"] = {
		Title = BabbleFaction["Bloodsail Buccaneers"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["AQBroodRings"] = {
		Title = BabbleFaction["Brood of Nozdormu"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Cenarion1"] = {
		Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Friendly"];
		Next_Page = "Cenarion2";
		Next_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Cenarion2"] = {
		Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"];
		Next_Page = "Cenarion3";
		Next_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"];
		Prev_Page = "Cenarion1";
		Prev_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Friendly"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Cenarion3"] = {
		Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"];
		Next_Page = "Cenarion4";
		Next_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Exalted"];
		Prev_Page = "Cenarion2";
		Prev_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Cenarion4"] = {
		Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Exalted"];
		Prev_Page = "Cenarion3";
		Prev_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Darkmoon1"] = {
		Title = BabbleFaction["Darkmoon Faire"];
		Next_Page = "Darkmoon2";
		Next_Title = AtlasLoot_TableNames["Darkmoon2"][1];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Darkmoon2"] = {
		Title = AtlasLoot_TableNames["Darkmoon2"][1];
		Prev_Page = "Darkmoon1";
		Prev_Title = BabbleFaction["Darkmoon Faire"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Defilers"] = {
		Title = BabbleFaction["The Defilers"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Frostwolf1"] = {
		Title = BabbleFaction["Frostwolf Clan"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["GelkisClan1"] = {
		Title = BabbleFaction["Gelkis Clan Centaur"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["WaterLords1"] = {
		Title = BabbleFaction["Hydraxian Waterlords"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["LeagueofArathor"] = {
		Title = BabbleFaction["The League of Arathor"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["MagramClan1"] = {
		Title = BabbleFaction["Magram Clan Centaur"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Stormpike1"] = {
		Title = BabbleFaction["Stormpike Guard"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Thorium1"] = {
		Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "Thorium2";
		Next_Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Thorium2"] = {
		Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "Thorium1";
		Prev_Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Timbermaw"] = {
		Title = BabbleFaction["Timbermaw Hold"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Wintersaber1"] = {
		Title = BabbleFaction["Wintersaber Trainers"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Zandalar1"] = {
		Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "Zandalar2";
		Next_Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
	["Zandalar2"] = {
		Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "Zandalar1";
		Prev_Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_AZEROTHPREBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
		};
  --Burning Crusade Factions
	["Aldor1"] = {
		Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "Aldor2";
		Next_Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["Aldor2"] = {
		Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "Aldor1";
		Prev_Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["Ashtongue1"] = {
		Title = BabbleFaction["Ashtongue Deathsworn"];
		Next_Page = "Ashtongue2";
		Next_Title = BabbleFaction["Ashtongue Deathsworn"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Ashtongue2"] = {
		Title = BabbleFaction["Ashtongue Deathsworn"];
		Prev_Page = "Ashtongue1";
		Prev_Title = BabbleFaction["Ashtongue Deathsworn"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["CExpedition1"] = {
		Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "CExpedition2";
		Next_Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["CExpedition2"] = {
		Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "CExpedition1";
		Prev_Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Consortium1"] = {
		Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "Consortium2";
		Next_Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Consortium2"] = {
		Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "Consortium1";
		Prev_Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["HonorHold1"] = {
		Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "HonorHold2";
		Next_Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["HonorHold2"] = {
		Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "HonorHold1";
		Prev_Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["KeepersofTime1"] = {
		Title = BabbleFaction["Keepers of Time"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		};
	["Kurenai1"] = {
		Title = BabbleFaction["Kurenai"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["LowerCity1"] = {
		Title = BabbleFaction["Lower City"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["Maghar1"] = {
		Title = BabbleFaction["The Mag'har"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Netherwing1"] = {
		Title = BabbleFaction["Netherwing"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Ogrila1"] = {
		Title = BabbleFaction["Ogri'la"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["ScaleSands1"] = {
		Title = BabbleFaction["The Scale of the Sands"];
		Next_Page = "ScaleSands2";
		Next_Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		};
	["ScaleSands2"] = {
		Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Honored"];
		Prev_Page = "ScaleSands1";
		Prev_Title = BabbleFaction["The Scale of the Sands"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		Next_Page = "ScaleSands3";
		Next_Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Revered"].."-"..BabbleFaction["Exalted"];
		};
	["ScaleSands3"] = {
		Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Revered"].."-"..BabbleFaction["Exalted"];
		Prev_Page = "ScaleSands2";
		Prev_Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		};
	["Scryer1"] = {
		Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "Scryer2";
		Next_Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["Scryer2"] = {
		Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "Scryer1";
		Prev_Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["Shatar1"] = {
		Title = BabbleFaction["The Sha'tar"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["Skyguard1"] = {
		Title = BabbleFaction["Sha'tari Skyguard"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["SunOffensive1"] = {
		Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "SunOffensive2";
		Next_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		};
	["SunOffensive2"] = {
		Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"];
		Next_Page = "SunOffensive3";
		Next_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		Prev_Page = "SunOffensive1";
		Prev_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		};
	["SunOffensive3"] = {
		Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_SHATTRATH";
		Back_Title = AL["Factions - Shattrath City"];
		Prev_Page = "SunOffensive2";
		Prev_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"];
		};
	["Sporeggar1"] = {
		Title = BabbleFaction["Sporeggar"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Thrallmar1"] = {
		Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Next_Page = "Thrallmar2";
		Next_Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Thrallmar2"] = {
		Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
		Prev_Page = "Thrallmar1";
		Prev_Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
		Back_Page = "REPMENU_OUTLAND";
		Back_Title = AL["Factions - Outland"];
		};
	["Tranquillien1"] = {
		Title = BabbleFaction["Tranquillien"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		};
	["VioletEye1"] = {
		Title = BabbleFaction["The Violet Eye"];
		Next_Page = "VioletEye2";
		Next_Title = BabbleFaction["The Violet Eye"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		};
	["VioletEye2"] = {
		Title = BabbleFaction["The Violet Eye"];
		Prev_Page = "VioletEye1";
		Prev_Title = BabbleFaction["The Violet Eye"];
		Back_Page = "REPMENU_AZEROTHPOSTBC";
		Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
		};
  --PvP
	["AVMisc"] = {
		Title = BabbleZone["Alterac Valley"]..": "..AL["Misc. Rewards"];
		Next_Page = "AVBlue";
		Next_Title = BabbleZone["Alterac Valley"]..": "..AL["Superior Rewards"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["AVBlue"] = {
		Title = BabbleZone["Alterac Valley"]..": "..AL["Superior Rewards"];
		Next_Page = "AVPurple";
		Next_Title = BabbleZone["Alterac Valley"]..": "..AL["Epic Rewards"];
		Prev_Page = "AVMisc";
		Prev_Title = BabbleZone["Alterac Valley"]..": "..AL["Misc. Rewards"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["AVPurple"] = {
		Title = BabbleZone["Alterac Valley"]..": "..AL["Epic Rewards"];
		Prev_Page = "AVBlue";
		Prev_Title = BabbleZone["Alterac Valley"]..": "..AL["Superior Rewards"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["ABMisc"] = {
		Title = BabbleZone["Arathi Basin"]..": "..AL["Misc. Rewards"];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB20291";
		Next_Title = AtlasLoot_TableNames["AB20291"][1];
		};
	["AB20291"] = {
		Title = AtlasLoot_TableNames["AB20291"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB20292";
		Next_Title = AtlasLoot_TableNames["AB20292"][1];
		Prev_Page = "ABMisc";
		Prev_Title = BabbleZone["Arathi Basin"]..": "..AL["Misc. Rewards"];
		};
	["AB20292"] = {
		Title = AtlasLoot_TableNames["AB20292"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB3039";
		Next_Title = AtlasLoot_TableNames["AB3039"][1];
		Prev_Page = "AB20291";
		Prev_Title = AtlasLoot_TableNames["AB20291"][1];
		};
	["AB3039"] = {
		Title = AtlasLoot_TableNames["AB3039"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB40491";
		Next_Title = AtlasLoot_TableNames["AB40491"][1];
		Prev_Page = "AB20292";
		Prev_Title = AtlasLoot_TableNames["AB20292"][1];
		};
	["AB40491"] = {
		Title = AtlasLoot_TableNames["AB40491"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB40492";
		Next_Title = AtlasLoot_TableNames["AB40492"][1];
		Prev_Page = "AB3039";
		Prev_Title = AtlasLoot_TableNames["AB3039"][1];
		};
	["AB40492"] = {
		Title = AtlasLoot_TableNames["AB40492"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB5059";
		Next_Title = AtlasLoot_TableNames["AB5059"][1];
		Prev_Page = "AB40491";
		Prev_Title = AtlasLoot_TableNames["AB40491"][1];
		};
	["AB5059"] = {
		Title = AtlasLoot_TableNames["AB5059"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Next_Page = "AB60";
		Next_Title = AtlasLoot_TableNames["AB60"][1];
		Prev_Page = "AB40492";
		Prev_Title = AtlasLoot_TableNames["AB40492"][1];
		};
	["AB60"] = {
		Title = AtlasLoot_TableNames["AB60"][1];
		Back_Page = "ABMENU";
		Back_Title = BabbleZone["Arathi Basin"];
		Prev_Page = "AB5059";
		Prev_Title = AtlasLoot_TableNames["AB5059"][1];
		};
	["ABSets1"] = {
		Title = AtlasLoot_TableNames["ABSets1"][1];
		Next_Page = "ABSets2";
		Next_Title = AtlasLoot_TableNames["ABSets2"][1];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["ABSets2"] = {
		Title = AtlasLoot_TableNames["ABSets2"][1];
		Next_Page = "ABSets3";
		Next_Title = AtlasLoot_TableNames["ABSets3"][1];
		Prev_Page = "ABSets1";
		Prev_Title = AtlasLoot_TableNames["ABSets1"][1];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["ABSets3"] = {
		Title = AtlasLoot_TableNames["ABSets3"][1];
		Prev_Page = "ABSets2";
		Prev_Title = AtlasLoot_TableNames["ABSets2"][1];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["WSGMisc"] = {
		Title = BabbleZone["Warsong Gulch"]..": "..AL["Misc. Rewards"];
		Next_Page = "WSG1019";
		Next_Title = AtlasLoot_TableNames["WSG1019"][1];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["WSG1019"] = {
		Title = AtlasLoot_TableNames["WSG1019"][1];
		Next_Page = "WSG2029";
		Next_Title = AtlasLoot_TableNames["WSG2029"][1];
		Prev_Page = "WSGMisc";
		Prev_Title = BabbleZone["Warsong Gulch"]..": "..AL["Misc. Rewards"];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["WSG2029"] = {
		Title = AtlasLoot_TableNames["WSG2029"][1];
		Next_Page = "WSG3039";
		Next_Title = AtlasLoot_TableNames["WSG3039"][1];
		Prev_Page = "WSG1019";
		Prev_Title = AtlasLoot_TableNames["WSG1019"][1];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["WSG3039"] = {
		Title = AtlasLoot_TableNames["WSG3039"][1];
		Next_Page = "WSG4049";
		Next_Title = AtlasLoot_TableNames["WSG4049"][1];
		Prev_Page = "WSG2029";
		Prev_Title = AtlasLoot_TableNames["WSG2029"][1];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["WSG4049"] = {
		Title = AtlasLoot_TableNames["WSG4049"][1];
		Next_Page = "WSG5059";
		Next_Title = AtlasLoot_TableNames["WSG5059"][1];
		Prev_Page = "WSG3039";
		Prev_Title = AtlasLoot_TableNames["WSG3039"][1];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["WSG5059"] = {
		Title = AtlasLoot_TableNames["WSG5059"][1];
		Next_Page = "WSG60";
		Next_Title = AtlasLoot_TableNames["WSG60"][1];
		Prev_Page = "WSG4049";
		Prev_Title = AtlasLoot_TableNames["WSG4049"][1];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["WSG60"] = {
		Title = AtlasLoot_TableNames["WSG60"][1];
		Prev_Page = "WSG5059";
		Prev_Title = AtlasLoot_TableNames["WSG5059"][1];
		Back_Page = "WSGMENU";
		Back_Title = BabbleZone["Warsong Gulch"];
		};
	["PvP60Accessories1"] = {
		Title = AL["PvP Accessories"]..": "..AL["Level 60"];
		Next_Page = "PvP60Accessories2";
		Next_Title = AtlasLoot_TableNames["PvP60Accessories2"][1];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["PvP60Accessories2"] = {
		Title = AtlasLoot_TableNames["PvP60Accessories2"][1];
		Next_Page = "PvP60Accessories3";
		Next_Title = AtlasLoot_TableNames["PvP60Accessories3"][1];
		Prev_Page = "PvP60Accessories1";
		Prev_Title = AL["PvP Accessories"]..": "..AL["Level 60"];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["PvP60Accessories3"] = {
		Title = AtlasLoot_TableNames["PvP60Accessories3"][1];
		Prev_Page = "PvP60Accessories2";
		Prev_Title = AtlasLoot_TableNames["PvP60Accessories2"][1];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["PvP70Accessories1"] = {
		Title = AL["PvP Accessories"]..": "..AL["Level 70"];
		Next_Page = "PvP70Accessories2";
		Next_Title = AL["PvP Accessories"]..": "..AL["Level 70"];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["PvP70Accessories2"] = {
		Title = AL["PvP Accessories"]..": "..AL["Level 70"];
		Prev_Page = "PvP70Accessories1";
		Prev_Title = AL["PvP Accessories"]..": "..AL["Level 70"];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["PVPWeapons1"] = {
		Title = AL["PvP Weapons"]..": "..AL["Level 60"];
		Next_Page = "PVPWeapons2";
		Next_Title = AL["PvP Weapons"]..": "..AL["Level 60"];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["PVPWeapons2"] = {
		Title = AL["PvP Weapons"]..": "..AL["Level 60"];
		Prev_Page = "PVPWeapons1";
		Prev_Title = AL["PvP Weapons"]..": "..AL["Level 60"];
		Back_Page = "HONORMENU";
		Back_Title = AL["PvP Honor System"];
		};
	["Arena2Weapons1"] = {
		Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
		Next_Page = "Arena2Weapons2";
		Next_Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
		Back_Page = "ARENAMENU";
		Back_Title = AL["Arena PvP System"];
		};
	["Arena2Weapons2"] = {
		Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
		Prev_Page = "Arena2Weapons1";
		Prev_Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
		Back_Page = "ARENAMENU";
		Back_Title = AL["Arena PvP System"];
		};
	["Arena3Weapons1"] = {
		Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
		Next_Page = "Arena3Weapons2";
		Next_Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
		Back_Page = "ARENAMENU";
		Back_Title = AL["Arena PvP System"];
		};
	["Arena3Weapons2"] = {
		Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
		Prev_Page = "Arena3Weapons1";
		Prev_Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
		Back_Page = "ARENAMENU";
		Back_Title = AL["Arena PvP System"];
		};
	["Arena4Weapons1"] = {
		Title = AL["Arena PvP Weapons"]..": "..AL["Season 4"];
		Next_Page = "Arena4Weapons2";
		Next_Title = AL["Arena PvP Weapons"]..": "..AL["Season 4"];
		Back_Page = "ARENAMENU";
		Back_Title = AL["Arena PvP System"];
		};
	["Arena4Weapons2"] = {
		Title = AL["Arena PvP Weapons"]..": "..AL["Season 4"];
		Prev_Page = "Arena4Weapons1";
		Prev_Title = AL["Arena PvP Weapons"]..": "..AL["Season 4"];
		Back_Page = "ARENAMENU";
		Back_Title = AL["Arena PvP System"];
		};
	["PvP70NonSet1"] = {
		Title = AtlasLoot_TableNames["PvP70NonSet1"][1];
		Next_Page = "PvP70NonSet2";
		Next_Title = AtlasLoot_TableNames["PvP70NonSet2"][1];
		Back_Page = "PVP70NONSETEPICS";
		Back_Title = AL["PvP Non-Set Epics"];
		};
	["PvP70NonSet2"] = {
		Title = AtlasLoot_TableNames["PvP70NonSet2"][1];
		Next_Page = "PvP70NonSet3";
		Next_Title = AtlasLoot_TableNames["PvP70NonSet3"][1];
		Prev_Page = "PvP70NonSet1";
		Prev_Title = AtlasLoot_TableNames["PvP70NonSet1"][1];
		Back_Page = "PVP70NONSETEPICS";
		Back_Title = AL["PvP Non-Set Epics"];
		};
	["PvP70NonSet3"] = {
		Title = AtlasLoot_TableNames["PvP70NonSet3"][1];
		Next_Page = "PvP70NonSet4";
		Next_Title = AtlasLoot_TableNames["PvP70NonSet4"][1];
		Prev_Page = "PvP70NonSet2";
		Prev_Title = AtlasLoot_TableNames["PvP70NonSet2"][1];
		Back_Page = "PVP70NONSETEPICS";
		Back_Title = AL["PvP Non-Set Epics"];
		};
	["PvP70NonSet4"] = {
		Title = AtlasLoot_TableNames["PvP70NonSet4"][1];
		Next_Page = "PvP70NonSet5";
		Next_Title = AtlasLoot_TableNames["PvP70NonSet5"][1];
		Prev_Page = "PvP70NonSet3";
		Prev_Title = AtlasLoot_TableNames["PvP70NonSet3"][1];
		Back_Page = "PVP70NONSETEPICS";
		Back_Title = AL["PvP Non-Set Epics"];
		};
	["PvP70NonSet5"] = {
		Title = AtlasLoot_TableNames["PvP70NonSet5"][1];
		Prev_Page = "PvP70NonSet4";
		Prev_Title = AtlasLoot_TableNames["PvP70NonSet4"][1];
		Back_Page = "PVP70NONSETEPICS";
		Back_Title = AL["PvP Non-Set Epics"];
		};

  --WorldPvP
	["Hellfire"] = {
		Title = BabbleZone["Hellfire Peninsula"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["Zangarmarsh"] = {
		Title = BabbleZone["Zangarmarsh"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["Nagrand1"] = {
		Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
		Next_Page = "Nagrand2";
		Next_Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["Nagrand2"] = {
		Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
		Prev_Page = "Nagrand1";
		Prev_Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
	["Terokkar"] = {
		Title = BabbleZone["Terokkar Forest"];
		Back_Page = "PVPMENU";
		Back_Title = AL["PvP Rewards"];
		};
  --PvP Armor Sets
	["PVPDruid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPHunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPMage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPPaladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPPriest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPRogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPShaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPWarlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVPWarrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "PVPSET";
		Back_Title = AL["PvP Armor Sets"];
		};
	["PVP70RepDruid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepHunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepMage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepPaladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepPriest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepRogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepShaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepWarlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["PVP70RepWarrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "PVP70RepSET";
		Back_Title = AL["PvP Reputation Sets"];
		};
	["ArenaDruid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaHunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaMage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaPaladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaPriest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaRogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaShaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaWarlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["ArenaWarrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "ARENASET";
		Back_Title = AL["Arena PvP Sets"];
		};
	["Arena2Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena2Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "ARENA2SET";
		Back_Title = AL["Arena 2 PvP Sets"];
		};
	["Arena3Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena3Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "ARENA3SET";
		Back_Title = AL["Arena 3 PvP Sets"];
		};
	["Arena4Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
	["Arena4Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "ARENA4SET";
		Back_Title = AL["Arena 4 PvP Sets"];
		};
  --Dungeon Armor Sets
	["T0Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["T0Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "T0SET";
		Back_Title = AL["Dungeon 1/2 Sets"];
		};
	["DS3Cloth"] = {
		Title = AL["Dungeon Set 3"].." - "..BabbleInventory["Cloth"];
		Back_Page = "DS3SET";
		Back_Title = AL["Dungeon 3 Sets"];
		};
	["DS3Leather"] = {
		Title = AL["Dungeon Set 3"].." - "..BabbleInventory["Leather"];
		Back_Page = "DS3SET";
		Back_Title = AL["Dungeon 3 Sets"];
		};
	["DS3Mail"] = {
		Title = AL["Dungeon Set 3"].." - "..BabbleInventory["Mail"];
		Back_Page = "DS3SET";
		Back_Title = AL["Dungeon 3 Sets"];
		};
	["DS3Plate"] = {
		Title = AL["Dungeon Set 3"].." - "..BabbleInventory["Plate"];
		Back_Page = "DS3SET";
		Back_Title = AL["Dungeon 3 Sets"];
		};
  --Tier Armor Sets
	["T1T2Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T1T2Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "T1T2SET";
		Back_Title = AL["Tier 1/2 Sets"];
		};
	["T3Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T3Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "T3SET";
		Back_Title = AL["Tier 3 Sets"];
		};
	["T4Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T4Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "T4SET";
		Back_Title = AL["Tier 4 Sets"];
		};
	["T5Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T5Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "T5SET";
		Back_Title = AL["Tier 5 Sets"];
		};
	["T6Druid"] = {
		Title = BabbleClass["Druid"];
		Next_Page = "T6Druid2";
		Next_Title = BabbleClass["Druid"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Druid2"] = {
		Title = BabbleClass["Druid"];
		Prev_Page = "T6Druid";
		Prev_Title = BabbleClass["Druid"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Paladin"] = {
		Title = BabbleClass["Paladin"];
		Next_Page = "T6Paladin2";
		Next_Title = BabbleClass["Paladin"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Paladin2"] = {
		Title = BabbleClass["Paladin"];
		Prev_Page = "T6Paladin";
		Prev_Title = BabbleClass["Paladin"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Shaman"] = {
		Title = BabbleClass["Shaman"];
		Next_Page = "T6Shaman2";
		Next_Title = BabbleClass["Shaman"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Shaman2"] = {
		Title = BabbleClass["Shaman"];
		Prev_Page = "T6Shaman";
		Prev_Title = BabbleClass["Shaman"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
	["T6Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "T6SET";
		Back_Title = AL["Tier 6 Sets"];
		};
  --AQ40 Armor Sets
	["AQ40Sets1"] = {
		Title = AL["Temple of Ahn'Qiraj Sets"];
		Next_Page = "AQ40Sets2";
		Next_Title = AL["Temple of Ahn'Qiraj Sets"];
		Back_Page = "SETMENU";
		};
	["AQ40Sets2"] = {
		Title = AL["Temple of Ahn'Qiraj Sets"];
		Next_Page = "AQ40Sets3";
		Next_Title = AL["Temple of Ahn'Qiraj Sets"];
		Prev_Page = "AQ40Sets1";
		Prev_Title = AL["Temple of Ahn'Qiraj Sets"];
		Back_Page = "SETMENU";
		};
	["AQ40Sets3"] = {
		Title = AL["Temple of Ahn'Qiraj Sets"];
		Prev_Page = "AQ40Sets2";
		Prev_Title = AL["Temple of Ahn'Qiraj Sets"];
		Back_Page = "SETMENU";
		};
	["AQ40Druid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Hunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Mage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Paladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Priest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Rogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Shaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Warlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
	["AQ40Warrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "AQ40SET";
		Back_Title = AL["Temple of Ahn'Qiraj Sets"];
		};
  --AQ20 Armor Sets
	["AQ20Sets1"] = {
		Title = AL["Ruins of Ahn'Qiraj Sets"];
		Next_Page = "AQ20Sets2";
		Next_Title = AL["Ruins of Ahn'Qiraj Sets"];
		Back_Page = "SETMENU";
		};
	["AQ20Sets2"] = {
		Title = AL["Ruins of Ahn'Qiraj Sets"];
		Prev_Page = "AQ20Sets1";
		Prev_Title = AL["Ruins of Ahn'Qiraj Sets"];
		Back_Page = "SETMENU";
		};
  --ZG Armor Sets
	["ZGDruid"] = {
		Title = BabbleClass["Druid"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGHunter"] = {
		Title = BabbleClass["Hunter"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGMage"] = {
		Title = BabbleClass["Mage"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGPaladin"] = {
		Title = BabbleClass["Paladin"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGPriest"] = {
		Title = BabbleClass["Priest"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGRogue"] = {
		Title = BabbleClass["Rogue"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGShaman"] = {
		Title = BabbleClass["Shaman"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGWarlock"] = {
		Title = BabbleClass["Warlock"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
	["ZGWarrior"] = {
		Title = BabbleClass["Warrior"];
		Back_Page = "ZGSET";
		Back_Title = AL["Zul'Gurub Sets"];
		};
  --Vanilla WoW Armor Sets
	["VWOWDeadmines"] = {
		Title = AL["Defias Leather"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWWailingC"] = {
		Title = AL["Embrace of the Viper"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWScarletM"] = {
		Title = AL["Chain of the Scarlet Crusade"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWBlackrockD"] = {
		Title = AL["The Gladiator"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWIronweave"] = {
		Title = AL["Ironweave Battlesuit"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWScholo"] = {
		Title = BabbleZone["Scholomance"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWStrat"] = {
		Title = AL["The Postmaster"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWScourgeInvasion"] = {
		Title = AL["Scourge Invasion"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWShardOfGods"] = {
		Title = AL["Shard of the Gods"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWZulGurub"] = {
		Title = BabbleZone["Zul'Gurub"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWSpiritofEskhandar"] = {
		Title = AL["Spirit of Eskhandar"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWDalRend"] = {
		Title = AL["Dal'Rend's Arms"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
	["VWOWSpiderKiss"] = {
		Title = AL["Spider's Kiss"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
  --The Burning Crusade WoW Armor Sets
	["TBCSets"] = {
		Title = AL["Burning Crusade"];
		Back_Page = "PRE60SET";
		Back_Title = AL["Pre 60 Sets"];
		};
  --Blacksmithing Plate Sets
	["ImperialPlate"] = {
		Title = AL["Imperial Plate"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["TheDarksoul"] = {
		Title = AL["The Darksoul"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["FelIronPlate"] = {
		Title = AL["Fel Iron Plate"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["AdamantiteB"] = {
		Title = AL["Adamantite Battlegear"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["FlameG"] = {
		Title = AL["Flame Guard"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["EnchantedAdaman"] = {
		Title = AL["Enchanted Adamantite Armor"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["KhoriumWard"] = {
		Title = AL["Khorium Ward"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["FaithFelsteel"] = {
		Title = AL["Faith in Felsteel"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["BurningRage"] = {
		Title = AL["Burning Rage"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
  --Blacksmithing Mail Sets
	["BloodsoulEmbrace"] = {
		Title = AL["Bloodsoul Embrace"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["FelIronChain"] = {
		Title = AL["Fel Iron Chain"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
  --Tailoring Sets
	["BloodvineG"] = {
		Title = AL["Bloodvine Garb"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["NeatherVest"] = {
		Title = AL["Netherweave Vestments"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["ImbuedNeather"] = {
		Title = AL["Imbued Netherweave"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["ArcanoVest"] = {
		Title = AL["Arcanoweave Vestments"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["TheUnyielding"] = {
		Title = AL["The Unyielding"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["WhitemendWis"] = {
		Title = AL["Whitemend Wisdom"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["SpellstrikeInfu"] = {
		Title = AL["Spellstrike Infusion"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["BattlecastG"] = {
		Title = AL["Battlecast Garb"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["SoulclothEm"] = {
		Title = AL["Soulcloth Embrace"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["PrimalMoon"] = {
		Title = AL["Primal Mooncloth"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["ShadowEmbrace"] = {
		Title = AL["Shadow's Embrace"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
	["SpellfireWrath"] = {
		Title = AL["Wrath of Spellfire"];
		Back_Page = "CRAFTSET";
		Back_Title = AL["Crafted Sets"];
		};
  --Leatherworking Sets
	["VolcanicArmor"] = {
		Title = AL["Volcanic Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["IronfeatherArmor"] = {
		Title = AL["Ironfeather Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["StormshroudArmor"] = {
		Title = AL["Stormshroud Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["DevilsaurArmor"] = {
		Title = AL["Devilsaur Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["BloodTigerH"] = {
		Title = AL["Blood Tiger Harness"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["PrimalBatskin"] = {
		Title = AL["Primal Batskin"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["WildDraenishA"] = {
		Title = AL["Wild Draenish Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["ThickDraenicA"] = {
		Title = AL["Thick Draenic Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["FelSkin"] = {
		Title = AL["Fel Skin"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["SClefthoof"] = {
		Title = AL["Strength of the Clefthoof"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["GreenDragonM"] = {
		Title = AL["Green Dragon Mail"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["BlueDragonM"] = {
		Title = AL["Blue Dragon Mail"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["BlackDragonM"] = {
		Title = AL["Black Dragon Mail"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["ScaledDraenicA"] = {
		Title = AL["Scaled Draenic Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["FelscaleArmor"] = {
		Title = AL["Felscale Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["FelstalkerArmor"] = {
		Title = AL["Felstalker Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["NetherFury"] = {
		Title = AL["Fury of the Nether"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["PrimalIntent"] = {
		Title = AL["Primal Intent"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["WindhawkArmor"] = {
		Title = AL["Windhawk Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["NetherscaleArmor"] = {
		Title = AL["Netherscale Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
	["NetherstrikeArmor"] = {
		Title = AL["Netherstrike Armor"];
		Back_Page = "CRAFTSET2";
		Back_Title = AL["Crafted Sets"];
		};
  --Lvl 70 Instance Token Rewards
	["HardModeCloth"] = {
		Title = AtlasLoot_TableNames["HardModeCloth"][1];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeLeather"] = {
		Title = AtlasLoot_TableNames["HardModeLeather"][1];
		Next_Page = "HardModeLeather2";
		Next_Title = AL["Badge of Justice Rewards"].." - "..BabbleInventory["Leather"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeLeather2"] = {
		Title = AtlasLoot_TableNames["HardModeLeather2"][1];
		Prev_Page = "HardModeLeather";
		Prev_Title = AL["Badge of Justice Rewards"].." - "..BabbleInventory["Leather"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeMail"] = {
		Title = AtlasLoot_TableNames["HardModeMail"][1];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModePlate"] = {
		Title = AtlasLoot_TableNames["HardModePlate"][1];
		Next_Page = "HardModePlate2";
		Next_Title = AL["Badge of Justice Rewards"].." - "..BabbleInventory["Plate"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModePlate2"] = {
		Title = AtlasLoot_TableNames["HardModePlate2"][1];
		Prev_Page = "HardModePlate";
		Prev_Title = AL["Badge of Justice Rewards"].." - "..BabbleInventory["Plate"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeCloaks"] = {
		Title = AtlasLoot_TableNames["HardModeCloaks"][1];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeResist"] = {
		Title = AtlasLoot_TableNames["HardModeResist"][1];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeAccessories"] = {
		Title = AtlasLoot_TableNames["HardModeAccessories"][1];
		Next_Page = "HardModeAccessories2";
		Next_Title = AL["Badge of Justice Rewards"].." - "..AL["Accessories"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeAccessories2"] = {
		Title = AtlasLoot_TableNames["HardModeAccessories2"][1];
		Prev_Page = "HardModeAccessories";
		Prev_Title = AL["Badge of Justice Rewards"].." - "..AL["Accessories"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeRelic"] = {
		Title = AtlasLoot_TableNames["HardModeRelic"][1];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeWeapons"] = {
		Title = AtlasLoot_TableNames["HardModeWeapons"][1];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeArena"] = {
		Title = AtlasLoot_TableNames["HardModeAccessories"][1];
		Next_Page = "HardModeArena2";
		Next_Title = AL["Badge of Justice Rewards"].." - "..AL["Arena Reward"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
	["HardModeArena2"] = {
		Title = AtlasLoot_TableNames["HardModeAccessories"][1];
		Prev_Page = "HardModeArena";
		Prev_Title = AL["Badge of Justice Rewards"].." - "..AL["Arena Reward"];
		Back_Page = "70TOKENMENU";
		Back_Title = AL["Badge of Justice Rewards"];
		};
  --Misc Collections
	["CardGame1"] = {
		Title = AL["Upper Deck Card Game Items"];
		Next_Page = "CardGame2";
		Next_Title = AL["Upper Deck Card Game Items"];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["CardGame2"] = {
		Title = AL["Upper Deck Card Game Items"];
		Prev_Page = "CardGame1";
		Prev_Title = AL["Upper Deck Card Game Items"];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["CraftedWeapons1"] = {
		Title = AL["Crafted Epic Weapons"];
		Next_Page = "CraftedWeapons2";
		Next_Title = AL["Crafted Epic Weapons"];
		Back_Page = "CRAFTINGMENU";
		Back_Title = AL["Collections"];
		};
	["CraftedWeapons2"] = {
		Title = AL["Crafted Epic Weapons"];
		Prev_Page = "CraftedWeapons1";
		Prev_Title = AL["Crafted Epic Weapons"];
		Back_Page = "CRAFTINGMENU";
		Back_Title = AL["Collections"];
		};
	["Legendaries"] = {
		Title = AL["Legendary Items"];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["RareMounts1"] = {
		Title = AtlasLoot_TableNames["RareMounts1"][1];
		Next_Page = "RareMounts2";
		Next_Title = AtlasLoot_TableNames["RareMounts2"][1];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["RareMounts2"] = {
		Title = AtlasLoot_TableNames["RareMounts2"][1];
		Prev_Page = "RareMounts1";
		Prev_Title = AtlasLoot_TableNames["RareMounts1"][1];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["Tabards1"] = {
		Title = AtlasLoot_TableNames["Tabards1"][1];
		Next_Page = "Tabards2";
		Next_Title = AtlasLoot_TableNames["Tabards2"][1];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["Tabards2"] = {
		Title = AtlasLoot_TableNames["Tabards2"][1];
		Prev_Page = "Tabards1";
		Prev_Title = AtlasLoot_TableNames["Tabards1"][1];
		Back_Page = "SETMENU";
		Back_Title = AL["Collections"];
		};
	["WorldEpics1"] = {
		Title = AtlasLoot_TableNames["WorldEpics1"][1];
		Next_Page = "WorldEpics2";
		Next_Title = AtlasLoot_TableNames["WorldEpics2"][1];
		Back_Page = "WORLDEPICS";
		Back_Title = AL["BoE World Epics"];
		};
	["WorldEpics2"] = {
		Title = AtlasLoot_TableNames["WorldEpics2"][1];
		Next_Page = "WorldEpics3";
		Next_Title = AtlasLoot_TableNames["WorldEpics3"][1];
		Prev_Page = "WorldEpics1";
		Prev_Title = AtlasLoot_TableNames["WorldEpics1"][1];
		Back_Page = "WORLDEPICS";
		Back_Title = AL["BoE World Epics"];
		};
	["WorldEpics3"] = {
		Title = AtlasLoot_TableNames["WorldEpics3"][1];
		Next_Page = "WorldEpics4";
		Next_Title = AtlasLoot_TableNames["WorldEpics4"][1];
		Prev_Page = "WorldEpics2";
		Prev_Title = AtlasLoot_TableNames["WorldEpics2"][1];
		Back_Page = "WORLDEPICS";
		Back_Title = AL["BoE World Epics"];
		};
	["WorldEpics4"] = {
		Title = AtlasLoot_TableNames["WorldEpics4"][1];
		Prev_Page = "WorldEpics3";
		Prev_Title = AtlasLoot_TableNames["WorldEpics3"][1];
		Back_Page = "WORLDEPICS";
		Back_Title = AL["BoE World Epics"];
		};
  --Misc
	["ZGTrash1"] = {
		Title = AtlasLoot_TableNames["ZGTrash1"][1];
		Next_Page = "ZGTrash2";
		Next_Title = AtlasLoot_TableNames["ZGTrash2"][1];
		};
	["ZGTrash2"] = {
		Title = AtlasLoot_TableNames["ZGTrash2"][1];
		Prev_Page = "ZGTrash1";
		Prev_Title = AtlasLoot_TableNames["ZGTrash1"][1];
		};
	["AQ40Trash1"] = {
		Title = AtlasLoot_TableNames["AQ40Trash1"][1];
		Next_Page = "AQ40Trash2";
		Next_Title = AtlasLoot_TableNames["AQ40Trash2"][1];
		};
	["AQ40Trash2"] = {
		Title = AtlasLoot_TableNames["AQ40Trash2"][1];
		Prev_Page = "AQ40Trash1";
		Prev_Title = AtlasLoot_TableNames["AQ40Trash1"][1];
		};
  --Season Events
	["Brewfest1"] = {
		Title = AL["Brewfest"];
		Next_Page = "Brewfest2";
		Next_Title = AL["Brewfest"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Brewfest2"] = {
		Title = AL["Brewfest"];
		Next_Page = "CorenDirebrew";
		Next_Title = AtlasLoot_TableNames["CorenDirebrew"][1];
		Prev_Page = "Brewfest1";
		Prev_Title = AL["Brewfest"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["CorenDirebrew"] = {
		Title = AL["Coren Direbrew"];
		Prev_Page = "Brewfest2";
		Prev_Title = AL["Brewfest"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["ChildrensWeek"] = {
		Title = AL["Children's Week"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Winterviel1"] = {
		Title = AL["Feast of Winter Veil"];
		Next_Page = "Winterviel2";
		Next_Title = AtlasLoot_TableNames["Winterviel2"][1];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Winterviel2"] = {
		Title = AtlasLoot_TableNames["Winterviel2"][1];
		Prev_Page = "Winterviel1";
		Prev_Title = AL["Feast of Winter Veil"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Halloween1"] = {
		Title = AL["Hallow's End"];
		Next_Page = "Halloween2";
		Next_Title = AL["Hallow's End"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Halloween2"] = {
		Title = AL["Hallow's End"];
		Next_Page = "HeadlessHorseman";
		Next_Title = AL["Headless Horseman"];
		Prev_Page = "Halloween1";
		Prev_Title = AL["Hallow's End"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["HeadlessHorseman"] = {
		Title = AL["Headless Horseman"];
		Prev_Page = "Halloween2";
		Prev_Title = AL["Hallow's End"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["HarvestFestival"] = {
		Title = AL["Harvest Festival"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Valentineday"] = {
		Title = AL["Love is in the Air"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["LunarFestival1"] = {
		Title = AL["Lunar Festival"];
		Next_Page = "LunarFestival2";
		Next_Title = AL["Lunar Festival"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["LunarFestival2"] = {
		Title = AL["Lunar Festival"];
		Prev_Page = "LunarFestival1";
		Prev_Title = AL["Lunar Festival"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["MidsummerFestival"] = {
		Title = AL["Midsummer Fire Festival"];
		Next_Page = "LordAhune";
		Next_Title = AL["Lord Ahune"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["LordAhune"] = {
		Title = AL["Lord Ahune"];
		Prev_Page = "MidsummerFestival";
		Prev_Title = AL["Midsummer Fire Festival"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
    ["LordAhuneHEROIC"] = {
		Title = AL["Lord Ahune"];
		Prev_Page = "MidsummerFestival";
		Prev_Title = AL["Midsummer Fire Festival"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Noblegarden"] = {
		Title = AL["Noblegarden"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	--World Events
	["BashirLanding"] = {
		Title = AL["Bash'ir Landing Skyguard Raid"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["ElementalInvasion"] = {
		Title = AL["Elemental Invasion"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["GurubashiArena"] = {
		Title = AL["Gurubashi Arena Booty Run"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["Shartuul"] = {
		Title = AL["Shartuul"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["ScourgeInvasionEvent1"] = {
		Title = AL["Scourge Invasion"];
		Next_Page = "ScourgeInvasionEvent2";
		Next_Title = AtlasLoot_TableNames["ScourgeInvasionEvent2"][1];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["ScourgeInvasionEvent2"] = {
		Title = AtlasLoot_TableNames["ScourgeInvasionEvent2"][1];
		Prev_Page = "ScourgeInvasionEvent1";
		Prev_Title = AL["Scourge Invasion"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
	["FishingExtravaganza"] = {
		Title = AL["Stranglethorn Fishing Extravaganza"];
		Back_Page = "WORLDEVENTMENU";
		Back_Title = AL["World Events"];
		};
  --Abyssal Counci
	["Templars"] = {
		Title = AL["Abyssal Council"].." - "..AL["Templars"];
		Back_Page = "ABYSSALMENU";
		Back_Title = AL["Abyssal Council"];
		};
	["Dukes"] = {
		Title = AL["Abyssal Council"].." - "..AL["Dukes"];
		Back_Page = "ABYSSALMENU";
		Back_Title = AL["Abyssal Council"];
		};
	["HighCouncil"] = {
		Title = AL["Abyssal Council"].." - "..AL["High Council"];
		Back_Page = "ABYSSALMENU";
		Back_Title = AL["Abyssal Council"];
		};
  --Ethereum Prison
	["ArmbreakerHuffaz"] = {
		Title = AL["Armbreaker Huffaz"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["FelTinkererZortan"] = {
		Title = AL["Fel Tinkerer Zortan"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["Forgosh"] = {
		Title = AL["Forgosh"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["Gulbor"] = {
		Title = AL["Gul'bor"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["MalevustheMad"] = {
		Title = AL["Malevus the Mad"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["PorfustheGemGorger"] = {
		Title = AL["Porfus the Gem Gorger"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["WrathbringerLaztarash"] = {
		Title = AL["Wrathbringer Laz-tarash"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
	["BashirStasisChambers"] = {
		Title = AL["Bash'ir Landing Stasis Chambers"];
		Back_Page = "ETHEREUMMENU";
		Back_Title = AL["Ethereum Prison"];
		};
  --Skettis
	["DarkscreecherAkkarai"] = {
		Title = AL["Darkscreecher Akkarai"];
		Back_Page = "SKETTISMENU";
		Back_Title = AL["Skettis"];
		};
	["Karrog"] = {
		Title = AL["Karrog"];
		Back_Page = "SKETTISMENU";
		Back_Title = AL["Skettis"];
		};
	["GezzaraktheHuntress"] = {
		Title = AL["Gezzarak the Huntress"];
		Back_Page = "SKETTISMENU";
		Back_Title = AL["Skettis"];
		};
	["VakkiztheWindrager"] = {
		Title = AL["Vakkiz the Windrager"];
		Back_Page = "SKETTISMENU";
		Back_Title = AL["Skettis"];
		};
	["Terokk"] = {
		Title = AL["Terokk"];
		Back_Page = "SKETTISMENU";
		Back_Title = AL["Skettis"];
		};
	--Alchemy
	["AlchemyApprentice1"] = {
		Title = ALCHEMY..": "..APPRENTICE;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyJourneyman1";
		Next_Title = ALCHEMY..": "..JOURNEYMAN;
		};
	["AlchemyJourneyman1"] = {
		Title = ALCHEMY..": "..JOURNEYMAN;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyExpert1";
		Next_Title = ALCHEMY..": "..EXPERT;
		Prev_Page = "AlchemyApprentice1";
		Prev_Title = ALCHEMY..": "..APPRENTICE;
		};
	["AlchemyExpert1"] = {
		Title = ALCHEMY..": "..EXPERT;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyArtisan1";
		Next_Title = ALCHEMY..": "..ARTISAN;
		Prev_Page = "AlchemyJourneyman1";
		Prev_Title = ALCHEMY..": "..JOURNEYMAN;
		};
	["AlchemyArtisan1"] = {
		Title = ALCHEMY..": "..ARTISAN;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyArtisan2";
		Next_Title = ALCHEMY..": "..ARTISAN;
		Prev_Page = "AlchemyExpert1";
		Prev_Title = ALCHEMY..": "..EXPERT;
		};
	["AlchemyArtisan2"] = {
		Title = ALCHEMY..": "..ARTISAN;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyMaster1";
		Next_Title = ALCHEMY..": "..MASTER;
		Prev_Page = "AlchemyArtisan1";
		Prev_Title = ALCHEMY..": "..ARTISAN;
		};
	["AlchemyMaster1"] = {
		Title = ALCHEMY..": "..MASTER;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyMaster2";
		Next_Title = ALCHEMY..": "..MASTER;
		Prev_Page = "AlchemyArtisan2";
		Prev_Title = ALCHEMY..": "..ARTISAN;
		};
	["AlchemyMaster2"] = {
		Title = ALCHEMY..": "..MASTER;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyMaster3";
		Next_Title = ALCHEMY..": "..MASTER;
		Prev_Page = "AlchemyMaster1";
		Prev_Title = ALCHEMY..": "..MASTER;
		};
	["AlchemyMaster3"] = {
		Title = ALCHEMY..": "..MASTER;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Next_Page = "AlchemyMaster4";
		Next_Title = ALCHEMY..": "..MASTER;
		Prev_Page = "AlchemyMaster2";
		Prev_Title = ALCHEMY..": "..MASTER;
		};
	["AlchemyMaster4"] = {
		Title = ALCHEMY..": "..MASTER;
		Back_Page = "ALCHEMYMENU";
		Back_Title = ALCHEMY;
		Prev_Page = "AlchemyMaster3";
		Prev_Title = ALCHEMY..": "..MASTER;
		};
	--BlackSmithing
	["SmithingApprentice1"] = {
		Title = BLACKSMITHING..": "..APPRENTICE;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Next_Page = "SmithingJourneyman1";
		Next_Title = BLACKSMITHING..": "..JOURNEYMAN;
		};
	["SmithingJourneyman1"] = {
		Title = BLACKSMITHING..": "..JOURNEYMAN;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingApprentice1";
		Prev_Title = BLACKSMITHING..": "..APPRENTICE;
		Next_Page = "SmithingExpert1";
		Next_Title = BLACKSMITHING..": "..EXPERT;
		};
	["SmithingExpert1"] = {
		Title = BLACKSMITHING..": "..EXPERT;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingJourneyman1";
		Prev_Title = BLACKSMITHING..": "..JOURNEYMAN;
		Next_Page = "SmithingExpert2";
		Next_Title = BLACKSMITHING..": "..EXPERT;
		};
	["SmithingExpert2"] = {
		Title = BLACKSMITHING..": "..EXPERT;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingExpert1";
		Prev_Title = BLACKSMITHING..": "..EXPERT;
		Next_Page = "SmithingArtisan1";
		Next_Title = BLACKSMITHING..": "..ARTISAN;
		};
	["SmithingArtisan1"] = {
		Title = BLACKSMITHING..": "..ARTISAN;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingExpert2";
		Prev_Title = BLACKSMITHING..": "..EXPERT;
		Next_Page = "SmithingArtisan2";
		Next_Title = BLACKSMITHING..": "..ARTISAN;
		};
	["SmithingArtisan2"] = {
		Title = BLACKSMITHING..": "..ARTISAN;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingArtisan1";
		Prev_Title = BLACKSMITHING..": "..ARTISAN;
		Next_Page = "SmithingMaster1";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster1"] = {
		Title = BLACKSMITHING..": "..ARTISAN;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingArtisan2";
		Prev_Title = BLACKSMITHING..": "..ARTISAN;
		Next_Page = "SmithingMaster2";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster2"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster1";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "SmithingMaster3";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster3"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster2";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "SmithingMaster4";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster4"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster3";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "SmithingMaster5";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster5"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster4";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "SmithingMaster6";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster6"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster5";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "SmithingMaster7";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster7"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster6";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "SmithingMaster8";
		Next_Title = BLACKSMITHING..": "..MASTER;
		};
	["SmithingMaster8"] = {
		Title = BLACKSMITHING..": "..MASTER;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster7";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "Armorsmith1";
		Next_Title = ARMORSMITH;
		};
	["Armorsmith1"] = {
		Title = ARMORSMITH;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "SmithingMaster8";
		Prev_Title = BLACKSMITHING..": "..MASTER;
		Next_Page = "Weaponsmith1";
		Next_Title = WEAPONSMITH;
		};
	["Weaponsmith1"] = {
		Title = WEAPONSMITH;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "Armorsmith1";
		Prev_Title = ARMORSMITH;
		Next_Page = "Axesmith1";
		Next_Title = AXESMITH;
		};
	["Axesmith1"] = {
		Title = AXESMITH;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "Weaponsmith1";
		Prev_Title = WEAPONSMITH;
		Next_Page = "Hammersmith1";
		Next_Title = HAMMERSMITH;
		};
	["Hammersmith1"] = {
		Title = HAMMERSMITH;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "Axesmith1";
		Prev_Title = AXESMITH;
		Next_Page = "Swordsmith1";
		Next_Title = SWORDSMITH;
		};
	["Swordsmith1"] = {
		Title = SWORDSMITH;
		Back_Page = "SMITHINGMENU";
		Back_Title = BLACKSMITHING;
		Prev_Page = "Hammersmith1";
		Prev_Title = HAMMERSMITH;
		};
	--Enchanting
	["EnchantingApprentice1"] = {
		Title = ENCHANTING..": "..APPRENTICE;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Next_Page = "EnchantingJourneyman1";
		Next_Title = ENCHANTING..": "..JOURNEYMAN;
		};
	["EnchantingJourneyman1"] = {
		Title = ENCHANTING..": "..JOURNEYMAN;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingApprentice1";
		Prev_Title = ENCHANTING..": "..APPRENTICE;
		Next_Page = "EnchantingExpert1";
		Next_Title = ENCHANTING..": "..EXPERT;
		};
	["EnchantingExpert1"] = {
		Title = ENCHANTING..": "..EXPERT;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingJourneyman1";
		Prev_Title = ENCHANTING..": "..JOURNEYMAN;
		Next_Page = "EnchantingExpert2";
		Next_Title = ENCHANTING..": "..EXPERT;
		};
	["EnchantingExpert2"] = {
		Title = ENCHANTING..": "..EXPERT;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingExpert1";
		Prev_Title = ENCHANTING..": "..EXPERT;
		Next_Page = "EnchantingArtisan1";
		Next_Title = ENCHANTING..": "..ARTISAN;
		};
	["EnchantingArtisan1"] = {
		Title = ENCHANTING..": "..ARTISAN;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingExpert2";
		Prev_Title = ENCHANTING..": "..EXPERT;
		Next_Page = "EnchantingArtisan2";
		Next_Title = ENCHANTING..": "..ARTISAN;
		};
	["EnchantingArtisan2"] = {
		Title = ENCHANTING..": "..ARTISAN;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingArtisan1";
		Prev_Title = ENCHANTING..": "..ARTISAN;
		Next_Page = "EnchantingMaster1";
		Next_Title = ENCHANTING..": "..MASTER;
		};
	["EnchantingMaster1"] = {
		Title = ENCHANTING..": "..MASTER;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingArtisan2";
		Prev_Title = ENCHANTING..": "..ARTISAN;
		Next_Page = "EnchantingMaster2";
		Next_Title = ENCHANTING..": "..MASTER;
		};
	["EnchantingMaster2"] = {
		Title = ENCHANTING..": "..MASTER;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingMaster1";
		Prev_Title = ENCHANTING..": "..MASTER;
		Next_Page = "EnchantingMaster3";
		Next_Title = ENCHANTING..": "..MASTER;
		};
	["EnchantingMaster3"] = {
		Title = ENCHANTING..": "..MASTER;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingMaster2";
		Prev_Title = ENCHANTING..": "..MASTER;
		Next_Page = "EnchantingMaster4";
		Next_Title = ENCHANTING..": "..MASTER;
		};
	["EnchantingMaster4"] = {
		Title = ENCHANTING..": "..MASTER;
		Back_Page = "ENCHANTINGMENU";
		Back_Title = ENCHANTING;
		Prev_Page = "EnchantingMaster3";
		Prev_Title = ENCHANTING..": "..MASTER;
		};
	--Engineering
	["EngineeringApprentice1"] = {
		Title = ENGINEERING..": "..APPRENTICE;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Next_Page = "EngineeringJourneyman1";
		Next_Title = ENGINEERING..": "..JOURNEYMAN;
		};
	["EngineeringJourneyman1"] = {
		Title = ENGINEERING..": "..JOURNEYMAN;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringApprentice1";
		Prev_Title = ENGINEERING..": "..APPRENTICE;
		Next_Page = "EngineeringExpert1";
		Next_Title = ENGINEERING..": "..EXPERT;
		};
	["EngineeringExpert1"] = {
		Title = ENGINEERING..": "..EXPERT;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringJourneyman1";
		Prev_Title = ENGINEERING..": "..JOURNEYMAN;
		Next_Page = "EngineeringExpert2";
		Next_Title = ENGINEERING..": "..EXPERT;
		};
	["EngineeringExpert2"] = {
		Title = ENGINEERING..": "..EXPERT;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringExpert1";
		Prev_Title = ENGINEERING..": "..EXPERT;
		Next_Page = "EngineeringArtisan1";
		Next_Title = ENGINEERING..": "..ARTISAN;
		};
	["EngineeringArtisan1"] = {
		Title = ENGINEERING..": "..ARTISAN;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringExpert2";
		Prev_Title = ENGINEERING..": "..EXPERT;
		Next_Page = "EngineeringArtisan2";
		Next_Title = ENGINEERING..": "..ARTISAN;
		};
	["EngineeringArtisan2"] = {
		Title = ENGINEERING..": "..ARTISAN;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringArtisan1";
		Prev_Title = ENGINEERING..": "..ARTISAN;
		Next_Page = "EngineeringArtisan3";
		Next_Title = ENGINEERING..": "..ARTISAN;
		};
	["EngineeringArtisan3"] = {
		Title = ENGINEERING..": "..ARTISAN;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringArtisan2";
		Prev_Title = ENGINEERING..": "..ARTISAN;
		Next_Page = "EngineeringMaster1";
		Next_Title = ENGINEERING..": "..MASTER;
		};
	["EngineeringMaster1"] = {
		Title = ENGINEERING..": "..MASTER;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringArtisan3";
		Prev_Title = ENGINEERING..": "..ARTISAN;
		Next_Page = "EngineeringMaster2";
		Next_Title = ENGINEERING..": "..MASTER;
		};
	["EngineeringMaster2"] = {
		Title = ENGINEERING..": "..MASTER;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringMaster1";
		Prev_Title = ENGINEERING..": "..MASTER;
		Next_Page = "EngineeringMaster3";
		Next_Title = ENGINEERING..": "..MASTER;
		};
	["EngineeringMaster3"] = {
		Title = ENGINEERING..": "..MASTER;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringMaster2";
		Prev_Title = ENGINEERING..": "..MASTER;
		Next_Page = "EngineeringMaster4";
		Next_Title = ENGINEERING..": "..MASTER;
		};
	["EngineeringMaster4"] = {
		Title = ENGINEERING..": "..MASTER;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringMaster3";
		Prev_Title = ENGINEERING..": "..MASTER;
		Next_Page = "Gnomish1";
		Next_Title = GNOMISH;
		};
	["Gnomish1"] = {
		Title = GNOMISH;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "EngineeringMaster4";
		Prev_Title = ENGINEERING..": "..MASTER;
		Next_Page = "Goblin1";
		Next_Title = GOBLIN;
		};
	["Goblin1"] = {
		Title = GOBLIN;
		Back_Page = "ENGINEERINGMENU";
		Back_Title = ENGINEERING;
		Prev_Page = "Gnomish1";
		Prev_Title = GNOMISH;
		};
	--Jewelcrafting
	["JewelApprentice1"] = {
		Title = JEWELCRAFTING..": "..APPRENTICE;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Next_Page = "JewelJourneyman1";
		Next_Title = JEWELCRAFTING..": "..JOURNEYMAN;
		};
	["JewelJourneyman1"] = {
		Title = JEWELCRAFTING..": "..JOURNEYMAN;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelApprentice1";
		Prev_Title = JEWELCRAFTING..": "..APPRENTICE;
		Next_Page = "JewelExpert1";
		Next_Title = JEWELCRAFTING..": "..EXPERT;
		};
	["JewelExpert1"] = {
		Title = JEWELCRAFTING..": "..EXPERT;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelJourneyman1";
		Prev_Title = JEWELCRAFTING..": "..JOURNEYMAN;
		Next_Page = "JewelArtisan1";
		Next_Title = JEWELCRAFTING..": "..ARTISAN;
		};
	["JewelArtisan1"] = {
		Title = JEWELCRAFTING..": "..ARTISAN;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelExpert1";
		Prev_Title = JEWELCRAFTING..": "..EXPERT;
		Next_Page = "JewelMaster1";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster1"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelArtisan1";
		Prev_Title = JEWELCRAFTING..": "..ARTISAN;
		Next_Page = "JewelMaster2";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster2"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelMaster1";
		Prev_Title = JEWELCRAFTING..": "..MASTER;
		Next_Page = "JewelMaster3";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster3"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelMaster2";
		Prev_Title = JEWELCRAFTING..": "..MASTER;
		Next_Page = "JewelMaster4";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster4"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelMaster3";
		Prev_Title = JEWELCRAFTING..": "..MASTER;
		Next_Page = "JewelMaster5";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster5"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelMaster4";
		Prev_Title = JEWELCRAFTING..": "..MASTER;
		Next_Page = "JewelMaster6";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster6"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelMaster5";
		Prev_Title = JEWELCRAFTING..": "..MASTER;
		Next_Page = "JewelMaster7";
		Next_Title = JEWELCRAFTING..": "..MASTER;
		};
	["JewelMaster7"] = {
		Title = JEWELCRAFTING..": "..MASTER;
		Back_Page = "JEWELCRAFTINGMENU";
		Back_Title = JEWELCRAFTING;
		Prev_Page = "JewelMaster6";
		Prev_Title = JEWELCRAFTING..": "..MASTER;
		};
	--Leatherworking
	["LeatherApprentice1"] = {
		Title = LEATHERWORKING..": "..APPRENTICE;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Next_Page = "LeatherJourneyman1";
		Next_Title = LEATHERWORKING..": "..JOURNEYMAN;
		};
	["LeatherJourneyman1"] = {
		Title = LEATHERWORKING..": "..JOURNEYMAN;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherApprentice1";
		Prev_Title = LEATHERWORKING..": "..APPRENTICE;
		Next_Page = "LeatherJourneyman2";
		Next_Title = LEATHERWORKING..": "..JOURNEYMAN;
		};
	["LeatherJourneyman2"] = {
		Title = LEATHERWORKING..": "..JOURNEYMAN;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherJourneyman1";
		Prev_Title = LEATHERWORKING..": "..JOURNEYMAN;
		Next_Page = "LeatherExpert1";
		Next_Title = LEATHERWORKING..": "..EXPERT;
		};
	["LeatherExpert1"] = {
		Title = LEATHERWORKING..": "..EXPERT;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherJourneyman2";
		Prev_Title = LEATHERWORKING..": "..JOURNEYMAN;
		Next_Page = "LeatherExpert2";
		Next_Title = LEATHERWORKING..": "..EXPERT;
		};
	["LeatherExpert2"] = {
		Title = LEATHERWORKING..": "..EXPERT;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherExpert1";
		Prev_Title = LEATHERWORKING..": "..EXPERT;
		Next_Page = "LeatherArtisan1";
		Next_Title = LEATHERWORKING..": "..ARTISAN;
		};
	["LeatherArtisan1"] = {
		Title = LEATHERWORKING..": "..ARTISAN;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherExpert2";
		Prev_Title = LEATHERWORKING..": "..EXPERT;
		Next_Page = "LeatherArtisan2";
		Next_Title = LEATHERWORKING..": "..ARTISAN;
		};
	["LeatherArtisan2"] = {
		Title = LEATHERWORKING..": "..ARTISAN;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherArtisan1";
		Prev_Title = LEATHERWORKING..": "..ARTISAN;
		Next_Page = "LeatherMaster1";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster1"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherArtisan2";
		Prev_Title = LEATHERWORKING..": "..ARTISAN;
		Next_Page = "LeatherMaster2";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster2"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster1";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "LeatherMaster3";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster3"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster2";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "LeatherMaster4";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster4"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster3";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "LeatherMaster5";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster5"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster4";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "LeatherMaster6";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster6"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster5";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "LeatherMaster7";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster7"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster6";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "LeatherMaster8";
		Next_Title = LEATHERWORKING..": "..MASTER;
		};
	["LeatherMaster8"] = {
		Title = LEATHERWORKING..": "..MASTER;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster7";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "Dragonscale1";
		Next_Title = DRAGONSCALE;
		};
	["Dragonscale1"] = {
		Title = DRAGONSCALE;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "LeatherMaster8";
		Prev_Title = LEATHERWORKING..": "..MASTER;
		Next_Page = "Elemental1";
		Next_Title = ELEMENTAL;
		};
	["Elemental1"] = {
		Title = ELEMENTAL;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "Dragonscale1";
		Prev_Title = DRAGONSCALE;
		Next_Page = "Tribal1";
		Next_Title = TRIBAL;
		};
	["Tribal1"] = {
		Title = TRIBAL;
		Back_Page = "LEATHERWORKINGMENU";
		Back_Title = LEATHERWORKING;
		Prev_Page = "Elemental1";
		Prev_Title = ELEMENTAL;
		};
	--Mining
	["Mining1"] = {
		Title = MINING;
		Back_Page = "CRAFTINGMENU";
		Back_Title = AL["Crafting"];
		};
	--Tailoring
	["TailoringApprentice1"] = {
		Title = TAILORING..": "..APPRENTICE;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Next_Page = "TailoringJourneyman1";
		Next_Title = TAILORING..": "..JOURNEYMAN;
		};
	["TailoringJourneyman1"] = {
		Title = TAILORING..": "..JOURNEYMAN;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringApprentice1";
		Prev_Title = TAILORING..": "..APPRENTICE;
		Next_Page = "TailoringJourneyman2";
		Next_Title = TAILORING..": "..JOURNEYMAN;
		};
	["TailoringJourneyman2"] = {
		Title = TAILORING..": "..JOURNEYMAN;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringJourneyman1";
		Prev_Title = TAILORING..": "..JOURNEYMAN;
		Next_Page = "TailoringExpert1";
		Next_Title = TAILORING..": "..EXPERT;
		};
	["TailoringExpert1"] = {
		Title = TAILORING..": "..EXPERT;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringJourneyman2";
		Prev_Title = TAILORING..": "..JOURNEYMAN;
		Next_Page = "TailoringExpert2";
		Next_Title = TAILORING..": "..EXPERT;
		};
	["TailoringExpert2"] = {
		Title = TAILORING..": "..EXPERT;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringExpert1";
		Prev_Title = TAILORING..": "..EXPERT;
		Next_Page = "TailoringArtisan1";
		Next_Title = TAILORING..": "..ARTISAN;
		};
	["TailoringArtisan1"] = {
		Title = TAILORING..": "..ARTISAN;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringExpert2";
		Prev_Title = TAILORING..": "..EXPERT;
		Next_Page = "TailoringArtisan2";
		Next_Title = TAILORING..": "..ARTISAN;
		};
	["TailoringArtisan2"] = {
		Title = TAILORING..": "..ARTISAN;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringArtisan1";
		Prev_Title = TAILORING..": "..ARTISAN;
		Next_Page = "TailoringArtisan3";
		Next_Title = TAILORING..": "..ARTISAN;
		};
	["TailoringArtisan3"] = {
		Title = TAILORING..": "..ARTISAN;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringArtisan2";
		Prev_Title = TAILORING..": "..ARTISAN;
		Next_Page = "TailoringMaster1";
		Next_Title = TAILORING..": "..MASTER;
		};
	["TailoringMaster1"] = {
		Title = TAILORING..": "..MASTER;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringArtisan3";
		Prev_Title = TAILORING..": "..ARTISAN;
		Next_Page = "TailoringMaster2";
		Next_Title = TAILORING..": "..MASTER;
		};
	["TailoringMaster2"] = {
		Title = TAILORING..": "..MASTER;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringMaster1";
		Prev_Title = TAILORING..": "..MASTER;
		Next_Page = "TailoringMaster3";
		Next_Title = TAILORING..": "..MASTER;
		};
	["TailoringMaster3"] = {
		Title = TAILORING..": "..MASTER;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringMaster2";
		Prev_Title = TAILORING..": "..MASTER;
		Next_Page = "TailoringMaster4";
		Next_Title = TAILORING..": "..MASTER;
		};
	["TailoringMaster4"] = {
		Title = TAILORING..": "..MASTER;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringMaster3";
		Prev_Title = TAILORING..": "..MASTER;
		Next_Page = "TailoringMaster5";
		Next_Title = TAILORING..": "..MASTER;
		};
	["TailoringMaster5"] = {
		Title = TAILORING..": "..MASTER;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringMaster4";
		Prev_Title = TAILORING..": "..MASTER;
		Next_Page = "TailoringMaster6";
		Next_Title = TAILORING..": "..MASTER;
		};
	["TailoringMaster6"] = {
		Title = TAILORING..": "..MASTER;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringMaster5";
		Prev_Title = TAILORING..": "..MASTER;
		Next_Page = "Mooncloth1";
		Next_Title = MOONCLOTH;
		};
	["Mooncloth1"] = {
		Title = MOONCLOTH;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "TailoringMaster6";
		Prev_Title = TAILORING..": "..MASTER;
		Next_Page = "Shadoweave1";
		Next_Title = SHADOWEAVE;
		};
	["Shadoweave1"] = {
		Title = SHADOWEAVE;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "Mooncloth1";
		Prev_Title = MOONCLOTH;
		Next_Page = "Spellfire1";
		Next_Title = SPELLFIRE;
		};
	["Spellfire1"] = {
		Title = SPELLFIRE;
		Back_Page = "TAILORINGMENU";
		Back_Title = TAILORING;
		Prev_Page = "Shadoweave1";
		Prev_Title = SHADOWEAVE;
		};
	--Cooking
	["CookingApprentice1"] = {
		Title = COOKING..": "..APPRENTICE;
		Back_Page = "COOKINGMENU";
		Back_Title = COOKING;
		Next_Page = "CookingJourneyman1";
		Next_Title = COOKING..": "..JOURNEYMAN;
		};
	["CookingJourneyman1"] = {
		Title = COOKING..": "..JOURNEYMAN;
		Back_Page = "COOKINGMENU";
		Back_Title = COOKING;
		Prev_Page = "CookingApprentice1";
		Prev_Title = COOKING..": "..APPRENTICE;
		Next_Page = "CookingJourneyman2";
		Next_Title = COOKING..": "..JOURNEYMAN;
		};
	["CookingJourneyman2"] = {
		Title = COOKING..": "..JOURNEYMAN;
		Back_Page = "COOKINGMENU";
		Back_Title = COOKING;
		Prev_Page = "CookingJourneyman1";
		Prev_Title = COOKING..": "..JOURNEYMAN;
		Next_Page = "CookingExpert1";
		Next_Title = COOKING..": "..EXPERT;
		};
	["CookingExpert1"] = {
		Title = COOKING..": "..EXPERT;
		Back_Page = "COOKINGMENU";
		Back_Title = COOKING;
		Prev_Page = "CookingJourneyman2";
		Prev_Title = COOKING..": "..JOURNEYMAN;
		Next_Page = "CookingArtisan1";
		Next_Title = COOKING..": "..ARTISAN;
		};
	["CookingArtisan1"] = {
		Title = COOKING..": "..ARTISAN;
		Back_Page = "COOKINGMENU";
		Back_Title = COOKING;
		Prev_Page = "CookingExpert1";
		Prev_Title = COOKING..": "..EXPERT;
		Next_Page = "CookingMaster1";
		Next_Title = COOKING..": "..MASTER;
		};
	["CookingMaster1"] = {
		Title = COOKING..": "..MASTER;
		Back_Page = "COOKINGMENU";
		Back_Title = COOKING;
		Prev_Page = "CookingArtisan1";
		Prev_Title = COOKING..": "..MASTER;
		};
	--FirstAid
	["FirstAid1"] = {
		Title = FIRSTAID;
		Back_Page = "CRAFTINGMENU";
		Back_Title = AL["Crafting"];
		};
	--Sunwell Plateau
	["SPPatterns1"] = {
		Title = AL["SP Patterns/Plans"];
		Next_Page = "SPPatterns2";
		Next_Title = AL["SP Patterns/Plans"];
		};
	["SPPatterns2"] = {
		Title = AL["SP Patterns/Plans"];
		Prev_Page = "SPPatterns1";
		Prev_Title = AL["SP Patterns/Plans"];
		};
};