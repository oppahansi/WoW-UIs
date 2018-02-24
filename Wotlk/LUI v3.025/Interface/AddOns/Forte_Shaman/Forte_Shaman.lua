-- ForteXorcist v1.959.8 by Xus 13-04-2010

if FW.CLASS == "SHAMAN" then
	local FW = FW;
	local FWL = FW.L;
	local SH = FW:ClassModule("Shaman");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	-- Register ID renames first! Only works for buffs and hidden cooldowns currently
	FW:RegisterCustomName(71220,FWL.ENERGIZED_RELIC);
	
	if ST then
		--
		-- Spells
		-- spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stacks
		-- istype: FW.DEFAULT	FW.SHARED FW.UNIQUE	FW.PET FW.POWERUP FW.CHARM FW.DEBUFF FW.DRAIN FW.HEAL FW.BUFF
		
		-- Elemental Spells
		ST:RegisterSpell(59684,	1,012,1,FW.DEFAULT) -- Flame Shock
			ST:RegisterSpellModGlph(59684, 41531, 1, 6); -- Glyph of Flame Shock
		ST:RegisterSpell(49236,	1,008,0,FW.DEFAULT); -- Frost Shock
		-- Enhancement Spells
		ST:RegisterSpell(31331,	0, 45,0,FW.PET); -- Feral Spirit
		ST:RegisterSpell(17364, 1, 12,0,FW.DEFAULT); -- Stormstrike
		-- Restoration Spells
		ST:RegisterSpell(16237, 1,015,0,FW.BUFF); -- Ancestral Fortitude
		ST:RegisterSpell(60014, 1,600,0,FW.BUFF); -- Earth Shield
		ST:RegisterSpell(52000, 1,012,0,FW.HEAL); -- Earthliving
		ST:RegisterSpell(29203, 1,015,0,FW.BUFF); -- Healing Way
		ST:RegisterSpell(61301, 1,012,0,FW.HEAL); -- Riptide
		
		ST:RegisterCooldown(60043,008); -- Lava Burst
		ST:RegisterCooldown(59159,045); -- Thunderstorm
		ST:RegisterCooldown(49271,006); -- Chain Lightning

		--[[
		for like tremor totem, and the cleansing totem
		magma totem too
		]]
		
		ST:RegisterTickSpeed(58734,2); -- Magma Totem
		--ST:RegisterTickSpeed(58582,2); -- Stoneclaw Totem
		
		--ST:RegisterTickSpeed( 8143,3); -- Tremor Totem
		
		--
		-- Buffs
		-- buffnam
		--
		ST:RegisterBuff(58060); -- Glyph of Renewed Life

		-- Elemental
		ST:RegisterBuff(30165); -- Elemental Devastation
		ST:RegisterBuff(56221); -- Lightning Shield
		ST:RegisterBuff(64701); -- Elemental Mastery

		-- Enhancement
		ST:RegisterBuff(53819); -- Maelstrom Weapon
		ST:RegisterBuff(30824); -- Shamanistic Rage
		ST:RegisterBuff(30811); -- Unleashed Rage

		-- Restoration
		ST:RegisterBuff(53390); -- Tidal Waves
		ST:RegisterBuff(34828); -- Water Shield
		
		-- Relics
		ST:RegisterBuff(71220); -- Energized

		-- Code to track totems
		local function SH_TotemUpdate(event,index)
			-- Fire = 1 Earth = 2 Water = 3 Air = 4
			local _, name, startTime, duration, icon = GetTotemInfo(index);
			local i = ST.ST:find(FW.LAST_TIMER_FLAG+index,6);
			if i then
				if name ~= "" then
					ST.ST:remove(i);
				else
					if ST.ST[i][1]-GetTime()<0.75 then
						FW:Fade(i,2);
					else
						FW:Fade(i,3);
					end
				end
			end
			if name ~= "" then
				name = select(3,strfind(name,"^(.+) [XVI]+$")) or name;
				ST.ST:insert(startTime+duration,0,duration,name,0,FW.LAST_TIMER_FLAG+index,icon,name,2,0,"none",0,FW.PRIOR_NONE,0,1,0,0,ST:GetFilterType(name,FW.LAST_TIMER_FLAG+index),0,startTime+duration,duration,1.0);
			end
		end
		FW:RegisterToEvent("PLAYER_TOTEM_UPDATE", SH_TotemUpdate);
		
		FW:AddTimerFlag("TotemFire");
		FW:AddTimerFlag("TotemEarth");
		FW:AddTimerFlag("TotemWater");
		FW:AddTimerFlag("TotemAir");
		
		FW:RegisterDelayedLoadEvent(function(self)
			for i=1,4,1 do
				SH_TotemUpdate(self,i);
			end
		end);
		
		ST:RegisterCasterBuffs();
		ST:RegisterMeleeBuffs();
		
		FW:SetMainCategory(FWL.SPELL_TIMER,FW.ICON_ST,3,"TIMER","Timer","Timer");
			FW:SetSubCategory(FWL.COLORING_FILTERING,FW.ICON_FILTER,7);
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_FIRE,			"",	"TotemFire",	FW.TimerGroupEnable);	
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_EARTH,			"",	"TotemEarth",	FW.TimerGroupEnable);	
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_WATER,			"",	"TotemWater",	FW.TimerGroupEnable);	
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_AIR,			"",	"TotemAir",		FW.TimerGroupEnable);	
		
		FW.Default.Timer.TotemFireColor = {1.00,0.37,0.00};
		FW.Default.Timer.TotemFireEnable = true;
		FW.Default.Timer.TotemEarthColor = {1.00,0.56,0.00};
		FW.Default.Timer.TotemEarthEnable = true;
		FW.Default.Timer.TotemWaterColor = {0.00,1.00,0.67};
		FW.Default.Timer.TotemWaterEnable = true;
		FW.Default.Timer.TotemAirColor = {0.00,1.00,1.00};
		FW.Default.Timer.TotemAirEnable = true;
	end

	if CD then
		CD:RegisterCasterPowerupCooldowns();
		CD:RegisterMeleePowerupCooldowns();
	end
end