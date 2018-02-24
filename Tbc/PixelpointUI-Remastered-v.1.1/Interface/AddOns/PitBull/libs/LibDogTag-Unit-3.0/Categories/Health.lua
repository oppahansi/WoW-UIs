local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = tonumber(("$Revision: 66645 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

local function HP_func(unit, known)
	local hp = UnitHealth(unit)
	if known and UnitHealthMax(unit) == 100 then
		return nil
	else
		if hp == 1 and UnitIsGhost(unit) then
			return 0
		end
		return hp
	end
end

local function MaxHP_func(unit, known)
	local maxhp = UnitHealthMax(unit)
	if known and maxhp == 100 then
		return nil
	else
		return maxhp
	end
end

local HP_lib
DogTag:AddAddonFinder("Unit", "LibStub", "LibMobHealth-4.0", function(v)
	HP_lib = "LibMobHealth-4.0"
	local LibMobHealth = v
	function HP_func(unit, known)
		local hp, found = LibMobHealth:GetUnitCurrentHP(unit)
		if known and not found then
			return nil
		else
			if hp == 1 and UnitIsGhost(unit) then
				return 0
			end
			return hp
		end
	end
	function MaxHP_func(unit, known)
		local maxhp, found = LibMobHealth:GetUnitMaxHP(unit)
		if known and not found then
			return nil
		else
			return maxhp
		end
	end
end)

DogTag:AddAddonFinder("Unit", "_G", "MobHealth3", function(v)
	if HP_lib == "LibMobHealth-4.0" then
		return
	end
	local MobHealth3 = v
	function HP_func(unit, found)
		local currValue = UnitHealth(unit)
		if not UnitIsFriend("player", unit) then
			local maxValue = UnitHealthMax(unit)
			local curr, max, found = MobHealth3:GetUnitHealth(unit, currValue, maxValue)
			if found then
				return curr
			elseif known then
				return nil
			end
		elseif known and UnitHealthMax(unit) == 100 then
			return nil
		end
		return currValue
	end
	function MaxHP_func(unit, found)
		local maxValue = UnitHealthMax(unit)
		if not UnitIsFriend("player", unit) then
			local curr, max, MHfound = MobHealth3:GetUnitHealth(unit, 1, maxValue)
			if MHfound then
				return max
			elseif known then
				return nil
			end
		elseif known and maxValue == 100 then
			return nil
		end
		return maxValue
	end
end)

DogTag:AddAddonFinder("Unit", "_G", "MobHealth_PPP", function(v)
	if HP_lib then
		return
	end
	local MobHealth_PPP = v
	function HP_func(unit, found)
		local currValue = UnitHealth(unit)
		if not UnitIsFriend("player", unit) then
			local name = UnitName(unit)
			local level = UnitLevel(unit)
			local ppp = MobHealth_PPP(name..":"..level)
			if ppp > 0 then
				return math.floor(currValue * ppp + 0.5)
			elseif known then
				return nil
			end
		elseif known and UnitHealthMax(unit) == 100 then
			return nil
		end
		return currValue
	end
	function MaxHP_func(unit, found)
		local maxValue = UnitHealthMax(unit)
		if not UnitIsFriend("player", unit) then
			local name = UnitName(unit)
			local level = UnitLevel(unit)
			local ppp = MobHealth_PPP(name..":"..level)
			if ppp > 0 then
				return math.floor(100 * ppp + 0.5)
			elseif known then
				return nil
			end
		elseif known and maxValue == 100 then
			return nil
		end
		return maxValue
	end
end)

DogTag:AddTag("Unit", "HP", {
	code = function(args)
		return HP_func
	end,
	dynamicCode = true,
	arg = {
		'unit', 'string;undef', 'player',
		'known', 'boolean', false,
	},
	ret = function(args)
		if args.known.types == "nil" then
			return 'number'
		else
			return 'nil;number'
		end
	end,
	events = "UNIT_HEALTH#$unit;UNIT_MAXHEALTH#$unit",
	doc = L["Return the current health of unit, will use MobHealth if found"],
	example = ('[HP] => "%d"'):format(UnitHealthMax("player")*.758),
	category = L["Health"],
})

DogTag:AddTag("Unit", "MaxHP", {
	code = function(args)
		return MaxHP_func
	end,
	dynamicCode = true,
	arg = {
		'unit', 'string;undef', 'player',
		'known', 'boolean', false,
	},
	ret = function(args)
		if args.known.types == "nil" then
			return 'number'
		else
			return 'nil;number'
		end
	end,
	events = "UNIT_HEALTH#$unit;UNIT_MAXHEALTH#$unit",
	doc = L["Return the maximum health of unit, will use MobHealth if found"],
	example = ('[MaxHP] => "%d"'):format(UnitHealthMax("player")),
	category = L["Health"],
})

DogTag:AddTag("Unit", "PercentHP", {
	code = function(unit)
		local hp = UnitHealth(unit)
		if hp == 0 then
			return 0
		end
		return math.floor(hp/UnitHealthMax(unit)*1000 + 0.5) / 10
	end,
	fakeAlias = "[CurHP / MaxHP * 100]:Round(1)",
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "number",
	events = "UNIT_HEALTH#$unit;UNIT_MAXHEALTH#$unit",
	doc = L["Return the percentage health of unit"],
	example = '[PercentHP] => "75.8"; [PercentHP:Percent] => "75.8%"',
	category = L["Health"],
})

DogTag:AddTag("Unit", "MissingHP", {
	alias = [=[MaxHP(unit=unit, known=known) - HP(unit=unit, known=known)]=],
	arg = {
		'unit', 'string;undef', 'player',
		'known', 'boolean', false,
	},
	ret = "number",
	doc = L["Return the missing health of unit, will use MobHealth if found"],
	example = ('[MissingHP] => "%d"'):format(UnitHealthMax("player")*.242),
	category = L["Health"]
})

DogTag:AddTag("Unit", "FractionalHP", {
	alias = [=[Concatenate(HP(unit=unit, known=known), "/", MaxHP(unit=unit, known=known))]=],
	arg = {
		'unit', 'string;undef', 'player',
		'known', 'boolean', false,
	},
	ret = "string",
	doc = L["Return the current health and maximum health of unit, will use MobHealth if found"],
	example = ('[FractionalHP] => "%d/%d"'):format(UnitHealthMax("player")*.758, UnitHealthMax("player")),
	category = L["Health"]
})

DogTag:AddTag("Unit", "IsMaxHP", {
	code = function(unit)
		return UnitHealth(unit) == UnitHealthMax(unit)
	end,
	arg = {
		'unit', 'string;undef', 'player'
	},
	ret = "boolean",
	doc = L["Return True if unit is at full health"],
	example = ('[IsMaxHP] => %q; [IsMaxHP] => ""'):format(L["True"]),
	category = L["Health"]
})

DogTag:AddTag("Unit", "HPColor", {
	code = function(value, unit)
		local perc = UnitHealth(unit) / UnitHealthMax(unit)
		local r1, g1, b1
		local r2, g2, b2
		if perc <= 0.5 then
			perc = perc * 2
			r1, g1, b1 = unpack(DogTag.__colors.minHP)
			r2, g2, b2 = unpack(DogTag.__colors.midHP)
		else
			perc = perc * 2 - 1
			r1, g1, b1 = unpack(DogTag.__colors.midHP)
			r2, g2, b2 = unpack(DogTag.__colors.maxHP)
		end
		local r, g, b = r1 + (r2 - r1)*perc, g1 + (g2 - g1)*perc, b1 + (b2 - b1)*perc
		if r < 0 then
			r = 0
		elseif r > 1 then
			r = 1
		end
		if g < 0 then
			g = 0
		elseif g > 1 then
			g = 1
		end
		if b < 0 then
			b = 0
		elseif b > 1 then
			b = 1
		end
		if value then
			return ("|cff%02x%02x%02x%s|r"):format(r*255, g*255, b*255, value)
		else
			return ("|cff%02x%02x%02x"):format(r*255, g*255, b*255)
		end
	end,
	arg = {
		'value', 'string;undef', "@undef",
		'unit', 'string;undef', 'player'
	},
	ret = "string",
	events = "UNIT_HEALTH#$unit;UNIT_MAXHEALTH#$unit",
	doc = L["Return the color or wrap value with the health color of unit"],
	example = '["Hello":HPColor] => "|cffff7f00Hello|r"; [HPColor "Hello"] => "|cffff7f00Hello"',
	category = L["Health"]
})

end