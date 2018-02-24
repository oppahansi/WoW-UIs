------------------------------------------------------------------------------
-- Chatmanager
-- 
-- Chatmanager is an addon that aims to simplify using chat channels by
-- providing most commonly used (and not so commonly used) features all in one
-- simple window.
-- 
-- Written by Cirk of DoomHammer
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- AddOn name and version
------------------------------------------------------------------------------
CHATMANAGER_NAME = "Cirk's Chatmanager"
CHATMANAGER_VERSION = "1.12.0"


------------------------------------------------------------------------------
-- Saved state
------------------------------------------------------------------------------
ChatmanagerState = {};					-- Will be overridden when loaded, contains for each character:
										--   .Channels = name indexed array of saved channel information
										--   .Options = table of options
										--     .SmartSticky = whether to use smart sticky mode (1 or 0)
										--     .ChatLink = whether to use item linking in private chat channels (1 or 0)
										--     .ChatLinkFormat = whether to use ChatLink format for item links (1 or 0)
										--     .ReplyLastTell = whether reply goes to last whispered if no more incoming (1 or 0)
										--     .ChatLog = sticky chat logging mode (0 is don't care, 1 is yes but off, 2 is yes and on)
										--     .ShowButton = whether to show menu button or not (1 or 0)
										--     .EnableChatScroll = whether to enable mousewheel scrolling in chat windows (1 or 0)
										--     .HideChatButtons = whether to hide the normal scroll and emote buttons for the chat windows (1 or 0)
										--   .Sticky = table of sticky settings for various chat types
										-- Also contains per server:
										--   .Notes = simple list of player notes, indexed by name


------------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------------
CHATMANAGER_PLAYER_LIST_BUTTON_HEIGHT = 16;
CHATMANAGER_PLAYER_LIST_BUTTON_COUNT = 17;
CHATMANAGER_FIRST_CHANNEL = 1;
CHATMANAGER_LAST_CHANNEL = 10;


------------------------------------------------------------------------------
-- Configuration flags
--
-- The _preserveChannels flag can be set to 1 to allow Chatmanager to record
-- and re-establish (on login) all of the user's chat channels.  This feature
-- should never be needed.  NOTE THAT THIS FEATURE IS NOT YET IMPLEMENTED.
------------------------------------------------------------------------------
local _preserveChannels = nil;


------------------------------------------------------------------------------
-- Local defines
------------------------------------------------------------------------------
local CHATMANAGER_PLAYER_UPDATE_INITIAL_DELAY = 5.0;	-- time after starting a list update before removing pending players
local CHATMANAGER_PLAYER_UPDATE_DELAY = 1.0;			-- time after getting an update before removing pending players
local CHATMANAGER_PLAYER_REQUEST_DELAY = 2.0;			-- time after cleanup before next request will be issued


------------------------------------------------------------------------------
-- Color information
------------------------------------------------------------------------------
local _colorTextEnabled = {["r"] = 1.0, ["g"] = 0.82, ["b"] = 0};				-- GameFontNormal yellow
local _colorTextDisabled = {["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5};				-- Light grey
local _highlightAlpha = 0.5;													-- alpha level for highlight texture
local _suspendedAlpha = 0.3;													-- alpha level for suspended channels
local _playerOwner = {["r"] = 1.0, ["g"] = 0.82, ["b"] = 0};
local _playerModerator = {["r"] = 0, ["g"] = 0.82, ["b"] = 1.0};
local _playerMuted = {["r"] = 0.6, ["g"] = 0.6, ["b"] = 0.6};
local _playerNormal = {["r"] = 1.0, ["g"] = 1.0, ["b"] = 1.0};

local _defaultChannelColor = {["r"] = 1, ["g"] = 0.75294122, ["b"] = 0.75294122};


------------------------------------------------------------------------------
-- Local variables
------------------------------------------------------------------------------
local _thisFrame = nil;					-- The frame pointer
local _serverName = nil;				-- set to current realm when loaded
local _playerName = nil;				-- set to current playername when known
local _debugFrame = nil;				-- debug output chat frame

local _channelSavedList = {};			-- list of saved channel information, indexed by lower case channel name (e.g., "mychannel")
										--   .name = channel name in original capitalization (e.g., "MyChannel")
										--   .index = channel index to show to the user for this channel
										--   .password = password for this channel (nil if not used)
										--   .isSticky = sticky status (1 or 0)
										--   .forcePassword = whether to force password or not (1 or 0)
										--   .color = channel color
										--   .suspended = client index for this channel that it was suspended on
										--   .special = (flag) if this was a special channel (e.g. ctra) or nil otherwise
local _channelList = {};				-- list of channels (indexed by WoW client channel number):
										--   .name = name of channel (short form, e.g., General)
										--   .fullName = name of channel (long form, e.g., General - Ironforge)
										--   .displayIndex = channel index to show to the user for this channel
										--   .type = type of channel, where 0 is private, 1 is server, and nil means inactive
										--   .suspended = true if the channel is suspended, nil otherwise
										--   .playerList = list of players (indexed by name) on this channel
										--      .isMuted = true if player is muted
										--      .isModerator = true if player is moderator
										--      .isOwner = true if player is owner
										--      .pending = true if pending delete (nil otherwise)
										--   .playerCount = count of players in .playerList
										--   .filteredList = indexed list of player names in .playerList
										--   .password = password for this channel (nil if not used)
										--   .isSticky = sticky status (1 or 0)
										--   .forcePassword = whether to force password or not (1 or 0)
										--   .isModerated = moderated status (true/false) if known (nil otherwise)
										--   .amOwner = true if player is owner of the channel
										--   .amModerator = true if player is moderator for this channel
										--   .pending = time that a player list update will expire for this channel
										--   .request = time that a new player list request should be issued for this channel
										--   .userRequest = true if the user has explicitly requested a listing for this channel
										--   .nextUserRequest = true if the next listing for the channel is for the user
										--   .special = (flag) if this is a special channel (e.g., ctra) or nil otherwise
local _channelIndexLookupByName = {};			-- client's channel index given the channel name (lower case)
local _channelIndexLookupByDisplayIndex = {};	-- client's channel index given the display index
local _selectedChannelIndex = nil;				-- index in _channelList of currently selected channel (nil means none)
local _selectedChannelDisplayIndex = nil;		-- display index for currently selected channel (nil means none)
local _selectedPlayer = nil;			-- name of player currently targetted
local _ctraChannelIndex = nil;			-- set to client channel index of channel for CTRA (if there is one)

local _convertChannelNumber = nil;		-- set to true when inside ChatEdit_ParseText
local _ignoreLinkConversions = nil;		-- set to true when further link conversion should not be done

local _playerListUpdateTimeout = nil;	-- set to time at which the player list should be checked (nil if inactive)
local _channelConnects = nil;			-- list of channels to attempt to reconnect to indexed by name (contains sdata reference)
local _hideChatButtons = nil;			-- whether the chat buttons should be hidden or not currently
local _buttonsHidden = nil;				-- set to 1 if we hide the chat buttons at all during the current session

local _rarityLookupByColor = {};		-- auto-populated list of item color strings and their rarity
local _rarityConvertToColor = {};		-- auto-populated list of item rarities and their color strings
local _channelOriginalText = nil;		-- set to the original channel text if item substitution has been used


------------------------------------------------------------------------------
-- Hooked function originals
------------------------------------------------------------------------------
local _original_GetChannelName = nil;
local _original_GetChannelList = nil;
local _original_ChatFrame_OnEvent = nil;
local _original_ChatEdit_UpdateHeader = nil;
local _original_ChatEdit_ParseText = nil;
local _original_JoinChannelByName = nil;
local _original_ListChannelByName = nil;
local _original_ChatEdit_OnEnterPressed = nil;
local _original_ChatEdit_OnEscapePressed = nil;
local _original_ChatEdit_SendText = nil;
local _original_ChatEdit_AddHistory = nil;
local _original_FCF_SetButtonSide = nil;

local _original_SlashCommand_LEAVE = nil;
local _original_SlashCommand_LIST_CHANNEL = nil;
local _original_SlashCommand_CHAT_PASSWORD = nil;
local _original_SlashCommand_CHAT_OWNER = nil;
local _original_SlashCommand_CHAT_MODERATOR = nil;
local _original_SlashCommand_CHAT_UNMODERATOR = nil;
local _original_SlashCommand_CHAT_MODERATE = nil;
local _original_SlashCommand_CHAT_MUTE = nil;
local _original_SlashCommand_CHAT_UNMUTE = nil;
local _original_SlashCommand_CHAT_CINVITE = nil;
local _original_SlashCommand_CHAT_KICK = nil;
local _original_SlashCommand_CHAT_BAN = nil;
local _original_SlashCommand_CHAT_UNBAN = nil;
local _original_SlashCommand_CHAT_ANNOUNCE = nil;


------------------------------------------------------------------------------
-- Hooked function originals for other addons
------------------------------------------------------------------------------
local _original_FLT_ParseChatMessage = nil;			-- Linkerator


------------------------------------------------------------------------------
-- Popup defines (see Blizzard's StaticPopup.lua)
------------------------------------------------------------------------------
local _chatmanagerConfirmLeavePopup = {
	text = CHATMANAGER_TEXT.CONFIRM_LEAVE_FORMAT,
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	sound = "igCharacterInfoOpen",
	OnAccept = function(data)
		Chatmanager_HandlePopupAccept("LEAVE", data);
	end,
	timeout = 60,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
};


local _chatmanagerEnterChannelNamePopup = {
	text = CHATMANAGER_TEXT.ENTER_NEW_CHANNEL_TEXT,
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	hasWideEditBox = 1,
	maxLetters = 60,
	OnShow = function()
		local editBox = getglobal(this:GetName().."WideEditBox");
		editBox:SetText("");
		editBox:HighlightText();
		editBox:SetFocus();
		this:SetWidth(420);
		getglobal(this:GetName().."Text"):SetWidth(390);
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
		this:SetWidth(320);
		getglobal(this:GetName().."Text"):SetWidth(290);
	end,
	OnAccept = function(data)
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		Chatmanager_HandlePopupAccept("JOIN", data, editBox:GetText());
	end,
	EditBoxOnEnterPressed = function(data)
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		Chatmanager_HandlePopupAccept("JOIN", data, editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 60,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
};


local _chatmanagerEnterPlayerNotePopup = {
	text = CHATMANAGER_TEXT.ENTER_PLAYER_NOTE_TEXT,
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	hasWideEditBox = 1,
	maxLetters = 60,
	OnShow = function()
		local editBox = getglobal(this:GetName().."WideEditBox");
		editBox:SetText(Chatmanager_GetPopupData("PLAYERNOTE"));
		editBox:HighlightText();
		editBox:SetFocus();
		this:SetWidth(420);
		getglobal(this:GetName().."Text"):SetWidth(390);
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
		this:SetWidth(320);
		getglobal(this:GetName().."Text"):SetWidth(290);
	end,
	OnAccept = function(data)
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		Chatmanager_HandlePopupAccept("PLAYERNOTE", data, editBox:GetText());
	end,
	EditBoxOnEnterPressed = function(data)
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		Chatmanager_HandlePopupAccept("PLAYERNOTE", data, editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 60,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
};


------------------------------------------------------------------------------
-- Local functions
------------------------------------------------------------------------------
local function Chatmanager_Register()
	-- Register for events and hook functions.  Note that although Chatmanager
	-- uses a lot of function hooks, most of these are lightweight wrappers or
	-- near-identical replacements, and are intended to maintain the illusion
	-- that the channel order selected by the user is being used by the
	-- client, rather than just simulated by the addon.
	_thisFrame:RegisterEvent("PLAYER_TARGET_CHANGED");

	-- Function hooks
	if (not _original_GetChannelName) then
		_original_GetChannelName = GetChannelName;
		GetChannelName = Chatmanager_GetChannelName;
	end
	if (not _original_GetChannelList) then
		_original_GetChannelList = GetChannelList;
		GetChannelList = Chatmanager_GetChannelList;
	end
	if (not _original_ChatFrame_OnEvent) then
		_original_ChatFrame_OnEvent = ChatFrame_OnEvent;
		ChatFrame_OnEvent = Chatmanager_ChatFrame_OnEvent;
	end
	if (not _original_ChatEdit_UpdateHeader) then
		_original_ChatEdit_UpdateHeader = ChatEdit_UpdateHeader;
		ChatEdit_UpdateHeader = Chatmanager_ChatEdit_UpdateHeader;
	end
	if (not _original_ChatEdit_ParseText) then
		_original_ChatEdit_ParseText = ChatEdit_ParseText;
		ChatEdit_ParseText = Chatmanager_ChatEdit_ParseText;
	end
	if (not _original_JoinChannelByName) then
		_original_JoinChannelByName = JoinChannelByName;
		JoinChannelByName = Chatmanager_JoinChannelByName;
	end
	if (not _original_ListChannelByName) then
		_original_ListChannelByName = ListChannelByName;
		ListChannelByName = Chatmanager_ListChannelByName;
	end
	if (not _original_ChatEdit_OnEnterPressed) then
		_original_ChatEdit_OnEnterPressed = ChatEdit_OnEnterPressed;
		ChatEdit_OnEnterPressed = Chatmanager_ChatEdit_OnEnterPressed;
	end
	if (not _original_ChatEdit_OnEscapePressed) then
		_original_ChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed;
		ChatEdit_OnEscapePressed = Chatmanager_ChatEdit_OnEscapePressed;
	end
	if (not _original_ChatEdit_SendText) then
		_original_ChatEdit_SendText = ChatEdit_SendText;
		ChatEdit_SendText = Chatmanager_ChatEdit_SendText;
	end
	if (not _original_ChatEdit_AddHistory) then
		_original_ChatEdit_AddHistory = ChatEdit_AddHistory;
		ChatEdit_AddHistory = Chatmanager_ChatEdit_AddHistory;
	end
	if (not _original_FCF_SetButtonSide) then
		_original_FCF_SetButtonSide = FCF_SetButtonSide;
		FCF_SetButtonSide = Chatmanager_FCF_SetButtonSide;
	end

	-- Slash command function hooks
	if (not _original_SlashCommand_LEAVE) then
		_original_SlashCommand_LEAVE = SlashCmdList["LEAVE"];
		SlashCmdList["LEAVE"] = Chatmanager_SlashCommand_LEAVE;
	end
	if (not _original_SlashCommand_LIST_CHANNEL) then
		_original_SlashCommand_LIST_CHANNEL = SlashCmdList["LIST_CHANNEL"];
		SlashCmdList["LIST_CHANNEL"] = Chatmanager_SlashCommand_LIST_CHANNEL;
	end
	if (not _original_SlashCommand_CHAT_PASSWORD) then
		_original_SlashCommand_CHAT_PASSWORD = SlashCmdList["CHAT_PASSWORD"];
		SlashCmdList["CHAT_PASSWORD"] = Chatmanager_SlashCommand_CHAT_PASSWORD;
	end
	if (not _original_SlashCommand_CHAT_OWNER) then
		_original_SlashCommand_ = SlashCmdList["CHAT_OWNER"];
		SlashCmdList["CHAT_OWNER"] = Chatmanager_SlashCommand_CHAT_OWNER;
	end
	if (not _original_SlashCommand_CHAT_MODERATOR) then
		_original_SlashCommand_CHAT_MODERATOR = SlashCmdList["CHAT_MODERATOR"];
		SlashCmdList["CHAT_MODERATOR"] = Chatmanager_SlashCommand_CHAT_MODERATOR;
	end
	if (not _original_SlashCommand_CHAT_UNMODERATOR) then
		_original_SlashCommand_CHAT_UNMODERATOR = SlashCmdList["CHAT_UNMODERATOR"];
		SlashCmdList["CHAT_UNMODERATOR"] = Chatmanager_SlashCommand_CHAT_UNMODERATOR;
	end
	if (not _original_SlashCommand_CHAT_MODERATE) then
		_original_SlashCommand_CHAT_MODERATE = SlashCmdList["CHAT_MODERATE"];
		SlashCmdList["CHAT_MODERATE"] = Chatmanager_SlashCommand_CHAT_MODERATE;
	end
	if (not _original_SlashCommand_CHAT_MUTE) then
		_original_SlashCommand_CHAT_MUTE = SlashCmdList["CHAT_MUTE"];
		SlashCmdList["CHAT_MUTE"] = Chatmanager_SlashCommand_CHAT_MUTE;
	end
	if (not _original_SlashCommand_CHAT_UNMUTE) then
		_original_SlashCommand_CHAT_UNMUTE = SlashCmdList["CHAT_UNMUTE"];
		SlashCmdList["CHAT_UNMUTE"] = Chatmanager_SlashCommand_CHAT_UNMUTE;
	end
	if (not _original_SlashCommand_CHAT_CINVITE) then
		_original_SlashCommand_CHAT_CINVITE = SlashCmdList["CHAT_CINVITE"];
		SlashCmdList["CHAT_CINVITE"] = Chatmanager_SlashCommand_CHAT_CINVITE;
	end
	if (not _original_SlashCommand_CHAT_KICK) then
		_original_SlashCommand_CHAT_KICK = SlashCmdList["CHAT_KICK"];
		SlashCmdList["CHAT_KICK"] = Chatmanager_SlashCommand_CHAT_KICK;
	end
	if (not _original_SlashCommand_CHAT_BAN) then
		_original_SlashCommand_CHAT_BAN = SlashCmdList["CHAT_BAN"];
		SlashCmdList["CHAT_BAN"] = Chatmanager_SlashCommand_CHAT_BAN;
	end
	if (not _original_SlashCommand_CHAT_UNBAN) then
		_original_SlashCommand_CHAT_UNBAN = SlashCmdList["CHAT_UNBAN"];
		SlashCmdList["CHAT_UNBAN"] = Chatmanager_SlashCommand_CHAT_UNBAN;
	end
	if (not _original_SlashCommand_CHAT_ANNOUNCE) then
		_original_SlashCommand_CHAT_ANNOUNCE = SlashCmdList["CHAT_ANNOUNCE"];
		SlashCmdList["CHAT_ANNOUNCE"] = Chatmanager_SlashCommand_CHAT_ANNOUNCE;
	end

	-- Handle SKY library interaction problems by removing some of their slash
	-- command overrides:
	--   "LeaveChannel" - Sky uses this to warn about leaving Sky channels.
	--   "ListChannel" - Not sure why this is hooked by Sky anyway.
	--   "SkyChannelManager" - Sky uses these to prevent talking on hidden Sky
	--     channels and so its ChannelManager can handle sticky actions.
	if (Sky and Sky.unregisterSlashCommand) then
		Sky.unregisterSlashCommand("LeaveChannel");
		Sky.unregisterSlashCommand("ListChannel");
		Sky.unregisterSlashCommand("SkyChannelManager");
	end

	-- Handle other addon interaction problems
	if (LinkeratorFrame and FLT_ParseChatMessage) then
		-- For the Fizzwidget Linkerator (http://fizzwidget.com/linkerator/)
		if (not _original_FLT_ParseChatMessage) then
			_original_FLT_ParseChatMessage = FLT_ParseChatMessage;
			FLT_ParseChatMessage = Chatmanager_FLT_ParseChatMessage;
		end
	end
end


local function Chatmanager_RebuildPlayerFilteredList(cdata)
	-- Rebuilds the filteredList and playerCount properties for the indicated
	-- channel data entry
	if (cdata and cdata.playerList) then
		local list = {};
		for name in cdata.playerList do
			table.insert(list, name);
		end
		table.sort(list);
		cdata.filteredList = list;
		cdata.playerCount = table.getn(list);
	end
end


local function Chatmanager_ResetOrdering()
	-- Resets all channel display indices to their actual client indices, and
	-- removes all saved indices so that new channels will be joined at their
	-- client index by default.
	_channelIndexLookupByDisplayIndex = {};
	for index = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		if (_channelList[index].name) then
			_channelList[index].displayIndex = index;
			_channelIndexLookupByDisplayIndex[index] = index;
		end
	end
	for sname, sdata in _channelSavedList do
		sdata.index = nil;
		sdata.special = nil;
	end
end


local function Chatmanager_ResetColors()
	CloseDropDownMenus();
	ColorPickerFrame:Hide();
	for index = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		local cdata = _channelList[index];
		if (cdata and cdata.name and cdata.suspended) then
			local lname = string.lower(cdata.name);
			local sdata = _channelSavedList[lname];
			if (sdata and sdata.color) then
				sdata.color.r = _defaultChannelColor.r;
				sdata.color.g = _defaultChannelColor.g;
				sdata.color.b = _defaultChannelColor.b;
			end
		end
		ChangeChatColor("CHANNEL"..index, _defaultChannelColor.r, _defaultChannelColor.g, _defaultChannelColor.b);
	end
end


local function Chatmanager_ResetWindows()
	-- Menu button
	ChatmanagerMenuButtonFrame:ClearAllPoints();
	if (_hideChatButtons == 1) then
		ChatmanagerMenuButtonFrame:SetPoint("TOPRIGHT", "ChatFrame1", "TOPRIGHT");
	else
		ChatmanagerMenuButtonFrame:SetPoint("BOTTOM", "ChatFrameMenuButton", "TOP");
	end
	-- Chatmanager frame
	ChatmanagerFrame:ClearAllPoints();
	ChatmanagerFrame:SetPoint("TOPLEFT", nil, "TOPLEFT", 0, -104);
	-- Chatmanager options frame
	ChatmanagerOptionsFrame:ClearAllPoints();
	ChatmanagerOptionsFrame:SetPoint("TOPLEFT", ChatmanagerFrame, "TOPRIGHT", -4, 0);
end


local function Chatmanager_MoveChannelTo(index, displayIndex)
	-- Moves the selected channel to the indicated display index
	if (index and displayIndex) then
		local cdata = _channelList[index];
		if (cdata and cdata.name and cdata.displayIndex) then
			local replaceIndex = _channelIndexLookupByDisplayIndex[displayIndex];
			if (replaceIndex) then
				local pdata = _channelList[replaceIndex];
				if (pdata and pdata.name and pdata.displayIndex) then
					pdata.displayIndex = cdata.displayIndex;
				end
			end
			_channelIndexLookupByDisplayIndex[displayIndex] = index;
			_channelIndexLookupByDisplayIndex[cdata.displayIndex] = replaceIndex;
			cdata.displayIndex = displayIndex;
		end
	end
end


local function Chatmanager_RequestPlayerList(index, user)
	-- If a player list request is not already in progress for the indicated
	-- channel index, then mark all existing player entries as pending, and
	-- issue a player list update request.  If a request is already in
	-- progress then set the request flag so that a new listing will be
	-- requested after the current listing is completed.  If the user argument
	-- is true then the listing (current or next) is also flagged to be passed
	-- on to the user.
	local cdata = _channelList[index];
	if (not cdata or not cdata.name) then
		return;
	end
	if (cdata.pending) then
		if (not cdata.request) then
			cdata.request = cdata.pending + CHATMANAGER_PLAYER_REQUEST_DELAY;
		end
		if (user) then
			cdata.nextUserRequest = true;
		end
	elseif (not cdata.request) then
		if (cdata.playerList) then
			for name, pdata in cdata.playerList do
				pdata.pending = true;
			end
		end
		cdata.pending = GetTime() + CHATMANAGER_PLAYER_UPDATE_INITIAL_DELAY;
		if (not _playerListUpdateTimeout) then
			_playerListUpdateTimeout = cdata.pending;
			_thisFrame:SetScript("OnUpdate", ChatmanagerFrame_OnUpdate);
		end
		if (user) then
			cdata.userRequest = true;
		end
		_original_ListChannelByName(tostring(index));
	elseif (user) then
		cdata.nextUserRequest = true;
	end
end


------------------------------------------------------------------------------
-- Local utility functions
------------------------------------------------------------------------------
local function Chatmanager_GetNextParam(text)
	-- Extracts the next parameter out of the passed text, and returns it and
	-- the rest of the string
	for param, remain in string.gfind(text, "(%w+) +(.*)") do
		return param, remain;
	end
	return text;
end


local function Chatmanager_CheckLoadedVariables()
	-- Make sure that all loaded variables have valid values and performs any
	-- fixups required for version to version changes of Chatmanager or for
	-- saved versus active values.
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog == 2) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog = 1;
		if (not LoggingChat()) then
			LoggingChat(true);
		end
		local info = ChatTypeInfo["SYSTEM"];
		DEFAULT_CHAT_FRAME:AddMessage(TEXT(CHATLOGENABLED), info.r, info.g, info.b, info.id);
	end
	if (not ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton = 1;
	end
	local savedChannels = ChatmanagerState.Servers[_serverName].Characters[_playerName].Channels;
	local convert = nil;
	for name, sdata in savedChannels do
		local lname = string.lower(name);
		if ((name ~= lname) or not sdata.name) then
			convert = true;
			break;
		end
	end
	if (convert) then
		local newChannels = {};
		for name, sdata in savedChannels do
			local lname = string.lower(name);
			if (not sdata.name) then
				sdata.name = name;
			end
			newChannels[lname] = sdata;
		end
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Channels = newChannels;
	end
end


local function Chatmanager_ChannelIsSpecial(channelName)
	-- This function looks for special channels, such as those used by CTRA,
	-- oRA, KLHThreatMeter, SWStats, etc., so that these can be flagged and
	-- kept at a persistant display index in the Chatmanager list even when
	-- the channel name changes.  The  function returns either a small string
	-- used to identify the special channel (e.g., "ctra") or nil if there is
	-- no match.
	-- Note that from 1.12 onwards, many of these addons no longer use chat
	-- channels for their communications, but this feature remains here for
	-- backwards compatibility.
	if (not channelName) then
		return nil;
	end
	if (CT_RA_Channel) then
		-- CTRaidAssist
		if (string.lower(CT_RA_Channel or "") == string.lower(channelName)) then
			return "ctra";
		end
	end
	if (oRA_Core and oRA_Core.GetOpt) then
		-- oRA
		local name = oRA_Core:GetOpt("channel") or "";
		if (string.lower(name) == string.lower(channelName)) then
			return "ora";
		end
	end
	if (klhtm and klhtm.net and klhtm.net.getchannel) then
		-- KLHThreatMeter - can use the CTRA or oRA channels or its own, so we
		-- only test for this after those.
		local number, name = klhtm.net.getchannel();
		if (string.lower(name or "") == string.lower(channelName)) then
			return "klhtm";
		end
	end
	if (DamageMeters_syncChannel) then
		if (string.lower(DamageMeters_syncChannel or "") == string.lower(channelName)) then
			return "dmeter";
		end
	end
	if (SW_Settings) then
		-- SWStats
		local name = SW_Settings["SYNCLastChan"] or "";
		if (string.lower(name) == string.lower(channelName)) then
			return "swstats";
		end
	end
	if (SuicideKingsOptions and SuicideKingsOptions.useCustomChannel and SuicideKingsOptions.syncChannel) then
		-- Suicide Kings
		if (string.lower(SuicideKingsOptions.syncChannel) == string.lower(channelName)) then
			return "sk";
		end
	end
	return nil;
end


------------------------------------------------------------------------------
-- Initialization and logout functions
------------------------------------------------------------------------------
function Chatmanager_Initialize()
	-- Called once the player's information has been loaded, this function
	-- fills in the current channel list and then loads the saved channel list
	-- information from ChatmanagerState so it can make changes for the actual
	-- versus displayed channel index.  Once this is done, the reference
	-- tables are filled in for speed of access later.

	-- First get list of current channels from client (this will normally be
	-- empty unless we have done a console reload).
	_channelList = {};
	_channelIndexLookupByName = {};
	for index = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		_channelList[index] = {};
	end
	local list = {_original_GetChannelList()};
	for i = 1, table.getn(list), 2 do
		local index = list[i];
		if ((index >= CHATMANAGER_FIRST_CHANNEL) and (index <= CHATMANAGER_LAST_CHANNEL)) then
			local _, fullName = _original_GetChannelName(tostring(index));
			_channelList[index].name = list[i+1];
			_channelList[index].fullName = fullName;
			_channelList[index].type = 0;
			_channelIndexLookupByName[string.lower(list[i+1])] = index;
		end
	end
	list = {EnumerateServerChannels()};
	for i = 1, table.getn(list) do
		local lname = string.lower(list[i]);
		for j = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
			if (_channelList[j].name and (string.lower(_channelList[j].name) == lname)) then
				_channelList[j].type = 1;
				break;
			end
		end
	end

	-- Find any suspended channels in the saved list, and add these to the
	-- channel list if they aren't already there.
	_channelSavedList = ChatmanagerState.Servers[_serverName].Characters[_playerName].Channels;
	for sname, sdata in _channelSavedList do
		local index = sdata.suspended;
		if (index and not _channelList[index].name) then
			_channelList[index].name = sdata.name;
			_channelList[index].fullName = sdata.name;
			_channelList[index].type = 1;
			_channelList[index].suspended = true;
			_channelIndexLookupByName[sname] = index;
		end
	end

	-- Now use the saved list to update the display indices and other saved
	-- parameters
	_channelIndexLookupByDisplayIndex = {};
	for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		if (_channelList[i].name) then
			local lname = string.lower(_channelList[i].name);
			local sdata = _channelSavedList[lname];
			if (sdata) then
				_channelList[i].password = sdata.password;
				_channelList[i].isSticky = sdata.isSticky;
				_channelList[i].forcePassword = sdata.forcePassword;
				if (sdata.index and not _channelIndexLookupByDisplayIndex[sdata.index]) then
					_channelList[i].displayIndex = sdata.index;
					_channelIndexLookupByDisplayIndex[sdata.index] = i;
				end
				if (sdata.color) then
					ChangeChatColor("CHANNEL"..i, sdata.color.r, sdata.color.g, sdata.color.b);
				end
			end
		end
	end

	-- Check if any of the channels are special channels, and if so give it
	-- the previous matching display index, allowing this to override any
	-- matches to channels of the same name in the saved list if possible.
	for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		local special = Chatmanager_ChannelIsSpecial(_channelList[i].name);
		if (special) then
			_channelList[i].special = special;
			for sname, sdata in _channelSavedList do
				if ((sdata.special == special) and sdata.index) then
					if (not _channelIndexLookupByDisplayIndex[sdata.index]) then
						if (_channelList[i].displayIndex) then
							_channelIndexLookupByDisplayIndex[_channelList[i].displayIndex] = nil;
						end
						_channelList[i].displayIndex = sdata.index;
						_channelIndexLookupByDisplayIndex[sdata.index] = i;
					end
					sdata.special = nil;
					break;
				end
			end
		end
	end

	-- Find any remaining entries that don't have a displayIndex assigned yet
	-- and give them one.
	for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		if (_channelList[i].name and not _channelList[i].displayIndex) then
			for j = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
				if (not _channelIndexLookupByDisplayIndex[j]) then
					_channelList[i].displayIndex = j;
					_channelIndexLookupByDisplayIndex[j] = i;
					break;
				end
			end
		end
	end

	-- Clean up WoW's Chatframe event registration to reduce overheads a bit,
	-- and make sure the first tab is selected by default.
	tinsert(ChatTypeGroup["CHANNEL"], "CHAT_MSG_CHANNEL");
	for tab = 1, NUM_CHAT_WINDOWS do
		local chatFrame = getglobal("ChatFrame"..tab);
		local _, _, _, _, _, _, shown, _, docked = GetChatWindowInfo(tab);
		if (shown or docked) then
			chatFrame:RegisterEvent("CHAT_MSG_CHANNEL");
		else
			chatFrame:UnregisterEvent("CHAT_MSG_CHANNEL");
		end
	end
	if (ChatFrame1.isDocked) then
		FCF_SelectDockFrame(ChatFrame1);
	end

	-- Lastly request the player list for every non-server channel.
	for index = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		if (_channelList[index].name) then
			if (_channelList[index].type == 0) then
				Chatmanager_RequestPlayerList(index);
			end
		end
	end
end


local function Chatmanager_UpdateSticky()
	for type, value in ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky do
		ChatTypeInfo[type].sticky = value;
	end
end


local function Chatmanager_UpdateScrollingAndButtons()
	-- Enable or disable mouse wheel events, and show or hide the scroll
	-- buttons for each window as needed.  To keep the buttons hidden, a new
	-- field is added to each frame object to contain the original OnShow
	-- handler, and the OnShow handler replaced with our own version.
	-- Similarly a new field is added to the bottom button for each frame.
	-- In order to prevent "touching" the chat frame button states when we are
	-- not controlling them (but which other components might be) we use the
	-- _buttonsHidden flag to determine if we have actively hidden the buttons
	-- in this session, and therefore whether it is valid to unhide them if
	-- such a action is required.
	local enable = ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.EnableChatScroll;
	local hidden = ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.HideChatButtons;
	if ((enable == 1) and (hidden == 1)) then
		_hideChatButtons = 1;
		_buttonsHidden = 1;
	else
		_hideChatButtons = 0;
	end
	for i = 1, 7 do
		local frame = getglobal("ChatFrame"..i);
		local bottomButton = getglobal("ChatFrame"..i.."BottomButton");
		if (frame) then
			if (enable == 1) then
				frame:EnableMouseWheel(1);
				frame:SetScript("OnMouseWheel", Chatmanager_ChatFrameOnScroll);
			else
				frame:EnableMouseWheel(0);
				frame:SetScript("OnMouseWheel", nil);
			end
			if (_hideChatButtons == 1) then
				if (not frame.chatmanagerOrigOnShow) then
					frame.chatmanagerOrigOnShow = frame:GetScript("OnShow");
					frame:SetScript("OnShow", Chatmanager_ChatFrameOnShow);
					if (frame:IsShown()) then
						frame:Hide();
						frame:Show();
					end
				end
			elseif (frame.chatmanagerOrigOnShow) then
				frame:SetScript("OnShow", frame.chatmanagerOrigOnShow);
				if (frame:IsShown()) then
					frame:Hide();
					frame:Show();
				end
				frame.chatmanagerOrigOnShow = nil;
			end
		end
		if (bottomButton) then
			if (_hideChatButtons == 1) then
				if (not bottomButton.chatmanagerOrigOnClick) then
					bottomButton.chatmanagerOrigOnClick = bottomButton:GetScript("OnClick");
					bottomButton:SetScript("OnClick", Chatmanager_ChatFrameBottomButtonOnClick);
				end
				bottomButton:ClearAllPoints();
				bottomButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, -4);
			elseif (_buttonsHidden == 1) then
				bottomButton:ClearAllPoints();
				if (FCF_GetButtonSide(frame) == "left") then
					bottomButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -32, -4);
				else
					bottomButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -4);
				end
				if (bottomButton.chatmanagerOrigOnClick) then
					bottomButton:SetScript("OnClick", bottomButton.chatmanagerOrigOnClick);
					bottomButton.chatmanagerOrigOnClick = nil;
				end
			end
		end
	end
	if (_hideChatButtons == 1) then
		ChatFrameMenuButton:Hide();
	elseif (_buttonsHidden == 1) then
		ChatFrameMenuButton:Show();
	end
end


local function Chatmanager_VariablesLoaded()
	-- Called for the VARIABLES_LOADED event, this function retrieves the
	-- current settings and sets the realm name
	_serverName = GetRealmName();
	if (not ChatmanagerState) then
		ChatmanagerState = {};
	end
	if (not ChatmanagerState.Servers) then
		ChatmanagerState.Servers = {};
	end
	if (not ChatmanagerState.Servers[_serverName]) then
		ChatmanagerState.Servers[_serverName] = {};
	end
	if (not ChatmanagerState.Servers[_serverName].Characters) then
		ChatmanagerState.Servers[_serverName].Characters = {};
	end
	if (not ChatmanagerState.Servers[_serverName].Notes) then
		ChatmanagerState.Servers[_serverName].Notes = {};
	end
end


local function Chatmanager_PlayerLogin()
	-- This function is called for the PLAYER_LOGIN event and checks to see if
	-- the playername is known so the player's per character settings can be
	-- retrieved, or the default settings should be used instead.
	_playerName = UnitName("player");

	-- Make sure basic saved variable structure is present
	if (not ChatmanagerState.Servers[_serverName].Characters[_playerName]) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName] = {};
	end
	if (not ChatmanagerState.Servers[_serverName].Characters[_playerName].Channels) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Channels = {};
	end
	if (not ChatmanagerState.Servers[_serverName].Characters[_playerName].Options) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options = {};
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.SmartSticky = 0;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLink = 0;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLinkFormat = 0;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ReplyLastTell = 0;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog = 0;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton = 1;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.EnableChatScroll = 0;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.HideChatButtons = 0;
	end
	if (not ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky = {};
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky["SAY"] = ChatTypeInfo["SAY"].sticky;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky["PARTY"] = ChatTypeInfo["PARTY"].sticky;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky["RAID"] = ChatTypeInfo["RAID"].sticky;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky["GUILD"] = ChatTypeInfo["GUILD"].sticky;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky["OFFICER"] = ChatTypeInfo["OFFICER"].sticky;
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky["WHISPER"] = ChatTypeInfo["WHISPER"].sticky;
	end

	-- Process the loaded variables (and do past version cleanups)
	Chatmanager_CheckLoadedVariables();

	-- Register for required events and hook functions
	Chatmanager_Register();

	-- Begin processing of the current channels (if any)
	Chatmanager_Initialize();

	-- Update sticky mode for non-channels
	Chatmanager_UpdateSticky();

	-- Update chat scrolling and button shown/hidden states
	Chatmanager_UpdateScrollingAndButtons();

	-- Show the Chatmanager button (if enabled)
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton == 1) then
		ChatmanagerMenuButtonFrame:Show();
	end
end


function Chatmanager_PlayerLogout()
	-- Just build and save the new _channelSavedList.  Note that in regards to
	-- password protected channels and the client's not saving the password,
	-- some Addon developers recommend simply leaving the channels on logout.
	-- However this doesn't appear to work properly: if we are doing a console
	-- reload then the YOU_LEFT message arrives after the reload and causes
	-- some sequencing issues; and a proper logout doesn't record that you
	-- have actually left the channel, and so logs back in with the default
	-- empty password anyway.  Since here we don't have to worry about the
	-- order in which channels are joined explicitly, we will deal with the
	-- password issue by reattempting at login instead.
	-- First copy relevant details from current channel list
	_channelSavedList = {};
	for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		if (_channelList[i].name) then
			sdata = {};
			sdata.index = _channelList[i].displayIndex;
			if (_channelList[i].password and (_channelList[i].password ~= "") and (_channelList[i].type == 0)) then
				sdata.password = _channelList[i].password;
			end
			sdata.isSticky = _channelList[i].isSticky;
			sdata.forcePassword = _channelList[i].forcePassword;
			local info = ChatTypeInfo["CHANNEL"..i];
			sdata.color = {};
			sdata.color.r = info.r;
			sdata.color.g = info.g;
			sdata.color.b = info.b;
			sdata.name = _channelList[i].name;
			if (_channelList[i].suspended) then
				sdata.suspended = i;
			else
				sdata.suspended = nil;
			end
			sdata.special = _channelList[i].special or Chatmanager_ChannelIsSpecial(_channelList[i].name);
			_channelSavedList[string.lower(_channelList[i].name)] = sdata;
		end
	end
	-- For all channels (if channel preservation is enabled) or just for
	-- password protected channels (otherwise), build a table of which tabs
	-- each channel is assigned to.
	local windowList;
	for tab = 1, NUM_CHAT_WINDOWS do
		windowList = {GetChatWindowChannels(tab)};
		for i = 1, table.getn(windowList), 2 do
			if (windowList[i+1] == 0) then
				local lname = string.lower(windowList[i]);
				local sdata = _channelSavedList[lname];
				if (sdata) then
					if (sdata.password or (_preserveChannels == 1)) then
						if (not sdata.tabs) then
							sdata.tabs = {};
						end
						table.insert(sdata.tabs, tab);
					end
				end
			end
		end
	end
	-- Save list
	ChatmanagerState.Servers[_serverName].Characters[_playerName].Channels = _channelSavedList;
	-- Record chat logging state if needed
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog == 1) then
		if (LoggingChat()) then
			ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog = 2;
		end
	end
end


------------------------------------------------------------------------------
-- ChatmanagerFrame UI functions
------------------------------------------------------------------------------
function ChatmanagerFrame_OnLoad()
	-- Make our frame closable with the ESC key
	tinsert(UISpecialFrames, "ChatmanagerFrame");

	-- Set title and version text
	ChatmanagerFrameTitleText:SetText(CHATMANAGER_TEXT.FRAME_TITLE);
	ChatmanagerFrameVersionText:SetText("v"..CHATMANAGER_VERSION.." by Cirk");
	ChatmanagerFrameVersionText:SetAlpha(0.6);

	-- Set text for buttons, tooltips, etc.
	ChatmanagerChannelSettingsFramePasswordText:SetText(CHATMANAGER_TEXT.PASSWORD_TITLE);
	ChatmanagerChannelSettingsFrameForcePasswordText:SetText(CHATMANAGER_TEXT.ALWAYS_USE_PASSWORD_TITLE);
	ChatmanagerChannelSettingsFrameForcePasswordCheckButton.tooltipOnText = CHATMANAGER_TEXT.ALWAYS_USE_PASSWORD_ON_TOOLTIP;
	ChatmanagerChannelSettingsFrameForcePasswordCheckButton.tooltipOffText = CHATMANAGER_TEXT.ALWAYS_USE_PASSWORD_OFF_TOOLTIP;
	ChatmanagerChannelSettingsFrameStickyText:SetText(CHATMANAGER_TEXT.CHANNEL_STICKY_TITLE);
	ChatmanagerChannelSettingsFrameStickyCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHANNEL_STICKY_ON_TOOLTIP;
	ChatmanagerChannelSettingsFrameStickyCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHANNEL_STICKY_OFF_TOOLTIP;
	ChatmanagerChannelSettingsFrameColorText:SetText(CHATMANAGER_TEXT.CHANNEL_COLOR_TITLE);
	ChatmanagerChannelSettingsFrameColorSwatch.tooltipText = CHATMANAGER_TEXT.CHANNEL_COLOR_TOOLTIP;
	ChatmanagerChannelSettingsFramePasswordSetButtonText:SetText(CHATMANAGER_TEXT.PASSWORD_SET_BUTTON);
	ChatmanagerChannelSettingsFrameModerateButtonText:SetText(CHATMANAGER_TEXT.MODERATE_BUTTON);
	ChatmanagerFrameOptionsButtonText:SetText(CHATMANAGER_TEXT.OPTIONS_BUTTON);
end


function ChatmanagerFrame_OnShow()
	ChatmanagerFrame_UpdateChannelList(_selectedChannelDisplayIndex);
	ChatmanagerFrame_UpdatePlayerList();
end


function ChatmanagerFrame_UpdateChannelList(buttonID)
	-- Called when the channel list has changed (buttonID is nil) or when a
	-- new channel has been selected (buttonID set to the display index of the
	-- channel selected).
	if (_debugFrame) then
		if (buttonID) then
			_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."ChatmanagerFrame_UpdateChannelList("..buttonID..")");
		else
			_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."ChatmanagerFrame_UpdateChannelList()");
		end
	end
	if (not ChatmanagerFrame:IsVisible()) then
		return;
	end

	-- Update the channel listing
	if (buttonID) then
		CloseDropDownMenus();
		_selectedChannelDisplayIndex = tonumber(buttonID);
	end
	local lastSelectedChannelIndex = _selectedChannelIndex;
	_selectedChannelIndex = nil;
	for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
		local button = getglobal("ChatmanagerChannelListFrameButton"..i);
		local nameText = getglobal("ChatmanagerChannelListFrameButton"..i.."NameText");
		local numberText = getglobal("ChatmanagerChannelListFrameButton"..i.."NumberText");
		local highlight = getglobal("ChatmanagerChannelListFrameButton"..i.."Highlight");
		local index = _channelIndexLookupByDisplayIndex[i];
		if (index and _channelList[index].name) then
			local count = _channelList[index].playerCount;
			local name = _channelList[index].fullName;
			if (not name) then
				name = _channelList[index].name;
			end
			if ((_channelList[index].type == 0) and count and (count > 0)) then
				nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_FORMAT, name, count));
			elseif (not _channelList[index].suspended) then
				nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_NOPLAYERS_FORMAT, name));
			else
				nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_SUSPENDED_FORMAT, name));
			end
			if (i == _selectedChannelDisplayIndex) then
				_selectedChannelIndex = index;
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
			local alpha = 1;
			if (_channelList[index].suspended) then
				alpha = _suspendedAlpha;
			end
			local info = ChatTypeInfo["CHANNEL"..index];
			nameText:SetTextColor(info.r, info.g, info.b, alpha);
			numberText:SetTextColor(info.r, info.g, info.b, alpha);
			highlight:SetVertexColor(info.r, info.g, info.b, _highlightAlpha*alpha);
		else
			nameText:SetText("");
			if (i == _selectedChannelDisplayIndex) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
			nameText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
			numberText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
			highlight:SetVertexColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b, _highlightAlpha);
		end
	end

	-- Update the channel settings and if the selected channel has changed (or
	-- has been clicked on again) then refresh the player list
	if (_selectedChannelIndex) then
		local title = format(CHATMANAGER_TEXT.FRAME_SETTINGS_TITLE_FORMAT, _channelList[_selectedChannelIndex].name);
		local info = ChatTypeInfo["CHANNEL".._selectedChannelIndex];
		local password = _channelList[_selectedChannelIndex].password;
		local sticky = _channelList[_selectedChannelIndex].isSticky;
		local forcePassword = _channelList[_selectedChannelIndex].forcePassword;
		local moderate = _channelList[_selectedChannelIndex].amOwner or _channelList[_selectedChannelIndex].amModerator;
		ChatmanagerChannelSettingsFrameTitle:SetText(title);
		ChatmanagerChannelSettingsFrameColorSwatchNormalTexture:SetVertexColor(info.r, info.g, info.b);
		ChatmanagerChannelSettingsFrameColorSwatch.channelID = _selectedChannelIndex;
		ChatmanagerChannelSettingsFrameColorSwatch:Enable();
		if (_channelList[_selectedChannelIndex].type == 0) then
			ChatmanagerChannelSettingsFramePasswordText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
			ChatmanagerChannelSettingsFrameForcePasswordText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
			ChatmanagerChannelSettingsFrameEditBox:Show();
			if (buttonID or (lastSelectedChannelIndex ~= _selectedChannelIndex)) then
				local text = ChatmanagerChannelSettingsFrameEditBox:GetText();
				if (password) then
					if (password ~= text) then
						ChatmanagerChannelSettingsFrameEditBox:SetText(password);
						ChatmanagerChannelSettingsFrameEditBox.textSet = 1;
					end
				elseif (text ~= "") then
					ChatmanagerChannelSettingsFrameEditBox:SetText("");
					ChatmanagerChannelSettingsFrameEditBox.textSet = 1;
				end
				ChatmanagerChannelSettingsFrameEditBox:ClearFocus();
				ChatmanagerChannelSettingsFramePasswordSetButton:Disable();
			end
			ChatmanagerChannelSettingsFrameForcePasswordCheckButton:Enable();
			if (forcePassword == 1) then
				ChatmanagerChannelSettingsFrameForcePasswordCheckButton:SetChecked(1);
			else
				ChatmanagerChannelSettingsFrameForcePasswordCheckButton:SetChecked(0);
			end
			if (moderate) then
				ChatmanagerChannelSettingsFrameModerateButton:Enable();
			else
				ChatmanagerChannelSettingsFrameModerateButton:Disable();
			end
		else
			ChatmanagerChannelSettingsFramePasswordText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
			ChatmanagerChannelSettingsFrameForcePasswordText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
			ChatmanagerChannelSettingsFrameEditBox:Hide();
			ChatmanagerChannelSettingsFramePasswordSetButton:Disable();
			ChatmanagerChannelSettingsFrameForcePasswordCheckButton:Disable();
			ChatmanagerChannelSettingsFrameForcePasswordCheckButton:SetChecked(0);
			ChatmanagerChannelSettingsFrameModerateButton:Disable();
		end
		ChatmanagerChannelSettingsFrameStickyCheckButton:Enable();
		if (sticky == 1) then
			ChatmanagerChannelSettingsFrameStickyCheckButton:SetChecked(1);
		else
			ChatmanagerChannelSettingsFrameStickyCheckButton:SetChecked(0);
		end
		ChatmanagerChannelSettingsFrameColorText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		ChatmanagerChannelSettingsFrameStickyText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		-- Refresh the player list (if not already in progress)
		if (buttonID or (lastSelectedChannelIndex ~= _selectedChannelIndex)) then
			if (not _channelList[_selectedChannelIndex].suspended) then
				Chatmanager_RequestPlayerList(_selectedChannelIndex);
			end
		end
	else
		ChatmanagerChannelSettingsFrameTitle:SetText(CHATMANAGER_TEXT.SETTINGS_TITLE_UNSELECTED);
		ChatmanagerChannelSettingsFrameColorSwatchNormalTexture:SetVertexColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		ChatmanagerChannelSettingsFrameColorSwatch.channelID = nil;
		ChatmanagerChannelSettingsFrameColorSwatch:Disable();
		ChatmanagerChannelSettingsFrameEditBox:Hide();
		ChatmanagerChannelSettingsFramePasswordSetButton:Disable();
		ChatmanagerChannelSettingsFrameStickyCheckButton:Disable();
		ChatmanagerChannelSettingsFrameStickyCheckButton:SetChecked(0);
		ChatmanagerChannelSettingsFrameForcePasswordCheckButton:Disable();
		ChatmanagerChannelSettingsFrameForcePasswordCheckButton:SetChecked(0);
		ChatmanagerChannelSettingsFrameModerateButton:Disable();
		ChatmanagerChannelSettingsFramePasswordText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		ChatmanagerChannelSettingsFrameForcePasswordText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		ChatmanagerChannelSettingsFrameColorText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		ChatmanagerChannelSettingsFrameStickyText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
	end
