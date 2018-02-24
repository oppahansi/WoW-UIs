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

Mazzifier_FrameCheckButtons = { };

Mazzifier_FrameCheckButtons["MAZZASPECT1"] = { index = 1, labelText = "1.25 (1280x1024, etc.)", tooltipText = "Divide your screen width by your screen height to get this value.  You can set and find this information in the video options."};
Mazzifier_FrameCheckButtons["MAZZASPECT2"] = { index = 2, labelText = "1.33 (1600x1200, 1024x768, 800x600, etc.)", tooltipText = "Divide your screen width by your screen height to get this value.  You can set and find this information in the video options."};
Mazzifier_FrameCheckButtons["MAZZASPECT3"] = { index = 3, labelText = "1.6 (1920x1200, 1680x1050, 1440x900, 1280x800, etc.)", tooltipText = "Divide your screen width by your screen height to get this value.  You can set and find this information in the video options."};

Mazzifier_FrameCheckButtons["MAZZPART1"] = { index = 4, labelText = "Add-Ons Settings", tooltipText = "Configure the settings of other add-ons.  You can customize in the next tab."};
Mazzifier_FrameCheckButtons["MAZZPART2"] = { index = 5, labelText = "Layout and Artwork", tooltipText = "Configure the positioning and size of UI elements.  Does this by configuring the Discord Art, Discord Frame Modifier and Discord Unit Frame profiles."};
Mazzifier_FrameCheckButtons["MAZZPART3"] = { index = 6, labelText = "Button Configuration", tooltipText = "Configures the layout and contents of your buttons.  You can override the default layout for you class in the Buttons tab."};

Mazzifier_FrameCheckButtons["MAZZCHATSIZE1"] = { index = 8, labelText = "Normal (may be too small for some people)", tooltipText = "Sets font size to 13pt for main chat windows, 12pt for Trade/LFG windows and 10pt for combat windows."};
Mazzifier_FrameCheckButtons["MAZZCHATSIZE2"] = { index = 9, labelText = "Large", tooltipText = "Sets font size to 15pt for main chat windows, 14pt for Trade/LFG windows and 13pt for combat windows."};
Mazzifier_FrameCheckButtons["MAZZCHATSIZE3"] = { index = 10, labelText = "Mr. Magoo", tooltipText = "Sets font size to 18pt for main chat windows, 16pt for Trade/LFG windows and 15pt for combat windows."};
Mazzifier_FrameCheckButtons["MAZZMODE1"] = { index = 13, labelText = "Complete configuration.  I want a Mazzlegasm!", tooltipText = "Mazzifier will configure everything for a fresh install."};
Mazzifier_FrameCheckButtons["MAZZMODE2"] = { index = 14, labelText = "Upgrade mode", tooltipText = "Mazzifier will configure only those things that have changed since your last MazzleUI install or update."};
Mazzifier_FrameCheckButtons["MAZZMODE3"] = { index = 15, labelText = "Custom mode", tooltipText = "Mazzifier will configure based on options you set in this window."};
Mazzifier_FrameCheckButtons["MAZZSAS"] = { index = 74, labelText = "Also place spells and actions in the buttons?", tooltipText = ""};
Mazzifier_FrameCheckButtons["MAZZPART0"] = { index = 75, labelText = "Add-On Selection (i.e. which ones are enabled for this character)", tooltipText = "Configure which add-ons are enabled for this character, based on class, level and some questions in the following tabs of this window."};
Mazzifier_FrameCheckButtons["MAZZPART5"] = { index = 76, labelText = "Key Bindings", tooltipText = "Configure key bindings for your UI.  Note that this is incremental, so you may not lose most of your previous bindings unless something specifically changed.  These do not alter button bindings specified by your buttons, i.e. Discord Action Bars"};

