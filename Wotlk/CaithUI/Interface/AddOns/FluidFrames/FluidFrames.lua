--------------------------------------------------------------------------
-- FluidFrames.lua 
--------------------------------------------------------------------------
--[[
FluidFrames

By: AnduinLothar	<KarlKFI@cosmosui.org>
		
	$Id: FluidFrames.lua 5241 2008-04-06 00:13:33Z karlkfi $
	$Rev: 5241 $
	$LastChangedBy: karlkfi $
	$Date: 2008-04-05 19:13:33 -0500 (Sat, 05 Apr 2008) $


TODO: HideUIPanel or ShowUIPanel hook that repositions 'center' UIPanelWindows
TODO: make 'full' UIPanelWindows highlightable when UIParent is hidden. Like WorldMapFrame
TODO: Add a module to disable SetPoint unless highlighted
]]--

FluidFrames = {}

FluidFrames.version = tonumber(GetAddOnMetadata("FluidFrames", "Version"))

FluidFrames.debug = false

FluidFrames.NEW_PARENT = "UIParent"

----------------------------
-- Util Functions
----------------------------

function FluidFrames.Print(text)
	-- Grey
	DEFAULT_CHAT_FRAME:AddMessage(text, .5,.5,.5)
end

function FluidFrames.DebugPrint(text)
	if (FluidFrames.debug) then
		-- Grey
		DEFAULT_CHAT_FRAME:AddMessage(text, .5,.5,.5)
	end
end

function FluidFrames.OrNil(text)
	return text or FLUIDFRAMES_NIL
end

function FluidFrames.Round(x, place)
	if not place then place = 1 end
	return floor(x*place+0.5)/place
end

function FluidFrames.Compare(x, y)
	local delta = 0.001
	return x <= y + delta and x >= y - delta
end

----------------------------
-- Initialization
----------------------------

FluidFrames.UninitializedFrames = {}
FluidFrames.ReanchoredFrames = {}
FluidFrames.ReshownFrames = {}
FluidFrames.ReparentedFrames = {}

FluidFrames.FramesToInitLater = {
	["QuestWatchFrame"] = true,
}

