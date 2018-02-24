-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("GuildData") then return end
local AloftGuildData = Aloft:GetModule("GuildData")
local L = AceLibrary("AceLocale-2.2"):new("AloftGuildDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Save Guild Data"] = true,
	["Stores guild information between sessions"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Save Guild Data"] = "길드 데이터 저장",
	["Stores guild information between sessions"] = "접속 간 길드 정보를 저장하니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Save Guild Data"] = "儲存公會資料",
	["Stores guild information between sessions"] = "儲存公會資料",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Save Guild Data"] = "储存公会信息",
	["Stores guild information between sessions"] = "在两次登录的间隔储存公会信息",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.guild =
{
	type = 'toggle',
	name = L["Save Guild Data"],
	desc = L["Stores guild information between sessions"],
	get = function() return AloftGuildData.db.profile.save end,
	set = AloftGuildData.SetSaveData
}

-----------------------------------------------------------------------------