end


function ChatmanagerFrame_UpdateChannelPlayerCounts(cdata)
	-- Updates just the player counts shown in the non-server channel names.
	-- If the optional cdata is provided then only that channel will be
	-- updated.
	if (cdata and cdata.name and cdata.displayIndex) then
		local nameText = getglobal("ChatmanagerChannelListFrameButton"..cdata.displayIndex.."NameText");
		if (nameText and (cdata.type == 0)) then
			local count = cdata.playerCount;
			local name = cdata.fullName;
			if (not name) then
				name = cdata.name;
			end
			if (count and (count > 0)) then
				nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_FORMAT, name, count));
			else
				nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_NOPLAYERS_FORMAT, name));
			end
		end
	else
		for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
			local nameText = getglobal("ChatmanagerChannelListFrameButton"..i.."NameText");
			local index = _channelIndexLookupByDisplayIndex[i];
			if (index and _channelList[index].name and (_channelList[index].type == 0)) then
				local count = _channelList[index].playerCount;
				local name = _channelList[index].fullName;
				if (not name) then
					name = _channelList[index].name;
				end
				if (count and (count > 0)) then
					nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_FORMAT, name, count));
				else
					nameText:SetText(format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_NOPLAYERS_FORMAT, name));
				end
			end
		end
	end
