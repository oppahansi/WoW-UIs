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

MazzifierAnimDB = {
    ["Wave"] = {
        ["textureObject"] = nil,
        ["nextAnim"] = "Wave2", },
    ["Wave2"] = {
        ["textureObject"] = nil,
        ["nextAnim"] = "Wave3", },
    ["Wave3"] = {
        ["textureObject"] = nil,
        ["nextAnim"] = "Wave", },
    ["Cast"] = {
        ["textureObject"] = nil,
        ["nextAnim"] = nil, },
    ["Cast2"] = {
        ["textureObject"] = nil,
        ["nextAnim"] = nil, },
}

function Mazzifier_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	tinsert(UISpecialFrames, "Mazzifier_Frame");

    --this:Show()
end

function Mazzifier_OnEvent(event)
	if (event=="ADDON_LOADED" and arg1=="Mazzifier") then
        MazzleTex1:SetTexture("Interface\\AddOns\\Mazzifier\\images\\Wave1")
        MazzleTex2:SetTexture("Interface\\AddOns\\Mazzifier\\images\\Wave2")
        MazzleTex3:SetTexture("Interface\\AddOns\\Mazzifier\\images\\Wave3")
        MazzleTex4:SetTexture("Interface\\AddOns\\Mazzifier\\images\\Cast1")
        MazzleTex5:SetTexture("Interface\\AddOns\\Mazzifier\\images\\Cast2")
        MazzifierAnimDB["Wave"].textureObject = MazzleTexFrame1
        MazzifierAnimDB["Wave2"].textureObject = MazzleTexFrame2
        MazzifierAnimDB["Wave3"].textureObject = MazzleTexFrame3
        MazzifierAnimDB["Cast"].textureObject = MazzleTexFrame4
        MazzifierAnimDB["Cast2"].textureObject = MazzleTexFrame5
        MazzleTexFrame1:Hide()
        MazzleTexFrame2:Hide()
        MazzleTexFrame3:Hide()
        MazzleTexFrame4:Hide()
        MazzleTexFrame5:Hide()
		DEFAULT_CHAT_FRAME:AddMessage(Mazzifier_LOADED_MESSAGE,0.0,1.0,0.0);
		Mazzifier_CheckLoadedAddons()
	end
end

function Mazzify_SchedulePhase2()
    ace:print("Mazzify_SchedulePhase2 called")
    Timex:AddSchedule("Mazzifier_MazzifyTimerOE", 1.5, nil, nil, Mazzify_Phase2,1)
end

function Mazzify_Show()
	MazzifierAnim = "Wave"
	if (GetCVar("uiScale") ~= "0.63999998569489") then SetCVar("uiScale", "0.63999998569489"); end;
	if (GetCVar("useUiScale") ~= "1") then SetCVar("useUiScale", "1"); end;
	Mazzifier_Frame:Show();
	Timex:AddSchedule("Mazzifier_AnimTimer", 0.2, true, nil, Mazzifier_Animate)
    Timex:AddSchedule("Mazzifier_MazzifyTimerShow", 7, nil, nil, Mazzify_PrePhase)
    Timex:AddSchedule("Mazzifier_MazzifyTimerShow2", 3, nil, nil, PlaySoundFile, "Sound\\Character\\Gnome\\GnomeVocalFemale\\GnomeFemaleHello02.wav")            
	Mazzifier_SetupGUI()
    Mazzify_CheckAddons()
end

function Mazzify_Hide()
	Mazzifier_Frame:Hide();
    Mazzifier_Progress = 2
	Timex:DeleteSchedule("Mazzifier_AnimTimer")
end

function Mazzify_ExecuteMacro(theCommand)
	Mazzifier_EditBox:SetText(theCommand);
	local editBox = Mazzifier_EditBox;
	ChatEdit_SendText(editBox);
end

function Mazzifier_Animate()
    local nextAnim = nil
    if (MazzifierAnim) then
        for animName,animInfo in MazzifierAnimDB do
            if (animName == MazzifierAnim) then
                animInfo.textureObject:Show()
                nextAnim = animInfo.nextAnim
             else
                animInfo.textureObject:Hide()
             end
        end
        MazzifierAnim = nextAnim
    end
end

function Mazzify_ChatSizeChange(theChatFrame, theChatSize)
    local fontFile, unused, fontFlags = theChatFrame:GetFont();
    local frameID = theChatFrame:GetID()
    theChatFrame:SetFont(fontFile, theChatSize, fontFlags);
    SetChatWindowSize(frameID,theChatSize) 
