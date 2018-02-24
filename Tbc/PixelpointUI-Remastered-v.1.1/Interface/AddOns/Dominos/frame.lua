--[[
	Dominos Frame
		An action button frame thingy
--]]

local Dominos = Dominos


--[[ Fade Manager ]]--

local Fader = CreateFrame('Frame')
do
	Fader.nextUpdate = 0
	Fader.fs = {}

	Fader:SetScript('OnUpdate', function(self, elapsed)
		if self.nextUpdate < 0 then
			self.nextUpdate = 0.1

			for f in pairs(self.fs) do
				if self:IsFocus(f) then
					if abs(f:GetAlpha() - f:GetFadedAlpha()) < 0.01 then --the checking logic is a little weird because floating point values tend to not be exact
						self:FadeIn(f, 0.1, f:GetAlpha(), f:GetFrameAlpha())
					end
				else
					if abs(f:GetAlpha() - f:GetFrameAlpha()) < 0.01 then
						self:FadeOut(f, 0.1, f:GetAlpha(), f:GetFadedAlpha())
					end
				end
			end
		else
			self.nextUpdate = self.nextUpdate - elapsed
		end
	end)
	Fader:Hide()

	function Fader:Add(f)
		self.fs[f] = true
		if not self:IsShown() then
			self:Show()
		end
	end

	function Fader:Remove(f)
		self.fs[f] = nil
		if not next(self.fs) then
			self:Hide()
		end
	end

	-- Generic fade function, taken from UIFrameFade
	--the following code exists only so that I can prevent some basic tainting issues caused by the UIFrameFade function attempting to show frames
	local function Fade(frame, fadeInfo)
		frame:SetAlpha(fadeInfo.startAlpha)
		frame.fadeInfo = fadeInfo

		for _,f in pairs(FADEFRAMES) do
			if f == frame then
				return
			end
		end
		tinsert(FADEFRAMES, frame)
	end

	function Fader:FadeIn(frame, timeToFade, startAlpha, endAlpha)
		local fadeInfo = {}
		fadeInfo.mode = "IN"
		fadeInfo.timeToFade = timeToFade
		fadeInfo.startAlpha = startAlpha
		fadeInfo.endAlpha = endAlpha
		Fade(frame, fadeInfo)
	end

	function Fader:FadeOut(frame, timeToFade, startAlpha, endAlpha)
		local fadeInfo = {}
		fadeInfo.mode = "OUT"
		fadeInfo.timeToFade = timeToFade
		fadeInfo.startAlpha = startAlpha
		fadeInfo.endAlpha = endAlpha
		Fade(frame, fadeInfo)
	end

	--this code determins if the mouse is over either the frame itself, or any child frames
	function Fader:IsFocus(f)
		if MouseIsOver(f, 1, -1, -1, 1) then
			return GetMouseFocus() == WorldFrame or self:IsChildFocus(f:GetChildren())
		end
	end

	function Fader:IsChildFocus(...)
		for i = 1, select('#', ...) do
			if GetMouseFocus() == select(i, ...) then
				return true
			end
		end

		for i = 1, select('#', ...) do
			local f = select(i, ...)
			if f:IsShown() and self:IsChildFocus(f:GetChildren()) then
				return true
			end
		end
	end
end


--[[ Mango Frame ]]--

local Frame = Dominos:CreateClass('Frame')
Dominos.Frame = Frame

local active = {}
local unused = {}

--constructor
function Frame:New(id)
	local id = tonumber(id) or id
	local f = self:Restore(id) or self:Create(id)
	f:LoadSettings()
	f.buttons = {}

	active[id] = f
	return f
end

function Frame:Create(id)
	local f = self:Bind(CreateFrame('Frame', nil, UIParent))
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f.id = id

	f.header = CreateFrame('Frame', nil, f, 'SecureStateHeaderTemplate')
	f.header:SetAllPoints(f)

	f.drag = Dominos.DragFrame:New(f)

	return f
end

function Frame:Restore(id)
	local f = unused[id]
	if f then
		unused[id] = nil
		return f
	end
end

