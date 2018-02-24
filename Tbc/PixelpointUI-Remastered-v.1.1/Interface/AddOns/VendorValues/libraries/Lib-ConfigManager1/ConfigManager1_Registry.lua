

local o = ConfigManager1; if (o.SHOULD_LOAD == nil) then return; end
local m = {};


local l_t_GetLocals; -- genericWithStoreFalseAsNil, genericWithoutStoreFalseAsNil, clients = ()

local l_RegisterClient; -- client = (configTableName, handlers, defaults, configMetatable, onLoadFunc)
local l_GetClient; -- client = (configTableName)
local l_InitClient; -- (configTableName, clientInfo)
local l_OnEvent_VARIABLES_LOADED; -- ()
local l_CreateGenericHandler; -- handler = (validInputTypes, storeFalseAsNil)

local l_GetValue; -- value = (configTableName, propertyName[, ...])
-- local l_m_GetValue; -- value = (self, propertyName[, ...])
local l_SetValue; -- newValue = (configTableName, propertyName[, ...], newValue)
-- local l_m_SetValue; -- newValue = (self, propertyName[, ...], newValue)

local l_ValidateAccessor; -- isValid, reasonInvalid, accessor = (handler, accessor)

local l_ApplyModifiers; -- modifiedValue = (modifiers, value)

local l_CheckExtraValidators; -- isValid, reasonUnvalid = (extraInputValidators, arg)
local l_DoesExtraValidatorMatch; -- isValid, reasonUnvalid = (arg, validator)


local select = select; -- GetValue, SetValue
local type = type; -- GetValue, SetValue, ApplyModifiers, ValidateAccessor
local tostring = tostring; -- GetValue, SetValue
local tonumber = tonumber; -- GetValue, SetValue
local stringmatch = string.match; -- CreateGenericHandler, GetValue, SetValue, ValidateAccessor


local l_GENERIC_HANDLERS_WITH_STORE_FALSE_AS_NIL;
local l_GENERIC_HANDLERS_WITHOUT_STORE_FALSE_AS_NIL;
local l_CLIENT_METATABLE;


local l_clients;


do
	if (o.t_GetLocals ~= nil) then
		l_GENERIC_HANDLERS_WITH_STORE_FALSE_AS_NIL, l_GENERIC_HANDLERS_WITHOUT_STORE_FALSE_AS_NIL, l_CLIENT_METATABLE, l_clients = o.t_GetLocals();
	else
		l_GENERIC_HANDLERS_WITH_STORE_FALSE_AS_NIL = {};
		l_GENERIC_HANDLERS_WITHOUT_STORE_FALSE_AS_NIL = {};
		l_CLIENT_METATABLE = {};
		l_clients = {};
	end
	l_CLIENT_METATABLE.__index = m;
end




function l_t_GetLocals()
	l_t_GetLocals = nil;
	o.t_GetLocals = nil;
	
	return l_GENERIC_HANDLERS_WITH_STORE_FALSE_AS_NIL, l_GENERIC_HANDLERS_WITHOUT_STORE_FALSE_AS_NIL, l_clients;
end

o.t_GetLocals = l_t_GetLocals;




do
	local IsLoggedIn = IsLoggedIn;
	
	function l_RegisterClient(configTableName, handlers, defaults, configMetatable, onLoadFunc, runOnChangeOnLoad)
		if (l_clients[configTableName] ~= nil) then
			error(("ConfigManager1.RegisterClient: Client with config table named \"%s\" is already registered."):format(configTableName));
		end
		
		local clientInfo = {
		  configTable = nil, configTableName = configTableName,
		  handlers = handlers, defaults = defaults,
		  configMetatable = configMetatable,
		  onLoadFunc = onLoadFunc,
		  runOnChangeOnLoad = ((runOnChangeOnLoad and true) or nil)
		};
		setmetatable(clientInfo, l_CLIENT_METATABLE);
		l_clients[configTableName] = clientInfo;
		
		if (IsLoggedIn() ~= nil) then
			l_InitClient(configTableName, clientInfo);
		else
			EventsManager1.RegisterForEvent(o, nil, "VARIABLES_LOADED", false, false);
		end
		
		return clientInfo;
	end
end

o.RegisterClient = l_RegisterClient;



function l_GetClient(configTableName)
	return l_clients[configTableName];
end

o.GetClient = l_GetClient;