Mazzifier_AddOnInfo = {}
Mazzifier_AddOnInfo["ATW"] = {              index = 16,name="Advanced Trade Window",setupFunc="Setup_ATW", lastUpdate=0.60, global = true, trueName = "AdvancedTradeSkillWindow"}
Mazzifier_AddOnInfo["AlphaMap"] = {         index = 17,name="AlphaMap (Fan's Update)", setupFunc="Setup_AlphaMap", lastUpdate=0.60, global = true, trueName = "AlphaMap"}
Mazzifier_AddOnInfo["AtlasLoot"] = {        index = 18,name="AtlasLoot", setupFunc="Setup_AtlasLoot", lastUpdate=0.70, global = true, trueName = "AtlasLoot"}
Mazzifier_AddOnInfo["Autobar"] = {          index = 19,name="Autobar",setupFunc="Setup_Autobar", lastUpdate=0.60, global = false, trueName = "AutoBar"}
Mazzifier_AddOnInfo["BigWigs"] = {          index = 20,name="BigWigs Boss Warnings", setupFunc="Setup_BigWigs", lastUpdate=0.60, global = true, trueName = "BigWigs"}
Mazzifier_AddOnInfo["Blizzard"] = {         index = 21,name="Blizzard UI Options", setupFunc="Setup_SV", lastUpdate=0.70, global = true}
Mazzifier_AddOnInfo["ChatCast"] = {         index = 22,name="Chat Cast", setupFunc="Setup_ChatCast", lastUpdate=0.60, global = true, trueName = "ChatCast"}
Mazzifier_AddOnInfo["AutoRank"] = {         index = 23,name="Cirk's AutoRank",setupFunc="Setup_AutoRank", lastUpdate=0.60, global = false, trueName = "Autorank"}
Mazzifier_AddOnInfo["ChatManager"] = {      index = 24,name="Cirk's Chat Manager",setupFunc="Setup_ChatManager", lastUpdate=0.60, global = false, trueName = "Chatmanager"}
Mazzifier_AddOnInfo["FastCast"] = {         index = 25,name="Cirk's FastCast", setupFunc="Setup_FastCast", lastUpdate=0.60, global = false, trueName = "Fastcast"}
Mazzifier_AddOnInfo["Clique"] = {           index = 26,name="Clique",setupFunc="Setup_Clique", lastUpdate=0.60, global = false, trueName = "Clique"}
Mazzifier_AddOnInfo["DamageMeters"] = {     index = 27,name="DamageMeters", setupFunc="Setup_DamageMeters", lastUpdate=0.60, global = true, trueName = "DamageMeters"}
Mazzifier_AddOnInfo["EQCompare"] = {        index = 28,name="EQCompare", setupFunc="Setup_EQCompare", lastUpdate=0.60, global = true, trueName = "EQCompare"}
Mazzifier_AddOnInfo["FinderReminder"] = {   index = 29,name="Finder Reminder", setupFunc="Setup_FinderReminder", lastUpdate=0.60, global = true, trueName = "FinderReminder"}
Mazzifier_AddOnInfo["Fubar"] = {            index = 30,name="Fubar", setupFunc="Setup_FuBar", lastUpdate=0.60, global = true, trueName = "FuBar"}
Mazzifier_AddOnInfo["FubarAdd-Ons"] = {     index = 31,name="Fubar Add-Ons", setupFunc="Setup_FuBar_Addons", lastUpdate=0.60, global = true}
Mazzifier_AddOnInfo["ItemRack"] = {         index = 32,name="Gello's ItemRack", setupFunc="Setup_ItemRack", lastUpdate=0.60, global = false, trueName = "ItemRack"}
Mazzifier_AddOnInfo["Recap"] = {            index = 33,name="Gello's Recap", setupFunc="Setup_recap", lastUpdate=0.60, global = false, trueName = "Recap"}
Mazzifier_AddOnInfo["TrinketMenu"] = {      index = 34,name="Gello's TrinketMenu", setupFunc="Setup_TrinketMenu", lastUpdate=0.60, global = false, trueName = "TrinketMenu"}
Mazzifier_AddOnInfo["ImprovedErrorFrame"] = {index = 35,name="Improved Error Frame", setupFunc="Setup_IEF", lastUpdate=0.60, global = true, trueName = "!ImprovedErrorFrame"}
Mazzifier_AddOnInfo["KCItems"] = {          index = 36,name="KC Items", setupFunc="Setup_KC", lastUpdate=0.60, global = false, trueName = "KC_Items"}
Mazzifier_AddOnInfo["Mazz3D"] = {           index = 37,name="Mazzlefizz's 3D Characters", setupFunc="Setup_Mazz3D", lastUpdate=0.60, global = true, trueName = "Mazz3D"}
Mazzifier_AddOnInfo["Mendeleev"] = {        index = 38,name="Mendeleev", setupFunc="Setup_Mendeleev", lastUpdate=0.60, global = true, trueName = "Mendeleev"}
Mazzifier_AddOnInfo["MobHealth3"] = {       index = 39,name="MobHealth 3", setupFunc="Setup_MobHealth3", lastUpdate=0.60, global = true, trueName = "MobHealth"}
Mazzifier_AddOnInfo["MonkeyQuest"] = {      index = 40,name="MonkeyQuest", setupFunc="Setup_MonkeyQuest", lastUpdate=0.70, global = false, trueName = "MonkeyQuest"}
Mazzifier_AddOnInfo["CEnemyCastBar"] = {    index = 41,name="Natur Enemy Cast Bar", setupFunc="Setup_CEnemyCastBar", lastUpdate=0.60, global = false, trueName = "CEnemyCastBar"}
Mazzifier_AddOnInfo["Necrosis"] = {         index = 42,name="Necrosis", setupFunc="Setup_Necrosis", lastUpdate=0.70, global = false, trueName = "Necrosis"}
Mazzifier_AddOnInfo["NeedyList"] = {        index = 43,name="Needy List", setupFunc="Setup_NeedyList", lastUpdate=0.60, global = false, trueName = "NeedyList"}
Mazzifier_AddOnInfo["OmniCC"] = {           index = 44,name="Omni Cooldown Count", setupFunc="Setup_OmniCC", lastUpdate=0.60, global = true, trueName = "!OmniCC"}
Mazzifier_AddOnInfo["oRA"] = {              index = 45,name="oRA2 Raid Add-Ons", setupFunc="Setup_oRA", lastUpdate=0.60, global = true, trueName = "oRA2"}
Mazzifier_AddOnInfo["PartySpotter"] = {     index = 46,name="PartySpotter", setupFunc="Setup_PartySpotter", lastUpdate=0.60, global = true, trueName = "PartySpotter"}
Mazzifier_AddOnInfo["Prat"] = {             index = 47,name="Prat", setupFunc="Setup_Prat", lastUpdate=0.70, global = true, trueName = "Prat"}
Mazzifier_AddOnInfo["SCT"] = {              index = 48,name="Scrolling Combat Text", setupFunc="Setup_sct", lastUpdate=0.60, global = false, trueName = "sct"}
Mazzifier_AddOnInfo["SCTC"] = {             index = 49,name="Scrolling Combat Cooldowns", setupFunc="Setup_sctc", lastUpdate=0.60, global = false, trueName = "sct_cooldowns"}
Mazzifier_AddOnInfo["SCL"] = {              index = 50,name="Simple Combat Log", setupFunc="Setup_SCL", lastUpdate=0.60, global = false, trueName = "SimpleCombatLog"}
Mazzifier_AddOnInfo["SmartAssist"] = {      index = 51,name="Smart Assist", setupFunc="Setup_SmartAssist", lastUpdate=0.60, global = false, trueName = "SmartAssist"}
Mazzifier_AddOnInfo["sRaid"] = {            index = 52,name="sRaid Raid Frames", setupFunc="Setup_sRaid", lastUpdate=0.60, global = true, trueName = "sRaidFrames"}
Mazzifier_AddOnInfo["StatusWindows"] = {    index = 53,name="Status Windows", setupFunc="Setup_StatusWindow", lastUpdate=0.60, global = false, trueName = "StatusWindow"}
Mazzifier_AddOnInfo["SuperInspect"] = {     index = 54,name="SuperInspect", setupFunc="Setup_SuperInspect", lastUpdate=0.60, global = true, trueName = "SuperInspect"}
Mazzifier_AddOnInfo["SWStats"] = {          index = 55,name="SWStats Damage Meter", setupFunc="Setup_SWStats", lastUpdate=0.60, global = false, trueName = "SW_Stats"}
Mazzifier_AddOnInfo["TargetButtons"] = {    index = 56,name="Target Buttons", setupFunc="Setup_TargetButtons", lastUpdate=0.60, global = true, trueName = "TargetButtons"}
Mazzifier_AddOnInfo["TinyTip"] = {          index = 57,name="Tiny Tip", setupFunc="Setup_TinyTip", lastUpdate=0.60, global = true, trueName = "TinyTip"}
Mazzifier_AddOnInfo["WhoTip"] = {           index = 58,name="WhoTip", setupFunc="Setup_WhoTip", lastUpdate=0.60, global = true, trueName = "WhoTip"}
Mazzifier_AddOnInfo["WitchHunt"] = {        index = 59,name="WitchHunt Spell Alerts", setupFunc="Setup_WitchHunt", lastUpdate=0.60, global = true, trueName = "WitchHunt"}
Mazzifier_AddOnInfo["XCalc"] = {            index = 60,name="XCalc", setupFunc="Setup_XCalc", lastUpdate=0.60, global = false, trueName = "xcalc"}
Mazzifier_AddOnInfo["XRS"] = {              index = 61,name="XRaid Status Monitor", setupFunc="Setup_XRS", lastUpdate=0.60, global = true, trueName = "XRS"}
Mazzifier_AddOnInfo[62] = { index = 62, name=""}
Mazzifier_AddOnInfo[63] = { index = 63, name=""}
Mazzifier_AddOnInfo[64] = { index = 64, name=""}
Mazzifier_AddOnInfo[65] = { index = 65, name=""}
Mazzifier_LastAddonButtonNum = 61

