-----------------------------------------------------------------------------

local AloftNameText = Aloft:NewModule("NameText", "AceEvent-2.0")
AloftNameText.db = Aloft:AcquireDBNamespace("nameText")
Aloft:RegisterDefaults("nameText", "profile", {
	enable			= true,
	useAliases		= false,
	font			= "Arial Narrow",
	fontSize		= 10,
	format			= "[name]",
	shadow			= false,
	alignment		= "LEFT",
	outline			= "OUTLINE",
	offsets =
	{
		left		= 0,
		right		= 0,
		vertical	= 0,
	},
	overrideColors		= true,
	colorByClass		= false,
	colorHostileByClass	= false,
	colors =
	{
		friendlyPlayer	= { 1, 1, 1 },
		friendlyPet		= { 1, 1, 1 },
		friendlyNPC		= { 1, 1, 1 },
		friendlyBoss	= { 1, 1, 1 },
		hostilePlayer	= { 1, 1, 1 },
		hostilePet		= { 1, 1, 1 },
		hostileNPC		= { 1, 1, 1 },
		hostileBoss		= { 1, 1, 1 },
		neutral			= { 1, 1, 1 },
		pet				= { 1, 1, 1 },
		groupPet		= { 1, 1, 1 },
	},
})

-----------------------------------------------------------------------------

local textMethod = nil
local textMethodData = { }
local profile

-----------------------------------------------------------------------------

function AloftNameText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end

	if profile.enable then
		for aloftData in Aloft:IterateVisibleNameplates() do
			if profile.overrideColors then
				self:UpdateText(aloftData)
			else
				self:UpdateTextNone(aloftData)
			end
		end
	end
end

