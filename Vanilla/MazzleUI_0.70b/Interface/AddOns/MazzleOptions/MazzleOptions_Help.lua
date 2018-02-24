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
local FAQSectionNum = 0
local FAQLastName = ""
local FAQQuestionNum = 0

function MazzleOptions_SetupHelp()
    MazzleOptions_HelpInfo = {} 
    MazzleOptions_HelpInfo.Contents = {} 
    
    MazzleOptions_Setup_HelpEntries()
    MazzleOptions_HelpInfo.NumTopics = table.getn(MazzleOptions_HelpInfo.Contents)

end

function MazzleOptions_SetupSeperator(sectionName)
    local addItem, tempItem = {}, {}

    addItem.name = " "..sectionName.." "
    addItem.tooltipText = ""
    addItem.num = 0
    table.insert(MazzleOptions_HelpInfo.Contents, addItem)
end

function MazzleOptions_Setup_FAQ_Question(isQuestion, question, answer, tooltipText)

    local addItem, tempItem = {}, {}
    FAQQuestionNum = FAQQuestionNum + 1
    if (isQuestion) then
        addItem.name = "|CFF00FF00"..FAQSectionNum.."."..FAQQuestionNum.."|r. "..question
    else
        addItem.name = question
    end
    addItem.tooltipText = tooltipText or ""

    if (isQuestion) then
        tempItem = {
            type = "Textbox", 
            text = "|CFF00FF00FAQ Section "..FAQSectionNum..": "..FAQLastName..", Question "..FAQQuestionNum..":|r\n\n|CFFFF8000"..string.gsub(question, "\n", " "),
            width = "full",
        }
        table.insert(addItem, tempItem)
    end
    
    tempItem = {
        type = "Notebox", notetype = "none",
        text = answer,
        width = "full",
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_HelpInfo.Contents, addItem)
end

function MazzleOptions_NewFAQSection(sectionName)
    FAQSectionNum = FAQSectionNum + 1
    FAQQuestionNum = 0
    FAQLastName = sectionName
    MazzleOptions_SetupSeperator("|CFF00FF00FAQ Section "..FAQSectionNum..":|CFFFF8000 "..sectionName)
end

