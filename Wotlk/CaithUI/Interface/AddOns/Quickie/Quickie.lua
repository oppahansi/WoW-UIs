
local size = 32

local left = CharacterModelFrameRotateLeftButton 
left:ClearAllPoints() 
left:SetPoint("LEFT", PaperDollFrame, "LEFT", 70, 5) 
    
local right = CharacterModelFrameRotateRightButton
right:ClearAllPoints()
right:SetPoint("RIGHT", PaperDollFrame, "RIGHT", -90, 5)

local head = CreateFrame("Button", nil, PaperDollFrame)
head:SetToplevel(true)
head:SetWidth(size)
head:SetHeight(size)
head:SetPoint("LEFT", CharacterHeadSlot, "RIGHT", 9, 0)
head:SetScript("OnClick", function() 
    ShowHelm(not ShowingHelm()) 
end)
head:SetNormalTexture("Interface\\AddOns\\Quickie\\media\\textureHead")
head:SetPushedTexture("Interface\\AddOns\\Quickie\\media\\textureCloak")
head:SetHighlightTexture("Interface\\AddOns\\Quickie\\media\\textureHighlight")

local cloak = CreateFrame("Button", nil, PaperDollFrame)
cloak:SetToplevel(true)
cloak:SetWidth(size)
cloak:SetHeight(size)
cloak:SetPoint("LEFT", CharacterBackSlot, "RIGHT", 9, 0)
cloak:SetScript("OnClick", function() 
    ShowCloak(not ShowingCloak()) 
end)
cloak:SetNormalTexture("Interface\\AddOns\\Quickie\\media\\textureHead")
cloak:SetPushedTexture("Interface\\AddOns\\Quickie\\media\\textureCloak")
cloak:SetHighlightTexture("Interface\\AddOns\\Quickie\\media\\textureHighlight")