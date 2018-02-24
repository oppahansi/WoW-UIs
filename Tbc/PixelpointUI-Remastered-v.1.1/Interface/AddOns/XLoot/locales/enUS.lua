local L = AceLibrary("AceLocale-2.2"):new("XLoot")

L:RegisterTranslations("enUS", function()
	return { --- TRANSLATORS: PLEASE REMOVE ANY ITEMS MARKED "DEPRICATED" FROM YOUR TRANSLATIONS.
		catSnap = "Frame Behavior",
		catLoot = "Loot Behavior",
		catFrame = "Frame options",
		catInfo = "Loot information",
		catGeneralAppearance = "General Appearance",
		catFrameAppearance = "Frame appearance",
		catLootAppearance = "Loot appearance",
		catExtras = "Extras",
		
		["2.0 compatability"] = true, -- DEPRICATED
		["If you're getting errors with table.setn, enable this"] = true, -- DEPRICATED
		["Disable Tooltip Scanning"] = true, -- DEPRICATED
		["Enable this to skip scanning item tooltips for BoP/BoE/BoU information. This is most likely causing the 'Attempt to index field Rlines' error."] = true, -- DEPRICATED
		
		optLock = "Lock frame",
		optOptions = "Options GUI",
		optBehavior = "Behavior options",
		optCursor = "Snap XLoot frame to cursor",
		optSmartsnap = "Only snap vertically",
		optSnapoffset = "Snap offset",
		optCollapse = "Hide empty loot buttons",
		optDragborder = "Draggable border",
		optLootexpand = "Fit frame width to loot names",
		optAltoptions = "Show menu on Alt+RightClick",
		optSwiftloot = "Hide frame when auto-looting",
		optQualitytext = "Show item quality text",
		optInfotext = "Show item info text",
		["Show BoP/BoE/BoU"] =  true,
		["Show Bind on Pickup/Bind on Equip/Bind on Use text opposite stack size for items"] = true,
		optLinkAll = "Link All button",
		optLinkAllVis = "Visible: ",
		optLinkAllThreshold = "Link threshold",
		optLinkAllChannels = "Always link to...",
		optAppearance = "Appearance",
		optQualityborder = "Color border by quality",
		optQualityframe = "Color frame by quality",
		optLootqualityborder = "Color border by quality",
		optBgcolor = "Background Color",
		optBordercolor = "Border Color",
		optTexColor = "Color icon by quality",
		optHighlightLoot = "Highlight by quality",
		optHighlightThreshold = "Highlight threshold", 
		optLootbgcolor = "Background Color",
		optLootbordercolor = "Border Color",
		optInfoColor = "Info text color",
		optScale = "Scale",
		["Alpha"] = true,
		optAdvanced = "Advanced options",
		optDebug = "Debug Messages",
		optDefaults = "Reset options to default",
		
		descLock = "Makes loot frame unmoveable",
		descOptions = "Show the options dropdown",
		descBehavior = "Change how XLoot behaves",
		descCursor = "Snap the loot frame to the cursor whenever you loot something",
		descSmartsnap = "Snaps the loot frame only vertically to the cursor when the list shifts as you loot a item so it doesn't jump around",
		descSnapoffset = "Sets a distance from the middle of the first loot icon to snap to, horizontally",
		descCollapse = "Hide looted (empty) buttons and place cursor over next frame if the Snap option is enabled.",
		descDragborder = "Allows the loot window to be moved by dragging the frame's border, instead of just the buttons, which can otherwise be clicked through",
		descLootexpand = "Changes frame width to match loot names. Short names mean thin frames, long names make the frames widen",
		descAltoptions = "Allows you to Alt+RightClick on loot to bring up the XLoot menu. Can be disabled to not mess with other mods.",
		descSwiftloot = "Prevents a little lag when looting items automatically, either through the Interface Options setting, or holding down your chosen key (Also set in interface options)",
		descQualitytext = "Show a additional line above the item name with the item's Quality",
		descInfotext = "Show a addition line below the item name with the item's Information",
		descLinkAll = "The Link All button, a button that pops up a menu with all available channels, letting you send the current open loot to any of them.",
		descLinkAllVis = "When the Link All button should be visible",
		descLinkAllThreshold = "Only link items higher than the threshold.",
		descLinkAllChannels = "Always link to these channels when left-clicking Link All. |cFFFF0000If none are checked, left-clicking Link All will show the Link All menu.|r",
		descAppearance = "Coloring, scaling, and skin of XLootFrame and each individual loot button",
		descQualityborder = "Colors lootframe border by the highest quality item",
		descQualityframe = "Colors lootframe background by the highest quality item",
		descLootqualityborder = "Colors loot borders by quality",
		descHighlightLoot = "Highlights each loot frame by quality",
		descHighlightThreshold = "The minimum quality at which loot frames will be highlighted",
		descBgcolor = "Change the background color for the loot frame itself",
		descBordercolor = "Change the border color of the frame itself",
		descTexColor = "Color the border of the actual item icon/texture by quality",
		descLootbgcolor = "Change the background color for every loot item",
		descLootbordercolor = "Change the border color of every loot item",
		descInfoColor = "Change the color of the information text",
		descScale = "Scale of the loot frame",
		descAdvanced = "Options you may not want to mess with, but can anyway.",
		descDebug = "Show debug messages",
		descDefaults = "Reinstate the database that comes with XLoot and set all the options back to their defaults",
		
		qualityQuest = "Miscellaneous",
		
		["BoP"] = true,
		["BoE"] = true,
		["BoU"] = true,
		
		guiTitle = "XLoot Options",
		
		itemWeapon = "Weapon",
		
		evHerbs = "Herb Gathering",
		evOpenNT = "Opening - No Text",
		evOpen = "Opening",
		
		linkallloot = "Link all...",
		linkallchanneldesc = "Automatically link loot to %s when left-clicking Link All",
	}
end)