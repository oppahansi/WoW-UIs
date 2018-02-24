-----------------------------------------------------------------------------

if not AceLibrary:HasInstance("FuBarPlugin-2.0") then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftFu")

L:RegisterTranslations("enUS", function() return {
	["Aloft"] = true,
    ["Fubar Options"] = true,
    ["Standard FuBar options"] = true,
	["Click to toggle nameplates."] = "|cffeda55fClick|r to toggle nameplates. ",
	["Shift-Click to open configuration."] = "|cffeda55fShift-Click|r to open configuration. ",

	["Hostile Nameplates"] = true,
	["Friendly Nameplates"] = true,
	["Enabled"] = "|cff00ff00Enabled|r",
	["Disabled"] = "|cffff0000Disabled|r",
} end)

L:RegisterTranslations("koKR", function() return {
	["Aloft"] = "Aloft",
	["Fubar Options"] = "Fubar 설정",
	["Standard FuBar options"] = "기본 FuBar 설정입니다.",
	["Click to toggle nameplates."] = "이름표를 전환하려면 |cffeda55f클릭|r하세요.",
	["Shift-Click to open configuration."] = "환경 설정을 열려면 |cffeda55fSHIFT-클릭|r하세요.",

	["Hostile Nameplates"] = "적대적 이름표",
	["Friendly Nameplates"] = "우호적 이름표",
	["Enabled"] = "|cff00ff00사용|r",
	["Disabled"] = "|cffff0000미사용|r",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Aloft"] = "Aloft",
    ["Fubar Options"] = "Fubar 選項",
    ["Standard FuBar options"] = "標準 Fubar 選項",
	["Click to toggle nameplates."] = "|cffeda55f左擊: |r切換名牌。",
	["Shift-Click to open configuration."] = "|cffeda55fShift-左擊: |r打開設定。",

	["Hostile Nameplates"] = "敵對名牌",
	["Friendly Nameplates"] = "友好名牌",
	["Enabled"] = "|cff00ff00已啟用|r",
	["Disabled"] = "|cffff0000已停用|r",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Aloft"] = "Aloft",
    ["Fubar Options"] = "Fubar设置",
    ["Standard FuBar options"] = "标准Fubar设置",
	["Click to toggle nameplates."] = "|cffeda55f点击: |r开启或关闭姓名板",
	["Shift-Click to open configuration."] = "|cffeda55fShift+点击: |r打开设置窗口",

	["Hostile Nameplates"] = "敌对方单位姓名板",
	["Friendly Nameplates"] = "友好方单位姓名板",
	["Enabled"] = "|cff00ff00已启用|r",
	["Disabled"] = "|cffff0000已停用|r",
} end)

-----------------------------------------------------------------------------

local AloftFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceDB-2.0")
AloftFu:RegisterDB("AloftFuDB")
AloftFu.title = "Aloft"
AloftFu.name = "FuBar - Aloft"
AloftFu.hasIcon = "Interface\\Icons\\Spell_Frost_Wisp"	-- Placeholder
AloftFu.blizzardTooltip = true
AloftFu.defaultPosition = 'LEFT'
AloftFu.hideWithoutStandby = true
AloftFu.independentProfile = true
AloftFu.hasNoColor = true
 
-----------------------------------------------------------------------------

AloftFu.OnMenuRequest = Aloft.Options

local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(AloftFu)
if not AloftFu.OnMenuRequest.args.fubar then
	AloftFu.OnMenuRequest.args.extrasSpacer =
	{
		type = 'header',
		order = 900,
	}
	
	AloftFu.OnMenuRequest.args.fubar = 
	{
		type = "group",
		name = L["Fubar Options"],
		desc = L["Standard FuBar options"],
		args = args,
		order = 1000,
	}
end

-----------------------------------------------------------------------------

function AloftFu:OnTextUpdate()
	self:SetText(L["Aloft"])
end

function AloftFu:OnTooltipUpdate()
	GameTooltip:AddLine(L["Aloft"])
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(L["Hostile Nameplates"]..": ", NAMEPLATES_ON and L["Enabled"] or L["Disabled"])
	GameTooltip:AddDoubleLine(L["Friendly Nameplates"]..": ", FRIENDNAMEPLATES_ON and L["Enabled"] or L["Disabled"])
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(L["Click to toggle nameplates."], 0.2, 1, 0.2)
	if Aloft.Options.args.waterfall then
		GameTooltip:AddLine(L["Shift-Click to open configuration."], 0.2, 1, 0.2)
	end
end

function AloftFu:OnClick()
	if Aloft.Options.args.waterfall and IsShiftKeyDown() then
		GameTooltip:Hide()
		Aloft.Options.args.waterfall.func()
		return
	end

	if NAMEPLATES_ON then
		HideNameplates()
		NAMEPLATES_ON = false
	else
		ShowNameplates()
		NAMEPLATES_ON = true
	end
	
	self:UpdateTooltip()
end

-----------------------------------------------------------------------------
