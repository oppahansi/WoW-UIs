--[[
    Shaman Totem Bar Skin by Darth Android / Telroth-The Venture Co.
    This script skins the totem bar to fit TukUI, and allows the user
    to set the orientation in any of the 4 cardinal directions.
    
    To control orientation, there are two new variables in the
    actionbar section of config.lua:
    
    ["verticalshapeshift"] = true, -- Orient the shapeshift or totem bar vertically
    ["flipshapeshift"] = true, -- Expand shapeshift or totem bar down/left instead of up/right
    
    Tukz:
        Feel free to use this code in TukUI. I would be more than honored to
        have contributed to such a wonderful UI.

]]

if (TukuiDB == nil) then return; end
TukuiDB.actionbar = TukuiDB.actionbar or {}
local vert = TukuiDB.actionbar.verticalshapeshift
local flip = TukuiDB.actionbar.flipshapeshift

local buttonsize = TukuiDB:Scale(27)
local flyoutsize = TukuiDB:Scale(24)
local buttonspacing = TukuiDB:Scale(4)
local borderspacing = TukuiDB:Scale(2)

local bordercolors = {
    {.23,.45,.13},    -- Earth
    {.58,.23,.10},    -- Fire
    {.19,.48,.60},   -- Water
    {.42,.18,.74},   -- Air
    {.39,.39,.12}    -- Summon / Recall
}

--[[ Skin the little button used to open the flyout ]]
local function SkinFlyoutButton(button)
    -- OK, SO
    --[[
        Normally I'd just skin this button and be done with it. However,
        a) the button hides when your mouse leaves the associated slot button
        b) you need several pixels of space to make the skin look right
        This results in having to move the mouse really fast to make it to the
        flyout before the button is hidden. We're just going to create an extra
        frame for the skin effect and make the button a few pixels bigger.
    ]]
    button.skin = CreateFrame("Frame",nil,button)
    TukuiDB:SetTemplate(button.skin)
    button:GetNormalTexture():SetTexture(nil)
    button:ClearAllPoints()
    button.skin:ClearAllPoints()
    button.skin:SetFrameStrata("LOW")
    --Positioning
    if vert then
        button:SetHeight(buttonsize+borderspacing)
        button:SetWidth(buttonspacing*3 + borderspacing-1)
        button.skin:SetHeight(buttonsize+borderspacing)
        button.skin:SetWidth(buttonspacing*2)
        if flip then
            button:SetPoint("LEFT",button:GetParent(),"RIGHT",0,0)    
            button.skin:SetPoint("RIGHT",button,"RIGHT",0,0)
        else
            button:SetPoint("RIGHT",button:GetParent(),"LEFT",0,0)    
            button.skin:SetPoint("LEFT",button,"LEFT",0,0)
        end
    else
        button:SetWidth(buttonsize+borderspacing)
        button:SetHeight(buttonspacing*3 + borderspacing-1)
        button.skin:SetWidth(buttonsize+borderspacing)
        button.skin:SetHeight(buttonspacing*2)
        if flip then
            button:SetPoint("TOP",button:GetParent(),"BOTTOM",0,0)    
            button.skin:SetPoint("BOTTOM",button,"BOTTOM",0,0)
        else
            button:SetPoint("BOTTOM",button:GetParent(),"TOP",0,0)    
            button.skin:SetPoint("TOP",button,"TOP",0,0)
        end
    end
    
    -- Adjust the highlight [[ NOT CURRENTLY WORKING >:( GRRRRRRRRRRR ]]
    button:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]],"HIGHLIGHT")
    button:GetHighlightTexture():ClearAllPoints()
    button:GetHighlightTexture():SetPoint("TOPLEFT",button.skin,"TOPLEFT",borderspacing,-borderspacing)
    button:GetHighlightTexture():SetPoint("BOTTOMRIGHT",button.skin,"BOTTOMRIGHT",-borderspacing,borderspacing)
    --button.skin
    --button:GetHighlightTexture():SetTexture(nil)
    
end

--[[ Skin an action button ]]
local function SkinActionButton(button, colorr, colorg, colorb)
    TukuiDB:SetTemplate(button)
    button:SetBackdropBorderColor(colorr,colorg,colorb)
    -- no background if no totem selected
    button:SetBackdropColor(0,0,0,0)
    -- same size as slot button
    button:ClearAllPoints()
    button:SetAllPoints(button.slotButton)
    -- remove gaudy border
    button.overlay:SetTexture(nil)
    -- raise icon so that it's visible
    button:GetRegions():SetDrawLayer("ARTWORK")
end

