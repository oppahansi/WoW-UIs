----------------------------
-- Draggable Frame
----------------------------

function FluidFrames.InitDraggableFrame()
	if (FluidFrames.DragFrame) then
		return
	end
	
	local dragFrame = CreateFrame("Frame", "FluidFrame", UIParent)
	dragFrame:Hide()
	dragFrame:SetToplevel(1)
	dragFrame:SetFrameStrata("TOOLTIP")
	dragFrame:SetResizable(1)
	dragFrame:SetMovable(1)
	dragFrame:EnableMouse("LeftButton")
	dragFrame:SetAlpha(0.25)

	dragFrame:SetScript("OnMouseDown", FluidFrames.StartMoving)
	dragFrame:SetScript("OnMouseUp", FluidFrames.StopDragFrameMovingOrSizing)
	dragFrame:SetScript("OnUpdate", FluidFrames.OnUpdate)
	
	local minsize = 10
	
	FluidFrames.DragFrame = dragFrame
	
	--dragFrame:CreateTitleRegion():SetAllPoints(dragFrame)
	--Frame:GetTitleRegion()
	
	local red = 0
	local green = 0.2
	local blue = 0.7
	-- Don't make bigger than the UIParent?
	dragFrame:SetMinResize(minsize, minsize)
	--dragFrame:SetMaxResize()
	
	local background = dragFrame:CreateTexture("FluidFrameBackground", "BACKGROUND")
	background:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	background:SetVertexColor(red, green, blue)
	background:SetPoint("TOP", 0, -2)
	background:SetPoint("BOTTOM", 0, 1)
	background:SetPoint("LEFT", 1, 0)
	background:SetPoint("RIGHT", -1, 0)
	
	local ResizeTopLeft = CreateFrame("Button", "FluidFrameResizeTopLeft", dragFrame)
	--ResizeTopLeft:SetFrameLevel(ResizeTopLeft:GetFrameLevel()-1)
	ResizeTopLeft:SetHeight(16)
	ResizeTopLeft:SetWidth(16)
	ResizeTopLeft:SetPoint("TOPLEFT", -2, 2)
	local rtlTexture = ResizeTopLeft:CreateTexture("FluidFramertlTexture", "BACKGROUND")
	rtlTexture:SetVertexColor(red, green, blue)
	rtlTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rtlTexture:SetAllPoints(ResizeTopLeft) --TOPLEFT 16/16?
	rtlTexture:SetTexCoord(0, 0.25, 0, 0.125)
	ResizeTopLeft:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "TOPLEFT") end)
	ResizeTopLeft:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeTopLeft:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rtlTexture) end)
	ResizeTopLeft:SetScript("OnLeave", function() rtlTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeTopRight = CreateFrame("Button", "FluidFrameResizeTopRight", dragFrame)
	--ResizeTopRight:SetFrameLevel(ResizeTopRight:GetFrameLevel()-1)
	ResizeTopRight:SetHeight(16)
	ResizeTopRight:SetWidth(16)
	ResizeTopRight:SetPoint("TOPRIGHT", 2, 2)
	local rtrTexture = ResizeTopRight:CreateTexture("FluidFramertrTexture", "BACKGROUND")
	rtrTexture:SetVertexColor(red, green, blue)
	rtrTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rtrTexture:SetAllPoints(ResizeTopRight) --TOPRIGHT 16/16?
	rtrTexture:SetTexCoord(0.75, 1.0, 0, 0.125)
	ResizeTopRight:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "TOPRIGHT") end)
	ResizeTopRight:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeTopRight:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rtrTexture) end)
	ResizeTopRight:SetScript("OnLeave", function() rtrTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeBottomLeft = CreateFrame("Button", "FluidFrameResizeBottomLeft", dragFrame)
	--ResizeBottomLeft:SetFrameLevel(ResizeBottomLeft:GetFrameLevel()-1)
	ResizeBottomLeft:SetHeight(16)
	ResizeBottomLeft:SetWidth(16)
	ResizeBottomLeft:SetPoint("BOTTOMLEFT", -2, -3)
	local rblTexture = ResizeBottomLeft:CreateTexture("FluidFramerblTexture", "BACKGROUND")
	rblTexture:SetVertexColor(red, green, blue)
	rblTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rblTexture:SetAllPoints(ResizeBottomLeft) --TOPLEFT 16/16?
	rblTexture:SetTexCoord(0, 0.25, 0.7265625, 0.8515625)
	ResizeBottomLeft:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "BOTTOMLEFT") end)
	ResizeBottomLeft:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeBottomLeft:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rblTexture) end)
	ResizeBottomLeft:SetScript("OnLeave", function() rblTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeBottomRight = CreateFrame("Button", "FluidFrameResizeBottomRight", dragFrame)
	--ResizeBottomRight:SetFrameLevel(ResizeBottomRight:GetFrameLevel()-1)
	ResizeBottomRight:SetHeight(16)
	ResizeBottomRight:SetWidth(16)
	ResizeBottomRight:SetPoint("BOTTOMRIGHT", 2, -3)
	local rbrTexture = ResizeBottomRight:CreateTexture("FluidFramerbrTexture", "BACKGROUND")
	rbrTexture:SetVertexColor(red, green, blue)
	rbrTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rbrTexture:SetAllPoints(ResizeBottomRight) --BOTTOMRIGHT 16/16?
	rbrTexture:SetTexCoord(0.75, 1.0, 0.7265625, 0.8515625)
	ResizeBottomRight:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "BOTTOMRIGHT") end)
	ResizeBottomRight:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeBottomRight:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rbrTexture) end)
	ResizeBottomRight:SetScript("OnLeave", function() rbrTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeTop = CreateFrame("Button", "FluidFrameResizeTop", dragFrame)
	--ResizeTop:SetFrameLevel(ResizeTop:GetFrameLevel()-1)
	ResizeTop:SetHeight(16)
	ResizeTop:SetWidth(16)
	ResizeTop:SetPoint("LEFT", ResizeTopLeft, "RIGHT", 0, 0)
	ResizeTop:SetPoint("RIGHT", ResizeTopRight, "LEFT", 0, 0)
	local rtTexture = ResizeTop:CreateTexture("FluidFramertTexture", "BACKGROUND")
	rtTexture:SetVertexColor(red, green, blue)
	rtTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rtTexture:SetAllPoints(ResizeTop)
	rtTexture:SetTexCoord(0.25, 0.75, 0, 0.125)
	ResizeTop:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "TOP") end)
	ResizeTop:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeTop:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rtTexture) end)
	ResizeTop:SetScript("OnLeave", function() rtTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeBottom = CreateFrame("Button", "FluidFrameResizeBottom", dragFrame)
	--ResizeBottom:SetFrameLevel(ResizeBottom:GetFrameLevel()-1)
	ResizeBottom:SetHeight(16)
	ResizeBottom:SetWidth(16)
	ResizeBottom:SetPoint("LEFT", ResizeBottomLeft, "RIGHT", 0, 0)
	ResizeBottom:SetPoint("RIGHT", ResizeBottomRight, "LEFT", 0, 0)
	local rbTexture = ResizeBottom:CreateTexture("FluidFramerbTexture", "BACKGROUND")
	rbTexture:SetVertexColor(red, green, blue)
	rbTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rbTexture:SetAllPoints(ResizeBottom) --TOPLEFT 16/16?
	rbTexture:SetTexCoord(0.25, 0.75, 0.7265625, 0.8515625)
	ResizeBottom:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "BOTTOM") end)
	ResizeBottom:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeBottom:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rbTexture) end)
	ResizeBottom:SetScript("OnLeave", function() rbTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeLeft = CreateFrame("Button", "FluidFrameResizeLeft", dragFrame)
	--ResizeLeft:SetFrameLevel(ResizeLeft:GetFrameLevel()-1)
	ResizeLeft:SetHeight(16)
	ResizeLeft:SetWidth(16)
	ResizeLeft:SetPoint("TOP", ResizeTopLeft, "BOTTOM", 0, 0)
	ResizeLeft:SetPoint("BOTTOM", ResizeBottomLeft, "TOP", 0, 0)
	local rbTexture = ResizeLeft:CreateTexture("FluidFramerbTexture", "BACKGROUND")
	rbTexture:SetVertexColor(red, green, blue)
	rbTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rbTexture:SetAllPoints(ResizeLeft)
	rbTexture:SetTexCoord(0, 0.25, 0.125, 0.7265625)
	ResizeLeft:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "LEFT") end)
	ResizeLeft:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeLeft:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rbTexture) end)
	ResizeLeft:SetScript("OnLeave", function() rbTexture:SetVertexColor(red, green, blue) end)
	
	local ResizeRight = CreateFrame("Button", "FluidFrameResizeRight", dragFrame)
	--ResizeRight:SetFrameLevel(ResizeRight:GetFrameLevel()-1)
	ResizeRight:SetHeight(16)
	ResizeRight:SetWidth(16)
	ResizeRight:SetPoint("TOP", ResizeTopRight, "BOTTOM", 0, 0)
	ResizeRight:SetPoint("BOTTOM", ResizeBottomRight, "TOP", 0, 0)
	local rrTexture = ResizeRight:CreateTexture("FluidFramerrTexture", "BACKGROUND")
	rrTexture:SetVertexColor(red, green, blue)
	rrTexture:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
	rrTexture:SetAllPoints(ResizeRight)
	rrTexture:SetTexCoord(0.75, 1.0, 0.125, 0.7265625)
	ResizeRight:SetScript("OnMouseDown", function(self, button) FluidFrames.StartParentResizing(self, button, "RIGHT") end)
	ResizeRight:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	ResizeRight:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(rrTexture) end)
	ResizeRight:SetScript("OnLeave", function() rrTexture:SetVertexColor(red, green, blue) end)
	
	local Scale = CreateFrame("Button", "FluidFrameRescale", dragFrame)
	Scale:SetFrameLevel(Scale:GetFrameLevel()+1)
	Scale:SetHeight(20)
	Scale:SetWidth(20)
	Scale:SetPoint("BOTTOMRIGHT", 20, -20)
	local sTexture = Scale:CreateTexture("FluidFrameRescaleTexture", "BACKGROUND")
	sTexture:SetVertexColor(red, green, blue)
	sTexture:SetTexture("Interface\\AddOns\\FluidFrames\\Skin\\Rescale")
	sTexture:SetAllPoints(Scale)
	Scale:SetScript("OnMouseDown", FluidFrames.StartParentRescaling)
	Scale:SetScript("OnMouseUp", FluidFrames.StopParentMovingOrSizing)
	Scale:SetScript("OnEnter", function() FluidFrames.SetColorHighlight(sTexture) end)
	Scale:SetScript("OnLeave", function() sTexture:SetVertexColor(red, green, blue) end)
	
	local HideButton = CreateFrame("Button", "FluidFrameHideButton", dragFrame, "UIPanelButtonTemplate2")
	HideButton:SetText(HIDE)
	HideButton:SetPoint("BOTTOM", dragFrame, "TOP", 10, 0)
	HideButton:SetScript("OnClick", FluidFrames.HideButton_OnClick)
	HideButton:SetClampedToScreen(1)
