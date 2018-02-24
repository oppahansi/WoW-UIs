


---------------
-- Mana Widget
---------------

local MANA_COLOR = {r = 1, g = .67, b = .14}

local function UpdateManaLine(frame, unitid)
	if unitid then
		local mana = UnitMana(unitid)	
		local manamax = UnitManaMax(unitid)		
		if mana and mana > 0 then
			-- Set Size
			frame.Line:SetWidth(.9 * (mana/manamax))
			-- Set Fading
			frame:Show()
			frame.FadeTime = GetTime() + 3
			frame:SetScript("OnUpdate", SetFade)
		else frame:Hide() end
	elseif (GetTime() > frame.FadeTime) or (not InCombatLockdown()) then frame:Hide() end
end
local manapath = path.."\\Art\\ThreatLine\\"
local function CreateManaLine(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(100)
	frame:SetHeight(24)
	-- Threat Center
	frame.Left = frame:CreateTexture(nil, "OVERLAY")
	frame.Left:SetTexture(manapath.."LeftDot")
	frame.Left:SetPoint("CENTER", frame, "LEFT")
	frame.Left:SetWidth(32)
	frame.Left:SetHeight(32)
	-- Threat Dot
	frame.Right = frame:CreateTexture(nil, "OVERLAY")
	frame.Right:SetTexture(manapath.."RightDot")
	frame.Right:SetPoint("CENTER", frame.Line, "RIGHT")
	frame.Right:SetWidth(32)
	frame.Right:SetHeight(32)
	-- Threat Line
	frame.Line = frame:CreateTexture(nil, "OVERLAY")
	frame.Line:SetTexture(manapath.."Threatline")
	frame.Line:SetPoint("LEFT", frame)
	frame.Line:SetWidth(32)
	frame.Line:SetHeight(32)
	-- Target Text
	frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
	frame.TargetText:SetFont(threatfont, 9, "NONE")
	frame.TargetText:SetPoint("BOTTOM",frame.Dot,"TOP", 0, -15)
	frame.TargetText:SetWidth(50)
	frame.TargetText:SetHeight(20)
	-- Set Colors
	frame.Right:SetVertexColor(MANA_COLOR.r, MANA_COLOR.g, MANA_COLOR.b)
	frame.Line:SetVertexColor(MANA_COLOR.r, MANA_COLOR.g, MANA_COLOR.b)
	frame.Left:SetVertexColor(MANA_COLOR.r, MANA_COLOR.g, MANA_COLOR.b)
	-- Mechanics/Setup
	frame.FadeTime = 0
	frame:Hide()
	frame.UpdateMana = UpdateManaLine
	return frame
end

---------------
-- Mouseover Widget
---------------
local function FadeTimer(self)
	if GetTime() > self.FadeTime then
		self:Hide()
		self:SetScript("OnUpdate", nil)
	end
end

local function UpdateMouseoverWidget(self, delay)
	if delay then
		self:Show()
		self.FadeTime = GetTime() + delay
		self:SetScript("OnUpdate", FadeTimer)
	elseif (GetTime() < self.FadeTime) then return
	else self:Hide() end
end

local function CreateMouseoverWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(128)
	frame:SetHeight(64)
	-- Mechanics/Setup
	frame.FadeTime = 0
	frame:Hide()
	frame:RegisterEvent("CURSOR_UPDATE")
	frame:SetScript("OnEvent", function() TidyPlates:Update() end)
	frame.Update = UpdateMouseoverWidget
	return frame
end

---------------
-- Aura Widget
---------------
local function UpdateDebuffWidget(self, unitid, aura, delay)
	local name, rank, icon, count, debuffType, duration, texture
	
	if unitid and aura then 
		name, rank, icon, count, debuffType, duration = UnitDebuff(unitid, aura);
		texture = GetSpellTexture(aura)
	end

	--[[ Idea:
		Each debuff icon has its own HideIn() which corresponds to the end time.  
		
		1. Generate Aura List
		2. Update Widget textureregions
		3. Set texture regions to HideIn
		
		
		1. TextureRegion - Icon of Spell (with cropped border?)
		2. Fontstring - Stacks
		3. Fontsring - Time remaining
	--]]
	
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
