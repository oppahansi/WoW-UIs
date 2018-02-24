-- ForteXorcist v1.959.8 by Xus 13-04-2010

FW = {}; -- core table
FC_Saved = {}; -- save table
local FC_Saved;
local FW_Debug = false;
local FW = FW;
FW.L = {}; -- locale table
local FWL = FW.L;
FW.Default = {};
FW.Frames = {};

local Frames = FW.Frames;
local Commands = {};

local FW_Loaded = {};
local FW_DelayedLoaded = {};
local FW_VariablesLoaded = {};
local FW_Messages = {};
local FW_oRAMessages = {};
local FW_EnterPartyRaid = {};
local FW_OnEnterCombat = {};
local FW_OnLeaveCombat = {};

local FilterRefresh = {};

local strfind = strfind;
local strformat = string.format;
local ipairs = ipairs;
local pairs = pairs;
local unpack = unpack;
local select = select;
local GetTime = GetTime;
local type = type;
local _G = _G;

FW.TITLE = "ForteXorcist";
local VERSION = "v1.959.8";
local ENABLE = false;
FW.GROUPED = false;
FW.RAID = false;

local GetNumRaidMembers = GetNumRaidMembers;
local GetNumPartyMembers = GetNumPartyMembers;

do
	local origUnitName = UnitName;
	FW.FullUnitName = function(token)
		local name, realm = origUnitName(token);
		if realm and realm~="" then
			return name.."-"..realm;
		else
			return name;
		end
	end
end
local UnitName = FW.FullUnitName;

----------------------------------------------------------------------------------------------------------------------------
--------- STUFF TO MINIMIZE TABLE MEMORY GARBAGE SINCE I LIKE TO USE '2D' TABLES A LOT -------------------------------------
----------------------------------------------------------------------------------------------------------------------------

do
	local function FW_BSTR(t,i,j,c,asc,a)
		local val1 = t[j-1][ c[a] ];
		local val2 = t[j][ c[a] ];
		
		if val1 == val2 then
			if c[a+1] then		
				FW_BSTR(t,i,j,c,asc,a+1);
			end
		elseif asc[a] == (val1 > val2) then
			t[j-1],t[j] = t[j],t[j-1];
		end
	end

	local function FW_BST(t,c,asc) -- sorts my '2d table', using 'column - ascending' table pairs
		local i = 1;
		local j;
		while i <= t.rows do
			j = t.rows;
			while i<j do
				FW_BSTR(t,i,j,c,asc,1);
				j=j-1;
			end
			i=i+1;
		end
	end

	local function FW_INS(t,...) -- insert new row, must be the same number of columns (for sort to work properly)!!
		t.rows = t.rows + 1;
		if t[t.rows] then
			for i=1,select('#',...),1 do
				t[t.rows][i] = select(i,...);
			end
		else
			tinsert(t,{...});
		end
	end

	local function FW_REM(t,row) -- remove row
		if row and row <= t.rows then
			t.rows=t.rows-1;
			for r=row,t.rows,1 do
				t[r],t[r+1] = t[r+1],t[r];
			end
		end
	end

	local function FW_ERASE2(t) -- erases my 2d tables ONLY
		t.rows = 0; -- lol :p
	end
	
	local function FW_FIND(t,v,c) -- find value v in '2d table' t at column c, returns ROW
		for r=1,t.rows,1 do
			if t[r][c]==v then
				return r;
			end
		end
	end

	local function FW_FIND2(t,v1,c1,v2,c2) -- returns ROW
		for r=1,t.rows,1 do
			if t[r][c1]==v1 and t[r][c2]==v2 then
				return r;
			end
		end
	end

	local function FW_FIND3(t,v1,c1,v2,c2,v3,c3) -- returns ROW
		for r=1,t.rows,1 do
			if t[r][c1]==v1 and t[r][c2]==v2 and t[r][c3]==v3 then
				return r;
			end
		end
	end

	local function FW_SETKEY(t,k,...) -- Set a row with 'key', MUST have the same num columns!
		local n = FW_FIND(t,k,1);
		if n then
			for i=1,select('#',...),1 do
				t[n][i+1] = select(i,...);
			end
		else
			FW_INS(t,k,...);
		end
	end

	local function FW_P(t)
		local str;
		for r=1,t.rows,1 do
			str = "";
			for c=1,#t[r],1 do
				str = str.." "..t[r][c];
			end
			FW:Show(str);
		end
	end

	function FW:NEW2D() -- CURRENTLY ONLY SUPPORTS A STATIC NUMBER OF COLUMNS (for one 2d table) TO INCREASE PERFORMANCE!!
		local t = {};
		t.rows = 0;
		t.erase = FW_ERASE2;
		t.remove = FW_REM;
		t.insert = FW_INS;
		t.find = FW_FIND;
		t.find2 = FW_FIND2;
		t.find3 = FW_FIND3;
		t.sort = FW_BST;
		t.setkey = FW_SETKEY;
		t.print = FW_P;
		return t;
	end
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
local LastRess;
local LeaveCombat;

local function FW_EnterCombat()
	--FW:Debug("enter combat");
	for i,f in ipairs(FW_OnEnterCombat) do
		f();
	end
end
local function FW_LeaveCombat()
	--FW:Debug("leave combat");
	for i,f in ipairs(FW_OnLeaveCombat) do
		f();
	end
end

local function FW_Ress()
	if not UnitIsDeadOrGhost("player") and not LastRess then
		LastRess = GetTime()+5; -- wait 5 seconds with checking combat
	end
end

local InCombatLockdown = InCombatLockdown;
local function FC_ExtraCombatCheck()
	if not InCombatLockdown() then FW_LeaveCombat(); end
end

do -- update frame related stuff uses locals with the smallest scope possible
	local FC_UpdateFrame = CreateFrame("Frame");
	local FW_Events = {};
	local FW_Updated = {};
	local FC_DelayedExecQueue = FW:NEW2D();
	local GetTime = GetTime;
	
	function FW:RegisterToEvent(event,func)
		if not FW_Events[event] then
			FC_UpdateFrame:RegisterEvent(event);
			FW_Events[event] = {};
		end
		for i,f in ipairs(FW_Events[event]) do
			if f == func then
				return;
			end
		end
		tinsert(FW_Events[event],func);
	end
	function FW:UnregisterToEvent(event,func)
		if not FW_Events[event] then return; end
		for i,f in ipairs(FW_Events[event]) do
			if f == func then
				tremove(FW_Events[event],i);
				if #FW_Events[event]==0 then
					FW_Events[event] = nil;
					FC_UpdateFrame:UnregisterEvent(event);
				end
				return;
			end
		end
	end
	function FW:RegisterUpdatedEvent(func)
		tinsert(FW_Updated,func);
	end

	function FW:UnregisterUpdatedEvent(func)
		for i,f in ipairs(FW_Updated) do
			if f == func then
				tremove(FW_Updated,i);
				return;
			end
		end
	end

	function FW:DelayedExec(delay,times,func,...)
		FC_DelayedExecQueue:insert(GetTime()+delay,delay,times,func,...);
	end
	local function FC_OnEvent(self,event,...)
		--[[if event=="COMBAT_LOG_EVENT_UNFILTERED" then
			if strfind(arg2,"SUMMON") or strfind(arg2,"UNIT_DIED") then
				local d = GetTime().." "..event;
				for i=1,select('#',...),1 do
					if select(i,...) ~= nil then d = d.." #"..i..":"..tostring(select(i,...)); end
				end
				FW:Show(d,0,1,1);
			end
		end]]
		
		if FW_Events[event] then 
			for k,v in ipairs(FW_Events[event]) do
				v(event,...);
			end
		end
	end
	local FW_Timed = {};
	
	function FW:RegisterTimedEvent(interval,func)
		if type(interval) == "string" then
			if FW.Settings[interval] then
				interval = FW.Settings[interval];
			else
				FW:Show("error adding interval: "..interval);
			end
		end
		if not FW_Timed[interval] then
			FW_Timed[interval] = {[0]=0};
		end
		tinsert(FW_Timed[interval],func);
	end

	function FW:UnregisterTimedEvent(interval,func)
		if type(interval) == "string" then
			if FW.Settings[interval] then
				interval = FW.Settings[interval];
			else
				FW:Show("error removing interval: "..interval);
			end
		end
		if FW_Timed[interval] then
			for i,f in ipairs(FW_Timed[interval]) do
				if f == func then
					tremove(FW_Timed[interval],i);
					return;
				end
			end
		end
	end
	
	local function FC_OnUpdate(self, elapsed) -- normal onupdate
		if LastRess and LastRess <= GetTime() then -- delays combat checking when you're ressed, so in case of a combat res or ss use your timers wont be cleared instantly
			FC_ExtraCombatCheck();
			LastRess = nil;
		end
		if LeaveCombat then -- this is only used when zoning, to make sure buttons arent still locked when FW_LeaveCombat is called
			FC_ExtraCombatCheck();
			LeaveCombat = nil;
		end
		-- run the timed events
		for key, val in pairs(FW_Timed) do
			FW_Timed[key][0] = FW_Timed[key][0] + elapsed;
			if FW_Timed[key][0] >= key then
				FW_Timed[key][0] = FW_Timed[key][0]%key;
				for k, v in ipairs(FW_Timed[key]) do
					v();
				end
			end
		end
		for i, f in ipairs(FW_Updated) do
			f(elapsed);
		end
		-- delayed exec code
		local t = GetTime();
		local i = 1;
		while i <= FC_DelayedExecQueue.rows do
			if FC_DelayedExecQueue[i][1] <= t then
				FC_DelayedExecQueue[i][4](unpack(FC_DelayedExecQueue[i],5));
				if FC_DelayedExecQueue[i][3] > 1 then
					FC_DelayedExecQueue[i][3]=FC_DelayedExecQueue[i][3]-1;
					FC_DelayedExecQueue[i][1] = FC_DelayedExecQueue[i][1] + FC_DelayedExecQueue[i][2];
				 else
					for k in ipairs(FC_DelayedExecQueue[i]) do -- erase all data so i can use any argument count
						FC_DelayedExecQueue[i][k] = nil;
					end
					FC_DelayedExecQueue:remove(i);
				end
			else
				i=i+1;
			end
		end
	end
	local UILoaded;
	local function FC_OnPreUpdate(self, elapsed) -- pre onupdate
		if UILoaded then -- enable update actions 2 sec after UI is fully loaded
			if GetTime() >= UILoaded then
				FC_UpdateFrame:SetScript("OnUpdate", FC_OnUpdate); -- start doing stuff when the addon is fully enabled!
				for i, f in ipairs(FW_DelayedLoaded) do
					f();
				end
			end
		elseif FW.Settings and FW.Settings.LoadDelay then
			UILoaded = GetTime() + FW.Settings.LoadDelay;
		end	
	end
	FC_UpdateFrame:SetScript("OnEvent", FC_OnEvent);
	FC_UpdateFrame:SetScript("OnUpdate", FC_OnPreUpdate);
	--FC_UpdateFrame:RegisterAllEvents(); -- for debugging only
