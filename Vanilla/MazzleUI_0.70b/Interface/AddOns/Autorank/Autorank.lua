------------------------------------------------------------------------------
-- Autorank
-- 
-- This Addon automatically selects the appropriate rank of a recognized spell
-- when you are casting on a lower level friendly target.  You must already
-- have the friendly target selected for this feature to work, and only
-- applies for spells that are recognized by the code.
--
-- In addition, Autorank now supports selecting a special key to automatically
-- cause actions (if targettable and not a macro) to be cast on the player
-- themselves.  (This is because otherwise the order in which addons hook the
-- UseAction function can prevent other self-casting addons from functioning
-- when Autorank is used).
--
-- Written by Cirk of DoomHammer, November 2005 and April 2006
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- AddOn name and version
------------------------------------------------------------------------------
AUTORANK_NAME = "Cirk's Autorank"
AUTORANK_VERSION = "1.12.0"


------------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------------
AutorankState = {};						-- Will be overridden when loaded


------------------------------------------------------------------------------
-- Localization (English default)
------------------------------------------------------------------------------
-- Spellname data for localization (these must match the spellbook names)
AUTORANK_SPELLNAMES = {
	-- Druid spells
	MARK_OF_THE_WILD = "Mark of the Wild",
	REJUVENATION = "Rejuvenation",
	REGROWTH = "Regrowth",
	THORNS = "Thorns",

	-- Mage spells
	AMPLIFY_MAGIC = "Amplify Magic",
	ARCANE_INTELLECT = "Arcane Intellect",
	DAMPEN_MAGIC = "Dampen Magic",
	CONJURE_FOOD = "Conjure Food",
	CONJURE_WATER = "Conjure Water",

	-- Paladin spells
	BLESSING_OF_KINGS = "Blessing of Kings",
	BLESSING_OF_LIGHT = "Blessing of Light",
	BLESSING_OF_MIGHT = "Blessing of Might",
	BLESSING_OF_SALVATION = "Blessing of Salvation",
	BLESSING_OF_SANCTUARY = "Blessing of Sanctuary",
	BLESSING_OF_WISDOM = "Blessing of Wisdom",

	-- Priest spells
	DIVINE_SPIRIT = "Divine Spirit",
	POWER_WORD_FORTITUDE = "Power Word: Fortitude",
	POWER_WORD_SHIELD = "Power Word: Shield",
	RENEW = "Renew",
	SHADOW_PROTECTION = "Shadow Protection",
	
	-- Warlock spells
	DETECT_LESSER_INVISIBILITY = "Detect Lesser Invisibility",
	DETECT_INVISIBILITY = "Detect Invisibility",
	DETECT_GREATER_INVISIBILITY = "Detect Greater Invisibility",
	CREATE_HEALTHSTONE_MINOR = "Create Healthstone (Minor)",
	CREATE_HEALTHSTONE_LESSER = "Create Healthstone (Lesser)",
	CREATE_HEALTHSTONE = "Create Healthstone",
	CREATE_HEALTHSTONE_GREATER = "Create Healthstone (Greater)",
	CREATE_HEALTHSTONE_MAJOR = "Create Healthstone (Major)",
};

-- Text color emphasis enable and disable (format is |cff<rr><gg><bb<)
AUTORANK_EM_ON = "|cffffff00"
AUTORANK_EM_OFF = "|r"

-- Miscellaneous text commands
AUTORANK_TEXT = {
	DEBUG = AUTORANK_EM_ON.."Autorank: "..AUTORANK_EM_OFF;
};

