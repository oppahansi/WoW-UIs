--[[

    The Shadow-Code ist based on Neals nMainbar Addon!!
    All thx and so on has to go to him, since I, Xu aka Garry,
    only removed stuff which are not needed and changed it a bit
    to get it working with Zorks rActionButtonStyler.

    Thank you Neal and Zork 4 great addons!!!

--]]


local mediaPath = "Interface\\AddOns\\xuButtonShadow\\"
local glowTex = mediaPath.."glowTex"
local bgfile = mediaPath.."back"
local frameBD = {
  bgFile = bgfile,
	edgeFile = glowTex, edgeSize = 5,
	tile = true, tileSize = 16,
	insets = {left = 6, right = 6, top = 6, bottom = 6}
}

hooksecurefunc('PetActionBar_Update', function()
    for _, name in pairs({
        'PetActionButton',
        'PossessButton',
        'ShapeshiftButton',
    }) do
        for i = 1, 12 do
            local button = _G[name..i]
            if (button) then
                --local button = _G[name..i]
                local normal
                if (name == 'PetActionButton') then
                    normal = _G[name..i..'NormalTexture2']
                else
                    normal = _G[name..i..'NormalTexture']
                end

                if (not button.Background) then
					button.Background = CreateFrame("Frame", nil, button)
					button.Background:SetPoint("TOPLEFT", normal, "TOPLEFT", -4, 4)
					button.Background:SetPoint("BOTTOMRIGHT", normal, "BOTTOMRIGHT", 4, -4)
					button.Background:SetFrameStrata("LOW")
					button.Background:SetBackdrop(frameBD)
					button.Background:SetBackdropColor(0, 0, 0, 0.3)
					button.Background:SetBackdropBorderColor(0, 0, 0)
                end
            end
        end
    end
end)

hooksecurefunc('ActionButton_Update', function(self)
    local totemButton = self:GetName():match("MultiCastAction")

    if (not totemButton) then
        local button = _G[self:GetName()]
        local normal = _G[self:GetName()..'NormalTexture']

        if (not button.Background and not button.Background2) then

				button.Background2 = CreateFrame("Frame", nil, button)
				button.Background2:SetPoint("TOPLEFT", normal, "TOPLEFT", -4, 4)
				button.Background2:SetPoint("BOTTOMRIGHT", normal, "BOTTOMRIGHT", 4, -4)
				button.Background2:SetFrameStrata("LOW")
				button.Background2:SetBackdrop(frameBD)
				button.Background2:SetBackdropColor(0, 0, 0, 0.3)
				button.Background2:SetBackdropBorderColor(0, 0, 0)
        end
    end
end)