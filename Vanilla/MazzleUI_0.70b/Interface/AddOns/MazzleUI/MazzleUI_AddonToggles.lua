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

local MazzleUI_MinimapButtons = {"ChatmanagerMenuButtonFrame",  "CECBMiniMapButton", "MazzleUI_FastCastButton", "MazzleUI_EfficiencyButton", "MazzleUI_RecapButton", }

function MazzleUI:Addon_Initialize(numCall)
    if (not numCall) then numCall = 1; end;
    if (DFM_INITIALIZED) then 
        -- Initialize raid frames and related variables
        MazzleUI:Handle_GroupChanges()

        -- Adjust position of minimap buttons
        local lastFrameName = "MazzleUI_OptionsButton"
        for _,theButton in MazzleUI_MinimapButtons do
            if (getglobal(theButton) and getglobal(theButton):IsVisible()) then
                MazzleUI_SetValue("DFM_Settings.MazzleUI._MinimapButtons."..theButton..".Location.frame", lastFrameName)
                DFM_Initialize_Frame("_MinimapButtons",theButton)
                lastFrameName = theButton
            end
        end
    elseif (numCall < 20) then
        Timex:AddSchedule("MazzleUI_AddonInitTimer", 5, nil, nil, MazzleUI.Addon_Initialize, (numCall + 1))
    end
end
function MazzleUI:HotSpot_Handle(hotSpotNumber, owner)
    if (owner) then
        GameTooltip:SetOwner(owner,"ANCHOR_LEFT")
    end

    if (hotSpotNumber == 0) then
    	if (owner) then
        	GameTooltip:AddLine("Left-click to show/hide bag and menu bar.")
        	if (MazzleUI_Settings.HotSpots.RaidCycle) then
            	GameTooltip:AddLine("Right-click to cycle through different raid layouts.")
        	end
        else
            if (MazzleUI_Settings.HotSpots.RaidCycle and arg1 and (arg1 == "RightButton")) then
                MazzleUI:NextView(1)
            else
                MazzleUI:BarsToggle()
            end
        end
    elseif ((hotSpotNumber == 1) and MazzleUI_Settings.HotSpots.MonkeyQuest) then
    	if (owner) then
            GameTooltip:SetOwner(owner,"ANCHOR_RIGHT")
        	GameTooltip:AddLine("Click to toggle MonkeyQuest.")
        else
            MazzleUI:MonkeyQuestToggle()
        end
    elseif ((hotSpotNumber == 2) and MazzleUI_Settings.HotSpots.Notebook) then
    	if (owner) then
            GameTooltip:SetOwner(owner,"ANCHOR_RIGHT")
        	GameTooltip:AddLine("Click to toggle TinyPad.")
        else
            MazzleUI:NotebookToggle()
        end
    elseif ((hotSpotNumber == 3) and MazzleUI_Settings.HotSpots.NeedyList) then
    	if (owner) then
        	GameTooltip:AddLine("Left-click to toggle your context menu.")
        else
            MazzleUI:ShowContextMenu(true)
        end
    elseif ((hotSpotNumber == 4) and MazzleUI_Settings.HotSpots.ItemRack) then
    	if (owner) then
        	GameTooltip:AddLine("Click to toggle ItemRack.")
        else
            MazzleUI:ItemRackToggle()
        end
    elseif ((hotSpotNumber == 5) and MazzleUI_Settings.HotSpots.KCI) then
    	if (owner) then
            GameTooltip:SetOwner(owner,"ANCHOR_TOPLEFT")
        	GameTooltip:AddLine("Click to toggle KC Item Database.")
        else
            MazzleUI:KCToggle()
        end
    elseif ((hotSpotNumber == 6) and MazzleUI_Settings.HotSpots.Compass) then
    	if (owner) then
    	    return
        else
            MazzleUI:ToggleMap()
        end
    elseif ((hotSpotNumber == 7) and MazzleUI_Settings.HotSpots.xCalc) then
    	if (owner) then
            GameTooltip:SetOwner(owner,"ANCHOR_TOPRIGHT")
        	GameTooltip:AddLine("Click to toggle xCalc.")
        else
            MazzleUI:ToggleXCalc()
        end
    elseif ((hotSpotNumber == 8) and MazzleUI_Settings.HotSpots.ToT) then
    	if (owner) then
    	    return
        else
            TargetUnit("targettarget");
        end
    end
    if (owner) then
        GameTooltip:Show()
    else
        MazzleUI:MouseClickEffect()
    end
