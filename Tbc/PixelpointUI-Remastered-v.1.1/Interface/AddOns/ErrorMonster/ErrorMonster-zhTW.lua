local L = AceLibrary("AceLocale-2.2"):new("ErrorMonster")

L:RegisterTranslations("zhTW", function() return {
	["Shows the current filters and their ID."] = "顯示目前過濾清單及ID",
	["Adds the given filter to the ignore list."] = "把特定過濾訊息加入至忽略列表",
	["<filter>"] = "<過濾訊息>",
	["Removes the given filter or ID from the filter list."] = "把特定過濾訊息或ID從過濾列表中移除",
	["Adding filter: "] = "加入過濾訊息：",
	["Removing filter: "] = "移除過濾訊息：",
	["Filter not found: "] = "過濾訊息未找到：",
	["Active filters:"] = "生效的過濾訊息：",
	["Throttle errors at the given rate in seconds."] = "控制一定時間（以秒計）内反覆出現的錯誤",
	["Go berserk and eat all the errors."] = "狂暴！吃掉所有錯誤訊息！",
	["Teach your ErrorMonster to aggro on other message types."] = "教會ErrorMonster吸收其他類型的訊息",
	["Error messages."] = "錯誤訊息",
	["Information messages."] = "提示訊息",
	["System messages."] = "系统訊息",
	["System messages"] = "系统訊息",
	["|cffff0000Ignore|r"] = "|cffff0000忽略|r",
	["|cff00ff00Aggro|r"] = "|cffff0000吸收|r",

	["list"] = "列表",
	["add"] = "加入",
	["remove"] = "移除",
	["throttle"] = "節流",
	["berserk"] = "狂暴",
	["aggro"] = "吸收",
	["error"] = "錯誤",
	["information"] = "提示",
	["system"] = "系統",
} end)

