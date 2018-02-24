-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("SpellNameText") then return end
local AloftSpellNameText = Aloft:GetModule("SpellNameText")
local L = AceLibrary("AceLocale-2.2"):new("AloftSpellNameTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Spell Name"] = true,
	["Cast bar spell name text options"] = true,
	["Enable"] = true,
	["Show spell name on cast bar"] = true,
	["Typeface"] = true,
	["Spell name typeface options"] = true,
	["Font"] = true, 
	["Sets the font for spell name"] = true,
	["Font Size"] = true,
	["Sets the font height of the spell name"] = true,
	["Font Shadow"] = true,
	["Show font shadow on spell name"] = true,
	["Alignment"] = true,
	["Sets the alignment of the spell name"] = true,
	["Outline"] = true,
	["Sets the font outline for spell name"] = true,
	["Position"] = true,
	["Adjust spell name position"] = true,
	["Left Offset"] = true,
	["Sets the offset of the left of the text"] = true,
	["Right Offset"] = true,
	["Sets the offset of the right of the text"] = true,
	["Vertical Offset"] = true,
	["Sets the vertical offset of the text"] = true,
	["Color"] = true,
	["Sets the spell name color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

	["LEFT"] = true,
	["CENTER"] = true,
	["RIGHT"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Spell Name"] = "주문명",
	["Cast bar spell name text options"] = "시전바 주문명 글자 설정",
	["Enable"] = "사용",
	["Show spell name on cast bar"] = "시전바에 주문명을 표시합니다.",
	["Typeface"] = "서체",
	["Spell name typeface options"] = "주문명 서체 설정",
	["Font"] = "글꼴", 
	["Sets the font for spell name"] = "주문명의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the spell name"] = "주문명 글자의 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on spell name"] = "주문명에 그림자를 표시합니다.",
	["Alignment"] = "정렬",
	["Sets the alignment of the spell name"] = "주문명의 정렬을 설정합니다.",
	["Outline"] = "테두리",
	["Sets the font outline for spell name"] = "주문명의 테두리를 설정합니다.",
	["Position"] = "위치",
	["Adjust spell name position"] = "주문명 위치 조절",
	["Left Offset"] = "좌측 좌표",
	["Sets the offset of the left of the text"] = "글자의 좌측 좌표를 설정합니다.",
	["Right Offset"] = "우측 좌표",
	["Sets the offset of the right of the text"] = "글자의 우측 좌표를 설정합니다.",
	["Vertical Offset"] = "수직 좌표",
	["Sets the vertical offset of the text"] = "글자의 수직 좌표를 설정합니다.",
	["Color"] = "색상",
	["Sets the spell name color"] = "주문명의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["LEFT"] = "좌측",
	["CENTER"] = "가운데",
	["RIGHT"] = "우측",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Spell Name"] = "法術名字",
	["Cast bar spell name text options"] = "施法條法術名字文字選項",
	["Enable"] = "啟用",
	["Show spell name on cast bar"] = "在施法條顯示法術名字",
	["Typeface"] = "字體",
	["Spell name typeface options"] = "法術名字字體選項",
	["Font"] = "字型", 
	["Sets the font for spell name"] = "法術名字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the spell name"] = "法術名字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on spell name"] = "法術名字字型陰影",
	["Alignment"] = "對齊",
	["Sets the alignment of the spell name"] = "法術名字對齊",
	["Outline"] = "輪廓",
	["Sets the font outline for spell name"] = "法術名字字型輪廓",
	["Position"] = "位置",
	["Adjust spell name position"] = "法術名字位置",
	["Left Offset"] = "左位移",
	["Sets the offset of the left of the text"] = "文字左位移",
	["Right Offset"] = "右位移",
	["Sets the offset of the right of the text"] = "文字右位移",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the text"] = "文字垂直位移",
	["Color"] = "顏色",
	["Sets the spell name color"] = "法術名字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Spell Name"] = "法术名称",
	["Cast bar spell name text options"] = "施法条法术名称文字相关设置",
	["Enable"] = "启用",
	["Show spell name on cast bar"] = "在施法条上显示法术名称",
	["Typeface"] = "字体",
	["Spell name typeface options"] = "法术名称文字式样设置",
	["Font"] = "字体", 
	["Sets the font for spell name"] = "设定法术名称文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the spell name"] = "设定法术名称文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on spell name"] = "设定法术名称文字的字体阴影",
	["Alignment"] = "对齐",
	["Sets the alignment of the spell name"] = "设定法术名称文字的字体的对齐方式",
	["Outline"] = "轮廓",
	["Sets the font outline for spell name"] = "设定法术名称文字的字体轮廓",
	["Position"] = "位置",
	["Adjust spell name position"] = "调整法术名称文字的位置",
	["Left Offset"] = "向左偏移",
	["Sets the offset of the left of the text"] = "设定法术名称文字的向左偏移量",
	["Right Offset"] = "向右偏移",
	["Sets the offset of the right of the text"] = "设定法术名称文字的向右偏移量",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the text"] = "设定法术名称文字的垂直偏移量",
	["Color"] = "颜色",
	["Sets the spell name color"] = "设定法术名称文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.spellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Cast bar spell name text options"],
	disabled = function() return not Aloft:IsActive() or GetCVar("ShowVKeyCastbar") ~= "1" end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show spell name on cast bar"],
			get = function() return AloftSpellNameText.db.profile.enable end,
			set = function(v) AloftSpellNameText.db.profile.enable = v AloftSpellNameText:Update() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for spell name"],
					get = function() return AloftSpellNameText.db.profile.font end,
					set = function(v) AloftSpellNameText.db.profile.font = v AloftSpellNameText:Update() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the spell name"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftSpellNameText.db.profile.fontSize end,
					set = function(value) AloftSpellNameText.db.profile.fontSize = value AloftSpellNameText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function() return AloftSpellNameText.db.profile.shadow end,
					set = function(v) AloftSpellNameText.db.profile.shadow = v AloftSpellNameText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function() return AloftSpellNameText.db.profile.outline end,
					set = function(value) AloftSpellNameText.db.profile.outline = value AloftSpellNameText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell name"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
			get = function() return AloftSpellNameText.db.profile.alignment end,
			set = function(value) AloftSpellNameText.db.profile.alignment = value AloftSpellNameText:Update() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
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
					get = function() return AloftSpellNameText.db.profile.offsets.left end,
					set = function(v) AloftSpellNameText.db.profile.offsets.left = v AloftSpellNameText:Update() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellNameText.db.profile.offsets.right end,
					set = function(v) AloftSpellNameText.db.profile.offsets.right = v AloftSpellNameText:Update() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellNameText.db.profile.offsets.vertical end,
					set = function(v) AloftSpellNameText.db.profile.offsets.vertical = v AloftSpellNameText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the spell name color"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
			get = function() return unpack(AloftSpellNameText.db.profile.color) end,
			set = function(r, g, b, a) AloftSpellNameText.db.profile.color = { r, g, b, a } AloftSpellNameText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------
