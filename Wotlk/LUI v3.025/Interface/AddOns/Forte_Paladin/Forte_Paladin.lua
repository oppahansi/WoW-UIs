-- ForteXorcist v1.959.8 by Xus 13-04-2010
-- Paladin module for ForteXorcist started by Arono of Skywall

if FW.CLASS == "PALADIN" then

	local FW = FW;
	local FWL = FW.L;
	local PA = FW:ClassModule("Paladin");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then
		FW:RegisterCustomName(58597,FWL.SACRED_SHIELD_EFFECT);
		-- Tier 7
		--FW:RegisterSet("Redemption Plate","39638", "39639", "39640", "39641", "39642", "40579", "40580", "40581", "40583", "40584");
		
		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack

		-- Holy Buffs
		ST:RegisterBuff(20216); -- Divine Favor
		--ST:RegisterBuff(43837); -- Enlightenment (T5 4-Set)
		ST:RegisterBuff(64891); -- Holy Mending (T8 2-Set)
		ST:RegisterBuff(54149,1); -- Infusion of Light (set to non-stacking)
		ST:RegisterBuff(53655); -- Judgements of the Pure
		ST:RegisterBuff(31834); -- Light's Grace
		ST:RegisterBuff(53659); -- Sacred Cleansing
		ST:RegisterBuff(54428); -- Divine Plea
		
		-- Protection Buffs
		ST:RegisterBuff(64883); -- Aegis (T8 4-Set)
		--ST:RegisterBuff(37193); -- Infused Shield (T5 4-Set)
		ST:RegisterBuff(20132); -- Redoubt
		ST:RegisterBuff(642); -- Divine Shield
		ST:RegisterBuff(48952); -- Holy Shield
		
		-- Retribution Buffs
		ST:RegisterBuff(59578); -- The Art of War
		ST:RegisterBuff(57669); -- Replenishment (Judgements of the Wise)
		ST:RegisterBuff(54203); -- Sheath of Light
		ST:RegisterBuff(20053); -- Vengeance
		
		-- Retribution Debuffs
		ST:RegisterSpell(53382, 1, 000, 1, FW.DEFAULT); -- Righteous Vengeance
			ST:RegisterTickSpeed(53382, 2); -- set tick speed to 2 instead of 3	
			
		-- Holy Spells
		ST:RegisterSpell(31821, 0, 006, 0, FW.BUFF); -- Aura Mastery
		ST:RegisterSpell(53563, 1, 060, 0, FW.BUFF); -- Beacon of Light
			ST:RegisterSpellModGlph(53563, 63865, 1, 030); -- Glyph of Beacon of Light
		ST:RegisterSpell(48819, 0, 008, 0, FW.DEFAULT); -- Consecration
			ST:RegisterSpellModGlph(48819, 55114, 1, 002); -- Glyph of Consecration
		ST:RegisterSpell(31842, 0, 015, 0, FW.DEFAULT); -- Divine Illumination
		ST:RegisterSpell(48817, 0, 003, 0, FW.DEFAULT); -- Holy Wrath (stun)
		ST:RegisterSpell(20235, 1, 015, 0, FW.DEFAULT); -- Improved Lay on Hands
		ST:RegisterSpell(53601, 1, 030, 0, FW.BUFF); -- Sacred Shield
		ST:RegisterSpell(58597, 1, 000, 0, FW.BUFF); -- Sacred Shield (shield)
			ST:RegisterSpellModTlnt(53601, 53530, 1, 015); -- Divine Guardian (Rank 1)
			ST:RegisterSpellModTlnt(53601, 53530, 2, 030); -- Divine Guardian (Rank 2)
		ST:RegisterSpell(10326, 1, 020, 0, FW.DEFAULT); -- Turn Evil
		-- Protection Spells
		ST:RegisterSpell(48827, 1, 010, 0, FW.DEFAULT); -- Avenger's Shield (daze)
		ST:RegisterSpell(19752, 1, 180, 0, FW.DEFAULT); -- Divine Intervention	
		ST:RegisterSpell(498,   0, 012, 0, FW.DEFAULT); -- Divine Protection
		ST:RegisterSpell(64205, 0, 010, 0, FW.DEFAULT); -- Divine Sacrifice
		ST:RegisterSpell(10308, 1, 006, 0, FW.DEFAULT); -- Hammer of Justice (stun)
		ST:RegisterSpell(1044,  1, 006, 0, FW.BUFF); -- Hand of Freedom
			ST:RegisterSpellModTlnt(1044, 20174, 1, 2); -- Guardian's Favor (Rank 1)
			ST:RegisterSpellModTlnt(1044, 20175, 1, 4); -- Guardian's Favor (Rank 2)
		ST:RegisterSpell(10278, 1, 010, 0, FW.BUFF); -- Hand of Protection
		ST:RegisterSpell(62124, 1, 003, 0, FW.DEFAULT); -- Hand of Reckoning
		ST:RegisterSpell(6940,  1, 012, 0, FW.BUFF); -- Hand of Sacrifice
		ST:RegisterSpell(1038,  1, 010, 0, FW.BUFF); -- Hand of Salvation
		ST:RegisterSpell(48785, 1, 000, 0, FW.HEAL); -- Flash of Light
			ST:RegisterTickSpeed(48785, 1);
		
		-- Retribution Spells
		ST:RegisterSpell(31884, 0, 020, 0, FW.DEFAULT); -- Avenging Wrath
		ST:RegisterSpell(53407, 1, 020, 0, FW.DEFAULT); -- Judgement of Justice
		ST:RegisterSpell(20271, 1, 020, 0, FW.DEFAULT); -- Judgement of Light
		ST:RegisterSpell(53408, 1, 020, 0, FW.DEFAULT); -- Judgement of Wisdom
		ST:RegisterSpell(20066, 1, 060, 0, FW.DEFAULT); -- Repentance (stun)
		
		ST:RegisterSpell(31803, 1, 000, 1, FW.DEFAULT); -- Holy Vengeance
			ST:RegisterSpecialRefresh(31803);
		ST:RegisterSpell(53742, 1, 000, 1, FW.DEFAULT); -- Blood Corruption
			ST:RegisterSpecialRefresh(53742);

		-- Libram Buffs
		ST:RegisterBuff(71192); -- Blessed, 				     from Libram of Blinding Light [ilvl264]
		ST:RegisterBuff(71187); -- Formidable, 			     from Libram of Three Truths [ilvl264]
		ST:RegisterBuff(71197); -- Evasive, 				     from Libram of the Eternal Tower [ilvl264]

		ST:RegisterBuff(60553); -- Relentless Aggression, 		     from Relentless Gladiator's Libram of Fortitude [ilvl251]
		ST:RegisterBuff(67378); -- Evasion, 				     from Libram of Defiance [ilvl245]
		ST:RegisterBuff(67371); -- Holy Strength, 			     from Libram of Valiance [ilvl245]
		ST:RegisterBuff(60551); -- "Furious Gladiator's Libram of Fortitude",     from Furious Gladiator's Libram of Fortitude [ilvl232]
		ST:RegisterBuff(65182); -- Increased Block, 			     from Libram of the Sacred Shield [ilvl226]
		ST:RegisterBuff(60549); -- Deadly Aggression, 			     from Deadly Gladiator's Libram of Fortitude [ilvl213]
		ST:RegisterBuff(60547); -- Hateful Aggression, 			     from Hateful Gladiator's Libram of Fortitude [ilvl200]
		ST:RegisterBuff(60544); -- Savage Aggression, 			     from Savage Gladiator's Libram of Fortitude [ilvl200]
		
		ST:RegisterBuff(46089); -- Brutal Gladiator's Libram of Fortitude/Vengeance
		ST:RegisterBuff(46093); -- Brutal Gladiator's Libram of Justice
		ST:RegisterBuff(43839); -- Gladiator's Libram of Fortitude/Vengeance
		ST:RegisterBuff(34135); -- Gladiator's Libram of Justice
		ST:RegisterBuff(34260); -- Libram of Avengement
		ST:RegisterBuff(43747); -- Libram of Divine Judgement
		ST:RegisterBuff(48836); -- Libram of Furious Blows
		ST:RegisterBuff(43742); -- Libram of Mending
		ST:RegisterBuff(60795); -- Libram of Obstruction
		ST:RegisterBuff(60819); -- Libram of Reciprocation
		ST:RegisterBuff(43848); -- Merciless Gladiator's Libram of Fortitude/Vengeance
		ST:RegisterBuff(42369); -- Merciless Gladiator's Libram of Justice
		ST:RegisterBuff(41043); -- Tome of the Lightbringer
		ST:RegisterBuff(43849); -- Vengeful Gladiator's Libram of Fortitude/Vengeance
		ST:RegisterBuff(43727); -- Vengeful Gladiator's Libram of Justice
		
		ST:RegisterDebuff(25771); -- Forbearance
		
		ST:RegisterCasterBuffs();
		ST:RegisterMeleeBuffs();
	end
	if CD then
		-- Holy Buffs
		CD:RegisterCooldownBuff(48936); -- Blessing of Wisdom
		CD:RegisterCooldownBuff(48938); -- Greater Blessing of Wisdom
		CD:RegisterCooldownBuff(20165); -- Seal of Light
		CD:RegisterCooldownBuff(21084); -- Seal of Righteousness
		CD:RegisterCooldownBuff(20166); -- Seal of Wisdom

		-- Protection Buffs
		CD:RegisterCooldownBuff(20217); -- Blessing of Kings
		CD:RegisterCooldownBuff(20911); -- Blessing of Sanctuary
		CD:RegisterCooldownBuff(25898); -- Greater Blessing of Kings
		CD:RegisterCooldownBuff(25899); -- Greater Blessing of Sanctuary
		CD:RegisterCooldownBuff(25780); -- Righteous Fury
		CD:RegisterCooldownBuff(20164); -- Seal of Justice

		-- Retribution Buffs
		CD:RegisterCooldownBuff(27140); -- Blessing of Might
		CD:RegisterCooldownBuff(48934); -- Greater Blessing of Might
		CD:RegisterCooldownBuff(31892); -- Seal of Blood
		CD:RegisterCooldownBuff(20375); -- Seal of Command
		CD:RegisterCooldownBuff(53736); -- Seal of Corruption
		CD:RegisterCooldownBuff(53720); -- Seal of the Martyr
		CD:RegisterCooldownBuff(31801); -- Seal of Vengeance
        
		CD:RegisterCasterPowerupCooldowns();
		CD:RegisterMeleePowerupCooldowns();
		
		-- Divine Shield, Divine Protection and Avenging Wrath cannot be used within 30s of each other (3.0.8)
		local avenging_wrath = FW:SpellName(31884);
		local divine_protection = FW:SpellName(498);
		local divine_shield = FW:SpellName(642);
		local hand_of_protection = FW:SpellName(10278);
		
		CD:RegisterOnCooldownUsed(function(s,d)
			if d~=30 then -- don't trigger any of the other hidden cooldowns if it's already a hidden cooldown
				if s == avenging_wrath then
					CD:HiddenCooldown(divine_shield, 030, "Interface\\Icons\\Spell_Holy_DivineIntervention");
					CD:HiddenCooldown(divine_protection, 030, "Interface\\Icons\\Spell_Holy_Restoration");
					CD:HiddenCooldown(hand_of_protection, 030, "Interface\\Icons\\Spell_Holy_SealofProtection");
				
				elseif s == divine_shield or s == divine_protection or s == hand_of_protection then
					CD:HiddenCooldown(avenging_wrath, 030, "Interface\\Icons\\Spell_Holy_AvengineWrath");
				
				end
			end
		end);
	end
end

