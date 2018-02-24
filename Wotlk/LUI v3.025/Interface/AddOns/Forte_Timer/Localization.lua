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
if GetLocale() == "ruRU" then
-- FR
elseif GetLocale() == "frFR" then
-- DE last update Norrax
elseif GetLocale() == "deDE" then
-- SPANISH
elseif GetLocale() == "esES" then
-- Simple Chinese
elseif GetLocale() == "zhCN" then
-- tradition Chinese
elseif GetLocale() == "zhTW" then
-- ENGLISH
else
	--FWL.SUMMON_VALKYR = "Val'kyr Guardian";
end

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

if GetLocale() == "ruRU" then

	FWL.SPELL_TIMER = "Таймер заклинаний";
	FWL.DISPLAY_MODES = "Режимы отображения";
	FWL.EXTRA = "Дополнительно";
	FWL.SHOW_HEADER = "Показывать заголовок";
--[[>>]]FWL.DISPLAY_TYPES = "Display Types";
--[[>>]]FWL.TIMER_HIDING = "Hiding";

	FWL.ST_HINT1 = "После настройки таймера, вы можете заблокировать его и скрыть его заголовок.";
--[[>>]]FWL.ST_HINT2 = "Right-clicking a debuff icon will fill in that spell in the custom filter field.";
--[[>>]]FWL.ST_HINT3 = "When the timer is locked you will click through it.";

	FWL.ST_BASIC1_TT = "Разрешить отображения таймера заклинаний.";		
	FWL.ST_BASIC3_TT = "Отображение заголовка может быть полезно при настройке таймера, но нет никакой причиные не скрыть его. вы все равно можете перетянуть таймер из места заголовка, даже если сам заголовок скрыт.";

	FWL.NORMAL_TEXT = "Обычный текст";
	FWL.NORMAL_TEXT_TT = "Цвет, используемый для текстов, соответствующих любому элементу, не являющемуся целью или фокусом.";
	FWL.TARGET_TEXT = "Текст цели";
	FWL.TARGET_TEXT_TT = "Цвет, использумый для текстов, относящихся к вашей цели.";
	FWL.FOCUS_TEXT = "Текст фокуса";
	FWL.FOCUS_TEXT_TT = "Цвет, используемый для текстов, относящихся к вашему фокусу.";
	FWL.COUNTDOWN_TEXT = "Текст кулдаунов";
	FWL.COUNTDOWN_TEXT_TT = "";

	FWL.LABEL_FONT = "Шрифт меток";
	FWL.LABEL_FONT_TT = "Шрифт, используемый для меток элементов между панелями (если включено)";
	FWL.UNIT_SPACING = "Отступ элементов";
	FWL.UNIT_SPACING_TT = "Отступ между группами панелей, принадлежащих к разным элементам. ТОлько применимо, когда производится группировка по номеру элемента.";
	FWL.UNIT_LABEL_HEIGHT = "Высота метки элемента";
	FWL.UNIT_LABEL_HEIGHT_TT = "Высота метки элемента между панелями (если включено)";
	FWL.COUNTDOWN_WIDTH = "Ширина текста обратного отсчета";
	FWL.COUNTDOWN_WIDTH_TT = "Вы можете увеличить ширину текста обратного отсчета, если он не помещается по какой-либо причине.";
	FWL.MAXIMIZE_SPACE = "Увеличить размер пространства имен (некрасиво)";
	FWL.MAXIMIZE_SPACE_TT = "Увеличивает размер, используемый для имен элементов/заклинаний. Как результат, эти тексты не будут отображаться в середине панелей. Может быть полезно при использовании очень коротких панелей.";
	FWL.COUNTDOWN_ON_RIGHT = "Обратный отсчет справа";
	FWL.COUNTDOWN_ON_RIGHT_TT = "Вы можете отображать текст обратного отсчета справа или слева панелей таймеров.";
	
	FWL.ONEMAX = "Привести к максимальной";
--[[>>]]FWL.ONEMAX_TT = "Привести размер всех панелей к максимальной. In other words, all the bars will use the duration of the spell with the longest duration currently on the timer. Это поможет легче отслеживать время чтения заклинаний.";
--[[>>]]FWL.FORCEMAX = "Force maximum time";
--[[>>]]FWL.FORCEMAX_TT = "Forces the maximum time setting on all bars, even if the longest timer has a shorter duration.";
	FWL.MAXTIME = "Максимальное время";
	FWL.MAXTIME_TT = "Максимальное время, отображаемое на панели. Эта опция предназначена в основном, для повышения практичности настройки 'привести к максимальной'.";

	FWL.DISPLAY_MODES7 = "Группировать по номеру элемента";
	FWL.DISPLAY_MODES7_TT = "Группирует таймеры, относящиеся к одним и тем же элементам.";
	FWL.DISPLAY_MODES8 = "Показывать номер элемента";
	FWL.DISPLAY_MODES8_TT = "Показывает идентификатор каждого элемента перед его именем. Это позволит отделять элементы с одинаковыми именами.";
	FWL.DISPLAY_MODES9 = "Заклинания с метками элементов";
	FWL.DISPLAY_MODES9_TT = "Показывает названия заклинаний на панелях таймеров вместо названия цели. В сочетании с группировкой по имени элемента, метки названий элементов будут показаны для каждой группы панелей.";
	FWL.DISPLAY_MODES10 = "Показывать только цель/фокус";
	FWL.DISPLAY_MODES10_TT = "Все заклинания будут отслеживаться в фоновом режиме, но вы будете видеть только вашу цель или фокус.";

	FWL.DISPLAY_TYPES1 = "Показывать приобретенные баффы";
	FWL.DISPLAY_TYPES1_TT = "Таймер также будет показывать положительные приобретенные баффы.";
	FWL.DISPLAY_TYPES2 = "Показывать уязвимость";
	FWL.DISPLAY_TYPES2_TT = "Показывать уязвимости, такие как дебафф Улучшенной Стрелы тьмы на вашей цели, как приобретение.";
--[[>>]]FWL.DISPLAY_TYPES3 = "Hide timers if remaining over";
--[[>>]]FWL.DISPLAY_TYPES3_TT = "Spells that still last longer than this time (seconds) will be hidden from the timer. They will be unhidden again when they get below this time or get removed early. In addition, hidden spells are again shown on your target when you reselect it, so it's still easy to see what spells are up.";
--[[>>]]FWL.DISPLAY_TYPES4 = "Pre-hide display time";
--[[>>]]FWL.DISPLAY_TYPES4_TT = "The time a spell is diplayed before being hidden.";
	FWL.DISPLAY_TYPES5 = "Показывать неудачные заклинания";
	FWL.DISPLAY_TYPES5_TT = "Также показывать неудачные заклинания на таймере (сопротивление, неуязвимость итд). Очень помогает.";
	FWL.DISPLAY_TYPES6 = "Время отображения неудачных";
	FWL.DISPLAY_TYPES6_TT = "Время, которое неудачное заклинание отображается до исчезновения.";
