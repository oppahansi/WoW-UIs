
--[[

TargetButtons

author: QuippeR		<quipper@gmail.com>

Adds buttons to the targeting frame when a player is selected.

Feel free to contact me if you've got questions, comments, requests or 
additions.

Use /tboptions and read the readme please!


]]--


----------------------------------------------------------
--	Don't change code unless you know what you do!
----------------------------------------------------------

TB_Vars = {};

	-- First run? Set defaults
function TB_WipeOut()
	TB_Vars = {

		Buttons = {			-- buttons states
		 { enabled = 1 , x = 1, y = 1, size = 24, button = "InviteButton", second = "PromoteButton" },	-- invite
		 { enabled = 1 , x = 1, y = 1, size = 24, button = "FollowButton", second = nil },		-- follow
		 { enabled = 1 , x = 1, y = 1, size = 24, button = "TradeButton", second = nil },		-- trade
		 { enabled = 1 , x = 1, y = 1, size = 24, button = "WhisperButton", second = nil },		-- whisper
		 { enabled = 1 , x = 1, y = 1, size = 24, button = "DuelButton", second = nil },		-- duel
		 { enabled = 1 , x = 1, y = 1, size = 24, button = "InspectButton", second = nil }		-- inspect
		},
		
		MODE = 1;		-- Layout mode --> 1=classical, 2=left-to-right, 3=right-to-left, 4=free
		TF = "TargetFrame";	-- target frame name
		XOFFSET = 0;		-- global offsets
		YOFFSET = 0;
		DISTANCE = 30;		-- distance between buttons in l-t-r an l-t-r layout
		GLOBAL_SIZE = 24;	-- global size
		USE_GLOBALSIZE = true;	-- use global size
	};
end

TB_WipeOut();

	-- Set variables for running
TB_BUTTON_LIST = {
	{ name = TARGETBUTTONS_INVITE_TT,		capname = "INVITE"},
	{ name = TARGETBUTTONS_FOLLOW_TT,		capname = "FOLLOW" },
	{ name = TARGETBUTTONS_TRADE_TT,		capname = "TRADE" },
	{ name = TARGETBUTTONS_WHISPER_TT,		capname = "WHISPER" },
	{ name = TARGETBUTTONS_DUEL_TT,			capname = "DUEL" },
	{ name = TARGETBUTTONS_INSPECT_TT,		capname = "INSPECT" }
};

TB_LAYOUT_LIST = {
	{ name = TARGETBUTTONS_CLASSICMODE,		options = 0 },
	{ name = TARGETBUTTONS_LEFTTORIGHT,		options = 1 },
	{ name = TARGETBUTTONS_RIGHTTOLEFT,		options = 1 },
	{ name = TARGETBUTTONS_FREEMODE,		options = 0 }
};




