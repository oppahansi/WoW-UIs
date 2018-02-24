-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("CreatureTypeData") then return end
local AloftCreatureTypeData = Aloft:GetModule("CreatureTypeData")
local L = AceLibrary("AceLocale-2.2"):new("AloftCreatureTypeDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Save Creature Type Data"] = true,
	["Stores creature type information between sessions"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Save Creature Type Data"] = "몹 종류 데이터를 저장합니다.",
	["Stores creature type information between sessions"] = "접속 간 몹 종류 정보를 저장합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Save Creature Type Data"] = "儲存生物類型資料",
	["Stores creature type information between sessions"] = "儲存生物類型資料",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Save Creature Type Data"] = "储存生物类型信息",
	["Stores creature type information between sessions"] = "在两次登陆的间隔储存生物类型信息",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.creatureType =
{
	type = 'toggle',
	name = L["Save Creature Type Data"],
	desc = L["Stores creature type information between sessions"],
	get = function() return AloftCreatureTypeData.db.profile.save end,
	set = AloftCreatureTypeData.SetSaveData
}

-----------------------------------------------------------------------------