end

function Mazzify_ChatSize(sizeType)

    local sizeImportant, sizeSpam, sizeCombatLog
    if (sizeType == 2) then
        sizeImportant, sizeSpam, sizeCombatLog = 15, 14, 13
    elseif (sizeType == 3) then
        sizeImportant, sizeSpam, sizeCombatLog = 18, 16, 15
    else
        sizeImportant, sizeSpam, sizeCombatLog = 13, 12, 10
    end
        
    Mazzify_ChatSizeChange(ChatFrame1,sizeImportant) 
    Mazzify_ChatSizeChange(ChatFrame2,sizeImportant) 
    Mazzify_ChatSizeChange(ChatFrame3,sizeSpam) 
    Mazzify_ChatSizeChange(ChatFrame4,sizeSpam) 
    Mazzify_ChatSizeChange(ChatFrame5,sizeImportant) 
    Mazzify_ChatSizeChange(ChatFrame6,sizeCombatLog) 
    Mazzify_ChatSizeChange(ChatFrame7,sizeCombatLog)

end

function Mazzify_ChatWindows()

    SetChatWindowShown(1,1) 
	SetChatWindowDocked(1,1)
	SetChatWindowColor(1,0,0,0)
	SetChatWindowAlpha(1,0) 
    SetChatWindowName(1,"General")
    SetChatWindowLocked(1,1) 

    SetChatWindowShown(2,1) 
	SetChatWindowDocked(2,2)
	SetChatWindowColor(2,0,0,0)
	SetChatWindowAlpha(2,0) 
    SetChatWindowName(2,"Private")
    SetChatWindowLocked(2,1) 

    SetChatWindowShown(3,1) 
	SetChatWindowDocked(3,3)
	SetChatWindowColor(3,0,0,0)
	SetChatWindowAlpha(3,0) 
    SetChatWindowName(3,"Trade")
    SetChatWindowLocked(3,1) 

    SetChatWindowShown(4,1) 
	SetChatWindowDocked(4,4)
	SetChatWindowColor(4,0,0,0)
	SetChatWindowAlpha(4,0) 
    SetChatWindowName(4,"LFG")
    SetChatWindowLocked(4,1) 

    SetChatWindowShown(5,1) 
	SetChatWindowDocked(5,5)
	SetChatWindowColor(5,0,0,0)
	SetChatWindowAlpha(5,0) 
    SetChatWindowName(5,"Guild")
    SetChatWindowLocked(5,1) 

    SetChatWindowShown(6,1) 
	SetChatWindowDocked(6,0)
	SetChatWindowColor(6,0,0,0)
	SetChatWindowAlpha(6,1) 
    SetChatWindowName(6,"Dmg Out")
    SetChatWindowLocked(6,1) 

    SetChatWindowShown(7,1) 
	SetChatWindowDocked(7,0)
	SetChatWindowColor(7,0,0,0)
	SetChatWindowAlpha(7,1) 
    SetChatWindowName(7,"Combat Log")
    SetChatWindowLocked(7,1) 
    
end

function Mazzify_ChatGroups()
    ChatFrame_RemoveAllMessageGroups(ChatFrame2)
    ChatFrame_RemoveChannel(ChatFrame1, "LookingForGroup")
    ChatFrame_RemoveChannel(ChatFrame1, "Trade")
    ChatFrame_RemoveChannel(ChatFrame1, "LocalDefense")
    ChatFrame_RemoveMessageGroup(ChatFrame1, "SKILL")
    ChatFrame_RemoveMessageGroup(ChatFrame1, "LOOT")
    ChatFrame_AddMessageGroup(ChatFrame7, "SKILL")
    ChatFrame_AddMessageGroup(ChatFrame7, "LOOT")
    ChatFrame_AddMessageGroup(ChatFrame2, "WHISPER")
    AddChatWindowChannel(3, "Trade") 
    AddChatWindowChannel(4, "LookingForGroup") 
    ChatFrame_AddMessageGroup(ChatFrame5, "GUILD")
end

