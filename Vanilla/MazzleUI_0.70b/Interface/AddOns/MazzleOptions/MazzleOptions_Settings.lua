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

function MazzleOptions_SetupOptions()
    MazzleOptions_SettingsInfo = {} 
    MazzleOptions_SettingsInfo.Contents = {} 
    
    local sections = { 
                       "MazzleOptions_Setup_Directory",
                       " MazzleUI ",
                       "MazzleOptions_Setup_AddOnManagement",
                       "MazzleOptions_Setup_Mazz3D",
                       "MazzleOptions_Setup_MazzleHUD",
                       "MazzleOptions_Setup_General",
                       "MazzleOptions_Setup_EfficiencyMode",
                       "MazzleOptions_Setup_UnitFramesManagement",
                       "MazzleOptions_Setup_Special",
                       " Main Categories ",
                       "MazzleOptions_Setup_Accessories",
                       "MazzleOptions_Setup_Assist",
                       "MazzleOptions_Setup_AH",
                       "MazzleOptions_Setup_Automation",
                       "MazzleOptions_Setup_Battlegrounds",
                       "MazzleOptions_Setup_Buttons",
                       "MazzleOptions_Setup_Character",
                       "MazzleOptions_Setup_Chat",
                       "MazzleOptions_Setup_ChatLinks",
                       "MazzleOptions_Setup_Crafting",
                       "MazzleOptions_Setup_DamageMeter",
                       "MazzleOptions_Setup_ErrorFrame",
                       "MazzleOptions_Setup_Fubar",
                       "MazzleOptions_Setup_Inspect",
                       "MazzleOptions_Setup_KeyBindings",
                       "MazzleOptions_Setup_Loot",
                       "MazzleOptions_Setup_Mail",
                       "MazzleOptions_Setup_MapAddons",
                       "MazzleOptions_Setup_Quests",
                       "MazzleOptions_Setup_Raiding",
                       "MazzleOptions_Setup_SCTAddOns",
                       "MazzleOptions_Setup_Spellbook",
                       "MazzleOptions_Setup_Talents",
                       "MazzleOptions_Setup_TimerBars",
                       "MazzleOptions_Setup_Tooltip",
                       "MazzleOptions_Setup_UnitFrames",
                       "MazzleOptions_Setup_Who",
                       " Class-Specific ",
                       "MazzleOptions_Setup_ClassHunter",
                       "MazzleOptions_Setup_ClassMage",
                       "MazzleOptions_Setup_ClassMelee",
                       "MazzleOptions_Setup_ClassWarlock",
                       " Under The Hood ",
                       "MazzleOptions_Setup_Display",
                       "MazzleOptions_Setup_Libraries",
                       "MazzleOptions_Setup_Performance",
                       "MazzleOptions_Setup_Windows",
                       }
    local setupProc
    
    for _,theSection in sections do
        setupProc = getglobal(theSection)
        if (setupProc) then setupProc() else MazzleOptions_SetupDummy(theSection) end
    end

    MazzleOptions_SettingsInfo.NumTopics = table.getn(MazzleOptions_SettingsInfo.Contents)

end

