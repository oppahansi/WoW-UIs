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
	--units
	FWL.HELLFIRE_CHANNELER = "Чаротворец из цитадели Адского Пламени";
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "Старший астромант Каперниан";
	FWL.LORD_SANGUINAR = "Лорд Сангвинар";
	FWL.MASTER_ENGINEER_TELONICUS = "Старший инженер Телоникус";
	FWL.THALADRED_THE_DARKENER = "Таладред Затемнитель";
	FWL.FATHOM_GUARD_SHARKKIS = "Хранительница глубин Карибдис";
	FWL.FATHOM_GUARD_CARIBDIS = "Хранительница глубин Карибдис";
	FWL.FATHOM_GUARD_TIDALVESS = "Хранитель глубин Волниис";
	
	--[[>>]]FWL._RELIC = " (Relic)";
	--[[>>]]FWL._EFFECT = " (Effect)";
	
-- FR
elseif GetLocale() == "frFR" then
	--units
	FWL.HELLFIRE_CHANNELER = "Canaliste des Flammes infernales";
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "Grand astromancien Capernian";
	FWL.LORD_SANGUINAR = "Seigneur Sanguinar";
	FWL.MASTER_ENGINEER_TELONICUS = "Maître ingénieur Telonicus";
	FWL.THALADRED_THE_DARKENER = "Thaladred l'Assombrisseur";
	FWL.FATHOM_GUARD_SHARKKIS = "Garde-fonds Squallis";
	FWL.FATHOM_GUARD_CARIBDIS = "Garde-fonds Caribdis";
	FWL.FATHOM_GUARD_TIDALVESS = "Garde-fonds Marevess";
	
	--[[>>]]FWL._RELIC = " (Relic)";
	--[[>>]]FWL._EFFECT = " (Effect)";
	
-- DE
elseif GetLocale() == "deDE" then
	--units
	FWL.HELLFIRE_CHANNELER = "Kanalisierer des Höllenfeuers ";
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "Großastronom Capernian";
	FWL.LORD_SANGUINAR = "Fürst Blutdurst";
	FWL.MASTER_ENGINEER_TELONICUS = "Meisteringenieur Telonicus";
	FWL.THALADRED_THE_DARKENER = "Thaladred der Verfinsterer";
	FWL.FATHOM_GUARD_SHARKKIS = "Tiefenwächter Haikis";
	FWL.FATHOM_GUARD_CARIBDIS = "Tiefenwächter Caribdis";
	FWL.FATHOM_GUARD_TIDALVESS = "Tiefenwächter Flutvess";
	
	--[[>>]]FWL._RELIC = " (Relic)";
	--[[>>]]FWL._EFFECT = " (Effect)";
	
-- SPANISH By Intxixu - SPQR - Tyrande
elseif GetLocale() == "esES" then
	--units
	FWL.HELLFIRE_CHANNELER = "Canalizador Fuego Infernal";
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "Grand Astromancer Capernian";
	FWL.LORD_SANGUINAR = "Lord Sanguinar";
	FWL.MASTER_ENGINEER_TELONICUS = "Maestro ingeniero Telonicus";
	FWL.THALADRED_THE_DARKENER = "Thaladred the Darkener";
	FWL.FATHOM_GUARD_SHARKKIS = "Guardia de las profundidades de Sharkkis";
	FWL.FATHOM_GUARD_CARIBDIS = " Guardia de las profundidades de Caribdis";
	FWL.FATHOM_GUARD_TIDALVESS = " Guardia de las profundidades de Tidalvess";
	
	--[[>>]]FWL._RELIC = " (Relic)";
	--[[>>]]FWL._EFFECT = " (Effect)";

elseif GetLocale() == "zhCN" then
	--units
	FWL.HELLFIRE_CHANNELER = "地狱火导魔者"
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "星术师卡波妮娅";
	FWL.LORD_SANGUINAR = "萨古纳尔男爵"
	FWL.MASTER_ENGINEER_TELONICUS = "首席技师塔隆尼库斯";
	FWL.THALADRED_THE_DARKENER = "亵渎者萨拉德雷";
	FWL.FATHOM_GUARD_SHARKKIS = "深水卫士沙克基斯";
	FWL.FATHOM_GUARD_CARIBDIS = "深水卫士卡莉蒂丝";
	FWL.FATHOM_GUARD_TIDALVESS = "深水卫士泰达维斯";
	
	--[[>>]]FWL._RELIC = " (Relic)";
	--[[>>]]FWL._EFFECT = " (Effect)";

-- tradition Chinese
elseif GetLocale() == "zhTW" then
	--units
	FWL.HELLFIRE_CHANNELER = "地獄火導魔師"
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "大星術師卡普尼恩";
	FWL.LORD_SANGUINAR = "桑古納爾領主"
	FWL.MASTER_ENGINEER_TELONICUS = "工程大師泰隆尼卡斯";
	FWL.THALADRED_THE_DARKENER = "扭曲預言家薩拉瑞德";
	FWL.FATHOM_GUARD_SHARKKIS = "深淵守衛沙卡奇斯";
	FWL.FATHOM_GUARD_CARIBDIS = "深淵守衛卡利迪斯";
	FWL.FATHOM_GUARD_TIDALVESS = "深淵守衛提達費斯";
	
	--[[>>]]FWL._RELIC = " (Relic)";
	--[[>>]]FWL._EFFECT = " (Effect)";

else -- standard english version
	--units
	FWL.HELLFIRE_CHANNELER = "Hellfire Channeler";
	FWL.GRAND_ASTROMANCER_CAPERNIAN = "Grand Astromancer Capernian";
	FWL.LORD_SANGUINAR = "Lord Sanguinar";
	FWL.MASTER_ENGINEER_TELONICUS = "Master Engineer Telonicus";
	FWL.THALADRED_THE_DARKENER = "Thaladred the Darkener";
	FWL.FATHOM_GUARD_SHARKKIS = "Fathom-Guard Sharkkis";
	FWL.FATHOM_GUARD_CARIBDIS = "Fathom-Guard Caribdis";
	FWL.FATHOM_GUARD_TIDALVESS = "Fathom-Guard Tidalvess";
	
	FWL._RELIC = " (Relic)";
	FWL._EFFECT = " (Effect)";
end
	
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

if GetLocale() == "ruRU" then

	FWL.UPDATE_NOW = "Обновить сейчас";
	FWL.LAST_CHECK = "\n\nПоследняя проверка: %d секунд назад.";
	FWL.SCROLL_TO_ = "Прокрутить до ";

	FWL.POTION = "Зелье";
	FWL.POWERUP = "Бонус";
	FWL.ITEM = "Вещь";
	FWL.PET = "Прислужник";
	FWL.SPELL = "Заклинание";
	FWL.HEALTHSTONE_NORMAL = "Камень здоровья";
	FWL.SOULWELL = "Источник душ";

	-- commonly used
	FWL.USE_ = "Использовать %s";
	FWL.CREATE_ = "Создать %s";
	FWL.LEFT_CLICK_TO_CREATE_ = "Щелкните левой кнопкой, чтобы создать %s.";
	FWL.RIGHT_CLICK_TO_USE_ = "Щелкните правой кнопкой, чтобы использовать %s.";

	FWL.MASTER = "Великий";
	FWL.MAJOR = "Крупный";
	FWL.GREATER = "Большой";
	FWL.NORMAL = "Обычный";
	FWL.LESSER = "Малый";
	FWL.MINOR = "Крошечный";

	FWL.FILTER_NONE = "обычный";
	FWL.FILTER_IGNORE = "|cffff0000игнорировать|r";
	FWL.FILTER_COLOR = "|cff00ff00цвет|r";

	FWL.MODULE_NONE = "|cffff0000Нет|r";

	FWL.NOTARGET = "<нет цели>";
	FWL.UNKNOWN = "<Неизвестный>";
	FWL.NOBODY = "<Никто>";

	FWL.NONE = "Нет";

	FWL.ENABLE  = "Включить";
