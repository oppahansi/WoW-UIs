local L = AceLibrary("AceLocale-2.0"):new("FuBar_LocationFu")

L:RegisterTranslations("enUS", function() return {
	["Open world map"] = true,
	["Open Atlas"] = true,
	["Show coordinates"] = true,
	["Toggle the coordinates in the text of this plugin"] = true,
	["Show subzone name"] = true,
	["Show zone name"] = true,
	["Toggle the zone name in the text of this plugin"] = true,
	["Show level range"] = true,
	["Show minimap bar"] = true,
	["Show the bar above the minimap that tells the location and allows you to close minimap"] = true,
	["Show coodinates on map"] = true,
	["Show the coordinates of your cursor and your player on the world map"] = true,
	["Show map overlay"] = true,
	["Show the overlay on the map which shows the level range and instances available"] = true,
	["Show recommended zones"] = true,
	["Show your recommended zones in the tooltip"] = true,
	["Zone:"] = true,
	["Subzone:"] = true,
	["Arena"] = true,
	["Friendly"] = true,
	["Contested"] = true,
	["Hostile"] = true,
	["Status:"] = true,
	["Coordinates:"] = true,
	["Level range:"] = true,
	["Instances"] = true,
	["Recommended zones"] = true,
	["Recommended instances"] = true,
	["Cursor:"] = true,
	["Player:"] = true,
	
	["Atlas-hint"] = "Click to open Atlas",
	["Standard-hint"] = "Click to open map",
	["Shift-hint"] = "Shift-Click to insert position into chat edit box",
	["Ctrl-hint"] = "Ctrl-Click to open map",
	["Ctrl-Atlas-hint"] = "Ctrl-Click to open Atlas",
	
	["AceConsole-options"] = {"/locfu", "/locationfu"},
} end)