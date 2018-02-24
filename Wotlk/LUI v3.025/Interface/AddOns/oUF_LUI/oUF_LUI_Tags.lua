LUI = LibStub("AceAddon-3.0"):GetAddon("LUI")
db = LUI.db.profile

oUF.TagEvents['[DiffColor]'] = 'UNIT_LEVEL'
if (not oUF.Tags['[DiffColor]']) then
	oUF.Tags['[DiffColor]']  = function(unit)
		local r, g, b
		local level = UnitLevel(unit)
		if (level < 1) then
			r, g, b = db.oUF.Colors.Diff.Diff1.r, db.oUF.Colors.Diff.Diff1.g, db.oUF.Colors.Diff.Diff1.b
		else
			local DiffColor = UnitLevel('target') - UnitLevel('player')
			if (DiffColor >= 5) then
				r, g, b = db.oUF.Colors.Diff.Diff1.r, db.oUF.Colors.Diff.Diff1.g, db.oUF.Colors.Diff.Diff1.b
			elseif (DiffColor >= 3) then
				r, g, b = db.oUF.Colors.Diff.Diff2.r, db.oUF.Colors.Diff.Diff2.g, db.oUF.Colors.Diff.Diff2.b
			elseif (DiffColor >= -2) then
				r, g, b = db.oUF.Colors.Diff.Diff3.r, db.oUF.Colors.Diff.Diff3.g, db.oUF.Colors.Diff.Diff3.b
			elseif (-DiffColor <= GetQuestGreenRange()) then
				r, g, b = db.oUF.Colors.Diff.Diff4.r, db.oUF.Colors.Diff.Diff4.g, db.oUF.Colors.Diff.Diff4.b
			else
				r, g, b = db.oUF.Colors.Diff.Diff5.r, db.oUF.Colors.Diff.Diff5.g, db.oUF.Colors.Diff.Diff5.b
			end
		end
		return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
	end
end

oUF.TagEvents['[level2]'] = 'UNIT_LEVEL'
if (not oUF.Tags['[level2]']) then
	oUF.Tags['[level2]'] = function(unit)
		local l = UnitLevel(unit)
		return (l > 0) and l
	end
end

