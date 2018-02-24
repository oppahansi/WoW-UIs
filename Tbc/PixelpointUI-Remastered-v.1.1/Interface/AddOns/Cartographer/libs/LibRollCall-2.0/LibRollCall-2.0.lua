--[[
Name: LibRollCall-2.0
Revision: $Rev: 62578 $
Author: Cameron Kenneth Knight (ckknight@gmail.com)
Website: http://wiki.wowace.com/index.php/LibRollCall-2.0
Documentation: http://wiki.wowace.com/index.php/LibRollCall-2.0
SVN: svn://svn.wowace.com/wowace/trunk/LibRollCall-2.0/LibRollCall-2.0
Description: A library to provide an easy way to get information about guild members.
Dependencies: LibRock-1.0, LibRockEvent-1.0, LibRockTimer-1.0, LibBabble-Zone-3.0 (optional),
				LibBabble-Class-3.0 (optional)
License: LGPL v2.1
]]

local MAJOR_VERSION = "LibRollCall-2.0"
local MINOR_VERSION = "$Revision: 62578 $"

-- This ensures the code is only executed if the libary doesn't already exist, or is a newer version
if not Rock then error(MAJOR_VERSION .. " requires LibRock-1.0.") end
if not Rock:HasLibrary("LibRockEvent-1.0") then error(MAJOR_VERSION .. " requires LibRockEvent-1.0.") end
if not Rock:HasLibrary("LibRockTimer-1.0") then error(MAJOR_VERSION .. " requires LibRockTimer-1.0.") end

local RollCall, oldLib = Rock:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not RollCall then
	return
end

Rock("LibRockEvent-1.0"):Embed(RollCall)
Rock("LibRockTimer-1.0"):Embed(RollCall)

local BZ, BC, old_BZ, old_BC

local IsInGuild = IsInGuild
local GuildRoster = GuildRoster
local select = select
local next = next

local newList, del = Rock:GetRecyclingFunctions(MAJOR_VERSION, "newList", "del")
local precondition, argCheck = Rock:GetContractFunctions(MAJOR_VERSION, "precondition", "argCheck")

local playersOnline = {}
local playerOfflineTimes = {}
local playerRanks = {}
local playerRankIndexes = {}
local playerLevels = {}
local playerClasses = {}
local playerZones = {}
local playerStatuses = {}
local playerNotes = {}
local playerOfficerNotes = {}
local numPlayersOnline = 0
local numPlayersTotal = 0
local guildLeader = nil

do
	-- Hooking the OnShow, which registers the event, to unregister it
	-- so that the Guild Control Panel will not "reset" every 15 seconds
	hooksecurefunc("GuildControlPopupFrame_OnShow", function()
		GuildControlPopupFrame:UnregisterEvent("GUILD_ROSTER_UPDATE")
	end)
end

function RollCall:PLAYER_GUILD_UPDATE(ns, event, arg1)
	if arg1 and arg1 ~= "player" then return end
	
	if IsInGuild() then
		if not self:HasEventListener("GUILD_ROSTER_UPDATE") then
			self:AddTimer("LibRollCall20-GuildRoster", 15, GuildRoster)
			self:AddEventListener("GUILD_ROSTER_UPDATE", "GUILD_ROSTER_UPDATE", 1)
		end
		GuildRoster()
		self:DispatchEvent("Joined")
	else
		if self:HasEventListener("GUILD_ROSTER_UPDATE") then
			self:RemoveTimer("LibRollCall20-GuildRoster")
			self:RemoveEventListener("GUILD_ROSTER_UPDATE")
		end
		self:DispatchEvent("Left")
		
		self:GUILD_ROSTER_UPDATE()
	end
end
RollCall:AddEventListener("PLAYER_GUILD_UPDATE")

