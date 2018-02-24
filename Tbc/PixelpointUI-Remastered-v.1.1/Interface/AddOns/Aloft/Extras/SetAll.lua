-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftSetAll")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Set All"] = true,
	["Set all options"] = true,
	["Textures"] = true,
	["Sets the texture for all status bars in Aloft"] = true,
	["Fonts"] = true,
	["Sets the font for all text in Aloft"] = true,
	["Font Sizes"] = true,
	["Sets the fonts size for all text in Aloft"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Set All"] = "전체 설정",
	["Set all options"] = "전체 설정을 변경합니다.",
	["Textures"] = "텍스쳐",
	["Sets the texture for all status bars in Aloft"] = "모든 상태바의 텍스쳐를 설정합니다.",
	["Fonts"] = "글꼴",
	["Sets the font for all text in Aloft"] = "모든 글자의 글꼴을 설정합니다.",
	["Font Sizes"] = "글꼴 크기",
	["Sets the fonts size for all text in Aloft"] = "모든 글자의 글꼴 크기를 설정합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Set All"] = "設定全部",
	["Set all options"] = "設定全部選項",
	["Textures"] = "紋理",
	["Sets the texture for all status bars in Aloft"] = "設定全部 Aloft 狀態條的紋理",
	["Fonts"] = "字型",
	["Sets the font for all text in Aloft"] = "設定全部 Aloft 文字的字型",
	["Font Sizes"] = "字型大小",
	["Sets the fonts size for all text in Aloft"] = "設定全部 Aloft 文字的字型大小",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Set All"] = "设置全部",
	["Set all options"] = "设定全部选项",
	["Textures"] = "材质",
	["Sets the texture for all status bars in Aloft"] = "设定全部Aloft状态条的材质",
	["Fonts"] = "字体",
	["Sets the font for all text in Aloft"] = "设定全部Aloft文字的字体",
	["Font Sizes"] = "字号",
	["Sets the fonts size for all text in Aloft"] = "设定全部Aloft文字的字号",
} end)

-----------------------------------------------------------------------------

local lastSetTexture = ""
local lastSetFont = ""
local lastSetFontSize = 10

-----------------------------------------------------------------------------

Aloft.Options.args.setAll =
{
	type = 'group',
	name = L["Set All"],
	desc = L["Set all options"],
	disabled = function() return not Aloft:IsActive() end,
	order = 600,
	args =
	{
		texture =
		{
			type = "text", 
			name = L["Textures"], 
			desc = L["Sets the texture for all status bars in Aloft"],
			get = function() return lastSetTexture end,
			set = function(v) lastSetTexture = v Aloft:TriggerEvent("Aloft:SetAll", "texture", v) end,
			validate = SML_statusbar,
		},
		font =
		{
			type = "text", 
			name = L["Fonts"], 
			desc = L["Sets the font for all text in Aloft"],
			get = function() return lastSetFont end,
			set = function(v) lastSetFont = v Aloft:TriggerEvent("Aloft:SetAll", "font", v) end,
			validate = SML_font,
		},
		fontSize =
		{
			type = 'range',
			name = L["Font Sizes"],
			desc = L["Sets the fonts size for all text in Aloft"],
			max = 16,
			min = 4,
			step = 1,
			get = function() return lastSetFontSize end,
			set = function(v) if lastSetFontSize ~= v then lastSetFontSize = v Aloft:TriggerEvent("Aloft:SetAll", "fontSize", v) end end
		},
	}
}

-----------------------------------------------------------------------------
