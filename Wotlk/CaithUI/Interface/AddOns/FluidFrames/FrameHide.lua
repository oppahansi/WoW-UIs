----------------------------
-- Hide Code
----------------------------

function FluidFrames.ShowHook(frame)
	if (frame.FFHidden) then
		local frameName = frame:GetName()
		if frame:IsProtected() and InCombatLockdown() then
			-- Store frame to hide on next PLAYER_REGEN_ENABLED or PLAYER_ENTERING_WORLD
			FluidFrames.ReshownFrames[frameName] = frame
			FluidFrames.EventFrame.secure_show_flag = true
			FluidFrames.DebugPrint(format("%s:Show intercepted - Hide delayed until after combat.", frameName))
		else
			-- Store frame to hide on next OnUpdate
			FluidFrames.ReshownFrames[frameName] = frame
			FluidFrames.EventFrame.show_flag = true
		end
	end
end

--/z FluidFrames.LockHiddenFrame(MainMenuBar)
function FluidFrames.LockHiddenFrame(frame)
	if (frame.GetName and frame:GetName()) then
		if (not frame.FFShowHooked) then
			hooksecurefunc(frame, "Show", FluidFrames.ShowHook)
			frame.FFShowHooked = true
		end
		local data = FluidFramesModifiedFrames[frame:GetName()]
		if (data) then
			FluidFrames.DebugPrint(format("Hiding: %s", frame:GetName()))
			frame.FFHidden = true
			data.hidden = true
			data.unitAttr = frame:GetAttribute("unit")
			if (data.unitAttr) then
				frame:SetAttribute("unit", nil)
			end
			FluidFrames.HideAssociatedFrames(frame)
			FluidFrames.UpdateGUI()
		else
			FluidFrames.DebugPrint(format(FLUIDFRAMES_CANT_HIDE, frame:GetName()))
		end
	end
end

--/z FluidFrames.UnlockHiddenFrame(MainMenuBar)
--MainMenuBarBackpackButton:Show()
function FluidFrames.UnlockHiddenFrame(frame)
	if (frame.GetName and frame:GetName()) then
		local data = FluidFramesModifiedFrames[frame:GetName()]
		if (data) then
			FluidFrames.DebugPrint(format("Un-hiding: %s", frame:GetName()))
			frame.FFHidden = nil
			data.hidden = nil
			if (data.unitAttr) then
				frame:SetAttribute("unit", data.unitAttr)
				data.unitAttr = nil
			end
			FluidFrames.ShowAssociatedFrames(frame)
			FluidFrames.UpdateGUI()
		else
			FluidFrames.DebugPrint(format(FLUIDFRAMES_CANT_HIDE, frame:GetName()))
		end
	end
end

function FluidFrames.HideAssociatedFrames(frame)
	for i,frame in ipairs(FluidFrames.GetPositionallyDependantOn(frame, frame:GetParent())) do
		frame:Hide()
	end
end

function FluidFrames.ShowAssociatedFrames(frame)
	--TODO: only show ones that weren't manually hidden?
	for i,frame in ipairs(FluidFrames.GetPositionallyDependantOn(frame, frame:GetParent())) do
		frame:Show()
	end
end

function FluidFrames.RestoreHide()
	local outOfCombat = not InCombatLockdown()
	for frameName, frame in pairs(FluidFrames.ReshownFrames) do
		if outOfCombat or not frame:IsProtected() then
			local data = FluidFramesModifiedFrames[frameName]
			if (data and data.hidden) then
				FluidFrames.HideAssociatedFrames(frame)
				FluidFrames.DebugPrint(format("%s - ReHidden.", frameName))
			end
			FluidFrames.ReshownFrames[frameName] = nil
		end
	end
end
