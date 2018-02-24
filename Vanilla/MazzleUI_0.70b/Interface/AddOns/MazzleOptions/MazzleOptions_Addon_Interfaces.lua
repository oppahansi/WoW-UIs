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

function MazzleOptions_DAB_IsLocked()
	for bar=1,10 do
		if (not DAB_Settings[DAB_INDEX].Bar[bar].buttonsLocked) then
			return false;
		end
	end
	for floater in DAB_Settings[DAB_INDEX].Floaters do
		if (not DAB_Settings[DAB_INDEX].Floaters[floater].buttonLocked) then
			return false;
		end
	end
	return true;
end

function MazzleOptions_DAB_Lock(widgetID, lockVal)
	for bar=1,10 do
    	DAB_Settings[DAB_INDEX].Bar[bar].buttonsLocked = lockVal;
	end
	for floater in DAB_Settings[DAB_INDEX].Floaters do
		DAB_Settings[DAB_INDEX].Floaters[floater].buttonLocked = lockVal;
	end
end

function MazzleOptions_HudTransparency()
    if (MazzleUI_Settings.HUD.Transparency_IC == 0) then
        MazzleUI_Settings.HUD.Transparency_FG_IC = 0
    else
        MazzleUI_Settings.HUD.Transparency_FG_IC = MazzleUI_Settings.HUD.Transparency_IC + 0.4
    end
    if (MazzleUI_Settings.HUD.Transparency_OOC == 0) then
        MazzleUI_Settings.HUD.Transparency_FG_OOC = 0
    else
        MazzleUI_Settings.HUD.Transparency_FG_OOC = MazzleUI_Settings.HUD.Transparency_OOC + 0.4
    end
    if (MazzleUI_Settings.HUD.Transparency_FG_IC >= 1) then
        MazzleUI_Settings.HUD.Transparency_FG_IC = 0.99
    end
    if (MazzleUI_Settings.HUD.Transparency_FG_OOC >= 1) then
        MazzleUI_Settings.HUD.Transparency_FG_OOC = 0.99
    end
    
    MazzleUI:InstantiateHUDSettings()
end

function MazzleOption_CBRead_Rev_1_nil(varValue)
    if (varValue) then return nil else return 1 end
end

function MazzleOptions_CBSet_Rev_1_nil(widgetID, widgetValue)
    --ace:print("Checkbutton write: ", " = ", widgetValue)
    if (widgetValue) then
        MazzleUI_SetValue(MazzleOptions_CurrentOptions[widgetID].info.readOnlyParameter, nil)
    else
        MazzleUI_SetValue(MazzleOptions_CurrentOptions[widgetID].info.readOnlyParameter, 1)
    end
end

function MazzleOptions_OpenSCLMenu( widgetID, widgetValue, whichMenu)
    SimpleCombatLog:LoadSettingMenu_Mazzle(whichMenu, MazzleOptions_CurrentOptions[widgetID].widget.frame)
end
    
function MazzleOptions_GetAutorankModifier()
    
    local selfKey = AutoRank_GetAltKey()
    if (selfKey == "none") then return 4;
    elseif (selfKey == "alt") then return 1;
    elseif (selfKey == "ctrl") then return 2;
    elseif (selfKey == "shift") then return 3; end

end

function MazzleOptions_SetAutorankModifier(widgetID, widgetValue)
    if (widgetValue == 4) then
        MazzleUI:ExecuteMacro("/autorank self none");
    elseif (widgetValue == 1) then
        MazzleUI:ExecuteMacro("/autorank self alt");
    elseif (widgetValue == 2) then
        MazzleUI:ExecuteMacro("/autorank self ctrl");
    elseif (widgetValue == 3) then
        MazzleUI:ExecuteMacro("/autorank self shift");
    end
end

function MazzleOptions_SASct_GetStyleNum()
    if (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "message") then
        return 1
    elseif (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "vertical") then
        return 2
    elseif (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "rainbow") then
        return 3
    elseif (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "horizontal") then
        return 4
    elseif (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "angled down") then
        return 5
    elseif (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "angled up") then
        return 6
    elseif (SpellAlertSCTDB[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].Style == "sprinkler") then
        return 7
    else
        return nil
    end
end

