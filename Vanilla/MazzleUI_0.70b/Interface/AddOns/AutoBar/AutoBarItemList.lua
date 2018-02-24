--
-- AutoBar
-- Item List Database
--
-- Maintained by Azethoth / Toadkiller of Proudmoore.  Original author Saien of Hyjal
-- http://www.wowace.com/wiki/AutoBar
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

AutoBarItemList = {};

local L = AceLibrary("AceLocale-2.2"):new("AutoBar");
local PT = PeriodicTableEmbed:GetInstance("1");


local function sortList(a, b)
	return a[2] < b[2];
end

-- Get set as a simple array of itemIds, ordered by their value in the set
function AutoBarItemList:GetSetItemsArray(set)
	local retval = {};
	local cacheSet = PT:GetSetTable(set);
	if (cacheSet) then
		local sortedList = {};
		local index = 1;
		for itemId, value in pairs(cacheSet) do
			sortedList[index] = { itemId, value };
			index = index + 1;
		end
		table.sort(sortedList, sortList);
		for i, j in ipairs(sortedList) do
			retval[i] = j[1];
		end
	end
	return retval;
end


function AutoBarItemList:OnInitialize()
	-- Ok, step 1 is to start getting the raw data from PeriodicTable.  Later we can use more of its functionality.
	AutoBar_Category_Info["ANTI_VENOM"]["items"] = self:GetSetItemsArray("antivenom");
	AutoBar_Category_Info["ARROWS"]["items"] = self:GetSetItemsArray("ammoarrows");
	AutoBar_Category_Info["BULLETS"]["items"] = self:GetSetItemsArray("ammobullets");
	AutoBar_Category_Info["THROWN"]["items"] = self:GetSetItemsArray("ammothrown");
	AutoBar_Category_Info["BANDAGES"]["items"] = self:GetSetItemsArray("bandagesgeneral");
	AutoBar_Category_Info["ALTERAC_BANDAGES"]["items"] = self:GetSetItemsArray("bandagesalterac");
	AutoBar_Category_Info["ARATHI_BANDAGES"]["items"] = self:GetSetItemsArray("bandagesarathi");
	AutoBar_Category_Info["WARSONG_BANDAGES"]["items"] = self:GetSetItemsArray("bandageswarsong");
	AutoBar_Category_Info["EXPLOSIVES"]["items"] = self:GetSetItemsArray("explosives");
	AutoBar_Category_Info["FISHING_LURES"]["items"] = self:GetSetItemsArray("fishinglures");
	AutoBar_Category_Info["FISHING_GEAR"]["items"] = self:GetSetItemsArray("fishinggear");
	AutoBar_Category_Info["FISHING_POLES"]["items"] = self:GetSetItemsArray("fishingpoles");
	AutoBar_Category_Info["FOOD_PERCENT"]["items"] = self:GetSetItemsArray("foodperc");
	AutoBar_Category_Info["FOOD_PERCENT_BONUS"]["items"] = self:GetSetItemsArray("foodpercbonus");
	AutoBar_Category_Info["FOOD_PERCENT_COMBO"]["items"] = self:GetSetItemsArray("foodcomboperc");
	AutoBar_Category_Info["FOOD_PET_CHEESE"]["items"] = self:GetSetItemsArray("foodcheese");
	AutoBar_Category_Info["HEALPOTIONS"]["items"] = self:GetSetItemsArray("potionheal");
	AutoBar_Category_Info["ALTERAC_HEAL"]["items"] = self:GetSetItemsArray("potionhealalterac");
	AutoBar_Category_Info["HEALTHSTONE"]["items"] = self:GetSetItemsArray("healthstone");
	AutoBar_Category_Info["MINI_PET"]["items"] = self:GetSetItemsArray("minipet");
	AutoBar_Category_Info["MINI_PET_HOLIDAY"]["items"] = self:GetSetItemsArray("minipetholiday");
	AutoBar_Category_Info["MOUNTS"]["items"] = self:GetSetItemsArray("mounts");
	AutoBar_Category_Info["MOUNTS_QIRAJI"]["items"] = self:GetSetItemsArray("mountsaq");
	AutoBar_Category_Info["MANAPOTIONS"]["items"] = self:GetSetItemsArray("potionmana");
	AutoBar_Category_Info["MANASTONE"]["items"] = self:GetSetItemsArray("manastone");
	AutoBar_Category_Info["OIL_MANA"]["items"] = self:GetSetItemsArray("oilmana");
	AutoBar_Category_Info["OIL_WIZARD"]["items"] = self:GetSetItemsArray("oilwizard");
	AutoBar_Category_Info["POISON-CRIPPLING"]["items"] = self:GetSetItemsArray("poisoncrippling");
	AutoBar_Category_Info["POISON-DEADLY"]["items"] = self:GetSetItemsArray("poisondeadly");
	AutoBar_Category_Info["POISON-INSTANT"]["items"] = self:GetSetItemsArray("poisoninstant");
	AutoBar_Category_Info["POISON-MINDNUMBING"]["items"] = self:GetSetItemsArray("poisonmindnumbing");
	AutoBar_Category_Info["POISON-WOUND"]["items"] = self:GetSetItemsArray("poisonwound");
	AutoBar_Category_Info["RAGEPOTIONS"]["items"] = self:GetSetItemsArray("potionrage");
	AutoBar_Category_Info["SHARPENINGSTONES"]["items"] = self:GetSetItemsArray("sharpeningstones");
	AutoBar_Category_Info["WEIGHTSTONES"]["items"] = self:GetSetItemsArray("weightstones");
	AutoBar_Category_Info["WATER"]["items"] = self:GetSetItemsArray("water");
	AutoBar_Category_Info["WATER_CONJURED"]["items"] = self:GetSetItemsArray("waterconjured");
	AutoBar_Category_Info["WATER_PERCENT"]["items"] = self:GetSetItemsArray("waterperc");
	AutoBar_Category_Info["WATER_SPIRIT"]["items"] = self:GetSetItemsArray("waterspirit");
end
-- /script DEFAULT_CHAT_FRAME:AddMessage(tostring(AutoBar_Category_Info["FOOD_PERCENT"]["items"][3]))







