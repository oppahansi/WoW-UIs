local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = tonumber(("$Revision: 66866 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

local function Threat_func(unit) return nil end
local function MaxThreat_func(unit) return nil end
local function HasThreat_func(unit) return nil end

local ThreatLib
DogTag:AddAddonFinder("Unit", "LibStub", "Threat-2.0", function(v)
	ThreatLib = v
	local IterateUnitsWithGUID = DogTag_Unit.IterateUnitsWithGUID
	ThreatLib.RegisterCallback(DogTag_Unit, "ThreatUpdated", function(event, srcGuid, dstGuid)
		for unit in IterateUnitsWithGUID(srcGuid) do
			DogTag:FireEvent("Threat", unit)
		end
		for unit in IterateUnitsWithGUID(dstGuid) do
			DogTag:FireEvent("Threat", unit)
		end
	end)
	local playerGuid
	if IsLoggedIn() then
		playerGuid = UnitGUID("player")
	else
		DogTag:AddEventHandler("Unit", "PLAYER_LOGIN", function()
			playerGuid = UnitGUID("player")
		end)
	end
	function Threat_func(unit)
		if UnitIsFriend("player", unit) then
			if UnitExists("target") then
				return math.floor(ThreatLib:GetThreat(UnitGUID(unit), UnitGUID("target")) + 0.5)
			else
				return 0
			end
		else
			return math.floor(ThreatLib:GetThreat(playerGuid, UnitGUID(unit)) + 0.5)
		end
	end
	function MaxThreat_func(unit)
		if UnitIsFriend("player", unit) then
			if UnitExists("target") then
				return math.floor(ThreatLib:GetMaxThreatOnTarget(UnitGUID("target")) + 0.5)
			else
				return 0
			end
		else
			return math.floor(ThreatLib:GetMaxThreatOnTarget(UnitGUID(unit)) + 0.5)
		end
	end
	function HasThreat_func(unit)
		if UnitIsFriend("player", unit) then
			if UnitExists("target") then
				return ThreatLib:GetThreat(UnitGUID(unit), UnitGUID("target")) > 0
			else
				return false
			end
		else
			return ThreatLib:GetThreat(playerGuid, UnitGUID(unit)) > 0
		end
	end
end)

DogTag:AddTag("Unit", "Threat", {
	code = function(args)
		return Threat_func
	end,
	dynamicCode = true,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "nil;number",
	events = "Threat#$unit",
	doc = L["Return the current threat that you have against enemy unit or that friendly unit has against your target, if Threat-2.0 is available"],
	example = '[Threat] => "50"',
	category = L["Threat"]
})

DogTag:AddTag("Unit", "MaxThreat", {
	code = function(args)
		return MaxThreat_func
	end,
	dynamicCode = true,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "nil;number",
	events = "Threat#$unit",
	doc = L["Return the maximum threat that group members have against enemy unit or that group members have against your target, if ThreatLib is available"],
	example = '[MaxThreat] => "80"',
	category = L["Threat"]
})

DogTag:AddTag("Unit", "PercentThreat", {
	alias = [=[(Threat(unit=unit) / MaxThreat(unit=unit) * 100):Round(1)]=],
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the percentage threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[PercentThreat] => "62.5"; [PercentThreat:Percent] => "62.5%"',
	category = L["Threat"]
})


DogTag:AddTag("Unit", "MissingThreat", {
	alias = "MaxThreat(unit=unit) - Threat(unit=unit)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the missing threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[MissingThreat] => "30"',
	category = L["Threat"]
})

DogTag:AddTag("Unit", "FractionalThreat", {
	alias = "Concatenate(Threat(unit=unit), '/', MaxThreat(unit=unit))",
	arg = {
		'unit', 'string;undef', 'player'
	},
	doc = L["Return the current and maximum threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[FractionalThreat] => "50/80"',
	category = L["Threat"]
})

DogTag:AddTag("Unit", "HasThreat", {
	code = function(args)
		return HasThreat_func
	end,
	dynamicCode = true,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "boolean",
	events = "Threat#$unit",
	doc = L["Return True if you have threat against enemy unit or friendly unit has threat against your target and if ThreatLib is available"],
	example = ('[HasThreat] => %q; [HasThreat] => ""'):format(L["True"]),
	category = L["Threat"]
})

end