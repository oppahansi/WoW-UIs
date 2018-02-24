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

local Mazzifier_ButtonMenuMapping = { currentMenuNum = {}, globalIndexNum = {}}

function Mazzifier_Next()
    local currentFrame = PanelTemplates_GetSelectedTab(Mazzifier_Frame) 
    if (currentFrame < 5) then 
        Mazzifier_TabSelect(nil,currentFrame+1)
    else
        Mazzifier_TabSelect(nil,1)
        Mazzifier_Button:Show()
        Mazzifier_NextButton:Hide()
        Timex:AddSchedule("Mazzifier_AttentionTimer", 0.1, true, nil, Mazzifier_Attention)
    end
end

function Mazzifier_Attention()
    Mazzifier_ReloadUIButton:SetTextColor(random(),random(),random())
end

function Mazzifier_ButtonDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Mazzifier_ButtonDropDown_Initialize);
	Mazzifier_ButtonDropDown.tooltip = "Various layouts designed by Mazzlefizz or submitted by the beta-testers";
	UIDropDownMenu_SetWidth(300, Mazzifier_ButtonDropDown);
	UIDropDownMenu_JustifyText("CENTER", Mazzifier_ButtonDropDown)
end

function Mazzifier_ButtonDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(Mazzifier_ButtonDropDown);
	local info;
    local valcnt = 0
    for index,value in Mazzifier_ButtonInfo do
        if ((Mazzifier_ButtonInfo[index].classes == "All") or (Mazzifier_ButtonInfo[index].classes == Mazzifier_PlayerClass)) then
            valcnt = valcnt + 1
        	info = {};
        	info.text = Mazzifier_ButtonInfo[index].name;
        	info.func = Mazzifier_ButtonDropDown_OnClick;
        	info.value = valcnt
        	if ( info.value == selectedValue ) then
        		info.checked = 1;
        	end
        	UIDropDownMenu_AddButton(info);
        	Mazzifier_ButtonMenuMapping.globalIndexNum[valcnt] = index
        	Mazzifier_ButtonMenuMapping.currentMenuNum[index] = valcnt
        end
    end
end

function Mazzifier_SetLayoutDefault()
    local defaultLayoutNum = nil
    if (Mazzifier_C_InstalledVersionDB and Mazzifier_C_InstalledVersionDB.ButtonLayout) then
        for i=1, table.getn(Mazzifier_ButtonInfo), 1 do
            if (Mazzifier_C_InstalledVersionDB.ButtonLayout.name == Mazzifier_ButtonInfo[i].devname) then
                defaultLayoutNum = i
            end
        end
    end
    if (not defaultLayoutNum) then
        for i=1, table.getn(Mazzifier_ButtonInfo), 1 do
            if (Mazzifier_DefaultLayout[UnitClass("player")] == Mazzifier_ButtonInfo[i].devname) then
                defaultLayoutNum = i
            end
        end
    end
    local currNum = Mazzifier_ButtonMenuMapping.currentMenuNum[defaultLayoutNum] or 1
        
	UIDropDownMenu_SetSelectedID(Mazzifier_ButtonDropDown, currNum);
	Mazzifier_SetLayoutChosen(defaultLayoutNum)
	UIDropDownMenu_SetText(Mazzifier_ButtonInfo[defaultLayoutNum].name, Mazzifier_ButtonDropDown)
end

function Mazzifier_SetLayoutChosen(layoutNumber)
    MazzleLayoutPict:SetTexture("Interface\\AddOns\\Mazzifier\\images\\"..Mazzifier_ButtonInfo[layoutNumber].image)
    Mazzifier_Tab5DescriptionText:SetText(Mazzifier_ButtonInfo[layoutNumber].description)
    Mazzifier_CurrentInstallOptions.ButtonLayout.name = Mazzifier_ButtonInfo[layoutNumber].devname
    Mazzifier_CurrentInstallOptions.ButtonLayout.version = Mazzifier_ButtonInfo[layoutNumber].lastUpdate