--[[>>]]FWL.LOCK = "Lock (disable dragging)";
	FWL.EXPAND_UP = "Расширять вверх";
	FWL.EXPAND_UP_TT = "Определяет, куда будет расширяться список панелей - вверх или вниз.";
	FWL.BAR_SPACING = "Отступ панелей";
	FWL.COMBAT_HINT = "Некоторые изменения размеров могут быть применены только вне боя.";
	FWL.ORA_HINT = "Для людей без ForteWarlock но с oRA, кто-то с FW должен быть лидеров или ассистентом.";

	FWL.DEAD = "Мертвый";
	FWL.OFFLINE = "Вышел из сети";
	FWL.CASTING = "Читает";
	FWL.CUSTOMIZE = "Настроить";
	FWL.GENERAL = "Основные настройки";
	FWL.ADVANCED = "Дополнительные настройки";
	FWL.BASIC = "Основные";
	FWL.SPECIFIC = "Cпецифичные";
	FWL.CORE = "Ядро";
	FWL.COLORING_FILTERING = "Раскраска/Фильтрация";
	FWL.APPEARANCE = "Внешний вид";
	FWL.SIZING = "Размер";
	FWL.SCALE = "Масштаб";
	FWL.BAR_HEIGHT = "Высота панели";
	FWL.BAR_WIDTH = "Ширина панели";
	FWL.BAR = "Панель";
	FWL.FRAME_BACKGROUND = "Фон окна";
	FWL.BAR_TEXT = "Текст панели";
	FWL.BAR_FONT = "Шрифт панели";
	FWL.BAR_TEXTURE = "Текстура панели";
	FWL.BAR_COLORING = "Цвет панели";
	FWL.AUTO_HIDE = "Автоматически скрывать вне группы/рейда";
	FWL.AUTO_HIDE_TT = "Разрешает автоматическое скрытие окна вне группы или рейда.";
	FWL.AUTO_MINIMIZE = "Автоматически сворачивать вне группы/рейда";
	FWL.AUTO_MINIMIZE_TT = "Разрешает автоматическое сворачивание окна вне группы или рейда.";
	FWL.SHOW_BARS = "Показать панели";
	FWL.SHOW_BARS_TT = "Показать панели. Вы можете скрыть их, если хотить видеть только информацию на заголовке.";
	FWL.MAX_SHOWN = "Отображать максимум";

	FWL.SELF_MESSAGES = "Сообщения себе";
	FWL.SELF_MESSAGES_HINT1 = "Разрешает отображение полезных сообщений для себя. Они показываются в окне чата.";
	FWL.RAID_MESSAGES = "Сообщения группе/рейду";
	FWL.RAID_MESSAGES_HINT1 = "Разрешает отображение сообщений другим в зависимости от заклинаний, которые вы читаете.";
	FWL.RAID_MESSAGES_HINT2 = "Вы можете отключить все сообщения группе/рейду и/или в определенный канал, или каждое сообщение в отдельности.";
	FWL.SHOW_IN_RAID = "Отображать в группе/рейде (первые галочки)";
	FWL.SHOW_IN_RAID_TT = "Снимите галочку для прекращения отправки любых сообщений в группу или рейд.";
	FWL.SHOW_IN_CHANNEL = "Отображать в канале (вторые галочки)";
	FWL.SHOW_IN_CHANNEL_TT = "Укажите имя или номер канала, в котором вы хотите отображать некоторые из ваших сообщений. 'Сказать' также является допустимым. Снимите галочку для прекращения отправки любых сообщений в канал.";

	-- standard usage tips to append
	FWL.USE_FILTER = "Первый тип предмета или заклинания, который вы хотите изменить (автозаполнение). Далее, вы можете выбрать, отображать его обычным образом (Обычный), скрыть его (Игнорировать) или изменить его цвет (Цвет). Если вы хотите изменить цвет, вы получаете диалог выбора цвета по щелчку по квадрату справа.";
	--FWL.USE_COLOR_PICKER = "Щелкните по цветному квадрату для открытия диалога выбора цвета. Ползунок справа позволяет задать прозрачность.";
--[[>>]]FWL.USE_COLOR_PICKER = "Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency. You can also use the editbox to enter a color value in R G B A (red green blue alpha) format. This also allows for easier copying.";
--[[>>]]FWL.USE_COLOR_PICKER2 = "Uncheck to hide completely. Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency. You can also use the editbox to enter a color value in R G B A (red green blue alpha) format. This also allows for easier copying.";

	
	FWL.USE_TEXTURE = "Наведите указатель на левую текстурированную полоску и выберите текстуру из выпадающего меню. Вы также можете использовать любую текстуру, указав путь к ней.";
	FWL.USE_FONT = "Наведите указатель на левую панель со шрифтами и выберите шрифт из выпадающего меню. Центральное поле ввода может быть использовано для изменения размера шрифта. Вы также можете использовать любой другой шрифт, указав путь к нему.";
	FWL.USE_EDITBOX = "Не забудьте нажать Enter для подтверждения изменений в полях ввода!";
	FWL.USE_MSG2 = "Первая галочка разрешит оправку этого сообщений в вашу группу или рейд. Вторая галочка разрешит его отправку в канал указанный выше.";

	--FWL.DEFAULT = "[по умолчанию]";
	--FWL.DEFAULTS = "[по умолчанию]";
	--FWL.POSITION = "[позиция]";
--[[>>]]FWL.DEFAULT = "[restore default]";
--[[>>]]FWL.POSITION = "[reset position]";

	-- all the other text and tips belonging to core itself
	FWL.ADVANCED_HINT1 = "Обычно не требуется изменять что-либо здесь. Этот раздел предназначен только для решения проблем.";
	FWL.ADVANCED_HINT2 = "Изменения в 'Интервалы обновления' будут применены только после перезагрузки.";

	FWL.GENERAL_TIPS = "Некоторые подсказки";
	FWL.GENERAL_TIPS1 = "Нажмите Enter для подтверждения изменений в полях ввода. Esc восстановит их текущие значения.";
	FWL.GENERAL_TIPS2 = "Нажмите на кнопку [по умолчанию] в заголовках для восстановления всех значений по умолчанию в данной категории.";
	FWL.GENERAL_TIPS3 = "Щелчок левой кнопкой по заголовкам окон переключает режимы отображения. Перетаскивание заголовков позволяет перемещать окна.";
	FWL.GENERAL_TIPS4 = "Некоторые настройки цветов также допускают изменения прозрачности. Обычно, это цвета фонов.";

	FWL.GENERAL_MO = "Общие настройки модуля";
	FWL.GENERAL_MO1 = "Щелкните правой кнопкой по заголовку для настройки";
	FWL.GENERAL_MO1_TT = "Вы можете щелкнуть правой кнопкой по заголовку окна для открытия меню настроке в нужной позиции. Работает только для окон, которые не были полностью заблокированы.";
	FWL.GENERAL_MO2 = "Альтернативный формат времени";
	FWL.GENERAL_MO2_TT = "Изменить формат времени из 30м в 29:59.";
	FWL.GENERAL_MO3 = "Разрешить прилипание окон";
	FWL.GENERAL_MO3_TT = "Модульные окна будут располагаться возле границ друг друга при перетаскивании.";
	FWL.GENERAL_MO4 = "Расстояние прилипания окон";
	FWL.GENERAL_MO4_TT = "Расстояние, на котором должны быть окна друг от друга, для прилипания.";
	FWL.GENERAL_MO5 = "Расстояние между окнами";
	FWL.GENERAL_MO5_TT = "Расстояние между окнами, когда они прилипли.";

	FWL.GENERAL_MA = "Обший вид модуля";
	FWL.GENERAL_MA1_TT = "Изменить шрифт панелей для ВСЕХ окон.";
	FWL.GENERAL_MA2_TT = "Изменить текстуру панелей для ВСЕХ окон.";

	FWL.GENERAL_OA = "Вид настроек";
	FWL.GENERAL_OA1 = "Цвет заголовка";
	FWL.GENERAL_OA1_TT = "Изменить цвет заголовка для окна настроек.";
	FWL.GENERAL_OA2 = "Цвет фона";
	FWL.GENERAL_OA2_TT = "Изменить цвет фона окна настроек.";
	FWL.GENERAL_OA3 = "Заголовки";
	FWL.GENERAL_OA3_TT = "Изменить шрифт заголовков окна настроек.";
	FWL.GENERAL_OA4 = "Настройки";
	FWL.GENERAL_OA4_TT = "Изменить шрифт окна настроек.";

	FWL.PROFILES = "Профили";
	FWL.PROFILES_CURRENT = "Текущий профиль";
	FWL.PROFILES_CURRENT_TT = "Выберите профиль для использования. [удалить текущий] удаляет профиль, который сейчас используется (выбран). [создать новый] копирует ваши текущие настройки в новый профиль, имя, которго вы указали, или заменяет его.";

	FWL.LOADING_DELAY = "Задержка загрузки";
	FWL.UPDATE_INTERVAL_CORE = "Интервал обновления ядра";
	FWL.UPDATE_INTERVAL_ANIMATIONS = "Интервал обновления анимаций";
	FWL.CHILL_SPEED = "Скорость остывания";
