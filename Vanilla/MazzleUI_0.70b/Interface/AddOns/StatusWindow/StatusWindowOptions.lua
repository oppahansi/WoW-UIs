--
-- Status Window Options
-- 2005 Satrina@Stormrage
--
StatusWindowOptions = {}

function StatusWindowOptions:Initialise()
	if SWVar[StatusWindow.player].addonmenu then
		AddonMenu:AddMenuItem(StatusWindow.strings.MENU, StatusWindowOptions.Open, "Satrina Addons")
	end
	
	StatusWindowVersionString:SetText(string.format("%s%.2f|r", StatusWindow.strings.VERSION, StatusWindow.version))
	StatusWindowPanesString:SetText("Panes")
	StatusWindowWindowsString:SetText("Windows")
	
	StatusWindowUIScaleCheckButtonText:SetText(StatusWindow.strings.UISCALE)
	StatusWindowBackgroundCheckButtonText:SetText(StatusWindow.strings.BACKGROUND)
	StatusWindowBorderCheckButtonText:SetText(StatusWindow.strings.BORDER)
	StatusWindowAlignmentCheckButtonText:SetText(StatusWindow.strings.HSTACK)
	StatusWindowAddonMenuCheckButtonText:SetText(StatusWindow.strings.ADDONMENU)
	StatusWindowModuleConfigDropDownLabel:SetText(StatusWindow.strings.CONFIG)
	
	StatusWindowAddonMenuCheckButton:SetChecked(SWVar[StatusWindow.player].addonmenu)

	OptionsFrame_EnableSlider(StatusWindowScaleSlider)
	StatusWindowScaleSliderText:SetText(StatusWindow.strings.SCALE)
	StatusWindowScaleSliderLow:SetText("0.5")
	StatusWindowScaleSliderHigh:SetText("2.0")
	StatusWindowScaleSlider:SetMinMaxValues(0.5, 2.0)
	StatusWindowScaleSlider:SetValueStep(0.01)
	StatusWindowScaleSlider:SetValue(1)

	OptionsFrame_EnableSlider(StatusWindowWidthSlider)
	StatusWindowWidthSliderText:SetText(StatusWindow.strings.WIDTH)
	StatusWindowWidthSliderLow:SetText("50")
	StatusWindowWidthSliderHigh:SetText("200")
	StatusWindowWidthSlider:SetMinMaxValues(50, 200)
	StatusWindowWidthSlider:SetValueStep(0.2)

	UIDropDownMenu_Initialize(StatusWindowModuleConfigDropDown, StatusWindowOptions.ModuleConfigDropDown_Initialise)
	StatusWindowOptions:InitialiseOptionButtons()
end

function StatusWindowOptions:WindowButtons()
	local button, str
	for i=1,10 do
		button = getglobal("StatusWindowWindowButton"..i)
		if (SWVar[StatusWindow.player].windows[i].count > 0) then
			button:SetTextColor(1.0,1.0,1.0)
		else
			button:SetTextColor(0.3,0.3,0.3)
		end
		button:SetText(StatusWindow.strings.WINDOW..i)
	end
end

function StatusWindowOptions:Open()
	StatusWindowOptions:SetWindow(1)
	StatusWindowOptions:WindowButtons()
	StatusWindowOptionsFrame:Show()
end

function StatusWindowOptions:Close()
	StatusWindowOptions.currentWindow = nil
	StatusWindowOptionsFrame:Hide()
end


function StatusWindowOptions:SetWindow(Window)
	StatusWindowOptions.currentWindow = Window
	StatusWindowCurrentWindow:SetText("Window "..Window)
	StatusWindowBorderCheckButton:SetChecked(SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].border)
	StatusWindowBackgroundCheckButton:SetChecked(SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].background)
	StatusWindowAlignmentCheckButton:SetChecked(SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].horizontal)
	StatusWindowWidthSlider:SetValue(SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].width)
	StatusWindowOptions:DoScale(StatusWindowOptions.currentWindow)
	StatusWindowOptions:SetOptionButtons()
end

function StatusWindowOptions:InitialiseOptionButtons()
	local button
	for i=1,20 do
		button = StatusWindow.panes[i].button
		button.text:SetText(StatusWindow.panes[i].module)
		button.home = "StatusWindowButtons"..ceil(i/10).."Button"..(math.mod(i-1, 10) + 1)
	end
end

