-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("CastBar") then return end
local AloftCastBar = Aloft:GetModule("CastBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftCastBarOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Cast Bar"] = true,
	["Cast bar options"] = true,
	["Enable"] = true,
	["Shows the current target's casting bar"] = true,
	["Position"] = true,
	["Adjust cast bar position"] = true,
	["Left Offset"] = true,
	["Sets the offset of the left of the cast bar"] = true,
	["Right Offset"] = true,
	["Sets the offset of the right of the cast bar"] = true,
	["Vertical Offset"] = true,
	["Sets the vertical offset of the cast bar"] = true,
	["Texture"] = true,
	["Sets the cast bar texture"] = true,
	["Height"] = true,
	["Sets the height of the cast bar"] = true,
	["Backdrop Color"] = true,
	["Sets the backdrop color of the cast bar"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Cast Bar"] = "시전바",
	["Cast bar options"] = "시전바 설정",
	["Enable"] = "사용",
	["Shows the current target's casting bar"] = "현재 대상의 시전바를 표시합니다.",
	["Position"] = "위치",
	["Adjust cast bar position"] = "시전바 위치 조절",
	["Left Offset"] = "좌측 좌표",
	["Sets the offset of the left of the cast bar"] = "시전바의 좌측 좌표를 설정합니다.",
	["Right Offset"] = "우측 좌표",
	["Sets the offset of the right of the cast bar"] = "시전바의 우측 좌표를 설정합니다.",
	["Vertical Offset"] = "수직 좌표",
	["Sets the vertical offset of the cast bar"] = "시전바의 수직 좌표를 설정합니다.",
	["Texture"] = "텍스쳐",
	["Sets the cast bar texture"] = "시전바의 텍스쳐를 설정합니다.",
	["Height"] = "높이",
	["Sets the height of the cast bar"] = "시전바의 높이를 설정합니다.",
	["Backdrop Color"] = "배경 색상",
	["Sets the backdrop color of the cast bar"] = "시전바의 배경 색상을 설정합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Cast Bar"] = "施法條",
	["Cast bar options"] = "施法條選項",
	["Enable"] = "啟用",
	["Shows the current target's casting bar"] = "顯示目前目標的施法條",
	["Position"] = "位置",
	["Adjust cast bar position"] = "調整施法條位置",
	["Left Offset"] = "左位移",
	["Sets the offset of the left of the cast bar"] = "施法條左位移",
	["Right Offset"] = "右位移",
	["Sets the offset of the right of the cast bar"] = "施法條右位移",
	["Vertical Offset"] = "垂直位移",
	["Sets the vertical offset of the cast bar"] = "施法條垂直位移",
	["Texture"] = "紋理",
	["Sets the cast bar texture"] = "施法條紋理",
	["Height"] = "高度",
	["Sets the height of the cast bar"] = "施法條高度",
	["Backdrop Color"] = "背景顏色",
	["Sets the backdrop color of the cast bar"] = "施法條背景顏色",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Cast Bar"] = "施法条",
	["Cast bar options"] = "施法条相关设置",
	["Enable"] = "启用",
	["Shows the current target's casting bar"] = "显示当前目标的施法条",
	["Position"] = "位置",
	["Adjust cast bar position"] = "调整施法条的位置",
	["Left Offset"] = "向左偏移",
	["Sets the offset of the left of the cast bar"] = "设定施法條的向左偏移量",
	["Right Offset"] = "向右偏移",
	["Sets the offset of the right of the cast bar"] = "设定施法条的向右偏移量",
	["Vertical Offset"] = "垂直偏移",
	["Sets the vertical offset of the cast bar"] = "设定施法条的垂直偏移量",
	["Texture"] = "材质",
	["Sets the cast bar texture"] = "设定施法条的材质",
	["Height"] = "高度",
	["Sets the height of the cast bar"] = "设置施法条的高度",
	["Backdrop Color"] = "背景颜色",
	["Sets the backdrop color of the cast bar"] = "设定施法条的背景颜色",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.castBar =
{
	type = 'group',
	name = L["Cast Bar"],
	desc = L["Cast bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Shows the current target's casting bar"],
			get = function() return GetCVar("ShowVKeyCastbar") == "1" end,
			set = function(v) SetCVar("ShowVKeyCastbar", v and "1" or "0") end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast bar position"],
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the cast bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBar.db.profile.offsets.left end,
					set = function(v) AloftCastBar.db.profile.offsets.left = v AloftCastBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the cast bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBar.db.profile.offsets.right end,
					set = function(v) AloftCastBar.db.profile.offsets.right = v AloftCastBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the cast bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBar.db.profile.offsets.vertical end,
					set = function(v) AloftCastBar.db.profile.offsets.vertical = v AloftCastBar:UpdateAll() end
				},
			},
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the cast bar"],
			min = 5,
			max = 32,
			step = 1,
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			get = function() return AloftCastBar.db.profile.height end,
			set = function(v) AloftCastBar.db.profile.height = v AloftCastBar:UpdateAll() end
		},
		backdrop =
		{
			type = 'color',
			name = L["Backdrop Color"],
			desc = L["Sets the backdrop color of the cast bar"],
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			get = function() return unpack(AloftCastBar.db.profile.backdropColor) end,
			set = function(r, g, b, a) AloftCastBar.db.profile.backdropColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
			hasAlpha = true,
		},
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the cast bar texture"],
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			get = function() return AloftCastBar.db.profile.texture end,
			set = function(v) AloftCastBar.db.profile.texture = v AloftCastBar:UpdateAll() end,
			validate = SML_statusbar,
		},
	},
}

-----------------------------------------------------------------------------