-- Slash commands and responses
AUTORANK_COMMANDS = {
	-- Slash commands
	HELP = "help",
	ON = "on",
	ENABLE = "enable",
	OFF = "off",
	DISABLE = "disable",
	LIST = "list",
	STATUS = "status",
	DEBUGON = "debugon",
	DEBUGOFF = "debugoff",
	SELF = "self",
	CONJURE = "conjure",

	-- Self-casting keys
	KEY_ALT = "alt",
	KEY_CTRL = "ctrl",
	KEY_SHIFT = "shift",
	KEY_NONE = "none",

	-- Slash command responses
	ENABLE_CONFIRM = AUTORANK_EM_ON.."Autorank spell-selection is enabled"..AUTORANK_EM_OFF,
	DISABLE_CONFIRM = AUTORANK_EM_ON.."Autorank spell-selection is disabled"..AUTORANK_EM_OFF,
	ENABLE_FAILED = AUTORANK_EM_ON.."Autorank spell-selection cannot be enabled for your class"..AUTORANK_EM_OFF,
	ENABLED_STATUS = AUTORANK_EM_ON.."Autorank spell-selection is currently enabled"..AUTORANK_EM_OFF,
	DISABLED_STATUS = AUTORANK_EM_ON.."Autorank spell-selection is currently disabled"..AUTORANK_EM_OFF,
	UNABLE_STATUS = AUTORANK_EM_ON.."Autorank spell-selection is not enabled for your class"..AUTORANK_EM_OFF,
	ENABLED_CONJURE_STATUS = AUTORANK_EM_ON.."Autorank spell-selection is currently enabled for normal and conjuration spells"..AUTORANK_EM_OFF,
	DISABLED_CONJURE_STATUS = AUTORANK_EM_ON.."Autorank spell-selection is currently enabled for normal spells only"..AUTORANK_EM_OFF,
	SELF_ENABLED_STATUS = AUTORANK_EM_ON.."Autorank using the "..AUTORANK_EM_OFF.."%s"..AUTORANK_EM_ON.." key for self-casting"..AUTORANK_EM_OFF,
	SELF_DISABLED_STATUS = AUTORANK_EM_ON.."Autorank's self-casting is disabled"..AUTORANK_EM_OFF,
	UNABLE_CONJURE = AUTORANK_EM_ON.."Your class has no conjuration spells"..AUTORANK_EM_OFF,
	ENABLED_CONJURE = AUTORANK_EM_ON.."Autorank spell-selection enabled for conjuration spells"..AUTORANK_EM_OFF,
	DISABLED_CONJURE = AUTORANK_EM_ON.."Autorank spell-selection disabled for conjuration spells"..AUTORANK_EM_OFF,
	DEBUGON_CONFIRM = "Autorank debug is enabled",
	DEBUGOFF_CONFIRM = "Autorank debug is disabled",
	LIST_CONFIRM = AUTORANK_EM_ON.."Autorank knows the following spells",
	LIST_FORMAT = "- %s",
};

-- Help text
AUTORANK_HELP = {
	AUTORANK_EM_ON..AUTORANK_NAME.." v"..AUTORANK_VERSION..AUTORANK_EM_OFF,
	AUTORANK_EM_ON.."Assists with casting buffs on lower level players and provides self-casting key support:"..AUTORANK_EM_OFF,
	"   /autorank "..AUTORANK_COMMANDS.HELP..AUTORANK_EM_ON.." shows this help message"..AUTORANK_EM_OFF,
	"   /autorank "..AUTORANK_COMMANDS.ON..AUTORANK_EM_ON.."||"..AUTORANK_EM_OFF..AUTORANK_COMMANDS.OFF..AUTORANK_EM_ON.." enables or disables automatic spell-rank selection"..AUTORANK_EM_OFF,
	"   /autorank "..AUTORANK_COMMANDS.CONJURE.." "..AUTORANK_COMMANDS.ON..AUTORANK_EM_ON.."||"..AUTORANK_EM_OFF..AUTORANK_COMMANDS.OFF..AUTORANK_EM_ON.." controls spell-selection for conjuration spells"..AUTORANK_EM_OFF,
	"   /autorank "..AUTORANK_COMMANDS.SELF.." "..AUTORANK_COMMANDS.KEY_ALT..AUTORANK_EM_ON.."||"..AUTORANK_EM_OFF..AUTORANK_COMMANDS.KEY_CTRL..AUTORANK_EM_ON.."||"..AUTORANK_EM_OFF..AUTORANK_COMMANDS.KEY_SHIFT..AUTORANK_EM_ON.."||"..AUTORANK_EM_OFF..AUTORANK_COMMANDS.KEY_NONE..AUTORANK_EM_ON.." selects Autorank's self-casting key"..AUTORANK_EM_OFF,
	"   /autorank "..AUTORANK_COMMANDS.LIST..AUTORANK_EM_ON.." lists the spells known by Autorank"..AUTORANK_EM_OFF,
	"   /autorank "..AUTORANK_COMMANDS.STATUS..AUTORANK_EM_ON.." shows the status of Autorank"..AUTORANK_EM_OFF,
};


