----------------------------
-- Immobilization Code
----------------------------

function FluidFrames.SetPointHook(self, ...)
	if (self.FFImmobilized) then
		--FluidFrames.DebugPrint(format("%s:SetPoint intercepted - Immobilized.", self:GetName()))
		local frameName = self:GetName()
		local data = FluidFramesModifiedFrames[frameName]
		if (data and data.immobilized) then
			if (self:IsProtected() and InCombatLockdown()) then
				-- Store frame to move on next PLAYER_REGEN_ENABLED or PLAYER_ENTERING_WORLD
				FluidFrames.ReanchoredFrames[frameName] = self
				FluidFrames.EventFrame.secure_setpoint_flag = true
				FluidFrames.DebugPrint(format("%s:SetPoint intercepted - Delayed until after combat.", frameName))
			else
				self.FFImmobilized = nil
				self:ClearAllPoints()
				self:SetPoint(unpack(data.immobilized.point))
				self.FFImmobilized = true
				FluidFrames.DebugPrint(format("%s:SetPoint intercepted - Moved to saved location.", frameName))
			end
		end
	else
		--FluidFrames.DebugPrint(format("%s:SetPoint intercepted - Mobile: %s.", self:GetName(), (this and this.GetName and this:GetName() or "Unknown")))
	end
end

function FluidFrames.SetWidthHook(self, width)
	if (self.FFImmobilized) then
		FluidFrames.DebugPrint(format("%s:SetWidth intercepted - %s.", self:GetName(), width))
		-- Allow SetWidth when immobilized, update saved data
		local data = FluidFramesModifiedFrames[self:GetName()]
		if (data and data.immobilized and data.immobilized.width and data.width) then
			-- Update Reset Width by scaling by difference between the previous immobilized width and the new width
			data.width = data.width * (width / data.immobilized.width)
			-- Update Immobilized Width
			data.immobilized.width = width
		end
	end
end

