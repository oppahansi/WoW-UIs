-----------------------------------------------------------------------------

local AloftCommentText = Aloft:NewModule("CommentText", "AceEvent-2.0")
AloftCommentText.db = Aloft:AcquireDBNamespace("commentText")
Aloft:RegisterDefaults("commentText", "profile", {
	enable			= false,
	alpha			= 1,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= -10,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= false,
	outline			= "OUTLINE",
	format			= "[comment]",
	color			= { 1, 1, 1 }
})

-----------------------------------------------------------------------------

local textMethod = nil
local textMethodData = { }
local textRegionPool = { }
local profile

-----------------------------------------------------------------------------

function AloftCommentText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enable then
			if aloftData.commentRegion then
				self:PrepareText(aloftData.commentRegion, profile)
				self:PlaceFrame(aloftData.commentRegion, aloftData.healthBar, profile)
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

function AloftCommentText:UpdateTag()
	if profile.enable then 
		profile.format = "[comment]"
	else
		profile.format = ""
	end

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------

function AloftCommentText:RegisterEvents()
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
function AloftCommentText:RequiresData()
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

function AloftCommentText:OnInitialize()
	profile = self.db.profile
end

function AloftCommentText:OnEnable()
	self:UpdateAll()
end

function AloftCommentText:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateNameplates() do
		local commentRegion = aloftData.commentRegion
		if commentRegion then
			commentRegion:Hide()
		end
	end
end

function AloftCommentText:UpdateText(aloftData)
	local text = textMethod(aloftData)

	if text ~= "" then
		-- Check if this nameplate already has a text region assigned to it
		local commentRegion = aloftData.commentRegion
		if not commentRegion then
			commentRegion = next(textRegionPool)
			if commentRegion then
				-- We have a recycled text region. Text format already setup, just need to place it
				textRegionPool[commentRegion] = nil
				commentRegion:SetParent(aloftData.nameplateFrame)
				commentRegion:Show()
			else
				-- We need a new text region.
				commentRegion = aloftData:CreateFontString()
				self:PrepareText(commentRegion, profile)
			end
			self:PlaceFrame(commentRegion, aloftData.healthBar, profile)
			aloftData.commentRegion = commentRegion
		end
		commentRegion:SetText(text)
	else
		self:OnNameplateHide(aloftData)
	end
end

function AloftCommentText:OnNameplateHide(aloftData)
	local commentRegion = aloftData.commentRegion
	if commentRegion then
		commentRegion:Hide()
		textRegionPool[commentRegion] = true
		aloftData.commentRegion = nil
	end
end

-----------------------------------------------------------------------------
