--[[-- 
	@name			Portfolio
	@description	Interface Option Creation Utility
	@release		1.21
	@author			Karl Isenberg (AnduinLothar)
	@revision		$Id: Portfolio.lua 3705 2006-06-26 08:15:29Z karlkfi $
	@usage			local Portfolio = LibStub("Portfolio")<br/>
					<div class="p">
					<b>Dependant Usage:</b><ol>
					<li>Add Portfolio as a Required Dependency.</li>
					<li>Include Portfolio in your download<br/>
					OR link users to <a href="http://www.wowinterface.com/downloads/info11749-Portfolio.html">WoW 
					Interface</a> for downloading.</li></ol>
					<b>Embedded Usage:</b><ol>
					<li>Include Portfolio in the Libs folder of you addon: &lt;addon&gt;\Libs\Portfolio.</li>
					<li>Include  Loader.xml in your xml file with &lt;Include file="Libs\Portfolio\Loader.xml"/&gt;<br/>
					OR load Libs\Portfolio\Loader.xml from your toc file.</li>
					<li>Add Portfolio as an Optional Dependency in your toc, and as an X-Embeds.</li></ol>
					</div>
--]]--

local version = 1.21
local Portfolio, oldminor = LibStub:NewLibrary("Portfolio", version)
if not Portfolio then return end

Portfolio.version = version
Portfolio.registered = Portfolio.registered or {}

-- Loading Flags (nil so that other files will load)
Portfolio.RegisterControl = nil
Portfolio.Control = nil

------------------------------------------------------------------------------
--[[ Portfolio External - Option Set Registration ]]--
------------------------------------------------------------------------------

--[[-- Register a new set of options.
	Creates and registers the option set frame and registers all the options with 
	<a href="RegisterControl.html">RegisterControl</a>. 

	@param optionSetTable	(table) option set registration table
	@return					options frame
--]]--
function Portfolio.RegisterOptionSet(optionSetTable)
	
	--Check for duplicate set name (id)
	if (Portfolio.registered[optionSetTable.id]) then
		Portfolio.PrintError("RegisterOptionSet: Option set already exists - "..optionSetTable.id)
		return
	end
	
	--Create Control Panel Frame
	local optionsFrame, frameName = Portfolio.CreateOptionsFrame(optionSetTable)
	
	--Shortcut: Set all unassigned options' novar
	if (optionSetTable.novarDefault) then
		for i, option in next, optionSetTable.options do
			if (option.tvar == nil and option.cvar == nil and option.uvar == nil and option.novar == nil) then
				option.novar = optionSetTable.novarDefault
			end
		end
	end
	
	-- Add Header & Options
	Portfolio.PopulateOptionsFrame(optionsFrame, optionSetTable, frameName)

	--OnLoad
	--optionsFrame.options = optionSetTable
	--optionSetTable.frame = optionsFrame

	--frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	--frame:SetScript("OnEvent", BlizzardOptionsPanel_OnEvent);
	--BlizzardOptionsPanel_OnLoad(optionsFrame, okay, cancel, default, refresh)
	
	--UIDropDownMenu_SetSelectedValue(InterfaceOptionsControlsPanelAutoLootKeyDropDown, GetModifiedClick("AUTOLOOTTOGGLE"));
	--UIDropDownMenu_EnableDropDown(InterfaceOptionsControlsPanelAutoLootKeyDropDown);
	
	optionsFrame:Hide()
	
	-- Store the newly registered frame
	Portfolio.registered[optionSetTable.id] = optionsFrame
	
	InterfaceOptions_AddCategory(optionsFrame)
	
	-- If the addon name is valid, add an about page
	if (optionsFrame.addon and optionSetTable.about ~= false) then
		LibStub("InterfaceOptionAboutPanel").new(optionsFrame.name, optionsFrame.addon)
		LibStub("LibDefaults"):SetScript(optionsFrame.addon, function() 
			optionsFrame:CallCallbacks() 
		end)
	end
	
	return optionsFrame
end

------------------------------------------------------------------------------
--[[ Options Frame Functions ]]--
------------------------------------------------------------------------------

--[[-- Get the options frame by set id.

	@usage			control = optionsFrame:GetControl(optionid)
	@param setid	(string) option set id
	@return			options frame
--]]--
function Portfolio.GetOptionsFrame(setid)
	return Portfolio.registered[setid]
end

--[[-- Get the control frame by option id.

	@usage				control = optionsFrame:GetControl(optionid)
	@param optionsFrame	options frame
	@param optionid		(string) option id
	@return				control frame
--]]--
function Portfolio.GetControl(optionsFrame, optionid)
	for _, control in next, optionsFrame.controls do
		if (control.id == optionid) then
			return control
		end
	end
end

