-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("CombatText") then return end
local AloftCombatText = Aloft:GetModule("CombatText")
local L = AceLibrary("AceLocale-2.2"):new("AloftCombatTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Combat Text"] = true,
	["Combat text options"] = true,
	["Enable Group"] = true,
	["Show combat text on group member nameplates"] = true,
	["Enable Target"] = true,
	["Show combat text on target nameplates"] = true,

	["Typeface"] = true,
	["Combat text typeface options"] = true,
	["Font"] = true,
	["Sets the font for combat text"] = true,
	["Font Size"] = true,
	["Sets the font height of the combat text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on combat text"] = true,
	["Outline"] = true,
	["Sets the outline for combat text"] = true,

	["Position"] = true,
	["Adjust combat text position"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the combat text"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the combat text"] = true,
	["X Offset"] = true,
	["X offset of the combat text"] = true,
	["Y Offset"] = true,
	["Y offset of the combat text"] = true,
	["Alpha"] = true,
	["Sets the alpha of the combat text"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

	["Colors"] = true,
	["Customize colors"] = true,
	["Physical"] = true,
	["Sets the color for physical damage"] = true,
	["Holy"] = true,
	["Sets the color for holy damage"] = true,
	["Fire"] = true,
	["Sets the color for fire damage"] = true,
	["Nature"] = true,
	["Sets the color for nature damage"] = true,
	["Frost"] = true,
	["Sets the color for frost damage"] = true,
	["Shadow"] = true,
	["Sets the color for shadow damage"] = true,
	["Arcane"] = true,
	["Sets the color for arcane damage"] = true,
	["Heal"] = true,
	["Sets the color for healing"] = true,
	["Text"] = true,
	["Sets the color for text feedback"] = true,
	["Reset"] = true,
	["Resets all of the colors to default"] = true,
	["Set All"] = true,
	["Sets all of the colors"] = true,

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
	["Combat Text"] = "전투 텍스트",
	["Combat text options"] = "전투 텍스트 설정",
	["Enable Group"] = "파티 사용",
	["Show combat text on group member nameplates"] = "파티원의 이름표에 전투 텍스트를 표시합니다.",
	["Enable Target"] = "대상 사용",
	["Show combat text on target nameplates"] = "대상의 이름표에 전투 텍스트를 사용합니다.",

	["Typeface"] = "서체",
	["Combat text typeface options"] = "전투 텍스트 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for combat text"] = "전투 텍스트의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the combat text"] = "전투 텍스트의 글꼴 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on combat text"] = "전투 텍스트에 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the outline for combat text"] = "전투 텍스트에 대한 테두리를 설정합니다.",

	["Position"] = "위치",
	["Adjust combat text position"] = "전투 텍스트 위치 조절",
	["Anchor"] = "앵커", 
	["Sets the anchor for the combat text"] = "전투 텍스트의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the combat text"] = "생명력 바에서 전투 텍스트의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the combat text"] = "전투 텍스트의 X 좌표입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the combat text"] = "전투 텍스트의 Y 좌표입니다.",
	["Alpha"] = "투명도",
	["Sets the alpha of the combat text"] = "전투 텍스트의 투명도를 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["Colors"] = "색상",
	["Customize colors"] = "사용자 지정 색상",
	["Physical"] = "물리",
	["Sets the color for physical damage"] = "물리적 피해량의 색상을 설정합니다.",
	["Holy"] = "신성",
	["Sets the color for holy damage"] = "신성 피해량의 색상을 설정합니다.",
	["Fire"] = "화염",
	["Sets the color for fire damage"] = "화염 피해량의 색상을 설정합니다.",
	["Nature"] = "자연",
	["Sets the color for nature damage"] = "자연 피해량의 색상을 설정합니다.",
	["Frost"] = "냉기",
	["Sets the color for frost damage"] = "냉기 피해량의 색상을 설정합니다.",
	["Shadow"] = "암흑",
	["Sets the color for shadow damage"] = "암흑 피해량의 색상을 설정합니다.",
	["Arcane"] = "비전",
	["Sets the color for arcane damage"] = "비전 피해량의 색상을 설정합니다.",
	["Heal"] = "치유",
	["Sets the color for healing"] = "치유량의 색상을 설정합니다.",
	["Text"] = "글자",
	["Sets the color for text feedback"] = "피드백 글자의 색상을 설정합니다.",
	["Reset"] = "초기화",
	["Resets all of the colors to default"] = "기본 색상으로 모두 초기화합니다.",
	["Set All"] = "전체 설정",
	["Sets all of the colors"] = "전체 색상을 설정합니다.",

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
	["Combat Text"] = "戰鬥文字",
	["Combat text options"] = "戰鬥文字選項",
	["Enable Group"] = "啟用團體",
	["Show combat text on group member nameplates"] = "在團體成員名牌顯示戰鬥文字",
	["Enable Target"] = "啟用目標",
	["Show combat text on target nameplates"] = "在目標名牌顯示戰鬥文字",

	["Typeface"] = "字體",
	["Combat text typeface options"] = "戰鬥文字字體選項",
	["Font"] = "字型",
	["Sets the font for combat text"] = "戰鬥文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the combat text"] = "戰鬥文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on combat text"] = "戰鬥文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the outline for combat text"] = "戰鬥文字字型輪廓",

	["Position"] = "位置",
	["Adjust combat text position"] = "戰鬥文字位置",
	["Anchor"] = "定位點", 
	["Sets the anchor for the combat text"] = "戰鬥文字定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the combat text"] = "戰鬥文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the combat text"] = "戰鬥文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the combat text"] = "戰鬥文字Y位移",
	["Alpha"] = "透明度",
	["Sets the alpha of the combat text"] = "戰鬥文字透明度",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["Colors"] = "顏色",
	["Customize colors"] = "自定顏色",
	["Physical"] = "物理",
	["Sets the color for physical damage"] = "物理傷害顏色",
	["Holy"] = "神聖",
	["Sets the color for holy damage"] = "神聖傷害顏色",
	["Fire"] = "火焰",
	["Sets the color for fire damage"] = "火焰傷害顏色",
	["Nature"] = "自然",
	["Sets the color for nature damage"] = "自然傷害顏色",
	["Frost"] = "冰霜",
	["Sets the color for frost damage"] = "冰霜傷害顏色",
	["Shadow"] = "暗影",
	["Sets the color for shadow damage"] = "暗影傷害顏色",
	["Arcane"] = "秘法",
	["Sets the color for arcane damage"] = "秘法傷害顏色",
	["Heal"] = "治療",
	["Sets the color for healing"] = "治療顏色",
	["Text"] = "文字",
	["Sets the color for text feedback"] = "回應文字顏色",
	["Reset"] = "重設",
	["Resets all of the colors to default"] = "重設全部顏色回預設值",
	["Set All"] = "設定全部",
	["Sets all of the colors"] = "設定全部顏色",

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
	["Combat Text"] = "战斗信息文字",
	["Combat text options"] = "战斗信息文字相关设置",
	["Enable Group"] = "启用队友",
	["Show combat text on group member nameplates"] = "在队友的姓名板上显示战斗信息文字",
	["Enable Target"] = "启用目标",
	["Show combat text on target nameplates"] = "在目标的姓名板上显示战斗信息文字",

	["Typeface"] = "式样",
	["Combat text typeface options"] = "战斗信息文字式样设置",
	["Font"] = "字体",
	["Sets the font for combat text"] = "设定战斗信息文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the combat text"] = "设定战斗信息文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on combat text"] = "显示战斗信息文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the outline for combat text"] = "设定战斗信息文字的字体轮廓",

	["Position"] = "位置",
	["Adjust combat text position"] = "调整战斗信息文字的位置",
	["Anchor"] = "锚点", 
	["Sets the anchor for the combat text"] = "设定战斗信息文字的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the combat text"] = "设定战斗信息文字固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the combat text"] = "战斗信息文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the combat text"] = "战斗信息文字的Y轴偏移量",
	["Alpha"] = "透明度",
	["Sets the alpha of the combat text"] = "设定战斗信息文字的透明度",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["Colors"] = "颜色",
	["Customize colors"] = "自定义颜色",
	["Physical"] = "物理",
	["Sets the color for physical damage"] = "设定物理伤害的颜色",
	["Holy"] = "神圣",
	["Sets the color for holy damage"] = "设定神圣伤害的颜色",
	["Fire"] = "火焰",
	["Sets the color for fire damage"] = "设定火焰伤害的颜色",
	["Nature"] = "自然",
	["Sets the color for nature damage"] = "设定自然伤害的颜色",
	["Frost"] = "冰霜",
	["Sets the color for frost damage"] = "设定冰霜伤害的颜色",
	["Shadow"] = "暗影",
	["Sets the color for shadow damage"] = "设定暗影伤害的颜色",
	["Arcane"] = "奥术",
	["Sets the color for arcane damage"] = "设定奥术伤害的颜色",
	["Heal"] = "治疗",
	["Sets the color for healing"] = "设定治疗的颜色",
	["Text"] = "文字",
	["Sets the color for text feedback"] = "设定回应文字的颜色",
	["Reset"] = "重置",
	["Resets all of the colors to default"] = "将所有颜色设定重置为默认",
	["Set All"] = "设定全部",
	["Sets all of the colors"] = "设定全部颜色",

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