end


function ChatmanagerFrame_UpdatePlayerList()
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."ChatmanagerFrame_UpdatePlayerList()");
	end
	if (not ChatmanagerFrame:IsVisible()) then
		return;
	end

	local offset = FauxScrollFrame_GetOffset(ChatmanagerPlayerListScrollFrame);
	local currentOffset = offset;
	local playerList = nil;
	local filteredList = nil;
	local playerCount = 0;

	if (_selectedChannelIndex) then
		local cdata = _channelList[_selectedChannelIndex];
		if (cdata and cdata.playerList and cdata.filteredList and cdata.playerCount) then
			playerList = cdata.playerList;
			filteredList = cdata.filteredList;
			playerCount = cdata.playerCount;
		end
	end

	if ((offset + CHATMANAGER_PLAYER_LIST_BUTTON_COUNT) > playerCount) then
		offset = playerCount - CHATMANAGER_PLAYER_LIST_BUTTON_COUNT;
		if (offset < 0) then
			offset = 0;
		end
	end
	if (offset ~= currentOffset) then
		FauxScrollFrame_SetOffset(ChatmanagerPlayerListScrollFrame, offset);
		ChatmanagerPlayerListScrollFrameScrollBar:SetValue(offset * CHATMANAGER_PLAYER_LIST_BUTTON_HEIGHT);
	end

	-- Update title
	if (playerCount > 0) then
		ChatmanagerPlayerListFrameTitle:SetText(string.format(CHATMANAGER_TEXT.FRAME_PLAYERS_TITLE_FORMAT, playerCount));
	else
		ChatmanagerPlayerListFrameTitle:SetText(CHATMANAGER_TEXT.FRAME_PLAYERS_TITLE_NONE);
	end

	-- Update buttons
	for i = 1, CHATMANAGER_PLAYER_LIST_BUTTON_COUNT do
		local button = getglobal("ChatmanagerPlayerListFrameButton"..i);
		local index = i + offset;
		if (index <= playerCount) then
			local nameText = getglobal("ChatmanagerPlayerListFrameButton"..i.."NameText");
			local nameHighlight = getglobal("ChatmanagerPlayerListFrameButton"..i.."Highlight");
			local pname = filteredList[index];
			local pdata = playerList[pname];
			button.pindex = index;
			button.pname = pname;
			if (pdata.isOwner) then
				nameText:SetText(string.format(CHATMANAGER_TEXT.PLAYER_NAME_OWNER_FORMAT, pname));
				nameText:SetTextColor(_playerOwner.r, _playerOwner.g, _playerOwner.b);
				nameHighlight:SetVertexColor(_playerOwner.r, _playerOwner.g, _playerOwner.b, _highlightAlpha);
				button.tooltipText = string.format(CHATMANAGER_TEXT.PLAYER_OWNER_TOOLTIP_FORMAT, pname);
			elseif (pdata.isModerator) then
				nameText:SetText(string.format(CHATMANAGER_TEXT.PLAYER_NAME_MODERATOR_FORMAT, pname));
				nameText:SetTextColor(_playerModerator.r, _playerModerator.g, _playerModerator.b);
				nameHighlight:SetVertexColor(_playerModerator.r, _playerModerator.g, _playerModerator.b, _highlightAlpha);
				button.tooltipText = string.format(CHATMANAGER_TEXT.PLAYER_MODERATOR_TOOLTIP_FORMAT, pname);
			elseif (pdata.isMuted) then
				nameText:SetText(string.format(CHATMANAGER_TEXT.PLAYER_NAME_MUTED_FORMAT, pname));
				nameText:SetTextColor(_playerMuted.r, _playerMuted.g, _playerMuted.b);
				nameHighlight:SetVertexColor(_playerMuted.r, _playerMuted.g, _playerMuted.b, _highlightAlpha);
				button.tooltipText = string.format(CHATMANAGER_TEXT.PLAYER_MUTED_TOOLTIP_FORMAT, pname);
			else
				nameText:SetText(string.format(CHATMANAGER_TEXT.PLAYER_NAME_NORMAL_FORMAT, pname));
				nameText:SetTextColor(_playerNormal.r, _playerNormal.g, _playerNormal.b);
				nameHighlight:SetVertexColor(_playerNormal.r, _playerNormal.g, _playerNormal.b, _highlightAlpha);
				button.tooltipText = nil;
			end
			button.tooltipText2 = ChatmanagerState.Servers[_serverName].Notes[pname];
			if (_selectedPlayer == pname) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
			button:Show();
		else
			button.pindex = nil;
			button.pname = nil;
			button:Hide();
		end
	end

	-- Update scrollbar
	FauxScrollFrame_Update(ChatmanagerPlayerListScrollFrame, playerCount, CHATMANAGER_PLAYER_LIST_BUTTON_COUNT, CHATMANAGER_PLAYER_LIST_BUTTON_HEIGHT);