--[[-- Call Update() on all the controls.

	@usage	optionsFrame:CallCallbacks()
	@param optionsFrame	options frame
--]]--
function Portfolio.CallCallbacks(optionsFrame)
	--Portfolio.Print("CallCallbacks: "..optionsFrame.addon)
	for _, control in next, optionsFrame.controls do
		if (control.Update) then
			control:Update()
		end
	end
end


------------------------------------------------------------------------------
--[[ Portfolio Internal - Registration Support Functions ]]--
------------------------------------------------------------------------------

function Portfolio.CreateOptionsFrame(optionTable)
	
	local frameName = optionTable.id.."ControlPanel"
	local parent = InterfaceOptionsFramePanelContainer
	local optionsFrame = CreateFrame("Frame", frameName, parent)
	optionsFrame:SetPoint("TOPLEFT", parent, "TOPLEFT");
	optionsFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT");
	
	local scrollFrame = CreateFrame("ScrollFrame", frameName.."ScrollFrame", optionsFrame, "UIPanelScrollFrameTemplate")
	scrollFrame.scrollBarHideable = true
	
	scrollFrame:SetVerticalScroll(0)
	optionsFrame.UpdateBox = Portfolio.OptionSet_UpdateBox
	Portfolio.InsetScrollBar(scrollFrame)
	
	--ScrollFrame Inset
	scrollFrame:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 5, -5);
	scrollFrame:SetPoint("BOTTOMRIGHT", optionsFrame, "BOTTOMRIGHT", -5, 5);
	
	optionsFrame.scrollChild = CreateFrame("Frame", frameName.."ScrollChildFrame", scrollFrame)
	scrollFrame:SetScrollChild(optionsFrame.scrollChild)
	optionsFrame.scrollChild:SetWidth(scrollFrame:GetWidth())
	optionsFrame.scrollChild:SetHeight(scrollFrame:GetHeight())
	--optionsFrame.scrollChild:SetBackdrop(GameTooltip:GetBackdrop())
	
	optionsFrame.scrollChild.xOffsetRelative = 12
	optionsFrame.scrollChild.yOffsetRelative = 8
	
	optionsFrame.savedVarTable = optionTable.savedVarTable
	optionsFrame.id = optionTable.id
	
	-- Validate the addon name
	local addon = optionTable.addon or optionTable.id
	if (GetAddOnInfo(addon)) then
		optionsFrame.addon  = addon
	end
	
	-- Defaults to true
	optionsFrame.initCallbacks = optionTable.initCallbacks == nil and true or optionTable.initCallbacks
	
	return optionsFrame, frameName
end

function Portfolio.PopulateOptionsFrame(optionsFrame, optionTable, frameName)
	
	optionsFrame.GetControl = Portfolio.GetControl
	optionsFrame.CallCallbacks = Portfolio.CallCallbacks
	optionsFrame.RegisterControl = Portfolio.RegisterControl
	
	optionsFrame.okay = Portfolio.OptionSet_Okay;
	optionsFrame.cancel = Portfolio.OptionSet_Cancel;
	optionsFrame.default = Portfolio.OptionSet_Reset;
	optionsFrame.refresh = Portfolio.OptionSet_Refresh;
	
	optionsFrame.name = optionTable.text 
		or optionsFrame.addon and GetAddOnMetadata(optionsFrame.addon, "Title") 
		or optionTable.id
	
	--Title w/ SubText
	local header = {}
	header.type = CONTROLTYPE_HEADER
	header.id = frameName.."Title"
	header.text = optionsFrame.name
	header.subText = optionTable.subText 
		or optionsFrame.addon and GetAddOnMetadata(optionsFrame.addon, "Notes")

	optionsFrame:RegisterControl(header)
	
	--Options
	for i, option in next, optionTable.options do
		optionsFrame:RegisterControl(option)
	end
	
	--Update the scrollbar
	Portfolio.ScrollFrame_OnScrollRangeChanged(optionsFrame.scrollChild:GetParent())
end


------------------------------------------------------------------------------
--[[ Portfolio Internal - Option Set Frame Event Functions ]]--
------------------------------------------------------------------------------

function Portfolio.OptionSet_Refresh(self)
	_G[self:GetName().."ScrollFrame"]:SetVerticalScroll(0)
	Portfolio.PassThrough(self,"Refresh")
	--Portfolio.ScrollFrame_OnScrollRangeChanged(self.scrollChild:GetParent())
end

function Portfolio.OptionSet_Okay(self) Portfolio.PassThrough(self,"Okay") end
function Portfolio.OptionSet_Cancel(self) Portfolio.PassThrough(self,"Cancel") end
function Portfolio.OptionSet_Reset(self) Portfolio.PassThrough(self,"Reset") end

function Portfolio.OptionSet_UpdateBox(self) 
	self.scrollChild:SetWidth(self.scrollChild:GetParent():GetWidth())
	self.scrollChild:SetHeight(self.scrollChild:GetParent():GetHeight())
	
	Portfolio.PassThrough(self,"UpdateBox")
end


