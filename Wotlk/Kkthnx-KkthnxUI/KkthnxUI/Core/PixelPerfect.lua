local K, C, _ = select(2, ...):unpack()

local format = string.format
local match = string.match
local min, max = math.min, math.max
local CreateFrame = CreateFrame
local GetCVar = GetCVar
local SetCVar = SetCVar

if (C.General.AutoScale) then
    C.General.UIScale = min(2, max(0.64, 768 / match(K.Resolution, "%d+x(%d+)")))
end

-- PixelPerfect Script for KkthnxUI.
local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	-- Enable UIScale for KkthnxUI
	local UseUIScale = GetCVar("useUiScale")
	if (UseUIScale ~= "1") then
		SetCVar("useUiScale", 1)
	end

	-- Multisample need to be at 1 for pixel perfectness
	if (C.General.MultisampleCheck) and (gxMultisample ~= "1") then
		local gxMultisample = GetCVar("gxMultisample")
		SetMultisampleFormat(1)
	end

	-- UIScale Security
	if C.General.UIScale > 1.0 then C.General.UIScale = 1.0 end
	if C.General.UIScale < 0.64 then C.General.UIScale = 0.64 end

	-- Set our new UIScale now if it doesn"t match Blizzard saved UIScale.
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C.General.UIScale)) then
		-- Set new UIScale
		SetCVar("uiScale", C.General.UIScale)
	end

	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if C.General.UIScale < 0.64 then
		UIParent:SetScale(C.General.UIScale)
	end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)