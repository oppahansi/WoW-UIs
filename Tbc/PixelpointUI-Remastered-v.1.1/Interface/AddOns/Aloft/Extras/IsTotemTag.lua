-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("IsTotemTag")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["TotemPattern"] = " Totem$"
} end)

L:RegisterTranslations("koKR", function() return {
	["TotemPattern"] = " 토템$"
} end)

L:RegisterTranslations("zhTW", function() return {
	["TotemPattern"] = "圖騰$"
} end)

L:RegisterTranslations("zhCN", function() return {
	["TotemPattern"] = "图腾$"
} end)

-----------------------------------------------------------------------------

Aloft.TagData.IsTotem =
{
	method = function(aloftData, value) return aloftData.name:find(L["TotemPattern"]) and value end
}

-----------------------------------------------------------------------------
