----------------------------
-- Frame Stack Code
----------------------------

FluidFrames.FrameStack = {}
FluidFrames.ExcludedFrames = {
	WorldFrame = true,
	UIParent = true,
	
	MainMenuBarArtFrame = true,
	MainMenuBarOverlayFrame = true,
	TargetFrameTextureFrame = true,
	LFGWizardFrame = true,
	FriendsListFrame = true,
}
for i=1, NUM_CONTAINER_FRAMES do
	FluidFrames.ExcludedFrames["ContainerFrame"..i] = true
end

function FluidFrames.IsChildFrame(frame, child)
	if (not frame or not child) then
		return
	end
	while (child ~= frame) do
		child = child:GetParent()
		if (not child) then
			return false
		end
	end
	return true
end

function FluidFrames.BuildCursorFrameStack()
	local stack = FluidFrames.FrameStack
	
	--Empty Stack
	local stackSize = #stack
	while (stackSize > 0) do
		tremove(stack, #stack)
		stackSize = #stack
	end
	
	local frame = EnumerateFrames()
	while (frame) do
		local frameName = frame.GetName and frame:GetName()
		if (frame:IsVisible() 
				and (not frameName or not FluidFrames.ExcludedFrames[frameName])
				and MouseIsOver(frame)
				and not FluidFrames.IsChildFrame(FluidFrames.DragFrame, frame)
			) then
			tinsert(stack, frame)
		end
		frame = EnumerateFrames(frame)
	end
end

function FluidFrames.GetNextStackFrame(frame, showAll)
	local stack = FluidFrames.FrameStack
	
	local returnNext
	
	if (not frame) then
		if (#stack > 0) then
			returnNext = true
		else
			return
		end
	end
	
	for i, sFrame in ipairs(stack) do
		if (showAll or sFrame:GetName()) then
			if (returnNext) then
				return sFrame
			elseif (frame == sFrame) then
				returnNext = true
			end
		end
	end
end


function FluidFrames.GetPreviousStackFrame(frame)
	local stack = FluidFrames.FrameStack
	
	if (not frame) then
		if (#stack > 0) then
			return stack[#stack]
		else
			return
		end
	end
	
	local prevFrame
	for i, sFrame in ipairs(stack) do
		if (frame == sFrame) then
			return prevFrame
		end
		prevFrame = sFrame
	end
end

----------------------------
-- Frame Highlight
----------------------------

function FluidFrames.HighlightMouseFrame(showAll)
	
	local dragFrame = FluidFrames.DragFrame
	
	if (dragFrame.isResizing) then
		dragFrame:StopMovingOrSizing()
		dragFrame.isResizing = nil
	end
	
	FluidFrames.BuildCursorFrameStack()
	
	local newFrame
	if (not dragFrame:IsVisible()) then
		if (IsShiftKeyDown()) then
			newFrame = FluidFrames.GetPreviousStackFrame()
		else
			newFrame = FluidFrames.GetNextStackFrame()
		end
	else
		if (#FluidFrames.FrameStack > 0) then
			if (IsShiftKeyDown()) then
				newFrame = FluidFrames.GetPreviousStackFrame(dragFrame.frame)
			else
				newFrame = FluidFrames.GetNextStackFrame(dragFrame.frame)
			end
			if (not newFrame) then
				dragFrame.frame = nil
				dragFrame:Hide()
				return
			end
		end
	end
	
	if (not newFrame) then
		FluidFrames.Print(FLUIDFRAMES_NO_MOVABLE_FRAMES)
		dragFrame.frame = nil
		dragFrame:Hide()
		return
	end

	
	local parent = newFrame:GetParent()
	FluidFrames.Print(format(FLUIDFRAMES_HIGHLIGHT, FluidFrames.OrNil(newFrame:GetName()), FluidFrames.OrNil(parent and parent:GetName())))
	
	dragFrame:SetWidth(newFrame:GetWidth())
	dragFrame:SetHeight(newFrame:GetHeight())
	local scale = newFrame:GetEffectiveScale()/UIParent:GetEffectiveScale()
	dragFrame:SetScale(scale)
	local left = newFrame:GetLeft()
	local bottom = newFrame:GetBottom()
	dragFrame:ClearAllPoints()
	dragFrame:SetPoint("BOTTOMLEFT", left, bottom)
	
	newFrame:SetMovable(1)
	
	if (parent == UIParent or parent == nil) then
		--[[
		newFrame:SetUserPlaced(nil)
		newFrame:ClearAllPoints()
		newFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
		newFrame:SetUserPlaced(1)
		]]--
	end
	
	dragFrame.frame = newFrame
	dragFrame:Show()
end
