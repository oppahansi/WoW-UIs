-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("NameText") then return end
local AloftNameText = Aloft:GetModule("NameText")
local L = AceLibrary("AceLocale-2.2"):new("AloftNameTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Name Text"] = true,
	["Nameplate text options"] = true,
	["Enable"] = true,
	["Show unit names"] = true,

	["Use Aliases"] = true,
	["Uses user defined aliases"] = true,

	["Set Alias"] = true,
	["Sets the alias for your current target. An empty alias will return the unit to its original name"] = true,
	["<Any String>"] = true,
	
	["Typeface"] = true,
	["Nameplate text typeface options"] = true,
	["Font"] = true,
	["Sets the font for nameplate text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on nameplate text"] = true,
	["Font Size"] = true,
	["Sets the font height of the nameplate text"] = true,
	["Outline"] = true,
	["Sets the font outline for nameplate text"] = true,

	["Alignment"] = true,
	["Sets the alignment of the nameplate text"] = true,	

	["Position"] = true,
	["Adjust nameplate text position"] = true,
	["Left Offset"] = true,
	["Sets the offset of the left of the text"] = true,
	["Right Offset"] = true,
	["Sets the offset of the right of the text"] = true,
	["Vertical Offset"] = true,
	["Sets the vertical offset of the text"] = true,
	
	["Override Colors"] = true,
	["Override the games colors for nameplate text"] = true,
	["Colors"] = true,
	["Customize colors"] = true,

	["Color by Class"] = true,
	["Sets the name text color according to class"] = true,
	["Color Hostile by Class"] = true,
	["Sets the name text color of hostile players according to class"] = true,
	["Set All"] = true,
	["Sets the name text color for all types"] = true,
	["Set All Friendly"] = true,
	["Sets the name text color for all friendly types"] = true,
	["Set All Hostile"] = true,
	["Sets the name text color for all hostile types"] = true,

	["Pet"] = true,
	["Sets the name text color for your pet"] = true,
	["Friendly Players"] = true,
	["Sets the name text color for friendly players"] = true,
	["Friendly Pets"] = true,
	["Sets the name text color for friendly pets"] = true,
	["Friendly NPCs"] = true,
	["Sets the name text color for friendly NPC Bosses"] = true,
	["Friendly Boss"] = true,
	["Sets the name text color for friendly NPCs"] = true,
	["Hostile Players"] = true,
	["Sets the name text color for hostile players"] = true,
	["Hostile Pets"] = true,
	["Sets the name text color for hostile pets"] = true,
	["Hostile NPCs"] = true,
	["Sets the name text color for hostile units"] = true,
	["Hostile Boss"] = true,
	["Sets the name text color for hostile boss units"] = true,
	["Neutral Units"] = true,
	["Sets the name text color for neutral units"] = true,
	["Group Pets"] = true,
	["Sets the name text color for group pets"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Format"] = true,
	["Name tag"] = true,
	["<Any tag string>"] = true,

	["LEFT"] = true,
	["CENTER"] = true,
	["RIGHT"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Name Text"] = "이름",
	["Nameplate text options"] = "이름 설정",
	["Enable"] = "사용",
	["Show unit names"] = "대상의 이름을 표시합니다.",

	["Use Aliases"] = "별명 사용",
	["Uses user defined aliases"] = "사용자가 지정한 별명을 사용합니다.",

	["Set Alias"] = "별명 설정",
	["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "현재 대상에 대한 별명을 설정합니다. 빈칸으로 두면 대상의 실제 이름을 반환합니다.",
	["<Any String>"] = "<문자열>",
	
	["Typeface"] = "서체",
	["Nameplate text typeface options"] = "이름 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for nameplate text"] = "이름의 글꼴을 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on nameplate text"] = "이름에 그림자를 표시합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the nameplate text"] = "이름의 높이를 설정합니다.",
	["Outline"] = "테두리",
	["Sets the font outline for nameplate text"] = "이름의 테두리를 설정합니다.",

	["Alignment"] = "정렬",
	["Sets the alignment of the nameplate text"] = "이름의 정렬을 설정합니다.",	

	["Position"] = "위치",
	["Adjust nameplate text position"] = "이름 위치 조절",
	["Left Offset"] = "좌측 좌표",
	["Sets the offset of the left of the text"] = "이름의 좌측 좌표를 설정합니다.",
	["Right Offset"] = "우측 좌표",
	["Sets the offset of the right of the text"] = "이름의 우측 좌표를 설정합니다.",
	["Vertical Offset"] = "수직 좌표",
	["Sets the vertical offset of the text"] = "이름의 수직 좌표를 설정합니다.",
	
	["Override Colors"] = "색상 적용",
	["Override the games colors for nameplate text"] = "이름에 게임 색상을 적용합니다.",
	["Colors"] = "색상",
	["Customize colors"] = "사용자 색상",

	["Color by Class"] = "직업별 색상",
	["Sets the name text color according to class"] = "이름 색상에 직업별 색상을 설정합니다.",
	["Color Hostile by Class"] = "적대적 직업별 색상",
	["Sets the name text color of hostile players according to class"] = "적대적 플레이어의 이름에 직업별 색상을 설정합니다.",
	["Set All"] = "전체 설정",
	["Sets the name text color for all types"] = "모든 이름의 색상을 설정합니다.",
	["Set All Friendly"] = "전체 우호적 설정",
	["Sets the name text color for all friendly types"] = "전체 우호적 대상에 대한 이름의 색상을 설정합니다.",
	["Set All Hostile"] = "전체 적대적 설정",
	["Sets the name text color for all hostile types"] = "전체 적대적 대상에 대한 이름의 색상을 설정합니다.",

	["Pet"] = "소환수",
	["Sets the name text color for your pet"] = "소환수의 이름 색상을 설정합니다.",
	["Friendly Players"] = "우호적 플레이어",
	["Sets the name text color for friendly players"] = "우호적 플레이어의 이름 색상을 설정합니다.",
	["Friendly Pets"] = "우호적 소환수",
	["Sets the name text color for friendly pets"] = "우호적 소환수의 이름 색상을 설정합니다.",
	["Friendly NPCs"] = "우호적 NPC",
	["Sets the name text color for friendly NPC Bosses"] = "우호적 NPC 보스의 이름 색상을 설정합니다.",
	["Friendly Boss"] = "우호적 보스",
	["Sets the name text color for friendly NPCs"] = "우호적 NPC의 이름 색상을 설정합니다.",
	["Hostile Players"] = "적대적 플레이어",
	["Sets the name text color for hostile players"] = "적대적 플레이어의 이름 색상을 설정합니다.",
	["Hostile Pets"] = "적대적 소환수",
	["Sets the name text color for hostile pets"] = "적대적 소환수의 이름 색상을 설정합니다.",
	["Hostile NPCs"] = "적대적 NPC",
	["Sets the name text color for hostile units"] = "적대적 NPC의 이름 색상을 설정합니다.",
	["Hostile Boss"] = "적대적 보스",
	["Sets the name text color for hostile boss units"] = "적대적 보스의 이름 색상을 설정합니다.",
	["Neutral Units"] = "중립적 대상",
	["Sets the name text color for neutral units"] = "중립적 대상의 이름 색상을 설정합니다.",
	["Group Pets"] = "파티 소환수",
	["Sets the name text color for group pets"] = "파티 소환수의 이름 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	["Format"] = "형식",
	["Name tag"] = "이름 태그",
	["<Any tag string>"] = "<태그 문자열>",

	["LEFT"] = "좌측",
	["CENTER"] = "가운데",
	["RIGHT"] = "우측",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Name Text"] = "名字文字",
	["Nameplate text options"] = "名牌文字選項",
	["Enable"] = "啟用",
	["Show unit names"] = "顯示單位名字",

	["Use Aliases"] = "使用別名",
	["Uses user defined aliases"] = "使用自定別名",

	["Set Alias"] = "設定別名",
	["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "設定目前目標的別名。空的別名會重設回原有名字",
	["<Any String>"] = "<任何文字>",
	
	["Typeface"] = "字體",
	["Nameplate text typeface options"] = "名牌文字字體選項",
	["Font"] = "字型",
	["Sets the font for nameplate text"] = "名牌文字字型",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on nameplate text"] = "名牌文字字型陰影",
	["Font Size"] = "字型大小",
	["Sets the font height of the nameplate text"] = "名牌文字字型大小",
	["Outline"] = "輪廓",
	["Sets the font outline for nameplate text"] = "名牌文字字型輪廓",

	["Alignment"] = "對齊",
	["Sets the alignment of the nameplate text"] = "名牌文字對齊",	

	["Position"] = "位置",
	["Adjust nameplate text position"] = "名牌文字位置",
	["Left Offset"] = "左位移",
	["Sets the offset of the left of the text"] = "文字左位移",
	["Right Offset"] = "右位移",
	["Sets the offset of the right of the text"] = "文字右位移",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the text"] = "文字垂直位移",
	
	["Override Colors"] = "置換顏色",
	["Override the games colors for nameplate text"] = "置換名牌文字的遊戲顏色",
	["Colors"] = "顏色",
	["Customize colors"] = "自定顏色",

	["Color by Class"] = "根據職業上色",
	["Sets the name text color according to class"] = "名字文字顏色使用職業顏色",
	["Color Hostile by Class"] = "敵對單位根據職業上色",
	["Sets the name text color of hostile players according to class"] = "敵對玩家的名字文字顏色使用職業顏色",
	["Set All"] = "設定全部",
	["Sets the name text color for all types"] = "設定全部單位的名字文字顏色",
	["Set All Friendly"] = "設定全部友好",
	["Sets the name text color for all friendly types"] = "設定全部友好單位的名字文字顏色",
	["Set All Hostile"] = "設定全部敵對",
	["Sets the name text color for all hostile types"] = "設定全部敵對單位的名字文字顏色",

	["Pet"] = "寵物",
	["Sets the name text color for your pet"] = "寵物的名字文字顏色",
	["Friendly Players"] = "友好玩家",
	["Sets the name text color for friendly players"] = "友好玩家的名字文字顏色",
	["Friendly Pets"] = "友好寵物",
	["Sets the name text color for friendly pets"] = "友好寵物的名字文字顏色",
	["Friendly NPCs"] = "友好NPC",
	["Sets the name text color for friendly NPC Bosses"] = "友好NPC的名字文字顏色",
	["Friendly Boss"] = "友好首領",
	["Sets the name text color for friendly NPCs"] = "友好首領的名字文字顏色",
	["Hostile Players"] = "敵對玩家",
	["Sets the name text color for hostile players"] = "敵對玩家的名字文字顏色",
	["Hostile Pets"] = "敵對寵物",
	["Sets the name text color for hostile pets"] = "敵對寵物的名字文字顏色",
	["Hostile NPCs"] = "敵對NPC",
	["Sets the name text color for hostile units"] = "敵對NPC的名字文字顏色",
	["Hostile Boss"] = "敵對玩家",
	["Sets the name text color for hostile boss units"] = "敵對首領的名字文字顏色",
	["Neutral Units"] = "中立單位",
	["Sets the name text color for neutral units"] = "中立單位的名字文字顏色",
	["Group Pets"] = "團體寵物",
	["Sets the name text color for group pets"] = "團體寵物的名字文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Format"] = "格式",
	["Name tag"] = "名字標籤",
	["<Any tag string>"] = "<任何標籤文字>",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Name Text"] = "名称文字",
	["Nameplate text options"] = "姓名板文字相关设置",
	["Enable"] = "启用",
	["Show unit names"] = "显示单位名称",

	["Use Aliases"] = "使用绰号",
	["Uses user defined aliases"] = "使用自定义绰号",

	["Set Alias"] = "设定绰号",
	["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "设定当前目标的绰号。如果留空则会重置为目标的原有名称",
	["<Any String>"] = "<任意文字>",
	
	["Typeface"] = "式样",
	["Nameplate text typeface options"] = "姓名板文字式样设置",
	["Font"] = "字体",
	["Sets the font for nameplate text"] = "设定姓名板文字的字体",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on nameplate text"] = "在姓名板文字上显示字体阴影",
	["Font Size"] = "字号",
	["Sets the font height of the nameplate text"] = "设定姓名板文字的字号",
	["Outline"] = "轮廓",
	["Sets the font outline for nameplate text"] = "设定姓名板文字的轮廓",

	["Alignment"] = "对齐",
	["Sets the alignment of the nameplate text"] = "设定姓名板文字的对齐样式",	

	["Position"] = "位置",
	["Adjust nameplate text position"] = "调整姓名板文字的位置",
	["Left Offset"] = "向左偏移",
	["Sets the offset of the left of the text"] = "设定文字的向左偏移量",
	["Right Offset"] = "向右偏移",
	["Sets the offset of the right of the text"] = "设定文字的向右偏移量",
	["Vertical Offset"] = "垂直偏移",
	["Sets the vertical offset of the text"] = "设定文字的垂直偏移量",
	
	["Override Colors"] = "置换颜色",
	["Override the games colors for nameplate text"] = "置换姓名板文字的游戏内颜色",
	["Colors"] = "颜色",
	["Customize colors"] = "自定义颜色",

	["Color by Class"] = "根据职业显示颜色",
	["Sets the name text color according to class"] = "名称文字颜色使用职业代表色",
	["Color Hostile by Class"] = "敌对方单位根据职业显示颜色",
	["Sets the name text color of hostile players according to class"] = "敌对方玩家的名称文字颜色使用职业代表色",
	["Set All"] = "设定全部",
	["Sets the name text color for all types"] = "设定所有单位的名称文字颜色",
	["Set All Friendly"] = "设定全部友好方单位",
	["Sets the name text color for all friendly types"] = "设定全部友好方单位的名称文字颜色",
	["Set All Hostile"] = "设定全部敌对方单位",
	["Sets the name text color for all hostile types"] = "设定全部敌对方单位的名称文字颜色",

	["Pet"] = "宠物",
	["Sets the name text color for your pet"] = "宠物的名称文字颜色",
	["Friendly Players"] = "友好方玩家",
	["Sets the name text color for friendly players"] = "设定友好方玩家的名称文字颜色",
	["Friendly Pets"] = "友好方宠物",
	["Sets the name text color for friendly pets"] = "设定友好方宠物的名称文字颜色",
	["Friendly NPCs"] = "友好方NPC",
	["Sets the name text color for friendly NPC Bosses"] = "设定友好方首领的名称文字颜色",
	["Friendly Boss"] = "友好方首领",
	["Sets the name text color for friendly NPCs"] = "设定友好方NPC的名称文字颜色",
	["Hostile Players"] = "敌对方玩家",
	["Sets the name text color for hostile players"] = "设定敌对方玩家的名称文字颜色",
	["Hostile Pets"] = "敌对方宠物",
	["Sets the name text color for hostile pets"] = "设定敌对方宠物的名称文字颜色",
	["Hostile NPCs"] = "敌对方NPC",
	["Sets the name text color for hostile units"] = "设定敌对方NPC的名称文字颜色",
	["Hostile Boss"] = "敌对方首领",
	["Sets the name text color for hostile boss units"] = "设定敌对方首领的名称文字颜色",
	["Neutral Units"] = "中立方单位",
	["Sets the name text color for neutral units"] = "设定中立方单位的名称文字颜色",
	["Group Pets"] = "队友宠物",
	["Sets the name text color for group pets"] = "设定队友宠物的名称文字颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级选项",
	["Format"] = "格式",
	["Name tag"] = "名称标签",
	["<Any tag string>"] = "<任意标签文字>",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.nameText =
{
	type = 'group',
	name = L["Name Text"],
	desc = L["Nameplate text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show unit names"],
			get = function() return AloftNameText.db.profile.enable end,
			set = function(v) AloftNameText.db.profile.enable = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
			order = 1
		},
		useAliases =
		{
			type = 'toggle',
			name = L["Use Aliases"],
			desc = L["Uses user defined aliases"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			get = function() return AloftNameText.db.profile.useAliases end,
			set = function(v) AloftNameText.db.profile.useAliases = v AloftNameText:UpdateFormatTag() Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
			order = 2
		},
		setAlias =
		{
			type = 'text',
			name = L["Set Alias"],
			desc = L["Sets the alias for your current target. An empty alias will return the unit to its original name"],
			usage = L["<Any String>"],
			disabled = function() return not AloftNameText.db.profile.enable or not AloftNameText.db.profile.useAliases end,
			get = function() return "" end,
			set = function(v) Aloft:GetModule("AliasData"):SetAlias(UnitName("target"), v) end,
			order = 3
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Nameplate text typeface options"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for nameplate text"],
					get = function() return AloftNameText.db.profile.font end,
					set = function(v) AloftNameText.db.profile.font = v AloftNameText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the nameplate text"],
					max = 16,
					min = 4,
					step = 1,
					get = function() return AloftNameText.db.profile.fontSize end,
					set = function(value) AloftNameText.db.profile.fontSize = value AloftNameText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on nameplate text"],
					get = function() return AloftNameText.db.profile.shadow end,
					set = function(v) AloftNameText.db.profile.shadow = v AloftNameText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for nameplate text"],
					get = function() return AloftNameText.db.profile.outline end,
					set = function(value) AloftNameText.db.profile.outline = value AloftNameText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the nameplate text"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			get = function() return AloftNameText.db.profile.alignment end,
			set = function(value) AloftNameText.db.profile.alignment = value AloftNameText:UpdateAll() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust nameplate text position"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the text"],
					min = -100,
					max = 100,
					step = 1,
					get = function() return AloftNameText.db.profile.offsets.left end,
					set = function(v) AloftNameText.db.profile.offsets.left = v AloftNameText:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -100,
					max = 100,
					step = 1,
					get = function() return AloftNameText.db.profile.offsets.right end,
					set = function(v) AloftNameText.db.profile.offsets.right = v AloftNameText:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -64,
					max = 64,
					step = 1,
					get = function() return AloftNameText.db.profile.offsets.vertical end,
					set = function(v) AloftNameText.db.profile.offsets.vertical = v AloftNameText:UpdateAll() end
				},
			},
		},
		overrideColors =
		{
			type = 'toggle',
			name = L["Override Colors"],
			desc = L["Override the games colors for nameplate text"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			get = function() return AloftNameText.db.profile.overrideColors end,
			set = function(value) AloftNameText.db.profile.overrideColors = value AloftNameText:UpdateAll() end,
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function() return not AloftNameText.db.profile.enable or not AloftNameText.db.profile.overrideColors end,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					name = L["Color by Class"],
					desc = L["Sets the name text color according to class"],
					get = function() return AloftNameText.db.profile.colorByClass end,
					set = function(v) AloftNameText.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					name = L["Color Hostile by Class"],
					desc = L["Sets the name text color of hostile players according to class"],
					get = function() return AloftNameText.db.profile.colorHostileByClass end,
					set = function(v) AloftNameText.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
					order = 2
				},
				setAll =
				{
					type = 'color',
					name = L["Set All"],
					desc = L["Sets the name text color for all types"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b) 
						AloftNameText.db.profile.colors.friendlyPlayer	= { r, g, b }
						AloftNameText.db.profile.colors.friendlyPet		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyNPC		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyBoss	= { r, g, b }
						AloftNameText.db.profile.colors.hostilePlayer	= { r, g, b }
						AloftNameText.db.profile.colors.hostilePet		= { r, g, b }
						AloftNameText.db.profile.colors.hostileNPC		= { r, g, b }
						AloftNameText.db.profile.colors.hostileBoss		= { r, g, b }
						AloftNameText.db.profile.colors.neutral			= { r, g, b }
						AloftNameText.db.profile.colors.pet				= { r, g, b }
						AloftNameText.db.profile.colors.groupPet		= { r, g, b }
						Aloft:DetermineDataSources() 
						AloftNameText:UpdateAll() end,
					order = 3
				},
				setAllFriendly =
				{
					type = 'color',
					name = L["Set All Friendly"],
					desc = L["Sets the name text color for all friendly types"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b) 
						AloftNameText.db.profile.colors.friendlyPlayer	= { r, g, b }
						AloftNameText.db.profile.colors.friendlyPet		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyNPC		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyBoss	= { r, g, b }
						AloftNameText.db.profile.colors.pet				= { r, g, b }
						AloftNameText.db.profile.colors.groupPet		= { r, g, b }
						Aloft:DetermineDataSources() 
						AloftNameText:UpdateAll() end,
					order = 4
				},
				setAllHostile =
				{
					type = 'color',
					name = L["Set All Hostile"],
					desc = L["Sets the name text color for all hostile types"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostileNPC) end,
					set = function(r, g, b) 
						AloftNameText.db.profile.colors.hostilePlayer	= { r, g, b }
						AloftNameText.db.profile.colors.hostilePet		= { r, g, b }
						AloftNameText.db.profile.colors.hostileNPC		= { r, g, b }
						AloftNameText.db.profile.colors.hostileBoss		= { r, g, b }
						Aloft:DetermineDataSources() 
						AloftNameText:UpdateAll() end,
					order = 5
				},
				friendlyPlayer =
				{
					type = 'color',
					name = L["Friendly Players"],
					desc = L["Sets the name text color for friendly players"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyPlayer = { r, g, b } AloftNameText:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					name = L["Friendly Pets"],
					desc = L["Sets the name text color for friendly pets"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					name = L["Friendly NPCs"],
					desc = L["Sets the name text color for friendly NPCs"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyNPC) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					name = L["Friendly Boss"],
					desc = L["Sets the name text color for friendly NPC Bosses"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyBoss) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyBoss = { r, g, b } AloftNameText:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					name = L["Hostile Players"],
					desc = L["Sets the name text color for hostile players"],
					disabled = function() return AloftNameText.db.profile.colorHostileByClass end,
					get = function() return unpack(AloftNameText.db.profile.colors.hostilePlayer) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					name = L["Hostile Pets"],
					desc = L["Sets the name text color for hostile pets"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostilePet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					name = L["Hostile NPCs"],
					desc = L["Sets the name text color for hostile units"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostileNPC) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					name = L["Hostile Boss"],
					desc = L["Sets the name text color for hostile boss units"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostileBoss) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostileBoss = { r, g, b } AloftNameText:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					name = L["Neutral Units"],
					desc = L["Sets the name text color for neutral units"],
					get = function() return unpack(AloftNameText.db.profile.colors.neutral) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.neutral = { r, g, b } AloftNameText:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					name = L["Pet"],
					desc = L["Sets the name text color for your pet"],
					get = function() return unpack(AloftNameText.db.profile.colors.pet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.pet = { r, g, b } AloftNameText:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					name = L["Group Pets"],
					desc = L["Sets the name text color for group pets"],
					get = function() return unpack(AloftNameText.db.profile.colors.groupPet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
			}
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftNameText.db.profile.enable end,
			args =
			{
				format = 
				{
					type = 'text',
					name = L["Format"],
					desc = L["Name tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftNameText.db.profile.format) end,
					set = function(v) AloftNameText.db.profile.format = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

local tagModifiers = { }

function AloftNameText:RegisterFormatTagModifier(priority, method, ...)
	table.insert(tagModifiers, { priority, method,  ... })
end

function AloftNameText:UpdateFormatTag()
	self.db.profile.format = self.db.profile.useAliases and "[Alias]" or "[Name]"
	table.sort(tagModifiers, function(a, b) return a[1] < b[1] end)
	
	for _,k in ipairs(tagModifiers) do
		k[2](unpack(k, 3))
	end
end

-----------------------------------------------------------------------------
