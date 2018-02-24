-----------------------------------------------------------------------------

local _, playerClass = UnitClass("player")
if playerClass ~= "PRIEST" then return end

local SML = AceLibrary("SharedMedia-1.0")
local BS = AceLibrary("Babble-Spell-2.2")

-----------------------------------------------------------------------------

AloftShackleUndead = Aloft:NewModule("ShackleUndead", "AceEvent-2.0")
AloftShackleUndead.db = Aloft:AcquireDBNamespace("shackleUndead")
Aloft:RegisterDefaults("shackleUndead", "profile", {
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

local shackleUndeadStatusBar = nil
local shackleUndeadTargetNameplate = nil
local shackleUndeadTargetName = nil
local shackleUndeadName = nil
local shackleUndeadNameplate = nil
local shackleUndeadAttach = false
local shackleUndeadHealthBarValue
local shackleUndeadDuration

local profile

-----------------------------------------------------------------------------

function AloftShackleUndead:UpdateAll()
	self:RegisterEvents()
	self:SetupFrame()
end

function AloftShackleUndead:RegisterEvents()
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
function AloftShackleUndead:SetupFrame()
	if not profile.enable then
		if shackleUndeadStatusBar then
			shackleUndeadStatusBar:Hide()
		end
		return 
	end

	if not shackleUndeadStatusBar then
		shackleUndeadStatusBar = CreateFrame("StatusBar", nil, UIParent)
		shackleUndeadStatusBar:Hide()
	end

	local texture = SML:Fetch("statusbar", profile.texture)
	shackleUndeadStatusBar:SetWidth(profile.width)
	shackleUndeadStatusBar:SetHeight(profile.height)
	shackleUndeadStatusBar:SetStatusBarTexture(texture)
	shackleUndeadStatusBar:SetStatusBarColor(unpack(profile.color))
	
	backdropTable.bgFile = texture
	shackleUndeadStatusBar:SetBackdrop(backdropTable)
	shackleUndeadStatusBar:SetBackdropColor(unpack(profile.backdropColor))

	local barRegion, backgroundRegion = shackleUndeadStatusBar:GetRegions()
	barRegion:SetDrawLayer("OVERLAY")
	backgroundRegion:SetDrawLayer("ARTWORK")
end

function AloftShackleUndead:OnInitialize()
	profile = self.db.profile
end

function AloftShackleUndead:OnEnable()
	local level = UnitLevel("player")
	shackleUndeadDuration = (level < 40 and 30) or (level < 60 and 40) or 50

	self:RegisterEvents()
	self:SetupFrame()
end

local shackleUndeadSpellName = BS["Shackle Undead"]
function AloftShackleUndead:OnSpellcastSent(unit, spellName, rank, targetName)
	if spellName == shackleUndeadSpellName then
		-- This is in case players use [target=focus] or whatever macros
		if UnitName("target") == targetName then
			shackleUndeadTargetNameplate = Aloft:GetTargetNameplate()
		else
			shackleUndeadTargetNameplate = nil
		end
		shackleUndeadTargetName = targetName
	else
		shackleUndeadTargetNameplate = nil
		shackleUndeadTargetName = nil
	end
end

function AloftShackleUndead:OnSpellcastSucceeded(unitid)
	if unitid ~= "player" then return end
	if not shackleUndeadTargetName then return end

	shackleUndeadName = shackleUndeadTargetName

	local currentTime = GetTime()

	shackleUndeadStatusBar:SetMinMaxValues(-currentTime-shackleUndeadDuration, -currentTime)
	shackleUndeadStatusBar:SetValue(-currentTime)

	if shackleUndeadTargetNameplate then
		self:AttachShackleUndead(shackleUndeadTargetNameplate)
		shackleUndeadTargetNameplate = nil
	elseif profile.speculativeAttach then
		for aloftData in Aloft:IterateVisibleNameplates() do
			if aloftData.name == shackleUndeadName then
				self:AttachShackleUndead(aloftData)
				break
			end
		end
		shackleUndeadAttach = true
	end
end

function AloftShackleUndead:ShackleUndeadFinished()
	shackleUndeadName		= nil
	shackleUndeadNameplate	= nil
	shackleUndeadAttach		= false
	shackleUndeadStatusBar:Hide()
	self:CancelScheduledEvent("AloftShackleUndead:Update")
	self:CancelScheduledEvent("PLAYER_REGEN_ENABLED")
end

function AloftShackleUndead:Update()
	local time = -GetTime()
	shackleUndeadStatusBar:SetValue(time)
	if time < shackleUndeadStatusBar:GetMinMaxValues() then
		self:ShackleUndeadFinished()
	end
end

function AloftShackleUndead:AttachShackleUndead(aloftData)
	shackleUndeadAttach = false
	shackleUndeadNameplate = aloftData
	shackleUndeadHealthBarValue = aloftData.healthBarValue
	self:PlaceFrame(shackleUndeadStatusBar, aloftData.healthBar, profile)
	shackleUndeadStatusBar:SetParent(aloftData.nameplateFrame)
	shackleUndeadStatusBar:Show()
	self:ScheduleRepeatingEvent("AloftShackleUndead:Update", self.Update, 0.05, self)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "ShackleUndeadFinished")
	self:Update()
end

function AloftShackleUndead:OnNameplateShow(aloftData)
	if shackleUndeadNameplate or shackleUndeadName ~= aloftData.name then return end

	if shackleUndeadAttach then
		self:AttachShackleUndead(aloftData)
	end
end

function AloftShackleUndead:OnNameplateHide(aloftData)
	if aloftData == shackleUndeadTargetNameplate then
		shackleUndeadTargetNameplate = nil
	elseif aloftData == shackleUndeadNameplate then
		shackleUndeadAttach		= profile.speculativeAttach
		shackleUndeadNameplate	= nil
		shackleUndeadStatusBar:Hide()
		self:CancelScheduledEvent("AloftShackleUndead:Update")
	end
end

function AloftShackleUndead:OnHealthBarValueChanged(aloftData)
	if aloftData == shackleUndeadNameplate then
		if aloftData.healthBarValue ~= shackleUndeadHealthBarValue then
			self:ShackleUndeadFinished()
		end
	end
end

-----------------------------------------------------------------------------
