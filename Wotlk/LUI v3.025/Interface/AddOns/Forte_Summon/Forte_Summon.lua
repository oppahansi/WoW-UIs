-- ForteXorcist v1.959.8 by Xus 13-04-2010
local FW = FW;
local FWL = FW.L;
local SU = FW:Module("Summon");
local RAID = FW.RAID;
local PARTY = FW.PARTY;
local NUM_SUMMONS = 10;

local Zone;
local SubZone;
local RealZone;
local Coordinates = FW:NEW2D();
local ActiveSummons = {};
local WorldMapRatio = 1.5;

local su = FW:NEW2D();

local NisFar = 0;
local Nis30y = 0;

local GetTime = GetTime;
local _G = _G;
local strfind = strfind;
local UnitName = FW.FullUnitName;

local summon = FW:SpellName(46546);
local meeting = FW:SpellName(23598);

local SORT_SUMMON_ORDER =	{6,3,4,1};
local SORT_SUMMON_ASC =		{true,true,false,true};

local SUMMON_PRIOR = {
	WHISPER = 1,
	NORMAL = 2,
	SUMMON = 3,
	IGNORE = 4,
};

--[[local INSTANCE_COORDS = {
	
};

function FW:Test() 
	FW:Show(Zone..";"..SubZone..";"..RealZone);
	--FW:Show(select(1,GetCursorPosition())..","..select(2,GetCursorPosition()));
	
end]]

local SUMMON_DISTANCE = {0.05,0.05,0.1,0.1}; -- the two old continents and outlands

local function SU_SummonShow(self,hide) -- with hide set, will force the frame to hide, even in 'combat'
	if InCombatLockdown() then return;end
	if FW.Settings.SummonEnable and not hide and FW.Saved.GROUPED and not WorldMapFrame:IsShown() then
		FWSUFrame:Show();
		FWSUBackground:Show();
		FWSUBackground:ClearAllPoints();
		
		
		FWSUFrame:SetWidth(FW.Settings.SummonWidth+2*FW.BORDER);
		FWSUBackground:SetWidth(FW.Settings.SummonWidth+2*FW.BORDER);
		FWSUFrame:SetScale(FW.Settings.FWSUFrame.scale);
		FWSUBackground:SetScale(FW.Settings.FWSUFrame.scale);
		
		FW:CorrectPosition(FWSUFrame);
		
		FWSUFrame:SetFrameStrata(FW.Settings.SummonStrata);
		FWSUBackground:SetFrameStrata(FW.Settings.SummonStrata);
		
		FWSUBackground:SetBackdropColor(unpack(FW.Settings.SummonBgColor));
		FWSUBackground:SetBackdropBorderColor(unpack(FW.Settings.SummonBgColor));
		
		FWSUFrameAmount:SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
		FWSUFrameInfo:SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
		
		local r,g,b = unpack(FW.Settings.SummonTextColor);
		for i=1,NUM_SUMMONS,1 do
			_G["FWSUBar"..i]:ClearAllPoints();
			
			_G["FWSUBar"..i.."Name"]:SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
			_G["FWSUBar"..i.."Info"]:SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
			
			_G["FWSUBar"..i]:SetWidth(FW.Settings.SummonWidth);
			_G["FWSUBar"..i]:SetHeight(FW.Settings.SummonHeight);
			_G["FWSUBar"..i.."NormalTexture"]:SetTexture(FW.Settings.SummonTexture);
			_G["FWSUBar"..i.."Name"]:SetTextColor(r,g,b);
			_G["FWSUBar"..i.."Info"]:SetTextColor(r,g,b);
		end
		if FW.Settings.SummonExpand then
			FWSUBackground:SetPoint("BOTTOMRIGHT", FWSUFrame, "BOTTOMRIGHT", 0, 0);
			FWSUBar1:SetPoint("BOTTOMLEFT", FWSUBackground, "BOTTOMLEFT", FW.BORDER, 18);
			
			for i=2,NUM_SUMMONS,1 do
				_G["FWSUBar"..i]:SetPoint("BOTTOMLEFT", _G["FWSUBar"..(i-1)], "TOPLEFT", 0, FW.Settings.SummonSpace);
			end
		else
			FWSUBackground:SetPoint("TOPLEFT", FWSUFrame, "TOPLEFT", 0, 0);
			FWSUBar1:SetPoint("TOPLEFT", FWSUBackground, "TOPLEFT", FW.BORDER, -18);
			
			for i=2,NUM_SUMMONS,1 do
				_G["FWSUBar"..i]:SetPoint("TOPLEFT", _G["FWSUBar"..(i-1)], "BOTTOMLEFT", 0, -FW.Settings.SummonSpace);
			end
		end
	else
		FWSUFrame:Hide();
		FWSUBackground:Hide();
	end