Mazzifier_RemovedAddOns = { "KC_ScheduleKeep", "SM_PlayerMenu", "ImprovedAssist", "AF_ToggleBags", "Gryffon", "Titan", "GhostBarMod", "TellTarget", "KC_AutoRepair", "AutoMount", "SpecialEvents", "ChatCast2", "KC_EnhancedTrades", "Fubar_RecapFu", "KeepItCool", "SortEnchant", "AceNameToggle", "ChatFrameFix", "Metamap", "PeriodicTable", "Notebook", "MetaMap", "MailSound", "RaidFrameKiller", "FuBar_KungFu", "AceHeal", "AutoShoutOut", "DuelINspect", "Reputation", "ReURL", "EquipCompare", "ChatFrameExtender", "CleanChat", "CT_RaidAssist", "Teknicolor"}

Mazzifier_ConflictAddOns = {"Framerate_Adjuster", "AutoMake", "rSelfCast", "FilterTradeSkill", "Kalented", "AuctionIt", "OpenBags", "HitsMode", "Catalyst", "AceAccept", "ABInfo", "SpellAlert", "TipBuddy", "Lootster", "Decursive", "MobileFrames", "FuBar_RestFu", "ChatFrameFix", "FuBar-compat-1.0", "FuBarPlugin-1.2", "CleanChat", "ChatFrameExtender", "CT_MailMod", "AceHeal", "vChat"}


