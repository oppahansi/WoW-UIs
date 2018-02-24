
BugGrabberDB = {
	["throttle"] = true,
	["limit"] = 500,
	["errors"] = {
		{
			["message"] = {
				"SatrinaBuffFrame-3.1\\SBFUtil.lua:111: attempt to compare number with nil\nSatrinaBuffFrame-3.1\\SBFTracking.lua:74: in function `UpdateTracking'\nSatrinaBuffFrame-3.1\\SatrinaBuffFrame.lua:226: in function `FinishSetup'\nSatrinaBuffFrame-3.1\\SatrinaBuffFrame.lua:252: in function <...terface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:246>\n\nLocals:|r\nself = <table> {\n sounds = <table> {\n }\n CancelTimer = <function> defined @Interface\\AddOns\\Chinchilla\\libs\\AceTimer-3.0\\AceTimer-3.0.lua:311\n UnitGUID = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFCombatLog.lua:14\n StopTimers = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:281\n debug = 0\n CopyTable = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFResources.lua:48\n GetTimer = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:323\n versionStr = \"3.1.20\"\n ScheduleTimer = <function> defined @Interface\\AddOns\\Chinchilla\\libs\\AceTimer-3.0\\AceTimer-3.0.lua:276\n", -- [1]
				" RemoveTrackingBuff = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFTracking.lua:24\n enchantID = <table> {\n }\n GetBuffFrame = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFFrame.lua:81\n FrameLevels = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:66\n db = <table> {\n }\n OpenOptions = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:501\n ValueIn = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFUtil.lua:12\n SetEnabledState = <function> defined @Interface\\AddOns\\AtlasLoot\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n DISEASE = \"Disease\"\n alpha = 0.79093404399852\n AddTrackingBuff = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFTracking.lua:12\n strings = <table> {\n }\n FrameExists = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFUtil.lua:317\n getAuras = <table> {\n }\n PutAnchor = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:673\n NewModule = <function> def", -- [2]
				"ined @Interface\\AddOns\\AtlasLoot\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n PutSlot = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFFrame.lua:636\n PutName = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:432\n PopulateSlot = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFFrame.lua:611\n DescendingDurationSort = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFUtil.lua:257\n revision = 129\n SetupEnchants = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFEnchant.lua:34\n UntilCancelled = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFBuff.lua:492\n DoFlow = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFBuff.lua:457\n name = \"SBF\"\n SetBarColour = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:268\n GetAnchor = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:663\n NONE = \"none\"\n Dispellable = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFUtil.lu", -- [3]
				"a:92\n sbfoVersion = 3.1\n lastUpdate = <table> {\n }\n Print = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceConsole-3.0\\AceConsole-3.0.lua:54\n RefreshBuffs = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:412\n timerFormat2 = \"%02d:%02d\"\n frameAdjustments = 0\n Castable = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFUtil.lua:79\n flashTime = 0.22399923857301\n ChatCommand = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:436\n durationIncrement = 1\n UnitVehicle = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:320\n CombatLog = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFCombatLog.lua:28\n GetCount = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFElements.lua:634\n CombatTimer = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SatrinaBuffFrame.lua:296\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\AtlasLoot\\Libs\\AceAddon-3.0\\", -- [4]
				"AceAddon-3.0.lua:381\n CreateFrames = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFFrame.lua:27\n EnableModule = <function> defined @Interface\\AddOns\\AtlasLoot\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n IterateEmbeds = <function> defined @Interface\\AddOns\\AtlasLoot\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n defaultVars = <table> {\n }\n AscendingTimeSort = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFUtil.lua:215\n ScanBuffTooltip = <function> defined @Interface\\AddOns\\SatrinaBuffFrame\\SBFFilters.lua:88\n \n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2010/02/25 12:58:03",
			["session"] = 1673,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nChatter-1.0\\Modules\\Scrollback.lua:42: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:27>\nChatter-1.0\\Modules\\Scrollback.lua:74: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:72>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (AtlasLoot):539: in function <...\\AddOns\\AtlasLoot\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/02/25 12:58:03",
			["session"] = 1673,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "PitBull4-v4.0.0-beta8\\Controls\\Controls.lua:31: attempt to call method 'SetTexCoordModifiesRect' (a nil value)\nPitBull4-v4.0.0-beta8\\Controls\\Controls.lua:63: in function `Delete'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:97: in function `ClearFrame'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:191: in function `UpdateFrame'\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:377: in function `UpdateForGUID'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:81: in function `?'\nCallbackHandler-1.0-5:146: in function <...ron\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[2]\":4: in function <[string \"safecall Dispatcher[2]\"]:4>\n<in C code>: ?\n<string>:\"safecall Dispatcher[2]\":13: in function `?'\nCallbackHandler-1.0-5:91: in function `Fire'\nAceEvent-3.0-3 (Acheron):119: in function <...ce\\AddOns\\Acheron\\Libs\\AceEvent-3.0\\AceEvent-3.0.lua:118>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/03/23 17:36:03",
			["session"] = 1725,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = {
				"PitBull4-v4.0.0-beta8\\Controls\\Controls.lua:31: attempt to call method 'SetTexCoordModifiesRect' (a nil value)\nPitBull4-v4.0.0-beta8\\Controls\\Controls.lua:63: in function `Delete'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:97: in function `ClearFrame'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:191: in function `UpdateFrame'\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:636: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:662: in function `UpdateGUID'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:334: in function <Interface\\AddOns\\PitBull4\\UnitFrame.lua:330>\n<in C code>: in function `Show'\nInterface\\FrameXML\\SecureTemplates.lua:817: in function <Interface\\FrameXML\\SecureTemplates.lua:729>:\nInterface\\FrameXML\\SecureTemplates.lua:1024: in function `SecureGroupHeader_Update':\nInterface\\FrameXML\\SecureTemplates.lua:610: in function <Interface\\FrameXML\\SecureTemplates.lua:608>:\n\nLocals:|r\nself = PitBull4_Tex", -- [1]
				"ture_84 {\n 0 = <userdata>\n Delete = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:49\n kind = \"Texture\"\n}\nkind = \"Texture\"\ndelete_funcs = <table> {\n StatusBar = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:33\n Texture = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:25\n Cooldown = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:39\n FontString = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:16\n}\ncache = <table> {\n BetterStatusBar = <table> {\n }\n Icon = <table> {\n }\n FontString = <table> {\n }\n Aura = <table> {\n }\n PlayerModel = <table> {\n }\n Frame = <table> {\n }\n Cooldown = <table> {\n }\n Texture = <table> {\n }\n}\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2010/03/23 17:36:04",
			["session"] = 1725,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "PitBull4-v4.0.0-beta8\\Controls\\Controls.lua:31: attempt to call method 'SetTexCoordModifiesRect' (a nil value)\nPitBull4-v4.0.0-beta8\\Controls\\Controls.lua:63: in function `Delete'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:100: in function `ClearFrame'\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:341: in function `Clear'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:618: in function `Update'\nPitBull4-v4.0.0-beta8\\GroupHeader.lua:1005: in function <Interface\\AddOns\\PitBull4\\GroupHeader.lua:1000>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceTimer-3.0-5 (Acheron):160: in function <...ce\\AddOns\\Acheron\\Libs\\AceTimer-3.0\\AceTimer-3.0.lua:132>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/03/23 17:59:26",
			["session"] = 1726,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = {
				"PitBull4-v4.0.0-beta8\\Controls\\Controls.lua:31: attempt to call method 'SetTexCoordModifiesRect' (a nil value)\nPitBull4-v4.0.0-beta8\\Controls\\Controls.lua:63: in function `Delete'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:100: in function `ClearFrame'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:191: in function `UpdateFrame'\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:636: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:662: in function `UpdateGUID'\nPitBull4-v4.0.0-beta8\\Main.lua:1331: in function `CheckGUIDForUnitID'\nPitBull4-v4.0.0-beta8\\Main.lua:1349: in function `?'\nCallbackHandler-1.0-5:146: in function <...ron\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[2]\":4: in function <[string \"safecall Dispatcher[2]\"]:4>\n<in C code>: ?\n<string>:\"safecall Dispatcher[2]\":13: in function `?'\nCallbackHandler-1.0-5:91: in function `Fire'\nAceEvent-3.0-3 (Acheron)", -- [1]
				":119: in function <...ce\\AddOns\\Acheron\\Libs\\AceEvent-3.0\\AceEvent-3.0.lua:118>\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2010/03/23 17:59:30",
			["session"] = 1726,
			["counter"] = 2,
		}, -- [6]
		{
			["message"] = "PitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:236: attempt to index field 'model' (a nil value)\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:636: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:662: in function `UpdateGUID'\nPitBull4-v4.0.0-beta8\\Main.lua:1331: in function `CheckGUIDForUnitID'\nPitBull4-v4.0.0-beta8\\Main.lua:1349: in function `?'\nCallbackHandler-1.0-5:146: in function <...ron\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[2]\":4: in function <[string \"safecall Dispatcher[2]\"]:4>\n<in C code>: ?\n<string>:\"safecall Dispatcher[2]\":13: in function `?'\nCallbackHandler-1.0-5:91: in function `Fire'\nAceEvent-3.0-3 (Acheron):119: in function <...ce\\AddOns\\Acheron\\Libs\\AceEvent-3.0\\AceEvent-3.0.lua:118>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/03/23 17:59:34",
			["session"] = 1726,
			["counter"] = 2,
		}, -- [7]
		{
			["message"] = {
				"PitBull4-v4.0.0-beta8\\Controls\\Controls.lua:31: attempt to call method 'SetTexCoordModifiesRect' (a nil value)\nPitBull4-v4.0.0-beta8\\Controls\\Controls.lua:63: in function `Delete'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:100: in function `ClearFrame'\nPitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:191: in function `UpdateFrame'\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:636: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:662: in function `UpdateGUID'\nPitBull4-v4.0.0-beta8\\Main.lua:1285: in function <Interface\\AddOns\\PitBull4\\Main.lua:1273>\n\nLocals:|r\nself = PitBull4_Texture_111 {\n 0 = <userdata>\n Delete = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:49\n kind = \"Texture\"\n}\nkind = \"Texture\"\ndelete_funcs = <table> {\n StatusBar = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:33\n Texture = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls", -- [1]
				".lua:25\n Cooldown = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:39\n FontString = <function> defined @Interface\\AddOns\\PitBull4\\Controls\\Controls.lua:16\n}\ncache = <table> {\n BetterStatusBar = <table> {\n }\n Cooldown = <table> {\n }\n FontString = <table> {\n }\n Aura = <table> {\n }\n PlayerModel = <table> {\n }\n Frame = <table> {\n }\n Icon = <table> {\n }\n Texture = <table> {\n }\n}\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2010/03/23 18:00:16",
			["session"] = 1726,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "PitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:236: attempt to index field 'model' (a nil value)\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:636: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:662: in function `UpdateGUID'\nPitBull4-v4.0.0-beta8\\Main.lua:1331: in function `CheckGUIDForUnitID'\nPitBull4-v4.0.0-beta8\\Main.lua:1343: in function `?'\nCallbackHandler-1.0-5:146: in function <...ron\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <[string \"safecall Dispatcher[1]\"]:4>\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":13: in function `?'\nCallbackHandler-1.0-5:91: in function `Fire'\nAceEvent-3.0-3 (Acheron):119: in function <...ce\\AddOns\\Acheron\\Libs\\AceEvent-3.0\\AceEvent-3.0.lua:118>\n<in C code>: in function `CameraOrSelectOrMoveStop'\n<string>:\"CAMERAORSELECTORMOVE\":4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/03/23 18:00:24",
			["session"] = 1726,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "PitBull4_Portrait-v4.0.0-beta8\\Portrait.lua:236: attempt to index field 'model' (a nil value)\nPitBull4-v4.0.0-beta8\\ModuleHandling\\Module.lua:319: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:636: in function `Update'\nPitBull4-v4.0.0-beta8\\UnitFrame.lua:662: in function `UpdateGUID'\nPitBull4-v4.0.0-beta8\\Main.lua:1331: in function `CheckGUIDForUnitID'\nPitBull4-v4.0.0-beta8\\Main.lua:1343: in function `?'\nCallbackHandler-1.0-5:146: in function <...ron\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <[string \"safecall Dispatcher[1]\"]:4>\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":13: in function `?'\nCallbackHandler-1.0-5:91: in function `Fire'\nAceEvent-3.0-3 (Acheron):119: in function <...ce\\AddOns\\Acheron\\Libs\\AceEvent-3.0\\AceEvent-3.0.lua:118>\n<in C code>: in function `TurnOrActionStop'\n<string>:\"TURNORACTION\":4: in function <[string \"TURNORACTION\"]:1>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/03/23 18:00:26",
			["session"] = 1726,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = {
				"StatusWindow-2.2\\StatusWindow.lua:421: attempt to index field '_var' (a nil value)\nStatusWindow-2.2\\StatusWindow.lua:69: in function `OnFrameEvent'\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\nself = <table> {\n NewPlayer = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:174\n SetupPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:681\n PutPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:287\n UnhookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:216\n FrameOnLeave = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:612\n FinishWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:501\n AttachModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:228\n ValidateFrameVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:302\n UpdateWindow = <function> defined @Interface\\AddOns\\", -- [1]
				"StatusWindow\\StatusWindow.lua:580\n DoSavedVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:144\n MouseDown = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:624\n GetWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:388\n Click = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:617\n SlashCommands = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:41\n debug = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:35\n PutWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:408\n HookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:202\n CopyTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:648\n loadedModules = <table> {\n }\n GetWindowTextColourCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:597\n OnFrameUpdate = <function> defined @Interface\\AddOns\\StatusWindo", -- [2]
				"w\\StatusWindow.lua:96\n HasLabel = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:702\n version = 2.2\n ClassColorRGB = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:811\n ClassColorCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:794\n GetFrameVar = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:576\n GetPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:271\n UpdateCurrentPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:754\n SetupDefaultPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:728\n RegisterModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:197\n ShowingIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:712\n HasIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:692\n paneCache = <table> {\n }\n GetTable = <function> defined @Interface\\AddOns\\", -- [3]
				"StatusWindow\\StatusWindow.lua:661\n Initialise = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:125\n tables = <table> {\n }\n windowCache = <table> {\n }\n windows = <table> {\n }\n GetFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:329\n OnFrameEvent = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:65\n ValidateWindowVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:365\n GetWindowFont = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:593\n InvokeFrameFunc = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:558\n PutFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:311\n AssembleWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:445\n frames = <table> {\n }\n RegisterEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:89\n minor = 0\n UpdateSavedVars = <function> defined @Interface\\Add", -- [4]
				"Ons\\StatusWindow\\StatusWindow.lua:426\n debugLevel = 1\n PutTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:668\n InitWindows = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:419\n FrameOnEnter = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:608\n MakeWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:433\n\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2010/04/05 18:22:06",
			["session"] = 1777,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "StatusWindow-2.2\\StatusWindow.lua:97: attempt to compare number with nil\n<string>:\"*:OnUpdate\":1: in function <[string \"*:OnUpdate\"]:1>\n\nLocals:|r\nself = StatusWindowFrame {\n 0 = <userdata>\n}\nelapsed = 0.054000001400709\n\n  ---",
			["type"] = "error",
			["time"] = "2010/04/05 18:22:06",
			["session"] = 1777,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = {
				"TipTac-10.03.25\\core.lua:799: attempt to index upvalue 'cfg' (a nil value)\nTipTac-10.03.25\\core.lua:809: in function <Interface\\AddOns\\TipTac\\core.lua:803>\n<in C code>: in function `GameTooltip_SetDefaultAnchor'\nBartender4-3\\ActionButton.lua:470: in function `SetTooltip'\nBartender4-3\\ActionButton.lua:201: in function <Interface\\AddOns\\Bartender4\\ActionButton.lua:199>\n\nLocals:|r\ntooltip = GameTooltip {\n Show = <function> defined @Interface\\AddOns\\TipTac\\core.lua:823\n FadeOut = <function> defined @Interface\\AddOns\\TipTac\\core.lua:833\n updateTooltip = 0.2\n 0 = <userdata>\n default = 1\n SetHyperlink = <function> defined =[C]:-1\n shoppingTooltips = <table> {\n }\n}\nparent = BT4Button40 {\n 0 = <userdata>\n macroName = BT4Button40Name {\n }\n action = 40\n parent = BT4Bar4 {\n }\n __bf_framelevel = <table> {\n }\n eventsRegistered = true\n flash = BT4Button40Flash {\n }\n __bf_nonormaltexture = true\n flashtime = 0\n icon = BT4Button40Icon {\n }\n stateactions = <table> {\n }\n __bf_skinlayer", -- [1]
				" = <table> {\n }\n feedback_action = 40\n border = BT4Button40Border {\n }\n __bf_normaltexture = <unnamed> {\n }\n id = 40\n SecureInit = true\n hotkey = BT4Button40HotKey {\n }\n normalTexture = BT4Button40BTNT {\n }\n Secure = BT4Button40 {\n }\n count = BT4Button40Count {\n }\n cooldown = BT4Button40Cooldown {\n }\n rid = 4\n flashing = 0\n SetNormalTexture = <function> defined =[C]:-1\n}\ngtt_anchorType = nil\ngtt_anchorPoint = nil\nGetAnchorPosition = <function> defined @Interface\\AddOns\\TipTac\\core.lua:795\ntt = TipTac {\n ApplySettings = <function> defined @Interface\\AddOns\\TipTac\\core.lua:1009\n 0 = <userdata>\n text = <unnamed> {\n }\n CURSOR_UPDATE = <function> defined @Interface\\AddOns\\TipTac\\core.lua:222\n AddModifiedTip = <function> defined @Interface\\AddOns\\TipTac\\core.lua:1079\n ApplyGeneralAppearance = <function> defined @Interface\\AddOns\\TipTac\\core.lua:1139\n VARIABLES_LOADED = <function> defined @Interface\\AddOns\\TipTac\\core.lua:242\n HookTips = <function> defined @Interface\\AddOn", -- [2]
				"s\\TipTac\\core.lua:964\n AnchorFrameToMouse = <function> defined @Interface\\AddOns\\TipTac\\core.lua:1096\n PLAYER_LEVEL_UP = <function> defined @Interface\\AddOns\\TipTac\\core.lua:237\n close = <unnamed> {\n }\n CVAR_UPDATE = <function> defined @Interface\\AddOns\\TipTac\\core.lua:272\n}\nTT_MirrorAnchorsSmart = <table> {\n BOTTOMRIGHT = \"TOPLEFT\"\n TOPLEFT = \"BOTTOMRIGHT\"\n BOTTOMLEFT = \"TOPRIGHT\"\n TOPRIGHT = \"BOTTOMLEFT\"\n}\nTT_MirrorAnchors = <table> {\n RIGHT = \"LEFT\"\n TOPLEFT = \"TOPRIGHT\"\n TOP = \"BOTTOM\"\n LEFT = \"RIGHT\"\n BOTTOM = \"TOP\"\n TOPRIGHT = \"TOPLEFT\"\n BOTTOMLEFT = \"BOTTOMRIGHT\"\n BOTTOMRIGHT = \"BOTTOMLEFT\"\n CENTER = \"CENTER\"\n}\n\n  ---", -- [3]
			},
			["type"] = "error",
			["time"] = "2010/04/05 18:22:06",
			["session"] = 1777,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = {
				"StatusWindow-2.2\\StatusWindow.lua:421: attempt to index field '_var' (a nil value)\nStatusWindow-2.2\\StatusWindow.lua:69: in function `OnFrameEvent'\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\nself = <table> {\n NewPlayer = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:174\n SetupPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:681\n PutPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:287\n UnhookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:216\n FrameOnLeave = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:612\n FinishWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:501\n AttachModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:228\n ValidateFrameVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:302\n UpdateWindow = <function> defined @Interface\\AddOns\\", -- [1]
				"StatusWindow\\StatusWindow.lua:580\n DoSavedVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:144\n MouseDown = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:624\n GetWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:388\n Click = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:617\n SlashCommands = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:41\n debug = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:35\n PutWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:408\n HookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:202\n CopyTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:648\n loadedModules = <table> {\n }\n GetWindowTextColourCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:597\n OnFrameUpdate = <function> defined @Interface\\AddOns\\StatusWindo", -- [2]
				"w\\StatusWindow.lua:96\n HasLabel = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:702\n version = 2.2\n ClassColorRGB = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:811\n ClassColorCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:794\n GetFrameVar = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:576\n GetPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:271\n UpdateCurrentPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:754\n SetupDefaultPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:728\n RegisterModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:197\n ShowingIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:712\n HasIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:692\n paneCache = <table> {\n }\n GetTable = <function> defined @Interface\\AddOns\\", -- [3]
				"StatusWindow\\StatusWindow.lua:661\n Initialise = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:125\n tables = <table> {\n }\n windowCache = <table> {\n }\n windows = <table> {\n }\n GetFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:329\n OnFrameEvent = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:65\n ValidateWindowVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:365\n GetWindowFont = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:593\n InvokeFrameFunc = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:558\n PutFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:311\n AssembleWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:445\n frames = <table> {\n }\n RegisterEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:89\n minor = 0\n UpdateSavedVars = <function> defined @Interface\\Add", -- [4]
				"Ons\\StatusWindow\\StatusWindow.lua:426\n debugLevel = 1\n PutTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:668\n InitWindows = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:419\n FrameOnEnter = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:608\n MakeWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:433\n\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2010/04/05 18:29:56",
			["session"] = 1778,
			["counter"] = 1,
		}, -- [14]
		{
			["message"] = "StatusWindow-2.2\\StatusWindow.lua:97: attempt to compare number with nil\n<string>:\"*:OnUpdate\":1: in function <[string \"*:OnUpdate\"]:1>\n\nLocals:|r\nself = StatusWindowFrame {\n 0 = <userdata>\n}\nelapsed = 0.059000004082918\n\n  ---",
			["type"] = "error",
			["time"] = "2010/04/05 18:29:56",
			["session"] = 1778,
			["counter"] = 1,
		}, -- [15]
		{
			["message"] = "AceSerializer-3.0-3:241: bad argument #1 to 'gsub' (string expected, got nil)\nAceSerializer-3.0-3:241: in function `Deserialize'\nAVR-0.9.3beta\\Core.lua:102: in function `?'\nCallbackHandler-1.0-5:146: in function <...oot\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[4]\":4: in function <[string \"safecall Dispatcher[4]\"]:4>\n<in C code>: ?\n<string>:\"safecall Dispatcher[4]\":13: in function `?'\nCallbackHandler-1.0-5:91: in function `Fire'\nAceComm-3.0-6 (AtlasLoot):268: in function <...ce\\AddOns\\AtlasLoot\\Libs\\AceComm-3.0\\AceComm-3.0.lua:257>\n\n  ---",
			["type"] = "error",
			["time"] = "2010/04/29 18:54:08",
			["session"] = 1831,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:27:27",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [17]
		{
			["message"] = {
				"AceHook-3.0-5 (Bartender4):142: attempt to index local 'obj' (a nil value)\nAceHook-3.0-5 (Bartender4):370: in function `HookScript'\nChatter-1.0\\Modules\\GroupSay.lua:12: in function <Interface\\AddOns\\Chatter\\Modules\\GroupSay.lua:11>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAd", -- [1]
				"dOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:27:34",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:27:34",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [19]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:27:34",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = {
				"StatusWindow-2.2\\StatusWindow.lua:421: attempt to index field '_var' (a nil value)\nStatusWindow-2.2\\StatusWindow.lua:69: in function `OnFrameEvent'\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\nself = <table> {\n NewPlayer = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:174\n SetupPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:681\n PutPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:287\n UnhookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:216\n FrameOnLeave = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:612\n FinishWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:501\n AttachModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:228\n ValidateFrameVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:302\n UpdateWindow = <function> defined @Interface\\AddOns\\", -- [1]
				"StatusWindow\\StatusWindow.lua:580\n DoSavedVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:144\n MouseDown = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:624\n GetWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:388\n Click = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:617\n SlashCommands = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:41\n debug = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:35\n PutWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:408\n HookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:202\n CopyTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:648\n loadedModules = <table> {\n }\n GetWindowTextColourCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:597\n OnFrameUpdate = <function> defined @Interface\\AddOns\\StatusWindo", -- [2]
				"w\\StatusWindow.lua:96\n HasLabel = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:702\n version = 2.2\n ClassColorRGB = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:811\n ClassColorCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:794\n GetFrameVar = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:576\n GetPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:271\n UpdateCurrentPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:754\n SetupDefaultPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:728\n RegisterModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:197\n ShowingIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:712\n HasIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:692\n paneCache = <table> {\n }\n GetTable = <function> defined @Interface\\AddOns\\", -- [3]
				"StatusWindow\\StatusWindow.lua:661\n Initialise = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:125\n tables = <table> {\n }\n windowCache = <table> {\n }\n windows = <table> {\n }\n GetFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:329\n OnFrameEvent = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:65\n ValidateWindowVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:365\n GetWindowFont = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:593\n InvokeFrameFunc = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:558\n PutFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:311\n AssembleWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:445\n frames = <table> {\n }\n RegisterEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:89\n minor = 0\n UpdateSavedVars = <function> defined @Interface\\Add", -- [4]
				"Ons\\StatusWindow\\StatusWindow.lua:426\n debugLevel = 1\n PutTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:668\n InitWindows = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:419\n FrameOnEnter = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:608\n MakeWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:433\n\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:27:35",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [21]
		{
			["message"] = "StatusWindow-2.2\\StatusWindow.lua:97: attempt to compare number with nil\n<string>:\"*:OnUpdate\":1: in function <[string \"*:OnUpdate\"]:1>\n\nLocals:|r\nself = StatusWindowFrame {\n 0 = <userdata>\n}\nelapsed = 0.016000000759959\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:27:35",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [22]
		{
			["message"] = "Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nChatter-1.0\\Modules\\Scrollback.lua:42: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:27>\nChatter-1.0\\Modules\\Scrollback.lua:74: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:72>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:28:42",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "AceHook-3.0-5 (Bartender4):142: attempt to index local 'obj' (a nil value)\nAceHook-3.0-5 (Bartender4):370: in function `HookScript'\nChatter-1.0\\Modules\\GroupSay.lua:12: in function <Interface\\AddOns\\Chatter\\Modules\\GroupSay.lua:11>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:28:42",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [24]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:71: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:28:42",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:28:42",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [26]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:114: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:28:42",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [27]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:28:42",
			["session"] = 1840,
			["counter"] = 1,
		}, -- [28]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:31:17",
			["session"] = 1841,
			["counter"] = 1,
		}, -- [29]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:31:19",
			["session"] = 1841,
			["counter"] = 1,
		}, -- [30]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:31:19",
			["session"] = 1841,
			["counter"] = 1,
		}, -- [31]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:33:03",
			["session"] = 1842,
			["counter"] = 1,
		}, -- [32]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:33:04",
			["session"] = 1842,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:33:04",
			["session"] = 1842,
			["counter"] = 1,
		}, -- [34]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:35:01",
			["session"] = 1843,
			["counter"] = 1,
		}, -- [35]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:35:06",
			["session"] = 1843,
			["counter"] = 1,
		}, -- [36]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:35:06",
			["session"] = 1843,
			["counter"] = 1,
		}, -- [37]
		{
			["message"] = "Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nChatter-1.0\\Modules\\Scrollback.lua:42: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:27>\nChatter-1.0\\Modules\\Scrollback.lua:74: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:72>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:37:44",
			["session"] = 1843,
			["counter"] = 3,
		}, -- [38]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:71: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:37:44",
			["session"] = 1843,
			["counter"] = 4,
		}, -- [39]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:37:44",
			["session"] = 1843,
			["counter"] = 4,
		}, -- [40]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:114: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:37:44",
			["session"] = 1843,
			["counter"] = 4,
		}, -- [41]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:37:44",
			["session"] = 1843,
			["counter"] = 4,
		}, -- [42]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nInterface\\FrameXML\\ChatFrame.lua:2937: in function `ChatFrame_MessageEventHandler':\nInterface\\FrameXML\\ChatFrame.lua:2491: in function `ChatFrame_OnEvent':\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\n(*temporary) = \"CHAT_MSG_CHANNEL\"\n(*temporary) = \" Conflicted COD me seal of vengeance, judgement, censecration\"\n(*temporary) = \"Shiroyuki\"\n(*temporary) = \"\"\n(*temporary) = \"2. Trade\"\n(*temporary) = \"Shiroyuki\"\n(*temporary) = \"\"\n(*temporary) = 2\n(*temporary) = 2\n(*temporary) = \"Trade\"\n(*temporary) = 0\n(*temporary) = 217\n(*temporary) = \"0x000000000011E9DF\"\n(*temporary) = 0\n(*temporary) = \"CHAT_MSG_CHANNEL\"\n(*temporary) = \" Conflicted COD me seal of vengeance, judgement, censecration\"\n(*temporary) = \"Shiroyuki\"\n(*temporary) = \"\"\n(*temporary) = \"2. Trade\"\n(*temporary) = \"Shiroyuki\"\n(*temporary) = \"\"\n(*", -- [1]
				"temporary) = 2\n(*temporary) = 2\n(*temporary) = \"Trade\"\n(*temporary) = 0\n(*temporary) = 217\n(*temporary) = \"0x000000000011E9DF\"\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:37:48",
			["session"] = 1843,
			["counter"] = 1,
		}, -- [43]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nInterface\\FrameXML\\ChatFrame.lua:2755: in function `ChatFrame_MessageEventHandler':\nInterface\\FrameXML\\ChatFrame.lua:2491: in function `ChatFrame_OnEvent':\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\n(*temporary) = \"CHAT_MSG_TRADESKILLS\"\n(*temporary) = \"Samie creates Fractured Cardinal Ruby.\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 282\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = \"CHAT_MSG_TRADESKILLS\"\n(*temporary) = \"Samie creates Fractured Cardinal Ruby.\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 282\n(*temporary) = \"\"\n(*tempora", -- [1]
				"ry) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:41:40",
			["session"] = 1843,
			["counter"] = 1,
		}, -- [44]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:41:48",
			["session"] = 1844,
			["counter"] = 1,
		}, -- [45]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:41:49",
			["session"] = 1844,
			["counter"] = 1,
		}, -- [46]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:41:49",
			["session"] = 1844,
			["counter"] = 1,
		}, -- [47]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:42:40",
			["session"] = 1845,
			["counter"] = 1,
		}, -- [48]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:42:41",
			["session"] = 1845,
			["counter"] = 1,
		}, -- [49]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:42:41",
			["session"] = 1845,
			["counter"] = 1,
		}, -- [50]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:42:52",
			["session"] = 1846,
			["counter"] = 1,
		}, -- [51]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:42:53",
			["session"] = 1846,
			["counter"] = 1,
		}, -- [52]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:42:53",
			["session"] = 1846,
			["counter"] = 1,
		}, -- [53]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:44:47",
			["session"] = 1847,
			["counter"] = 1,
		}, -- [54]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:44:52",
			["session"] = 1847,
			["counter"] = 1,
		}, -- [55]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:44:52",
			["session"] = 1847,
			["counter"] = 1,
		}, -- [56]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nInterface\\FrameXML\\ChatFrame.lua:2937: in function `ChatFrame_MessageEventHandler':\nInterface\\FrameXML\\ChatFrame.lua:2491: in function `ChatFrame_OnEvent':\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\n(*temporary) = \"CHAT_MSG_CHANNEL\"\n(*temporary) = \"WTB |cffffffff|Hitem:46376:0:0:0:0:0:0:0:80|h[Flask of the Frost Wyrm]|h|r stack\"\n(*temporary) = \"Stormblight\"\n(*temporary) = \"\"\n(*temporary) = \"2. Trade\"\n(*temporary) = \"Stormblight\"\n(*temporary) = \"\"\n(*temporary) = 2\n(*temporary) = 2\n(*temporary) = \"Trade\"\n(*temporary) = 0\n(*temporary) = 360\n(*temporary) = \"0x0000000000002B55\"\n(*temporary) = 0\n(*temporary) = \"CHAT_MSG_CHANNEL\"\n(*temporary) = \"WTB |cffffffff|Hitem:46376:0:0:0:0:0:0:0:80|h[Flask of the Frost Wyrm]|h|r stack\"\n(*temporary) = \"Stormblight\"\n(*temporary) = \"\"\n(*temporary) = \"2. Trade\"\n(*t", -- [1]
				"emporary) = \"Stormblight\"\n(*temporary) = \"\"\n(*temporary) = 2\n(*temporary) = 2\n(*temporary) = \"Trade\"\n(*temporary) = 0\n(*temporary) = 360\n(*temporary) = \"0x0000000000002B55\"\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:46:20",
			["session"] = 1847,
			["counter"] = 1,
		}, -- [57]
		{
			["message"] = "Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nChatter-1.0\\Modules\\Scrollback.lua:42: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:27>\nChatter-1.0\\Modules\\Scrollback.lua:74: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:72>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:20",
			["session"] = 1847,
			["counter"] = 2,
		}, -- [58]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:71: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:20",
			["session"] = 1847,
			["counter"] = 2,
		}, -- [59]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:20",
			["session"] = 1847,
			["counter"] = 2,
		}, -- [60]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:114: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:20",
			["session"] = 1847,
			["counter"] = 2,
		}, -- [61]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:20",
			["session"] = 1847,
			["counter"] = 2,
		}, -- [62]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:46:36",
			["session"] = 1848,
			["counter"] = 1,
		}, -- [63]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:46:37",
			["session"] = 1848,
			["counter"] = 1,
		}, -- [64]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:46:37",
			["session"] = 1848,
			["counter"] = 1,
		}, -- [65]
		{
			["message"] = "Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nChatter-1.0\\Modules\\Scrollback.lua:42: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:27>\nChatter-1.0\\Modules\\Scrollback.lua:74: in function <Interface\\AddOns\\Chatter\\Modules\\Scrollback.lua:72>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:59",
			["session"] = 1848,
			["counter"] = 3,
		}, -- [66]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:71: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:59",
			["session"] = 1848,
			["counter"] = 4,
		}, -- [67]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:59",
			["session"] = 1848,
			["counter"] = 4,
		}, -- [68]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:114: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:59",
			["session"] = 1848,
			["counter"] = 4,
		}, -- [69]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:46:59",
			["session"] = 1848,
			["counter"] = 4,
		}, -- [70]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nInterface\\FrameXML\\ChatFrame.lua:2937: in function `ChatFrame_MessageEventHandler':\nInterface\\FrameXML\\ChatFrame.lua:2491: in function `ChatFrame_OnEvent':\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\n(*temporary) = \"CHAT_MSG_SAY\"\n(*temporary) = \"ikr u are\"\n(*temporary) = \"Areks\"\n(*temporary) = \"Common\"\n(*temporary) = \"\"\n(*temporary) = \"Areks\"\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 390\n(*temporary) = \"0x00000000000CBA97\"\n(*temporary) = 0\n(*temporary) = \"CHAT_MSG_SAY\"\n(*temporary) = \"ikr u are\"\n(*temporary) = \"Areks\"\n(*temporary) = \"Common\"\n(*temporary) = \"\"\n(*temporary) = \"Areks\"\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 390\n(*temporary) = \"0x00000000000CBA97\"\n(*temporary) = ", -- [1]
				"0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:48:18",
			["session"] = 1848,
			["counter"] = 1,
		}, -- [71]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChannelNames.lua:162: attempt to concatenate field 'Whisper To' (a nil value)\n(tail call): ?:\n(tail call): ?:\n(tail call): ?:\nInterface\\FrameXML\\ChatFrame.lua:2937: in function `ChatFrame_MessageEventHandler':\nInterface\\FrameXML\\ChatFrame.lua:2491: in function `ChatFrame_OnEvent':\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\n(*temporary) = \"CHAT_MSG_CHANNEL\"\n(*temporary) = \"Dustwallow Marsh level range ?\"\n(*temporary) = \"Varshal\"\n(*temporary) = \"\"\n(*temporary) = \"5. global\"\n(*temporary) = \"Varshal\"\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 5\n(*temporary) = \"global\"\n(*temporary) = 0\n(*temporary) = 391\n(*temporary) = \"0x000000000012825D\"\n(*temporary) = 0\n(*temporary) = \"CHAT_MSG_CHANNEL\"\n(*temporary) = \"Dustwallow Marsh level range ?\"\n(*temporary) = \"Varshal\"\n(*temporary) = \"\"\n(*temporary) = \"5. global\"\n(*temporary) = \"Varshal\"\n(*temporary) = \"\"\n(*temporary) = 0\n(*temporary) = 5\n(*temporary) = \"global\"\n(*temporary", -- [1]
				") = 0\n(*temporary) = 391\n(*temporary) = \"0x000000000012825D\"\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:48:22",
			["session"] = 1848,
			["counter"] = 1,
		}, -- [72]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:48:32",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [73]
		{
			["message"] = {
				"AceHook-3.0-5 (Bartender4):142: attempt to index local 'obj' (a nil value)\nAceHook-3.0-5 (Bartender4):370: in function `HookScript'\nChatter-1.0\\Modules\\GroupSay.lua:12: in function <Interface\\AddOns\\Chatter\\Modules\\GroupSay.lua:11>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAd", -- [1]
				"dOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:48:33",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [74]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:48:33",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [75]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:48:33",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [76]
		{
			["message"] = "AceHook-3.0-5 (Bartender4):142: attempt to index local 'obj' (a nil value)\nAceHook-3.0-5 (Bartender4):370: in function `HookScript'\nChatter-1.0\\Modules\\GroupSay.lua:12: in function <Interface\\AddOns\\Chatter\\Modules\\GroupSay.lua:11>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:48:53",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [77]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:71: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:48:53",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [78]
		{
			["message"] = "Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:48:53",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [79]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:114: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):573: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:566>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:181: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:48:53",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [80]
		{
			["message"] = "Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:182: in function `UpdateConfig'\nChatter-1.0\\Chatter.lua:168: in function <Interface\\AddOns\\Chatter\\Chatter.lua:164>\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:48:53",
			["session"] = 1849,
			["counter"] = 1,
		}, -- [81]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:49:02",
			["session"] = 1850,
			["counter"] = 1,
		}, -- [82]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:49:03",
			["session"] = 1850,
			["counter"] = 1,
		}, -- [83]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:49:03",
			["session"] = 1850,
			["counter"] = 1,
		}, -- [84]
		{
			["message"] = "AceLocale-3.0: Chatter: Missing entry for 'Module':\nChatter-1.0\\Chatter.lua:98: in function <Interface\\AddOns\\Chatter\\Chatter.lua:91>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[2]\":9: in function <[string \"safecall Dispatcher[2]\"]:5>\n(tail call): ?:\nAceConfigDialog-3.0-45:796: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:611>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[3]\":9: in function <[string \"safecall Dispatcher[3]\"]:5>\n(tail call): ?:\nAceGUI-3.0-30 (ButtonFacade):326: in function `Fire'\n...er\\Libs\\AceGUI-3.0\\widgets\\AceGUIWidget-CheckBox.lua:69: in function <...er\\Libs\\AceGUI-3.0\\widgets\\AceGUIWidget-CheckBox.lua:58>:\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 16:49:36",
			["session"] = 1850,
			["counter"] = 1,
		}, -- [85]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\EditBox.lua:182: attempt to index global 'ChatFrameEditBox' (a nil value)\nChatter-1.0\\Modules\\EditBox.lua:186: in main chunk\n\nLocals:|r\nmod = <table> {\n modName = \"Edit Box Polish\"\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n hooks = <table> {\n }\n RawHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:255\n Disable = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:328\n EnableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:346\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:230\n Iter", -- [1]
				"ateEmbeds = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:456\n IsModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:237\n SecureHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {\n }\n IsHooked = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:496\n UnhookAll = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:480\n SetEnabledState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:438\n Hook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:277\n enabledState = false\n Unhook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:421\n SecureHookScript = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:413\n HookScript = <functio", -- [2]
				"n> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:369\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:423\n GetName = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:298\n defaultModuleState = true\n IterateModules = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n name = \"Chatter_Edit Box Polish\"\n RawHook = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceHook-3.0\\AceHook-3.0.lua:316\n IsEnabled = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:465\n moduleName = \"Edit Box Polish\"\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:401\n DisableModule = <function> defined @Interface\\AddOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:364\n}\nL = <table> {\n Character to use for the left bracket = \"Character", -- [3]
				" to use for the left bracket\"\n Play a sound when a message is received in this channel = \"Play a sound when a message is received in this channel\"\n Raid Leader = \"Raid Leader\"\n Scroll lines = \"Scroll lines\"\n Remembers the history of the editbox across sessions. = \"Remembers the history of the editbox across sessions.\"\n Disable Fading = \"Disable Fading\"\n Whisper = \"Whisper\"\n Edge Size = \"Edge Size\"\n Sets the frame's border color to the color of your currently active channel = \"Sets the frame's border color to the color of your currently active channel\"\n Character to use between the name and level = \"Character to use between the name and level\"\n Save data between sessions. Will increase memory usage = \"Save data between sessions. Will increase memory usage\"\n Border color = \"Border color\"\n Bottom = \"Bottom\"\n Enable text justification = \"Enable text justification\"\n Add word to your invite trigger list = \"Add word to your invite trigger list\"\n Borders/Background = \"Borde", -- [4]
				"rs/Background\"\n Warlock = \"Warlock\"\n Use PlayerNames coloring = \"Use PlayerNames coloring\"\n Who is %s's main? = \"Who is %s's main?\"\n Officer = \"Officer\"\n Save class data from guild between sessions. = \"Save class data from guild between sessions.\"\n $$EMPTY$$ = \"$$EMPTY$$\"\n Name color = \"Name color\"\n Select the custom color to use\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:53:44",
			["session"] = 1851,
			["counter"] = 1,
		}, -- [86]
		{
			["message"] = {
				"AceHook-3.0-5 (Bartender4):142: attempt to index local 'obj' (a nil value)\nAceHook-3.0-5 (Bartender4):370: in function `HookScript'\nChatter-1.0\\Modules\\GroupSay.lua:12: in function <Interface\\AddOns\\Chatter\\Modules\\GroupSay.lua:11>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAd", -- [1]
				"dOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:53:48",
			["session"] = 1851,
			["counter"] = 1,
		}, -- [87]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\Buttons.lua:44: attempt to index local 'upButton' (a nil value)\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIPa", -- [1]
				"rent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:53:48",
			["session"] = 1851,
			["counter"] = 1,
		}, -- [88]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\ChatTabs.lua:86: attempt to index a nil value\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:194: in function <Interface\\AddOns\\Chatter\\Chatter.lua:187>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ", -- [1]
				"---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/18 16:53:48",
			["session"] = 1851,
			["counter"] = 1,
		}, -- [89]
		{
			["message"] = {
				"StatusWindow-2.2\\StatusWindow.lua:421: attempt to index field '_var' (a nil value)\nStatusWindow-2.2\\StatusWindow.lua:69: in function `OnFrameEvent'\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\nself = <table> {\n NewPlayer = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:174\n SetupPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:681\n PutPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:287\n UnhookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:216\n FrameOnLeave = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:612\n FinishWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:501\n AttachModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:228\n ValidateFrameVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:302\n UpdateWindow = <function> defined @Interface\\AddOns\\", -- [1]
				"StatusWindow\\StatusWindow.lua:580\n DoSavedVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:144\n MouseDown = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:624\n GetWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:388\n Click = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:617\n SlashCommands = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:41\n debug = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:35\n PutWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:408\n HookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:202\n CopyTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:648\n loadedModules = <table> {\n }\n GetWindowTextColourCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:597\n OnFrameUpdate = <function> defined @Interface\\AddOns\\StatusWindo", -- [2]
				"w\\StatusWindow.lua:96\n HasLabel = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:702\n version = 2.2\n ClassColorRGB = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:811\n ClassColorCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:794\n GetFrameVar = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:576\n GetPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:271\n UpdateCurrentPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:754\n SetupDefaultPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:728\n RegisterModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:197\n ShowingIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:712\n HasIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:692\n paneCache = <table> {\n }\n GetTable = <function> defined @Interface\\AddOns\\", -- [3]
				"StatusWindow\\StatusWindow.lua:661\n Initialise = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:125\n tables = <table> {\n }\n windowCache = <table> {\n }\n windows = <table> {\n }\n GetFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:329\n OnFrameEvent = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:65\n ValidateWindowVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:365\n GetWindowFont = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:593\n InvokeFrameFunc = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:558\n PutFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:311\n AssembleWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:445\n frames = <table> {\n }\n RegisterEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:89\n minor = 0\n UpdateSavedVars = <function> defined @Interface\\Add", -- [4]
				"Ons\\StatusWindow\\StatusWindow.lua:426\n debugLevel = 1\n PutTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:668\n InitWindows = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:419\n FrameOnEnter = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:608\n MakeWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:433\n\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/18 23:34:49",
			["session"] = 1856,
			["counter"] = 1,
		}, -- [90]
		{
			["message"] = "StatusWindow-2.2\\StatusWindow.lua:97: attempt to compare number with nil\n<string>:\"*:OnUpdate\":1: in function <[string \"*:OnUpdate\"]:1>\n\nLocals:|r\nself = StatusWindowFrame {\n 0 = <userdata>\n}\nelapsed = 0.026000000536442\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/18 23:34:49",
			["session"] = 1856,
			["counter"] = 1,
		}, -- [91]
		{
			["message"] = {
				"SBFOptions-3.1\\ProfileTab.lua:35: attempt to index global 'ChatFrameEditBox' (a nil value)\nInterface\\FrameXML\\StaticPopup.lua:3452: in function `StaticPopup_OnHide':\n<string>:\"*:OnHide\":1: in function <[string \"*:OnHide\"]:1>\n<in C code>: in function `Hide'\nSBFOptions-3.1\\ProfileTab.lua:22: in function `OnAccept'\nInterface\\FrameXML\\StaticPopup.lua:3473: in function `StaticPopup_OnClick':\n<string>:\"*:OnClick\":1: in function <[string \"*:OnClick\"]:1>\n\nLocals:|r\nself = StaticPopup1 {\n 0 = <userdata>\n hideOnEscape = 1\n itemFrame = StaticPopup1ItemFrame {\n }\n button3 = StaticPopup1Button3 {\n }\n extraFrame = StaticPopup1ExtraFrame {\n }\n icon = StaticPopup1AlertIcon {\n }\n maxWidthSoFar = 320\n button2 = StaticPopup1Button2 {\n }\n moneyFrame = StaticPopup1MoneyFrame {\n }\n moneyInputFrame = StaticPopup1MoneyInputFrame {\n }\n text = StaticPopup1Text {\n }\n editBox = StaticPopup1EditBox {\n }\n timeleft = 0\n button1 = StaticPopup1Button1 {\n }\n maxHeightSoFar = 113.23124823604\n wideEdi", -- [1]
				"tBox = StaticPopup1WideEditBox {\n }\n which = \"SBFO_NEW_PROFILE\"\n}\ndialog = <table> {\n button2 = \"Cancel\"\n hideOnEscape = 1\n timeout = 0\n button1 = \"Okay\"\n OnHide = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:34\n text = \"Enter the name for the new profile\"\n whileDead = 1\n EditBoxOnEnterPressed = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:40\n OnAccept = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:19\n EditBoxOnTextChanged = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:47\n OnShow = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:29\n maxLetters = 32\n EditBoxOnEscapePressed = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:55\n hasEditBox = 1\n}\nOnHide = <function> defined @Interface\\AddOns\\SBFOptions\\ProfileTab.lua:34\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/19 13:22:12",
			["session"] = 1860,
			["counter"] = 1,
		}, -- [92]
		{
			["message"] = "Bartender4-3\\ActionBars.lua:175: Usage: SaveBindings(1||2)\nBartender4-3\\ActionBars.lua:175: in function `ReassignBindings'\nBartender4-3\\ActionBars.lua:83: in function <Interface\\AddOns\\Bartender4\\ActionBars.lua:65>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):551: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---",
			["type"] = "error",
			["time"] = "2017/02/19 20:29:17",
			["session"] = 1864,
			["counter"] = 1,
		}, -- [93]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\AltNames.lua:331: bad argument #1 to 'strlower' (string expected, got nil)\nChatter-1.0\\Modules\\AltNames.lua:331: in function `ScanGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:290: in function `EnableGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:192: in function <Interface\\AddOns\\Chatter\\Modules\\AltNames.lua:181>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:249: in function <Interface\\AddOns\\Chatter\\Chatter.lua:242>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n", -- [1]
				"<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/19 20:29:17",
			["session"] = 1864,
			["counter"] = 1,
		}, -- [94]
		{
			["message"] = {
				"StatusWindow-2.2\\StatusWindow.lua:421: attempt to index field '_var' (a nil value)\nStatusWindow-2.2\\StatusWindow.lua:69: in function `OnFrameEvent'\n<string>:\"*:OnEvent\":1: in function <[string \"*:OnEvent\"]:1>\n\nLocals:|r\nself = <table> {\n NewPlayer = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:174\n SetupPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:681\n PutPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:287\n UnhookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:216\n FrameOnLeave = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:612\n FinishWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:501\n AttachModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:228\n ValidateFrameVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:302\n UpdateWindow = <function> defined @Interface\\AddOns\\", -- [1]
				"StatusWindow\\StatusWindow.lua:580\n DoSavedVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:144\n MouseDown = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:624\n GetWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:388\n Click = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:617\n SlashCommands = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:41\n debug = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:35\n PutWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:408\n HookEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:202\n CopyTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:648\n loadedModules = <table> {\n }\n GetWindowTextColourCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:597\n OnFrameUpdate = <function> defined @Interface\\AddOns\\StatusWindo", -- [2]
				"w\\StatusWindow.lua:96\n HasLabel = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:702\n version = 2.2\n ClassColorRGB = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:811\n ClassColorCode = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:794\n GetFrameVar = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:576\n GetPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:271\n UpdateCurrentPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:754\n SetupDefaultPane = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:728\n RegisterModule = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:197\n ShowingIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:712\n HasIcon = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:692\n paneCache = <table> {\n }\n GetTable = <function> defined @Interface\\AddOns\\", -- [3]
				"StatusWindow\\StatusWindow.lua:661\n Initialise = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:125\n tables = <table> {\n }\n windowCache = <table> {\n }\n windows = <table> {\n }\n GetFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:329\n OnFrameEvent = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:65\n ValidateWindowVars = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:365\n GetWindowFont = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:593\n InvokeFrameFunc = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:558\n PutFrame = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:311\n AssembleWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:445\n frames = <table> {\n }\n RegisterEvents = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:89\n minor = 0\n UpdateSavedVars = <function> defined @Interface\\Add", -- [4]
				"Ons\\StatusWindow\\StatusWindow.lua:426\n debugLevel = 1\n PutTable = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:668\n InitWindows = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:419\n FrameOnEnter = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:608\n MakeWindow = <function> defined @Interface\\AddOns\\StatusWindow\\StatusWindow.lua:433\n\n  ---", -- [5]
			},
			["type"] = "error",
			["time"] = "2017/02/19 20:29:18",
			["session"] = 1864,
			["counter"] = 1,
		}, -- [95]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\AltNames.lua:331: bad argument #1 to 'strlower' (string expected, got nil)\nChatter-1.0\\Modules\\AltNames.lua:331: in function `ScanGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:290: in function `EnableGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:192: in function <Interface\\AddOns\\Chatter\\Modules\\AltNames.lua:181>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:249: in function <Interface\\AddOns\\Chatter\\Chatter.lua:242>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n", -- [1]
				"<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/19 20:33:41",
			["session"] = 1865,
			["counter"] = 1,
		}, -- [96]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\AltNames.lua:331: bad argument #1 to 'strlower' (string expected, got nil)\nChatter-1.0\\Modules\\AltNames.lua:331: in function `ScanGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:290: in function `EnableGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:192: in function <Interface\\AddOns\\Chatter\\Modules\\AltNames.lua:181>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:249: in function <Interface\\AddOns\\Chatter\\Chatter.lua:242>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n", -- [1]
				"<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/19 22:21:10",
			["session"] = 1866,
			["counter"] = 1,
		}, -- [97]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\AltNames.lua:331: bad argument #1 to 'strlower' (string expected, got nil)\nChatter-1.0\\Modules\\AltNames.lua:331: in function `ScanGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:290: in function `EnableGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:192: in function <Interface\\AddOns\\Chatter\\Modules\\AltNames.lua:181>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:249: in function <Interface\\AddOns\\Chatter\\Chatter.lua:242>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n", -- [1]
				"<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/19 22:40:43",
			["session"] = 1867,
			["counter"] = 1,
		}, -- [98]
		{
			["message"] = {
				"Chatter-1.0\\Modules\\AltNames.lua:331: bad argument #1 to 'strlower' (string expected, got nil)\nChatter-1.0\\Modules\\AltNames.lua:331: in function `ScanGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:290: in function `EnableGuildNotes'\nChatter-1.0\\Modules\\AltNames.lua:192: in function <Interface\\AddOns\\Chatter\\Modules\\AltNames.lua:181>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:532>\n(tail call): ?:\nChatter-1.0\\Chatter.lua:249: in function <Interface\\AddOns\\Chatter\\Chatter.lua:242>\n(tail call): ?:\n<in C code>: ?\n<string>:\"safecall Dispatcher[1]\":9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?:\nAceAddon-3.0-5 (ButtonFacade):539: in function `EnableAddon'\nAceAddon-3.0-5 (ButtonFacade):629: in function <...dOns\\ButtonFacade\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:615>\n", -- [1]
				"<in C code>: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:235: in function `UIParentLoadAddOn':\nInterface\\FrameXML\\UIParent.lua:258: in function `CombatLog_LoadUI':\nInterface\\FrameXML\\UIParent.lua:482: in function <Interface\\FrameXML\\UIParent.lua:454>:\n\n  ---", -- [2]
			},
			["type"] = "error",
			["time"] = "2017/02/19 23:16:08",
			["session"] = 1868,
			["counter"] = 1,
		}, -- [99]
	},
	["save"] = true,
	["session"] = 1868,
}
