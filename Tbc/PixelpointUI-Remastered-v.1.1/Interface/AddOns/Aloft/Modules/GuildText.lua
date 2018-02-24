-----------------------------------------------------------------------------

local AloftGuildText = Aloft:NewModule("GuildText", "AceEvent-2.0")
AloftGuildText.db = Aloft:AcquireDBNamespace("guildText")
Aloft:RegisterDefaults("guildText", "profile", {
	enable			= false,
	useShort		= true,
	showOwn			= true,
	attachToName	= true,
	attachFormat	= "HYPHEN",
	alpha			= 1,
	point			= "BOTTOMLEFT",
	relativeToPoint	= "TOPLEFT",
	offsetX			= 0,
	offsetY			= 0,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= false,
	outline			= "OUTLINE",
	format			= "[guild]",
	color			= { 1, 1, 1 }
})

-----------------------------------------------------------------------------

local textMethod = nil
local textMethodData = { }
local textRegionPool = { }
local profile

-----------------------------------------------------------------------------

function AloftGuildText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enable then
			if profile.attachToName then
				self:OnNameplateHide(aloftData)
			else
				if aloftData.guildTextRegion then
					self:PrepareText(aloftData.guildTextRegion, profile)
					self:PlaceFrame(aloftData.guildTextRegion, aloftData.healthBar, profile)
				end
				if aloftData:IsShown() then
					self:UpdateText(aloftData)
				end
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

function AloftGuildText:RegisterEvents()
	self:UnregisterAllEvents()
	
	self:RegisterEvent("Aloft:SetAll", function(type, value)
										if profile[type] then
											profile[type] = value
											self:UpdateAll()
										end
									   end)

	if profile.enable then
		if not profile.attachToName then
			self:RegisterEvent("Aloft:OnNameplateShow", "UpdateText")
			self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
			for events in pairs(textMethodData.events) do
				self:RegisterEvent(events, "UpdateText")
			end
		end
	end
end

function AloftGuildText:OnInitialize()
	profile = self.db.profile
end

function AloftGuildText:OnEnable()
	self:UpdateAll()
end

function AloftGuildText:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local guildTextRegion = aloftData.guildTextRegion
		if guildTextRegion then
			guildTextRegion:Hide()
		end
	end
end

local dataRequiredList = { }
function AloftGuildText:RequiresData()
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

-----------------------------------------------------------------------------

function AloftGuildText:UpdateText(aloftData)
    local text = textMethod(aloftData)

    if text ~= "" then 
        -- Check if this nameplate already has a text region assigned to it
        local guildTextRegion = aloftData.guildTextRegion
        if not guildTextRegion then
            guildTextRegion = next(textRegionPool)
            if guildTextRegion then
                -- We have a recycled text region. Text format already setup, just need to place it
                textRegionPool[guildTextRegion] = nil
                guildTextRegion:SetParent(aloftData.nameplateFrame)
                guildTextRegion:Show()
            else
                -- We need a new text region.
                guildTextRegion = aloftData:CreateFontString()
                self:PrepareText(guildTextRegion, profile)
            end
            self:PlaceFrame(guildTextRegion, aloftData.healthBar, profile)
            aloftData.guildTextRegion = guildTextRegion
        end
        guildTextRegion:SetText(text)
    else
        self:OnNameplateHide(aloftData)
    end
end 

function AloftGuildText:OnNameplateHide(aloftData)
    local guildTextRegion = aloftData.guildTextRegion
    if guildTextRegion then
        guildTextRegion:Hide()
        textRegionPool[guildTextRegion] = true
        aloftData.guildTextRegion = nil
    end
end

-----------------------------------------------------------------------------
