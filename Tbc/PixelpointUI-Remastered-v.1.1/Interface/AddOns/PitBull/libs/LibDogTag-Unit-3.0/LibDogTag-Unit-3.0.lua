--[[
Name: LibDogTag-3.0
Revision: $Rev: 68104 $
Author: Cameron Kenneth Knight (ckknight@gmail.com)
Website: http://www.wowace.com/
Description: A library to provide a markup syntax
]]

local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = tonumber(("$Revision: 68104 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

local frame
if DogTag_Unit.oldLib and DogTag_Unit.oldLib.frame then
	frame = DogTag_Unit.oldLib.frame
	frame:UnregisterAllEvents()
	frame:SetScript("OnEvent", nil)
	frame:SetScript("OnUpdate", nil)
	frame:Show()
else
	frame = CreateFrame("Frame")
end
DogTag_Unit.frame = frame
frame:RegisterAllEvents()
frame:SetScript("OnEvent", function(this, event, ...)
	if (...) == "target" then
	 	if UnitIsUnit("mouseover", "target") then
			DogTag:FireEvent(event, "mouseover", select(2, ...))
		end
		DogTag:FireEvent(event, "playertarget", select(2, ...))
	elseif (...) == "pet" then
		DogTag:FireEvent(event, "playerpet", select(2, ...))
	elseif type((...)) == "string" then
	 	local num = (...):match("^partypet(%d)$")
		if num then
			DogTag:FireEvent(event, "party" .. num .. "pet", select(2, ...))
		end
	end
end)

local function GetNameServer(unit)
	local name, realm = UnitName(unit)
	if name then
		if realm and realm ~= "" then
			return name .. "-" .. realm
		else
			return name
		end
	end
end
DogTag_Unit.GetNameServer = GetNameServer

local UnitToLocale = {player = L["Player"], target = L["Target"], pet = L["%s's pet"]:format(L["Player"]), focus = L["Focus-target"], mouseover = L["Mouse-over"]}
setmetatable(UnitToLocale, {__index=function(self, unit)
	if unit:find("pet$") then
		local nonPet = unit:sub(1, -4)
		self[unit] = L["%s's pet"]:format(self[nonPet])
		return self[unit]
	elseif not unit:find("target$") then
		if unit:find("^party%d$") then
			local num = unit:match("^party(%d)$")
			self[unit] = L["Party member #%d"]:format(num)
			return self[unit]
		elseif unit:find("^raid%d%d?$") then
			local num = unit:match("^raid(%d%d?)$")
			self[unit] = L["Raid member #%d"]:format(num)
			return self[unit]
		elseif unit:find("^partypet%d$") then
			local num = unit:match("^partypet(%d)$")
			self[unit] = UnitToLocale["party" .. num .. "pet"]
			return self[unit]
		elseif unit:find("^raidpet%d%d?$") then
			local num = unit:match("^raidpet(%d%d?)$")
			self[unit] = UnitToLocale["raid" .. num .. "pet"]
			return self[unit]
		end
		self[unit] = unit
		return unit
	end
	local nonTarget = unit:sub(1, -7)
	self[unit] = L["%s's target"]:format(self[nonTarget])
	return self[unit]
end})
DogTag.UnitToLocale = UnitToLocale

local IsLegitimateUnit = { player = true, target = true, focus = true, pet = true, playerpet = true, mouseover = true, npc = true, NPC = true }
DogTag.IsLegitimateUnit = IsLegitimateUnit
local IsNormalUnit = { player = true, target = true, focus = true, pet = true, playerpet = true, mouseover = true }
DogTag.IsNormalUnit = IsNormalUnit
for i = 1, 4 do
	IsLegitimateUnit["party" .. i] = true
	IsLegitimateUnit["partypet" .. i] = true
	IsLegitimateUnit["party" .. i .. "pet"] = true
	IsNormalUnit["party" .. i] = true
	IsNormalUnit["partypet" .. i] = true
	IsNormalUnit["party" .. i .. "pet"] = true
end
for i = 1, 40 do
	IsLegitimateUnit["raid" .. i] = true
	IsNormalUnit["raid" .. i] = true
	IsLegitimateUnit["raidpet" .. i] = true
	IsLegitimateUnit["raid" .. i .. "pet"] = true
end
setmetatable(IsLegitimateUnit, { __index = function(self, key)
	if type(key) ~= "string" then
		return false
	end
	if key:match("target$") then
		self[key] = self[key:sub(1, -7)]
		return self[key]
	end
	self[key] = false
	return false
end, __call = function(self, key)
	return self[key]
end})

local unitToGUID = {}
local function refreshGUID(unit)
	unitToGUID[unit] = UnitGUID(unit)
end

local function PARTY_MEMBERS_CHANGED()
	for unit in pairs(IsNormalUnit) do
		refreshGUID(unit)
		DogTag:FireEvent("UnitChanged", unit)
	end
end
DogTag:AddEventHandler("Unit", "PARTY_MEMBERS_CHANGED", PARTY_MEMBERS_CHANGED)

PARTY_MEMBERS_CHANGED()
DogTag:AddEventHandler("Unit", "PLAYER_LOGIN", PARTY_MEMBERS_CHANGED)

local t = {}
local function IterateUnitsWithGUID(guid)
	for k in pairs(t) do
		t[k] = nil
	end
	for unit, g in pairs(unitToGUID) do
		if g == guid then
			t[unit] = true
		end
	end
	return pairs(t)
end
DogTag_Unit.IterateUnitsWithGUID = IterateUnitsWithGUID

local function searchForNameTag(ast)
	if type(ast) ~= "table" then
		return false
	end
	if ast[1] == "tag" and ast[2]:lower() == "name" then
		return true
	end
	for i = 2, #ast do
		if searchForNameTag(ast[i]) then
			return true
		end
	end
	if ast.kwarg then
		for k, v in pairs(ast.kwarg) do
			if searchForNameTag(v) then
				return true
			end
		end
	end
	return false
end

DogTag:AddCompilationStep("Unit", "start", function(t, ast, kwargTypes, extraKwargs)
	if kwargTypes["unit"] then
		t[#t+1] = [=[if not DogTag.IsLegitimateUnit[]=]
		t[#t+1] = extraKwargs["unit"][1]
		t[#t+1] = [=[] then]=]
		t[#t+1] = "\n"
		t[#t+1] = [=[return ("Bad unit: %q"):format(]=]
		t[#t+1] = extraKwargs["unit"][1]
		t[#t+1] = [=[), nil;]=]
		t[#t+1] = "\n"
		t[#t+1] = [=[end;]=]
		t[#t+1] = "\n"
		t[#t+1] = [=[if ]=]
		t[#t+1] = extraKwargs["unit"][1]
		t[#t+1] = [=[ ~= "player" and not UnitExists(]=]
		t[#t+1] = extraKwargs["unit"][1]
		t[#t+1] = [=[) then]=]
		t[#t+1] = "\n"
		t[#t+1] = [=[return ]=]
		if searchForNameTag(ast) then
			t[#t+1] = [=[DogTag.UnitToLocale[]=]
			t[#t+1] = extraKwargs["unit"][1]
			t[#t+1] = [=[]]=]
		else
			t[#t+1] = [=[nil]=]
		end
		t[#t+1] = [=[, nil;]=]
		t[#t+1] = "\n"
		t[#t+1] = [=[end;]=]
		t[#t+1] = "\n"
	end
end)

DogTag:AddCompilationStep("Unit", "tag", function(ast, t, tag, tagData, kwargs, extraKwargs, compiledKwargs)
	if compiledKwargs["unit"] and kwargs["unit"] ~= extraKwargs then
		if type(kwargs["unit"]) ~= "table" then
		 	if not IsLegitimateUnit[kwargs["unit"]] then
				t[#t+1] = [=[do]=]
				t[#t+1] = "\n"
				t[#t+1] = [=[return ]=]
				t[#t+1] = [=[("Bad unit: %q"):format(tostring(]=]
				t[#t+1] = compiledKwargs["unit"][1]
				t[#t+1] = [=[));]=]
				t[#t+1] = "\n"
				t[#t+1] = [=[end;]=]
				t[#t+1] = "\n"
			end
		else
			t[#t+1] = [=[if ]=]
			t[#t+1] = compiledKwargs["unit"][1]
			t[#t+1] = [=[ and not DogTag.IsLegitimateUnit[]=]
			t[#t+1] = compiledKwargs["unit"][1]
			t[#t+1] = [=[] then]=]
			t[#t+1] = "\n"
			t[#t+1] = [=[return ]=]
			t[#t+1] = [=[("Bad unit: %q"):format(tostring(]=]
			t[#t+1] = compiledKwargs["unit"][1]	
			t[#t+1] = [=[));]=]
			t[#t+1] = "\n"
			t[#t+1] = [=[end;]=]
			t[#t+1] = "\n"
		end
	end
	if tag == "IsUnit" then
		if type(kwargs["other"]) ~= "table" then
		 	if not IsLegitimateUnit[kwargs["other"]] then
				t[#t+1] = [=[do]=]
				t[#t+1] = "\n"
				t[#t+1] = [=[return ]=]
				t[#t+1] = [=[("Bad unit: %q"):format(tostring(]=]
				t[#t+1] = compiledKwargs["other"][1]
				t[#t+1] = [=[));]=]
				t[#t+1] = "\n"
				t[#t+1] = [=[end;]=]
				t[#t+1] = "\n"
			end
		else
			t[#t+1] = [=[if not DogTag.IsLegitimateUnit[]=]
			t[#t+1] = compiledKwargs["other"][1]
			t[#t+1] = [=[] then]=]
			t[#t+1] = "\n"
			t[#t+1] = [=[return ]=]
			t[#t+1] = [=[("Bad unit: %q"):format(tostring(]=]
			t[#t+1] = compiledKwargs["other"][1]	
			t[#t+1] = [=[));]=]
			t[#t+1] = "\n"
			t[#t+1] = [=[end;]=]
			t[#t+1] = "\n"
		end
	end
end)

DogTag:AddCompilationStep("Unit", "tagevents", function(ast, t, u, tag, tagData, kwargs, extraKwargs, compiledKwargs, events, returns)
	if compiledKwargs["unit"] and kwargs["unit"] ~= extraKwargs and kwargs["unit"] ~= "player" then
		t[#t+1] = [=[if ]=]
		t[#t+1] = compiledKwargs["unit"][1]
		t[#t+1] = [=[ and UnitExists(]=]
		t[#t+1] = compiledKwargs["unit"][1]
		t[#t+1] = [=[) then]=]
		t[#t+1] = "\n"
		u[#u+1] = [=[end;]=]
		u[#u+1] = "\n"
		if not returns["boolean"] then
			returns["nil"] = true
		end
	end
end)

DogTag:AddEventHandler("Unit", "PLAYER_TARGET_CHANGED", function(event, ...)
	refreshGUID("target")
	DogTag:FireEvent("UnitChanged", "target")
	DogTag:FireEvent("UnitChanged", "playertarget")
end)

DogTag:AddEventHandler("Unit", "PLAYER_FOCUS_CHANGED", function(event, ...)
	refreshGUID("focus")
	DogTag:FireEvent("UnitChanged", "focus")
end)

DogTag:AddEventHandler("Unit", "PLAYER_PET_CHANGED", function(event, ...)
	refreshGUID("pet")
	DogTag:FireEvent("UnitChanged", "pet")
end)

DogTag:AddEventHandler("Unit", "UNIT_TARGET", function(event, unit)
	DogTag:FireEvent("UnitChanged", unit .. "target")
end)

DogTag:AddEventHandler("Unit", "UNIT_PET", function(event, unit)
	local unit_pet = unit .. "pet"
	refreshGUID(unit_pet)
	DogTag:FireEvent("UnitChanged", unit_pet)
end)

local inMouseover = false
DogTag:AddEventHandler("Unit", "UPDATE_MOUSEOVER_UNIT", function(event, ...)
	inMouseover = true
	refreshGUID("mouseover")
	DogTag:FireEvent("UnitChanged", "mouseover")
end)

local fsToKwargs = DogTag.fsToKwargs
local fsToNSList = DogTag.fsToNSList
local fsNeedUpdate = DogTag.fsNeedUpdate
local fsNeedQuickUpdate = DogTag.fsNeedQuickUpdate
local unpackNamespaceList = DogTag.unpackNamespaceList

local nsListHasUnit = setmetatable({}, { __index = function(self, key)
	for _, ns in ipairs(unpackNamespaceList[key]) do
		if ns == "Unit" then
			self[key] = true
			return true
		end
	end
	self[key] = false
	return false
end })

local nextUpdateWackyUnitsTime = 0
DogTag:AddTimerHandler("Unit", function(num, currentTime)
	local exists = not not UnitExists("mouseover")
	if inMouseover ~= exists then
		inMouseover = exists
		DogTag:FireEvent("UnitChanged", "mouseover")
	end
	if currentTime >= nextUpdateWackyUnitsTime then
		nextUpdateWackyUnitsTime = currentTime + 0.25
		DogTag:FireEvent("UpdateWackyUnits")
		for fs, nsList in pairs(fsToNSList) do
			if nsListHasUnit[nsList] then
				local kwargs = fsToKwargs[fs]
				if kwargs and kwargs["unit"] and not IsNormalUnit[kwargs["unit"]] then
					fsNeedUpdate[fs] = true
				end
			end
		end
	end
end)

DogTag:AddTimerHandler("Unit", function(num, currentTime)
	local exists = not not UnitExists("mouseover")
	if not exists then
		for fs, nsList in pairs(fsToNSList) do
			if nsListHasUnit[nsList] then
				local kwargs = fsToKwargs[fs]
				if kwargs and kwargs["unit"] == "mouseover" then
					fsNeedUpdate[fs] = nil
					fsNeedQuickUpdate[fs] = nil
				end
			end
		end
	end
end, 9)

DogTag:AddCompilationStep("Unit", "tagevents", function(ast, t, u, tag, tagData, kwargs, extraKwargs, compiledKwargs, events, returns)
	if compiledKwargs["unit"] then
		events["UnitChanged#$unit"] = true
		events["PARTY_MEMBERS_CHANGED"] = true
		events["PLAYER_ENTERING_WORLD"] = true
		if kwargs["unit"] ~= extraKwargs and (type(kwargs["unit"]) ~= "string" or not IsNormalUnit[kwargs["unit"]]) then
			events["UpdateWackyUnits"] = true
		end
	end
end)

end