function MazzleOptions_Setup_HelpEntries()

    local addItem, tempItem = {}, {}

    addItem.name = "What is MazzleUI?"
    addItem.tooltipText = "Overview of the features of MazzleUI"

    tempItem = {
        type = "Notebox", notetype = "none", width = "full",
        text = "What is |cFF0000FFMazzleUI|r?\n\nIn short it's a comprehensive, customized user interface for the World of Warcraft that attempts to be clean, symmetrical, provides lots of information, use minimal space and be highly efficient.  It is extremely easy to set-up, use and learn.  It is a compilation with a several custom add-ons and many modified ones.  Some of the key features are as follows:\n\n|cFFFF0000(1)|cFF00FF00 Original artwork|r:  Elven metal-work theme.  More themes may be added in the future.\n\n|cFFFF0000(2)|cFF00FF00 'Mazzifier'|r: This is an in-game installer addon that provides incredibly easy setup. It configures everything for you in a few easy steps.\n\n|CFFFF8000  (a) -->|r It does NOT require you to copy a makeshift WTF folder and rename things like most compilations do.\n\n|CFFFF8000  (b) -->|r Configures the position and size of every UI element, including the artwork for nearly any resolution (anything that has an aspect ratio of 1.25, 1.33 or 1.6.)  You should not have to adjust anything to make it look like the screenshots.\n\n|CFFFF8000  (c) -->|r Configures every add-on to be ready to use out of the box. You don't have to learn the ins and outs and settings of a million add-ons to get started.  The settings were chosen with efficiency in mind.\n\n|CFFFF8000  (d) -->|r Maintains an internal database of version numbers so that new version of MazzleUI will know exactly what to update.  Just drop in the new version, the Mazzifier will automatically launch when you log in and update what is necessary.\n\n|CFFFF8000  (e) -->|r Asks the user a series of question so that it will enable ONLY those add-ons that the user is interested in. This allows the UI to be tailored to each individual character to minimize cpu/memory use.\n|CFFFF8000     --> (1)|r Four different base install packages\n|CFFFF8000     --> (2)|r A variety of class-specific add-ons only installed for the appropriate classes\n|CFFFF8000     --> (3)|r A variety of add-ons marked as 'expensive', that will only be installed if the user requests it.\n\n|CFFFF8000  (f) -->|r Allows the user to visually browse 15 different button layouts and choose the one that fits their play style best.\n|CFFFF8000     --> (1)|r There are multiple button layouts for each class.  All button layouts follow a consistent design philosophy.\n|CFFFF8000     --> (2)|r Each button layout has versions for different screen sizes.  It will automatically install the appropriate one for your resolution.\n|CFFFF8000     --> (3)|r The majority of the button layouts will also automatically place your spells and skills in the appropriate buttons, regardless of what level your characters are at.\n|CFFFF8000     --> (4)|r Every layout will automatically place your trade skills and racial abilities.\n|CFFFF8000     --> (5)|r Layouts can be refreshed as you gain new abilities and spells so that they always have the correct levels.\n\n|CFFFF8000  (g) -->|r Creates and configures all seven chat frames to contain the right channels with sensical and consistent ordering and nice text coloring. This includes multi-framed combat information with slim damage frame and formatted and colored combat log.\n\n|CFFFF8000  (h) -->|r Warns the user of conflict add-ons and other potential problems.\n\n|CFFFF8000  (i) -->|r Allows the user to reconfigure any aspect of their UI back to the install settings to undo changes or problems."
    }
    table.insert(addItem, tempItem)
        
    tempItem = {
        type = "Notebox", notetype = "none", width = "full",
        text = "|cFFFF0000(3)|cFF00FF00 MazzleUI Core Add-on|r: A central add-on that provides a host of new UI features and integrates many of the add-ons into a more coherent UI.  It provides the following:\n\n|CFFFF8000  (a) -->|r 'HotSpots': A novel space-saving feature where certain hidden areas of the bottom pane artwork function as buttons. Some components turn into visibly different buttons when certain actions are available. This provides extra functionality and information presentation with zero additional space usage. There are 13 such hidden HotSpots that let you quickly access a myriad of functions. \n|CFFFF8000     --> (1)|r Six corner HotSpots that pull up or hide commonly used add-ons: KCItems loot database, MonkeyQuest quest tracker, TinyPad notebook, the MazzleUI context menu, ItemRack and xCalc.\n|CFFFF8000     --> (2)|r The coordinates under the minimap serve as a HotSpot to open up AlphaMap, the world and instance map add-on.\n|CFFFF8000     --> (3)|r The area under your target box serves as a HotSpot to target your ToT, i.e. the target of your target. \n|CFFFF8000     --> (4)|r The four corners of the target box serve as hotspot to perform actions on your target, namely whispering, following, trading and inspecting.  Actual buttons will appear there when those actions are available.\n|CFFFF8000     --> (5)|r The actual MazzleUI logo text is a HotSpot that does two things.  Left-clicking on it brings up the bag and micro-menu bars.  This allows them to stay hidden most of the time, saving even more room. Right-clicking on the same text hot-swaps you through 15 different party/raid layouts.\n\n|CFFFF8000  (b) -->|r Hot-Swappable Raid Layouts: \n|CFFFF8000     --> (1)|r 15 different raid layouts are available that can be changed at any time.\n|CFFFF8000     --> (2)|r Automatically takes other elements of the UI into account: the size of your screen, whether party frames are visible, whether party pets are visibile, etc.\n|CFFFF8000     --> (3)|r Automatically redistributes raid frames when in a 20 or 10 man raid group to make the layout more symmetrical.\n\n|CFFFF8000  (c) -->|r 5 MazzleUI Efficiency Modes:  A novel feature that allows the UI to automatically turn off certain features and complete add-ons depending on the context of the situation to improve performance.\n|CFFFF8000     --> (1)|r There are four modes that can be set to automatically kick in when you are either (1) solo, (2) in a party, (3) in a raid or (4) pvp-flagged.\n|CFFFF8000     --> (2)|r This is one manual mode that is activated when you press the MazzleUI Efficiency button.  This allows you the UI to set everything to minimum for unexpectedly demanding situations or encounters.\n|CFFFF8000     --> (3)|r The efficiency modes can currently module 12 different items: (1) graphical settings, (2) 3d animation, (3) damage meter tracking, (4) name tags and name plates, (5) FastCast, (6) BigWigs, (7) Scrolling Combat Text, (8) Scrolling Combat Text Damage, (9) Scrolling Combat Text Cooldowns, (10) Witchhunt spell alerts, (11) button visibility, and (12) Discord add-ons OnUpdate rate.  More items will be added, for example spell effect level.\n\n|CFFFF8000  (d) -->|r Several simple automations: auto resurrection, auto summon acceptance, auto-dismounting at flight paths\n\n|CFFFF8000  (e) -->|r Context menu management:  A set of buttons that are normally hidden but can be pulled up under your mouse at any time.  Perfect for keeping non-combat stuff and trade skills out of the way.  Will automatically hide when used or when logging in.\n\n|CFFFF8000  (f) -->|r 2 special minimap buttons to quickly interface to certain add-ons that don't provide them: (1)  a Recap button that you can use to toggle visibility or turn on/off the add-on and (2) a similar FastCast button.\n\n|cFFFF0000(4)|cFF00FF00 MazzleOptions|r: A centralized options and help system that offers unprecedented information and control of your add-ons.\n\n|CFFFF8000  (a) -->|r Descriptions of every single add-on in the system\n\n|CFFFF8000  (b) -->|r GUI controls to change the settings of every add-on in the system, even for add-ons that don't provide graphical options.  You never have to learn slash commands again.\n\n|CFFFF8000  (c) -->|r Ability to disable or enable add-ons in-game with one quick click.\n\n|CFFFF8000  (d) -->|r Everything is organized by both category and alphebetically.  It is extremely easy to find the add-on you're looking for.\n\n|CFFFF8000  (e) -->|r A comprehensive in-game FAQ system, with tons of help documents.\n\n|CFFFF8000  (f) -->|r Several value-added options for add-ons that aren't originally part of the add-ons.  For example, one click locking or unlocking of all DAB bars, automatic hiding of resurrection monitors, etc.\n    \n|cFFFF0000(5)|cFF00FF00 MazzleHUD|r: A custom, low-cost, clean-looking heads-up display that shows up when in combat.  Both the code and artwork are original.  Is configurable via MazzleOptions.\n\n|cFFFF0000(6)|cFF00FF00 Mazzle 3D Characters|r: Custom 3d model add-on that is probably the most bug-free and feature-rich 3d model add-on out there. Seamlessly integrated within the rest of the UI.\n\n|CFFFF8000  (a) -->|r Every single model in the game, including bosses, will be displayed correctly.  It uses a comprehensive database of cameras to insure this.\n\n|CFFFF8000  (b) -->|r Self, pet, party and party pet members are presented as 3-d models on a pedestal.\n\n|CFFFF8000  (c) -->|r These models animate depending on context of events. For example, they flinch when hit and fall when killed. They may also laugh when tickled and give you a wave or rude gesture from time to time.\n\n|CFFFF8000  (d) -->|r Target model can be zoomed, panned and rotate to get a better view.  Self and party models can be rotated on their pedestal.\n\n|CFFFF8000  (e) -->|r Models will correctly change when forms changes and readjust the cameras appropriately.\n\n|cFFFF0000(7)|cFF00FF00 Enhanced add-ons|r: Many third-party add-ons in the package are modified to add features, increase performance, allow options to be changed more easily or, in some cases, to correct bugs.  There are 24 such add-ons.\n__________________________________________________________________\n\nIn general, the package tries to follow the following guidlines:\n\n|cFF00FF00Layout philosophy|r: Minimalistic space usage while still presenting all the information one could need in game.\n\n|CFFFF8000-->|r Middle of bottom pane is minimal height to hold minimap. Side of bottom pane is minimum height to hold 16 lines of chat text.\n\n|CFFFF8000-->|r Play area is resized so that the UI covers a minimal amount of the rendered game.\n\n|CFFFF8000-->|r Even with 3d party models or 40 raid frames, most of screen is completely unobstructed (Screenshot)\n\n|CFFFF8000-->|r Nearly every element in the UI has positioning information to maintain this design philosophy.\n\n|cFF00FF00Add-On philosophy|r: Useful add-ons that are highly efficient.  The majority of the add-ons are Ace add-ons, including the custom MazzleUI ones.\n"
    }
    table.insert(addItem, tempItem)

    addItem.num = table.getn(addItem)
    table.insert(MazzleOptions_HelpInfo.Contents, addItem)
    
    MazzleOptions_Setup_FAQ_Question( flase,
        -- Question
        "Welcome to |cFF006699MazzleUI|r",
        -- Answer
        "|CFF00FF00Mazzlefizz of Argent Dawn here!|CFFFFFFFF \n\nNow that you have your new UI installed here is what you should do.  It can be a bit overwhelming at first, especially if you're not used to some of the add-ons.\n\n|CFFFF0000(1)|CFFFFFFFF If you haven't installed it on your other characters, I recommend doing that first.\n\n|CFFFF0000(2)|CFFFFFFFF Check you video and interface settings.  Fine tune them to your preferences.  Since you just did a clean install, the video settings and stuff like the camera following mode may be different than what you have been using before.  The video settings in particular may affect performance, so make sure to check before concluding that there's a problem with the UI.\n\n|CFFFF0000(3)|CFFFFFFFF Click on the button with the 'M' on it.  This will open up the extensive |CFF00FF00MazzleOptions|CFFFFFFFF system.  Each and every add-on has a description and controls to change its options.  It's a great way to learn exactly what everything does.  You can also customize things to your preferences and disable things you don't use.  I'd recommend not making many, if any, changes at first.  Give it some time, and see what you like and find useful.\n\n|CFFFF0000(4)|CFFFFFFFF Browse the key bindings.  Again, I'd give these a try for a while before changing them.  While some may seem very different and counter-intuitive to you, there are usually very intentional design decisions behind.  For example, many of the interface panels are now open through ctrl-key combinations.  This frees up the non-modified keystroke that are near the WASD keys for skills thats need to be accessed quickly, like those used in battle.\n\n|CFFFF0000(5)|CFFFFFFFF  Browse these help documents and start playing around!  I |cFFFF0000HIGHLY|r recommend that you read every FAQ entry, especially the ones on customizing efficiency modes.\n\nHope you enjoy the UI!",
        "This category contains general new user orientation.")

    MazzleOptions_Setup_FAQ_Question( false,
        -- Question
        "Known Bugs",
        -- Answer
        "|CFFFF8000MazzleUI/Mazz3D/Mazzifier Bugs|r\n\n- Chatframe 1 reminder button doesn't show until you switch chat frames at least once.  This is probably related to the Blizzard bug where the chat frame focus is on the last user created chat frame upon login, instead of chat frame 1, where it's supposed to be.\n\n- What is displayed in the combat log needs tweaking for various classes.\n\n- DAB error when you switch button layouts for a Mazzification (does not seem to have any impact after reload)\n\n- When blizzard floating combat text show periodic damage setting is disabled, you don't see any blizzard aoe damage in left combat log.\n\n- Dead dwarf 3d models animation flickers.\n\n|CFFFF8000Third-Party Add-On Bugs|r\n\n- Clicking exit in recap options produces Error: Interface\AddOns\Recap\Recap.lua:262: attempt to call method `UnregisterAll' (a nil value)\n\n- Scanning AH throws an error with AH filter (cannot reproduce)\n\n- Gfxt keeps saying that an update is needed when logging in\n\n- Target buttons doesn't work for whispering cross-server in a bg",
        "A list of all bugs currently reported"
    )

    MazzleOptions_Setup_FAQ_Question( false,
        -- Question
        "Recent Changes",
        -- Answer
        "|cFF0000FF MazzleUI|r 0.7 Changes\n\n|cFFFF0000- Feature Addition|r: MazzleOptions and MazzleHelp integrated into one add-on with a button to switch between the two modes.  I think it will be easier for users to see everything in one interface.  MazzleOptions code was also much better and more flexible.\n|cFFFF0000- Feature Addition|r: MazzleOptions now has an integrated FAQ system.  It automatically numbers sections/questions and presents questions and answers appropriately.\n|cFFFF0000- Feature Addition|r: TONS of new help and FAQ questions added to MazzleOptions help system.  All documents re-organized and rewritten.\n|cFFFF0000- Feature Addition|r: Mazzifier will now prompt the user to re-enable add-ons it needs to change the settings for.  Clicking yes will automatically enable all such add-ons and reload the UI.\n|cFFFF0000- Layout Change|r: Moved improved error frame button near other minimap buttons so certain button layouts have more room.\n|cFFFF0000- Feature Addition|r: MazzleUI will automatically adjust minimap buttons for add-ons that are disabled and aren't showing their buttons.\n|cFFFF0000- Bug Fix|r: You no longer will have problems clicking on links at the bottom of the general chat window.  Hid the resize edges of the chat frame.  (Thanks to Tigerheart for figuring it out)\n|cFFFF0000- Bug Fix|r: Fixed MonkeyQuest showing up in the middle left rather than top left in some aspect ratios\n|cFFFF0000- Bug Fix|r: Dots on you will show up in right combat log\n|cFFFF0000- Bug Fix|r: XRaidStatus should properly mazzify in all cases now\n|cFFFF0000- Feature Addition|r: Added auto dismounting at flight masters since it was lost when changing from FlightPath to ToFu.\n|cFFFF0000- Bug Fix|r: Divine Spirit fixed in NeedyList (credit to Tiger for the fix)\n|cFFFF0000- Add-On Set Change|r: Added SimpleCombatLog, Fubar Mail and BookofTracks to 'Minimal' set.\n|cFFFF0000- Settings Change|r: Turned buff timers on in Blizzard settings module.  (Don't know how/why it got to be off)\n|cFFFF0000- Settings Change|r: Fixed bindings of autobar buttons.  (new ace2 version changed things)\n|cFFFF0000- Feature Addition|r: Button layout browser will now only show layouts that are universal or applicable to your class.\n|cFFFF0000- Bug Fix|r: Clicking the 'Button Layout' checkbox in Mazzifier will not throw an illegal ID error\n|cFFFF0000- Feature Addition|r: Mazzifier now configures AtlasLoot settings\n|cFFFF0000- Settings Change|r: Necrosis now at 130%, purple skin, buffs on left and timers off.\n|cFFFF0000- Add-On Change|r: Replaced vChat and Teknicolor with Prat.\n|cFFFF0000- Button Layout Change|r:  All button layout descriptions updates and all new preview pictures in the Mazzifier.\n|cFFFF0000- Feature Addition|r: Mazzifier can now consider a list of spells when deciding what to put in a button! It will put the first item found from the list into the button.  It will also not put an item that it has already placed before.  Creating layouts that can handle multiple talent specs, character levels, racial abilities, etc. is much easier to do now.\n|cFFFF0000- Feature Addition|r: Added mount set to replace previous single mount binding in all layouts.  Considers all current mounts in the game.  You no longer have to learn how to use DAB to do drop your mount into slot 120.\n|cFFFF0000- Feature Addition|r: Added set of ALL tradeskills to three buttons in the context menu.  This should guarantee that everybody's trade skills show up right, including supporting skills like Disenchanting and Smelting.\n|cFFFF0000- Feature Addition|r: Added a racial skills set button to every layout.  All racial skills should show up now.  (Note|r: You may still need to add cannibalize to some of the layouts that didn't have room.)\n|cFFFF0000- Button Layout Change|r: All max spells changed to be several levels higher.  This means all layouts should properly place AQ and BC level spells.\n|cFFFF0000- Button Layout Change|r: DAB cooldown counts all turned off since OmniCC does them and a bit more\n|cFFFF0000- Button Layout Change|r: Changed context menu scripts in the button layouts to use options in MazzleOptions, so that it won't hide on click if you don't want it to.\n|cFFFF0000- Button Layout Change|r: Changed pet and shapeshift forms to have visible locations for all classes.  (for future use and special cases like Razorgore possession)\n|cFFFF0000- Feature Addition|r: New button layout, 'Big Buttons Simple'.  It's like the Simple layout, but with fewer buttons that are much larger.  Good for low resolution and/or 1.25 aspect ratio.\n|cFFFF0000- Add-On Selection Change|r: Enemy Cast Bar defaults to off.  (It's just too expensive)\n|cFFFF0000- Mage Layout|r:\n    - Fixed overlapping bars when certain skills are missing\n    - Cleaned up positioning of bars\n    - Combined combustion and arcane power into the same button (when mazzifying, not in general)\n    - Added multiple oil set for the oil button\n    - Added multiple polymorph set to the polymorph button\n    - Added blastwave to AOE bar\n    - Adjusted pet and shapeshift bar locations\n    - Added 1.33 version\n|cFFFF0000- Priest Layout|r:\n    - Fixed overlapping bars when certain skills are missing\n    - Cleaned up positioning of bars\n    - Added auto-applying oil button\n    - Now handles shadow spec spells\n    - Now handles Power Infusion, Lightwell and Divine Spirit\n    - Now handles all racial priest spells, not just Fear Ward.  Desperate prayer, Hex of Weakness, Starshards and Devouring Plague grouped in one button, while Feedback, Fear Ward, Shadowguard, Elune's Grace and Touch of Weakness is in another.\n    - Should be better for leveling.  Will place lesser heal and heal buttons in certain spots when you don't have greater heal or heal.  Will do the same for cure poison when you don't have abolish poison.\n    - Adjusted pet and shapeshift bar locations\n    - Added 1.33 version\n    - Fixed shoot wand binding\n|cFFFF0000- Hunter Layout|r:\n    - Changed range check to use wing clip.  Ranged bar will now show in all cases except when wing clip is in range.  (before melee would show when completely out of range of both melee and ranged weapons)\n    - Added missing Aspect of the Beast and ordered aspects based on levels you acquire them\n    - Feign death button moved so that it doesn't overlap pvp icon.  F5 binding added by request.\n    - Improved bindings\n    - Added Wyvern Sting, Counter-Attack and Trueshot Aura\n|cFFFF0000- Warlock Layout|r:\n    - Improved bindings\n    - Fixed overlapping bars when certain skills are missing\n    - Cleaned up positioning of bars.  Fixed overlap with bg queue icon\n    - Detect Greater Invisibility and Detect Lesser Invisibility merged into one button\n    - Demon Skin and Demon Armour merged into one button\n    - Added warlock mounts to mount sets so they'll install just like normal mounts and be bound to shift-~\n    - Reordered curses\n    - Reordered fears\n    - Shoot wand should properly work on F1\n|cFFFF0000Shaman Layout|r:\n    - Added combination Elemental Mastery/Stormstrike button\n    - Added Nature's Swiftness\n    - Added Mana Tide Totem\n    - Re-organized layout\n    - Improved bindings\n|cFFFF0000Shaman Durzil Layout|r:\n    - Added stormstrike, nature's swiftness and mana tide totems (spots for the latter two probably don't make sense, but I didn't want to mess with the layout)\n    - Cleaned up various layout problems (some anchors, overlapping battleground icon and gatherer, proper pet and shapeshift bar location)\n    - Note: Does not fit in 1.25 aspect ratio\n|cFFFF0000Rogue Simple Layout|r:\n    - Added racial buttons\n    - Added poison bar to the rogue simple layout\n    - Improved bindings\n    - Increased size of shapeshift bar, moved so that it won't overlap tracking or gatherer icons\n    - Fixed anchors\n|cFFFF0000Rogue Layout |r:\n    - Completely revamped.  Many fundamental changes.\n    - Added all missing talents\n    - Added 1.33 and 1.25 versions\n|cFFFF0000Paladin Layout|r:\n    - Fixed nil error when using the judgement keybinding\n    - Improved key bindings\n    - Added talents holy shock, repentance, divine favor, holy shield\n|cFFFF0000Joypunk's Warrior Layout|r:\n    - Fixed Execute/Overpower changing\n    - Removed faux stance shift bar\n    - Added Fury and Protection Talents (piercing howl, death wish, bloodthirst, last stand, concussion blow, and shield slam)\n    - Made keybindings more consistent with other layouts\n|cFFFF0000SimpleWarrior and Simple Druid Layouts|r:\n    - Added explicit racial skills buttons\n    - Added some action placements for trade skills, forms and stances (for keybindings)\n    - Rearranged bars to be consistent with other layouts (main bar is top right)\n    - Improved key bindings\n",
        "All new changes added to the current version of the UI"
    )

    MazzleOptions_Setup_FAQ_Question( false,
        -- Question
        "Credits/Discredits",
        -- Answer
        "|CFFFF8000Credits|r:\n\nFirst and foremost, a ton of credit must go to the many add-on authors whose work is in this package.  While there is a ton of value-added stuff, many modifications, and several of my own add-ons, this package would be meaningless without their collective contributions.  A special thank you to |CFFFF0000Lozareth, Gello, Kaelten|r and the rest of the Ace community.\n\nAnd of course, I have to thank the many testers who've helped along the way.  I'd like to specially thank four testers in particular:  |CFFFF0000Tigerheart, JoyPunk, Durzil|r and |CFFFF0000Vint|r.  Tigerheart came in late in the process, but he was invaluable in terms of bouncing ideas, finding bugs/fixes and making suggestions.  And in a way, he actually got me started on this whole thing in the beginning.  Joypunk (who recently organized the button layout review), Durzil and Vint have been dedicated testers since day one, staying active while most other testers eventually lost motivation.  Thank a lot guys for your many contributions.\n\nI'd also like to thank the other core testers:  |CFFFF0000Brieta, Dredlock, Endrian, Gneekappa, Grebis, Iljott, Kalazar, Kusanagi, Lilliana|r and |CFFFF0000Soron|r.  Some of you guys have been around since the beginning and all of you have been helpful at one point or another.\n\nAnd of course the newbie testers who recently joined: |CFFFF0000Brem, Flarin, Nadger, Nandy, Sgt Blunts, Sketch, Slyde, Sinnyil|r and |CFFFF0000Taniya|r.  Thank you for your feedback.\n\nAnd thanks to all the other testers along the way, especially the ones who participated in the tiresome original camera survey even though it ended up being something that wasn't used.  I'm sure I'll forget a lot of the names, but I do remember: |CFFFF0000Guvante, Stromson, Spectacumazing, SalmonElla, Quickbeam, Astos, Linra, Ispide, Chaze|r and |CFFFF0000SyrinxPriest|r.\n\nA big thank you to all the people who offered encouragement on the foums and even donations in some cases.  I sincerely appreciate your good will and gestures.\n\nAnd finally, a big thank you to |CFFFF0000Cairenn|r, for hosting the beta forums and enduring the 10 months of forum idiocy that accompanied this project\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n__________________________________________________________________\n\n|CFFFF8000Discredits|r:\n\nTo all the leech and run liars: you guys were a real disappointment.  Nonetheless, I'm not going to list all of your names.  If you are a tester but aren't listed above, you were probably one of the disingenuous people that just slowed the process down and made this project feel like a waste of time.\n\nAnd a big /spit to all the whiny little shits on the forums, who think they're smart because they can do the easiest things any retard can do, criticize and complain.  Yeah, I'm looking at you |CFFFF80C0ShibbyShaman, b1mmer, nvrsbr, Phukkit, Dsurion|r and the rest of you do-nothing leeches that made the development of this a far more unpleasant experience for both me and the WoWInterface admins than it needed to be. And a special fuck you to |CFFFF80C0Warrian|r and |CFFFF80C0Scito|r, two 'testers' who stole my work and distributed it to others.  You guys are true douchebags.",
        "The people who helped bring the UI to its current state\n(and the people who made it more of a PITA)"
    )

