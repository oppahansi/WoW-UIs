-----------------------------------------------------------------------------

local AloftOverlay = Aloft:NewModule("Overlay", "AceEvent-2.0")

-----------------------------------------------------------------------------

function AloftOverlay:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do	
		aloftData.overlayRegion:Hide()
	end
end

-----------------------------------------------------------------------------

function AloftOverlay:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:UpdateAll()
end

function AloftOverlay:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local overlayRegion = aloftData.overlayRegion
		overlayRegion:ClearAllPoints()
		overlayRegion:SetAllPoints(aloftData.nameplateFrame)
		overlayRegion:SetTexture("Interface\\Tooltips\\Nameplate-Border")
		overlayRegion:SetVertexColor(1.0, 1.0, 1.0, 1.0)
		overlayRegion:SetTexCoord(0.0, 1.0, 0.0, 1.0)
		overlayRegion:Show()
	end
end

function AloftOverlay:SetupFrame(aloftData)
	aloftData.overlayRegion:Hide()
end

-----------------------------------------------------------------------------
