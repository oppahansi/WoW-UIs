-- Copyright © 2006 Mazin Assanie
-- All Rights Reserved.
-- 
-- Permission to use, copy, modify, and distribute this software in any way
-- is not granted without expressed written agreement.  In the case that it
-- is granted, the above copyright notice and this paragraph must appear in
-- all copies, modifications, and distributions.
--
-- To contact the author of this work, use mazzlefizz@gmail.com 
-- For more information on copyright, visit http://copyright.gov/ or http://whatiscopyright.org/
--

function Mazz3D:Character_OnUpdate()
	Mazz3D:Character_AttemptToRender(this);
	if (Mazz3D_Model_Info[this.ID].GUI.isEnabled) then
		local activeControl = Mazz3D_Model_Info[this.ID].GUI.active;
		if (activeControl ~= nil) then
			Mazz3D:GUI_GetCursorMovement(); -- Calculate movement for controls
		    Mazz3D:GUI_HandleMouseDown(this)
		    Mazz3D_Status.CursorMoveX, Mazz3D_Status.CursorMoveY = nil, nil;
		end
	end
    if this.animNum then
		this.frameTime = this.frameTime + (arg1 * 1000);
		this.model:SetSequenceTime(this.animNum,this.frameTime);
		if this.frameEndTime then
    		if this.frameTime > this.frameEndTime then
    		    if this.nextAnim then
    		        Mazz3D:StartAnimation(this, this.nextAnim)
    		    else
    		        Mazz3D:ResetAnimation(this)
    		    end
    		end
        end
    end
end

function Mazz3D:Character_OnShow()
    Mazz3D_Model_Info[this.ID].Character.isRendered = false;
	Mazz3D:Character_AttemptToRender(this, true);
    Mazz3D:GetCamera(this.unitType);
end

function Mazz3D:Character_OnHide()
	Mazz3D:GUI_OnMouseUp();
	this.model:ClearModel();
	Mazz3D_Model_Info[this.ID].Character.isRendered = true;
end

function Mazz3D:Character_Initialize(Character)

	local profile = Mazz3D_Model_Info[Character.ID];
    Character.unitType = profile.Character.unitType
    Character.lastHealth = UnitHealth(Character.unitType)

	Character:Show();
	Character:SetBackdropColor(0,0,0,0);
	Character:SetScale(1)
	Character:SetParent(profile.Character.dufparent);
	Character:SetWidth(profile.scale.width);
	Character:SetHeight(profile.scale.height);
	Character:ClearAllPoints()
	if (not profile.anchor.relative) then profile.anchor.relative = "BOTTOM"; end
	if (not profile.anchor.relativeTo) then profile.anchor.relativeTo = "BOTTOM"; end
	Character:SetPoint(profile.anchor.relative, profile.anchor.anchorParent, profile.anchor.relativeTo, profile.anchor.x, profile.anchor.y);

	Character.model:SetWidth(profile.scale.width);
	Character.model:SetHeight(profile.scale.height);
    Character.model:ClearAllPoints()
    Character.model:SetAllPoints(Character)

    Character.renderTick = 0;
	Mazz3D:ResetAnimation(Character)
	Mazz3D:Character_HandleDeathEvent(Character)
	Mazz3D_Model_Info[Character.ID].Character.isRendered = false;
	Mazz3D:Character_AttemptToRender(Character, true);

    Mazz3D:GUI_SetButton(Character, "Rotate", "LeftButton", "NOKEY");
    Mazz3D_Model_Info[Character.ID].Character.isRendered = false;

    if (Character.unitType == "target") then
        Mazz3D:GUI_SetButton(Character, "Pan", "LeftButton", "SHIFT");
        Mazz3D:GUI_SetButton(Character, "Shrink", "LeftButton", "CTRL");
        Mazz3D:GUI_SetButton(Character, "Zoom", "LeftButton", "ALT");
    end

    if (UnitExists(Character.unitType)) then Character:Show(); else Character:Hide(); end
	Mazz3D:RefreshCamera(Character);

end

function Mazz3D:Character_SetScale(Character, width, height)
	local changed = false;

	-- Get Width Constraint
	if (width ~= nil) then
        if (width > UIParent:GetWidth() / UIParent:GetEffectiveScale()) then
    		width = UIParent:GetWidth() / UIParent:GetEffectiveScale();
    	elseif (width < 20) then
    		width = 20;
    	end
    end
	if (width ~= nil and width ~= Character:GetWidth()) then
		Character:SetWidth(width);
		Mazz3D_Model_Info[Character.ID].scale.width = width;
		changed = true;
	end
	
	-- Get Height Constraint
	if (height ~= nil) then
    	if (height > UIParent:GetHeight() / UIParent:GetEffectiveScale()) then
    		height = UIParent:GetHeight() / UIParent:GetEffectiveScale();
    	elseif (height < 20) then
    		height = 20;
    	end
    end

	if (height ~= nil and height ~= Character:GetHeight()) then
		Character:SetHeight(height);
		Mazz3D_Model_Info[Character.ID].scale.height = height;
		changed = true;
	end
	if (changed) then
		-- Make sure the new bounding box size doesn't exceed its borders.
		local x, y = Mazz3D:Character_GetPositionConstraint(Character);
		Character:SetPoint("BOTTOMLEFT", x, y);
		Mazz3D_Model_Info[Character.ID].anchor.x = x;
		Mazz3D_Model_Info[Character.ID].anchor.y = y;
	end
