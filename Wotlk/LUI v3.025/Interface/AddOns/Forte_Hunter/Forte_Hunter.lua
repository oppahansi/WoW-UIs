-- ForteXorcist v1.959.8 by Xus 13-04-2010
-- Module started by Destard/Stormstalker fixes by Caleb & Xus

if FW.CLASS == "HUNTER" then
	local FW = FW;
	local FWL = FW.L;
	local HT = FW:ClassModule("Hunter");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then
		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack
		-- DON'T SET ANYTHING WITH TRAVEL TIME TO DOT YET PLX
		
		ST:RegisterDrain(27022,	6); -- Volley
		
 		ST:RegisterSpell(1543,	0,20,0,FW.UNIQUE);-- Flare
		ST:RegisterSpell(781,	0,25,0,FW.UNIQUE);-- Disengage
			ST:RegisterSpellModGlph(781,	42904, 1, -5);-- Glyph of Serpent Sting
			ST:RegisterSpellModTlnt(781,	19286, 1, -2);-- Survival Tactics
			ST:RegisterSpellModTlnt(781,	19287, 2, -4);-- Survival Tactics
		
 		ST:RegisterSpell(53338,	1,300,0,FW.UNIQUE);-- Hunter's Mark
 		ST:RegisterSpell(14327,	1,020,0,FW.UNIQUE);-- Scare Beast
			ST:RegisterSpellModRank(14327, 	1, -10);
			ST:RegisterSpellModRank(14327, 	2, -5);
		ST:RegisterSpell(48990,	0,015,0,FW.PET);-- Mend Pet
		ST:RegisterSpell(6991,	0,010,0,FW.PET);-- Feed Pet
 		ST:RegisterSpell(49001,	1,015,1,FW.SHARED);-- Serpent Sting
			ST:RegisterSpecialRefresh(49001);
			ST:RegisterSpellModGlph(49001,	57009,	1, 6); -- Glyph of Serpent Sting
		ST:RegisterSpell(3034,	1,008,0,FW.SHARED); -- Viper Sting
		ST:RegisterSpell(52604,	1,020,0,FW.SHARED); -- Scorpid Sting
		ST:RegisterSpell(60053, 1,002,0,FW.DEFAULT);	-- Explosive Shot
			ST:RegisterTickSpeed(60053, FW.DEFAULT); -- set tick speed to 1 instead of 3
		ST:RegisterSpell(2974 , 1,010,0,FW.UNIQUE); -- Wing Clip
		ST:RegisterSpell(19503, 1,004,0,FW.UNIQUE); -- scatter shot
		ST:RegisterSpell(19386, 1,030,0,FW.UNIQUE);	-- wyvern sting			
		ST:RegisterSpell(34490, 1,003,0,FW.UNIQUE);	-- silencing shot
		ST:RegisterSpell(53548, 1,004,0,FW.PET);	-- pet pin
		ST:RegisterSpell(35102, 1,004,0,FW.UNIQUE);	-- concussive barrage
		ST:RegisterSpell(63672, 1,015,1,FW.DEFAULT);	-- black arrow
		ST:RegisterSpell(49050, 1,010,0,FW.DEFAULT);	-- Aimed Shot
		ST:RegisterSpell(53238, 1,000,1,FW.DEFAULT); -- Piercing Shots
			ST:RegisterTickSpeed(53238, 2); -- set tick speed to 2 instead of 3	

		ST:RegisterSpell(55754, 1,000,0,FW.PET,nil,nil,2);	-- pet acid spit (030 set to 000 because of travel time)			
		
		--[[ST:RegisterCooldown(61006,015); -- Kill Shot
			ST:RegisterCooldownModGlph(61006,64304,	1, -6); -- Glyph of Kill Shot
		ST:RegisterCooldown(49050,010); -- Aimed Shot
			ST:RegisterCooldownModGlph(49050,56869,	1, -2); -- Glyph of Aimed Shot
		ST:RegisterCooldown(49048,010); -- Multi Shot
			ST:RegisterCooldownModGlph(49048,56882,	1, -1); -- Glyph of Multi Shot
		ST:RegisterCooldown(49045,006); -- Arcane Shot]]
		
			-- hunter buffs
		ST:RegisterBuff(38373); -- The Beast Within
		ST:RegisterBuff(36828); -- Rapid Fire
		ST:RegisterBuff(56453); -- Lock and Load
		ST:RegisterBuff(35099); -- Rapid Killing
		ST:RegisterBuff(40487); -- Deadly Aim
		ST:RegisterBuff(53271); -- Master's call
		ST:RegisterBuff(19263); -- Deterrence
		ST:RegisterBuff(34477); -- Misdirection
		ST:RegisterBuff(53304); -- Sniper Training
		ST:RegisterBuff(34501); -- Expose Weakness
		ST:RegisterBuff(34839); -- Master Tactician
		ST:RegisterBuff(64495); -- Furious Howl
		ST:RegisterBuff(70728); -- Exploit Weakness (t10)
		ST:RegisterBuff(6150); -- Quick Shots (imp asp o t hawk)
		
		ST:RegisterSpell(13809,	0,030,0,FW.UNIQUE);-- Frost Trap
 		ST:RegisterSpell(34600,	0,030,0,FW.UNIQUE);-- Snake Trap
		--ST:RegisterSpell(49067,	0,020,0,FW.UNIQUE);-- Explosive Trap
		
 		ST:RegisterSpell(49065,	1,030,0,FW.UNIQUE);-- Explosive Trap Effect -- debuff on target
			ST:RegisterSpellRename(49067,49065); --trap which triggers debuff
		
		ST:RegisterSpell(49054, 1,030,0,FW.UNIQUE); -- Immolation Trap Effect -- debuff on target
			ST:RegisterSpellRename(52606,49054); --trap which triggers debuff
		ST:RegisterSpell(60210, 1,030,0,FW.UNIQUE); -- Freezing Arrow Effect -- debuff on target
			ST:RegisterSpellRename(60192,60210); --trap which triggers debuff
		ST:RegisterSpell(14309, 1,030,0,FW.UNIQUE); -- Freezing Trap Effect -- debuff on target
			ST:RegisterSpellRename(14311,14309); --trap which triggers debuff
			
		--debuffname,mine only
 		ST:RegisterDebuff(55041); -- Freezing Trap Effect
		ST:RegisterDebuff(60210); -- Freezing Arrow Effect
		ST:RegisterDebuff(53338); -- Hunter's Mark
		
		ST:RegisterMeleeBuffs();
		ST:RegisterCasterBuffs();
	end
	if CD then
		tinsert(CD.Masters,{"^"..FW:SpellName(52606)}); -- immolation trap
		tinsert(CD.Masters,{"^"..FW:SpellName(14311)}); -- freezing trap
		tinsert(CD.Masters,{"^"..FW:SpellName(49045)}); -- arcane shot
		tinsert(CD.Masters,{"^"..FW:SpellName(49050)}); -- aimed shot
		
		CD:RegisterMeleePowerupCooldowns();
		CD:RegisterCasterPowerupCooldowns();
		
		CD:RegisterHiddenCooldown(nil,56453,22); -- Lock and Load
		
		local readiness = FW:SpellName(23989);
		local bestial_wrath = FW:SpellName(19574);
		
		CD:RegisterOnCooldownUsed(function(s,d)
			if s == readiness then
				local i = 1; -- needs testing, but should work in theory
				while i<=CD.CD.rows do
					if CD.CD[i][6]==1 then -- FLAG_SPELL only
						local spell = CD.CD[i][1];
						if spell ~= readiness and spell ~= bestial_wrath then
							CD:CheckCooldown(spell,GetTime(),0,"",1);
						end
					end
					i=i+1;
				end
			end
		end);
	end
end