--[[
Name: LibTalentQuery-1.0
Revision: $Rev: 67107 $
Author: Rich Martel (richmartel@gmail.com)
Documentation: http://wowace.com/wiki/LibTalentQuery-1.0
SVN: http://svn.wowace.com/wowace/trunk/LibTalentQuery-1.0
Description: Library to help with querying unit talents
Dependancies: LibStub, CallbackHandler-1.0
License: LGPL v2.1

Example Usage:
	local TalentQuery = LibStub:GetLibrary("LibTalentQuery-1.0")
	TalentQuery.RegisterCallback(self, "TalentQuery_Ready")
	local spec = {}
	...
	if UnitIsUnit(unit, "player") then
		self:TalentQuery_Ready(_, UnitName(unit))
	else
		TalentQuery:Query(unit)
	end
	...
	function MyAddon:TalentQuery_Ready(e, name, realm)
		local namerealm = realm and realm ~= "" and name .. "-" .. realm or name
		local isnotplayer = (name ~= UnitName("player"))
		for tab = 1, GetNumTalentTabs(isnotplayer) do
			local treename, _, pointsspent = GetTalentTabInfo(tab, isnotplayer)
			if pointsspent > 30 then
				spec[namerealm] = treename
			end
		end
		...
	end
]]

local MAJOR, MINOR = "LibTalentQuery-1.0", "$Rev: 67107 $"

local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local INSPECTDELAY = 1
local INSPECTTIMEOUT = 15
if not lib.events then
	lib.events = LibStub("CallbackHandler-1.0"):New(lib)
end

local frame = lib.frame
if not frame then
	frame = CreateFrame("Frame", MAJOR .. "_Frame")
	lib.frame = frame
end
frame:UnregisterAllEvents()
frame:RegisterEvent("INSPECT_TALENT_READY")
frame:SetScript("OnEvent", function(this, event, ...)
	return lib[event](lib, ...)
end)

local CheckInspectQueue
local lastUpdateTime = 0
local inspectingUnitName = nil
local lastInspectTime = nil
frame:SetScript("OnUpdate", function(this, elapsed)
	lastUpdateTime = lastUpdateTime + elapsed
	if lastUpdateTime > INSPECTDELAY then
		CheckInspectQueue()
		lastUpdateTime = 0
	end
end)
frame:Hide()

local inspectQueue = lib.inspectQueue
if not inspectQueue then
	inspectQueue = {}
	lib.inspectQueue = inspectQueue
end
if next(inspectQueue) then
	frame:Show()
end

local UnitIsPlayer = _G.UnitIsPlayer
local UnitName = _G.UnitName

local function UnitNameRealm(unit)
	local name, realm = UnitName(unit)
	local namerealm = realm and realm ~= "" and name .. "-" .. realm or name
	return namerealm
end

local function NameToUnitID(name)
	local prefix, min, max = "raid", 0, GetNumRaidMembers()
	if max == 0 then
		prefix, min, max = "party", 0, GetNumPartyMembers()
	end
	for i = min, max + 3 do
		if i == 0 then
			unit = "player"
		elseif i == max + 1 then
			unit = "target"
		elseif i == max + 2 then
			unit = "focus"
		elseif i == max + 3 then
			unit = "mouseover"
		else
			unit = prefix .. i
		end
		if unit ~= "player" and UnitIsPlayer(unit) and UnitNameRealm(unit) == name then
			return unit
		elseif UnitIsPlayer(unit .. "target") and UnitNameRealm(unit .. "target") == name then
			return unit
		elseif i <= max and UnitIsPlayer(unit .. "pettarget") and UnitNameRealm(unit .. "pettarget") == name then
			return unit
		end
	end
	return nil
end

function lib:Query(unit)
	if type(unit) ~= "string" then
		error(("Bad argument #2 to 'Query'. Expected %q, received %q (%s)"):format("string", type(unit), tostring(unit)), 2)
	elseif not UnitExists(unit) or not UnitIsPlayer(unit) then
		error(("Bad argument #2 to 'Query'. %q is not a valid player unit"):format(tostring(unit)), 2)
	elseif not UnitExists(unit) or not UnitIsPlayer(unit) then
		error(("Bad argument #2 to 'Query'. %q does not require a server query before reading talents"):format("player"), 2)
	else
		inspectQueue[UnitNameRealm(unit)] = true
		local shown = frame:IsShown()
		frame:Show()
		if not shown then
			CheckInspectQueue()
		end
	end
end

function CheckInspectQueue()
	if inspectingUnitName and lastInspectTime and lastInspectTime < GetTime() - INSPECTTIMEOUT then
		inspectQueue[inspectingUnitName] = true
		lastInspectTime = nil
		inspectingUnitName = nil
	end
	if _G.InspectFrame and _G.InspectFrame:IsShown() then
		return
	end
	if not inspectingUnitName then
		for name in pairs(inspectQueue) do
			local unit = NameToUnitID(name)
			if unit and UnitIsVisible(unit) and UnitIsConnected(unit) and not UnitCanAttack("player", unit) and not UnitCanAttack(unit, "player") and CanInspect(unit) then
				inspectingUnitName = name
				lastInspectTime = GetTime()
				inspectQueue[inspectingUnitName] = nil
				NotifyInspect(unit)
				break
			else
				inspectQueue[name] = nil
			end
		end
	end
	if not next(inspectQueue) then
		frame:Hide()
	end
end

if not lib.NotifyInspect then -- don't hook twice
	hooksecurefunc("NotifyInspect", function(...) return lib:NotifyInspect(...) end)
end
function lib:NotifyInspect(unit)
	-- If this library did not call NotifyInspect, and we are waiting for a query, then
	-- stop waiting, and put the inspectingUnitName back on the queue.
	if inspectingUnitName and inspectingUnitName ~= UnitNameRealm(unit) then
		inspectQueue[inspectingUnitName] = true
		inspectingUnitName = nil
		lastInspectTime = nil
	end
end

function lib:INSPECT_TALENT_READY()
	if not inspectingUnitName then
		return
	end
	local name, realm = ("-"):split(inspectingUnitName, 2)
	inspectingUnitName = nil
	lastInspectTime = nil
	self.events:Fire("TalentQuery_Ready", name, realm)
end
