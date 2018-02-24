-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("ShackleUndead") then return end
local AloftShackleUndead = Aloft:GetModule("ShackleUndead")

local L = AceLibrary("AceLocale-2.2"):new("AloftShackleUndeadOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Shackle Undead"] = true,
	["Shackle Undead options"] = true,

	["Enable"] = true,
	["Shows shackle undead timers on nameplates when possible"] = true,
	["Speculative Attach"] = true,
	["Attempt to attach the shackle undead timer bar when it is not absolutely certain if it is the correct nameplate"] = true,
	["Texture"] = true,
	["Sets the shackle undead bar texture"] = true,
	["Colors"] = true,
	["Color options"] = true,
	["Bar Color"] = true,
	["Sets the shackle undead bar color"] = true,
	["Backdrop Color"] = true,
	["Sets the shackle undead backdrop color"] = true,
	["Size"] = true,
	["Shackle Undead size options"] = true,
	["Width"] = true,
	["Sets the width of the shackle undead bar"] = true,
	["Height"] = true,
	["Sets the height of the shackle undead bar"] = true,
	["Position"] = true,
	["Adjust shackle undead bar position"] = true,
	["Anchor"] = true,
	["Sets the anchor for the shackle undead bar"] = true,
	["Anchor To"] = true,
	["Sets the relative point on the health bar to anchor the shackle undead bar"] = true,
	["X Offset"] = true,
	["X offset of the shackle undead bar"] = true,
	["Y Offset"] = true,
	["Y offset of the shackle undead bar"] = true,

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
	["Shackle Undead"] = "언데드 속박",
	["Shackle Undead options"] = "언데드 속박 설정",

	["Enable"] = "사용",
	["Shows shackle undead timers on nameplates when possible"] = "가능할 때 이름표에 언데드 속박 타이머를 표시합니다.",
	["Speculative Attach"] = "추리적인 붙이기",
	["Attempt to attach the shackle undead timer bar when it is not absolutely certain if it is the correct nameplate"] = "정확한 이름표가 확실치 않을때 언데드 속박 타이머바 붙이기를 시도합니다.",
	["Texture"] = "텍스쳐",
	["Sets the shackle undead bar texture"] = "언데드 속박 바의 텍스쳐를 설정합니다.",
	["Colors"] = "색상",
	["Color options"] = "색상 설정",
	["Bar Color"] = "바 색상",
	["Sets the shackle undead bar color"] = "언데드 속박 바의 색상을 설정합니다.",
	["Backdrop Color"] = "배경 색상",
	["Sets the shackle undead backdrop color"] = "언데드 속박의 배경 색상을 설정합니다.",
	["Size"] = "크기",
	["Shackle Undead size options"] = "언데드 속박 크기 설정",
	["Width"] = "너비",
	["Sets the width of the shackle undead bar"] = "언데드 속박 바의 너비를 설정합니다.",
	["Height"] = "높이",
	["Sets the height of the shackle undead bar"] = "언데드 속박 바의 높이를 설정합니다.",
	["Position"] = "위치",
	["Adjust shackle undead bar position"] = "언데드 속박 바의 위치를 조절합니다.",
	["Anchor"] = "앵커",
	["Sets the anchor for the shackle undead bar"] = "언데드 속박 바의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치",
	["Sets the relative point on the health bar to anchor the shackle undead bar"] = "생명력 바에서 언데드 속박 바의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the shackle undead bar"] = "언데드 속박 바의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the shackle undead bar"] = "언데드 속박 바의 Y 좌표 입니다.",

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
	["Shackle Undead"] = "束縛不死生物條",
	["Shackle Undead options"] = "束縛不死生物條選項",

	["Enable"] = "啟用",
	["Shows shackle undead timers on nameplates when possible"] = "當可能時在名牌顯示束縛不死生物計時",
	["Speculative Attach"] = "推理依附",
	["Attempt to attach the shackle undead timer bar when it is not absolutely certain if it is the correct nameplate"] = "根據推理依附束縛不死生物條在不肯定正確的名牌",
	["Texture"] = "紋理",
	["Sets the shackle undead bar texture"] = "束縛不死生物條紋理",
	["Colors"] = "顏色",
	["Color options"] = "顏色選項",
	["Bar Color"] = "束縛不死生物條顏色",
	["Sets the shackle undead bar color"] = "束縛不死生物條顏色",
	["Backdrop Color"] = "背景顏色",
	["Sets the shackle undead backdrop color"] = "束縛不死生物條背景顏色",
	["Size"] = "大小",
	["Shackle Undead size options"] = "束縛不死生物條大小",
	["Width"] = "寬度",
	["Sets the width of the shackle undead bar"] = "束縛不死生物條寬度",
	["Height"] = "高度",
	["Sets the height of the shackle undead bar"] = "束縛不死生物條高度",
	["Position"] = "位置",
	["Adjust shackle undead bar position"] = "束縛不死生物條位置",
	["Anchor"] = "定位點",
	["Sets the anchor for the shackle undead bar"] = "束縛不死生物條定位點",
	["Anchor To"] = "固定在",
	["Sets the relative point on the health bar to anchor the shackle undead bar"] = "束縛不死生物條固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the shackle undead bar"] = "束縛不死生物條X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the shackle undead bar"] = "束縛不死生物條Y位移",

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
	["Shackle Undead"] = "束缚亡灵计时条",
	["Shackle Undead options"] = "束缚亡灵计时条相关设置",

	["Enable"] = "启用",
	["Shows shackle undead timers on nameplates when possible"] = "可能时，在姓名板上显示束缚亡灵计时条",
	["Speculative Attach"] = "推理依附",
	["Attempt to attach the shackle undead timer bar when it is not absolutely certain if it is the correct nameplate"] = "在不确定依附对象为正确的姓名板时，仍然尝试根据推理依附变形术计时条",
	["Texture"] = "材质",
	["Sets the shackle undead bar texture"] = "设定束缚亡灵计时条的材质",
	["Colors"] = "颜色",
	["Color options"] = "颜色设置",
	["Bar Color"] = "计时条颜色",
	["Sets the shackle undead bar color"] = "设定束缚亡灵计时条的颜色",
	["Backdrop Color"] = "背景颜色",
	["Sets the shackle undead backdrop color"] = "设定束缚亡灵计时条的背景颜色",
	["Size"] = "尺寸",
	["Shackle Undead size options"] = "束缚亡灵计时条的尺寸设置",
	["Width"] = "宽度",
	["Sets the width of the shackle undead bar"] = "设定束缚亡灵计时条的宽度",
	["Height"] = "高度",
	["Sets the height of the shackle undead bar"] = "设定束缚亡灵计时条的高度",
	["Position"] = "位置",
	["Adjust shackle undead bar position"] = "调整束缚亡灵计时条的位置",
	["Anchor"] = "锚点",
	["Sets the anchor for the shackle undead bar"] = "设定束缚亡灵计时条的锚点",
	["Anchor To"] = "固定在",
	["Sets the relative point on the health bar to anchor the shackle undead bar"] = "设定束缚亡灵计时条固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the shackle undead bar"] = "设定束缚亡灵计时条的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the shackle undead bar"] = "设定束缚亡灵计时条的Y轴偏移量",

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

