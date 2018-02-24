-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("CastBarTimeText") then return end
local AloftCastBarTimeText = Aloft:GetModule("CastBarTimeText")
local L = AceLibrary("AceLocale-2.2"):new("AloftCastBarTimeTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Time Text"] = true,
	["Cast bar time text options"] = true,
	["Enable"] = true,
	["Show cast bar time text"] = true,
	["Typeface"] = true,
	["Cast bar time text typeface options"] = true,
	["Font"] = true, 
	["Sets the font for cast bar time text"] = true,
	["Font Size"] = true,
	["Sets the font height of the cast bar time text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on cast bar time text"] = true,
	["Alignment"] = true,
	["Sets the alignment of the cast bar time text"] = true,
	["Outline"] = true,
	["Sets the font outline for cast bar time text"] = true,
	["Position"] = true,
	["Adjust cast bar time text position"] = true,
	["Left Offset"] = true,
	["Sets the offset of the left of the text"] = true,
	["Right Offset"] = true,
	["Sets the offset of the right of the text"] = true,
	["Vertical Offset"] = true,
	["Sets the vertical offset of the text"] = true,
	["Color"] = true,
	["Sets the cast bar time text color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

	["LEFT"] = true,
	["CENTER"] = true,
	["RIGHT"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Time Text"] = "시전 시간",
	["Cast bar time text options"] = "시전 시간 설정",
	["Enable"] = "사용",
	["Show cast bar time text"] = "시전바에 시간을 표시합니다.",
	["Typeface"] = "서체",
	["Cast bar time text typeface options"] = "시전 시간 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for cast bar time text"] = "시전 시간의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the cast bar time text"] = "시전 시간의 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on cast bar time text"] = "시전 시간에 그림자를 표시합니다.",
	["Alignment"] = "정렬",
	["Sets the alignment of the cast bar time text"] = "시전 시간의 정렬을 설정합니다.",
	["Outline"] = "테두리",
	["Sets the font outline for cast bar time text"] = "시전 시간의 테두리를 설정합니다.",
	["Position"] = "위치",
	["Adjust cast bar time text position"] = "시전 시간 위치 조절",
	["Left Offset"] = "좌측 좌표",
	["Sets the offset of the left of the text"] = "시전 시간의 좌측 좌표를 설정합니다.",
	["Right Offset"] = "우측 좌표",
	["Sets the offset of the right of the text"] = "시전 시간의 우측 좌표를 설정합니다.",
	["Vertical Offset"] = "수직 좌표",
	["Sets the vertical offset of the text"] = "시전 시간의 수직 좌표를 설정합니다.",
	["Color"] = "색상",
	["Sets the cast bar time text color"] = "시전 시간의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["LEFT"] = "좌측",
	["CENTER"] = "가운데",
	["RIGHT"] = "우측",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Time Text"] = "時間文字",
	["Cast bar time text options"] = "施法條時間文字選項",
	["Enable"] = "啟用",
	["Show cast bar time text"] = "顯示施法條時間文字",
	["Typeface"] = "字體",
	["Cast bar time text typeface options"] = "施法條時間文字字體選項",
	["Font"] = "字型", 
	["Sets the font for cast bar time text"] = "施法條時間文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the cast bar time text"] = "施法條時間文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on cast bar time text"] = "施法條時間文字字型陰影",
	["Alignment"] = "對齊",
	["Sets the alignment of the cast bar time text"] = "施法條時間文字對齊",
	["Outline"] = "輪廓",
	["Sets the font outline for cast bar time text"] = "施法條時間文字字型輪廓",
	["Position"] = "位置",
	["Adjust cast bar time text position"] = "施法條時間文字位置",
	["Left Offset"] = "左位移",
	["Sets the offset of the left of the text"] = "文字左位移",
	["Right Offset"] = "右位移",
	["Sets the offset of the right of the text"] = "文字右位移",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the text"] = "文字垂直位移",
	["Color"] = "顏色",
	["Sets the cast bar time text color"] = "施法條時間文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Time Text"] = "计时文字",
	["Cast bar time text options"] = "施法条计时文字相关设置",
	["Enable"] = "启用",
	["Show cast bar time text"] = "显示施法条计时文字",
	["Typeface"] = "式样",
	["Cast bar time text typeface options"] = "施法条计时文字式样设置",
	["Font"] = "字体", 
	["Sets the font for cast bar time text"] = "设定施法条计时文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the cast bar time text"] = "设定施法条计时文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on cast bar time text"] = "设定施法条计时文字的字体阴影",
	["Alignment"] = "对齐",
	["Sets the alignment of the cast bar time text"] = "设定施法条计时文字的对齐方式",
	["Outline"] = "轮廓",
	["Sets the font outline for cast bar time text"] = "设定施法条计时文字的字体轮廓",
	["Position"] = "位置",
	["Adjust cast bar time text position"] = "调整施法条计时文字的位置",
	["Left Offset"] = "向左偏移",
	["Sets the offset of the left of the text"] = "设定文字的向左偏移量",
	["Right Offset"] = "向右偏移",
	["Sets the offset of the right of the text"] = "设定文字的向右偏移量",
	["Vertical Offset"] = "垂直偏移",
	["Sets the vertical offset of the text"] = "设定文字的垂直偏移量",
	["Color"] = "颜色",
	["Sets the cast bar time text color"] = "设定施法条计时文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.castBarTimeText =
{
	type = 'group',
	name = L["Time Text"],
	desc = L["Cast bar time text options"],
	disabled = function() return not Aloft:IsActive() or GetCVar("ShowVKeyCastbar") ~= "1" end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show cast bar time text"],
			get = function() return AloftCastBarTimeText.db.profile.enable end,
			set = function(v) AloftCastBarTimeText.db.profile.enable = v AloftCastBarTimeText:Update() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Cast bar time text typeface options"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for cast bar time text"],
					get = function() return AloftCastBarTimeText.db.profile.font end,
					set = function(v) AloftCastBarTimeText.db.profile.font = v AloftCastBarTimeText:Update() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the cast bar time text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.fontSize end,
					set = function(value) AloftCastBarTimeText.db.profile.fontSize = value AloftCastBarTimeText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on cast bar time text"],
					get = function() return AloftCastBarTimeText.db.profile.shadow end,
					set = function(v) AloftCastBarTimeText.db.profile.shadow = v AloftCastBarTimeText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for cast bar time text"],
					get = function() return AloftCastBarTimeText.db.profile.outline end,
					set = function(value) AloftCastBarTimeText.db.profile.outline = value AloftCastBarTimeText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the cast bar time text"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			get = function() return AloftCastBarTimeText.db.profile.alignment end,
			set = function(value) AloftCastBarTimeText.db.profile.alignment = value AloftCastBarTimeText:Update() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast bar time text position"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.offsets.left end,
					set = function(v) AloftCastBarTimeText.db.profile.offsets.left = v AloftCastBarTimeText:Update() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.offsets.right end,
					set = function(v) AloftCastBarTimeText.db.profile.offsets.right = v AloftCastBarTimeText:Update() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.offsets.vertical end,
					set = function(v) AloftCastBarTimeText.db.profile.offsets.vertical = v AloftCastBarTimeText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the cast bar time text color"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			get = function() return unpack(AloftCastBarTimeText.db.profile.color) end,
			set = function(r, g, b, a) AloftCastBarTimeText.db.profile.color = { r, g, b, a } AloftCastBarTimeText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------
