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
if FW.CLASS == "MAGE" then
	local FWL = FW.L;
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

	--simpal chinese
	if GetLocale() == "zhCN" then
		
		FWL.BREAK_FADE = "打断/消退";
		FWL.BREAK_FADE_HINT1 = "变形术打断/消退时显示字符.";
		FWL.POLYMORPH_BREAK = "变形术打断";
		FWL.POLYMORPH_FADE = "变形术消退";

	--traditional chinese
	elseif GetLocale() == "zhTW" then
		
		FWL.BREAK_FADE = "打斷/消退";
		FWL.BREAK_FADE_HINT1 = "變形術打斷/消退時顯示字元.";
		FWL.POLYMORPH_BREAK = "變形術打斷";
		FWL.POLYMORPH_FADE = "變形術消退";
		
	-- ENGLISH
	else	-- standard english version

		FWL.BREAK_FADE = "Break/Fade";
		FWL.BREAK_FADE_HINT1 = "The time you set in the fade string defines when it is displayed.";
		FWL.POLYMORPH_BREAK = "Polymorph Break";
		FWL.POLYMORPH_FADE = "Polymorph Fade";

	end
end
	