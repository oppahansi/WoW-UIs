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

function Mazz3D:GetUnitNum(unitType)
    if (unitType == "player") then return 0
    elseif (unitType == "target") then return 1
    elseif (unitType == "party1") then return 2
    elseif (unitType == "party2") then return 3
    elseif (unitType == "party3") then return 4
    elseif (unitType == "party4") then return 5
    elseif (unitType == "partypet1") then return 6
    elseif (unitType == "partypet2") then return 7
    elseif (unitType == "partypet3") then return 8
    elseif (unitType == "partypet4") then return 9
    elseif (unitType == "pet") then return 10 end
end

function Mazz3D:RefreshCamera(Character)
	camera = Mazz3D_Model_Info[Character.ID].Character.camera;
	Character.model:SetModelScale(camera.scale);
	Character.model:SetPosition(camera.zoom, camera.position.panH, camera.position.panV);
	Character.model:SetRotation(camera.rotation);
end

function Mazz3D:GetModelPath(thisUnit)
    if (not thisUnit) then thisUnit = "target" end
    local modelPath = unitDB[thisUnit].Character.model:GetModel()
    if (type(modelPath) == "string") then return string.gsub (modelPath, "\\", "."); else return false; end
end

function Mazz3D:SaveCamera()
    if (UnitExists("target")) then
        local modelString = Mazz3D:GetModelPath()
        if (modelString) then
            Mazz3D_ModelDB[modelString] = Mazz3D:AddCamera(Mazz3D_Model_Info[1].Character.camera)
            Mazz3D:DebugPrint("Creating new camera |CFF00FF00"..(Mazz3D_ModelDB[modelString] or "?"))
        end
    end
end

function Mazz3D:LoadCamera(cameraNum, modelNum, char)
    if (not modelNum) then 
        modelNum = 1
        char = Mazz3D_Camera1
    end
    Mazz3D:DebugPrint("Loading camera |CFF00FF00"..cameraNum)
    local cameraInfo = Mazz3D_CameraDB[cameraNum]
    if cameraInfo then
        Mazz3D_Model_Info[modelNum].Character.camera.rotation = cameraInfo.rotation
        Mazz3D_Model_Info[modelNum].Character.camera.zoom = cameraInfo.zoom
        Mazz3D_Model_Info[modelNum].Character.camera.scale = cameraInfo.scale 
        Mazz3D_Model_Info[modelNum].Character.camera.position.panV = cameraInfo.position.panV
        Mazz3D_Model_Info[modelNum].Character.camera.position.panH = cameraInfo.position.panH
        Mazz3D:Character_Refresh(char);
    end
end    

function Mazz3D:GetCamera(unitType)
    if (not unitType) then unitType = "target" end;
    unitNum = Mazz3D:GetUnitNum(unitType)
    unitDB[unitType].Character:Show();
    Mazz3D:Character_Refresh(unitDB[unitType].Character)
    if (UnitExists(unitType)) then
        local modelPath = Mazz3D:GetModelPath(unitType)
        if (modelPath) then
            local cameraNum = Mazz3D_ModelDB[modelPath]
            if (cameraNum) then
                Mazz3D:LoadCamera(cameraNum, unitNum, unitDB[unitType].Character)
            else
                PlaySoundFile("Sound\\Character\\Human\\MaleNPC\\HumanPesantMale\\HumanPesantMaleWoundB.wav");
                Mazz3D:DebugPrint("No camera found!")
                Mazz3D:LoadCamera(1)
            end
        end
    end
end

function Mazz3D:AddCamera(cameraToAdd)
    if (Mazz3D.IsCameraSimilar) then
        for i = 1, table.getn(Mazz3D_CameraDB), 1 do
            if Mazz3D:IsCameraSimilar(Mazz3D_CameraDB[i], cameraToAdd) then
                Mazz3D:DebugPrint("...similar camera found at index |CFF00FF00"..i)
                return i;
            end
        end
    end
    local tempCamera = {}
    table.insert(Mazz3D_CameraDB, tempCamera)
    local cameraID = table.getn(Mazz3D_CameraDB)
    Mazz3D:WriteCameraSettings(cameraID, cameraToAdd)
    return cameraID
end

function Mazz3D:WriteCameraSettings(cameraID, cameraSettings, isOverwritten)
    Mazz3D_CameraDB[cameraID].position = {}
    Mazz3D_CameraDB[cameraID].rotation = cameraSettings.rotation
    Mazz3D_CameraDB[cameraID].zoom = cameraSettings.zoom
    Mazz3D_CameraDB[cameraID].scale = cameraSettings.scale
    Mazz3D_CameraDB[cameraID].position.panV = cameraSettings.position.panV
    Mazz3D_CameraDB[cameraID].position.panH = cameraSettings.position.panH
end