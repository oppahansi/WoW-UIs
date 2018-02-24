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
-- RU  by Papo
if GetLocale() == "ruRU" then
	
	FWL.MANA_POTION = "флакон с зельем маны$"; -- is All types [Огромный флакон с зельем маны]
	FWL.HEALING_POTION = "флакон с лечебным зельем$"; -- is All types [Огромный флакон с лечебным зельемГигантский флакон с лечебным зельем]
	FWL.PROTECTION_POTION = " зелье защиты от "; -- is All types [Мощное зелье защиты от темной магии, Сильное зелье защиты от тайной магии]
	FWL.SOULSTONE = "камень души$"; -- is All types [Демонический камень души]
	FWL.HEALTHSTONE = "камень здоровья$"; -- is All types [Демонический камень здоровья]

-- FR
elseif GetLocale() == "frFR" then

	FWL.MANA_POTION = "^Potion(.+)mana"; -- is All types
	FWL.HEALING_POTION = "^Potion(.+)soins"; -- is All types
	FWL.PROTECTION_POTION = "^Potion de protection"; -- is All types
	FWL.SOULSTONE = "^Pierre d'âme"; -- is All types
	FWL.HEALTHSTONE = "^Pierre de soins"; -- is All types

-- DE
elseif GetLocale() == "deDE" then

	FWL.MANA_POTION = "anatrank$"; -- is All types
	FWL.HEALING_POTION = "eiltrank$"; -- is All types
	FWL.PROTECTION_POTION = "schutztrank$"; -- is All types
	FWL.SOULSTONE = "Seelenstein$"; -- is All types
	FWL.HEALTHSTONE = "Gesundheitsstein$"; -- is All types

-- SPANISH By Intxixu - SPQR - Tyrande
elseif GetLocale() == "esES" then

	FWL.MANA_POTION = "^Poción de maná"; -- is All types
	FWL.HEALING_POTION = "^Poción de sanación"; -- is All types
	FWL.PROTECTION_POTION = "^Poción de protección"; -- is All types
	FWL.SOULSTONE = "^Piedra de alma"; -- is All types
	FWL.HEALTHSTONE = "^Piedra de salud"; -- is All types

-- Simple Chinese
elseif GetLocale() == "zhCN" then
	FWL.MANA_POTION = "法力药水$"; -- is All types
	FWL.HEALING_POTION = "治疗药水$"; -- is All types
	FWL.PROTECTION_POTION = "防护药水$"; -- is All types
	FWL.SOULSTONE = "灵魂石$"; -- is All types
	FWL.HEALTHSTONE = "治疗石$"; -- is All types

-- tradition Chinese
elseif GetLocale() == "zhTW" then

	FWL.MANA_POTION = "法力藥水$"; -- is All types
	FWL.HEALING_POTION = "治療藥水$"; -- is All types
	FWL.PROTECTION_POTION = "防護藥水$"; -- is All types
	FWL.SOULSTONE = "靈魂石$"; -- is All types
	FWL.HEALTHSTONE = "治療石$"; -- is All types

-- ENGLISH
else	-- standard english version
	
	FWL.MANA_POTION = "Mana Potion$"; -- is All types
	FWL.HEALING_POTION = "Healing Potion$"; -- is All types
	FWL.PROTECTION_POTION = "Protection Potion$"; -- is All types
	FWL.SOULSTONE = "Soulstone$"; -- is All types
	FWL.HEALTHSTONE = "Healthstone$"; -- is All types
end

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

-- ruRU
if GetLocale() == "ruRU" then
	FWL.COOLDOWN_TIMER = "Таймер восстановления";

	FWL.CD_HINT1 = "Использовать прозрачность в настройках цвета для скрытия/отображения текстов и других элементов.";
	FWL.CD_HINT2 = "Использовать опцию 'Настроить' для игнорирования кулдаунов или изменения цвета. Щелкните правой кнопкой по значку для игнорирования.";
