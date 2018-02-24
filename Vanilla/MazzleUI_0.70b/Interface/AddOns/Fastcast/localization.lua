------------------------------------------------------------------------------
-- Globals required by localized tables
------------------------------------------------------------------------------
FASTCAST_EM = {
	ON = "|cffffff00",					-- Yellow (default emphasis color)
	RED = "|cffff4000",					-- Red (used for warnings)
	OFF = "|r",
};


------------------------------------------------------------------------------
-- English localization (default)
--
-- Original text by Cirk
------------------------------------------------------------------------------
-- For parsing spell names
FASTCAST_SPELLDATA = {
	NAME_AND_RANK_PATTERN = "^([^%(]+)%(?([^%(%)]-)%)?$",
};

-- General strings
FASTCAST_TEXT = {
	FRAME_TITLE = "Fastcast",
	FAST_ENABLE_OPTION = "Enable fast casting",
	FAST_CASTBAR_OPTION = "Adjust casting bar",
	FAST_PLAY_SOUND_OPTION = "Play sound effect",
	FAST_PADDING_TEXT = "Cast time padding",
	CHANNEL_PROTECT = "Protect channeled spells",
	CHANNEL_MAXIMUM_TEXT = "Maximum protected time",

	HELP_BUTTON_TEXT = "[?]",
	HELP_FAST_TITLE = "Fast casting",
	HELP_FAST_DESC = "Fast casting allows you to automatically stop casting your current spell early and start casting a new one in such a way that the first spell is still cast successfully.\n\nInstant cast spells are not affected by fast casting.\n\nYou can optionally have fast cast |cffffd100adjust the casting bar|r so that the casting bar reflects the actual spell timing, meaning when casting reaches the end of the bar, you can cast again.  You can also optionally have fast cast |cffffd100play a sound effect|r when you are trying to cast again before the end of the current spell has been reached to give you better feedback.\n\nThe |cffffd100cast time padding|r (in seconds) should be set large enough to absorb typical variations in the communication delay between your client and the server.  Smaller values will allow you to cast your spells one after another faster, but will have a higher chance of being interrupted or failing to cast.  Larger values will slow down how quickly you can cast spells one after another, but will improve your spell casting reliability.",
	HELP_CHANNEL_TITLE = "Channeling protection",
	HELP_CHANNEL_DESC = "Channeling protection prevents you from accidentally canceling or restarting a currently channeled spell when pressing the same casting action key or button, allowing you to spam your channeled spells just like you can do with normal cast-time spells.\n\nAny other spell cast action will still interrupt the current channeled spell.\n\nThe |cffffd100maximum protected time|r is the longest time (in seconds) for which your channeled spell will be protected from being cancelled or restarted while they are casting.  Changing this value allows you to keep your channeled spells protected when you need them (e.g., when starting a new cast), while still allowing you to cancel or recast your spells after the protected time (e.g., for spells like priest's Mind Vision or warlock's Drain Soul).",
	HELP_NO_CHANNEL_DESC = "Your class does not have any channeled spells, so this feature is disabled.",
	
	DEBUG = FASTCAST_EM.ON.."Fastcast: "..FASTCAST_EM.OFF;
	WARNING_DISABLED_ISCASTING = FASTCAST_EM.RED.."Fastcast warning: "..FASTCAST_EM.OFF.."FastcastIsCasting() requires fast-casting to be enabled!",
	WARNING_DISABLED_STOPCASTING = FASTCAST_EM.RED.."Fastcast warning: "..FASTCAST_EM.OFF.."FastcastStopCasting() requires fast-casting to be enabled!",
}

