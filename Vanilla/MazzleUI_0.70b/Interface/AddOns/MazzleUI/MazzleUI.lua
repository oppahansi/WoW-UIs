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

BINDING_HEADER_MAZZLEUI = "Mazzlefizz's MazzleUI";
BINDING_NAME_MAZZLEUICONTEXT = "Toggle Context Menu Buttons";
BINDING_NAME_MAZZLEUIDEBUG = "Toggle Camera Debug Messages";
BINDING_NAME_MAZZLEUINEXTVIEW = "Next Party/Raid View";
BINDING_NAME_MAZZLEUIVIEW1 = "View 1 - Raid Frames on Bottom";
BINDING_NAME_MAZZLEUIVIEW2 = "View 2 - Raid Frames on Top";
BINDING_NAME_MAZZLEUIVIEW3 = "View 3 - No Raid Frames";
BINDING_NAME_MAZZLEUIMT1 = "MT 1 - MT Windows on Side";
BINDING_NAME_MAZZLEUIMT2 = "MT 2 - MT Windows on Top";
BINDING_NAME_MAZZLEUIMT3 = "MT 3 - MT Windows on Top Wide";
BINDING_NAME_MAZZLEUIPARTYSHOW = "Party 1 - Show Party ";
BINDING_NAME_MAZZLEUIPARTYHIDE = "Party 2 - Hide Party";
BINDING_NAME_MAZZLEUITTELL = "Whisper Current Target";

Mazzifier_Version = 0.6
MazzleUI_HUD_InCombat = nil
MazzleUI_HUD_Initialized = nil
MazzleUI_DART_Constants = {  ["Health"] = 6,
                    ["Background"] = 7,
                    ["Mana"] = 8,
                    ["T_Health"] = 9,
                    ["T_Background"] = 10,
                    ["T_Mana"] = 11,}

MazzleUI_PerformanceItems = {
    "Performance_Gfx",
    "Performance_Models",
    "Performance_NamePlates",
    "Performance_Recap",
    "Performance_CECB",
    "Performance_BigWigs",
    "Performance_Compass",
    "Performance_FastCast",
    "Performance_SCT",
    "Performance_SCTD",
    "Performance_SCTC",
    "Performance_SpellAlert",
    "Performance_Discord",
    "Performance_Buttons",}

MazzleUI_Events = {
    AutoRes =  {      setting = "MazzleUI_Settings.AutoRes", 
                        events = {"RESURRECT_REQUEST",}, 
                        handler = "Handle_AutoRes",
                        },
    AutoSummon = {    setting = "MazzleUI_Settings.AutoSummon",  
                        events = {"CONFIRM_SUMMON",}, 
                        handler = "Handle_AutoSummon",
                        },
    PVPMode = {       setting = "MazzleUI_Settings.Performance_Enabled.pvp",  
                        events = {"UNIT_FACTION",}, 
                        handler = "Handle_PVPMode",
                        },
    AutoDismount = {  setting = "MazzleUI_Settings.AutoDismount",  
                        events = {"TAXIMAP_OPENED",}, 
                        handler = "Handle_AutoDismount",
                        },
}

MazzleUI = AceAddon:new({
	name 			= "MazzleUI",
	version			= "0.40",
	description 	= "mmm...MazzleUI",
	author			= "Mazzlefizz of Argent Dawn",
	email			= "mazzlefizz@gmail.com",
	releaseDate		= "???",
	aceCompatible	= "103",
	category		= "interface",
})
MazzleUI:RegisterForLoad()

function MazzleUI:Initialize()
    self.GetOpt = function(var) return self.db:get(self.profilePath,var) end
    self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val) end
    
    MazzleUI:Handle_PlayerLogin()
	MazzleUI_MouseClick:SetModelScale(0.5);
	MazzleUI_MouseClick:SetPosition(0, 0, 0.076875);
	MazzleUI_MouseClick:SetRotation(0.055);

end

function MazzleUI:Enable()
    SlashCmdList["MAZZIFIER"] = function(msg)
        MAZZIFIER_Command(msg);
    end
    SLASH_MAZZIFIER1 = "/mazzify";

    MazzleUI:InitSettings()
    MazzleUI_DebugLog = {}
    MazzleUI_LastRaidView = MazzleUI_Settings.RaidLayout40
    
    -- Initialize efficiency modes
    MazzleUI_Status = {}
    MazzleUI_Status.inRaid40 = false
    MazzleUI_Status.inRaid20 = false
    MazzleUI_Status.inParty = false
    MazzleUI_Status.solo = false
    MazzleUI_Status.isManual = false
    MazzleUI_Status.inPvP = UnitIsPVP("player")
    MazzleUI_Status.currentEfficiencyMode = "solo"
    MazzleUI_Status.currentEfficiencySettings = {}
    
    MazzleUI_Status.PlayerIsInCombat = false
    MazzleUI_Status.PlayerIsRegenOn = false
            
    for _,performanceItem in MazzleUI_PerformanceItems do
        MazzleUI_Status.currentEfficiencySettings[performanceItem] = true;
    end

    if (Mazzifier_Progress == 2) then
        if (not MazzleUI_LastAspect) then
            MazzleUI_LastAspect = MazzleUI:GetAspect()
        end

    	--self:RegisterEvent("UPDATE_PENDING_MAIL", "Handle_MailEvent");
        self:RegisterEvent("PARTY_MEMBERS_CHANGED", "Handle_GroupChanges");
        self:RegisterEvent("RAID_ROSTER_UPDATE", "Handle_GroupChanges");
        
        for _,eventItem in MazzleUI_Events do
            if (MazzleUI_GetValue(eventItem.setting)) then
                for _,theEvent in eventItem.events do
                    MazzleUI:RegisterEventForSetting(theEvent, true, eventItem.handler)
                end
            end
        end
        
        Mazz3D:Init()    
        Timex:AddSchedule("MazzleUI_AddonInitTimer", 5, nil, nil, MazzleUI.Addon_Initialize)
    
        MazzleUI:InitHUD()
        MazzleUI:InitButtons()
        MazzleUI:InitBags()
        if (MazzleUI_Settings.HideContext) then
            Timex:AddSchedule("MazzleUI_ContextInitTimer", 5, nil, nil, MazzleUI.HideContextMenu)
        end
        
        -- Switch to chat frame 1 workaround
        FCF_SelectDockFrame(ChatFrame1)
        for i=1,7 do 
            getglobal("ChatFrame"..i):SetFading(nil)
            getglobal("ChatFrame"..i.."BottomButton"):Show()
        end
        -- Disable one-time add-ons that may have been enabled in MazzleOptions
        if (WarmupOutputFrame) then WarmupOutputFrame:Show() end
        DisableAddOn("!!Warmup")
        DisableAddOn("SimpleActionSets")
    
    end 
