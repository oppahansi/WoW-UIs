------------------------------------------------------------------------------
-- Merchantbags
-- 
-- Allows for all your bags to automatically open when you start trading with
-- a merchant or open your mailbox, rather than just the default backpack.
-- Merchantbags can be enabled or disabled on a per character basis, and will
-- remember the last setting applied.
-- 
-- For control, the AddOn registers a /merchantbags slash command
-- with the following options:
--     /merchantbags help (default command, describes available options)
--     /merchantbags status (indicates if Merchantbags is active)
--     /merchantbags on (enables Merchantbags, default)
--     /merchantbags off (disables Merchantbags)
--     /merchantbags debugon (turns on Merchantbags debug)
--     /merchantbags debugoff (turns off Merchantbags debug)
-- 
-- Written by Cirk of DoomHammer, April 2005
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- AddOn version
------------------------------------------------------------------------------
MERCHANTBAGS_NAME = "Cirk's Merchantbags"
MERCHANTBAGS_VERSION = "1.12.0"


------------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------------
MerchantbagsState = {};			-- Will be overridden when loaded


------------------------------------------------------------------------------
-- Local variables
------------------------------------------------------------------------------
local MERCHANTBAGS_FIRSTBAG = 0;	-- first bag index (backpack)
local MERCHANTBAGS_LASTBAG = 4;		-- only 5 bags total
local _thisFrame = nil;				-- The frame pointer
local _enabled = 1;					-- Enabled by default
local _verbose = nil;				-- turn on debug about casting
local _serverName = nil;			-- set to current realm when loaded
local _playerName = nil;			-- set to current playername when known
local _bagStatus = {};				-- status of bags


------------------------------------------------------------------------------
-- Slash command strings and help text
------------------------------------------------------------------------------
local EM_ON = "|cffffff00"
local EM_OFF = "|r"

local MERCHANTBAGS_COMMAND_HELP = "help";
local MERCHANTBAGS_COMMAND_ON = "on";
local MERCHANTBAGS_COMMAND_ENABLE = "enable";
local MERCHANTBAGS_COMMAND_OFF = "off";
local MERCHANTBAGS_COMMAND_DISABLE = "disable";
local MERCHANTBAGS_COMMAND_STATUS = "status";
local MERCHANTBAGS_ENABLE_CONFIRM = EM_ON.."Merchantbags is enabled"..EM_OFF;
local MERCHANTBAGS_DISABLE_CONFIRM = EM_ON.."Merchantbags is disabled"..EM_OFF;
local MERCHANTBAGS_ENABLED_STATUS = EM_ON.."Merchantbags is currently enabled"..EM_OFF;
local MERCHANTBAGS_DISABLED_STATUS = EM_ON.."Merchantbags is currently disabled"..EM_OFF;

local MERCHANTBAGS_COMMAND_DEBUGON = "debugon";
local MERCHANTBAGS_COMMAND_DEBUGOFF = "debugoff";
local MERCHANTBAGS_DEBUGON_CONFIRM = "Merchantbags debug is enabled";
local MERCHANTBAGS_DEBUGOFF_CONFIRM = "Merchantbags debug is disabled";

MERCHANTBAGS_HELP_LINE0 = " ";
MERCHANTBAGS_HELP_LINE1 = EM_ON..MERCHANTBAGS_NAME.." v"..MERCHANTBAGS_VERSION..EM_OFF;
MERCHANTBAGS_HELP_LINE2 = EM_ON.."Allows for all your bags to automatically open when you start trading with a merchant"..EM_OFF;
MERCHANTBAGS_HELP_LINE3 = "   /merchantbags "..MERCHANTBAGS_COMMAND_HELP..EM_ON.." shows this help message"..EM_OFF;
MERCHANTBAGS_HELP_LINE4 = "   /merchantbags "..MERCHANTBAGS_COMMAND_ON..EM_ON.." enables Merchantbags"..EM_OFF;
MERCHANTBAGS_HELP_LINE5 = "   /merchantbags "..MERCHANTBAGS_COMMAND_OFF..EM_ON.." disables Merchantbags"..EM_OFF;
MERCHANTBAGS_HELP_LINE6 = "   /merchantbags "..MERCHANTBAGS_COMMAND_STATUS..EM_ON.." shows the status of Merchantbags"..EM_OFF;


