SLASH_MARSQUESTORGANIZER1 = "/q";

local RealmName;
local PlayerCharacterName;
local GotQuestLogUpdate;
local savedQuestIDMap;
local lastExistingNumEntries = -1;
local savedNumEntries;
local savedNumQuests;
local savedSelectedQuest;
local reportedNoQuests;

function MarsQuestOrganizer_OnLoad()
	SlashCmdList["MARSQUESTORGANIZER"] = function(msg)
		MarsQuestOrganizer_SlashCmd(msg);
	end
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("QUEST_LOG_UPDATE");
end

function MarsQuestOrganizer_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		-- If no record of this addon is in SavedVariables.lua, create an empty list
		if ( not MarsQuestOrganizerSettings ) then
			MarsQuestOrganizerSettings = { };
		end
		-- Get the realmname so that characters with the same name can be differentiated
		RealmName = GetCVar("realmName");
		if ( not MarsQuestOrganizerSettings[RealmName] ) then
			MarsQuestOrganizerSettings[RealmName] = { };
		end
		PlayerCharacterName = UnitName("player");
		if ( not MarsQuestOrganizerSettings[RealmName][PlayerCharacterName] ) then
			MarsQuestOrganizerSettings[RealmName][PlayerCharacterName] = { };
		end
	elseif ( event == "QUEST_LOG_UPDATE" ) then
		if(not GotQuestLogUpdate) then
			GotQuestLogUpdate = 1;
			MarsQuestOrganizer_RefreshOtherQuestDisplays();
			return;
		end
		MarsQuestOrganizer_UpdateDB();
	end
end

local existingGetNumQuestLogEntries = GetNumQuestLogEntries;
local existingGetQuestLogTitle = GetQuestLogTitle;
local existingSelectQuestLogEntry = SelectQuestLogEntry;
local existingGetQuestLogSelection = GetQuestLogSelection;
local existingExpandQuestHeader = ExpandQuestHeader;
local existingCollapseQuestHeader = CollapseQuestHeader;
local existingIsUnitOnQuest = IsUnitOnQuest;
local existingIsQuestWatched = IsQuestWatched;
local existingAddQuestWatch = AddQuestWatch;
local existingRemoveQuestWatch = RemoveQuestWatch;
local existingGetQuestIndexForWatch = GetQuestIndexForWatch;
local existingGetNumQuestLeaderBoards = GetNumQuestLeaderBoards;
local existingGetQuestLogLeaderBoard = GetQuestLogLeaderBoard;

function MarsQuestOrganizer_SortComparison(value1, value2)
	if(value1.header == value2.header) then
		if(value1.level == value2.level) then
			return value1.title < value2.title;
		end
		return value1.level < value2.level;
	end
	return value1.header < value2.header;
end

function MarsQuestOrganizer_UpdateDB()
	if(not RealmName or not PlayerCharacterName or not GotQuestLogUpdate) then
		return nil;
	end
	local numEntries, numQuests = existingGetNumQuestLogEntries();
	if(numEntries == lastExistingNumEntries) then
		return 1;
	end
	if(lastExistingNumEntries == -1 and numEntries < 1) then
		if(not reportedNoQuests) then
			DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: Your quest log has become active but shows no quests yet; suspending MarsQuestOrganizer until quests are found.");
			reportedNoQuests = 1;
		end
		return nil;
	end
	if(reportedNoQuests) then
		DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: Your quest log now has quests in it; resuming MarsQuestOrganizer.");
		reportedNoQuests = nil;
	end
	lastExistingNumEntries = numEntries;
	local index;
	for index in MarsQuestOrganizerSettings[RealmName][PlayerCharacterName] do
		MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][index].cleanup = 1;
	end
	local i;
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete;
	local sortData = {};
	local j = 1;
	local lastHeader = "NoHeader";
	for i=1, numEntries, 1 do
		questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = existingGetQuestLogTitle(i);
		if(isHeader) then
			lastHeader = questLogTitleText;
		else
			sortData[j] = {};
			if(MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][questLogTitleText]) then
				sortData[j].header = MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][questLogTitleText].header;
				MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][questLogTitleText].cleanup = nil;
			else
				sortData[j].header = lastHeader;
			end
			sortData[j].level = level;
			sortData[j].title = questLogTitleText;
			sortData[j].questID = i;
			j = j + 1;
		end
	end
	table.sort(sortData, MarsQuestOrganizer_SortComparison);
	savedNumQuests = j - 1;
	local selectedQuest = existingGetQuestLogSelection();
	savedSelectedQuest = selectedQuest;
	savedQuestIDMap = {};
	j = 1;
	lastHeader = nil;
	for i=1, savedNumQuests, 1 do
		if(sortData[i].header ~= lastHeader) then
			lastHeader = sortData[i].header;
			savedQuestIDMap[j] = {};
			savedQuestIDMap[j].header = lastHeader;
			j = j + 1;
		end
		savedQuestIDMap[j] = {};
		savedQuestIDMap[j].questID = sortData[i].questID;
		if(savedQuestIDMap[j].questID == selectedQuest) then
			savedSelectedQuest = j;
		end
		j = j + 1;
	end
	savedNumEntries = j - 1;
	for index in MarsQuestOrganizerSettings[RealmName][PlayerCharacterName] do
		if(MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][index].cleanup) then
			MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][index] = nil;
			if(MarsQuestOrganizerSettings.marsDebug) then
				DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer ("..lastExistingNumEntries.."): |cffff0000Cleaned up|r organization data for "..index..".");
			end
		else
			if(MarsQuestOrganizerSettings.marsDebug) then
				DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer ("..lastExistingNumEntries.."): |cff00ff00Kept|r organization data for "..index..".");
			end
		end
	end
	return 1;
