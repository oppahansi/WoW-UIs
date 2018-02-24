-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("SpellIcon") then return end
local AloftSpellIcon = Aloft:GetModule("SpellIcon")
local SML = AceLibrary("SharedMedia-1.0")
local L = AceLibrary("AceLocale-2.2"):new("AloftSpellIconOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Spell Icon"] = true,
	["Spell icon placement options"] = true,
	["Enable"] = true,
	["Enable spell icon display on the nameplate"] = true,
	["Position"] = true,
	["Adjust spell icon position"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the spell icon"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the cast bar to anchor the spell icon"] = true,
	["Size"] = true,
	["Size in pixels of the spell icon"] = true,
	["X Offset"] = true,
	["X offset of the spell icon"] = true,
	["Y Offset"] = true,
	["Y offset of the spell icon"] = true,

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
	["Spell Icon"] = "주문 아이콘",
	["Spell icon placement options"] = "주문 아이콘 배치 설정",
	["Enable"] = "사용",
	["Enable spell icon display on the nameplate"] = "이름표에 주문 아이콘을 표시합니다.",
	["Position"] = "위치",
	["Adjust spell icon position"] = "주문 아이콘 위치 조절",
	["Anchor"] = "앵커", 
	["Sets the anchor for the spell icon"] = "주문 아이콘의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the cast bar to anchor the spell icon"] = "시전 바에서 주문 아이콘의 앵커 위치를 설정합니다.",
	["Size"] = "크기",
	["Size in pixels of the spell icon"] = "주문 아이콘의 크기입니다.",
	["X Offset"] = "X 좌표",
	["X offset of the spell icon"] = "주문 아이콘의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the spell icon"] = "주문 아이콘의 Y 좌표 입니다.",

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
	["Spell Icon"] = "法術圖示",
	["Spell icon placement options"] = "法術圖示佈局選項",
	["Enable"] = "啟用",
	["Enable spell icon display on the nameplate"] = "在名牌顯示法術圖示",
	["Position"] = "位置",
	["Adjust spell icon position"] = "法術圖示位置",
	["Anchor"] = "定位點", 
	["Sets the anchor for the spell icon"] = "法術圖示定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the cast bar to anchor the spell icon"] = "法術圖示固定在生命力條的位置",
	["Size"] = "大小",
	["Size in pixels of the spell icon"] = "法術圖示大小",
	["X Offset"] = "X位移",
	["X offset of the spell icon"] = "法術圖示X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the spell icon"] = "法術圖示Y位移",

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
	["Spell Icon"] = "法术图标",
	["Spell icon placement options"] = "法术图标相关设置",
	["Enable"] = "启用",
	["Enable spell icon display on the nameplate"] = "在姓名板上显示法术图标",
	["Position"] = "位置",
	["Adjust spell icon position"] = "法术图标位置",
	["Anchor"] = "锚点", 
	["Sets the anchor for the spell icon"] = "设定法术图标的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the cast bar to anchor the spell icon"] = "设定法术图标固定在生命值显示条的相对位置",
	["Size"] = "尺寸",
	["Size in pixels of the spell icon"] = "以像素定义的法术图标尺寸",
	["X Offset"] = "X轴偏移",
	["X offset of the spell icon"] = "法术图标的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the spell icon"] = "法术图标的Y轴偏移量",

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

Aloft.Options.args.castBar.args.spellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Spell icon placement options"],
	disabled = function() return not Aloft:IsActive() or GetCVar("ShowVKeyCastbar") ~= "1" end,
	order = -1,
	args =
	{
		enable = 
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable spell icon display on the nameplate"],
			get = function() return AloftSpellIcon.db.profile.enable end,
			set = function(v) AloftSpellIcon.db.profile.enable = v AloftSpellIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell icon position"],
			disabled = function() return not AloftSpellIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the spell icon"],
					get = function() return AloftSpellIcon.db.profile.point end,
					set = function(v) AloftSpellIcon.db.profile.point = v AloftSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the cast bar to anchor the spell icon"],
					get = function() return AloftSpellIcon.db.profile.relativeToPoint end,
					set = function(v) AloftSpellIcon.db.profile.relativeToPoint = v AloftSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellIcon.db.profile.offsetX end,
					set = function(v) AloftSpellIcon.db.profile.offsetX = v AloftSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellIcon.db.profile.offsetY end,
					set = function(v) AloftSpellIcon.db.profile.offsetY = v AloftSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function() return not AloftSpellIcon.db.profile.enable end,
			get = function() return AloftSpellIcon.db.profile.size end,
			set = function(v) AloftSpellIcon.db.profile.size = v AloftSpellIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------
