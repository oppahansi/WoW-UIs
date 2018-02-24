if not TukuiCF.actionbar.ingame then return end
local Bars = 1
local BarBG = TukuiActionBarBackgroundRight
local Bar3 = TukuiBar3
local Bar4 = TukuiBar4
local Bar5 = TukuiBar5

-- buttons to set bars
local ToggleRBarsButton1 = CreateFrame("Button", "ToggleRBarsButton1", UIParent)
TukuiDB.CreatePanel(ToggleRBarsButton1, BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5), TukuiDB.Scale(14), "TOPLEFT", BarBG, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
--ToggleRBarsButton1:EnableMouse(true)
ToggleRBarsButton1:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(0,0.8,1,1) end)
ToggleRBarsButton1:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
TukuiDB.CreateShadow(ToggleRBarsButton1)
Text1 = ToggleRBarsButton1:CreateFontString(nil, "LOW")
Text1:SetFont(TukuiCF.media.font, 12)
Text1:SetPoint("CENTER", ToggleRBarsButton1, 0, 0)
Text1:SetText("<")

local ToggleRBarsButton2 = CreateFrame("Button", "ToggleRBarsButton2", UIParent)
TukuiDB.CreatePanel(ToggleRBarsButton2, BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5), TukuiDB.Scale(14), "TOPRIGHT", BarBG, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
--ToggleRBarsButton2:EnableMouse(true)
ToggleRBarsButton2:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(0,0.8,1,1) end)
ToggleRBarsButton2:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
TukuiDB.CreateShadow(ToggleRBarsButton2)
Text1 = ToggleRBarsButton2:CreateFontString(nil, "LOW")
Text1:SetFont(TukuiCF.media.font, 12)
Text1:SetPoint("CENTER", ToggleRBarsButton2, 0, 0)
Text1:SetText(">")

local bbframe = CreateFrame("Frame", "TukuiBottomBarFrame", UIParent)
TukuiDB.CreatePanel(bbframe, 1, 1, "TOP", UIParent, "TOP", 0, 10)
bbframe:Hide()

--Actionbar Config Button
ABConfigText = TukuiTabRight:CreateFontString(nil, "LOW")
--- ABConfigText:SetFont(TukuiCF.media.font, 11) --- YAN
ABConfigText:SetFont(TukuiCF.media.minimal, 10, "OUTLINE")
ABConfigText:SetPoint("CENTER", TukuiTabRight, 0, 0)
ABConfigText:SetShadowColor(0, 0, 0)
ABConfigText:SetShadowOffset(1.25, -1.25)
ABConfigText:SetText("Action Bars")
ABConfigText:SetTextColor(unpack(TukuiCF.chat.tabcolor))

local ABConfigButton = CreateFrame("Frame", "TukuiABConfigButton", TukuiTabRight)
TukuiDB.CreatePanel(ABConfigButton, 1, 16, "CENTER", TukuiTabRight, "CENTER", 0, 0)
ABConfigButton:SetWidth(ABConfigText:GetWidth() + 12)
ABConfigButton:SetAlpha(0)
ABConfigButton:EnableMouse(true)
ABConfigButton:HookScript("OnEnter", function(self) ABConfigText:SetTextColor(unpack(TukuiCF.chat.tabmouseover)) end)
ABConfigButton:HookScript("OnLeave", function(self) ABConfigText:SetTextColor(unpack(TukuiCF.chat.tabcolor)) end)
ABConfigButton:SetScript("OnMouseDown", function()
	ToggleFrame(TukuiBottomBarFrame)
end)

-- Hydra was in your files, savin' your variables
local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
function frame:OnEvent(event)
	if event == "ADDON_LOADED" then
		if Rightbars == nil then
			Bars = 1
			Rightbars = 1
		end
		if Rightbars then
			Bars = Rightbars
		else
			Bars = 1
		end
	elseif event == "PLAYER_LOGOUT" then
		Rightbars = Bars
	end
end
frame:SetScript("OnEvent", frame.OnEvent)

