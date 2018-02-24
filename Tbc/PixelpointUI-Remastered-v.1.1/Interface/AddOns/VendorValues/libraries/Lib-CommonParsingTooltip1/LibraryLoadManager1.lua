

if (LoadLibrary1 ~= nil) then
	return;
end


do
	local select = select;
	local type = type;
	local loadstring = loadstring;
	local stringsub = string.sub;
	local _G = _G;
	local l_knownLoaded = {};

	function LoadLibrary1(name, version, createFunc, cleanupFunc, ...)
		name = (name .. stringsub(version, 1, 1));
		local o = (l_knownLoaded[name] or _G[name]);
		
		if (o ~= nil and version <= o.VERSION) then
			o.SHOULD_LOAD = nil;
			return false, o;
		end
		
		local depName, depTable;
		for index = 1, select("#", ...), 1 do
			depName = (select(index, ...));
			if (l_knownLoaded[depName] == nil) then
				depTable = _G[dep];
				if (depTable == nil) then
					error(("%s requires %s to be loaded."):format(name, depName));
					if (o ~= nil) then
						o.SHOULD_LOAD = nil;
					end
					return false, o;
				else
					l_knownLoaded[depName] = depTable;
				end
			end
		end
		
		if (o == nil) then
			if (createFunc ~= nil) then
				if (type(createFunc) == "string") then
					createFunc = loadstring(createFunc)();
				end
				o = createFunc(name, version);
			else
				o = {};
			end
			_G[name] = o;
		else
			if (cleanupFunc == nil) then
				cleanupFunc = o.CLEANUP_FUNC;
			end
			if (cleanupFunc ~= nil) then
				cleanupFunc(o);
			end
		end
		o.OLD_VERSION = o.VERSION;
		o.VERSION = version;
		o.SHOULD_LOAD = true;
		l_knownLoaded[name] = o;
		return true, o;
	end
end

