-----------------------------------------------------------------------------

local SML = AceLibrary("SharedMedia-1.0")

-----------------------------------------------------------------------------

local AloftFrame = Aloft:NewModule("Frame", "AceEvent-2.0")
AloftFrame.db = Aloft:AcquireDBNamespace("frame")
AloftFrame.healthBarDB = Aloft:AcquireDBNamespace("healthBar")
Aloft:RegisterDefaults("frame", "profile", {
	enableMouse		= true,
	background		= "Solid",
	border			= "None",
	borderColor		= { 1, 1, 1, 1 },
	width			= 0,
	height			= 0,
	packingWidth	= 5,
	packingHeight	= 5,
	backgroundAlpha	= 0,
	colorFormat		= "",
	backgroundColors =
	{
		friendlyPlayer	= { 0, 0, 0 },
		friendlyPet		= { 0, 0, 0 },
		friendlyNPC		= { 0, 0, 0 },
		friendlyBoss	= { 0, 0, 0 },
		hostilePlayer	= { 0, 0, 0 },
		hostilePet		= { 0, 0, 0 },
		hostileNPC		= { 0, 0, 0 },
		hostileBoss		= { 0, 0, 0 },
		neutral			= { 0, 0, 0 },
		pet				= { 0, 0, 0 },
		groupPet		= { 0, 0, 0 },
	},
})

-----------------------------------------------------------------------------

local colorMethod = nil
local colorMethodData = { }
local frameUpdateList = { }
local profile
local backgroundColors

-----------------------------------------------------------------------------

function AloftFrame:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.backdropFrame then
			self:OnNameplateShowWithColor(aloftData)
		else
			self:OnNameplateShow(aloftData)
		end
	end
end

function AloftFrame:RegisterEvents()
	self:UnregisterAllEvents()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatFinished")

	local onShowMethod = "OnNameplateShow"
	
	if (profile.backgroundAlpha ~= 0) and
	   (not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.friendlyPet) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.friendlyNPC) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.friendlyBoss) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostilePlayer) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostilePet) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostileNPC) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostileBoss) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.neutral) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.pet) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.groupPet) or
		profile.colorByClass or
		profile.colorHostileByClass or
		profile.colorFormat ~= "") then
		
		if not profile.colorByClass and
		   not profile.colorHostileByClass and
		   (self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.friendlyPet) and
			self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.friendlyBoss) and
			self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.pet) and
			self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.groupPet)) and
		   (self:IsArrayEqual(backgroundColors.hostilePlayer, backgroundColors.hostilePet) and
			self:IsArrayEqual(backgroundColors.hostilePlayer, backgroundColors.hostileNPC) and
			self:IsArrayEqual(backgroundColors.hostilePlayer, backgroundColors.hostileBoss)) then
			onShowMethod = "OnNameplateShowWithColorByType"
		else		
			onShowMethod = "OnNameplateShowWithColor"
		end
	end

	self:RegisterEvent("Aloft:OnNameplateShow", onShowMethod)

	if profile.backgroundAlpha ~= 0 then	
		if profile.colorByClass or profile.colorHostileByClass then
			self:RegisterEvent("Aloft:OnClassDataChanged", onShowMethod)
		end

		if not self:IsArrayEqual(backgroundColors.friendlyPet, backgroundColors.friendlyNPC) or
		   not self:IsArrayEqual(backgroundColors.hostilePet, backgroundColors.hostileNPC) then
			self:RegisterEvent("Aloft:OnIsPetDataChanged", onShowMethod)
		end
		for events in pairs(colorMethodData.events) do
			self:RegisterEvent(events, onShowMethod)
		end
	end
	
end

-----------------------------------------------------------------------------

function AloftFrame:OnInitialize()
	profile = self.db.profile
	backgroundColors = profile.backgroundColors
end

function AloftFrame:OnEnable()
	self:UpdateAll()
end

function AloftFrame:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local backdropFrame = aloftData.backdropFrame
		if backdropFrame then
			backdropFrame:Hide()
		end
	end