function Mazzify_CheckAddons()
    local loadable, showWarning = false, false
    local warningList = ""
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if (addonInfo.trueName) then
            _, _, _, _, loadable, _, _= GetAddOnInfo(addonInfo.trueName)
            if (addonInfo.needsUpdate and (not loadable)) then
                showWarning = true
                if (warningList == "") then
                    warningList = addonInfo.name
                else
                    warningList = warningList..", "..addonInfo.name
                end
            end
        end
    end
    if (showWarning) then
        Mazzifier_NeedAddonsFrame_Text:SetText(" The Mazzifier needs to update the settings for some add-ons that it cannot currently access because they are turned off.  Would you like the Mazzifier to enable all of those add-ons first and reload your UI, so that you can properly mazzify all necessary add-ons?\n\nAdd-Ons that need to be enabled: "..warningList)
        Mazzifier_NeedAddonsFrame_Text:SetTextColor(1,1,1)
        Mazzifier_NeedAddonsFrame:Show()
    end
end

function Mazzify_EnableNeededAddOns()
    local loadable
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if (addonInfo.trueName) then
            _, _, _, _, loadable, _, _= GetAddOnInfo(addonInfo.trueName)
            if (addonInfo.needsUpdate and (not loadable)) then
                EnableAddOn(addonInfo.trueName)
            end
        end
    end
    Mazzifier_Progress = 0.5
    ConsoleExec("ReloadUI");
end


function Mazzify_Addons()
    for theAddon,isEnabled in Mazzifier_CurrentInstallOptions.AddOnList do
        if (isEnabled and getglobal(Mazzifier_AddOnInfo[theAddon].setupFunc)) then
            ace:print("Mazzifying ", theAddon)
            getglobal(Mazzifier_AddOnInfo[theAddon].setupFunc)()
            ace:print("Done mazzifying ", theAddon)
        end
    end
end

function Mazzify_AS()
    local shouldEnable = false
    local disableText, enableText, disableCount, enableCount = "Disabling: ", "Enabling: ", 0, 0
    for _,addonInfo in MazzleUI_AddOn_DB do
        shouldEnable = true
        if (addonInfo.core) then
            if (addonInfo.classes) then
                if ((not Mazzifier_CurrentInstallOptions.AddonExtras.class) or (not addonInfo.classes[Mazzifier_PlayerClass])) then shouldEnable = false end
            end
            if (addonInfo.raiding) then
                if (not Mazzifier_CurrentInstallOptions.AddonExtras.raiding) then shouldEnable = false end
            end
            if (addonInfo.raidleader) then
                if (not Mazzifier_CurrentInstallOptions.AddonExtras.raidleader) then shouldEnable = false end
            end
            if (addonInfo.pvp) then
                if (not Mazzifier_CurrentInstallOptions.AddonExtras.pvp) then shouldEnable = false end
            end
            if (Mazzifier_CurrentInstallOptions.AddonExtras.corepackage and addonInfo.notInPackage and addonInfo.notInPackage[Mazzifier_CurrentInstallOptions.AddonExtras.corepackage]) then shouldEnable = false end;
            if (shouldEnable) then
                EnableAddOn(addonInfo.addonName)
            else
                DisableAddOn(addonInfo.addonName)
            end
        end
    end
    if (Mazzifier_CurrentInstallOptions.AddonExtras.gatherer) then
        EnableAddOn("Gatherer")
    else
        DisableAddOn("Gatherer")
    end
    if (Mazzifier_CurrentInstallOptions.AddonExtras.enemycastbar) then
        EnableAddOn("CEnemyCastBar")
    else
        DisableAddOn("CEnemyCastBar")
    end
    if (Mazzifier_CurrentInstallOptions.AddonExtras.klh) then
        EnableAddOn("KLHThreatMeter")
    else
        DisableAddOn("KLHThreatMeter")
    end
    if (Mazzifier_CurrentInstallOptions.AddonExtras.damageheal) then
        if (Mazzifier_CurrentInstallOptions.AddonExtras.recap) then
            EnableAddOn("Recap")
        else
            DisableAddOn("Recap")
        end
        if (Mazzifier_CurrentInstallOptions.AddonExtras.dm) then
            EnableAddOn("DamageMeters")
            EnableAddOn("Fubar_DamageMetersFu2")
        else
            DisableAddOn("DamageMeters")
            DisableAddOn("Fubar_DamageMetersFu2")
        end
        if (Mazzifier_CurrentInstallOptions.AddonExtras.sws) then
            EnableAddOn("SW_Stats")
        else
            DisableAddOn("SW_Stats")
        end
    else
        DisableAddOn("Recap")
        DisableAddOn("DamageMeters")
        DisableAddOn("Fubar_DamageMetersFu2")
        DisableAddOn("SW_Stats")
    end
    if (UnitLevel("player") == 60) then
        DisableAddOn("Fubar_ExperienceFu")
        ace:print("Disabling Fubar ExperienceFu for level 60 character "..Mazzifier_PlayerName)
    end       