end

function MazzleUI:ToggleXCalc()
    if (xcalc_windowdisplay) then
        xcalc_windowdisplay()
    end
end

function MazzleUI:MonkeyQuestToggle()
    if IsAddOnLoaded("MonkeyQuest") then
        MonkeyQuestSlash_ToggleDisplay()
    end
end

function MazzleUI:NotebookToggle()
    if IsAddOnLoaded("TinyPad") then
        if (TinyPadFrame:IsVisible()) then 
            TinyPadFrame:Hide() 
        else 
            TinyPadFrame:Show()
        end
    end
end

function MazzleUI:BarsToggle()
    if (DAB_OtherBar_Bag) then
        if (DAB_OtherBar_Bag:IsVisible()) then 
            DAB_OtherBar_Hide(13)
            DAB_OtherBar_Hide(14)
        else
            DAB_OtherBar_Show(13)
            DAB_OtherBar_Show(14)
        end
    end
end

function MazzleUI:ItemRackToggle()
    if IsAddOnLoaded("ItemRack") then
        ItemRack_Toggle()
    end
end

function MazzleUI:KCToggle()
    if IsAddOnLoaded("KC_Items") then
		if (KC_LinkviewFrame:IsVisible()) then
			KC_LinkviewFrame:Hide()
        else
            KC_LinkviewFrame:Show()			
		end
    end
end

function MazzleUI:ToggleMap()
    if ToggleAlphaMap then ToggleAlphaMap(); end
end

function MazzleUI:ToggleRecap(side)
    if IsAddOnLoaded("Recap") then
        if (side and (side == "RightButton")) then
            if (recap.Opt.State.value == "Idle") or (recap.Opt.State.value == "Active") then
        	    Recap_SetState("Stopped")
                MazzleUI:HilightButton("RecapButton", true)
            	UIErrorsFrame:AddMessage("Recap combat tracking now OFF.", 1.0, 0.0, 0.0, 1.0, 0.1);
        	else
        	    Recap_SetState("Idle")
                MazzleUI:HilightButton("RecapButton", false)
            	UIErrorsFrame:AddMessage("Recap combat tracking now ON.", 0.0, 1.0, 0.0, 1.0, 0.1);
        	end
        else
            RecapFrame_Toggle();
        end
    end
end

function MazzleUI:FastCastIsOn()
    if ((Mazzifier_PlayerClass ~= "Rogue") and FastcastState) then
        return (FastCast_IsEnabled())
    else
        return nil
    end
end


function MazzleUI:ToggleFastCast(side)
    if (IsAddOnLoaded("FastCast")) then
        if (side and (side == "RightButton")) then
            FastcastFrame:Show();
        else
            if (MazzleUI:FastCastIsOn()) then
                Fastcast_SlashCommand("fast off")
                MazzleUI:HilightButton("FastCastButton", false)
            	UIErrorsFrame:AddMessage("Cirk's FastCast is now OFF.", 1.0, 0.0, 0.0, 1.0, 0.1);
            else
                Fastcast_SlashCommand("fast on")
                MazzleUI:HilightButton("FastCastButton", true)
            	UIErrorsFrame:AddMessage("Cirk's FastCast is now ON.  Compensating for high latency.", 0.0, 1.0, 0.0, 1.0, 0.1);
            end
        end
    end
