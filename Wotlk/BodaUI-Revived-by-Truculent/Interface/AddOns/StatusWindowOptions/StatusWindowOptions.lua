--
-- Status Window Options
-- 2005-2008 Satrina@Stormrage
--

local SML = LibStub:GetLibrary('LibSharedMedia-3.0')
local ColourFrame = LibStub:GetLibrary('LibColourFrame-1.0')
local ScrollingDropDown = LibStub:GetLibrary('LibScrollingDropDown-1.0')

local ColourButton_Enable = function(button, enable)
  if enable then
    button:Enable()
    button.label:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
    button.highlight:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
  else
    button:Disable()
    button.label:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
    button.highlight:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
  end
end

local tableaddr = function(t)
  return string.match(tostring(t), "table: (.+)")
end

local _sw = StatusWindow

StatusWindowOptions = {
  version = 2.2,
  minor = 0,
}

function StatusWindowOptions:Initialise()
	UIPanelWindows["SWOptions"] =		{ area = "center",	pushable = 0,	whileDead = 1 }

	if _sw._beta then
		self.versionStr = string.format("%.01f beta %d", self.version, self.minor)
	else
		self.versionStr = string.format("%.01f.%d", self.version, self.minor)
	end
  SWOptionsVersionString:SetFormattedText(_sw.strings.VERSION, self.versionStr)

	SWOptionsWindowDropDown:Init(self.DropDownCallback, self.strings.WINDOW)
	SWOptionsNewButton:SetText(self.strings.NEWWINDOW)
	SWOptionsRemoveButton:SetText(self.strings.REMOVEWINDOW)
	SWOptionsResetButton:SetText(self.strings.RESETBUTTON)
  SWOptionsCopyProfileButtonLabel:SetText(self.strings.COPYPROFILE)
  
	-- Window
	SWOptionsCurrentWindowBackgroundDropDown:Init(self.DropDownCallback, self.strings.BACKGROUND)
	SWOptionsCurrentWindowBorderDropDown:Init(self.DropDownCallback, self.strings.BORDER)
	SWOptionsCurrentWindowFontDropDown:Init(self.DropDownCallback, self.strings.FONT)

	SWOptionsCurrentWindowFrame:SetFormattedText(self.strings.FRAMES)
	SWOptionsCurrentWindowFrameUpButton:SetFormattedText(self.strings.UP)
	SWOptionsCurrentWindowFrameDownButton:SetFormattedText(self.strings.DOWN)
	SWOptionsCurrentWindowFrameAddButton:SetFormattedText(self.strings.ADD)
	SWOptionsCurrentWindowFrameRemoveButton:SetFormattedText(self.strings.REMOVE)
	SWOptionsCurrentWindowBorderColourLabel:SetFormattedText(self.strings.BORDERCOLOUR)
	SWOptionsCurrentWindowTextColourLabel:SetFormattedText(self.strings.TEXTCOLOUR)
	SWOptionsCurrentWindowBackgroundColourLabel:SetFormattedText(self.strings.BGCOLOUR)
	SWOptionsCurrentWindowScaleSliderLow:SetFormattedText("0.5")
	SWOptionsCurrentWindowScaleSliderHigh:SetFormattedText("2.0")
	SWOptionsCurrentWindowScaleSlider:SetMinMaxValues(0.5, 2.0)
	SWOptionsCurrentWindowScaleSlider:SetValueStep(0.1)
	SWOptionsCurrentWindowOpacitySliderLow:SetFormattedText("0.1")
	SWOptionsCurrentWindowOpacitySliderHigh:SetFormattedText("1.0")
	SWOptionsCurrentWindowOpacitySlider:SetMinMaxValues(0.1, 1.0)
	SWOptionsCurrentWindowOpacitySlider:SetValueStep(0.05)
  SWOptionsCurrentWindowUseWindowColourCheckButtonText:SetFormattedText(self.strings.USEWINDOWCOLOUR)
  
	SWOptionsCurrentWindowFontSizeSliderLow:SetFormattedText("6")
	SWOptionsCurrentWindowFontSizeSliderHigh:SetFormattedText("20")
	SWOptionsCurrentWindowFontSizeSlider:SetMinMaxValues(6, 20)
	SWOptionsCurrentWindowFontSizeSlider:SetValueStep(1)

	SWOptionsCurrentWindowBorderSizeSliderLow:SetFormattedText("1")
	SWOptionsCurrentWindowBorderSizeSliderHigh:SetFormattedText("32")
	SWOptionsCurrentWindowBorderSizeSlider:SetMinMaxValues(1, 32)
	SWOptionsCurrentWindowBorderSizeSlider:SetValueStep(1)

	-- Frame
	SWOptionsCurrentFrameWidthSliderLow:SetFormattedText("10")
	SWOptionsCurrentFrameWidthSliderHigh:SetFormattedText("150")
	SWOptionsCurrentFrameWidthSlider:SetMinMaxValues(10, 150)
	SWOptionsCurrentFrameWidthSlider:SetValueStep(1)

	SWOptionsCurrentFrameHeightSliderLow:SetFormattedText("10")
	SWOptionsCurrentFrameHeightSliderHigh:SetFormattedText("35")
	SWOptionsCurrentFrameHeightSlider:SetMinMaxValues(10, 30)
	SWOptionsCurrentFrameHeightSlider:SetValueStep(1)
	SWOptionsCurrentFramePaddingSliderLow:SetFormattedText("0")
	SWOptionsCurrentFramePaddingSliderHigh:SetFormattedText("50")
	SWOptionsCurrentFramePaddingSlider:SetMinMaxValues(0, 50)
	SWOptionsCurrentFramePaddingSlider:SetValueStep(1)
	SWOptionsCurrentFrameModuleDropDown:Init(self.DropDownCallback, self.strings.module)
	
  self:FontDropDown_Initialise()
  self:BackgroundDropDown_Initialise()
  self:BorderDropDown_Initialise()
  self:CopyProfileButton_Initialise()
	self:ModuleDropDown_Initialise()
  
  self.frameButtons = {}
	for i=1,10 do
		self.frameButtons[i] = getglobal("SWOptionsCurrentWindowFrameList"..i)
	end
	
	self:DisableFrameControls()
	self:DisableWindowControls()
	
  StaticPopupDialogs["SWResetProfile"] = {
    text = TEXT(StatusWindowOptions.strings.RESETPROFILE),
    button1 = TEXT(YES),
    button2 = TEXT(NO),
    OnAccept = StatusWindowOptions.ResetProfileCallback,
    timeout = 0,
    whileDead = 1
  }

	self.optionsElapsed = 0
