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

function Mazz3D:GUI_OnMouseDown()
    Mazz3D_Status.LastClickTime = time()
	if (MazzleUI_Settings.Mazz3D.adjustModels) then 
	    this:SetScript("OnUpdate", Mazz3D.Character_OnUpdate);
        Mazz3D_Model_Info[this.ID].GUI.isEnabled = true;
    end
    if (arg1 == "LeftButton") then
		Mazz3D:GUI_SetActiveButton(this, arg1);
		--TargetUnit(this.unitType)
    elseif (arg1 == "RightButton") then
        if ((this.unitType == "player") or (this.unitType == "party1") or 
            (this.unitType == "party2") or (this.unitType == "party3") or
            (this.unitType == "party4")) then
	        Mazz3D:PlayRandomAnim(this)
	        MazzleUI:MouseClickEffect()
	    end
    end
end

function Mazz3D:GUI_HandleMouseDown(theCharacter)
    Mazz3D:GUI_Rotate(theCharacter);
    Mazz3D:GUI_Zoom(theCharacter);
    Mazz3D:GUI_Shrink(theCharacter);
    Mazz3D:GUI_Pan(theCharacter);
end

function Mazz3D:GUI_OnMouseUp()
    if (not this.animNum) then
    	this:SetScript("OnUpdate", nil)
    end
    Mazz3D_Model_Info[this.ID].GUI.isEnabled = false;
	Mazz3D:GUI_SetActiveButton(this);
    if ( ((time() - Mazz3D_Status.LastClickTime) < 1)) then
        if ((arg1 == "LeftButton" ) and (this.unitType ~= "target")) then
    		TargetUnit(this.unitType)
        elseif (arg1 == "RightButton") then
    		DUF_UnitPopup_ShowMenu(this.unitType)
        end
    end
	Mazz3D_Status.CursorX,     Mazz3D_Status.CursorY     = nil, nil;
	Mazz3D_Status.CursorMoveX, Mazz3D_Status.CursorMoveY = nil, nil;
end

function Mazz3D:GUI_OnMouseWheel()
    if ((this == Mazz3D_Camera1) and arg1) then
    	local scale = Mazz3D_Model_Info[this.ID].Character.camera.scale
    	scale = Mazz3D:GUI_GetControlConstraint(scale + (0.05*arg1), 0.10, 10, false);
        if (scale ~= nil and scale ~= Mazz3D_Model_Info[this.ID].Character.camera.scale) then
            this.model:SetModelScale(scale);
            Mazz3D_Model_Info[this.ID].Character.camera.scale = scale;
        end
    end
end

function Mazz3D:GUI_GetCursorMovement()
	if (Mazz3D_Status.CursorMoveX == nil or Mazz3D_Status.CursorMoveY == nil) then
		local previousX, previousY = Mazz3D_Status.CursorX, Mazz3D_Status.CursorY;
		Mazz3D_Status.CursorX, Mazz3D_Status.CursorY = GetCursorPosition();
		if (previousX == nil or previousY == nil) then
			previousX, previousY = Mazz3D_Status.CursorX, Mazz3D_Status.CursorY;
		end
		Mazz3D_Status.CursorMoveX = (Mazz3D_Status.CursorX - previousX) / UIParent:GetEffectiveScale();
		Mazz3D_Status.CursorMoveY = (Mazz3D_Status.CursorY - previousY) / UIParent:GetEffectiveScale();
	end
	
	return Mazz3D_Status.CursorMoveX, Mazz3D_Status.CursorMoveY;
end

function Mazz3D:GUI_SetButton(theCharacter, controlName, mouseButton, keyModifier)
	cc = Mazz3D_Model_Info[theCharacter.ID].GUI;
	if (keyModifier == nil) then
		keyModifier = "NOKEY";
	end
	if (controlName ~= nil) then
		cc[mouseButton][keyModifier] = { ["name"] = controlName };
	else
		cc[mouseButton][keyModifier] = nil;
	end
end

function Mazz3D:GUI_SetActiveButton(theCharacter, mouseButton)
	cc = Mazz3D_Model_Info[theCharacter.ID].GUI;
	if (mouseButton == nil) then
		cc.active = nil;
		return;
	end
	if (IsAltKeyDown()) then
		keyModifier = "ALT";
	elseif (IsControlKeyDown()) then
		keyModifier = "CTRL";
	elseif (IsShiftKeyDown()) then
		keyModifier = "SHIFT";
	else
		keyModifier = "NOKEY";
	end
	if (cc[mouseButton][keyModifier] ~= nil) then
		cc.active = cc[mouseButton][keyModifier];
	else
		cc.active = nil;
	end
end

function Mazz3D:GUI_IsActive(theCharacter, controlName)
	local active = Mazz3D_Model_Info[theCharacter.ID].GUI.active;
	if (controlName ~= nil and active ~= nil and controlName == active.name) then
		return true;
	end
	return false;
end

