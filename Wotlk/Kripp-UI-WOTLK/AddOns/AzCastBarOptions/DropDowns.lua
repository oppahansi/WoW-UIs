AzCastBarDropDowns = {};
local cfg = AzCastBar_Config;

-- Shared Media
local LSM = LibStub and LibStub("LibSharedMedia-3.0",1);

--------------------------------------------------------------------------------------------------------
--                                        Default DropDown Init                                       --
--------------------------------------------------------------------------------------------------------

local function Default_SelectValue(dropDown,entry,index)
	cfg[AzCastBarOptions.activeBar.token][dropDown.option.var] = entry.value;
	AzCastBar.ApplyBarSettings(AzCastBarOptions.activeBar);
end

function AzCastBarDropDowns.Default_Init(dropDown,list)
	dropDown.SelectValueFunc = Default_SelectValue;
	for text, option in next, dropDown.option.list do
		local tbl = list[#list + 1];
		tbl.text = text; tbl.value = option;
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Lib Shared Media                                          --
--------------------------------------------------------------------------------------------------------

local LibSharedMediaSubstitute = {
	font = {
		["Friz Quadrata TT"] = "Fonts\\FRIZQT__.TTF",
		["Arial Narrow"] = "Fonts\\ARIALN.TTF",
		["Skurri"] = "Fonts\\SKURRI.TTF",
		["Morpheus"] = "Fonts\\MORPHEUS.TTF",
	},
	background = {
		["Blizzard Tooltip"] = "Interface\\Tooltips\\UI-Tooltip-Background",
		["Solid"] = "Interface\\Buttons\\WHITE8X8",
	},
	border = {
		["None"] = "Interface\\None",
		["Blizzard Dialog"]  = "Interface\\DialogFrame\\UI-DialogBox-Border",
		["Blizzard Tooltip"] = "Interface\\Tooltips\\UI-Tooltip-Border",
		["Solid"] = "Interface\\Buttons\\WHITE8X8",
	},
	statusbar = {
		["Blizzard StatusBar"] = "Interface\\TargetingFrame\\UI-StatusBar",
		["HorizontalFade"] = "Interface\\Addons\\AzCastBar\\Textures\\HorizontalFade",
		["Pale"] = "Interface\\Addons\\AzCastBar\\Textures\\Pale",
		["Lines"] = "Interface\\Addons\\AzCastBar\\Textures\\Lines",
		["SmoothBar"] = "Interface\\Addons\\AzCastBar\\Textures\\SmoothBar",
		["Streamline"] = "Interface\\Addons\\AzCastBar\\Textures\\Streamline",
		["Streamline-Inverted"] = "Interface\\Addons\\AzCastBar\\Textures\\Streamline-Inverted",
		["Waterline"] = "Interface\\Addons\\AzCastBar\\Textures\\Waterline",
	},
	sound = {
		["Bell"] = "Sound\\Doodad\\BellTollHorde.wav",
		["Murmur"] = "Sound\\Creature\\Murmur\\MurmurWoundA.wav",
		["Alarm Warning 1"] = "Sound\\Interface\\AlarmClockWarning1.wav",
		["Alarm Warning 2"] = "Sound\\Interface\\AlarmClockWarning2.wav",
		["Alarm Warning 3"] = "Sound\\Interface\\AlarmClockWarning3.wav",
		["Raid Warning"] = "Sound\\Interface\\RaidWarning.wav",
		["Ready Check 1"] = "Sound\\Interface\\levelup2.wav",
		["Ready Check 2"] = "Sound\\Interface\\ReadyCheck.wav",
		["Takeoff"] = "Sound\\Universal\\FM_Takeoff.wav",
		["Map Ping"] = "Sound\\Interface\\MapPing.wav",
		["Auction Close"] = "Sound\\Interface\\AuctionWindowClose.wav",
		["Auction Open"] = "Sound\\Interface\\AuctionWindowOpen.wav",
		["Gnome Exploration"] = "Sound\\Interface\\GnomeExploration.wav",
		["Flag Capture Horde"] = "Sound\\Interface\\PVPFlagCapturedHordeMono.wav",
		["Flag Capture Alliance"] = "Sound\\Interface\\PVPFlagCapturedmono.wav",
		["Flag Taken Alliance"] = "Sound\\Interface\\PVPFlagTakenHordeMono.wav",
		["Flag Taken Horde"] = "Sound\\Interface\\PVPFlagTakenMono.wav",
		["PvP Warning"] = "Sound\\Interface\\PVPWARNING.wav",
		["PvP Warning Alliance"] = "Sound\\Interface\\PVPWarningAllianceMono.wav",
		["PvP Warning Horde"] = "Sound\\Interface\\PVPWarningHordeMono.wav",
	},
};

if (LSM) then
	LSM:Register("border","Solid","Interface\\Buttons\\WHITE8X8");
	for name, path in next, LibSharedMediaSubstitute.statusbar do
		LSM:Register("statusbar",name,path);
	end
	for name, path in next, LibSharedMediaSubstitute.sound do
		LSM:Register("sound",name,path);
	end
end

local function SharedMediaLib_SelectValue(dropDown,entry,index)
	if (dropDown.option.media == "sound") then
		PlaySoundFile(entry.value);
	end
	Default_SelectValue(dropDown,entry,index);
end

function AzCastBarDropDowns.SharedMediaLib_Init(dropDown,list)
	local query = dropDown.option.media;
	dropDown.SelectValueFunc = SharedMediaLib_SelectValue;
	if (LSM) then
		for _, name in next, LSM:List(query) do
			local tbl = list[#list + 1];
			tbl.text = name; tbl.value = LSM:Fetch(query,name);
		end
	else
		for name, value in next, LibSharedMediaSubstitute[query] do
			local tbl = list[#list + 1];
			tbl.text = name; tbl.value = value;
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                            List Plugins                                            --
--------------------------------------------------------------------------------------------------------

local function CopyPluginSettings_SelectValue(dropDown,entry,index)
	local cfgTo = cfg[AzCastBarOptions.activeBar.token];
	local cfgFrom = entry.value;
	-- using rawget here makes sure it goes default if the bar we copy from doesn't have this option set
	for option, value in next, AzCastBar.defOptions do
		cfgTo[option] = rawget(cfgFrom,option);
	end
	AzCastBar.ApplyBarSettings(AzCastBarOptions.activeBar);
	dropDown.label:SetText("|cff80ff80Settings Copied");
end

function AzCastBarDropDowns.CopyPluginSettings_Init(dropDown,list)
	dropDown.SelectValueFunc = CopyPluginSettings_SelectValue;
	for index, plugin in ipairs(AzCastBar.frames) do
		if (plugin ~= AzCastBarOptions.activeBar) then
			local tbl = list[#list + 1];
			tbl.text = plugin.token; tbl.value = plugin.cfg; tbl.checked = false;
		end
	end
	dropDown.label:SetText("|cff00ff00Select Plugin...");
end

--------------------------------------------------------------------------------------------------------
--                                            List Layouts                                            --
--------------------------------------------------------------------------------------------------------

local layouts = {
	["|cff80ff80Default"] = {
		enabled = true,
		reverseGrowth = false,
		showSpark = false,
		fadeTime = 0.6,
		alpha = 1,

		showLabel = true,
		nameFontFace = GameFontNormal:GetFont(),
		nameFontFlags = "",
		nameFontSize = 12,
		nameLabelAlign = "LEFT",
		colNameLabel = { 1, 1, 1 },
		nameOffsetX = 0,
		nameOffsetY = 0,

		showTime = true,
		timeFontFace = GameFontNormal:GetFont(),
		timeFontFlags = "",
		timeFontSize = 12,
		timeLabelAlign = "RIGHT",
		colTimeLabel = { 1, 1, 1 },
		timeOffsetX = 0,
		timeOffsetY = 0,
		showTotalTime = false,

		texture = "Interface\\Addons\\AzCastBar\\Textures\\Waterline",
		useSameBGTexture = false,
		colBackGround = { 0.3, 0.3, 0.3, 0.6 },
		colBackdrop = { 0.1, 0.22, 0.35 },
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		backdropIndent = -2.5,

		strata = "MEDIUM",
		width = 250,
		height = 18,

		anchorPoint = "BOTTOM",
		anchorOffset = 6,
		iconAnchor = "LEFT",
		iconOffset = 2.5,
		hideIconBorder = true,
	},
	["Dark Background"] = {
		colBackGround = { 0.3, 0.3, 0.3, 0.5 },
		bgFile = "Interface\\Buttons\\WHITE8X8",
		colBackdrop = { 0, 0, 0, 0.9 },
	},
	["Auras"] = {
		backdropIndent = 0,

		nameFontSize = 10,
		timeFontSize = 10,

		width = 200,
		height = 16,

		anchorPoint = "BOTTOM",
		anchorOffset = 0,
		iconAnchor = "LEFT",
		iconOffset = 0,
		hideIconBorder = true,
	},
	["Side by Side"] = {
		showLabel = false,
		showTime = true,
		timeLabelAlign = "CENTER",
		colTimeLabel = { 1, 0.82, 0 },
		timeOffsetX = -15,
		timeOffsetY = -20,

		width = 32,
		height = 32,

		colBackdrop = { 0, 0, 0, 0 },

		anchorPoint = "LEFT",
		anchorOffset = 4,
		iconAnchor = "LEFT",
		iconOffset = 0,
		hideIconBorder = false,
	},
};

local function LayoutTemplate_SelectValue(dropDown,entry,index)
	local barCfg = cfg[AzCastBarOptions.activeBar.token];
	for option, value in next, layouts[entry.value] do
		barCfg[option] = value;
	end
	AzCastBar.ApplyBarSettings(AzCastBarOptions.activeBar);
	dropDown.label:SetText("|cff80ff80Layout Loaded");
end

function AzCastBarDropDowns.LayoutTemplate_Init(dropDown,list)
	dropDown.SelectValueFunc = LayoutTemplate_SelectValue;
	for layoutName in next, layouts do
		local tbl = list[#list + 1];
		tbl.text = layoutName; tbl.value = layoutName; tbl.checked = false;
	end
	dropDown.label:SetText("|cff00ff00Pick Layout...");
end