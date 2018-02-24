--[[

	English/Default translations for Who Favorites

	$Revision: 1.1 $
	$Date: 2005/10/10 17:35:29 $

]]--

-- All strings will be placed in the WHO_FAV table.
WHO_FAV = {};
WHO_FAV.NAME = "WhoFavorites";

-- Default English translations here
if( not ace:LoadTranslation("WhoFav") ) then

WHO_FAV.DESCRIPTION = "Saves who searches in a favorites list";
WHO_FAV.COMMANDS = {"/WhoFavorites", "/WhoFav", "/WhoFavs"};

WHO_FAV.AUTOQUERY = "AutoQuery";
WHO_FAV.AUTOQUERY_DESC = "Automatically run a favorite search when selected from the pulldown";

WHO_FAV.ENABLED = "Enabled";
WHO_FAV.DISABLED = "Disabled";

WHO_FAV.INIT_MSG = WHO_FAV.NAME .. " Initialized";
WHO_FAV.ENABLE_MSG = WHO_FAV.NAME .. " " .. WHO_FAV.ENABLED;
WHO_FAV.DISABLE_MSG = WHO_FAV.NAME .. " " .. WHO_FAV.DISABLED;

WHO_FAV.AUTOQUERY_ENABLE_MSG = WHO_FAV.NAME .. " " .. WHO_FAV.AUTOQUERY .. " " .. WHO_FAV.ENABLED;
WHO_FAV.AUTOQUERY_DISABLE_MSG = WHO_FAV.NAME .. " " .. WHO_FAV.AUTOQUERY .. " " .. WHO_FAV.DISABLED;

WHO_FAV.POPUP_TEXT = "New Search Name:";
WHO_FAV.SAVE = "Save";
WHO_FAV.CANCEL = "Cancel";
WHO_FAV.DELETE = "Delete";
WHO_FAV.CLEAR = "Clear";
WHO_FAV.FAVORITES = "Favorites use z-<region> c-<class>";
WHO_FAV.HINTINFO = "g-<guild> ex c-warrior 51-60";




end

