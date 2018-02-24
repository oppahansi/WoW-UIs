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

	FWL.GET_HS_UPDATE = "Запустить обновление статуса камней здоровья. Полностью функционально только если кто-нибудь с аддоном является лидером рейда или помощником! Щелкните правой кнопкой для проведения Ритуала душ.";
	FWL.UPDATE_AND_RITUAL = "Обновить сейчас / Ритуал душ";

	FWL.HEALTHSTONE_SPY = "Монитор Камней здоровья";
	FWL.LITTLE_HS = "Мало Камней здоровья";
	FWL.MANY_HS = "Много Камней здоровья";
	FWL.SHOW_MISSING = "Показать недостающие";
	FWL.SHOW_MISSING_TT = "Вместо количество камней здоровья в рейде, панели будут показывать количество недостающих камней здоровья.";
	FWL.NUM_TYPES = "Количество типов для отслеживания";
	FWL.NUM_TYPES_TT = "Максимальное количество типов Камней здоровья для отслеживания.";
	FWL.ONLY_TOP_RANK = "Показывать только максимальный уровень";
	FWL.ONLY_TOP_RANK_TT = "Когда включено, монитор не будет отображать камни здоровья различных уровней. Когда отключено, всегда будет отображаться указанное количество типов.";

	FWL.HS_ENABLE_TT = "Включить монитор камней здоровья.";

	FWL.HEALTHSTONE_CHECK_TIME = "Проверка камней здоровья";
	FWL.HEALTHSTONE_DRAW_INTERVAL = "Интервал отображения камней здоровья";
	
	FWL.YOU_HAVE_ = "У вас: %s";	
	FWL.MISSING_ = "Не хватает: %s";
	FWL.MADE_BY_ = "Изготовитель: %s";
	
--[[>>]]FWL.USE_HEALTHSTONE = "Use Healthstone";
--[[>>]]FWL.TOTAL = "Total";

elseif GetLocale() == "zhCN" then
	FWL.GET_HS_UPDATE = "扫描糖果数据.只有装了FW的同志拥有团队权限才能实现所有功能";
	FWL.UPDATE_AND_RITUAL = "扫描糖果 / 灵魂仪式";

	FWL.HEALTHSTONE_SPY = "糖果助手";
	FWL.LITTLE_HS = "糖果少";
	FWL.MANY_HS = "糖果多";
	FWL.SHOW_MISSING = "显示缺少的糖果";
	FWL.SHOW_MISSING_TT = "糖果条上显示的是缺少的糖果,而不是团队中现有的糖果.";
	FWL.NUM_TYPES = "监视糖果类型";
	FWL.NUM_TYPES_TT = "最多监视糖果类型.";
	FWL.ONLY_TOP_RANK = "只显示顶级糖果";
	FWL.ONLY_TOP_RANK_TT = "开启此功能,插件不会监视其他级别的糖果. 禁用此功能,插件显示所有类型糖果.";

	FWL.HS_ENABLE_TT = "启用糖果助手.";

	FWL.HEALTHSTONE_CHECK_TIME = "治疗石检查";
	FWL.HEALTHSTONE_DRAW_INTERVAL = "治疗石扫描间隔";
	
	FWL.YOU_HAVE_ = "你现有: %s";
	FWL.MISSING_ = "缺少: %s";
	FWL.MADE_BY_ = "制作人: %s";

	FWL.USE_HEALTHSTONE = "使用治疗石";
	
	FWL.TOTAL = "共计";

elseif GetLocale() == "zhTW" then

	FWL.GET_HS_UPDATE = "掃描糖果資料.只有裝了FW的同志擁有團隊許可權才能實現所有功能";
	FWL.UPDATE_AND_RITUAL = "掃描糖果 / 靈魂儀式";

	FWL.HEALTHSTONE_SPY = "糖果助手";
	FWL.LITTLE_HS = "糖果少";
	FWL.MANY_HS = "糖果多";
	FWL.SHOW_MISSING = "顯示缺少的糖果";
	FWL.SHOW_MISSING_TT = "糖果條上顯示的是缺少的糖果,而不是團隊中現有的糖果.";
	FWL.NUM_TYPES = "監視糖果類型";
	FWL.NUM_TYPES_TT = "最多監視糖果類型.";
	FWL.ONLY_TOP_RANK = "只顯示頂級糖果";
	FWL.ONLY_TOP_RANK_TT = "開啟此功能,插件不會監視其他級別的糖果. 禁用此功能,插件顯示所有類型糖果.";

	FWL.HS_ENABLE_TT = "啟用糖果助手.";
	FWL.HEALTHSTONE_CHECK_TIME = "治療石檢查";
	FWL.HEALTHSTONE_DRAW_INTERVAL = "治療石掃描間隔";
	
	FWL.YOU_HAVE_ = "你現有: %s";
	FWL.MISSING_ = "缺失: %s";
	FWL.MADE_BY_ = "製造者: %s";
	
	FWL.USE_HEALTHSTONE = "使用治療石";
	
	FWL.TOTAL = "總數";
	
-- ENGLISH
else
	FWL.GET_HS_UPDATE = "Get an update of healthstone status now. Will only fully work when someone with the addon is promoted! Right-click to summon a Soulwell.";
	FWL.UPDATE_AND_RITUAL = "Update Now / Ritual of Souls";

	FWL.HEALTHSTONE_SPY = "Healthstone Spy";
	FWL.LITTLE_HS = "Little Healthstones";
	FWL.MANY_HS = "Many Healthstones";
	FWL.SHOW_MISSING = "Show missing";
	FWL.SHOW_MISSING_TT = "Instead of the number of healthstones present in the raid, the bars will show the number of missing healthstones.";
	FWL.NUM_TYPES = "Number of types to track";
	FWL.NUM_TYPES_TT = "The maximum number of Healthstone types to track.";
	FWL.ONLY_TOP_RANK = "Only show top rank";
	FWL.ONLY_TOP_RANK_TT = "With this enabled, the spy will not show healthstones of different ranks. Disabled, it will always display the number of types you specified.";

	FWL.HS_ENABLE_TT = "Enable the Healthstone Spy.";

	FWL.HEALTHSTONE_CHECK_TIME = "Healthstone check";
	FWL.HEALTHSTONE_DRAW_INTERVAL = "Healthstone draw interval";
	
	FWL.YOU_HAVE_ = "You have: %s";	
	FWL.MISSING_ = "Missing: %s";
	FWL.MADE_BY_ = "Made by: %s";
	
	FWL.USE_HEALTHSTONE = "Use Healthstone";
	
	FWL.TOTAL = "Total";
end

