--[[-- ColorPicker Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.ColorPicker then return end

--[[-- ColorPicker Control Registration and Methods
	@class table
	@name Portfolio.Control.ColorPicker
--]]--
Portfolio.Control.ColorPicker = {}
CONTROLTYPE_COLORPICKER = 7
Portfolio.CONTROL_TYPES[CONTROLTYPE_COLORPICKER] = "ColorPicker"

--Registration
function Portfolio.Control.ColorPicker.Register(optionsFrame, option)
	--Checkbox
	local controlName = optionsFrame:GetName()..option.id
	local control = CreateFrame("Button", controlName, optionsFrame.scrollChild) -- No Template
	control:SetWidth(16)
	control:SetHeight(16)
	
	local bg = control:CreateTexture(nil, "BACKGROUND") -- bg texture
	bg:SetWidth(14)
	bg:SetHeight(14)
	bg:SetPoint("CENTER", 0, 0)
	bg:SetTexture(1,1,1) -- white bg
	control.GetBackground = function(self) return bg end
	
	control:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch") -- main color texture
	
	-- Add Text
	local desc = control:CreateFontString(controlName.."Text", "ARTWORK", "GameFontNormalSmall")
	desc:SetPoint("LEFT", control, "RIGHT", 6, 0)
	
	--Copy Vars
	Portfolio.CopyTableElements(control, option, "tooltipText", "callback", "hasOpacity", "cancelFunc")
	
	Portfolio.InitField(control, option, "xOffset", 4)
	Portfolio.InitField(control, option, "yOffset")
	Portfolio.InitField(control, option, "xOffsetRelative", -4)
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_COLORPICKER, control)
	Portfolio.PopulateValueControl(optionsFrame, option, control)
	
	-- Frame Population
	control.GetValue = Portfolio.Control.GetValue
	control.SetValue = Portfolio.Control.ColorPicker.SetValue
	control.Update = Portfolio.Control.Update
	control.UpdateText = Portfolio.Control.ColorPicker.UpdateText
	control.SetText = Portfolio.Control.SetText
	
	control:SetScript("OnEnter", Portfolio.Control.ColorPicker.OnEnter)
	control:SetScript("OnLeave", Portfolio.Control.ColorPicker.OnLeave)
	control:SetScript("OnClick", Portfolio.Control.ColorPicker.OnClick)
	
	-- Enable (same as Checkbox)
	BlizzardOptionsPanel_CheckButton_Enable(control)
	
	-- Setup Frame Text
	control:UpdateText()
	
	--control.currValue = "1"
	--control.value = "1"
	
	Portfolio.InitDefaultValue(control)
	
	if type(option.init) == "function" then
		option.init(control)
	end
	
	return control
end


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[-- Update the saved var and the control state.

	@name			SetValue
	@param self		control
	@param color	new color table {r=#, g=#, b=#, opacity=#} (opacity is optional)
	@param isGUI	(boolean) called from a GUI interaction, passed to the callback
	@param isUpdate	(boolean) called from control:Update(), passed to the callback 
	@usage			control:SetValue(color)
--]]--
function Portfolio.Control.ColorPicker.SetValue(self, color, isGUI, isUpdate)
	Portfolio.Control.SetValue(self, color, isGUI, isUpdate)
	
	local normalTex = self:GetNormalTexture()
	normalTex:SetVertexColor(color.r, color.g, color.b)
	if (color.opacity) then
		normalTex:SetAlpha(color.opacity)
	else
		normalTex:SetAlpha(1.0)
	end
end

--[[-- Update the control text from control.text.
	Adjust the checkbox HitRect to accept OnEnter and OnClick over the text.

	@name			UpdateText
	@param self		checkbox control
	@usage			control:UpdateText()
--]]--
function Portfolio.Control.ColorPicker.UpdateText(self)
	Portfolio.Control.UpdateText(self)

	local fontString = _G[self:GetName().."Text"]
	self:SetHitRectInsets(0, -fontString:GetWidth(), 0, 0)
end


------------------------------------------------------------------------------
--[[ Control Events ]]--
------------------------------------------------------------------------------

local function emptyFunc() end

-- Event: OnEnter
function Portfolio.Control.ColorPicker.OnEnter(self)
	self:GetBackground():SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	Portfolio.Control.OnEnter(self)
end

-- Event: OnLeave
function Portfolio.Control.ColorPicker.OnLeave(self)
	self:GetBackground():SetVertexColor(1, 1, 1)
	Portfolio.Control.OnLeave(self)
end

-- Event: OnClick
function Portfolio.Control.ColorPicker.OnClick(self)
	PlaySound("gsTitleOptionOK")
	
	local control = self
	local func = function()
		local r, g, b = ColorPickerFrame:GetColorRGB()
		local opacity
		if ( ColorPickerFrame.hasOpacity ) then
			opacity = 1 - Portfolio.Round(OpacitySliderFrame:GetValue(), 2) -- round to 2 decimal points
		end
		
		-- TODO: don't recreate the table?
		local color = {r = r, g = g, b = b, opacity = opacity}
		
		--if not control:ValueEquals(color) then
			if ColorPickerFrame:IsShown() then
				-- call callback
				Portfolio.Control.SetValue(control, color, true)
			else
				-- update control
				control:SetValue(color, true)
			end
		--end
	end
	
	local color = self:GetValue()
	ColorPickerFrame.hasOpacity = self.hasOpacity
	if ( self.hasOpacity and color.opacity ) then
		ColorPickerFrame.opacity = 1 - color.opacity
		ColorPickerFrame.func = func
		ColorPickerFrame.opacityFunc = func
	else
		ColorPickerFrame.opacity = 1.0
		ColorPickerFrame.func = func
		ColorPickerFrame.opacityFunc = nil
	end
	
	-- This triggers a call to ColorPickerFrame.func()
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b)
	ColorPickerFrame.previousValues = {r = color.r, g = color.g, b = color.b, opacity = color.opacity}
	
	ColorPickerFrame.cancelFunc = function(previousValues)
		Portfolio.Control.SetValue(control, previousValues, true)
		if control.cancelFunc then
			control.cancelFunc(previousValues)
		end
	end
	
	ShowUIPanel(ColorPickerFrame)
end