-- sizing/hiding (don't touch anything)
local BarUpdate = CreateFrame("Frame")
function UpdateRightBars()
	if InCombatLockdown() then
		ToggleRBarsButton1:EnableMouse(false)
		ToggleRBarsButton2:EnableMouse(false)
	else
		ToggleRBarsButton1:EnableMouse(true)
		ToggleRBarsButton2:EnableMouse(true)
	end

ToggleRBarsButton1:SetWidth(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5))
ToggleRBarsButton2:SetWidth(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5))
	if TukuiDB.lowversion or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
		if Bars == 3 then
			BarBG:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
			Bar3:Show(); Bar4:Show(); Bar5:Show()
		elseif Bars == 2 then
			BarBG:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
			Bar3:Hide(); Bar4:Show(); Bar5:Show()
		elseif Bars == 1 then
			BarBG:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
			Bar4:Show(); Bar3:Hide(); Bar5:Hide()
		elseif Bars == 0 then
			BarBG:Hide(); Bar3:Hide(); Bar4:Hide(); Bar5:Hide()
		end
		
		if TukuiBottomBarFrame:IsVisible() then
			ToggleRBarsButton1:Show(); ToggleRBarsButton2:Show()
			ToggleRBarsButton1:SetAlpha(1); ToggleRBarsButton2:SetAlpha(1)
		else
			ToggleRBarsButton1:Hide(); ToggleRBarsButton2:Hide()
			ToggleRBarsButton1:SetAlpha(0); ToggleRBarsButton2:SetAlpha(0)
		end
		
		-- set limits
		if Bars == 0 then
			ToggleRBarsButton2:Hide(); ToggleRBarsButton1:SetWidth(BarBG:GetWidth())
			ToggleRBarsButton1:ClearAllPoints(); ToggleRBarsButton1:SetPoint("RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-10), 0)
			ToggleRBarsButton1:SetSize(TukuiDB.Scale(20), TukuiDB.Scale(70))
		else
			ToggleRBarsButton2:Show(); ToggleRBarsButton1:SetWidth(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5))
			ToggleRBarsButton1:ClearAllPoints(); ToggleRBarsButton1:SetPoint("TOPLEFT", BarBG, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
			ToggleRBarsButton1:SetSize(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5), TukuiDB.Scale(14))
		end
		
		if Bars == 3 then
			ToggleRBarsButton1:Hide(); ToggleRBarsButton2:SetWidth(BarBG:GetWidth())
		else
			ToggleRBarsButton1:Show(); ToggleRBarsButton2:SetWidth(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5))
		end
	else
		if Bars == 1 then
			BarBG:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2)); Bar4:Show()
		elseif Bars == 0 then
			BarBG:Hide(); Bar4:Hide()
		end
		
		if TukuiBottomBarFrame:IsVisible() then
			ToggleRBarsButton1:Show(); ToggleRBarsButton2:Show()
			ToggleRBarsButton1:SetAlpha(1); ToggleRBarsButton2:SetAlpha(1)
		else
			ToggleRBarsButton1:Hide(); ToggleRBarsButton2:Hide()
			ToggleRBarsButton1:SetAlpha(0); ToggleRBarsButton2:SetAlpha(0)
		end
		
		-- set limits
		if Bars == 0 then
			ToggleRBarsButton2:Hide(); ToggleRBarsButton1:SetWidth(BarBG:GetWidth())
			ToggleRBarsButton1:ClearAllPoints(); ToggleRBarsButton1:SetPoint("RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-10), 0)
			ToggleRBarsButton1:SetSize(TukuiDB.Scale(20), TukuiDB.Scale(70))
		else
			ToggleRBarsButton2:Show(); ToggleRBarsButton1:SetWidth(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5))
			ToggleRBarsButton1:ClearAllPoints(); ToggleRBarsButton1:SetPoint("TOPLEFT", BarBG, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
			ToggleRBarsButton1:SetSize(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5), TukuiDB.Scale(14))
		end
		
		if Bars == 1 then
			ToggleRBarsButton1:Hide(); ToggleRBarsButton2:SetWidth(BarBG:GetWidth())
		else
			ToggleRBarsButton1:Show(); ToggleRBarsButton2:SetWidth(BarBG:GetWidth() / 2 - TukuiDB.Scale(1.5))
		end
	end
end
BarUpdate:SetScript("OnUpdate", UpdateRightBars)

ToggleRBarsButton1:SetScript("OnMouseUp", function(self) Bars = Bars + 1 if not BarBG:IsShown() then BarBG:Show() end end)
ToggleRBarsButton2:SetScript("OnMouseUp", function(self) Bars = Bars - 1 end)