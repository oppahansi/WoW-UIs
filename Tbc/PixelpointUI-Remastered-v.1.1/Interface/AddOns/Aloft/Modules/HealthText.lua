-----------------------------------------------------------------------------

local AloftHealthText = Aloft:NewModule("HealthText", "AceEvent-2.0")
AloftHealthText.db = Aloft:AcquireDBNamespace("healthText")
Aloft:RegisterDefaults("healthText", "profile", {
	enable			= false,
	alpha			= 1,
	point			= "RIGHT",
	relativeToPoint	= "RIGHT",
	offsetX			= 0,
	offsetY			= 0,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= false,
	outline			= "OUTLINE",
	mode			= "PERCENT",
	format			= "",
	color			= { 1, 1, 1 }
})

-----------------------------------------------------------------------------

local textMethod = nil
local textMethodData = { }
local textRegionPool = { }
local profile

-----------------------------------------------------------------------------

function AloftHealthText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enable then
			if aloftData.healthTextRegion then
				self:PrepareText(aloftData.healthTextRegion, profile)
				self:PlaceFrame(aloftData.healthTextRegion, aloftData.healthBar, profile)
			end
			if aloftData:IsShown() then
				self:UpdateText(aloftData)
			end
		else
			self:OnNameplateHide(aloftData)
		end
	end
	for textRegion in pairs(textRegionPool) do
		self:PrepareText(textRegion, profile)
	end
end

-----------------------------------------------------------------------------

function AloftHealthText:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)
	
	if profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "UpdateText")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")

		for events in pairs(textMethodData.events) do
			self:RegisterEvent(events, "UpdateText")
		end
	end
end

local dataRequiredList = { }
function AloftHealthText:RequiresData()
	textMethodData = Aloft:CreateTag(profile.format)
	textMethod = textMethodData.method

	self:RegisterEvents()

	if not profile.enable then
		return
	end

	for i=1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	for data in pairs(textMethodData.data) do
		table.insert(dataRequiredList, data)
	end

	return unpack(dataRequiredList)
end

function AloftHealthText:OnInitialize()
	profile = self.db.profile
end

function AloftHealthText:OnEnable()
	self:UpdateAll()
end

function AloftHealthText:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local healthTextRegion = aloftData.healthTextRegion
		if healthTextRegion then
			healthTextRegion:Hide()
		end
	end
end

function AloftHealthText:UpdateText(aloftData)
    local text = textMethod(aloftData)
            
    if text ~= "" then
        -- Check if this nameplate already has a text region assigned to it
        local healthTextRegion = aloftData.healthTextRegion
        if not healthTextRegion then
            healthTextRegion = next(textRegionPool)
            if healthTextRegion then
                -- We have a recycled text region. Text format already setup, just need to place it
                textRegionPool[healthTextRegion] = nil
                healthTextRegion:SetParent(aloftData.nameplateFrame)
                healthTextRegion:Show()
            else
                -- We need a new text region.
                healthTextRegion = aloftData:CreateFontString()
                self:PrepareText(healthTextRegion, profile)
            end
            self:PlaceFrame(healthTextRegion, aloftData.healthBar, profile)
            aloftData.healthTextRegion = healthTextRegion
        end
        healthTextRegion:SetText(text)
    else
        self:OnNameplateHide(aloftData)
    end
end

function AloftHealthText:OnNameplateHide(aloftData)
    local healthTextRegion = aloftData.healthTextRegion
    if healthTextRegion then
        healthTextRegion:Hide()
        textRegionPool[healthTextRegion] = true
        aloftData.healthTextRegion = nil
    end
end

-----------------------------------------------------------------------------