end

function Mazzifier_ButtonDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(Mazzifier_ButtonDropDown, this.value);
	Mazzifier_SetLayoutChosen(Mazzifier_ButtonMenuMapping.globalIndexNum[this.value])
end

function Mazzifier_TabSelect(tabName, tabNum)
    if ((tabName == "Mazzifier_FrameTab1") or (tabNum == 1)) then
        PanelTemplates_SetTab(Mazzifier_Frame, 1)
        Mazzifier_Tab1:Show()
        Mazzifier_Tab2:Hide()
        Mazzifier_Tab3:Hide()
        Mazzifier_Tab4:Hide()
        Mazzifier_Tab5:Hide()
    elseif ((tabName == "Mazzifier_FrameTab2") or (tabNum == 2)) then
        PanelTemplates_SetTab(Mazzifier_Frame, 2)
        Mazzifier_Tab1:Hide()
        Mazzifier_Tab2:Show()
        Mazzifier_Tab3:Hide()
        Mazzifier_Tab4:Hide()
        Mazzifier_Tab5:Hide()
    elseif ((tabName == "Mazzifier_FrameTab3") or (tabNum == 3)) then
        PanelTemplates_SetTab(Mazzifier_Frame, 3)
        Mazzifier_Tab1:Hide()
        Mazzifier_Tab2:Hide()
        Mazzifier_Tab3:Show()
        Mazzifier_Tab4:Hide()
        Mazzifier_Tab5:Hide()
    elseif ((tabName == "Mazzifier_FrameTab4") or (tabNum == 4)) then
        PanelTemplates_SetTab(Mazzifier_Frame, 4)
        Mazzifier_Tab1:Hide()
        Mazzifier_Tab2:Hide()
        Mazzifier_Tab3:Hide()
        Mazzifier_Tab4:Show()
        Mazzifier_Tab5:Hide()
    elseif ((tabName == "Mazzifier_FrameTab5") or (tabNum == 5)) then
        PanelTemplates_SetTab(Mazzifier_Frame, 5)
        Mazzifier_Tab1:Hide()
        Mazzifier_Tab2:Hide()
        Mazzifier_Tab3:Hide()
        Mazzifier_Tab4:Hide()
        Mazzifier_Tab5:Show()
    end        
end