end

do
	local type = type;
	local origUnitBuff = UnitBuff;
	local origUnitDebuff = UnitDebuff;
	local CustomIDToName = {};
	local CustomNameToID = {};

	FW.UnitBuff = function(unit,buff,rank,filter) -- works exactly like the original, but takes custom names into account
		if type(buff) == "string" then
			local id = CustomNameToID[buff];
			if id then
				local i = 1;
				while true do
					local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = origUnitBuff(unit,i,filter);
					if name then
						if id == spellId then
							return buff, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
						end
						i=i+1;
					else
						return nil;
					end
				end
			else
				return origUnitBuff(unit,buff,rank,filter);
			end
		else
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = origUnitBuff(unit,buff,rank,filter);
			return CustomIDToName[spellId] or name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
		end
	end

	FW.UnitDebuff = function(unit,buff,rank,filter) -- works exactly like the original, but takes custom names into account
		if type(buff) == "string" then
			local id = CustomNameToID[buff];
			if id then
				local i = 1;
				while true do
					local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = origUnitDebuff(unit,i,filter);
					if name then
						if id == spellId then
							return buff, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
						end
						i=i+1;
					else
						return nil;
					end
				end
			else
				return origUnitDebuff(unit,buff,rank,filter);
			end
		else
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = origUnitDebuff(unit,buff,rank,filter);
			return CustomIDToName[spellId] or name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
		end
	end
	function FW:RegisterCustomName(id,name)
		CustomIDToName[id] = name;
		CustomNameToID[name] = id;
	end
	function FW:SpellName(spell)
		local s,_,t = GetSpellInfo(spell);
		s = CustomIDToName[spell] or s;
		if s then
			if not FW.SpellInfo[s] then
				FW.SpellInfo[s] = {spell,0,0,0};
			end
			return s,t;
		else
			return spell;
		end
	end
end

FW.Sets = {};

FW.BORDER = 3;
--FW.pet,target,focus is also non-nil (guid) when present
FW.PLAYER = UnitName("player");
FW.CLASS = select(2,UnitClass("player"));
FW.SERVER = GetRealmName();
FW.RACE = select(2,UnitRace("player"));

FW.ID_SOULSHARD = 6265;
FW.ID_SOULSTONE = {
	5232,
	16892,
	16893,
	16895,
	16896,
	22116,
	36895,
};

FW.PARTY = {};for i=1,4,1 do tinsert(FW.PARTY,"party"..i);end
local PARTY = FW.PARTY;
FW.RAID = {};for i=1,40,1 do tinsert(FW.RAID,"raid"..i);end
local RAID = FW.RAID;

FW.OPTION_COLOR = {};
FW.OPTION_COLOR.CLASS = {RAID_CLASS_COLORS[FW.CLASS].r,RAID_CLASS_COLORS[FW.CLASS].g,RAID_CLASS_COLORS[FW.CLASS].b};
FW.OPTION_COLOR.COOLDOWN = {0.00,1.00,0.50};
FW.OPTION_COLOR.TIMER = {1.00,0.50,0.00};

FW.OPTION_COLOR.SOULSTONE = {0.55,0.00,0.70};
FW.OPTION_COLOR.SHARD = {0.55,0.00,0.70};
FW.OPTION_COLOR.HEALTHSTONE = {0.00,1.00,0.00};
FW.OPTION_COLOR.SHARDMANAGER = {0.55,0.00,0.70};
FW.OPTION_COLOR.SUMMON = {0.55,0.00,0.70};
FW.OPTION_COLOR.TALENT = {1.00,0.00,0.00};

FW.OPTION_COLOR.RAIDMESSAGES = {0.00,0.50,1.00};
FW.OPTION_COLOR.SELFMESSAGES = {0.00,0.50,1.00};
FW.OPTION_COLOR.SOUND = {0.00,0.50,1.00};
FW.OPTION_COLOR.ABOUT = {1.00,1.00,0.00};

FW.FLAG_RES = 0; -- can res with ss
FW.FLAG_DI = 1; -- is di-ed
FW.FLAG_TIME = 2; -- normal soulstone duration
FW.FLAG_WARLOCK = 6203;
FW.FLAG_DRUID = 48477;
FW.FLAG_PALADIN = 19752;
FW.FLAG_SHAMAN = 20608;

FW.ORA3_COOLDOWN = "^1^SCooldown^N%d^N%d^^";

FW.FLAG_LEFT = -2;
FW.FLAG_OFFLINE = -1;
FW.FLAG_NORMAL = 0;
FW.FLAG_UNKNOWN = 1;
FW.FLAG_DEAD = 2;

FW.FILTER_ALWAYS = 3;
FW.FILTER_SHOW = 1;
FW.FILTER_NONE = 0;
FW.FILTER_HIDE = -1;
FW.FILTER_COLOR = -2;
FW.FILTER_SHOW_COLOR = 2;

-- spell timer flags
FW.DEFAULT = 1;
FW.SHARED = 2;
FW.UNIQUE = 3;
-- above are scanned by standard as debuff
FW.PET = 4;
FW.POWERUP = 5;
FW.SELF_DEBUFF = 6;
FW.CHARM = 7;
FW.COOLDOWN = 8;
FW.DEBUFF = 9;
FW.DRAIN = 10;
-- below are scanned by standard as buff
FW.HEAL = 11;
FW.BUFF = 12;

FW.LAST_TIMER_FLAG = FW.BUFF;

FW.PRIOR_COOLDOWN = 0;
FW.PRIOR_NONE = -1;
FW.PRIOR_DEBUFF = -2;
FW.PRIOR_SELF_DEBUFF = -3;
FW.PRIOR_POWERUP = -4;

FW.RaidIcons = {"{rt1}","{rt2}","{rt3}","{rt4}","{rt5}","{rt6}","{rt7}","{rt8}"};

FW.FontList = {};
FW.SoundList = {};
FW.BorderList = {};
FW.BackgroundList = {};

--[[function FW:RT(val,roundto)
	FW:Show(tostring(FW:RoundTo(val,roundto)));
end]]

function FW:RoundTo(val,roundto)
	if not roundto or roundto <= 0 then
		return val;
	end
	local f = 100;
	val = f*val;
	roundto = f*roundto;
	
	local remain = val%roundto;
	val = val - remain;
	if remain >= roundto*0.5 then
		return (val + roundto)/f;
	elseif remain < -roundto*0.5 then
		return (val - roundto)/f;
	else
		return val/f;
	end
end

function FW:Show(msg,r,g,b,a) DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b,a); end

function FW:Debug(msg) if FW_Debug then FW:Show("Debug: "..msg,1,0.5,0); end end

function FW:RegisterFont(path,name)
	tinsert(FW.FontList,{path,name});
end

function FW:RegisterBorder(path,name)
	tinsert(FW.BorderList,{path,name});
end

function FW:RegisterBackground(path,name)
	tinsert(FW.BackgroundList,{path,name});
end

function FW:RegisterSound(path,name)
	tinsert(FW.SoundList,{path,name});
end

function FW:SetDefaultFont(path,size)
	FW.Default.Font = path;
	FW.Default.FontSize = size;
end

FW.ERASE = function(t) -- erases any table
	for k in pairs(t) do
		if type(t[k])=="table" then
			FW.ERASE(t[k]);
		end
		t[k]= nil;
	end
end
local erase = FW.ERASE;

FW:RegisterFont("Fonts\\ARIALN.TTF", "Arial Narrow");
FW:RegisterFont("Fonts\\FRIZQT__.TTF", "Friz Quadrata TT");
FW:RegisterFont("Fonts\\MORPHEUS.TTF", "Morpheus");
FW:RegisterFont("Fonts\\SKURRI.TTF", "Skurri");
FW:RegisterFont("Interface\\AddOns\\Forte_Core\\Fonts\\FORTE.TTF", "Forte");
FW:RegisterFont("Interface\\AddOns\\Forte_Core\\Fonts\\HandelGothicBT.TTF", "Handel Gothic BT");
FW:RegisterFont("Interface\\AddOns\\Forte_Core\\Fonts\\GOTHIC.TTF", "Century Gothic");
FW:RegisterFont("Interface\\AddOns\\Forte_Core\\Fonts\\GOTHICB.TTF", "Century Gothic Bold");
FW:SetDefaultFont("Interface\\AddOns\\Forte_Core\\Fonts\\GOTHIC.TTF", 11);

FW:RegisterBorder("None", "None");
FW:RegisterBorder("Interface\\AddOns\\Forte_Core\\Textures\\Border", "ForteXorcist");

