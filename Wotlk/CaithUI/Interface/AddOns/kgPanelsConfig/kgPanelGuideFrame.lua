--[[
	Placeholder file
	
	We're going to want to put our guide frame code here, so it's also LoD without adding anymore filesystem clutter
]]

--[[------------------------------------------------------------
	Most of this module has been taken verbatium from eePanels
	why re-invent the wheel if you dont need to.
--------------------------------------------------------------]]
local kgPanels = LibStub("AceAddon-3.0"):GetAddon("kgPanels")
local GuideFrame = kgPanels:NewModule("GuideFrame")
local kgPanelsConfig = kgPanels:GetModule("kgPanelsConfig") -- grab a ref to the config system
local L = LibStub("AceLocale-3.0"):GetLocale("kgPanels",true)

local guideFrames = {}

function GuideFrame:DeleteGuide(guide)
	guide:Hide()
	guideFrames[guide] = true
end

function GuideFrame:GetGuideFrame(name,to,from,anchor)
	local frame = kgPanels:FetchFrame(name)
	local guide = next(guideFrames)
	if guide then
		guide.panel = name
		guide.title:SetText( L["kgPanel"]..": "..name )
		guide:SetParent(frame)
		guide:SetAllPoints(frame)
		guide:Show()
		guideFrames[guide] = nil
	else
		guide = CreateFrame("Frame", nil, frame)
		guide:EnableMouse(true)
		guide:SetResizable(true)
		guide:SetMovable(true)
		guide:SetMinResize(22,22)
		guide:SetFrameStrata("HIGH")
		guide:SetAllPoints(frame)
		guide:SetBackdropColor(1,1,1,0)
		guide.isResizing = false
		guide.isMoving = false
		guide:SetParent(frame)
		guide.panel = name	
		-- Create a texture to display a special highlight color when we mouse-over this frame
		guide.texture = guide:CreateTexture(nil, "HIGHLIGHT")
		guide.texture:SetAllPoints(guide)
		guide.texture:SetTexture(0,1,1)
		guide.texture:SetAlpha(.3)
		-- Display the frame number on top of our texture when we mouseOver
		guide.title = guide:CreateFontString(nil, "HIGHLIGHT")
		guide.title:SetFontObject(GameFontHighlightSmall)
		guide.title:SetPoint("CENTER", guide, "CENTER", 0, 0)
		guide.title:SetText( L["kgPanel"]..": "..name)
		-- Resize mouse-drag image
		resizeTexture = guide:CreateTexture(nil, "HIGHLIGHT")
		resizeTexture:SetHeight(16)
		resizeTexture:SetWidth(16)
		resizeTexture:SetTexture("Interface\\Addons\\kgPanelsConfig\\resize.tga")
		resizeTexture:SetPoint("BOTTOMRIGHT",-2,2)
		-- Set scripts to let us move while dragging
		guide:SetScript("OnMouseDown",function(frame) GuideFrame:MouseDownListener(frame) end)
		guide:SetScript("OnMouseUp",function(frame) GuideFrame:MouseUpListener(frame) end)	
		guide:Show()
	end
	guide.to = to
	guide.from = from
	local anch = getglobal(anchor)
	if not anch then
		anch = kgPanels:FetchFrame(anchor)
	end
	guide.anchor = anch
	return guide
end

--[[
-- Listen for mouse-clicks on the guide frame
--]]
function GuideFrame:MouseDownListener(frame)
	-- On left-clicks, listen for mouse-dragging
	if arg1 == "LeftButton" then	
		-- Set vars to figure out if the mouse is in the resize area or not
		local screenX, screenY = GetCursorPosition()
		local panelX = frame:GetRight()
		local panelY = frame:GetBottom()
		-- Adjust for screen scale
		local scale = frame:GetEffectiveScale()
		panelX = panelX * scale
		panelY = panelY * scale
		-- Set bounds for lower-right hand corner
		local check1 = screenX <= panelX + 14
		local check2 = screenX >= panelX - 14
		local check3 = screenY <= panelY + 14
		local check4 = screenY >= panelY - 14
		-- Start resizing
		if check1 and check2 and check3 and check4 then
			frame.isResizing = true
			frame:SetScript("OnUpdate", function(frame) self:ResizeListener(frame) end)
			frame:StartSizing("BOTTOMRIGHT")
		else
			frame.isMoving = true
			frame:SetScript("OnUpdate", function(frame) self:MoveListener(frame) end)
			frame:StartMoving()
		end
	end