function Mazzifier_SetupGUI()

    local needsUpdate, installedVersion

    Mazzifier_SetupInitialValues()
    Mazzifier_Tab5DescriptionTitle:SetText("Description:");
    PanelTemplates_SetNumTabs(Mazzifier_Frame, 5);
    Mazzifier_Frame.selectedTab=1;
    PanelTemplates_UpdateTabs(Mazzifier_Frame);
    
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index] = {}
        Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index].index = addonInfo.index
        needsUpdate = true
        installedVersion = Mazzifier_InstalledVersionDB_Get(addonIndexName)
        if ((addonInfo.name == "") or (installedVersion >= addonInfo.lastUpdate)) then
            needsUpdate = false
        end
        if (needsUpdate) then
            Mazzifier_AddOnInfo[addonIndexName].needsUpdate = true;
            Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index].labelText = addonInfo.name.." |CFFFF8000(Needs Update)"
            if (installedVersion > 0) then
                Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index].tooltipText = "Settings for this add-on have changed.  Previous version number "..installedVersion..", current version number "..addonInfo.lastUpdate..". Check to update."
            else
                Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index].tooltipText = "Settings for this add-on need Mazzification."
            end
        else
            Mazzifier_AddOnInfo[addonIndexName].needsUpdate = false;
            Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index].labelText = addonInfo.name
            Mazzifier_FrameCheckButtons["AddOn"..addonInfo.index].tooltipText = "Check to install MazzleUI default settings for this Add-On"
        end
    end
	local button, string, checked;
	for index, value in Mazzifier_FrameCheckButtons do
		button = getglobal("Mazzifier_FrameCheckButton"..value.index);
		string = getglobal("Mazzifier_FrameCheckButton"..value.index.."Text");
		checked = nil;
		button.disabled = nil;
		button:SetID(value.index);
		if ( value.func ) then
			checked = value.func();
		end
		OptionsFrame_EnableCheckBox(button);
		button:SetChecked(checked);
		string:SetText(TEXT(value.labelText));
		if (value.labelText == "") then
		    button:Hide()
		end
		button.tooltipText = value.tooltipText;
	end
    Mazzifier_InitUpdateMode()
    if (Mazzifier_AddonsNeedUpdate()) then
        Mazzifier_FrameCheckButton4Text:SetText(Mazzifier_FrameCheckButton4Text:GetText().." |CFFFF8000(Needs Update)")
    end
    if (Mazzifier_CurrentPartVersions.Layout > Mazzifier_C_InstalledVersionDB.Layout) then
        Mazzifier_FrameCheckButton5Text:SetText(Mazzifier_FrameCheckButton5Text:GetText().." |CFFFF8000(Needs Update)")
    end
    if (Mazzifier_CurrentPartVersions.AddonSelection > Mazzifier_C_InstalledVersionDB.AddonSelection) then
        Mazzifier_FrameCheckButton75Text:SetText(Mazzifier_FrameCheckButton75Text:GetText().." |CFFFF8000(Needs Update)")
    end
    if (Mazzifier_CurrentPartVersions.Bindings > Mazzifier_C_InstalledVersionDB.Bindings) then
        Mazzifier_FrameCheckButton76Text:SetText(Mazzifier_FrameCheckButton76Text:GetText().." |CFFFF8000(Needs Update)")
    end
    if (Mazzifier_ButtonsNeedUpdate()) then
        Mazzifier_FrameCheckButton6Text:SetText(Mazzifier_FrameCheckButton6Text:GetText().." |CFFFF8000(Needs Update)")
    end

    Mazzifier_ASLayoutWidgets()
    Mazzifier_AbleAddonSelection(Mazzifier_CurrentInstallOptions.AddonSelection)
    Mazzifier_SetLayoutDefault()
    Mazzifier_TabSelect(nil,1)
end

function Mazzifier_GetUpdateMode()
	if ((Mazzifier_LastInstalledVersion == 0.0) and Mazzifier_G_InstalledVersionDB.firstInstall) then
	    return 1
	end
    if ((Mazzifier_CurrentPartVersions.Addons > Mazzifier_C_InstalledVersionDB.AddonSet) or
        (Mazzifier_CurrentPartVersions.Layout > Mazzifier_C_InstalledVersionDB.Layout) or
        (Mazzifier_CurrentPartVersions.AddonSelection > Mazzifier_C_InstalledVersionDB.AddonSelection) or
        (Mazzifier_CurrentPartVersions.Bindings > Mazzifier_C_InstalledVersionDB.Bindings) or
        (Mazzifier_ButtonsNeedUpdate()) or
        (MazzleUI_LastAspect ~= Mazzifier_CurrentInstallOptions.Aspect)) then
        return 2
    end
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if ((addonInfo.name ~= "") and (Mazzifier_InstalledVersionDB_Get(addonIndexName) < addonInfo.lastUpdate)) then
           return 2
        end
    end
    -- Add version check for installed button layout
    return 3
