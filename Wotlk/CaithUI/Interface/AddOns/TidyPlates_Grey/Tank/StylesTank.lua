-----------------------------------------------------
-- Tidy Plates: Grey/Tank - Theme Definition
-----------------------------------------------------
TidyPlatesThemeList["Grey/Tank"] = {}

---------------
-- Config
---------------
TidyPlatesGreyTankVariables = {
	OpacityNonTarget = .5,
	OpacityHideNeutral = false,
	OpacityHideNonElites = false,
	ScaleGeneral = 1,
	ScaleLoose = 1.5,
	ScaleIgnoreNonElite = false,
	WidgetTug = false,
	WidgetWheel = false,
	WidgetSelect = false,
	HealthText = 1,
	AggroHealth = false,
	AggroBorder = true,									
	AggroLooseColor = {r = .6, g = 1, b = 0, a = 1,},
	AggroTankedColor = {r = 1, g = 0, b = 0, a= 1,},
}

---------------
-- Style Assignment (Uses default art)
---------------
local theme = TidyPlatesThemeList["Grey/Tank"]

theme.hitbox = { width = 140, height = 35, }
theme.name = { width = 100, }
theme.options = { showLevel = false, showSpecialText = true, showSpecialText2 = true, showAggroGlow = true, }
theme.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 1,},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1,},
	HIGH = {r = 1, g = 0, b = 0, a= 1,},}