--[[>>]]FWL.CD_HINT3 = "When the bar is locked you will click through it.";

	FWL.CD_BASIC1_TT = "Включить отображение таймера восстановления.";		

	FWL.CD_CUSTOMIZE_TT = "Настроить каждый из ваших кулдаунов.";

	FWL.CD_SPECIFIC1 = "Щелкните правой кнопкой по значкам для игнорирования.";
	FWL.CD_SPECIFIC1_TT = "Щелчок правой кнопкой мыши по значку на панели кулдаунов, поместит его в список игнорирования. Вы можете удалить его из этого списка используя опции настройки.";
	FWL.CD_SPECIFIC2 = "Перевернуть по вертикали";
	FWL.CD_SPECIFIC2_TT = "Изменить ориентацию панели с горизотальной на вертикальную.";
	FWL.CD_SPECIFIC3 = "Автоматически скрывать когда нет кулдаунов.";
	FWL.CD_SPECIFIC3_TT = "Скрыть шкалу таймера восстановления и фон, когда нет видимых кулдаунов.";
	FWL.CD_SPECIFIC5 = "Детальная шкала";
	FWL.CD_SPECIFIC5_TT = "Вы получите несколько дополнительных точек масштаба времени на панели восстановления. Полезно, если вы изменили масштаб времени на что-то, значительно меньше 60 минут.";
	FWL.CD_SPECIFIC6 = "Максимум шкалы времени (сек)";
	FWL.CD_SPECIFIC6_TT = "Установка шкалы панели восстановления заданием времени максимального кулдауна в секундах(!), который панель должна отображать. Кулдауны вне шкалы будут отображаться в конце панели.";
	FWL.CD_SPECIFIC7 = "Отобразить баффы.";
	FWL.CD_SPECIFIC7_TT = "Таймер восстановления также будет показывать некоторые собственные баффы.";
	FWL.CD_SPECIFIC8 = "Перевернуть направление панели";
	FWL.CD_SPECIFIC8_TT = "Перевернуть направление панели таймера.";
	FWL.CD_SPECIFIC9 = "Минимальная прозрачность панели";
	FWL.CD_SPECIFIC9_TT = "Это видимость (прозрачность) для панели с максимальной длительностью  кулдауна. Иными словами, минимальная прозрачность, которую может иметь панель.";
	
	FWL.CD_SPLASH = "Вспыхивание значков";
	FWL.CD_SPLASH1 = "Вспыхивание истекших кулдаунов";
	FWL.CD_SPLASH1_TT = "Эта опция задает отображение вспышки значка в начале таймера восстановления каждый раз, когда кулдаун истечет.";
	FWL.CD_SPLASH2 = "Коэффициент вспыхивания значков.";
	FWL.CD_SPLASH2_TT = "Задание максимального коэффициента масштаба для использования при вспышках значков.";
	FWL.CD_SPLASH3 = "Разрешить вспыхивание вторичных значков";
	FWL.CD_SPLASH3_TT = "Этот значок вспышки может быть перетащен куда угодно в вашем интерфейсе. Разблокируйте его для задания его положения (зажмите ALT для перетаскивания!).";
	FWL.CD_SPLASH4 = "Заблокировать вторичный значок вспышки";
	FWL.CD_SPLASH4_TT = "Блокирование значка вспышки сделает невозможным любое взаимодействие с ним.  Locking the splash icon will disable any interaction with it. Разблокируйте его для задания его положения (зажмите ALT для перетаскивания!).";
	FWL.CD_SPLASH5 = "Минимальный размер вторичной вспышки";
	FWL.CD_SPLASH5_TT = "Вспыхнувший значок мягко уменьшится и опять увеличится. Это размер, начиная с которого значок начнет расти и к которому он опять уменьшится.";
	FWL.CD_SPLASH6 = "Максимальный размер вторичной вспышки";
	FWL.CD_SPLASH6_TT = "Вспыхнувший значок мягко уменьшится и опять увеличится. Это размер, начиная до которого значок выростет, прежде чем начнет уменьшаться.";
	FWL.CD_SPLASH7 = "Прозрачность вторичной вспышки";	
	FWL.CD_SPLASH7_TT = "Вспыхнувший значок мягко уменьшится и опять увеличится. Это наибольшая видимость (прозрачность) значка.";
	
	FWL.RESURRECT_TIMER = "Таймер воскрешения";
	FWL.BUFF = "Бафф";
	FWL.SS = "Камень души";
