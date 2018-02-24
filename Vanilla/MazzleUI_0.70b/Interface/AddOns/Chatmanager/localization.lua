------------------------------------------------------------------------------
-- Globals required by localized tables
------------------------------------------------------------------------------
CHATMANAGER_EM = {
	ON = "|cffffff00",					-- Yellow (default emphasis color)
	RED = "|cffff4000",					-- Red (used for warnings)
	OFF = "|r",
};


------------------------------------------------------------------------------
-- English localization (default)
--
-- Original text by Cirk
------------------------------------------------------------------------------
-- Bindings text
BINDING_HEADER_CHATMANAGER_TITLE = "Chatmanager";
BINDING_NAME_CHATMANAGER_PANEL = "Toggle Chatmanager";
BINDING_NAME_CHATMANAGER_SAY = "Say";
BINDING_NAME_CHATMANAGER_PARTY = "Party";
BINDING_NAME_CHATMANAGER_RAID = "Raid";
BINDING_NAME_CHATMANAGER_GUILD = "Guild";
BINDING_NAME_CHATMANAGER_OFFICER = "Officer";
BINDING_NAME_CHATMANAGER_CHANNEL_1 = "Channel 1";
BINDING_NAME_CHATMANAGER_CHANNEL_2 = "Channel 2";
BINDING_NAME_CHATMANAGER_CHANNEL_3 = "Channel 3";
BINDING_NAME_CHATMANAGER_CHANNEL_4 = "Channel 4";
BINDING_NAME_CHATMANAGER_CHANNEL_5 = "Channel 5";
BINDING_NAME_CHATMANAGER_CHANNEL_6 = "Channel 6";
BINDING_NAME_CHATMANAGER_CHANNEL_7 = "Channel 7";
BINDING_NAME_CHATMANAGER_CHANNEL_8 = "Channel 8";
BINDING_NAME_CHATMANAGER_CHANNEL_9 = "Channel 9";
BINDING_NAME_CHATMANAGER_CHANNEL_10 = "Channel 10";

