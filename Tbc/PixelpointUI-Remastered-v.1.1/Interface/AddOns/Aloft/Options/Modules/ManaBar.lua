-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ManaBar") then return end
local AloftManaBar = Aloft:GetModule("ManaBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftManaBarOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Mana Bar"] = true,
	["Mana Bar options"] = true,
	["Enable"] = true,
	["Show mana bars on group member nameplates"] = true,

	["Texture"] = true,
	["Sets the mana bar texture"] = true,
	["Alpha"] = true,
	["Sets the mana bar alpha"] = true,

	["Height"] = true,
	["Sets the height of the mana bar"] = true,
	
	["Position"] = true,
	["Adjust the mana bar's position"] = true,
	["Left Offset"] = true,
	["Sets the offset of the left of the mana bar"] = true,
	["Right Offset"] = true,
	["Sets the offset of the right of the mana bar"] = true,
	["Vertical Offset"] = true,
	["Sets the vertical offset of the mana bar"] = true,
	
	["Colors"] = true,
	["Customize colors"] = true,
	["Backdrop Color"] = true,
	["Sets the backdrop color of the mana bar"] = true,
	["Mana Color"] = true,
	["Sets the color for mana bars"] = true,
	["Rage Color"] = true,
	["Sets the color for rage bars"] = true,
	["Focus Color"] = true,
	["Sets the color for focus bars"] = true,
	["Energy Color"] = true,
	["Sets the color for energy bars"] = true,
	["Happiness Color"] = true,
	["Sets the color for happiness bars"] = true,
	["Reset to Defaults"] = true,
	["Resets all colors to their defaults"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Color Format"] = true,
	["Color tag"] = true,
	["<Any tag string>"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Mana Bar"] = "마나바",
	["Mana Bar options"] = "마나바 설정",
	["Enable"] = "사용",
	["Show mana bars on group member nameplates"] = "파티원의 이름표에 마나바를 표시합니다.",

	["Texture"] = "텍스쳐",
	["Sets the mana bar texture"] = "마나바의 텍스쳐를 설정합니다.",
	["Alpha"] = "투명도",
	["Sets the mana bar alpha"] = "마나바의 투명도를 설정합니다.",

	["Height"] = "높이",
	["Sets the height of the mana bar"] = "마나바의 높이를 설정합니다.",
	
	["Position"] = "위치",
	["Adjust the mana bar's position"] = "마나바의 위치를 조절합니다.",
	["Left Offset"] = "좌측 좌표",
	["Sets the offset of the left of the mana bar"] = "마나바의 좌측 좌표를 설정합니다.",
	["Right Offset"] = "우측 좌표",
	["Sets the offset of the right of the mana bar"] = "마나바의 우측 좌표를 설정합니다.",
	["Vertical Offset"] = "수직 좌표",
	["Sets the vertical offset of the mana bar"] = "마나바의 수직 좌표를 설정합니다.",
	
	["Colors"] = "색상",
	["Customize colors"] = "사용자 색상",
	["Backdrop Color"] = "배경 색상",
	["Sets the backdrop color of the mana bar"] = "마나바의 배경 색상을 설정합니다.",
	["Mana Color"] = "마나 색상",
	["Sets the color for mana bars"] = "마나바의 색상을 설정합니다.",
	["Rage Color"] = "분노 색상",
	["Sets the color for rage bars"] = "분노바의 색상을 설정합니다.",
	["Focus Color"] = "지정 색상",
	["Sets the color for focus bars"] = "지정바의 색상을 설정합니다.",
	["Energy Color"] = "기력 색상",
	["Sets the color for energy bars"] = "기력바의 색상을 설정합니다.",
	["Happiness Color"] = "만족도 색상",
	["Sets the color for happiness bars"] = "만족도바의 색상을 설정합니다.",
	["Reset to Defaults"] = "기본값 초기화",
	["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정",
	["Color Format"] = "색상 형식",
	["Color tag"] = "색상 태그",
	["<Any tag string>"] = "<태그 문자열>",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Mana Bar"] = "能力條",
	["Mana Bar options"] = "能力條選項",
	["Enable"] = "啟用",
	["Show mana bars on group member nameplates"] = "在團體名牌顯示能力條",

	["Texture"] = "紋理",
	["Sets the mana bar texture"] = "能力條紋理",
	["Alpha"] = "透明度",
	["Sets the mana bar alpha"] = "能力條透明度",

	["Height"] = "高度",
	["Sets the height of the mana bar"] = "能力條高度",
	
	["Position"] = "位置",
	["Adjust the mana bar's position"] = "能力條位置",
	["Left Offset"] = "左位移",
	["Sets the offset of the left of the mana bar"] = "能力條左位移",
	["Right Offset"] = "右位移",
	["Sets the offset of the right of the mana bar"] = "能力條右位移",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the mana bar"] = "能力條垂直位移",
	
	["Colors"] = "顏色",
	["Customize colors"] = "自定顏色",
	["Backdrop Color"] = "背景顏色",
	["Sets the backdrop color of the mana bar"] = "能力條背景顏色",
	["Mana Color"] = "法力顏色",
	["Sets the color for mana bars"] = "法力條顏色",
	["Rage Color"] = "怒氣顏色",
	["Sets the color for rage bars"] = "怒氣條顏色",
	["Focus Color"] = "集中值顏色",
	["Sets the color for focus bars"] = "集中值條顏色",
	["Energy Color"] = "能量顏色",
	["Sets the color for energy bars"] = "能量條顏色",
	["Happiness Color"] = "快樂值顏色",
	["Sets the color for happiness bars"] = "快樂值條顏色",
	["Reset to Defaults"] = "重設回預設值",
	["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Color Format"] = "顏色格式",
	["Color tag"] = "顏色標籤",
	["<Any tag string>"] = "<任何標籤文字>",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Mana Bar"] = "法力值显示条",
	["Mana Bar options"] = "法力值显示条相关设置",
	["Enable"] = "启用",
	["Show mana bars on group member nameplates"] = "在队友的姓名板上显示法力值显示条",

	["Texture"] = "材质",
	["Sets the mana bar texture"] = "设定法力值显示条的材质",
	["Alpha"] = "透明度",
	["Sets the mana bar alpha"] = "设定法力值显示条的透明度",

	["Height"] = "高度",
	["Sets the height of the mana bar"] = "设定法力值显示条的高度",
	
	["Position"] = "位置",
	["Adjust the mana bar's position"] = "调整法力值显示条的位置",
	["Left Offset"] = "向左偏移",
	["Sets the offset of the left of the mana bar"] = "设定法力值显示条的向左偏移量",
	["Right Offset"] = "向右偏移",
	["Sets the offset of the right of the mana bar"] = "设定法力值显示条的向右偏移量",
	["Vertical Offset"] = "垂直偏移",
	["Sets the vertical offset of the mana bar"] = "设定法力值显示条的垂直偏移量",
	
	["Colors"] = "颜色",
	["Customize colors"] = "自定义颜色",
	["Backdrop Color"] = "背景颜色",
	["Sets the backdrop color of the mana bar"] = "设定法力值显示条的背景颜色",
	["Mana Color"] = "法力颜色",
	["Sets the color for mana bars"] = "设定法力条的颜色",
	["Rage Color"] = "怒气颜色",
	["Sets the color for rage bars"] = "设定怒气条的颜色",
	["Focus Color"] = "集中值颜色",
	["Sets the color for focus bars"] = "设定集中值显示条的颜色",
	["Energy Color"] = "能量颜色",
	["Sets the color for energy bars"] = "设定能量条的颜色",
	["Happiness Color"] = "快乐值颜色",
	["Sets the color for happiness bars"] = "设定快乐值显示条的颜色",
	["Reset to Defaults"] = "重置为默认值",
	["Resets all colors to their defaults"] = "将全部颜色设定重置为默认",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Color Format"] = "颜色格式",
	["Color tag"] = "颜色标签",
	["<Any tag string>"] = "<任意标签文字>",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.manaBar =
{
	type = 'group',
	name = L["Mana Bar"],
	desc = L["Mana Bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show mana bars on group member nameplates"],
			get = function() return AloftManaBar.db.profile.enable end,
			set = function(v) AloftManaBar.db.profile.enable = v Aloft:DetermineDataSources() AloftManaBar:UpdateAll() end,
			order = 1
		},
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the mana bar texture"],
			get = function() return AloftManaBar.db.profile.texture end,
			set = function(v) AloftManaBar.db.profile.texture = v AloftManaBar:UpdateAll() end,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			validate = SML_statusbar
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the mana bar's position"],
			disabled = function() return not AloftManaBar.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the mana bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftManaBar.db.profile.offsets.left end,
					set = function(v) AloftManaBar.db.profile.offsets.left = v AloftManaBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the mana bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftManaBar.db.profile.offsets.right end,
					set = function(v) AloftManaBar.db.profile.offsets.right = v AloftManaBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the mana bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftManaBar.db.profile.offsets.vertical end,
					set = function(v) AloftManaBar.db.profile.offsets.vertical = v AloftManaBar:UpdateAll() end
				},
			},
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the mana bar"],
			min = 2,
			max = 32,
			step = 1,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			get = function() return AloftManaBar.db.profile.height end,
			set = function(v) AloftManaBar.db.profile.height = v AloftManaBar:UpdateAll() end
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function() return not AloftManaBar.db.profile.enable end,
			args =
			{
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the mana bar"],
					get = function() return unpack(AloftManaBar.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.backdropColor = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				mana =
				{
					type = 'color',
					name = L["Mana Color"],
					desc = L["Sets the color for mana bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[0]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[0] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				rage =
				{
					type = 'color',
					name = L["Rage Color"],
					desc = L["Sets the color for rage bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[1]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[1] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				focus =
				{
					type = 'color',
					name = L["Focus Color"],
					desc = L["Sets the color for focus bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[2]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[2] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				energy =
				{
					type = 'color',
					name = L["Energy Color"],
					desc = L["Sets the color for energy bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[3]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[3] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				happiness =
				{
					type = 'color',
					name = L["Happiness Color"],
					desc = L["Sets the color for happiness bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[4]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[4] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function() 
								AloftManaBar.db.profile.backgroundColor	= { 0.25, 0.25, 0.25, 0.5 }
								AloftManaBar.db.profile.powerTypeColors	=
								{
									[0] = { 0.28, 0.52, 0.84, 1},	-- Mana
									[1] = { 0.89, 0.18, 0.29, 1}, 	-- Rage
									[2] = {    1, 0.82,    0, 1},	-- Focus
									[3] = {    1, 0.86, 0.10, 1}, 	-- Energy
									[4] = {    0,    1,    1, 1} 	-- Happiness
								},
								AloftManaBar:UpdateAll()
							end,
				},
			}
		}
	},
}

-----------------------------------------------------------------------------