function StatusWindowOptions:SetOptionButtons()
	local button, slot
	
	for i=1,10 do
		slot = getglobal("StatusWindowButtonGroupButton"..i)
		slot.button = nil
	end
	
	for i=1,20 do
		button = StatusWindow.panes[i].button

		if (SWVar[StatusWindow.player].windows[0].panes[i] > 0) then
			StatusWindowOptions:SeatButton(getglobal(button.home), button)
			button:Show()
		else	
			for j=1,10 do
				for index,buttonNum in SWVar[StatusWindow.player].windows[j].panes do
					if (buttonNum == i) then
						if (j == StatusWindowOptions.currentWindow) then
							StatusWindowOptions:SeatButton(getglobal("StatusWindowButtonGroupButton"..index), button)
							button:Show()
						else
							button:Hide()
						end
						break
					end
				end
			end
		end
	end
	StatusWindow:InitWindows()
	StatusWindowOptions:WindowButtons()
end

function StatusWindowOptions:MoveButton(s1, b0)
	-- No move, just reseat
	if (s1 == b0.slot) then
		StatusWindowOptions:SeatButton(s1, b0)
		return
	end

	s0 = b0.slot
	b1 = s1.button
	-- Right now, s0 contains b0 and s1 contains b1

	if b1 then																				-- Swapping two buttons
		if (s0:GetName() == b0.home) then
			-- Swapping a button on the home row with one in the window
			s0.button = nil
			s0 = getglobal(b1.home)
			SWVar[StatusWindow.player].windows[0].panes[b0:GetID()] = 0
			SWVar[StatusWindow.player].windows[0].panes[b1:GetID()] = b1:GetID()
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s1:GetID()] = b0:GetID()
		elseif (string.find(s1:GetName(), "StatusWindowButtons")) then
			-- Swapping a button in the window with one on the home row	
			s1.button = nil
			s1 = getglobal(b0.home)
			SWVar[StatusWindow.player].windows[0].panes[b0:GetID()] = b0:GetID()
			SWVar[StatusWindow.player].windows[0].panes[b1:GetID()] = 0
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s0:GetID()] = b1:GetID()
		else
			-- Swapping two buttons in the window
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s0:GetID()] = b1:GetID()
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s1:GetID()] = b0:GetID()
		end
	else																							-- Moving a button
		if (s1:GetName() == b0.home) then
			-- Moving to home slot
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s0:GetID()] = 0
			SWVar[StatusWindow.player].windows[0].panes[b0:GetID()] = b0:GetID()
		elseif (s0:GetName() == b0.home) then
			-- Moving from home slot
			SWVar[StatusWindow.player].windows[0].panes[b0:GetID()] = 0
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s1:GetID()] = b0:GetID()
		else
			-- Moving to a different slot in the window
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s0:GetID()] = 0
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].panes[s1:GetID()] = b0:GetID()
		end
	end
	StatusWindowOptions:SeatButton(s1, b0)
	StatusWindowOptions:SeatButton(s0, b1)
	StatusWindow:InitWindows()
	StatusWindowOptions:WindowButtons()
end

function StatusWindowOptions:UIScale()
	SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].scale = not this:GetChecked() and 1.0
	StatusWindowOptions:DoScale(StatusWindowOptions.currentWindow)
end 

function StatusWindowOptions:SetBorder()
	SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].border = this:GetChecked()
	StatusWindow:InitWindow(StatusWindowOptions.currentWindow)
end 

function StatusWindowOptions:SetAlignment()
	SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].horizontal = this:GetChecked()
	StatusWindow:InitWindow(StatusWindowOptions.currentWindow)
end 

function StatusWindowOptions:SetBackground()
	SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].background = this:GetChecked()
	StatusWindow:InitWindow(StatusWindowOptions.currentWindow)
end 

function StatusWindowOptions:OnUpdate(elapsed)
	if (StatusWindow.optionsElapsed > 0.5) then
		StatusWindow.optionsElapsed = 0

		if (StatusWindowWidthSlider:GetValue() ~= SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].width) then
			SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].width = StatusWindowWidthSlider:GetValue()
			StatusWindow:InitWindow(StatusWindowOptions.currentWindow)
		end
	
		if SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].scale then
			if (StatusWindowScaleSlider:GetValue() ~= SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].scale) then
				SWVar[StatusWindow.player].windows[StatusWindowOptions.currentWindow].scale = StatusWindowScaleSlider:GetValue()
				StatusWindow:InitWindow(StatusWindowOptions.currentWindow)
			end
		end
	else
		StatusWindow.optionsElapsed = StatusWindow.optionsElapsed + elapsed
	end