end

function MazzleUI:HideContextMenu()
    if (DAB_ActionBar_10 and DAB_ActionBar_10:IsVisible()) then
        DAB_ActionBar_10:Hide()
    end
end

function MAZZIFIER_Command(msg)
    if IsAddOnLoaded("Mazzifier") then
        if (Mazzifier_Frame:IsVisible()) then
            Mazzifier_Frame:Hide()
        else
            Mazzifier_Frame:Show();
        end
    else
        LoadAddOn("Mazzifier")
        Mazzifier_Frame:Show();
    end
end

function MazzleUI:UpdateEventForSetting(eventType)
    if (MazzleUI_Events[eventType]) then
        local eventItem = MazzleUI_Events[eventType]
        for _,theEvent in eventItem.events do
            MazzleUI:RegisterEventForSetting(theEvent, MazzleUI_GetValue(eventItem.setting), eventItem.handler)
        end
    else
        ace:print("MAZZLEUI ERROR: Attempting to update event type for ", eventType, " which doesn't exist.")
    end
end

function MazzleUI:RegisterEventForSetting(theEvent, theValue, theHandler)
    --ace:print("MazzleUI_RegisterEventForSetting called with ", theEvent, " ", theValue, " ", theHandler)
    if (theValue) then
        self:RegisterEvent(theEvent, theHandler)
    else
        self:UnregisterEvent(theEvent)
    end
end

function MazzleUI:RegisterHUDEvents()
    self:RegisterEvent("PLAYER_ENTER_COMBAT", "Handle_CombatStatus");
    self:RegisterEvent("PLAYER_LEAVE_COMBAT", "Handle_CombatStatus");
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "Handle_CombatStatus");
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "Handle_CombatStatus");
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "Handle_TargetChange");
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "Handle_Zoning");
    self:RegisterEvent("UNIT_HEALTH", "Handle_HealthChange") 
    self:RegisterEvent("UNIT_MANA", "Handle_JuiceChange") 
    self:RegisterEvent("UNIT_RAGE", "Handle_JuiceChange")
    self:RegisterEvent("UNIT_ENERGY", "Handle_JuiceChange") 
    self:RegisterEvent("UNIT_FOCUS", "Handle_JuiceChange") 
    
end

function MazzleUI:UnRegisterHUDEvents()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD");
    self:UnregisterEvent("PLAYER_ENTER_COMBAT");
    self:UnregisterEvent("PLAYER_LEAVE_COMBAT");
    self:UnregisterEvent("PLAYER_REGEN_DISABLED");
    self:UnregisterEvent("PLAYER_REGEN_ENABLED");
    self:UnregisterEvent("PLAYER_TARGET_CHANGED");
    self:UnregisterEvent("UNIT_HEALTH");
    self:UnregisterEvent("UNIT_MANA");
    self:UnregisterEvent("UNIT_RAGE");
    self:UnregisterEvent("UNIT_ENERGY");
    self:UnregisterEvent("UNIT_FOCUS")
end


function MazzleUI:Handle_HealthChange()
    if (arg1 == "player") then
        MazzleUI:HUD_PlayerHealthEvent()
    elseif (arg1 == "target") then
        MazzleUI:HUD_TargetHealthEvent()
    end
end

function MazzleUI:Handle_GroupChanges()
    local numRaid = GetNumRaidMembers();
    if ((numRaid > 0) and (not MazzleUI_Status.inRaid40) and (not MazzleUI_Status.inRaid20)) then
        MazzleUI_LastRaidView = MazzleUI_Settings.RaidLayout40
    end
    if (numRaid > 20) then
	    if (not MazzleUI_Status.inRaid40) then
	        MazzleUI:InRaid40Mode();
	    end
    elseif (numRaid > 0) then
	    if (not MazzleUI_Status.inRaid20) then
	        MazzleUI:InRaid20Mode();
	    end
	else
        local numParty = GetNumPartyMembers();
    	if (numParty > 0) then
    		if (not MazzleUI_Status.inParty) then
	            MazzleUI:InPartyMode();
	        end
        else
    	    if (not MazzleUI_Status.solo) then
	    	    MazzleUI:InSoloMode();
		    end
		end
    end
end

function MazzleUI:InRaid40Mode()
    MazzleUI_Status.inRaid40 = true
    MazzleUI_Status.inRaid = true
    MazzleUI_Status.inRaid20 = false
    MazzleUI_Status.inParty = false
    MazzleUI_Status.solo = false
    MazzleUI_Status.currentGroupType = "raid"
    MazzleUI:InstantiateEfficiencyMode()
    
    if (MazzleUI_Settings.manageRaidFrames) then
        MazzleUI:RaidViewSet()
    end
end

function MazzleUI:InRaid20Mode()
    MazzleUI_Status.inRaid20 = true
    MazzleUI_Status.inRaid40 = false
    MazzleUI_Status.inRaid = true
    MazzleUI_Status.inParty = false
    MazzleUI_Status.solo = false
    MazzleUI_Status.currentGroupType = "raid"
    MazzleUI:InstantiateEfficiencyMode()

    if (MazzleUI_Settings.manageRaidFrames) then
        MazzleUI:RaidViewSet()
    end
end

function MazzleUI:InPartyMode()
    MazzleUI_Status.inParty = true
    MazzleUI_Status.inRaid40 = false
    MazzleUI_Status.inRaid20 = false
    MazzleUI_Status.inRaid = false
    MazzleUI_Status.solo = false
    MazzleUI_Status.currentGroupType = "party"
    MazzleUI:InstantiateEfficiencyMode()
end

function MazzleUI:InSoloMode()
    MazzleUI_Status.solo = true
    MazzleUI_Status.inRaid40 = false
    MazzleUI_Status.inRaid20 = false
    MazzleUI_Status.inRaid = false
    MazzleUI_Status.inParty = false
    MazzleUI_Status.currentGroupType = "solo"
    MazzleUI:InstantiateEfficiencyMode()
end

function MazzleUI:Handle_JuiceChange()
    if (arg1 == "player") then
        MazzleUI:HUD_PlayerManaEvent()
    elseif (arg1 == "target") then
        MazzleUI:HUD_TargetManaEvent()
    end
end

function MazzleUI:Handle_TargetChange()
    MazzleUI:HUD_TargetHealthEvent()
    MazzleUI:HUD_TargetManaEvent()
    MazzleUI:CheckCombatStatusManual()