end


local function ColorVal(flag,prior)
	
	if flag == SUMMON_PRIOR.NORMAL then
		if prior > 1 then prior = 1; end
		return FW:MixColors(prior,FW.Settings.SummonCloseColor,FW.Settings.SummonFarColor);
	elseif flag == SUMMON_PRIOR.SUMMON then
		return unpack(FW.Settings.SummoningColor);
	elseif flag == SUMMON_PRIOR.WHISPER then
		return unpack(FW.Settings.WhisperColor);
	end
end

local function SU_DrawSummon()
	if not FWSUFrame:IsShown() then return; end
	su:sort(SORT_SUMMON_ORDER,SORT_SUMMON_ASC); -- sort viewable data, first by class, then by distance, last by name
	local n=0;
	local index=0;
	local Bar;
	for i=1, NUM_SUMMONS, 1 do
		local t1,t2,t4,t6,t7;
		Bar = _G["FWSUBar"..i];
		index = index+1;
		while index <= su.rows do
			t1,t2,_,t4,_,t6,t7 = unpack(su[index]);
			if t6 ~= SUMMON_PRIOR.IGNORE then break; else index=index+1 end
		end
		if FW.Settings.SummonDetails and i <= FW.Settings.SummonMax and index <= su.rows then
			
			local r,g,b = ColorVal(t6,t4);
			
			_G["FWSUBar"..i.."Name"]:SetText(t1);
			_G["FWSUBar"..i.."Info"]:SetText(t7);
			_G["FWSUBar"..i.."NormalTexture"]:SetVertexColor(r,g,b);
		
			if UnitIsUnit("target",t2) then
				Bar:SetAttribute("type1" ,"spell");
				Bar:SetAttribute("spell", summon);
			else
				Bar:SetAttribute("type1" ,"target");
				Bar:SetAttribute("unit",t2);
			end
			Bar.unit = t2;
			
			n=n+1;
			Bar:Show();
		else
			Bar:Hide();
		end

	end
	if FW.Settings.SummonCloser then
		FWSUFrameAmount:SetText("x"..Nis30y);
		FWSUFrameInfo:SetText(NisFar.." | "..Nis30y..FWL._ALL);
	else
		FWSUFrameInfo:SetText(FWL.FAR_..NisFar.." | "..Nis30y);
		FWSUFrameAmount:SetText("x"..NisFar);
	end
	if n>0 then
		FWSUBackground:SetHeight(21+(FW.Settings.SummonHeight+FW.Settings.SummonSpace)*n-FW.Settings.SummonSpace);
	else
		FWSUBackground:SetHeight(20);
	end
end

local function SU_ClearSummon() -- remove everybody that's added with normal priority and people outside the raid
	local i=1;
	while i <= su.rows do
		if su[i][6] == SUMMON_PRIOR.NORMAL then 
			su:remove(i);
		elseif not FW:NameToID(su[i][1]) then
			su:remove(i);
		else
			i=i+1;
		end
	end
	NisFar = 0;
	Nis30y = 0;
end

--[[local function SU_InstanceToCoordinates(name)
	if name == FW.PLAYER then
		if INSTANCE_COORDINATES[Zone] then
			return unpack(INSTANCE_COORDINATES[Zone]);
		elseif INSTANCE_COORDINATES[RealZone] then
			return unpack(INSTANCE_COORDINATES[RealZone]);
		elseif INSTANCE_COORDINATES[SubZone] then
			return unpack(INSTANCE_COORDINATES[SubZone]);
		end
	else
		if FW.RAID and INSTANCE_COORDINATES[ FW.Zones[name] ] then
			return unpack(INSTANCE_COORDINATES[ FW.Zones[name] ]);
		end
	end
end]]

local pc,px,py;-- player continent and coordinates
local function SU_AddCoordinates(unit,c)
	local t3 = UnitName(unit);
	local t1,t2= GetPlayerMapPosition(unit);
	if t1~=0 or t2~=0 then
		Coordinates:insert(t3 ,c,t1,t2);
		if t3 == FW.PLAYER then
			pc=c;px=t1;py=t2;
		end
	end
end

