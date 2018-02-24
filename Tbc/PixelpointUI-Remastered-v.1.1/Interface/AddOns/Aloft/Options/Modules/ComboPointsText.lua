-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ComboPointsText") then return end
local AloftComboPointsText = Aloft:GetModule("ComboPointsText")
local L = AceLibrary("AceLocale-2.2"):new("AloftComboPointsTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Combo Points Text"] = true,
	["Combo points text options"] = true,
	["Enable"] = true,
	["Show combo points text"] = true,
	["Font"] = true, 
	["Sets the font for combo points text"] = true,
	["Font Size"] = true,
	["Sets the font height of the combo points text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on combo points text"] = true,
	["Outline"] = true,
	["Sets the font outline for combo points text"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the combo points text"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the combo points text"] = true,
	["X Offset"] = true,
	["X offset of the combo points text"] = true,
	["Y Offset"] = true,
	["Y offset of the combo points text"] = true,
	["Color"] = true,
	["Sets the combo points text color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

    ["TOPLEFT"] = true,
	["TOP"] = true,
	["TOPRIGHT"] = true,
	["LEFT"] = true,
	["CENTER"] = true,
	["RIGHT"] = true,
	["BOTTOMLEFT"] = true,
	["BOTTOM"] = true,
	["BOTTOMRIGHT"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Combo Points Text"] = "연계 포인트",
	["Combo points text options"] = "연계 포인트 설정",
	["Enable"] = "사용",
	["Show combo points text"] = "연계 포인트를 표시합니다.",
	["Font"] = "글꼴", 
	["Sets the font for combo points text"] = "연계 포인트의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the combo points text"] = "연계 포인트의 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on combo points text"] = "연계 포인트에 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the font outline for combo points text"] = "연계 포인트의 테두리를 설정합니다.",
	["Anchor"] = "앵커", 
	["Sets the anchor for the combo points text"] = "연계 포인트의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the combo points text"] = "생명력바에서 연계 포인트의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the combo points text"] = "연계 포인트의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the combo points text"] = "연계 포인트의 Y 좌표 입니다.",
	["Color"] = "색상",
	["Sets the combo points text color"] = "연계 포인트의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["TOPLEFT"] = "좌측 상단",
	["TOP"] = "상단",
	["TOPRIGHT"] = "우측 상단",
	["LEFT"] = "좌측",
	["CENTER"] = "가운데",
	["RIGHT"] = "우측",
	["BOTTOMLEFT"] = "좌측 하단",
	["BOTTOM"] = "하단",
	["BOTTOMRIGHT"] = "우측 하단",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Combo Points Text"] = "連擊點文字",
	["Combo points text options"] = "連擊點文字選項",
	["Enable"] = "啟用",
	["Show combo points text"] = "顯示連擊點文字",
	["Font"] = "字型", 
	["Sets the font for combo points text"] = "連擊點文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the combo points text"] = "連擊點文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on combo points text"] = "連擊點文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the font outline for combo points text"] = "連擊點文字字型輪廓",
	["Anchor"] = "定位點", 
	["Sets the anchor for the combo points text"] = "連擊點文字定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the combo points text"] = "連擊點文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the combo points text"] = "連擊點文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the combo points text"] = "連擊點文字Y位移",
	["Color"] = "顏色",
	["Sets the combo points text color"] = "連擊點文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

    ["TOPLEFT"] = "左上",
	["TOP"] = "上",
	["TOPRIGHT"] = "右上",
	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
	["BOTTOMLEFT"] = "左下",
	["BOTTOM"] = "下",
	["BOTTOMRIGHT"] = "右下",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Combo Points Text"] = "连击点提示文字",
	["Combo points text options"] = "连击点提示文字相关设置",
	["Enable"] = "启用",
	["Show combo points text"] = "显示连击点提示文字",
	["Font"] = "字体", 
	["Sets the font for combo points text"] = "设定连击点提示文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the combo points text"] = "设定连击点提示文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on combo points text"] = "设定连击点提示文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the font outline for combo points text"] = "设定连击点提示文字的字体轮廓",
	["Anchor"] = "锚点", 
	["Sets the anchor for the combo points text"] = "设定连击点提示文字的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the combo points text"] = "連擊點文字固定在生命力條的位置",
	["X Offset"] = "X轴偏移",
	["X offset of the combo points text"] = "连击点提示文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the combo points text"] = "连击点提示文字的Y轴偏移量",
	["Color"] = "颜色",
	["Sets the combo points text color"] = "设定连击点提示文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

    ["TOPLEFT"] = "左上",
	["TOP"] = "上",
	["TOPRIGHT"] = "右上",
	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
	["BOTTOMLEFT"] = "左下",
	["BOTTOM"] = "下",
	["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.comboPointsText =
{
	type = 'group',
	name = L["Combo Points Text"],
	desc = L["Combo points text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show combo points text"],
			get = function() return AloftComboPointsText.db.profile.enable end,
			set = function(v) AloftComboPointsText.db.profile.enable = v AloftComboPointsText:Update() end,
			order = 1
		},
		font =
		{
			type = "text", 
			name = L["Font"], 
			desc = L["Sets the font for combo points text"],
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.font end,
			set = function(v) AloftComboPointsText.db.profile.font = v AloftComboPointsText:Update() end,
			validate = SML_font,
		},
		fontSize =
		{
			type = 'range',
			name = L["Font Size"],
			desc = L["Sets the font height of the combo points text"],
			max = 16,
			min = 5,
			step = 1,
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.fontSize end,
			set = function(value) AloftComboPointsText.db.profile.fontSize = value AloftComboPointsText:Update() end
		},
		shadow =
		{
			type = 'toggle',
			name = L["Font Shadow"],
			desc = L["Show font shadow on combo points text"],
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.shadow end,
			set = function(v) AloftComboPointsText.db.profile.shadow = v AloftComboPointsText:Update() end
		},
		outline =
		{
			type = 'text',
			name = L["Outline"],
			desc = L["Sets the font outline for combo points text"],
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.outline end,
			set = function(value) AloftComboPointsText.db.profile.outline = value AloftComboPointsText:Update() end,
			validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
		},
		anchor = {
			type = "text", 
			name = L["Anchor"], 
			desc = L["Sets the anchor for the combo points text"],
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.point end,
			set = function(v) AloftComboPointsText.db.profile.point = v AloftComboPointsText:Update() end,
			validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
		},
		anchorto = {
			type = "text", 
			name = L["Anchor To"], 
			desc = L["Sets the relative point on the health bar to anchor the combo points text"],
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.relativeToPoint end,
			set = function(v) AloftComboPointsText.db.profile.relativeToPoint = v AloftComboPointsText:Update() end,
			validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
		},
		offsetX =
		{
			type = 'range',
			name = L["X Offset"],
			desc = L["X offset of the combo points text"],
			min = -32,
			max = 32,
			step = 1,
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.offsetX end,
			set = function(v) AloftComboPointsText.db.profile.offsetX = v AloftComboPointsText:Update() end
		},
		offsetY =
		{
			type = 'range',
			name = L["Y Offset"],
			desc = L["Y offset of the combo points text"],
			min = -32,
			max = 32,
			step = 1,
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return AloftComboPointsText.db.profile.offsetY end,
			set = function(v) AloftComboPointsText.db.profile.offsetY = v AloftComboPointsText:Update() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the combo points text color"],
			disabled = function() return not AloftComboPointsText.db.profile.enable end,
			get = function() return unpack(AloftComboPointsText.db.profile.color) end,
			set = function(r, g, b, a) AloftComboPointsText.db.profile.color = { r, g, b, a } AloftComboPointsText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------