end


function ChatmanagerFrame_StickyOnClick()
	if (_selectedChannelIndex) then
		local cdata = _channelList[_selectedChannelIndex];
		if (cdata and cdata.name) then
			if (this:GetChecked()) then
				cdata.isSticky = 1;
			else
				cdata.isSticky = 0;
			end
		end
	end
end


function ChatmanagerFrame_ForcePasswordOnClick()
	if (_selectedChannelIndex) then
		local cdata = _channelList[_selectedChannelIndex];
		if (cdata and cdata.name) then
			if (this:GetChecked()) then
				cdata.forcePassword = 1;
			else
				cdata.forcePassword = 0;
			end
		end
	end
end


function ChatmanagerFrame_SetChatColor(previous)
	local r, g, b = ColorPickerFrame:GetColorRGB();
	if (previous) then
		r = previous.r;
		g = previous.g;
		b = previous.b;
	end
	ChangeChatColor(UIDROPDOWNMENU_MENU_VALUE, r, g, b);
	if (_selectedChannelIndex) then
		local cdata = _channelList[_selectedChannelIndex];
		if (cdata and cdata.name) then
			if (cdata.suspended) then
				local lname = string.lower(cdata.name);
				local sdata = _channelSavedList[lname];
				if (sdata and sdata.color) then
					sdata.color.r = r;
					sdata.color.g = g;
					sdata.color.b = b;
				end
			end
			if (ChatmanagerFrame:IsVisible() and _selectedChannelDisplayIndex) then
				ChatmanagerChannelSettingsFrameColorSwatchNormalTexture:SetVertexColor(r, g, b);
				local alpha = 1;
				if (cdata.suspended) then
					alpha = _suspendedAlpha;
				end
				local nameText = getglobal("ChatmanagerChannelListFrameButton".._selectedChannelDisplayIndex.."NameText");
				local numberText = getglobal("ChatmanagerChannelListFrameButton".._selectedChannelDisplayIndex.."NumberText");
				local highlight = getglobal("ChatmanagerChannelListFrameButton".._selectedChannelDisplayIndex.."Highlight");
				nameText:SetTextColor(r, g, b, alpha);
				numberText:SetTextColor(r, g, b, alpha);
				highlight:SetVertexColor(r, g, b, _highlightAlpha*alpha);
			end
		end
	end
end


function ChatmanagerFrame_OnUpdate()
	-- Checks for any pending names in the various player lists, and if any
	-- are found they are removed.  Note the code here uses the filteredList
	-- as an interator over the playerList so that we can safely remove
	-- entries from inside the for loop.  Also resets the userRequest flag for
	-- each channel if the request has expired.
	if (_playerListUpdateTimeout) then
		local time = GetTime();
		if (time > _playerListUpdateTimeout) then
			local nextUpdate = nil;
			for index = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
				local cdata = _channelList[index];
				if (cdata.pending) then
					if (time > cdata.pending) then
						local playerList = cdata.playerList;
						local filteredList = cdata.filteredList;
						if (playerList and filteredList) then
							for _, name in filteredList do
								pdata = playerList[name];
								if (pdata and pdata.pending) then
									playerList[name] = nil;
								end
							end
						end
						cdata.pending = nil;
						if (cdata.request) then
							cdata.request = time + CHATMANAGER_PLAYER_REQUEST_DELAY;
						end
						Chatmanager_RebuildPlayerFilteredList(cdata);
						ChatmanagerFrame_UpdateChannelPlayerCounts(cdata);
						if (index == _selectedChannelIndex) then
							ChatmanagerFrame_UpdatePlayerList();
						end
						cdata.userRequest = nil;
					end
				elseif (cdata.request) then
					if (time > cdata.request) then
						cdata.request = nil;
						Chatmanager_RequestPlayerList(index, cdata.nextUserRequest);
						cdata.nextUserRequest = nil;
					end
				end
				if (cdata.pending) then
					if (not nextUpdate or (nextUpdate > cdata.pending)) then
						nextUpdate = cdata.pending;
					end
				elseif (cdata.request) then
					if (not nextUpdate or (nextUpdate > cdata.request)) then
						nextUpdate = cdata.request;
					end
				end
			end
			_playerListUpdateTimeout = nextUpdate;
		end
	end
	if (_channelConnects) then
		for name, sdata in _channelConnects do
			if (sdata.password and (sdata.password ~= "")) then
				sdata.newPassword = sdata.password;
				sdata.password = nil;
				if (_debugFrame) then
					_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Attempting to reconnect to "..sdata.name.." with password "..sdata.newPassword);
				end
				_original_JoinChannelByName(sdata.name, sdata.newPassword);
			end
		end
		_channelConnects = nil;
	end
	if (not _playerListUpdateTimeout) then
		_thisFrame:SetScript("OnUpdate", nil);
	end
end


function ChatmanagerFrame_ChannelButton_OnClick()
	-- Called when the user left or right clicks on a channel in the channel
	-- list.
	-- Close any open menus and close the color picker if it is open too.
	CloseDropDownMenus();
	if (ColorPickerFrame:IsVisible()) then
		if (ColorPickerFrame.cancelFunc) then
			ColorPickerFrame.cancelFunc(ColorPickerFrame.previousValues);
		end
		ColorPickerFrame:Hide();
	end
	-- Set frame to show this channel (or refresh channel if it is already on
	-- this one).
	ChatmanagerFrame_UpdateChannelList(this:GetID());
	ChatmanagerFrame_UpdatePlayerList();
	if (arg1 == "RightButton") then
		if (_selectedChannelIndex) then
			local cdata = _channelList[_selectedChannelIndex];
			if (cdata and cdata.name) then
				ChatmanagerDropDown.thisMode = "channel";
				if (cdata.suspended) then
					ChatmanagerDropDown.thisName = format(CHATMANAGER_TEXT.FRAME_CHANNEL_NAME_SUSPENDED_FORMAT, cdata.name);
				else
					ChatmanagerDropDown.thisName = cdata.name;
				end
				ChatmanagerDropDown.thisButton = this;
				ChatmanagerDropDown.initialize = ChatmanagerFrame_DropdownTargetInitialize;
				ChatmanagerDropDown.displayMode = "MENU";
				ChatmanagerDropDown.point = "TOPLEFT";
				ChatmanagerDropDown.relativePoint = "BOTTOMLEFT";
				ToggleDropDownMenu(1, nil, ChatmanagerDropDown, "cursor");
			end
		else
			ChatmanagerDropDown.thisMode = "newchannel";
			ChatmanagerDropDown.thisName = nil;
			ChatmanagerDropDown.thisButton = this;
			ChatmanagerDropDown.initialize = ChatmanagerFrame_DropdownTargetInitialize;
			ChatmanagerDropDown.displayMode = "MENU";
			ChatmanagerDropDown.point = "TOPLEFT";
			ChatmanagerDropDown.relativePoint = "BOTTOMLEFT";
			ToggleDropDownMenu(1, nil, ChatmanagerDropDown, "cursor");
		end
	end
end


function ChatmanagerFrame_PlayerButton_OnClick()
	-- Called when the user left or right clicks on a player in the player
	-- list.
	-- Close any open menus and close the color picker if it is open too.
	CloseDropDownMenus();
	if (ColorPickerFrame:IsVisible()) then
		if (ColorPickerFrame.cancelFunc) then
			ColorPickerFrame.cancelFunc(ColorPickerFrame.previousValues);
		end
		ColorPickerFrame:Hide();
	end
	if (arg1 == "LeftButton") then
		if (this.pname) then
			local originalTargetName = UnitName("target");
			TargetByName(this.pname, 1);
			if (UnitName("target") ~= this.pname) then
				if (originalTargetName) then
					if (UnitName("target") ~= originalTargetName) then
						TargetLastTarget();
						if (UnitName("target") ~= originalTargetName) then
							TargetByName(originalTargetName, 1);
						end
					end
				else
					ClearTarget();
				end
			end
		end
	elseif (arg1 == "RightButton") then
		ChatmanagerDropDown.thisMode = "player";
		ChatmanagerDropDown.thisName = this.pname;
		ChatmanagerDropDown.thisButton = this;
		ChatmanagerDropDown.initialize = ChatmanagerFrame_DropdownTargetInitialize;
		ChatmanagerDropDown.displayMode = "MENU";
		ChatmanagerDropDown.point = "TOPLEFT";
		ChatmanagerDropDown.relativePoint = "BOTTOMLEFT";
		ToggleDropDownMenu(1, nil, ChatmanagerDropDown, "cursor");
	end
end


function ChatmanagerFrame_DropdownTargetInitialize()
	local info;
	if (ChatmanagerDropDown.thisName and (UIDROPDOWNMENU_MENU_LEVEL == 1)) then
		info = {};
		info.text = ChatmanagerDropDown.thisName;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
	if (ChatmanagerDropDown.thisMode == "channel") then
		if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
			-- Move channel to
			info = {};
			info.text = CHATMANAGER_TEXT.MOVE_TO_OPTION;
			info.notCheckable = 1;
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info);
			-- Text color
			info = {};
			info.text = CHATMANAGER_TEXT.TEXT_COLOR_OPTION;
			info.value = CHATMANAGER_TEXT.TEXT_COLOR_OPTION;
			if (_selectedChannelIndex) then
				info.textR = ChatTypeInfo["CHANNEL".._selectedChannelIndex].r;
				info.textG = ChatTypeInfo["CHANNEL".._selectedChannelIndex].g;
				info.textB = ChatTypeInfo["CHANNEL".._selectedChannelIndex].b;
			else
				info.disabled = 1;
			end
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownSelect;
			UIDropDownMenu_AddButton(info);
			-- Leave channel
			info = {};
			info.text = CHATMANAGER_TEXT.LEAVE_OPTION;
			info.value = CHATMANAGER_TEXT.LEAVE_OPTION;
			if (_selectedChannelIndex) then
				-- Note that it doesn't appear to be possible to leave suspended
				-- channels, so treat them like bad data.
				local cdata = _channelList[_selectedChannelIndex];
				if (not cdata or not cdata.name or cdata.suspended) then
					info.disabled = 1;
				end
			end
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownSelect;
			UIDropDownMenu_AddButton(info);
			-- Cancel menu
			info = {};
			info.text = CANCEL;
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownCancel;
			UIDropDownMenu_AddButton(info);
		elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then
			for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
				info = {};
				info.text = string.format(CHATMANAGER_TEXT.MOVE_TO_CHANNEL_FORMAT, i);
				info.value = i;
				if (not ChatmanagerDropDown.thisButton or (ChatmanagerDropDown.thisButton:GetID() == i)) then
					info.disabled = 1;
				end
				info.notCheckable = 1;
				info.func = ChatmanagerFrame_DropdownSelect;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	elseif (ChatmanagerDropDown.thisMode == "newchannel") then
		-- New channel
		info = {};
		info.text = CHATMANAGER_TEXT.NEW_CHANNEL_OPTION;
		info.value = "";
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownSelect;
		UIDropDownMenu_AddButton(info);
		-- Previous channels
		for sname, sdata in _channelSavedList do
			if (sdata and not _channelIndexLookupByName[sname]) then
				info = {};
				info.text = string.format(CHATMANAGER_TEXT.REJOIN_CHANNEL_OPTION, sdata.name);
				info.value = sname;
				info.notCheckable = 1;
				info.func = ChatmanagerFrame_DropdownSelect;
				UIDropDownMenu_AddButton(info);
			end
		end
		-- Cancel menu
		info = {};
		info.text = CANCEL;
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownCancel;
		UIDropDownMenu_AddButton(info);
	elseif (ChatmanagerDropDown.thisMode == "player") then
		-- Who
		info = {};
		info.text = WHO;
		info.value = WHO;
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownSelect;
		UIDropDownMenu_AddButton(info);
		-- Whisper
		info = {};
		info.text = WHISPER;
		info.value = WHISPER;
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownSelect;
		UIDropDownMenu_AddButton(info);
		-- Invite
		info = {};
		info.text = PARTY_INVITE;
		info.value = PARTY_INVITE;
		if (ChatmanagerDropDown.thisName == _playerName) then
			info.disabled = 1;
		elseif (GetNumRaidMembers() > 0) then
			if (IsRaidLeader() or IsRaidOfficer()) then
				for i = 1, 40 do
					local unit = "raid"..i;
					if (UnitInRaid(unit) and (UnitName(unit) == ChatmanagerDropDown.thisName)) then
						info.disabled = 1;
						break;
					end
				end
			else
				info.disabled = 1;
			end
		elseif (GetNumPartyMembers() > 0) then
			if (IsPartyLeader()) then
				for i = 1, 4 do
					local unit = "party"..i;
					if (UnitInParty(unit) and (UnitName(unit) == ChatmanagerDropDown.thisName)) then
						info.disabled = 1;
						break;
					end
				end
			else
				info.disabled = 1;
			end
		end
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownSelect;
		UIDropDownMenu_AddButton(info);
		-- Player Note
		info = {};
		info.text = CHATMANAGER_TEXT.EDIT_PLAYER_NOTE;
		info.value = CHATMANAGER_TEXT.EDIT_PLAYER_NOTE;
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownSelect;
		UIDropDownMenu_AddButton(info);
		-- Variables for the options to follow
		local cdata = nil;
		local pdata = nil;
		local moderator = nil;
		local notServer = nil;
		if (_selectedChannelIndex) then
			cdata = _channelList[_selectedChannelIndex];
			if (cdata and cdata.name) then
				moderator = cdata.amOwner or cdata.amModerator;
				if (cdata.type == 0) then
					notServer = true;
				end
				pdata = cdata.playerList[ChatmanagerDropDown.thisName];
			end
		end
		if (notServer) then
			-- Mute/Unmute
			info = {};
			if (pdata and pdata.isMuted) then
				info.text = CHATMANAGER_TEXT.UNMUTE_PLAYER_OPTION;
				info.value = CHATMANAGER_TEXT.UNMUTE_PLAYER_OPTION;
			else
				info.text = CHATMANAGER_TEXT.MUTE_PLAYER_OPTION;
				info.value = CHATMANAGER_TEXT.MUTE_PLAYER_OPTION;
			end
			if (not moderator or not pdata or pdata.isOwner or pdata.isModerator) then
				info.disabled = 1;
			end
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownSelect;
			UIDropDownMenu_AddButton(info);
			-- Kick
			info = {};
			info.text = CHATMANAGER_TEXT.KICK_PLAYER_OPTION;
			info.value = CHATMANAGER_TEXT.KICK_PLAYER_OPTION;
			if (not moderator or not pdata or pdata.isOwner or pdata.isModerator) then
				info.disabled = 1;
			end
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownSelect;
			UIDropDownMenu_AddButton(info);
			-- Ban
			info = {};
			info.text = CHATMANAGER_TEXT.BAN_PLAYER_OPTION;
			info.value = CHATMANAGER_TEXT.BAN_PLAYER_OPTION;
			if (not moderator or not pdata or pdata.isOwner or pdata.isModerator) then
				info.disabled = 1;
			end
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownSelect;
			UIDropDownMenu_AddButton(info);
			-- Set/unset moderator
			info = {};
			if (pdata and pdata.isModerator) then
				info.text = CHATMANAGER_TEXT.UNSET_MODERATOR_OPTION;
				info.value = CHATMANAGER_TEXT.UNSET_MODERATOR_OPTION;
			else
				info.text = CHATMANAGER_TEXT.SET_MODERATOR_OPTION;
				info.value = CHATMANAGER_TEXT.SET_MODERATOR_OPTION;
			end
			if (not moderator or not pdata or pdata.isOwner) then
				info.disabled = 1;
			end
			info.notCheckable = 1;
			info.func = ChatmanagerFrame_DropdownSelect;
			UIDropDownMenu_AddButton(info);
			-- Set owner (only if actually owner does this show up)
			if (cdata and cdata.amOwner) then
				info = {};
				info.text = CHATMANAGER_TEXT.SET_OWNER_OPTION;
				info.value = CHATMANAGER_TEXT.SET_OWNER_OPTION;
				if (ChatmanagerDropDown.thisName == _playerName) then
					info.disabled = 1;
				end
				info.notCheckable = 1;
				info.func = ChatmanagerFrame_DropdownSelect;
				UIDropDownMenu_AddButton(info);
			end
		end
		-- Cancel menu
		info = {};
		info.text = CANCEL;
		info.notCheckable = 1;
		info.func = ChatmanagerFrame_DropdownCancel;
		UIDropDownMenu_AddButton(info);
	end
