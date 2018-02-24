-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftVisibility")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Critter"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Critter"] = "동물",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Critter"] = "小動物",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Critter"] = "小动目",
} end)

L:RegisterTranslations("ruRU", function() return {
	["Critter"] = "Существо",
} end)

-----------------------------------------------------------------------------

local AloftVisibility = Aloft:NewModule("Visibility", "AceEvent-2.0")
AloftVisibility.db = Aloft:AcquireDBNamespace("visibility")
Aloft:RegisterDefaults("visibility", "profile", {
	showHostilePlayers = true,
	showHostilePets = true,
	showHostileNPCs = true,

	friendlyPlayers = "ALL",
	showPet = true,
	showGroupPets = true,
	showFriendlyPets = true,
	showFriendlyNPCs = true,

	showNeutralUnits = true,
	showCritters = true,
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftVisibility:Update()
	self:RegisterEvents()

	-- Toggle the visibility to get previously hidden stuff to show
	Aloft:RedisplayNameplates()
	Aloft:RedisplayFriendlyNameplates()
end

function AloftVisibility:RegisterEvents()
	self:UnregisterAllEvents()

	if not profile.showHostilePlayers then
		self:RegisterEvent("Aloft:OnClassDataChanged", "OnClassDataChanged")
	end

	if profile.showNeutralUnits and not profile.showCritters then
		self:RegisterEvent("Aloft:OnCreatureTypeDataChanged", "OnCreatureTypeDataChanged")
	end

	if not profile.showHostilePets or
	   not profile.showFriendlyPets then
		self:RegisterEvent("Aloft:OnIsPetDataChanged", "OnNameplateShow")
	end

	if not profile.showCritters or
	   not profile.showHostilePlayers or
	   not profile.showHostilePets or
	   not profile.showHostileNPCs or
	   not profile.showNeutralUnits or
	   not profile.showFriendlyNPCs or
	   not profile.showFriendlyPets or
	   not profile.showGroupPets or
	   not profile.showPet or
	   profile.friendlyPlayers ~= "ALL" then

		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	end
end

-----------------------------------------------------------------------------

function AloftVisibility:OnInitialize()
	profile = self.db.profile
end

function AloftVisibility:OnEnable()
	self:RegisterEvents()
end

function AloftVisibility:OnDisable()
	self:UnregisterAllEvents()

	if not profile.showCritters or
	   not profile.showHostilePlayers or
	   not profile.showHostilePets or
	   not profile.showHostileNPCs or
	   not profile.showNeutralUnits or
	   not profile.showFriendlyNPCs or
	   not profile.showFriendlyPets  or
	   not profile.showGroupPets or
	   not profile.showPet or
	   profile.friendlyPlayers ~= "ALL" then
		Aloft:RedisplayNameplates()
		Aloft:RedisplayFriendlyNameplates()
	end
end

local dataRequiredList = { }
function AloftVisibility:RequiresData()
	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if not profile.showHostilePlayers then
		table.insert(dataRequiredList, "class")
	end

	if profile.showHostilePets ~= profile.showHostileNPCs or
	   profile.showFriendlyPets ~= profile.showFriendlyNPCs then
		table.insert(dataRequiredList, "isPet")
	end

	if profile.friendlyPlayers == "GUILDONLY" then
		table.insert(dataRequiredList, "isGuildMember")
	end

	if profile.showNeutralUnits and not profile.showCritters then
		table.insert(dataRequiredList, "creatureType")
	end

	if Aloft:IsDataAvailable("unitid") then
		if profile.friendlyPlayers == "GROUPONLY" or
	   	   profile.showGroupPets ~= profile.showFriendlyPets then
			table.insert(dataRequiredList, "unitid")
		end
	end

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

local friendlyPlayerMethods =
{
	["ALL"] = function() end,
	["GUILDONLY"] = function(frame, aloftData) if not aloftData.isGuildMember then frame:Hide() end end,
	["GROUPONLY"] = function(frame, aloftData) if not aloftData.unitid then frame:Hide() end end,
	["NONE"] = function(frame) frame:Hide() end,
}

local showTypeMethods =
{
	["friendlyPlayer"] = function(frame, aloftData)
							local friendlyPlayerMethod = friendlyPlayerMethods[profile.friendlyPlayers]
							if friendlyPlayerMethod then
								friendlyPlayerMethod(frame, aloftData)
							end
						 end,
	["friendlyNPC"] = function(frame, aloftData)
						if UnitName("pet") == aloftData.name then
							if not profile.showPet then
								frame:Hide()
							end
						elseif aloftData.unitid then
							-- Group pet
							if not profile.showGroupPets then
								frame:Hide()
							end
						elseif aloftData.isPet then
							if not profile.showFriendlyPets then
								frame:Hide()
							end
						else
							if not profile.showFriendlyNPCs then
								frame:Hide()
							end
						end
					  end,
	["neutral"] = function(frame, aloftData)
					if not profile.showNeutralUnits or (not profile.showCritters and aloftData.creatureType == L["Critter"]) then
						frame:Hide()
					end
				  end,
	["hostile"] = function(frame, aloftData)
					-- Is it a player?
					if aloftData.class then
						if not profile.showHostilePlayers then
							frame:Hide()
						end
					elseif aloftData.isPet then
						if not profile.showHostilePets then
							frame:Hide()
						end
					else
						if not profile.showHostileNPCs then
							frame:Hide()
						end
					end
				  end,
	["unknown"] = function() end,
}

function AloftVisibility:OnNameplateShow(aloftData)
	if not InCombatLockdown() then
		showTypeMethods[aloftData.type](aloftData.nameplateFrame, aloftData)
	end
end

function AloftVisibility:OnClassDataChanged(aloftData)
	-- If it was changed, then it must have some value now
	if aloftData.type == "hostile" and not InCombatLockdown() then
		aloftData.nameplateFrame:Hide()
	end
end

function AloftVisibility:OnCreatureTypeDataChanged(aloftData)
	if aloftData.type == "neutral" and aloftData.creatureType == L["Critter"] and not InCombatLockdown() then
		aloftData.nameplateFrame:Hide()
	end
end

-----------------------------------------------------------------------------
