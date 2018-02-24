----------------------------
-- Temp Draggable Frames
----------------------------

FluidFrames.FramesToDragByParent = {
	"PaperDollFrame",
	"ReputationFrame",
	"SkillFrame",
	"PVPFrameHonor",
	"PetPaperDollFrame",
	"PetPaperDollFrameCompanionFrame",
	"TokenFrame",
	"PVPFrame",
	"SendMailFrame",
}

function FluidFrames.InitTempDraggableFrames()
	-- Make UIPanels temporarily draggable (position not saved)
	for frameName,info in pairs(UIPanelWindows) do
		if (info.area ~= "full") then
			local frame = getglobal(frameName)
			if (frame and frame.GetTitleRegion) then
				local titleRegion = frame:GetTitleRegion()
				if (not titleRegion) then
					titleRegion = frame:CreateTitleRegion()
				end
				--titleRegion:SetAllPoints(frame)
				frame:EnableMouse(1)
			end
		end
	end
	
	--[[
	for i,frameName in pairs(UIChildWindows) do
		local frame = getglobal(frameName)
		if (frame and frame.GetTitleRegion) then
			local titleRegion = frame:GetTitleRegion()
			if (not titleRegion) then
				titleRegion = frame:CreateTitleRegion()
			end
			--titleRegion:SetAllPoints(frame)
			frame:EnableMouse(1)
		end
	end
	]]--

	-- Disable the mouse on a few child frames so that the parent is draggable
	for i,frameName in ipairs(FluidFrames.FramesToDragByParent) do
		local frame = getglobal(frameName)
		if (frame) then
			frame:EnableMouse(nil)
		end
	end

	-- Update Enabled (mostly for LoD)
	if (FluidFrames_SavedVars) then
		FluidFrames.ToggleTempDraggableFrames(FluidFrames_SavedVars.TempDraggable == "1")
	end
end

function FluidFrames.ToggleTempDraggableFrames(value)
	for frameName,info in pairs(UIPanelWindows) do
		if (info.area ~= "full") then
			local frame = getglobal(frameName)
			if (frame and frame.GetTitleRegion) then
				local titleRegion = frame:GetTitleRegion()
				if (titleRegion) then
					if (value) then
						titleRegion:SetAllPoints(frame)
					else
						titleRegion:ClearAllPoints()
						titleRegion:SetHeight(0)
						titleRegion:SetWidth(0)
					end
				end
			end
		end
	end
	
	--[[
	for i,frameName in pairs(UIChildWindows) do
		local frame = getglobal(frameName)
		if (frame and frame.GetTitleRegion) then
			local titleRegion = frame:GetTitleRegion()
			if (titleRegion) then
				if (value) then
					titleRegion:SetAllPoints(frame)
				else
					titleRegion:ClearAllPoints()
					titleRegion:SetHeight(0)
					titleRegion:SetWidth(0)
				end
			end
		end
	end
	]]--
	
	if (value and AchievementFrame) then
		AchievementFrameHeader:EnableMouse(false)
	end
end

function FluidFrames.ToggleTempDraggableMinimap(value)
	local titleRegion = MinimapCluster:GetTitleRegion()
	if (not titleRegion) then
		if (value) then
			--Init
			MinimapCluster:SetScript("OnEnter", function()
				MinimapZoneTextButton:GetScript("OnEnter")(MinimapZoneTextButton)
			end)
			MinimapCluster:SetScript("OnLeave", function()
				MinimapZoneTextButton:GetScript("OnLeave")(MinimapZoneTextButton)
			end)
			titleRegion = MinimapCluster:CreateTitleRegion()
			titleRegion:SetAllPoints(MinimapCluster)
			MinimapZoneTextButton:EnableMouse(nil)
		end
	else
		if (value) then
			titleRegion:SetAllPoints(MinimapCluster)
		else
			titleRegion:ClearAllPoints()
			titleRegion:SetHeight(0)
			titleRegion:SetWidth(0)
		end
	end
end
