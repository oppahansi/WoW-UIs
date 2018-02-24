-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ManaText") then return end
local AloftManaText = Aloft:GetModule("ManaText")
local L = AceLibrary("AceLocale-2.2"):new("AloftManaTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Mana Text"] = true,
	["Mana text options"] = true,
	["Enable"] = true,
	["Show mana text on group member nameplates"] = true,

	["Color by type"] = true,
	["Color text differently for mana, energy, rage"] = true,

	["Typeface"] = true,
	["Mana text typeface options"] = true,
	["Font"] = true,
	["Sets the font for mana text"] = true,
	["Font Size"] = true,
	["Sets the font height of the mana text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on mana text"] = true,
	["Outline"] = true,
	["Sets the outline for mana text"] = true,
	["Mode"] = true,
	["Choose what to show for mana text"] = true,

	["Position"] = true,
	["Adjust mana text position"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the mana text"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the mana text"] = true,
	["X Offset"] = true,
	["X offset of the mana text"] = true,
	["Y Offset"] = true,
	["Y offset of the mana text"] = true,
	["Alpha"] = true,
	["Sets the alpha of the mana text"] = true,
	["Color"] = true,
	["Sets the mana text color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,
	
	["Percent"] = true,
	["Deficit"] = true,
	["Mana"] = true,
	["Full"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Format"] = true,
	["Mana tag"] = true,
	["<Any tag string>"] = true,

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
	["Mana Text"] = "마나 수치",
	["Mana text options"] = "마나 수치 설정",
	["Enable"] = "사용",
	["Show mana text on group member nameplates"] = "파티원의 이름표에 마나 수치를 표시합니다.",

	["Color by type"] = "종류별 색상",
	["Color text differently for mana, energy, rage"] = "각각의 마나, 기력, 분노에 따른 수치 색상",

	["Typeface"] = "서체",
	["Mana text typeface options"] = "마나 수치 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for mana text"] = "마나 수치의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the mana text"] = "마나 수치의 글꼴 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on mana text"] = "마나 수치에 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the outline for mana text"] = "마나 수치에 테두리를 설정합니다.",
	["Mode"] = "모드",
	["Choose what to show for mana text"] = "마나 수치의 표시 방법을 선택합니다.",

	["Position"] = "위치",
	["Adjust mana text position"] = "마나 수치의 위치를 조절합니다.",
	["Anchor"] = "앵커", 
	["Sets the anchor for the mana text"] = "마나 수치의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the mana text"] = "생명력바에 마나 수치의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the mana text"] = "마나 수치의 X 좌표입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the mana text"] = "마나 수치의 Y 좌표입니다.",
	["Alpha"] = "투명도",
	["Sets the alpha of the mana text"] = "마나 수치의 투명도를 설정합니다.",
	["Color"] = "색상",
	["Sets the mana text color"] = "마나 수치의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",
	
	["Percent"] = "백분율",
	["Deficit"] = "결손치",
	["Mana"] = "마나",
	["Full"] = "가득",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정",
	["Format"] = "형식",
	["Mana tag"] = "마나 태그",
	["<Any tag string>"] = "<태그 문자열>",

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
	["Mana Text"] = "能力文字",
	["Mana text options"] = "能力文字選項",
	["Enable"] = "啟用",
	["Show mana text on group member nameplates"] = "在團體名牌顯示能力文字",

	["Color by type"] = "根據類型上色",
	["Color text differently for mana, energy, rage"] = "根據不同類型 (法力，能量，怒氣) 設定顏色",

	["Typeface"] = "字體",
	["Mana text typeface options"] = "能力文字字體選項",
	["Font"] = "字型",
	["Sets the font for mana text"] = "能力文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the mana text"] = "能力文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on mana text"] = "能力文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the outline for mana text"] = "能力文字字型輪廓",
	["Mode"] = "模式",
	["Choose what to show for mana text"] = "選擇在能力文字顯示什麼",

	["Position"] = "位置",
	["Adjust mana text position"] = "能力文字位置",
	["Anchor"] = "定位點", 
	["Sets the anchor for the mana text"] = "能力文字定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the mana text"] = "能力文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the mana text"] = "能力文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the mana text"] = "能力文字Y位移",
	["Alpha"] = "透明度",
	["Sets the alpha of the mana text"] = "能力文字透明度",
	["Color"] = "顏色",
	["Sets the mana text color"] = "能力文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",
	
	["Percent"] = "百分比",
	["Deficit"] = "不足額",
	["Mana"] = "能力",
	["Full"] = "完全",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Format"] = "格式",
	["Mana tag"] = "能力標籤",
	["<Any tag string>"] = "<任何標籤文字>",

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
	["Mana Text"] = "法力提示文字",
	["Mana text options"] = "法力提示文字相关设置",
	["Enable"] = "启用",
	["Show mana text on group member nameplates"] = "在队友的姓名板上显示法力文字",

	["Color by type"] = "根据类型显示颜色",
	["Color text differently for mana, energy, rage"] = "根据不同的类型（法力、能量或怒气）显示颜色",

	["Typeface"] = "式样",
	["Mana text typeface options"] = "法力提示文字的式样设置",
	["Font"] = "字体",
	["Sets the font for mana text"] = "设定法力提示文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the mana text"] = "设定法力提示文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on mana text"] = "设定法力提示文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the outline for mana text"] = "设定法力提示文字的字体轮廓",
	["Mode"] = "模式",
	["Choose what to show for mana text"] = "选择在法力提示文字的显示内容",

	["Position"] = "位置",
	["Adjust mana text position"] = "设定法力提示文字的位置",
	["Anchor"] = "锚点", 
	["Sets the anchor for the mana text"] = "设定法力提示文字的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the mana text"] = "设定法力提示文字固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the mana text"] = "设定法力提示文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the mana text"] = "设定法力提示文字的Y轴偏移量",
	["Alpha"] = "透明度",
	["Sets the alpha of the mana text"] = "设定法力提示文字的透明度",
	["Color"] = "颜色",
	["Sets the mana text color"] = "设定法力提示文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",
	
	["Percent"] = "百分比",
	["Deficit"] = "不足额",
	["Mana"] = "法力",
	["Full"] = "完全",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Format"] = "格式",
	["Mana tag"] = "法力标签",
	["<Any tag string>"] = "<任意标签文字>",

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

