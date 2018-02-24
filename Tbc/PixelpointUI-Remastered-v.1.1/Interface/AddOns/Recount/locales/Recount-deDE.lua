local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Recount", "deDE")
if not L then return end
-- Wer mit deutschem Client englische Texte wünscht, kann einfach alles unterhalb dieser Zeile löschen. (If you prefer English Recount with a German client, just delete everything below in this file.)
	L["Profiles"] = "Profile"
	L["GUI"] = "GUI"
	L["gui"] = "gui"
	L["Open Ace3 Config GUI"] = "Ace3 Konfig GUI öffnen"
	L["Sync"] = "Sync"
	L["sync"] = "sync"
	L["Toggles sending synchronization messages"] = "Schaltet die Synchronisation an/aus"
	L["Reset"] = "Zurücksetzen"
	L["reset"] = "zurücksetzen"
	L["Resets the data"] = "Setzt die Daten zurück"
	L["VerChk"] = "Versions Check"
	L["verChk"] = "verChk"
	L["Displays the versions of players in the raid"] = "Zeigt die Versionen aller Spieler im Schlachtzug an"
	L["Displaying Versions"] = "Versionen anzeigen"
	L["Show"] = "Zeige"
	L["show"] = "zeige"
	L["Shows the main window"] = "Zeigt Hauptfenster"
	L["Hide"] = "Verstecke"
	L["Hides the main window"] = "Versteckt Hauptfenster"
	L["Toggle"] = "Ein-/Ausblenden"
	L["Toggles the main window"] = "Hauptfenster ein-/ausblenden"
	L["Report"] = "Bericht"
	L["Allows the data of a window to be reported"] = "Berichten der Fensterdaten erlauben"
	L["Detail"] = "Detail"
	L["Report the Detail Window Data"] = "Berichtet die Daten im Detailfenster"
	L["Main"] = "Haupt"
	L["Report the Main Window Data"] = "Berichtet die Daten im Hauptfenster"
	L["Config"] = "Konfig"
	L["Shows the config window"] = "Zeigt das Konfigurationsfenster"
	L["ResetPos"] = "UrsprungsPos"
	L["Resets the positions of the detail, graph, and main windows"] = "Setzt die Positionen von Detail-, Graphik- und Hauptfenster zurück"
	L["Lock"] = "Sperren"
	L["Toggles windows being locked"] = "Schaltet die Sperre für Fensterverschiebung an/aus"
	L["|cffff4040Disabled|r"] = "|cffff4040Ausgeschaltet|r"
	L["|cff40ff40Enabled|r"] = "|cff40ff40Eingeschaltet|r"
	L["Unknown Spells"] = "Unbekannter Zauberspruch"
	L["Shows found unknown spells in BabbleSpell"] = "Zeigt Zaubersprüche die BabbleSpell unbekannt sind"
	L["Unknown Spells:"] = "Unbekannte Zaubersprüche:"
	L["Realtime"] = "Echtzeit"
	L["Specialized Realtime Graphs"] = "Spezielle Echtzeit Graphen"
	L["FPS"] = "FPS"
	L["Starts a realtime window tracking your FPS"] = "Öffnet ein Echtzeitfenster für Deine FPS (Frames Per Seconds)"
	L["Lag"] = "Lag"
	L["Starts a realtime window tracking your latency"] = "Öffnet ein Echtzeitfenster für Deine Latenz"
	L["Upstream Traffic"] = "Ankommender Verkehr"
	L["Starts a realtime window tracking your upstream traffic"] = "Öffnet ein Echtzeitfenster für Deinen ankommenden Verkehr"
	L["Downstream Traffic"] = "Ausgehender Verkehr"
	L["Starts a realtime window tracking your downstream traffic"] = "Öffnet ein Echtzeitfenster für Deinen ausgehenden Verkehr"
	L["Available Bandwidth"] = "Verfügbare Bandbreite"
	L["Starts a realtime window tracking amount of available AceComm bandwidth left"] = "Öffnet ein Echtzeitfenster für verfügbare AceComm Bandbreite"
	L["Tracks your entire raid"] = "Verfolgt den gesamten Schlachtzug"
	L["DPS"] = "DPS"
	L["Tracks Raid Damage Per Second"] = "Verfolgt im Schlachtzug ausgeteilten Schaden pro Sekunde (DPS)"
	L["DTPS"] = "DTPS"
	L["Tracks Raid Damage Taken Per Second"] = "Verfolgt im Schlachtzug genommenen Schaden pro Sekunde (DTPS)"
	L["HPS"] = "HPS"
	L["Tracks Raid Healing Per Second"] = "Verfolgt im Schlachtzug ausgeteilte Heilung pro Sekunde (HPS)"
	L["HTPS"] = "HTPS"
	L["Tracks Raid Healing Taken Per Second"] = "Verfolgt im Schlachtzug genommene Heilung pro Sekunde (HTPS)"
	L["Pet"] = "Begleiter"
	L["Mob"] = "Mob"
	L["Title"] = "Titel"
	L["Background"] = "Hintergrund"
	L["Title Text"] = "Titeltext"
	L["Bar Text"] = "Balkentext"
	L["Total Bar"] = "Gesamtbalken"
	L["Show previous main page"] = "Zeige vorige Hauptseite"
	L["Show next main page"] = "Zeige nächste Hauptseite"
	L["Display"] = "Darstellung"
	L["Damage Done"] = "Schaden gemacht"
	L["Friendly Fire"] = "Freundliches Feuer"
	L["Damage Taken"] = "Schaden genommen"
	L["Healing Done"] = "Geheilt für"
	L["Healing Taken"] = "Heilung bekommen"
	L["Overhealing Done"] = "Überheilung"
	L["Deaths"] = "Tode"
	L["DOT Uptime"] = "DoT Aktivzeit"
	L["HOT Uptime"] = "HoT Aktivzeit"
	L["Dispels"] = "Entzauberungen"
	L["Dispelled"] = "Wurde entzaubert"
	L["Interrupts"] = "Unterbrechungen"
	L["Ressers"] = "Wiederbelebungen"
	L["CC Breakers"] = "CC Brecher"
	L["Activity"] = "Aktivität"
	L["Threat"] = "Bedrohung"
	L["Mana Gained"] = "Mana bekommen"
	L["Energy Gained"] = "Energie bekommen"
	L["Rage Gained"] = "Wut bekommen"
	L["Network Traffic(by Player)"] = "Netzwerkverkehr (pro Spieler)"
	L["Network Traffic(by Prefix)"] = "Netzwerkverkehr (pro Präfix)"
	L["Bar Color Selection"] = "Balkenfarbenauswahl"
	L["Class Colors"] = "Klassenfarbe"
	L["Reset Colors"] = "Farbe zurücksetzen"
	L["Is this shown in the main window?"] = "Soll dies im Hauptfenster angezeigt werden?"
	L["Record Data"] = "Daten aufzeichnen"
	L["Whether data is recorded for this type"] = "Daten für diesen Typ aufzeichnen"
	L["Record Time Data"] = "Zeitdaten aufzeichnen"
	L["Whether time data is recorded for this type (used for graphs can be a |cffff2020memory hog|r if you are concerned about memory)"] = "Zeitdaten für diesen Typ aufzeichnen (wenn dies in Graphen benutzt wird, kann dies zu |cffff2020erheblichem Speicherverbrauch|r führen)"
	L["Record Deaths"] = "Tode aufzeichnen"
	L["Records when deaths occur and the past few actions involving this type"] = "Tode und ein paar Aktionen davor für diesen Typ aufzeichnen"
	L["Record Buffs/Debuffs"] = "Buffs/Debuffs aufzeichnen"
	L["Records the times and applications of buff/debuffs on this type"] = "Buffs/Debuffs für diesen Typ aufzeichnen"
	L["Filters"] = "Filter"
	L["Players"] = "Spieler"
	L["Self"] = "Selbst"
	L["Grouped"] = "In Gruppe"
	L["Ungrouped"] = "Nicht in Grp"
	L["Pets"] = "Begleiter"
	L["Mobs"] = "Mobs"
	L["Trivial"] = "Graue"
	L["Non-Trivial"] = "Nicht Graue"
	L["Bosses"] = "Bosse"
	L["Unknown"] = "Unbekannt"
	L["Bar Selection"] = "Balkentextur"
	L["Font Selection"] = "Schriftauswahl"
	L["General Window Options"] = "Allgemeine Fensteroptionen"
	L["Reset Positions"] = "Position zurücksetzen"
	L["Window Scaling"] = "Fensterskalierung"
	L["Data Deletion"] = "Datenlöschung"
	L["Instance Based Deletion"] = "Instanzbasiertes Löschen..."
	L["Group Based Deletion"] = "Gruppenbasiertes Löschen..."
	L["Global Realtime Windows"] = "Echtzeitfensteroptionen"
	L["Network"] = "Netzwerk"
	L["Latency"] = "Latenz"
	L["Up Traffic"] = "Eing. Verkehr"
	L["Down Traffic"] = "Ausg. Verkehr"
	L["Bandwidth"] = "Bandbreite"
	L["Recount Version"] = "Recount Version"
	L["Check Versions"] = "Versionscheck"
	L["Data Options"] = "Datenoptionen"
	L["Combat Log Range"] = "Kampflogreichweite"
	L["Yds"] = "m"
	L["Fix Ambiguous Log Strings"] = "Logmeldungen korrigieren" -- Mehrdeutige Logmeldungen korrigieren
	L["Merge Pets w/ Owners"] = "Begleiter/Besitzer zusammen" -- Begleiter/Besitzer zusammenfassen
	L["Main Window Options"] = "Hauptfensteroptionen"
	L["Show Buttons"] = "Buttons anzeigen"
	L["File"] = "Daten"
	L["Previous"] = "Vorherige"
	L["Next"] = "Nächste"
	L["Row Height"] = "Zeilenhöhe"
	L["Row Spacing"] = "Zeilenabstand"
	L["Autohide On Combat"] = "Autom. im Kampf verstecken" -- Automatisch im Kampf verstecken
	L["Show Scrollbar"] = "Scrollbar anzeigen"
	L["Data"] = "Daten"
	L["Appearance"] = "Aussehen"
	L["Color"] = "Farbe"
	L["Window"] = "Fenster"
	L["Window Color Selection"] = "Fensterfarbenauswahl"
	L["Main Window"] = "Hauptfenster"
	L["Other Windows"] = "Andere Fenster"
	L["Global Data Collection"] = "Allg. Datensammlung" -- Allgemeine Datensammlung
	L["Autoswitch Shown Fight"] = "Autom. akt. Kampf zeigen" -- Automatisch aktuellen Kampf zeigen
	L["Lock Windows"] = "Fenster sperren"
	L["Autodelete Time Data"] = "Autom. Zeitdaten löschen" -- Automatisch Zeitdaten löschen
	L["Delete on Entry"] = "...bei Eintritt"
	L["New"] = "Neu"
	L["Confirmation"] = "Bestätigung"
	L["Delete on New Group"] = "...bei neuer Gruppe"
	L["Delete on New Raid"] = "...bei neuem Schlachtzug"
	L["Sync Data"] = "Daten synchronisieren"
	L["Set Combat Log Range"] = "Kampflogreichw. einstellen" -- Kampflogreichweite einstellen
	L["Detail Window"] = "Detailfenster"
	L["Death Details for"] = "Todesdetails für"
	L["Health"] = "Gesundheit"
	L["Recount"] = "Recount"
	L["Outgoing"] = "Ausgehend"
	L["Incoming"] = "Eingehend"
	L["Damage Report for"] = "Schadensbericht für"
	L["Damage"] = "Schaden"
	L["Resisted"] = "Widerstanden"
	L["Report for"] = "Bericht für"
	L["Glancing"] = "Gestreift"
	L["Hit"] = "Treffer"
	L["Crushing"] = "Schmetternd"
	L["Crit"] = "Krit"
	L["Miss"] = "Verfehlt"
	L["Dodge"] = "Ausgewichen"
	L["Parry"] = "Pariert"
	L["Block"] = "Geblockt"
	L["Resist"] = "Widerstanden"
	L["Tick"] = "Tick"
	L["Split"] = "Split"
	L["X Gridlines Represent"] = "X Gridlinien bedeuten"
	L["Seconds"] = "Sekunden"
	L["Graph Window"] = "Graph Fenster"
	L["Data Name"] = "Daten (Name)"
	L["Enabled"] = "Aktiviert"
	L["Fought"] = "Gekämpft"
	L["Start"] = "Start"
	L["End"] = "Ende"
	L["Normalize"] = "Normalisiert"
	L["Integrate"] = "Integriert"
	L["Stack"] = "Stapel"
	L["Report Data"] = "Daten berichten"
	L["Report To"] = "Bericht an:"
	L["Report Top"] = "Berichte die ersten"
	L["Reset Recount?"] = "Recount zurücksetzen"
	L["Do you wish to reset the data?"] = "Willst Du alle Daten zurücksetzen?"
	L["Yes"] = "Ja"
	L["No"] = "Nein"
	L["Show Details (Left Click)"] = "Zeige Details (Links Klick)"
	L["Show Graph (Shift Click)"] = "Zeige Graph (Shift Klick)"
	L["Add to Current Graph (Alt Click)"] = "Zu momentanem Graph hinzufügen (Alt Klick)"
	L["Show Realtime Graph (Ctrl Click)"] = "Zeige Echtzeit Graph (Strg Klick)"
	L["Delete Combatant (Ctrl-Alt Click)"] = "Mitkämpfer löschen (Strg-Alt Klick)"
	L[" for "] = " für "
	L["Overall Data"] = "Alle Daten"
	L["Current Fight"] = "Momentaner Kampf"
	L["Last Fight"] = "Letzter Kampf"
	L["Fight"] = "Kampf"
	L["Top Color"] = "Farbe oben"
	L["Bottom Color"] = "Farbe unten"
	L["Ability Name"] = "Fähigkeit (Name)"
	L["Type"] = "Typ"
	L["Min"] = "Min"
	L["Avg"] = "ø"
	L["Max"] = "Max"
	L["Count"] = "Anzahl"
	L["Player/Mob Name"] = "Spieler-/Mobname"
	L["Attack Name"] = "Angriff (Name)"
	L["Time (s)"] = "Zeit(en)"
	L["Heal Name"] = "Heilung (Name)"
	L["Heal"] = "Heilung"
	L["Healed"] = "Geheilt"
	L["Overheal"] = "Überheilung"
	L["Ability"] = "Fähigkeit"
	L["DOT Time"] = "DoT Zeit"
	L["Ticked on"] = "Getickt auf"
	L["Duration"] = "Dauer"
	L["HOT Time"] = "HoT Zeit"
	L["Interrupted Who"] = "Wen unterbrochen"
	L["Interrupted"] = "Unterbrochen"
	L["Ressed Who"] = "Hat wiederbelebt"
	L["Times"] = "Zeiten"
	L["Who"] = "Wer"
	L["Broke"] = "Gebrochen"
	L["Broke On"] = "Gebrochen bei"
	L["Gained"] = "Bekommen"
	L["From"] = "Von"
	L["Prefix"] = "Präfix"
	L["Messages"] = "Nachrichten"
	L["Distribution"] = "Verteilung"
	L["Bytes"] = "Bytes"
	L["'s Hostile Attacks"] = "s Feindangriffe"
	L["Damaged Who"] = "hat Schaden gemacht auf"
	L["'s Partial Resists"] = "s Fähigkeiten denen widerstanden wurde" -- s Fähigkeiten denen (teilweise) widerstanden wurde
	L["'s Time Spent Attacking"] = "s benutzte Zeit für Angriffe"
	L["'s Friendly Fire"] = "s Freundliches Feuer"
	L["Friendly Fired On"] = "s Freundliches Feuer auf"
	L["Took Damage From"] = "hat Schaden genommen von"
	L["'s Effective Healing"] = "s effektive Heilung"
	L["Healed Who"] = "hat geheilt"
	L["'s Overhealing"] = "s Überheilung"
	L["'s Time Spent Healing"] = "s benutzte Zeit für Heilung"
	L["was Healed by"] = "wurde geheilt von"
	L["'s DOT Uptime"] = "s DoT Aktivzeit"
	L["'s HOT Uptime"] = "s HoT Aktivzeit"
	L["'s Interrupts"] = "s Unterbrechungen"
	L["'s Resses"] = "s Wiederbelebungen"
	L["'s Dispels"] = "s Entzauberungen"
	L["was Dispelled by"] = "wurde entzaubert von"
	L["'s Time Spent"] = "s benutzte Zeit"
	L["CC Breaking"] = "CC gebrochen"
	L["'s Mana Gained"] = "s Mana bekommen"
	L["'s Mana Gained From"] = "s Mana bekommen von"
	L["'s Energy Gained"] = "s Energie bekommen"
	L["'s Energy Gained From"] = "s Energie bekommen von"
	L["'s Rage Gained"] = "s Wut bekommen"
	L["'s Rage Gained From"] = "s Wut bekommen von"
	L["'s Network Traffic"] = "s Netzwerkverkehr"
	L["Top 3"] = "Top 3"
	L["Damage Abilities"] = "Schaden (Fähigkeit)"
	L["Attacked"] = "Angegriffen"
	L["Pet Damage Abilities"] = "Begleiter - Schaden (Fähigkeit)"
	L["Pet Attacked"] = "Begleiter - Angegriffen"
	L["Click for more Details"] = "Klicken für mehr Details"
	L["Friendly Attacks"] = "Freundliche Angriffe"
	L["Attacked by"] = "Wurde angegriffen von"
	L["Heals"] = "Heilung"
	L["Healed By"] = "Geheilt von"
	L["Over Heals"] = "Überheilungen"
	L["DOTs"] = "DoTs"
	L["HOTs"] = "HoTs"
	L["Dispelled By"] = "Entzaubert von"
	L["Attacked/Healed"] = "Angegriffen/Geheilt"
	L["Time Damaging"] = "Zeit für Schaden"
	L["Time Healing"] = "Zeit für Heilung"
	L["Mana Abilities"] = "Mana (Fähigkeiten)"
	L["Mana Sources"] = "Mana (Quellen)"
	L["Energy Abilities"] = "Energie (Fähigkeiten)"
	L["Energy Sources"] = "Energie (Quellen)"
	L["Rage Abilities"] = "Wut (Fähigkeiten)"
	L["Rage Sources"] = "Wut (Quellen)"
	L["CC's Broken"] = "CCs gebrochen"
	L["Ressed"] = "Wiederbelebt"
	L["Network Traffic"] = "Netzwerkverkehr"
	L["'s DPS"] = "s DPS"
	L["'s DTPS"] = "s DTPS"
	L["'s HPS"] = "s HPS"
	L["'s HTPS"] = "s HTPS"
	L["'s TPS"] = "s TPS"
	L["Threat on"] = "Bedrohung von"
	L["Name of Ability"] = "Name der Fähigkeit"
	L["Time"] = "Zeit"
	L["Killed By"] = "Getötet von"
	L["Combat Messages"] = "Kampflog Nachrichten"
	L["Misc"] = "Versch."
	L["Show Graph"] = "Zeige Graph"
	L["Config Recount"] = "Recount Konfiguration"
	L["Death Graph"] = "Todesgraph"
	L["Melee"] = "Nahkampf"
	L["Physical"] = "Körperlich"
	L["Arcane"] = "Arkan"
	L["Fire"] = "Feuer"
	L["Frost"] = "Frost"
	L["Holy"] = "Heilig"
	L["Nature"] = "Natur"
	L["Shadow"] = "Schatten"
	L["Total"] = "Gesamt"
	L["Taken"] = "Genommen"
	L["Damage Focus"] = "Schaden Fokus"
	L["Avg. DOTs Up"] = "Durchschn. DoTs Dauer"
	L["Pet Damage"] = "Begleiterschaden"
	L["No Pet"] = "Kein Begleiter"
	L["Pet Time"] = "Begleiter Zeit"
	L["Pet Focus"] = "Begleiter Fokus"
	L["Healing"] = "Heilung"
	L["Overhealing"] = "Überheilung"
	L["Heal Focus"] = "Heil Fokus"
	L["Avg. HOTs Up"] = "Durchschn. HoTs Dauer"
	L["Attack Summary Outgoing (Click for Incoming)"] = "Angriffszusammenfassung Ausgehend (Klick für Eingehend)"
	L["Attack Summary Incoming (Click for Outgoing)"] = "Angriffszusammenfassung Eingehend (Klick für Ausgehend)"
	L["Summary Report for"] = "Zusammenfassung für"
	L["Say"] = "Sagen"
	L["Party"] = "Gruppe"
	L["Raid"] = "Schlachtzug"
	L["Guild"] = "Gilde"
	L["Officer"] = "Offizier"
	L["Whisper"] = "Flüstern"
	L["Whisper Target"] = "Flüstern an Dein Ziel"
	L["Blocked"] = "Geblockt"
	L["Absorbed"] = "Absorbiert"
	L["Guardian"] = "Wächter"
	L["Click for next Pet"] = "Für nächsten Begleiter klicken"
	L["Outside Instances"] = "Instanzen im Freien"
	L["Party Instances"] = "Gruppeninstanzen"
	L["Raid Instances"] = "Schlachtzuginstanzen"
	L["Battlegrounds"] = "Schlachfelder"
	L["Arenas"] = "Arenen"
	L["Content-based Filters"] = "Inhaltsbasierter Filter"
	L["Show Total Bar"] = "Zeige Gesamtbalken"
	L["Config Access"] = "Konfiguration Zugriff"
	L["Window Options"] = "Fenster Optionen"
	L["Sync Options"] = "Sync Optionen"
	L["Hostile"] = "Feindselig"
	L["Rank Number"] = "Plazierung"
	L["Bar Text Options"] = "Balkentext"
	L["Per Second"] = "Pro Sekunde"
	L["Percent"] = "Prozent"
	L["Fight Segmentation"] = "Kampfsegmente"
	L["Keep Only Boss Segments"] = "Nur Bosssegmente behalten"
	L["Click|r to toggle the Recount window"] = "Klicken|r um das Recount-Fenster ein-/auszublenden"
	L["Right-click|r to open the options menu"] = "Rechtsklick|r um das Optionsfenster zu öffnen"
	L["Number Format"] = "Nummerformatierung"
	L["Standard"] = "Standard"
	L["Commas"] = "Kommas"
	L["Short"] = "Kurz"