Mazzifier_CurrentPartVersions = {}
Mazzifier_CurrentPartVersions.Layout = 0.70
Mazzifier_CurrentPartVersions.Buttons = 0.70
Mazzifier_CurrentPartVersions.Addons = 0.60
Mazzifier_CurrentPartVersions.AddonSelection = 0.70
Mazzifier_CurrentPartVersions.Bindings = 0.70

Mazzifier_ButtonInfo = {}
Mazzifier_ButtonInfo[1] = {name="Basic Layout", devname= "Generic", image="Simple", profileName = "MazzleUI-Generic", classes = "All", lastUpdate=0.7, 
                           setupFunc125="Setup_DAB125", setupFunc133="Setup_DAB133", setupFunc16="Setup_DAB16", sasFunc="Setup_SAS_Basic",
                           description="|CFFFFFFFFFour bars.  Top right bar has pages, somewhat similar to the default blizzard bar.  This layout is nice for users who would prefer a simple setup or are accustomed to the Blizzard one.  It's also a good starting point for making your own layout.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Use Shift-~ to get on your mount.  Use Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs.\n\nThis layout does not drop spells into the buttons, so you must organize and do that yourself."}

Mazzifier_ButtonInfo[2] = {name="Big Button Basic Layout", devname= "GenericBig", image="BigButton", profileName = "MazzleUI-GenericBig", classes = "All", lastUpdate=0.7, 
                           setupFunc125="Setup_DAB_Big_125", setupFunc133="Setup_DAB_Big_133", setupFunc16="Setup_DAB_Big_16", sasFunc="Setup_SAS_Big",
                           description="|CFFFFFFFFThis layout is the same as the simple layout except with fewer buttons that are far larger.  This is especially useful for users on smaller screens or at 1.25 aspect ratio.  This layout has four bars.  The top right bars has pages, somewhat similar to the default blizzard bar.  This layout is nice for users who would prefer a simple setup or are accustomed to the Blizzard one.  It's also a good starting point for making your own layout.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Use Shift-~ to get on your mount.  Use Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.\n\nThis layout does not drop spells into the buttons, so you must organize and do that yourself."}