if (IsLoggedIn() == nil) then
	function o.OnEvent_VARIABLES_LOADED()
		o.OnEvent_VARIABLES_LOADED = nil;
		
		for configTableName, clientInfo in pairs(l_clients) do
			l_InitClient(configTableName, clientInfo);
		end
	end
end



do
	local setmetatable = setmetatable;
	local _G = _G;
	
	function l_InitClient(configTableName, clientInfo)
		local configTable = clientInfo.configTable;
		if (configTable == nil) then
			configTable = _G[configTableName];
			if (configTable == nil) then
				configTable = {};
				_G[configTableName] = configTable;
				if (clientInfo.configMetatable ~= nil) then
					setmetatable(configTable, clientInfo.configMetatable);
				end
				for key, value in pairs(clientInfo.defaults) do
					if (value == "<blank table>") then
						configTable[key] = {};
					else
						configTable[key] = value;
					end
				end
			else
				if (clientInfo.configMetatable ~= nil) then
					setmetatable(configTable, clientInfo.configMetatable);
				end
			end
			clientInfo.configTable = configTable;
		else
			if (clientInfo.configMetatable ~= nil) then
				setmetatable(configTable, clientInfo.configMetatable);
			end
		end
		clientInfo.defaults = nil;
		clientInfo.configMetatable = nil;
		
		if (clientInfo.onLoadFunc ~= nil) then
			clientInfo.onLoadFunc(configTable);
			clientInfo.onLoadFunc = nil;
		end
		
		local runOnChangeOnLoad = clientInfo.runOnChangeOnLoad;
		local onChange;
		for propertyName, handler in pairs(clientInfo.handlers) do
			if (runOnChangeOnLoad == true or handler.runOnChangeOnLoad == true) then
				handler.runOnChangeOnLoad = nil;
				onChange = handler.onChange;
				if (onChange ~= nil) then
					onChange(clientInfo:GetValue(propertyName), nil, propertyName);
				end
			end
		end
		clientInfo.runOnChangeOnLoad = nil;
	end
end



do
	local tableconcat = table.concat;
	
	function l_CreateGenericHandler(validInputTypes, storeFalseAsNil)
		local handler;
		
		if (stringmatch(validInputTypes, ",") ~= nil) then
			local alphabetized = { (","):split(validInputTypes) };
			for index, inputType in ipairs(alphabetized) do
				alphabetized[index] = inputType:trim(" ");
			end
			tablesort(alphabetized);
			validInputTypes = tableconcat(alphabetized, ",");
		end
		local handlersList;
		if (storeFalseAsNil == true) then
			handlersList = l_GENERIC_HANDLERS_WITH_STORE_FALSE_AS_NIL;
		else
			handlersList = l_GENERIC_HANDLERS_WITHOUT_STORE_FALSE_AS_NIL;
		end
		handler = handlersList[validInputTypes];
		if (handler == nil) then
			handler = { validInputTypes = validInputTypes, storeFalseAsNil = ((storeFalseAsNil == true and true) or nil) };
			handlersList[validInputTypes] = handler;
		end
		
		return handler;
	end
	
	o.CreateGenericHandler = l_CreateGenericHandler;
end




function l_GetValue(configTableName, propertyName, ...)
	local client = l_clients[configTableName];
	if (client == nil) then
		error(("ConfigManager1.GetValue: Undefined client for config table named %s"):format(tostring(configTableName)));
	end
	
	return client:GetValue(propertyName, ...);
end

o.GetValue = l_GetValue;


function m:GetValue(propertyName, ...)
	local handler = self.handlers[propertyName];
	if (handler == nil) then
		error(("ConfigManager1.GetValue: Unrecognized property name (\"%s\") in config table named %s"):format(tostring(propertyName), self.configTableName));
	end
	
	
	local operableTable = self.configTable;
	local finalAccessor = propertyName;
	
	local numAccessors = select("#", ...);
	local accessor;
	local prevAccessor = propertyName;
	local valid, reasonInvalid;
	for index = 1, numAccessors, 1 do
		accessor = select(index, ...);
		valid, reasonInvalid, accessor = l_ValidateAccessor(handler, accessor);
		if (valid == true) then
			operableTable = operableTable[prevAccessor];
			if (index == numAccessors) then
				finalAccessor = accessor;
			else
				if (handler.subHandlers ~= nil) then
					handler = (handler.subHandlers[prevAccessor] or handler.subHandlers["<any>"]);
				end
			end
			prevAccessor = accessor;
		else
			error(("ConfigManager1.GetValue: Accessor \"%s\" was invalid for config table \"%s\", for the following reason: %s"):format(tostring(accessor), self.configTableName, tostring(reasonInvalid or UNKNOWN)));
		end
	end
	
	if (handler.realTableIndex ~= nil) then
		local nextOperable = operableTable[handler.realTableIndex];
		if (nextOperable == nil) then
			nextOperable = {};
			operableTable[handler.realTableIndex] = nextOperable;
		end
		operableTable = nextOperable;
	end
	
	
	local value = operableTable[finalAccessor];
	if (value == nil and handler.storeFalseAsNil == true) then
		value = false;
	end
	return value;
