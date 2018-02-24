local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = tonumber(("$Revision: 65358 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

DogTag:AddTag("Unit", "Combos", {
	code = GetComboPoints,
	ret = "number",
	events = "PLAYER_COMBO_POINTS",
	doc = L["Return the number of combo points you have"],
	example = '[Combos] => "5"',
	category = L["Miscellaneous"]
})

DogTag:AddTag("Unit", "ComboSymbols", {
	alias = [=[symbol:Repeat(Combos)]=],
	arg = {
		'symbol', 'string', '@'
	},
	doc = L["Return @ or argument repeated by the number of combo points you have"],
	example = '[ComboSymbols] => "@@@@@"; [ComboSymbols(X)] => "XXX"',
	category = L["Miscellaneous"]
})

end