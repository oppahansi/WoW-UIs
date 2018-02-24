-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("Frame") then return end
local AloftFrame = Aloft:GetModule("Frame")
local L = AceLibrary("AceLocale-2.2"):new("AloftFrameOptions")
local SML = AceLibrary("SharedMedia-1.0")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Enable Mouse"] = true,
	["Allows left click to target and right click to interact"] = true,

	["Frame"] = true,
	["Frame options"] = true,
	["Width"] = true,
	["Sets the width of the frame"] = true,
	["Height"] = true,
	["Sets the height of the frame"] = true,

	["Packing Width"] = true,
	["Sets the minimum horizontal distance between frames"] = true,
	["Packing Height"] = true,
	["Sets the minimum vertical distance between frames"] = true,

	["Background Alpha"] = true,
	["Sets the alpha for the background of the nameplates"] = true,
	["Background Colors"] = true,
	["Customize colors"] = true,
	
	["Color by Class"] = true,
	["Sets the background color according to class"] = true,
	["Color Hostile by Class"] = true,
	["Sets the background color of hostile players according to class"] = true,
	["Set All"] = true,
	["Sets the background color for all types"] = true,

	["Set All Friendly"] = true,
	["Sets the background color for all friendly types"] = true,
	["Set All Hostile"] = true,
	["Sets the background color for all hostile types"] = true,

	["Pet"] = true,
	["Sets the background color for your pet"] = true,
	["Friendly Players"] = true,
	["Sets the background color for friendly players"] = true,
	["Friendly Pets"] = true,
	["Sets the background color for friendly pets"] = true,
	["Friendly NPCs"] = true,
	["Sets the background color for friendly NPC Bosses"] = true,
	["Friendly Boss"] = true,
	["Sets the background color for friendly NPCs"] = true,
	["Hostile Players"] = true,
	["Sets the background color for hostile players"] = true,
	["Hostile Pets"] = true,
	["Sets the background color for hostile pets"] = true,
	["Hostile NPCs"] = true,
	["Sets the background color for hostile units"] = true,
	["Hostile Boss"] = true,
	["Sets the background color for hostile boss units"] = true,
	["Neutral Units"] = true,
	["Sets the background color for neutral units"] = true,
	["Group Pets"] = true,
	["Sets the background color for group pets"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Color Format"] = true,
	["Color tag"] = true,
	["<Any tag string>"] = true,
	
	["Border Color"] = true,
	["Sets the border color of the nameplate"] = true,
	["Border Style"] = true,
	["Sets the style of the nameplate border"] = true,
	["Background Style"] = true,
	["Sets the style of the nameplate background"] = true,
	
	["NONE"] = "None", 
	["STANDARD"] = "Standard", 
	["SQUARE"] = "Square",
} end)

