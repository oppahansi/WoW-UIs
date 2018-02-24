local L = AceLibrary("AceLocale-2.2"):new("ErrorMonster")

L:RegisterTranslations("enUS", function() return {
	["Shows the current filters and their ID."] = true,
	["Adds the given filter to the ignore list."] = true,
	["<filter>"] = true,
	["Removes the given filter or ID from the filter list."] = true,
	["Adding filter: "] = true,
	["Removing filter: "] = true,
	["Filter not found: "] = true,
	["Active filters:"] = true,
	["Throttle errors at the given rate in seconds."] = true,
	["Go berserk and eat all the errors."] = true,
	["Teach your ErrorMonster to aggro on other message types."] = true,
	["Error messages."] = true,
	["Information messages."] = true,
	["System messages."] = true,
	["System messages"] = true,
	["|cffff0000Ignore|r"] = true,
	["|cff00ff00Aggro|r"] = true,

	["list"] = true,
	["add"] = true,
	["remove"] = true,
	["throttle"] = true,
	["berserk"] = true,
	["aggro"] = true,
	["error"] = true,
	["information"] = true,
	["system"] = true,
} end)

