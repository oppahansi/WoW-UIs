-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ClassData") then return end
local AloftClassData = Aloft:GetModule("ClassData")
local L = AceLibrary("AceLocale-2.2"):new("AloftClassDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Save Class Data"] = true,
	["Stores player class information between sessions"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Save Class Data"] = "직업 데이터 저장",
	["Stores player class information between sessions"] = "접속 간 플레이어 직업 정보를 저장합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Save Class Data"] = "儲存職業資料",
	["Stores player class information between sessions"] = "儲存職業資料",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Save Class Data"] = "储存职业信息",
	["Stores player class information between sessions"] = "在两次登录的间隔储存职业信息",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.class =
{
	type = 'toggle',
	name = L["Save Class Data"],
	desc = L["Stores player class information between sessions"],
	get = function() return AloftClassData.db.profile.save end,
	set = AloftClassData.SetSaveData
}

-----------------------------------------------------------------------------
