-----------------------------------------------------------------------------

local SML = AceLibrary("SharedMedia-1.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

local AloftManaBar = Aloft:NewModule("ManaBar", "AceEvent-2.0")
AloftManaBar.db = Aloft:AcquireDBNamespace("manaBar")
Aloft:RegisterDefaults("manaBar", "profile", {
	enable			= false,
	texture			= "Blizzard",
	height			= 4,
	backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
	offsets =
	{
		left		= 0,
		right		= 0,
		vertical	= -1,
	},
	powerTypeColors	=
	{
        [0] = { 0.28, 0.52, 0.84, 1},	-- Mana
        [1] = { 0.89, 0.18, 0.29, 1}, 	-- Rage
        [2] = {    1, 0.82,    0, 1},	-- Focus
        [3] = {    1, 0.86, 0.10, 1}, 	-- Energy
        [4] = {    0,    1,    1, 1} 	-- Happiness
	},
})

-----------------------------------------------------------------------------

local manaBarPool = { }
local profile
local unpack=unpack

-----------------------------------------------------------------------------

function AloftManaBar:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			if aloftData.manaBar then
				self:PlaceBar(aloftData)
				self:SetupBar(aloftData.manaBar)
			end
			self:Update(aloftData)
		else
			self:ReleaseManaBar(aloftData)
		end
	end
	if profile.enable then
		for manaBar in pairs(manaBarPool) do
			self:SetupBar(manaBar)
		end
	end
end

-----------------------------------------------------------------------------

function AloftManaBar:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "Update")
		self:RegisterEvent("Aloft:OnManaDataChanged", "Update")
		self:RegisterEvent("Aloft:OnNameplateHide", "ReleaseManaBar")
	else
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnManaDataChanged")
		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

function AloftManaBar:OnInitialize()
	profile = self.db.profile
end

function AloftManaBar:OnEnable()
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

function AloftManaBar:OnDisable()
	self:UnregisterAllEvents()
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseManaBar(aloftData)
	end
end

function AloftManaBar:RequiresData()
	self:RegisterEvents()
	if profile.enable then
		return "mana", "maxMana", "powerType"
	end
end

local backdropTable = { }
function AloftManaBar:SetupBar(manaBar)
	local texture = SML:Fetch("statusbar", profile.texture)
	manaBar:SetStatusBarTexture(texture)

	backdropTable.bgFile = texture
	manaBar:SetBackdrop(backdropTable)
	manaBar:SetBackdropColor(unpack(profile.backdropColor))

	-- This manipulates the manabar background to always display above the frame background
	local barRegion, backgroundRegion = manaBar:GetRegions()
	barRegion:SetDrawLayer("OVERLAY")
	backgroundRegion:SetDrawLayer("ARTWORK")
end

function AloftManaBar:PlaceBar(aloftData)
	local manaBar = aloftData.manaBar
	manaBar:ClearAllPoints()
	manaBar:SetPoint("TOPLEFT", aloftData.healthBar, "BOTTOMLEFT", profile.offsets.left, profile.offsets.vertical)
	manaBar:SetPoint("BOTTOMRIGHT", aloftData.healthBar, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical-profile.height)
	manaBar:SetFrameLevel(0)
	manaBar:Show()
end

function AloftManaBar:AcquireManaBar(aloftData)
	local manaBar = aloftData.manaBar
	if not manaBar then
		manaBar = next(manaBarPool)
		if manaBar then
			manaBarPool[manaBar] = nil
			manaBar:SetParent(aloftData.nameplateFrame)
		else
			manaBar = CreateFrame("StatusBar", nil, aloftData.nameplateFrame)
			self:SetupBar(manaBar)
		end
		aloftData.manaBar = manaBar
		self:PlaceBar(aloftData)
	end
	return manaBar
end

function AloftManaBar:ReleaseManaBar(aloftData)
	local manaBar = aloftData.manaBar
	if manaBar then
		manaBar:Hide()
		manaBarPool[manaBar] = true
		aloftData.manaBar = nil
	end
end

function AloftManaBar:Update(aloftData)
	if aloftData.mana then
		local manaBar = self:AcquireManaBar(aloftData)
		local color = profile.powerTypeColors[aloftData.powerType]
		manaBar:SetStatusBarColor(unpack(color))
		manaBar:SetMinMaxValues(0, aloftData.maxMana)
		manaBar:SetValue(aloftData.mana)
	else
		self:ReleaseManaBar(aloftData)
	end
end

-----------------------------------------------------------------------------
