-- Translated by StingerSoft.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Chatter", "ruRU")
if not L then return end

-- ./Chatter.lua
L["Standalone Config"] = "Меню настроек"
L["Open a standalone config window. You might consider installing |cffffff00BetterBlizzOptions|r to make the Blizzard UI options panel resizable."] = "Open a standalone config window. You might consider installing |cffffff00BetterBlizzOptions|r to make the Blizzard UI options panel resizable."
L["Configure"] = "Настройки"
L["Modules"] = "Модули"
L["Module"] = "Модуль"
L["Settings"] = "Настройки"
L["Enable "] = "Вкл. "
L["Enabled"] = "Включен"
L["Disabled"] = "Отключен"
L["Chatter Settings"] = "Настройки Chatterа"
L["Welcome to Chatter! Type /chatter to configure."] = "Добро пожаловать в Chatter! Для настроек введите /chatter"

-- ./Modules/AltNames.lua
L["Alt Linking"] = "Ссылка на альтов"
L["Use PlayerNames coloring"] = "Использовать окраску по именам игрока"
L["Use custom color"] = "Пользовательский цвет"
L["Use channel color"] = "Цвет канала"
L["Name color"] = "Цвет имени"
L["Set the coloring mode for alt names"] = "Установите тип окраски для имен альтов"
L["Custom color"] = "Спец.цвет"
L["Select the custom color to use for alt names"] = "Выберите спец. цвет для отображения имен альтов"
L["Who is %s's main?"] = "Кто основной %s'а?"
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name."] = "Включает нажатие ПКМ по имени персонажа в чате, запись заметки для отображение а чате, о имени основного персонажа."
L["Set Main"] = "Назн. основного"

-- ./Modules/AutoLogChat.lua
L["Chat Autolog"] = "Авто чат"
L["Automatically turns on chat logging."] = "Автоматическое включения чата при входе"

-- ./Modules/Buttons.lua
L["Disable Buttons"] = "Отключить кнопки"
L["Show bottom when scrolled"] = "В нижней части когда прокручивается"
L["Show bottom button when scrolled up"] = "Показывать кнопки в нижней части когда прокручивается вверх"
L["Hides the buttons attached to the chat frame"] = "Скрыть прикрепленные к окну чата кнопки"

-- ./Modules/ChannelColors.lua
L["Channel Colors"] = "Цвета каналов"
L["Keeps your channel colors by name rather than by number."] = "Хранит ваши цвета канала по имени а не по номеру."
L["Other Channels"] = "Другие каналы"
L["Yell"] = "Крик"
L["Guild"] = "Гильдия"
L["Officer"] = "Офицерский"
L["Raid"] = "Рейд"
L["Party"] = "Греппа"
L["Raid Warning"] = "Объявление рейду"
L["Say"] = "Сказать"
L["Battleground"] = "Поля сражений"
L["Whisper"] = "Шепот"
L["Select a color for this channel"] = "Выберите цвет для данного канала"

-- ./Modules/ChannelNames.lua
L["Channel Names"] = "Имена каналов"
L["Raid Leader"] = "Рейд лидер"
L["LookingForGroup"] = "Поиск групп"
L["Battleground Leader"] = "Лидер поля сражений"
L["Custom Channels"] = "Пользовательские каналы"
L["Add space after channels"] = "Добавить пропуск после каналов"
L["Replace this channel name with..."] = "Заменить название данного канала на..."
L["^To "] = "^к "
L["^(.-|h) whispers:"] = "^(.-|h) шепчет:"
L["Enables you to replace channel names with your own names"] = "Включает возможность замены названий каналов на ваши собственные"

-- ./Modules/ChatFading.lua
L["Disable Fading"] = "Отключить затухание"
L["Makes old text disappear rather than fade out"] = "Заставляет старый текст исчезнуть быстрее чем затухать"

-- ./Modules/ChatFont.lua
L["Chat Font"] = "Шрифт чата"
L["Font"] = "Шрифт"
L["Font size"] = "Размер шрифта"
L["Font Outline"] = "Контур шрифта"
L["Font outlining"] = "Контур шрифта"
L["Chat Frame "] = "Окно чата"
L["Enables you to set a custom font and font size for your chat frames"] = "Включает возможность настройки шрифта, его размера в ваших окнах чата"