-- General text strings
CHATMANAGER_TEXT = {
	FRAME_TITLE = "Chatmanager",
	FRAME_LIST_TITLE = "Channels",
	FRAME_SETTINGS_TITLE_FORMAT = "Settings for %s",
	FRAME_SETTINGS_TITLE_UNSELECTED = "Channel Settings",
	FRAME_CHANNEL_NAME_FORMAT = "%s (%d)",
	FRAME_CHANNEL_NAME_NOPLAYERS_FORMAT = "%s",
	FRAME_CHANNEL_NAME_SUSPENDED_FORMAT = "%s (inactive)",
	FRAME_PLAYERS_TITLE_FORMAT = "Players (%d)",
	FRAME_PLAYERS_TITLE_NONE = "Players",
	FRAME_LIST_NUMBER_FORMAT = "%d.",
	PASSWORD_TITLE = "Password",
	ALWAYS_USE_PASSWORD_TITLE = "Always use password",
	ALWAYS_USE_PASSWORD_ON_TOOLTIP = "Forces password to be used if there isn't one when connecting to the channel",
	ALWAYS_USE_PASSWORD_OFF_TOOLTIP = "Password will only be remembered until it is not needed",
	CHANNEL_STICKY_TITLE = "Channel is sticky",
	CHANNEL_STICKY_ON_TOOLTIP = "This channel will stay as the default after you send a message on it",
	CHANNEL_STICKY_OFF_TOOLTIP = "Will not be the default for the next message you send",
	CHANNEL_COLOR_TITLE = "Channel text color",
	CHANNEL_COLOR_TOOLTIP = "Change color of messages for this channel",
	PASSWORD_SET_BUTTON = "Set",
	MODERATE_BUTTON = "Moderate",
	OPTIONS_BUTTON = "Options",

	OPTIONS_FRAME_TITLE = "Chat Options",
	REPLY_TO_SENT_TITLE = "Reply also to last whisper sent",
	REPLY_TO_SENT_ON_TOOLTIP = "Reply to either the last player who whispered you or that you whispered to",
	REPLY_TO_SENT_OFF_TOOLTIP = "Reply only to last player who whispered you",
	CHAT_LINK_TITLE = "Send item links in chat channels",
	CHAT_LINK_ON_TOOLTIP = "Players using Chatmanager can see items you link in private chat channels",
	CHAT_LINK_OFF_TOOLTIP = "Item links in chat channels are sent as names only",
	CHAT_LINK_COMPAT_ON_TOOLTIP = "Players using Chatmanager or ChatLink can see items you link in private chat channels",
	CHAT_LINK_FORMAT_TITLE = "Use ChatLink format",
	CHAT_LINK_FORMAT_ON_TOOLTIP = "Sends item links in a format compatible with Yrys's ChatLink",
	CHAT_LINK_FORMAT_OFF_TOOLTIP = "Sends item links using Chatmanager's own format",
	CHAT_LINK_FORMAT_TITLE = "Use ChatLink format",
	SMART_STICKY_TITLE = "Enable channel smart-sticky mode",
	SMART_STICKY_ON_TOOLTIP = "Channels that are normally sticky are not while you are in a raid or party",
	SMART_STICKY_OFF_TOOLTIP = "Channels are always sticky or not depending on their setting",
	CHAT_LOG_TITLE = "Remember chat logging state",
	CHAT_LOG_ON_TOOLTIP = "Chat logging state is remembered between logins",
	CHAT_LOG_OFF_TOOLTIP = "Chat logging state is not remembered",
	CHAT_BUTTON_TITLE = "Show Chatmanager button",
	CHAT_BUTTON_ON_TOOLTIP = "Show the Chatmanager button",
	CHAT_BUTTON_OFF_TOOLTIP = "Hide the Chatmanager button",
	CHAT_SCROLL_TITLE = "Chat window mousewheel scrolling",
	CHAT_SCROLL_ON_TOOLTIP = "Mousewheel will scroll in chat windows",
	CHAT_SCROLL_OFF_TOOLTIP = "Mousewheel not used in chat windows",
	CHAT_HIDE_BUTTONS_TITLE = "Hide chat window buttons",
	CHAT_HIDE_BUTTONS_ON_TOOLTIP = "Hides the chat window scroll and menu buttons",
	CHAT_HIDE_BUTTONS_OFF_TOOLTIP = "Chat window scroll buttons will be shown as normal",

	CHAT_STICKY_SAY_TITLE = "Say is sticky",
	CHAT_STICKY_SAY_ON_TOOLTIP = "Say will be sticky",
	CHAT_STICKY_SAY_OFF_TOOLTIP = "Say will not be sticky",
	CHAT_STICKY_PARTY_TITLE = "Party is sticky",
	CHAT_STICKY_PARTY_ON_TOOLTIP = "Party chat will be sticky",
	CHAT_STICKY_PARTY_OFF_TOOLTIP = "Party chat will not be sticky",
	CHAT_STICKY_RAID_TITLE = "Raid is sticky",
	CHAT_STICKY_RAID_ON_TOOLTIP = "Raid chat will be sticky",
	CHAT_STICKY_RAID_OFF_TOOLTIP = "Raid chat will not be sticky",
	CHAT_STICKY_GUILD_TITLE = "Guild is sticky",
	CHAT_STICKY_GUILD_ON_TOOLTIP = "Guild chat will be sticky",
	CHAT_STICKY_GUILD_OFF_TOOLTIP = "Guild chat will not be sticky",
	CHAT_STICKY_OFFICER_TITLE = "Officer is sticky",
	CHAT_STICKY_OFFICER_ON_TOOLTIP = "Officer chat will be sticky",
	CHAT_STICKY_OFFICER_OFF_TOOLTIP = "Officer chat will not be sticky",
	CHAT_STICKY_WHISPER_TITLE = "Whisper is sticky",
	CHAT_STICKY_WHISPER_ON_TOOLTIP = "Whispers will be sticky",
	CHAT_STICKY_WHISPER_OFF_TOOLTIP = "Whispers will not be sticky",

	MOVE_TO_OPTION = "Move channel to",
	MOVE_TO_CHANNEL_FORMAT = "%d.",
	TEXT_COLOR_OPTION = "Change text color",
	LEAVE_OPTION = "Leave channel",
	MUTE_PLAYER_OPTION = "Mute",
	UNMUTE_PLAYER_OPTION = "Unmute",
	KICK_PLAYER_OPTION = "Kick",
	BAN_PLAYER_OPTION = "Ban",
	SET_MODERATOR_OPTION = "Set moderator",
	UNSET_MODERATOR_OPTION = "Unset moderator",
	SET_OWNER_OPTION = "Set as owner",
	EDIT_PLAYER_NOTE = "Edit note",

	NEW_CHANNEL_OPTION = "Join new channel...",
	REJOIN_CHANNEL_OPTION = "Rejoin %s",

	ENTER_NEW_CHANNEL_TEXT = "Enter name of channel to connect to:\n(a password can be optionally given after the name)",
	ENTER_PLAYER_NOTE_TEXT = "Edit note for player %s",
	MENU_BUTTON_DRAG_TOOLTIP = "Use CTRL key to drag",

	CHANNEL_HEADER = "%d. %s",											-- 1. General
	LIST_CHANNELS_FORMAT_STRING = "[%d. %s] ",							-- [1. General]
	LIST_CHANNELS_PARSE_STRING = "%[(%d+)%. (.-)%]",					-- [1. General - Ironforge]
	LIST_PLAYER_NAMES_PARSE_STRING = "([%*%#%@]*)([^%p%s]+)",			-- *Gimlet, @Cirk, Stigma, #Prodigal
	LIST_PLAYER_OWNER = "*",											-- Must match string value from client
	LIST_PLAYER_MODERATOR = "@",										-- Must match string value from client
	LIST_PLAYER_MUTED = "#",											-- Must match string value from client

	PLAYER_NAME_OWNER_FORMAT = "%s *",
	PLAYER_NAME_MODERATOR_FORMAT = "%s @",
	PLAYER_NAME_MUTED_FORMAT = "%s #",
	PLAYER_NAME_NORMAL_FORMAT = "%s",

	PLAYER_OWNER_TOOLTIP_FORMAT = "Channel owner",
	PLAYER_MODERATOR_TOOLTIP_FORMAT = "Moderator",
	PLAYER_MUTED_TOOLTIP_FORMAT = "Muted",

	CONFIRM_LEAVE_FORMAT = "Really leave \"%s\" channel?",

	DEBUG = CHATMANAGER_EM.ON.."Chatmanager: "..CHATMANAGER_EM.OFF,
	ERROR = CHATMANAGER_EM.RED.."Chatmanager: "..CHATMANAGER_EM.OFF,
};

