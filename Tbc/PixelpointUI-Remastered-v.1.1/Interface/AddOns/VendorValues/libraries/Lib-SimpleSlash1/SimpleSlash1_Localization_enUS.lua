

local o = SimpleSlash1; if (o.SHOULD_LOAD == nil) then return; end
local f = o.Localization;

if (f.NOT_LOADED == nil) then return; end
-- This localization file is the fallback in case no others load, so the following line should remain commented out.
--if (GetLocale() ~= "enUS") then return; end
f.NOT_LOADED = nil;



f.SLASH_STATUS = ("+status");

f.GENERIC_ERROR = ("The argument \"%s\" for the subcommand \"%s\" is invalid.");
f.GENERIC_STATUS = ("The option for subcommand \"#c\", as set by argument \"#i\", #s holds the value \"#r\".");
f.NON_TOGGLE_SUBCOMMAND = ("The subcommand \"%s\" is not a toggle/option subcommand, so the \"+status\" prefix holds no meaning.");
f.ALREADY_FIRED_ONCE_ONLY = ("The subcommand \"#c\" is a once-only subcommand, and has already been triggered. It cannot be triggered again.");

f.CURRENTLY = ("currently");
f.NOW = ("now");

f.UNKNOWN_SUBCOMMAND_BASIC_FEEDBACK = ("Unknown slash command subcommand, \"%s\".");
f.UNKNOWN_SUBCOMMAND_EXTENDED_FEEDBACK_HEADER = ("The following is a list of valid subcommands and their usage information.");
f.UNKNOWN_SUBCOMMAND_EXTENDED_FEEDBACK_TRAILER = ("Add \"+status\" immediately after any option-type subcommand (such as \"/<command> <subcommand> +status <arguments>\") to check the current value of that option, without modifying it.");
f.NO_USAGE_INFO = ("<no usage info>");