--[[>>]]FWL.DISPLAY_TYPES7 = "Show harmfull spells";
--[[>>]]FWL.DISPLAY_TYPES7_TT = "Show your harmful spells in the Spell Timer.";
--[[>>]]FWL.DISPLAY_TYPES8 = "Show heals";
--[[>>]]FWL.DISPLAY_TYPES8_TT = "Show your HoTs in the Spell Timer.";
--[[>>]]FWL.DISPLAY_TYPES9 = "Show friendly spells";
--[[>>]]FWL.DISPLAY_TYPES9_TT = "Show your friendly spells in the Spell Timer.";
--[[>>]]FWL.DISPLAY_TYPES10 = "Show pet spells";
--[[>>]]FWL.DISPLAY_TYPES10_TT = "Show your pet's spells in the Spell Timer.";
--[[>>]]FWL.DISPLAY_TYPES11 = "No hiding on bosses";
--[[>>]]FWL.DISPLAY_TYPES11_TT = "Enable this option to keep all your longer spells visible on bosses.";

	FWL.FADING1 = "Мигать истекающими панелями";
	FWL.FADING1_TT = "Когда включено, панели истекающие через 3 секунды, начнут мигать. Медленно сначала, быстро в конце. Хороший показатель для истекающих панелей без смены их цвета.";
	FWL.FADING2 = "Затухание панелей";
	FWL.FADING2_TT = "Когда включено, панели буду плавно затухать.";
	FWL.FADING3 = "Стандартная задержка затухания";
	FWL.FADING3_TT = "Задержка после истечения панели таймера, до момента начала затухания. Также известна как 'призрачное время'.";
	FWL.FADING4 = "Время затухания";
	FWL.FADING4_TT = "Время, которое требуется панелям, чтобы пропасть.";
	FWL.FADING5 = "Подсвечивать новые заклинания";
	FWL.FADING5_TT = "Недавно прочинтанные заклинания будут ярче и будут менять свой цвет примерно за полсекунды. Дополнительная помощь при отслеживании новых заклинаний на таймере.";
	FWL.FADING6 = "Прозрачность не-цели";
	FWL.FADING6_TT = "Таймеры, которые не принадлежает в вашей текущей цели или фокусу, будут отображаться с другой прозрачностью. Это делает очень простым видеть, какой элемент выбран в данный момент.";

	FWL.EXTRA1 = "Показывать значки рейдовых целей";
	FWL.EXTRA1_TT = "Показывать значки рейдовых целей каждого элемента на фоне панелей.";
	FWL.EXTRA2 = "Прозрачность значков рейдовых целей";
	FWL.EXTRA2_TT = "Прозрачность значков рейдовых целей.";
	FWL.EXTRA3 = "Улучшение: показывать тики дотов";
	FWL.EXTRA3_TT = "Когда включено, таймер будет отслеживать периодический урон по истории боя (combat log), чтоб поможет убрирать неактивные панели.";
	FWL.EXTRA4 = "Улучшение: Использовать цели группы/рейда";
	FWL.EXTRA4_TT = "Когда включено, таймер будет отслеживать цели партии/рейда для убирания неактивных панелей.";
--[[>>]]FWL.EXTRA5 = "Synchronize durations";
--[[>>]]FWL.EXTRA5_TT = "Synchronize spell timer durations to the actual debuff/buff durations of their targets. This is needed for example for debuffs that can reset their duration through other abilities. The addon has never done this before, but currently debuff/buff information seems much more reliable.";
--[[>>]]FWL.EXTRA6 = "Remove mob timers after combat";
--[[>>]]FWL.EXTRA6_TT = "Every time you exit combat the addon will remove remaining timers belonging to NPCs. May be useful to disable this in some cases.";
	
	FWL.HIGHLIGHT = "Выделение";
	FWL.FAIL = "Неудача";
	FWL.MAGIC_DOT = "Магический дот";
	FWL.CURSE = "Проклятье";
	FWL.CC = "Контроль толпы";
	FWL.POWERUP_BUFFS = "Положительный бафф";
	FWL.HEAL = "Лечение";
	FWL.FRIENDLY_BUFFS = "Дружеский бафф";

	FWL.ST_CUSTOMIZE_TT = "Настроить каждый из ваших спеллов или баффов.";
	FWL.FAILED_MESSAGE_COLOR = "Сообщения о неудачных заклинаниях";
	FWL.SHOW_FAILED = "Показывать неудачные заклинания";
	FWL.SHOW_FAILED_TT = "Показывать заклинания, неудавшиеся из-за сопротивления, неуязвимости итд.";

	FWL.SHORT_HIDE = "скрыто";
	FWL.SHORT_FADE = "затух";
	FWL.SHORT_REMOVED = "снято";
	FWL.SHORT_RESISTED = "сопр";
	FWL.SHORT_IMMUNE = "неуязв";
	FWL.SHORT_EVADED = "мимо";
	FWL.SHORT_REFLECTED = "отраж";

	FWL.UPDATE_INTERVAL_SPELL_TIMER = "Интервал обновления таймера заклинаний";
	FWL.DELAY_TARGET_DEBUFF_CHECK = "Задержка проверки дебаффов цели";
	FWL.DELAY_DOT_TICKS_INIT = "Задержка инициализации тиков дотов";
	FWL.DELAY_DOT_TICKS = "Задержка тиков дотов";
	
--[[>>]]FWL.TIME_LEFT = "Announce fade time";

--[[>>]]FWL.NORMAL_TYPE = "Normal Type";
--[[>>]]FWL.NORMAL_TYPE_TT = "Normal Spell Types";
--[[>>]]FWL.SHARED_TYPE = "Shared Type";
--[[>>]]FWL.SHARED_TYPE_TT = "Types of spells that allow only one spell of this kind up on one target (for example Curses).";
--[[>>]]FWL.OTHER_DEBUFFS = "Other Debuffs";
--[[>>]]FWL.OTHER_DEBUFFS_TT = "This may be important debuffs cast by others, or debuffs that belong to you that aren't triggered directly by spellcasts. These are only shown for your current target.";
--[[>>]]FWL.CC_TT = "Crowd control or silencing spells";

--[[>>]]FWL.TICKS = "Show Ticks";
--[[>>]]FWL.TICKS_TT = "Show remaining DoT ticks on the bars.";
--[[>>]]FWL.TICKS_NEXT = "Next Tick only";
--[[>>]]FWL.TICKS_NEXT_TT = "Only show the next Tick on the bars.";
	
--[[>>]]FWL.DRAIN = "Drain";
--[[>>]]FWL.DRAIN_TT = "Show Drain spells that benefit from haste";