end


function ChatmanagerFrame_DropdownSelect()
	CloseDropDownMenus();
	if (ChatmanagerDropDown.thisMode == "channel") then
		if (this.value == CHATMANAGER_TEXT.TEXT_COLOR_OPTION) then
			ChatmanagerColorSwatch_OnClick(_selectedChannelIndex);
		elseif (this.value == CHATMANAGER_TEXT.LEAVE_OPTION) then
			if (_selectedChannelIndex) then
				local cdata = _channelList[_selectedChannelIndex];
				if (cdata and cdata.name) then
					local dialogFrame = StaticPopup_Show("CHATMANAGER_LEAVE_CONFIRM", cdata.name);
					if (dialogFrame) then
						dialogFrame.data = tostring(_selectedChannelIndex);
					end
				end
			end
		else
			local displayIndex = tonumber(this.value or 0);
			if (displayIndex and (displayIndex >= CHATMANAGER_FIRST_CHANNEL) and (displayIndex <= CHATMANAGER_LAST_CHANNEL)) then
				Chatmanager_MoveChannelTo(_selectedChannelIndex, displayIndex);
			end
			ChatmanagerFrame_UpdateChannelList(displayIndex);
		end
	elseif (ChatmanagerDropDown.thisMode == "newchannel") then
		if (this.value == "") then
			StaticPopup_Show("CHATMANAGER_NEW_CHANNEL");
		elseif (this.value) then
			local sdata = _channelSavedList[this.value];
			if (sdata) then
				sdata.index = _selectedChannelDisplayIndex;
				sdata.newPassword = sdata.password;
				sdata.password = nil;
				if (not sdata.tabs) then
					sdata.tabs = {1};
				end
				_original_JoinChannelByName(sdata.name, sdata.newPassword);
			end
		end
	elseif (ChatmanagerDropDown.thisMode == "player") then
		local cdata = nil;
		local moderator = nil;
		if (_selectedChannelIndex) then
			cdata = _channelList[_selectedChannelIndex];
			if (cdata) then
				moderator = cdata.amOwner or cdata.amModerator;
			end
		end
		if (this.value == WHO) then
			if (ChatmanagerDropDown.thisName) then
				SendWho("n-"..ChatmanagerDropDown.thisName);
			end
		elseif (this.value == WHISPER) then
			if (ChatmanagerDropDown.thisName) then
				ChatFrame_SendTell(ChatmanagerDropDown.thisName);
			end
		elseif (this.value == PARTY_INVITE) then
			if (ChatmanagerDropDown.thisName) then
				InviteByName(ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.EDIT_PLAYER_NOTE) then
			if (ChatmanagerDropDown.thisName) then
				local dialogFrame = StaticPopup_Show("CHATMANAGER_PLAYER_NOTE", ChatmanagerDropDown.thisName);
				if (dialogFrame) then
					dialogFrame.data = ChatmanagerDropDown.thisName;
				end
			end
		elseif (this.value == CHATMANAGER_TEXT.MUTE_PLAYER_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				ChannelMute(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.UNMUTE_PLAYER_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				ChannelUnmute(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.KICK_PLAYER_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				ChannelKick(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.BAN_PLAYER_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				ChannelBan(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.SET_MODERATOR_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				ChannelModerator(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.UNSET_MODERATOR_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				ChannelUnmoderator(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		elseif (this.value == CHATMANAGER_TEXT.SET_OWNER_OPTION) then
			if (cdata and moderator and ChatmanagerDropDown.thisName) then
				SetChannelOwner(tostring(_selectedChannelIndex), ChatmanagerDropDown.thisName);
			end
		end
	end
end


function ChatmanagerFrame_DropdownCancel()
	CloseDropDownMenus();
end


function ChatmanagerFrame_SetPassword(password)
	-- Updates the password for the current channel.  If the player is not the
	-- owner or moderator, then the password is simply recorded.
	if (not password) then
		password = "";
	end
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."ChatmanagerFrame_SetPassword(\""..password.."\")");
	end
	if (_selectedChannelIndex) then
		local cdata = _channelList[_selectedChannelIndex];
		if (cdata and cdata.name and (cdata.type == 0)) then
			cdata.password = password;
			if (cdata.amOwner or cdata.amModerator) then
				SetChannelPassword(tostring(_selectedChannelIndex), password);
			end
		end
	end
end


function ChatmanagerFrame_ToggleModerateChannel()
	-- Toggles moderation on the current channel.
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."ChatmanagerFrame_ToggleModerateChannel()");
	end
	if (_selectedChannelIndex) then
		local cdata = _channelList[_selectedChannelIndex];
		if (cdata and cdata.name and (cdata.type == 0)) then
			if (cdata.amOwner or cdata.amModerator) then
				ChannelModerate(tostring(_selectedChannelIndex));
			end
		end
	end
end


function ChatmanagerOptionsFrame_OnLoad()
	-- Make our frame closable with the ESC key
	tinsert(UISpecialFrames, "ChatmanagerOptionsFrame");

	-- Set text for titles,  buttons, tooltips, etc.
	ChatmanagerOptionsFrameTitleText:SetText(CHATMANAGER_TEXT.OPTIONS_FRAME_TITLE);
	ChatmanagerOptionsFrameReplyToSentText:SetText(CHATMANAGER_TEXT.REPLY_TO_SENT_TITLE);
	ChatmanagerOptionsFrameReplyToSentCheckButton.tooltipOnText = CHATMANAGER_TEXT.REPLY_TO_SENT_ON_TOOLTIP;
	ChatmanagerOptionsFrameReplyToSentCheckButton.tooltipOffText = CHATMANAGER_TEXT.REPLY_TO_SENT_OFF_TOOLTIP;
	ChatmanagerOptionsFrameChatLinkingText:SetText(CHATMANAGER_TEXT.CHAT_LINK_TITLE);
	ChatmanagerOptionsFrameChatLinkingCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_LINK_ON_TOOLTIP;
	ChatmanagerOptionsFrameChatLinkingCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_LINK_OFF_TOOLTIP;
	ChatmanagerOptionsFrameChatLinkFormatText:SetText(CHATMANAGER_TEXT.CHAT_LINK_FORMAT_TITLE);
	ChatmanagerOptionsFrameChatLinkFormatCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_LINK_FORMAT_ON_TOOLTIP;
	ChatmanagerOptionsFrameChatLinkFormatCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_LINK_FORMAT_OFF_TOOLTIP;
	ChatmanagerOptionsFrameSmartStickyText:SetText(CHATMANAGER_TEXT.SMART_STICKY_TITLE);
	ChatmanagerOptionsFrameSmartStickyCheckButton.tooltipOnText = CHATMANAGER_TEXT.SMART_STICKY_ON_TOOLTIP;
	ChatmanagerOptionsFrameSmartStickyCheckButton.tooltipOffText = CHATMANAGER_TEXT.SMART_STICKY_OFF_TOOLTIP;
	ChatmanagerOptionsFrameChatLogText:SetText(CHATMANAGER_TEXT.CHAT_LOG_TITLE);
	ChatmanagerOptionsFrameChatLogCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_LOG_ON_TOOLTIP;
	ChatmanagerOptionsFrameChatLogCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_LOG_OFF_TOOLTIP;
	ChatmanagerOptionsFrameShowButtonText:SetText(CHATMANAGER_TEXT.CHAT_BUTTON_TITLE);
	ChatmanagerOptionsFrameShowButtonCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_BUTTON_ON_TOOLTIP;
	ChatmanagerOptionsFrameShowButtonCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_BUTTON_OFF_TOOLTIP;
	ChatmanagerOptionsFrameStickySayText:SetText(CHATMANAGER_TEXT.CHAT_STICKY_SAY_TITLE);
	ChatmanagerOptionsFrameStickySayCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_STICKY_SAY_ON_TOOLTIP;
	ChatmanagerOptionsFrameStickySayCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_STICKY_SAY_OFF_TOOLTIP;
	ChatmanagerOptionsFrameStickyPartyText:SetText(CHATMANAGER_TEXT.CHAT_STICKY_PARTY_TITLE);
	ChatmanagerOptionsFrameStickyPartyCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_STICKY_PARTY_ON_TOOLTIP;
	ChatmanagerOptionsFrameStickyPartyCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_STICKY_PARTY_OFF_TOOLTIP;
	ChatmanagerOptionsFrameStickyRaidText:SetText(CHATMANAGER_TEXT.CHAT_STICKY_RAID_TITLE);
	ChatmanagerOptionsFrameStickyRaidCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_STICKY_RAID_ON_TOOLTIP;
	ChatmanagerOptionsFrameStickyRaidCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_STICKY_RAID_OFF_TOOLTIP;
	ChatmanagerOptionsFrameStickyGuildText:SetText(CHATMANAGER_TEXT.CHAT_STICKY_GUILD_TITLE);
	ChatmanagerOptionsFrameStickyGuildCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_STICKY_GUILD_ON_TOOLTIP;
	ChatmanagerOptionsFrameStickyGuildCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_STICKY_GUILD_OFF_TOOLTIP;
	ChatmanagerOptionsFrameStickyOfficerText:SetText(CHATMANAGER_TEXT.CHAT_STICKY_OFFICER_TITLE);
	ChatmanagerOptionsFrameStickyOfficerCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_STICKY_OFFICER_ON_TOOLTIP;
	ChatmanagerOptionsFrameStickyOfficerCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_STICKY_OFFICER_OFF_TOOLTIP;
	ChatmanagerOptionsFrameStickyWhisperText:SetText(CHATMANAGER_TEXT.CHAT_STICKY_WHISPER_TITLE);
	ChatmanagerOptionsFrameStickyWhisperCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_STICKY_WHISPER_ON_TOOLTIP;
	ChatmanagerOptionsFrameStickyWhisperCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_STICKY_WHISPER_OFF_TOOLTIP;
	ChatmanagerOptionsFrameScrollChatText:SetText(CHATMANAGER_TEXT.CHAT_SCROLL_TITLE);
	ChatmanagerOptionsFrameScrollChatCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_SCROLL_ON_TOOLTIP;
	ChatmanagerOptionsFrameScrollChatCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_SCROLL_OFF_TOOLTIP;
	ChatmanagerOptionsFrameHideChatButtonsText:SetText(CHATMANAGER_TEXT.CHAT_HIDE_BUTTONS_TITLE);
	ChatmanagerOptionsFrameHideChatButtonsCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_HIDE_BUTTONS_ON_TOOLTIP;
	ChatmanagerOptionsFrameHideChatButtonsCheckButton.tooltipOffText = CHATMANAGER_TEXT.CHAT_HIDE_BUTTONS_OFF_TOOLTIP;
end


function ChatmanagerOptionsFrame_OnShow()
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ReplyLastTell == 1) then
		ChatmanagerOptionsFrameReplyToSentCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameReplyToSentCheckButton:SetChecked(0);
	end
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLink == 1) then
		ChatmanagerOptionsFrameChatLinkingCheckButton:SetChecked(1);
		ChatmanagerOptionsFrameChatLinkFormatCheckButton:Enable();
		ChatmanagerOptionsFrameChatLinkFormatText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLinkFormat == 1) then
			ChatmanagerOptionsFrameChatLinkFormatCheckButton:SetChecked(1);
			ChatmanagerOptionsFrameChatLinkingCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_LINK_COMPAT_ON_TOOLTIP;
		else
			ChatmanagerOptionsFrameChatLinkFormatCheckButton:SetChecked(0);
			ChatmanagerOptionsFrameChatLinkingCheckButton.tooltipOnText = CHATMANAGER_TEXT.CHAT_LINK_ON_TOOLTIP;
		end
	else
		ChatmanagerOptionsFrameChatLinkingCheckButton:SetChecked(0);
		if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLinkFormat == 1) then
			ChatmanagerOptionsFrameChatLinkFormatCheckButton:SetChecked(1);
		else
			ChatmanagerOptionsFrameChatLinkFormatCheckButton:SetChecked(0);
		end
		ChatmanagerOptionsFrameChatLinkFormatCheckButton:Disable();
		ChatmanagerOptionsFrameChatLinkFormatText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
	end
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.SmartSticky == 1) then
		ChatmanagerOptionsFrameSmartStickyCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameSmartStickyCheckButton:SetChecked(0);
	end
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog == 1) then
		ChatmanagerOptionsFrameChatLogCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameChatLogCheckButton:SetChecked(0);
	end
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton == 1) then
		ChatmanagerOptionsFrameShowButtonCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameShowButtonCheckButton:SetChecked(0);
	end
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.EnableChatScroll == 1) then
		ChatmanagerOptionsFrameScrollChatCheckButton:SetChecked(1);
		ChatmanagerOptionsFrameHideChatButtonsCheckButton:Enable();
		ChatmanagerOptionsFrameHideChatButtonsText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
	else
		ChatmanagerOptionsFrameScrollChatCheckButton:SetChecked(0);
		ChatmanagerOptionsFrameHideChatButtonsCheckButton:Disable();
		ChatmanagerOptionsFrameHideChatButtonsText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
	end
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.HideChatButtons == 1) then
		ChatmanagerOptionsFrameHideChatButtonsCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameHideChatButtonsCheckButton:SetChecked(0);
	end

	local color = ChatTypeInfo["SAY"];
	ChatmanagerOptionsFrameStickySayText:SetTextColor(color.r, color.g, color.b);
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky.SAY == 1) then
		ChatmanagerOptionsFrameStickySayCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameStickySayCheckButton:SetChecked(0);
	end
	color = ChatTypeInfo["PARTY"];
	ChatmanagerOptionsFrameStickyPartyText:SetTextColor(color.r, color.g, color.b);
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky.PARTY == 1) then
		ChatmanagerOptionsFrameStickyPartyCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameStickyPartyCheckButton:SetChecked(0);
	end
	color = ChatTypeInfo["RAID"];
	ChatmanagerOptionsFrameStickyRaidText:SetTextColor(color.r, color.g, color.b);
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky.RAID == 1) then
		ChatmanagerOptionsFrameStickyRaidCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameStickyRaidCheckButton:SetChecked(0);
	end
	color = ChatTypeInfo["GUILD"];
	ChatmanagerOptionsFrameStickyGuildText:SetTextColor(color.r, color.g, color.b);
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky.GUILD == 1) then
		ChatmanagerOptionsFrameStickyGuildCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameStickyGuildCheckButton:SetChecked(0);
	end
	color = ChatTypeInfo["OFFICER"];
	ChatmanagerOptionsFrameStickyOfficerText:SetTextColor(color.r, color.g, color.b);
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky.OFFICER == 1) then
		ChatmanagerOptionsFrameStickyOfficerCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameStickyOfficerCheckButton:SetChecked(0);
	end
	color = ChatTypeInfo["WHISPER"];
	ChatmanagerOptionsFrameStickyWhisperText:SetTextColor(color.r, color.g, color.b);
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky.WHISPER == 1) then
		ChatmanagerOptionsFrameStickyWhisperCheckButton:SetChecked(1);
	else
		ChatmanagerOptionsFrameStickyWhisperCheckButton:SetChecked(0);
	end
end


function ChatmanagerOptionsFrame_ReplyToSentOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ReplyLastTell = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ReplyLastTell = 0;
	end
end


function ChatmanagerOptionsFrame_ChatLinkOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLink = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLink = 0;
	end
	ChatmanagerOptionsFrame_OnShow();
end


function ChatmanagerOptionsFrame_ChatLinkFormatOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLinkFormat = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLinkFormat = 0;
	end
	ChatmanagerOptionsFrame_OnShow();
end


function ChatmanagerOptionsFrame_SmartStickyOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.SmartSticky = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.SmartSticky = 0;
	end
end


function ChatmanagerOptionsFrame_ChatLogOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLog = 0;
	end
end


function ChatmanagerOptionsFrame_ShowButtonOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton = 1;
		ChatmanagerMenuButtonFrame:Show();
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ShowButton = 0;
		ChatmanagerMenuButtonFrame:Hide();
	end
end


function ChatmanagerOptionsFrame_ScrollChatOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.EnableChatScroll = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.EnableChatScroll = 0;
	end
	Chatmanager_UpdateScrollingAndButtons();
	ChatmanagerOptionsFrame_OnShow();
end


function ChatmanagerOptionsFrame_HideChatButtonsOnClick()
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.HideChatButtons = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.HideChatButtons = 0;
	end
	Chatmanager_UpdateScrollingAndButtons();
end


function ChatmanagerOptionsFrame_StickyTypeButtonOnClick(type)
	if (not type) then
		return;
	end
	if (this:GetChecked()) then
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky[type] = 1;
		ChatTypeInfo[type].sticky = 1;
	else
		ChatmanagerState.Servers[_serverName].Characters[_playerName].Sticky[type] = 0;
		ChatTypeInfo[type].sticky = 0;
	end
