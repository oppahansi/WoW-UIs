----------------------------
-- Reset Code
----------------------------

FluidFramesModifiedFrames = {}

function FluidFrames.StoreFrameDefault(frame, storeScale, storeDimentions)
	local name = frame:GetName()
	if (not name) then
		return
	end
	local data = FluidFramesModifiedFrames[name]
	if (not data) then
		data = {}
	end
	if (storeScale and not data.scale) then
		data.scale = frame:GetScale()
	end
	if (storeDimentions and (not data.height or not data.width)) then
		data.height = frame:GetHeight()
		data.width = frame:GetWidth()
	end
	if (not data.parent) then
		local parent = frame:GetParent()
		data.parent = parent and parent:GetName() or parent
	end
	if (not data.point) then
		data.point = {}
		for i=1, frame:GetNumPoints() do
			local pdata = { frame:GetPoint(i) }
			--{ point, relativeTo, relativePoint, xofs, yofs }
			if (pdata[2] and pdata[2].GetName and pdata[2]:GetName()) then
				pdata[2] = pdata[2]:GetName()
				tinsert(data.point, pdata)
			else
				--No anchor name.... won't save accross sessions (deleted on VARIABLES_LOADED).
				FluidFrames.Print(format(FLUIDFRAMES_UNNAMED_ANCHOR, name))
				tinsert(data.point, pdata)
			end
		end
	end
	if (not FluidFramesModifiedFrames[name]) then
		FluidFramesModifiedFrames[name] = data
		FluidFrames.UpdateGUI()
	end
end

function FluidFrames.ResetFrame(frame)
	-- Remove saved position regardless.
	frame:SetUserPlaced(nil)
	
	local name = frame:GetName()
	if (not name) then
		FluidFrames.Print(FLUIDFRAMES_CANT_RESET_UNNAMED)
		return
	elseif (not FluidFramesModifiedFrames[name]) then
		FluidFrames.Print(format(FLUIDFRAMES_CANT_RESET_NO_DEFAULT, name))
		return
	end
	local data = FluidFramesModifiedFrames[name]
	--WOW Crash!!! uncomment this and reset a frame. FluidFrames.RescaleFrame(frame, data.width/frame:GetWidth(), data.height/frame:GetHeight())
	
	FluidFrames.Mobilize(frame)
	
	if (type(data.parent) == "string") then
		local parent = getglobal(data.parent)
		if (parent) then
			FluidFrames.ResetFrameParent(frame, parent)
		end
	elseif (type(data.parent) == "table") then
		FluidFrames.ResetFrameParent(frame, data.parent)
	end
	
	if (data.scale) then
		--frame:SetScale(data.scale)
		FluidFrames.RelativelyScaleFrame(frame, data.scale/frame:GetScale())
	end
	
	if (data.width and data.height) then
		local widthScale = data.width/frame:GetWidth()
		local heightScale = data.height/frame:GetHeight()
		FluidFrames.RescaleFrame(frame, widthScale, heightScale, true)
	end
	
	frame:ClearAllPoints()
	for i=1, #data.point do
		frame:SetPoint(data.point[i][1], data.point[i][2], data.point[i][3], data.point[i][4], data.point[i][5])
	end
	
	FluidFrames.UnlockHiddenFrame(frame)
	
	FluidFramesModifiedFrames[name] = nil
	
	-- Refresh frame with it's OnShow updates
	frame:Hide()
	frame:Show()
	
	FluidFrames.DragFrame.frame = nil
	FluidFrames.DragFrame:Hide()
	
	FluidFrames.UpdateGUI()
	FluidFrames.Print(format(FLUIDFRAMES_RESET, name))
end

function FluidFrames.ResetAll()
	FluidFrames.DoNotUpdateGUI = true
	for k,v in pairs(FluidFramesModifiedFrames) do
		local frame = getglobal(k)
		if (frame) then
			FluidFrames.ResetFrame(frame)
		else
			FluidFrames.Print(format(FLUIDFRAMES_CANT_RESET_NOT_FOUND, k))
		end
	end
	FluidFrames.DoNotUpdateGUI = nil
	FluidFrames.UpdateGUI()
	FluidFrames.Print(FLUIDFRAMES_RESET_ALL_FINISHED)
end

SlashCmdList["FLUIDFRAMESSLASH"] = FluidFrames.ResetAll;

function FluidFrames.ReshowAll()
	FluidFrames.DoNotUpdateGUI = true
	for k,v in pairs(FluidFramesModifiedFrames) do
		local frame = getglobal(k)
		if (frame and frame.FFHidden) then
			FluidFrames.UnlockHiddenFrame(frame)
		end
	end
	FluidFrames.DoNotUpdateGUI = nil
	FluidFrames.UpdateGUI()
	FluidFrames.Print(FLUIDFRAMES_RESHOW_ALL_FINISHED)
end
