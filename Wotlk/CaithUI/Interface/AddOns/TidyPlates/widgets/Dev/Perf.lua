--[[

SetCVar("scriptProfile", 1)
local Perfmon = CreateFrame("Frame")
local Perfstats = {}
local updateWhen = GetTime()
local incrementWhen = 2

local function UpdatePerformanceStats()
	if GetTime() < updateWhen then return end
	updateWhen = GetTime() + incrementWhen
	UpdateAddOnCPUUsage()
	UpdateAddOnMemoryUsage()
	Perfstats.gather =  10*GetFunctionCPUUsage(UpdatePlate, false) or 0
	Perfstats.indicators =  10*GetFunctionCPUUsage(UpdatePlateIndicators, true) or 0
	Perfstats.style =  10*GetFunctionCPUUsage(UpdateStyle, true) or 0
	Perfstats.update = 10*(GetFunctionCPUUsage(OnUpdate, false) + GetFunctionCPUUsage(OnCreateChildFrames, false) + GetFunctionCPUUsage(UpdateAll, false)) or 0
	Perfstats.sum = Perfstats.gather + Perfstats.indicators + Perfstats.style + Perfstats.update
	print("TIME: "..GetTime()..", SUM:"..Perfstats.sum.." PCT_GATHER: "..ceil(100*(Perfstats.gather/Perfstats.sum))..", PCT_INDICATOR: "..ceil(100*(Perfstats.indicators/Perfstats.sum))..", PCT_STYLE: "..ceil(100*(Perfstats.style/Perfstats.sum))..", PCT_UPDATE:"..ceil(100*(Perfstats.update/Perfstats.sum)))
end

function StartTidyPlatesMonitor()
	ResetCPUUsage()
	Perfmon:SetScript("OnUpdate", UpdatePerformanceStats)
end
-- /script StartTidyPlatesMonitor()

--]]