-- (c) Torrid of www.torridreflections.com, aka Torrid/Torec/Torvie of Black Dragonflight USA
-- this file may be distributed so long as it remains unaltered
-- if this file is posted to a web site, credit must be given to me along with a link to my web page
-- no code in this file may be used in other works without expressed permission

local PreformAVEnabler_Version = tonumber(GetAddOnMetadata("PreformAVEnabler", "Version"));
local PreformAVEnabler_Status = {};
local PreformAVEnabler_MyStatus = { frame = 0, deserter = 0, };
local PreformAVEnabler_Members = {};		-- = { name = "", online = 0 or 1 }
local PreformAVEnabler_Pending = 0;		-- if non-zero, attempt to join this specific bg id
local PreformAVEnabler_PendingBG = 0;		-- bg type
local PreformAVEnabler_AnywhereQueueBG = nil;
local PreformAVEnabler_AnywhereQueueId = nil;
local PreformAVEnabler_OnUpdateTime = 0;	-- used to prevent redundant status redraws
local PreformAVEnabler_Debug = false;
local PreformAVEnabler_NewGroup = true;		-- send status update when joing new group
local PreformAVEnabler_LastStatus = "";		-- used to prevent 
local PreformAVEnabler_LastStatusTime = 0;	-- redundant status sending
local PreformAVEnabler_WaitUntilReady = false;	-- to prevent leave queue spam
--local PreformAVEnabler_QTime = 0;			-- timestamp of when queued
--local PreformAVEnabler_ClosedTime = 0;		-- timestamp of when battlefield frame was closed
--local PreformAVEnabler_PlayerQueuedHimself = true;	-- did the instance window close within 3 seconds of being queued?
local PreformAVEnabler_HideTime = 0;		-- timestamp of when the hide signal was seen
local PreformAVEnabler_AutomateBG = 0;		-- which BG to automate
local PreformAVEnabler_RaidLeader = "";		-- remember who the party/raid leader is so he can use buttons on people inside bgs
local PreformAVEnabler_SetMemberFramesPending	-- if true, member frames will be shown or hidden when combat ends
local BG_NAME = {
	[1] = PREFORM_AV_ENABLER_AV,
	[2] = PREFORM_AV_ENABLER_WSG,
	[3] = PREFORM_AV_ENABLER_AB,
	[4] = PREFORM_AV_ENABLER_EYE,
	[5] = PREFORM_AV_ENABLER_STRAND,
	[6] = PREFORM_AV_ENABLER_ISLE,
};
local BG_ABR_NAME = {
	[1] = PREFORM_AV_ENABLER_AV_ABR,
	[2] = PREFORM_AV_ENABLER_WSG_ABR,
	[3] = PREFORM_AV_ENABLER_AB_ABR,
	[4] = PREFORM_AV_ENABLER_EYE_ABR,
	[5] = PREFORM_AV_ENABLER_STRAND_ABR,
	[6] = PREFORM_AV_ENABLER_ISLE_ABR,
};
local BG_ID = {
	[PREFORM_AV_ENABLER_AV]  = 1,
	[PREFORM_AV_ENABLER_WSG] = 2,
	[PREFORM_AV_ENABLER_AB]  = 3,
	[PREFORM_AV_ENABLER_EYE] = 4,
	[PREFORM_AV_ENABLER_STRAND] = 5,
	[PREFORM_AV_ENABLER_ISLE] = 6,
};
local NUM_BGS = #BG_NAME;
for i = 1, NUM_BGS do
	PreformAVEnabler_MyStatus[i] = { status = 0, id = 0 };
end
PreformAVEnabler_Automating = false;
PreformAVEnabler_Threshold = 30;
PreformAVEnabler_NeverUpdated = 0;		-- used to determine if a status update was ever seen between the time player got member data and
						-- player opened status window (don't request status update if player has everybody's status)
PreformAVEnabler_LastCheck = 0;			-- used to prevent redundant status updates
PreformAVEnabler_HideColumn = {};		-- which columns are hidden/minimized
PreformAVEnabler_SizeLimit = false;		-- maximum window size set by user click dragging the bottom of the frame
PreformAVEnabler_Buttonize = false;		-- create raid unit buttons or not
--PreformAVEnabler_ForcedJoin = true;		-- allow raid leader to force joining or not

StaticPopupDialogs["PREFORM_LEAVE_CONFIRM"] = {
	text = PREFORM_AV_ENABLER_LEAVE_THIS,
	button1 = OKAY,
	button2 = NO,
	OnAccept = function(self, data)
		if ( not AcceptBattlefieldPort(data) ) then
			return 1;
		end
	end,
	timeout = 90,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1,
	multiple = 1
};

function PreformAVEnablerFrame_OnLoad(frame)
	SlashCmdList["PREFORMAV"] = PreformAVEnablerCmdLine;
	SLASH_PREFORMAV1 = PREFORM_AV_ENABLER_CMD;

	frame:RegisterEvent("CHAT_MSG_ADDON");
	frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	frame:RegisterEvent("RAID_ROSTER_UPDATE");
	frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	--frame:RegisterEvent("PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE");		-- doesn't seem to ever trigger in game?
	frame:RegisterEvent("PVPQUEUE_ANYWHERE_SHOW");
	frame:RegisterEvent("BATTLEFIELDS_SHOW");
	frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	frame:RegisterEvent("PARTY_INVITE_REQUEST");
	frame:RegisterEvent("PLAYER_REGEN_ENABLED");
	frame:RegisterEvent("VARIABLES_LOADED");

	PreformAVEnabler_SetWidgets();
	BattlefieldFrame:HookScript("OnShow", PreformAVEnabler_BattlefieldFrameOnShowHook);
	BattlefieldFrame:HookScript("OnHide", PreformAVEnabler_BattlefieldFrameOnHideHook);
	MiniMapBattlefieldFrame:HookScript("OnClick", PreformAVEnabler_MiniMapButton);

	-- set column headers
	for i = 1, NUM_BGS do
		getglobal("PreformAVEnablerHeaderText"..i):SetText(BG_NAME[i]);
		getglobal("PreformAVEnablerHideButton"..i).tooltipText = BG_NAME[i];
	end

	-- stripe the backgrounds
	for i = 2, 40, 2 do
		getglobal("PreformAVEnablerMember"..i):SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
								    tile = true, tileSize = 16, edgeSize = 16, });
		getglobal("PreformAVEnablerMember"..i):SetBackdropColor(1, 1, 1, .2);
	end

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00ffff00"..PREFORM_AV_ENABLER_SELF.."|r v|c0000ffff"..PreformAVEnabler_Version.."|r loaded.  |c0000ff00"..PREFORM_AV_ENABLER_CMD.."|r to use");
	end
end

function PreformAVEnabler_SetWidgets()

	if ( PreformAVEnabler_RaidLeader == UnitName("player") ) then

		for i = 1, NUM_BGS do
			if ( not PreformAVEnabler_HideColumn[i] ) then
				getglobal("PreformAVEnablerFrameQueueButton"..i):Show();
				getglobal("PreformAVEnablerFrameJoinButton"..i):Show();
				getglobal("PreformAVEnablerFrameLeaveButton"..i):Show();
				getglobal("PreformAVEnablerAutomateCheckButton"..i):Show();
			else
				getglobal("PreformAVEnablerFrameQueueButton"..i):Hide();
				getglobal("PreformAVEnablerFrameJoinButton"..i):Hide();
				getglobal("PreformAVEnablerFrameLeaveButton"..i):Hide();
				getglobal("PreformAVEnablerAutomateCheckButton"..i):Hide();
			end
		end

		PreformAVEnablerThresholdSlider:Show();
		--PreformAVEnablerForcedJoinCheckButton:Hide();

	else
		for i = 1, NUM_BGS do
			getglobal("PreformAVEnablerFrameQueueButton"..i):Hide();
			getglobal("PreformAVEnablerFrameJoinButton"..i):Hide();
			getglobal("PreformAVEnablerFrameLeaveButton"..i):Hide();
			getglobal("PreformAVEnablerAutomateCheckButton"..i):Hide();
		end
		PreformAVEnablerThresholdSlider:Hide();

		local x = 0;
		for i = 1, NUM_BGS do
			if ( not PreformAVEnabler_HideColumn[i] ) then
				x = x + 1;
			end
		end

		-- hide forced join check box if all BGs minimized/hidden due to space
		--[[
		if ( x == 0 ) then
			PreformAVEnablerForcedJoinCheckButton:Hide();
		else
			PreformAVEnablerForcedJoinCheckButton:Show();
		end
		]]
	end
end