-- ./Modules/ChatFrameBorders.lua
L["Borders/Background"] = "Края/Фон"
L["Enable"] = "Включить"
L["Enable borders on this frame"] = "Включить края в данном окне"
L["Combat Log Fix"] = "Фикс Журнала боя"
L["Resize this border to fit the new combat log"] = "Изменить размеры данного края для заполнения нового журнала сражений"
L["Background texture"] = "Текстура фона"
L["Border texture"] = "Текстура края"
L["Background color"] = "Цвет фона"
L["Border color"] = "Цвет края"
L["Background Inset"] = "Фон Вкладки"
L["Tile Size"] = "Размер заголовка"
L["Edge Size"] = "Размер края"
L["Gives you finer control over the chat frame's background and border colors"] = "Позволяет вам настроить фон окон чата и цвета краев"

-- ./Modules/ChatLink.Lua
L["Chat Link"] = "Ссылки чата"
L["Lets you link items, enchants, spells, and quests in custom channels."] = "Позволяет вам показывать предметы, зачерования, заклинания и задания в пользовательских каналах."
L["Trade -"] = "Торговля: "

-- ./Modules/ChatScroll.lua
L["Mousewheel Scroll"] = "Прокручивать колесом-мыши"
L["Scroll lines"] = "Прокрутка строк"
L["How many lines to scroll per mouse wheel click"] = "Сколько строк будет прокручиваться при клике колесика мыши"
L["Lets you use the mousewheel to page up and down chat."] = "Позволяет вам использовать колесо-выми для прокрутки цато вверх и вниз."

-- ./Modules/ChatTabs.lua
L["Chat Tabs"] = "Закладки чата"
L["Button Height"] = "Высота кнопки"
L["Button's height, and text offset from the frame"] = "Высота кнопок, и смещение текста из окна"
L["Hide Tabs"] = "Скрыть закладки"
L["Hides chat frame tabs"] = "Скрыть закладки окна чата"

-- ./Modules/ClickInvite.lua
L["Invite Links"] = "Ссылки приглашений"
L["Add Word"] = "Добавить слово"
L["Add word to your invite trigger list"] = "Добавить слово для вашего списка триггеров приглашений"
L["Remove Word"] = "Удалить слово"
L["Remove a word from your invite trigger list"] = "Удалить слово из вашего списка триггеров приглошений"
L["Remove this word from your trigger list?"] = "Удалить данное слово из вашего списка триггеров?"
L["Alt-click name to invite"] = "Alt-клик по имени для приглошения"
L["Lets you alt-click player names to invite them to your party."] = "Позволяет вам alt-кликнув по имени игрока приглосить того в группу."
L["invite"] = "пригласи"
L["inv"] = "инв"
L["Gives you more flexibility in how you invite people to your group."] = "Дает вам больше возможностей принятия людей в вашу группу."

-- ./Modules/CopyChat.lua
L["Copy Chat"] = "Копирование чата"
L["Copy text from this frame."] = "Копировать текст из данного окна."
L["Lets you copy text out of your chat frames."] = "Позволяет вам копировать текст из ваших окон чата."

-- ./Modules/EditBox.lua
L["Edit Box Polish"] = "Блеск поле ввода"
L["Top"] = "Сверху"
L["Bottom"] = "Снизу"
L["Free-floating"] = "Свободно-плавучий"
L["Free-floating, Locked"] = "Свободно-плавучий, Зафиксирован"
L["Attach to..."] = "Прикрепить к..."
L["Attach edit box to..."] = "Прикрепить поле ввода к..."
L["Color border by channel"] = "Цвет краев по каналу"
L["Sets the frame's border color to the color of your currently active channel"] = "Sets the frame's border color to the color of your currently active channel"
L["Use Alt key for cursor movement"] = "Alt клавиша для переджинения курсива"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Requires the Alt key to be held down to move the cursor in chat"
L["Select the font to use for the edit box"] = "Выберите шрифт для использования в поле ввода"
L["Lets you customize the position and look of the edit box"] = "Позволяет вам настроить вид и позицию поля ввода"