end



function l_SetValue(configTableName, propertyName, ...)
	local client = l_clients[configTableName];
	if (client == nil) then
		error(("ConfigManager1.SetValue: Undefined client for config table named %s"):format(tostring(configTableName)));
	end
	
	return client:SetValue(propertyName, ...);
end

o.SetValue = l_SetValue;


function m:SetValue(propertyName, ...)
	local handler = self.handlers[propertyName];
	if (handler == nil) then
		error(("ConfigManager1.SetValue: Unrecognized property name (\"%s\") in config table named %s"):format(tostring(propertyName), self.configTableName));
	end
	
	
	local numArgs = select("#", ...);
	local operableTable = self.configTable;
	local finalAccessor = propertyName;
	
	local numAccessors = (numArgs - 1);
	local accessor;
	local prevAccessor = propertyName;
	local valid, reasonInvalid;
	for index = 1, numAccessors, 1 do
		accessor = select(index, ...);
		valid, reasonInvalid, accessor = l_ValidateAccessor(handler, accessor);
		if (valid == true) then
			operableTable = operableTable[prevAccessor];
			if (index == numAccessors) then
				finalAccessor = accessor;
			else
				if (handler.subHandlers ~= nil) then
					handler = (handler.subHandlers[prevAccessor] or handler.subHandlers["<any>"]);
				end
			end
			prevAccessor = accessor;
		else
			error(("ConfigManager1.GetValue: Accessor \"%s\" was invalid for config table \"%s\", for the following reason: %s"):format(tostring(accessor), self.configTableName, tostring(reasonInvalid or UNKNOWN)));
		end
	end
	
	if (handler.realTableIndex ~= nil) then
		local nextOperable = operableTable[handler.realTableIndex];
		if (nextOperable == nil) then
			nextOperable = {};
			operableTable[handler.realTableIndex] = nextOperable;
		end
		operableTable = nextOperable;
	end
	
	
	local newValue = ((numArgs ~= 0 and select(numArgs, ...)) or nil);
	
	local modifiers = handler.inputModifiers;
	if (modifiers ~= nil) then
		newValue = l_ApplyModifiers(modifiers, newValue);
	end
	
	local validInputTypes = handler.validInputTypes;
	if (validInputTypes ~= nil) then
		if (validInputTypes == "string") then
			local newValueType = type(newValue);
			if (newValueType == "number") then
				newValue = tostring(newValue);
			elseif (newValueType ~= "string") then
				newValue = nil;
			end
		elseif (validInputTypes == "number") then
			newValue = tonumber(newValue);
		elseif (validInputTypes == "boolean") then
			newValue = ((newValue and true) or false);
		end
		if (stringmatch(validInputTypes, type(newValue), 1, true) == nil) then
			error(("ConfigManager1.SetValue: Invalid input type (%s) for property \"%s\" of config table \"%s\""):format(type(newValue), tostring(propertyName), self.configTableName));
		end
	end
	
	if (handler.extraInputValidators ~= nil) then
		local isValid, reasonInvalid = l_CheckExtraValidators(handler.extraInputValidators, newValue);
		if (isValid == false) then
			error(("ConfigManager1.SetValue: Invalid input (\"%s\") for property \"%s\" of config table \"%s\", for the following reason: %s."):format(tostring(newValue), tostring(propertyName), self.configTableName, (reasonInvalid or NONE)));
		end
	end
	
	
	if (newValue == false and handler.storeFalseAsNil == true) then
		newValue = nil;
	end
	local oldValue = operableTable[finalAccessor];
	operableTable[finalAccessor] = newValue;
	if (oldValue ~= newValue) then
		local func = handler.onChange;
		if (func ~= nil) then
			func(newValue, oldValue, finalAccessor);
		end
	end
	
	if (newValue == nil and handler.storeFalseAsNil == true) then
		newValue = false;
	end
	return newValue;
end




