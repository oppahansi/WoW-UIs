-- $Id: TinyTipExtrasLocale_zhCN.lua 15089 2006-10-24 17:02:37Z damjau $
--[[ TinyTip by Thrae
-- 
-- Chinese Localization
-- Any wrong words, change them here.
-- 
-- TinyTipExtrasLocale should be defined in your FIRST included
-- localization file.
--
-- Contributors:
--]]

TinyTipExtrasLocale = GetLocale()

if TinyTipExtrasLocale and TinyTipExtrasLocale == "zhCN" then
	-- TinyTipTargets
	TinyTipTargetsLocale_Targeting		= "当前目标"
	TinyTipTargetsLocale_YOU			= ">>你<<"
	TinyTipTargetsLocale_TargetedBy	= "关注"

	TinyTipTargetsLocale_Unknown	= "Unknown"

	-- TinyTipExtras core
	TinyTipExtrasLocale_Buffs = "增益"
	TinyTipExtrasLocale_DispellableDebuffs = "可驱散"
	TinyTipExtrasLocale_DebuffMap = {
		["Magic"] = "|cFF5555FF魔法|r",
		["Poison"] = "|cFFFF5555中毒|r",
		["Curse"] = "|cFFFF22FF诅咒|r",
		["Disease"] = "|cFF555555疾病|r" }

	TinyTipExtrasLocale = nil -- we no longer need this
end