--[[ Skin a slot button ]]
local function SkinButton(button,colorr, colorg, colorb)
    -- templates
    TukuiDB:SetTemplate(button)
    TukuiDB:SetTemplate(button.actionButton)
    -- make the icon visible
    button.background:SetDrawLayer("ARTWORK")
    button.background:ClearAllPoints()
    button.background:SetPoint("TOPLEFT",button,"TOPLEFT",borderspacing,-borderspacing)
    button.background:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-borderspacing,borderspacing)
    -- remove the gaudy border
    button.overlay:SetTexture(nil)
    button:SetSize(TukuiDB:Scale(27),TukuiDB:Scale(27))
    -- border color
    button:SetBackdropBorderColor(colorr,colorg,colorb)
end

--[[ Skin the summon or recall button ]]
local function SkinSummonButton(button,colorr, colorg, colorb)
    -- raise icon
    local icon = select(1,button:GetRegions())
    icon:SetDrawLayer("ARTWORK")
    icon:ClearAllPoints()
    icon:SetPoint("TOPLEFT",button,"TOPLEFT",borderspacing,-borderspacing)
    icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-borderspacing,borderspacing)
    icon:SetTexCoord(.09,.91,.09,.91)
    -- remove border
    select(12,button:GetRegions()):SetTexture(nil)
    select(7,button:GetRegions()):SetTexture(nil)
    TukuiDB:SetTemplate(button)
    button:SetSize(buttonsize,buttonsize)
    button:SetBackdropBorderColor(colorr/255,colorg/255,colorb/255)
end

local function SkinFlyoutTray(tray)
    local parent = tray.parent
    local buttons = {select(2,tray:GetChildren())}
    local closebutton = tray:GetChildren()
    local numbuttons = 0
    
    
    for i,k in ipairs(buttons) do
        local prev = i > 1 and buttons[i-1] or tray
        -- count
        if k:IsVisible() then numbuttons = numbuttons + 1 end
        -- adjust icon texture
        if k.icon then
            k.icon:SetDrawLayer("ARTWORK")
            k.icon:ClearAllPoints()
            k.icon:SetPoint("TOPLEFT",k,"TOPLEFT",borderspacing,-borderspacing)
            k.icon:SetPoint("BOTTOMRIGHT",k,"BOTTOMRIGHT",-borderspacing,borderspacing)
            TukuiDB:SetTemplate(k)
            k:SetBackdropBorderColor(unpack(bordercolors[((parent.idx-1)%5)+1]))
            if k.icon:GetTexture() ~= [[Interface\Buttons\UI-TotemBar]] then
                k.icon:SetTexCoord(.09,.91,.09,.91)
            end
        end
        -- anchor
        k:ClearAllPoints()
        if vert then
            if flip then
                k:SetPoint("LEFT",prev,"RIGHT",buttonspacing,0)
            else
                k:SetPoint("RIGHT",prev,"LEFT",-buttonspacing,0)
            end
        else
            if flip then
                k:SetPoint("TOP",prev,"BOTTOM",0,-buttonspacing)
            else
                k:SetPoint("BOTTOM",prev,"TOP",0,buttonspacing)
            end
        end
    end
    -- skin tray
    tray.middle:SetTexture(nil)
    tray.top:SetTexture(nil)
    TukuiDB:SetTemplate(tray)
    -- skin close button and fix highlight
    TukuiDB:SetTemplate(closebutton)
    closebutton:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
    closebutton:GetHighlightTexture():SetPoint("TOPLEFT",closebutton,"TOPLEFT",borderspacing,-borderspacing)
    closebutton:GetHighlightTexture():SetPoint("BOTTOMRIGHT",closebutton,"BOTTOMRIGHT",-borderspacing,borderspacing)
    closebutton:GetNormalTexture():SetTexture(nil)
    -- size and position close button and tray and first icon
    tray:ClearAllPoints()
    closebutton:ClearAllPoints()
    if vert then
        tray:SetHeight(flyoutsize + buttonspacing*2)
        tray:SetWidth((flyoutsize+buttonspacing) * numbuttons + buttonspacing)
        closebutton:SetWidth(buttonspacing * 2)
        closebutton:SetHeight(tray:GetHeight())
        if flip then
            tray:SetPoint("LEFT",parent,"RIGHT",buttonspacing + TukuiDB:Scale(1),0)
            closebutton:SetPoint("LEFT",tray,"RIGHT", TukuiDB:Scale(1),0)
            buttons[1]:SetPoint("LEFT",tray,"LEFT",buttonspacing,0)
        else
            tray:SetPoint("RIGHT",parent,"LEFT",-buttonspacing - TukuiDB:Scale(1),0)
            closebutton:SetPoint("RIGHT",tray,"LEFT", - TukuiDB:Scale(1),0)
            buttons[1]:SetPoint("RIGHT",tray,"RIGHT",-buttonspacing,0)
        end
    else
        tray:SetWidth(flyoutsize + buttonspacing*2)
        tray:SetHeight((flyoutsize+buttonspacing) * numbuttons + buttonspacing)
        closebutton:SetHeight(buttonspacing * 2)
        closebutton:SetWidth(tray:GetWidth())
        if flip then
            tray:SetPoint("TOP",parent,"BOTTOM",0,-buttonspacing - TukuiDB:Scale(1))
            closebutton:SetPoint("TOP",tray,"BOTTOM",0, - TukuiDB:Scale(1))
            buttons[1]:SetPoint("TOP",tray,"TOP",0,-buttonspacing)
        else
            tray:SetPoint("BOTTOM",parent,"TOP",0,buttonspacing + TukuiDB:Scale(1))
            closebutton:SetPoint("BOTTOM",tray,"TOP",0,TukuiDB:Scale(1))
            buttons[1]:SetPoint("BOTTOM",tray,"BOTTOM",0,buttonspacing)
        end
    end