function PreformAVEnabler_SendStatus(type, bg)

	local msg;

	if ( type == "bg" and bg ) then
		msg = "u,"..bg..","..PreformAVEnabler_MyStatus[bg].status..","..PreformAVEnabler_MyStatus[bg].id;

	elseif ( type == "frame" ) then
		msg = "f,"..PreformAVEnabler_MyStatus.frame;

	else
		-- full status

		PreformAVEnabler_MyStatus.deserter = PreformAVEnabler_CheckDeserter();

		msg = "s,"..PreformAVEnabler_Version..","
			..PreformAVEnabler_MyStatus.frame..","
			..PreformAVEnabler_MyStatus.deserter;

		for i = 1, NUM_BGS do
			msg = msg..","..i..","..PreformAVEnabler_MyStatus[i].status..","..PreformAVEnabler_MyStatus[i].id;
		end
	end

	-- if this status message is the same as the last one sent, and not two seconds have passed, then don't send
	if ( PreformAVEnabler_LastStatus == msg and PreformAVEnabler_LastStatusTime > GetTime() ) then
		return
	end

	PreformAVEnabler_LastStatusTime = GetTime() + 2;	-- do not send redundant messages within two seconds
	PreformAVEnabler_LastStatus = msg;

	if ( PreformAVEnabler_Debug ) then
		if ( type == "bg" ) then
			DEFAULT_CHAT_FRAME:AddMessage(" >>> Sending "..BG_NAME[bg].." status: "..msg, 0, 1, 1);
		elseif ( type == "frame" ) then
			DEFAULT_CHAT_FRAME:AddMessage(" >>> Sending frame status: "..msg, 0, 1, 1);
		else
			DEFAULT_CHAT_FRAME:AddMessage(" >>> Sending my status: "..msg, 0, 1, 1);
		end
	end

	SendAddonMessage("PreformAVEnabler", msg, "RAID");
end

function PreformAVEnabler_BattlefieldFrameOnShowHook()
	local mapName = GetBattlefieldInfo();

	if ( BG_ID[mapName] ) then
		PreformAVEnabler_MyStatus.frame = BG_ID[mapName];
	else
		PreformAVEnabler_MyStatus.frame = 0;
	end

	if ( PreformAVEnabler_MyStatus.frame > 0 ) then

		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("battlemaster window opened; PreformAVEnabler_MyStatus.frame == "..PreformAVEnabler_MyStatus.frame, 0, 1, 1);
		end

		PreformAVEnabler_SendStatus("frame");
	end
end

function PreformAVEnabler_BattlefieldFrameOnHideHook()

	if ( PreformAVEnabler_MyStatus.frame > 0 ) then
		PreformAVEnabler_MyStatus.frame = 0;

		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("battlemaster window closed", 0, 1, 1);
		end

		PreformAVEnabler_SendStatus("frame");
	end
end

function PreformAVEnabler_LeaveQueue(bg)

	if ( not bg ) then
		bg = AV;
	end

	local status, id, qid = PreformAVEnabler_BGStatus(bg);

	if ( status == "confirm" or status == "queued" ) then
		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("Leaving "..BG_NAME[bg].." queue", 0, 1, 1);
		end

--		AcceptBattlefieldPort(qid);

		if ( (PreformAVEnabler_RaidLeader ~= UnitName("player") or PreformAVEnabler_Automating) ) then

			PreformAVEnabler_HidePopup(qid);

			local dialog = StaticPopup_Show("PREFORM_LEAVE_CONFIRM", BG_NAME[bg], id, qid);
			if ( dialog ) then
				dialog.data = qid;
			end
		end

--		PreformAVEnabler_MyStatus[bg].status = currentBg;
--		PreformAVEnabler_MyStatus[bg].id = 0;
--		PreformAVEnabler_HideTime = 0;
	end

	PreformAVEnabler_CheckBattlefieldFrame();
end

function PreformAVEnabler_Queue(bg, queueId)
	queueId = tonumber(queueId);
	bg = tonumber(bg);

	if ( not BG_NAME[bg] ) then
		return
	end

	if ( PreformAVEnabler_MyStatus.frame == bg ) then
		if ( not queueId ) then
			-- first avail
			JoinBattlefield(0);
			PreformAVEnabler_HideTime = GetTime();
		else
			-- specific bg
			local instanceId;
			for i = 1, GetNumBattlefields() do
				instanceId = GetBattlefieldInstanceInfo(i);
				if ( instanceId == queueId ) then
					JoinBattlefield(i);
					return
				end
			end

		end
	end

	PVPBattlegroundFrame.selectedBG = bg;
	RequestBattlegroundInstanceInfo(bg);
	PreformAVEnabler_AnywhereQueueBG = bg;
	PreformAVEnabler_AnywhereQueueId = queueId;
end

function PreformAVEnabler_MassQueue(bg)

	if ( PreformAVEnabler_Debug ) then
		DEFAULT_CHAT_FRAME:AddMessage("Sending signal to queue for "..BG_NAME[bg], 0, 1, 1);
	end
--	SendAddonMessage("PreformAVEnabler", "hide", "RAID");

	if ( bg == BG_ID[PREFORM_AV_ENABLER_AV] ) then
		SendAddonMessage("PreformAVEnabler", "queue", "RAID");
	else
		SendAddonMessage("PreformAVEnabler", "queue,"..bg, "RAID");
	end
end

function PreformAVEnabler_SetPending(n, bg)
	if ( n and n > 0 ) then
		PreformAVEnabler_Pending = n;
		PreformAVEnabler_PendingBG = bg;
		PreformAVEnablerPendingText:SetText(PREFORM_AV_ENABLER_ATTEMPT..BG_NAME[bg].." "..n);
		PreformAVEnabler_HideTime = 0;
	else
		PreformAVEnablerPendingText:SetText("");
		PreformAVEnabler_Pending = 0;
		PreformAVEnabler_PendingBG = 0;
	end
end

function PreformAVEnabler_Tally(bg)
	-- returns:
	-- determine the majority's bg,
	-- how many got it,
	-- how many got a bg at all,
	-- unqueued people,
	-- queued people,
	-- total raid members that are able to queue,
	-- is everybody ready?
	
	local val;
	local allReady = true;
	local people = 0;
	local unqueuedPeople = 0;
	local queuedPeople = 0;
	local hisStatus;
	local AV = {};

	for i, val in pairs(PreformAVEnabler_Members) do

		hisStatus = PreformAVEnabler_Status[val.name];

		-- if player is online, we have his status info, and is not inside a BG, and not deserter (only these people will count)
		if (	val.online and
			hisStatus and
			hisStatus[bg].status < 3 and
			hisStatus.deserter < ( GetTime() + 1 )		-- add one extra second for good measure
		) then
			people = people + 1;

			-- is everybody ready?
			if ( hisStatus[bg].status ~= 0 or hisStatus[bg].id > 0 ) then
				allReady = false;
			end

			-- these people might possibly get the AV we want (if status == queued)
			-- include non-queued else they might trigger a requeue when not wanted
			if ( hisStatus[bg].status == 1 ) then
				queuedPeople = queuedPeople + 1;
			elseif ( hisStatus[bg].status == 0 ) then
				unqueuedPeople = unqueuedPeople + 1;
			end

			-- tally up confirms
			-- does this guy have an instance, and is his status confirm?
			if ( hisStatus[bg].id > 0 and hisStatus[bg].status == 2) then
				if ( AV[hisStatus[bg].id] ) then
					AV[hisStatus[bg].id] = AV[hisStatus[bg].id] + 1;
				else
					AV[hisStatus[bg].id] = 1;
				end

			end

		end
	end

	local av, num;
	local highestAV = 0;
	local haveConfirm = 0;

	for av, num in pairs(AV) do
		if ( not AV[highestAV] ) then
			highestAV = av;			-- first av in table
		end

		if ( num > AV[highestAV] ) then
			highestAV = av;
		end
		haveConfirm = haveConfirm + num;
	end

	return highestAV, AV[highestAV], haveConfirm, unqueuedPeople, queuedPeople, people, allReady;
end

-- check everybody's battlemaster window status and disable buttons that wouldn't work due to windows being closed
function PreformAVEnabler_CheckBMs()
	local member, memberStatus;
	local bms = {};

	for i = 1, NUM_BGS do
		table.insert(bms, { window = false, status = 0 } );

		for _, member in pairs(PreformAVEnabler_Members) do
			memberStatus = PreformAVEnabler_Status[member.name];
			if ( memberStatus.frame == i ) then
				bms[i].window = true;
			end

			if ( memberStatus[i].status == 0 ) then
				bms[i].none = true;

			elseif ( memberStatus[i].status == 1 ) then
				bms[i].queued = true;

			elseif ( memberStatus[i].status == 2 ) then
				bms[i].confirms = true;
			end
		end
	end

	for i = 1, NUM_BGS do
		--[[
		if ( bms[i].window and bms[i].none ) then
			getglobal("PreformAVEnablerFrameQueueButton"..i):Enable();
		else
			getglobal("PreformAVEnablerFrameQueueButton"..i):Disable();
		end
		]]
		if ( bms[i].queued or bms[i].confirms ) then
			getglobal("PreformAVEnablerFrameLeaveButton"..i):Enable();
		else
			getglobal("PreformAVEnablerFrameLeaveButton"..i):Disable();
		end
		if ( bms[i].confirms ) then
			getglobal("PreformAVEnablerFrameJoinButton"..i):Enable();
		else
			getglobal("PreformAVEnablerFrameJoinButton"..i):Disable();
		end
	end
