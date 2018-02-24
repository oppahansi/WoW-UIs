_G.MINUTE_ONELETTER_ABBR = '|cffffffff%dm|r'
_G.HOUR_ONELETTER_ABBR = '|cffffffff%dh|r'
_G.DAY_ONELETTER_ABBR = '|cffffffff%dd|r'
_G.SECOND_ONELETTER_ABBR = '|cffffffff%ds|r'

-- buffs to be given a purple border instead of the default.
-- numbers representing the spell ID or strings representing
-- the spell's name can be supplied.

_G.HIGHLIGHTED_BUFFS = {
    34477, -- Misdirection
    57934, -- Tricks of the Trade
    71600, -- Surging Power (Dislodged Foreign Object)
    72416, -- Frostforged Sage (Ashen Verdict Ring)
    47585, -- Dispersion
--  54646, -- Focus Magic
     2825, -- Bloodlust
    53908, -- Potion of Speed
    59626, -- Black Magic
    54758, -- Hyperspeed Acceleration
}

local function IsHighlightedBuff(name)
    for _,i in pairs(_G.HIGHLIGHTED_BUFFS) do
        if (type(i) == "string" and i == name)
            or (type(i) == "number" and select(1, GetSpellInfo(i)) == name)
        then
            return true
        end
    end
    return false
end

local function BuffFrame_SetPoint(self)
    local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
    if (self and self:IsShown()) then
        self:ClearAllPoints()
        if (hasMainHandEnchant and hasOffHandEnchant) then
            self:SetPoint('TOPRIGHT', TempEnchant2, 'TOPLEFT', -nBuff.padding.x, 0)
            return
        elseif (hasMainHandEnchant or hasOffHandEnchant) then            
            self:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -nBuff.padding.x, 0)
            return
        elseif (not hasMainHandEnchant and not hasOffHandEnchant) then
            self:SetPoint('TOPRIGHT', TempEnchant1)
            return
        end
    end
end

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -20, 0)
TemporaryEnchantFrame.SetPoint = function() end

TempEnchant2:ClearAllPoints()
TempEnchant2:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -nBuff.padding.x, 0)

for i = 1, 2 do
    local button = _G['TempEnchant'..i]
    button:SetScale(nBuff.button.scale)
    button:SetWidth(32)
    button:SetHeight(32)

    local icon = _G['TempEnchant'..i..'Icon']
    icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)

    local duration = _G['TempEnchant'..i..'Duration']
    duration:ClearAllPoints()
    duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -16)
    duration:SetFont(nBuff.button.durationFont, nBuff.button.durationFontsize,'OUTLINE')
    duration:SetShadowOffset(0, 0)
    duration:SetDrawLayer('OVERLAY')

    local border = _G['TempEnchant'..i..'Border']
    border:SetTexture(nBuff.button.borderDebuff)
    border:SetTexCoord(0, 1, 0, 1)
    border:SetVertexColor(0.9, 0.25, 0.9)
    border:ClearAllPoints()
    border:SetPoint('TOPRIGHT', button, 1, 1)
    border:SetPoint('BOTTOMLEFT', button, -1, -1)    

    button.Background = button:CreateTexture('$parentBackground', 'BACKGROUND')
    button.Background:SetPoint('TOPRIGHT', border, 3.35, 3.35)
    button.Background:SetPoint('BOTTOMLEFT', border, -3.35, -3.35)
    button.Background:SetTexture('Interface\\AddOns\\nBuff\\media\\textureBackground')
    button.Background:SetVertexColor(0, 0, 0, 1)
end

BuffFrame:SetScript('OnUpdate', function(self, elapsed)
    --self.BuffFrameUpdateTime = self.BuffFrameUpdateTime + elapsed
    --if (self.BuffFrameUpdateTime > TOOLTIP_UPDATE_TIME) then
    --    self.BuffFrameUpdateTime = 0
        BuffFrame_SetPoint(BuffButton1)
    --end
end)