end


function ChatmanagerMenuButtonFrame_OnLoad()
	-- Set the tooltip text for the menu button
	ChatmanagerMenuButtonFrameMenuButton.tooltipText = CHATMANAGER_TEXT.FRAME_TITLE;
	ChatmanagerMenuButtonFrameMenuButton.tooltipText2 = CHATMANAGER_TEXT.MENU_BUTTON_DRAG_TOOLTIP;
end


function ChatmanagerColorSwatch_OnClick(index)
	-- Called for a specific client channel index, this function prepares and
	-- opens the color picker frame.  It can be called from a non-button
	-- context.
	if (index) then
		if (ColorPickerFrame:IsVisible()) then
			if (ColorPickerFrame.cancelFunc) then
				ColorPickerFrame.cancelFunc(ColorPickerFrame.previousValues);
			end
			ColorPickerFrame:Hide();
		end
		local button = {};
		button.value = "CHANNEL"..index;
		button.r = ChatTypeInfo["CHANNEL"..index].r;
		button.g = ChatTypeInfo["CHANNEL"..index].g;
		button.b = ChatTypeInfo["CHANNEL"..index].b;
		button.swatchFunc = ChatmanagerFrame_SetChatColor;
		button.cancelFunc = ChatmanagerFrame_SetChatColor;
		UIDropDownMenuButton_OpenColorPicker(button);
	end
end


------------------------------------------------------------------------------
-- Popup support functions
------------------------------------------------------------------------------
function Chatmanager_GetPopupData(type)
	if (type == "PLAYERNOTE") then
		local note;
		if (ChatmanagerDropDown.thisName) then
			note = ChatmanagerState.Servers[_serverName].Notes[ChatmanagerDropDown.thisName];
		end
		return note or "";
	end
end


function Chatmanager_HandlePopupAccept(type, data, text)
	if (type == "LEAVE") then
		-- data is the channel name (index as a string) to leave
		if (data and (data ~= "")) then
			LeaveChannelByName(data);
		end
	elseif (type == "JOIN") then
		-- text is the contents of the edit box (name [password])
		local name = string.gsub(text, "%s*([^%s]+).*", "%1");
		local password = string.gsub(text, "%s*([^%s]+)%s*([^%s]*)", "%2");
		if (name and (string.len(name) > 0)) then
			local zoneID, channelName = Chatmanager_JoinChannelByName(name, password);
			if (zoneID) then
				if (channelName) then
					name = channelName;
				end
				local sdata = _channelSavedList[string.lower(name)];
				if (sdata) then
					sdata.index = _selectedChannelDisplayIndex;
					if (not sdata.tabs) then
						sdata.tabs = {1};
					end
				end
			end
		end
	elseif (type == "PLAYERNOTE") then
		-- data is the player name, text is the new player note
		if (data) then
			if ((text == "") or (string.gsub(text, "%s", "") == "")) then
				text = nil;
			end
			local oldText = ChatmanagerState.Servers[_serverName].Notes[data];
			ChatmanagerState.Servers[_serverName].Notes[data] = text;
			if ((oldText ~= text) and DEFAULT_CHAT_FRAME) then
				if (text) then
					DEFAULT_CHAT_FRAME:AddMessage(string.format(CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE_CONFIRM_FORMAT, data, text));
				else
					DEFAULT_CHAT_FRAME:AddMessage(string.format(CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE_REMOVE_FORMAT, data));
				end
			end
			ChatmanagerFrame_UpdatePlayerList();
		end
	end
end


------------------------------------------------------------------------------
-- Local parsing functions
------------------------------------------------------------------------------
local function Chatmanager_ProcessPlayerList(list, index)
	-- Processes messages resulting from a call to ListChannelByName.  Note
	-- that a single channel listing may be broken into multiple messages.  If
	-- the listing is for a user request, then the function returns true,
	-- otherwise it returns nil.
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ProcessPlayerList("..list..", "..index..")");
	end
	local cdata = _channelList[index];
	if (cdata and cdata.name) then
		local pdata;
		if (not cdata.playerList) then
			cdata.playerList = {};
		end
		for qualifier, name in string.gfind(list, CHATMANAGER_TEXT.LIST_PLAYER_NAMES_PARSE_STRING) do
			pdata = cdata.playerList[name];
			if (not pdata) then
				pdata = {};
				cdata.playerList[name] = pdata;
			else
				pdata.pending = nil;
			end
			if (qualifier == CHATMANAGER_TEXT.LIST_PLAYER_OWNER) then
				pdata.isOwner = true;
				pdata.isModerator = nil;
				pdata.isMuted = nil;
			elseif (qualifier == CHATMANAGER_TEXT.LIST_PLAYER_MODERATOR) then
				pdata.isOwner = nil;
				pdata.isModerator = true;
				pdata.isMuted = nil;
			elseif (qualifier == CHATMANAGER_TEXT.LIST_PLAYER_MUTED) then
				pdata.isOwner = nil;
				pdata.isModerator = nil;
				pdata.isMuted = true;
				cdata.isModerated = true;
			else
				pdata.isOwner = nil;
				pdata.isModerator = nil;
				pdata.isMuted = nil;
			end
		end
		pdata = cdata.playerList[_playerName];
		if (pdata) then
			if (pdata.isOwner) then
				cdata.amOwner = true;
				cdata.amModerator = nil;
			elseif (pdata.isModerator) then
				cdata.amOwner = nil;
				cdata.amModerator = true;
			else
				cdata.amOwner = nil;
				cdata.amModerator = nil;
			end
		else
			cdata.amOwner = nil;
			cdata.amModerator = nil;
		end
		Chatmanager_RebuildPlayerFilteredList(cdata);
		ChatmanagerFrame_UpdateChannelPlayerCounts(cdata);
		if (index == _selectedChannelIndex) then
			if (cdata.amOwner or cdata.amModerator) then
				ChatmanagerChannelSettingsFrameModerateButton:Enable();
			else
				ChatmanagerChannelSettingsFrameModerateButton:Disable();
			end
			ChatmanagerFrame_UpdatePlayerList();
		end
		cdata.pending = GetTime() + CHATMANAGER_PLAYER_UPDATE_DELAY;
		if (_playerListUpdateTimeout and (_playerListUpdateTimeout > cdata.pending)) then
			_playerListUpdateTimeout = cdata.pending;
		end
		return cdata.userRequest;
	end
end


local function Chatmanager_ConvertChannelHeader(header, index, channel)
	-- Returns the rebuilt channel header where the header contains the index
	-- that the player thinks this channel is on, rather than the one it is
	-- according to the client.  If the index is the same in both cases, the
	-- original header (passed in) is returned.  Note that for failure
	-- situations where the index is not found, we follow the same logic that
	-- adding a new channel would have followed to try and get a reasonable
	-- channel number.
	local newIndex = _channelList[index].displayIndex;
	if (not newIndex) then
		local lname = string.lower(string.gsub(channel, "%s%-%s.*", ""));
		local sdata = _channelSavedList[lname];
		if (sdata and sdata.index and not _channelIndexLookupByDisplayIndex[sdata.index]) then
			newIndex = sdata.index;
		end
		if (not newIndex) then
			for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
				if (not _channelIndexLookupByDisplayIndex[i]) then
					newIndex = i;
					break;
				end
			end
		end
	end
	if (newIndex and (newIndex ~= index)) then
		return string.format(CHATMANAGER_TEXT.CHANNEL_HEADER, newIndex, arg9);
	end
	return header;
end


local function Chatmanager_RebuildList(text)
	-- Called to rebuild the output string of a ListChannels command
	local list = {};
	for index, name in string.gfind(text, CHATMANAGER_TEXT.LIST_CHANNELS_PARSE_STRING) do
		local newIndex = _channelList[tonumber(index)].displayIndex;
		table.insert(list, newIndex or index);
	end
	table.sort(list);
	text = "";
	for _, displayIndex in list do
		local index = _channelIndexLookupByDisplayIndex[displayIndex or ""];
		local cdata = _channelList[index or ""];
		if (cdata and cdata.name) then
			text = text..string.format(CHATMANAGER_TEXT.LIST_CHANNELS_FORMAT_STRING, displayIndex, cdata.fullName);
		end
	end
	return text;
end


local function Chatmanager_ProcessPlayerAction(name, index, action)
	-- Called when a player joins or leaves a channel, this only occurs if
	-- announcement is on for the channel (which is outside of our control).
	-- At any rate, this function simply adds or removes the indicated player
	-- from the list for the channel, where the list will be refreshed when
	-- the UI is shown or the selected channel changed anyway.  Since the
	-- join message doesn't tell us about the player, we also request an
	-- update of the player list for the channel.
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ProcessPlayerAction("..name..", "..index..", "..action..")");
	end
	local cdata = _channelList[index];
	if (not cdata) then
		return;
	end
	if (action == "JOIN") then
		local playerList = cdata.playerList;
		if (not playerList) then
			playerList = {};
			cdata.playerList = playerList;
		end
		if (not playerList[name]) then
			playerList[name] = {};
		end
		if (cdata.isModerated) then
			playerList[name].isMuted = true;
		end
		Chatmanager_RebuildPlayerFilteredList(cdata);
		ChatmanagerFrame_UpdateChannelPlayerCounts(cdata);
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdatePlayerList();
		end
		Chatmanager_RequestPlayerList(index);
	elseif (action == "LEAVE") then
		local playerList = cdata.playerList;
		if (playerList) then
			playerList[name] = nil;
			Chatmanager_RebuildPlayerFilteredList(cdata);
			ChatmanagerFrame_UpdateChannelPlayerCounts(cdata);
			if (index == _selectedChannelIndex) then
				ChatmanagerFrame_UpdatePlayerList();
			end
		end
	end
end


local function Chatmanager_ProcessNotice(channel, index, zone, action)
	-- Called for join, leave, suspended, and changed notices on individual
	-- channels, and also for wrong passwords.  Suspended appears to be a
	-- special case for trade channels and amounts to the equivalent of
	-- "left", and is followed by a "joined" when you re-enter a trade zone.
	-- Also called for wrong-password notification.  This function returns
	-- -1 if an entry was removed, 1 if one was added, 0 if there was no
	-- change, and nil if the output should be suppressed.  Note that for
	-- other notice events (such as NOT_MODERATOR, NOT_MODERATED, MUTED,
	-- etc.) we simply return 0 so that the caller can pass the notification
	-- on.
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ProcessNotice("..channel..", "..index..", "..zone..", "..action..")");
	end
	if (action == "YOU_LEFT") then
		local name = string.gsub(channel, "%s%-%s.*", "");
		local lname = string.lower(name);
		_channelIndexLookupByName[lname] = nil;
		if (_channelList[index].displayIndex) then
			_channelIndexLookupByDisplayIndex[_channelList[index].displayIndex] = nil;
		end
		if (_channelList[index].name == name) then
			-- Save details on the channel for rejoining again in this
			-- session.
			local sdata = {};
			sdata.name = name;
			sdata.index = _channelList[index].displayIndex;
			if (_channelList[index].password and (_channelList[index].password ~= "") and (_channelList[index].type == 0)) then
				sdata.password = _channelList[index].password;
			end
			sdata.isSticky = _channelList[index].isSticky;
			sdata.forcePassword = _channelList[index].forcePassword;
			local info = ChatTypeInfo["CHANNEL"..index];
			sdata.color = {};
			sdata.color.r = info.r;
			sdata.color.g = info.g;
			sdata.color.b = info.b;
			sdata.special = _channelList[index].special or Chatmanager_ChannelIsSpecial(_channelList[index].name);
			if (_debugFrame and sdata.special) then
				_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.." --> left the "..sdata.special.." channel");
			end
			_channelSavedList[lname] = sdata;
		end
		_channelList[index] = {};
		ChatmanagerFrame_UpdateChannelList();
		ChatmanagerFrame_UpdatePlayerList();
		return -1;
	elseif (action == "YOU_JOINED") then
		local name = string.gsub(channel, "%s%-%s.*", "");
		if (not _channelList[index] or (_channelList[index].name ~= name) or _channelList[index].suspended) then
			local lname = string.lower(name);
			if (_channelList[index].displayIndex) then
				_channelIndexLookupByDisplayIndex[_channelList[index].displayIndex] = nil;
			end
			_channelList[index] = {};
			_channelList[index].name = name;
			_channelList[index].fullName = channel;
			if (zone == 0) then
				_channelList[index].type = 0;
			else
				_channelList[index].type = 1;
			end
			_channelIndexLookupByName[lname] = index;
			local sdata = _channelSavedList[lname];
			if (sdata) then
				if (not sdata.newPassword and sdata.password and (sdata.password ~= "")) then
					-- Joined this channel without using our password.  If we
					-- should force it then do that now, otherwise discard the
					-- password we had saved.
					if (sdata.forcePassword == 1) then
						if (_debugFrame) then
							_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."--> applying password to channel "..name);
						end
						SetChannelPassword(tostring(index), sdata.password);
						_channelList[index].password = sdata.password;
					end
					sdata.password = nil;
				else
					_channelList[index].password = sdata.newPassword;
					sdata.newPassword = nil;
				end
				_channelList[index].isSticky = sdata.isSticky;
				_channelList[index].forcePassword = sdata.forcePassword;
				if (sdata.index and not _channelIndexLookupByDisplayIndex[sdata.index]) then
					_channelList[index].displayIndex = sdata.index;
					_channelIndexLookupByDisplayIndex[sdata.index] = index;
				end
				if (sdata.color) then
					local info = ChatTypeInfo["CHANNEL"..index];
					info.r = sdata.color.r;
					info.g = sdata.color.g;
					info.b = sdata.color.b;
				end
				if (sdata.tabs) then
					-- Restore tabs on which this channel was on, and then
					-- discard the tabs list, since if the user manually
					-- changes their assigments and then leaves/rejoins, we
					-- don't want to use the old list.
					for tab = 1, NUM_CHAT_WINDOWS do
						local frame = getglobal("ChatFrame"..tab);
						local found = nil;
						for i = 1, table.getn(sdata.tabs) do
							if (sdata.tabs[i] == tab) then
								found = 1;
								ChatFrame_AddChannel(frame, name);
								break;
							end
						end
						if (not found) then
							ChatFrame_RemoveChannel(frame, name);
						end
					end
					sdata.tabs = nil;
				end
			else
				-- Use default channel colors
				local info = ChatTypeInfo["CHANNEL"..index];
				info.r = _defaultChannelColor.r;
				info.g = _defaultChannelColor.g;
				info.b = _defaultChannelColor.b;
			end
			local special = Chatmanager_ChannelIsSpecial(name);
			if (special) then
				if (_debugFrame) then
					_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.." --> new channel is "..special.." channel");
				end
				_channelList[index].special = special;
				for sname, sdata in _channelSavedList do
					if ((sdata.special == special) and sdata.index) then
						if (not _channelIndexLookupByDisplayIndex[sdata.index]) then
							if (_debugFrame) then
								_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.." --> assigning display index "..sdata.index);
							end
							if (_channelList[index].displayIndex) then
								_channelIndexLookupByDisplayIndex[_channelList[index].displayIndex] = nil;
							end
							_channelList[index].displayIndex = sdata.index;
							_channelIndexLookupByDisplayIndex[sdata.index] = index;
							if (sdata.color) then
								local info = ChatTypeInfo["CHANNEL"..index];
								info.r = sdata.color.r;
								info.g = sdata.color.g;
								info.b = sdata.color.b;
							end
						end
						sdata.special = nil;
						break;
					end
				end
			end
			if (not _channelList[index].displayIndex) then
				for i = CHATMANAGER_FIRST_CHANNEL, CHATMANAGER_LAST_CHANNEL do
					if (not _channelIndexLookupByDisplayIndex[i]) then
						_channelList[index].displayIndex = i;
						_channelIndexLookupByDisplayIndex[i] = index;
						break;
					end
				end
			end
			if (_channelList[index].type == 0) then
				Chatmanager_RequestPlayerList(index);
			end
			ChatmanagerFrame_UpdateChannelList();
			return 1;
		else
			return 0;
		end
	elseif (action == "SUSPENDED") then
		-- Note that only server channels can be suspended, so save the
		-- minimal data
		local name = string.gsub(channel, "%s%-%s.*", "");
		local lname = string.lower(name);
		local sdata = {};
		sdata.name = name;
		sdata.isSticky = _channelList[index].isSticky;
		local info = ChatTypeInfo["CHANNEL"..index];
		sdata.color = {};
		sdata.color.r = info.r;
		sdata.color.g = info.g;
		sdata.color.b = info.b;
		_channelSavedList[lname] = sdata;
		-- Update channel status
		_channelList[index].suspended = true;
		_channelList[index].fullName = name;
		_channelList[index].playerList = {};
		_channelList[index].filteredList = {};
		_channelList[index].playerCount = 0;
		ChatmanagerFrame_UpdateChannelList();
		ChatmanagerFrame_UpdatePlayerList();
		return 0;
	elseif (action == "YOU_CHANGED") then
		_channelList[index].fullName = channel;
		_channelList[index].playerList = {};
		_channelList[index].filteredList = {};
		_channelList[index].playerCount = 0;
		if (_channelList[index].type == 0) then
			Chatmanager_RequestPlayerList(index);
		end
		ChatmanagerFrame_UpdateChannelList();
		ChatmanagerFrame_UpdatePlayerList();
		return 0;
	elseif (action == "WRONG_PASSWORD") then
		-- When this happens, the client can get a bit confused about whether
		-- it is or isn't joined to the channel, so its best to force it to
		-- leave the channel explicitly, but note that in this case the
		-- "YOU_LEFT" message won't contain a valid index, so we won't see it
		-- here in this function and instead we do that cleanup now.  If there
		-- was a saved password then we return nil to indicate that we don't
		-- want to report this yet (since we will reattempt the connection
		-- when the empty YOU_LEFT notification is received).
		local lname = string.lower(string.gsub(channel, "%s%-%s.*", ""));
		_channelIndexLookupByName[lname] = nil;
		LeaveChannelByName(channel);
		if (_channelList[index].displayIndex) then
			_channelIndexLookupByDisplayIndex[_channelList[index].displayIndex] = nil;
		end
		_channelList[index] = {};
		local sdata = _channelSavedList[lname];
		if (sdata and sdata.password) then
			return nil;
		end
		ChatmanagerFrame_UpdateChannelList();
		ChatmanagerFrame_UpdatePlayerList();
		return 0;
	end
	-- For unhandled actions, just return 0
	return 0;