function AloftNameText:RegisterEvents()
	self:UnregisterAllEvents()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)
	
	if profile.enable and profile.overrideColors then
		local updateTextMethod = "UpdateTextSimple"
		if not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.friendlyPet) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.friendlyBoss) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostilePlayer) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostilePet) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostileNPC) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostileBoss) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.neutral) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.pet) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.groupPet) or
		   profile.colorByClass or
		   profile.colorHostileByClass then
			updateTextMethod = "UpdateText"
		end

		self:RegisterEvent("Aloft:OnNameplateShow", updateTextMethod)
		self:RegisterEvent("Aloft:OnHealthBarColorChanged", updateTextMethod)

		if profile.colorByClass or profile.colorHostileByClass then
			self:RegisterEvent("Aloft:OnClassDataChanged", updateTextMethod)
		end

		if not self:IsArrayEqual(profile.colors.friendlyPet, profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(profile.colors.hostilePet, profile.colors.hostileNPC) then
			self:RegisterEvent("Aloft:OnIsPetDataChanged", updateTextMethod)
		end

		for events in pairs(textMethodData.events) do
			self:RegisterEvent(events, updateTextMethod)
		end
	else
		if profile.enable then
			self:RegisterEvent("Aloft:OnNameplateShow", "UpdateTextNone")

			for events in pairs(textMethodData.events) do
				self:RegisterEvent(events, "UpdateTextNone")
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftNameText:OnInitialize()
	profile = self.db.profile
end

function AloftNameText:OnEnable()
	self:UpdateAll()
end

function AloftNameText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local nameTextRegion = aloftData.nameTextRegion

		nameTextRegion:ClearAllPoints()
		nameTextRegion:SetPoint("BOTTOM", aloftData.nameplateFrame, "CENTER")
		nameTextRegion:SetFont(NAMEPLATE_FONT, 14.5)		
		nameTextRegion:SetText(aloftData.name)
		nameTextRegion:SetShadowOffset(1, -1)
		nameTextRegion:Show()
	end
end

local dataRequiredList = { }
function AloftNameText:RequiresData()
	textMethodData = Aloft:CreateTag(profile.format)
	textMethod = textMethodData.method
	
	self:RegisterEvents()
	
	if not profile.enable then
		return
	end

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if profile.colorByClass or
	   profile.colorHostileByClass or
	   not self:IsArrayEqual(profile.colors.hostileNPC, profile.colors.hostilePlayer) then
		table.insert(dataRequiredList, "class")
	end

	if not self:IsArrayEqual(profile.colors.friendlyPet, profile.colors.friendlyNPC) or
	   not self:IsArrayEqual(profile.colors.hostilePet, profile.colors.hostileNPC) then
		table.insert(dataRequiredList, "isPet")
	end

	if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(profile.colors.friendlyPet, profile.colors.groupPet) then
		table.insert(dataRequiredList, "unitid")
	end

	for data in pairs(textMethodData.data) do
		table.insert(dataRequiredList, data)
	end
	
	return unpack(dataRequiredList)
end

function AloftNameText:SetupFrame(aloftData)
	local nameTextRegion = aloftData.nameTextRegion
	local healthBar = aloftData.healthBar

	nameTextRegion:ClearAllPoints()
	nameTextRegion:SetPoint("TOPLEFT", healthBar, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
	nameTextRegion:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
	self:PrepareText(nameTextRegion, profile)

	if profile.enable then
		nameTextRegion:Show()
	else
		nameTextRegion:Hide()
	end
end

-----------------------------------------------------------------------------

function AloftNameText:SetTextColor(aloftData, color)
	aloftData.nameTextRegion:SetText(("|cff%02x%02x%02x%s"):format(color[1]*255, color[2]*255, color[3]*255, textMethod(aloftData)))
end

function AloftNameText:SetTextColorRgb(aloftData, color)
	aloftData.nameTextRegion:SetText(("|cff%02x%02x%02x%s"):format(color.r*255, color.g*255, color.b*255, textMethod(aloftData)))
end

-----------------------------------------------------------------------------

function AloftNameText:UpdateTextSimple(aloftData)
	if profile.colorByClass and aloftData.class then
		local color = RAID_CLASS_COLORS[aloftData.class]
		
		if color then
			self:SetTextColorRgb(aloftData, color)
			return
		end
	end
	
	self:SetTextColor(aloftData, profile.colors.friendlyPlayer)
end

-----------------------------------------------------------------------------

function AloftNameText:ColourFriendlyPlayer(aloftData)
	if profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = RAID_CLASS_COLORS[class]
			if color then
				self:SetTextColorRgb(aloftData, color)
				return
			end
		end
	end
	self:SetTextColor(aloftData, profile.colors.friendlyPlayer)
end

function AloftNameText:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetTextColor(aloftData, profile.colors.pet)
	elseif aloftData.unitid then
		self:SetTextColor(aloftData, profile.colors.groupPet)
	elseif aloftData.isPet then
		self:SetTextColor(aloftData, profile.colors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetTextColor(aloftData, profile.colors.friendlyBoss)
	else
		self:SetTextColor(aloftData, profile.colors.friendlyNPC)
	end
end

function AloftNameText:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	if profile.colorHostileByClass then
		local class = aloftData.class
		if class then
			local color = RAID_CLASS_COLORS[class]
			if color then
				self:SetTextColorRgb(aloftData, color)
				return
			end
		end
	end

	if aloftData.class then
		self:SetTextColor(aloftData, profile.colors.hostilePlayer)
	elseif aloftData.isPet then
		self:SetTextColor(aloftData, profile.colors.hostilePet)
	elseif aloftData.isBoss then
		self:SetTextColor(aloftData, profile.colors.hostileBoss)
	else
		self:SetTextColor(aloftData, profile.colors.hostileNPC)
	end
end

function AloftNameText:ColourNeutral(aloftData)
	self:SetTextColor(aloftData, profile.colors.neutral)
end

function AloftNameText:ColourUnknown(aloftData)
end

local nameTextMethods =
{
	["friendlyPlayer"] = AloftNameText.ColourFriendlyPlayer,
	["friendlyNPC"] = AloftNameText.ColourFriendlyNPC,
	["hostile"] = AloftNameText.ColourHostile,
	["neutral"] = AloftNameText.ColourNeutral,
	["unknown"] = AloftNameText.ColourUnknown,
}

function AloftNameText:UpdateText(aloftData)
	nameTextMethods[aloftData.type](self, aloftData)
end

function AloftNameText:UpdateTextNone(aloftData)
	aloftData.nameTextRegion:SetText(textMethod(aloftData))
end

-----------------------------------------------------------------------------