local manaTags =
{
	NONE	= { "", "" },
	PERCENT	= { "[ManaFraction:Percent]", "[ManaFraction:Percent:PowerTypeColor]" },
	MANA	= { "[Mana:Short]", "[Mana:Short:PowerTypeColor]" },
	DEFICIT	= { "[ManaDeficit:HideZero:Short]", "[ManaDeficit:HideZero:Short:PowerTypeColor]" },
	FULL	= { "[Mana:Short:Suffix(\" (\")][ManaFraction:Percent:Suffix(\")\")]", "[Mana:Short:Suffix(\" (\"):PowerTypeColor][ManaFraction:Percent:Suffix(\")\"):PowerTypeColor]" },
}

-----------------------------------------------------------------------------

Aloft.Options.args.manaBar.args.manaText =
{
	type = 'group',
	name = L["Mana Text"],
	desc = L["Mana text options"],
	disabled = function() return not Aloft:IsActive() end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show mana text on group member nameplates"],
			get = function() return AloftManaText.db.profile.enable end,
			set = function(v) AloftManaText.db.profile.enable = v AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Mana text typeface options"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for mana text"],
					get = function() return AloftManaText.db.profile.font end,
					set = function(v) AloftManaText.db.profile.font = v AloftManaText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the mana text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftManaText.db.profile.fontSize end,
					set = function(value) AloftManaText.db.profile.fontSize = value AloftManaText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on mana text"],
					get = function() return AloftManaText.db.profile.shadow end,
					set = function(v) AloftManaText.db.profile.shadow = v AloftManaText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for mana text"],
					get = function() return AloftManaText.db.profile.outline end,
					set = function(value) AloftManaText.db.profile.outline = value AloftManaText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		colorByType =
		{
			type = 'toggle',
			name = L["Color by type"],
			desc = L["Color text differently for mana, energy, rage"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return AloftManaText.db.profile.colorByType end,
			set = function(value) AloftManaText.db.profile.colorByType = value AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
		},
		mode =
		{
			type = 'text',
			name = L["Mode"],
			desc = L["Choose what to show for mana text"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return AloftManaText.db.profile.mode end,
			set = function(value) AloftManaText.db.profile.mode = value AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
			validate = { PERCENT = L["Percent"], DEFICIT = L["Deficit"], MANA = L["Mana"], FULL = L["Full"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust mana text position"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the mana text"],
					get = function() return AloftManaText.db.profile.point end,
					set = function(v) AloftManaText.db.profile.point = v AloftManaText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the mana text"],
					get = function() return AloftManaText.db.profile.relativeToPoint end,
					set = function(v) AloftManaText.db.profile.relativeToPoint = v AloftManaText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the mana text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftManaText.db.profile.offsetX end,
					set = function(v) AloftManaText.db.profile.offsetX = v AloftManaText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the mana text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftManaText.db.profile.offsetY end,
					set = function(v) AloftManaText.db.profile.offsetY = v AloftManaText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the mana text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return AloftManaText.db.profile.alpha end,
			set = function(v) AloftManaText.db.profile.alpha = v AloftManaText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the mana text color"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return unpack(AloftManaText.db.profile.color) end,
			set = function(r, g, b, a) AloftManaText.db.profile.color = { r, g, b, a } AloftManaText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftManaText.db.profile.enable end,
			args =
			{
				format = 
				{
					type = 'text',
					name = L["Format"],
					desc = L["Mana tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftManaText.db.profile.format) end,
					set = function(v) AloftManaText.db.profile.format = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftManaText:UpdateAll() end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

function AloftManaText:UpdateTag()
	local tag = self.db.profile.mode
	local index = 1
	
	if self.db.profile.colorByType then 
		index = 2
	end
	
	if not self.db.profile.enable then tag = "NONE"	end
	self.db.profile.format = manaTags[tag][index]

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------
