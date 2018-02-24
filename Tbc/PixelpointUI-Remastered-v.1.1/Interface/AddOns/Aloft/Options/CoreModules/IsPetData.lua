-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("IsPetData") then return end
local AloftIsPetData = Aloft:GetModule("IsPetData")
local L = AceLibrary("AceLocale-2.2"):new("AloftIsPetDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Save Pet Data"] = true,
	["Stores pet information between sessions"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Save Pet Data"] = "소환수 데이터 저장",
	["Stores pet information between sessions"] = "접속 간 소환수 정보를 저장합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Save Pet Data"] = "儲存寵物資料",
	["Stores pet information between sessions"] = "儲存寵物資料",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Save Pet Data"] = "储存宠物信息",
	["Stores pet information between sessions"] = "在两次登录的间隔储存宠物信息",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.pet =
{
	type = 'toggle',
	name = L["Save Pet Data"],
	desc = L["Stores pet information between sessions"],
	get = function() return AloftIsPetData.db.profile.save end,
	set = AloftIsPetData.SetSaveData
}

-----------------------------------------------------------------------------