function MazzleOptions_SASct_GetStyleName(menuNum)
    if (menuNum == 1) then return "message";
    elseif (menuNum == 2) then return "vertical";
    elseif (menuNum == 3) then return "rainbow";
    elseif (menuNum == 4) then return "horizontal";
    elseif (menuNum == 5) then return "angled down";
    elseif (menuNum == 6) then return "angled up";
    elseif (menuNum == 7) then return "sprinkler"; end
end

function MazzleOptions_SASct_PrintIgnoreList()
    if (SpellAlertSCTDB["SpellIgnoreList"]) then
        ace:print(TEXT("|CFF00FF00Spell Alert SCT|CFFFFFFFF is currently ignoring the following spells: "))
        for theSpell,_ in SpellAlertSCTDB["SpellIgnoreList"] do
            ace:print(" -> ", theSpell)
        end
    end
end

function MazzleOptions_Get_sRaid(varType)
    if (varType == "health") then
        local varValue = MazzleUI_GetValue("sRaidFramesDB.profiles.default.healthDisplayType")
        if (varValue == "percent") then return 1;
        elseif (varValue == "deficit") then return 2;
        elseif (varValue == "current") then return 3; end
    elseif (varType == "texture") then
        local varValue = MazzleUI_GetValue("sRaidFramesDB.profiles.default.texture")
        if (varValue == "Blizzard") then return 1;
        elseif (varValue == "Default") then return 2;
        elseif (varValue == "Smooth") then return 3;
        elseif (varValue == "Striped") then return 4; end
    elseif (varType == "sort") then
        local varValue = MazzleUI_GetValue("sRaidFramesDB.profiles.default.SortBy")
        if (varValue == "class") then return 1;
        elseif (varValue == "group") then return 2; end
    elseif (varType == "bufftype") then
        local varValue = MazzleUI_GetValue("sRaidFramesDB.profiles.default.BuffType")
        if (varValue == "buffs") then return 1;
        elseif (varValue == "debuffs") then return 2; end
    elseif (varType == "layout") then
        if (MazzleUI_LastAspect == "1") then return 5; else return 4; end
    end
end

function MazzleOptions_Set_sRaid(varType, varValue)
    if (varType == "health") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/sRaidFrames health percent");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/sRaidFrames health deficit");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/sRaidFrames health current"); end
    elseif (varType == "texture") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/sRaidFrames texture Blizzard");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/sRaidFrames texture Default");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/sRaidFrames texture Smooth");
        elseif (varValue == 4) then MazzleUI:ExecuteMacro("/sRaidFrames texture Striped"); end
    elseif (varType == "sort") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/sRaidFrames sort class");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/sRaidFrames sort group"); end
    elseif (varType == "bufftype") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/sRaidFrames bufftype buffs");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/sRaidFrames bufftype debuffs"); end
    elseif (varType == "layout") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/sRaidFrames layout vertical");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/sRaidFrames layout horizontal");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/sRaidFrames layout ctra");
        elseif (varValue == 4) then MazzleUI:ExecuteMacro("/sRaidFrames layout mazzle");
        elseif (varValue == 5) then MazzleUI:ExecuteMacro("/sRaidFrames layout mazzle125"); end
    end
end

function MazzleOptions_Get_oRA_MTF(varType)
    if (varType == "style") then
        local varValue = MazzleUI_GetValue("oRAMainTankFrames.profiles.default.style")
        if (varValue == "ctra") then return 1;
        elseif (varValue == "dire") then return 2;
        elseif (varValue == "praid") then return 3;
        elseif (varValue == "elysium") then return 4; end
    elseif (varType == "texture") then
        local varValue = MazzleUI_GetValue("oRAMainTankFrames.profiles.default.bartexture")
        if (varValue == "default") then return 1;
        elseif (varValue == "otravi") then return 2;
        elseif (varValue == "perl") then return 3;
        elseif (varValue == "smooth") then return 4;
        elseif (varValue == "striped") then return 5; end
    end
end

