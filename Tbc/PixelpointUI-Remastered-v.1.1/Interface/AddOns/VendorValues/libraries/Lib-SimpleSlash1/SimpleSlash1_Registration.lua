

local o = SimpleSlash1; if (o.SHOULD_LOAD == nil) then return; end


local l_t_GetLocals; -- clients, prefixes = ()

local l_RegisterClient; -- (clientName, handlerTable)
local l_GetClient; -- handlerTable = (clientName)
local l_UnregisterClient; -- (clientName)

local l_RegisterPrefix; -- (clientName, prefix)
local l_IsPrefixRegistered; -- (prefix)
local l_UnregisterPrefix; -- (clientName, prefix)


local _G = _G; -- UnregisterClient, RegisterPrefix, UnregisterPrefix
local SlashCmdList = SlashCmdList; -- RegisterClient, UnregisterClient
local hash_SlashCmdList = hash_SlashCmdList; -- UnregisterClient, UnregisterPrefix


local l_clients;
local l_prefixes;


do
	if (o.t_GetLocals ~= nil) then
		l_clients, l_prefixes = o.t_GetLocals();
	else
		l_clients = (o.clients or {});
		o.clients = nil;
		l_prefixes = (o.prefixes or {});
		o.prefixes = nil;
	end
end




function l_t_GetLocals()
	l_t_GetLocals = nil;
	o.t_GetLocals = nil;
	
	return l_clients, l_prefixes;
end

o.t_GetLocals = l_t_GetLocals;




function l_RegisterClient(name, info)
	if (l_clients[name] ~= nil) then
		error(("SimpleSlash1.RegisterClient: A client with name \"%s\" is already registered."):format(name));
	end
	if (SlashCmdList[name] ~= nil) then
		error(("SimpleSlash1.RegisterClient: A client with name \"%s\" already exists in the default SlashCmdList."):format(name));
	end
	
	SlashCmdList[name] = o.BuildCommandHandler(name);
	l_clients[name] = info;
end

o.RegisterClient = l_RegisterClient;



function l_GetClient(name)
	return l_clients[name];
end

o.GetClient = l_GetClient;



function l_UnregisterClient(name)
	if (l_clients[name] == nil) then
		return;
	end
	
	local index = 1;
	local currPrefix = _G["SLASH_" .. name .. index];
	while (currPrefix ~= nil) do
		_G["SLASH_" .. name .. index] = currPrefix;
		l_prefixes[currPrefix] = nil;
		hash_SlashCmdList[currPrefix] = nil;
		index = (index + 1);
		currPrefix = _G["SLASH_" .. name .. index];
	end
	
	SlashCmdList[name] = nil;
	l_clients[name] = nil;
end

o.UnregisterClient = l_UnregisterClient;




function l_RegisterPrefix(name, prefix)
	if (l_prefixes[prefix] ~= nil) then
		error(("SimpleSlash1.RegisterPrefix: The prefix \"%s\" is already registered."):format(prefix));
	end
	
	local index = 1;
	while (_G["SLASH_" .. name .. index] ~= nil) do
		index = (index + 1);
	end
	_G["SLASH_" .. name .. index] = prefix;
	l_prefixes[prefix] = index;
end

o.RegisterPrefix = l_RegisterPrefix;



function l_IsPrefixRegistered(prefix)
	return (l_prefixes[prefix] ~= nil);
end

o.IsPrefixRegistered = l_IsPrefixRegistered;



function l_UnregisterPrefix(name, prefix)
	if (l_prefixes[prefix] == nil) then
		return;
	end
	
	local index = l_prefixes[prefix];
	_G["SLASH_" .. name .. index] = nil; -- Remove this now in case there are no newer prefixes to overwrite it.
	index = (index + 1); -- Start displacing the rest of the prefixes to one index lower.
	local currPrefix = _G["SLASH_" .. name .. index];
	while (currPrefix ~= nil) do
		hash_SlashCmdList[currPrefix] = nil;
		_G["SLASH_" .. name .. (index - 1)] = currPrefix;
		index = (index + 1);
		currPrefix = _G["SLASH_" .. name .. index];
	end
	_G["SLASH_" .. name .. index] = nil; -- Remove the final, duplicate index.
	hash_SlashCmdList[prefix] = nil;
	l_prefixes[prefix] = nil;
end

o.UnregisterPrefix = l_UnregisterPrefix;

