-- ForteXorcist v1.959.8 by Xus 13-04-2010
-- Forte Mage Module attempt by Amros of Gilneas

if FW.CLASS == "MAGE" then
	local FW = FW;
	local FWL = FW.L;
	local MG = FW:ClassModule("Mage");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	if ST then

		-- istype: FW.DEFAULT FW.SHARED FW.UNIQUE FW.PET FW.CHARM FW.COOLDOWN FW.HEAL FW.BUFF
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stack
	
		ST:RegisterSpell(58537,1,050,0,FW.UNIQUE,010); -- Polymorph
			ST:RegisterSpellModRank(58537,	1, -30);
			ST:RegisterSpellModRank(58537,	2, -20);
			ST:RegisterSpellModRank(58537,	3, -10);
		ST:RegisterSpell(55361,1,012,1,FW.DEFAULT); -- living bomb
		ST:RegisterSpell(12848,1,004,1,FW.DEFAULT); -- ignite
			ST:RegisterTickSpeed(12848, 1); -- set tick speed to 1 instead of 3
		ST:RegisterSpell(42833,1,000,0,FW.DEFAULT); -- fireball
			ST:RegisterTickSpeed(42833, 2); -- set tick speed to 2 instead of 3	
			
		ST:RegisterSpell(31589,1,000,0,FW.UNIQUE); -- slow
		ST:RegisterSpell(42931,0,008,0,FW.UNIQUE); -- cone of cold
		ST:RegisterSpell(42917,0,008,0,FW.UNIQUE); -- frost nova
		ST:RegisterSpell(44572,1,005,0,FW.UNIQUE); -- deep freeze
		
		ST:RegisterSpell(12497,1,005,0,FW.DEFAULT); -- frostbite
		
		ST:RegisterSpell(55342,0,030,0,FW.UNIQUE); -- Mirror Image
		ST:RegisterSpell(12486,1,000,0,FW.DEFAULT); -- chill
		
		ST:RegisterSpell(43015,1,600,0,FW.BUFF); -- Dampen Magic
		ST:RegisterSpell(43017,1,600,0,FW.BUFF); -- Amplify Magic
		
		ST:RegisterBuff(34754); -- Clearcasting
		ST:RegisterBuff(48108); -- Hot Streak
		ST:RegisterBuff(37445);	-- Mana Surge
		
		ST:RegisterBuff(12042); -- Arcane Power
		ST:RegisterBuff(43020); -- Mana Shield
		ST:RegisterBuff(43010); -- Fire Ward
		ST:RegisterBuff(43012); -- Frost Ward
		ST:RegisterBuff(12472); -- Icy Veins
		ST:RegisterBuff(54490); -- Missile Barrage
		ST:RegisterBuff(57761); -- Fireball!
		ST:RegisterBuff(70753); -- Pushing the Limit
		
		ST:RegisterBuff(67765); -- Invisibility
		ST:RegisterBuff(12051); -- Evocation
		ST:RegisterBuff(45438); -- Ice Block
		
		ST:RegisterBuff(43024); -- Mage Armor
		ST:RegisterBuff(43046); -- Molten Armor
		ST:RegisterBuff(7301); -- Frost Armor
		ST:RegisterBuff(43008); -- Ice Armor
		
		ST:RegisterBuff(44545); -- Fingers of Frost
		
		-- self debuffs
		ST:RegisterSelfDebuff(36032); -- Arcane Blast

		--debuffs
		ST:RegisterDebuff(42931); -- cone of cold
		ST:RegisterDebuff(42917); -- frost nova

		ST:RegisterCasterBuffs();
		
		local poly = FW:SpellName(58537);
		ST:RegisterOnTimerBreak(function(unit,mark,spell)
			if spell == poly then
				if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
				CA:CastShow("PolymorphBreak",unit);
			end
		end);
		ST:RegisterOnTimerFade(function(unit,mark,spell,t)
			if spell == poly then
				if t <= ST:GetFadeTime("PolymorphFade") then
					if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
					CA:CastShow("PolymorphFade",unit);
					return 1;
				end
			end
		end);
	end
	if CD then
		CD:RegisterCasterPowerupCooldowns();
	end

	FW:SetMainCategory(FWL.RAID_MESSAGES,FW.ICON_MESSAGE,10,"RAIDMESSAGES");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
	FW:RegisterOption(FW.INF,2,FW.NON,FWL.RAID_MESSAGES_HINT1);
	FW:RegisterOption(FW.INF,2,FW.NON,FWL.RAID_MESSAGES_HINT2);
	FW:RegisterOption(FW.CHK,2,FW.NON,FWL.SHOW_IN_RAID,		FWL.SHOW_IN_RAID_TT,    "OutputRaid");
	FW:RegisterOption(FW.MSG,2,FW.NON,FWL.SHOW_IN_CHANNEL,	FWL.SHOW_IN_CHANNEL_TT,	"Output");

	if ST then
		FW:SetSubCategory(FWL.BREAK_FADE,FW.ICON_SPECIFIC,2);
		FW:RegisterOption(FW.INF,2,FW.NON,FWL.BREAK_FADE_HINT1);
		FW:RegisterOption(FW.MS2,2,FW.NON,FWL.POLYMORPH_BREAK,		"",    "PolymorphBreak");
		FW:RegisterOption(FW.MS2,2,FW.NON,FWL.POLYMORPH_FADE,		"",    "PolymorphFade");
	end

	FW.Default.OutputRaid = true;
	FW.Default.Output = true;
	FW.Default.OutputMsg = "MyProMageChannel";

	FW.Default.PolymorphBreak = 0;	FW.Default.PolymorphBreakMsg = ">> Polymorph on %s Broke Early! <<";
	FW.Default.PolymorphFade = 0;	FW.Default.PolymorphFadeMsg = ">> Polymorph on %s Fading in 3 seconds! <<";

end