end

-- if player is the leader, then set buttons and process automate if checked
function PreformAVEnabler_Leader()

	if ( (IsRaidLeader() or IsPartyLeader()) or PreformAVEnabler_RaidLeader == UnitName("player") ) then

		PreformAVEnabler_CheckBMs();

		if ( PreformAVEnabler_AutomateBG < 1 ) then
			return
		end

		local majorityAV, majorityPop, haveConfirm, unqueuedPeople, queuedPeople, people, allReady = PreformAVEnabler_Tally(PreformAVEnabler_AutomateBG);

		if ( allReady ) then
			-- put this here so checking automate right after manually queueing will work
			PreformAVEnabler_WaitUntilReady = false;
		end

		if ( PreformAVEnabler_Automating ) then

			if ( allReady ) then
				PreformAVEnabler_MassQueue(PreformAVEnabler_AutomateBG);
				return
			end

			-- prevent leave queue spam, and prevent unwanted behavior if automate is quickly checked after user hits leave queue
			if ( PreformAVEnabler_WaitUntilReady ) then
				return
			end

			-- any confirms at all?
			if ( majorityAV > 0 ) then
				-- check if threshold met, or everybody got the same instance
				if (	majorityPop >= PreformAVEnabler_Threshold or
					majorityPop >= people
				) then
					-- send join signal
					PreformAVEnabler_Automating = false;
					getglobal("PreformAVEnablerAutomateCheckButton"..PreformAVEnabler_AutomateBG):SetChecked(0);

					if ( PreformAVEnabler_Debug ) then
						DEFAULT_CHAT_FRAME:AddMessage(" -- Sending signal to join "..BG_NAME[PreformAVEnabler_AutomateBG].." "..majorityAV, 0, 1, 1);
						DEFAULT_CHAT_FRAME:AddMessage(" -- Automate disengaged", 0, 1, 1);
					end
					if ( PreformAVEnabler_AutomateBG == BG_ID[PREFORM_AV_ENABLER_AV] ) then
						SendAddonMessage("PreformAVEnabler", "join,"..majorityAV, "RAID");
					else
						SendAddonMessage("PreformAVEnabler", "enter,"..PreformAVEnabler_AutomateBG..","..majorityAV, "RAID");
					end
				else

					-- is the threshold even possible to meet?
					if ( people > PreformAVEnabler_Threshold ) then

						-- if threshold impossible, send requeue signal
						-- do nothing otherwise
						if ( (majorityPop + queuedPeople + unqueuedPeople) < PreformAVEnabler_Threshold ) then
							if ( PreformAVEnabler_Debug ) then
								DEFAULT_CHAT_FRAME:AddMessage(" -- Threshold now impossible;  Majority's "..BG_NAME[PreformAVEnabler_AutomateBG].." has "..majorityPop.." people.  Queued People="..queuedPeople.."  Unqueued="..unqueuedPeople, 0, 1, 1);
								DEFAULT_CHAT_FRAME:AddMessage(" -- Sending leave queue signal", 0, 1, 1);
							end
							if ( PreformAVEnabler_AutomateBG == BG_ID[PREFORM_AV_ENABLER_AV] ) then
								SendAddonMessage("PreformAVEnabler", "leavequeue", "RAID");
							else
								SendAddonMessage("PreformAVEnabler", "leavequeue,"..PreformAVEnabler_AutomateBG, "RAID");
							end
							PreformAVEnabler_WaitUntilReady = true;
						end

					-- else the threshold is impossible to meet
					-- did everybody get an AV?  if not do nothing
					elseif ( (haveConfirm + unqueuedPeople) >= people ) then
						-- everybody has an AV, not all match, and threshold not met
						if ( PreformAVEnabler_Debug ) then
							DEFAULT_CHAT_FRAME:AddMessage(" -- Everybody has a confirm box, not all match, and threshold not met: "..haveConfirm, 0, 1, 1);
							DEFAULT_CHAT_FRAME:AddMessage(" -- Sending leave queue signal", 0, 1, 1);
						end
						if ( PreformAVEnabler_AutomateBG == BG_ID[PREFORM_AV_ENABLER_AV] ) then
							SendAddonMessage("PreformAVEnabler", "leavequeue", "RAID");
						else
							SendAddonMessage("PreformAVEnabler", "leavequeue,"..PreformAVEnabler_AutomateBG, "RAID");
						end
						PreformAVEnabler_WaitUntilReady = true;
					end
				end
			end -- if there are confirms

		end -- if automate checked
	end -- if group/raid leader
end

function PreformAVEnabler_BGStatus(bg)
	local map, desiredMap;
	local status, id, qid = "none", 0, 0;

	if ( BG_NAME[bg] ) then
		desiredMap = BG_NAME[bg];
	else
		return "none", 0, 0;
	end

	for i = 1, MAX_BATTLEFIELD_QUEUES do
		status, map, id = GetBattlefieldStatus(i);

		if ( map == desiredMap ) then
			return status, id, i;
		end
	end

	return "none", 0, 0;
end

function PreformAVEnabler_InsideBG()
	local instance, instanceType = IsInInstance();
	if ( instance and instanceType == "pvp" ) then
		return true;
	end
	return false;
end

function PreformAVEnabler_CheckBattlefieldFrame()
	if ( not BattlefieldFrame:IsVisible() ) then
		PreformAVEnabler_MyStatus.frame = 0;
	else
		local mapName = GetBattlefieldInfo();

		if ( BG_ID[mapName] ) then
			PreformAVEnabler_MyStatus.frame = BG_ID[mapName];
		else
			PreformAVEnabler_MyStatus.frame = 0;
		end
	end
end

function PreformAVEnabler_IsLeader(name)
	local i, unit;

	if ( name == PreformAVEnabler_RaidLeader ) then
		return true;
	end

	if ( GetNumRaidMembers() == 0 ) then
		-- this isn't a raid

		i = GetPartyLeaderIndex();

		if ( i > 0 ) then
			unit = "party"..i;
			if ( UnitName(unit) == name ) then
				if ( UnitIsPartyLeader(unit) ) then
					return true;
				end
			end
		else
			-- is player leader?
			if ( name == UnitName("player") ) then
				return true;
			end
		end

		return false;
	else
		-- this is a raid
		for i = 1, 40 do
			unit = "raid"..i;
			if ( UnitName(unit) == name ) then
				if ( UnitIsPartyLeader(unit) ) then
					return true;
				end
			end
		end
	end
end

function PreformAVEnabler_DetermineStatus()
	local status, id, qid;

	for i = 1, NUM_BGS do
		status, id, qid = PreformAVEnabler_BGStatus(i);

		PreformAVEnabler_MyStatus[i].id = id;

		if ( status == "queued" ) then
			PreformAVEnabler_MyStatus[i].status = 1;

		elseif ( status == "confirm" ) then
			PreformAVEnabler_MyStatus[i].status = 2;

		elseif ( status == "active" ) then
			PreformAVEnabler_MyStatus[i].status = 3;
		
		else
			PreformAVEnabler_MyStatus[i].status = 0;
		end
	end

	PreformAVEnabler_CheckBattlefieldFrame();
end

function PreformAVEnabler_HidePopup(qid)
	StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY", qid);
end

function PreformAVEnabler_HidePopupsExcept(bg)

	local qid;

	for i = 1, NUM_BGS do
		
		_, _, qid = PreformAVEnabler_BGStatus(i);

		if ( qid > 0 and bg ~= i ) then
			PreformAVEnabler_HidePopup(qid);
		end
	end
end

--[[
function PreformAVEnabler_ShowPopup(bg, number)
	StaticPopup_Show("CONFIRM_BATTLEFIELD_ENTRY", BG_NAME[bg], number);
end
]]

function PreformAVEnabler_Join(bg, joinThis)

	if ( PreformAVEnabler_RaidLeader ~= UnitName("player") or not PreformAVEnablerFrame:IsVisible() ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(PREFORM_AV_ENABLER_JOIN_THIS, BG_NAME[bg], joinThis or ""));
	end

	PreformAVEnabler_HidePopupsExcept(bg);

	local status, id, qid = PreformAVEnabler_BGStatus(bg);

	if ( status == "active" ) then
		return

	elseif ( status == "confirm" ) then

		if ( not joinThis or joinThis == id ) then


-- AcceptBattlefieldPort() now requires a button press
--[[
			if ( not PreformAVEnabler_ForcedJoin ) then
				DEFAULT_CHAT_FRAME:AddMessage(format(PREFORM_AV_ENABLER_JOIN_THIS, BG_NAME[bg], joinThis or ""));
				return			
			end

			if ( not UnitIsAFK("player") ) then
				if ( PreformAVEnabler_Debug ) then
					DEFAULT_CHAT_FRAME:AddMessage("Entering "..BG_NAME[bg].." "..id, 0, 1, 1);
				end
				AcceptBattlefieldPort(qid, 1);
			end
]]

		elseif ( joinThis and id > 0 ) then
			-- id not the one we want
			PreformAVEnabler_LeaveQueue(bg);
			PreformAVEnabler_SetPending(joinThis, bg);
		end

		return
	
	elseif ( status == "queued" ) then

		if ( joinThis ) then
			PreformAVEnabler_SetPending(joinThis, bg);
		end

		if ( id == joinThis or id == 0 ) then
			return
		end

		PreformAVEnabler_LeaveQueue(bg);

	elseif ( status == "none" ) then

		PreformAVEnabler_Queue( bg, joinThis );
	end