FW:RegisterBackground("None", "None");
FW:RegisterBackground("Interface\\AddOns\\Forte_Core\\Textures\\Background", "ForteXorcist");
FW:RegisterBackground("Interface\\AddOns\\Forte_Core\\Textures\\Otravi", "Otravi");
FW:RegisterBackground("Interface\\AddOns\\Forte_Core\\Textures\\Smooth", "Smooth");

FW:RegisterSound("Interface\\AddOns\\Forte_Core\\Sounds\\SoulstoneExpire.mp3", "FX: Soulstone Expire");
FW:RegisterSound("Sound\\Spells\\SoulstoneResurrection_Base.wav","Soulstone");
FW:RegisterSound("Sound\\Spells\\EnlargeCast.wav","Enlarge");
FW:RegisterSound("Sound\\Spells\\FluteRun.wav","Flute");
FW:RegisterSound("Sound\\Spells\\ShadowWard.wav","Shadow Ward");
FW:RegisterSound("Sound\\Spells\\ShadowWordSilence.wav","Silence");
FW:RegisterSound("Sound\\Spells\\ShadowWordPain_Chest.wav","Shadow Word Pain");
FW:RegisterSound("Sound\\Spells\\ShadowWordFumble.wav","Fumble");
FW:RegisterSound("Sound\\Spells\\AntiHoly.wav","Anti Holy");
FW:RegisterSound("Sound\\Spells\\Bonk1.wav","Bonk1");
FW:RegisterSound("Sound\\Spells\\Bonk2.wav","Bonk2");
FW:RegisterSound("Sound\\Spells\\Bonk3.wav","Bonk3");
FW:RegisterSound("Sound\\Spells\\consume_magic_impact.wav","Consume Magic");
FW:RegisterSound("Sound\\Spells\\Creature_SpellPortalLarge_All_Colors.wav","Spell Portal");
FW:RegisterSound("Sound\\Spells\\Ingvar_ResurrectionGroundVisual.wav","Resurrection Ground");
FW:RegisterSound("Sound\\Spells\\Resurrection.wav","Resurrection");
FW:RegisterSound("Sound\\Spells\\Rogue_shadowdance_state.wav","Shadow Dance");
FW:RegisterSound("Sound\\Spells\\ShaysBell.wav","Shay's Bell");
FW:RegisterSound("Sound\\Spells\\SimonGame_Visual_BadPress.wav","Simon Error");
FW:RegisterSound("Sound\\Spells\\SimonGame_Visual_GameFailedLarge.wav","Simon Failed Large");
FW:RegisterSound("Sound\\Spells\\SimonGame_Visual_GameFailedSmall.wav","Simon Failed Small");
FW:RegisterSound("Sound\\Spells\\SimonGame_Visual_GameStart.wav","Simon Start");
FW:RegisterSound("Sound\\Spells\\SimonGame_Visual_GameTick.wav","Simon Tick");
FW:RegisterSound("Sound\\Spells\\SimonGame_Visual_LevelStart.wav","Simon Level Start");

FW.TextureList = {
	"Interface\\AddOns\\Forte_Core\\Textures\\Aluminium",
	"Interface\\AddOns\\Forte_Core\\Textures\\Minimalist",
	"Interface\\AddOns\\Forte_Core\\Textures\\Xus",
	"Interface\\AddOns\\Forte_Core\\Textures\\Otravi",
	"Interface\\AddOns\\Forte_Core\\Textures\\LiteStep",
	"Interface\\AddOns\\Forte_Core\\Textures\\BantoBar",
	"Interface\\AddOns\\Forte_Core\\Textures\\Charcoal",
	"Interface\\AddOns\\Forte_Core\\Textures\\Perl",
	"Interface\\AddOns\\Forte_Core\\Textures\\Smooth",
	"Interface\\AddOns\\Forte_Core\\Textures\\Smudge",
	"Interface\\AddOns\\Forte_Core\\Textures\\Striped",
	"Interface\\AddOns\\Forte_Core\\Textures\\Glaze",
	"Interface\\AddOns\\Forte_Core\\Textures\\Frost",
	"Interface\\AddOns\\Forte_Core\\Textures\\HealBot",
	"Interface\\AddOns\\Forte_Core\\Textures\\Rocks",
	"Interface\\AddOns\\Forte_Core\\Textures\\Runes",
	"Interface\\AddOns\\Forte_Core\\Textures\\Xeon",
	"Interface\\AddOns\\Forte_Core\\Textures\\SWSDefault",
	"Interface\\AddOns\\Forte_Core\\Textures\\Flat",
	"Interface\\TargetingFrame\\UI-StatusBar",
	"Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
};

function FW:SoundName(sound)
	for i, data in ipairs(FW.SoundList) do
		if strlower(data[1]) == strlower(sound) then
			return data[2];
		end
	end
	return "Custom Sound";
end

function FW:FontName(font)
	for i, data in ipairs(FW.FontList) do
		if strlower(data[1]) == strlower(font) then
			return data[2];
		end
	end
	return "Custom Font";
end

function FW:TypeName(t,list)
	for i, data in ipairs(list) do
		if data[1] == t then
			return data[2];
		end
	end	
end

FW.Modules = {};
function FW:ClassModule(module)
	FW.ClassModules = module;
	return FW:Module(module);
end
function FW:Module(module)
	FW.Modules[module] = {};
	return FW.Modules[module];
end

local DeleteOld = 1800;

FW.GET_SHARDS = "SG";
FW.GET_HEALTHSTONE = "HG"
FW.SEND_HEALTHSTONE = "HS";
FW.SEND_SHARDS = "SH";

local SEND_VERSION = "VE"
local GET_VERSION = "VG";
local GET_SPECC = "SPG";
local SEND_SPECC = "SPS";

FW.LastShardCheck = 0;
FW.LastHSCheck = 0;

FW.Healthstone = {};

FW.Zones = {};
FW.Ranks = {};
FW.Ready = {};

FW.SetBonus = {};
FW.Talent = {};
FW.Glyph = {};

FW.SpellInfo = {};-- id [,casttime,minrange,maxrange]

function FW:CastTime(spell)
	return FW.SpellInfo[spell] and FW.SpellInfo[spell][2] or 0;
end

function FW:SpellId(name)
	return FW.SpellInfo[name][1] or name;
end

function FW:FrameScaleCheck(editbox)
	local num = tonumber(editbox:GetText());
	if num then
		if num < 0.2 then 
			return 0.2;
		elseif num > 5.0 then
			return 5.0;
		end
		return num;
	end
end
function FW:FrameAlphaCheck(editbox)
	local num = tonumber(editbox:GetText());
	if num then
		if num < 0.1 then 
			return 0.1;
		elseif num > 1.0 then
			return 1.0;
		end
		return num;
	end
end

function FW:NumberCheck(editbox)
	local num = tonumber(editbox:GetText());
	if num then
		if editbox.maximum and num>editbox.maximum then
			return editbox.maximum;
		elseif editbox.minimum and num<editbox.minimum then
			return editbox.minimum;
		end
		return num;
	end
end

do
	local function FW_Largest(x,y)
		if x>y then
			return x;
		else
			return y;
		end
	end

	function FW:FixIntensity(r,g,b)
		local largest = FW_Largest(FW_Largest(r,g),b);
		if largest < 1 then
			return 0.7*r/largest+0.3,0.7*g/largest+0.3,0.7*b/largest+0.3;
		else
			return 0.7*r+0.3,0.7*g+0.3,0.7*b+0.3;
		end
	end
end

local GetItemInfo = GetItemInfo;
function FW:ItemName(item)
	return (GetItemInfo(item)) or "unknown";
end
local UnitGUID = UnitGUID;
function FW:Changed(unit)
	FW[unit] = UnitGUID(unit);
end

