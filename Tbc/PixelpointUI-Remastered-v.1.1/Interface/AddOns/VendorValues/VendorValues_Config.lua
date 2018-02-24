

local o = VendorValues;


local l_t_Init; -- ()




function l_t_Init()
	l_t_Init = nil;
	o.t_Config_Init = nil;
	
	
	local defaults = {
		prefix = o.Localization.DEFAULT_PREFIX;
		prefixStack = o.Localization.DEFAULT_PREFIX_STACK;
		hidePrefix = nil;
		addSeparator = true;
		textR = 1.0;
		textG = 1.0;
		textB = 1.0;
	};
	
	local handlers = {
		prefix = ConfigManager1.CreateGenericHandler("string");
		prefixStack = ConfigManager1.CreateGenericHandler("string");
		hidePrefix = ConfigManager1.CreateGenericHandler("boolean", true);
		addSeparator = ConfigManager1.CreateGenericHandler("boolean", true);
		textR = ConfigManager1.CreateGenericHandler("number", true);
		textG = ConfigManager1.CreateGenericHandler("number", true);
		textB = ConfigManager1.CreateGenericHandler("number", true);
	};
	
	local configClient = ConfigManager1.RegisterClient("VendorValues_Config", handlers, defaults, nil, o.t_Tooltips_OnConfigLoaded, false);
	
	
	local sCmds = o.Localization.SLASH_COMMANDS;
	SimpleSlash1.RegisterClient(
	  "VendorValues",
	  {
		_handlerObj = configClient;
		_sendHandler = true;
		[sCmds.PREFIX] = {
			extraStartArg = ("prefix");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noStatusInversion = true;
			usageText = sCmds.PREFIX_USAGE;
			statusText = sCmds.PREFIX_STATUS;
			plainStatus = true;
		};
		[sCmds.PREFIXSTACK] = {
			extraStartArg = ("prefixStack");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noStatusInversion = true;
			usageText = sCmds.PREFIXSTACK_USAGE;
			statusText = sCmds.PREFIXSTACK_STATUS;
			plainStatus = true;
		};
		[sCmds.HIDEPREFIX] = {
			extraStartArg = ("hidePrefix");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noArgForSet = true;
			usageText = sCmds.HIDEPREFIX_USAGE;
			statusText = sCmds.HIDEPREFIX_STATUS;
			[true] = sCmds.HIDEPREFIX_STATUS_TRUE;
			[false] = sCmds.HIDEPREFIX_STATUS_FALSE;
		};
		[sCmds.SEPARATOR] = {
			extraStartArg = ("addSeparator");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noArgForSet = true;
			usageText = sCmds.SEPARATOR_USAGE;
			statusText = sCmds.SEPARATOR_STATUS;
			[true] = sCmds.SEPARATOR_STATUS_SHOWN;
			[false] = sCmds.SEPARATOR_STATUS_HIDDEN;
		};
		[sCmds.RED] = {
			extraStartArg = ("textR");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noStatusInversion = true;
			usageText = sCmds.RED_USAGE;
			statusText = sCmds.RED_STATUS;
			plainStatus = true;
		};
		[sCmds.GREEN] = {
			extraStartArg = ("textG");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noStatusInversion = true;
			usageText = sCmds.GREEN_USAGE;
			statusText = sCmds.GREEN_STATUS;
			plainStatus = true;
		};
		[sCmds.BLUE] = {
			extraStartArg = ("textB");
			get = ("GetValue");
			noArgForGet = true;
			set = ("SetValue");
			noStatusInversion = true;
			usageText = sCmds.BLUE_USAGE;
			statusText = sCmds.BLUE_STATUS;
			plainStatus = true;
		};
	  }
	);
	SimpleSlash1.RegisterPrefix("VendorValues", sCmds.PREFIX_1);
	o.Localization.SLASH_COMMANDS = nil;
	o.Localization = nil;
end

o.t_Config_Init = l_t_Init;

