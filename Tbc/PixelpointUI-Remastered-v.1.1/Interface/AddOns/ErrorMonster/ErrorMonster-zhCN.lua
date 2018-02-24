local L = AceLibrary("AceLocale-2.2"):new("ErrorMonster")

L:RegisterTranslations("zhCN", function() return {
	["Shows the current filters and their ID."] = "显示当前过滤清单及ID",
	["Adds the given filter to the ignore list."] = "把特定过滤信息添加至忽略列表",
	["<filter>"] = "<过滤信息>",
	["Removes the given filter or ID from the filter list."] = "把特定过滤信息或ID从过滤列表中移除",
	["Adding filter: "] = "添加过滤信息：",
	["Removing filter: "] = "移除过滤信息：",
	["Filter not found: "] = "过滤信息未找到：",
	["Active filters:"] = "激活的过滤信息：",
	["Throttle errors at the given rate in seconds."] = "屏蔽一定时间（以秒计）内反复出现的错误",
	["Go berserk and eat all the errors."] = "狂暴！干掉所有错误信息！",
	["Teach your ErrorMonster to aggro on other message types."] = "教会ErrorMonster吸收其他类型的信息",
	["Error messages."] = "错误信息",
	["Information messages."] = "提示信息",
	["System messages."] = "系统信息",
	["System messages"] = "系统信息",
	["|cffff0000Ignore|r"] = "|cffff0000忽略|r",
	["|cff00ff00Aggro|r"] = "|cffff0000吸收|r",

	["list"] = "列表",
	["add"] = "添加",
	["remove"] = "移除",
	["throttle"] = "节流",
	["berserk"] = "狂暴",
	["aggro"] = "吸收",
	["error"] = "错误",
	["information"] = "提示",
	["system"] = "系统",
} end)

