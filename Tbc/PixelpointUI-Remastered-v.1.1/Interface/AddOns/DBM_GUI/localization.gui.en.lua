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
-- Translation by Default -> EN --
----------------------------------

-- DBM_GUI.lua for Bossmod List Frame (DBMBossModListFrame)

DBMGUI_DROPDOWN_LEVEL_1		= "Burning Crusade";
DBMGUI_DROPDOWN_LEVEL_2		= "WoW Classic";


DBMGUI_DISABLE_ADDON			= "Disable AddOn";
DBMGUI_ENABLE_ADDON			= "Enable AddOn";
DBMGUI_STOP_ADDON				= "Stop AddOn";
DBMGUI_DISABLE_ANNOUNCE		= "Disable Announce";
DBMGUI_ENABLE_ANNOUNCE			= "Enable Announce";
DBMGUI_SHOW_DROPDOWNMENU		= "Additional Options";
DBMGUI_DROPDOWNMENU_TITLE		= "Boss Mod Menu";

-- DBMBossModFrame
DBMGUI_HIDE_OPTIONS				= "<< Options";
DBMGUI_SHOW_OPTIONS				= "Options >>";

-- Options Frame (DBMOptionsFrame)
if( DBM.VersionBeta ) then
	DBMGUI_OPTIONS					= "DBM v"..DBM.Version.." - "..DBM.VersionBeta;
else
	DBMGUI_OPTIONS					= "Options (GUI v"..DBMGUI_VERSION.." / Boss Mod v"..(DBM.BetaVersion or DBM.Version)..")";
end
DBMGUI_SIDEFRAME_TAB1				= "General";
DBMGUI_SIDEFRAME_TAB2				= "Bars 1";
DBMGUI_SIDEFRAME_TAB3				= "Warnings";
DBMGUI_SIDEFRAME_TAB4				= "Specials";

-- DBMOptionsFramePage1
DBMGUI_TITLE_SYNCSETTINGS			= "Synchronization Setup";
DBMGUI_TITLE_MINIMAPBUTTON			= "Minimap Button Setup";
DBMGUI_TITLE_AGGROALERT			= "Aggro Alert Settings";
DBMGUI_CHECKBOX_SYNC_ENABLE			= "Enable synchronization";
DBMGUI_BUTTON_VERSION_CHECK			= "Version check";
DBMGUI_BUTTON_VERSION_CHECK_FAILD		= "No other Deadly Boss Mods clients found";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO		= "Status bar sync info";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD 	= "There are no bars.";
DBMGUI_SLIDER_MINIMAP_1			= "Position";
DBMGUI_SLIDER_MINIMAP_2			= "Radius";
DBMGUI_CHECKBOX_MINIMAP			= "Show minimap button";
DBMGUI_CHECKBOX_AGGROALERT_ENABLE		= "Enable aggro alert";
DBMGUI_BUTTON_AGGROALERT_TEST			= "Test aggro alert";
DBMGUI_BUTTON_AGGROALERT_RESET			= "Reset settings";
DBMGUI_BUTTON_AGGROALERT_RESET_DONE		= "Aggro alert has been resetted";
DBMGUI_BUTTON_AGGROALERT_ENABLE_PARTY	= "Enable aggro alert in 5 player instances";
DBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND	= "Play sound on aggro gain";
DBMGUI_CHECKBOX_AGGROALERT_FLASH		= "Flash on aggro gain";
DBMGUI_CHECKBOX_AGGROALERT_SHAKE		= "Shake on aggro gain";
DBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT		= "Show special warning";
DBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING	= "Show warning as local warning";
DBMGUI_BUTTON_MOVEABLEBAR			= "Movable bar";
DBMGUI_BUTTON_DEFAULTS				= "Defaults";

-- DBMOptionsFramePage2
DBMGUI_TITLE_STATUSBARS 			= "Status Bar Timer Setup";
DBMGUI_TITLE_PIZZATIMER			= "Create \"Pizza Timer\"";
DBMGUI_CHECKBOX_STATUSBAR_ENABLE		= "Enable status bars";
DBMGUI_CHECKBOX_STATUSBAR_FILLUP		= "Fill up status bars";
DBMGUI_CHECKBOX_STATUSBAR_FLIPOVER		= "Expand status bars upwards";
DBMGUI_EDITBOX_PIZZATIMER_TEXT			= "Name";
DBMGUI_EDITBOX_PIZZATIMER_HOUR			= "Hours";
DBMGUI_EDITBOX_PIZZATIMER_MIN			= "Minutes";
DBMGUI_EDITBOX_PIZZATIMER_SEC			= "Seconds";
DBMGUI_CHECKBOX_PIZZATIMER_BROADCAST		= "Broadcast timer to raid";
DBMGUI_BUTTON_PIZZATIMER_START			= "Start timer";