function MazzleOptions_SetupDummy(sectionName)
    local addItem, tempItem = {}, {}

    addItem.name = sectionName
    addItem.num = 0
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_CompileDirectory()
    local addItem, tempItem = {}, {}
    local addOnCount, currentTooltip
    addItem.name = "Add-On Directory"
    addItem.tooltipText = "This category contains an alphabetical list of every add-on in MazzleUI.\nYou can click any add-on in the list to take you to its options."

    tempItem = {
        type = "Notebox", notetype = "none",
        text = "You are here.",
        label = "_",
    }
    table.insert(addItem, tempItem)

    for i=1, MazzleOptions_SettingsInfo.NumTopics, 1 do
        addOnCount = 0; currentTooltip = "This category contains the following add-ons:|CFFFFFFFF";
        for _,addonInfo in MazzleOptions_SettingsInfo.Contents[i] do
            if ((type(addonInfo)=="table") and (addonInfo.type == "AddOnHeader")) then
                addOnCount = addOnCount + 1
                currentTooltip = currentTooltip.."\n   "..addOnCount.." - "..addonInfo.addonName
                tempItem = {
                    type = "TitleButton", yadjust = 5,
                    label = "|CFFFF8000"..addonInfo.addonName.."|r  ("..MazzleOptions_SettingsInfo.Contents[i].name..")",
                    topicID = i,
                    setProc = function(a,b) MazzleOptions_TopicButton_OnClick(MazzleOptions_CurrentOptions[this:GetID()].info.topicID); end}
                table.insert(addItem, tempItem)
            end
        end;
        if ((addOnCount > 0) and (not MazzleOptions_SettingsInfo.Contents[i].tooltipText)) then
            MazzleOptions_SettingsInfo.Contents[i].name = MazzleOptions_SettingsInfo.Contents[i].name.." ("..addOnCount..")"
            MazzleOptions_SettingsInfo.Contents[i].tooltipText = currentTooltip
        end
    end;
    
    table.sort(addItem, function(a,b) if (string.lower(a.label) < string.lower(b.label)) then return true; else return false; end; end)
    MazzleOptions_SettingsInfo.Contents[1] = addItem
end

function MazzleOptions_Setup_Directory()

    local addItem, tempItem = {}, {}
    addItem.name = "Add-On Directory"


    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_AddOnManagement()

    local addItem, tempItem = {}, {}
    addItem.name = "Add-On Management"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "LoadIT",
        requiredAddOn = "LoadIT",
        addonDescription = "This add-on provides you with an in-game interface to change which add-ons are loaded for a particular character.  In addition to being able to turn add-ons on and off and immediately reloading the changes, you can create add-on profiles.  For example, you could create a profile to use just when you're raiding.",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Open",
        label = "Click here to configure which add-ons are loaded",
        setProc = function() MazzleUI:ExecuteMacro("/mods menu"); MazzleOptions_Hide(); end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Mazzifier",
        requiredAddOn = "MazzleUI",
        addonDescription = "This add-on is the automatic configuration utility that sets up MazzleUI for you.  In addition to initial installation, it will automatically launch whenever you install a MazzleUI upgrade.",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Launch",
        label = "Open the MazzleUI configuration Utility",
        setProc = function() MazzleUI:ExecuteMacro("/mazzify") end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "You can use the Mazzifier to reset option settings to their original 'mazzified' settings, change button layouts, change chat window text size, reset your layout or reconfigure which add-ons are enabled.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Force Current",
        label = "Force Mazzifier think that all version information is current",
        setProc = function() MazzleUI:ExecuteMacro("/mazzify forcecurrent") end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "You can use this to make sure that the current version of the Mazzifier will not ask you to update anything in your UI.  This is not recommended unless you have a very specific reason.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "The force current option is not yet implemented.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Warm-Up",
        requiredAddOn = "!!Warmup",
        addonDescription = "Warm-Up is an add-on that displays loading time and INITIAL memory use of all of your add-ons.  It is by default disabled.  Enable this add-on to show startup times for the next restart.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Hide",
        label = "Click here to hide the Warm-Up window",
        setProc = function() MazzleUI:ExecuteMacro("/warmup"); MazzleOptions_Hide(); end
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_EfficiencyMode()
    
    local addItem, tempItem = {}, {}
    addItem.name = "|cFF006699MazzleUI|r Efficiency Modes"
    addItem.tooltipText = "This category lets you set how MazzleUI will scale back\nfunctionality to improve performance in certain situations."

    tempItem = {
        type = "Textbox", 
        text= "MazzleUI offers multiple efficiency modes that can scale back the resources that WoW uses during demanding situations.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3, 
        name = "Enable Party Efficiency Mode",
        parameter = "MazzleUI_Settings.Performance_Enabled.party",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable Raid Efficiency Mode",
        parameter = "MazzleUI_Settings.Performance_Enabled.raid",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Enable Combat Efficiency Mode",
        parameter = "MazzleUI_Settings.Performance_Enabled.combat",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Enable PvP Efficiency Mode",
        parameter = "MazzleUI_Settings.Performance_Enabled.pvp",
        setProc = function(a,b) MazzleUI:UpdateEventForSetting("PVPMode"); end,
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text= "Solo, PvP, party, raid and combat efficiency models will automatically be initiated when you're in that context.  There is also a manually-initiated mode you enter when you click on the MazzleUI efficiency mode button.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox",
        text= "Fine-tune Settings:",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", yadjust = -15, xadjust = -20, justification ="right",
        name = "Full graphics settings",
        header = "Solo    Combat    Party       Raid         PvP     Manual",
        parameter = "MazzleUI_Settings.Performance_Gfx",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "3D model animation",
        parameter = "MazzleUI_Settings.Performance_Models",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Name Plates",
        parameter = "MazzleUI_Settings.Performance_NamePlates",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Recap combat monitoring",
        parameter = "MazzleUI_Settings.Performance_Recap",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Carnival Enemy Cast Bars",
        parameter = "MazzleUI_Settings.Performance_CECB",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "BigWigs",
        parameter = "MazzleUI_Settings.Performance_BigWigs",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "FastCast latency compensation",
        parameter = "MazzleUI_Settings.Performance_FastCast",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Scrolling Combat Text",
        parameter = "MazzleUI_Settings.Performance_SCT",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Scrolling Combat Text Damage",
        parameter = "MazzleUI_Settings.Performance_SCTD",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Scrolling Combat Text Cooldowns",
        parameter = "MazzleUI_Settings.Performance_SCTC",
    }
    table.insert(addItem, tempItem)


    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "WitchHunt Spell Alerts",
        parameter = "MazzleUI_Settings.Performance_SpellAlert",
    }
    table.insert(addItem, tempItem)