function l_ValidateAccessor(handler, accessor)
	if (handler == nil) then
		return false, ("handler was nil"), nil;
	end
	if (accessor == nil) then
		return false, ("accessor was nil"), nil;
	end
	
	local modifiers = handler.accessorModifiers;
	if (modifiers ~= nil) then
		accessor = l_ApplyModifiers(modifiers, accessor);
	end
	
	local validAccessorTypes = handler.validAccessorTypes;
	if (validAccessorTypes ~= nil) then
		if (validAccessorTypes == "string") then
			local accessorType = type(accessor);
			if (accessorType == "number") then
				accessor = tostring(accessor);
			elseif (accessorType ~= "string") then
				accessor = nil;
			end
		elseif (validAccessorTypes == "number") then
			accessor = tonumber(accessor);
		elseif (validAccessorTypes == "boolean") then
			accessor = ((accessor and true) or false);
		end
		if (stringmatch(validAccessorTypes, type(accessor), 1, true) == nil) then
			return false, ("invalid type"), nil;
		end
	end
	
	if (handler.extraAccessorValidators ~= nil) then
		local isValid, reasonInvalid = l_CheckExtraValidators(handler.extraAccessorValidators, accessor);
		if (isValid == false) then
			return false, reasonInvalid, nil;
		end
	end
	
	return true, nil, accessor;
end




do
	local ipairs = ipairs;
	local stringformat = string.format;
	
	function l_ApplyModifiers(modifiers, value)
		local valueType = type(value);
		if (valueType ~= "string" and valueType ~= "number") then
			return value;
		end
		
		local modifierType;
		if (type(modifiers) == "table") then
			for index, modifier in ipairs(modifiers) do
				modifierType = type(modifier);
				if (modifierType == "string") then
					value = stringformat(modifier, value);
				elseif (modifierType == "function") then
					value = modifier(value);
				end
			end
		else
			modifierType = type(modifiers);
			if (modifierType == "string") then
				value = stringformat(modifiers, value);
			elseif (modifierType == "function") then
				value = modifiers(value);
			end
		end
		return value;
	end
end




function l_CheckExtraValidators(extraValidators, arg)
	local valid = true;
	local doesMatch, reasonInvalid;
	
	local one = extraValidators.matchOne;
	if (valid == true and one ~= nil) then
		local oneMatches = false;
		local index = 1;
		local validator = one[1];
		while (oneMatches == false and validator ~= nil) do
			doesMatch, reasonInvalid = l_DoesExtraValidatorMatch(arg, validator);
			if (doesMatch == true) then
				oneMatches = true;
			else
				index = (index + 1);
				validator = one[index];
			end
		end
		if (oneMatches == false) then
			valid = false;
		end
	end
	
	local all = extraValidators.matchAll;
	if (valid == true and all ~= nil) then
		local allMatch = true;
		local index = 1;
		local validator = all[1];
		while (allMatch == true and validator ~= nil) do
			doesMatch, reasonInvalid = l_DoesExtraValidatorMatch(arg, validator);
			if (doesMatch == false) then
				allMatch = false;
			else
				index = (index + 1);
				validator = all[index];
			end
		end
		if (allMatch == false) then
			valid = false;
		end
	end
	
	return valid, reasonInvalid;
end


function l_DoesExtraValidatorMatch(arg, validator)
	local doesMatch, invalidText;
	
	local valType = validator.validatorType;
	
	if (valType == "index-table") then
		doesMatch = (validator.tableToIndex[arg] == validator.expectedValue);
		
	elseif (valType == "number-comparison") then
		doesMatch = true;
		local low, high = validator.low, validator.high;
		if (low ~= nil) then
			if (validator.lowInclusive == true) then
				if (low <= arg) then
					doesMatch = false;
				end
			else
				if (low < arg) then
					doesMatch = false;
				end
			end
		end
		if (high ~= nil and doesMatch == true) then
			if (validator.highInclusive == true) then
				if (high <= arg) then
					doesMatch = false;
				end
			else
				if (high < arg) then
					doesMatch = false;
				end
			end
		end
		
	elseif (valType == "string-comparison") then
		doesMatch = (stringmatch(arg, validator.stringMatcher) ~= nil);
		
	elseif (valType == "custom") then
		local success;
		success, doesMatch = pcall(validator.func, arg);
		if (success == false) then
			invalidText = doesMatch;
			doesMatch = false;
		end
		
	else
		error(("ConfigManager1: Unrecognized validator type: \"%s\"."):format(tostring(valType)));
	end
	
	return doesMatch, (invalidText or validator.invalidText);
end