end

local dataRequiredList = { }
function AloftFrame:RequiresData()
	colorMethodData = Aloft:CreateTag(profile.colorFormat)
	colorMethod = colorMethodData.method
	
	self:RegisterEvents()

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if profile.backgroundAlpha ~= 0 then
		if profile.colorByClass or
		   profile.colorHostileByClass or
		   not self:IsArrayEqual(backgroundColors.hostileNPC, backgroundColors.hostilePlayer) then
			table.insert(dataRequiredList, "class")
		end

		if not self:IsArrayEqual(backgroundColors.friendlyPet, backgroundColors.friendlyNPC) or
		   not self:IsArrayEqual(backgroundColors.hostilePet, backgroundColors.hostileNPC) then
			table.insert(dataRequiredList, "isPet")
		end

		if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(backgroundColors.friendlyPet, backgroundColors.groupPet) then
			table.insert(dataRequiredList, "unitid")
		end

		for data in pairs(colorMethodData.data) do
			table.insert(dataRequiredList, data)
		end
	end

	return unpack(dataRequiredList)
end

local backdropTable =
{
	tile = false, tileSize = 16,
	edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}
-----------------------------------------------------------------------------

function AloftFrame:SetupFrame(aloftData)
	--
	-- Using the inbuilt frame for borders/background works fine, until a nameplate shows during combat
	--
	-- The game likes to automatically resize the frame when a frame is shown, 
	-- but we can't change it back OnShow because of in-combat lockdown.
	--
	-- This forces us to use our own backdropFrame which we can control as we please.
	--
	-- We also can't use SetFrameLevel during combat.
	--
	-- Requirements:
	--  Backdrop must appear behind all elements
	--  CastBar/HealthBar must be show backgrounds
	--  CastBar/HealthBar background must be above backdrop
	--  Overlay must display on top of HealthBar/CastBar
	--  UI elements must appear on top of healthbar/castbar/overlay
	--
	local backdropFrame = aloftData.backdropFrame

	if InCombatLockdown() then
		frameUpdateList[aloftData] = true
	else
		aloftData.nameplateFrame:EnableMouse(not profile.enableMouse)
	end

	if profile.border == "None" and profile.backgroundAlpha == 0 then
		if backdropFrame then
			backdropFrame:Hide()
		end
		return
	end
	
	if not backdropFrame then
		local nameplateFrame = aloftData.nameplateFrame
		backdropFrame = CreateFrame("Frame", nil, nameplateFrame)
		backdropFrame:SetPoint("CENTER", nameplateFrame, "CENTER")
		backdropFrame:SetAlpha(nameplateFrame:GetAlpha())
		backdropFrame:SetFrameLevel(0)
		aloftData.backdropFrame = backdropFrame
	end

	backdropTable.bgFile = SML:Fetch("background", profile.background)
	backdropTable.edgeFile = SML:Fetch("border", profile.border)
	backdropFrame:SetBackdrop(backdropTable)
	backdropFrame:SetBackdropBorderColor(unpack(profile.borderColor))
	
	local healthBarProfile = self.healthBarDB.profile
	backdropFrame:SetWidth(profile.width+healthBarProfile.width+10)
	backdropFrame:SetHeight(profile.height+healthBarProfile.height+10)
	backdropFrame:Show()
	
	-- This shifts the backdrop to border layer, enabling it to display, despite being at frame level 0
	backdropFrame:GetRegions():SetDrawLayer("BORDER")

	self:SetBackgroundColor(aloftData, backgroundColors.friendlyPlayer)
end

function AloftFrame:SetBackgroundColor(aloftData, color)
	aloftData.backdropFrame:SetBackdropColor(color[1], color[2], color[3], profile.backgroundAlpha)
end

function AloftFrame:SetBackgroundColorRgb(aloftData, color)
	aloftData.backdropFrame:SetBackdropColor(color.r, color.g, color.b, profile.backgroundAlpha)