end

    
function Mazzifier_SetupInitialValues()
    local Mazzifier_InstallOptionsDefault = {
        FontSize = 1,
        Buttons = 1,
        SAS = 1,
        Addons = 1,
        Layout = 1,
        AddonSelection = 1,
        Bindings = 1,
        AddonExtras = {
            class = true,
            pvp = true,
            raiding = true,
            raidleader = false,
            gatherer = false,
            enemycastbar = false,
            auctions = true,
            dm = false,
            recap = true,
            sws = false,
            klh = false,
            damageheal = true,
            corepackage = "full",
        },
        ButtonLayout = {},
    }
    local Mazzifier_G_InstallVersionsDefault = {
        firstInstall = true,
        Addons = {},
    }    
    local Mazzifier_C_InstallVersionsDefault = {
        Layout = 0.0,
        ButtonLayout = {},
        AddonSet = 0.0,
        AddonSelection = 0.0,
        Bindings = 0.0,
        Addons = {},
    }    

    Mazzifier_LastInstalledVersion = Mazzifier_LastInstalledVersion or 0.0
    if (not Mazzifier_C_InstalledVersionDB) then Mazzifier_C_InstalledVersionDB = {} end
    if (not Mazzifier_G_InstalledVersionDB) then Mazzifier_G_InstalledVersionDB = {} end
    Mazzifier_G_InstalledVersionDB = MazzleUI:VerifyDefaults(Mazzifier_G_InstalledVersionDB, Mazzifier_G_InstallVersionsDefault)
    Mazzifier_C_InstalledVersionDB = MazzleUI:VerifyDefaults(Mazzifier_C_InstalledVersionDB, Mazzifier_C_InstallVersionsDefault)
    for theAddOn in Mazzifier_AddOnInfo do
        if (Mazzifier_AddOnInfo[theAddOn].name ~= "") then
            if (Mazzifier_InstalledVersionDB_Get(theAddOn) == 0.0) then
                Mazzifier_InstalledVersionDB_Set(theAddOn, 0.0)
            end
        end
    end

    if (not Mazzifier_CurrentInstallOptions) then Mazzifier_CurrentInstallOptions = {} end
    Mazzifier_CurrentInstallOptions = MazzleUI:VerifyDefaults(Mazzifier_CurrentInstallOptions, Mazzifier_InstallOptionsDefault)

    Mazzifier_CurrentInstallOptions.Aspect = MazzleUI:GetAspect()
end

function Mazzifier_InitUpdateMode()
    local theUpdateMode = Mazzifier_GetUpdateMode()
    if (theUpdateMode == 1) then 
        Mazzifier_SetOptions_FullMode()
    elseif (theUpdateMode == 2) then 
        Mazzifier_SetOptions_UpdateMode()
    else
        Mazzifier_SetOptions_CustomMode()
    end
end

function Mazzifier_HandleCheckbutton(theButton)
    local buttonID = theButton:GetID()
    if ((buttonID > 0) and (buttonID <= 3)) then
        Mazzifier_CBClick_Aspect(this, buttonID)
    elseif (((buttonID >= 4) and (buttonID <= 7)) or (buttonID == 75) or (buttonID == 76)) then
        Mazzifier_CBClick_Parts(this, buttonID)
    elseif ((buttonID >= 8) and (buttonID <= 10)) then
        Mazzifier_CBClick_Fonts(this, buttonID)
    elseif ((buttonID >= 11) and (buttonID <= 12)) then
        Mazzifier_CBClick_ClassSpecific(this, buttonID)
    elseif ((buttonID >= 66) and (buttonID <= 67)) then
        Mazzifier_CBClick_PvP(this, buttonID)
    elseif ((buttonID >= 68) and (buttonID <= 71)) then
        Mazzifier_CBClick_RaidOption(this, buttonID)
    elseif ((buttonID >= 72) and (buttonID <= 73)) then
        Mazzifier_CBClick_BigWigs(this, buttonID)
    elseif (buttonID == 74) then
        Mazzifier_CBClick_SAS(this, buttonID)
    elseif ((buttonID >= 13) and (buttonID <= 15)) then
        Mazzifier_CBClick_Upgrade(this, buttonID)
    elseif ((buttonID >= 16) and (buttonID <= Mazzifier_LastAddonButtonNum)) then
        Mazzifier_CBClick_Addon(this, buttonID)
        --pAddons()
    else
        ace:print("Mazzifier Error:  Illegal button press ", buttonID)
    end
    --pOptions()
end

