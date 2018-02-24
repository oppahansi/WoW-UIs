TipTacDropDowns = {};
local cfg = TipTac_Config;

-- Shared Media
local SML = LibStub and LibStub("LibSharedMedia-2.0",1) or nil;

-- DropDown Lists
TipTacDropDowns.FontFlags = {
	["None"] = "",
	["Outline"] = "OUTLINE",
	["Thick Outline"] = "THICKOUTLINE",
};
TipTacDropDowns.AnchorType = {
	["Normal Anchor"] = "normal",
	["Mouse Anchor"] = "mouse",
	["Smart Anchor"] = "smart",
};

TipTacDropDowns.AnchorPos = {
	["Top"] = "TOP",
	["Top Left"] = "TOPLEFT",
	["Top Right"] = "TOPRIGHT",
	["Bottom"] = "BOTTOM",
	["Bottom Left"] = "BOTTOMLEFT",
	["Bottom Right"] = "BOTTOMRIGHT",
	["Left"] = "LEFT",
	["Right"] = "RIGHT",
	["Center"] = "CENTER",
};

TipTacDropDowns.BarTextFormat = {
	["No text"] = "none",
	["Show percentage"] = "percent",
	["Show values if available"] = "value",
};

--------------------------------------------------------------------------------------------------------
--                                        Default DropDown Init                                       --
--------------------------------------------------------------------------------------------------------

local function Default_SelectValue(dropDown,table)
	cfg[dropDown.option.var] = table.value;
	TipTac:ApplySettings();
end

function TipTacDropDowns.Default(dropDown,table)
	dropDown.SelectValueFunc = Default_SelectValue;
	for text, option in pairs(dropDown.option.list) do
		tinsert(table,{ text = text, value = option });
	end
end;

--------------------------------------------------------------------------------------------------------
--                                          Shared Media Lib                                          --
--------------------------------------------------------------------------------------------------------

local SharedMediaLibSubstitute = not SML and {
	["font"] = {
		["Friz Quadrata TT"] = "Fonts\\FRIZQT__.TTF",
		["Arial Narrow"] = "Fonts\\ARIALN.TTF",
		["Skurri"] = "Fonts\\SKURRI.TTF",
		["Morpheus"] = "Fonts\\MORPHEUS.TTF",
	},
	["background"] = {
		["Blizzard Tooltip"] = "Interface\\Tooltips\\UI-Tooltip-Background",
		["Solid"] = "Interface\\ChatFrame\\ChatFrameBackground",
	},
	["border"] = {
		["None"] = "Interface\\None",
		["Blizzard Dialog"]  = "Interface\\DialogFrame\\UI-DialogBox-Border",
		["Blizzard Tooltip"] = "Interface\\Tooltips\\UI-Tooltip-Border",
	},
	["statusbar"] = {
		["Blizzard StatusBar"] = "Interface\\TargetingFrame\\UI-StatusBar",
	},
} or nil;

function TipTacDropDowns.SharedMediaLib(dropDown,table)
	local query = dropDown.option.media;
	dropDown.SelectValueFunc = Default_SelectValue;
	if (SML) then
		for _, name in pairs(SML:List(query)) do
			tinsert(table,{ text = name, value = SML:Fetch(query,name) });
		end
	else
		for name, value in pairs(SharedMediaLibSubstitute[query]) do
			tinsert(table,{ text = name, value = value });
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Layout Presets                                           --
--------------------------------------------------------------------------------------------------------