AutoBar_Category_Info = { -- global
	["CUSTOM"] = {
		["description"] = AUTOBAR_CLASS_CUSTOM;
		["texture"] = "INV_Misc_Bandage_12",
		["custom"] = true;
		["items"] = { 19307 },
	},
	["MINI_PET"] = {
		["description"] = AUTOBAR_CLASS_MINI_PET;
		["texture"] = "Ability_Creature_Poison_05";
		["arrangeOnUse"] = true,
	},
	["MINI_PET_HOLIDAY"] = {
		["description"] = AUTOBAR_CLASS_MINI_PET_HOLIDAY;
		["texture"] = "INV_Misc_Bag_17";
		["arrangeOnUse"] = true,
	},
	["AAACLEAR"] = {
		["description"] = AUTOBAR_CLASS_CLEAR;
		["texture"] = "INV_Misc_Fork&Knife";
		["items"] = {},
	},
	["BANDAGES"] = {
		["description"] = AUTOBAR_CLASS_BANDAGES;
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["smarttarget"] = true;
	},
	["ALTERAC_BANDAGES"] = {
		["description"] = AUTOBAR_CLASS_ALTERAC_BANDAGE;
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["location"] = AUTOBAR_ALTERACVALLEY;
		["smarttarget"] = true;
	},
	["WARSONG_BANDAGES"] = {
		["description"] = AUTOBAR_CLASS_WARSONG_BANDAGE;
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["location"] = AUTOBAR_WARSONGGULCH;
		["smarttarget"] = true;
	},
	["ARATHI_BANDAGES"] = {
		["description"] = AUTOBAR_CLASS_ARATHI_BANDAGE;
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["location"] = AUTOBAR_ARATHIBASIN;
		["smarttarget"] = true;
	},
	["UNGORO_RESTORE"] = {
		["description"] = AUTOBAR_CLASS_UNGORORESTORE;
		["texture"] = "INV_Misc_Gem_Diamond_02";
		["combatonly"] = true;
		["targetted"] = true;
		["smarttarget"] = true;
		["limit"] = { ["downhp"] = { 670 } },
		["items"] = { 11562 },
	},
	["ANTI_VENOM"] = {
		["description"] = AUTOBAR_CLASS_ANTIVENOM;
		["texture"] = "INV_Drink_14";
		["targetted"] = true;
		["smarttarget"] = true;
	},
	----------------
	["POTION_AGILITY"] = {
		["texture"] = "INV_Potion_94",
		["description"] = AUTOBAR_CLASS_AGILITYPOTIONS,
		["items"] = {
			2457,	-- Elixir of Minor Agility		4		60
			3390,	-- Elixir of Lesser Agility		8		60
			8949,	-- Elixir of Agility			15		60
			9187,	-- Elixir of Greater Agility	25		60
			13452,	-- Elixir of the Mongoose		25		60 2% crit
		},
	},
	["POTION_STRENGTH"] = {
		["texture"] = "INV_Potion_61",
		["description"] = AUTOBAR_CLASS_STRENGTHPOTIONS,
		["items"] = {
			2457,	-- Elixir of Lion's Strength	4		60
			3391,	-- Elixir of Ogre's Strength	8		60
			6662,	-- Elixir of Giant Growth		8		60
			9206,	-- Elixir of Giants				25		60
			13453,	-- Elixir of Brute Force		18		60 18 sta
		},
	},
	["POTION_FORTITUDE"] = {
		["texture"] = "INV_Potion_43",
		["description"] = AUTOBAR_CLASS_FORTITUDEPOTIONS,
		["items"] = {
			2458,	-- Elixir of Minor Fortitude	27		60
			3825,	-- Elixir of Fortitude			120		60
		},
	},
	["POTION_INTELLECT"] = {
		["texture"] = "INV_Potion_10",
		["description"] = AUTOBAR_CLASS_INTELLECTPOTIONS,
		["items"] = {
			9179,	-- Elixir of Greater Intellect	25		60
			13447,	-- Elixir of the Sages			18		60 18 spi
		},
	},
	["POTION_WISDOM"] = {
		["texture"] = "INV_Potion_06",
		["description"] = AUTOBAR_CLASS_WISDOMPOTIONS,
		["items"] = {
			3383,	-- Elixir of Wisdom				6		60
		},
	},
	["POTION_DEFENSE"] = {
		["texture"] = "INV_Potion_66",
		["description"] = AUTOBAR_CLASS_DEFENSEPOTIONS,
		["items"] = {
			5997,	-- Elixir of Minor Defense		50		60
			3389,	-- Elixir of Defense			150		60
			8951,	-- Elixir of Greater Defense	250		60
			13445,	-- Elixir of Superior Defense	450		60
		},
	},
	["POTION_TROLL"] = {
		["texture"] = "INV_Potion_80",
		["description"] = AUTOBAR_CLASS_TROLLBLOODPOTIONS,
		["items"] = {
			3382,	-- Weak Troll's Blood Potion	2/5		60
			3388,	-- Strong Troll's Blood Potion	6/5		60
			3826,	-- Mighty Troll's Blood Potion	12/5	60
			20004,	-- Major Troll's Blood Potion	20/5	60
		},
	},
	----------------
	["SCROLL_AGILITY"] = {
		["texture"] = "INV_Scroll_02",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_SCROLLOFAGILITY,
		["items"] = {
			3012,	-- Scroll of Agility
			1477,	-- Scroll of Agility II
			4425,	-- Scroll of Agility III
			10309,	-- Scroll of Agility IV
		},
	},
	["SCROLL_INTELLECT"] = {
		["texture"] = "INV_Scroll_01",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_SCROLLOFINTELLECT,
		["items"] = {
			955,	-- Scroll of Intellect
			2290,	-- Scroll of Intellect II
			4419,	-- Scroll of Intellect III
			10308,	-- Scroll of Intellect IV
			12458,	-- Juju Guile				40
		},
	},
	["SCROLL_PROTECTION"] = {
		["texture"] = "INV_Scroll_07",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_SCROLLOFPROTECTION,
		["items"] = {
			3013,	-- Scroll of Protection
			1478,	-- Scroll of Protection II
			4421,	-- Scroll of Protection III
			10305,	-- Scroll of Protection IV
		},
	},
	["SCROLL_SPIRIT"] = {
		["texture"] = "INV_Scroll_01",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_SCROLLOFSPIRIT,
		["items"] = {
			1181,	-- Scroll of Spirit
			1712,	-- Scroll of Spirit II
			4424,	-- Scroll of Spirit III
			10306,	-- Scroll of Spirit IV
		},
	},
	["SCROLL_STAMINA"] = {
		["texture"] = "INV_Scroll_07",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_SCROLLOFSTAMINA,
		["items"] = {
			1180,	-- Scroll of Stamina
			1711,	-- Scroll of Stamina II
			4422,	-- Scroll of Stamina III
			10307,	-- Scroll of Stamina IV
		},
	},
	["SCROLL_STRENGTH"] = {
		["texture"] = "INV_Scroll_02",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_SCROLLOFSTRENGTH,
		["items"] = {
			954,	-- Scroll of Strength		5
			2289,	-- Scroll of Strength II	9
			4426,	-- Scroll of Strength III	13
			10310,	-- Scroll of Strength IV	17
			12451,	-- Juju Power				30
		},
	},
	["BUFF_ATTACKPOWER"] = {
		["texture"] = "INV_Misc_MonsterScales_07",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_BUFF_ATTACKPOWER,
		["items"] = {
			12820,	-- Winterfall Firewater		35	20m
			12460,	-- Juju Might				40	30m
		},
	},
	["BUFF_ATTACKSPEED"] = {
		["texture"] = "INV_Misc_MonsterScales_17",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_BUFF_ATTACKSPEED,
		["items"] = {
			12450,	-- Juju Flurry				3%	20s
		},
	},
	["BUFF_DODGE"] = {
		["texture"] = "INV_Misc_MonsterScales_17",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_BUFF_DODGE,
		["items"] = {
			12459,	-- Juju Escape				5%	10s
		},
	},
	["BUFF_FROST"] = {
		["texture"] = "INV_Misc_MonsterScales_09",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_BUFF_FROST,
		["items"] = {
			12457,	-- Juju Chill				15	10m
		},
	},
	["BUFF_FIRE"] = {
		["texture"] = "INV_Misc_MonsterScales_15",
		["targetted"] = true,
		["description"] = AUTOBAR_CLASS_BUFF_FIRE,
		["items"] = {
			12455,	-- Juju Ember				15	10m
		},
	},
	----------------
	["FISHING_LURES"] = {
		["texture"] = "INV_Misc_Food_26",
		["targetted"] = "WEAPON",
		["description"] = L["FISHING_LURES"],
	},
	["FISHING_GEAR"] = {
		["texture"] = "INV_Helmet_31",
		["description"] = L["FISHING_GEAR"],
	},
	["FISHING_POLES"] = {
		["texture"] = "INV_Fishingpole_01",
		["description"] = L["FISHING_POLES"],
	},
	----------------
	["HEALPOTIONS"] = {
		["description"] = AUTOBAR_CLASS_HEALPOTIONS;
		["texture"] = "INV_Potion_54";
		["limit"] = { ["downhp"] = { 70, 140, 140, 280, 455, 700, 800, 1050} },
	},
	["HEALTHSTONE"] = {
		["description"] = AUTOBAR_CLASS_HEALTHSTONE;
		["texture"] = "INV_Stone_04";
	},
	["WHIPPER_ROOT"] = {
		["description"] = AUTOBAR_CLASS_WHIPPER_ROOT;
		["texture"] = "INV_Misc_Food_55";
		["items"] = { 11951 },
		["limit"] = { ["downhp"] = { 700 } },
	},
	["ALTERAC_HEAL"] = {
		["description"] = AUTOBAR_CLASS_BATTLEGROUNDHEALPOTIONS;
		["texture"] = "INV_Potion_39";
		["battleground"] = true;
	},
	----------------
	["MANAPOTIONS"] = {
		["description"] = AUTOBAR_CLASS_MANAPOTIONS;
		["texture"] = "INV_Potion_76";
		["limit"] = { ["downmana"] = { 140, 280, 455, 700, 900, 900, 1350} },
	},
	["MANASTONE"] = {
		["description"] = AUTOBAR_CLASS_MANASTONE;
		["texture"] = "INV_Misc_Gem_Emerald_01";
	},
	["ALTERAC_MANA"] = {
		["description"] = AUTOBAR_CLASS_BATTLEGROUNDMANAPOTIONS;
		["texture"] = "INV_Potion_81";
		["battleground"] = true;
		["items"] = {
			17352,	-- Superior Mana Draught
			17351,	-- Major Mana Draught
		},
	},
	["DREAMLESS_SLEEP"] = {
		["description"] = AUTOBAR_CLASS_DREAMLESS_SLEEP;
		["texture"] = "INV_Potion_83";
		["items"] = {
			12190,	-- Dreamless Sleep
			20002,	-- Greater Dreamless Sleep
		},
	},
	----------------
	["NIGHT_DRAGONS_BREATH"] = {
		["description"] = AUTOBAR_CLASS_NIGHT_DRAGONS_BREATH;
		["texture"] = "INV_Misc_Food_45";
		["limit"] = { ["downhp"] = { 456 }, ["downmana"] = { 456 }, },
		["items"] = { 11952 },
	},
	["REJUVENATION_POTIONS"] = {
		["description"] = AUTOBAR_CLASS_REJUVENATION_POTIONS;
		["texture"] = "INV_Potion_47";
		["items"] = {
			2456,	-- Minor Rejuvenation Potion
			9144,	-- Wildvine Potion
			18253,	-- Major Rejuvenation Potion
		},
		["limit"] = { ["downhp"] = { 150, 750, 1760 }, ["downmana"] = { 150, 750, 1760 }, },
	},
	----------------
	["BATTLE_STANDARD"] = {
		["description"] = AUTOBAR_CLASS_BATTLESTANDARD;
		["texture"] = "INV_BannerPVP_01";
		["battleground"] = true;
		["items"] = {
			18606,	-- Alliance Battle Standard
			18607,	-- Horde Battle Standard
		},
	},
	["BATTLE_STANDARD_AV"] = {
		["description"] = AUTOBAR_CLASS_BATTLESTANDARDAV;
		["texture"] = "INV_BannerPVP_02";
		["location"] = AUTOBAR_ALTERACVALLEY;
		["items"] = {
			19045,	-- Stormpike Battle Standard
			19046,	-- Frostwolf Battle Standard
		},
	},
	["HOURGLASS_SAND"] = {
		["description"] = AUTOBAR_CLASS_BATTLESTANDARDAV;
		["texture"] = "INV_BannerPVP_02";
		["location"] = AUTOBAR_BWL;
		["items"] = {
			19183,	-- Hourglass Sand
		},
	},
	["QUEST_ITEMS"] = {
		["description"] = AUTOBAR_CLASS_QUEST_ITEMS;
		["texture"] = "INV_BannerPVP_02";
		["arrangeOnUse"] = true;
		["items"] = {
			13892,	-- Kodo Kombobulator
		},
	},
	----------------
	["RUNES"] = {
		["description"] = AUTOBAR_CLASS_DEMONIC_DARK_RUNES;
		["texture"] = "Spell_Shadow_SealOfKings";
		["limit"] = { ["downmana"] = { 900, 900 }, },
		["items"] = {
			20520,	-- Dark Rune
			12662,	-- Demonic Rune
		},
	},
	----------------
	["PROTECTION_ARCANE"] = {
		["description"] = AUTOBAR_CLASS_ARCANE_PROTECTION;
		["texture"] = "INV_Potion_83";
		["items"] = { 13461 },
	},
	["PROTECTION_FIRE"] = {
		["description"] = AUTOBAR_CLASS_FIRE_PROTECTION;
		["texture"] = "INV_Potion_24";
		["items"] = { 6049, 13457 },
	},
	["PROTECTION_FROST"] = {
		["description"] = AUTOBAR_CLASS_FROST_PROTECTION;
		["texture"] = "INV_Potion_20";
		["items"] = { 6050, 13456 },
	},
	["PROTECTION_NATURE"] = {
		["description"] = AUTOBAR_CLASS_NATURE_PROTECTION;
		["texture"] = "INV_Potion_22";
		["items"] = { 6052, 13458 },
	},
	["PROTECTION_SHADOW"] = {
		["description"] = AUTOBAR_CLASS_SHADOW_PROTECTION;
		["texture"] = "INV_Potion_23";
		["items"] = { 6048, 13459 },
	},
	["PROTECTION_SPELLS"] = {
		["description"] = AUTOBAR_CLASS_SPELL_PROTECTION;
		["texture"] = "INV_Potion_29";
		["items"] = {
			20080	-- Sheen of Zanza
		},
	},
	["PROTECTION_HOLY"] = {
		["description"] = AUTOBAR_CLASS_HOLY_PROTECTION;
		["texture"] = "INV_Potion_09";
		["items"] = { 6051 },
		["noncombat"] = false,
	},
	["PROTECTION_DAMAGE"] = {
		["description"] = AUTOBAR_CLASS_INVULNERABILITY_POTIONS;
		["texture"] = "INV_Potion_62";
		["items"] = { 3387 },
		["noncombat"] = false,
	},
	["ACTION_POTIONS"] = {
		["description"] = AUTOBAR_CLASS_FREE_ACTION_POTION;
		["texture"] = "INV_Potion_04";
		["items"] = {
			20008,		-- Living Action Potion
			5634,		-- Free Action Potion
		},
	},
	----------------
	["HEARTHSTONE"] = {
		["description"] = AUTOBAR_CLASS_HEARTHSTONE;
		["texture"] = "INV_Misc_Rune_01";
		["items"] = {
			6948,			-- HearthStone
		},
	},
	----------------
	["WATER"] = {
		["description"] = AUTOBAR_CLASS_WATER;
		["texture"] = "INV_Drink_10";
		["noncombat"] = true,
	},
	["WATER_PERCENT"] = {
		["description"] = AUTOBAR_CLASS_WATER_PERCENT;
		["texture"] = "INV_Drink_04";
		["noncombat"] = true,
	},
	["WATER_CONJURED"] = {
		["description"] = AUTOBAR_CLASS_WATER_CONJURED;
		["texture"] = "INV_Drink_18";
		["noncombat"] = true,
	},
	["WATER_SPIRIT"] = {
		["description"] = AUTOBAR_CLASS_WATER_SPIRIT;
		["texture"] = "INV_Drink_16";
		["noncombat"] = true,
	},
	["RAGEPOTIONS"] = {
		["description"] = AUTOBAR_CLASS_RAGEPOTIONS;
		["texture"] = "INV_Potion_24";
	},
	["ENERGYPOTIONS"] = {
		["description"] = AUTOBAR_CLASS_ENERGYPOTIONS;
		["texture"] = "INV_Drink_Milk_05";
		["items"] = { 7676 },
	},
	["SWIFTNESSPOTIONS"] = {
		["description"] = AUTOBAR_CLASS_SWIFTNESSPOTIONS;
		["texture"] = "INV_Potion_95";
		["items"] = { 20081, 2459, },
	},
	["SOULSHARDS"] = {
		["description"] = AUTOBAR_CLASS_SOULSHARDS;
		["texture"] = "INV_Misc_Gem_Amethyst_02";
		["notusable"] = true;
		["items"] = { 6265 },
	},
	--------------
	["ARROWS"] = {
		["description"] = AUTOBAR_CLASS_ARROWS;
		["texture"] = "INV_Ammo_Arrow_02";
		["notusable"] = true;
	},
	["BULLETS"] = {
		["description"] = AUTOBAR_CLASS_BULLETS;
		["texture"] = "INV_Ammo_Bullet_02";
		["notusable"] = true;
	},
	["THROWN"] = {
		["description"] = AUTOBAR_CLASS_THROWNWEAPON;
		["texture"] = "INV_Axe_19";
		["notusable"] = true;
	},
	--------------
	["FOOD"] = {
		["description"] = AUTOBAR_CLASS_FOOD;
		["texture"] = "INV_Misc_Food_23";
		["noncombat"] = true,
	},
	["FOOD_PERCENT"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PERCENT;
		["texture"] = "INV_Misc_Food_60",
		["custom"] = true;
	},
	["FOOD_PERCENT_BONUS"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PERCENT_BONUS;
		["texture"] = "INV_Misc_Food_62",
		["custom"] = true;
	},
	["FOOD_PERCENT_COMBO"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PERCENT_COMBO;
		["texture"] = "INV_Food_ChristmasFruitCake_01",
		["custom"] = true;
	},
	["FOOD_PET_BREAD"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PET_BREAD;
		["texture"] = "INV_Misc_Food_35";
		["noncombat"] = true,
	},
	["FOOD_PET_CHEESE"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PET_CHEESE;
		["texture"] = "INV_Misc_Food_37";
		["noncombat"] = true,
	},
	["FOOD_PET_FISH"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PET_FISH;
		["texture"] = "INV_Misc_Fish_22";
		["noncombat"] = true,
	},
	["FOOD_PET_FRUIT"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PET_FRUIT;
		["texture"] = "INV_Misc_Food_19";
		["noncombat"] = true,
	},
	["FOOD_PET_FUNGUS"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PET_FUNGUS;
		["texture"] = "INV_Mushroom_05";
		["noncombat"] = true,
	},
	["FOOD_PET_MEAT"] = {
		["description"] = AUTOBAR_CLASS_FOOD_PET_MEAT;
		["texture"] = "INV_Misc_Food_14";
		["noncombat"] = true,
	},
	["FOOD_WATER"] = {
		["description"] = AUTOBAR_CLASS_FOOD_COMBO;
		["texture"] = "INV_Misc_Food_33";
		["noncombat"] = true,
	},
	["FOOD_CONJURED"] = {
		["description"] = AUTOBAR_CLASS_FOOD_CONJURED;
		["texture"] = "INV_Misc_Food_73CinnamonRoll";
		["noncombat"] = true,
	},
	["FOOD_STAMINA"] = {
		["description"] = AUTOBAR_CLASS_FOOD_STAMINA;
		["texture"] = "INV_Egg_03";
		["noncombat"] = true,
	},
	["FOOD_AGILITY"] = {
		["description"] = AUTOBAR_CLASS_FOOD_AGILITY;
		["texture"] = "INV_Misc_Fish_13";
		["noncombat"] = true,
	},
	["FOOD_MANAREGEN"] = {
		["description"] = AUTOBAR_CLASS_FOOD_MANAREGEN;
		["texture"] = "INV_Drink_17";
		["noncombat"] = true,
	},
	["FOOD_HPREGEN"] = {
		["description"] = AUTOBAR_CLASS_FOOD_HPREGEN;
		["texture"] = "INV_Misc_Fish_19";
		["noncombat"] = true,
	},
	["FOOD_STRENGTH"] = {
		["description"] = AUTOBAR_CLASS_FOOD_STRENGTH;
		["texture"] = "INV_Misc_Food_41";
		["noncombat"] = true,
	},
	["FOOD_INTELLIGENCE"] = {
		["description"] = AUTOBAR_CLASS_FOOD_INTELLIGENCE;
		["texture"] = "INV_Misc_Food_63";
		["noncombat"] = true,
	},
	["FOOD_ARATHI"] = {
		["description"] = AUTOBAR_CLASS_FOOD_ARATHI;
		["texture"] = "INV_Misc_Food_33";
		["noncombat"] = true,
		["location"] = AUTOBAR_ARATHIBASIN;
		["items"] = {
			20062,
			20063,	-- Arathi Basin Field Ration	1074 health	2202 mana 30 sec
			20064,
			20222,	-- Defiler's Enriched Ration	2148 health	4410 mana 30 sec
			20223,
			20224,
			20225,
			20226,
			20227,
		},
	},
	["FOOD_WARSONG"] = {
		["description"] = AUTOBAR_CLASS_FOOD_WARSONG;
		["texture"] = "INV_Misc_Food_33";
		["noncombat"] = true,
		["location"] = AUTOBAR_WARSONGGULCH;
		["items"] = { 19062, 19061, 19060 },
	},
	--------------
	["SHARPENINGSTONES"] = {
		["description"] = AUTOBAR_CLASS_SHARPENINGSTONES;
		["texture"] = "INV_Stone_SharpeningStone_01";
		["targetted"] = "WEAPON";
	},
	["WEIGHTSTONES"] = {
		["description"] = AUTOBAR_CLASS_WEIGHTSTONE;
		["texture"] = "INV_Stone_WeightStone_02";
		["targetted"] = "WEAPON";
	},
	--------------
	["POISON-CRIPPLING"] = {
		["description"] = AUTOBAR_CLASS_POISON_CRIPPLING;
		["texture"] = "INV_Potion_19";
		["targetted"] = "WEAPON";
	},
	["POISON-DEADLY"] = {
		["description"] = AUTOBAR_CLASS_POISON_DEADLY;
		["texture"] = "Ability_Rogue_DualWeild";
		["targetted"] = "WEAPON";
	},
	["POISON-INSTANT"] = {
		["description"] = AUTOBAR_CLASS_POISON_INSTANT;
		["texture"] = "Ability_Poisons";
		["targetted"] = "WEAPON";
	},
	["POISON-MINDNUMBING"] = {
		["description"] = AUTOBAR_CLASS_POISON_MINDNUMBING;
		["texture"] = "Spell_Nature_NullifyDisease";
		["targetted"] = "WEAPON";
	},
	["POISON-WOUND"] = {
		["description"] = AUTOBAR_CLASS_POISON_WOUND;
		["texture"] = "Ability_PoisonSting";
		["targetted"] = "WEAPON";
	},
	--------------
	["EXPLOSIVES"] = {
		["description"] = AUTOBAR_CLASS_EXPLOSIVES;
		["texture"] = "INV_Misc_Bomb_08";
		["nosmartcast"] = true;
		["targetted"] = true;
	},
	--------------
	["MOUNTS"] = {
		["description"] = AUTOBAR_CLASS_MOUNTS;
		["texture"] = "Ability_Mount_JungleTiger";
		["noncombat"] = true,
		["arrangeOnUse"] = true,
	},
	["MOUNTS_QIRAJI"] = {
		["description"] = AUTOBAR_CLASS_MOUNTS_QIRAJI;
		["texture"] = "INV_Misc_QirajiCrystal_05";
		["noncombat"] = true,
		["arrangeOnUse"] = true,
		["location"] = AUTOBAR_AHN_QIRAJ;
	},
	--------------
	["OIL_MANA"] = {
		["texture"] = "INV_Potion_100";
		["targetted"] = "WEAPON";
		["description"] = AUTOBAR_CLASS_MANA_OIL;
	},
	["OIL_WIZARD"] = {
		["texture"] = "INV_Potion_105";
		["targetted"] = "WEAPON";
		["description"] = AUTOBAR_CLASS_WIZARD_OIL;
	},
};

