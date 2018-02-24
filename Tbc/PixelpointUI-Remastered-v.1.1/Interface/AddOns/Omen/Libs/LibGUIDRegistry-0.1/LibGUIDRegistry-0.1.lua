local lib = LibStub:NewLibrary("LibGUIDRegistry-0.1", 1) -- yes a major version of 0.1 because I'm not even sure what I'm doing

if not lib then
	return	-- already loaded and no upgrade necessary
end

local bit_band	= bit.band
local bit_bor	= bit.bor
local UnitName	= UnitName
local UnitClass	= UnitClass
local UnitRace	= UnitRace
local UnitLevel	= UnitLevel
local UnitSex	= UnitSex
local UnitFactionGroup	= UnitFactionGroup
local UnitCreatureType	= UnitCreatureType
local UnitCreatureFamily	= UnitCreatureFamily
local UnitClassification	= UnitClassification
local UnitPlayerControlled  = UnitPlayerControlled
local UnitIsPlayer			= UnitIsPlayer

-- Affiliation
local COMBATLOG_OBJECT_AFFILIATION_MINE		= COMBATLOG_OBJECT_AFFILIATION_MINE		or 0x00000001
local COMBATLOG_OBJECT_AFFILIATION_PARTY	= COMBATLOG_OBJECT_AFFILIATION_PARTY	or 0x00000002
local COMBATLOG_OBJECT_AFFILIATION_RAID		= COMBATLOG_OBJECT_AFFILIATION_RAID		or 0x00000004
local COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	or 0x00000008
local COMBATLOG_OBJECT_AFFILIATION_MASK		= COMBATLOG_OBJECT_AFFILIATION_MASK		or 0x0000000F
-- Reaction
local COMBATLOG_OBJECT_REACTION_FRIENDLY	= COMBATLOG_OBJECT_REACTION_FRIENDLY	or 0x00000010
local COMBATLOG_OBJECT_REACTION_NEUTRAL		= COMBATLOG_OBJECT_REACTION_NEUTRAL		or 0x00000020
local COMBATLOG_OBJECT_REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE		or 0x00000040
local COMBATLOG_OBJECT_REACTION_MASK		= COMBATLOG_OBJECT_REACTION_MASK		or 0x000000F0
-- Ownership
local COMBATLOG_OBJECT_CONTROL_PLAYER		= COMBATLOG_OBJECT_CONTROL_PLAYER		or 0x00000100
local COMBATLOG_OBJECT_CONTROL_NPC			= COMBATLOG_OBJECT_CONTROL_NPC			or 0x00000200
local COMBATLOG_OBJECT_CONTROL_MASK			= COMBATLOG_OBJECT_CONTROL_MASK			or 0x00000300
-- Unit type
local COMBATLOG_OBJECT_TYPE_PLAYER			= COMBATLOG_OBJECT_TYPE_PLAYER			or 0x00000400
local COMBATLOG_OBJECT_TYPE_NPC				= COMBATLOG_OBJECT_TYPE_NPC				or 0x00000800
local COMBATLOG_OBJECT_TYPE_PET				= COMBATLOG_OBJECT_TYPE_PET				or 0x00001000
local COMBATLOG_OBJECT_TYPE_GUARDIAN		= COMBATLOG_OBJECT_TYPE_GUARDIAN		or 0x00002000
local COMBATLOG_OBJECT_TYPE_OBJECT			= COMBATLOG_OBJECT_TYPE_OBJECT			or 0x00004000
local COMBATLOG_OBJECT_TYPE_MASK			= COMBATLOG_OBJECT_TYPE_MASK			or 0x0000FC00

