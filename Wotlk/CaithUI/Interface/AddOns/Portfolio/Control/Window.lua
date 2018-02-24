--[[-- Window Control Registration and Methods
<br/>A window acts as a bordered frame within the parent window/page. 
<br/>It defaults to 200px height and almost as wide as the parent window/page.
<br/>It will add a scrollbar if there are enough child controls.
<br/>PassThrough Methods called on the window are called on all the children that have that method.
--]]--

local Portfolio = LibStub("Portfolio")
if Portfolio.Control.Window then return end

--[[-- Window Control Registration and Methods
	@class table
	@name Portfolio.Control.Window
--]]--
Portfolio.Control.Window = {}
CONTROLTYPE_WINDOW = 8
Portfolio.CONTROL_TYPES[CONTROLTYPE_WINDOW] = "Window"

function Portfolio.Control.Window.Register(optionsFrame, option)
	--Checkbox
	local controlName = optionsFrame:GetName()..option.id
	local parent = optionsFrame.scrollChild
	local control = CreateFrame("Frame", controlName, parent)
	--optionsFrame:SetPoint("TOPLEFT", parent, "TOPLEFT");
	--optionsFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT");
	
	local scrollFrame = CreateFrame("ScrollFrame", controlName.."ScrollFrame", control, "UIPanelScrollFrameTemplate")
	scrollFrame.scrollBarHideable = true
	
	Portfolio.InitField(control, option, "xOffset")
	Portfolio.InitField(control, option, "yOffset")
	Portfolio.InitField(control, option, "xOffsetRelative")
	Portfolio.InitField(control, option, "yOffsetRelative")
	
	Portfolio.InitField(control, option, "width")
	Portfolio.InitField(control, option, "height", 200)
	
	control:SetWidth(control.width or parent:GetWidth()-parent.xOffsetRelative*2-(control.xOffset and control.xOffset*2 or 0))
	control:SetHeight(control.height)
	
	--ScrollFrame Inset
	scrollFrame:SetPoint("TOPLEFT", control, "TOPLEFT", 5, -5)
	scrollFrame:SetPoint("BOTTOMRIGHT", control, "BOTTOMRIGHT", -5, 5)
	
	control.scrollChild = CreateFrame("Frame", controlName.."ScrollChildFrame", scrollFrame)
	scrollFrame:SetScrollChild(control.scrollChild)
	--control.scrollChild:SetBackdrop(GameTooltip:GetBackdrop())
	scrollFrame:SetVerticalScroll(0)
	
	control.scrollChild.xOffsetRelative = 4
	control.scrollChild.yOffsetRelative = 4
	
	control.scrollChild:SetWidth(scrollFrame:GetWidth())
	control.scrollChild:SetHeight(scrollFrame:GetHeight()/4)
	
	local windowBackdrop  = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 3, right = 3, top = 5, bottom = 3 }
	}
	control:SetBackdrop(windowBackdrop)
	control:SetBackdropColor(0,0,0,0.25)
	
	Portfolio.PopulateCommonControl(optionsFrame, option, CONTROLTYPE_WINDOW, control)
	
	-- Frame Population
	control.UpdateText = Portfolio.Control.UpdateText
	control.SetText = Portfolio.Control.SetText
	--TODO: Maybe allow the user to set a variable to update text on callback?
	-- temp fix for GetValueText called by UpdateText
	control.GetValue = function(self) return UNKNOWN end
	
	
	control.Update = Portfolio.Control.Window.Update
	control.Disable = Portfolio.Control.Window.Disable
	control.Enable = Portfolio.Control.Window.Enable
	control.Reset = Portfolio.Control.Window.Reset
	control.Okay = Portfolio.Control.Window.Okay
	control.Cancel = Portfolio.Control.Window.Cancel
	control.Refresh = Portfolio.Control.Window.Refresh
	--control.ValueEquals = Portfolio.Control.List.ValueEquals
	control.UpdateBox = Portfolio.Control.Window.UpdateBox
	
	control.GetControl = Portfolio.GetControl
	
	control.RegisterControl = Portfolio.RegisterControl
	
	-- Default width (override?)
	--control:SetWidth(parent:GetWidth()-12*2)
	--control.scrollChild:SetWidth(scrollFrame:GetWidth())

	for i, subOption in ipairs(option.options) do
		control:RegisterControl(subOption)
	end

	Portfolio.InsetScrollBar(scrollFrame)
	
	--control:SetHeight(60)
	--control.scrollChild:SetHeight(scrollFrame:GetHeight())
	
	if (type(option.init) == "function") then
		option.init(control)
	end
	
	return control
end


--[[--  PassThrough Method. See <a href="../Control.html#Update">Control.Update</a>
	@name			Update
	@param self		control
--]]--
function Portfolio.Control.Window.Update(self) Portfolio.PassThrough(self, "Update") end

--[[--  PassThrough Method. See <a href="../Control.html#Disable">Control.Disable</a>
	@name			Disable
	@param self		control
--]]--
function Portfolio.Control.Window.Disable(self) Portfolio.PassThrough(self, "Disable") end

--[[--  PassThrough Method. See <a href="../Control.html#Enable">Control.Enable</a>
	@name			Enable
	@param self		control
--]]--
function Portfolio.Control.Window.Enable(self) Portfolio.PassThrough(self, "Enable") end

--[[--  PassThrough Method. See <a href="../Control.html#Reset">Control.Reset</a>
	@name			Reset
	@param self		control
--]]--
function Portfolio.Control.Window.Reset(self) Portfolio.PassThrough(self, "Reset") end

--[[--  PassThrough Method. See <a href="../Control.html#Okay">Control.Okay</a>
	@name			Okay
	@param self		control
--]]--
function Portfolio.Control.Window.Okay(self) Portfolio.PassThrough(self, "Okay") end

--[[--  PassThrough Method. See <a href="../Control.html#Cancel">Control.Cancel</a>
	@name			Cancel
	@param self		control
--]]--
function Portfolio.Control.Window.Cancel(self) Portfolio.PassThrough(self, "Cancel") end

--[[--  PassThrough Method. See <a href="../Control.html#Refresh">Control.Refresh</a>
	@name			Refresh
	@param self		control
--]]--
function Portfolio.Control.Window.Refresh(self) Portfolio.PassThrough(self, "Refresh") end

--function Portfolio.Control.Window.ValueEquals(self) Portfolio.PassThrough(self, "ValueEquals") end

--[[-- Update Window size based on the parent window's size.
	Called OnScrollRangeChanged of the parent window.
	PassThrough Method.
	
	@name			UpdateBox
	@param self		control
	@usage			control:UpdateBox()
--]]--
function Portfolio.Control.Window.UpdateBox(self)
	--Update Width
	local parent = self:GetParent()
	self:SetWidth(self.width or parent:GetWidth()-parent.xOffsetRelative*2-(self.xOffset and self.xOffset*2 or 0))
	self.scrollChild:SetWidth(self:GetWidth())
	self.scrollChild:SetHeight(self:GetHeight()/4)
	
	Portfolio.PassThrough(self, "UpdateBox")
end

