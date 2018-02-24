-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("RaidIcon") then return end
local AloftRaidIcon = Aloft:GetModule("RaidIcon")
local L = AceLibrary("AceLocale-2.2"):new("AloftRaidIconOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Raid Icon"] = true,
	["Raid icon placement options"] = true,
	["Enable"] = true,
	["Enable raid icon display on the nameplate"] = true,
	["Size"] = true,
	["Size in pixels of the raid icon"] = true,
	["Position"] = true,
	["Adjust raid icon position"] = true,
	["X Offset"] = true,
	["X offset of the raid icon"] = true,
	["Y Offset"] = true,
	["Y offset of the raid icon"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the raid icon"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the raid icon"] = true,
	["Alpha"] = true,
	["Sets the raid icon alpha"] = true,

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
	["Raid Icon"] = "공격대 아이콘",
	["Raid icon placement options"] = "공격대 아이콘 배치 설정",
	["Enable"] = "사용",
	["Enable raid icon display on the nameplate"] = "이름표에 공격대 아이콘을 표시합니다.",
	["Size"] = "크기",
	["Size in pixels of the raid icon"] = "공격대 아이콘의 크기입니다.",
	["Position"] = "위치",
	["Adjust raid icon position"] = "공격대 아이콘 위치 조절",
	["X Offset"] = "X 좌표",
	["X offset of the raid icon"] = "공격대 아이콘의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the raid icon"] = "공격대 아이콘의 Y 좌표 입니다.",
	["Anchor"] = "앵커", 
	["Sets the anchor for the raid icon"] = "공격대 아이콘의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the raid icon"] = "생명력 바에서 공격대 아이콘의 앵커 위치를 설정합니다.",
	["Alpha"] = "투명도",
	["Sets the raid icon alpha"] = "공격대 아이콘의 투명도를 설정합니다.",

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
	["Raid Icon"] = "團隊圖示",
	["Raid icon placement options"] = "團隊圖示佈局選項",
	["Enable"] = "啟用",
	["Enable raid icon display on the nameplate"] = "在名牌顯示團隊圖示",
	["Size"] = "大小",
	["Size in pixels of the raid icon"] = "團隊圖示大小",
	["Position"] = "位置",
	["Adjust raid icon position"] = "團隊圖示位置",
	["X Offset"] = "X位移",
	["X offset of the raid icon"] = "團隊圖示X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the raid icon"] = "團隊圖示Y位移",
	["Anchor"] = "定位點", 
	["Sets the anchor for the raid icon"] = "團隊圖示定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the raid icon"] = "團隊圖示固定在生命力條的位置",
	["Alpha"] = "透明度",
	["Sets the raid icon alpha"] = "團隊圖示透明度",

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
	["Raid Icon"] = "团队图标",
	["Raid icon placement options"] = "团队图标位置相关设置",
	["Enable"] = "启用",
	["Enable raid icon display on the nameplate"] = "在姓名板上显示团队图标",
	["Size"] = "尺寸",
	["Size in pixels of the raid icon"] = "以像素定义的团队图标尺寸",
	["Position"] = "位置",
	["Adjust raid icon position"] = "调整团队图标的位置",
	["X Offset"] = "X轴偏移",
	["X offset of the raid icon"] = "团队图标的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the raid icon"] = "团队图标的Y轴偏移量",
	["Anchor"] = "锚点", 
	["Sets the anchor for the raid icon"] = "设定团队图标的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the raid icon"] = "设定团队图标固定在生命值显示条的相对位置",
	["Alpha"] = "透明度",
	["Sets the raid icon alpha"] = "设定团队图标的透明度",

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

Aloft.Options.args.raidIcon =
{
	type = 'group',
	name = L["Raid Icon"],
	desc = L["Raid icon placement options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable = 
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable raid icon display on the nameplate"],
			get = function() return AloftRaidIcon.db.profile.enable end,
			set = function(v) AloftRaidIcon.db.profile.enable = v AloftRaidIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust raid icon position"],
			disabled = function() return not AloftRaidIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the raid icon"],
					get = function() return AloftRaidIcon.db.profile.point end,
					set = function(v) AloftRaidIcon.db.profile.point = v AloftRaidIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the raid icon"],
					get = function() return AloftRaidIcon.db.profile.relativeToPoint end,
					set = function(v) AloftRaidIcon.db.profile.relativeToPoint = v AloftRaidIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the raid icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftRaidIcon.db.profile.offsetX end,
					set = function(v) AloftRaidIcon.db.profile.offsetX = v AloftRaidIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the raid icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftRaidIcon.db.profile.offsetY end,
					set = function(v) AloftRaidIcon.db.profile.offsetY = v AloftRaidIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the raid icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function() return not AloftRaidIcon.db.profile.enable end,
			get = function() return AloftRaidIcon.db.profile.size end,
			set = function(v) AloftRaidIcon.db.profile.size = v AloftRaidIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the raid icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftRaidIcon.db.profile.enable end,
			get = function() return AloftRaidIcon.db.profile.alpha end,
			set = function(v) AloftRaidIcon.db.profile.alpha = v AloftRaidIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------
