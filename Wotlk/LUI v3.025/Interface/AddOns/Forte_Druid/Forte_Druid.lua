-- ForteXorcist v1.959.8 by Xus 13-04-2010
-- Module started by Lurosara

-- TODO:
-- Forte_Timer:
--   Feral: Feral Charge Effect (Possibly too painful to implement in a reasonable manner.)

if FW.CLASS == "DRUID" then
	local FW = FW;
	local FWL = FW.L;
	local DR = FW:ClassModule("Druid");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	--
	-- Spell Timer
	--
	-- Note that the Cyclone timer is always going to be inaccurate past the first cast
	
	-- Register ID renames first! Only works for buffs and hidden cooldowns currently
	FW:RegisterCustomName(50334,FWL.BERSERK_FERAL);
	
	if ST then
		FW:RegisterSet("Thunderheart Regalia","31043","31035","31040","31046","31049","34572","34446","34555");
		FW:RegisterSet("Nordrassil Raiment","30216","30217","30219","30220","30220");
		--
		-- Spells
		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		-- spell, hastarget, duration, isdot, istype, reducedinpvp, texture, maxstacks
		
		-- Balance Spells
		ST:RegisterSpell(61662,	1,006,0,FW.UNIQUE,06); -- Cyclone
		ST:RegisterSpell(57095,	1,027,0,FW.UNIQUE,12); -- Entangling Roots
			ST:RegisterSpellModRank(57095, 1, -15);
			ST:RegisterSpellModRank(57095, 2, -12);
			ST:RegisterSpellModRank(57095, 3, -9);
			ST:RegisterSpellModRank(57095, 4, -6);
			ST:RegisterSpellModRank(57095, 5, -3);
		ST:RegisterSpell(21670,	1,040,0,FW.DEFAULT); -- Faerie Fire
		ST:RegisterSpell(33831,	0,030,0,FW.PET); -- Force of Nature
		ST:RegisterSpell(18658,	1,040,0,FW.UNIQUE,12); -- Hibernate
			ST:RegisterSpellModRank(18658, 1, -20);
			ST:RegisterSpellModRank(18658, 2, -10);
		ST:RegisterSpell(48468,	1,012,1,FW.DEFAULT); -- Insect Swarm
			ST:RegisterTickSpeed(48468, 2); -- set tick speed to 2 instead of 3
			ST:RegisterSpellModTlnt(48468,57865,1,2); -- Nature's Splendor
		ST:RegisterSpell(59987,	1,012,1,FW.DEFAULT); -- Moonfire
			ST:RegisterSpellModSetB(59987,"Thunderheart Regalia", 2, 3);
			ST:RegisterSpellModTlnt(59987,57865,1,3); -- Nature's Splendor
		
		-- Feral Spells
		ST:RegisterSpell(58861,	1,004,0,FW.UNIQUE); -- Bash
			ST:RegisterSpellModTlnt(58861,16941,1,0.5); -- 16941 = Brutal Impact
			ST:RegisterSpellModTlnt(58861,16941,2,1);
		ST:RegisterSpell(48560,	1,030,0,FW.UNIQUE); -- Demoralizing Roar
		ST:RegisterSpell(5209,	1,006,0,FW.UNIQUE); -- Challenging Roar
		ST:RegisterSpell(16857,	1,040,0,FW.DEFAULT); -- Faerie Fire (Feral)
		ST:RegisterSpell(61676,	1,003,0,FW.UNIQUE); -- Growl
		ST:RegisterSpell(48564,	1,012,0,FW.SHARED); -- Mangle - Bear
		ST:RegisterSpell(48566,	1,012,0,FW.SHARED); -- Mangle - Cat
		ST:RegisterSpell(49803,	1,003,0,FW.DEFAULT); -- Pounce
			ST:RegisterSpellModTlnt(49803,16941,1,0.5);
			ST:RegisterSpellModTlnt(49803,16941,2,1);
		ST:RegisterSpellAdd(49803, 49804); -- 49804 = Pounce Bleed
		ST:RegisterSpell(49804,	1,018,1,FW.DEFAULT); -- Pounce Bleed
		ST:RegisterSpell(59886,	1,009,1,FW.DEFAULT); -- Rake
		ST:RegisterSpell(59989,	1,012,1,FW.DEFAULT); -- Rip
			ST:RegisterTickSpeed(59989, 2); -- set tick speed to 2 instead of 3
			ST:RegisterSpellModGlph(59989,54860,1,4); -- glyph of rip
			
		ST:RegisterSpell(49802,	1,001,0,FW.UNIQUE); -- Maim
			ST:RegisterSpellModComb(49802,1,1);--like the other spellmods,
			ST:RegisterSpellModComb(49802,2,2);--this is added for each
			ST:RegisterSpellModComb(49802,3,3);--of the number of combopoints
			ST:RegisterSpellModComb(49802,4,4);
			ST:RegisterSpellModComb(49802,5,5);
		-- Shred, Maul, and Mangle -> Infected Wounds
		ST:RegisterSpellRename(48572,58179); -- Shred to Infected Wounds
		ST:RegisterSpellRename(48480,58179); -- Maul to Infected Wounds
		ST:RegisterSpellAdd(48564,58179); -- add to mangle
		ST:RegisterSpellAdd(48566,58179); -- add to mangle
		ST:RegisterSpell(58179, 1, 012,0,FW.DEFAULT,nil,nil,2); -- Infected Wounds
			ST:RegisterSpellModTlnt(58179,48485,0,-12); -- only if you have this talent...
		ST:RegisterSpell(48568, 1, 015,1,FW.DEFAULT,nil,nil,5); -- Lacerate
		
		-- Resto Spells
		ST:RegisterSpell(29166,	1,010,0,FW.BUFF); -- Innervate
		ST:RegisterSpell(14253,	1,008,0,FW.BUFF); -- Abolish Poison
		ST:RegisterSpell(59990,	1,007,0,FW.HEAL,nil,nil,3); -- Lifebloom
			ST:RegisterTickSpeed(59990, 1); -- set tick speed to 1 instead of 3
			ST:RegisterSpellModTlnt(59990,57865,1,2);-- Nature's Splendor
			ST:RegisterSpellModGlph(59990,54826,1,1); -- glyph of lifebloom
		ST:RegisterSpell(48443,	1,021,0,FW.HEAL); -- Regrowth
			ST:RegisterSpellModSetB(48443, "Nordrassil Raiment", 2, 6);
			ST:RegisterSpellModTlnt(48443,    57865,1,6); -- Nature's Splendor
		ST:RegisterSpell(48441,	1,015,0,FW.HEAL); -- Rejuvenation
			ST:RegisterSpellModTlnt(48441,	57865,1,3);-- Nature's Splendor
			ST:RegisterHastedGlyph(48441,71014); -- set to hasted hot, requires Glyph of Rapid Rejuvenation
			
		ST:RegisterSpell(48500,	1,015,0,FW.HEAL); -- Living Seed
		ST:RegisterSpell(53251,	1,007,0,FW.HEAL); -- Wild Growth
			ST:RegisterTickSpeed(53251, 1); -- set tick speed to 1 instead of 3
		--
		-- Buffs
		-- buffname,hidden cd
		ST:RegisterBuff(48517); -- eclipse (solar)
		ST:RegisterBuff(48518); -- eclipse (lunar)
		ST:RegisterBuff(52610); -- savage roar

		-- Balance Buffs
		ST:RegisterBuff(22812); -- Barkskin
		ST:RegisterBuff(53312); -- Nature's Grasp
		ST:RegisterBuff(61346); -- Nature's Grace

		-- Feral Buffs
		ST:RegisterBuff(61684); -- Dash
		ST:RegisterBuff(59828); -- Enrage
		ST:RegisterBuff(22845); -- Frenzied Regeneration
		ST:RegisterBuff(50213); -- Tiger's Fury
		ST:RegisterBuff(37316); -- Nurture 2 piece Feral T5
		ST:RegisterBuff(50334); -- Berserk

		-- Resto Buffs
		ST:RegisterBuff(34754); -- Clearcasting
		ST:RegisterBuff(45283); -- Natural Perfection

		-- Feral Procs/Trinkets
		ST:RegisterBuff(43738); -- Primal Instinct, Idol of Terror
		ST:RegisterBuff(43716); -- Call of the Berserker, Berserker's Call
		ST:RegisterBuff(34519); -- Time's Favor, Moroes' Lucky Pocket Watch
		ST:RegisterBuff(40464); -- Protector's Vigor, Shadowmoon Insignia
		ST:RegisterBuff(40729); -- Heightened Reflexes, Badge of Tenacity
		
		ST:RegisterBuff(67354); -- Evasion, Idol of Mutilation
		ST:RegisterBuff(67355); -- Agile, Idol of Mutilation
		ST:RegisterBuff(67360); -- Blessing of the Moon Goddess, Idol of Lunar Fury
		ST:RegisterBuff(67358); -- Rejuvenating, Idol of Flaring Growth
		ST:RegisterBuff(60569); -- Relentless Survival, Relentless Gladiator's Idol of Steadfastness
		ST:RegisterBuff(60553); -- Relentless Aggression, Relentless Gladiator's Idol of Resolve
		ST:RegisterBuff(71177); -- Vicious, Idol of the Lunar Eclipse
		ST:RegisterBuff(71175); -- Agile, Idol of the Crying Moon
		ST:RegisterBuff(71184); -- Soothing, Idol of the Black Willow
		
		ST:RegisterCasterBuffs();
		ST:RegisterMeleeBuffs();
		
	end
	--
	-- Cooldown Timer
	--
	if CD then
		-- Note: One day, this will correctly track Clearcasting/Nature's Gasp/Nature's Grace.
		
		-- Balance buffs
		CD:RegisterCooldownBuff(22812); -- barkskin
		CD:RegisterCooldownBuff(53307); -- thorns

		-- Resto buffs
		CD:RegisterCooldownBuff(48470); -- Gift of the Wild
		CD:RegisterCooldownBuff(48469); -- Mark of the Wild
		CD:RegisterCooldownBuff(16864); -- Omen of Clarity
		
		CD:RegisterHiddenCooldown(nil,48517,30); -- eclipse (solar)
		CD:RegisterHiddenCooldown(nil,48518,30); -- eclipse (lunar)
		
		-- other idols
		--CD:RegisterHiddenCooldown(47668,67354,45); -- Idol of Mutilation, Evasion
		--CD:RegisterHiddenCooldown(47670,67360,05); -- Idol of Lunar Fury, Blessing of the Moon Goddess
		--CD:RegisterHiddenCooldown(47671,67358,05); -- Idol of Flaring Growth, Rejuvenating
  
		-- Powerups
		CD:RegisterCasterPowerupCooldowns();
		CD:RegisterMeleePowerupCooldowns();
	end
end