end

function AloftFrame:OnNameplateShow(aloftData)
	if InCombatLockdown() then
		frameUpdateList[aloftData] = true
	else
		local healthBarProfile = self.healthBarDB.profile
		local nameplateFrame = aloftData.nameplateFrame

		nameplateFrame:SetWidth(profile.packingWidth+healthBarProfile.width)
		nameplateFrame:SetHeight(profile.packingHeight+healthBarProfile.height)
	end
end

function AloftFrame:OnNameplateHide(aloftData)
	frameUpdateList[aloftData] = nil
end

function AloftFrame:OnCombatFinished()
	for aloftData in pairs(frameUpdateList) do
		aloftData.nameplateFrame:EnableMouse(not profile.enableMouse)
		self:OnNameplateShow(aloftData)
		frameUpdateList[aloftData] = nil
	end
end

-----------------------------------------------------------------------------

function AloftFrame:ColourFriendlyPlayer(aloftData)
	if profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = RAID_CLASS_COLORS[class]
			if color then
				self:SetBackgroundColorRgb(aloftData, color)
				return
			end
		end
	end
	self:SetBackgroundColor(aloftData, backgroundColors.friendlyPlayer)
end

function AloftFrame:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetBackgroundColor(aloftData, backgroundColors.pet)
	elseif aloftData.unitid then
		self:SetBackgroundColor(aloftData, backgroundColors.groupPet)
	elseif aloftData.isPet then
		self:SetBackgroundColor(aloftData, backgroundColors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetBackgroundColor(aloftData, backgroundColors.friendlyBoss)
	else
		self:SetBackgroundColor(aloftData, backgroundColors.friendlyNPC)
	end
end

function AloftFrame:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	if profile.colorHostileByClass then
		local class = aloftData.class
		if class then
			local color = RAID_CLASS_COLORS[class]
			if color then
				self:SetBackgroundColorRgb(aloftData, color)
				return
			end
		end
	end

	if aloftData.class then
		self:SetBackgroundColor(aloftData, backgroundColors.hostilePlayer)
	elseif aloftData.isPet then
		self:SetBackgroundColor(aloftData, backgroundColors.hostilePet)
	elseif aloftData.isBoss then
		self:SetBackgroundColor(aloftData, backgroundColors.hostileBoss)
	else
		self:SetBackgroundColor(aloftData, backgroundColors.hostileNPC)
	end
end

function AloftFrame:ColourNeutral(aloftData)
	self:SetBackgroundColor(aloftData, backgroundColors.neutral)
end

function AloftFrame:ColourUnknown(aloftData)
end

local backgroundColorMethods =
{
	friendlyPlayer = AloftFrame.ColourFriendlyPlayer,
	friendlyNPC = AloftFrame.ColourFriendlyNPC,
	hostile = AloftFrame.ColourHostile,
	neutral = AloftFrame.ColourNeutral,
	unknown = AloftFrame.ColourUnknown,
}

function AloftFrame:OnNameplateShowWithColor(aloftData)
	self:OnNameplateShow(aloftData)
	local override = colorMethod(aloftData)
	if #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		aloftData.backdropFrame:SetBackdropColor(tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, profile.backgroundAlpha)
	else
		backgroundColorMethods[aloftData.type](self, aloftData)
	end
end

local backgroundTypeColorLookup =
{
	friendlyPlayer = "friendlyPlayer",
	friendlyNPC = "friendlyNPC",
	hostile = "hostileNPC",
	neutral = "neutral",
	unknown = "friendlyNPC",
}

function AloftFrame:OnNameplateShowWithColorByType(aloftData)
	self:OnNameplateShow(aloftData)

	local override = colorMethod(aloftData)
	if #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		aloftData.backdropFrame:SetBackdropColor(tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, profile.backgroundAlpha)
	else
		self:SetBackgroundColor(aloftData, backgroundColors[backgroundTypeColorLookup[aloftData.type]])
	end
end

-----------------------------------------------------------------------------
