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
-- RU by Papo
--[[if GetLocale() == "ruRU" then
-- FR
elseif GetLocale() == "frFR" then
-- DE 
elseif GetLocale() == "deDE" then
-- SPANISH
elseif GetLocale() == "esES" then
-- simple chinese
elseif GetLocale() == "zhCN" then
-- tradition chinese
elseif GetLocale() == "zhTW" then
-- ENGLISH
else
end]]

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

if GetLocale() == "ruRU" then

	FWL.SOULSTONE_TRACKER = "Монитор Камней душ";
	FWL.SHOW_ALL_ABILITIES = "Показывать способности всех классов (oRA3)";
	FWL.SHOW_ALL_ABILITIES_TT = "Когда включено, вы сможете видеть кулдауны способностей всех классов, поддерживаемые oRA3.";
	FWL.SHOW_READY = "Показывать готовые способности";
	FWL.SHOW_READY_TT = "Задает отображение не только способностей на кулдауне, но и готовых."; 
	FWL.SHOW_SOULSTONE_MESSAGES = "Показывать сообщения Камней душ";
	FWL.SHOW_SOULSTONE_MESSAGES_TT = "Показывает сообщения о истекших Камнях душ и тому подобные.";
	FWL.SOULSTONE_MESSAGES_COLOR = "Сообщения Камней душ";
	FWL.SS_FULL = "Камень душ заполнен";
	FWL.SS_EMPTY = "Камень душ пуст";
	FWL.RESURRECT = "Воскрешение";
	FWL.DEAD_OFFLINE_MIXING = "Смешивание мертвых/вышедших из игры";
	FWL.WARLOCK = "Чернокнижник";
	FWL.DRUID = "Друид";
	FWL.PALADIN = "Паладин";
	FWL.SHAMAN = "Шаман";	
	FWL.DEAD_OFFLINE_MIXING_TT = "Цвет класса будет смешан с цветом мертвых/вышедших из игры с этим коэффициентом. 1.0 значит, что цвет будет полностью цветом класса. 0.0 значит, что цвет будет полностью цветом мертвых/вышедших из сети.";

	FWL.SS_ENABLE_TT = "Включить монитор Камней душ.";

	FWL.DI_GAIN = "%s получил Божественное Вмешательство.";
	FWL.DI_FADE = "Божественное вмешательство рассеивается с %s.";
	FWL.SS_EXPIRE = "Камень души иссяк на %s.";
	FWL.SS_EXPIRE_YOUR = "Ваш Камень души иссяк на %s.";
	FWL.SS_EXPIRE_OTHER = "Камень души %s иссяк на %s.";
	FWL.SS_DIED = "%s погиб с Камнем души на нем.";
	FWL.SS_DIED_YOUR = "%s погиб с вашим Камнем души на нем.";
	FWL.SS_DIED_OTHER = "%s погиб с Камнем души %s на нем.";

	FWL.SHORT_READY = "готов";
	FWL.READY_TO_RES = "готов к воскрешению";
	FWL.NO_SS_UP = "нет КД";

	FWL.FLAG_SOULSTONE = "<Камень души>";
	FWL.FLAG_REBIRTH = "<Возрождение>";
	FWL.FLAG_DIVINE_INTERVENTION = "<Божественное Вмеш>";
	FWL.FLAG_ANKH = "<Крест>";

	FWL.DELAY_MAX_SS_BUFF = "Максимальная длительность Камня души";
	
--[[>>]]FWL.USE_SOULSTONE = "Use Soulstone";