Mazzifier_ButtonInfo[3] = {name="Mazzlefizz's Mage Setup", devname= "MageMazzle", image="Mage", profileName = "MazzleUI-Mage", classes = "Mage", lastUpdate=0.7, 
                           setupFunc125="Setup_DABMage125", setupFunc133="Setup_DABMage133", setupFunc16="Setup_DABMage16", sasFunc="Setup_SAS_MageMazzle",
                           description="|CFFFFFFFFMazzlefizz's setup for a mage.  Works for any spec and handles all talented abilities. You can access all of your combat abilities with your left hand staying the WASD keys.  Click the fire/frost button to quickly switch to your secondary element for vulnerability based mobs (just makes the actions in two bars switch, making the bindings easier).  The single bottom left button is to apply a wizard oil to your weapon in one click.  Do not put other items in there. \n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  F1 can be used to fire your wand (no button wasted on it :D).  Shift-~ will mount up. Shift-Mousebutton 4 or Shift-MiddleMouseButton accesses the context menu.  You'll find all of your portals and conjuring spells in the first page of the context menu.  You can put skills and so forth in the second page."}

Mazzifier_ButtonInfo[4] = {name="Mazzlefizz's Priest Setup", devname= "PriestMazzle", image="Priest", profileName = "MazzleUI-Priest", classes = "Priest", lastUpdate=0.7, 
                           setupFunc125="Setup_DABPriest125", setupFunc133="Setup_DABPriest133", setupFunc16="Setup_DABPriest16", sasFunc="Setup_SAS_PriestMazzle",
                           description="|CFFFFFFFFHealing/Damage on the right, buffs/psychic abilities on the left.  Automatic smart-targeting on healing and buff spells. Healing bar and damage bar quickly swappable depending on context of situations via the Offensive/Defensive buttons.  Handles all talent builds including shadow.  Also incorporates all priest racials.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Alt-~ can be used to fire your wand (no button wasted on it :D).  Shift-~ will mount up.  Use Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[5] = {name="Mazzlefizz's Warlock Layout", devname= "WarlockMazzle", image="Warlock", profileName = "MazzleUI-Warlock", classes = "Warlock", lastUpdate=0.7, 
                           setupFunc125="Setup_DABWarlock125", setupFunc133="Setup_DABWarlock16", setupFunc16="Setup_DABWarlock16", sasFunc="Setup_SAS_WarlockMazzle",
                           description="|CFFFFFFFFBar on the right categorized by offensive, drain, AOE, offensive specials requiring shards and curses.  Bars on the left categorized by buffs, fearing, demon CC, and hp/mana conversion.  Pet bar on the left.  Layout handles all talent specs.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Shift-~ will summon your mount.  Use F1 to shoot your wand.  Shift-Mousebutton 4 or Shift-MiddleMouseButton accesses the context menu, where you'll find all of your conjuring and summon spells.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[6] = {name="Mazzlefizz's Hunter Layout", devname= "HunterMazzle", image="Hunter", profileName = "MazzleUI-Hunter", classes = "Hunter", lastUpdate=0.7, 
                           setupFunc125="Setup_DABHunter125", setupFunc133="Setup_DABHunter133", setupFunc16="Setup_DABHunter16", sasFunc="Setup_SAS_HunterMazzle",
                           description="|CFFFFFFFFAttack bar changes pages between melee and ranged depending on distance to target.  Handles all talent specs and racials.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Use Alt 1-0 for your pet bar abilities. Use Shift-~ to mount up. Use Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[7] = {name="Mazzlefizz's Druid Layout", devname= "DruidMazzle", image="Druid", profileName = "MazzleUI-Druid", classes = "Druid", lastUpdate=0.7, 
                           setupFunc125="Setup_DABDruid125", setupFunc133="Setup_DABDruid16", setupFunc16="Setup_DABDruid16", sasFunc="Setup_SAS_DruidMazzle",
                           description="|CFFFFFFFFThree main bars on the right that change based on form: Healing (1-5), Offensive (Alt-1 - Alt-5), Specials (Z, X, C).  Extra bar with lower level heals on right also.  Left bars contain crowd control, cleansing and buffing spells.  Handles all specs.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Shift 1-4 to shift forms.  Shift-~ to mount up. ~ to root.  Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[8] = {name="Mazzlefizz's Rogue Layout", devname= "RogueMazzle", image="Rogue", profileName = "MazzleUI-Rogue", classes = "Rogue", lastUpdate=0.7, 
                           setupFunc125="Setup_DABRogue125", setupFunc133="Setup_DABRogue133", setupFunc16="Setup_DABRogue16", sasFunc="Setup_SAS_RogueMazzle",
                           description="|CFFFFFFFFFive combat bars on the right.  One bar changes based on stealth (F1-F4).  Main bar for all combo point generating moves (1-6).  Second combat bar below that with all finishing moves (Alt-1 - Alt-5).  One bar for base skills on cooldown like Evasion, Blind, Sprint (X, V, T, Z).  Another bar for talent-based skills on cooldown (R, C, G).  Miscellaneous skills in the left bars.  Bottom left bar is a poison and sharpening stone bar.  Left-click items in that bar to apply to left weapon.  Right-click to apply to right weapon.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF ~ to stealth. Shift-1 to shoot weapon.  Shift-~ to mount. Shift-Mousebutton 4 or Shift-MiddleMouseButton accesses the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[9] = {name="Mazzlefizz's Paladin Layout", devname= "PaladinMazzle", image="Paladin", profileName = "MazzleUI-Paladin", classes = "Paladin", lastUpdate=0.7, 
                           setupFunc125="Setup_DABPaladin125", setupFunc133="Setup_DABPaladin16", setupFunc16="Setup_DABPaladin16", sasFunc="Setup_SAS_PaladinMazzle",
                           description="|CFFFFFFFFBars categorized by Healing, Cleansing, Offensive, Offensive Undead, Self Buffs, Seals and Auras.  Includes three-paged blessings box with index buttons.  Also has an offensive/defensive buttons to quickly switch hotkeys for main spells depending on your current role.  Handles all talent specs.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF   Shift 1-7 for seals. Hit G to judge your seal.  Ctrl 1-6 for various blessings. 1-6 for healing/clean abilities, alt 1-6 for offensive abilities.  Hit offensive button to switch those bindings.  Use Shift-~ to mount up.  Use Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[10] = {name="Mazzlefizz's Shaman Layout", devname= "ShamanMazzle", image="Shaman", profileName = "MazzleUI-Shaman", classes = "Shaman", lastUpdate=0.7, 
                           setupFunc125="Setup_DABShaman125", setupFunc133="Setup_DABShaman16", setupFunc16="Setup_DABShaman16", sasFunc="Setup_SAS_Shaman",
                           description="|CFFFFFFFFOffensive and healing spells on the right.  Bars organized by attacks, shocks, heals, cleanses and buff.  Has an offensive/defensive buttons to quickly switch hotkeys for main spells depending on your current role.  Totems on the left organized by offensive, combat, heal/cleansing, and buffs.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  1-7 for attacks and shocks.  Alt 1-6 for heals and cleanses.  Use Shift-~ to mount up.  Shift-Mousebutton 4 or Shift-MiddleMouseButton accesses the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[11] = {name="Joypunk's Warrior Layout", devname= "WarriorJoyluck", image="Warrior", profileName = "MazzleUI-Warrior", classes = "Warrior", lastUpdate=0.7, 
                           setupFunc125="Setup_DABWarriorJoyluck125", setupFunc133="Setup_DABWarriorJoyluck16", setupFunc16="Setup_DABWarriorJoyluck16", sasFunc="Setup_SAS_WarriorJoyluck",
                           description="|CFFFFFFFFThis layout was designed for quick and easy access to every ability that a Warrior has. Ideally, your left hand will never have to leave the WASD keys.\n- Overpower and Execute on one easy button. The Overpower ability will replace the Execute ability whenever your opponent Dodges an attack. The moment you use Overpower or 4 seconds after the opponent's Dodge, the button will return to the Execute ability.\n- Every bar in every stance arranged in use order.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Stance changing is done with F2-F4.  Shoot with F1. Shouts are done with Z, X, C, V, G.   use Shift-~ to mount up.  Use Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there. It keeps your UI cleaner and reduces computational costs."}

