-----------------------------------------------------------------------------

local spellNameTextRegion = nil

-----------------------------------------------------------------------------

local AloftSpellNameText = Aloft:NewModule("SpellNameText", "AceEvent-2.0")
AloftSpellNameText.db = Aloft:AcquireDBNamespace("spellNameText")
Aloft:RegisterDefaults("spellNameText", "profile", {
	enable			= true,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= true,
	alignment		= "LEFT",
	outline			= "",
	offsets =
	{
		left		= 0,
		right		= 0,
		vertical	= 0,
	},
	color			= { 1, 1, 1, 1 }
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftSpellNameText:Update()
	self:CreateFrame()
	self:RegisterEvents()
	
	if profile.enable then
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:SetupFrame(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftSpellNameText:CreateFrame()
	if not profile.enable then
		if spellNameTextRegion then
			spellNameTextRegion:Hide()
		end
		return
	end

	if not spellNameTextRegion then
		spellNameTextRegion = UIParent:CreateFontString()
	end
	
	self:PrepareText(spellNameTextRegion, profile)

end

function AloftSpellNameText:RegisterEvents()
	if profile.enable then	
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnCastBarValueChanged", "UpdateText")
		self:RegisterEvent("Aloft:OnCastBarShow", "OnCastBarShow")
		self:RegisterEvent("Aloft:OnCastBarHide", "OnCastBarHide")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnCastBarValueChanged")
		self:CancelEvent("Aloft:OnCastBarShow")
		self:CancelEvent("Aloft:OnCastBarHide")
	end
end

-----------------------------------------------------------------------------

function AloftSpellNameText:GetTargetSpellName()
	local _, _, displayName = UnitCastingInfo("target")
	if displayName then
		return displayName
	end
	_, _, displayName = UnitChannelInfo("target")
	if displayName then
		return displayName
	end
	return ""
end

-----------------------------------------------------------------------------

function AloftSpellNameText:OnInitialize()
	profile = self.db.profile
end

function AloftSpellNameText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:Update()
		end
	end)
	
	self:Update()
end

function AloftSpellNameText:OnDisable()
	self:UnregisterAllEvents()
	
	if spellNameTextRegion then
		spellNameTextRegion:Hide()
	end
end

function AloftSpellNameText:SetupFrame(aloftData)
	if aloftData:IsTarget() then
		self:OnCastBarShow(aloftData)
	end	
end

function AloftSpellNameText:UpdateText(aloftData)
	local castBar = aloftData.castBar
	
	if aloftData.castBarStartTime ~= castBar:GetMinMaxValues() then
		spellNameTextRegion:SetText(self:GetTargetSpellName())
	end
end

function AloftSpellNameText:OnCastBarShow(aloftData)
	local castBar = aloftData.castBar

	spellNameTextRegion:SetText(self:GetTargetSpellName())
	spellNameTextRegion:ClearAllPoints()
	spellNameTextRegion:SetPoint("TOPLEFT", castBar, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
	spellNameTextRegion:SetPoint("BOTTOMRIGHT", castBar, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
	spellNameTextRegion:SetAlpha(1.0)
	spellNameTextRegion:SetParent(aloftData.nameplateFrame)
	spellNameTextRegion:Show()

	aloftData.castBarStartTime = castBar:GetMinMaxValues()

	self:ScheduleRepeatingEvent("AloftSpellNameText:UpdateAlpha", self.UpdateAlpha, 0.1, self, aloftData.castBar)
end

function AloftSpellNameText:OnCastBarHide(aloftData)
	self:CancelScheduledEvent("AloftSpellNameText:UpdateAlpha")
	spellNameTextRegion:Hide()
end

function AloftSpellNameText:UpdateAlpha(castBar)
	local _, _, _, a = castBar:GetStatusBarColor()
	spellNameTextRegion:SetAlpha(a)
end

-----------------------------------------------------------------------------