L:RegisterTranslations("koKR", function() return {
	["Enable Mouse"] = "마우스 사용",
	["Allows left click to target and right click to interact"] = "행동을 위한 우클릭과 대상에 좌클릭을 허용합니다.",

	["Frame"] = "프레임",
	["Frame options"] = "프레임 설정입니다.",
	["Width"] = "너비",
	["Sets the width of the frame"] = "프레임의 너비를 설정합니다.",
	["Height"] = "높이",
	["Sets the height of the frame"] = "프레임의 높이를 설정합니다.",

	["Packing Width"] = "패킹 넓이",
	["Sets the minimum horizontal distance between frames"] = "프레임 사이의 최소 수평 거리를 설정합니다.",
	["Packing Height"] = "패킹 높이",
	["Sets the minimum vertical distance between frames"] = "프레임 사이의 최소 수직 거리를 설정합니다.",

	["Background Alpha"] = "배경 투명도",
	["Sets the alpha for the background of the nameplates"] = "이름표의 배경에 대한 투명도를 설정합니다.",
	["Background Colors"] = "배경 색상",
	["Customize colors"] = "사용자 색상",
	
	["Color by Class"] = "직업별 색상",
	["Sets the background color according to class"] = "직업별 색상을 배경 색상으로 설정합니다.",
	["Color Hostile by Class"] = "적대적 직업별 색상",
	["Sets the background color of hostile players according to class"] = "직업별 색상을 적대적 플레이어의 배경 색상으로 설정합니다.",
	["Set All"] = "전체 설정",
	["Sets the background color for all types"] = "전체의 배경 색상을 설정합니다.",

	["Set All Friendly"] = "전체 우호적 설정",
	["Sets the background color for all friendly types"] = "전체 우호적 대상에 대한 배경 색상을 설정합니다.",
	["Set All Hostile"] = "전체 적대적 설정",
	["Sets the background color for all hostile types"] = "전체 적대적 대상에 대한 배경 색상을 설정합니다.",

	["Pet"] = "소환수",
	["Sets the background color for your pet"] = "소환수에 대한 배경 색상을 설정합니다.",
	["Friendly Players"] = "우호적 플레이어",
	["Sets the background color for friendly players"] = "우호적 플레이어에 대한 배경 색상을 설정합니다.",
	["Friendly Pets"] = "우호적 소환수",
	["Sets the background color for friendly pets"] = "우호적 소환수에 대한 배경 색상을 설정합니다.",
	["Friendly NPCs"] = "우호적 NPC",
	["Sets the background color for friendly NPC Bosses"] = "우호적 NPC 보스에 대한 배경 색상을 설정합니다.",
	["Friendly Boss"] = "우호적 보스",
	["Sets the background color for friendly NPCs"] = "우호적 NPC에 대한 배경 색상을 설정합니다.",
	["Hostile Players"] = "적대적 플레이어",
	["Sets the background color for hostile players"] = "적대적 플레이어에 대한 배경 색상을 설정합니다.",
	["Hostile Pets"] = "적대적 소환수",
	["Sets the background color for hostile pets"] = "적대적 소환수에 대한 배경 색상을 설정합니다.",
	["Hostile NPCs"] = "적대적 NPC",
	["Sets the background color for hostile units"] = "적대적 대상에 대한 배경 색상을 설정합니다.",
	["Hostile Boss"] = "적대적 보스",
	["Sets the background color for hostile boss units"] = "적대적 보스에 대한 배경 색상을 설정합니다.",
	["Neutral Units"] = "중립적 대상",
	["Sets the background color for neutral units"] = "중립적 대상에 대한 배경 색상을 설정합니다.",
	["Group Pets"] = "파티 소환수",
	["Sets the background color for group pets"] = "파티 소환수에 대한 배경 색상을 설정합니다.",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	["Color Format"] = "색상 형식",
	["Color tag"] = "색상 태그",
	["<Any tag string>"] = "<태그 문자열>",
	
	["Border Color"] = "테두리 색상",
	["Sets the border color of the nameplate"] = "이름표의 테두리 색상을 설정합니다.",
	["Border Style"] = "테두리 스타일",
	["Sets the style of the nameplate border"] = "이름표 테두리의 스타일을 설정합니다.",
	["Background Style"] = "배경 유형",
	["Sets the style of the nameplate background"] = "이름표 배경의 유형을 설정합니다.",
	
	["NONE"] = "없음", 
	["STANDARD"] = "기본형", 
	["SQUARE"] = "사각형",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Enable Mouse"] = "啟用滑鼠",
	["Allows left click to target and right click to interact"] = "允許左擊選擇目標，右擊彈出選單",

	["Frame"] = "框架",
	["Frame options"] = "框架選項",
	["Width"] = "寬度",
	["Sets the width of the frame"] = "框架寬度",
	["Height"] = "高度",
	["Sets the height of the frame"] = "框架高度",

	["Packing Width"] = "間隔寬度",
	["Sets the minimum horizontal distance between frames"] = "框架最小水平間隔",
	["Packing Height"] = "間隔高度",
	["Sets the minimum vertical distance between frames"] = "框架最小垂直間隔",

	["Background Alpha"] = "背景透明度",
	["Sets the alpha for the background of the nameplates"] = "名牌背景透明度",
	["Background Colors"] = "背景顏色",
	["Customize colors"] = "自定顏色",
	
	["Color by Class"] = "根據職業上色",
	["Sets the background color according to class"] = "背景顏色使用職業顏色",
	["Color Hostile by Class"] = "敵對單位根據職業上色",
	["Sets the background color of hostile players according to class"] = "敵對玩家的背景顏色使用職業顏色",
	["Set All"] = "設定全部",
	["Sets the background color for all types"] = "設定全部單位的背景顏色",

	["Set All Friendly"] = "設定全部友好",
	["Sets the background color for all friendly types"] = "設定全部友好單位的背景顏色",
	["Set All Hostile"] = "設定全部敵對",
	["Sets the background color for all hostile types"] = "設定全部敵對單位的背景顏色",

	["Pet"] = "寵物",
	["Sets the background color for your pet"] = "寵物的背景顏色",
	["Friendly Players"] = "友好玩家",
	["Sets the background color for friendly players"] = "友好玩家的背景顏色",
	["Friendly Pets"] = "友好寵物",
	["Sets the background color for friendly pets"] = "友好寵物的背景顏色",
	["Friendly NPCs"] = "友好NPC",
	["Sets the background color for friendly NPC Bosses"] = "友好NPC的背景顏色",
	["Friendly Boss"] = "友好首領",
	["Sets the background color for friendly NPCs"] = "友好首領的背景顏色",
	["Hostile Players"] = "敵對玩家",
	["Sets the background color for hostile players"] = "敵對玩家的背景顏色",
	["Hostile Pets"] = "敵對寵物",
	["Sets the background color for hostile pets"] = "敵對寵物的背景顏色",
	["Hostile NPCs"] = "敵對NPC",
	["Sets the background color for hostile units"] = "敵對NPC的背景顏色",
	["Hostile Boss"] = "敵對玩家",
	["Sets the background color for hostile boss units"] = "敵對首領的背景顏色",
	["Neutral Units"] = "中立單位",
	["Sets the background color for neutral units"] = "中立單位的背景顏色",
	["Group Pets"] = "團體寵物",
	["Sets the background color for group pets"] = "團體寵物的背景顏色",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Color Format"] = "顏色格式",
	["Color tag"] = "顏色標籤",
	["<Any tag string>"] = "<任何標籤文字>",
	
	["Border Color"] = "邊框顏色",
	["Sets the border color of the nameplate"] = "名牌邊框顏色",
	["Border Style"] = "邊框樣式",
	["Sets the style of the nameplate border"] = "名牌邊框樣式",
	["Background Style"] = "背景樣式",
	["Sets the style of the nameplate background"] = "設定名牌背景樣式",
	
	["NONE"] = "無", 
	["STANDARD"] = "標準", 
	["SQUARE"] = "正方形",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Enable Mouse"] = "启用鼠标",
	["Allows left click to target and right click to interact"] = "设定左键点击为选择目标，右键点击则为弹出选单",

	["Frame"] = "框架",
	["Frame options"] = "框架相关设置",
	["Width"] = "宽度",
	["Sets the width of the frame"] = "设定框架的宽度",
	["Height"] = "高度",
	["Sets the height of the frame"] = "设定框架的高度",

	["Packing Width"] = "间隔宽度",
	["Sets the minimum horizontal distance between frames"] = "设定框架之间的最小水平间隔",
	["Packing Height"] = "间隔高度",
	["Sets the minimum vertical distance between frames"] = "设定框架之间的最小垂直间隔",

	["Background Alpha"] = "背景透明度",
	["Sets the alpha for the background of the nameplates"] = "设定姓名板的背景透明度",
	["Background Colors"] = "背景颜色",
	["Customize colors"] = "自定义颜色",
	
	["Color by Class"] = "根据职业显示颜色",
	["Sets the background color according to class"] = "背景颜色使用职业代表色",
	["Color Hostile by Class"] = "敌对方单位根据职业显示颜色",
	["Sets the background color of hostile players according to class"] = "敌对方玩家的背景颜色使用职业代表色",
	["Set All"] = "设定全部",
	["Sets the background color for all types"] = "设定所有单位的背景颜色",

	["Set All Friendly"] = "设定全部友好方单位",
	["Sets the background color for all friendly types"] = "设定全部友好方单位的背景颜色",
	["Set All Hostile"] = "设定全部敌对方单位",
	["Sets the background color for all hostile types"] = "设定全部敌对方单位的背景颜色",

	["Pet"] = "宠物",
	["Sets the background color for your pet"] = "设定你的宠物的背景颜色",
	["Friendly Players"] = "友好方玩家",
	["Sets the background color for friendly players"] = "设定友好方玩家的背景颜色",
	["Friendly Pets"] = "友好方宠物",
	["Sets the background color for friendly pets"] = "设定友好方宠物的背景颜色",
	["Friendly NPCs"] = "友好方NPC",
	["Sets the background color for friendly NPC Bosses"] = "设定友好方首领的背景颜色",
	["Friendly Boss"] = "友好方首领",
	["Sets the background color for friendly NPCs"] = "设定友好NPC的背景颜色",
	["Hostile Players"] = "敌对方玩家",
	["Sets the background color for hostile players"] = "设定敌对方玩家的背景颜色",
	["Hostile Pets"] = "敌对方宠物",
	["Sets the background color for hostile pets"] = "设定敌对方宠物的背景颜色",
	["Hostile NPCs"] = "敌对方NPC",
	["Sets the background color for hostile units"] = "设定敌对方NPC的背景颜色",
	["Hostile Boss"] = "敌对方首领",
	["Sets the background color for hostile boss units"] = "设定敌对方首领的背景颜色",
	["Neutral Units"] = "中立方单位",
	["Sets the background color for neutral units"] = "设定中立方单位的背景颜色",
	["Group Pets"] = "队友宠物",
	["Sets the background color for group pets"] = "设定队友宠物的背景颜色",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Color Format"] = "颜色格式",
	["Color tag"] = "颜色标签",
	["<Any tag string>"] = "<任意标签文字>",
	
	["Border Color"] = "边框颜色",
	["Sets the border color of the nameplate"] = "姓名板边框颜色",
	["Border Style"] = "边框样式",
	["Sets the style of the nameplate border"] = "设定姓名板边框样式",
	["Background Style"] = "背景样式",
	["Sets the style of the nameplate background"] = "设定姓名牌背景样式",
	
	["NONE"] = "无", 
	["STANDARD"] = "标准", 
	["SQUARE"] = "正方形",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.frame =
{
	type = 'group',
	name = L["Frame"],
	desc = L["Frame options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enableMouse  =
		{
			type = 'toggle',
			name = L["Enable Mouse"],
			desc = L["Allows left click to target and right click to interact"],
			get = function() return AloftFrame.db.profile.enableMouse end,
			set = function(v) AloftFrame.db.profile.enableMouse = v AloftFrame:UpdateAll() end,
		},
		width =
		{
			type = 'range',
			name = L["Width"],
			desc = L["Sets the width of the frame"],
			min = -10,
			max = 100,
			step = 1,
			get = function() return AloftFrame.db.profile.width end,
			set = function(v) if AloftFrame.db.profile.width ~= v then AloftFrame.db.profile.width = v AloftFrame.db.profile.packingWidth = v AloftFrame:UpdateAll() end end,
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the frame"],
			min = -10,
			max = 100,
			step = 1,
			get = function() return AloftFrame.db.profile.height end,
			set = function(v) if AloftFrame.db.profile.height ~= v then AloftFrame.db.profile.height = v AloftFrame.db.profile.packingHeight = v AloftFrame:UpdateAll() end end,
		},
		packingWidth =
		{
			type = 'range',
			name = L["Packing Width"],
			desc = L["Sets the minimum horizontal distance between frames"],
			min = 0,
			max = 100,
			step = 1,
			get = function() return AloftFrame.db.profile.packingWidth end,
			set = function(v) AloftFrame.db.profile.packingWidth = v AloftFrame:UpdateAll() end,
		},
		packingHeight =
		{
			type = 'range',
			name = L["Packing Height"],
			desc = L["Sets the minimum vertical distance between frames"],
			min = 0,
			max = 100,
			step = 1,
			get = function() return AloftFrame.db.profile.packingHeight end,
			set = function(v) AloftFrame.db.profile.packingHeight = v AloftFrame:UpdateAll() end,
		},
		backgroundAlpha =
		{
			type = 'range',
			name = L["Background Alpha"],
			desc = L["Sets the alpha for the background of the nameplates"],
			min = 0,
			max = 1,
			step = 0.01,
			get = function() return AloftFrame.db.profile.backgroundAlpha end,
			set = function(v) 
				local oldShow = (AloftFrame.db.profile.backgroundAlpha ~= 0)
				AloftFrame.db.profile.backgroundAlpha = v
				local newShow = (v ~= 0)
				if oldShow ~= newShow then
					Aloft:DetermineDataSources()
				end
				AloftFrame:UpdateAll() 
			end,
		},
		backgroundColors =
		{
			type = 'group',
			name = L["Background Colors"],
			desc = L["Customize colors"],
			disabled = function() return AloftFrame.db.profile.backgroundAlpha == 0 end,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					name = L["Color by Class"],
					desc = L["Sets the background color according to class"],
					get = function() return AloftFrame.db.profile.colorByClass end,
					set = function(v) AloftFrame.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftFrame:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					name = L["Color Hostile by Class"],
					desc = L["Sets the background color of hostile players according to class"],
					get = function() return AloftFrame.db.profile.colorHostileByClass end,
					set = function(v) AloftFrame.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftFrame:UpdateAll() end,
					order = 2
				},
				setAll =
				{
					type = 'color',
					name = L["Set All"],
					desc = L["Sets the background color for all types"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.friendlyPlayer) end,
					set = function(r, g, b) 
						AloftFrame.db.profile.backgroundColors.friendlyPlayer	= { r, g, b }
						AloftFrame.db.profile.backgroundColors.friendlyPet		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.friendlyNPC		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.friendlyBoss		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostilePlayer	= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostilePet		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostileNPC		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostileBoss		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.neutral			= { r, g, b }
						AloftFrame.db.profile.backgroundColors.pet				= { r, g, b }
						AloftFrame.db.profile.backgroundColors.groupPet			= { r, g, b }
						Aloft:DetermineDataSources() 
						AloftFrame:UpdateAll() end,
					order = 3
				},
				setAllFriendly =
				{
					type = 'color',
					name = L["Set All Friendly"],
					desc = L["Sets the background color for all friendly types"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.friendlyPlayer) end,
					set = function(r, g, b) 
						AloftFrame.db.profile.backgroundColors.friendlyPlayer	= { r, g, b }
						AloftFrame.db.profile.backgroundColors.friendlyPet		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.friendlyNPC		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.friendlyBoss		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.pet				= { r, g, b }
						AloftFrame.db.profile.backgroundColors.groupPet			= { r, g, b }
						Aloft:DetermineDataSources() 
						AloftFrame:UpdateAll() end,
					order = 4
				},
				setAllHostile =
				{
					type = 'color',
					name = L["Set All Hostile"],
					desc = L["Sets the background color for all hostile types"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.hostileNPC) end,
					set = function(r, g, b) 
						AloftFrame.db.profile.backgroundColors.hostilePlayer	= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostilePet		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostileNPC		= { r, g, b }
						AloftFrame.db.profile.backgroundColors.hostileBoss		= { r, g, b }
						Aloft:DetermineDataSources() 
						AloftFrame:UpdateAll() end,
					order = 5
				},
				friendlyPlayer =
				{
					type = 'color',
					name = L["Friendly Players"],
					desc = L["Sets the background color for friendly players"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.friendlyPlayer) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.friendlyPlayer = { r, g, b } AloftFrame:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					name = L["Friendly Pets"],
					desc = L["Sets the background color for friendly pets"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.friendlyPet) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					name = L["Friendly NPCs"],
					desc = L["Sets the background color for friendly NPCs"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.friendlyNPC) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					name = L["Friendly Boss"],
					desc = L["Sets the background color for friendly NPC Bosses"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.friendlyBoss) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.friendlyBoss = { r, g, b } AloftFrame:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					name = L["Hostile Players"],
					desc = L["Sets the background color for hostile players"],
					disabled = function() return AloftFrame.db.profile.colorHostileByClass end,
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.hostilePlayer) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					name = L["Hostile Pets"],
					desc = L["Sets the background color for hostile pets"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.hostilePet) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					name = L["Hostile NPCs"],
					desc = L["Sets the background color for hostile units"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.hostileNPC) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					name = L["Hostile Boss"],
					desc = L["Sets the background color for hostile boss units"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.hostileBoss) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.hostileBoss = { r, g, b } AloftFrame:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					name = L["Neutral Units"],
					desc = L["Sets the background color for neutral units"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.neutral) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.neutral = { r, g, b } AloftFrame:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					name = L["Pet"],
					desc = L["Sets the background color for your pet"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.pet) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.pet = { r, g, b } AloftFrame:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					name = L["Group Pets"],
					desc = L["Sets the background color for group pets"],
					get = function() return unpack(AloftFrame.db.profile.backgroundColors.groupPet) end,
					set = function(r, g, b) AloftFrame.db.profile.backgroundColors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
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
							get = function() return Aloft:HighlightTagSyntax(AloftFrame.db.profile.colorFormat) end,
							set = function(v) AloftFrame.db.profile.colorFormat = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftFrame:UpdateAll() end,
						}
					},
				},
			}
		},
		borderColor =
		{
			type = 'color',
			name = L["Border Color"],
			desc = L["Sets the border color of the nameplate"],
			get = function() return unpack(AloftFrame.db.profile.borderColor) end,
			set = function(r, g, b, a) AloftFrame.db.profile.borderColor = { r, g, b, a } AloftFrame:UpdateAll() end,
			disabled = function() return AloftFrame.db.profile.border == "None" end,
			hasAlpha = true,
		},
		border =
		{
			type = 'text',
			name = L["Border Style"],
			desc = L["Sets the style of the nameplate border"],
			get = function() return AloftFrame.db.profile.border end,
			set = function(v) AloftFrame.db.profile.border = v AloftFrame:UpdateAll() end,
			validate = SML:List("border")
		},
		background =
		{
			type = 'text',
			name = L["Background Style"],
			desc = L["Sets the style of the nameplate background"],
			get = function() return AloftFrame.db.profile.background end,
			set = function(v) AloftFrame.db.profile.background = v AloftFrame:UpdateAll() end,
			validate = SML:List("background")
		},
	},
}

-----------------------------------------------------------------------------
