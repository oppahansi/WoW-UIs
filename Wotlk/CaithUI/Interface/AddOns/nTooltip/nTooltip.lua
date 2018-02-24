
UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 14

GameTooltipStatusBar:SetHeight(7)
GameTooltipStatusBar:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8'})

for _, tooltip in pairs({
   GameTooltip,
   ItemRefTooltip,
   WorldMapTooltip,
        
   ShoppingTooltip1,
   ShoppingTooltip2,
   ShoppingTooltip3,   

   DropDownList1MenuBackdrop,
   DropDownList2MenuBackdrop,
}) do
    tooltip:SetBackdrop({
        bgFile = 'Interface\\Buttons\\WHITE8x8', 
        insets = {
            left = 3, 
            right = 3, 
            top = 3, 
            bottom = 3
        }
    })

    tooltip:HookScript('OnShow', function(self)
        self:SetBackdropColor(0, 0, 0, 0.70)
    end)
    
    CreateBorder(tooltip, 12)
end

local function GameTooltip_GetUnit(self)
    if (GetMouseFocus() and not GetMouseFocus():GetAttribute('unit') and GetMouseFocus() ~= WorldFrame) then
        return select(2, self:GetUnit())
	elseif (GetMouseFocus() and GetMouseFocus():GetAttribute('unit')) then
		return GetMouseFocus():GetAttribute('unit')
    else
        return select(2, self:GetUnit())  
	end
end

local function GameTooltip_UnitCreatureType(unit)
    local creaturetype = UnitCreatureType(unit)
    if (creaturetype) then
        return creaturetype
    else
        return ''
    end
end

local function GameTooltip_UnitClassification(unit)
    local class = UnitClassification(unit)
    if (class == 'worldboss') then
        return '|cffFF0000'..BOSS..'|r '
    elseif (class == 'rareelite') then
        return '|cffFF66CCRare|r |cffFFFF00'..ELITE..'|r '
    elseif (class == 'rare') then 
        return '|cffFF66CCRare|r '
    elseif (class == 'elite') then
        return '|cffFFFF00'..ELITE..'|r '
    else
        return ''
    end
end

local function GameTooltip_UnitLevel(unit)
    local diff = GetQuestDifficultyColor(UnitLevel(unit))
    if (UnitLevel(unit) == -1) then
        return '|cffff0000??|r '
    elseif (UnitLevel(unit) == 0) then
        return '? '
    else
        return format('|cff%02x%02x%02x%s|r ', diff.r*255, diff.g*255, diff.b*255, UnitLevel(unit))    
    end
end

local function GameTooltip_UnitClass(unit)
    local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
    if (color) then
        return format(' |cff%02x%02x%02x%s|r', color.r*255, color.g*255, color.b*255, UnitClass(unit))
    end
end

local function GameTooltip_UnitType(unit) 
    if (UnitIsPlayer(unit)) then
        return GameTooltip_UnitLevel(unit)..UnitRace(unit)..GameTooltip_UnitClass(unit)
    else
        return GameTooltip_UnitLevel(unit)..GameTooltip_UnitClassification(unit)..GameTooltip_UnitCreatureType(unit)
    end
end

GameTooltip.Icon = GameTooltip:CreateTexture('$parentRaidIcon', 'OVERLAY')
GameTooltip.Icon:SetPoint('TOPLEFT', GameTooltip, 10, -10)
GameTooltip.Icon:SetWidth(16)
GameTooltip.Icon:SetHeight(16)

hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self)
	self:SetPoint('BOTTOMRIGHT', UIParent, -27.35, 27.35)
end)

GameTooltip:HookScript('OnTooltipCleared', function(self)
    GameTooltipStatusBar:ClearAllPoints()
    GameTooltipStatusBar:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 2, -2)
    GameTooltipStatusBar:SetPoint('TOPRIGHT', self, 'BOTTOMRIGHT', -2, -2)
    
    self.Icon:SetTexture(nil)
end)

GameTooltip:HookScript('OnTooltipSetUnit', function(self, ...)
    local unit = GameTooltip_GetUnit(self)

	if (UnitExists(unit) and UnitName(unit) ~= UNKNOWN) then
        local name, realm = UnitName(unit)

        GameTooltipTextLeft1:SetText(name)
        
        if (GetGuildInfo(unit)) then
            if (GetGuildInfo(unit) == GetGuildInfo('player') and IsInGuild('player')) then
               GameTooltipTextLeft2:SetText('|cffFF66CC'..GameTooltipTextLeft2:GetText()..'|r')
            end
        end

        for i = 2, GameTooltip:NumLines() do
            if (_G['GameTooltipTextLeft'..i]:GetText():find('^'..TOOLTIP_UNIT_LEVEL:gsub('%%s', '.+'))) then
                _G['GameTooltipTextLeft'..i]:SetText(GameTooltip_UnitType(unit))
            end
        end

		for i = 2, GameTooltip:NumLines() do
			if (_G['GameTooltipTextLeft'..i]:GetText():find(PVP_ENABLED)) then
				_G['GameTooltipTextLeft'..i]:SetText(nil)
                if (UnitIsPVPFreeForAll(unit)) then
                    GameTooltipTextLeft1:SetText('|cffFF0000# |r'..GameTooltipTextLeft1:GetText())
                elseif (UnitIsPVP(unit)) then
                    GameTooltipTextLeft1:SetText('|cff00FF00# |r'..GameTooltipTextLeft1:GetText())
                end
			end
		end
        
        if (GetRaidTargetIndex(unit) and not UnitIsDead(unit)) then
           GameTooltipTextLeft1:SetText('   '..GameTooltipTextLeft1:GetText())
            self.Icon:SetTexture('Interface\\TargetingFrame\\UI-RaidTargetingIcon_'..GetRaidTargetIndex(unit))
        end

        if (UnitIsAFK(unit)) then 
            self:AppendText(' |cffffffff[|r|cff00ff00AFK|r|cffffffff]|r')   
        elseif (UnitIsDND(unit)) then
            self:AppendText(' |cffffffff[|r|cff00ff00DND|r|cffffffff]|r')
        end

        if (realm and realm ~= '') then
            self:AppendText(' (*)')
        end
        
        if (UnitIsDead(unit) or UnitIsGhost(unit)) then
            GameTooltipStatusBar:SetBackdropColor(0.5, 0.5, 0.5, 0.35)
        else
            GameTooltipStatusBar:SetBackdropColor(27/255, 243/255, 27/255, 0.35)
        end

        self:AddLine(' ')
        GameTooltipStatusBar:ClearAllPoints()
        GameTooltipStatusBar:SetPoint('LEFT', self:GetName()..'TextLeft'..self:NumLines(), 1, -3)
        GameTooltipStatusBar:SetPoint('RIGHT', self, -10, 0)
    end
end)