------------------------------------------------------------------------------
--[[ Support Functions ]]--
------------------------------------------------------------------------------

function Portfolio.Print(text)
	(SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):AddMessage(text)
end

function Portfolio.PrintError(text)
	(SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):AddMessage(text, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
end

function Portfolio.CopyTableElements(to, from, ...)
	for i=1, select("#", ...) do
		local key = select(i, ...)
		to[key] = from[key]
	end
end

function Portfolio.InitField(to, from, key, default)
	if from[key] ~= nil then
		to[key] = from[key]
	elseif default ~= nil then
		to[key] = default
	end
end

function Portfolio.Round(num, idp)
	local mult = 10^(idp or 0)
	return floor(num * mult + 0.5) / mult
end

function Portfolio.PassThrough(self, methodName)
	if self.controls then
		for i, control in ipairs(self.controls) do
			if control[methodName] then
				control[methodName](control)
			end
		end
	end
end

function Portfolio.InsetScrollBar(scrollFrame)
	local frameName = scrollFrame:GetName()
	local scrollbar = _G[frameName.."ScrollBar"]
	scrollbar:EnableMouseWheel(true)
	scrollbar:ClearAllPoints()
	scrollbar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 6, -22)
	scrollbar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 6, 21)
	local scrollBackdrop = {
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 12,
		insets = { left = 0, right = 0, top = 5, bottom = 5 }
	}
	local border = CreateFrame("Frame", nil, scrollbar)
	border:SetPoint("TOPLEFT", _G[frameName.."ScrollBarScrollUpButton"], -5, 5)
	border:SetPoint("BOTTOMRIGHT", _G[frameName.."ScrollBarScrollDownButton"], 5, -4)
	border:SetBackdrop(scrollBackdrop)
	border:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.5)
	
	scrollFrame:SetScript("OnScrollRangeChanged", Portfolio.ScrollFrame_OnScrollRangeChanged)
	scrollFrame:SetScript("OnShow", Portfolio.ScrollFrame_OnScrollRangeChanged)
	scrollFrame:SetScript("OnMouseWheel", Portfolio.ScrollFrameTemplate_OnMouseWheel)
	scrollbar:SetScript("OnMouseWheel", function (self, ...) Portfolio.ScrollFrameTemplate_OnMouseWheel(self:GetParent(), ...) end)
	
	--Portfolio.ScrollFrame_OnScrollRangeChanged(scrollFrame)
end

function Portfolio.ScrollFrame_OnScrollRangeChanged(self, yrange, xrange, count)
	local scrollbarName = self:GetName().."ScrollBar"
	local scrollbar = _G[scrollbarName]
	if ( not yrange ) then
		yrange = self:GetVerticalScrollRange()
	end
	local value = scrollbar:GetValue()
	if ( value > yrange ) then
		value = yrange
	end
	scrollbar:SetMinMaxValues(0, yrange)
	scrollbar:SetValue(value)
	
	local thumb = _G[scrollbarName.."ThumbTexture"]
	
	if ( floor(yrange) == 0 ) then
		if (self.scrollBarHideable ) then
			scrollbar:Hide()
			self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", -5, 5)
		else
			_G[scrollbarName.."ScrollDownButton"]:Disable()
			_G[scrollbarName.."ScrollUpButton"]:Disable()
			self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", -32, 5)
		end
		thumb:Hide()
	else
		scrollbar:Show()
		_G[scrollbarName.."ScrollDownButton"]:Enable()
		thumb:Show()
		self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", -32, 5)
	end
	self:GetParent():UpdateBox()
	
	local newYRange = self:GetVerticalScrollRange()
	local count = count or 0
	local maxResursion = 5
	if ( yrange ~= newYRange and count < maxResursion ) then
		Portfolio.ScrollFrame_OnScrollRangeChanged(self, newYRange, nil, count+1)
		return
	end
	
	if scrollbar:GetHeight() <= 24 then
		if scrollbar:GetHeight() <= 12 then
			thumb:SetHeight(6)
		else
			thumb:SetHeight(12)
		end
	else
		thumb:SetHeight(24)
	end
end

function Portfolio.ScrollFrameTemplate_OnMouseWheel(self, value, scrollBar)
	scrollBar = scrollBar or _G[self:GetName() .. "ScrollBar"]
	if scrollBar:IsShown() then
		local min, max = scrollBar:GetMinMaxValues()
		if value > 0 then
			scrollBar:SetValue(scrollBar:GetValue() - math.max(40,scrollBar:GetHeight() / 3))
		else
			scrollBar:SetValue(scrollBar:GetValue() + math.max(40,scrollBar:GetHeight() / 3))
		end
	else
		--Passthrough
		local window = self:GetParent()
		if window.optionsFrame then
			local pScrollFrame = window.optionsFrame.scrollChild:GetParent()
			pScrollFrame:GetScript("OnMouseWheel")(pScrollFrame, value)
		end
	end
end
