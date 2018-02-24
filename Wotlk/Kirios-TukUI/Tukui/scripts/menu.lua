 -- By Foof & Hydra at Tukui.org
-- Config variables
font = TukuiCF.media.font            -- Font to be used for button tMenuText
fontsize = 12                        -- Size of font for button tMenuText
buttonwidth = TukuiDB.Scale(100)     -- Width of menu buttons
buttonheight = TukuiDB.Scale(20)     -- Height of menu buttons
classcolor = false                   -- Class color buttons
hovercolor = {0,.8,1,1}              -- Color of buttons on mouse-over (if classcolor is false)

local addons = {
	["Recount"] = function()
		ToggleFrame(Recount.MainWindow)
		Recount.RefreshMainWindow()
	end,
	
	["Skada"] = function()
		Skada:ToggleWindow()
	end,
	
	["AtlasLoot"] = function()
		ToggleFrame(AtlasLootDefaultFrame)
	end,
	
	["Omen"] = function()
		ToggleFrame(Omen.Anchor)
	end,
	
	["DXE"] = function()
		_G.DXE:ToggleConfig()
	end,
	
	["DBM-Core"] = function()
		DBM:LoadGUI()
	end,
	
	["TinyDPS"] = function()
		ToggleFrame(tdpsFrame)
	end,
	
	["Tukui_ConfigUI"] = function()
		if not TukuiConfigUI or not TukuiConfigUI:IsShown() then
			CreateTukuiConfigUI()
		else
			TukuiConfigUI:Hide()
		end
	end,
}

local MenuBG = CreateFrame("Frame", "MenuBackground", UIParent)
TukuiDB.CreatePanel(MenuBG, buttonwidth + TukuiDB.Scale(6), buttonheight * 5 + TukuiDB.Scale(18), "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-10))
MenuBG:SetFrameLevel(0)
TukuiDB.CreateShadow(MenuBG)
MenuBG:Hide()
 
local AddonBG = CreateFrame("Frame", "AddOnBackground", UIParent)
TukuiDB.CreatePanel(AddonBG, buttonwidth + TukuiDB.Scale(6), 1, "TOP", MenuBG, "TOP", 0, 0)
AddonBG:SetFrameLevel(0)
TukuiDB.CreateShadow(AddonBG)
AddonBG:Hide()

-- color sh*t
if classcolor then
	local classcolor = RAID_CLASS_COLORS[TukuiDB.myclass]
	hovercolor = {classcolor.r,classcolor.g,classcolor.b,1}
end

menu = CreateFrame("Button", "Menu", MenuBG) -- Main buttons
for i = 1, 5 do
	menu[i] = CreateFrame("Button", "Menu"..i, MenuBG)
	TukuiDB.CreatePanel(menu[i], buttonwidth, buttonheight, "BOTTOM", MenuBG, "BOTTOM", 0, TukuiDB.Scale(3))
	if i == 1 then
		menu[i]:SetPoint("BOTTOM", MenuBG, "BOTTOM", 0, TukuiDB.Scale(3))
	else
		menu[i]:SetPoint("BOTTOM", menu[i-1], "TOP", 0, TukuiDB.Scale(3))
	end
	menu[i]:EnableMouse(true)
	menu[i]:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hovercolor)) end)
	menu[i]:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
	menu[i]:RegisterForClicks("AnyUp")
	tMenuText = menu[i]:CreateFontString(nil, "LOW")
	tMenuText:SetFont(font, fontsize)
	tMenuText:SetPoint("CENTER", menu[i], 0, 0)
 
	if i == 1 then -- KeyRing
		tMenuText:SetText("Keyring")
		menu[i]:SetScript("OnMouseUp", function() ToggleKeyRing() end)
	elseif i == 2 then -- Reload UI
		tMenuText:SetText("Reload UI")
		menu[i]:SetScript("OnClick", function() ReloadUI() end)
	elseif i == 3 then -- Calendar
		tMenuText:SetText("Calendar")
		menu[i]:SetScript("OnMouseUp", function() ToggleCalendar() end)
	elseif i == 4 then -- AddOns
		tMenuText:SetText("Addons")
		menu[i]:SetScript("OnMouseUp", function() ToggleFrame(AddOnBackground); ToggleFrame(MenuBackground); end)
	elseif i == 5 then -- Close Menu
		tMenuText:SetText("Close Menu")
		AnimGroup(MenuBackground, 0, TukuiDB.Scale(150), 0.4)
		AnimGroup(AddOnBackground, 0, TukuiDB.Scale(150), 0.4)
		menu[i]:SetScript("OnMouseUp", function()
			SlideOut(MenuBackground)
			if AddOnBackground:IsVisible() then
				SlideOut(AddOnBackground)
			end
		end)
	end
