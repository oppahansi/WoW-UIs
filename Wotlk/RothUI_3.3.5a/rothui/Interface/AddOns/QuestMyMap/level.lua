local function tagMe(id)
	local name, lvl = GetQuestLogTitle(id)
	return name and lvl and ("[%d] %s"):format(lvl, name) or ""
end

hooksecurefunc("WorldMapFrame_UpdateQuests", function()
	i = 1
	local frame = _G["WorldMapQuestFrame"..i]
	while(_G["WorldMapQuestFrame"..i]) do
		frame.title:SetText(tagMe(frame.questLogIndex))
		i = i+1
		frame = _G["WorldMapQuestFrame"..i]
	end
end)

hooksecurefunc("WorldMapQuestPOI_SetTooltip", function(self, questLogIndex)
	WorldMapTooltipTextLeft1:SetText(tagMe(questLogIndex))
	WorldMapTooltip:AppendText("")

	if(MAP_QUEST_DIFFICULTY == "1") then
		local color = GetQuestDifficultyColor(select(2, GetQuestLogTitle(questLogIndex)))
		WorldMapTooltipTextLeft1:SetTextColor(color.r, color.g, color.b)
	end
end)