-- -------------------------------------- --
-- Deadly Boss Mods - german localization --
--          by DeadlyMinds|Tandanu        --
-- -------------------------------------- --

if (GetLocale() == "deDE") then
	--classes
	DBM_MAGE		= "Magier";
	DBM_PRIEST		= "Priester";
	DBM_PALADIN	= "Paladin";
	DBM_DRUID		= "Druide";
	DBM_WARLOCK	= "Hexenmeister";
	DBM_ROGUE		= "Schurke";
	DBM_HUNTER		= "Jäger";
	DBM_WARRIOR	= "Krieger";
	DBM_SHAMAN		= "Schamane";
	
	--zones
	DBM_NAXX			= "Naxxramas";
	DBM_AQ40			= "Ahn'Qiraj";
	DBM_BWL			= "Pechschwingenhort";
	DBM_MC				= "Geschmolzener Kern";
	DBM_AQ20			= "Ruinen von Ahn'Qiraj";
	DBM_ZG				= "Zul'Gurub";
	DBM_ONYXIAS_LAIR	= "Onyxias Hort";
	DBM_DUSKWOOD		= "Dämmerwald";
	DBM_ASHENVALE		= "Eschental"; --das ist ein guter grund englischen client zu verwenden...
	DBM_FERALAS		= "Feralas";
	DBM_HINTERLANDS	= "Das Hinterland";
	DBM_BLASTED_LANDS	= "Die verwüsteten Lande";
	DBM_AZSHARA		= "Azshara";
	DBM_ARATHI			= "Arathibecken";
	DBM_WARSONG		= "Kriegshymnenschlucht";
	DBM_ALTERAC		= "Alteractal";
	DBM_OTHER			= "Sonstige";
	DBM_HELLFIRE	= "Höllenfeuerhalbinsel";

	DBM_EYEOFTHESTORM = "Auge des Sturms";
	DBM_GRUULS_LAIR	= "Gruuls Unterschlupf";
	DBM_MAGS_LAIR	= "Magtheridons Kammer";	
	
	--spells/buffs
	DBM_CHARGE			= "Sturmangriff";
	DBM_FERALCHARGE	= "Wilde Attacke";
	DBM_BLOODRAGE		= "Blutrausch";
	DBM_REDEMPTION		= "Geist der Erlösung";
	DBM_FEIGNDEATH		= "Totstellen";
	DBM_MINDCONTROL	= "Gedankenkontrolle";
	
	--key bindings
	BINDING_HEADER_DBM	= "Deadly Boss Mods";
	BINDING_NAME_DBMTOGGLE	= "GUI anzeigen";
	
	--OnLoad messages
	DBM_LOADED			= "Deadly Boss Mods v%s von DeadlyMinds|Tandanu @ EU-Aegwynn und La Vendetta|Nitram @ EU-Azshara geladen.";
	DBM_MODS_LOADED	= "%s %s Boss Mods geladen."
	
	--Slash command messages
	DBM_MOD_ENABLED		= "Boss Mod aktiviert.";
	DBM_MOD_DISABLED		= "Boss Mod deaktiviert.";
	DBM_ANNOUNCE_ENABLED	= "Ansage aktiviert.";
	DBM_ANNOUNCE_DISABLED	= "Ansage deaktiviert.";
	DBM_MOD_STOPPED		= "Timer angehalten.";
	DBM_MOD_INFO			= "Boss Mod v%s von %s";
	DBM_SLASH_HELP1		= " on/off";
	DBM_SLASH_HELP2		= " announce on/off";
	DBM_SLASH_HELP3		= " stop";
	DBM_SLASH_HELP4		= "Du kannst auch %s anstelle von /%s verwenden.";
	DBM_RANGE_CHECK		= "Weiter als 30 Meter weg: ";
	DBM_FOUND_CLIENTS		= "%s Spieler mit Deadly Boss Mods gefunden";
	
	--Sync options
	DBM_SOMEONE_SET_SYNC_CHANNEL	= "%s hat den Sync Channel auf %s gesetzt.";
	DBM_SET_SYNC_CHANNEL			= "Sync Channel wurde auf %s gesetzt.";
	DBM_CHANNEL_NOT_SET			= "Channel nicht gesetzt. Broadcasten nicht m\195\182glich.";
	DBM_NEED_LEADER				= "Du musst Gruppenanf\195\188hrer oder bef\195\182rdert sein um den Channel zu broadcasten!";
	DBM_NEED_LEADER_STOP_ALL		= "Du musst Gruppenanf\195\188hrer oder bef\195\192rdert sein um diese Funktion zu verwenden!";
	DBM_ALL_STOPPED				= "Alle Timer gestoppt.";
	DBM_REC_STOP_ALL				= "'Stop all' Befehl von %s empfangen.";

	--Update dialog
	DBM_UPDATE_DIALOG		= "Deine Version von Deadly Boss Mods ist veraltet!\n%s und %s haben Version %s.\nBitte downloade die neuste Version von www.deadlybossmods.com."	
	DBM_YOUR_VERSION_SUCKS	= "Deine Version von Deadly Boss Mods ist veraltet! Bitte downloade die neuste Version von www.deadlybossmods.com.";
	DBM_REQ_PATCHNOTES		= "Fordere Patchnotes von %s an...bitte warten.";
	DBM_SHOW_PATCHNOTES	= "Patchnotes anzeigen";
	DBM_PATCHNOTES			= "Patchnotes";

	--Status Bar Timers
	DBM_SBT_TIMELEFT				= "Verbleibende Zeit:";
	DBM_SBT_TIMEELAPSED			= "Verstrichene Zeit:";
	DBM_SBT_TOTALTIME				= "Gesamte Zeit:";
	DBM_SBT_REPETITIONS			= "Wiederholungen:";
	DBM_SBT_INFINITE				= "unendlich";
	DBM_SBT_BOSSMOD				= "Boss Mod:";
	DBM_SBT_STARTEDBY				= "Gestartet von:";
	DBM_SBT_RIGHTCLICK				= "Rechtsklick um die Bar zu verstecken.";
	DBM_SBT_LEFTCLICK				= "Shift + Linksklick um die Bar im Chat zu schreiben.";
	DBM_TIMER_IS_ABOUT_TO_EXPIRE	= "Timer \"%s\" läuft gleich ab!";
	DBM_BAR_STYLE_DEFAULT			= "Standard";
	DBM_BAR_STYLE_MODERN			= "Modern";
	DBM_BAR_STYLE_CLOUDS			= "Wolken";
	DBM_BAR_STYLE_PERL				= "Perl";
	
	--Combat messages
	DBM_BOSS_ENGAGED			= "Kampf gegen %s hat begonnen. Viel Glück! :)";
	DBM_BOSS_SYNCED_BY			= "(Sync Befehl von %s erhalten)";
	DBM_BOSS_DOWN				= "%s tot nach %s!";
	DBM_COMBAT_ENDED			= "Kampf hat nach %s aufgehört.";
	DBM_DEFAULT_BUSY_MSG		= "%P ist gerade damit beschäftigt gegen %B zu kämpfen (%HP, %ALIVE/%RAID am Leben). Du wirst nach dem Kampf informiert.";
	DBM_RAID_STATUS_WHISPER	= "%B - %HP - %ALIVE/%RAID am Leben.";
	DBM_SEND_STATUS_INFO		= "Sende \"status\" an mich um den Status abzufragen.";
	DBM_AUTO_RESPOND_SHORT		= "Automatisch geantwortet.";
	DBM_AUTO_RESPOND_LONG		= "Automatisch auf ein Whisper von %s geantwortet.";
	DBM_MISSED_WHISPERS		= "Verpasste Whisper während dem Kampf:";
	DBM_BALCONY_PHASE			= "Balkon Phase #%s";
	
	--Misc stuff
	DBM_YOU					= "Ihr";
	DBM_ARE					= "seid";
	DBM_IS						= "ist";
	DBM_OR						= "oder";
	DBM_AND					= "und";
	DBM_UNKNOWN				= "unbekannt";
	DBM_LOCAL					= "lokal";
	DBM_DEFAULT_DESCRIPTION	= "Beschreibung nicht verfügbar";
	DBM_SEC					= "Sek";
	DBM_MIN					= "Min";
	DBM_SECOND					= "Sekunde";
	DBM_SECONDS				= "Sekunden";
	DBM_MINUTES				= "Minuten";
	DBM_MINUTE					= "Minute";
	DBM_HIT					= "trifft";
	DBM_CRIT					= "kritisch";
	DBM_MISS					= "verfehlt";
	DBM_DODGE					= "ausgewichen";
	DBM_PARRY					= "parriert";
	DBM_FROST					= "Frostschaden";
	DBM_ARCANE					= "Arkanschaden";
	DBM_FIRE					= "Feuerschaden";
	DBM_HOLY					= "Heiligschaden";
	DBM_NATURE					= "Naturschaden";
	DBM_SHADOW					= "Schattenschaden";
	DBM_CLOSE					= "Schließen";
	DBM_AGGRO_FROM				= "Aggro von ";
	DBM_SET_ICON				= "Icon setzen";
	DBM_SEND_WHISPER			= "Whisper verschicken";
	DBM_DEAD					= "Tot";
	DBM_OFFLINE				= "Offline";
	DBM_PHASE					= "Phase %s";
	DBM_WAVE					= "Welle %s";
	

	--added @ 1.12.06
	DBM_LEFT	= "links";
	DBM_RIGHT	= "rechts";
	


	DBMGUI_DISTANCE_FRAME_TITLE		= "Distanz";
	DBMGUI_DISTANCE_FRAME_TEXT		= "Zu nah:";
	DBMGUI_DISTANCE_FRAME_TEXT_15YD	= "Zu nah (15m):";
	
	DBM_GUI_COMBATLOG_RANGE_TITLE      = "Combatlog Reichweite";
	
	DBMGUI_INFOFRAME_TOOLTIP_TITLE		= "Info Frame";
	DBMGUI_INFOFRAME_TOOLTIP_TEXT		= "Rechtsklick zum Bewegen\nShift + Rechtsklick zum schließen";

	DBMGUI_STATUSBAR_WIDTH_SLIDER		= "Bar Breite";
	DBMGUI_STATUSBAR_SCALE_SLIDER		= "Bar Skalierung";

	DBMGUI_BUTTON_RANGECHECK		= "Range Check";
	DBMGUI_TOOLTIP_RANGECHECK_TITLE	= "Range Check";
	DBMGUI_TOOLTIP_RANGECHECK_TEXT		= "Startet einen Range Check der alle Spieler anzeigt, die weiter als 30 Meter von dir entfernt stehen.";

	DBMGUI_BUTTON_DISTANCEFRAME		= "Distanz Frame";
	DBMGUI_TOOLTIP_DISTANCEFRAME_TITLE	= "Distanz Frame";
	DBMGUI_TOOLTIP_DISTANCEFRAME_TEXT	= "Zeigt oder versteckt ein Distanz Check Frame, welches alle Spieler anzeigt die zu nah bei dir stehen (10 Meter). Dieses Frame ist nützlich für Encounter wie C'Thun oder Huhuran.";
	
	-- Added 2.12.06
	DBM_NAME			= "Name";
	DBM_DURABILITY		= "Haltbarkeit";
	
	-- Added 13.12.06
	DBM_TIMER_SLASHCMD_HELP1	= "/dbm timer <time> <text>  -  startet einen Timer";
	DBM_TIMER_SLASHCMD_HELP2	= "/dbm broadcast timer <time> <text>  -  broadcastet einen Timer";

	-- Added 20.12.06
	DBM_HORDE		= "Horde";
	DBM_ALLIANCE	= "Allianz";
	
	-- Added 22.12.06
	DBM_ENABLED_GREEN	= GREEN_FONT_COLOR_CODE.."aktiviert"..FONT_COLOR_CODE_CLOSE;
	DBM_DISABLED_RED	= RED_FONT_COLOR_CODE.."deaktiviert"..FONT_COLOR_CODE_CLOSE;
	DBM_ERROR			= "Fehler";
	
	DBMGUI_TAB_1_TITLE_TEXT		= "Naxxramas Boss Mods";
	DBMGUI_TAB_2_TITLE_TEXT		= "Temple von Ahn'Qiraj Boss Mods";
	DBMGUI_TAB_3_TITLE_TEXT		= "Pechschwingenhort Boss Mods";
	DBMGUI_TAB_4_TITLE_TEXT		= "Geschmolzener Kern Boss Mods";

	DBMGUI_TAB_6_TITLE_TEXT		= "Sonstige Boss Mods";
	DBMGUI_TAB_ZG_TITLE_TEXT	= "Zul'Gurub Boss Mods";
	DBMGUI_TAB_AQ20_TITLE_TEXT	= "Ruinen von Ahn'Qiraj Boss Mods";
	
	
	DBM_EAL_MOBCASTSTART_EXPR	= "(.+) beginnt (.+) .+%.";
	DBM_EAL_MOBCAST_EXPR		= "(.+) wirkt (.+)%.";
	DBM_EAL_DEBUFF_EXPR			= "([^%s]+) %w+ von (.+) betroffen%.";
	DBM_EAL_MOB_BUFF_EXPR		= "(.+) bekommt '(.+)'%.";
	DBM_EAL_MOBDEAD_EXPR		= "(.+) stirbt%.";
	
	DBM_BOSS_MOD_LOADED	= "Boss Mods für '%s' geladen!";
	DBM_ERROR_LVBM_STILL_LOADED	= "Du hast die alten Ordner nicht gelöscht, Deadly Boss Mods läuft doppelt!\nKlick auf \"Okay\" um die alte Version zu deaktivieren und dein Interface neu zu laden.\nDie alten Ordner musst du dann nicht mehr löschen.";
	DBM_DISABLE_AND_RELOAD		= "Okay";
	
	--.--
	DBM_KAZZAK_NAME			= "Verdammnislord Kazzak";
	DBM_DOOMW_NAME			= "Verdammniswandler";
	
	
	--18.3.07
	DBM_HEAVY_NW_BANDAGE		= "Schwerer Netherstoffverband";
	
	DBM_HP_UNKNOWN				= "HP unbekannt"
	
	DBMGUI_OPTIONS_BAR_TARGET	= "<Ziel>"
	
	DBM_NO_TARGET				= "<kein Ziel>"
end
