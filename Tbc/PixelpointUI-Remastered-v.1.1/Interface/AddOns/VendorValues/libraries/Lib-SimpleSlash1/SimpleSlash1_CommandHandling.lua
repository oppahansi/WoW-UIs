

local o = SimpleSlash1; if (o.SHOULD_LOAD == nil) then return; end


local l_BuildCommandHandler; -- handlerFunc = (name)

local l_HandleFullSlashCommand; -- (owner, fullCommand)
local l_SplitFullCommand; -- subcommand, argsString, showStatus = (fullCommand)

local l_CallHandlerFunction; -- success, ... = (config, key, argsArray, skipArgs, handlerObj, sendHandler, extraArgSpecifier, newStatus)
local l_AddExtraArgs; -- arrayIndex = (array, arrayIndex, config, startOrEnd, plural, specifier)

local l_HandleNonToggleSubcommand; -- statusText, extraFeedback = (config, argsArray, handlerObj, sendHandler)
local l_HandleToggleSubcommand; -- statusText, extraFeedback = (config, argsArray, handlerObj, sendHandler, showStatus)
local l_HandleMissingSubcommandConfig; -- basicHelpText, extendedHelpText = (client, subcommand)

local l_BuildStatusFeedback; -- feedback = (statusText, subcommand, argsString, argsArray)
local l_BuildErrorFeedback; -- feedback = (statusText, subcommand, argsString)

local l_PrintFeedback; -- (feedback, extraFeedback, r, g, b)


local tostring = tostring; -- HandleToggleSubcommand, BuildStatusFeedback
local type = type; -- HandleFullSlashCommand, CallHandlerFunction, AddExtraArgs, PrintFeedback
local ipairs = ipairs; -- PrintFeedback, CallHandlerFunction, AddExtraArgs




function l_BuildCommandHandler(owner)
	return (function(fullCommand) l_HandleFullSlashCommand(owner, fullCommand); end);
end

o.BuildCommandHandler = l_BuildCommandHandler;




do
	local loc_NON_TOGGLE_SUBCOMMAND = o.Localization.NON_TOGGLE_SUBCOMMAND;
	local loc_ALREADY_FIRED_ONCE_ONLY = o.Localization.ALREADY_FIRED_ONCE_ONLY;
	
	function l_HandleFullSlashCommand(owner, fullCommand)
		local client = o.GetClient(owner);
		if (client == nil) then
			return;
		end
		
		local feedback, extraFeedback;
		
		local subcommand, argsString, showStatus = l_SplitFullCommand(fullCommand);
		local subcommandConfig = client[subcommand];
		if (subcommandConfig == nil) then
			feedback, extraFeedback = l_HandleMissingSubcommandConfig(client, subcommand);
		else
			local argsArray;
			if (argsString ~= nil) then
				local splitter = subcommandConfig.argSplitter;
				local splitterType = type(splitter);
				if (splitterType == "string") then
					argsArray = { argsString:match(splitter) };
				elseif (splitterType == "function") then
					argsArray = { splitter(argsString) };
				else
					argsArray = { argsString };
				end
			else
				argsArray = {};
			end
			local success, statusText;
			
			if (subcommandConfig.onceOnly == true and subcommandConfig.alreadyFired == true) then
				success = true;
				statusText = loc_ALREADY_FIRED_ONCE_ONLY;
			else
				local handlerObj;
				if (subcommandConfig.handlerObj ~= nil) then
					handlerObj = subcommandConfig.handlerObj;
				else
					handlerObj = client._handlerObj;
				end
				local sendHandler;
				if (subcommandConfig.sendHandler ~= nil) then
					sendHandler = subcommandConfig.sendHandler;
				else
					sendHandler = client._sendHandler;
				end
				if (subcommandConfig.isNotToggle == true) then
					if (showStatus == true) then
						success = true;
						feedback = loc_NON_TOGGLE_SUBCOMMAND:format(subcommand);
					else
						success, statusText, extraFeedback = l_HandleNonToggleSubcommand(subcommandConfig, argsArray, handlerObj, sendHandler);
					end
				else
					success, statusText, extraFeedback = l_HandleToggleSubcommand(subcommandConfig, argsArray, handlerObj, sendHandler, showStatus);
				end
			end
			
			if (success == false) then
				feedback = l_BuildErrorFeedback(statusText, subcommand, argsString);
			else
				if (statusText ~= nil) then
					feedback = l_BuildStatusFeedback(statusText, subcommand, argsString, argsArray);
				end
				if (subcommandConfig.onceOnly == true) then
					subcommandConfig.alreadyFired = true;
				end
			end
		end
		
		if (feedback ~= nil) then
			feedback = (owner .. ": " .. feedback);
		end
		l_PrintFeedback(feedback, extraFeedback, client._r, client._g, client._b);
	end