AutoBar_Category_Info["FOOD_WATER"].items = {
		3448,	-- Senggin Root				Level 1		heals 294	mana 294
		2682,	-- Cooked Crab Claw			Level 5		heals 294	mana 294
		13724,  -- Enriched Manna Biscuit   -- 45
		19301,  -- Alterac Manna Biscuit    -- 51
		20031,  -- Essence Mango            -- 55
};
AutoBar_Category_Info["FOOD_CONJURED"].items = {
		5349,	-- Conjured Muffin			-- Mage    - Level 1, heals 61
		1113,	-- Conjured Bread			-- Mage    - Level 5, heals 243
		1114,	-- Conjured Rye 			-- Mage    - Level 15, heals 552
		1487,	-- Conjured Pumpernickel 	-- Mage    - Level 25, heals 874
		8075,	-- Conjured Sourdough		-- Mage    - Level 35, heals 1392
		8076,	-- Conjured Sweet Roll		-- Mage    - Level 45, heals 2148
		22895,	-- Conjured Cinnamon Roll	-- Mage    - Level 55, heals 3180
};
AutoBar_Category_Info["FOOD"].items = {
		2070,	-- Darnassian Bleu			-- Vendor  - Level 1, heals 61
		4540,	-- Tough Hunk of Bread		-- Vendor  - Level 1, heals 61
		4536,	-- Shiny Red Apple			-- Vendor  - Level 1, heals 61
		117,	-- Tough Jerky				-- Vendor  - Level 1, heals 61
		4604,	-- Forest Mushroom Cap		-- Vendor  - Level 1, heals 61
		16166,	-- Bean Soup				-- Vendor  - Level 1, heals 61
		2679,	-- Charred Wolf Meat		-- Cooking - Level 1, heals 61
		2681,	-- Roasted Boar Meat		-- Cooking - Level 1, heals 61
		787,	-- Slitherskin Mackerel		-- Cooking - Level 1, heals 61
		6290,	-- Brilliant Smallfish		-- Cooking - Level 1, heals 61
		2680,	-- Spiced Wolf Meat			-- Cooking
		16167,	-- Versicolor Treat			-- Vendor - Level 5, heals 243
		4605,	-- Red-speckled Mushroom	-- Vendor  - Level 5, heals 243
		2287,	-- Haunch of Meat			-- Vendor  - Level 5, heals 243
		4537,	-- Tel'Abim Banana			-- Vendor  - Level 5, heals 243
		414,	-- Dalaran Sharp			-- Vendor  - Level 5, heals 243
		4541,	-- Freshly Baked Bread		-- Vendor  - Level 5, heals 243
		6890,	-- Smoked Bear Meat			-- Cooking - Level 5, heals 243
		6316,	-- Loch Frenzy Delight		-- Cooking - Level 5, heals 243
		5095,	-- Rainbow Fin Albacore		-- Cooking - Level 5, heals 243
		4592,	-- Longjaw Mud Snapper		-- Cooking - Level 5, heals 243
		2683,	-- Crab Cake				-- Cooking
		2684,	-- Coyote Steak				-- Cooking
		5473,	-- Scorpid Surprise			-- Cooking - Level 1, heals 294
		733,	-- Westfall Stew			-- Cooking - Level 5, heals 552
		422,	-- Dwarven Mild				-- Vendor  - Level 15, heals 552
		4542,	-- Moist Cornbread			-- Vendor  - Level 15, heals 552
		4538,	-- Snapvine Watermelon		-- Vendor  - Level 15, heals 552
		3770,	-- Mutton Chop				-- Vendor  - Level 15, heals 552
		4606,	-- Spongy Morel				-- Vendor  - Level 15, heals 552
		16170,	-- Steamed Mandu			-- Vendor  - Level 15, heals 552
		5526,	-- Clam Chowder				-- Cooking - Level 10, heals 552
		5478,	-- Dig Rat Stew				-- Cooking - Level 10, heals 552
		2685,	-- Succulent Pork Ribs		-- Cooking - Level 10, heals 552
		4593,	-- Bristle Whisker Catfish 	-- Cooking - Level 15, heals 552
		4594,	-- Rockscale Cod			-- Cooking - Level 25, heals 874
		8364,	-- Mithril Head Trout 		-- Cooking - Level 25, heals 874
		16169,	-- Wild Ricecake			-- Vendor  - Level 25, heals 874
		4607,	-- Delicious Cave Mold		-- Vendor  - Level 25, heals 874
		3771,	-- Wild Hog Shank 			-- Vendor  - Level 25, heals 874
		4539,	-- Goldenbark Apple 		-- Vendor  - Level 25, heals 874
		4544,	-- Mulgore Spice Bread 		-- Vendor  - Level 25, heals 874
		1707,	-- Stormwind Brie 			-- Vendor  - Level 25, heals 874
		13546,	-- Bloodbelly Fish			-- Quest   - Level 25, heals 1392
		3927,	-- Fine Aged Cheddar		-- Vendor  - Level 35, heals 1392
		4601,	-- Soft Banana Bread		-- Vendor  - Level 35, heals 1392
		4602,	-- Moon Harvest Pumpkin		-- Vendor  - Level 35, heals 1392
		4599,	-- Cured Ham Steak 			-- Vendor  - Level 35, heals 1392
		4608,	-- Raw Black Truffle 		-- Vendor  - Level 35, heals 1392
		18255,	-- Runn Tum Tuber			-- Uncooked
		16168,	-- Heaven Peach				-- Vendor  - Level 35, heals 1392
		16766,	-- Undermine Clam Chowder	-- Cooking - Level 35, heals 1392
		6887,	-- Spotted Yellowtail		-- Cooking - Level 35, heals 1392
		13930,	-- Filet of Redgill			-- Cooking - Level 35, heals 1392
		9681,	-- Grilled King Crawler Legs	-- Quest - Level 35, heals 1392
		16171,	-- Shinsollo				-- Vendor  - Level 45, heals 2148
		8952,	-- Roasted Quail 			-- Vendor  - Level 45, heals 2148
		8953,	-- Deep Fried Plantains		-- Vendor  - Level 45, heals 2148
		8950,	-- Homemade Cherry Pie 		-- Vendor  - Level 45, heals 2148
		8932,	-- Alterac Swiss 			-- Vendor  - Level 45, heals 2148
		8948,	-- Dried King Bolete 		-- Vendor  - Level 45, heals 2148
		8957,	-- Spinefin Halibut			-- Vendor  - Level 45, heals 2148
		13935,	-- Baked Salmon				-- Cooking - Level 45, heals 2148
		13933,	-- Lobster Stew				-- Cooking - Level 45, heals 2148
		23160,	-- Friendship Bread			-- Vendor  - Level 45, heals 2148
		21031,	-- Cabbage Kimchi			-- Vendor  - Level 45, heals 2148
		21033,	-- Radish Kimchi			-- Vendor  - Level 45, heals 2148
		22324,	-- Winter Kimchi			-- Vendor  - Level 45, heals 2148
};
AutoBar_Category_Info["FOOD_PET_BREAD"].items = {
		5349,	-- Conjured Muffin						heals 61
		4540,	-- Tough Hunk of Bread		Level 1		heals 61
		17197,	-- Gingerbread Cookie					heals 61
		1113,	-- Conjured Bread			Level 5		heals 243
		2683,	-- Crab Cake				Level 5		heals 243
		4541,	-- Freshly Baked Bread		Level 5		heals 243
		1114,	-- Conjured Rye				Level 15	heals 552
		4542,	-- Moist Cornbread			Level 15	heals 552
		1487,	-- Conjured Pumpernickel	Level 25	heals 874
		4544,	-- Mulgore Spice Bread 		Level 25	heals 874
		16169,	-- Wild Ricecake 			Level 25	heals 874
		8075,	-- Conjured Sourdough		Level 35	heals 1392
		4601,	-- Soft Banana Bread		Level 35	heals 1392
		8076,	-- Conjured Sweet Roll		Level 45	heals 2148
		23160,	-- Friendship Bread			Level 45	heals 2148
		8950,	-- Homemade Cherry Pie 		Level 45	heals 2148
		22895,	-- Conjured Cinnamon Roll	Level 55	heals 3180
};
AutoBar_Category_Info["FOOD_PET_FISH"].items = {
		6303,	-- Raw Slitherskin Mackerel			Level 0		30
		6291,	-- Raw Brilliant Smallfish			Level 0		30
		6290,	-- Brilliant Smallfish				Level 0		61
		6361,	-- Raw Rainbow Fin Albacore			Level 5		61
		6289,	-- Raw Longjaw Mud Snapper			Level 5		61
		787,	-- Slitherskin Mackerel				Level 1		61
		6316,	-- Loch Frenzy Delight				Level 5		243
		5095,	-- Rainbow Fin Albacore				Level 5		243
		4592,	-- Longjaw Mud Snapper				Level 5		243
		6308,	-- Raw Bristle Whisker Catfish		Level 15	243
		2682,	-- Cooked Crab Claw					Level 5		294
		5526,	-- Clam Chowder						Level 10	552
		4593,	-- Bristle Whisker Catfish			Level 15	552
		16170,	-- Steamed Mandu					Level 15	552
		6362,	-- Raw Rockscale Cod				Level 25	552
		8365,	-- Raw Mithril Head Trout			Level 25	552
		13754,	-- Raw Glossy Mightfish				Level 35	874
		4594,	-- Rockscale Cod					Level 25	874
		8364,	-- Mithril Head Trout				Level 25	874
		13758,	-- Raw Redgill						Level 35	874
		13760,	-- Raw Sunscale Salmon				Level 35	874
		13756,	-- Raw Summer Bass					Level 35	874
		4603,	-- Raw Spotted Yellowtail			Level 35	874
		13546,	-- Bloodbelly Fish					Level 25	1392
		13893,	-- Large Raw Mightfish				Level 45	1392
		8959,	-- Raw Spinefin Halibut				Level 45	1392
		13930,	-- Filet of Redgill					Level 35	1392
		6887,	-- Spotted Yellowtail				Level 35	1392
		16766,	-- Undermine Clam Chowder			Level 35	1392
		13888,	-- Darkclaw Lobster					Level 45	1392
		13933,	-- Lobster Stew						Level 45	2148
		8957,	-- Spinefin Halibut					Level 45	2148
		13935,	-- Baked Salmon						Level 45	2148
};
AutoBar_Category_Info["FOOD_PET_FRUIT"].items = {
		4536,	-- Shiny Red Apple					Level 1		61
		4537,	-- Tel'Abim Banana					Level 5		243
		4538,	-- Snapvine Watermelon				Level 15	552
		4539,	-- Goldenbark Apple 				Level 25	874
		4602,	-- Moon Harvest Pumpkin				Level 35	1392
		16168,	-- Heaven Peach						Level 35	1392
		8953,	-- Deep Fried Plantains				Level 45	2148
};
AutoBar_Category_Info["FOOD_PET_FUNGUS"].items = {
		4604,	-- Forest Mushroom Cap				Level 1		61
		4605,	-- Red-speckled Mushroom			Level 5		243
		4606,	-- Spongy Morel						Level 15	552
		4607,	-- Delicious Cave Mold				Level 25	874
		4608,	-- Raw Black Truffle 				Level 35	1392
		8948,	-- Dried King Bolete 				Level 45	2148
};
AutoBar_Category_Info["FOOD_PET_MEAT"].items = {
		4457,		--	Barbecued Buzzard Wing
		117,	-- Tough Jerky						Level 1		61
		3173,		--	Bear Meat
		2888,		--	Beer Basted Boar Ribs
		2679,	-- Charred Wolf Meat		-- Cooking - Level 1, heals 61
		2681,	-- Roasted Boar Meat		-- Cooking - Level 1, heals 61
		3730,		--	Big Bear Meat
		3726,		--	Big Bear Steak
		3220,		--	Blood Sausage
		2677,		--	Boar Ribs
		3404,		--	Buzzard Wing
		12213,	--	Carrion Surprise
		769,		--	Chunk of Boar Meat
		2673,		--	Coyote Meat
		1081,		--	Crisp Spider Meat
		12224,	--	Crispy Bat Wing
		5479,		--	Crispy Lizard Tail
		2924,		--	Crocolisk Meat
		3662,		--	Crocolisk Steak
		17119,	--	Deeprun Rat Kabob
		5051,		--	Dig Rat
		12217,	--	Dragonbreath Chili
		2687,		--	Dry Pork Ribs
		9681,		--	Grilled King Crawler Legs
		12204,	--	Heavy Kodo Meat
		3727,		--	Hot Lion Chops
		13851,	--	Hot Wolf Ribs
		12212,	--	Jungle Stew
		5472,		--	Kaldorei Spider Kabob
		5467,		--	Kodo Meat
		5480,		--	Lean Venison
		1015,		--	Lean Wolf Flank
		12209,	--	Lean Wolf Steak
		3731,		--	Lion Meat
		12223,	--	Meaty Bat Wing
		12037,	--	Mystery Meat
		4739,		--	Plainstrider Meat
		12184,	--	Raptor Flesh
		13759,	--	Raw Nightfin Snapper
		12203,	--	Red Wolf Meat
		12210,	--	Roast Raptor
		5474,		--	Roasted Kodo Meat
		1017,		--	Seasoned Wolf Kabob
		5465,		--	Small Spider Leg
		3729,		--	Soothing Turtle Bisque
		2680,	-- Spiced Wolf Meat			-- Cooking
		17222,	--	Spider Sausage
		5471,	--	Stag Meat
		2287,	-- Haunch of Meat			-- Vendor  - Level 5, heals 243
		6890,	-- Smoked Bear Meat			-- Cooking - Level 5, heals 243
		5469,	-- Strider Meat
		5477,	-- Strider Stew
		2672,	-- Stringy Wolf Meat
		3728,	-- Tasty Lion Steak
		3667,	-- Tender Crocolisk Meat
		12208,	-- Tender Wolf Meat
		18045,	-- Tender Wolf Steak
		5470,	-- Thunder Lizard Tail
		12202,	-- Tiger Meat
		2684,	-- Coyote Steak				-- Cooking
		5473,	-- Scorpid Surprise			-- Cooking - Level 1, heals 294
		733,	-- Westfall Stew			-- Cooking - Level 5, heals 552
		3770,	-- Mutton Chop				-- Vendor  - Level 15, heals 552
		5478,	-- Dig Rat Stew				-- Cooking - Level 10, heals 552
		2685,	-- Succulent Pork Ribs		-- Cooking - Level 10, heals 552
		3771,	-- Wild Hog Shank 			-- Vendor  - Level 25, heals 874
		3712,	-- Turtle Meat
		12205,	-- White Spider Meat
		4599,	-- Cured Ham Steak 			-- Vendor  - Level 35, heals 1392
		16171,	-- Shinsollo				-- Vendor  - Level 45, heals 2148
		8952,	-- Roasted Quail 			-- Vendor  - Level 45, heals 2148
};
AutoBar_Category_Info["FOOD_STAMINA"].items = {
		6888,	-- Herb Baked Egg	-- Cooking - Level 1, heals 61, stamina/spirit
		12224,	-- Crispy Bat Wing	-- Cooking - Level 1, heals 61, stamina/spirit
		7808,	-- Chocolate Square	-- heals 61, 2 stamina/spirit
		17197,	-- Gingerbread Cookie	-- Cooking - Level 1, heals 61, stamina/spirit
		17198,	-- Egg Nog		-- Cooking - Level 1, heals 61, stamina/spirit
		5472,	-- Kaldorei Spider Kabo	-- Cooking - Level 1, heals 61, with bonus
		2888,	-- Beer Basted Boar Rib	-- Cooking - Level 1, heals 61, with bonus
		5474,	-- Roasted Kodo Meat	-- Cooking - Level 1, heals 61, stamina/spirit
		11584,	-- Cactus Apple Surpris	-- Quest   - Level 1, heals 61, with bonus
		5476,	-- Fillet of Frenzy	-- Cooking - Level 5, heals 243, with bonus
		5477,	-- Strider Stew		-- Cooking - Level 5, heals 243, stamina/spirit
		724,	-- Goretusk Liver Pieo	-- Cooking - Level 5, heals 243, with bonus
		3220,	-- Blood Sausageo	-- Cooking - Level 5, heals 243, with bonus
		3662,	-- Crocolisk Steako	-- Cooking - Level 5, heals 243, with bonus
		2687,	-- Dry Pork Ribso	-- Cooking - Level 5, heals 243, stamina/spirit
		5525,	-- Boiled Clams		-- Cooking - Level 5, heals 243, stamina/spirit
		1082,	-- Redridge Goulash	-- Cooking - Level 10, heals 552, with bonus
		5479,	-- Crispy Lizard Tail	-- Cooking - Level 12, heals 552, stamina/spirit
		1017,	-- Seasoned Wolf Kabob	-- Cooking - Level 15, heals 552, with bonus
		3663,	-- Murloc Fin Soup	-- Cooking - Level 15, heals 552, with bonus
		3726,	-- Big Bear Steak	-- Cooking - Level 15, heals 552, stamina/spirit
		5480,	-- Lean Venison		-- Cooking - Level 15, heals 552, stamina/spirit
		3666,	-- Gooey Spider Cake	-- Cooking - Level 15, heals 552, with bonus
		3664,	-- Crocolisk Gumbo	-- Cooking - Level 15, heals 552, with bonus
		5527,	-- Goblin Deviled Clams	-- Cooking - Level 15, heals 552, stamina/spirit
		3727,	-- Hot Lion Chops	-- Cooking - Level 15, heals 552, stamina/spirit
		12209,	-- Lean Wolf Steak	-- Cooking - Level 15, heals 552, with bonus
		3665,	-- Curiously Tasty Omel	-- Cooking - Level 15, heals 552, stamina/spirit
		3728,	-- Tasty Lion Steak	-- Cooking - Level 20, heals 874, with bonus
		20074,	-- Heavy Crocolisk Stew	-- Cooking - Level 20, heals 874, with 8 stamina/spirit
		4457,	-- Barbecued Buzzard Win-- Cooking - Level 25, heals 874, stamina/spirit
		12213,	-- Carrion Surprise	-- Cooking - Level 25, heals 874, stamina/spirit
		6038,	-- Giant Clam Corcho	-- Cooking - Level 25, heals 874, stamina/spirit
		3729,	-- Soothing Turtle Bisqu-- Cooking - Level 25, heals 874, stamina/spirit
		13851,	-- Hot Wolf Ribs	-- Cooking - Level 25, heals 874, with bonus
		12214,	-- Mystery Stew		-- Cooking - Level 25, heals 874, with bonus
		12210,	-- Roast Raptor		-- Cooking - Level 25, heals 874, stamina/spirit
		12212,	-- Jungle Stew		-- Cooking - Level 25, heals 874, stamina/spirit
		13929,	-- Hot Smoked Bass	-- Cooking - Level 35, heals 874, with bonus
		17222,	-- Spider Sausage 	-- Cooking - Level 35, heals 1392, stamina/spirit
		12215,	-- Heavy Kodo Stew	-- Cooking - Level 35, heals 1392, stamina/spirit
		13927,	-- Cooked Glossy Mightfi-- Cooking - Level 35, heals 1392, stamina
		12216,	-- Spider Chilli Crab	-- Cooking - Level 35, heals 1392, stamina/spirit
		12218,	-- Monster Omlette	-- Cooking - Level 40, heals 1392, stamina/spirit
		16971,	-- Clamlette Surprise 	-- Cooking - Level 40, heals 1392, with bonus
		18045,	-- Tender Wolf Steak	-- Cooking - Level 40, heals 1392, stamina/spirit
		13934,	-- Mightfish Steak	-- Cooking - Level 45, heals 1933, stamina
		11950,	-- Windblossom Berries	-- Felwood - Level 45, heals 1933, stamina/spirit
		21023,	-- Dirge's Kickin' Chimaerok Chops	-- Cooking - Level 55, heals 2250, 25 stamina
};
AutoBar_Category_Info["FOOD_AGILITY"].items = {
		13928,	-- Grilled Squid	-- Cooking - Level 35, heals 874, agility
};
AutoBar_Category_Info["FOOD_MANAREGEN"].items = {
		21072,	-- Smoked Sagefish	-- Cooking - Level 10, heals 378, mana 567, 3/5 mana regen
		21217,	-- Sagefish Delight	-- Cooking - Level 30, heals 840, mana 1260, 6/5 mana regen
		13931,	-- Nightfin Soup	-- Cooking - Level 35, heals 874, 8/5 mana regen
};
AutoBar_Category_Info["FOOD_HPREGEN"].items = {
		13932,	-- Poached Sunscale Salmon	-- Cooking - Level 35, heals 874, hp regen
};
AutoBar_Category_Info["FOOD_STRENGTH"].items = {
		13810,	-- Blessed Sunfruit -- AD - Level 45, heals 1933, strength
		20452,	-- Smoked Desert Dumpling-- Level 45, heals 2148, str bonus
};
AutoBar_Category_Info["FOOD_INTELLIGENCE"].items = {
		18254,	-- Runn Tum Tuber Surpris-- int bonus
};