end


local function Chatmanager_ProcessEmptyNotice(channel, action)
	-- Called for actions that don't have an associated channel number and
	-- name in arg8 and arg9, this function is called with the channel name
	-- from arg4 instead.  Observed actions are YOU_LEFT and YOU_JOINED when
	-- a channel connection has failed (typically due to incorrect password).
	-- For YOU_LEFT actions, if there is still a password in the saved list
	-- then we attempt to connect again using it.  For YOU_JOINED actions we
	-- simply issue a disconnect.
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ProcessEmptyNotice("..channel..", "..action..")");
	end
	if (action == "YOU_LEFT") then
		local lname = string.lower(string.gsub(channel, "%s%-%s.*", ""));
		local sdata = _channelSavedList[lname];
		if (sdata and sdata.password and (sdata.password ~= "")) then
			if (not _channelConnects) then
				_channelConnects = {};
			end
			_channelConnects[lname] = sdata;
			_thisFrame:SetScript("OnUpdate", ChatmanagerFrame_OnUpdate);
		end
	elseif (action == "YOU_JOINED") then
		LeaveChannelByName(channel);
	end
end


local function ChatManager_ProcessUserNotice(name, index, action)
	-- Called for CHAT_MSG_NOTICE_USER events
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."ChatManager_ProcessUserNotice("..name..", "..index..", "..action..")");
	end
	local cdata = _channelList[index];
	if (not cdata) then
		return;
	end
	local pdata = nil;
	if (name and cdata.playerList) then
		pdata = cdata.playerList[name];
	end
	if (action == "SET_VOICE") then
		if (pdata) then
			pdata.isMuted = nil;
		end
		cdata.isModerated = true;
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdatePlayerList();
		end
	elseif (action == "UNSET_VOICE") then
		if (pdata) then
			pdata.isMuted = true;
		end
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdatePlayerList();
		end
	elseif (action == "SET_MODERATOR") then
		if (pdata) then
			pdata.isModerator = true;
		end
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdatePlayerList();
		end
	elseif (action == "UNSET_MODERATOR") then
		if (pdata) then
			pdata.isModerator = nil;
		end
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdatePlayerList();
		end
	elseif (action == "MODERATION_ON") then
		cdata.isModerated = true;
		Chatmanager_RequestPlayerList(index);
	elseif (action == "MODERATION_OFF") then
		cdata.isModerated = nil;
		Chatmanager_RequestPlayerList(index);
	elseif (action == "PASSWORD_CHANGED") then
		-- Password changed, but we don't know what it is yet (unless of
		-- course we changed it)
		if (not arg2 or (arg2 ~= _playerName)) then
			cdata.password = "";
		end
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdateChannelList(_selectedChannelDisplayIndex);
		end
	elseif (action == "OWNER_CHANGED") then
		cdata.isModerated = nil;
		Chatmanager_RequestPlayerList(index);
	elseif (action == "PLAYER_BANNED") then
		-- Nothing special to do here, ban will be followed by a kick
		-- automatically, but note that banning (like kicking) can only occur
		-- on a moderated list
		cdata.isModerated = true;
	elseif (action == "PLAYER_KICKED") then
		if (pdata) then
			cdata.playerList[name] = nil;
			Chatmanager_RebuildPlayerFilteredList(cdata);
			ChatmanagerFrame_UpdateChannelPlayerCounts(cdata);
		end
		cdata.isModerated = true;
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdatePlayerList();
		end
	end
end


local function Chatmanager_RestoreItemLink(name, i1, i2, i3, i4, rS)
	-- Called by gsub with the name, 4 item parameters, and the item rarity
	-- string, it returns a correctly formatted item link string.
	local itemString = "item:"..i1..":"..i2..":"..i3..":"..i4;
	local itemName, itemLink, itemRarity = GetItemInfo(itemString);
	if (itemName and itemLink and itemRarity) then
		local itemColor = _rarityConvertToColor[tonumber(itemRarity)];
		if (not itemColor) then
			itemColor = "";
		end
		return itemColor.."|H"..itemLink.."|h["..itemName.."]|h|r";
	end
	itemRarity = string.len(rS) - 1;
	if (itemRarity >= 0) then
		local itemColor = _rarityConvertToColor[tonumber(itemRarity)];
		if (not itemColor) then
			itemColor = "";
		end
		return itemColor.."|H"..itemString.."|h["..name.."]|h|r";
	end
	return "|H"..itemString.."|h["..name.."]|h|r";
end


local function Chatmanager_RestoreChatLinkItemLink(cS, i1, i2, i3, i4, name)
	-- Called by gsub with the color, 4 item parameters, and the item name
	-- string, it returns a correctly formatted item link string.
	local itemString = "item:"..i1..":"..i2..":"..i3..":"..i4;
	local itemName, itemLink, itemRarity = GetItemInfo(itemString);
	if (itemName and itemLink and itemRarity) then
		local itemColor = _rarityConvertToColor[tonumber(itemRarity)];
		if (not itemColor) then
			itemColor = "|c"..cS;
		end
		return itemColor.."|H"..itemLink.."|h["..itemName.."]|h|r";
	end
	return "|c"..cS.."|H"..itemString.."|h["..name.."]|h|r";
end


local function Chatmanager_ConvertItemLink(cS, i1, i2, i3, i4, name)
	-- Called by gsub with the color hex string (without the leading "|c"), 4
	-- item parameters, and item name, it returns a formatted item link string
	-- that can be sent via chat channel.
	if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLinkFormat == 1) then
		-- Convert item links using the same format as used by Yrys's Chatlink
		return "{CLINK:"..cS..":"..i1..":"..i2..":"..i3..":"..i4..":"..name.."}";
	end
	-- Use Chatmanager's own format
	local itemString = "item:"..i1..":"..i2..":"..i3..":"..i4;
	local _, _, itemRarity = GetItemInfo(itemString);
	if (not itemRarity) then
		-- Perform reverse color lookup to get rarity instead
		itemRarity = _rarityLookupByColor[cS];
	end
	if (itemRarity) then
		return "["..name.."]{"..i1..":"..i2..":"..i3..":"..i4.."}"..string.rep("\b", tonumber(itemRarity) + 1);
	end
	return "["..name.."]{"..i1..":"..i2..":"..i3..":"..i4.."}";
end


------------------------------------------------------------------------------
-- Hooked functions
------------------------------------------------------------------------------
function Chatmanager_JoinChannelByName(name, password, ID)
	-- Hooked so we can capture the password for the new channel
	if (_debugFrame) then
		if (password) then
			if (ID) then
				_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_JoinChannelByName("..name..", "..password..", "..ID..")");
			else
				_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_JoinChannelByName("..name..", "..password..")");
			end
		else
			_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_JoinChannelByName("..name..")");
		end
	end
	local index = _channelIndexLookupByName[string.lower(name)];
	if (index) then
		if (_debugFrame) then
			_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."--> already connected to channel \""..name.."\"");
		end
	else
		local zoneID, channelName = _original_JoinChannelByName(name, password, ID);
		if (zoneID) then
			if (channelName) then
				name = channelName;
			end
			if (_debugFrame) then
				_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."--> zoneID = "..zoneID.." and name = "..name);
			end
			local lname = string.lower(name);
			if (not _channelSavedList[lname]) then
				-- Its a new channel, so create an entry and give it the
				-- default colors
				_channelSavedList[lname] = {};
				_channelSavedList[lname].name = name;
				_channelSavedList[lname].color = {};
				_channelSavedList[lname].color.r = _defaultChannelColor.r;
				_channelSavedList[lname].color.g = _defaultChannelColor.g;
				_channelSavedList[lname].color.b = _defaultChannelColor.b;
			end
			if (password and (password ~= "")) then
				_channelSavedList[lname].newPassword = password;
			else
				_channelSavedList[lname].newPassword = nil;
			end
			_channelSavedList[lname].password = nil;
			return zoneID, channelName;
		end
	end
end


function Chatmanager_ListChannelByName(name)
	-- Hooked so we can determine when some other component is requesting a
	-- channel listing.  It is assumed that the passed name is either the
	-- channel name or its actual index (not its display index).
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ListChannelByName("..name..")");
	end
	local index = tonumber(name);
	if (not index) then
		index = _channelIndexLookupByName[string.lower(name or "")];
	end
	if (index) then
		Chatmanager_RequestPlayerList(index, true);
	else
		_original_ListChannelByName(name);
	end
end


