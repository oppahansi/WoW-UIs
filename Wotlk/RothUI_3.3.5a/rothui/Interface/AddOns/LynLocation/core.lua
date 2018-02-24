local addon = CreateFrame("Frame", nil, UIParent)
-- frame
local frame_anchor = "BOTTOMLEFT"
local frame_x = 750
local frame_y = 5
-- font
local font = "Fonts\\ARIALN.ttf"
local size = 11
local outline = true 
local shadow = false
local classcolors = false -- true/false - if false, it uses "color" (2 line below)
local class = RAID_CLASS_COLORS[select(2, UnitClass("player"))] -- dont change
local color = { r=156/255, g=144/255, b=125/255 }
local text_anchor = "CENTER"
-- used locals

local x, y, text, zone
-- new
function addon:new()
	-- frame position
	--self:SetPoint(frame_anchor, UIParent, frame_anchor, frame_x, frame_y)
	self:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -30)
	self:SetWidth(250)
	self:SetHeight(13)
	-- create fontstring
	text = self:CreateFontString(nil, "OVERLAY")
	-- text style
	if outline == true then
		text:SetFont(font, size, "OUTLINE")
	else
		text:SetFont(font, size, nil)
	end
	if classcolors == true then
		text:SetTextColor(class.r, class.g, class.b)
	else
		text:SetTextColor(color.r, color.g, color.b)
	end
	if shadow == true then
		text:SetShadowOffset(1, -1)
	else
		text:SetShadowOffset(0, 0)
	end
	text:SetPoint(text_anchor, self)
	
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	-- update
	self:SetScript("OnUpdate", self.update) 
	self:SetScript("OnEvent", self.event)
end
function addon:event()
	if (event == "ZONE_CHANGED_NEW_AREA") then 
		SetMapToCurrentZone()
	end
end
-- update function
function addon:update()
	-- get zone map
	zone = GetMinimapZoneText()
	zone = "|c009C907D"..zone.."|r"
	-- get player x,y
	x, y = GetPlayerMapPosition("player")
	-- if x and y 0 then boo
	if(x == 0 and y == 0) then
		coords = "";
	else
		coords = " "..format("%.2d / %.2d",x*100,y*100)
	end
	-- set it
	text:SetText(zone..coords) 
end
-- fire
addon:new()