-- Special cases (non-exclusive)
local COMBATLOG_OBJECT_TARGET				= COMBATLOG_OBJECT_TARGET				or 0x00010000
local COMBATLOG_OBJECT_FOCUS				= COMBATLOG_OBJECT_FOCUS				or 0x00020000
local COMBATLOG_OBJECT_MAINTANK				= COMBATLOG_OBJECT_MAINTANK				or 0x00040000
local COMBATLOG_OBJECT_MAINASSIST			= COMBATLOG_OBJECT_MAINASSIST			or 0x00080000
local COMBATLOG_OBJECT_RAIDTARGET1			= COMBATLOG_OBJECT_RAIDTARGET1			or 0x00100000
local COMBATLOG_OBJECT_RAIDTARGET2			= COMBATLOG_OBJECT_RAIDTARGET2			or 0x00200000
local COMBATLOG_OBJECT_RAIDTARGET3			= COMBATLOG_OBJECT_RAIDTARGET3			or 0x00400000
local COMBATLOG_OBJECT_RAIDTARGET4			= COMBATLOG_OBJECT_RAIDTARGET4			or 0x00800000
local COMBATLOG_OBJECT_RAIDTARGET5			= COMBATLOG_OBJECT_RAIDTARGET5			or 0x01000000
local COMBATLOG_OBJECT_RAIDTARGET6			= COMBATLOG_OBJECT_RAIDTARGET6			or 0x02000000
local COMBATLOG_OBJECT_RAIDTARGET7			= COMBATLOG_OBJECT_RAIDTARGET7			or 0x04000000
local COMBATLOG_OBJECT_RAIDTARGET8			= COMBATLOG_OBJECT_RAIDTARGET8			or 0x08000000
local COMBATLOG_OBJECT_NONE					= COMBATLOG_OBJECT_NONE					or 0x80000000
local COMBATLOG_OBJECT_SPECIAL_MASK			= COMBATLOG_OBJECT_SPECIAL_MASK			or 0xFFFF0000

local LIB_FILTER_RAIDTARGET	= bit_bor(
	COMBATLOG_OBJECT_RAIDTARGET1, COMBATLOG_OBJECT_RAIDTARGET2, COMBATLOG_OBJECT_RAIDTARGET3, COMBATLOG_OBJECT_RAIDTARGET4,
	COMBATLOG_OBJECT_RAIDTARGET5, COMBATLOG_OBJECT_RAIDTARGET6, COMBATLOG_OBJECT_RAIDTARGET7, COMBATLOG_OBJECT_RAIDTARGET8
)
local LIB_FILTER_ME = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER
)
local LIB_FILTER_MY_PET = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE,
--	COMBATLOG_OBJECT_REACTION_FRIENDLY,
	COMBATLOG_OBJECT_CONTROL_PLAYER,	-- remove this?
	COMBATLOG_OBJECT_TYPE_PET
)
local LIB_FILTER_MY_GUARDIAN = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE,
--	COMBATLOG_OBJECT_REACTION_FRIENDLY,
	COMBATLOG_OBJECT_CONTROL_PLAYER,	-- remove this?
	COMBATLOG_OBJECT_TYPE_GUARDIAN
)
local LIB_FILTER_PARTY = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_PARTY)
local LIB_FILTER_RAID  = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_RAID)
local LIB_FILTER_GROUP = bit_bor(LIB_FILTER_PARTY, LIB_FILTER_RAID)

lib.update	= lib.update or {}
lib.units	= lib.units	or {}
lib.reg		= lib.reg	or {}
lib.names	= lib.names	or {}
lib.guardians	= lib.guardians or {}
lib.callbacks	= lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

local update = lib.update -- save a dereference
local units = lib.units
local reg = lib.reg
local names = lib.names
local guardians = lib.guardians

local function OnEvent(self, event, ...)
	lib[event](lib, ...)
end
if not lib.frame then
	lib.frame = CreateFrame("Frame")
end
lib.frame:UnregisterAllEvents()
lib.frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
lib.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
lib.frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
lib.frame:RegisterEvent("RAID_TARGET_UPDATE")
lib.frame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
lib.frame:RegisterEvent("UNIT_LEVEL")
lib.frame:RegisterEvent("UNIT_NAME_UPDATE")
--lib.frame:RegisterEvent("UNIT_PET")
lib.frame:SetScript("OnEvent", OnEvent)

