-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ShortGuildData") then return end
local AloftShortGuildData = Aloft:GetModule("ShortGuildData")
local L = AceLibrary("AceLocale-2.2"):new("AloftShortGuildDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Reset Short Guilds"] = true,
	["Empties the custom short guild database"] = true,

	["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Reset Short Guilds"] = "짧은 길드 초기화",
	["Empties the custom short guild database"] = "사용자의 짧은 길드 데이터베이스를 삭제합니다.",

	["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "당신의 짧은 길드명 데이터를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Reset Short Guilds"] = "重設簡短公會名字",
	["Empties the custom short guild database"] = "清空簡短公會名字資料庫",

	["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空簡短公會名字資料庫?",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Reset Short Guilds"] = "重置公会简称",
	["Empties the custom short guild database"] = "清空公会简称的信息库。",

	["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "你是否真要清空公会简称信息库？",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.shortGuild =
{
    type = "execute",
    name = L["Reset Short Guilds"],
    desc = L["Empties the custom short guild database"],
    func = function() AloftShortGuildData:ClearAllData() end,
    confirm = L["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"]
}

-----------------------------------------------------------------------------
