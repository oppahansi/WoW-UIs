-----------------------------------------------------------------------------

local roster = AceLibrary("Roster-2.1")
local BC = AceLibrary("Babble-Class-2.2")

-----------------------------------------------------------------------------

local playerClasses = { }

-----------------------------------------------------------------------------

local AloftClassData = Aloft:NewModule("ClassData", "AceEvent-2.0")
AloftClassData.db = Aloft:AcquireDBNamespace("classData")
Aloft:RegisterDefaults("classData", "server", {	playerClasses = { } })
Aloft:RegisterDefaults("classData", "profile", { save = true })

-----------------------------------------------------------------------------

local localClassNames =
{
	DRUID	= BC["Druid"],
	HUNTER	= BC["Hunter"],
	MAGE	= BC["Mage"],
	PALADIN = BC["Paladin"],
	PRIEST	= BC["Priest"],
	ROGUE	= BC["Rogue"],
	SHAMAN	= BC["Shaman"],
	WARLOCK = BC["Warlock"],
	WARRIOR = BC["Warrior"],
}

Aloft.TagData.Class =
{
	data = "class",
	events = "Aloft:OnClassDataChanged",
	method = function(data, prior)
				return prior and localClassNames[data.class]
			 end
}

-----------------------------------------------------------------------------

function AloftClassData.SetSaveData(v)
	AloftClassData.db.profile.save = v
	AloftClassData.db.server.playerClasses = v and playerClasses or { }
end

function AloftClassData:ProvidesData()
	return "class"
end

function AloftClassData:EnableDataSource()
	-- Events to update our class database
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateClassFromMouseOver")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateClassFromTarget")
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateClassesFromGuild")
    self:RegisterEvent("WHO_LIST_UPDATE", "UpdateClassesFromWho") 
    self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateClassesFromWho") 
    self:RegisterEvent("RosterLib_RosterUpdated", "UpdateClassesFromRoster")

	self:RegisterEvent("FRIENDLIST_UPDATE", "UpdateClassesFromFriends")

	-- Update stuff from battlegrounds
	self:ScheduleRepeatingEvent("AloftClassDataBattlefieldUpdate", function() if MiniMapBattlefieldFrame.status == "active" then RequestBattlefieldScoreData() end end, 15)
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "UpdateClassesFromBattlefield")
	
	self:UpdateClassesFromGuild()
	self:UpdateClassesFromFriends()
end

-----------------------------------------------------------------------------

function AloftClassData:OnEnable()
	if self.db.profile.save then
		playerClasses = self.db.server.playerClasses
	end
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateData(aloftData)
	aloftData.class = nil
	
	-- This is so that pets named the same as players we've encountered aren't given a class incorrectly
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostile" then
		aloftData.class = playerClasses[aloftData.name]
	end
end

-----------------------------------------------------------------------------

local updateRequired = false

local function AddData(name, class)
	if name and playerClasses[name] ~= class then
		playerClasses[name] = class
		updateRequired = true
	end
end

function AloftClassData:UpdateVisibleNameplates()
	if updateRequired then
		for aloftData in Aloft:IterateVisibleNameplates() do
			local class = playerClasses[aloftData.name]
		
			if aloftData.class ~= class then
				aloftData.class = class
				self:TriggerEvent("Aloft:OnClassDataChanged", aloftData)
			end
		end
	end
	updateRequired = false
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateClassFromMouseOver()
	if UnitIsPlayer("mouseover") then
		local _, class = UnitClass("mouseover")
		AddData(UnitName("mouseover"), class)
		self:UpdateVisibleNameplates()
	end
end

function AloftClassData:UpdateClassFromTarget()
	if UnitIsPlayer("target") then
		local _, class = UnitClass("target")
		AddData(UnitName("target"), class)
		self:UpdateVisibleNameplates()
	end
end

function AloftClassData:UpdateClassesFromGuild()
    if IsInGuild() then
		for i = 1, GetNumGuildMembers(true) do
			local name, _, _, _, class = GetGuildRosterInfo(i)
			if name and class then
				AddData(name, BC:GetReverseTranslation(class):upper())
			end
		end
		self:UpdateVisibleNameplates()
	end
end

function AloftClassData:UpdateClassesFromWho()
    for i = 1, GetNumWhoResults() do
        local name, _, _, _, class = GetWhoInfo(i)
		if name and class and BC:HasReverseTranslation(class) then
			AddData(name, BC:GetReverseTranslation(class):upper())
		end
    end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromRoster()
	for unit in roster:IterateRoster(false) do
		AddData(unit.name, unit.class)
	end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromBattlefield()
	for i = 1, GetNumBattlefieldScores() do
		local name, _, _, _, _, _, _, _, _, class = GetBattlefieldScore(i)
		name = ("-"):split(name, 2)
		AddData(name, class)
	end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromFriends()
    for i = 1, GetNumFriends() do
        local name, _, class = GetFriendInfo(i)

		if name and class and BC:HasReverseTranslation(class) then
			AddData(name, BC:GetReverseTranslation(class):upper())
		end
    end
	self:UpdateVisibleNameplates()
end

function AloftClassData:GetClass(name)
	return playerClasses[name]
end

-----------------------------------------------------------------------------
