-----------------------------------------------------------------------------

local AloftBossIcon = Aloft:NewModule("BossIcon", "AceEvent-2.0")
AloftBossIcon.db = Aloft:AcquireDBNamespace("bossIcon")
Aloft:RegisterDefaults("bossIcon", "profile", {
	enable			= true,
	alpha			= 1.0,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftBossIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do	
		self:PlaceFrame(aloftData.bossIconRegion, aloftData.healthBar, profile)
	end
end

-----------------------------------------------------------------------------

function AloftBossIcon:OnInitialize()
	profile = self.db.profile
end

function AloftBossIcon:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:UpdateAll()
end

function AloftBossIcon:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local bossIconRegion = aloftData.bossIconRegion
		
		bossIconRegion:ClearAllPoints()
		bossIconRegion:SetPoint("CENTER", aloftData.levelTextFrame, "CENTER")
		bossIconRegion:SetWidth(14.5)
		bossIconRegion:SetHeight(14.5)
		bossIconRegion:SetAlpha(1)
		bossIconRegion:SetDrawLayer("ARTWORK")
	end
end

function AloftBossIcon:SetupFrame(aloftData)
	self:PlaceFrame(aloftData.bossIconRegion, aloftData.healthBar, profile)
	aloftData.bossIconRegion:SetDrawLayer("OVERLAY")
end

-----------------------------------------------------------------------------
