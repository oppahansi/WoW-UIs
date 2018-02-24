-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("PetOwnersNameData") then return end
local L = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameTextOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Pet Owner's Names"] = true,
	["Select how to show pet owner's names"] = true,

	["NONE"]	= "None",
	["HYPHEN"]	= "Pet - Owner",
	["SLASH"]	= "Pet / Owner",
	["BRACKET"]	= "Pet (Owner)",
	["COLON"]	= "Pet : Owner",
} end)

L:RegisterTranslations("koKR", function() return {
	["Pet Owner's Names"] = "소환수 소유자명",
	["Select how to show pet owner's names"] = "소솬수 소유자명의 표시 방법을 선택합니다.",

	["NONE"]	= "없음",
	["HYPHEN"]	= "소환수 - 소유자",
	["SLASH"]	= "소환수 / 소유자",
	["BRACKET"]	= "소환수 (소유자)",
	["COLON"]	= "소환수 : 소유자",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Pet Owner's Names"] = "寵物主人的名字",
	["Select how to show pet owner's names"] = "選擇怎樣顯示寵物主人的名字",

	["NONE"]	= "無",
	["HYPHEN"]	= "寵物 - 主人",
	["SLASH"]	= "寵物 / 主人",
	["BRACKET"]	= "寵物 (主人)",
	["COLON"]	= "寵物 : 主人",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Pet Owner's Names"] = "宠物主人名称",
	["Select how to show pet owner's names"] = "设定宠物主人名称的显示方式",

	["NONE"]	= "无",
	["HYPHEN"]	= "宠物名 - 主人名",
	["SLASH"]	= "宠物名 / 主人名",
	["BRACKET"]	= "宠物名（主人名）",
	["COLON"]	= "宠物名 : 主人名",
} end)

-----------------------------------------------------------------------------

local attachFormats =
{
	["NONE"]	= "",
	["HYPHEN"]	= "[PetOwnersName:Prefix(\" - \")]",
	["SLASH"]	= "[PetOwnersName:Prefix(\" / \")]",
	["BRACKET"]	= "[PetOwnersName:Surround(\" (\", \")\")]",
	["COLON"]	= "[PetOwnersName:Prefix(\" : \")]",
}

-----------------------------------------------------------------------------

local AloftNameText = Aloft:GetModule("NameText")

Aloft.Options.args.nameText.args.petOwnersName =
{
	type = 'text',
	name = L["Pet Owner's Names"],
	desc = L["Select how to show pet owner's names"],
	disabled = function() return not AloftNameText.db.profile.enable end,
	get = function() return AloftNameText.db.profile.petOwnersName or "NONE" end,
	set = function(v) AloftNameText.db.profile.petOwnersName = v AloftNameText:UpdateFormatTag() Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
	validate = { NONE = L["NONE"], HYPHEN = L["HYPHEN"], SLASH = L["SLASH"], BRACKET = L["BRACKET"], COLON = L["COLON"] },
}

-----------------------------------------------------------------------------

local function NameTextTagModifier()
	AloftNameText.db.profile.format = AloftNameText.db.profile.format..attachFormats[AloftNameText.db.profile.petOwnersName or "NONE"]
end

AloftNameText:RegisterFormatTagModifier(2, NameTextTagModifier)

-----------------------------------------------------------------------------

