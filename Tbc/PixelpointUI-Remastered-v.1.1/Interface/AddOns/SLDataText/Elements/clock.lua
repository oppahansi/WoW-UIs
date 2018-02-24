--[[ 		     SLDataText Module: Clock 				]]
--[[ Author: Taffu  RevDate: 01/16/2012  Version: 5.0.0 ]]

local SLDT, MODNAME = SLDataText, "Clock"
if ( SLDT ) then SLDT.Clock = CreateFrame("Frame") end
--local L = SLDT.Locale
local db, frame, text, tool

local rCol, gCol = RED_FONT_COLOR_CODE, GREEN_FONT_COLOR_CODE
local locTime, rlmTime
local function getGameTime()
    local serTime, serAMPM
    local hour, minu = GetGameTime()
	if ( minu < 10 ) then minu = string.format("0%i", minu) end 
    if ( db.format24 ) then
        serAMPM = ""; serTime = string.format("%s:%s", hour, minu)
    else
        if ( hour > 11 ) then serAMPM = "pm" else serAMPM = "am" end
        if ( hour == 0 ) then hour = hour + 12 elseif hour > 12 then hour = hour - 12 end
        serTime = string.format("%s:%s", hour, minu)
    end
    return serTime, serAMPM
end

local function formatTimer(wait)
	local queueTime = 900
	local h, m, s = 0, 0, 0
	if ( wait >= 3600 ) then
		h = floor(wait / 3600); wait = wait - (h * 3600)
		m = floor(wait / 60); wait = wait - (m * 60)
		s = floor(wait)
	elseif ( wait >= 60 and wait < 3600 ) then
		m = floor(wait / 60); wait = wait - (m * 60)
		s = floor(wait)
	elseif ( wait < 60 ) then
		s = floor(wait)
	end
	
	return string.format("%s%s%s", h ~= 0 and h..":" or "", m ~= 0 and m..":" or "", s ~= 0 and s or "")
end

local function SetupToolTip()
	tool:SetScript("OnEnter", function(this)
		GameTooltip:SetOwner(this, db.aF)
		GameTooltip:AddLine(string.format("|cffffffff%s %i, %i|r", date("%B"), date("%d"), date("%Y")))
		GameTooltip:AddDoubleLine("Realm Time", string.format("%s%s", select(1, getGameTime()), select(2, getGameTime())), 1,1,0,1,1,1)
		GameTooltip:AddDoubleLine("Local Time", locTime, 1,1,0,1,1,1)
		GameTooltip:AddLine(" ")
		
		--[[if ( db.showPVP ) then
			local inQueue = nil
			for i = 1, 2 do
				local id, name, active, canQ, wait, _ = GetWorldPVPAreaInfo(i)
				if ( active ) then
					name = string.format("%s%s (A)|r", rCol, name)
				elseif ( canQ ) then
					name = string.format("%s%s (Q)|r", gCol, name)
				end
				GameTooltip:AddDoubleLine(name, formatTimer(wait))
			end
			
			for j = 1, MAX_WORLD_PVP_QUEUES do
				local status, map = GetWorldPVPQueueStatus(j)
				if ( status == "queued" ) then inQueue = {}; table.insert(inQueue, map) end
			end
			
			if ( inQueue ~= nil ) then
				local maps = ""
				for k, v in pairs(inQueue) do
					maps = string.format("%s %s", maps, v)
				end
				GameTooltip:AddLine(string.format("%s %s", L["Queued for:"], maps))
			end
			
			GameTooltip:AddLine(" ")
		end]]--
		
		--GameTooltip:AddDoubleLine("Left-Click", "Toggle Calendar", 1,1,0,1,1,1)
		--GameTooltip:AddDoubleLine("Right-Click", "Toggle Time Manager", 1,1,0,1,1,1)
		--GameTooltip:Show()
	end)
	tool:SetScript("OnLeave", function(this)
		if ( GameTooltip:IsShown() ) then GameTooltip:Hide() end
	end)
	tool:SetScript("OnMouseDown", function(self, button)
		if ( button == "LeftButton" ) then 
			--ToggleCalendar()
		elseif ( button == "RightButton" ) then
			ToggleTimeManager()
		end
	end)
end

function SLDT.Clock:Enable()
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

