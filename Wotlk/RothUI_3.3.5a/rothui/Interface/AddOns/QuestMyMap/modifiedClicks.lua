local function handleModified(self, button)
	if(IsModifiedClick("CHATLINK") and ChatFrameEditBox:IsVisible()) then
		ChatEdit_InsertLink(GetQuestLink(self.questLogIndex))
		return true
	elseif(button == "RightButton") then
		QuestLog_SetSelection(self.questLogIndex)
		QuestLogDetailFrame:Show()
		return true
	end
end

WorldMapQuestFrame_OnMouseUp = function(self, button)
	self.title:SetPoint("TOPLEFT", 34, -8)
	self.ownPOI:SetButtonState("NORMAL")
	QuestPOIButton_OnMouseUp(self.ownPOI)

	if(not self:IsMouseOver()) then return end

	if(WORLDMAP_SETTINGS.selectedQuest ~= self) then
		WorldMapQuestHighlightedFrame:Hide()
		PlaySound("igMainMenuOptionCheckBoxOn")
		WorldMapFrame_SelectQuestFrame(self)
	end

	if(not handleModified(self, button) and IsShiftKeyDown()) then
		local isChecked = not WorldMapTrackQuest:GetChecked()
		WorldMapTrackQuest:SetChecked(isChecked)
		WorldMapTrackQuest_Toggle(isChecked)
		WorldMapQuestFrame_UpdateMouseOver()
	end
end

WorldMapQuestPOI_OnClick = function(self, button)
	PlaySound("igMainMenuOptionCheckBoxOn")

	if(WORLDMAP_SETTINGS.selectedQuest ~= self.quest) then
		if(WORLDMAP_SETTINGS.selectedQuest) then
			WorldMapBlobFrame:DrawQuestBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
		end
		WorldMapFrame_SelectQuestFrame(self.quest)
	end

	if(not handleModified(self.quest, button) and IsShiftKeyDown()) then
		local isChecked = not WorldMapTrackQuest:GetChecked()
		WorldMapTrackQuest:SetChecked(isChecked)
		WorldMapTrackQuest_Toggle(isChecked)
	end
end