-- ./Modules/GroupSay.lua
L["Group Say (/gr)"] = "Сказать в группу (/gr)"
L["Provides a /gr slash command to let you speak in your group (raid, party, or battleground) automatically."] = "Обеспечивает командой /gr для автомотического общения в группе (рейде или поле сражения)"

-- ./Modules/Highlight.lua
L["Highlights"] = "Выделение"
L["Use sound"] = "Использовать звук"
L["Play a soundfile when one of your keywords is said."] = "Проиграть звуковой файл когда будут сказоны одино из ваших ключевых слов."
L["Show SCT message"] = "Сообщения SCT"
L["Show highlights in your SCT mod"] = "Показать выделение в вашем SCT моде"
L["Sound File"] = "Звуковой файл"
L["Sound file to play"] = "Звуковой файл для проигрывания"
L["Add word to your highlight list"] = "Добавить слово в ваш список выделения"
L["Remove a word from your highlight list"] = "Удалить слово из вашего списка выделения"
L["Remove this word from your highlights?"] = "Удалить данное слово из выделения?"
L["Custom Channel Sounds"] = "Спец звук канала"
L["Play a sound when a message is received in this channel"] = "Проиграть звук когда будет получено сообщений в данном канале"
L["%s said '%s' in %s"] = "%s сказал '%s' в %s"
L["Alerts you when someone says a keyword or speaks in a specified channel."] = "Уведомлять вас когда кто либо скажет ключевое слово в определенный канал."
L["Reroute whole message to SCT"] = "Направлять все сообщение в SCT"
L["Reroute whole message to SCT instead of just displaying 'who said keyword in channel'"] = "Направлять все сообщение в SCT вместо одного отображения 'кто сказал ключевое слово в канал'"
L["[%s] %s: %s"] = "[%s] %s: %s"

-- ./Modules/Justify.lua
L["Text Justification"] = "Выравнивани текста"
L["Enable text justification"] = "Выравнивани текста"
L["Left"] = "Влево"
L["Right"] = "Вправо"
L["Center"] = "По центр"
L["Lets you set the justification of text in your chat frames."] = "Позволяет настроить выравнивани текста в вашем окне чата."

-- ./Modules/LinkHover.lua
L["Link Hover"] = "Навод на ссылку"
L["Makes link tooltips show when you hover them in chat."] = "Отображение подсказки когда вы наводите на ссылку предмета в чате."