end

function MazzleUI:CheckCombatStatusManual()
    if (UnitAffectingCombat("player")) then
        if (not MazzleUI_Status.PlayerIsInCombat) then MazzleUI:Handle_PlayerEnterCombat() end
    else
        if (MazzleUI_Status.PlayerIsInCombat) then MazzleUI:Handle_PlayerLeaveCombat() end
    end
end

function MazzleUI:Handle_Zoning()
    MazzleUI:CheckCombatStatusManual()
end

function MazzleUI:Handle_MailEvent()
    if ( HasNewMail() ) then
    	PlaySoundFile("MailSound.wav");
    end
end

function MazzleUI:Handle_PlayerLogin()
    if (Mazzifier_Progress and (Mazzifier_Progress == 1)) then
        LoadAddOn("Mazzifier")
        Mazzify_SchedulePhase2()
    elseif ((not Mazzifier_Progress) or (Mazzifier_Progress == 0) or (Mazzifier_Progress == 0.5) or 
        (Mazzifier_LastInstalledVersion and (Mazzifier_LastInstalledVersion < Mazzifier_Version))) then
        Mazzifier_Progress = 0
        LoadAddOn("Mazzifier")
        Mazzifier_Frame:Show();
    end
end

function MazzleUI:ShowHUDNumbers()
    DUF_Settings[DUF_INDEX].player.TextBox[10].hide = nil
    DUF_Settings[DUF_INDEX].player.TextBox[6].hide = nil
    DUF_Settings[DUF_INDEX].target.TextBox[7].hide = nil
    DUF_Settings[DUF_INDEX].target.TextBox[10].hide = nil
    DUF_PlayerFrame_TextBox_6:Show()
    DUF_PlayerFrame_TextBox_10:Show()
    DUF_TargetFrame_TextBox_7:Show()
    DUF_TargetFrame_TextBox_10:Show()
end

function MazzleUI:HideHUDNumbers()
    DUF_Settings[DUF_INDEX].player.TextBox[10].hide = 1
    DUF_Settings[DUF_INDEX].player.TextBox[6].hide = 1
    DUF_Settings[DUF_INDEX].target.TextBox[7].hide = 1
    DUF_Settings[DUF_INDEX].target.TextBox[10].hide = 1
    DUF_PlayerFrame_TextBox_6:Hide()
    DUF_PlayerFrame_TextBox_10:Hide()
    DUF_TargetFrame_TextBox_7:Hide()
    DUF_TargetFrame_TextBox_10:Hide()
end

function MazzleUI:InstantiateHUDSettings()
    --ace:print("Instantiating HUD Settings")
    DUF_Settings[DUF_INDEX].target.TextBox[10].alpha = MazzleUI_Settings.HUD.Transparency_ToT
    DUF_Settings[DUF_INDEX].target.ComboPoints.alpha = MazzleUI_Settings.HUD.Transparency_ComboPoints
    if (MazzleUI_Settings.HUD.UseHUD) then
        if (MazzleUI_Settings.HUD.Transparency_OOC > 0) then
            MazzleUI:ShowHUDNumbers()
        else
            MazzleUI:HideHUDNumbers()
        end
        DART_Show(MazzleUI_DART_Constants.Health);
        DART_Show(MazzleUI_DART_Constants.Mana);
        DART_Show(MazzleUI_DART_Constants.T_Health);
        DART_Show(MazzleUI_DART_Constants.T_Mana);
        DART_Show(MazzleUI_DART_Constants.T_Background);
        DART_Show(MazzleUI_DART_Constants.Background);
        if (UnitAffectingCombat("player")) then
            MazzleUI:Handle_PlayerEnterCombat()
        else
            MazzleUI:Handle_PlayerLeaveCombat()
        end
        MazzleUI:RegisterHUDEvents()
    else
        MazzleUI:UnRegisterHUDEvents()
        MazzleUI:HideHUDNumbers()
        DART_Hide(MazzleUI_DART_Constants.Health);
        DART_Hide(MazzleUI_DART_Constants.Mana);
        DART_Hide(MazzleUI_DART_Constants.T_Health);
        DART_Hide(MazzleUI_DART_Constants.T_Mana);
        DART_Hide(MazzleUI_DART_Constants.Background);
        DART_Hide(MazzleUI_DART_Constants.T_Background);
    end
    DUF_Initialize_AllFrames();    
    DUF_Main_UpdatePartyMembers()
end

function MazzleUI:InitHUD()

    if ((Mazzifier_Progress == 2) and DART_INITIALIZED and DART_Settings and DART_INDEX) then
        DART_Color(MazzleUI_DART_Constants.Health, 1, 0, 0); 
        DART_Color(MazzleUI_DART_Constants.T_Health, 1, 0, 1); 
        DART_Color(MazzleUI_DART_Constants.Background, 1, 1, 1); 
        DART_Color(MazzleUI_DART_Constants.T_Background, 1, 1, 1); 
        DART_Color(MazzleUI_DART_Constants.Mana, 1, 1, 1); 
        DART_Color(MazzleUI_DART_Constants.T_Mana, 1, 1, 1); 
        MazzleUI_HUD_Initialized = true
        MazzleUI:InstantiateHUDSettings()
        
    else
    	Timex:AddSchedule("MazzleUI_InitTimer", 1, nil, nil, MazzleUI.InitHUD)
    end
end

function MazzleUI:InitButtons()
    if (Mazzifier_Progress == 2) then
        MazzleUI_RecapButton_Icon:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUI_RecapOn")
        MazzleUI_EfficiencyButton_Icon:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUI_EfficiencyOff")
        MazzleUI_FastCastButton_Icon:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUI_FastCastOff")
        MazzleUI_OptionsButton_Icon:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUI_Options")
        MazzleUI:HilightButton("RecapButton", false)
        MazzleUI:HilightButton("EfficiencyButton", false)
        MazzleUI:HilightButton("FastCastButton", false)
        MazzleUI:HilightButton("OptionsButton", false)
        
        if (MazzleUI_Status.isManual) then
            MazzleUI:HilightButton("EfficiencyButton", true)
        end
        
        if ((not IsAddOnLoaded("Recap")) or 
            (IsAddOnLoaded("Recap") and 
            ((recap.Opt.State.value ~= "Idle") and (recap.Opt.State.value ~= "Active")))) then
            MazzleUI:HilightButton("RecapButton", true)
        end
        
        if (IsAddOnLoaded("FastCast") and MazzleUI:FastCastIsOn()) then
            MazzleUI:HilightButton("FastCastButton", true)
        end
    end