end

function Mazz3D:Character_GetPositionConstraint(Character, x, y)
	if (x == nil) then
		x = Character:GetLeft();
	end
	if (y == nil) then
		y = Character:GetBottom();
	end
	-- Determine left and right boundries
	local parentBoundry = UIParent:GetWidth() / UIParent:GetEffectiveScale();
	if (x < 0 and x + Character:GetWidth() > parentBoundry) then
		Character:SetWidth(parentBoundry);
		Mazz3D_Model_Info[Character.ID].scale.width = parentBoundry;
	elseif (x < 0) then
		x = 0;
	elseif (x + Character:GetWidth() > parentBoundry) then
		x = parentBoundry - Character:GetWidth();
	end
	-- Determine top and bottom boundries
	parentBoundry = UIParent:GetHeight() / UIParent:GetEffectiveScale();
	if (y < 0 and y + Character:GetHeight() > parentBoundry) then
		Character:SetHeight(parentBoundry);
		Mazz3D_Model_Info[Character.ID].scale.height = parentBoundry;
	elseif (y < 0) then
		y = 0;
	elseif (y + Character:GetHeight() > parentBoundry) then
		y = parentBoundry - Character:GetHeight();
	end
	return x, y;
end

function Mazz3D:Character_Refresh(Character)
    Character.model:SetModelScale(1);
    Character.model:SetPosition(0, 0, 0);
    Character.model:ClearModel();
    Character.model:SetUnit(Character.unitType);
    Mazz3D:RefreshCamera(Character);
end

function Mazz3D:Character_AttemptToRender(Character, tick)
    -- The rendering tick, in practice, only effects joining a party where
    -- the members are too far away to be rendered. This will continue to
    -- refresh the party member until it ticks while within dueling range.
    if (Character.renderTick < 4000) then
        Character.renderTick = Character.renderTick + 1;
    else
        Character.renderTick = 0;
        tick = true;
    end
    if (tick) then
        Character.renderTick = 0;
        if (not Mazz3D_Model_Info[Character.ID].Character.isRendered) then
            Mazz3D:Character_Refresh(Character);
        	if (UnitExists(Character.unitType) and UnitIsVisible(Character.unitType)) then
                Mazz3D_Model_Info[Character.ID].Character.isRendered = true;
            else
                -- Model *might* have rendered, until the target is within
                -- dueling range, we can't be sure. Continue to attempt
                -- rendering until we're sure.
            end
        end
    end
end

function Mazz3D:Character_HandleDeathEvent(Character)
    local isAlive = (not UnitIsDead(Character.unitType))
        
    if (Character.isAlive and (not isAlive)) then
        Character.isAlive = nil
        Mazz3D:StartAnimation(Character, "Death")
        return 1
    end
    if ((not Character.isAlive) and isAlive and (UnitHealth(Character.unitType)>1)) then
        Character.isAlive = true
        Mazz3D:StartAnimation(Character, "Roar")
        return 1
    end
    return nil
end
    
function Mazz3D:RandomAnim()
    if (math.random(100)<20) then
        Mazz3D:PlayRandomAnim(Mazz3D_Camera0)
    end
    if (UnitExists("party1")) then
        if (math.random(100)<20) then
            Mazz3D:PlayRandomAnim(Mazz3D_Camera2)
        end
    end
    if (UnitExists("party2")) then
        if (math.random(100)<20) then
            Mazz3D:PlayRandomAnim(Mazz3D_Camera3)
        end
    end
    if (UnitExists("party3")) then
        if (math.random(100)<20) then
            Mazz3D:PlayRandomAnim(Mazz3D_Camera4)
        end
    end
    if (UnitExists("party4")) then
        if (math.random(100)<20) then
            Mazz3D:PlayRandomAnim(Mazz3D_Camera5)
        end
    end
end        

function Mazz3D:PlayRandomAnim(Character)
    if (not Character.animNum) then
        local randomAnims = { "Wave", "Rude", "Roar", "Kiss", "Chicken", "Flex" }
        local chosenAnim = randomAnims[math.random(table.getn(randomAnims))]
        Mazz3D:StartAnimation(Character, chosenAnim)
    end
end

function Mazz3D:PlayRandomFlinch(Character)
    local randomAnims = { "Flinch", "Flinch2" }
    local chosenAnim = randomAnims[math.random(2)]
    Mazz3D:StartAnimation(Character, chosenAnim)
end

function Mazz3D:StartAnimation(Character, animName)
    Character.animNum = animDB[animName].animNum
    Character.nextAnim = animDB[animName].nextAnim
    Character.frameTime = 0
    Character.frameEndTime = animDB[animName].duration
    Character:SetScript("OnUpdate",  Mazz3D.Character_OnUpdate)
end

function Mazz3D:ResetAnimation(Character)
    Character.animNum = nil
    Character.nextAnim = nil
    Character.frameTime = 0
    Character.frameEndTime = 0
    if (not Mazz3D_Model_Info[Character.ID].GUI.isEnabled) then
        Character:SetScript("OnUpdate",  nil)
    end
end