Gladiminish = LibStub("AceAddon-3.0"):NewAddon("Gladiminish", "AceEvent-3.0", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Gladiminish")
local Gladius = Gladius
local fontSize
local db

function Gladiminish:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("GladiminishDB", self:GetDefaultDB())
	db = self.db.profile
	self:SetupConfig()
	
	if db.fontGladius then
		fontSize = Gladius.db.profile.auraFontSize or db.fontSize
	else
		fontSize = db.fontSize
	end

	self.DRData = LibStub("DRData-1.0")
	
	self.trackedGUID = {}
	self.iFrames = {}
	self.unusedIcons = {}
	
	self:SecureHook(Gladius, "JoinedArena", self.JoinedArena)
	self:SecureHook(Gladius, "Test", self.UpdateiFrames)
	self:SecureHook(Gladius, "UpdateFrame", self.UpdateiFrames)
	
	self:SecureHook(Gladius, "LeftArena", self.ClearAllFrames)
	self:SecureHook(Gladius, "UpdateUnit", self.UpdateUnit)

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

-- Copy Gladius GUIDs to ensure the right diminishing returns are next to the right frame
function Gladiminish:UpdateUnit(unit)
	if unit and Gladius.buttons[unit].GUID then
		Gladiminish.trackedGUID[Gladius.buttons[unit].GUID] = unit
	end
end

-- Clear old data
function Gladiminish:ClearAllFrames()
	local self = Gladiminish
	
	for guid, unit in pairs(self.trackedGUID) do
		self:ClearAllDR(unit)
		self.trackedGUID[guid] = nil
	end
end

-- Update iconFrames before every match and after the Gladius frame changed
function Gladiminish:UpdateiFrames()
	local self = Gladiminish
	local bracket = Gladius.currentBracket or 5
	
	for i=1, bracket do
		local unitID = "arena"..i
	
		if Gladius.buttons[unitID] then
			if not self.iFrames[unitID] then
				self.iFrames[unitID] = self:CreateIconFrame(i)	
			else
				local gladiusButton = "GladiusButton"..i
				local iFrame = self.iFrames["arena"..i]
		
				self:PositionIconFrame(iFrame, gladiusButton)
			end
			
			self.iconWidth = self.iFrames[unitID]:GetHeight()
			if Gladius.buttons[unitID].GUID then
				self.trackedGUID[Gladius.buttons[unitID].GUID] = unitID
			end
		end
	end	
	
	if db.fontGladius then
		fontSize = Gladius.db.profile.auraFontSize or db.fontSize
	else
		fontSize = db.fontSize
	end
end

-- Also clear data when joining arena (could have been in test mode)
function Gladiminish:JoinedArena()
	Gladiminish:ClearAllFrames()
	Gladiminish:UpdateiFrames()
end

local trackedEvents = { ["SPELL_AURA_REMOVED"] = true, ["SPELL_AURA_APPLIED"] = true, ["SPELL_AURA_REFRESH"] = true, ["PARTY_KILL"] = true }
function Gladiminish:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType)
	if self.trackedGUID[destGUID] and trackedEvents[eventType] then
	
		if ( eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH" ) then
			if ( auraType == "DEBUFF" and self.DRData:GetSpellCategory(spellID) ) then
				--self:Print("Gained:",self.trackedGUID[destGUID], spellID, spellName)
				self:DebuffGained(self.trackedGUID[destGUID], spellID)
			end
		elseif eventType == "SPELL_AURA_REMOVED" then
			if ( auraType == "DEBUFF" and self.DRData:GetSpellCategory(spellID) ) then
				--self:Print("Faded:",self.trackedGUID[destGUID], spellID, spellName)
				self:DebuffFaded(self.trackedGUID[destGUID], spellID)
			end
		elseif eventType == "PARTY_KILL" then
			self:ClearAllDR(self.iFrames[self.trackedGUID[destGUID]])
		end
	end
end

-- Create a diminishing return item, but fix its duration
function Gladiminish:DebuffGained(unit, spellID)
	local category = self.DRData:GetSpellCategory(spellID)
	local duration = self.DRData:GetResetTime()
	
	-- Is there already a diminishing return?
	for i, icon in pairs(self.iFrames[unit].icons) do
		if icon.category == category then
			self:RefreshIcon(icon, self.iFrames[unit], category, spellID, self.DRData:NextDR(icon.factor), duration)
			icon.fixed = true
			self:PositionIcons()
			return
		end
	end
	
	-- Create a new diminishing return
	local icon
	if (#Gladiminish.unusedIcons > 0) then
		icon = table.remove(Gladiminish.unusedIcons)
		Gladiminish:RefreshIcon(icon, self.iFrames[unit], category, spellID, 0.5, duration)
	else
		icon = Gladiminish:CreateIcon(self.iFrames[unit], category, spellID, 0.5, duration)
	end
	icon.fixed = true
	
	table.insert(self.iFrames[unit].icons, icon)
	self.iFrames[unit].numIcons = #self.iFrames[unit].icons		

	self:PositionIcons()
	icon:Show()
end

-- Find diminishing return icon and unfix it
function Gladiminish:DebuffFaded(unit, spellID)
	local category = self.DRData:GetSpellCategory(spellID)
	
	for i, icon in pairs(self.iFrames[unit].icons) do
		if icon.category == category then
			icon.fixed = false
			self:PositionIcons()
			break
		end
	end
end

-- Clear every diminishing return of a given unit
function Gladiminish:ClearAllDR(unit)
	local self = Gladiminish
	local iFrame = self.iFrames[unit]
	
	if iFrame then
		while #iFrame.icons > 0 do
			local icon = table.remove(iFrame.icons)
			icon:Hide()
			table.insert(self.unusedIcons, icon)
		end
		
		self:PositionIcons()
	end
end

local function sortIcons (a, b)
	if a.fixed ~= b.fixed then
		return b.fixed
	else
		return a.timeLeft < b.timeLeft
	end
end								
								
-- Sort and position the icons
function Gladiminish:PositionIcons()
	for _, iFrame in pairs(self.iFrames) do
		local side = iFrame:GetHeight()
		local padding
		if db.iconGladius or db.iconSize > side then
			padding = 0
		else
			padding = (side - db.iconSize) / 2
			side = db.iconSize
		end
		
		iFrame:SetWidth(#iFrame.icons * ( side + 10 ) + 10)

		table.sort(iFrame.icons, sortIcons)
		for i, icon in ipairs(iFrame.icons) do
			icon:ClearAllPoints()
			icon:SetWidth(side)
			
			if db.framePos then
				icon:SetPoint("TOPRIGHT", iFrame, "TOPRIGHT", -(i - 1) * ( side + db.iconDist ), -padding)
				icon:SetPoint("BOTTOMRIGHT", iFrame, "BOTTOMRIGHT", -(i - 1) * ( side + db.iconDist ), padding)
			else
				icon:SetPoint("TOPLEFT", iFrame, "TOPLEFT", (i - 1) * ( side + db.iconDist ), -padding)
				icon:SetPoint("BOTTOMLEFT", iFrame, "BOTTOMLEFT", -(i - 1) * ( side + db.iconDist ), padding)
			end
		end
	end
end

-- Update displayed icons in an iconFrame
local function iconUpdate(self, elapsed)
	if (self.numIcons > 0) then
		for i, icon in pairs(self.icons) do
			if not icon.fixed then
				icon.timeLeft = icon.timeLeft - elapsed
			end
			
			if icon.timeLeft >= 10 then
				icon.durationText:SetFormattedText("%.0f", icon.timeLeft)
			elseif icon.timeLeft > 0 then
				icon.durationText:SetFormattedText("%.1f", icon.timeLeft)
			else
				local Gladiminish = Gladiminish
			
				self.icons[i]:Hide()
				table.insert(Gladiminish.unusedIcons, table.remove(self.icons, i))
				
				Gladiminish:PositionIcons()	
			end
		end
	end
end

-- Create an iconFrame and position it
function Gladiminish:CreateIconFrame(i)
	local gladiusButton = "GladiusButton"..i
	local iFrame = CreateFrame("Frame", nil, GladiusFrame)
	
	iFrame:ClearAllPoints()
	self:PositionIconFrame(iFrame, gladiusButton)
	iFrame:SetWidth(1)
	
	iFrame:SetScript("OnUpdate", iconUpdate)
	iFrame.numIcons = 0
	iFrame.icons = {}
	
	return iFrame
end

-- Position an iconFrame next to a given button
function Gladiminish:PositionIconFrame(iFrame, gladiusButton)
	local dist
	iFrame:ClearAllPoints()
	
	if db.framePos then	
		dist = db.frameDist + (_G[gladiusButton]:GetLeft() or 0) - (GladiusFrame:GetLeft() or 0)

		iFrame:SetPoint("TOPRIGHT", gladiusButton, "TOPLEFT", -dist, 0)
		iFrame:SetPoint("BOTTOMRIGHT", gladiusButton, "BOTTOMLEFT", -dist, 0)
	else
		dist = db.frameDist + ( ( GladiusFrame:GetRight() or 0 ) - ( _G[gladiusButton]:GetRight() or 0 ) )
	
		iFrame:SetPoint("TOPLEFT", gladiusButton, "TOPRIGHT", dist, 0)
		iFrame:SetPoint("BOTTOMLEFT", gladiusButton, "BOTTOMRIGHT", dist, 0)	
	end
end

-- Return color based on DR factor - soon to be replaced
function Gladiminish:GetColor(factor)
	if factor == 0.5 then
		return 1, 1, 0, 1
	elseif factor == 0.25 then
		return 1, 0.5, 0, 1
	else
		return 1, 0, 0, 1
	end
end

-- Create an icon
function Gladiminish:CreateIcon(parent, category, spellID, factor, duration)
	local icon = CreateFrame("Frame", nil, parent)
	icon.category = category
	icon.spellID = spellID
	icon.factor = factor
	icon.timeLeft = duration
	icon.fixed = nil
	
	icon:ClearAllPoints()
	icon:SetPoint("TOPRIGHT", 0, 0)
	
	local size = parent:GetHeight()
	icon:SetWidth(size)
	icon:SetHeight(size)
	
	-- texture
	local _, _, path = GetSpellInfo(spellID)
	icon.texture = icon:CreateTexture(nil, "ARTWORK")
	icon.texture:SetTexture(path)
	icon.texture:SetAllPoints(icon)
	
	local font = GameFontNormalSmall:GetFont()	
	-- duration text
	icon.durationText = icon:CreateFontString(nil, "OVERLAY")
	icon.durationText:SetFont(font, fontSize)
	icon.durationText:SetShadowOffset(1, -1)
	icon.durationText:SetShadowColor(0, 0, 0, 1)
	icon.durationText:SetJustifyH("CENTER")
	icon.durationText:SetPoint("CENTER", 0, 0)
	
	icon.durationText:SetTextColor(self:GetColor(factor))
	
	return icon
end

-- Update an existing icon
function Gladiminish:RefreshIcon(icon, parent, category, spellID, factor, duration)
	icon.spellID = spellID
	icon.category = category
	icon.factor = factor
	icon.timeLeft = duration
	icon.fixed = nil
	
	icon:SetParent(parent)
	icon:ClearAllPoints()
	icon:SetPoint("TOPRIGHT", 0, 0)
	
	local size = parent:GetHeight()
	icon:SetWidth(size)
	icon:SetHeight(size)
	
	local _, _, path = GetSpellInfo(spellID)
	icon.texture:SetTexture(path)
	icon.texture:ClearAllPoints()
	icon.texture:SetAllPoints(icon)
	
	local font = GameFontNormalSmall:GetFont()
	icon.durationText:SetFont(font, fontSize)
	icon.durationText:ClearAllPoints()
	icon.durationText:SetPoint("CENTER", 0, 0)
	
	icon.durationText:SetTextColor(self:GetColor(factor))
end