end

function MazzleUI:ToggleHelp()
    local addon_name = "MazzleHelp"
    if (not IsAddOnLoaded(addon_name)) then
        LoadAddOn(addon_name)
    end
    if (getglobal(addon_name.."_Frame"):IsVisible()) then
        getglobal(addon_name.."_Hide")()
    else
        getglobal(addon_name.."_Show")()
    end
end

function MazzleUI:ToggleOptions()
    local addon_name = "MazzleOptions"
    if (not IsAddOnLoaded(addon_name)) then
        LoadAddOn(addon_name)
    end
    if (getglobal(addon_name.."_Frame"):IsVisible()) then
        getglobal(addon_name.."_Hide")()
    else
        getglobal(addon_name.."_Show")()
    end
end

function MazzleUI:HideDAB()
	MazzleUI_Status.DABHide = {}
	MazzleUI_Status.DABHide.floaters = {}
	MazzleUI_Status.DABHide.CBs = {}
	for i=1,10,1 do
    	MazzleUI_Status.DABHide[i] = getglobal("DAB_ActionBar_"..i):IsVisible();
    	getglobal("DAB_ActionBar_"..i):Hide();
	end
	for i=1,10,1 do
    	MazzleUI_Status.DABHide.CBs[i] = getglobal("DAB_ControlBox_"..i):IsVisible();
    	getglobal("DAB_ControlBox_"..i):Hide();
	end
	for floater in DAB_Settings[DAB_INDEX].Floaters do
    	MazzleUI_Status.DABHide.floaters[floater] = getglobal("DAB_ActionButton_"..floater):IsVisible();
    	getglobal("DAB_ActionButton_"..floater):Hide();
	end
end

function MazzleUI:ShowDAB()
	if (MazzleUI_Status.DABHide) then
    	for i=1,10,1 do
    	    if (MazzleUI_Status.DABHide[i]) then
            	getglobal("DAB_ActionBar_"..i):Show();
            end
    	end
    	for i=1,10,1 do
    	    if (MazzleUI_Status.DABHide.CBs[i]) then
            	getglobal("DAB_ControlBox_"..i):Show();
            end
    	end
    	for floater in MazzleUI_Status.DABHide.floaters do
    	    if (MazzleUI_Status.DABHide.floaters[floater]) then
            	getglobal("DAB_ActionButton_"..floater):Show();
            end
    	end
    end
end

function MazzleUI:ToggleEfficiency()
    if (MazzleUI_Status.isManual) then
        MazzleUI_Status.isManual = false
        MazzleUI:InstantiateEfficiencyMode(true)
        MazzleUI:HilightButton("EfficiencyButton", false)
    else
        MazzleUI_Status.isManual = true
        MazzleUI:InstantiateEfficiencyMode()
        MazzleUI:HilightButton("EfficiencyButton", true)
    end
end