function Chatmanager_SlashCommand_LEAVE(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
		if (index) then
			LeaveChannelByName(tostring(index));
		end
	else
		LeaveChannelByName(name);
	end
end


function Chatmanager_SlashCommand_LIST_CHANNEL(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	if (string.len(name) > 0) then
		local index = tonumber(name);
		if (index) then
			index = _channelIndexLookupByDisplayIndex[index];
		else
			index = _channelIndexLookupByName[string.lower(name)];
		end
		if (index) then
			Chatmanager_RequestPlayerList(index, true);
		end
	else
		ListChannels();
	end
end


function Chatmanager_SlashCommand_CHAT_PASSWORD(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local password = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index) then
		_channelList[index].password = password;
		if (index == _selectedChannelIndex) then
			ChatmanagerFrame_UpdateChannelList(_selectedChannelDisplayIndex);
		end
		SetChannelPassword(tostring(index), password);
	else
		SetChannelPassword(name, password);
	end
end


function Chatmanager_SlashCommand_CHAT_OWNER(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local newOwner = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index) then
		if (string.len(newOwner) > 0) then
			SetChannelOwner(tostring(index), newOwner);
		else
			DisplayChannelOwner(tostring(index));
		end
	end
end


function Chatmanager_SlashCommand_CHAT_MODERATOR(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelModerator(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_UNMODERATOR(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelUnmoderator(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_MODERATE(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index) then
		ChannelModerate(tostring(index));
	end
end


function Chatmanager_SlashCommand_CHAT_MUTE(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelMute(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_UNMUTE(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelUnmute(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_CINVITE(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelInvite(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_KICK(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelKick(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_BAN(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelBan(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_UNBAN(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local player = gsub(msg, "%s*([^%s]+)%s*(.*)", "%2");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index and (string.len(player) > 0)) then
		ChannelUnban(tostring(index), player);
	end
end


function Chatmanager_SlashCommand_CHAT_ANNOUNCE(msg)
	local name = gsub(msg, "%s*([^%s]+).*", "%1");
	local index = tonumber(name);
	if (index) then
		index = _channelIndexLookupByDisplayIndex[index];
	else
		index = _channelIndexLookupByName[string.lower(name)];
	end
	if (index) then
		ChannelToggleAnnouncements(tostring(index));
	end
end


function Chatmanager_GetChannelName(channel)
	-- Hooked so that we can perform the channel number reassignment without
	-- actually having to leave and rejoin etc., and hope to get the channel
	-- numbers right, etc.  For the default client, GetChannelName is called
	-- only by the ChatFrame code.  Note that we want this function to return
	-- the actual channel number, etc., its only when its given our "display"
	-- channel number that we want to convert it.
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_GetChannelName("..channel..")");
	end
	if (_convertChannelNumber) then
		local index = tonumber(channel or "");
		if (index) then
			local newIndex = _channelIndexLookupByDisplayIndex[index];
			if (newIndex) then
				channel = tostring(newIndex);
			else
				channel = nil;
			end
		end
	end
	if (channel and (channel ~= "")) then
		local num, name, id = _original_GetChannelName(channel);
		if (_debugFrame) then
			if (num and name) then
				if (id) then
					_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."--> "..num..", "..name..", "..id);
				else
					_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."--> "..num..", "..name);
				end
			end
		end
		return num, name, id;
	end
	return 0;
end


function Chatmanager_GetChannelList()
	-- Hooked so we can re-order the list according to what the user has
	-- selected.  We do this because we wish to maintain the correct color
	-- index association with the client, so that channel4 is really always 
	-- channel4, even though, via this addon we make it (say) channel7.  Note
	-- that the caller of GetChannelList expects each of the return arguments
	-- to be passed, not a single table, so we use unpack to do the conversion
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_GetChannelList()");
	end
	local list = {_original_GetChannelList()};
	local tempList = {};
	-- First reorder list into table based on display index (not best way to
	-- do this, but with a maximum of only 20 items in the table, we don't
	-- need to be super efficient).
	local maxPos = 0;
	for i = 1, table.getn(list), 2 do
		local index = list[i];
		local name = list[i+1];
		local newIndex = _channelList[index].displayIndex;
		if (newIndex) then
			local j = (newIndex*2) - 1;
			tempList[j] = index;
			tempList[j+1] = name;
			if (j + 1 > maxPos) then
				maxPos = j + 1;
			end
		else
			tempList[i] = index;
			tempList[i+1] = name;
			if (i + 1 > maxPos) then
				maxPos = i + 1;
			end
		end
	end
	-- Then compress to remove any sequence gaps
	local newList = {};
	for i = 1, maxPos, 2 do
		if (tempList[i] and tempList[i + 1]) then
			table.insert(newList, tempList[i]);
			table.insert(newList, tempList[i + 1]);
		end
	end
	return unpack(newList);
end


function Chatmanager_ChatEdit_UpdateHeader(editBox)
	-- Hooked so that we can clear the _convertChannelNumber flag if needed
	-- and to rebuild the header for chat channels where the display index is
	-- different to the actual index.  The implementation of this function is
	-- based on the original ChatEdit_UpdateHeader function (ChatFrame.lua).
--	if (_debugFrame) then
--		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ChatEdit_UpdateHeader("..editBox:GetName()..")");
--	end
	if (editBox.chatType == "CHANNEL") then
		_convertChannelNumber = nil;
		_original_ChatEdit_UpdateHeader(editBox);
		local header = getglobal(editBox:GetName().."Header");
		if (header) then
			-- editBox.channelTarget already has the correct (client) index
			local index = tonumber(editBox.channelTarget);
			local newIndex = _channelList[index].displayIndex;
			if (newIndex and (newIndex ~= index)) then
				local text = string.gsub(header:GetText(), "%d+", tostring(newIndex), 1);
				if (text) then
					header:SetText(text);
					editBox:SetTextInsets(15 + header:GetWidth(), 13, 0, 0);
				end
			end
		end
	else
		_original_ChatEdit_UpdateHeader(editBox);
	end
end


function Chatmanager_ChatEdit_ParseText(editBox, send)
	-- Hooked so that we can set the _convertChannelNumber flag so that the
	-- also-hooked GetChannelName function will translate a user input channel
	-- number to the actual channel number.  Note that ChatEdit_ParseText may
	-- itself call ChatEdit_UpdateHeader which will clear
	-- _convertChannelNumber if the type is channel.
--	if (_debugFrame) then
--		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ChatEdit_ParseText("..editBox:GetName()..", "..tostring(send or "")..")");
--	end
	_convertChannelNumber = true;
	_original_ChatEdit_ParseText(editBox, send);
	_convertChannelNumber = nil;
end


function Chatmanager_ChatFrame_OnEvent(event)
	-- Hooked to enable us to intercept and discard or change channel related
	-- messages (particularly to support number reassignment).
--	if (_debugFrame) then
--		if (event) then
--			_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ChatFrame_OnEvent("..event..", "..(arg1 or "")..")");
--		else
--			_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ChatFrame_OnEvent()");
--		end
--	end
	if (string.sub(event, 1, 16) == "CHAT_MSG_CHANNEL") then
		if (event == "CHAT_MSG_CHANNEL") then
			if (arg9 and (arg9 ~= "") and arg8 and (arg8 ~= "")) then
				arg4 = Chatmanager_ConvertChannelHeader(arg4, tonumber(arg8), arg9);
				arg1 = string.gsub(arg1, "%[([^%[^%]]-)%]{(%d+):(%d+):(%d+):(%d+)}(\b*)", Chatmanager_RestoreItemLink);
				arg1 = string.gsub(arg1, "{CLINK:(%x+):(%d-):(%d-):(%d-):(%d-):([^}]-)}", Chatmanager_RestoreChatLinkItemLink); -- "|c%1|Hitem:%2:%3:%4:%5|h[%6]|h|r");
			end
			_original_ChatFrame_OnEvent(event);
		elseif (event == "CHAT_MSG_CHANNEL_LIST") then
			-- List of all channels or a list of players on a channel
			if (arg9 and (arg9 ~= "") and arg8 and (arg8 ~= "")) then
				local index = tonumber(arg8);
				if (Chatmanager_ProcessPlayerList(arg1, index)) then
					-- This was an update explicitly requested by the user
					arg4 = Chatmanager_ConvertChannelHeader(arg4, index, arg9);
				else
					-- Don't pass this list request on
					return;
				end
			else
				-- List of all subscribed channnels, just need to rebuild this
				arg1 = Chatmanager_RebuildList(arg1);
			end
			_original_ChatFrame_OnEvent(event);
		elseif (event == "CHAT_MSG_CHANNEL_JOIN") then
			-- Someone has joined this chat channel
			Chatmanager_ProcessPlayerAction(arg2, tonumber(arg8), "JOIN");
			arg4 = Chatmanager_ConvertChannelHeader(arg4, tonumber(arg8), arg9);
			local note = ChatmanagerState.Servers[_serverName].Notes[arg2];
			if (note) then
				-- If we have a note for this player, then append it to the
				-- string used to format the joined message.  This is a bit of
				-- a kludge, but is minimally invasive.
				local originalFormat = CHAT_CHANNEL_JOIN_GET;
				CHAT_CHANNEL_JOIN_GET = CHAT_CHANNEL_JOIN_GET.." ("..note..")";
				_original_ChatFrame_OnEvent(event);
				CHAT_CHANNEL_JOIN_GET = originalFormat;
			else
				_original_ChatFrame_OnEvent(event);
			end
		elseif (event == "CHAT_MSG_CHANNEL_LEAVE") then
			-- Someone has joined this chat channel
			Chatmanager_ProcessPlayerAction(arg2, tonumber(arg8), "LEAVE");
			arg4 = Chatmanager_ConvertChannelHeader(arg4, tonumber(arg8), arg9);
			_original_ChatFrame_OnEvent(event);
		elseif (event == "CHAT_MSG_CHANNEL_NOTICE") then
			-- Notice actions are joined, left, suspended, changed, and wrong
			-- password.  Because these affect the channel list contents we
			-- have to be careful about how we reformat arg4.
			if (arg9 and (arg9 ~= "") and arg8 and (arg8 ~= "")) then
				local index = tonumber(arg8);
				local newarg4 = Chatmanager_ConvertChannelHeader(arg4, index, arg9);
				local result = Chatmanager_ProcessNotice(arg9, index, arg7, arg1);
				if (result == 1) then
					arg4 = Chatmanager_ConvertChannelHeader(arg4, index, arg9);
					_original_ChatFrame_OnEvent(event);
				elseif (result) then
					arg4 = newarg4;
					_original_ChatFrame_OnEvent(event);
				end
			else
				Chatmanager_ProcessEmptyNotice(arg4, arg1);
			end
		elseif (event == "CHAT_MSG_CHANNEL_NOTICE_USER") then
			if (arg9 and (arg9 ~= "") and arg8 and (arg8 ~= "")) then
				local index = tonumber(arg8);
				arg4 = Chatmanager_ConvertChannelHeader(arg4, index, arg9);
				ChatManager_ProcessUserNotice(arg2, index, arg1);
			end
			_original_ChatFrame_OnEvent(event);
		else
			if (arg9 and (arg9 ~= "") and arg8 and (arg8 ~= "")) then
				arg4 = Chatmanager_ConvertChannelHeader(arg4, tonumber(arg8), arg9);
			end
			_original_ChatFrame_OnEvent(event);
		end
	elseif (event == "CHAT_MSG_WHISPER_INFORM") then
		if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ReplyLastTell == 1) then
			if (this and this.editBox) then
				ChatEdit_SetLastTellTarget(this.editBox, arg2);
			end
		end
		_original_ChatFrame_OnEvent(event);
	else
		_original_ChatFrame_OnEvent(event);
		if (event == "UPDATE_CHAT_WINDOWS") then
			local _, _, _, _, _, _, shown, _, docked = GetChatWindowInfo(this:GetID());
			if (shown or docked) then
				this:RegisterEvent("CHAT_MSG_CHANNEL");
			else
				this:UnregisterEvent("CHAT_MSG_CHANNEL");
			end
		end
	end
end


function Chatmanager_ChatEdit_SendText(editBox, addHistory)
	-- If we have modified the original text we are sending on a chat channel,
	-- then send first the current contents of the editBox, and then replace
	-- this with the original text to add it to the history, and reset the
	-- passed original text.
	if (_channelOriginalText and addHistory) then
		_original_ChatEdit_SendText(editBox);
		editBox:SetText(_channelOriginalText);
		ChatEdit_AddHistory(editBox);
		_channelOriginalText = nil;
	else
		_original_ChatEdit_SendText(editBox, addHistory);
	end
end


function Chatmanager_ChatEdit_OnEnterPressed()
	-- Hooked so we can implement sticky channels and item linking.  We want
	-- to make sure to call the original OnEnterPressed function to ensure
	-- that multiple hooks to these functions (by other addons) preserve their
	-- functionality as much as possible.

	-- Call ChatEdit_ParseText if the editbox text starts with a slash to
	-- ensure that chatType and channelTarget are set correctly.  Note to
	-- avoid accidentally treating a slash-command on a sticky chat channel as
	-- an outgoing channel command we reset (and then restore if needed) the
	-- editbox chatType.
	local text = this:GetText();
	local type = this.chatType;
	local channelTarget = this.channelTarget;
	if (string.sub(text, 1, 1) == "/") then
		local origType = type;
		this.chatType = nil;
		ChatEdit_ParseText(this, 0);
		type = this.chatType;
		channelTarget = this.channelTarget;
		if (not type) then
			this.chatType = origType;
		end
		text = this:GetText();
	end
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_ChatEdit_OnEnterPressed() for chatType "..this.chatType);
	end

	-- Process text for item links first (if needed).
	local converted = nil;
	if (type == "CHANNEL") then
		if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.ChatLink == 1) then
			local index = tonumber(this.channelTarget);
			local cdata = _channelList[index];
			if (cdata and (cdata.type == 0)) then
				if (_original_FLT_ParseChatMessage) then
					text = _original_FLT_ParseChatMessage(text);
					converted = true;
				end
				local newText, subs = string.gsub(text, "|c(%x+)|Hitem:(%d+):(%d+):(%d+):(%d+)|h%[(.-)%]|h|r", Chatmanager_ConvertItemLink);
				if (subs > 0) then
					_channelOriginalText = text;
					this:SetText(newText);
				end
			end
		end
	end

	-- Call original OnEnterPressed to send the text, etc.
	_ignoreLinkConversions = converted;
	_original_ChatEdit_OnEnterPressed();
	_ignoreLinkConversions = nil;

	-- Update sticky channels, if needed
	if (type == "CHANNEL") then
		local index = tonumber(channelTarget);
		local cdata = _channelList[index];
		local sticky = nil;
		if (cdata and (cdata.isSticky == 1)) then
			if (ChatmanagerState.Servers[_serverName].Characters[_playerName].Options.SmartSticky == 1) then
				if ((GetNumRaidMembers() == 0) and (GetNumPartyMembers() == 0)) then
					sticky = 1;
				end
			else
				sticky = 1;
			end
		end
		if (sticky == 1) then
			this.stickyType = type;
			this.chatType = type;
			this.stickyChannel = channelTarget;
			this.channelTarget = channelTarget;
		elseif ((this.stickyType == "CHANNEL") and (this.stickyChannel)) then
			this.channelTarget = this.stickyChannel;
		end
	elseif (type and ChatTypeInfo[type] and (ChatTypeInfo[type].sticky == 1)) then
		this.stickyChannel = nil;
	end
end


function Chatmanager_ChatEdit_OnEscapePressed(editBox)
	-- Hooked to restore the previous sticky channel
	_original_ChatEdit_OnEscapePressed(editBox);
	if (editBox.chatType == "CHANNEL") then
		editBox.channelTarget = editBox.stickyChannel;
	end
end


function Chatmanager_ChatEdit_AddHistory(editBox)
	-- Modified to store the display index for the channel, rather
	-- than the actual index.
	if (editBox.chatType == "CHANNEL") then
		local index = tonumber(editBox.channelTarget);
		local cdata = _channelList[index];
		if (cdata and cdata.name and cdata.displayIndex) then
			editBox.channelTarget = tostring(cdata.displayIndex);
			_original_ChatEdit_AddHistory(editBox);
			editBox.channelTarget = tostring(index);
		else
			_original_ChatEdit_AddHistory(editBox);
		end
	else
		_original_ChatEdit_AddHistory(editBox);
	end
end


function Chatmanager_FCF_SetButtonSide(chatFrame, side)
	_original_FCF_SetButtonSide(chatFrame, side);
	if (_hideChatButtons == 1) then
		local bottomButton = getglobal(chatFrame:GetName().."BottomButton");
		if (bottomButton) then
			bottomButton:ClearAllPoints();
			bottomButton:SetPoint("BOTTOMRIGHT", chatFrame, "BOTTOMRIGHT", 0, -4);
		end
	end
end


------------------------------------------------------------------------------
-- Hooked functions from other addons
------------------------------------------------------------------------------
function Chatmanager_FLT_ParseChatMessage(text)
	-- If we have already converted any links in the text, make sure to not
	-- have Linkerator convert them back again!
	if (_ignoreLinkConversions) then
		return text;
	else
		return _original_FLT_ParseChatMessage(text);
	end
end


------------------------------------------------------------------------------
-- Chat frame OnScroll and OnShow handlers
------------------------------------------------------------------------------
function Chatmanager_ChatFrameOnScroll()
	-- Use the same key combinations and scrolling amounts as ChatBox (shift
	-- for top/bottom, control for by 3 lines, or normally by 1 line).
	if (arg1 == 1) then
		if (IsShiftKeyDown()) then
			this:ScrollToTop();
		elseif (IsControlKeyDown()) then
			this:ScrollUp();
			this:ScrollUp();
			this:ScrollUp();
		else
			this:ScrollUp();
		end
	elseif (arg1 == -1) then
		if (IsShiftKeyDown()) then
			this:ScrollToBottom();
		elseif (IsControlKeyDown()) then
			this:ScrollDown();
			this:ScrollDown();
			this:ScrollDown();
		else
			this:ScrollDown();
		end
	end
	if (_hideChatButtons == 1) then
		if (this:AtBottom()) then
			getglobal(this:GetName().."BottomButton"):Hide();
		else
			getglobal(this:GetName().."BottomButton"):Show();
		end
	end
end


function Chatmanager_ChatFrameOnShow()
	if (this.chatmanagerOrigOnShow) then
		this.chatmanagerOrigOnShow();
		if (this:AtBottom()) then
			getglobal(this:GetName().."BottomButton"):Hide();
		end
		getglobal(this:GetName().."DownButton"):Hide();
		getglobal(this:GetName().."UpButton"):Hide();
	end
end


function Chatmanager_ChatFrameBottomButtonOnClick()
	if (this.chatmanagerOrigOnClick) then
		this.chatmanagerOrigOnClick();
		this:Hide();
	end
end


------------------------------------------------------------------------------
-- OnEvent handler
------------------------------------------------------------------------------
function Chatmanager_OnEvent(event)
	if (_debugFrame) then
		_debugFrame:AddMessage(CHATMANAGER_TEXT.DEBUG.."Chatmanager_OnEvent("..event..", "..(arg1 or "")..")");
	end
	if (event == "PLAYER_TARGET_CHANGED") then
		if (UnitIsPlayer("target")) then
			local name = UnitName("target");
			if (_selectedPlayer ~= name) then
				if (name and (name ~= "")) then
					_selectedPlayer = name;
				else
					_selectedPlayer = nil;
				end
				ChatmanagerFrame_UpdatePlayerList();
			end
		elseif (_selectedPlayer) then
			_selectedPlayer = nil;
			ChatmanagerFrame_UpdatePlayerList();
		end

	elseif (event == "PLAYER_LEAVING_WORLD") then
		_thisFrame:SetScript("OnUpdate", nil);

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (_playerListUpdateTimeout or _channelConnects) then
			_thisFrame:SetScript("OnUpdate", ChatmanagerFrame_OnUpdate);
		end

	elseif (event == "VARIABLES_LOADED") then
		Chatmanager_VariablesLoaded();

	elseif (event == "PLAYER_LOGIN") then
		Chatmanager_PlayerLogin();

	elseif (event == "PLAYER_LOGOUT") then
		Chatmanager_PlayerLogout();

	end
end


------------------------------------------------------------------------------
-- OnLoad function
------------------------------------------------------------------------------
function Chatmanager_OnLoad()
	-- Record our frame pointer for later
	_thisFrame = this;

	-- Register for player events
	_thisFrame:RegisterEvent("VARIABLES_LOADED");
	_thisFrame:RegisterEvent("PLAYER_LOGIN");
	_thisFrame:RegisterEvent("PLAYER_LOGOUT");
	_thisFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	_thisFrame:RegisterEvent("PLAYER_LEAVING_WORLD");

	-- Register slash functions
	SLASH_CHATMANAGER1 = "/chatmanager";
	SLASH_CHATMANAGER2 = "/chatman";
	SlashCmdList["CHATMANAGER"] = function(text)
		Chatmanager_SlashCommand(text);
	end
	SLASH_GROUP1 = "/group";
	SLASH_GROUP2 = "/gr";
	SlashCmdList["GROUP"] = function(text)
		ChatmanagerGroup_SlashCommand(text);
	end

	-- Add our static popup dialogs for the actions we need
	StaticPopupDialogs["CHATMANAGER_LEAVE_CONFIRM"] = _chatmanagerConfirmLeavePopup;
	StaticPopupDialogs["CHATMANAGER_NEW_CHANNEL"] = _chatmanagerEnterChannelNamePopup;
	StaticPopupDialogs["CHATMANAGER_PLAYER_NOTE"] = _chatmanagerEnterPlayerNotePopup;

	-- Announce ourselves
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_NAME.." v"..CHATMANAGER_VERSION.." loaded");
	end

	-- Populate _rarityLookupByColor and _rarityConvertToColor tables
	for rarity = 0, 6 do
		local _, _, _, itemColor = GetItemQualityColor(rarity);
		if (itemColor) then
			_rarityConvertToColor[rarity] = itemColor;
			_rarityLookupByColor[string.sub(itemColor, 3)] = rarity;
		end
	end
end


------------------------------------------------------------------------------
-- Slash command function
------------------------------------------------------------------------------
function Chatmanager_SlashCommand(text)
	if (text) then
		local command, params = Chatmanager_GetNextParam(text);
		command = string.lower(command or "");
		if (command == CHATMANAGER_COMMANDS.COMMAND_SHOW) then
			ShowUIPanel(ChatmanagerFrame);
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_HIDE) then
			HideUIPanel(ChatmanagerFrame);
			HideUIPanel(ChatmanagerOptionsFrame);
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_OPTIONS) then
			ShowUIPanel(ChatmanagerOptionsFrame);
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_RESET) then
			params = string.lower(params or "");
			if (params == "") then
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_RESET_HELP);
				end
			end
			if ((params == CHATMANAGER_COMMANDS.OPTION_RESET_ORDER) or (params == CHATMANAGER_COMMANDS.OPTION_RESET_ALL)) then
				Chatmanager_ResetOrdering();
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_RESET_ORDER_CONFIRM);
				end
			end
			if ((params == CHATMANAGER_COMMANDS.OPTION_RESET_COLOR) or (params == CHATMANAGER_COMMANDS.OPTION_RESET_ALL)) then
				Chatmanager_ResetColors();
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_RESET_COLOR_CONFIRM);
				end
			end
			if ((params == CHATMANAGER_COMMANDS.OPTION_RESET_WINDOW) or (params == CHATMANAGER_COMMANDS.OPTION_RESET_ALL)) then
				Chatmanager_ResetWindows();
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_RESET_WINDOW_CONFIRM);
				end
			end
			ChatmanagerFrame_OnShow();
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE) then
			local pname, pnote = Chatmanager_GetNextParam(params or "");
			if (pname ~= "") then
				pname = string.upper(string.sub(pname, 1, 1))..string.lower(string.sub(pname, 2));
				if (pnote and (pnote ~= "") and (string.gsub(pnote, "%s", "") ~= "")) then
					pnote = string.sub(pnote, 1, _chatmanagerEnterPlayerNotePopup.maxLetters);
					ChatmanagerState.Servers[_serverName].Notes[pname] = pnote;
					ChatmanagerFrame_UpdatePlayerList();
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage(string.format(CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE_CONFIRM_FORMAT, pname, pnote));
					end					
				else
					CloseDropDownMenus();
					ColorPickerFrame:Hide();
					ChatmanagerDropDown.thisName = pname;
					local dialogFrame = StaticPopup_Show("CHATMANAGER_PLAYER_NOTE", ChatmanagerDropDown.thisName);
					if (dialogFrame) then
						dialogFrame.data = ChatmanagerDropDown.thisName;
					end
				end
			elseif (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE_HELP);
			end
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_LISTNOTES) then
			if (DEFAULT_CHAT_FRAME) then
				local found = 0;
				for pname, pnote in ChatmanagerState.Servers[_serverName].Notes do
					found = found + 1;
					DEFAULT_CHAT_FRAME:AddMessage(string.format(CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE_LIST_FORMAT, found, pname, pnote));
				end
				if (found < 1) then
					DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_PLAYERNOTE_LIST_EMPTY);
				end
			end
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_DEBUGON) then
			_debugFrame = DEFAULT_CHAT_FRAME;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_DEBUGON_CONFIRM);
			end
		elseif (command == CHATMANAGER_COMMANDS.COMMAND_DEBUGOFF) then
			_debugFrame = nil;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_COMMANDS.COMMAND_DEBUGOFF_CONFIRM);
			end
		elseif (command == "") then
			if (ChatmanagerFrame:IsShown() or ChatmanagerOptionsFrame:IsShown()) then
				HideUIPanel(ChatmanagerFrame);
				HideUIPanel(ChatmanagerOptionsFrame);
			else
				ShowUIPanel(ChatmanagerFrame);
			end
		else
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(CHATMANAGER_EM.ON..CHATMANAGER_NAME.." v"..CHATMANAGER_VERSION..CHATMANAGER_EM.OFF);
				for _, string in CHATMANAGER_HELP do
					DEFAULT_CHAT_FRAME:AddMessage(string);
				end
			end
		end
	end
end


function ChatmanagerGroup_SlashCommand(text)
	-- Sends a message to RAID if in a raid, PARTY if in a party, or SAY
	-- otherwise
	if (text ~= "") then
		if (GetNumRaidMembers() > 0) then
			SendChatMessage(text, "RAID", nil);
		elseif (GetNumPartyMembers() > 0) then
			SendChatMessage(text, "PARTY", nil);
		else
			SendChatMessage(text, "SAY", nil);
		end
	end
end

