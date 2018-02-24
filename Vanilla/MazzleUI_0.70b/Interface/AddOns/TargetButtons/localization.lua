-- Last update : 30/03/2006

-- <<--
--	Global info
-- -->>
TARGETBUTTONS_NAME		= "TargetButtons";
TARGETBUTTONS_VERSION 		= "0.36";
TARGETBUTTONS_NAMEVERSION	= TARGETBUTTONS_NAME.." v"..TARGETBUTTONS_VERSION;

-- Version : English
-- Last update : 25/04/2005

TARGETBUTTONS_HEADER		= "The mod for easy interaction";


-- <<--
--	Tooltip texts
-- -->>
TARGETBUTTONS_INVITE_TT		= "Invite";
TARGETBUTTONS_FOLLOW_TT		= "Follow";
TARGETBUTTONS_TRADE_TT		= "Trade";
TARGETBUTTONS_WHISPER_TT	= "Whisper";
TARGETBUTTONS_DUEL_TT		= "Duel";
TARGETBUTTONS_INSPECT_TT	= "Inspect";
TARGETBUTTONS_PROMOTE_TT	= "Promote to leader";

-- <<-- 
--	Help text
-- -->>
TARGETBUTTONS_INIT_TEXT 	= TARGETBUTTONS_NAMEVERSION.." loaded";


-- <<--
--	Messages
-- -->>
TARGETBUTTONS_NO_SUCH		= "There's no such frame: ";


-- <<--
--	Options frame
-- -->>
TARGETBUTTONS_PERBUTTON		= "Per-button settings";
TARGETBUTTONS_LAYOUT		= "Layout settings";
TARGETBUTTONS_GLOBAL		= "Global settings";
TARGETBUTTONS_VISIBLE		= "Visible";
TARGETBUTTONS_POSITION		= "Position";
TARGETBUTTONS_SIZE		= "Size";
TARGETBUTTONS_SLAYOUT		= "Select layout:";
TARGETBUTTONS_NOOPT		= "No options available";
TARGETBUTTONS_DISTANCE		= "Distance between buttons";
TARGETBUTTONS_SETFRAME		= "Set target frame";
TARGETBUTTONS_OFFSET		= "Offset";
TARGETBUTTONS_USEGLOBALSIZE	= "Use global size";


TARGETBUTTONS_CLASSICMODE	= "Classic mode";
TARGETBUTTONS_LEFTTORIGHT	= "Left-to-right";
TARGETBUTTONS_RIGHTTOLEFT	= "Right-to-left";
TARGETBUTTONS_FREEMODE		= "Free mode";
TARGETBUTTONS_SETFRAME		= "Set target frame";
TARGETBUTTONS_LEFT		= "Left";
TARGETBUTTONS_RIGHT		= "Right";
TARGETBUTTONS_DOWN		= "Down";
TARGETBUTTONS_UP		= "Up";
TARGETBUTTONS_BIGGER		= "Bigger";
TARGETBUTTONS_SMALLER		= "Smaller";

-- <<--
--	Options frame tooltips
-- -->>
TARGETBUTTONS_SELBUT_TT		= "Select the button you want to set up.";
TARGETBUTTONS_BUTVIS_TT		= "This checkbutton indicates if the selected button is visible or not.";
TARGETBUTTONS_BUTSIZE_TT	= "Move the slider to change the size of this button. \nThis only works when Use global size is unchecked!";
TARGETBUTTONS_SLIDEX_TT		= "Move the slider to change the horizontal position of the selected button. \nThis only works when Free layout mode is selected!";
TARGETBUTTONS_SLIDEY_TT		= "Move the slider to change the vertical position of the selected button. \nThis only works when Free layout mode is selected!";
TARGETBUTTONS_SELLAY_TT		= "Select wich layout mode you want to use.";
TARGETBUTTONS_DISTANCE_TT	= "Move the slider to change the distance between the buttons. \nThis only works in Left-to-right and Right-to-left layout modes!";
TARGETBUTTONS_TARGEDIT_TT	= "You can change the frame wich TargetButtons follows here. Hit the Set target frame button to save changes!";
TARGETBUTTONS_SETFRAME1_TT	= "Push this button to change the target frame to ";
TARGETBUTTONS_SETFRAME2_TT	= ". (You can enter a new name in the editbox to the left.) \nTargetButtons will then follow the move of this frame.";
TARGETBUTTONS_XOFFSET_TT	= "Move the slider to change the horizontal position of TargetButtons.";
TARGETBUTTONS_YOFFSET_TT	= "Move the slider to change the vertical position of TargetButtons.";
TARGETBUTTONS_USEGLOBAL_TT	= "Check this button to use a global size for all buttons."
TARGETBUTTONS_GLOBALSIZE_TT	= "Move the slider to change the value of the global size. \nThis only works when Use global size is checked!";

TARGETBUTTONS_RESET_TT		= "Push this button to reset all settings to default. Please push this button if you had an earlier version of TargetButtons installed and you get error messages!"



if ( GetLocale() == "deDE" ) then