local function SU_StoreMap() -- stores the viewing part of the map, and every raid member's position on the map
	pc=nil;px=0;py=0;
	Coordinates:erase();
	for c=1,4,1 do -- get all the positions from people now
		SetMapZoom(c);
		if GetNumRaidMembers()>0 then
			for i=1,GetNumRaidMembers(),1 do
				SU_AddCoordinates(RAID[i],c);
			end
		else
			for i=1,GetNumPartyMembers(),1 do
				SU_AddCoordinates(PARTY[i],c);
			end
			SU_AddCoordinates("player",c);
		end
	end
	SetMapToCurrentZone();
	RealZone = GetRealZoneText();
    SubZone = GetSubZoneText();
   	Zone = GetZoneText();
end

local function SU_QueueSummon(unit)
	local unitName = UnitName(unit);
	su:setkey(unitName, unit,(FW:IsWarlock(unit) or 2),0,GetTime(),SUMMON_PRIOR.WHISPER,unitName);
	SU_DrawSummon();
end

--FW.Zones only useable in raids!

local function SU_InInstance(name,index)
	if index then
		-- check for bugged coordinates
		if FW.RAID and FW.Zones[name] == FWL.COILFANG_RESERVOIR then -- ppl inside Coilfang Reservoir may show up as near the dark portal...
			if Coordinates[index][3]<0.5 then
				return false;
			else
				return true;
			end
		else
			return false;
		end
		
	else
		return true;
	end
end

local function SU_InMyInstance(name,index)
	-- BLIZZARD FAILS since someone in your instance outside viewing range shows up in some bugged spot on the world map
	-- meaning there's no way to know for sure someone is inside your instance, only if he's in a zone named the same
	-- Fixed for: Coilfang Reservoir

	if FW.RAID and FW.Zones[name] ~= Zone and FW.Zones[name] ~= RealZone and FW.Zones[name] ~= SubZone then -- zone text doesnt match
		return false;
	end
	-- zone matches, but is this unit actually inside the instance?
	return SU_InInstance(name,index);
	
end

local function SU_AddSummon(unit)
	local prior = 1;-- default out of range priority
	local unitName = UnitName(unit);
	local cIndex = Coordinates:find(unitName,1);
	local index = su:find(unitName,1);
	if index then -- if it exists, means this unit has special properties
		su[index][2] = unit; -- update unit id even if this is a special prior!
		if su[index][6]==SUMMON_PRIOR.IGNORE and su[index][5] <= GetTime() then -- whisper and ignore priority expire
			--FW:Debug("removing ignore on "..unitName);
			su:remove(index);
		end
		return;
	end
	
	-- automatic adding
	if not UnitIsDeadOrGhost(unit) and UnitIsConnected(unit) and not UnitIsUnit(unit,"player") and not CheckInteractDistance(unit, 4) then -- alive,connected and outside follow range
		if pc then -- outside instance
		
			if FW.Settings.SummonOldMode and SU_InInstance(unitName,cIndex) then
				return;
			else -- this unit isnt in an instance
				Nis30y = Nis30y + 1;
				if not cIndex or Coordinates[cIndex][2] ~= pc then -- this unit is on another continent, give high prior
					prior = 2; --
					NisFar = NisFar + 1;
				else
					prior = math.sqrt(math.pow(px-Coordinates[cIndex][3],2) + math.pow( WorldMapRatio*(py-Coordinates[cIndex][4]) ,2));
					if prior <= SUMMON_DISTANCE[pc] then
						if not FW.Settings.SummonCloser then
							return; -- too close to need a summon
						end
					else
						NisFar = NisFar + 1;
					end
				end
			end
		else -- inside instance 
			if not FW.Settings.SummonOldMode or SU_InMyInstance(unitName,cIndex) then
				Nis30y = Nis30y + 1;
				if UnitIsVisible(unit) then
					if FW.Settings.SummonCloser then
						prior = 0;
					else
						return;
					end
				else
					NisFar = NisFar + 1;
				end
			else -- not inside my instance, ignore
				return;
			end		
		end
		
		su:insert(unitName, unit,(FW:IsWarlock(unit) or 2),prior,GetTime(),SUMMON_PRIOR.NORMAL,unitName);
	end
	if cIndex then Coordinates:remove(cIndex); end-- speed up searching player coordinates a bit, deleting the player i've done
end