Mazzifier_ButtonInfo[12] = {name="Simple Rogue Layout", devname= "RogueSimple", image="RogueSimple", profileName = "MazzleUI-SimpleRogue", classes = "Rogue", lastUpdate=0.7, 
                           setupFunc125="Setup_DABRogueSimple125", setupFunc133="Setup_DABRogueSimple133", setupFunc16="Setup_DABRogueSimple16",  sasFunc="Setup_SAS_SimpleRogue",
                           description="|CFFFFFFFFFour bar setup.  Main bar on top-right changes based on stealth (1-10).   Bottom left bar is a poison and sharpening stone bar.  Left-click items in that bar to apply to left weapon.  Right-click to apply to right.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF ~ to stealth. Shift-~ to mount. Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs.\n\nThis layout does not drop spells into the buttons, so you must organize and do that yourself."}

Mazzifier_ButtonInfo[13] = {name="Simple Warrior Layout", devname= "WarriorSimple", image="WarriorSimple", profileName = "MazzleUI-SimpleWarrior", classes = "Warrior", lastUpdate=0.7, 
                           setupFunc125="Setup_DABWarriorSimple125", setupFunc133="Setup_DABWarriorSimple133", setupFunc16="Setup_DABWarriorSimple16", sasFunc="Setup_SAS_SimpleWarriorDruid",
                           description="|CFFFFFFFFBasic four-bar setup.  Top right bar pages based on stance.  Racial buttons on the bottom left.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Change stances with Z, X, C.  Main bar is 1-0, second bar is Alt-1 - Alt-0, third bar is F1-F12, and fourth bar is Shift-1 - Shift -0.  Racial skill is R. Shift-~ mounts.  Shift-Mousebutton 4 or Shift-MiddleMouseButton accesses the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs.\n\nThis layout does not drop spells into the buttons, so you must organize and do that yourself."}

