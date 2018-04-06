local K, C, L, _ = select(2, ...):unpack()
if C.Nameplate.Enable ~= true then return end

local GetSpellInfo = GetSpellInfo
----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Necrotic Plague> http://wotlk.openwow.com/spell=73787
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	if(not name) then
		print(" SpellID is not valid: "..id..". Please check for an updated version, if none exists report this to Kkthnx.")
		return "Impale"
	else
		return name
	end
end

K.DebuffWhiteList = {
	-- Death Knight
	[SpellName(49203)] = true,
	[SpellName(47476)] = true,
	-- Druid
	[SpellName(33786)] = true,
	[SpellName(2637)] = true,
	[SpellName(339)] = true,
	[SpellName(8921)] = true,
	[SpellName(5570)] = true,
	[SpellName(58180)] = true,
	[SpellName(33878)] = true,
	[SpellName(33745)] = true,
	[SpellName(1822)] = true,
	[SpellName(1079)] = true,
	-- Hunter
	[SpellName(3355)] = true,
	[SpellName(1513)] = true,
	[SpellName(19503)] = true,
	[SpellName(34490)] = true,
	-- Mage
	[SpellName(31661)] = true,
	[SpellName(61305)] = true,
	[SpellName(18469)] = true,
	[SpellName(122)] = true,
	[SpellName(55080)] = true,
	-- Paladin
	[SpellName(20066)] = true,
	[SpellName(10326)] = true,
	[SpellName(853)] = true,
	-- Priest
	[SpellName(605)] = true,
	[SpellName(64044)] = true,
	[SpellName(8122)] = true,
	[SpellName(9484)] = true,
	[SpellName(15487)] = true,
	-- Rogue
	[SpellName(2094)] = true,
	[SpellName(1776)] = true,
	[SpellName(6770)] = true,
	[SpellName(18425)] = true,
	-- Shaman
	[SpellName(51514)] = true,
	[SpellName(3600)] = true,
	[SpellName(8056)] = true,
	[SpellName(8050)] = true,
	[SpellName(63685)] = true,
	[SpellName(39796)] = true,
	-- Warlock
	[SpellName(710)] = true,
	[SpellName(6789)] = true,
	[SpellName(5782)] = true,
	[SpellName(5484)] = true,
	[SpellName(6358)] = true,
	[SpellName(30283)] = true,
	[SpellName(603)] = true,
	[SpellName(980)] = true,
	[SpellName(172)] = true,
	[SpellName(17800)] = true,
	[SpellName(48181)] = true,
	[SpellName(30108)] = true,
	[SpellName(348)] = true,
	-- Warrior
	[SpellName(20511)] = true,
	-- Racial
	[SpellName(25046)] = true,
	[SpellName(20549)] = true,
}

K.PlateBlacklist = {
	["Dragonmaw War Banner"] = true,
	["Healing Tide Totem"] = true,

	--Gundrak
	["Fanged Pit Viper"] = true,
	["Crafty Snake"] = true,

	--Shaman Totems
	["Disease Cleansing Totem"] = true,
	["Earth Elemental Totem"] = true,
	["Earthbind Totem"] = true,
	["Fire Elemental Totem"] = true,
	["Fire Nova Totem I"] = true,
	["Fire Nova Totem II"] = true,
	["Fire Nova Totem III"] = true,
	["Fire Nova Totem IV"] = true,
	["Fire Nova Totem V"] = true,
	["Fire Nova Totem VI"] = true,
	["Fire Nova Totem VII"] = true,
	["Fire Resistance Totem I"] = true,
	["Fire Resistance Totem II"] = true,
	["Fire Resistance Totem III"] = true,
	["Fire Resistance Totem IV"] = true,
	["Fire Resistance Totem "] = true,
	["Flametongue Totem I"] = true,
	["Flametongue Totem II"] = true,
	["Flametongue Totem III"] = true,
	["Flametongue Totem IV"] = true,
	["Flametongue Totem V"] = true,
	["Frost Resistance Totem I"] = true,
	["Frost Resistance Totem II"] = true,
	["Frost Resistance Totem III"] = true,
	["Frost Resistance Totem IV"] = true,
	["Grace of Air Totem I"] = true,
	["Tranquil Air Totem"] = true,
	["Grace of Air Totem II"] = true,
	["Grace of Air Totem III"] = true,
	["Grounding Totem"] = true,
	["Healing Stream Totem"] = true,
	["Healing Stream Totem II"] = true,
	["Healing Stream Totem III"] = true,
	["Healing Stream Totem IV"] = true,
	["Healing Stream Totem V "] = true,
	["Healing Stream Totem VI"] = true,
	["Magma Totem"] = true,
	["Magma Totem II"] = true,
	["Magma Totem III"] = true,
	["Magma Totem IV"] = true,
	["Magma Totem V"] = true,
	["Mana Spring Totem"] = true,
	["Mana Spring Totem II"] = true,
	["Mana Spring Totem III"] = true,
	["Mana Spring Totem IV"] = true,
	["Mana Spring Totem V"] = true,
	["Mana Tide Totem"] = true,
	["Nature Resistance Totem"] = true,
	["Nature Resistance Totem II"] = true,
	["Nature Resistance Totem III"] = true,
	["Nature Resistance Totem IV"] = true,
	["Nature Resistance Totem V"] = true,
	["Nature Resistance Totem V"] = true,
	["Poison Cleansing Totem"] = true,
	["Searing Totem"] = true,
	["Searing Totem II"] = true,
	["Searing Totem III"] = true,
	["Searing Totem IV"] = true,
	["Searing Totem V"] = true,
	["Searing Totem VI"] = true,
	["Searing Totem VII"] = true,
	["Sentry Totem"] = true,
	["Stoneclaw Totem"] = true,
	["Stoneclaw Totem II"] = true,
	["Stoneclaw Totem III"] = true,
	["Stoneclaw Totem IV"] = true,
	["Stoneclaw Totem V"] = true,
	["Stoneclaw Totem VI"] = true,
	["Stoneclaw Totem VII"] = true,
	["Stoneskin Totem"] = true,
	["Stoneskin Totem II"] = true,
	["Stoneskin Totem III"] = true,
	["Stoneskin Totem IV"] = true,
	["Stoneskin Totem V"] = true,
	["Stoneskin Totem VI"] = true,
	["Stoneskin Totem VII"] = true,
	["Stoneskin Totem VIII"] = true,
	["Strength of Earth Totem"] = true,
	["Strength of Earth Totem II"] = true,
	["Strength of Earth Totem III"] = true,
	["Strength of Earth Totem IV"] = true,
	["Strength of Earth Totem V"] = true,
	["Strength of Earth Totem VI"] = true,
	["Totem of Wrath"] = true,
	["Totem of Wrath II"] = true,
	["Totem of Wrath III"] = true,
	["Totem of Wrath IV"] = true,
	["Windfury Totem"] = true,
	["Windfury Totem II"] = true,
	["Windfury Totem III"] = true,
	["Windfury Totem IV"] = true,
	["Windfury Totem V"] = true,
	["Windwall Totem"] = true,
	["Windwall Totem II"] = true,
	["Windwall Totem III"] = true,
	["Windwall Totem IV"] = true,
	["Wrath of Air Totem"] = true,

	--The gayest ability in the game
	["Army of the Dead Ghoul"] = true,

	--Hunter Trap
	["Venomous Snake"] = true,
	["Viper"] = true,
}