local tmp, tmp2 = {}, {}
function RollCall:GUILD_ROSTER_UPDATE()
	if IsInGuild() then
		playersOnline, tmp = tmp, playersOnline
		playerLevels, tmp2 = tmp2, playerLevels
		numPlayersOnline = 0
		numPlayersTotal = GetNumGuildMembers(true)
		
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status
		local yearsOffline, monthsOffline, daysOffline, hoursOffline, secondsOffline
		for i = 1, numPlayersTotal do
			name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i)
			yearsOffline, monthsOffline, daysOffline, hoursOffline = GetGuildRosterLastOnline(i)
			if yearsOffline then
				secondsOffline = hoursOffline * 60 * 60
				secondsOffline = secondsOffline + daysOffline * 24 * 60 * 60
				secondsOffline = secondsOffline + monthsOffline * 30 * 24 * 60 * 60
				secondsOffline = secondsOffline + yearsOffline * 365 * 24 * 60 * 60
			else
				secondsOffline = nil
			end
			if status == "" then
				status = nil
			end
			if note == "" then
				note = nil
			end
			if officernote == "" then
				officernote = nil
			end
			local add, connect
			if name then
				playerRanks[name] = rank or UNKNOWN
				playerRankIndexes[name] = rankIndex or -1
				playerLevels[name] = level or -1
				playerClasses[name] = class or UNKNOWN
				playerZones[name] = zone or UNKNOWN
				playerStatuses[name] = status
				playerNotes[name] = note
				playerOfficerNotes[name] = officernote
				playerOfflineTimes[name] = secondsOffline
				if tmp2[name] then
					tmp2[name] = nil
				else
					add = true
				end
				if rankIndex == 0 then
					guildLeader = name
				end
			end
			if online then
				numPlayersOnline = numPlayersOnline + 1
				if name then
					playersOnline[name] = true
					if tmp[name] then
						tmp[name] = nil
					else
						connect = true
					end
				end
			end
			if add then
				self:DispatchEvent("MemberAdded", name)
			end
			if connect then
				self:DispatchEvent("MemberConnected", name)
			end
		end
		for k in pairs(tmp2) do
			tmp2[k] = nil
			self:DispatchEvent("MemberRemoved", k)
		end
		for k in pairs(tmp) do
			tmp[k] = nil
			self:DispatchEvent("MemberDisconnected", k)
		end
		
		if self:HasEventListener("GUILD_ROSTER_UPDATE") then
			self:AddTimer("LibRollCall20-GuildRoster", 15, GuildRoster)
		end
	else
		for name in pairs(playerLevels) do
			playersOnline[name] = nil
			playerRanks[name] = nil
			playerRankIndexes[name] = nil
			playerLevels[name] = nil
			playerClasses[name] = nil
			playerZones[name] = nil
			playerStatuses[name] = nil
			playerNotes[name] = nil
			playerOfficerNotes[name] = nil
		end
		numPlayersOnline = 0
		numPlayersTotal = 0
		guildLeader = nil
	end
	self:DispatchEvent("Updated")
end

if IsInGuild() then
	RollCall:AddTimer("LibRollCall20-GuildRoster", 15, GuildRoster)
	RollCall:AddEventListener("GUILD_ROSTER_UPDATE", "GUILD_ROSTER_UPDATE", 1)
	GuildRoster()
end

function RollCall:GetNumOnline()
	return numPlayersOnline
end

function RollCall:GetNumTotal()
	return numPlayersTotal
end

local playerName = UnitName("player")

function RollCall:HasMember(name)
	return not not playerLevels[name or playerName]
