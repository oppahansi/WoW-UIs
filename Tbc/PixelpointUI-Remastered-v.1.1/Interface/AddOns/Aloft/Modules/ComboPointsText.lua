-----------------------------------------------------------------------------

local _, playerClass = UnitClass("player")
if playerClass ~= "ROGUE" and playerClass ~= "DRUID" then return end

-----------------------------------------------------------------------------

local AloftComboPointsText = Aloft:NewModule("ComboPointsText", "AceEvent-2.0")
AloftComboPointsText.db = Aloft:AcquireDBNamespace("comboPointsText")
Aloft:RegisterDefaults("comboPointsText", "profile", {
	enable			= true,
	font			= "Arial Narrow",
	fontSize		= 16,
	shadow			= true,
	outline			= "THICKOUTLINE",
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	color			= { 1, 1, 1, 1 }
})

-----------------------------------------------------------------------------

local comboPointsTextRegion = nil
local targetNameplate = nil
local profile

-----------------------------------------------------------------------------

function AloftComboPointsText:Update()
	self:CreateFrame()
	self:RegisterEvents()
	
	if profile.enable then
		if targetNameplate then
			self:PlaceFrame(comboPointsTextRegion, targetNameplate.healthBar, profile)
		end
	end
end

-----------------------------------------------------------------------------

function AloftComboPointsText:CreateFrame()
	if not profile.enable then
		if comboPointsTextRegion then
			comboPointsTextRegion:Hide()
		end
		return
	end

	if not comboPointsTextRegion then
		comboPointsTextRegion = UIParent:CreateFontString()
	end
	
	self:PrepareText(comboPointsTextRegion, profile)
end

function AloftComboPointsText:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateTarget")
		self:RegisterEvent("PLAYER_COMBO_POINTS", "UpdateText")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	else
		self:CancelEvent("PLAYER_TARGET_CHANGED")
		self:CancelEvent("PLAYER_COMBO_POINTS")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

-----------------------------------------------------------------------------

function AloftComboPointsText:OnInitialize()
	profile = self.db.profile
end

function AloftComboPointsText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:Update()
		end
	end)
	
	self:Update()
end

function AloftComboPointsText:OnDisable()
	self:UnregisterAllEvents()
	
	if comboPointsTextRegion then
		comboPointsTextRegion:Hide()
	end
end

function AloftComboPointsText:OnNameplateShow(aloftData)
	if not targetNameplate and aloftData:IsTarget() then
		targetNameplate = aloftData
	
		self:PlaceFrame(comboPointsTextRegion, aloftData.healthBar, profile)
		comboPointsTextRegion:SetParent(aloftData.nameplateFrame)
		comboPointsTextRegion:Show()
	end
end

function AloftComboPointsText:OnNameplateHide(aloftData)
	if targetNameplate == aloftData then
		targetNameplate = nil
		comboPointsTextRegion:Hide()
	end
end

function AloftComboPointsText:UpdateText()
	local comboPoints = GetComboPoints()

	local newTargetNameplate = Aloft:GetTargetNameplate()
	
	if newTargetNameplate and newTargetNameplate ~= targetNameplate then
		targetNameplate = newTargetNameplate
	
		self:PlaceFrame(comboPointsTextRegion, targetNameplate.healthBar, profile)
		comboPointsTextRegion:SetParent(targetNameplate.nameplateFrame)
	end

	if comboPoints > 0 then
		comboPointsTextRegion:SetText(comboPoints)
		comboPointsTextRegion:Show()
	else
		comboPointsTextRegion:SetText("")
		comboPointsTextRegion:Hide()
	end
end

function AloftComboPointsText:UpdateTarget()
	if GetComboPoints() > 0 then 
		self:UpdateText()
	end
end

-----------------------------------------------------------------------------
