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

Mazz3D = AceAddon:new({
	name 			= "Mazz3D",
	version			= "1.0",
	description 	= "Aww...look at them go!",
	author			= "Mazzlefizz of Argent Dawn",
	email			= "mazzlefizz@gmail.com",
	releaseDate		= "???",
	aceCompatible	= "103",
	category		= "interface",
})
Mazz3D:RegisterForLoad()

function Mazz3D:Enable()
end

function Mazz3D:Disable()
    ace:print("OMG.  Mazz3D cannot be disabled in-game!  Quit trying to be so clever.")
end

function Mazz3D:Init()
    Mazz3D_Status = {}
    Mazz3D_Status.DebugLogOn = nil
    Mazz3D_Status.CursorX,     Mazz3D_Status.CursorY     = nil, nil;
    Mazz3D_Status.CursorMoveX, Mazz3D_Status.CursorMoveY = nil, nil;
    Mazz3D_Status.LastClickTime = time()
    Mazz3D_Status.LastGuess, Mazz3D_Status.LastCachedGuess, Mazz3D_Status.CachedGuesses = nil, nil, {};
    Mazz3D_Status.LastAdjusted = 0;
	
	local theObject, theCharacterObject
	for i=0, 10, 1 do
	    theObject = CreateFrame("Frame", "Mazz3D_Camera"..i, getglobal(Mazz3D_Model_Info[i].Character.dufparent), "Mazz3D_CharacterTemplate");
	    theObject.model = getglobal("Mazz3D_Camera"..i.."_Character")
        theObject.ID = i
        theObject:EnableMouse(1)
        theObject.model:EnableMouse(false)
        theObject.model:EnableMouseWheel(false)
        Mazz3D:Character_Initialize(theObject)
        Mazz3D:RegisterCharacterScripts(theObject)
    end	
    
    if (not Mazz3D_CameraDB) then
        return
    end

    unitDB.player.Character = Mazz3D_Camera0
    unitDB.target.Character = Mazz3D_Camera1
    unitDB.party1.Character = Mazz3D_Camera2
    unitDB.party2.Character = Mazz3D_Camera3
    unitDB.party3.Character = Mazz3D_Camera4
    unitDB.party4.Character = Mazz3D_Camera5
    unitDB.partypet1.Character = Mazz3D_Camera6
    unitDB.partypet2.Character = Mazz3D_Camera7
    unitDB.partypet3.Character = Mazz3D_Camera8
    unitDB.partypet4.Character = Mazz3D_Camera9
    unitDB.pet.Character = Mazz3D_Camera10
    
    if (MazzleUI_Settings.Mazz3D.randomAnims) then
        Mazz3D:StartRandomAnims()
    end
    
    Mazz3D:RegisterBaseEvents()
    if (MazzleUI_Settings.Mazz3D.eventAnims) then
        Mazz3D:RegisterAnimEvents()
    end
    if (MazzleUI_Settings.Mazz3D.adjustModels) then
        Mazz3D:RegisterAdjustEvents()
    end

end

function Mazz3D:RegisterCharacterScripts(theCharacter)
    --Mazz3D:DebugPrint("Registering character scripts for "..(theCharacter:GetName() or "nil!!!"))
    theCharacter:SetScript("OnShow", Mazz3D.Character_OnShow)
    theCharacter:SetScript("OnHide", Mazz3D.Character_OnHide)
end

function Mazz3D:RegisterBaseEvents()
    Mazz3D:DebugPrint("Registering base events")
    self:RegisterEvent("PARTY_MEMBERS_CHANGED","Handle_PartyChange");    
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "Handle_TargetChange");    
	self:RegisterEvent("UNIT_MODEL_CHANGED","Handle_ModelChange");       
    self:RegisterEvent("UNIT_PORTRAIT_UPDATE","Handle_ModelChange");     
    self:RegisterEvent("UNIT_PET","Handle_PetEvent");                 
    self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS","Handle_ModelChange");
	self:RegisterEvent("PLAYER_ENTERING_WORLD","Handle_EnteringWorld");
	local theFrame
	for i=0, 10, 1 do
    	theFrame = getglobal("Mazz3D_Camera"..i)
        theFrame:SetScript("OnMouseDown", Mazz3D.GUI_OnMouseDown)
        theFrame:SetScript("OnMouseUp", Mazz3D.GUI_OnMouseUp)
    end
end

function Mazz3D:UnregisterBaseEvents()
    Mazz3D:DebugPrint("Unregistering base events")
    self:UnregisterEvent("PARTY_MEMBERS_CHANGED");    
    self:UnregisterEvent("PLAYER_TARGET_CHANGED");    
	self:UnregisterEvent("UNIT_MODEL_CHANGED");       
    self:UnregisterEvent("UNIT_PORTRAIT_UPDATE");     
    self:UnregisterEvent("UNIT_PET");                 
    self:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS");
	self:UnregisterEvent("PLAYER_ENTERING_WORLD");
	for i=0, 10, 1 do
    	theFrame = getglobal("Mazz3D_Camera"..i)
        theFrame:SetScript("OnMouseDown", nil)
        theFrame:SetScript("OnMouseUp", nil)
    end
end

function Mazz3D:RegisterAnimEvents()
    Mazz3D:DebugPrint("Registering animation events")
	self:RegisterEvent("UNIT_HEALTH","Handle_UnitHealth");
end

function Mazz3D:UnregisterAnimEvents()
    Mazz3D:DebugPrint("Unregistering animation events")
	self:UnregisterEvent("UNIT_HEALTH");
