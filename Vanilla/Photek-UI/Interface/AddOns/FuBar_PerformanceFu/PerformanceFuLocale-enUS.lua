local L = AceLibrary("AceLocale-2.0"):new("FuBar_PerformanceFu")

L:RegisterTranslations("enUS", function() return {
	["Show framerate"] = true,
	["Toggle whether to framerate"] = true,
	["Show latency"] = true,
	["Toggle whether to latency (lag)"] = true,
	["Show memory usage"] = true,
	["Toggle whether to show current memory usage"] = true,
	["Show rate of increasing memory usage"] = true,
	["Toggle whether to show increasing rate of memory"] = true,
	["Warn on garbage collection"] = true,
	["Toggle whether to warn on an upcoming garbage collection"] = true,
	["Force garbage collection"] = true,
	["Force a garbage collection to happen"] = true,
	["Garbage collection occurred"] = true,
	["Garbage collection in %s"] = true,
	["Framerate:"] = true,
	["Network status"] = true,
	["Latency:"] = true,
	["Bandwidth in:"] = true,
	["Bandwidth out:"] = true,
	["Memory usage"] = true,
	["Current memory:"] = true,
	["Initial memory:"] = true,
	["Increasing rate:"] = true,
	["Average increasing rate:"] = true,
	["Garbage collection"] = true,
	["Threshold:"] = true,
	["Time to next:"] = true,
	
	["AceConsole-options"] = {"/perffu", "/performancefu"},
} end)