local function SU_ScanSummon()

	if FW.Settings.SummonEnable and FW.Saved.GROUPED and not InCombatLockdown() and not WorldMapFrame:IsShown() then -- dont do shit if not in raid, in combat or when your map is shown :P
		SU_ClearSummon();
		-- Do scans
		SU_StoreMap();
		
		if GetNumRaidMembers()>0 then
			for i=1,GetNumRaidMembers(),1 do
				SU_AddSummon(RAID[i]);
			end
		else
			for i=1,GetNumPartyMembers(),1 do
				SU_AddSummon(PARTY[i]);
			end
			SU_AddSummon("player");
		end
		SU_DrawSummon();
	end
end

local function SU_SummonWhisper(event,arg1,arg2)
	arg1 = strlower(arg1);
	if not FW.Saved.GROUPED or not FW.Settings.SummonEnable or not FW.Settings.SummonKeyword or strfind(arg1,strlower(FWL.SUMMON_REQUEST_BLOCK)) then return; end
	local t1 = FW:NameToID(arg2);
	if t1 then
		local t2 = select(3,string.find(arg1,"^"..strlower(FW.Settings.SummonKeywordMsg).." (%l+)"));
		if t2 then
			for i=1,GetNumRaidMembers(),1 do
				if strlower(UnitName(RAID[i])) == t2 then
					SU_QueueSummon(RAID[i]);
					FW:Whisper(string.format(FWL.SUMMON_REQUEST_FOR,UnitName(RAID[i])),arg2);
					FW:Whisper(string.format(FWL.SUMMON_REQUEST_BY,arg2),UnitName(RAID[i]));
					return;
				end
			end
			for i=1,GetNumPartyMembers(),1 do
				if strlower(UnitName(PARTY[i])) == t2 then
					SU_QueueSummon(PARTY[i]);
					FW:Whisper(string.format(FWL.SUMMON_REQUEST_FOR,UnitName(PARTY[i])),arg2);
					FW:Whisper(string.format(FWL.SUMMON_REQUEST_BY,arg2),UnitName(PARTY[i]));
					return;
				end
			end
			SU_QueueSummon(t1);
			FW:Whisper(FWL.SUMMON_REQUEST,arg2);
		elseif arg1==strlower(FW.Settings.SummonKeywordMsg) then
			SU_QueueSummon(t1);
			FW:Whisper(FWL.SUMMON_REQUEST,arg2);
		end		
	end
end
local function SU_SummonCastStart(player,target,from)
	--FW:Debug("Summon Start msg: "..target.." by "..player);
	
	-- don't do anything when i get more summon targets for one player, lag may cause a warlock's target to update too slow, and showns as summoning it's old target
	if not ActiveSummons[player] or player == from then
		
		ActiveSummons[player] = target;

		-- Move this player to bottom
		local id =  FW:NameToID(target);
		if id then
			su:setkey(target, id,(FW:IsWarlock(id) or 2),0,GetTime(),SUMMON_PRIOR.SUMMON,"<"..player..">");
			SU_DrawSummon();
		end
	end
end

local function SU_SummonCastCancel(player,target,from)
	--FW:Debug("Summon Cancel msg: "..target.." by "..player);
	ActiveSummons[player] = nil;
	
	local index = su:find(target,1);
	-- change this player back to normal, if nobody else was summoning him / has summoned him
	if index and (su[index][6] ~= SUMMON_PRIOR.IGNORE or player == from) then -- don't change mainprior if ignored already

		for key, val in pairs(ActiveSummons) do -- don't change prior if being summoned by another warlock
			if val == target then
				su[index][7] = "<"..key..">";
				return;
			end
		end
		su:remove(index);
		SU_DrawSummon();
	end
end

local function SU_SummonCastEnd(player,target,from)
	--FW:Debug("Summon End msg: "..target.." by "..player);
	
	ActiveSummons[player] = nil;
	
	local index = su:find(target,1);
	
	if index and (su[index][6] ~= SUMMON_PRIOR.IGNORE or player == from) then -- don't change mainprior if ignored already

		for key, val in pairs(ActiveSummons) do -- don't change prior if being summoned by another warlock
			if val == target then
				su[index][7] = "<"..key..">";
				return;
			end
		end
		su[index][5] = GetTime()+10;
		su[index][6] = SUMMON_PRIOR.IGNORE;
		SU_DrawSummon();
	end
end

