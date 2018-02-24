--[[-- EditBox Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.EditBox then return end

--[[-- EditBox Control Registration and Methods
	@class table
	@name Portfolio.Control.EditBox
--]]--
Portfolio.Control.EditBox = {}
CONTROLTYPE_EDITBOX = 5
Portfolio.CONTROL_TYPES[CONTROLTYPE_EDITBOX] = "EditBox"

--Registration
function Portfolio.Control.EditBox.Register(optionsFrame, option)
	--EditBox
	local controlName = optionsFrame:GetName()..option.id
	local control = CreateFrame("EditBox", controlName, optionsFrame.scrollChild) -- No Template
	control:SetAltArrowKeyMode(false)
	--control:SetHistoryLines(32)
	--control:SetMaxLetters(256)
	control:SetAutoFocus(false)
	--<FontString inherits="ChatFontNormal" bytes="256"/>
	--control:CreateFontString(nil, layer, "ChatFontNormal")
	control:SetFontObject(ChatFontNormal)
	
	control:SetTextInsets(5, 5, 2, 2)
	
	control:SetWidth(100)
	control:SetHeight(20)
	
	control:SetMultiLine(false)
	
	--border and background textures
	control:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile = true, 
		tileSize = 16, 
		edgeSize = 16,
		insets = { left = 5, right = 5, top = 4, bottom = 4 }	
	})
	control:SetBackdropBorderColor(0.5, 0.5, 0.5)
	control:SetBackdropColor(0.09, 0.09, 0.09)
	
	--[[
	local left = control:CreateTexture(nil, "BACKGROUND")
	left:SetWidth(8)
	left:SetPoint("TOPLEFT", 0, 0)
	left:SetPoint("BOTTOMLEFT", 0, 0)
	left:SetTexture("Interface\\Common\\Common-Input-Border")
	left:SetTexCoord(0, 0.0625, 0, 0.625)
	
	local right = control:CreateTexture(nil, "BACKGROUND")
	right:SetWidth(8)
	right:SetPoint("TOPRIGHT", 0, 0)
	right:SetPoint("BOTTOMRIGHT", 0, 0)
	right:SetTexture("Interface\\Common\\Common-Input-Border")
	right:SetTexCoord(0.9375, 1.0, 0, 0.625)
	
	local middle = control:CreateTexture(nil, "BACKGROUND")
	middle:SetPoint("TOPLEFT", left, "TOPRIGHT", 0, 0)
	middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT", 0, 0)
	middle:SetTexture("Interface\\Common\\Common-Input-Border")
	middle:SetTexCoord(0.0625, 0.9375, 0, 0.625)
	]]--
	
	-- Add Description Text
	local desc = control:CreateFontString(controlName.."HeaderText", "ARTWORK", "GameFontNormalSmall")
	desc:SetPoint("BOTTOMLEFT", control, "TOPLEFT", -2, 2)
	
	--Copy Vars
	Portfolio.CopyTableElements(control, option, "tooltipText", "callback", "headerText")
	
	Portfolio.InitField(control, option, "xOffset", 2)
	Portfolio.InitField(control, option, "xOffsetRelative", -2)
	Portfolio.InitField(control, option, "yOffset", -12)
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_EDITBOX, control)
	Portfolio.PopulateValueControl(optionsFrame, option, control)
	
	if control.text and not control.headerText then
		control.headerText = control.text
		control.text = nil
	end
	
	-- Frame Population
	control.GetValue = Portfolio.Control.GetValue
	control.SetValue = Portfolio.Control.EditBox.SetValue
	control.Update = Portfolio.Control.Update
	control.UpdateText = Portfolio.Control.EditBox.UpdateText
	control.SetHeaderText = Portfolio.Control.SetHeaderText
	control.UpdateHeaderText = Portfolio.Control.UpdateHeaderText
	
	-- Update OnEnter to accept tooltipText as functions
	control:SetScript("OnEnter", Portfolio.Control.OnEnter)
	control:SetScript("OnLeave", Portfolio.Control.OnLeave)
	--control:SetScript("OnMouseUp", Portfolio.Control.EditBox.OnClick)
	control:SetScript("OnTextChanged", Portfolio.Control.EditBox.OnTextChanged)
	control:SetScript("OnEnterPressed", Portfolio.Control.EditBox.OnEnterPressed)
	control:SetScript("OnEscapePressed", Portfolio.Control.EditBox.OnEscapePressed)
	--control:SetScript("OnEditFocusLost", Portfolio.Control.EditBox.OnEditFocusLost)
	
	-- Setup Frame Text
	control:UpdateText()
	
	Portfolio.InitDefaultValue(control)
	
	if type(option.init) == "function" then
		option.init(control)
	end
	
	return control
end


--[[--	See <a href="Control.html#GetValue">Control.GetValue </a>
	@name			GetValue
--]]--

--[[
control.GetValue = Portfolio.Control.GetValue
control.SetValue = Portfolio.Control.EditBox.SetValue
control.Update = Portfolio.Control.Update
control.UpdateText = Portfolio.Control.EditBox.UpdateText
control.SetHeaderText = Portfolio.Control.SetHeaderText
control.UpdateHeaderText = Portfolio.Control.UpdateHeaderText
]]--


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[-- Calls control:UpdateHeaderText()

	@name			UpdateText
	@param self		control
	@usage			control:UpdateText()
--]]--
function Portfolio.Control.EditBox.UpdateText(self)
	self:UpdateHeaderText()
end

--[[-- Update the saved var and the control state.

	@name			SetValue
	@param self		editbox control
	@param value	(string) new value
	@param isGUI	(boolean) called from a GUI interaction, passed to the callback
	@param isUpdate	(boolean) called from control:Update(), passed to the callback
	@usage			control:SetValue(value)
--]]--
function Portfolio.Control.EditBox.SetValue(self, value, isGUI, isUpdate)
	self.isSet = true
	self:SetText(value)
	Portfolio.Control.SetValue(self, value, isGUI, isUpdate)
end


------------------------------------------------------------------------------
--[[ Control Event ]]--
------------------------------------------------------------------------------

-- Event: OnTextChanged
function Portfolio.Control.EditBox.OnTextChanged(self)
	if not self.isSet then
		Portfolio.Control.SetValue(self, self:GetText(), true)
	end
	self.isSet = nil
end

-- Event: OnEscapePressed
function Portfolio.Control.EditBox.OnEscapePressed(self)
	self:ClearFocus()
end

-- Event: OnEscapePressed
function Portfolio.Control.EditBox.OnEnterPressed(self)
	if not self:IsMultiLine() then
		self:ClearFocus()
	end
end

