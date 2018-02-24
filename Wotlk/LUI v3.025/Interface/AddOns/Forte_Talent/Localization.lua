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

local FWL = FW.L;
--[[ RU
if GetLocale() == "ruRU" then
-- FR
elseif GetLocale() == "frFR" then
-- DE 
elseif GetLocale() == "deDE" then
-- SPANISH
elseif GetLocale() == "esES" then
-- ENGLISH
else
end]]

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

if GetLocale() == "ruRU" then 

	FWL.TS = "Монитор Талантов";
	FWL.TS_USE = "Вы можете использовать новое выпадающий список монитора в окне Талантов.";
	FWL.TS_HINT = "В настоящий момент, вы должны осмотреть людей без этого аддона, для запоминания их талантов.";
	FWL.TALENT_OFFSETX = "Отступ по горизонтали";
	FWL.TALENT_OFFSETY = "Отступ по вертикали";
	FWL.TALENT_OFFSET_TT = "Используйте это, если вы используете измененное окно талантов и требуется изменить позицию выпадающего списка и кнопок.";

-- simple chinese
elseif GetLocale() == "zhCN" then

	FWL.TS = "天赋助手";
	FWL.TS_USE = "在你的天赋窗口有新的下拉菜单使用.";
	FWL.TS_HINT = "你必须要观察那些没有装此插件的人,以保存其天赋.";
	FWL.TALENT_OFFSETX = "菜单水平偏移";
	FWL.TALENT_OFFSETY = "菜单垂直偏移";
	FWL.TALENT_OFFSET_TT = "此选项是为了你使用自定义天赋窗口,需要移动下拉菜单和按钮准备的";

-- tradition chinese
elseif GetLocale() == "zhTW" then

	FWL.TS = "天賦助手";
	FWL.TS_USE = "在你的天賦視窗有新的下拉功能表使用.";
	FWL.TS_HINT = "你必須要觀察那些沒有裝此插件的人,以保存其天賦.";
	FWL.TALENT_OFFSETX = "菜單水準偏移";
	FWL.TALENT_OFFSETY = "菜單垂直偏移";
	FWL.TALENT_OFFSET_TT = "此選項是為了你使用自定義天賦視窗,需要移動下拉功能表和按鈕準備的";

-- ENGLISH
else

	FWL.TS = "Talent Spy";
	FWL.TS_USE = "You can use the new spy dropdown menu from your Talent frame.";
	FWL.TS_HINT = "For now you have to inspect people that aren't using the addon to store their talents.";
	FWL.TALENT_OFFSETX = "X-offset dropdown";
	FWL.TALENT_OFFSETY = "Y-offset dropdown";
	FWL.TALENT_OFFSET_TT = "Use this in case you're using a customized Talent Frame and need to change the position of the dropdown and buttons.";
	
end