-- ./Modules/PlayerNames.lua
L["Player Names"] = "Имя игрока"
L["Warlock"] = "Чернокнижник"
L["Warrior"] = "Воин"
L["Hunter"] = "Охотник"
L["Mage"] = "Маг"
L["Priest"] = "Жрец"
L["Druid"] = "Друид"
L["Paladin"] = "паладин"
L["Shaman"] = "Шаман"
L["Rogue"] = "Разбойник"
L["Save Data"] = "Сохранить данные"
L["Save data between sessions. Will increase memory usage"] = "Сохранить данные между сеансами. Увеличение используемый объем памети"
L["Save class data from guild between sessions."] = "Сохранить данные между сеансами по классу из гильдии."
L["Group"] = "Группа"
L["Save class data from groups between sessions."] = "Сохранить данные между сеансами по классу из группы."
L["Target/Mouseover"] = "Цель/Наведение-мыши"
L["Save class data from target/mouseover between sessions."] = "Сохранить данные между сеансами по классу из Цели/Наведение-мыши."
L["Who"] = "Кто"
L["Save class data from /who queries between sessions."] = "Сохранить данные между сеансами по классу из запросов /who"
L["Reset Data"] = "Сброс данных"
L["Destroys all your saved class/level data"] = "Удалить все ваши сохраненные данные по классу/уровню"
L["Are you sure you want to delete all your saved class/level data?"] = "Вы уверены что вы хотите удалить все сохраненные данные по классу/уровню?"
L["Left Bracket"] = "Левая скобка"
L["Character to use for the left bracket"] = "Буква для использование левой скобки"
L["Right Bracket"] = "Правая скобка"
L["Character to use for the right bracket"] = "Буква для использование правой скобки"
L["Use Tab Complete"] = "Исп. Tab для завершения"
L["Use tab key to automatically complete character names."] = " Использование tab клавиши для автоматического завершения имён персонажей."
L["Level Options"] = "Настройки уровня"
L["Include level"] = "Включая уровень"
L["Include the player's level"] = "Ыключая уровень игроков"
L["Exclude Level 70s"] = "Исключать 70ые уровни"
L["Exclude level display for level 70s"] = "Исключать отображение уровня для 70ых уровня"
L["Color level by difficulty"] = "Цвет уровней по трудности"
L["Color Player Names By..."] = "Цвет имен игроков по..."
L["Select a method for coloring player names"] = "Выберите метод для окрашивания имен игроков"
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "Provides options to color player names, add player levels, and add tab completion of player names."
L["Color self in messages"] = "Окраска себя в сообщениях"
L["Color own charname in messages."] = "Цвет имени машего персонажа в сообщениях."
L["Emphasize self in messages"] = "Подчёркивать себя в сообщениях"
L["Add surrounding brackets to own charname in messages."] = "Добавляет квадратные скобки в начало и конец имени машего персонажа в сообщениях."
L["Class"] = "Класс"
L["Name"] = "Имя"
L["None"] = "Нету"

-- ./Modules/StickyChannels.lua
L["Sticky Channels"] = "Клейкие каналы"
L["Emote"] = "Эмоции"
L["Raid warning"] = "Объевление рейду"
L["Custom channels"] = "Специальные каналы"
L["Make %s sticky"] = "Зделать %s клейким"
L["Makes channels you select sticky."] = "Делает выбранный вами канал клейким."

-- ./Modules/Telltarget.lua
L["Tell Target (/tt)"] = "Сказать о цели (/tt)"
L["Enables the /tt command to send a tell to your target."] = "Включает команду /tt для передачи в чат вашу цель"

-- ./Modules/Timestamps.lua
L["Timestamps"] = "Формат времени"
L["HH:MM:SS AM (12-hour)"] = "ЧЧ:ММ:СС AM (12-часов)"
L["HH:MM (12-hour)"] = "ЧЧ:ММ (12-чясов)"
L["HH:MM:SS (24-hour)"] = "ЧЧ:ММ:СС (24-часа)"
L["HH:MM (24-hour)"] = "ЧЧ:ММ (24-часа)"
L["MM:SS"] = "ММ:СС"
L["Timestamp format"] = "Формат времени"
L["Custom format (advanced)"] = "Специальный формат (продвинутый)"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "Введите специальный формат времени. Просмотрите http://www.lua.org/pil/22.1.html для зучения доступных символов фармотирования."
L["Timestamp color"] = "Цвет времени"
L["Color timestamps the same as the channel they appear in."] = "Color timestamps the same as the channel they appear in."
L["Adds timestamps to chat."] = "Добавить время в чат"
L["Per chat frame settings"] = "Настройки окон чатов"
L["Choose which chat frames display timestamps"] = "Выберите в каком окне чата отображать время"

-- ./Modules/TinyChat.lua
L["Tiny Chat"] = "Маленький чат"
L["Allows you to make the chat frames much smaller than usual."] = "Позволяет вам зделать окно чата намного меньше обычного."

-- ./Modules/UrlCopy.lua
L["URL Copy"] = "Копирование ссылок"
L["Lets you copy URLs out of chat."] = "Позоляет вам копировать ссылки из чата."

-- ./Modules/Scrollback.lua
L["Scrollback"] = "Scroll back"
L["Enable Scrollback length modification"] = "Enable Scrollback length modification"
L["Lets you set the scrollback length of your chat frames."] = "Lets you set the scrollback length of your chat frames"
-- L["Chat Frame "] exists in ChatFrame section