--    tempItem = {
--        type = "PerformanceEntry", justification ="right",
--        name = "Combat log",
--        parameter = "MazzleUI_Settings.Performance_SCL",
--    }
--    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Show Buttons",
        parameter = "MazzleUI_Settings.Performance_Buttons",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "PerformanceEntry", justification ="right",
        name = "Normal update rate for Discord add-ons",
        parameter = "MazzleUI_Settings.Performance_Discord",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", xadjust = -250,
        text= "Manual mode trumps PvP mode.  PvP mode trumps raid mode.  Raid mode trumps party mode.  Party mode trumps combat mode.  Combat mode trumps solo mode.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", notetype = "warning",
        text= "Do not turn on extra modes or options unless you're absolutely certain you need to get the increased performance, since you will lose some functionality.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "Discord Update Rate",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", xadjust = 5,
        name = "Max update frequency for all Discord add-Ons:",
        minValue = 1,
        maxValue = 30,
        stepValue = 1,
        units = " upd/sec",
        parameter = "MazzleUI_Settings.DiscordUpdate",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider",
        name = "Reduced update frequency for all Discord add-Ons:",
        minValue = 1,
        maxValue = 30,
        stepValue = 1,
        units = " upd/sec",
        parameter = "MazzleUI_Settings.Performance_DiscordUpdate",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