Mazzifier_ButtonInfo[14] = {name="Simple Druid Layout", devname= "DruidSimple", image="DruidSimple", profileName = "MazzleUI-SimpleDruid", classes = "Druid", lastUpdate=0.7, 
                           setupFunc125="Setup_DABDruidSimple125", setupFunc133="Setup_DABDruidSimple133", setupFunc16="Setup_DABDruidSimple16", sasFunc="Setup_SAS_SimpleWarriorDruid",
                           description="|CFFFFFFFFSimple four bar setup. Top right bar pages based on form.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF  Shift 1-4 to shift forms.  Shift-~ mounts.  Shift-Mousebutton 4 or Shift-MiddleMouseButton accesses the context menu.  Put non-combat abilities, trade skills, miscellaneous items, etc. there.  It keeps your UI cleaner and reduces computational costs.\n\nThis layout does not drop spells into the buttons, so you must organize and do that yourself."}

Mazzifier_ButtonInfo[15] = {name="Durzil's Shaman Layout", devname= "ShamanDurzil", image="ShamanDurzil", profileName = "MazzleUI-Shaman", classes = "Shaman", lastUpdate=0.7, 
                           setupFunc125="Setup_DABShamanDurzil16", setupFunc133="Setup_DABShamanDurzil16", setupFunc16="Setup_DABShamanDurzil16", sasFunc="Setup_SAS_ShamanDurzil",
                           description="|CFFFFFFFFAlternate version of Mazzlefizz's Shaman layout.  Layout organised by type of attack and then further organised by which element it uses or usefulness. Offensive and healing/cleansing spells on the right side of the layout along with pvp/damaging/misc totems spells along the bottem. The left side of the layout has your weapon buffs and totems.\n\n|CFF00FF00Key Binding Notes:|CFFFFFFFF 1-6 for attacks and shocks. Shift 1-6 for heals and cleanses. Ctrl-0 for common totems. Alt 1-6 for healing/cleansing totems. Hit ` for Ghostwolf, Z for Racial ability and F for Lighting Sheild. Use shift-~ to mount up. F1-F4 for weapon buffs. Shift-Mousebutton 4 or Shift-MiddleMouseButton to access the context menu. Put all non-combat abilities, trade skills, miscellanous items, ect there. It keeps your UI cleaner and reduces computational costs."}

