-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("Banzai") then return end
local AloftBanzai = Aloft:GetModule("Banzai")
local L = AceLibrary("AceLocale-2.2"):new("AloftBanzaiOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Banzai"] = true,
	["Banzai options"] = true,

	["Enable"] = true,
	["Highlights group members that have aggro"] = true,
	["Color"] = true,
	["Sets the aggro color"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Banzai"] = "어그로",
	["Banzai options"] = "어그로에 대한 설정입니다.",

	["Enable"] = "사용",
	["Highlights group members that have aggro"] = "어그로를 가진 파티원을 강조합니다.",
	["Color"] = "색상",
	["Sets the aggro color"] = "어그로 색상을 설정합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Banzai"] = "Banzai",
	["Banzai options"] = "Banzai 選項",

	["Enable"] = "啟用",
	["Highlights group members that have aggro"] = "高亮變成被攻擊目標的團體成員",
	["Color"] = "顏色",
	["Sets the aggro color"] = "被攻擊目標的顏色",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Banzai"] = "Banzai",
	["Banzai options"] = "Banzai相关设置",

	["Enable"] = "启用",
	["Highlights group members that have aggro"] = "将获得仇恨的团队成员高亮显示",
	["Color"] = "颜色",
	["Sets the aggro color"] = "仇恨持有者的颜色",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.banzai =
{
	type = 'group',
	name = L["Banzai"],
	desc = L["Banzai options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Highlights group members that have aggro"],
			get = function() return AloftBanzai.db.profile.enable end,
			set = function(v) AloftBanzai.db.profile.enable = v Aloft:DetermineDataSources() AloftBanzai:UpdateAll() end,
			order = 1
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the aggro color"],
			disabled = function() return not AloftBanzai.db.profile.enable end,
			get = function() return unpack(AloftBanzai.db.profile.color) end,
			set = function(r, g, b, a) AloftBanzai.db.profile.color = { r, g, b, a } AloftBanzai:UpdateAll() end,
		},
	},
}

-----------------------------------------------------------------------------