--[[>>]]FWL.DEBUFF = "Debuff";

	FWL.ICON_FONT = "Шрифт значка";
	FWL.ICON_TEXT = "Текст значка";
	FWL.ICON_TEXT_TT = "Это время, отображаемое на самих значках. Для его отображения, измените прознрачность текста.";

--[[>>]]FWL.SHOW_GLOW = "Show icon Glow";
--[[>>]]FWL.SHOW_GLOW_TT = "Show a glow around the icons that matches the bar color.";
--[[>>]]FWL.WEAPON_ENCHANT = "Weapon Enchant";
--[[>>]]FWL.COOLDOWN_LEFT = "Announce cooldown time";

--[[>>]]FWL.MASTER_ICONS = "Group Master Icons";
--[[>>]]FWL.MASTER_ICONS_TT = "With this option enabled, some abilities that share the same cooldown will be grouped under one master icon (instead of fading between all icons)";

--[[>>]]FWL.SECONDARY_SPLASH = "Secondary Splash";

--[[>>]]FWL.CD_SPLASH_HINT1 = "The Secondary Splash Icon currently uses all the type/filter settings from the Cooldown Timer."
--[[>>]]FWL.CD_SPLASH_HINT2 = "The splash icon will smoothly fade in and out again. The frame alpha sets its maximum visibility.";

--[[>>]]FWL.CD_WARNING = "Spell on cooldown Warning";
--[[>>]]FWL.CD_WARNING_TT = "When you try to use an ability that is on cooldown, the timer will focus on this ability.";

--[[>>]]FWL.CD_WEAPON_ENCHANT_MAIN = "Weapon Enchant (main-hand)";
--[[>>]]FWL.CD_WEAPON_ENCHANT_OFFHAND = "Weapon Enchant (off-hand)";
	