end

function StatusWindowOptions.DropDownCallback()
  ScrollingDropDown:Open(this:GetParent())
end

function StatusWindowOptions:OnUpdate(elapsed)
end

function StatusWindowOptions:Open()
  _sw.showingOptions = true
	ShowUIPanel(SWOptions)
  self:WindowDropDown_Initialise()
	self:SelectWindow(1)
end


function StatusWindowOptions:Close()
	StatusWindowOptions.currentWindowIndex = nil
  self:CloseConfigFrames()
	HideUIPanel(SWOptions)
  _sw.showingOptions = false
	collectgarbage("step", 5000)
end

function StatusWindowOptions:CopyProfileButton_Initialise()
  SWOptionsCopyProfileButton.dropDownOptions = _sw:GetTable()
  SWOptionsCopyProfileButton.dropDownOptions.noSelection = true
  
	local info = _sw:GetTable()
	info.callback = self.CopyProfileButton_OnClick

	for k,v in pairs(SWVar) do
    if (type(v) == "table") and (k ~= _sw.player) then
      info.text		= k
      info.value	= k
      ScrollingDropDown:AddItem(SWOptionsCopyProfileButton, info)
    end
	end
  _sw:PutTable(info)
end

function StatusWindowOptions.CopyProfileButton_OnClick(item)
  _sw.copyingProfile = true
  _sw:PutTable(SWVar[_sw.player])
  SWVar[_sw.player] = StatusWindowOptions:CopyTable(SWVar[item.text])
  StatusWindowOptions:ResetAll()
  _sw.copyingProfile = false
end

function StatusWindowOptions:ResetProfile()
  StaticPopup_Show("SWResetProfile")
end

function StatusWindowOptions.ResetProfileCallback()
  _sw.copyingProfile = true
  _sw:PutTable(SWVar[_sw.player])
  _sw:NewPlayer()
  StatusWindowOptions:ResetAll()
  _sw.copyingProfile = false
end

