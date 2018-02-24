--[[
sets.lua
The loot tables for all item sets and collections is defined here.
]]

AtlasLoot_Data["AtlasLootSetItems"] = {
	EmptyInstance = {};

-------------------------
--- Vanilla WoW Sets ---
-------------------------

	VWOWDeadmines = {
		{ 0, "INV_Box_01", "=q6=#pre60s1#", "=ec1=#a2#. =q1=#z1#" },
		{ 10399, "", "=q3=Blackened Defias Armor", "=ds=#s5#, =q2=#n6#", "14.77%" },
		{ 10401, "", "=q2=Blackened Defias Gloves", "=ds=#s9#, =q2=#n9#", "1.76%" },
		{ 10403, "", "=q3=Blackened Defias Belt", "=ds=#s10#, =q2=#n7#", "23.26%" },
		{ 10400, "", "=q2=Blackened Defias Leggings", "=ds=#s11#, =q2=#n9#", "1.64%" },
		{ 10402, "", "=q2=Blackened Defias Boots", "=ds=#s12#, =q2=#n8#", "1.23%" },
	}; 

	VWOWWailingC = {
		{ 0, "INV_Box_01", "=q6=#pre60s2#", "=ec1=#a2#. =q1=#z2#" },
		{ 6473, "", "=q3=Armor of the Fang", "=ds=#s5#, =q2=#n5#", "52.05%" },
		{ 10413, "", "=q3=Gloves of the Fang", "=ds=#s9#, =q2=#n4#", "1.20%" },
		{ 10412, "", "=q3=Belt of the Fang", "=ds=#s10#, =q2=#n2#", "8.64%" },
		{ 10410, "", "=q3=Leggings of the Fang", "=ds=#s11#, =q2=#n1#", "16.03%" },
		{ 10411, "", "=q3=Footpads of the Fang", "=ds=#s12#, =q2=#n3#", "19.08%" },
	}; 

	VWOWScarletM = {
		{ 0, "INV_Box_01", "=q6=#pre60s3#", "=ec1=#a3#. =q1=#z3#" },
		{ 10328, "", "=q3=Scarlet Chestpiece", "=ds=#s5#, =q2=#n12#", "0.3%"},
		{ 10333, "", "=q2=Scarlet Wristguards", "=ds=#s8#, =q2=#n15#", "1.6%"},
		{ 10331, "", "=q2=Scarlet Gauntlets", "=ds=#s9#, =q2=#n13#", "1.7%" },
		{ 10329, "", "=q2=Scarlet Belt", "=ds=#s10#, =q2=#n10#", "1.6%"},
		{ 10330, "", "=q3=Scarlet Leggings", "=ds=#s11#, =q2=#n14#", "13.2%"},
		{ 10332, "", "=q3=Scarlet Boots", "=ds=#s12#, =q2=#n11#", "0.1%"},
	};

	VWOWBlackrockD = {
		{ 0, "INV_Box_01", "=q6=#pre60s4#", "=ec1=#a3#. =q1=#z4#" },
		{ 11729, "", "=q3=Savage Gladiator Helm", "=ds=#s1#, =q2=#brd3#, #brd5#", "10.08%" },
		{ 11726, "", "=q4=Savage Gladiator Chain", "=ds=#s5#, =q2=#brd3#", "14.52%" },
		{ 11730, "", "=q3=Savage Gladiator Grips", "=ds=#s9#, =q2=#brd2#", "14.12%"},
		{ 11728, "", "=q3=Savage Gladiator Leggings", "=ds=#s11#, =q2=#brd6#", "14.95%" },
		{ 11731, "", "=q3=Savage Gladiator Greaves", "=ds=#s12#, =q2=#brd1#", "15.14%" },
	};

	VWOWIronweave = {
		{ 0, "INV_Box_01", "=q6=#pre60s5#", "=ec1=#a1#, =q1=#m1# #c5#, #c3#, #c8#" },
		{ 22302, "", "=q3=Ironweave Cowl", "=ds=#s1#, =q2=#n16# (#z9#)", "27.72%" },
		{ 22305, "", "=q3=Ironweave Mantle", "=ds=#s3#, =q2=#n17# (#z4#)", "30.39%" },
		{ 22301, "", "=q3=Ironweave Robe", "=ds=#s5#, =q2=#n18# (#z6#)", "19.00%" },
		{ 22313, "", "=q3=Ironweave Bracers", "=ds=#s8#, =q2=#n19# (#z10#)", "18.16%" },
		{ 22304, "", "=q3=Ironweave Gloves", "=ds=#s9#, =q2=#n20# (#z13#)", "16.24%" },
		{ 22306, "", "=q3=Ironweave Belt", "=ds=#s10#, =q2=#n21# (#z10#)", "20.28%" }, 
		{ 22303, "", "=q3=Ironweave Pants", "=ds=#s11#, =q2=#n22# (#z5#)", "23.33%" },
		{ 22311, "","=q3=Ironweave Boots", "=ds=#s12#, =q2=#n23# (#z9#)", "12.31%" },
	};
	
	VWOWScholo = {
		{ 0, "INV_Box_01", "=q6=#pre60s6#", "=ec1=#a1#. =q1=#z5#" },
		{ 14633, "", "=q3=Necropile Mantle", "=ds=#s3#", "1.12%" },
		{ 14626, "", "=q3=Necropile Robe", "=ds=#s5#", "1.27%" },
		{ 14629, "", "=q3=Necropile Cuffs", "=ds=#s8#", "1.03%" },
		{ 14632, "", "=q3=Necropile Leggings", "=ds=#s11#", "0.85%" },
		{ 14631, "", "=q3=Necropile Boots", "=ds=#s12#", "0.88%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s7#", "=ec1=#a2#. =q1=#z5#" },
		{ 14637, "", "=q3=Cadaverous Armor", "=ds=#s5#", "1.51%" },
		{ 14640, "", "=q3=Cadaverous Gloves", "=ds=#s9#", "0.82%" },
		{ 14636, "", "=q3=Cadaverous Belt", "=ds=#s10#", "0.60%" },
		{ 14638, "", "=q3=Cadaverous Leggings", "=ds=#s11#", "1.09%" },
		{ 14641, "", "=q3=Cadaverous Walkers", "=ds=#s12#", "0.67%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s8#", "=ec1=#a3#. =q1=#z5#" },
		{ 14611, "", "=q3=Bloodmail Hauberk", "=ds=#s5#", "0.54%" },
		{ 14615, "", "=q3=Bloodmail Gauntlets", "=ds=#s9#", "0.09%" },
		{ 14614, "", "=q3=Bloodmail Belt", "=ds=#s10#", "0.60%" },
		{ 14612, "", "=q3=Bloodmail Legguards", "=ds=#s11#", "0.42%" },
		{ 14616, "", "=q3=Bloodmail Boots", "=ds=#s12#", "0.36%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s9#", "=ec1=#a4#. =q1=#z5#" },
		{ 14624, "", "=q3=Deathbone Chestplate", "=ds=#s5#", "0.45%" },
		{ 14622, "", "=q3=Deathbone Gauntlets", "=ds=#s9#", "0.45%" },
		{ 14620, "", "=q3=Deathbone Girdle", "=ds=#s10#", "0.67%" },
		{ 14623, "", "=q3=Deathbone Legguards", "=ds=#s11#", "1.12%" },
		{ 14621, "", "=q3=Deathbone Sabatons", "=ds=#s12#", "0.57%" },
	};

	VWOWStrat = {
		{ 0, "INV_Box_01", "=q6=#pre60s10#", "=ec1=#a1#, =q2=#n24#. =q1=#z6#" },
		{ 13390, "", "=q3=The Postmaster's Band", "=ds=#s1#", "" },
		{ 13388, "", "=q3=The Postmaster's Tunic", "=ds=#s5#", "" },
		{ 13389, "", "=q3=The Postmaster's Trousers", "=ds=#s11#", "" },
		{ 13391, "", "=q3=The Postmaster's Treads", "=ds=#s12#", "" },
		{ 13392, "", "=q3=The Postmaster's Seal", "=ds=#s13#", "" },
	};

	VWOWScourgeInvasion = {
		{ 0, "INV_Jewelry_Talisman_13", "=q6=#pre60s11#", "=ec1=#a1#" },
		{ 23085, "", "=q3=Robe of Undead Cleansing", "=ds=#s5#, =q2=#n25#", "" },
		{ 23091, "", "=q3=Bracers of Undead Cleansing", "=ds=#s8#, =q2=#n26#, #n27#", "" },
		{ 23084, "", "=q3=Gloves of Undead Cleansing", "=ds=#s9#, =q2=#m4#", "" },
		{ 0,"","","" },
		{ 0, "INV_Jewelry_Talisman_13", "=q6=#pre60s12#", "=ec1=#a2#" },
		{ 23089, "", "=q3=Tunic of Undead Slaying", "=ds=#s5#, =q2=#n25#", "" },
		{ 23093, "", "=q3=Wristwraps of Undead Slaying", "=ds=#s8#, =q2=#n26#, #n27#", "" },
		{ 23081, "", "=q3=Handwraps of Undead Slaying", "=ds=#s9#, =q2=#m4#", "" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Jewelry_Talisman_13", "=q6=#pre60s13#", "=ec1=#a3#" },
		{ 23088, "", "=q3=Chestguard of Undead Slaying", "=ds=#s5#, =q2=#n25#", "" },
		{ 23092, "", "=q3=Wristguards of Undead Slaying", "=ds=#s8#, =q2=#n26#, #n27#", "" },
		{ 23082, "", "=q3=Handguards of Undead Slaying", "=ds=#s9#, =q2=#m4#", "" },
		{ 0,"","","" },
		{ 0, "INV_Jewelry_Talisman_13", "=q6=#pre60s14#", "=ec1=#a4#" },
		{ 23087, "", "=q3=Breastplate of Undead Slaying", "=ds=#s5#, =q2=#n25#", "" },
		{ 23090, "", "=q3=Bracers of Undead Slaying", "=ds=#s8#, =q2=#n26#, #n27#", "" },
		{ 23078, "", "=q3=Gauntlets of Undead Slaying", "=ds=#s9#, =q2=#m4#", "" },
	};

	VWOWSpiderKiss = {
		{ 0, "INV_Box_01", "=q6=#pre60s24#", "=q1=#z10#" },
		{ 13218, "", "=q3=Fang of the Crystal Spider", "=ds=#h1#, #w4#, =q2=#n41#", "15.46%" },
		{ 13183, "", "=q3=Venomspitter", "=ds=#h1#, #w6#, =q2=#n42#", "13.07%" },
	};

	VWOWDalRend = {
		{ 0, "INV_Box_01", "=q6=#pre60s23#", "=q1=#z9#" },
		{ 12940, "", "=q3=Dal'Rend's Sacred Charge", "=ds=#h3#, #w10#, =q2=#n40#", "6.62%" },
		{ 12939, "", "=q3=Dal'Rend's Tribal Guardian", "=ds=#h4#, #w10#, =q2=#n40#", "7.44%" },
	};

	VWOWZulGurub = {
		{ 0, "INV_Box_01", "=q6=#pre60s16#", "=q1=#z8#" },
		{ 19898, "", "=q3=Seal of Jin", "=ds=#s13#, =q2=#n28#", "8.81%" },
		{ 19925, "", "=q3=Band of Jin", "=ds=#s13#, =q2=#n29#", "10.36%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s17#", "=q1=#z8#" },
		{ 19873, "", "=q3=Overlord's Crimson Band", "=ds=#s13#, =q2=#n33#", "10.12%" },
		{ 19912, "", "=q3=Overlord's Onyx Band", "=ds=#s13#, =q2=#n30#", "14.51%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s22#", "=q1=#z8#" },
		{ 19896, "", "=q4=Thekal's Grasp", "=ds=#h3#, #w13#, =q2=#n28#", "5.20%" },
		{ 19910, "", "=q4=Arlokk's Grasp", "=ds=#h4#, #w13#, =q2=#n30#", "4.54%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s18#", "=q1=#z8#" },
		{ 19863, "", "=q3=Primalist's Seal", "=ds=#s13#, =q2=#n33#", "9.72%" },
		{ 19920, "", "=q3=Primalist's Band", "=ds=#s13#, =q2=#n31#", "8.95%" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#pre60s19#", "=q1=#z8#" },
		{ 19905, "", "=q3=Zanzil's Band", "=ds=#s13#, =q2=#n32#", "9.24%" },
		{ 19893, "", "=q3=Zanzil's Seal", "=ds=#s13#, =q2=#n33#", "10.12%" },
		{ 0,"","","" },		
		{ 0, "INV_Box_01", "=q6=#pre60s21#", "=q1=#z8#" },
		{ 19865, "", "=q4=Warblade of the Hakkari", "=ds=#h3#, #w10#, =q2=#n34#", "5.18%" },
		{ 19866, "", "=q4=Warblade of the Hakkari", "=ds=#h4#, #w10#, =q2=#n33#", "4.55%" },
	};

	VWOWShardOfGods = {
		{ 0, "INV_Box_01", "=q6=#pre60s15#", "=q1=#z7#" },
		{ 17082, "", "=q4=Shard of the Flame", "=ds=#s14#, =q2=#n35# (#z14#)", "4.46%" },
		{ 17064, "", "=q4=Shard of the Scale", "=ds=#s14#, =q2=#n36# (#z15#)", "3.71%" },
	};

	VWOWSpiritofEskhandar = {
		{ 0, "INV_Box_01", "=q6=#pre60s20#", "=q1=#z7#" },
		{ 18204, "", "=q4=Eskhandar's Pelt", "=ds=#s4#, =q2=#n37#", "9.16%" },
		{ 18205, "", "=q4=Eskhandar's Collar", "=ds=#s2#, =q2=#n36# (#z15#)", "14.29% " },
		{ 18203, "", "=q4=Eskhandar's Right Claw", "=ds=#h3#, #w13#, =q2=#n38# (#z14#)", "16.97%" },
		{ 18202, "", "=q4=Eskhandar's Left Claw", "=ds=#h4#, #w13#, =q2=#n39#", "12.36%" },
	};

--------------------------------
--- The Burning Crusade Sets ---
--------------------------------

	TBCSets = {
		{ 0, "INV_Box_01", "=q6=#bcs1#", "=q1=#z17#" },
		{ 31338, "", "=q4=Charlotte's Ivy", "=ds=#s2#", "0.01%" },
		{ 31339, "", "=q4=Lola's Eve", "=ds=#s13#", "0.01%" },
	};

------------------------
--- Tier 6 Sets (T6) ---
------------------------

	T6Druid = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#t6s1_1#", "" },
		{ 31039, "", "=q4=Thunderheart Cover", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31048, "", "=q4=Thunderheart Pauldrons", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31042, "", "=q4=Thunderheart Chestguard", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34444, "", "=q4=Thunderheart Wristguards", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31034, "", "=q4=Thunderheart Gauntlets", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34556, "", "=q4=Thunderheart Waistguard", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31044, "", "=q4=Thunderheart Leggings", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34573, "", "=q4=Thunderheart Treads", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Nature_Regeneration", "=q6=#t6s1_2#", "" },
		{ 31037, "", "=q4=Thunderheart Helmet", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31047, "", "=q4=Thunderheart Spaulders", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31041, "", "=q4=Thunderheart Tunic", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34445, "", "=q4=Thunderheart Bracers", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31032, "", "=q4=Thunderheart Gloves", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34554, "", "=q4=Thunderheart Belt", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31045, "", "=q4=Thunderheart Legguards", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34571, "", "=q4=Thunderheart Boots", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Druid2 = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#t6s1_3#", "" },
		{ 31040, "", "=q4=Thunderheart Headguard", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31049, "", "=q4=Thunderheart Shoulderpads", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31043, "", "=q4=Thunderheart Vest", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34446, "", "=q4=Thunderheart Bands", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31035, "", "=q4=Thunderheart Handguards", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34555, "", "=q4=Thunderheart Cord", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31046, "", "=q4=Thunderheart Pants", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34572, "", "=q4=Thunderheart Footwraps", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Hunter = {
		{ 0, "Ability_Hunter_RunningShot", "=q6=#t6s2#", "" },
		{ 31003, "", "=q4=Gronnstalker's Helmet", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31006, "", "=q4=Gronnstalker's Spaulders", "=ds="..AtlasLootBossNames["BlackTemple"][1] }, 
		{ 31004, "", "=q4=Gronnstalker's Chestguard", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34443, "", "=q4=Gronnstalker's Bracers", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31001, "", "=q4=Gronnstalker's Gloves", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34549, "", "=q4=Gronnstalker's Belt", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31005, "", "=q4=Gronnstalker's Leggings", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34570, "", "=q4=Gronnstalker's Boots", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Mage = {
		{ 0, "Spell_Frost_IceStorm", "=q6=#t6s3#", "" },
		{ 31056, "", "=q4=Cowl of the Tempest", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31059, "", "=q4=Mantle of the Tempest", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31057, "", "=q4=Robes of the Tempest", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34447, "", "=q4=Bracers of the Tempest", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31055, "", "=q4=Gloves of the Tempest", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34557, "", "=q4=Belt of the Tempest", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31058, "", "=q4=Leggings of the Tempest", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34574, "", "=q4=Boots of the Tempest", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Paladin = {
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t6s4_1#", "" },
		{ 30987, "", "=q4=Lightbringer Faceguard", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 30998, "", "=q4=Lightbringer Shoulderguards", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 30991, "", "=q4=Lightbringer Chestguard", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34433, "", "=q4=Lightbringer Wristguards", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 30985, "", "=q4=Lightbringer Handguards", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34488, "", "=q4=Lightbringer Waistguard", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 30995, "", "=q4=Lightbringer Legguards", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34560, "", "=q4=Lightbringer Greaves", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t6s4_2#", "" },
		{ 30989, "", "=q4=Lightbringer War-Helm", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 30997, "", "=q4=Lightbringer Shoulderbraces", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 30990, "", "=q4=Lightbringer Breastplate", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34431, "", "=q4=Lightbringer Bands", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 30982, "", "=q4=Lightbringer Gauntlets", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34485, "", "=q4=Lightbringer Girdle", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 30993, "", "=q4=Lightbringer Greaves", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34561, "", "=q4=Lightbringer Boots", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Paladin2 = {
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t6s4_3#", "" },
		{ 30988, "", "=q4=Lightbringer Greathelm", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 30996, "", "=q4=Lightbringer Pauldrons", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 30992, "", "=q4=Lightbringer Chestpiece", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34432, "", "=q4=Lightbringer Bracers", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 30983, "", "=q4=Lightbringer Gloves", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34487, "", "=q4=Lightbringer Belt", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 30994, "", "=q4=Lightbringer Leggings", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34559, "", "=q4=Lightbringer Treads", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Priest = {
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#t6s5_1#", "" },
		{ 31063, "", "=q4=Cowl of Absolution", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31069, "", "=q4=Mantle of Absolution", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31066, "", "=q4=Vestments of Absolution", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34435, "", "=q4=Cuffs of Absolution", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31060, "", "=q4=Gloves of Absolution", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34527, "", "=q4=Belt of Absolution", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31068, "", "=q4=Breeches of Absolution", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34562, "", "=q4=Boots of Absolution", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#t6s5_2#", "" },
		{ 31064, "", "=q4=Hood of Absolution", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31070, "", "=q4=Shoulderpads of Absolution", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31065, "", "=q4=Shroud of Absolution", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34434, "", "=q4=Bracers of Absolution", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31061, "", "=q4=Handguards of Absolution", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34528, "", "=q4=Cord of Absolution", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31067, "", "=q4=Leggings of Absolution", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34563, "", "=q4=Treads of Absolution", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Rogue = {
		{ 0, "Ability_BackStab", "=q6=#t6s6#", "" },
		{ 31027, "", "=q4=Slayer's Helm", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31030, "", "=q4=Slayer's Shoulderpads", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31028, "", "=q4=Slayer's Chestguard", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34448, "", "=q4=Slayer's Bracers", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31026, "", "=q4=Slayer's Handguards", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34558, "", "=q4=Slayer's Belt", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31029, "", "=q4=Slayer's Legguards", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34575, "", "=q4=Slayer's Boots", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Shaman = {
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t6s7_1#", "" },
		{ 31015, "", "=q4=Skyshatter Cover", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31024, "", "=q4=Skyshatter Pauldrons", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31018, "", "=q4=Skyshatter Tunic", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34439, "", "=q4=Skyshatter Wristguards", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31011, "", "=q4=Skyshatter Grips", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34545, "", "=q4=Skyshatter Girdle", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31021, "", "=q4=Skyshatter Pants", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34567, "", "=q4=Skyshatter Greaves", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t6s7_2#", "" },
		{ 31012, "", "=q4=Skyshatter Helmet", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31022, "", "=q4=Skyshatter Shoulderpads", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31016, "", "=q4=Skyshatter Chestguard", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34438, "", "=q4=Skyshatter Bracers", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31007, "", "=q4=Skyshatter Gloves", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34543, "", "=q4=Skyshatter Belt", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31019, "", "=q4=Skyshatter Leggings", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34565, "", "=q4=Skyshatter Boots", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Shaman2 = {
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t6s7_3#", "" },
		{ 31014, "", "=q4=Skyshatter Headguard", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31023, "", "=q4=Skyshatter Mantle", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31017, "", "=q4=Skyshatter Breastplate", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34437, "", "=q4=Skyshatter Bands", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31008, "", "=q4=Skyshatter Gauntlets", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34542, "", "=q4=Skyshatter Cord", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31020, "", "=q4=Skyshatter Legguards", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34566, "", "=q4=Skyshatter Treads", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Warlock = {
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#t6s8#", "" },
		{ 31051, "", "=q4=Hood of the Malefic", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 31054, "", "=q4=Mantle of the Malefic", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 31052, "", "=q4=Robe of the Malefic", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34436, "", "=q4=Bracers of the Malefic", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 31050, "", "=q4=Gloves of the Malefic", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34541, "", "=q4=Belt of the Malefic", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 31053, "", "=q4=Leggings of the Malefic", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34564, "", "=q4=Boots of the Malefic", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

	T6Warrior = {
		{ 0, "INV_Shield_05", "=q6=#t6s9_1#", "" },
		{ 30974, "", "=q4=Onslaught Greathelm", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 30980, "", "=q4=Onslaught Shoulderguards", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 30976, "", "=q4=Onslaught Chestguard", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34442, "", "=q4=Onslaught Wristguards", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 30970, "", "=q4=Onslaught Handguards", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34547, "", "=q4=Onslaught Waistguard", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 30978, "", "=q4=Onslaught Legguards", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34568, "", "=q4=Onslaught Boots", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"INV_Shield_05","=q6=#t6s9_2#","" },
		{ 30972, "", "=q4=Onslaught Battle-Helm", "=ds="..AtlasLootBossNames["CoTMountHyjal"][2] },
		{ 30979, "", "=q4=Onslaught Shoulderblades", "=ds="..AtlasLootBossNames["BlackTemple"][1] },
		{ 30975, "", "=q4=Onslaught Breastplate", "=ds="..AtlasLootBossNames["BlackTemple"][3] },
		{ 34441, "", "=q4=Onslaught Bracers", "=ds="..AtlasLootBossNames["SunwellPlateau"][1] },
		{ 30969, "", "=q4=Onslaught Gauntlets", "=ds="..AtlasLootBossNames["CoTMountHyjal"][1] },
		{ 34546, "", "=q4=Onslaught Belt", "=ds="..AtlasLootBossNames["SunwellPlateau"][2] },
		{ 30977, "", "=q4=Onslaught Greaves", "=ds="..AtlasLootBossNames["BlackTemple"][2] },
		{ 34569, "", "=q4=Onslaught Treads", "=ds="..AtlasLootBossNames["SunwellPlateau"][3] },
	};

------------------------
--- Tier 5 Sets (T5) ---
------------------------

	T5Druid = {
		{ 0,"Spell_Nature_Regeneration","=q6=#t5s1_1#","" },
		{ 30228, "", "=q4=Nordrassil Headdress", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30230, "", "=q4=Nordrassil Feral-Mantle", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30222, "", "=q4=Nordrassil Chestplate", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30223, "", "=q4=Nordrassil Handgrips", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30229, "", "=q4=Nordrassil Feral-Kilt", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"Spell_Nature_Regeneration","=q6=#t5s1_2#","" },
		{ 30219, "", "=q4=Nordrassil Headguard", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30221, "", "=q4=Nordrassil Life-Mantle", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30216, "", "=q4=Nordrassil Chestguard", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30217, "", "=q4=Nordrassil Gloves", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30220, "", "=q4=Nordrassil Life-Kilt", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"Spell_Nature_Regeneration","=q6=#t5s1_3#","" },
		{ 30233, "", "=q4=Nordrassil Headpiece", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30235, "", "=q4=Nordrassil Wrath-Mantle", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30231, "", "=q4=Nordrassil Chestpiece", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30232, "", "=q4=Nordrassil Gauntlets", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30234, "", "=q4=Nordrassil Wrath-Kilt", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Hunter = {
		{ 0,"Ability_Hunter_RunningShot","=q6=#t5s2#","" },
		{ 30141, "", "=q4=Rift Stalker Helm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30143, "", "=q4=Rift Stalker Mantle", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30139, "", "=q4=Rift Stalker Hauberk", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30140, "", "=q4=Rift Stalker Gauntlets", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30142, "", "=q4=Rift Stalker Leggings", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Mage = {
		{ 0,"Spell_Frost_IceStorm","=q6=#t5s3#","" },
		{ 30206, "", "=q4=Cowl of Tirisfal", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30210, "", "=q4=Mantle of Tirisfal", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30196, "", "=q4=Robes of Tirisfal", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30205, "", "=q4=Gloves of Tirisfal", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30207, "", "=q4=Leggings of Tirisfal", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Paladin = {
		{ 0,"Spell_Holy_SealOfMight","=q6=#t5s4_1#","" },
		{ 30125, "", "=q4=Crystalforge Faceguard", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30127, "", "=q4=Crystalforge Shoulderguards", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30123, "", "=q4=Crystalforge Chestguard", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30124, "", "=q4=Crystalforge Handguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30126, "", "=q4=Crystalforge Legguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"Spell_Holy_SealOfMight","=q6=#t5s4_2#","" },
		{ 30131, "", "=q4=Crystalforge War-Helm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30133, "", "=q4=Crystalforge Shoulderbraces", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30129, "", "=q4=Crystalforge Breastplate", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30130, "", "=q4=Crystalforge Gauntlets", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30132, "", "=q4=Crystalforge Greaves", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"Spell_Holy_SealOfMight","=q6=#t5s4_3#","" },
		{ 30136, "", "=q4=Crystalforge Greathelm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30138, "", "=q4=Crystalforge Pauldrons", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30134, "", "=q4=Crystalforge Chestpiece", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30135, "", "=q4=Crystalforge Gloves", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30137, "", "=q4=Crystalforge Leggings", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Priest = {
		{ 0,"Spell_Holy_PowerWordShield","=q6=#t5s5_1#","" },
		{ 30152, "", "=q4=Cowl of the Avatar", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30154, "", "=q4=Mantle of the Avatar", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30150, "", "=q4=Vestments of the Avatar", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30151, "", "=q4=Gloves of the Avatar", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30153, "", "=q4=Breeches of the Avatar", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"Spell_Holy_PowerWordShield","=q6=#t5s5_2#","" },
		{ 30161, "", "=q4=Hood of the Avatar", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30163, "", "=q4=Wings of the Avatar", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30159, "", "=q4=Shroud of the Avatar", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30160, "", "=q4=Handguards of the Avatar", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30162, "", "=q4=Leggings of the Avatar", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Rogue = {
		{ 0,"Ability_BackStab","=q6=#t5s6#","" },
		{ 30146, "", "=q4=Deathmantle Helm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30149, "", "=q4=Deathmantle Shoulderpads", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30144, "", "=q4=Deathmantle Chestguard", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30145, "", "=q4=Deathmantle Handguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30148, "", "=q4=Deathmantle Legguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Shaman = {
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t5s7_1#","" },
		{ 30190, "", "=q4=Cataclysm Helm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30194, "", "=q4=Cataclysm Shoulderplates", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30185, "", "=q4=Cataclysm Chestplate", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30189, "", "=q4=Cataclysm Gauntlets", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30192, "", "=q4=Cataclysm Legplates", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t5s7_2#","" },
		{ 30166, "", "=q4=Cataclysm Headguard", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30168, "", "=q4=Cataclysm Shoulderguards", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30164, "", "=q4=Cataclysm Chestguard", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30165, "", "=q4=Cataclysm Gloves", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30167, "", "=q4=Cataclysm Legguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t5s7_3#","" },
		{ 30171, "", "=q4=Cataclysm Headpiece", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30173, "", "=q4=Cataclysm Shoulderpads", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30169, "", "=q4=Cataclysm Chestpiece", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30170, "", "=q4=Cataclysm Handgrips", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30172, "", "=q4=Cataclysm Legguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Warlock = {
		{ 0,"Spell_Shadow_CurseOfTounges","=q6=#t5s8#","" },
		{ 30212, "", "=q4=Hood of the Corruptor", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30215, "", "=q4=Mantle of the Corruptor", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30214, "", "=q4=Robe of the Corruptor", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30211, "", "=q4=Gloves of the Corruptor", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30213, "", "=q4=Leggings of the Corruptor", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

	T5Warrior = {
		{ 0,"INV_Shield_05","=q6=#t5s9_1#","" },
		{ 30115, "", "=q4=Destroyer Greathelm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30117, "", "=q4=Destroyer Shoulderguards", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30113, "", "=q4=Destroyer Chestguard", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30114, "", "=q4=Destroyer Handguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30116, "", "=q4=Destroyer Legguards", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
		{ 0,"","","" },
		{ 0,"INV_Shield_05","=q6=#t5s9_2#","" },
		{ 30120, "", "=q4=Destroyer Battle-Helm", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][3] },
		{ 30122, "", "=q4=Destroyer Shoulderblades", "=ds="..AtlasLootBossNames["TKTheEye"][1] },
		{ 30118, "", "=q4=Destroyer Breastplate", "=ds="..AtlasLootBossNames["TKTheEye"][2] },
		{ 30119, "", "=q4=Destroyer Gauntlets", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][1] },
		{ 30121, "", "=q4=Destroyer Greaves", "=ds="..AtlasLootBossNames["CFRSerpentshrineCavern"][2] },
	};

------------------------
--- Tier 4 Sets (T4) ---
------------------------

	T4Druid = {
		{ 0,"Spell_Nature_Regeneration","=q6=#t4s1_1#","" },
		{ 29098, "", "=q4=Stag-Helm of Malorne", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29100, "", "=q4=Mantle of Malorne", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29096, "", "=q4=Breastplate of Malorne", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29097, "", "=q4=Gauntlets of Malorne", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29099, "", "=q4=Greaves of Malorne", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"Spell_Nature_Regeneration","=q6=#t4s1_2#","" },
		{ 29086, "", "=q4=Crown of Malorne", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29089, "", "=q4=Shoulderguards of Malorne", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29087, "", "=q4=Chestguard of Malorne", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29090, "", "=q4=Handguards of Malorne", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29088, "", "=q4=Legguards of Malorne", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"Spell_Nature_Regeneration","=q6=#t4s1_3#","" },
		{ 29093, "", "=q4=Antlers of Malorne", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29095, "", "=q4=Pauldrons of Malorne", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29091, "", "=q4=Chestpiece of Malorne", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29092, "", "=q4=Gloves of Malorne", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29094, "", "=q4=Britches of Malorne", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Hunter = {
		{ 0,"Ability_Hunter_RunningShot","=q6=#t4s2#","" },
		{ 29081, "", "=q4=Demon Stalker Greathelm", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29084, "", "=q4=Demon Stalker Shoulderguards", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29082, "", "=q4=Demon Stalker Harness", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29085, "", "=q4=Demon Stalker Gauntlets", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29083, "", "=q4=Demon Stalker Greaves", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Mage = {
		{ 0,"Spell_Frost_IceStorm","=q6=#t4s3#","" },
		{ 29076, "", "=q4=Collar of the Aldor", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29079, "", "=q4=Pauldrons of the Aldor", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29077, "", "=q4=Vestments of the Aldor", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29080, "", "=q4=Gloves of the Aldor", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29078, "", "=q4=Legwraps of the Aldor", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Paladin = {
		{ 0,"Spell_Holy_SealOfMight","=q6=#t4s4_1#","" },
		{ 29068, "", "=q4=Justicar Faceguard", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29070, "", "=q4=Justicar Shoulderguards", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29066, "", "=q4=Justicar Chestguard", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29067, "", "=q4=Justicar Handguards", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29069, "", "=q4=Justicar Legguards", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"Spell_Holy_SealOfMight","=q6=#t4s4_2#","" },
		{ 29073, "", "=q4=Justicar Crown", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29075, "", "=q4=Justicar Shoulderplates", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29071, "", "=q4=Justicar Breastplate", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29072, "", "=q4=Justicar Gauntlets", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29074, "", "=q4=Justicar Greaves", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"Spell_Holy_SealOfMight","=q6=#t4s4_3#","" },
		{ 29061, "", "=q4=Justicar Diadem", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29064, "", "=q4=Justicar Pauldrons", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29062, "", "=q4=Justicar Chestpiece", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29065, "", "=q4=Justicar Gloves", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29063, "", "=q4=Justicar Leggings", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Priest = {
		{ 0,"Spell_Holy_PowerWordShield","=q6=#t4s5_1#","" },
		{ 29049, "", "=q4=Light-Collar of the Incarnate", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29054, "", "=q4=Light-Mantle of the Incarnate", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29050, "", "=q4=Robes of the Incarnate", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29055, "", "=q4=Handwraps of the Incarnate", AtlasLootBossNames["Karazhan"][1] },
		{ 29053, "", "=q4=Trousers of the Incarnate", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"Spell_Holy_PowerWordShield","=q6=#t4s5_2#","" },
		{ 29058, "", "=q4=Soul-Collar of the Incarnate", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29060, "", "=q4=Soul-Mantle of the Incarnate", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29056, "", "=q4=Shroud of the Incarnate", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29057, "", "=q4=Gloves of the Incarnate", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29059, "", "=q4=Leggings of the Incarnate", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Rogue = {
		{ 0,"Ability_BackStab","=q6=#t4s6#","" },
		{ 29044, "", "=q4=Netherblade Facemask", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29047, "", "=q4=Netherblade Shoulderpads", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29045, "", "=q4=Netherblade Chestpiece", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29048, "", "=q4=Netherblade Gloves", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29046, "", "=q4=Netherblade Breeches", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Shaman = {
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t4s7_1#","" },
		{ 29040, "", "=q4=Cyclone Helm", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29043, "", "=q4=Cyclone Shoulderplates", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29038, "", "=q4=Cyclone Breastplate", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29039, "", "=q4=Cyclone Gauntlets", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29042, "", "=q4=Cyclone War-Kilt", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t4s7_2#","" },
		{ 29028, "", "=q4=Cyclone Headdress", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29031, "", "=q4=Cyclone Shoulderpads", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29029, "", "=q4=Cyclone Hauberk", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29032, "", "=q4=Cyclone Gloves", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29030, "", "=q4=Cyclone Kilt", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t4s7_3#","" },
		{ 29035, "", "=q4=Cyclone Faceguard", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29037, "", "=q4=Cyclone Shoulderguards", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29033, "", "=q4=Cyclone Chestguard", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29034, "", "=q4=Cyclone Handguards", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29036, "", "=q4=Cyclone Legguards", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Warlock = {
		{ 0,"Spell_Shadow_CurseOfTounges","=q6=#t4s8#","" },
		{ 28963, "", "=q4=Voidheart Crown", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 28967, "", "=q4=Voidheart Mantle", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 28964, "", "=q4=Voidheart Robe", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 28968, "", "=q4=Voidheart Gloves", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 28966, "", "=q4=Voidheart Leggings", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

	T4Warrior = {
		{ 0,"INV_Shield_05","=q6=#t4s9_1#","" },
		{ 29011, "", "=q4=Warbringer Greathelm", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29016, "", "=q4=Warbringer Shoulderguards", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29012, "", "=q4=Warbringer Chestguard", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29017, "", "=q4=Warbringer Handguards", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29015, "", "=q4=Warbringer Legguards", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
		{ 0,"","","" },
		{ 0,"INV_Shield_05","=q6=#t4s9_2#","" },
		{ 29021, "", "=q4=Warbringer Battle-Helm", "=ds="..AtlasLootBossNames["Karazhan"][2] },
		{ 29023, "", "=q4=Warbringer Shoulderplates", "=ds="..AtlasLootBossNames["GruulsLair"][1] },
		{ 29019, "", "=q4=Warbringer Breastplate", "=ds="..AtlasLootBossNames["MagtheridonsLair"][1] },
		{ 29020, "", "=q4=Warbringer Gauntlets", "=ds="..AtlasLootBossNames["Karazhan"][1] },
		{ 29022, "", "=q4=Warbringer Greaves", "=ds="..AtlasLootBossNames["GruulsLair"][2] },
	};

------------------------
--- Tier 3 Sets (T3) ---
------------------------

	T3Druid = {
		{ 0,"Spell_Nature_Regeneration","=q6=#t3s1#","" },
		{ 22490, "", "=q4=Dreamwalker Headpiece", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22491, "", "=q4=Dreamwalker Spaulders", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22488, "", "=q4=Dreamwalker Tunic", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22495, "", "=q4=Dreamwalker Wristguards", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22493, "", "=q4=Dreamwalker Handguards", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22494, "", "=q4=Dreamwalker Girdle", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22489, "", "=q4=Dreamwalker Legguards", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22492, "", "=q4=Dreamwalker Boots", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23064, "", "=q4=Ring of the Dreamwalker", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Hunter = {
		{ 0,"Ability_Hunter_RunningShot","=q6=#t3s2#","" },
		{ 22438, "", "=q4=Cryptstalker Headpiece", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22439, "", "=q4=Cryptstalker Spaulders", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22436, "", "=q4=Cryptstalker Tunic", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22443, "", "=q4=Cryptstalker Wristguards", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22441, "", "=q4=Cryptstalker Handguards", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22442, "", "=q4=Cryptstalker Girdle", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22437, "", "=q4=Cryptstalker Legguards", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22440, "", "=q4=Cryptstalker Boots", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23067, "", "=q4=Ring of the Cryptstalker", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Mage = {
		{ 0,"Spell_Frost_IceStorm","=q6=#t3s3#", ""},
		{ 22498, "", "=q4=Frostfire Circlet", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22499, "", "=q4=Frostfire Shoulderpads", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22496, "", "=q4=Frostfire Robe", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22503, "", "=q4=Frostfire Bindings", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22501, "", "=q4=Frostfire Gloves", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22502, "", "=q4=Frostfire Belt", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22497, "", "=q4=Frostfire Leggings", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22500, "", "=q4=Frostfire Sandals", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9]  },
		{ 23062, "", "=q4=Frostfire Ring", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Paladin = {
		{ 0,"Spell_Holy_SealOfMight","=q6=#t3s4#","" },
		{ 22428, "", "=q4=Redemption Headpiece", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22429, "", "=q4=Redemption Spaulders", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22425, "", "=q4=Redemption Tunic", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22424, "", "=q4=Redemption Wristguards", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22426, "", "=q4=Redemption Handguards", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22431, "", "=q4=Redemption Girdle", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22427, "", "=q4=Redemption Legguards", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22430, "", "=q4=Redemption Boots", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23066, "", "=q4=Ring of Redemption", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Priest = {
		{ 0,"Spell_Holy_PowerWordShield","=q6=#t3s5#","" },
		{ 22514, "", "=q4=Circlet of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22515, "", "=q4=Shoulderpads of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22512, "", "=q4=Robe of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22519, "", "=q4=Bindings of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22517, "", "=q4=Gloves of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22518, "", "=q4=Belt of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22513, "", "=q4=Leggings of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22516, "", "=q4=Sandals of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23061, "", "=q4=Ring of Faith", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Rogue = {
		{ 0,"Ability_BackStab","=q6=#t3s6#","" },
		{ 22478, "", "=q4=Bonescythe Helmet", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22479, "", "=q4=Bonescythe Pauldrons", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22476, "", "=q4=Bonescythe Breastplate", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22483, "", "=q4=Bonescythe Bracers", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22481, "", "=q4=Bonescythe Gauntlets", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22482, "", "=q4=Bonescythe Waistguard", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22477, "", "=q4=Bonescythe Legplates", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22480, "", "=q4=Bonescythe Sabatons", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23060, "", "=q4=Bonescythe Ring", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Shaman = {
		{ 0,"Spell_FireResistanceTotem_01","=q6=#t3s7#","" },
		{ 22466, "", "=q4=Earthshatter Headpiece", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22467, "", "=q4=Earthshatter Spaulders", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22464, "", "=q4=Earthshatter Tunic", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22471, "", "=q4=Earthshatter Wristguards", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22469, "", "=q4=Earthshatter Handguards", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22470, "", "=q4=Earthshatter Girdle", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22465, "", "=q4=Earthshatter Legguards", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22468, "", "=q4=Earthshatter Boots", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23065, "", "=q4=Ring of the Earthshatterer", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Warlock = {
		{ 0,"Spell_Shadow_CurseOfTounges","=q6=#t3s8#","" },
		{ 22506, "", "=q4=Plagueheart Circlet", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22507, "", "=q4=Plagueheart Shoulderpads", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2]},
		{ 22504, "", "=q4=Plagueheart Robe", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22511, "", "=q4=Plagueheart Bindings", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22509, "", "=q4=Plagueheart Gloves", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22510, "", "=q4=Plagueheart Belt", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22505, "", "=q4=Plagueheart Leggings", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22508, "", "=q4=Plagueheart Sandals", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23063, "", "=q4=Plagueheart Ring", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

	T3Warrior = {
		{ 0, "INV_Shield_05", "=q6=#t3s9#", "" },
		{ 22418, "", "=q4=Dreadnaught Helmet", "=ds="..AtlasLootBossNames["Naxxramas"][4] },
		{ 22419, "", "=q4=Dreadnaught Pauldrons", "=ds="..AtlasLootBossNames["Naxxramas"][1]..", "..AtlasLootBossNames["Naxxramas"][2] },
		{ 22416, "", "=q4=Dreadnaught Breastplate", "=ds="..AtlasLootBossNames["Naxxramas"][10] },
		{ 22423, "", "=q4=Dreadnaught Bracers", "=ds="..AtlasLootBossNames["Naxxramas"][5]..", "..AtlasLootBossNames["Naxxramas"][6] },
		{ 22421, "", "=q4=Dreadnaught Gauntlets", "=ds="..AtlasLootBossNames["Naxxramas"][7] },
		{ 22422, "", "=q4=Dreadnaught Waistguard", "=ds="..AtlasLootBossNames["Naxxramas"][11]..", "..AtlasLootBossNames["Naxxramas"][12] },
		{ 22417, "", "=q4=Dreadnaught Legplates", "=ds="..AtlasLootBossNames["Naxxramas"][13] },
		{ 22420, "", "=q4=Dreadnaught Sabatons", "=ds="..AtlasLootBossNames["Naxxramas"][3]..", "..AtlasLootBossNames["Naxxramas"][8]..", "..AtlasLootBossNames["Naxxramas"][9] },
		{ 23059, "", "=q4=Ring of the Dreadnaught", "=ds="..AtlasLootBossNames["Naxxramas"][15] },
	};

----------------------------
--- Tier 1/2 Sets (T1/2) ---
----------------------------

	T1T2Druid = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#t1s1#", "=q1=#m30#" },
		{ 16834, "", "=q4=Cenarion Helm", "=ds="..AtlasLootBossNames["MoltenCore"][4], "11.51%" },
		{ 16836, "", "=q4=Cenarion Spaulders", "=ds="..AtlasLootBossNames["MoltenCore"][6], "19.52%" },
		{ 16833, "", "=q4=Cenarion Vestments", "=ds="..AtlasLootBossNames["MoltenCore"][7], "15.21%" },
		{ 16830, "", "=q4=Cenarion Bracers", "=ds="..AtlasLootBossNames["Common"][1], "0.17%" },
		{ 16831, "", "=q4=Cenarion Gloves", "=ds="..AtlasLootBossNames["MoltenCore"][5], "19.53%" },
		{ 16828, "", "=q4=Cenarion Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.16%" },
		{ 16835, "", "=q4=Cenarion Leggings", "=ds="..AtlasLootBossNames["MoltenCore"][2], "12.90%" },
		{ 16829, "", "=q4=Cenarion Boots", "=ds="..AtlasLootBossNames["MoltenCore"][1], "10.72%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Nature_Regeneration", "=q6=#t2s1#", "=q1=#m31#" },		
		{ 16900, "", "=q4=Stormrage Cover", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "13.08%" },
		{ 16902, "", "=q4=Stormrage Pauldrons", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "14.63%" },
		{ 16897, "", "=q4=Stormrage Chestguard", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "11.89%" },		
		{ 16904, "", "=q4=Stormrage Bracers", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "17.38%" },
		{ 16899, "", "=q4=Stormrage Handguards", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "5.34%" },
		{ 16903, "", "=q4=Stormrage Belt", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "16.90%" },
		{ 16901, "", "=q4=Stormrage Legguards", "=ds="..AtlasLootBossNames["MoltenCore"][9], "15.49%" },
		{ 16898, "", "=q4=Stormrage Boots", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "13.79%" },
	};

	T1T2Hunter = {
		{ 0, "Ability_Hunter_RunningShot", "=q6=#t1s2#", "=q1=#m30#" },
		{ 16846, "", "=q4=Giantstalker's Helmet", "=ds="..AtlasLootBossNames["MoltenCore"][4], "11.57%" },
		{ 16848, "", "=q4=Giantstalker's Epaulets", "=ds="..AtlasLootBossNames["MoltenCore"][8], "19.64%" },
		{ 16845, "", "=q4=Giantstalker's Breastplate", "=ds="..AtlasLootBossNames["MoltenCore"][7], "15.83%" },
		{ 16850, "", "=q4=Giantstalker's Bracers", "=ds="..AtlasLootBossNames["Common"][1], "0.18%" },
		{ 16852, "", "=q4=Giantstalker's Gloves", "=ds="..AtlasLootBossNames["MoltenCore"][5], "18.58%" },
		{ 16851, "", "=q4=Giantstalker's Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.17%" },
		{ 16847, "", "=q4=Giantstalker's Leggings", "=ds="..AtlasLootBossNames["MoltenCore"][2], "13.28%" },
		{ 16849, "", "=q4=Giantstalker's Boots", "=ds="..AtlasLootBossNames["MoltenCore"][3], "14.54%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_RunningShot", "=q6=#t2s2#", "=q1=#m31#" },
		{ 16939, "", "=q4=Dragonstalker's Helm", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "13.91%" },
		{ 16937, "", "=q4=Dragonstalker's Spaulders", "=ds="..AtlasLootBossNames["BlackwingLair"][7],   "16.20%" },
		{ 16942, "", "=q4=Dragonstalker's Breastplate", "=ds="..AtlasLootBossNames["BlackwingLair"][8],   "13.30%" },
		{ 16935, "", "=q4=Dragonstalker's Bracers", "=ds="..AtlasLootBossNames["BlackwingLair"][1],	   "19.13%" },
		{ 16940, "", "=q4=Dragonstalker's Gauntlets", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "6.13%" },
		{ 16936, "", "=q4=Dragonstalker's Belt", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "20.17%" },
		{ 16938, "", "=q4=Dragonstalker's Legguards", "=ds="..AtlasLootBossNames["MoltenCore"][9], "16.02%" },
		{ 16941, "", "=q4=Dragonstalker's Greaves", "=ds="..AtlasLootBossNames["BlackwingLair"][3],	 "17.78%" },
	};

	T1T2Mage = {
		{ 0, "Spell_Frost_IceStorm", "=q6=#t1s3#", "=q1=#m30#" },
		{ 16795, "", "=q4=Arcanist Crown", "=ds="..AtlasLootBossNames["MoltenCore"][4], "11.31%" },
		{ 16797, "", "=q4=Arcanist Mantle", "=ds="..AtlasLootBossNames["MoltenCore"][6], "19.92%" },
		{ 16798, "", "=q4=Arcanist Robes", "=ds="..AtlasLootBossNames["MoltenCore"][7], "16.51%" },
		{ 16799, "", "=q4=Arcanist Bindings", "=ds="..AtlasLootBossNames["Common"][1], "0.16%" },
		{ 16801, "", "=q4=Arcanist Gloves", "=ds="..AtlasLootBossNames["MoltenCore"][5], "19.59%" },
		{ 16802, "", "=q4=Arcanist Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.16%"  },
		{ 16796, "", "=q4=Arcanist Leggings", "=ds="..AtlasLootBossNames["MoltenCore"][2], "14.57%" },
		{ 16800, "", "=q4=Arcanist Boots",  "=ds="..AtlasLootBossNames["MoltenCore"][1], "12.06%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Frost_IceStorm", "=q6=#t2s3#", "=q1=#m31#" },
		{ 16914, "", "=q4=Netherwind Crown", "=ds="..AtlasLootBossNames["OnyxiasLair"][1] , "14.09%" },
		{ 16917, "", "=q4=Netherwind Mantle", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "18.09%" },
		{ 16916, "", "=q4=Netherwind Robes", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "14.03%" },
		{ 16918, "", "=q4=Netherwind Bindings", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "20.41%" },
		{ 16913, "", "=q4=Netherwind Gloves", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "7.37%" },
		{ 16818, "", "=q4=Netherwind Belt", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "19.94%" },
		{ 16915, "", "=q4=Netherwind Pants", "=ds="..AtlasLootBossNames["MoltenCore"][9], "17.37%" },
		{ 16912, "", "=q4=Netherwind Boots", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "17.17%" },
	};

	T1T2Paladin = {
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t1s4#", "=q1=#m30#" },
		{ 16854, "", "=q4=Lawbringer Helm", "=ds="..AtlasLootBossNames["MoltenCore"][4], "7.23%" },
		{ 16856, "", "=q4=Lawbringer Spaulders", "=ds="..AtlasLootBossNames["MoltenCore"][6], "12.62%" },
		{ 16853, "", "=q4=Lawbringer Chestguard", "=ds="..AtlasLootBossNames["MoltenCore"][7], "9.53%" },
		{ 16857, "", "=q4=Lawbringer Bracers", "=ds="..AtlasLootBossNames["Common"][1], "0.11%" },
		{ 16860, "", "=q4=Lawbringer Gauntlets", "=ds="..AtlasLootBossNames["MoltenCore"][3], "11.77%" },
		{ 16858, "", "=q4=Lawbringer Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.10%" },
		{ 16855, "", "=q4=Lawbringer Legplates", "=ds="..AtlasLootBossNames["MoltenCore"][2], "8.54%" },
		{ 16859, "", "=q4=Lawbringer Boots", "=ds="..AtlasLootBossNames["MoltenCore"][1], "7.20%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t2s4#", "=q1=#m31#" },
		{ 16955, "", "=q4=Judgement Crown", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "8.64%" },
		{ 16953, "", "=q4=Judgement Spaulders", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "10.97%" },
		{ 16958, "", "=q4=Judgement Breastplate", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "9.24%" },
		{ 16951, "", "=q4=Judgement Bindings", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "13.61%" },
		{ 16956, "", "=q4=Judgement Gauntlets", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "3.58%" },
		{ 16952, "", "=q4=Judgement Belt", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "12.23%" },
		{ 16954, "", "=q4=Judgement Legplates", "=ds="..AtlasLootBossNames["MoltenCore"][9], "10.81%" },
		{ 16957, "", "=q4=Judgement Sabatons", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "11.28%" },
	};

	T1T2Priest = {
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#t1s5#", "=q1=#m30#" },
		{ 16813, "", "=q4=Circlet of Prophecy", "=ds="..AtlasLootBossNames["MoltenCore"][4], "11.36%" },
		{ 16816, "", "=q4=Mantle of Prophecy", "=ds="..AtlasLootBossNames["MoltenCore"][8], "21.06%" },
		{ 16815, "", "=q4=Robes of Prophecy", "=ds="..AtlasLootBossNames["MoltenCore"][7], "15.65%" },
		{ 16819, "", "=q4=Vambraces of Prophecy", "=ds="..AtlasLootBossNames["Common"][1], "0.16%" },
		{ 16812, "", "=q4=Gloves of Prophecy", "=ds="..AtlasLootBossNames["MoltenCore"][3], "18.65%" },
		{ 16817, "", "=q4=Girdle of Prophecy", "=ds="..AtlasLootBossNames["Common"][1], "0.18%" },
		{ 16814, "", "=q4=Pants of Prophecy", "=ds="..AtlasLootBossNames["MoltenCore"][2], "14.33%" },
		{ 16811, "", "=q4=Boots of Prophecy", "=ds="..AtlasLootBossNames["MoltenCore"][5], "14.90%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#t2s5#", "=q1=#m31#" },
		{ 16921, "", "=q4=Halo of Transcendence",  "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "13.39%" },
		{ 16924, "", "=q4=Pauldrons of Transcendence", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "17.83%" },
		{ 16923, "", "=q4=Robes of Transcendence", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "14.83%" },
		{ 16926, "", "=q4=Bindings of Transcendence", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "20.37%" },
		{ 16920, "", "=q4=Handguards of Transcendence", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "6.01%" },
		{ 16925, "", "=q4=Belt of Transcendence", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "18.76%" },
		{ 16922, "", "=q4=Leggings of Transcendence", "=ds="..AtlasLootBossNames["MoltenCore"][9], "17.30%" },
		{ 16919, "", "=q4=Boots of Transcendence", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "14.61%" },
	};

	T1T2Rogue = {
		{ 0, "Ability_BackStab", "=q6=#t1s6#", "=q1=#m30#" },
		{ 16821, "", "=q4=Nightslayer Cover", "=ds="..AtlasLootBossNames["MoltenCore"][4], "10.38%" },
		{ 16823, "", "=q4=Nightslayer Shoulder Pads", "=ds="..AtlasLootBossNames["MoltenCore"][8], "20.66%" },
		{ 16820, "", "=q4=Nightslayer Chestpiece", "=ds="..AtlasLootBossNames["MoltenCore"][7], "16.76%" },
		{ 16825, "", "=q4=Nightslayer Bracelets", "=ds="..AtlasLootBossNames["Common"][1], "0.17%" },
		{ 16826, "", "=q4=Nightslayer Gloves", "=ds="..AtlasLootBossNames["MoltenCore"][3], "19.47%" },
		{ 16827, "", "=q4=Nightslayer Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.15%" },
		{ 16822, "", "=q4=Nightslayer Pants", "=ds="..AtlasLootBossNames["MoltenCore"][2], "13.83%" },
		{ 16824, "", "=q4=Nightslayer Boots", "=ds="..AtlasLootBossNames["MoltenCore"][5], "15.58%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_BackStab", "=q6=#t2s6#", "=q1=#m31#" },
		{ 16908, "", "=q4=Bloodfang Hood", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "13.21%" },
		{ 16832, "", "=q4=Bloodfang Spaulders", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "17.03%" },
		{ 16905, "", "=q4=Bloodfang Chestpiece", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "14.21%" },
		{ 16911, "", "=q4=Bloodfang Bracers", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "20.69%" },
		{ 16907, "", "=q4=Bloodfang Gloves", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "6.84%" },
		{ 16910, "", "=q4=Bloodfang Belt", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "19.69%" },
		{ 16909, "", "=q4=Bloodfang Pants", "=ds="..AtlasLootBossNames["MoltenCore"][9], "17.18%" },
		{ 16906, "", "=q4=Bloodfang Boots", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "15.66%" },
	};

	T1T2Shaman = {
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t1s7#", "=q1=#m30#" },
		{ 16842, "", "=q4=Earthfury Helmet", "=ds="..AtlasLootBossNames["MoltenCore"][4], "3.91%" },
		{ 16844, "", "=q4=Earthfury Epaulets", "=ds="..AtlasLootBossNames["MoltenCore"][6], "7.29%" },
		{ 16841, "", "=q4=Earthfury Vestments", "=ds="..AtlasLootBossNames["MoltenCore"][7], "6.08%" },
		{ 16840, "", "=q4=Earthfury Bracers", "=ds="..AtlasLootBossNames["Common"][1], "0.06%" },
		{ 16839, "", "=q4=Earthfury Gauntlets", "=ds="..AtlasLootBossNames["MoltenCore"][3], "7.38%" },
		{ 16838, "", "=q4=Earthfury Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.07%" },
		{ 16843, "", "=q4=Earthfury Legguards", "=ds="..AtlasLootBossNames["MoltenCore"][2], "4.73%" },
		{ 16837, "", "=q4=Earthfury Boots", "=ds="..AtlasLootBossNames["MoltenCore"][1], "4.16%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t2s7#", "=q1=#m31#" },
		{ 16947, "", "=q4=Helmet of Ten Storms", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "4.86%" },
		{ 16945, "", "=q4=Epaulets of Ten Storms", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "6.73%" },
		{ 16950, "", "=q4=Breastplate of Ten Storms", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "5.65%" },
		{ 16943, "", "=q4=Bracers of Ten Storms", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "7.54%" },
		{ 16948, "", "=q4=Gauntlets of Ten Storms", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "2.13%" },
		{ 16944, "", "=q4=Belt of Ten Storms", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "6.93%" },
		{ 16946, "", "=q4=Legplates of Ten Storms", "=ds="..AtlasLootBossNames["MoltenCore"][9], "5.97%" },
		{ 16949, "", "=q4=Greaves of Ten Storms", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "5.57%" },
	};

	T1T2Warlock = {
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#t1s8#", "=q1=#m30#" },
		{ 16808, "", "=q4=Felheart Horns", "=ds="..AtlasLootBossNames["MoltenCore"][4], "10.62%" },
		{ 16807, "", "=q4=Felheart Shoulder Pads", "=ds="..AtlasLootBossNames["MoltenCore"][6], "19.78%" },
		{ 16809, "", "=q4=Felheart Robes", "=ds="..AtlasLootBossNames["MoltenCore"][7], "15.66%" },
		{ 16804, "", "=q4=Felheart Bracers", "=ds="..AtlasLootBossNames["Common"][1], "0.16%" },
		{ 16805, "", "=q4=Felheart Gloves", "=ds="..AtlasLootBossNames["MoltenCore"][1],  "14.89%" },
		{ 16806, "", "=q4=Felheart Belt", "=ds="..AtlasLootBossNames["Common"][1], "0.19%" },
		{ 16810, "", "=q4=Felheart Pants", "=ds="..AtlasLootBossNames["MoltenCore"][2], "13.75%" },
		{ 16803, "", "=q4=Felheart Slippers", "=ds="..AtlasLootBossNames["MoltenCore"][5], "15.28%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#t2s8#", "=q1=#m31#" },
		{ 16929, "", "=q4=Nemesis Skullcap", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "13.54%" },
		{ 16932, "", "=q4=Nemesis Spaulders", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "16.26%" },
		{ 16931, "", "=q4=Nemesis Robes", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "12.46%" },
		{ 16934, "", "=q4=Nemesis Bracers", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "18.11%" },
		{ 16928, "", "=q4=Nemesis Gloves", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "5.28%" },
		{ 16933, "", "=q4=Nemesis Belt", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "18.42%" },
		{ 16930, "", "=q4=Nemesis Leggings", "=ds="..AtlasLootBossNames["MoltenCore"][9], "16.87%" },
		{ 16927, "", "=q4=Nemesis Boots", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "15.32%" },
	};

	T1T2Warrior = {
		{ 0, "INV_Shield_05", "=q6=#t1s9#", "=q1=#m30#" },
		{ 16866, "", "=q4=Helm of Might", "=ds="..AtlasLootBossNames["MoltenCore"][4], "11.39%" },
		{ 16868, "", "=q4=Pauldrons of Might", "=ds="..AtlasLootBossNames["MoltenCore"][8], "21.14%" },
		{ 16865, "", "=q4=Breastplate of Might", "=ds="..AtlasLootBossNames["MoltenCore"][7], "15.28%" },
		{ 16861, "", "=q4=Bracers of Might", "=ds="..AtlasLootBossNames["Common"][1], "0.16%" },
		{ 16863, "", "=q4=Gauntlets of Might", "=ds="..AtlasLootBossNames["MoltenCore"][1],  "16.40%" },
		{ 16864, "", "=q4=Belt of Might", "=ds="..AtlasLootBossNames["Common"][1], "0.16%" },
		{ 16867, "", "=q4=Legplates of Might", "=ds="..AtlasLootBossNames["MoltenCore"][2], "13.97%" },
		{ 16862, "", "=q4=Sabatons of Might", "=ds="..AtlasLootBossNames["MoltenCore"][3], "14.48%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Shield_05", "=q6=#t2s9#", "=q1=#m31#" },
		{ 16963, "", "=q4=Helm of Wrath", "=ds="..AtlasLootBossNames["OnyxiasLair"][1], "13.65%" },
		{ 16961, "", "=q4=Pauldrons of Wrath", "=ds="..AtlasLootBossNames["BlackwingLair"][7], "16.83%" },
		{ 16966, "", "=q4=Breastplate of Wrath", "=ds="..AtlasLootBossNames["BlackwingLair"][8], "15.06%" },
		{ 16959, "", "=q4=Bracelets of Wrath", "=ds="..AtlasLootBossNames["BlackwingLair"][1], "20.29%" },
		{ 16964, "", "=q4=Gauntlets of Wrath", "=ds="..AtlasLootBossNames["BlackwingLair"][4]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][5]..", ".."=ds="..AtlasLootBossNames["BlackwingLair"][6], "5.93%" },
		{ 16960, "", "=q4=Waistband of Wrath", "=ds="..AtlasLootBossNames["BlackwingLair"][2], "20.03%" },
		{ 16962, "", "=q4=Legplates of Wrath", "=ds="..AtlasLootBossNames["MoltenCore"][9], "17.23%" },
		{ 16965, "", "=q4=Sabatons of Wrath", "=ds="..AtlasLootBossNames["BlackwingLair"][3], "16.84%" },
	};

------------------------------------
--- Dungeon 1 and 2 Sets (D1/D2) ---
------------------------------------

	T0Druid = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#t0s1#", "=ec1=#j6#" },
		{ 16720, "", "=q3=Wildheart Cowl", "=ds="..AtlasLootBossNames["Scholomance"][10], "7.09%" },
		{ 16718, "", "=q3=Wildheart Spaulders", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][6], "11.04%" },
		{ 16706, "", "=q3=Wildheart Vest", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "7.36%" },
		{ 16714, "", "=q3=Wildheart Bracers", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.85%" },
		{ 16717, "", "=q3=Wildheart Gloves", "=ds="..AtlasLootBossNames["Stratholme"][2], "12.61%" },
		{ 16716, "", "=q3=Wildheart Belt", "=ds="..AtlasLootBossNames["Scholomance"][11], "2.60%" },
		{ 16719, "", "=q3=Wildheart Kilt", "=ds="..AtlasLootBossNames["Stratholme"][12], "6.58%" },
		{ 16715, "", "=q3=Wildheart Boots", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][4], "13.03%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Nature_Regeneration", "=q6=#t05s1#", "=ec1=#j7#" },
		{ 22109, "", "=q4=Feralheart Cowl", "=ds=#a2#, #s1#" },
		{ 22112, "", "=q3=Feralheart Spaulders", "=ds=#a2#, #s3#" },
		{ 22113, "", "=q4=Feralheart Vest", "=ds=#a2#, #s5#" },
		{ 22108, "", "=q3=Feralheart Bracers", "=ds=#a2#, #s8#" },
		{ 22110, "", "=q4=Feralheart Gloves", "=ds=#a2#, #s9#" },
		{ 22106, "", "=q3=Feralheart Belt", "=ds=#a2#, #s10#" },
		{ 22111, "", "=q3=Feralheart Kilt", "=ds=#a2#, #s11#" },
		{ 22107, "", "=q4=Feralheart Boots", "=ds=#a2#, #s12#" },
	};

	T0Hunter = {
		{ 0, "Ability_Hunter_RunningShot", "=q6=#t0s2#", "=ec1=#j6#" },
		{ 16677, "", "=q3=Beaststalker's Cap", "=ds="..AtlasLootBossNames["Scholomance"][10], "7.00%" },
		{ 16679, "", "=q3=Beaststalker's Mantle", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][7], "9.89%" },
		{ 16674, "","=q3=Beaststalker's Tunic", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6],   "6.81%" },
		{ 16681, "", "=q3=Beaststalker's Bindings", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.64%" },
		{ 16676, "", "=q3=Beaststalker's Gloves", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][3], "9.15%" },
		{ 16680, "", "=q3=Beaststalker's Belt", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.36%" },
		{ 16678, "", "=q3=Beaststalker's Pants", "=ds="..AtlasLootBossNames["Stratholme"][12], "6.16%" },
		{ 16675, "", "=q3=Beaststalker's Boots", "=ds="..AtlasLootBossNames["Stratholme"][8], "13.62%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_RunningShot", "=q6=#t05s2#", "=ec1=#j7#" },
		{ 22013, "", "=q4=Beastmaster's Cap", "=ds=#a3#, #s1#" },
		{ 22016, "", "=q3=Beastmaster's Mantle", "=ds=#a3#, #s3#" },
		{ 22060, "","=q4=Beastmaster's Tunic", "=ds=#a3#, #s5#" },
		{ 22011, "", "=q3=Beastmaster's Bindings", "=ds=#a3#, #s8#" },
		{ 22015, "", "=q4=Beastmaster's Gloves", "=ds=#a3#, #s9#" },
		{ 22010, "", "=q3=Beastmaster's Belt", "=ds=#a3#, #s10#" },
		{ 22017, "", "=q3=Beastmaster's Pants", "=ds=#a3#, #s11#" },
		{ 22061, "", "=q4=Beastmaster's Boots", "=ds=#a3#, #s12#" },
	};

	T0Mage = {
		{ 0, "Spell_Frost_IceStorm", "=q6=#t0s3#", "=ec1=#j6#" },
		{ 16686, "", "=q3=Magister's Crown", "=ds="..AtlasLootBossNames["Scholomance"][10], "8.60%" },
		{ 16689, "", "=q3=Magister's Mantle", "=ds="..AtlasLootBossNames["Scholomance"][4], "11.93%" },
		{ 16688, "", "=q3=Magister's Robes", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "7.24%" },
		{ 16683, "", "=q3=Magister's Bindings", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.19%" },
		{ 16684, "", "=q3=Magister's Gloves", "=ds="..AtlasLootBossNames["Scholomance"][6], "9.75%" },
		{ 16685, "", "=q3=Magister's Belt", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.32%" },
		{ 16687, "", "=q3=Magister's Leggings", "=ds="..AtlasLootBossNames["Stratholme"][12], "6.79%" },
		{ 16682, "", "=q3=Magister's Boots", "=ds="..AtlasLootBossNames["Stratholme"][1], "10.86%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Frost_IceStorm", "=q6=#t05s3#", "=ec1=#j7#" },
		{ 22065, "", "=q4=Sorcerer's Crown", "=ds=#a1#, #s1#" },
		{ 22068, "", "=q3=Sorcerer's Mantle", "=ds=#a1#, #s3#" },
		{ 22069, "","=q4=Sorcerer's Robes", "=ds=#a1#, #s5#" },
		{ 22063, "", "=q3=Sorcerer's Bindings", "=ds=#a1#, #s8#" },
		{ 22066, "", "=q4=Sorcerer's Gloves", "=ds=#a1#, #s9#" },
		{ 22062, "", "=q3=Sorcerer's Belt", "=ds=#a1#, #s10#" },
		{ 22067, "", "=q3=Sorcerer's Leggings", "=ds=#a1#, #s11#" },
		{ 22064, "", "=q4=Sorcerer's Boots", "=ds=#a1#, #s12#" },
	};

	T0Paladin = {
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t0s4#", "=ec1=#j6#" },
		{ 16727, "", "=q3=Lightforge Helm", "=ds="..AtlasLootBossNames["Scholomance"][10], "5.32%" },
		{ 16729, "", "=q3=Lightforge Spaulders", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][5], "13.62%" },
		{ 16726, "", "=q3=Lightforge Breastplate", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "3.76%" },
		{ 16722, "", "=q3=Lightforge Bracers", "=ds="..AtlasLootBossNames["Scholomance"][11], "3.37%" },
		{ 16724, "", "=q3=Lightforge Gauntlets", "=ds="..AtlasLootBossNames["Stratholme"][3], "10.42%" },
		{ 16723, "", "=q3=Lightforge Belt", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.93%" },
		{ 16728, "", "=q3=Lightforge Legplates", "=ds="..AtlasLootBossNames["Stratholme"][12], "4.20%" },
		{ 16725, "", "=q3=Lightforge Boots", "=ds="..AtlasLootBossNames["Stratholme"][6], "11.11%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_SealOfMight", "=q6=#t05s4#", "=ec1=#j7#" },
		{ 22091, "", "=q4=Soulforge Helm", "=ds=#a4#, #s1#" },
		{ 22093, "","=q3=Soulforge Spaulders", "=ds=#a4#, #s3#" },
		{ 22089, "","=q4=Soulforge Breastplate", "=ds=#a4#, #s5#" },
		{ 22088, "", "=q3=Soulforge Bracers", "=ds=#a4#, #s8#" },
		{ 22090, "", "=q4=Soulforge Gauntlets", "=ds=#a4#, #s9#" },
		{ 22086, "", "=q3=Soulforge Belt", "=ds=#a4#, #s10#" },
		{ 22092, "", "=q3=Soulforge Legplates", "=ds=#a4#, #s11#" },
		{ 22087, "", "=q4=Soulforge Boots", "=ds=#a4#, #s12#" },
	};

	T0Priest = {
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#t0s5#", "=ec1=#j6#" },
		{ 16693, "", "=q3=Devout Crown", "=ds="..AtlasLootBossNames["Scholomance"][10], "7.89%" },
		{ 16695, "", "=q3=Devout Mantle", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][2], "12.84%" },
		{ 16690, "", "=q3=Devout Robe", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "6.20%" },
		{ 16697, "", "=q3=Devout Bracers", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.13%" },
		{ 16692, "", "=q3=Devout Gloves", "=ds="..AtlasLootBossNames["Stratholme"][5], "12.46%" },
		{ 16696, "", "=q3=Devout Belt", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "2.07%" },
		{ 16694, "", "=q3=Devout Skirt", "=ds="..AtlasLootBossNames["Stratholme"][12], "7.42%" },
		{ 16691, "", "=q3=Devout Sandals", "=ds="..AtlasLootBossNames["Stratholme"][9], "13.64%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#t05s5#", "=ec1=#j7#" },
		{ 22080, "", "=q4=Virtuous Crown", "=ds=#a1#, #s1#" },
		{ 22082, "", "=q3=Virtuous Mantle", "=ds=#a1#, #s3#" },
		{ 22083, "", "=q4=Virtuous Robe", "=ds=#a1#, #s5#" },
		{ 22079, "", "=q3=Virtuous Bracers", "=ds=#a1#, #s8#" },
		{ 22081, "", "=q4=Virtuous Gloves", "=ds=#a1#, #s9#" },
		{ 22078, "", "=q3=Virtuous Belt", "=ds=#a1#, #s10#" },
		{ 22085, "", "=q3=Virtuous Skirt", "=ds=#a1#, #s11#" },
		{ 22084, "", "=q4=Virtuous Sandals", "=ds=#a1#, #s12#" },
	};

	T0Rogue = {
		{ 0, "Ability_BackStab", "=q6=#t0s6#", "=ec1=#j6#" },
		{ 16707, "", "=q3=Shadowcraft Cap", "=ds="..AtlasLootBossNames["Scholomance"][10], "6.65%" },
		{ 16708, "", "=q3=Shadowcraft Spaulders", "=ds="..AtlasLootBossNames["Stratholme"][4], "10.68%" },
		{ 16721, "", "=q3=Shadowcraft Tunic", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "6.09%" },
		{ 16710, "", "=q3=Shadowcraft Bracers", "=ds="..AtlasLootBossNames["Scholomance"][11], "3.51%" },
		{ 16712, "", "=q3=Shadowcraft Gloves", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][2], "11.89%" },
		{ 16713, "", "=q3=Shadowcraft Belt", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.05%" },
		{ 16709, "", "=q3=Shadowcraft Pants", "=ds="..AtlasLootBossNames["Stratholme"][12], "7.76%" },
		{ 16711, "", "=q3=Shadowcraft Boots", "=ds="..AtlasLootBossNames["Scholomance"][3], "14.32%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_BackStab", "=q6=#t05s6#", "=ec1=#j7#" },
		{ 22005, "", "=q4=Darkmantle Cap", "=ds=#a2#, #s1#" },
		{ 22008, "", "=q3=Darkmantle Spaulders", "=ds=#a2#, #s3#" },
		{ 22009, "", "=q4=Darkmantle Tunic", "=ds=#a2#, #s5#" },
		{ 22004, "", "=q3=Darkmantle Bracers", "=ds=#a2#, #s8#" },
		{ 22006, "", "=q4=Darkmantle Gloves", "=ds=#a2#, #s9#" },
		{ 22002, "", "=q3=Darkmantle Belt", "=ds=#a2#, #s10#" },
		{ 22007, "", "=q3=Darkmantle Pants", "=ds=#a2#, #s11#" },
		{ 22003, "", "=q4=Darkmantle Boots", "=ds=#a2#, #s12#" },
	};

	T0Shaman = {
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t0s7#", "=ec1=#j6#" },
		{ 16667, "", "=q3=Coif of Elements", "=ds="..AtlasLootBossNames["Scholomance"][10], "2.86%" },
		{ 16669, "", "=q3=Pauldrons of Elements", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][4], "14.77%" },
		{ 16666, "", "=q3=Vest of Elements", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "3.03%" },
		{ 16671, "", "=q3=Bindings of Elements", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.59%" },
		{ 16672, "", "=q3=Gauntlets of Elements", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][1], "14.23%" },
		{ 16673, "", "=q3=Cord of Elements", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.06%" },
		{ 16668, "", "=q3=Kilt of Elements", "=ds="..AtlasLootBossNames["Stratholme"][12], "3.02%" },
		{ 16670, "", "=q3=Boots of Elements", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][1], "9.35%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#t05s7#", "=ec1=#j7#" },
		{ 22097, "", "=q4=Coif of The Five Thunders", "=ds=#a3#, #s1#" },
		{ 22101, "", "=q3=Pauldrons of The Five Thunders", "=ds=#a3#, #s3#" },
		{ 22102, "", "=q4=Vest of The Five Thunders", "=ds=#a3#, #s5#" },
		{ 22095, "", "=q3=Bindings of The Five Thunders", "=ds=#a3#, #s8#" },
		{ 22099, "", "=q4=Gauntlets of The Five Thunders", "=ds=#a3#, #s9#" },
		{ 22098, "", "=q3=Cord of The Five Thunders", "=ds=#a3#, #s10#" },
		{ 22100, "", "=q3=Kilt of The Five Thunders", "=ds=#a3#, #s11#" },
		{ 22096, "", "=q4=Boots of The Five Thunders", "=ds=#a3#, #s12#" },
	};

	T0Warlock = {
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#t0s8#", "=ec1=#j6#" },
		{ 16698, "", "=q3=Dreadmist Mask", "=ds="..AtlasLootBossNames["Scholomance"][10], "8.78%" },
		{ 16701, "", "=q3=Dreadmist Mantle", "=ds="..AtlasLootBossNames["Scholomance"][2], "12.20%" },
		{ 16700, "","=q3=Dreadmist Robe", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "8.04%" },
		{ 16703, "", "=q3=Dreadmist Bracers", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.68%" },
		{ 16705, "", "=q3=Dreadmist Wraps", "=ds="..AtlasLootBossNames["Scholomance"][7], "14.54%" },
		{ 16702, "", "=q3=Dreadmist Belt", "=ds="..AtlasLootBossNames["Stratholme"][13], "1.03%" },
		{ 16699, "", "=q3=Dreadmist Leggings", "=ds="..AtlasLootBossNames["Stratholme"][12], "7.31%" },
		{ 16704, "", "=q3=Dreadmist Sandals", "=ds="..AtlasLootBossNames["Stratholme"][7], "13.16%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#t05s8#", "=ec1=#j7#" },
		{ 22074, "", "=q4=Deathmist Mask", "=ds=#a1#, #s1#" },
		{ 22073, "", "=q3=Deathmist Mantle", "=ds=#a1#, #s5#" },
		{ 22075, "","=q4=Deathmist Robe", "=ds=#a1#, #s3#" },
		{ 22071, "", "=q3=Deathmist Bracers", "=ds=#a1#, #s8#" },
		{ 22077, "", "=q4=Deathmist Wraps", "=ds=#a1#, #s9#" },
		{ 22070, "", "=q3=Deathmist Belt", "=ds=#a1#, #s10#" },
		{ 22072, "", "=q3=Deathmist Leggings", "=ds=#a1#, #s11#" },
		{ 22076, "", "=q4=Deathmist Sandals", "=ds=#a1#, #s12#" },
	};

	T0Warrior = {
		{ 0, "INV_Shield_05", "=q6=#t0s9#", "=ec1=#j6#" },
		{ 16731, "", "=q3=Helm of Valor", "=ds="..AtlasLootBossNames["Scholomance"][10], "6.54%" },
		{ 16733, "", "=q3=Spaulders of Valor", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][3], "13.39%" },
		{ 16730, "", "=q3=Breastplate of Valor", "=ds="..AtlasLootBossNames["BlackrockSpireUpper"][6], "5.83%" },
		{ 16735, "", "=q3=Bracers of Valor", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.49%" },
		{ 16737, "", "=q3=Gauntlets of Valor", "=ds="..AtlasLootBossNames["Stratholme"][11], "9.58%" },
		{ 16736, "", "=q3=Belt of Valor", "=ds="..AtlasLootBossNames["BlackrockSpireLower"][8], "1.96%" },
		{ 16732, "", "=q3=Legplates of Valor", "=ds="..AtlasLootBossNames["Stratholme"][12], "5.74%" },
		{ 16734, "", "=q3=Boots of Valor", "=ds="..AtlasLootBossNames["Scholomance"][1], "11.12%" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Shield_05", "=q6=#t05s9#", "=ec1=#j7#" },
		{ 21999, "", "=q4=Helm of Heroism", "=ds=#a4#, #s1#" },
		{ 22001, "", "=q3=Spaulders of Heroism", "=ds=#a4#, #s3#" },
		{ 21997, "", "=q4=Breastplate of Heroism", "=ds=#a4#, #s5#" },
		{ 21996, "", "=q3=Bracers of Heroism", "=ds=#a4#, #s8#" },
		{ 21998, "", "=q4=Gauntlets of Heroism", "=ds=#a4#, #s9#" },
		{ 21994, "", "=q3=Belt of Heroism", "=ds=#a4#, #s10#" },
		{ 22000, "", "=q3=Legplates of Heroism", "=ds=#a4#, #s11#" },
		{ 21995, "", "=q4=Boots of Heroism", "=ds=#a4#, #s12#" },
	};

---------------------------
--- Dungeon 3 Sets (D3) ---
---------------------------

	DS3Cloth = {
		{ 0, "Spell_Holy_InnerFire", "=q6=#ds3s1#", "" },
		{ 28413, "", "=q3=Hallowed Crown", "=ds="..AtlasLootBossNames["TKTheArcatraz"][1] },
		{ 27775, "", "=q3=Hallowed Pauldrons", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][2] },
		{ 28230, "", "=q3=Hallowed Garments", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][3] },
		{ 27536, "", "=q3=Hallowed Handwraps", "=ds="..AtlasLootBossNames["HCShatteredHalls"][2] },
		{ 27875, "", "=q3=Hallowed Trousers", "=ds="..AtlasLootBossNames["AuchSethekkHalls"][1] },
		{ 0,"","","" },
		{ 0, "INV_Elemental_Mote_Nether", "=q6=#ds3s3#", "" },
		{ 28193, "", "=q3=Mana-Etched Crown", "=ds="..AtlasLootBossNames["CoTTheBlackMorass"][1] },
		{ 27796, "", "=q3=Mana-Etched Spaulders", "=ds="..AtlasLootBossNames["CFRTheSlavePens"][1].." (#j3#)" },
		{ 28191, "", "=q3=Mana-Etched Vestments", "=ds="..AtlasLootBossNames["CoTOldHillsbradFoothills"][1].." (#j3#)" },
		{ 27465, "", "=q3=Mana-Etched Gloves", "=ds="..AtlasLootBossNames["HCRamparts"][1].." (#j3#)" },
		{ 27907, "", "=q3=Mana-Etched Pantaloons", "=ds="..AtlasLootBossNames["CFRTheUnderbog"][1].." (#j3#)" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_Creature_Cursed_04", "=q6=#ds3s2#", "" },
		{ 28278, "", "=q3=Incanter's Cowl", "=ds="..AtlasLootBossNames["TKMechanar"][1] },
		{ 27738, "", "=q3=Incanter's Pauldrons", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 28229, "", "=q3=Incanter's Robe", "=ds="..AtlasLootBossNames["TKTheBotanica"][2] },
		{ 27508, "", "=q3=Incanter's Gloves", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][1] },
		{ 27838, "", "=q3=Incanter's Trousers", "=ds="..AtlasLootBossNames["AuchSethekkHalls"][1] },
		{ 0,"","","" },
		{ 0, "Ability_Creature_Cursed_03", "=q6=#ds3s4#", "" },
		{ 28415, "", "=q3=Hood of Oblivion", "=ds="..AtlasLootBossNames["TKTheArcatraz"][1] },
		{ 27778, "", "=q3=Spaulders of Oblivion", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][3] },
		{ 28232, "", "=q3=Robe of Oblivion", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][3] },
		{ 27537, "", "=q3=Gloves of Oblivion", "=ds="..AtlasLootBossNames["HCShatteredHalls"][2] },
		{ 27948, "", "=q3=Trousers of Oblivion", "=ds="..AtlasLootBossNames["AuchSethekkHalls"][1] },
	};
	
	DS3Leather = {
		{ 0, "Ability_Rogue_SinisterCalling", "=q6=#ds3s5#", "" },
		{ 28414, "", "=q3=Helm of Assassination", "=ds="..AtlasLootBossNames["TKTheArcatraz"][1] },
		{ 27776, "", "=q3=Shoulderpads of Assassination", "=ds="..AtlasLootBossNames["AuchSethekkHalls"][1] },
		{ 28204, "", "=q3=Tunic of Assassination", "=ds="..AtlasLootBossNames["TKMechanar"][1] },
		{ 27509, "", "=q3=Handgrips of Assassination", "=ds="..AtlasLootBossNames["CoTTheBlackMorass"][1] },
		{ 27908, "", "=q3=Leggings of Assassination", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][3] },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_RapidKilling", "=q6=#ds3s7#", "" },
		{ 28224, "", "=q3=Wastewalker Helm", "=ds="..AtlasLootBossNames["CoTOldHillsbradFoothills"][1].." (#j3#)" },
		{ 27797, "", "=q3=Wastewalker Shoulderpads", "=ds="..AtlasLootBossNames["AuchAuchenaiCrypts"][2].." (#j3#)" },
		{ 28264, "", "=q3=Wastewalker Tunic", "=ds="..AtlasLootBossNames["HCBloodFurnace"][1].." (#j3#)" },
		{ 27531, "", "=q3=Wastewalker Gloves", "=ds="..AtlasLootBossNames["HCShatteredHalls"][2] },
		{ 27837, "", "=q3=Wastewalker Leggings", "=ds="..AtlasLootBossNames["AuchManaTombs"][1].." (#j3#)" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_SealOfRighteousness", "=q6=#ds3s6#", "" },
		{ 28348, "", "=q3=Moonglade Cowl", "=ds="..AtlasLootBossNames["TKTheBotanica"][2] },
		{ 27737, "", "=q3=Moonglade Shoulders", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 28202, "", "=q3=Moonglade Robe", "=ds="..AtlasLootBossNames["TKMechanar"][1] },
		{ 27468, "", "=q3=Moonglade Handwraps", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][1] },
		{ 27873, "", "=q3=Moonglade Pants", "=ds="..AtlasLootBossNames["CoTTheBlackMorass"][1] },
	};
	
	DS3Mail = {
		{ 0, "Ability_Hunter_Pet_Wolf", "=q6=#ds3s8#", "" },
		{ 28275, "", "=q3=Beast Lord Helm", "=ds="..AtlasLootBossNames["TKMechanar"][1] },
		{ 27801, "", "=q3=Beast Lord Mantle", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 28228, "", "=q3=Beast Lord Curiass", "=ds="..AtlasLootBossNames["TKTheBotanica"][2] },
		{ 27474, "", "=q3=Beast Lord Handguards", "=ds="..AtlasLootBossNames["HCShatteredHalls"][2] },
		{ 27874, "", "=q3=Beast Lord Leggings", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 0,"","","" },
		{ 0, "INV_Helmet_70", "=q6=#ds3s10#", "" },
		{ 28349, "", "=q3=Tidefury Helm", "=ds="..AtlasLootBossNames["TKTheBotanica"][2] },
		{ 27802, "", "=q3=Tidefury Shoulderguards", "=ds="..AtlasLootBossNames["HCShatteredHalls"][1] },
		{ 28231, "", "=q3=Tidefury Chestpiece", "=ds="..AtlasLootBossNames["TKTheArcatraz"][1] },
		{ 27510, "", "=q3=Tidefury Gauntlets", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 27909, "", "=q3=Tidefury Kilt", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][3] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Ability_FiegnDead", "=q6=#ds3s9#", "" },
		{ 28192, "", "=q3=Helm of Desolation", "=ds="..AtlasLootBossNames["CoTTheBlackMorass"][1] },
		{ 27713, "", "=q3=Pauldrons of Desolation", "=ds="..AtlasLootBossNames["CFRTheSlavePens"][1].." (#j3#)" },
		{ 28401, "", "=q3=Hauberk of Desolation", "=ds="..AtlasLootBossNames["CoTOldHillsbradFoothills"][1].." (#j3#)" },
		{ 27528, "", "=q3=Gauntlets of Desolation", "=ds="..AtlasLootBossNames["HCShatteredHalls"][2] },
		{ 27936, "", "=q3=Greaves of Desolation", "=ds="..AtlasLootBossNames["AuchSethekkHalls"][1] },
	};
	
	DS3Plate = {
		{ 0, "Spell_Fire_EnchantWeapon", "=q6=#ds3s11#", "" },
		{ 28350, "", "=q3=Warhelm of the Bold", "=ds="..AtlasLootBossNames["TKTheBotanica"][2] },
		{ 27803, "", "=q3=Shoulderguards of the Bold", "=ds="..AtlasLootBossNames["AuchShadowLabyrinth"][3] },
		{ 28205, "", "=q3=Breastplate of the Bold", "=ds="..AtlasLootBossNames["TKTheArcatraz"][1] },
		{ 27475, "", "=q3=Gauntlets of the Bold", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 27977, "", "=q3=Legplates of the Bold", "=ds="..AtlasLootBossNames["CoTTheBlackMorass"][1] },
		{ 0,"","","" },
		{ 0, "INV_Hammer_02", "=q6=#ds3s13#", "" },
		{ 28285, "", "=q3=Helm of the Righteous", "=ds="..AtlasLootBossNames["TKMechanar"][1] },
		{ 27739, "", "=q3=Spaulders of the Righteous", "=ds="..AtlasLootBossNames["TKTheBotanica"][1] },
		{ 28203, "", "=q3=Breastplate of the Righteous", "=ds="..AtlasLootBossNames["CFRTheSteamvault"][2] },
		{ 27535, "", "=q3=Gauntlets of the Righteous", "=ds="..AtlasLootBossNames["HCShatteredHalls"][1] },
		{ 27839, "", "=q3=Legplates of the Righteous", "=ds="..AtlasLootBossNames["CoTTheBlackMorass"][1] },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Helmet_08", "=q6=#ds3s12#", "" },
		{ 28225, "", "=q3=Doomplate Warhelm", "=ds="..AtlasLootBossNames["CoTOldHillsbradFoothills"][1].." (#j3#)" },
		{ 27771, "", "=q3=Doomplate Shouldergards", "=ds="..AtlasLootBossNames["CFRTheUnderbog"][1].." (#j3#)" },
		{ 28403, "", "=q3=Doomplate Chestguard", "=ds="..AtlasLootBossNames["TKTheArcatraz"][1] },
		{ 27497, "", "=q3=Doomplate Gauntlets", "=ds="..AtlasLootBossNames["HCBloodFurnace"][1].." (#j3#)" },
		{ 27870, "", "=q3=Doomplate Legguards", "=ds="..AtlasLootBossNames["AuchAuchenaiCrypts"][1].." (#j3#)" },
	};

---------------
--- ZG Sets ---
---------------

	ZGDruid = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#zgs1#", "" },
		{ 19955, "", "=q4=Wushoolay's Charm of Nature", "" },
		{ 19613, "", "=q4=Pristine Enchanted South Seas Kelp", "=ds=#r5#" },
		{ 19838, "", "=q4=Zandalar Haruspex's Tunic", "=q4=#zgt9#, =ds=#r4#" },
		{ 19839, "", "=q4=Zandalar Haruspex's Belt","=q4=#zgt4#, =ds=#r3#" },
		{ 19840, "", "=q4=Zandalar Haruspex's Bracers", "=q4=#zgt5#, =ds=#r2#" },
	};

	ZGHunter = {
		{ 0, "Ability_Hunter_RunningShot", "=q6=#zgs2#", "" },
		{ 19953, "", "=q4=Renataki's Charm of Beasts", "" },
		{ 19621, "", "=q4=Maelstrom's Wrath", "=ds=#r5#" },
		{ 19831, "", "=q4=Zandalar Predator's Mantle", "=q4=#zgt6#, =ds=#r4#" },
		{ 19832, "", "=q4=Zandalar Predator's Belt", "=q4=#zgt2#, =ds=#r3#" },
		{ 19833, "", "=q4=Zandalar Predator's Bracers", "=q4=#zgt3#, =ds=#r2#" },
	};

	ZGMage = {
		{ 0, "Spell_Frost_IceStorm", "=q6=#zgs3#", "" },
		{ 19959, "", "=q4=Hazza'rah's Charm of Magic", "" },
		{ 19601, "", "=q4=Jewel of Kajaro", "=ds=#r5#" },
		{ 20034, "", "=q4=Zandalar Illusionist's Robe", "=q4=#zgt1#, =ds=#r4#" },
		{ 19845, "", "=q4=Zandalar Illusionist's Mantle", "=q4=#zgt2#, =ds=#r3#" },
		{ 19846, "", "=q4=Zandalar Illusionist's Wraps", "=q4=#zgt3#, =ds=#r2#" },
	};

	ZGPaladin = {
		{ 0, "Spell_Holy_SealOfMight", "=q6=#zgs4#", "" },
		{ 19952, "", "=q4=Gri'lek's Charm of Valor", "" },
		{ 19588, "", "=q4=Hero's Brand", "=ds=#r5#" },
		{ 19825, "", "=q4=Zandalar Freethinker's Breastplate", "=q4=#zgt9#, =ds=#r4#" },
		{ 19826, "", "=q4=Zandalar Freethinker's Belt", "=q4=#zgt2#, =ds=#r3#" },
		{ 19827, "", "=q4=Zandalar Freethinker's Armguards", "=q4=#zgt3#, =ds=#r2#" },
	};

	ZGPriest = {
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#zgs5#", "" },
		{ 19958, "", "=q4=Hazza'rah's Charm of Healing", "" },
		{ 19594, "", "=q4=The All-Seeing Eye of Zuldazar", "=ds=#r5#" },
		{ 19841, "", "=q4=Zandalar Confessor's Mantle", "=q4=#zgt6#, =ds=#r4#" },
		{ 19842, "", "=q4=Zandalar Confessor's Bindings", "=q4=#zgt4#, =ds=#r3#" },
		{ 19843, "", "=q4=Zandalar Confessor's Wraps", "=q4=#zgt5#, =ds=#r2#" },
	};

	ZGRogue = {
		{ 0, "Ability_BackStab", "=q6=#zgs6#", "" },
		{ 19954, "", "=q4=Renataki's Charm of Trickery", "" },
		{ 19617, "", "=q4=Zandalarian Shadow Mastery Talisman", "=ds=#r5#" },
		{ 19834, "", "=q4=Zandalar Madcap's Tunic", "=q4=#zgt6#, =ds=#r4#" },
		{ 19835, "", "=q4=Zandalar Madcap's Mantle", "=q4=#zgt7#, =ds=#r3#" },
		{ 19836, "", "=q4=Zandalar Madcap's Bracers", "=q4=#zgt8#, =ds=#r2#" },
	};

	ZGShaman = {
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#zgs7#", "" },
		{ 19956, "", "=q4=Wushoolay's Charm of Spirits", "" },
		{ 19609, "", "=q4=Unmarred Vision of Voodress", "=ds=#r5#" },
		{ 19828, "", "=q4=Zandalar Augur's Hauberk", "=q4=#zgt9#, =ds=#r4#" },
		{ 19829, "", "=q4=Zandalar Augur's Belt", "=q4=#zgt7#, =ds=#r3#" },
		{ 19830, "", "=q4=Zandalar Augur's Bracers", "=q4=#zgt8#, =ds=#r2#" },
	};

	ZGWarlock = {
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#zgs8#", "" },
		{ 19957, "", "=q4=Hazza'rah's Charm of Destruction", "" },
		{ 19605, "", "=q4=Kezan's Unstoppable Taint", "=ds=#r5#" },
		{ 20033, "", "=q4=Zandalar Demoniac's Robe", "=q4=#zgt1#, =ds=#r4#" },
		{ 19849, "", "=q4=Zandalar Demoniac's Mantle", "=q4=#zgt4#, =ds=#r3#" },
		{ 19848, "", "=q4=Zandalar Demoniac's Wraps", "=q4=#zgt5#, =ds=#r2#" },
	};

	ZGWarrior = {
		{ 0, "INV_Shield_05", "=q6=#zgs9#", "" },
		{ 19951, "", "=q4=Gri'lek's Charm of Might", "" },
		{ 19577, "", "=q4=Rage of Mugamba", "=ds=#r5#" },
		{ 19822, "", "=q4=Zandalar Vindicator's Breastplate", "=q4=#zgt1#, =ds=#r4#" },
		{ 19823, "", "=q4=Zandalar Vindicator's Belt", "=q4=#zgt7#, =ds=#r3#" },
		{ 19824, "", "=q4=Zandalar Vindicator's Armguards", "=q4=#zgt8#, =ds=#r2#" },
	};

-----------------
--- AQ20 Sets ---
-----------------

    AQ20Sets1 = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#aq20s1#", "=ec1=#c1#" },
		{ 21407, "", "=q4=Mace of Unending Life", "=q4=#aq20t1#, =ds=#r5#" },
		{ 21409, "", "=q4=Cloak of Unending Life", "=q3=#aq20t5#, =ds=#r4#" },
		{ 21408, "", "=q4=Band of Unending Life", "=q3=#aq20t3#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_RunningShot", "=q6=#aq20s2#", "=ec1=#c2#" },
		{ 21401, "", "=q4=Scythe of the Unseen Path", "=q4=#aq20t6#, =ds=#r5#" },
		{ 21403, "", "=q4=Cloak of the Unseen Path", "=q3=#aq20t5#, =ds=#r4#" },
		{ 21402, "", "=q4=Signet of the Unseen Path", "=q3=#aq20t4#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "Spell_Frost_IceStorm", "=q6=#aq20s3#", "=ec1=#c3#" },
		{ 21413, "", "=q4=Blade of Vaulted Secrets", "=q4=#aq20t1#, =ds=#r5#" },
		{ 21415, "", "=q4=Drape of Vaulted Secrets", "=q3=#aq20t2#, =ds=#r4#" },
		{ 21414, "", "=q4=Band of Vaulted Secrets", "=q3=#aq20t3#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_SealOfMight", "=q6=#aq20s4#", "=ec1=#c4#" },
		{ 21395, "", "=q4=Blade of Eternal Justice", "=q4=#aq20t6#, =ds=#r5#" },
		{ 21397, "", "=q4=Cape of Eternal Justice", "=q3=#aq20t5#, =ds=#r4#" },
		{ 21396, "", "=q4=Ring of Eternal Justice", "=q3=#aq20t3#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#aq20s5#", "=ec1=#c5#" },
		{ 21410, "", "=q4=Gavel of Infinite Wisdom", "=q4=#aq20t1#, =ds=#r5#" },
		{ 21412, "", "=q4=Shroud of Infinite Wisdom", "=q3=#aq20t2#, =ds=#r4#" },
		{ 21411, "", "=q4=Ring of Infinite Wisdom", "=q3=#aq20t4#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "Ability_BackStab", "=q6=#aq20s6#", "=ec1=#c6#" },
		{ 21404, "", "=q4=Dagger of Veiled Shadows", "=q4=#aq20t6#, =ds=#r5#" },
		{ 21406, "", "=q4=Cloak of Veiled Shadows", "=q3=#aq20t2#, =ds=#r4#" },
		{ 21405, "", "=q4=Band of Veiled Shadows", "=q3=#aq20t4#, =ds=#r3#" },
	};
	
    AQ20Sets2 = {
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#aq20s7#", "=ec1=#c7#" },
		{ 21398, "", "=q4=Hammer of the Gathering Storm", "=q4=#aq20t6#, =ds=#r5#" },
		{ 21400, "", "=q4=Cloak of the Gathering Storm", "=q3=#aq20t5#, =ds=#r4#" },
		{ 21399, "", "=q4=Ring of the Gathering Storm", "=q3=#aq20t3#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#aq20s8#", "=ec1=#c8#" },
		{ 21416, "", "=q4=Kris of Unspoken Names", "=q4=#aq20t1#, =ds=#r5#" },
		{ 21418, "", "=q4=Shroud of Unspoken Names", "=q3=#aq20t5#, =ds=#r4#" },
		{ 21417, "", "=q4=Ring of Unspoken Names", "=q3=#aq20t4#, =ds=#r3#" },
		{ 0,"","","" },
		{ 0, "INV_Shield_05", "=q6=#aq20s9#", "=ec1=#c9#" },
		{ 21392, "", "=q4=Sickle of Unyielding Strength", "=q4=#aq20t6#, =ds=#r5#" },
		{ 21394, "", "=q4=Drape of Unyielding Strength", "=q3=#aq20t2#, =ds=#r4#" },
		{ 21393, "", "=q4=Signet of Unyielding Strength", "=q3=#aq20t3#=ds=, #r3#" },
	};

-----------------
--- AQ40 Sets ---
-----------------

	AQ40Sets1 = {
		{ 0, "Spell_Nature_Regeneration", "=q6=#aq40s1#", "=ec1=#c1#" },
		{ 21357, "", "=q4=Genesis Vest", "=q4=#aq40t4#, =ds=#r3#" },
		{ 21353, "", "=q4=Genesis Helm", "=q4=#aq40t6#, =ds=#r2#" },
		{ 21356, "", "=q4=Genesis Trousers", "=q4=#aq40t7#, =ds=#r2#" },
		{ 21354, "", "=q4=Genesis Shoulderpads", "=q4=#aq40t1#, =ds=#r1#" },
		{ 21355, "", "=q4=Genesis Boots", "=q4=#aq40t1#, =ds=#r1#" },
		{ 0,"","","" },
		{ 0, "Ability_Hunter_RunningShot", "=q6=#aq40s2#", "=ec1=#c2#" },
		{ 21370, "", "=q4=Striker's Hauberk", "=q4=#aq40t8#, =ds=#r3#" },
		{ 21366, "", "=q4=Striker's Diadem", "=q4=#aq40t6#, =ds=#r2#" },
		{ 21368, "", "=q4=Striker's Leggings", "=q4=#aq40t7#, =ds=#r2#" },
		{ 21367, "", "=q4=Striker's Pauldrons", "=q4=#aq40t5#, =ds=#r1#" },
		{ 21365, "", "=q4=Striker's Footguards", "=q4=#aq40t5#, =ds=#r1#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_Frost_IceStorm", "=q6=#aq40s3#", "=ec1=#c3#" },
		{ 21343, "", "=q4=Enigma Robes", "=q4=#aq40t4#, =ds=#r3#" },
		{ 21347, "", "=q4=Enigma Circlet", "=q4=#aq40t2#, =ds=#r2#" },
		{ 21346, "", "=q4=Enigma Leggings", "=q4=#aq40t3#, =ds=#r2#" },
		{ 21345, "", "=q4=Enigma Shoulderpads", "=q4=#aq40t1#, =ds=#r1#" },
		{ 21344, "", "=q4=Enigma Boots", "=q4=#aq40t1#, =ds=#r1#" },
		{ 0,"","","" },
		{ 0, "Spell_Holy_SealOfMight", "=q6=#aq40s4#", "=ec1=#c4#" },
		{ 21389, "", "=q4=Avenger's Breastplate", "=q4=#aq40t8#, =ds=#r3#" },
		{ 21387, "", "=q4=Avenger's Crown", "=q4=#aq40t6#, =ds=#r2#" },
		{ 21390, "", "=q4=Avenger's Legguards", "=q4=#aq40t7#, =ds=#r2#" },
		{ 21391, "", "=q4=Avenger's Pauldrons", "=q4=#aq40t1#, =ds=#r1#" },
		{ 21388, "", "=q4=Avenger's Greaves", "=q4=#aq40t1#, =ds=#r1#" },
	};

	AQ40Sets2 = {
		{ 0, "Spell_Holy_PowerWordShield", "=q6=#aq40s5#", "=ec1=#c5#" },
		{ 21351, "", "=q4=Vestments of the Oracle", "=q4=#aq40t4#, =ds=#r3#" },
		{ 21348, "", "=q4=Tiara of the Oracle", "=q4=#aq40t2#, =ds=#r2#" },
		{ 21352, "", "=q4=Trousers of the Oracle","=q4=#aq40t3#, =ds=#r2#" },
		{ 21350, "", "=q4=Mantle of the Oracle", "=q4=#aq40t5#, =ds=#r1#" },
		{ 21349, "", "=q4=Footwraps of the Oracle", "=q4=#aq40t5#, =ds=#r1#" },
		{ 0,"","","" },
		{ 0, "Ability_BackStab", "=q6=#aq40s6#", "=ec1=#c6#" },
		{ 21364, "", "=q4=Deathdealer's Vest", "=q4=#aq40t8#, =ds=#r3#" },
		{ 21360, "", "=q4=Deathdealer's Helm", "=q4=#aq40t6#, =ds=#r2#" },
		{ 21362, "", "=q4=Deathdealer's Leggings", "=q4=#aq40t3#, =ds=#r2#" },
		{ 21361, "", "=q4=Deathdealer's Spaulders", "=q4=#aq40t5#, =ds=#r1#" },
		{ 21359, "", "=q4=Deathdealer's Boots", "=q4=#aq40t5#, =ds=#r1#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "Spell_FireResistanceTotem_01", "=q6=#aq40s7#", "=ec1=#c7#" },
		{ 21374, "", "=q4=Stormcaller's Hauberk", "=q4=#aq40t8#, =ds=#r3#" },
		{ 21372, "", "=q4=Stormcaller's Diadem", "=q4=#aq40t6#, =ds=#r2#" },
		{ 21375, "", "=q4=Stormcaller's Leggings", "=q4=#aq40t7#, =ds=#r2#" },
		{ 21376, "", "=q4=Stormcaller's Pauldrons", "=q4=#aq40t1#, =ds=#r1#" },
		{ 21373, "", "=q4=Stormcaller's Footguards", "=q4=#aq40t1#, =ds=#r1#" },
		{ 0,"","","" },
		{ 0, "Spell_Shadow_CurseOfTounges", "=q6=#aq40s8#", "=ec1=#c8#" },
		{ 21334, "", "=q4=Doomcaller's Robes", "=q4=#aq40t4#, =ds=#r3#" },
		{ 21337, "", "=q4=Doomcaller's Circlet", "=q4=#aq40t2#, =ds=#r2#" },
		{ 21336, "", "=q4=Doomcaller's Trousers", "=q4=#aq40t7#, =ds=#r2#" },
		{ 21335, "", "=q4=Doomcaller's Mantle", "=q4=#aq40t1#, =ds=#r1#" },
		{ 21338, "", "=q4=Doomcaller's Footwraps", "=q4=#aq40t1#, =ds=#r1#" },
	};
	
	AQ40Sets3 = {
		{ 0, "INV_Shield_05", "=q6=#aq40s9#", "=ec1=#c9#" },
		{ 21331, "", "=q4=Conqueror's Breastplate", "=q4=#aq40t8#, =ds=#r3#" },
		{ 21329, "", "=q4=Conqueror's Crown", "=q4=#aq40t2#, =ds=#r2#" },
		{ 21332, "", "=q4=Conqueror's Legguards", "=q4=#aq40t3#, =ds=#r2#" },
		{ 21330, "", "=q4=Conqueror's Spaulders", "=q4=#aq40t5#, =ds=#r1#" },
		{ 21333, "", "=q4=Conqueror's Greaves", "=q4=#aq40t5#, =ds=#r1#" },
	};

-----------------------
--- Legendary Items ---
-----------------------

	Legendaries = {
		{ 22736, "", "=q5=Andonisus, Reaper of Souls", "=q1=#m26#: =ds=#h3#, #w10#" },
		{ 19019, "", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=ds=#h1#, #w10#" },
		{ 17182, "", "=q5=Sulfuras, Hand of Ragnaros", "=ds=#h2#, #w6#" },
		{ 21176, "", "=q5=Black Qiraji Resonating Crystal", "=ds=#e12#" },
		{ 22632, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c1#"},
		{ 22589, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c3#"},
		{ 22631, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c5#"},
		{ 22630, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c8#"},
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 30312, "", "=q5=Infinity Blade", "=q1=#m26#: =ds=#h1#, #w4#" },
		{ 30311, "", "=q5=Warp Slicer", "=q1=#m26#: =ds=#h1#, #w10#" },
		{ 30317, "", "=q5=Cosmic Infuser", "=q1=#m26#: =ds=#h3#, #w6#" },
		{ 30316, "", "=q5=Devastation", "=q1=#m26#: =ds=#h2#, #w1#" },
		{ 30313, "", "=q5=Staff of Disintegration", "=q1=#m26#: =ds=#w9#" },
		{ 30314, "", "=q5=Phaseshift Bulwark", "=q1=#m26#: =ds=#w8#" },
		{ 30318, "", "=q5=Netherstrand Longbow", "=q1=#m26#: =ds=#w2#, =q1=#m1# =ds=#c2#" },
		{ 30319, "", "=q5=Nether Spike", "=q1=#m26#: =ds=#w17#" },
	};
	
-----------------------
--- GM Items ---
-----------------------

	GMItems = {
		{ 12947, "", "=q6=Alex's Ring of Audacity", "#s13#" },	
		{ 18582, "", "=q6=The Twin Blades of Azzinoth", "#h1#, #w10#" },	
		{ 18584, "", "=q6=Warglaive of Azzinoth (Left)", "#h1#, #w10#" },
		{ 18583, "", "=q6=Warglaive of Azzinoth (Right)", "#h1#, #w10#" },		
		{ 0,"","","" },
		{ 17782, "", "=q5=Talisman of Binding Shard", "#s2#" },
		{ 13262, "", "=q5=Ashbringer", "=ds=#h2#, #w10#" },
		{ 23051, "", "=q5=Glaive of the Defender", "#w10#" },
		{ 17142, "", "=q5=Shard of the Defiler", "#h1#, #w4#" },
	};

---------------------------------
--- Heroic Mode Token Rewards ---
---------------------------------

	HardModeResist = {
		{ 0, "INV_Box_01", "=q6=#a1#", "" },
		{ 30762, "", "=q4=Infernoweave Robe", "=ds=#a1#, #s5#", "30 #heroic#" },
		{ 30764, "", "=q4=Infernoweave Gloves", "=ds=#a1#, #s9#", "20 #heroic#" },
		{ 30761, "", "=q4=Infernoweave Leggings", "=ds=#a1#, #s11#", "30 #heroic#" },
		{ 30763, "", "=q4=Infernoweave Boots", "=ds=#a1#, #s12#", "20 #heroic#" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#a2#", "" },
		{ 30776, "", "=q4=Inferno Hardened Chestguard", "=ds=#a2#, #s5#", "30 #heroic#" },
		{ 30780, "", "=q4=Inferno Hardened Gloves", "=ds=#a2#, #s9#", "20 #heroic#" },
		{ 30778, "", "=q4=Inferno Hardened Leggings", "=ds=#a2#, #s11#", "30 #heroic#" },
		{ 30779, "", "=q4=Inferno Hardened Boots", "=ds=#a2#, #s12#", "20 #heroic#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#a3#", "" },
		{ 30773, "", "=q4=Inferno Forged Hauberk", "=ds=#a3#, #s5#", "30 #heroic#" },
		{ 30774, "", "=q4=Inferno Forged Gloves", "=ds=#a3#, #s9#", "20 #heroic#" },
		{ 30772, "", "=q4=Inferno Forged Leggings", "=ds=#a3#, #s11#", "30 #heroic#" },
		{ 30770, "", "=q4=Inferno Forged Boots", "=ds=#a3#, #s12#", "20 #heroic#" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#a4#", "" },
		{ 30769, "", "=q4=Inferno Tempered Chestguard", "=ds=#a4#, #s5#", "30 #heroic#" },
		{ 30767, "", "=q4=Inferno Tempered Gauntlets", "=ds=#a4#, #s9#", "20 #heroic#" },
		{ 30766, "", "=q4=Inferno Tempered Leggings", "=ds=#a4#, #s11#", "30 #heroic#" },
		{ 30768, "", "=q4=Inferno Tempered Boots", "=ds=#a4#, #s12#", "20 #heroic#" },
	};

	HardModeCloth = {

	};

	HardModeLeather = {

	};
		
	HardModeLeather2 = {

	};

	HardModeMail = {

	};

	HardModePlate = {

	};
		
	HardModePlate2 = {

	};

	HardModeCloaks = {
		{ 29375, "", "=q4=Bishop's Cloak", "=ds=#s4#", "25 #heroic#" },
		{ 29382, "", "=q4=Blood Knight War Cloak", "=ds=#s4#", "25 #heroic#" },
		{ 29385, "", "=q4=Farstrider Defender's Cloak", "=ds=#s4#", "25 #heroic#" },
		{ 29369, "", "=q4=Shawl of Shifting Probabilities", "=ds=#s4#", "25 #heroic#" },
	};

	HardModeRelic = {
		{ 29390, "", "=q4=Everbloom Idol", "=ds=#s16#, #w14#", "15 #heroic#" },
		{ 29389, "", "=q4=Totem of the Pulsing Earth", "=ds=#s16#, #w15#", "15 #heroic#" },
		{ 29388, "", "=q4=Libram of Repentance", "=ds=#s16#, #w16#", "15 #heroic#" },
	};

	HardModeAccessories = {
		{ 0, "INV_Box_01", "=q6=#n138#", "" },
		{ 29381, "", "=q4=Choker of Vile Intent", "=ds=#s2#", "25 #heroic#" },
		{ 29374, "", "=q4=Necklace of Eternal Hope", "=ds=#s2#", "25 #heroic#" },
		{ 29386, "", "=q4=Necklace of the Juggernaut", "=ds=#s2#", "25 #heroic#" },
		{ 29368, "", "=q4=Manasurge Pendant", "=ds=#s2#", "25 #heroic#" },
		{ 29373, "", "=q4=Band of Halos", "=ds=#s13#", "25 #heroic#" },
		{ 29379, "", "=q4=Ring of Arathi Warlords", "=ds=#s13#", "25 #heroic#" },
		{ 29367, "", "=q4=Ring of Cryptic Dreams", "=ds=#s13#", "25 #heroic#" },
		{ 29384, "", "=q4=Ring of Unyielding Force", "=ds=#s13#", "25 #heroic#" },
		{ 0,"","","" },
		{ 29383, "", "=q4=Bloodlust Brooch", "=ds=#s14#", "41 #heroic#" },
		{ 29376, "", "=q4=Essence of the Martyr", "=ds=#s14#", "41 #heroic#" },
		{ 29387, "", "=q4=Gnomeregan Auto-Blocker 600", "=ds=#s14#", "41 #heroic#" },
		{ 29370, "", "=q4=Icon of the Silver Crescent", "=ds=#s14#", "41 #heroic#" },
	};
		
	HardModeAccessories2 = {
	};

	HardModeWeapons = {
		{ 29275, "", "=q4=Searing Sunblade", "=ds=#h4# #w4#", "50 #heroic#" },
		{ 29268, "", "=q4=Mazthoril Honor Shield", "=ds=#w8#", "33 #heroic#" },
		{ 29267, "", "=q4=Light-Bearer's Faith Shield", "=ds=#w8#", "33 #heroic#" },
		{ 29266, "", "=q4=Azure-Shield of Coldarra", "=ds=#w8#", "33 #heroic#" },
		{ 29270, "", "=q4=Flametounge Seal", "=ds=#s15#", "25 #heroic#" },
		{ 29273, "", "=q4=Khadgar's Knapsack", "=ds=#s15#", "25 #heroic#" },
		{ 29272, "", "=q4=Orb of the Soul-Eater", "=ds=#s15#", "25 #heroic#" },
		{ 29269, "", "=q4=Sapphiron's Wing Bone", "=ds=#s15#", "25 #heroic#" },
		{ 29271, "", "=q4=Talisman of Kalecgos", "=ds=#s15#", "25 #heroic#" },
		{ 29274, "", "=q4=Tears of Heaven", "=ds=#s15#", "25 #heroic#" },
	};
	
	HardModeArena = {
		{ 32811, "", "=q4=Veteran's Dreadweave Cuffs", "=ds=#s8#, #a1#", "25 #heroic#" },
		{ 32799, "", "=q4=Veteran's Dreadweave Belt", "=ds=#s10#, #a1#", "40 #heroic#" },
		{ 32787, "", "=q4=Veteran's Dreadweave Stalkers", "=ds=#s12#, #a1#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32980, "", "=q4=Veteran's Mooncloth Cuffs", "=ds=#s8#, #a1#", "25 #heroic#" },
		{ 32979, "", "=q4=Veteran's Mooncloth Belt", "=ds=#s10#, #a1#", "40 #heroic#" },
		{ 32981, "", "=q4=Veteran's Mooncloth Slippers", "=ds=#s12#, #a1#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32820, "", "=q4=Veteran's Silk Cuffs", "=ds=#s8#, #a1#", "25 #heroic#" },
		{ 32807, "", "=q4=Veteran's Silk Belt", "=ds=#s10#, #a1#", "40 #heroic#" },
		{ 32795, "", "=q4=Veteran's Silk Footguards", "=ds=#s12#, #a1#", "40 #heroic#" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 32810, "", "=q4=Veteran's Dragonhide Bracers", "=ds=#s8#, #a2#", "25 #heroic#" },
		{ 32798, "", "=q4=Veteran's Dragonhide Belt", "=ds=#s10#, #a2#", "40 #heroic#" },
		{ 32786, "", "=q4=Veteran's Dragonhide Boots", "=ds=#s12#, #a2#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32812, "", "=q4=Veteran's Kodohide Bracers", "=ds=#s8#, #a2#", "25 #heroic#" },
		{ 32800, "", "=q4=Veteran's Kodohide Belt", "=ds=#s10#, #a2#", "40 #heroic#" },
		{ 32788, "", "=q4=Veteran's Kodohide Boots", "=ds=#s12#, #a2#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32814, "", "=q4=Veteran's Leather Bracers", "=ds=#s8#, #a2#", "25 #heroic#" },
		{ 32801, "", "=q4=Veteran's Leather Belt", "=ds=#s10#, #a2#", "40 #heroic#" },
		{ 32790, "", "=q4=Veteran's Leather Boots", "=ds=#s12#, #a2#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32821, "", "=q4=Veteran's Wyrmhide Bracers", "=ds=#s8#, #a2#", "25 #heroic#" },
		{ 32808, "", "=q4=Veteran's Wyrmhide Belt", "=ds=#s10#, #a2#", "40 #heroic#" },
		{ 32796, "", "=q4=Veteran's Wyrmhide Boots", "=ds=#s12#, #a2#", "40 #heroic#" },
	};

	HardModeArena2 = {
		{ 32809, "", "=q4=Veteran's Chain Bracers", "=ds=#s8#, #a3#", "25 #heroic#" },
		{ 32797, "", "=q4=Veteran's Chain Girdle", "=ds=#s10#, #a3#", "40 #heroic#" },
		{ 32785, "", "=q4=Veteran's Chain Sabatons", "=ds=#s12#, #a3#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32816, "", "=q4=Veteran's Linked Bracers", "=ds=#s8#, #a3#", "25 #heroic#" },
		{ 32803, "", "=q4=Veteran's Linked Girdle", "=ds=#s10#, #a3#", "40 #heroic#" },
		{ 32791, "", "=q4=Veteran's Linked Sabatons", "=ds=#s12#, #a3#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32817, "", "=q4=Veteran's Mail Bracers", "=ds=#s8#, #a3#", "25 #heroic#" },
		{ 32804, "", "=q4=Veteran's Mail Girdle", "=ds=#s10#, #a3#", "40 #heroic#" },
		{ 32792, "", "=q4=Veteran's Mail Sabatons", "=ds=#s12#, #a3#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32997, "", "=q4=Veteran's Ringmail Bracers", "=ds=#s8#, #a3#", "25 #heroic#" },
		{ 32998, "", "=q4=Veteran's Ringmail Girdle", "=ds=#s10#, #a3#", "40 #heroic#" },
		{ 32999, "", "=q4=Veteran's Ringmail Sabatons", "=ds=#s12#, #a3#", "40 #heroic#" },
		{ 32813, "", "=q4=Veteran's Lamellar Bracers", "=ds=#s8#, #a4#", "25 #heroic#" },
		{ 32801, "", "=q4=Veteran's Lamellar Belt", "=ds=#s10#, #a4#", "40 #heroic#" },
		{ 32789, "", "=q4=Veteran's Lamellar Greaves", "=ds=#s12#, #a4#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32989, "", "=q4=Veteran's Ornamented Bracers", "=ds=#s8#, #a4#", "25 #heroic#" },
		{ 32988, "", "=q4=Veteran's Ornamented Belt", "=ds=#s10#, #a4#", "40 #heroic#" },
		{ 32990, "", "=q4=Veteran's Ornamented Greaves", "=ds=#s12#, #a4#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32818, "", "=q4=Veteran's Plate Bracers", "=ds=#s8#, #a4#", "25 #heroic#" },
		{ 32805, "", "=q4=Veteran's Plate Belt", "=ds=#s10#, #a4#", "40 #heroic#" },
		{ 32793, "", "=q4=Veteran's Plate Greaves", "=ds=#s12#, #a4#", "40 #heroic#" },
		{ 0,"","","" },
		{ 32819, "", "=q4=Veteran's Scaled Bracers", "=ds=#s8#, #a4#", "25 #heroic#" },
		{ 32806, "", "=q4=Veteran's Scaled Belt", "=ds=#s10#, #a4#, #a4#", "40 #heroic#" },
		{ 32794, "", "=q4=Veteran's Scaled Greaves", "=ds=#s12#, #a4#", "40 #heroic#" },
	};

-------------------
--- Rare Mounts ---
-------------------

	RareMounts1 = {
		{ 21176, "", "=q5=Black Qiraji Resonating Crystal", "=q2=#m4#" },
		{ 0,"","","" },
		{ 30480, "", "=q4=Fiery Warhorse's Reins", "=q2=#n53#, =q1=#z12#" },
		{ 13335, "", "=q4=Deathcharger's Reins", "=q2=#n52#, =q1=#z6#", "0.10%" },
		{ 19872, "", "=q4=Swift Razzashi Raptor",   "=q2=#n33#, =q1=#z8#", "0.43%" },
		{ 19902, "", "=q4=Swift Zulian Tiger", "=q2=#n28#, =q1=#z8#", " 0.70%" },
		{ 13086, "", "=q4=Reins of the Winterspring Frostsaber", "=ds=#e12#" },
		{ 23720, "", "=q4=Riding Turtle", "=q2=#m24#" },
		{ 0,"","","" },
		{ 21218, "", "=q3=Blue Qiraji Resonating Crystal", "=q2=#n11#,  =q1=#z11#", "10.91%" },
		{ 21323, "", "=q3=Green Qiraji Resonating Crystal", "=q2=#n11#,  =q1=#z11#", "11.77%" },
		{ 21321, "", "=q3=Red Qiraji Resonating Crystal", "=q2=#n11#,  =q1=#z11#", "1.32%" },
		{ 21324, "", "=q3=Yellow Qiraji Resonating Crystal", "=q2=#n11#,  =q1=#z11#", "12.64%" },
	};
	
	RareMounts2 = {
	};

---------------
--- Tabards ---
---------------

	Tabards1 = {
		{ 23705, "", "=q4=Tabard of Flame", "=ds=#s7#, =q1=#m24#" },
		{ 23709, "", "=q4=Tabard of Frost", "=ds=#s7#, =q1=#m24#" },
		{ 31404, "", "=q2=Green Trophy Tabard of the Illidari", "=ds=#s7#, =q1=#m4#" },
		{ 31405, "", "=q2=Purple Trophy Tabard of the Illidari", "=ds=#s7#, =q1=#m4#" },
		{ 23192, "", "=q2=Tabard of the Scarlet Crusade", "=ds=#s7#", "0.48%" },
		{ 24344, "", "=q1=Tabard of the Hand", "=ds=#s7#, =q1=#m4#, =ec1=#m7#" },
		{ 22999, "", "=q1=Tabard of the Agent Dawn", "=ds=#s7#, =q1=#m4#" },
		{ 28788, "", "=q1=Tabard of the Protector", "=ds=#s7#, =q1=#m4#" },
		{ 19160, "", "=q1=Contest Winner's Tabard", "=ds=#s7#" },
		{ 25549, "", "=q1=Blood Knight Tabard", "=ds=#s7#, =ec1=#m6#" },
		{ 31779, "", "=q1=Aldor Tabard", "=ds=#s7#" },
		{ 31804, "", "=q1=Cenarion Expedition Tabard", "=ds=#s7#" },
		{ 31776, "", "=q1=Consortium Tabard", "=ds=#s7#" },
		{ 23999, "", "=q1=Honor Hold Tabard", "=ds=#s7#, =ec1=#m7#" },
		{ 31777, "", "=q1=Keepers of Time Tabard", "=ds=#s7#" },
		{ 31774, "", "=q1=Kurenai Tabard", "=ds=#s7#, =ec1=#m7#" },
		{ 31778, "", "=q1=Lower City Tabard", "=ds=#s7#" },
		{ 31773, "", "=q1=Mag'har Tabard", "=ds=#s7#, =ec1=#m6#" },
		{ 31781, "", "=q1=Sha'tar Tabard", "=ds=#s7#" },
		{ 31780, "", "=q1=Scryers Tabard", "=ds=#s7#" },
		{ 24004, "", "=q1=Thrallmar Tabard", "=ds=#s7#, =ec1=#m6#" },
	};

	Tabards2 = {
		{ 0, "INV_BannerPVP_01", "=q6=#m6#", "" },
		{ 15197, "", "=q1=Scout's Tabard", "=ds=#s7#" },
		{ 15199, "", "=q1=Stone Guard's Herald", "=ds=#s7#" },
		{ 20131, "", "=q1=Battle Tabard of the Defilers", "=ds=#s7#, =q1=#m4#" },
		{ 19031, "", "=q1=Frostwolf Battle Tabard", "=ds=#s7#" },
		{ 19505, "", "=q1=Warsong Battle Tabard", "=ds=#s7#" },
		{ 0,"","","" },
		{ 0, "INV_BannerPVP_02", "=q6=#m7#", "" },
		{ 15196, "", "=q1=Private's Tabard", "=ds=#s7#" },
		{ 15198, "", "=q1=Knight's Colors", "=ds=#s7#" }, 
		{ 20132, "", "=q1=Arathor Battle Tabard", "=ds=#s7#, =q1=#m4#" },
		{ 19032, "", "=q1=Stormpike Battle Tabard", "=ds=#s7#" },
		{ 19506, "", "=q1=Silverwing Battle Tabard", "=ds=#s7#" },
	};

-----------------------
--- Card Game Items ---
-----------------------

	CardGame1 = {
		{ 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud2#" },
		{ 32588, "", "=q3=Banana Charm", "=ds=#ud9#" },
		{ 32566, "", "=q3=Picnic Basket", "=ds=#ud10#" },
		{ 32542, "", "=q3=Imp in a Ball", "=ds=#ud11#" },
		{ 0,"","","" },
		{ 0, "INV_Box_01", "=q6=#ud4#", "=q1=#ud1#" },
		{ 23705, "", "=q4=Tabard of Flame", "=ds=#ud6#" },
		{ 23713, "", "=q4=Hippogryph Hatchling", "=ds=#ud7#" },
		{ 23720, "", "=q4=Riding Turtle", "=ds=#ud8#" },
	};
	
	CardGame2 = {
	
	};

-----------------------
--- BoE World Epics ---
-----------------------

	WorldEpics1 = {
		{ 867, "", "=q4=Gloves of Holy Might", "=ds=#s9#, #a2#", "" },
		{ 1981, "", "=q4=Icemail Jerkin", "=ds=#s5#, #a3#", "" },
		{ 1980, "", "=q4=Underworld Band", "=ds=#s13#", "" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 869, "", "=q4=Dazzling Longsword", "=ds=#h3#, #w10#", "" },
		{ 1982, "", "=q4=Nightblade", "=ds=#h2#, #w10#", "" },
		{ 870, "", "=q4=Fiery War Axe", "=ds=#h2#, #w1#", "" },
		{ 868, "", "=q4=Ardent Custodian", "=ds=#h3#, #w6#", "" },
		{ 873, "", "=q4=Staff of Jordan", "=ds=#w9#", "" },
		{ 1204, "", "=q4=The Green Tower", "=ds=#w8#", "" },
		{ 2825, "", "=q4=Bow of Searing Arrows", "=ds=#w2#", "" },
	};

	WorldEpics2 = {
		{ 3075, "", "=q4=Eye of Flame", "=ds=#s1#, #a1#", "" },
		{ 940, "", "=q4=Robes of Insight", "=ds=#s5#, #a1#", "" },
		{ 14551, "", "=q4=Edgemaster's Handguards", "=ds=#s9#, #a3#", "" },
		{ 17007, "", "=q4=Stonerender Gauntlets", "=ds=#s9#, #a3#", "" },
		{ 14549, "", "=q4=Boots of Avoidance", "=ds=#s12#, #a4#", "" },
		{ 1315, "", "=q4=Lei of Lilies", "=ds=#s2#", "" },
		{ 942, "", "=q4=Freezing Band", "=ds=#s13#", "" },
		{ 1447, "", "=q4=Ring of Saviors", "=ds=#s13#", "" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 2164, "", "=q4=Gut Ripper", "=ds=#h1#, #w4#", "" },
		{ 2163, "", "=q4=Shadowblade", "=ds=#h1#, #w4#", "" },
		{ 809, "", "=q4=Bloodrazor", "=ds=#h3#, #w10#", "" },
		{ 871, "", "=q4=Flurry Axe", "=ds=#h1#, #w1#", "" },
		{ 2291, "", "=q4=Kang the Decapitator", "=ds=#h2#, #w1#", "" },
		{ 810, "", "=q4=Hammer of the Northern Wind", "=ds=#h3#, #w6#", "" },
		{ 2915, "", "=q4=Taran Icebreaker", "=ds=#h2#, #w6#", "" },
		{ 812, "", "=q4=Glowing Brightwood Staff", "=ds=#w9#", "" },
		{ 943, "", "=q4=Warden Staff", "=ds=#w9#", "" },
		{ 1169, "", "=q4=Blackskull Shield", "=ds=#w8#", "" },
		{ 1979, "", "=q4=Wall of the Dead", "=ds=#w8#", "" },
		{ 2824, "", "=q4=Hurricane", "=ds=#w2#", "" },
		{ 2100, "", "=q4=Precisely Calibrated Boomstick", "=ds=#w5#", "" },
	};

	WorldEpics3 = {
		{ 3475, "", "=q4=Cloak of Flames", "=ds=#s4#", "" },
		{ 14553, "", "=q4=Sash of Mercy", "=ds=#s10#, #a2#", "" },
		{ 2245, "", "=q4=Helm of Narv", "=ds=#s1#, #a3#", "" },
		{ 14552, "", "=q4=Stockade Pauldrons", "=ds=#s3#, #a4#", "" },
		{ 14554, "", "=q4=Cloudkeeper Legplates", "=ds=#s11#, #a4#", "" },
		{ 1443, "", "=q4=Jeweled Amulet of Cainwyn", "=ds=#s2#", "" },
		{ 14558, "", "=q4=Lady Maye's Pendant", "=ds=#s2#", "" },
		{ 2246, "", "=q4=Myrmidon's Signet", "=ds=#s13#", "" },
		{ 833, "", "=q4=Lifestone", "=ds=#s14#", "" },
		{ 14557, "", "=q4=The Lion Horn of Stormwind", "=ds=#s14#", "" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 1728, "", "=q4=Teebu's Blazing Longsword", "=ds=#h3#, #w10#", "" },
		{ 14555, "", "=q4=Alcor's Sunrazor", "=ds=#h1#, #w10#", "" },
		{ 2244, "", "=q4=Krol Blade", "=ds=#h1#, #w10#", "" },
		{ 2801, "", "=q4=Blade of Hanna", "=ds=#h2#, #w10#", "" },
		{ 647, "", "=q4=Destiny", "=ds=#h2#, #w10#", "" },
		{ 811, "", "=q4=Axe of the Deep Woods", "=ds=#h1#, #w1#", "" },
		{ 1263, "", "=q4=Brain Hacker", "=ds=#h2#, #w1#", "" },
		{ 2243, "", "=q4=Hand of Edward the Odd", "=ds=#h3#, #w6#", "" },
		{ 944, "", "=q4=Elemental Mage Staff", "=ds=#w9#", "" },
		{ 1168, "", "=q4=Skullflame Shield", "=ds=#w8#", "" },
		{ 2099, "", "=q4=Dwarven Hand Cannon", "=ds=#w5#", "" },
	};

	WorldEpics4 = {
		{ 31329, "", "=q4=Lifegiving Cloak", "=ds=#s4#", "" },
		{ 31340, "", "=q4=Will of Edward the Odd", "=ds=#s5#, #a1#", "" },
		{ 31343, "", "=q4=Kamaei's Cerulean Skirt", "=ds=#s11#, #a1#", "" },
		{ 31333, "", "=q4=The Night Watchman", "=ds=#s1#, #a2#", "" },
		{ 31330, "", "=q4=Lightning Crown", "=ds=#s1#, #a3#", "" },
		{ 31328, "", "=q4=Leggings of Beast Mastery", "=ds=#s11#, #a3#", "" },
		{ 31335, "", "=q4=Pants of Living Growth", "=ds=#s11#, #a3#", "" },
		{ 31320, "", "=q4=Chestguard of Exile", "=ds=#s5#, #a4#", "" },
		{ 31338, "", "=q4=Charlotte's Ivy", "=ds=#s2#", "" },
		{ 31321, "", "=q4=Choker of Repentance", "=ds=#s2#", "" },
		{ 31319, "", "=q4=Band of Impenetrable Defenses", "=ds=#s13#", "" },
		{ 31339, "", "=q4=Lola's Eve", "=ds=#s13#", "" },
		{ 31326, "", "=q4=Truestrike Ring", "=ds=#s13#", "" },
		{ 0,"","","" },
		{ 0,"","","" },
		{ 31331, "", "=q4=The Night Blade", "=ds=#h1#, #w4#", "" },
		{ 31336, "", "=q4=Blade of Wizardry", "=ds=#h3#, #w10#", "" },
		{ 31332, "", "=q4=Blinkstrike", "=ds=#h1#, #w10#", "" },
		{ 31318, "", "=q4=Singing Crystal Axe", "=ds=#h2#, #w1#", "" },
		{ 31342, "", "=q4=The Ancient Scepter of Sue-Min", "=ds=#h3#, #w6#", "" },
		{ 31322, "", "=q4=The Hammer of Destiny", "=ds=#h2#, #w6#", "" },
		{ 31334, "", "=q4=Staff of Natural Fury", "=ds=#w9#", "" },
		{ 31323, "", "=q4=Don Santos' Famous Hunting Rifle", "=ds=#w5#", "" },
	};

-----------------------------
--- Blizzard Collectables ---
-----------------------------

	BlizzardCollectables1 = {
		{ 33079, "", "=q3=Murloc Costume", "=ds=" },
		{ 30360, "", "=q3=Lurky's Egg", "=ds=#e13#" },
		{ 20371, "", "=q3=Blue Murloc Egg", "=ds=#e13#" },
		{ 22114, "", "=q3=Pink Murloc Egg", "=ds=#e13#" },
		{ 13583, "", "=q3=Panda Collar", "=ds=#e13#" },
		{ 13584, "", "=q3=Diablo Stone", "=ds=#e13#" },
		{ 13582, "", "=q3=Zergling Leash", "=ds=#e13#" },
		{ 25535, "", "=q3=Netherwhelp's Collar", "=ds=#e13#" },
		{ 39656, "", "=q3=Tyrael's Hilt", "=ds=#e13#" },
	};

	};