------------------------------------------------------------------------------
-- Local defines
------------------------------------------------------------------------------
local AUTORANK_ACTION_SLOT_FIRST = 1;	-- First action slot index
local AUTORANK_ACTION_SLOT_LAST = 120;	-- Last action slot index


------------------------------------------------------------------------------
-- Local constants
------------------------------------------------------------------------------


------------------------------------------------------------------------------
-- Local variables
------------------------------------------------------------------------------
local _thisFrame = nil;					-- The frame pointer
local _serverName = nil;				-- set to current realm when loaded
local _playerName = nil;				-- set to current playername when known
local _classEnabled = nil;				-- set to 1 if the player is of a valid class
local _enabled = nil;					-- whether the AddOn's spell-selection feature is enabled or not
local _selfKey = nil;					-- key to use for self-casting
local _checkConjure = nil;				-- whether to check conjured item spells
local _hasConjure = nil;				-- whether class has conjuration spells
local _originalUseAction = nil;			-- original UseAction function

local _debugFrame = nil;				-- debug output chat frame


------------------------------------------------------------------------------
-- Spellbook data
--
-- _spellbookTranslate allows mapping spellnames that don't follow the usual
-- rank based scheme (i.e., warlock spells) to the rank system for casting.
-- _spellbookData lists those spells that have multiple ranks and the levels
-- at which those ranks apply (normally 10 less than the level at which the
-- spell is learned).
------------------------------------------------------------------------------
local _spellbookTranslate = {
	[AUTORANK_SPELLNAMES.DETECT_LESSER_INVISIBILITY] = {["spellname"] = AUTORANK_SPELLNAMES.DETECT_INVISIBILITY, ["rank"] = 1},
	[AUTORANK_SPELLNAMES.DETECT_INVISIBILITY] = {["spellname"] = AUTORANK_SPELLNAMES.DETECT_INVISIBILITY, ["rank"] = 2},
	[AUTORANK_SPELLNAMES.DETECT_GREATER_INVISIBILITY] = {["spellname"] = AUTORANK_SPELLNAMES.DETECT_INVISIBILITY, ["rank"] = 3},
	[AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE_MINOR] =  {["spellname"] = AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE, ["rank"] = 1},
	[AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE_LESSER] =  {["spellname"] = AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE, ["rank"] = 2},
	[AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE] =  {["spellname"] = AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE, ["rank"] = 3},
	[AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE_GREATER] =  {["spellname"] = AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE, ["rank"] = 4},
	[AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE_MAJOR] =  {["spellname"] = AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE, ["rank"] = 5},
};

