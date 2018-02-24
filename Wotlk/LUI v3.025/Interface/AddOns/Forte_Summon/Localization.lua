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
if GetLocale() == "ruRU" then

	--zones
	FWL.COILFANG_RESERVOIR = "Кривой Клык: Змеиное святилище";

-- FR
elseif GetLocale() == "frFR" then

	--zones
	FWL.COILFANG_RESERVOIR = "Caverne du sanctuaire du Serpent";
	
-- DE 
elseif GetLocale() == "deDE" then

	--zones
	FWL.COILFANG_RESERVOIR = "Höhle des Schlangenschreins";
	
-- SPANISH
elseif GetLocale() == "esES" then

	--zones
	FWL.COILFANG_RESERVOIR = "Caverna Santuario Serpiente";

-- simple chinese
elseif GetLocale() == "zhCN" then

	--zones
	FWL.COILFANG_RESERVOIR = "毒蛇神殿";
	
-- tradition chinese
elseif GetLocale() == "zhTW" then

	--zones
	FWL.COILFANG_RESERVOIR = "毒蛇神殿洞穴";
	
-- ENGLISH
else

	--zones
	FWL.COILFANG_RESERVOIR = "Serpentshrine Cavern";
end

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

if GetLocale() == "ruRU" then

	FWL.CAST_RITUAL_OF_SUMMONING = "Прочитать Ритуал призывания";
	FWL.CAST_RITUAL_OF_SUMMONING_TT = "Прочитать Ритуал призывания, как вы обычно это делаете.";

	FWL.SUMMON_ASSISTANT = "Помощник призывания";
	FWL.SU_HINT1 = "Помощник призывания видим только вне боя и в группе или рейде.";
	FWL.SU_HINT2 = "Щелкните левой кнопкой по имени для выбора/призывания. Щелкните правой кнопкой для удаления на 10 секунд.";

	FWL.SHOW_CLOSE = "Показывать всех дальше 30 м";
	FWL.SHOW_CLOSE_TT = "Когда включено, помощние призывания будет помещать в очередь всех за пределами 30-метрового радиуса. В противном случае, он будет помещать людей за пределами поля зрения в подземелье или на расстоянии примерно в половину зоны снаружи.";
	FWL.QUEUE_SUMMON = "Ключевое слово очереди призывания";
	FWL.QUEUE_SUMMON_TT = "Ключевое слово, которые игроки должны шепнуть для запроса на призывание. Снимите галочку для запрета использования шепота.";
	FWL.SHOW_MEETING_STONE = "Показывать призывание Камнями Встреч";
	FWL.SHOW_MEETING_STONE_TT = "Отслеживание призывов членов рейда Камнями Встреч. Вероятно, лучше держать выключенным, если вы не возле Камня Встреч.";
	FWL.OLD_SUMMONING_MODE = "Старый режим очереди";
	FWL.OLD_SUMMONING_MODE_TT = "Когда включено, люди будут помещаться в очередь как раньше, до разрешения призывания людей в подземелья. То есть, только люди далеко от вас и в вашем подземелье. И люди не в подземелье и далеко, когда вы не находитесь в подземелье.";

	FWL.PLAYER_FAR = "Игрок далеко";
	FWL.PLAYER_CLOSE = "Игрок близко";
	FWL.BEING_SUMMONED = "Вызывается";
	FWL.WHISPERED = "Шепнул";

	FWL.SU_ENABLE_TT = "Включить Помощник призывания.";

	FWL.SUMMON_REQUEST_BLOCK = "^<< Запрос призывания ";
	FWL.SUMMON_REQUEST = "<< Запрос призывания >>";
	FWL.SUMMON_REQUEST_FOR = "<< Запрос призывания для %s >>";
	FWL.SUMMON_REQUEST_BY = "<< Запрос призывания от %s >>";

	FWL.FAR_ = "далеко ";
	FWL._ALL = " все";

	FWL.UPDATE_INTERVAL_SUMMON = "Интервал обновления Помощника призывания";

-- simple chinese
elseif GetLocale() == "zhCN" then

	FWL.CAST_RITUAL_OF_SUMMONING = "施法召唤仪式";
	FWL.CAST_RITUAL_OF_SUMMONING_TT = "就是召唤仪式而已....";

	FWL.SUMMON_ASSISTANT = "召唤助手";
	FWL.SU_HINT1 = "召唤助手仅raid且非战斗时可见.";
	FWL.SU_HINT2 = "左键单击名字选中/召唤. 右键单击移除10秒.";

	FWL.SHOW_CLOSE = "显示30码外所有人";
	FWL.SHOW_CLOSE_TT = "开启此选项,将显示30码外所有队友,否则它将显示半个地图外或可视距离外的队友.";
	FWL.QUEUE_SUMMON = "请求召唤关键词";
	FWL.QUEUE_SUMMON_TT = "队友请求召唤时M你的关键词. 关闭选项将禁用密语.";
	FWL.SHOW_MEETING_STONE = "显示集合石召唤";
	FWL.SHOW_MEETING_STONE_TT = "此选项将监视团队队友的集合石召唤. 你不在集合石附近可以将其关闭.";
	FWL.OLD_SUMMONING_MODE = "旧排队模式";
	FWL.OLD_SUMMONING_MODE_TT = "启用此项，会对召唤人员列队，你将不能将队友召唤进副本。";

	FWL.PLAYER_FAR = "队友远";
	FWL.PLAYER_CLOSE = "队友近";
	FWL.BEING_SUMMONED = "正在被召唤";
	FWL.WHISPERED = "M语请求的";

	FWL.SU_ENABLE_TT = "启用召唤助手.";