end
--[[
-- Listens for mouse-click release over the guide frame
--]]
function GuideFrame:MouseUpListener(frame)
	frame:StopMovingOrSizing()
	frame:SetScript("OnUpdate", nil)	
	if frame.isResizing then
		frame.isResizing = false
	elseif frame.isMoving then
		frame.isMoving = false
	end
	-- at this point the mouse button has been released save the positions
	local panelFrame = kgPanels:FetchFrame(frame.panel)
	local scale,pscale = frame:GetEffectiveScale(),panelFrame:GetParent():GetEffectiveScale()
	local gX,gY = self:GetXY(frame.from,frame)
	local pX,pY = self:GetXY(frame.to,frame.anchor)
	local x = (gX * scale) - (pX * pscale)
	local y = (gY * scale) - (pY * pscale)
	x = x/scale
	y = y/scale
	kgPanelsConfig:UpdatePanel(frame.panel,frame:GetWidth(),frame:GetHeight(),x,y)	
end
--[[
-- Listens for guide frame movement
	FIXME for multi parents and anchors
--]]
function GuideFrame:MoveListener(frame)
	local panelFrame = kgPanels:FetchFrame(frame.panel)
	local scale,pscale = frame:GetEffectiveScale(),panelFrame:GetParent():GetEffectiveScale()
	local gX,gY = self:GetXY(frame.from,frame)
	local pX,pY = self:GetXY(frame.to,frame.anchor)
	local x = (gX * scale) - (pX * pscale)
	local y = (gY * scale) - (pY * pscale)
	x = x/scale
	y = y/scale
	panelFrame:ClearAllPoints()
	panelFrame:SetPoint(frame.from, frame.anchor, frame.to, x, y)
	kgPanelsConfig:UpdatePanel(frame.panel,frame:GetWidth(),frame:GetHeight(),x,y)	
end
--[[
-- Listen for guide frame resize
--]]
function GuideFrame:ResizeListener(frame)
	local panelFrame = kgPanels:FetchFrame(frame.panel)
	local scale,pscale = frame:GetEffectiveScale(),panelFrame:GetParent():GetEffectiveScale()
	local gX,gY = self:GetXY(frame.from,frame)
	local pX,pY = self:GetXY(frame.to,frame.anchor)
	local x = (gX * scale) - (pX * pscale)
	local y = (gY * scale) - (pY * pscale)
	x = x/scale
	y = y/scale
	panelFrame:SetWidth(frame:GetWidth())
	panelFrame:SetHeight(frame:GetHeight())
	panelFrame:ClearAllPoints()
	panelFrame:SetPoint(frame.from, frame.anchor, frame.to, x, y )
	kgPanelsConfig:UpdatePanel(frame.panel,frame:GetWidth(),frame:GetHeight(),x,y)	
end

function GuideFrame:GetXY(anchor,frame)
	if anchor == "TOPLEFT" then return frame:GetLeft(), frame:GetTop()
	elseif anchor == "LEFT" then return frame:GetLeft(), frame:GetBottom() + frame:GetHeight() / 2
	elseif anchor == "BOTTOMLEFT" then return frame:GetLeft(), frame:GetBottom()
	elseif anchor == "TOP" then return frame:GetLeft() + frame:GetWidth() / 2, frame:GetTop()
	elseif anchor == "CENTER" then return frame:GetLeft() + frame:GetWidth() / 2, frame:GetBottom() + frame:GetHeight() / 2
	elseif anchor == "BOTTOM" then return frame:GetLeft() + frame:GetWidth() / 2, frame:GetBottom()
	elseif anchor == "TOPRIGHT" then return frame:GetRight(), frame:GetTop()
	elseif anchor == "RIGHT" then return frame:GetRight(), frame:GetBottom() + frame:GetHeight() / 2
	elseif anchor == "BOTTOMRIGHT" then return frame:GetRight(), frame:GetBottom() end
end