--initialize
function TargetButtons_Initialize()
	SlashCmdList["TBOPTIONS"] = Toggle_Options;
	SLASH_TBOPTIONS1 = "/tbopt";
	SLASH_TBOPTIONS2 = "/tboptions";

	UIErrorsFrame:AddMessage(TARGETBUTTONS_INIT_TEXT, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

	if (BINDING_NAME_GOODINSPECT ~= nil or BINDING_NAME_SUPERINSPECT ~= nil) then
		TB_GOODINSP_RECOGNIZED = true;
	else
		TB_GOODINSP_RECOGNIZED = false;
	end


	if (Cosmos_RegisterConfiguration) then
		Register_Cosmos();
	end

	UIPanelWindows["TBOptionsFrame"] = { area = "center", pushable = 0 };

	if(myAddOnsFrame) then
		myAddOnsList.TargetButtons = {
			name = TARGETBUTTONS_NAME,
			description = TARGETBUTTONS_HEADER,
			version = TARGETBUTTONS_VERSION,
			category = MYADDONS_CATEGORY_OTHERS,
			frame = "TargetButtonsFrame",
			optionsframe = "TBOptionsFrame"
		};
	end
	
	-- reset defaults if earlier version was 0.291 or older
	if (TB_Vars.INVITE_ENABLED) then
		TB_WipeOut();
	end

	 TBOptions_OnLoad();

end



--update button visibility
function Button_Redraw()

	PFrame = getglobal(TB_Vars.TF);	--get the parent frame by name

	for i = 1, 6, 1 do
	  --	Hiding buttons until they are in place
		(getglobal(TB_Vars.Buttons[i].button)):Hide();
		if(getglobal(TB_Vars.Buttons[i].second)) then
			(getglobal(TB_Vars.Buttons[i].second)):Hide();
		end

	  --	Set button sizes
		if (TB_Vars.USE_GLOBALSIZE) then
			(getglobal(TB_Vars.Buttons[i].button)):SetWidth( TB_Vars.GLOBAL_SIZE );
			(getglobal(TB_Vars.Buttons[i].button)):SetHeight( TB_Vars.GLOBAL_SIZE );

			if(getglobal(TB_Vars.Buttons[i].second)) then
				(getglobal(TB_Vars.Buttons[i].second)):SetWidth( TB_Vars.GLOBAL_SIZE );
				(getglobal(TB_Vars.Buttons[i].second)):SetHeight( TB_Vars.GLOBAL_SIZE );
			end
		else
			(getglobal(TB_Vars.Buttons[i].button)):SetWidth( TB_Vars.Buttons[i].size );
			(getglobal(TB_Vars.Buttons[i].button)):SetHeight( TB_Vars.Buttons[i].size );

			if(getglobal(TB_Vars.Buttons[i].second)) then
				(getglobal(TB_Vars.Buttons[i].second)):SetWidth( TB_Vars.Buttons[i].size );
				(getglobal(TB_Vars.Buttons[i].second)):SetHeight( TB_Vars.Buttons[i].size );
			end
			
		end
	
	  --	Set scaling
		(getglobal(TB_Vars.Buttons[i].button)):SetScale(PFrame:GetScale());
		if(getglobal(TB_Vars.Buttons[i].second)) then
			(getglobal(TB_Vars.Buttons[i].second)):SetScale(PFrame:GetScale());
		end

	end
	--	Enabling invite button
	InviteButton:Enable();


	-- <<<-------------------------->>>
	--     Friendly player selected
	-- <<<-------------------------->>>
	if(UnitIsFriend("player","target") and UnitIsPlayer("target") and not UnitIsUnit("player","target")) then

	 -- Classical layout as seen in the first version of TargetButtons
	 if (TB_Vars.MODE == 1) then
		if (TB_Vars.Buttons[1].enabled == 1) then
			InviteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 5 + TB_Vars.XOFFSET, -25 + TB_Vars.YOFFSET);
			InviteButton:Show();
			InviteButton:Disable();
			if IsRaidLeader() or IsPartyLeader() then
				if UnitInRaid("target") or UnitInParty("target") then
					InviteButton:Hide();
					PromoteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 5 + TB_Vars.XOFFSET, -25 + TB_Vars.YOFFSET);
					PromoteButton:Show();
				end
			end
			if (GetNumPartyMembers()==0 and GetNumRaidMembers()==0) or IsRaidLeader() or IsPartyLeader() then
				InviteButton:Enable();
			end
		end

		if (TB_Vars.Buttons[2].enabled == 1) then
			--Floating button positioning
			if ((TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled) == 3) then
				FollowButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 25 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
			else 
				if ((TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled) == 2) then
					FollowButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 30 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
				else
					if ((TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled) == 1) then
						FollowButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 40 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					else
						FollowButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 65 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					end
				end
			end
			FollowButton:Show();
		end

		if (TB_Vars.Buttons[3].enabled == 1) then
			--Floating button positioning
			if (TB_Vars.Buttons[2].enabled == 1) then
				if(TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled == 2) then
					TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 51 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
				else
					if(TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled == 1) then
						TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 65 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					else
						TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 90 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					end
				end
			else
				if(TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled == 2) then
					TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 30 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
				else
					if(TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled == 1) then
						TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 40 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					else
						TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 65 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					end
				end
			end
			TradeButton:Show();
		end

		if (TB_Vars.Buttons[4].enabled == 1) then
			--Floating button positioning
			if (TB_Vars.Buttons[2].enabled + TB_Vars.Buttons[3].enabled == 2) then
				if(TB_Vars.Buttons[5].enabled == 1) then
					WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 79 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
				else
					WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 100 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
				end
			else
				if(TB_Vars.Buttons[2].enabled + TB_Vars.Buttons[3].enabled == 1) then
					if(TB_Vars.Buttons[5].enabled == 1) then
						WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 65 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					else
						WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 90 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					end
				else
					if(TB_Vars.Buttons[5].enabled == 1) then
	 					WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 40 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					else
						WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 65 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					end
				end
			end
			WhisperButton:Show();
		end

		if (TB_Vars.Buttons[5].enabled == 1) then
			--Floating button positioning
			if (TB_Vars.Buttons[2].enabled + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled == 3) then
				DuelButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 105 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
			else
				if (TB_Vars.Buttons[2].enabled + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled == 2) then
					DuelButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 100 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
				else
					if (TB_Vars.Buttons[2].enabled + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled == 1) then
						DuelButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 90 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					else
						DuelButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 65 + TB_Vars.XOFFSET, -13 + TB_Vars.YOFFSET);
					end
				end
			end
			DuelButton:Show();
		end

		if (TB_Vars.Buttons[6].enabled == 1) then
			getglobal(TB_Vars.Buttons[6].button):SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 125 + TB_Vars.XOFFSET, -25 + TB_Vars.YOFFSET);
			getglobal(TB_Vars.Buttons[6].button):Show();
		end

	 -- Left-to-right layout
	 elseif (TB_Vars.MODE == 2) then
		if (TB_Vars.Buttons[1].enabled == 1) then
			InviteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			InviteButton:Show();
			InviteButton:Disable();
			if (IsRaidLeader() or IsPartyLeader()) then
				if UnitInRaid("target") or UnitInParty("target") then
					InviteButton:Hide();
					PromoteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
					PromoteButton:Show();
				end
			end
			if (GetNumPartyMembers()==0 and GetNumRaidMembers()==0) or IsRaidLeader() or IsPartyLeader() then
				InviteButton:Enable();
			end
		end
		if (TB_Vars.Buttons[2].enabled == 1) then
			FollowButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + TB_Vars.Buttons[1].enabled*TB_Vars.DISTANCE  + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			FollowButton:Show();					
		end
		if (TB_Vars.Buttons[3].enabled == 1) then
			TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + (TB_Vars.Buttons[1].enabled + TB_Vars.Buttons[2].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			TradeButton:Show();					
		end
		if (TB_Vars.Buttons[4].enabled == 1) then
			WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + (TB_Vars.Buttons[1].enabled + TB_Vars.Buttons[2].enabled  + TB_Vars.Buttons[3].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			WhisperButton:Show();					
		end
		if (TB_Vars.Buttons[5].enabled == 1) then
			DuelButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + (TB_Vars.Buttons[1].enabled + TB_Vars.Buttons[2].enabled  + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			DuelButton:Show();					
		end
		if (TB_Vars.Buttons[6].enabled == 1) then
			InspectButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + (TB_Vars.Buttons[1].enabled + TB_Vars.Buttons[2].enabled  + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[5].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			InspectButton:Show();					
		end
	

	 -- Right-to-left layout	
	 elseif (TB_Vars.MODE == 3) then
		if (TB_Vars.Buttons[1].enabled == 1) then
			InviteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 - (TB_Vars.Buttons[6].enabled + TB_Vars.Buttons[5].enabled  + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[2].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			InviteButton:Show();
			InviteButton:Disable();
			if (IsRaidLeader()) then
				if UnitInRaid("target") or UnitInParty("target") then
					InviteButton:Hide();
					PromoteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 - (TB_Vars.Buttons[6].enabled + TB_Vars.Buttons[5].enabled  + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[2].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
					PromoteButton:Show();
				end
			end
			if (GetNumPartyMembers()==0 and GetNumRaidMembers()==0) or IsRaidLeader() or IsPartyLeader() then
				InviteButton:Enable();
			end
		end
		if (TB_Vars.Buttons[2].enabled == 1) then
			FollowButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 - (TB_Vars.Buttons[6].enabled + TB_Vars.Buttons[5].enabled  + TB_Vars.Buttons[4].enabled + TB_Vars.Buttons[3].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			FollowButton:Show();					
		end
		if (TB_Vars.Buttons[3].enabled == 1) then
			TradeButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 - (TB_Vars.Buttons[6].enabled + TB_Vars.Buttons[5].enabled  + TB_Vars.Buttons[4].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			TradeButton:Show();					
		end
		if (TB_Vars.Buttons[4].enabled == 1) then
			WhisperButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 - (TB_Vars.Buttons[6].enabled + TB_Vars.Buttons[5].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			WhisperButton:Show();					
		end
		if (TB_Vars.Buttons[5].enabled == 1) then
			DuelButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 - TB_Vars.Buttons[6].enabled*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			DuelButton:Show();					
		end
		if (TB_Vars.Buttons[6].enabled == 1) then
			InspectButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172 + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
			InspectButton:Show();					
		end

	 -- Free mode
	 else
		if (TB_Vars.Buttons[1].enabled == 1) then
			InviteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", TB_Vars.Buttons[1].x + TB_Vars.XOFFSET, TB_Vars.Buttons[1].y + TB_Vars.YOFFSET);
			InviteButton:Show();
			InviteButton:Disable();
			if (IsRaidLeader()) then
				if UnitInRaid("target") or UnitInParty("target") then
					InviteButton:Hide();
					PromoteButton:SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", TB_Vars.Buttons[1].x + TB_Vars.XOFFSET, TB_Vars.Buttons[1].y + TB_Vars.YOFFSET);
					PromoteButton:Show();
				end
			end
			if (GetNumPartyMembers()==0 and GetNumRaidMembers()==0) or IsRaidLeader() or IsPartyLeader() then
				InviteButton:Enable();
			end

		end
		for i = 2, 6, 1 do
			if (TB_Vars.Buttons[i].enabled == 1) then
				getglobal(TB_Vars.Buttons[i].button):SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", TB_Vars.Buttons[i].x + TB_Vars.XOFFSET, TB_Vars.Buttons[i].y + TB_Vars.YOFFSET);
				getglobal(TB_Vars.Buttons[i].button):Show();
			end
		end
	 end


	-- <<<----------------------->>>
	--     Enemy player selected
	-- <<<----------------------->>>
	elseif (UnitIsPlayer("target") and not UnitIsUnit("player","target")) then
		if (TB_Vars.MODE == 1) then
			if (TB_Vars.Buttons[5].enabled == 1) then
				getglobal(TB_Vars.Buttons[5].button):SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 125 + TB_Vars.XOFFSET, -25 + TB_Vars.YOFFSET);
				getglobal(TB_Vars.Buttons[5].button):Show();
			end
		end

		if (TB_Vars.MODE == 2) then
			if (TB_Vars.Buttons[5].enabled == 1) then
				getglobal(TB_Vars.Buttons[5].button):SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 24 + (TB_Vars.Buttons[1].enabled + TB_Vars.Buttons[2].enabled  + TB_Vars.Buttons[3].enabled + TB_Vars.Buttons[4].enabled)*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
				getglobal(TB_Vars.Buttons[5].button):Show();
			end
		end

		if (TB_Vars.MODE == 3) then
			if (TB_Vars.Buttons[5].enabled == 1) then
				getglobal(TB_Vars.Buttons[5].button):SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", 172- TB_Vars.Buttons[6].enabled*TB_Vars.DISTANCE + TB_Vars.XOFFSET, 2 + TB_Vars.YOFFSET);
				getglobal(TB_Vars.Buttons[5].button):Show();
			end
		end

		if (TB_Vars.MODE == 4) then
			if (TB_Vars.Buttons[5].enabled == 1) then
				getglobal(TB_Vars.Buttons[5].button):SetPoint("CENTER", TB_Vars.TF, "TOPLEFT", TB_Vars.Buttons[5].x + TB_Vars.XOFFSET, TB_Vars.Buttons[5].y + TB_Vars.YOFFSET);
				getglobal(TB_Vars.Buttons[5].button):Show();
			end
		end


	end
end

function TB_CheckRange()
	if CheckInteractDistance("target",1) then
		InspectButton:Enable();
		TradeButton:Enable();
		DuelButton:Enable();
		if ( UnitIsDeadOrGhost("player") or UnitIsDeadOrGhost("target") ) then
			TradeButton:Disable();
			DuelButton:Disable();
		end
		FollowButton:Enable();
		if ( UnitIsDead("player") ) then
			FollowButton:Disable();
		end
	elseif CheckInteractDistance("target",3) then
		if (not TB_GOODINSP_RECOGNIZED) then
			InspectButton:Disable();
		end
		DuelButton:Enable();
		TradeButton:Enable();
		if ( UnitIsDeadOrGhost("player") or UnitIsDeadOrGhost("target") ) then
			TradeButton:Disable();
			DuelButton:Disable();
		end
		FollowButton:Enable();
		if ( UnitIsDead("player") ) then
			FollowButton:Disable();
		end
	elseif CheckInteractDistance("target",2) then
		if (not TB_GOODINSP_RECOGNIZED) then
			InspectButton:Disable();
		end
		TradeButton:Enable();
		DuelButton:Disable();
		if ( UnitIsDeadOrGhost("player") or UnitIsDeadOrGhost("target") ) then
			TradeButton:Disable();
		end
		FollowButton:Enable();
		if ( UnitIsDead("player") ) then
			FollowButton:Disable();
		end
	elseif CheckInteractDistance("target",4) then
		if (not TB_GOODINSP_RECOGNIZED) then
			InspectButton:Disable();
		end
		TradeButton:Disable();
		DuelButton:Disable();
		FollowButton:Enable();
		if ( UnitIsDead("player") ) then
			FollowButton:Disable();
		end
	else
		if (not TB_GOODINSP_RECOGNIZED) then
			InspectButton:Disable();
		end
		TradeButton:Disable();
		DuelButton:Disable();
		FollowButton:Disable();
	end
end

function Toggle_Button()
	local currentID = UIDropDownMenu_GetSelectedID(TB_SelectButton);
	TB_Vars.Buttons[currentID].enabled = 1 - TB_Vars.Buttons[currentID].enabled;
	Button_Redraw();
end

--Invite button procedures
function Invite_onClick()
	InviteToParty("target");
end


function Promote_onClick()
--	if GetNumRaidMembers() > 0 then
--		PromoteToAssistant(UnitName("target"));
--	else
		PromoteToPartyLeader("target");
--	end
	Button_Redraw();
end


--Follow button procedures
function Follow_onClick()
	FollowUnit("target");	
end


--Trade button procedures
function Trade_onClick()
	InitiateTrade("target");
end


--Whisper button procedures
function Whisper_onClick()
	ChatFrame_SendTell(UnitName("target"));
end


--Duel button procedures
function Duel_onClick()
	StartDuelUnit("target");
end


--Inspect button procedures
function Inspect_onClick()
	InspectUnit("target");
end



-------------------------------


function Toggle_GlobalSize()
	if (TB_Vars.USE_GLOBALSIZE) then
		TB_Vars.USE_GLOBALSIZE = nil;
	else
		TB_Vars.USE_GLOBALSIZE = true;
	end
	Button_Redraw();
end


function SelectButton_Initialize()
	local info;
	for i = 1, getn(TB_BUTTON_LIST), 1 do
		info = { };
		info.text = TB_BUTTON_LIST[i].name;
		info.func = SelectButton_onClick;
		UIDropDownMenu_AddButton(info);
	end
end


function SelectButton_onLoad()
	UIDropDownMenu_Initialize(TB_SelectButton, SelectButton_Initialize);
	UIDropDownMenu_SetSelectedID(TB_SelectButton, 1);
	UIDropDownMenu_SetWidth(140); 
end

function SelectButton_onClick()
	local oldID = UIDropDownMenu_GetSelectedID(TB_SelectButton);
	UIDropDownMenu_SetSelectedID(TB_SelectButton, this:GetID());
	if(oldID ~= this:GetID()) then
		ButtonOptions_Refresh();
	end
end

function ButtonOptions_Refresh()
	local currentID = UIDropDownMenu_GetSelectedID(TB_SelectButton);
	TB_ButtonVisible:SetChecked(TB_Vars.Buttons[currentID].enabled);
	TB_Slider_X:SetValue(TB_Vars.Buttons[currentID].x);
	TB_Slider_XValue:SetText(TB_Vars.Buttons[currentID].x);
	TB_Slider_Y:SetValue(TB_Vars.Buttons[currentID].y);
	TB_Slider_YValue:SetText(TB_Vars.Buttons[currentID].y);
	TB_Size:SetValue(TB_Vars.Buttons[currentID].size);
	TB_SizeValue:SetText(TB_Vars.Buttons[currentID].size);
end


function SelectLayout_Initialize()
	local info;
	for i = 1, getn(TB_LAYOUT_LIST), 1 do
		info = { };
		info.text = TB_LAYOUT_LIST[i].name;
		info.func = SelectLayout_onClick;
		UIDropDownMenu_AddButton(info);
	end
end


function SelectLayout_onLoad()
	UIDropDownMenu_Initialize(TB_SelectLayout, SelectLayout_Initialize);
	UIDropDownMenu_SetSelectedID(TB_SelectLayout, TB_Vars.MODE);
	UIDropDownMenu_SetWidth(220); 
end

function SelectLayout_onClick()
	local oldID = UIDropDownMenu_GetSelectedID(TB_SelectLayout);
	UIDropDownMenu_SetSelectedID(TB_SelectLayout, this:GetID());
	if(oldID ~= this:GetID()) then
		LayoutOptions_Refresh();
	end
end

function LayoutOptions_Refresh()
	local currentID = UIDropDownMenu_GetSelectedID(TB_SelectLayout);
	if (TB_LAYOUT_LIST[currentID].options == 1) then
		TB_NoLayoutOptions:Hide();
		TB_Slider_Dist:SetValue(TB_Vars.DISTANCE);
		TB_Slider_DistValue:SetText(TB_Vars.DISTANCE);
		TB_Slider_Dist:Show();
	else
		TB_Slider_Dist:Hide();
		TB_NoLayoutOptions:Show();
	end
	TB_Vars.MODE = currentID;
	Button_Redraw();
end


function ChangeOffset(name)
	local currentID = UIDropDownMenu_GetSelectedID(TB_SelectButton);
	(getglobal(name.."Value")):SetText((getglobal(name)):GetValue());
	if (name=="TB_Offset_X") then
		TB_Vars.XOFFSET = (getglobal(name)):GetValue();
	elseif (name=="TB_Offset_Y") then
		TB_Vars.YOFFSET = (getglobal(name)):GetValue();
	elseif (name=="TB_Slider_X") then
		TB_Vars.Buttons[currentID].x = (getglobal(name)):GetValue();
	elseif (name=="TB_Slider_Y") then
		TB_Vars.Buttons[currentID].y = (getglobal(name)):GetValue();
	elseif (name=="TB_Size") then
		TB_Vars.Buttons[currentID].size = (getglobal(name)):GetValue();
	elseif (name=="TB_GlobalSize") then
		TB_Vars.GLOBAL_SIZE = (getglobal(name)):GetValue();
	elseif (name=="TB_Slider_Dist") then
		TB_Vars.DISTANCE = (getglobal(name)):GetValue();
	end
	Button_Redraw();
end

function Toggle_Options()
	if (TBOptionsFrame:IsVisible()) then
		HideUIPanel(TBOptionsFrame);
		if (MYADDONS_ACTIVE_OPTIONSFRAME == TBOptionsFrame) then
			ShowUIPanel(myAddOnsFrame);
		end
	else
		ShowUIPanel(TBOptionsFrame);
	end
end


function SetTargetFrameClicked()
	local hovered;
	local editbox = TB_TargetFrame_Edit;
	SetTargetFrame(editbox:GetText());

end

function SetTargetFrame(name)
	if getglobal(name) then
		TB_Vars.TF = name;
		Button_Redraw();
	else
		UIErrorsFrame:AddMessage(TARGETBUTTONS_NO_SUCH..name, 1.0, 0.2, 0.2, 1.0, UIERRORS_HOLD_TIME);
		TB_TargetFrame_Edit:SetText(TB_Vars.TF);
	end
end


function TBOptions_OnLoad()
	TB_TargetFrame_Edit:SetText(TB_Vars.TF);
	TB_Slider_X:SetMinMaxValues(-100,200);
	TB_Slider_X:SetValueStep(1);
	TB_Slider_Y:SetMinMaxValues(-100,200);
	TB_Slider_Y:SetValueStep(1);


	TB_Offset_X:SetMinMaxValues(-100,100);
	TB_Offset_X:SetValue(TB_Vars.XOFFSET);
	TB_Offset_X:SetValueStep(1);
	TB_Offset_Y:SetMinMaxValues(-100,100);
	TB_Offset_Y:SetValue(TB_Vars.YOFFSET);
	TB_Offset_Y:SetValueStep(1);

	TB_Size:SetMinMaxValues(16,32);
	TB_Size:SetValueStep(1);

	TB_Slider_Dist:SetMinMaxValues(15,45);
	TB_Slider_Dist:SetValue(TB_Vars.DISTANCE);
	TB_Slider_Dist:SetValueStep(1);

	TB_GlobalSize:SetMinMaxValues(16,32);
	TB_GlobalSize:SetValue(TB_Vars.GLOBAL_SIZE);
	TB_GlobalSize:SetValueStep(1);

	TB_UseGlobalSize:SetChecked(TB_Vars.USE_GLOBALSIZE);

	ButtonOptions_Refresh();
	UIDropDownMenu_SetSelectedID(TB_SelectLayout, TB_Vars.MODE);
	LayoutOptions_Refresh();


end

function TB_Reset()

	TB_WipeOut();
	UIDropDownMenu_SetSelectedID(TB_SelectLayout, TB_Vars.MODE);
	TBOptions_OnLoad();

end

--register TB in Cosmos (optional)
function Register_Cosmos()
	if (not TB_Cosmos_Registered) then

		Cosmos_RegisterButton (
			TARGETBUTTONS_NAMEVERSION,
			"",
			"",
			"Interface\\Icons\\Ability_Hunter_SniperShot",
			Toggle_Options,
			function()
				return true; -- The button is always enabled
			end
		);

	end
	TB_Cosmos_Registered = true;
end