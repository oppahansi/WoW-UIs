TidyPlatesWidgets = {}

--[[
* Widgets
	TidyPlatesWidgets. table
	AddWidget("Type", ...) where ... is the parameters
	So, using...  TidyPlatesWidgets:AddWidget("ThreatWheel"), would check to make sure the widget exists
	Each widget should use the .Update() method for updating, as standard practice
	Widgets should accept the UnitInfo table, and work automatically
	Widgets should only need init, placement, and update calls
	- Threat Wheel (Unit, Time) (ShowName)
	- Threat Line (Unit, Time) (ShowName)
	- Text Widget (Text)
	- Mana Widget (Percent)
	- Buff Widget (Buff,Time) (ShowTimerBar)
	- Combo Point Widget (Number)
	- "Behind" Widget
	- Incoming Heal Widget (Requires Healcomm)
	- Current Target Widget
	- Selection Widget
	- Class Icon
	
	-- Update Artwork Paths


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