Mazzifier_DefaultLayout = {}
Mazzifier_DefaultLayout["Mage"] = "MageMazzle"
Mazzifier_DefaultLayout["Priest"] = "PriestMazzle"
Mazzifier_DefaultLayout["Warlock"] = "WarlockMazzle"
Mazzifier_DefaultLayout["Rogue"] = "RogueMazzle"
Mazzifier_DefaultLayout["Druid"] = "DruidMazzle"
Mazzifier_DefaultLayout["Shaman"] = "ShamanMazzle"
Mazzifier_DefaultLayout["Hunter"] = "HunterMazzle"
Mazzifier_DefaultLayout["Paladin"] = "PaladinMazzle"
Mazzifier_DefaultLayout["Warrior"] = "WarriorJoyluck"

Mazzifier_WelcomeText = "|CFFFFFFFFMazzlefizz of Argent Dawn here! \n\nPrepare to experience the latest in gnomish UI ingenuity.  Make absolutely sure you've read the instructions or this process may turn out a little more goblin-ish (think Boom!)\n\n|CFF00FF00(1) Make sure to change your resolution first in the video option.|CFFFFFFFF  Hit escape to access video options.\n|CFF00FF00(2) Go through the other pages of this window and answer all the questions honestly.|CFFFFFFFF  It has a built-in lie detector, so be careful.  You will be shocked if you answer dishonestly.  Make especially sure to choose a button layout that you like.\n|CFF00FF00(3) Hit the Mazzify button below|CFFFFFFFF In a few moments, a second button should appear.  Click that and wait until it reloads your UI.\n\n|CFFFF0000Warning:|CFFFFFFFF  When you are done, you should repeat this process for every one of your characters.  Unmazzified characters tend to get jealous of mazzified ones and may pull pranks on their UI's.\n\nOnce all your characters are set up, I suggest getting to know your UI.  Read every help entry in the MazzleOptions system and perhaps even browse the MazzleUI forums at |CFFFF8000http://Mazzlefizz.wowinterface.com|CFFFFFFFF.  Once you feel a little more comfortable with MazzleUI, start poking around and customizing it.  There's even a FAQ section to help you tweak things! When you're, go to the MazzleUI forums and give Mazzlefizz some feedback.  Enjoy!\n\n"

Mazzifier_UpgradeText = "|CFFFFFFFFGreetings once again, brave MazzleUI user!  Mazzlefizz of Argent Dawn here with important news.  Things have changed!  Updates are needed!  Warlocks should be nerfed.  But don't worry.  My gnomish know-how will help you through this...well, maybe not the Warlock part.\n\n|CFFFF8000A couple things to remember:\n\n|CFF00FF00(1)|CFFFFFFFF If you have customized your button layout and want to keep it, make sure to save it under a new profile before I begin my magic.  Or, if you're absolutely certain you don't want to try the latest and greatest button layout that Gnomeregan has to offer, then uncheck the 'Buttons' option in the next tab.  People who do so will receive their goblin-lovers membership card in the mail in 6-8 weeks.\n\n|CFF00FF00(2)|CFFFFFFFF The Add-On tab of this window will tell you exactly which add-ons need updating.  If it says that an add-on needs updating this means either (a) Gnomeregan has discovered better initial settings or (b) the add-on author modified the format or content of the settings.  So, while you *can* uncheck items here so that they're not updated, it's probably better that you let them get updated in case the format changed.  Moreover, if you changed your settings later and want to go back to the original MazzleUI settings, pull up this window with /mazzify and run it with only that add-on checked.\n\n"


