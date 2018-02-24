--[[ 		    SLDataText Module: Coords 				]]
--[[ Author: Taffu  RevDate: 01/16/2012  Version: 5.0.0 ]]

local SLDT, MODNAME, SML, SLC = SLDataText, "Coords", LibStub("LibSharedMedia-3.0"), LibStub("LibSL-1.0")
if ( SLDT ) then SLDT.Coords = CreateFrame("Frame") end
--local L = SLDT.Locale
local db, frame, text, tool

function SLDT.Coords:Enable()
	if ( db.enabled ) then
		SLDT:UpdateBaseText(self, db)
		local int = db.interval
		frame:SetScript("OnUpdate", function(_, elapsed)
			int = int - elapsed
			if ( int <= 0 ) then SLDT.Coords:Refresh(); int = db.interval end
		end)
	end
	self:Refresh()
end

function SLDT.Coords:Disable()
	if ( not db.enabled ) then
		frame:SetScript("OnUpdate", nil)
	end
	self:Refresh()
end

function SLDT.Coords:Refresh()
	if ( db.enabled or SLDataText.db.profile.configMode ) then
		if ( not self.firstRun ) then self.firstRun = true; SLDT:UpdateBaseText(self, db) end
		
		local posX, posY = GetPlayerMapPosition("player")
		text:SetFormattedText("%."..db.precision.."f, %."..db.precision.."f", posX*100, posY*100)
		
		SLDT:UpdateBaseFrame(SLDT.Coords, db)
	else
		if ( frame:IsShown() and not SLDataText.db.profile.configMode ) then frame:Hide() end
	end
end

SLDT.Coords.optsTbl = {
	[1] = { [1] = "toggle", [2] = "Enabled", [3] = "enabled" },
	[2] = { [1] = "toggle", [2] = "Global Font", [3] = "gfont" },
	[3] = { [1] = "toggle", [2] = "Outline", [3] = "outline" },
	[4] = { [1] = "toggle", [2] = "Force Shown", [3] = "forceShow" },
	[5] = { [1] = "range", [2] = "Precision", [3] = "precision", [4] = 0, [5] = 2, [6] = 1 },
	[6] = { [1] = "range", [2] = "Update Interval", [3] = "interval", [4] = 10, [5] = 1000, [6] = 10 },
	[7] = { [1] = "range", [2] = "Font Size", [3] = "fontSize", [4] = 6, [5] = 40, [6] = 1 },
	[8] = { [1] = "select", [2] = "Font", [3] = "font", [4] = SLDT.fontTbl },
	[9] = { [1] = "select", [2] = "Justify", [3] = "aP", [4] = SLDT.justTbl },
	[10] = { [1] = "text", [2] = "Parent", [3] = "anch" },
	[11] = { [1] = "select", [2] = "Anchor", [3] = "aF", [4] = SLDT.anchTbl },
	[12] = { [1] = "text", [2] = "X Offset", [3] = "xOff" },
	[13] = { [1] = "text", [2] = "Y Offset", [3] = "yOff" },
	[14] = { [1] = "select", [2] = "Frame Strata", [3] = "strata", [4] = SLDT.stratTbl },
}

local function OnInit()
	SLDT.Coords.db = SLDT.db:RegisterNamespace(MODNAME)
    SLDT.Coords.db:RegisterDefaults({
        profile = {
			name = "Coords",
			enabled = true,
			precision = 0,
			forceShow = true,
			aP = "CENTER",
			anch = "Minimap",
			aF = "BOTTOM",
			xOff = 0,
			yOff = 16,
			strata = "LOW",
			gfont = false,
			fontSize = 12,
			font = "Arial Narrow",
			outline = false,
			interval = 10,
			tooltipOn = false,
        },
    })
	db = SLDT.Coords.db.profile
	
	SLDT.Modules = SLDT.Modules or {}
	if ( not SLDT.Modules[MODNAME] ) then table.insert(SLDT.Modules, { MODNAME, db }) end
	frame, text, tool = SLDT:SetupBaseFrame(SLDT.Coords)
	
	SLDT.Coords:UnregisterEvent("PLAYER_ENTERING_WORLD")
	--SLDT.Coords:Enable()
end

SLDT.Coords:RegisterEvent("PLAYER_ENTERING_WORLD")
SLDT.Coords:SetScript("OnEvent", OnInit)