--[[>>]]FWL.FADE = "Fade";
--[[>>]]FWL.BREAK = "Break";
--[[>>]]FWL.RESIST = "Resist";

--[[>>]]FWL.TICKS_COLOR = "Tick Color";
--[[>>]]FWL.TICKS_COLOR_TT = "Set the tick colors to any color you like.";

--[[>>]]FWL.TIMER_OUTWARDS = "Highest timers outwards";
--[[>>]]FWL.TIMER_OUTWARDS_TT = "Bars will be sorted with the longest remaining times the furthest from the spell timer header/anchor.";
--[[>>]]FWL.TEST_BARS = "Enable Test Bars";
--[[>>]]FWL.TEST_BARS_TT = "Enable Test Bars. This option makes it easier to configure the timer without having to cast on units. You still need to select units to test target/focus settings, but this can also be yourself.";


--[[>>]]FWL.CAST_GLOW = "Show cast time Glow";
--[[>>]]FWL.CAST_GLOW_TT = "The timer bars indicate the time it will take to cast this spell or how long global cooldown would take up after the cast. This makes it much easier to time spell casts. Global cooldown is only shown when '"..FWL.ONEMAX.."' is enabled.";

--[[>>]]FWL.CUSTOM_TAG = "Custom tag";
--[[>>]]FWL.CUSTOM_TAG_TT = "Use your own customized tag for the spell timer bars.\n|cff00ff00id|r is replaced by the target's id (if any).\n|cff00ff00target|r is replaced by the target unit name (if any).\n|cff00ff00spell|r is replaced by the spell name.\n|cff00ff00stacks|r is replaced by the number of stacks of the buff/debuff (if any).";

--[[>>]]FWL.UNIQUE_TYPE = "Unique Type";
--[[>>]]FWL.UNIQUE_TYPE_TT = "Types of spells that can only be cast on one target at a time. For example most crowd control spells.";
	

