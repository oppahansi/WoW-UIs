local L = AceLibrary("AceLocale-2.2"):new("FuBar_FriendsFu")

L:RegisterTranslations("deDE", function() return {
	["Group"] = "Gruppe",
	["Name"] = "Name",
	["Class"] = "Klasse",
	["Level"] = "Level",
	["Zone"] = "Zone",
	["Notes"] = "Notizen",
	["Show"] = "Anzeigen",
	["Align"] = "Ausrichtung",
	["Color"] = "Farbe",
	["None"] = "Keine",
	["Left"] = "Links",
	["Center"] = "Mitte",
	["Right"] = "Rechts",
	["Updating..."] = "Aktualisiere...",
	["You aren't having any known friends."] = "Ihr habt keine bekannten Freunde.",
	["All friends offline or filtered."] = "Alle Freunde offline oder gefiltert.",
	["Text"] = "Text",
	["Text Settings"] = "Text-Einstellungen",
	["Show Displayed"] = "Zeige Angezeigte",
	["Toggles display of number of unfiltered friends"] = "Schaltet die Anzeige der Anzahl ungefilterter Freunde um",
	["Show Online"] = "Zeige Online",
	["Toggles display of number of online friends"] = "Schaltet die Anzeige der Anzahl verbundener Freunde um",
	["Show Total"] = "Zeige Gesamt",
	["Toggles display of number of total friends known"] = "Schaltet die Anzeige der Gesamtzahl an bekannten Freunden um",
	["Tooltip"] = "Tooltip",
	["Tooltip Settings"] = "Tooltip-Einstellungen",
	["Sort"] = "Sortierung",
	["Sets sorting"] = "Stellt die Sortierung ein",
	["Group Indicator Settings"] = "Gruppenindikator-Einstellungen",
	["Toggles display of group indicators"] = "Schaltet die Anzeige der Gruppenindikatoren um",
	["Name Column Settings"] = "Namensspalten-Einstellungen",
	["Sets color of name column"] = "Stellt die Farbe der Namensspalte ein",
	["Status"] = "Status",
	["Toggles display of status"] = "Schaltet die Anzeige des Status um",
	["Class Column Settings"] = "Klassenspalten-Einstellungen",
	["Toggles display of class column"] = "Schaltet die Anzeige der Klassenspalte um",
	["Sets alignment of class column"] = "Stellt die Ausrichtung der Klassenspalte ein",
	["Level Column Settings"] = "Levelspalten-Einstellungen",
	["Toggles display of level column"] = "Schaltet die Anzeige der Levelspalte um",
	["Sets alignment of level column"] = "Stellt die Ausrichtung der Levelspalte ein",
	["Sets color of level column"] = "Stelt die Farbe der Levelspalte ein",
	["Relative"] = "Relativ",
	["Zone Column Settings"] = "Zonenspalten-Einstellungen",
	["Toggles display of zone column"] = "Schaltet die Anzeige der Zonenspalte um",
	["Sets alignment of zone column"] = "Stellt die Ausrichtung der Zonenspalte ein",
	["Sets color of zone column"] = "Stellt die Farbe der Zonenspalte ein",
	["Faction"] = "Fraktion",
	["Notes Column Settings"] = "Notizspalten-Einstellungen",
	["Show AuldLangSyne"] = "Zeige AuldLangSyne",
	["Toggles display of AuldLangSyne notes"] = "Schaltet die Anzeige der AuldLangSyne-Notiz um",
	["Show CT_PlayerNotes"] = "Zeige CT_PlayerNotes",
	["Toggles display of CT_PlayerNotes notes"] = "Schaltet die Anzeige der CT_PlayerNotes-Notiz um",
	["Sets alignment of notes column"] = "Stellt die Ausrichtung der Notizspalte ein",
	["Filter"] = "Filter",
	["Filter Settings"] = "Filter-Einstellungen",
	["Class Filter Settings"] = "Klassenfilter-Einstellungen",
	["Druid"] = "Druide",
	["Toggles display of Druids"] = "Schaltet die Anzeige von Druiden um",
	["Hunter"] = "J\195\164ger",
	["Toggles display of Hunters"] = "Schaltet die Anzeige von J\195\164gern um",
	["Mage"] = "Magier",
	["Toggles display of Mages"] = "Schaltet die Anzeige von Magiern um",
	["Paladin"] = "Paladin",
	["Toggles display of Paladins"] = "Schaltet die Anzeige von Paladinen um",
	["Priest"] = "Priester",
	["Toggles display of Priests"] = "Schaltet die Anzeige von Priestern um",
	["Rogue"] = "Schurke",
	["Toggles display of Rogues"] = "Schaltet die Anzeige von Schurken um",
	["Shaman"] = "Schamane",
	["Toggles display of Shamans"] = "Schaltet die Anzeige von Schamanen um",
	["Warlock"] = "Hexenmeister",
	["Toggles display of Warlocks"] = "Schaltet die Anzeige von Hexenmeistern um",
	["Warrior"] = "Krieger",
	["Toggles display of Warriors"] = "Schaltet die Anzeige von Kriegern um",
	["Level Filter Settings"] = "Levelfilter-Einstellungen",
	[" 1- 9"] = " 1- 9",
	["Toggles display of level 1 to 9 chars"] = "Schaltet die Anzeige von Charakteren der Stufen 1 bis 9 um",
	["10-19"] = "10-19",
	["Toggles display of level 10 to 19 chars"] = "Schaltet die Anzeige von Charakteren der Stufen 10 bis 19 um",
	["20-29"] = "20-29",
	["Toggles display of level 20 to 29 chars"] = "Schaltet die Anzeige von Charakteren der Stufen 20 bis 29 um",
	["30-39"] = "30-39",
	["Toggles display of level 30 to 39 chars"] = "Schaltet die Anzeige von Charakteren der Stufen 30 bis 39 um",
	["40-49"] = "40-49",
	["Toggles display of level 40 to 49 chars"] = "Schaltet die Anzeige von Charakteren der Stufen 40 bis 49 um",
	["50-59"] = "50-59",
	["Toggles display of level 50 to 59 chars"] = "Schaltet die Anzeige von Charakteren der Stufen 50 bis 59 um",
	["60"] = "60",
	["Toggles display of level 60 chars"] = "Schaltet die Anzeige von Charakteren der Stufe 60 um",
	["Zone Filter Settings"] = "Zonenfilter-Einstellungen",
	["In Battleground"] = "Auf dem Schlachtfeld",
	["Toggles display of chars in battlegrounds"] = "Schaltet die Anzeige von Charakteren auf Schlachtfeldern um",
	["In Instance"] = "In einer Instanz",
	["Toggles display of chars in instances"] = "Schaltet die Anzeige von Charakteren in Instanzen um",
	["In Open Field"] = "Im freien Feld",
	["Toggles display of chars in open field"] = "Schaltet die Anzeige von Charakteren im freien Feld um",
} end)