--destructor
function Frame:Free()
	active[self.id] = nil

	UnregisterStateDriver(self.header, 'state', 0)
	UnregisterStateDriver(self.header, 'visibility', 'show')
	Fader:Remove(self)

	for i in pairs(self.buttons) do
		self:RemoveButton(i)
	end
	self.buttons = nil

	self:ClearAllPoints()
	self:SetUserPlaced(nil)
	self.drag:Hide()
	self:Hide()

	unused[self.id] = self
end

function Frame:Delete()
	self:Free()
	Dominos:SetFrameSets(self.id, nil)
end

function Frame:LoadSettings(defaults)
	self.sets = Dominos:GetFrameSets(self.id) or Dominos:SetFrameSets(self.id, self:GetDefaults()) --get defaults must be provided by anything implementing the Frame type
	self:Reposition()

	if self.sets.hidden then
		self:HideFrame()
	else
		self:ShowFrame()
	end

	if Dominos:Locked() then
		self:Lock()
	else
		self:Unlock()
	end

	self:UpdateShowStates()
	self:UpdateAlpha()
	self:UpdateFader()
end


--[[ Layout ]]--

--this function is used in a lot of places, but never called in Frame
function Frame:LoadButtons()
	for i = 1, self:NumButtons() do
		self:AddButton(i)
	end
end

function Frame:SetNumButtons(numButtons)
	self.sets.numButtons = numButtons

	for i = #self.buttons + 1, self:NumButtons() do
		self:AddButton(i)
	end

	for i = self:NumButtons() + 1, #self.buttons do
		self:RemoveButton(i)
	end

	self:Layout()
end

function Frame:NumButtons()
	return self.sets.numButtons or 0
end

function Frame:SetColumns(columns)
	self.sets.columns = columns ~= self:NumButtons() and columns or nil
	self:Layout()
end

function Frame:NumColumns()
	return self.sets.columns or self:NumButtons()
end

function Frame:SetSpacing(spacing)
	self.sets.spacing = spacing
	self:Layout()
end

function Frame:GetSpacing()
	return self.sets.spacing or 0
end

function Frame:SetPadding(w, h)
	self.sets.padW = w
	self.sets.padH = h or w
	self:Layout()
end

function Frame:GetPadding()
	return self.sets.padW or 0, self.sets.padH or self.sets.padW or 0
end