------------------------------------------------------
    MazzleOptions_NewFAQSection("Setup")
------------------------------------------------------

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "The text is way too tiny! Is something wrong?",
        -- Answer
        "As a gnome, Mazzlefizz has excellent vision.  Unfortunately, many of the lesser races seem to like bigger fonts than gnomes.  If so, you're in good company and do have options.  The first option is upgrading yourself to a gnome.  Unfortunately, Gnomeregan is still working out the kinks with the upgrades.  See leper gnomes for more information.\n\nThere is also an easier option.  When mazzifying, you can choose from three different font sets: Normal, Medium, and Mr. Magoo.  Simply choose another one.  Type '/mazzify' or use MazzleOptions to pull up the Mazzifier.\n\nThat said, if you're accustomed to running at a larger resolution and/or aspect ratio, I highly recommend trying the smaller sizes for a while. It may seem small since you're used to larger scale, but I suspect you may grow to like the increased information density/display.  Of course, if you're running at a lower resolution, have a fuzzy display, etc. and simply can't read what is in the chat windows, by all means change the font size."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I need to Mazzify again.  How do I pull up that\nwindow with the gorgeous gnome in it?",
        -- Answer
        "Ah, multiple Mazzlegasms.  I like your style.\n\nTo pull up the Mazzifier, type '/mazzify'.  You can also look in MazzleOptions under the 'Add-On Management'.  You'll find a button there that will open the Mazzifier."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I just Mazzified my low-level character.  The\nbuttons are weird.  There's just a few single\nbuttons scattered around.  That can't be right,\nis it?",
        -- Answer
        "Most of the layouts in the Mazzifier are designed for level 60 players.  The categorizations and compromises one makes to get their buttons to make sense at level 60 are far different than the ones they would make at a low-level when they have far fewer skills.  In all likelihood, the reason you have a bunch of scattered buttons is that you only have a couple skills for that bar's 'category'.\n\nFor low level characters, if the main layout doesn't work for you, I would recommend trying one of the 'Simple' layouts.  You can then organize your skills however you'd like.  You can go back to one of the more advanced layouts later, after your character progresses some."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I ran the Mazzifier, but the health bars on the\ntarget window and the bottom panel don't line up\nright.",
        -- Answer
        "Silly rabbit, you have Mazzified at the wrong aspect ratio.  If you have no idea what I'm talking about, it was one of the questions that the Mazzifier asked you when you first set up the UI.  Don't worry though.  This can be fixed quite easily.\n\nFirst make sure that you are at the desired resolution before you Mazzify. Pull up the mazzify window again by typing /mazzify.  Make sure that the aspect ratio (divide your screen width by your screen height) is correct and that both the 'Buttons' and 'Layout' options are checked.  Then click Mazzify.\n\nNote: If your aspect ratio is NOT 1.25, 133 or 1.6, something similar will also happen. There's nothing you can do about that other than start adjusting things manually.  I suggest choosing the closest aspect ratio that is lower than your true ratio."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I clicked the Mazzify button.  It showed an\nanimation of a gnome casting a spell, but nothing\nhappened.  Is Mazzlefizz forever trapped in time?",
        -- Answer
        "While a gnome's good looks are impervious to the passage of time, I don't think that's what is happening here.  You probably had some sort of error during the Mazzification process.  Odds are that it was related to goblin technology.  Look in the chat window for text that looks like an error message.  If you can't figure out why it happened, post the error in the MazzleUI forums and Gnomeregan will get on the case."
    )