end
function MazzleUI:HilightButton(theButton, shouldHilight)
    local theButton = getglobal("MazzleUI_"..theButton.."_IconSelect")
    if (shouldHilight) then
        theButton:SetTexture("Interface\\AddOns\\MazzleUI\\Art\\MazzleUISelectedBorderButton")
    else
        theButton:SetTexture("")
    end
end

function MazzleUI:InitBags()
	local STBAlpha = 0.5
	
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local bt = getglobal("ContainerFrame"..i.."BackgroundTop");
			 if bt then bt:SetAlpha(STBAlpha) end
    local bm = getglobal("ContainerFrame"..i.."BackgroundMiddle1");
   		if bm then bm:SetAlpha(STBAlpha) end
		local bb = getglobal("ContainerFrame"..i.."BackgroundBottom");
			if bb then bb:SetAlpha(STBAlpha) end
	end
	
end

function MazzleUI:GetAspect()
    local screenX, screenY = CT_Viewport_GetCurrentResolution(GetScreenResolutions())
    local screenRatio = math.floor((screenX/screenY)*10)
    if (screenRatio == 16) then
    	return 3
    elseif (screenRatio == 12) then
    	return 1
    else
    	return 2
    end 
end

function MazzleUI:Handle_PlayerEnterCombat()
    if (MazzleUI_Settings.HUD.UseHUD) then
        DART_Show(MazzleUI_DART_Constants.Health);
        DART_Show(MazzleUI_DART_Constants.Mana);
        DART_Show(MazzleUI_DART_Constants.T_Health);
        DART_Show(MazzleUI_DART_Constants.T_Mana);
        DART_Show(MazzleUI_DART_Constants.T_Background);
        DART_Show(MazzleUI_DART_Constants.Background);
        DART_Alpha(MazzleUI_DART_Constants.Health, MazzleUI_Settings.HUD.Transparency_FG_IC);
        DART_Alpha(MazzleUI_DART_Constants.Mana, MazzleUI_Settings.HUD.Transparency_FG_IC);
        DART_Alpha(MazzleUI_DART_Constants.Background, MazzleUI_Settings.HUD.Transparency_IC);
        DART_Alpha(MazzleUI_DART_Constants.T_Health, MazzleUI_Settings.HUD.Transparency_FG_IC);
        DART_Alpha(MazzleUI_DART_Constants.T_Mana, MazzleUI_Settings.HUD.Transparency_FG_IC);
        DART_Alpha(MazzleUI_DART_Constants.T_Background, MazzleUI_Settings.HUD.Transparency_IC);

        MazzleUI:ShowHUDNumbers()
        
        MazzleUI:HUD_PlayerHealthEvent()
        MazzleUI:HUD_TargetHealthEvent()
        MazzleUI:HUD_PlayerManaEvent()
        MazzleUI:HUD_TargetManaEvent()
    end
    if (MazzleUI_Settings.Performance_Enabled.combat) then
        MazzleUI:InstantiateEfficiencyMode()
    end
end

function MazzleUI:Handle_PlayerLeaveCombat()
    if (MazzleUI_Settings.HUD.UseHUD) then
        DART_Hide(MazzleUI_DART_Constants.T_Health);
        DART_Hide(MazzleUI_DART_Constants.T_Mana);
        DART_Alpha(MazzleUI_DART_Constants.Health, MazzleUI_Settings.HUD.Transparency_FG_OOC);
        DART_Alpha(MazzleUI_DART_Constants.Mana, MazzleUI_Settings.HUD.Transparency_FG_OOC);
        DART_Alpha(MazzleUI_DART_Constants.Background, MazzleUI_Settings.HUD.Transparency_OOC);
        DART_Alpha(MazzleUI_DART_Constants.T_Health, MazzleUI_Settings.HUD.Transparency_FG_OOC);
        DART_Alpha(MazzleUI_DART_Constants.T_Mana, MazzleUI_Settings.HUD.Transparency_FG_OOC);
        DART_Alpha(MazzleUI_DART_Constants.T_Background, MazzleUI_Settings.HUD.Transparency_OOC);
        DART_Height(MazzleUI_DART_Constants.Health, 256);
        DART_Texture(MazzleUI_DART_Constants.Health, "Interface\\AddOns\\DiscordArt\\CustomTextures\\HL", {0,1,0,1});
        DART_Height(MazzleUI_DART_Constants.T_Health, 256);
        DART_Texture(MazzleUI_DART_Constants.T_Health, "Interface\\AddOns\\DiscordArt\\CustomTextures\\HL", {1,0,0,1});
        DART_Height(MazzleUI_DART_Constants.Mana, 256);
        DART_Texture(MazzleUI_DART_Constants.Mana, "Interface\\AddOns\\DiscordArt\\CustomTextures\\ML", {0,1,0,1});
        DART_Height(MazzleUI_DART_Constants.T_Mana, 256);
        DART_Texture(MazzleUI_DART_Constants.T_Mana, "Interface\\AddOns\\DiscordArt\\CustomTextures\\ML", {1,0,0,1});

        if (MazzleUI_Settings.HUD.Transparency_OOC == 0) then
            MazzleUI:HideHUDNumbers()
        end
    end
    if (MazzleUI_Settings.Performance_Enabled.combat) then
        MazzleUI:InstantiateEfficiencyMode()
    end
end