--[[>>]]FWL.ANIMATE_SCROLL = "Animate auto-scrolling";
--[[>>]]FWL.ANIMATE_SCROLL_TT = "Animates the scrolling and showing of the options. This may give you a better feeling of 'where you are' in the options menu (and it looks kinda cool).";

--[[>>]]FWL.OPTIONS_SCALE = "Options scale";
--[[>>]]FWL.OPTIONS_SCALE_TT = "Change the scale of the Options frame";
--[[>>]]FWL.TOGGLE_OPTIONS = "Toggle Options";
--[[>>]]FWL.OPTIONS_COLUMNS = "Option Columns";
--[[>>]]FWL.OPTIONS_COLUMNS_TT = "Change the number of columns of the options frame.";
--[[>>]]FWL.OPTIONS_HEIGHT = "Option Height";
--[[>>]]FWL.OPTIONS_HEIGHT_TT = "Change the height of the options frame.";
--[[>>]]FWL.BLOCK_SHARDS = "Safely block shard reagents";
--[[>>]]FWL.BLOCK_SHARDS_TT = "Hides the shard count on your action buttons. Requires a reload of your interface to apply. Currently supported: Bartender4 and Standard UI.";

--[[>>]]FWL.GLOBAL_LOCK = "Global Frame Lock";
--[[>>]]FWL.GLOBAL_LOCK_TT = "Lock all the frames belonging to the addon. Some frames may have their own locking option though.";

--[[>>]]FWL.SOUND = "Sound";
--[[>>]]FWL.SOUND_HINT1 = "Click the little trumpet icons to hear the sounds. Use the second editbox to adjust the volume.";
--[[>>]]FWL.RANGE_MAX = "Range: %s to %s";
--[[>>]]FWL.RANGE_MIN = "Range: %s and higher";
--[[>>]]FWL.CREATE_PROFILE = "[create new profile]";
--[[>>]]FWL.DELETE_PROFILE = "[delete active profile]";
--[[>>]]FWL.CLICK_TO_EDIT = "[click to edit]";
--[[>>]]FWL.CLICK_TO_EDIT_TT = "Press ENTER to confirm your change. Press ESC to discard your change.";
--[[>>]]FWL.CLICK_TO_COPY = "[click to select, Ctrl+C to copy]";

--[[>>]]FWL.DEMONIC = "Demonic";
--[[>>]]FWL.FEL = "Fel";

--[[>>]]FWL.SPARK_MATCH = "Spark matches bar";
--[[>>]]FWL.SPARK_MATCH_TT = "The color of the sparks will match the color of the bars.";
--[[>>]]FWL.SPARK_COLOR = "Spark color";
--[[>>]]FWL.SPARK_COLOR_TT = "Set the spark colors to any color you like. You can also use this to hide the sparks by choosing an alpha of 0.";

	FWL.FADING = "Угасать";
--[[>>]]FWL.TIME_LEFT_HINT = "Announce fade time for your spells by left-clicking a Timer icon.";	
--[[>>]]FWL.TIME_LEFT_NOTARGET = "Announce fade time (no target)";

--[[>>]]FWL.PROFILES_HINT1 = "The AddOn saved what profile you were using on this character last time.";
--[[>>]]FWL.PROFILES_HINT2 = "This makes it easy to share profiles among different characters.";

--[[>>]]FWL.GENERAL_MO6 = "Right-click icons to customize";
--[[>>]]FWL.GENERAL_MO6_TT = "You can right-click the icons in some modules to open the options menu at the right customization filter.";

--[[>>]]FWL.FILTER_NORMAL = "|cffffff00show|r";
--[[>>]]FWL.FILTER_ALWAYS = "|cffff8000always|r";	

	FWL.UNLOCK = "Unlock (enable dragging)";
	FWL.UNLOCK_TT = "This module's frame is Locked. Click to Unlock this frame, so it can be dragged around.";
	FWL.LOCK_TT = "This module's frame is Unlocked. Click to Lock this frame, so it can no longer be dragged around.";

	FWL.DEFAULT_ALL = "[restore all defaults]";
	FWL.DEFAULT_ALL_TT = "Click to restore the defaults of all the options in this category. Be careful, it cannot be undone!";
	FWL.DEFAULT_TT = "Click to restore the default of this option.";

	FWL.DEFAULT_FRAME = "[restore frame defaults]";
	FWL.DEFAULT_FRAME_TT = "Click to restore the frame properties of this module.";

	FWL.POSITION_TT = "Click to reset this module's frame position.";

	FWL.MODULE_COLORS = "Use Module Colors";
	FWL.MODULE_COLORS_TT = "Each of the option frames gets its own color. His should help not to edit the wrong module by accident. These colors are mixed with the option header color, so you can still influence their appearance a little.";

	FWL.GLOBAL_ALPHA = "Global Frame Alpha";
	FWL.GLOBAL_ALPHA_TT = "Set the visibility of all frames belonging to the addon to this value.";
	FWL.ALPHA = "[restore alpha]";
	FWL.ALPHA_TT = "Click to reset the transparency of this frame to its default.";

	FWL.RESTORE_SCALE = "[restore scale]";
	FWL.RESTORE_SCALE_TT = "Click to reset the scale of this frame to its default.";

	FWL.TIPS = "Show module frame Tooltips";
	FWL.TIPS_TT = "Show any non-option Tooltips. For example the Tooltips on timer icons, module bars and integrated cast buttons.";

	FWL.FILTER_ALL = "all";
	FWL.FILTER_OTHERS = "|cFF00BFFFbuff|r |cFF005BFFdebuff|r";
	FWL.FILTER_MINE = "|cFFFFCC00mine|r";
	FWL.FILTER_BUFF = "|cFF00BBFFbuff";
	FWL.FILTER_BUFF_DEBUFF = "|cFFAACCFFbuff|r |cFFFF0000debuff|r";
	FWL.FILTER_DEBUFF = "|cFFFF0000debuff";
	FWL.FILTER_OTHER = "|cFFFFCC00all other|r";
	FWL.FILTER_COOLDOWNS = "|cFFFF6359cooldowns|r";
	FWL.FILTER_SHOW_COLOR = FWL.FILTER_COLOR.." "..FWL.FILTER_NORMAL;

	FWL.TOGGLE_FILTER_LIST = "Toggle Filter List";
	FWL.BACKDROP = "Backdrop";

	FW:SetDefaultFont("Fonts\\ARIALN.TTF",11);

