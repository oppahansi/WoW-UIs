-----------------------------------------------------------------------------

local SML = AceLibrary("SharedMedia-1.0")

local AloftHealthBar = Aloft:NewModule("HealthBar", "AceEvent-2.0")
AloftHealthBar.db = Aloft:AcquireDBNamespace("healthBar")
Aloft:RegisterDefaults("healthBar", "profile", {
	texture			= "Blizzard",
	alpha			= 1.0,
	colorByClass	= true,
	colorHostileByClass = true,
	width			= 115,
	height			= 11,
	offsetX			= 0,
	offsetY			= 0,
	colorFormat		= "",
	colors =
	{
		backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
		friendlyPlayer	= { 0, 0, 1 },
		friendlyPet		= { 0, 1, 0 },
		friendlyNPC		= { 0, 1, 0 },
		friendlyBoss	= { 0, 1, 0 },
		hostilePlayer	= { 1, 0, 0 },
		hostilePet		= { 1, 0, 0 },
		hostileNPC		= { 1, 0, 0 },
		hostileBoss		= { 1, 0, 0 },
		neutral			= { 1, 1, 0 },
		pet				= { 0, 1, 0 },
		groupPet		= { 0, 1, 0 },
	},
})

-----------------------------------------------------------------------------

local colorMethod = nil
local colorMethodData = { }
local profile
local colors

-----------------------------------------------------------------------------

function AloftHealthBar:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:Update(aloftData)
	end
end

function AloftHealthBar:UpdateSizesAll()
	for aloftData in Aloft:IterateNameplates() do
		self:OnNameplateShow(aloftData)
	end

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:Update(aloftData)
	end

	Aloft:GetModule("Frame"):UpdateAll()
	Aloft:GetModule("Overlay"):UpdateAll()
end

-----------------------------------------------------------------------------

function AloftHealthBar:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnHealthBarValueChanged", "Update")
	self:RegisterEvent("Aloft:OnHealthBarColorChanged", "Update")

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
	
	if profile.colorByClass then
		self:RegisterEvent("Aloft:OnClassDataChanged", "Update")
	end

	if not self:IsArrayEqual(colors.friendlyPet, colors.friendlyNPC) or
	   not self:IsArrayEqual(colors.hostilePet, colors.hostileNPC) then
		self:RegisterEvent("Aloft:OnIsPetDataChanged", "Update")
	end
	
	for events in pairs(colorMethodData.events) do
		self:RegisterEvent(events, "Update")
	end
end

function AloftHealthBar:OnInitialize()
	profile = self.db.profile
	colors = profile.colors
end

function AloftHealthBar:OnEnable()
	self:UpdateAll()
	self:UpdateSizesAll()
end

local backdropTable = { }

function AloftHealthBar:OnDisable()
	self:UnregisterAllEvents()
	
	backdropTable.bgFile = ""

	for aloftData in Aloft:IterateNameplates() do
		local healthBar = aloftData.healthBar
		
		healthBar:ClearAllPoints()
		healthBar:SetPoint("BOTTOMLEFT", aloftData.nameplateFrame, "BOTTOMLEFT", 4.5, 4.5)
		healthBar:SetWidth(116.5)
		healthBar:SetHeight(10.18)
		healthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		healthBar:SetStatusBarColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)
		healthBar:SetBackdrop(backdropTable)
		healthBar:SetBackdropColor(0, 0, 0, 0)
	end
end

local dataRequiredList = { }
function AloftHealthBar:RequiresData()
	colorMethodData = Aloft:CreateTag(profile.colorFormat)
	colorMethod = colorMethodData.method
	
	self:RegisterEvents()

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if profile.colorByClass or
	   profile.colorHostileByClass or
	   not self:IsArrayEqual(colors.hostileNPC, colors.hostilePlayer) then
		table.insert(dataRequiredList, "class")
	end

	if not self:IsArrayEqual(colors.friendlyPet, colors.friendlyNPC) or
	   not self:IsArrayEqual(colors.hostilePet, colors.hostileNPC) then
		table.insert(dataRequiredList, "isPet")
	end

	if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(colors.friendlyPet, colors.groupPet) then
		table.insert(dataRequiredList, "unitid")
	end

	for data in pairs(colorMethodData.data) do
		table.insert(dataRequiredList, data)
	end

	return unpack(dataRequiredList)
