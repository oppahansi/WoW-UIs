-- ForteXorcist v1.959.8 by Xus 13-04-2010

if FW.CLASS == "ROGUE" then
	local FW = FW;
	local FWL = FW.L;
	local PR = FW:ClassModule("Rogue");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then
		-- istype: FW.DEFAULT	FW.SHARED FW.UNIQUE	FW.PET FW.POWERUP FW.CHARM FW.DEBUFF FW.DRAIN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack
		
		-- Self buffs
		ST:RegisterBuff(13750); -- Adrenaline Rush
		ST:RegisterBuff(13877); -- Blade Flurry
		ST:RegisterBuff(14177); -- Cold Blood
		ST:RegisterBuff(26669); -- Evasion
		ST:RegisterBuff(11305); -- Sprint
		ST:RegisterBuff(31224); -- CloS
		ST:RegisterBuff(26889); -- Vanish
		ST:RegisterBuff(48659); -- Feint
		ST:RegisterBuff(51662); -- Hunger for Blood
		ST:RegisterBuff(57934); -- Tricks of the Trade
		ST:RegisterBuff(6774); -- Slice and Dice
		
		-- Abilities
		ST:RegisterSpell(30621, 1, 000,0,FW.UNIQUE); -- Kidney Shot
		ST:RegisterSpell( 2094, 1, 000,0,FW.UNIQUE); -- Blind
		ST:RegisterSpell(51724, 1, 000,0,FW.UNIQUE); -- Sap
		ST:RegisterSpell(18425, 1, 000,0,FW.UNIQUE); -- Kick silence
		ST:RegisterSpell(32748, 1, 000,0,FW.UNIQUE); -- Deadly Throw interrupt
		ST:RegisterSpell( 1330, 1, 000,0,FW.UNIQUE); -- Garrote silence	
		ST:RegisterSpell( 1833, 1, 000,0,FW.UNIQUE); -- Cheap Shot
		ST:RegisterSpell(38764, 1, 000,0,FW.UNIQUE); -- Gouge
		ST:RegisterSpell(51722, 1, 000,0,FW.UNIQUE); -- Dismantle
		ST:RegisterSpell(25809, 1, 000,0,FW.UNIQUE); -- Crippling Poison
		ST:RegisterSpell( 5760, 1, 000,0,FW.UNIQUE); -- Mind-numbing Poison
		
		ST:RegisterSpell(48676, 1, 000,1,FW.DEFAULT); -- Garrote
		ST:RegisterSpell(48672, 1, 000,1,FW.DEFAULT); -- Rupture
			ST:RegisterTickSpeed(48672, 2); -- set tick speed to 2 instead of 3	
			
		ST:RegisterSpell(57975, 1, 000,0,FW.UNIQUE); -- Wound Poison
		
		ST:RegisterSpell(57993, 1, 000,0,FW.DEFAULT); -- Envenom
		
		-- Poisons
		ST:RegisterSpell(2818, 1,000,1,FW.DEFAULT);  -- Deadly Poison I
			ST:RegisterSpecialRefresh(2818);
		ST:RegisterSpell(2824, 1,000,1,FW.DEFAULT);  -- Deadly Poison II
			ST:RegisterSpecialRefresh(2824);
		ST:RegisterSpell(11353, 1,000,1,FW.DEFAULT); -- Deadly Poison III
			ST:RegisterSpecialRefresh(11353);
		ST:RegisterSpell(11354, 1,000,1,FW.DEFAULT); -- Deadly Poison IV
			ST:RegisterSpecialRefresh(11354);
		ST:RegisterSpell(25349, 1,000,1,FW.DEFAULT); -- Deadly Poison V
			ST:RegisterSpecialRefresh(25349);
		ST:RegisterSpell(26968, 1,000,1,FW.DEFAULT); -- Deadly Poison VI
			ST:RegisterSpecialRefresh(26968);
		ST:RegisterSpell(27187, 1,000,1,FW.DEFAULT); -- Deadly Poison VII
			ST:RegisterSpecialRefresh(27187);
		ST:RegisterSpell(57969, 1,000,1,FW.DEFAULT); -- Deadly Poison VIII
			ST:RegisterSpecialRefresh(57969);
		ST:RegisterSpell(57970, 1,000,1,FW.DEFAULT); -- Deadly Poison IX
			ST:RegisterSpecialRefresh(57970);
		
		ST:RegisterMeleeBuffs();		
		--ST:RegisterCasterBuffs();
				
	end
	if CD then
		CD:RegisterMeleePowerupCooldowns();
	end
end
