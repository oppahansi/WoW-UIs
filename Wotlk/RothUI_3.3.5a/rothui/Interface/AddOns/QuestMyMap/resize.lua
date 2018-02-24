local dummy = function() end

WORLDMAP_QUESTLIST_SIZE = WORLDMAP_FULLMAP_SIZE
WORLDMAP_SETTINGS.size = WORLDMAP_QUESTLIST_SIZE
WorldMapFrame_SetPOIMaxBounds()

local questList = WorldMapQuestScrollFrame

questList:ClearAllPoints()
questList:SetPoint("TOPRIGHT", WorldMapDetailFrame, "TOPRIGHT", -20, 0)
questList:SetResizable(true)
questList:SetMinResize(1, 1)
questList:SetMaxResize(284, 999)

local bg = questList:CreateTexture(nil, "BACKGROUND")
bg:SetPoint("TOPLEFT")
bg:SetPoint("BOTTOMRIGHT", 20, 0)
bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
bg:SetVertexColor(0, 0, 0)
bg:SetAlpha(0.5)

for k,v in pairs{
	WorldMapQuestRewardScrollFrame,
	WorldMapQuestDetailScrollFrame,
} do v:Hide(); v.Show = v.Hide end

hooksecurefunc("WorldMapFrame_SetQuestMapView", function()
	WorldMapDetailFrame:SetPoint("TOPLEFT", WorldMapPositioningGuide, "TOP", -502, -69)
	for i = NUM_WORLDMAP_DETAIL_TILES + 1, NUM_WORLDMAP_DETAIL_TILES + NUM_WORLDMAP_PATCH_TILES do
		_G["WorldMapFrameTexture"..i]:Show()
	end
end)

hooksecurefunc("WorldMapFrame_ResetFrameLevels", function()
	questList:SetFrameLevel(WORLDMAP_POI_FRAMELEVEL + -9)
end)
WorldMapFrame_ResetFrameLevels()

-- Sizer to drag the quest list's width

local width = 284
local sizer = CreateFrame("Button", nil, questList)
sizer:SetPoint("TOPLEFT", -3, 0)
sizer:SetPoint("BOTTOMRIGHT", questList, "BOTTOMLEFT", 5, 0)
sizer:SetScript("OnMouseDown", function(self, button)
	if(button == "LeftButton" and not IsShiftKeyDown()) then
		questList:StartSizing("LEFT")
	end
end)
sizer:SetScript("OnMouseUp", function(self, button)
	if(button == "LeftButton" and not IsShiftKeyDown()) then
		questList:StopMovingOrSizing()
		questList:ClearAllPoints()
		questList:SetPoint("TOPRIGHT", WorldMapDetailFrame, "TOPRIGHT", -20, 0)
	elseif(questList:GetWidth() < 10) then
		questList:SetWidth(width)
	else
		width = questList:GetWidth()
		questList:SetWidth(1)
	end
end)

local sizerBG = sizer:CreateTexture(nil, "BACKGROUND")
sizerBG:SetPoint("TOPLEFT")
sizerBG:SetPoint("BOTTOMRIGHT", sizer, "BOTTOMLEFT", 3, 0)
sizerBG:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
sizerBG:SetVertexColor(0, 0, 0)
sizerBG:SetAlpha(0.7)

sizer:SetScript("OnEnter", function() sizerBG:SetVertexColor(.12, .56, 1) end)
sizer:SetScript("OnLeave", function() sizerBG:SetVertexColor(0, 0, 0) end)