
------------------------------
-- Combo Point Widget
------------------------------
--  [[

local path = "Interface\\Addons\\TidyPlates_Grey"


local combopath = path.."\\Art\\ComboPoints\\"
local COMBO_ART = {
"Blue",
"Green",
"Yellow",
"Orange",
"Red",
}

local function UpdateComboPointFrame(frame, points)
		--local points = 0
		--if UnitExists("target") then points = GetComboPoints("player", "target") end
		--print("Here")
		if points > 0 then 
			frame.Icon:SetTexture(combopath..COMBO_ART[points]) 
			frame:Show()
		else frame:Hide() end	
end

local function CreateComboPointFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame:RegisterEvent("PLAYER_COMBO_POINTS")
	frame:SetScript("OnEvent", function() TidyPlates:ForceUpdateFrame(parent.secureframe) end)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.UpdateCombo = UpdateComboPointFrame
	return frame
end
--]]

---------------
-- Threat Functions
---------------
--GameTooltip:HookScript("OnTooltipSetUnit", function(self) TidyPlates:Update() end)
local threatpath = "Interface\\Addons\\TidyPlates_Grey\\Art\\RingThreat\\"
local threatfont = "Interface\\Addons\\TidyPlates_Grey\\Art\\LiberationSans-Regular.ttf"
local TANK_SEGMENT_ART = {
HIGHTANK = threatpath.."Red",
MEDIUMTANK = threatpath.."Orange",
LOWTANK = threatpath.."Yellow",
HIGHDPS = threatpath.."Green",
MEDIUMDPS = threatpath.."Blue",
LOWDPS = threatpath.."Blue",
UNKNOWN = threatpath.."Unknown",
}

local function SetFade(frame)
	if GetTime() > frame.FadeTime then
		frame:Hide()
		frame:SetScript("OnUpdate", nil)
	end
end

local function GetThreatSegment(threat)
	if not threat then return nil end
	if threat > 135 then return "HIGHTANK"
	elseif threat > 110 then return "MEDIUMTANK"
	elseif threat > 100 then return "LOWTANK"
	elseif threat > 85 then return "HIGHDPS"
	elseif threat > 55 then return "MEDIUMDPS"
	else return "LOWDPS"  end
end

local function GetRelativeThreat(unit)
	if not UnitExists(unit) then return end
	local _, group, size, index, unitid
	local playerthreat, leaderthreat, tempthreat, petthreat, leadername  = 0,0,0,0, nil
	_, _,  playerthreat, _, _ = UnitDetailedThreatSituation("player", unit)
	if HasPetUI() then _, _,  petthreat, _, _ = UnitDetailedThreatSituation("pet", unit);leaderthreat = petthreat or 0; leadername = "pet" end
	if UnitInRaid("player") then group = "raid"; size = GetNumRaidMembers() - 1
	elseif UnitInParty("player") then group = "party"; size = GetNumPartyMembers()
	else group = nil end
	if group then
		for index = 1, size do
			unitid = group..index
			_, _, tempthreat , _, _ = UnitDetailedThreatSituation(unitid, unit)
			if tempthreat and tempthreat > leaderthreat then 
				leaderthreat = tempthreat 
				leadername = unitid
				end
		end
	end
	if playerthreat and leaderthreat then
		if playerthreat == 100 then return playerthreat + (100-leaderthreat), nil
		else return playerthreat, leadername end
	else return end
end


---------------
-- Threat Widget
---------------
--  [[
local function UpdateThreatWidget(frame, unitid)
	if unitid then
		local threat, topholder = GetRelativeThreat(unitid) 
		local threatsegment = GetThreatSegment(threat)
		if threatsegment then
			-- Set Indicator
			frame:Show()
			frame.ThreatIcon:SetTexture(TANK_SEGMENT_ART[threatsegment])
			frame.ThreatText:SetText(floor(threat))
			if topholder then 
				frame.TargetText:SetText(UnitName(topholder))
				--local _, class = UnitClass(topholder)
				--local classcolor = RAID_CLASS_COLORS[class]
				--frame.TargetText:SetTextColor(classcolor.r, classcolor.g, classcolor.b) 
			else frame.TargetText:SetText("") end
			-- Set Fading
			frame.FadeTime = GetTime() + 3
			frame:SetScript("OnUpdate", SetFade)
		else frame:Hide() end
	elseif (GetTime() > frame.FadeTime) or (not InCombatLockdown()) then frame:Hide() end
end

local function CreateThreatWidget(parent, showname, hangtime, art)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(64)
	frame:SetHeight(64)
	-- Icon
	frame.ThreatIcon = frame:CreateTexture(nil, "OVERLAY")
	frame.ThreatIcon:SetAllPoints(frame)
	-- Threat Text
	frame.ThreatText = frame:CreateFontString(nil, "OVERLAY")
	frame.ThreatText:SetFont(threatfont, 8, "NONE")
	frame.ThreatText:SetPoint("CENTER",frame.ThreatIcon,"CENTER", -1, 0)
	frame.ThreatText:SetWidth(20)
	frame.ThreatText:SetHeight(20)
	-- Target Text
	frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
	frame.TargetText:SetFont(threatfont, 8, "NONE")
	frame.TargetText:SetShadowOffset(1, -1)
	frame.TargetText:SetShadowColor(0,0,0,1)
	frame.TargetText:SetPoint("BOTTOM",frame,"TOP", 1, -25)
	frame.TargetText:SetWidth(50)
	frame.TargetText:SetHeight(20)
	-- Setup
	frame.FadeTime = 0
	frame:Hide()
	--parent.bars.health:RegisterEvent("CURSOR_UPDATE")
	--frame:SetScript("OnEvent", function() TidyPlates:ForceUpdateFrame(parent.secureframe)  end)
	frame.UpdateThreat = UpdateThreatWidget
	return frame
end
--]]

---------------
-- Mana Widget
---------------
--[[
local combopath = "Interface\\Addons\\TidyPlates_Grey\\Art\\ComboPoints\\"
local COMBO_ART = {
"Blue",
"Green",
"Yellow",
"Orange",
"Red",
}

local function UpdateManaWidget(self, points)
		if points > 0 then 
			self.Icon:SetTexture(combopath..COMBO_ART[points]) 
			self:Show()
		else self:Hide() end	
end

local function CreateManaWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:RegisterEvent("CURSOR_UPDATE")
	frame:RegisterEvent("PLAYER_COMBO_POINTS")
	frame:SetScript("OnEvent", function() TidyPlates:ForceUpdateFrame(parent.secureframe)  end)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetPoint("CENTER",parent,"TOP")
	frame.Icon:SetWidth(64)
	frame.Icon:SetHeight(64)
	frame:Hide()
	frame.UpdateMana = UpdateManaWidget
	return frame
end
--]]





--[[ "TANKED" Widget

local offTanks = {}
-- RAID_ROSTER_UPDATE

for i, 1, numraid do
	isAssigned = GetPartyAssignment("assignment", "unit") or GetPartyAssignment("assignment", "name" [, exactMatch])
	if isAssigned == "MAINTANK" then end
end

--]]

TidyPlatesWidgets = {}
TidyPlatesWidgets.CreateComboPointFrame = CreateComboPointFrame
TidyPlatesWidgets.CreateThreatWidget = CreateThreatWidget