function Mazzifier_GetAddonIndexName(buttonID)
    for theAddonIndex,theAddonInfo in Mazzifier_AddOnInfo do
        if (theAddonInfo.index == buttonID) then
            return theAddonIndex
        end
    end
    ace:print("Mazzifier Error!  Button ID does not correspond to a valid add-on!")
    return nil
end

function Mazzifier_AbleButtons(isEnabled)
    if (isEnabled) then
        OptionsFrame_EnableDropDown(Mazzifier_ButtonDropDown)
        Mazzifier_EnableCheckbutton(Mazzifier_FrameCheckButton74)
    else
        OptionsFrame_DisableDropDown(Mazzifier_ButtonDropDown)
        OptionsFrame_DisableCheckBox(Mazzifier_FrameCheckButton74, Mazzifier_FrameCheckButton74:GetChecked())
    end
end

function Mazzifier_CheckLoadedAddons()
    for theAddonIndex,theAddonInfo in Mazzifier_AddOnInfo do
        if (theAddonInfo.trueName) then
            _, _, _, _, loadable, _, _= GetAddOnInfo(theAddonInfo.trueName)
            if (loadable) then
                Mazzifier_AddOnInfo[theAddonIndex].loaded = true
            else
                Mazzifier_AddOnInfo[theAddonIndex].loaded = false
            end
        else
            Mazzifier_AddOnInfo[theAddonIndex].loaded = true
        end
    end
end

function Mazzifier_AbleAddons(isEnabled)
    for cbCount = 16, Mazzifier_LastAddonButtonNum, 1 do
        if (isEnabled) then
            Mazzifier_EnableCheckbutton(getglobal("Mazzifier_FrameCheckButton"..cbCount))
        else
            OptionsFrame_DisableCheckBox(getglobal("Mazzifier_FrameCheckButton"..cbCount), getglobal("Mazzifier_FrameCheckButton"..cbCount):GetChecked())
        end
    end
end

function Mazzifier_AbleAddons(isEnabled)
    local theCheckbox
    for theAddonIndex,theAddonInfo in Mazzifier_AddOnInfo do
        theCheckbox = getglobal("Mazzifier_FrameCheckButton"..theAddonInfo.index)
        if (isEnabled and theAddonInfo.loaded) then
            Mazzifier_EnableCheckbutton(theCheckbox)
        else
            OptionsFrame_DisableCheckBox(theCheckbox, theCheckbox:GetChecked())
        end
    end
end

function Mazzifier_EnableCheckbutton(theButton)
    local isChecked = theButton:GetChecked()
    OptionsFrame_EnableCheckBox(theButton, isChecked)
    theButton:SetChecked(isChecked)
end
    
function Mazzifier_CBClick_Addon(theButton, buttonID)
    local theAddonIndex = Mazzifier_GetAddonIndexName(buttonID)
    if (Mazzifier_CurrentInstallOptions.AddOnList[theAddonIndex]) then
        if (theButton:GetChecked()) then
            theButton:SetChecked(1)
            return
        else
            Mazzifier_CurrentInstallOptions.AddOnList[theAddonIndex] = nil
            Mazzifier_SetOptions_Modified()
            return
        end
    else
        if (theButton:GetChecked()) then
            Mazzifier_CurrentInstallOptions.AddOnList[theAddonIndex] = 1
            Mazzifier_SetOptions_Modified()
            return
        end
    end
end

function Mazzifier_CBClick_Aspect(theButton, buttonID)
    if (Mazzifier_CurrentInstallOptions.Aspect ~= buttonID) then 
        Mazzifier_CurrentInstallOptions.Aspect = buttonID
        if (buttonID ~= 1) then Mazzifier_FrameCheckButton1:SetChecked(0) end
        if (buttonID ~= 2) then Mazzifier_FrameCheckButton2:SetChecked(0) end
        if (buttonID ~= 3) then Mazzifier_FrameCheckButton3:SetChecked(0) end
    else
		getglobal("Mazzifier_FrameCheckButton"..buttonID):SetChecked(1)
    end
