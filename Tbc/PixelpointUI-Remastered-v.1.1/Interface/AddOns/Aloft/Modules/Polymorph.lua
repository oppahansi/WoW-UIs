-----------------------------------------------------------------------------

local _, playerClass = UnitClass("player")
if playerClass ~= "MAGE" then return end

local SML = AceLibrary("SharedMedia-1.0")
local BS = AceLibrary("Babble-Spell-2.2")

-----------------------------------------------------------------------------

local AloftClassData = Aloft:GetModule("ClassData")

AloftPolymorph = Aloft:NewModule("Polymorph", "AceEvent-2.0")
AloftPolymorph.db = Aloft:AcquireDBNamespace("polymorph")
Aloft:RegisterDefaults("polymorph", "profile", {
	enable				= false,
	speculativeAttach	= true,
	texture				= "Blizzard",
	point				= "TOP",
	relativeToPoint		= "BOTTOM",
	offsetX				= 0,
	offsetY				= 0,
	width				= 115,
	height				= 5,
	color				= { 1, 1, 1, 1 },
	backdropColor		= { 0, 0, 0, 0.5 },
})

-----------------------------------------------------------------------------

local polymorphStatusBar = nil
local polymorphTargetSpellName = nil
local polymorphTargetNameplate = nil
local polymorphTargetName = nil
local polymorphSpellName = nil
local polymorphName = nil
local polymorphNameplateToHide = nil
local polymorphAttachToNextShow = false
local polymorphNameplate = nil
local polymorphHideTime = 0
local polymorphAttach = false
local polymorphHealthBarValue
local polymorphDuration

local profile

-----------------------------------------------------------------------------

--
-- Sequence goes like this:
-- 
-- We successfully cast a spell
-- Sometimes he nameplate hides and a new nameplate shows with the sheep
-- Other times it doesn't
--

function AloftPolymorph:UpdateAll()
	self:RegisterEvents()
	self:SetupFrame()
end

function AloftPolymorph:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("SharedMedia_SetGlobal", function(mediatype, override)
		if mediatype == "statusbar" then
			self:SetupFrame()
		end
	end)
	
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:SetupFrame()
		end
	end)

	if profile.enable then
		self:RegisterEvent("UNIT_SPELLCAST_SENT", "OnSpellcastSent")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "OnSpellcastSucceeded")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnHealthBarValueChanged", "OnHealthBarValueChanged")
	end
end

local backdropTable = { }
function AloftPolymorph:SetupFrame()
	if not profile.enable then
		if polymorphStatusBar then
			polymorphStatusBar:Hide()
		end
		return 
	end

	if not polymorphStatusBar then
		polymorphStatusBar = CreateFrame("StatusBar", nil, UIParent)
		polymorphStatusBar:Hide()
	end

	local texture = SML:Fetch("statusbar", profile.texture)
	polymorphStatusBar:SetWidth(profile.width)
	polymorphStatusBar:SetHeight(profile.height)
	polymorphStatusBar:SetStatusBarTexture(texture)
	polymorphStatusBar:SetStatusBarColor(unpack(profile.color))
	
	backdropTable.bgFile = texture
	polymorphStatusBar:SetBackdrop(backdropTable)
	polymorphStatusBar:SetBackdropColor(unpack(profile.backdropColor))

	local barRegion, backgroundRegion = polymorphStatusBar:GetRegions()
	barRegion:SetDrawLayer("OVERLAY")
	backgroundRegion:SetDrawLayer("ARTWORK")
end

function AloftPolymorph:OnInitialize()
	profile = self.db.profile
end

function AloftPolymorph:OnEnable()
	local level = UnitLevel("player")
	polymorphDuration = (level < 20 and 20) or (level < 40 and 30) or (level < 60 and 40) or 50

	self:RegisterEvents()
	self:SetupFrame()
end

local spellNameList =
{
	[BS["Polymorph"]] = true,
	[BS["Polymorph: Pig"]] = true,
	[BS["Polymorph: Turtle"]] = true,
}

function AloftPolymorph:OnSpellcastSent(unit,spellName,rank,targetName)
	if spellNameList[spellName] then
		-- This is in case players use [target=focus] or whatever macros
		if UnitName("target") == targetName then
			polymorphTargetNameplate = Aloft:GetTargetNameplate()
		else
			polymorphTargetNameplate = nil
		end
		polymorphTargetName = targetName
		polymorphTargetSpellName = spellName
	else
		polymorphTargetNameplate = nil
		polymorphTargetName = nil
	end
