----------------------------
-- Rescale Code
----------------------------

function FluidFrames.RescaleChildren(widthScale, heightScale, resizeFontStrings, ...)
	for i=1, select("#", ...) do
		local child = select(i, ...)
		if (child) then
			if (child:IsObjectType("FontString")) then
				local fontName, fontHeight, fontFlags = child:GetFont()
				if (fontName and fontHeight > 0 and heightScale ~= child:GetParent():GetScale()) then
					child:SetFont(fontName, fontHeight*heightScale, fontFlags)
					--FluidFrames.Print("Resizing FontString: "..(child:GetName() or "<Unnamed>").." Scale: "..FluidFrames.Round(heightScale, 100).." FontSize: "..FluidFrames.Round(fontHeight*heightScale, 100))
				end
				if ( resizeFontStrings and child:GetStringWidth() > 0 and not FluidFrames.Compare(child:GetStringWidth(), child:GetWidth()) ) then
					--Use height for now, untill there's a way to check if the FontString has been absoolutely sized or not
					if (child.GetName and child:GetName()) then
						--FluidFrames.Print(child:GetName()..": resizeFontStrings - "..floor(child:GetStringWidth()).." "..floor(child:GetWidth()).." "..floor(child:GetHeight()).." "..FluidFrames.Round(heightScale, 100))
						child:SetWidth(child:GetWidth()*heightScale)
						child:SetHeight(child:GetHeight()*heightScale)
						--FluidFrames.Print("SetWidth: "..FluidFrames.Round(child:GetWidth()*heightScale, 100).." SetHeight: "..FluidFrames.Round(child:GetHeight()*heightScale, 100))
					end
				end
			else
				--FluidFrames.Print(child:GetName())
				child:SetWidth(child:GetWidth()*widthScale)
				child:SetHeight(child:GetHeight()*heightScale)
			end
			if (child.GetChildren) then
				FluidFrames.RescaleChildren(widthScale, heightScale, resizeFontStrings, child:GetChildren())
			end
			if (child.GetRegions) then
				FluidFrames.RescaleChildren(widthScale, heightScale, resizeFontStrings, child:GetRegions())
			end
			
			if (child.GetNumPoints) then
				for p=1, child:GetNumPoints() do
					local point, relativeTo, relativePoint, xOffset, yOffset = child:GetPoint(p)
					child:SetPoint(point, relativeTo, relativePoint, xOffset*widthScale, yOffset*heightScale)
				end
			end
		end
	end
end

--/z FluidFrames.RescaleFrame(ShapeshiftBarFrame, 1.5, 1)
--/z FluidFrames.RescaleFrame(PlayerFrame, 1.5, 1)
function FluidFrames.RescaleFrame(frame, widthScale, heightScale, resizeFontStrings)
	if (not frame) then
		return
	elseif (frame:IsProtected() and InCombatLockdown()) then
		return
	end
	
	--frame:SetWidth(frame:GetWidth()*widthScale)
	--frame:SetHeight(frame:GetHeight()*heightScale)
	
	--[[
	if (frame.GetChildren) then
		FluidFrames.RescaleChildren(widthScale, heightScale, resizeFontStrings, frame:GetChildren())
	end
	if (frame.GetRegions) then
		FluidFrames.RescaleChildren(widthScale, heightScale, resizeFontStrings, frame:GetRegions())
	end
	]]--
	
	FluidFrames.RescaleChildren(widthScale, heightScale, resizeFontStrings, 
		unpack(FluidFrames.GetPositionallyDependantOn(frame, frame:GetParent())))
end

function FluidFrames.RelativelyScaleFrame(frame, scale)
	if (not frame) then
		return
	end
	--frame:SetScale(frame:GetScale()*scale)
	for i,v in ipairs(FluidFrames.GetPositionallyDependantOn(frame, frame:GetParent())) do
		v:SetScale(v:GetScale()*scale)
	end
end
