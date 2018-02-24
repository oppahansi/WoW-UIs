-----------------------------------------------------------------------------

local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

local AloftManaText = Aloft:NewModule("ManaText", "AceEvent-2.0")
AloftManaText.db = Aloft:AcquireDBNamespace("manaText")
Aloft:RegisterDefaults("manaText", "profile", {
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

function AloftManaText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enable then
			if aloftData.manaTextRegion then
				self:PrepareText(aloftData.manaTextRegion, profile)
				self:PlaceFrame(aloftData.manaTextRegion, aloftData.healthBar, profile)
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

function AloftManaText:RegisterEvents()
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
function AloftManaText:RequiresData()
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

function AloftManaText:OnInitialize()
	profile = self.db.profile
end

function AloftManaText:OnEnable()
	self:UpdateAll()
end

function AloftManaText:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
end

function AloftManaText:UpdateText(aloftData)
    local text = textMethod(aloftData)
            
    if text ~= "" then
        -- Check if this nameplate already has a text region assigned to it
        local manaTextRegion = aloftData.manaTextRegion
        if not manaTextRegion then
            manaTextRegion = next(textRegionPool)
            if manaTextRegion then
                -- We have a recycled text region. Text format already setup, just need to place it
                textRegionPool[manaTextRegion] = nil
                manaTextRegion:SetParent(aloftData.nameplateFrame)
                manaTextRegion:Show()
            else
                -- We need a new text region.
                manaTextRegion = aloftData:CreateFontString()
                self:PrepareText(manaTextRegion, profile)
            end
            self:PlaceFrame(manaTextRegion, aloftData.healthBar, profile)
            aloftData.manaTextRegion = manaTextRegion
        end
        manaTextRegion:SetText(text)
    else
        self:OnNameplateHide(aloftData)
    end
end

function AloftManaText:OnNameplateHide(aloftData)
    local manaTextRegion = aloftData.manaTextRegion
    if manaTextRegion then
        manaTextRegion:Hide()
        textRegionPool[manaTextRegion] = true
        aloftData.manaTextRegion = nil
    end
end

-----------------------------------------------------------------------------
