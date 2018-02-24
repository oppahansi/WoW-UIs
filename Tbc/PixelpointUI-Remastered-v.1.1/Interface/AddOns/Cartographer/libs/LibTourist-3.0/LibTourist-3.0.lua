--[[
Name: LibTourist-3.0
Revision: $Rev: 64725 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://www.wowace.com/wiki/LibTourist-3.0
SVN: http://svn.wowace.com/root/trunk/LibTourist-3.0
Description: A library to provide information about zones and instances.
Dependencies: LibBabble-Zone-3.0
License: LGPL v2.1
]]

local MAJOR_VERSION = "LibTourist-3.0"
local MINOR_VERSION = tonumber(("$Revision: 64725 $"):match("(%d+)"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end
if not LibStub("LibBabble-Zone-3.0") then error(MAJOR_VERSION .. " requires LibBabble-Zone-3.0.") end

local Tourist, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not Tourist then
	return
end
if oldLib then
	oldLib = {}
	for k, v in pairs(Tourist) do
		Tourist[k] = nil
		oldLib[k] = v
	end
end

local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

local playerLevel = 1
local _,race = UnitRace("player")
local isHorde = (race == "Orc" or race == "Troll" or race == "Tauren" or race == "Scourge" or race == "BloodElf")
local isWestern = GetLocale() == "enUS" or GetLocale() == "deDE" or GetLocale() == "frFR" or GetLocale() == "esES"

local Kalimdor, Eastern_Kingdoms, Outland = GetMapContinents()
if not Outland then
	Outland = "Outland"
end
local Azeroth = BZ["Azeroth"]

local X_Y_ZEPPELIN = "%s/%s Zeppelin"
local X_Y_BOAT = "%s/%s Boat"
local X_Y_PORTAL = "%s/%s Portal"

if GetLocale() == "zhCN" then
	X_Y_ZEPPELIN = "%s/%s 飞艇"
	X_Y_BOAT = "%s/%s 船"
	X_Y_PORTAL = "%s/%s 传送门"
elseif GetLocale() == "zhTW" then
	X_Y_ZEPPELIN = "%s/%s 飛艇"
	X_Y_BOAT = "%s/%s 船"
	X_Y_PORTAL = "%s/%s 傳送門"
elseif GetLocale() == "frFR" then
	X_Y_ZEPPELIN = "Zeppelin %s/%s"
	X_Y_BOAT = "Bateau %s/%s"
	X_Y_PORTAL = "Portail %s/%s"
end

local recZones = {}
local recInstances = {}
local lows = setmetatable({}, {__index = function() return 0 end})
local highs = setmetatable({}, getmetatable(lows))
local continents = {}
local instances = {}
local paths = {}
local types = {}
local groupSizes = {}
local factions = {}
local yardWidths = {}
local yardHeights = {}
local yardXOffsets = {}
local yardYOffsets = {}
local fishing = {}
local cost = {}
local textures = {}
local textures_rev = {}
local complexes = {}

local function PLAYER_LEVEL_UP(self)
	playerLevel = UnitLevel("player")
	for k in pairs(recZones) do
		recZones[k] = nil
	end
	for k in pairs(recInstances) do
		recInstances[k] = nil
	end
	for k in pairs(cost) do
		cost[k] = nil
	end
	for zone in pairs(lows) do
		if not self:IsHostile(zone) then
			local low, high = self:GetLevel(zone)
			if types[zone] == "Zone" or types[zone] == "PvP Zone" and low and high then
				if low <= playerLevel and playerLevel <= high then
					recZones[zone] = true
				end
			elseif types[zone] == "Battleground" and low and high then
				local playerLevel = playerLevel
				if zone == BZ["Alterac Valley"] then
					playerLevel = playerLevel - 1
				end
				if playerLevel >= low and (playerLevel == MAX_PLAYER_LEVEL or math.fmod(playerLevel, 10) >= 6) then
					recInstances[zone] = true
				end
			elseif types[zone] == "Instance" and low and high then
				if low <= playerLevel and playerLevel <= high then
					recInstances[zone] = true
				end
			end
		end
	end
end

-- minimum fishing skill to fish these zones
function Tourist:GetFishingLevel(zone)
	return fishing[zone]
end

function Tourist:GetLevel(zone)
	if types[zone] == "Battleground" then
		if zone == BZ["Eye of the Storm"] then
			return 61, 70
		elseif zone == BZ["Alterac Valley"] and playerLevel >= 61 then
			return 61, 70
		elseif zone == BZ["Alterac Valley"] then
			return 51, 60
		elseif playerLevel >= MAX_PLAYER_LEVEL then
			return MAX_PLAYER_LEVEL, MAX_PLAYER_LEVEL
		elseif playerLevel >= 60 then
			return 60, 69
		elseif playerLevel >= 50 then
			return 50, 59
		elseif playerLevel >= 40 then
			return 40, 49
		elseif playerLevel >= 30 then
			return 30, 39
		elseif playerLevel >= 20 or zone == BZ["Arathi Basin"] then
			return 20, 29
		else
			return 10, 19
		end
	end
	return lows[zone], highs[zone]
end

function Tourist:GetLevelColor(zone)
	if types[zone] == "Battleground" then
		if (playerLevel < 61 and zone == BZ["Eye of the Storm"]) or (playerLevel < 51 and zone == BZ["Alterac Valley"]) or (playerLevel < 20 and zone == BZ["Arathi Basin"]) or (playerLevel < 10 and zone == BZ["Warsong Gulch"]) then
			return 1, 0, 0
		end
		local playerLevel = playerLevel
		if zone == BZ["Alterac Valley"] or zone == "Eye of the Storm" then
			playerLevel = playerLevel - 1
		end
		if playerLevel == MAX_PLAYER_LEVEL then
			return 1, 1, 0
		end
		playerLevel = math.fmod(playerLevel, 10)
		if playerLevel <= 5 then
			return 1, playerLevel / 10, 0
		elseif playerLevel <= 7 then
			return 1, (playerLevel - 3) / 4, 0
		else
			return (9 - playerLevel) / 2, 1, 0
		end
	end
	local low, high = lows[zone], highs[zone]
	
	if low <= 0 and high <= 0 then
		-- City
		return 1, 1, 1
	elseif playerLevel == low and playerLevel == high then
		return 1, 1, 0
	elseif playerLevel <= low - 3 then
		return 1, 0, 0
	elseif playerLevel <= low then
		return 1, (playerLevel - low - 3) / -6, 0
	elseif playerLevel <= (low + high) / 2 then
		return 1, (playerLevel - low) / (high - low) + 0.5, 0
	elseif playerLevel <= high then
		return 2 * (playerLevel - high) / (low - high), 1, 0
	elseif playerLevel <= high + 3 then
		local num = (playerLevel - high) / 6
		return num, 1 - num, num
	else
		return 0.5, 0.5, 0.5
	end
end

function Tourist:GetFactionColor(zone)
	if factions[zone] == (isHorde and "Alliance" or "Horde") then
		return 1, 0, 0
	elseif factions[zone] == (isHorde and "Horde" or "Alliance") then
		return 0, 1, 0
	else
		return 1, 1, 0
	end
end

function Tourist:GetZoneYardSize(zone)
	return yardWidths[zone], yardHeights[zone]
end

local ekXOffset = 15525.32200715066
local ekYOffset = 672.3934326738229

local kalXOffset = -8310.762035321373
local kalYOffset = 1815.149000954498

function Tourist:GetYardDistance(zone1, x1, y1, zone2, x2, y2)
	local zone1_yardXOffset = yardXOffsets[zone1]
	if not zone1_yardXOffset then
		return nil
	end
	local zone2_yardXOffset = yardXOffsets[zone2]
	if not zone2_yardXOffset then
		return nil
	end
	local zone1_yardYOffset = yardYOffsets[zone1]
	local zone2_yardYOffset = yardYOffsets[zone2]
	
	local zone1_continent = continents[zone1]
	local zone2_continent = continents[zone2]
	if (zone1_continent == Outland) ~= (zone2_continent == Outland) then
		return nil
	end
	
	local zone1_yardWidth = yardWidths[zone1]
	local zone1_yardHeight = yardHeights[zone1]
	local zone2_yardWidth = yardWidths[zone2]
	local zone2_yardHeight = yardHeights[zone2]
	
	local x1_yard = zone1_yardWidth*x1
	local y1_yard = zone1_yardHeight*y1
	local x2_yard = zone2_yardWidth*x2
	local y2_yard = zone2_yardHeight*y2
	
	if zone1 ~= zone2 then
		x1_yard = x1_yard + zone1_yardXOffset
		y1_yard = y1_yard + zone1_yardYOffset
		
		x2_yard = x2_yard + zone2_yardXOffset
		y2_yard = y2_yard + zone2_yardYOffset
		
		if zone1_continent ~= zone2_continent then
			if zone1_continent == Kalimdor then
				x1_yard = x1_yard + kalXOffset
				y1_yard = y1_yard + kalYOffset
			elseif zone1_continent == Eastern_Kingdoms then
				x1_yard = x1_yard + ekXOffset
				y1_yard = y1_yard + ekYOffset
			end
		
			if zone2_continent == Kalimdor then
				x2_yard = x2_yard + kalXOffset
				y2_yard = y2_yard + kalYOffset
			elseif zone2_continent == Eastern_Kingdoms then
				x2_yard = x2_yard + ekXOffset
				y2_yard = y2_yard + ekYOffset
			end
		end
	end
	
	local x_diff = x1_yard - x2_yard
	local y_diff = y1_yard - y2_yard
	local dist_2 = x_diff*x_diff + y_diff*y_diff
	return dist_2^0.5
end

function Tourist:TransposeZoneCoordinate(x, y, zone1, zone2)
	if zone1 == zone2 then
		return x, y
	end
	
	local zone1_yardXOffset = yardXOffsets[zone1]
	if not zone1_yardXOffset then
		return nil
	end
	local zone2_yardXOffset = yardXOffsets[zone2]
	if not zone2_yardXOffset then
		return nil
	end
	local zone1_yardYOffset = yardYOffsets[zone1]
	local zone2_yardYOffset = yardYOffsets[zone2]
	
	local zone1_continent = continents[zone1]
	local zone2_continent = continents[zone2]
	if (zone1_continent == Outland) ~= (zone2_continent == Outland) then
		return nil
	end
	
	local zone1_yardWidth = yardWidths[zone1]
	local zone1_yardHeight = yardHeights[zone1]
	local zone2_yardWidth = yardWidths[zone2]
	local zone2_yardHeight = yardHeights[zone2]
	
	local x_yard = zone1_yardWidth*x
	local y_yard = zone1_yardHeight*y
	
	x_yard = x_yard + zone1_yardXOffset
	y_yard = y_yard + zone1_yardYOffset
	
	if zone1_continent ~= zone2_continent then
		if zone1_continent == Kalimdor then
			x_yard = x_yard + kalXOffset
			y_yard = y_yard + kalYOffset
		elseif zone1_continent == Eastern_Kingdoms then
			x_yard = x_yard + ekXOffset
			y_yard = y_yard + ekYOffset
		end
	
		if zone2_continent == Kalimdor then
			x_yard = x_yard - kalXOffset
			y_yard = y_yard - kalYOffset
		elseif zone2_continent == Eastern_Kingdoms then
			x_yard = x_yard - ekXOffset
			y_yard = y_yard - ekYOffset
		end
	end
	
	x_yard = x_yard - zone2_yardXOffset
	y_yard = y_yard - zone2_yardYOffset
	
	x = x_yard / zone2_yardWidth
	y = y_yard / zone2_yardHeight
	
	return x, y
end

local zonesToIterate = setmetatable({}, {__index = function(self, key)
	local t = {}
	self[key] = t
	for k,v in pairs(continents) do
		if v == key and v ~= k and yardXOffsets[k] then
			t[#t+1] = k
		end
	end
	return t
end})

local kal_yardWidth
local kal_yardHeight
local ek_yardWidth
local ek_yardHeight

function Tourist:GetBestZoneCoordinate(x, y, zone)
	if not kal_yardWidth then
		kal_yardWidth = yardWidths[Kalimdor]
		kal_yardHeight = yardHeights[Kalimdor]
		ek_yardWidth = yardWidths[Eastern_Kingdoms]
		ek_yardHeight = yardHeights[Eastern_Kingdoms]
	end
	
	local zone_yardXOffset = yardXOffsets[zone]
	if not zone_yardXOffset then
		return x, y, zone
	end
	local zone_yardYOffset = yardYOffsets[zone]
	
	local zone_yardWidth = yardWidths[zone]
	local zone_yardHeight = yardHeights[zone]
	
	local x_yard = zone_yardWidth*x
	local y_yard = zone_yardHeight*y
	
	x_yard = x_yard + zone_yardXOffset
	y_yard = y_yard + zone_yardYOffset
	
	local zone_continent = continents[zone]
	local azeroth = false
	if zone_continent == Kalimdor then
		if x_yard < 0 or y_yard < 0 or x_yard > kal_yardWidth or y_yard > kal_yardHeight then
			x_yard = x_yard + kalXOffset
			y_yard = y_yard + kalYOffset
			azeroth = true
		end
	elseif zone_continent == Eastern_Kingdoms then
		if x_yard < 0 or y_yard < 0 or x_yard > ek_yardWidth or y_yard > ek_yardHeight then
			x_yard = x_yard + ekXOffset
			y_yard = y_yard + ekYOffset
			azeroth = true
		end
	end
	if azeroth then
		local kal, ek = zone_continent ~= Kalimdor, zone_continent ~= Eastern_Kingdoms
		if kal and (x_yard < kalXOffset or y_yard < kalYOffset or x_yard > kalXOffset + kal_yardWidth or y_yard > kalYOffset + kal_yardWidth) then
			kal = false
		end
		if ek and (x_yard < ekXOffset or y_yard < ekYOffset or x_yard > ekXOffset + ek_yardWidth or y_yard > ekYOffset + ek_yardWidth) then
			ek = false
		end
		if kal then
			x_yard = x_yard - kalXOffset
			y_yard = y_yard - kalYOffset
			zone_continent = Kalimdor
		elseif ek then
			x_yard = x_yard - ekXOffset
			y_yard = y_yard - ekYOffset
			zone_continent = Eastern_Kingdoms
		else
			return x_yard / yardWidths[Azeroth], y_yard / yardHeights[Azeroth], Azeroth
		end
	end
	
	local best_zone, best_x, best_y, best_value
	
	for _,z in ipairs(zonesToIterate[zone_continent]) do
		local z_yardXOffset = yardXOffsets[z]
		local z_yardYOffset = yardYOffsets[z]
		local z_yardWidth = yardWidths[z]
		local z_yardHeight = yardHeights[z]
		
		local x_yd = x_yard - z_yardXOffset
		local y_yd = y_yard - z_yardYOffset
		
		if x_yd >= 0 and y_yd >= 0 and x_yd <= z_yardWidth and y_yd <= z_yardHeight then
			if types[z] == "City" then
				return x_yd/z_yardWidth, y_yd/z_yardHeight,  z
			end
			local x_tmp = x_yd - z_yardWidth / 2
			local y_tmp = y_yd - z_yardHeight / 2
			local value = x_tmp*x_tmp + y_tmp*y_tmp
			if not best_value or value < best_value then
				best_zone = z
				best_value = value
				best_x = x_yd/z_yardWidth
				best_y = y_yd/z_yardHeight
			end
		end
	end
	if not best_zone then
		return x_yard / yardWidths[zone_continent], y_yard / yardHeights[zone_continent], zone_continent
	end
	return best_x, best_y, best_zone
end

local function retNil() return nil end
local function retOne(object, state)
	if state == object then
		return nil
	else
		return object
	end
end

local function retNormal(t, position)
	return (next(t, position))
end

local function mysort(a,b)
	if not lows[a] then
		return false
	elseif not lows[b] then
		return true
	else	
		local aval, bval = groupSizes[a], groupSizes[b]
		if aval ~= bval then
			return aval < bval
		end
		aval, bval = lows[a], lows[b]
		if aval ~= bval then
			return aval < bval
		end
		aval, bval = highs[a], highs[b]
		if aval ~= bval then
			return aval < bval
		end
		return a < b
	end
end	
local t = {}
local function myiter(t)
	local n = t.n
	n = n + 1
	local v = t[n]
	if v then
		t[n] = nil
		t.n = n
		return v
	else
		t.n = nil
	end
end
function Tourist:IterateZoneInstances(zone)
	local inst = instances[zone]
	
	if not inst then
		return retNil
	elseif type(inst) == "table" then
		for k in pairs(t) do
			t[k] = nil
		end
		for k in pairs(inst) do
			t[#t+1] = k
		end
		table.sort(t, mysort)
		t.n = 0
		return myiter, t, nil
	else
		return retOne, inst, nil
	end
end

function Tourist:GetInstanceZone(instance)
	for k, v in pairs(instances) do
		if v then
			if type(v) == "string" then
				if v == instance then
					return k
				end
			else -- table
				for l in pairs(v) do
					if l == instance then
						return k
					end
				end
			end
		end
	end
end

function Tourist:DoesZoneHaveInstances(zone)
	return not not instances[zone]
end

local zonesInstances
local function initZonesInstances()
	if not zonesInstances then
		zonesInstances = {}
		for zone, v in pairs(lows) do
			if types[zone] ~= "Transport" then
				zonesInstances[zone] = true
			end
		end
	end
	initZonesInstances = nil
end

function Tourist:IterateZonesAndInstances()
	if initZonesInstances then
		initZonesInstances()
	end
	return retNormal, zonesInstances, nil
end

local function zoneIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and (types[k] == "Instance" or types[k] == "Battleground") do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateZones()
	if initZonesInstances then
		initZonesInstances()
	end
	return zoneIter, nil, nil
end

local function instanceIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and (types[k] ~= "Instance" and types[k] ~= "Battleground") do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateInstances()
	if initZonesInstances then
		initZonesInstances()
	end
	return instanceIter, nil, nil
end

local function bgIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and types[k] ~= "Battleground" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateBattlegrounds()
	if initZonesInstances then
		initZonesInstances()
	end
	return bgIter, nil, nil
end

local function pvpIter(_, position)
    local k = next(zonesInstances, position)
    while k ~= nil and types[k] ~= "PvP Zone" do
        k = next(zonesInstances, k)
    end
    return k
end
function Tourist:IteratePvPZones()
	if initZonesInstances then
		initZonesInstances()
	end
    return pvpIter, nil, nil
end

local function allianceIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and factions[k] ~= "Alliance" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateAlliance()
	if initZonesInstances then
		initZonesInstances()
	end
	return allianceIter, nil, nil
end

local function hordeIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and factions[k] ~= "Horde" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateHorde()
	if initZonesInstances then
		initZonesInstances()
	end
	return hordeIter, nil, nil
end

if isHorde then
	Tourist.IterateFriendly = Tourist.IterateHorde
	Tourist.IterateHostile = Tourist.IterateAlliance
else
	Tourist.IterateFriendly = Tourist.IterateAlliance
	Tourist.IterateHostile = Tourist.IterateHorde
end

local function contestedIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and factions[k] do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateContested()
	if initZonesInstances then
		initZonesInstances()
	end
	return contestedIter, nil, nil
end

local function kalimdorIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Kalimdor do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateKalimdor()
	if initZonesInstances then
		initZonesInstances()
	end
	return kalimdorIter, nil, nil
end

local function easternKingdomsIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Eastern_Kingdoms do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateEasternKingdoms()
	if initZonesInstances then
		initZonesInstances()
	end
	return easternKingdomsIter, nil, nil
end

local function outlandIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Outland do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateOutland()
	if initZonesInstances then
		initZonesInstances()
	end
	return outlandIter, nil, nil
end

function Tourist:IterateRecommendedZones()
	return retNormal, recZones, nil
end

function Tourist:IterateRecommendedInstances()
	return retNormal, recInstances, nil
end

function Tourist:HasRecommendedInstances()
	return next(recInstances) ~= nil
end

function Tourist:IsInstance(zone)
	local t = types[zone]
	return t == "Instance" or t == "Battleground"
end

function Tourist:IsZone(zone)
	local t = types[zone]
	return t ~= "Instance" and t ~= "Battleground" and t ~= "Transport"
end

function Tourist:GetComplex(zone)
	return complexes[zone]
end

function Tourist:IsZoneOrInstance(zone)
	local t = types[zone]
	return t and t ~= "Transport"
end

function Tourist:IsBattleground(zone)
	local t = types[zone]
	return t == "Battleground"
end

function Tourist:IsArena(zone)
	local t = types[zone]
	return t == "Arena"
end

function Tourist:IsPvPZone(zone)
    local t = types[zone]
    return t == "PvP Zone"
end

function Tourist:IsCity(zone)
	local t = types[zone]
	return t == "City"
end

function Tourist:IsAlliance(zone)
	return factions[zone] == "Alliance"
end

function Tourist:IsHorde(zone)
	return factions[zone] == "Horde"
end

if isHorde then
	Tourist.IsFriendly = Tourist.IsHorde
	Tourist.IsHostile = Tourist.IsAlliance
else
	Tourist.IsFriendly = Tourist.IsAlliance
	Tourist.IsHostile = Tourist.IsHorde
end

function Tourist:IsContested(zone)
	return not factions[zone]
end

function Tourist:GetContinent(zone)
	return continents[zone] or UNKNOWN
end

function Tourist:IsInKalimdor(zone)
	return continents[zone] == Kalimdor
end

function Tourist:IsInEasternKingdoms(zone)
	return continents[zone] == Eastern_Kingdoms
end

function Tourist:IsInOutland(zone)
	return continents[zone] == Outland
end

function Tourist:GetInstanceGroupSize(instance)
	return groupSizes[instance] or 0
end

function Tourist:GetTexture(zone)
	return textures[zone]
end

function Tourist:GetZoneFromTexture(texture)
	if not texture then
		return BZ["Azeroth"]
	end
	return textures_rev[texture]
end

function Tourist:GetEnglishZoneFromTexture(texture)
	if not texture then
		return "Azeroth"
	end
	local zone = textures_rev[texture]
	if zone then
		return BZR[zone]
	end
	return nil
end

local inf = 1/0
local stack = setmetatable({}, {__mode='k'})
local function iterator(S)
	local position = S['#'] - 1
	S['#'] = position
	local x = S[position]
	if not x then
		for k in pairs(S) do
			S[k] = nil
		end
		stack[S] = true
		return nil
	end
	return x
end

setmetatable(cost, {
	__index = function(self, vertex)
		local price = 1
		
		if lows[vertex] > playerLevel then
			price = price * (1 + math.ceil((lows[vertex] - playerLevel) / 6))
		end
		
		if factions[vertex] == (isHorde and "Horde" or "Alliance") then
			price = price / 2
		elseif factions[vertex] == (isHorde and "Alliance" or "Horde") then
			if types[vertex] == "City" then
				price = price * 10
			else
				price = price * 3
			end
		end
		
		if types[x] == "Transport" then
			price = price * 2
		end
		
		self[vertex] = price
		return price
	end
})

function Tourist:IteratePath(alpha, bravo)
	if paths[alpha] == nil or paths[bravo] == nil then
		return retNil
	end
	
	local d = next(stack) or {}
	stack[d] = nil
	local Q = next(stack) or {}
	stack[Q] = nil
	local S = next(stack) or {}
	stack[S] = nil
	local pi = next(stack) or {}
	stack[pi] = nil
	
	for vertex, v in pairs(paths) do
		d[vertex] = inf
		Q[vertex] = v
	end
	d[alpha] = 0
	
	while next(Q) do
		local u
		local min = inf
		for z in pairs(Q) do
			local value = d[z]
			if value < min then
				min = value
				u = z
			end
		end
		if min == inf then
			return retNil
		end
		Q[u] = nil
		if u == bravo then
			break
		end
		
		local adj = paths[u]
		if type(adj) == "table" then
			local d_u = d[u]
			for v in pairs(adj) do
				local c = d_u + cost[v]
				if d[v] > c then
					d[v] = c
					pi[v] = u
				end
			end
		elseif adj ~= false then
			local c = d[u] + cost[adj]
			if d[adj] > c then
				d[adj] = c
				pi[adj] = u
			end
		end
	end
	
	local i = 1
	local last = bravo
	while last do
		S[i] = last
		i = i + 1
		last = pi[last]
	end
	
	for k in pairs(pi) do
		pi[k] = nil
	end
	for k in pairs(Q) do
		Q[k] = nil
	end
	for k in pairs(d) do
		d[k] = nil
	end
	stack[pi] = true
	stack[Q] = true
	stack[d] = true
	
	S['#'] = i
	
	return iterator, S
end

local function retWithOffset(t, key)
	while true do
		key = next(t, key)
		if not key then
			return nil
		end
		if yardYOffsets[key] then
			return key
		end
	end
end

function Tourist:IterateBorderZones(zone, zonesOnly)
	local path = paths[zone]
	if not path then
		return retNil
	elseif type(path) == "table" then
		return zonesOnly and retWithOffset or retNormal, path
	else
		if zonesOnly and not yardYOffsets[path] then
			return retNil
		end
		return retOne, path
	end
end

do
	Tourist.frame = oldLib and oldLib.frame or CreateFrame("Frame", MAJOR_VERSION .. "Frame", UIParent)
	Tourist.frame:UnregisterAllEvents()
	Tourist.frame:RegisterEvent("PLAYER_LEVEL_UP")
	Tourist.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	Tourist.frame:SetScript("OnEvent", function()
		PLAYER_LEVEL_UP(Tourist)
	end)
	
	local BOOTYBAY_RATCHET_BOAT = string.format(X_Y_BOAT, BZ["Booty Bay"], BZ["Ratchet"])
	local MENETHIL_THERAMORE_BOAT = string.format(X_Y_BOAT, BZ["Menethil Harbor"], BZ["Theramore Isle"])
	local MENETHIL_AUBERDINE_BOAT = string.format(X_Y_BOAT, BZ["Menethil Harbor"], BZ["Auberdine"])
	local AUBERDINE_DARNASSUS_BOAT = string.format(X_Y_BOAT, BZ["Auberdine"], BZ["Darnassus"])
	local AUBERDINE_AZUREMYST_BOAT = string.format(X_Y_BOAT, BZ["Auberdine"], BZ["Azuremyst Isle"])
	local ORGRIMMAR_UNDERCITY_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Orgrimmar"], BZ["Undercity"])
	local ORGRIMMAR_GROMGOL_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Orgrimmar"], BZ["Grom'gol Base Camp"])
	local UNDERCITY_GROMGOL_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Undercity"], BZ["Grom'gol Base Camp"])
	local SHATTRATH_IRONFORGE_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Ironforge"])
	local SHATTRATH_STORMWIND_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Stormwind City"])
	local SHATTRATH_DARNASSUS_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Darnassus"])
	local SHATTRATH_ORGRIMMAR_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Orgrimmar"])
	local SHATTRATH_THUNDERBLUFF_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Thunder Bluff"])
	local SHATTRATH_UNDERCITY_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Undercity"])
	local SHATTRATH_EXODAR_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["The Exodar"])
	local SHATTRATH_SILVERMOON_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Silvermoon City"])
	
	local zones = {}
	
	zones[BZ["Eastern Kingdoms"]] = {
		type = "Continent",
		yards = 37649.15159852673,
		x_offset = 0,
		y_offset = 0,
		continent = Eastern_Kingdoms,
		texture = "Azeroth",
	}
	
	zones[BZ["Kalimdor"]] = {
		type = "Continent",
		yards = 36798.56388065484,
		x_offset = 0,
		y_offset = 0,
		continent = Kalimdor,
		texture = "Kalimdor",
	}
	
	zones[BZ["Outland"]] = {
		type = "Continent",
		yards = 17463.5328406368,
		x_offset = 0,
		y_offset = 0,
		continent = Outland,
		texture = "Expansion01",
	}

	zones[BZ["Azeroth"]] = {
		type = "Continent",
		yards = 44531.82907938571,
		x_offset = 0,
		y_offset = 0,
	}
	
	zones[AUBERDINE_AZUREMYST_BOAT] = {
		paths = {
			[BZ["Darkshore"]] = true,
			[BZ["Azuremyst Isle"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}
	
	zones[AUBERDINE_DARNASSUS_BOAT] = {
		paths = {
			[BZ["Darkshore"]] = true,
			[BZ["Darnassus"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[BOOTYBAY_RATCHET_BOAT] = {
		paths = {
			[BZ["Stranglethorn Vale"]] = true,
			[BZ["The Barrens"]] = true,
		},
		type = "Transport",
	}

	zones[MENETHIL_AUBERDINE_BOAT] = {
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Darkshore"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[MENETHIL_THERAMORE_BOAT] = {
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Dustwallow Marsh"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[ORGRIMMAR_GROMGOL_ZEPPELIN] = {
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Stranglethorn Vale"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[ORGRIMMAR_UNDERCITY_ZEPPELIN] = {
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Tirisfal Glades"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}
	
	zones[SHATTRATH_DARNASSUS_PORTAL] = {
		paths = BZ["Darnassus"],
		type = "Transport",
	}
	
	zones[SHATTRATH_EXODAR_PORTAL] = {
		paths = BZ["The Exodar"],
		type = "Transport",
	}
	
	zones[SHATTRATH_IRONFORGE_PORTAL] = {
		paths = BZ["Ironforge"],
		type = "Transport",
	}
	
	zones[SHATTRATH_ORGRIMMAR_PORTAL] = {
		paths = BZ["Orgrimmar"],
		type = "Transport",
	}
	
	zones[SHATTRATH_SILVERMOON_PORTAL] = {
		paths = BZ["Silvermoon City"],
		type = "Transport",
	}
	
	zones[SHATTRATH_STORMWIND_PORTAL] = {
		paths = BZ["Stormwind City"],
		type = "Transport",
	}
	
	zones[SHATTRATH_THUNDERBLUFF_PORTAL] = {
		paths = BZ["Thunder Bluff"],
		type = "Transport",
	}
	
	zones[SHATTRATH_UNDERCITY_PORTAL] = {
		paths = BZ["Undercity"],
		type = "Transport",
	}
	
	zones[BZ["The Dark Portal"]] = {
		paths = {
			[BZ["Blasted Lands"]] = true,
			[BZ["Hellfire Peninsula"]] = true,
		},
		type = "Transport",
	}

	zones[UNDERCITY_GROMGOL_ZEPPELIN] = {
		paths = {
			[BZ["Stranglethorn Vale"]] = true,
			[BZ["Tirisfal Glades"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[BZ["Alterac Valley"]] = {
		continent = Eastern_Kingdoms,
		paths = BZ["Alterac Mountains"],
		groupSize = 40,
		type = "Battleground",
		texture = "AlteracValley",
	}

	zones[BZ["Arathi Basin"]] = {
		continent = Eastern_Kingdoms,
		paths = BZ["Arathi Highlands"],
		groupSize = 15,
		type = "Battleground",
		texture = "ArathiBasin",
	}

	zones[BZ["Warsong Gulch"]] = {
		continent = Kalimdor,
		paths = isHorde and BZ["The Barrens"] or BZ["Ashenvale"],
		groupSize = 10,
		type = "Battleground",
		texture = "WarsongGulch",
	}

	zones[BZ["Deeprun Tram"]] = {
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Stormwind City"]] = true,
			[BZ["Ironforge"]] = true,
		},
		faction = "Alliance",
	}

	zones[BZ["Ironforge"]] = {
		continent = Eastern_Kingdoms,
		instances = BZ["Gnomeregan"],
		paths = {
			[BZ["Dun Morogh"]] = true,
			[BZ["Deeprun Tram"]] = true,
		},
		faction = "Alliance",
		type = "City",
		yards = 790.5745810546713,
		x_offset = 17764.34206355846,
		y_offset = 13762.32403658607,
		fishing_min = 1,
		texture = "Ironforge",
	}
	
	zones[BZ["Silvermoon City"]] = {
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Eversong Woods"]] = true,
			[BZ["Undercity"]] = true,
		},
		faction = "Horde",
		type = "City",
		yards = 1211.384457945605,
		x_offset = 21051.29911245071,
		y_offset = 1440.439646345552,
		fishing_min = 1,
		texture = "SilvermoonCity",
	}
	
	zones[BZ["Stormwind City"]] = {
		continent = Eastern_Kingdoms,
		instances = BZ["The Stockade"],
		paths = {
			[BZ["Deeprun Tram"]] = true,
			[BZ["The Stockade"]] = true,
			[BZ["Elwynn Forest"]] = true,
			[BZ["Champions' Hall"]] = true,
		},
		faction = "Alliance",
		type = "City",
		yards = 1344.138055148283,
		x_offset = 15669.93346231942,
		y_offset = 17471.62163820253,
		fishing_min = 1,
		texture = "Stormwind",
	}
	
	zones[BZ["Champions' Hall"]] = {
		continent = Eastern_Kingdoms,
		paths = BZ["Stormwind City"],
		faction = "Alliance",
	}
	
	zones[BZ["Undercity"]] = {
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		paths = {
			[BZ["Silvermoon City"]] = true,
			[BZ["Tirisfal Glades"]] = true,
		},
		faction = "Horde",
		type = "City",
		yards = 959.3140238076666,
		x_offset = 16177.65630384973,
		y_offset = 7315.685533181013,
		texture = "Undercity",
	}
	
	zones[BZ["Dun Morogh"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		instances = BZ["Gnomeregan"],
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Gnomeregan"]] = true,
			[BZ["Ironforge"]] = true,
			[BZ["Loch Modan"]] = true,
		},
		faction = "Alliance",
		yards = 4924.664537147015,
		x_offset = 15248.84370721237,
		y_offset = 13070.22369811241,
		fishing_min = 1,
		texture = "DunMorogh",
	}
	
	zones[BZ["Elwynn Forest"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		instances = BZ["The Stockade"],
		paths = {
			[BZ["Westfall"]] = true,
			[BZ["Redridge Mountains"]] = true,
			[BZ["Stormwind City"]] = true,
			[BZ["Duskwood"]] = true,
		},
		faction = "Alliance",
		yards = 3470.62593362794,
		x_offset = 15515.46777926721,
		y_offset = 17132.38313881497,
		fishing_min = 1,
		texture = "Elwynn",
	}
	
	zones[BZ["Eversong Woods"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Silvermoon City"]] = true,
			[BZ["Ghostlands"]] = true,
		},
		faction = "Horde",
		yards = 4924.70470173181,
		x_offset = 19138.16325760612,
		y_offset = 552.5351270080572,
		fishing_min = 20,
		texture = "EversongWoods",
	}
	
	zones[BZ["Tirisfal Glades"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		paths = {
			[BZ["Western Plaguelands"]] = true,
			[BZ["Undercity"]] = true,
			[BZ["Scarlet Monastery"]] = true,
			[UNDERCITY_GROMGOL_ZEPPELIN] = true,
			[ORGRIMMAR_UNDERCITY_ZEPPELIN] = true,
			[BZ["Silverpine Forest"]] = true,
		},
		faction = "Horde",
		yards = 4518.469744413802,
		x_offset = 14017.64852522109,
		y_offset = 5356.296558943325,
		fishing_min = 1,
		texture = "Tirisfal",
	}
	
	zones[BZ["Amani Pass"]] = {
		continent = Eastern_Kingdoms,
	}
	
	zones[BZ["Ghostlands"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		instances = BZ["Zul'Aman"],
		paths = {
			[BZ["Eastern Plaguelands"]] = true,
			[BZ["Zul'Aman"]] = true,
			[BZ["Eversong Woods"]] = true,
		},
		faction = "Horde",
		yards = 3299.755735439147,
		x_offset = 19933.969945598,
		y_offset = 3327.317139912411,
		fishing_min = 20,
		texture = "Ghostlands",
	}
	
	zones[BZ["Loch Modan"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Badlands"]] = true,
			[BZ["Dun Morogh"]] = true,
			[BZ["Searing Gorge"]] = not isHorde and true or nil,
		},
		faction = "Alliance",
		yards = 2758.158752877019,
		x_offset = 19044.42466174755,
		y_offset = 13680.58746225864,
		fishing_min = 20,
		texture = "LochModan",
	}

	zones[BZ["Silverpine Forest"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		instances = BZ["Shadowfang Keep"],
		paths = {
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Hillsbrad Foothills"]] = true,
			[BZ["Shadowfang Keep"]] = true,
		},
		faction = "Horde",
		yards = 4199.739879721531,
		x_offset = 13601.00798540562,
		y_offset = 7526.945768538925,
		fishing_min = 20,
		texture = "Silverpine",
	}

	zones[BZ["Westfall"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		instances = BZ["The Deadmines"],
		paths = {
			[BZ["Duskwood"]] = true,
			[BZ["Elwynn Forest"]] = true,
			[BZ["The Deadmines"]] = true,
		},
		faction = "Alliance",
		yards = 3499.786489780177,
		x_offset = 14034.31142029944,
		y_offset = 18592.67765947875,
		fishing_min = 55,
		texture = "Westfall",
	}

	zones[BZ["Redridge Mountains"]] = {
		low = 15,
		high = 25,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Burning Steppes"]] = true,
			[BZ["Elwynn Forest"]] = true,
			[BZ["Duskwood"]] = true,
		},
		yards = 2170.704876735185,
		x_offset = 18621.52904187992,
		y_offset = 17767.73128664901,
		fishing_min = 55,
		texture = "Redridge",
	}

	zones[BZ["Duskwood"]] = {
		low = 18,
		high = 30,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Redridge Mountains"]] = true,
			[BZ["Stranglethorn Vale"]] = true,
			[BZ["Westfall"]] = true,
			[BZ["Deadwind Pass"]] = true,
			[BZ["Elwynn Forest"]] = true,
		},
		yards = 2699.837284973949,
		x_offset = 16217.51007473156,
		y_offset = 18909.31475362112,
		fishing_min = 55,
		texture = "Duskwood",
	}

	zones[BZ["Hillsbrad Foothills"]] = {
		low = 20,
		high = 30,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Alterac Mountains"]] = true,
			[BZ["The Hinterlands"]] = true,
			[BZ["Arathi Highlands"]] = true,
			[BZ["Silverpine Forest"]] = true,
		},
		yards = 3199.802496078764,
		x_offset = 15984.19170342619,
		y_offset = 8793.505832296016,
		fishing_min = 55,
		texture = "Hilsbrad",
	}

	zones[BZ["Wetlands"]] = {
		low = 20,
		high = 30,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Arathi Highlands"]] = true,
			[MENETHIL_AUBERDINE_BOAT] = true,
			[MENETHIL_THERAMORE_BOAT] = true,
			[BZ["Dun Morogh"]] = true,
			[BZ["Loch Modan"]] = true,
		},
		yards = 4135.166184805389,
		x_offset = 17440.35277057554,
		y_offset = 11341.20698670613,
		fishing_min = 55,
		texture = "Wetlands",
	}

	zones[BZ["Alterac Mountains"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		instances = BZ["Alterac Valley"],
		paths = {
			[BZ["Western Plaguelands"]] = true,
			[BZ["Alterac Valley"]] = true,
			[BZ["Hillsbrad Foothills"]] = true,
		},
		yards = 2799.820894040741,
		x_offset = 16267.51182664554,
		y_offset = 7693.598754637632,
		fishing_min = 130,
		texture = "Alterac",
	}

	zones[BZ["Arathi Highlands"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		instances = BZ["Arathi Basin"],
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Hillsbrad Foothills"]] = true,
			[BZ["Arathi Basin"]] = true,
		},
		yards = 3599.78645678886,
		x_offset = 17917.40598190062,
		y_offset = 9326.804744097401,
		fishing_min = 130,
		texture = "Arathi",
	}

	zones[BZ["Stranglethorn Vale"]] = {
		low = 30,
		high = 45,
		continent = Eastern_Kingdoms,
		instances = BZ["Zul'Gurub"],
		paths = {
			[BZ["Zul'Gurub"]] = true,
			[BOOTYBAY_RATCHET_BOAT] = true,
			[BZ["Duskwood"]] = true,
			[ORGRIMMAR_GROMGOL_ZEPPELIN] = true,
			[UNDERCITY_GROMGOL_ZEPPELIN] = true,
		},
		yards = 6380.866711475876,
		x_offset = 14830.09122763351,
		y_offset = 20361.27611706414,
		fishing_min = 130,
		texture = "Stranglethorn",
	}

	zones[BZ["Badlands"]] = {
		low = 35,
		high = 45,
		continent = Eastern_Kingdoms,
		instances = BZ["Uldaman"],
		paths = {
			[BZ["Uldaman"]] = true,
			[BZ["Searing Gorge"]] = true,
			[BZ["Loch Modan"]] = true,
		},
		yards = 2487.343589680943,
		x_offset = 19129.83542887301,
		y_offset = 15082.55526717644,
		texture = "Badlands",
	}

	zones[BZ["Swamp of Sorrows"]] = {
		low = 35,
		high = 45,
		continent = Eastern_Kingdoms,
		instances = BZ["The Temple of Atal'Hakkar"],
		paths = {
			[BZ["Blasted Lands"]] = true,
			[BZ["Deadwind Pass"]] = true,
			[BZ["The Temple of Atal'Hakkar"]] = true,
		},
		yards = 2293.606089974149,
		x_offset = 19273.57577346738,
		y_offset = 18813.48829580375,
		fishing_min = 130,
		texture = "SwampOfSorrows",
	}

	zones[BZ["The Hinterlands"]] = {
		low = 40,
		high = 50,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Hillsbrad Foothills"]] = true,
			[BZ["Western Plaguelands"]] = true,
		},
		yards = 3849.77134323942,
		x_offset = 18625.69536724846,
		y_offset = 7726.929725104341,
		fishing_min = 205,
		texture = "Hinterlands",
	}

	zones[BZ["Searing Gorge"]] = {
		low = 43,
		high = 50,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Blackrock Depths"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
		paths = {
			[BZ["Blackrock Mountain"]] = true,
			[BZ["Badlands"]] = true,
			[BZ["Loch Modan"]] = not isHorde and true or nil,
		},
		yards = 2231.119799153945,
		x_offset = 17373.68649889545,
		y_offset = 15292.9566475719,
		texture = "SearingGorge",
	}

	zones[BZ["Blackrock Mountain"]] = {
		low = 42,
		high = 54,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Blackrock Depths"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
		paths = {
			[BZ["Burning Steppes"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Depths"]] = true,
			[BZ["Searing Gorge"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
	}

	zones[BZ["Deadwind Pass"]] = {
		low = 55,
		high = 60,
		continent = Eastern_Kingdoms,
		instances = BZ["Karazhan"],
		paths = {
			[BZ["Duskwood"]] = true,
			[BZ["Swamp of Sorrows"]] = true,
			[BZ["Karazhan"]] = true,
		},
		yards = 2499.848163715574,
		x_offset = 17884.07519016362,
		y_offset = 19059.30117481421,
		fishing_min = 330,
		texture = "DeadwindPass",
	}

	zones[BZ["Blasted Lands"]] = {
		low = 45,
		high = 55,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["The Dark Portal"]] = true,
			[BZ["Swamp of Sorrows"]] = true,
		},
		yards = 3349.808966078055,
		x_offset = 18292.37876312771,
		y_offset = 19759.24272564734,
		texture = "BlastedLands",
	}

	zones[BZ["Burning Steppes"]] = {
		low = 50,
		high = 58,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Blackrock Depths"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
		paths = {
			[BZ["Blackrock Mountain"]] = true,
			[BZ["Redridge Mountains"]] = true,
		},
		yards = 2928.988452241535,
		x_offset = 17317.44291506163,
		y_offset = 16224.12640057407,
		fishing_min = 330,
		texture = "BurningSteppes",
	}

	zones[BZ["Western Plaguelands"]] = {
		low = 51,
		high = 58,
		continent = Eastern_Kingdoms,
		instances = BZ["Scholomance"],
		paths = {
			[BZ["The Hinterlands"]] = true,
			[BZ["Eastern Plaguelands"]] = true,
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Scholomance"]] = true,
			[BZ["Alterac Mountains"]] = true,
		},
		yards = 4299.7374000546,
		x_offset = 16634.14908983872,
		y_offset = 5827.092974820261,
		fishing_min = 205,
		texture = "WesternPlaguelands",
	}

	zones[BZ["Eastern Plaguelands"]] = {
		low = 53,
		high = 60,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Stratholme"]] = true,
			[BZ["Naxxramas"]] = true,
		},
		paths = {
			[BZ["Western Plaguelands"]] = true,
			[BZ["Naxxramas"]] = true,
			[BZ["Stratholme"]] = true,
			[BZ["Ghostlands"]] = true,
		},
		yards = 3870.596078314358,
		x_offset = 19236.07699848783,
		y_offset = 5393.799386328108,
        type = "PvP Zone",
		fishing_min = 330,
		texture = "EasternPlaguelands",
	}

	zones[BZ["The Deadmines"]] = {
		low = 15,
		high = 20,
		continent = Eastern_Kingdoms,
		paths = BZ["Westfall"],
		groupSize = 5,
		faction = "Alliance",
		type = "Instance",
		fishing_min = 20,
	}

	zones[BZ["Shadowfang Keep"]] = {
		low = 18,
		high = 25,
		continent = Eastern_Kingdoms,
		paths = BZ["Silverpine Forest"],
		groupSize = 5,
		faction = "Horde",
		type = "Instance",
	}

	zones[BZ["The Stockade"]] = {
		low = 23,
		high = 26,
		continent = Eastern_Kingdoms,
		paths = BZ["Stormwind City"],
		groupSize = 5,
		faction = "Alliance",
		type = "Instance",
	}

	zones[BZ["Gnomeregan"]] = {
		low = 24,
		high = 33,
		continent = Eastern_Kingdoms,
		paths = BZ["Dun Morogh"],
		groupSize = 5,
		faction = "Alliance",
		type = "Instance",
	}

	zones[BZ["Scarlet Monastery"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		paths = {
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		faction = "Horde",
		type = "Instance",
	}

	zones[BZ["Graveyard"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
	}

	zones[BZ["Library"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
	}

	zones[BZ["Armory"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
	}

	zones[BZ["Cathedral"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
	}

	zones[BZ["Uldaman"]] = {
		low = 35,
		high = 45,
		continent = Eastern_Kingdoms,
		paths = BZ["Badlands"],
		groupSize = 5,
		type = "Instance",
	}

	zones[BZ["The Temple of Atal'Hakkar"]] = {
		low = 44,
		high = 50,
		continent = Eastern_Kingdoms,
		paths = BZ["Swamp of Sorrows"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 205,
	}

	zones[BZ["Blackrock Depths"]] = {
		low = 48,
		high = 56,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Mountain"]] = true,
		},
		groupSize = 5,
		type = "Instance",
	}

	zones[BZ["Blackrock Spire"]] = {
		low = 53,
		high = 60,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Blackrock Mountain"]] = true,
			[BZ["Blackwing Lair"]] = true,
		},
		groupSize = 10,
		type = "Instance",
	}

	zones[BZ["Scholomance"]] = {
		low = 58,
		high = 60,
		continent = Eastern_Kingdoms,
		paths = BZ["Western Plaguelands"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 330,
	}

	zones[BZ["Stratholme"]] = {
		low = 55,
		high = 60,
		continent = Eastern_Kingdoms,
		paths = BZ["Eastern Plaguelands"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 330,
	}

	zones[BZ["Blackwing Lair"]] = {
		low = 60,
		high = 62,
		continent = Eastern_Kingdoms,
		paths = BZ["Blackrock Mountain"],
		groupSize = 40,
		type = "Instance",
	}

	zones[BZ["Molten Core"]] = {
		low = 60,
		high = 62,
		continent = Eastern_Kingdoms,
		paths = BZ["Blackrock Mountain"],
		groupSize = 40,
		type = "Instance",
	}

	zones[BZ["Zul'Gurub"]] = {
		low = 60,
		high = 62,
		continent = Eastern_Kingdoms,
		paths = BZ["Stranglethorn Vale"],
		groupSize = 20,
		type = "Instance",
		fishing_min = 330,
	}

	zones[BZ["Naxxramas"]] = {
		low = 60,
		high = 70,
		continent = Eastern_Kingdoms,
		groupSize = 40,
		type = "Instance",
	}
	
	zones[BZ["Karazhan"]] = {
		low = 70,
		high = 70,
		continent = Eastern_Kingdoms,
		paths = BZ["Deadwind Pass"],
		groupSize = 10,
		type = "Instance",
	}
	
	zones[BZ["Zul'Aman"]] = {
		low = 70,
		high = 70,
		continent = Eastern_Kingdoms,
		paths = BZ["Ghostlands"],
		groupSize = 10,
		type = "Instance",
	}

	zones[BZ["Darnassus"]] = {
		continent = Kalimdor,
		paths = {
			[BZ["Teldrassil"]] = true,
			[AUBERDINE_DARNASSUS_BOAT] = true,
		},
		faction = "Alliance",
		type = "City",
		yards = 1058.300884213672,
		x_offset = 14127.75729935019,
		y_offset = 2561.497770365213,
		fishing_min = 1,
		texture = "Darnassis",
	}

	zones[BZ["Hyjal"]] = {
		continent = Kalimdor,
	}

	zones[BZ["Moonglade"]] = {
		continent = Kalimdor,
		paths = {
			[BZ["Felwood"]] = true,
			[BZ["Winterspring"]] = true,
		},
		yards = 2308.253559286662,
		x_offset = 18447.22668103606,
		y_offset = 4308.084192710569,
		fishing_min = 205,
		texture = "Moonglade",
	}

	zones[BZ["Orgrimmar"]] = {
		continent = Kalimdor,
		instances = BZ["Ragefire Chasm"],
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Ragefire Chasm"]] = true,
			[BZ["Hall of Legends"]] = true,
		},
		faction = "Horde",
		type = "City",
		yards = 1402.563051365538,
		x_offset = 20746.49533101771,
		y_offset = 10525.68532631853,
		fishing_min = 1,
		texture = "Ogrimmar",
	}
	
	zones[BZ["Hall of Legends"]] = {
		continent = Kalimdor,
		paths = BZ["Orgrimmar"],
		faction = "Horde",
	}
	
	zones[BZ["The Exodar"]] = {
		continent = Kalimdor,
		paths = BZ["Azuremyst Isle"],
		faction = "Alliance",
		type = "City",
		yards = 1056.732317707213,
		x_offset = 10532.61275516805,
		y_offset = 6276.045028807911,
		fishing_min = 1,
		texture = "TheExodar",
	}

	zones[BZ["Thunder Bluff"]] = {
		continent = Kalimdor,
		paths = BZ["Mulgore"],
		faction = "Horde",
		type = "City",
		yards = 1043.762849319158,
		x_offset = 16549.32009877855,
		y_offset = 13649.45129927044,
		texture = "ThunderBluff",
	}
	
	zones[BZ["Azuremyst Isle"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		paths = {
			[BZ["The Exodar"]] = true,
			[BZ["Bloodmyst Isle"]] = true,
			[AUBERDINE_AZUREMYST_BOAT] = true,
		},
		faction = "Alliance",
		yards = 4070.691916244019,
		x_offset = 9966.264785353642,
		y_offset = 5460.139378090237,
		fishing_min = 20,
		texture = "AzuremystIsle",
	}

	zones[BZ["Durotar"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		instances = BZ["Ragefire Chasm"],
		paths = {
			[ORGRIMMAR_UNDERCITY_ZEPPELIN] = true,
			[ORGRIMMAR_GROMGOL_ZEPPELIN] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Orgrimmar"]] = true,
		},
		faction = "Horde",
		yards = 5287.285801274457,
		x_offset = 19028.47465485265,
		y_offset = 10991.20642822035,
		fishing_min = 1,
		texture = "Durotar",
	}

	zones[BZ["Mulgore"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		paths = {
			[BZ["Thunder Bluff"]] = true,
			[BZ["The Barrens"]] = true,
		},
		faction = "Horde",
		yards = 5137.32138887616,
		x_offset = 15018.17633401988,
		y_offset = 13072.38917227894,
		fishing_min = 1,
		texture = "Mulgore",
	}

	zones[BZ["Teldrassil"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		paths = BZ["Darnassus"],
		faction = "Alliance",
		yards = 5091.467863261982,
		x_offset = 13251.58449896318,
		y_offset = 968.6223632831094,
		fishing_min = 1,
		texture = "Teldrassil",
	}
	
	zones[BZ["Bloodmyst Isle"]] = {
		low = 10,
		high = 20,
		continent = Kalimdor,
		paths = {
			[BZ["Azuremyst Isle"]] = true,
		},
		faction = "Alliance",
		yards = 3262.385067990556,
		x_offset = 9541.280691875327,
		y_offset = 3424.790637352245,
		fishing_min = 1,
		texture = "BloodmystIsle",
	}

	zones[BZ["Darkshore"]] = {
		low = 10,
		high = 20,
		continent = Kalimdor,
		paths = {
			[MENETHIL_AUBERDINE_BOAT] = true,
			[AUBERDINE_DARNASSUS_BOAT] = true,
			[AUBERDINE_AZUREMYST_BOAT] = true,
			[BZ["Ashenvale"]] = true,
		},
		faction = "Alliance",
		yards = 6549.780280774227,
		x_offset = 14124.4534386827,
		y_offset = 4466.419105960455,
		fishing_min = 20,
		texture = "Darkshore",
	}

	zones[BZ["The Barrens"]] = {
		low = 10,
		high = 25,
		continent = Kalimdor,
		instances = {
			[BZ["Razorfen Kraul"]] = true,
			[BZ["Wailing Caverns"]] = true,
			[BZ["Razorfen Downs"]] = true,
			[BZ["Warsong Gulch"]] = isHorde and true or nil,
		},
		paths = {
			[BZ["Thousand Needles"]] = true,
			[BZ["Razorfen Kraul"]] = true,
			[BZ["Ashenvale"]] = true,
			[BZ["Durotar"]] = true,
			[BZ["Wailing Caverns"]] = true,
			[BOOTYBAY_RATCHET_BOAT] = true,
			[BZ["Dustwallow Marsh"]] = true,
			[BZ["Razorfen Downs"]] = true,
			[BZ["Stonetalon Mountains"]] = true,
			[BZ["Mulgore"]] = true,
			[BZ["Warsong Gulch"]] = isHorde and true or nil,
		},
		faction = "Horde",
		yards = 10132.98626357964,
		x_offset = 14443.19633043607,
		y_offset = 11187.03406016663,
		fishing_min = 20,
		texture = "Barrens",
	}

	zones[BZ["Stonetalon Mountains"]] = {
		low = 15,
		high = 27,
		continent = Kalimdor,
		paths = {
			[BZ["Desolace"]] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Ashenvale"]] = true,
		},
		yards = 4883.173287670144,
		x_offset = 13820.29750397374,
		y_offset = 9882.909063258192,
		fishing_min = 55,
		texture = "StonetalonMountains",
	}

	zones[BZ["Ashenvale"]] = {
		low = 18,
		high = 30,
		continent = Kalimdor,
		instances = {
			[BZ["Blackfathom Deeps"]] = true,
			[BZ["Warsong Gulch"]] = not isHorde and true or nil,
		},
		paths = {
			[BZ["Azshara"]] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Blackfathom Deeps"]] = true,
			[BZ["Warsong Gulch"]] = not isHorde and true or nil,
			[BZ["Felwood"]] = true,
			[BZ["Darkshore"]] = true,
			[BZ["Stonetalon Mountains"]] = true,
		},
		yards = 5766.471113365881,
		x_offset = 15366.08027406009,
		y_offset = 8126.716152815561,
		fishing_min = 55,
		texture = "Ashenvale",
	}

	zones[BZ["Thousand Needles"]] = {
		low = 25,
		high = 35,
		continent = Kalimdor,
		paths = {
			[BZ["Feralas"]] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Tanaris"]] = true,
		},
		yards = 4399.86408093722,
		x_offset = 17499.32929341832,
		y_offset = 16766.0151133423,
		fishing_min = 130,
		texture = "ThousandNeedles",
	}

	zones[BZ["Desolace"]] = {
		low = 30,
		high = 40,
		continent = Kalimdor,
		instances = BZ["Maraudon"],
		paths = {
			[BZ["Feralas"]] = true,
			[BZ["Stonetalon Mountains"]] = true,
			[BZ["Maraudon"]] = true,
		},
		yards = 4495.726850591814,
		x_offset = 12832.80723200791,
		y_offset = 12347.420176847,
		fishing_min = 130,
		texture = "Desolace",
	}

	zones[BZ["Dustwallow Marsh"]] = {
		low = 35,
		high = 45,
		continent = Kalimdor,
		instances = BZ["Onyxia's Lair"],
		paths = {
			[BZ["Onyxia's Lair"]] = true,
			[BZ["The Barrens"]] = true,
			[MENETHIL_THERAMORE_BOAT] = true,
		},
		yards = 5249.824712249077,
		x_offset = 18040.98829886713,
		y_offset = 14832.74650226312,
		fishing_min = 130,
		texture = "Dustwallow",
	}

	zones[BZ["Feralas"]] = {
		low = 40,
		high = 50,
		continent = Kalimdor,
		instances = BZ["Dire Maul"],
		paths = {
			[BZ["Thousand Needles"]] = true,
			[BZ["Desolace"]] = true,
			[BZ["Dire Maul"]] = true,
		},
		yards = 6949.760203962193,
		x_offset = 11624.54217828119,
		y_offset = 15166.06954533647,
		fishing_min = 205,
		texture = "Feralas",
	}
	
	zones[BZ["Tanaris"]] = {
		low = 40,
		high = 50,
		continent = Kalimdor,
		instances = {
			[BZ["Zul'Farrak"]] = true,
			[BZ["Old Hillsbrad Foothills"]] = true,
			[BZ["The Black Morass"]] = true,
			[BZ["Hyjal Summit"]] = true,
		},
		paths = {
			[BZ["Thousand Needles"]] = true,
			[BZ["Un'Goro Crater"]] = true,
			[BZ["Zul'Farrak"]] = true,
			[BZ["Caverns of Time"]] = true,
		},
		yards = 6899.765399158026,
		x_offset = 17284.7655865671,
		y_offset = 18674.28905369955,
		fishing_min = 205,
		texture = "Tanaris",
	}

	zones[BZ["Azshara"]] = {
		low = 45,
		high = 55,
		continent = Kalimdor,
		paths = BZ["Ashenvale"],
		yards = 5070.669448432522,
		x_offset = 20342.99178351035,
		y_offset = 7457.974565554941,
		fishing_min = 205,
		texture = "Aszhara",
	}

	zones[BZ["Felwood"]] = {
		low = 48,
		high = 55,
		continent = Kalimdor,
		paths = {
			[BZ["Winterspring"]] = true,
			[BZ["Moonglade"]] = true,
			[BZ["Ashenvale"]] = true,
		},
		yards = 5749.8046476606,
		x_offset = 15424.4116748014,
		y_offset = 5666.381311442202,
		fishing_min = 205,
		texture = "Felwood",
	}

	zones[BZ["Un'Goro Crater"]] = {
		low = 48,
		high = 55,
		continent = Kalimdor,
		paths = {
			[BZ["Silithus"]] = true,
			[BZ["Tanaris"]] = true,
		},
		yards = 3699.872808671186,
		x_offset = 16532.70803775362,
		y_offset = 18765.95157787033,
		fishing_min = 205,
		texture = "UngoroCrater",
	}

	zones[BZ["Silithus"]] = {
		low = 55,
		high = 60,
		continent = Kalimdor,
		instances = {
			[BZ["Ahn'Qiraj"]] = true,
			[BZ["Ruins of Ahn'Qiraj"]] = true,
		},
		paths = {
			[BZ["Ruins of Ahn'Qiraj"]] = true,
			[BZ["Un'Goro Crater"]] = true,
			[BZ["Ahn'Qiraj"]] = true,
		},
		yards = 3483.224287356748,
		x_offset = 14528.60591761034,
		y_offset = 18757.61998086822,
        type = "PvP Zone",
		fishing_min = 330,
		texture = "Silithus",
	}

	zones[BZ["Winterspring"]] = {
		low = 55,
		high = 60,
		continent = Kalimdor,
		paths = {
			[BZ["Felwood"]] = true,
			[BZ["Moonglade"]] = true,
		},
		yards = 7099.756078049357,
		x_offset = 17382.67868933954,
		y_offset = 4266.421320915686,
		fishing_min = 330,
		texture = "Winterspring",
	}

	zones[BZ["Ragefire Chasm"]] = {
		low = 13,
		high = 15,
		continent = Kalimdor,
		paths = BZ["Orgrimmar"],
		groupSize = 5,
		faction = "Horde",
		type = "Instance",
	}

	zones[BZ["Wailing Caverns"]] = {
		low = 15,
		high = 21,
		continent = Kalimdor,
		paths = BZ["The Barrens"],
		groupSize = 5,
		faction = "Horde",
		type = "Instance",
		fishing_min = 20,
	}

	zones[BZ["Blackfathom Deeps"]] = {
		low = 20,
		high = 27,
		continent = Kalimdor,
		paths = BZ["Ashenvale"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 20,
	}

	zones[BZ["Razorfen Kraul"]] = {
		low = 25,
		high = 35,
		continent = Kalimdor,
		paths = BZ["The Barrens"],
		groupSize = 5,
		type = "Instance",
	}

	zones[BZ["Razorfen Downs"]] = {
		low = 35,
		high = 40,
		continent = Kalimdor,
		paths = BZ["The Barrens"],
		groupSize = 5,
		type = "Instance",
	}

	zones[BZ["Zul'Farrak"]] = {
		low = 43,
		high = 47,
		continent = Kalimdor,
		paths = BZ["Tanaris"],
		groupSize = 5,
		type = "Instance",
	}

	zones[BZ["Maraudon"]] = {
		low = 40,
		high = 49,
		continent = Kalimdor,
		paths = BZ["Desolace"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 205,
	}

	zones[BZ["Dire Maul"]] = {
		low = 56,
		high = 60,
		continent = Kalimdor,
		paths = BZ["Feralas"],
		groupSize = 5,
		type = "Instance",
	}

	zones[BZ["Onyxia's Lair"]] = {
		low = 60,
		high = 62,
		continent = Kalimdor,
		paths = BZ["Dustwallow Marsh"],
		groupSize = 40,
		type = "Instance",
	}

	zones[BZ["Ahn'Qiraj"]] = {
		low = 60,
		high = 65,
		continent = Kalimdor,
		paths = BZ["Silithus"],
		groupSize = 40,
		type = "Instance",
	}

	zones[BZ["Ruins of Ahn'Qiraj"]] = {
		low = 60,
		high = 65,
		continent = Kalimdor,
		paths = BZ["Silithus"],
		groupSize = 20,
		type = "Instance",
	}
	
	zones[BZ["Caverns of Time"]] = {
		continent = Kalimdor,
		instances = {
			[BZ["Old Hillsbrad Foothills"]] = true,
			[BZ["The Black Morass"]] = true,
			[BZ["Hyjal Summit"]] = true,
		},
		paths = {
			[BZ["Tanaris"]] = true,
			[BZ["Old Hillsbrad Foothills"]] = true,
			[BZ["The Black Morass"]] = true,
			[BZ["Hyjal Summit"]] = true,
		},
	}
	
	zones[BZ["Old Hillsbrad Foothills"]] = {
		low = 66,
		high = 68,
		continent = Kalimdor,
		paths = BZ["Tanaris"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Caverns of Time"]
	}
	
	zones[BZ["The Black Morass"]] = {
		low = 67,
		high = 72,
		continent = Kalimdor,
		paths = BZ["Tanaris"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Caverns of Time"]
	}
	
	zones[BZ["Hyjal Summit"]] = {
		low = 70,
		high = 72,
		continent = Kalimdor,
		paths = BZ["Tanaris"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Caverns of Time"]
	}
	
	zones[BZ["Shattrath City"]] = {
		continent = Outland,
		paths = {
			[SHATTRATH_THUNDERBLUFF_PORTAL] = true,
			[SHATTRATH_STORMWIND_PORTAL] = true,
			[SHATTRATH_UNDERCITY_PORTAL] = true,
			[BZ["Terokkar Forest"]] = true,
			[SHATTRATH_SILVERMOON_PORTAL] = true,
			[SHATTRATH_EXODAR_PORTAL] = true,
			[SHATTRATH_DARNASSUS_PORTAL] = true,
			[SHATTRATH_ORGRIMMAR_PORTAL] = true,
			[SHATTRATH_IRONFORGE_PORTAL] = true,
			[BZ["Nagrand"]] = true,
		},
		type = "City",
		yards = 1306.210386847456,
		x_offset = 6860.565394341991,
		y_offset = 7295.086145447915,
		texture = "ShattrathCity",
	}
	
	zones[BZ["Hellfire Citadel"]] = {
		continent = Outland,
		instances = {
			[BZ["The Blood Furnace"]] = true,
			[BZ["Hellfire Ramparts"]] = true,
			[BZ["Magtheridon's Lair"]] = true,
			[BZ["The Shattered Halls"]] = true,
		},
		paths = {
			[BZ["Hellfire Peninsula"]] = true,
			[BZ["The Blood Furnace"]] = true,
			[BZ["Hellfire Ramparts"]] = true,
			[BZ["Magtheridon's Lair"]] = true,
			[BZ["The Shattered Halls"]] = true,
		},
	}
	
	zones[BZ["Hellfire Peninsula"]] = {
		low = 58,
		high = 63,
		continent = Outland,
		instances = {
			[BZ["The Blood Furnace"]] = true,
			[BZ["Hellfire Ramparts"]] = true,
			[BZ["Magtheridon's Lair"]] = true,
			[BZ["The Shattered Halls"]] = true,
		},
		paths = {
			[BZ["Zangarmarsh"]] = true,
			[BZ["The Dark Portal"]] = true,
			[BZ["Terokkar Forest"]] = true,
			[BZ["Hellfire Citadel"]] = true,
		},
		yards = 5164.421615455519,
		x_offset = 7456.223236253186,
		y_offset = 4339.973528794677,
        type = "PvP Zone",
		texture = "Hellfire",
	}
	
	zones[BZ["Coilfang Reservoir"]] = {
		continent = Outland,
		instances = {
			[BZ["The Underbog"]] = true,
			[BZ["Serpentshrine Cavern"]] = true,
			[BZ["The Steamvault"]] = true,
			[BZ["The Slave Pens"]] = true,
		},
		paths = {
			[BZ["Zangarmarsh"]] = true,
			[BZ["The Underbog"]] = true,
			[BZ["Serpentshrine Cavern"]] = true,
			[BZ["The Steamvault"]] = true,
			[BZ["The Slave Pens"]] = true,
		},
	}
	
	zones[BZ["Zangarmarsh"]] = {
		low = 60,
		high = 64,
		continent = Outland,
		instances = {
			[BZ["The Underbog"]] = true,
			[BZ["Serpentshrine Cavern"]] = true,
			[BZ["The Steamvault"]] = true,
			[BZ["The Slave Pens"]] = true,
		},
		paths = {
			[BZ["Coilfang Reservoir"]] = true,
			[BZ["Blade's Edge Mountains"]] = true,
			[BZ["Terokkar Forest"]] = true,
			[BZ["Nagrand"]] = true,
			[BZ["Hellfire Peninsula"]] = true,
		},
		yards = 5026.925554043871,
		x_offset = 3520.930685571132,
		y_offset = 3885.821388791224,
        type = "PvP Zone",
		fishing_min = 305,
		texture = "Zangarmarsh",
	}

	zones[BZ["Ring of Observance"]] = {
		continent = Outland,
		instances = {
			[BZ["Mana-Tombs"]] = true,
			[BZ["Sethekk Halls"]] = true,
			[BZ["Shadow Labyrinth"]] = true,
			[BZ["Auchenai Crypts"]] = true,
		},
		paths = {
			[BZ["Terokkar Forest"]] = true,
			[BZ["Mana-Tombs"]] = true,
			[BZ["Sethekk Halls"]] = true,
			[BZ["Shadow Labyrinth"]] = true,
			[BZ["Auchenai Crypts"]] = true,
		},
	}

	zones[BZ["Terokkar Forest"]] = {
		low = 62,
		high = 65,
		continent = Outland,
		instances = {
			[BZ["Mana-Tombs"]] = true,
			[BZ["Sethekk Halls"]] = true,
			[BZ["Shadow Labyrinth"]] = true,
			[BZ["Auchenai Crypts"]] = true,
		},
		paths = {
			[BZ["Ring of Observance"]] = true,
			[BZ["Shadowmoon Valley"]] = true,
			[BZ["Zangarmarsh"]] = true,
			[BZ["Shattrath City"]] = true,
			[BZ["Hellfire Peninsula"]] = true,
			[BZ["Nagrand"]] = true,
		},
		yards = 5399.832305361811,
		x_offset = 5912.521284664757,
		y_offset = 6821.146112637057,
        type = "PvP Zone",
		fishing_min = 355,
		texture = "TerokkarForest",
	}

	zones[BZ["Nagrand"]] = {
		low = 64,
		high = 67,
		continent = Outland,
		paths = {
			[BZ["Zangarmarsh"]] = true,
			[BZ["Shattrath City"]] = true,
			[BZ["Terokkar Forest"]] = true,
		},
		yards = 5524.827295176373,
		x_offset = 2700.121400200201,
		y_offset = 5779.512212073806,
        type = "PvP Zone",
		fishing_min = 380,
		texture = "Nagrand",
	}

	zones[BZ["Blade's Edge Mountains"]] = {
		low = 65,
		high = 68,
		continent = Outland,
		instances = BZ["Gruul's Lair"],
		paths = {
			[BZ["Netherstorm"]] = true,
			[BZ["Zangarmarsh"]] = true,
		},
		yards = 5424.84803598309,
		x_offset = 4150.068157139826,
		y_offset = 1412.982266241851,
		texture = "BladesEdgeMountains",
	}
	
	zones[BZ["Tempest Keep"]] = {
		continent = Outland,
		instances = {
			[BZ["The Mechanar"]] = true,
			[BZ["The Eye"]] = true,
			[BZ["The Botanica"]] = true,
			[BZ["The Arcatraz"]] = true,
		},
		paths = {
			[BZ["Netherstorm"]] = true,
			[BZ["The Mechanar"]] = true,
			[BZ["The Eye"]] = true,
			[BZ["The Botanica"]] = true,
			[BZ["The Arcatraz"]] = true,
		},
	}
	
	zones[BZ["Netherstorm"]] = {
		low = 67,
		high = 70,
		continent = Outland,
		instances = {
			[BZ["The Mechanar"]] = true,
			[BZ["The Botanica"]] = true,
			[BZ["The Arcatraz"]] = true,
			[BZ["The Eye"]] = true,
		},
		paths = {
			[BZ["Tempest Keep"]] = true,
			[BZ["Blade's Edge Mountains"]] = true,
		},
		yards = 5574.82788866266,
		x_offset = 7512.470386633603,
		y_offset = 365.0992858464317,
		fishing_min = 380,
		texture = "Netherstorm",
	}

	zones[BZ["Shadowmoon Valley"]] = {
		low = 67,
		high = 70,
		continent = Outland,
		instances = BZ["Black Temple"],
		paths = BZ["Terokkar Forest"],
		yards = 5499.827432644566,
		x_offset = 8770.765422136874,
		y_offset = 7769.034259125071,
		texture = "ShadowmoonValley",
	}
	
	zones[BZ["Black Temple"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		paths = BZ["Shadowmoon Valley"],
		groupSize = 25,
		type = "Instance",
	}
	
	zones[BZ["Auchenai Crypts"]] = {
		low = 64,
		high = 66,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
	}
	
	zones[BZ["Auchenai Crypts"]] = {
		low = 65,
		high = 67,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
	}
	
	zones[BZ["Shadow Labyrinth"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
	}
	
	zones[BZ["Sethekk Halls"]] = {
		low = 67,
		high = 69,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
	}
	
	zones[BZ["Mana-Tombs"]] = {
		low = 64,
		high = 66,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
	}
	
	zones[BZ["Hellfire Ramparts"]] = {
		low = 60,
		high = 62,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
	}
	
	zones[BZ["The Blood Furnace"]] = {
		low = 61,
		high = 63,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
	}
	
	zones[BZ["The Shattered Halls"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
	}
	
	zones[BZ["Magtheridon's Lair"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
	}
	
	zones[BZ["The Slave Pens"]] = {
		low = 62,
		high = 64,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
	}
	
	zones[BZ["The Underbog"]] = {
		low = 63,
		high = 65,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
	}
	
	zones[BZ["The Steamvault"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
	}
	
	zones[BZ["Serpentshrine Cavern"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
	}
	
	zones[BZ["Gruul's Lair"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		paths = BZ["Blade's Edge Mountains"],
		groupSize = 25,
		type = "Instance",
	}
	
	zones[BZ["The Mechanar"]] = {
		low = 69,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Tempest Keep"],
	}
	
	zones[BZ["The Botanica"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Tempest Keep"],
	}
	
	zones[BZ["The Arcatraz"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Tempest Keep"],
	}

	zones[BZ["The Eye"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Tempest Keep"],
	}

	zones[BZ["Eye of the Storm"]] = {
		low = 61,
		high = 70,
		continent = Outland,
		groupSize = 25,
		type = "Battleground",
		texture = "NetherstormArena",
	}
 
	-- arenas
	zones[BZ["Blade's Edge Arena"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		type = "Arena",
	}

	zones[BZ["Nagrand Arena"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		type = "Arena",
	}
	
	zones[BZ["Ruins of Lordaeron"]] = {
		low = 70,
		high = 70,
		continent = Kalimdor,
		type = "Arena",
	}
	
	-- 2.4 zones
	zones[BZ["Isle of Quel'Danas"]] = {
		continent = Eastern_Kingdoms,
		low = 70,
		high = 70,
		paths = BZ["Eversong Woods"], -- TODO: validate once we're sure about final state
		instances = {
			[BZ["Magisters' Terrace"]] = true,
			[BZ["Sunwell Plateau"]] = true,
		},
		texture = "Sunwell",
		yards = 3327.0830078125,
		x_offset = 0, --TODO: complete me
		y_offset = 0, --TODO: complete me
		fishing_min = 380, --TODO: validate
	}
	
	zones[BZ["Magisters' Terrace"]] = {
		low = 70,
		high = 70,
		continent = Eastern_Kingdoms,
		paths = BZ["Isle of Quel'Danas"],
		groupSize = 5,
		type = "Instance",
	}
	
	zones[BZ["Sunwell Plateau"]] = {
		low = 70,
		high = 70,
		continent = Eastern_Kingdoms,
		paths = BZ["Isle of Quel'Danas"],
		groupSize = 25,
		type = "Instance",
	}


	for k,v in pairs(zones) do
		lows[k] = v.low or 0
		highs[k] = v.high or 0
		continents[k] = v.continent or UNKNOWN
		instances[k] = v.instances
		paths[k] = v.paths or false
		types[k] = v.type or "Zone"
		groupSizes[k] = v.groupSize
		factions[k] = v.faction
		yardWidths[k] = v.yards
		yardHeights[k] = v.yards and v.yards * 2/3 or nil
		yardXOffsets[k] = v.x_offset
		yardYOffsets[k] = v.y_offset
		fishing[k] = v.fishing_min
		textures[k] = v.texture
		complexes[k] = v.complex
		if v.texture then
			textures_rev[v.texture] = k
		end
	end
	zones = nil
	
	PLAYER_LEVEL_UP(Tourist)
end

local function compat()
	local Tourist20 = setmetatable({}, {__index=function(self, key)
		if type(Tourist[key]) ~= "function" then
			self[key] = Tourist[key]
		else
			self[key] = function(self, ...)
				return Tourist[key](Tourist, ...)
			end
		end
		return rawget(self, key)
	end})
	AceLibrary:Register(Tourist20, "Tourist-2.0", MINOR_VERSION*1000)
end
if AceLibrary then
	compat()
elseif Rock then
	function Tourist:OnLibraryLoad(major, instance)
		if major == "AceLibrary" then
			compat()
		end
	end
end
