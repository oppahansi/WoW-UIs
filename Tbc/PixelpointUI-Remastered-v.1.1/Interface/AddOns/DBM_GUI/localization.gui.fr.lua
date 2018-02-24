---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

----------------------------------
-- Translation FR --
----------------------------------

if( GetLocale() == "frFR" ) then

-- DBM_GUI.lua for Bossmod List Frame (DBMBossModListFrame)
DBMGUI_TAB_1_TITLE_TEXT		= "Boss Mods Naxxramas";
DBMGUI_TAB_2_TITLE_TEXT		= "Boss Mods Temple d'Ahn'Qiraj";
DBMGUI_TAB_3_TITLE_TEXT		= "Boss Mods Repaire de l'Aile Noire";
DBMGUI_TAB_4_TITLE_TEXT		= "Boss Mods Coeur du Magma";
DBMGUI_TAB_5_TITLE_TEXT		= "Boss Mods Zul'Gurub et Ahn'Qiraj";
DBMGUI_TAB_6_TITLE_TEXT		= "Autres Boss Mods";

-- Tooltips
DBMGUI_FRAMETAB_1_TT			= "Boss Mods Naxxramas";
DBMGUI_FRAMETAB_1_TD			= "Une liste de nos Boss Mods pour Naxxramas. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
DBMGUI_FRAMETAB_2_TT			= "Boss Mods Temple d'Ahn'Qiraj";
DBMGUI_FRAMETAB_2_TD			= "Une liste de nos Boss Mods pour le Temple d'Ahn'Qiraj. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
DBMGUI_FRAMETAB_3_TT			= "Boss Mods Repaire de l'Aile Noire";
DBMGUI_FRAMETAB_3_TD			= "Une liste de nos Boss Mods pour le Repaire de l'Aile Noire. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
DBMGUI_FRAMETAB_4_TT			= "Boss Mods Coeur du Magma";
DBMGUI_FRAMETAB_4_TD			= "Une liste de nos Boss Mods pour le Coeur du Magma. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";
DBMGUI_FRAMETAB_5_TT			= "Boss Mods Zul'Gurub et Ahn'Qiraj";
DBMGUI_FRAMETAB_5_TD			= "Une liste de nos Boss Mods pour Zul'Gurub et Ahn'Qiraj 20. Selectionnez un boss pour acc\195\169der aux Options Additionnelles.";

DBMGUI_DISABLE_ADDON			= "D\195\169sactiver AddOn";
DBMGUI_ENABLE_ADDON			= "Activer AddOn";
DBMGUI_STOP_ADDON				= "Arr\195\170ter AddOn";
DBMGUI_DISABLE_ANNOUNCE		= "D\195\169sactiver Annonce";
DBMGUI_ENABLE_ANNOUNCE			= "Activer Annonce";
DBMGUI_SHOW_DROPDOWNMENU		= "Options add.";
DBMGUI_DROPDOWNMENU_TITLE		= "Boss Mod Menu";

-- DBMBossModFrame
DBMGUI_HIDE_OPTIONS				= "<<< Options";
DBMGUI_SHOW_OPTIONS				= "Options >>>";

-- Options Frame (DBMOptionsFrame)
DBMGUI_OPTIONS					= "Options (GUI v"..DBMGUI_VERSION.." / Boss Mod v"..(DBM.BetaVersion or DBM.Version)..")";
DBMGUI_SIDEFRAME_TAB1				= "General";
DBMGUI_SIDEFRAME_TAB2				= "Barres";
DBMGUI_SIDEFRAME_TAB3				= "Alertes";
DBMGUI_SIDEFRAME_TAB4				= "Autres";

-- DBMOptionsFramePage1
DBMGUI_TITLE_SYNCSETTINGS			= "Options de Synchronization";
DBMGUI_TITLE_MINIMAPBUTTON			= "Options du Boutton Minimap";
DBMGUI_TITLE_AGGROALERT			= "Options d'Aggro Alert";
DBMGUI_CHECKBOX_SYNC_ENABLE			= "Activer synchronization";
DBMGUI_BUTTON_VERSION_CHECK			= "Recherche";
DBMGUI_BUTTON_VERSION_CHECK_FAILD		= "Aucun autre utilisateur de Vendetta n'a \195\169t\195\169 trouv\195\169";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO		= "Infos de synchro";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD 	= "Aucune synchronisation trouv\195\169e.";
DBMGUI_SLIDER_MINIMAP_1			= "Position";
DBMGUI_SLIDER_MINIMAP_2			= "Rayon";
DBMGUI_CHECKBOX_MINIMAP			= "Afficher le bouton";
DBMGUI_CHECKBOX_AGGROALERT_ENABLE		= "Activer Aggro Alert";
DBMGUI_BUTTON_AGGROALERT_TEST			= "Tester Aggro Alert";
DBMGUI_BUTTON_AGGROALERT_RESET			= "Par d\195\169faut";
DBMGUI_BUTTON_AGGROALERT_RESET_DONE		= "Aggro Alert \195\160 bien \195\169t\195\169 reset";
DBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND		= "Jouer un son";
DBMGUI_CHECKBOX_AGGROALERT_FLASH		= "Flash";
DBMGUI_CHECKBOX_AGGROALERT_SHAKE		= "Secousses";
DBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT		= "Afficher les alertes sp\195\169ciales";
DBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING	= "Afficher les alertes comme des alertes locales";
DBMGUI_BUTTON_MOVEABLEBAR			= "Barre Mobile";
DBMGUI_BUTTON_DEFAULTS				= "Par d\195\169faut";