function StatusWindowOptions:ResetAll()
  while (#_sw.windows > 0) do
    _sw:PutWindow(table.remove(_sw.windows))
  end
  while (#_sw.frames > 0) do
    _sw:PutFrame(table.remove(_sw.frames))
  end
	_sw._var = SWVar[_sw.player]
  _sw:InitWindows()
  StatusWindowOptions:WindowDropDown_Initialise()
  StatusWindowOptions:SelectWindow(1)
  StatusWindowOptions:SelectFrame(1)
end

function StatusWindowOptions:CopyTable(src)
	local dst = _sw:GetTable()
	for k,v in pairs(src) do
		if (type(v) == "table") and not v.IsObjectType then
			dst[k] = self:CopyTable(v)
		else
			dst[k] = v
		end
	end
	return dst
end
-- 
-- Windows
-- 

function StatusWindowOptions:WindowDropDown_Initialise()
	ScrollingDropDown:ClearItems(SWOptionsWindowDropDown)
  local info = StatusWindow:GetTable()
	info.callback = self.WindowDropDown_OnClick

	for k,v in pairs(_sw.windows) do
		info.text		= "Window "..k
		info.value	= k
		ScrollingDropDown:AddItem(SWOptionsWindowDropDown, info)
	end
  StatusWindow:PutTable(info)
end

function StatusWindowOptions.WindowDropDown_OnClick(item)
	StatusWindowOptions:SelectWindow(item.value)
end

function StatusWindowOptions:NewWindow()
	if not _sw._var.windows then
    StatusWindow:debug(2, "StatusWindow._var.windows was nil")
    _sw._var.windows = {}
  end
  local	index = #_sw._var.windows + 1
	_sw._var.windows[index] = {}
	_sw._var.windows[index].scale = 1
	StatusWindow:MakeWindow(index)
	local f = _sw.windows[index]
	f:ClearAllPoints()
	f:SetPoint("TOP", "SWOptions", "BOTTOM", 0, -20)
	self:WindowDropDown_Initialise()
  self:SelectWindow(index)
end

function StatusWindowOptions:RemoveWindow()
  self:SelectFrame(1)
	while (#self.currentWindow.frames > 0) do
		self:RemoveCurrentFrame()
	end

	for index,var in pairs(_sw._var.windows) do
    if (tableaddr(var) == tableaddr(self.currentWindow._var)) then
      local var = table.remove(_sw._var.windows, index)
      StatusWindow:PutTable(var)
      break
    end
  end
	StatusWindow:PutWindow(table.remove(_sw.windows, self.currentWindowIndex))
	
	for k,v in pairs(_sw.windows) do
		_sw.windows[k].index = k
		StatusWindow:UpdateSavedVars(_sw.windows[k])
	end
	self:WindowDropDown_Initialise()
	self:SelectWindow()
end

function StatusWindowOptions:SelectWindow(window)
  self.selectWindow = true
	if (#_sw.windows == 0) then
		self.currentWindowIndex = nil
	elseif window then
		if (window <= #_sw.windows) then
			self.currentWindowIndex = window
		else 
			self.currentWindowIndex = #_sw.windows
		end
	elseif (self.currentWindowIndex > #_sw.windows) then
		self.currentWindowIndex = #_sw.windows
	end
	
	if self.currentWindowIndex then
    self:EnableWindowControls()
		self.currentWindow = _sw.windows[self.currentWindowIndex]

		SWOptionsCurrentWindowScaleSlider:SetValue(self.currentWindow._var.scale)
		SWOptionsCurrentWindowOpacitySlider:SetValue(self.currentWindow._var.opacity)
		SWOptionsCurrentWindowFontSizeSlider:SetValue(self.currentWindow._var.fontSize)
		SWOptionsCurrentWindowBorderSizeSlider:SetValue(self.currentWindow._var.borderSize)

    SWOptionsCurrentWindowScaleSliderText:SetFormattedText(self.strings.SCALE, self.currentWindow._var.scale)
    SWOptionsCurrentWindowOpacitySliderText:SetFormattedText(self.strings.OPACITY, self.currentWindow._var.opacity)
    SWOptionsCurrentWindowFontSizeSliderText:SetFormattedText(self.strings.FONTSIZE, self.currentWindow._var.fontSize)
    SWOptionsCurrentWindowBorderSizeSliderText:SetFormattedText(self.strings.BORDERSIZE, self.currentWindow._var.borderSize)

    SWOptionsCurrentWindowUseWindowColourCheckButton:SetChecked(self.currentWindow._var.useWindowColour)
    
    self:SetupRowCountSlider()
    self:SetColours()
		self.currentFrame = nil
    ScrollingDropDown:SetSelected(SWOptionsWindowDropDown, self.currentWindowIndex, ScrollingDropDown.VALUE)
    ScrollingDropDown:SetSelected(SWOptionsCurrentWindowFontDropDown, self.currentWindow._var.font)
    if not Skinner then
      ScrollingDropDown:SetSelected(SWOptionsCurrentWindowBackgroundDropDown, self.currentWindow._var.background)
      ScrollingDropDown:SetSelected(SWOptionsCurrentWindowBorderDropDown, self.currentWindow._var.border)
    end
    self:SelectFrame(1)
    SWOptionsRemoveButton:Enable()
	else
		self.currentWindow = nil
		self:DisableWindowControls()
    SWOptionsRemoveButton:Disable()
	end
	self.selectWindow = false
end

function StatusWindowOptions:SetupRowCountSlider()
  if (#self.currentWindow.frames > 0) then
    SWOptionsCurrentWindowRowCountSlider:Enable()
    SWOptionsCurrentWindowRowCountSliderLow:SetFormattedText("1")
    SWOptionsCurrentWindowRowCountSliderHigh:SetFormattedText(#self.currentWindow.frames)
    SWOptionsCurrentWindowRowCountSlider:SetMinMaxValues(1, #self.currentWindow.frames)
    SWOptionsCurrentWindowRowCountSlider:SetValueStep(1)
    SWOptionsCurrentWindowRowCountSliderText:SetFormattedText(self.strings.ROWCOUNT, self.currentWindow._var.rowCount)
    SWOptionsCurrentWindowRowCountSlider:SetValue(self.currentWindow._var.rowCount)
  else
  SWOptionsCurrentWindowRowCountSlider:Disable()
  end
end

function StatusWindowOptions:SetColours()
  local var = self.currentWindow._var
  if not Skinner then
    SWOptionsCurrentWindowBackgroundColour.texture:SetVertexColor(var.backgroundColour.r, var.backgroundColour.g, var.backgroundColour.b)
    SWOptionsCurrentWindowBorderColour.texture:SetVertexColor(var.borderColour.r, var.borderColour.g, var.borderColour.b)
    ColourButton_Enable(SWOptionsCurrentWindowBackgroundColour, var.background)
    ColourButton_Enable(SWOptionsCurrentWindowBorderColour, var.border)
  else
    ColourButton_Enable(SWOptionsCurrentWindowBackgroundColour, false)
    ColourButton_Enable(SWOptionsCurrentWindowBorderColour, false)
  end
  SWOptionsCurrentWindowTextColour.texture:SetVertexColor(var.textColour.r, var.textColour.g, var.textColour.b)
end

function StatusWindowOptions:SetBorder()
	self.currentWindow._var.border = this:GetChecked()
  self:SetColours()
	StatusWindow:FinishWindow(self.currentWindow)
end 

function StatusWindowOptions:SetAlignment()
	self.currentWindow._var.horizontal = this:GetChecked()
	StatusWindow:MakeWindow(self.currentWindowIndex)
end 

function StatusWindowOptions:UseWindowColour()
	self.currentWindow._var.useWindowColour = this:GetChecked()
	StatusWindow:UpdateWindow(self.currentWindowIndex)
end

function StatusWindowOptions:SetBackground()
	self.currentWindow._var.background = this:GetChecked()
  self:SetColours()
	StatusWindow:FinishWindow(self.currentWindow)
end 

StatusWindowOptions.ColourPicker = function(self, colour)
	self.currentColour = colour
	self.currentControl = this
  if self.currentWindow._var[colour].a then
    ColourFrame:Open(self.ColourCallback, self.currentWindow._var[colour].r, self.currentWindow._var[colour].g, self.currentWindow._var[colour].b, self.currentWindow._var[colour].a)
  else
    ColourFrame:Open(self.ColourCallback, self.currentWindow._var[colour].r, self.currentWindow._var[colour].g, self.currentWindow._var[colour].b)
  end
end

StatusWindowOptions.ColourCallback = function(r,g,b,a)
	StatusWindowOptions.currentWindow._var[StatusWindowOptions.currentColour].r = r
	StatusWindowOptions.currentWindow._var[StatusWindowOptions.currentColour].g = g
	StatusWindowOptions.currentWindow._var[StatusWindowOptions.currentColour].b = b
  if a then
    StatusWindowOptions.currentWindow._var[StatusWindowOptions.currentColour].a = a
  end
  StatusWindowOptions.currentControl.texture:SetVertexColor(r,g,b,a or 1)
  StatusWindow:FinishWindow(StatusWindowOptions.currentWindow)
  StatusWindow:UpdateWindow(StatusWindowOptions.currentWindowIndex)
end

function StatusWindowOptions:EnableWindowControls()
	SWOptionsCurrentWindowFrameUpButton:Enable()
	SWOptionsCurrentWindowFrameDownButton:Enable()
	SWOptionsCurrentWindowFrameAddButton:Enable()
	SWOptionsCurrentWindowFrameRemoveButton:Enable()
	SWOptionsRemoveButton:Enable()
	SWOptionsCurrentWindowScaleSlider:Enable()
	SWOptionsCurrentWindowOpacitySlider:Enable()
	for i=1,10 do
		getglobal("SWOptionsCurrentWindowFrameList"..i):Enable()
	end
end

function StatusWindowOptions:DisableWindowControls()
	SWOptionsCurrentWindowFrameUpButton:Disable()
	SWOptionsCurrentWindowFrameDownButton:Disable()
	SWOptionsCurrentWindowFrameAddButton:Disable()
	SWOptionsCurrentWindowFrameRemoveButton:Disable()
	SWOptionsCurrentWindowBackgroundColour:Disable()
	SWOptionsCurrentWindowScaleSlider:Disable()
	SWOptionsCurrentWindowOpacitySlider:Disable()
	for i=1,10 do
		getglobal("SWOptionsCurrentWindowFrameList"..i):Disable()
	end
end

function StatusWindowOptions:FontDropDown_Initialise()
	local info = _sw:GetTable()
	info.callback = self.FontDropDown_OnClick
	for k,v in pairs(SML:List("font")) do
		info.text = v
		info.value = v
		ScrollingDropDown:AddItem(SWOptionsCurrentWindowFontDropDown, info)
	end
	_sw:PutTable(info)
end

function StatusWindowOptions.FontDropDown_OnClick(item)
	ScrollingDropDown:SetSelected(SWOptionsCurrentWindowFontDropDown, item.value)
	StatusWindowOptions.currentWindow._var.font = item.value
	StatusWindow:FinishWindow(StatusWindowOptions.currentWindow)
end

function StatusWindowOptions:BackgroundDropDown_Initialise()
	if Skinner then
    SWOptionsCurrentWindowBackgroundDropDown:Disable()
  else
    local info = _sw:GetTable()
    info.callback = self.BackgroundDropDown_OnClick
    for k,v in pairs(SML:List("background")) do
      info.text = v
      info.value = v
      ScrollingDropDown:AddItem(SWOptionsCurrentWindowBackgroundDropDown, info)
    end
    info.text = self.strings.NONE
    info.value = self.strings.NONE
    ScrollingDropDown:AddItem(SWOptionsCurrentWindowBackgroundDropDown, info)
    
    _sw:PutTable(info)
  end
end

function StatusWindowOptions.BackgroundDropDown_OnClick(item)
	ScrollingDropDown:SetSelected(SWOptionsCurrentWindowBackgroundDropDown, item.value, ScrollingDropDown.VALUE)
	StatusWindowOptions.currentWindow._var.background = item.value
	StatusWindow:FinishWindow(StatusWindowOptions.currentWindow)
end

function StatusWindowOptions:BorderDropDown_Initialise()
	if Skinner then
    SWOptionsCurrentWindowBorderDropDown:Disable()
  else
    local info = _sw:GetTable()
    info.callback = self.BorderDropDown_OnClick
    for k,v in pairs(SML:List("border")) do
      info.text = v
      info.value = v
      ScrollingDropDown:AddItem(SWOptionsCurrentWindowBorderDropDown, info)
    end
    _sw:PutTable(info)
  end
end

function StatusWindowOptions.BorderDropDown_OnClick(item)
	ScrollingDropDown:SetSelected(SWOptionsCurrentWindowBorderDropDown, item.value, ScrollingDropDown.VALUE)
	StatusWindowOptions.currentWindow._var.border = item.value
	StatusWindow:FinishWindow(StatusWindowOptions.currentWindow)
end

--
-- Frames
--

function StatusWindowOptions:AddFrame()
	if not _sw._var.frames then
    StatusWindow:debug(2, "StatusWindow._var.frames was nil")
    _sw._var.frames = {}
  end
	local fvar = _sw:GetTable()
	fvar.module = "None"
	fvar.window = self.currentWindowIndex
	fvar.position = #self.currentWindow.frames + 1

  local numRows = ceil((#self.currentWindow.frames + 1)/self.currentWindow._var.rowCount)
  if numRows > 1 then
    local col = mod(fvar.position, self.currentWindow._var.rowCount)
    if (col == 0) then 
      col = self.currentWindow._var.rowCount
    end
    fvar.width = self.currentWindow.frames[col]._var.width
  else
    fvar.width = 75 
  end
  table.insert(_sw._var.frames, fvar)
	StatusWindow:MakeWindow(self.currentWindowIndex)
	self:SelectFrame(#self.currentWindow.frames)
  self:SetupRowCountSlider()
end

function StatusWindowOptions:RemoveCurrentFrame()
  self:RemoveFrame(self.currentFrame)
	StatusWindow:UpdateSavedVars(self.currentWindow)
	if (self.currentWindow._var.rowCount > #self.currentWindow.frames) then
    self.currentWindow._var.rowCount = #self.currentWindow.frames
  end
	StatusWindow:MakeWindow(self.currentWindowIndex)
  StatusWindowOptions:SetupRowCountSlider()
  self:SelectFrame()
end

function StatusWindowOptions:RemoveFrame(f)
  self:RemoveFrameVars(f._var)
  StatusWindow:PutFrame(f)
end

function StatusWindowOptions:RemoveFrameVars(fvar)
  for k,v in pairs(_sw._var.frames) do
    if (tableaddr(v) == tableaddr(fvar)) then
      _sw:PutTable(table.remove(_sw._var.frames, k))
    end
  end
end

function StatusWindowOptions:SelectFrame(frame)
  self.selectFrame = true
	self:CloseConfigFrames()

	if (#self.currentWindow.frames == 0) then
		self.currentFrame = nil
		self.currentFrameIndex = nil
		self:DisableFrameControls()
		SWOptionsCurrentFrameTitle:SetFormattedText("")
	else
		if frame then
			if (frame <= #self.currentWindow.frames) then
				self.currentFrameIndex = frame
			else 
				self.currentFrameIndex = #self.currentWindow.frames
			end
		elseif (self.currentFrameIndex > #self.currentWindow.frames) then
			self.currentFrameIndex = #self.currentWindow.frames
		end

		self.currentFrame = self.currentWindow.frames[self.currentFrameIndex]
		SWOptionsCurrentFrameTitle:SetFormattedText(self.strings.PANETITLE, self.currentWindowIndex, self.currentFrameIndex)
		StatusWindow:InvokeFrameFunc(self.currentFrame, "Configure")
		self:EnableFrameControls()
		SWOptionsCurrentFrameWidthSlider:SetValue(self.currentFrame._var.width)
		SWOptionsCurrentFrameWidthSliderText:SetFormattedText(self.strings.WIDTH, self.currentFrame._var.width)
		SWOptionsCurrentFrameHeightSlider:SetValue(self.currentFrame._var.height)
    SWOptionsCurrentFrameHeightSliderText:SetFormattedText(self.strings.HEIGHT, self.currentFrame._var.height)
		SWOptionsCurrentFramePaddingSlider:SetValue(self.currentFrame._var.padding)
		SWOptionsCurrentFramePaddingSliderText:SetFormattedText(self.strings.PADDING, self.currentFrame._var.padding)

		ScrollingDropDown:SetSelected(SWOptionsCurrentFrameModuleDropDown, StatusWindowOptions.currentFrame._module.name)
	end
	self.UpdateFrameList()
  self.selectFrame = false
end

function StatusWindowOptions.UpdateFrameList()
	local offset = FauxScrollFrame_GetOffset(SWOptionsCurrentWindowFrameListScrollFrame)
	local listIndex,str
	local self = StatusWindowOptions
	local frames = self.currentWindow.frames
	local numFrames = #frames
	
	for i=1,10 do
		local listIndex = offset + i
		button = self.frameButtons[i]

		if frames[listIndex] then
			button.label:SetFormattedText(frames[listIndex]._module.name)
			button.index = listIndex
		else	
			button.label:SetFormattedText("")
			button.index = nil
		end

		-- Highlight the selected filter
		if self.currentFrame and (self.currentFrameIndex == listIndex) then
			button:LockHighlight()
			button.label:SetTextColor(1, 1, 1)
		else
			button:UnlockHighlight()
			button.label:SetTextColor(1, 0.82, 0)
		end
	end
	FauxScrollFrame_Update(SWOptionsCurrentWindowFrameListScrollFrame, numFrames, 15, 14)
	
	if StatusWindowOptions.currentFrame and StatusWindowOptions.currentFrameIndex then
		SWOptionsCurrentWindowFrameRemoveButton:Enable()
		if (numFrames > 1) and (StatusWindowOptions.currentFrameIndex > 1) then
			SWOptionsCurrentWindowFrameUpButton:Enable()
		else
			SWOptionsCurrentWindowFrameUpButton:Disable()
		end
		if (#frames > 1) and (StatusWindowOptions.currentFrameIndex < numFrames) then
			SWOptionsCurrentWindowFrameDownButton:Enable()
		else
			SWOptionsCurrentWindowFrameDownButton:Disable()
		end
	else
		SWOptionsCurrentWindowFrameRemoveButton:Disable()
		SWOptionsCurrentWindowFrameUpButton:Disable()
		SWOptionsCurrentWindowFrameDownButton:Disable()
	end
end

function StatusWindowOptions:CloseConfigFrames()
  if self.currentFrame then
    if self.configFrame then
      self.configFrame:Hide()
      self.configFrame = nil
    end
    if self.altConfigFrame then
      self.altConfigFrame:Hide()
      self.altConfigFrame = nil
    end
    StatusWindow:InvokeFrameFunc(self.currentFrame, "ConfigureCleanup")
  end
end

function StatusWindowOptions:OpenConfigFrames(frame, altFrame)
  self.configFrame = frame
  self.configFrame:SetPoint("BOTTOM", SWOptionsCurrentFrame, "BOTTOM", 0, 10)
  self.configFrame:Show()
  if altFrame then
    self.altConfigFrame = altFrame
    self.altConfigFrame:SetPoint("BOTTOM", frame, "TOP")
    self.altConfigFrame:Show()
  end
end

function StatusWindowOptions:ModuleDropDown_Initialise()
	local info = _sw:GetTable()
	info.callback = self.ModuleDropDown_OnClick
	for k,v in pairs(StatusWindow.loadedModules) do
		info.text = v.name
		info.value = v.name
		ScrollingDropDown:AddItem(SWOptionsCurrentFrameModuleDropDown, info)
	end
  _sw:PutTable(info)
end

function StatusWindowOptions.ModuleDropDown_OnClick(item)
  local s = StatusWindowOptions
  local f = s.currentFrame
  local var = f._var

  if (var.module == item.text) then
    return
  end
  
  s:CloseConfigFrames()
  
  _sw:PutTable(var.modVar)
	var.modVar = nil
  var.new = false
  var.window = s.currentWindowIndex
  var.position = s.currentFrameIndex
	var.module = item.text
  f.pane.fmt = nil
	StatusWindow:AttachModule(f)
  _sw:ValidateFrameVars(var)
	StatusWindow:InvokeFrameFunc(f, "Init")
  StatusWindow:FinishFrame(f)
	StatusWindow:FinishWindow(StatusWindowOptions.currentWindow)
  StatusWindow:InvokeFrameFunc(f, "Update", f._module.updateEvent)
  SWOptionsCurrentFrameWidthSlider:SetValue(f._var.width)
	s:DoUpdate()
	s:UpdateFrameList()
	ScrollingDropDown:SetSelected(SWOptionsCurrentFrameModuleDropDown, f._module.name)
	StatusWindow:InvokeFrameFunc(f, "Configure")
end

function StatusWindowOptions:EnableFrameControls()
	SWOptionsCurrentFrameWidthSlider:Enable()
	SWOptionsCurrentFrameModuleDropDown:Enable()
end

function StatusWindowOptions:DisableFrameControls()
	SWOptionsCurrentFrameWidthSlider:Disable()
	SWOptionsCurrentFrameModuleDropDown:Disable()
end

function StatusWindowOptions:FrameDown()
	if (self.currentFrameIndex < #self.currentWindow.frames) then
		local tmp = self.currentWindow.frames[self.currentFrameIndex]
		self.currentWindow.frames[self.currentFrameIndex] = self.currentWindow.frames[self.currentFrameIndex + 1]
		self.currentFrameIndex = self.currentFrameIndex + 1
		self.currentWindow.frames[self.currentFrameIndex] = tmp
		StatusWindow:UpdateSavedVars(self.currentWindow)
		StatusWindow:MakeWindow(self.currentWindowIndex)
		self:UpdateFrameList()
	end
end

function StatusWindowOptions:FrameUp()
	if (self.currentFrameIndex > 1) then
		local tmp = self.currentWindow.frames[self.currentFrameIndex]
		self.currentWindow.frames[self.currentFrameIndex] = self.currentWindow.frames[self.currentFrameIndex - 1]
		self.currentFrameIndex = self.currentFrameIndex - 1
		self.currentWindow.frames[self.currentFrameIndex] = tmp
		StatusWindow:UpdateSavedVars(self.currentWindow)
		StatusWindow:MakeWindow(self.currentWindowIndex)
		self:UpdateFrameList()
	end
end

function StatusWindowOptions:GetAbsoluteVarIndex(frame)
	for k,v in pairs(_sw._var.frames) do
		if (v.position == frame._var.position) and (v.window == frame._var.window) then
			return k
		end
	end
end

function StatusWindowOptions:AdjustColumnWidth(w)
  local numRows = ceil(#self.currentWindow.frames/self.currentWindow._var.rowCount)
  local col = mod(self.currentFrame._var.position, self.currentWindow._var.rowCount)
  if (col == 0) then 
    col = self.currentWindow._var.rowCount
  end

  local curFrame = 1
  for i=1,numRows do
    for j=1,self.currentWindow._var.rowCount do
      if (j == col) then
        frame = self.currentWindow.frames[curFrame]
        if not frame then
          break
        end
        frame._var.width = w
      end
      curFrame = curFrame + 1
    end
  end
end

function StatusWindowOptions:AdjustRowHeight(h)
  local numRows = ceil(#self.currentWindow.frames/self.currentWindow._var.rowCount)
  local row = ceil(self.currentFrame._var.position/self.currentWindow._var.rowCount)

  local curFrame = 1
  for i=1,numRows do
    for j=1,self.currentWindow._var.rowCount do
      if (i == row) then
        frame = self.currentWindow.frames[curFrame]
        if not frame then
          break
        end
        frame._var.height = h
      end
      curFrame = curFrame + 1
    end
  end
end
--
-- Sliders
--
function StatusWindowOptions:RowCountChanged()
  if not self.selectWindow then
    self.currentWindow._var.rowCount = this:GetValue()
    SWOptionsCurrentWindowRowCountSliderText:SetFormattedText(self.strings.ROWCOUNT, self.currentWindow._var.rowCount)
    StatusWindow:MakeWindow(self.currentWindowIndex)
  end
end

function StatusWindowOptions:PaddingChanged()
  if not self.selectFrame then
    self.currentFrame._var.padding = this:GetValue()
    SWOptionsCurrentFramePaddingSliderText:SetFormattedText(self.strings.PADDING, self.currentFrame._var.padding)
    StatusWindow:SetupPane(self.currentFrame)
  end
end

function StatusWindowOptions:WidthChanged()
  if not self.selectFrame then
    self:AdjustColumnWidth(this:GetValue())
    SWOptionsCurrentFrameWidthSliderText:SetFormattedText(self.strings.WIDTH, self.currentFrame._var.width)
    StatusWindow:MakeWindow(self.currentWindowIndex)
  end
end

function StatusWindowOptions:ScaleChanged()
  if not self.selectWindow then
    self.currentWindow._var.scale = this:GetValue()
    SWOptionsCurrentWindowScaleSliderText:SetFormattedText( self.strings.SCALE, self.currentWindow._var.scale)
    StatusWindow:FinishWindow(self.currentWindow)
  end
end

function StatusWindowOptions:OpacityChanged()
  if not self.selectWindow then
    self.currentWindow._var.opacity = this:GetValue()
    SWOptionsCurrentWindowOpacitySliderText:SetFormattedText(self.strings.OPACITY, self.currentWindow._var.opacity)
    StatusWindow:FinishWindow(self.currentWindow)
  end
end

function StatusWindowOptions:HeightChanged()
  if not self.selectFrame then
    self:AdjustRowHeight(this:GetValue())
    SWOptionsCurrentFrameHeightSliderText:SetFormattedText(self.strings.HEIGHT, self.currentFrame._var.height)
    StatusWindow:MakeWindow(self.currentWindowIndex)
  end
end

function StatusWindowOptions:FontSizeChanged()
  if not self.selectWindow then
    self.currentWindow._var.fontSize = this:GetValue()
    SWOptionsCurrentWindowFontSizeSliderText:SetFormattedText(self.strings.FONTSIZE, self.currentWindow._var.fontSize)
    StatusWindow:FinishWindow(self.currentWindow)
  end
end

function StatusWindowOptions:InsetChanged()
  if not self.selectFrame then
    self.currentWindow._var.backgroundInset = this:GetValue()
    SWOptionsCurrentWindowBackgroundInsetSliderText:SetFormattedText(self.strings.INSET, self.currentWindow._var.backgroundInset)
    StatusWindow:FinishWindow(self.currentWindow)
  end
end

function StatusWindowOptions:BorderSizeChanged()
  if not self.selectWindow then
    self.currentWindow._var.borderSize = this:GetValue()
    SWOptionsCurrentWindowBorderSizeSliderText:SetFormattedText(self.strings.BORDERSIZE, self.currentWindow._var.borderSize)
    StatusWindow:FinishWindow(self.currentWindow)
  end
end

--
-- Generic config window stuff
--
function StatusWindowOptions:GenericConfigHelpTooltip()
  if self.currentFrame._module.helpStrings then
    GameTooltip:SetOwner(this, "TOPRIGHT")
    GameTooltip:AddLine(format(_sw.strings.HELPTITLE, self.currentFrame._module.name))
    for k,v in ipairs(self.currentFrame._module.helpStrings) do
      GameTooltip:AddLine(v)
    end
    if self.currentFrame._module.icon then
      GameTooltip:AddLine(StatusWindow.strings.ICONHELP)
    end
    GameTooltip:Show()
  end
end

function StatusWindowOptions:SetupGenericConfig()
	self.setupConfig = true
  local var = StatusWindowOptions.currentFrame._var.modVar
  if self.currentFrame._module.helpStrings then
    StatusWindowGenericOptionsHelpButton:Show()
  else
    StatusWindowGenericOptionsHelpButton:Hide()
  end
	StatusWindowGenericOptionsTextAlignSliderText:SetFormattedText(self.strings.ALIGN)
  StatusWindowGenericOptionsTextAlignSliderLow:SetFormattedText("LEFT")
	StatusWindowGenericOptionsTextAlignSliderHigh:SetFormattedText("RIGHT")
	StatusWindowGenericOptionsTextAlignSlider:SetMinMaxValues(1, 3)
	StatusWindowGenericOptionsTextAlignSlider:SetValueStep(1)
  StatusWindowGenericOptionsTextAlignSlider:SetValue((var.textAlign == "LEFT" and 1) or (var.textAlign == "RIGHT" and 3) or 2)
  if var.label then
    StatusWindowGenericOptionsEditText:SetText(var.label)
  end
	self.setupConfig = false
end

function StatusWindowOptions:GenericConfigTextAlignmentChanged()
  if not self.setupConfig then
    local v = this:GetValue()
    self.currentFrame._var.modVar.textAlign = (v == 1 and "LEFT") or (v == 3 and "RIGHT") or "CENTER"
    StatusWindow:FinishWindow(self.currentWindow)
  end
end

function StatusWindowOptions:GenericConfigTextOK()
  local t = StatusWindowGenericOptionsEditText:GetText()
  local a = string.find(t, "%$i")
  
  if a then
    if not self.currentFrame._module.icon then
      ChatFrame1:AddMessage(format(self.strings.NOICON, self.currentFrame._module.name))
      return
    elseif (a > 1) then
      ChatFrame1:AddMessage(self.strings.ICONFIRST)
      return
    end
  end
  
	self.currentFrame._var.modVar.label = t
	self.currentFrame.pane.fmt = nil
  self.currentFrame._var.icon = (a == 1)
  StatusWindow:SetupDefaultPane(self.currentFrame)
  self:DoUpdate()
end

--
-- Module config callbacks
--
function StatusWindowOptions:InvokeConfigFunc(func, arg1)
	StatusWindow:InvokeFrameFunc(self.currentFrame, func, arg1)
end

function StatusWindowOptions:DoUpdate()
	StatusWindow:InvokeFrameFunc(self.currentFrame, "Update", self.currentFrame._module.updateEvent)
end