function FW:ShowTip(self)
	if self.tip and self.title and FW.Settings.Tips then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		GameTooltip:SetText(self.title, 1.0, 1.0, 1.0);
		GameTooltip:AddLine(self.tip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		GameTooltip:Show();
	end
end

function FW:HideTip(self)
	HideUIPanel(GameTooltip);
end

local function FW_VersionCheck()
	FW:SendData(GET_VERSION);
end
local function FW_GetSpeccInfo()
	FW:SendData(GET_SPECC);
end


function FW:HealthstoneSpecc(player)
	if FC_Saved.Speccs.WARLOCK and FC_Saved.Speccs.WARLOCK[player] then
		return tonumber(strsub(FC_Saved.Speccs.WARLOCK[player], strlen(FC_Saved.Speccs.WARLOCK[player])-1 ));
	else
		return 0;
	end
end

local function FW_HealthstoneRankByLevel(unit)
	if select(2,UnitClass(unit)) == "WARLOCK" then
		local level = UnitLevel(unit);
		if level < 10 then
			return 0;
		elseif level < 22 then
			return 1;
		elseif level < 34 then
			return 2;
		elseif level < 46 then
			return 3;
		elseif level < 58 then
			return 4;
		elseif level < 68 then
			return 5;
		elseif level < 73 then
			return 6;
		elseif level < 78 then
			return 7;
		else
			return 8;
		end
	else
		return 0;
	end
end

local createhs = FW:SpellName(47878);
local function FW_HealthstoneRank()
	if FW.CLASS == "WARLOCK" then
		local high = 0;
		local spellName, spellRank;
		local i = 1
		
		while true do
			spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
			if spellName then
				if spellName == createhs then
					spellRank = tonumber(select(3,strfind(spellRank,"(%d+)")));
					if spellRank > high then
						high = spellRank;
					end
				end
				i = i + 1;
			else
				break;
			end
		end
		return high;
	else
		return 0;
	end
end

local function FW_MakeSpeccInfo(inspect) -- creates you own specc information string, or that of someone you're inspecting
	local player,class,hsrank;
	if inspect then
		if not InspectFrame or not InspectFrame.unit then return; end -- avoid saving wrong speccs to the wrong ppl for now!!
		player = UnitName("target");
		class = select(2,UnitClass("target"));
		if not player or not class or (not UnitInParty("target") and not UnitInRaid("target")) or player == FW.PLAYER then return;end
		hsrank = FW_HealthstoneRankByLevel("target");
	else
		player = FW.PLAYER;
		class = FW.CLASS;
		hsrank = FW_HealthstoneRank();
	end
	--FW:Show("building talents for "..player);
	local currentRank;
	local str = "";
	for tab=1,GetNumTalentTabs(inspect),1 do
		for i=1,GetNumTalents(tab,inspect),1 do
			currentRank = ( select( 5,GetTalentInfo(tab,i,inspect,nil,GetActiveTalentGroup(inspect)) ) );
			if currentRank > 0 then
				str = str..strformat("%02d",i)..currentRank;
			end
		end
		str=str.." ";
	end
	if not FC_Saved.Speccs[class] then
		FC_Saved.Speccs[class] = {};
	end
	if hsrank == 0 then
		FC_Saved.Speccs[class][player] = str.."00";
	else
		FC_Saved.Speccs[class][player] = str..strformat( "%02d", 3*hsrank+select(5,GetTalentInfo(2,1,inspect,nil,GetActiveTalentGroup(inspect)))-2 );
	end
	-- will later use the last digits for other classes as well, for now it's always zero for non-warlocks
end

------------------------------------------------------------------------------------------------------------------
local FW_Scans = {};
--FW.Online = {};

local function FW_ScanUnit(unit,update)
	local unitName = UnitName(unit);
	local _, unitClass = UnitClass(unit);
	local flag;
	if UnitIsConnected(unit) then
		if UnitIsDeadOrGhost(unit) then	
			flag = FW.FLAG_DEAD;
		else
			flag = FW.FLAG_NORMAL;
		end
	else
		flag = FW.FLAG_OFFLINE;
	end
	
	for i,f in ipairs(FW_Scans) do
		f(unit,unitName,unitClass,flag,update);
	end
end

local function FW_Scan()
	local update = GetTime();
	FW:RosterInfo();
	for k in pairs(FC_Saved.RaidStatus) do -- in case i want to be able to tell who left the raid
		FC_Saved.RaidStatus[k][1] = FW.FLAG_LEFT;
	end
	-- ss scan, raid or party
	if GetNumRaidMembers() > 0 then	
		-- Do scans
		for i=1,GetNumRaidMembers(),1 do
			FW_ScanUnit(RAID[i],update);
		end
	else	
		for i=1,GetNumPartyMembers(),1 do
			FW_ScanUnit(PARTY[i],update);
		end
		FW_ScanUnit("player",update);
	end
	FC_Saved.Update = update; 
	-- updating raw data complete
end

local fx2temp = {};
local ora3temp = {};

local function FW_RaidStatusScan(unit,unitName,unitClass,flag,update)
	if not FC_Saved.RaidStatus[unitName] then
		FC_Saved.RaidStatus[unitName] = {flag,update,unitClass,(unitName==FW.PLAYER and VERSION) or fx2temp[unitName] or (unitName==FW.PLAYER and _G.oRA3 and _G.oRA3.VERSION) or ora3temp[unitName]};
	end
	FC_Saved.RaidStatus[unitName][1] = flag;
	FC_Saved.RaidStatus[unitName][3] = unitClass;
	if flag ~= FW.FLAG_OFFLINE then
		FC_Saved.RaidStatus[unitName][2] = update;
	end
end

local function FW_ActionButton_UpdateCount(self)
	local text = _G[self:GetName().."Count"];
	local action = self.action;
	if not IsStackableAction(action) and ((GetActionInfo(action))=="spell" or not IsConsumableAction(action)) then
		text:SetText("");
	end
end

local function FW_RegisterBlockReagent()
	if FW.Settings.SafeBlockShardReagent then
		hooksecurefunc("ActionButton_UpdateCount", FW_ActionButton_UpdateCount);
	end
end

local SpecialSaved = {};
local function FW_Reset()
	for k, v in pairs(SpecialSaved) do
		if v==true then
			erase(FC_Saved[k]);
		end
	end
end

local function FW_ResetOld(t)
	for k, v in pairs(FC_Saved.RaidStatus) do
		if (t-v[2] > DeleteOld) then
			FC_Saved.RaidStatus[k] = nil;
		end
	end
	for key, val in pairs(SpecialSaved) do
		if val==true then
			for k, v in pairs(FC_Saved[key]) do
				if k == "Timers" then -- still old style
					if (t-v[2] > DeleteOld) then
						FC_Saved[key][k] = nil;
					end
				elseif not FC_Saved["RaidStatus"][k] then
					FC_Saved[key][k] = nil;
				end
			end
		end
	end
end

local function FW_RefreshAllFilters()
	for i,f in ipairs(FilterRefresh) do
		f();
	end
end

local function FW_InitConfig2(from,to)
	for key, val in pairs(from) do
		if type(val) == "table" then
			if to[key] == nil or type(to[key]) ~= "table" then
				to[key] = {};
			end
			FW_InitConfig2(val,to[key]);
		else
			if to[key] == nil then
				to[key] = val;
			end
		end
	end
end

function FW:CopyFromTo(from,to)
	FW_InitConfig2(from,to);
end

function FW:FullName()
	return FW.PLAYER.."-"..FW.SERVER;
end

local function FW_InitConfig()
	if FC_Saved.PROFILES[FW:FullName()] then -- load the proper profile or use the last used one if loading for the first time
		FW:UseProfile(FC_Saved.PROFILES[FW:FullName()],1); -- <-- new style profiles
	else
		FW:UseProfile(FC_Saved.PROFILE,1); -- <-- simply use the last active profile if i can't find any match
	end
end

local function FW_InitFrameVars() -- also contains compatibility fixes (these should be removed at some point, e.g. ver2.00)
	for f,d in pairs(Frames) do
		if not FW.Settings[f] then
			FW.Settings[f] = {};
		end
		if FW.Settings[f].lock == nil then -- init value
			FW.Settings[f].lock = (FW.Default[f] and FW.Default[f].lock) or FW.Settings.GlobalLock;
		end
		if FW.Settings[f].alpha == nil then -- init value
			FW.Settings[f].alpha = (FW.Default[f] and FW.Default[f].alpha) or FW.Settings.GlobalAlpha;
		end
		if FW.Settings[f].scale == nil then -- init value
			FW.Settings[f].scale = (FW.Default[f] and FW.Default[f].scale) or FW.Settings.GlobalScale;
		end
	end
end
	
local function FW_Variables()
	local t = GetTime();
	
	FC_Saved = _G.FC_Saved;
	FW.Saved = FC_Saved; -- use to access the saved table globally
	
	FW:RegisterSpecialSaved("Profiles",false,{["Profile"]={}});
	FW:RegisterSpecialSaved("ProfileNames",false,{{"Profile","Default"}});
	FW:RegisterSpecialSaved("VERSION",false,"");
	FW:RegisterSpecialSaved("RAID",false,false);
	FW:RegisterSpecialSaved("GROUPED",false,false);
	FW:RegisterSpecialSaved("PROFILE",false,"Profile");
	FW:RegisterSpecialSaved("PROFILES",false,{});
	
	FW:RegisterSpecialSaved("Speccs",false,{});
	FW:RegisterSpecialSaved("Exceptions",false,{});
	FW:RegisterSpecialSaved("Update",false,0);
	
	FW:RegisterSpecialSaved("RaidStatus",true,{});	 -- need a last seen table
	
	FW:RegisterSpecialSaved("Timers",true,{}); -- old style
	FW:RegisterSpecialSaved("Cooldowns",true,{}); -- old style

	FW:RegisterSpecialSaved("Healthstone",true,{}); -- new style
	FW:RegisterSpecialSaved("Shards",true,{}); -- new style
	
	FW_InitConfig2(FW.Exceptions,FC_Saved.Exceptions);
	
	--FC_Saved.VERSION = "v1.959.1"; -- REMOVE IF NOT TESTING!!!!!
	
	if FC_Saved.VERSION ~= VERSION then -- version change
	
		-- !!! COMPATIBILITY FIXES !!! --
		if FC_Saved.VERSION ~= "" then
			if FC_Saved.VERSION < "v1.90" then
				local err = "ForteXorcist: You are updating from a too old version. See your default chat window for solutions.";
				local err2 = "ForteXorcist: You are updating from a too old version. If you want to keep your settings and make this work, install and run v1.958 first and then this version. If you don't care about keeping your old settings type in '/fx resetall' (without the quotation marks). ForteXorcist will then restart as if it were a fresh install.";
				FW:Show(err2,1,0,0);
				BasicScriptErrors:Show();
				BasicScriptErrorsText:SetText(err);
				return;
			end
			if FC_Saved.VERSION < "v1.959" then
				if FC_Saved.Profiles then
					for p,d in pairs( FC_Saved.Profiles ) do
						if FC_Saved.Profiles[p]["Timer"] then
							FC_Saved.Profiles[p]["Timer"]["BlinkEnable"] = FC_Saved.Profiles[p]["Timer"]["Blink"];
							FC_Saved.Profiles[p]["Timer"]["Blink"] = 3;
						end
					end
				end
			end
			if FC_Saved.VERSION < "v1.959.2" then
				if FC_Saved.Profiles then
					erase(FC_Saved.ProfileNames);
					for p,d in pairs( FC_Saved.Profiles ) do
						tinsert(FC_Saved.ProfileNames,{p,p});
					end
				end
			end
			if FC_Saved.VERSION < "v1.959.5" then
				FC_Saved.GotORA = nil; -- no longer used
				FC_Saved.Warlocks = nil; -- no longer used
				
				FC_Saved.Shards = {}; -- reset
				FC_Saved.Healthstone = {}; -- reset
				FC_Saved.Cooldowns = {}; -- reset
			end
			if FC_Saved.VERSION < "v1.959.7" then
				FC_Saved.PARTY = nil; -- no longer used
			end
			
		end
		-- !!! END COMPATIBILITY FIXES !!! --
		
		FC_Saved.VERSION = VERSION;
	end
	FWOptions.Update = function(self)
		self:SetScale(FW.Settings.FWOptions.scale);
		self:SetAlpha(FW.Settings.FWOptions.alpha);
		FW:CorrectPosition(self);
	end;
	
	FW.GROUPED = FC_Saved.GROUPED;
	FW.RAID = FC_Saved.RAID;
	
	FW:RegisterFrame("FWOptions",FWOptions); -- needs to be done at least before FW_InitConfig!!!
	
	FW_InitConfig();
	
	FW.tab_data[1] = FC_Saved.PROFILE;
	FW.tab_data[6] = FC_Saved.ProfileNames;
	
	FW:Show(FW:Title().." - /fx for options",0,1,0);
	FW:Show("Class Module: "..FW.ClassModules.." - Modules: "..FW:Size(FW.Modules),0,1,0);
	
	FW:Debug("Warning: Debug mode is on!");
	
	if FC_Saved.Update > t then -- pc rebooted, have to clear all timers
		FW_Reset();
	else
		FW_ResetOld(t);
	end

	for i,f in ipairs(FW_VariablesLoaded) do
		f();
	end
end

function FW:Title()
	return FW.TITLE.." "..VERSION.." by Xus - "..FW:ProfileSaveToDisplayName(FC_Saved.PROFILE);
end

function FW:RegisterEnterPartyRaid(func)
	tinsert(FW_EnterPartyRaid,func);
end

local function FW_PartyRaid() -- also run on ui load plx!
	for i,f in ipairs(FW_EnterPartyRaid) do
		f(FW.GROUPED);
	end
end

local function FW_TimedRaidParty()
	local t1, t2 = IsInInstance();
	local t3;
	local party,raid;
	if t1 and t2 ~= "raid" and t2 ~= "party" then -- switch everything raid related off if we're inside a battleground
		raid = false;
		party = false;
	else
		raid = GetNumRaidMembers()>0;
		party = GetNumPartyMembers()>0;
	end
	if FW.RAID ~= raid then
		FC_Saved.RAID = raid;
		FW.RAID = raid;
	end
	t3 = raid or party;
	if FW.GROUPED ~= t3 then
		FC_Saved.GROUPED = t3;
		FW.GROUPED = t3;
		FW_PartyRaid();
	end
end

-- ids here in in string form, not numbers!
function FW:RegisterSet(name,...)
	for i=1,select('#',...), 1 do
		FW.Sets[select(i,...)] = name;
	end
end

local function FW_RelevantTalent()
	--FW:Show("TALENTS");
	for tab=1,GetNumTalentTabs(),1 do
		for i=1,GetNumTalents(tab),1 do
			local name, _, _, _, rank = GetTalentInfo(tab, i, nil,nil,GetActiveTalentGroup());
			if FW.Talent[name] then
				FW.Talent[name] = rank;
			end
		end
	end
end

local function FW_RelevantStance()
	FW.Stance = GetShapeshiftForm();
	--FW:Show("STANCE "..FW.Stance);
end

local function FW_RelevantGlyph()
	--FW:Show("check");
	for k, v in pairs(FW.Glyph) do
		FW.Glyph[k] = 0;
	end
	local _,enabled, glyphSpell;
	for i = 1, 6, 1 do
		--FW:Show("moo");
		enabled, _, glyphSpell = GetGlyphSocketInfo(i,GetActiveTalentGroup());
		if glyphSpell then
			if enabled then
				--FW:Show(GetSpellInfo(glyphSpell));
				FW.Glyph[GetSpellInfo(glyphSpell)] = 1;
			end
		end
	end
end

local function FW_RelevantSetBonus()
	--FW:Show( "SET SCAN" );
	for k, v in pairs(FW.SetBonus) do
		FW.SetBonus[k] = 0;
	end
	local t1;
	for i=1,12,1 do -- from head to 2nd ring
		t1 = GetInventoryItemLink("player", i);
		if t1 then
			t1 = select(3,strfind(t1,"^|c.-|Hitem:(.-):"));
			--FW:Show(t1);
			t1 = FW.Sets[t1];
			if t1 then
				FW.SetBonus[t1] = FW.SetBonus[t1] + 1;
			end
		end
	end
end

do
	local UnitBuff = FW.UnitBuff;
	local UnitDebuff = FW.UnitDebuff;
	local isMine = {["player"]=true,["pet"]=true,["vehicle"]=true};
	--[[function FW:UnitHasBuff(unit,buff) -- returns expirationTime
		--name 1, rank 2, icon 3, count 4, debuffType 5, duration 6, expirationTime 7, isMine 8, isStealable
		local d,t;
		d,_,_,_,_,_,t = UnitBuff(unit,buff);
		if d then return t; end
	end]]

	-- USE UnitBuff or UnitDebuff IF I DONT NEED THE INDEX (OR NEED MORE DATA OFC)
	function FW:UnitHasBuff(unit,buff) -- returns expirationTime, index
		-- name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
		local b = 1;
		local _,d,t,s,tt;--buff name, texture
		while true do
			d,_,_,s,_,tt,t = UnitBuff(unit,b);
			if d then
				if d == buff then
					return t,b,s,tt;
				end
				b=b+1;
			else
				return nil,b,0,0;
			end
		end
	end

	--[[function FW:UnitHasBuffID(unit,buffid) -- returns expirationTime, index
		-- name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId 
		local b = 1;
		local d,t,s,tt,id;--buff name, texture
		while true do
			d,_,_,s,_,tt,t,_,_,_,id = UnitBuff(unit,b);
			if d then
				if id == buffid then
					return t,b,s,tt,d;
				end
				b=b+1;
			else
				return nil,b,0,0,nil;
			end
		end
	end]]

	function FW:UnitHasYourBuff(unit,buff) -- returns expirationTime, index
		--name 1, rank 2, icon 3, count 4, debuffType 5, duration 6, expirationTime 7, isMine 8, isStealable 
		local b = 1;
		local _,d,t,m,s,tt;--buff name, texture
		while true do
			d,_,_,s,_,tt,t,m = UnitBuff(unit,b);
			if d then
		
				if d == buff and isMine[m] then
					return t,b,s,tt;
				end
				b=b+1;
			else
				return nil,b,0,0;
			end
		end
	end

	--[[function FW:UnitHasDebuff(unit,debuff) -- returns timeleft	--name 1, rank 2, icon 3, count 4, debuffType 5, duration 6, expirationTime 7, isMine 8, isStealable 
		local d,t;
		d,_,_,_,_,_,t = UnitDebuff(unit,debuff);
		if d then return t; end
	end]]
	-- USE UnitBuff or UnitDebuff IF I DONT NEED THE INDEX (OR NEED MORE DATA OFC)
	function FW:UnitHasDebuff(unit,debuff) -- returns expirationTime, index
		--name 1, rank 2, icon 3, count 4, debuffType 5, duration 6, expirationTime 7, isMine 8, isStealable 
		local b = 1;
		local _,d,t,s,tt;--debuff name, expire time, mine
		while true do -- castable by you
			d,_,_,s,_,tt,t = UnitDebuff(unit,b);
			if d then
				if d == debuff then
					return t,b,s,tt;
				end
				b=b+1;
			else
				return nil,b,0,0;
			end
		end
	end

	function FW:UnitHasYourDebuff(unit,debuff) -- returns expirationTime, index
		--name 1, rank 2, icon 3, count 4, debuffType 5, duration 6, expirationTime 7, isMine 8, isStealable 
		local b = 1;
		local _,d,t,m,s,tt,r;--debuff name, expire time, mine
		while true do -- castable by you
			d,r,_,s,_,tt,t,m = UnitDebuff(unit,b);
			if d then
				if d == debuff and isMine[m] then
					--FW:Show("found");
					return t,b,s,tt,r;
				end
				b=b+1;
			else
				return nil,b,0,0,0;
			end
		end
	end
	
end

function FW:SecToTimeD(t)
	if FW.Settings.TimeFormat then
		if t >= 60 then 
			return math.floor(t/60)..":"..strformat("%02d",t%60);
		else
			return strformat("%.1f",t);
		end
	else
		if t >= 60 then return ceil(t/60).."m";else return floor(t).."s"; end
	end
end

function FW:SecToTime(t)
	if FW.Settings.TimeFormat then
		return math.floor(t/60)..":"..strformat("%02d",t%60);
	else
		if t >= 60 then return ceil(t/60).."m"; else return floor(t).."s";end
	end
end

function FW:NameToRaidID(name)
	for i=1,GetNumRaidMembers(),1 do
		if name == UnitName(RAID[i]) then
			return RAID[i];
		end
	end
end
function FW:NameToPartyID(name)
	for i=1,GetNumPartyMembers(),1 do
		if name == UnitName(PARTY[i]) then
			return PARTY[i];
		end
	end
end
function FW:NameToID(name)
	if name == FW.PLAYER then return "player";end
	for i=1,GetNumPartyMembers(),1 do
		if name == UnitName(PARTY[i]) then
			return PARTY[i];
		end
	end
	for i=1,GetNumRaidMembers(),1 do
		if name == UnitName(RAID[i]) then
			return RAID[i];
		end
	end
end

function FW:RosterInfo()
	if GetNumRaidMembers()>0 then
		local _,t1,t2,t3;
		for i=1,40,1 do
			t1, t2, _, _, _, _, t3 = GetRaidRosterInfo(i);
			if t1 then
				FW.Ranks[t1] = t2;
				FW.Zones[t1] = t3;
			end
		end
	end
end

function FW:IsWarlock(unit)
	if select(2,UnitClass(unit)) == "WARLOCK" then return 1;end
end

function FW:GotSoulstone() -- returns the name of the best ss in your inventory
	for i=#FW.ID_SOULSTONE ,1,-1 do
		if GetItemCount(FW.ID_SOULSTONE[i]) ~= 0 then
			return FW:ItemName(FW.ID_SOULSTONE[i]);
		end
	end
end

function FW_GotShards() -- returns number of shards
	return GetItemCount(FW.ID_SOULSHARD);
end

local createss = FW:SpellName(47884);
function FW:BestSoulstone() -- returns name of best soulstone you can create, ising in cooldown and soulstone module
	if FW.CLASS == "WARLOCK" then
		local i = 1
		local high = 1;
		local spellName, spellRank;
		while true do
			spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
			if spellName then
				if spellName == createss then
					spellRank = tonumber(select(3,strfind(spellRank,"(%d+)")));
					if spellRank > high then
						high = spellRank;
					end
				end
				i = i + 1;
			else
				break;
			end
		end
		return FW:ItemName(FW.ID_SOULSTONE[high]);
	else
		return FWL.NONE;
	end
end

function FW:GotThisHealthstone(healthstone) -- returns the best hs of this name
	for i=#FW.ID_HEALTHSTONE,1,-1 do
		if FW:ItemName(FW.ID_HEALTHSTONE[i][1]) == healthstone then
			if GetItemCount(FW.ID_HEALTHSTONE[i][1]) ~= 0 then
				return FW.ID_HEALTHSTONE[i][1],FW.ID_HEALTHSTONE[i][2];
			end
		end
	end
end

function FW:GotHealthstone() -- returns the name of the best hs in your inventory
	for i=#FW.ID_HEALTHSTONE,1,-1 do
		if GetItemCount(FW.ID_HEALTHSTONE[i][1]) ~= 0 then
			return FW:ItemName(FW.ID_HEALTHSTONE[i][1]),FW.ID_HEALTHSTONE[i][2],i;
		end
	end
	return FWL.NONE,FWL.NONE,0;
end

function FW:BestHealthstone()
	if FW.CLASS == "WARLOCK" then
		local index = FW:HealthstoneSpecc(FW.PLAYER);
		local high = math.ceil(index/3);
		return FW:ItemName(FW.ID_HEALTHSTONE[index][1]),index,high;
	else
		return FWL.NONE,0,0;
	end
end

--[[
function FW:TimeStart()
	FW.StartTime = GetTime();
end

function FW:TimeEnd(label)
	FW:Show(label..": "..(GetTime()-FW.StartTime),0,0,1);
end]]

local function FW_SendVersion()
	FW:SendData(SEND_VERSION..VERSION);
end


local function FW_SendSpeccInfo()
	if FC_Saved.Speccs[FW.CLASS] and FC_Saved.Speccs[FW.CLASS][FW.PLAYER] then
		FW:SendData(SEND_SPECC..FC_Saved.Speccs[FW.CLASS][FW.PLAYER]);
	--else
		--FW:Show("failed to send");
	end
end

local function FW_AddonMessage(msg,from)
	for i,d in ipairs(FW_Messages) do
		if strfind(msg,d[1]) then
			FW:Debug("FX2 Running function for "..d[1],0,1,1);
			if d[2]( strsub(msg,strlen(d[1])), from ) then return; end
		end
	end
end

local function FW_AddonMessageReceived(event,...)
	local arg1,arg2,arg3,arg4 = ...;
	if arg1 == "FX2" then
		--FW:Debug(arg4..": "..arg2,0,1,1);
		if arg4 ~= FW.PLAYER then -- ignore messages from self
			FW_AddonMessage(arg2,arg4);
		end
	elseif arg1 == "oRA3" then
		if FC_Saved.RaidStatus[arg4] then
			if not FC_Saved.RaidStatus[arg4][4] then
				FC_Saved.RaidStatus[arg4][4] = 1;
			end
		else
			ora3temp[arg4] = 1;
		end
		--[[local debug = GetTime().." "..event;
		if arg1 then debug = debug.." "..tostring(arg1); end
		if arg2 then debug = debug.." "..tostring(arg2); end
		if arg3 then debug = debug.." "..tostring(arg3); end
		if arg4 then debug = debug.." "..tostring(arg4); end
		FW:Show(debug,0,1,1);]]
		local _,t1,t2;
		for i,d in ipairs(FW_oRAMessages) do
			_,_,t1,t2 = strfind(arg2,d[1]);
			if t1 then
				FW:Debug("oRA3 Running function for "..d[1],0,1,1);
				if d[2]( t1,t2, arg4 ) then return; end -- stop looking if function actually returns something
			end
		end
	end
end

--------------------------------------------

function FW:SendData(msg)
	FW_AddonMessage(msg,FW.PLAYER);
	if FW.GROUPED then
		SendAddonMessage("FX2",msg,"RAID");
	end
end
--------------------------------------------

function FW_CheckHealthstone()
	FW:Debug("HS check response");
	FW:SendHealthstone(FC_Saved.Healthstone[FW.PLAYER] or -1);
end

function FW_CheckShards()
	FW:Debug("SH check response");
	FW:SendShards(FC_Saved.Shards[FW.PLAYER] or -1);
end

-- still want to reply to shards/healstonew requests no matter what modules are loaded
function FW:SendShards(n)
	SendAddonMessage("FX2",FW.SEND_SHARDS..n,"RAID");--can completely ignore this yourself
end

function FW:SendHealthstone(id)
	SendAddonMessage("FX2",FW.SEND_HEALTHSTONE..id,"RAID");--can completely ignore this yourself
end

---------------------------------------------------------------------------
-- register functions
---------------------------------------------------------------------------
local FW_Chill = FW:NEW2D();

function FW:RegisterChill(func,arg1) -- every same function will only be triggered 20x per second by default
	for i=1,FW_Chill.rows,1 do
		 if FW_Chill[i][1] == func and FW_Chill[i][2] == arg1 then
			return;
		 end
	end
	FW_Chill:insert(func,arg1);
end

local function FW_ExecuteChill()
	for i=1,FW_Chill.rows,1 do
		--FW:Show(tostring(FW_Chill[i][1]).."("..tostring(FW_Chill[i][2])..")");
		FW_Chill[i][1](FW_Chill[i][2]);
	end
	FW_Chill:erase();
end

function FW:RegisterORAMessage(start,func,ignorewithfw) -- note that the ora message recognition needs the function to give a return value to stop/break early
	tinsert(FW_oRAMessages,{"^"..start,func}); -- ignorewithfw IS DISABLED
end

function FW:RegisterMessage(start,func,merge) -- will always stop/break when a prefix match is found at this time
	tinsert(FW_Messages,{"^"..start,func});
end

function FW:RegisterSpecialSaved(saved,reset,default)
	SpecialSaved[saved] = reset;
	if FC_Saved[saved]==nil then  FC_Saved[saved] = default; end
end

function FW:RegisterOnProfileChange(func)
	tinsert(FilterRefresh,func);
end

-- the normal events aren't accurate enough in case of zoning for instance
function FW:RegisterOnLeaveCombat(func)
	tinsert(FW_OnLeaveCombat,func);
end
function FW:RegisterOnEnterCombat(func)
	tinsert(FW_OnEnterCombat,func);
end

function FW:RegisterScan(func)
	tinsert(FW_Scans,func);
end

function FW:AddCommand(k,f)
	Commands[k] = f;
end

function FW:GetFrame(name)
	return Frames[name];
end

function FW:UnregisterFrame(name)
	Frames[name]:Hide();
	Frames[name] = nil;
end

function FW:RegisterFrame(name,frame,combat_sensitive,instanceof)
	Frames[name] = frame;
	Frames[name].combat_sensitive = combat_sensitive;
	Frames[name].name = name;
	Frames[name].instanceof = instanceof;
end

function FW:RegisterVariablesEvent(func)
	tinsert(FW_VariablesLoaded,func);
end

function FW:RegisterLoadEvent(func)
	tinsert(FW_Loaded,func);
end

function FW:RegisterDelayedLoadEvent(func)
	tinsert(FW_DelayedLoaded,func);
end
---------------------------------------------------------------------------
-- some local frame functions
---------------------------------------------------------------------------
function FW:GetCenter(frame)
	local x,y = frame:GetCenter()
	return x*frame:GetEffectiveScale(),y*frame:GetEffectiveScale();
end

function FW:RefreshFrames()
	for f,d in pairs(Frames) do
		d:Update();
	end
end

function FW:SetPosition(frame,x,y)
	frame:ClearAllPoints();
	frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x/frame:GetEffectiveScale(), y/frame:GetEffectiveScale());
