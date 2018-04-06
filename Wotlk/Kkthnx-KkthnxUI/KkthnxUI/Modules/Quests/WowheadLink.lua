local K, C, L, _ = select(2, ...):unpack()
if IsAddOnLoaded("QuestHelper") then return end

local format = string.format
local IsControlKeyDown = IsControlKeyDown
local CreateFrame = CreateFrame
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestIndexForWatch = GetQuestIndexForWatch
local hooksecurefunc = hooksecurefunc

-- Add quest/achievement OpenWow link
local linkQuest, linkAchievement
if K.Client == "ruRU" then
	linkQuest = "http://ru.wowhead.com/quest=%d"
	linkAchievement = "http://ru.wowhead.com/achievement=%d"
elseif K.Client == "frFR" then
	linkQuest = "http://fr.wowhead.com/quest=%d"
	linkAchievement = "http://fr.wowhead.com/achievement=%d"
elseif K.Client == "deDE" then
	linkQuest = "http://de.wowhead.com/quest=%d"
	linkAchievement = "http://de.wowhead.com/achievement=%d"
elseif K.Client == "esES" or K.Client == "esMX" then
	linkQuest = "http://es.wowhead.com/quest=%d"
	linkAchievement = "http://es.wowhead.com/achievement=%d"
elseif K.Client == "ptBR" or K.Client == "ptPT" then
	linkQuest = "http://pt.wowhead.com/quest=%d"
	linkAchievement = "http://pt.wowhead.com/achievement=%d"
else
	linkQuest = "http://www.wowhead.com/quest=%d"
	linkAchievement = "http://www.wowhead.com/achievement=%d"
end

StaticPopupDialogs.WATCHFRAME_URL = {
	text = L_WATCH_WOWHEAD_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	hasWideEditBox = 1,
	OnShow = function(self, ...) self.wideEditBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	preferredIndex = 3,
}

local tblDropDown = {}
hooksecurefunc("WatchFrameDropDown_Initialize", function(self)
	if self.type == "QUEST" then
		tblDropDown = {
			text = L_WATCH_WOWHEAD_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, watchId)
				local logId = GetQuestIndexForWatch(watchId)
				local _, _, _, _, _, _, _, _, questId = GetQuestLogTitle(logId)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.wideEditBox:SetText(linkQuest:format(questId))
				inputBox.wideEditBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	elseif self.type == "ACHIEVEMENT" then
		tblDropDown = {
			text = L_WATCH_WOWHEAD_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, id)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.wideEditBox:SetText(linkAchievement:format(id))
				inputBox.wideEditBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	end
end)
UIDropDownMenu_Initialize(WatchFrameDropDown, WatchFrameDropDown_Initialize, "MENU")

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_AchievementUI") then
		hooksecurefunc("AchievementButton_OnClick", function(self)
			if self.id and IsControlKeyDown() then
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(self.id))
				inputBox.editBox:HighlightText()
			end
		end)
	end
end)