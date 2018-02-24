-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("LevelText") then return end
local AloftLevelText = Aloft:GetModule("LevelText")
local L = AceLibrary("AceLocale-2.2"):new("AloftLevelTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Level Text"] = true,
	["Level text options"] = true,
	["Enable"] = true,
	["Enable level text display on the nameplate"] = true,

	["Show Creature Type"] = true,	
	["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = true,

	["Show Classification"] = true,
	["Shows +,r,b for elite, rare and bosses after the level"] = true,
	["Show Race"] = true,
	["Shows unit race after the level"] = true,

	["Typeface"] = true,
	["Level text typeface options"] = true,
	["Font"] = true,
	["Sets the font for level text"] = true,
	["Font Size"] = true,
	["Sets the font height of the level text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on level text"] = true,
	["Outline"] = true,
	["Sets the font outline of the level text"] = true,

	["Position"] = true,
	["Adjust level text position"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the level text"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the level text"] = true,
	["X Offset"] = true,
	["X offset of the level text"] = true,
	["Y Offset"] = true,
	["Y offset of the level text"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Override Text"] = true,
	["Override level text"] = true,
	["Format"] = true,
	["Level tag"] = true,
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
	["Level Text"] = "레벨",
	["Level text options"] = "레벨 설정",
	["Enable"] = "사용",
	["Enable level text display on the nameplate"] = "이름표에 레벨을 표시합니다.",

	["Show Creature Type"] = "몹 종류 표시",	
	["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "야수, 악마, 용족, 정령, 인간형 및 언데드등의 몹 종류를 B,D,K,E,H,U등으로 표시합니다.",

	["Show Classification"] = "구분 표시",
	["Shows +,r,b for elite, rare and bosses after the level"] = "레벨 뒤에 정예, 희귀, 보스등을 +, r, b 로 표시합니다.",
	["Show Race"] = "종족 표시",
	["Shows unit race after the level"] = "레벨 뒤에 대상의 종족을 표시합니다.",

	["Typeface"] = "서체",
	["Level text typeface options"] = "레벨 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for level text"] = "레벨의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the level text"] = "레벨의 글자 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on level text"] = "레벨에 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the font outline of the level text"] = "레벨의 글자에 테두리를 설정합니다.",

	["Position"] = "위치",
	["Adjust level text position"] = "레벨 위치 조절",
	["Anchor"] = "앵커", 
	["Sets the anchor for the level text"] = "레벨의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the level text"] = "생명력 바에서 레벨의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the level text"] = "레벨의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the level text"] = "레벨의 Y 좌표 입니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	["Override Text"] = "텍스트 오버라이드",
	["Override level text"] = "레벨 텍스트 오버라이드",
	["Format"] = "형식",
	["Level tag"] = "레벨 태그",
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
	["Level Text"] = "等級文字",
	["Level text options"] = "等級文字選項",
	["Enable"] = "啟用",
	["Enable level text display on the nameplate"] = "在名牌顯示等級文字",

	["Show Creature Type"] = "顯示生物類型",	
	["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "使用簡短生物類型",

	["Show Classification"] = "顯示分類",
	["Shows +,r,b for elite, rare and bosses after the level"] = "使用簡短分類",
	["Show Race"] = "顯示種族",
	["Shows unit race after the level"] = "顯示種族於等級文字之後",

	["Typeface"] = "字體",
	["Level text typeface options"] = "等級文字字體選項",
	["Font"] = "字型",
	["Sets the font for level text"] = "等級文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the level text"] = "等級文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on level text"] = "等級文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the font outline of the level text"] = "等級文字字型輪廓",

	["Position"] = "位置",
	["Adjust level text position"] = "等級文字位置",
	["Anchor"] = "定位點", 
	["Sets the anchor for the level text"] = "等級文字定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the level text"] = "等級文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the level text"] = "等級文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the level text"] = "等級文字Y位移",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Override Text"] = "置換文字",
	["Override level text"] = "置換等級文字",
	["Format"] = "格式",
	["Level tag"] = "等級標籤",
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
	["Level Text"] = "等级文字",
	["Level text options"] = "等级文字相关设置",
	["Enable"] = "启用",
	["Enable level text display on the nameplate"] = "在姓名板上显示等级文字",

	["Show Creature Type"] = "显示生物类型",	
	["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "使用生物类型缩写",

	["Show Classification"] = "显示分类",
	["Shows +,r,b for elite, rare and bosses after the level"] = "使用分类缩写",
	["Show Race"] = "显示种族",
	["Shows unit race after the level"] = "将种族名称显示在等级之后",

	["Typeface"] = "式样",
	["Level text typeface options"] = "等级文字式样设置",
	["Font"] = "字体",
	["Sets the font for level text"] = "设定等级文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the level text"] = "设定等级文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on level text"] = "设定等级文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the font outline of the level text"] = "设定等级文字的字体轮廓",

	["Position"] = "位置",
	["Adjust level text position"] = "调整等級文字的位置",
	["Anchor"] = "锚点", 
	["Sets the anchor for the level text"] = "设定等级文字的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the level text"] = "设定等級文字固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the level text"] = "等级文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the level text"] = "等级文字的Y轴偏移量",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Override Text"] = "置换文字",
	["Override level text"] = "置换等级文字",
	["Format"] = "格式",
	["Level tag"] = "等级标签",
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