end

local function FW_InitFramePositions(onload)
	for f,d in pairs(Frames) do	
		if FW.Settings[f].x == nil or FW.Settings[f].y == nil then
			FW.Settings[f].x,FW.Settings[f].y = FW:GetCenter(UIParent);
		else
			FW:SetPosition( d ,FW.Settings[f].x,FW.Settings[f].y);
		end
	end
end
---------------------------------------------------------------------------
-- globally accessable
---------------------------------------------------------------------------

function FW:ToGroup(msg)
	if not FW.Settings["OutputRaid"] then return; end
	if GetNumRaidMembers() > 0 then
		SendChatMessage(msg,"RAID");
	elseif GetNumPartyMembers() > 0 then
		SendChatMessage(msg,"PARTY");
	else
		FW:Show(msg);
	end

end

function FW:ToChannel(msg)
	if not FW.Settings["Output"] then return; end
	if strlower(FW.Settings["OutputMsg"]) == "say" then
		SendChatMessage(msg,"SAY");
	else
		local index = tonumber(FW.Settings["OutputMsg"]) or GetChannelName(FW.Settings["OutputMsg"]);
		if index then
			SendChatMessage(msg,"CHANNEL",nil,index);
		end
	end
end

function FW:PlaySound(option)
	if FW.Settings[option.."Enable"] then
		for i=1,FW.Settings[option.."Volume"],1 do
			PlaySoundFile(FW.Settings[option]);
		end
	end