-- simple chinese
elseif GetLocale() == "zhCN" then

	FWL.SOULSTONE_TRACKER = "灵魂石助手";
	FWL.SHOW_ALL_ABILITIES = "显示其他职业技能CD(oRA3)";
	FWL.SHOW_ALL_ABILITIES_TT = "开启此功能,你可以看见oRA3支持的其他职业技能的CD.";
	FWL.SHOW_READY = "显示可用技能";
	FWL.SHOW_READY_TT = "此功能不仅显示CD中的技能,而且显示CD完成后的技能."; 
	FWL.SHOW_SOULSTONE_MESSAGES = "显示灵魂石信息";
	FWL.SHOW_SOULSTONE_MESSAGES_TT = "显示过期或者相似的灵魂石信息.";
	FWL.SOULSTONE_MESSAGES_COLOR = "灵魂石信息";
	FWL.SS_FULL = "灵魂石开始";
	FWL.SS_EMPTY = "灵魂石失效";
	FWL.RESURRECT = "复活";
	FWL.DEAD_OFFLINE_MIXING = "死亡/下线";
	FWL.WARLOCK = "术士";
	FWL.DRUID = "德鲁伊";
	FWL.PALADIN = "圣骑士";
	FWL.SHAMAN = "萨满祭司";	
	FWL.DEAD_OFFLINE_MIXING_TT = "职业颜色和死亡/掉线颜色按此比例混合. 1.0表示完全为职业颜色. 0.0 表示完全为死亡/掉线颜色.";

	FWL.SS_ENABLE_TT = "开始灵魂石助手.";

	FWL.DI_GAIN = "%s 获得了神圣干涉.";
	FWL.DI_FADE = "神圣干涉从 %s 身上消失了.";
	FWL.SS_EXPIRE = "%s 的灵魂石过期了.";
	FWL.SS_EXPIRE_YOUR = "你给 %s 的灵魂石过期了.";
	FWL.SS_EXPIRE_OTHER = "%s 给 %s 的灵魂石过期了.";
	FWL.SS_DIED = "%s 带着灵魂石挂了.";
	FWL.SS_DIED_YOUR = "%s 带着你的灵魂石挂了.";
	FWL.SS_DIED_OTHER = "%s 带着 %s 的灵魂石挂了.";

	FWL.SHORT_READY = "准备";
	FWL.READY_TO_RES = "可以释放";
	FWL.NO_SS_UP = "没有灵魂石";

	FWL.FLAG_SOULSTONE = "<灵魂石>";
	FWL.FLAG_REBIRTH = "<复生>";
	FWL.FLAG_DIVINE_INTERVENTION = "<神圣干涉>";
	FWL.FLAG_ANKH = "<十字章>";

	FWL.DELAY_MAX_SS_BUFF = "灵魂石buff最大延迟";
	
	FWL.USE_SOULSTONE = "使用灵魂石";

-- tradition chinese
elseif GetLocale() == "zhTW" then

	FWL.SOULSTONE_TRACKER = "靈魂石助手";
	FWL.SHOW_ALL_ABILITIES = "顯示其他職業技能CD(oRA3)";
	FWL.SHOW_ALL_ABILITIES_TT = "開啟此功能,你可以看見oRA3支援的其他職業技能的CD.";
	FWL.SHOW_READY = "顯示可用技能";
	FWL.SHOW_READY_TT = "此功能不僅顯示CD中的技能,而且顯示CD完成後的技能."; 
	FWL.SHOW_SOULSTONE_MESSAGES = "顯示靈魂石資訊";
	FWL.SHOW_SOULSTONE_MESSAGES_TT = "顯示過期或者相似的靈魂石資訊.";
	FWL.SOULSTONE_MESSAGES_COLOR = "靈魂石資訊";
	FWL.SS_FULL = "靈魂石開始";
	FWL.SS_EMPTY = "靈魂石失效";
	FWL.RESURRECT = "復活";
	FWL.DEAD_OFFLINE_MIXING = "死亡/下線";
	FWL.WARLOCK = "術士";
	FWL.DRUID = "德魯伊";
	FWL.PALADIN = "聖騎士";
	FWL.SHAMAN = "薩滿祭司";	
	FWL.DEAD_OFFLINE_MIXING_TT = "職業顏色和死亡/掉線顏色按此比例混合. 1.0表示完全為職業顏色. 0.0 表示完全為死亡/掉線顏色.";

	FWL.SS_ENABLE_TT = "開始靈魂石助手.";

	FWL.DI_GAIN = "%s 獲得了神聖干涉.";
	FWL.DI_FADE = "神聖干涉從 %s 身上消失了.";
	FWL.SS_EXPIRE = "%s 的靈魂石過期了.";
	FWL.SS_EXPIRE_YOUR = "你給 %s 的靈魂石過期了.";
	FWL.SS_EXPIRE_OTHER = "%s 給 %s 的靈魂石過期了.";
	FWL.SS_DIED = "%s 帶著靈魂石掛了.";
	FWL.SS_DIED_YOUR = "%s 帶著你的靈魂石掛了.";
	FWL.SS_DIED_OTHER = "%s 帶著 %s 的靈魂石掛了.";

	FWL.SHORT_READY = "準備";
	FWL.READY_TO_RES = "可以釋放";
	FWL.NO_SS_UP = "沒有靈魂石";

	FWL.FLAG_SOULSTONE = "<靈魂石>";
	FWL.FLAG_REBIRTH = "<複生>";
	FWL.FLAG_DIVINE_INTERVENTION = "<神聖干涉>";
	FWL.FLAG_ANKH = "<十字章>";

	FWL.DELAY_MAX_SS_BUFF = "靈魂石buff最大延遲";

	FWL.USE_SOULSTONE = "使用靈魂石";