function lib:COMBAT_LOG_EVENT_UNFILTERED(timestamp, type, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	lib:ProcessActor(srcGUID, srcName, srcFlags)
	lib:ProcessActor(dstGUID, dstName, dstFlags)
	lib.callbacks:Fire("COMBAT_LOG_EVENT_UNFILTERED", timestamp, type, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
end

local function processUnit(unitID, GUID, player)
	reg[GUID] = reg[GUID] or {}
	reg[GUID].name	= UnitName(unitID)
	reg[GUID].class	= select(2, UnitClass(unitID))
	reg[GUID].race	= select(2, UnitRace(unitID))
	reg[GUID].level	= UnitLevel(unitID)
	reg[GUID].sex	= UnitSex(unitID)
	reg[GUID].faction	= UnitFactionGroup(unitID)
	reg[GUID].creaturetype	= UnitCreatureType(unitID)
	reg[GUID].creaturefamily	= UnitCreatureFamily(unitID)
	reg[GUID].classification	= UnitClassification(unitID)
end

function lib:ProcessActor(GUID, name, flags)
	if update.target and bit_band(flags, COMBATLOG_OBJECT_TARGET) == COMBATLOG_OBJECT_TARGET then
		update.target = nil
		units.target = GUID
		processUnit("target", GUID)
		lib.callbacks:Fire("TargetGUIDSet", GUID)
	end
	
	if update.focus and bit_band(flags, COMBATLOG_OBJECT_FOCUS) == COMBATLOG_OBJECT_FOCUS then
		update.focus = nil
		units.focus = GUID
		processUnit("focus", GUID)
		lib.callbacks:Fire("FocusGUIDSet", GUID)
	end
	
	-- If they're in the party or raid...	
	if (update.player or not reg[GUID]) and (bit_band(flags, LIB_FILTER_ME) == LIB_FILTER_ME) then
		update.player = nil
		units.player = GUID
		processUnit("player", GUID)
		units[UnitName("player")] = GUID
		lib.callbacks:Fire("PlayerGUIDSet", GUID, name)
	elseif UnitName("pet") and (update.pet or not reg[GUID]) and (bit_band(flags, LIB_FILTER_MY_PET) == LIB_FILTER_MY_PET) then
		update.pet = nil
		units.pet = GUID
		processUnit(name, GUID)
		units[UnitName("pet") .. ":pet"] = GUID
		lib.callbacks:Fire("PetGUIDSet", GUID, name)
	elseif not guardians[GUID] and (bit_band(flags, LIB_FILTER_MY_GUARDIAN) == LIB_FILTER_MY_GUARDIAN) then
		guardians[GUID] = true
		lib.callbacks:Fire("GuardianGUIDSet", GUID, name)
	-- the following section might be better elsewhere and not in this giant if/elseif/else statement
	elseif guardians[GUID] and (bit_band(flags, LIB_FILTER_MY_GUARDIAN) ~= LIB_FILTER_MY_GUARDIAN) then
		guardians[GUID] = nil
		lib.callbacks:Fire("GuardianGUIDUnset", GUID, name) -- need a new name for this and probably the rest of the callbacks
	--[[
		This section needs a lot of work and why the .class check?
		
		The class check is used because if we process a unit "Joe", and he isn't in our party,
		then we won't have class data for him (since Unit*() only works if the name is in your group).
		If Joe later joins our party, we'll want class info, etc for him.
		-- Antiarc
	]]--
	elseif update[name] or not reg[GUID] or not reg[GUID].class then  
		local group = bit_band(flags, LIB_FILTER_GROUP)
		if group == LIB_FILTER_PARTY or group == LIB_FILTER_RAID then
			update[name] = nil
			units[name] = GUID		-- This is a name, but Unit*() takes names if they're in your party.
			processUnit(name, GUID)
			lib.callbacks:Fire("GroupGUIDSet", GUID, name)
		end
	end
	
	local raidtarget = bit_band(flags, LIB_FILTER_RAIDTARGET)
	raidtarget	 = (raidtarget == COMBATLOG_OBJECT_RAIDTARGET8 and 8)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET7 and 7)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET6 and 6)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET5 and 5)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET4 and 4)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET3 and 3)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET2 and 2)
				or (raidtarget == COMBATLOG_OBJECT_RAIDTARGET1 and 1)
				or nil
	if raidtarget then
		local raidtargetunitID = "raidtarget"..tostring(raidtarget)
		units[raidtargetunitID] = units[raidtargetunitID] == GUID and GUID
			or lib.callbacks:Fire("RaidTargetGUIDSet", GUID, name, raidtarget, raidtargetunitID) and GUID
	end
	
	if (not reg[GUID] or not reg[GUID].name) and not names[GUID] then
		names[GUID] = name
	end
