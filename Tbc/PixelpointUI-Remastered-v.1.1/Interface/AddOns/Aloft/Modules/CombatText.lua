-----------------------------------------------------------------------------

local AloftCombatText = Aloft:NewModule("CombatText", "AceEvent-2.0")
AloftCombatText.db = Aloft:AcquireDBNamespace("combatText")
Aloft:RegisterDefaults("combatText", "profile", {
	enable			= true, -- not used for any module control logic, just required for PlaceFrame and PrepareText to work
	enableGroup		= false,
	enableTarget	= false,
	alpha			= 0.75,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= 0,
	font			= "Friz Quadrata TT",
	fontSize		= 16,
	shadow			= false,
	outline			= "OUTLINE",
	colors =
	{
		[0] = { 1, 1, 1 },			-- Physical
		[1] = { 1, 1, 0.5 },  		-- Holy
		[2] = { 1, 0.3, 0 },		-- Fire
		[3] = { 0.5, 1, 0.2 },		-- Nature
		[4] = { 0.4, 0.6, 0.9 },	-- Frost,
		[5] = { 0.7, 0.4, 1 },	-- Shadow
		[6] = { 0.8, 0.8, 1 },		-- Arcane
		energize = { 0.41, 0.8, 0.94 },
		text = { 1, 1, 1 },
		heal = { 0, 1, 0 },
	},
})

-----------------------------------------------------------------------------

local textRegionPool = { }
local updateList = { }
local profile
local colors

-----------------------------------------------------------------------------

function AloftCombatText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enableTarget or profile.enableGroup then
			if aloftData.combatTextRegion then
				self:PlaceFrame(aloftData.combatTextRegion, aloftData.healthBar, profile)
				self:PrepareText(aloftData.combatTextRegion, profile)
			end
		else
			self:OnNameplateHide(aloftData)
		end
	end
	for textRegion in pairs(textRegionPool) do
		self:PrepareText(textRegion, profile)
	end
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCombatText:RegisterEvents()
	if profile.enableGroup or profile.enableTarget then
		self:RegisterEvent("UNIT_COMBAT", "OnUnitCombat")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	else
		self:CancelEvent("UNIT_COMBAT")
		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

function AloftCombatText:RequiresData()
	if profile.enableGroup then
		return "unitid"
	end
end

function AloftCombatText:OnInitialize()
	profile = self.db.profile
	colors = profile.colors
end

function AloftCombatText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)
	
	self:UpdateAll()
end

function AloftCombatText:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------

-- These return text, scale, r, g, b
local combatHandlers =
{
	["BLOCK"]		= function() return CombatFeedbackText["BLOCK"], 0.75, colors.text end,
	["ENERGIZE"]	= function(flags, amount) return amount, flags == "CRITICAL" and 1.3 or 1.0, colors.energize end,
	["HEAL"]		= function(flags, amount) return "+"..amount, flags == "CRITICAL" and 1.3 or 1.0, colors.heal end,
	["IMMUNE"]		= function() return CombatFeedbackText["IMMUNE"], 0.5, colors.text end,
	["WOUND"]		= function(flags, amount, type) 
						if amount ~= 0 then
							local scale = 1
							if flags == "CRITICAL" or flags == "CRUSHING" then
								scale = 1.5
							elseif flags == "GLANCING" then
								scale = 0.75
							end
							return "-"..amount, scale, colors[type]
						elseif flags == "ABSORB" or flags == "BLOCK" or flags == "RESIST" then
							return CombatFeedbackText[flags], 0.75, colors.text
						end
						return CombatFeedbackText[flags], 1.0, colors.text
					  end,
}

function AloftCombatText:OnUnitCombat(unit, event, ...)	-- last 3 arguments are flags, amount, type
	if unit == "player" then return end
	
	local aloftData	
	
	if unit == "target" then
		if not profile.enableTarget then return end		
		if profile.enableGroup and (UnitInParty(unit) or UnitInRaid(unit)) then return end
		aloftData = Aloft:GetTargetNameplate()
	else
		if not profile.enableGroup then return end
		aloftData = Aloft:GetUnitNameplate(unit)	
	end
	if not aloftData then return end

	local text, scale, color
	if combatHandlers[event] then
		text, scale, color = combatHandlers[event](...)
	else
		text, scale, color = CombatFeedbackText[event], 1.0, colors.text
	end

    local combatTextRegion = aloftData.combatTextRegion    
    if not combatTextRegion then
        combatTextRegion = next(textRegionPool)
        if combatTextRegion then
            textRegionPool[combatTextRegion] = nil
            combatTextRegion:SetParent(aloftData.nameplateFrame)
        else
            -- We need a new text region.
            combatTextRegion = aloftData:CreateFontString()
	        self:PrepareText(combatTextRegion, profile)
        end
        self:PlaceFrame(combatTextRegion, aloftData.healthBar, profile)
        aloftData.combatTextRegion = combatTextRegion
    end

	-- The line below crashes the Windows WoW client sporadically (not the Mac one). SetTextHeight is used instead.
	--combatTextRegion:SetFont(SML:Fetch("font", profile.font), profile.fontSize * scale, profile.outline)
	combatTextRegion:SetTextHeight(profile.fontSize * scale)
    combatTextRegion:SetText(text)
    combatTextRegion:SetTextColor(unpack(color))
    combatTextRegion:SetAlpha(0)
    combatTextRegion:Show()

    updateList[aloftData] = GetTime()

	self:ScheduleRepeatingEvent("AloftCombatText:Update", self.Update, 0.05, self)
end

function AloftCombatText:Update()
	local now = GetTime()
	
	for aloftData, startTime in pairs(updateList) do
		local elapsedTime = now - startTime
		local combatTextRegion = aloftData.combatTextRegion

		if elapsedTime < COMBATFEEDBACK_FADEINTIME then
			combatTextRegion:SetAlpha(profile.alpha*(elapsedTime / COMBATFEEDBACK_FADEINTIME))
		elseif elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) then
			combatTextRegion:SetAlpha(profile.alpha)
		elseif elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME) then
			combatTextRegion:SetAlpha(profile.alpha * (1 - (elapsedTime - COMBATFEEDBACK_HOLDTIME - COMBATFEEDBACK_FADEINTIME) / COMBATFEEDBACK_FADEOUTTIME))
		else
			combatTextRegion:Hide()
			textRegionPool[combatTextRegion] = true
			aloftData.combatTextRegion = nil
			updateList[aloftData] = nil
		end		
	end

    if not next(updateList) then
		self:CancelScheduledEvent("AloftCombatText:Update")
    end
end

function AloftCombatText:OnNameplateHide(aloftData)
    local combatTextRegion = aloftData.combatTextRegion
    if combatTextRegion then
        combatTextRegion:Hide()
		textRegionPool[combatTextRegion] = true
		aloftData.combatTextRegion = nil
        updateList[aloftData] = nil
        
        if not next(updateList) then
			self:CancelScheduledEvent("AloftCombatText:Update")
        end
    end
end

-----------------------------------------------------------------------------