Aloft.Options.args.shackleUndead =
{
	type = 'group',
	name = L["Shackle Undead"],
	desc = L["Shackle Undead options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Shows shackle undead timers on nameplates when possible"],
			get = function() return AloftShackleUndead.db.profile.enable end,
			set = function(v) AloftShackleUndead.db.profile.enable = v AloftShackleUndead:UpdateAll() end,
			order = 1
		},
		speculativeAttach =
		{
			type = 'toggle',
			name = L["Speculative Attach"],
			desc = L["Attempt to attach the shackle undead timer bar when it is not absolutely certain if it is the correct nameplate"],
			disabled = function() return not AloftShackleUndead.db.profile.enable end,
			get = function() return AloftShackleUndead.db.profile.speculativeAttach end,
			set = function(v) AloftShackleUndead.db.profile.speculativeAttach = v end,
			order = 2
		},
		texture =
		{
			type = "text", 
			name = L["Texture"], 
			desc = L["Sets the shackle undead bar texture"],
			disabled = function() return not AloftShackleUndead.db.profile.enable end,
			get = function() return AloftShackleUndead.db.profile.texture end,
			set = function(v) AloftShackleUndead.db.profile.texture = v AloftShackleUndead:UpdateAll() end,
			validate = SML_statusbar
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Color options"],
			disabled = function() return not AloftShackleUndead.db.profile.enable end,
			args =
			{
				bar =
				{
					type = 'color',
					name = L["Bar Color"],
					desc = L["Sets the shackle undead bar color"],
					get = function() return unpack(AloftShackleUndead.db.profile.color) end,
					set = function(r, g, b, a) AloftShackleUndead.db.profile.color = { r, g, b, a } AloftShackleUndead:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the shackle undead backdrop color"],
					get = function() return unpack(AloftShackleUndead.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftShackleUndead.db.profile.backdropColor = { r, g, b, a } AloftShackleUndead:UpdateAll() end,
					hasAlpha = true,
					order = 2
				},
			},
		},
		size =
		{
			type = 'group',
			name = L["Size"],
			desc = L["Shackle Undead size options"],
			disabled = function() return not AloftShackleUndead.db.profile.enable end,
			args =
			{
				width =
				{
					type = 'range',
					name = L["Width"],
					desc = L["Sets the width of the shackle undead bar"],
					min = 5,
					max = 250,
					step = 1,
					get = function() return AloftShackleUndead.db.profile.width end,
					set = function(v) AloftShackleUndead.db.profile.width = v AloftShackleUndead:UpdateAll() end
				},
				height =
				{
					type = 'range',
					name = L["Height"],
					desc = L["Sets the height of the shackle undead bar"],
					min = 2,
					max = 32,
					step = 1,
					get = function() return AloftShackleUndead.db.profile.height end,
					set = function(v) AloftShackleUndead.db.profile.height = v AloftShackleUndead:UpdateAll() end
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust shackle undead bar position"],
			disabled = function() return not AloftShackleUndead.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the shackle undead bar"],
					get = function() return AloftShackleUndead.db.profile.point end,
					set = function(v) AloftShackleUndead.db.profile.point = v AloftShackleUndead:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the shackle undead bar"],
					get = function() return AloftShackleUndead.db.profile.relativeToPoint end,
					set = function(v) AloftShackleUndead.db.profile.relativeToPoint = v AloftShackleUndead:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the shackle undead bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftShackleUndead.db.profile.offsetX end,
					set = function(v) AloftShackleUndead.db.profile.offsetX = v AloftShackleUndead:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the shackle undead bar"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftShackleUndead.db.profile.offsetY end,
					set = function(v) AloftShackleUndead.db.profile.offsetY = v AloftShackleUndead:UpdateAll() end
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