-- DBMOptionsFramePage3
DBMGUI_TITLE_RAIDWARNING			= "Raid Warnings";
DBMGUI_TITLE_SELFWARNING			= "Local Warnings"; 
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_1		= "RaidWarning (default Sound)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_2		= "BellTollNightElf (CT_Raid Sound)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_3		= "Disable sound warning";
DBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED	= "Raid Warning sound disabled";
DBMGUI_RAIDWARNING_EXAMPLE			= "*** Example Raid Warning ***";
DBMGUI_BUTTON_SOUND_TEST			= "Test sound";
DBMGUI_BUTTON_SHOW_EXAMPLE			= "Show example";
DBMGUI_BUTTON_RAIDWARNING_RESET		= "Reset frame";
DBMGUI_BUTTON_RAIDWARNING_RESET_DONE		= "Settings successfully resetted to defaults";

-- DBMOptionsFramePage4
DBMGUI_TITLE_SPECIALWARNING			= "Setup Special Warnings";
DBMGUI_TITLE_SHAKESCREEN			= "Setup Screen Shake Effects";
DBMGUI_TITLE_FLASHEFFECT			= "Setup Flash Effects";
DBMGUI_CHECKBOX_SPECWARNING_ENABLE		= "Enable special warnings";
DBMGUI_BUTTON_SPECWARNING_TEST			= "Test warning";
DBMGUI_BUTTON_SPECWARNING_EXAMPLE		= "Test message :)";
DBMGUI_SLIDER_SPECWARNING_DURATION		= "Duration";
DBMGUI_SLIDER_SPECWARNING_FADETIME		= "Fade time";
DBMGUI_SLIDER_SPECWARNING_TEXTSIZE		= "Text size";
DBMGUI_CHECKBOX_SHAKESCREEN_ENABLE		= "Enable screen shake effects";
DBMGUI_BUTTON_SHAKESCREEN_TEST			= "Test shake";
DBMGUI_SLIDER_SHAKESCREEN_DURATION		= "Duration";
DBMGUI_SLIDER_SHAKESCREEN_INTENSITY		= "Intensity";
DBMGUI_CHECKBOX_FLASHEFFECT_ENABLE		= "Enable flash effects";
DBMGUI_BUTTON_FLASHEFFECT_TEST			= "Test flash";
DBMGUI_SLIDER_FLASHEFFECT_DURATION		= "Duration";
DBMGUI_SLIDER_FLASHEFFECT_FLASHES		= "Flashes";

-- DBMOptionsFramePage5
DBMGUI_ABOUTTITLE	= "About";
DBMGUI_ABOUTTEXT	= {
	"Deadly Boss Mods API (c) by DeadlyMinds Tandanu",
	"Deadly Boss Mods GUI (c) by La Vendetta Nitram",
	" ",
	"Thanks for using our AddOn.",
	" ",
	"                                  Visit",
	" ",
	"                   www.deadlybossmods.com",
	" ",
	"                                   and",
	" ",
	"                 www.curse-gaming.com",
	" ",
	"If you have a suggestion or a bug report, leave a comment at www.curse-gaming.com or post in our forums at www.deadlyminds.net",

};


-- Translations added v1.10
DBMGUI_SIDEFRAME_TAB5				= "Misc";
DBMGUI_SIDEFRAME_TAB6				= "About";

DBMGUI_SLIDER_STATUSBAR_COUNT			= "Bar count";
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_1		= "Classic Design"; --wird überflüssig mit dem Verwenden des Namens aus der Tabelle
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_2		= "Modern Style"; 
DBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR		= "Example Bar";

DBMGUI_TITLE_AUTORESPOND			= "Auto Respond Settings";
DBMGUI_CHECKBOX_AUTORESPOND_ENABLE		= "Auto respond to whispers during boss fights";
DBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS	= "Show whispers during combat";
DBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER	= "Inform me about auto-responded whispers";
DBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY		= "Hide auto responses";