end

function AloftPolymorph:OnSpellcastSucceeded(unitid)
	if unitid ~= "player" then return end
	if not polymorphTargetName then return end

	polymorphName = polymorphTargetName
	polymorphSpellName = polymorphTargetSpellName

	local currentTime = GetTime()
	local duration = AloftClassData and AloftClassData:GetClass(polymorphTargetName) and 12 or polymorphDuration
	polymorphHideTime = 0

	polymorphStatusBar:SetMinMaxValues(-currentTime-duration, -currentTime)
	polymorphStatusBar:SetValue(-currentTime)

	if polymorphTargetNameplate then
		self:AttachPolymorph(polymorphTargetNameplate)
		polymorphNameplateToHide = polymorphTargetNameplate
		polymorphHideTime = currentTime + 1
		polymorphTargetNameplate = nil
	elseif profile.speculativeAttach then
		for aloftData in Aloft:IterateVisibleNameplates() do
			if aloftData.name == polymorphName and aloftData.healthBarValue == aloftData.healthBarMaxValue then
				self:AttachPolymorph(aloftData)
				break
			end
		end
		polymorphAttach = true
	end
end

function AloftPolymorph:PolymorphFinished()
	polymorphName		= nil
	polymorphNameplate	= nil
	polymorphAttach		= false
	polymorphStatusBar:Hide()
	self:CancelScheduledEvent("AloftPolymorph:Update")
	self:CancelScheduledEvent("PLAYER_REGEN_ENABLED")
end

function AloftPolymorph:Update()
	local time = -GetTime()
	polymorphStatusBar:SetValue(time)
	if time < polymorphStatusBar:GetMinMaxValues() then
		self:PolymorphFinished()
	end
end

function AloftPolymorph:AttachPolymorph(aloftData)
	polymorphAttach = false
	polymorphNameplate = aloftData
	polymorphHealthBarValue = aloftData.healthBarValue
	self:PlaceFrame(polymorphStatusBar, aloftData.healthBar, profile)
	polymorphStatusBar:SetParent(aloftData.nameplateFrame)
	polymorphStatusBar:Show()
	self:ScheduleRepeatingEvent("AloftPolymorph:Update", self.Update, 0.05, self)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "PolymorphFinished")
	self:Update()
end

function AloftPolymorph:OnNameplateShow(aloftData)
	if polymorphNameplate or polymorphName ~= aloftData.name then return end

	if polymorphAttachToNextShow then
		polymorphAttachToNextShow = false
		self:AttachPolymorph(aloftData)
	elseif polymorphAttach and aloftData.healthBarValue == aloftData.healthBarMaxValue then
-- Problem is that IsTarget isn't accurate until next frame. Reinvestigate later.
--[[
		if aloftData:IsTarget() then
			for i=1,40 do
				local name = UnitDebuff("target", i)
				if not name then return end
				if name == polymorphSpellName then break end
			end
		end
]]
		self:AttachPolymorph(aloftData)
	end
end

function AloftPolymorph:OnNameplateHide(aloftData)
	if aloftData == polymorphTargetNameplate then
		polymorphTargetNameplate = nil
	elseif aloftData == polymorphNameplateToHide and GetTime() < polymorphHideTime then
		polymorphNameplate			= nil
		polymorphNameplateToHide	= nil
		polymorphAttachToNextShow	= true
		polymorphHideTime			= 0
		self:CancelScheduledEvent("AloftPolymorph:Update")
	elseif aloftData == polymorphNameplate then
		polymorphAttach		= profile.speculativeAttach
		polymorphNameplate	= nil
		polymorphStatusBar:Hide()
		self:CancelScheduledEvent("AloftPolymorph:Update")
	end
end

function AloftPolymorph:OnHealthBarValueChanged(aloftData)
	if aloftData == polymorphNameplate then
		if aloftData.healthBarValue < polymorphHealthBarValue then
			self:PolymorphFinished()
		else
			polymorphHealthBarValue = aloftData.healthBarValue
		end
	end
end

-----------------------------------------------------------------------------
