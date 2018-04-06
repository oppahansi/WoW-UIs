local K, C, L, _ = select(2, ...):unpack()

local hooksecurefunc = hooksecurefunc
local GetNumQuestLogEntries, GetQuestLogTitle = GetNumQuestLogEntries, GetQuestLogTitle
local IsModifiedClick, IsAltKeyDown, IsControlKeyDown = IsModifiedClick, IsAltKeyDown, IsControlKeyDown
local GetQuestLogPushable = GetQuestLogPushable
local GetID = GetID

-- Quest level(yQuestLevel by Yleaf)
local function questlevel()
	local buttons = QuestLogScrollFrame.buttons
	local numButtons = #buttons
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries = GetNumQuestLogEntries()

	for i = 1, numButtons do
		local questIndex = i + scrollOffset
		local questLogTitle = buttons[i]
		if questIndex <= numEntries then
			local title, level, _, _, isHeader = GetQuestLogTitle(questIndex)
			if not isHeader then
				questLogTitle:SetText("["..level.."] "..title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end
hooksecurefunc("QuestLog_Update", questlevel)
QuestLogScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)

-- CTRL+Click to abandon a quest or ALT+Click to share a quest(by Suicidal Katt)
hooksecurefunc("QuestLogTitleButton_OnClick", function(self, button)
	local questIndex = self:GetID()
	if IsModifiedClick() then
		if self.isHeader then return end
		if IsControlKeyDown() then
			QuestLog_SetSelection(questIndex)
			AbandonQuest()
			QuestLog_Update()
			QuestLog_SetSelection(questIndex)
		elseif IsAltKeyDown() then
			QuestLog_SetSelection(questIndex)
			if GetQuestLogPushable() then
				QuestLogPushQuest()
			end
		end
	end
end)