end

function Mazzify_Conflicts()
    local shouldInstall = false
    for _,addonName in Mazzifier_ConflictAddOns do
        DisableAddOn(addonName)
    end
end

function Mazzify_Layout()
    LoadAddOn("DiscordArtOptions")
    LoadAddOn("DiscordUnitFramesOptions")
    if (DART_Settings and DUF_Settings and DFM_Settings) then
        if (not DART_Settings.MazzleUI) then
            DART_Options_NewProfile("MazzleUI")
        end
        if (not DUF_Settings.MazzleUI) then
            DUF_Options_SaveSettings("MazzleUI")
        end
        if (not DFM_Settings.MazzleUI) then
            DFM_Create_Profile("MazzleUI")
        end
        Setup_DFM("MazzleUI")
        Setup_DART16("MazzleUI")
        if (Mazzifier_CurrentInstallOptions.Aspect == 1) then
            Setup_DUF125("MazzleUI")
            Setup_DART125("MazzleUI")
        elseif (Mazzifier_CurrentInstallOptions.Aspect == 2) then
            Setup_DUF133("MazzleUI")
            Setup_DART133("MazzleUI")
        elseif (Mazzifier_CurrentInstallOptions.Aspect == 3) then
            Setup_DUF16("MazzleUI")
        end
        DART_Options_SetProfile("MazzleUI")
        DUF_Options_LoadSettings("MazzleUI")
        DFM_Load_Profile("MazzleUI")
        if (MovableBags_Config) then
            MovableBags_SlashHandler('reset')
        end
    else
        ace:print("MAZZIFIER ERROR: Discord Add-ons not initialized.")
    end
end

function Mazzify_DAB_Buttons()

    if (DAB_Settings) then
        local defaultLayoutNum = nil
        if (Mazzifier_CurrentInstallOptions and Mazzifier_CurrentInstallOptions.ButtonLayout) then
            for i=1, table.getn(Mazzifier_ButtonInfo), 1 do
                if (Mazzifier_CurrentInstallOptions.ButtonLayout.name == Mazzifier_ButtonInfo[i].devname) then
                    defaultLayoutNum = i
                end
            end
        end
        if (not defaultLayoutNum) then
            defaultLayoutNum = Mazzifier_DefaultLayout[UnitClass("player")]
        end

        local DABProfileName = Mazzifier_ButtonInfo[defaultLayoutNum].profileName
        if (not DAB_Settings[DABProfileName]) then
            DAB_New_Profile(DABProfileName)
        end

        DAB_Load_Profile("Default")

        if (Mazzifier_CurrentInstallOptions.Aspect == 1) then
            getglobal(Mazzifier_ButtonInfo[defaultLayoutNum].setupFunc125)(DABProfileName)
        elseif (Mazzifier_CurrentInstallOptions.Aspect == 2) then
            getglobal(Mazzifier_ButtonInfo[defaultLayoutNum].setupFunc133)(DABProfileName)
        elseif (Mazzifier_CurrentInstallOptions.Aspect == 3) then
            ace:print("Layout is ", defaultLayoutNum)
            getglobal(Mazzifier_ButtonInfo[defaultLayoutNum].setupFunc16)(DABProfileName)
        end
        DAB_Load_Profile(DABProfileName)
        if (Mazzifier_CurrentInstallOptions.SAS) then
            Mazzify_ClearActions()
            if (Mazzifier_ButtonInfo[defaultLayoutNum].sasFunc) then
                getglobal(Mazzifier_ButtonInfo[defaultLayoutNum].sasFunc)()
            end
        end
    end
end

function Mazzifier_MakeDev()
    