-- simple chinese
elseif GetLocale() == "zhCN" then

	FWL.SPELL_TIMER = "法术计时条";
	FWL.DISPLAY_MODES = "显示模式";
	FWL.EXTRA = "扩展";
	FWL.SHOW_HEADER = "显示标题栏";
	FWL.DISPLAY_TYPES = "显示类型";
	FWL.TIMER_HIDING = "隐藏";

	FWL.ST_HINT1 = "设置好计时条后可以锁定并隐藏标题栏.";
	FWL.ST_HINT2 = "右键单击debuff图标过滤.";
	FWL.ST_HINT3 = "计时条锁定时点击穿过.";

	FWL.ST_BASIC1_TT = "计时条可视.";		
	FWL.ST_BASIC3_TT = "显示标题栏对设置计时条很有帮助,但最好还是隐藏了它,它隐藏后依然能够通过拖拽它移动计时条.";

	FWL.NORMAL_TEXT = "一般文字";
	FWL.NORMAL_TEXT_TT = "任何非目标/焦点的目标的计时文字颜色.";
	FWL.TARGET_TEXT = "目标文字";
	FWL.TARGET_TEXT_TT = "你目标的计时文字颜色.";
	FWL.FOCUS_TEXT = "焦点文字";
	FWL.FOCUS_TEXT_TT = "你焦点的计时文字颜色.";
	FWL.COUNTDOWN_TEXT = "冷却文字";
	FWL.COUNTDOWN_TEXT_TT = "";

	FWL.LABEL_FONT = "标签字体";
	FWL.LABEL_FONT_TT = "对象标签的字体. (当开启按对象分类时)";
	FWL.UNIT_SPACING = "对象间距";
	FWL.UNIT_SPACING_TT = "不同对象计时条之间的间距. 只有当设定按对象分类计时条才有效.";
	FWL.UNIT_LABEL_HEIGHT = "对象标签高度";
	FWL.UNIT_LABEL_HEIGHT_TT = "对象标签的高度. (当开启按对象分类时)";
	FWL.COUNTDOWN_WIDTH = "计时文字宽度";
	FWL.COUNTDOWN_WIDTH_TT = "你可以增加计时文字的宽度, 因为有时候计时文字可能显示不完全.";
	FWL.MAXIMIZE_SPACE = "最大名字空间(丑)";
	FWL.MAXIMIZE_SPACE_TT = "对象/法术的空间最大化. 结果是这些文字将不会在计时条中间显示. 当你把计时条设置非常短时有所帮助.";
	FWL.COUNTDOWN_ON_RIGHT = "右侧显示计时";
	FWL.COUNTDOWN_ON_RIGHT_TT = "在计时条左侧或右侧显示计时.";

	FWL.ONEMAX = "统一上限时间";
	FWL.ONEMAX_TT = "所有的计时条都统一计时上限，就是所有的计时条的显示计时上限都统一为当前的最大计时时间，这样更容易看出施法计时.";
	FWL.FORCEMAX = "强制上限时间";
	FWL.FORCEMAX_TT = "所有的计时条都强制最大计时上限，哪怕计时上限长于最大的计时时间.";
	FWL.MAXTIME = "上限时间";
	FWL.MAXTIME_TT = "计时条显示的上限时间.";
	
	FWL.DISPLAY_MODES7 = "按对象号分类";
	FWL.DISPLAY_MODES7_TT = "将一个对象的计时条排在一起显示.";
	FWL.DISPLAY_MODES8 = "显示对象号";
	FWL.DISPLAY_MODES8_TT = "在每个对象名字前显示其编号. 有助于分辨出同名对象.";
	FWL.DISPLAY_MODES9 = "计时条显示法术名";
	FWL.DISPLAY_MODES9_TT = "计时条将显示法术名而不是目标名. 当按照对象分类选项开启时,对象名将在每个分类条上显示.";
	FWL.DISPLAY_MODES10 = "只显示目标/焦点";
	FWL.DISPLAY_MODES10_TT = "所有的法术在背后仍然被追踪,但是只显示你目标和焦点的法术.";

	FWL.DISPLAY_TYPES1  = "显示增强buffs";
	FWL.DISPLAY_TYPES1_TT = "计时条显示增益buff.";
	FWL.DISPLAY_TYPES2 = "显示暗影易伤";
	FWL.DISPLAY_TYPES2_TT = "显示目标身上的类似暗影易伤的debuff作为自己的增强buff.";
	FWL.DISPLAY_TYPES3 = "计时阀值";
	FWL.DISPLAY_TYPES3_TT = "法术剩余时间比这个时间长的时候不显示法术，当这些法术持续时间低于这个时间或者提前被移除时将会再次显示，此外，被隐藏的法术在你重选定它时会显示在你的目标上，因此你可以很容易看到有哪些法术存在，设置0则禁用.";
	FWL.DISPLAY_TYPES4 = "隐藏前显示时间";
	FWL.DISPLAY_TYPES4_TT = "法术隐藏前的显示时间.";
	FWL.DISPLAY_TYPES5 = "显示失败法术";
	FWL.DISPLAY_TYPES5_TT = "失败法术仍在计时条显示 (例如抵抗,免疫之类). 很有用.";
	FWL.DISPLAY_TYPES6 = "失败法术显示时间";
	FWL.DISPLAY_TYPES6_TT = "失败法术在计时条上显示时间.";
	
	FWL.DISPLAY_TYPES7 = "显示伤害法术";
	FWL.DISPLAY_TYPES7_TT = "计时条中显示你的伤害法术.";
	FWL.DISPLAY_TYPES8 = "显示治疗";
	FWL.DISPLAY_TYPES8_TT = "计时条中显示你的HoTs.";
	FWL.DISPLAY_TYPES9 = "显示友善法术";
	FWL.DISPLAY_TYPES9_TT = "计时条显示你的友善法术.";
	FWL.DISPLAY_TYPES10 = "显示Pet法术";
	FWL.DISPLAY_TYPES10_TT = "计时条显示你的Pet法术.";
	FWL.DISPLAY_TYPES11 = "boss战全显示";
	FWL.DISPLAY_TYPES11_TT = "启用这个选项，boss战的时候显示所有长计时法术";

	FWL.FADING1 = "法术结束前闪烁";
	FWL.FADING1_TT = "启动此选项,计时条结束3秒前闪烁.先慢后快. 颜色不变";
	FWL.FADING2 = "计时条渐隐";
	FWL.FADING2_TT = "开启后计时条平滑消失.";
	FWL.FADING3 = "渐隐消失时间";
	FWL.FADING3_TT = "计时结束,计时条渐隐持续时间";
	FWL.FADING4 = "渐隐时间";
	FWL.FADING4_TT = "计时条渐隐需用时间.";
	FWL.FADING5 = "高亮新释放法术";
	FWL.FADING5_TT = "新释放法术将高亮显示,目的是为了分辨新释放法术.";
	FWL.FADING6 = "没有目标时的透明度";
	FWL.FADING6_TT = "当计时条显示的不是你的目标或者焦点时,可以设置不同的透明度. 很容易分辨出自己的目标.";

	FWL.EXTRA1 = "显示团队图标";
	FWL.EXTRA1_TT = "在对象计时条背景上显示团队图标.";
	FWL.EXTRA2 = "团队图标透明度";
	FWL.EXTRA2_TT = "团队图标透明度.";
	FWL.EXTRA3 = "DOT判读";
	FWL.EXTRA3_TT = "启动此功能,计时条将查看你的战斗记录DOT伤害,来判读移除失效计时条.";
	FWL.EXTRA4 = "队友判读";
	FWL.EXTRA4_TT = "启动此功能,计时条将查看你队友的目标,来帮助判读移除失效计时条.";
	FWL.EXTRA5 = "计时同步";
	FWL.EXTRA5_TT = "将法术计时和其对目标造成的buff/debuff计时同步，需要设置样本技能.";
	FWL.EXTRA6 = "战斗结束后移除计时条";
	FWL.EXTRA6_TT = "每次离开战斗将NPC的计时条移除，也许有用吧.";

	
	FWL.HIGHLIGHT = "高亮";
	FWL.FAIL = "失败";
	FWL.MAGIC_DOT = "DOT";
	FWL.CURSE = "诅咒";
	FWL.CC = "控制";
	FWL.POWERUP_BUFFS = "增强buffs";
	FWL.HEAL = "治疗";
	FWL.FRIENDLY_BUFFS = "友善buffs";

	FWL.ST_CUSTOMIZE_TT = "自定义计时法术/buffs."
	FWL.FAILED_MESSAGE_COLOR = "失败法术信息";
	FWL.SHOW_FAILED = "显示失败法术";
	FWL.SHOW_FAILED_TT = "显示由于抵抗,免疫等释放失败的法术.";

	FWL.SHORT_HIDE = "隐藏";
	FWL.SHORT_FADE = "消失";
	FWL.SHORT_REMOVED = "移除";
	FWL.SHORT_RESISTED = "抵抗";
	FWL.SHORT_IMMUNE = "免疫";
	FWL.SHORT_EVADED = "闪避";
	FWL.SHORT_REFLECTED = "反射";

	FWL.UPDATE_INTERVAL_SPELL_TIMER = "计时条更新间隔";
	FWL.DELAY_TARGET_DEBUFF_CHECK = "目标debuff检查延迟";
	FWL.DELAY_DOT_TICKS_INIT = "DOT初始化延迟";
	FWL.DELAY_DOT_TICKS = "DoT延迟";
	
	FWL.TIME_LEFT = "显示法术剩余时间";
	
	FWL.NORMAL_TYPE = "普通";
	FWL.NORMAL_TYPE_TT = "普通模式";
	FWL.SHARED_TYPE = "公用模式";
	FWL.SHARED_TYPE_TT = "每种法术类型只显示一个计时条.";
	FWL.OTHER_DEBUFFS = "其他 Debuffs";
	FWL.OTHER_DEBUFFS_TT = "他人的重要debuff，或者不是由你的法术直接触发的debuff，只对当前目标有效.";
	FWL.CC_TT = "控制或沉默法术";
	
	FWL.TICKS = "显示DoT跳数";
	FWL.TICKS_TT = "显示DoT剩余跳数.";
	FWL.TICKS_NEXT = "显示下一跳";
	FWL.TICKS_NEXT_TT = "只显示计时条的的下一跳.";
	
	FWL.DRAIN = "吸取法术";
	FWL.DRAIN_TT = "显示受到急速效果加成的吸取法术";

	FWL.FADE = "消退";
	FWL.BREAK = "打断";
	FWL.RESIST = "抵抗";

	FWL.TICKS_COLOR = "跳数颜色";
	FWL.TICKS_COLOR_TT = "设置跳数颜色.";
	
	FWL.TIMER_OUTWARDS = "最长持续时间";
	FWL.TIMER_OUTWARDS_TT = "计时条记录最长的法术持续时间.";
	FWL.TEST_BARS = "启用测试计时条";
	FWL.TEST_BARS_TT = "测试计时条.";
	
	FWL.CAST_GLOW = "施法时间发光";
--[[>>]]FWL.CAST_GLOW_TT = "计时条显示该法术施放的准备时间或者是施放后的公共CD，帮助计算施法时间，公共CD只有启用'"..FWL.ONEMAX.."' 和冷却计时条时显示.";

	FWL.CUSTOM_TAG = "自定义标签";
	FWL.CUSTOM_TAG_TT = "使用自定义计时条标签.\n|cff00ff00id|r 替换目标id.\n|cff00ff00目标名|r 替换目标名字.\n|cff00ff00法术名|r 替换法术名字.\n|cff00ff00跳数|r 替换buff/debuff的跳数.";

	FWL.UNIQUE_TYPE = "单独类型";
	FWL.UNIQUE_TYPE_TT = "只能在同一时间对一个目标使用的法术. 比如大多数控制技能.";