end

function PreformAVEnabler_PaintWindow()
	-- prevent redundant redraws
	if ( PreformAVEnabler_OnUpdateTime < 9.5 and PreformAVEnablerFrame:IsVisible() ) then
		PreformAVEnabler_Update();
		PreformAVEnabler_OnUpdateTime = 0;
	else
		PreformAVEnabler_OnUpdateTime = 9;
	end
end

function PreformAVEnabler_ParseAddonMsg(msg, sender)

	local vars = {};
	local v, bg, i;
	for v in string.gmatch(msg, "([^,]+)") do
		table.insert(vars, v);
	end

	-- BG status from a 2.0+ user.  Using small string to reduce bandwidth usage
	if ( vars[1] == "u" ) then
		if ( not vars[2] or not vars[3] or not vars[4] ) then
			return
		end

		bg = tonumber( vars[2] );
		if ( not PreformAVEnabler_Status[sender] ) then
			PreformAVEnabler_CreateStatus(sender);
		end
		if ( not PreformAVEnabler_Status[sender][bg] ) then
			return
		end

		PreformAVEnabler_Status[sender][bg].status = tonumber( vars[3] );
		PreformAVEnabler_Status[sender][bg].id = tonumber( vars[4] );

		PreformAVEnabler_PaintWindow();
		-- set leader buttons and handle automate if player is leader
		PreformAVEnabler_Leader();

	-- frame status of a 2.0+ user
	elseif ( vars[1] == "f" ) then
		if ( not vars[2] or not PreformAVEnabler_Status[sender] ) then
			return
		end

		i = tonumber( vars[2] );
		PreformAVEnabler_Status[sender].frame = i;

		PreformAVEnabler_PaintWindow();
		PreformAVEnabler_Leader();


	-- status from a 2.0+ user
	elseif ( vars[1] == "s" ) then
		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("--> from "..sender..": "..msg, 0, 1, 1);
		end

		if ( not vars[2] or not vars[3] or not vars[4] ) then
			return
		end
		for i = 2, #vars do
			vars[i] = tonumber(vars[i]);
		end

		if ( not PreformAVEnabler_Status[sender] ) then
			PreformAVEnabler_CreateStatus(sender);
		end

		PreformAVEnabler_Status[sender].version = vars[2]; -- version
		PreformAVEnabler_Status[sender].frame = vars[3]; -- battlefield frame status
		if ( vars[4] > 0 ) then
			PreformAVEnabler_Status[sender].deserter = vars[4] + GetTime(); -- deserter
		end

		-- status of every BG
		v = 5;
		for i = v, (v + NUM_BGS * 3), 3 do
			if ( vars[i] and vars[i+1] and vars[i+2] and PreformAVEnabler_Status[sender][vars[i]] ) then
				if ( PreformAVEnabler_Status[sender][vars[i]] ) then
					PreformAVEnabler_Status[sender][vars[i]].status = vars[i+1];
					PreformAVEnabler_Status[sender][vars[i]].id = vars[i+2];
				end
			end
		end

		PreformAVEnabler_PaintWindow();
		PreformAVEnabler_Leader();

	
	elseif ( vars[1] == "statuscheck" ) then

		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("Status check requested from "..sender, 0, 1, 1);
		end

		-- if got raid member data, but never a status update
		if ( PreformAVEnabler_NeverUpdated == 1 ) then
			-- 2 == do not request status update when we open the status window to reduce redundancy
			PreformAVEnabler_NeverUpdated = 2;
		end

		PreformAVEnabler_DetermineStatus();
		PreformAVEnabler_SendStatus();
		PreformAVEnabler_LastCheck = GetTime() + 3;		-- prevent spam

	elseif ( vars[1] == "queue" ) then

		if ( PreformAVEnabler_IsLeader(sender) ) then
			if ( not vars[2] ) then
				bg = BG_ID[PREFORM_AV_ENABLER_AV];
			else
				bg = tonumber(vars[2]);
			end

			if ( BG_NAME[bg] ) then
				if ( PreformAVEnabler_Debug ) then
					if ( not BG_NAME[bg] ) then
						DEFAULT_CHAT_FRAME:AddMessage(bg);
					end
					DEFAULT_CHAT_FRAME:AddMessage("Queue "..BG_NAME[bg].." signal seen", 0, 1, 1);
				end
				PreformAVEnabler_SetPending(0);
				PreformAVEnabler_Queue(bg);
			end
		end

	-- signal for AV joining
	elseif ( vars[1] == "join" ) then

		if ( PreformAVEnabler_IsLeader(sender) ) then

			bg = BG_ID[PREFORM_AV_ENABLER_AV];

			if ( vars[2] ) then
				i = tonumber(vars[2]);
			end

			if ( PreformAVEnabler_Debug ) then
				DEFAULT_CHAT_FRAME:AddMessage("Join "..BG_NAME[bg].." "..(i or "").." signal seen", 0, 1, 1);
			end
			PreformAVEnabler_Join(bg, i);
		end

	-- need two types of join signals to maintain some backward compatibility
	-- this one used for non-AV BGs
	elseif ( vars[1] == "enter" ) then

		if ( PreformAVEnabler_IsLeader(sender) ) then

			if ( not vars[2] ) then
				return
			else
				bg = tonumber(vars[2]);
			end
			if ( vars[3] ) then
				i = tonumber(vars[3]);
			end

			if ( BG_NAME[bg] ) then

				if ( PreformAVEnabler_Debug ) then
					DEFAULT_CHAT_FRAME:AddMessage("Enter "..BG_NAME[bg].." "..(i or "").." signal seen", 0, 1, 1);
				end
				PreformAVEnabler_Join(bg, i);
			end
		end

	elseif ( vars[1] == "leavequeue" ) then
		if ( PreformAVEnabler_IsLeader(sender) ) then

			if ( not vars[2] ) then
				bg = BG_ID[PREFORM_AV_ENABLER_AV];
			else
				bg = tonumber(vars[2]);
			end

			if ( BG_NAME[bg] ) then
				if ( PreformAVEnabler_Debug ) then
					DEFAULT_CHAT_FRAME:AddMessage("Leave "..BG_NAME[bg].." queue signal seen", 0, 1, 1);
				end

				PreformAVEnabler_SetPending(0);
				PreformAVEnabler_LeaveQueue(bg);
			end
		end

--[[
	elseif ( vars[1] == "hide" ) then
		if ( PreformAVEnabler_IsLeader(sender) ) then
			if ( PreformAVEnabler_Debug ) then
				DEFAULT_CHAT_FRAME:AddMessage("Hide signal seen", 0, 1, 1);
			end
			PreformAVEnabler_HideTime = GetTime();
		end
]]
	elseif ( vars[1] == "leaveall" ) then
		if ( PreformAVEnabler_IsLeader(sender) ) then
			if ( PreformAVEnabler_Debug ) then
				DEFAULT_CHAT_FRAME:AddMessage("Leave all battleground queues signal seen", 0, 1, 1);
			end
			local status, map, id;

			for i=1, MAX_BATTLEFIELD_QUEUES do
				status, map, id = GetBattlefieldStatus(i);
				if ( status == "confirm" or status == "queued" ) then
					if ( PreformAVEnabler_Debug ) then
						DEFAULT_CHAT_FRAME:AddMessage("Left "..map.." queue", 0, 1, 1);
					end
					AcceptBattlefieldPort(i, 0);
				end
			end
		end

	elseif ( vars[1] == "mystatus" ) then
		if ( PreformAVEnabler_Debug ) then
			--DEFAULT_CHAT_FRAME:AddMessage(sender.." sent status ("..msg..")", 0, 1, 1);
		end
		if ( not PreformAVEnabler_Status[sender] ) then
			PreformAVEnabler_CreateStatus(sender);
		end

		if ( vars[2] ) then
			PreformAVEnabler_Status[sender].version = tonumber( vars[2] ); -- version
		end
		if ( vars[3] ) then
			PreformAVEnabler_Status[sender].frame = tonumber( vars[3] ); -- frame open/closed
		end

		if ( vars[4] ) then
			PreformAVEnabler_Status[sender][BG_ID[PREFORM_AV_ENABLER_AV]].status = tonumber( vars[4] ); -- confirm
		end

		if ( vars[5] ) then
			PreformAVEnabler_Status[sender][BG_ID[PREFORM_AV_ENABLER_AV]].id = tonumber( vars[5] );  -- AV #
		end

		local deserter;
		if ( vars[6] ) then
			deserter = tonumber( vars[6] );
			if ( deserter > 0 ) then
				PreformAVEnabler_Status[sender].deserter = deserter + GetTime();
			end
		end

		PreformAVEnabler_PaintWindow();
		PreformAVEnabler_Leader();
	end
