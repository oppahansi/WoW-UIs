local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Chatter", "deDE")
if not L then return end

-- ./Chatter.lua
L["Standalone Config"] = "Eigenes Menü"
L["Open a standalone config window. You might consider installing |cffffff00BetterBlizzOptions|r to make the Blizzard UI options panel resizable."] = "Öffnet ein eigenes Options Menü. Vielleicht solltest du in Erwägung ziehen |cffffff00BetterBlizzOptions|r zu installieren damit das Blizzard Optionsmenü in der Größe dynamisch anpassbar wird."
L["Configure"] = "Justiere"
L["Modules"] = "Module"
L["Module"] = "Module"
L["Settings"] = "Einstellungen"
L["Enable "] = "Aktiviere "
L["Enabled"] = "Aktiviert"
L["Disabled"] = "Deaktiviert"
L["Chatter Settings"] = "Chatter Einstellungen"
L["Welcome to Chatter! Type /chatter to configure."] = "Willkommen zu Chatter! Tipp /chatter um die Optionen zu Justieren."

-- ./Modules/AltNames.lua
L["Alt Linking"] = "Twink Verlinkung"
L["Use PlayerNames coloring"] = "Benutze Spielernamen Farben"
L["Use custom color"] = "Benutze selbstdefinierte Farbe"
L["Use channel color"] = "Benutze Kanal Farbe"
L["Name color"] = "Namensfarbe"
L["Set the coloring mode for alt names"] = "Justiere die Einfärbe Methode für Twink Namen."
L["Custom color"] = "Selbstdefinierte Farbe"
L["Select the custom color to use for alt names"] = "Wähle eine Farbe die nur bei Twink Namen benutzt wird."
L["Who is %s's main?"] = "Wer ist %s's Hauptcharakter?"
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name."] = "Erlaubt dir einen Spieler Namen rechtszuklicken und eine Notiz hinzuzufügen die auch im Chat angezeigft wird, wie den Namen des Hauptcharakters."
L["Set Main"] = "Setze Hauptcharakter"

-- ./Modules/AutoLogChat.lua
L["Chat Autolog"] = "Chat Aufzeichnung"
L["Automatically turns on chat logging."] = "Automatische Chat Aufzeichnung aktivieren."

-- ./Modules/Buttons.lua
L["Disable Buttons"] = "Tasten Ausblenden"
L["Show bottom when scrolled"] = "Zeige 'unten' wenn gescrollt wird"
L["Show bottom button when scrolled up"] = "Eine 'Nach unten' Taste wird automatisch eingeblendet wenn im Chat nach oben gescrollt wird."
L["Hides the buttons attached to the chat frame"] = "Versteckt die Tasten die Stadardmäßig zum Chatfenster gehören."

-- ./Modules/ChannelColors.lua
L["Channel Colors"] = "Kanal Farben"
L["Keeps your channel colors by name rather than by number."] = "Sortiert deine Kanal Farben nach Name anstatt nach Nummer."
L["Other Channels"] = "Andere Kanäle"
L["Yell"] = "Schreien"
L["Guild"] = "Gilde"
L["Officer"] = "Offizierschat"
L["Raid"] = "Schlachtzug"
L["Party"] = "Gruppe"
L["Raid Warning"] = "Schlachtzugswarnung"
L["Say"] = "Sagen"
L["Battleground"] = "Schlachtfeld"
L["Whisper"] = "Flüstern"
L["Select a color for this channel"] = "Wähle eine Farbe für diesen Kanal"

-- ./Modules/ChannelNames.lua
L["Channel Names"] = "Kanal Namen"
L["Raid Leader"] = "Schlachtzugsleiter"
L["LookingForGroup"] = "SucheNachGruppe"
L["Battleground Leader"] = "Schlachtfeldleiter"
L["Custom Channels"] = "Eigene Kanäle"
L["Add space after channels"] = "Füge eine Leerstelle hinter Kanalnamen"
L["Replace this channel name with..."] = "Ersetze diesen Kanal Namen mit..."
L["^To "] = "^Zu "
L["^(.-|h) whispers:"] = "^(.-|h) flüstert:"
L["Enables you to replace channel names with your own names"] = "Erlaubt dir die Kanal Namen nach deinen Wünschen anzupassen."

-- ./Modules/ChatFading.lua
L["Disable Fading"] = "Ausblenden Deaktivieren"
L["Makes old text disappear rather than fade out"] = "Läst alten Text verschwinden anstatt ihn auszublenden."