-- DBMOptionsFramePage2
DBMGUI_TITLE_STATUSBARS 			= "Options Barres de status";
DBMGUI_TITLE_PIZZATIMER			= "Cr\195\169er \"Pizza Timer\"";
DBMGUI_CHECKBOX_STATUSBAR_ENABLE		= "Activers Barres de status";
DBMGUI_CHECKBOX_STATUSBAR_FILLUP		= "Remplir les barres de status";
DBMGUI_CHECKBOX_STATUSBAR_FLIPOVER		= "Ajuster hauteur";
DBMGUI_EDITBOX_PIZZATIMER_TEXT			= "Nom";
DBMGUI_EDITBOX_PIZZATIMER_MIN			= "Minutes";
DBMGUI_EDITBOX_PIZZATIMER_SEC			= "Seconds";
DBMGUI_CHECKBOX_PIZZATIMER_BROADCAST		= "Broadcast timer au raid";
DBMGUI_BUTTON_PIZZATIMER_START			= "Lancer le timer";

-- DBMOptionsFramePage3
DBMGUI_TITLE_RAIDWARNING			= "Alertes Raid";
DBMGUI_TITLE_SELFWARNING			= "Alerts Locales"; 
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_1		= "RaidWarning (Son par d\195\169faut)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_2		= "BellTollNightElf (Son CT_Raid)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_3		= "D\195\169sactiver Sons d'alerte";
DBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED	= "Sons d'alerte d\195\169sactiv\195\169s";
DBMGUI_RAIDWARNING_EXAMPLE			= "*** Exemple d'Alerte Raid ***";
DBMGUI_BUTTON_SOUND_TEST			= "Sons test\195\169s";
DBMGUI_BUTTON_SHOW_EXAMPLE			= "Exemple";
DBMGUI_BUTTON_RAIDWARNING_RESET		= "Reset frame";
DBMGUI_BUTTON_RAIDWARNING_RESET_DONE		= "Les configurations ont bien \195\169t\195\169 remises \195\170 z\195\169ro";

-- DBMOptionsFramePage4
DBMGUI_TITLE_SPECIALWARNING			= "Alertes sp\195\169ciales";
DBMGUI_TITLE_SHAKESCREEN			= "Effets de secousses de l'\195\169cran";
DBMGUI_TITLE_FLASHEFFECT			= "Effets de flash";
DBMGUI_CHECKBOX_SPECWARNING_ENABLE		= "Activers les alertes sp\195\169ciales";
DBMGUI_BUTTON_SPECWARNING_TEST			= "Test alertes";
DBMGUI_BUTTON_SPECWARNING_EXAMPLE		= "Message de Test :)";
DBMGUI_SLIDER_SPECWARNING_DURATION		= "Dur\195\169e";
DBMGUI_SLIDER_SPECWARNING_FADETIME		= "Temps de fade";
DBMGUI_SLIDER_SPECWARNING_TEXTSIZE		= "Taille du texte";
DBMGUI_CHECKBOX_SHAKESCREEN_ENABLE		= "Activers effets de secousses";
DBMGUI_BUTTON_SHAKESCREEN_TEST			= "Test secousses";
DBMGUI_SLIDER_SHAKESCREEN_DURATION		= "Dur\195\169e";
DBMGUI_SLIDER_SHAKESCREEN_INTENSITY		= "Intensit\195\169";
DBMGUI_CHECKBOX_FLASHEFFECT_ENABLE		= "Activer effets de flash";
DBMGUI_BUTTON_FLASHEFFECT_TEST			= "Test flash";
DBMGUI_SLIDER_FLASHEFFECT_DURATION		= "Dur\195\169e";
DBMGUI_SLIDER_FLASHEFFECT_FLASHES		= "Nombre";

-- DBMOptionsFramePage5
DBMGUI_ABOUTTITLE	= "About";
DBMGUI_ABOUTTEXT	= {
	"Deadly Boss Mods API (c) by DeadlyMinds Tandanu",
	"Deadly Boss Mods GUI (c) by La Vendetta Nitram",
	"French Translation by Proreborn",
	" ",
	"Merci d'utiliser La Vendetta Boss Mods.",
	" ",
	"                                  Visitez",
	" ",
	"                   www.deadlyminds.net",
	" ",
	"                                   et",
	" ",
	"                 www.curse-gaming.com",
	" ",
	"Si vous avez une suggection, un report de bug ou un commentaire, merci de poster sur www.curse-gaming.com ou sur nos forums @ www.deadlyminds.net",
};


-- Translations added v1.10
DBMGUI_SIDEFRAME_TAB5				= "Misc";
DBMGUI_SIDEFRAME_TAB6				= "About";

DBMGUI_SLIDER_STATUSBAR_COUNT			= "Nombre max.";
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_1		= "Classic Design"; --wird überflüssig mit dem Verwenden des Namens aus der Tabelle
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_2		= "Modern Style"; 
DBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR		= "Barre d'exemple";

DBMGUI_TITLE_AUTORESPOND			= "Options Auto-rep";
DBMGUI_CHECKBOX_AUTORESPOND_ENABLE		= "Auto-r\195\169pondre aux whisps pendant un encounter";
DBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS	= "Afficher les whisps pendant le combat";
DBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER	= "M'informer des whisps Auto-r\195\169pondus";
DBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY		= "Masquer les R\195\169ponses auto";

DBMGUI_EDITBOX_AUTORESPOND_TITLE		= "Message à envoyer pendant les encounters de boss";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER	= "Les champs suivants seront\nautomatiquement remplac\195\169s:";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1	= {"%P", "Votre nom"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2	= {"%B", "Nom du boss"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3	= {"%HP", "PdV du boss"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4	= {"%ALIVE", "Membres du raid en vie"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5	= {"%RAID", "Membres du raid"};

end
