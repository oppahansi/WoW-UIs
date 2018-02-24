-- ForteXorcist v1.959.8 by Xus 13-04-2010

if FW.CLASS == "WARLOCK" then
	local FW = FW;
	local WL = FW:ClassModule("Warlock");
	local FWL = FW.L;
	
	local UnitName = FW.FullUnitName;
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then
		--FW:RegisterSet("Voidheart Raiment","28963","28968","28966","28967","28964");
		
		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack

		-- id/name, ticks total
		ST:RegisterDrain(47855,	5); -- Drain Soul
		ST:RegisterDrain(47857,	5); -- Drain Life
		ST:RegisterDrain(47858,	5); -- Drain Mana
		ST:RegisterDrain(47823,	15); -- Hellfire
		ST:RegisterDrain(47820,	4); -- Rain of Fire
		
		ST:RegisterSpell(47811,	1,015,1,FW.DEFAULT); -- Immolate
			--ST:RegisterSpellModSetB(47811, 	"Voidheart Raiment", 4,  3);
			ST:RegisterSpellModTlnt(47811,47247,1,3); -- Molten Core
			ST:RegisterSpellModTlnt(47811,47247,2,6);
			ST:RegisterSpellModTlnt(47811,47247,3,9);
		ST:RegisterSpell(47813,	1,018,1,FW.DEFAULT);-- Corruption
			ST:RegisterSpecialRefresh(47813);
			ST:RegisterHastedGlyph(47813,70947); -- set to hasted dot, requires Glyph of Quick Decay
			ST:RegisterSpellModRank(47813, 	1, -6);
			ST:RegisterSpellModRank(47813, 	2, -3);
			--ST:RegisterSpellModSetB(47813, "Voidheart Raiment", 4,  3);
		ST:RegisterSpell(47843,	1,015,1,FW.DEFAULT); -- Unstable Affliction
		ST:RegisterSpell(47864,	1,024,1,FW.SHARED); -- Curse of Agony
			ST:RegisterTickSpeed(47864, 2); -- set tick speed to 2 instead of 3
			ST:RegisterSpellModGlph(47864, 56282, 1, 4);
		ST:RegisterSpell(47865,	1,300,0,FW.SHARED); -- Curse of the Elements
		ST:RegisterSpell(50511,	1,120,0,FW.SHARED); -- Curse of Weakness
		ST:RegisterSpell(47867,	1,060,0,FW.SHARED); -- Curse of Doom
		ST:RegisterSpell(11719,	1,030,0,FW.SHARED,010); -- Curse of Tongues
		ST:RegisterSpell(46434,	1,012,0,FW.SHARED); -- Curse of Exhaustion
		ST:RegisterSpell(18647,	1,030,0,FW.UNIQUE,010); -- Banish
			ST:RegisterSpellModRank(18647, 	1, -10);
		ST:RegisterSpell(6215,	1,020,0,FW.UNIQUE,010); -- Fear
			ST:RegisterSpellModRank(6215, 1, -10);
			ST:RegisterSpellModRank(6215, 2, -5);
		ST:RegisterSpell(17928, 0,008,0,FW.UNIQUE); -- Howl of Terror
			ST:RegisterSpellModRank(17928, 	1, -2);
		ST:RegisterSpell(61191,	1,300,0,FW.CHARM); -- Enslave Demon
		ST:RegisterSpell(39941,	0,060,0,FW.PET); -- Inferno
		ST:RegisterSpell(05697,	1,600,0,FW.BUFF); -- Unending Breath
		ST:RegisterSpell(11649,	1,600,0,FW.BUFF); -- Detect Invisibility
		ST:RegisterSpell(59164,	1,000,0,FW.DEFAULT); -- Haunt (12sec set to 0 for travel time)
		ST:RegisterSpell(47836,	1,018,1,FW.DEFAULT); -- SoC
		ST:RegisterSpell(47847,	0,003,0,FW.UNIQUE); -- Shadowfury
		ST:RegisterSpell(48018,	0,360,0,FW.HEAL); -- Demonic Circle: Summon
		ST:RegisterSpell(61290,	1,000,1,FW.DEFAULT); -- Shadow Flame
			ST:RegisterTickSpeed(61290, 2); -- set tick speed to 2 instead of 3
		ST:RegisterSpell(60468,	1,000,0,FW.DEFAULT); -- Shadow Embrace
		
		ST:RegisterSpell(17962,	1,006,1,FW.DEFAULT); -- Conflagrate
			ST:RegisterTickSpeed(17962, 2); -- set tick speed to 2 instead of 3
			
		ST:RegisterCooldown(17962,010); -- Conflag
		ST:RegisterCooldown(50796,012); -- Chaos Bolt
		ST:RegisterCooldown(59164,008); -- Haunt
				
		--buffname
		--ST:RegisterBuff(37378); -- Shadowflame
		--ST:RegisterBuff(37379); -- Flameshadow 
		ST:RegisterBuff(17941); -- Shadow Trance
		ST:RegisterBuff(51439); -- Backlash
		ST:RegisterBuff(47197); -- Eradication
		ST:RegisterBuff(61610); -- Metamorphosis
		ST:RegisterBuff(54278,1); -- Empowered Imp (set to non-stacking)
		ST:RegisterBuff(47383); -- Molten Core
		ST:RegisterBuff(63158); -- Decimation
		ST:RegisterBuff(47260); -- backdraft
		--ST:RegisterBuff(61595); -- demonic soul (t7 bonus)
		--ST:RegisterBuff(61082); -- spirits of the damned (t7 bonus)
		ST:RegisterBuff(63321); -- glyph of life tap buff
		ST:RegisterBuff(70840); -- Devious Minds
	
		-- important debuffs from others i want to track
		ST:RegisterDebuff(44836); -- Banish
		ST:RegisterDebuff(59669); -- Fear
		ST:RegisterDebuff(61191); -- Enslave Demon
		ST:RegisterDebuff(17928); -- Howl of Terror
		ST:RegisterDebuff(60946); -- Nightmare

		ST:RegisterCasterBuffs();
	end
	
	local t1,t2,t3,t4,t5,t6;
	local BP = {};
	
	local PetTarget = "";
	local PetSpell = "";
	local PetTime = -1;
	local bp = FW:SpellName(47982);
	
	local function WL_ScanBloodpact(unit)
		local unitClass = select(2,UnitClass(unit));
		local unitName = UnitName(unit);
		if not unitClass or not unitName then return; end
		t1 = strlower(FW.Settings.BloodPactMsg);
		if strfind(t1,strlower(unitName)) or strfind(t1,strlower(unitClass)) or strfind(t1,"all") or (unit == "player" and strfind(t1,"self")) then
			t2 = UnitBuff(unit,bp);
			if BP[unitName] ~= t2 then
				if FW.Settings.BloodPact then
					if t2 then
						FW:Show(string.format(FWL._GAINED_BLOOD_PACT,unitName),unpack(FW.Settings.BloodpactGainColor));
					else
						FW:Show(string.format(FWL._LOST_BLOOD_PACT,unitName),unpack(FW.Settings.BloodpactLossColor));
					end
				end
				BP[unitName] = t2;
			end
		end
	end
	local PARTY = FW.PARTY;
	local RAID = FW.RAID;
	local function WL_BloodpactScan()
		if GetNumRaidMembers() > 0 then
			for i=1,GetNumRaidMembers(),1 do
				WL_ScanBloodpact(RAID[i]);
			end		
		else
			for i=1,GetNumPartyMembers(),1 do
				WL_ScanBloodpact(PARTY[i]);
			end
			WL_ScanBloodpact("player");
		end
	end
	local shardlink = "^|c.-|Hitem:"..FW.ID_SOULSHARD..":";
	local function WL_IsShard(link)
		if strfind(link,shardlink) then
			return true;
		else
			return false;
		end
	end
	
	local function WL_IsShardBag(link)
		-- soulbag type == 4
		return bit.band(4,GetItemFamily(link)) == 4;
	end
	
	local BagStats = {[0]={},[1]={},[2]={},[3]={},[4]={}};
	local SMP = {};
	
	local function WL_ShardMove(frombag,fromslot,tobag,toslot)
		ClearCursor();
		PickupContainerItem(frombag,fromslot);
		local i1,i2,i3 = GetCursorInfo();
		local i4 = GetContainerItemLink(tobag,toslot);
		if i1=="item" and i2 == FW.ID_SOULSHARD and i4 == nil then -- make sure i only move shards and only to an empty spot in case of bugs
			PickupContainerItem(tobag,toslot);
		else
			ClearCursor();
		end
	end
	
	local function WL_ShardDelete(bag,slot)
		ClearCursor();
		PickupContainerItem(bag,slot);
		local i1,i2,i3 = GetCursorInfo();
		if i1=="item" and i2 == FW.ID_SOULSHARD then -- make sure i only delete shards in case of bugs
			DeleteCursorItem();
			--FW:Debug("Deleted a Soulshard");
		else
			--FW:Debug("Failed to delete a Soulshard");
			ClearCursor();
		end
	end
	
	local function WL_ScanBags()
		-- possible bug: shards keep sticking to cursor with 22 slot bag?
		if not FW.Settings.ShardManagerEnable then return;end
		--FW:Show("scanning");
		--FW:Debug("Scanning Bag");
		local link;
		local item;
		local bag;
		local shardbag;
		
		BagStats.shard = 0;
		BagStats.empty = 0;
		BagStats.emptybag = nil;
		BagStats.emptyslot = nil;
		BagStats.shardbag = nil;
		BagStats.shardslot = nil;
				
		SMP[1],SMP[2],SMP[3],SMP[4],SMP[5] = strsplit(",",FW.Settings.ShardManagerPriorMsg);
		
		for k,v in ipairs(SMP) do 
			SMP[k] = tonumber(v);
		end	
		for i=1,5 do
			if not SMP[i] or SMP[i]<0 or SMP[i]>4 then
				FW.Settings.ShardManagerPriorMsg = FW.Default.ShardManagerPriorMsg;
				SMP[1],SMP[2],SMP[3],SMP[4],SMP[5] = strsplit(",",FW.Settings.ShardManagerPriorMsg);
				for k,v in ipairs(SMP) do 
					SMP[k] = tonumber(v);
				end
				FW:RefreshOptions();
				break;	
			end
		end
		for i=1,4 do 
			for j=i+1,5 do
				if (SMP[i] == SMP[j]) then
					FW.Settings.ShardManagerPriorMsg = FW.Default.ShardManagerPriorMsg;
					SMP[1],SMP[2],SMP[3],SMP[4],SMP[5] = strsplit(",",FW.Settings.ShardManagerPriorMsg);
					for k,v in ipairs(SMP) do 
						SMP[k] = tonumber(v);
					end	
					FW:RefreshOptions();
					break;
				end
			end
		end
		for i=1,5 do
			bag = SMP[i];
			if bag then
				BagStats[bag].size = GetContainerNumSlots(bag);
				BagStats[bag].empty = 0;
				BagStats[bag].shard = 0;
				BagStats[bag].prior = i;
				BagStats[bag].lastEmptyslot = nil;
				BagStats[bag].firstShardslot = nil;
				if bag == 0 or BagStats[bag].size == 0 then -- bag 0 = backpack
					BagStats[bag].shardbag = false;
				else
					if WL_IsShardBag(GetInventoryItemLink("player", ContainerIDToInventoryID(bag))) then
						BagStats[bag].shardbag = true;
						shardbag = bag;
					else
						BagStats[bag].shardbag = false;
					end
				end
				for slot=1,BagStats[bag].size do
				
					link = GetContainerItemLink(bag,slot);
					if link then
						if WL_IsShard(link) then
							BagStats[bag].shard = BagStats[bag].shard + 1;
							BagStats.shard=BagStats.shard+1;
							
							if BagStats.shardbag ~= bag then
								BagStats[bag].firstShardslot = slot;
							end	
							
							BagStats.shardbag = bag;
							BagStats.shardslot = slot;
						end
					else
						BagStats[bag].empty = BagStats[bag].empty + 1;
						BagStats.empty=BagStats.empty+1;
						if not BagStats.emptybag then
							BagStats.emptybag = bag;
							BagStats.emptyslot = slot;
						end
						BagStats[bag].lastEmptyslot = slot;
					end
				end
			end
		end
		-- fix shard bag as nr1
		if shardbag ~= nil and BagStats[shardbag].prior ~= 1 then
			for i=0,4 do
				if BagStats[i].prior <= BagStats[shardbag].prior then
					BagStats[i].prior = BagStats[i].prior + 1;
				end
			end
			BagStats[shardbag].prior = 1;
			-- fix the input field
			for i=0,4 do
				SMP[BagStats[i].prior] = i;
			end
			FW.Settings.ShardManagerPriorMsg = "";
			for i=1,5 do
				FW.Settings.ShardManagerPriorMsg = FW.Settings.ShardManagerPriorMsg..SMP[i];
				if i<5 then
					FW.Settings.ShardManagerPriorMsg = FW.Settings.ShardManagerPriorMsg..",";
				end
			end
			FW:RefreshOptions();
		end

		if FW.Settings.ShardManagerPrior then
			if BagStats.emptybag and BagStats.shardbag and BagStats[BagStats.emptybag].prior < BagStats[BagStats.shardbag].prior then
				if FW.Settings.ShardManagerTop then -- this is the 'standard' adding from top
					WL_ShardMove(BagStats.shardbag,BagStats.shardslot,BagStats.emptybag,BagStats.emptyslot);
				else
					WL_ShardMove(BagStats.shardbag,BagStats[BagStats.shardbag].firstShardslot,BagStats.emptybag,BagStats[BagStats.emptybag].lastEmptyslot);
				end
				return;
			end
		end
		if FW.Settings.ShardManagerDelete then
			if BagStats.shardbag and not BagStats[BagStats.shardbag].shardbag and ( (FW.Settings.ShardManagerMaxEnable and BagStats.shard > FW.Settings.ShardManagerMax) or (FW.Settings.ShardManagerFreeEnable and BagStats.empty < FW.Settings.ShardManagerFree and not (FW.Settings.ShardManagerMinEnable and BagStats.shard <= FW.Settings.ShardManagerMin) )) then
				if FW.Settings.ShardManagerTop then -- this is the 'standard' adding from top
					WL_ShardDelete(BagStats.shardbag,BagStats.shardslot);
				else
					WL_ShardDelete(BagStats.shardbag,BagStats[BagStats.shardbag].firstShardslot);
				end
				return;
			end
		end
		if FW.Settings.ShardManagerPrior  then
			if FW.Settings.ShardManagerTop then -- this is the 'standard' adding from top
				if BagStats.shardbag and BagStats.emptybag and BagStats.shardslot and BagStats.emptyslot and BagStats.shardbag == BagStats.emptybag and BagStats.shardslot>BagStats.emptyslot then -- has to have room and shards
					WL_ShardMove(BagStats.shardbag,BagStats.shardslot,BagStats.shardbag,BagStats.emptyslot);
				end
			else
				if BagStats.shardbag and BagStats.emptybag and BagStats.shardslot and BagStats.emptyslot and BagStats.shardbag == BagStats.emptybag and BagStats[BagStats.shardbag].firstShardslot<BagStats[BagStats.shardbag].lastEmptyslot then -- has to have room and shards
					WL_ShardMove(BagStats.shardbag,BagStats[BagStats.shardbag].firstShardslot,BagStats.shardbag,BagStats[BagStats.shardbag].lastEmptyslot);
				end
			end
		end
	end
	local function WL_ScanBagsChilled()
		FW:RegisterChill(WL_ScanBags);
	end
	local function WL_RegisterShardManager()
		if FW.Settings.ShardManagerEnable then
			FW:RegisterToEvent("BAG_UPDATE",WL_ScanBagsChilled);
		else
			FW:UnregisterToEvent("BAG_UPDATE",WL_ScanBagsChilled);
		end
	end
		
	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("UpdateInterval",		WL_BloodpactScan);
		WL_RegisterShardManager();
	end);
	
	local devour = FW:SpellName(48011);
	local spelllock = FW:SpellName(30849);
	local consume = FW:SpellName(54501);
	local seduction = FW:SpellName(31865);
	
	if CA then
		local sscast = FW:SpellName(47883);
		local summon = FW:SpellName(46546);
		local meeting = FW:SpellName(23598);
		local ritual = FW:SpellName(60429);
		local doom = FW:SpellName(18540);
		
		CA:RegisterIsChannel(summon);
		
		local function WL_UpdatePetTarget()
			if PetTime ~= -1 and PetTime <= GetTime() then
				PetTime = -1;
				PetTarget = UnitName("pettarget");
				if PetTarget then
					if PetSpell == seduction then
						CA:CastShow("SeduceStart",PetTarget);
					end
				end
			end
		end
		FW:RegisterUpdatedEvent(WL_UpdatePetTarget);
		FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_START",
		function(event,arg1)
			if arg1 == "pet" then
				local spellName, _, _, spellTexture, startTime, endTime = UnitChannelInfo("pet");
				t1,t2,t3,t4 = 0,0,0,"";
				if spellName == consume then
					PetTarget = spellName;
				elseif spellName == seduction then
					PetTarget = UnitName("pettarget");
					CA:CastShow("SeduceSuccess",PetTarget);
					t1,t2,t3,t4 = CA:CastTargetInfo(PetTarget);
				else
					PetTarget = UnitName("pettarget") or spellName;
				end
				if ST then
					ST.ST:insert(endTime*0.001,0,(endTime-startTime)*0.001,PetTarget,0,FW.PET,spellTexture,spellName,t1,0,t4,0,t2,0,1,0,0,ST:GetFilterType(spellName,FW.PET),t3,endTime*0.001,(endTime-startTime)*0.001,1.0,0);
				end
			end
		end);
		CA:RegisterOnSelfCastStart(function(s,t)
			if s == summon then
				CA:CastShow("SummonStart",t);
			elseif s == sscast then
				CA:CastShow("SoulstoneStart",t);

			end
		end);
		CA:RegisterOnSelfCastCancel(function(s,t)
			if s == sscast then
				CA:CastShow("SoulstoneCancel",t); 
			elseif s == summon then
				CA:CastShow("SummonCancel",t);
			end
		end);
		CA:RegisterOnSelfCastSuccess(function(s,t,rank)
			if s == sscast then
				CA:CastShow("SoulstoneSuccess",t);
			elseif s == summon then
				CA:CastShow("SummonFinish",t);
			elseif s == ritual then
				local base;
				if rank == 1 then
					base = 2080;
				else
					base = 4280;
				end
				CA:CastShow("SoulwellStart",base*(1+0.1*select(5,GetTalentInfo(2,1,nil,nil,GetActiveTalentGroup()))));
			elseif s == doom then
				CA:CastShow("RitualOfDoomStart");
			end
		end);
		CA:RegisterOnPetCastSuccess(function(spell)
			if spell == devour then
				CA:CastShow("DevourMagicSuccess");
			elseif spell == spelllock then
				CA:CastShow("SpellLockSuccess");
			end
		end);
		CA:RegisterOnPetCastFailed(function(spell)
			if spell == devour then
				CA:CastShow("DevourMagicFailed");
			elseif spell == spelllock then
				CA:CastShow("SpellLockFailed");
			elseif spell == seduction then
				CA:CastShow("SeduceFailed");
			end
		end);
		CA:RegisterOnPetCastStart(function(spell)
			if spell == seduction then
				PetTime = GetTime() + FW.Settings.PetTargetDelay;
				PetSpell = spell;
			end
		end);
	end
	if ST then
		local fear = FW:SpellName(59669);
		local banish = FW:SpellName(44836);
		local enslave = FW:SpellName(61191);
	
		FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_STOP",
		function(event,arg1)
			local t = GetTime();
			if arg1 == "pet" then
				for i=1,ST.ST.rows,1 do
					if ST.ST[i][6] == 4 then
						if ST.ST[i][1]-t > 0.75 then
						
							ST.ST[i][14] = 3;
							ST.ST[i][17] = t;
							
							if ST.ST[i][8] == seduction then
								local unit = ST.ST[i][4];
								local mark = ST.ST[i][19];
								if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
								CA:CastShow("SeduceBreak",unit);
								FW:PlaySound("TimerBreakSound");
							end
						end
						break;
					end
				end
			end
		end);
		ST:RegisterOnTimerBreak(function(unit,mark,spell)
			if spell == fear then
				if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
				CA:CastShow("FearBreak",unit);
				return 1;
			elseif spell == banish then
				if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
				CA:CastShow("BanishBreak",unit);
				return 1;
			elseif spell == enslave then
				if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
				CA:CastShow("EnslaveBreak",unit);
				return 1;
			end
		end);
		ST:RegisterOnTimerFade(function(unit,mark,spell,t)
			if spell == fear then
				if t <= ST:GetFadeTime("FearFade") then
					if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
					CA:CastShow("FearFade",unit);
					return 1;
				end
			elseif spell == banish then
				if t <= ST:GetFadeTime("BanishFade") then
					if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
					CA:CastShow("BanishFade",unit);
					return 1;
				end
			elseif spell == enslave then
				if t <= ST:GetFadeTime("EnslaveFade") then
					if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
					CA:CastShow("EnslaveFade",unit);
					return 1;
				end
			elseif spell == seduction then
				if t <= ST:GetFadeTime("SeduceFade") then
					if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
					CA:CastShow("SeduceFade",unit);
					return 1;
				end
			end
		end);
		local backlash = FW:SpellName(51439);
		local shadowtrance = FW:SpellName(17941);
		local decimation = FW:SpellName(63158);
		ST:RegisterOnBuffGain(function(buff)
			if buff == backlash or buff == shadowtrance or buff == decimation then
				FW:PlaySound("TimerInstantSound");
			end
		end);
	end
	if CD then
		CD:RegisterOnCooldownReady(function(spell)
			if spell == devour then
				CA:CastShow("DevourMagicReady");
			elseif spell == spelllock then
				CA:CastShow("SpellLockReady");
			end
		end);
		
		CD:RegisterCooldownBuff(47893); -- fel armor
		CD:RegisterCooldownBuff(47889); -- demon armor
		
		CD:RegisterCooldownBuff(18789); -- burning wish
		CD:RegisterCooldownBuff(18792); -- fel energy
		CD:RegisterCooldownBuff(35701); -- touch of shadow
		CD:RegisterCooldownBuff(18790); -- fel stamina
		
		CD:RegisterHiddenCooldown(nil,51439,08); -- Backlash	
		CD:RegisterCasterPowerupCooldowns();
	end
	
	FW:SetMainCategory(FWL.RAID_MESSAGES,FW.ICON_MESSAGE,10,"RAIDMESSAGES");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.RAID_MESSAGES_HINT1);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.RAID_MESSAGES_HINT2);
			FW:RegisterOption(FW.CHK,2,FW.NON,FWL.SHOW_IN_RAID,	FWL.SHOW_IN_RAID_TT,	"OutputRaid");
			FW:RegisterOption(FW.MSG,2,FW.NON,FWL.SHOW_IN_CHANNEL,	FWL.SHOW_IN_CHANNEL_TT,"Output");
		
		if CA then
		FW:SetSubCategory(FWL.SUMMONING,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SUMMON_PORTAL,		"",	"SummonFinish");
							  
		FW:SetSubCategory(FWL.SOULSTONE_NORMAL,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SOULTONE_START,		"",	"SoulstoneStart");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SOULTONE_CANCEL,		"",	"SoulstoneCancel");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SOULTONE_SUCCESS,	"",	"SoulstoneSuccess");
			FW:RegisterOption(FW.MSG,2,FW.NON,FWL.SOULTONE_START_W,	"",	"SoulstoneStartWhisper");
			FW:RegisterOption(FW.MSG,2,FW.NON,FWL.SOULTONE_CANCEL_W,	"",	"SoulstoneCancelWhisper");
			FW:RegisterOption(FW.MSG,2,FW.NON,FWL.SOULTONE_SUCCESS_W,	"",	"SoulstoneSuccessWhisper");
			
		FW:SetSubCategory(FWL.SOULWELL,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SOULWELL,		"",	"SoulwellStart");
		FW:SetSubCategory(FWL.RITUAL_OF_DOOM,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.RITUAL_OF_DOOM,	"",	"RitualOfDoomStart");
		end

		FW:SetSubCategory(FWL.PET,FW.ICON_SPECIFIC,2);
			if CA then
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SEDUCE_START,		"",	"SeduceStart");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SEDUCE_SUCCESS,		"",	"SeduceSuccess");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SEDUCE_FAILED,		"",	"SeduceFailed");
			end
			if ST then
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SEDUCE_BREAK,		"",	"SeduceBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SEDUCE_FADE,			"",	"SeduceFade");
			end
			if CA then
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SPELL_LOCK_SUCCESS,	"",	"SpellLockSuccess");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SPELL_LOCK_FAILED,	"",	"SpellLockFailed");
			end
			if CD then
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.SPELL_LOCK_READY,	"",	"SpellLockReady");
			end
			if CA then
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.DEVOUR_MAGIC_SUCCESS,"",	"DevourMagicSuccess");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.DEVOUR_MAGIC_FAILED,	"",	"DevourMagicFailed");
			end
			if CD then
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.DEVOUR_MAGIC_READY,	"",	"DevourMagicReady");
			end
		if ST then
		FW:SetSubCategory(FWL.BREAK_FADE,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.BREAK_FADE_HINT1);
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.FEAR_BREAK,		"",	"FearBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.FEAR_FADE,		"",	"FearFade");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.BANISH_BREAK,	"",	"BanishBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.BANISH_FADE,		"",	"BanishFade");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.ENSLAVE_BREAK,	"",	"EnslaveBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FWL.ENSLAVE_FADE,	"",	"EnslaveFade");
		end
		
	if ST then
	FW:SetMainCategory(FWL.SOUND,FW.ICON_SOUND,12,"SOUND");
		FW:SetSubCategory(FWL.SPELL_TIMER,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.SND,2,FW.NON,"Instant","","TimerInstantSound");
	end
	
	FW:SetMainCategory(FWL.SHARD_MANAGER,FW.ICON_SOULBAG,9,"SHARDMANAGER");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.SHARD_MANAGER_HINT1);
			
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.ENABLE,		FWL.SHARD_MANAGER_ENABLE_TT,	"ShardManagerEnable",		function() WL_RegisterShardManager(); WL_ScanBags();end);
			FW:RegisterOption(FW.MSG,1,FW.NON,FWL.SHARD_BAG_PRIOR,	FWL.SHARD_BAG_PRIOR_TT,	"ShardManagerPrior",	WL_ScanBags);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHARD_DELETE,	FWL.SHARD_DELETE_TT,		"ShardManagerDelete",	WL_ScanBags);
			FW:RegisterOption(FW.NU2,1,FW.NON,FWL.SHARD_MAX,	FWL.SHARD_MAX_TT,		"ShardManagerMax",	WL_ScanBags,0,32);
			FW:RegisterOption(FW.NU2,1,FW.NON,FWL.SHARD_FREE,	FWL.SHARD_FREE_TT,		"ShardManagerFree",	WL_ScanBags,0);
			FW:RegisterOption(FW.NU2,1,FW.NON,FWL.SHARD_MIN,	FWL.SHARD_MIN_TT,		"ShardManagerMin",	WL_ScanBags,0,32);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHARD_TOP,	FWL.SHARD_TOP_TT,		"ShardManagerTop",	WL_ScanBags);
	
	FW:SetMainCategory(FWL.SELF_MESSAGES,FW.ICON_SELFMESSAGE,11,"SELFMESSAGES");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.SELF_MESSAGES_HINT1);
		
		FW:SetSubCategory(FWL.BLOOD_PACT,FW.ICON_SPECIFIC,2)
			FW:RegisterOption(FW.MSG,1,FW.NON,FWL.BLOOD_PACT_ON,	FWL.BLOOD_PACT_TT,	"BloodPact");
			FW:RegisterOption(FW.COL,1,FW.NON,FWL.BLOOD_PACT_GAIN,		"",		"BloodpactGain");
			FW:RegisterOption(FW.COL,1,FW.NON,FWL.BLOOD_PACT_LOSS,		"",		"BloodpactLoss");
			
	FW:SetMainCategory(FWL.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
		FW:SetSubCategory(FWL.CASTING,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.DELAY_PET_TARGET		,"",	"PetTargetDelay",nil,0.1,1);
	
	FW.Default.PetTargetDelay = 0.5; -- delay between pet cast start and target check
	
	FW.Default.ShardManagerEnable = false;
	FW.Default.ShardManagerDelete = false;
	FW.Default.ShardManagerMaxEnable = false;
	FW.Default.ShardManagerMax = 28;
	FW.Default.ShardManagerMinEnable = true;
	FW.Default.ShardManagerMin = 28;
	FW.Default.ShardManagerFreeEnable = true;
	FW.Default.ShardManagerFree = 2;
	FW.Default.ShardManagerPrior = true;
	FW.Default.ShardManagerPriorMsg = "4,0,1,2,3";
	FW.Default.ShardManagerTop = true;
	
	--FW.Default.SummonStartWhisper = false;	FW.Default.SummonStartWhisperMsg = ">> You are being Summoned! <<";
	--FW.Default.SummonCancelWhisper = false;	FW.Default.SummonCancelWhisperMsg = "<< Your Summon was Cancelled >>";
	--FW.Default.SummonFailedWhisper = false;	FW.Default.SummonFailedWhisperMsg = "<< Your Summon Failed >>";

	FW.Default.SoulstoneSuccessWhisper = true;	FW.Default.SoulstoneSuccessWhisperMsg = ">> You are now soulstoned! <<";
	FW.Default.SoulstoneStartWhisper = false;	FW.Default.SoulstoneStartWhisperMsg = ">> Soulstoning you now <<";
	FW.Default.SoulstoneCancelWhisper = false;	FW.Default.SoulstoneCancelWhisperMsg = "<< Soulstoning cancelled >>";

	FW.Default.SummonFinish = 1;		FW.Default.SummonFinishMsg = ">> Opening Summoning Portal << Clicky clicky!"
	FW.Default.SoulstoneSuccess = 0;	FW.Default.SoulstoneSuccessMsg = "Soulstoned >> %s << Use it well!";
	FW.Default.SoulstoneStart = 1;		FW.Default.SoulstoneStartMsg = "Soulstoning >> %s << Now";
	FW.Default.SoulstoneCancel = 1;		FW.Default.SoulstoneCancelMsg = "Soulstoning >> %s << Cancelled";

	FW.Default.SeduceSuccess = 0;		FW.Default.SeduceSuccessMsg = "Seduced >> %s << Don't hit it!";
	FW.Default.SeduceStart = 0;			FW.Default.SeduceStartMsg = "Seducing >> %s << Now";
	FW.Default.SeduceFailed = 0;		FW.Default.SeduceFailedMsg = ">> Seduction Failed! <<";
	FW.Default.SeduceBreak = 1;			FW.Default.SeduceBreakMsg = ">> Seduction on %s Broke Early! <<";
	FW.Default.SeduceFade = 1;			FW.Default.SeduceFadeMsg = ">> Seduction on %s Fading in 3 seconds! <<";
	
	FW.Default.DevourMagicSuccess = 0;	FW.Default.DevourMagicSuccessMsg = ">> Devour Magic Used <<";
	FW.Default.DevourMagicFailed = 0;	FW.Default.DevourMagicFailedMsg = ">> Devour Magic Failed! <<";
	FW.Default.DevourMagicReady = 0;	FW.Default.DevourMagicReadyMsg = ">> Devour Magic ready <<";

	FW.Default.SpellLockSuccess = 0;	FW.Default.SpellLockSuccessMsg = ">> Spell Lock Used <<";
	FW.Default.SpellLockFailed = 0;		FW.Default.SpellLockFailedMsg = ">> Spell Lock Failed! <<";
	FW.Default.SpellLockReady = 0;		FW.Default.SpellLockReadyMsg = ">> Spell Lock ready <<";
	
	FW.Default.SoulwellStart = 0;		FW.Default.SoulwellStartMsg = "Summoning >> %shp Soulwell << Yummie!";
	FW.Default.RitualOfDoomStart = 0;	FW.Default.RitualOfDoomStartMsg = "Want to end it all? Clicky clicky!";
	
	FW.Default.FearBreak = 0;		FW.Default.FearBreakMsg = ">> Fear on %s Broke Early! <<";
	FW.Default.FearFade = 0;		FW.Default.FearFadeMsg = ">> Fear on %s Fading in 3 seconds! <<";
	FW.Default.BanishBreak = 1;		FW.Default.BanishBreakMsg = ">> Banish on %s Broke Early! <<";
	FW.Default.BanishFade = 1;		FW.Default.BanishFadeMsg = ">> Banish on %s Fading in 3 seconds! <<";
	FW.Default.EnslaveBreak = 1;	FW.Default.EnslaveBreakMsg = ">> Enslave on %s Broke Early! <<";
	FW.Default.EnslaveFade = 1;		FW.Default.EnslaveFadeMsg = ">> Enslave on %s Fading in 3 seconds! <<";

	FW.Default.BloodPact = false;		FW.Default.BloodPactMsg = "warrior self";
	FW.Default.BloodpactGainColor = {1.00,0.40,0.00};
	FW.Default.BloodpactLossColor = {1.00,0.00,0.00};
	
	if CD then
		FW.Default.Cooldown.Filter[FW:SpellName(60949)] = 		{{-2,0.00,0.63,0.05}};--death coil
		FW.Default.Cooldown.Filter[FW:SpellName(47891)] = 		{{-2,0.63,0.00,1.00}};--shadow ward
		FW.Default.Cooldown.Filter[FW:SpellName(60429)] = 		{{-2,0.64,0.21,0.93}};--ritual of souls
		FW.Default.Cooldown.Filter[FW:SpellName(32835)] = 		{{-2,0.00,0.38,1.00}};--soulshatter
		FW.Default.Cooldown.Filter[FW:SpellName(29315)] = 		{{-1}};--phaseshift
		FW.Default.Cooldown.Filter[FW:SpellName(51439)] = 		{{-1}};--backlash
	end
end
