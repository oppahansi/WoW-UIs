local K, C, L, _ = select(2, ...):unpack()
if C.Automation.AutoCollapse ~= true or IsAddOnLoaded("QuestHelper") == true then return end

local CreateFrame = CreateFrame
local IsInInstance = IsInInstance
local InCombatLockdown = InCombatLockdown

-- Auto collapse WatchFrame
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if InCombatLockdown() then
		return
	end

	if IsInInstance() then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	elseif WatchFrame.collapsed and not InCombatLockdown() then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	end
end)