-- Simple Chinese
elseif GetLocale() == "zhCN" then

	FWL.COOLDOWN_TIMER = "冷却计时";

	FWL.CD_HINT1 = "设置颜色时使用透明度控制文字和其他部分的显示.";
	FWL.CD_HINT2 = "使用自定义选项屏蔽冷却或者改变颜色,右键点击屏蔽.";
	FWL.CD_HINT3 = "bar锁定时不受点击影响.";

	FWL.CD_BASIC1_TT = "显示冷却计时条.";		

	FWL.CD_CUSTOMIZE_TT = "自定义你的冷却技能.";

	FWL.CD_SPECIFIC1 = "右击图标屏蔽";
	FWL.CD_SPECIFIC1_TT = "右键点击图标屏蔽此技能冷却显示,在自定义选项中可以设定解除屏蔽.";
	FWL.CD_SPECIFIC2 = "竖向显示";
	FWL.CD_SPECIFIC2_TT = "冷却条竖向显示.";
	FWL.CD_SPECIFIC3 = "没有冷却时隐藏";
	FWL.CD_SPECIFIC3_TT = "当冷却条没有冷却显示时自动隐藏.";
	FWL.CD_SPECIFIC5 = "小时间刻度";
	FWL.CD_SPECIFIC5_TT = "冷却条上显示更详细的时间刻度,如果你的时间显示长度远小于60M时很有帮助.";
	FWL.CD_SPECIFIC6 = "最大计时长度(秒)";
	FWL.CD_SPECIFIC6_TT = "设定冷却条显示的最大冷却计时长度,单位为秒,超过这个时间的冷却技能也会在冷却条开始端显示.";
	FWL.CD_SPECIFIC7 = "显示Buffs";
	FWL.CD_SPECIFIC7_TT = "冷却计时同样会显示某些特定的自身buff";
	FWL.CD_SPECIFIC8 = "冷却计时方向";
	FWL.CD_SPECIFIC8_TT = "转换冷却计时的移动方向.";
	FWL.CD_SPECIFIC9 = "冷却条最小透明度";
	FWL.CD_SPECIFIC9_TT = "这个是冷却条最大冷却时间时的可见度，也就是冷却条的最小可见度。";
	
	FWL.CD_SPLASH = "图标闪动"; 
	FWL.CD_SPLASH1 = "结束时闪动";
	FWL.CD_SPLASH1_TT = "每个技能冷却结束后显示一个闪动效果(JCC效果).";
	FWL.CD_SPLASH2 = "闪光大小";
	FWL.CD_SPLASH2_TT = "设定图标闪动的最大比例.";
	FWL.CD_SPLASH3 = "启用副闪动图标";
	FWL.CD_SPLASH3_TT = "这个闪动图标你可以拖放到界面的任意位置（解锁后按住ALT拖放）";
	FWL.CD_SPLASH4 = "锁定副闪动图标";
	FWL.CD_SPLASH4_TT = "锁定图标对任何操作都无效，解锁后按住ALT可以拖放";
	FWL.CD_SPLASH5 = "副闪动图标最小尺寸";
	FWL.CD_SPLASH5_TT = "图标会放大缩小的闪动，这个尺寸是图标开始放大和最后缩小的尺寸.";
	FWL.CD_SPLASH6 = "副闪动图标最大尺寸";
	FWL.CD_SPLASH6_TT = "图标会放大缩小的闪动，这个尺寸是图标放大的最大尺寸.";
	FWL.CD_SPLASH7 = "副闪动图标透明度";	
	FWL.CD_SPLASH7_TT = "图标会放大缩小的闪动，这个是图标闪动时的最大可见度.";
	
	FWL.RESURRECT_TIMER = "复活计时";
	FWL.SS = "灵魂石";
	FWL.BUFF = "Buff";
	FWL.DEBUFF = "Debuff";

	FWL.ICON_FONT = "冷却字体";
	FWL.ICON_TEXT = "冷却时间";
	FWL.ICON_TEXT_TT = "这个显示技能冷却的时间,想显示具体时间,请设置好文字颜色的透明度.";

	FWL.UPDATE_INTERVAL_BUFFS = "更新buff扫描间隔";
	
	FWL.SHOW_GLOW = "图标发光";
	FWL.SHOW_GLOW_TT = "在图标周围显示一圈与bar颜色相同的关.";
	FWL.WEAPON_ENCHANT = "武器增强";
	FWL.COOLDOWN_LEFT = "通告冷却时间";

	FWL.MASTER_ICONS = "团长图标";
	FWL.MASTER_ICONS_TT = "启用后，某些共享冷却的技能会在此显示";
	
	FWL.SECONDARY_SPLASH = "二次闪光";

	FWL.CD_SPLASH_HINT1 = "二次闪光共用冷却条设置."
	FWL.CD_SPLASH_HINT2 = "闪光图标会快速闪动，透明度设为最大.";

	FWL.CD_WARNING = "技能冷却警告";
	FWL.CD_WARNING_TT = "当你想使用的技能在冷却条上时，该技能会突出显示.";

	FWL.CD_WEAPON_ENCHANT_MAIN = "主手武器增强";
	FWL.CD_WEAPON_ENCHANT_OFFHAND = "副手武器增强";	