local _spellbookData = {
	-- Druid spells
	{["spellname"] = AUTORANK_SPELLNAMES.MARK_OF_THE_WILD, ["levels"] = {1, 10, 20, 30, 40, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.REJUVENATION, ["levels"] = {1, 1, 6, 12, 18, 24, 30, 36, 42, 48, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.REGROWTH, ["levels"] = {2, 8, 14, 20, 26, 32, 38, 44, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.THORNS, ["levels"] = {1, 4, 14, 24, 34, 44, 50}},

	-- Mage spells
	{["spellname"] = AUTORANK_SPELLNAMES.AMPLIFY_MAGIC, ["levels"] = {8, 20, 32, 44, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.ARCANE_INTELLECT, ["levels"] = {1, 4, 28, 32, 46, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.DAMPEN_MAGIC, ["levels"] = {2, 14, 26, 38, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.CONJURE_FOOD, ["levels"] = {1, 5, 15, 25, 35, 45, 55}, ["conjure"] = 1},
	{["spellname"] = AUTORANK_SPELLNAMES.CONJURE_WATER, ["levels"] = {1, 5, 15, 25, 35, 45, 55}, ["conjure"] = 1},

	-- Paladin blessings
	{["spellname"] = AUTORANK_SPELLNAMES.BLESSING_OF_LIGHT, ["levels"] = {30, 40, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.BLESSING_OF_MIGHT, ["levels"] = {1, 2, 12, 22, 32, 42, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.BLESSING_OF_SANCTUARY, ["levels"] = {10, 20, 30, 40, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.BLESSING_OF_WISDOM, ["levels"] = {4, 14, 24, 34, 44, 50}},

	-- Priest spells
	{["spellname"] = AUTORANK_SPELLNAMES.DIVINE_SPIRIT, ["levels"] = {20, 32, 44, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.POWER_WORD_FORTITUDE, ["levels"] = {1, 2, 14, 26, 38, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.POWER_WORD_SHIELD, ["levels"] = {1, 2, 8, 14, 20, 26, 32, 38, 44, 50, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.RENEW, ["levels"] = {1, 4, 10, 16, 22, 28, 34, 40, 46, 50}},
	{["spellname"] = AUTORANK_SPELLNAMES.SHADOW_PROTECTION, ["levels"] = {20, 32, 46, 50}},

	-- Warlock spells
	{["spellname"] = AUTORANK_SPELLNAMES.DETECT_INVISIBILITY, ["levels"] = {16, 28, 40}},
	{["spellname"] = AUTORANK_SPELLNAMES.CREATE_HEALTHSTONE, ["levels"] = {1, 12, 24, 36, 48}, ["conjure"] = 1},
};


------------------------------------------------------------------------------
-- Other data tables
------------------------------------------------------------------------------
local _classData = {
	["DRUID"] = 1,					-- 1 means class has autorank spells
	["MAGE"] = 2,					-- 2 means class has autorank and conjuration spells
	["PALADIN"] = 1,
	["PRIEST"] = 1,
	["WARLOCK"] = 2,
};
local _spellbookLookupName = {};	-- Will be populated with spellnames and indices into _spellbookData
local _actionBarData = {};			-- Will contain spellIndex and rank information for each slot


------------------------------------------------------------------------------
-- Local registration functions
------------------------------------------------------------------------------
local function Autorank_HookFunctions()
	-- Hook the UseAction function if we haven't already
	if (not _originalUseAction) then
		_originalUseAction = UseAction;
		UseAction = Autorank_UseAction;
	end
end


local function Autorank_Register()
	-- Register for events
	_thisFrame:RegisterEvent("SPELLS_CHANGED");
	_thisFrame:RegisterEvent("CHARACTER_POINTS_CHANGED");
	_thisFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
end


local function Autorank_Unregister()
	-- Unregister for events
	_thisFrame:UnregisterEvent("SPELLS_CHANGED");
	_thisFrame:UnregisterEvent("CHARACTER_POINTS_CHANGED");
	_thisFrame:UnregisterEvent("ACTIONBAR_SLOT_CHANGED");
end


------------------------------------------------------------------------------
-- Local spell selection functions
------------------------------------------------------------------------------
local function Autorank_ConvertToSpellID(spellIndex, unitLevel, maxRank, isPlayer)
	-- Given a spellIndex, level of the target, and a maximum rank, this
	-- function determines the appropriate spellID for passing to CastSpell.
	-- Note that this function requires that the levels data is ordered in
	-- increasing level values.
	local sdata = _spellbookData[spellIndex];
	local spellID = nil;
	if (sdata and sdata.levels and sdata.ranks and unitLevel and (unitLevel >= 1)) then
		if (not sdata.conjure or ((_checkConjure == 1) and isPlayer)) then
			for rank, minLevel in sdata.levels do
				if (unitLevel >= minLevel) then
					local rankID = sdata.ranks[rank];
					if (rankID > 0) then
						spellID = rankID;
					end
				end
				if (maxRank and (rank >= maxRank)) then
					break;
				end
			end
		end
	end
	return spellID;
end


------------------------------------------------------------------------------
-- Spellbook and action bar parsing functions
------------------------------------------------------------------------------
local function Autorank_CheckSpellbook()
	-- Parses the player's spellbook, looking for spells known by Autorank and
	-- records the spellID for these.
	if (_debugFrame) then
		_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."Autorank_CheckSpellbook()");
	end
	for sindex, sdata in _spellbookData do
		if (sdata.levels) then
			sdata.ranks = {};
			for rank, spellLevel in sdata.levels do
				sdata.ranks[rank] = 0;
			end
		end
	end
	for tab = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(tab);
		for index = 1, numSpells do
			local spellName, spellRank = GetSpellName(offset + index, BOOKTYPE_SPELL);
			local tdata = _spellbookTranslate[spellName];
			if (tdata) then
				spellName = tdata.spellname;
				spellRank = "Rank "..tdata.rank;
			end
			local spellIndex = _spellbookLookupName[spellName];
			if (spellIndex) then
				if (spellRank and (string.sub(spellRank, 1, 5) == "Rank ")) then
					local rankNum = tonumber(string.sub(spellRank, 6));
					_spellbookData[spellIndex].ranks[rankNum] = offset + index;
					if (_debugFrame) then
						_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."--> found rank "..rankNum.." of "..spellName.." (level ".._spellbookData[spellIndex].levels[rankNum].."+)");
					end
				else
					_spellbookData[spellIndex].ranks[1] = offset + index;
					if (_debugFrame) then
						_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."--> found "..spellName.." (level ".._spellbookData[spellIndex].levels[1].."+)");
					end
				end
			end
		end
	end
end


local function Autorank_ProcessActionSlot(slot)
	-- Uses the hidden tooltip to check for a known spell at the indicated
	-- action bar slot, and if found, updates the _actionBarData table
	_actionBarData[slot] = nil;
	if (HasAction(slot) and not GetActionText(slot)) then
		AutorankTooltip:SetOwner(_thisFrame, "ANCHOR_NONE");
		AutorankTooltip:ClearLines();
		AutorankTooltip:SetAction(slot);
		local actionName = AutorankTooltipTextLeft1:GetText();
		local actionRank = AutorankTooltipTextRight1:GetText();
		AutorankTooltip:Hide();
		local tdata = _spellbookTranslate[actionName];
		if (tdata) then
			actionName = tdata.spellname;
			actionRank = "Rank "..tdata.rank;
		end
		local spellIndex = _spellbookLookupName[actionName];
		if (spellIndex) then
			_actionBarData[slot] = {};
			_actionBarData[slot].index = spellIndex;
			if (actionRank and (string.sub(actionRank, 1, 5) == "Rank ")) then
				_actionBarData[slot].rank = tonumber(string.sub(actionRank, 6));
				if (_debugFrame) then
					_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."--> found rank ".._actionBarData[slot].rank.." of "..actionName.." in action slot "..slot);
				end
			else
				_actionBarData[slot].rank = nil;
				if (_debugFrame) then
					_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."--> found "..actionName.." in action slot "..slot);
				end
			end
		end
	end
end


local function Autorank_ScanActionBar(slot)
	-- Scans the action slot using Autorank_ProcessActionSlot for the
	-- indicated slot, or for all slots if no specific slot is given.
	if (_debugFrame) then
		_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."Autorank_ScanActionBar("..(slot or "")..")");
	end
	if (slot) then
		Autorank_ProcessActionSlot(slot);
	else
		_actionBarData = {};
		for slot = AUTORANK_ACTION_SLOT_FIRST, AUTORANK_ACTION_SLOT_LAST do
			Autorank_ProcessActionSlot(slot);
		end
	end
end


------------------------------------------------------------------------------
-- Hooked UseAction function (public)
------------------------------------------------------------------------------
function Autorank_UseAction(slot, cursor, onSelf)
	if (_debugFrame) then
		if (onSelf) then
			_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."Autorank_UseAction("..slot..", "..cursor..", "..onSelf..")");
		else
			_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."Autorank_UseAction("..slot..", "..cursor..")");
		end
	end
	if (not onSelf) then
		if (_selfKey == AUTORANK_COMMANDS.KEY_ALT) then
			onSelf = IsAltKeyDown();
		elseif (_selfKey == AUTORANK_COMMANDS.KEY_CTRL) then
			onSelf = IsControlKeyDown();
		elseif (_selfKey == AUTORANK_COMMANDS.KEY_SHIFT) then
			onSelf = IsShiftKeyDown();
		end
	end
	if (_enabled == 1) then
		local adata = _actionBarData[slot];
		if (adata and not onSelf and UnitExists("target") and UnitCanAssist("player", "target")) then
			local spellID = Autorank_ConvertToSpellID(adata.index, UnitLevel("target"), adata.rank, UnitIsPlayer("target"));
			if (spellID) then
				if (_debugFrame) then
					local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_SPELL);
					if (spellRank and (spellRank ~= "")) then
						_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."Casting spell "..spellName.." ("..spellRank..") on target "..UnitName("target"));
					else
						_debugFrame:AddMessage(AUTORANK_TEXT.DEBUG.."Casting spell "..spellName.." on target "..UnitName("target"));
					end
				end
				CastSpell(spellID, BOOKTYPE_SPELL);
			else
				_originalUseAction(slot, cursor);
			end
		else
			_originalUseAction(slot, cursor, onSelf);
		end
	else
		_originalUseAction(slot, cursor, onSelf);
	end
	if (onSelf and SpellIsTargeting() and SpellCanTargetUnit("player") and (_selfKey ~= AUTORANK_COMMANDS.KEY_NONE)) then
		SpellTargetUnit("player");
	end
end


------------------------------------------------------------------------------
-- Local utility functions
------------------------------------------------------------------------------
local function Autorank_GetNextParam(text)
	-- Extracts the next parameter out of the passed text, and returns it and
	-- the rest of the string
	for param, remain in string.gfind(text, "(%w+) +(.*)") do
		return param, remain;
	end
	return text;
end


------------------------------------------------------------------------------
-- Initialization functions
------------------------------------------------------------------------------
local function Autorank_VariablesLoaded()
	-- Called for the VARIABLES_LOADED event, this function retrieves the
	-- current settings and sets the realm name
	_serverName = GetRealmName();
	if (not AutorankState) then
		AutorankState = {};
	end
	if (not AutorankState.Servers) then
		AutorankState.Servers = {};
	end
	if (not AutorankState.Servers[_serverName]) then
		AutorankState.Servers[_serverName] = {};
	end
	if (not AutorankState.Servers[_serverName].Characters) then
		AutorankState.Servers[_serverName].Characters = {};
	end
end


local function Autorank_PlayerLoaded()
	-- This function is called for the PLAYER_LOGIN event and checks to see if
	-- the playername is known so the player's per character settings can be
	-- retrieved.
	_playerName = UnitName("player");
	local _, classname = UnitClass("player");
	_classEnabled = _classData[classname];
	if (_classEnabled == 2) then
		_hasConjure = 1;
		_classEnabled = 1;
	end
	if (_classEnabled == 1) then
		if (AutorankState.Servers[_serverName].Characters[_playerName]) then
			_enabled = AutorankState.Servers[_serverName].Characters[_playerName].Enabled;
			_selfKey = AutorankState.Servers[_serverName].Characters[_playerName].SelfKey;
			_checkConjure = AutorankState.Servers[_serverName].Characters[_playerName].CheckConjure;
		end
		if (not _enabled) then
			_enabled = 1;
		end
		if ((not _checkConjure) and (_hasConjure == 1)) then
			_checkConjure = 1;
		end
	else
		if (AutorankState.Servers[_serverName].Characters[_playerName]) then
			_selfKey = AutorankState.Servers[_serverName].Characters[_playerName].SelfKey;
		end
		_enabled = 0;
		_checkConjure = 0;
	end
	if (not _selfKey) then
		_selfKey = AUTORANK_COMMANDS.KEY_NONE;
	end

	-- If enabled perform initializations (will register for events when
	-- player actually enters the world)
	if (_enabled == 1) then
		Autorank_HookFunctions();
		Autorank_CheckSpellbook();
		Autorank_ScanActionBar();
	elseif (_selfKey ~= AUTORANK_COMMANDS.KEY_NONE) then
		Autorank_HookFunctions();
	end
end


local function Autorank_PlayerLogout()
	AutorankState.Servers[_serverName].Characters[_playerName] = {};
	if (_classEnabled == 1) then
		AutorankState.Servers[_serverName].Characters[_playerName].Enabled = _enabled;
		AutorankState.Servers[_serverName].Characters[_playerName].SelfKey = _selfKey;
		AutorankState.Servers[_serverName].Characters[_playerName].CheckConjure = _checkConjure;
	elseif (_selfKey ~= AUTORANK_COMMANDS.KEY_NONE) then
		AutorankState.Servers[_serverName].Characters[_playerName].SelfKey = _selfKey;
	end
end


------------------------------------------------------------------------------
-- OnEvent handler
------------------------------------------------------------------------------
function Autorank_OnEvent(event)
	if (event == "SPELLS_CHANGED") then
		Autorank_CheckSpellbook();

	elseif (event == "ACTIONBAR_SLOT_CHANGED") then
		Autorank_ScanActionBar(arg1);

	elseif (event == "VARIABLES_LOADED") then
		Autorank_VariablesLoaded();

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (_enabled == 1) then
			Autorank_Register();
		end

	elseif (event == "PLAYER_LEAVING_WORLD") then
		Autorank_Unregister();

	elseif (event == "PLAYER_LOGIN") then
		Autorank_PlayerLoaded();

	elseif (event == "PLAYER_LOGOUT") then
		Autorank_PlayerLogout();

	end
end


------------------------------------------------------------------------------
-- OnLoad function
------------------------------------------------------------------------------
function Autorank_OnLoad()
	-- Record our frame pointer for later
	_thisFrame = this;

	-- Register for player events
	_thisFrame:RegisterEvent("VARIABLES_LOADED");
	_thisFrame:RegisterEvent("PLAYER_LOGIN");
	_thisFrame:RegisterEvent("PLAYER_LOGOUT");
	_thisFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	_thisFrame:RegisterEvent("PLAYER_LEAVING_WORLD");

	-- Register slash command handler
	SLASH_AUTORANK1 = "/autorank";
	SlashCmdList["AUTORANK"] = function(text)
		Autorank_SlashCommand(text);
	end

	-- Build the _spellbookLookupName table
	for sindex, sdata in _spellbookData do
		_spellbookLookupName[sdata.spellname] = sindex;
	end

	-- Announce ourselves
	DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_NAME.." v"..AUTORANK_VERSION.." loaded");
end


------------------------------------------------------------------------------
-- Slash command function
------------------------------------------------------------------------------
function Autorank_SlashCommand(text)
	if (text) then
		local command, params = Autorank_GetNextParam(string.lower(text));
		if ((command == AUTORANK_COMMANDS.ON) or (command == AUTORANK_COMMANDS.ENABLE)) then
			if (_classEnabled == 1) then
				_enabled = 1;
				Autorank_HookFunctions();
				Autorank_CheckSpellbook();
				Autorank_ScanActionBar();
				Autorank_Register();
				DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.ENABLE_CONFIRM);
			else
				DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.ENABLE_FAILED);
			end
		elseif ((command == AUTORANK_COMMANDS.OFF) or (command == AUTORANK_COMMANDS.DISABLE)) then
			if (_classEnabled == 1) then
				_enabled = 0;
				Autorank_Unregister();
				DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DISABLE_CONFIRM);
			else
				DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.UNABLE_STATUS);
			end
		elseif (command == AUTORANK_COMMANDS.LIST) then
			DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.LIST_CONFIRM);
			for sindex, sdata in _spellbookData do
				DEFAULT_CHAT_FRAME:AddMessage(format(AUTORANK_COMMANDS.LIST_FORMAT, sdata.spellname));
			end
		elseif (command == AUTORANK_COMMANDS.SELF) then
			if ((params == AUTORANK_COMMANDS.KEY_ALT) or (params == AUTORANK_COMMANDS.KEY_CTRL) or
				(params == AUTORANK_COMMANDS.KEY_SHIFT) or (params == AUTORANK_COMMANDS.KEY_NONE)) then
				_selfKey = params;
				if ((_selfKey ~= AUTORANK_COMMANDS.KEY_NONE) and (_enabled ~= 1)) then
					Autorank_HookFunctions();
				end
			end
			if (_selfKey ~= AUTORANK_COMMANDS.KEY_NONE) then
				DEFAULT_CHAT_FRAME:AddMessage(string.format(AUTORANK_COMMANDS.SELF_ENABLED_STATUS, _selfKey));
			else
				DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.SELF_DISABLED_STATUS);
			end
		elseif (command == AUTORANK_COMMANDS.CONJURE) then
			if (_hasConjure == 1) then
				if (params == AUTORANK_COMMANDS.ON) then
					_checkConjure = 1;
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.ENABLED_CONJURE);
				elseif (params == AUTORANK_COMMANDS.OFF) then
					_checkConjure = 0;
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DISABLED_CONJURE);
				elseif (_checkConjure == 1) then
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.ENABLED_CONJURE_STATUS);
				else
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DISABLED_CONJURE_STATUS);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.UNABLE_CONJURE);
			end
		elseif (command == AUTORANK_COMMANDS.STATUS) then
			if (_enabled == 1) then
				if (_hasConjure) then
					if (_checkConjure == 1) then
						DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.ENABLED_CONJURE_STATUS);
					else
						DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DISABLED_CONJURE_STATUS);
					end
				else
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.ENABLED_STATUS);
				end
			else
				if (_classEnabled == 1) then
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DISABLED_STATUS);
				else
					DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.UNABLE_STATUS);
				end
			end
			Autorank_SlashCommand(AUTORANK_COMMANDS.SELF);
		elseif (command == AUTORANK_COMMANDS.DEBUGON) then
			_debugFrame = DEFAULT_CHAT_FRAME;
			DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DEBUGON_CONFIRM);
		elseif (command == AUTORANK_COMMANDS.DEBUGOFF) then
			_debugFrame = nil;
			DEFAULT_CHAT_FRAME:AddMessage(AUTORANK_COMMANDS.DEBUGOFF_CONFIRM);
		else
			for _, string in AUTORANK_HELP do
				DEFAULT_CHAT_FRAME:AddMessage(string);
			end
			Autorank_SlashCommand(AUTORANK_COMMANDS.STATUS);
		end
	end
end


function AutoRank_GetAltKey()
    return _selfKey
end