end

function FW:MixColors(v,c1,c2)
	-- v == 0 then color = c1, v == 1 then color = c2
	if v<0 then v=0; elseif v>1 then v=1;end
	return c1[1]*(1-v)+c2[1]*v,c1[2]*(1-v)+c2[2]*v,c1[3]*(1-v)+c2[3]*v;
end

function FW:MixColors2(v,c1r,c1g,c1b,c2r,c2g,c2b)
	-- v == 0 then color = c1, v == 1 then color = c2
	if v<0 then v=0; elseif v>1 then v=1;end
	return c1r*(1-v)+c2r*v,c1g*(1-v)+c2g*v,c1b*(1-v)+c2b*v;
end

function FW:Whisper(msg,to)
	SendChatMessage(msg,"WHISPER",nil,to);
end

function FW:Size(t)
	local i = 0;
	for k, v in pairs(t) do i=i+1;end
	return i;
end

local loadclones = {};
function FW:RegisterLoadClones(func)
	tinsert(loadclones,func);
end

local function FW_InitClones()
	for i,f in ipairs(loadclones) do
		f();
	end
end

function FW:DeleteProfile(name)
	if FC_Saved.Profiles[name] == nil then return; end
	if #FC_Saved.ProfileNames>1 then
		for i, v in ipairs(FC_Saved.ProfileNames) do
			if v[1] == name then
				tremove(FC_Saved.ProfileNames,i);
				break;
			end
		end
		FW:UseProfile(FC_Saved.ProfileNames[1][1]);
		FC_Saved.Profiles[name]=nil;
	end