-- globally accessable
function FW:SUFrame_OnClick(button)
	if FW:Moved() then return; end
	if button == "LeftButton" then
		if FW.Settings.SummonDetails then -- toggles between hidden->normal->all30y->etc
			if FW.Settings.SummonCloser then
				FW.Settings.SummonDetails = false;
			else
				FW.Settings.SummonCloser = true;
			end
		else
			FW.Settings.SummonDetails = true;
			FW.Settings.SummonCloser = false;
		end
		SU_DrawSummon();
		FW:RefreshOptions();
		
	else
		FW:ScrollTo(FWL.SUMMON_ASSISTANT);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:IgnoreClick()
	local unitName = UnitName(this.unit);
	su:setkey(unitName, this.unit,(FW:IsWarlock(this.unit) or 2),0,(GetTime()+10),SUMMON_PRIOR.IGNORE,unitName);
	SU_DrawSummon();
end

local function SU_ChatFilter(self, event, msg, ...)
	--FW:Show(event..":"..msg);
	if strfind(msg,FWL.SUMMON_REQUEST_BLOCK) then
		return true;
	else
		return false, msg, ...;
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", SU_ChatFilter);

function FW:SummonOnload()
	-- includes a quick 2.00 fix!
	FWSUFrame.Update = SU_SummonShow;
	FW:RegisterFrame("FWSUFrame",FWSUFrame,1);
		
	FW:RegisterButtonPress("SU_SUMMON","FWSUButton","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON1","FWSUBar1","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON2","FWSUBar2","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON3","FWSUBar3","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON4","FWSUBar4","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON5","FWSUBar5","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON6","FWSUBar6","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON7","FWSUBar7","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON8","FWSUBar8","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON9","FWSUBar9","LeftButton");
	FW:RegisterButtonPress("SU_SUMMON10","FWSUBar10","LeftButton");
	FW:RegisterButtonPress("SU_OPTIONS","FWSUFrame","RightButton");

	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("SummonInterval",		SU_SummonShow);
		FW:RegisterTimedEvent("SummonInterval",		SU_ScanSummon);
	end);

	FW:RegisterToEvent("CHAT_MSG_WHISPER",		SU_SummonWhisper);
	FW:RegisterToEvent("PLAYER_TARGET_CHANGED",	SU_DrawSummon);-- change summon buttons to summon or select

	
	
	--[[FW:RegisterOtherCasts();
	local function ss(s,u,t)
		if s == summon or s == meeting then
			if t ~= "" then FW:SummonStartMessage(u,t);end
			return true;
		end
	end
	local function sc(s,u,t)
		if s == summon then
			if t ~= "" then FW:SummonCancelMessage(u,t);end
			return true;
		end
	end
	local function se(s,u,t)
		if s == summon or s == meeting then
			if t ~= "" then FW:SummonEndMessage(u,t);end
			return true;
		end
	end]]
	
	FW:RegisterOnLeaveCombat(SU_SummonShow);
	FW:RegisterOnEnterCombat(function() FWSUFrame:Update(1);end);
	
	--[[FW:RegisterMessage(FW.SU_CAST_START,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(.-) (.+)$");
			if t1 and t2 then SU_SummonCastStart(t1,t2,f); end
		end,
	1);
	FW:RegisterMessage(FW.SU_CAST_CANCEL,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(.-) (.+)$");
			if t1 and t2 then SU_SummonCastCancel(t1,t2,f); end
		end,
	1);
	FW:RegisterMessage(FW.SU_CAST_END,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(.-) (.+)$");
			if t1 and t2 then SU_SummonCastEnd(t1,t2,f); end
		end,
	1);]]
	--FW:Show("Summon Module Loaded");
end

