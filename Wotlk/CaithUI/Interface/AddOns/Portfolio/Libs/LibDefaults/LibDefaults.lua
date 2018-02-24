--------------------------------------------------------------------------
-- LibDefaults.lua 
--------------------------------------------------------------------------
--[[
LibDefaults

author: AnduinLothar    <karlkfi@yahoo.com>

-Saved Variable Initialization Library

Change List
v2.1
- Fixed a bug that broke non-table defaults
v2.0
- Added Meta-Indexing
Defaults are only saved in the default storage, not in the main table, 
but still allows you to get them from the main table. Saves on run-time memory!
Defaults wont be accessable via pairs() from the main table, 
unless you set the value to a non-default and then back to a default.
- Added Default Unloading
Removes defaults from the saved variables so that they aren't saved to disk. Speed up load time, yay!
- Added lib:Reset(addonName, varName) to reset an addons variable to default (and all table values to default)
v1.0
- Hopefully one version is enough!

$Date: 2007-07-03 21:22:03 -0500 (Tue, 03 Jul 2007) $
$Rev: 5009 $

]]--

local lib, oldminor = LibStub:NewLibrary("LibDefaults", 2.1 )
if not lib then return end

local print, quoteString, tableKeyValue, hashsize
local recursInit, getMetaIndex, recursReset, recursCleanup, OnEvent

--------------------------------------------------------------------------
-- Public
--------------------------------------------------------------------------

--[[
Register a saved variable's default value. 
For non-tables:
	if the variable is nil once the addon's saved variables are loaded, it will be set to the default value.
For tables:
	The variable will be set to an empty table which is meta-index-linked to the stored default table.
	Any time you access keys in the table the default will be returned, unless you set that key to a non-default value.
	This saves space in live memory because the defaults only reside in one place. 
	With the drawback that #, pairs and ipairs will not count the default values.

SetDefault also gives you the option to build your defaults on the fly without creating the containing tables.
It can handle N-depth table values by providing any number of keys. ex: _G["SavedVarName"][key1][key2] = value

The addon saved variable defaults will be initialized at the addon's ADDON_LOADED event, 
or they can be forced to load using lib:InitAddOn(addonName).

Usage:
	lib:SetDefault("MyAddOn", "SavedVar(Table)Name", [key1, [key2, [...] ] ], value)
Example Usage: 
	local lib = LibStub("LibDefaults")
	lib:SetDefault("MyAddOn", "SavedVarName", SavedVarValue)
]]--
function lib:SetDefault(addonName, varName, ...)
	if type(addonName) ~= "string" then
		error("LibDefaults:SetDefault - addonName must be a string.")
	elseif type(varName) ~= "string" then
		error("LibDefaults:SetDefault - global varName must be a string.")
	end
	for i=1, select("#", ...) do
		if select(i, ...) == nil then
			error("LibDefaults:SetDefault - table keys and values must be non-nil.")
		end
	end
	--print("SetDefault: ", addonName, varName, ...)
	if not self.addonVars[addonName] then
		self.addonVars[addonName] = {}
	end
	tinsert(self.addonVars[addonName], { varName = varName; value = {...}; } )
end

--[[
Register a function to be executed once an addon's variables have been loaded. 
Fires after addon defaults have been initialized.

Usage:
	lib:SetScript("MyAddOn", function)
Example Usage: 
	local lib = LibStub("LibDefaults")
	lib:SetScript("MyAddOn", function(addonName) dostuff() end)
]]--
function lib:SetScript(addonName, func)
	if type(addonName) ~= "string" then
		error("LibDefaults:SetScript - addonName must be a string.")
	elseif type(func) ~= "function" then
		error("LibDefaults:SetScript - func must be a function.")
	end
	if not self.addonScripts[addonName] then
		self.addonScripts[addonName] = {}
	end
	tinsert(self.addonScripts[addonName], func)
end

--[[
Reset you addon's global variable back to default.
Also recursively resets all table values and sub-tables.

Usage:
	lib:SetDefault("MyAddOn", "SavedVar(Table)Name")
Example Usage: 
	local lib = LibStub("LibDefaults")
	lib:SetDefault("MyAddOn", "SavedVarName")
]]--
function lib:Reset(addonName, varName)
	if type(addonName) ~= "string" then
		error("LibDefaults:Reset - addonName must be a string.")
	elseif type(varName) ~= "string" then
		error("LibDefaults:Reset - global varName must be a string.")
	end
	storage = self.addonVarStorage[addonName]
	if storage and storage[varName] then
		-- Clean everything but the root var, so we don't have to rewrite the meta-index
		recursReset(_G, varName, storage[varName])
	end
end

--------------------------------------------------------------------------
-- Init/Cleanup funcs
--------------------------------------------------------------------------

function lib:InitAddOn(addonName)
	if self.addonVars[addonName] then
		--print("InitAddOn: ", addonName)
		-- Init cold storage
		local storage = {}
		local varName;
		-- Initialize Variables that are nil
		for i, set in ipairs(self.addonVars[addonName]) do
			varName = set.varName
			
			--Backup Defaults
			recursInit(storage, _G, varName, unpack(set.value))
			
			if #(set.value) == 1 and type(set.value[1]) ~= "table" then
				-- Just init non-tables
				_G[varName] = set.value[1]
			else
				-- Recursive Meta-Indexing
				_G[varName] = getMetaIndex(_G[varName], storage[varName])
			end
		end
		-- Empty the list
		self.addonVars[addonName] = nil
		self.addonVarStorage[addonName] = storage
	end
	if self.addonScripts[addonName] then
		-- execute scripts
		for i, func in ipairs(self.addonScripts[addonName]) do
			func(addonName)
		end
		-- Empty the list
		self.addonScripts[addonName] = nil
	end