elseif GetLocale() == "zhCN" then

	FWL.UPDATE_NOW = "刷新";
	FWL.LAST_CHECK = "\n\n上次扫描: %d 秒之前.";
	FWL.SCROLL_TO_ = "移动到 ";

	FWL.POTION = "药水";
	FWL.POWERUP = "增强BUFF";
	FWL.ITEM = "物品";
	FWL.PET = "Pet";
	FWL.SPELL = "法术";
	FWL.HEALTHSTONE_NORMAL = "治疗石";
	FWL.SOULWELL = "灵魂井";

	-- commonly used
	FWL.USE_ = "使用 %s";
	FWL.CREATE_ = "制作 %s";
	FWL.LEFT_CLICK_TO_CREATE_ = "左键点击制作 %s.";
	FWL.RIGHT_CLICK_TO_USE_ = "右键点击使用 %s.";

	FWL.MASTER = "极效糖";
	FWL.MAJOR = "特效糖";
	FWL.GREATER = "强效糖";
	FWL.NORMAL = "普通糖";
	FWL.LESSER = "次级糖";
	FWL.MINOR = "初级糖";

	FWL.FILTER_NONE = "恢复";
	FWL.FILTER_IGNORE = "|cffff0000屏蔽|r";
	FWL.FILTER_COLOR = "|cff00ff00颜色|r";

	FWL.MODULE_NONE = "|cffff0000无|r";

	FWL.NOTARGET = "<没有目标>";
	FWL.UNKNOWN = "<未知>";
	FWL.NOBODY = "<无人>"

	FWL.NONE = "None";

	FWL.ENABLE  = "启动";
	FWL.LOCK = "锁定 (拖动不能)";
	FWL.EXPAND_UP = "向上扩展";
	FWL.EXPAND_UP_TT = "设置计时条向上/下扩展.";
	FWL.BAR_SPACING = "间距"
	FWL.COMBAT_HINT = "大小设置只在非战斗状态下有效.";
	FWL.ORA_HINT = "很多同志没有装FW,但是装了oRA,装了FW的同志需要取得团队权限(L或A)";

	FWL.DEAD = "挂了";
	FWL.OFFLINE = "掉线";
	FWL.CASTING = "施法";
	FWL.CUSTOMIZE = "自定义";
	FWL.GENERAL = "综合选项";
	FWL.ADVANCED = "高级选项";
	FWL.BASIC = "基本选项";
	FWL.SPECIFIC = "特殊选项";
	FWL.CORE = "核心选项";
	FWL.COLORING_FILTERING = "颜色/过滤";
	FWL.APPEARANCE = "外观";
	FWL.SIZING = "尺寸";
	FWL.SCALE = "缩放";
	FWL.BAR_HEIGHT = "高度";
	FWL.BAR_WIDTH = "宽度";
	FWL.BAR = "Bar";
	FWL.FRAME_BACKGROUND = "框体背景";
	FWL.BAR_TEXT = "文字";
	FWL.BAR_FONT = "字体";
	FWL.BAR_TEXTURE = "材质";
	FWL.BAR_COLORING = "颜色";
	FWL.AUTO_HIDE = "非组队/团队隐藏";
	FWL.AUTO_HIDE_TT = "当不在小队或者团队中自动隐藏";
	FWL.AUTO_MINIMIZE = "非组队/团队最小化";
	FWL.AUTO_MINIMIZE_TT = "当不在小队/团队中,自动隐藏计时条.";
	FWL.SHOW_BARS = "显示计时条";
	FWL.SHOW_BARS_TT = "显示计时条. 如果你只需要从标题栏看见相关信息,可以将计时条隐藏.";
	FWL.MAX_SHOWN = "最大显示数";

	FWL.SELF_MESSAGES = "个人信息";
	FWL.SELF_MESSAGES_HINT1 = "此功能能在聊天窗口向你显示一些有用的信息,此信息只有你能看见."
	FWL.RAID_MESSAGES = "小队/团队信息";
	FWL.RAID_MESSAGES_HINT1 = "此功能向你的队友显示一些关于你施放的法术的信息.";
	FWL.RAID_MESSAGES_HINT2 = "你可以逐条或者全部禁止信息在任何频道对你的队友显示.";
	FWL.SHOW_IN_RAID = "小队/团队频道 (第一个选项)";
	FWL.SHOW_IN_RAID_TT = "关闭此项将会禁止所有信息对你的队友显示.";
	FWL.SHOW_IN_CHANNEL = "在定义频道显示 (第二个选项)";
	FWL.SHOW_IN_CHANNEL_TT = "设定显示信息的频道名字或者序号. 支持'说'(白字). 关闭此项将禁止所有信息在此频道显示.";

	-- standard usage tips to append
	FWL.USE_FILTER = "首先键入你想过滤的法术或者物品 (auto-fills). 然后你可以选择设置正常显示 (normal选项), 隐藏不显示 (ignore选项) 或改变其颜色 (custom选项). 选择第三项后右边会出现颜色设置按钮.";
	FWL.USE_COLOR_PICKER = "点颜色打开调色板，右侧滑条调整透明度，可以直接在下方输入RGBA数值.";
	FWL.USE_COLOR_PICKER2 = "取消.";
	
	FWL.USE_TEXTURE = "鼠标划过材质条可以在出现菜单中选择材质. 输入材质路径可以设置为其他材质."
	FWL.USE_FONT = "鼠标划过字体框可以在出现菜单中选择字体.中间的编辑框可以设定字体大小.输入字体路径可以设置为其他字体.";
	FWL.USE_EDITBOX = "改变后需要按'回车'键确认更改!!!";
	FWL.USE_MSG2 = "第一个选项向你队友显示信息. 第二个选项在你上面设定的频道中显示信息.";

	FWL.DEFAULT = "[恢复默认]";
	FWL.POSITION = "[位置重置]";

	-- all the other text and tips belonging to core itself
	FWL.ADVANCED_HINT1 = "没事/不懂的话,这里的东西不要改变. 这部分是调整整个插件的."
	FWL.ADVANCED_HINT2 = "'更新间隔'选项改变后,必须重载插件才有效.";

	FWL.GENERAL_TIPS = "提示";
	FWL.GENERAL_TIPS1 = "注意!!编辑框中按回车确认更改,按ESC取消更改.";
	FWL.GENERAL_TIPS2 = "按顶部的[default]按钮,恢复到默认设置.";
	FWL.GENERAL_TIPS3 = "单击框体标题栏切换显示模式. 拖拽移动框体.";
	FWL.GENERAL_TIPS4 = "颜色选项支持调整透明度,一般是背景颜色才有.";

	FWL.GENERAL_MO = "综合模块选项";
	FWL.GENERAL_MO1 = "右击标题栏设置框体";
	FWL.GENERAL_MO1_TT = "在框体标题栏右键点击可以在右侧显示设置框体. 框体锁定时无效.";
	FWL.GENERAL_MO2 = "改变时间显示格式";
	FWL.GENERAL_MO2_TT = "将时间格式从30m变成29:59.";
	FWL.GENERAL_MO3 = "自动对齐";
	FWL.GENERAL_MO3_TT = "各模块框体在拖拽到一起时自动对齐.";
	FWL.GENERAL_MO4 = "自动对齐距离";
	FWL.GENERAL_MO4_TT = "自动对齐生效的最大距离.";
	FWL.GENERAL_MO5 = "框体间距";
	FWL.GENERAL_MO5_TT = "框体对齐后之间保持的距离.";

	FWL.GENERAL_MA = "综合模块显示";
	FWL.GENERAL_MA1_TT = "改变所有模块字体.";
	FWL.GENERAL_MA2_TT = "改变所有模块材质.";

	FWL.GENERAL_OA = "选项显示";
	FWL.GENERAL_OA1 = "标题栏颜色";
	FWL.GENERAL_OA1_TT = "改变选项框体标题栏颜色.";
	FWL.GENERAL_OA2 = "背景颜色";
	FWL.GENERAL_OA2_TT = "改变选项框体背景颜色.";
	FWL.GENERAL_OA3 = "标题栏字体";
	FWL.GENERAL_OA3_TT = "设定选项窗口标题栏字体.";
	FWL.GENERAL_OA4 = "选项字体";
	FWL.GENERAL_OA4_TT = "设定选项字体.";

	FWL.PROFILES = "保存设置";
	FWL.PROFILES_CURRENT = "当前设置文件";
	FWL.PROFILES_CURRENT_TT = "选择设置文件. [delete current] 删除当前设置 (选中).[create new] 将当前设置保存为输入的设置名.";

	FWL.LOADING_DELAY = "正在读入";
	FWL.UPDATE_INTERVAL_CORE = "更新间隔核心";
	FWL.UPDATE_INTERVAL_ANIMATIONS = "更新动画间隔";
	FWL.CHILL_SPEED = "冷冻减速chill speed";
	FWL.ANIMATE_SCROLL = "动画自动卷动";
	FWL.ANIMATE_SCROLL_TT = "设置窗口卷动显示动画效果（好看，Cool）.";

	FWL.OPTIONS_SCALE = "设置窗口缩放";
	FWL.OPTIONS_SCALE_TT = "改变设置窗口大小";
	FWL.TOGGLE_OPTIONS = "切换选项";
	FWL.OPTIONS_COLUMNS = "选项栏目";
	FWL.OPTIONS_COLUMNS_TT = "改变选项窗口栏目数.";
	FWL.OPTIONS_HEIGHT = "窗口高度";
	FWL.OPTIONS_HEIGHT_TT = "改变设置窗口高度.";
	FWL.BLOCK_SHARDS = "隐藏碎片计数";
	FWL.BLOCK_SHARDS_TT = "隐藏动作条上的碎片计数，需要重载UI，当前支持Bartender4.";

	FWL.GLOBAL_LOCK = "锁定全部窗口";
	FWL.GLOBAL_LOCK_TT = "锁定这个插件的全部窗口，有的窗口可以单独锁定和解锁.";
	
	FWL.SOUND = "声音";

	FWL.SOUND_HINT1 = "点击小号图标测试声音，下面的编辑框可以调整音量.";
	FWL.RANGE_MAX = "音量: %s 到 %s";
	FWL.RANGE_MIN = "音量: %s 或更高";
	FWL.CREATE_PROFILE = "[创建新的存档]";
	FWL.DELETE_PROFILE = "[删除当前存档]";
	FWL.CLICK_TO_EDIT = "[点击编辑]";