local layout_presets = {
	-- TipTac Layout
	["TipTac (Default)"] = {
		showTarget = "second",

		tipTacColor = { 0.1, 0.1, 0.2, 1.0 };
		tipTacBorderColor = { 0.3, 0.3, 0.4, 1.0 };
		tipColor = { 0.1, 0.1, 0.2, 1.0 };
		tipBorderColor = { 0.3, 0.3, 0.4, 1.0 };

		reactColoredBackdrop = false,

		colSameGuild = "|cffff32ff";
		colRace = "|cffffffff";
		colLevel = "|cffc0c0c0";

		colorNameByClass = false,
		classColoredBorder = false,

		classification_normal = "%s ",
		classification_elite = "+%s ",
		classification_worldboss = "%s|r (Boss) ",
		classification_rare = "%s|r (Rare) ",
		classification_rareelite = "+%s|r (Rare) ",

		healthBar = true,
		healthBarClassColor = true,
		healthBarText = "value",
		healthBarColor = { 0.3, 0.9, 0.3, 1 },
		manaBar = false,
		powerBar = false,
	},
	-- TipBuddy Layout
	["TipBuddy"] = {
		showTarget = "first",

		tipTacColor = { 0.1, 0.22, 0.35, 0.78 };
		tipTacBorderColor = { 0.8, 0.8, 0.9, 1.0 };
		tipColor = { 0.1, 0.1, 0.1, 0.8 };
		tipBorderColor = { 0.8, 0.8, 0.9, 1.0 };

		colSameGuild = "|cffff32ff";
		colRace = "|cffffffff";
		colLevel = "|cffc0c0c0";

		classification_normal = "%s ",
		classification_elite = "+%s ",
		classification_worldboss = "%s|r (Boss) ",
		classification_rare = "%s|r (Rare) ",
		classification_rareelite = "+%s|r (Rare) ",
	},
	-- TinyTip Layout
	["TinyTip"] = {
		showTarget = "last",

		tipTacColor = { 0, 0, 0.5, 1.0 };
		tipTacBorderColor = { 0, 0, 0.75, 1.0 };
		tipColor = { 0, 0, 0, 1 };
		tipBorderColor = { 0, 0, 0, 1 };

		reactColoredBackdrop = true,

		colRace = "|cffddeeaa";
		colLevel = "|cffffcc00";

		classification_normal = "Level %s",
		classification_elite = "Level %s|cffffcc00 Elite",
		classification_worldboss = "Level %s|cffff0000 Boss",
		classification_rare = "Level %s|cffff66ff Rare",
		classification_rareelite = "Level %s|cffffaaff Rare Elite",
	},
	-- Roth UI Layout
	["Roth UI"] = {
		showStatus = true,
		pvpName = true,
		showTarget = "last",
		showTargetedBy = false,

		tipBackdropBG = "Interface\\Tooltips\\UI-Tooltip-Background",
		tipBackdropEdge = "Interface\\Tooltips\\UI-Tooltip-Border",
		tipColor = { 0.1, 0.1, 0.2, 1 },
		tipBorderColor = { 0.3, 0.3, 0.4, 1	},
		tipTacBorderColor = { 0.3, 0.3, 0.4, 1 },
		tipTacColor = { 0.1, 0.1, 0.2, 1 },

		colSameGuild = "|cffff32ff",
		colRace = "|cffffffff",
		colLevel = "|cffc0c0c0",

		colorNameByClass = true,
		classColoredBorder = false,

		healthBar = true,
		healthBarClassColor = true,
		healthBarText = "none",
		healthBarColor = { 0.3, 0.9, 0.3, 1 },
		manaBar = true,
		manaBarText = "none",
    	manaBarColor = { 0.3, 0.55, 0.9, 1 },
		powerBar = false,

		barHeight = 6,
		barTexture = "Interface\\AddOns\\rTextures\\statusbar",

		showBuffs = false,
		showDebuffs = false,

		classification_normal = "%s",
		classification_elite = "%s+",
		classification_worldboss = "%sb++",
		classification_rare = "%sr",
		classification_rareelite = "%sr+",
	},
};

local function Layout_SelectValue(dropDown,table)
	for name, value in pairs(layout_presets[table.value]) do
		cfg[name] = value;
	end
	TipTac:ApplySettings();
end

function TipTacDropDowns.Layouts(dropDown,table)
	dropDown.SelectValueFunc = Layout_SelectValue;
	for name in pairs(layout_presets) do
		tinsert(table,{ text = name, value = name });
	end
end