------------------------------------------------------
    MazzleOptions_NewFAQSection("Orientation")
------------------------------------------------------

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "How do I access my bag slots or the main\nmenu bar?",
        -- Answer
        "Left-click on the 'MazzleUI' text at the top right of the bottom artwork. This will bring up your your bag slots and micro menu bar.  B is now bound to open all bags, so you typically do not have to ever show the bar except when you're replacing bags.\n\nIf you're trying to get your spell book, don't do it through the main menu bar.  Hit 'P' to pull up the Discord Spell Book, a much improved upgrade to the default spell book."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "What is this context menu I keep hearing\nabout and how do I use it?",
        -- Answer
        "The context menu is a set of 16 buttons arranged in a square that is hidden most of the time you are playing.  You can unhide it at any point by click Shift-Mousebutton4, Shift-MiddleMouseButton or by clicking the context menu HotSpot (middle right corner the MazzleUI bottom panel).  It will then appear under your mouse for quick access.\n\nThe context menu is an excellent place to put non-combat skills and spells.  It keeps things out of your way and makes your UI a little bit more efficient.  By default, the Mazzifier should put all of your trade skills and hearthstone in the context menu.  For some classes, it will also put things like conjuring or pet summon spells.  Remember that there are two pages to the context menu.  You can switch pages by using your mousewheel while over the context menu.\n\n|CFFFF8000Note:|r There are several options you can use to configure your context menu.  These options include whether the context menu auto-hides after you use something in it, whether the context menu moves to your mouse location, and whether the UI will automatically hide the context menu when you first log in.  These can all be accessed under the 'MazzleUI General Settings' category of MazzleOptions."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Is it true that there are some top secret,\nhidden areas in the UI that allow you to quickly\nget to or do certain things?",
        -- Answer
        "Yes.  In an effort to minimalize things on the screen, features have been added that allow you to quickly get to certain add-ons with adding more buttons or other clutter to your screen.\n\nFirst, there are 13 hidden 'HotSpots' you can click on.\n\n- Each of the 6 corners of the bottom panel artwork is a hot spot.  Mouse over them, and MazzleUI will tell you exactly what that HotSpot does.  For example, the middle right HotSpot will quickly show or hide your context menu, while the bottom left hotspot will pull up your item database.\n\n- The 7th HotSpot is is over the minimap coordinates at the very bottom of the screen.  Click on it to pull up the AlphaMap, the addon that provides world and instance maps.\n\n- The 8th hotspot is under the target box, right over the text that says the target name and what it is looking at.  Click there to select your target's target, i.e. the ToT.\n\n- The four corners of your target window also behave like HotSpots.  Four buttons will appear in those corners that allow you to quickly follow, trade, inspect or whisper your target.  These buttons will appear whenever you have a target selected and will become clickable when you are in the correct range of the respective action.\n\n- The thirteenth HotSpot is the MazzleUI logo.  Left click on it to show/hide your bags and the main menu bar.  Right-click on it to cycle through the hot-swappable raid layouts."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Eww.  Why does every line in my chat window\nstart with a very unattractive '@' symbol? I don't\nwant that!  Space is already at a premium.",
        -- Answer
        "The asterisk you see at the beginning of each line actually provides an essential ability that Blizzard chose, for some odd reason, to not provide. Namely, it allows you to cut and paste any arbitrary line of text.\n\nSimply click the asterisk and you will be presented with an editbox from which you can copy the text.  The standard Windows copy and paste bindings will work in that or any edit box, namely Ctrl-C for Copy, Ctrl-X for Cut, and Ctrl-V for Paste.\n\nIf you really don't want this feature, disable the add-on EasyCopy."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I've heard you mention efficiency modes\nseveral times now.  What the hell are you talking\nabout?",
        -- Answer
        "MazzleUI has a novel feature that allows it to automatically turn off certain features (and even complete add-ons), depending on the situation you are in to improve performance.  So how does it work?\n        \nFirst, you have to understand |cFFFF8000what|r efficiency mode can turn off. Currently, it can modulate 12 different items:\n  \n  |CFFFF0000(1)|CFF00FF00 Video settings|r: It uses gfxToggle to switch between high graphics settings and low ones.\n  |CFFFF0000(2)|CFF00FF00 Animation of the 3d models|r:  It will turn off flinching and othere model animations in Mazz3D.\n  |CFFFF0000(3)|CFF00FF00 Damage meters|r: It will turn Recap combat monitoring off.  In the future, this may be extended to SWStats and DamageMeters.\n  |CFFFF0000(4)|CFF00FF00 Name tags and name plates|r:  It will switch off name tags and name plates.  You can set exactly which ones will be shown in MazzleOptions.\n  |CFFFF0000(5)|CFF00FF00 FastCast|r: It will turn ON FastCast.  Use this only if you expect to have high latency in the situation that it's on.\n  |CFFFF0000(6)|CFF00FF00 BigWigs|r: It will turn boss warnings off.\n  |CFFFF0000(7)|CFF00FF00 Scrolling Combat Text|r:  It will disable all scrolling combat text.\n  |CFFFF0000(8)|CFF00FF00 Scrolling Combat Text Damage|r: It will disable all damage combat text.\n  |CFFFF0000(9)|CFF00FF00 Scrolling Combat Text Cooldowns|r: It will disable the ability cooldown alerts.\n  |CFFFF0000(10)|CFF00FF00 Witchhunt|r: It will disable all enemy spell alerts.\n  |CFFFF0000(11)|CFF00FF00 Button visibility|r: This will hide all buttons in a given mode.  This can be useful if you play strictly with key bindings.\n  |CFFFF0000(12)|CFF00FF00 Discord add-ons update rate|r: This will decrease how often Discord Action Bars and Discord Unit Frames update themselves.  Since those are probably two of the most expensive add-ons in the package, this is a very useful item to change.\n\nMore items are planned for future versions of MazzleUI, for example turning down spell effect level.\n\nNow that you know what the efficiency modes can change, you now have to understand |cFFFF8000when|r it can turn things off.  There are five different contexts in which you can use an efficiency mode.\n  \n  |CFFFF0000(1)|CFF00FF00 Solo|r: Active when no other mode is applicable.\n  |CFFFF0000(2)|CFF00FF00 Party Efficiency Mode|r: Active whenever you are in a 5-man party.\n  |CFFFF0000(3)|CFF00FF00 Raid Efficiency Mode|r: Active whenever you are in a raid.\n  |CFFFF0000(4)|CFF00FF00 PvP Efficiency Mode|r: Active whenever you are PvP flagged.\n  |CFFFF0000(5)|CFF00FF00 Manual Efficiency Mode|r: Active when you press the manual efficiency mode button.  This is the only efficiency mode that does not automatically turn itself on.\n\nIf more than one mode is applicable, only the highest mode (in terms of the order of that list) will apply.  For example, if you are pvp-flagged and in a raid, you will be in PvP efficiency mode, not raid efficiency mode.  This is because PvP, #4, is higher in that list than Raid, #3.\n\nNow that you understand how efficiency modes work, I'd suggest you customize it for your particular needs.\n\nThe first, and most important thing you should do is set up what the UI considers 'high graphics settings' vs. 'low graphics settings'.  |cFFFF8000There is an entry in the 'Tweaking' section of this FAQ that will explain how to do that|r via an add-on called gfxToggle.  If you don't set that up, you may find that the UI will reset your graphics to very high settings even if you had previously turned them down manually.\n\nAfter you do that, you can tweak exactly what gets turned off in the various modes.  Just open up MazzleOptions and find the MazzleUI Efficiency Mode category.  You'll find a ton of settings there that you can tweak.  Mark exactly what you want to turn on and off in those various contexts.  Try to find a good balance between the features you want and the performance you need.  My guess that the default settings should work well for most people.  You can also turn entire efficiency modes off if you'd like."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I heard MazzleUI can hot-swap raid layouts.\nDoes that mean Mazzlefizz is a swinger?",
        -- Answer
        "While Mazzlefizz is open to trading partners, hot-swapping raid layouts is an entirely different thing.  What it means is that you can change your raid layout in-game at any time.  You have a choice between 15 different layouts.  These are the things the differ between the various layouts:\n\n|CFFFF0000(1)|r Whether your raid frames are on the bottom of the screen or the top\n\n|CFFFF0000(2)|r Whether your main tank windows are on the top or on the side|CFFFF0000\n\n(3)|r Whether your party frames are visible\n\n|CFFFF0000(4)|rWhether your main tank frames are extra wide to show both the tanks' target and target of target\n\nYou can cycle through these layouts by right-clicking on the MazzleUI logo.  You can also set it directly by accessing the 'MazzleUI Unit Frame Settings' in MazzleOption.  Finally, you can bind button directly to different layouts in your key bindings."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Why is the left combat log window so narrow?\nWhy are there no scrollboxes?",
        -- Answer
        "The left window is only intended to display damage out and other similar combat messages.  For some classes, the damage window may also list resist amounts, vulnerability bonuses, immunity and other offensive items. The right window will display all actions taken to you and all miscellaneous combat messages.  It also contains loot messages and honor information\n\nAs for the scrollboxes, the philosophy behind this UI is to present a lot of information in a minimal amount of space.  As a result, the scroll bars are removed.  You can still scroll with the mousewheel. Hold down shift while scrolling to go immediately the top or bottom of the chat text.  If you do not have a scroll wheel you can use the page up and page down keys."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I heard a cha-ching!  Where are my loot\nmessages?",
        -- Answer
        "They are in the far right chat window with the miscellaneous combat messages."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I'm in your keybordz, steeling ur strokes, or\nwhy arent't any of the keybindings I expect\nworking?",
        -- Answer
        "Many of the standard Blizzard bindings have been changed, especially the ones on the left hand side of the keyboard.  Those keys are quite valuable in combat because they can be quickly reached while your other fingers stay on WASD. Rather than have those keys pull up non-combat stuff like the character window, they have been reassigned to combat functions.\n\nMost of the standard button assignments have been changed to their ctrl-key equivalents.  For example, you can pull up your character window with ctrl-c in most layouts.\n\n|CFFFF8000Note:|r If you installed the 'Minimal' or one of the other reduced MazzleUI install packages, you will probably have to re-do a lot of the basic keybinds.  The reason for this is that a lot of the keys are bound to add-ons you did not install, so, in effect, they will be unbound."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "How do I zoom in/out of the minimap?",
        -- Answer
        "To keep the UI as clean as possible, all extra buttons have been removed. This includes the '+' and '-' signs on the minimap. However, zooming in/out of the minimap is still very simple. Just hover your mouse over the minimap and use the scroll wheel to zoom in or out. If you don't have a scroll wheel, you can bind a couple of keys to scrolling in your Key Bindings."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "WTF? Isn't MazzleUI supposed to include\nTitan or FuBar? I don't see it anywhere on my\nscreen?!",
        -- Answer
        "MazzleUI includes FuBar, which is typically better at memory management than Titan and has, more or less, the same functionality.  As part of the design philosophy of keeping the majority of your screen unobstructed, it's hidden at the top of the screen.  Just move your mouse to the top 32 pixels of the screen and it will show. Move your mouse away from the area and you will once again have a nice clean onubstructed playing field."
    )