local colors = setmetatable({
	power = setmetatable({
		["MANA"] = {tonumber(db.oUF.Colors.Power.Mana.r), tonumber(db.oUF.Colors.Power.Mana.g), tonumber(db.oUF.Colors.Power.Mana.b)},
		["RAGE"] = {tonumber(db.oUF.Colors.Power.Rage.r), tonumber(db.oUF.Colors.Power.Rage.g), tonumber(db.oUF.Colors.Power.Rage.b)},
		["FOCUS"] = {tonumber(db.oUF.Colors.Power.Focus.r), tonumber(db.oUF.Colors.Power.Focus.g), tonumber(db.oUF.Colors.Power.Focus.b)},
		["ENERGY"] = {tonumber(db.oUF.Colors.Power.Energy.r), tonumber(db.oUF.Colors.Power.Energy.g), tonumber(db.oUF.Colors.Power.Energy.b)},
		["RUNES"] = {tonumber(db.oUF.Colors.Power.Runes.r), tonumber(db.oUF.Colors.Power.Runes.g), tonumber(db.oUF.Colors.Power.Runes.b)},
		["RUNIC_POWER"] = {tonumber(db.oUF.Colors.Power.RunicPower.r), tonumber(db.oUF.Colors.Power.RunicPower.g), tonumber(db.oUF.Colors.Power.RunicPower.b)},
		["AMMOSLOT"] = {tonumber(db.oUF.Colors.Power.AmmoSlot.r), tonumber(db.oUF.Colors.Power.AmmoSlot.g), tonumber(db.oUF.Colors.Power.AmmoSlot.b)},
		["FUEL"] = {tonumber(db.oUF.Colors.Power.Fuel.r), tonumber(db.oUF.Colors.Power.Fuel.g), tonumber(db.oUF.Colors.Power.Fuel.b)},
		["POWER_TYPE_STEAM"] = {0.55, 0.57, 0.61},
		["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
	}, {__index = oUF.colors.power}),
	class = setmetatable({
		["WARRIOR"] = {tonumber(db.oUF.Colors.Class.Warrior.r), tonumber(db.oUF.Colors.Class.Warrior.g), tonumber(db.oUF.Colors.Class.Warrior.b)},
		["PRIEST"] = {tonumber(db.oUF.Colors.Class.Priest.r), tonumber(db.oUF.Colors.Class.Priest.g), tonumber(db.oUF.Colors.Class.Priest.b)},
		["DRUID"] = {tonumber(db.oUF.Colors.Class.Druid.r), tonumber(db.oUF.Colors.Class.Druid.g), tonumber(db.oUF.Colors.Class.Druid.b)},
		["HUNTER"] = {tonumber(db.oUF.Colors.Class.Hunter.r), tonumber(db.oUF.Colors.Class.Hunter.g), tonumber(db.oUF.Colors.Class.Hunter.b)},
		["MAGE"] = {tonumber(db.oUF.Colors.Class.Mage.r), tonumber(db.oUF.Colors.Class.Mage.g), tonumber(db.oUF.Colors.Class.Mage.b)},
		["PALADIN"] = {tonumber(db.oUF.Colors.Class.Paladin.r), tonumber(db.oUF.Colors.Class.Paladin.g), tonumber(db.oUF.Colors.Class.Paladin.b)},
		["SHAMAN"] = {tonumber(db.oUF.Colors.Class.Shaman.r), tonumber(db.oUF.Colors.Class.Shaman.g), tonumber(db.oUF.Colors.Class.Shaman.b)},
		["WARLOCK"] = {tonumber(db.oUF.Colors.Class.Warlock.r), tonumber(db.oUF.Colors.Class.Warlock.g), tonumber(db.oUF.Colors.Class.Warlock.b)},
		["ROGUE"] = {tonumber(db.oUF.Colors.Class.Rogue.r), tonumber(db.oUF.Colors.Class.Rogue.g), tonumber(db.oUF.Colors.Class.Rogue.b)},
		["DEATH KNIGHT"] = {tonumber(db.oUF.Colors.Class.DeathKnight.r), tonumber(db.oUF.Colors.Class.DeathKnight.g), tonumber(db.oUF.Colors.Class.DeathKnight.b)},
	}, {__index = oUF.colors.class}),
	happiness = setmetatable({
		[1] = {tonumber(db.oUF.Colors.Happiness.Happiness1.r), tonumber(db.oUF.Colors.Happiness.Happiness1.g), tonumber(db.oUF.Colors.Happiness.Happiness1.b)},
		[2] = {tonumber(db.oUF.Colors.Happiness.Happiness2.r), tonumber(db.oUF.Colors.Happiness.Happiness2.g), tonumber(db.oUF.Colors.Happiness.Happiness2.b)},
		[3] = {tonumber(db.oUF.Colors.Happiness.Happiness3.r), tonumber(db.oUF.Colors.Happiness.Happiness3.g), tonumber(db.oUF.Colors.Happiness.Happiness3.b)},
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
		[1] = {tonumber(db.oUF.Colors.Runes.Rune1.r), tonumber(db.oUF.Colors.Runes.Rune1.g), tonumber(db.oUF.Colors.Runes.Rune1.b)},
		[2] = {tonumber(db.oUF.Colors.Runes.Rune2.r), tonumber(db.oUF.Colors.Runes.Rune2.g), tonumber(db.oUF.Colors.Runes.Rune2.b)},
		[3] = {tonumber(db.oUF.Colors.Runes.Rune3.r), tonumber(db.oUF.Colors.Runes.Rune3.g), tonumber(db.oUF.Colors.Runes.Rune3.b)},
		[4] = {tonumber(db.oUF.Colors.Runes.Rune4.r), tonumber(db.oUF.Colors.Runes.Rune4.g), tonumber(db.oUF.Colors.Runes.Rune4.b)},
	}, {__index = oUF.colors.runes}),
}, {__index = oUF.colors})

oUF.colors.LUI = {db.Theme.IndividualColor_r,db.Theme.IndividualColor_g,db.Theme.IndividualColor_b}
ColorsTapped = {tonumber(db.oUF.Colors.Tapped.r), tonumber(db.oUF.Colors.Tapped.g), tonumber(db.oUF.Colors.Tapped.b)}

oUF.colors.disconnected = {0.11,0.11,0.11}

oUF.colors.smooth = {tonumber(db.oUF.Colors.Smooth.Smooth1.r),tonumber(db.oUF.Colors.Smooth.Smooth1.g), tonumber(db.oUF.Colors.Smooth.Smooth1.b),tonumber(db.oUF.Colors.Smooth.Smooth2.r),tonumber(db.oUF.Colors.Smooth.Smooth2.g),tonumber(db.oUF.Colors.Smooth.Smooth2.b),tonumber(db.oUF.Colors.Smooth.Smooth3.r),tonumber(db.oUF.Colors.Smooth.Smooth3.g),tonumber(db.oUF.Colors.Smooth.Smooth3.b)}

oUF.TagEvents['[GetNameColor]'] = 'UNIT_HAPPINESS'
if (not oUF.Tags['[GetNameColor]']) then
	oUF.Tags['[GetNameColor]'] = function(unit)
	
		local reaction = UnitReaction(unit, 'player')
		local pClass, pToken = UnitClass(unit)
		local pClass2, pToken2 = UnitPowerType(unit)
		local color = colors.class[pToken]
		local color2 = colors.power[pToken2]
		local c = nil
		
		if (unit == 'pet' and GetPetHappiness()) then
			c = colors.happiness[GetPetHappiness()]
			if c then
				return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
			else
				return string.format('|cff%02x%02x%02x', 0.8 * 255, 0.8 * 255, 0.8 * 255)
			end
		elseif (UnitIsPlayer(unit)) then
			if color then
				return string.format('|cff%02x%02x%02x', color[1] * 255, color[2] * 255, color[3] * 255)
			else
				if color2 then
					return string.format('|cff%02x%02x%02x', color2[1] * 255, color2[2] * 255, color2[3] * 255)
				else
					return string.format('|cff%02x%02x%02x', 0.8 * 255, 0.8 * 255, 0.8 * 255)
				end
			end
		else
			if color2 then
				return string.format('|cff%02x%02x%02x', color2[1] * 255, color2[2] * 255, color2[3] * 255)
			else
				if color then
					return string.format('|cff%02x%02x%02x', color[1] * 255, color[2] * 255, color[3] * 255)
				else
					return string.format('|cff%02x%02x%02x', 0.8 * 255, 0.8 * 255, 0.8 * 255)
				end
			end
		end
	end
end

utf8sub = function(string, i, dots)
	local bytes = string:len()
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end

		if (len == i and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and '...' or '')
		else
			return string
		end
	end
end

oUF.TagEvents['[NameShort]'] = 'UNIT_NAME_UPDATE'
if (not oUF.Tags['[NameShort]']) then
	oUF.Tags['[NameShort]'] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 6, false)
	end
end

oUF.TagEvents['[NameMedium]'] = 'UNIT_NAME_UPDATE'
if (not oUF.Tags['[NameMedium]']) then
	oUF.Tags['[NameMedium]'] = function(unit)
		local name = UnitName(unit)
		if (unit == 'pet' and name == 'Unknown') then
			return 'Pet'
		else
			return utf8sub(name, 18, true)
		end
	end
end

oUF.TagEvents['[NameLong]'] = 'UNIT_NAME_UPDATE'
if (not oUF.Tags['[NameLong]']) then
	oUF.Tags['[NameLong]'] = function(unit)

			local name = UnitName(unit)
			return utf8sub(name, 36, true)

	end
end