end


do
	l_SplitFullCommand = assert(loadstring([[
		return (
			function(fullCommand)
				local subcommand, argsString = fullCommand:match("^([^%s]+) (.+)$");
				subcommand = (subcommand or fullCommand):lower();
				
				local showStatus = false;
				if (subcommand == "]] .. o.Localization.SLASH_STATUS .. [[" and argsString ~= nil) then
					showStatus = true;
					subcommand, argsString = argsString:match("^([^%s]+) ?(.*)$");
					subcommand = subcommand:lower();
				end
				
				return subcommand, argsString, showStatus;
			end
		);
	]]))();
end




do
	local pcall = pcall;
	local unpack = unpack;
	local l_callingArray = {};
	
	function l_CallHandlerFunction(config, funcKey, argsArray, skipArgs, handlerObj, sendHandler, extraArgSpecifier, sendNewStatus, newStatus)
		local func = config[funcKey];
		func = ((type(func) == "function" and func) or handlerObj[func]);
		
		local argIndex = 1;
		
		if (sendHandler == true) then
			l_callingArray[argIndex] = handlerObj;
			argIndex = (argIndex + 1);
		end
		
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "Start", "", "");
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "Start", "s", "");
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "Start", "", extraArgSpecifier);
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "Start", "s", extraArgSpecifier);
		
		if (skipArgs ~= true) then
			for index, value in ipairs(argsArray) do
				l_callingArray[argIndex] = value;
				argIndex = (argIndex + 1);
			end
		end
		
		if (sendNewStatus == true) then
			l_callingArray[argIndex] = newStatus;
			argIndex = (argIndex + 1);
		end
		
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "End", "", "");
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "End", "s", "");
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "End", "", extraArgSpecifier);
		argIndex = l_AddExtraArgs(l_callingArray, argIndex, config, "End", "s", extraArgSpecifier);
		
		for index = argIndex, #l_callingArray, 1 do
			l_callingArray[index] = nil;
		end
		
		return pcall(func, unpack(l_callingArray, 1, (argIndex - 1)));
	end
end



function l_AddExtraArgs(array, arrayIndex, config, startOrEnd, plural, specifier)
	local extraArgs = config["extra" .. (specifier or "") .. (startOrEnd or "") .. "Arg" .. (plural or "")];
	if (extraArgs ~= nil) then
		if (type(extraArgs) == "table") then
			for index, value in ipairs(extraArgs) do
				array[arrayIndex] = value;
				arrayIndex = (arrayIndex + 1);
			end
		else
			array[arrayIndex] = extraArgs;
			arrayIndex = (arrayIndex + 1);
		end
	end
	return arrayIndex;
end




do
	local loc_GENERIC_STATUS = o.Localization.GENERIC_STATUS;
	
	function l_HandleNonToggleSubcommand(config, argsArray, handlerObj, sendHandler)
		local success, extraReturn = l_CallHandlerFunction(config, "func", argsArray, (config.noArg == true), handlerObj, sendHandler, "", false, nil);
		
		if (success == false) then
			return false, (config.errorText or extraReturn), nil;
		end
		
		local statusText, extraFeedback;
		if (config.noStatusFeedback ~= true) then
			statusText = config.statusText;
		end
		if (config.hasExtraFeedback == true) then
			extraFeedback = extraReturn;
		end
		return true, statusText, extraFeedback;
	end
end




