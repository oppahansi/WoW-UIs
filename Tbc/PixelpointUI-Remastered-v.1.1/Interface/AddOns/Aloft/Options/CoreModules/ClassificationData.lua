-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ClassificationData") then return end
local AloftClassificationData = Aloft:GetModule("ClassificationData")
local L = AceLibrary("AceLocale-2.2"):new("AloftClassificationDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Save Classification Data"] = true,
	["Stores unit classification information between sessions"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Save Classification Data"] = "구분 데이터 저장",
	["Stores unit classification information between sessions"] = "각 접속간 대상의 구분 정보를 저장합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Save Classification Data"] = "儲存分類資料",
	["Stores unit classification information between sessions"] = "儲存分類資料",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Save Classification Data"] = "储存分类信息",
	["Stores unit classification information between sessions"] = "在两次登录的间隔储存分类信息",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.classification =
{
	type = 'toggle',
	name = L["Save Classification Data"],
	desc = L["Stores unit classification information between sessions"],
	get = function() return AloftClassificationData.db.profile.save end,
	set = AloftClassificationData.SetSaveData
}

-----------------------------------------------------------------------------