Aloft.Options.args.combatText =
{
	type = 'group',
	name = L["Combat Text"],
	desc = L["Combat text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enableGroup =
		{
			type = 'toggle',
			name = L["Enable Group"],
			desc = L["Show combat text on group member nameplates"],
			get = function() return AloftCombatText.db.profile.enableGroup end,
			set = function(v) AloftCombatText.db.profile.enableGroup = v AloftCombatText:UpdateAll() end,
			order = 1
		},
		enableTarget =
		{
			type = 'toggle',
			name = L["Enable Target"],
			desc = L["Show combat text on target nameplates"],
			get = function() return AloftCombatText.db.profile.enableTarget end,
			set = function(v) AloftCombatText.db.profile.enableTarget = v AloftCombatText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Combat text typeface options"],
			disabled = function() return not AloftCombatText.db.profile.enableGroup and not AloftCombatText.db.profile.enableTarget end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for combat text"],
					get = function() return AloftCombatText.db.profile.font end,
					set = function(v) AloftCombatText.db.profile.font = v AloftCombatText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the combat text"],
					max = 40,
					min = 5,
					step = 1,
					get = function() return AloftCombatText.db.profile.fontSize end,
					set = function(value) AloftCombatText.db.profile.fontSize = value AloftCombatText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on combat text"],
					get = function() return AloftCombatText.db.profile.shadow end,
					set = function(v) AloftCombatText.db.profile.shadow = v AloftCombatText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for combat text"],
					get = function() return AloftCombatText.db.profile.outline end,
					set = function(value) AloftCombatText.db.profile.outline = value AloftCombatText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust combat text position"],
			disabled = function() return not AloftCombatText.db.profile.enableGroup and not AloftCombatText.db.profile.enableTarget end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the combat text"],
					get = function() return AloftCombatText.db.profile.point end,
					set = function(v) AloftCombatText.db.profile.point = v AloftCombatText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the combat text"],
					get = function() return AloftCombatText.db.profile.relativeToPoint end,
					set = function(v) AloftCombatText.db.profile.relativeToPoint = v AloftCombatText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the combat text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCombatText.db.profile.offsetX end,
					set = function(v) AloftCombatText.db.profile.offsetX = v AloftCombatText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the combat text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCombatText.db.profile.offsetY end,
					set = function(v) AloftCombatText.db.profile.offsetY = v AloftCombatText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the combat text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftCombatText.db.profile.enableGroup and not AloftCombatText.db.profile.enableTarget end,
			get = function() return AloftCombatText.db.profile.alpha end,
			set = function(v) AloftCombatText.db.profile.alpha = v AloftCombatText:UpdateAll() end
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function() return not AloftCombatText.db.profile.enableGroup and not AloftCombatText.db.profile.enableTarget end,
			args =
			{
				physical =
				{
					type = 'color',
					name = L["Physical"],
					desc = L["Sets the color for physical damage"],
					order = 1,
					get = function() return unpack(AloftCombatText.db.profile.colors[0]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[0] = { r, g, b } end,
				},
				holy =
				{
					type = 'color',
					name = L["Holy"],
					desc = L["Sets the color for holy damage"],
					order = 2,
					get = function() return unpack(AloftCombatText.db.profile.colors[1]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[1] = { r, g, b } end,
				},
				fire =
				{
					type = 'color',
					name = L["Fire"],
					desc = L["Sets the color for fire damage"],
					order = 2,
					get = function() return unpack(AloftCombatText.db.profile.colors[2]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[2] = { r, g, b } end,
				},
				nature =
				{
					type = 'color',
					name = L["Nature"],
					desc = L["Sets the color for nature damage"],
					order = 2,
					get = function() return unpack(AloftCombatText.db.profile.colors[3]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[3] = { r, g, b } end,
				},
				frost =
				{
					type = 'color',
					name = L["Frost"],
					desc = L["Sets the color for frost damage"],
					order = 2,
					get = function() return unpack(AloftCombatText.db.profile.colors[4]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[4] = { r, g, b } end,
				},
				shadow =
				{
					type = 'color',
					name = L["Shadow"],
					desc = L["Sets the color for shadow damage"],
					order = 2,
					get = function() return unpack(AloftCombatText.db.profile.colors[5]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[5] = { r, g, b } end,
				},
				arcane =
				{
					type = 'color',
					name = L["Arcane"],
					desc = L["Sets the color for arcane damage"],
					order = 2,
					get = function() return unpack(AloftCombatText.db.profile.colors[6]) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors[6] = { r, g, b } end,
				},
				heal =
				{
					type = 'color',
					name = L["Heal"],
					desc = L["Sets the color for healing"],
					order = 3,
					get = function() return unpack(AloftCombatText.db.profile.colors.heal) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors.heal = { r, g, b } end,
				},
				text =
				{
					type = 'color',
					name = L["Text"],
					desc = L["Sets the color for text feedback"],
					order = 3,
					get = function() return unpack(AloftCombatText.db.profile.colors.text) end,
					set = function(r, g, b) AloftCombatText.db.profile.colors.text = { r, g, b } end,
				},
				reset =
				{
					type = 'execute',
					name = L["Reset"],
					desc = L["Resets all of the colors to default"],
					order = -1,
					func = function()
								AloftCombatText.db.profile.colors[0] = { 1, 1, 1 }			-- Physical
								AloftCombatText.db.profile.colors[1] = { 1, 1, 0.5 }  		-- Holy
								AloftCombatText.db.profile.colors[2] = { 1, 0.3, 0 }		-- Fire
								AloftCombatText.db.profile.colors[3] = { 0.5, 1, 0.2 }		-- Nature
								AloftCombatText.db.profile.colors[4] = { 0.4, 0.6, 0.9 }	-- Frost,
								AloftCombatText.db.profile.colors[5] = { 0.7, 0.4, 1 }		-- Shadow
								AloftCombatText.db.profile.colors[6] = { 0.8, 0.8, 1 }		-- Arcane
								AloftCombatText.db.profile.colors.energize = { 0.41, 0.8, 0.94 }
								AloftCombatText.db.profile.colors.text = { 1, 1, 1 }
								AloftCombatText.db.profile.colors.heal = { 0, 1, 0 }
							end
				},
				setAll =
				{
					type = 'color',
					name = L["Set All"],
					desc = L["Sets all of the colors"],
					get = function() return unpack(AloftCombatText.db.profile.colors[0]) end,
					set = function(r, g, b)
							AloftCombatText.db.profile.colors[0] = { r, g, b } 
							AloftCombatText.db.profile.colors[1] = { r, g, b } 
							AloftCombatText.db.profile.colors[2] = { r, g, b } 
							AloftCombatText.db.profile.colors[3] = { r, g, b } 
							AloftCombatText.db.profile.colors[4] = { r, g, b } 
							AloftCombatText.db.profile.colors[5] = { r, g, b } 
							AloftCombatText.db.profile.colors[6] = { r, g, b } 
							AloftCombatText.db.profile.colors.energize = { r, g, b }
							AloftCombatText.db.profile.colors.text = { r, g, b }
							AloftCombatText.db.profile.colors.heal = { r, g, b }
						  end,
					order = -1,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
