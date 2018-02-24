-- ForteXorcist v1.959.8 by Xus 13-04-2010

local FW = FW;
local FWL = FW.L;
local CA = FW:Module("Casting");
local ST; -- access to spell timer module (after loaded vars)
local CD; -- access to cooldown timer module (after loaded vars)
local GetTime = GetTime;
local strfind = strfind;
local unpack = unpack;
local pairs = pairs;
local ipairs = ipairs;
local UnitName = FW.FullUnitName;
local strformat = string.format;
local erase = FW.ERASE;
local UnitAura = UnitAura;
local SendAddonMessage = SendAddonMessage;

local LastCast = 0;

local OtherQueue = FW:NEW2D();
local FW_OnSelfCastSuccess = {};
local FW_OnSelfCastCancel = {};
local FW_OnSelfCastStart = {};
local FW_OnSelfCastEnd = {};
local FW_OnSelfCastDelay = {};
local FW_OnSelfChannelStart = {};
local FW_OnSelfChannelUpdate = {};

local FW_OnSelfCastFail = {};
local FW_OnSelfCastTracked = {};

local FW_OnPetCastSuccess = {};
local FW_OnPetCastFailed = {};
local FW_OnPetCastStart = {};

local FW_IsChannel = {}; -- keys in here are marked as special channeling spells

local CA_SelfQueue = FW:NEW2D();

-- used in casting, warlock, summon
FW.SU_CAST_START = "SuS";
FW.SU_CAST_CANCEL = "SuC";
FW.SU_CAST_END = "SuE";

FW.SS_CAST_SELF = "SF";
FW.SS_CAST_START = "SS";
FW.SS_CAST_DELAY = "SD";
FW.SS_CAST_CANCEL = "SC";
FW.SS_CAST_END = "SE";

FW.Track = {};
FW.SpellRename = {};
FW.Tick = {};
FW.Drain = {};
FW.Hasted = {};
FW.SpellHaste = 0.1; -- just an 'impossible' starting value
FW.GlobalCooldown = 1.5;
FW.TrackGCD = {};

local hastebuffs = {
	["ALL"] = {
		[FW:SpellName(32182)] = 1.30, -- heroism
		[FW:SpellName(2825)] = 1.30, -- bloodlust
		[FW:SpellName(2895)] = 1.05, -- wrath of air totem
		[FW:SpellName(10060)] = 1.20, -- power infusion
		[FW:SpellName(63277)] = 2.00, -- shadow crash
	},
	["WARLOCK"] = {
		[FW:SpellName(64371)] = 1.20, -- eradication
	},
	["DRUID"] = {
		[FW:SpellName(61346)] = 1.20, -- Nature's Grace
	},
	["SHAMAN"] = {
		[FW:SpellName(64701)] = 1.15, -- Elemental Mastery
	},
	["Troll"] = {
		[FW:SpellName(26297)] = 1.20, -- berserking
	},
	-- Improved Moonkin Form, Swift Retribution
}
-- also register the talents for 'relevant talent' function !!!!
FW.Talent[FW:SpellName(16924)] = 0; -- Celestial Focus
FW.Talent[FW:SpellName(51183)] = 0; -- Gift of the Earthmother 
local hastetalents = {
	["DRUID"] = {
		[FW:SpellName(16924)] = {1.01,1.02,1.03}, -- Celestial Focus
		[FW:SpellName(51183)] = {1.02,1.04,1.06,1.08,1.10}, -- Gift of the Earthmother 
	},
}

local function CA_AddSpecialHasteBuffs(group,haste)
	if hastebuffs[group] then
		for k, v in pairs(hastebuffs[group]) do
			if UnitAura("player",k) then
				haste = haste * v;
			end
		end
	end
	return haste;
end

local function CA_AddSpecialHasteTalents(group,haste)
	if hastetalents[group] then
		for k, v in pairs(hastetalents[group]) do
			if FW.Talent[k] > 0 then
				haste = haste * v[  FW.Talent[k] ];
			end
		end
	end
	return haste;