end

function FluidFrames.SetColorHighlight(frame)
	if (IsShiftKeyDown()) then
		frame:SetVertexColor(1, 0.82, 0)
	end
end

function FluidFrames.HideButton_OnClick(self)
	if (FluidFrames.DragFrame.frame.FFHidden) then
		FluidFrames.UnlockHiddenFrame(FluidFrames.DragFrame.frame)
		self:SetText(HIDE)
	else
		FluidFrames.StoreFrameDefault(FluidFrames.DragFrame.frame)
		FluidFrames.LockHiddenFrame(FluidFrames.DragFrame.frame)
		self:SetText(SHOW)
	end
end

function FluidFrames.StartParentResizing(self, button, anchorPoint)
	local frame = self:GetParent()
	if (frame.isLocked) then
		return
	end
	if (frame:IsProtected() and InCombatLockdown()) then
		FluidFrames.Print(format(FLUIDFRAMES_CANT_RESIZE_IN_COMBAT, frame:GetName()))
		return
	elseif (button == "RightButton") then
		FluidFrames.ResetFrame(frame.frame)
	elseif (IsShiftKeyDown()) then
		FluidFrames.StoreFrameDefault(frame.frame, true, true)
		FluidFrames.Mobilize(frame.frame)
		FluidFrames.FreeFrameFromParent(frame.frame)
		frame.isResizing = true
		frame:StartSizing(anchorPoint)
	else
		FluidFrames.StoreFrameDefault(frame.frame)
		FluidFrames.Mobilize(frame.frame)
		FluidFrames.FreeFrameFromParent(frame.frame)
		frame:StartMoving()
		frame.isMoving = true
	end