function MazzleUI:InstantiateEfficiencyMode(forceReInit)
   if (MazzleUI_Status.isManual) then
        if (MazzleUI_Status.currentEfficiencyMode == "manual" and (not forceReInit)) then return; else
            MazzleUI_Status.currentEfficiencyMode = "manual"
            MazzleUI_EfficiencyButton:SetText("M")
        end
   elseif (MazzleUI_Settings.Performance_Enabled["pvp"] and MazzleUI_Status.inPvP) then
        if (MazzleUI_Status.currentEfficiencyMode == "pvp" and (not forceReInit)) then return; else
            MazzleUI_Status.currentEfficiencyMode = "pvp"
            MazzleUI_EfficiencyButton:SetText("V")
        end
   elseif (MazzleUI_Settings.Performance_Enabled["raid"] and MazzleUI_Status.inRaid) then
        if (MazzleUI_Status.currentEfficiencyMode == "raid" and (not forceReInit)) then return; else
            MazzleUI_Status.currentEfficiencyMode = "raid"
            MazzleUI_EfficiencyButton:SetText("R")
        end
   elseif (MazzleUI_Settings.Performance_Enabled["party"] and MazzleUI_Status.inParty) then
        if (MazzleUI_Status.currentEfficiencyMode == "party" and (not forceReInit)) then return; else
            MazzleUI_Status.currentEfficiencyMode = "party"
            MazzleUI_EfficiencyButton:SetText("P")
        end
   elseif (MazzleUI_Settings.Performance_Enabled["combat"] and MazzleUI_Status.inCombat) then
        if (MazzleUI_Status.currentEfficiencyMode == "combat" and (not forceReInit)) then return; else
            MazzleUI_Status.currentEfficiencyMode = "combat"
            MazzleUI_EfficiencyButton:SetText("C")
        end
   else
        if (MazzleUI_Status.currentEfficiencyMode == "solo" and (not forceReInit)) then return; else
            MazzleUI_Status.currentEfficiencyMode = "solo"
            MazzleUI_EfficiencyButton:SetText("")
        end
    end
    local currentSettings = MazzleUI_Status.currentEfficiencySettings
    for _,performanceOption in MazzleUI_PerformanceItems do
        if (MazzleUI_Settings[performanceOption][MazzleUI_Status.currentEfficiencyMode] ~= MazzleUI_Status.currentEfficiencySettings[performanceOption]) then
            MazzleUI_Status.currentEfficiencySettings[performanceOption] = MazzleUI_Settings[performanceOption][MazzleUI_Status.currentEfficiencyMode]
            MazzleUI:InstantiateEfficiencyItem(performanceOption, MazzleUI_Status.currentEfficiencySettings[performanceOption])
        end
    end
end

