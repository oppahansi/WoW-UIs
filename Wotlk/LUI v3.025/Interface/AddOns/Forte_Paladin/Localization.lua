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

--[[>> still needs translating]]
if FW.CLASS == "PALADIN" then
	local FWL = FW.L;
	FWL.SACRED_SHIELD = GetSpellInfo(58597);
	--[[
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
	FWL.SACRED_SHIELD_EFFECT = FWL.SACRED_SHIELD..FWL._EFFECT;
end
	