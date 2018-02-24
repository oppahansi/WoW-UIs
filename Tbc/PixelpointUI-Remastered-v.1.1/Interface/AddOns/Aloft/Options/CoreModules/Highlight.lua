-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("Highlight") then return end
local AloftHighlight = Aloft:GetModule("Highlight")
local L = AceLibrary("AceLocale-2.2"):new("AloftHighlightOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Highlight"] = true,
	["Mouseover highlight options"] = true,
	["Color"] = true,
	["Sets the highlight color"] = true,
	["Texture"] = true,
	["Sets the highlight texture"] = true,
	["Blend Mode"] = true,
	["Sets the blend mode for the highlight texture"] = true,

	["BLEND"] = true,
    ["ADD"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Highlight"] = "강조",
	["Mouseover highlight options"] = "마우스 오버 시 강조 설정",
	["Color"] = "색상",
	["Sets the highlight color"] = "강조 색상을 설정합니다.",
	["Texture"] = "텍스쳐",
	["Sets the highlight texture"] = "강조 텍스쳐를 설정합니다.",
	["Blend Mode"] = "혼합 모드",
	["Sets the blend mode for the highlight texture"] = "강조 텍스쳐에 혼합 모드를 설정합니다.",

	["BLEND"] = "혼합",
	["ADD"] = "추가",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Highlight"] = "高亮",
	["Mouseover highlight options"] = "滑鼠目標高亮選項",
	["Color"] = "顏色",
	["Sets the highlight color"] = "高亮的顏色",
	["Texture"] = "紋理",
	["Sets the highlight texture"] = "高亮的紋理",
	["Blend Mode"] = "交融模式",
	["Sets the blend mode for the highlight texture"] = "高亮的紋理的交融模式",

	["BLEND"] = "混合",
    ["ADD"] = "增加",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Highlight"] = "高亮",
	["Mouseover highlight options"] = "鼠标悬浮目标高亮相关设置",
	["Color"] = "颜色",
	["Sets the highlight color"] = "设定高亮的颜色",
	["Texture"] = "材质",
	["Sets the highlight texture"] = "设定高亮的材质",
	["Blend Mode"] = "渲染模式",
	["Sets the blend mode for the highlight texture"] = "设定高亮的材质渲染模式",

	["BLEND"] = "渲染",
    ["ADD"] = "增加",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar.args.highlight =
{
	type = 'group',
	name = L["Highlight"],
	desc = L["Mouseover highlight options"],
	disabled = function() return not Aloft:IsActive() end,
	order = -1,
	args =
	{
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the highlight color"],
			get = function() return unpack(AloftHighlight.db.profile.color) end,
			set = function(r, g, b, a) AloftHighlight.db.profile.color = { r, g, b, a } AloftHighlight:UpdateAll() end,
			hasAlpha = true
		},
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the highlight texture"],
			get = function() return AloftHighlight.db.profile.texture end,
			set = function(v) AloftHighlight.db.profile.texture = v AloftHighlight:UpdateAll() end,
			validate = SML_statusbar,
		},
		mode =
		{
			type = "text",
			name = L["Blend Mode"],
			desc = L["Sets the blend mode for the highlight texture"],
			get = function() return AloftHighlight.db.profile.blendMode end,
			set = function(v) AloftHighlight.db.profile.blendMode = v AloftHighlight:UpdateAll() end,
			validate = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
		},
	},
}

-----------------------------------------------------------------------------