function MazzleUI:Handle_CombatStatus()
	if(event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED") then
		MazzleUI_Status.PlayerIsInCombat = true
		MazzleUI:Handle_PlayerEnterCombat()
		if(event == "PLAYER_REGEN_DISABLED") then
			MazzleUI_Status.PlayerIsRegenOn = false
		end
	elseif(event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_REGEN_ENABLED") then
		if(event == "PLAYER_LEAVE_COMBAT" and MazzleUI_Status.PlayerIsRegenOn) then
			MazzleUI_Status.PlayerIsInCombat = false
			MazzleUI:Handle_PlayerLeaveCombat()
		elseif(event == "PLAYER_REGEN_ENABLED") then
			MazzleUI_Status.PlayerIsInCombat = false
			MazzleUI_Status.PlayerIsRegenOn = true
			MazzleUI:Handle_PlayerLeaveCombat()
		end
	end
end

function MazzleUI:HUD_PlayerHealthEvent()
    local health = UnitHealth("player"); 
    local maxhealth = UnitHealthMax("player")
    if (maxhealth == 0) then 
        return;
    end
    
    local p = (health/maxhealth)
    if p == 0 then p = 0.001; end;
    local h = 256 * p;
    DART_Height(MazzleUI_DART_Constants.Health, h);
    DART_Texture(MazzleUI_DART_Constants.Health, "Interface\\AddOns\\DiscordArt\\CustomTextures\\HL", {0,1,1-p,1});

end

function MazzleUI:HUD_TargetHealthEvent()
    local health = UnitHealth("target"); 
    local maxhealth = UnitHealthMax("target")
    if (maxhealth == 0) then 
        return;
    end
    
    local p = (health/maxhealth)
    if p == 0 then p = 0.001; end;
    local h = 256 * p;
    DART_Height(MazzleUI_DART_Constants.T_Health, h);
    DART_Texture(MazzleUI_DART_Constants.T_Health, "Interface\\AddOns\\DiscordArt\\CustomTextures\\HL", {1,0,1-p,1});

end

function MazzleUI:HUD_PlayerManaEvent()
    local p = (UnitMana("player")/UnitManaMax("player"))
    p = .453125 + (.546875 * p)
    local h = 256 * p;
    DART_Height(MazzleUI_DART_Constants.Mana, h);
    DART_Texture(MazzleUI_DART_Constants.Mana, "Interface\\AddOns\\DiscordArt\\CustomTextures\\ML", {0,1,1-p,1});

end

function MazzleUI:HUD_TargetManaEvent()
    local p = (UnitMana("target")/UnitManaMax("target"))
    p = .453125 + (.546875 * p)
    local h = 256 * p;
    DART_Height(MazzleUI_DART_Constants.T_Mana, h);
    DART_Texture(MazzleUI_DART_Constants.T_Mana, "Interface\\AddOns\\DiscordArt\\CustomTextures\\ML", {1,0,1-p,1});

end

function MazzleUI:NextView()

    if (MazzleUI_Settings.FaveMTPosition < 3) then
        MazzleUI_Settings.FaveMTPosition = MazzleUI_Settings.FaveMTPosition + 1
    elseif (MazzleUI_Settings.ShowRaidParty and (MazzleUI_Settings.FaveRaidPosition ~= 1)) then
        MazzleUI_Settings.FaveMTPosition = 1
        MazzleUI_Settings.ShowRaidParty = false
    else
        MazzleUI_Settings.ShowRaidParty = true
        MazzleUI_Settings.FaveMTPosition = 1
        if (MazzleUI_Settings.FaveRaidPosition == 3) then
            MazzleUI_Settings.FaveRaidPosition = 1
        else
            MazzleUI_Settings.FaveRaidPosition = MazzleUI_Settings.FaveRaidPosition + 1
        end
    end

    MazzleUI:RaidViewSet()

end

function MazzleUI:RaidViewSet()

    local feedbackMsg = "MazzleUI hot-swapping raid layout: "
    --if (sRaidFrames.master and sRaidFrames.master:IsVisible() and DUF_Settings and DUF_INDEX) then
    if (sRaidFrames and sRaidFrames.master and DUF_Settings and DUF_INDEX) then
        --ace:print("Setting sRaidFrames layout.")
        if (MazzleUI_LastAspect) then

            -- Set up raid frame positions
            if (MazzleUI_Settings.FaveRaidPosition == 1) then
                sRaidFrames.master:Show()
                MazzleUI:LayoutRaid(1)
                feedbackMsg = feedbackMsg.."raid frames on bottom, " 
            elseif (MazzleUI_Settings.FaveRaidPosition == 2) then
                sRaidFrames.master:Show()
                if (MazzleUI_Settings.FaveMTPosition == 1) then
                    MazzleUI:LayoutRaid(2)
                elseif (MazzleUI_Settings.FaveMTPosition == 2) then
                    MazzleUI:LayoutRaid(3)
                elseif (MazzleUI_Settings.FaveMTPosition == 3) then
                    MazzleUI:LayoutRaid(4)
                end
                feedbackMsg = feedbackMsg.."raid frames on top, " 
            elseif (MazzleUI_Settings.FaveRaidPosition == 3) then
                sRaidFrames.master:Hide()
                feedbackMsg = feedbackMsg.."no raid frames, " 
            end

            -- Show party frames if room and user wants
            if (MazzleUI_Settings.ShowRaidParty and (MazzleUI_Settings.FaveRaidPosition ~= 1)) then
                DUF_Settings[DUF_INDEX].hidepartyinraid = nil
                feedbackMsg = feedbackMsg.."show party, " 
            else
                DUF_Settings[DUF_INDEX].hidepartyinraid = 1
                feedbackMsg = feedbackMsg.."no party, " 
            end
            DUF_Main_UpdatePartyMembers()

            -- Position MT windows
            if (MazzleUI_Settings.FaveMTPosition == 1) then
                if ((not DUF_Settings[DUF_INDEX].hidepartyinraid) and (not DUF_Settings[DUF_INDEX].partypet.hide) and (MazzleUI_LastAspect ~= 3)) then
                    MazzleUI:oRA_MTPosition("petAdjust")
                else
                    if (MazzleUI_LastAspect == 1) then
                        MazzleUI:oRA_MTPosition("standard-125")
                    else
                        MazzleUI:oRA_MTPosition("standard")
                    end
                end
                feedbackMsg = feedbackMsg.."MT windows on side." 
            elseif (MazzleUI_Settings.FaveMTPosition == 2) then
                MazzleUI:oRA_MTPosition("top")
                feedbackMsg = feedbackMsg.."MT windows on top." 
            elseif (MazzleUI_Settings.FaveMTPosition == 3) then
                MazzleUI:oRA_MTPosition("top-3")
                feedbackMsg = feedbackMsg.."MT windows on top with wider ToToT display." 
            end
        	UIErrorsFrame:AddMessage(feedbackMsg, 0.0, 0.0, 1.0, 1.0, 0.05);
        end
    end
end
        
function MazzleUI:LayoutRaid(theLayout)

    if (theLayout == 1) then 
        if (MazzleUI_LastAspect == 3) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.6 40 bottom
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 282, groupSpacing = 25, xAnchor = 432, yAnchor = -1120, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("up")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.6 20 on bottom
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 745, groupSpacing = 37, xAnchor = 433, yAnchor = -1065, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 2) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.33 40 bottom
                MazzleUI_Settings.sRaidFrames = { scale = 0.815, targetAdjust = 295, groupSpacing = 0, xAnchor = 474, yAnchor = -1291, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("up")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.33 20 bottom
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 296, groupSpacing = 45, xAnchor = 456, yAnchor = -1119, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("up")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20125")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 1) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.25 40 bottom
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 268, groupSpacing = 0, xAnchor = 430, yAnchor = -1169, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle125")
                MazzleUI:sRaidGrow("up")
                MazzleUI:sRaidShowGroups(true)
            else
                --1.25 20 on bottom
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 297, groupSpacing = 30, xAnchor = 460, yAnchor = -1169, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("up")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20125")
                MazzleUI:sRaidShowGroups(false)
            end
        end
    elseif (theLayout == 2) then 
        if (MazzleUI_LastAspect == 3) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.6 40 on top mt side
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 282, groupSpacing = 25, xAnchor = 664, yAnchor = -10, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:PositionLayout("horizontal")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.6 20 top mt side
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 440, groupSpacing = -67, xAnchor = 586, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 2) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.33 40 on top mt side
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 282, groupSpacing = 25, xAnchor = 490, yAnchor = -10, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:PositionLayout("horizontal")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.33 20 top mt side
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 440, groupSpacing = -67, xAnchor = 416, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 1) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.25 40 on top mt side
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 282, groupSpacing = 25, xAnchor = 470, yAnchor = -10, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:PositionLayout("horizontal")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.25 20 top mt side
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 440, groupSpacing = -67, xAnchor = 399, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        end
    elseif (theLayout == 3) then 
        if (MazzleUI_LastAspect == 3) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.6 40 on top mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 255, groupSpacing = 10, xAnchor = 521, yAnchor = -20, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.6 20 top mt top
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 694, groupSpacing = -67, xAnchor = 480, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 2) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.33 40 on top mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 251, groupSpacing = 10, xAnchor = 328, yAnchor = -17, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.33 20 top mt top done
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 695, groupSpacing = -67, xAnchor = 284, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 1) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.25 40 on top mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 262, groupSpacing = 10, xAnchor = 306, yAnchor = -17, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                --1.25 20 top mt top done
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 702, groupSpacing = -67, xAnchor = 264, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        end
    elseif (theLayout == 4) then 
        if (MazzleUI_LastAspect == 3) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.6 40 on top 3-frame mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 382, groupSpacing = 10, xAnchor = 435, yAnchor = -20, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.6 20 top 3-frame mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 825, groupSpacing = -67, xAnchor = 391, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 2) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.33 40 top 3-frame mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.94, targetAdjust = 380, groupSpacing = 10, xAnchor = 264, yAnchor = -17, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                -- 1.33 20 top 3-frame mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.90, targetAdjust = 838, groupSpacing = -67, xAnchor = 250, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        elseif (MazzleUI_LastAspect == 1) then
            if (MazzleUI_Status.inRaid40 or (MazzleUI_Status.inRaid20 and (not MazzleUI_Settings.AutoSwapRaid20))) then
                -- 1.25 40 on top 3-frame mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 399, groupSpacing = 5, xAnchor = 255, yAnchor = -17, yMargin = 5, adjust125x = 190, adjust125y = 100}
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle")
                MazzleUI:sRaidGrow("down")
                MazzleUI:sRaidShowGroups(true)
            else
                --1.25 20 top 3-frame mt on top
                MazzleUI_Settings.sRaidFrames = { scale = 0.9, targetAdjust = 834, groupSpacing = -67, xAnchor = 198, yAnchor = -15, yMargin = 5, adjust125x = 190, adjust125y = 100}
                MazzleUI:sRaidGrow("right")
                sRaidFrames:chatScale(MazzleUI_Settings.sRaidFrames.scale)
                sRaidFrames:chatSetLayout("mazzle20")
                MazzleUI:sRaidShowGroups(false)
            end
        end
    end
