-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("AliasData") then return end
local L = AceLibrary("AceLocale-2.2"):new("AloftAliasDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Reset Aliases"] = true,
	["Empties the alias database"] = true,

	["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Reset Aliases"] = "별명 초기화",
	["Empties the alias database"] = "별명 데이터베이스를 삭제합니다.",

	["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "별명 데이터베이스를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Reset Aliases"] = "重設別名",
	["Empties the alias database"] = "清空別名資料庫",

	["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空別名資料庫?",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Reset Aliases"] = "重设绰号",
	["Empties the alias database"] = "清空绰号资料库",

	["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "你是否真得要清空绰号资料库？本操作不可逆！",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.alias =
{
    type = "execute",
    name = L["Reset Aliases"],
    desc = L["Empties the alias database"],
    func = function() Aloft:GetModule("AliasData"):ClearAllData() end,
    confirm = L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"]
}

-----------------------------------------------------------------------------