do
	local tableremove = table.remove;
	local loc_GENERIC_STATUS = o.Localization.GENERIC_STATUS;
	local loc_CURRENTLY = o.Localization.CURRENTLY;
	local loc_NOW = o.Localization.NOW;
	
	function l_HandleToggleSubcommand(config, argsArray, handlerObj, sendHandler, showStatus)
		local success, status, extraReturn = l_CallHandlerFunction(config, "get", argsArray, (config.noArgForGet == true), handlerObj, sendHandler, "Get", false, nil);
		
		if (success == false) then
			return false, (config.getFuncErrorText or config.errorText or status), nil;
		end
		
		
		if (showStatus == false) then
			local sendNewStatus = (config.noStatusInversion ~= true);
			local newStatus = nil;
			if (sendNewStatus == true) then
				newStatus = (not status);
			end
			success, status, extraReturn = l_CallHandlerFunction(config, "set", argsArray, (config.noArgForSet == true), handlerObj, sendHandler, "Set", sendNewStatus, newStatus);
			
			if (success == false) then
				return false, (config.setFuncErrorText or config.errorText or status), nil;
			end
		end
		
		
		local statusText, extraFeedback;
		
		if (config.noStatusFeedback ~= true) then
			if (config.plainStatus == true) then
				status = tostring(status);
			else
				status = tostring(config[status] or status);
			end
			if (config.resultFormat ~= nil) then
				status = config.resultFormat:format(status);
			end
			statusText = (config.statusText or loc_GENERIC_STATUS);
			statusText = statusText:gsub("#s", ((showStatus == true and loc_CURRENTLY) or loc_NOW));
			statusText = statusText:gsub("#r", status);
		end
		if (config.hasExtraFeedback == true) then
			extraFeedback = extraReturn;
		end
		
		return true, statusText, extraFeedback;
	end
end




do
	l_HandleMissingSubcommandConfig = assert(loadstring([[
		local tostring = tostring;
		return (
			function(client, subcommand)
				local basicHelpText = ("]] .. o.Localization.UNKNOWN_SUBCOMMAND_BASIC_FEEDBACK:gsub("\"", "\\\"") .. [["):format(tostring(subcommand));
				
				local extendedHelpText = {};
				extendedHelpText[#extendedHelpText + 1] = ("]] .. o.Localization.UNKNOWN_SUBCOMMAND_EXTENDED_FEEDBACK_HEADER .. [[");
				for subcommand, config in pairs(client) do
					if (subcommand:sub(1, 1) ~= "_") then
						extendedHelpText[#extendedHelpText + 1] = ("--==--==--==--");
						extendedHelpText[#extendedHelpText + 1] = ("\"" .. subcommand .. "\" - " .. (config.usageText or "]] .. o.Localization.NO_USAGE_INFO .. [["));
					end
				end
				extendedHelpText[#extendedHelpText + 1] = ("--==--==--==--");
				extendedHelpText[#extendedHelpText + 1] = ("]] .. o.Localization.UNKNOWN_SUBCOMMAND_EXTENDED_FEEDBACK_TRAILER:gsub("\"", "\\\"") .. [[");
				
				return basicHelpText, extendedHelpText;
			end
		);
	]]))();
end




function l_BuildStatusFeedback(statusText, subcommand, argsString, argsArray)
	statusText = statusText:gsub("#i", tostring(argsString));
	statusText = statusText:gsub("#c", subcommand);
	for index = 1, #argsArray, 1 do
		statusText = statusText:gsub(("#i" .. index), tostring(argsArray[index]));
	end
	return statusText;
end



do
	l_BuildErrorFeedback = assert(loadstring([[
		local tostring = tostring;
		return (
			function(errorText, subcommand, argsString)
				local errorFeedback = ("]] .. o.Localization.GENERIC_ERROR:gsub("\"", "\\\"") .. [["):format(tostring(argsString), subcommand);
				if (errorText ~= nil) then
					errorFeedback = (errorFeedback .. " " .. errorText);
				end
				return errorFeedback;
			end
		);
	]]))();
end




function l_PrintFeedback(feedback, extraFeedback, r, g, b)
	local chatFrame = DEFAULT_CHAT_FRAME;
	local addMsg = chatFrame.AddMessage;
	
	if (feedback ~= nil) then
		addMsg(chatFrame, feedback, r, g, b);
	end
	
	if (extraFeedback ~= nil) then
		local extraFeedbackType = type(extraFeedback);
		if (extraFeedbackType == "string") then
			addMsg(chatFrame, extraFeedback, r, g, b);
		elseif (extraFeedbackType == "table") then
			for index, text in ipairs(extraFeedback) do
				addMsg(chatFrame, text, r, g, b);
			end
		end
	end
end




o.Localization = nil;

