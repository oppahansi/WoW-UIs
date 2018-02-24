-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("HealthBar") then return end
local AloftHealthBar = Aloft:GetModule("HealthBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftHealthBarOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Health Bar"] = true,
	["Health Bar options"] = true,

	["Texture"] = true,
	["Sets the health bar texture"] = true,
	["Alpha"] = true,
	["Sets the health bar alpha"] = true,

	["Size"] = true,
	["Adjust health bar's size"] = true,
	["Width"] = true,
	["Sets the width of the health bar"] = true,
	["Height"] = true,
	["Sets the height of the health bar"] = true,
	
	["Position"] = true,
	["Adjust the health bar's position"] = true,
	["X Offset"] = true,
	["X offset of the health bar"] = true,
	["Y Offset"] = true,
	["Y offset of the health bar"] = true,
	
	["Colors"] = true,
	["Customize colors"] = true,
	["Color by Class"] = true,
	["Sets the health bar color of players according to class"] = true,
	["Color Hostile by Class"] = true,
	["Sets the health bar color of hostile players according to class"] = true,
	["Backdrop Color"] = true,
	["Sets the backdrop color of the health bar"] = true,
	["Pet"] = true,
	["Sets the health bar color for your pet"] = true,
	["Friendly Players"] = true,
	["Sets the health bar color for friendly players"] = true,
	["Friendly Pets"] = true,
	["Sets the health bar color for friendly pets"] = true,
	["Friendly NPCs"] = true,
	["Sets the health bar color for friendly NPC Bosses"] = true,
	["Friendly Boss"] = true,
	["Sets the health bar color for friendly NPCs"] = true,
	["Hostile Players"] = true,
	["Sets the health bar color for hostile players"] = true,
	["Hostile Pets"] = true,
	["Sets the health bar color for hostile pets"] = true,
	["Hostile NPCs"] = true,
	["Sets the health bar color for hostile units"] = true,
	["Hostile Boss"] = true,
	["Sets the health bar color for hostile boss units"] = true,
	["Neutral Units"] = true,
	["Sets the health bar color for neutral units"] = true,
	["Group Pets"] = true,
	["Sets the health bar color for group pets"] = true,
	["Reset to Defaults"] = true,
	["Resets all colors to their defaults"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Color Format"] = true,
	["Color tag"] = true,
	["<Any tag string>"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Health Bar"] = "생명력바",
	["Health Bar options"] = "생명력바 설정",

	["Texture"] = "텍스쳐",
	["Sets the health bar texture"] = "생명력바의 텍스쳐를 설정합니다.",
	["Alpha"] = "투명도",
	["Sets the health bar alpha"] = "생명력바의 투명도를 설정합니다.",

	["Size"] = "크기",
	["Adjust health bar's size"] = "생명력바의 크기를 조절합니다.",
	["Width"] = "너비",
	["Sets the width of the health bar"] = "생명력바의 너비를 설정합니다.",
	["Height"] = "높이",
	["Sets the height of the health bar"] = "생명력바의 높이를 설정합니다.",
	
	["Position"] = "위치",
	["Adjust the health bar's position"] = "생명력바의 위치를 조절합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the health bar"] = "생명력바의 X 좌표입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the health bar"] = "생명력바의 Y 좌표입니다.",
	
	["Colors"] = "색상",
	["Customize colors"] = "사용자 색상",
	["Color by Class"] = "직업에 따른 색상",
	["Sets the health bar color of players according to class"] = "플레이어의 생명력바에 직업별 색상을 설정합니다.",
	["Color Hostile by Class"] = "적대적 직업별 색상",
	["Sets the health bar color of hostile players according to class"] = "적대적 플레이어의 생명력바에 직업별 색상을 설정합니다.",
	["Backdrop Color"] = "배경 색상",
	["Sets the backdrop color of the health bar"] = "생명력바의 배경 색상을 설정합니다.",
	["Pet"] = "소환수",
	["Sets the health bar color for your pet"] = "소환수의 생명력바 색상을 설정합니다.",
	["Friendly Players"] = "우호적 플레이어",
	["Sets the health bar color for friendly players"] = "우호적 플레이어에 대한 생명력바 색상을 설정합니다.",
	["Friendly Pets"] = "우호적 소환수",
	["Sets the health bar color for friendly pets"] = "우호적 소환수의 생명력바 색상을 설정합니다.",
	["Friendly NPCs"] = "우호적 NPC",
	["Sets the health bar color for friendly NPC Bosses"] =  "우호적 NPC 보스에 대한 생명력바 색상을 설정합니다.",
	["Friendly Boss"] = "우호적 보스",
	["Sets the health bar color for friendly NPCs"] = "우호적 NPC에 대한 생명력바 색상을 설정합니다.",
	["Hostile Players"] = "적대적 플레이어",
	["Sets the health bar color for hostile players"] = "적대적 플레이어의 생명력바의 색상을 설정합니다.",
	["Hostile Pets"] = "적대적 소환수",
	["Sets the health bar color for hostile pets"] = "적대적 소환수의 생명력바 색상을 설정합니다.",
	["Hostile NPCs"] = "적대적 NPC",
	["Sets the health bar color for hostile units"] = "적대적 대상에 대한 생명력바 색상을 설정합니다.",
	["Hostile Boss"] = "적대적 보스",
	["Sets the health bar color for hostile boss units"] = "적대적 보스에 대한 생명력바 색상을 설정합니다.",
	["Neutral Units"] = "중립적 대상",
	["Sets the health bar color for neutral units"] = "중립적 대상에 대한 생명력바 색상을 설정합니다.",
	["Group Pets"] = "파티 소환수",
	["Sets the health bar color for group pets"] = "파티 소환수에 대한 생명력바 색상을 설정합니다.",
	["Reset to Defaults"] = "기본값으로 초기화",
	["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	["Color Format"] = "색상 형식",
	["Color tag"] = "색상 태그",
	["<Any tag string>"] = "<태그 문자열>",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Health Bar"] = "生命力條",
	["Health Bar options"] = "生命力條選項",

	["Texture"] = "紋理",
	["Sets the health bar texture"] = "生命力條紋理",
	["Alpha"] = "透明度",
	["Sets the health bar alpha"] = "生命力條透明度",

	["Size"] = "大小",
	["Adjust health bar's size"] = "生命力條大小",
	["Width"] = "寬度",
	["Sets the width of the health bar"] = "生命力條寬度",
	["Height"] = "高度",
	["Sets the height of the health bar"] = "生命力條高度",
	
	["Position"] = "位置",
	["Adjust the health bar's position"] = "生命力條位置",
	["X Offset"] = "X位移",
	["X offset of the health bar"] = "生命力條X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the health bar"] = "生命力條Y位移",
	
	["Colors"] = "顏色",
	["Customize colors"] = "自定顏色",
	["Color by Class"] = "根據職業上色",
	["Sets the health bar color of players according to class"] = "生命力條顏色使用職業顏色",
	["Color Hostile by Class"] = "敵對單位根據職業上色",
	["Sets the health bar color of hostile players according to class"] = "敵對玩家的生命力條顏色使用職業顏色",
	["Backdrop Color"] = "背景顏色",
	["Sets the backdrop color of the health bar"] = "生命力條背景顏色",
	["Pet"] = "寵物",
	["Sets the health bar color for your pet"] = "寵物的生命力條顏色",
	["Friendly Players"] = "友好玩家",
	["Sets the health bar color for friendly players"] = "友好玩家的生命力條顏色",
	["Friendly Pets"] = "友好寵物",
	["Sets the health bar color for friendly pets"] = "友好寵物的生命力條顏色",
	["Friendly NPCs"] = "友好NPC",
	["Sets the health bar color for friendly NPC Bosses"] = "友好NPC的生命力條顏色",
	["Friendly Boss"] = "友好首領",
	["Sets the health bar color for friendly NPCs"] = "友好首領的生命力條顏色",
	["Hostile Players"] = "敵對玩家",
	["Sets the health bar color for hostile players"] = "敵對玩家的生命力條顏色",
	["Hostile Pets"] = "敵對寵物",
	["Sets the health bar color for hostile pets"] = "敵對寵物的生命力條顏色",
	["Hostile NPCs"] = "敵對NPC",
	["Sets the health bar color for hostile units"] = "敵對NPC的生命力條顏色",
	["Hostile Boss"] = "敵對玩家",
	["Sets the health bar color for hostile boss units"] = "敵對首領的生命力條顏色",
	["Neutral Units"] = "中立單位",
	["Sets the health bar color for neutral units"] = "中立單位的生命力條顏色",
	["Group Pets"] = "團體寵物",
	["Sets the health bar color for group pets"] = "團體寵物的生命力條顏色",
	["Reset to Defaults"] = "重設回預設值",
	["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Color Format"] = "顏色格式",
	["Color tag"] = "顏色標籤",
	["<Any tag string>"] = "<任何標籤文字>",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Health Bar"] = "生命值显示条",
	["Health Bar options"] = "生命值显示条相关设置",

	["Texture"] = "材质",
	["Sets the health bar texture"] = "设定生命值显示条的材质",
	["Alpha"] = "透明度",
	["Sets the health bar alpha"] = "设定生命值显示条透明度",

	["Size"] = "尺寸",
	["Adjust health bar's size"] = "调整生命值显示条的尺寸",
	["Width"] = "宽度",
	["Sets the width of the health bar"] = "设定生命值显示条的宽度",
	["Height"] = "高度",
	["Sets the height of the health bar"] = "设定生命值显示条的高度",
	
	["Position"] = "位置",
	["Adjust the health bar's position"] = "调整生命值显示条的位置",
	["X Offset"] = "X轴偏移",
	["X offset of the health bar"] = "生命值显示条的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the health bar"] = "生命值显示条的Y轴偏移量",
	
	["Colors"] = "颜色",
	["Customize colors"] = "自定义颜色",
	["Color by Class"] = "显示职业代表色",
	["Sets the health bar color of players according to class"] = "生命值显示条颜色使用职业颜色",
	["Color Hostile by Class"] = "敌对方单位根据职业显示颜色",
	["Sets the health bar color of hostile players according to class"] = "敌对方玩家的生命值显示条颜色使用职业代表色",
	["Backdrop Color"] = "背景颜色",
	["Sets the backdrop color of the health bar"] = "设定生命值显示条的背景颜色",
	["Pet"] = "宠物",
	["Sets the health bar color for your pet"] = "设定宠物的生命值显示条颜色",
	["Friendly Players"] = "友好方玩家",
	["Sets the health bar color for friendly players"] = "设定友好方玩家的生命值显示条颜色",
	["Friendly Pets"] = "友好方宠物",
	["Sets the health bar color for friendly pets"] = "设定友好方宠物的生命值显示条颜色",
	["Friendly NPCs"] = "友好方NPC",
	["Sets the health bar color for friendly NPC Bosses"] = "设定友好方NPC的生命值显示条颜色",
	["Friendly Boss"] = "友好方首领",
	["Sets the health bar color for friendly NPCs"] = "设定友好方首领的生命值显示条颜色",
	["Hostile Players"] = "敌对方玩家",
	["Sets the health bar color for hostile players"] = "设定敌对方玩家的生命值显示条颜色",
	["Hostile Pets"] = "敌对方宠物",
	["Sets the health bar color for hostile pets"] = "设定敌对方宠物的生命值显示条颜色",
	["Hostile NPCs"] = "敌对方NPC",
	["Sets the health bar color for hostile units"] = "设定敌对方NPC的生命值显示条颜色",
	["Hostile Boss"] = "敌对方首领",
	["Sets the health bar color for hostile boss units"] = "设定敌对方首领的生命值显示条颜色",
	["Neutral Units"] = "中立方单位",
	["Sets the health bar color for neutral units"] = "设定中立方单位的生命值显示条颜色",
	["Group Pets"] = "队友宠物",
	["Sets the health bar color for group pets"] = "队友宠物的生命值显示条颜色",
	["Reset to Defaults"] = "重置为默认",
	["Resets all colors to their defaults"] = "将全部颜色设定重置为默认",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Color Format"] = "颜色格式",
	["Color tag"] = "颜色标签",
	["<Any tag string>"] = "<任意标签文字>",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar =
{
	type = 'group',
	name = L["Health Bar"],
	desc = L["Health Bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the health bar texture"],
			get = function() return AloftHealthBar.db.profile.texture end,
			set = function(v) AloftHealthBar.db.profile.texture = v AloftHealthBar:UpdateAll() end,
			validate = SML_statusbar
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the health bar alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			get = function() return AloftHealthBar.db.profile.alpha end,
			set = function(v) AloftHealthBar.db.profile.alpha = v AloftHealthBar:UpdateAll() end,
			order = 2,
		},
		size =
		{
			type = 'group',
			name = L["Size"],
			desc = L["Adjust health bar's size"],
			args =
			{
				width =
				{
					type = 'range',
					name = L["Width"],
					desc = L["Sets the width of the health bar"],
					min = 50,
					max = 250,
					step = 1,
					get = function() return AloftHealthBar.db.profile.width end,
					set = function(v) AloftHealthBar.db.profile.width = v AloftHealthBar:UpdateSizesAll() end,
					order = 3,
				},
				height =
				{
					type = 'range',
					name = L["Height"],
					desc = L["Sets the height of the health bar"],
					min = 4,
					max = 40,
					step = 1,
					get = function() return AloftHealthBar.db.profile.height end,
					set = function(v) AloftHealthBar.db.profile.height = v AloftHealthBar:UpdateSizesAll() end,
					order = 4,
				},
			}
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the health bar's position"],
			args =
			{
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the health bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftHealthBar.db.profile.offsetX end,
					set = function(v) AloftHealthBar.db.profile.offsetX = v AloftHealthBar:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the health bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftHealthBar.db.profile.offsetY end,
					set = function(v) AloftHealthBar.db.profile.offsetY = v AloftHealthBar:UpdateAll() end
				},
			},
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			order = 7,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					name = L["Color by Class"],
					desc = L["Sets the health bar color of players according to class"],
					get = function() return AloftHealthBar.db.profile.colorByClass end,
					set = function(v) AloftHealthBar.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					name = L["Color Hostile by Class"],
					desc = L["Sets the health bar color of hostile players according to class"],
					get = function() return AloftHealthBar.db.profile.colorHostileByClass end,
					set = function(v) AloftHealthBar.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					order = 2
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the health bar"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.backdropColor) end,
					set = function(r, g, b, a) AloftHealthBar.db.profile.colors.backdropColor = { r, g, b, a } AloftHealthBar:UpdateAll() end,
					hasAlpha = true,
					order = 3
				},
				friendlyPlayer =
				{
					type = 'color',
					name = L["Friendly Players"],
					desc = L["Sets the health bar color for friendly players"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyPlayer = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					name = L["Friendly Pets"],
					desc = L["Sets the health bar color for friendly pets"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyPet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					name = L["Friendly NPCs"],
					desc = L["Sets the health bar color for friendly NPCs"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyNPC) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					name = L["Friendly Boss"],
					desc = L["Sets the health bar color for friendly NPC Bosses"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyBoss) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyBoss = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					name = L["Hostile Players"],
					desc = L["Sets the health bar color for hostile players"],
					disabled = function() return AloftHealthBar.db.profile.colorHostileByClass end,
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostilePlayer) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					name = L["Hostile Pets"],
					desc = L["Sets the health bar color for hostile pets"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostilePet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					name = L["Hostile NPCs"],
					desc = L["Sets the health bar color for hostile units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostileNPC) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					name = L["Hostile Boss"],
					desc = L["Sets the health bar color for hostile boss units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostileBoss) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostileBoss = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					name = L["Neutral Units"],
					desc = L["Sets the health bar color for neutral units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.neutral) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.neutral = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					name = L["Pet"],
					desc = L["Sets the health bar color for your pet"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.pet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.pet = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					name = L["Group Pets"],
					desc = L["Sets the health bar color for group pets"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.groupPet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function() 
								local colors = AloftHealthBar.db.profile.colors
								colors.backdropColor	= { 0.25, 0.25, 0.25, 0.5 }
								colors.friendlyPlayer	= { 0, 0, 1 }
								colors.friendlyPet		= { 0, 1, 0 }
								colors.friendlyNPC		= { 0, 1, 0 }
								colors.friendlyBoss		= { 0, 1, 0 }
								colors.hostilePlayer	= { 1, 0, 0 }
								colors.hostilePet		= { 1, 0, 0 }
								colors.hostileNPC		= { 1, 0, 0 }
								colors.hostileBoss		= { 1, 0, 0 }
								colors.neutral			= { 1, 1, 0 }
								colors.pet				= { 0, 1, 0 }
								colors.groupPet			= { 0, 1, 0 }
								Aloft:DetermineDataSources()
								AloftHealthBar:UpdateAll()
							end,
				},
				advanced  =
				{
					type = 'group',
					name = L["Advanced"],
					desc = L["Options for expert users"],
					order = -1,
					args =
					{
						format = 
						{
							type = 'text',
							name = L["Color Format"],
							desc = L["Color tag"],
							usage = L["<Any tag string>"],
							get = function() return Aloft:HighlightTagSyntax(AloftHealthBar.db.profile.colorFormat) end,
							set = function(v) AloftHealthBar.db.profile.colorFormat = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
						}
					},
				},
			}
		}
	},
}

-----------------------------------------------------------------------------
