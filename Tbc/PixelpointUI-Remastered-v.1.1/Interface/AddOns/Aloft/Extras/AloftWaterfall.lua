---------------------------------------------------------------------------------

if not AceLibrary:HasInstance("Waterfall-1.0") then return end

---------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftWaterfall")
local waterfall = AceLibrary("Waterfall-1.0")
local dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")

---------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["GUI Configuration"] = true,
	["Opens the Waterfall GUI configuration menu"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["GUI Configuration"] = "GUI 환경설정",
	["Opens the Waterfall GUI configuration menu"] = "Waterfall GUI 환경설정 메뉴를 엽니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["GUI Configuration"] = "圖形用戶介面設定",
	["Opens the Waterfall GUI configuration menu"] = "打開 Waterfall 圖形用戶介面設定選單",
} end)

L:RegisterTranslations("zhCN", function() return {
	["GUI Configuration"] = "图形用户设置界面",
	["Opens the Waterfall GUI configuration menu"] = "打开Waterfall图形用户设置介面的菜单",
} end)

---------------------------------------------------------------------------------

Aloft.Options.args.waterfall = 
{
	type = "execute",
	name = L["GUI Configuration"],
	desc = L["Opens the Waterfall GUI configuration menu"],
	order = 400,
	func = function() Aloft:LoadOptions() waterfall:Open("Aloft") if dewdrop then dewdrop:Close() end end,
	disabled = function() return waterfall:IsOpen("Aloft") end,
	guiHidden = true,
}

---------------------------------------------------------------------------------

local AloftWaterfall = AceLibrary("AceAddon-2.0"):new()

function AloftWaterfall:OnInitialize()
	waterfall:Register("Aloft",
					   "aceOptions", Aloft.Options,
					   "treeType","TREE",
					   "colorR", 0.26, "colorG", 0.41, "colorB", 0.57
					   )
end

---------------------------------------------------------------------------------
