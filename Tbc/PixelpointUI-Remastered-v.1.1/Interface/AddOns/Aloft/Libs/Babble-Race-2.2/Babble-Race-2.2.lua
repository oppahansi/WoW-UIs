--[[
Name: Babble-Race-2.2
Revision: $Rev: 1296 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Babble-Race-2.2
SVN: http://svn.wowace.com/root/trunk/Babble-2.2/Babble-Race-2.2
Description: A library to provide localizations for races.
Dependencies: AceLibrary, AceLocale-2.2
License: MIT
]]

local MAJOR_VERSION = "Babble-Race-2.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1296 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(MAJOR_VERSION .. " requires AceLocale-2.2") end

local _, x = AceLibrary("AceLocale-2.2"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleRace = AceLibrary("AceLocale-2.2"):new(MAJOR_VERSION)

-- uncomment below for debug information
-- BabbleRace:EnableDebugging()

BabbleRace:RegisterTranslations("enUS", function()
	return {
		["Human"] = true,
		["Night Elf"] = true,
		-- Fix for legacy apps
		["Night elf"] = "Night Elf",
		["Dwarf"] = true,
		["Gnome"] = true,
		["Draenei"] = true,

		["Orc"] = true,
		["Tauren"] = true,
		["Troll"] = true,
		["Undead"] = true,
		["Blood Elf"] = true,
		-- Fix for legacy apps
		["Blood elf"] = "Blood Elf",

		["Humans"] = true,
		["Night elves"] = true,
		["Dwarves"] = true,
		["Gnomes"] = true,
		["Draenei_PL"] = "Draenei",

		["Orcs"] = true,
		["Tauren_PL"] = "Tauren",
		["Trolls"] = true,
		["Undead_PL"] = "Undead",
		["Blood elves"] = true,

		["Imp"] = true,
		["Succubus"] = true,
		["Voidwalker"] = true,
		["Felguard"] = true,
		["Felhunter"] = true,
	}
end)

BabbleRace:RegisterTranslations("deDE", function()
	return {
		["Human"] = "Mensch",
		["Night elf"] = "Nachtelf",
		["Dwarf"] = "Zwerg",
		["Gnome"] = "Gnom",
		["Draenei"] = "Draenei",

		["Orc"] = "Orc",
		["Tauren"] = "Tauren",
		["Troll"] = "Troll",
		["Undead"] = "Untoter",
		["Blood elf"] = "Blutelf",

		["Humans"] = "Menschen",
		["Night elves"] = "Nachtelfen",
		["Dwarves"] = "Zwerge",
		["Gnomes"] = "Gnome",
		["Draenei_PL"] = "Draenei",

		["Orcs"] = "Orcs",
		["Tauren_PL"] = "Tauren",
		["Trolls"] = "Trolle",
		["Undead_PL"] = "Untote",
		["Blood elves"] = "Blutelfen",

		["Imp"] = "Wichtel",
		["Succubus"] = "Sukkubus",
		["Voidwalker"] = "Leerwandler",
		["Felguard"] = "Teufelswache",
		["Felhunter"] = "Teufelsj\195\164ger",
	}
end)

BabbleRace:RegisterTranslations("frFR", function()
	return {
		["Human"] = "Humain",
		["Night elf"] = "Elfe de la nuit",
		["Night Elf"] = "Elfe de la nuit",
		["Dwarf"] = "Nain",
		["Gnome"] = "Gnome",
		["Draenei"] = "Draeneï",

		["Orc"] = "Orc",
		["Tauren"] = "Tauren",
		["Troll"] = "Troll",
		["Undead"] = "Mort-vivant",
		["Blood elf"] = "Elfe de sang",
		["Blood Elf"] = "Elfe de sang",

		["Humans"] = "Humains",
		["Night elves"] = "Elfes de la nuit",
		["Dwarves"] = "Nains",
		["Gnomes"] = "Gnomes",
		["Draenei_PL"] = "Draeneï",

		["Orcs"] = "Orcs",
		["Tauren_PL"] = "Taurens",
		["Trolls"] = "Trolls",
		["Undead_PL"] = "Morts-vivants",
		["Blood elves"] = "Elfes de sang",

		["Imp"] = "Diablotin",
		["Succubus"] = "Succube",
		["Voidwalker"] = "Marcheur du Vide",
		["Felguard"] = "Gangregarde",
		["Felhunter"] = "Chasseur corrompu",
	}
end)

BabbleRace:RegisterTranslations("koKR", function()
	return {
		["Human"] = "인간",
		["Night Elf"] = "나이트 엘프",
		-- Fix for legacy apps
		["Night elf"] = "나이트 엘프",
		["Dwarf"] = "드워프",
		["Gnome"] = "노움",
		["Draenei"] = "드레나이",

		["Orc"] = "오크",
		["Tauren"] = "타우렌",
		["Troll"] = "트롤",
		["Undead"] = "언데드",
		["Blood Elf"] = "블러드 엘프",
		-- Fix for legacy apps
		["Blood elf"] = "블러드 엘프",

		["Humans"] = "인간",
		["Night elves"] = "나이트 엘프",
		["Dwarves"] = "드워프",
		["Gnomes"] = "노움",
		["Draenei_PL"] = "드레나이",

		["Orcs"] = "오크",
		["Tauren_PL"] = "타우렌",
		["Trolls"] = "트롤",
		["Undead_PL"] = "언데드",
		["Blood elves"] = "블러드 엘프",

		["Imp"] = "임프",
		["Succubus"] = "서큐버스",
		["Voidwalker"] = "보이드워커",
		["Felguard"] = "지옥수호병",
		["Felhunter"] = "지옥사냥개",
	}
end)

BabbleRace:RegisterTranslations("zhCN", function()
	return {
		["Human"] = "人类",
		["Night Elf"] = "暗夜精灵",
		["Night elf"] = "暗夜精灵",
		["Dwarf"] = "矮人",
		["Gnome"] = "侏儒",
		["Draenei"] = "德莱尼",

		["Orc"] = "兽人",
		["Tauren"] = "牛头人",
		["Troll"] = "巨魔",
		["Undead"] = "亡灵",
		["Blood Elf"] = "血精灵",
		["Blood elf"] = "血精灵",

		["Humans"] = "人类",
		["Night elves"] = "暗夜精灵",
		["Dwarves"] = "矮人",
		["Gnomes"] = "侏儒",
		["Draenei_PL"] = "德莱尼",

		["Orcs"] = "兽人",
		["Tauren_PL"] = "牛头人",
		["Trolls"] = "巨魔",
		["Undead_PL"] = "亡灵",
		["Blood elves"] = "血精灵",
		["Imp"] = "小鬼",
		["Succubus"] = "魅魔",
		["Voidwalker"] = "虚空行者",
		["Felguard"] = "恶魔卫士",
		["Felhunter"] = "地狱猎犬",
	}
end)

BabbleRace:RegisterTranslations("zhTW", function()
	return {
		["Human"] = "人類",
		["Night Elf"] = "夜精靈",
		-- Fix for legacy apps
		["Night elf"] = "夜精靈",
		["Dwarf"] = "矮人",
		["Gnome"] = "地精",
		["Draenei"] = "德萊尼",

		["Orc"] = "獸人",
		["Tauren"] = "牛頭人",
		["Troll"] = "食人妖",
		["Undead"] = "不死族",
		["Blood Elf"] = "血精靈",
		-- Fix for legacy apps
		["Blood elf"] = "血精靈",

		["Humans"] = "人類",
		["Night elves"] = "夜精靈",
		["Dwarves"] = "矮人",
		["Gnomes"] = "地精",
		["Draenei_PL"] = "德萊尼",

		["Orcs"] = "獸人",
		["Tauren_PL"] = "牛頭人",
		["Trolls"] = "食人妖",
		["Undead_PL"] = "不死族",
		["Blood elves"] = "血精靈",

		["Imp"] = "小鬼",
		["Succubus"] = "魅魔",
		["Voidwalker"] = "虛無行者",
		["Felguard"] = "惡魔守衛",
		["Felhunter"] = "惡魔獵犬",
	}
end)

BabbleRace:RegisterTranslations("esES", function()
	return {
		["Human"] = "Humano",
		["Night elf"] = "Elfo de la noche",
		["Dwarf"] = "Enano",
		["Gnome"] = "Gnomo",
		["Draenei"] = "Draenei",

		["Orc"] = "Orco",
		["Tauren"] = "Tauren",
		["Troll"] = "Trol",
		["Undead"] = "No-muerto",
		["Blood elf"] = "Elfo de sangre",

		["Humans"] = "Humanos",
		["Night elves"] = "Elfos de la noche",
		["Dwarves"] = "Enanos",
		["Gnomes"] = "Gnomos",
		["Draenei_PL"] = "Draenei",

		["Orcs"] = "Orcos",
		["Tauren_PL"] = "Tauren",
		["Trolls"] = "Trols",
		["Undead_PL"] = "No-muertos",
		["Blood elves"] = "Elfos de sangre",

		--["Imp"] = true,
		--["Succubus"] = true,
		--["Voidwalker"] = true,
		--["Felguard"] = true,
		--["Felhunter"] = true,
	}
end)

-- updater: StingerSoft
BabbleRace:RegisterTranslations("ruRU", function()
    return {
-- Races
		["Human"] = "Человек",
		["Night Elf"] = "Ночной эльф",
		-- Fix for legacy apps
		["Night elf"] = "Ночной эльф",
		["Dwarf"] = "Дворф",
		["Gnome"] = "Гном",
		["Draenei"] = "Дреней",

		["Orc"] = "Орк",
		["Tauren"] = "Таурен",
		["Troll"] = "Тролль",
		["Undead"] = "Нежить",
		["Blood Elf"] = "Эльф крови",
		-- Fix for legacy apps
		["Blood elf"] = "Эльф крови",

		["Humans"] = "Человеков",
		["Night elves"] = "Ночные эльфы",
		["Dwarves"] = "Дворфы",
		["Gnomes"] = "Гномы",
		["Draenei_PL"] = "Дренеев",

		["Orcs"] = "Орков",
		["Tauren_PL"] = "Тауренов",
		["Trolls"] = "Троллей",
		["Undead_PL"] = "Нежитей",
		["Blood elves"] = "Эльфов крови",

-- Creatures
		["Imp"] = "Бес",
		["Succubus"] = "Суккуб",
		["Voidwalker"] = "Демон Хаоса",
		["Felguard"] = "Страж Скверны",
		["Felhunter"] = "Охотник Скверны",
    }
end)

BabbleRace:Debug()
BabbleRace:SetStrictness(true)

AceLibrary:Register(BabbleRace, MAJOR_VERSION, MINOR_VERSION)
BabbleRace = nil
