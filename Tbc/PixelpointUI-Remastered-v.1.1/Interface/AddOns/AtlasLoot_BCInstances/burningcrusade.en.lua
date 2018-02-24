
local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

AtlasLoot_Data["AtlasLootExpansionItems"] = {

	EmptyInstance = {};

	----------------------------
	--- Burning Crusade Keys ---
	----------------------------

	BCKeys = {
		{ 0, "INV_Box_01", "=q6=#j1#", "" },
		{ 27991, "", "=q1=Shadow Labyrinth Key", "=ds=#e9#" },
		{ 28395, "", "=q1=Shattered Halls Key", "=ds=#e9#" },
		{ 31084, "", "=q1=Key to the Arcatraz", "=ds=#e9#" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#j3#", "" },
		{ 30622, "", "=q1=Flamewrought Key", "=ds=#e9# =ec1=#m7#" },
		{ 30637, "", "=q1=Flamewrought Key", "=ds=#e9# =ec1=#m6#" },
		{ 30623, "", "=q1=Reservoir Key", "=ds=#e9#" },
		{ 30633, "", "=q1=Auchenai Key", "=ds=#e9#" },
		{ 30635, "", "=q1=Key of Time", "=ds=#e9#" },
		{ 30634, "", "=q1=Warpforged Key", "=ds=#e9#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#j2#", "" },
		{ 32649, "", "=q4=Medallion of Karabor", "=ds=#e9#, #s2#" },
		{ 31704, "", "=q1=The Tempest Key", "=ds=#e9#" },
		{ 24490, "", "=q1=The Master's Key", "=ds=#e9#" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#m20#", "" },
		{ 32092, "", "=q3=The Eye of Haramad", "=ds=#m27#" },
		{ 24140, "", "=q1=Blackened Urn", "=ds=#m27#" },
		{ 32449, "", "=q1=Essence-Infused Moonstone", "=ds=#m27#" },
	};

	-------------------------------------------
	--- Hellfire Citadel: Hellfire Ramparts ---
	-------------------------------------------

	HCRampWatchkeeper = {
		{ 24024, "", "=q3=Pauldrons of Arcane Rage", "=ds=#s3#, #a1#", "20.00%" },
		{ 24023, "", "=q3=Bracers of Finesse", "=ds=#s8#, #a2#", "20.00%" },
		{ 24022, "", "=q3=Scale Leggings of the Skirmisher", "=ds=#s11#, #a3#", "20.00%" },
		{ 24021, "", "=q3=Light-Touched Breastplate", "=ds=#s5#, #a4#", "20.00%" },
		{ 24020, "", "=q3=Shadowrend Longblade", "=ds=#h1#, #w10#", "20.00%" },
		{ 0,"","","" },
		{ 23881, "", "=q1=Gargolmar's Hand", "=ds=#m3#", "100%" },
	};

	HCRampWatchkeeperHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27448, "", "=q3=Cloak of the Everliving", "=ds=#s4#", "20.00%" },
		{ 27451, "", "=q3=Boots of the Darkwalker", "=ds=#s12#, #a1#", "20.00%" },
		{ 27450, "", "=q3=Wild Stalker Boots", "=ds=#s12#, #a3#", "20.00%" },
		{ 27447, "", "=q3=Bracers of Just Rewards", "=ds=#s8#, #a4#", "20.00%" },
		{ 27449, "", "=q3=Blood Knight Defender", "=ds=#w8#", "20.00%" },
		{ 0,"","","" },
		{ 23881, "", "=q1=Gargolmar's Hand", "=ds=#m3#", "100%" },
	};

	HCRampOmor = {
		{ 24090, "", "=q3=Bloodstained Ravager Gauntlets", "=ds=#s9#, #a3#", "17.00%" },
		{ 24091, "", "=q3=Tenacious Defender", "=ds=#s10#, #a4#", "17.00%" },
		{ 24073, "", "=q3=Garotte-String Necklace", "=ds=#s2#", "17.00%" },
		{ 24096, "", "=q3=Heartblood Prayer Beads", "=ds=#s2#", "17.00%" },
		{ 24094, "", "=q3=Heart Fire Warhammer", "=ds=#h2#, #w6#", "17.00%" },
		{ 24069, "", "=q3=Crystalfire Staff", "=ds=#w9#", "17.00%" },
		{ 0,"","","" },
		{ 23886, "", "=q1=Omor's Hoof", "=ds=#m3#", "100%" },
	};

	HCRampOmorHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27466, "", "=q3=Headdress of Alacrity", "=ds=#s1#, #a1#", "8.00%" },
		{ 27462, "", "=q3=Crimson Bracers of Gloom", "=ds=#s8#, #a1#", "8.00%" },
		{ 27467, "", "=q3=Silent-Strider Kneeboots", "=ds=#s12#, #a2#", "8.00%" },
		{ 27478, "", "=q3=Girdle of the Blasted Reaches", "=ds=#s10#, #a3#", "8.00%" },
		{ 27539, "", "=q3=Justice Bearer's Pauldrons", "=ds=#s3#, #a4#", "8.00%" },
		{ 27906, "", "=q3=Crimsonforge Breastplate", "#s5#, #a4#", "8.00%" },
		{ 27464, "", "=q3=Omor's Unyielding Will", "=ds=#s2#", "8.00%" },
		{ 27895, "", "=q3=Band of Many Prisms", "=ds=#s13#", "8.00%" },
		{ 27477, "", "=q3=Faol's Signet of Cleansing", "=ds=#s15#", "8.00%" },
		{ 27463, "", "=q3=Terror Flame Dagger", "=ds=#h1#, #w4#", "8.00%" },
		{ 27476, "", "=q3=Truncheon of Five Hells", "=ds=#h1#, #w6#", "8.00%" },
		{ 27465, "", "=q3=Mana-Etched Gloves", "=ds=#s9#, #a1#", "8.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 23886, "", "=q1=Omor's Hoof", "=ds=#m3#", "100%" },
	};

	HCRampVazruden = {
		{ 24150, "", "=q3=Mok'Nathal Wildercloak", "=ds=#s4#", "10.00%" },
		{ 24083, "", "=q3=Lifegiver Britches", "=ds=#s11#, #a1#", "10.00%" },
		{ 24063, "", "=q3=Shifting Sash of Midnight", "=ds=#s10#, #a2#", "10.00%" },
		{ 24046, "", "=q3=Kilt of Rolling Thunders", "=ds=#s11#, #a3#", "10.00%" },
		{ 24064, "", "=q3=Ironsole Clompers", "=ds=#s12#, #a4#", "10.00%" },
		{ 24045, "", "=q3=Band of Renewal", "=ds=#s13#", "10.00%" },
		{ 24154, "", "=q3=Witching Band", "=ds=#s13#", "10.00%" },
		{ 24151, "", "=q3=Mok'Nathal Clan Ring", "=ds=#s13#", "10.00%" },
		{ 24044, "", "=q3=Hellreaver", "=ds=#w7#", "10.00%" },
		{ 24155, "", "=q3=Ursol's Claw", "=ds=#w9#", "10.00%" },
		{ 0,"","","" },
		{ 23901, "", "=q1=Nazan's Head", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 23892, "", "=q1=Ominous Letter", "=ds=#m2#", "100%" },
		{ 25711, "", "=q3=Deadly Borer Leggings", "=ds=#m4#: #s11#, #a1#"},
		{ 25710, "", "=q3=Moonkin Headdress", "=ds=#m4#: #s1#, #a2#"},
		{ 25702, "", "=q3=Scaled Legs of Ruination", "=ds=#m4#: #s11#, #a3#"},
		{ 25701, "", "=q3=Breastplate of Retribution", "=ds=#m4#: #s5#, #a4#"},
	};
	
	HCRampVazrudenHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30593, "", "=q4=Iridescent Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30594, "", "=q4=Effulgent Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 30592, "", "=q4=Steady Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29264, "", "=q4=Tree-Mender's Belt", "=ds=#s10#, #a2#", "33.00%" },
		{ 29238, "", "=q4=Lion's Heart Girdle", "=ds=#s10#, #a4#", "33.00%" },
		{ 29346, "", "=q4=Feltooth Eviscerator", "=ds=#h1#, #w4#", "33.00%" },
		{ 0,"","","" },
		{ 23901, "", "=q1=Nazan's Head", "=ds=#m3#", "100%" },
		{ 23892, "", "=q1=Ominous Letter", "=ds=#m2#", "100%" },
		{ 25711, "", "=q3=Deadly Borer Leggings", "=ds=#m4#: #s11#, #a1#"},
		{ 25710, "", "=q3=Moonkin Headdress", "=ds=#m4#: #s1#, #a2#"},
		{ 25702, "", "=q3=Scaled Legs of Ruination", "=ds=#m4#: #s11#, #a3#"},
		{ 25701, "", "=q3=Breastplate of Retribution", "=ds=#m4#: #s5#, #a4#"},
		{ 27452, "", "=q3=Light Scribe Bands", "=ds=#s8#, #a1#", "10.00%" },
		{ 27461, "", "=q3=Chestguard of the Prowler", "=ds=#s5#, #a2#", "10.00%" },
		{ 27456, "", "=q3=Raiments of Nature's Breath", "=ds=#s5#, #a2#", "10.00%" },
		{ 27454, "", "=q3=Volcanic Pauldrons", "=ds=#s3#, #a3#", "10.00%" },
		{ 27458, "", "=q3=Oceansong Kilt", "=ds=#s11#, #a3#", "10.00%" },
		{ 27455, "", "=q3=Irondrake Faceguard", "=ds=#s1#, #a4#", "10.00%" },
		{ 27459, "", "=q3=Vambraces of Daring", "=ds=#s8#, #a4#", "10.00%" },
		{ 27457, "", "=q3=Life Bearer's Gauntlets", "=ds=#s9#, #a4#", "10.00%" },
		{ 27453, "", "=q3=Averinn's Ring of Slaying", "=ds=#s13#", "10.00%" },
		{ 27460, "", "=q3=Reavers' Ring", "=ds=#s13#", "10.00%" },
	};

	HCRampNazan = {
		{ 23901, "", "=q1=Nazan's Head", "=ds=#m3#", "100%" },
	};

	HCRampFelIronChest = {
		{ 24150, "", "=q3=Mok'Nathal Wildercloak", "=ds=#s4#", "15.65%" },
		{ 24083, "", "=q3=Lifegiver Britches", "=ds=#s11#, #a1#", "17.00%" },
		{ 24063, "", "=q3=Shifting Sash of Midnight", "=ds=#s10#, #a2#", "17.25%" },
		{ 24046, "", "=q3=Kilt of Rolling Thunders", "=ds=#s11#, #a3#", "15.96%" },
		{ 24064, "", "=q3=Ironsole Clompers", "=ds=#s12#, #a4#", "13.80%" },
		{ 24045, "", "=q3=Band of Renewal", "=ds=#s13#", "14.44%" },
		{ 24154, "", "=q3=Witching Band", "=ds=#s13#", "13.23%" },
		{ 24151, "", "=q3=Mok'Nathal Clan Ring", "=ds=#s13#", "15.45%" },
		{ 24044, "", "=q3=Hellreaver", "=ds=#w7#", "13.91%" },
		{ 24155, "", "=q3=Ursol's Claw", "=ds=#w9#", "16.21%" },	 
	};

	HCRampFelIronChestHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 29264, "", "=q4=Tree-Mender's Belt", "=ds=#s10#, #a2#", "16.05%" },
		{ 29238, "", "=q4=Lion's Heart Girdle", "=ds=#s10#, #a4#", "14.81%" },
		{ 29346, "", "=q4=Feltooth Eviscerator", "=ds=#h1#, #w4#", "5.56%" },
		{ 0,"","","" },
		{ 27452, "", "=q3=Light Scribe Bands", "=ds=#s8#, #a1#", "11.73%" },
		{ 27461, "", "=q3=Chestguard of the Prowler", "=ds=#s5#, #a2#", "11.73%" },
		{ 27456, "", "=q3=Raiments of Nature's Breath", "=ds=#s5#, #a2#", "19.75%" },
		{ 27454, "", "=q3=Volcanic Pauldrons", "=ds=#s3#, #a3#", "16.66%" },
		{ 27458, "", "=q3=Oceansong Kilt", "=ds=#s11#, #a3#", "10.49%" },
		{ 27455, "", "=q3=Irondrake Faceguard", "=ds=#s1#, #a4#", "11.11%" },
		{ 27459, "", "=q3=Vambraces of Daring", "=ds=#s8#, #a4#", "10.49%" },
		{ 27457, "", "=q3=Life Bearer's Gauntlets", "=ds=#s9#, #a4#", "8.02%" },
		{ 27453, "", "=q3=Averinn's Ring of Slaying", "=ds=#s13#", "14.20%" },
		{ 27460, "", "=q3=Reavers' Ring", "=ds=#s13#", "17.90%" },
	};

	-------------------------------------------
	--- Hellfire Citadel: The Blood Furnace ---
	-------------------------------------------

	HCFurnaceMaker = {
		{ 24388, "", "=q3=Girdle of the Gale Storm", "=ds=#s10#, #a3#", "20.00%" },
		{ 24387, "", "=q3=Ironblade Gauntlets", "=ds=#s9#, #a4#", "20.00%" },
		{ 24385, "", "=q3=Pendant of Battle-Lust", "=ds=#s2#", "20.00%" },
		{ 24386, "", "=q3=Libram of Saints Departed", "=ds=#s16#, #w16#", "20.00%" },
		{ 24384, "", "=q3=Diamond-Core Sledgemace", "=ds=#h3#, #w6#", "20.00%" },
	};

	HCFurnaceMakerHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27485, "", "=q3=Embroidered Cape of Mysteries", "=ds=#s4#", "20.00%" },
		{ 27488, "", "=q3=Mage-Collar of the Firestorm", "=ds=#s1#, #a1#", "20.00%" },
		{ 27483, "", "=q3=Moon-Touched Bands", "=ds=#s8#, #a2#", "20.00%" },
		{ 27487, "", "=q3=Bloodlord Legplates", "=ds=#s11#, #a4#", "20.00%" },
		{ 27484, "", "=q3=Libram of Avengement", "=ds=#s16#, #w16#", "20.00%" },
	};

	HCFurnaceBroggok = {
		{ 24392, "", "=q3=Arcing Bracers", "=ds=#s8#, #a1#", "20.00%" },
		{ 24393, "", "=q3=Bloody Surgeon's Mitts", "=ds=#s9#, #a1#", "20.00%" },
		{ 24391, "", "=q3=Kilt of the Night Strider", "=ds=#s11#, #a2#", "20.00%" },
		{ 24390, "", "=q3=Auslese's Light Channeler", "=ds=#s14#", "20.00%" },
		{ 24389, "", "=q3=Legion Blunderbuss", "=ds=#w5#", "20.00%" },
	};

	HCFurnaceBroggokHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27848, "", "=q3=Embroidered Spellpyre Boots", "=ds=#s12#, #a1#", "20.00%" },
		{ 27492, "", "=q3=Moonchild Leggings", "=ds=#s11#, #a2#", "20.00%" },
		{ 27489, "", "=q3=Virtue Bearer's Vambraces", "=ds=#s8#, #a4#", "20.00%" },
		{ 27491, "", "=q3=Signet of Repose", "=ds=#s13#", "20.00%" },
		{ 27490, "", "=q3=Firebrand Battleaxe", "=ds=#h1#, #w1#", "20.00%" },
	};

	HCFurnaceBreaker = {
		{ 24397, "", "=q3=Raiments of Divine Authority", "=ds=#s5#, #a1#", "20.00%" },
		{ 24395, "", "=q3=Mindfire Waistband", "=ds=#s10#, #a1#", "20.00%" },
		{ 24398, "", "=q3=Mantle of the Dusk-Dweller", "=ds=#s3#, #a2#", "20.00%" },
		{ 24396, "", "=q3=Vest of Vengeance", "=ds=#s5#, #a2#", "20.00%" },
		{ 24394, "", "=q3=Warsong Howling Axe", "=ds=#h2#, #w1#", "20.00%" },
	};

	HCFurnaceBreakerHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30601, "", "=q4=Beaming Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30600, "", "=q4=Fluorescent Tanzanite", "=ds=#e7#", "15.00%" },
		{ 30602, "", "=q4=Jagged Chrysoprase", "=ds=#e7#", "15.00%" }, 
		{ 0,"","","" },
		{ 29245, "", "=q4=Wave-Crest Striders", "=ds=#s12#, #a3#", "33.00%" },
		{ 29239, "", "=q4=Eaglecrest Warboots", "=ds=#s12#, #a4#", "33.00%" },
		{ 29347, "", "=q4=Talisman of the Breaker", "=ds=#s2#", "33.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27506, "", "=q3=Robe of Effervescent Light", "=ds=#s5#, #a1#", "8.00%" },
		{ 27514, "", "=q3=Leggings of the Unrepentant", "=ds=#s11#, #a2#", "8.00%" },
		{ 27522, "", "=q3=World's End Bracers", "=ds=#s8#, #a3#", "8.00%" },
		{ 27494, "", "=q3=Emerald Eye Bracer", "=ds=#s8#, #a3#", "8.00%" },
		{ 27505, "", "=q3=Ruby Helm of the Just", "=ds=#s1#, #a4#", "8.00%" },
		{ 27788, "", "=q3=Bloodsworn Warboots", "=ds=#s12#, #a4#", "8.00%" },
		{ 27495, "", "=q3=Soldier's Dog Tags", "=ds=#s2#", "9.85%", "8.00%" },
		{ 28121, "", "=q3=Icon of Unyielding Courage", "=ds=#s14#", "8.00%" },
		{ 28264, "", "=q3=Wastewalker Tunic", "=ds=#s5#, #a2# (D3)", "8.00%" },
		{ 27497, "", "=q3=Doomplate Gauntlets", "=ds=#s9#, #a4# (D3)", "8.00%" },
		{ 27512, "", "=q3=The Willbreaker", "=ds=#h3#, #w10#", "8.00%" },
		{ 27507, "", "=q3=Adamantine Repeater", "=ds=#w3#", "8.00%" },
	};

	------------------------------------------
	--- Coilfang Reservoir: The Slave Pens ---
	------------------------------------------

	CFRSlaveMennu = {
		{ 24359, "", "=q3=Princely Reign Leggings", "=ds=#s11#, #a1#", "20.00%" },
		{ 24357, "", "=q3=Vest of Living Lightning", "=ds=#s5#, #a3#", "20.00%" },
		{ 24360, "", "=q3=Tracker's Belt", "=ds=#s10#, #a3#", "20.00%" },
		{ 24356, "", "=q3=Wastewalker Shiv", "=ds=#h1#, #w4#", "20.00%" },
		{ 24361, "", "=q3=Spellfire Longsword", "=ds=#h3#, #w10#", "20.00%" },
		{ 0,"","","" },
		{ 29674, "", "=q2=Pattern: Nature Armor Kit", "=ds=#p7# (340)", "10.00%" },
	};

	CFRSlaveMennuHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27542, "", "=q3=Cord of Belief", "=ds=#s10#, #a1#", "17.00%" },
		{ 27545, "", "=q3=Mennu's Scaled Leggings", "=ds=#s11#, #a2#", "17.00%" },
		{ 27541, "", "=q3=Archery Belt of the Broken", "=ds=#s10#, #a3#", "17.00%" },
		{ 27546, "", "=q3=Traitor's Noose", "=ds=#s2#", "17.00%" },
		{ 27544, "", "=q3=Totem of Spontaneous Regrowth", "=ds=#s16#, #w15#", "17.00%" },
		{ 27543, "", "=q3=Starlight Dagger", "=ds=#h3#, #w4#", "17.00%" },
		{ 0,"","","" },
		{ 29674, "", "=q2=Pattern: Nature Armor Kit", "=ds=#p7# (340)", "10.00%" },
	};

	CFRSlaveRokmar = {
		{ 24379, "", "=q3=Bogstrok Scale Cloak", "=ds=#s4#", "20.00%" },
		{ 24376, "", "=q3=Runed Fungalcap", "=ds=#s14#", "20.00%" },
		{ 24378, "", "=q3=Coilfang Hammer of Renewal", "=ds=#h3#, #w6#", "20.00%" },
		{ 24380, "", "=q3=Calming Spore Reed", "=ds=#w12#", "20.00%" },
		{ 24381, "", "=q3=Coilfang Needler", "=ds=#w3#", "20.00%" },
	};

	CFRSlaveRokmarHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27550, "", "=q3=Ironscale War Cloak", "=ds=#s4#", "17.00%" },
		{ 27547, "", "=q3=Coldwhisper Cord", "=ds=#s10#, #a1#", "17.00%" },
		{ 28124, "", "=q3=Liar's Cord", "=ds=#s10#, #a2#", "17.00%" },
		{ 27549, "", "=q3=Wavefury Boots", "=ds=#s12#, #a3#", "17.00%" },
		{ 27548, "", "=q3=Girdle of Many Blessings", "=ds=#s10#, #a4#", "17.00%" },
		{ 27551, "", "=q3=Skeletal Necklace of Battlerage", "=ds=#s2#", "17.00%" },
	};

	CFRSlaveQuagmirran = {
		{ 24362, "", "=q3=Spore-Soaked Vaneer", "=ds=#s4#", "20.00%" },
		{ 24365, "", "=q3=Deft Handguards", "=ds=#s9#, #a2#", "20.00%" },
		{ 24366, "", "=q3=Scorpid-Sting Mantle", "=ds=#s3#, #a3#", "20.00%" },
		{ 24363, "", "=q3=Unscarred Breastplate", "=ds=#s5#, #a4#", "20.00%" },
		{ 24364, "", "=q3=Azureplate Greaves", "=ds=#s11#, #a4#", "20.00%" },
	};

	CFRSlaveQuagmirranHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30604, "", "=q4=Resplendent Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30605, "", "=q4=Vivid Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 30603, "", "=q4=Royal Tanzanite", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29242, "", "=q4=Boots of Blasphemy", "=ds=#s12#, #a1#", "33.00%" },
		{ 30538, "", "=q4=Midnight Legguards", "=ds=#s11#, #a2#", "33.00%" },
		{ 29349, "", "=q4=Adamantine Chain of the Unbroken", "=ds=#s2#", "33.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27742, "", "=q3=Mage-Fury Girdle", "=ds=#s10#, #a1#", "6.00%" },
		{ 27796, "", "=q3=Mana-Etched Spaulders", "=ds=#s3#, #a1# (D3)", "6.00%" },
		{ 27712, "", "=q3=Shackles of Quagmirran", "=ds=#s8#, #a2#", "6.00%" },
		{ 27800, "", "=q3=Earthsoul Britches", "=ds=#s11#, #a2#", "6.00%" },
		{ 27713, "", "=q3=Pauldrons of Desolation", "=ds=#s3#, #a3# (D3)", "6.00%" },
		{ 28337, "", "=q3=Breastplate of Righteous Fury", "=ds=#s5#, #a4#", "6.00%" },
		{ 27672, "", "=q3=Girdle of the Immovable", "=ds=#s10#, #a4#", "6.00%" },
		{ 27740, "", "=q3=Band of Ursol", "=ds=#s13#", "6.00%" },
		{ 27683, "", "=q3=Quagmirran's Eye", "=ds=#s14#", "6.00%" },
		{ 27714, "", "=q3=Swamplight Lantern", "=ds=#s15#", "6.00%" },
		{ 27673, "", "=q3=Phosphorescent Blade", "=ds=#h1#, #w10#", "6.00%" },
		{ 27741, "", "=q3=Bleeding Hollow Warhammer", "=ds=#h3#, #w6#", "6.00%" },
	};

	----------------------------------------
	--- Coilfang Reservoir: The Underbog ---
	----------------------------------------

	CFRUnderHungarfen = {
		{ 24450, "", "=q3=Manaspark Gloves", "=ds=#s9#, #a1#", "20.00%" },
		{ 24452, "", "=q3=Starlight Gauntlets", "=ds=#s9#, #a2#", "20.00%" },
		{ 24451, "", "=q3=Lykul Bloodbands", "=ds=#s8#, #a3#", "20.00%" },
		{ 24413, "", "=q3=Totem of the Thunderhead", "=ds=#s16#, #w15#", "20.00%" },
		{ 27631, "", "=q3=Needle Shrike", "=ds=#w11#", "20.00%" },
	};

	CFRUnderHungarfenHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27746, "", "=q3=Arcanium Signet Bands", "=ds=#s8#, #a1#", "17.00%" },
		{ 27745, "", "=q3=Hungarhide Gauntlets", "=ds=#s9#, #a3#", "17.00%" },
		{ 27743, "", "=q3=Girdle of Living Flame", "=ds=#s10#, #a3#", "17.00%" },
		{ 27748, "", "=q3=Cassock of the Loyal", "=ds=#s11#, #a4#", "17.00%" },
		{ 27744, "", "=q3=Idol of Ursoc", "=ds=#s16#, #w14#", "17.00%" },
		{ 27747, "", "=q3=Boggspine Knuckles", "=ds=#h4#, #w13#", "17.00%" },
	};

	CFRUnderGhazan = {
		{ 24459, "", "=q3=Cloak of Healing Rays", "=ds=#s4#", "20.00%" },
		{ 24458, "", "=q3=Studded Girdle of Virtue", "=ds=#s10#, #a4#", "20.00%" },
		{ 24460, "", "=q3=Talisman of Tenacity", "=ds=#s2#", "20.00%" },
		{ 24462, "", "=q3=Luminous Pearls of Insight", "=ds=#s2#", "20.00%" },
		{ 24461, "", "=q3=Hatebringer", "=ds=#h2#, #w6#", "20.00%" },
	};

	CFRUnderGhazanHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27760, "", "=q3=Dunewind Sash", "=ds=#s10#, #a2#", "17.00%" },
		{ 27759, "", "=q3=Headdress of the Tides", "=ds=#s1#, #a3#", "17.00%" },
		{ 27755, "", "=q3=Girdle of Gallantry", "=ds=#s10#, #a4#", "17.00%" },
		{ 27758, "", "=q3=Hydra-fang Necklace", "=ds=#s2#", "17.00%" },
		{ 27761, "", "=q3=Ring of the Shadow Deeps", "=ds=#s13#", "17.00%" },
		{ 27757, "", "=q3=Greatstaff of the Leviathan", "=ds=#w9#", "17.00%" },
	};

	CFRUnderSwamplord = {
		{ 24454, "", "=q3=Cloak of Enduring Swiftness", "=ds=#s4#", "20.00%" },
		{ 24455, "", "=q3=Tunic of the Nightwatcher", "=ds=#s5#, #a2#", "20.00%" },
		{ 24457, "", "=q3=Truth Bearer Shoulderguards", "=ds=#s3#, #a4#", "20.00%" },
		{ 24456, "", "=q3=Greaves of the Iron Guardian", "=ds=#s11#, #a4#", "20.00%" },
		{ 24453, "", "=q3=Zangartooth Shortblade", "=ds=#h3#, #w4#", "20.00%" },
	};

	CFRUnderSwamplordHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27764, "", "=q3=Hands of the Sun", "=ds=#s9#, #a1#", "17.00%" },
		{ 27763, "", "=q3=Crown of the Forest Lord", "=ds=#s1#, #a2#", "17.00%" },
		{ 27765, "", "=q3=Armwraps of Disdain", "=ds=#s8#, #a2#", "17.00%" },
		{ 27766, "", "=q3=Swampstone Necklace", "=ds=#s2#", "17.00%" },
		{ 27762, "", "=q3=Weathered Band of the Swamplord", "=ds=#s13#", "17.00%" },
		{ 27767, "", "=q3=Bogreaver", "=ds=#h1#, #w1#", "17.00%" },
	};

	CFRUnderStalker = {
		{ 24481, "", "=q3=Robes of the Augurer", "=ds=#s5#, #a1#", "20.00%" },
		{ 24466, "", "=q3=Skulldugger's Leggings", "=ds=#s11#, #a2#", "20.00%" },
		{ 24465, "", "=q3=Shamblehide Chestguard", "=ds=#s5#, #a3#", "20.00%" },
		{ 24463, "", "=q3=Pauldrons of Brute Force", "=ds=#s3#, #a4#", "20.00%" },
		{ 24464, "", "=q3=The Stalker's Fangs", "=ds=#h1#, #w4#", "20.00%" },
		{ 0,"","","" },
		{ 24248, "", "=q1=Brain of the Black Stalker", "=ds=#m3#", "100%" },
	};

	CFRUnderStalkerHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30606, "", "=q4=Lambent Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 30607, "", "=q4=Splendid Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30608, "", "=q4=Radiant Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29265, "", "=q4=Barkchip Boots", "=ds=#s12#, #a2#", "33.00%" },
		{ 30541, "", "=q4=Stormsong Kilt", "=ds=#s11#, #a3#", "33.00%" },
		{ 29350, "", "=q4=The Black Stalk", "=ds=#w12#", "33.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 24248, "", "=q1=Brain of the Black Stalker", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27781, "", "=q3=Demonfang Ritual Helm", "=ds=#s1#, #a1#", "8.00%" },
		{ 27768, "", "=q3=Oracle Belt of Timeless Mystery", "=ds=#s10#, #a1#", "8.00%" },
		{ 27907, "", "=q3=Mana-Etched Pantaloons", "=ds=#s11#, #a1# (D3)", "8.00%" },
		{ 27938, "", "=q3=Savage Mask of the Lynx Lord", "=ds=#s1#, #a2#", "8.00%" },
		{ 27773, "", "=q3=Barbaric Legstraps", "=ds=#s11#, #a3#", "8.00%" },
		{ 27771, "", "=q3=Doomplate Shoulderguards", "=ds=#s3#, #a4# (D3)", "8.00%" },
		{ 27779, "", "=q3=Bone Chain Necklace", "=ds=#s2#", "8.00%" },
		{ 27780, "", "=q3=Ring of Fabled Hope", "=ds=#s13#", "8.00%" },
		{ 27896, "", "=q3=Alembic of Infernal Power", "=ds=#s14#", "8.00%" },
		{ 27770, "", "=q3=Argussian Compass", "=ds=#s14#", "8.00%" },
		{ 27769, "", "=q3=Endbringer", "=ds=#h2#, #w10#", "8.00%" },
		{ 27772, "", "=q3=Stormshield of Renewal", "=ds=#w8#", "8.00%" },
	};

	------------------------------
	--- Auchindoun: Mana-Tombs ---
	------------------------------
 
	AuchManaPandemonius = {
		{ 25941, "", "=q3=Boots of the Outlander", "=ds=#s12#, #a3#", "17.00%" },
		{ 25942, "", "=q3=Faith Bearer's Gauntlets", "=ds=#s9#, #a4#", "17.00%" },
		{ 25940, "", "=q3=Idol of the Claw", "=ds=#s16#, #w14#", "17.00%" },
		{ 25943, "", "=q3=Creepjacker", "=ds=#h3#, #w13#", "17.00%" },
		{ 28166, "", "=q3=Shield of the Void", "=ds=#w8#", "17.00%" },
		{ 25939, "", "=q3=Voidfire Wand", "=ds=#w12#", "17.00%" },
	};

	AuchManaPandemoniusHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27816, "", "=q3=Mindrage Pauldrons", "=ds=#s3#, #a1#", "17.00%" },
		{ 27818, "", "=q3=Starry Robes of the Crescent", "=ds=#s5#, #a2#", "17.00%" },
		{ 27813, "", "=q3=Boots of the Colossus", "=ds=#s12#, #a4#", "17.00%" },
		{ 27815, "", "=q3=Totem of the Astral Winds", "=ds=#s16#, #w15#", "17.00%" },
		{ 27814, "", "=q3=Twinblade of Mastery", "=ds=#h1#, #w4#", "17.00%" },
		{ 27817, "", "=q3=Starbolt Longbow", "=ds=#w2#", "17.00%" },
	};

	AuchManaTavarok = {
		{ 25945, "", "=q3=Cloak of Revival", "=ds=#s4#", "17.00%" },
		{ 25946, "", "=q3=Nethershade Boots", "=ds=#s12#, #a2#", "17.00%" },
		{ 25947, "", "=q3=Lightning-Rod Pauldrons", "=ds=#s3#, #a3#", "17.00%" },
		{ 25952, "", "=q3=Scimitar of the Nexus-Stalkers", "=ds=#h1#, #w10#", "17.00%" },
		{ 25944, "", "=q3=Shaarde the Greater", "=ds=#h2#, #w10#", "17.00%" },
		{ 25950, "", "=q3=Staff of Polarities", "=ds=#w9#", "17.00%" },
	};

	AuchManaTavarokHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27824, "", "=q3=Robe of the Great Dark Beyond", "=ds=#s5#, #a1#", "17.00%" },
		{ 27821, "", "=q3=Extravagant Boots of Malice", "=ds=#s12#, #a1#", "17.00%" },
		{ 27825, "", "=q3=Predatory Gloves", "=ds=#s9#, #a2#", "17.00%" },
		{ 27826, "", "=q3=Mantle of the Sea Wolf", "=ds=#s3#, #a3#", "17.00%" },
		{ 27823, "", "=q3=Shard Encrusted Breastplate", "=ds=#s5#, #a3#", "17.00%" },
		{ 27822, "", "=q3=Crystal Band of Valor", "=ds=#s13#", "17.00%" },
	};

	AuchManaNexusPrince = {
		{ 25957, "", "=q3=Ethereal Boots of the Skystrider", "=ds=#s12#, #a1#", "17.00%" },
		{ 25955, "", "=q3=Mask of the Howling Storm", "=ds=#s1#, #a3#", "17.00%" },
		{ 25956, "", "=q3=Nexus-Bracers of Vigor", "=ds=#s8#, #a4#", "17.00%" },
		{ 25954, "", "=q3=Sigil of Shaffar", "=ds=#s2#", "17.00%" },
		{ 25962, "", "=q3=Longstrider's Loop", "=ds=#s13#", "17.00%" },
		{ 25953, "", "=q3=Ethereal Warp-Bow", "=ds=#w2#", "17.00%" },
		{ 0,"","","" },
		{ 22921, "", "=q2=Recipe: Major Frost Protection Potion", "=ds=#p1# (360)", "10.00%" },
		{ 0,"","","" },
		{ 28490, "", "=q1=Shaffar's Wrappings", "=ds=#m3#", "100%" },
	};

	AuchManaNexusPrinceHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30584, "", "=q4=Enscribed Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30585, "", "=q4=Glistening Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30583, "", "=q4=Timeless Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29240, "", "=q4=Bands of Negation", "=ds=#s8#, #a1#", "33.00%" },
		{ 30535, "", "=q4=Forestwalker Kilt", "=ds=#s11#, #a2#", "33.00%" },
		{ 29352, "", "=q4=Cobalt Band of Tyrigosa", "=ds=#s13#", "33.00%" },
		{ 0,"","","" },
		{ 22921, "", "=q2=Recipe: Major Frost Protection Potion", "=ds=#p1# (360)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 28490, "", "=q1=Shaffar's Wrappings", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 27831, "", "=q3=Mantle of the Unforgiven", "=ds=#s3#, #a1#", "17.00%" },
		{ 27843, "", "=q3=Glyph-Lined Sash", "=ds=#s10#, #a1#", "17.00%" },
		{ 27827, "", "=q3=Lucid Dream Bracers", "=ds=#s8#, #a2#", "17.00%" },
		{ 27837, "", "=q3=Wastewalker Leggings", "=ds=#s11#, #a2# (D3)", "17.00%" },
		{ 27835, "", "=q3=Stillwater Girdle", "=ds=#s10#, #a3#", "17.00%" },
		{ 27844, "", "=q3=Pauldrons of Swift Retribution", "=ds=#s3#, #a4#", "17.00%" },
		{ 27798, "", "=q3=Gauntlets of Vindication", "=ds=#s9#, #a4#", "17.00%" },
		{ 27828, "", "=q3=Warp-Scarab Brooch", "=ds=#s14#", "17.00%" },
		{ 28400, "", "=q3=Warp-Storm Warblade", "=ds=#h1#, #w10#", "17.00%" },
		{ 27829, "", "=q3=Axe of the Nexus-Kings", "=ds=#h2#, #w1#", "17.00%" },
		{ 27840, "", "=q3=Scepter of Sha'tar", "=ds=#h2#, #w6#", "17.00%" },
		{ 27842, "", "=q3=Grand Scepter of the Nexus-Kings", "=ds=#w9#", "17.00%" },
	};

	AuchManaYor = {
	};

	AuchManaTrash = {
		{ 23615, "", "=q3=Plans: Swiftsteel Gloves", "=q1=#cas1#", "4.00%" },
		{ 22543, "", "=q2=Formula: Enchant Boots - Fortitude", "=q1=#cas2#", "2.00%" },
	};

	-----------------------------------
	--- Auchindoun: Auchenai Crypts ---
	-----------------------------------

	AuchCryptsShirrak = {
		{ 27410, "", "=q3=Collar of Command", "=ds=#s1#, #a1#", "20.00%" },
		{ 27409, "", "=q3=Raven-Heart Headdress", "=ds=#s1#, #a2#", "20.00%" },
		{ 27408, "", "=q3=Hope Bearer Helm", "=ds=#s1#, #a4#", "20.00%" },
		{ 26055, "", "=q3=Oculus of the Hidden Eye", "=ds=#s14#", "20.00%" },
		{ 25964, "", "=q3=Shaarde the Lesser", "=ds=#h1#, #w10#", "20.00%" },
	};

	AuchCryptsShirrakHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27866, "", "=q3=Scintillating Headdress of Second Sight", "=ds=#s1#, #a1#", "17.00%" },
		{ 27493, "", "=q3=Gloves of the Deadwatcher", "=ds=#s9#, #a1#", "17.00%" },
		{ 27865, "", "=q3=Bracers of Shirrak", "=ds=#s8#, #a3#", "17.00%" },
		{ 27845, "", "=q3=Magma Plume Boots", "=ds=#s12#, #a3#", "17.00%" },
		{ 27847, "", "=q3=Fanblade Pauldrons", "=ds=#s3#, #a4#", "17.00%" },
		{ 27846, "", "=q3=Claw of the Watcher", "=ds=#h3#, #w13#", "17.00%" },
	};

	AuchCryptsExarch = {
		{ 27411, "", "=q3=Slippers of Serenity", "=ds=#s12#, #a1#", "17.00%" },
		{ 27415, "", "=q3=Darkguard Face Mask", "=ds=#s1#, #a2#", "17.00%" },
		{ 27414, "", "=q3=Mok'Nathal Beast-Mask", "=ds=#s1#, #a3#", "17.00%" },
		{ 27413, "", "=q3=Ring of the Exarchs", "=ds=#s13#", "17.00%" },
		{ 27416, "", "=q3=Fetish of the Fallen", "=ds=#s14#", "17.00%" },
		{ 27412, "", "=q3=Ironstaff of Regeneration", "=ds=#w9#", "17.00%" },
		{ 0,"","","" },
		{ 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
	};

	AuchCryptsExarchHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30587, "", "=q4=Champion's Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30588, "", "=q4=Potent Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30586, "", "=q4=Seer's Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29354, "", "=q4=Light-Touched Stole of Altruism", "=ds=#s4#", "33.00%" },
		{ 29257, "", "=q4=Sash of Arcane Visions", "=ds=#s10#, #a1#", "33.00%" },
		{ 29244, "", "=q4=Wave-Song Girdle", "=ds=#s10#, #a3#", "33.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27867, "", "=q3=Boots of the Unjust", "=ds=#s12#, #a2#", "17.00%" },
		{ 27870, "", "=q3=Doomplate Legguards", "=ds=#s11#, #a4# (D3)", "17.00%" },
		{ 27871, "", "=q3=Maladaar's Blessed Chaplet", "=ds=#s2#", "17.00%" },
		{ 27869, "", "=q3=Soulpriest's Ring of Resolve", "=ds=#s13#", "17.00%" },
		{ 27523, "", "=q3=Exarch's Diamond Band", "=ds=#s13#", "17.00%" },
		{ 27872, "", "=q3=The Harvester of Souls", "=ds=#h1#, #w1#", "17.00%" },
		{ 0,"","","" },
		{ 0, "spell_shadow_coneofsilence", "=q6=#cas3#", "=q5=#cas4#" },
		{ 27878, "", "=q3=Auchenai Death Shroud", "=ds=#s4#", "18.00%" },
		{ 28268, "", "=q3=Natural Mender's Wraps", "=ds=#s9#, #a2#", "18.00%" },
		{ 27797, "", "=q3=Wastewalker Shoulderpads", "=ds=#s3#, #a2# (D3)", "16.00%" },
		{ 27876, "", "=q3=Will of the Fallen Exarch", "=ds=#h3#, #w6#", "15.00%" },
		{ 27937, "", "=q3=Sky Breaker", "=ds=#h3#, #w6#", "17.00%" },
		{ 27877, "", "=q3=Draenic Wildstaff", "=ds=#w9#", "15.00%" },
	};

	AuchCryptsAvatar = {
		{ 27878, "", "=q3=Auchenai Death Shroud", "=ds=#s4#", "4.41%" },
		{ 28268, "", "=q3=Natural Mender's Wraps", "=ds=#s9#, #a2#", "3.94%" },
		{ 27876, "", "=q3=Will of the Fallen Exarch", "=ds=#h3#, #w6#", "5.10%" },
		{ 27937, "", "=q3=Sky Breaker", "=ds=#h3#, #w6#", "3.48%" },
		{ 27877, "", "=q3=Draenic Wildstaff", "=ds=#w9#", "4.87%" },
		{ 27797, "", "=q3=Wastewalker Shoulderpads", "=ds=#s3#, #a2# (D3)", "3.94%" },
	};

	AuchCryptsTrash = {
		{ 23605, "", "=q3=Plans: Felsteel Gloves", "=q1=#cas5#", "9.00%" },
		{ 22544, "", "=q2=Formula: Enchant Boots - Dexterity", "=q1=#cas6#", "2.00%" },
	};

	---------------------------------
	--- Auchindoun: Sethekk Halls ---
	---------------------------------

	AuchSethekkDarkweaver = {
		{ 27919, "", "=q3=Light-Woven Slippers", "=ds=#s12#, #a1#", "17.00%" },
		{ 27914, "", "=q3=Moonstrider Boots", "=ds=#s12#, #a2#", "17.00%" },
		{ 27915, "", "=q3=Sky-Hunter Swift Boots", "=ds=#s12#, #a3#", "17.00%" },
		{ 27918, "", "=q3=Bands of Syth", "=ds=#s8#, #a4#", "17.00%" },
		{ 27917, "", "=q3=Libram of the Eternal Rest", "=ds=#s16#, #w16#", "17.00%" },
		{ 27916, "", "=q3=Sethekk Feather-Darts", "=ds=#w11#", "17.00%" },
		{ 0,"","","" },
		{ 24160, "", "=q3=Design: Khorium Inferno Band", "=ds=#p12# (355)", "10.00%" },
		{ 0,"","","" },
		{ 27633, "", "=q1=Terokk's Mask", "=ds=#m3#", "100%" },
	};

	AuchSethekkDarkweaverHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27919, "", "=q3=Light-Woven Slippers", "=ds=#s12#, #a1#", "17.00%" },
		{ 27914, "", "=q3=Moonstrider Boots", "=ds=#s12#, #a2#", "17.00%" },
		{ 27915, "", "=q3=Sky-Hunter Swift Boots", "=ds=#s12#, #a3#", "17.00%" },
		{ 27918, "", "=q3=Bands of Syth", "=ds=#s8#, #a4#", "17.00%" },
		{ 27917, "", "=q3=Libram of the Eternal Rest", "=ds=#s16#, #w16#", "17.00%" },
		{ 27916, "", "=q3=Sethekk Feather-Darts", "=ds=#w11#", "17.00%" },
		{ 0,"","","" },
		{ 24160, "", "=q3=Design: Khorium Inferno Band", "=ds=#p12# (355)", "10.00%" },
		{ 0,"","","" },
		{ 27633, "", "=q1=Terokk's Mask", "=ds=#m3#", "100%" },
		{ 25461, "", "=q1=Book of Forgotten Names", "=ds=#m3#", "100%" },
	};

	AuchSethekkTheSagaofTerokk ={
		{ 27634, "", "=q1=The Saga of Terokk", "=ds=#m3#" },
	};

	AuchSethekkTalonKing = {
		{ 27948, "", "=q3=Trousers of Oblivion", "=ds=#s11#, #a1# (D3)", "09.00%" },
		{ 27838, "", "=q3=Incanter's Trousers", "=ds=#s11#, #a1# (D3)", "09.00%" },
		{ 27875, "", "=q3=Hallowed Trousers", "=ds=#s11#, #a1# (D3)", "09.00%" },
		{ 27946, "", "=q3=Avian Cloak of Feathers", "=ds=#s4#", "09.00%" },
		{ 27981, "", "=q3=Sethekk Oracle Cloak", "=ds=#s4#", "09.00%" },
		{ 27776, "", "=q3=Shoulderpads of Assassination", "#s3#, #a2# (D3)", "09.00%" },
		{ 27936, "", "=q3=Greaves of Desolation", "=ds=#s11#, #a3# (D3)", "09.00%" },
		{ 27985, "", "=q3=Deathforge Girdle", "=ds=#s10#, #a4#", "09.00%" },
		{ 27925, "", "=q3=Ravenclaw Band", "=ds=#s13#", "09.00%" },
		{ 27980, "", "=q3=Terokk's Nightmace", "=ds=#h1#, #w6#", "09.00%" },
		{ 27986, "", "=q3=Crow Wing Reaper", "=ds=#h2#, #w1#", "09.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "5.00%" },
		{ 0,"","","" },
		{ 27632, "", "=q1=Terokk's Quill", "=ds=#m3#", "100%" },
		{ 0, "INV_Box_01", "=q6=#x37#", "" },
		{ 27991, "", "=q1=Shadow Labyrinth Key", "=ds=#e9#", "100%" },
	};

	AuchSethekkTalonKingHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30553, "", "=q4=Pristine Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30554, "", "=q4=Stalwart Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30552, "", "=q4=Blessed Tanzanite", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29249, "", "=q4=Bands of the Benevolent", "=ds=#s8#, #a1#", "33.00%" },
		{ 29259, "", "=q4=Bracers of the Hunt", "=ds=#s8#, #a3#", "33.00%" },
		{ 29355, "", "=q4=Terokk's Shadowstaff", "=ds=#w9#", "33.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 27632, "", "=q1=Terokk's Quill", "=ds=#m3#", "100%" },
		{ 33834, "", "=q1=The Headfeathers of Ikiss", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27946, "", "=q3=Avian Cloak of Feathers", "=ds=#s4#", "9.00%" },
		{ 27981, "", "=q3=Sethekk Oracle Cloak", "=ds=#s4#", "9.00%" },
		{ 27948, "", "=q3=Trousers of Oblivion", "=ds=#s11#, #a1# (D3)", "9.00%" },
		{ 27838, "", "=q3=Incanter's Trousers", "=ds=#s11#, #a1# (D3)", "9.00%" },
		{ 27875, "", "=q3=Hallowed Trousers", "=ds=#s11#, #a1# (D3)", "9.00%" },
		{ 27776, "", "=q3=Shoulderpads of Assassination", "#s3#, #a2# (D3)", "9.00%" },
		{ 27936, "", "=q3=Greaves of Desolation", "=ds=#s11#, #a3# (D3)", "9.00%" },
		{ 27985, "", "=q3=Deathforge Girdle", "=ds=#s10#, #a4#", "9.00%" },
		{ 27925, "", "=q3=Ravenclaw Band", "=ds=#s13#", "9.00%" },
		{ 27980, "", "=q3=Terokk's Nightmace", "=ds=#h1#, #w6#", "9.00%" },
		{ 27986, "", "=q3=Crow Wing Reaper", "=ds=#h2#, #w1#", "9.00%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#x37#", "" },
		{ 27991, "", "=q1=Shadow Labyrinth Key", "=ds=#e9#", "100%" },
	};

	AuchSethekkRavenGod = {
	};

	AuchSethekkTrash = {
		{ 25731, "", "=q3=Pattern: Stylin' Crimson Hat", "=q1=#cas7#", "5.00%" },
		{ 29669, "", "=q2=Pattern: Shadow Armor Kit", "=q1=#cas8#", "6.00%" },
	};

	------------------------------------------------
	--- Caverns of Time: Old Hillsbrad Foothills ---
	------------------------------------------------

	CoTHillsbradDrake = {
		{ 27423, "", "=q3=Cloak of Impulsiveness", "=ds=#s4#", "20.00%" },
		{ 27418, "", "=q3=Stormreaver Shadow-Kilt", "=ds=#s11#, #a1#", "20.00%" },
		{ 27417, "", "=q3=Ravenwing Pauldrons", "=ds=#s3#, #a2#", "20.00%" },
		{ 27420, "", "=q3=Uther's Ceremonial Warboots", "=ds=#s12#, #a4#", "20.00%" },
		{ 27436, "", "=q3=Iron Band of the Unbreakable", "=ds=#s13#", "20.00%" },
	};

	CoTHillsbradDrakeHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28212, "", "=q3=Aran's Sorcerous Slacks", "=ds=#s11#, #a1#", "17.00%" },
		{ 28214, "", "=q3=Grips of the Lunar Eclipse", "=ds=#s9#, #a2#", "17.00%" },
		{ 28215, "", "=q3=Mok'Nathal Mask of Battle", "=ds=#s1#, #a3#", "17.00%" },
		{ 28211, "", "=q3=Lieutenant's Signet of Lordaeron", "=ds=#s13#", "17.00%" },
		{ 28213, "", "=q3=Lordaeron Medical Guide", "=ds=#s15#", "17.00%" },
		{ 28210, "", "=q3=Bloodskull Destroyer", "=ds=#h1#, #w6#", "17.00%" },
	};

	CoTHillsbradSkarloc = {
		{ 27428, "", "=q3=Stormfront Gauntlets", "=ds=#s9#, #a3#", "20.00%" },
		{ 27430, "", "=q3=Scaled Greaves of Patience", "=ds=#s11#, #a3#", "20.00%" },
		{ 27427, "", "=q3=Durotan's Battle Harness", "=ds=#s5#, #a4#", "20.00%" },
		{ 27424, "", "=q3=Amani Venom-Axe", "=ds=#h1#, #w1#", "20.00%" },
		{ 27426, "", "=q3=Northshire Battlemace", "=ds=#h3#, #w6#", "20.00%" },
		{ 0,"","","" },
		{ 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 22927, "", "=q2=Recipe: Ironshield Potion", "=ds=#p1# (365)", "10.00%" },
	};

	CoTHillsbradSkarlocHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28218, "", "=q3=Pontiff's Pantaloons of Prophecy", "=ds=#s11#, #a1#", "17.00%" },
		{ 28220, "", "=q3=Moon-Crown Antlers", "=ds=#s1#, #a2#", "17.00%" },
		{ 28219, "", "=q3=Emerald-Scale Greaves", "=ds=#s11#, #a3#", "17.00%" },
		{ 28221, "", "=q3=Boots of the Watchful Heart", "=ds=#s12#, #a4#", "17.00%" },
		{ 28217, "", "=q3=Tarren Mill Vitality Locket", "=ds=#s2#", "17.00%" },
		{ 28216, "", "=q3=Dathrohan's Ceremonial Hammer", "=ds=#h3#, #w6#", "17.00%" },
		{ 0,"","","" },
		{ 22927, "", "=q2=Recipe: Ironshield Potion", "=ds=#p1# (365)", "10.00%" },
		{ 0,"","","" },
		{ 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
	};

	CoTHillsbradHunter = {
		{ 27433, "", "=q3=Pauldrons of Sufferance", "=ds=#s3#, #a1#", "20.00%" },
		{ 27434, "", "=q3=Mantle of Perenolde", "=ds=#s3#, #a2#", "20.00%" },
		{ 27440, "", "=q3=Diamond Prism of Recurrence", "=ds=#s2#", "20.00%" },
		{ 27432, "", "=q3=Broxigar's Ring of Valor", "=ds=#s13#", "20.00%" },
		{ 27431, "", "=q3=Time-Shifted Dagger", "=ds=#h3#, #w4#", "20.00%" },
		{ 0,"","","" },
		{ 24173, "", "=q4=Design: Circlet of Arcane Might", "=ds=#p12# (370)", "10.00%" },
	};

	CoTHillsbradHunterHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30589, "", "=q4=Dazzling Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 30591, "", "=q4=Empowered Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30590, "", "=q4=Enduring Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29250, "", "=q4=Cord of Sanctification", "=ds=#s10#, #a1#", "25.00%" },
		{ 29246, "", "=q4=Nightfall Wristguards", "=ds=#s8#, #a2#", "25.00%" },
		{ 30534, "", "=q4=Wyrmscale Greaves", "=ds=#s11#, #a3#", "25.00%" },
		{ 30536, "", "=q4=Greaves of the Martyr", "=ds=#s11#, #a4#", "25.00%" },
		{ 0,"","","" },
		{ 24173, "", "=q4=Design: Circlet of Arcane Might", "=ds=#p12# (370)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 28191, "", "=q3=Mana-Etched Vestments", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 28224, "", "=q3=Wastewalker Helm", "=ds=#s1#, #a2# (D3)", "8.00%" },
		{ 27911, "", "=q3=Epoch's Whispering Cinch", "=ds=#s10#, #a2#", "8.00%" },
		{ 28344, "", "=q3=Wyrmfury Pauldrons", "=ds=#s3#, #a3#", "8.00%" },
		{ 28401, "", "=q3=Hauberk of Desolation", "=ds=#s5#, #a3# (D3)", "8.00%" },
		{ 28225, "", "=q3=Doomplate Warhelm", "=ds=#s1#, #a4# (D3)", "8.00%" },
		{ 28233, "", "=q3=Necklace of Resplendent Hope", "=ds=#s2#", "8.00%" },
		{ 27904, "", "=q3=Resounding Ring of Glory", "=ds=#s13#", "8.00%" },
		{ 28227, "", "=q3=Sparking Arcanite Ring", "=ds=#s13#", "8.00%" },
		{ 28223, "", "=q3=Arcanist's Stone", "=ds=#s14#", "8.00%" },
		{ 28226, "", "=q3=Timeslicer", "=ds=#h1#, #w4#", "8.00%" },
		{ 28222, "", "=q3=Reaver of the Infinites", "=ds=#h2#, #w1#", "8.00%" },
	};

	CoTHillsbradTrash = {
		{ 25729, "", "=q3=Pattern: Stylin' Adventure Hat", "=q1=#cas12#", "2.00%" },
		{ 0,"","","" },
		{ 0, "Inv_misc_coin_02", "=q6=#cas13#", "=q5=#cas14#" },
		{ 25725, "", "=q1=Pattern: Riding Crop", "=ds=#p7# (350)" },
		{ 0,"","","" },
		{ 0, "Inv_misc_coin_02", "=q6=#cas15#", "=q5=#cas14#" },
		{ 22539, "", "=q1=Formula: Enchant Shield - Intellect", "=ds=#p4# (325)" },
	};

	CoTHillsbradThomasYance = {
		{ 25725, "", "=q1=Pattern: Riding Crop", "=ds=#p7# (350)" },
	};

	CoTHillsbradAgedDalaranWizard = {
		{ 22539, "", "=q1=Formula: Enchant Shield - Intellect", "=ds=#p4# (325)" },
	};
	
	CoTHillsbradDonCarlos = {
		{ 38329, "", "=q1=Don Carlos' Hat", "=q1=#m3#" },
		{ 38276, "", "=q1=Haliscan Brimmed Hat", "=q1=#m4#: =ds=#s1#, #a1#" },
	};
	
	CoTHillsbradDonCarlosHEROIC = {
		{ 38506, "", "=q3=Don Carlos' Famous Hat", "=ds=#s1#, #a1#" },
		{ 0,"","","" },
		{ 38329, "", "=q1=Don Carlos' Hat", "=q1=#m3#" },
		{ 38276, "", "=q1=Haliscan Brimmed Hat", "=q1=#m4#: =ds=#s1#, #a1#" },
	};

	------------------------------------
	--- Auchindoun: Shadow Labyrinth ---
	------------------------------------

	AuchShadowHellmaw = {
		{ 27889, "", "=q3=Jaedenfire Gloves of Annihilation", "=ds=#s9#, #a1#", "17.00%" },
		{ 27888, "", "=q3=Dream-Wing Helm", "=ds=#s1#, #a3#", "17.00%" },
		{ 27884, "", "=q3=Ornate Boots of the Sanctified", "=ds=#s12#, #a4#", "17.00%" },
		{ 27886, "", "=q3=Idol of the Emerald Queen", "=ds=#s16#, #w14#", "17.00%" },
		{ 27887, "", "=q3=Platinum Shield of the Valorous", "=ds=#w8#", "17.00%" },
		{ 27885, "", "=q3=Soul-Wand of the Aldor", "=ds=#w12#", "17.00%" },
	};

	AuchShadowHellmawHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27889, "", "=q3=Jaedenfire Gloves of Annihilation", "=ds=#s9#, #a1#", "17.00%" },
		{ 27888, "", "=q3=Dream-Wing Helm", "=ds=#s1#, #a3#", "17.00%" },
		{ 27884, "", "=q3=Ornate Boots of the Sanctified", "=ds=#s12#, #a4#", "17.00%" },
		{ 27886, "", "=q3=Idol of the Emerald Queen", "=ds=#s16#, #w14#", "17.00%" },
		{ 27887, "", "=q3=Platinum Shield of the Valorous", "=ds=#w8#", "17.00%" },
		{ 27885, "", "=q3=Soul-Wand of the Aldor", "=ds=#w12#", "17.00%" },
	};

	AuchShadowBlackheart = {
		{ 27892, "", "=q3=Cloak of the Inciter", "=ds=#s4#", "17.00%" },
		{ 27468, "", "=q3=Moonglade Handwraps", "=ds=#s9#, #a2# (D3)", "17.00%" },
		{ 27893, "", "=q3=Ornate Leggings of the Venerated", "=ds=#s11#, #a4#", "17.00%" },
		{ 28134, "", "=q3=Brooch of Hightened Potential", "=ds=#s2#", "17.00%" },
		{ 27891, "", "=q3=Adamantine Figurine", "=ds=#s14#", "17.00%" },
		{ 27890, "", "=q3=Wand of the Netherwing", "=ds=#w12#", "17.00%" },
		{ 0,"","","" },
		{ 25728, "", "=q3=Pattern: Stylin' Purple Hat", "=ds=#p7# (350)", "10.00%" },
		{ 0,"","","" },
		{ 30808, "", "=q1=Book of Fel Names", "=ds=#m3#", "100%" },
	};

	AuchShadowBlackheartHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27892, "", "=q3=Cloak of the Inciter", "=ds=#s4#", "17.00%" },
		{ 27468, "", "=q3=Moonglade Handwraps", "=ds=#s9#, #a2# (D3)", "17.00%" },
		{ 27893, "", "=q3=Ornate Leggings of the Venerated", "=ds=#s11#, #a4#", "17.00%" },
		{ 28134, "", "=q3=Brooch of Hightened Potential", "=ds=#s2#", "17.00%" },
		{ 27891, "", "=q3=Adamantine Figurine", "=ds=#s14#", "17.00%" },
		{ 27890, "", "=q3=Wand of the Netherwing", "=ds=#w12#", "17.00%" },
		{ 0,"","","" },
		{ 25728, "", "=q3=Pattern: Stylin' Purple Hat", "=ds=#p7# (350)", "10.00%" },
		{ 0,"","","" },
		{ 30808, "", "=q1=Book of Fel Names", "=ds=#m3#", "100%" },
	};

	AuchShadowGrandmaster = {
		{ 27775, "", "=q3=Hallowed Pauldrons", "=ds=#s3#, #a1# (D3)", "20.00%" },
		{ 27897, "", "=q3=Breastplate of Many Graces", "=ds=#s5#, #a4#", "20.00%" },
		{ 27900, "", "=q3=Jewel of Charismatic Mystique", "=ds=#s14#", "20.00%" },
		{ 27901, "", "=q3=Blackout Truncheon", "=ds=#h1#, #w6#", "20.00%" },
		{ 27898, "", "=q3=Wrathfire Hand-Cannon", "=ds=#w5#", "20.00%" },
		{ 0,"","","" },
		{ 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 30827, "", "=q1=Lexicon Demonica", "=ds=#m3#", "100%" },
	};

	AuchShadowGrandmasterHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27775, "", "=q3=Hallowed Pauldrons", "=ds=#s3#, #a1# (D3)", "20.00%" },
		{ 27897, "", "=q3=Breastplate of Many Graces", "=ds=#s5#, #a4#", "20.00%" },
		{ 27900, "", "=q3=Jewel of Charismatic Mystique", "=ds=#s14#", "20.00%" },
		{ 27901, "", "=q3=Blackout Truncheon", "=ds=#h1#, #w6#", "20.00%" },
		{ 27898, "", "=q3=Wrathfire Hand-Cannon", "=ds=#w5#", "20.00%" },
		{ 0,"","","" },
		{ 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 30827, "", "=q1=Lexicon Demonica", "=ds=#m3#", "100%" },
	};

	AuchShadowMurmur = {
		{ 24309, "", "=q4=Pattern: Spellstrike Pants", "=ds=#p8# (375)", "10.00%" },
		{ 0,"","","" },
		{ 27902, "", "=q3=Silent Slippers of Meditation", "=ds=#s12#, #a1#", "8.00%" },
		{ 27778, "", "=q3=Spaulders of Oblivion", "=ds=#s3#, #a1# (D3)", "8.00%" },
		{ 28232, "", "=q3=Robe of Oblivion", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 28230, "", "=q3=Hallowed Garments", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 27908, "", "=q3=Leggings of Assassination", "=ds=#s11#, #a2# (D3)", "8.00%" },
		{ 27909, "", "=q3=Tidefury Kilt", "=ds=#s11#, #a3# (D3)", "8.00%" },
		{ 27912, "", "=q3=Harness of the Deep Currents", "=ds=#s5#, #a3#", "8.00%" },
		{ 27803, "", "=q3=Shoulderguards of the Bold", "=ds=#s3#, #a4# (D3)", "8.00%" },
		{ 27913, "", "=q3=Whispering Blade of Slaying", "=ds=#h1#, #w4#", "8.00%" },
		{ 27905, "", "=q3=Greatsword of Horrid Dreams", "=ds=#h3#, #w10#", "8.00%" },
		{ 27903, "", "=q3=Sonic Spear", "=ds=#w7#", "8.00%" },
		{ 27910, "", "=q3=Silvermoon Crest Shield", "=ds=#w8#", "8.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "5.00%" },
	};

	AuchShadowMurmurHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30563, "", "=q4=Regal Tanzanite", "=ds=#e7#", "15.00%" },
		{ 30559, "", "=q4=Etched Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30560, "", "=q4=Rune Covered Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 30532, "", "=q4=Kirin Tor Master's Trousers", "=ds=#s11#, #a1#", "25.00%" },
		{ 29357, "", "=q4=Master Thief's Gloves", "=ds=#s9#, #a2#", "25.00%" },
		{ 29261, "", "=q4=Girdle of Ferocity", "=ds=#s10#, #a3#", "25.00%" },
		{ 29353, "", "=q4=Shockwave Truncheon", "=ds=#h3#, #w6#", "25.00%" },
		{ 0,"","","" },
		{ 24309, "", "=q4=Pattern: Spellstrike Pants", "=ds=#p8# (375)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27902, "", "=q3=Silent Slippers of Meditation", "=ds=#s12#, #a1#", "8.00%" },
		{ 27778, "", "=q3=Spaulders of Oblivion", "=ds=#s3#, #a1# (D3)", "8.00%" },
		{ 28232, "", "=q3=Robe of Oblivion", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 28230, "", "=q3=Hallowed Garments", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 27908, "", "=q3=Leggings of Assassination", "=ds=#s11#, #a2# (D3)", "8.00%" },
		{ 27909, "", "=q3=Tidefury Kilt", "=ds=#s11#, #a3# (D3)", "8.00%" },
		{ 27912, "", "=q3=Harness of the Deep Currents", "=ds=#s5#, #a3#", "8.00%" },
		{ 27803, "", "=q3=Shoulderguards of the Bold", "=ds=#s3#, #a4# (D3)", "8.00%" },
		{ 27913, "", "=q3=Whispering Blade of Slaying", "=ds=#h1#, #w4#", "8.00%" },
		{ 27905, "", "=q3=Greatsword of Horrid Dreams", "=ds=#h3#, #w10#", "8.00%" },
		{ 27903, "", "=q3=Sonic Spear", "=ds=#w7#", "8.00%" },
		{ 27910, "", "=q3=Silvermoon Crest Shield", "=ds=#w8#", "8.00%" },
		{ 0,"","","" },
		{ 31722, "", "=q1=Murmur's Essence", "=ds=#m3#", "100%" },
	};

	AuchShadowFirstFragmentGuardian = {
		{ 24514, "", "=q1=First Key Fragment", "=ds=#m3#", "100%" },
	};

	AuchShadowTrash = {
		{ 23607, "", "=q3=Plans: Felsteel Helm", "=q1=#cas9#", "8.00%" },
		{ 0,"","","" },
		{ 0, "spell_arcane_arcane01", "=q6=#cas10#", "=q5=#cas11#" },
		{ 24514, "", "=q1=First Key Fragment", "=ds=#m3#", "100%" },
	};

	---------------------------------------------
	--- Hellfire Citadel: The Shattered Halls ---
	---------------------------------------------

	HCHallsNethekurse = {
		{ 27519, "", "=q3=Cloak of Malice", "=ds=#s4#", "20.00%" },
		{ 27517, "", "=q3=Bands of Nethekurse", "=ds=#s8#, #a1#", "20.00%" },
		{ 27521, "", "=q3=Telaari Hunting Girdle", "=ds=#s10#, #a3#", "20.00%" },
		{ 27520, "", "=q3=Greathelm of the Unbreakable", "=ds=#s1#, #a4#", "20.00%" },
		{ 27518, "", "=q3=Ivory Idol of the Moongoddess", "=ds=#s16#, #w14#", "20.00%" },
		{ 0,"","","" },
		{ 24312, "", "=q4=Pattern: Spellstrike Hood", "=ds=#p8# (375)", "10.00%" },
		{ 0,"","","" },
		{ 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 23735, "", "=q1=Grand Warlock's Amulet", "=ds=#m3#", "100%" },
	};

	HCHallsNethekurseHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27519, "", "=q3=Cloak of Malice", "=ds=#s4#", "20.00%" },
		{ 27517, "", "=q3=Bands of Nethekurse", "=ds=#s8#, #a1#", "20.00%" },
		{ 27521, "", "=q3=Telaari Hunting Girdle", "=ds=#s10#, #a3#", "20.00%" },
		{ 27520, "", "=q3=Greathelm of the Unbreakable", "=ds=#s1#, #a4#", "20.00%" },
		{ 27518, "", "=q3=Ivory Idol of the Moongoddess", "=ds=#s16#, #w14#", "20.00%" },
		{ 0,"","","" },
		{ 24312, "", "=q4=Pattern: Spellstrike Hood", "=ds=#p8# (375)", "0.47%" },
		{ 0,"","","" },
		{ 21525, "", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 23735, "", "=q1=Grand Warlock's Amulet", "=ds=#m3#", "100%" },
		{ 25462, "", "=q1=Tome of Dusk", "=ds=#m3#", "100%" },
	};

	HCHallsPorung = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 30709, "", "=q3=Pantaloons of Flaming Wrath", "=ds=#s11#, #a1#", "20.00%" },
		{ 30707, "", "=q3=Nimble-foot Treads", "=ds=#s12#, #a2#", "20.00%" },
		{ 30708, "", "=q3=Belt of Flowing Thought", "=ds=#s10#, #a3#", "20.00%" },
		{ 30705, "", "=q3=Spaulders of Slaughter", "=ds=#s3#, #a4#", "20.00%" },
		{ 30710, "", "=q3=Blood Guard's Necklace of Ferocity", "=ds=#s2#", "20.00%" },
	};

	HCHallsOmrogg = {
		{ 27525, "", "=q3=Jeweled Boots of Sanctification", "=ds=#s12#, #a1#", "20.00%" },
		{ 27802, "", "=q3=Tidefury Shoulderguards", "=ds=#s3#, #a3# (D3)", "20.00%" },
		{ 27868, "", "=q3=Runesong Dagger", "=ds=#h3#, #w4#", "20.00%" },
		{ 27524, "", "=q3=Firemaul of Destruction", "=ds=#h2#, #w6#", "20.00%" },
		{ 27526, "", "=q3=Skyfire Hawk-Bow", "=ds=#w2#", "20.00%" },
		{ 0,"","","" },
		{ 30829, "", "=q1=Tear of the Earthmother", "=ds=#m3#", "100%" },
	};

	HCHallsOmroggHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27525, "", "=q3=Jeweled Boots of Sanctification", "=ds=#s12#, #a1#", "20.00%" },
		{ 27802, "", "=q3=Tidefury Shoulderguards", "=ds=#s3#, #a3# (D3)", "20.00%" },
		{ 27868, "", "=q3=Runesong Dagger", "=ds=#h3#, #w4#", "20.00%" },
		{ 27524, "", "=q3=Firemaul of Destruction", "=ds=#h2#, #w6#", "20.00%" },
		{ 27526, "", "=q3=Skyfire Hawk-Bow", "=ds=#w2#", "20.00%" },
		{ 0,"","","" },
		{ 30829, "", "=q1=Tear of the Earthmother", "=ds=#m3#", "100%" },
	};

	HCHallsKargath = {
		{ 27536, "", "=q3=Hallowed Handwraps", "=ds=#s9#, #a1# (D3)", "8.00%" },
		{ 27537, "", "=q3=Gloves of Oblivion", "=ds=#s9#, #a1# (D3)", "8.00%" },
		{ 27531, "", "=q3=Wastewalker Gloves", "=ds=#s9#, #a2# (D3)", "8.00%" },
		{ 27474, "", "=q3=Beast Lord Handguards", "=ds=#s9#, #a3# (D3)", "8.00%" },
		{ 27528, "", "=q3=Gauntlets of Desolation", "=ds=#s9#, #a3# (D3)", "8.00%" },
		{ 27535, "", "=q3=Gauntlets of the Righteous", "=ds=#s9#, #a4# (D3)", "8.00%" },
		{ 27527, "", "=q3=Greaves of the Shatterer", "=ds=#s11#, #a4#", "8.00%" },
		{ 27529, "", "=q3=Figurine of the Colossus", "=ds=#s14#", "8.00%" },
		{ 27534, "", "=q3=Hortus' Seal of Brilliance", "=ds=#s15#", "8.00%" },
		{ 27533, "", "=q3=Demonblood Eviscerator", "=ds=#h3#, #w13#", "8.00%" },
		{ 27538, "", "=q3=Lightsworn Hammer", "=ds=#h3#, #w6#", "8.00%" },
		{ 27540, "", "=q3=Nexus Torch", "=ds=#w12#", "8.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "5.00%" },
		{ 0,"","","" },
		{ 23723, "", "=q1=Warchief Kargath's Fist", "=ds=#m3#", "100%" },
	};

	HCHallsKargathHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30548, "", "=q4=Polished Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 30547, "", "=q4=Luminous Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30546, "", "=q4=Sovereign Tanzanite", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29255, "", "=q4=Bands of Rarefied Magic", "=ds=#s8#, #a1#", "25.00%" },
		{ 29263, "", "=q4=Forestheart Bracers", "=ds=#s8#, #a2#", "25.00%" },
		{ 29254, "", "=q4=Boots of the Righteous Path", "=ds=#s12#, #a4#", "25.00%" },
		{ 29348, "", "=q4=The Bladefist", "=ds=#h3#, #w13#", "25.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 23723, "", "=q1=Warchief Kargath's Fist", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 27536, "", "=q3=Hallowed Handwraps", "=ds=#s9#, #a1# (D3)", "8.00%" },
		{ 27537, "", "=q3=Gloves of Oblivion", "=ds=#s9#, #a1# (D3)", "8.00%" },
		{ 27531, "", "=q3=Wastewalker Gloves", "=ds=#s9#, #a2# (D3)", "8.00%" },
		{ 27474, "", "=q3=Beast Lord Handguards", "=ds=#s9#, #a3# (D3)", "8.00%" },
		{ 27528, "", "=q3=Gauntlets of Desolation", "=ds=#s9#, #a3# (D3)", "8.00%" },
		{ 27535, "", "=q3=Gauntlets of the Righteous", "=ds=#s9#, #a4# (D3)", "8.00%" },
		{ 27527, "", "=q3=Greaves of the Shatterer", "=ds=#s11#, #a4#", "8.00%" },
		{ 27529, "", "=q3=Figurine of the Colossus", "=ds=#s14#", "8.00%" },
		{ 27534, "", "=q3=Hortus' Seal of Brilliance", "=ds=#s15#", "8.00%" },
		{ 27533, "", "=q3=Demonblood Eviscerator", "=ds=#h3#, #w13#", "8.00%" },
		{ 27538, "", "=q3=Lightsworn Hammer", "=ds=#h3#, #w6#", "8.00%" },
		{ 27540, "", "=q3=Nexus Torch", "=ds=#w12#", "8.00%" },
	};

	HCHallsExecutioner = {
		{ 31716, "", "=q1=Unused Axe of the Executioner", "=ds=#m3#", "100%" },
	};

	HCHallsTrash = {
		{ 22554, "", "=q2=Formula: Enchant 2H Weapon - Savagery", "=q1=#cas19#", "2.00%" },
	}; 

	------------------------------------------
	--- Coilfang Reservoir: The Steamvault ---
	------------------------------------------

	CFRSteamThespia = {
		{ 27508, "", "=q3=Incanter's Gloves", "=ds=#s9#, #a1# (D3)", "20.00%" },
		{ 27789, "", "=q3=Cloak of Whispering Shells", "=ds=#s4#", "20.00%" },
		{ 27787, "", "=q3=Chestguard of No Remorse", "=ds=#s5#, #a2#", "20.00%" },
		{ 27783, "", "=q3=Moonrage Girdle", "=ds=#s10#, #a2#", "20.00%" },
		{ 27784, "", "=q3=Scintillating Coral Band", "=ds=#s13#", "20.00%" },
		{ 0,"","","" },
		{ 29673, "", "=q2=Pattern: Frost Armor Kit", "=ds=#p7# (340)", "10.00%" },
		{ 0,"","","" },
		{ 30828, "", "=q1=Vial of Underworld Loam", "=ds=#m3#", "100%" },
	};

	CFRSteamThespiaHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27508, "", "=q3=Incanter's Gloves", "=ds=#s9#, #a1# (D3)", "20.00%" },
		{ 27789, "", "=q3=Cloak of Whispering Shells", "=ds=#s4#", "20.00%" },
		{ 27787, "", "=q3=Chestguard of No Remorse", "=ds=#s5#, #a2#", "20.00%" },
		{ 27783, "", "=q3=Moonrage Girdle", "=ds=#s10#, #a2#", "20.00%" },
		{ 27784, "", "=q3=Scintillating Coral Band", "=ds=#s13#", "20.00%" },
		{ 0,"","","" },
		{ 29673, "", "=q2=Pattern: Frost Armor Kit", "=ds=#p7# (340)", "13.00%" },
		{ 0,"","","" },
		{ 30828, "", "=q1=Vial of Underworld Loam", "=ds=#m3#", "100%" },
	};

	CFRSteamSecondFragmentGuardian = {
		{ 24487, "", "=q1=Second Key Fragment", "=ds=#m3#", "100%" },
	};

	CFRSteamSteamrigger = {
		{ 27793, "", "=q3=Earth Mantle Handwraps", "=ds=#s9#, #a3#", "20.00%" },
		{ 27790, "", "=q3=Mask of Pennance", "=ds=#s1#, #a4#", "20.00%" },
		{ 27792, "", "=q3=Steam-Hinge Chain of Valor", "=ds=#s2#", "20.00%" },
		{ 27791, "", "=q3=Serpentcrest Life-Staff", "=ds=#w9#", "20.00%" },
		{ 27794, "", "=q3=Recoilless Rocket Ripper X-54", "=ds=#w5#", "20.00%" },
		{ 0,"","","" },
		{ 23887, "", "=q3=Schematic: Rocket Boots Xtreme", "=ds=#p5# (355)", "10.00%" },
	};

	CFRSteamSteamriggerHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27793, "", "=q3=Earth Mantle Handwraps", "=ds=#s9#, #a3#", "20.00%" },
		{ 27790, "", "=q3=Mask of Pennance", "=ds=#s1#, #a4#", "20.00%" },
		{ 27792, "", "=q3=Steam-Hinge Chain of Valor", "=ds=#s2#", "20.00%" },
		{ 27791, "", "=q3=Serpentcrest Life-Staff", "=ds=#w9#", "20.00%" },
		{ 27794, "", "=q3=Recoilless Rocket Ripper X-54", "=ds=#w5#", "20.00%" },
		{ 0,"","","" },
		{ 23887, "", "=q3=Schematic: Rocket Boots Xtreme", "=ds=#p5# (355)", "10.00%" },
	};

	CFRSteamWarlord = {
		{ 27804, "", "=q3=Devilshark Cape", "=ds=#s4#", "8.00%" },
		{ 27799, "", "=q3=Vermillion Robes of the Dominant", "=ds=#s5#, #a1#", "8.00%" },
		{ 27795, "", "=q3=Sash of Serpentra", "=ds=#s10#, #a1#", "8.00%" },
		{ 27738, "", "=q3=Incanter's Pauldrons", "=ds=#s3#, #a1# (D3)", "8.00%" },
		{ 27737, "", "=q3=Moonglade Shoulders", "=ds=#s3#, #a2# (D3)", "8.00%" },
		{ 27801, "", "=q3=Beast Lord Mantle", "=ds=#s3#, #a3# (D3)", "8.00%" },
		{ 27510, "", "=q3=Tidefury Gauntlets", "=ds=#s9#, #a3# (D3)", "8.00%" },
		{ 27874, "", "=q3=Beast Lord Leggings", "=ds=#s11#, #a3# (D3)", "8.00%" },
		{ 27806, "", "=q3=Fathomheart Gauntlets", "=ds=#s9#, #a3#", "8.00%" },
		{ 28203, "", "=q3=Breastplate of the Righteous", "=ds=#s5#, #a4# (D3)", "8.00%" },
		{ 27475, "", "=q3=Gauntlets of the Bold", "=ds=#s9#, #a4# (D3)", "8.00%" },
		{ 27805, "", "=q3=Ring of the Silver Hand", "=ds=#s13#", "8.00%" },
		{ 0,"","","" },
		{ 24313, "", "=q4=Pattern: Battlecast Hood", "=ds=#p8# (375)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "5.00%" },
	};

	CFRSteamWarlordHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30550, "", "=q4=Sundered Chrysoprase", "=ds=#e7#", "15.00%" },
		{ 30551, "", "=q4=Infused Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30549, "", "=q4=Shifting Tanzanite", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 30543, "", "=q4=Pontifex Kilt", "=ds=#s11#, #a1#", "25.00%" },
		{ 29243, "", "=q4=Wave-Fury Vambraces", "=ds=#s8#, #a3#", "25.00%" },
		{ 29463, "", "=q4=Amber Bands of the Aggressor", "=ds=#s8#, #a4#", "25.00%" },
		{ 29351, "", "=q4=Wrathtide Longbow", "=ds=#w2#", "25.00%" },
		{ 0,"","","" },
		{ 24313, "", "=q4=Pattern: Battlecast Hood", "=ds=#p8# (375)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 31721, "", "=q1=Kalithresh's Trident", "=ds=#m3#", "100%" },
		{ 27804, "", "=q3=Devilshark Cape", "=ds=#s4#", "8.00%" },
		{ 27799, "", "=q3=Vermillion Robes of the Dominant", "=ds=#s5#, #a1#", "8.00%" },
		{ 27795, "", "=q3=Sash of Serpentra", "=ds=#s10#, #a1#", "8.00%" },
		{ 27738, "", "=q3=Incanter's Pauldrons", "=ds=#s3#, #a1# (D3)", "8.00%" },
		{ 27737, "", "=q3=Moonglade Shoulders", "=ds=#s3#, #a2# (D3)", "8.00%" },
		{ 27801, "", "=q3=Beast Lord Mantle", "=ds=#s3#, #a3# (D3)", "8.00%" },
		{ 27510, "", "=q3=Tidefury Gauntlets", "=ds=#s9#, #a3# (D3)", "8.00%" },
		{ 27874, "", "=q3=Beast Lord Leggings", "=ds=#s11#, #a3# (D3)", "8.00%" },
		{ 27806, "", "=q3=Fathomheart Gauntlets", "=ds=#s9#, #a3#", "8.00%" },
		{ 28203, "", "=q3=Breastplate of the Righteous", "=ds=#s5#, #a4# (D3)", "8.00%" },
		{ 27475, "", "=q3=Gauntlets of the Bold", "=ds=#s9#, #a4# (D3)", "8.00%" },
		{ 27805, "", "=q3=Ring of the Silver Hand", "=ds=#s13#", "8.00%" },
	};

	CFRSteamTrash = {
		{ 24159, "", "=q3=Design: Khorium Band of Frost", "=q1=#cas16#", "1.86%" },
		{ 22533, "", "=q2=Formula: Enchant Bracer - Fortitude", "=q1=#cas17#", "2.00%" },
		{ 0,"","","" },
		{ 24367, "", "=q1=Orders from Lady Vashj", "=ds=#m2#" },
		{ 24368, "", "=q1=Coilfang Armaments", "=ds=#m3#", "12.68%" },
		{ 0,"","","" },
		{ 0, "spell_arcane_arcane01", "=q6=#cas18#", "=q5=#cas11#" },
		{ 24487, "", "=q1=Second Key Fragment", "=ds=#m3#", "100%" },
	};

	-----------------------------------------
	--- Caverns of Time: The Black Morass ---
	-----------------------------------------

	CoTMorassDeja = {
		{ 27988, "", "=q3=Burnoose of Shifting Ages", "=ds=#s4#", "17.00%" },
		{ 27994, "", "=q3=Mantle of Three Terrors", "=ds=#s3#, #a1#", "17.00%" },
		{ 27995, "", "=q3=Sun-Gilded Shouldercaps", "=ds=#s3#, #a2#", "17.00%" },
		{ 27993, "", "=q3=Mask of Inner Fire", "=ds=#s1#, #a3#", "17.00%" },
		{ 27996, "", "=q3=Ring of Spiritual Precision", "=ds=#s13#", "17.00%" },
		{ 27987, "", "=q3=Melmorta's Twilight Longbow", "=ds=#w2#", "17.00%" },
		{ 0,"","","" },
		{ 29675, "", "=q2=Pattern: Arcane Armor Kit", "=ds=#p7# (340)", "10.00%" },
	};

	CoTMorassDejaHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 27988, "", "=q3=Burnoose of Shifting Ages", "=ds=#s4#", "17.00%" },
		{ 27994, "", "=q3=Mantle of Three Terrors", "=ds=#s3#, #a1#", "17.00%" },
		{ 27995, "", "=q3=Sun-Gilded Shouldercaps", "=ds=#s3#, #a2#", "17.00%" },
		{ 27993, "", "=q3=Mask of Inner Fire", "=ds=#s1#, #a3#", "17.00%" },
		{ 27996, "", "=q3=Ring of Spiritual Precision", "=ds=#s13#", "17.00%" },
		{ 27987, "", "=q3=Melmorta's Twilight Longbow", "=ds=#w2#", "17.00%" },
		{ 0,"","","" },
		{ 29675, "", "=q2=Pattern: Arcane Armor Kit", "=ds=#p7# (340)", "10.00%" },
	};

	CoTMorassTemporus = {
		{ 28185, "", "=q3=Khadgar's Kilt of Abjuration", "=ds=#s11#, #a1#", "17.00%" },
		{ 28186, "", "=q3=Laughing Skull Battle-Harness", "=ds=#s5#, #a3#", "17.00%" },
		{ 28034, "", "=q3=Hourglass of the Unraveller", "=ds=#s14#", "17.00%" },
		{ 28187, "", "=q3=Star-Heart Lamp", "=ds=#s15#", "17.00%" },
		{ 28184, "", "=q3=Millennium Blade", "=ds=#h1#, #w10#", "17.00%" },
		{ 28033, "", "=q3=Epoch-Mender", "=ds=#w9#", "17.00%" },
	};

	CoTMorassTemporusHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28185, "", "=q3=Khadgar's Kilt of Abjuration", "=ds=#s11#, #a1#", "17.00%" },
		{ 28186, "", "=q3=Laughing Skull Battle-Harness", "=ds=#s5#, #a3#", "17.00%" },
		{ 28034, "", "=q3=Hourglass of the Unraveller", "=ds=#s14#", "17.00%" },
		{ 28187, "", "=q3=Star-Heart Lamp", "=ds=#s15#", "17.00%" },
		{ 28184, "", "=q3=Millennium Blade", "=ds=#h1#, #w10#", "17.00%" },
		{ 28033, "", "=q3=Epoch-Mender", "=ds=#w9#", "17.00%" },
	};

	CoTMorassAeonus = {
		{ 28193, "", "=q3=Mana-Etched Crown", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 27509, "", "=q3=Handgrips of Assassination", "=ds=#s9#, #a2# (D3)", "8.00%" },
		{ 27873, "", "=q3=Moonglade Pants", "=ds=#s11#, #a2# (D3)", "8.00%" },
		{ 28206, "", "=q3=Cowl of the Guiltless", "=ds=#s1#, #a2#", "8.00%" },
		{ 28192, "", "=q3=Helm of Desolation", "=ds=#s1#, #a3# (D3)", "8.00%" },
		{ 28194, "", "=q3=Primal Surge Bracers", "=ds=#s8#, #a3#", "8.00%" },
		{ 27977, "", "=q3=Legplates of the Bold", "=ds=#s11#, #a4# (D3)", "8.00%" },
		{ 27839, "", "=q3=Legplates of the Righteous", "=ds=#s11#, #a4# (D3)", "8.00%" },
		{ 28207, "", "=q3=Pauldrons of the Crimson Flight", "=ds=#s3#, #a4#", "8.00%" },
		{ 28190, "", "=q3=Scarab of the Infinite Cycle", "=ds=#s14#", "8.00%" },
		{ 28189, "", "=q3=Latro's Shifting Sword", "=ds=#h1#, #w10#", "8.00%" },
		{ 28188, "", "=q3=Bloodfire Greatstaff", "=ds=#w9#", "8.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "7.00%" },
	};

	CoTMorassAeonusHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30558, "", "=q4=Glimmering Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30556, "", "=q4=Glinting Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30555, "", "=q4=Glowing Tanzanite", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 30531, "", "=q4=Breeches of the Occultist", "=ds=#s11#, #a1#", "25.00%" },
		{ 29247, "", "=q4=Girdle of the Deathdealer", "=ds=#s10#, #a2#", "25.00%" },
		{ 29253, "", "=q4=Girdle of Valorous Deeds", "=ds=#s10#, #a4#", "25.00%" },
		{ 29356, "", "=q4=Quantum Blade", "=ds=#h2#, #w10#", "25.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 28193, "", "=q3=Mana-Etched Crown", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 27509, "", "=q3=Handgrips of Assassination", "=ds=#s9#, #a2# (D3)", "8.00%" },
		{ 27873, "", "=q3=Moonglade Pants", "=ds=#s11#, #a2# (D3)", "8.00%" },
		{ 28206, "", "=q3=Cowl of the Guiltless", "=ds=#s1#, #a2#", "8.00%" },
		{ 28194, "", "=q3=Primal Surge Bracers", "=ds=#s8#, #a3#", "8.00%" },
		{ 28192, "", "=q3=Helm of Desolation", "=ds=#s1#, #a3# (D3)", "8.00%" },
		{ 28207, "", "=q3=Pauldrons of the Crimson Flight", "=ds=#s3#, #a4#", "8.00%" },
		{ 27977, "", "=q3=Legplates of the Bold", "=ds=#s11#, #a4# (D3)", "8.00%" },
		{ 27839, "", "=q3=Legplates of the Righteous", "=ds=#s11#, #a4# (D3)", "8.00%" },
		{ 28190, "", "=q3=Scarab of the Infinite Cycle", "=ds=#s14#", "8.00%" },
		{ 28189, "", "=q3=Latro's Shifting Sword", "=ds=#h1#, #w10#", "8.00%" },
		{ 28188, "", "=q3=Bloodfire Greatstaff", "=ds=#w9#", "8.00%" },
	};

	CoTMorassTrash = {
		{ 25730, "", "=q3=Pattern: Stylin' Jungle Hat", "=ds=#p7# (350) =q1=#n95#", "0.29%" },
	};

	----------------------------------
	--- Tempest Keep: The Mechanar ---
	----------------------------------

	TKMechGyro = {
		{ 30436, "", "=q1=Jagged Blue Crystal", "=ds=#e9#", "100%" },
	};

	TKMechIron = {
		{ 30437, "", "=q1=Jagged Red Crystal", "=ds=#e9#", "100%" },
	};

	TKMechCacheoftheLegion = {
		{ 28249, "", "=q3=Capacitus' Cloak of Calibration", "=ds=#s4#", "20.00%" },
		{ 28250, "", "=q3=Vestia's Pauldrons of Inner Grace", "=ds=#s3#, #a1#", "20.00%" },
		{ 28252, "", "=q3=Bloodfyre Robes of Annihilation", "=ds=#s5#, #a1#", "20.00%" },
		{ 28251, "", "=q3=Boots of the Glade-Keeper", "=ds=#s12#, #a2#", "20.00%" },
		{ 28248, "", "=q3=Totem of the Void", "=ds=#s16#, #w15#", "20.00%" },
	};
	
	TKMechCacheoftheLegionHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28249, "", "=q3=Capacitus' Cloak of Calibration", "=ds=#s4#", "20.00%" },
		{ 28250, "", "=q3=Vestia's Pauldrons of Inner Grace", "=ds=#s3#, #a1#", "20.00%" },
		{ 28252, "", "=q3=Bloodfyre Robes of Annihilation", "=ds=#s5#, #a1#", "20.00%" },
		{ 28251, "", "=q3=Boots of the Glade-Keeper", "=ds=#s12#, #a2#", "20.00%" },
		{ 28248, "", "=q3=Totem of the Void", "=ds=#s16#, #w15#", "20.00%" },
	};

	TKMechCapacitus = {
		{ 28256, "", "=q3=Thoriumweave Cloak", "=ds=#s4#", "20.00%" },
		{ 28255, "", "=q3=Lunar-Claw Pauldrons", "=ds=#s3#, #a2#", "20.00%" },
		{ 28254, "", "=q3=Warp Engineer's Prismatic Chain", "=ds=#s2#", "20.00%" },
		{ 28257, "", "=q3=Hammer of the Penitent", "=ds=#h3#, #w6#", "20.00%" },
		{ 28253, "", "=q3=Plasma Rat's Hyper-Scythe", "=ds=#w7#", "20.00%" },
	};

	TKMechCapacitusHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28256, "", "=q3=Thoriumweave Cloak", "=ds=#s4#", "20.00%" },
		{ 28255, "", "=q3=Lunar-Claw Pauldrons", "=ds=#s3#, #a2#", "20.00%" },
		{ 28254, "", "=q3=Warp Engineer's Prismatic Chain", "=ds=#s2#", "20.00%" },
		{ 28257, "", "=q3=Hammer of the Penitent", "=ds=#h3#, #w6#", "20.00%" },
		{ 28253, "", "=q3=Plasma Rat's Hyper-Scythe", "=ds=#w7#", "20.00%" },
	};

	TKMechOverchargedManacell = {
		{ 30824, "", "=q1=Overcharged Manacell", "=ds=#m3#" },
	};

	TKMechSepethrea = {
		{ 28262, "", "=q3=Jade-Skull Breastplate", "=ds=#s5#, #a4#", "20.00%" },
		{ 28259, "", "=q3=Cosmic Lifeband", "=ds=#s13#", "20.00%" },
		{ 28260, "", "=q3=Manual of the Nethermancer", "=ds=#s15#", "20.00%" },
		{ 28263, "", "=q3=Stellaris", "=ds=#h1#, #w1#", "20.00%" },
		{ 28258, "", "=q3=Nethershrike", "=ds=#w11#", "20.00%" },
		{ 0,"","","" },
		{ 22920, "", "=q2=Recipe: Major Fire Protection Potion", "=ds=#p1# (360)", "10.00%" },
		{ 0,"","","" },
		{ 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
	};

	TKMechSepethreaHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28262, "", "=q3=Jade-Skull Breastplate", "=ds=#s5#, #a4#", "20.00%" },
		{ 28259, "", "=q3=Cosmic Lifeband", "=ds=#s13#", "20.00%" },
		{ 28260, "", "=q3=Manual of the Nethermancer", "=ds=#s15#", "20.00%" },
		{ 28263, "", "=q3=Stellaris", "=ds=#h1#, #w1#", "20.00%" },
		{ 28258, "", "=q3=Nethershrike", "=ds=#w11#", "20.00%" },
		{ 0,"","","" },
		{ 22920, "", "=q2=Recipe: Major Fire Protection Potion", "=ds=#p1# (360)", "10.00%" },
		{ 0,"","","" },
		{ 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
	};

	TKMechCalc = {
		{ 28269, "", "=q3=Baba's Cloak of Arcanistry", "=ds=#s4#", "8.00%" },
		{ 28278, "", "=q3=Incanter's Cowl", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 28202, "", "=q3=Moonglade Robe", "=ds=#s5#, #a2# (D3)", "8.00%" },
		{ 28204, "", "=q3=Tunic of Assassination", "=ds=#s5#, #a2# (D3)", "8.00%" },
		{ 28275, "", "=q3=Beast Lord Helm", "=ds=#s1#, #a3# (D3)", "8.00%" },
		{ 28266, "", "=q3=Molten Earth Kilt", "=ds=#s11#, #a3#", "8.00%" },
		{ 28285, "", "=q3=Helm of the Righteous", "=ds=#s1#, #a4# (D3)", "8.00%" },
		{ 28265, "", "=q3=Dath'Remar's Ring of Defense", "=ds=#s13#", "8.00%" },
		{ 28288, "", "=q3=Abacus of Violent Odds", "=ds=#s14#", "8.00%" },
		{ 27899, "", "=q3=Mana Wrath", "=ds=#h3#, #w10#", "8.00%" },
		{ 28267, "", "=q3=Edge of the Cosmos", "=ds=#h1#, #w10#", "8.00%" },
		{ 28286, "", "=q3=Telescopic Sharprifle", "=ds=#w5#", "8.00%" },
		{ 0,"","","" },
		{ 21907, "", "=q2=Pattern: Arcanoweave Robe", "=ds=#p8# (370)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "5.00%" },
		{ 0,"","","" },
		{ 31086, "", "=q1=Bottom Shard of the Arcatraz Key", "=ds=#m3#", "100%" },
	};

	TKMechCalcHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30565, "", "=q4=Assassin's Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30566, "", "=q4=Defender's Tanzanite", "=ds=#e7#", "15.00%" },
		{ 30564, "", "=q4=Shining Fire Opal", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29251, "", "=q4=Boots of the Pious", "=ds=#s12#, #a1#", "33.00%" },
		{ 30533, "", "=q4=Vanquisher's Legplates", "=ds=#s11#, #a4#", "33.00%" },
		{ 29362, "", "=q4=The Sun Eater", "=ds=#h1#, #w10#", "33.00%" },
		{ 0,"","","" },
		{ 21907, "", "=q2=Pattern: Arcanoweave Robe", "=ds=#p8# (370)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 31086, "", "=q1=Bottom Shard of the Arcatraz Key", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 28269, "", "=q3=Baba's Cloak of Arcanistry", "=ds=#s4#", "8.00%" },
		{ 28278, "", "=q3=Incanter's Cowl", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 28202, "", "=q3=Moonglade Robe", "=ds=#s5#, #a2# (D3)", "8.00%" },
		{ 28204, "", "=q3=Tunic of Assassination", "=ds=#s5#, #a2# (D3)", "8.00%" },
		{ 28275, "", "=q3=Beast Lord Helm", "=ds=#s1#, #a3# (D3)", "8.00%" },
		{ 28266, "", "=q3=Molten Earth Kilt", "=ds=#s11#, #a3#", "8.00%" },
		{ 28285, "", "=q3=Helm of the Righteous", "=ds=#s1#, #a4# (D3)", "8.00%" },
		{ 28265, "", "=q3=Dath'Remar's Ring of Defense", "=ds=#s13#", "8.00%" },
		{ 28288, "", "=q3=Abacus of Violent Odds", "=ds=#s14#", "8.00%" },
		{ 27899, "", "=q3=Mana Wrath", "=ds=#h3#, #w10#", "8.00%" },
		{ 28267, "", "=q3=Edge of the Cosmos", "=ds=#h1#, #w10#", "8.00%" },
		{ 28286, "", "=q3=Telescopic Sharprifle", "=ds=#w5#", "8.00%" },
	};

	TKMechTrash = {
		{ 22920, "", "=q2=Recipe: Major Fire Protection Potion", "=q1=#cas23#", "1.90%" },
		{ 21906, "", "=q2=Pattern: Arcanoweave Boots", "=q1=#cas23#", "8.00%" },
		{ 0,"","","" },
		{ 0, "spell_shadow_metamorphosis", "=q6=#cas24#", "=q5=#cas25#" },
		{ 30436, "", "=q1=Jagged Blue Crystal", "=ds=#e9#", "100%" },
		{ 0,"","","" },
		{ 0, "spell_shadow_metamorphosis", "=q6=#cas26#", "=q5=#cas25#" },
		{ 30437, "", "=q1=Jagged Red Crystal", "=ds=#e9#", "100%" },
	};

	----------------------------------
	--- Tempest Keep: The Botanica ---
	----------------------------------
	
	TKBotSarannis = {
		{ 28301, "", "=q3=Syrannis' Mystic Sheen", "=ds=#s4#", "20.00%" },
		{ 28304, "", "=q3=Prismatic Mittens of Mending", "=ds=#s9#, #a1#", "20.00%" },
		{ 28306, "", "=q3=Towering Mantle of the Hunt", "=ds=#s3#, #a3#", "20.00%" },
		{ 28296, "", "=q3=Libram of the Lightbringer", "=ds=#s16#, #w16#", "20.00%" },
		{ 28311, "", "=q3=Revenger", "=ds=#h1#, #w10#", "20.00%" },
		{ 0,"","","" },
		{ 28769, "", "=q1=The Keystone", "=ds=#m3#", "100%" },
	};

	TKBotSarannisHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28301, "", "=q3=Syrannis' Mystic Sheen", "=ds=#s4#", "20.00%" },
		{ 28304, "", "=q3=Prismatic Mittens of Mending", "=ds=#s9#, #a1#", "20.00%" },
		{ 28306, "", "=q3=Towering Mantle of the Hunt", "=ds=#s3#, #a3#", "20.00%" },
		{ 28296, "", "=q3=Libram of the Lightbringer", "=ds=#s16#, #w16#", "20.00%" },
		{ 28311, "", "=q3=Revenger", "=ds=#h1#, #w10#", "20.00%" },
		{ 0,"","","" },
		{ 28769, "", "=q1=The Keystone", "=ds=#m3#", "100%" },
	};

	TKBotFreywinn = {
		{ 28317, "", "=q3=Energis Armwraps", "=ds=#s9#, #a1#", "20.00%" },
		{ 28318, "", "=q3=Obsidian Clodstompers", "=ds=#s12#, #a4#", "20.00%" },
		{ 28321, "", "=q3=Enchanted Thorium Torque", "=ds=#s2#", "20.00%" },
		{ 28315, "", "=q3=Stormreaver Warblades", "=ds=#h4#, #w13#", "20.00%" },
		{ 28316, "", "=q3=Aegis of the Sunbird", "=ds=#w8#", "20.00%" },
		{ 0,"","","" },
		{ 23617, "", "=q3=Plans: Earthpeace Breastplate", "=ds=#p2# (370)", "10.00%" },
		{ 0,"","","" },
		{ 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 31744, "", "=q1=Botanist's Field Guide", "=ds=#m3#", "100%" },
	};

	TKBotFreywinnHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28317, "", "=q3=Energis Armwraps", "=ds=#s9#, #a1#", "20.00%" },
		{ 28318, "", "=q3=Obsidian Clodstompers", "=ds=#s12#, #a4#", "20.00%" },
		{ 28321, "", "=q3=Enchanted Thorium Torque", "=ds=#s2#", "20.00%" },
		{ 28315, "", "=q3=Stormreaver Warblades", "=ds=#h4#, #w13#", "20.00%" },
		{ 28316, "", "=q3=Aegis of the Sunbird", "=ds=#w8#", "20.00%" },
		{ 0,"","","" },
		{ 23617, "", "=q3=Plans: Earthpeace Breastplate", "=ds=#p2# (370)", "14.00%" },
		{ 0,"","","" },
		{ 21524, "", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
		{ 0,"","","" },
		{ 31744, "", "=q1=Botanist's Field Guide", "=ds=#m3#", "100%" },
	};

	TKBotThorngrin = {
		{ 28324, "", "=q3=Gauntlets of Cruel Intention", "=ds=#s9#, #a4#", "20.00%" },
		{ 28327, "", "=q3=Arcane Netherband", "=ds=#s13#", "20.00%" },
		{ 28323, "", "=q3=Ring of Umbral Doom", "=ds=#s13#", "20.00%" },
		{ 28322, "", "=q3=Runed Dagger of Solace", "=ds=#h3#, #w4#", "20.00%" },
		{ 28325, "", "=q3=Dreamer's Dragonstaff", "=ds=#w9#", "20.00%" },
		{ 0,"","","" },
		{ 24310, "", "=q4=Pattern: Battlecast Pants", "=ds=#p8# (375)", "10.00%" },
	};

	TKBotThorngrinHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28324, "", "=q3=Gauntlets of Cruel Intention", "=ds=#s9#, #a4#", "20.00%" },
		{ 28327, "", "=q3=Arcane Netherband", "=ds=#s13#", "20.00%" },
		{ 28323, "", "=q3=Ring of Umbral Doom", "=ds=#s13#", "20.00%" },
		{ 28322, "", "=q3=Runed Dagger of Solace", "=ds=#h3#, #w4#", "20.00%" },
		{ 28325, "", "=q3=Dreamer's Dragonstaff", "=ds=#w9#", "20.00%" },
		{ 0,"","","" },
		{ 24310, "", "=q4=Pattern: Battlecast Pants", "=ds=#p8# (375)", "10.00%" },
	};

	TKBotLaj = {
		{ 28328, "", "=q3=Mithril-Bark Cloak", "=ds=#s4#", "20.00%" },
		{ 28338, "", "=q3=Devil-Stitched Leggings", "=ds=#s11#, #a1#", "20.00%" },
		{ 28340, "", "=q3=Mantle of Autumn", "=ds=#s3#, #a2#", "20.00%" },
		{ 28339, "", "=q3=Boots of the Shifting Sands", "=ds=#s12#, #a2#", "20.00%" },
		{ 27739, "", "=q3=Spaulders of the Righteous", "=ds=#s3#, #a4# (D3)", "20.00%" },
	};

	TKBotLajHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28328, "", "=q3=Mithril-Bark Cloak", "=ds=#s4#", "20.00%" },
		{ 28338, "", "=q3=Devil-Stitched Leggings", "=ds=#s11#, #a1#", "20.00%" },
		{ 28340, "", "=q3=Mantle of Autumn", "=ds=#s3#, #a2#", "20.00%" },
		{ 28339, "", "=q3=Boots of the Shifting Sands", "=ds=#s12#, #a2#", "20.00%" },
		{ 27739, "", "=q3=Spaulders of the Righteous", "=ds=#s3#, #a4# (D3)", "20.00%" },
	};

	TKBotSplinter = {
		{ 28371, "", "=q3=Netherfury Cape", "=ds=#s4#", "8.00%" },
		{ 28342, "", "=q3=Warp Infused Drape", "=ds=#s5#, #a1#", "8.00%" },
		{ 28229, "", "=q3=Incanter's Robe", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 28348, "", "=q3=Moonglade Cowl", "=ds=#s1#, #a2# (D3)", "8.00%" },
		{ 28347, "", "=q3=Warpscale Leggings", "=ds=#s11#, #a2#", "8.00%" },
		{ 28349, "", "=q3=Tidefury Helm", "=ds=#s1#, #a3# (D3)", "8.00%" },
		{ 28228, "", "=q3=Beast Lord Curiass", "=ds=#s5#, #a3# (D3)", "8.00%" },
		{ 28350, "", "=q3=Warhelm of the Bold", "=ds=#s1#, #a4# (D3)", "8.00%" },
		{ 28343, "", "=q3=Jagged Bark Pendant", "=ds=#s2#", "8.00%" },
		{ 28370, "", "=q3=Bangle of Endless Blessings", "=ds=#s14#", "8.00%" },
		{ 28345, "", "=q3=Warp Splinter's Thorn", "=ds=#h1#, #w4#", "8.00%" },
		{ 28367, "", "=q3=Greatsword of Forlorn Visions", "=ds=#h2#, #w10#", "8.00%" },
		{ 28341, "", "=q3=Warpstaff of Arcanum", "=ds=#w9#", "8.00%" },
		{ 0,"","","" },
		{ 24311, "", "=q4=Pattern: Whitemend Hood", "=ds=#p8# (375)", "10.00%" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "5.00%" },
		{ 0,"","","" },
		{ 31085, "", "=q1=Top Shard of the Arcatraz Key", "=ds=#m3#", "100%" },
	};

	TKBotSplinterHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30574, "", "=q4=Brutal Tanzanite", "=ds=#e7#", "15.00%" },
		{ 30572, "", "=q4=Imperial Tanzanite", "=ds=#e7#", "15.00%" },
		{ 30573, "", "=q4=Mysterious Fire Opal", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29258, "", "=q4=Boots of Ethereal Manipulation", "=ds=#s11#, #a1#", "33.00%" },
		{ 29262, "", "=q4=Boots of the Endless Hunt", "=ds=#s12#, #a3#", "33.00%" },
		{ 29359, "", "=q4=Feral Staff of Lashing", "=ds=#w9#", "33.00%" },
		{ 0,"","","" },
		{ 24311, "", "=q4=Pattern: Whitemend Hood", "=ds=#p8# (375)", "10.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 31085, "", "=q1=Top Shard of the Arcatraz Key", "=ds=#m3#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 28371, "", "=q3=Netherfury Cape", "=ds=#s4#", "8.00%" },
		{ 28342, "", "=q3=Warp Infused Drape", "=ds=#s5#, #a1#", "8.00%" },
		{ 28229, "", "=q3=Incanter's Robe", "=ds=#s5#, #a1# (D3)", "8.00%" },
		{ 28348, "", "=q3=Moonglade Cowl", "=ds=#s1#, #a2# (D3)", "8.00%" },
		{ 28347, "", "=q3=Warpscale Leggings", "=ds=#s11#, #a2#", "8.00%" },
		{ 28349, "", "=q3=Tidefury Helm", "=ds=#s1#, #a3# (D3)", "8.00%" },
		{ 28228, "", "=q3=Beast Lord Curiass", "=ds=#s5#, #a3# (D3)", "8.00%" },
		{ 28350, "", "=q3=Warhelm of the Bold", "=ds=#s1#, #a4# (D3)", "8.00%" },
		{ 28343, "", "=q3=Jagged Bark Pendant", "=ds=#s2#", "8.00%" },
		{ 28370, "", "=q3=Bangle of Endless Blessings", "=ds=#s14#", "8.00%" },
		{ 28345, "", "=q3=Warp Splinter's Thorn", "=ds=#h1#, #w4#", "8.00%" },
		{ 28367, "", "=q3=Greatsword of Forlorn Visions", "=ds=#h2#, #w10#", "8.00%" },
		{ 28341, "", "=q3=Warpstaff of Arcanum", "=ds=#w9#", "8.00%" },
	};

	TKBotTrash = {
		{ 24172, "", "=q4=Design: Coronet of Verdant Flame", "=q1=#cas27#", "5.00%" },
	};

	----------------------------------
	--- Tempest Keep: The Arcatraz ---
	----------------------------------

	TKArcUnbound = {
		{ 28373, "", "=q3=Cloak of Scintillating Auras", "=ds=#s4#", "20.00%" },
		{ 28374, "", "=q3=Mana-Sphere Shoulderguards", "=ds=#s3#, #a1#", "20.00%" },
		{ 28384, "", "=q3=Outland Striders", "=ds=#s12#, #a3#", "20.00%" },
		{ 28375, "", "=q3=Rubium War-Girdle", "=ds=#s10#, #a4#", "20.00%" },
		{ 28372, "", "=q3=Idol of Feral Shadows", "=ds=#s16#, #w14#", "20.00%" },
	};

	TKArcUnboundHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28373, "", "=q3=Cloak of Scintillating Auras", "=ds=#s4#", "20.00%" },
		{ 28374, "", "=q3=Mana-Sphere Shoulderguards", "=ds=#s3#, #a1#", "20.00%" },
		{ 28384, "", "=q3=Outland Striders", "=ds=#s12#, #a3#", "20.00%" },
		{ 28375, "", "=q3=Rubium War-Girdle", "=ds=#s10#, #a4#", "20.00%" },
		{ 28372, "", "=q3=Idol of Feral Shadows", "=ds=#s16#, #w14#", "20.00%" },
	};

	TKArcThirdFragmentGuardian = {
		{ 24488, "", "=q1=Third Key Fragment", "=ds=#m3#", "100%" },
	};

	TKArcScryer = {
		{ 28396, "", "=q3=Gloves of the Unbound", "=ds=#s9#, #a2#", "20.00%" },
		{ 28398, "", "=q3=The Sleeper's Cord", "=ds=#s10#, #a2#", "20.00%" },
		{ 28394, "", "=q3=Ryngo's Band of Ingenuity", "=ds=#s13#", "20.00%" },
		{ 28393, "", "=q3=Warmaul of Infused Light", "=ds=#h2#, #w6#", "20.00%" },
		{ 28397, "", "=q3=Emberhawk Crossbow", "=ds=#w3#", "20.00%" },
	};

	TKArcScryerHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28396, "", "=q3=Gloves of the Unbound", "=ds=#s9#, #a2#", "20.00%" },
		{ 28398, "", "=q3=The Sleeper's Cord", "=ds=#s10#, #a2#", "20.00%" },
		{ 28394, "", "=q3=Ryngo's Band of Ingenuity", "=ds=#s13#", "20.00%" },
		{ 28393, "", "=q3=Warmaul of Infused Light", "=ds=#h2#, #w6#", "20.00%" },
		{ 28397, "", "=q3=Emberhawk Crossbow", "=ds=#w3#", "20.00%" },
	};

	TKArcDalliah = {
		{ 28391, "", "=q3=Worldfire Chestguard", "=ds=#s5#, #a3#", "20.00%" },
		{ 28390, "", "=q3=Thatia's Self-Correcting Gauntlets", "=ds=#s9#, #a4#", "20.00%" },
		{ 28387, "", "=q3=Lamp of Peaceful Repose", "=ds=#s15#", "20.00%" },
		{ 28392, "", "=q3=Reflex Blades", "=ds=#h3#, #w13#", "20.00%" },
		{ 28386, "", "=q3=Nether Core's Control Rod", "#w12#", "20.00%" },
		{ 0,"","","" },
		{ 24308, "", "=q4=Pattern: Whitemend Pants", "=ds=#p8# (375)", "10.00%" },
	};

	TKArcDalliahHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 0,"","","" },
		{ 28391, "", "=q3=Worldfire Chestguard", "=ds=#s5#, #a3#", "20.00%" },
		{ 28390, "", "=q3=Thatia's Self-Correcting Gauntlets", "=ds=#s9#, #a4#", "20.00%" },
		{ 28387, "", "=q3=Lamp of Peaceful Repose", "=ds=#s15#", "20.00%" },
		{ 28392, "", "=q3=Reflex Blades", "=ds=#h3#, #w13#", "20.00%" },
		{ 28386, "", "=q3=Nether Core's Control Rod", "=ds=#w12#", "20.00%" },
		{ 0,"","","" },
		{ 24308, "", "=q4=Pattern: Whitemend Pants", "=ds=#p8# (375)", "10.00%" },
	};

	TKArcHarbinger = {
		{ 28406, "", "=q3=Sigil-Laced Boots", "=ds=#s12#, #a1#", "8.00%" },
		{ 28415, "", "=q3=Hood of Oblivion", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 28413, "", "=q3=Hallowed Crown", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 28414, "", "=q3=Helm of Assassination", "=ds=#s1#, #a2# (D3)", "8.00%" },
		{ 28231, "", "=q3=Tidefury Chestpiece", "=ds=#s5#, #a3# (D3)", "8.00%" },
		{ 28403, "", "=q3=Doomplate Chestguard", "=ds=#s5#, #a4# (D3)", "8.00%" },
		{ 28205, "", "=q3=Breastplate of the Bold", "=ds=#s5#, #a4# (D3)", "8.00%" },
		{ 28419, "", "=q3=Choker of Fluid Thought", "=ds=#s2#", "8.00%" },
		{ 28407, "", "=q3=Elementium Band of the Sentry", "=ds=#s13#", "8.00%" },
		{ 28418, "", "=q3=Shiffar's Nexus-Horn", "=ds=#s14#", "8.00%" },
		{ 28412, "", "=q3=Lamp of Peaceful Radiance", "=ds=#s15#", "8.00%" },
		{ 28416, "", "=q3=Hungering Spineripper", "=ds=#h1#, #w4#", "8.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "7.00%" },
	};

	TKArcHarbingerHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 30582, "", "=q4=Deadly Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30575, "", "=q4=Nimble Fire Opal", "=ds=#e7#", "15.00%" },
		{ 30581, "", "=q4=Durable Fire Opal", "=ds=#e7#", "15.00%" },
		{ 0,"","","" },
		{ 29241, "", "=q4=Belt of Depravity", "=ds=#s10#, #a1#", "25.00%" },
		{ 29248, "", "=q4=Shadowstep Striders", "=ds=#s12#, #a2#", "25.00%" },
		{ 29252, "", "=q4=Bracers of Dignity", "=ds=#s8#, #a4#", "25.00%" },
		{ 29360, "", "=q4=Vileblade of the Betrayer", "=ds=#h1#, #w4#", "25.00%" },
		{ 0,"","","" },
		{ 23572, "", "=q3=Primal Nether", "=ds=#e8#", "100%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 28406, "", "=q3=Sigil-Laced Boots", "=ds=#s12#, #a1#", "8.00%" },
		{ 28415, "", "=q3=Hood of Oblivion", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 28413, "", "=q3=Hallowed Crown", "=ds=#s1#, #a1# (D3)", "8.00%" },
		{ 28414, "", "=q3=Helm of Assassination", "=ds=#s1#, #a2# (D3)", "8.00%" },
		{ 28231, "", "=q3=Tidefury Chestpiece", "=ds=#s5#, #a3# (D3)", "8.00%" },
		{ 28403, "", "=q3=Doomplate Chestguard", "=ds=#s5#, #a4# (D3)", "8.00%" },
		{ 28205, "", "=q3=Breastplate of the Bold", "=ds=#s5#, #a4# (D3)", "8.00%" },
		{ 28419, "", "=q3=Choker of Fluid Thought", "=ds=#s2#", "8.00%" },
		{ 28407, "", "=q3=Elementium Band of the Sentry", "=ds=#s13#", "8.00%" },
		{ 28418, "", "=q3=Shiffar's Nexus-Horn", "=ds=#s14#", "8.00%" },
		{ 28412, "", "=q3=Lamp of Peaceful Radiance", "=ds=#s15#", "8.00%" },
		{ 28416, "", "=q3=Hungering Spineripper", "=ds=#h1#, #w4#", "8.00%" },
	};

	TKArcTrash = {
		{ 23606, "", "=q3=Plans: Felsteel Leggings", "=q1=#cas28#", "43.00%" },
		{ 22556, "", "=q2=Formula: Enchant 2H Weapon - Major Agility", "=q1=#cas29#", "21.00%" },
		{ 29672, "", "=q2=Pattern: Flame Armor Kit", "=q1=#cas30#", "26.00%" },
		{ 21905, "", "=q2=Pattern: Arcanoweave Bracers", "=q1=#cas31#", "14.00%" },
		{ 0,"","","" },
		{ 0, "spell_arcane_arcane01", "=q6=#cas32#", "=q5=#cas11#" },
		{ 24488, "", "=q1=Third Key Fragment", "=ds=#m3#", "100%" },
	};

	----------------
	--- Karazhan ---
	----------------

	KaraCharredBoneFragment = {
		{ 24152 ,"INV_Misc_Bone_10", "=q1=Charred Bone Fragment", "=ds=#m3#" },
	};

	KaraNamed = {
		{ 0, "Ability_Hunter_Pet_Spider", "=q6="..BabbleBoss["Hyakiss the Lurker"], "=q5="..AL["Spider"] },
		{ 30675, "", "=q4=Lurker's Cord", "=ds=#s10#, #a1# =q2=#m16#", "25.00%" },
		{ 30676, "", "=q4=Lurker's Grasp", "=ds=#s10#, #a2# =q2=#m16#", "25.00%" },
		{ 30677, "", "=q4=Lurker's Belt", "=ds=#s10#, #a3# =q2=#m16#", "25.00%" },
		{ 30678, "", "=q4=Lurker's Girdle", "=ds=#s10#, #a4# =q2=#m16#", "25.00%" },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_Pet_Hyena", "=q6="..BabbleBoss["Rokad the Ravager"], "=q5="..AL["Darkhound"] },
		{ 30684, "", "=q4=Ravager's Cuffs", "=ds=#s8#, #a1# =q2=#m16#", "25.00%" },
		{ 30685, "", "=q4=Ravager's Wrist-Wraps", "=ds=#s8#, #a2# =q2=#m16#", "25.00%" },
		{ 30686, "", "=q4=Ravager's Bands", "=ds=#s8#, #a3# =q2=#m16#", "25.00%" },
		{ 30687, "", "=q4=Ravager's Bracers", "=ds=#s8#, #a4# =q2=#m16#", "25.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_Pet_Bat", "=q6="..BabbleBoss["Shadikith the Glider"], "=q5="..AL["Bat"] },
		{ 30680, "", "=q4=Glider's Foot-Wraps", "=ds=#s12#, #a1# =q2=#m16#", "25.00%" },
		{ 30681, "", "=q4=Glider's Boots", "=ds=#s12#, #a2# =q2=#m16#", "25.00%" },
		{ 30682, "", "=q4=Glider's Sabatons", "=ds=#s12#, #a3# =q2=#m16#", "25.00%" },
		{ 30683, "", "=q4=Glider's Greaves", "=ds=#s12#, #a4# =q2=#m16#", "25.00%" },
	};

	KaraAttumen = {
		{ 28477, "", "=q4=Harbinger Bands", "=ds=#s8#, #a1#", "8.00%" },
		{ 28507, "", "=q4=Handwraps of Flowing Thought", "=ds=#s9#, #a1#", "8.00%" },
		{ 28508, "", "=q4=Gloves of Saintly Blessings", "=ds=#s9#, #a1#", "8.00%" },
		{ 28453, "", "=q4=Bracers of the White Stag", "=ds=#s8#, #a2#", "8.00%" },
		{ 28506, "", "=q4=Gloves of Dexterous Manipulation", "=ds=#s9#, #a2#", "8.00%" },
		{ 28503, "", "=q4=Whirlwind Bracers", "=ds=#s8#, #a3#", "8.00%" },
		{ 28454, "", "=q4=Stalker's War Bands", "=ds=#s8#, #a3#", "8.00%" },
		{ 28502, "", "=q4=Vambraces of Courage", "=ds=#s8#, #a4#", "8.00%" },
		{ 28505, "", "=q4=Gauntlets of Renewed Hope", "=ds=#s9#, #a4#", "8.00%" },
		{ 28509, "", "=q4=Worgen Claw Necklace", "=ds=#s2#", "8.00%" },
		{ 28510, "", "=q4=Spectral Band of Innervation", "=ds=#s13#", "8.00%" },
		{ 28504, "", "=q4=Steelhawk Crossbow", "=ds=#w3#", "8.00%" },
		{ 0,"","","" },
		{ 30480, "", "=q4=Fiery Warhorse's Reins", "=ds=#e12#", "0.50%" },
		{ 0,"","","" },
		{ 23809, "", "=q3=Schematic: Stabilized Eternium Scope", "=ds=#p5# (375)", "5.00%" },	
	};

	KaraMoroes = {
		{ 28529, "", "=q4=Royal Cloak of Arathi Kings", "=ds=#s4#", "8.00%" },
		{ 28570, "", "=q4=Shadow-Cloak of Dalaran", "=ds=#s4#", "8.00%" },
		{ 28565, "", "=q4=Nethershard Girdle", "=ds=#s10#, #a1#", "8.00%" },
		{ 28545, "", "=q4=Edgewalker Longboots", "=ds=#s12#, #a2#", "8.00%" },
		{ 28567, "", "=q4=Belt of Gale Force", "=ds=#s10#, #a3#", "8.00%" },
		{ 28566, "", "=q4=Crimson Girdle of the Indomitable", "=ds=#s10#, #a4#", "8.00%" },
		{ 28569, "", "=q4=Boots of Valiance", "=ds=#s12#, #a4#", "8.00%" },
		{ 28530, "", "=q4=Brooch of Unquenchable Fury", "=ds=#s2#", "8.00%" },
		{ 28528, "", "=q4=Moroes' Lucky Pocket Watch", "=ds=#s14#", "8.00%" },
		{ 28525, "", "=q4=Signet of Unshakable Faith", "=ds=#s15#", "8.00%" },
		{ 28568, "", "=q4=Idol of the Avian Heart", "=ds=#s16#, #w14#", "8.00%" },
		{ 28524, "", "=q4=Emerald Ripper", "=ds=#h1#, #w4#", "8.00%" },
		{ 0,"","","" },
		{ 22559, "", "=q3=Formula: Enchant Weapon - Mongoose", "=ds=#p4# (375)", "5.00%" },
	};

	KaraKeannaLog = {
		{ 24492, "", "=q1=Keanna's Log", "=ds=#m3#" },
	};

	KaraMaiden = {
		{ 28511, "", "=q4=Bands of Indwelling", "=ds=#s8#, #a1#", "8.00%" },
		{ 28515, "", "=q4=Bands of Nefarious Deeds", "=ds=#s8#, #a1#", "8.00%" },
		{ 28517, "", "=q4=Boots of Foretelling", "=ds=#s12#, #a1#", "8.00%" },
		{ 28514, "", "=q4=Bracers of Maliciousness", "=ds=#s8#, #a2#", "8.00%" },
		{ 28521, "", "=q4=Mitts of the Treemender", "=ds=#s9#, #a2#", "8.00%" },
		{ 28520, "", "=q4=Gloves of Centering", "=ds=#s9#, #a3#", "8.00%" },
		{ 28519, "", "=q4=Gloves of Quickening", "=ds=#s9#, #a3#", "8.00%" },
		{ 28512, "", "=q4=Bracers of Justice", "=ds=#s8#, #a4#", "8.00%" },
		{ 28518, "", "=q4=Iron Gauntlets of the Maiden", "=ds=#s9#, #a4#", "8.00%" },
		{ 28516, "", "=q4=Barbed Choker of Discipline", "=ds=#s2#", "8.00%" },
		{ 28523, "", "=q4=Totem of Healing Rains", "=ds=#s16#, #w15#", "8.00%" },
		{ 28522, "", "=q4=Shard of the Virtuous", "=ds=#h3#, #w6#", "8.00%" },
	};

	KaraOperaEvent = {
		{ 0, "INV_Box_01", "=q6="..AL["Shared Drops"], "" },
		{ 28594, "", "=q4=Trial-FireTrousers", "=ds=#s11#, #a1#", "17.00%" },
		{ 28591, "", "=q4=Earthsoul Leggings", "=ds=#s11#, #a2#", "17.00%" },
		{ 28589, "", "=q4=Beastmaw Pauldrons", "=ds=#s3#, #a3#", "17.00%" },
		{ 28593, "", "=q4=Eternium Greathelm", "=ds=#s1#, #a4#", "17.00%" },
		{ 28590, "", "=q4=Ribbon of Sacrifice", "=ds=#s14#", "17.00%" },
		{ 28592, "", "=q4=Libram of Souls Redeemed", "=ds=#s16#, #w16#", "17.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6="..BabbleBoss["The Crone"], "=q5="..AL["Wizard of Oz"] },
		{ 28586, "", "=q4=Wicked Witch's Hat", "=ds=#s1#, #a1#", "25.00%" },
		{ 28585, "", "=q4=Ruby Slippers", "=ds=#s12#, #a1#", "25.00%" },
		{ 28587, "", "=q4=Legacy", "=ds=#h2#, #w1#", "25.00%" },
		{ 28588, "", "=q4=Blue Diamond Witchwand", "=ds=#w12#", "25.00%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6="..BabbleBoss["Romulo & Julianne"], "=q5="..AL["Romulo & Julianne"] },
		{ 28578, "", "=q4=Masquerade Gown", "=ds=#s5#, #a1#", "25.00%" },
		{ 28579, "", "=q4=Romulo's Poison Vial", "=ds=#s14#", "25.00%" },
		{ 28572, "", "=q4=Blade of the Unrequited", "=ds=#h1#, #w4#", "25.00%" },
		{ 28573, "", "=q4=Despair", "=ds=#h2#, #w10#", "25.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6="..BabbleBoss["The Big Bad Wolf"], "=q5="..AL["Red Riding Hood"] },
		{ 28582, "", "=q4=Red Riding Hood's Cloak", "=ds=#s4#", "25.00%" },
		{ 28583, "", "=q4=Big Bad Wolf's Head", "=ds=#s1#, #a3#", "25.00%" },
		{ 28584, "", "=q4=Big Bad Wolf's Paw", "=ds=#h3#, #w13#", "25.00%" },
		{ 28581, "", "=q4=Wolfslayer Sniper Rifle", "=ds=#w5#", "25.00%" },
	};

	KaraCurator = {
		{ 28612, "", "=q4=Pauldrons of the Solace-Giver", "=ds=#s3#, #a1#", "17.00%" },
		{ 28647, "", "=q4=Forest Wind Shoulderpads", "=ds=#s3#, #a2#", "17.00%" },
		{ 28631, "", "=q4=Dragon-Quake Shoulderguards", "=ds=#s3#, #a3#", "17.00%" },
		{ 28621, "", "=q4=Wrynn Dynasty Greaves", "=ds=#s11#, #a4#", "17.00%" },
		{ 28649, "", "=q4=Garona's Signet Ring", "=ds=#s13#", "17.00%" },
		{ 28633, "", "=q4=Staff of Infinite Mysteries", "=ds=#w9#", "17.00%" },
		{ 0,"","","" },
		{ 29757, "", "=q4=Gloves of the Fallen Champion", "=ds=#m21# #e15#", "33.00%" },
		{ 29758, "", "=q4=Gloves of the Fallen Defender", "=ds=#m21# #e15#", "33.00%" },
		{ 29756, "", "=q4=Gloves of the Fallen Hero", "=ds=#m21# #e15#", "33.00%" },
	};

	KaraIllhoof = {
		{ 28660, "", "=q4=Gilded Thorium Cloak", "=ds=#s4#", "8.00%" },
		{ 28653, "", "=q4=Shadowvine Cloak of Infusion", "=ds=#s4#", "8.00%" },
		{ 28652, "", "=q4=Cincture of Will", "=ds=#s10#, #a1#", "8.00%" },
		{ 28654, "", "=q4=Malefic Girdle", "=ds=#s10#, #a1#", "8.00%" },
		{ 28655, "", "=q4=Cord of Nature's Sustenance", "=ds=#s10#, #a2#", "8.00%" },
		{ 28656, "", "=q4=Girdle of the Prowler", "=ds=#s10#, #a3#", "8.00%" },
		{ 28662, "", "=q4=Breastplate of the Lightbinder", "=ds=#s5#, #a4#", "8.00%" },
		{ 28661, "", "=q4=Mender's Heart-Ring", "=ds=#s13#", "8.00%" },
		{ 28785, "", "=q4=The Lightning Capacitor", "=ds=#s14#", "8.00%" },
		{ 28657, "", "=q4=Fool's Bane", "=ds=#h1#, #w6#", "8.00%" },
		{ 28658, "", "=q4=Terestian's Stranglestaff", "=ds=#w9#", "8.00%" },
		{ 28659, "", "=q4=Xavian Stiletto", "=ds=#w11#", "8.00%" },
		{ 0,"","","" },
		{ 22561, "", "=q3=Formula: Enchant Weapon - Soulfrost", "=ds=#p4# (375)", "5.00%" },
	};

	KaraAran = {
		{ 28672, "", "=q4=Drape of the Dark Reavers", "=ds=#s4#", "8.00%" },
		{ 28726, "", "=q4=Mantle of the Mind Flayer", "=ds=#s3#, #a1#", "8.00%" },
		{ 28670, "", "=q4=Boots of the Infernal Coven", "=ds=#s12#, #a1#", "8.00%" },
		{ 28663, "", "=q4=Boots of the Incorrupt", "=ds=#s12#, #a1#", "8.00%" },
		{ 28669, "", "=q4=Rapscallion Boots", "=ds=#s12#, #a2#", "8.00%" },
		{ 28671, "", "=q4=Steelspine Faceguard", "=ds=#s1#, #a3#", "8.00%" },
		{ 28666, "", "=q4=Pauldrons of the Justice-Seeker", "=ds=#s3#, #a4#", "8.00%" },
		{ 28674, "", "=q4=Saberclaw Talisman", "=ds=#s2#", "8.00%" },
		{ 28675, "", "=q4=Shermanar Great-Ring", "=ds=#s13#", "8.00%" },
		{ 28727, "", "=q4=Pendant of the Violet Eye", "=ds=#s14#", "8.00%" },
		{ 28728, "", "=q4=Aran's Soothing Sapphire", "=ds=#s15#", "8.00%" },
		{ 28673, "", "=q4=Tirisfal Wand of Ascendancy", "=ds=#w12#", "8.00%" },
		{ 0,"","","" },
		{ 22560, "", "=q3=Formula: Enchant Weapon - Sunfire", "=ds=#p4# (375)", "5.00%" },
		{ 0,"","","" },
		{ 23933, "", "=q1=Medivh's Journal", "=ds=#m3#", "100%" },
	};

	KaraNetherspite = {
		{ 28744, "", "=q4=Uni-Mind Headdress", "=ds=#s1#, #a1#", "8.00%" },
		{ 28742, "", "=q4=Pantaloons of Repentence", "=ds=#s11#, #a1#", "8.00%" },
		{ 28732, "", "=q4=Cowl of Defiance", "=ds=#s1#, #a2#", "8.00%" },
		{ 28741, "", "=q4=Skulker's Greaves", "=ds=#s11#, #a2#", "8.00%" },
		{ 28735, "", "=q4=Earthblood Chestguard", "=ds=#s5#, #a3#", "8.00%" },
		{ 28740, "", "=q4=Rip-Flayer Leggings", "=ds=#s11#, #a3#", "8.00%" },
		{ 28743, "", "=q4=Mantle of Abrahmis", "=ds=#s3#, #a4#", "8.00%" },
		{ 28733, "", "=q4=Girdle of Truth", "=ds=#s10#, #a4#", "8.00%" },
		{ 28731, "", "=q4=Shining Chain of the Afterworld", "=ds=#s2#", "8.00%" },
		{ 28730, "", "=q4=Mithril Band of the Unscarred", "=ds=#s13#", "8.00%" },
		{ 28734, "", "=q4=Jewel of Infinite Possibilities", "=ds=#s15#", "8.00%" },
		{ 28729, "", "=q4=Spiteblade", "=ds=#h1#, #w10#", "8.00%" },
	};

	KaraChess = {
		{ 28756, "", "=q4=Headdress of the High Potentate", "=ds=#s1#, #a1#", "8.00%" },
		{ 28755, "", "=q4=Bladed Shoulderpads of the Merciless", "=ds=#s3#, #a2#", "8.00%" },
		{ 28750, "", "=q4=Girdle of Treachery", "=ds=#s10#, #a2#", "8.00%" },
		{ 28752, "", "=q4=Forestlord Striders", "=ds=#s12#, #a2#", "8.00%" },
		{ 28751, "", "=q4=Heart-Flame Leggings", "=ds=#s11#, #a3#", "8.00%" },
		{ 28746, "", "=q4=Fiend Slayer Boots", "=ds=#s12#, #a3#", "8.00%" },
		{ 28748, "", "=q4=Legplates of the Innocent", "=ds=#s11#, #a4#", "8.00%" },
		{ 28747, "", "=q4=Battlescar Boots", "=ds=#s12#, #a4#", "8.00%" },
		{ 28745, "", "=q4=Mithril Chain of Heroism", "=ds=#s2#", "8.00%" },
		{ 28753, "", "=q4=Ring of Recurrence", "=ds=#s13#", "8.00%" },
		{ 28749, "", "=q4=King's Defender", "=ds=#h1#, #w10#", "8.00%" },
		{ 28754, "", "=q4=Triptych Shield of the Ancients", "=ds=#w8#", "8.00%" },
	};

	KaraNightbane = {
		{ 28602, "", "=q4=Robe of the Elder Scribes", "=ds=#s5#, #a1#", "8.00%" },
		{ 28600, "", "=q4=Stonebough Jerkin", "=ds=#s5#, #a2#", "8.00%" },
		{ 28601, "", "=q4=Chestguard of the Conniver", "=ds=#s5#, #a2#", "8.00%" },
		{ 28599, "", "=q4=Scaled Breastplate of Carnage", "=ds=#s5#, #a3#", "8.00%" },
		{ 28610, "", "=q4=Ferocious Swift-Kickers", "=ds=#s12#, #a3#", "8.00%" },
		{ 28597, "", "=q4=Panzar'Thar Breastplate", "=ds=#s5#, #a4#", "8.00%" },
		{ 28608, "", "=q4=Ironstriders of Urgency", "=ds=#s12#, #a4#", "8.00%" },
		{ 28609, "", "=q4=Emberspur Talisman", "=ds=#s2#", "8.00%" },
		{ 28603, "", "=q4=Talisman of Nightbane", "=ds=#s15#", "8.00%" },
		{ 28604, "", "=q4=Nightstaff of the Everliving", "=ds=#w9#", "8.00%" },
		{ 28611, "", "=q4=Dragonheart Flameshield", "=ds=#w8#", "8.00%" },
		{ 28606, "", "=q4=Shield of Impenetrable Darkness", "=ds=#w8#", "8.00%" },
		{ 0,"","","" },
		{ 31751, "", "=q1=Blazing Signet", "=ds=#m3#", "100%" },
		{ 24139, "", "=q1=Faint Arcane Essence", "=ds=#m3#", "100%" },
	};

	KaraPrince = {
		{ 28765, "", "=q4=Stainless Cloak of the Pure Hearted", "=ds=#s4#", "17.00%" },
		{ 28766, "", "=q4=Ruby Drape of the Mysticant", "=ds=#s4#", "17.00%" },
		{ 28764, "", "=q4=Farstrider Wildercloak", "=ds=#s4#", "17.00%" },
		{ 28762, "", "=q4=Adornment of Stolen Souls", "=ds=#s2#", "17.00%" },
		{ 28763, "", "=q4=Jade Ring of the Everliving", "=ds=#s13#", "17.00%" },
		{ 28757, "", "=q4=Ring of a Thousand Marks", "=ds=#s13#", "17.00%" },
		{ 28770, "", "=q4=Nathrezim Mindblade", "=ds=#h3#, #w4#", "17.00%" },
		{ 28768, "", "=q4=Malchazeen", "=ds=#h1#, #w4#", "17.00%" },
		{ 28767, "", "=q4=The Decapitator", "=ds=#h1#, #w1#", "17.00%" },
		{ 28773, "", "=q4=Gorehowl", "=ds=#h2#, #w1#", "17.00%" },
		{ 28771, "", "=q4=Light's Justice", "=ds=#h3#, #w6#", "17.00%" },
		{ 28772, "", "=q4=Sunfury Bow of the Phoenix", "=ds=#w2#", "17.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 29760, "", "=q4=Helm of the Fallen Champion", "=ds=#m21# #e15#", "33.00%" },
		{ 29761, "", "=q4=Helm of the Fallen Defender", "=ds=#m21# #e15#", "33.00%" },
		{ 29759, "", "=q4=Helm of the Fallen Hero", "=ds=#m21# #e15#", "33.00%" },
	};

	KaraTrash = {
		{ 30642, "", "=q4=Drape of the Righteous", "=ds=#s4#" },
		{ 30668, "", "=q4=Grasp of the Dead", "=ds=#s9#, #a1#" },
		{ 30673, "", "=q4=Inferno Waist Cord", "=ds=#s10#, #a1#" },
		{ 30644, "", "=q4=Grips of the Deftness", "=ds=#s9#, #a2#" },
		{ 30674, "", "=q4=Zierhut's Lost Treads", "=ds=#s12#, #a2#" },
		{ 30643, "", "=q4=Belt of the Tracker", "=ds=#s10#, #a3#" },
		{ 30641, "", "=q4=Boots of Elusion", "=ds=#s12#, #a4#" },
		{ 30666, "", "=q4=Ritssyn's Lost Pendant", "=ds=#s2#" },
		{ 30667, "", "=q4=Ring of Unrelenting Storms", "=ds=#s13#" },
		{ 0,"","","" },
		{ 21903, "", "=q4=Pattern: Soulcloth Shoulders", "=q1=#cas20#", "11.00%" },
		{ 21904, "", "=q4=Pattern: Soulcloth Vest", "=q1=#cas21#", "28.00%" },
		{ 22545, "", "=q2=Formula: Enchant Boots - Surefooted", "=q1=#cas22#", "8.00%" },
		{ 0,"","","" },
		{ 21882, "", "=q1=Soul Essence", "=ds=#e8#" },
		{ 23857, "", "=q1=Legacy of the Mountain King", "=ds=" },
		{ 23864, "", "=q1=Torment of the Worgen", "=ds=" },
		{ 23862, "", "=q1=Redemption of the Fallen", "=ds=" },
		{ 23865, "", "=q1=Wrath of the Titans", "=ds=" },
	};

	--------------------
	--- Gruul's Lair ---
	--------------------

	GruulsLairHighKingMaulgar = {
		{ 28797, "", "=q4=Brute Cloak of the Ogre-Magi", "#s4#", "17.00%" },
		{ 28799, "", "=q4=Belt of Divine Inspiration", "#s10#, #a1#", "17.00%" },
		{ 28796, "", "=q4=Malefic Mask of the Shadows", "=ds=#s1#, #a2#", "17.00%" },
		{ 28801, "", "=q4=Maulgar's Warhelm", "=ds=#s1#, #a3#", "17.00%" },
		{ 28795, "", "=q4=Bladespire Warbands", "=ds=#s8#, #a4#", "17.00%" },
		{ 28800, "", "=q4=Hammer of the Naaru", "=ds=#h2#, #w6#", "17.00%" },
		{ 0,"","","" },
		{ 29763, "", "=q4=Pauldrons of the Fallen Champion", "=ds=#m21# #e15#", "33.00%" },
		{ 29764, "", "=q4=Pauldrons of the Fallen Defender", "=ds=#m21# #e15#", "33.00%" },
		{ 29762, "", "=q4=Pauldrons of the Fallen Hero", "=ds=#m21# #e15#", "33.00%" },
	};

	GruulGruul = {
		{ 28804, "", "=q4=Collar of Cho'gall", "=ds=#s1#, #a1#", "8.00%" },
		{ 28803, "", "=q4=Cowl of Nature's Breath", "=ds=#s1#, #a2#", "8.00%" },
		{ 28828, "", "=q4=Gronn-Stitched Girdle", "=ds=#s10#, #a2#", "8.00%" },
		{ 28827, "", "=q4=Gauntlets of the Dragonslayer", "=ds=#s9#, #a3#", "8.00%" },
		{ 28810, "", "=q4=Windshear Boots", "=ds=#s12#, #a3#", "8.00%" },
		{ 28824, "", "=q4=Gauntlets of Martial Perfection", "=ds=#s9#, #a4#", "8.00%" },
		{ 28822, "", "=q4=Teeth of Gruul", "=ds=#s2#", "8.00%" },
		{ 28823, "", "=q4=Eye of Gruul", "=ds=#s14#", "8.00%" },
		{ 28830, "", "=q4=Dragonspine Trophy", "=ds=#s14#", "8.00%" },
		{ 28802, "", "=q4=Bloodmaw Magus-Blade", "=ds=#h3#, #w10#", "8.00%" },
		{ 28794, "", "=q4=Axe of the Gronn Lords", "=ds=#h2#, #w1#", "8.00%" },
		{ 28825, "", "=q4=Aldori Legacy Defender", "=ds=#w8#", "8.00%" },
		{ 28826, "", "=q4=Shuriken of Negation", "=ds=#w11#", "8.00%" },
		{ 0,"","","" },
		{ 31750, "", "=q1=Earthen Signet", "=ds=#m3#", "100%" },
		{ 29766, "", "=q4=Leggings of the Fallen Champion", "=ds=#m21# #e15#", "33.00%" },
		{ 29767, "", "=q4=Leggings of the Fallen Defender", "=ds=#m21# #e15#", "33.00%" },
		{ 29765, "", "=q4=Leggings of the Fallen Hero", "=ds=#m21# #e15#", "33.00%" },
	};

	--------------------------------------------
	--- Hellfire Citadel: Magtheridon's Lair ---
	--------------------------------------------

	HCMagtheridon = {
		{ 28777, "", "=q4=Cloak of the Pit Stalker", "=ds=#s4#", "8.00%" },
		{ 28780, "", "=q4=Soul-Eater's Handwraps", "=ds=#s9#, #a1#", "8.00%" },
		{ 28776, "", "=q4=Liar's Tongue Gloves", "=ds=#s9#, #a2#", "8.00%" },
		{ 28778, "", "=q4=Terror Pit Girdle", "=ds=#s10#, #a3#", "8.00%" },
		{ 28775, "", "=q4=Thundering Greathelm", "=ds=#s1#, #a4#", "8.00%" },
		{ 28779, "", "=q4=Girdle of the Endless Pit", "=ds=#s10#, #a4#", "8.00%" },
		{ 28789, "", "=q4=Eye of Magtheridon", "=ds=#s14#", "8.00%" },
		{ 28781, "", "=q4=Karaborian Talisman", "=ds=#s15#", "8.00%" },
		{ 28774, "", "=q4=Glaive of the Pit", "=ds=#w7#", "8.00%" },
		{ 28782, "", "=q4=Crystalheart Pulse-Staff", "=ds=#w9#", "8.00%" },
		{ 29458, "", "=q4=Aegis of the Vindicator", "=ds=#w8#", "8.00%" },
		{ 28783, "", "=q4=Eredar Wand of Obliteration", "=ds=#w12#", "8.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 29754, "", "=q4=Chestguard of the Fallen Champion", "=ds=#m21# #e15#", "33.00%" },
		{ 29753, "", "=q4=Chestguard of the Fallen Defender", "=ds=#m21# #e15#", "33.00%" },
		{ 29755, "", "=q4=Chestguard of the Fallen Hero", "=ds=#m21# #e15#", "33.00%" },
		{ 0,"","","" },
		{ 32385, "", "=q4=Magtheridon's Head", "=ds=#m2#", "100%" },
		{ 28791, "", "=q4=Ring of the Recalcitrant", "=q1=#m4#: =ds=#s13#" },
		{ 28790, "", "=q4=Naaru Lightwarden's Band", "=q1=#m4#: =ds=#s13#" },
		{ 28793, "", "=q4=Band of Crimson Fury", "=q1=#m4#: =ds=#s13#" },
		{ 28792, "", "=q4=A'dal's Signet of Defense", "=q1=#m4#: =ds=#s13#" },
		{ 0,"","","" },
		{ 34845, "", "=q4=Pit Lord's Satchel", "=ds=#e1# #m15#", "100%" },
		{ 0,"","","" },
		{ 34846, "", "=q2=Black Sack of Gems", "=ds=#e1#", "100%" },
	};

	------------------------------------------------
	--- Coilfang Reservoir: Serpentshrine Cavern ---
	------------------------------------------------

	CFRSerpentHydross = {
		{ 30056, "", "=q4=Robe of Hateful Echoes", "=ds=#s5#, #a1#", "8.00%" },
		{ 30050, "", "=q4=Boots of the Shifting Nightmare", "=ds=#s12#, #a1#", "8.00%" },
		{ 30055, "", "=q4=Shoulderpads of the Stranger", "=ds=#s3#, #a2#", "8.00%" },
		{ 30047, "", "=q4=Blackfathom Warbands", "=ds=#s8#, #a3#", "8.00%" },
		{ 30054, "", "=q4=Ranger-General's Chestguard", "=ds=#s5#, #a3#", "8.00%" },
		{ 30048, "", "=q4=Brighthelm of Justice", "=ds=#s1#, #a4#", "8.00%" },
		{ 30053, "", "=q4=Pauldrons of the Wardancer", "=ds=#s3#, #a4#", "8.00%" },
		{ 30052, "", "=q4=Ring of Lethality", "=ds=#s13#", "8.00%" },
		{ 30664, "", "=q4=Living Root of the Wildheart", "=ds=#s14#, =q1=#m1# =ds=#c1#", "8.00%" },
		{ 30629, "", "=q4=Scarab of Displacement", "=ds=#s14#", "8.00%" },
		{ 30049, "", "=q4=Fathomstone", "=ds=#s15#", "8.00%" },
		{ 30051, "", "=q4=Idol of the Crescent Goddess", "=ds=#s16#, #w14#", "8.00%" },
	};

	CFRSerpentLurker = {
		{ 30064, "", "=q4=Cord of Screaming Terrors", "=ds=#s10#, #a1#", "8.00%" },
		{ 30067, "", "=q4=Velvet Boots of the Guardian", "=ds=#s12#, #a1#", "8.00%" },
		{ 30062, "", "=q4=Grove-Bands of Remulos", "=ds=#s8#, #a2#", "8.00%" },
		{ 30060, "", "=q4=Boots of Effortless Striking", "=ds=#s12#, #a2#", "8.00%" },
		{ 30066, "", "=q4=Tempest-Strider Boots", "=ds=#s12#, #a3#", "8.00%" },
		{ 30065, "", "=q4=Glowing Breastplate of Truth", "=ds=#s5#, #a4#", "8.00%" },
		{ 30057, "", "=q4=Bracers of Eradication", "=ds=#s8#, #a4#", "8.00%" },
		{ 30059, "", "=q4=Choker of Animalistic Fury", "=ds=#s2#", "8.00%" },
		{ 30061, "", "=q4=Ancestral Ring of Conquest", "=ds=#s13#", "8.00%" },
		{ 30665, "", "=q4=Earring of Soulful Meditation", "=ds=#s14#, =q1=#m1# =ds=#c5#", "8.00%" },
		{ 30063, "", "=q4=Libram of Absolute Truth", "=ds=#s16#, #w16#", "8.00%" },
		{ 30058, "", "=q4=Mallet of the Tides", "=ds=#h1#, #w6#", "8.00%" },
	};

	CFRSerpentLeotheras = {
		{ 30092, "", "=q4=Orca-Hide Boots", "=ds=#s12#, #a2#", "17.00%" },
		{ 30097, "", "=q4=Coral-Barbed Shoulderpads", "=ds=#s3#, #a3#", "17.00%" },
		{ 30091, "", "=q4=True-Aim Stalker Bands", "=ds=#s8#, #a3#", "17.00%" },
		{ 30096, "", "=q4=Girdle of the Invulnerable", "=ds=#s10#, #a4#", "17.00%" },
		{ 30627, "", "=q4=Tsunami Talisman", "=ds=#s14#", "17.00%" },
		{ 30095, "", "=q4=Fang of the Leviathan", "=ds=#h3#, #w10#", "17.00%" },
		{ 0,"","","" },
		{ 30239, "", "=q4=Gloves of the Vanquished Champion", "=ds=#m22# #e15#", "33.00%" },
		{ 30240, "", "=q4=Gloves of the Vanquished Defender", "=ds=#m22# #e15#", "33.00%" },
		{ 30241, "", "=q4=Gloves of the Vanquished Hero", "=ds=#m22# #e15#", "33.00%" },
	};

	CFRSerpentKarathress = {
		{ 30100, "", "=q4=Soul-Strider Boots", "=ds=#s12#, #a1#", "17.00%" },
		{ 30101, "", "=q4=Bloodsea Brigand's Vest", "=ds=#s5#, #a2#", "17.00%" },
		{ 30099, "", "=q4=Frayed Tether of the Drowned", "=ds=#s2#", "17.00%" },
		{ 30663, "", "=q4=Fathom-Brooch of the Tidewalker", "=ds=#s14#, =q1=#m1# =ds=#c7#", "17.00%" },
		{ 30626, "", "=q4=Sextant of Unstable Currents", "=ds=#s14#", "17.00%" },
		{ 30090, "", "=q4=World Breaker", "=ds=#h2#, #w6#", "17.00%" },
		{ 0,"","","" },
		{ 30245, "", "=q4=Leggings of the Vanquished Champion", "=ds=#m22# #e15#", "33.00%" },
		{ 30246, "", "=q4=Leggings of the Vanquished Defender", "=ds=#m22# #e15#", "33.00%" },
		{ 30247, "", "=q4=Leggings of the Vanquished Hero", "=ds=#m22# #e15#", "33.00%" },
	};

	CFRSerpentMorogrim = {
		{ 30098, "", "=q4=Razor-Scale Battlecloak", "=ds=#s4#", "8.00%" },
		{ 30079, "", "=q4=Illidari Shoulderpads", "=ds=#s3#, #a1#", "8.00%" },
		{ 30075, "", "=q4=Gnarled Chestpiece of the Ancients", "=ds=#s5#, #a2#", "8.00%" },
		{ 30085, "", "=q4=Mantle of the Tireless Tracker", "=ds=#s3#, #a3#", "8.00%" },
		{ 30068, "", "=q4=Girdle of the Tidal Call", "=ds=#s10#, #a3#", "8.00%" },
		{ 30084, "", "=q4=Pauldrons of the Argent Sentinel", "=ds=#s3#, #a4#", "8.00%" },
		{ 30081, "", "=q4=Warboots of Obliteration", "=ds=#s12#, #a4#", "8.00%" },
		{ 30008, "", "=q4=Pendant of the Lost Ages", "=ds=#s2#", "8.00%" },
		{ 30083, "", "=q4=Ring of Sundered Souls", "=ds=#s13#", "8.00%" },
		{ 30720, "", "=q4=Serpent-Coil Braid", "=ds=#s14#, =q1=#m1# =ds=#c3#", "8.00%" },
		{ 30082, "", "=q4=Talon of Azshara", "=ds=#h1#, #w10#", "8.00%" },
		{ 30080, "", "=q4=Luminescent Rod of the Naaru", "=ds=#w12#", "8.00%" },
	};

	CFRSerpentVashj = {
		{ 30107, "", "=q4=Vestments of the Sea-Witch", "=ds=#s5#, #a1#", "8.00%" },
		{ 30111, "", "=q4=Runetotem's Mantle", "=ds=#s3#, #a2#", "8.00%" },
		{ 30106, "", "=q4=Belt of One-Hundred Deaths", "=ds=#s10#, #a2#", "8.00%" },
		{ 30104, "", "=q4=Cobra-Lash Boots", "=ds=#s12#, #a3#", "8.00%" },
		{ 30102, "", "=q4=Krakken-Heart Breastplate", "=ds=#s5#, #a4#", "8.00%" },
		{ 30112, "", "=q4=Glorious Gauntlets of Crestfall", "=ds=#s9#, #a4#", "8.00%" },
		{ 30109, "", "=q4=Ring of Endless Coils", "=ds=#s13#", "8.00%" },
		{ 30110, "", "=q4=Coral Band of the Revived", "=ds=#s13#", "8.00%" },
		{ 30621, "", "=q4=Prism of Inner Calm", "=ds=#s14#", "8.00%" },
		{ 30103, "", "=q4=Fang of Vashj", "=ds=#h1#, #w4#", "8.00%" },
		{ 30108, "", "=q4=Lightfathom Scepter", "=ds=#h3#, #w6#", "8.00%" },
		{ 30105, "", "=q4=Serpent Spine Longbow", "=ds=#w2#", "8.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 30242, "", "=q4=Helm of the Vanquished Champion", "=ds=#m22# #e15#", "33.00%" },
		{ 30243, "", "=q4=Helm of the Vanquished Defender", "=ds=#m22# #e15#", "33.00%" },
		{ 30244, "", "=q4=Helm of the Vanquished Hero", "=ds=#m22# #e15#", "33.00%" },
		{ 0,"","","" },
		{ 30183, "", "=q4=Nether Vortex", "=ds=#e8#", "100%" },
	};

	CFRSerpentTrash = {
		{ 30027, "", "=q4=Boots of Courage Unending", "=ds=#s12#, #a4#" },
		{ 30022, "", "=q4=Pendant of the Perilous", "=ds=#s2#" },
		{ 30620, "", "=q4=Spyglass of the Hidden Fleet", "=ds=#s14#" },
		{ 30023, "", "=q4=Totem of the Maelstrom", "=ds=#s16#, #w15#" },
		{ 30021, "", "=q4=Wildfury Greatstaff", "=ds=#w9#" },
		{ 30025, "", "=q4=Serpentshrine Shuriken", "=ds=#w11#" },
		{ 0,"","","" },
		{ 30183, "", "=q4=Nether Vortex", "=ds=#e8#" },
	};

		-----------------------------
		--- Tempest Keep: The Eye ---
		-----------------------------

	TKEyeAlar = {
		{ 29925, "", "=q4=Phoenix-Wing Cloak", "=ds=#s4#", "8.00%" },
		{ 29918, "", "=q4=Mindstorm Wristbands", "=ds=#s8#, #a1#", "8.00%" },
		{ 29947, "", "=q4=Gloves of the Searing Grip", "=ds=#s9#, #a2#", "8.00%" },
		{ 29921, "", "=q4=Fire Crest Breastplate", "=ds=#s5#, #a3#", "8.00%" },
		{ 29922, "", "=q4=Band of Al'Ar", "=ds=#s13#", "8.00%" },
		{ 29920, "", "=q4=Phoenix-Ring of Rebirth", "=ds=#s13#", "8.00%" },
		{ 30448, "", "=q4=Talon of Al'ar", "=ds=#s14#, =q1=#m1# =ds=#c2#", "8.00%" },
		{ 30447, "", "=q4=Tome of Fiery Redemption", "=ds=#s14#, =q1=#m1# =ds=#c4#", "8.00%" },
		{ 29923, "", "=q4=Talisman of the Sun King", "=ds=#s15#", "8.00%" },
		{ 29948, "", "=q4=Claw of the Phoenix", "=ds=#h4#, #w13#", "8.00%" },
		{ 29924, "", "=q4=Netherbane", "=ds=#h1#, #w1#", "8.00%" },
		{ 29949, "", "=q4=Arcanite Steam-Pistol", "=ds=#w5#", "8.00%" },
	};

	TKEyeVoidReaver = {
		{ 29986, "", "=q4=Cowl of the Grand Engineer", "=ds=#s1#, #a1#", "17.00%" },
		{ 29984, "", "=q4=Girdle of Zaetar", "=ds=#s10#, #a2#", "17.00%" },
		{ 29985, "", "=q4=Void Reaver Greaves", "=ds=#s11#, #a3#", "17.00%" },
		{ 29983, "", "=q4=Fel-Steel Warhelm", "=ds=#s1#, #a4#", "17.00%" },
		{ 30619, "", "=q4=Fel Reaver's Piston", "=ds=#s14#", "17.00%" },
		{ 30450, "", "=q4=Warp-Spring Coil", "=ds=#s14#, =q1=#m1# =ds=#c6#", "17.00%" },
		{ 0,"","","" },
		{ 30248, "", "=q4=Pauldrons of the Vanquished Champion", "=ds=#m22# #e15#", "33.00%" },
		{ 30249, "", "=q4=Pauldrons of the Vanquished Defender", "=ds=#m22# #e15#", "33.00%" },
		{ 30250, "", "=q4=Pauldrons of the Vanquished Hero", "=ds=#m22# #e15#", "33.00%" },
	};

	TKEyeSolarian = {
		{ 29977, "", "=q4=Star-Soul Breeches", "=ds=#s11#, #a1#", "8.00%" },
		{ 29972, "", "=q4=Trousers of the Astromancer", "=ds=#s11#, #a1#", "8.00%" },
		{ 29966, "", "=q4=Vambraces of Ending", "=ds=#s8#, #a2#", "8.00%" },
		{ 29976, "", "=q4=Worldstorm Gauntlets", "=ds=#s9#, #a3#", "8.00%" },
		{ 29951, "", "=q4=Star-Strider Boots", "=ds=#s12#, #a3#", "8.00%" },
		{ 29965, "", "=q4=Girdle of the Righteous Path", "=ds=#s10#, #a4#", "8.00%" },
		{ 29950, "", "=q4=Greaves of the Bloodwarder", "=ds=#s11#, #a4#", "8.00%" },
		{ 30446, "", "=q4=Solarian's Sapphire", "=ds=#s14#, =q1=#m1# =ds=#c9#", "8.00%" },
		{ 30449, "", "=q4=Void Star Talisman", "=ds=#s14#, =q1=#m1# =ds=#c8#", "8.00%" },
		{ 29962, "", "=q4=Heartrazor", "=ds=#h1#, #w4#", "8.00%" },
		{ 29981, "", "=q4=Etherium Life-Staff", "=ds=#w9#", "8.00%" },
		{ 29982, "", "=q4=Wand of the Forgotten Star", "=ds=#w12#", "8.00%" },
	};

	TKEyeKaelthas = {
		{ 29992, "", "=q4=Royal Cloak of the Sunstriders", "=ds=#s4#", "8.00%" },
		{ 29989, "", "=q4=Sunshower Light Cloak", "=ds=#s4#", "8.00%" },
		{ 29994, "", "=q4=Thalassian Wildercloak", "=ds=#s4#", "8.00%" },
		{ 29990, "", "=q4=Crown of the Sun", "=ds=#s1#, #a1#", "8.00%" },
		{ 29987, "", "=q4=Gauntlets of the Sun-King", "=ds=#s9#, #a1#", "8.00%" },
		{ 29995, "", "=q4=Leggings of Murderous Intent", "=ds=#s11#, #a2#", "8.00%" },
		{ 29991, "", "=q4=Sunhawk Leggings", "=ds=#s11#, #a3#", "8.00%" },
		{ 29998, "", "=q4=Royal Gauntlets of Silvermoon", "=ds=#s9#, #a4#", "8.00%" },
		{ 29997, "", "=q4=Band of the Ranger-General", "=ds=#s13#", "8.00%" },
		{ 29993, "", "=q4=Twinblade of the Phoenix", "=ds=#h2#, #w10#", "8.00%" },
		{ 29996, "", "=q4=Rod of the Sun King", "=ds=#h1#, #w6#", "8.00%" },
		{ 29988, "", "=q4=The Nexus Key", "=ds=#w9#", "8.00%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 30236, "", "=q4=Chestguard of the Vanquished Champion", "=ds=#m22# #e15#", "33.00%" },
		{ 30237, "", "=q4=Chestguard of the Vanquished Defender", "=ds=#m22# #e15#", "33.00%" },
		{ 30238, "", "=q4=Chestguard of the Vanquished Hero", "=ds=#m22# #e15#", "33.00%" },
		{ 0,"","","" },
		{ 30183, "", "=q4=Nether Vortex", "=ds=#e8#", "100%" },
	};

	TKEyeTrash = {
		{ 30024, "", "=q4=Mantle of the Elven Kings", "=ds=#s3#, #a1#" },
		{ 30020, "", "=q4=Fire-Cord of the Magus", "=ds=#s10#, #a1#" },
		{ 30029, "", "=q4=Bark-Gloves of Ancient Wisdom", "=ds=#s9#, #a2#" },
		{ 30026, "", "=q4=Bands of the Celestial Archer", "=ds=#s8#, #a3#" },
		{ 30030, "", "=q4=Girdle of Fallen Stars", "=ds=#s10#, #a3#" },
		{ 30028, "", "=q4=Seventh Ring of the Tirisfalen", "=ds=#s13#" },
		{ 0,"","","" },
		{ 30183, "", "=q4=Nether Vortex", "=ds=#e8#" },
	};

	TKEyeLegendaries = {
		{ 30312, "", "=q5=Infinity Blade", "=ds=#h1#, #w4#" },
		{ 30311, "", "=q5=Warp Slicer", "=ds=#h1#, #w10#" },
		{ 30317, "", "=q5=Cosmic Infuser", "=ds=#h3#, #w6#" },
		{ 30316, "", "=q5=Devastation", "=ds=#h2#, #w1#" },
		{ 30313, "", "=q5=Staff of Disintegration", "=ds=#w9#" },
		{ 30314, "", "=q5=Phaseshift Bulwark", "=ds=#w8#" },
		{ 30318, "", "=q5=Netherstrand Longbow", "=ds=#w2#, =q1=#m1# =ds=#c2#" },
		{ 30319, "", "=q5=Nether Spike", "=ds=#w17#" },
	};

	-------------------------------------
	--- Caverns of Time: Hyjal Summit ---
	-------------------------------------

	MountHyjalWinterchill = {
		{ 30871, "", "=q4=Bracers of Martyrdom", "=ds=#s8#, #a1#" },
		{ 30870, "", "=q4=Cuffs of Devastation", "=ds=#s8#, #a1#" },
		{ 30863, "", "=q4=Deadly Cuffs", "=ds=#s8#, #a2#" },
		{ 30868, "", "=q4=Rejuvenating Bracers", "=ds=#s8#, #a2#" },
		{ 30864, "", "=q4=Bracers of the Pathfinder", "=ds=#s8#, #a3#" },
		{ 30869, "", "=q4=Howling Wind Bracers", "=ds=#s8#, #a3#" }, 
		{ 30873, "", "=q4=Stillwater Boots", "=ds=#s12#, #a3#" },
		{ 30866, "", "=q4=Blood-stained Pauldrons", "=ds=#s3#, #a4#" },
		{ 30862, "", "=q4=Blessed Adamantite Bracers", "=ds=#s8#, #a4#" },
		{ 30861, "", "=q4=Furious Shackles", "=ds=#s8#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 30865, "", "=q4=Tracker's Blade", "=ds=#h1#, #w4#" },
		{ 30872, "", "=q4=Chronicle of Dark Secrets", "=ds=#s15#" },
		{ 0,"","","" },
		{ 32459, "", "=q1=Time-Phased Phylactery", "=ds=#m3#" },
	};

	MountHyjalAnetheron = {
		{ 30884, "", "=q4=Hatefury Mantle", "=ds=#s3#, #a1#" },
		{ 30888, "", "=q4=Anetheron's Noose", "=ds=#s10#, #a1#" },
		{ 30885, "", "=q4=Archbishop's Slippers", "=ds=#s12#, #a1#" },
		{ 30879, "", "=q4=Don Alejandro's Money Belt", "=ds=#s10#, #a2#" },
		{ 30886, "", "=q4=Enchanted Leather Sandals", "=ds=#s12#, #a2#" },
		{ 30887, "", "=q4=Golden Links of Restoration", "=ds=#s5#, #a3#" },
		{ 30880, "", "=q4=Quickstrider Moccasins", "=ds=#s12#, #a3#" },
		{ 30878, "", "=q4=Glimmering Steel Mantle", "=ds=#s3#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 30874, "", "=q4=The Unbreakable Will", "=ds=#h1#, #w10#" },
		{ 30881, "", "=q4=Blade of Infamy", "=ds=#h1#, #w10#" },
		{ 30883, "", "=q4=Pillar of Ferocity", "=ds=#w9#" },
		{ 30882, "", "=q4=Bastion of Light", "=ds=#w8#" },
	};

	MountHyjalKazrogal = {
		{ 30895, "", "=q4=Angelista's Sash", "=ds=#s10#, #a1#" },
		{ 30916, "", "=q4=Leggings of Channeled Elements", "=ds=#s11#, #a1#" },
		{ 30894, "", "=q4=Blue Suede Shoes", "=ds=#s12#, #a1#" },
		{ 30917, "", "=q4=Razorfury Mantle", "=ds=#s3#, #a2#" },
		{ 30914, "", "=q4=Belt of the Crescent Moon", "=ds=#s10#, #a2#" },
		{ 30891, "", "=q4=Black Featherlight Boots", "=ds=#s12#, #a2#" },
		{ 30892, "", "=q4=Beast-tamer's Shoulders", "=ds=#s3#, #a3#" },
		{ 30919, "", "=q4=Valestalker Girdle", "=ds=#s10#, #a3#" },
		{ 30893, "", "=q4=Sun-touched Chain Leggings", "=ds=#s11#, #a3#" },
		{ 30915, "", "=q4=Belt of Seething Fury", "=ds=#s10#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 30918, "", "=q4=Hammer of Atonement", "=ds=#h3#, #w6#" },
		{ 30889, "", "=q4=Kaz'rogal's Hardened Heart", "=ds=#w8#" },
	};

	MountHyjalAzgalor = {
		{ 30899, "", "=q4=Don Rodrigo's Poncho", "=ds=#s5#, #a2#" },
		{ 30898, "", "=q4=Shady Dealer's Pantaloons", "=ds=#s11#, #a2#" },
		{ 30900, "", "=q4=Bow-stitched Leggings", "=ds=#s11#, #a3#" },
		{ 30896, "", "=q4=Glory of the Defender", "=ds=#s5#, #a4#" },
		{ 30897, "", "=q4=Girdle of Hope", "=ds=#s10#, #a4#" },
		{ 30901, "", "=q4=Boundless Agony", "=ds=#h1#, #w4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 31092, "", "=q4=Gloves of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 31094, "", "=q4=Gloves of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 31093, "", "=q4=Gloves of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
	};

	MountHyjalArchimonde = {
		{ 30913, "", "=q4=Robes of Rhonin", "=ds=#s5#, #a1#" },
		{ 30912, "", "=q4=Leggings of Eternity", "=ds=#s11#, #a1#" },
		{ 30905, "", "=q4=Midnight Chestguard", "=ds=#s5#, #a2#" },
		{ 30907, "", "=q4=Mail of Fevered Pursuit", "=ds=#s5#, #a3#" },
		{ 30904, "", "=q4=Savior's Grasp", "=ds=#s5#, #a4#" },
		{ 30903, "", "=q4=Legguards of Endless Rage", "=ds=#s11#, #a4#" },
		{ 30911, "", "=q4=Scepter of Purification", "=ds=#s15#" },
		{ 0,"","","" },
		{ 30910, "", "=q4=Tempest of Chaos", "=ds=#h3#, #w10#" },
		{ 30902, "", "=q4=Cataclysm's Edge", "=ds=#h2#, #w10#" },
		{ 30908, "", "=q4=Apostle of Argus", "=ds=#w9#" },
		{ 30909, "", "=q4=Antonidas's Aegis of Rapt Concentration", "=ds=#w8#" },
		{ 30906, "", "=q4=Bristleblitz Striker", "=ds=#w2#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 31097, "", "=q4=Helm of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 31095, "", "=q4=Helm of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 31096, "", "=q4=Helm of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
		};

	MountHyjalTrash = {
		{ 32590, "", "=q4=Nethervoid Cloak", "=ds=#s4#" },
		{ 34010, "", "=q4=Pepe's Shroud of Pacification","=ds=#s4#" },
		{ 32609, "", "=q4=Boots of the Divine Light", "=ds=#s12#, #a1#" },
		{ 32592, "", "=q4=Chestguard of Relentless Storms", "=ds=#s5#, #a3#" },
		{ 32591, "", "=q4=Choker of Serrated Blades", "=ds=#s2#" },
		{ 32589, "", "=q4=Hellfire-Encased Pendant", "=ds=#s2#" },
		{ 34009, "", "=q4=Hammer of Judgement","=ds=#h3#, #w6#" },
		{ 32946, "", "=q4=Claw of Molten Fury", "=ds=#h3#, #w13#" },
		{ 32945, "", "=q4=Fist of Molten Fury", "=ds=#h4#, #w13#" },
		{ 0,"","","" },
		{ 32428, "", "=q3=Heart of Darkness", "=ds=#e8#" },
		{ 32897, "", "=q2=Mark of the Illidari", "=ds=#m20#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32285, "", "=q4=Design: Flashing Crimson Spinel", "=ds=#p12# (375)" },
		{ 32296, "", "=q4=Design: Great Lionseye", "=ds=#p12# (375)" },
		{ 32303, "", "=q4=Design: Inscribed Pyrestone", "=ds=#p12# (375)" },
		{ 32295, "", "=q4=Design: Mystic Lionseye", "=ds=#p12# (375)" },
		{ 32298, "", "=q4=Design: Shifting Shadowsong Amethyst", "=ds=#p12# (375)" },
		{ 32297, "", "=q4=Design: Sovereign Shadowsong Amethyst", "=ds=#p12# (375)" },
		{ 32289, "", "=q4=Design: Stormy Empyrean Sapphire", "=ds=#p12# (375)" },
		{ 32307, "", "=q4=Design: Veiled Pyrestone", "=ds=#p12# (375)" },
		};

	--------------------
	--- Black Temple ---
	--------------------

	BTNajentus = {
		{ 32239, "", "=q4=Slippers of the Seacaller", "=ds=#s12#, #a1#" },
		{ 32240, "", "=q4=Guise of the Tidal Lurker", "=ds=#s1#, #a2#" },
		{ 32377, "", "=q4=Mantle of Darkness", "=ds=#s3#, #a2#" },
		{ 32241, "", "=q4=Helm of Soothing Currents", "=ds=#s1#, #a3#" },
		{ 32234, "", "=q4=Fists of Mukoa", "=ds=#s9#, #a3#" },
		{ 32242, "", "=q4=Boots of Oceanic Fury", "=ds=#s12#, #a3#" },
		{ 32232, "", "=q4=Eternium Shell Bracers", "=ds=#s8#, #a4#" },
		{ 32243, "", "=q4=Pearl Inlaid Boots", "=ds=#s12#, #a4#" },
		{ 32245, "", "=q4=Tide-stomper's Greaves", "=ds=#s12#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32238, "", "=q4=Ring of Calming Waves", "=ds=#s13#" },
		{ 32247, "", "=q4=Ring of Captured Storms", "=ds=#s13#" },
		{ 32237, "", "=q4=The Maelstrom's Fury", "=ds=#h3#, #w4#" },
		{ 32236, "", "=q4=Rising Tide", "=ds=#h1#, #w1#" },
		{ 32248, "", "=q4=Halberd of Desolation", "=ds=#w7#" },
	};

	BTSupremus = {
		{ 32256, "", "=q4=Waistwrap of Infinity", "=ds=#s10#, #a1#" },
		{ 32252, "", "=q4=Nether Shadow Tunic", "=ds=#s5#, #a2#" },
		{ 32259, "", "=q4=Bands of the Coming Storm", "=ds=#s8#, #a3#" },
		{ 32251, "", "=q4=Wraps of Precise Flight", "=ds=#s8#, #a3#" },
		{ 32258, "", "=q4=Naturalist's Preserving Cinch", "=ds=#s10#, #a3#" },
		{ 32250, "", "=q4=Pauldrons of Abyssal Fury", "=ds=#s3#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32260, "", "=q4=Choker of Endless Nightmares", "=ds=#s2#" },
		{ 32261, "", "=q4=Band of the Abyssal Lord", "=ds=#s13#" },
		{ 32257, "", "=q4=Idol of the White Stag", "=ds=#s16#, #w14#" },
		{ 32254, "", "=q4=The Brutalizer", "=ds=#h1#, #w1#" },
		{ 32262, "", "=q4=Syphon of the Nathrezim", "=ds=#h1#, #w6#" },
		{ 32255, "", "=q4=Felstone Bulwark", "=ds=#w8#" },
		{ 32253, "", "=q4=Legionkiller", "=ds=#w3#" },
	};

	BTGorefiend = {
		{ 32323, "", "=q4=Shadowmoon Destroyer's Drape", "=ds=#s4#" },
		{ 32329, "", "=q4=Cowl of Benevolence", "=ds=#s1#, #a1#" },
		{ 32327, "", "=q4=Robe of the Shadow Council", "=ds=#s5#, #a1#" },
		{ 32324, "", "=q4=Insidious Bands", "=ds=#s8#, #a2#" },
		{ 32328, "", "=q4=Botanist's Gloves of Growth", "=ds=#s9#, #a2#" },
		{ 32510, "", "=q4=Softstep Boots of Tracking", "=ds=#s12#, #a3#" },
		{ 32280, "", "=q4=Gauntlets of Enforcement", "=ds=#s9#, #a4#" },
		{ 32512, "", "=q4=Girdle of Lordaeron's Fallen", "=ds=#s10#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32330, "", "=q4=Totem of Ancestral Guidance", "=ds=#s16#, #w15#" },
		{ 32348, "", "=q4=Soul Cleaver", "=ds=#h2#, #w1#" },
		{ 32326, "", "=q4=Twisted Blades of Zarak", "=ds=#w11#" },
		{ 32325, "", "=q4=Rifle of the Stoic Guardian", "=ds=#w5#" },
	};

	BTBloodboil = {
		{ 32337, "", "=q4=Shroud of Forgiveness", "=ds=#s4#" },
		{ 32338, "", "=q4=Blood-cursed Shoulderpads", "=ds=#s3#, #a1#" },
		{ 32340, "", "=q4=Garments of Temperance", "=ds=#s5#, #a1#" },
		{ 32339, "", "=q4=Belt of Primal Majesty", "=ds=#s10#, #a2#" },
		{ 32334, "", "=q4=Vest of Mounting Assault", "=ds=#s5#, #a3#" },
		{ 32342, "", "=q4=Girdle of Mighty Resolve", "=ds=#s10#, #a4#" },
		{ 32333, "", "=q4=Girdle of Stability", "=ds=#s10#, #a4#" },
		{ 32341, "", "=q4=Leggings of Divine Retribution", "=ds=#s11#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32335, "", "=q4=Unstoppable Aggressor's Ring", "=ds=#s13#" },
		{ 32501, "", "=q4=Shadowmoon Insignia", "=ds=#s14#" },
		{ 32269, "", "=q4=Messenger of Fate", "=ds=#h1#, #w4#" },
		{ 32344, "", "=q4=Staff of Immaculate Recovery", "=ds=#w9#" },
		{ 32343, "", "=q4=Wand of Prismatic Focus", "=ds=#w12#" },
	};

	BTAkama = {
		{ 32273, "", "=q4=Amice of Brilliant Light", "=ds=#s3#, #a1#" },
		{ 32270, "", "=q4=Focused Mana Bindings", "=ds=#s8#, #a1#" },
		{ 32513, "", "=q4=Wristbands of Divine Influence", "=ds=#s8#, #a1#" },
		{ 32265, "", "=q4=Shadow-walker's Cord", "=ds=#s10#, #a2#" },
		{ 32271, "", "=q4=Kilt of Immortal Nature", "=ds=#s11#, #a2#" },
		{ 32264, "", "=q4=Shoulders of the Hidden Predator", "=ds=#s3#, #a3#" },
		{ 32275, "", "=q4=Spiritwalker Gauntlets", "=ds=#s9#, #a3#" },
		{ 32276, "", "=q4=Flashfire Girdle", "=ds=#s10#, #a3#" },
		{ 32279, "", "=q4=The Seeker's Wristguards", "=ds=#s8#, #a4#" },
		{ 32278, "", "=q4=Grips of Silent Justice", "=ds=#s9#, #a4#" },
		{ 32263, "", "=q4=Praetorian's Legguards", "=ds=#s11#, #a4#" },
		{ 32268, "", "=q4=Myrmidon's Treads", "=ds=#s12#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32266, "", "=q4=Ring of Deceitful Intent", "=ds=#s13#" },
		{ 32361, "", "=q4=Blind-Seers Icon", "=ds=#s15#" },
	};

	BTEssencofSouls = {
		{ 32353, "", "=q4=Gloves of Unfailing Faith", "=ds=#s9#, #a1#" },
		{ 32351, "", "=q4=Elunite Empowered Bracers", "=ds=#s8#, #a2#" },
		{ 32347, "", "=q4=Grips of Damnation", "=ds=#s9#, #a2#" },
		{ 32352, "", "=q4=Naturewarden's Treads", "=ds=#s12#, #a2#" },
		{ 32517, "", "=q4=The Wavemender's Mantle", "=ds=#s3#, #a3#" },
		{ 32346, "", "=q4=Boneweave Girdle", "=ds=#s10#, #a3#" },
		{ 32354, "", "=q4=Crown of Empowered Fate", "=ds=#s1#, #a4#" },
		{ 32345, "", "=q4=Dreadboots of the Legion", "=ds=#s12#, #a4#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32349, "", "=q4=Translucent Spellthread Necklace", "=ds=#s2#" },
		{ 32362, "", "=q4=Pendant of Titans", "=ds=#s2#" },
		{ 32350, "", "=q4=Touch of Inspiration", "=ds=#s15#" },
		{ 32332, "", "=q4=Torch of the Damned", "=ds=#h2#, #w6#" },
		{ 32363, "", "=q4=Naaru-Blessed Life Rod", "=ds=#w12#" },
	};

	BTShahraz = {
		{ 32367, "", "=q4=Leggings of Devastation", "=ds=#s11#, #a1#" },
		{ 32366, "", "=q4=Shadowmaster's Boots", "=ds=#s12#, #a2#" },
		{ 32365, "", "=q4=Heartshatter Breastplate", "=ds=#s5#, #a4#" },
		{ 32370, "", "=q4=Nadina's Pendant of Purity", "=ds=#s2#" },
		{ 32368, "", "=q4=Tome of the Lightbringer", "=ds=#s16#, #w16#" },
		{ 32369, "", "=q4=Blade of Savagery", "=ds=#h1#, #w10#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 31101, "", "=q4=Pauldrons of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 31103, "", "=q4=Pauldrons of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 31102, "", "=q4=Pauldrons of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
	};

	BTCouncil = {
		{ 32331, "", "=q4=Cloak of the Illidari Council", "=ds=#s4#" },
		{ 32519, "", "=q4=Belt of Divine Guidance", "=ds=#s10#, #a1#" },
		{ 32518, "", "=q4=Veil of Turning Leaves", "=ds=#s3#, #a2#" },
		{ 32376, "", "=q4=Forest Prowler's Helm", "=ds=#s1#, #a3#" },
		{ 32373, "", "=q4=Helm of the Illidari Shatterer", "=ds=#s1#, #a4#" },
		{ 32505, "", "=q4=Madness of the Betrayer", "=ds=#s14#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 31098, "", "=q4=Leggings of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 31100, "", "=q4=Leggings of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 31099, "", "=q4=Leggings of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
	};

	BTIllidanStormrage = {
		{ 32524, "", "=q4=Shroud of the Highborne", "=ds=#s4#" },
		{ 32525, "", "=q4=Cowl of the Illidari High Lord", "=ds=#s1#, #a1#" },
		{ 32235, "", "=q4=Cursed Vision of Sargeras", "=ds=#s1#, #a2#" },
		{ 32521, "", "=q4=Faceplate of the Impenetrable", "=ds=#s1#, #a4#" },
		{ 32497, "", "=q4=Stormrage Signet Ring", "=ds=#s13#" },
		{ 32483, "", "=q4=The Skull of Gul'dan", "=ds=#s14#" },
		{ 32496, "", "=q4=Memento of Tyrande", "=ds=#s14#" },
		{ 0,"","","" },
		{ 32837, "", "=q5=Warglaive of Azzinoth", "=ds=#h3#, #w10#, =q1=#m1# =ds=#c9#, #c6#" },
		{ 32838, "", "=q5=Warglaive of Azzinoth", "=ds=#h4#, #w10#, =q1=#m1# =ds=#c9#, #c6#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 31089, "", "=q4=Chestguard of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 31091, "", "=q4=Chestguard of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 31090, "", "=q4=Chestguard of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
		{ 0,"","","" },
		{ 32471, "", "=q4=Shard of Azzinoth", "=ds=#h1#, #w4#" },
		{ 32500, "", "=q4=Crystal Spire of Karabor", "=ds=#h3#, #w6#" },
		{ 32374, "", "=q4=Zhar'doom, Greatstaff of the Devourer", "=ds=#w9#" },
		{ 32375, "", "=q4=Bulwark of Azzinoth", "=ds=#w8#" },
		{ 32336, "", "=q4=Black Bow of the Betrayer", "=ds=#w2#" },
	};

	BTTrash = {
		{ 32590, "", "=q4=Nethervoid Cloak", "=ds=#s4#" },
		{ 34012, "", "=q4=Shroud of the Final Stand","=ds=#s4#" },
		{ 32609, "", "=q4=Boots of the Divine Light", "=ds=#s12#, #a1#" },
		{ 32593, "", "=q4=Treads of the Den Mother", "=ds=#s12#, #a2#" },
		{ 32592, "", "=q4=Chestguard of Relentless Storms", "=ds=#s5#, #a3#" },
		{ 32608, "", "=q4=Pillager's Gauntlets", "=ds=#s9#, #a4#" },
		{ 32606, "", "=q4=Girdle of the Lightbearer", "=ds=#s10#, #a4#" },
		{ 32591, "", "=q4=Choker of Serrated Blades", "=ds=#s2#" },
		{ 32589, "", "=q4=Hellfire-Encased Pendant", "=ds=#s2#" },
		{ 32526, "", "=q4=Band of Devastation", "=ds=#s13#" },
		{ 32528, "", "=q4=Blessed Band of Karabor", "=ds=#s13#" },
		{ 32527, "", "=q4=Ring of Ancient Knowledge", "=ds=#s13#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 34009, "", "=q4=Hammer of Judgement","=ds=#h3#, #w6#" },
		{ 32943, "", "=q4=Swiftsteel Bludgeon", "=ds=#h1#, #w6#" },
		{ 34011, "", "=q4=Illidari Runeshield", "=ds=#w8#" },
		{ 0,"","","" },
		{ 32228, "", "=q4=Empyrean Sapphire", "=ds=#e7#" },
		{ 32231, "", "=q4=Pyrestone", "=ds=#e7#" },
		{ 32229, "", "=q4=Lionseye", "=ds=#e7#" },
		{ 32249, "", "=q4=Seaspray Emerald", "=ds=#e7#" },
		{ 32230, "", "=q4=Shadowsong Amethyst", "=ds=#e7#" },
		{ 32227, "", "=q4=Crimson Spinel", "=ds=#e7#" },
		{ 0,"","","" },
		{ 32428, "", "=q3=Heart of Darkness", "=ds=#e8#" },
		{ 32897, "", "=q2=Mark of the Illidari", "=ds=#m20#" },
	};

	BTPatterns = {
		{ 32748, "", "=q4=Pattern: Bindings of Lightning Reflexes", "=ds=#p7# (375)" },
		{ 32744, "", "=q4=Pattern: Bracers of Renewed Life", "=ds=#p7# (375)" },
		{ 32750, "", "=q4=Pattern: Living Earth Bindings", "=ds=#p7# (375)" },
		{ 32751, "", "=q4=Pattern: Living Earth Shoulders", "=ds=#p7# (375)" },
		{ 32749, "", "=q4=Pattern: Shoulders of Lightning Reflexes", "=ds=#p7# (375)" },
		{ 32745, "", "=q4=Pattern: Shoulderpads of Renewed Life", "=ds=#p7# (375)" },
		{ 32746, "", "=q4=Pattern: Swiftstrike Bracers", "=ds=#p7# (375)" },
		{ 32747, "", "=q4=Pattern: Swiftstrike Shoulders", "=ds=#p7# (375)" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32754, "", "=q4=Pattern: Bracers of Nimble Thought", "=ds=#p8# (375)" },
		{ 32755, "", "=q4=Pattern: Mantle of Nimble Thought", "=ds=#p8# (375)" },
		{ 32753, "", "=q4=Pattern: Swiftheal Mantle", "=ds=#p8# (375)" },
		{ 32752, "", "=q4=Pattern: Swiftheal Wraps", "=ds=#p8# (375)" },
	};

	----------------
	--- Zul'Aman ---
	----------------

	ZANalorakk = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 33203, "", "=q4=Robes of Heavenly Purpose", "=ds=#s5#, #a1#" },
		{ 33285, "", "=q4=Fury of the Ursine", "=ds=#s8#, #a1#" },
		{ 33211, "", "=q4=Bladeangel's Money Belt", "=ds=#s10#, #a2#" },
		{ 33206, "", "=q4=Pauldrons of Primal Fury", "=ds=#s3#, #a3#" },
		{ 33327, "", "=q4=Mask of Introspection", "=ds=#s1#, #a4#" },
		{ 33191, "", "=q4=Jungle Stompers", "=ds=#s12#, #a4#" },
		{ 33640, "", "=q4=Fury", "=ds=#h4#, #w13#" },
		{ 0,"","","" },
		{ 33307, "", "=q3=Formula: Enchant Weapon - Executioner","=ds=#p4# (375)" },
	};

	ZAAkilZon = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 33286, "", "=q4=Mojo-mender's Mask", "=ds=#s1#, #a3#" },
		{ 33215, "", "=q4=Bloodstained Elven Battlevest", "=ds=#s5#, #a4#" },
		{ 33216, "", "=q4=Chestguard of Hidden Purpose", "=ds=#s5#, #a4#" },
		{ 33281, "", "=q4=Brooch of Nature's Mercy", "=ds=#s2#" },
		{ 33293, "", "=q4=Signet of Ancient Magics", "=ds=#s13#" },
		{ 33214, "", "=q4=Akil'zon's Talonblade", "=ds=#h1#, #w10#" },
		{ 33283, "", "=q4=Amani Punisher", "=ds=#h3#, #w6#" },
		{ 0,"","","" },
		{ 33307, "", "=q3=Formula: Enchant Weapon - Executioner","=ds=#p4# (375)" },
	};

	ZAJanAlai = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 33357, "", "=q4=Footpads of Madness", "=ds=#s12#, #a1#" },
		{ 33356, "", "=q4=Helm of Natural Regeneration", "=ds=#s1#, #a2#" },
		{ 33329, "", "=q4=Shadowtooth Trollskin Cuirass", "=ds=#s5#, #a2#" },
		{ 33328, "", "=q4=Arrow-fall Chestguard", "=ds=#s5#, #a3#" },
		{ 33354, "", "=q4=Wub's Cursed Hexblade", "=ds=#h3#, #w4#" },
		{ 33326, "", "=q4=Bulwark of the Amani Empire", "=ds=#w8#" },
		{ 33332, "", "=q4=Enamelled Disc of Mojo", "=ds=#w8#" },
		{ 0,"","","" },
		{ 33307, "", "=q3=Formula: Enchant Weapon - Executioner","=ds=#p4# (375)" },
	};

	ZAHalazzi = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 33317, "", "=q4=Robe of Departed Spirits", "=ds=#s5#, #a1#" },
		{ 33300, "", "=q4=Shoulderpads of Dancing Blades", "=ds=#s3#, #a2#" },
		{ 33322, "", "=q4=Shimmer-pelt Vest", "=ds=#s5#, #a2#" },
		{ 33533, "", "=q4=Avalanche Leggings", "=ds=#s11#, #a3#" },
		{ 33299, "", "=q4=Spaulders of the Advocate", "=ds=#s3#, #a4#" },
		{ 33303, "", "=q4=Skullshatter Warboots", "=ds=#s12#, #a4#" },
		{ 33297, "", "=q4=The Savage's Choker", "=ds=#s2#" },
		{ 0,"","","" },
		{ 33307, "", "=q3=Formula: Enchant Weapon - Executioner","=ds=#p4# (375)" },
	};

	ZAMalacrass = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 33592, "", "=q4=Cloak of Ancient Rituals", "=ds=#s4#" },
		{ 33453, "", "=q4=Hood of Hexing", "=ds=#s1#, #a1#" },
		{ 33463, "", "=q4=Hood of the Third Eye", "=ds=#s1#, #a1#" },
		{ 33432, "", "=q4=Coif of the Jungle Stalker", "=ds=#s1#, #a3#" },
		{ 33464, "", "=q4=Hex Lord's Voodoo Pauldrons", "=ds=#s3#, #a3#" },
		{ 33421, "", "=q4=Battleworn Tuskguard", "=ds=#s1#, #a4#" },
		{ 33446, "", "=q4=Girdle of Stromgarde's Hope", "=ds=#s10#, #a4#" },
		{ 0,"","","" },
		{ 33307, "", "=q3=Formula: Enchant Weapon - Executioner","=ds=#p4# (375)" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 33829, "", "=q4=Hex Shrunken Head", "=ds=#s14#" },
		{ 34029, "", "=q4=Tiny Voodoo Mask", "=ds=#s14#" },
		{ 33828, "", "=q4=Tome of Diabolic Remedy", "=ds=#s14#" },
		{ 33389, "", "=q4=Dagger of Bad Mojo", "=ds=#h1#, #w4#" },
		{ 33298, "", "=q4=Prowler's Strikeblade", "=ds=#h1#, #w4#" },
		{ 33388, "", "=q4=Heartless", "=ds=#h1#, #w10#" },
		{ 33465, "", "=q4=Staff of Primal Fury", "=ds=#w9#" },
	};

	ZAZuljin = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 33471, "", "=q4=Two-toed Sandals", "=ds=#s12#, #a1#" },
		{ 33479, "", "=q4=Grimgin Faceguard", "=ds=#s1#, #a2#" },
		{ 33469, "", "=q4=Hauberk of the Empire's Champion", "=ds=#s5#, #a3#" },
		{ 33473, "", "=q4=Chestguard of the Warlord", "=ds=#s5#, #a4#" },
		{ 33466, "", "=q4=Loop of Cursed Bones", "=ds=#s2#" },
		{ 33830, "", "=q4=Ancient Aqir Artifact", "=ds=#s14#" },
		{ 33831, "", "=q4=Berserker's Call", "=ds=#s14#" },
		{ 0,"","","" },
		{ 33307, "", "=q3=Formula: Enchant Weapon - Executioner","=ds=#p4# (375)" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 33467, "", "=q4=Blade of Twisted Visions", "=ds=#h3#, #w10#" },
		{ 33478, "", "=q4=Jin'rohk, The Great Apocalypse", "=ds=#h2#, #w10#" },
		{ 33476, "", "=q4=Cleaver of the Unforgiving", "=ds=#h1#, #w1#" },
		{ 33468, "", "=q4=Dark Blessing", "=ds=#h3#, #w6#" },
		{ 33474, "", "=q4=Ancient Amani Longbow", "=ds=#w2#" },
		{ 0,"","","" },
		{ 33102, "", "=q4=Blood of Zul'Jin", "=ds=#m2#" },
	};

	ZATimedChest = {
		{ 0, "INV_Box_01", "=q6=#x30#", "" },
		{ 33590, "", "=q4=Cloak of Fiends", "=ds=#s4#" },
		{ 33591, "", "=q4=Shadowcaster's Drape", "=ds=#s4#" },
		{ 33489, "", "=q4=Mantle of Ill Intent", "=ds=#s3#, #a1#" },
		{ 33480, "", "=q4=Cord of Braided Troll Hair", "=ds=#s10#, #a1#" },
		{ 33483, "", "=q4=Life-step Belt", "=ds=#s10#, #a2#" },
		{ 33971, "", "=q4=Elunite Imbued Leggings", "=ds=#s11#, #a2#" },
		{ 33805, "", "=q4=Shadowhunter's Treads", "=ds=#s12#, #a3#" },
		{ 33481, "", "=q4=Pauldrons of Stone Resolve", "=ds=#s3#, #a4#" },
		{ 0, "INV_Box_01", "=q6=#x32#", "" },
		{ 33497, "", "=q4=Mana Attuned Band", "=ds=#s13#" },
		{ 33500, "", "=q4=Signet of Eternal Life", "=ds=#s13#" },
		{ 33496, "", "=q4=Signet of Primal Wrath", "=ds=#s13#" },
		{ 33499, "", "=q4=Signet of the Last Defender", "=ds=#s13#" },
		{ 33498, "", "=q4=Signet of the Quiet Forest", "=ds=#s13#" },
		{ 0, "INV_Box_01", "=q6=#x31#", "" },
		{ 33495, "", "=q4=Rage", "=ds=#h3#, #w13#" },
		{ 33493, "", "=q4=Umbral Shiv", "=ds=#h1#, #w4#" },
		{ 33492, "", "=q4=Trollbane", "=ds=#h2#, #w1#" },
		{ 33490, "", "=q4=Staff of Dark Mending", "=ds=#w9#" },
		{ 33494, "", "=q4=Amani Divining Staff", "=ds=#w9#" },
		{ 33491, "", "=q4=Tuskbreaker", "=ds=#w5#" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#x33#", "" },
		{ 33809, "", "=q4=Amani War Bear", "=ds=#e12#" },
	};

	ZATrash = {
		{ 33993, "", "=q3=Mojo", "=ds=#e13#" },
		{ 0,"","","" },
		{ 33865, "", "=q2=Amani Hex Stick", "=ds=#m20#" },
		{ 33930, "", "=q2=Amani Charm of the Bloodletter", "=ds=#m26#" },
		{ 33932, "", "=q2=Amani Charm of the Witch Doctor", "=ds=#m26#" },
		{ 33931, "", "=q2=Amani Charm of Mighty Mojo", "=ds=#m26#" },
		{ 33933, "", "=q2=Amani Charm of the Raging Defender", "=ds=#m26#" },
	};

	----------------------------------------
	--- Sunwell Isle: Magister's Terrace ---
	----------------------------------------

	SMTFireheart = {
		{ 34702, "", "=q3=Cloak of Swift Mending", "=ds=#s4#" },
		{ 34697, "", "=q3=Bindings of Raging Fire", "=ds=#s8#, #a1#" },
		{ 34701, "", "=q3=Leggings of the Betrayed", "=ds=#s11#, #a2#" },
		{ 34698, "", "=q3=Bracers of the Forest Stalker", "=ds=#s8#, #a3#" },
		{ 34700, "", "=q3=Gauntlets of Divine Blessings", "=ds=#s9#, #a4#" },
		{ 34699, "", "=q3=Sun-forged Cleaver", "=ds=#h1#, #w1#" },
	};

	SMTFireheartHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 34602, "", "=q4=Eversong Cuffs", "=ds=#s8#, #a2#" },
		{ 34601, "", "=q4=Shoulderplates of Everlasting Pain", "=ds=#s3#, #a4#" },
		{ 34604, "", "=q4=Jaded Crystal Dagger", "=ds=#h3#, #w4#" },
		{ 34603, "", "=q4=Distracting Blades", "=ds=#w11#" },
		{ 0,"","","" },
		{ 35275, "", "=q3=Orb of the Sin'dorei", "=ds=#m20#" },
	};

	SMTVexallus = {
		{ 34708, "", "=q3=Cloak of the Coming Night", "=ds=#s4#" },
		{ 34705, "", "=q3=Bracers of Divine Infusion", "=ds=#s8#, #a1#" },
		{ 34707, "", "=q3=Boots of Resuscitation", "=ds=#s12#, #a2#" },
		{ 34704, "", "=q3=Band of Arcane Alacrity", "=ds=#s13#" },
		{ 34706, "", "=q3=Band of Determination", "=ds=#s13#" },
		{ 34703, "", "=q3=Latro's Dancing Blade", "=ds=#h1#, #w10#" },
	};

	SMTVexallusHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 34607, "", "=q4=Fel-tinged Mantle", "=ds=#s3#, #a1#" },
		{ 34605, "", "=q4=Breastplate of Fierce Survival", "=ds=#s5#, #a4#" },
		{ 34606, "", "=q4=Edge of Oppression", "=ds=#h1#, #w4#" },
		{ 34608, "", "=q4=Rod of the Blazing Light", "=ds=#w9#" },
		{ 0,"","","" },
		{ 35275, "", "=q3=Orb of the Sin'dorei", "=ds=#m20#" },
	};

	SMTDelrissa = {
		{ 34792, "", "=q3=Cloak of the Betrayed", "=ds=#s4#" },
		{ 34788, "", "=q3=Duskhallow Mantle", "=ds=#s3#, #a1#" },
		{ 34791, "", "=q3=Gauntlets of the Tranquil Waves", "=ds=#s9#, #a3#" },
		{ 34789, "", "=q3=Bracers of Slaughter", "=ds=#s8#, #a4#" },
		{ 34790, "", "=q3=Battle-mace of the High Priestess", "=ds=#h3#, #w6#" },
		{ 34783, "", "=q3=Nightstrike", "=ds=#w11#" },
		{ 0,"","","" },
		{ 35756, "", "=q3=Formula: Enchant Cloak - Steelweave", "=ds=#p4# (375)" },
	};

	SMTDelrissaHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 34473, "", "=q4=Commendation of Kael'thas", "=ds=#s14#" },
		{ 34471, "", "=q4=Vial of the Sunwell", "=ds=#s14#" },
		{ 34470, "", "=q4=Timbal's Focusing Crystal", "=ds=#s14#" },
		{ 34472, "", "=q4=Shard of Contempt", "=ds=#s14#" },
		{ 0,"","","" },
		{ 35756, "", "=q3=Formula: Enchant Cloak - Steelweave", "=ds=#p4# (375)" },
		{ 35275, "", "=q3=Orb of the Sin'dorei", "=ds=#m20#" },
	};

	SMTKaelthas = {
		{ 34810, "", "=q4=Cloak of Blade Turning", "=ds=#s4#" },
		{ 34808, "", "=q4=Gloves of Arcane Acuity", "=ds=#s9#, #a1#" },
		{ 34809, "", "=q4=Sunrage Treads", "=ds=#s12#, #a2#" },
		{ 34799, "", "=q4=Hauberk of the War Bringer", "=ds=#s5#, #a3#" },
		{ 34807, "", "=q4=Sunstrider Warboots", "=ds=#s12#, #a4#" },
		{ 34625, "", "=q4=Kharmaa's Ring of Fate", "=ds=#s13#" },
		{ 0,"","","" },
		{ 35311, "", "=q3=Schematic: Mana Potion Injector", "=ds=#p5# (345)" },
		{ 35304, "", "=q3=Design: Solid Star of Elune", "=ds=#p12# (350)" },
		{ 0,"","","" },
		{ 34157, "", "=q1=Head of Kael'thas", "=ds=#m3#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 34793, "", "=q3=Cord of Reconstruction", "=ds=#s10#, #a1#" },
		{ 34796, "", "=q3=Robes of Summer Flame", "=ds=#s5#, #a2#" },
		{ 34795, "", "=q3=Helm of Sanctification", "=ds=#s1#, #a4#" },
		{ 34798, "", "=q3=Band of Celerity", "=ds=#s13#" },
		{ 34794, "", "=q3=Axe of Shattered Dreams", "=ds=#h2#, #w1#" },
		{ 34797, "", "=q3=Sun-infused Focus Staff", "=ds=#w9#" },
		{ 35504, "", "=q3=Phoenix Hatchling", "=ds=#e13#" },
		};

	SMTKaelthasHEROIC = {
		{ 29434, "", "=q4=Badge of Justice", "=ds=#e15#", "100%" },
		{ 34610, "", "=q4=Scarlet Sin'dorei Robes", "=ds=#s5#, #a1#" },
		{ 34613, "", "=q4=Shoulderpads of the Silvermoon Retainer", "=ds=#s3#, #a2#" },
		{ 34614, "", "=q4=Tunic of the Ranger Lord", "=ds=#s5#, #a3#" },
		{ 34615, "", "=q4=Netherforce Chestplate", "=ds=#s5#, #a4#" },
		{ 34612, "", "=q4=Greaves of the Penitent Knight", "=ds=#s12#, #a4#" },
		{ 34611, "", "=q4=Cudgel of Consecration", "=ds=#h3#, #w6#" },
		{ 34609, "", "=q4=Quickening Blade of the Prince", "=ds=#h1#, #w10#" },
		{ 34616, "", "=q4=Breeching Comet", "=ds=#h1#, #w1#" },
		{ 35513, "", "=q4=Swift White Hawkstrider", "=ds=#e12#" },
		{ 0,"","","" },
		{ 35504, "", "=q3=Phoenix Hatchling", "=ds=#e13#" },
		{ 0,"","","" },
		{ 35311, "", "=q3=Schematic: Mana Potion Injector", "=ds=#p5# (345)" },
		{ 35304, "", "=q3=Design: Solid Star of Elune", "=ds=#p12# (350)" },
	};

	SMTTrash = {
		{ 35516, "", "=q3=Sun Touched Satchel", "=ds=#e1# #m15#" },
	};

	-------------------------------------
	--- Sunwell Isle: Sunwell Plateau ---
	-------------------------------------

	SPKalecgos = {
		{ 34170, "", "=q4=Pantaloons of Calming Strife", "=ds=#s11#, #a1#" },
		{ 34386, "", "=q4=Pantaloons of Growing Strife", "=ds=#m29#" },
		{ 34169, "", "=q4=Breeches of Natural Aggression", "=ds=#s11#, #a2#" },
		{ 34384, "", "=q4=Breeches of Natural Splendor", "=ds=#m29#" },
		{ 34168, "", "=q4=Starstalker Legguards", "=ds=#s11#, #a3#" },
		{ 34167, "", "=q4=Legplates of the Holy Juggernaut", "=ds=#s11#, #a4#" },
		{ 34382, "", "=q4=Judicator's Legguards", "=ds=#m29#" },
		{ 34166, "", "=q4=Band of Lucent Beams", "=ds=#s13#" },
		{ 34165, "", "=q4=Fang of Kalecgos", "=ds=#h1#, #w4#" },
		{ 34164, "", "=q4=Dragonscale-Encrusted Longblade", "=ds=#h1#, #w10#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 34848, "", "=q4=Bracers of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 34851, "", "=q4=Bracers of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 34852, "", "=q4=Bracers of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
	};

	SPBrutallus = {
		{ 34181, "", "=q4=Leggings of Calamity", "=ds=#s11#, #a1#" },
		{ 34180, "", "=q4=Felfury Legplates", "=ds=#s11#, #a4#" },
		{ 34381, "", "=q4=Felstrength Legplates", "=ds=#m29#" },
		{ 34178, "", "=q4=Collar of the Pit Lord", "=ds=#s2#" },
		{ 34177, "", "=q4=Clutch of Demise", "=ds=#s2#" },
		{ 34179, "", "=q4=Heart of the Pit", "=ds=#s15#" },
		{ 34176, "", "=q4=Reign of Misery", "=ds=#h3#, #w6#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 34853, "", "=q4=Belt of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 34854, "", "=q4=Belt of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 34855, "", "=q4=Belt of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
	};

	SPFelmyst = {
		{ 34352, "", "=q4=Borderland Fortress Grips", "=ds=#s9#, #a4#" },
		{ 34188, "", "=q4=Leggings of the Immortal Night", "=ds=#s11#, #a2#" },
		{ 34385, "", "=q4=Leggings of the Immortal Beast", "=ds=#m29#" },
		{ 34186, "", "=q4=Chain Links of the Tumultuous Storm", "=ds=#s11#, #a3#" },
		{ 34383, "", "=q4=Kilt of Spiritual Reconstruction", "=ds=#m29#" },
		{ 34184, "", "=q4=Brooch of the Highborne", "=ds=#s2#" },
		{ 34185, "", "=q4=Sword Breaker's Bulwark", "=ds=#w8#" },
		{ 34182, "", "=q4=Grand Magister's Staff of Torrents", "=ds=#w9#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 34856, "", "=q4=Boots of the Forgotten Conqueror", "=ds=#m23# #e15#" },
		{ 34857, "", "=q4=Boots of the Forgotten Protector", "=ds=#m23# #e15#" },
		{ 34858, "", "=q4=Boots of the Forgotten Vanquisher", "=ds=#m23# #e15#" },
	};
	
	SPEredarTwins = {
		{ 34205, "", "=q4=Shroud of Redeemed Souls", "=ds=#s4#" },
		{ 34190, "", "=q4=Crimson Paragon's Cover", "=ds=#s4#" },
		{ 34210, "", "=q4=Amice of the Convoker", "=ds=#s3#, #a1#" },
		{ 34202, "", "=q4=Shawl of Wonderment", "=ds=#s3#, #a1#" },
		{ 34393, "", "=q4=Shoulderpads of Knowledge's Pursuit", "=ds=#m29#" },
		{ 34209, "", "=q4=Spaulders of Reclamation", "=ds=#s3#, #a2#" },
		{ 34391, "", "=q4=Spaulders of Devastation", "=ds=#m29#" },
		{ 34195, "", "=q4=Shoulderpads of Vehemence", "=ds=#s3#, #a2#" },
		{ 34392, "", "=q4=Demontooth Shoulderpads", "=ds=#m29#" },
		{ 34194, "", "=q4=Mantle of the Golden Forest", "=ds=#s3#, #a3#" },
		{ 34208, "", "=q4=Equilibrium Epaulets", "=ds=#s3#, #a3#" },
		{ 34390, "", "=q4=Erupting Epaulets", "=ds=#m29#" },
		{ 34192, "", "=q4=Pauldrons of Perseverance", "=ds=#s3#, #a4#" },
		{ 34388, "", "=q4=Pauldrons of Berserking", "=ds=#m29#" },
		{ 0,"","","" },
		{ 34193, "", "=q4=Spaulders of the Thalassian Savior", "=ds=#s3#, #a4#" },
		{ 34389, "", "=q4=Spaulders of the Thalassian Defender", "=ds=#m29#" },
		{ 35290, "", "=q4=Sin'dorei Pendant of Conquest", "=ds=#s2#" },
		{ 35291, "", "=q4=Sin'dorei Pendant of Salvation", "=ds=#s2#" },
		{ 35292, "", "=q4=Sin'dorei Pendant of Triumph", "=ds=#s2#" },
		{ 34204, "", "=q4=Amulet of Unfettered Magics", "=ds=#s2#" },
		{ 34189, "", "=q4=Band of Ruinous Delight", "=ds=#s13#" },
		{ 34206, "", "=q4=Book of Highborne Hymns", "=ds=#s15#" },
		{ 34197, "", "=q4=Shiv of Exsanguination", "=ds=#h1#, #w4#" },
		{ 34199, "", "=q4=Archon's Gavel", "=ds=#h3#, #w6#" },
		{ 34203, "", "=q4=Grip of Mannoroth", "=ds=#h4#, #w13#" },
		{ 34198, "", "=q4=Stanchion of Primal Instinct", "=ds=#w9#" },
		{ 34196, "", "=q4=Golden Bow of Quel'Thalas", "=ds=#w3#" },
	};

	SPMuru = {
		{ 34232, "", "=q4=Fel Conquerer Raiments", "=ds=#s5#, #a1#" },
		{ 34233, "", "=q4=Robes of Faltered Light", "=ds=#s5#, #a1#" },
		{ 34399, "", "=q4=Robes of Ghostly Hatred", "=ds=#m29#" },
		{ 34212, "", "=q4=Sunglow Vest", "=ds=#s5#, #a2#" },
		{ 34398, "", "=q4=Utopian Tunic of Elune", "=ds=#m29#" },
		{ 34211, "", "=q4=Harness of Carnal Instinct", "=ds=#s5#, #a2#" },
		{ 34397, "", "=q4=Bladed Chaos Tunic", "=ds=#m29#" },
		{ 34234, "", "=q4=Shadowed Gauntlets of Paroxysm", "=ds=#s9#, #a2#" },
		{ 34408, "", "=q4=Gloves of the Forest Drifter", "=ds=#m29#" },
		{ 34229, "", "=q4=Garments of Serene Shores", "=ds=#s5#, #a3#" },
		{ 34396, "", "=q4=Garments of Crashing Shores", "=ds=#m29#" },
		{ 34228, "", "=q4=Vicious Hawkstrider Hauberk", "=ds=#s5#, #a3#" },
		{ 34215, "", "=q4=Warharness of Reckless Fury", "=ds=#s5#, #a4#" },
		{ 34394, "", "=q4=Breastplate of Agony's Aversion", "=ds=#m29#" },
		{ 34240, "", "=q4=Gauntlets of the Soothed Soul", "=ds=#s9#, #a4#" },
		{ 34216, "", "=q4=Heroic Judicator's Chestguard", "=ds=#s5#, #a4#" },
		{ 34395, "", "=q4=Noble Judicator's Chestguard", "=ds=#m29#" },
		{ 34213, "", "=q4=Ring of Hardened Resolve", "=ds=#s13#" },
		{ 34230, "", "=q4=Ring of Omnipotence", "=ds=#s13#" },
		{ 35282, "", "=q4=Sin'dorei Band of Dominance", "=ds=#s13#" },
		{ 35283, "", "=q4=Sin'dorei Band of Salvation", "=ds=#s13#" },
		{ 35284, "", "=q4=Sin'dorei Band of Triumph", "=ds=#s13#" },
		{ 34427, "", "=q4=Blackened Naaru Sliver", "=ds=#s14#" },
		{ 34430, "", "=q4=Glimmering Naaru Sliver", "=ds=#s14#" },
		{ 34429, "", "=q4=Shifting Naaru Sliver", "=ds=#s14#" },
		{ 34428, "", "=q4=Steely Naaru Sliver", "=ds=#s14#" },
		{ 34214, "", "=q4=Muramasa", "=ds=#h1#, #w10#" },
		{ 34231, "", "=q4=Aegis of Angelic Fortune", "=ds=#w8#" },
	};

	SPKiljaeden = {
		{ 34241, "", "=q4=Cloak of Unforgivable Sin", "=ds=#s4#" },
		{ 34242, "", "=q4=Tattered Cape of Antonidas", "=ds=#s4#" },
		{ 34339, "", "=q4=Cowl of Light's Purity", "=ds=#s1#, #a1#" },
		{ 34405, "", "=q4=Helm of Arcane Purity", "=ds=#m29#" },
		{ 34340, "", "=q4=Dark Conjuror's Collar", "=ds=#s1#, #a1#" },
		{ 34342, "", "=q4=Handguards of the Dawn", "=ds=#s9#, #a1#" },
		{ 34406, "", "=q4=Gloves of Tyri's Power", "=ds=#m29#" },
		{ 34344, "", "=q4=Handguards of the Defiled Worlds", "=ds=#s9#, #a1#" },
		{ 34244, "", "=q4=Duplicitous Guise", "=ds=#s1#, #a2#" },
		{ 34404, "", "=q4=Mask of the Furry Hunter", "=ds=#m29#" },
		{ 34245, "", "=q4=Cover of Ursol the Wise", "=ds=#s1#, #a2#" },
		{ 34403, "", "=q4=Cover of Ursoc the Mighty", "=ds=#m29#" },
		{ 34333, "", "=q4=Coif of Alleria", "=ds=#s1#, #a3#" },
		{ 34332, "", "=q4=Cowl of Gul'dan", "=ds=#s1#, #a3#" },
		{ 34402, "", "=q4=Shroud of Chieftain Ner'zhul", "=ds=#m29#" },
		{ 34343, "", "=q4=Thalassian Ranger Gauntlets", "=ds=#s9#, #a3#" },
		{ 34243, "", "=q4=Helm of Burning Righteousness", "=ds=#s1#, #a4#" },
		{ 34401, "", "=q4=Helm of Uther's Resolve", "=ds=#m29#" },
		{ 34345, "", "=q4=Crown of Anasterian", "=ds=#s1#, #a4#" },
		{ 34400, "", "=q4=Crown of Dath'Remar", "=ds=#m29#" },
		{ 34341, "", "=q4=Borderland Paingrips", "=ds=#s9#, #a4#" },
		{ 0,"","","" },
		{ 34334, "", "=q5=Thori'dal, the Stars' Fury", "=ds=#w2#" },
		{ 0,"","","" },
		{ 34329, "", "=q4=Crux of the Apocalypse", "=ds=#h1#, #w4#" },
		{ 34247, "", "=q4=Apolyon, the Soul-Render", "=ds=#h2#, #w10#" },
		{ 34335, "", "=q4=Hammer of Sanctification", "=ds=#h3#, #w6#" },
		{ 34331, "", "=q4=Hand of the Deceiver", "=ds=#h3#, #w13#" },
		{ 34336, "", "=q4=Sunflare", "=ds=#h3#, #w4#" },
		{ 34337, "", "=q4=Golden Staff of the Sin'dorei", "=ds=#w9#" },
	};

	SPTrash = {
		{ 34351, "", "=q4=Tranquil Majesty Wraps", "=ds=#s9#, #a2#" },
		{ 34407, "", "=q4=Tranquil Moonlight Wraps", "=ds=#m29#" },
		{ 34350, "", "=q4=Gauntlets of the Ancient Shadowmoon", "=ds=#s9#, #a3#" },
		{ 34409, "", "=q4=Gauntlets of the Ancient Frostwolf", "=ds=#m29#" },
		{ 35733, "", "=q4=Ring of Harmonic Beauty", "=ds=#s13#" },
		{ 34183, "", "=q4=Shivering Felspine", "=ds=#h2#, #w7#" },
		{ 34346, "", "=q4=Mounting Vengeance", "=ds=#h4#, #w13#" },
		{ 34349, "", "=q4=Blade of Life's Inevitability", "=ds=#w11#" },
		{ 34348, "", "=q4=Wand of Cleansing Light", "=ds=#w12#" },
		{ 34347, "", "=q4=Wand of the Demonsoul", "=ds=#w12#" },
		{ 0,"","","" },
		{ 35273, "", "=q3=Study of Advanced Smelting", "=ds=#p23# (375)" },
		{ 0,"","","" },
		{ 34664, "", "=q3=Sunmote", "=ds=#m20#" },
		{ 0,"","","" },
		{ 32228, "", "=q4=Empyrean Sapphire", "=ds=#e7#" },
		{ 32231, "", "=q4=Pyrestone", "=ds=#e7#" },
		{ 32229, "", "=q4=Lionseye", "=ds=#e7#" },
		{ 32249, "", "=q4=Seaspray Emerald", "=ds=#e7#" },
		{ 32230, "", "=q4=Shadowsong Amethyst", "=ds=#e7#" },
		{ 32227, "", "=q4=Crimson Spinel", "=ds=#e7#" },
	};

	SPPatterns = {
		{ 35212, "", "=q4=Pattern: Leather Gauntlets of the Sun", "=ds=#p7# (365)" },
		{ 35216, "", "=q4=Pattern: Leather Chestguard of the Sun", "=ds=#p7# (365)" },
		{ 35213, "", "=q4=Pattern: Fletcher's Gloves of the Phoenix", "=ds=#p7# (365)" },
		{ 35217, "", "=q4=Pattern: Pattern: Embrace of the Phoenix", "=ds=#p7# (365)" },
		{ 35214, "", "=q4=Pattern: Gloves of Immortal Dusk", "=ds=#p7# (365)" },
		{ 35218, "", "=q4=Pattern: Carapace of Sun and Shadow", "=ds=#p7# (365)" },
		{ 35215, "", "=q4=Pattern: Sun-Drenched Scale Gloves", "=ds=#p7# (365)" },
		{ 35219, "", "=q4=Pattern: Sun-Drenched Scale Chestguard", "=ds=#p7# (365)" },
		{ 35204, "", "=q4=Pattern: Sunfire Handwraps", "=ds=#p8# (365)" },
		{ 35206, "", "=q4=Pattern: Sunfire Robe", "=ds=#p8# (365)" },
		{ 35205, "", "=q4=Pattern: Hands of Eternal Light", "=ds=#p8# (365)" },
		{ 35207, "", "=q4=Pattern: Robe of Eternal Light", "=ds=#p8# (365)" },
		{ 35198, "", "=q4=Design: Loop of Forged Power", "=ds=#p12# (365)" },
		{ 35201, "", "=q4=Design: Pendant of Sunfire", "=ds=#p12# (365)" },
		{ 35199, "", "=q4=Design: Ring of Flowing Life", "=ds=#p12# (365)" },
		{ 35202, "", "=q4=Design: Amulet of Flowing Life", "=ds=#p12# (365)" },
		{ 35200, "", "=q4=Design: Hard Khorium Band", "=ds=#p12# (365)" },
		{ 35203, "", "=q4=Design: Hard Khorium Choker", "=ds=#p12# (365)" },
		{ 35186, "", "=q4=Schematic: Annihilator Holo-Gogs", "=ds=#p5# (375)" },
		{ 35187, "", "=q4=Schematic: Justicebringer 3000 Specs", "=ds=#p5# (375)" },
		{ 35189, "", "=q4=Schematic: Powerheal 9000 Lens", "=ds=#p5# (375)" },
		{ 35190, "", "=q4=Schematic: Hyper-Magnified Moon Specs", "=ds=#p5# (375)" },
		{ 35191, "", "=q4=Schematic: Wonderheal XT68 Shades", "=ds=#p5# (375)" },
		{ 35192, "", "=q4=Schematic: Primal-Attuned Goggles", "=ds=#p5# (375)" },
		{ 35193, "", "=q4=Schematic: Lightning Etched Specs", "=ds=#p5# (375)" },
		{ 35194, "", "=q4=Schematic: Surestrike Goggles v3.0", "=ds=#p5# (375)" },
		{ 35195, "", "=q4=Schematic: Mayhem Projection Goggles", "=ds=#p5# (375)" },
		{ 35196, "", "=q4=Schematic: Hard Khorium Goggles", "=ds=#p5# (375)" },
		{ 35197, "", "=q4=Schematic: Quad Deathblow X44 Goggles", "=ds=#p5# (375)" },
	};
};