-- Slash commands and responses
CHATMANAGER_COMMANDS = {
	-- Slash commands
	COMMAND_HELP = "help",
	COMMAND_SHOW = "show",
	COMMAND_HIDE = "hide",
	COMMAND_OPTIONS = "options",
	COMMAND_DEBUGON = "debugon",
	COMMAND_DEBUGOFF = "debugoff",
	COMMAND_RESET = "reset",
	OPTION_RESET_ORDER = "order",
	OPTION_RESET_COLOR = "color",
	OPTION_RESET_WINDOW = "window",
	OPTION_RESET_ALL = "all",
	COMMAND_PLAYERNOTE = "note",
	COMMAND_LISTNOTES = "list",

	-- Slash command responses
	COMMAND_DEBUGON_CONFIRM = "Chatmanager debug is enabled",
	COMMAND_DEBUGOFF_CONFIRM = "Chatmanager debug is disabled",
	COMMAND_RESET_ORDER_CONFIRM = CHATMANAGER_EM.ON.."Chatmanager channel assignments reset"..CHATMANAGER_EM.OFF,
	COMMAND_RESET_COLOR_CONFIRM = CHATMANAGER_EM.ON.."Chatmanager channel colors reset to default"..CHATMANAGER_EM.OFF,
	COMMAND_RESET_WINDOW_CONFIRM = CHATMANAGER_EM.ON.."Chatmanager window positions reset"..CHATMANAGER_EM.OFF,
	COMMAND_RESET_HELP = CHATMANAGER_EM.ON.."Specify "..CHATMANAGER_EM.OFF.."order"..CHATMANAGER_EM.ON..", "..CHATMANAGER_EM.OFF.."color"..CHATMANAGER_EM.ON..", "..CHATMANAGER_EM.OFF.."window"..CHATMANAGER_EM.ON..", or "..CHATMANAGER_EM.OFF.."all"..CHATMANAGER_EM.OFF,
	COMMAND_PLAYERNOTE_CONFIRM_FORMAT = CHATMANAGER_EM.ON.."Note for player "..CHATMANAGER_EM.OFF.."%s"..CHATMANAGER_EM.ON.." has been changed to \""..CHATMANAGER_EM.OFF.."%s"..CHATMANAGER_EM.ON.."\""..CHATMANAGER_EM.OFF,
	COMMAND_PLAYERNOTE_REMOVE_FORMAT = CHATMANAGER_EM.ON.."Note for player "..CHATMANAGER_EM.OFF.."%s"..CHATMANAGER_EM.ON.." removed."..CHATMANAGER_EM.OFF,
	COMMAND_PLAYERNOTE_HELP = CHATMANAGER_EM.ON.."A player name is required for this command."..CHATMANAGER_EM.OFF,
	COMMAND_PLAYERNOTE_LIST_FORMAT = CHATMANAGER_EM.ON.."%d. "..CHATMANAGER_EM.OFF.."%s"..CHATMANAGER_EM.ON.." - "..CHATMANAGER_EM.OFF.."%s",
	COMMAND_PLAYERNOTE_LIST_EMPTY = CHATMANAGER_EM.ON.."You have no player notes on this server."..CHATMANAGER_EM.OFF,
};

