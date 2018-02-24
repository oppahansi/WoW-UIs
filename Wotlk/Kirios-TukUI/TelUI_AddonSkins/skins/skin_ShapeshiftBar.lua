--[[

    TukUI Skin for Shapeshift bar by Darth Android / Telroth-The Venture Co.

    TukUI partially skins the shapeshift bar, this finishes the job and adds
    the option to orient the bar in any of the 4 cardinal directions.
    
    To control orientation, there are two new variables in the
    actionbar section of config.lua:
    
    ["verticalshapeshift"] = true, -- Orient the shapeshift or totem bar vertically
    ["flipshapeshift"] = true, -- Expand shapeshift or totem bar down/left instead of up/right
    

]]

local skin,layout = TelUI.loadedSkin,TelUI.loadedLayout
if skin or not layout then return end

local GetNumShapeshiftForms = GetNumShapeshiftForms
Skin.SkinShapeshiftBar = function(self)
	ShapeshiftBarLeft:Hide()
	ShapeshiftBarRight:Hide()
	ShapeshiftBarMiddle:Hide()
	for i = 1,NUM_SHAPESHIFT_SLOTS do
		self:SkinButton(_G["ShapeshiftButton"..i])
		_G["ShapeshiftButton"..i]:SetSize(skin:ButtonSize(),skin:ButtonSize())
	end
end

Layout.PositionShapeshiftBar = dummy
Layout.LayoutShapeshiftBar = function(self)
	local pointS,pointD,offX,offY = "LEFT","RIGHT",skin:ButtonSpacing(),0
	if TelUI.layout.verticalShapeshift then
		pointS,pointD,offX,offY = "BOTTOM","TOP",offY,offX
	end
	if TelUI.layout.reverseShapeshift then
		pointS,pointD,offX,offY = pointD,pointS,-offX,-offY
	end
	for i = 2,NUM_SHAPESHIFT_SLOTS do
		_G["ShapeshiftButton"..i]:ClearAllPoints()
		_G["ShapeshiftButton"..i]:SetPoint(pointS,_G["ShapeshiftButton"..(i-1)],pointD,offX,offY)
	end
end

hooksecurefunc("ShapeshiftBar_Update",function() skin:SkinShapeshiftBar() end)
hooksecurefunc("ShapeshiftBar_UpdateState",function() skin:SkinShapeshiftBar() end)
hooksecurefunc("ShapeshiftBar_OnLoad",function() layout:LayoutShapeshiftBar() end)
hooksecurefunc("ShapeshiftBar_OnLoad",function() layout:PositionShapeshiftBar() end)
