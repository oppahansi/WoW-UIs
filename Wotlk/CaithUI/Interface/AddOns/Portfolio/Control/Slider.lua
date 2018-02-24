--[[-- Slider Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.Slider then return end

--[[-- Slider Control Registration and Methods
	@class table
	@name Portfolio.Control.Slider
--]]--
Portfolio.Control.Slider = {}
--CONTROLTYPE_SLIDER = 3 -- Defined in UIOptionsPanel.lua
Portfolio.CONTROL_TYPES[CONTROLTYPE_SLIDER] = "Slider"

--Registration
function Portfolio.Control.Slider.Register(optionsFrame, option)
	--Slider
	local controlName = optionsFrame:GetName()..option.id
	local control = CreateFrame("Slider", controlName, optionsFrame.scrollChild, "OptionsSliderTemplate")
	
	--Copy Vars
	Portfolio.CopyTableElements(control, option, "tooltipText", "callback", "minText", "maxText", "valueStep")
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffset", -12)
	Portfolio.InitField(control, option, "yOffsetRelative", -4)
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_SLIDER, control)
	Portfolio.PopulateValueControl(optionsFrame, option, control)

	-- Frame Population
	control.SetMinMaxValues = Portfolio.Control.Slider.SetMinMaxValues
	control.GetValue = Portfolio.Control.GetValue
	control.SetValue = Portfolio.Control.Slider.SetValue
	control.Update = Portfolio.Control.Update
	control.UpdateText = Portfolio.Control.UpdateText
	control.SetText = Portfolio.Control.SetText
	
	--control.currValue = "1"
	--control.value = "1"
	--control.dependentControls = {}
	--self.uvar = option.id (Global Var)
	
	control:SetMinMaxValues(option.minValue, option.maxValue)
	control:SetValueStep(control.valueStep)
	
	control:SetScript("OnEnter", Portfolio.Control.OnEnter)
	control:SetScript("OnValueChanged", Portfolio.Control.Slider.OnValueChanged)
	
	-- Enable and Color Text
	BlizzardOptionsPanel_Slider_Enable(control)
	
	-- Setup Frame Text
	control:UpdateText()
	
	Portfolio.InitDefaultValue(control)
	
	if type(option.init) == "function" then
		option.init(control)
	end
	
	return control
end


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[-- Update the min and max ranges of the slider.
	Updates control.minValue and control.maxValue and the min/max text
	if control.minText and control.maxText are undefined.

	@name			SetMinMaxValues
	@param self		slider control
	@param minValue	(number) minimum value
	@param maxValue	(number) maximum value
	@usage			control:SetMinMaxValues(minValue, maxValue)
--]]--
function Portfolio.Control.Slider.SetMinMaxValues(self, minValue, maxValue)
	-- Call Orig
	getmetatable(self).__index.SetMinMaxValues(self, minValue, maxValue)
	
	self.minValue = minValue
	self.maxValue = maxValue
	
	-- Set Min/Max Texts
	_G[self:GetName().."Low"]:SetText(self.minText or minValue)
	_G[self:GetName().."High"]:SetText(self.maxText or maxValue)
end

--[[-- Update the saved var and the control state.

	@name			SetValue
	@param self		slider control
	@param value	(number) new value
	@param isGUI	(boolean) called from a GUI interaction, passed to the callback
	@param isUpdate	(boolean) called from control:Update(), passed to the callback 
	@usage			control:SetValue(value)
--]]--
function Portfolio.Control.Slider.SetValue(self, value, isGUI, isUpdate)
	self.isSet = true
	getmetatable(self).__index.SetValue(self, value)
	Portfolio.Control.SetValue(self, value, isGUI, isUpdate)
end


------------------------------------------------------------------------------
--[[ Control Events ]]--
------------------------------------------------------------------------------

-- Event: OnValueChanged
function Portfolio.Control.Slider.OnValueChanged(self, value)
	if not self.isSet then
		local value = getmetatable(self).__index.GetValue(self, value)
		Portfolio.Control.SetValue(self, value, true)
	end
	self.isSet = nil
end
