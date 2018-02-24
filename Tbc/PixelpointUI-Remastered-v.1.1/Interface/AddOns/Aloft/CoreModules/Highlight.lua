-----------------------------------------------------------------------------

local SML = AceLibrary("SharedMedia-1.0")

local AloftHighlight = Aloft:NewModule("Highlight", "AceEvent-2.0")
AloftHighlight.db = Aloft:AcquireDBNamespace("highlight")
Aloft:RegisterDefaults("highlight", "profile", {
	color			= { 1, 1, 0, 0.25 },
	texture			= "Blizzard",
	blendMode		= "ADD",
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftHighlight:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do	
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftHighlight:OnInitialize()
	profile = self.db.profile
end

function AloftHighlight:OnEnable()
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

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	
	self:UpdateAll()
end

function AloftHighlight:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local highlightRegion = aloftData.highlightRegion
		highlightRegion:ClearAllPoints()
		highlightRegion:SetAllPoints(aloftData.nameplateFrame)
		highlightRegion:SetTexture("Interface\\Tooltips\\Nameplate-Glow")
		highlightRegion:SetBlendMode("ADD")
		highlightRegion:SetDrawLayer("HIGHLIGHT")
	end
end

function AloftHighlight:OnNameplateShow(aloftData)
	local highlightRegion = aloftData.highlightRegion
	highlightRegion:ClearAllPoints()
	highlightRegion:SetAllPoints(aloftData.healthBar)
end

function AloftHighlight:OnNameplateHide(aloftData)
	-- We do this because WoW leaves lingering highlights if you toggle off nameplate while the mouse is over them
	aloftData.highlightRegion:Hide()
end

function AloftHighlight:SetupFrame(aloftData)
	local highlightRegion = aloftData.highlightRegion

	highlightRegion:ClearAllPoints()
	highlightRegion:SetAllPoints(aloftData.healthBar)
	highlightRegion:SetVertexColor(unpack(profile.color))	
	highlightRegion:SetTexture(SML:Fetch("statusbar", profile.texture))
	highlightRegion:SetBlendMode(profile.blendMode)
	highlightRegion:SetDrawLayer("ARTWORK")
end

-----------------------------------------------------------------------------