end

function FW:CreateProfile(name,displayname)
	if FC_Saved.PROFILE == name then return;end
	
	if FC_Saved.Profiles[name] == nil then
		FC_Saved.Profiles[name] = {};
	else
		erase(FC_Saved.Profiles[name]);
	end
	FW_InitConfig2(FW.Settings,FC_Saved.Profiles[name]);
	tinsert(FC_Saved.ProfileNames,{name,displayname or name}); -- save in the 'savedname-displayrename' table
	FW:UseProfile(name);
end

function FW:UseProfile(name,onload)
	if FC_Saved.Profiles[name] == nil then -- make sure i always load a profile!!!!
		if FC_Saved.Profiles[FC_Saved.PROFILE] then
			name = FC_Saved.PROFILE;
		else
			for key, val in pairs(FC_Saved.Profiles) do
				name = key;
				break;
			end
		end
	end
	FW.Options[1].selected = name;
	FC_Saved.PROFILE = name;
	FC_Saved.PROFILES[FW:FullName()] = FC_Saved.PROFILE;
	FW.Settings = FC_Saved.Profiles[FC_Saved.PROFILE];
	FW_InitConfig2(FW.Default,FW.Settings);
	
	FW_InitClones();
	FW_InitFrameVars(); -- always do, since profiles may still need fixing
	FW_InitFramePositions(); -- always do, since profiles may still need fixing
	FW:RefreshFrames(); -- also updates the settings tables of clones, so make sure this is called before doing anything with them
	if not onload then
		FW_RefreshAllFilters();
		FW:BuildOptions();
		FW:RefreshOptions();
	end	
end

function FW:ProfileDisplayToSaveName(displayname)
	for i, v in ipairs(FC_Saved.ProfileNames) do
		if strlower(v[2]) == strlower(displayname) then
			return v[1];
		end
	end
end

function FW:ProfileSaveToDisplayName(savename)
	for i, v in ipairs(FC_Saved.ProfileNames) do
		if v[1] == savename then
			return v[2];
		end
	end
end

function FW:RenameProfile(name,newname)
	for i, v in ipairs(FC_Saved.ProfileNames) do
		if v[1] == name then
			FC_Saved.ProfileNames[i][2] = newname;
			break;
		end
	end
	FW:BuildOptions();
	FW:RefreshOptions();
end

function FW:ShowTimeFor(spell,target,timeleft,iscooldown)
	if spell ~= target then -- really has a target
		if bit.band(1,FW.Settings.TimeLeft) ~= 0 then
			FW:ToGroup( strformat( FW.Settings.TimeLeftMsg,spell,target, FW:SecToTimeD(timeleft) ) );
		end
		if bit.band(2,FW.Settings.TimeLeft) ~= 0 then
			FW:ToChannel( strformat( FW.Settings.TimeLeftMsg,spell,target, FW:SecToTimeD(timeleft) ) );
		end
	else
		if iscooldown then
			if bit.band(1,FW.Settings.CooldownLeft) ~= 0 then
				FW:ToGroup( strformat( FW.Settings.CooldownLeftMsg,spell,FW:SecToTimeD(timeleft) ) );
			end
			if bit.band(2,FW.Settings.CooldownLeft) ~= 0 then
				FW:ToChannel( strformat( FW.Settings.CooldownLeftMsg,spell,FW:SecToTimeD(timeleft) ) );
			end
		else
			if bit.band(1,FW.Settings.TimeLeftNoTarg) ~= 0 then
				FW:ToGroup( strformat( FW.Settings.TimeLeftNoTargMsg,spell,FW:SecToTimeD(timeleft) ) );
			end
			if bit.band(2,FW.Settings.TimeLeftNoTarg) ~= 0 then
				FW:ToChannel( strformat( FW.Settings.TimeLeftNoTargMsg,spell,FW:SecToTimeD(timeleft) ) );
			end
		end
	end
end
---------------------------------------------------------------------------
-- template/option functions
---------------------------------------------------------------------------
local function FW_LoadedFunc()
	for i, f in ipairs(FW_Loaded) do
			f();
	end
end

local FW_Bindings = {};
function FW:RegisterButtonPress(bindingname,buttonname,button)
	table.insert(FW_Bindings, {bindingname,buttonname,button} );
end

local function FW_UpdateBindings()
	--FW:Show("update");
	if not InCombatLockdown() then
		for i,t in ipairs(FW_Bindings) do
			ClearOverrideBindings(_G[t[2]]);
		end
		for i,t in ipairs(FW_Bindings) do
			local b1,b2 = GetBindingKey(t[1]);
			if b1 then
				SetOverrideBindingClick(_G[t[2]], false, b1,t[2],t[3]);
			end
			if b2 then
				SetOverrideBindingClick(_G[t[2]], false, b2,t[2],t[3]);
			end
		end
	end
end

local function FW_ScanBags() -- send item counts regardless of installed modules to improve usefulness
	FW:Debug("scan bags");
	if FW.CLASS == "WARLOCK" then
		if not FC_Saved.Shards[FW.PLAYER] then
			FC_Saved.Shards[FW.PLAYER] = -1;
		end
		local t1 = FW_GotShards();
		if t1 ~= FC_Saved.Shards[FW.PLAYER] then
			FC_Saved.Shards[FW.PLAYER] = t1;
			if FW.GROUPED then
				FW:SendShards(t1);
			end
		end
	end
	if not FC_Saved.Healthstone[FW.PLAYER] then
		FC_Saved.Healthstone[FW.PLAYER] = -1;
	end
	local _,_,t3=FW:GotHealthstone();
	if FC_Saved.Healthstone[FW.PLAYER] ~= t3 then
		FC_Saved.Healthstone[FW.PLAYER] = t3;
		if FW.GROUPED then
			FW:SendHealthstone(t3);
		end
	end
end
local function FW_ScanBagsChilled()
	FW:RegisterChill(FW_ScanBags);
end
---------------------------------------------------------------------------
-- options & events
---------------------------------------------------------------------------

-- things to do at load (after load delay)
FW:RegisterDelayedLoadEvent(FW_Scan);
FW:RegisterDelayedLoadEvent(FW_RelevantSetBonus);
FW:RegisterDelayedLoadEvent(FW_RelevantTalent);
FW:RegisterDelayedLoadEvent(FW_RelevantGlyph);
FW:RegisterDelayedLoadEvent(FW_RelevantStance);
FW:RegisterDelayedLoadEvent(FW_TimedRaidParty);
FW:RegisterDelayedLoadEvent(FW_PartyRaid);
FW:RegisterDelayedLoadEvent(FW_MakeSpeccInfo);--doesnt work at load event
FW:RegisterDelayedLoadEvent(FW_ScanBagsChilled);

FW:RegisterOnLeaveCombat(FW_InitFramePositions); -- this is just a 'backup' init

FW:RegisterScan(FW_RaidStatusScan);

-- done when all addon variables are loaded
FW:RegisterVariablesEvent(function()
	
	FW:RegisterTimedEvent("UpdateInterval",		FW_TimedRaidParty);
	FW:RegisterTimedEvent("UpdateInterval",		FW_Scan);
	FW:RegisterTimedEvent("Chill",				FW_ExecuteChill);
	
	FW_RegisterBlockReagent();
	
	FW:RegisterToEvent("PLAYER_TALENT_UPDATE",	FW_RelevantTalent);
	FW:RegisterToEvent("PLAYER_TALENT_UPDATE",	function() FW_MakeSpeccInfo(nil); end);
	FW:RegisterToEvent("PLAYER_TALENT_UPDATE",	function() FW_SendSpeccInfo(nil); end);
	
	FW:RegisterToEvent("UPDATE_SHAPESHIFT_FORM", FW_RelevantStance);
end);
FW:RegisterToEvent("UPDATE_BINDINGS",			FW_UpdateBindings);