--[[>>]]FWL.CLICK_TO_EDIT_TT = "Press ENTER to confirm your change. Press ESC to discard your change.";
	FWL.CLICK_TO_COPY = "[点击选中, Ctrl+C 拷贝]";

	FWL.DEMONIC = "恶魔";
	FWL.FEL = "魔能";	
	
	FWL.SPARK_MATCH = "bar颜色闪动";
	FWL.SPARK_MATCH_TT = "闪光的颜色与bar颜色一样.";
	FWL.SPARK_COLOR = "闪光颜色";
	FWL.SPARK_COLOR_TT = "设定闪光颜色，将alpha设为0可以隐藏闪光.";
	
	FWL.FADING = "渐隐";
	FWL.TIME_LEFT_HINT = "点击法术图标显示法术剩余时间.";	
	FWL.TIME_LEFT_NOTARGET = "显示法术剩余时间 (非目标)";

	FWL.PROFILES_HINT1 = "保存你此人物最新的设置文件";
	FWL.PROFILES_HINT2 = "方便人物之间的设置共享.";

	FWL.GENERAL_MO6 = "右击编辑图标"; 
	FWL.GENERAL_MO6_TT = "一些框体下你可以右击图标编辑过滤";

	FWL.FILTER_NORMAL = "|cffffff00显示|r";
	FWL.FILTER_ALWAYS = "|cffff8000保持|r";	
	
	FWL.UNLOCK = "解锁 (拖动可以)";
	FWL.UNLOCK_TT = "窗口锁定，点击解锁可以拖动.";
	FWL.LOCK_TT = "窗口未锁，点击锁定无法拖动.";

	FWL.DEFAULT_ALL = "[重置设定]";
	FWL.DEFAULT_ALL_TT = "设置全部变成初始设定，无法恢复!";
	FWL.DEFAULT_TT = "重置该选项设置.";

	FWL.DEFAULT_FRAME = "[重置窗口设定]";
	FWL.DEFAULT_FRAME_TT = "该窗口设置恢复为原始状态.";

	FWL.POSITION_TT = "点击重置该状况位置.";

	FWL.MODULE_COLORS = "应用模块颜色";
	FWL.MODULE_COLORS_TT = "每个选项窗口都有个性颜色，帮助你不会搞错设置窗口.";

	FWL.GLOBAL_ALPHA = "全局窗口透明度";
	FWL.GLOBAL_ALPHA_TT = "设置ForteXorcist全部窗口的透明度";
	FWL.ALPHA = "[重置透明度]";
	FWL.ALPHA_TT = "恢复窗口原始透明度.";

	FWL.RESTORE_SCALE = "[重置大小]";
	FWL.RESTORE_SCALE_TT = "重置窗口原始大小.";

	FWL.TIPS = "显示模块窗口鼠标提示Show module frame Tooltips";
	FWL.TIPS_TT = "为非选项显示鼠标提示，比如时间图标、模块bar、操作按钮.";

	FWL.FILTER_ALL = "全部";
	FWL.FILTER_OTHERS = "|cFF00BFFFbuff|r |cFF005BFFdebuff|r";
--[[>>]]FWL.FILTER_MINE = "|cFFFFCC00玩家|r";
	FWL.FILTER_BUFF = "|cFF00BBFFbuff";
	FWL.FILTER_BUFF_DEBUFF = "|cFFAACCFFbuff|r |cFFFF0000debuff|r";
	FWL.FILTER_DEBUFF = "|cFFFF0000debuff";
	FWL.FILTER_OTHER = "|cFFFFCC00其他人|r";
	FWL.FILTER_COOLDOWNS = "|cFFFF6359冷却|r";
	FWL.FILTER_SHOW_COLOR = FWL.FILTER_COLOR.." "..FWL.FILTER_NORMAL;

	FWL.TOGGLE_FILTER_LIST = "过滤表开关";
	FWL.BACKDROP = "背景";	
	
	-- register extra fonts
	FW:RegisterFont("Fonts\\ZYHei.TTF","中易黑");
	FW:RegisterFont("Fonts\\ZYKai_T.TTF","中易楷");
	FW:SetDefaultFont("Fonts\\ZYHei.TTF",11);
	