FW:SetMainCategory(FWL.SUMMON_ASSISTANT,FW.ICON_SU,8,"SUMMON","FWSUFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FWL.SU_HINT1);
		FW:RegisterOption(FW.INF,2,FW.NON,FWL.SU_HINT2);
	
	FW:SetSubCategory(FWL.BASIC,FW.ICON_BASIC,2)
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.ENABLE,			FWL.SU_ENABLE_TT,	"SummonEnable",		SU_SummonShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHOW_BARS,		FWL.SHOW_BARS_TT,	"SummonDetails");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.EXPAND_UP,		FWL.EXPAND_UP_TT,	"SummonExpand",		SU_SummonShow);
	
	FW:SetSubCategory(FWL.SPECIFIC,FW.ICON_SPECIFIC,3);	
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHOW_CLOSE,		FWL.SHOW_CLOSE_TT,		"SummonCloser");
		FW:RegisterOption(FW.MSG,1,FW.NON,FWL.QUEUE_SUMMON,		FWL.QUEUE_SUMMON_TT,		"SummonKeyword");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHOW_MEETING_STONE,	FWL.SHOW_MEETING_STONE_TT,	"SummonMeetingStone");
		
	FW:SetSubCategory(FWL.SIZING,FW.ICON_SIZE,4);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_WIDTH,		"",	"SummonWidth",		SU_SummonShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_HEIGHT,		"",	"SummonHeight",		SU_SummonShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_SPACING,		"",	"SummonSpace",		SU_SummonShow,0);
		--FW:RegisterOption(FW.NUM,1,FW.NON,FWL.SCALE,			"",	"SummonScale",		SU_SummonScale,0.2,5);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.MAX_SHOWN,		"",	"SummonMax",		nil,0,NUM_SUMMONS);	

	FW:SetSubCategory(FWL.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.PLAYER_FAR,		"",	"SummonFar");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.PLAYER_CLOSE,		"",	"SummonClose");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.BEING_SUMMONED,	"",	"Summoning");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.WHISPERED,		"",	"Whisper");

	FW:SetSubCategory(FWL.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.BAR_TEXT,			"",	"SummonText",	SU_SummonShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.FRAME_BACKGROUND,	"",	"SummonBg",		SU_SummonShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FWL.BAR_FONT,			"",	"SummonFont",	SU_SummonShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FWL.BAR_TEXTURE,		"",	"SummonTexture",SU_SummonShow);
		
FW:SetMainCategory(FWL.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FWL.SUMMON_ASSISTANT,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.MS0,1,FW.NON,FWL.FRAME_LEVEL,	"",	"SummonStrata", SU_SummonShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.UPDATE_INTERVAL_SUMMON,	"",	"SummonInterval",nil,0.5,5);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.OLD_SUMMONING_MODE,	FWL.OLD_SUMMONING_MODE_TT,	"SummonOldMode");

		
FW.Default.SummonInterval = 1;
FW.Default.SummonStrata = FW.Default.Strata;

FW.Default.SummonFont = FW.Default.Font;
FW.Default.SummonFontSize = FW.Default.FontSize;
FW.Default.SummonTexture = FW.Default.Texture;
FW.Default.SummonEnable = true;
FW.Default.SummonDetails = true;
FW.Default.SummonCloser = false;
FW.Default.SummonWidth = 100;
FW.Default.SummonHeight = 12;
FW.Default.SummonMax = 5;
FW.Default.SummonKeyword = true;
FW.Default.SummonKeywordMsg = "summon";
FW.Default.SummonExpand = false;
FW.Default.SummonSpace = 1;
FW.Default.SummonMeetingStone = false;
FW.Default.SummonOldMode = false;

FW.Default.SummonCloseColor = 	{0.60,0.60,0.60};
FW.Default.SummonFarColor = 	{1.00,1.00,1.00};
FW.Default.SummoningColor = 	{0.64,0.21,0.93};
FW.Default.WhisperColor = 		{1.00,0.00,1.00};
FW.Default.SummonBgColor = 		{0.31,0.00,0.62,0.75};
FW.Default.SummonTextColor = 	{1.00,1.00,1.00};

BINDING_HEADER_SUMMON = FWL.SUMMON_ASSISTANT;
BINDING_NAME_SU_SUMMON = FWL.CAST_RITUAL_OF_SUMMONING;
BINDING_NAME_SU_SUMMON1 = FWL.SUMMON_PLAYER_.."1";
BINDING_NAME_SU_SUMMON2 = FWL.SUMMON_PLAYER_.."2";
BINDING_NAME_SU_SUMMON3 = FWL.SUMMON_PLAYER_.."3";
BINDING_NAME_SU_SUMMON4 = FWL.SUMMON_PLAYER_.."4";
BINDING_NAME_SU_SUMMON5 = FWL.SUMMON_PLAYER_.."5";
BINDING_NAME_SU_SUMMON6 = FWL.SUMMON_PLAYER_.."6";
BINDING_NAME_SU_SUMMON7 = FWL.SUMMON_PLAYER_.."7";
BINDING_NAME_SU_SUMMON8 = FWL.SUMMON_PLAYER_.."8";
BINDING_NAME_SU_SUMMON9 = FWL.SUMMON_PLAYER_.."9";
BINDING_NAME_SU_SUMMON10 = FWL.SUMMON_PLAYER_.."10";
BINDING_NAME_SU_OPTIONS = FWL.TOGGLE_OPTIONS;