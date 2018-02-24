--[[-- Individual Option Registration Functions --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.RegisterControl then return end

local LibDefaults = LibStub("LibDefaults")

-- WARNING: These are globals, don't taint blizzard's
--CONTROLTYPE_HEADER = 0
--[[ Defined in UIOptionsPanel.lua
CONTROLTYPE_CHECKBOX = 1
CONTROLTYPE_DROPDOWN = 2
CONTROLTYPE_SLIDER = 3
]]--
--CONTROLTYPE_BUTTON = 4
--CONTROLTYPE_EDITBOX = 5
--CONTROLTYPE_TEXT = 6
--CONTROLTYPE_COLORPICKER = 7
--CONTROLTYPE_WINDOW = 8

------------------------------------------------------------------------------
--[[ Control Registration ]]--
------------------------------------------------------------------------------

Portfolio.CONTROL_TYPES = {}

--[[-- Register a new control and append it to the optionsFrame.
	Can be used to create options once an option set has already been registered, 
	but the preferred usage is just to register whole sets with RegisterOptionSet.
	New options will be appended to the end of the list. 
	Using either method, many of the option attributes are copied to the control 
	itself for easy access, since the option registration table itself is not saved.

	@usage				optionsFrame:RegisterControl(option)
	@param optionsFrame	options panel frame
	@param option		(table) option registration table
	@return				new control frame
--]]--
function Portfolio.RegisterControl(optionsFrame, option)
	local regFunc = Portfolio.Control[Portfolio.CONTROL_TYPES[option.type]].Register
	if regFunc then
		return regFunc(optionsFrame, option)
	else
		Portfolio.PrintError("Cannot register option \""..option.id.."\" of type "..option.type)
	end
end


------------------------------------------------------------------------------
--[[ Common Control Population Functions ]]--
------------------------------------------------------------------------------

--[[-- Control population called on all controls.

	@param optionsFrame	(frame) 
	@param option		(table) 
	@param optionType	(number) 
	@param control		(frame) 
	@usage				Portfolio.PopulateCommonControl(optionsFrame, option , optionType, control)
--]]--
function Portfolio.PopulateCommonControl(optionsFrame, option, optionType, control)

	Portfolio.CopyTableElements(control, option, "id", "text")
	
	-- Store optionsFrame
	control.optionsFrame = optionsFrame
	
	-- Store Type
	control.type = optionType
	
	-- Add the control to optionsFrame.controls and create next/prev
	-- Instead of BlizzardOptionsPanel_RegisterControl(control, optionsFrame)
	if not optionsFrame.controls then
		optionsFrame.controls = {}
	end
	local prevOption = optionsFrame.controls[#(optionsFrame.controls)]
	control.prev = prevOption
	if prevOption then prevOption.next = control end
	tinsert(optionsFrame.controls, control);
	
	-- SetPoint (Default relative to control.prev)
	control.SetRelativePoint = Portfolio.Control.SetRelativePoint
	if option.point then
		local p = option.point
		control:SetRelativePoint(p[1], p[2], p[3], p[4], p[5])
	else
		control:SetRelativePoint()
	end
end

--[[-- Additional control population for controls with values.
	(Not called on header, text or button)

	@param optionsFrame	(frame) 
	@param option		(table) 
	@param control		(frame) 
	@usage				Portfolio.PopulateValueControl(optionsFrame, option, control)
--]]--
function Portfolio.PopulateValueControl(optionsFrame, option, control)
	
	Portfolio.CopyTableElements(control, option, "defaultValue", "cvar", "event", "uvar", "tvar")
	
	-- Default tvar
	if option.varTable or optionsFrame.savedVarTable then
		if (option.tvar == nil and option.cvar == nil and option.uvar == nil and not option.novar) then
			control.tvar = option.id
		end
	end
	
	control.Disable = Portfolio.Control.Disable
	control.Enable = Portfolio.Control.Enable
	control.Reset = Portfolio.Control.Reset
	control.Okay = Portfolio.Control.Okay
	control.Cancel = Portfolio.Control.Cancel
	control.Refresh = Portfolio.Control.Refresh
	control.ValueEquals = Portfolio.Control.ValueEquals
end

--[[-- Generic Saved Var Initialization.
	Called on each control upon creation to initialize defaults with LibDefaults (or SetCVar). 

	@param control	control
	@usage			Portfolio.InitControlDefaultValue(control)
--]]--
function Portfolio.InitDefaultValue(control)
	local addonName = control.optionsFrame.addon
	
	if (control.defaultValue ~= nil and addonName) then
		if type(control.uvar) == "string" then
			LibDefaults:SetDefault(addonName, control.uvar, control.defaultValue)
		elseif type(control.tvar) == "string" then
			local varTable = control.varTable or control.optionsFrame.savedVarTable
			if type(varTable) == "string" then
				LibDefaults:SetDefault(addonName, varTable, control.tvar, control.defaultValue)
			end
		elseif type(control.cvar) == "string" then
			if GetCVar(control.cvar) == nil then
				SetCVar(control.cvar, control.defaultValue, control.event)
			end
		end
	end
end