-- Help text
CHATMANAGER_HELP = {
	CHATMANAGER_EM.ON.."Helps you to manage your chat channels:"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_HELP..CHATMANAGER_EM.ON.." shows this help message"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_EM.ON.."toggles Chatmanager between shown and hidden"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_SHOW..CHATMANAGER_EM.ON.." shows your Chatmanager"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_HIDE..CHATMANAGER_EM.ON.." hides your Chatmanager"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_OPTIONS..CHATMANAGER_EM.ON.." shows your Chatmanager options"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_RESET.." "..CHATMANAGER_COMMANDS.OPTION_RESET_ORDER..CHATMANAGER_EM.ON.." resets channels to client ordering"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_RESET.." "..CHATMANAGER_COMMANDS.OPTION_RESET_COLOR..CHATMANAGER_EM.ON.." resets channels colors to default"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_RESET.." "..CHATMANAGER_COMMANDS.OPTION_RESET_WINDOW..CHATMANAGER_EM.ON.." resets window positions"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_RESET.." "..CHATMANAGER_COMMANDS.OPTION_RESET_ALL..CHATMANAGER_EM.ON.." resets channel ordering, colors, and window positions"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE.." <name> [note]"..CHATMANAGER_EM.ON.." allows you to edit the note for a player"..CHATMANAGER_EM.OFF,
	"   /chatmanager "..CHATMANAGER_COMMANDS.COMMAND_LISTNOTES..CHATMANAGER_EM.ON.." lists all known player notes to your chat window (may be very long)"..CHATMANAGER_EM.OFF,
};
