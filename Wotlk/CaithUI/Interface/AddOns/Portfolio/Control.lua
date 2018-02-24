--[[-- Generic Control Methods.<br/>
	These methods are assigned to controls upon creation.<br/>
	Some of them overload (hook or replace) existing creation methods.<br/>
	<br/>
	Instead of using a control's type specific set/get methods you should use
	contol:SetValue(value) and control:GetValue() to update and check 
	the control state and the saved variable.
 --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control then return end

--[[-- Generic Control Methods
	@class table
	@name Portfolio.Control
--]]--
Portfolio.Control = {}

------------------------------------------------------------------------------
--[[ Common Control Support Functions ]]--
------------------------------------------------------------------------------

-- Get text from a key
function Portfolio.Control.GetValueText(control, key)
	local text = control[key]
	if not text then return end
	
	local value = control:GetValue() or 0
	local success = true
	if (type(text) == "function") then
		success, text = pcall( text, value )
	end
	if (success and value ~= nil and type(text) == "string" and strfind(text, "%%[0# +%-]*%d*%.?%d*[idfgGeEsq]")) then
		success, text = pcall( format, text, value )
	end
	if not success then
		-- Print out the error if there is one. Can we fake an error?
		Portfolio.PrintError(control:GetName().."."..key.."("..tostring(control:GetValue())..") Error:")
		Portfolio.PrintError(text)
	elseif type(text) == "string" then
		return text
	end
end


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[--  Get the value from the saved var or control. 
	This should also be the state of the control unless it hasn't been initialized. 
	This will be the case if initCallbacks = false and Update has not been called, 
	or if the variables haven't loaded yet.
	
	@name			GetValue
	@param self		control
	@usage			value = control:GetValue()
	@return			value
--]]--
function Portfolio.Control.GetValue(self)
	local value = nil
	if (self.tvar) then
		local varTable = self.varTable or self.optionsFrame.savedVarTable
		if (type(varTable) == "string") then
			varTable = _G[varTable]
		end
		if (varTable) then
			value = varTable[self.tvar]
		end
	elseif (self.cvar) then
		value = GetCVar(self.cvar)
	elseif (self.uvar) then
		value = _G[self.uvar]
	elseif (self.value ~= nil) then
		value = self.value
	elseif (self.defaultValue ~= nil) then
		--Portfolio.PrintError("defaultValue "..self:GetName().."GetValue()")
		value = self.defaultValue
	else
		--Portfolio.PrintError("Real "..self:GetName().."GetValue()")
		-- Call Orig if no default set
		local control = getmetatable(self).__index
		if control.GetValue then
			value = control.GetValue(self)
		elseif control.IsChecked then
			value = control.IsChecked(self) and "1" or "0"
		elseif control.GetText then
			value = control.GetText(self) or ""
		end
	end
	return value
end

--[[-- Update the saved var, the control state and the contol text.

	@name			SetValue
	@param self		control
	@param value	new value
	@param isGUI	(boolean) called from a GUI interaction, passed to the callback
	@param isUpdate	(boolean) called from control:Update(), passed to the callback
	@usage			control:SetValue(value)
--]]--
function Portfolio.Control.SetValue(self, value, isGUI, isUpdate)
	
	-- Update Saved Var
	if type(self.uvar) == "string" then
		-- Global
		_G[self.uvar] = value
	elseif type(self.tvar) == "string" then
		-- Table Var
		local varTable = self.varTable or self.optionsFrame.savedVarTable
		if (varTable ~= nil) then
			-- VarTable was set and is expected to be a table or a string name of a global table
			if (type(varTable) == "string") then
				-- String varTable must be global
				varTable = _G[varTable]
			end
			if type(varTable) == "table" then
				varTable[self.tvar] = value
			else
				--error: non-table varTable
				Portfolio.PrintError(self:GetName()..":SetValue("..tostring(value)..") Error: varTable is not a table")
			end
		end
	elseif type(self.cvar) == "string" then
		-- CVar
		-- Only update the CVar if it has changed. Use Blizz wrapper for comparison.
		BlizzardOptionsPanel_SetCVarSafe(self.cvar, value, self.event)
	end
	
	-- Safe callback with pcall
	if (self.callback) then
		local success, result = pcall( self.callback, value, isGUI, isUpdate )
		if (not success) then
			-- Print out the error if there is one. Can we fake an error?
			Portfolio.PrintError(self:GetName()..".callback("..tostring(value)..", "..tostring(isUpdate)..", "..tostring(isGUI)..") Error:")
			Portfolio.PrintError(result)
		end
	end
	
	-- Update Text
	self:UpdateText()
	
	self.newValue = value
end

--[[-- Update the control state from the saved var and call the callback.

	@name			Update
	@param self		control
	@usage			control:Update()
--]]--
function Portfolio.Control.Update(self)
	self:SetValue(self:GetValue(), false, true)
end

-- control:SetRelativePoint("point", "prevOption", "relativePoint", offsetX, offsetY)
function Portfolio.Control.SetRelativePoint(self, point, anchor, relativePoint, xOffset, yOffset)
	
	point = point or "TOPLEFT"
	anchor = ( type(anchor) == "string" and self.optionsFrame:GetControl(anchor) ) or anchor or self.prev
	
	if not anchor then
		-- Title or first option, anchor to the parent optionsFrame.scrollChild
		anchor = self:GetParent()
		relativePoint = relativePoint or "TOPLEFT"
	else 
		relativePoint = relativePoint or "BOTTOMLEFT"
	end
	
	if not yOffset then
		yOffset = -8
		if anchor.yOffsetRelative then
			yOffset = yOffset + anchor.yOffsetRelative
		end
		if self.yOffset then
			yOffset = yOffset + self.yOffset
		end
	end
	
	if not xOffset then
		xOffset = 0
		if anchor.xOffsetRelative then
			xOffset = xOffset + anchor.xOffsetRelative
		end
		if self.xOffset then
			xOffset = xOffset + self.xOffset
		end
	end
	
	self:SetPoint(point, anchor, relativePoint, xOffset, yOffset)
	--Portfolio.Print(self.id..":SetPoint("..point..", "..tostring(anchor.id)..", "..relativePoint..", "..offsetX..", "..offsetY)
end

--[[-- Set the control text.
	Sets control.text to the new value and calls control:UpdateText()
	
	@name			SetText
	@param self		control
	@param text		(string) new text
	@usage			control:SetText(text)
--]]--
function Portfolio.Control.SetText(self, text)
	self.text = text
	self:UpdateText(text)
end

--[[-- Update the control text from control.text
	Also calls control:UpdateHeaderText() if it exists.

	@name			UpdateText
	@param self		control
	@usage			control:UpdateText()
--]]--
function Portfolio.Control.UpdateText(self)
	-- Update header text
	if self.UpdateHeaderText then
		self:UpdateHeaderText()
	end
	
	local text = Portfolio.Control.GetValueText(self, "text")
	if type(text) == "string" then
		_G[self:GetName().."Text"]:SetText(text)
	end
end

--[[-- Update the control width to adjust text wrapping.
	Only needs to be called if the position of the control is moved or the parent frame was resized.
	(headers, texts, windows)
	
	@name			UpdateBox
	@param self		header or text control
	@usage			control:UpdateBox()
--]]--
function Portfolio.Control.UpdateBox(self)
	if not self:GetRight() then return end
	local width = self:GetRight() - self:GetLeft()
	self:SetWidth(0)
	self:SetHeight(0)
	--local height = math.ceil( self:GetStringWidth() / width ) * self:GetStringHeight()
	--print(self.id..": "..width..", "..height)
	self:SetWidth(width)
	--self:SetHeight(height)
end

--[[-- Set the control header text.
	Sets control.headerText to the new value and calls control:UpdateHeaderText()
	(dropdowns and editboxes)
	
	@name			SetHeaderText
	@param self		control
	@param text		(string) new text
	@usage			control:SetHeaderText(text)
--]]--
function Portfolio.Control.SetHeaderText(self, text)
	self.headerText = text
	self:UpdateHeaderText()
end

--[[-- Update the control header text from control.headerText
	(dropdowns and editboxes)

	@name			UpdateHeaderText
	@param self		control
	@usage			control:UpdateHeaderText()
--]]--
function Portfolio.Control.UpdateHeaderText(self)
	local text = Portfolio.Control.GetValueText(self, "headerText")
	if type(text) == "string" then
		_G[self:GetName().."HeaderText"]:SetText(text)
	end
end

--[[-- Enable the control for clicks.
	Restores the text color.
	
	@name			Enable
	@param self		control
	@usage			control:Enable()
--]]--
function Portfolio.Control.Enable(self)
	-- Call Orig
	getmetatable(self).__index.Enable(self)
	-- Restore text color
	local text = _G[self:GetName().."Text"];
	local fontObject = text:GetFontObject();
	_G[self:GetName().."Text"]:SetTextColor(fontObject:GetTextColor());
end

--[[-- Disable the control so it cannot be clicked.
	Sets the text color to grey.
	
	@name			Disable
	@param self		control
	@usage			control:Disable()
--]]--
function Portfolio.Control.Disable(self)
	-- Call Orig
	getmetatable(self).__index.Disable(self)
	
	local text = _G[self:GetName().."Text"];
	if ( text ) then
		text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	end
end

--[[-- Reset the control value to the default value
	if it is different than the current value.

	@name			Reset
	@param self		control
	@usage			control:Reset()
--]]--
function Portfolio.Control.Reset(self)
	if not self:ValueEquals(self.defaultValue) then
		self:SetValue(self.defaultValue)
	end
end

--[[-- Update the control state from the saved var 
	if the value is different than the current control state.
	Also stores the current value to allow for canceling changes.

	@name			Refresh
	@param self		control
	@usage			control:Refresh()
--]]--
function Portfolio.Control.Refresh(self)
	if not self:ValueEquals(self.newValue or self.value) then
		self:Update()
	end
	self.value = self:GetValue()
	self.newValue = nil
end

--[[-- Confirm changes to the value of this control

	@name			Okay
	@param self		control
	@usage			control:Okay()
--]]--
function Portfolio.Control.Okay(self)
	BlizzardOptionsPanel_OkayControl(self)
end

--[[-- Undo changes to the value of this control

	@name			Cancel
	@param self		control
	@usage			control:Cancel()
--]]--
function Portfolio.Control.Cancel(self)
	BlizzardOptionsPanel_CancelControl(self)
end

-- Deep Equals
local function equals(t1, t2)
	if t1 == t2 then
		return true
	end
	if type(t1) ~= "table" or type(t2) ~= "table" then
		return false
	end
	local v2
	for k,v1 in pairs(t1) do
		v2 = t2[k]
		if v1 ~= v2 and not equals(v1, t2[k]) then
			return false
		end
	end
	for k in pairs(t2) do
		if t1[k] == nil then
			return false
		end
	end
	return true
end

--[[-- Check if a value is equal to the current control value.
	Deep equals for table values (namely ColorPicker). Use instead of value == self:GetValue()

	@name			ValueEquals
	@param self		control
	@return			(boolean) isEqual
	@usage			isEqual = control:ValueEquals(value)
--]]--
function Portfolio.Control.ValueEquals(self, value)
	return equals(self:GetValue(), value)
end


------------------------------------------------------------------------------
--[[ Common Control Events ]]--
------------------------------------------------------------------------------

-- Event: OnEnter
function Portfolio.Control.OnEnter(self)
	local text = Portfolio.Control.GetValueText(self, "tooltipText")
	if type(text) == "string" then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(text, nil, nil, nil, nil, 1);
	end
	-- From Blizzard code. If you want red text at the bollow just use "\n|cFF0000", imo.
	if ( self.tooltipText and self.tooltipRequirement ) then
		GameTooltip:AddLine(self.tooltipRequirement, "", 1.0, 1.0, 1.0);
		GameTooltip:Show();
	end
end

-- Event: OnLeave
function Portfolio.Control.OnLeave(self)
	GameTooltip:Hide()
end
