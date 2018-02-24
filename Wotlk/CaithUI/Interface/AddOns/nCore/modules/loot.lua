
local f = CreateFrame('Button', nil, LootFrame, 'UIPanelButtonTemplate')
f:SetPoint('TOPRIGHT', LootFrame, -80, -43)
f:SetFrameStrata('HIGH')
f:SetWidth(100)
f:SetHeight(24)
f:SetText('Loot all')
f:SetScript('OnClick', function()
	for i = 1, GetNumLootItems() do 
        LootSlot(i) 
    end
    
	if (LootFrame:IsShown()) then 
        CloseLoot() 
    end
end)