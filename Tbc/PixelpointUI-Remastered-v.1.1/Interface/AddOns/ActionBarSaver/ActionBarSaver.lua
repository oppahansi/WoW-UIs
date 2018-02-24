--[[ 
	Action Bar Saver, Mayen/Selari (Horde) from Illidan (US) PvP
]]

ABS = {}

local L = ActionBarSaverLocals

local restoreErrors, spellCache, macroCache, highestRanks = {}, {}, {}, {}
local iconCache, playerClass

local MAX_MACROS = 54
local MAX_CHAR_MACROS = 18
local MAX_GLOBAL_MACROS = 36

function ABS:OnInitialize()
	local defaults = {
		macro = false,
		checkCount = false,
		restoreRank = true,
		spellSubs = {},
		sets = {}
	}
	
	ActionBarSaverDB = ActionBarSaverDB or {}
	
	self:FormatUpgrade()
	
	-- Load defaults in
	for key, value in pairs(defaults) do
		if( ActionBarSaverDB[key] == nil ) then
			ActionBarSaverDB[key] = value
		end
	end
	
	for classToken in pairs(RAID_CLASS_COLORS) do
		ActionBarSaverDB.sets[classToken] = ActionBarSaverDB.sets[classToken] or {}
	end
	
	self.db = ActionBarSaverDB
	
	playerClass = select(2, UnitClass("player"))
end

-- Check if were still using the Ace3 DB format
function ABS:FormatUpgrade()
	if( not ActionBarSaverDB or not ActionBarSaverDB.profiles or not ActionBarSaverDB.profiles.Global ) then
		return
	end
	
	local backup = CopyTable(ActionBarSaverDB.profiles.Global)
	ActionBarSaverDB = CopyTable(backup)
	
	self:Print(L["Your DB has been upgraded to the new storage format."])
end

-- Text "compression" so it can be stored in our format fine
function ABS:CompressText(text)
	text = string.gsub(text, "\n", "/n")
	text = string.gsub(text, "/n$", "")
	text = string.gsub(text, "||", "/124")
	
	return string.trim(text)
end

function ABS:UncompressText(text)
	text = string.gsub(text, "/n", "\n")
	text = string.gsub(text, "/124", "|")
	
	return string.trim(text)
end

-- Restore a saved profile
function ABS:SaveProfile(name)
	self.db.sets[playerClass][name] = self.db.sets[playerClass][name] or {}
	local set = self.db.sets[playerClass][name]
	
	for actionID=1, 120 do
		set[actionID] = nil
		
		local type, id, subType, extraID = GetActionInfo(actionID)
		if( type and id ) then
			-- DB Format: <type>|<id>|<binding>|<name>|<extra ...>
			-- Save a companion
			if( type == "companion" ) then
				set[actionID] = string.format("%s|%s|%s|%s|%s|%s", type, id, "", name, subType, extraID)
			-- Save an item
			elseif( type == "item" ) then
				set[actionID] = string.format("%s|%d|%s|%s", type, id, "", (GetItemInfo(id)) or "")
			-- Save a spell
			elseif( type == "spell" and id > 0 ) then
				local spell, rank = GetSpellName(id, BOOKTYPE_SPELL)
				if( spell ) then
					set[actionID] = string.format("%s|%d|%s|%s|%s|%s", type, id, "", spell, rank or "", extraID or "")
				end
			-- Save a macro
			elseif( type == "macro" ) then
				local name, icon, macro = GetMacroInfo(id)
				if( name and icon and macro ) then
					set[actionID] = string.format("%s|%d|%s|%s|%s|%s", type, actionID, "", self:CompressText(name), icon, self:CompressText(macro))
				end
			end
		end
	end
	
	self:Print(string.format(L["Saved profile %s!"], name))
end

-- Finds the macroID in case it's changed
function ABS:FindMacro(id, data)
	if( macroCache[id] == data ) then
		return id
	end
	
	-- No such luck, check text
	for id, currentMacro in pairs(macroCache) do
		if( currentMacro == data ) then
			return id
		end
	end
	
	return nil