-- ./Modules/ChatFont.lua
L["Chat Font"] = "Chat Schriftart"
L["Font"] = "Schriftart"
L["Font size"] = "Schriftgröße"
L["Font Outline"] = "Schrift Umriss"
L["Font outlining"] = "Schrift Umrandung"
L["Chat Frame "] = "Chatfenster"
L["Enables you to set a custom font and font size for your chat frames"] = "Ermöglicht dir beliebige Schriftarten und Schriftgrößen zu verwenden bei deinen Chatfenstern."

-- ./Modules/ChatFrameBorders.lua
L["Borders/Background"] = "Rahmen/Hintergrund"
L["Enable"] = "Aktiviere"
L["Enable borders on this frame"] = "Aktiviere Rahmen in diesem Fenster."
L["Combat Log Fix"] = "Kampflog Fix"
L["Resize this border to fit the new combat log"] = "Größe dieses Rahmens anpassen um mit den neuen Kampflog kompatibel zu bleiben."
L["Background texture"] = "Hintergrundtextur"
L["Border texture"] = "Rahmen Textur"
L["Background color"] = "Hintergrundfarbe"
L["Border color"] = "Rahmen Farbe"
L["Background Inset"] = "Hintergrund Teile"
L["Tile Size"] = "Ziegel Größe"
L["Edge Size"] = "Kanten Größe"
L["Gives you finer control over the chat frame's background and border colors"] = "Gibt dir eine feinere Einstellungsmöglichkeit über die Chatfenster Hintergründe und Rahmen Farben."

-- ./Modules/ChatLink.Lua
L["Chat Link"] = "Chat Links"
L["Lets you link items, enchants, spells, and quests in custom channels."] = "Läst dich Items, Verzauberrungen, Zauber und Quest in selbsterstellten Chatkanälen verlinken."
L["Trade -"] = "Handel -"

-- ./Modules/ChatScroll.lua
L["Mousewheel Scroll"] = "Mausrad Scrollen"
L["Scroll lines"] = "Scroll Linien"
L["How many lines to scroll per mouse wheel click"] = "Wieviele Linien soll der Chat bei einem Rastersprung des Mausrades scrollen?"
L["Lets you use the mousewheel to page up and down chat."] = "Läst dich mit dem Mausrad im Chat rauf und runter scrollen."

-- ./Modules/ChatTabs.lua
L["Chat Tabs"] = "Chat Karteikarten"
L["Button Height"] = "Tastenhöhe"
L["Button's height, and text offset from the frame"] = "Tastenhöhe und Text Abstand vom Fenster."
L["Hide Tabs"] = "Verstecke Karteikarten"
L["Hides chat frame tabs"] = "Versteckt die Karteikarten der Chatfenster."

-- ./Modules/ClickInvite.lua
L["Invite Links"] = "Einladen Links"
L["Add Word"] = "Wort Hinzufügen"
L["Add word to your invite trigger list"] = "Füge ein Wort zu deiner Einladen Ativierungsliste."
L["Remove Word"] = "Wort Entfernen"
L["Remove a word from your invite trigger list"] = "Entferne ein Wort zu deiner Einladen Ativierungsliste."
L["Remove this word from your trigger list?"] = "Entferne dieses Wort zu deiner Einladen Ativierungsliste."
L["Alt-click name to invite"] = "Alt+Klick auf Namen zum einladen"
L["Lets you alt-click player names to invite them to your party."] = "Lässt dich durch Alt+Klick auf Spielernamen diese automatisch ein Gruppe/Raid einladen."
L["invite"] = "einladen"
L["inv"] = "lad"
L["Gives you more flexibility in how you invite people to your group."] = "Gibt dir mehr Möglichkeiten wie du Leute in deine(n) Gruppe/Raid einladen kannst."

-- ./Modules/CopyChat.lua
L["Copy Chat"] = "Chat Kopieren Taste"
L["Copy text from this frame."] = "Kopiere Text von diesem Fenster"
L["Lets you copy text out of your chat frames."] = "Läst dich aus deinen Chatfenstern Text kopieren."

-- ./Modules/EditBox.lua
L["Edit Box Polish"] = "Eingabefeld"
L["Top"] = "Oben"
L["Bottom"] = "Unten"
L["Free-floating"] = "Frei-schwebend"
L["Free-floating, Locked"] = "Frei-schwebend, Gesperrt"
L["Attach to..."] = "Andocken an..."
L["Attach edit box to..."] = "Andocken des Eingabefelds an..."
L["Color border by channel"] = "Färbe Rahmen nach Kanal"
L["Sets the frame's border color to the color of your currently active channel"] = "Passt die Rahmenfarbe der Farbe an die für das entsprechnde Chatfenster eingestellt ist."
L["Use Alt key for cursor movement"] = "Benutze Alt Taste für Courser Bewegung"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Setzt das halten der Alt Taste vorraus um im Eingabefeld den Courser bewegen zu können."
L["Select the font to use for the edit box"] = "Wähle die Schriftart die beim Eingabefeld benutzt wird"
L["Lets you customize the position and look of the edit box"] = "Läst dich die Position und das Aussehn des Eingabefelds, deinen eigenen Wünschen nach anpassen."