-- tradition Chinese
elseif GetLocale() == "zhTW" then	

	FWL.COOLDOWN_TIMER = "冷卻計時";

	FWL.CD_HINT1 = "設置顏色時使用透明度控制文字和其他部分的顯示.";
	FWL.CD_HINT2 = "使用自定義選項遮罩冷卻或者改變顏色,右鍵點擊遮罩.";
	FWL.CD_HINT3 = "bar鎖定時不受點擊影響.";

	FWL.CD_BASIC1_TT = "顯示冷卻計時條.";		

	FWL.CD_CUSTOMIZE_TT = "自定義你的冷卻技能.";

	FWL.CD_SPECIFIC1 = "右擊圖示遮罩";
	FWL.CD_SPECIFIC1_TT = "右鍵點擊圖示遮罩此技能冷卻顯示,在自定義選項中可以設定解除遮罩.";
	FWL.CD_SPECIFIC2 = "豎向顯示";
	FWL.CD_SPECIFIC2_TT = "冷卻條豎向顯示.";
	FWL.CD_SPECIFIC3 = "沒有冷卻時隱藏";
	FWL.CD_SPECIFIC3_TT = "當冷卻條沒有冷卻顯示時自動隱藏.";
	FWL.CD_SPECIFIC5 = "小時間刻度";
	FWL.CD_SPECIFIC5_TT = "冷卻條上顯示更詳細的時間刻度,如果你的時間顯示長度遠小於60M時很有幫助.";
	FWL.CD_SPECIFIC6 = "最大計時長度(秒)";
	FWL.CD_SPECIFIC6_TT = "設定冷卻條顯示的最大冷卻計時長度,單位為秒,超過這個時間的冷卻技能也會在冷卻條開始端顯示.";
	FWL.CD_SPECIFIC7 = "顯示Buffs";
	FWL.CD_SPECIFIC7_TT = "冷卻計時同樣會顯示某些特定的自身buff";
	FWL.CD_SPECIFIC8 = "冷卻計時方向";
	FWL.CD_SPECIFIC8_TT = "轉換冷卻計時的移動方向.";
	FWL.CD_SPECIFIC9 = "冷卻條最小透明度";
	FWL.CD_SPECIFIC9_TT = "這個是冷卻條最大冷卻時間時的可見度，也就是冷卻條的最小可見度。";
	
	FWL.CD_SPLASH = "圖示閃動";
	FWL.CD_SPLASH1 = "結束時閃動";
	FWL.CD_SPLASH1_TT = "每個技能冷卻結束後顯示一個閃動效果(JCC效果).";
	FWL.CD_SPLASH2 = "閃光大小";
	FWL.CD_SPLASH2_TT = "設定圖示閃動的最大比例.";
	FWL.CD_SPLASH3 = "啟用副閃動圖示";
	FWL.CD_SPLASH3_TT = "這個閃動圖示你可以拖放到介面的任意位置（解鎖後按住ALT拖放）";
	FWL.CD_SPLASH4 = "鎖定副閃動圖示";
	FWL.CD_SPLASH4_TT = "鎖定圖示對任何操作都無效，解鎖後按住ALT可以拖放";
	FWL.CD_SPLASH5 = "副閃動圖示最小尺寸";
	FWL.CD_SPLASH5_TT = "圖示會放大縮小的閃動，這個尺寸是圖示開始放大和最後縮小的尺寸.";
	FWL.CD_SPLASH6 = "副閃動圖示最大尺寸";
	FWL.CD_SPLASH6_TT = "圖示會放大縮小的閃動，這個尺寸是圖示放大的最大尺寸.";
	FWL.CD_SPLASH7 = "副閃動圖示透明度";	
	FWL.CD_SPLASH7_TT = "圖示會放大縮小的閃動，這個是圖示閃動時的最大可見度.";

	
	FWL.RESURRECT_TIMER = "復活計時";
	FWL.SS = "靈魂石";
	FWL.BUFF = "Buff";
	FWL.DEBUFF = "Debuff";

	FWL.ICON_FONT = "冷卻字體";
	FWL.ICON_TEXT = "冷卻時間";
	FWL.ICON_TEXT_TT = "這個顯示技能冷卻的時間,想顯示具體時間,請設置好文字顏色的透明度.";

	FWL.UPDATE_INTERVAL_BUFFS = "更新buffs掃描間隔";

	FWL.SHOW_GLOW = "圖示發光";
	FWL.SHOW_GLOW_TT = "在圖示周圍顯示一圈與bar顏色相同的關.";
	FWL.WEAPON_ENCHANT = "武器增強";
	FWL.COOLDOWN_LEFT = "通告冷卻時間";

	FWL.MASTER_ICONS = "團長圖示";
	FWL.MASTER_ICONS_TT = "啟用後，某些共用冷卻的技能會在此顯示";
	
	FWL.SECONDARY_SPLASH = "二次閃光";

	FWL.CD_SPLASH_HINT1 = "二次閃光共用冷卻條設置."
	FWL.CD_SPLASH_HINT2 = "閃光圖示會快速閃動，透明度設為最大.";

	FWL.CD_WARNING = "技能冷卻警告";
	FWL.CD_WARNING_TT = "當你想使用的技能在冷卻條上時，該技能會突出顯示.";

	FWL.CD_WEAPON_ENCHANT_MAIN = "主手武器增強";
	FWL.CD_WEAPON_ENCHANT_OFFHAND = "副手武器增強";	