-- tradition chinese
elseif GetLocale() == "zhTW" then

	FWL.SPELL_TIMER = "法術計時條";
	FWL.DISPLAY_MODES = "顯示模式";
	FWL.EXTRA = "擴展";
	FWL.SHOW_HEADER = "顯示標題欄";
	FWL.DISPLAY_TYPES = "顯示類型";
	FWL.TIMER_HIDING = "隱藏";
	
	FWL.ST_HINT1 = "設置好計時條後可以鎖定並隱藏標題欄.";
	FWL.ST_HINT2 = "按右鍵debuff圖示過濾.";
	FWL.ST_HINT3 = "計時條鎖定時點擊穿過.";

	FWL.ST_BASIC1_TT = "計時條可視.";		
	FWL.ST_BASIC3_TT = "顯示標題欄對設置計時條很有幫助,但最好還是隱藏了它,它隱藏後依然能夠通過拖拽它移動計時條.";

	FWL.NORMAL_TEXT = "一般文字";
	FWL.NORMAL_TEXT_TT = "任何非目標/焦點的目標的計時文字顏色.";
	FWL.TARGET_TEXT = "目標文字";
	FWL.TARGET_TEXT_TT = "你目標的計時文字顏色.";
	FWL.FOCUS_TEXT = "焦點文字";
	FWL.FOCUS_TEXT_TT = "你焦點的計時文字顏色.";
	FWL.COUNTDOWN_TEXT = "冷卻文字";
	FWL.COUNTDOWN_TEXT_TT = "";

	FWL.LABEL_FONT = "標籤字體";
	FWL.LABEL_FONT_TT = "物件標籤的字體. (當開啟按對象分類時)";
	FWL.UNIT_SPACING = "對象間距";
	FWL.UNIT_SPACING_TT = "不同物件計時條之間的間距. 只有當設定按物件分類計時條才有效.";
	FWL.UNIT_LABEL_HEIGHT = "對象標籤高度";
	FWL.UNIT_LABEL_HEIGHT_TT = "對象標籤的高度. (當開啟按對象分類時)";
	FWL.COUNTDOWN_WIDTH = "計時文字寬度";
	FWL.COUNTDOWN_WIDTH_TT = "你可以增加計時文字的寬度, 因為有時候計時文字可能顯示不完全.";
	FWL.MAXIMIZE_SPACE = "最大名字空間(醜)";
	FWL.MAXIMIZE_SPACE_TT = "物件/法術的空間最大化. 結果是這些文字將不會在計時條中間顯示. 當你把計時條設置非常短時有所幫助.";
	FWL.COUNTDOWN_ON_RIGHT = "右側顯示計時";
	FWL.COUNTDOWN_ON_RIGHT_TT = "在計時條左側或右側顯示計時.";

	FWL.ONEMAX = "統一上限時間";
	FWL.ONEMAX_TT = "所有的計時條都統一計時上限，就是所有的計時條的顯示計時上限都統一為當前的最大計時時間，這樣更容易看出施法計時.";
	FWL.FORCEMAX = "強制上限時間";
	FWL.FORCEMAX_TT = "所有的計時條都強制最大計時上限，哪怕計時上限長於最大的計時時間.";
	FWL.MAXTIME = "上限時間";
	FWL.MAXTIME_TT = "計時條顯示的上限時間.";

	FWL.DISPLAY_MODES7 = "按對象號分類";
	FWL.DISPLAY_MODES7_TT = "將一個物件的計時條排在一起顯示.";
	FWL.DISPLAY_MODES8 = "顯示物件號";
	FWL.DISPLAY_MODES8_TT = "在每個物件名字前顯示其編號. 有助於分辨出同名物件.";
	FWL.DISPLAY_MODES9 = "計時條顯示法術名";
	FWL.DISPLAY_MODES9_TT = "計時條將顯示法術名而不是目標名. 當按照物件分類選項開啟時,物件名將在每個分類條上顯示.";
	FWL.DISPLAY_MODES10 = "只顯示目標/焦點";
	FWL.DISPLAY_MODES10_TT = "所有的法術在背後仍然被追蹤,但是只顯示你目標和焦點的法術.";

	FWL.DISPLAY_TYPES1 = "顯示增強buffs";
	FWL.DISPLAY_TYPES1_TT = "計時條顯示增益buff.";
	FWL.DISPLAY_TYPES2 = "顯示暗影易傷";
	FWL.DISPLAY_TYPES2_TT = "顯示目標身上的類似暗影易傷的debuff作為自己的增強buff.";
	FWL.DISPLAY_TYPES3 = "計時閥值";
	FWL.DISPLAY_TYPES3_TT = "持續時間比這個時間長的法術不會在計時器裏顯示，當這些法術持續時間低於這個時間或者提前被移除時將會再次顯示，此外，被隱藏的法術在你重選定它時會顯示在你的目標上，因此你可以很容易看到有哪些法術存在，設置0則禁用.";
	FWL.DISPLAY_TYPES4 = "預備隱藏時間";
	FWL.DISPLAY_TYPES4_TT = "法術隱藏前的顯示時間.";
	FWL.DISPLAY_TYPES5 = "顯示失敗法術";
	FWL.DISPLAY_TYPES5_TT = "失敗法術仍在計時條顯示 (例如抵抗,免疫之類). 很有用.";
	FWL.DISPLAY_TYPES6 = "失敗法術顯示時間";
	FWL.DISPLAY_TYPES6_TT = "失敗法術在計時條上顯示時間.";
	FWL.DISPLAY_TYPES7 = "顯示傷害法術";
	FWL.DISPLAY_TYPES7_TT = "計時條中顯示你的傷害法術.";
	FWL.DISPLAY_TYPES8 = "顯示治療";
	FWL.DISPLAY_TYPES8_TT = "計時條中顯示你的HoTs.";
	FWL.DISPLAY_TYPES9 = "顯示友善法術";
	FWL.DISPLAY_TYPES9_TT = "計時條顯示你的友善法術.";
	FWL.DISPLAY_TYPES10 = "顯示Pet法術";
	FWL.DISPLAY_TYPES10_TT = "計時條顯示你的Pet法術.";
	FWL.DISPLAY_TYPES11 = "boss戰全顯示";
	FWL.DISPLAY_TYPES11_TT = "啟用這個選項，boss戰的時候顯示所有長計時法術";

	FWL.FADING1 = "法術結束前閃爍";
	FWL.FADING1_TT = "啟動此選項,計時條結束3秒前閃爍.先慢後快. 顏色不變";
	FWL.FADING2 = "計時條漸隱";
	FWL.FADING2_TT = "開啟後計時條平滑消失.";
	FWL.FADING3 = "漸隱消失時間";
	FWL.FADING3_TT = "計時結束,計時條漸隱持續時間";
	FWL.FADING4 = "漸隱時間";
	FWL.FADING4_TT = "計時條漸隱需用時間.";
	FWL.FADING5 = "高亮新釋放法術";
	FWL.FADING5_TT = "新釋放法術將高亮顯示,目的是為了分辨新釋放法術.";
	FWL.FADING6 = "沒有目標時的透明度";
	FWL.FADING6_TT = "當計時條顯示的不是你的目標或者焦點時,可以設置不同的透明度. 很容易分辨出自己的目標.";

	FWL.EXTRA1 = "顯示團隊圖示";
	FWL.EXTRA1_TT = "在物件計時條背景上顯示團隊圖示.";
	FWL.EXTRA2 = "團隊圖示透明度";
	FWL.EXTRA2_TT = "團隊圖示透明度.";
	FWL.EXTRA3 = "DOT判讀";
	FWL.EXTRA3_TT = "啟動此功能,計時條將查看你的戰鬥記錄DOT傷害,來判讀移除失效計時條.";
	FWL.EXTRA4 = "隊友判讀";
	FWL.EXTRA4_TT = "啟動此功能,計時條將查看你隊友的目標,來幫助判讀移除失效計時條.";
	FWL.EXTRA5 = "計時同步";
	FWL.EXTRA5_TT = "將法術計時和其對目標造成的buff/debuff計時同步，需要設置樣本技能.";
	FWL.EXTRA6 = "戰鬥結束後移除計時條";
	FWL.EXTRA6_TT = "每次離開戰鬥將NPC的計時條移除，也許有用吧.";

	
	FWL.HIGHLIGHT = "高亮";
	FWL.FAIL = "失敗";
	FWL.MAGIC_DOT = "DOT";
	FWL.CURSE = "詛咒";
	FWL.CC = "控制";
	FWL.POWERUP_BUFFS = "增強buffs";
	FWL.HEAL = "治療";
	FWL.FRIENDLY_BUFFS = "友善buffs";

	FWL.ST_CUSTOMIZE_TT = "自定義計時法術/buffs."
	FWL.FAILED_MESSAGE_COLOR = "失敗法術資訊";
	FWL.SHOW_FAILED = "顯示失敗法術";
	FWL.SHOW_FAILED_TT = "顯示由於抵抗,免疫等釋放失敗的法術.";

	FWL.SHORT_HIDE = "隱藏";
	FWL.SHORT_FADE = "消失";
	FWL.SHORT_REMOVED = "移除";
	FWL.SHORT_RESISTED = "抵抗";
	FWL.SHORT_IMMUNE = "免疫";
	FWL.SHORT_EVADED = "閃避";
	FWL.SHORT_REFLECTED = "反射";

	FWL.UPDATE_INTERVAL_SPELL_TIMER = "計時條更新間隔";
	FWL.DELAY_TARGET_DEBUFF_CHECK = "目標debuff檢查延遲";
	FWL.DELAY_DOT_TICKS_INIT = "DOT初始化延遲";
	FWL.DELAY_DOT_TICKS = "DoT延遲";

	FWL.TIME_LEFT = "顯示法術剩餘時間";

	FWL.NORMAL_TYPE = "普通";
	FWL.NORMAL_TYPE_TT = "普通法術計時";
	FWL.SHARED_TYPE = "公用";
	FWL.SHARED_TYPE_TT = "每種類型的法術只顯示一個計時條.";
	FWL.OTHER_DEBUFFS = "其他 Debuffs";
	FWL.OTHER_DEBUFFS_TT = "他人釋放的重要debuff，或者不是由你的法術直接觸發的debuff，只對當前目標有效.";
	FWL.CC_TT = "控制或者沉默法術";

	FWL.TICKS = "顯示DoT跳數";
	FWL.TICKS_TT = "顯示DoT剩餘跳數.";
	FWL.TICKS_NEXT = "顯示下一跳";
	FWL.TICKS_NEXT_TT = "只顯示計時條的的下一跳.";
	
	FWL.DRAIN = "吸取法術";
	FWL.DRAIN_TT = "顯示受到急速效果加成的吸取法術";

	FWL.FADE = "消退";
	FWL.BREAK = "打斷";
	FWL.RESIST = "抵抗";

	FWL.TICKS_COLOR = "跳數顏色";
	FWL.TICKS_COLOR_TT = "設置跳數顏色.";
	
	FWL.TIMER_OUTWARDS = "最長持續時間";
	FWL.TIMER_OUTWARDS_TT = "計時條記錄最長的法術持續時間.";
	FWL.TEST_BARS = "啟用測試計時條";
	FWL.TEST_BARS_TT = "測試計時條.";
	
	FWL.CAST_GLOW = "施法時間發光";