end

function Mazzifier_CBClick_Fonts(theButton, buttonID)
    if (Mazzifier_CurrentInstallOptions.FontSize ~= (buttonID-7)) then 
        Mazzifier_CurrentInstallOptions.FontSize = buttonID - 7
        if (buttonID ~= 8) then Mazzifier_FrameCheckButton8:SetChecked(0) end
        if (buttonID ~= 9) then Mazzifier_FrameCheckButton9:SetChecked(0) end
        if (buttonID ~= 10) then Mazzifier_FrameCheckButton10:SetChecked(0) end
    else
		getglobal("Mazzifier_FrameCheckButton"..buttonID):SetChecked(1)
    end
end


function Mazzifier_CBClick_Parts(theButton, buttonID)
    if (buttonID == 75) then
        Mazzifier_CurrentInstallOptions.AddonSelection = theButton:GetChecked()
        Mazzifier_AbleAddonSelection(Mazzifier_CurrentInstallOptions.AddonSelection )
    elseif (buttonID == 4) then
        Mazzifier_CurrentInstallOptions.Addons = theButton:GetChecked()
        Mazzifier_AbleAddons(Mazzifier_CurrentInstallOptions.Addons)
    elseif (buttonID == 5) then
        Mazzifier_CurrentInstallOptions.Layout = theButton:GetChecked()
    elseif (buttonID == 6) then
        Mazzifier_CurrentInstallOptions.Buttons = theButton:GetChecked()
        Mazzifier_AbleButtons(Mazzifier_CurrentInstallOptions.Buttons)
    elseif (buttonID == 76) then
        Mazzifier_CurrentInstallOptions.Bindings= theButton:GetChecked()
    end
    Mazzifier_SetOptions_Modified()
end

function Mazzifier_CBClick_Upgrade(theButton, buttonID)
    if ((Mazzifier_CurrentInstallOptions.updateMode=="full") and (buttonID == 13)) then 
        Mazzifier_FrameCheckButton13:SetChecked(1)
    elseif ((Mazzifier_CurrentInstallOptions.updateMode=="upgrade") and (buttonID == 14)) then 
        Mazzifier_FrameCheckButton14:SetChecked(1)
    elseif ((Mazzifier_CurrentInstallOptions.updateMode=="custom") and (buttonID == 15)) then 
        Mazzifier_FrameCheckButton15:SetChecked(1)
    else
        if (buttonID == 13) then
            Mazzifier_SetOptions_FullMode()
        elseif (buttonID == 14) then
            Mazzifier_SetOptions_UpdateMode()
        elseif (buttonID == 15) then
            Mazzifier_SetOptions_CustomMode()
        end
        if (buttonID ~= 13) then Mazzifier_FrameCheckButton13:SetChecked(0) end
        if (buttonID ~= 14) then Mazzifier_FrameCheckButton14:SetChecked(0) end
        if (buttonID ~= 15) then Mazzifier_FrameCheckButton15:SetChecked(0) end
    end
end

function Mazzifier_CBClick_SAS(theButton, buttonID)
    if (theButton:GetChecked()) then
        Mazzifier_CurrentInstallOptions.SAS = true
        theButton:SetChecked(1)
    else
        Mazzifier_CurrentInstallOptions.SAS = false
        theButton:SetChecked(0)
    end
end

function Mazzifier_ButtonsNeedUpdate()
    if (Mazzifier_C_InstalledVersionDB and Mazzifier_C_InstalledVersionDB.ButtonLayout) then
        for i=1, table.getn(Mazzifier_ButtonInfo), 1 do
            if (Mazzifier_C_InstalledVersionDB.ButtonLayout.name == Mazzifier_ButtonInfo[i].devname) then
                return (Mazzifier_ButtonInfo[i].lastUpdate > Mazzifier_C_InstalledVersionDB.ButtonLayout.version)
            end
        end
    end
    return true
