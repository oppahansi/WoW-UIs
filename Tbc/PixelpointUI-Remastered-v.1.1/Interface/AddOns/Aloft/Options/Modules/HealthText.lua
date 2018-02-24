-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("HealthText") then return end
local AloftHealthText = Aloft:GetModule("HealthText")
local L = AceLibrary("AceLocale-2.2"):new("AloftHealthTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Health Text"] = true,
	["Health text options"] = true,
	["Enable"] = true,
	["Show health text on nameplates"] = true,

	["Typeface"] = true,
	["Health text typeface options"] = true,
	["Font"] = true,
	["Sets the font for health text"] = true,
	["Font Size"] = true,
	["Sets the font height of the health text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on health text"] = true,
	["Outline"] = true,
	["Sets the outline for health text"] = true,
	["Mode"] = true,
	["Choose what to show for health text"] = true,

	["Position"] = true,
	["Adjust health text position"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the health text"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the health text"] = true,
	["X Offset"] = true,
	["X offset of the health text"] = true,
	["Y Offset"] = true,
	["Y offset of the health text"] = true,
	["Alpha"] = true,
	["Sets the alpha of the health text"] = true,
	["Color"] = true,
	["Sets the health text color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,
	
	["Percent"] = true,
	["Group Health"] = true,
	["Group Health Deficit"] = true,
	["Health"] = true,
	["Health & Percent"] = true,
	["Full"] = true,
	["Smart"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Format"] = true,
	["Health tag"] = true,
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
	["Health Text"] = "생명력 수치",
	["Health text options"] = "생명력 수치 설정",
	["Enable"] = "사용",
	["Show health text on nameplates"] = "이름표에 생명력 수치를 표시합니다.",

	["Typeface"] = "서체",
	["Health text typeface options"] = "생명력 수치 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for health text"] = "생명력 수치의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the health text"] = "생명력 수치의 크기를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on health text"] = "생명력 수치에 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the outline for health text"] = "생명력 수치의 테두리를 설정합니다.",
	["Mode"] = "모드",
	["Choose what to show for health text"] = "생명력 수치의 표시 방법을 선택합니다.",

	["Position"] = "위치",
	["Adjust health text position"] = "생명력 수치 위치 조절",
	["Anchor"] = "앵커", 
	["Sets the anchor for the health text"] = "생명력 수치의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the health text"] = "생명력 바에서 생명력 수치의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the health text"] = "생명력 수치의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the health text"] = "생명력 수치의 Y 좌표 입니다.",
	["Alpha"] = "투명도",
	["Sets the alpha of the health text"] = "생명력 수치의 투명도를 설정합니다.",
	["Color"] = "색상",
	["Sets the health text color"] = "생명력 수치의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",
	
	["Percent"] = "백분율",
	["Group Health"] = "파티 생명력",
	["Group Health Deficit"] = "파티 생명력 결손치",
	["Health"] = "생명력",
	["Health & Percent"] = "생명력 & 백분율",
	["Full"] = "가득",
	["Smart"] = "자동",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	["Format"] = "형식",
	["Health tag"] = "생명력 태그",
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
	["Health Text"] = "生命力文字",
	["Health text options"] = "生命力文字選項",
	["Enable"] = "啟用",
	["Show health text on nameplates"] = "在名牌顯示生命力文字",

	["Typeface"] = "字體",
	["Health text typeface options"] = "生命力文字字體選項",
	["Font"] = "字型",
	["Sets the font for health text"] = "生命力文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the health text"] = "生命力文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on health text"] = "生命力文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the outline for health text"] = "生命力文字字型輪廓",
	["Mode"] = "模式",
	["Choose what to show for health text"] = "選擇在生命力文字顯示什麼",

	["Position"] = "位置",
	["Adjust health text position"] = "生命力文字位置",
	["Anchor"] = "定位點", 
	["Sets the anchor for the health text"] = "生命力文字定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the health text"] = "生命力文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the health text"] = "生命力文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the health text"] = "生命力文字Y位移",
	["Alpha"] = "透明度",
	["Sets the alpha of the health text"] = "生命力文字透明度",
	["Color"] = "顏色",
	["Sets the health text color"] = "生命力文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",
	
	["Percent"] = "百分比",
	["Group Health"] = "團體生命力",
	["Group Health Deficit"] = "團體生命力不足額",
	["Health"] = "生命力",
	["Health & Percent"] = "生命力和百分比",
	["Full"] = "完全",
	["Smart"] = "精明",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Format"] = "格式",
	["Health tag"] = "生命力標籤",
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
	["Health Text"] = "生命值提示文字",
	["Health text options"] = "生命值提示文字相关设置",
	["Enable"] = "启用",
	["Show health text on nameplates"] = "在姓名板上显示生命值提示文字",

	["Typeface"] = "式样",
	["Health text typeface options"] = "生命值提示文字的式样设置",
	["Font"] = "字体",
	["Sets the font for health text"] = "设定生命值提示文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the health text"] = "设定生命值提示文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on health text"] = "显示生命值提示文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the outline for health text"] = "设定生命值提示文字的字体轮廓",
	["Mode"] = "模式",
	["Choose what to show for health text"] = "选择生命值提示文字的显示方式",

	["Position"] = "位置",
	["Adjust health text position"] = "调整生命值提示文字的位置",
	["Anchor"] = "锚点", 
	["Sets the anchor for the health text"] = "设定生命值提示文字的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the health text"] = "设定生命值提示文字固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the health text"] = "生命值提示文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the health text"] = "生命值提示文字的Y轴偏移量",
	["Alpha"] = "透明度",
	["Sets the alpha of the health text"] = "设定生命值提示文字的透明度",
	["Color"] = "颜色",
	["Sets the health text color"] = "设定生命值提示文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",
	
	["Percent"] = "百分比",
	["Group Health"] = "队友生命值",
	["Group Health Deficit"] = "队友生命值不足额",
	["Health"] = "生命值",
	["Health & Percent"] = "生命值和百分比",
	["Full"] = "完全",
	["Smart"] = "智能",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Format"] = "格式",
	["Health tag"] = "生命值标签",
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