------------------------------------------------------
    MazzleOptions_NewFAQSection("Tweaking")
------------------------------------------------------

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I moved the window for one of my add-ons,\nbut every time I restart, it goes back to its\noriginal position.  This is so annoying! How do I get\nthe window to stay where I put it?",
        -- Answer
        "Most add-ons are positioned using another add-on called |CFFFF0000Discord Frame Modifier|r.  This add-on is basically a huge list of changes to window positions (and other properties).  MazzleUI uses it to make sure everything looks and fits right.  This is what keeps resetting your window's position.  In other words, even though you may have manually moved a window, if it's listed in Discord Frame Modifier, the UI will move it back to the MazzleUI-assigned position upon your next reload.  But don't worry.  It's pretty easy to get around this.\n\n|CFFFF8000(1)|r Open Discord Frame Modifier.  (you can do this via MazzleOptions or by typing '/dfm'\n\n|CFFFF8000(2)|r Scroll through the list on the left until you find the window you're interested in, and click on it.  If you don't know the name of the window, click Frame Finder and mouse over the window and DFM will tell you what it is called.\n\n|CFFFF8000(3)|rOn the right side of the DFM window, you'll see an area called 'Frame Location'.  You can either disable DFM from ever trying to move your window by unchecking the 'Use' and 'Lock' checkbuttons, or you can manually move it using the arrow buttons in DFM."
    )
    
    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "What is mod X? How do I use it? How do I\nchange its settings? How can I completely turn it\noff?",
        -- Answer
        "MazzleUI has an integrated options panel, MazzleOptions, that can be loaded by clicking on the button with an 'M' on it right under the 'MazzleUI' text. Once the window is open -- the one you're looking at now! -- you can access add-on options by clicking on the the options button in the top left corner of the window. \n\nMazzleOptions gives you a good description for every single mod included in the UI, organized by category! From there, you can modify the mod's settings or turn it on or off with one simple click. If you need more information on a particular addon, check the help documents in MazzleOptions by clicking the help button.  If that is not enough, look for the add-on author's web site or look in the add-on's directory for any help documents."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I don't like the video settings that the\nMazzleUI efficiency modes switch to?  The low\nsettings are way too low or the high settings\nare for too high for my system.",
        -- Answer
        "This is very easy to fix, and I highly recommend that everyone does this the first time they set up the UI.\n\n|CFFFF0000(1)|r Go to video settings and set everything up to be how you like it when you normally play the game.  This will be considered your 'high' settings.\n\n|CFFFF0000(2)|r Open MazzleOptions, go to the 'UI Performance' category (should be near the end of the list), and find the options for the add-on called |CFFFF8000GfxToggle|r.\n\n|CFFFF0000(3)|r Click on the 'Save High' button.\n\n|CFFFF0000(4)|r Go to video settings and set everything up to be the absolute bare minimum you can endure.  This will be considered your 'low' settings.\n\n|CFFFF0000(5)|r Go back to the options for |CFFFF8000GfxToggle|r.\n\n|CFFFF0000(6)|r Click on the 'Save Low' button.\n\nViola.  You're done.  MazzleUI will now switch between those two settings when it enables different efficiency modes."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Can I update add-ons on my own or do I have\nto wait for new MazzleUI versions?",
        -- Answer
        "You can update most add-ons on your own with a few caveats.\n\nFirst, it's possible the Mazzifier will no longer configure the settings properly.  If the author decides to change the format of the settings, Mazzlefizz must manually make the same changes in the Mazzifier.  If the Mazzifier creates settings that don't make sense to the newer version of the add-on, bad things can sometimes happen.  If you do update an add-on, I recommend that you do not re-mazzify that add-on until a new version of the Mazzifier comes out.\n\nSecond, you may be replacing an enhanced version of the add-on.  Remember that Mazzlefizz has modified many add-ons to add extra features or improve performance.  In some cases, upgrading won't break anything but you will lose those features that were added.  In other cases, things may start to give errors.  Even if you decide not to upgrade, Gnomeregan will try to release regular updates of MazzleUI, so you'll always have the latest and greatest versions of add-ons at your disposal.\n\nHere is a list of changed add-ons to help you decide how problematic it may be to upgrade a particular add-on on your own.\n\n - Ace 1\n - Answering Machine\n - Autobar\n - AutoRank\n - BookOfCrafts\n - CEnemyCastBar\n - ChatManager\n - EasyCopy\n - FastCast\n - KC Items\n - KC Mobility\n - MerchantBags\n - MovableBags\n - oRA\n - PartySpotter\n - SCT Cooldowns\n - SimpleCombatLog\n - SpecialTalent\n - SimpleCombatLog\n - sRaidFrames\n - StatusWindow\n - WitchHunt\n - xcalc"
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Can I drop other add-ons in or remove\nadd-ons I don't want? Will that mess up MazzleUI\nor future Mazifications?",
        -- Answer
        "Yes, you can drop in whatever add-on you want. If your add-on doesn't do the same thing as another add-on in the UI, you're *probably* going to be OK.  There are lots of nice special purpose or class add-ons that I did not include in the package for a variety of reasons.  Usually, it's because of a performance concerns or worries that the utility of the add-on wasn't general enough.  I expect that many people will add many of their favorite add-ons on their own.\n\nIf you feel an add-on should be included in the package, feel free to suggest it in the MazzleUI forums.  Just make a good case for it in your post!  :D\n\nYou can also remove add-ons you don't want, as long as its not part of the core set of add-ons.  Personally, I'd recommend just disabling them via MazzleOptions."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Today is Tuesday! Blizzard just released a\npatch! None of my add-ons work! What do I do?",
        -- Answer
        "First, calm down, take a deep breath...and relax.  Did you go in and click the 'load out of date add-ons' option on your add-ons screen?  If not, just do that.  For most of the minor patches released by Blizzard, there isn't anything else you need to do.\n\nIf Blizzard has just released a major update, you're going to have to wait for Mazzlefizz to release an updated download.  If you're feeling adventurous, you can download and install the updates for the included mods as those authors release them.  Just make sure to first read the FAQ entry about upgrading add-ons on your own."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I know the 3d models are nifty looking, but\nI'm worried that they are lagging my system.  How\nexpensive are they?",
        -- Answer
        "The 3d models are far less expensive than you would think.  Whenever you are playing WoW, you can potentially have a kazillion models on the screen, both other friendly players and enemy mobs.  Even spell effects have their own models that are created on the fly.  All of these models are constantly changing position, size, animation, special effects, etc. as you play the game.    Mazz3D on the other hand only shows a handful of models that do almost nothing.  The cost to show such static models is fairly negligible.\n\nI've also spent a good deal of effort making sure that Mazz3D is as efficient as possible.  The database of camera information is quite compact.  Moreover, the OnUpdate processing for a model is completely turned off except when it's in the middle of an animation.\n\nThat said, there are options you can set to lower the costs of Mazz3D.  In MazzleOptions, you can disable random animations and/or event-based animations like having the model flinch when hit.  I don't think most people will gain much performance from doing this, but it is an option.  You can also use the MazzleUI Efficiency Modes to automatically turn those animations off in especially demanding contexts, for example, when you're pvp'ing or are in a raid.\n\n|cFFFF0000Note|r: Animated portrait models that you see in other UI's will use the exact some resources as the ones you'll find in Mazz3D with event-based animation off.  Just because these look cooler doesn't mean they cost a lot more."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I am not an anal-retentive gnome who must\nknow when every damn thing happens.  How do I\nget rid of all those time stamps in the chat frames?",
        -- Answer
        "If you don't eat your meat, how can you have any pudding?  How can you have any pudding if you don't eat your meat?\n\nIf you can't answer that question or decide that you still want to disable time stamps, look for Prat's entry in MazzleOptions.  You can disable it from there."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I need to adjust the time zone of the clock.\nHow can I do that?",
        -- Answer
        "The add-on is called Status Windows.  Access its options via MazzleOptions and select 'Time' from the Module Config menu.  It will present you with a window to enter your time zone adjustment.  Gnomeregan has modified StatusWindows to store these values per character, so you can set different values for different servers.  As a result, though, you'll need to adjust every character individually."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I tried to change the UI scale and now\neverything is in the wrong place. What's going on?",
        -- Answer
        "Positional data changes based on the UI scale. When you change the scale, you're changing the assumption that much of the MazzleUI code makes. If you really want to, you can still do it, but you'll need to make tons of settings changes to make it look right.  This would require significant knowledge of all the Discord add-ons as well as some of the other add-ons. It will also probably prevent you from using future versions of MazzleUI, unless you're willing to make those same changes every time there's an update to the layout."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I know it's only a graphic, but I'm in love\nwith the HUD.  I'd like to run away with it,\nbut, until then, how can I make sure I see it\nall the time?",
        -- Answer
        "You can find an option to set the out-of-combat transparency of the HUD in MazzleOptions.  If you set it to something greater than zero, you will see the HUD at all times.\n\nOh, and you are odd."
    )

