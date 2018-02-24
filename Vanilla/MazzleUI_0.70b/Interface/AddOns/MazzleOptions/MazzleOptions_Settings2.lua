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

function MazzleOptions_Setup_Automation()

    local addItem, tempItem = {}, {}
    addItem.name = "Automation"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AQ Automount",
        requiredAddOn = "AQAutoMount",
        addonDescription = "When in the confines of Ahn'Qiraj, this add-on will automatically substitute your bug mount whenever you attempt to use a normal mount.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure Ahn'Qiraj Automount",
        setProc = function() MazzleUI:ExecuteMacro("/aqmount"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AutoAcceptInvite",
        requiredAddOn = "AutoAcceptInvite",
        addonDescription = "This Ace2 add-on made by our very own Tigerheart allows your character to automatically accept invites from people on an 'accept list' and automatically reject invites from those on your 'reject' list.  You can also tell it to automatically accept invites from all friends or guild memebers.  You can access the options for this add-on via the DeuceCommander entry in FuBar.  It is under the Raid category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Cirk's AutoRank",
        requiredAddOn = "Autorank",
        addonDescription = "This add-on will adjust the rank of a spell downwards so that it will work with the level of your target.  It also has options to do a few other spellcasting modification such as self-casting.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        name = "Self Cast Key", xadjust = -18,
        menuItems = {"alt",
                     "ctrl",
                     "shift",
                     "none",},
        width = 75,
        readProc = MazzleOptions_GetAutorankModifier,
        setProc = MazzleOptions_SetAutorankModifier,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5, xadjust = 18,
        name = "Options",
        label = "Click here to list all spells that Autorank knows",
        setProc = function() MazzleUI:ExecuteMacro("/autorank list"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Detox",
        requiredAddOn = "Detox",
        addonDescription = "This Ace2 add-on allows you to quickly removes curses, poisons and other debuffs from friendly units.  You can prioritize units to determine what order debuffs are cleared.  By default, Control-D is used to clean a unit using Detox.  You can access the options for this add-on via the Detox entry in FuBar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Finder Reminder",
        requiredAddOn = "FinderReminder",
        addonDescription = "This add-on presents you with a reminder window if you don't have a tracking skill active.  You can even select a tracking skill to turn on from the reminder window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Hide reminders when pvp'ing in battlegrounds?",
        parameter = "FinderReminderDB.profiles.default.hideInBG",}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Performance()

    local addItem, tempItem = {}, {}
    addItem.name = "UI Performance"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "ClearBlizzard",
        requiredAddOn = "clearBlizzard",
        addonDescription = "This is a very small add-on that unregisters the self, party and target frames for a small increase in performance.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Cirk's FastCast",
        requiredAddOn = "Fastcast",
        addonDescription = "This add-on can compensate for the lag that can occur between spell casts in high latency situations.  It does this by cancelling the old spell cast and immediately starting another one.  Due to the high latency, the cancellation does not get there in time and you're able to start the next spell far more quickly.  Do not use in normal latency situation, since it will cause unexpected cancellations instead and offer no benefits.  This add-on also provides channeling protection, so that you don't accidentally cancel channeled spells such as arcane missiles when spamming the same key.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure FastCast",
        setProc = function() MazzleUI:ExecuteMacro("/fastcast"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "You can quickly turn on the latency compensation features of this add-on by clicking on the FastCast button in the left portion of the MazzleUI panel.  You can also set the various MazzleUI Efficiency modes to automatically turn it on and off.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "FixMe",
        requiredAddOn = "FixMe",
        addonDescription = "This add-on provides a few miscellaneous fixes to the Blizzard UI.  It will automatically disable itself when WoW is patched.  Currently, it (1) throttles invalid cooldown checks on items in default bags, (2) makes sure that the BattlefieldMinimap always shows if you have it enabled (sometimes it will disappear inexplicitably), and (3) shows ChatFrame1 on login if you have ChatFrames enabled (sometimes it will focus on a random tab instead of the first).",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "GFX Toggle",
        requiredAddOn = "gfxToggle",
        addonDescription = "GFX Toggle allows you to quickly switch between various video settings.  It is used by the various MazzleUI efficiency modes to tone down or improve the graphics as per the MazzleUI performance settings.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Save Low",
        label = "Click to save the CURRENT video settings as the Low setting.",
        setProc = function() MazzleUI:ExecuteMacro("/gfxt save low");  end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Save Medium",
        label = "Click to save the CURRENT video settings as the Medium setting.",
        setProc = function() MazzleUI:ExecuteMacro("/gfxt save medium");  end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Save High",
        label = "Click to save the CURRENT video settings as the High setting.",
        setProc = function() MazzleUI:ExecuteMacro("/gfxt save high"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Toggle",
        label = "Click to switch between the current setting low and high.",
        setProc = function() MazzleUI:ExecuteMacro("/gfxt toggle"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 5,
        text = "MazzleUI efficiency modes use the low and high gfxt settings to change graphics.  It does not use the medium settings",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 10,
        text = "GFX Toggle also has options to automatically switch settings based on the zone you're in.  Type /gfxt to access more options.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_UnitFrames()

    local addItem, tempItem = {}, {}
    addItem.name = "Unit Frames"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Unit Frames",
        requiredAddOn = "DiscordUnitFrames",
        addonDescription = "This add-on displays the unit frames for yourself, your target, your pets, your party members and their pets.  It does not handle raid frames.  It is a complex add-on that most users will not need to modify.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 0,
        name = "Discord Unit Frames",
        label = "Click to open options window for Discord Unit Frames.",
        setProc = function() MazzleUI:ExecuteMacro("/duf"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Mob Health 3",
        requiredAddOn = "MobHealth",
        addonDescription = "This add-on allows you to display actual health values for your targetted mob.  It can both maintain a database of these values as well as calculate the values on the fly.  You can configure this add-on via the Deucecommander menu in your Fubar.  It is under the Combat category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 5,
        text = "When configuring the settings remember that estimation precision is a measure of how the add-on balances accuracy vs quick display of a health estimate.  MobHealth3 uses a number between 1 and 99 to determine the trade-off. This number is how many percent a mob's health needs to to change before we will trust the estimated maximum health and display it. The lower this value is, the quicker you'll see a value and the less accurate it will be. Raiding players may want to turn this down a bit. If you don't care about accuracy and want info ASAP, set this to 1.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 10,
        text = "When turned on, the max HP only updates once your target changes. If data for the target is unknown, MH3 will update once during the battle when the precision percentage is reached.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_ErrorFrame()

    local addItem, tempItem = {}, {}
    addItem.name = "Error Window"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Improved Error Frame",
        requiredAddOn = "!ImprovedErrorFrame",
        addonDescription = "Improved Error Frame intercepts all error messages and queues them for your later perusal.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Notify when errors occur?",
        parameter = "ImprovedErrorSettings.displayOnError",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Blink error button when errors are pending?",
        parameter = "ImprovedErrorSettings.blinkNotification",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Display count of errors on button?",
        parameter = "ImprovedErrorSettings.displayCount",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Always show error button?",
        parameter = "ImprovedErrorSettings.alwaysShow",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Do not play sound when an error occurs?",
        parameter = "ImprovedErrorSettings.gagNoise",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Hide button graphic when blinking?",
        parameter = "ImprovedErrorSettings.emptyButton",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Enable verbose FrameXML logging? (only for developers)",
        parameter = "ImprovedErrorSettings.XMLDebug",}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Display()

    local addItem, tempItem = {}, {}
    addItem.name = "Display"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "ClearFont",
        requiredAddOn = "!ClearFont",
        addonDescription = "Clearfont replaces most of the fonts in the UI with a much more legible font.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "CT Viewport",
        requiredAddOn = "CT_Viewport",
        addonDescription = "CT Viewport is an add-on that lets you modify the size of the rendered part of the screen.  The Mazzifier should already set this up for you.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 10,
        name = "Options",
        label = "Click to configure your viewport",
        setProc = function() ShowUIPanel(CT_ViewportFrame); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Art",
        requiredAddOn = "DiscordArt",
        addonDescription = "Discord Art is used to display textures and handle related events suchs as clicks, mouse-overs, etc.  MazzleUI currently uses it to display the bottom panel art, changes the borders of various frames, display the HUD and handle the various hidden HotSpots.  You should not have to alter the settings of this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 10,
        name = "DART",
        label = "Click to open options window for Discord Art.",
        setProc = function() MazzleUI:ExecuteMacro("/dart"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Buttons()

    local addItem, tempItem = {}, {}
    addItem.name = "Buttons and Clicking"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AutoBar",
        requiredAddOn = "AutoBar",
        addonDescription = "This add-on provides a bar of buttons that auto-load with items that can replenish you in some way.  For example, one item is for mana consumables which will automatically be stacked with mana gems, mana pots, etc. that change dynamically based on a priority list and what is on cooldown.  You can create up to 18 categories and order the items in any way you please.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to open the Autobar options window",
        setProc = function() MazzleUI:ExecuteMacro("/autobar"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Book of Tracks",
        requiredAddOn = "BookOfTracks",
        addonDescription = "If your character knows at least one tracking skill (resources tracking, hunter skill or demonist senses), this add-on provides a small button next to your minimap to access all those skills. There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Clique",
        requiredAddOn = "Clique",
        addonDescription = "This add-on allows you to click on unit and raid frames to cast any spells on the unit or yourself.  This can be used for both offensive and defensive spells.  This add-on also works on the unit frames of certain other add-ons like NeedyList.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "Configuring click-casting is very simple.  First, open up the default blizzard spellbook (left-click on the MazzleUI text on the left side of the screen and click on the spellbook.)  Then click on the Clique tab, which is the bottom tab past your other spell schools.  You can follow the directions presented by Clique at that point.",
}
    table.insert(addItem, tempItem)


    tempItem = {
        type = "Notebox", 
        text = "Click-casting can prevent you from accessing the party menu you get when right-click on yourself or a party member if you bind the right mouse button.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Action Bars",
        requiredAddOn = "DiscordActionBars",
        addonDescription = "This add-on manages all of your button bars.  It's extremely powerful and offers a myriad of configuration options.  It is highly suggested you spend some time to learn this add-on well so you can personalize and configure your buttons.  See the help system for more information about DAB.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Discord Action Bars",
        label = "Click to open options window for Discord Action Bars.",
        setProc = function() MazzleUI:ExecuteMacro("/dab"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "The original Blizzard lock bars option will not work on Discord Action Bars.  You must use the following checkbox to lock your buttons.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -10,
        name = "Lock all buttons.  (So you can't drag actions off of them.)",
        readProc = function() return MazzleOptions_DAB_IsLocked() end,
        setProc = MazzleOptions_DAB_Lock}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Gello's ItemRack",
        requiredAddOn = "ItemRack",
        addonDescription = "This extremely powerful add-on makes swapping equipment easier. One thing it does is provides a bar with one button for each item slot.  Mouseover the bar to access a menu of all items in your bags that can go in that slot. In addition, it provides extremely powerful set management.  Create an arbitrary number of sets or partial sets of equipment and swap them in with one click on the the ItemRack Fubar module (right side of Fubar.)  You can also automatically swap in equipment sets when certain events happen such as being mounted, startin evocation, etc.  This is an extremely powerful and polished add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Item Rack",
        label = "Click here to configure your ItemRack sets, events and options",
        setProc = function() ItemRack_Sets_Toggle(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Fubar ItemRackFu",
        requiredAddOn = "ItemRackFu",
        addonDescription = "This add-on provides a Fubar menu for the extremely powerful add-on, ItemRack, which makes swapping equipment easier. If you create sets of equipment, you can click on this Fubar entry to access a menu of those sets that you then put on in one click.  Right-clck to access to ItemRack options window to create and modify sets.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Gello's TrinketMenu",
        requiredAddOn = "TrinketMenu",
        addonDescription = "This is a mod to make swapping trinkets easier. It will display your two equipped trinkets in a bar. Mouseover on either trinket will display a menu of up to 30 trinkets in your bags to swap.  In addition, uou can also create a priority list of trinkets to automatically swap in as their cooldowns become available.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Show/Hide",
        label = "Click here to toggle your trinket menu visibility",
        setProc = function() MazzleUI:ExecuteMacro("/trinketmenu"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 0,
        name = "Options",
        label = "Click here to configure your options and trinket priority list",
        setProc = function() MazzleUI:ExecuteMacro("/trinketmenu opt"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "NeedyList",
        requiredAddOn = "NeedyList",
        addonDescription = "This is an extremely powerful add-on that provides a dynamic list of units that have a *need* that you can fulfill.  To learn more about this add-on, look in the MazzleUI Help System.\n\nTo access the options for this add-on, right-click on the NeedyList buttoon on the right-hand side of the screen.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure NeedyList",
        setProc = function() NLConfigNeedsFrame:Hide(); NLConfigFrame:Show(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "NeedyList settings are something that you will be changing quite frequently depending on the context of the situation.  A quicker way to open those options is by right-clicking the bottom NeedyList header button.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Target Buttons",
        requiredAddOn = "TargetButtons",
        addonDescription = "This add-on adds small buttons to the targeting frame when a friendly player is selected allowing you to do common tasks very quickly. The buttons it adds are: invite, follow, trade, whisper, duel, inspect.  By default in MazzleUI, these buttons are placed on the four corners of the target frame.  You should not need to change the settings of this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 4,
        name = "Target Buttons",
        label = "Click here to change the options for this add-on",
        setProc = function() MazzleUI:ExecuteMacro("/tboptions"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Omni Cooldown Count",
        requiredAddOn = "!OmniCC",
        addonDescription = "Omni Cooldown Count is a universal cooldown count plugin that provides cooldown counts for nearly every button in your UI.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Font Size:",
        minValue = 7,
        stepValue = 1,
        maxValue = 42,
        units = " pts",
        parameter = "OmniCC.size",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Font",
        label = "Click to change the font used",
        setProc = function() MazzleUI:StartEditCommand("/omnicc font "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        notetype = "example", 
        text = "/omnicc font Fonts\\FRIZQT__.TTF",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Short Color",
        label = "Click to change the color used for less than 5.5 seconds",
        setProc = function() MazzleUI:StartEditCommand("/omnicc color short "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Medium Color",
        label = "Click to change the color used for less than 1 minute",
        setProc = function() MazzleUI:StartEditCommand("/omnicc color medium "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Long Color",
        label = "Click to change the color used for less than one hour",
        setProc = function() MazzleUI:StartEditCommand("/omnicc color long "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Very Long Color",
        label = "Click to change the color used for longer durations",
        setProc = function() MazzleUI:StartEditCommand("/omnicc color vlong "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "You can specify a color with 3 numbers for <red value> <green value> <blue value>.  For example, '1 0 1' would be a purple color.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Scale size for less than 5.5 seconds =",
        minValue = 0.1,
        stepValue = .1,
        maxValue = 2,
        units = " x original size",
        parameter = "OmniCC.short.s",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Scale size for less than 1 minute =",
        minValue = 0.1,
        stepValue = .1,
        maxValue = 2,
        units = " x original size",
        parameter = "OmniCC.medium.s",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Scale size for less than one hour =",
        minValue = 0.1,
        stepValue = .1,
        maxValue = 2,
        units = " x original size",
        parameter = "OmniCC.long.s",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Scale size for for longer durations =",
        minValue = 0.1,
        stepValue = .1,
        maxValue = 2,
        units = " x original size",
        parameter = "OmniCC.vlong.s",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "Scale allows you to change the size of the cooldown based on how much time is left.  For example, you can make it grow larger as it gets closer to finishing.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -10,
        name = "Only show on buttons with cooldowns greater than",
        minValue = 0,
        stepValue = .5,
        maxValue = 60,
        units = " seconds",
        parameter = "OmniCC.min",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -20,
        name = "Hide Blizzard 'clock' effect?",
        parameter = "OmniCC.hideModel",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Flash when a skill becomes available?",
        parameter = "OmniCC.shine",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -5,
        name = "Flash brightness",
        minValue = 1,
        stepValue = 1,
        maxValue = 15,
        units = " units",
        parameter = "OmniCC.shineScale",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -10,
        name = "Reset",
        label = "Click here to reset all OmniCC settings to default.",
        setProc = function() MazzleUI:ExecuteMacro("/omnicc reset"); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Inspect()

    local addItem, tempItem = {}, {}
    addItem.name = "Inspecting"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Super Inspect",
        requiredAddOn = "SuperInspect",
        addonDescription = "This add-on provides a much improved inspect window that allows you to inspect from long distances and keep inspect information even if you lose your target.  It also allows you to see summaries of item bonuses and honor information, as well as rotate the 3d models.  There are no significant options for this add-on.  Note:  Some of this functionality is in the process of being disabled by Blizzard and may not work now or for long.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Talents()

    local addItem, tempItem = {}, {}
    addItem.name = "Talent Window"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Special Talent",
        requiredAddOn = "SpecialTalent",
        addonDescription = "This add-on provides an improved talent frame window in which you can see all three talent trees at once. In addition, you can use it in 'planning mode' as a talent calculator to play with potential specs.  You can access this by hitting the standard talent window keybinding of 'n'.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Special Talent",
        label = "Click here to open the Special Talent window",
        setProc = function() ToggleTalentFrame(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Assist()

    local addItem, tempItem = {}, {}
    addItem.name = "Assisting"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Smart Assist",
        requiredAddOn = "SmartAssist",
        addonDescription = "This add-on provides an intelligent assisting and targetting system in groups.  Depending on which options are available, it cyles through a list of potential targets to find the 'best' one at that time.  It can use a manually-set main assist (ctrl-f), the CT Raid Main Tanks, the targets with the most people targetting them, the mob attacking the party member with lowest health, etc.  It will fall back to standard tab targetting if one of the previous methods did not choose a good target.  It will also warn you if your current target is crowd control.  By default, the SmartAssist button can be accessed with the 'f' key.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Smart Assist",
        label = "Click here to open the options window for this add-ons",
        setProc = function() SA_ShowOptions(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Quests()

    local addItem, tempItem = {}, {}
    addItem.name = "Quests"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Mars Quest Organizer",
        requiredAddOn = "MarsQuestOrganizer",
        addonDescription = "This add-on allows you to move quests to a different zone.  You can even create your own custom categories to move quests into!  Simply select a quest and type /q <new category>.  If the new category or zone does not exist, it will be created.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Move Quest",
        label = "Click to move currently selected quest to another category",
        setProc = function() MazzleUI:StartEditCommand("/q "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "MonkeyQuest",
        requiredAddOn = "MonkeyQuest",
        addonDescription = "This add-on The displays quests and their objectives in a nice frame that is more powerful and customizable than Blizzard.  By default, you can access the MonkeyQuest log by hitting L.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "MonkeyBuddy",
        label = "Click here to open the options window for all Monkey add-ons",
        setProc = function() ShowUIPanel(MonkeyBuddyFrame); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "MonkeyQuestLog",
        requiredAddOn = "MonkeyQuestLog",
        addonDescription = "This add-on provides a much easier to read, resizable quest log window that works in tandem with MonkeyQuest.  The MonkeyQuestLog will open whenever you select an entry in MonkeyQuest.  This add-on is still in alpha, so there are currently no options for it.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Spellbook()

    local addItem, tempItem = {}, {}
    addItem.name = "Spellbook"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord MiniSpellbook",
        requiredAddOn = "DiscordMiniSpellbook",
        addonDescription = "This add-on provides a much more friendly spellbook than the default Blizzard one.  Multiple spell levels are compacted into one entry so you can see all of your spells without having to go through multiple pages.  By default, you can access this spellbook by type 'p'.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Mini Spellbook",
        label = "Click here to open the Discord Spellbook",
        setProc = function() DiscordMiniSpellbookFrame:Show(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Who()

    local addItem, tempItem = {}, {}
    addItem.name = "Who Window"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Who Favorites",
        requiredAddOn = "WhoFavorites",
        addonDescription = "This add-on allows you to save a list of frequently-used /who queries and recall them at will.  Click on the button next to the entry field in the Who window to add or remove searches from that list.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Character()

    local addItem, tempItem = {}, {}
    addItem.name = "Character Window"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Characters Viewer",
        requiredAddOn = "CharactersViewer",
        addonDescription = "This add-on allows you to view all of your character and bank information for *any* of your characters at any time.  By default, ctrl-b will open your global bank viewer.  You can see stats and inventory for another character by using the pull-down menu in your normal character window to select another character.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Bank View",
        label = "Click here to open the global bank viewer",
        setProc = function() MazzleUI:ExecuteMacro("/cv bank") end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Character Info",
        label = "List various information for all characters on this server",
        setProc = function() ace:print("|CFF00FF00-=CV Character Summary Information =-"); MazzleUI:ExecuteMacro("/cv list") end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", 
        name = "Bags",
        label = "List the amount of bag space each character has",
        setProc = function() ace:print("|CFF00FF00-=CV Bag Summary Information =-"); MazzleUI:ExecuteMacro("/cv bags") end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Bags Used",
        label = "List the amount of used bag space each character has",
        setProc = function() ace:print("|CFF00FF00-=CV Bag Use Summary Information =-"); MazzleUI:ExecuteMacro("/cv baguse") end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "DamageCalc",
        requiredAddOn = "DmgCalc",
        addonDescription = "This add-on shows total +damage, +healing, +spell hit, +crit, and mana regen from items/sets for each damage type(frost/fire etc.) in your character viewing window.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_KeyBindings()

    local addItem, tempItem = {}, {}
    addItem.name = "Key Bindings"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "MyBindings",
        requiredAddOn = "myBindings",
        addonDescription = "This add-on makes the key bindings interface much more user-friendly.  Rather than scrolling through a huge list of bindings, you can click on a key binding category and see only the bindings for that item.  There are no commonly-used options for this add-on.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Windows()

    local addItem, tempItem = {}, {}
    addItem.name = "Window Positioning"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Cirk's MerchantBags",
        requiredAddOn = "Merchantbags",
        addonDescription = "This add-on opens all your bags when you interact with a merchant or mailbox .  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Frame Modifier",
        requiredAddOn = "DiscordFrameModifier",
        addonDescription = "Discord Frame Modifier is used to change the properties all the different frames in your UI.  Mostly, this is used to place things in the proper location.  It's also used to change the size and textures of certain elements, for example, the minimap.  If you want to change the location of something in your UI, this is most likely the best place to do it.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 10,
        name = "DFM",
        label = "Click to change the properties of your various frames.",
        setProc = function() MazzleUI:ExecuteMacro("/dfm"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "KC Mobility",
        requiredAddOn = "KC_Mobility",
        addonDescription = "This add-on makes most windows in the game movable.  This has been modified from the original by Mazzlefizz.  There are no commonly-used options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader",
        addonName ="Lexan",
        requiredAddOn = "Lexan",
        addonDescription = "This add-on prevents other windows from closing your Auction House window.  It also blocks trade requests when at your mailbox or bank.  You can configure this add-on via the DeuceCommander menu in your FuBar.  It is under the Interface Enhancements category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Movable Bags",
        requiredAddOn = "MovableBags",
        addonDescription = "This add-on makes all of your bags movable.  This has been modified from the original by Mazzlefizz.  There are no commonly-used options for this add-on.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Mail()

    local addItem, tempItem = {}, {}
    addItem.name = "Mail"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "GMail",
        requiredAddOn = "GMail",
        addonDescription = "This add-on adds several mailing options to your mail window:  mass mailing, mail forwarding, and the ability to open multiple messages at once.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "MailTo",
        requiredAddOn = "MailTo",
        addonDescription = "This add-on allows you to create a list of commonly-used mail recipients.  Click on the button next to the To: field to add or remove people from that list.  It also tracks all items mailed, lets you remotely view inboxes and see when items in your inbox will expire.  Additional options can be accessed by typing in /mt help",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Expiration",
        label = "List all pending mail expiration dates",
        setProc = function() MazzleUI:ExecuteMacro("/mtex all"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", 
        name = "New Mail",
        label = "List all new mail on all characters",
        setProc = function() MazzleUI:ExecuteMacro("/mtn all"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Inbox",
        label = "Remotely view an inbox as it was last seen.",
        setProc = function() MazzleUI:ExecuteMacro("/inbox"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -10,
        name = "Alert you when mail is delivered?",
        readProc = function() return (not MailTo_Option.noalert); end,
        setProc = function(a,b)  MailTo_Option.noalert = (not b); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Show current mail status information when logging in?",
        readProc = function() return (not MailTo_Option.nologin); end,
        setProc = function(a,b)  MailTo_Option.nologin = (not b); end,}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Loot()

    local addItem, tempItem = {}, {}
    addItem.name = "Loot Related"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Class Master Loot",
        requiredAddOn = "ClassMasterLoot",
        addonDescription = "This add-on provides an enhance masterloot dropdown menu that is ordered by class.  Moreover, it adds entries to give the item to a random person or give it to yourself.  This add-on also allows you to make a list of 'quickloot' people, for example, someone in your raid who has a lot of bag space and you want to hold all the bijous.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -10,
        name = "Ask a winner for confirmation before sending them any loot?",
        parameter = "CML_Vars.Ask",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Add Player",
        label = "Click to add a player to the QuickLoot sub-menu",
        setProc = function() MazzleUI:StartEditCommand("/cml add "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button",
        name = "Clear QuickLoot",
        label = "Click to clear all players from the QuickLoot menu",
        setProc = function() MazzleUI:ExecuteMacro("/cml add") end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -10,
        name = "When using the loot-to-random-person, do you want to send a whisper to the winner?",
        parameter = "CML_Vars.PostRandom",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Fruity Loots",
        requiredAddOn = "FruityLoots",
        addonDescription = "This add-on moves the loot window to your mouse whenever it is shown.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Only reposition the loot window once?",
        parameter = "FruityLootsDB.profiles.Default.Once",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Loot Scroll",
        requiredAddOn = "LootScroll",
        addonDescription = "This add-on makes your loot window scrollable rather than having to click next or previous page buttons to see all the loot that a mob drops.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "KC Items",
        requiredAddOn = "KC_Items",
        addonDescription = "KC Items is an addon package that is both feature rich and modular.  It allows you to maintain a searchable item database, scan the auction house for auction data, provides several auction house conveniences, create on the fly chatlinks (type [ and start entering the name), as well as several tooltip enhancements.  You can access the many options of KC Items via the KCI menu in Fubar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_KCIFu",
        addonName = "FuBar KCIFu",
        addonDescription = "This add-on allows you to access KCI items functions from a menu.  I also allows you change all of your KC Items options without figuring out the various slash commands.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Chat()

    local addItem, tempItem = {}, {}
    addItem.name = "Chat Windows"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Cirk's ChatManager",
        requiredAddOn = "Chatmanager",
        addonDescription = "This add-on provides powerful management of your chat channels.  Among the things it does is manage and maintain a consistent ordering of channels (even if the underlying numbers change), list all members of a channel, provide quick access to channel management commands (like kick, passwords, etc.), provide a large variety of 'sticky' options for any channel, as well as several other features.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Open",
        label = "Click here to open the ChatManager",
        setProc = function() MazzleUI:ExecuteMacro("/chatmanager show"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "You can quickly access this window by clicking on the ChatManager button that is always visible on the right-side of the MazzleUI panel.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "EasyCopy",
        requiredAddOn = "EasyCopy",
        addonDescription = "This add-on provides an elegant way to copy text from whispers or chat.  At the beginning of every copyable line in the chat window, you will see an '@'.  Click on it and it will open an edit box from which you can copy the contents of that line.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Simple Combat Log",
        requiredAddOn = "SimpleCombatLog",
        addonDescription = "This important add-on formats your windows with cleaned-up, colored and easier-to-read combat log information.  It also filters out information that you don't want in a particular chat frame.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Left Combat Log",
        label = "Click here to configure damage/healing out combat messages ",
        setProc = function(a,b) MazzleOptions_OpenSCLMenu(a,b,6); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Right Combat Log",
        label = "Click here to configure all other combat messages ",
        setProc = function(a,b) MazzleOptions_OpenSCLMenu(a,b,7); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "The settings for the left chat window, the thin one, are configured to succinctly display damage and healing done.  The right one, on the other hand, is intended to show a more verbose combat log which includes damage and healing taken to you , as well as all miscellaneous messages.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Prat",
        requiredAddOn = "Prat",
        addonDescription = "This add-on modifies the behavior and display of your chat window. Among the things it provides are:\n\n  |cFFFF0000(1)|r Abbreviated channel names\n  |cFFFF0000(2)|r Colored player names (by class)\n  |cFFFF0000(3)|r Access to chat history without holding down Alt\n  |cFFFF0000(4)|r Increased chat history length\n  |cFFFF0000(5)|r Edit box to the top of the chat window\n  |cFFFF0000(6)|r Chat links in any channel (other users must run Prat or ChatManager)\n  |cFFFF0000(7)|r Mouse wheel scrolling\n  |cFFFF0000(8)|r Removal of unnecessary chat buttons to save space\n  |cFFFF0000(9)|r Tab completion of names\n  |cFFFF0000(10)|r Incread number of chat channels that are sticky\n  |cFFFF0000(11)|r Time stamps\n\nYou can access the options for this add-on via the DeuceCommander menu item in your FuBar.  It is under the chat/communication category.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_ChatLinks()

    local addItem, tempItem = {}, {}
    addItem.name = "Chat Links"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "ChatCast",
        requiredAddOn = "ChatCast",
        addonDescription = "ChatCast watches chat for keywords to make buff, heal, rez, healthstone/soulstone, mage water and invite requests into clickable links in your chat window. When you click on the link, it will cast that buff on the person who requested it. When clicking a link for healthstone or water, it figures out the best healthstone/water the person can use, makes it if necessary, and then trades it to them automatically. Soulstone links requires two clicks if you don't have one already, one to create and one to use.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Put brackets around clickable links?",
        parameter = "ChatCast.Brackets",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Play a sound when you click a link?",
        parameter = "ChatCast.Brackets",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Print a feedback message in chat when you click a link?",
        parameter = "ChatCast.Feedback",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Create invite links?",
        parameter = "ChatCast.Invites",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "'Last Link' keybinding only executes the last buff reqested?",
        parameter = "ChatCast.LastLink",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton",
        name = "Automatically send an invite when clicking on an LFM link?",
        parameter = "ChatCast.LFMAlt",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "When the above is unchecked, it will instead open your chatedit box with a whisper containing the ChatCast LFM response message.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "LFM Message",
        label = "Click here to change the default LFM response",
        setProc = function() MazzleUI:StartEditCommand("/cc lfm "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Link Color",
        label = "Click here to set the color of your chat links",
        setProc = function() ChatCast_ColorPicker(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "WhoTip",
        requiredAddOn = "WhoTip",
        addonDescription = "This add-on creates a tooltip when you shift-click on person's name so that you can see the /who results from any chat frame.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Display tooltips at mouse?",
        parameter = "WhoTip_Mouse",}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Crafting()

    local addItem, tempItem = {}, {}
    addItem.name = "Crafting"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Advanced Trade Skill Window",
        requiredAddOn = "AdvancedTradeSkillWindow",
        addonDescription = "ATSW is a complete replacement for Blizzards tradeskill window with an impressive set of features.  It:\n\n(1) Provides a larger window so you can see more\n\n(2) Allows sorting based on a variety of different criteria (alphabetical, by slot, by attribute, even custom categories)\n\n(3) Allows you to set filters that you can use to search for a recipe or only show certain recipes\n\n(4) Has a production list so you can quickly queue up multiple items.  It automatically adda all necessary sub-items that you must craft to make whatever it is you just added. It even lets you automatically compose a shopping list based on your production queue that you can later use at the auction house or at vendors!\n\nYou can access the options for this via when you open up any of your trade skill windows.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)

end

function MazzleOptions_Setup_Accessories()

    local addItem, tempItem = {}, {}
    addItem.name = "Accessories"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Answering Machine",
        requiredAddOn = "AnsweringMachine",
        addonDescription = "This add-on records messages that come to you in the whisper channel while you are away from your keyboard.  It will present the missed whispers when you exit afk or dnd state.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Record messages while AFK",
        readProc = function () return AnsweringMachine_GetLocal("afk"); end,
        setProc = function(a,b) if (b) then MazzleUI:ExecuteMacro("/answer afk on") else MazzleUI:ExecuteMacro("/answer afk off"); end; end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Record Message while DND",
        readProc = function () return AnsweringMachine_GetLocal("dnd"); end,
        setProc = function(a,b) if (b) then MazzleUI:ExecuteMacro("/answer dnd on") else MazzleUI:ExecuteMacro("/answer dnd off"); end; end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Change Message",
        label = "Click to change default message displayed when afk",
        setProc = function() MazzleUI:StartEditCommand("/answer msg "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Hide",
        label = "Click to hide afk window immediately",
        setProc = function() MazzleUI:ExecuteMacro("/answer frame off"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Status Windows",
        requiredAddOn = "StatusWindow",
        addonDescription = "This add-on  allows you to build up to 10 StatusWindows. A StatusWindow holds up to 10 panes, each of which displays a piece of information, like clock, latency meter, FPS meter, durability monitor, health regen monitor, mana regen monitor, and more.  MazzleUI uses several of these on the right-hand side of the MazzleUI panel.  The durability display below the character frame is also a Status Window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure Status Windows",
        setProc = function() MazzleUI:ExecuteMacro("/statuswindow"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "TinyPad",
        requiredAddOn = "TinyPad",
        addonDescription = "This add-on provides you with a virtual notebook to jot down little pieces of information that you may want to keep track of as you adventure.  You can create as many pages as you'd like, change the font size and even execute LUA code from in there!",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "TinyPad",
        label = "",
        setProc = function() MazzleUI:ExecuteMacro("/tinypad"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "You can always click on the HotSpot over the middle left corner of the MazzleUI panel to show or hide your TinyPad quickly.  The default keybinding for this add-on is 'J'.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "XCalc",
        requiredAddOn = "xcalc",
        addonDescription = "This add-on adds provides an in-game calculator.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 4,
        name = "Open",
        label = "Click here to launch XCalc",
        setProc = function() if (xcalc_windowdisplay) then xcalc_windowdisplay(); MazzleOptions_Hide(); end; end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "This add-on can be quickly launched by clicking in the bottom right HotSpot of the MazzleUI bottom panel.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_ClassHunter()

    local addItem, tempItem = {}, {}
    addItem.name = "Hunter"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AntiDaze",
        requiredAddOn = "AntiDaze",
        addonDescription = "This add-on automatically cancels Aspect of the Cheetah or Pack when you or one of your party members get dazed.  It also provides a keybinding for manual cancellations.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Options",
        label = "Click to configure Anti-Daze",
        setProc = function() MazzleUI:ExecuteMacro("/antidaze options"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)


    tempItem = {
        type = "AddOnHeader", 
        addonName = "FizzWidget's Feed-O-Matic",
        requiredAddOn = "GFW_FeedOMatic",
        addonDescription = "This add-on automatically feeds your pet whenever his happiness falls below a certain level, automatically choosing an appropriate food.  You can also set a key binding to do it manually.  Feed-o-matic can even do various role-playing emotes when feeding a pet.  When doing all of this, Feed-o-Matic uses an intelligent food choosing algorithm which takes into how much your pet likes the food, whether the food gives a bonus buff, whether the food is used for quests, whether the food is used in cooking (or optionally cooking that you can skill with).  All other things equal, it will even try to eat foods so that they use the least amount of space in your bags!",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Options",
        label = "Click to configure your Feed-O-Matic",
        setProc = function() ShowUIPanel(FOM_OptionsFrame); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    
    tempItem = {
        type = "AddOnHeader", 
        addonName = "FizzWidget's Hunter's Helper",
        requiredAddOn = "GFW_HuntersHelper",
        addonDescription = "When you mouse over a beast in the world with this add-on enabled, the tooltip will show which abilities a Hunter could learn after taming it. The abilities will be colored according to whether you’ve already learned them.  You can also use this add-on to get a list of all animals that can teach you a skill.",
    }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Find Animal",
        label = "Click to search for animals with a given skill",
        setProc = function() MazzleUI:StartEditCommand("/huntershelper find "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        notetype = "example", 
        text = "/huntershelper find Bite 6 to get a list of beasts known to have Bite (Rank 6). Results are sorted by zone.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_Aspect",
        addonName = "FuBar Aspect",
        addonDescription = "This add-on shows and gives hunters a quick way to change their aspect via your FuBar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Sorren's Hunter Timers",
        requiredAddOn = "SHunterTimers",
        addonDescription = "This add-on will display timers that show the duration of various hunter abilities in a draggable frame.  It also adds a casting bar for aimed shot.\n\nIt current handles the following hunter abilities: Auto Shot, Aimed Shot, Hunter's Mark, Flare, Concussive Shot and Improved Concussive Shot, Scatter Shot, Intimidation, Bestial Wrath, Scare Beast, Wingclip and Improved Wing Clip, Counterattack, Deterrence, Serpent Sting, Viper Sting, Scorpid Sting, Wyvern Sting, Freezing Trap, Frost Trap, Explosive Trap, Immolation Trap, Trap effects (will sometimes detect other hunters trap effects if they go off after you've dropped a trap), Trap diminishing returns, Clever Traps Talent, Entrapment, Frenzy, Rapid Fire, Berserking (Troll racial), Quick Shots (Improved Aspect of the Hawk proc), Expose Weakness (Dragonstalker 8-piece set proc), Primal Blessing (ZG set proc), Devilsaur Eye, Zandalarian Hero Medallion, Earthstrike, Badge of the Swarmguard, Jom Gabbar, and Kiss of the Spider .",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Options",
        label = "Click to configure Sorren's Hunter Timers",
        setProc = function() MazzleUI:ExecuteMacro("/sht menu"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)

end

function MazzleOptions_Setup_ClassMelee()

    local addItem, tempItem = {}, {}
    addItem.name = "Melee Classes"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Color Combo Points",
        requiredAddOn = "ColorComboPoints",
        addonDescription = "This add-on provides individually movable colored combo points for rogues and druids.  MazzleUI places them above the hud.  If you'd like to move, you should do that through DFM..  Check the help system for more information on how to use DFM.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "FuBar TankPointsFu",
        requiredAddOn = "FuBar_TankPointsFu",
        addonDescription = "This add-on displays a multitude of tank statistics in your Fubar.  Among these items are the tank's armour, defense, attack power, crit %.  It uses this information to calculate TankPoints, a metric for measuring how effective a character is as a tank in terms of gear and talents.  It is capable of reporting all of these critical stats (Health, Armour, Avoidance) to guild/raid chat to make tanking decisions more easily.  Finally, it can also yell an alert to raid chat whenever certain tank abilities are used such as Shield Wall, Last Stand, or Challenging Shout.  You can configure this add-on by right-clicking on its entry in your FuBar.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)

end

function MazzleOptions_Setup_ClassWarlock()

    local addItem, tempItem = {}, {}
    addItem.name = "Warlock"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "DoTimer",
        requiredAddOn = "DoTimer",
        addonDescription = "This add-on provides sophisticated DoT tracking addon, featuring spearation by target, smart timer removal, a host of interface options, extreme macro support, and much more.  It even detects resists, immunes, reflects, and evades.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Options",
        label = "Click to configure DoTimer",
        setProc = function() MazzleUI:ExecuteMacro("/dotimer"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Necrosis",
        requiredAddOn = "Necrosis",
        addonDescription = "This add-on provides an elaborate GUI to access a multitude of warlock abilities.  You can access the options for.  It also provides timers for most warlock dots and abilities.  You can access Necrosis options by clicking on the button in the Necrosis GUI.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)

end

function MazzleOptions_Setup_ClassMage()

    local addItem, tempItem = {}, {}
    addItem.name = "Mage"


    tempItem = {
        type = "AddOnHeader", 
        addonName = "FuBar MageFu", 
        addonDescription = "This simple add-on provides a myriad of functions to make a mage's job easier:\n\n  (1) 1-click conjuring of gems/water/food based on target class and level (even drinks automatically when your mana is low)\n  (2) Ability to set limits on amount of food/water/gems conjured (/magefu conjure)\n  (3) 1-click/auto trading of food/water based on target class and level (/magefu trade)\n  (4) 1-click consumption of food/water/mana gems (/magefu consume)\n  (5) Menu access to teleport/portal/hearthstone\n  (6) Customisable teleport/portal messages\n  (7) Auto buying of reagents when visiting vendors\n  (8) Assignment of yourself of groups to buff in raid (also visible to all other members of raid using MageFu)\n  (9) Customizable tooltips that can show assigned groups and group buffs.\n\nYou can configure this add-on directly from its entry in your FuBar.",
        requiredAddOn = "FuBar_MageFu",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "MazzleMage", 
        addonDescription = "This simple add-on provides several functions that can help a mage increase their damage more easily.  First, it allows for a few different automatic spell substitutions when certain conditions arise.  For example, if you get a Netherwind (8 out 8 Netherwind bonus), the add-on can substitue a powerful slow-casting spell such as pyroblast for your free instant cast.  Second, it provides bindings to simultaneously cast trinkets and spell modifying talents like presence of mind or arcane power.",
        requiredAddOn = "MazzleMage",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Enable spell substitution?",
        parameter = "MazzleMage_Settings.isOn",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Substitute spell when Netherwind procs?",
        parameter = "MazzleMage_Settings.netherwind",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        name = "Spell to substitute", yadjust = 5, xadjust = -15,
        menuItems = {"Frostbolt",
                     "Fireball",
                     "Pyroblast"},
        width = 100,
        readProc = function(a) return MazzleOptions_Get_MazzleMage("netherwind"); end,
        setProc = function(a,b) MazzleOptions_Set_MazzleMage("netherwind", b); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3, xadjust = 15,
        name = "Substitute spell when Presence of Mind is cast?",
        parameter = "MazzleMage_Settings.POM",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        name = "Spell to substitute", yadjust = 5, xadjust = -15,
        menuItems = {"Frostbolt",
                     "Fireball",
                     "Pyroblast"},
        width = 100,
        readProc = function(a) return MazzleOptions_Get_MazzleMage("POM"); end,
        setProc = function(a,b) MazzleOptions_Set_MazzleMage("POM", b); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3, xadjust = 15,
        name = "Substitute spell when Clearcasting procs?",
        parameter = "MazzleMage_Settings.clearcasting",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        name = "Spell to substitute", yadjust = 5, xadjust = -15,
        menuItems = {"Frostbolt",
                     "Fireball",
                     "Pyroblast"},
        width = 100,
        readProc = function(a) return MazzleOptions_Get_MazzleMage("clearcasting"); end,
        setProc = function(a,b) MazzleOptions_Set_MazzleMage("clearcasting", b); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3, xadjust = 15,
        name = "Substitute fireblast when in range and available?",
        parameter = "MazzleMage_Settings.fireblast",}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Don't substitue fireblast when target is frozen?",
        parameter = "MazzleMage_Settings.ignoreFrozen",}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)

end

function MazzleOptions_Setup_AH()

    local addItem, tempItem = {}, {}
    addItem.name = "Auction House"

    tempItem = {
        type = "AddOnHeader", 
        addonName ="Auction Filter Plus",
        requiredAddOn = "AuctionFilterPlus",
        addonDescription = "This add-on allows you to apply powerful filters to the currently items displayed in the auction house.  These options are also available by clicking on the Filters button in the auction house window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Show price per item (as opposed to price per stack)",
        parameter = "afp_SavedSettings.afp_OptionButton_PricePerUnit",
        setProc = function() afp_FlyoutLoad_OnClick(); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Hide unafforable (price greater than your current amount of gold)",
        parameter = "afp_SavedSettings.afp_OptionButton_HideUnaffordable",
        setProc = function() afp_FlyoutLoad_OnClick(); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Show only auctions with buyout",
        parameter = "afp_SavedSettings.afp_OptionButton_HideNoBuyout",
        setProc = function() afp_FlyoutLoad_OnClick(); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Exact name search, i.e. no partial matches shown",
        parameter = "afp_SavedSettings.afp_OptionButton_ExactName",
        setProc = function() afp_FlyoutLoad_OnClick(); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Show best deals (annotates auctions with good/bad/average based on the average price on that page)",
        parameter = "afp_SavedSettings.afp_OptionButton_ShowBestDeals",
        setProc = function() afp_FlyoutLoad_OnClick(); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader",
        addonName ="Auction House Favorites",
        requiredAddOn = "AHFavorites",
        addonDescription = "This add-on allows you to save commonly-used auction house searches for one-click future access.  Simply type in the search and then click on the menubutton next to the entry box.  There are no other options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader",
        addonName ="Auction House Quick Search",
        requiredAddOn = "AH_QuickSearch",
        addonDescription = "This add-on allows you to shift-click an item or item link to automatically perform a search in the auction house.  You must obviously have the auction house window open.  There are no other options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader",
        addonName ="Auction House Show Bid",
        requiredAddOn = "AH_ShowBid",
        addonDescription = "This small add-on will annotate auctions that have bids placed on them with the words (bid).  There are no other options for this add-on.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Tooltip()

    local addItem, tempItem = {}, {}
    addItem.name = "Tooltips"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "TinyTip",
        requiredAddOn = "TinyTip",
        addonDescription = "This add-on provides you with highly enhanced Tooltips for units.  Not only can you get increased information, but you can format the tooltip however you please.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Tiny Tip",
        label = "Click here to open the TipBuddy configuration window",
        setProc = function() MazzleUI:ExecuteMacro("/tinytip"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Book of Crafts",
        requiredAddOn = "BookOfCrafts",
        addonDescription = "This add-on provide you with information regarding your other characters crafts. Whenever you display a recipe tooltips, it will list which character know this recipe already, which character may learn it now and which character will be able to learn it later.  There are no other options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "BOC Options",
        label = "",
        setProc = function() MazzleUI:ExecuteMacro("/boc"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Equip Compare",
        requiredAddOn = "EQCompare",
        addonDescription = "This add-on allows you to get a comparison tooltip showing the 'currently equipped' item(s) so that you may compare it to an item you are looking at. This AddOn adds such a feature everywhere in the game where you can hover over items, such as in your bags, in the loot window or on the reward page of a quest. You also receive comparison tooltips when clicking an item link in the chat box.  Used in conjunction with Characters Viewer, you can even set it to show tooltips for alts, so you can shop for one character more easily from another.  You can change the options for this add-on via the DeuceCommander entry in your FuBar.  It is under the Interface Enhancements category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "IDCard",
        requiredAddOn = "IDCard",
        addonDescription = "IDCard is a very small add-on that displays an item's icon next to the tooltip descriptions.  This can be helpful, especially with items that have almost no description.  You can also ctrl-click or shift-click on the IDCard picture to try on or link the item long after the link is gone from your chat window.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Mendeleev",
        requiredAddOn = "Mendeleev",
        addonDescription = "This database adds some very useful information into an item's tooltip.  Depending on the item in question, it adds are where the items drops, what classes the items are useful for, and what recipes an item is used for.  You can configure this add-on via the DeuceCommander menu in your FuBar.  It is under the 'Other' category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "TheoryCraft",
        requiredAddOn = "TheoryCraft",
        addonDescription = "This add-on can provide a cornucopia of statistical information about your spells right in their tooltips. It helps you better analyze not only what your spells do but how your gear and talents affect them.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure TheoryCraft",
        setProc = function() MazzleUI:ExecuteMacro("/tc"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end


function MazzleOptions_Setup_Libraries()

    local addItem, tempItem = {}, {}
    addItem.name = "Libraries"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Ace 2 and Related Libraries",
        requiredAddOn = "!!!Libs",
        addonDescription = "This add-on contains package of libraries that  that are used by Ace 2 add-ons.  When you download an Ace2 add-on it will typically contain several embedded libraries within the folder of the add-on.  In MazzleUI, all of those embedded libraries are removed.  In its stead, MazzleUI uses this folder containing all the various libraries.  This speeds up loading time.  There are no commonly used options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Ace 1",
        requiredAddOn = "Ace",
        addonDescription = "This add-on is a library that provides a common development framework for Ace 1 add-ons.  There are no commonly used options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AceGUI",
        requiredAddOn = "AceGUI",
        addonDescription = "This add-on is a library that some Ace add-ons use to draw graphical interfaces.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Autobar Config ",
        requiredAddOn = "AutoBarConfig",
        addonDescription = "This add-on provides an options window for Autobar, the add-on that provides a category-based item bar on the right side of the MazzleUI panel.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Carnival Enemy Cast Bar Options ",
        requiredAddOn = "CECB_Options",
        addonDescription = "This add-on provides an options window for Enemy Cast Bars, the add-on that provides timers and castbars for any spells that occurs in your proximity.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Action Bars Options",
        requiredAddOn = "DiscordActionBarsOptions",
        addonDescription = "This add-on provides an options window for Discord Action Bars, the add-on that handles all your buttons.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Art Options",
        requiredAddOn = "DiscordArtOptions",
        addonDescription = "This add-on provides an options window for Discord Art, the add-on that handles the textures for the bottom panel and HUD.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Frame Modifier Options",
        requiredAddOn = "DiscordFrameModifierOptions",
        addonDescription = "This add-on provides an options window for Discord Frame Modifier, the add-on that positions all of the windows in the UI.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Library",
        requiredAddOn = "DiscordLibrary",
        addonDescription = "This add-on provides support functions for all of the Discord add-ons.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Discord Unit Frames Options",
        requiredAddOn = "DiscordUnitFramesOptions",
        addonDescription = "This add-on provides an options window for Discord Unit Frames, the add-on that displays unit frames for you and your party's characters.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Fubar 1.2 Compatibility Module",
        requiredAddOn = "FuBar-compat-1.2",
        addonDescription = "This add-on provides functions that allows older 1.2 version of Fubar plug-ins to work with Fubar 2.x.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Monkey Buddy",
        requiredAddOn = "MonkeyBuddy",
        addonDescription = "This add-on provides an options system for MonkeyQuest and MonkeyQuestLog.  You can access the options for these under MonkeyQuest in the 'Quests' section of MazzleOptions.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Monkey Library",
        requiredAddOn = "MonkeyLibrary",
        addonDescription = "This library provides some common functions for MonkeyQuest, MonkeyQuestLog and Monkeybuddy. There are no options for this add-on",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "SCT Options",
        requiredAddOn = "sct_options",
        addonDescription = "This add-on provides an options window for Scrolling Combat Text, the add-on that displays combat information in the middle of your screen.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "SCTD Options",
        requiredAddOn = "sctd_options",
        addonDescription = "This add-on provides an options window for the damage module of Scrolling Combat Text, the add-on that displays outgoing damage information in the middle of your screen.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "SmartAssist Options",
        requiredAddOn = "SmartAssistOptions",
        addonDescription = "This add-on provides an options window for SmartAssist, the add-on that allows you to quickly choose a good target to assist on.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "SpecialTalentUI",
        requiredAddOn = "SpecialTalentUI",
        addonDescription = "This is a library used by SpecialTalent.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "SuperInspect UI",
        requiredAddOn = "SuperInspect_UI",
        addonDescription = "This is a library used by SuperInspect.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "TinyTip Extras",
        requiredAddOn = "TinyTipExtras",
        addonDescription = "This is a library used by Tiny Tip for added functionality to the standard tooltips.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "TinyTip Options",
        requiredAddOn = "TinyTipOptions",
        addonDescription = "This add-on provides an options window for TinyTip, the add-on that displays and formats your tooltips.  This add-on only loads when you open the corresponding options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Timex",
        requiredAddOn = "Timex",
        addonDescription = "This is a library used by several Ace add-ons and each of the MazzleUI add-ons to schedule actions at future times.  There are no commonly-used options for this add-on.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Battlegrounds()

    local addItem, tempItem = {}, {}
    addItem.name = "Battlegrounds and PvP"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AV Bars",
        requiredAddOn = "avbars",
        addonDescription = "This add-on provides a set of timers for the various objectives in both Alterac Valley and Arathi Basic.  There are no options for this add-on.",
}
    table.insert(addItem, tempItem)
    
    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_BattlegroundFu",
        addonName = "FuBar BattlegroundFu",
        addonDescription = "This add-on provides a multitude of Battleground related functions:  Queue timer display for all battlegrounds queues, change/join/leave commands, tooltip displays with detailed timers that can be detached to work as an on-screen frame, in-game scoreboard summary for your character in shorthand format on the bar, detachable in-game tooltip with full scoreboard summary for your character, team sizes, team scores (AB/WSG), number of bases held (AB), objective Status report w/ timers (AB/AV), flag carriers (click to target in WSG) and real-time scoreboard.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_HonorFu",
        addonName = "FuBar HonorFu",
        addonDescription = "This add-on keeps track of honor and PvP statistics. It keeps track of: current honor (accurately), battlegrounds wins/losses, honorable kills/deaths and PVP Cooldown.  The add-on will also tell you when the next battleground weekend occurs and what your rating/rank limit for your level is.  It also does a few active things like auto-releasing on bg death, automatically showing bg map, keeping track of enemy flag carrier (allowing you to target them) and printing reputation gain for honor-related factions.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_Fubar()

    local addItem, tempItem = {}, {}
    addItem.name = "FuBar Add-Ons"

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar",
        addonName = "Fubar",
        addonDescription = "This add-on and its modules creates a power toolbar at the top of your screen.  You can access option for the different Fubar modules by right-clicking on their display in the top bar.  You can access general Fubar options by right-clicking on an empty portion of the top bar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 15,
        text = "This MazzleOptions category only contains the FuBar plug-ins that did not clearly fit in another category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "DeuceCommander",
        addonName = "DeuceCommander",
        addonDescription = "This add-on gives you a menu from which you can change the settings of most Ace 2 add-ons with having to learn and use slash commands.  Since so many of MazzleUI's add-ons are Ace2, this is a very important plug-in.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_AmmoFu",
        addonName = "FuBar AmmoFu",
        addonDescription = "This add-on shows how much ammo you have left.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "FuBar AnkhTimerFu",
        requiredAddOn = "FuBar_AnkhTimerFu",
        addonDescription = "This shaman-specific add-on displays both how many Ankhs you have and their related cooldowns.  You can change options for this add-on by right-clicking its entry in your FuBar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_CombatInfoFu",
        addonName = "FuBar CombatInfoFu",
        addonDescription = "This add-on provides a variety of summary combat skill information like Block/Crit/Dodge/Parry/Armor as well as Mainhand, Offhand, and Ranged Attack numbers.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_DurabilityFu",
        addonName = "FuBar DurabilityFu",
        addonDescription = "This add-on shows you a detailed breakdown of your armor and weapon durability including the cost to repair.  When you visit a vendor, it will automatically present you with an option repair damaged items.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_ExperienceFu",
        addonName = "FuBar ExperienceFu",
        addonDescription = "This add-on shows you detailed tracking of your character's experience points.  It shows current, rest, and pet XP in percent, absolute value, points to next level or xp/time.  It can also show time to level based on either the session or the past level played.  Finally, it shows total time played by session, level or overall.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_FactionsFu",
        addonName = "FuBar FactionsFu",
        addonDescription = "This add-on shows you your current reputation with all factions.  Click on a faction to monitor it.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_FriendsFu",
        addonName = "FuBar FriendsFu",
        addonDescription = "This add-on shows your online friends.  You can sort the list of players by different values and you can set some filters (eg. specific classes, level ranges or zones). It will also show an indicator if you're grouped with that player.  Click a player to whisper him, shift-click a player to paste its name to chat, alt-click a player to send an invite.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_GuildFu",
        addonName = "FuBar GuildFu",
        addonDescription = "This add-on shows your online guildmates.  You can sort the list of players by different values and you can set some filters (eg. specific classes, level ranges or zones). It will also show an indicator if you're grouped with that player.  Click a player to whisper him, shift-click a player to paste its name to chat, alt-click a player to send an invite.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_SkillsPlusFu",
        addonName = "FuBar SkillsPlusFu Light",
        addonDescription = "This add-on provides a tooltip which contains most of the information from the skills and professions panel. You can also choose a skill to watch on the bar. Left-click on the icon to display the skills panel.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_MailFu",
        addonName = "FuBar MailFu",
        addonDescription = "This add-on provides notifications of new mail on your FuBar.",
}
    table.insert(addItem, tempItem)
 
    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_MoneyFu",
        addonName = "FuBar MoneyFu",
        addonDescription = "This add-on tracks information about the money you earn and spend.  It does this for all of your characters.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_NameToggleFu",
        addonName = "FuBar NameToggleFu",
        addonDescription = "This add-on provides adds an icon to toggle player names.  Left-click to toggle names over players.  Right-click to fine-tune the settings including those for name plates.",
}
    table.insert(addItem, tempItem)
 
    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_PetInfo",
        addonName = "FuBar PetInfoFu",
        addonDescription = "This add-on provides detailed information on a hunter or warlock's pet.",
}
    table.insert(addItem, tempItem)
 
    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_ReagentFu",
        addonName = "FuBar ReagentFu",
        addonDescription = "This add-on provides a quick way to see how many reagents you have left.  It automatically configures itself based on your class.  Right-click to add or remove items.",
}
    table.insert(addItem, tempItem)
  
    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_TopScoreFu",
        addonName = "FuBar TopScoreFu",
        addonDescription = "This add-on keeps track of your top damage/heals and alerts you with a large message and sound when you get a new record.  It distinguishes between normal and critical hits, as well as between PvP and PvE damage.  Shift-clicking to put information in the chat box.  Can also be set to take a screenshot when record occurs.",
}
    table.insert(addItem, tempItem)
  
    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_VolumeFu",
        addonName = "FuBar VolumeFu",
        addonDescription = "This add-on gives you a quick way to change the various volume levels as well as disable them entirely.  Mousing over this add-on will also reset your volume, allowing you to quickly recover from that annoying bug that sometimes maximizes your volume when you tab out of WoW.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end


function MazzleOptions_Setup_SCTAddOns()

    local addItem, tempItem = {}, {}
    addItem.name = "Scrolling/Floating Combat Text"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Scrolling Combat Text",
        requiredAddOn = "sct",
        addonDescription = "This add-on adds damage, heals, and events (dodge, parry, windfury, etc...) as scrolling text above you character model, much like what already happens above your target. This makes it so you do not have to watch (or use) your regular combat chat window and can see important information quickly.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure SCT",
        setProc = function() MazzleUI:ExecuteMacro("/sct menu"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Scrolling Combat Text Damage",
        requiredAddOn = "sctd",
        addonDescription = "This add-on is a plugin for SCT that lets it also handle the damage done to your target.  It has far more options that the default Blizzard damage display.  Settings for this add-on can be changed via the main SCT options window.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Scrolling Combat Text Cooldowns",
        requiredAddOn = "sct_cooldowns",
        addonDescription = "This add-on uses SCT to display a message when your cooldowns finish.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -15,
        name = "Show cooldown messages in crit format?",
        parameter = "sctcOptions.crit"}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -15,
        name = "Format Message",
        label = "Click to change message displayed when CD is up",
        setProc = function() MazzleUI:StartEditCommand("/sctc format "..sctcOptions["format"]); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Format Warning",
        label = "Click to change warning message when CD is almost up",
        setProc = function() MazzleUI:StartEditCommand("/sctc wformat "..sctcOptions["wformat"]); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 15,
        text = "Use %s in the above two options to indicate where you want the spell name printed",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -15,
        name = "Message Color",
        label = "Click here to change the color of the various messages.",
        setProc = function() MazzleUI:StartEditCommand("/sctc color "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 15,
        text = "For the above color option, you must enter 3 numbers as parameters: red, green and blue.  Each parameter is a number from 0.0 to 1.0",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", notetype = "example", yadjust = 20,
        text = "/sctc color 1 0 1 (makes message a purple color)",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", yadjust = -15,
        name = "Also show WARNING when cooldown will be up in ",
        minValue = 0,
        stepValue = 1,
        maxValue = 30,
        units = " seconds",
        readOnlyParameter = "sctcOptions.warning",
        setProc = function(a,b) if (tonumber(b)>0) then sctcOptions.warning = tonumber(b); else sctcOptions.warning = nil; end; end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 5,
        text = "Use 0 in the above option to disable cooldown warnings.  This setting only applies to an extra warning message, not main 'Cooldown is ready' message",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -15,
        name = "Disable Spell",
        label = "Click here to disable cooldown message for a spell",
        setProc = function() MazzleUI:StartEditCommand("/sctc disable "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "List Disabled Spells",
        label = "Click here to list all disabled spells",
        setProc = function() MazzleUI:ExecuteMacro("/sctc list"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", yadjust = 15,
        text = "For the above two options, make sure to enter name precisely.  It is case-sensitive.  Repeat the process to re-enable.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "WitchHunt",
        requiredAddOn = "WitchHunt",
        addonDescription = "This add-on provides large banner messages when enemies near you cast spells or perform emotes.  This lets you more quickly react to important actions your enemy performs do without needing to examing the combat or chat windows.  You can access the settings for this add-on via the DeuceCommander menu in your FuBar.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_DamageMeter()

    local addItem, tempItem = {}, {}
    addItem.name = "Damage Meters"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "DamageMeters",
        requiredAddOn = "DamageMeters",
        addonDescription = "This add-on monitors damage and healing done by and to yourself and other nearby players. It keeps a running total for each player and displays the information as a bars chart in a frame on the screen. It is perfect for real-time comparison of the various members of your party or raid. At any time the text results can be output to the say, raid or party chat, or whispered to another player.\n\nThis add-on can cause lag, but may be worth using if your raid group also uses it.  In such cases, it will give you more accurate numbers than Recap.\n\nYou can access the options of DamageMeters by right-clicking on it's title header.  To hide or show DamageMeters, click on the DamageMeter icon in your FuBar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "Fubar_DamageMetersFu2",
        addonName = "Fubar DamageMetersFu 2",
        addonDescription = "This add-on provides a quick way to show and hide Damage Meters.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "KLH ThreatMeter",
        requiredAddOn = "KLHThreatMeter",
        addonDescription = "This add-on monitors and records your threat, and will list your threat in a table with other members of your party or raid group who are using the mod. Most class talents, abilities, and items that cause or modify threat are taken into account. There is a table for your personal threat contribution, broken into specific categories such as white damage, healing, mana gain, etc, and specific abilities such as Sunder Armor and Taunt.\n\nYou can set options for this add-on by clicking on the options icon in the title bar of the KLH Threatmeter.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        text = "This add-on is expensive and can cause significant framerate loss.  Moreover, it is only useful if everyone in your raid uses it.  Make sure it will be worth the cost to you before enabling it.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Recap",
        requiredAddOn = "Recap",
        addonDescription = "This add-on will track and summarize the damage dealt and received by every participant in a fight around the user.  It also does healing and keeps track of a variety of information about which abilities the combatants use.  This version uses Rophy's ParserLib for efficient combat log parsing.\n\nYou can set options for this add-on by clicking on the options icon in the title bar of the Recap window.  You can show/hide by left-clicking on the Recap icon on the right-side of the MazzleUI panel.  You can also right-click on that same icon to quickly turn combat monitoring on or off.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure Recap combat tracking",
        setProc = function() RecapOptFrame:Show(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "SWStats",
        requiredAddOn = "SW_Stats",
        addonDescription = "This add-on is a customizable damage/heal meter with a built-in Sync channel that is running in the background. The design here is especially geared towards raid groups.\n\nThis add-on can cause lag, but may be worth using if your raid group also uses it.  In such cases, it will give you more accurate numbers than Recap.\n\nYou can access the options of SWStats by right-clicking on it's icon, near the game clock.  To hide or show SWStats, simply click on that same icon.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", requiredAddOn = "FuBar_SWStatsFu",
        addonName = "FuBar SWStatsFu",
        addonDescription = "This add-on provides a quick way to show and hide SWStats and to access its options from your FuBar.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_TimerBars()

    local addItem, tempItem = {}, {}
    addItem.name = "Timer Bars"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Natur's Enemy Castbars",
        requiredAddOn = "CEnemyCastBar",
        addonDescription = "This powerful add-on display cooldown and timer bars for other people around you who may be casting spells or have spells on cooldown.  It can also show various timers for your own skills.  Consult the documentation for other powerful things that Enemy Castbars can do; for example, you can use them in macros to set up timers for your various DOTs and HOTs.",
}
    table.insert(addItem, tempItem)
    
    tempItem = {
        type = "Button", yadjust = 5,
        name = "Options",
        label = "Click here to configure Enemy Cast Bars",
        setProc = function() MazzleUI:ExecuteMacro("/necb"); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "You can access the options for this add-on by left-clicking the EnemyCastBar icon on the right side of the MazzleUI panel.  Right-click to temporarily turn it off, since it can be expensive in certain situations.  You can also set it to be disabled automatically via the various MazzleUI efficiency modes.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end

function MazzleOptions_Setup_MapAddons()

    local addItem, tempItem = {}, {}
    addItem.name = "Maps and Navigation"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Alpha Map (Fan's Update)",
        requiredAddOn = "AlphaMap",
        addonDescription = "This add-on provides a scalable, moveable, transparent WorldMap that the user can have on screen while they continue to play and interact with the world. It includes maps for instances, battlegrounds, & world bosses.  Use ctrl-click to zoom the map in and out just like the normal world map.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = 10,
        name = "Options",
        label = "Click to open the options window for AlphaMap.",
        setProc = function() AM_OptionsFrame:Show(); MazzleOptions_Hide(); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "AtlasLoot",
        requiredAddOn = "AtlasLoot",
        addonDescription = "This add-on provides a list of what items drop from every boss in every instance.  You can access this information by pulling up the map for an instance in AlphaMap.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "FuBar ToFu",
        requiredAddOn = "FuBar_ToFu",
        addonDescription = "This add-on adds flight information to the flight path gossip window and a duration timer during flights.  You can configure this add-on via its entry in your FuBar.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Gatherer",
        requiredAddOn = "Gatherer",
        addonDescription = "This add-on Gatherer is for herbalists, miners and treasure hunters. It's main purpose is to track the closest plants, deposits and treasure locations on you minimap.  Unlike the normal tracking ability does, Gatherer 'remembers' where you have found various items in the past and, whenever the item comes into range, will pop up an icon on your minimap.  While computationally expensive, this add-on can be extremely useful to herbalists and miners.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "MapScroll",
        requiredAddOn = "MapScroll",
        addonDescription = "This add-on allows you to use the mouse wheel to zoom the minimap in and out.  There are no commonly-used options for this add-on.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "Party Spotter",
        requiredAddOn = "PartySpotter",
        addonDescription = "A small but powerful add-on that helps you distinguish unit blips on your maps.  It will color blips on your map (standard or battleground) depending on whether that unit is a party member, a raid member, a guild member, a friend, the raid leader or even just an arbitrary person you have interest in and told it to keep track of!  It can even put numbers on the icons to specify which group they are in.\n\nTo highlight a group, you can left-click on the legend near the map in question.  To change the color of a group, right-click on its entry in the map legend.  To highlight an arbitrary player, right click on any party or unit raid frame and select highlight from the menu.  Highlighted players will also appear as an X in your minimap.  You can click on any of the icons to target that player in question.  ",
}
    table.insert(addItem, tempItem)
    tempItem = {
        type = "Notebox", 
        text = "To take full advantage of this AddOn's features, don't forget to use the provided key bindings to cycle through the various display modes.  You can do that by finding the appropriate entry under the 'Party Spotter' heading in the key binding window, and choosing a key to bind it to.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Slider", xadjust = 10,
        name = "Icon update rate:",
        minValue = 0,
        stepValue = 0.1,
        maxValue = 9,
        units = " secs",
        parameter = "PartySpotterSettings.updateInterval",
        setProc = function() PartySpotter_ConfigChange(); end,
        }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        name = "Mark different raid groups with different", yadjust = -10, xadjust = -15,
        menuItems = {"Colors",
                     "Numbers",
                     "Nothing"},
        width = 100,
        readProc = function(a) return MazzleOptions_Get_PartySpotter("groups"); end,
        setProc = function(a,b) MazzleOptions_Set_PartySpotter("groups", b); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Menu",
        name = "Highlight", yadjust = 5, 
        menuItems = {"Friends",
                     "Guildmates",
                     "Ignores"},
        width = 100,
        readProc = function(a) return MazzleOptions_Get_PartySpotter("highlight"); end,
        setProc = function(a,b) MazzleOptions_Set_PartySpotter("highlight", b); end,}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", xadjust = 15, yadjust = -10,
        name = "Highlight raid leader?",
        parameter = "PartySpotterSettings.showLeader",
        setProc = function() PartySpotter_ConfigChange(); end,
        }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Specific Player",
        label = "Click to highlight someone",
        setProc = function() MazzleUI:StartEditCommand("/pspot -t "); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Button", yadjust = -5,
        name = "Clear",
        label = "Click to clear player highlight currently set",
        setProc = function() MazzleUI:ExecuteMacro("/pspot -t"); end}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox",
        notetype = "example", 
        text = "'/pspot -t Mazzlefizz' will highlight me if I'm in your raid or group.  Note that you can also just right click on a unit frame and select 'Highlight' from the menu.",
    }
    table.insert(addItem, tempItem)


    tempItem = {
        type = "CheckButton", yadjust = -10,
        name = "Color messages in chat the same colour that their icons are labelled with?",
        parameter = "PartySpotterSettings.colouredChat",
        setProc = function() PartySpotter_ConfigChange(); end,
        }
    table.insert(addItem, tempItem)

    tempItem = {
        type = "CheckButton", 
        name = "Add a numbered prefix in chat to show what group a person is in?",
        parameter = "PartySpotterSettings.numberedChat",
        setProc = function() PartySpotter_ConfigChange(); end,
        }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end
    
function MazzleOptions_Setup_Raiding()

    local addItem, tempItem = {}, {}
    addItem.name = "Raiding Tools"

    tempItem = {
        type = "AddOnHeader", 
        addonName = "BigWigs",
        requiredAddOn = "BigWigs",
        addonDescription = "BigWigs is a boss timer and warning mod that attempts to show info in the most relevant way possible, and give the user control over their mods, not the raid leader.\n\nThere's a few other things that distinguish BigWigs from that other boss mod. First off, it shows actual timers bars for events rather than less-informative periodic messages.  Of course, it also shows important event messages as well.  The best difference, however, is one you can't see. BigWigs will take advantage of the CTRA/oRA chat channel if it is present to send sync messages. This means that modules that rely on combat log triggers, like detecting when Ragnaros is engaged after a wipe, can trigger even if the player isn't in range to catch the combat log message. The only requirement for this to happen is that another BigWigs user is in range of the event. This sync system has the potential to allow for detailed info to be exchanged between BigWigs users with much more accuracy than systems that rely on a few promoted people being in range.\n\nBigWigs will also block unnecessary spam from other add-ons like CT RaidAssist's Boss Mods.  Moreover, it can broadcast messages to other raid members who are not running BigWigs.  These messages, though, will be automatically blocked by other users of BigWigs.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "You can access the options for BigWigs by right-clicking on its button in the right-hand side of the MazzleUI panel.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "BigWigs Nefarion Counter",
        requiredAddOn = "BigWigs_NefCount",
        addonDescription = "This add-on provides a window that tallies how many drakonids you kill in stage one of the Nefarion fight.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "You do not need this add-on if your guild does not fight Nefarion, the final boss of Blackwing Lair.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "BigWigs C'Thun Assist",
        requiredAddOn = "BigWigs_CThunAssist",
        addonDescription = "This add-on provides a window that tells you whether people are too close to you during the C'thun encounter.  During phase 2, it will also tell you who is in the stomach.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "You do not need this add-on if your guild does not fight C'thun, the final boss of AQ40.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "oRA2",
        addonDescription = "This add-on provides a low-cost alternative to CT RaidAssist.  With this option you can use only the modules that you need.  All of the commands and options of this add-on can be accessed via the oRA2 menu in Fubar.",
        requiredAddOn = "oRA2",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "sRaidFrames",
        requiredAddOn = "sRaidFrames",
        addonDescription = "sRaidFrames is a low-cost add-on that show Raid frames.  It has been modified to better work within the MazzleUI layout.  It's a more efficient alternative to either Blizzard or CT Raid's raid frames.  You can access all of the options for this add-on via the DeuceCommander menu in your Fubar.  It is under the Raid category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "AddOnHeader", 
        addonName = "XRaid Status",
        requiredAddOn = "XRS",
        addonDescription = "This add-on provides an informative window that lets you monitor overall raid status, such as number of deaths, total tank health, total healer mana, etc.  This add-on is highly configurable.  It's a more efficient alternative to CT Raid's status monitor.  You can access the options for this add-on via the DeuceCommander menu in your Fubar.  It is under the Raid category.",
}
    table.insert(addItem, tempItem)

    tempItem = {
        type = "Notebox", 
        text = "To add more stats to monitor or change display options, simply right-click on the XRaidStatus window, which, by default, is at the top right of the screen.",
}
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_SettingsInfo.Contents, addItem)
end