end

function FluidFrames.StartMoving(self, button)
	if (self.frame:IsProtected() and InCombatLockdown()) then
		FluidFrames.Print(format(FLUIDFRAMES_CANT_MOVE_IN_COMBAT, self.frame:GetName()))
		return
	elseif (button == "RightButton") then
		FluidFrames.ResetFrame(self.frame)
	elseif (not self.isLocked) then
		FluidFrames.StoreFrameDefault(self.frame)
		FluidFrames.Mobilize(self.frame)
		FluidFrames.FreeFrameFromParent(self.frame)
		self:StartMoving()
		self.isMoving = true
	end
end

function FluidFrames.StartParentRescaling(self, button)
	local frame = self:GetParent()
	if (frame:IsProtected() and InCombatLockdown()) then
		FluidFrames.Print(format(FLUIDFRAMES_CANT_RESCALE_IN_COMBAT, frame:GetName()))
		return
	elseif (button == "RightButton") then
		FluidFrames.ResetFrame(frame.frame)
	elseif (IsShiftKeyDown()) then
		if (not frame.isLocked) then
			FluidFrames.StoreFrameDefault(frame.frame, true)
			FluidFrames.Mobilize(frame.frame)
			FluidFrames.FreeFrameFromParent(frame.frame)
			frame.isRescaling = true
		end
	else
		FluidFrames.StoreFrameDefault(frame.frame)
		FluidFrames.Mobilize(frame.frame)
		FluidFrames.FreeFrameFromParent(frame.frame)
		frame:StartMoving()
		frame.isMoving = true
	end
