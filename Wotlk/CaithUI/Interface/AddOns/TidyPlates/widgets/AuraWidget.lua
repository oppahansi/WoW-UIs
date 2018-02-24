---------------
-- Aura Widgets
---------------
local function UpdateDebuffWidget(frame, unit)
	local name, rank, icon, count, debuffType, duration, expirationTime,  unitCaster
	local unitid
	
	if unit.isTarget and UnitExists("target") then unitid = "target"
	elseif unit.isMouseover then unitid = "mouseover" end
	
	if unitid then 
		for index = 1, 40 do
			name, rank, icon, count, debuffType, duration, expirationTime,  unitCaster = UnitDebuff(unitid, index);
		end

	end

	if name and texture and delay then
		self.texture:SetTexture(texture)
		
		self:Show()
		self.FadeTime = GetTime() + delay
		if delay > 0 then self:SetScript("OnUpdate", FadeTimer) end
		
	elseif (GetTime() < self.FadeTime) then return
	else self:Hide() end
end

local function CreateDebuffWidget(parent)
	local frame = CreateMouseoverWidget(parent)
	frame:SetWidth(16)
	frame:SetHeight(16)
	-- Graphics
	frame.texture = frame:CreateTexture(nil, "OVERLAY")
	frame.texture:SetAllPoints(frame)
	-- Mechanics/Setup
	frame.FadeTime = 0
	frame:Hide()
	frame:RegisterEvent("CURSOR_UPDATE")
	frame:SetScript("OnEvent", function() TidyPlates:Update() end)
	frame.Update = UpdateDebuffWidget
	return frame
end

--[[

		local unitid
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) then frame:Hide(); return end
		if unit.isTarget and UnitExists("target") then unitid = "target"
		elseif unit.isMouseover then unitid = "mouseover" end
		
		if unitid then
			local threat, topholder = GetRelativeThreat(unitid) 
			local threatsegment = GetThreatSegment(threat)
			if threatsegment then
				-- Set Indicator
				frame:Show()
				--frame.ThreatIcon:SetTexture(THREATWIDGET_SEGMENT_ART[threatsegment])
				frame.ThreatIcon:SetTexCoord(unpack(THREATWIDGET_SEGMENT_ART[threatsegment]))
				frame.ThreatText:SetText(floor(threat))
				if topholder then frame.TargetText:SetText(UnitName(topholder))
				else frame.TargetText:SetText("") end
				-- Set Fading
				frame:Show()
				frame.FadeTime = GetTime() + 3
				frame:HideIn(frame.FadeTime)
			else frame:Hide() end
		elseif (GetTime() > frame.FadeTime) then frame:Hide() end
		
--]]