end

function MazzleUI:sRaidShowGroups(showAll)
    if (showAll) then
        sRaidFrames.opt.GroupFilter[1] = true
        sRaidFrames.opt.GroupFilter[2] = true
        sRaidFrames.opt.GroupFilter[3] = true
        sRaidFrames.opt.GroupFilter[4] = true
        sRaidFrames.opt.GroupFilter[5] = true
        sRaidFrames.opt.GroupFilter[6] = true
        sRaidFrames.opt.GroupFilter[7] = true
        sRaidFrames.opt.GroupFilter[8] = true
    else
        sRaidFrames.opt.GroupFilter[1] = true
        sRaidFrames.opt.GroupFilter[2] = true
        sRaidFrames.opt.GroupFilter[3] = true
        sRaidFrames.opt.GroupFilter[4] = true
        sRaidFrames.opt.GroupFilter[5] = false
        sRaidFrames.opt.GroupFilter[6] = false
        sRaidFrames.opt.GroupFilter[7] = false
        sRaidFrames.opt.GroupFilter[8] = false
    end
	sRaidFrames:UpdateVisibility()
end

function MazzleUI:sRaidGrow(growDirection)
    
	sRaidFrames:S("Growth", growDirection)
	sRaidFrames:UpdateVisibility()

end

function MazzleUI:oRA_MTPosition(thePosition)
    local xcenter
    MazzleUI_CreatePath("DFM_Settings.MazzleUI._Raiding.oRA_MainTankFrameMtMain.dummy")

    if (thePosition == "standard") then
        oRAOMainTank:ToggleGrowup(true)
        MazzleUI_Settings.oRA = { width = 100, nameWidth = 52, nameIndent = 11, raidIconIndent = 0 }
        oRAOMainTank:SetScale(1.0)
        DFM_Settings.MazzleUI._Raiding["oRA_MainTankFrameMtMain"] = {
                ["Location"] = {
                ["to"] = "BOTTOMRIGHT",
                ["x"] = -136,
                ["y"] = 160,
                ["lock"] = 1,
                ["frame"] = "UIParent",
                ["point"] = "BOTTOMRIGHT",
                ["use"] = 1,
            },
            ["name"] = "oRA_MainTankFrameMtMain",
        }
    elseif (thePosition == "standard-125") then
        MazzleUI_Settings.oRA = { width = 100, nameWidth = 52, nameIndent = 11, raidIconIndent = 0 }
        oRAOMainTank:ToggleGrowup(true)
        oRAOMainTank:SetScale(1.0)
        DFM_Settings.MazzleUI._Raiding["oRA_MainTankFrameMtMain"] = {
            ["Location"] = {
                ["x"] = -136,
                ["y"] = 323,
                ["point"] = "BOTTOMRIGHT",
                ["frame"] = "UIParent",
                ["to"] = "BOTTOMRIGHT",
                ["lock"] = 1,
                ["use"] = 1,
            },
            ["name"] = "oRA_MainTankFrameMtMain",
        }
    elseif (thePosition == "top") then
        MazzleUI_Settings.oRA = { width = 120, nameWidth = 62, nameIndent = 18, raidIconIndent = 1  }
        if (MazzleUI_LastAspect == 3) then
            xcenter = -48
        elseif (MazzleUI_LastAspect == 2) then
            xcenter = -72
        elseif (MazzleUI_LastAspect == 1) then
            xcenter = -71
        end
        oRAOMainTank:SetScale(1.0)
        oRAOMainTank:ToggleGrowup(false)
        DFM_Settings.MazzleUI._Raiding["oRA_MainTankFrameMtMain"] = {
            ["Location"] = {
                ["x"] = xcenter,
                ["y"] = -22,
                ["point"] = "TOP",
                ["frame"] = "UIParent",
                ["to"] = "TOP",
                ["lock"] = 1,
                ["use"] = 1,
            },
            ["name"] = "oRA_MainTankFrameMtMain",
        }
    elseif (thePosition == "top-3") then
        MazzleUI_Settings.oRA = { width = 120, nameWidth = 62, nameIndent = 18, raidIconIndent = 1  }
        if (MazzleUI_LastAspect == 3) then
            xcenter = -130
        elseif (MazzleUI_LastAspect == 2) then
            xcenter = -132
        elseif (MazzleUI_LastAspect == 1) then
            xcenter = -131
        end
        oRAOMainTank:SetScale(1.0)
        oRAOMainTank:ToggleGrowup(false)
        DFM_Settings.MazzleUI._Raiding["oRA_MainTankFrameMtMain"] = {
            ["Location"] = {
                ["x"] = xcenter,
                ["y"] = -22,
                ["point"] = "TOP",
                ["frame"] = "UIParent",
                ["to"] = "TOP",
                ["lock"] = 1,
                ["use"] = 1,
            },
            ["name"] = "oRA_MainTankFrameMtMain",
        }
    elseif (thePosition == "petAdjust") then
        MazzleUI_Settings.oRA = { width = 100, nameWidth = 52, nameIndent = 11, raidIconIndent = 0 }
        oRAOMainTank:ToggleGrowup(true)
        oRAOMainTank:SetScale(1.0)
        DFM_Settings.MazzleUI._Raiding["oRA_MainTankFrameMtMain"] = {
            ["Location"] = {
                ["x"] = -136,
                ["y"] = 472,
                ["point"] = "BOTTOMRIGHT",
                ["frame"] = "UIParent",
                ["to"] = "BOTTOMRIGHT",
                ["lock"] = 1,
                ["use"] = 1,
            },
            ["name"] = "oRA_MainTankFrameMtMain",
        }
    end
    DFM_Initialize_Frame("_Raiding","oRA_MainTankFrameMtMain")
    if (thePosition == "top-3") then
		oRAOMainTank.db.profile.showmttt = true
		oRAOMainTank:UpdateFrameShow()
		oRAOMainTank:oRA_MainTankUpdate()
    else
		oRAOMainTank.db.profile.showmttt = false
		oRAOMainTank:UpdateFrameShow()
    end