else

	FWL.COOLDOWN_TIMER = "Cooldown Timer";

	FWL.CD_HINT1 = "Use alpha in the color settings to hide/show texts and other parts.";
	FWL.CD_HINT2 = "Use the 'Customize' option to ignore cooldowns or change a color. Right-click an icon to ignore.";
	FWL.CD_HINT3 = "When the bar is locked you will click through it.";

	FWL.CD_BASIC1_TT = "Visually enable the cooldown timer.";		
	FWL.CD_CUSTOMIZE_TT = "Customize each of your cooldowns.";

	FWL.CD_SPECIFIC1 = "Right-click icons to ignore";
	FWL.CD_SPECIFIC1_TT = "Right-clicking an icon on the cooldown bar will put it on ignore. You can remove it from ignore using the customization option.";
	FWL.CD_SPECIFIC2 = "Flip to vertical";
	FWL.CD_SPECIFIC2_TT = "Change the bar orientation from horizontal to vertical.";
	FWL.CD_SPECIFIC3 = "Auto-hide when no cooldowns";
	FWL.CD_SPECIFIC3_TT = "Hide the cooldown timer scale and background when you have no visible cooldowns.";
	FWL.CD_SPECIFIC5 = "Detail scale";
	FWL.CD_SPECIFIC5_TT = "You will receive some extra time scale points on the cooldown bar. Useful if you have changed the time scale to something a lot smaller than 60 minutes.";
	FWL.CD_SPECIFIC6 = "Time scale max (sec)";
	FWL.CD_SPECIFIC6_TT = "Set the scale of the cooldown bar, by giving the biggest cooldown time in seconds(!) that the bar should display. Cooldowns outside your scale will still show at the end of the bar.";
	FWL.CD_SPECIFIC7 = "Show Buffs";
	FWL.CD_SPECIFIC7_TT = "The cooldown timer will also show certain self buffs.";
	FWL.CD_SPECIFIC8 = "Flip bar direction";
	FWL.CD_SPECIFIC8_TT = "Flip the timer bar direction.";
	FWL.CD_SPECIFIC8 = "Flip bar direction";
	FWL.CD_SPECIFIC8_TT = "Flip the timer bar direction.";
	FWL.CD_SPECIFIC9 = "Minimum bar alpha";
	FWL.CD_SPECIFIC9_TT = "This is the visibility (alpha) for a bar at its maximum cooldown duration. In other words, the minimum visibility a bar can get.";
	
	FWL.CD_SPLASH = "Splash Icons";
	FWL.CD_SPLASH1 = "Splash ready cooldowns";
	FWL.CD_SPLASH1_TT = "This will show an icon 'splash' at the origin of the cooldown timer each time a cooldown is ready.";
	FWL.CD_SPLASH2 = "Splash icon Factor";
	FWL.CD_SPLASH2_TT = "Set what maximum scale factor to use for the icon splash.";
	FWL.CD_SPLASH3 = "Enable Secondary Splash icon";
	FWL.CD_SPLASH3_TT = "This splash icon can be moved to anywhere in your interface. Unlock it to position it.";
	FWL.CD_SPLASH4 = "Lock Secondary Splash icon";
	FWL.CD_SPLASH4_TT = "Locking the splash icon will disable any interaction with it. Unlock it to position it.";
	FWL.CD_SPLASH5 = "Secondary Splash Minimum scale";
	FWL.CD_SPLASH5_TT = "The splash icon will smoothly fade in and out again. This is the scale from which the icon starts to grow and fades back to again.";
	FWL.CD_SPLASH6 = "Secondary Splash Maximum scale";
	FWL.CD_SPLASH6_TT = "The splash icon will smoothly fade in and out again. This is the scale to which the icon will grow and then fade away again.";

	FWL.RESURRECT_TIMER = "Resurrect Timer";
	FWL.SS = "Soulstone";
	FWL.BUFF = "Buff";
	FWL.DEBUFF = "Debuff";

	FWL.ICON_FONT = "Icon Font";
	FWL.ICON_TEXT = "Icon text";
	FWL.ICON_TEXT_TT = "This is the time text on the cooldown icons themselves. To show these, change the text color transparency.";

	FWL.UPDATE_INTERVAL_BUFFS = "Update interval buffs";
	
	FWL.SHOW_GLOW = "Show icon Glow";
	FWL.SHOW_GLOW_TT = "Show a glow around the icons that matches the bar color.";
	FWL.WEAPON_ENCHANT = "Weapon Enchant";

	FWL.COOLDOWN_LEFT = "Announce cooldown time";

	FWL.MASTER_ICONS = "Group Master Icons";
	FWL.MASTER_ICONS_TT = "With this option enabled, some abilities that share the same cooldown will be grouped under one master icon (instead of fading between all icons)";

	FWL.SECONDARY_SPLASH = "Secondary Splash";

	FWL.CD_SPLASH_HINT1 = "The Secondary Splash Icon currently uses all the type/filter settings from the Cooldown Timer."
	FWL.CD_SPLASH_HINT2 = "The splash icon will smoothly fade in and out again. The frame alpha sets its maximum visibility.";

	FWL.CD_WARNING = "Spell on cooldown Warning";
	FWL.CD_WARNING_TT = "When you try to use an ability that is on cooldown, the timer will focus on this ability.";

	FWL.CD_WEAPON_ENCHANT_MAIN = "Weapon Enchant (main-hand)";
	FWL.CD_WEAPON_ENCHANT_OFFHAND = "Weapon Enchant (off-hand)";
	
end

FWL.CD_SPECIFIC10 = "Maximum bar alpha";
FWL.CD_SPECIFIC10_TT = "This is the visibility (alpha) for a bar at its minimum cooldown duration. In other words, the maximum visibility a bar can get.";
FWL.USE_POWER_OF = "Use power of";
FWL.USE_POWER_OF_TT = "Setting this to a lower value means the Cooldown icons will speed up toward the end faster. Setting this to 1.0 means the Cooldown icons will have a constant speed.";
FWL.NUM_TIME_TAGS = "Amount of time tags";
FWL.NUM_TIME_TAGS_TT = "The number of time tags that will be visible in the background of the Cooldown bar.";
FWL.CUSTOM_TAGS = "Custom tags";
FWL.CUSTOM_TAGS_TT = "Instead of the addon generating time tags on equal intervals, you can also choose to specify at what times the tags have to be located.";