elseif GetLocale() == "zhTW" then

	FWL.UPDATE_NOW = "刷新";
	FWL.LAST_CHECK = "\n\n上次掃描: %d 秒之前.";
	FWL.SCROLL_TO_ = "移動到 ";

	FWL.POTION = "藥水";
	FWL.POWERUP = "增強BUFF";
	FWL.ITEM = "物品";
	FWL.PET = "Pet";
	FWL.SPELL = "法術";
	FWL.HEALTHSTONE_NORMAL = "治療石";
	FWL.SOULWELL = "靈魂井";

	-- commonly used
	FWL.USE_ = "使用 %s";
	FWL.CREATE_ = "製作 %s";
	FWL.LEFT_CLICK_TO_CREATE_ = "左鍵點擊製作 %s.";
	FWL.RIGHT_CLICK_TO_USE_ = "右鍵點擊使用 %s.";

	FWL.MASTER = "極強效糖";
	FWL.MAJOR = "特效糖";
	FWL.GREATER = "強效糖";
	FWL.NORMAL = "普通糖";
	FWL.LESSER = "次級糖";
	FWL.MINOR = "初級糖";

	FWL.FILTER_NONE = "恢復";
	FWL.FILTER_IGNORE = "|cffff0000遮罩|r";
	FWL.FILTER_COLOR = "|cff00ff00顏色|r";

	FWL.MODULE_NONE = "|cffff0000無|r";

	FWL.NOTARGET = "<沒有目標>";
	FWL.UNKNOWN = "<未知>";
	FWL.NOBODY = "<無人>"

	FWL.NONE = "None";

	FWL.ENABLE  = "啟動";
	FWL.LOCK = "鎖定 (拖動不能)";
	FWL.EXPAND_UP = "向上擴展";
	FWL.EXPAND_UP_TT = "設置計時條向上/下擴展.";
	FWL.BAR_SPACING = "間距"
	FWL.COMBAT_HINT = "大小設置只在非戰鬥狀態下有效.";
	FWL.ORA_HINT = "很多同志沒有裝FW,但是裝了oRA,裝了FW的同志需要取得團隊許可權(L或A)";

	FWL.DEAD = "掛了";
	FWL.OFFLINE = "掉線";
	FWL.CASTING = "施法";
	FWL.CUSTOMIZE = "自定義";
	FWL.GENERAL = "綜合選項";
	FWL.ADVANCED = "高級選項";
	FWL.BASIC = "基本選項";
	FWL.SPECIFIC = "特殊選項";
	FWL.CORE = "核心選項";
	FWL.COLORING_FILTERING = "顏色/過濾";
	FWL.APPEARANCE = "外觀";
	FWL.SIZING = "尺寸";
	FWL.SCALE = "縮放";
	FWL.BAR_HEIGHT = "高度";
	FWL.BAR_WIDTH = "寬度";
	FWL.BAR = "Bar";
	FWL.FRAME_BACKGROUND = "框體背景";
	FWL.BAR_TEXT = "文字";
	FWL.BAR_FONT = "字體";
	FWL.BAR_TEXTURE = "材質";
	FWL.BAR_COLORING = "顏色";
	FWL.AUTO_HIDE = "非組隊/團隊隱藏";
	FWL.AUTO_HIDE_TT = "當不在小隊或者團隊中自動隱藏";
	FWL.AUTO_MINIMIZE = "非組隊/團隊最小化";
	FWL.AUTO_MINIMIZE_TT = "當不在小隊/團隊中,自動隱藏計時條.";
	FWL.SHOW_BARS = "顯示計時條";
	FWL.SHOW_BARS_TT = "顯示計時條. 如果你只需要從標題欄看見相關資訊,可以將計時條隱藏.";
	FWL.MAX_SHOWN = "最大顯示數";

	FWL.SELF_MESSAGES = "個人資訊";
	FWL.SELF_MESSAGES_HINT1 = "此功能能在聊天視窗向你顯示一些有用的資訊,此資訊只有你能看見."
	FWL.RAID_MESSAGES = "小隊/團隊信息";
	FWL.RAID_MESSAGES_HINT1 = "此功能向你的隊友顯示一些關於你施放的法術的資訊.";
	FWL.RAID_MESSAGES_HINT2 = "你可以逐條或者全部禁止資訊在任何頻道對你的隊友顯示.";
	FWL.SHOW_IN_RAID = "小隊/團隊頻道 (第一個選項)";
	FWL.SHOW_IN_RAID_TT = "關閉此項將會禁止所有資訊對你的隊友顯示.";
	FWL.SHOW_IN_CHANNEL = "在定義頻道顯示 (第二個選項)";
	FWL.SHOW_IN_CHANNEL_TT = "設定顯示資訊的頻道名字或者序號. 支持'說'(白字). 關閉此項將禁止所有資訊在此頻道顯示.";

	-- standard usage tips to append
	FWL.USE_FILTER = "首先鍵入你想過濾的法術或者物品 (auto-fills). 然後你可以選擇設置正常顯示 (normal選項), 隱藏不顯示 (ignore選項) 或改變其顏色 (custom選項). 選擇第三項後右邊會出現顏色設置按鈕.";
	FWL.USE_COLOR_PICKER = "點顏色打開調色板，右側滑條調整透明度，可以直接在下方輸入RGBA數值.";
	FWL.USE_COLOR_PICKER2 = "取消.";

	FWL.USE_TEXTURE = "滑鼠劃過材質條可以在出現功能表中選擇材質. 輸入材質路徑可以設置為其他材質."
	FWL.USE_FONT = "滑鼠劃過字體框可以在出現功能表中選擇字體.中間的編輯框可以設定字體大小.輸入字體路徑可以設置為其他字體.";
	FWL.USE_EDITBOX = "改變後需要按'回車'鍵確認更改!!!";
	FWL.USE_MSG2 = "第一個選項向你隊友顯示資訊. 第二個選項在你上面設定的頻道中顯示資訊.";

	FWL.DEFAULT = "[恢復默認]";
	FWL.POSITION = "[位置重置]";

	-- all the other text and tips belonging to core itself
	FWL.ADVANCED_HINT1 = "沒事/不懂的話,這裏的東西不要改變. 這部分是調整整個插件的."
	FWL.ADVANCED_HINT2 = "'更新間隔'選項改變後,必須重載插件才有效.";

	FWL.GENERAL_TIPS = "提示";
	FWL.GENERAL_TIPS1 = "注意!!編輯框中按回車確認更改,按ESC取消更改.";
	FWL.GENERAL_TIPS2 = "按頂部的[default]按鈕,恢復到默認設置.";
	FWL.GENERAL_TIPS3 = "單擊框體標題欄切換顯示模式. 拖拽移動框體.";
	FWL.GENERAL_TIPS4 = "顏色選項支援調整透明度,一般是背景顏色才有.";

	FWL.GENERAL_MO = "綜合模組選項";
	FWL.GENERAL_MO1 = "右擊標題欄設置框體";
	FWL.GENERAL_MO1_TT = "在框體標題欄右鍵點擊可以在右側顯示設置框體. 框體鎖定時無效.";
	FWL.GENERAL_MO2 = "改變時間顯示格式";
	FWL.GENERAL_MO2_TT = "將時間格式從30m變成29:59.";
	FWL.GENERAL_MO3 = "自動對齊";
	FWL.GENERAL_MO3_TT = "各模組框體在拖拽到一起時自動對齊.";
	FWL.GENERAL_MO4 = "自動對齊距離";
	FWL.GENERAL_MO4_TT = "自動對齊生效的最大距離.";
	FWL.GENERAL_MO5 = "框體間距";
	FWL.GENERAL_MO5_TT = "框體對齊後之間保持的距離.";

	FWL.GENERAL_MA = "綜合模組顯示";
	FWL.GENERAL_MA1_TT = "改變所有模組字體.";
	FWL.GENERAL_MA2_TT = "改變所有模組材質.";

	FWL.GENERAL_OA = "選項顯示";
	FWL.GENERAL_OA1 = "標題欄顏色";
	FWL.GENERAL_OA1_TT = "改變選項框體標題欄顏色.";
	FWL.GENERAL_OA2 = "背景顏色";
	FWL.GENERAL_OA2_TT = "改變選項框體背景顏色.";
	FWL.GENERAL_OA3 = "標題欄字體";
	FWL.GENERAL_OA3_TT = "設定選項視窗標題欄字體.";
	FWL.GENERAL_OA4 = "選項字體";
	FWL.GENERAL_OA4_TT = "設定選項字體.";

	FWL.PROFILES = "保存設置";
	FWL.PROFILES_CURRENT = "當前設置文件";
	FWL.PROFILES_CURRENT_TT = "選擇設置檔. [delete current] 刪除當前設置 (選中).[create new] 將當前設置保存為輸入的設置名.";

	FWL.LOADING_DELAY = "正在讀入";
	FWL.UPDATE_INTERVAL_CORE = "更新間隔核心";
	FWL.UPDATE_INTERVAL_ANIMATIONS = "更新動畫間隔";
	FWL.CHILL_SPEED = "冷凍減速Chill speed";
	FWL.ANIMATE_SCROLL = "動畫自動捲動";
	FWL.ANIMATE_SCROLL_TT = "設置視窗捲動顯示動畫效果（好看，Cool）.";

	FWL.OPTIONS_SCALE = "設置視窗縮放";
	FWL.OPTIONS_SCALE_TT = "改變設置視窗大小";
	FWL.TOGGLE_OPTIONS = "切換選項";
	FWL.OPTIONS_COLUMNS = "選項欄目";
	FWL.OPTIONS_COLUMNS_TT = "改變選項視窗欄目數.";
	FWL.OPTIONS_HEIGHT = "窗口高度";
	FWL.OPTIONS_HEIGHT_TT = "改變設置視窗高度.";
	FWL.BLOCK_SHARDS = "隱藏碎片計數";
	FWL.BLOCK_SHARDS_TT = "隱藏動作條上的碎片計數，需要重載UI，當前支援Bartender4.";

	FWL.GLOBAL_LOCK = "鎖定全部視窗";
	FWL.GLOBAL_LOCK_TT = "鎖定這個外掛程式的全部視窗，有的視窗可以單獨鎖定和解鎖.";

	FWL.SOUND = "聲音";

	FWL.SOUND_HINT1 = "點擊小號圖示測試聲音，下面的編輯方塊可以調整音量.";
	FWL.RANGE_MAX = "音量: %s 到 %s";
	FWL.RANGE_MIN = "音量: %s 或更高";
	FWL.CREATE_PROFILE = "[創建新的存檔]";
	FWL.DELETE_PROFILE = "[刪除當前存檔]";
	FWL.CLICK_TO_EDIT = "[點擊編輯]";
--[[>>]]FWL.CLICK_TO_EDIT_TT = "Press ENTER to confirm your change. Press ESC to discard your change.";
	FWL.CLICK_TO_COPY = "[點擊選中, Ctrl+C 拷貝]";
	
	FWL.DEMONIC = "惡魔";
	FWL.FEL = "魔能";
	
	FWL.SPARK_MATCH = "bar顏色閃動";
	FWL.SPARK_MATCH_TT = "閃光的顏色與bar顏色一樣.";
	FWL.SPARK_COLOR = "閃光顏色";
	FWL.SPARK_COLOR_TT = "設定閃光顏色，將alpha設為0可以隱藏閃光.";
	
	FWL.FADING = "漸隱";
	FWL.TIME_LEFT_HINT = "點擊法術圖示顯示法術剩餘時間.";	
	FWL.TIME_LEFT_NOTARGET = "顯示法術剩餘時間 (非目標)";
	
	FWL.PROFILES_HINT1 = "保存你此人物最新的設置檔";
	FWL.PROFILES_HINT2 = "方便人物之間的設置共用.";

	FWL.GENERAL_MO6 = "右擊編輯圖示"; 
	FWL.GENERAL_MO6_TT = "一些框體下你可以右擊圖示編輯過濾";

	FWL.FILTER_NORMAL = "|cffffff00顯示|r";
	FWL.FILTER_ALWAYS = "|cffff8000保持|r";	

	FWL.UNLOCK = "解鎖 (拖動可以)";
	FWL.UNLOCK_TT = "視窗鎖定，點擊解鎖可以拖動.";
	FWL.LOCK_TT = "窗口未鎖，點擊鎖定無法拖動.";

	FWL.DEFAULT_ALL = "[重置設定]";
	FWL.DEFAULT_ALL_TT = "設置全部變成初始設定，無法恢復!";
	FWL.DEFAULT_TT = "重置該選項設置.";

	FWL.DEFAULT_FRAME = "[重置窗口設定]";
	FWL.DEFAULT_FRAME_TT = "該視窗設置恢復為原始狀態.";

	FWL.POSITION_TT = "點擊重置該狀況位置.";

	FWL.MODULE_COLORS = "應用模組顏色";
	FWL.MODULE_COLORS_TT = "每個選項視窗都有個性顏色，幫助你不會搞錯設置視窗.";

	FWL.GLOBAL_ALPHA = "全域窗口透明度";
	FWL.GLOBAL_ALPHA_TT = "設置ForteXorcist全部視窗的透明度";
	FWL.ALPHA = "[重置透明度]";
	FWL.ALPHA_TT = "恢復窗口原始透明度.";

	FWL.RESTORE_SCALE = "[重置大小]";
	FWL.RESTORE_SCALE_TT = "重置窗口原始大小.";

	FWL.TIPS = "顯示模組視窗滑鼠提示Show module frame Tooltips";
	FWL.TIPS_TT = "為非選項顯示滑鼠提示，比如時間圖示、模組bar、操作按鈕.";

	FWL.FILTER_ALL = "全部";
	FWL.FILTER_OTHERS = "|cFF00BFFFbuff|r |cFF005BFFdebuff|r";
