-- ForteXorcist v1.959.8 by Xus 13-04-2010
-- Module by Lurosara
-- Shamelessly cribbed from Xus' Forte Warrior module.

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

--[[>> still needs translating]]

if FW.CLASS == "DRUID" then
	local FWL = FW.L;
	FWL.BERSERK = GetSpellInfo(50334);
	
	-- Russian
	if GetLocale() == "ruRU" then
	--[[>>]]FWL._FERAL = " (Feral)";
	
	-- FR
	elseif GetLocale() == "frFR" then
	--[[>>]]FWL._FERAL = " (Feral)";
	
	-- DE
	elseif GetLocale() == "deDE" then
	--[[>>]]FWL._FERAL = " (Feral)";
	
	-- SPANISH
	elseif GetLocale() == "esES" then
	--[[>>]]FWL._FERAL = " (Feral)";
	
	-- Simple Chinese
	elseif GetLocale() == "zhCN" then
	--[[>>]]FWL._FERAL = " (Feral)";
	
	-- tradition Chinese
	elseif GetLocale() == "zhTW" then
	--[[>>]]FWL._FERAL = " (Feral)";
	
	-- ENGLISH
	else
		FWL._FERAL = " (Feral)";
	end

	FWL.BERSERK_FERAL = FWL.BERSERK..FWL._FERAL;
end
