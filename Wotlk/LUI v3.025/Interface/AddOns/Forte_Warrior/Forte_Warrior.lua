-- ForteXorcist v1.959.8 by Xus 13-04-2010

if FW.CLASS == "WARRIOR" then
	local FW = FW;
	local FWL = FW.L;
	local WR = FW:ClassModule("Warrior");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then
	
		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack
		
		ST:RegisterSpell(59608,	1,030,0,FW.DEFAULT,000,nil,5); -- Sunder Armor
		ST:RegisterSpell(355,	1,003,0,FW.UNIQUE); -- Taunt
		ST:RegisterSpell(694,	1,006,0,FW.UNIQUE); -- Mocking Blow
		ST:RegisterSpell(676,	1,010,0,FW.UNIQUE); -- Disarm
		ST:RegisterSpell(57789,	1,010,0,FW.DEFAULT); -- Mortal Strike
		ST:RegisterSpell(12868,	1,006,1,FW.DEFAULT); -- Deep Wounds
			ST:RegisterTickSpeed(12868, 1); -- set tick speed to 1 instead of 3
		ST:RegisterSpell(59691,	1,015,1,FW.DEFAULT); -- Rend
			ST:RegisterSpellModGlph(59691, 58399,	1, 6);
		ST:RegisterSpell(48639,	1,015,0,FW.DEFAULT); -- Hamstring
		ST:RegisterSpell(61044,	0,030,0,FW.UNIQUE); -- Demoralizing Shout   
		ST:RegisterSpell(20511,	0,008,0,FW.UNIQUE); -- Intimidating Shout
		ST:RegisterSpell(60019,	0,030,0,FW.UNIQUE); -- Thunder Clap
			 ST:RegisterSpellModRank(60019,	1, -20); 
			 ST:RegisterSpellModRank(60019,	2, -16); 
			 ST:RegisterSpellModRank(60019,	3, -12); 
			 ST:RegisterSpellModRank(60019,	4, -8);
			 ST:RegisterSpellModRank(60019,	5, -4);
		ST:RegisterSpell(12323,	0,006,0,FW.UNIQUE); -- Piercing Howl	 
		
		ST:RegisterSpell(50725,	1,1800,0,FW.BUFF); -- Vigilance

		--buffname,duration
		ST:RegisterBuff(29131); -- Bloodrage
		ST:RegisterBuff(47440); -- Commanding Shout
		ST:RegisterBuff(59707); -- Enrage
		ST:RegisterBuff(30029); -- Rampage
		ST:RegisterBuff(35429); -- Sweeping Strikes
		ST:RegisterBuff(12292);	-- Death Wish
		
		ST:RegisterBuff(59614); -- Battle Shout
		ST:RegisterBuff(18499); -- Berserker Rage
		ST:RegisterBuff(1719); -- Recklessness
		
		ST:RegisterBuff(60503); -- Taste for Blood
	
		-- Slam!
		ST:RegisterBuff(46916);	
		
		--debuffs
		ST:RegisterDebuff(59608); -- Sunder Armor
		ST:RegisterDebuff(57789); -- Mortal Strike
		ST:RegisterDebuff(48639); -- Hamstring
		ST:RegisterDebuff(60019); -- Thunder Clap
		ST:RegisterDebuff(61044); -- Demoralizing Shout    
		ST:RegisterDebuff(20511); -- Intimidating Shout
		ST:RegisterDebuff(12323); -- Piercing Howl
		
		ST:RegisterMeleeBuffs();
	end
	if CD then
		CD:RegisterCooldownBuff(59614);--"Battle Shout"
		CD:RegisterHiddenCooldown(nil,60503,6);
		CD:RegisterMeleePowerupCooldowns();
	end
end