function UpdateBuffAnchors()     
        local buff, previousBuff, aboveBuff; 
        local numBuffs = 0; 

        for i = 1, BUFF_ACTUAL_DISPLAY do 
            buff = _G["BuffButton"..i]; 
            if ( buff.consolidated ) then 
                if ( buff.parent == BuffFrame ) then 
                    buff:SetParent(ConsolidatedBuffsContainer); 
                    buff.parent = ConsolidatedBuffsContainer; 
                end 
            else 
                numBuffs = numBuffs + 1; 
                index = numBuffs; 
                if ( buff.parent ~= BuffFrame ) then 
                    buff.count:SetFontObject(NumberFontNormal); 
                    buff:SetParent(BuffFrame); 
                    buff.parent = BuffFrame; 
                end 
                buff:ClearAllPoints(); 
                    if (index > 1 and mod(index, nBuff.button.buffPerRow) == 1) then 
                        if (index == nBuff.button.buffPerRow + 1) then 
                            buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -nBuff.padding.y) 
                        else 
                            buff:SetPoint('TOP', aboveBuff, 'BOTTOM', 0, -nBuff.padding.y) 
                        end 
                        aboveBuff = buff; 
                    elseif (index == 1) then 
                        BuffFrame_SetPoint(buff) 
                    else 
                        buff:SetPoint('RIGHT',previousBuff, 'LEFT', -nBuff.padding.x, 0) 
                    end 
                    previousBuff = buff; 
            end 
        end 

        ConsolidatedBuffs:ClearAllPoints() 
        ConsolidatedBuffs:SetPoint("TOPLEFT", Minimap, "TOPLEFT",-10,10) 
        ConsolidatedBuffsIcon:SetAlpha(0) 

        -- A bug found by garagar on shaman character  
        -- need to reset enchant weapon each time there is an update on windfury for enhancement shaman (temp fix) 
        -- else the weapon buff will move anywhere on screen  

        TemporaryEnchantFrame:ClearAllPoints() 
        TemporaryEnchantFrame:SetPoint("TOPRIGHT", -22, -180) 
    end 
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)  
hooksecurefunc('DebuffButton_UpdateAnchors', function(self, index)
    local space = 31 + nBuff.padding.y
	local row = ceil(BUFF_ACTUAL_DISPLAY/nBuff.button.buffPerRow)

    if (row and row > 1) then
        rowspacing = -row * space
    else
        rowspacing = -space
    end

    local buff = _G[self..index]
    buff:ClearAllPoints()
	if (index > 1 and mod(index, nBuff.button.buffPerRow) == 1) then
		buff:SetPoint('TOP', _G[self..(index-nBuff.button.buffPerRow)], 'BOTTOM', 0, -nBuff.padding.y)
	elseif (index == 1) then
        buff:SetPoint('TOPRIGHT', TempEnchant1, 'BOTTOMRIGHT', 0, rowspacing)
	else
		buff:SetPoint('RIGHT', _G[self..(index-1)], 'LEFT', -nBuff.padding.x, 0)
	end
end)

hooksecurefunc('AuraButton_Update', function(self, index)
    local button = _G[self..index]
    if (button) then
        button:SetScale(nBuff.button.scale)
        button:SetWidth(32)
        button:SetHeight(32)
    end

    local icon = _G[self..index..'Icon']
    if (icon) then
        icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)
    end

    local duration = _G[self..index..'Duration']
    if (duration) then
        duration:ClearAllPoints()
        duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -16)
        duration:SetFont(nBuff.button.durationFont, nBuff.button.durationFontsize,'OUTLINE')
        duration:SetShadowOffset(0, 0)
        duration:SetDrawLayer('OVERLAY')
    end

    local count = _G[self..index..'Count']
    if (count) then
        count:ClearAllPoints()
        count:SetPoint('TOPRIGHT', button)
        count:SetFont(nBuff.button.countFont, nBuff.button.countFontsize, 'OUTLINE')
        count:SetShadowOffset(0, 0)
        count:SetDrawLayer('OVERLAY')
    end

    local border = _G[self..index..'Border']
    if (border) then
        border:SetTexture(nBuff.button.borderDebuff)
        border:SetPoint('TOPRIGHT', button, 1, 1)
        border:SetPoint('BOTTOMLEFT', button, -1, -1)
        border:SetTexCoord(0, 1, 0, 1)
    end

    if (button and not border) then
        if (not button.texture) then
            button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
            button.texture:SetParent(button)
            button.texture:SetTexture(nBuff.button.borderBuff)
            button.texture:SetVertexColor(unpack(nBuff.button.buffBorderColor))
            button.texture:SetPoint('TOPRIGHT', button, 1, 1)
            button.texture:SetPoint('BOTTOMLEFT', button, -1, -1)
        end

        local name = UnitAura('player', index)
        if (IsHighlightedBuff(name)) then
            button.texture:SetVertexColor(1, 0, 1)
            button.texture:SetTexture(nBuff.button.borderDebuff)
        else
            button.texture:SetVertexColor(unpack(nBuff.button.buffBorderColor))
            button.texture:SetTexture(nBuff.button.borderBuff)
        end
    end

    if (button and not button.Background) then
        button.Background = button:CreateTexture('$parentBackground', 'BACKGROUND')
        button.Background:SetPoint('TOPRIGHT', button.texture or border, 3.35, 3.35)
        button.Background:SetPoint('BOTTOMLEFT', button.texture or border, -3.35, -3.35)
        button.Background:SetTexture('Interface\\AddOns\\nBuff\\media\\textureBackground')
        button.Background:SetVertexColor(0, 0, 0, 1)
    end
end)