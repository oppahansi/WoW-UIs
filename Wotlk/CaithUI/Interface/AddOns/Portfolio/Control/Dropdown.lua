--[[-- DropDown Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.DropDown then return end

--[[-- DropDown Control Registration and Methods
	@class table
	@name Portfolio.Control.DropDown
--]]--
Portfolio.Control.DropDown = {}
--CONTROLTYPE_DROPDOWN = 2 -- Defined in UIOptionsPanel.lua
Portfolio.CONTROL_TYPES[CONTROLTYPE_DROPDOWN] = "DropDown"

--Registration
function Portfolio.Control.DropDown.Register(optionsFrame, option)
	--DropDown
	local controlName = optionsFrame:GetName()..option.id
	local control = CreateFrame("Frame", controlName, optionsFrame.scrollChild, "UIDropDownMenuTemplate")
	
	--Copy Vars
	Portfolio.CopyTableElements(control, option, "tooltipText", "callback", "headerText")
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "yOffset", -12)
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_DROPDOWN, control)
	Portfolio.PopulateValueControl(optionsFrame, option, control)
	
	-- Frame Population
	control.GetValue = Portfolio.Control.GetValue
	control.SetValue = Portfolio.Control.SetValue
	control.GetValueInfo = Portfolio.Control.DropDown.GetValueInfo
	control.Update = Portfolio.Control.Update
	control.SetText = Portfolio.Control.SetText
	control.UpdateText = Portfolio.Control.DropDown.UpdateText
	control.SetHeaderText = Portfolio.Control.SetHeaderText
	control.UpdateHeaderText = Portfolio.Control.UpdateHeaderText
	
	--control.currValue = "1"
	--control.value = "1"
	--control.dependentControls = {}
	--self.uvar = option.id (Global Var)
	
	local button = _G[controlName.."Button"]
	button:SetScript("OnEnter", Portfolio.Control.DropDown.OnEnter)
	button:SetScript("OnLeave", Portfolio.Control.OnLeave)
	button:SetScript("OnClick", Portfolio.Control.DropDown.OnClick)
	
	control.initialize = Portfolio.Control.DropDown.initfunction
	control.rootMenuList = option.menuList
	
	if not option.nochecks then
		Portfolio.Control.DropDown.InitChecked(control)
	end
	if not option.nofuncs then
		Portfolio.Control.DropDown.InitFunc(control)
	end
	
	-- Add Description Text
	local desc = control:CreateFontString(controlName.."HeaderText", "ARTWORK", "GameFontNormalSmall")
	desc:SetPoint("BOTTOMLEFT", control, "TOPLEFT", 0, -2)
	
	--Fix textures so that control:SetWidth works
	local leftTex = _G[controlName.."Left"]
	leftTex:SetPoint("TOPLEFT", -14, 14)
	local rightTex = _G[controlName.."Right"]
	rightTex:ClearAllPoints()
	rightTex:SetPoint("TOPRIGHT", 14, 14)
	local middleTex = _G[controlName.."Middle"]
	-- already anchored to the left
	middleTex:SetPoint("RIGHT", rightTex, "LEFT", 0, 0)
	
	control.minWidth = option.minWidth or 100
	
	-- Setup Frame Text
	control:UpdateText()
	
	--control:SetValue(optionsFrame.savedVarTable[option.id])
	--control.currValue ??
	--if ( self.uvar ) then setglobal(self.uvar, value); end if ( self.setFunc ) then self.setFunc(value)

	Portfolio.InitDefaultValue(control)
	
	if type(option.init) == "function" then
		option.init(control)
	end
	
	return control
end


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[-- Update the control text from control.text.
	Also calls control:UpdateHeaderText() and updates the width of the dropdown 
	to fit the text or control.minWidth

	@name			UpdateText
	@param self		dropdown control
	@usage			control:UpdateText()
--]]--
function Portfolio.Control.DropDown.UpdateText(self)
	-- Update header text
	self:UpdateHeaderText()
	
	-- Update button text
	local text = self.text
	if text then
		text = Portfolio.Control.GetValueText(self, "text")
	else
		local info = self:GetValueInfo()
		if info then
			text = info.text
		end
	end
	if type(text) == "string" then
		_G[self:GetName().."Text"]:SetText(text)
	end
	
	-- Update the button width
	local leftTex = _G[self:GetName().."Left"]
	local middleTex = _G[self:GetName().."Middle"]
	local rightTex = _G[self:GetName().."Right"]
	local button = _G[self:GetName().."Button"]
	local fontString = _G[self:GetName().."Text"]
	
	local buttonWidth = leftTex:GetWidth() + 2  -- button offset
	local leftWidth = leftTex:GetWidth() - 14 -- texture inset
	local rightWidth = rightTex:GetWidth() - 14  -- texture inset
	local textWidth = fontString:GetStringWidth() + 43 - 14 -- text offset - texture inset
	local width = leftWidth + textWidth + rightWidth
	
	if self.minWidth and self.minWidth > width then
		self:SetWidth(self.minWidth)
		--middleTex:SetWidth(self.width - leftWidth - rightWidth)
		button:SetHitRectInsets(-self.minWidth + buttonWidth, 0, 0, 0)
	else
		self:SetWidth(width)
		--middleTex:SetWidth(textWidth)
		button:SetHitRectInsets(-width + buttonWidth, 0, 0, 0)
	end
