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

	FWL.GET_SH_UPDATE = "Обновить количество Осколков душ у чернокнижников. Польностью функционально, только если кто-нибудь с аддоном является лидером или ассистентом!";

	FWL.SHARD_SPY = "Монитор Осколков душ";
	FWL.LITTLE_SHARDS = "Мало Осколков";
	FWL.MANY_SHARDS = "Много Осколков";
	FWL.UNKNOWN_N = "Неизвестно";

	FWL.SH_ENABLE_TT = "Включить монитор Осколков душ.";

	FWL.SHARD_CHECK_TIME = "Проверка Осколков";
	FWL.SHARD_DRAW_INTERVAL = "Интервал отображения Осколков";

	FWL._TOTAL = "Всего %d";

-- simple chinese
elseif GetLocale() == "zhCN" then

	FWL.GET_SH_UPDATE = "扫描碎片数据. 装了FW的同志有团队权限才能实现所有功能!";

	FWL.SHARD_SPY = "碎片助手";
	FWL.LITTLE_SHARDS = "碎片少";
	FWL.MANY_SHARDS = "碎片多";
	FWL.UNKNOWN_N = "未知";

	FWL.SH_ENABLE_TT = "启用碎片助手.";

	FWL.SHARD_CHECK_TIME = "碎片检查";
	FWL.SHARD_DRAW_INTERVAL = "碎片检查间隔";

	FWL._TOTAL = "共有 %d";

-- tradition chinese
elseif GetLocale() == "zhTW" then

	FWL.GET_SH_UPDATE = "掃描碎片資料. 裝了FW的隊員有團隊許可權才能實現所有功能!";

	FWL.SHARD_SPY = "碎片助手";
	FWL.LITTLE_SHARDS = "碎片少";
	FWL.MANY_SHARDS = "碎片多";
	FWL.UNKNOWN_N = "未知";

	FWL.SH_ENABLE_TT = "啟用碎片助手.";

	FWL.SHARD_CHECK_TIME = "碎片檢查";
	FWL.SHARD_DRAW_INTERVAL = "碎片檢查間隔";

	FWL._TOTAL = "共有 %d";
	
	-- ENGLISH
else
	FWL.GET_SH_UPDATE = "Get an update of warlock shard status now. Will only fully work when someone with the addon is promoted!";

	FWL.SHARD_SPY = "Shard Spy";
	FWL.LITTLE_SHARDS = "Little shards";
	FWL.MANY_SHARDS = "Many shards";
	FWL.UNKNOWN_N = "Unknown";

	FWL.SH_ENABLE_TT = "Enable the Shard Spy.";

	FWL.SHARD_CHECK_TIME = "Shard check";
	FWL.SHARD_DRAW_INTERVAL = "Shard draw interval";

	FWL._TOTAL = "%d total";

end