function SLDT.Clock:Disable()
	if ( not db.enabled ) then
		frame:SetScript("OnUpdate", nil)
	end
	self:Refresh()
end

function SLDT.Clock:Refresh()
	if ( db.enabled or SLDT.db.profile.configMode ) then
		if ( not self.firstRun ) then self.firstRun = true; SLDT:UpdateBaseText(self, db) end
		

		local hr, mi = db.format24 and "%H" or "%I", "%M"
		local hour, minute, meridian = date(hr), date(mi), date("%p")
		locTime = string.format("%i:%s|cff%s%s|r", hour, minute, SLDT.db.profile.cCol and SLDT.classColor or "ffffff", not db.format24 and string.lower(meridian) or "")
		rlmTime = string.format("%s|cff%s%s|r", select(1, getGameTime()), SLDT.db.profile.cCol and SLDT.classColor or "ffffff", select(2, getGameTime()))
		text:SetText(db.realmTime and rlmTime or locTime)
		

		
		SLDT:UpdateBaseFrame(self, db)
	else

		if ( frame:IsShown() and not SLDataText.db.profile.configMode ) then frame:Hide() end
	end
end

SLDT.Clock.optsTbl = {
	[1] = { [1] = "toggle", [2] = "Enabled", [3] = "enabled" },
	[2] = { [1] = "toggle", [2] = "Global Font", [3] = "gfont" },
	[3] = { [1] = "toggle", [2] = "Outline", [3] = "outline" },
	[4] = { [1] = "toggle", [2] = "Force Shown", [3] = "forceShow" },
	[5] = { [1] = "toggle", [2] = "Tooltip On", [3] = "tooltipOn" },
	[6] = { [1] = "toggle", [2] = "Realm Time", [3] = "realmTime" },
	[7] = { [1] = "toggle", [2] = "24 Hour", [3] = "format24" },
	[8] = { [1] = "toggle", [2] = "PvP Info", [3] = "showPVP" },
	[9] = { [1] = "range", [2] = "Update Interval", [3] = "interval", [4] = 10, [5] = 1000, [6] = 10 },
	[10] = { [1] = "range", [2] = "Font Size", [3] = "fontSize", [4] = 6, [5] = 40, [6] = 1 },
	[11] = { [1] = "select", [2] = "Font", [3] = "font", [4] = SLDT.fontTbl },
	[12] = { [1] = "select", [2] = "Justify", [3] = "aP", [4] = SLDT.justTbl },
	[13] = { [1] = "text", [2] = "Parent", [3] = "anch" },
	[14] = { [1] = "select", [2] = "Anchor", [3] = "aF", [4] = SLDT.anchTbl },
	[15] = { [1] = "text", [2] = "X Offset", [3] = "xOff" },
	[16] = { [1] = "text", [2] = "Y Offset", [3] = "yOff" },
	[17] = { [1] = "select", [2] = "Frame Strata", [3] = "strata", [4] = SLDT.stratTbl },
}

local function OnInit()
	SLDT.Clock.db = SLDT.db:RegisterNamespace(MODNAME)
    SLDT.Clock.db:RegisterDefaults({
        profile = {
			name = "Clock",
			enabled = true,
			forceShow = true,
			aP = "CENTER",
			anch = "Minimap",
			aF = "BOTTOM",
			xOff = 0,
			yOff = -10,
			strata = "MEDIUM",
			gfont = false,
			realmTime = false,
			format24 = false,
			fontSize = 12,
			font = "Arial Narrow",
			outline = false,
			interval = 10,
			tooltipOn = true,
			showPVP = true,
        },
    })
	db = SLDT.Clock.db.profile
	
	SLDT.Modules = SLDT.Modules or {}
	if ( not SLDT.Modules[MODNAME] ) then table.insert(SLDT.Modules, { MODNAME, db }) end
	frame, text, tool = SLDT:SetupBaseFrame(SLDT.Clock)
	SetupToolTip()
	
	SLDT.Clock:UnregisterEvent("PLAYER_ENTERING_WORLD")
	--SLDT.Clock:Enable()
end

SLDT.Clock:RegisterEvent("PLAYER_ENTERING_WORLD")
SLDT.Clock:SetScript("OnEvent", OnInit)