function FluidFrames.SetHeightHook(self, height)
	if (self.FFImmobilized) then
		FluidFrames.DebugPrint(format("%s:SetHeight intercepted - %s.", self:GetName(), height))
		-- Allow SetHeight when immobilized, update saved data
		local data = FluidFramesModifiedFrames[self:GetName()]
		if (data and data.immobilized and data.immobilized.height and data.height) then
			-- Update Reset Height by scaling by difference between the previous immobilized height and the new height
			data.height = data.height * (height / data.immobilized.height)
			-- Update Immobilized Height
			data.immobilized.height = height
			--[[ Update position (since it's will be set from the bottom left)
			self.FFImmobilized = nil
			self:ClearAllPoints()
			self:SetPoint(unpack(data.immobilized.point))
			self.FFImmobilized = true
			]]--
		end
	end
end

function FluidFrames.SetParentHook(self, oldParent)
	if (self.FFImmobilized) then
		local frameName = self:GetName()
		FluidFrames.DebugPrint(format("%s:SetParent intercepted - %s.", frameName, oldParent.GetName and oldParent:GetName() or oldParent))
		if (self:IsProtected() and InCombatLockdown()) then
			-- Store frame to reparent on next PLAYER_REGEN_ENABLED or PLAYER_ENTERING_WORLD
			FluidFrames.ReparentedFrames[frameName] = self
			FluidFrames.EventFrame.secure_setparent_flag = true
		else
			-- Store frame to reparent on next OnUpdate
			FluidFrames.ReparentedFrames[frameName] = self
			FluidFrames.EventFrame.setparent_flag = true
		end
	end
end

function FluidFrames.SetImmobilizeHooks(frame)
	if (not frame.FFSetXHooked) then
		hooksecurefunc(frame, "SetParent", FluidFrames.SetParentHook)
		hooksecurefunc(frame, "SetPoint", FluidFrames.SetPointHook)
		hooksecurefunc(frame, "SetWidth", FluidFrames.SetWidthHook)
		hooksecurefunc(frame, "SetHeight", FluidFrames.SetHeightHook)
		frame.FFSetXHooked = true
	end
end


function FluidFrames.Immobilize(frame)
	if (frame.GetName and frame:GetName()) then
	
		FluidFrames.SetImmobilizeHooks(frame)
		
		-- Should be just a single point relative to UIParent. Maybe store in SV? Set relativeTo = "UIParent"?
		local data = FluidFramesModifiedFrames[frame:GetName()]
		if (data) then
			local point = { frame:GetPoint(1) }
			if (point[2] == UIParent) then
				point[2] = "UIParent"
				frame.FFImmobilized = true
				
				if (not data.immobilized) then
					data.immobilized = {}
				end
				data.immobilized.point = point
			else
				if (data.immobilized) then
					if (not data.immobilized.scale) then
						data.immobilized = nil
					else
						data.immobilized.point = nil
					end
				end
				frame.FFImmobilized = nil
				FluidFrames.Print(format(FLUIDFRAMES_CANT_IMMOBILIZE_NOT_UIPARENT, frame:GetName()))
			end
		else
			FluidFrames.Print(format(FLUIDFRAMES_CANT_IMMOBILIZE_NO_DEFAULT, frame:GetName()))
		end
	else
		FluidFrames.Print(FLUIDFRAMES_CANT_IMMOBILIZE_UNNAMED)
	end
end

function FluidFrames.ImmobilizeAndStoreDimentions(frame, storeScale, storeDimentions)
	if (frame.GetName and frame:GetName()) then
		
		FluidFrames.SetImmobilizeHooks(frame)
		
		-- Should be just a single point relative to UIParent. Maybe store in SV? Set relativeTo = "UIParent"?
		local data = FluidFramesModifiedFrames[frame:GetName()]
		if (data) then
			local point = { frame:GetPoint(1) }
			if (point[2] == UIParent) then
				point[2] = "UIParent"
				frame.FFImmobilized = true
				
				if (not data.immobilized) then
					data.immobilized = {}
				end
				data.immobilized.point = point
				if (storeScale) then
					data.immobilized.scale = frame:GetScale()
				end
				if (storeDimentions) then
					data.immobilized.height = frame:GetHeight()
					data.immobilized.width = frame:GetWidth()
				end
			else
				data.immobilized = nil
				frame.FFImmobilized = nil
				FluidFrames.Print(format(FLUIDFRAMES_CANT_IMMOBILIZE_NOT_UIPARENT, frame:GetName()))
			end
		else
			FluidFrames.Print(format(FLUIDFRAMES_CANT_IMMOBILIZE_NO_DEFAULT, frame:GetName()))
		end
	else
		FluidFrames.Print(FLUIDFRAMES_CANT_IMMOBILIZE_UNNAMED)
	end
end

function FluidFrames.Mobilize(frame)
	frame.FFImmobilized = nil
	if (frame.GetName and frame:GetName()) then
		local data = FluidFramesModifiedFrames[frame:GetName()]
		if (data and data.immobilized) then
			data.immobilized.point = nil
			--data.immobilized = nil
		end
	end
end

function FluidFrames.RestoreSetPoint()
	local outOfCombat = not InCombatLockdown()
	for frameName, frame in pairs(FluidFrames.ReanchoredFrames) do
		if outOfCombat or not frame:IsProtected() then
			local data = FluidFramesModifiedFrames[frameName]
			if (data and data.immobilized) then
				frame.FFImmobilized = nil
				frame:ClearAllPoints()
				frame:SetPoint(unpack(data.immobilized.point))
				frame.FFImmobilized = true
				FluidFrames.DebugPrint(format("%s - Moved to saved location.", frameName))
			end
			FluidFrames.ReanchoredFrames[frameName] = nil
		end
	end
end

function FluidFrames.RestoreSetParent()
	local newParent = getglobal(FluidFrames.NEW_PARENT)
	local outOfCombat = not InCombatLockdown()
	for frameName, frame in pairs(FluidFrames.ReparentedFrames) do
		if outOfCombat or not frame:IsProtected() then
			local data = FluidFramesModifiedFrames[frameName]
			local oldParent = frame:GetParent()
			if (data and data.immobilized and oldParent ~= newParent) then
				frame.FFImmobilized = nil
				FluidFrames.ReparentAssociatedFrames(frame, oldParent, newParent)
				frame.FFImmobilized = true
			end
			FluidFrames.ReparentedFrames[frameName] = nil
		end
	end
end
