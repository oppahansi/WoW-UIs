local L = AceLibrary("AceLocale-2.2"):new("XLoot")

L:RegisterTranslations("deDE", function() return {
		catSnap = "Fenster Verhalten",
		catLoot = "Loot Verhalten",
		catFrame = "Fenster Optionen",
		catInfo = "Loot Informationen",
		catGeneralAppearance = "Allgemeines Aussehen",
		catFrameAppearance = "Fenster Aussehen",
		catLootAppearance = "Loot Aussehen",
		
		optLock = "Sperre Fenster",
		optOptions = "GUI Optionen",
		optBehavior = "Verhalten",
		optCursor = "Lootfenster beim Cursor einrasten",
		optSmartsnap = "Nur Vertikal einrasten",
		optSnapoffset = "Versatz des Lootfensters",
		optCollapse = "Verstecke leere Loot Schaltfl\195\164chen",
		optDragborder = "Ziehbarer Rahmen",
		optLootexpand = "Passe die Fensterweite an den Lootnamen an",
		optAltoptions = "Zeige Men\195\188 bei ALT+Rechtsklick",
		optSwiftloot = "Verstecke Fenster beim auto. Looten",
		optQualitytext = "Zeige Itemqualit\195\164tstext",
		optInfotext = "Zeige Iteminformationstext",
		["Show BoP/BoE/BoU"] =  "Zeige BoP/BoE/BoU",
		["Show Bind on Pickup/Bind on Equip/Bind on Use text opposite stack size for items"] = "Zeige, wird gebunden beim Aufheben/Anlegen/Benutzen Text und umgekehrte Stapelgr\195\182\195\159e f\195\188r Items an", -- maybe split it to two vars, its a bit wired?
		optLinkAll = "Link All Schalter",
		optLinkAllVis = "Sichtbarkeit: ",
		optLinkAllThreshold = "Linkgrenzwert",
		optLinkAllChannels = "Immer verkn\195\188pfen nach...",
		optAppearance = "Aussehen",
		optQualityborder = "Rahmen nach Qualit\195\164t einf\195\164rben",
		optQualityframe = "Fenster nach Qualit\195\164t einf\195\164rben",
		optLootqualityborder = "Rahmen nach Qualit\195\164t einf\195\164rben",
		optBgcolor = "Hintergrundfarbe",
		optBordercolor = "Rahmenfarbe",
		optTexColor = "Symbol nach Qualit\195\164t einf\195\164rben",
		optHighlightLoot = "Glanzlicht nach Qualit\195\164t einf\195\164rben",
		optHighlightThreshold = "Grenzwert f\195\188r das Glanzlicht", 
		optLootbgcolor = "Hintergrundfarbe",
		optLootbordercolor = "Rahmenfarbe",
		optInfoColor = "Informationstextfarbe",
		optScale = "Skalierung",
		optAdvanced = "Erweiterte Optionen",
		optDebug = "Fehlersuchprogramm einschalten",
		optDefaults = "Zur\195\188cksetzten der Optionen",
		
		descLock = "Fixiert das Lootfenster",
		descOptions = "Zeigt das Dropdownmen\195\188",
		descBehavior = "\195\132ndert das Verhten von XLoot",
		descCursor = "L\195\164sst das Lootfenster w\195\164hrend des Lootens immer beim Cursor einrasten",
		descSmartsnap = "L\195\164sst das Lootfenster nur Vertikal einrasten, damit wenn sich die Liste \195\164ndert das Fenster nicht herrum h\195\188pft",
		descSnapoffset = "Versetzt das Lootfenster Horizontal vom ersten Loot an",
		descCollapse = "Versteckt leere gelootete Schaltfl\195\164chen und plaziert den Cursor \195\188ber den n\195\164chste Loot, wenn Einrasten aktiviert ist",
		descDragborder = "Erlaubt das Bewegen des Lootfensters durch festhalten des Rahmens, anstatt nur \195\188ber die Schaltfl\195\164chen",
		descLootexpand = "\195\132ndert die Weite der Fenster passend zu den Namen der Loots",
		descAltoptions = "Erlaubt es durch ALT+RechtsKlick auf einen Loot das XLoot Men\195\188 aufzurufen. Kann deaktiviert werden um nicht mit anderen Addons zu interferieren",
		descSwiftloot = "Verhindert die Verz\195\182gerung beim automatischen Looten, n\195\164heres zu dieser Einstellung befindet sich unter den Spieleinstellungen - Inteface",
		descQualitytext = "Zeige eine weitere Zeile \195\188ber dem Itemnamen an mit der Itemqualit\195\164t",
		descInfotext = "Zeige eine weitere Zeile \195\188ber dem Itemnamen an mit Iteminformationen",
		descLinkAll = "Der Link All Schalter, eine Schaltfl\195\164che welche ein Men\195\188 \195\182ffnet mit allen verf\195\188gbaren Kan\195\164len an die der Loot gesendet werden kann",
		descLinkAllVis = "Wann der Link All Schalter sichtbar sein soll",
		descLinkAllThreshold = "Sende nur Links von Items h\195\182her des eingestellten Grenzwertes",
		descLinkAllChannels = "Sende immer an diese Kan\195\164le beim links klicken auf den Link All Schalter. |cFFFF0000Solange kein Standard eingestellt ist erscheint das komplette Men\195\188|r",
		descAppearance = "Farben, Skalierung, und Skin des XLootfensters sowie der Loot Schaltfl\195\164chen",
		descQualityborder = "F\195\164rbt das Lootfenster nach der h\195\182chsten Itemqualit\195\164t ein",
		descQualityframe = "F\195\164rbt den Lootfensterhintergrund nach der h\195\182chsten Itemqualit\195\164t ein",
		descLootqualityborder = "F\195\164rbt den Rahmen nach der h\195\182chsten Qualit\195\164t ein",
		descHighlightLoot = "Glanzlichter der Lootfenster nach der h\195\182chsten Qualit\195\164t",
		descHighlightThreshold = "Die kleinste Qualit\195\164t die \195\188berhaupt ein Glanzlicht bekommen soll",
		descBgcolor = "\195\132ndert die Hintergundfarbe des Lootfenster ansich",
		descBordercolor = "\195\132ndert die Rahmenfarbe des Lootfenster ansich",
		descTexColor = "F\195\164rbt den Rahmen der derzeitigen Itemsymbole oder Texturen nach Qualit\195\164t ein",
		descLootbgcolor = "\195\132ndert die Hintergrundfarbe f\195\188r jedes Lootitem",
		descLootbordercolor = "\195\132ndert die Rahmenfarbe f\195\188r jedes Lootitem",
		descInfoColor = "\195\132ndert die Farbe des Informationstextes",
		descScale = "Skaliert das Lootfenster",
		descAdvanced = "Options you may not want to mess with, but can anyway",
		descDebug = "Zeige Fehlermeldungen an",
		descDefaults = "Alles auf XLoot Standard zur\195\188cksetzen",
		
		qualityQuest = "Verschiedenes",
	
		guiTitle = "XLoot Optionen",
		
		itemWeapon = "Waffe",
		
		evHerbs = "Kr\195\164uter sammeln",
		evOpenNT = "\195\150ffnen - Kein Text",
		evOpen = "\195\150fnen",
		
		linkallloot = "Link all...",
		linkallchanneldesc = "Auto. senden der Itemlinks durch einen Linksklick an %s",
		}
end)
-- -- 
--    Ä : \195\132
--    Ö : \195\150
--    Ü : \195\156
--    ü : \195\188
--    ä : \195\164                    
--    ö : \195\182
--    ß : \195\159
-- -- 