function Frame:Layout()
	if #self.buttons > 0 then
		local cols = min(self:NumColumns(), #self.buttons)
		local rows = ceil(#self.buttons / cols)
		local pW, pH = self:GetPadding()
		local spacing = self:GetSpacing()

		local b = self.buttons[1]
		local w = b:GetWidth() + spacing
		local h = b:GetHeight() + spacing

		for i,b in pairs(self.buttons) do
			local col = (i-1) % cols
			local row = ceil(i / cols) - 1
			b:ClearAllPoints()
			b:SetPoint('TOPLEFT', w*col + pW, -(h*row + pH))
		end

		self:SetWidth(w*cols - spacing + pW*2)
		self:SetHeight(h*ceil(#self.buttons/cols) - spacing + pH*2)
	else
		self:SetWidth(30) self:SetHeight(30)
	end
end


--[[ Scaling ]]--

function Frame:GetScaledCoords(scale)
	local ratio = self:GetScale() / scale
	return (self:GetLeft() or 0) * ratio, (self:GetTop() or 0) * ratio
end

function Frame:SetFrameScale(scale, scaleAnchored)
	local x, y =  self:GetScaledCoords(scale)

	self.sets.scale = scale
	self:Rescale()

	if not self.sets.anchor then
		self:ClearAllPoints()
		self:SetPoint('TOPLEFT', self:GetParent(), 'BOTTOMLEFT', x, y)
		self:SavePosition()
	end

	if scaleAnchored then
		for _,f in self:GetAll() do
			if f:GetAnchor() == self then
				f:SetFrameScale(scale, true)
			end
		end
	end
end

function Frame:Rescale()
	self:SetScale(self:GetScale())
	self.drag:SetScale(self:GetScale())
end

function Frame:GetScale()
	return self.sets.scale or 1
end


--[[ Opacity ]]--

function Frame:UpdateAlpha()
	local alpha
	if MouseIsOver(self, 1, -1, -1, 1) then
		alpha = self:GetFrameAlpha()
	else
		alpha = self:GetFadedAlpha()
	end
	self:SetAlpha(alpha)
end

function Frame:SetFrameAlpha(alpha)
	if alpha == 1 then
		self.sets.alpha = nil
	else
		self.sets.alpha = alpha
	end
	self:UpdateAlpha()
end

function Frame:GetFrameAlpha()
	return self.sets.alpha or 1
end

--faded opacity (mouse not over the f)
function Frame:SetFadeAlpha(alpha)
	local alpha = alpha or 1
	if alpha == 1 then
		self.sets.fadeAlpha = nil
	else
		self.sets.fadeAlpha = alpha
	end

	self:UpdateAlpha()
	self:UpdateFader()
end

--returns fadedOpacity, fadePercentage
--fadedOpacity is what opacity the f will be at when faded
--fadedPercentage is what modifier we use on normal opacity
function Frame:GetFadedAlpha(alpha)
	local fadeAlpha = self.sets.fadeAlpha or 1
	return fadeAlpha * self:GetFrameAlpha(), fadeAlpha
end


--[[ Visibility ]]--

function Frame:ShowFrame()
	self.sets.hidden = nil
	self:Show()
	self:UpdateFader()
	self.drag:UpdateColor()
end

function Frame:HideFrame()
	self.sets.hidden = true
	self:Hide()
	self:UpdateFader()
	self.drag:UpdateColor()
end

function Frame:ToggleFrame()
	if self:FrameIsShown() then
		self:HideFrame()
	else
		self:ShowFrame()
	end
end

function Frame:FrameIsShown()
	return not self.sets.hidden
end


--[[ ShowStates ]]--

function Frame:SetShowStates(states)
	self.sets.showstates = states
	self:UpdateShowStates()
end

function Frame:GetShowStates()
	return self.sets.showstates
end

function Frame:UpdateShowStates()
	UnregisterStateDriver(self.header, 'visibility', 'show')
	self.header:Show()

	local showstates = self:GetShowStates()
	if showstates then
		RegisterStateDriver(self.header, 'visibility', showstates .. 'show;hide')
	end
end


--[[ Lock/Unlock ]]--

function Frame:Lock()
	self.drag:Hide()
end

function Frame:Unlock()
	self.drag:Show()
end


--[[ Sticky Bars ]]--

Frame.stickyTolerance = 16

function Frame:StickToEdge()
	local point, x, y = self:GetRelPosition()
	local s = self:GetScale()
	local w = self:GetParent():GetWidth()/s
	local h = self:GetParent():GetHeight()/s
	local rTolerance = self.stickyTolerance/s
	local changed = false

	--sticky edges
	if abs(x) <= rTolerance then
		x = 0
		changed = true
	end

	if abs(y) <= rTolerance then
		y = 0
		changed = true
	end

	-- auto centering
	local cX, cY = self:GetCenter()
	if y == 0 then
		if abs(cX - w/2) <= rTolerance*2 then
			if point == 'TOPLEFT' or point == 'TOPRIGHT' then
				point = 'TOP'
			else
				point = 'BOTTOM'
			end

			x = 0
			changed = true
		end
	elseif x == 0 then
		if abs(cY - h/2) <= rTolerance*2 then
			if point == 'TOPLEFT' or point == 'BOTTOMLEFT' then
				point = 'LEFT'
			else
				point = 'RIGHT'
			end

			y = 0
			changed = true
		end
	end

	--save this junk if we've done something
	if changed then
		self.sets.point = point
		self.sets.x = x
		self.sets.y = y

		self:ClearAllPoints()
		self:SetPoint(point, x, y)
	end
end

function Frame:Stick()
	self.sets.anchor = nil

	--only do sticky code if the alt key is not currently down
	if not IsAltKeyDown() then
		--try to stick to a bar, then try to stick to a screen edge
		for _, f in self:GetAll() do
			if f ~= self then
				local point = FlyPaper.Stick(self, f, self.stickyTolerance)
				if point then
					self.sets.anchor = f.id .. point
					break
				end
			end
		end

		if not self.sets.anchor then
			self:StickToEdge()
		end
	end

	self:SavePosition()
	self.drag:UpdateColor()
end

function Frame:Reanchor()
	local f, point = self:GetAnchor()

	if not(f and FlyPaper.StickToPoint(self, f, point)) then
		self.sets.anchor = nil

		if not self:Reposition() then
			self:ClearAllPoints()
			self:SetPoint('CENTER')
		end
	end
	self.drag:UpdateColor()
end

function Frame:GetAnchor()
	local anchorString = self.sets.anchor
	if anchorString then
		local pointStart = #anchorString - 1
		return self:Get(anchorString:sub(1, pointStart - 1)), anchorString:sub(pointStart)
	end
end


--[[ Positioning ]]--

function Frame:GetRelPosition()
	local parent = self:GetParent()
	local w, h = parent:GetWidth(), parent:GetHeight()
	local x, y = self:GetCenter()
	local s = self:GetScale()
	w = w/s h = h/s

	local dx, dy
	local hHalf = (x > w/2) and 'RIGHT' or 'LEFT'
	if hHalf == 'RIGHT' then
		dx = self:GetRight() - w
	else
		dx = self:GetLeft()
	end

	local vHalf = (y > h/2) and 'TOP' or 'BOTTOM'
	if vHalf == 'TOP' then
		dy = self:GetTop() - h
	else
		dy = self:GetBottom()
	end

	return vHalf..hHalf, dx, dy
end

function Frame:SavePosition()
	local point, x, y = self:GetRelPosition()
	local sets = self.sets

	sets.point = point
	sets.x = x
	sets.y = y
end

--place the frame at it's saved position
function Frame:Reposition()
	self:Rescale()

	local sets = self.sets
	local point, x, y = sets.point, sets.x, sets.y

	if point then
		self:ClearAllPoints()
		self:SetPoint(point, x, y)
		self:SetUserPlaced(true)
		return true
	end
end

function Frame:SetFramePoint(...)
	self:ClearAllPoints()
	self:SetPoint(...)
	self:SavePosition()
end


--[[ Menus ]]--

function Frame:CreateMenu()
	self.menu = Dominos:NewMenu(self.id)
	self.menu:AddLayoutPanel()
end

function Frame:ShowMenu()
	if not self.menu then
		self:CreateMenu()
	end

	local menu = self.menu
	if menu then
		menu:Hide()
		menu:SetOwner(self)
		menu:ShowPanel(LibStub('AceLocale-3.0'):GetLocale('Dominos-Config').Layout)
		menu:Show()
	end
end


--[[ Utility ]]--

--run the fade onupdate checker if only if there are mouseover fs to check
function Frame:UpdateFader()
	if self.sets.hidden then
		Fader:Remove(self)
	else
		if select(2, self:GetFadedAlpha()) == 1 then
			Fader:Remove(self)
		else
			Fader:Add(self)
		end
	end
end


--[[ Metafunctions ]]--

function Frame:Get(id)
	return active[tonumber(id) or id]
end

function Frame:GetAll()
	return pairs(active)
end

function Frame:ForAll(method, ...)
	for _,f in self:GetAll() do
		local action = f[method]
		if action then
			action(f, ...)
		end
	end
end

--takes a fID, and performs the specified action on that f
--this adds two special IDs, 'all' for all fs and number-number for a range of IDs
function Frame:ForFrame(id, method, ...)
	if id == 'all' then
		self:ForAll(method, ...)
	else
		local startID, endID = tostring(id):match('(%d+)-(%d+)')
		startID = tonumber(startID)
		endID = tonumber(endID)

		if startID and endID then
			if startID > endID then
				local t = startID
				startID = endID
				endID = t
			end

			for i = startID, endID do
				local f = self:Get(i)
				if f then
					local action = f[method]
					if action then
						action(f, ...)
					end
				end
			end
		else
			local f = self:Get(id)
			if f then
				local action = f[method]
				if action then
					action(f, ...)
				end
			end
		end
	end
end