-- ENGLISH
else
	FWL.SOULSTONE_TRACKER = "Soulstone Tracker";
	FWL.SHOW_ALL_ABILITIES = "Show all class abilities (oRA3)";
	FWL.SHOW_ALL_ABILITIES_TT = "When enabled, you will be able to see all class ability cooldowns supported by oRA3.";
	FWL.SHOW_READY = "Show ready abilities";
	FWL.SHOW_READY_TT = "This will set the tracker to not only show abilities on cooldown, but also any abilities that are ready."; 
	FWL.SHOW_SOULSTONE_MESSAGES = "Show soulstone messages";
	FWL.SHOW_SOULSTONE_MESSAGES_TT = "Shows messages for expired soulstones and similar.";
	FWL.SOULSTONE_MESSAGES_COLOR = "Soulstone messages";
	FWL.SS_FULL = "Soulstone full";
	FWL.SS_EMPTY = "Soulstone empty";
	FWL.RESURRECT = "Resurrect";
	FWL.DEAD_OFFLINE_MIXING = "Dead/offline mixing";
	FWL.WARLOCK = "Warlock";
	FWL.DRUID = "Druid";
	FWL.PALADIN = "Paladin";
	FWL.SHAMAN = "Shaman";	
	FWL.DEAD_OFFLINE_MIXING_TT = "The class color is mixed with the dead or offline color with this ratio. 1.0 means the color will be completely class color. 0.0 means the color will be the dead or offline color only.";

	FWL.SS_ENABLE_TT = "Enable the Soulstone Tracker.";

	FWL.DI_GAIN = "%s got Divine Intervention.";
	FWL.DI_FADE = "Divine Intervention faded from %s.";
	FWL.SS_EXPIRE = "Soulstone expired on %s.";
	FWL.SS_EXPIRE_YOUR = "Your Soulstone expired on %s.";
	FWL.SS_EXPIRE_OTHER = "%s's Soulstone expired on %s.";
	FWL.SS_DIED = "%s died with a Soulstone on.";
	FWL.SS_DIED_YOUR = "%s died with your Soulstone on.";
	FWL.SS_DIED_OTHER = "%s died with %s's Soulstone on.";

	FWL.SHORT_READY = "rdy";
	FWL.READY_TO_RES = "ready to res";
	FWL.NO_SS_UP = "no ss up";

	FWL.FLAG_SOULSTONE = "<Soulstone>";
	FWL.FLAG_REBIRTH = "<Rebirth>";
	FWL.FLAG_DIVINE_INTERVENTION = "<Divine Int>";
	FWL.FLAG_ANKH = "<Ankh>";

	FWL.DELAY_MAX_SS_BUFF = "Delay max soulstone buff";
	
	FWL.USE_SOULSTONE = "Use Soulstone";
end