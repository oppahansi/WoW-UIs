

local o = EventsManager1; if (o.SHOULD_LOAD == nil) then return; end


local l_t_GetLocals; -- scriptsFrame, oneTimeEvents, customEvents, handlersByEvent = ()

local l_DispatchEvent; -- (event, ...)
local l_OnEvent; -- (scriptsFrame, event, ...)

local l_IsCustomEventAvailable; -- isAvailable, oneTimeOnly = (event)
local l_AddCustomEvent; -- (event, oneTimeOnly)
local l_RemoveCustomEvent; -- (event)

local l_GetHandlerData; -- keyName, sendHandler, sendEvent, ... = (handlerObj, event)
local l_RegisterForEvent; -- (handlerObj, keyName, event, sendHandler, sendEvent)
local l_UnregisterForAllEvents; -- (handlerObj)
local l_UnregisterForEvent; -- (handlerObj, event)

local l_CreateHandler; -- handler = (keyName, sendHandler, sendEvent, ...)
local l_ReadHandler; -- keyName, sendHandler, sendEvent, hasExtraArgs = (handler)

local l_IsDefaultEvent; -- isDefaultEvent = (event)


local type = type; -- Damn near everything.
local unpack = unpack; -- DispatchEvent, GetHandlerData
local pairs = pairs; -- DispatchEvent, RemoveCustomEvent, UnregisterForAllEvents


local l_SCRIPTS_FRAME;


local l_oneTimeEvents;
local l_customEvents;
local l_handlersByEvent;


do
	if (o.t_GetLocals ~= nil) then
		l_SCRIPTS_FRAME, l_oneTimeEvents, l_customEvents, l_handlersByEvent = o.t_GetLocals();
	else
		l_SCRIPTS_FRAME = o.SCRIPTS_FRAME;
		o.SCRIPTS_FRAME = nil;
		if (l_SCRIPTS_FRAME == nil) then
			l_SCRIPTS_FRAME = CreateFrame("Frame", "EventsManager1_ScriptsFrame", WorldFrame, nil);
			l_SCRIPTS_FRAME:Hide();
		end
		l_oneTimeEvents = (
		  o.oneTimeEvents
		  or {
			["VARIABLES_LOADED"] = true;
			["PLAYER_LOGIN"] = true;
			["PLAYER_LOGOUT"] = true;
		  }
		);
		o.oneTimeEvents = nil;
		l_customEvents = (
		  o.customEvents
		  or {
			--["EventsManager1_HANDLER_REGISTERED"] = false;
			--["EventsManager1_HANDLER_UNREGISTERED"] = false;
		    ["EventsManager1_CUSTOM_EVENT_ADDED"] = false;
			["EventsManager1_CUSTOM_EVENT_REMOVED"] = false;
		  }
		);
		o.customEvents = nil;
		l_handlersByEvent = (o.handlersByEvent or {});
		o.handlersByEvent = nil;
	end
end




function l_t_GetLocals()
	l_t_GetLocals = nil;
	o.t_GetLocals = nil;
	
	return l_SCRIPTS_FRAME, l_oneTimeEvents, l_customEvents, l_handlersByEvent;
end

o.t_GetLocals = l_t_GetLocals;




