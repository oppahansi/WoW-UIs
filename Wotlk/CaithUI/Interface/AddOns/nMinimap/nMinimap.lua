
local function Minimap_GetTrackType()
    local track = nil
    for i = 1, GetNumTrackingTypes() do
        local name, _, isActive = GetTrackingInfo(i)
        if (isActive) then
            track = isActive
            MinimapTrackingText:SetText(name)
        end
        
        if (not track) then
            MinimapTrackingText:SetText(NONE)
        end
    end
end

for i = 1, select('#', GameTimeFrame:GetRegions()) do
    local texture = select(i, GameTimeFrame:GetRegions())
    if (texture and texture:GetObjectType() == 'Texture') then
        texture:SetTexture(nil)
    end
end

GameTimeFrame:SetWidth(14)
GameTimeFrame:SetHeight(14)
GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)
GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint('TOPRIGHT', Minimap, -3.5, -3.5)

GameTimeFrame:GetFontString():SetFont('Fonts\\ARIALN.ttf', 16, 'OUTLINE')
GameTimeFrame:GetFontString():SetShadowOffset(0, 0)
GameTimeFrame:GetFontString():SetPoint('TOPRIGHT', GameTimeFrame)

if (not IsAddOnLoaded('Blizzard_TimeManager')) then
    LoadAddOn('Blizzard_TimeManager')
end
    
for _, texture in pairs({
    GameTimeCalendarEventAlarmTexture,
    GameTimeCalendarInvitesTexture,
    GameTimeCalendarInvitesGlow,
}) do
    texture.Show = function()
        GameTimeFrame:GetFontString():SetTextColor(1, 0, 1)
    end
    
    texture.Hide = function() 
        local classColor = RAID_CLASS_COLORS[select(2, UnitClass('player'))]
        GameTimeFrame:GetFontString():SetTextColor(classColor.r, classColor.g, classColor.b)
    end
end

MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

MinimapBorder:Hide()
MinimapBorderTop:Hide()
--MinimapToggleButton:Hide()

MinimapZoneText:Hide()
MinimapZoneTextButton:Hide()

MiniMapWorldMapButton:Hide()

MiniMapTracking:Hide()
--MiniMapBattlefieldBorder:Hide()
--MiniMapMailBorder:Hide()
BattlegroundShine:Hide()
DurabilityFrame:Hide()

--MinimapNorthTag:SetAlpha(0)

MinimapCluster:SetScale(1.1)
MinimapCluster:EnableMouse(false)

Minimap:EnableMouseWheel(true)
Minimap:ClearAllPoints()
Minimap:SetPoint('TOPRIGHT', UIParent, -26, -26)
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

CreateBorder(Minimap, 12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

MiniMapMailText = MiniMapMailFrame:CreateFontString('MiniMapMailText', 'OVERLAY')
MiniMapMailText:SetParent(MiniMapMailFrame)
MiniMapMailText:SetFont('Fonts\\ARIALN.ttf', 16, 'OUTLINE')
MiniMapMailText:SetPoint('BOTTOMRIGHT', MiniMapMailFrame)
MiniMapMailText:SetTextColor(1, 0, 1)
MiniMapMailText:SetText('new')

MiniMapMailFrame:SetWidth((MiniMapMailText:GetStringWidth()))
MiniMapMailFrame:SetHeight(18)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint('BOTTOMRIGHT', Minimap, -4, 5)

MiniMapMailIcon:SetTexture(nil)

MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint('TOPLEFT', Minimap, -2, 1)

MinimapTrackingText = Minimap:CreateFontString('$parentTrackingText', 'OVERLAY')
MinimapTrackingText:SetFont('Fonts\\ARIALN.ttf', 15)
MinimapTrackingText:SetShadowOffset(1, -1)
MinimapTrackingText:SetPoint('CENTER', Minimap, 0, 35)
MinimapTrackingText:SetWidth((Minimap:GetWidth() - 25))
--MinimapTrackingText:SetAlpha(0)

Minimap:SetScript('OnEnter', function()
    Minimap_GetTrackType()
    UIFrameFadeIn(MinimapTrackingText, 0.15, MinimapTrackingText:GetAlpha(), 1)
end)

Minimap:SetScript('OnLeave', function()
    Minimap_GetTrackType()
    UIFrameFadeOut(MinimapTrackingText, 0.15, MinimapTrackingText:GetAlpha(), 0)
end)

Minimap:SetScript('OnMouseUp', function(self, button)
    if (button == 'RightButton') then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
    else
        Minimap_OnClick(self)
    end
end)

Minimap:SetScript('OnMouseWheel', function()
    if (arg1 > 0) then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end)