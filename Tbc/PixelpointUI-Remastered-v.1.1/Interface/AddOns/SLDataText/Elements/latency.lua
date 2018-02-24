--[[ 		    SLDataText Module: Latency 				]]
--[[ Author: Taffu  RevDate: 01/16/2012  Version: 5.0.0 ]]

local SLDT, MODNAME = SLDataText, "Latency"
if ( SLDT ) then SLDT.Latency = CreateFrame("Frame") end
--local L = SLDT.Locale
local db, frame, text, tool

local bandIn, bandOut, lagHome, lagWorld
local function SetupToolTip()
	tool:SetScript("OnEnter", function(this)
		GameTooltip:SetOwner(this, db.aF)
		GameTooltip:AddLine("|cffffffff".."Latency".."|r")
		GameTooltip:AddDoubleLine("Bandwidth In", string.format("%.2fkb", bandIn), 1,1,0,1,1,1)
		GameTooltip:AddDoubleLine("Bandwidth Out", string.format("%.2fkb", bandOut), 1,1,0,1,1,1)
		GameTooltip:AddDoubleLine("Latency (Home)", string.format("%ims", lagHome), 1,1,0,1,1,1)
		--GameTooltip:AddDoubleLine("Latency (World)", string.format("%ims", lagWorld), 1,1,0,1,1,1)
		GameTooltip:Show()
	end)
	tool:SetScript("OnLeave", function(this) if ( GameTooltip:IsShown() ) then GameTooltip:Hide() end end)
end

function SLDT.Latency:Enable()
	if ( db.enabled ) then
		SLDT:UpdateBaseText(self, db)
		local int = db.interval
		frame:SetScript("OnUpdate", function(_, elapsed)
			int = int - elapsed
			if ( int <= 0 ) then self:Refresh(); int = db.interval end
		end)
	end
	self:Refresh()
end

function SLDT.Latency:Disable()
	if ( not db.enabled ) then
		frame:SetScript("OnUpdate", nil)
	end
	self:Refresh()
end

local tags = {
	["L"] = function()
		bandIn, bandOut, lagHome, lagWorld = GetNetStats()
		return string.format("|cffffffff%i|r|cff%s", lagHome, SLDT.db.profile.cCol and SLDT.classColor or "ffffff")
	end,
}

function SLDT.Latency:Refresh()
	if ( db.enabled or SLDataText.db.profile.configMode ) then
		if ( not self.firstRun ) then self.firstRun = true; SLDT:UpdateBaseText(self, db) end
		
		local str = db.textDisplay
		str = string.gsub(str, "%[(%w+)%]", function(w) return tags[w]() end)
		text:SetFormattedText("|cff%s%s|r", SLDT.db.profile.cCol and SLDT.classColor or "ffffff", str)
		
		SLDT:UpdateBaseFrame(self, db)
	else
		if ( frame:IsShown() and not SLDataText.db.profile.configMode ) then frame:Hide() end
	end
end

SLDT.Latency.optsTbl = {
	[1] = { [1] = "toggle", [2] = "Enabled", [3] = "enabled" },
	[2] = { [1] = "toggle", [2] = "Global Font", [3] = "gfont" },
	[3] = { [1] = "toggle", [2] = "Outline", [3] = "outline" },
	[4] = { [1] = "toggle", [2] = "Force Shown", [3] = "forceShow" },
	[5] = { [1] = "toggle", [2] = "Tooltip On", [3] = "tooltipOn" },
	[6] = { [1] = "text", [2] = "Text Display", [3] = "textDisplay" },
	[7] = { [1] = "desc", [2] = "LagTextDesc", [3] = "LagTextDesc" },
	[8] = { [1] = "range", [2] = "Update Interval", [3] = "interval", [4] = 10, [5] = 1000, [6] = 10 },
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
	SLDT.Latency.db = SLDT.db:RegisterNamespace(MODNAME)
    SLDT.Latency.db:RegisterDefaults({
        profile = {
			name = "Latency",
			enabled = true,
			forceShow = false,
			aP = "CENTER",
			anch = "UIParent",
			aF = "BOTTOMLEFT",
			xOff = 107,
			yOff = 177,
			strata = "LOW",
			gfont = false,
			fontSize = 12,
			font = "Arial Narrow",
			outline = false,
			interval = 10,
			tooltipOn = true,
			textDisplay = "[L]ms",
        },
    })
	db = SLDT.Latency.db.profile
	
	SLDT.Modules = SLDT.Modules or {}
	if ( not SLDT.Modules[MODNAME] ) then table.insert(SLDT.Modules, { MODNAME, db }) end
	frame, text, tool = SLDT:SetupBaseFrame(SLDT.Latency)
	SetupToolTip()
	
	SLDT.Latency:UnregisterEvent("PLAYER_ENTERING_WORLD")
	SLDT.Latency:Enable()
end

SLDT.Latency:RegisterEvent("PLAYER_ENTERING_WORLD")
SLDT.Latency:SetScript("OnEvent", OnInit)