end

--[[-- Get the first info table in the menuList with the specified value.

	@name			GetValueInfo
	@param self		dropdown control
	@param value	[optional] value, defauts to the current value
	@param menuList	(table) [optional] menu list, defauts to control.rootMenuList
	@usage			control:GetValueInfo([value[, menuList] ])
	@return			(table) dropdown button info table
--]]--
function Portfolio.Control.DropDown.GetValueInfo(self, value, menuList)
	if value == nil then
		value = self:GetValue()
	end
	if menuList == nil then
		menuList = self.rootMenuList
	end
	for i, info in ipairs(menuList) do
		if info.value == value then
			return info
		end
		if info.menuList then
			info = self:GetValueInfo(value, info.menuList)
			if info then
				return info
			end
		end
	end
end

--[[-- Recursively initialize the menuList 'checked' functions. 
	They will show a check if the value of the menuItem matches control:GetValue()
	Called on control construction.

	@param self		dropdown control
	@param menuList	(table) [optional] menu list, defauts to control.rootMenuList
	@usage			control:InitChecked([menuList])
--]]--
function Portfolio.Control.DropDown.InitChecked(self, menuList)
	if not menuList then
		menuList = self.rootMenuList
	end
	local control = self
	for i=1, #(menuList) do
		local info = menuList[i]
		if info.value ~= nil and info.checked == nil then
			info.checked = function() return control:GetValue() == info.value end
		end
		if info.menuList then
			Portfolio.Control.DropDown.InitChecked(self, info.menuList)
		end
	end
end

--[[-- Recursively initialize the menuList 'func' functions. 
	When the menu item is selected it will call control:SetValue(menuItem.value, true),
	and close the parent menus. Called on control construction.

	@param self		dropdown control
	@param menuList	(table) [optional] menu list, defauts to control.rootMenuList
	@usage			control:InitFunc([menuList])
--]]--
function Portfolio.Control.DropDown.InitFunc(self, menuList)
	if not menuList then
		menuList = self.rootMenuList
	end
	local control = self
	for i=1, #(menuList) do
		local info = menuList[i]
		if info.func == nil then
			info.func = Portfolio.Control.DropDown.MenuItemOnClick
		end
		if info.menuList then
			Portfolio.Control.DropDown.InitFunc(self, info.menuList)
		end
	end
end


------------------------------------------------------------------------------
--[[ Control Events ]]--
------------------------------------------------------------------------------

-- Event: DropDown Initialization
function Portfolio.Control.DropDown.initfunction(self, level, menuList)
	-- Populate dropdown from menuList
	if not level then
		level = 1
	end
	if menuList then
		for i, info in ipairs(menuList) do
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

-- Event: DropDown Menu Item OnClick (default item.func)
function Portfolio.Control.DropDown.MenuItemOnClick(menuItem, arg1, arg2, checked)
	if not checked then
		local control = UIDROPDOWNMENU_OPEN_MENU
		control:SetValue(menuItem.value, true)
	end
	-- Hide Parent Menus
	for level=UIDROPDOWNMENU_MENU_LEVEL-1, 1, -1 do
		HideDropDownMenu(level)
	end
end

-- Event: OnClick
function Portfolio.Control.DropDown.OnClick(self)
	local control = self:GetParent()
	ToggleDropDownMenu(1, nil, control, control:GetName(), 0, 0, control.rootMenuList)
	PlaySound("igMainMenuOptionCheckBoxOn")
end

-- Event: OnEnter
function Portfolio.Control.DropDown.OnEnter(self)
	local control = self:GetParent()
	local text = Portfolio.Control.GetValueText(control, "tooltipText")
	if type(text) == "string" then
		GameTooltip:SetOwner(control, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(text, nil, nil, nil, nil, 1);
	end
	-- From Blizzard code. If you want red text at the bollow just use "\n|cFF0000", imo.
	if ( control.tooltipText and control.tooltipRequirement ) then
		GameTooltip:AddLine(control.tooltipRequirement, "", 1.0, 1.0, 1.0);
		GameTooltip:Show();
	end
end