function FluidFrames.InitMovedFrames(frameList)
	local framesToHide = {};
	
	for k,v in pairs(frameList) do
		-- remove parents that used to be unnamed frames
		if (type(v.parent) ~= "string") then
			v.parent = nil
		end
		-- remove relativeTo points that used to be unnamed frames
		for kk,vv in ipairs(v.point) do
			if (type(vv[2]) ~= "string") then
				v.point[kk] = nil
			end
		end
		
		local frame = getglobal(k)
		if (not frame) then
			FluidFrames.DebugPrint(format(FLUIDFRAMES_CANT_FIND_STORED, k))
			-- Add to the Uninitialized list and check on subsequent ADDON_LOADED and PLAYER_REGEN_ENABLED events 
			if (frameList ~= FluidFrames.UninitializedFrames) then
				FluidFrames.UninitializedFrames[k] = frameList[k]
			end
			
		elseif (frame:IsProtected() and InCombatLockdown()) then
			FluidFrames.DebugPrint(format(FLUIDFRAMES_CANT_MOVE_IN_COMBAT, k))
			-- Add to the Uninitialized list and check on subsequent ADDON_LOADED and PLAYER_REGEN_ENABLED events 
			if (frameList ~= FluidFrames.UninitializedFrames) then
				FluidFrames.UninitializedFrames[k] = frameList[k]
			end
		
		elseif (FluidFrames.FramesToInitLater[k] and frameList ~= FluidFrames.UninitializedFrames) then
			FluidFrames.DebugPrint(format(FLUIDFRAMES_DELAYING_EXCEPTION_FRAME, k))
			-- Exception frames load on PLAYER_REGEN_ENABLED or QUEST_LOG_UPDATE after PLAYER_ENTERING_WORLD
			FluidFrames.UninitializedFrames[k] = frameList[k]
			
		else
			-- SetPoint to stored location, immobilize and establish SetPointHook
			if (v.immobilized) then
				local data = v.immobilized
				if (data.point) then
					if (data.scale and not FluidFrames.Compare(data.scale, frame:GetScale())) then
						--frame:SetScale(data.scale)
						FluidFrames.RelativelyScaleFrame(frame, data.scale/frame:GetScale())
					end
					if (data.width and data.height) then
						local widthScale = data.width/frame:GetWidth()
						local heightScale = data.height/frame:GetHeight()
						if (FluidFrames.debug) then
							FluidFrames.Print("Dimension Restore: "..(frame.GetName and frame:GetName() or "(nil)"))
							FluidFrames.Print("Saved Width: "..FluidFrames.Round(data.width, 100).." Curr Width: "..FluidFrames.Round(frame:GetWidth(), 100))
							FluidFrames.Print("Saved Height: "..FluidFrames.Round(data.height, 100).." Curr Height: "..FluidFrames.Round(frame:GetHeight(), 100))
							FluidFrames.Print("WidthScale: "..FluidFrames.Round(widthScale, 100).." HeightScale: "..FluidFrames.Round(heightScale, 100))
						end
						FluidFrames.RescaleFrame(frame, widthScale, heightScale, true)
					end
				else
					-- update v1.01 sv
					data.point = { data[1], data[2], data[3], data[4], data[5] }
					data[1] = nil
					data[2] = nil
					data[3] = nil
					data[4] = nil
					data[5] = nil
				end
				
				FluidFrames.FreeFrameFromParent(frame)
				
				frame:ClearAllPoints()
				frame:SetPoint(unpack(data.point))
				frame:SetMovable(1)
				frame:SetUserPlaced(1)
				frame.FFImmobilized = true
				
				FluidFrames.SetImmobilizeHooks(frame)
			end
			
			-- Store frame to hide later (so that it doesn't hide moved child frames before they are reparented)
			if (v.hidden) then
				tinsert(framesToHide, k)
			end
			
			-- Remove from the Uninitialized list 
			if (frameList == FluidFrames.UninitializedFrames) then
				frameList[k] = nil
			end
			
		end
		
	end
	
	-- Hide frames and establish ShowHook
	for i,frameName in pairs(framesToHide) do
		local frame = getglobal(frameName)
		FluidFrames.LockHiddenFrame(frame)
	end
end


----------------------------
-- Event Frame
----------------------------

function FluidFrames.EventOnEvent(self, event, arg1)
	if (event == "ADDON_LOADED") then
		-- Catch Load on Demand Addon frames
		-- Use OnUpdate to load after their LoadWith's
		self.nextFrameInit = true
		
	elseif (event == "VARIABLES_LOADED") then
		FluidFrames.InitTempDraggableFrames()
		--FluidFrames.RegisterPortfolio()
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self.init_flag = true
		
	elseif (event == "PLAYER_ENTERING_WORLD") then
		--self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if self.init_flag then
			self.init_flag = nil
			self:RegisterEvent("QUEST_LOG_UPDATE")
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
			self.init_regen_flag = true
			self:RegisterEvent("ADDON_LOADED")
			
			if (not FluidFramesModifiedFrames) then
				FluidFramesModifiedFrames = {}
			else
				FluidFrames.InitMovedFrames(FluidFramesModifiedFrames)
				hooksecurefunc("CreateFrame", FluidFrames.CreateFrameHook)
			end
			--FluidFrames.InitTempDraggableFrames()
		end
		if self.secure_setpoint_flag then
			self.secure_setpoint_flag = nil
			FluidFrames.RestoreSetPoint()
		end
		if self.secure_setparent_flag then
			self.secure_setparent_flag = nil
			FluidFrames.RestoreSetParent()
		end
		if self.secure_show_flag then
			self.secure_show_flag = nil
			FluidFrames.RestoreHide()
		end
	
	-- QUEST_LOG_UPDATE should fire when you log in or reloadui, regardless of whether you have any quests
	--This makes sure QuestWatchFrame has been resized
	elseif (event == "QUEST_LOG_UPDATE") then
		self:UnregisterEvent("QUEST_LOG_UPDATE")
		FluidFrames.InitMovedFrames(FluidFrames.UninitializedFrames)
	
	elseif (event == "PLAYER_REGEN_ENABLED") then
		--self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		if self.init_regen_flag then
			self.init_regen_flag = nil
			FluidFrames.InitMovedFrames(FluidFrames.UninitializedFrames)
		end
		if self.secure_setpoint_flag then
			self.secure_setpoint_flag = nil
			FluidFrames.RestoreSetPoint()
		end
		if self.secure_setparent_flag then
			self.secure_setparent_flag = nil
			FluidFrames.RestoreSetParent()
		end
		if self.secure_show_flag then
			self.secure_show_flag = nil
			FluidFrames.RestoreHide()
		end
	end
end

function FluidFrames.CreateFrameHook(frameType, frameName, parent)
	if (frameName and FluidFrames.UninitializedFrames[frameName]) then
		FluidFrames.EventFrame.nextFrameInit = true
	end
end

function FluidFrames.EventOnUpdate(self, delay) 
	if (self.nextFrameInit) then
		FluidFrames.InitMovedFrames(FluidFrames.UninitializedFrames)
		FluidFrames.InitTempDraggableFrames()
		self.nextFrameInit = false
	end
	if self.setparent_flag then
		self.setparent_flag = nil
		FluidFrames.RestoreSetParent()
	end
	if self.show_flag then
		self.show_flag = nil
		FluidFrames.RestoreHide()
	end
end

function FluidFrames.InitEventFrame()
	if (FluidFrames.EventFrame) then
		return
	end
	local eventFrame = CreateFrame("Frame", "FluidEventFrame", UIParent)
	eventFrame:RegisterEvent("VARIABLES_LOADED")
	eventFrame:SetScript("OnEvent", FluidFrames.EventOnEvent)
	eventFrame:SetScript("OnUpdate", FluidFrames.EventOnUpdate)
	FluidFrames.EventFrame = eventFrame
end


----------------------------
-- OnLoad Inits
----------------------------
FluidFrames.InitEventFrame()