DBMGUI_EDITBOX_AUTORESPOND_TITLE		= "Message to send during boss fights";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER	= "The following strings will\nbe automatically replaced:";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1	= {"%P", "your name"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2	= {"%B", "boss name"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3	= {"%HP", "boss hp"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4	= {"%ALIVE", "raid members alive"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5	= {"%RAID", "raid members"};

-- Translations added v1.15
DBMGUI_CHECKBOX_ALLOW_STATUS_COMMAND		= "Allow users to request the fight status (whisper \"status\")";
DBMGUI_CHECKBOX_SHOWCOMBATINFO			= "Show combat information like fight length";

DBMGUI_TITLE_COMBATSYSTEM			= "Combat Detection System";
DBMGUI_BUTTON_STATUSBAR_FLASHONEND		= "Flash bar on timer end";
DBMGUI_BUTTON_STATUSBAR_AUTOCOLORBARS		= "Dynamic bar color";

-- Translations added v1.20
DBMGUI_TITLE_RAIDOPTIONS			= "Raid Options";
DBMGUI_CHECKBOX_HIDEPLAYERNAMESINRAIDS		= "Hide player names when joining a raid group";
DBMGUI_CHECKBOX_ALLOWSYNCFROMOLDCLIENT		= "Accept sync from old clients";

-- Translation added v1.25
DBMGUI_CHECKBOX_ENABLE_RAIDWARNINGFRAME	= "Enable RaidWarning Frame";
DBMGUI_CHECKBOX_ENABLE_SELFWARNINGFRAME	= "Enable local warnings";

DBMGUI_BUTTON_LOADADDON			= "Load AddOn";
DBMGUI_FRAME_LOADADDON_DESCRIPTION		= {
	"Please enter the zone to load the AddOns",
	"automatically. If you want to load the AddOns",
	"manually, click on \"Load AddOns\".",
	"After this the AddOns are loaded and working,",
	"but using memory and CPU. This feature is",
	"only a performance tweak because we don't",
	"want to load AddOns for instances we never do.",
};



-- added @ 1.12.06
DBMGUI_CHECKBOX_SHOWPULLSYNCINFO	= "Show pull sync info";

DBMGUI_TITLE_LOAD_ON_DEMAND		= "Load on Demand Options";
DBMGUI_CHECKBOX_LOAD_GUI_ONLOAD	= "Load GUI on login";	

-- added @ 13.12.06
DBMGUI_BUTTON_STATUSBAR_SHOW_ICON	= "Enable status bar icons";
DBMGUI_BUTTON_STATUSBAR_ICON_SIDE	= "Show icon on the right side";

--DBM_ERROR_TABS_FULL	= "The boss mod tab list is full, so the oldest tab (%s) was hidden. Use the \"Load Mods\" button to show this tab again.";

DBMGUI_BUTTON_LOADMODS	= "Load Mods";

-- text size slider
DBMGUI_STATUSBAR_TEXTSIZE_SLIDER	= "Text size"

DBMGUI_SIDEFRAME_TAB22 = "Bars 2"

-- huge bars
DBMGUI_BARS2_TITLE_STATUSBARS				= "Huge Status Bar Timers"
DBMGUI_BARS2_CHECKBOX_STATUSBAR_ENABLE		= "Enable Huge Status Bars"
DBMGUI_BARS2_SLIDER_ENLARGEAFTER_TEXT		= "Enlarge bars %.1f seconds before they expire"
DBMGUI_BARS2_SLIDER_ENLARGEAFTER_PERC_TEXT	= "Enlarge bars at %.0f%%"
DBMGUI_BARS2_SLIDER_ENLARGMAXTIME_TEXT		= "Enlarge only if time left < %.0f seconds"

-- bar dropdown menu
DBMGUI_DROPDOWN_BAR_OPTIONS		= "Bars"

DBMGUI_BUTTON_271_DEFAULTS		= "Old Defaults"

-- raid warning colors
DBMGUI_WARNINGCOLORS_COLOR_1	= "Color 1"
DBMGUI_WARNINGCOLORS_COLOR_2	= "Color 2"
DBMGUI_WARNINGCOLORS_COLOR_3	= "Color 3"
DBMGUI_WARNINGCOLORS_COLOR_4	= "Color 4"

DBMGUI_BUTTON_RAIDWARNING_RESET_COLOR	= "Reset colors"

DBMGUI_RAIDWARNING_EXAMPLE_NEW	= "|cff%.2x%.2x%.2xColor 1|r |cff%.2x%.2x%.2xColor 2|r |cff%.2x%.2x%.2xColor 3|r |cff%.2x%.2x%.2xColor 4|r"