--    if (not DFM_Settings["MazzleUI-Dev"]) then
--        DFM_Create_Profile("MazzleUI-Dev")
--    end
--    Setup_DFM("MazzleUI-Dev")
--
--    LoadAddOn("DiscordArtOptions")
--    LoadAddOn("DiscordUnitFramesOptions")
--    
--    local currProfileName = "MazzleUI-125"
--    if (not DUF_Settings[currProfileName]) then DUF_Options_SaveSettings(currProfileName) end
--    if (not DART_Settings[currProfileName]) then DART_Options_NewProfile(currProfileName) end
--    Setup_DUF125(currProfileName)
--    Setup_DART125(currProfileName)
--    DART_Options_SetProfile(currProfileName)
--    DUF_Options_LoadSettings(currProfileName)
--    currProfileName = "MazzleUI-133"
--    if (not DUF_Settings[currProfileName]) then DUF_Options_SaveSettings(currProfileName) end
--    if (not DART_Settings[currProfileName]) then DART_Options_NewProfile(currProfileName) end
--    Setup_DUF133(currProfileName)
--    Setup_DART133(currProfileName)
--    DART_Options_SetProfile(currProfileName)
--    DUF_Options_LoadSettings(currProfileName)
--    currProfileName = "MazzleUI-16"
--    if (not DUF_Settings[currProfileName]) then DUF_Options_SaveSettings(currProfileName) end
--    if (not DART_Settings[currProfileName]) then DART_Options_NewProfile(currProfileName) end
--    Setup_DUF16(currProfileName)
--    Setup_DART16(currProfileName)
--    DART_Options_SetProfile(currProfileName)
--    DUF_Options_LoadSettings(currProfileName)

    for _,theProfile in Mazzifier_ButtonInfo do
        currProfileName = theProfile.profileName.."-16"
        ace:print("Setting up button layout ", currProfileName)
        DAB_New_Profile(currProfileName)
        getglobal(theProfile.setupFunc16)(currProfileName)
        --DAB_Load_Profile(currProfileName)
        if (theProfile.setupFunc133 ~= theProfile.setupFunc16) then
            currProfileName = theProfile.profileName.."-133"
            ace:print("Setting up button layout ", currProfileName)
            DAB_New_Profile(currProfileName)
            getglobal(theProfile.setupFunc133)(currProfileName)
            --DAB_Load_Profile(currProfileName)
        end        
        if (theProfile.setupFunc125 ~= theProfile.setupFunc133) then
            currProfileName = theProfile.profileName.."-125"
            ace:print("Setting up button layout ", currProfileName)
        DAB_New_Profile(currProfileName)
            getglobal(theProfile.setupFunc125)(currProfileName)
            --DAB_Load_Profile(currProfileName)
        end        
    end

    --ConsoleExec("ReloadUI");
end

function Mazzifier_DoMazzify()
    
    -- Play spell cast sound
    MazzifierAnim = "Cast"
    Mazzifier_Animate()
	Timex:AddSchedule("Mazzifier_MazzifyTimerDoMazz", 1.5, nil, nil, Mazzify_Phase0)

end

function Mazzify_PrePhase()
    if ((not Mazzifier_LastInstalledVersion) or (Mazzifier_LastInstalledVersion == 0.0)) then
        ace:print("Mazzifier pre-phase started.")
        for _,hideWin in { MonkeyQuestFrame, RecapFrame, CT_RA_ChangelogFrame, FastcastFrame, SimpleCompassFrame, DecursiveAfflictedListFrame, StaticPopup1, SAListTitleButton, AM_MapSelector, DamageMetersFrame} do
        	if (hideWin) then HideUIPanel(hideWin) end
        end
    	if (NLHeader) then NL_Disable() end
    	if (NecrosisButton) then
			HideUIPanel(NecrosisShardMenu);
    		HideUIPanel(NecrosisSpellTimerButton);
    		HideUIPanel(NecrosisButton);
    		HideUIPanel(NecrosisPetMenuButton);
    		HideUIPanel(NecrosisBuffMenuButton);
    		HideUIPanel(NecrosisMountButton);
    		HideUIPanel(NecrosisFirestoneButton);
    		HideUIPanel(NecrosisSpellstoneButton);
    		HideUIPanel(NecrosisHealthstoneButton);
    		HideUIPanel(NecrosisSoulstoneButton);
    		HideUIPanel(NecrosisAntiFearButton);
    		HideUIPanel(NecrosisShadowTranceButton);
        end
    end        
end

function Mazzify_Phase0()
    PlaySoundFile("Sound\\Spells\\ShaysBell.wav");
    PlaySoundFile("Sound\\Spells\\Vanish.wav");
    MazzifierAnim = "Cast2"
    Mazzifier_Animate()
	Timex:AddSchedule("Mazzifier_MazzifyTimer_P0", 1, nil, nil, Mazzify_Phase1,0)
end
    