-- Slash commands and responses
FASTCAST_COMMANDS = {
	-- Slash commands
	COMMAND_HELP = "help",
	COMMAND_ON = "on",
	COMMAND_ENABLE = "enable",
	COMMAND_OFF = "off",
	COMMAND_DISABLE = "disable",
	COMMAND_FAST = "fast",
	COMMAND_PROTECT = "protect",
	COMMAND_STATUS = "status",
	COMMAND_DEBUGON = "debugon",
	COMMAND_DEBUGOFF = "debugoff",

	-- Slash command responses
	COMMAND_FAST_ENABLE_CONFIRM = FASTCAST_EM.ON.."Fast-casting mode is enabled."..FASTCAST_EM.OFF,
	COMMAND_FAST_DISABLE_CONFIRM = FASTCAST_EM.ON.."Fast-casting mode is disabled."..FASTCAST_EM.OFF,
	COMMAND_FAST_PADDING_FORMAT = FASTCAST_EM.ON.."Fast-casting padding set to %.2f seconds."..FASTCAST_EM.OFF;
	COMMAND_FAST_ENABLED_STATUS_FORMAT = FASTCAST_EM.ON.."Fast-casting mode is currently enabled with padding %.2f seconds."..FASTCAST_EM.OFF,
	COMMAND_FAST_DISABLED_STATUS = FASTCAST_EM.ON.."Fast-casting mode is currently disabled."..FASTCAST_EM.OFF,
	COMMAND_FAST_NOT_ENABLED = FASTCAST_EM.ON.."Fast-casting mode must be enabled to use this option."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_ENABLE_CONFIRM = FASTCAST_EM.ON.."Channeling protection is enabled."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_DISABLE_CONFIRM = FASTCAST_EM.ON.."Channeling protection is disabled."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_MAXIMUM_FORMAT = FASTCAST_EM.ON.."Channeling protection maximum set to %.1f seconds."..FASTCAST_EM.OFF;
	COMMAND_PROTECT_ENABLED_STATUS_FORMAT = FASTCAST_EM.ON.."Channeling protection is currently enabled with maximum %.1f seconds."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_DISABLED_STATUS = FASTCAST_EM.ON.."Channeling protection is currently disabled."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_NOT_ENABLED = FASTCAST_EM.ON.."Channeling protection must be enabled to use this option."..FASTCAST_EM.OFF,
	COMMAND_USAGE_FAILED = FASTCAST_EM.RED.."Your class does not have any actions that Fastcast can help with.\nFastcast macros are still usable however."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_USAGE_FAILED = FASTCAST_EM.RED.."Your class does not have any channeled spells."..FASTCAST_EM.OFF,
	COMMAND_CHANNELCAST_PRESENT_NOTICE = FASTCAST_EM.RED.."Channelcast is still installed, please make sure to remove it.\nTurning off Channelcast..."..FASTCAST_EM.OFF,
	COMMAND_DEBUGON_CONFIRM = "Fastcast debug is enabled.",
	COMMAND_DEBUGOFF_CONFIRM = "Fastcast debug is disabled.",
};

-- Help text
FASTCAST_HELP = {
	FASTCAST_EM.ON.."Provides support for fast-casting of cast-time spells, and protection of channeled spells from accidental interruptions."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_HELP..FASTCAST_EM.ON.." shows this help message"..FASTCAST_EM.OFF;
	"   /fastcast"..FASTCAST_EM.ON.." shows or hides the Fastcast options window."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_FAST.." ["..FASTCAST_COMMANDS.COMMAND_ON.."|"..FASTCAST_COMMANDS.COMMAND_OFF.."]"..FASTCAST_EM.ON.." enables or disables fast casting mode."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_FAST.." #"..FASTCAST_EM.ON.." sets the cast time padding."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_PROTECT.." ["..FASTCAST_COMMANDS.COMMAND_ON.."|"..FASTCAST_COMMANDS.COMMAND_OFF.."]"..FASTCAST_EM.ON.." enables or disables channeling protection."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_PROTECT.." #"..FASTCAST_EM.ON.." sets the maximum channeling protection time."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_STATUS..FASTCAST_EM.ON.." shows the status of Fastcast"..FASTCAST_EM.OFF,
};