local LEVELTEXT_FORMAT_BASE = "[Level]"
local LEVELTEXT_FORMAT_CREATURETYPE = "[ShortCreatureType]"
local LEVELTEXT_FORMAT_CLASSIFICATION = "[Select(Level, ShortClassification, Classification)]"
local LEVELTEXT_FORMAT_RACE = "[Race:Prefix(\" \"):Cyan]"

Aloft.Options.args.levelText =
{
	type = 'group',
	name = L["Level Text"],
	desc = L["Level text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable = 
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable level text display on the nameplate"],
			get = function() return AloftLevelText.db.profile.enable end,
			set = function(v) AloftLevelText.db.profile.enable = v AloftLevelText:UpdateTag() Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
			order = 1
		},
		showCreatureType = 
		{
			type = 'toggle',
			name = L["Show Creature Type"],
			desc = L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"],
			get = function() return AloftLevelText.db.profile.showCreatureType end,
			set = function(v) 
					AloftLevelText.db.profile.showCreatureType = v 
					AloftLevelText:UpdateTag()
					Aloft:DetermineDataSources()
					AloftLevelText:UpdateAll() 
				  end,
			order = 2,
		},
		showClassification = 
		{
			type = 'toggle',
			name = L["Show Classification"],
			desc = L["Shows +,r,b for elite, rare and bosses after the level"],
			get = function() return AloftLevelText.db.profile.showClassification end,
			set = function(v) 
					AloftLevelText.db.profile.showClassification = v 
					AloftLevelText:UpdateTag()
					Aloft:DetermineDataSources()
					AloftLevelText:UpdateAll() 
				  end,
			order = 3,
		},
		showRace = 
		{
			type = 'toggle',
			name = L["Show Race"],
			desc = L["Shows unit race after the level"],
			get = function() return AloftLevelText.db.profile.showRace end,
			set = function(v) 
					AloftLevelText.db.profile.showRace = v 
					AloftLevelText:UpdateTag()
					Aloft:DetermineDataSources()
					AloftLevelText:UpdateAll() 
				  end,
			order = 4,
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Level text typeface options"],
			disabled = function() return not AloftLevelText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for level text"],
					get = function() return AloftLevelText.db.profile.font end,
					set = function(v) AloftLevelText.db.profile.font = v AloftLevelText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the level text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftLevelText.db.profile.fontSize end,
					set = function(value) AloftLevelText.db.profile.fontSize = value AloftLevelText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on level text"],
					get = function() return AloftLevelText.db.profile.shadow end,
					set = function(v) AloftLevelText.db.profile.shadow = v AloftLevelText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline of the level text"],
					get = function() return AloftLevelText.db.profile.outline end,
					set = function(value) AloftLevelText.db.profile.outline = value AloftLevelText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust level text position"],
			disabled = function() return not AloftLevelText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the level text"],
					get = function() return AloftLevelText.db.profile.point end,
					set = function(v) AloftLevelText.db.profile.point = v AloftLevelText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the level text"],
					get = function() return AloftLevelText.db.profile.relativeToPoint end,
					set = function(v) AloftLevelText.db.profile.relativeToPoint = v AloftLevelText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the level text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftLevelText.db.profile.offsetX end,
					set = function(v) AloftLevelText.db.profile.offsetX = v AloftLevelText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the level text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftLevelText.db.profile.offsetY end,
					set = function(v) AloftLevelText.db.profile.offsetY = v AloftLevelText:UpdateAll() end
				},
			},
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftLevelText.db.profile.enable end,
			args =
			{
				enable = 
				{
					type = 'toggle',
					name = L["Override Text"],
					desc = L["Override level text"],
					get = function() return AloftLevelText.db.profile.overrideText end,
					set = function(v) AloftLevelText.db.profile.overrideText = v if v then AloftLevelText:UpdateTag() end Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
					order = 1
				},
				format = 
				{
					type = 'text',
					name = L["Format"],
					desc = L["Level tag"],
					usage = L["<Any tag string>"],
					disabled = function() return not AloftLevelText.db.profile.overrideText end,
					get = function() return Aloft:HighlightTagSyntax(AloftLevelText.db.profile.format) end,
					set = function(v) AloftLevelText.db.profile.format = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

local textMethod = nil
local textMethodData = { }

-----------------------------------------------------------------------------

function AloftLevelText:UpdateTag()
	if not self.db.profile.enable or (not self.db.profile.showCreatureType and not self.db.profile.showClassification and not self.db.profile.showRace) then
		self.db.profile.overrideText = false
	else
		self.db.profile.overrideText = true
		self.db.profile.format = LEVELTEXT_FORMAT_BASE..
								  (self.db.profile.showCreatureType and LEVELTEXT_FORMAT_CREATURETYPE or "")..
								  (self.db.profile.showClassification and LEVELTEXT_FORMAT_CLASSIFICATION or "")..
								  (self.db.profile.showRace and LEVELTEXT_FORMAT_RACE or "")
	end
end

-----------------------------------------------------------------------------