function MazzleUI:InstantiateEfficiencyItem(performanceItem, isOn)
    --ace:print("Instantiating performance setting: ", performanceItem, " ", isOn)
    if (performanceItem == "Performance_Gfx") then
        if (gfxToggle) then
            if (isOn) then
                gfxToggle.Obj:LoadHi()
            else
                gfxToggle.Obj:LoadLo()
            end
        end
    elseif (performanceItem == "Performance_Models") then
        if (isOn) then
    	    Mazz3D:StartRandomAnims()
    	    Mazz3D:RegisterAnimEvents()
    	    Mazz3D:RegisterAdjustEvents()
        else
            Mazz3D:StopRandomAnims()
    	    Mazz3D:UnregisterAnimEvents()
    	    Mazz3D:UnregisterAdjustEvents()
        end
    elseif (performanceItem == "Performance_Recap") then
        if (Recap_SetState) then
            if (isOn) then
                Recap_SetState("Idle")
                MazzleUI_RecapButton_Icon:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUI_RecapOn")
            else
        	    Recap_SetState("Stopped")
                MazzleUI_RecapButton_Icon:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUI_RecapOff")
            end
        end
    elseif (performanceItem == "Performance_NamePlates") then
        local nameSettings
        if (isOn) then nameSettings = MazzleUI_Settings.Performance_Names.High; else nameSettings = MazzleUI_Settings.Performance_Names.Low; end;
        SetCVar("UnitNameOwn",MazzleUI:Return1or0(nameSettings.Own))
        SetCVar("UnitNamePlayer",MazzleUI:Return1or0(nameSettings.Name))
        SetCVar("UnitNamePlayerGuild",MazzleUI:Return1or0(nameSettings.Guild))
        SetCVar("UnitNamePlayerPVPTitle",MazzleUI:Return1or0(nameSettings.Title))
        SetCVar("UnitNameNPC",MazzleUI:Return1or0(nameSettings.NPCName))
        if (nameSettings.NPCNamePlate) then  ShowNameplates(); NAMEPLATES_ON = 1; else HideNameplates(); NAMEPLATES_ON = nil; end;
        if (nameSettings.NamePlate) then ShowFriendNameplates(); FRIENDNAMEPLATES_ON = 1; else HideFriendNameplates(); FRIENDNAMEPLATES_ON = nil; end;
    elseif (performanceItem == "Performance_CECB") then
        if (CEnemyCastBar_Options) then
            if (isOn) then
                CEnemyCastBar_Options("enable")
            else
                CEnemyCastBar_Options("disable")
            end
        end
    elseif (performanceItem == "Performance_FastCast") then
        if (IsAddOnLoaded("FastCast")) then
            if (isOn) then
                if ( not MazzleUI:FastCastIsOn()) then MazzleUI:ToggleFastCast(); end;
            else
                if (MazzleUI:FastCastIsOn()) then MazzleUI:ToggleFastCast(); end;
            end
        end
    elseif (performanceItem == "Performance_BigWigs") then
        if (BigWigs) then
            if (isOn) then
                BigWigs:ToggleActive(true)
            else
                BigWigs:ToggleActive(false)
            end
        end
    elseif (performanceItem == "Performance_SCT") then
        if (SCT) then
            if (isOn) then
                SCT:ToggleActive(true)
            else
                SCT:ToggleActive(false)
            end
        end
    elseif (performanceItem == "Performance_SCTD") then
        if (SCTD) then
            if (isOn) then
                SCTD:OnEnable()
            else
                SCTD:OnDisable()
            end
        end
    elseif (performanceItem == "Performance_SCTC") then
        if (sctc_Enable) then
            if (isOn) then
                sctc_Enable()
            else
                sctc_Disable()
            end
        end
    elseif (performanceItem == "Performance_SpellAlert") then
        if (WitchHunt) then
            if (isOn) then
                WitchHunt:ToggleActive(true)
            else
                WitchHunt:ToggleActive(false)
            end
        end
    elseif (performanceItem == "Performance_Buttons") then
        if (DAB_Settings) then
            if (isOn) then
                MazzleUI:ShowDAB()
            else
                MazzleUI:HideDAB()
            end
        end
    elseif (performanceItem == "Performance_Discord") then
        if (isOn) then
            MazzleUI:ChangeDiscordUpdateRate(MazzleUI_Settings.DiscordUpdate)
        else
            MazzleUI:ChangeDiscordUpdateRate(MazzleUI_Settings.Performance_DiscordUpdate)
        end
    end
end

function MazzleUI:ChangeDiscordUpdateRate(newSpeed)

    --ace:print("MazzleUI is setting all discord add-ons' update rate to "..newSpeed)
    if (DAB_Settings and DAB_INDEX and DAB_Settings[DAB_INDEX]) then
        DAB_Settings[DAB_INDEX].UpdateSpeed = newSpeed;
        DAB_UPDATE_SPEED = 1 / DAB_Settings[DAB_INDEX].UpdateSpeed;
    end

    if (DART_Settings and DART_INDEX and DART_Settings[DART_INDEX]) then
        DART_Settings[DART_INDEX].updatespeed= newSpeed
        DART_UPDATE_SPEED = 1 / DART_Settings[DART_INDEX].updatespeed
    end
    
    if (DUF_Settings and DUF_INDEX and DUF_Settings[DUF_INDEX]) then
        DUF_Settings[DUF_INDEX].updatespeedbase = newSpeed
    	DUF_Settings[DUF_INDEX].updatespeed = 1 / DUF_Settings[DUF_INDEX].updatespeedbase;
    end

end

function MazzleUI:ChangeSpecialTalentsOnShow()
    SpecialTalentFrame:SetScript("OnShow", function()
                                        		SpecialTalentFrame:SetScale(1.5);
                                        		SpecialTalentFrame_OnShow();
                                        		SpecialTalentFrame:ClearAllPoints();
                                        		SpecialTalentFrame:SetPoint("TOP", UIParent, "TOP", 0, -50);
                                        		end)
end