do
	local select = select;
	local pcall = pcall;
	local tableinsert = table.insert;
	local tableremove = table.remove;
	
	function l_DispatchEvent(event, ...)
		local handlers = l_handlersByEvent[event];
		if (handlers == nil) then
			if (l_oneTimeEvents[event] == true) then
				l_oneTimeEvents[event] = nil;
				if (l_customEvents[event] ~= nil) then
					l_RemoveCustomEvent(event);
				end
			end
			return;
		end
		
		
		local errorsArray;
		
		local argsArray;
		local success, errorText;
		local keyName, sendHandler, sendEvent, hasExtraArgs, func;
		
		for handlerObj, handlerKey in pairs(handlers) do
			keyName, sendHandler, sendEvent, hasExtraArgs = l_ReadHandler(handlerKey);
			
			if (keyName == "") then
				func = handlerObj;
			else
				func = (handlerObj[keyName] or handlerObj["OnEvent"]);
			end
			if (func == nil) then
				if (errorsArray == nil) then
					errorsArray = {};
				end
				tableinsert(errorsArray, ("EventsManager1.DispatchEvent: There was no handler function for handlerObj \"%s\" (first key \"%s\"), with handlerKey \"%s\", during dispatch of event %s."):format(tostring(handlerObj), ((type(handlerObj) == "table" and tostring(next(handlerObj, nil))) or "<n/a>"), handlerKey, event));
			else
				if (hasExtraArgs == true) then
					if (argsArray == nil) then
						argsArray = {};
					end
					if (sendHandler == true) then
						tableinsert(argsArray, handlerObj);
					end
					if (hasExtraArgs == true) then
						for index = 4, #handlerKey, 1 do
							tableinsert(argsArray, handlerKey[index]);
						end
					end
					if (sendEvent == true) then
						tableinsert(argsArray, event);
					end
					for index = 1, select("#", ...), 1 do
						tableinsert(argsArray, (select(index, ...)));
					end
					
					success, errorText = pcall(func, unpack(argsArray, 1, #argsArray));
					
					for index = #argsArray, 1, -1 do
						tableremove(argsArray);
					end
				else
					if (sendHandler == true) then
						if (sendEvent == true) then
							success, errorText = pcall(func, handlerObj, event, ...);
						else
							success, errorText = pcall(func, handlerObj, ...);
						end
					else
						if (sendEvent == true) then
							success, errorText = pcall(func, event, ...);
						else
							success, errorText = pcall(func, ...);
						end
					end
				end
				
				if (success == false) then
					if (errorsArray == nil) then
						errorsArray = {};
					end
					tableinsert(errorsArray, errorText);
				end
			end
		end
		
		
		if (l_oneTimeEvents[event] == true) then
			l_oneTimeEvents[event] = nil;
			for handlerObj in pairs(handlers) do
				l_UnregisterForEvent(handlerObj, event);
			end
			if (l_customEvents[event] ~= nil) then
				l_RemoveCustomEvent(event);
			end
		end
		
		
		if (errorsArray ~= nil) then
			local chatFrame = DEFAULT_CHAT_FRAME;
			local addMsg = chatFrame.AddMessage;
			addMsg(chatFrame, ("EventsManager1: Errors occurred during dispatch of the event named %s. The errors, in order, follow:"):format(event));
			for index, errorText in ipairs(errorsArray) do
				addMsg(chatFrame, ("Error %d: %s"):format(index, errorText));
			end
		end
	end
end

o.DispatchEvent = l_DispatchEvent;



do
	function l_OnEvent(scriptsFrame, event, ...)
		l_DispatchEvent(event, ...);
		if (l_handlersByEvent[event] == nil) then
			scriptsFrame:UnregisterEvent(event);
		end
	end

	l_SCRIPTS_FRAME:SetScript("OnEvent", l_OnEvent);
end




function l_IsCustomEventAvailable(event)
	if (type(event) ~= "string") then
		error(("EventsManager1.IsCustomEventAvailable: Bad argument #1; expected string, received %s."):format(type(event)));
	end
	if (l_IsDefaultEvent(event) == true) then
		error(("EventsManager1.IsCustomEventAvailable: %s is a default event."):format(event));
	end
	
	local onceOnly = l_customEvents[event];
	return (onceOnly ~= nil), onceOnly;
end

o.IsCustomEventAvailable = l_IsCustomEventAvailable;



function l_AddCustomEvent(event, isOnceOnly)
	if (type(event) ~= "string") then
		error(("EventsManager1.AddCustomEvent: Bad argument #1; expected string, received %s."):format(type(event)));
	end
	if (l_IsDefaultEvent(event) == true) then
		error(("EventsManager1.AddCustomEvent: Cannot add a default event, %s, as a custom event."):format(event));
	end
	isOnceOnly = ((isOnceOnly and true) or false);
	
	local existing = l_customEvents[event];
	if (existing ~= nil) then
		if (existing ~= isOnceOnly) then
			error(("EventsManager1.AddCustomEvent: Custom event named %s already exists."):format(event));
		end
	else
		l_customEvents[event] = isOnceOnly;
		l_oneTimeEvents[event] = (isOnceOnly or nil);
		l_DispatchEvent("EventsManager1_CUSTOM_EVENT_ADDED", event, isOnceOnly);
	end
end

o.AddCustomEvent = l_AddCustomEvent;



function l_RemoveCustomEvent(event)
	if (type(event) ~= "string") then
		error(("EventsManager1.RemoveCustomEvent: Bad argument #1; expected string, received %s."):format(type(event)));
	end
	if (event == "EventsManager1_CUSTOM_EVENT_ADDED" or event == "EventsManager1_CUSTOM_EVENT_REMOVED") then
		error(("EventsManager1.RemoveCustomEvent: Custom event \"%s\" cannot be removed."):format(event));
	end
	
	local isOnceOnly = l_customEvents[event];
	if (isOnceOnly ~= nil) then
		l_customEvents[event] = nil;
		l_oneTimeEvents[event] = nil;
		if (l_handlersByEvent[event] ~= nil) then
			for handlerObj in pairs(l_handlersByEvent[event]) do
				l_UnregisterForEvent(handlerObj, event);
			end
			l_handlersByEvent[event] = nil;
		end
		l_DispatchEvent("EventsManager1_CUSTOM_EVENT_REMOVED", event, isOnceOnly);
	end
end

l_RemoveCustomEvent("EventsManager1_EVENT_REGISTERED");
l_RemoveCustomEvent("EventsManager1_EVENT_UNREGISTERED");
o.RemoveCustomEvent = l_RemoveCustomEvent;




function l_GetHandlerData(handlerObj, event)
	if (type(handlerObj) ~= "table" and type(handlerObj) ~= "function") then
		error(("EventsManager1.GetHandlerData: Bad argument #1; expected table or function, received %s."):format(type(handlerObj)));
	end
	
	if (l_IsDefaultEvent(event) == false and l_customEvents[event] == nil) then
		error(("EventsManager1.GetHandlerData: Unknown event name: %s."):format(tostring(event)));
	end
	
	local handlersForEvent = l_handlersByEvent[event];
	if (handlersForEvent ~= nil) then
		local handlerKey = handlersForEvent[handlerObj];
		if (handlerKey ~= nil) then
			local keyName, sendHandler, sendEvent, hasExtraArgs = l_ReadHandler(handlerKey);
			if (hasExtraArgs == true) then
				return keyName, sendHandler, sendEvent, unpack(handlerKey, 4, #handlerKey);
			else
				return keyName, sendHandler, sendEvent;
			end
		end
	end
	return nil, nil, nil;
end

o.GetHandlerData = l_GetHandlerData;



function l_RegisterForEvent(handlerObj, keyName, event, sendHandler, sendEvent, ...)
	if (type(handlerObj) ~= "table" and type(handlerObj) ~= "function") then
		error(("EventsManager1.RegisterForEvent: Bad argument #1; expected table or function, received %s."):format(type(handlerObj)));
	end
	if (type(event) ~= "string") then
		error(("EventsManager1.RegisterForEvent: Bad argument #3; expected string, received %s."):format(type(event)));
	end
	
	
	local isDefaultEvent = l_IsDefaultEvent(event);
	
	if (isDefaultEvent == true or l_customEvents[event] ~= nil) then
		keyName = ((type(handlerObj) == "function" and "") or (keyName == nil and ("OnEvent_" .. event)) or keyName);
		sendHandler = ((sendHandler and true) or false);
		sendEvent = ((sendEvent and true) or false);
		
		local handlersForEvent = l_handlersByEvent[event];
		local existingHandler = ((handlersForEvent ~= nil and handlersForEvent[handlerObj]) or nil);
		if (existingHandler ~= nil) then
			local existingKeyName, existingSendHandler, existingSendEvent, existingHasExtraArgs = l_ReadHandler(existingHandler);
			local allMatches = (existingKeyName == keyName and existingSendHandler == sendHandler and existingSendEvent == sendEvent);
			if (allMatches == true) then
				if (existingHasExtraArgs == true) then
					if (select("#", ...) == 0) then
						allMatches = false;
					else
						for index = 4, #existingHandler, 1 do
							if (existingHandler[index] ~= select((index - 3), ...)) then
								allMatches = false;
							end
						end
					end
				else
					if (select("#", ...) ~= 0) then
						allMatches = false;
					end
				end
			end
			if (allMatches == true) then
				-- This is already registered with this exact configuration, no need to error or proceed at all.
				return;
			else
				-- Trying to register an already-registered event with a different configuration.
				error(
				  ("EventsManager1.RegisterForEvent: Event \"%s\" is already registered to handler \"%s\" (first key \"%s\") with keyName \"%s\"."):format(
				    event, tostring(handlerObj), tostring((type(handlerObj) == "table" and next(handlerObj)) or "n/a"), tostring(existingKeyName)
				  )
				);
			end
		end
		
		if (handlersForEvent == nil) then
			handlersForEvent = {};
			l_handlersByEvent[event] = handlersForEvent;
			if (isDefaultEvent == true) then
				l_SCRIPTS_FRAME:RegisterEvent(event);
			end
		end
		
		handlersForEvent[handlerObj] = l_CreateHandler(keyName, sendHandler, sendEvent, ...);
		--l_DispatchEvent("EventsManager1_HANDLER_REGISTERED", event, handlerObj, keyName, sendEvent, sendHandler, ...);
	else
		error(("EventsManager1.RegisterForEvent: Unknown event name: %s."):format(tostring(event)));
	end
end

o.RegisterForEvent = l_RegisterForEvent;



function l_UnregisterForEvent(handlerObj, event)
	if (type(handlerObj) ~= "table" and type(handlerObj) ~= "function") then
		error(("EventsManager1.UnregisterForEvent: Bad argument #1; expected table or function, received %s."):format(type(handlerObj)));
	end
	if (type(event) ~= "string") then
		error(("EventsManager1.UnregisterForEvent: Bad argument #2; expected string, received %s."):format(type(event)));
	end
	
	
	local isDefaultEvent = l_IsDefaultEvent(event);
	
	if (isDefaultEvent == true or l_customEvents[event] ~= nil) then
		local handlersForEvent = l_handlersByEvent[event];
		local handler = ((handlersForEvent ~= nil and handlersForEvent[handlerObj]) or nil);
		if (handler ~= nil) then
			local keyName, sendHandler, sendEvent, hasExtraArgs = l_ReadHandler(handler);
			
			handlersForEvent[handlerObj] = nil;
			
			if (next(handlersForEvent) == nil) then
				l_handlersByEvent[event] = nil;
				if (isDefaultEvent == true) then
					l_SCRIPTS_FRAME:UnregisterEvent(event);
				end
			end
			
			--[[
			if (hasExtraArgs == true) then
				l_DispatchEvent("EventsManager1_HANDLER_UNREGISTERED", event, handlerObj, keyName, sendHandler, sendEvent, unpack(handler, 4, #handler));
			else
				l_DispatchEvent("EventsManager1_HANDLER_UNREGISTERED", event, handlerObj, keyName, sendHandler, sendEvent);
			end
			--]]
		end
	else
		error(("EventsManager1.UnregisterForEvent: Unknown event name: %s."):format(tostring(event)));
	end
end

o.UnregisterForEvent = l_UnregisterForEvent;


function l_UnregisterForAllEvents(handlerObj)
	if (type(handlerObj) ~= "table" and type(handlerObj) ~= "function") then
		error(("EventsManager1.UnregisterForAllEvents: Bad argument #1; expected table or function, received %s."):format(type(handlerObj)));
	end
	
	for eventName, handlers in pairs(l_handlersByEvent) do
		if (handlers[handlerObj] ~= nil) then
			l_UnregisterForEvent(handlerObj, eventName);
		end
	end
end

o.UnregisterForAllEvents = l_UnregisterForAllEvents;




function l_CreateHandler(keyName, sendHandler, sendEvent, ...)
	local handler;
	if (select("#", ...) ~= 0) then
		handler = { keyName, sendHandler, sendEvent, ... };
	else
		handler = ("%s%s-%s"):format(
			((sendHandler == true and "1") or "0"),
			((sendEvent == true and "1") or "0"),
			keyName
		);
	end
	return handler;
end


do
	local stringmatch = string.match;
	local stringsub = string.sub;
	
	function l_ReadHandler(handler)
		local keyName, sendHandler, sendEvent, hasExtraArgs;
		if (type(handler) == "string") then
			local settings, matchedKeyName = stringmatch(handler, "^(%d*)%-?(.*)$");
			sendHandler = (stringsub(settings, 1, 1) == "1");
			sendEvent = (stringsub(settings, 2, 2) == "1");
			keyName = matchedKeyName;
			hasExtraArgs = false;
		else
			keyName = handler[1];
			sendHandler = handler[2];
			sendEvent = handler[3];
			hasExtraArgs = true;
		end
		return keyName, sendHandler, sendEvent, hasExtraArgs;
	end
end




function l_IsDefaultEvent(event)
	local isDefaultEvent = false;
	if (l_SCRIPTS_FRAME:IsEventRegistered(event) ~= nil) then
		isDefaultEvent = true;
	else
		-- Hack: Try to register the event with the scripts frame. If it takes, then the event has to be a default event, because only those will stick.
		l_SCRIPTS_FRAME:RegisterEvent(event);
		if (l_SCRIPTS_FRAME:IsEventRegistered(event) ~= nil) then
			isDefaultEvent = true;
			l_SCRIPTS_FRAME:UnregisterEvent(event);
		end
	end
	return isDefaultEvent;
end

