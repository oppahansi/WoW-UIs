--[[-- Checkbox Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.Checkbox then return end

--[[-- Checkbox Control Registration and Methods
	@class table
	@name Portfolio.Control.Checkbox
--]]--
Portfolio.Control.Checkbox = {}
--CONTROLTYPE_CHECKBOX = 1 -- Defined in UIOptionsPanel.lua
Portfolio.CONTROL_TYPES[CONTROLTYPE_CHECKBOX] = "Checkbox"

--Registration
function Portfolio.Control.Checkbox.Register(optionsFrame, option)
	--Checkbox
	local controlName = optionsFrame:GetName()..option.id
	local control = CreateFrame("CheckButton", controlName, optionsFrame.scrollChild, "OptionsCheckButtonTemplate")
	
	--Copy Vars
	Portfolio.CopyTableElements(control, option, "tooltipText", "callback", "dependentControls", "dependentControlsByID", "invert")
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffset")
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_CHECKBOX, control)
	Portfolio.PopulateValueControl(optionsFrame, option, control)
	
	-- Frame Population
	control.UpdateDependents = Portfolio.Control.Checkbox.UpdateDependents
	control.GetValue = Portfolio.Control.GetValue
	control.SetValue = Portfolio.Control.Checkbox.SetValue
	control.Update = Portfolio.Control.Update
	control.UpdateText = Portfolio.Control.Checkbox.UpdateText
	control.SetText = Portfolio.Control.SetText
	
	control:SetScript("OnEnter", Portfolio.Control.OnEnter)
	control:SetScript("OnClick", Portfolio.Control.Checkbox.OnClick)
	
	-- Enable
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
	Calls control:UpdateDependents() if changed.

	@name			SetValue
	@param self		checkbox control
	@param value	("1" or "0") new value
	@param isGUI	(boolean) called from a GUI interaction, passed to the callback
	@param isUpdate	(boolean) called from control:Update(), passed to the callback 
	@usage			control:SetValue(value)
--]]--
function Portfolio.Control.Checkbox.SetValue(self, value, isGUI, isUpdate)
	self:SetChecked(value == "1" or self.invert and value ~= "1")
	--if (isUpdate or value ~= self:GetValue()) then
		Portfolio.Control.SetValue(self, value, isGUI, isUpdate)
		self:UpdateDependents()
	--end
end

--[[-- Update the dependant controls.
	From control.dependentControlsByID by control id 
	or from control.dependentControlsByID by frame.

	@name			UpdateDependents
	@param self		checkbox control
	@usage			control:UpdateDependents()
--]]--
function Portfolio.Control.Checkbox.UpdateDependents(self)
	if ( self.dependentControls ) then
		local value = self:GetValue()
		local control
		if ( value == "1" or self.invert and value == "0" ) then
			if self.dependentControlsByID then
				for _, control in next, self.dependentControlsByID do
					control = self.optionsFrame:GetControl(control)
					if not control:IsEnabled() then
						control:Enable()
					end
				end
			end
			if self.dependentControls then
				for _, control in next, self.dependentControls do
					if not control:IsEnabled() then
						control:Enable()
					end
				end
			end
		else
			if self.dependentControlsByID then
				for _, control in next, self.dependentControlsByID do
					control = self.optionsFrame:GetControl(control)
					if control:IsEnabled() then
						control:Disable()
						control:Reset()
					end
				end
			end
			if self.dependentControls then
				for _, control in next, self.dependentControls do
					if control:IsEnabled() then
						control:Disable()
					end
				end
			end
		end
	end
end

--[[-- Update the control text from control.text.
	Adjust the checkbox HitRect to accept OnEnter and OnClick over the text.

	@name			UpdateText
	@param self		checkbox control
	@usage			control:UpdateText()
--]]--
function Portfolio.Control.Checkbox.UpdateText(self)
	Portfolio.Control.UpdateText(self)

	local fontString = _G[self:GetName().."Text"]
	self:SetHitRectInsets(0, -fontString:GetWidth(), 0, 0)
end


------------------------------------------------------------------------------
--[[ Control Events ]]--
------------------------------------------------------------------------------

-- Replacing InterfaceOptionsPanel_CheckButton_OnClick
-- Event: OnClick
function Portfolio.Control.Checkbox.OnClick(self)
	local checked = self:GetChecked()
	if checked then
		PlaySound("igMainMenuOptionCheckBoxOn")
	else
		PlaySound("igMainMenuOptionCheckBoxOff")
	end
	local value = checked and not self.invert and "1" or "0"
	self:SetValue(value, true)
end