--[[>>]]FWL.CAST_GLOW_TT = "計時條顯示該法術施放的準備時間或者是施放後的公共CD，幫助計算施法時間，公共CD只有啟用'"..FWL.ONEMAX.."' 和冷卻計時條時顯示.";

	
	FWL.CUSTOM_TAG = "自訂標籤";
	FWL.CUSTOM_TAG_TT = "使用自訂計時條標籤.\n|cff00ff00id|r 替換目標id.\n|cff00ff00目標名|r 替換目標名字.\n|cff00ff00法術名|r 替換法術名字.\n|cff00ff00跳數|r 替換buff/debuff的跳數.";

	FWL.UNIQUE_TYPE = "單獨類型";
	FWL.UNIQUE_TYPE_TT = "只能在同一時間對一個目標使用的法術. 比如大多數控制技能.";
	

-- ENGLISH
else	-- standard english version
	FWL.SPELL_TIMER = "Spell Timer";
	FWL.DISPLAY_MODES = "Display Modes";
	FWL.EXTRA = "Extra";
	FWL.SHOW_HEADER = "Show header";
	FWL.DISPLAY_TYPES = "Display Types";
	FWL.TIMER_HIDING = "Hiding";

	FWL.ST_HINT1 = "Once you have set up the timer, you can lock it and hide its header.";
	FWL.ST_HINT2 = "Right-clicking a debuff icon will fill in that spell in the custom filter field.";
	FWL.ST_HINT3 = "When the timer is locked you will click through it.";

	FWL.ST_BASIC1_TT = "Visually enable the spell timer.";		
	FWL.ST_BASIC3_TT = "Showing the header can be usefull for setting up the timer, but there's no reason not to hide it. You can still drag the timer from the header spot if the header itself is hidden.";

	FWL.NORMAL_TEXT = "Normal text";
	FWL.NORMAL_TEXT_TT = "The color used for the texts belonging to any non-target/focus unit.";
	FWL.TARGET_TEXT = "Target text";
	FWL.TARGET_TEXT_TT = "The color used for the texts belonging to your target.";
	FWL.FOCUS_TEXT = "Focus text";
	FWL.FOCUS_TEXT_TT = "The color used for the texts belonging to your focus.";
	FWL.COUNTDOWN_TEXT = "Countdown text";
	FWL.COUNTDOWN_TEXT_TT = "";

	FWL.LABEL_FONT = "Label Font";
	FWL.LABEL_FONT_TT = "The font to use for the unit labels in between the bars. (if enabled)";
	FWL.UNIT_SPACING = "Unit spacing";
	FWL.UNIT_SPACING_TT = "The spacing between bar groups belonging to different units. Only applies when grouping by unit.";
	FWL.UNIT_LABEL_HEIGHT = "Unit label height";
	FWL.UNIT_LABEL_HEIGHT_TT = "The height of the unit labels in between the bars. (if enabled)";
	FWL.COUNTDOWN_WIDTH = "Countdown text width";
	FWL.COUNTDOWN_WIDTH_TT = "You can increase the width your countdown text takes up, in case the text doesnt always fit for some reason.";
	FWL.MAXIMIZE_SPACE = "Maximize name space (ugly)";
	FWL.MAXIMIZE_SPACE_TT = "Maximizes the space used for the unit/spell texts. As a result, these texts will no longer be displayed in the exact center of the bars. This can be usefull if you have very short bars.";
	FWL.COUNTDOWN_ON_RIGHT = "Count down on right";
	FWL.COUNTDOWN_ON_RIGHT_TT = "You can display the countdown text on the right or on the left of the timer bars.";
	
	FWL.ONEMAX = "Adapt to one maximum";
	FWL.ONEMAX_TT = "Adapt all bars to one maximum. In other words, all the bars will use the duration of the spell with the longest duration currently on the timer. This may make it easier to time spellcasts.";
	FWL.FORCEMAX = "Force maximum time";
	FWL.FORCEMAX_TT = "Forces the maximum time setting on all bars, even if the longest timer has a shorter duration.";
	FWL.MAXTIME = "Maximum time";
	FWL.MAXTIME_TT = "Maximum time that's displayed on a bar. This option is mostly there for making the 'one maximum' setting more practical.";
	
	FWL.DISPLAY_MODES7 = "Group by unit";
	FWL.DISPLAY_MODES7_TT = "Groups timers belonging to the same units together.";
	FWL.DISPLAY_MODES8 = "Show unit #";
	FWL.DISPLAY_MODES8_TT = "Shows the 'id' number of each unit in front of its name. This way you can distinguish between units with the same name.";
	FWL.DISPLAY_MODES9 = "Spells with unit label";
	FWL.DISPLAY_MODES9_TT = "This will display the names of your spells on the timer bars, instead of the target name. With the '"..FWL.DISPLAY_MODES7.."' option on, unit name tags will appear for each bar group.";
	FWL.DISPLAY_MODES10 = "Only show target/focus";
	FWL.DISPLAY_MODES10_TT = "All spells will still be tracked in the background, but you will only see those on your target or focus.";
	
	FWL.DISPLAY_TYPES1 = "Show powerup buffs";
	FWL.DISPLAY_TYPES1_TT = "The timer will also display beneficial powerup buffs.";
	FWL.DISPLAY_TYPES2 = "Show Vulnerability";
	FWL.DISPLAY_TYPES2_TT = "Show vulnerabilities like the Improved Shadowbolt debuff on your target as a powerup.";
	FWL.DISPLAY_TYPES3 = "Hide timers if remaining over";
	FWL.DISPLAY_TYPES3_TT = "Spells that still last longer than this time (seconds) will be hidden from the timer. They will be unhidden again when they get below this time or get removed early. In addition, hidden spells are again shown on your target when you reselect it, so it's still easy to see what spells are up.";
	FWL.DISPLAY_TYPES4 = "Pre-hide display time";
	FWL.DISPLAY_TYPES4_TT = "The time a spell is diplayed before being hidden.";
	FWL.DISPLAY_TYPES5 = "Show failed spells";
	FWL.DISPLAY_TYPES5_TT = "Also show failed spells on the timer (due to resist, immune etc). Very usefull visual aid.";
	FWL.DISPLAY_TYPES6 = "Failed display time";
	FWL.DISPLAY_TYPES6_TT = "The time a spell that failed is diplayed before fading away.";
	FWL.DISPLAY_TYPES7 = "Show harmful spells";
	FWL.DISPLAY_TYPES7_TT = "Show your harmfull spells in the Spell Timer.";
	FWL.DISPLAY_TYPES8 = "Show heals";
	FWL.DISPLAY_TYPES8_TT = "Show your HoTs in the Spell Timer.";
	FWL.DISPLAY_TYPES9 = "Show friendly spells";
	FWL.DISPLAY_TYPES9_TT = "Show your friendly spells in the Spell Timer.";
	FWL.DISPLAY_TYPES10 = "Show pet spells";
	FWL.DISPLAY_TYPES10_TT = "Show your pet's spells in the Spell Timer.";
	FWL.DISPLAY_TYPES11 = "No hiding on bosses";
	FWL.DISPLAY_TYPES11_TT = "Enable this option to keep all your longer spells visible on bosses.";
	
	FWL.FADING1 = "Blink expiring bars";
	FWL.FADING1_TT = "When enabled, bars expiring in 3 seconds will start to blink. First slow, fast in the end. A nice indication of expiring bars, without changing the actual color.";
	FWL.FADING2 = "Fade out bars";
	FWL.FADING2_TT = "When enabled, your timer bars will smoothly fade out.";
	FWL.FADING3 = "Standard fade delay";
	FWL.FADING3_TT = "The delay before a timer bar that already expired, starts fading out. Also known as 'ghost time'.";
	FWL.FADING4 = "Fade time";
	FWL.FADING4_TT = "The time it takes for the bars to fade out.";
	FWL.FADING5 = "Highlight new casts";
	FWL.FADING5_TT = "Newly cast spells will start out bright and change to their normal color in half a second. An extra aid to see where your newly cast spell appeared on the timer.";
	FWL.FADING6 = "Non-target alpha";
	FWL.FADING6_TT = "Timers that do not belong to your target or focus, can be displayed with a different transparency. This makes it very easy to see what unit you have currently selected.";

	FWL.EXTRA1 = "Show Raid Target Icons";
	FWL.EXTRA1_TT = "Show the raid target icon of each unit in the bar background.";
	FWL.EXTRA2 = "Raid Target Icons Alpha";
	FWL.EXTRA2_TT = "The alpha (transparency) of the raid target icons.";
	FWL.EXTRA3 = "Improve: Use dot ticks";
	FWL.EXTRA3_TT = "When enabled, the timer will watch your combat log for dot damage to help remove bars that no longer apply.";
	FWL.EXTRA4 = "Improve: Use party/raid targets";
	FWL.EXTRA4_TT = "When enabled, the timer will watch party/raid member targets to help remove bars that no longer apply.";
	FWL.EXTRA5 = "Synchronize durations";
	FWL.EXTRA5_TT = "Synchronize spell timer durations to the actual debuff/buff durations of their targets. This is needed for example for debuffs that can reset their duration through other abilities. The addon has never done this before, but currently debuff/buff information seems much more reliable.";
	FWL.EXTRA6 = "Remove mob timers after combat";
	FWL.EXTRA6_TT = "Every time you exit combat the addon will remove remaining timers belonging to NPCs. May be useful to disable this in some cases.";
	
	FWL.HIGHLIGHT = "Highlight";
	FWL.FAIL = "Fail";
	FWL.MAGIC_DOT = "Magic dot";
	FWL.CURSE = "Curse";
	--FWL.CC = "Crowd control";
	FWL.POWERUP_BUFFS = "Powerup buffs";
	FWL.HEAL = "Heal";
	FWL.FRIENDLY_BUFFS = "Friendly buffs";

	FWL.ST_CUSTOMIZE_TT = "Customize each of your spells or buffs.";
	FWL.FAILED_MESSAGE_COLOR = "Failed spell messages";
	FWL.SHOW_FAILED = "Show failed spells";
	FWL.SHOW_FAILED_TT = "Show spells that failed due to resist, immune etc.";

	FWL.SHORT_HIDE = "hide";
	FWL.SHORT_FADE = "fade";
	FWL.SHORT_REMOVED = "remo";
	FWL.SHORT_RESISTED = "resi";
	FWL.SHORT_IMMUNE = "immu";
	FWL.SHORT_EVADED = "evad";
	FWL.SHORT_REFLECTED = "refl";

	FWL.UPDATE_INTERVAL_SPELL_TIMER = "Update interval spell timer";
	FWL.DELAY_TARGET_DEBUFF_CHECK = "Delay target debuff check";
	FWL.DELAY_DOT_TICKS_INIT = "Delay dot ticks init";
	FWL.DELAY_DOT_TICKS = "Delay dot ticks";
	
	FWL.TIME_LEFT = "Announce fade time";
	
	FWL.NORMAL_TYPE = "Normal Type";
	FWL.NORMAL_TYPE_TT = "Normal Spell Types";
	FWL.SHARED_TYPE = "Shared Type";
	FWL.SHARED_TYPE_TT = "Types of spells that allow only one spell of this kind up on one target (for example Curses).";
	FWL.OTHER_DEBUFFS = "Raid debuffs";
	FWL.OTHER_DEBUFFS_TT = "This may be important debuffs cast by others, or debuffs that belong to you that aren't triggered directly by spellcasts. These are only shown for your current target.";
	--FWL.CC_TT = "Crowd control or silencing spells";

	FWL.TICKS = "Show Ticks";
	FWL.TICKS_TT = "Show remaining DoT ticks on the bars.";
	FWL.TICKS_NEXT = "Next Tick only";
	FWL.TICKS_NEXT_TT = "Only show the next Tick on the bars.";
	
	FWL.DRAIN = "Drain";
	FWL.DRAIN_TT = "Show Drain and some other Channeling spells.";
	
	FWL.FADE = "Fade";
	FWL.BREAK = "Break";
	FWL.RESIST = "Resist";
	
	FWL.TICKS_COLOR = "Tick color";
	FWL.TICKS_COLOR_TT = "Set the tick colors to any color you like.";
	
	FWL.TIMER_OUTWARDS = "Highest timers outwards";
	FWL.TIMER_OUTWARDS_TT = "Bars will be sorted with the longest remaining times the furthest from the spell timer header/anchor.";
	FWL.TEST_BARS = "Enable Test Bars";
	FWL.TEST_BARS_TT = "Enable Test Bars. This option makes it easier to configure the timer without having to cast on units. You still need to select units to test target/focus settings, but this can also be yourself.";

	FWL.CAST_GLOW = "Show cast time Glow";
	FWL.CAST_GLOW_TT = "The timer bars indicate the time it will take to cast this spell or how long global cooldown would take up after the cast. This makes it much easier to time spell casts. Global cooldown is only shown when '"..FWL.ONEMAX.."' is enabled.";

	FWL.CUSTOM_TAG = "Custom tag";
	FWL.CUSTOM_TAG_TT = "Use your own customized tag for the spell timer bars.\n|cff00ff00id|r is replaced by the target's id (if any).\n|cff00ff00target|r is replaced by the target unit name (if any).\n|cff00ff00spell|r is replaced by the spell name.\n|cff00ff00stacks|r is replaced by the number of stacks of the buff/debuff (if any).";

	FWL.UNIQUE_TYPE = "Unique Type";
	FWL.UNIQUE_TYPE_TT = "Types of spells that can only be cast on one target at a time. For example most crowd control spells.";
	