end

function lib:CleanupAddOn(addonName)
	if self.addonVarStorage[addonName] then
		for k, defaults in pairs(self.addonVarStorage[addonName]) do
			recursCleanup(_G, k, defaults)
		end
	end
end

--------------------------------------------------------------------------
-- Private Helper Funcs
--------------------------------------------------------------------------

function print(...)
	local txt = ""
	for i=1, select("#", ...) do
		txt = txt..tostring(select(i, ...)).."  "
	end
	(SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):AddMessage(txt)
end

function quoteString(str)
	if type(str) == "string" then
		return "\""..str.."\""
	else
		return tostring(str)
	end
end

function tableKeyValue(t, k, v)
	return "( "..tostring(t).."["..quoteString(k).."] = "..quoteString(v).." )"
end

function hashsize(tbl)
	local size = 0
	for k,v in pairs(tbl) do
		size = size + 1
	end
	return size
end

--------------------------------------------------------------------------
-- Private
--------------------------------------------------------------------------

lib.addonScripts = {}
lib.addonVars = {}
lib.addonVarStorage = {}

-- Initialization of Defaults
function recursInit(defaultTable, t, key, keyOrValue, ...)
	if select("#", ...) > 0 then
		if type(defaultTable[key]) ~= "table" then
			--init non-existant or replace non-table
			if defaultTable[key] ~= nil then
				print("LibDefaults: Overwriting preset default value "
					..tableKeyValue(defaultTable, key, defaultTable[key])
					.." with a table.")
			end
			defaultTable[key] = {}
		end
		local tt = t and t[key]
		if tt ~= nil and type(tt) ~= "table" then
			error("LibDefaults: Cannot set default value "
				..tableKeyValue(defaultTable, key, keyOrValue)
				.." because live value "
				..tableKeyValue(t, key, t[key])
				.." exists and is not a table.")
		end 
		recursInit(defaultTable[key], tt, keyOrValue, ...)
	else
		if defaultTable[key] ~= nil and defaultTable[key] ~= keyOrValue then
			print("LibDefaults: Overwriting preset default value "
				..tableKeyValue(defaultTable, key, defaultTable[key])
				.." with ( "..tostring(keyOrValue).." ).")
		end
		defaultTable[key] = keyOrValue
	end
end

-- Table and Sub-Table Meta-Indexing
function getMetaIndex(t, defaultTable)
	if type(defaultTable) ~= "table" then
		error("LibDefaults:getMetaIndex - defaultTable is not a table")
	end
	
	-- turn existing tables into metatables if they are also in the defaultTable
	if type(t) == "table" then
		for k,v in pairs(t) do
			if type(v) == "table" and type(defaultTable[k]) == "table" then
				t[k] = getMetaIndex(v, defaultTable[k])
			end
		end
	end
	
	-- create a meta-index that, when t[key] == nil: 
	--		returns defaultTable[key], if t[key] == nil; 
	--		or creates and returns a new table with metaindex, if defaultTable[key] is a table
	-- create a meta-newindex that, when value == defaultTable[key] nothing is saved in live memory 
	return setmetatable(t or {}, {
		__index = function(tbl, key)
			if type(defaultTable[key]) == "table" then
				--print("__index (default tbl): ", tbl, key)
				tbl[key] = getMetaIndex({}, defaultTable[key])
				--return tbl[key]
				return rawget(tbl, key)
			else
				--print("__index: ", tbl, key)
				--return defaultTable[key]
				return rawget(defaultTable, key)
			end
		end;
		__newindex = function(tbl, key, value)
			if value ~= nil and value == defaultTable[key] then
				--print("__newindex (ignore): ", tbl, key, value)
			else
				--print("__newindex: ", tbl, key, value)
				rawset(tbl, key, value)
			end
		end
	})
end

-- Reset of Defaults
function recursReset(t, key, defaultValue)
	local value = rawget(t, key)
	if type(value) == "table" and type(defaultValue) == "table" then
		-- Cleanup sub tables
		for i, v in pairs(defaultValue) do
			recursReset(value, i, v)
		end
		-- Don't Remove empty tables, they're already metaindexed
	elseif defaultValue ~= nil then
		if t == _G then
			-- Set root defaults
			t[key] = defaultValue
		else
			-- Remove defaults
			t[key] = nil
		end
	end
end

-- Removal of Defaults
function recursCleanup(t, key, defaultValue)
	local value = rawget(t, key)
	if type(value) == "table" and type(defaultValue) == "table" then
		-- Cleanup sub tables
		for i, v in pairs(defaultValue) do
			recursCleanup(value, i, v)
		end
		-- Remove empty tables
		if hashsize(value) == 0 then
			t[key] = nil
		end
	elseif value == defaultValue then
		-- Remove defaults
		t[key] = nil
	end
end

-- Event Handler
function OnEvent(self, event, addonName)
	if event == "ADDON_LOADED" then
		lib:InitAddOn(addonName)
	elseif event == "PLAYER_LOGOUT" then
		for addonName, defaultVars in pairs(lib.addonVarStorage) do
			lib:CleanupAddOn(addonName)
		end
	end
end

--------------------------------------------------------------------------
-- Event Frame
--------------------------------------------------------------------------

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", OnEvent)
lib.frame = frame
