--[[-- Header Control Registration and Methods --]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.Header then return end

--[[-- Header Control Registration and Methods
	@class table
	@name Portfolio.Control.Header
--]]--
Portfolio.Control.Header = {}
CONTROLTYPE_HEADER = 0
Portfolio.CONTROL_TYPES[CONTROLTYPE_HEADER] = "Header"

--Registration
function Portfolio.Control.Header.Register(optionsFrame, option)
	-- Header
	local controlName = optionsFrame:GetName()..option.id
	local control = optionsFrame.scrollChild:CreateFontString(controlName, "ARTWORK", "GameFontNormalLarge")
	control.id = option.id
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffset", -16)
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_HEADER, control)
	
	control:SetPoint("RIGHT", -32, 0)
	control:SetHeight(32) -- Default height placeholder
	control:SetText(option.text)
	control:SetJustifyH("LEFT")
	control:SetJustifyV("TOP")
	control:SetNonSpaceWrap(true)
	
	-- Voodoo to get the right width
	control.UpdateBox = Portfolio.Control.UpdateBox
	control.Refresh = Portfolio.Control.Header.Refresh
	
	-- Optional SubText
	if (option.subText) then
		local subText = { id = option.id.."SubText", text = option.subText }
		local subTextControl = Portfolio.Control.Text.Register(optionsFrame, subText)
		
		if (type(option.init) == "function") then
			option.init(control, subTextControl)
		end
		
		return subTextControl
	end
	
	if (type(option.init) == "function") then
		option.init(control)
	end
	
	return control
end


------------------------------------------------------------------------------
--[[ Control Methods ]]--
------------------------------------------------------------------------------

--[[-- Update the Text Wrap

	@name			Refresh
	@param self		control
	@usage			control:Refresh()
--]]--
function Portfolio.Control.Header.Refresh(self)
	self:UpdateBox()
end