end

FWL.BAR_BG_ALPHA = "Empty bar alpha";
FWL.BAR_BG_ALPHA_TT = "The alpha the 'empty' part of a timer bar will have.";
FWL.TIMER_FORMATS = "Timer formats";
FWL.TIMER_UNITS = "Units";
FWL.TIMER_MAXIMUM_TIME = "Maximum time";
FWL.TIMER_TICKS = "Ticks";
FWL.TIMER_RAID_TARGET_ICONS = "Raid Target Icons";

FWL.TIMER_SHOW_TARGET = "Show target unit";
FWL.TIMER_SHOW_TARGET_TT = "Show the bars belonging to your current target in this timer frame instance.";
FWL.TIMER_SHOW_FOCUS = "Show focus unit";
FWL.TIMER_SHOW_FOCUS_TT = "Show the bars belonging to your current focus in this timer frame instance.";
FWL.TIMER_SHOW_OTHER = "Show other units";
FWL.TIMER_SHOW_OTHER_TT = "Show the bars belonging to all other units in this timer frame instance.";

FWL.COOLDOWNS = "Cooldowns";
FWL.COOLDOWNS_TT = "Show a small selection of cooldowns.";
FWL.DEBUFFS = "Debuffs on me";
FWL.DEBUFFS_TT = "Show a small selection of debuffs on yourself.";

FWL.TARGET_BACKGROUND = "Target background";
FWL.FOCUS_BACKGROUND = "Focus background";

FWL.EXPIRED = "Expired";
FWL.EXPIRED_TT = "Enable to make expired bars take a different color.";

FWL._RIGHTCLICK_FOR_OPTIONS = " (right-click for options)"