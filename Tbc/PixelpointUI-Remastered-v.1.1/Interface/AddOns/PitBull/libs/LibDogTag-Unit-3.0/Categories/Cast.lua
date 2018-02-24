local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = tonumber(("$Revision: 66768 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

local L = DogTag.L
local newList = DogTag.newList
local del = DogTag.del
local IsNormalUnit = DogTag.IsNormalUnit
local hasEvent = DogTag.hasEvent

local castData = setmetatable({}, {__index=function(self, unit)
	local data = newList()
	self[unit] = data
	
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)
	local casting = true
	
	if not spell then
		spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
		casting = false
		
		if not spell then
			return data
		end
	end
	data.spell = spell
	data.rank = rank and tonumber(rank:match("%d+"))
	data.displayName = displayName
--	data.icon = icon
	data.startTime = startTime / 1000
	data.endTime = endTime / 1000
	data.delay = 0
	data.casting = casting
	data.stopTime = nil
	data.stopMessage = nil
	
	return data
end})

DogTag:AddTimerHandler("Unit", function(num, currentTime)
	for unit, data in pairs(castData) do
		if not IsNormalUnit[unit] then
			castData[unit] = del(data)
		elseif not data.stopTime and data.endTime and currentTime > data.endTime then
			if data.casting then
			 	if not UnitIsUnit("player", unit) then
					data.stopTime = currentTime
				end
			else
				data.stopTime = currentTime
			end
		end
	end
end)

DogTag:AddEventHandler("Unit", "UnitChange", function(event, unit)
	if rawget(castData, unit) then
		castData[unit] = del(castData[unit])
	end
end)

local nextSpell, nextRank, nextTarget
local lastPlayerEvent

local function UNIT_SPELLCAST_SENT(event, unit, spell, rank, target)
	if not hasEvent('Cast') then
		return
	end
	if unit == "player" then
		nextSpell = spell
		nextRank = rank and tonumber(rank:match("%d+"))
		nextTarget = target ~= "" and target or nil
		lastPlayerEvent = "UNIT_SPELLCAST_SENT"
	end
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_SENT", UNIT_SPELLCAST_SENT)

local function UNIT_SPELLCAST_START(event, unit)
	if not hasEvent('Cast') then
		return
	end
	if rawget(castData, unit) then
		castData[unit] = del(castData[unit])
	end
	if unit == "player" then
		if castData[unit].spell == nextSpell and castData[unit].rank == nextRank then
			castData[unit].target = nextTarget
		end
		lastPlayerEvent = "UNIT_SPELLCAST_START"
	end
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_START", UNIT_SPELLCAST_START)
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_CHANNEL_START", UNIT_SPELLCAST_START)

local function UNIT_SPELLCAST_STOP(event, unit)
	if not hasEvent('Cast') or not rawget(castData, unit) or not castData[unit].casting or castData[unit].fading then
		return
	end
	castData[unit].stopTime = GetTime()
	if unit == "player" then
		lastPlayerEvent = "UNIT_SPELLCAST_STOP"
	end
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_STOP", UNIT_SPELLCAST_STOP)

local function UNIT_SPELLCAST_SUCCEEDED(event, unit, name, rank)
	if not hasEvent('Cast') or unit ~= "player" or lastPlayerEvent ~= "UNIT_SPELLCAST_SENT" then
		return
	end
	lastPlayerEvent = "UNIT_SPELLCAST_SUCCEEDED"
	
	if rawget(castData, "player") then
		castData["player"] = del(castData["player"])
	end
	
	local currentTime = GetTime()
	
	rank = rank and tonumber(rank:match("%d+"))
	local t = newList()
	t.spell = name
	t.rank = rank
	t.displayName = name
	if name == nextSpell and rank == nextRank then
		t.target = nextTarget
	end
	t.startTime = currentTime
	t.endTime = currentTime
	t.delay = 0
	t.casting = true
	t.stopTime = currentTime
	t.stopMessage = nil
	castData["player"] = t
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_SUCCEEDED", UNIT_SPELLCAST_SUCCEEDED)

local function UNIT_SPELLCAST_FAILED(event, unit)
	if not hasEvent('Cast') or not rawget(castData, unit) or castData[unit].fading then
		return
	end
	castData[unit].stopTime = GetTime()
	castData[unit].stopMessage = _G.FAILED
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_FAILED", UNIT_SPELLCAST_FAILED)

local function UNIT_SPELLCAST_INTERRUPTED(event, unit)
	if not hasEvent('Cast') or not rawget(castData, unit) then
		return
	end
	castData[unit].stopTime = GetTime()
	castData[unit].stopMessage = _G.INTERRUPTED
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_INTERRUPTED", UNIT_SPELLCAST_INTERRUPTED)
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_CHANNEL_INTERRUPTED", UNIT_SPELLCAST_INTERRUPTED)

local function UNIT_SPELLCAST_DELAYED(event, unit)
	if not hasEvent('Cast') or not rawget(castData, unit) or not castData[unit].casting or castData[unit].stopTime then
		return
	end
	
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)

	if not spell or not startTime or not endTime then
		return
	end
	
	local oldStart = castData[unit].startTime
	
	startTime = startTime / 1000
	castData[unit].startTime = startTime
	castData[unit].endTime = endTime / 1000

	castData[unit].delay = castData[unit].delay + (startTime - oldStart)
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_DELAYED", UNIT_SPELLCAST_DELAYED)

