
-------------------------------------------------------------------------------------
-- Default Artwork
-------------------------------------------------------------------------------------

local config = {}
local defaultArtPath = "Interface\\Addons\\TidyPlates\\Media"
local font =					defaultArtPath.."\\LiberationSans-Regular.ttf"
--local font =					"FONTS\\arialn.ttf"
local nameplate_verticalOffset = -5
local castBar_verticalOffset = -6 -- Adjust Cast Bar distance

config.hitbox = {
	width = 149,
	height = 37,
}

config.healthborder = {
	texture		 =				defaultArtPath.."\\RegularBorder",
	glowtexture =					defaultArtPath.."\\Highlight",
	elitetexture =					defaultArtPath.."\\EliteBorder",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER",
}

config.threatborder = {
	texture =			defaultArtPath.."\\RegularThreat",
	elitetexture =			defaultArtPath.."\\EliteThreat",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER",
}

config.castborder = {
	texture =					defaultArtPath.."\\CastStoppable",
	width = 128,
	height = 64,
	x = 0,
	y = 0 +castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
}

config.castnostop = {
	texture = 				defaultArtPath.."\\CastNotStoppable",
	width = 128,
	height = 64,
	x = 0,
	y = 0+castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
}

config.name = {
	typeface =					font,
	size = 9,
	width = 88,
	height = 10,
	x = 0,
	y = 6+nameplate_verticalOffset,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

config.level = {
	typeface =					font,
	size = 9,
	width = 25,
	height = 10,
	x = 36,
	y = 6+nameplate_verticalOffset,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

config.healthbar = {
	texture =					 defaultArtPath.."\\Statusbar",
	height = 12,
	width = 101,
	x = 0,
	y = 15+nameplate_verticalOffset,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

config.castbar = {
	texture =					defaultArtPath.."\\Statusbar",
	height = 12,
	width = 99,
	x = 0,
	y = -8+castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

config.specialText = {
	typeface =					font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 16+nameplate_verticalOffset,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

config.specialText2 = {
	typeface =					font,
	size = 8,
	width = 100,
	height = 10,
	x = 1,
	y = castBar_verticalOffset-8+nameplate_verticalOffset,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

config.specialArt = {
	width = 24,
	height = 24,
	x = -5,
	y = 15+nameplate_verticalOffset,
	anchor = "TOP",
}

config.spellicon = {
	width = 24,
	height = 24,
	x = 65,
	y = -11+castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
}

config.raidicon = {
	width = 20,
	height = 20,
	x = -35,
	y = 12+nameplate_verticalOffset,
	anchor = "TOP",
}

config.dangerskull = {
	width = 14,
	height = 14,
	x = 44,
	y = 8+nameplate_verticalOffset,
	anchor = "CENTER",
}

config.frame = {
	width = 101,
	height = 45,
	x = 0,
	y = 0+nameplate_verticalOffset,
	anchor = "CENTER",
}

-- [[
	-- Normal
config.threatcolor = {
	LOW = { r = .75, g = 1, b = 0, a= 1, },
	MEDIUM = { r = 1, g = 1, b = 0, a = 1, },
	HIGH = { r = 1, g = 0, b = 0, a = 1, },
}
--]]

--[[
	-- Colorblind
config.threatcolor = {
	LOW = { r = 15/255, g = 133/255, b = 255/255, a= 1, },
	MEDIUM = { r = 15/255, g = 133/255, b = 255/255, a= 1, },
	HIGH = { r = 255/255, g = 128/255, b = 0, a = 1, },
}
--]]

config.options = {
	showLevel = true,
	showName = true,
	showSpecialText = false,
	showSpecialText2 = false,
	showSpecialArt = false,
	showDangerSkull = true,
	showspellIcon = true,
	showNostopSpell = true,
	showAggroGlow = true, 
}

TidyPlates.defaultTheme = config
TidyPlates:ActivateTheme(TidyPlates.defaultTheme)
