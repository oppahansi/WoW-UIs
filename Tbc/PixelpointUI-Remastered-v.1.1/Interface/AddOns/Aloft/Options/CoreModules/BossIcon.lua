-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("BossIcon") then return end
local AloftBossIcon = Aloft:GetModule("BossIcon")
local L = AceLibrary("AceLocale-2.2"):new("AloftBossIconOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Boss Icon"] = true,
	["Boss icon placement options"] = true,
	["Enable"] = true,
	["Enable boss icon display on the nameplate"] = true,
	["Size"] = true,
	["Size in pixels of the boss icon"] = true,
	["Position"] = true,
	["Adjust boss icon position"] = true,
	["X Offset"] = true,
	["X offset of the boss icon"] = true,
	["Y Offset"] = true,
	["Y offset of the boss icon"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the boss icon"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the boss icon"] = true,
	["Alpha"] = true,
	["Sets the boss icon alpha"] = true,	

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
	["Boss Icon"] = "보스 아이콘",
	["Boss icon placement options"] = "보스 아이콘 배치 설정",
	["Enable"] = "사용",
	["Enable boss icon display on the nameplate"] = "이름표에 보스 아이콘을 표시합니다.",
	["Size"] = "크기",
	["Size in pixels of the boss icon"] = "보스 아이콘의 크기입니다.",
	["Position"] = "위치",
	["Adjust boss icon position"] = "보스 아이콘 위치 조절",
	["X Offset"] = "X 좌표",
	["X offset of the boss icon"] = "보스 아이콘의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the boss icon"] = "보스 아이콘의 Y 좌표 입니다.",
	["Anchor"] = "앵커", 
	["Sets the anchor for the boss icon"] = "보스 아이콘의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the boss icon"] = "생명력바에서 보스 아이콘의 앵커 위치를 설정합니다.",
	["Alpha"] = "투명도",
	["Sets the boss icon alpha"] = "보스 아이콘의 투명도를 설정합니다.",	

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
	["Boss Icon"] = "首領圖示",
	["Boss icon placement options"] = "首領圖示佈局選項",
	["Enable"] = "啟用",
	["Enable boss icon display on the nameplate"] = "在名牌顯示首領圖示",
	["Size"] = "大小",
	["Size in pixels of the boss icon"] = "首領圖示大小",
	["Position"] = "位置",
	["Adjust boss icon position"] = "首領圖示位置",
	["X Offset"] = "X位移",
	["X offset of the boss icon"] = "首領圖示X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the boss icon"] = "首領圖示Y位移",
	["Anchor"] = "定位點", 
	["Sets the anchor for the boss icon"] = "首領圖示定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the boss icon"] = "首領圖示固定在生命力條的位置",
	["Alpha"] = "透明度",
	["Sets the boss icon alpha"] = "首領圖示透明度",	

    ["TOPLEFT"] = "左上",
	["TOP"] = "上",
	["TOPRIGHT"] = "右上",
	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
	["BOTTOMLEFT"] = "左下",
	["BOTTOM"] = "下",
	["BOTTOMRIGHT"] = "右下",
} end)L:RegisterTranslations("zhCN", function() return {
	["Boss Icon"] = "首领图标",
	["Boss icon placement options"] = "首领图标位置相关设置",
	["Enable"] = "启用",
	["Enable boss icon display on the nameplate"] = "在姓名板上显示首领图标",
	["Size"] = "尺寸",
	["Size in pixels of the boss icon"] = "首领图标的像素尺寸",
	["Position"] = "位置",
	["Adjust boss icon position"] = "调整首领图标的位置",
	["X Offset"] = "X轴偏移",
	["X offset of the boss icon"] = "首领图标的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the boss icon"] = "首领图标的Y轴偏移量",
	["Anchor"] = "锚点", 
	["Sets the anchor for the boss icon"] = "设定首领图标的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the boss icon"] = "设定首领图标固定在生命值显示条的相对位置",
	["Alpha"] = "透明度",
	["Sets the boss icon alpha"] = "设定首领图标的透明度",	

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

Aloft.Options.args.bossIcon =
{
	type = 'group',
	name = L["Boss Icon"],
	desc = L["Boss icon placement options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable = 
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable boss icon display on the nameplate"],
			get = function() return AloftBossIcon.db.profile.enable end,
			set = function(v) AloftBossIcon.db.profile.enable = v AloftBossIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust boss icon position"],
			disabled = function() return not AloftBossIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the boss icon"],
					get = function() return AloftBossIcon.db.profile.point end,
					set = function(v) AloftBossIcon.db.profile.point = v AloftBossIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the boss icon"],
					get = function() return AloftBossIcon.db.profile.relativeToPoint end,
					set = function(v) AloftBossIcon.db.profile.relativeToPoint = v AloftBossIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the boss icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftBossIcon.db.profile.offsetX end,
					set = function(v) AloftBossIcon.db.profile.offsetX = v AloftBossIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the boss icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftBossIcon.db.profile.offsetY end,
					set = function(v) AloftBossIcon.db.profile.offsetY = v AloftBossIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the boss icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function() return not AloftBossIcon.db.profile.enable end,
			get = function() return AloftBossIcon.db.profile.size end,
			set = function(v) AloftBossIcon.db.profile.size = v AloftBossIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the boss icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftBossIcon.db.profile.enable end,
			get = function() return AloftBossIcon.db.profile.alpha end,
			set = function(v) AloftBossIcon.db.profile.alpha = v AloftBossIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------
