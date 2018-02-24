if not TukuiCF.actionbar.ingame then return end
local Bars = 2
local BarBG = TukuiActionBarBackground
local Bar1 = TukuiMainMenuBar
local Bar2 = TukuiBar2
local Bar3 = TukuiBar3 -- top highres
local Bar5 = TukuiBar5 -- top highres

-- buttons to set bars
local ToggleBarsButton1 = CreateFrame("Button", "ToggleBarsButton1", UIParent)
TukuiDB.CreatePanel(ToggleBarsButton1, TukuiDB.Scale(14), BarBG:GetHeight() / 2 - TukuiDB.Scale(1.5), "TOPLEFT", BarBG, "TOPRIGHT", TukuiDB.Scale(3), 0)
--ToggleBarsButton1:EnableMouse(true)
ToggleBarsButton1:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(0,0.8,1,1) end)
ToggleBarsButton1:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
ToggleBarsButton1:SetFrameLevel(2)
TukuiDB.CreateShadow(ToggleBarsButton1)
Text1 = ToggleBarsButton1:CreateFontString(nil, "LOW")
Text1:SetFont(TukuiCF.media.font, 12)
Text1:SetPoint("CENTER", ToggleBarsButton1, 0, 0)
Text1:SetText("^")

local ToggleBarsButton2 = CreateFrame("Button", "ToggleBarsButton2", UIParent)
TukuiDB.CreatePanel(ToggleBarsButton2,  TukuiDB.Scale(14), BarBG:GetHeight() / 2 - TukuiDB.Scale(1.5), "BOTTOMLEFT", BarBG, "BOTTOMRIGHT", TukuiDB.Scale(3), 0)
--ToggleBarsButton2:EnableMouse(true)
ToggleBarsButton2:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(0,0.8,1,1) end)
ToggleBarsButton2:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
ToggleBarsButton2:SetFrameLevel(2)
TukuiDB.CreateShadow(ToggleBarsButton2)
Text1 = ToggleBarsButton2:CreateFontString(nil, "LOW")
Text1:SetFont(TukuiCF.media.font, 12)
Text1:SetPoint("CENTER", ToggleBarsButton2, 0, 0)
Text1:SetText("v")
	
-- Hydra was in your files, savin' your variables
local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
function frame:OnEvent(event)
	if event == "ADDON_LOADED" then
		if Bottombars == nil then
			Bars = 2
			Bottombars = 1
		end
		if Bottombars then
			Bars = Bottombars
		else
			Bars = 2
		end
	elseif event == "PLAYER_LOGOUT" then
		Bottombars = Bars
	end
end
frame:SetScript("OnEvent", frame.OnEvent)

-- sizing/hiding (don't touch anything)
local BarUpdate = CreateFrame("Frame")
local function UpdateBars(self)
	if InCombatLockdown() then
		ToggleBarsButton1:EnableMouse(false)
		ToggleBarsButton2:EnableMouse(false)
	else
		ToggleBarsButton1:EnableMouse(true)
		ToggleBarsButton2:EnableMouse(true)
	end

	ToggleBarsButton1:SetHeight(BarBG:GetHeight() / 2 - TukuiDB.Scale(1.5))
	ToggleBarsButton2:SetHeight(BarBG:GetHeight() / 2 - TukuiDB.Scale(1.5))
	
	if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
		if Bars == 2 then
			BarBG:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
			Bar1:Show(); Bar2:Show()
		elseif Bars == 1 then
			BarBG:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
			Bar1:Show(); Bar2:Hide()	
		elseif Bars == 0 then
			BarBG:Hide(); Bar1:Hide(); Bar2:Hide()
		end
	else
		if Bars == 2 then
			BarBG:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
			Bar1:Show(); Bar2:Show(); Bar3:Show(); Bar5:Show()
		elseif Bars == 1 then
			BarBG:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
			Bar1:Show(); Bar2:Show(); Bar3:Hide(); Bar5:Hide()
		elseif Bars == 0 then
			BarBG:Hide(); Bar1:Hide(); Bar2:Hide(); Bar3:Hide(); Bar5:Hide()
		end
	end
	
	if TukuiBottomBarFrame:IsVisible() then
		ToggleBarsButton1:Show(); ToggleBarsButton2:Show()--; ToggleRBarsButton1:Show(); ToggleRBarsButton2:Show()
		ToggleBarsButton1:SetAlpha(1); ToggleBarsButton2:SetAlpha(1)--; ToggleRBarsButton1:SetAlpha(1); ToggleRBarsButton2:SetAlpha(1)
	else
		ToggleBarsButton1:Hide(); ToggleBarsButton2:Hide()--; ToggleRBarsButton1:Hide(); ToggleRBarsButton2:Hide()
		ToggleBarsButton1:SetAlpha(0); ToggleBarsButton2:SetAlpha(0)--; ToggleRBarsButton1:SetAlpha(0); ToggleRBarsButton2:SetAlpha(0)
	end
	
	-- set limits
	if Bars == 0 then
		ToggleBarsButton2:Hide(); ToggleBarsButton1:SetHeight(BarBG:GetHeight())
		ToggleBarsButton1:ClearAllPoints(); ToggleBarsButton1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(10))
		ToggleBarsButton1:SetSize(TukuiDB.Scale(70), TukuiDB.Scale(10))
	else
		ToggleBarsButton2:Show(); ToggleBarsButton1:SetHeight(BarBG:GetHeight() / 2 - TukuiDB.Scale(1.5))
		ToggleBarsButton1:ClearAllPoints(); ToggleBarsButton1:SetPoint("TOPLEFT", BarBG, "TOPRIGHT", TukuiDB.Scale(3), 0)
		ToggleBarsButton1:SetSize(BarBG:GetHeight() / 2 - TukuiDB.Scale(1.5), TukuiDB.Scale(14))
		ToggleBarsButton1:SetWidth(TukuiDB.Scale(14)); ToggleBarsButton2:SetWidth(TukuiDB.Scale(14))
	end
	
	if Bars == 2 then
		ToggleBarsButton1:Hide(); ToggleBarsButton2:SetHeight(BarBG:GetHeight())
	else
		ToggleBarsButton1:Show(); ToggleBarsButton1:SetHeight(BarBG:GetHeight() / 2 - TukuiDB.Scale(1)); ToggleBarsButton2:SetHeight(BarBG:GetHeight() / 2 - TukuiDB.Scale(1))
	end
end
BarUpdate:SetScript("OnUpdate", UpdateBars)

ToggleBarsButton1:SetScript("OnMouseUp", function(self) Bars = Bars + 1 if not BarBG:IsShown() then BarBG:Show() end end)
ToggleBarsButton2:SetScript("OnMouseUp", function(self) Bars = Bars - 1 end)