------------------------------------------------------
    MazzleOptions_NewFAQSection("Usage")
------------------------------------------------------

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Why can I no longer right click on my world\nmap to zoom out?  That's retarded!",
        -- Answer
        "Don't worry.  You can still zoom out.  One of the nice things about your new map (provided by an add-on called AlphaMap) is that it is transparent and can be left on the screen while you run around trying to get somewhere.  Obviously, you couldn't keep the menu up and play if you could no longer click anything in the playing area! So, the mechanism to the zoom the map in and out had to be changed.\n\nTo zoom the map in and out, simply hold down ctrl while you right or left click.  You can also select the actual zone you're interested in from the pulldown menu."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "OMG, name plates are being turned on and\noff randomly!  Are there gremlins in my UI?",
        -- Answer
        "While you never want to discount the possibility of gremlins, what you are probably seeing is a feature of the UI called MazzleUI efficiency modes.  It allows the UI to manage settings and add-ons, to improve efficiency in certain contexts.  By default, name plates are set to be on only when PvP flagged.  If you think about it, you'll probably realize that those random times are when your pvp flag was changing.\n\nYou can completely configure what gets turned on and off in any of the five efficiency modes by using the MazzleOptions system.  To learn more, check out the Efficiency Mode FAQ entry in the MazzleOptions help system."
    )
    
    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "My party keeps telling me to 'heal' them.\nWhat MazzleUI add-ons can help me do that?",
        -- Answer
        "There are two main add-ons that help with healing.\n\nThe first is |CFFFF0000Clique|r. This add-on provides click casting support. It is configured differently depending on the class you're playing.  In general, right-clicking casts the most mana efficient spell for your class, for exaple Greater Heal on a priest. Alt-Left-clicking casts your emergency 'fast spell', like flash heal. Mouse button 4 casts your heal over time spell, and Mouse Button 5 casts your shield. Comparable spells will be cast for other classes.\n\nThe second add-on is |CFFFF0000NeedyList|r. It provides you with a highly-configurable list of people that have 'needs' you can meet. These needs can be anything from being healed, to decursing, buffing, etc. This need concept is applicable to almost any class. You can also limit which people are of interest for any particular needs, for example, 'only show healing needs for groups 3 and 4' or 'only show int buff needs for mana users', etc.\n\nTo configure Clique, you must open the Blizzard spell book.  Left-click the MazzleUI text to show the main menu bar to do that. There is a tab at the bottom (below your various spell schools) that will allow you to configure Clique.\n\nTo configure NeedyList, right-click on the NeedyList header at the very bottom of the list. There are a lot of options there that you'll tend to change regularly depending on your responsibilities within a group."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Oooh, it keeps track of my record damages,\nheals, and crits....but where do i go to view this\ninformation later?",
        -- Answer
        "Just place your mouse at the very top of the screen and you'll see your FuBar menu.  Mouseover the TopScoreFu portion of the Fubar and you can see all your record damages/heals/crits."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Woah!  There are a million add-ons in\nMazzleOptions.  How can I possibly find what I'm\nlooking for?",
        -- Answer
        "There are two key features of MazzleOptions that can help you find the add-on you're looking for.\n\n|cFFFF0000(1)|r If you know the name of the add-on, go to the 'Add-On Directory', the first item in MazzleOptions.  There will be an alphabetical list of every add-on.  You can click on any item and it will take you to the correct category.\n\n|cFFFF0000(2)|r If you don't know the name of the add-on, try to find it by category.  Remember that you can mouse over any category in the MazzleOptions topic list, and a tooltip will pop up telling you what is inside it.  Just scan the list and it should be pretty easy to find what you're looing for."
    )