-- ./Modules/GroupSay.lua
L["Group Say (/gr)"] = "Gruppe Sagen (/gr)"
L["Provides a /gr slash command to let you speak in your group (raid, party, or battleground) automatically."] = "Fügt das /gr Slash Kommando hinzu damit du immer (Raid, Gruppe, Schlachtfeld) im Gruppenchat schreiben kannst."

-- ./Modules/Highlight.lua
L["Highlights"] = "Benachrichtigungen"
L["Use sound"] = "Benutze Sound"
L["Play a soundfile when one of your keywords is said."] = "Spiele einen Sound ab wenn eienr deiner Schlüsselwörter gesagt wurde."
L["Show SCT message"] = "Zeige SCT Nachrichten"
L["Show highlights in your SCT mod"] = "Zeige die Höhepunkte in deinem Scrollendem Kampftext Mod."
L["Sound File"] = "Sound Datei"
L["Sound file to play"] = "Sound Datei zum Abspielen."
L["Add word to your highlight list"] = "Füge ein Wort zu deiner Höhepunkte Liste"
L["Remove a word from your highlight list"] = "Entferne ein Wort aus deiner Höhepunkte Liste"
L["Remove this word from your highlights?"] = "Entferne dieses Wort aus deiner Höhepunkte Liste"
L["Custom Channel Sounds"] = "Selbstdefinierte Kanal Sounds"
L["Play a sound when a message is received in this channel"] = "Spiel einen Sound ab wenn eine Nachricht in diesem Kanal eingeht"
L["%s said '%s' in %s"] = "%s sagte '%s' in %s"
L["Alerts you when someone says a keyword or speaks in a specified channel."] = "Lass dich Benachrichtigen wenn jemand ein Schlüsselwort sagt oder in einem definiertem Kanal spricht."
L["Reroute whole message to SCT"] = "Leite die gesamte Nachricht an SCT"
L["Reroute whole message to SCT instead of just displaying 'who said keyword in channel'"] = "Leite die gesammte Nachricht an SCT weiter anstatt nur zu informieren wer ein Schlüsselwort geschrieben hat."
L["[%s] %s: %s"] = "[%s] %s: %s"

-- ./Modules/Justify.lua
L["Text Justification"] = "Text Justierung"
L["Enable text justification"] = "Aktiviere die Text Justierung."
L["Left"] = "Linksbündig"
L["Right"] = "Rechtsbündig"
L["Center"] = "Zentrieren"
L["Lets you set the justification of text in your chat frames."] = "Läst dich die Bündigkeit der Texte in den Chatfenstern Justieren."

-- ./Modules/LinkHover.lua
L["Link Hover"] = "Links bei Mausüber"
L["Makes link tooltips show when you hover them in chat."] = "Lässt Tooltips von Links automatisch erscheinen wenn du mit der Maus über Links im Chat schwebst."