end

function PreformAVEnablerFrame_OnEvent(event, arg1, arg2, arg3, arg4)

	if ( event == "CHAT_MSG_ADDON" ) then
		if ( arg1 ~= "PreformAVEnabler" ) then
			return
		end
		PreformAVEnabler_ParseAddonMsg(arg2, arg4);

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then

		if ( PreformAVEnabler_InsideBG() ) then

			if ( PreformAVEnabler_Debug ) then
				local status, id, qid;
				for i in ipairs(BG_NAME) do
					status, id, qid = PreformAVEnabler_BGStatus(i);
					DEFAULT_CHAT_FRAME:AddMessage(BG_NAME[i].." status: "..status..";  ID: "..id..";  QID: "..qid, 0, 1, 1);
				end
			end

			PreformAVEnabler_SetPending(0);
			PreformAVEnabler_DetermineStatus();
			PreformAVEnabler_SendStatus();
			PreformAVEnabler_Update();

			if ( PreformAVEnablerMember1Button ) then
				for i = 1, 40 do
					getglobal("PreformAVEnablerMember"..i.."Button"):Disable();
				end
			end

			return;		-- don't want to GetMembers() inside a bg
		end

		PreformAVEnabler_GetMembers();
		--PreformAVEnabler_SendStatus();

		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("PLAYER_ENTERING_WORLD", 0, 1, 1);
		end

		if ( PreformAVEnablerMember1Button ) then
			for i = 1, 40 do
				getglobal("PreformAVEnablerMember"..i.."Button"):Enable();
			end
		end


	elseif ( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		if ( PreformAVEnabler_InsideBG() ) then
			return
		end

		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("PARTY MEMBERS CHANGED, RAID ROSTER UPDATE", 0, 1, 1);
		end

		PreformAVEnabler_GetMembers();

	elseif ( event == "BATTLEFIELDS_SHOW" ) then
--[[
		local mapName = GetBattlefieldInfo();

		-- queue pending if player reopened window
		if ( PreformAVEnabler_Pending > 0 and PreformAVEnabler_PendingBG == BG_ID[mapName] ) then

			PreformAVEnabler_Queue(BG_ID[mapName], PreformAVEnabler_Pending, true);
			PreformAVEnabler_SetPending(0);
		end
]]
	elseif ( event == "UPDATE_BATTLEFIELD_STATUS" ) then

		local status, id, qid;

		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("UPDATE_BATTLEFIELD_STATUS event", 0, 1, 1);
		end

		for i = 1, NUM_BGS do
			status, id, qid = PreformAVEnabler_BGStatus(i);

			PreformAVEnabler_MyStatus[i].id = id;

			if ( status == "confirm" ) then
				--DEFAULT_CHAT_FRAME:AddMessage("got BG "..id);
				PreformAVEnabler_MyStatus[i].status = 2;

				-- hide confirm box if leader queued (sent hide signal) in last 30 seconds
				if ( (PreformAVEnabler_HideTime + 30) > GetTime() ) then
					if ( PreformAVEnabler_Debug ) then
						DEFAULT_CHAT_FRAME:AddMessage("Hiding Popup", 0, 1, 1);
					end

					PreformAVEnabler_HidePopup(qid);
					PreformAVEnabler_HideTime = 0;
				end

				if ( PreformAVEnabler_Pending > 0 and PreformAVEnabler_PendingBG == i ) then
					if ( id ~= PreformAVEnabler_Pending ) then
						--DEFAULT_CHAT_FRAME:AddMessage("not the BG we want (pending = "..PreformAVEnabler_Pending..") requeueing");
						-- join specific BG only
						PreformAVEnabler_LeaveQueue(i);
					else
						-- we got in the BG we wanted
						PreformAVEnabler_SetPending(0);
					end
				end

				PreformAVEnabler_SendStatus("bg", i);

			elseif ( status == "queued" ) then
				-- if newly queued
				if ( PreformAVEnabler_MyStatus[i].status ~= 1 ) then
					PreformAVEnabler_SetPending(0);
					PreformAVEnabler_MyStatus[i].status = 1;
					PreformAVEnabler_SendStatus("bg", i);		-- only send status if changed to prevent redundancy
				end

			elseif ( status == "active" ) then
				if ( PreformAVEnabler_Debug ) then
					DEFAULT_CHAT_FRAME:AddMessage(BG_NAME[i].." ACTIVE", 0, 1, 1);
				end
				if ( PreformAVEnabler_MyStatus[i].status ~= 3 ) then
					PreformAVEnabler_MyStatus[i].status = 3;
					PreformAVEnabler_SendStatus("bg", i);
				end

			elseif ( status == "none" ) then
				-- this qid not queued for or inside a BG

				if ( PreformAVEnabler_MyStatus[i].status ~= 0 ) then
					if ( PreformAVEnabler_Debug ) then
						DEFAULT_CHAT_FRAME:AddMessage(BG_NAME[i].." status == none", 0, 1, 1);
					end
					PreformAVEnabler_MyStatus[i].status = 0;
					PreformAVEnabler_MyStatus[i].id = 0;
					PreformAVEnabler_SendStatus("bg", i);

					StaticPopup_Hide("PREFORM_LEAVE_CONFIRM", qid);

					if ( PreformAVEnabler_Pending > 0 and PreformAVEnabler_PendingBG == i ) then
						PreformAVEnabler_Queue(PreformAVEnabler_PendingBG, PreformAVEnabler_Pending);
						PreformAVEnabler_SetPending(0);
					end
				end
			end
		end

	elseif ( event == "PVPQUEUE_ANYWHERE_SHOW" ) then
--		if ( PreformAVEnabler_Debug ) then
--			DEFAULT_CHAT_FRAME:AddMessage("PVPQUEUE_ANYWHERE_SHOW", 0, 1, 1);
--		end

		if ( PreformAVEnabler_AnywhereQueueBG ) then

			if ( PreformAVEnabler_AnywhereQueueId ) then
				local instanceId;
				for i = 1, GetNumBattlefields() do
					instanceId = GetBattlefieldInstanceInfo(i);
					if ( instanceId == PreformAVEnabler_AnywhereQueueId ) then
						JoinBattlefield(i);
						break;
					end
				end
			else
				JoinBattlefield(0);
			end
			PreformAVEnabler_AnywhereQueueBG = nil;
			PreformAVEnabler_AnywhereQueueId = nil;
		end


--	elseif ( event == "PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE" ) then
--		DEFAULT_CHAT_FRAME:AddMessage("PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE");

	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
		PreformAVEnabler_SetMemberFrames();

	elseif ( event == "PARTY_INVITE_REQUEST" ) then
		PreformAVEnabler_NewGroup = true;
		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage("PARTY_INVITE_REQUEST", 0, 1, 1);
		end

	elseif ( event == "VARIABLES_LOADED" ) then

		for i = 1, NUM_BGS do
			if ( PreformAVEnabler_HideColumn[i] ) then
				PreformAVEnabler_HideColumn[i] = nil;
				PreformAVEnablerHideButton_OnClick(getglobal("PreformAVEnablerHideButton"..i), i);
			end
		end
	end
end

function PreformAVEnabler_CreateStatus(name)

	PreformAVEnabler_Status[name] = {
		version = -1,
		frame = 0,
		deserter = 0,
	};
	for i = 1, NUM_BGS do
		PreformAVEnabler_Status[name][i] = { status = 0, id = 0 };
	end
end

function PreformAVEnabler_SetMemberFrames()
	if ( PreformAVEnabler_SetMemberFramesPending ) then

		if ( not PreformAVEnablerMember1Button or not InCombatLockdown() ) then
			for i = 1, 40 do
				if ( PreformAVEnabler_Members[i] ) then
					getglobal("PreformAVEnablerMember"..i):Show();
				else
					getglobal("PreformAVEnablerMember"..i):Hide();
				end
			end

			PreformAVEnabler_ResizeFrame();
			PreformAVEnabler_SetMemberFramesPending = false;
		end

	end
end

-- this should never get called inside a bg
function PreformAVEnabler_GetMembers()
	PreformAVEnabler_Members = {};
	PreformAVEnabler_RaidLeader = "";
	local name, unit, online;
	local numRaidMembers = GetNumRaidMembers();
	if ( numRaidMembers == 0 ) then

		-- Party members
		for i=1, MAX_PARTY_MEMBERS do
			if ( GetPartyMember(i) ) then
				unit = "party"..i;
				name = UnitName(unit);
				online = UnitIsConnected(unit);
				if ( UnitIsPartyLeader(unit) ) then
					PreformAVEnabler_RaidLeader = name;
				end

				PreformAVEnabler_Members[i] = { name = name, online = online };
				if ( not PreformAVEnabler_Status[name] ) then
					PreformAVEnabler_CreateStatus(name);
				end
			end
		end

		-- player
		name = UnitName("player");
		online = UnitIsConnected("player");
		if ( UnitIsPartyLeader("player") ) then
			PreformAVEnabler_RaidLeader = name;
		end
		table.insert(PreformAVEnabler_Members, { name = name, online = online });
		if ( not PreformAVEnabler_Status[name] ) then
			PreformAVEnabler_CreateStatus(name);
		end

	else

		-- Raid
		for i=1, MAX_RAID_MEMBERS do
			name, _, _, _, _, _, _, online = GetRaidRosterInfo(i);
			if ( name ) then
				if ( UnitIsPartyLeader("raid"..i) ) then
					PreformAVEnabler_RaidLeader = name;
				end

				PreformAVEnabler_Members[i] = { name = name, online = online };
				if ( not PreformAVEnabler_Status[name] ) then
					PreformAVEnabler_CreateStatus(name);
				end
			end
		end

	end

	PreformAVEnabler_SetMemberFramesPending = true;
	PreformAVEnabler_SetMemberFrames();

	-- set widgets if group/raid disbanded (members == 1)
	-- or if thresholder slider visible and player is not leader
	-- or is threshold slider not visible and player leader
	-- bit of a kludge, but I don't want to call SetWidets unnecessarily
	if (	#PreformAVEnabler_Members == 1 
		or (PreformAVEnablerThresholdSlider:IsShown() and PreformAVEnabler_RaidLeader ~= UnitName("player") ) 
		or (not PreformAVEnablerThresholdSlider:IsShown() and PreformAVEnabler_RaidLeader == UnitName("player") ) 
	) then
		PreformAVEnabler_SetWidgets();
		PreformAVEnabler_CheckBMs();
	end

	-- 1 == have member data but never requested status before.  2 == have member data and have requested data before
	if ( PreformAVEnabler_NeverUpdated ~= 2 ) then
		PreformAVEnabler_NeverUpdated = 1;
	end

	-- send status if new to the group
	if ( PreformAVEnabler_NewGroup ) then
		PreformAVEnabler_SendStatus();
	end

	-- if player is newly deserter (check put here because PLAYER_ENTERING_WORLD seems to fire before client gets the icon
	-- and if members > 1.  There is a period of time after a player zones out of a BG that the game considers him out of a group/raid before rejoining it
	if ( PreformAVEnabler_MyStatus.deserter == 0 and PreformAVEnabler_CheckDeserter() > 0 and #PreformAVEnabler_Members > 1 ) then
		PreformAVEnabler_SendStatus();
	end

	PreformAVEnabler_NewGroup = false;

	PreformAVEnabler_Update();
end

function PreformAVEnabler_CheckDeserter()
	local name, timeLeft;

	for i=1, MAX_PARTY_DEBUFFS do
		--  name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitDebuff("unit", [index] or ["name", "rank"]) 
		name, _, _, _, _, _, timeLeft = UnitDebuff("player", i);
		if ( name == PREFORM_AV_ENABLER_DESERTER ) then
			return math.ceil( timeLeft - GetTime() );
		end
	end

	return 0;
end

function PreformAVEnabler_Update()

	if ( not PreformAVEnablerFrame:IsVisible() ) then
		return
	end

	local i, j, k, fontStr, name, status, deserterTime;

	i = 0;
	for _, member in ipairs( PreformAVEnabler_Members ) do
		i = i + 1;
		fontStr = getglobal("PreformAVEnablerMember"..i);

		name = member.name;
		status = PreformAVEnabler_Status[name];

		fontStr = getglobal("PreformAVEnablerMember"..i.."NameText")
		fontStr:SetText(name);
		fontStr:SetTextColor(1, .82, 0);

		if ( not member.online ) then
			getglobal("PreformAVEnablerMember"..i.."FrameText"):SetText(PLAYER_OFFLINE);
			getglobal("PreformAVEnablerMember"..i.."NameText"):SetTextColor(.5, .5, .5);
			getglobal("PreformAVEnablerMember"..i.."FrameText"):SetTextColor(.5, .5, .5);

			for j = 1, NUM_BGS do
				getglobal("PreformAVEnablerMember"..i.."StatusText"..j):SetText("");
				getglobal("PreformAVEnablerMember"..i.."IdText"..j):SetText("");
			end
			getglobal("PreformAVEnablerMember"..i.."VersionText"):SetText("");

		elseif ( status.version == -1 ) then
			fontStr = getglobal("PreformAVEnablerMember"..i.."VersionText");
			fontStr:SetText("");
			fontStr:SetTextColor(.5, .5, .5);

			fontStr = getglobal("PreformAVEnablerMember"..i.."FrameText");
			fontStr:SetText(PREFORM_AV_ENABLER_NOTINSTALLED);
			fontStr:SetTextColor(.5, .5, .5);

			for j = 1, NUM_BGS do
				getglobal("PreformAVEnablerMember"..i.."StatusText"..j):SetText("");
				getglobal("PreformAVEnablerMember"..i.."IdText"..j):SetText("");
			end

			getglobal("PreformAVEnablerMember"..i.."NameText"):SetTextColor(.8, .62, 0);
		else
			fontStr = getglobal("PreformAVEnablerMember"..i.."VersionText");
			if ( status.version == 1 ) then
				fontStr:SetText("1.0");
			elseif ( status.version == 2 ) then
				fontStr:SetText("2.0");
			else
				fontStr:SetText(status.version);
			end
			if ( status.version < PreformAVEnabler_Version ) then
				fontStr:SetTextColor(.8, .4, .4);
			else
				fontStr:SetTextColor(.8, .8, .8);
			end

			fontStr = getglobal("PreformAVEnablerMember"..i.."FrameText");
			if ( status.frame > 0 ) then
				fontStr:SetText(BG_ABR_NAME[status.frame]);
				fontStr:SetTextColor(.1, 1, .1);
			else
				fontStr:SetText(PREFORM_AV_ENABLER_CLOSED);
				fontStr:SetTextColor(1, .1, .1);
			end

			for j = 1, NUM_BGS do
				if ( not PreformAVEnabler_HideColumn[j] ) then

					fontStr = getglobal("PreformAVEnablerMember"..i.."StatusText"..j);
					if ( status[j].status == 1 ) then
						fontStr:SetText(PREFORM_AV_ENABLER_QUEUED);
						fontStr:SetTextColor(.1, 1, 1);
					elseif ( status[j].status == 2 ) then
						fontStr:SetText(PREFORM_AV_ENABLER_CONFIRM);
						fontStr:SetTextColor(1, 1, .1);
					elseif ( status[j].status == 3 ) then
						fontStr:SetText(PREFORM_AV_ENABLER_INSIDE);
						fontStr:SetTextColor(1, 1, 1);
					else
						fontStr:SetText("");
					end

					fontStr = getglobal("PreformAVEnablerMember"..i.."IdText"..j);
					if ( status[j].id > 0 ) then
						fontStr:SetText(status[j].id);
						if ( status[j].status >= 4 ) then
							fontStr:SetTextColor(.5, .5, .5);
						else
							fontStr:SetTextColor(1, 1, 0);
						end
					else
						if ( status[j].status == 1 ) then
							fontStr:SetText(PREFORM_AV_ENABLER_FIRSTAVAIL);
							fontStr:SetTextColor(1, 1, 1);
						else
							fontStr:SetText("");
						end
					end

					if ( status[j].status == 0 ) then
						fontStr:SetText("");
					end
				end
			end

			fontStr = getglobal("PreformAVEnablerMember"..i.."FrameText");
			if ( status.deserter > 0 ) then

				if ( status.deserter > GetTime() ) then
					deserterTime = status.deserter - GetTime();
					fontStr:SetFormattedText(SecondsToTimeAbbrev(deserterTime));
					fontStr:SetTextColor(1, .1, .1);

					getglobal("PreformAVEnablerMember"..i.."NameText"):SetTextColor(1, .1, .1);
				else
					status.deserter = 0;
					getglobal("PreformAVEnablerMember"..i.."NameText"):SetTextColor(1, .82, 0);
				end
			end

		end -- if online
	end -- for member in

	-- blank out the rest
	--[[
	for j = (i + 1), 40 do
		getglobal("PreformAVEnablerMember"..j.."NameText"):SetText("");
		getglobal("PreformAVEnablerMember"..j.."FrameText"):SetText("");
		getglobal("PreformAVEnablerMember"..j.."VersionText"):SetText("");

		for k = 1, NUM_BGS do
			getglobal("PreformAVEnablerMember"..j.."StatusText"..k):SetText("");
			getglobal("PreformAVEnablerMember"..j.."IdText"..k):SetText("");
		end
	end
	]]

	-- Majority text
	for i = 1, NUM_BGS do
		local majorityBG, majorityPop, _, _, queuedPeople, people = PreformAVEnabler_Tally(i);
		fontStr = getglobal("PreformAVEnablerMajorityText"..i);
		if ( majorityBG == 0 ) then
			if ( queuedPeople == 0 ) then
				fontStr:SetText("");
			else
				fontStr:SetText(PREFORM_AV_ENABLER_QUEUED..": "..queuedPeople);
				fontStr:SetTextColor(.1, 1, 1);
			end
		else
			fontStr:SetText(PREFORM_AV_ENABLER_CONFIRM.." "..majorityBG..": "..majorityPop);
			fontStr:SetTextColor(1, 1, .1);
		end
	end

	if ( #PreformAVEnabler_Members == 1 ) then
		PreformAVEnablerMember1FrameText:SetText(ERR_QUEST_PUSH_NOT_IN_PARTY_S);
		PreformAVEnablerMember1FrameText:SetTextColor(.5, .5, .5);
	end
end

function PreformAVEnablerFrameStatusButton_OnClick()
	-- prevent spam clicking
	if ( PreformAVEnabler_LastCheck < GetTime() ) then
		SendAddonMessage("PreformAVEnabler", "statuscheck", "RAID");
		PreformAVEnabler_LastCheck = GetTime() + 5;
	end
end

function PreformAVEnablerFrameLeaveButton_OnClick(self)

	local bg = self:GetID();

	if ( bg == PreformAVEnabler_AutomateBG ) then
		PreformAVEnabler_WaitUntilReady = true;				-- so automate doesn't try to get people to join games until ready
	end

	if ( bg == BG_ID[PREFORM_AV_ENABLER_AV] ) then
		SendAddonMessage("PreformAVEnabler", "leavequeue", "RAID");
	else
		SendAddonMessage("PreformAVEnabler", "leavequeue,"..bg, "RAID");
	end


	local status, id, qid = PreformAVEnabler_BGStatus(bg);

	if ( status == "confirm" or status == "queued" ) then
		AcceptBattlefieldPort(qid);
	end
end

function PreformAVEnablerCmdLine(param)
	if ( param == "debug" ) then
		if ( PreformAVEnabler_Debug ) then
			PreformAVEnabler_Debug = false;
			DEFAULT_CHAT_FRAME:AddMessage("Debug mode off");
		else
			PreformAVEnabler_Debug = true;
			DEFAULT_CHAT_FRAME:AddMessage("Debug mode on");
		end

	elseif ( param == "reset" ) then
		PreformAVEnablerFrame:ClearAllPoints();
		PreformAVEnablerFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -25, -25);

	else
		PreformAVEnabler_ShowMasterFrame();
	end
end

function PreformAVEnablerJoinButton_OnClick(self)

	local bg = self:GetID();

	local majorityBG = PreformAVEnabler_Tally(bg);
	if ( majorityBG > 0 ) then
		if ( self:GetID() == BG_ID[PREFORM_AV_ENABLER_AV] ) then
			SendAddonMessage("PreformAVEnabler", "join,"..majorityBG, "RAID");
		else
			SendAddonMessage("PreformAVEnabler", "enter,"..bg..","..majorityBG, "RAID");
		end
	end

	local status, id, qid = PreformAVEnabler_BGStatus(bg);

	if ( status == "confirm" ) then
		if ( id == majorityBG ) then
			AcceptBattlefieldPort(qid, 1);
--print("AcceptBattlefieldPort("..qid..", 1)");
		else
			AcceptBattlefieldPort(qid);
			PreformAVEnabler_Queue(bg, majorityBG);
		end
	end
end

function PreformAVEnablerAutomateCheckButton_OnClick(self)
	if (self:GetChecked()) then
		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage(" -- Automate checked for bg "..self:GetID(), 0, 1, 1);
		end

		PreformAVEnabler_Automating = true;
		PreformAVEnabler_AutomateBG = self:GetID();
		PreformAVEnabler_WaitUntilReady = false;
		PreformAVEnabler_Leader();

		for i = 1, NUM_BGS do
			if ( i ~= self:GetID() ) then
				getglobal("PreformAVEnablerAutomateCheckButton"..i):SetChecked(nil);
			end
		end
	else
		if ( PreformAVEnabler_Debug ) then
			DEFAULT_CHAT_FRAME:AddMessage(" -- Automate disengaged", 0, 1, 1);
		end
		PreformAVEnabler_Automating = false;
		PreformAVEnabler_AutomateBG = 0;
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function PreformAVEnabler_ResizeFrame()
	local members = #PreformAVEnabler_Members;
	if ( members < 1 ) then
		members = 1;
	end

	local padding = 115;
	if ( IsRaidLeader() or IsPartyLeader() ) then
		padding = 190;
	end

	local height = members * 15 + padding;
	if ( PreformAVEnabler_SizeLimit and height > PreformAVEnabler_SizeLimit ) then
		PreformAVEnablerFrame:SetHeight(PreformAVEnabler_SizeLimit);
		PreformAVEnablerMembersScrollFrame:SetHeight(PreformAVEnabler_SizeLimit - padding + 4);
	else
		PreformAVEnablerFrame:SetHeight(height);
		PreformAVEnablerMembersScrollFrame:SetHeight(height - padding + 4);
	end

	height = 604 - (15 * (40 - members));
	PreformAVEnablerMembersScrollFrameChildFrame:SetHeight(height);

	if ( (IsRaidLeader() or IsPartyLeader()) ) then
		PreformAVEnablerMajorityText1:SetPoint("BOTTOMLEFT", PreformAVEnablerFrame, "BOTTOMLEFT", 140, 130);
	else
		PreformAVEnablerMajorityText1:SetPoint("BOTTOMLEFT", PreformAVEnablerFrame, "BOTTOMLEFT", 140, 57);
	end
end

function PreformAVEnablerHideButton_OnClick(button, id)
	if ( PreformAVEnabler_IfSecure() ) then
		return
	end
	if ( not id ) then
		id = button:GetID();
		PlaySound("igCharacterInfoTab");
	end

	if ( PreformAVEnabler_HideColumn[id] ) then
		PreformAVEnabler_HideColumn[id] = false;
		button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
		button:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down");
		button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight");

		for i = 1, 40 do
			getglobal("PreformAVEnablerMember"..i.."StatusText"..id):SetWidth(55);
			getglobal("PreformAVEnablerMember"..i.."IdText"..id):SetWidth(70);
		end

		getglobal("PreformAVEnablerHeaderText"..id):SetWidth(125);
		getglobal("PreformAVEnablerMajorityText"..id):SetWidth(125);
		getglobal("PreformAVEnablerHeaderText"..id):SetText(BG_NAME[id]);

		getglobal("PreformAVEnablerMajorityText"..id):Show();

		PreformAVEnabler_Update();
	else
		PreformAVEnabler_HideColumn[id] = true;
		button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
		button:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down");
		button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight");

		for i = 1, 40 do
			getglobal("PreformAVEnablerMember"..i.."StatusText"..id):SetWidth(16);
			getglobal("PreformAVEnablerMember"..i.."IdText"..id):SetWidth(1);
			getglobal("PreformAVEnablerMember"..i.."StatusText"..id):SetText("");
			getglobal("PreformAVEnablerMember"..i.."IdText"..id):SetText("");
		end

		getglobal("PreformAVEnablerHeaderText"..id):SetWidth(17);
		getglobal("PreformAVEnablerMajorityText"..id):SetWidth(17);
		getglobal("PreformAVEnablerHeaderText"..id):SetText("");
		getglobal("PreformAVEnablerMajorityText"..id):SetText("");

		getglobal("PreformAVEnablerMajorityText"..id):Hide();
	end

	PreformAVEnabler_SetWidgets();

	local x = 0;
	-- determine how many columns are hidden to calculate frame width
	for i = 1, NUM_BGS do
		if ( PreformAVEnabler_HideColumn[i] ) then
			x = x + 1;
		end
	end

	local baseWidth = 945;

	-- set width of master, scroll, and scroll child frames
	PreformAVEnablerFrame:SetWidth(baseWidth - (x * 108));
	PreformAVEnablerMembersScrollFrame:SetWidth(baseWidth - 30 - (x * 108));
	PreformAVEnablerMembersScrollFrameChildFrame:SetWidth(baseWidth - 15 - (x * 108));

	-- set width of member frames
	for i = 1, 40 do
		getglobal("PreformAVEnablerMember"..i):SetWidth(baseWidth - 45 - (x * 108));
	end
end

-- redraw every 10 seconds in case of deserter or anything that may need drawing
-- handle frame resizing if user is click dragging bottom of frame
function PreformAVEnablerFrame_OnUpdate(self, arg)
	PreformAVEnabler_OnUpdateTime = PreformAVEnabler_OnUpdateTime + arg;
	if ( PreformAVEnabler_OnUpdateTime > 10 ) then
		PreformAVEnabler_OnUpdateTime = 0;
		PreformAVEnabler_Update();
	end

	if ( self.isResizing ) then
		local _, pos = GetCursorPosition();
		pos = math.floor(pos);

		local h;
		local diff = pos - self.startPos;
		if ( diff == 0 ) then
			return
		end

		h = self.startHeight - diff;
		local members = #PreformAVEnabler_Members;
		if ( members < 5 ) then
			return
		end
		
		local padding = 115;
		if ( PreformAVEnabler_RaidLeader == UnitName("player") ) then
			padding = 190;
		end

		local min = 15 * 5 + padding - 2;
		local max = members * 15 + padding;
		
		if ( h < min ) then
			h = min;
		end
		if ( h >= max ) then
			h = max;
			PreformAVEnabler_SizeLimit = nil;
		else
			PreformAVEnabler_SizeLimit = h;
		end

		PreformAVEnablerFrame:SetHeight(h);
		PreformAVEnablerMembersScrollFrame:SetHeight(h - padding + 4);
	end
end

function PreformAVEnablerResizeButton_OnEnter()
	if ( (not issecure() or not InCombatLockdown()) and #PreformAVEnabler_Members > 5 ) then
		SetCursor("CAST_CURSOR");
	end
end

function PreformAVEnabler_FakeRaid(max)

	PreformAVEnabler_Members = {};
	PreformAVEnabler_Status = {};
	local name, online, i, j;

	if ( not max ) then
		max = 40;
	end

	--math.randomseed(time());
	j = math.floor(GetTime());
	for i = 1, j, 100 do
		random();
	end

	for i = 1, max do
		name = "Player"..i;
		if ( name ) then
			PreformAVEnabler_Members[i] = { name = name, online = 1 };
			if ( not PreformAVEnabler_Status[name] ) then
				PreformAVEnabler_Status[name] = {
					version = 2.33,			-- unknown / not installed
					frame = math.random(0, 4),
					deserter = 0,
				};
				for j = 1, NUM_BGS do
					PreformAVEnabler_Status[name][j] = { status = math.random(0, 3), id = math.random(0, 20) };
				end
			end
		end
	end

	if ( max >= 4 ) then
		PreformAVEnabler_Status["Player4"].deserter = GetTime() + 30;
	end
	if ( max >= 6 ) then
		PreformAVEnabler_Members[6].online = false;
	end
	if ( max >= 9 ) then
		PreformAVEnabler_Status["Player9"].version = -1;
	end

	PreformAVEnabler_SetMemberFramesPending = true;
	PreformAVEnabler_SetMemberFrames();

	-- raid member data loaded
	PreformAVEnabler_NeverUpdated = 1;

	PreformAVEnabler_NewGroup = false;

	PreformAVEnabler_Update();
end

-- only way I can get a screenshot with a large number of people
--[[
function PreformAVEnabler_Screenshot()

	PreformAVEnabler_Members = {};
	PreformAVEnabler_Status = {};
	local name, online, i, j;
	local names = {
		"Torrid",
		"Torec",
		"Torvie",
		"Coryz",
		"Rodion",
		"Skimm",
		"Lowbal",
		"Censura",
		"Amaryn",
		"Vitash",
		"Hobb",
		"Xate",
		"Mbp",
		"Sirensa",
		"Sylvos",
	};

	for i = 1, 15 do
		name = names[i];
		if ( name ) then
			PreformAVEnabler_Members[i] = { name = name, online = 1 };
			if ( not PreformAVEnabler_Status[name] ) then
				PreformAVEnabler_Status[name] = {
					version = 2.1,			-- unknown / not installed
					frame = 1,
					deserter = 0,
				};
				PreformAVEnabler_Status[name][1] = { status = 2, id = 7 };
				PreformAVEnabler_Status[name][2] = { status = 0, id = 0 };
				PreformAVEnabler_Status[name][3] = { status = 1, id = 0 };
				PreformAVEnabler_Status[name][4] = { status = 1, id = 0 };
			end
		end
	end

	PreformAVEnabler_Status["Torec"].deserter = GetTime() + 300;
	PreformAVEnabler_Status["Torec"][1].status = 0;
	PreformAVEnabler_Status["Torec"][1].id = 0;
	PreformAVEnabler_Status["Torec"][3].status = 0;
	PreformAVEnabler_Status["Torec"][3].id = 0;
	PreformAVEnabler_Status["Torec"][4].status = 0;
	PreformAVEnabler_Status["Torec"][4].id = 0;

	PreformAVEnabler_Members[11].online = false;
	PreformAVEnabler_Status["Sylvos"].version = -1;
	PreformAVEnabler_Status["Lowbal"][2].status = 3;
	PreformAVEnabler_Status["Lowbal"][2].id = 19;
	PreformAVEnabler_Status["Lowbal"][4].status = 0;
	PreformAVEnabler_Status["Lowbal"][4].id = 0;
	PreformAVEnabler_Status["Lowbal"].frame = 0;

	PreformAVEnablerFrameQueueButton1:Enable();
	PreformAVEnablerFrameQueueButton2:Disable();
	PreformAVEnablerFrameQueueButton3:Disable();
	PreformAVEnablerFrameQueueButton4:Disable();

	PreformAVEnablerFrameLeaveButton1:Enable();
	PreformAVEnablerFrameLeaveButton2:Disable();
	PreformAVEnablerFrameLeaveButton3:Enable();
	PreformAVEnablerFrameLeaveButton4:Enable();

	PreformAVEnablerFrameJoinButton1:Enable();
	PreformAVEnablerFrameJoinButton2:Disable();
	PreformAVEnablerFrameJoinButton3:Disable();
	PreformAVEnablerFrameJoinButton4:Disable();

	for i = 1, 40 do
		if ( PreformAVEnabler_Members[i] ) then
			getglobal("PreformAVEnablerMember"..i):Show();
		else
			getglobal("PreformAVEnablerMember"..i):Hide();
		end
	end

	-- raid member data loaded
	PreformAVEnabler_NeverUpdated = 1;

	PreformAVEnabler_NewGroup = false;

	PreformAVEnabler_ResizeFrame();
	PreformAVEnabler_Update();
end
]]

function PreformAVEnabler_ShowLeader()
	DEFAULT_CHAT_FRAME:AddMessage(PreformAVEnabler_RaidLeader);
end

function PreformAVEnabler_MiniMapButton()
	if ( arg1 == "RightButton" ) then
		local info;

		info = UIDropDownMenu_CreateInfo();
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);

		info = UIDropDownMenu_CreateInfo();
		info.text = PREFORM_AV_ENABLER_PREFORM;
		info.func = PreformAVEnabler_ShowMasterFrame;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
end

function PreformAVEnabler_ShowMasterFrame()
	if ( PreformAVEnabler_IfSecure() ) then
		return
	end

	PreformAVEnablerFrame:Show();
end

function PreformAVEnablerMenu()
	ToggleDropDownMenu(1, nil, PreformAVEnablerDropDown, "cursor", 0, 0);
end

--[[
function PreformAVEnablerMemberButton_OnLoad(self)
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	SecureUnitButton_OnLoad(self, "raid"..self:GetParent():GetID(), PreformAVEnablerMenu);
end
]]
function PreformAVEnablerMemberButton_OnLoad(self)
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	SecureUnitButton_OnLoad(self, "raid"..self:GetParent():GetID(), PreformAVEnablerMenu);
end

function PreformAVEnablerDropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, PreformAVEnablerDropDown_Initialize, "MENU");
end

function PreformAVEnablerDropDown_Initialize(self)
	local menu;
	local name;
	local id = self:GetParent():GetID();
	local unit = "raid"..id;

	if ( UnitIsUnit(unit, "player") ) then
		menu = "SELF";
	elseif ( UnitIsPlayer(unit) ) then
		id = UnitInRaid(unit);
		if ( id ) then
			menu = "RAID";
			name = GetRaidRosterInfo(id +1);
		elseif ( UnitInParty(unit) ) then
			menu = "PARTY";
		end
	end
	if ( menu ) then
		UnitPopup_ShowMenu(PreformAVEnablerDropDown, menu, unit, name, id);
	end
end

function PreformAVEnablerButtonize_OnClick(self)
	if ( self:GetChecked() ) then
		if ( not PreformAVEnablerMember1Button ) then

			if ( InCombatLockdown() ) then

				-- can't create buttons in combat
				self:SetChecked(nil);
				PlaySoundFile("sound\\interface\\Error.wav");
				UIErrorsFrame:AddMessage( ERR_NOT_IN_COMBAT, 1.0, 0.1, 0.1, 1.0 );
				return

			else

				-- not in combat, create buttons

				PreformAVEnabler_Buttonize = true;

				local f, t;

				for i = 1, 40 do

					f = CreateFrame("Button", "PreformAVEnablerMember"..i.."Button", getglobal("PreformAVEnablerMember"..i), "SecureUnitButtonTemplate");
					f:SetPoint("TOPLEFT", 0, 0);
					f:SetWidth(75);
					f:SetHeight(15);
					f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
					f:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					SecureUnitButton_OnLoad(f, "raid"..f:GetParent():GetID(), PreformAVEnablerMenu);
				end
			end
		else
			-- buttons already created
			PreformAVEnabler_Buttonize = true;
		end
	else
		PreformAVEnabler_Buttonize = false;
	end
end

function PreformAVEnabler_IfSecure()
	if ( PreformAVEnablerMember1Button and InCombatLockdown() ) then
		PlaySoundFile("sound\\interface\\Error.wav");
		UIErrorsFrame:AddMessage( ERR_NOT_IN_COMBAT, 1.0, 0.1, 0.1, 1.0 );
		return true
	end
end