-- ForteXorcist v1.959.8 by Xus 13-04-2010

--[[
"frFR": French
"deDE": German
"esES": Spanish
"enUS": American english
"enGB": British english
"zhCN": Simplified Chinese
"zhTW": Traditional Chinese
"ruRU": Russian

!! Make sure to keep this saved as UTF-8 format !!

]]
if FW.CLASS == "SHAMAN" then
--[[>> still needs translating]]
	local FWL = FW.L;
	FWL.ENERGIZED = GetSpellInfo(71220);
	
	--[[--RUSSIAN
	if GetLocale() == "ruRU" then
	-- FR
	elseif GetLocale() == "frFR" then
	-- DE 
	elseif GetLocale() == "deDE" then
	-- SPANISH
	elseif GetLocale() == "esES" then
	-- Simple Chinese
	elseif GetLocale() == "zhCN" then
	-- tradition Chinese
	elseif GetLocale() == "zhTW" then
	-- ENGLISH
	else
	
	end]]
	

	FWL.ENERGIZED_RELIC = FWL.ENERGIZED..FWL._RELIC;
	FWL.TOTEM_FIRE = "Fire Totem";
	FWL.TOTEM_EARTH = "Earth Totem";
	FWL.TOTEM_WATER = "Water Totem";
	FWL.TOTEM_AIR = "Air Totem";	
end 