-- ./Modules/PlayerNames.lua
L["Player Names"] = "Spieler Namen"
L["Warlock"] = "Hexenmeister"
L["Warrior"] = "Krieger"
L["Hunter"] = "Jäger"
L["Mage"] = "Magier"
L["Priest"] = "Priester"
L["Druid"] = "Druide"
L["Paladin"] = "Paladin"
L["Shaman"] = "Schamane"
L["Rogue"] = "Schurke"
L["Save Data"] = "Speichere Daten"
L["Save data between sessions. Will increase memory usage"] = "Speicher Daten zwischen den Sitzungen. Dies wird den Speicherverbrauch erhöhen."
L["Save class data from guild between sessions."] = "Speichere Klassen Daten aus Gilde zwischen den Sitzungen."
L["Group"] = "Gruppe"
L["Save class data from groups between sessions."] = "Speichere Klassen Daten von Gruppen zwischen den Sitzungen."
L["Target/Mouseover"] = "Ziel/Mausüber"
L["Save class data from target/mouseover between sessions."] = "Speichere Klassen Daten vom Ziel/Mausüber zwischen den Sitzungen."
L["Who"] = "Wer"
L["Save class data from /who queries between sessions."] = "Speichere Klassen Daten vom /wer Anfragen zwischen den Sitzungen."
L["Reset Data"] = "Resette Daten"
L["Destroys all your saved class/level data"] = "Zerstört alle deine gespeicherten Klassen/Level Daten."
L["Are you sure you want to delete all your saved class/level data?"] = "Bist du sicher das du ALLE deiner gespeicherten Klassen/Level Daten Löschen willst?"
L["Left Bracket"] = "Linke Klammer"
L["Character to use for the left bracket"] = "Zeichnesymbol das für die linke Klammer benutzt wird."
L["Right Bracket"] = "Rechte Klammer"
L["Character to use for the right bracket"] = "Zeichnesymbol das für die rechte Klammer benutzt wird."
L["Use Tab Complete"] = "Benutze Tab Vervollständigen"
L["Use tab key to automatically complete character names."] = "Benutze die Tab Taste um Namen automatisch zu vervollständigen."
L["Level Options"] = "Level Optionen"
L["Include level"] = "Level hinzufügen"
L["Include the player's level"] = "Füge dem Namen den Level des spielers hinzu."
L["Exclude Level 70s"] = "Level 70 Ausschließen"
L["Exclude level display for level 70s"] = "Zeige das Level bei Stufe 70 Spielern nicht an."
L["Color level by difficulty"] = "Färbe Level nach Schwierigkeit"
L["Color Player Names By..."] = "Färbe Spieler Namen nach..."
L["Select a method for coloring player names"] = "Wähle eine Methode wie Spielernamen eingefärbt werden."
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "Fügt die Möglichkeiten hinzu Spieler Namen einzufärben, Spieler Level anzuzeigen und per Tab Taste die Namen vervollständigen zu lassen."
L["Color self in messages"] = "Färbe dich in Nachrichten"
L["Color own charname in messages."] = "Färbt deinen eigenen Namen in Nachrichten ein."
L["Emphasize self in messages"] = "Betone eigenen Namen in Nachrichten"
L["Add surrounding brackets to own charname in messages."] = "Fügt dem eigenem Namen umschließende Klammern in Chattexten hinzu."
L["Class"] = "Klasse"
L["Name"] = "Name"
L["None"] = "Nichts"

-- ./Modules/StickyChannels.lua
L["Sticky Channels"] = "Stehende Kanäle"
L["Emote"] = "Emote"
L["Raid warning"] = "Schlachtzugswarnung"
L["Custom channels"] = "Benutzerdefinierte Kanäle"
L["Make %s sticky"] = "Macht %s stehend"
L["Makes channels you select sticky."] = "Macht Kanäle die du auswählst stehend. Dadurch wird der Text erst später ausgeblendet."

-- ./Modules/Telltarget.lua
L["Tell Target (/tt)"] = "Ziel Flüstern (/tt)"
L["Enables the /tt command to send a tell to your target."] = "Aktiviert das /tt Kommando um dem Ziel das du gegenwärtig angeklickt hast eine Nachricht zu senden."

-- ./Modules/Timestamps.lua
L["Timestamps"] = "Zeitstempel"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-Stunden)"
L["HH:MM (12-hour)"] = "HH:MM (12-Stunden)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-Stunden)"
L["HH:MM (24-hour)"] = "HH:MM (24-Stunden)"
L["MM:SS"] = "MM:SS"
L["Timestamp format"] = "Zeitstempel Formatierung"
L["Custom format (advanced)"] = "Eigene Formatierung (erweitert)"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "Gib eine eigene Zeitstempel Formatierung ein. Besuch http://www.lua.org/pil/22.1.html für eine Liste der gültigen Formatierungssymbole."
L["Timestamp color"] = "Zeitstempel Farbe"
L["Color timestamps the same as the channel they appear in."] = "Färbe den Zeitsempel in der gleichen Farbe wie der Kanal eingestellt ist."
L["Adds timestamps to chat."] = "Fügt dem Chat Zeitstempel hinzu."
L["Per chat frame settings"] = "Einstellungen nach Chatfenster"
L["Choose which chat frames display timestamps"] = "Wähle welche Chatfenster Zeitstempel anzeigen sollen."

-- ./Modules/TinyChat.lua
L["Tiny Chat"] = "Kleiner Chat"
L["Allows you to make the chat frames much smaller than usual."] = "Erlaubt dir die Chatfenster wesentlich kleiner zu machen als normal der Fall ist."

-- ./Modules/UrlCopy.lua
L["URL Copy"] = "URL Kopieren"
L["Lets you copy URLs out of chat."] = "Läst dich URL's aus dem Chat kopieren."

-- ./Modules/Scrollback.lua
L["Scrollback"] = "Zurückscrollen"
L["Enable Scrollback length modification"] = "Aktiviere die Zurückscrollen Modifikation"
L["Lets you set the scrollback length of your chat frames."] = "Läst dich justieren wieviele Zeilen du in den Chatfenstern zurückscrollen kannst."
-- L["Chat Frame "] exists in ChatFrame section