local function UNIT_SPELLCAST_CHANNEL_UPDATE(event, unit)
	if not hasEvent('Cast') or not rawget(castData, unit) or castData[unit].casting or castData[unit].stopTime then
		return
	end
	
	DogTag:FireEvent("Cast", unit)
	
	local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
	if not spell then
		for k,v in pairs(castData[unit]) do
			castData[unit][k] = nil
		end
		return
	end
	
	local oldStart = castData[unit].startTime
	startTime = startTime / 1000
	castData[unit].startTime = startTime
	castData[unit].endTime = endTime / 1000
	castData[unit].delay = castData[unit].delay + (oldStart - startTime)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_CHANNEL_UPDATE", UNIT_SPELLCAST_CHANNEL_UPDATE)

local function UNIT_SPELLCAST_CHANNEL_STOP(event, unit)
	if not hasEvent('Cast') or not rawget(castData, unit) or castData[unit].casting or castData[unit].stopTime then
		return
	end
	
	castData[unit].stopTime = GetTime()
	
	DogTag:FireEvent("Cast", unit)
end
DogTag:AddEventHandler("Unit", "UNIT_SPELLCAST_CHANNEL_STOP", UNIT_SPELLCAST_CHANNEL_STOP)

DogTag:AddTag("Unit", "CastName", {
	code = function(unit)
		return castData[unit].spell
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "string;nil",
	events = "Cast",
	doc = L["Return the current or last spell to be cast"],
	example = ('[CastName] => %q'):format(L["Holy Light"]),
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastTarget", {
	code = function(unit)
		return castData[unit].target
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "string;nil",
	events = "Cast",
	doc = L["Return the current cast target name"],
	example = ('[CastTarget] => %q'):format((UnitName("player"))),
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastRank", {
	code = function(unit)
		return castData[unit].rank
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number;nil",
	events = "Cast",
	doc = L["Return the current cast rank"],
	example = '[CastRank] => "4"; [CastRank:Romanize] => "IV"',
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastStartDuration", {
	code = function(unit)
		local t = castData[unit].startTime
		if t then
			return GetTime() - t
		else
			return nil
		end
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number;nil",
	events = "FastUpdate;Cast#$unit",
	doc = L["Return the duration since the current cast started"],
	example = '[CastStartDuration] => "3.012367"; [CastStartDuration:FormatDuration] => "0:03"',
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastEndDuration", {
	code = function(unit)
		local t = castData[unit].endTime
		if t then
			return t - GetTime()
		else
			return nil
		end
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number;nil",
	events = "FastUpdate;Cast#$unit",
	globals = "DogTag.__castData",
	doc = L["Return the duration until the current cast is meant to finish"],
	example = '[CastEndDuration] => "2.07151"; [CastEndDuration:FormatDuration] => "0:02"',
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastDelay", {
	code = function(unit)
		return castData[unit].delay
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number;nil",
	events = "Cast#$unit",
	doc = L["Return the number of seconds the current cast has been delayed by interruption"],
	example = '[CastDelay] => "1.49997"; [CastDelay:Round(1)] => "1.5"',
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastIsChanneling", {
	code = function(unit)
		return not castData[unit].casting
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "boolean",
	events = "Cast#$unit",
	doc = L["Return True if the current cast is a channeling spell"],
	example = ('[CastIsChanneling] => %q; [CastIsChanneling] => ""'):format(L["True"]),
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastStopDuration", {
	code = function(unit)
		local t = castData[unit].stopTime
		if t then
			return GetTime() - t
		else
			return nil
		end
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number;nil",
	events = "FastUpdate;Cast#$unit",
	doc = L["Return the duration which the current cast has been stopped, blank if not stopped yet"],
	example = '[CastStopDuration] => "2.06467"; [CastStopDuration:FormatDuration] => "0:02"; [CastStopDuration] => ""',
	category = L["Casting"]
})

DogTag:AddTag("Unit", "CastStopMessage", {
	code = function(unit)
		return castData[unit].stopMessage
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "string;nil",
	events = "Cast#$unit",
	doc = L["Return the message as to why the cast stopped, if there is an error"],
	example = ('[CastStopMessage] => %q; [CastStopMessage] => %q, [CastStopMessage] => ""'):format(_G.FAILED, _G.INTERRUPTED),
	category = L["Casting"]
})

end