end

function lib:PLAYER_TARGET_CHANGED()
	-- clear stored guid for 'target'
	units.target = nil
	update.target = true
end
function lib:PLAYER_FOCUS_CHANGED()
	-- clear stored guid for 'focus'
	units.focus = nil
	update.focus = true
end
function lib:RAID_TARGET_UPDATE()
	-- clear all stored guids for raidtargets
	units["raidtarget1"] = nil
	units["raidtarget2"] = nil
	units["raidtarget3"] = nil
	units["raidtarget4"] = nil
	units["raidtarget5"] = nil
	units["raidtarget6"] = nil
	units["raidtarget7"] = nil
	units["raidtarget8"] = nil
end

local function FlagForUpdate(self, unitID, ...)
	if unitID == "target" or unitID == "focus" or unitID == "pet" or unitID == "player" then
		update[unitID] = true
	elseif UnitIsPlayer(unitID) and UnitPlayerOrPetInParty(unitID) and UnitPlayerOrPetInRaid(unitID) then
		update[UnitName(unitID)] = true
	end
end
lib.UNIT_CLASSIFICATION_CHANGED = FlagForUpdate
lib.UNIT_LEVEL = FlagForUpdate
lib.UNIT_NAME_UPDATE = FlagForUpdate

-- Will take a unit ID, or the name of someone in
-- Note: This needs work so that if we have/had a player in the group with the same name as an npc
--       we don't return the players GUID when requesting the GUID for the target
--       adding a UnitExists() might solve this
function lib:GetGUID(unitID)
	local uname = UnitExists(unitID) and UnitName(unitID)
	local vname 
	if uname then
		-- These checks are valid, because we only set name indexes on the units table if they are self, pet, or in group.
		vname = (UnitIsPlayer(unitID) and units[uname]) or 
				(UnitPlayerControlled(unitID) and units[uname .. ":pet"])
	end
	return vname or units[unitID] or nil
end

function lib:GetNPCID(GUID)
	return tonumber(GUID:sub(-12,-7),16)
end

function lib:GetName(GUID)
	return reg[GUID] and reg[GUID].name or names[GUID] or nil
end

function lib:GetClass(GUID)
	return reg[GUID] and reg[GUID].class or nil
end

function lib:GetRace(GUID)
	return reg[GUID] and reg[GUID].race or nil
end

function lib:GetLevel(GUID)
	return reg[GUID] and reg[GUID].level or nil
end

function lib:GetClassification(GUID)
	return reg[GUID] and reg[GUID].classification or nil
end

function lib:GetCreatureType(GUID)
	return reg[GUID] and reg[GUID].creaturetype or nil
end

function lib:GetCreatureFamily(GUID)
	return reg[GUID] and reg[GUID].creaturefamily or nil
end

function lib:GetFaction(GUID)
	return reg[GUID] and reg[GUID].faction or nil
end

function lib:GetSex(GUID)
	return reg[GUID] and reg[GUID].sex or nil
end