end

local function CA_AddSpecialHaste(haste)
	-- special haste increasing buffs per race or class
	haste = CA_AddSpecialHasteBuffs("ALL",haste);
	haste = CA_AddSpecialHasteBuffs(FW.CLASS,haste);
	haste = CA_AddSpecialHasteBuffs(FW.RACE,haste);
	-- special haste increasing talents
	haste = CA_AddSpecialHasteTalents("ALL",haste);
	haste = CA_AddSpecialHasteTalents(FW.CLASS,haste);
	haste = CA_AddSpecialHasteTalents(FW.RACE,haste);
	return haste;
end

local function CA_CheckCastSpeed()
	--FW:Show("checking cast speed");
	for key, val in pairs(FW.SpellInfo) do
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(val[1])
		if castTime then
			FW.SpellInfo[key][2] = castTime*0.001;
			FW.SpellInfo[key][3] = minRange;
			FW.SpellInfo[key][4] = maxRange;
		end
	end
	if ST then
		for i=1, ST.ST.rows, 1 do
			if FW.SpellInfo[ST.ST[i][8]] then
				ST.ST[i][2] = FW.SpellInfo[ST.ST[i][8]][2];
			end
		end
	end
end

local function CA_CheckGlobalCooldown()
	local gcd = (FW.TrackGCD[FW.Stance] or 1.5)*FW.SpellHaste;
	if gcd < 1.0 then
		gcd = 1.0;
	end
	FW.GlobalCooldown = gcd;
end

local function CA_StatsUpdate()
	local haste = CA_AddSpecialHaste( 1.0 + GetCombatRatingBonus(20)*0.01 ); 
	-- some things that increase casting speed, but not actual haste
	local newhaste = 1.0/haste;
	if FW.SpellHaste ~= newhaste then
		FW.SpellHaste = newhaste;
		CA_CheckCastSpeed();
	end
	--CA_CheckCastSpeed();
	CA_CheckGlobalCooldown();
end