end

function AloftHealthBar:SetupFrame(aloftData)
	local healthBar = aloftData.healthBar	

	healthBar:ClearAllPoints()
	healthBar:SetPoint("CENTER", aloftData.nameplateFrame, "CENTER", profile.offsetX, profile.offsetY)

	local texture = SML:Fetch("statusbar", profile.texture)
	healthBar:SetStatusBarTexture(texture)

	backdropTable.bgFile = texture
	healthBar:SetBackdrop(backdropTable)
	healthBar:SetBackdropColor(unpack(colors.backdropColor))
	
	-- This manipulates the healthbar background to always display above the frame background
	local barRegion, backgroundRegion = healthBar:GetRegions()
	barRegion:SetDrawLayer("OVERLAY")
	backgroundRegion:SetDrawLayer("ARTWORK")
end

function AloftHealthBar:OnNameplateShow(aloftData)
	local healthBar = aloftData.healthBar

	healthBar:ClearAllPoints()
	healthBar:SetPoint("CENTER", aloftData.nameplateFrame, "CENTER", profile.offsetX, profile.offsetY)
	healthBar:SetWidth(profile.width)
	healthBar:SetHeight(profile.height)

	self:Update(aloftData)	
end

-----------------------------------------------------------------------------

function AloftHealthBar:SetHealthBarColor(healthBar, color)
	healthBar:SetStatusBarColor(color[1], color[2], color[3], profile.alpha)
end

function AloftHealthBar:ColourFriendlyPlayer(aloftData)
	if profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = RAID_CLASS_COLORS[class]
			if color then
				aloftData.healthBar:SetStatusBarColor(color.r, color.g, color.b, profile.alpha)
				return
			end
		end
	end
	self:SetHealthBarColor(aloftData.healthBar, colors.friendlyPlayer)
end

function AloftHealthBar:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetHealthBarColor(aloftData.healthBar, colors.pet)
	elseif aloftData.unitid then
		self:SetHealthBarColor(aloftData.healthBar, colors.groupPet)
	elseif aloftData.isPet then
		self:SetHealthBarColor(aloftData.healthBar, colors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetHealthBarColor(aloftData.healthBar, colors.friendlyBoss)
	else
		self:SetHealthBarColor(aloftData.healthBar, colors.friendlyNPC)
	end
end

function AloftHealthBar:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	if profile.colorHostileByClass then
		local class = aloftData.class
		if class then
			local color = RAID_CLASS_COLORS[class]
			if color then
				aloftData.healthBar:SetStatusBarColor(color.r, color.g, color.b, profile.alpha)
				return
			end
		end
	end

	if aloftData.class then
		self:SetHealthBarColor(aloftData.healthBar, colors.hostilePlayer)
	elseif aloftData.isPet then
		self:SetHealthBarColor(aloftData.healthBar, colors.hostilePet)
	elseif aloftData.isBoss then
		self:SetHealthBarColor(aloftData.healthBar, colors.hostileBoss)
	else
		self:SetHealthBarColor(aloftData.healthBar, colors.hostileNPC)
	end
end

function AloftHealthBar:ColourNeutral(aloftData)
	self:SetHealthBarColor(aloftData.healthBar, colors.neutral)
end

function AloftHealthBar:ColourUnknown(aloftData)
	-- Should never be here, but if we do, just change the alpha
	local r, g, b = aloftData.healthBar:GetStatusBarColor()
	aloftData.healthBar:SetStatusBarColor(r, g, b, profile.alpha)
end

local healthBarMethods =
{
	["friendlyPlayer"] = AloftHealthBar.ColourFriendlyPlayer,
	["friendlyNPC"] = AloftHealthBar.ColourFriendlyNPC,
	["hostile"] = AloftHealthBar.ColourHostile,
	["neutral"] = AloftHealthBar.ColourNeutral,
	["unknown"] = AloftHealthBar.ColourUnknown,
}

function AloftHealthBar:Update(aloftData)
	local override = colorMethod(aloftData)
	if #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		aloftData.healthBar:SetStatusBarColor(tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, profile.alpha)
	else
		healthBarMethods[aloftData.type](self, aloftData)
	end
end

-----------------------------------------------------------------------------
