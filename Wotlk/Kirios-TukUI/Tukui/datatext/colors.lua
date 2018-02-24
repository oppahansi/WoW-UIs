-- Color system for Hydra datatexts
_, class = UnitClass("player")
hexa = TukuiCF["datatext"].color
hexb = "|r"

if TukuiCF["datatext"].classcolor == true then
	if class == "DEATHKNIGHT" then
		hexa = "|cffC41F3B"
	elseif class == "DRUID" then
		hexa = "|cffFF7D0A"
	elseif class == "HUNTER" then
		hexa = "|cffABD473"
	elseif class == "MAGE" then
		hexa = "|cff69CCF0"
	elseif class == "PALADIN" then
		hexa = "|cffF58CBA"
	elseif class == "PRIEST" then
		hexa = "|cffFFFFFF"
	elseif class == "ROGUE" then
		hexa = "|cffFFF569"
	elseif class == "SHAMAN" then
		hexa = "|cff2459FF"
	elseif class == "WARLOCK" then
		hexa = "|cff9482C9"
	elseif class == "WARRIOR" then
		hexa = "|cffC79C6E"
	end
end