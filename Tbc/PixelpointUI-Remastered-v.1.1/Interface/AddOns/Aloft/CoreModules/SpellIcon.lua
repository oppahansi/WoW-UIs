-----------------------------------------------------------------------------

local AloftSpellIcon = Aloft:NewModule("SpellIcon", "AceEvent-2.0")
AloftSpellIcon.db = Aloft:AcquireDBNamespace("spellIcon")
Aloft:RegisterDefaults("spellIcon", "profile", {
	enable			= true,
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftSpellIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if aloftData:IsTarget() then
			self:OnCastBarShow(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftSpellIcon:OnInitialize()
	profile = self.db.profile
end

function AloftSpellIcon:OnEnable()
	self:RegisterEvent("Aloft:OnCastBarShow", "OnCastBarShow")
	self:UpdateAll()
end

function AloftSpellIcon:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local spellIconRegion = aloftData.spellIconRegion
		spellIconRegion:ClearAllPoints()
		spellIconRegion:SetPoint("CENTER", aloftData.nameplateFrame, "BOTTOMLEFT", 13.33, 10.29)
		spellIconRegion:SetWidth(14.5)
		spellIconRegion:SetHeight(14.5)
	end
end

function AloftSpellIcon:OnCastBarShow(aloftData)
	if profile.enable then
		self:PlaceFrame(aloftData.spellIconRegion, aloftData.castBar, profile)
	else
		aloftData.spellIconRegion:SetTexture("")
		aloftData.spellIconRegion:SetAlpha(0)
		aloftData.spellIconRegion:Hide()
	end
end

-----------------------------------------------------------------------------