-- Version : Deutsch (German)
-- Last update : 25/04/2005
-- thx to Scarabeus

-- <<--
-- Global info
-- -->>
TARGETBUTTONS_HEADER = "Die mod f\195\188r einfache Interaction";


-- <<--
-- Tooltip texts
-- -->>
TARGETBUTTONS_INVITE_TT = "Einladen";
TARGETBUTTONS_FOLLOW_TT = "Folgen";
TARGETBUTTONS_TRADE_TT = "Handeln";
TARGETBUTTONS_WHISPER_TT = "Fl\195\188stern";
TARGETBUTTONS_DUEL_TT = "Duel";
TARGETBUTTONS_INSPECT_TT = "Betrachten";
TARGETBUTTONS_PROMOTE_TT = "Zum Anf\195\188hrer bef\195\182rdern";

-- <<--
-- Help text
-- -->>
TARGETBUTTONS_INIT_TEXT = TARGETBUTTONS_NAMEVERSION.." geladen";


-- <<--
-- Messages
-- -->>
TARGETBUTTONS_NO_SUCH = "Es gibt kein solches Frame: ";


-- <<--
-- Options frame
-- -->>
TARGETBUTTONS_PERBUTTON = "Button Einstellungen";
TARGETBUTTONS_LAYOUT = "Layout Einstellungen";
TARGETBUTTONS_GLOBAL = "Globale Einstelungen";
TARGETBUTTONS_VISIBLE = "Sichtbarkeit";
TARGETBUTTONS_POSITION = "Position";
TARGETBUTTONS_SIZE = "Gr\195\182sse";
TARGETBUTTONS_SLAYOUT = "Layout ausw\195\164hlen:";
TARGETBUTTONS_NOOPT = "Keine optionen verf\195\188gbar";
TARGETBUTTONS_DISTANCE = "Abstand zwischen Buttons";
TARGETBUTTONS_SETFRAME = "Set target frame";
TARGETBUTTONS_OFFSET = "Offset";
TARGETBUTTONS_USEGLOBALSIZE = "Use global size";


TARGETBUTTONS_CLASSICMODE = "Classischer modus";
TARGETBUTTONS_LEFTTORIGHT = "Links-nach-rechts";
TARGETBUTTONS_RIGHTTOLEFT = "Rechts-nach-links";
TARGETBUTTONS_FREEMODE = "Freier modus";
TARGETBUTTONS_SETFRAME = "Set target frame";
TARGETBUTTONS_LEFT = "Links";
TARGETBUTTONS_RIGHT = "Rechts";
TARGETBUTTONS_DOWN = "Runter";
TARGETBUTTONS_UP = "Hoch";
TARGETBUTTONS_BIGGER = "Gr\195\182sser";
TARGETBUTTONS_SMALLER = "Kleiner";

-- <<--
-- Options frame tooltips
-- -->>
TARGETBUTTONS_SELBUT_TT = "Button w\195\164hlen zum konfiguieren.";
TARGETBUTTONS_BUTVIS_TT = "Zeigt an ob Button sichtbar ist oder nicht.";
TARGETBUTTONS_BUTSIZE_TT = "Gr\195\182sse des Buttons \195\164ndern. \nGeht nur wenn Use global size nicht an ist!";
TARGETBUTTONS_SLIDEX_TT = "\195\132ndern der Horizontalen Position vom ausgew\195\164hltem Button. \nGeht nur bei ausgew\195\164hltem Freien modus!";
TARGETBUTTONS_SLIDEY_TT = "\195\132ndern der Verticalen Position vom ausgew\195\164hltem Button. \nGeht nur bei ausgew\195\164hltem Freien modus!";
TARGETBUTTONS_SELLAY_TT = "Layout modus ausw\195\164hlen.";
TARGETBUTTONS_DISTANCE_TT = "Abstand zwischen den Buttons. \nGeht nur in links-nach-rechts und rechts-nach-links modus!";
TARGETBUTTONS_TARGEDIT_TT = "You can change the frame wich TargetButtons follows here. Hit the Set target frame button to save changes!";
TARGETBUTTONS_SETFRAME1_TT = "Push this button to change the target frame to ";
TARGETBUTTONS_SETFRAME2_TT = ". (You can enter a new name in the editbox to the left.) \nTargetButtons will then follow the move of this frame.";
TARGETBUTTONS_XOFFSET_TT = "\195\132ndern der Horizontalen Position von TargetButtons.";
TARGETBUTTONS_YOFFSET_TT = "\195\132ndern der Verticalen Position von TargetButtons.";
TARGETBUTTONS_USEGLOBAL_TT = "Ausw\195\164hlen f\195\188r Globale gr\195\182sse von allen Buttons."
TARGETBUTTONS_GLOBALSIZE_TT = "Gr\195\182sse von allen Buttons \195\164ndern. \nGeht nur wenn Use global size an ist!";

TARGETBUTTONS_RESET_TT = "Stellt Standard Einstellungen wieder her. Bitte dr\195\188cken wenn vorher eine \195\164ltere Version benutzt wurde und eine Fehlermeldung kommt!"

end
