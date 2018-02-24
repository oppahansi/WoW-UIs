-----------------------------------------------------------------------------

local AloftRaidIcon = Aloft:NewModule("RaidIcon", "AceEvent-2.0")
AloftRaidIcon.db = Aloft:AcquireDBNamespace("raidIcon")
Aloft:RegisterDefaults("raidIcon", "profile", {
	enable			= true,
	alpha			= 0.75,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= 0,
	size			= 32
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftRaidIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:PlaceFrame(aloftData.raidIconRegion, aloftData.healthBar, profile)
	end
end

-----------------------------------------------------------------------------

function AloftRaidIcon:OnInitialize()
	profile = self.db.profile
end

function AloftRaidIcon:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:UpdateAll()
end

function AloftRaidIcon:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local raidIconRegion = aloftData.raidIconRegion
		raidIconRegion:ClearAllPoints()
		raidIconRegion:SetPoint("RIGHT", aloftData.nameplateFrame, "LEFT")
		raidIconRegion:SetWidth(29)
		raidIconRegion:SetHeight(29)
		raidIconRegion:SetAlpha(1)
		raidIconRegion:SetDrawLayer("ARTWORK")
	end
end

function AloftRaidIcon:SetupFrame(aloftData)
	self:PlaceFrame(aloftData.raidIconRegion, aloftData.healthBar, profile)
	aloftData.raidIconRegion:SetDrawLayer("OVERLAY")
end

-----------------------------------------------------------------------------
