----------------------------
-- Accociative Reparent Code 
-- Fixes things like dragging ActionBar1 by also reparenting anchored siblings
----------------------------

--[[-- Get the hash size of a table --]]--
local function tsize(t)
	local i = 0
	for k in pairs(t) do
		i=i+1
	end
	return i
end

--[[-- Get the hash keys as a list --]]--
local function keyList(t)
	local keys = {}
	for k in pairs(t) do
		tinsert(keys, k)
	end
	return keys
end

function FluidFrames.ReparentAssociatedFrames(frame, oldParent, newParent)
	if oldParent and oldParent ~= newParent then
		--frame:SetParent(newParent)
		FluidFrames.DebugPrint(format(FLUIDFRAMES_REPARENTING, frame:GetName(), FluidFrames.OrNil(oldParent:GetName()), FluidFrames.OrNil(newParent:GetName())))
		for i,v in ipairs(FluidFrames.GetPositionallyDependantOn(frame, oldParent)) do
			v:SetParent(newParent)
		end
	end
end

function FluidFrames.FreeFrameFromParent(frame)
	local oldParent = frame:GetParent()
	if oldParent then
		local newParent = getglobal(FluidFrames.NEW_PARENT)
		FluidFrames.ReparentAssociatedFrames(frame, oldParent, newParent)
	end
end

function FluidFrames.ResetFrameParent(frame, origParent)
	--local parent = getglobal(FluidFrames.NEW_PARENT)
	local parent = frame:GetParent()
	FluidFrames.ReparentAssociatedFrames(frame, parent, origParent)
end

function FluidFrames.GetPositionallyDependantOn(frame, parent)
	local frameSet = { [frame] = true }
	if parent.GetChildren then
		local siblings = { parent:GetChildren() }
		local size = 0
		local newSize = tsize(frameSet)
		while size < newSize do
			FluidFrames.GetAnchoredTo(frameSet, unpack(siblings))
			size = newSize
			newSize = tsize(frameSet)
		end
	end
	if parent.GetRegions then
		local siblings = { parent:GetRegions() }
		local size = 0
		local newSize = tsize(frameSet)
		while size < newSize do
			FluidFrames.GetAnchoredTo(frameSet, unpack(siblings))
			size = newSize
			newSize = tsize(frameSet)
		end
	end
	return keyList(frameSet)
end

--[[-- From a list of frames/regions add the ones that are anchored once only to one of the frames in the frameSet to the frameSet. --]]--
function FluidFrames.GetAnchoredTo(frameSet, first, ...)
	if first and not frameSet[first] and first:GetNumPoints() == 1 then
		--TODO: check if it's anchored to a child of the frame
		local relativeFrame = select(2, first:GetPoint(1))
		if frameSet[relativeFrame] then
			frameSet[first] = true
			if select("#", ...) > 0 then
				FluidFrames.GetAnchoredTo(frameSet, ...)
			end
		end
	end
	if select("#", ...) > 0 then
		FluidFrames.GetAnchoredTo(frameSet, ...)
	end
end