--[[>>]]FWL.FILTER_MINE = "|cFFFFCC00玩家|r";
	FWL.FILTER_BUFF = "|cFF00BBFFbuff";
	FWL.FILTER_BUFF_DEBUFF = "|cFFAACCFFbuff|r |cFFFF0000debuff|r";
	FWL.FILTER_DEBUFF = "|cFFFF0000debuff";
	FWL.FILTER_OTHER = "|cFFFFCC00其他人|r";
	FWL.FILTER_COOLDOWNS = "|cFFFF6359冷卻|r";
	FWL.FILTER_SHOW_COLOR = FWL.FILTER_COLOR.." "..FWL.FILTER_NORMAL;

	FWL.TOGGLE_FILTER_LIST = "過濾表開關";
	FWL.BACKDROP = "背景";	

	-- register extra fonts
	FW:RegisterFont("Fonts\\bLEI00D.TTF","聊天字體");
	FW:RegisterFont("Fonts\\bHEI01B.TTF","戰鬥字體");
	FW:SetDefaultFont("Fonts\\bLEI00D.TTF",11);
else
	FWL.MODULE_NONE = "|cffff0000None|r";
	
	FWL.UPDATE_NOW = "Update Now";
	FWL.LAST_CHECK = "\n\nLast check: %d seconds ago.";
	FWL.SCROLL_TO_ = "Scroll to ";

	FWL.POTION = "Potion";
	FWL.POWERUP = "Powerup";
	FWL.ITEM = "Item";
	FWL.PET = "Pet";
	FWL.SPELL = "Spell";
	FWL.HEALTHSTONE_NORMAL = "Healthstone";
	FWL.SOULWELL = "Soulwell";

	-- commonly used
	FWL.USE_ = "Use %s";
	FWL.CREATE_ = "Create %s";
	FWL.LEFT_CLICK_TO_CREATE_ = "Left Click to create %s.";
	FWL.RIGHT_CLICK_TO_USE_ = "Right Click to use %s.";

	FWL.MASTER = "Master";
	FWL.MAJOR = "Major";
	FWL.GREATER = "Greater";
	FWL.NORMAL = "Normal";
	FWL.LESSER = "Lesser";
	FWL.MINOR = "Minor";

	FWL.NOTARGET = "<No Target>";
	FWL.UNKNOWN = "<Unknown>";
	FWL.NOBODY = "<Nobody>";

	FWL.NONE = "None";

	FWL.ENABLE  = "Enable";
	FWL.LOCK = "Lock (disable dragging)";
	FWL.EXPAND_UP = "Expand up";
	FWL.EXPAND_UP_TT = "Determines if the bar lists should be expanded upwards or downwards.";
	FWL.BAR_SPACING = "Bar spacing";
	FWL.COMBAT_HINT = "Some sizing changes you make here will only apply outside of combat.";
	FWL.ORA_HINT = "For people without ForteWarlock but with oRA, someone with FW has to be promoted.";

	FWL.DEAD = "Dead";
	FWL.OFFLINE = "Offline";
	FWL.CASTING = "Casting";
	FWL.CUSTOMIZE = "Customize";
	FWL.GENERAL = "General Options";
	FWL.ADVANCED = "Advanced Options";
	FWL.BASIC = "Basics";
	FWL.SPECIFIC = "Specifics";
	FWL.CORE = "Core";
	FWL.COLORING_FILTERING = "Spell Coloring/Filtering";
	FWL.APPEARANCE = "Frame Appearance";
	FWL.SIZING = "Frame Sizing";
	FWL.SCALE = "Scale";
	FWL.BAR_HEIGHT = "Bar height";
	FWL.BAR_WIDTH = "Bar width";
	FWL.BAR = "Bar";
	FWL.FRAME_BACKGROUND = "Frame Background";
	FWL.BAR_TEXT = "Bar text";
	FWL.BAR_FONT = "Bar Font";
	FWL.BAR_TEXTURE = "Bar Texture";
	FWL.BAR_COLORING = "Bar Coloring";
	FWL.AUTO_HIDE = "Auto-hide outside party/raid";
	FWL.AUTO_HIDE_TT = "This will automatically hide the frame when not in a party or raid.";
	FWL.AUTO_MINIMIZE = "Auto-minimize outside party/raid";
	FWL.AUTO_MINIMIZE_TT = "This will automatically hide the bars when not in a party or raid.";
	FWL.SHOW_BARS = "Show bars";
	FWL.SHOW_BARS_TT = "Show the bars. You can hide them in case you only want to see the information on the header.";
	FWL.MAX_SHOWN = "Maximum shown";

	FWL.SELF_MESSAGES = "Self Messages";
	FWL.SELF_MESSAGES_HINT1 = "This allows you to display useful messages to yourself. They are shown in your 'default' chat frame.";
	FWL.RAID_MESSAGES = "Party/Raid Messages";
	FWL.RAID_MESSAGES_HINT1 = "This allows you to display messages to others based on spells you cast.";
	FWL.RAID_MESSAGES_HINT2 = "You can disable all messages to party/raid and/or channel, or every message separately.";
	FWL.SHOW_IN_RAID = "Show in party/raid (1st checkboxes)";
	FWL.SHOW_IN_RAID_TT = "Uncheck to stop any messages from being shown in your raid or party.";
	FWL.SHOW_IN_CHANNEL = "Show in channel (2nd checkboxes)";
	FWL.SHOW_IN_CHANNEL_TT = "Set the channel name or number in which you want some of your messages to be displayed. 'say' is also valid. Uncheck to stop any messages being shown in the channel.";

	-- standard usage tips to append
	FWL.USE_FILTER = "First type in the item or spell that you want to change (auto-fills). Then you can select if you want to show it normally (normal), hide it (ignore) or change its color (color). If you selected you want to change the color, you get a color picker from clicking square on the right.";
	FWL.USE_COLOR_PICKER = "Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency. You can also use the editbox to enter a color value in R G B A (red green blue alpha) format. This also allows for easier copying.";
	FWL.USE_COLOR_PICKER2 = "Uncheck to hide completely. Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency. You can also use the editbox to enter a color value in R G B A (red green blue alpha) format. This also allows for easier copying.";

	FWL.USE_TEXTURE = "Mouse over the left textured bar and select a texture from the dropdown menu. You can also use any other texture by giving its path.";
	FWL.USE_FONT = "Mouse over the left font area and select a font from the dropdown menu. The center editbox can be used to change the font size. You can also use any other font by giving its path.";
	FWL.USE_EDITBOX = "Don't forget you have to press enter to confirm changes to the editboxes!";
	FWL.USE_MSG2 = "The first checkbox will enable this message in your party or raid. The second checkbox will enable it in the channel you set above.";

	FWL.DEFAULT = "[restore default]";
	FWL.POSITION = "[reset position]";
	
	-- all the other text and tips belonging to core itself
	FWL.ADVANCED_HINT1 = "You will usually not have to change anything here. It's only for problem solving.";
	FWL.ADVANCED_HINT2 = "Changes to 'update intervals' only apply after reloading.";

	FWL.GENERAL_TIPS = "Some Tips";
	FWL.GENERAL_TIPS1 = "Press enter to confirm changes to editboxes. Escape will restore its current setting.";
	FWL.GENERAL_TIPS2 = "You can use the [default] button in the headers to restore every default in this category.";
	FWL.GENERAL_TIPS3 = "Left-click frame headers to toggle between display modes. Drag frame headers to move.";
	FWL.GENERAL_TIPS4 = "Some color options also allow for transparency changing. Usually the background colors.";

	FWL.GENERAL_MO = "General Module Options";
	FWL.GENERAL_MO1 = "Right-click headers for options";
	FWL.GENERAL_MO1_TT = "You can right-click the module frame headers to open the options menu at the right position. Will only work for frames that aren't fully locked.";
	FWL.GENERAL_MO2 = "Alternate time format";
	FWL.GENERAL_MO2_TT = "Change the time format from 30m to 29:59.";
	FWL.GENERAL_MO3 = "Enable frame snapping";
	FWL.GENERAL_MO3_TT = "The module frames will allign to each other's borders when dragged.";
	FWL.GENERAL_MO4 = "Frame snapping distance";
	FWL.GENERAL_MO4_TT = "The distance frame borders must be from each other to allign.";
	FWL.GENERAL_MO5 = "Frame spacing";
	FWL.GENERAL_MO5_TT = "The distance to keep between frames when they are alligned.";

	FWL.GENERAL_MA = "General Module Appearance";
	FWL.GENERAL_MA1_TT = "Change the Bar Font for ALL module frames.";
	FWL.GENERAL_MA2_TT = "Change the Bar Texture for ALL module frames.";

	FWL.GENERAL_OA = "Options Appearance";
	FWL.GENERAL_OA1 = "Header Color";
	FWL.GENERAL_OA1_TT = "Change the Header Color of the option frames.";
	FWL.GENERAL_OA2 = "Background Color";
	FWL.GENERAL_OA2_TT = "Change the Background Color of the option frames.";
	FWL.GENERAL_OA3 = "Headers";
	FWL.GENERAL_OA3_TT = "Change the font the options headers are displayed in.";
	FWL.GENERAL_OA4 = "Options";
	FWL.GENERAL_OA4_TT = "Change the font the options are displayed in.";

	FWL.PROFILES = "Profiles";
	FWL.PROFILES_CURRENT = "Current Profile";
	FWL.PROFILES_CURRENT_TT = "Select the profile you want to use. [delete current] deletes the profile you are currently using (have selected). [create new] copies your current settings to a new profile with the name you entered or replaces one.";

	FWL.LOADING_DELAY = "Loading delay";
	FWL.UPDATE_INTERVAL_CORE = "Update interval core";
	FWL.UPDATE_INTERVAL_ANIMATIONS = "Update interval animations";
	FWL.CHILL_SPEED = "Chill speed";
	FWL.ANIMATE_SCROLL = "Animate auto-scrolling";
	FWL.ANIMATE_SCROLL_TT = "Animates the scrolling and showing of the options. This may give you a better feeling of 'where you are' in the options menu (and it looks kinda cool).";
	
	FWL.OPTIONS_SCALE = "Options scale";
	FWL.OPTIONS_SCALE_TT = "Change the scale of the Options frame";
	FWL.TOGGLE_OPTIONS = "Toggle Options";
	FWL.OPTIONS_COLUMNS = "Option Columns";
	FWL.OPTIONS_COLUMNS_TT = "Change the number of columns of the options frame.";
	FWL.OPTIONS_HEIGHT = "Option Height";
	FWL.OPTIONS_HEIGHT_TT = "Change the height of the options frame.";
	
	FWL.BLOCK_SHARDS = "Safely block shard reagents";
	FWL.BLOCK_SHARDS_TT = "Hides the shard count on your action buttons. Requires a reload of your interface to apply. Currently supported: Bartender4 and Standard UI.";

	FWL.GLOBAL_LOCK = "Global Frame Lock";
	FWL.GLOBAL_LOCK_TT = "Lock all the frames belonging to the addon. Some frames may have their own locking option though.";
	
	FWL.SOUND = "Sound";
	FWL.SOUND_HINT1 = "Click the little trumpet icons to hear the sounds. Use the second editbox to adjust the volume.";
	FWL.RANGE_MAX = "Range: %s to %s";
	FWL.RANGE_MIN = "Range: %s and higher";
	FWL.CREATE_PROFILE = "[create new profile]";
	FWL.DELETE_PROFILE = "[delete active profile]";
	FWL.CLICK_TO_EDIT = "[click to edit]";
	FWL.CLICK_TO_EDIT_TT = "Press ENTER to confirm your change. Press ESC to discard your change.";
	FWL.CLICK_TO_COPY = "[click to select, Ctrl+C to copy]";
	
	FWL.DEMONIC = "Demonic";
	FWL.FEL = "Fel";
	
	FWL.SPARK_MATCH = "Spark matches bar";
	FWL.SPARK_MATCH_TT = "The color of the sparks will match the color of the bars.";
	FWL.SPARK_COLOR = "Spark color";
	FWL.SPARK_COLOR_TT = "Set the spark colors to any color you like. You can also use this to hide the sparks by choosing an alpha of 0.";

	FWL.FADING = "Fading";
	FWL.TIME_LEFT_HINT = "Announce fade time for your spells by left-clicking a Timer icon.";
	FWL.TIME_LEFT_NOTARGET = "Announce fade time (no target)";
	
	FWL.PROFILES_HINT1 = "The AddOn saved what profile you were using on this character last time.";
	FWL.PROFILES_HINT2 = "This makes it easy to share profiles among different characters.";

	FWL.GENERAL_MO6 = "Right-click icons to customize";
	FWL.GENERAL_MO6_TT = "You can right-click the icons in some modules to open the options menu at the right customization filter.";

	FWL.FILTER_NONE = "none";
	FWL.FILTER_IGNORE = "|cffff0000hide|r";
	FWL.FILTER_COLOR = "|cff00ffffcolor|r";
	FWL.FILTER_NORMAL = "|cff00ff00show|r";
	FWL.FILTER_ALWAYS = "|cffff8000always|r";
	
	FWL.UNLOCK = "Unlock (enable dragging)";
	
	FWL.UNLOCK_TT = "This module's frame is Locked. Click to Unlock this frame, so it can be dragged around.";
	FWL.LOCK_TT = "This module's frame is Unlocked. Click to Lock this frame, so it can no longer be dragged around.";

	FWL.DEFAULT_ALL = "[restore all defaults]";
	FWL.DEFAULT_ALL_TT = "Click to restore the defaults of all the options in this category. Be careful, it cannot be undone!";
	FWL.DEFAULT_TT = "Click to restore the default of this option.";

	FWL.DEFAULT_FRAME = "[restore frame defaults]";
	FWL.DEFAULT_FRAME_TT = "Click to restore the frame properties of this module.";

	FWL.POSITION_TT = "Click to reset this module's frame position.";

	FWL.MODULE_COLORS = "Use Module Colors";
	FWL.MODULE_COLORS_TT = "Each of the option frames gets its own color. His should help not to edit the wrong module by accident. These colors are mixed with the option header color, so you can still influence their appearance a little.";

	FWL.GLOBAL_ALPHA = "Global Frame Alpha";
	FWL.GLOBAL_ALPHA_TT = "Set the visibility of all frames belonging to the addon to this value.";
	FWL.ALPHA = "[restore alpha]";
	FWL.ALPHA_TT = "Click to reset the transparency of this frame to its default.";

	FWL.RESTORE_SCALE = "[restore scale]";
	FWL.RESTORE_SCALE_TT = "Click to reset the scale of this frame to its default.";

	FWL.TIPS = "Show module frame Tooltips";
	FWL.TIPS_TT = "Show any non-option Tooltips. For example the Tooltips on timer icons, module bars and integrated cast buttons.";

	FWL.FILTER_ALL = "all";
	FWL.FILTER_OTHERS = "|cFF00BFFFbuff|r |cFF005BFFdebuff|r";
	FWL.FILTER_MINE = "|cFF00FF00by me (rest)|r";
	FWL.FILTER_BUFF = "|cFF00BBFFbuff";
	FWL.FILTER_BUFF_DEBUFF = "|cFFAACCFFbuff|r |cFFFF0000debuff|r";
	FWL.FILTER_DEBUFF = "|cFFFF0000debuff";
	FWL.FILTER_OTHER = "|cFFFFCC00all other|r";
	FWL.FILTER_COOLDOWNS = "|cFFFF6359cooldowns|r";
	FWL.FILTER_SHOW_COLOR = FWL.FILTER_COLOR.." "..FWL.FILTER_NORMAL;

	FWL.TOGGLE_FILTER_LIST = "Toggle Filter List";
	FWL.BACKDROP = "Backdrop";
end
FWL.FILTER_DEBUFFS_ON_ME = "|cffff4400on me|r";
FWL.FRAME_LEVEL = "Frame level (strata)";
FWL.CLONE = "Clone";
FWL.CREATE_CLONE = "[click to create clone/profile]";
FWL.SELECT_CLONE = "[click to select clone/profile]";
FWL.RENAME_CLONE = "[click to rename clone/profile]";
FWL.DELETE_CLONE = "[click to delete clone/profile]";
FWL.RENAMING_CLONE = "Renaming Clone/Profile";
FWL.BACK_GROUND = "Back-ground";
FWL.SUB_HEADERS = "Sub-Headers";
FWL.GLOBAL_FRAME_NAMES = "Enable global frame names";
FWL.GLOBAL_FRAME_NAMES_TT = "Enable global frame names for module frames for other addons to use. You have to reload your interface to apply.";

FWL.GENERAL_TIPS5 = "Right-click frame headers or spell icons to quickly open their options.";
FWL.GENERAL_TIPS6 = "Make sure to read the tooltip of an option if you're unsure of what is does.";

FW:LocalizedData();