function MazzleOptions_Set_oRA_MTF(varType, varValue)
    if (varType == "style") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/ora maintankframes style ctra");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/ora maintankframes style dire");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/ora maintankframes style praid");
        elseif (varValue == 4) then MazzleUI:ExecuteMacro("/ora maintankframes style elysium"); end
    elseif (varType == "texture") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/ora maintankframes bartexture default");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/ora maintankframes bartexture otravi");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/ora maintankframes bartexture perl");
        elseif (varValue == 4) then MazzleUI:ExecuteMacro("/ora maintankframes bartexture smooth");
        elseif (varValue == 5) then MazzleUI:ExecuteMacro("/ora maintankframes bartexture striped"); end
    end
end

function MazzleOptions_Get_oRA_RS(varType)
    if (varType == "fontsize") then
        local varValue = MazzleUI_GetValue("oRARaidSay.profiles.default.FontSize")
        if (varValue == "small") then return 1;
        elseif (varValue == "normal") then return 2;
        elseif (varValue == "large") then return 3;
        else return 4; end
    end
end

function MazzleOptions_Set_oRA_RS(varType, varValue)
    if (varType == "fontsize") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/ora rs fontsize small");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/ora rs fontsize normal");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/ora rs fontsize large");
        elseif (varValue == 4) then MazzleUI:ExecuteMacro("/ora rs fontsize huge"); end
    end
end

function MazzleOptions_Get_MazzleMage(varType)
    local varValue = MazzleUI_GetValue("MazzleMage_Settings.spell_"..varType)
    if (varValue == "Frostbolt") then return 1;
    elseif (varValue == "Fireball") then return 2;
    elseif (varValue == "Pyroblast") then return 3; end
end

function MazzleOptions_Set_MazzleMage(varType, varValue)
    if (varValue == 1) then MazzleUI_SetValue("MazzleMage_Settings.spell_"..varType, "Frostbolt")
    elseif (varValue == 2) then MazzleUI_SetValue("MazzleMage_Settings.spell_"..varType, "Fireball")
    elseif (varValue == 3) then MazzleUI_SetValue("MazzleMage_Settings.spell_"..varType, "Pyroblast"); end
end

function MazzleOptions_Set_RefreshRaidView()
    if (MazzleUI_Settings.manageRaidFrames) then
        MazzleUI:RaidViewSet()
    end
end

function MazzleOptions_RestoreChatFrames()
    ChatFrame6:Show()
    ChatFrame7:Show()
end

function MazzleOptions_Get_PartySpotter(varType)
    if (varType == "groups") then
        local varValue = MazzleUI_GetValue("PartySpotterSettings.showGroups")
        if (varValue == "Icons") then return 1;
        elseif (varValue == "Numbers") then return 2;
        elseif (varValue == "Nil") then return 3; end
    elseif (varType == "highlight") then
        local varValue = MazzleUI_GetValue("PartySpotterSettings.showFriends")
        if (varValue == "1") then return 1; end
        varValue = MazzleUI_GetValue("PartySpotterSettings.showGuild")
        if (varValue == "1") then return 2; end
        return 3;
    end
end

function MazzleOptions_Set_PartySpotter(varType, varValue)
    if (varType == "groups") then
        if (varValue == 1) then MazzleUI:ExecuteMacro("/pspot showgroups icons");
        elseif (varValue == 2) then MazzleUI:ExecuteMacro("/pspot showgroups numbers");
        elseif (varValue == 3) then MazzleUI:ExecuteMacro("/pspot showgroups off"); end
    elseif (varType == "highlight") then
        MazzleUI_SetValue("PartySpotterSettings.showFriends", nil)
        MazzleUI_SetValue("PartySpotterSettings.showGuild", nil)
        MazzleUI_SetValue("PartySpotterSettings.showIgnores", nil)
        if (varValue == 1) then MazzleUI_SetValue("PartySpotterSettings.showFriends", "1")
        elseif (varValue == 2) then MazzleUI_SetValue("PartySpotterSettings.showGuild", "1");
        elseif (varValue == 3) then MazzleUI_SetValue("PartySpotterSettings.showIgnores", "1"); end
        PartySpotter_ConfigChange();
    end
end

function MazzleOptions_Get_DUFPartyPets()
    return DUF_Settings[DUF_INDEX].partypet.hide
end

function MazzleOptions_Set_DUFPartyPets(shouldHide)
    ace:print("Setting pets to ", shouldHide)
    DUF_Settings[DUF_INDEX].partypet.hide = shouldHide
    DUF_Main_UpdatePartyMembers()
end