end

local returnbutton = CreateFrame("Button", "AddonMenuReturnButton", AddonBG)
TukuiDB.CreatePanel(returnbutton, buttonwidth, buttonheight, "TOP", AddonBG, "TOP", 0, TukuiDB.Scale(-3))
returnbutton:EnableMouse(true)
returnbutton:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hovercolor)) end)
returnbutton:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
returnbutton:RegisterForClicks("AnyUp")
returnbutton:SetFrameLevel(1)
tMenuText2 = returnbutton:CreateFontString(nil, "LOW")
tMenuText2:SetFont(font, fontsize)
tMenuText2:SetPoint("CENTER", returnbutton, 0, 0)
tMenuText2:SetText("Addons List")
returnbutton:SetScript("OnMouseUp", function() ToggleFrame(AddOnBackground); ToggleFrame(MenuBackground); end)

addonmenu = CreateFrame("Button", "AddonMenu", AddonBG)	-- AddOn page buttons
addonmenu[1] = returnbutton

for key, value in pairs(addons) do
	if IsAddOnLoaded(key) then
		local menuitem = CreateFrame("Button", "AddonMenu"..(#addonmenu + 1), AddonBG)
		TukuiDB.CreatePanel(menuitem, buttonwidth, buttonheight, "TOP", addonmenu[#addonmenu], "BOTTOM", 0, TukuiDB.Scale(-3))
		menuitem:EnableMouse(true)
		menuitem:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hovercolor)) end)
		menuitem:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(TukuiCF.media.bordercolor)) end)
		menuitem:RegisterForClicks("AnyUp")
		menuitem:SetFrameLevel(1)
		tMenuText3 = menuitem:CreateFontString(nil, "LOW")
		tMenuText3:SetFont(font, fontsize)
		tMenuText3:SetPoint("CENTER", menuitem, 0, 0)
		tMenuText3:SetText(key)
		menuitem:SetScript("OnMouseUp", value)
		addonmenu[#addonmenu + 1] = menuitem
	end
end

AddonBG:SetHeight((#addonmenu * buttonheight) + ((#addonmenu + 1) * 3))

-- MENU BUTTON
MenuText = TukuiTabLeft:CreateFontString(nil, "LOW")
-- MenuText:SetFont(TukuiCF.media.font, 11) YAN
MenuText:SetFont(TukuiCF.media.minimal, 10, "OUTLINE") 
MenuText:SetPoint("RIGHT", TukuiTabLeft, -20, 0)
MenuText:SetShadowColor(0, 0, 0)
MenuText:SetShadowOffset(1.25, -1.25)
MenuText:SetText("Меню")
MenuText:SetTextColor(unpack(TukuiCF.chat.tabcolor))

local MenuButton = CreateFrame("Frame", "TukuiMenuButton", TukuiTabLeft)
TukuiDB.CreatePanel(MenuButton, 1, 16, "RIGHT", TukuiTabLeft, "RIGHT", -15, 0)
MenuButton:SetWidth(MenuText:GetWidth() + 12)
MenuButton:SetAlpha(0)
MenuButton:EnableMouse(true)
MenuButton:HookScript("OnEnter", function(self) MenuText:SetTextColor(unpack(TukuiCF.chat.tabmouseover)) end)
MenuButton:HookScript("OnLeave", function(self) MenuText:SetTextColor(unpack(TukuiCF.chat.tabcolor)) end)

AnimGroup(MenuBackground, 0, TukuiDB.Scale(150), 0.4)
AnimGroup(AddOnBackground, 0, TukuiDB.Scale(150), 0.4)

-- HIDE/SHOW ZONE & MENU
MenuButton:SetScript("OnMouseDown", function()
	if not MenuBackground:IsVisible() then
		if not AddOnBackground:IsVisible() then
			SlideIn(MenuBackground)
		end
	else
		SlideOut(MenuBackground)
	end
	
	if AddOnBackground:IsVisible() then
		SlideOut(AddOnBackground)
		if TukuiCF.datatext.topzone then
			SlideIn(ZoneBackground)
			SlideIn(ZoneToggle)
		end
	end
	
	if MenuBackground:IsVisible() and (TukuiCF.datatext.topzone and ZoneBackground:IsVisible()) then
		SlideOut(ZoneBackground)
		SlideOut(ZoneToggle)
	end
	
	if MenuBackground:IsVisible() and (TukuiCF.datatext.topzone and not ZoneBackground:IsVisible()) then
		SlideIn(ZoneBackground)
		SlideIn(ZoneToggle)
	end
end)