-- I still can't use combat-only code because I'm lacking target info in the cast start event and a success event is lacking for non-instant casts :(

function CA:RegisterIsChannel(spell) -- only for making sure that channels being cast have the right target assigned
	FW_IsChannel[FW:SpellName(spell)] = 1;
end

function CA:Unique(unit)
	if not unit then return 0;end
	local name = UnitName(unit);
	if FW.Saved.Exceptions[name] then
		return FW.Saved.Exceptions[name];
	end
	
	if UnitPlayerControlled(unit) then
		return 2; -- unique player / pet
	elseif UnitClassification(unit) == "rareelite" or UnitClassification(unit) == "worldboss" then
		return 1; -- unique boss
	else
		return 0; -- not unique
	end
end

local validOn = {};

local function CA_ValidOn(target,unitid) -- narrow this down as much as possible (i'm asuming that i cannot cast on dead units unless they are playercontrolled)
	if target == UnitName(unitid) and (not UnitIsDead(unitid) or UnitPlayerControlled(unitid)) then
		--FW:Debug("validOn "..unitid);
		tinsert(validOn,unitid);
	end
end

local function CA_CastOn(target)
	local t,f = 0,0;
	erase(validOn);
	CA_ValidOn(target,"target");
	CA_ValidOn(target,"pet");
	CA_ValidOn(target,"vehicle");
	CA_ValidOn(target,"pettarget");
	if not FW.Settings.DisableFocus then 
		CA_ValidOn(target,"focus");
	end
	if not FW.Settings.DisableMouseover then
		CA_ValidOn(target,"mouseover");
	end
	CA_ValidOn(target,FW:NameToID(target) or "");
	--only missing party/raid pets casts by using macros, but i think we can live with that
	
	if #validOn > 0 then
		for i=1, #validOn, 1 do -- yes, starting at 1! i suck ;)
			if not UnitIsUnit(validOn[1],validOn[i]) then -- if they are not all the same i cannot be certain
				return "";
			end
		end
	else
		return "";
	end
	return validOn[1];
end

---------------------------------------------------------------------------
-- SelfQueue 13: GUID "" for uncertain, "none" for none
-- SelfQueue 12: raid target icon
-- SelfQueue 11: UniqueID# (for sorting)
-- SelfQueue 10: NOT USED
-- SelfQueue 9: Renamed spell name
-- SelfQueue 8: Target Type (0:trash 1:boss 2:player)
-- SelfQueue 7: Spell Rank
-- SelfQueue 6: Full spell name
-- SelfQueue 5: Target name

-- SelfQueue 4: Success/Cancel (or whatever) Time (including check delay)
-- SelfQueue 3: Time of cast completion (from event) non-zero means casting spell
-- SelfQueue 2: 0 currently casting, 1 'successfully' casted, -1 maybe cancelled

-- SelfQueue 1: Original Spell Name

local origend;
local function CA_SelfChannelUpdate(spell)
	-- *** new drain code ***
	if ST and FW.Drain[spell] --[[and not FW.Settings.TimerTest]] then 
		local i = ST.ST:find(spell,8);
		if i then
			local spellName, _, _, _, _, endTime = UnitChannelInfo("player");
			endTime = endTime*0.001;
			endTime = origend - math.ceil((origend - endTime)/FW.Tick[spellName])*FW.Tick[spellName];
			ST.ST[i][1] = endTime; 
		end
	end
	for i,f in ipairs(FW_OnSelfChannelUpdate) do
		f(spell);
	end
end

local function CA_SelfChannelStart(spell)
	--FW:Debug("Channel Start");
	local spellName, _, _, icon, startTime, endTime = UnitChannelInfo("player");
	
	if not FW_IsChannel[spellName] then -- if marked as special channel it's already taken care off
		local target = UnitName("target");
		startTime = startTime*0.001;
		endTime = endTime*0.001;
		local realduration = endTime-startTime;
		origend = endTime;
		-- *** new drain code ***
		if ST and FW.Drain[spellName] then
			
			local i = CA_SelfQueue:find(spellName,1);
			if i then
				ST.ST:remove(ST.ST:find(FW.DRAIN,6,spellName,8));
				--local t = GetTime();
				--FW:Debug("|cff00ff00"..t.." start:"..startTime..","..endTime);
				FW.Tick[spellName] = realduration/FW.Drain[spellName]; -- use this instead of calculating at update
				ST.ST:insert(endTime,FW:CastTime(spell),realduration,CA_SelfQueue[i][5],0,FW.DRAIN,icon,spellName,CA_SelfQueue[i][8],0,CA_SelfQueue[i][13],0,CA_SelfQueue[i][11],0,1,0,0,ST:GetFilterType(spellName,FW.DRAIN),CA_SelfQueue[i][12],endTime,realduration,1.0,0);
			end
		end
		-- *** end new drain code ***
		if target then
			CA_SelfQueue:insert( spellName.." (C)",0,endTime,0,target,realduration,"",0,0,0,0,0,UnitGUID("target"),1.0);
			for i,f in ipairs(FW_OnSelfChannelStart) do
				f(spellName,target);
			end
		end
	end
end

local function CA_SelfStart(spell)
	--FW:Debug("Spell Start");
	local i = CA_SelfQueue:find2(spell,1,0,3);
	if i then
		CA_SelfQueue[i][3] = select(6,UnitCastingInfo("player"));
		-----------------------------------------------------------
		for i,f in ipairs(FW_OnSelfCastStart) do
			f(spell,CA_SelfQueue[i][5]);
		end
		-----------------------------------------------------------
	end
end

local function CA_SelfRemove(n)
	--FW:Debug("Cancelling spell");
	local spell,_,t3,_,target = unpack(CA_SelfQueue[n]);
	if t3~= 0 then
		-----------------------------------------------------------
		for i,f in ipairs(FW_OnSelfCastCancel) do
			f(spell,target);
		end
		-----------------------------------------------------------
	end
	CA_SelfQueue:remove(n); 
end

--0 currently casting, 1 'successfully' casted, -1 maybe cancelled
local function CA_SelfCancel(spell)
	--FW:Debug("Cancelling spell");
	local i = CA_SelfQueue:find2(spell,1,0,2);-- not awaiting resist check, and not already cancelled
	if i then
		CA_SelfQueue[i][2] = -1;
		CA_SelfQueue[i][4] = GetTime() + FW.Settings.CancelDelay;
	end
end
--[["ABSORB" 
"BLOCK" 
"DEFLECT" 
"DODGE" 
"EVADE" 
"IMMUNE" 
"MISS" 
"PARRY" 
"REFLECT" 
"RESIST" ]]
local CA_CombatEventToMiss = {
	--caster
	["RESIST"] = 4,
	["IMMUNE"] = 5,
	["EVADE"] = 6,
	["REFLECT"] = 7,
	--melee
	["PARRY"] = 4,
	["DODGE" ] = 4,
	["MISS" ] = 4,
	["BLOCK"] = 4,
	["DEFLECT"] = 7
};

local function CA_SelfResist(...)
	local name = select(10,...);
	local i=1;
	while i <= CA_SelfQueue.rows do
		local spell,state,_,_,target,_,_,typ,s,_,id,icon,guid = unpack(CA_SelfQueue[i]);
		if state == 1 then
			local t;
			if spell == name then -- right spell name ofc
				t = CA_CombatEventToMiss[select(12,...)];
			end
			if t then
				for n, f in ipairs(FW_OnSelfCastFail) do
					f(s,t,target,typ,id,icon,guid,...);-- s is spell name as it would appear on the timer
				end
				CA_SelfQueue:remove(i);
				break;
			end
		end
		i=i+1;
	end
end

local function CA_SelfDelay(spell)
	--FW:Debug("Spell delay");
	local endTime = select(6,UnitCastingInfo("player"));
	if endTime then
		local i = CA_SelfQueue:find2(spell,1,0,2);
		if i then
			
			-----------------------------------------------------------
			for n, f in ipairs(FW_OnSelfCastDelay) do
				f( spell, endTime - CA_SelfQueue[i][3] );
			end
			-----------------------------------------------------------
			CA_SelfQueue[i][3] = endTime;
		end
	end
end

function FW:HasteFactor(s) -- spell, rank, combopoints, unit type (2=players)
	-- duration adjustments
	if FW.Track[s] then
		-- hasted duration with stance
		if FW.Track[s]["hs"] then
			if FW.Track[s]["hs"][FW.Stance] then
				return FW.SpellHaste;
			end
		elseif FW.Track[s]["hg"] then -- hasted duration with glyph
			for k, v in pairs(FW.Track[s]["hg"]) do
				if FW.Glyph[k] and FW.Glyph[k] > 0 then
					return FW.SpellHaste;
				end
			end
		end
	end
	return 1;
end

function CA:Duration(s,rank,p,u) -- spell, rank, combopoints, unit type (2=players)
	local dura = 0;
	-- duration adjustments
	if FW.Track[s] then
		dura = FW.Track[s][2];
		-- change based on rank
		if FW.Track[s]["r"] and FW.Track[s]["r"][rank] then
			dura = dura + FW.Track[s]["r"][rank];
		end
		-- change based on talents
		if FW.Track[s]["t"] then
			for k, v in pairs(FW.Track[s]["t"]) do
				if v[FW.Talent[k]] then
					dura = dura + v[FW.Talent[k]];
				end
			end
		end
		-- change based on setbonus
		if FW.Track[s]["s"] then
			for k, v in pairs(FW.Track[s]["s"]) do
				for n, a in pairs(v) do
					if FW.SetBonus[k] >= n then
						dura = dura + a;
					end
				end
			end
		end
		-- change based on combopoints
		if FW.Track[s]["c"] and p then
			dura = dura + (FW.Track[s]["c"][p] or 0);
		end
		-- change based on glyphs
		if FW.Track[s]["g"] then
			for k, v in pairs(FW.Track[s]["g"]) do
				if FW.Glyph[k] and FW.Glyph[k] > 0 then
					dura = dura + v;
				end
			end
		end

		-- % change based on talents
		if FW.Track[s]["tp"] then
			for k, v in pairs(FW.Track[s]["tp"]) do
				if v[FW.Talent[k]] then
					dura = dura * v[FW.Talent[k]];
				end
			end
		end
		-- hasted duration with stance
		--[[if FW.Track[s]["hs"] then
			if FW.Track[s]["hs"][FW.Stance] then
				haste = FW.SpellHaste;
				dura = dura * haste;
			end
		elseif FW.Track[s]["hg"] then -- hasted duration with glyph
			for k, v in pairs(FW.Track[s]["hg"]) do
				if FW.Glyph[k] and FW.Glyph[k] > 0 then
					haste = FW.SpellHaste
					dura = dura * haste;
				end
			end
		end]]
		-- set max duration in pvp
		if u == 2 and FW.Track[s][5] ~= 0 and dura>FW.Track[s][5] then dura=FW.Track[s][5] end 
	end
	return dura;
end

local function CA_SelfSucces(delay,n)
	local spell,_,_,_,target,realduration,rank,targettype,s,p,id,icon,guid,haste = unpack(CA_SelfQueue[n]);
	--CA_SelfQueue:print();
	-- realduration is now adjusted duration!
	if FW.Track[s] then
		for i,f in ipairs(FW_OnSelfCastTracked) do
			f(spell,target,realduration,rank,targettype,s,p,id,icon,guid,delay,haste);
		end
	end
	--FW:Debug(spell.." cast successfull on "..target);
	-----------------------------------------------------------
	for i,f in ipairs(FW_OnSelfCastSuccess) do
		f(spell,target,rank,icon)
	end
	-----------------------------------------------------------
	-- makes it skip the remove if it has a return value, used in channeling spells
	if FW_IsChannel[spell] then
		CA_SelfQueue[n][1] = spell.." (C)"; -- rename to channeling
		CA_SelfQueue[n][2] = 0; -- 
		CA_SelfQueue[n][4] = 0; -- set this spell to not finished again
	else
		CA_SelfQueue:remove(n);
	end
end

local summonchannel = FW:SpellName(46546).." (C)";

local function CA_SelfEnd(arg2)
	--FW:Debug("Ending spell");
	local i=1;
	while i <= CA_SelfQueue.rows do
		local spell = CA_SelfQueue[i][1];
		
		if CA_SelfQueue[i][4]~=1 and (not arg2 or spell==arg2) then
			local s = CA_SelfQueue[i][9];
			if FW.Track[s] and FW.Track[s][1] == 1 then
				CA_SelfQueue[i][2] = 1;
				CA_SelfQueue[i][4] = GetTime() + FW.Settings.Delay;
				
			-- put weird exceptions below!
			elseif spell == summonchannel then
				CA_SelfQueue[i][2] = 1;
				CA_SelfQueue[i][4] = GetTime() + 1; -- 1 sec delay on checking if shard is used
			else
				CA_SelfSucces(0,i); -- ignore possible resists
			end

			break;
		else
			i=i+1;
		end
	end		
	for i,f in ipairs(FW_OnSelfCastEnd) do
		f(arg2); -- spell
	end
end

--[[function FW:SelfChannelUpdate(remain)
	FW:Debug("Channelling Update "..remain);
end]]

local function CA_SelfChannelEnd(spell)
	--FW:Debug("Channelling End");
	-- problem: when you start casting a new spell while still channeling a spell, channel end may fire after the new spell sent event, making it 'complete' the new cast instantly
	-- solution: a spell already channeling, will always be queued at slot [1], so if this isnt a channeling spell ignore this event!

	-- *** new drain code ***
	if ST and FW.Drain[spell] then 
		local i = ST.ST:find(spell,8);
		if i then
			FW:Fade(i,2,true);
			--FW:Debug("|cffff0000"..GetTime().." end");
		end
	end
	-- *** end new drain code ***
	
	if CA_SelfQueue.rows > 0 and strfind(CA_SelfQueue[1][1]," %(C%)$") then CA_SelfEnd();end
end

local function CA_SelfSent(spell,rank,target)
	local s = FW.SpellRename[spell] or spell;
	--FW:Debug("Spell Sent");
	LastCast = GetTime();
	CA_SelfChannelEnd();
	local i = CA_SelfQueue.rows;
	while i>0 do
		if CA_SelfQueue[i][2] == 0 and CA_SelfQueue[i][3] == 0 then -- replace 'garbage sent events'
			CA_SelfQueue:remove(i);
			--FW:Debug("remove garbage sent");
		end
		i=i-1;
	end
	local u,id,r,guid,p = CA:CastTargetInfo(target);
	--FW:Debug(spell.." on: "..guid);
	rank = tonumber(select(3,strfind(rank,"(%d+)")) or 1);
	CA_SelfQueue:insert(spell,0,0,0,target,CA:Duration(s,rank,p,u),rank,u,s,p,id,r,guid,1); -- last (haste) unused now!!
	--CA_SelfQueue:print();
end

-- target debuffs scan is now delayed just as much as the cast success (due to resist checking)
-- this should make the cast success trigger before any debuffs are added 

local function CA_TimedSpellSuccess()
	local i=1;
	local t = GetTime();
	while i <= CA_SelfQueue.rows do
		local state,t4 = CA_SelfQueue[i][2],CA_SelfQueue[i][4];
		if t4 > 0 and t4 < t then
			if state == 1 then
				--FW:Show(t-t4);
				CA_SelfSucces(t-t4+FW.Settings.Delay,i); 
			elseif state == -1 then
				CA_SelfRemove(i);
			end
		else
			i=i+1;
		end
	end
end

local function CA_TimedClearCastBuffer()
	if UnitCastingInfo("player") or UnitChannelInfo("player") then -- if not casting or channelling for 2 sec, remove everything from cast queue to avoid bugs
		LastCast = GetTime();
	elseif LastCast ~= 0 and GetTime() - LastCast >= 3 then
		--FW:Debug("CLEARING BUFFER "..CA_SelfQueue.rows);
		
		CA_SelfQueue:erase();
		
		LastCast = 0;
	end
end
---------------------------------------------------------------------------
-- globally accessable
---------------------------------------------------------------------------

-- used for messaging mostly
function CA:RegisterOnSelfCastEnd(func)
	tinsert(FW_OnSelfCastEnd,func);
end

function CA:RegisterOnSelfCastSuccess(func)
	tinsert(FW_OnSelfCastSuccess,func);
end

function CA:RegisterOnSelfCastTracked(func)
	tinsert(FW_OnSelfCastTracked,func);
end

function CA:RegisterOnSelfCastStart(func)
	tinsert(FW_OnSelfCastStart,func);
end

function CA:RegisterOnSelfCastDelay(func)
	tinsert(FW_OnSelfCastDelay,func);
end

function CA:RegisterOnSelfCastCancel(func)
	tinsert(FW_OnSelfCastCancel,func);
end

function CA:RegisterOnSelfCastFail(func)
	tinsert(FW_OnSelfCastFail,func);
end

function CA:RegisterOnSelfChannelStart(func)
	tinsert(FW_OnSelfChannelStart,func);
end
function CA:RegisterOnSelfChannelUpdate(func)
	tinsert(FW_OnSelfChannelUpdate,func);
end

-- pet cast
function CA:RegisterOnPetCastSuccess(func)
	tinsert(FW_OnPetCastSuccess,func);
end

function CA:RegisterOnPetCastFailed(func)
	tinsert(FW_OnPetCastFailed,func);
end

function CA:RegisterOnPetCastStart(func)
	tinsert(FW_OnPetCastStart,func);
end
---------------------------------------------------------------------------
function CA:GiveID(guid)
	local high,id = 0,0;
	if ST then
		for i=1,ST.ST.rows,1 do
			id = ST.ST[i][13];
			if id > 0 then
				if high < id then high = id; end
				if ST.ST[i][11] == guid then
					return id;
				end
			end
		end
	end
	for i=1,CA_SelfQueue.rows,1 do
		id = CA_SelfQueue[i][11];
		if id > 0 then
			if high < id then high = id;end
			if CA_SelfQueue[i][13] == guid then
				return id;
			end
		end
	end
	return high+1;
end

function CA:CastTargetInfo(target)
	local unit = CA_CastOn(target);
	if unit ~= "" then
		local id = UnitGUID(unit);
		return CA:Unique(unit),CA:GiveID(id),GetRaidTargetIndex(unit) or 0,id,GetComboPoints("player",unit);
	else
		return 0,FW.PRIOR_NONE,0,"",0; -- uncertain about target, will use debuff check to get guid
	end
end

function CA:CastShow(key,target)
	if bit.band(1,FW.Settings[key]) ~= 0 then FW:ToGroup(strformat(FW.Settings[(key.."Msg")],target or "")); end
	if bit.band(2,FW.Settings[key]) ~= 0 then FW:ToChannel(strformat(FW.Settings[(key.."Msg")],target or "")); end
	if FW.Settings[key.."Whisper"] and target~=FW.PLAYER then FW:Whisper( FW.Settings[(key.."WhisperMsg")],target or ""); end
end

FW:RegisterToEvent("UNIT_SPELLCAST_INTERRUPTED",
function(event,arg1,arg2)
	--FW:Show(event.." arg1 "..arg1);
	if arg1 == "player" then
		CA_SelfCancel(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_FAILED",
function(event,arg1,arg2)
	if arg1 == "player" then
		CA_SelfCancel(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_DELAYED",
function(event,arg1,arg2) 
	if arg1 == "player" then
		CA_SelfDelay(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_SENT",
function(event,arg1,arg2,arg3,arg4)
	if arg1 == "player" then
		CA_SelfSent(arg2,arg3,arg4);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_START",		
function(event,arg1,arg2) 
	if arg1 == "player" then 
		CA_SelfStart(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_SUCCEEDED",
function(event,arg1,arg2)
	if arg1 == "player" then
		CA_SelfEnd(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_START",
function(event,arg1,arg2)
	if arg1 == "player" then
		CA_SelfChannelStart(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_STOP",
function(event,arg1,arg2)
	if arg1 == "player" then
		CA_SelfChannelEnd(arg2);
	end
end);

FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_UPDATE",
function(event,arg1,arg2)
	if arg1 == "player" then
		CA_SelfChannelUpdate(arg2);
	end
end);

local ORA3_COOLDOWN = FW.ORA3_COOLDOWN;
local function CA_VariablesLoaded()
	ST = FW.Modules.Timer;
	CD = FW.Modules.Cooldown;
	
	FW:RegisterTimedEvent("UpdateInterval",CA_TimedClearCastBuffer);
	-- also check if you actually get cast success events from party/raid members now!!!
	if not _G["oRA3"] and not CD then -- using ora3 or cooldown module over this
		if FW.CLASS == "SHAMAN" then
			local reinc = FW:SpellName(FW.FLAG_SHAMAN);
			CA:RegisterOnSelfCastSuccess(function(s,t)
				if s == reinc and FW.GROUPED then
					local impreinc = FW:SpellName(16209);
					local dur = 1800;
					for tab=1,GetNumTalentTabs(),1 do
						for i=1,GetNumTalents(tab),1 do
							local name, _, _, _, rank = GetTalentInfo(tab, i,nil,nil,GetActiveTalentGroup());
							if name == impreinc then
								dur = dur - rank*450;
								break;
							end
						end
					end
					SendAddonMessage("oRA3",strformat(ORA3_COOLDOWN,FW.FLAG_SHAMAN,dur),"RAID");
				end
			end)
		elseif FW.CLASS == "PALADIN" then
			local di = FW:SpellName(FW.FLAG_PALADIN);
			CA:RegisterOnSelfCastSuccess(function(s,t)
				if s == di and FW.GROUPED then
					SendAddonMessage("oRA3",strformat(ORA3_COOLDOWN,FW.FLAG_PALADIN,600),"RAID");
				end
			end)
		elseif FW.CLASS == "DRUID" then
			local rebirth = FW:SpellName(FW.FLAG_DRUID);
			CA:RegisterOnSelfCastSuccess(function(s,t)
				if s == rebirth and FW.GROUPED then
					SendAddonMessage("oRA3",strformat(ORA3_COOLDOWN,FW.FLAG_DRUID,600),"RAID");
				end
			end)
		end
	end
end

FW:RegisterToEvent("PLAYER_LEAVING_WORLD",	function() CA_SelfQueue:erase();end);
FW:RegisterToEvent("PLAYER_DEAD",			function() CA_SelfQueue:erase();end);

do
	local PLAYER = FW.PLAYER;
	local pet = FW.pet;
	local select = select;
	
	local function CA_CombatLogEvent(event,...)
		if select(4,...) == PLAYER then
			if select(2,...) == "SPELL_MISSED" then
				CA_SelfResist(...);
			end
		elseif select(3,...) == pet then
			local arg2 = select(2,...);
			if arg2 == "SPELL_MISSED" then
				for i,f in ipairs(FW_OnPetCastFailed) do
					f(select(10,...));
				end
			elseif arg2 == "SPELL_CAST_FAILED" then
				for i,f in ipairs(FW_OnPetCastFailed) do
					f(select(10,...));
				end
			elseif arg2 == "SPELL_CAST_START" then
				for i,f in ipairs(FW_OnPetCastStart) do
					f(select(10,...));
				end
			elseif arg2 == "SPELL_CAST_SUCCESS" then
				for i,f in ipairs(FW_OnPetCastSuccess) do
					f(select(10,...));
				end
			end
		end
	end
	FW:RegisterToEvent("COMBAT_LOG_EVENT_UNFILTERED",	CA_CombatLogEvent);
end

FW:RegisterToEvent("UNIT_AURA",function(event,arg1)
	if arg1=="player" then
		FW:RegisterChill(CA_StatsUpdate);
	end
end);

FW:RegisterToEvent("COMBAT_RATING_UPDATE",CA_StatsUpdate);
FW:RegisterLoadEvent(CA_StatsUpdate);
FW:RegisterUpdatedEvent(CA_TimedSpellSuccess);
FW:RegisterVariablesEvent(CA_VariablesLoaded);

FW:SetMainCategory(FWL.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FWL.CASTING,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.DELAY_MAX_FAIL,		"","Delay",nil,0.01,1);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.DELAY_MAX_FASTCAST,	"","CancelDelay",nil,0.1,1);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.DISABLE_FOCUS,		"","DisableFocus");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.DISABLE_MOUSEOVER,	"","DisableMouseover");
		
FW.Default.Delay = 0.1; -- maximum delay between cast success event and evade/resist/immune event (seems to be system lag only)
FW.Default.CancelDelay = 0.5; -- maximum delay between a possible fastcast macro generated fail and the actual success (server lag)
FW.Default.DisableFocus = false;
FW.Default.DisableMouseover = false;

FW.Default.MeetingStoneSummon = 0;		FW.Default.MeetingStoneSummonMsg = "Summoning >> %s << Clicky clicky!"