end

function MarsQuestOrganizer_RefreshOtherQuestDisplays()
	lastExistingNumEntries = -1;
	existingExpandQuestHeader(0);
end

function MarsQuestOrganizer_SlashCmd(msg)
	if (string.len(msg) > 0) then
		if(not MarsQuestOrganizer_UpdateDB()) then
			DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: Still waiting for Quest Log to load.");
			return;
		end
		local questID = GetQuestLogSelection();
		if(not (questID and questID > 0)) then
			DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: No quest selected.");
			return;
		end
		if(msg == "resetall") then
			MarsQuestOrganizerSettings[RealmName][PlayerCharacterName] = {};
		else
			local title = GetQuestLogTitle(questID);
			if(not title) then
				DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: No quest selected.");
				return;
			end
			if(msg == "reset") then
				MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][title] = nil;
			else
				MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][title] = {};
				MarsQuestOrganizerSettings[RealmName][PlayerCharacterName][title].header = msg;
			end
		end
		MarsQuestOrganizer_RefreshOtherQuestDisplays();
	else
		DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer Usage:");
		DEFAULT_CHAT_FRAME:AddMessage("/q - shows this message");
		DEFAULT_CHAT_FRAME:AddMessage("/q <header> - moves the currently selected quest to this header");
		DEFAULT_CHAT_FRAME:AddMessage("/q reset - reset the currently selected quest to its default header");
		DEFAULT_CHAT_FRAME:AddMessage("/q resetall - resets all quests to their default headers");
	end
end

function GetNumQuestLogEntries()
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingGetNumQuestLogEntries();
	end
	return savedNumEntries, savedNumQuests;
end

function GetQuestLogTitle(questID)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingGetQuestLogTitle(questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID]) then
		if(savedQuestIDMap[questID].questID) then
			return existingGetQuestLogTitle(savedQuestIDMap[questID].questID);
		else
			return savedQuestIDMap[questID].header, 0, nil, true, nil, nil;
		end
	end
end

function SelectQuestLogEntry(questID)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingSelectQuestLogEntry(questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		savedSelectedQuest = questID;
		return existingSelectQuestLogEntry(savedQuestIDMap[questID].questID);
	end
end

function GetQuestLogSelection()
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingGetQuestLogSelection();
	end
	return savedSelectedQuest;
end

function ExpandQuestHeader(questID)
	--DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: Please report what you did to see this message.");
end

function CollapseQuestHeader(questID)
	DEFAULT_CHAT_FRAME:AddMessage("MarsQuestOrganizer: Collapsing quest headers not advised.");
	QuestLogCollapseAllButton.collapsed = nil;
end

function IsUnitOnQuest(questID, unit)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingIsUnitOnQuest(questID, unit);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		return existingIsUnitOnQuest(savedQuestIDMap[questID].questID, unit);
	end
end

function IsQuestWatched(questID)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingIsQuestWatched(questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		return existingIsQuestWatched(savedQuestIDMap[questID].questID);
	end
end

function AddQuestWatch(questID)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingAddQuestWatch(questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		return existingAddQuestWatch(savedQuestIDMap[questID].questID);
	end
end

function RemoveQuestWatch(questID)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingRemoveQuestWatch(questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		return existingRemoveQuestWatch(savedQuestIDMap[questID].questID);
	end
end

function GetQuestIndexForWatch(watchID)
	if(not MarsQuestOrganizer_UpdateDB()) then
		return existingGetQuestIndexForWatch(watchID);
	end
	if(savedQuestIDMap) then
		local mappedQuestID = existingGetQuestIndexForWatch(watchID);
		local questID;
		for questID in savedQuestIDMap do
			if(savedQuestIDMap[questID].questID and (savedQuestIDMap[questID].questID == mappedQuestID)) then
				return questID;
			end
		end
	end
end

function GetNumQuestLeaderBoards(questID)
	if(not questID or not MarsQuestOrganizer_UpdateDB()) then
		return existingGetNumQuestLeaderBoards(questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		return existingGetNumQuestLeaderBoards(savedQuestIDMap[questID].questID);
	end
end

function GetQuestLogLeaderBoard(objectiveID, questID)
	if(not questID or not MarsQuestOrganizer_UpdateDB()) then
		return existingGetQuestLogLeaderBoard(objectiveID, questID);
	end
	if(savedQuestIDMap and savedQuestIDMap[questID] and savedQuestIDMap[questID].questID) then
		return existingGetQuestLogLeaderBoard(objectiveID, savedQuestIDMap[questID].questID);
	end
end