function Mazzify_Phase1(callnum)
    if (DART_Settings and DUF_Settings and (DAB_Settings or (not IsAddOnLoaded("DiscordActionBars"))) and DFM_Settings) then
        ace:print("Mazzification Phase 1 initiated")
        local shouldReload = nil
        local lastProfile
        MazzleUI_LastAspect = Mazzifier_CurrentInstallOptions.Aspect
        if (Mazzifier_CurrentInstallOptions.Bindings) then
            ace:print("Mazzification Phase 1: Key Bindings")
            lastProfile = DAB_INDEX
            DAB_Load_Profile("Default")
            Mazzify_ExecuteMacro("/ace1 profile default")
        	Setup_Bindings()
        	shouldReload = true
            Mazzify_ExecuteMacro("/ace1 profile char")
            Mazzify_ExecuteMacro("/ace1 profile char mybindings")
            Mazzify_ExecuteMacro("/ace1 profile char kc_items")
            DAB_Load_Profile(lastProfile)
            SaveBindings(2)
        end
        if (Mazzifier_CurrentInstallOptions.Layout) then
            ace:print("Mazzification Phase 1: Chat and Resolution")
            Mazzify_ChatWindows()
            Mazzify_ChatGroups()
            Mazzify_Resolution()
        end
        if ( Mazzifier_CurrentInstallOptions.FontSize ~= Mazzifier_C_InstalledVersionDB.FontSize) then
            ace:print("Mazzification Phase 1: Fonts")
            Mazzify_ChatSize(Mazzifier_CurrentInstallOptions.FontSize)
        end
        if (Mazzifier_CurrentInstallOptions.Addons) then
            ace:print("Mazzification Phase 1: Add-On Settings")
            lastProfile = DAB_INDEX
            DAB_Load_Profile("Default")
            Mazzify_ExecuteMacro("/ace1 profile default")
            Mazzify_Addons()
            Mazzify_ExecuteMacro("/ace1 profile char")
            Mazzify_ExecuteMacro("/ace1 profile char mybindings")
            Mazzify_ExecuteMacro("/ace1 profile char kc_items")
            DAB_Load_Profile(lastProfile)
            shouldReload = true
        end
        if (Mazzifier_CurrentInstallOptions.AddonSelection) then
            ace:print("Mazzification Phase 1: Add-On Selection")
            Mazzify_AS()
            Mazzify_Conflicts()
            shouldReload = true
        end
        if (Mazzifier_CurrentInstallOptions.Buttons and IsAddOnLoaded("DiscordActionBars")) then
            ace:print("Mazzification Phase 1: Discord Action Buttons")
            Mazzify_DAB_Buttons()
        end
        if (Mazzifier_CurrentInstallOptions.Layout) then
        	--Setup_StatusWindow(Mazzifier_PlayerName, Mazzifier_ServerName)
            ace:print("Mazzification Phase 1: Discord Layout Settings")
            Mazzifier_Progress = 1
            Mazzify_Layout()
            shouldReload = true
        end
        Mazzify_Specialty()
        if (shouldReload) then
            Mazzifier_Progress = 1
            Mazzifier_ReloadUIButton:Show()
        else
            Mazzify_Hide()
            Mazzify_Phase2(0)
        end
    else
        callnum = callnum + 1
    	Timex:AddSchedule("Mazzifier_MazzifyTimer_P1_"..callnum, 1, nil, nil, Mazzify_Phase1, callnum)
    end
end

