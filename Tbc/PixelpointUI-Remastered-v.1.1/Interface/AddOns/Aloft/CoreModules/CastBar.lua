-----------------------------------------------------------------------------

local SML = AceLibrary("SharedMedia-1.0")

local AloftCastBar = Aloft:NewModule("CastBar", "AceEvent-2.0")
AloftCastBar.db = Aloft:AcquireDBNamespace("castBar")
Aloft:RegisterDefaults("castBar", "profile", {
	offsets =
	{
		left		= 12,
		right		= 0,
		vertical	= -1,
	},
	height			= 10,
	texture			= "Blizzard",
	backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftCastBar:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnCastBarShow(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftCastBar:OnInitialize()
	profile = self.db.profile
end

function AloftCastBar:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnCastBarShow", "OnCastBarShow")
	self:RegisterEvent("Aloft:OnCastBarHide", "OnCastBarHide")

	self:RegisterEvent("SharedMedia_SetGlobal", function(mediatype, override)
		if mediatype == "statusbar" then
			self:UpdateAll()
		end
	end)

	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)
	
	self:UpdateAll()
end

local backdropTable = { }

function AloftCastBar:OnDisable()
	self:UnregisterAllEvents()

	backdropTable.bgFile = ""

	for aloftData in Aloft:IterateNameplates() do
		local castBar = aloftData.castBar
	
		castBar:ClearAllPoints()
		castBar:SetPoint("BOTTOMRIGHT", aloftData.castBarOverlayRegion, "BOTTOMRIGHT", -4.5, 4.5)
		castBar:SetWidth(116.5)
		castBar:SetHeight(10.18)
		castBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		castBar:SetBackdrop(backdropTable)
		castBar:SetBackdropColor(0, 0, 0, 0)
	end
end

function AloftCastBar:SetupFrame(aloftData)
	local castBar = aloftData.castBar
	
	local texture = SML:Fetch("statusbar", profile.texture)
	castBar:SetStatusBarTexture(texture)

	backdropTable.bgFile = texture
	castBar:SetBackdrop(backdropTable)
	castBar:SetBackdropColor(unpack(profile.backdropColor))

	-- This manipulates the castbar background to always display above the frame background
	local barRegion, backgroundRegion = castBar:GetRegions()
	barRegion:SetDrawLayer("OVERLAY")
	backgroundRegion:SetDrawLayer("ARTWORK")
end

function AloftCastBar:OnCastBarShow(aloftData)
	local castBar = aloftData.castBar
	local healthBar = aloftData.healthBar

	castBar:ClearAllPoints()
	castBar:SetPoint("TOPLEFT", healthBar, "BOTTOMLEFT", profile.offsets.left, profile.offsets.vertical)
	castBar:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical - profile.height)
	castBar:SetAlpha(1.0)
	
	self:UpdateAlpha(castBar)
	self:ScheduleRepeatingEvent("AloftCastBar:UpdateAlpha", self.UpdateAlpha, 0.1, self, aloftData.castBar)
end

function AloftCastBar:OnCastBarHide(aloftData)
	self:CancelScheduledEvent("AloftCastBar:UpdateAlpha")
end

function AloftCastBar:UpdateAlpha(castBar)
	local r, g, b, a = unpack(profile.backdropColor)
	local _, _, _, castBarAlpha = castBar:GetStatusBarColor()
	a = a * castBarAlpha
	castBar:SetBackdropColor(r, g, b, a)
end

-----------------------------------------------------------------------------
