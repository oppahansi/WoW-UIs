-----------------------------------------------------------------------------

if not AceLibrary:HasInstance("Threat-1.0") then return end

local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

local AloftThreatBar = Aloft:NewModule("ThreatBar", "AceEvent-2.0")
AloftThreatBar.db = Aloft:AcquireDBNamespace("threatBar")
Aloft:RegisterDefaults("threatBar", "profile", {
	enable					= false,
	texture					= "Blizzard",
	height					= 4,
	maxThreatCommonColor	= { 1, 1, 1, 1 },		-- colors if you have the max threat
	maxThreatMarginColor	= { 0, 1, 0, 1 },
	commonThreatColor		= { 1, 1, 1, 1 },		-- colors if you do not have the max threat
	commonThreatMarginColor	= { 1, 0, 0, 1 },
	offsets =
	{
		left		= 0,
		right		= 0,
		vertical	= -1,
	},
})

-----------------------------------------------------------------------------

local threatBarPool = { }
local profile

-----------------------------------------------------------------------------

function AloftThreatBar:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			if aloftData.threatBar then
				self:PlaceBar(aloftData)
				self:SetupBar(aloftData.threatBar)
			end
			self:Update(aloftData)
		else
			self:ReleaseThreatBar(aloftData)
		end
	end
	if profile.enable then
		for threatBar in pairs(threatBarPool) do
			self:SetupBar(threatBar)
		end
	end
end

-----------------------------------------------------------------------------

function AloftThreatBar:RegisterEvents()
	if profile.enable and Aloft:IsDataAvailable("unitid") then
		self:RegisterEvent("Aloft:OnNameplateShow", "Update")
		self:RegisterEvent("Aloft:OnThreatDataChanged", "Update")
		self:RegisterEvent("Aloft:OnNameplateHide", "ReleaseThreatBar")
	else
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnThreatDataChanged")
		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

function AloftThreatBar:OnInitialize()
	profile = self.db.profile
end

function AloftThreatBar:OnEnable()
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

function AloftThreatBar:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseThreatBar(aloftData)
	end
end

function AloftThreatBar:RequiresData()
	self:RegisterEvents()
	if profile.enable then
		return "threat"
	end
end

function AloftThreatBar:SetupBar(threatBar)
	local texture = SML:Fetch("statusbar", profile.texture)
	
	threatBar.lowerRegion:SetTexture(texture)
	threatBar.upperRegion:SetTexture(texture)
end

function AloftThreatBar:PlaceBar(aloftData)
	local threatBar = aloftData.threatBar
	threatBar:ClearAllPoints()
	threatBar:SetPoint("TOPLEFT", aloftData.healthBar, "BOTTOMLEFT", profile.offsets.left, profile.offsets.vertical)
	threatBar:SetPoint("BOTTOMRIGHT", aloftData.healthBar, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical-profile.height)
	threatBar:SetFrameLevel(0)
	threatBar:Show()
end

function AloftThreatBar:AcquireThreatBar(aloftData)
	local threatBar = aloftData.threatBar
	if not threatBar then
		threatBar = next(threatBarPool)
		if threatBar then
			threatBarPool[threatBar] = nil
			threatBar:SetParent(aloftData.nameplateFrame)
		else
			threatBar = CreateFrame("Frame", nil, aloftData.nameplateFrame)
			
			local lowerRegion = threatBar:CreateTexture(nil, "OVERLAY")
			lowerRegion:ClearAllPoints()
			lowerRegion:SetPoint("TOPLEFT", threatBar, "TOPLEFT")
			lowerRegion:SetPoint("BOTTOMLEFT", threatBar, "BOTTOMLEFT")
			threatBar.lowerRegion = lowerRegion
			
			local upperRegion = threatBar:CreateTexture(nil, "OVERLAY")
			upperRegion:ClearAllPoints()
			upperRegion:SetPoint("TOPRIGHT", threatBar, "TOPRIGHT")
			upperRegion:SetPoint("BOTTOMRIGHT", threatBar, "BOTTOMRIGHT")
			threatBar.upperRegion = upperRegion

			self:SetupBar(threatBar)
		end
		aloftData.threatBar = threatBar
		self:PlaceBar(aloftData)
	end
	return threatBar
end

function AloftThreatBar:ReleaseThreatBar(aloftData)
	local threatBar = aloftData.threatBar
	if threatBar then
		threatBar:Hide()
		threatBarPool[threatBar] = true
		aloftData.threatBar = nil
	end
end

function AloftThreatBar:Update(aloftData)
	local threat = aloftData.threat
	local threatMax = aloftData.threatMax or 0
	if threat and (threat > 0 or threatMax > 0) then
		local threatBar = self:AcquireThreatBar(aloftData)
		local lowerRegion = threatBar.lowerRegion
		local upperRegion = threatBar.upperRegion
		local width = threatBar:GetWidth()
		
		if threat > threatMax then
			local lowerRegionWidth = width * threatMax / threat
			if lowerRegionWidth == 0 then
				lowerRegion:Hide()
			else
				lowerRegion:SetWidth(lowerRegionWidth)
				lowerRegion:SetVertexColor(unpack(profile.maxThreatCommonColor))
				lowerRegion:Show()
			end

			local upperRegionWidth = width - lowerRegionWidth
			if upperRegionWidth == 0 then
				upperRegion:Hide()
			else
				upperRegion:SetWidth(upperRegionWidth)
				upperRegion:SetVertexColor(unpack(profile.maxThreatMarginColor))
				upperRegion:Show()
			end
		elseif threatMax > threat then
			local lowerRegionWidth = width * threat / threatMax
			if lowerRegionWidth == 0 then
				lowerRegion:Hide()
			else
				lowerRegion:SetWidth(lowerRegionWidth)
				lowerRegion:SetVertexColor(unpack(profile.commonThreatColor))
				lowerRegion:Show()
			end

			local upperRegionWidth = width - lowerRegionWidth
			if upperRegionWidth == 0 then
				upperRegion:Hide()
			else
				upperRegion:SetWidth(upperRegionWidth)
				upperRegion:SetVertexColor(unpack(profile.commonThreatMarginColor))
				upperRegion:Show()
			end
		else
			lowerRegion:SetWidth(width)
			lowerRegion:SetVertexColor(unpack(profile.maxThreatCommonColor))
			lowerRegion:Show()
			upperRegion:Hide()
		end
	else
		self:ReleaseThreatBar(aloftData)
	end
end

-----------------------------------------------------------------------------