end
precondition(RollCall, 'HasMember', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:IsMemberOnline(name)
	return not not playersOnline[name or playerName]
end
precondition(RollCall, 'IsMemberOnline', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetRank(name)
	return playerRanks[name or playerName]
end
precondition(RollCall, 'GetRank', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetRankIndex(name)
	return playerRankIndexes[name or playerName]
end
precondition(RollCall, 'GetRankIndex', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetLevel(name)
	return playerLevels[name or playerName]
end
precondition(RollCall, 'GetLevel', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetClass(name)
	return playerClasses[name or playerName]
end
precondition(RollCall, 'GetClass', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetEnglishClass(name)
	if not BC then
		BC = Rock("LibBabble-Class-3.0", false, true)
		if not BC then
			if not old_BC then
				old_BC = Rock("Babble-Class-2.2", false, true)
				if not old_BC then
					error("Cannot call `GetClassHexColor' without LibBabble-Class-3.0 or Babble-Class-2.2 loaded.", 2)
				end
			end
		end
	end
	local class = playerClasses[name or playerName]
	if class then
		if BC then
			return BC:GetReverseLookupTable()[name]
		elseif old_BC then
			return old_BC:HasReverseTranslation(name) and old_BC:GetReverseTranslation(name)
		end
	else
		return nil
	end
end
precondition(RollCall, 'GetEnglishClass', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetClassColor(name)
	if not BC then
		BC = Rock("LibBabble-Class-3.0", false, true)
		if not BC then
			if not old_BC then
				old_BC = Rock("Babble-Class-2.2", false, true)
				if not old_BC then
					error("Cannot call `GetClassHexColor' without LibBabble-Class-3.0 or Babble-Class-2.2 loaded.", 2)
				end
			end
		end
	end
	local class = playerClasses[name or playerName]
	if class then
		if BC then
			local english = BC:GetReverseLookupTable()[class]
			if english then
				english = english:upper()
				local color = RAID_CLASS_COLORS[english]
				if color then
					return color.r, color.g, color.b
				end
			end
		elseif old_BC then
			return old_BC:GetColor(class)
		end
	else
		return 0.8, 0.8, 0.8
	end
end
precondition(RollCall, 'GetClassColor', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetClassHexColor(name)
	if not BC then
		BC = Rock("LibBabble-Class-3.0", false, true)
		if not BC then
			if not old_BC then
				old_BC = Rock("Babble-Class-2.2", false, true)
				if not old_BC then
					error("Cannot call `GetClassHexColor' without LibBabble-Class-3.0 or Babble-Class-2.2 loaded.", 2)
				end
			end
		end
	end
	local class = playerClasses[name or playerName]
	if class then
		if BC then
			local english = BC:GetReverseLookupTable()[class]
			if english then
				english = english:upper()
				local color = RAID_CLASS_COLORS[english]
				if color then
					return ("%02x%02x%02x"):format(color.r*255, color.g*255, color.b*255)
				end
			end
		elseif old_BC then
			return old_BC:GetHexColor(class)
		end
	else
		return "cccccc"
	end
end
precondition(RollCall, 'GetClassHexColor', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetZone(name)
	return playerZones[name or playerName]
end
precondition(RollCall, 'GetZone', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetEnglishZone(name)
	if not BZ then
		BZ = Rock("LibBabble-Zone-3.0", false, true)
		if not BZ then
			if not old_BZ then
				old_BZ = Rock("Babble-Zone-2.2", false, true)
				if not old_BZ then
					error("Cannot call `GetEnglishZone' without LibBabble-Zone-3.0 or Babble-Zone-2.2 loaded.", 2)
				end
			end
		end
	end
	local zone = playerZones[name or playerName]
	if zone ~= UNKNOWN then
		if BZ then
			return BZ:GetReverseLookupTable()[zone]
		elseif old_BZ then
			return BZ:HasReverseTranslation(zone) and BZ:GetReverseTranslation(zone) or "Unknown"
		end
	else
		return "Unknown"
	end
end
precondition(RollCall, 'GetEnglishZone', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetStatus(name)
	return playerStatuses[name or playerName]
end
precondition(RollCall, 'GetStatus', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetNote(name)
	return playerNotes[name or playerName]
end
precondition(RollCall, 'GetNote', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetOfficerNote(name)
	return playerOfficerNotes[name or playerName]
end
precondition(RollCall, 'GetOfficerNote', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetSecondsOffline(name)
	return playerOfflineTimes[name or playerName]
end
precondition(RollCall, 'GetSecondsOffline', function(self, name)
	argCheck(name, 2, "string", "nil")
end)

function RollCall:GetGuildName()
	return (GetGuildInfo('player'))
end

function RollCall:GetGuildLeader()
	return guildLeader
end

local sorts; sorts = {
	NAME = function(a, b)
		return a < b
	end,
	CLASS =	function(a, b)
		local playerClasses_a = playerClasses[a]
		local playerClasses_b = playerClasses[b]
		if playerClasses_a < playerClasses_b then
			return true
		elseif playerClasses_a > playerClasses_b then
			return false
		else
			local playerLevels_a = playerLevels[a]
			local playerLevels_b = playerLevels[b]
			if playerLevels_a < playerLevels_b then
				return true
			elseif playerLevels_a > playerLevels_b then
				return false
			else
				return a < b
			end
		end
	end,
	LEVEL =	function(a,b)
		local playerLevels_a = playerLevels[a]
		local playerLevels_b = playerLevels[b]
		if playerLevels_a < playerLevels_b then
			return true
		elseif playerLevels_a > playerLevels_b then
			return false
		else
			local playerClasses_a = playerClasses[a]
			local playerClasses_b = playerClasses[b]
			if playerClasses_a < playerClasses_b then
				return true
			elseif playerClasses_a > playerClasses_b then
				return false
			else
				return a < b
			end
		end
	end,
	ZONE = function(a, b)
		local playerZones_a = playerZones[a]
		local playerZones_b = playerZones[b]
		if playerZones_a < playerZones_b then
			return true
		elseif playerZones_a > playerZones_b then
			return false
		else
			return sorts.CLASS(a, b)
		end
	end,
	RANK = function(a, b)
		local playerRanks_a = playerZones[a]
		local playerRanks_b = playerZones[b]
		if playerRanks_a < playerRanks_b then
			return true
		elseif playerRanks_a > playerRanks_b then
			return false
		else
			return sorts.CLASS(a, b)
		end
	end,
}

local iter = function(t)
	local n = t.n
	n = n + 1
	t.n = n
	return t[n] or del(t)
end
function RollCall:GetIterator(sort, includeOffline)
	local sortFunc = sorts[sort or "NAME"]
	
	local tmp = newList()
	for k in pairs(tmp) do
		tmp[k] = nil
	end
	
	for k in pairs(includeOffline and playerLevels or playersOnline) do
		tmp[#tmp+1] = k
	end
	
	table.sort(tmp, sortFunc)
	tmp.n = 0
	
	return iter, tmp, nil
end
precondition(RollCall, 'GetSecondsOffline', function(self, sort, includeOffline)
	argCheck(sort, 2, "string", "nil")
	if not sorts[sort or "NAME"] then
		error(('Argument #2 must be "NAME", "LEVEL", "CLASS", "ZONE", "RANK", or nil, got %q.'):format(sort), 3)
	end
	argCheck(includeOffline, 3, "boolean", "nil")
end)

Rock:FinalizeLibrary(MAJOR_VERSION)
