--[[-- Text Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.Text then return end

--[[-- Text Control Registration and Methods
	@class table
	@name Portfolio.Control.Text
--]]--
Portfolio.Control.Text = {}
CONTROLTYPE_TEXT = 6
Portfolio.CONTROL_TYPES[CONTROLTYPE_TEXT] = "Text"

--Registration
function Portfolio.Control.Text.Register(optionsFrame, option)
	-- Text
	local controlName = optionsFrame:GetName()..option.id
	
	local control = optionsFrame.scrollChild:CreateFontString(controlName, "ARTWORK", "GameFontHighlightSmall")
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffset")
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_TEXT, control)
	
	control:SetPoint("RIGHT", -32, 0)
	control:SetHeight(32) -- Default height placeholder
	control:SetText(option.text)
	control:SetJustifyH("LEFT")
	control:SetJustifyV("TOP")
	control:SetNonSpaceWrap(true)
	
	-- Voodoo to get the right width
	control.UpdateBox = Portfolio.Control.UpdateBox
	control.Refresh = Portfolio.Control.Text.Refresh
	
	if (type(option.init) == "function") then
		option.init(control)
	end
	
	return control
end


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[-- Updates the Text Wrap

	@name			Refresh
	@param self		control
	@usage			control:Refresh()
--]]--
function Portfolio.Control.Text.Refresh(self)
	self:UpdateBox()
end