function Mazz3D:GUI_GetControlIntensity(Character, modAmountPerUnit)
	boundryWidth = Character:GetWidth();
	boundryHeight = Character:GetHeight();
	if (boundryHeight == nil) then
		boundryHeight = boundryWidth;
	end
	local modAmount;
	if (modAmountPerUnit == nil) then
		modAmountPerUnit = 0;
	elseif (boundryWidth > boundryHeight) then
		modAmount = modAmountPerUnit / (boundryWidth / 100);
	elseif (boundryHeight <= 0) then
		-- Shouldn't be able (or want) to size to 0, but just in case.
		modAmount = modAmountPerUnit;
	else
		modAmount = modAmountPerUnit / (boundryHeight / 100);
	end
	return modAmount;
end

function Mazz3D:GUI_GetControlConstraint(modify, min, max, loop)
	if (min ~= nil) then
		if (modify < min and not loop) then
			modify = min;
		elseif (modify < min and loop and max ~= nil) then
			modify = max;
		end
	end
	if (max ~= nil) then
		if (modify > max and not loop) then
			modify = max;
		elseif (modify > max and loop and min ~= nil) then
			modify = min;
		end
	end
	return modify;
end

function Mazz3D:GUI_Rotate(theCharacter)
	if (  Mazz3D:GUI_IsActive(theCharacter, "Rotate")  ) then
		changeX, changeY = Mazz3D:GUI_GetCursorMovement();
		if (changeX ~= 0) then
			local mod = Mazz3D:GUI_GetControlIntensity(theCharacter, 0.033);
			local rotation = Mazz3D_Model_Info[theCharacter.ID].Character.camera.rotation
			rotation = Mazz3D:GUI_GetControlConstraint(rotation + (mod * changeX), -3.1, 3.099999999999, true);
            if (rotation ~= nil and rotation > 3.099999999999) then
                rotation = -3.1;
            elseif (rotation ~= nil and rotation < -3.1) then
                rotation = 3.099999999999;
            end
            if (rotation ~= nil and rotation ~= Mazz3D_Model_Info[theCharacter.ID].Character.camera.rotation) then
                theCharacter.model:SetRotation(rotation);
                Mazz3D_Model_Info[theCharacter.ID].Character.camera.rotation = rotation;
            end
		end
	end
end

function Mazz3D:GUI_Zoom(theCharacter)
	if (  Mazz3D:GUI_IsActive(theCharacter, "Zoom")  ) then
		changeX, changeY = Mazz3D:GUI_GetCursorMovement();
		if (changeY ~= 0) then
			local mod = Mazz3D:GUI_GetControlIntensity(theCharacter, 0.035);
			local zoom = Mazz3D_Model_Info[theCharacter.ID].Character.camera.zoom
			zoom = Mazz3D:GUI_GetControlConstraint(zoom + (mod * changeY), -20, 5, false);
            if (zoom ~= nil and zoom ~= Mazz3D_Model_Info[theCharacter.ID].Character.camera.zoom) then
                theCharacter.model:SetPosition(zoom, Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panH, Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panV);
                Mazz3D_Model_Info[theCharacter.ID].Character.camera.zoom = zoom;
            end
		end
	end
end

function Mazz3D:GUI_Shrink(theCharacter)
	if (  Mazz3D:GUI_IsActive(theCharacter, "Shrink")  ) then
		changeX, changeY = Mazz3D:GUI_GetCursorMovement();
		if (changeY ~= 0) then
			local mod = Mazz3D:GUI_GetControlIntensity(theCharacter, 0.0055);
			local scale = Mazz3D_Model_Info[theCharacter.ID].Character.camera.scale
			scale = Mazz3D:GUI_GetControlConstraint(scale + (mod * changeY), 0.10, 10, false);
            if (scale ~= nil and scale ~= Mazz3D_Model_Info[theCharacter.ID].Character.camera.scale) then
                theCharacter.model:SetModelScale(scale);
                Mazz3D_Model_Info[theCharacter.ID].Character.camera.scale = scale;
            end
		end
	end
end

function Mazz3D:GUI_Pan(theCharacter)
	if (Mazz3D:GUI_IsActive(theCharacter, "Pan")) then
		changeX, changeY = Mazz3D:GUI_GetCursorMovement();
		if (changeX ~= 0 or changeY ~= 0) then
			local mod = Mazz3D:GUI_GetControlIntensity(theCharacter, 0.03075);
			local h = Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panH
			local v = Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panV
			h = Mazz3D:GUI_GetControlConstraint(h + (mod * changeX), -50, 50, true);
			v = Mazz3D:GUI_GetControlConstraint(v + (mod * changeY), -50, 50, true);
            if (h == nil) then
                h = Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panH;
            end
            if (v == nil) then
                v = Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panV;
            end
            if (h ~= Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panH or v ~= Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panV) then
                theCharacter.model:SetPosition(Mazz3D_Model_Info[theCharacter.ID].Character.camera.zoom, h, v);
                Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panH = h;
                Mazz3D_Model_Info[theCharacter.ID].Character.camera.position.panV = v;
            end
		end
	end
end