--[[-- Button Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.Button then return end

--[[-- Button Control Registration and Methods
	@class table
	@name Portfolio.Control.Button
--]]--
Portfolio.Control.Button = {}
CONTROLTYPE_BUTTON = 4
Portfolio.CONTROL_TYPES[CONTROLTYPE_BUTTON] = "Button"

function Portfolio.Control.Button.Register(optionsFrame, option)
	--Checkbox
	local controlName = optionsFrame:GetName()..option.id
	local control = CreateFrame("Button", controlName, optionsFrame.scrollChild, "UIPanelButtonTemplate2")
	--Portfolio.Print(controlName)
	--Copy Vars
	Portfolio.CopyTableElements(control, option, "tooltipText", "callback")
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffset")
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_BUTTON, control)
	
	-- Frame Population
	control.UpdateText = Portfolio.Control.UpdateText
	control.SetText = Portfolio.Control.SetText
	--TODO: Maybe allow the user to set a variable to update text on callback?
	-- temp fix for GetValueText called by UpdateText
	control.GetValue = function(self) return UNKNOWN end
	
	
	--Wrap Callback
	control:SetScript("OnClick", Portfolio.Control.Button.OnClick)
	
	-- Setup Frame Text
	control:UpdateText()
	
	-- Default width (override?)
	control:SetWidth(100)
	
	-- Update OnEnter to accept tooltipText as functions
	control:SetScript("OnEnter", Portfolio.Control.OnEnter)
	
	-- Button also needs OnLeave set
	control:SetScript("OnLeave", Portfolio.Control.OnLeave)
	
	--control.currValue = "1"
	--control.value = "1"
	
	if (type(option.init) == "function") then
		option.init(control)
	end
	
	return control
end


------------------------------------------------------------------------------
--[[ Control Events ]]--
------------------------------------------------------------------------------

-- Event: OnClick
function Portfolio.Control.Button.OnClick(self)
	PlaySound("gsTitleOptionOK")
	-- Safe callback with pcall
	if (self.callback) then
		local success, result = pcall( self.callback )
		if (not success) then
			-- Print out the error if there is one. Can we fake an error?
			Portfolio.PrintError(self:GetName()..".callback() Error:")
			Portfolio.PrintError(result)
		end
	end
	-- Update Text
	self:UpdateText()
end