end

function Mazzifier_AddonsNeedUpdate()
    if (Mazzifier_C_InstalledVersionDB and Mazzifier_C_InstalledVersionDB.Addons and Mazzifier_G_InstalledVersionDB and Mazzifier_G_InstalledVersionDB.Addons) then
        for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
            if ((addonInfo.name ~= "") and (Mazzifier_InstalledVersionDB_Get(addonIndexName) < addonInfo.lastUpdate)) then
                return true
            end
        end
        return nil
    end
    return (Mazzifier_CurrentPartVersions.Addons > Mazzifier_C_InstalledVersionDB.AddonSet)
end

function Mazzifier_SetOptions_UpdateMode()
    Mazzifier_CurrentInstallOptions.updateMode = "upgrade"
    Mazzifier_CurrentInstallOptions.Buttons = (Mazzifier_ButtonsNeedUpdate() or (MazzleUI_LastAspect ~= Mazzifier_CurrentInstallOptions.Aspect))
    Mazzifier_CurrentInstallOptions.Addons = Mazzifier_AddonsNeedUpdate()
    Mazzifier_CurrentInstallOptions.Layout = ((Mazzifier_CurrentPartVersions.Layout > Mazzifier_C_InstalledVersionDB.Layout) or (MazzleUI_LastAspect ~= Mazzifier_CurrentInstallOptions.Aspect))
    Mazzifier_CurrentInstallOptions.Bindings = (Mazzifier_CurrentPartVersions.Bindings > Mazzifier_C_InstalledVersionDB.Bindings)
    Mazzifier_CurrentInstallOptions.AddonSelection = (Mazzifier_CurrentPartVersions.AddonSelection > Mazzifier_C_InstalledVersionDB.AddonSelection)
    Mazzifier_CurrentInstallOptions.AddOnList = {}
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if (addonInfo.name ~= "") then
    		Mazzifier_CurrentInstallOptions.AddOnList[addonIndexName] = (addonInfo.lastUpdate > Mazzifier_InstalledVersionDB_Get(addonIndexName))
        end
    end
    -- If a layout for this class has a version number then set the button menu to that item, otherwise set to default for that class
    Mazzifier_WelcomeFrameText:SetText(Mazzifier_UpgradeText..Mazzifier_WarnRemovedAddons())
    Mazzifier_InstantiateCurrentOptions()
end

function Mazzifier_SetOptions_Modified()
    Mazzifier_CurrentInstallOptions.updateMode = "custom"
    Mazzifier_FrameCheckButton13:SetChecked(0)
    Mazzifier_FrameCheckButton14:SetChecked(0)
    Mazzifier_FrameCheckButton15:SetChecked(1)
    Mazzifier_WelcomeFrameText:SetText(Mazzifier_UpgradeText..Mazzifier_WarnRemovedAddons())
end

function Mazzifier_SetOptions_CustomMode()
    Mazzifier_CurrentInstallOptions.updateMode = "custom"
    Mazzifier_CurrentInstallOptions.Buttons = nil
    Mazzifier_CurrentInstallOptions.Addons = nil
    Mazzifier_CurrentInstallOptions.AddonSelection = nil
    Mazzifier_CurrentInstallOptions.Layout = nil
    Mazzifier_CurrentInstallOptions.Bindings = nil
    Mazzifier_CurrentInstallOptions.AddOnList = {}
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if (addonInfo.name ~= "") then
    		Mazzifier_CurrentInstallOptions.AddOnList[addonIndexName] = nil
        end
    end
    Mazzifier_WelcomeFrameText:SetText(Mazzifier_UpgradeText..Mazzifier_WarnRemovedAddons())
    Mazzifier_InstantiateCurrentOptions()
end

