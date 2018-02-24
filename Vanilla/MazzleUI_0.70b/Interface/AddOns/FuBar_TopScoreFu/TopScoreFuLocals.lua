local L = AceLibrary("AceLocale-2.2"):new("TopScoreFu")

L:RegisterTranslations("enUS", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "Keeps track of your top hits, heals, criticals, etc.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "showSplash",
		["ARGUMENT_PLAYNOISE"] = "playNoise",
		["ARGUMENT_SCREENSHOT"] = "screenshot",
		["ARGUMENT_HEALING"] = "healing",
		["ARGUMENT_DAMAGE"] = "damage",
		["ARGUMENT_ONLYPVP"] = "onlyPvP",
		["ARGUMENT_RESET"] = "reset",
		["ARGUMENT_POSITION"] = "position",
		["ARGUMENT_SHOWTRIVIAL"] = "trivial",

		["MENU_SHOW_SPLASH"] = "Show splash",
		["MENU_PLAY_NOISE"] = "Play noise",
		["MENU_TAKE_SCREENSHOTS"] = "Take screenshots",
		["MENU_INCLUDE_HEALING"] = "Include healing",
		["MENU_INCLUDE_DAMAGE"] = "Include damage",
		["MENU_VS_MONSTERS"] = "vs. Monsters",
		["MENU_RESET_SCORES"] = "Reset scores",
		["MENU_SHOW_TRIVIAL"] = "Trivial scores",
		["MENU_FILTER"] = "Filter",
		["MENU_PURGE"] = "Purge",
	
		["TEXT_NORMAL"] = "Normal",
		["TEXT_CRITICAL"] = "Critical",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "Critical %s",
		["TEXT_SCORES_RESET"] = "Scores reset",
		["TEXT_SET_POSITION_ERROR"] = "You must give the position in the form of `x y`, where x and y are numbers.",

		["HINT"] = "Shift-Click to insert your highest scores in chat edit box.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "New critical %s record!\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "New %s record!\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "Position now %d, %d",
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "Protokolliert Eure h\195\182chsten Treffer, h\195\182chste Heilung, h\195\182chsten kritischen Treffer, etc.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "showSplash",
		["ARGUMENT_PLAYNOISE"] = "playNoise",
		["ARGUMENT_SCREENSHOT"] = "screenshot",
		["ARGUMENT_HEALING"] = "healing",
		["ARGUMENT_DAMAGE"] = "damage",
		["ARGUMENT_ONLYPVP"] = "onlyPvP",
		["ARGUMENT_RESET"] = "reset",
		["ARGUMENT_POSITION"] = "position",
		["ARGUMENT_SHOWTRIVIAL"] = "trivial",

		["MENU_SHOW_SPLASH"] = "Zeige Einblendung",
		["MENU_PLAY_NOISE"] = "Sound abspielen",
		["MENU_TAKE_SCREENSHOTS"] = "Screenshot anfertigen",
		["MENU_INCLUDE_HEALING"] = "Heilung einbeziehen",
		["MENU_INCLUDE_DAMAGE"] = "Schaden einbeziehen",
		["MENU_VS_MONSTERS"] = "Treffer gegen Monster",
		["MENU_RESET_SCORES"] = "Werte zur\195\188cksetzen",
		["MENU_SHOW_TRIVIAL"] = "Ergebnisse bei grauen Zielen",
		["MENU_FILTER"] = "Filter", -- CHECK
		["MENU_PURGE"] = "Purge", -- CHECK

		["TEXT_NORMAL"] = "Normal",
		["TEXT_CRITICAL"] = "Kritisch",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "kritische/r %s",
		["TEXT_SCORES_RESET"] = "Werte zur\195\188ckgesetzt",
		["TEXT_SET_POSITION_ERROR"] = "Die Position muss in der Form `x y` angegeben werden, wobei x und y Zahlen sind.",

		["HINT"] = "Shift-Linksklick f\195\188gt Eure Rekorde in die Chat-Eingabezeile ein.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "Neuer Crit-Rekord mit %s !\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "Neuer Rekord mit %s !\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "Position auf %d, %d eingestellt",
	}
end)

L:RegisterTranslations("frFR", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "Garde une trace de vos records de vos soins, coups, etc.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "Montrer Splash",
		["ARGUMENT_PLAYNOISE"] = "Jouer Son",
		["ARGUMENT_SCREENSHOT"] = "Screenshot",
		["ARGUMENT_HEALING"] = "Soins",
		["ARGUMENT_DAMAGE"] = "Dommage",
		["ARGUMENT_ONLYPVP"] = "SeulementPvP",
		["ARGUMENT_RESET"] = "Reset",
		["ARGUMENT_POSITION"] = "Position",
		["ARGUMENT_SHOWTRIVIAL"] = "Trivial",

		["MENU_SHOW_SPLASH"] = "Splash Ecran",
		["MENU_PLAY_NOISE"] = "Jouer son",
		["MENU_TAKE_SCREENSHOTS"] = "Faire screenshots",
		["MENU_INCLUDE_HEALING"] = "Inclus Soins",
		["MENU_INCLUDE_DAMAGE"] = "Inclus dommage",
		["MENU_VS_MONSTERS"] = "vs. Monstres",
		["MENU_RESET_SCORES"] = "Remise \195\160 zero",
		["MENU_SHOW_TRIVIAL"] = "Trivial scores",
		["MENU_FILTER"] = "Filtre", -- CHECK
		["MENU_PURGE"] = "Purge", -- CHECK

		["TEXT_NORMAL"] = "Normal",
		["TEXT_CRITICAL"] = "Critique",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "Critique %s",
		["TEXT_SCORES_RESET"] = "Remise \195\160 zero",
		["TEXT_SET_POSITION_ERROR"] = "You must give the position in the form of `x y`, where x and y are numbers.",

		["HINT"] = "Shift-Click pour mettre votre meilleur score dans la boite de chat.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "Nouveau record critique pour %s!\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "Nouveau record pour %s!\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "Position actuelle %d, %d",
	}
end)