--[[by the looks of this, blocking summoning messages will not work properly! ]]
	FWL.SUMMON_REQUEST_BLOCK = "^<< 请求召唤 ";
	FWL.SUMMON_REQUEST = "<< 接受请求 >>";
	FWL.SUMMON_REQUEST_FOR = "<< %s 请求召唤>>";
	FWL.SUMMON_REQUEST_BY = "<< 要求 %s 召唤>>";

	FWL.FAR_ = "远距离 ";
	FWL._ALL = " 全部";

	FWL.UPDATE_INTERVAL_SUMMON = "召唤助手更新间隔";

-- tradition chinese
elseif GetLocale() == "zhTW" then

	FWL.CAST_RITUAL_OF_SUMMONING = "施法召喚儀式";
	FWL.CAST_RITUAL_OF_SUMMONING_TT = "就是召喚儀式而已....";

	FWL.SUMMON_ASSISTANT = "召喚助手";
	FWL.SU_HINT1 = "召喚助手僅raid且非戰鬥時可見.";
	FWL.SU_HINT2 = "左鍵單擊名字選中/召喚. 右鍵單擊移除10秒.";

	FWL.SHOW_CLOSE = "顯示30碼外所有人";
	FWL.SHOW_CLOSE_TT = "開啟此選項,將顯示30碼外所有隊友,否則它將顯示半個地圖外或可視距離外的隊友.";
	FWL.QUEUE_SUMMON = "請求召喚關鍵字";
	FWL.QUEUE_SUMMON_TT = "隊友請求召喚時M你的關鍵字. 關閉選項將禁用密語.";
	FWL.SHOW_MEETING_STONE = "顯示集合石召喚";
	FWL.SHOW_MEETING_STONE_TT = "此選項將監視團隊隊友的集合石召喚. 你不在集合石附近可以將其關閉.";
	FWL.OLD_SUMMONING_MODE = "舊列隊模式";
	FWL.OLD_SUMMONING_MODE_TT = "With this setting enabled, it will queue people as before, when you couldn't summon people from outside into your instance. So only people that are in your instance, and far away. And people not inside an instance when you yourself are not, and far away.";

	FWL.PLAYER_FAR = "隊友遠";
	FWL.PLAYER_CLOSE = "隊友近";
	FWL.BEING_SUMMONED = "正在被召喚";
	FWL.WHISPERED = "M語請求的";

	FWL.SU_ENABLE_TT = "啟用召喚助手.";

--[[by the looks of this, blocking summoning messages will not work properly! ]]
	FWL.SUMMON_REQUEST_BLOCK = "^<< 請求召喚 ";
	FWL.SUMMON_REQUEST = "<< 接受請求 >>";
	FWL.SUMMON_REQUEST_FOR = "<< %s 請求召喚>>";
	FWL.SUMMON_REQUEST_BY = "<< 要求 %s 召喚>>";

	FWL.FAR_ = "遠距離 ";
	FWL._ALL = " 全部";

	FWL.UPDATE_INTERVAL_SUMMON = "召喚助手更新間隔";

else

	FWL.CAST_RITUAL_OF_SUMMONING = "Cast Ritual of Summoning";
	FWL.CAST_RITUAL_OF_SUMMONING_TT = "Cast Ritual of Summoning like you would normally do.";

	FWL.SUMMON_ASSISTANT = "Summon Assistant";
	FWL.SU_HINT1 = "The Summon Assistant is only visible outside of combat and in a party or raid.";
	FWL.SU_HINT2 = "Left-click a name to select/summon. Right-click to remove for 10 seconds.";

	FWL.SHOW_CLOSE = "Show all outside 30 yards";
	FWL.SHOW_CLOSE_TT = "When this is checked, the summon assistant will queue everybody outside ~30 yards range. Otherwise it will queue people that are either out of visual range in an instance, or are about half a zone away outside.";
	FWL.QUEUE_SUMMON = "Summon keyword";
	FWL.QUEUE_SUMMON_TT = "The keyword players can whisper to you to request a summon. Uncheck to disable using whispers.";
	FWL.SHOW_MEETING_STONE = "Show Meeting Stone summons";
	FWL.SHOW_MEETING_STONE_TT = "This will also track meeting stone summons from raid members. Probably best kept off if you're not around a meeting stone.";
	FWL.OLD_SUMMONING_MODE = "Old Queue Mode";
	FWL.OLD_SUMMONING_MODE_TT = "With this setting enabled, it will queue people as before, when you couldn't summon people from outside into your instance. So only people that are in your instance, and far away. And people not inside an instance when you yourself are not, and far away.";

	FWL.PLAYER_FAR = "Player far";
	FWL.PLAYER_CLOSE = "Player close";
	FWL.BEING_SUMMONED = "Being summoned";
	FWL.WHISPERED = "Whispered";

	FWL.SU_ENABLE_TT = "Enable the Summon Assistant.";

	FWL.SUMMON_REQUEST_BLOCK = "^<< Summon Requested ";
	FWL.SUMMON_REQUEST = "<< Summon Requested >>";
	FWL.SUMMON_REQUEST_FOR = "<< Summon Requested for %s >>";
	FWL.SUMMON_REQUEST_BY = "<< Summon Requested by %s >>";

	FWL.FAR_ = "far ";
	FWL._ALL = " all";

	FWL.UPDATE_INTERVAL_SUMMON = "Update interval summon assistant";
end

FWL.SUMMON_PLAYER_ = "Summon player ";