end

function FluidFrames.StopParentMovingOrSizing(self)
	if (button ~= "RightButton") then
		local frame = self:GetParent()
		frame:StopMovingOrSizing()
		if (frame.isRescaling or frame.isResizing or frame.isMoving) then
			local storeScale = frame.isRescaling or frame.isResizing
			local storeDimentions = frame.isResizing
			frame.isMoving = nil
			frame.isResizing = nil
			frame.isRescaling = nil
			FluidFrames.ImmobilizeAndStoreDimentions(frame.frame, storeScale, storeDimentions)
		end
	end
end

function FluidFrames.StopDragFrameMovingOrSizing(self)
	if (button ~= "RightButton") then
		self:StopMovingOrSizing()
		local storeScale = self.isRescaling or self.isResizing
		local storeDimentions = self.isResizing
		self.isMoving = nil
		self.isResizing = nil
		self.isRescaling = nil
		FluidFrames.ImmobilizeAndStoreDimentions(self.frame, storeScale, storeDimentions)
	end
end

--/z FluidFrames.StartFrameResize(FriendsFrame)
function FluidFrames.StartFrameResize(frame)
	if (not frame) then
		return
	elseif (frame:IsProtected() and InCombatLockdown()) then
		FluidFrames.Print(format(FLUIDFRAMES_CANT_RESIZE_IN_COMBAT, frame:GetName()))
		return
	end
	FluidFrames.InitDraggableFrame()
	local dragFrame = FluidFrames.DragFrame
	
	FluidFrames.Print(format(FLUIDFRAMES_START_RESIZE, FluidFrames.OrNil(frame:GetName())))
	
	dragFrame:SetWidth(frame:GetWidth())
	dragFrame:SetHeight(frame:GetHeight())
	local left = frame:GetLeft()
	local bottom = frame:GetBottom()
	dragFrame:ClearAllPoints()
	dragFrame:SetPoint("BOTTOMLEFT", left, bottom)
	frame:SetUserPlaced(nil)
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
	frame:SetUserPlaced(1)
	dragFrame.frame = frame
	dragFrame:Show()
end

function FluidFrames.EndResizeFrame(frame)
	if (not frame) then
		return
	end
	local dragFrame = FluidFrames.DragFrame
	
	FluidFrames.Print(format(FLUIDFRAMES_STOP_RESIZE, FluidFrames.OrNil(frame:GetName())))
	
	dragFrame.frame = nil
	dragFrame:Hide()
end

function FluidFrames.OnUpdate(self, delay) 
	if (self.frame and (self.isResizing or self.isMoving or self.isRescaling)) then
		if (not this.count) then
			self.count = delay
		elseif (this.count < .02) then
			self.count = self.count + delay
		
		elseif (this.isRescaling) then
			this.count = 0
			local frame = self.frame
			
			local x, y = GetCursorPosition()
			local UIScale = UIParent:GetEffectiveScale()
			local currScale = self:GetEffectiveScale()
			x = x / currScale - 10 / currScale
			y = y / currScale + 10 / currScale
			local left = self:GetLeft()
			local top = self:GetTop()
			local wScale = (x-left)/self:GetWidth() 
			local hScale = (top-y)/self:GetHeight()
			local scale = max(min(max(wScale, hScale), 1.2), 0.8)
			
			if (scale < 1 and currScale < 0.1) then
				return
			end
			
			FluidFrames.RelativelyScaleFrame(this, scale)
			FluidFrames.RelativelyScaleFrame(frame, scale)
			
			local xOffset = left/scale
			local yOffset = top/scale - this:GetHeight()
			
			frame:SetUserPlaced(nil)
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", xOffset, yOffset)
			frame:SetUserPlaced(1)
			
			self:ClearAllPoints()
			self:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", xOffset, yOffset)
			
		else
			self.count = 0
			local frame = self.frame
			
			if (this.isResizing) then
				local wScale = self:GetWidth()/frame:GetWidth()
				if (frame.MFwScale) then
					frame.MFwScale = frame.MFwScale * wScale
				else
					frame.MFwScale = wScale
				end
				local hScale = self:GetHeight()/frame:GetHeight()
				if (frame.MFhScale) then
					frame.MFhScale = frame.MFhScale * hScale
				else
					frame.MFhScale = hScale
				end
				
				FluidFrames.RescaleFrame(frame, wScale, hScale, not IsAltKeyDown())
			end
			
			frame:SetUserPlaced(nil)
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self:GetLeft(), self:GetBottom())
			frame:SetUserPlaced(1)
			
		end
	end
end

----------------------------
-- OnLoad Inits
----------------------------
FluidFrames.InitDraggableFrame()
