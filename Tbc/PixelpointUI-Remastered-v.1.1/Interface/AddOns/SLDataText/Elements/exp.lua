--[[ 		     SLDataText Module: Exp 				]]
--[[ Author: Taffu  RevDate: 01/16/2012  Version: 5.0.0 ]]

local SLDT, MODNAME = SLDataText, "Exp"
if ( SLDT ) then SLDT.Exp = CreateFrame("Frame") end
--local L = SLDT.Locale
local db, frame, text, tool
--[[
local function getXPStr(typ)
	local curXP, maxXP, resXP, str, classColor = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion(), nil, SLDT.db.profile.cCol and SLDT.classColor or "ffffff"
	if ( typ == "cur" ) then if ( maxXP > 999 ) then str = string.format("%i|cff%sk|r", curXP/1000, classColor) else str = string.format("%i", curXP) end end
	if ( typ == "max" ) then if ( maxXP > 999 ) then str = string.format("%i|cff%sk|r", maxXP/1000, classColor) else str = string.format("%i", maxXP) end end
	if ( typ == "rem" ) then if ( maxXP > 999 ) then str = string.format("%i|cff%sk|r", (maxXP-curXP)/1000, classColor) else str = string.format("%i", maxXP-curXP) end end
	if ( typ == "per" ) then str = string.format("|cff%s(|r%.0f%%|cff%s)|r", classColor, curXP*(100/maxXP), classColor) end
	if ( typ == "perR" ) then str = string.format("|cff%s(|r%.0f%%|cff%s)|r", classColor, 100-(curXP*(100/maxXP)), classColor) end
	if ( typ == "rest" ) then if ( resXP > 999 ) then str = string.format("%i%sk|r", resXP/1000, classColor) else str = string.format("%i", resXP) end end
	if ( typ == "rper" ) then str = string.format(" |cff%s[|r%.0f%%|cff%s]|r", classColor, resXP*(100/maxXP), classColor) end
	if ( typ == nil ) then str = "No xp data" end
	return str
end
]]
local tags = {
	["Cur"] = function()
		local curXP = UnitXP("player")
		if ( curXP > 999 ) then
			return string.format("|cffffffff%.0fk|r|cff%s", curXP / 1000, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		else
			return string.format("|cffffffff%.0f|r|cff%s", curXP, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		end
	end,
	["Max"] = function()
		local maxXP = UnitXPMax("player")
		if ( maxXP > 999 ) then
			return string.format("|cffffffff%.0fk|r|cff%s", maxXP / 1000, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		else
			return string.format("|cffffffff%.0f|r|cff%s", maxXP, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		end
	end,
	["Rem"] = function()
		local remXP = UnitXPMax("player") - UnitXP("player")
		if ( remXP > 999 ) then
			return string.format("|cffffffff%.0fk|r|cff%s", remXP / 1000, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		else
			return string.format("|cffffffff%.0f|r|cff%s", remXP, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		end
	end,
	["Per"] = function()
		local perXP = UnitXP("player") * (100 / UnitXPMax("player"))
		return string.format("|cffffffff%.1f|r|cff%s", perXP, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
	end,
	["PerR"] = function()
		local perRemXP = 100 - (UnitXP("player") * (100 / UnitXPMax("player")))
		return string.format("|cffffffff%.1f|r|cff%s", perRemXP, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
	end,
	["R"] = function()
		local rest = GetXPExhaustion()
		if ( rest > 999 ) then
			return string.format("|cffffffff%.0fk|r|cff%s", rest / 1000, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		else
			return string.format("|cffffffff%.0f|r|cff%s", rest, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
		end
		return string.format("|cffffffff%.0f|r|cff%s", rest, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
	end,
	["RP"] = function()
		local restPer = GetXPExhaustion() * (100 / UnitXPMax("player"))
		return string.format("|cffffffff%.1f|r|cff%s", restPer, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
	end,
}

local function SetupToolTip()
	--[[
	tool:SetScript("OnEnter", function(this)
		GameTooltip:SetOwner(this, db.aF)
		GameTooltip:AddLine("|cffffffffExperience|r")
		GameTooltip:Show()
	end)
	tool:SetScript("OnLeave", function(this) if ( GameTooltip:IsShown() ) then GameTooltip:Hide() end end)
	]]
end

function SLDT.Exp:Enable()
	if ( db.enabled ) then
		SLDT:UpdateBaseText(self, db)
		self:RegisterEvent("PLAYER_XP_UPDATE")
		self:RegisterEvent("DISABLE_XP_GAIN")
		self:RegisterEvent("ENABLE_XP_GAIN")
		self:SetScript("OnEvent", function(self, event) self:Refresh() end)
	end
	self:Refresh()
end

function SLDT.Exp:Disable()
	if ( not db.enabled ) then
		self:UnregisterEvent("PLAYER_XP_UPDATE")
		self:UnregisterEvent("DISABLE_XP_GAIN")
		self:UnregisterEvent("ENABLE_XP_GAIN")
		self:SetScript("OnEvent", nil)
	end
	self:Refresh()
end

function SLDT.Exp:Refresh()
	if ( db.enabled or SLDataText.db.profile.configMode ) then
		if ( not self.firstRun ) then self.firstRun = true; SLDT:UpdateBaseText(self, db) end
		
		if ( db.hideMaxLvl and ( UnitLevel("player") == 70 ) ) then
			text:SetText("")
		else
			local str = db.textDisplay
			str = string.gsub(str, "%[(%w+)%]", function(w) return tags[w]() end)
			text:SetFormattedText("|cff%s%s|r", SLDT.db.profile.cCol and SLDT.classColor or "ffffff", str)
		end
		
		SLDT:UpdateBaseFrame(self, db)
	else
		if ( frame:IsShown() and not SLDataText.db.profile.configMode ) then frame:Hide() end
	end
end

SLDT.Exp.optsTbl = {
	[1] = { [1] = "toggle", [2] = "Enabled", [3] = "enabled" },
	[2] = { [1] = "toggle", [2] = "Global Font", [3] = "gfont" },
	[3] = { [1] = "toggle", [2] = "Outline", [3] = "outline" },
	[4] = { [1] = "toggle", [2] = "Force Shown", [3] = "forceShow" },
	[5] = { [1] = "toggle", [2] = "Tooltip On", [3] = "tooltipOn" },
	[6] = { [1] = "toggle", [2] = "Max Level Hide", [3] = "hideMaxLvl" },
	[7] = { [1] = "text", [2] = "Text Display", [3] = "textDisplay" },
	[8] = { [1] = "desc", [2] = "ExpTextDesc", [3] = "ExpTextDesc" },
	[9] = { [1] = "range", [2] = "Font Size", [3] = "fontSize", [4] = 6, [5] = 40, [6] = 1 },
	[10] = { [1] = "select", [2] = "Font", [3] = "font", [4] = SLDT.fontTbl },
	[11] = { [1] = "select", [2] = "Justify", [3] = "aP", [4] = SLDT.justTbl },
	[12] = { [1] = "text", [2] = "Parent", [3] = "anch" },
	[13] = { [1] = "select", [2] = "Anchor", [3] = "aF", [4] = SLDT.anchTbl },
	[14] = { [1] = "text", [2] = "X Offset", [3] = "xOff" },
	[15] = { [1] = "text", [2] = "Y Offset", [3] = "yOff" },
	[16] = { [1] = "select", [2] = "Frame Strata", [3] = "strata", [4] = SLDT.stratTbl },
}

local function OnInit()
	SLDT.Exp.db = SLDT.db:RegisterNamespace(MODNAME)
    SLDT.Exp.db:RegisterDefaults({
        profile = {
			name = "Exp",
			enabled = true,
			hideMaxLvl = false,
			forceShow = false,
			aP = "CENTER",
			anch = "UIParent",
			aF = "CENTER",
			xOff = -100,
			yOff = 24,
			strata = "LOW",
			gfont = false,
			fontSize = 12,
			font = "Arial Narrow",
			outline = false,
			tooltipOn = true,
			textDisplay = "Exp [Cur]/[Max] ([Per])",
        },
    })
	db = SLDT.Exp.db.profile
	
	SLDT.Modules = SLDT.Modules or {}
	if ( not SLDT.Modules[MODNAME] ) then table.insert(SLDT.Modules, { MODNAME, db }) end
	frame, text, tool = SLDT:SetupBaseFrame(SLDT.Exp)
	SetupToolTip()
	
	SLDT.Exp:UnregisterEvent("PLAYER_ENTERING_WORLD")
	--SLDT.Exp:Enable()
end

SLDT.Exp:RegisterEvent("PLAYER_ENTERING_WORLD")
SLDT.Exp:SetScript("OnEvent", OnInit)