end

function pack(...) return {...} end


local AddOn = CreateFrame("Frame")
local OnEvent = function(self, event, ...) self[event](self, event, ...) end
AddOn:SetScript("OnEvent", OnEvent)

function AddOn:PLAYER_ENTERING_WORLD()
    if select(2,UnitClass("player")) == "SHAMAN" then
        -- background
        local bgframe = CreateFrame("Frame","TotemBG",MultiCastSummonSpellButton)
        TukuiDB:SetTemplate(bgframe)
        bgframe:SetHeight(buttonsize + buttonspacing*2)
        bgframe:SetWidth(buttonspacing + (buttonspacing + buttonsize)*6)
        bgframe:SetFrameStrata("LOW")
        bgframe:ClearAllPoints()
        if vert then
            bgframe:SetWidth(buttonsize + buttonspacing*2)
            bgframe:SetHeight(buttonspacing + (buttonspacing + buttonsize)*6)
        else
            bgframe:SetHeight(buttonsize + buttonspacing*2)
            bgframe:SetWidth(buttonspacing + (buttonspacing + buttonsize)*6)
        end
        if flip then
            bgframe:SetPoint("TOPRIGHT",MultiCastSummonSpellButton,"TOPRIGHT",buttonspacing,buttonspacing)
        else
            bgframe:SetPoint("BOTTOMLEFT",MultiCastSummonSpellButton,"BOTTOMLEFT",-buttonspacing,-buttonspacing)
        end
        -- Skin and position slot buttons
        for i = 1,12 do
            -- Slots
            if i < 6 then
                local button = _G["MultiCastSlotButton"..i] or MultiCastRecallSpellButton
                local prev = _G["MultiCastSlotButton"..(i-1)] or MultiCastSummonSpellButton
                prev.idx = i - 1
                if i == 1 or i == 5 then
                    SkinSummonButton(i == 5 and button or prev,unpack(bordercolors[5]))
                end
                if i < 5 then
                    SkinButton(button,unpack(bordercolors[((i-1) % 4) + 1]))
                end
                button:ClearAllPoints()
                if vert then
                    if flip then
                        -- LOOK AT THIS HACKING TUKZ, LOOK WHAT YOU'VE MADE ME DO!
                        -- VVVVVVVVVVVVVVVVVV -- I guess I should be thankful this even works.
                        ActionButton1.SetPoint(button,"TOP",prev,"BOTTOM",0,-buttonspacing)
                    else
                        ActionButton1.SetPoint(button,"BOTTOM",prev,"TOP",0,buttonspacing)
                    end
                else
                    if flip then
                        ActionButton1.SetPoint(button,"RIGHT",prev,"LEFT",-buttonspacing,0)
                    else
                        ActionButton1.SetPoint(button,"LEFT",prev,"RIGHT",buttonspacing,0)
                    end
                end
                
            end
            -- Skin the action buttons
            SkinActionButton(_G["MultiCastActionButton"..i],unpack(bordercolors[((i-1) % 4) + 1]))
        end
        -- enable flyout tray skin
        MultiCastFlyoutFrame:HookScript("OnShow",SkinFlyoutTray)
        -- enable flyout open skin
        MultiCastFlyoutFrameOpenButton:HookScript("OnShow",SkinFlyoutButton)
    end
end

AddOn:RegisterEvent("PLAYER_ENTERING_WORLD")