end

function StatusWindowOptions:DoScale(windowID)
	if SWVar[StatusWindow.player].windows[windowID].scale then
		StatusWindowUIScaleCheckButton:SetChecked(false)
		OptionsFrame_EnableSlider(StatusWindowScaleSlider)
		StatusWindowScaleSlider:SetValue(SWVar[StatusWindow.player].windows[windowID].scale)
	else
		StatusWindowUIScaleCheckButton:SetChecked(true)
		OptionsFrame_DisableSlider(StatusWindowScaleSlider)
	end
	StatusWindow:ScaleWindow(windowID)
end


function StatusWindowOptions:ModuleConfigDropDown_Initialise()
	for name,module in StatusWindow.modules do
		if module.Configure then
			info = {}
			info.text = name
			info.value = module
			info.func = StatusWindowOptions.ModuleConfigDropDown_OnClick
			UIDropDownMenu_AddButton(info)
		end
	end
end

function StatusWindowOptions:ModuleConfigDropDown_OnClick()
	this.value.configFrame:SetPoint("BOTTOMRIGHT", "StatusWindowOptionsFrame", "BOTTOMLEFT", -3, 0)
	this.value:Configure()
end

function StatusWindowOptions:ModuleDropDown_Initialise()
	StatusWindow.currentButton = this:GetID()
	for name,module in StatusWindow.modules do
		info = {}
		info.text = name
		info.value = name
		info.func = StatusWindowOptions.ModuleDropDown_OnClick
		if (StatusWindow.panes[StatusWindow.currentButton].module == name) then
			info.checked = true
			UIDropDownMenu_SetText(name, StatusWindowModuleDropDown)
		end
		UIDropDownMenu_AddButton(info)
	end
end

function StatusWindowOptions:ModuleDropDown_OnClick()
	SWVar[StatusWindow.player].panes[StatusWindow.currentButton] = this.value
	StatusWindow:ModuleAttachPane(this.value, StatusWindow.currentButton)
	StatusWindow.panes[StatusWindow.currentButton].button.text:SetText(this.value)
end

function StatusWindow:AddonMenu()
	SWVar[StatusWindow.player].addonmenu = this:GetChecked()
	if not SWVar[StatusWindow.player].addonmenu then
		DEFAULT_CHAT_FRAME:AddMessage(StatusWindow.strings.ADDONMENU_DISABLE)
	end
end 

--
-- Button Movement
--
function StatusWindowOptions:SeatButton(slot, button)
	slot.button = button
	if button then
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", slot:GetName(), "TOPLEFT")
		button.slot = slot
		slot.button = button
	end
end

function StatusWindowOptions:OnButtonDragStart()
	local cursorX, cursorY = GetCursorPosition()
	this:ClearAllPoints()
	StatusWindow.moving = 1
	this:StartMoving()
end

function StatusWindowOptions:OnButtonDragStop()
	this:StopMovingOrSizing()
	if StatusWindow.target then
		-- Hovering over a slot that isn't where we started from and doesn't have a button in it to swap
		if string.find(StatusWindow.target:GetName(), "StatusWindowButtons") and not StatusWindow.target.button then
			local id = this:GetID()
			StatusWindow.target = getglobal(this.home)
		end
		StatusWindowOptions:MoveButton(StatusWindow.target, this)
	else
		-- Back to where you started
		this:SetPoint("TOPLEFT", this.slot, "TOPLEFT", 0, 0)
	end
end

function StatusWindowOptions:Help()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT", 5, 0);
	GameTooltip:AddLine(StatusWindow.strings.HELP1, 1.00, 0.86, 0.00);
	GameTooltip:AddLine(StatusWindow.strings.HELP2, 1.00, 0.86, 0.00);
	GameTooltip:AddLine(" ", 1.00, 0.86, 0.00);
	GameTooltip:AddLine(StatusWindow.strings.HELP3, 1.00, 0.86, 0.00);
	GameTooltip:AddLine(StatusWindow.strings.HELP4, 1.00, 0.86, 0.00);
	GameTooltip:AddLine(StatusWindow.strings.HELP5, 1.00, 0.86, 0.00);
	GameTooltip:AddLine(StatusWindow.strings.HELP6, 1.00, 0.86, 0.00);
	GameTooltip:AddLine(StatusWindow.strings.HELP7, 1.00, 0.86, 0.00);
	GameTooltip:Show();
end
