-----------------------------------------------------------------------------

local AloftCastBarOverlay = Aloft:NewModule("CastBarOverlay", "AceEvent-2.0")

-----------------------------------------------------------------------------

function AloftCastBarOverlay:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do	
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftCastBarOverlay:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:UpdateAll()
end

function AloftCastBarOverlay:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local castBarOverlayRegion = aloftData.castBarOverlayRegion

		castBarOverlayRegion:ClearAllPoints()
		castBarOverlayRegion:SetPoint("CENTER", aloftData.nameplateFrame, "CENTER", 0, -16)
		castBarOverlayRegion:SetTexture("Interface\\Tooltips\\Nameplate-Border")
		castBarOverlayRegion:SetTexCoord(0.0, 1.0, 1.0, 1.0)
		castBarOverlayRegion:SetAlpha(1)
		castBarOverlayRegion:SetWidth(128)
		castBarOverlayRegion:SetHeight(32)
	end
end

function AloftCastBarOverlay:SetupFrame(aloftData)
	aloftData.castBarOverlayRegion:SetTexture("")
end

-----------------------------------------------------------------------------