--    tempItem = {
--        type = "Textbox",  xadjust = -5, yadjust = -20,
--        text = "Scrolling Combat Text Efficiency",
--    }
--    table.insert(addItem, tempItem)
--
--    tempItem = {
--        type = "YesNo", yadjust = -10,
--        question = "When turning down Scrolling Combat Text, use:",
--        noText = "Turn SCT completely off",
--        yesText = "Put SCT in light mode",
--        parameter = "MazzleUI_Settings.Performance_LightSCT",
--    }
--    table.insert(addItem, tempItem)
--
--    tempItem = {
--        type = "YesNo", yadjust = -10,
--        question = "When turning down Scrolling Combat Text Damage, use:",
--        noText = "Turn all floating damage completely off",
--        yesText = "Use Blizzard Floating Damage",
--        parameter = "MazzleUI_Settings.Performance_BlizzardSCTD",
--    }
--    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox",  xadjust = -5, yadjust = -10,
        text = "Name Setting Full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Own Name",
        parameter = "MazzleUI_Settings.Performance_Names.High.Own",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton",
        name = "Friendly Player Names",
        parameter = "MazzleUI_Settings.Performance_Names.High.Name",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton", 
        name = "Friendly Player Nameplate",
        parameter = "MazzleUI_Settings.Performance_Names.High.NamePlate",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton", 
        name = "Guild",
        parameter = "MazzleUI_Settings.Performance_Names.High.Guild",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton", 
        name = "PvP Title",
        parameter = "MazzleUI_Settings.Performance_Names.High.Title",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton",
        name = "NPC and Enemy Names",
        parameter = "MazzleUI_Settings.Performance_Names.High.NPCName",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton",
        name = "NPC and Enemy Nameplates",
        parameter = "MazzleUI_Settings.Performance_Names.High.NPCNamePlate",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox",  xadjust = -5, yadjust = -10,
        text = "Name Setting Reduced",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Own Name",
        parameter = "MazzleUI_Settings.Performance_Names.Low.Own",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton",
        name = "Friendly Player Names",
        parameter = "MazzleUI_Settings.Performance_Names.Low.Name",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton", 
        name = "Friendly Player Nameplate",
        parameter = "MazzleUI_Settings.Performance_Names.Low.NamePlate",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton", 
        name = "Guild",
        parameter = "MazzleUI_Settings.Performance_Names.Low.Guild",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton", 
        name = "PvP Title",
        parameter = "MazzleUI_Settings.Performance_Names.Low.Title",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton",
        name = "NPC and Enemy Names",
        parameter = "MazzleUI_Settings.Performance_Names.Low.NPCName",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)
    tempItem = {
        type = "CheckButton",
        name = "NPC and Enemy Nameplates",
        parameter = "MazzleUI_Settings.Performance_Names.Low.NPCNamePlate",
        setProc = function() MazzleUI:InstantiateEfficiencyMode(true); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", notetype = "warning", yadjust = -16, 
        text= "Guild and pvp rank tags do not show up when name tags are not on.  Also, most name tag information does not show up when name plates are on.",
        width = "full",
    }
    table.insert(addItem, tempItem)
    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Special()

    local addItem, tempItem = {}, {}
    addItem.name = "|cFF006699MazzleUI|r Special Settings"
    addItem.tooltipText = "This category contains a few special purpose options such as bug\nworkarounds and tools for submitting button layouts to Mazzlefizz."


    tempItem = {
        type = "Textbox", 
        text = "Quick Bug Workarounds",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Restore Chat Windows",
        label = "",
        setProc = function() MazzleOptions_RestoreChatFrames() end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "Due to a Blizzard bug, detached chat windows, in this case the MazzleUI combat log windows, can disappear for some people.  If this happens to you, click this button to restore them.  If ALL of your chat windows disappear, try typing '/dfm'.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "Submitting Your Button Layouts",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Simple Action Sets",
        requiredAddOn = "SimpleActionSets",
        addonDescription = "Simple Action Sets is an add-on that allows you to save and restore which spells and actions are placed in which buttons.  You can use this to save your button placement if you want to try out another button layout.  You can also use this if you want to submit a button layout for a future version of MazzleUI.",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 10,
        name = "Open SAS",
        label = "Click to open this add-on",
        setProc = function() if (IsAddOnLoaded"SimpleActionSets") then MazzleUI:ExecuteMacro("/sas") else ace:print("MazzleUI: First enable add-on before trying to open it") end; end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "This add-on is not routinely used and is, by default, disabled.  Moreover, MazzleUI will automatically disable it after you're done using it.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Mazz3D()

    local addItem, tempItem = {}, {}
    addItem.name = "|cFF006699Mazz3D|r Characters"
    addItem.tooltipText = "This category lets you configure MazzleUI's animated 3d models."

    tempItem = {
        type = "Textbox", 
        text = "Mazzlefizz's Mazz3D Characters Settings",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want the 3D characters to do a random emote animation every now and then?",
        parameter = "MazzleUI_Settings.Mazz3D.randomAnims",
        setProc = function () if (MazzleUI_Settings.Mazz3D.randomAnims) then Mazz3D:StartRandomAnims() else Mazz3D:StopRandomAnims(); end; end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want the 3d characters to do event-based animation?",
        parameter = "MazzleUI_Settings.Mazz3D.eventAnims",
        setProc = function () if (MazzleUI_Settings.Mazz3D.eventAnims) then Mazz3D:RegisterAnimEvents(); else Mazz3D:UnregisterAnimEvents(); end; end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "Event-based animations include flinching when hit, roaring when resurrected and falling when dead.  Emote animations are the ones that occur when you do things like /rude.  You can also initiate emote animations by right-clicking on the middle of the 3D model.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to be able to rotate and adjust 3d characters?",
        parameter = "MazzleUI_Settings.Mazz3D.adjustModels",
        setProc = function () if (MazzleUI_Settings.Mazz3D.adjustModels) then Mazz3D:RegisterAdjustEvents(); else Mazz3D:UnregisterAdjustEvents(); end; end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox",
        text = "Debug Options",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Enable Debug messages?",
        parameter = "MazzleUI_Settings.Mazz3D.debugCamera",
    }
    table.insert(addItem, tempItem)


    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_General()

    local addItem, tempItem = {}, {}
    addItem.name = "|cFF006699MazzleUI|r General Settings"
    addItem.tooltipText = "This category contains general MazzleUI settings."

    tempItem = {
        type = "Textbox", 
        text = "Automation",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to automatically accept resurrections?",
        parameter = "MazzleUI_Settings.AutoRes",
        setProc = function(a,b) MazzleUI:UpdateEventForSetting("AutoRes"); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to automatically accept summons from Warlocks?",
        parameter = "MazzleUI_Settings.AutoSummon",
        setProc = function(a,b) MazzleUI:UpdateEventForSetting("AutoSummon"); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to automatically unmount when you speak to Flightmaster?",
        parameter = "MazzleUI_Settings.AutoDismount",
        setProc = function(a,b) MazzleUI:UpdateEventForSetting("AutoDismount"); end,
    }
    table.insert(addItem, tempItem)


    tempItem = {
        type = "Textbox", 
        text = "Context Menu",  xadjust = -15,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to hide the context menu when you first log in?",
        parameter = "MazzleUI_Settings.HideContext",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to hide the context menu when you use an item in it?",
        parameter = "MazzleUI_Settings.HideContextOnClick",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to move the context menu to your mouse when opened?",
        parameter = "MazzleUI_Settings.MoveContext",
    }
    table.insert(addItem, tempItem)

   tempItem = {
        type = "Textbox", 
        text = "Hotspot Shortcuts",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Enable KC Item Loot Database Hotspot (bottom left corner)",
        parameter = "MazzleUI_Settings.HotSpots.KCI",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable MonkeyQuest Hotspot (top left corner)",
        parameter = "MazzleUI_Settings.HotSpots.MonkeyQuest",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable TinyPad Hotspot (middle left)",
        parameter = "MazzleUI_Settings.HotSpots.Notebook",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable Context Menu Hotspot (middle right)",
        parameter = "MazzleUI_Settings.HotSpots.NeedyList",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable ItemRack Hotspot (top right corner)",
        parameter = "MazzleUI_Settings.HotSpots.ItemRack",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable xCalc Hotspot (bottom right)",
        parameter = "MazzleUI_Settings.HotSpots.xCalc",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable AlphaMap Hotspot (minimap coordinates)",
        parameter = "MazzleUI_Settings.HotSpots.Compass",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Enable Target of Target Hotspot (under target box)",
        parameter = "MazzleUI_Settings.HotSpots.ToT",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "Hotspots are hidden areas in the bottom MazzleUI panel that you can click to open up commonly used add-ons.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "Raid Utility Auto-Hiding",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to auto-hide oRA's resurrection monitor when not on a healer?",
        parameter = "MazzleUI_Settings.AutohideRezMonitor",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to auto-show oRA's resurrection monitor when you're dead?",
        parameter = "MazzleUI_Settings.AutoshowRezMonitor",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Never show resurrection monitor or XRaidStatus when pvp-flagged?",
        parameter = "MazzleUI_Settings.HotSpots.hideResurrectionXRSPvP",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", xadjust = 15,
        text = "The three options above are not yet implemented.",
        width = "full",
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_MazzleHUD()
    local addItem = {}
    addItem.name = "|cFF006699MazzleHUD|r Settings"
    addItem.tooltipText = "This category lets you configure MazzleUI's heads-up display."

    tempItem = {
        type = "Textbox", 
        text = "MazzleHUD",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to use the HUD?",
        parameter = "MazzleUI_Settings.HUD.UseHUD",
        setProc = function() MazzleUI:InstantiateHUDSettings() end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "Transparency:",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider",
        name = "Hud Transparency in Combat:",
        minValue = 0,
        stepValue = .01,
        maxValue = 0.9,
        units = " visibility",
        parameter = "MazzleUI_Settings.HUD.Transparency_IC",
        setProc = function() MazzleOptions_HudTransparency() end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Hud Transparency Out of Combat:",
        minValue = 0,
        stepValue = .01,
        maxValue = 0.9,
        units = " visibility",
        parameter = "MazzleUI_Settings.HUD.Transparency_OOC",
        setProc = function() MazzleOptions_HudTransparency() end
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Target of Target Transparency:",
        minValue = 0,
        stepValue = .01,
        maxValue = 1,
        units = " visibility",
        parameter = "MazzleUI_Settings.HUD.Transparency_ToT",
        setProc = function() MazzleOptions_HudTransparency() end
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_UnitFramesManagement()
    local addItem = {}
    addItem.name = "|cFF006699MazzleUI|r Unit Frame Settings"
    addItem.tooltipText = "This category lets you configure how\nyour party and raid frames are laid out."

    tempItem = {
        type = "Textbox", 
        text = "Unit Frame Display",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3, 
        name = "SHOW your party members when in a raid and there's room for them?",
        parameter = "MazzleUI_Settings.ShowRaidParty",
        setProc = MazzleOptions_Set_RefreshRaidView,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3, 
        name = "HIDE your party members' pets?",
        setProc = function(a,b) MazzleOptions_Set_DUFPartyPets(b); MazzleOptions_Set_RefreshRaidView(); end,
        readOnlyParameter = function() MazzleOptions_Get_DUFPartyPets(); end,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "MazzleUI Hot-Swappable Layouts",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Allow MazzleUI to move your raid frames?",
        parameter = "MazzleUI_Settings.manageRaidFrames",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Enable Right-Clicking on MazzleUI logo to cycle through layouts?",
        parameter = "MazzleUI_Settings.HotSpots.RaidCycle",
    }
    table.insert(addItem, tempItem)


    tempItem = {
        type = "CheckButton", yadjust = -3, 
        name = "Adjust raid frame layout to be better distributed when in a 20-man raid?",
        parameter = "MazzleUI_Settings.AutoSwapRaid20",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Textbox",
        text = "Favorite View",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        width = 90,
        name = "Raid Frame Position", xadjust = -15,
        parameter = "MazzleUI_Settings.FaveRaidPosition",
        menuItems = {"Bottom",
                     "Top",
                     "None",},
        setProc = MazzleOptions_Set_RefreshRaidView,
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        width = 310,
        name = "MT Window Position",
        menuItems = {"Side with MT and MT's target",
                     "Top with MT and MT's target",
                     "Top with MT and MT's target and MT's ToT (wide)"},
        parameter = "MazzleUI_Settings.FaveMTPosition",
        setProc = MazzleOptions_Set_RefreshRaidView,
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end
