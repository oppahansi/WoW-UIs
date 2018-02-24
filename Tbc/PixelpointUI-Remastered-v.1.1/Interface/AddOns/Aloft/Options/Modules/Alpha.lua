-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("Alpha") then return end
local AloftAlpha = Aloft:GetModule("Alpha")
local L = AceLibrary("AceLocale-2.2"):new("AloftAlphaOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Alpha"] = true,
	["Various Alpha Options"] = true,

	["Target Enable"] = true,
	["Enable changing alpha of target"] = true,

	["Target Alpha"] = true,
	["Sets the alpha of the target's nameplate"] = true,

	["Non-Target Enable"] = true,
	["Enable changing alpha of non-target"] = true,

	["Non-Target Alpha"] = true,
	["Sets the alpha of non-target nameplates"] = true,

	["Default Enable"] = true,
	["Enable changing alpha of default nameplates"] = true,

	["Default Alpha"] = true,
	["Sets the alpha of default nameplates"] = true,

} end)

L:RegisterTranslations("zhTW", function() return {
	["Alpha"] = "透明度",
	["Various Alpha Options"] = "透明度選項",

	["Target Enable"] = "目標啟用",
	["Enable changing alpha of target"] = "啟用改變目標名牌的透明度",

	["Target Alpha"] = "目標透明度",
	["Sets the alpha of the target's nameplate"] = "設定目標名牌的透明度",

	["Non-Target Enable"] = "非目標啟用",
	["Enable changing alpha of non-target"] = "啟用改變非目標名牌的透明度",

	["Non-Target Alpha"] = "非目標透明度",
	["Sets the alpha of non-target nameplates"] = "設定非目標名牌的透明度",

	["Default Enable"] = "預設啟用",
	["Enable changing alpha of default nameplates"] = "啟用改變預設名牌的透明度",

	["Default Alpha"] = "預設透明度",
	["Sets the alpha of default nameplates"] = "設定預設名牌的透明度",

} end)

L:RegisterTranslations("zhCN", function() return {
	["Alpha"] = "透明度",
	["Various Alpha Options"] = "透明度相关设置",

	["Target Enable"] = "对目标启用",
	["Enable changing alpha of target"] = "启用目标姓名板的透明度改变",

	["Target Alpha"] = "目标透明度",
	["Sets the alpha of the target's nameplate"] = "设定目标姓名板的透明度",

	["Non-Target Enable"] = "对非目标启用",
	["Enable changing alpha of non-target"] = "启用非目标姓名板的透明度改变",

	["Non-Target Alpha"] = "非目标透明度",
	["Sets the alpha of non-target nameplates"] = "设定非目标姓名板的透明度",

	["Default Enable"] = "对默认启用",
	["Enable changing alpha of default nameplates"] = "启用默认姓名板的透明度改变",

	["Default Alpha"] = "默认透明度",
	["Sets the alpha of default nameplates"] = "设定默认姓名板的透明度",

} end)

L:RegisterTranslations("koKR", function() return {
	["Alpha"] = "투명도",
	["Various Alpha Options"] = "각각의 투명도 설정입니다.",

	["Target Enable"] = "대상 사용",
	["Enable changing alpha of target"] = "대상의 투명도를 변경합니다.",

	["Target Alpha"] = "대상 투명도",
	["Sets the alpha of the target's nameplate"] = "대상의 이름표의 투명도를 설정합니다.",

	["Non-Target Enable"] = "비-대상 사용",
	["Enable changing alpha of non-target"] = "비-대상의 투명도를 변경합니다.",

	["Non-Target Alpha"] = "비-대상 투명도",
	["Sets the alpha of non-target nameplates"] = "비-대상 이름표의 투명도를 설정합니다.",

	["Default Enable"] = "기본 사용",
	["Enable changing alpha of default nameplates"] = "기본 이름표의 투명도를 변경합니다.",

	["Default Alpha"] = "기본 투명도",
	["Sets the alpha of default nameplates"] = "기본 이름표의 투명도를 설정합니다.",

} end)

-----------------------------------------------------------------------------

Aloft.Options.args.AloftAlpha =
{
	type = 'group',
	name = L["Alpha"],
	desc = L["Various Alpha Options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		targetEnable =
		{
			type = 'toggle',
			name = L["Target Enable"],
			desc = L["Enable changing alpha of target"],
			get = function() return AloftAlpha.db.profile.targetEnable end,
			set = function(v) AloftAlpha.db.profile.targetEnable = v AloftAlpha:EnableChange() end,
			order = 1
		},
		targetAlpha =
		{
			type = 'range',
			name = L["Target Alpha"],
			desc = L["Sets the alpha of the target's nameplate"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftAlpha.db.profile.targetEnable end,
			get = function() return AloftAlpha.db.profile.targetAlpha end,
			set = function(v) AloftAlpha.db.profile.targetAlpha = v end,
			order = 2,
		},
		nonTargetEnable =
		{
			type = 'toggle',
			name = L["Non-Target Enable"],
			desc = L["Enable changing alpha of non-target"],
			get = function() return AloftAlpha.db.profile.nonTargetEnable end,
			set = function(v) AloftAlpha.db.profile.nonTargetEnable = v AloftAlpha:EnableChange() end,
			order = 3,
		},
		nonTargetAlpha =
		{
			type = 'range',
			name = L["Non-Target Alpha"],
			desc = L["Sets the alpha of non-target nameplates"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftAlpha.db.profile.nonTargetEnable end,
			get = function() return AloftAlpha.db.profile.nonTargetAlpha end,
			set = function(v) AloftAlpha.db.profile.nonTargetAlpha = v end,
			order = 4,
		},
		defaultEnable =
		{
			type = 'toggle',
			name = L["Default Enable"],
			desc = L["Enable changing alpha of default nameplates"],
			get = function() return AloftAlpha.db.profile.defaultEnable end,
			set = function(v) AloftAlpha.db.profile.defaultEnable = v AloftAlpha:EnableChange() end,
			order = 5,
		},
		defaultAlpha =
		{
			type = 'range',
			name = L["Default Alpha"],
			desc = L["Sets the alpha of default nameplates"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftAlpha.db.profile.defaultEnable end,
			get = function() return AloftAlpha.db.profile.defaultAlpha end,
			set = function(v) AloftAlpha.db.profile.defaultAlpha = v end,
			order = 6,
		},
	},
}