local healthTags =
{
	NONE				= "",
	PERCENT				= "[HealthFraction:Percent]",
	GROUPHEALTH 		= "[IsGroup:HealthBarValue:Short]",
	GROUPHEALTHDEFICIT	= "[IsGroup:HealthBarDeficit:HideZero:Negate:Short]",
	HEALTH				= "[Select(Health, Health:Short, HealthFraction:Percent)]",
	HEALTHANDPERCENT	= "[Health:Short:Suffix(\" (\")][HealthFraction:Percent][Health:\")\"]",
	FULL				= "[Health:Short:Suffix(\"/\")][MaxHealth:Short:Suffix(\" (\")][HealthFraction:Percent][Health:\")\"]",
	SMART				= "[Select(IsFriendly, HealthDeficit:Negate:HideZero:Short:HexColor(\"ff8080\"), Select(Health, Health:Short, HealthFraction:Percent))]",
}

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar.args.healthText =
{
	type = 'group',
	name = L["Health Text"],
	desc = L["Health text options"],
	disabled = function() return not Aloft:IsActive() end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show health text on nameplates"],
			get = function() return AloftHealthText.db.profile.enable end,
			set = function(v) AloftHealthText.db.profile.enable = v AloftHealthText:UpdateTag() AloftHealthText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Health text typeface options"],
			disabled = function() return not AloftHealthText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for health text"],
					get = function() return AloftHealthText.db.profile.font end,
					set = function(v) AloftHealthText.db.profile.font = v AloftHealthText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the health text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftHealthText.db.profile.fontSize end,
					set = function(value) AloftHealthText.db.profile.fontSize = value AloftHealthText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on health text"],
					get = function() return AloftHealthText.db.profile.shadow end,
					set = function(v) AloftHealthText.db.profile.shadow = v AloftHealthText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for health text"],
					get = function() return AloftHealthText.db.profile.outline end,
					set = function(value) AloftHealthText.db.profile.outline = value AloftHealthText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		mode =
		{
			type = 'text',
			name = L["Mode"],
			desc = L["Choose what to show for health text"],
			disabled = function() return not AloftHealthText.db.profile.enable end,
			get = function() return AloftHealthText.db.profile.mode end,
			set = function(value) AloftHealthText.db.profile.mode = value AloftHealthText:UpdateTag() AloftHealthText:UpdateAll() end,
			validate = { PERCENT = L["Percent"], GROUPHEALTH = L["Group Health"], GROUPHEALTHDEFICIT = L["Group Health Deficit"], HEALTH = L["Health"], HEALTHANDPERCENT = L["Health & Percent"], FULL = L["Full"], SMART = L["Smart"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust health text position"],
			disabled = function() return not AloftHealthText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the health text"],
					get = function() return AloftHealthText.db.profile.point end,
					set = function(v) AloftHealthText.db.profile.point = v AloftHealthText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the health text"],
					get = function() return AloftHealthText.db.profile.relativeToPoint end,
					set = function(v) AloftHealthText.db.profile.relativeToPoint = v AloftHealthText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the health text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftHealthText.db.profile.offsetX end,
					set = function(v) AloftHealthText.db.profile.offsetX = v AloftHealthText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the health text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftHealthText.db.profile.offsetY end,
					set = function(v) AloftHealthText.db.profile.offsetY = v AloftHealthText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the health text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftHealthText.db.profile.enable end,
			get = function() return AloftHealthText.db.profile.alpha end,
			set = function(v) AloftHealthText.db.profile.alpha = v AloftHealthText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the health text color"],
			disabled = function() return not AloftHealthText.db.profile.enable end,
			get = function() return unpack(AloftHealthText.db.profile.color) end,
			set = function(r, g, b, a) AloftHealthText.db.profile.color = { r, g, b, a } AloftHealthText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftHealthText.db.profile.enable end,
			args =
			{
				format = 
				{
					type = 'text',
					name = L["Format"],
					desc = L["Health tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftHealthText.db.profile.format) end,
					set = function(v) AloftHealthText.db.profile.format = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftHealthText:UpdateAll() end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

function AloftHealthText:UpdateTag()
	local tag = self.db.profile.mode
	if not self.db.profile.enable then tag = "NONE"	end
	self.db.profile.format = healthTags[tag]

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------