end

function Mazz3D:RegisterAdjustEvents()
    Mazz3D:DebugPrint("Registering camera control events")
    local theFrame
	for i=0, 10, 1 do
    	theFrame = getglobal("Mazz3D_Camera"..i)
        theFrame:SetScript("OnReceiveDrag", Mazz3D.GUI_OnMouseUp)
        theFrame:SetScript("OnMouseWheel", Mazz3D.GUI_OnMouseWheel)
    end
    Mazz3D_Camera1:EnableMouseWheel(1)
end

function Mazz3D:UnregisterAdjustEvents()
    Mazz3D:DebugPrint("Mazz3D: Unregistering adjust events")
    local theFrame
	for i=0, 10, 1 do
    	theFrame = getglobal("Mazz3D_Camera"..i)
        theFrame:SetScript("OnReceiveDrag",nil)
        theFrame:SetScript("OnMouseWheel",nil)
    end	
    Mazz3D_Camera1:EnableMouseWheel(false)
end

function Mazz3D:StartRandomAnims()
    Mazz3D:DebugPrint("Scheduling random animations.")
    Timex:AddSchedule("Mazz3D_RandomAnimTimer", 150, true,nil, Mazz3D.RandomAnim)
    Mazz3D:PlayRandomAnim(Mazz3D_Camera0)
end

function Mazz3D:StopRandomAnims()
    Mazz3D:DebugPrint("Removing schedule for random animations.")
    Timex:DeleteSchedule("Mazz3D_RandomAnimTimer")
end

function Mazz3D:Handle_TargetChange()
    Mazz3D:DebugPrint("Target change.")
    local updateList = {}
	if (UnitExists("target")) then
        table.insert(updateList, Mazz3D_Camera1)
        Mazz3D_Status.LastGuess = nil
        Mazz3D_Status.LastCachedGuess = nil
        Mazz3D_Status.CachedGuesses = {}
        Mazz3D:GetCamera()
        Mazz3D:ResetAnimation(Mazz3D_Camera1)
        Mazz3D_Camera1.lastHealth = UnitHealth("target")
        Mazz3D:UpdateDirtyCharacters(updateList)
    end
end

function Mazz3D:Handle_UnitHealth()
    if (UnitExists(arg1) and unitDB[arg1]) then
        local newHealth = UnitHealth(arg1)
        if (not Mazz3D:Character_HandleDeathEvent(unitDB[arg1].Character, arg1)) then
            if (UnitAffectingCombat(arg1) and (newHealth < unitDB[arg1].Character.lastHealth)) then
                Mazz3D:PlayRandomFlinch(unitDB[arg1].Character)
            end
        end
        unitDB[arg1].Character.lastHealth = newHealth
     end
end

function Mazz3D:Handle_PartyChange()
    local updateList = {}
    table.insert(updateList, Mazz3D_Camera2)
    table.insert(updateList, Mazz3D_Camera3)
    table.insert(updateList, Mazz3D_Camera4)
    table.insert(updateList, Mazz3D_Camera5)
    table.insert(updateList, Mazz3D_Camera6)
    table.insert(updateList, Mazz3D_Camera7)
    table.insert(updateList, Mazz3D_Camera8)
    table.insert(updateList, Mazz3D_Camera9)
    table.insert(updateList, Mazz3D_Camera10)
    for unit in unitDB do
        Mazz3D:Character_HandleDeathEvent(unitDB[unit].Character, unit)
        unitDB[unit].Character.lastHealth = UnitHealth(unit)
    end
    Mazz3D:UpdateDirtyCharacters(updateList)
end

function Mazz3D:Handle_ModelChange()
    local updateList = {}
    if (UnitExists(arg1) and unitDB[arg1]) then
        table.insert(updateList, unitDB[arg1].Character)
        Mazz3D:UpdateDirtyCharacters(updateList)
    end
end

function Mazz3D:Handle_PetEvent()
    local updateList = {}
    if (UnitExists(arg1) and unitDB[arg1] and unitDB[arg1].petname and UnitExists(unitDB[arg1].petname)) then
        table.insert(updateList, unitDB[unitDB[arg1].petname].Character)
        unitDB[unitDB[arg1].petname].Character.lastHealth = UnitHealth(unitDB[arg1].petname)
        Mazz3D:UpdateDirtyCharacters(updateList)
    end
end

function Mazz3D:Handle_EnteringWorld()
    local updateList = {}
    if (Mazzifier_Progress == 2) then
	    for _,petType in {"pet", "partypet1", "partypet2", "partypet3", "partypet4"} do
	        if (UnitExists(petType)) then
        	    table.insert(updateList, unitDB[petType].Character)
        	end
        end
	end
    if (table.getn(updateList) > 0) then Mazz3D:UpdateDirtyCharacters(updateList) end
end

function Mazz3D:UpdateDirtyCharacters(updateList)
    if (table.getn(updateList)>0) then
        for _,thisCharacter in updateList do
            Mazz3D:GetCamera(thisCharacter.unitType)
            Mazz3D_Model_Info[thisCharacter.ID].Character.isRendered = false;
        	Mazz3D:Character_AttemptToRender(thisCharacter, true);
        end
    end
end

function Mazz3D:DebugPrint(debugStr, forceLog)
    if MazzleUI_Settings.Mazz3D.debugCamera then
        MazzleUI:DebugPrint(debugStr, forceLog, "Mazz3D")
    end
end
