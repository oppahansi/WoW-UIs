-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("Polymorph") then return end
local AloftPolymorph = Aloft:GetModule("Polymorph")

local L = AceLibrary("AceLocale-2.2"):new("AloftPolymorphOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Polymorph"] = true,
	["Polymorph options"] = true,

	["Enable"] = true,
	["Shows polymorph timers on nameplates when possible"] = true,
	["Speculative Attach"] = true,
	["Attempt to attach the polymorph timer bar when it is not absolutely certain if it is the correct nameplate"] = true,
	["Texture"] = true,
	["Sets the polymorph bar texture"] = true,
	["Colors"] = true,
	["Color options"] = true,
	["Bar Color"] = true,
	["Sets the polymorph bar color"] = true,
	["Backdrop Color"] = true,
	["Sets the polymorph backdrop color"] = true,
	["Size"] = true,
	["Polymorph size options"] = true,
	["Width"] = true,
	["Sets the width of the polymorph bar"] = true,
	["Height"] = true,
	["Sets the height of the polymorph bar"] = true,
	["Position"] = true,
	["Adjust polymorph bar position"] = true,
	["Anchor"] = true,
	["Sets the anchor for the polymorph bar"] = true,
	["Anchor To"] = true,
	["Sets the relative point on the health bar to anchor the polymorph bar"] = true,
	["X Offset"] = true,
	["X offset of the polymorph bar"] = true,
	["Y Offset"] = true,
	["Y offset of the polymorph bar"] = true,

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
	["Polymorph"] = "변이",
	["Polymorph options"] = "변이 설정",

	["Enable"] = "사용",
	["Shows polymorph timers on nameplates when possible"] = "가능할 때 이름표에 변이 타이머를 표시합니다.",
	["Speculative Attach"] = "추리적인 붙이기",
	["Attempt to attach the polymorph timer bar when it is not absolutely certain if it is the correct nameplate"] = "정확한 이름표가 확실치 않을때 변이 타이머바 붙이기를 시도합니다.",
	["Texture"] = "텍스쳐",
	["Sets the polymorph bar texture"] = "변이바의 텍스쳐를 설정합니다.",
	["Colors"] = "색상",
	["Color options"] = "색상 설정",
	["Bar Color"] = "바 색상",
	["Sets the polymorph bar color"] = "변이바의 색상을 설정합니다.",
	["Backdrop Color"] = "배경 색상",
	["Sets the polymorph backdrop color"] = "변이바의 배경 색상을 설정합니다.",
	["Size"] = "크기",
	["Polymorph size options"] = "변이 크기 설정",
	["Width"] = "너비",
	["Sets the width of the polymorph bar"] = "변이바의 너비를 설정합니다.",
	["Height"] = "높이",
	["Sets the height of the polymorph bar"] = "변이바의 높이를 설정합니다.",
	["Position"] = "위치",
	["Adjust polymorph bar position"] = "변이바의 위치를 조절합니다.",
	["Anchor"] = "앵커",
	["Sets the anchor for the polymorph bar"] = "변이바의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치",
	["Sets the relative point on the health bar to anchor the polymorph bar"] = "생명력바에서 변이바 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the polymorph bar"] = "변이바의 X 좌표입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the polymorph bar"] = "변이바의 Y 좌표입니다.",

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
	["Polymorph"] = "變形條",
	["Polymorph options"] = "變形條選項",

	["Enable"] = "啟用",
	["Shows polymorph timers on nameplates when possible"] = "當可能時在名牌顯示變形計時",
	["Speculative Attach"] = "推理依附",
	["Attempt to attach the polymorph timer bar when it is not absolutely certain if it is the correct nameplate"] = "根據推理依附變形條在不肯定正確的名牌",
	["Texture"] = "紋理",
	["Sets the polymorph bar texture"] = "變形條紋理",
	["Colors"] = "顏色",
	["Color options"] = "顏色選項",
	["Bar Color"] = "變形條顏色",
	["Sets the polymorph bar color"] = "變形條顏色",
	["Backdrop Color"] = "背景顏色",
	["Sets the polymorph backdrop color"] = "變形條背景顏色",
	["Size"] = "大小",
	["Polymorph size options"] = "變形條大小",
	["Width"] = "寬度",
	["Sets the width of the polymorph bar"] = "變形條寬度",
	["Height"] = "高度",
	["Sets the height of the polymorph bar"] = "變形條高度",
	["Position"] = "位置",
	["Adjust polymorph bar position"] = "變形條位置",
	["Anchor"] = "定位點",
	["Sets the anchor for the polymorph bar"] = "變形條定位點",
	["Anchor To"] = "固定在",
	["Sets the relative point on the health bar to anchor the polymorph bar"] = "變形條固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the polymorph bar"] = "變形條X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the polymorph bar"] = "變形條Y位移",

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
	["Polymorph"] = "变形术计时条",
	["Polymorph options"] = "变形术计时条相关设置",

	["Enable"] = "启用",
	["Shows polymorph timers on nameplates when possible"] = "可能时，在姓名板上显示变形术计时条",
	["Speculative Attach"] = "推理依附",
	["Attempt to attach the polymorph timer bar when it is not absolutely certain if it is the correct nameplate"] = "在不确定依附对象为正确的姓名板时，仍然尝试根据推理依附变形术计时条",
	["Texture"] = "材质",
	["Sets the polymorph bar texture"] = "变形术计时条的材质",
	["Colors"] = "颜色",
	["Color options"] = "颜色设置",
	["Bar Color"] = "计时条颜色",
	["Sets the polymorph bar color"] = "设定变形术计时间条的颜色",
	["Backdrop Color"] = "背景颜色",
	["Sets the polymorph backdrop color"] = "设定变形术计时间条的背景颜色",
	["Size"] = "尺寸",
	["Polymorph size options"] = "设定变形术计时条的尺寸",
	["Width"] = "宽度",
	["Sets the width of the polymorph bar"] = "设定变形术计时条的宽度",
	["Height"] = "高度",
	["Sets the height of the polymorph bar"] = "设定变形术计时条的高度",
	["Position"] = "位置",
	["Adjust polymorph bar position"] = "调整变形术计时条的位置",
	["Anchor"] = "锚点",
	["Sets the anchor for the polymorph bar"] = "设定变形术计时条的锚点",
	["Anchor To"] = "固定在",
	["Sets the relative point on the health bar to anchor the polymorph bar"] = "设定变形术计时条固定在生命值显示条的位置",
	["X Offset"] = "X轴偏移",
	["X offset of the polymorph bar"] = "设定变形术计时条的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the polymorph bar"] = "设定变形术计时条的Y轴偏移量",

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