function Mazzifier_SetOptions_FullMode()
    Mazzifier_CurrentInstallOptions.updateMode = "full"
    Mazzifier_CurrentInstallOptions.Buttons = 1
    Mazzifier_CurrentInstallOptions.Addons = 1
    Mazzifier_CurrentInstallOptions.Layout = 1
    Mazzifier_CurrentInstallOptions.AddonSelection = 1
    Mazzifier_CurrentInstallOptions.Bindings = 1
    Mazzifier_CurrentInstallOptions.AddOnList = {}
    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if (addonInfo.name ~= "") then
    		Mazzifier_CurrentInstallOptions.AddOnList[addonIndexName] = 1
        end
    end
    Mazzifier_WelcomeFrameText:SetText(Mazzifier_WelcomeText..Mazzifier_WarnRemovedAddons())
            
    -- If a layout for this class has a version number then set the button menu to that item, otherwise set to default for that class
    Mazzifier_InstantiateCurrentOptions()
end

function Mazzifier_InstantiateCurrentOptions()
    if (Mazzifier_CurrentInstallOptions.Addons) then Mazzifier_FrameCheckButton4:SetChecked(1) else Mazzifier_FrameCheckButton4:SetChecked(0) end
    Mazzifier_AbleAddons(Mazzifier_CurrentInstallOptions.Addons)
    if (Mazzifier_CurrentInstallOptions.Layout) then Mazzifier_FrameCheckButton5:SetChecked(1) else Mazzifier_FrameCheckButton5:SetChecked(0) end
    if (Mazzifier_CurrentInstallOptions.Buttons) then Mazzifier_FrameCheckButton6:SetChecked(1) else Mazzifier_FrameCheckButton6:SetChecked(0) end
    Mazzifier_AbleButtons(Mazzifier_CurrentInstallOptions.Buttons)
    if (Mazzifier_CurrentInstallOptions.AddonSelection) then Mazzifier_FrameCheckButton75:SetChecked(1) else Mazzifier_FrameCheckButton75:SetChecked(0) end
    if (Mazzifier_CurrentInstallOptions.Bindings) then Mazzifier_FrameCheckButton76:SetChecked(1) else Mazzifier_FrameCheckButton76:SetChecked(0) end
    if (Mazzifier_CurrentInstallOptions.SAS) then Mazzifier_FrameCheckButton74:SetChecked(1) else Mazzifier_FrameCheckButton74:SetChecked(0) end

    Mazzifier_AbleAddonSelection(Mazzifier_CurrentInstallOptions.AddonSelection)

    getglobal("Mazzifier_FrameCheckButton"..Mazzifier_CurrentInstallOptions.Aspect):SetChecked(1)
    getglobal("Mazzifier_FrameCheckButton"..(Mazzifier_CurrentInstallOptions.FontSize+7)):SetChecked(1)
    if (Mazzifier_CurrentInstallOptions.updateMode == "full") then
        Mazzifier_FrameCheckButton13:SetChecked(1)
        Mazzifier_FrameCheckButton14:SetChecked(0)
        Mazzifier_FrameCheckButton15:SetChecked(0)
    elseif (Mazzifier_CurrentInstallOptions.updateMode == "upgrade") then
        Mazzifier_FrameCheckButton13:SetChecked(0)
        Mazzifier_FrameCheckButton14:SetChecked(1)
        Mazzifier_FrameCheckButton15:SetChecked(0)
    elseif (Mazzifier_CurrentInstallOptions.updateMode == "custom") then
        Mazzifier_FrameCheckButton13:SetChecked(0)
        Mazzifier_FrameCheckButton14:SetChecked(0)
        Mazzifier_FrameCheckButton15:SetChecked(1)
    end

    for addonIndexName, addonInfo in Mazzifier_AddOnInfo do
        if (addonInfo.name ~= "") then
            if (not addonInfo.loaded) then
                Mazzifier_CurrentInstallOptions.AddOnList[addonIndexName] = nil
            end
    		getglobal("Mazzifier_FrameCheckButton"..addonInfo.index):SetChecked(Mazzifier_CurrentInstallOptions.AddOnList[addonIndexName])
        end
    end

end