end

-- Restore any macros that don't exist
function ABS:RestoreMacros(set)
	local perCharacter = true
	for id, data in pairs(set) do
		local type, id, binding, macroName, macroIcon, macroData = string.split("|", data)
		if( type == "macro" ) then
			-- Do we already have a macro?
			local macroID = self:FindMacro(id, macroData)
			if( not macroID ) then
				local globalNum, charNum = GetNumMacros()
				-- Make sure we aren't at the limit
				if( globalNum == MAX_GLOBAL_MACROS and charNum == MAX_CHAR_MACROS ) then
					table.insert(restoreErrors, L["Unable to restore macros, you already have 18 global and 18 per character ones created."])
					break

				-- We ran out of space for per character, so use global
				elseif( charNum == MAX_CHAR_MACROS ) then
					perCharacter = false
				end

				-- When creating a macro, we have to pass the icon id not the icon path
				if( not iconCache ) then
					iconCache = {}
					for i=1, GetNumMacroIcons() do
						iconCache[(GetMacroIconInfo(i))] = i
					end
				end
				
				macroName = self:UncompressText(macroName)
				
				-- If we don't have a macro name, it won't be created/saved
				CreateMacro(macroName == "" and " " or macroName, iconCache[macroIcon] or 1, self:UncompressText(macroData), nil, perCharacter)
			end
		end
	end
	
	-- Recache macros due to any additions
	for i=1, MAX_MACROS do
		local macro = select(3, GetMacroInfo(i))
		macroCache[i] = macro and self:CompressText(macro) or nil
	end
end

