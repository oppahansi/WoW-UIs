-- ForteXorcist v1.959.8 by Xus 13-04-2010

if FW.CLASS == "PRIEST" then
	local FW = FW;
	local FWL = FW.L;
	local PR = FW:ClassModule("Priest");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then
		FW:RegisterSet("Absolution Regalia","31061","31064","31067","31070","31065","34434","34528","34563");
		
		FW:RegisterSet("Velen's/Zabra's Regalia",
			"48072","48073","48074","48075","48076",
			"48077","48078","48079","48080","48081",
			"48082","48083","48084","48085","48086",
			"48087","48088","48089","48090","48091",
			"48092","48093","48094","48095","48096",
			"48097","48098","48099","48100","48101"
		);
		
		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack
 		
 		ST:RegisterSpell(48125,	1,018,1,FW.DEFAULT); -- Shadow Word: Pain
			ST:RegisterSpecialRefresh(48125);
			ST:RegisterSpellModSetB(48125,	"Absolution Regalia", 2, 3);
		ST:RegisterSpell(48160,	1,015,1,FW.DEFAULT); -- Vampiric Touch
			ST:RegisterSpellModSetB(48160,	"Velen's/Zabra's Regalia", 2, 6);
			ST:RegisterHastedStance(48160,1); -- set to hasted dot, requires Shadow Form
 		ST:RegisterSpell(34433,	0,015,0,FW.PET); -- Shadowfiend
 		ST:RegisterSpell(43432,	0,008,0,FW.UNIQUE); -- Psychic Scream
 		ST:RegisterSpell(40135,	1,050,0,FW.UNIQUE); -- Shackle Undead
			ST:RegisterSpellModRank(40135, 	1, -20);
			ST:RegisterSpellModRank(40135, 	2, -10);
		
		ST:RegisterSpell(453,	1,015,0,FW.UNIQUE); -- Mind Soothe
		ST:RegisterSpell(48066,	1,030,0,FW.BUFF); -- Power Word: Shield
		ST:RegisterSpell(48068,	1,015,0,FW.HEAL); -- Renew
			ST:RegisterSpellModGlph(48068, 56178, 1, -3); -- Glyph of Renew

		ST:RegisterSpell(48300,	1,024,1,FW.UNIQUE); -- Devouring Plague 
			ST:RegisterHastedStance(48300,1); -- set to hasted dot, requires Shadow Form
		ST:RegisterSpell(15487,	1,005,0,FW.UNIQUE); -- Silence
		ST:RegisterSpell(48135, 1,007,1,FW.DEFAULT); -- holy fire
			ST:RegisterTickSpeed(48135, 1); -- set tick speed to 1 instead of 3
		
		ST:RegisterSpell(48113,	1,030,0,FW.BUFF); -- Prayer of Mending
		ST:RegisterSpell(15359,	1,015,0,FW.BUFF); -- Inspiration
		ST:RegisterSpell(  552, 1,012,0,FW.BUFF); -- Abolish Disease		
		ST:RegisterSpell(33206, 1,008,0,FW.BUFF); -- Pain Suppression
		ST:RegisterSpell(10060, 1,015,0,FW.BUFF); -- Power Infusion
		ST:RegisterSpell(47788, 1,010,0,FW.BUFF); -- Guardian Spirit
		
		ST:RegisterSpell(47753, 1,012,0,FW.BUFF); -- Divine Aegis
		ST:RegisterSpell(47930, 1,015,0,FW.BUFF,000,nil,3); -- Grace
		
		ST:RegisterCooldown(48127,008); -- Mind Blast
			ST:RegisterCooldownModTlnt(48127,	15316, 1, -0.5); -- Improved Mind Blast
			ST:RegisterCooldownModTlnt(48127,	15316, 2, -1.0);
			ST:RegisterCooldownModTlnt(48127,	15316, 3, -1.5);
			ST:RegisterCooldownModTlnt(48127,	15316, 4, -2.0);
			ST:RegisterCooldownModTlnt(48127,	15316, 5, -2.5);
		ST:RegisterCooldown(51818,012); -- Shadow Word: Death
				
		-- id/name, ticks total
		ST:RegisterDrain(48156,	3); -- Mind Flay
		ST:RegisterDrain(53022,	5); -- Mind Sear
		
		--Priest Buffs
		ST:RegisterBuff(63734); -- Serendipity
		ST:RegisterBuff(33154); -- Surge of Light
		ST:RegisterBuff(52800); -- Borrowed Time
		ST:RegisterBuff(34860); -- Holy Concentration
		ST:RegisterBuff(12685); -- Fade
		ST:RegisterBuff(48168); -- Inner fire
		ST:RegisterBuff(15258); -- Shadow Weaving
		ST:RegisterBuff(47585); -- Dispersion
		ST:RegisterBuff(15290); -- Vampiric Embrace
		ST:RegisterBuff(70799); -- Flash Heal!

		--debuffname,mineonly
			
		-- weakened soul
 		ST:RegisterDebuff(6788);

		ST:RegisterCasterBuffs();
		
	end
	if CD then
		do
			local PLAYER = FW.PLAYER;
			local rapture,texture = FW:SpellName(47755);
			local select = select;
			local function PR_CombatLogEvent(event,...)
				if select(4,...) == PLAYER and select(10,...) == rapture then
					CD:HiddenCooldown(rapture, 012, texture);
				end
			end
			FW:RegisterToEvent("COMBAT_LOG_EVENT_UNFILTERED",	PR_CombatLogEvent);
		end
	
		CD:RegisterCooldownBuff(15290); -- Vampiric Embrace
		CD:RegisterCooldownBuff(48168); -- Inner Fire
		CD:RegisterCasterPowerupCooldowns();
	end
end
