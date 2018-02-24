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

if FW.CLASS == "DEATHKNIGHT" then
	local FWL = FW.L;
	
	if GetLocale() == "ruRU" then
--[[>>]]FWL.RUNE_BLOOD = "Blood Rune";
--[[>>]]FWL.RUNE_UNHOLY = "Unholy Rune";
--[[>>]]FWL.RUNE_FROST = "Frost Rune";
--[[>>]]FWL.RUNE_ALL = "Death Rune";
	
	-- Simple Chinese
	elseif GetLocale() == "zhCN" then
		FWL.RUNE_BLOOD = "鲜血符文 ";
		FWL.RUNE_UNHOLY = "邪恶符文";
		FWL.RUNE_FROST = "冰霜符文";
		FWL.RUNE_ALL = "死亡符文";	
		
	-- tradition Chinese
	elseif GetLocale() == "zhTW" then
		FWL.RUNE_BLOOD = "血魄符文";
		FWL.RUNE_UNHOLY = "穢邪符文";
		FWL.RUNE_FROST = "冰霜符文";
		FWL.RUNE_ALL = "死亡符文";
		
	-- ENGLISH
	else
		FWL.RUNE_BLOOD = "Blood Rune";
		FWL.RUNE_UNHOLY = "Unholy Rune";
		FWL.RUNE_FROST = "Frost Rune";
		FWL.RUNE_ALL = "Death Rune";		
	end
end