-- Restore a saved profile
function ABS:RestoreProfile(name, overrideClass)
	local set = self.db.sets[overrideClass or playerClass][name]
	if( not set ) then
		self:Print(string.format(L["No profile with the name \"%s\" exists."], set))
		return
	elseif( InCombatLockdown() ) then
		self:Print(String.format(L["Unable to restore profile \"%s\", you are in combat."], set))
		return
	end
	
	-- Cache spells
	for k in pairs(spellCache) do spellCache[k] = nil end
	
	for book=1, MAX_SKILLLINE_TABS do
		local _, _, offset, numSpells = GetSpellTabInfo(book)

		for i=1, numSpells do
			local index = offset + i
			local spell, rank = GetSpellName(index, BOOKTYPE_SPELL)
			
			-- This way we restore the max rank of spells
			spellCache[spell] = index
			spellCache[string.lower(spell)] = index
			
			if( rank and rank ~= "" ) then
				spellCache[spell .. rank] = index
			end
		end
	end
		
	
	-- Cache macros
	for i=1, MAX_MACROS do
		local macro = select(3, GetMacroInfo(i))
		macroCache[i] = macro and self:CompressText(macro) or nil
	end
	
	-- Check if we need to restore any missing macros
	if( self.db.macro ) then
		self:RestoreMacros(set)
	end
	
	-- Start fresh with nothing on the cursor
	ClearCursor()
	
	for i=1, 120 do
		local type, id = GetActionInfo(i)
		
		-- Clear the current spot
		if( id or type ) then
			PickupAction(i)
			ClearCursor()
		end
		
		-- Restore this spot
		if( set[i] ) then
			self:RestoreAction(i, string.split("|", set[i]))
		end
	end
	
	
	-- Done!
	if( #(restoreErrors) == 0 ) then
		self:Print(string.format(L["Restored profile %s!"], name))
	else
		self:Print(string.format(L["Restored profile %s, failed to restore %d buttons type /abs errors for more information."], name, #(restoreErrors)))
	end
end

function ABS:RestoreAction(i, type, actionID, binding, ...)
	-- Restore a spell
	if( type == "spell" ) then
		local spellName, spellRank = ...
		if( ( self.db.restoreRank or spellRank == "" ) and spellCache[spellName] ) then
			PickupSpell(spellCache[spellName], BOOKTYPE_SPELL)
		elseif( spellRank ~= "" and spellCache[spellName .. spellRank] ) then
			PickupSpell(spellCache[spellName .. spellRank], BOOKTYPE_SPELL)
		end
		
		if( GetCursorInfo() ~= type ) then
			-- Bad restore, check if we should link at all
			local lowerSpell = string.lower(spellName)
			for spell, linked in pairs(self.db.spellSubs) do
				if( lowerSpell == spell and spellCache[linked] ) then
					self:RestoreAction(i, type, actionID, binding, linked, nil, arg3)
					return
				elseif( lowerSpell == linked and spellCache[spell] ) then
					self:RestoreAction(i, type, actionID, binding, spell, nil, arg3)
					return
				end
			end
			
			table.insert(restoreErrors, string.format(L["Unable to restore spell \"%s\" to slot #%d, it does not appear to have been learned yet."], spellName, i))
			ClearCursor()
			return
		end

		PlaceAction(i)
	-- Restore a 3.1 saved companion
	elseif( type == "companion" ) then
		local critterName, critterType, critterID = ...
		PickupCompanion(critterType, actionID)
		if( GetCursorInfo() ~= "companion" ) then
			table.insert(restoreErrors, string.format(L["Unable to restore companion \"%s\" to slot #%d, it does not appear to exist yet."], critterName, i))
			ClearCursor()
			return
		end
		
		PlaceAction(i)
	-- Restore an item
	elseif( type == "item" ) then
		PickupItem(actionID)

		if( GetCursorInfo() ~= type ) then
			local itemName = select(i, ...)
			table.insert(restoreErrors, string.format(L["Unable to restore item \"%s\" to slot #%d, cannot be found in inventory."], itemName and itemName ~= "" and itemName or actionID, i))
			ClearCursor()
			return
		end
		
		PlaceAction(i)
	-- Restore a macro
	elseif( type == "macro" ) then
		PickupMacro(self:FindMacro(actionID, (select(3, ...))) or -1)
		if( GetCursorInfo() ~= type ) then
			table.insert(restoreErrors, string.format(L["Unable to restore macro id #%d to slot #%d, it appears to have been deleted."], actionID, i))
			ClearCursor()
			return
		end
		
		PlaceAction(i)
	end
end

function ABS:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99ABS|r: " .. msg)
end

SLASH_ABS1 = "/abs"
SLASH_ABS2 = "/actionbarsaver"
SlashCmdList["ABS"] = function(msg)
	msg = msg or ""
	
	local cmd, arg = string.split(" ", msg, 2)
	cmd = string.lower(cmd or "")
	arg = string.lower(arg or "")
	
	local self = ABS
	
	-- Profile saving
	if( cmd == "save" and arg ~= "" ) then
		self:SaveProfile(arg)
	
	-- Spell sub
	elseif( cmd == "link" and arg ~= "" ) then
		local first, second = string.match(arg, "\"(.+)\" \"(.+)\"")
		first = string.trim(first or "")
		second = string.trim(second or "")
		
		if( first == "" or second == "" ) then
			self:Print(L["Invalid spells passed, remember you must put quotes around both of them."])
			return
		end
		
		self.db.spellSubs[first] = second
		
		self:Print(string.format(L["Spells \"%s\" and \"%s\" are now linked."], first, second))
		
	-- Profile restoring
	elseif( cmd == "restore" and arg ~= "" ) then
		for i=#(restoreErrors), 1, -1 do table.remove(restoreErrors, i) end
				
		if( not self.db.sets[playerClass][arg] ) then
			self:Print(string.format(L["Cannot restore profile \"%s\", you can only restore profiles saved to your class."], arg))
			return
		end
		
		self:RestoreProfile(arg, playerClass)
		
	-- Profile renaming
	elseif( cmd == "rename" and arg ~= "" ) then
		local old, new = string.split(" ", arg, 2)
		new = string.trim(new or "")
		old = string.trim(old or "")
		
		if( new == old ) then
			self:Print(string.format(L["You cannot rename \"%s\" to \"%s\" they are the same profile names."], old, new))
			return
		elseif( new == "" ) then
			self:Print(string.format(L["No name specified to rename \"%s\" to."], old))
			return
		elseif( self.db.sets[playerClass][new] ) then
			self:Print(string.format(L["Cannot rename \"%s\" to \"%s\" a profile already exists for %s."], old, new, (UnitClass("player"))))
			return
		elseif( not self.db.sets[playerClass][old] ) then
			self:Print(string.format(L["No profile with the name \"%s\" exists."], old))
			return
		end
		
		-- Backwards compat
		local profileCat = playerClass
		self.db.sets[playerClass][new] = CopyTable(self.db.sets[profileCat][old])
		self.db.sets[profileCat][old] = nil
		
		self:Print(string.format(L["Renamed \"%s\" to \"%s\""], old, new))
		
	-- Restore errors
	elseif( cmd == "errors" ) then
		if( #(restoreErrors) == 0 ) then
			self:Print(L["No errors found!"])
			return
		end

		self:Print(string.format(L["Errors found: %d"], #(restoreErrors)))
		for _, text in pairs(restoreErrors) do
			DEFAULT_CHAT_FRAME:AddMessage(text)
		end

	-- Delete profile
	elseif( cmd == "delete" ) then
		self.db.sets[playerClass][arg] = nil
		self:Print(string.format(L["Deleted saved profile %s."], arg))
	
	-- List profiles
	elseif( cmd == "list" ) then
		local classes = {}
		local setList = {}
		
		for class, sets in pairs(self.db.sets) do
			table.insert(classes, class)
		end
		
		table.sort(classes, function(a, b)
			return a < b
		end)
		
		for _, class in pairs(classes) do
			for i=#(setList), 1, -1 do table.remove(setList, i) end
			for setName in pairs(self.db.sets[class]) do
				table.insert(setList, setName)
			end
			
			if( #(setList) > 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage(string.format("|cff33ff99%s|r: %s", L[class] or "???", table.concat(setList, ", ")))
			end
		end
		
	-- Macro restoring
	elseif( cmd == "macro" ) then
		self.db.macro = not self.db.macro

		if( self.db.macro ) then
			self:Print(L["Auto macro restoration is now enabled!"])
		else
			self:Print(L["Auto macro restoration is now disabled!"])
		end
	
	-- Item counts
	elseif( cmd == "count" ) then
		self.db.checkCount = not self.db.checkCount

		if( self.db.checkCount ) then
			self:Print(L["Checking item count is now enabled!"])
		else
			self:Print(L["Checking item count is now disabled!"])		
		end
	
	-- Rank restore
	elseif( cmd == "rank" ) then
		self.db.restoreRank = not self.db.restoreRank
		
		if( self.db.restoreRank ) then
			self:Print(L["Auto restoring highest spell rank is now enabled!"])
		else
			self:Print(L["Auto restoring highest spell rank is now disabled!"])
		end
		
	-- Halp
	else
		self:Print(L["Slash commands"])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs save <profile> - Saves your current action bar setup under the given profile."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs restore <profile> - Changes your action bars to the passed profile."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs delete <profile> - Deletes the saved profile."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs rename <oldProfile> <newProfile> - Renames a saved profile from oldProfile to newProfile."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs link \"<spell 1>\" \"<spell 2>\" - Links a spell with another, INCLUDE QUOTES for example you can use \"Shadowmeld\" \"War Stomp\" so if War Stomp can't be found, it'll use Shadowmeld and vica versa."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs count - Toggles checking if you have the item in your inventory before restoring it, use if you have disconnect issues when restoring."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs macro - Attempts to restore macros that have been deleted for a profile."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs rank - Toggles if ABS should restore the highest rank of the spell, or the one saved originally."])
		DEFAULT_CHAT_FRAME:AddMessage(L["/abs list - Lists all saved profiles."])
	end
end

-- Check if we need to load
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if( addon == "ActionBarSaver" ) then
		ABS:OnInitialize()
		self:UnregisterEvent("ADDON_LOADED")
	end
end)