------------------------------------------------------
    MazzleOptions_NewFAQSection("Buttons")
------------------------------------------------------

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "ZOMG!  These buttons suck.  They are too\nsmall. They are not where I want them.  They're\ntoo far away from the left.  They're too far from\nthe right. They're way too square!  MazzleUI sux!",
        -- Answer
        "MazzleUI ships with quite a few different button layouts, but buttons are very personal.  As a result, Gnomeregan calculates that 70% of people will be less that 60% satisfied with 30% of some layouts.  If you are one of those people, I recommend you either try one of the other layouts for your class, or start with one of the 'simple' layouts and configure it for your needs.  For more information on how to use DAB, you can visit |CFF00FF00www.discordmods.com|r.\n\nMake sure to save any customized layouts with a new profile name, so that it doesn't get overwritten by future Mazzifications."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "Hmm... I've got a bunch of small letters like\nA1, C1, S1, etc... on my Action Buttons. What\nare they?",
        -- Answer
        "Those letters denote the keybindings for those buttons\n\nA is for Alt\nC is for Ctrl\nS is for Shift\n\nSo A-D would be Alt-D, C-F would be Ctrl-F, etc. To modify the bindings on your buttons, you should open up Discord Action Bars and do it from there.  You can open up DAB by either typing /dab or opening up MazzleOptions."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I just leveled and got my new spells... but\nhow do i get get the UI to add them where they're\nsupposed to be in this layout?",
        -- Answer
        "It's as easy as remazzifying your button layout.  Just type /mazzify', check off 'Button Layouts' in the second page, choose your button layout on the button layout page and click on 'Mazzify Me'.  It will re-drop spells into the layout.  Any new spells or spell levels will now be in your buttons."
    )


    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "I just Mazzified and my button layout does\nnot have one of my skills on it.  Does that mean\nsomething went wrong?",
        -- Answer
        "It probably just means that the layout did not take that action or skill into account.  There are so permutations of classes, races, talents, aspect ratios, that there are bound to be omissions in the layouts.  If you find such an item, make sure to report it at the MazzleUI forums."
    )

