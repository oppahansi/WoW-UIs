local K, C, L, _ = select(2, ...):unpack()
if C.Misc.HatTrick ~= true then return end

local GameTooltip = GameTooltip
local CreateFrame = CreateFrame

local HelmCheck = CreateFrame("CheckButton", "HelmCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
HelmCheck:ClearAllPoints()
HelmCheck:SetSize(22, 22)
HelmCheck:SetPoint("TOPLEFT", CharacterHeadSlot, "TOPRIGHT", 5, 0)
HelmCheck:SetScript("OnClick", function() ShowHelm(not ShowingHelm()) end)
HelmCheck:SetScript("OnEnter", function()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	GameTooltip:SetText(OPTION_TOOLTIP_SHOW_HELM)
end)
HelmCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
HelmCheck:SetScript("OnEvent", function() HelmCheck:SetChecked(ShowingHelm()) end)
HelmCheck:RegisterEvent("UNIT_MODEL_CHANGED")
HelmCheck:SetToplevel(true)

local CloakCheck = CreateFrame("CheckButton", "CloakCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
CloakCheck:ClearAllPoints()
CloakCheck:SetSize(22, 22)
CloakCheck:SetPoint("TOPLEFT", CharacterBackSlot, "TOPRIGHT", 5, 0)
CloakCheck:SetScript("OnClick", function() ShowCloak(not ShowingCloak()) end)
CloakCheck:SetScript("OnEnter", function()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	GameTooltip:SetText(OPTION_TOOLTIP_SHOW_CLOAK)
end)
CloakCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
CloakCheck:SetScript("OnEvent", function() CloakCheck:SetChecked(ShowingCloak()) end)
CloakCheck:RegisterEvent("UNIT_MODEL_CHANGED")
CloakCheck:SetToplevel(true)

HelmCheck:SetChecked(ShowingHelm())
CloakCheck:SetChecked(ShowingCloak())