function Mazzify_Specialty()
    if (Mazzifier_LastInstalledVersion < 0.50) then
        if (MazzleUI_Settings) then
            MazzleUI_Settings.HUD = { Transparency_IC = 0.1, Transparency_OOC = 0.0, Transparency_FG_IC = 0.5, Transparency_FG_OOC = 0.0, UseHUD = true, Transparency_ToT = 1.0, Transparency_ComboPoints = 1.0}
            MazzleUI_Settings.Mazz3D = { randomAnims = true, eventAnims = true, adjustModels = true, debugCamera = false, debugCameraSounds = false,}
            MazzleUI_Settings.Performance_Names = { 
                High = { Own = false, Name = true, Guild = true, Title = true, NPCName = true, NamePlate = false, NPCNamePlate = false,},
                Low = { Own = false, Name = false, Guild = false, Title = false, NPCName = false, NamePlate = false, NPCNamePlate = false,},}
        	MazzleUI_Settings.Performance_BlizzardSCTD = false
            MazzleUI_Settings.DiscordUpdate = 10
        	MazzleUI_Settings.Performance_DiscordUpdate = 5
        	MazzleUI_Settings.Performance_LightSCT = false
        	MazzleUI_Settings.Performance_BigWigs = { manual = true, party = false, combat = false, raid = true, solo = false, pvp = false,}
        	MazzleUI_Settings.Performance_Buttons = { manual = true, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_CECB = { manual = false, party = true, combat = true, raid = false, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_Compass = { manual = false, party = true, combat = false, raid = false, solo = true, pvp = false,}
        	MazzleUI_Settings.Performance_Discord = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_Enabled = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_FastCast = { manual = false, party = false, combat = false, raid = false, solo = false, pvp = false,}
        	MazzleUI_Settings.Performance_Gfx = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_Models = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_NamePlates = { manual = false, party = false, combat = false, raid = false, solo = false, pvp = true,}
        	MazzleUI_Settings.Performance_QueueWho = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_Recap = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = false,}
        	MazzleUI_Settings.Performance_SCL = { manual = true, party = false, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_SCT = { manual = false, party = true, combat = true, raid = true, solo = true, pvp = true,}
        	MazzleUI_Settings.Performance_SCTC = { manual = false, party = true, solo = true, raid = true, combat = true, pvp = true,}
        	MazzleUI_Settings.Performance_SCTD = { manual = false, party = true, solo = true, raid = true, combat = true, pvp = true,}
        	MazzleUI_Settings.Performance_SpellAlert = { manual = false, party = true, solo = true, raid = true, combat = true, pvp = true,}
        end
    elseif (Mazzifier_LastInstalledVersion < 0.60) then
        if (MazzleUI_Settings) then
            MazzleUI_LastRaidView = 1
        	MazzleUI_Settings.AutoSwapRaid20 = true
            MazzleUI_Settings.RaidLayout40 = 1
        end
    end
end

function Mazzify_Phase2(timerNum)
    if ((DAB_INITIALIZED or (not IsAddOnLoaded("DiscordActionBars"))) and DFM_INITIALIZED) then
        ace:print("Mazzification Phase 2 initiated")
        if (not MazzleUI_LastRaidView) then
            MazzleUI_LastRaidView = 0
            --MazzleUI:NextView(1)
        end
        if (Dcr_Hide and DecursiveMainBar:IsVisible()) then Dcr_Hide(); end
        if (IsAddOnLoaded("DiscordActionBars")) then
            DAB_OtherBar_Hide(13)
            DAB_OtherBar_Hide(14)
        end
        if (Mazzifier_CurrentInstallOptions.Addons) then
            --Mazzify_ExecuteMacro("/ace1 profile class aceheal")
            --Mazzify_ExecuteMacro("/ace1 profile char kc_items")
        end
        Mazzify_HideSideBars()
        Mazzify_UpdateVersions()
    	DoEmote("moan")
    	if ((Mazzifier_PlayerName ~= "Mazzlefizz") and (Mazzifier_PlayerName ~= "Mazzlegasm") and (Mazzifier_PlayerName ~= "Mazzardah") and 
    	    (Mazzifier_PlayerName ~= "Mazzlemoo") and (Mazzifier_PlayerName ~= "Sandy") and (Mazzifier_PlayerName ~= "Aare") and 
    	    (Mazzifier_PlayerName ~= "Dana") and (Mazzifier_PlayerName ~= "Nizzam")) then
            SendChatMessage("Woah!  I just had an intense Mazzlegasm!!!","YELL")
        end
    	DoEmote("cheer")
    	DoEmote("dance")
    	ace:print(Mazzifier_WarnRemovedAddons())
        Mazzifier_Progress = 2
        MazzleUI:Enable()
        MazzleUI:Handle_GroupChanges()
        if (not Mazzifier_CurrentInstallOptions.InitialHelpShown) then
            LoadAddOn("MazzleOptions")
            MazzleOptions_Show()
            MazzleOptions_CategoryButtonOnClick(2)
            MazzleOptions_TopicButton_OnClick(2)
            Mazzifier_CurrentInstallOptions.InitialHelpShown = true
        end
    else
        timerNum = timerNum + 1
        ace:print("Scheduling another phase 2")
        Timex:AddSchedule("Mazzifier_MazzifyTimer_P2_"..timerNum, 1, nil, nil, Mazzify_Phase2, timerNum)
    end
end

function Mazzifier_ReloadUI()
    ConsoleExec("ReloadUI");
end

function Mazzifier_InstalledVersionDB_Set(theAddon, versionNum)
    if (Mazzifier_AddOnInfo and Mazzifier_AddOnInfo[theAddon]) then
        if (Mazzifier_AddOnInfo[theAddon].global) then
            MazzleUI_CreateSet("Mazzifier_G_InstalledVersionDB.Addons."..theAddon, versionNum)
        else
            MazzleUI_CreateSet("Mazzifier_C_InstalledVersionDB.Addons."..theAddon, versionNum)
        end
    end
end

function Mazzifier_InstalledVersionDB_Get(theAddon)
    if (Mazzifier_AddOnInfo and Mazzifier_AddOnInfo[theAddon]) then
        if (Mazzifier_AddOnInfo[theAddon].global) then
            return (Mazzifier_G_InstalledVersionDB.Addons[theAddon] or 0.0)
        else
            return (Mazzifier_C_InstalledVersionDB.Addons[theAddon] or 0.0)
        end
    else
        return 0.0
    end
end

function Mazzify_UpdateVersions()
    if (Mazzifier_CurrentInstallOptions.Layout) then
        Mazzifier_C_InstalledVersionDB.Layout = Mazzifier_CurrentPartVersions.Layout
    end
    if (Mazzifier_CurrentInstallOptions.Buttons) then
        Mazzifier_C_InstalledVersionDB.ButtonLayout = Mazzifier_CurrentInstallOptions.ButtonLayout
    end
    if (Mazzifier_CurrentInstallOptions.AddonSelection) then
        Mazzifier_C_InstalledVersionDB.AddonSelection = Mazzifier_CurrentPartVersions.AddonSelection
    end
    if (Mazzifier_CurrentInstallOptions.Bindings) then
        Mazzifier_C_InstalledVersionDB.Bindings = Mazzifier_CurrentPartVersions.Bindings
    end
    if (Mazzifier_CurrentInstallOptions.Addons) then
        Mazzifier_C_InstalledVersionDB.AddonSet = Mazzifier_CurrentPartVersions.Addons
        for theAddon,isEnabled in Mazzifier_CurrentInstallOptions.AddOnList do
            if (isEnabled) then
                Mazzifier_InstalledVersionDB_Set(theAddon, Mazzifier_AddOnInfo[theAddon].lastUpdate)
            end
        end
    end
    Mazzifier_LastInstalledVersion = Mazzifier_Version
    Mazzifier_C_InstalledVersionDB.FontSize = Mazzifier_CurrentInstallOptions.FontSize
    Mazzifier_G_InstalledVersionDB.firstInstall = false

end

function Mazzifier_WarnRemovedAddons()
    local shouldWarn = nil
    local warnMessage = "|CFFFF0000Warning:|CFFFFFFFF The following AddOns are no longer part of MazzleUI.  It is recommended that you delete them from your AddOns folder:|CFFFF8000"
    local name, title, notes, enabled, loadable, reason, security

    for _,addonName in Mazzifier_RemovedAddOns do
        name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonName)
        if ((not reason) or (reason and (reason ~= "MISSING"))) then
            warnMessage = warnMessage.." "..addonName
            shouldWarn = true
        end
    end
    for _,addonName in Mazzifier_ConflictAddOns do
        name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonName)
        if ((not reason) or (reason and (reason ~= "MISSING"))) then
            warnMessage = warnMessage.." "..addonName
            shouldWarn = true
        end
    end
    if (shouldWarn) then return warnMessage else return "" end
end


function Mazzify_HideSideBars()
    SHOW_MULTI_ACTIONBAR_2 = nil
    SHOW_MULTI_ACTIONBAR_3 = nil
    SHOW_MULTI_ACTIONBAR_4 = nil
	SHOW_MULTI_ACTIONBAR_1 = nil
	MultiActionBar_Update();
end

function Mazzify_Resolution()
    local screenX, screenY = CT_Viewport_GetCurrentResolution(GetScreenResolutions())
    local screenRatio = math.floor((screenX/screenY)*10)
    CT_Viewport_ApplyViewport(0,0,0,(147*(screenY/1200)))
end

function Mazzifier_UserMove(frameName, parent, sourcePoint, targetPoint, x, y)
    theFrame = getglobal(frameName)
    if (theFrame) then
        local isVisible theFrame:IsVisible()
        theFrame:Show()
        theFrame:SetPoint(sourcePoint, parent, targetPoint, x, y)
        theFrame:SetUserPlaced(true)
        if (not isVisible) then theFrame:Hide(); end
    end
end