-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("RaceData") then return end
local AloftRaceData = Aloft:GetModule("RaceData")
local L = AceLibrary("AceLocale-2.2"):new("AloftRaceDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Save Race Data"] = true,
	["Stores race information between sessions"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Save Race Data"] = "종족 데이터 저장",
	["Stores race information between sessions"] = "접속 간 종족 정보를 저장합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Save Race Data"] = "儲存種族資料",
	["Stores race information between sessions"] = "儲存種族資料",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Save Race Data"] = "储存种族信息",
	["Stores race information between sessions"] = "在两次登录的间隔储存种族信息",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.race =
{
	type = 'toggle',
	name = L["Save Race Data"],
	desc = L["Stores race information between sessions"],
	get = function() return AloftRaceData.db.profile.save end,
	set = AloftRaceData.SetSaveData
}

-----------------------------------------------------------------------------
