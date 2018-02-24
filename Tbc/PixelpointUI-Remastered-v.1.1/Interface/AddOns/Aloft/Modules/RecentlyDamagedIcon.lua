-----------------------------------------------------------------------------

local AloftRecentlyDamagedIcon = Aloft:NewModule("RecentlyDamagedIcon", "AceEvent-2.0")
AloftRecentlyDamagedIcon.db = Aloft:AcquireDBNamespace("recentlyDamagedIcon")
Aloft:RegisterDefaults("recentlyDamagedIcon", "profile", {
	enable			= false,
	alpha			= 1.0,
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enable then
			self:SetupFrame(aloftData)
			self:Update(aloftData)
		else
			local recentlyDamagedIconRegion = aloftData.recentlyDamagedIconRegion
			if recentlyDamagedIconRegion then
				recentlyDamagedIconRegion:Hide()
			end
		end
	end

	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnNameplateShow", "Update")
		self:RegisterEvent("Aloft:OnRecentlyDamagedChanged", "Update")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnRecentlyDamagedChanged")
	end
end

function AloftRecentlyDamagedIcon:OnInitialize()
	profile = self.db.profile
end

function AloftRecentlyDamagedIcon:OnEnable()
	self:UpdateAll()
end

function AloftRecentlyDamagedIcon:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local recentlyDamagedIconRegion = aloftData.recentlyDamagedIconRegion
		if recentlyDamagedIconRegion then
			recentlyDamagedIconRegion:Hide()
		end
	end
end

function AloftRecentlyDamagedIcon:RequiresData()
	if profile.enable then 
		return "recentlyDamaged"
	end
end

function AloftRecentlyDamagedIcon:SetupFrame(aloftData)
	local recentlyDamagedIconRegion = aloftData.recentlyDamagedIconRegion
	
	if not recentlyDamagedIconRegion then
		recentlyDamagedIconRegion = aloftData:CreateTexture()
		recentlyDamagedIconRegion:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
		recentlyDamagedIconRegion:SetTexCoord(0.5, 1, 0, 0.5)
		aloftData.recentlyDamagedIconRegion = recentlyDamagedIconRegion
	end
	
	self:PlaceFrame(recentlyDamagedIconRegion, aloftData.healthBar, profile)
end

function AloftRecentlyDamagedIcon:Update(aloftData)
	local recentlyDamagedIconRegion = aloftData.recentlyDamagedIconRegion

	if aloftData.recentlyDamaged then
		recentlyDamagedIconRegion:Show()
	else
		recentlyDamagedIconRegion:Hide()
	end
end

-----------------------------------------------------------------------------