end

function MazzleUI:OnClick(side, buttonID)
    if (buttonID == 1) then 
        MazzleUI:ToggleRecap(side)
        GameTooltip:Hide()
        MazzleUI:OnTooltip(1, MazzleUI_RecapButton)
    elseif (buttonID == 2) then 
        MazzleUI:ToggleEfficiency()
        GameTooltip:Hide()
        MazzleUI:OnTooltip(2, MazzleUI_EfficiencyButton)
    elseif (buttonID == 3) then 
        MazzleUI:ToggleFastCast()
        GameTooltip:Hide()
        MazzleUI:OnTooltip(3, MazzleUI_FastCastButton)
    elseif (buttonID == 10) then 
        MazzleUI:ToggleOptions()
        GameTooltip:Hide()
        MazzleUI:OnTooltip(10, MazzleUI_OptionsButton)
    end
    MazzleUI:MouseClickEffect()
end

function MazzleUI:OnTooltip(buttonID, owner)
    GameTooltip:SetOwner(owner,"ANCHOR_LEFT")
    if (buttonID == 1) then
        if (IsAddOnLoaded("Recap") and ((recap.Opt.State.value == "Idle") or (recap.Opt.State.value == "Active"))) then
        	GameTooltip:AddLine("Left-click to show/hide Recap.")
        	GameTooltip:AddLine("Right-click to toggle Recap combat monitoring.")
        	GameTooltip:AddLine("Recap is currently ON.")
        else
        	GameTooltip:AddLine("Left-click to show/hide Recap.")
        	GameTooltip:AddLine("Right-click to toggle Recap combat monitoring.")
        	GameTooltip:AddLine("Recap is currently OFF.")
        end
    elseif (buttonID == 2) then
        if (MazzleUI_Status.isManual) then
        	GameTooltip:AddLine("Click to toggle MazzleUI Efficiency Mode.")
        	GameTooltip:AddLine("MazzleUI Efficiency Mode is currently ON.")
        else
        	GameTooltip:AddLine("Click to toggle MazzleUI Efficiency Mode.")
        	GameTooltip:AddLine("MazzleUI Efficiency Mode is currently OFF.")
        end
    elseif (buttonID == 3) then
        if (MazzleUI:FastCastIsOn()) then
        	GameTooltip:AddLine("Click to toggle Cirk's FastCast.")
        	GameTooltip:AddLine("FastCast is currently ON.")
        else
        	GameTooltip:AddLine("Click to toggle Cirk's FastCast.")
        	GameTooltip:AddLine("FastCast is currently OFF.")
        end
    elseif (buttonID == 9) then
    	GameTooltip:AddLine("Click to show the MazzleUI Help Desk.")
    elseif (buttonID == 10) then
    	GameTooltip:AddLine("Click to show the MazzleUI Options Window.")
    end
    GameTooltip:Show()
end

function MazzleUI:ContextMenuClick()
    if (DAB_ActionBar_10:IsVisible() and MazzleUI_Settings.HideContextOnClick) then
        DAB_ActionBar_10:Hide()
    end
end

function MazzleUI:ShowContextMenu(dontMove)
    if (DAB_ActionBar_10:IsVisible()) then
        DAB_Bar_Hide(10);
    else
        if ((not dontMove) and MazzleUI_Settings.MoveContext) then
            local x, y = GetCursorPosition();
            x = x / UIParent:GetScale();
            y = y / UIParent:GetScale();
            DAB_Bar_Location(10, x, y, "UIParent", "CENTER", "BOTTOMLEFT");
        end
        DAB_Bar_Show(10);
    end
end