------------------------------------------------------
    MazzleOptions_NewFAQSection("Troubleshooting")
------------------------------------------------------

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "My click-casting isn't working.  Look!\nClickity-click-click.  Woe is me.  What do I do?",
        -- Answer
        "The current version of Clique requires that the Mazzifier specify the exact level of spells attached to a click.  If it's not working, you probably don't have the spell that was assigned to the click.  This is almost certainly true if you are not a high-level character.  To fix this, simply configure Clique to perform the spells you do have.\n\nTo configure Clique, you must open the Blizzard spell book.  Left-click the MazzleUI text to show the main menu bar to do that. There is a tab at the bottom (below your various spell schools) that will allow you to configure Clique.\n\n|CFFFF8000Note:|r It's also possible, though unlikely, that Clique did not get Mazzified.  You can try re-mazzifying that one add-on to fix the problem."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "My UI is laggy as hell?  Waaah!  Help me!",
        -- Answer
        "While one of the main goals of MazzleUI is efficiency, a few people do have unexpected performance problems.  I say unexpected because there are also a lot of users who run the UI on pretty low-end systems just fine.  Unfortunately, there's no easy, general solution to this problem.  Different systems seem to have problems with so many different things.  \n\nHere are a couple things I can suggest, in no particular order:\n\n|cFFFF00001)|r Lower your video settings.  Perhaps try a lower resolution.  Uncheck things in the Blizzard interface options that you don't need.\n\n|cFFFF00002)|r If you're only having problems in places with large numbers of people, try lowering your texture settings in particular or adding more memory to your computer.  WoW is extrememly memory hungry when there are lots of people around you.  It needs to cache a lot stuff to be able to display the variety of characters, armour, etc around you.  This has little to do with your mods, but can be affected by some of the setting that MazzleUI sets, most notably the UI scale.\n\n|cFFFF00003)|r Open MazzleOptions, go through the various categories and disable add-ons you don't use often.  Similarly, you can try installing one of the smaller base packages in the Mazzifier, which will quickly disable a larger set of add-ons.  I'd also recommend turning off the add-ons that the Mazzifier labels as expensive, things like Gatherer, Enemy Cast Bars and the various damage meters.  Try to think of what the add-on does before you disable it.  If it has to process lots of combat information on the fly, it's probably expensive.\n\n|cFFFF00004)|r Play with the efficiency mode settings.  There's a lot of power there to automatically modulate which add-ons and features are turned on at certain times.  Try to find a balance between the usability you like and the performance you need.  Remember that a lot of those settings will not affect your base frame rate and will only help in computationally demanding situations like combat.  So don't be discouraged if you don't see immediate jumps in frame rate.\n\nMake sure to read the FAQ entry on efficiency modes.  It is particular important to set up what it considers high and low graphics settings.  If you don't, you may find that your UI is setting your graphics settings to be higher than what it can handle.  Also make sure to try decreasing the Discord update rate in there.\n\nUnfortunately, there are two aspects of MazzleUI that you cannot easily get around.  \n\n|cFFFF00001)|r The UI scale.  Some users have reported that setting it at the lowest value of 0.64 is very hard on their systems.  While it's not entirely clear why it hurts some people so badly, I'm guessing that it's becuase, in some sense, it's similar to increasing your resolution.  There's just more real estate that WoW has to consider.  You can try setting your scale to a higher value, but you'll find most of the positional information in the UI will now be off.\n\n|cFFFF00002)|r Discord Action Bars and Discord Unit Frames.  While these add-ons are very powerful and flexible, they can be expensive.  If you can't run those add-ons well in other situations -- perhaps you tried installing them in a different UI that used them -- you probably won't be able to run MazzleUI that well either."
    )

    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "EEP! I Changed my Video/Interface settings\nand my chat boxes and/or minimap have\ndisappeared! I can't get them back!! What have\nyou done with them?!?  The British are coming!\nThe British are coming!",
        -- Answer
        "Unfortunately, this is simply a known Blizzard bug.  Opening some of the settings windows sometimes causes detached chat windows to disappear. Similarly, most changes in video settings will cause the minimap's background to turn black.  But don't panic! There are two simple ways to get them back:\n\n|CFFFF80001|r. Type '/console reloadui'. This command will reload the entire UI.  In a few moments, your chat windows and/or minimap will be back.\n\n|CFFFF80002|r. If only your detached chat windows, i.e. the combat logs, have disappeared, there's a button in MazzleOptions that will immediately bring them back.  You can find it under the category 'MazzleUI Special Settings'."
    )
    
    MazzleOptions_Setup_FAQ_Question( true,
        -- Question
        "One of the add-ons is putting timer bars/text\nright in the middle of the HUD!  Surely this wasn't\nintended by the engineers of Gnomeragan.",
        -- Answer
        "For some reason, certain add-ons can become 'locked', and MazzleUI is no longer able to place them where it needs to.  Reloading the ui, '/console reloadui', should clear it up.\n\nSo far, Gnomeregan has noticed this occasionally happen with BigWigs timers, oRA main tank windows, Color Combo Points and WitchHunt spell alerts.  We do not currently know why this is happening."
    )

--    MazzleOptions_Setup_FAQ_Question( true,
--        -- Question
--        "",
--        -- Answer
--        ""
--    )
end