------------------------------------------------------------------------------
-- Local functions
------------------------------------------------------------------------------
local function Merchantbags_Register()
	_thisFrame:RegisterEvent("MERCHANT_SHOW");
	_thisFrame:RegisterEvent("MERCHANT_CLOSED");
	_thisFrame:RegisterEvent("MAIL_SHOW");
	_thisFrame:RegisterEvent("MAIL_CLOSED");
	_thisFrame:RegisterEvent("TRADE_SHOW");
	_thisFrame:RegisterEvent("TRADE_CLOSED");
	_thisFrame:RegisterEvent("BANKFRAME_OPENED");
	_thisFrame:RegisterEvent("BANKFRAME_CLOSED");
end


local function Merchantbags_Unregister()
	_thisFrame:UnregisterEvent("MERCHANT_SHOW");
	_thisFrame:UnregisterEvent("MERCHANT_CLOSED");
	_thisFrame:UnregisterEvent("MAIL_SHOW");
	_thisFrame:UnregisterEvent("MAIL_CLOSED");
	_thisFrame:UnregisterEvent("TRADE_SHOW");
	_thisFrame:UnregisterEvent("TRADE_CLOSED");
	_thisFrame:UnregisterEvent("BANKFRAME_OPENED");
	_thisFrame:UnregisterEvent("BANKFRAME_CLOSED");
end


local function Merchantbags_VariablesLoaded()
	-- Called for the VARIABLES_LOADED event, this function retrieves the
	-- current settings, sets the current realm name, and unregisters the
	-- event (we don't need any more notifications for this)
	if (not _serverName) then
		if (not MerchantbagsState) then
			MerchantbagsState = {};
		end
		if (not MerchantbagsState.Servers) then
			MerchantbagsState.Servers = {};
		end
		_serverName = GetCVar("realmName");
		if (not MerchantbagsState.Servers[_serverName]) then
			MerchantbagsState.Servers[_serverName] = {};
		end
		_thisFrame:UnregisterEvent("VARIABLES_LOADED");
	end
end


local function Merchantbags_PlayerLoaded()
	-- This function is called when the player enters the world and checks to
	-- see if the playername is known so the player's per character settings
	-- can be retrieved.  Once this is done, unregister the startup events
	-- since they aren't needed anymore.
	if (_serverName and not _playerName) then
		local playername = UnitName("player");
		if ((not playername) or (playername == UNKNOWNOBJECT) or (playername == UKNOWNBEING)) then
			-- Player not yet known, just return
			return;
		end
		_playerName = playername;
		_thisFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
		_thisFrame:UnregisterEvent("UNIT_NAME_UPDATE");
		if (not MerchantbagsState.Servers[_serverName].Characters) then
			MerchantbagsState.Servers[_serverName].Characters = {};
		end
		if (not MerchantbagsState.Servers[_serverName].Characters[_playerName]) then
			MerchantbagsState.Servers[_serverName].Characters[_playerName] = {};
		end
		if (not MerchantbagsState.Servers[_serverName].Characters[_playerName].Enabled) then
			MerchantbagsState.Servers[_serverName].Characters[_playerName].Enabled = 1;
		end
		_enabled = MerchantbagsState.Servers[_serverName].Characters[_playerName].Enabled;
		if (_enabled == 1) then
			Merchantbags_Register();
			if (_verbose and DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_ENABLE_CONFIRM);
			end
		end
	end
end


local function Merchantbags_Open()
	-- Open any bags that aren't already open
	if (_enabled == 1) then
		for bag = MERCHANTBAGS_FIRSTBAG, MERCHANTBAGS_LASTBAG, 1 do
			local bagsize = GetContainerNumSlots(bag);
			if (bagsize and (bagsize > 0) and not IsBagOpen(bag)) then
				_bagStatus[bag].state = 1;
				if (_verbose and DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage("Opening "..GetBagName(bag).." at slot "..bag);
				end
				OpenBag(bag);
			else
				_bagStatus[bag].state = nil;
			end
		end
	end
end


local function Merchantbags_Close()
	-- Close any bags that are still open that weren't when we started.  Note
	-- that the MERCHANT_CLOSED event is triggered twice when closing, hence
	-- we reset the bag state as well for each bag on the first event call.
	if (_enabled == 1) then
		for bag = MERCHANTBAGS_FIRSTBAG, MERCHANTBAGS_LASTBAG, 1 do
			if ((_bagStatus[bag].state == 1) and IsBagOpen(bag)) then
				if (_verbose and DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage("Closing "..GetBagName(bag).." at slot "..bag);
				end
				CloseBag(bag);
			end
			_bagStatus[bag].state = nil;
		end
	end
end


------------------------------------------------------------------------------
-- OnLoad function
------------------------------------------------------------------------------
function Merchantbags_OnLoad()
	-- Record our frame pointer for later
	_thisFrame = this;

	-- Register slash command handler
	SLASH_MERCHANTBAGS1 = "/merchantbags";
	SLASH_MERCHANTBAGS2 = "/merchantbag";
	SlashCmdList["MERCHANTBAGS"] = function(text)
		Merchantbags_SlashCommand(text);
	end

	-- Register for variable and player events
	_thisFrame:RegisterEvent("VARIABLES_LOADED");
	_thisFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	_thisFrame:RegisterEvent("UNIT_NAME_UPDATE");

	-- Initialize bag status array
	for bag = MERCHANTBAGS_FIRSTBAG, MERCHANTBAGS_LASTBAG, 1 do
		if (not _bagStatus[bag]) then
			_bagStatus[bag] = {};
		end
	end

	-- Announce ourselves
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_NAME.." v"..MERCHANTBAGS_VERSION.." loaded");
	end
end


------------------------------------------------------------------------------
-- Slash command function
------------------------------------------------------------------------------
function Merchantbags_SlashCommand(text)
	if (text) then
		local command = string.lower(text);
		if ((command == MERCHANTBAGS_COMMAND_ON) or (command == MERCHANTBAGS_COMMAND_ENABLE)) then
			if (_enabled == 0) then
				_enabled = 1;
				MerchantbagsState.Servers[_serverName].Characters[_playerName].Enabled = 1;
				Merchantbags_Register();
			end
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_ENABLE_CONFIRM);
			end
		elseif ((command == MERCHANTBAGS_COMMAND_OFF) or (command == MERCHANTBAGS_COMMAND_DISABLE)) then
			if (_enabled == 1) then
				_enabled = 0;
				MerchantbagsState.Servers[_serverName].Characters[_playerName].Enabled = 0;
				Merchantbags_Unregister();
			end
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_DISABLE_CONFIRM);
			end
		elseif (command == MERCHANTBAGS_COMMAND_STATUS) then
			if (DEFAULT_CHAT_FRAME) then
				if (_enabled == 1) then
					DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_ENABLED_STATUS);
				else
					DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_DISABLED_STATUS);
				end
			end
		elseif (command == MERCHANTBAGS_COMMAND_DEBUGON) then
			_verbose = 1;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_DEBUGON_CONFIRM);
			end
		elseif (command == MERCHANTBAGS_COMMAND_DEBUGOFF) then
			_verbose = nil;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(MERCHANTBAGS_DEBUGOFF_CONFIRM);
			end
		else
			if (DEFAULT_CHAT_FRAME) then
				local line = 0;
				local string = getglobal("MERCHANTBAGS_HELP_LINE"..line);
				while (string) do
					DEFAULT_CHAT_FRAME:AddMessage(string);
					line = line + 1;
					string = getglobal("MERCHANTBAGS_HELP_LINE"..line);
				end
				Merchantbags_SlashCommand(MERCHANTBAGS_COMMAND_STATUS);
				DEFAULT_CHAT_FRAME:AddMessage(" ");
			end
		end
	end