Aloft.Options.args.polymorph =
{
	type = 'group',
	name = L["Polymorph"],
	desc = L["Polymorph options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Shows polymorph timers on nameplates when possible"],
			get = function() return AloftPolymorph.db.profile.enable end,
			set = function(v) AloftPolymorph.db.profile.enable = v AloftPolymorph:UpdateAll() end,
			order = 1
		},
		speculativeAttach =
		{
			type = 'toggle',
			name = L["Speculative Attach"],
			desc = L["Attempt to attach the polymorph timer bar when it is not absolutely certain if it is the correct nameplate"],
			disabled = function() return not AloftPolymorph.db.profile.enable end,
			get = function() return AloftPolymorph.db.profile.speculativeAttach end,
			set = function(v) AloftPolymorph.db.profile.speculativeAttach = v end,
			order = 2
		},
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the polymorph bar texture"],
			disabled = function() return not AloftPolymorph.db.profile.enable end,
			get = function() return AloftPolymorph.db.profile.texture end,
			set = function(v) AloftPolymorph.db.profile.texture = v AloftPolymorph:UpdateAll() end,
			validate = SML_statusbar
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Color options"],
			disabled = function() return not AloftPolymorph.db.profile.enable end,
			args =
			{
				bar =
				{
					type = 'color',
					name = L["Bar Color"],
					desc = L["Sets the polymorph bar color"],
					get = function() return unpack(AloftPolymorph.db.profile.color) end,
					set = function(r, g, b, a) AloftPolymorph.db.profile.color = { r, g, b, a } AloftPolymorph:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the polymorph backdrop color"],
					get = function() return unpack(AloftPolymorph.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftPolymorph.db.profile.backdropColor = { r, g, b, a } AloftPolymorph:UpdateAll() end,
					hasAlpha = true,
					order = 2
				},
			},
		},
		size =
		{
			type = 'group',
			name = L["Size"],
			desc = L["Polymorph size options"],
			disabled = function() return not AloftPolymorph.db.profile.enable end,
			args =
			{
				width =
				{
					type = 'range',
					name = L["Width"],
					desc = L["Sets the width of the polymorph bar"],
					min = 5,
					max = 250,
					step = 1,
					get = function() return AloftPolymorph.db.profile.width end,
					set = function(v) AloftPolymorph.db.profile.width = v AloftPolymorph:UpdateAll() end
				},
				height =
				{
					type = 'range',
					name = L["Height"],
					desc = L["Sets the height of the polymorph bar"],
					min = 2,
					max = 32,
					step = 1,
					get = function() return AloftPolymorph.db.profile.height end,
					set = function(v) AloftPolymorph.db.profile.height = v AloftPolymorph:UpdateAll() end
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust polymorph bar position"],
			disabled = function() return not AloftPolymorph.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the polymorph bar"],
					get = function() return AloftPolymorph.db.profile.point end,
					set = function(v) AloftPolymorph.db.profile.point = v AloftPolymorph:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the polymorph bar"],
					get = function() return AloftPolymorph.db.profile.relativeToPoint end,
					set = function(v) AloftPolymorph.db.profile.relativeToPoint = v AloftPolymorph:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the polymorph bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftPolymorph.db.profile.offsetX end,
					set = function(v) AloftPolymorph.db.profile.offsetX = v AloftPolymorph:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the polymorph bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftPolymorph.db.profile.offsetY end,
					set = function(v) AloftPolymorph.db.profile.offsetY = v AloftPolymorph:UpdateAll() end
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