function MazzleUI:MouseClickEffect()
    -- Idea for following function borrowed from Sprocket
    local x2, y2 = GetCursorPosition();
    x2 = x2 / UIParent:GetScale();
    y2 = y2 / UIParent:GetScale();
    MazzleUI_MouseClick:ClearAllPoints();
    MazzleUI_MouseClick:SetPoint( "CENTER", "UIParent", "BOTTOMLEFT", x2, y2);
    
    MazzleUI_MouseClick:SetSequence(0);
    MazzleUI_MouseClick:SetSequenceTime(0, 0);
    MazzleUI_MouseClick:Show();
end

function MazzleUI:Handle_AutoRes()
	getglobal("StaticPopup1"):Hide()
	AcceptResurrect()
end

function MazzleUI:Handle_AutoSummon()
	getglobal("StaticPopup1"):Hide()
	ConfirmSummon()
end

function MazzleUI:Handle_PVPMode()
    MazzleUI_Status.inPvP = UnitIsPVP("player")
    MazzleUI:InstantiateEfficiencyMode()
end

function MazzleUI:Handle_AutoDismount()
    for i=0,15 do
        local currentBuff = GetPlayerBuffTexture(i)
        if currentBuff then
            if ((   string.find(string.lower(currentBuff), "_mount_") or 
                    string.find(string.lower(currentBuff), "spell_nature_swiftness")) or (
                    string.find(string.lower(currentBuff), "_qirajicrystal_"))) then
                CancelPlayerBuff(i)
           end
        end
    end
end

function MazzleUI:ExecuteMacro(theCommand)
	MazzleUI_EditBox:SetText(theCommand);
	local editBox = MazzleUI_EditBox;
	ChatEdit_SendText(editBox);
end

function MazzleUI:StartEditCommand(theCommand)
	ChatFrameEditBox:SetText(theCommand);
    ChatFrameEditBox:Show();
end

function MazzleUI:InitSettings()

	Mazzifier_PlayerName = UnitName("player");
	Mazzifier_ServerName = GetCVar("realmName");
    Mazzifier_PlayerClass = UnitClass("player");

    if (not MazzleUI_Settings) then MazzleUI_Settings = {} end
    MazzleUI_Settings = MazzleUI:VerifyDefaults(MazzleUI_Settings, MazzleUI_SettingsDefault)

end

function MazzleUI:VerifyDefaults(originalTable, defaultTable)
    
    for theSetting, theDefaultValue in defaultTable do
        if (type(defaultTable[theSetting]) == "table") then
            if (type(originalTable[theSetting]) == "nil") then
                originalTable[theSetting] = {}
            end
            originalTable[theSetting] = MazzleUI:VerifyDefaults(originalTable[theSetting], defaultTable[theSetting])
        else
            if (type(originalTable[theSetting]) == "nil") then
                originalTable[theSetting] = theDefaultValue
            end
       end
    end
    return originalTable
end

MazzleUI_SettingsDefault = {
    debugPrint = true,
    debugLogOn = false,
    OptionsMode = "Options",
    OptionsLastTopic = 1,
    sRaidFrames = { scale = 0.8, targetAdjust = 315, groupSpacing = 0, xAnchor = 483, yAnchor = -1320, yMargin = 5},
    oRA = { width = 100, nameWidth = 52, nameIndent = 11, raidIconIndent = 0 },
    Mazz3D = { randomAnims = true, eventAnims = true, adjustModels = true, debugEvents = false, debugCamera = false, debugCameraSounds = false,},
    HotSpots = { RaidCycle = true, KCI = true, MonkeyQuest = true, Notebook = true, NeedyList = true, ItemRack = true, Compass = true, xCalc = true, ToT = true,},
    HUD = { Transparency_IC = 0.1, Transparency_OOC = 0.0, Transparency_FG_IC = 0.5, Transparency_FG_OOC = 0.0, UseHUD = true, Transparency_ToT = 1.0, Transparency_ComboPoints = 1.0},
    AutohideRezMonitor = true,
    AutoshowRezMonitor = true,
    hideResurrectionXRSPvP = true,
    AutoRes = true,
    AutoSummon = false,
    AutoDismount = true,
    HideContext = false,
    HideContextOnClick = true,
    MoveContext = true,
    manageRaidFrames = true,
    ShowRaidParty = true,
    FaveRaidPosition = 1,
    FaveMTPosition = 1,
    AutoSwapRaid20 = true,
    NeedyListEnabled = true,
    Performance_Names      = { High = { Own = false, Name = true, Guild = true, Title = true, NPCName = true, NamePlate = false, NPCNamePlate = false,},
                                Low = { Own = false, Name = false, Guild = false, Title = false, NPCName = false, NamePlate = false, NPCNamePlate = false,},},
	Performance_BlizzardSCTD = false,
    DiscordUpdate = 10,
	Performance_DiscordUpdate = 5,
	Performance_LightSCT = false,
	Performance_BigWigs = { manual = true, party = false, combat = false, raid = true, solo = false, pvp = false,},
	Performance_Buttons = { manual = true, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_CECB = { manual = false, party = true, combat = true, raid = false, solo = true, pvp = true,},
	Performance_Compass = { manual = false, party = true, combat = false, raid = false, solo = true, pvp = false,},
	Performance_Discord = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_Enabled = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_FastCast = { manual = false, party = false, combat = false, raid = false, solo = false, pvp = false,},
	Performance_Gfx = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_Models = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_NamePlates = { manual = false, party = false, combat = false, raid = false, solo = false, pvp = true,},
	Performance_QueueWho = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_Recap = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = false,},
	Performance_SCL = { manual = true, party = false, combat = true, raid = true, solo = true, pvp = true,},
	Performance_SCT = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,},
	Performance_SCTC = { manual = false, party = true, solo = true, raid = true, combat = true, pvp = true,},
	Performance_SCTD = { manual = false, party = true, solo = true, raid = true, combat = true, pvp = true,},
	Performance_SpellAlert = { manual = false, party = true, solo = true, raid = true, combat = true, pvp = true,},
}

function MazzleUI:TargetTell(msg)

	local chatFrame = DEFAULT_CHAT_FRAME;
	if UnitExists("target") and UnitName("target") and UnitIsPlayer("target") then
		chatFrame.editBox.chatType = "WHISPER";
		chatFrame.editBox.tellTarget = UnitName("target");
		ChatEdit_UpdateHeader(chatFrame.editBox);
		if ( not chatFrame.editBox:IsVisible() ) then
			ChatFrame_OpenChat("", chatFrame);
		end
	else
		ace:print("|CFFFF0000MazzleUI: |rYou cannot send a tell to that target.")
	end
end