end


------------------------------------------------------------------------------
-- OnEvent function
------------------------------------------------------------------------------
function Merchantbags_OnEvent(event)
	if (event == "TRADE_SHOW") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MERCHANT_SHOW");
		end
		Merchantbags_Open();
		return;
	end
	if (event == "TRADE_CLOSED") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MERCHANT_CLOSED");
		end
		Merchantbags_Close();
		return;
	end
	if (event == "MERCHANT_SHOW") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MERCHANT_SHOW");
		end
		Merchantbags_Open();
		return;
	end
	if (event == "MERCHANT_CLOSED") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MERCHANT_CLOSED");
		end
		Merchantbags_Close();
		return;
	end
	if (event == "MAIL_SHOW") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MAIL_SHOW");
		end
		Merchantbags_Open();
		return;
	end
	if (event == "MAIL_CLOSED") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MAIL_CLOSED");
		end
		Merchantbags_Close();
		-- Close backpack as well because the MailFrame doesn't do this call
		-- although it should (this will only actually close the backpack if
		-- it wasn't previously opened)
		CloseBackpack();
		return;
	end
	if (event == "BANKFRAME_OPENED") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("BANKFRAME_OPENED");
		end
		Merchantbags_Open();
		return;
	end
	if (event == "BANKFRAME_CLOSED") then
		if (_verbose and DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("BANKFRAME_CLOSED");
		end
		Merchantbags_Close();
		return;
	end
	if (event == "VARIABLES_LOADED") then
		Merchantbags_VariablesLoaded();
		return;
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		Merchantbags_PlayerLoaded();
		return;
	end
	if ((event == "UNIT_NAME_UPDATE") and (arg1 == "player")) then
		Merchantbags_PlayerLoaded();
		return;
	end
end

