-----------------------------------------------------------------------------

local AloftLevelText = Aloft:NewModule("LevelText", "AceEvent-2.0")
AloftLevelText.db = Aloft:AcquireDBNamespace("levelText")
Aloft:RegisterDefaults("levelText", "profile", {
	enable				= true,
	font				= "Arial Narrow",
	fontSize			= 8,
	outline				= "OUTLINE",
	shadow				= false,
	point				= "RIGHT",
	relativeToPoint		= "RIGHT",
	offsetX				= 0,
	offsetY				= 0,
	showCreatureType	= false,
	showClassification	= false,
	showRace			= false,
	overrideText		= false,
	format				= "",
})

-----------------------------------------------------------------------------

local textMethod = nil
local textMethodData = { }
local profile

-----------------------------------------------------------------------------

function AloftLevelText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		local levelTextRegion = aloftData.levelTextRegion
	
		if profile.enable then
			if profile.overrideText then
				levelTextRegion:SetText(textMethod(aloftData))
				levelTextRegion:Show()
			else
				levelTextRegion:SetText(aloftData.level or -1)
				if aloftData.level then
					levelTextRegion:Show()
				else
					levelTextRegion:Hide()
				end
			end
		else
			levelTextRegion:Hide()
		end
		self:PrepareText(levelTextRegion, profile)
		self:PlaceFrame(levelTextRegion, aloftData.healthBar, profile)
	end
end

function AloftLevelText:RegisterEvents()
	self:UnregisterAllEvents()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:SetAll", function(type, value)
										if profile[type] then
											profile[type] = value
											self:UpdateAll()
										end
									  end)

	if profile.enable then
		if profile.overrideText then
			for events in pairs(textMethodData.events) do
				self:RegisterEvent(events, "UpdateText")
			end
			self:RegisterEvent("Aloft:OnNameplateShow", "PlaceAndUpdateLevelTextOnNameplateShow")
		else
			self:RegisterEvent("Aloft:OnNameplateShow", "PlaceLevelTextOnNameplateShow")
		end
	else
		self:RegisterEvent("Aloft:OnNameplateShow", "HideLevelTextOnNameplateShow")
	end
end

local dataRequiredList = { }
function AloftLevelText:RequiresData()
	textMethodData = Aloft:CreateTag(profile.format)
	textMethod = textMethodData.method

	self:RegisterEvents()

	if not profile.enable or not profile.overrideText then
		return
	end

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	for data in pairs(textMethodData.data) do
		table.insert(dataRequiredList, data)
	end

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

function AloftLevelText:OnInitialize()
	profile = self.db.profile
end

function AloftLevelText:OnEnable()
	self:UpdateAll()
end

function AloftLevelText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local levelTextRegion = aloftData.levelTextRegion

		levelTextRegion:ClearAllPoints()
		levelTextRegion:SetPoint("CENTER", aloftData.nameplateFrame, "BOTTOMRIGHT", -13.331, 10.288)
		levelTextRegion:SetFont(NAMEPLATE_FONT, 11)		
		levelTextRegion:SetShadowOffset(1, -1)
		levelTextRegion:SetAlpha(1)
		levelTextRegion:SetText(aloftData.level or -1)
	end
end

function AloftLevelText:SetupFrame(aloftData)
	local levelTextRegion = aloftData.levelTextRegion

	self:PrepareText(levelTextRegion, profile)
	self:PlaceFrame(levelTextRegion, aloftData.healthBar, profile)
end

function AloftLevelText:HideLevelTextOnNameplateShow(aloftData)
	aloftData.levelTextRegion:Hide()
end

function AloftLevelText:PlaceLevelTextOnNameplateShow(aloftData)
	self:PlaceFrame(aloftData.levelTextRegion, aloftData.healthBar, profile)
end

function AloftLevelText:UpdateText(aloftData)
	aloftData.levelTextRegion:SetText( textMethod(aloftData) )
end

function AloftLevelText:PlaceAndUpdateLevelTextOnNameplateShow(aloftData)
	local levelTextRegion = aloftData.levelTextRegion
	if aloftData.isBoss then
		levelTextRegion:SetTextColor(1, 0, 0)
	end
	self:PlaceFrame(levelTextRegion, aloftData.healthBar, profile)
	levelTextRegion:Show()
	self:UpdateText(aloftData)
end

-----------------------------------------------------------------------------
