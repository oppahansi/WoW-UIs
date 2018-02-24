
UIPanelWindows.WorldMapFrame = {area = 'center', pushable = 9}

hooksecurefunc(WorldMapFrame, 'Show', function(self)
	self:EnableKeyboard(false)
	self:EnableMouse(false)
    self:SetScale(0.9)
    
    WorldMapZoomOutButton:Hide()
    
	BlackoutWorld:Hide()
end)

local f = CreateFrame('Frame')
f:SetParent(WorldMapButton)

f.cursor = f:CreateFontString(nil, 'ARTWORK')
f.cursor:SetFontObject('GameFontNormal')
f.cursor:SetJustifyH('LEFT')
f.cursor:SetPoint('BOTTOMLEFT', WorldMapButton, 'BOTTOM', -125, -20)
        
f.player = f:CreateFontString(nil, 'ARTWORK')
f.player:SetFontObject('GameFontNormal')
f.player:SetJustifyH('RIGHT')
f.player:SetPoint('BOTTOMRIGHT', WorldMapButton, 'BOTTOM', 125, -20)

f:SetScript('OnUpdate', function()
    local width = WorldMapButton:GetWidth() 
    local height = WorldMapButton:GetHeight()
    local mx, my = WorldMapFrame:GetCenter()
    local px, py = GetPlayerMapPosition('player')
    local cx, cy = GetCursorPosition()

    mx = (((cx / WorldMapFrame:GetScale()) - (mx - width / 2)) / width + 22 / 10000)
    my = ((((my + height / 2) - (cy / WorldMapFrame:GetScale())) / height) - 262 / 10000)

    f.cursor:SetText(format('Cursor %.2d*%.2d', mx * 100, my * 100))
    f.player:SetText(format('Player %.2d*%.2d', px * 100, py * 100))
end)