FW:RegisterToEvent("PLAYER_REGEN_ENABLED",		FW_LeaveCombat);
FW:RegisterToEvent("PLAYER_REGEN_DISABLED",		FW_EnterCombat);
FW:RegisterToEvent("PLAYER_ALIVE",				FW_Ress)
FW:RegisterToEvent("PLAYER_UNGHOST",			FW_Ress);
FW:RegisterToEvent("PLAYER_LEAVING_WORLD",		function() LeaveCombat = 1; end);
FW:RegisterToEvent("UNIT_INVENTORY_CHANGED",	function() FW:RegisterChill(FW_RelevantSetBonus);end);

FW:RegisterToEvent("VARIABLES_LOADED",			FW_Variables);
FW:RegisterToEvent("INSPECT_TALENT_READY",		function() FW_MakeSpeccInfo(1); end);
FW:RegisterToEvent("CHAT_MSG_ADDON",			FW_AddonMessageReceived);

FW:RegisterToEvent("PLAYER_ENTERING_WORLD", 	FW_LoadedFunc);

FW:RegisterToEvent("UNIT_PET", function(event,arg1) if arg1 == "player" then FW:Changed("pet");end end);

FW:RegisterToEvent("GLYPH_ADDED", 	function() FW:RegisterChill(FW_RelevantGlyph); end);
FW:RegisterToEvent("GLYPH_REMOVED", function() FW:RegisterChill(FW_RelevantGlyph); end);
FW:RegisterToEvent("GLYPH_UPDATED", function() FW:RegisterChill(FW_RelevantGlyph); end);

FW:RegisterToEvent("PARTY_MEMBERS_CHANGED",FW_TimedRaidParty);

FW:RegisterToEvent("BAG_UPDATE",FW_ScanBagsChilled);

FW:RegisterEnterPartyRaid( function(joined) if joined then FW_VersionCheck();end end );
FW:RegisterEnterPartyRaid( function(joined) if joined then FW_GetSpeccInfo();end end );

SlashCmdList["FORTEXORCIST"] = function(msg)
	local s = strsplit(" ",msg);
	if Commands[s] then
		Commands[s]( strsub(msg,strlen(s)+2) );
	else
		FW:ToggleOptions();
	end
end
SLASH_FORTEXORCIST1 = "/fw";
SLASH_FORTEXORCIST2 = "/fortewarlock";
SLASH_FORTEXORCIST3 = "/fc";
SLASH_FORTEXORCIST4 = "/forteclass";
SLASH_FORTEXORCIST5 = "/fx";
SLASH_FORTEXORCIST6 = "/fortexorcist";
	
FW:AddCommand("commands",
	function()
		for k,v in pairs(Commands) do
			FW:Show(k,1,1,0);
		end
	end
);
do
	FW:AddCommand("version",
		function()
			for k, v in pairs(FC_Saved.RaidStatus) do
				if v[4] then
					if type(v[4])=="string" then
						FW:Show(k.." FX: "..v[4]);
					else
						FW:Show(k.." FX: no, oRA3: yes" );
					end
				else
					FW:Show(k.." FX: no, oRA3: ??");
				end
			end
		end
	);
end
	
local function FW_ResetOptionsFrame()
	FWOptions:ClearAllPoints();
	FWOptions:SetPoint("CENTER",UIParent, "CENTER",0,0);
	FW.Settings["FWOptions"].x,FW.Settings["FWOptions"].y = FW:GetCenter(FWOptions);
	FW.Settings["FWOptions"].alpha = 1.0;
	FW.Settings["FWOptions"].lock = false;
	FW.Settings["FWOptions"].scale = 1.0;
	
	FW.Settings.OptionsColums = 2;

	FW:BuildOptions();
	FWOptions:Update();
	FW:RefreshOptions();
end

FW:AddCommand("position",FW_ResetOptionsFrame);
FW:AddCommand("reset",FW_ResetOptionsFrame);

FW:AddCommand("resetall",
	function()
		_G.FC_Saved = {};
		ReloadUI();
	end
);

FW:AddCommand("profile",
	function(profile)
		FW:UseProfile( FW:ProfileDisplayToSaveName(profile) );
	end
);

FW:AddCommand("debug",
	function()
		FW_Debug = not FW_Debug;
		if FW_Debug then
			FW:Show("fw debugging enabled",1,1,0);
		else
			FW:Show("fw debugging disabled",1,1,0);
		end
	end
);
FW:AddCommand("wowbuild",
	function()
		local version, build, date, tocversion = GetBuildInfo();
		FW:Show("version:"..version..", build:"..build..", date:"..date..", tocversion:"..tocversion);
	end
);

FW:RegisterMessage(FW.GET_SHARDS,
	function() 
		if FW.LastShardCheck + 5 < GetTime() then
			FW.LastShardCheck = GetTime();
			FW_CheckShards();
		end
		return 1;
	end,
nil);
FW:RegisterMessage(FW.GET_HEALTHSTONE,
	function() 
		if FW.LastHSCheck + 5 < GetTime() then
			FW.LastHSCheck = GetTime();
			FW_CheckHealthstone();
		end
		return 1;
	end,
nil);
FW:RegisterMessage(GET_VERSION,FW_SendVersion,nil);
FW:RegisterMessage(SEND_VERSION,
	function(m,f)
		if FC_Saved.RaidStatus[f] then
			FC_Saved.RaidStatus[f][4] = m;
		else
			fx2temp[f] = a1;
		end
		return 1;
	end,
nil);
FW:RegisterMessage(GET_SPECC,FW_SendSpeccInfo,nil);
FW:RegisterMessage(SEND_SPECC,
	function(m,f)
		local id = FW:NameToID(f);
		if id then
			local class = select(2,UnitClass(id));
			if not FC_Saved.Speccs[class] then
				FC_Saved.Speccs[class] = {};
			end
			FC_Saved.Speccs[class][f] =  m;
		end
		return 1;
	end,
nil);

FW.Default.CustomInstances = {}; -- used to store per profile custom frame instances

FW.Default.OptionsFontLabelColor = {1,1,1};
FW.Default.OptionsFontInputColor = {1,1,1};

FW.Default.AnimationInterval = 0.04;
FW.Default.LoadDelay = 1;
FW.Default.UpdateInterval = 0.5;
FW.Default.Chill = 0.05;

FW.Default.AnimateScroll = true;

FW.Default.FrameSnapDistance = 5;
FW.Default.FrameDistance = 0;
FW.Default.FrameSnap = true;
--FW.Default.FrameAnchor = false;
FW.Default.OptionsColums = 2;
FW.Default.OptionsHeight = 440;

FW.Default.TimeFormat = true;
FW.Default.Texture = "Interface\\AddOns\\Forte_Core\\Textures\\Aluminium";

FW.Default.BlockShardReagent = false;
FW.Default.SafeBlockShardReagent = false;
FW.Default.RightClickOptions = true;
FW.Default.RightClickIconOptions = true;

FW.Default.OptionBackgroundColor = {0.40,0.40,0.40,0.90};
FW.Default.OptionHeaderColor = {0.20,0.20,0.20};

FW.Default.Font = "Interface\\AddOns\\Forte_Core\\Fonts\\GOTHIC.TTF";
FW.Default.FontSize = 11;
FW.Default.GlobalLock = false;
FW.Default.GlobalAlpha = 1.0;
FW.Default.GlobalScale = 1.0;

FW.Default.SparkColor = {1.00,1.00,1.00,1.00};
FW.Default.SparkEnable = false;

FW.Default.OutputRaid = true;
FW.Default.Output = true;
FW.Default.OutputMsg = "MyProChannel";

FW.Default.OptionsModuleColor = true;
FW.Default.Tips = true;

FW.Default.TimeLeft = 1; FW.Default.TimeLeftMsg = ">> %s on %s is fading in %s <<";
FW.Default.TimeLeftNoTarg = 1; FW.Default.TimeLeftNoTargMsg = ">> %s is fading in %s <<";
FW.Default.CooldownLeft = 1; FW.Default.CooldownLeftMsg = ">> %s is ready in %s <<";

FW.Default.GlobalFrameNames = false;

FW.Default.Strata = "MEDIUM";

--[[FW.Default.Backdrop = {
	"Interface\\AddOns\\Forte_Core\\Textures\\Background",
	"Interface\\AddOns\\Forte_Core\\Textures\\Border",
	false,16,5,5
}]]
FW.Default.OptionsBackdrop = {
	"Interface\\AddOns\\Forte_Core\\Textures\\Background",
	"Interface\\AddOns\\Forte_Core\\Textures\\Border",
	false,16,5,5
}
FW.Default.OptionsHeaderBackdrop = {
	"Interface\\AddOns\\Forte_Core\\Textures\\Otravi",
	"None",
	false,16,1,1
}
FW.Default.OptionsSubHeaderBackdrop = {
	"Interface\\AddOns\\Forte_Core\\Textures\\Smooth",
	"None",
	false,16,2,2
}

function FW:MakeBackdrop(backdrop,bg,edge,tile,tilesize,edgesize)
	if not backdrop.insets then backdrop.insets = {}; end
	backdrop.bgFile = bg;
	backdrop.edgeFile = edge;
	backdrop.tile = tile;
	backdrop.tileSize = tilesize;
	backdrop.edgeSize = edgesize;
	backdrop.insets.left = edgesize;
	backdrop.insets.right = edgesize;
	backdrop.insets.top = edgesize;
	backdrop.insets.bottom = edgesize;
end

function FW:SetBackdrop(frame,bg,edge,tile,tilesize,edgesize)
	if not frame.backdrop then frame.backdrop = {}; end
	FW:MakeBackdrop(frame.backdrop,bg,edge,tile,tilesize,edgesize);
	frame:SetBackdrop(frame.backdrop);
end