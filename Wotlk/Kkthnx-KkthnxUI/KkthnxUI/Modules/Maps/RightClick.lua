local K, C, L, _ = select(2, ...):unpack()
if C.Minimap.Enable ~= true then return end

local match = string.match
local CreateFrame, UIParent = CreateFrame, UIParent
local ToggleFrame = ToggleFrame
local IsShiftKeyDown = IsShiftKeyDown
local ToggleDropDownMenu = ToggleDropDownMenu

-- Right click menu
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function() ToggleTalentFrame() end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON,
	func = function() ToggleFrame(QuestLogFrame) end},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end},
	{text = L_MAP_FARMMODE,
	func = SlashCmdList.FARMMODE},
	{text = L_ADDON_LIST,
	func = SlashCmdList.ADDONLIST},
	{text = TIMEMANAGER_TITLE,
	func = function() ToggleTimeManager() end},
	{text = PLAYER_V_PLAYER,
	func = function() ToggleFrame(PVPParentFrame) end},
	{text = LFG_TITLE,
	func = function() ToggleFrame(LFDParentFrame) end},
	{text = L_LFRAID,
	func = function() ToggleFrame(LFRParentFrame) end},
	{text = HELP_BUTTON,
	func = function() ToggleHelpFrame() end},
	{text = L_CALENDAR,
		func = function()
			if(not CalendarFrame) then
				LoadAddOn("Blizzard_Calendar")
			end

			Calendar_Toggle()
	end}
}

local taint = CreateFrame("Frame")
taint:RegisterEvent("PLAYER_ENTERING_WORLD")
taint:SetScript("OnEvent", function(self)
	ToggleFrame(SpellBookFrame)
	ToggleFrame(SpellBookFrame)
end)

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = self:GetPoint()
	if(button == "MiddleButton" or (button == "RightButton" and IsShiftKeyDown())) then
		if(position:match("LEFT")) then
			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(menuList, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	elseif(button == "RightButton") then
		local xoff = -1
		if(position:match("RIGHT")) then
			xoff = -16
		end

		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, xoff, -3)
	else
		Minimap_OnClick(self)
	end
end)