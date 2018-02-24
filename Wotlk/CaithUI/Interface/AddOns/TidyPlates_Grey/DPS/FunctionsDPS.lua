local WidgetLib = TidyPlatesWidgets
local LocalVars = TidyPlatesGreyDPSVariables
local theme = TidyPlatesThemeList["Grey/DPS"]
local valueToString = TidyPlatesUtility.abbrevNumber

---------------
-- Text Delegates
---------------

local function SpellTextDelegate(unit)
	local spellname
	if unit.isCasting then 
		spellname = UnitCastingInfo("target") or UnitChannelInfo("target")
		return spellname
	else return "" end
end

local HealthTextFunctions = {
	--HEALTH_NONE
	function (health, healthmax) return "" end,
	--HEALTH_PCT
	function (health, healthmax) if health ~= healthmax then return "%"..ceil(100*(health/healthmax)) else return nil end end,
	--HEALTH_TOTAL
	function (health, healthmax) return valueToString(health) end,
	--HEALTH_DEF
	function (health, healthmax) if health ~= healthmax then return "-"..valueToString(healthmax - health) end end,
	--HEALTH_TOT_PCT
	function (health, healthmax) return valueToString(health).." / "..valueToString(healthmax).." ("..ceil(100*(health/healthmax)).."%)" end,
	--Health_Total_Pct_Def
	function (health, healthmax) return "+"..valueToString(health).." ("..ceil(100*(health/healthmax)).."%) -"..valueToString(healthmax - health) end,
}


local function HealthTextDelegate(unit) return HealthTextFunctions[LocalVars.HealthText](unit.health, unit.healthmax)end

---------------
-- Graphics Delegates
---------------
local function DpsScale(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" and  unit.threatSituation ~= "LOW" then
		if LocalVars.ScaleIgnoreNonElite then
			if unit.isElite then return LocalVars.ScaleDanger end
		else return LocalVars.ScaleDanger end 
	end
	return LocalVars.ScaleGeneral
end
	
local function DpsAlpha(unit)
	if unit.isTarget then return 1
	else 	
		if LocalVars.OpacityHideNeutral and unit.reaction == "NEUTRAL" then return 0 end
		if LocalVars.OpacityHideNonElites and not unit.isElite then return 0 end
		if not UnitExists("target") then return 1 end
		return LocalVars.OpacityNonTarget, true
	end
end


local function HealthColorDelegate(unit)	
	if  LocalVars.AggroHealth then
		if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
			local danger, safe = LocalVars.AggroDangerColor, LocalVars.AggroSafeColor
			if unit.threatSituation ~= "LOW" then return danger.r, danger.g, danger.b
				else return safe.r, safe.g, safe.b end 
			end
	end
	return unit.red, unit.green, unit.blue
end

---------------
-- Widgets
---------------
local function CreateTargetbox(frame)
	local icon = frame:CreateTexture(nil, 'OVERLAY', frame)
	icon:SetTexture("Interface\\Addons\\TidyPlates_Grey\\Media\\TargetBox")
	icon:SetWidth(128)
	icon:SetHeight(64)
	icon:Hide()
	icon.SetTarget = function (self, value) 
		if value then icon:Show() else icon:Hide() end 
	end
	return icon
end

local function OnUpdateDelegate(plate, unit)
	-- Tug-o-Threat
	if LocalVars.WidgetTug then
		if not plate.widgets.WidgetTug then 		
			plate.widgets.WidgetTug = WidgetLib.CreateThreatLineWidget(plate)
			plate.widgets.WidgetTug:SetPoint("CENTER", plate, 0, 18)
		end
		plate.widgets.WidgetTug:UpdateThreat(unit)
	end
	-- Combo Point Wheel
	if LocalVars.WidgetCombo then
		if not plate.widgets.WidgetCombo then 
			plate.widgets.WidgetCombo = WidgetLib.CreateComboPointWidget(plate)
			plate.widgets.WidgetCombo:SetPoint("CENTER", plate, 30, 25)
			plate.widgets.WidgetCombo:SetFrameLevel(plate:GetFrameLevel()+2)
		end
		plate.widgets.WidgetCombo:Update(unit)
	end	
	-- Target Selection Box
	if LocalVars.WidgetSelect then
		if not plate.widgets.targetbox then 
			plate.widgets.targetbox = CreateTargetbox(plate)
			plate.widgets.targetbox:SetPoint("CENTER", 0, -5)
		end
		plate.widgets.targetbox:SetTarget(unit.isTarget)
	end
end

---------------
-- Function Assignment - Tank Mode
---------------
theme.SetSpecialText = HealthTextDelegate
theme.SetSpecialText2 = SpellTextDelegate
theme.SetScale = DpsScale
theme.SetAlpha = DpsAlpha
theme.OnUpdate = OnUpdateDelegate
theme.SetHealthbarColor = HealthColorDelegate





