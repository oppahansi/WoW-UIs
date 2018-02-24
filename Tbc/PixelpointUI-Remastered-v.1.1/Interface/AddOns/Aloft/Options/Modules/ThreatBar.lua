-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ThreatBar") then return end
local AloftThreatBar = Aloft:GetModule("ThreatBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftThreatBarOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Threat Bar"] = true,
	["Threat Bar options"] = true,
	["Enable"] = true,
	["Show threat bars on group member nameplates"] = true,

	["Texture"] = true,
	["Sets the threat bar texture"] = true,
	["Alpha"] = true,
	["Sets the threat bar alpha"] = true,

	["Height"] = true,
	["Sets the height of the threat bar"] = true,
	
	["Position"] = true,
	["Adjust the threat bar's position"] = true,
	["Left Offset"] = true,
	["Sets the offset of the left of the threat bar"] = true,
	["Right Offset"] = true,
	["Sets the offset of the right of the threat bar"] = true,
	["Vertical Offset"] = true,
	["Sets the vertical offset of the threat bar"] = true,
	
	["Colors"] = true,
	["Customize colors"] = true,
	["Maximum Threat Common Color"] = true,
	["Sets the color for threat shared when you have the maximum threat on a unit."] = true,
	["Maximum Threat Margin Color"] = true,
	["Sets the color for the threat before someone matches your threat level."] = true,
	["Common Threat Color"] = true,
	["Sets the color for your threat level when you do not have maximum threat."] = true,
	["Common Threat Margin Color"] = true,
	["Sets the color for the threat remaining until you match the highest threat."] = true,

	["Reset to Defaults"] = true,
	["Resets all colors to their defaults"] = true,

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Color Format"] = true,
	["Color tag"] = true,
	["<Any tag string>"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Threat Bar"] = "위협바",
	["Threat Bar options"] = "위협바 설정",
	["Enable"] = "사용",
	["Show threat bars on group member nameplates"] = "파티원의 이름표에 위협바를 표시합니다.",

	["Texture"] = "텍스쳐",
	["Sets the threat bar texture"] = "위협바의 텍스쳐를 설정합니다.",
	["Alpha"] = "투명도",
	["Sets the threat bar alpha"] = "위협바의 투명도를 설정합니다.",

	["Height"] = "높이",
	["Sets the height of the threat bar"] = "위협바의 높이를 설정합니다.",
	
	["Position"] = "위치",
	["Adjust the threat bar's position"] = "위협바의 위치를 조절합니다.",
	["Left Offset"] = "좌측 좌표",
	["Sets the offset of the left of the threat bar"] = "위협바의 좌측 좌표를 설정합니다.",
	["Right Offset"] = "우측 좌표",
	["Sets the offset of the right of the threat bar"] = "위협바의 우측 좌표를 설정합니다.",
	["Vertical Offset"] = "수직 좌표",
	["Sets the vertical offset of the threat bar"] = "위협바의 수직 좌표를 설정합니다.",
	
	["Colors"] = "색상",
	["Customize colors"] = "사용자 정의 색상",
	["Maximum Threat Common Color"] = "최대 위협 일반 색상",
	["Sets the color for threat shared when you have the maximum threat on a unit."] = "당신이 대상의 최대 위협을 획득했을 때 공유된 최대 위협에 대한 색상을 설정합니다.",
	["Maximum Threat Margin Color"] = "최대 위협 차이 색상",
	["Sets the color for the threat before someone matches your threat level."] = "이전에 당신의 위협 레벨과 같은 누군가의 위협에 대한 색상을 설정합니다.",
	["Common Threat Color"] = "일반 위협 색상",
	["Sets the color for your threat level when you do not have maximum threat."] = "당신이 최대 위협을 획득하지 않았을 때 당신의 위협 레벨의 색상을 설정합니다.",
	["Common Threat Margin Color"] = "일반 위협 차이 색상",
	["Sets the color for the threat remaining until you match the highest threat."] = "당신이 최고 위협과 일치하기 전까지 남은 위협의 색상을 설정합니다.",

	["Reset to Defaults"] = "기본값으로 초기화",
	["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자에 대한 설정입니다.",
	["Color Format"] = "색상 형식",
	["Color tag"] = "색상 태그",
	["<Any tag string>"] = "<태그 문자열>",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Threat Bar"] = "威脅值條",
	["Threat Bar options"] = "威脅值條選項",
	["Enable"] = "啟用",
	["Show threat bars on group member nameplates"] = "在團體名牌顯示威脅值條",

	["Texture"] = "紋理",
	["Sets the threat bar texture"] = "威脅值條紋理",
	["Alpha"] = "透明度",
	["Sets the threat bar alpha"] = "威脅值條透明度",

	["Height"] = "高度",
	["Sets the height of the threat bar"] = "威脅值條高度",
	
	["Position"] = "位置",
	["Adjust the threat bar's position"] = "威脅值條位置",
	["Left Offset"] = "左位移",
	["Sets the offset of the left of the threat bar"] = "威脅值條左位移",
	["Right Offset"] = "右位移",
	["Sets the offset of the right of the threat bar"] = "威脅值條右位移",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the threat bar"] = "威脅值條垂直位移",
	
	["Colors"] = "顏色",
	["Customize colors"] = "自定顏色",
	["Maximum Threat Common Color"] = "最大威脅值共同顏色",
	["Sets the color for threat shared when you have the maximum threat on a unit."] = "與威脅值第二位共同分享的威脅值顏色",
	["Maximum Threat Margin Color"] = "最大威脅值邊際顏色",
	["Sets the color for the threat before someone matches your threat level."] = "比威脅值第二位多的威脅值顏色",
	["Common Threat Color"] = "共同威脅值顏色",
	["Sets the color for your threat level when you do not have maximum threat."] = "與威脅值第一位共同分享的威脅值顏色",
	["Common Threat Margin Color"] = "共同威脅值邊際顏色",
	["Sets the color for the threat remaining until you match the highest threat."] = "比威脅值第一位小的威脅值顏色",

	["Reset to Defaults"] = "重設回預設值",
	["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Color Format"] = "顏色格式",
	["Color tag"] = "顏色標籤",
	["<Any tag string>"] = "<任何標籤文字>",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Threat Bar"] = "威胁值显示条",
	["Threat Bar options"] = "威胁值显示条相关设置",
	["Enable"] = "启用",
	["Show threat bars on group member nameplates"] = "在团队成员的姓名板上显示威胁值显示条",

	["Texture"] = "材质",
	["Sets the threat bar texture"] = "设定威胁值显示条的材质",
	["Alpha"] = "透明度",
	["Sets the threat bar alpha"] = "设定威胁值显示条的透明度",

	["Height"] = "高度",
	["Sets the height of the threat bar"] = "设定威胁值显示条的高度",
	
	["Position"] = "位置",
	["Adjust the threat bar's position"] = "调整威胁值显示条的位置",
	["Left Offset"] = "向左偏移",
	["Sets the offset of the left of the threat bar"] = "设定威胁值显示条的向左偏移量",
	["Right Offset"] = "向右偏移",
	["Sets the offset of the right of the threat bar"] = "设定威胁值显示条的向右偏移量",
	["Vertical Offset"] = "垂直偏移",
	["Sets the vertical offset of the threat bar"] = "设定威胁值显示条的垂直偏移量",
	
	["Colors"] = "颜色",
	["Customize colors"] = "自定义颜色",
	["Maximum Threat Common Color"] = "最大威胁值的共同颜色",
	["Sets the color for threat shared when you have the maximum threat on a unit."] = "设定最大威胁值与第二威胁值重合部分威胁值的颜色",
	["Maximum Threat Margin Color"] = "最大威胁值的边际颜色",
	["Sets the color for the threat before someone matches your threat level."] = "设定最大威胁值比第二威胁值多出部分的颜色",
	["Common Threat Color"] = "共同威胁值颜色",
	["Sets the color for your threat level when you do not have maximum threat."] = "设定你在并非是最大威胁值时，你的威胁值颜色",
	["Common Threat Margin Color"] = "共同威胁值边际颜色",
	["Sets the color for the threat remaining until you match the highest threat."] = "设定你与最大威胁值的差值部分的颜色",

	["Reset to Defaults"] = "重置为默认",
	["Resets all colors to their defaults"] = "将所有的颜色设定重置为默认",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Color Format"] = "颜色格式",
	["Color tag"] = "颜色标签",
	["<Any tag string>"] = "<任意标签文字>",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.threatBar =
{
	type = 'group',
	name = L["Threat Bar"],
	desc = L["Threat Bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show threat bars on group member nameplates"],
			get = function() return AloftThreatBar.db.profile.enable end,
			set = function(v) AloftThreatBar.db.profile.enable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
			order = 1
		},
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the threat bar texture"],
			get = function() return AloftThreatBar.db.profile.texture end,
			set = function(v) AloftThreatBar.db.profile.texture = v AloftThreatBar:UpdateAll() end,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			validate = SML_statusbar
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the threat bar's position"],
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the threat bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftThreatBar.db.profile.offsets.left end,
					set = function(v) AloftThreatBar.db.profile.offsets.left = v AloftThreatBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the threat bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftThreatBar.db.profile.offsets.right end,
					set = function(v) AloftThreatBar.db.profile.offsets.right = v AloftThreatBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the threat bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftThreatBar.db.profile.offsets.vertical end,
					set = function(v) AloftThreatBar.db.profile.offsets.vertical = v AloftThreatBar:UpdateAll() end
				},
			},
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the threat bar"],
			min = 2,
			max = 32,
			step = 1,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			get = function() return AloftThreatBar.db.profile.height end,
			set = function(v) AloftThreatBar.db.profile.height = v AloftThreatBar:UpdateAll() end
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				maxThreatCommonColor =
				{
					type = 'color',
					name = L["Maximum Threat Common Color"],
					desc = L["Sets the color for threat shared when you have the maximum threat on a unit."],
					get = function() return unpack(AloftThreatBar.db.profile.maxThreatCommonColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.maxThreatCommonColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				maxThreatMarginColor =
				{
					type = 'color',
					name = L["Maximum Threat Margin Color"],
					desc = L["Sets the color for the threat before someone matches your threat level."],
					get = function() return unpack(AloftThreatBar.db.profile.maxThreatMarginColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.maxThreatMarginColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				commonThreatColor =
				{
					type = 'color',
					name = L["Common Threat Color"],
					desc = L["Sets the color for your threat level when you do not have maximum threat."],
					get = function() return unpack(AloftThreatBar.db.profile.commonThreatColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.commonThreatColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				commonThreatMarginColor =
				{
					type = 'color',
					name = L["Common Threat Margin Color"],
					desc = L["Sets the color for the threat remaining until you match the highest threat."],
					get = function() return unpack(AloftThreatBar.db.profile.commonThreatMarginColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.commonThreatMarginColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
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
								AloftThreatBar.db.profile.maxThreatCommonColor	= { 1, 1, 1, 1 }
								AloftThreatBar.db.profile.maxThreatMarginColor	= { 0, 1, 0, 1 }
								AloftThreatBar.db.profile.commonThreatColor		= { 1, 1, 1, 1 }
								AloftThreatBar.db.profile.commonThreatMarginColor	= { 1, 0, 0, 1 }
								
								AloftThreatBar:UpdateAll()
							end,
				},
			}
		}
	},
}

-----------------------------------------------------------------------------
