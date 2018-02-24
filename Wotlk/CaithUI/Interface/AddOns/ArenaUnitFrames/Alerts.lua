if ( not ArenaUnitFrames ) then
	return
end
local auf = ArenaUnitFrames;
local opponents = auf.opponents;
local pets = auf.pets;
local party = auf.party;
local partyPets = auf.partyPets;
local unitFrameLookup = auf.unitFrameLookup;
local config;

local alertLookup = {};

local voiceDurations = {
	["Partner"] = .5,
	["School_Locked"] = 1,
	["Silenced"] = .7,
	["On"] = .3,
	["Cyclone"] = .7,
	["Blind"] = .6,
	["PRIEST"] = .6,
	["DRUID"] = .6,
	["SHAMAN"] = .6,
	["PALADIN"] = .6,
	["WARRIOR"] = .6,
	["ROGUE"] = .6,
	["DEATHKNIGHT"] = .6,
	["WARLOCK"] = .6,
	["MAGE"] = .6,
	["HUNTER"] = .6,
	["Hex"] = .5,
	["Fear"] = .5,
	["Died"] = .5,
	["Down"] = .5,
	["Low"] = .5,
	["Polymorph"] = .8,
	["Trinket_Used"] = 1,
	["Trinket_Ready"] = 1,
	["Repentance"] = 1,
	["Seduction"] = 1,
	["Sleep"] = .5,
	["Root"] = .5,
	["Sap"] = .5,
	["Partner_CCed"] = 1,
	["Is_Drinking"] = 1,
	["Resurrecting"] = 1,
	["Hungering_Cold"] = 1,
	["Freezing_Trap"] = 1,
	["Casting"] = .5,
	["Wotf_Used"] = 1,
	["Wotf_Ready"] = 1,
	["Wotf"] = 1,
	["Trinket"] = .4,
	["Used"] = .3,
	["Ready"] = .3,
};

local effectAudio = {
	[ARENA_UNIT_FRAMES_SPELLS["Sap"]] = "Sap",
	[ARENA_UNIT_FRAMES_SPELLS["Polymorph"]] = "Polymorph",
	[ARENA_UNIT_FRAMES_SPELLS["Cyclone"]] = "Cyclone",
	[ARENA_UNIT_FRAMES_SPELLS["Freezing Trap Effect"]] = "Freezing_Trap",
	[ARENA_UNIT_FRAMES_SPELLS["Freezing Arrow Effect"]] = "Freezing_Trap",
	[ARENA_UNIT_FRAMES_SPELLS["Psychic Scream"]] = "Fear",
	[ARENA_UNIT_FRAMES_SPELLS["Fear"]] = "Fear",
	[ARENA_UNIT_FRAMES_SPELLS["Howl of Terror"]] = "Fear",
	[ARENA_UNIT_FRAMES_SPELLS["Seduction"]] = "Seduction",
	[ARENA_UNIT_FRAMES_SPELLS["Blind"]] = "Blind",
	[ARENA_UNIT_FRAMES_SPELLS["Intimidating Shout"]] = "Fear",
	[ARENA_UNIT_FRAMES_SPELLS["Entangling Roots"]] = "Root",
	[ARENA_UNIT_FRAMES_SPELLS["Frost Nova"]] = "Root",
	[ARENA_UNIT_FRAMES_SPELLS["Freeze"]] = "Root",
	[ARENA_UNIT_FRAMES_SPELLS["Hungering Cold"]] = "Hungering_Cold",
	[ARENA_UNIT_FRAMES_SPELLS["Hex"]] = "Hex",
	[ARENA_UNIT_FRAMES_SPELLS["Hibernate"]] = "Sleep",
	[ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"]] = "Sleep",
	[ARENA_UNIT_FRAMES_SPELLS["Repentance"]] = "Repentance",
	[ARENA_UNIT_FRAMES_SPELLS["Scare Beast"]] = "Fear",
};

auf.alerts = {
	{
		name = "drinking",
		func = function(dstGUID)
			return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r";
		end,
		soundEffect = "potion.wav",
		speech = "$class Is_Drinking",
	},
	{
		name = "trinketUsed",
		func = function(guid)
			return 0, auf.classColors[opponents[guid].class]..opponents[guid].name.."|r";
		end,
		soundEffect = "portalenter.wav",
		speech = "$class Trinket Used",
	},
	{
		name = "trinketAvailable",
		func = function(dstGUID)
			return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r";
		end,
		soundEffect = "amplifydamage.wav",
		speech = "$class Trinket Ready",
	},
	{
		name = "resurrecting",
		combatEvent = "SPELL_CAST_START",
		objectReaction = "Hostile",
		func = function(srcGUID, dstGUID, spell)
			if ( auf.resurrections[spell] and opponents[srcGUID] ) then
				return 1, auf.classColors[opponents[srcGUID].class]..opponents[srcGUID].name.."|r";
			end
		end,
		soundEffect = "nukesilo.wav",
		speech = "$class Resurrecting",
	},
	{
		name = "lowHealth",
		func = function(guid, hp, maxhp)
			
			if ( not opponents[guid] ) then
				return
			end

			local frame = opponents[guid].frame;

			if ( hp > 0 and frame.ref ) then

				local hppct = 100 / maxhp * hp;
				local threshold;
				if ( config["Alerts"]["lowHealth"]["options"] and config["Alerts"]["lowHealth"]["options"]["lowHPPct"] ) then
					threshold = config["Alerts"]["lowHealth"]["options"]["lowHPPct"];
				else
					threshold = 40;
				end

				-- if health below threshold
				if ( hppct <= threshold ) then

					-- if not already alerted
					if ( not frame.lowHealthAlerted ) then

						-- if not alerted in the last 10 seconds
						if ( not frame.lowHealthAlertedTime or frame.lowHealthAlertedTime < time() - 10 ) then

							frame.lowHealthAlerted = true;
							frame.lowHealthAlertedTime = time();

							return 0, auf.classColors[frame.ref.class]..frame.ref.name.."|r";
						end
					end
				else
					-- if alerted, and unit healed above low health pct + 19, reset alerted
					if (	frame.lowHealthAlerted and 
						hp > (threshold + 19)
					) then
						frame.lowHealthAlerted = nil;
					end
				end
			end
		end,
		soundEffect = "gogogo.wav",
		speech = "$class Low",
		options = {
			{
				name = "lowHPPct",
				type = "slider",
				min = 5,
				max = 60,
				step = 5,
				value = 40,
				text = ARENA_UNIT_FRAMES_LOWHP_SLIDER,
				lowText = "5%",
				highText = "60%",
			},
		},
	},
	{
		name = "opponentDeaths",
		func = function(guid)
			if ( opponents[guid] ) then
				return 0, auf.classColors[opponents[guid].class]..opponents[guid].name.."|r";
			end
		end,
		soundEffect = "outstanding.wav",
		speech = "$class Died",
	},
	{
		name = "partnerCCs",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Hostile",
		buffType = "Debuff",
		func = function(srcGUID, dstGUID, spell)
			if ( opponents[dstGUID] and party[srcGUID] and effectAudio[spell] ) then

				--[[
				if ( config["Alerts"]["partnerCastingCC"].speech or config["Alerts"]["partnerCastingCC"].soundEffect or config["Alerts"]["partnerCastingCC"].displayMsg ) then
					if (	spell == ARENA_UNIT_FRAMES_SPELLS["Polymorph"] or
						spell == ARENA_UNIT_FRAMES_SPELLS["Cyclone"] or
						spell == ARENA_UNIT_FRAMES_SPELLS["Fear"] or
						spell == ARENA_UNIT_FRAMES_SPELLS["Entangling Roots"] or
						spell == ARENA_UNIT_FRAMES_SPELLS["Hex"] or
						spell == ARENA_UNIT_FRAMES_SPELLS["Hibernate"]
					) then
						return
					end
				end
				]]

				return 0, spell, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r";
			end
		end,
		soundEffect = "Miopia1.wav",
		speech = "$spell On $class",
	},
	{
		name = "partnerCastingCC",
		combatEvent = "SPELL_CAST_START",
		objectReaction = "Friendly",
		func = function(srcGUID, dstGUID, spell)
			if ( party[srcGUID] and effectAudio[spell] ) then
				return 0, auf.classColors[party[srcGUID].class]..party[srcGUID].name.."|r", spell;
			end
		end,
		soundEffect = "halfmeteorlaunch.wav",
		speech = "Casting $spell",
	},
	{
		name = "ccsOnPartner",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Friendly",
		buffType = "Debuff",
		func = function(srcGUID, dstGUID, spell)
			if (	party[dstGUID] and effectAudio[spell] and not
				( config["Alerts"]["ccsOnPartner"]["excludes"] and config["Alerts"]["ccsOnPartner"]["excludes"][spell] )
			) then
				return 1, spell, auf.classColors[party[dstGUID].class]..party[dstGUID].name.."|r";
			end
		end,
		soundEffect = "lockdown.wav",
		speech = "$spell On Partner",
		excludes = {
			[ARENA_UNIT_FRAMES_SPELLS["Sap"]] = ARENA_UNIT_FRAMES_SPELLS["Sap"],
			[ARENA_UNIT_FRAMES_SPELLS["Polymorph"]] = ARENA_UNIT_FRAMES_SPELLS["Polymorph"],
			[ARENA_UNIT_FRAMES_SPELLS["Cyclone"]] = ARENA_UNIT_FRAMES_SPELLS["Cyclone"],
			[ARENA_UNIT_FRAMES_SPELLS["Freezing Trap Effect"]] = ARENA_UNIT_FRAMES_SPELLS["Freezing Trap Effect"],
			[ARENA_UNIT_FRAMES_SPELLS["Freezing Arrow Effect"]] = ARENA_UNIT_FRAMES_SPELLS["Freezing Arrow Effect"],
			[ARENA_UNIT_FRAMES_SPELLS["Psychic Scream"]] = ARENA_UNIT_FRAMES_SPELLS["Psychic Scream"],
			[ARENA_UNIT_FRAMES_SPELLS["Fear"]] = ARENA_UNIT_FRAMES_SPELLS["Fear"],
			[ARENA_UNIT_FRAMES_SPELLS["Howl of Terror"]] = ARENA_UNIT_FRAMES_SPELLS["Howl of Terror"],
			[ARENA_UNIT_FRAMES_SPELLS["Seduction"]] = ARENA_UNIT_FRAMES_SPELLS["Seduction"],
			[ARENA_UNIT_FRAMES_SPELLS["Blind"]] = ARENA_UNIT_FRAMES_SPELLS["Blind"],
			[ARENA_UNIT_FRAMES_SPELLS["Intimidating Shout"]] = ARENA_UNIT_FRAMES_SPELLS["Intimidating Shout"],
			[ARENA_UNIT_FRAMES_SPELLS["Entangling Roots"]] = ARENA_UNIT_FRAMES_SPELLS["Entangling Roots"],
			[ARENA_UNIT_FRAMES_SPELLS["Frost Nova"]] = ARENA_UNIT_FRAMES_SPELLS["Frost Nova"],
			[ARENA_UNIT_FRAMES_SPELLS["Hungering Cold"]] = ARENA_UNIT_FRAMES_SPELLS["Hungering Cold"],
			[ARENA_UNIT_FRAMES_SPELLS["Hex"]] = ARENA_UNIT_FRAMES_SPELLS["Hex"],
			[ARENA_UNIT_FRAMES_SPELLS["Hibernate"]] = ARENA_UNIT_FRAMES_SPELLS["Hibernate"],
			[ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"]] = ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"],
			[ARENA_UNIT_FRAMES_SPELLS["Repentance"]] = ARENA_UNIT_FRAMES_SPELLS["Repentance"],
			[ARENA_UNIT_FRAMES_SPELLS["Freeze"]] = ARENA_UNIT_FRAMES_SPELLS["Freeze"],
			[ARENA_UNIT_FRAMES_SPELLS["Scare Beast"]] = ARENA_UNIT_FRAMES_SPELLS["Scare Beast"],
		},
	},
	{
		name = "drExpiration",
		func = function(type, guid)
			if ( not (config["Alerts"]["drExpiration"]["excludes"] and config["Alerts"]["drExpiration"]["excludes"][type]) ) then
				return 0, auf.classColors[opponents[guid].class]..opponents[guid].name.."|r", ARENA_UNIT_FRAMES_DR_LABELS[type];
			end
		end,
		soundEffect = "BEEPMETA.WAV",
		excludes = {
			[ARENA_UNIT_FRAMES_DR_LABELS[1]] = 1,
			[ARENA_UNIT_FRAMES_DR_LABELS[2]] = 2,
			[ARENA_UNIT_FRAMES_DR_LABELS[3]] = 3,
			[ARENA_UNIT_FRAMES_DR_LABELS[4]] = 4,
			[ARENA_UNIT_FRAMES_DR_LABELS[5]] = 5,
			[ARENA_UNIT_FRAMES_DR_LABELS[6]] = 6,
			[ARENA_UNIT_FRAMES_DR_LABELS[7]] = 7,
			[ARENA_UNIT_FRAMES_DR_LABELS[8]] = 8,
			[ARENA_UNIT_FRAMES_DR_LABELS[9]] = 9,
		},
	},
	{
		name = "drExpiration2",
		func = function(type, guid)
			if ( not (config["Alerts"]["drExpiration2"]["excludes"] and config["Alerts"]["drExpiration2"]["excludes"][type]) ) then
				return 0, auf.classColors[opponents[guid].class]..opponents[guid].name.."|r", ARENA_UNIT_FRAMES_DR_LABELS[type];
			end
		end,
		soundEffect = "pop.wav",
		excludes = {
			[ARENA_UNIT_FRAMES_DR_LABELS[1]] = 1,
			[ARENA_UNIT_FRAMES_DR_LABELS[2]] = 2,
			[ARENA_UNIT_FRAMES_DR_LABELS[3]] = 3,
			[ARENA_UNIT_FRAMES_DR_LABELS[4]] = 4,
			[ARENA_UNIT_FRAMES_DR_LABELS[5]] = 5,
			[ARENA_UNIT_FRAMES_DR_LABELS[6]] = 6,
			[ARENA_UNIT_FRAMES_DR_LABELS[7]] = 7,
			[ARENA_UNIT_FRAMES_DR_LABELS[8]] = 8,
			[ARENA_UNIT_FRAMES_DR_LABELS[9]] = 9,
		},
	},
	{
		name = "invulns",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Hostile",
		buffType = "Buff",
		func = function(srcGUID, dstGUID, spell)
			if (	opponents[dstGUID] and auf.invulns[spell] and not
				( config["Alerts"]["invulns"]["excludes"] and config["Alerts"]["invulns"]["excludes"][spell] )
			) then
				return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r", spell;
			end
		end,
		soundEffect = "shield.wav",
		excludes = {
			[ARENA_UNIT_FRAMES_SPELLS["Ice Block"]] = ARENA_UNIT_FRAMES_SPELLS["Ice Block"],
			[ARENA_UNIT_FRAMES_SPELLS["Divine Protection"]] = ARENA_UNIT_FRAMES_SPELLS["Divine Protection"],
			[ARENA_UNIT_FRAMES_SPELLS["Divine Shield"]] = ARENA_UNIT_FRAMES_SPELLS["Divine Shield"],
			[ARENA_UNIT_FRAMES_SPELLS["Hand of Protection"]] = ARENA_UNIT_FRAMES_SPELLS["Hand of Protection"],
			[ARENA_UNIT_FRAMES_SPELLS["Pain Suppression"]] = ARENA_UNIT_FRAMES_SPELLS["Pain Suppression"],
			[ARENA_UNIT_FRAMES_SPELLS["Shield Wall"]] = ARENA_UNIT_FRAMES_SPELLS["Shield Wall"],
		},
	},
	{
		name = "hostileSchoolLocks",
		combatEvent = "SPELL_INTERRUPT",
		objectReaction = "Hostile",
		func = function(srcGUID, dstGUID, spell, duration)
			if ( opponents[dstGUID] ) then

				local caster = party[srcGUID] or partyPets[srcGUID];

				if ( not caster or (config["Alerts"]["hostileSchoolLocks"]["excludes"] and config["Alerts"]["hostileSchoolLocks"]["excludes"][spell]) ) then
					return
				end

				if ( not duration ) then
					duration = auf.schoolLock[caster.class];
				end

				if ( opponents[dstGUID].class == "PALADIN" ) then
					duration = duration *.7;
				end
				
				return 0, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r", tostring(math.ceil(duration));
			end
		end,
		soundEffect = "terranerror1.wav",
		speech = "$class School_Locked",
		excludes = {
			[ARENA_UNIT_FRAMES_SPELLS["Kick"]] = ARENA_UNIT_FRAMES_SPELLS["Kick"],
			[ARENA_UNIT_FRAMES_SPELLS["Counterspell"]] = ARENA_UNIT_FRAMES_SPELLS["Counterspell"],
			[ARENA_UNIT_FRAMES_SPELLS["Spell Lock"]] = ARENA_UNIT_FRAMES_SPELLS["Spell Lock"],
			[ARENA_UNIT_FRAMES_SPELLS["Wind Shear"]] = ARENA_UNIT_FRAMES_SPELLS["Wind Shear"],
			[ARENA_UNIT_FRAMES_SPELLS["Shield Bash"]] = ARENA_UNIT_FRAMES_SPELLS["Shield Bash"],
			[ARENA_UNIT_FRAMES_SPELLS["Pummel"]] = ARENA_UNIT_FRAMES_SPELLS["Pummel"],
			[ARENA_UNIT_FRAMES_SPELLS["Feral Charge - Bear"]] = ARENA_UNIT_FRAMES_SPELLS["Feral Charge - Bear"],
			[ARENA_UNIT_FRAMES_SPELLS["Throwing Specialization"]] = ARENA_UNIT_FRAMES_SPELLS["Throwing Specialization"],
			[ARENA_UNIT_FRAMES_SPELLS["Mind Freeze"]] = ARENA_UNIT_FRAMES_SPELLS["Mind Freeze"],
		},
	},
	{
		name = "hostileSilences",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Hostile",
		buffType = "Debuff",
		func = function(srcGUID, dstGUID, spell)
			if ( opponents[dstGUID] and auf.silences[spell] ) then

				if ( config["Alerts"]["hostileSilences"]["excludes"] and config["Alerts"]["hostileSilences"]["excludes"][spell] ) then
					return
				end

				return  0,
					auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r",
					auf.silences[spell];
			end
		end,
		soundEffect = "terranerror1.wav",
		speech = "$class Silenced",
		excludes = {
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Counterspell"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Counterspell"],
			[ARENA_UNIT_FRAMES_SPELLS["Silence"]] = ARENA_UNIT_FRAMES_SPELLS["Silence"],
			[ARENA_UNIT_FRAMES_SPELLS["Spell Lock"]] = ARENA_UNIT_FRAMES_SPELLS["Spell Lock"],
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Kick"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Kick"],
			[ARENA_UNIT_FRAMES_SPELLS["Garrote - Silence"]] = ARENA_UNIT_FRAMES_SPELLS["Garrote - Silence"],
			[ARENA_UNIT_FRAMES_SPELLS["Strangulate"]] = ARENA_UNIT_FRAMES_SPELLS["Strangulate"],
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Shield of the Templar"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Shield of the Templar"],
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Gag Order"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Gag Order"],
			[ARENA_UNIT_FRAMES_SPELLS["Arcane Torrent"]] = ARENA_UNIT_FRAMES_SPELLS["Arcane Torrent"],
			[ARENA_UNIT_FRAMES_SPELLS["Silencing Shot"]] = ARENA_UNIT_FRAMES_SPELLS["Silencing Shot"],
			[ARENA_UNIT_FRAMES_SPELLS["Nether Shock"]] = ARENA_UNIT_FRAMES_SPELLS["Nether Shock"],
		},
	},
	{
		name = "friendlySilences",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Friendly",
		buffType = "Debuff",
		func = function(srcGUID, dstGUID, spell)
			if ( party[dstGUID] and auf.silences[spell] ) then

				if ( config["Alerts"]["friendlySilences"]["excludes"] and config["Alerts"]["friendlySilences"]["excludes"][spell] ) then
					return
				end

				return  1,
					auf.classColors[party[dstGUID].class]..party[dstGUID].name.."|r",
					auf.silences[spell];
			end

		end,
		soundEffect = "weaken.wav",
		speech = "Partner Silenced",
		excludes = {
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Counterspell"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Counterspell"],
			[ARENA_UNIT_FRAMES_SPELLS["Silence"]] = ARENA_UNIT_FRAMES_SPELLS["Silence"],
			[ARENA_UNIT_FRAMES_SPELLS["Spell Lock"]] = ARENA_UNIT_FRAMES_SPELLS["Spell Lock"],
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Kick"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Kick"],
			[ARENA_UNIT_FRAMES_SPELLS["Garrote - Silence"]] = ARENA_UNIT_FRAMES_SPELLS["Garrote - Silence"],
			[ARENA_UNIT_FRAMES_SPELLS["Strangulate"]] = ARENA_UNIT_FRAMES_SPELLS["Strangulate"],
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Shield of the Templar"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Shield of the Templar"],
			[ARENA_UNIT_FRAMES_SPELLS["Silenced - Gag Order"]] = ARENA_UNIT_FRAMES_SPELLS["Silenced - Gag Order"],
			[ARENA_UNIT_FRAMES_SPELLS["Arcane Torrent"]] = ARENA_UNIT_FRAMES_SPELLS["Arcane Torrent"],
			[ARENA_UNIT_FRAMES_SPELLS["Silencing Shot"]] = ARENA_UNIT_FRAMES_SPELLS["Silencing Shot"],
			[ARENA_UNIT_FRAMES_SPELLS["Nether Shock"]] = ARENA_UNIT_FRAMES_SPELLS["Nether Shock"],
		},
	},
	{
		name = "friendlySchoolLocks",
		combatEvent = "SPELL_INTERRUPT",
		objectReaction = "Friendly",
		func = function(srcGUID, dstGUID, spell, duration)
			if ( party[dstGUID] ) then

				local caster = opponents[srcGUID] or pets[srcGUID];

				if ( not caster or (config["Alerts"]["friendlySchoolLocks"]["excludes"] and config["Alerts"]["friendlySchoolLocks"]["excludes"][spell]) ) then
					return
				end
				if ( not duration ) then
					duration = auf.schoolLock[caster.class];
				end

				if ( party[dstGUID].class == "PALADIN" ) then
					duration = duration * .7;
				end
				duration = math.ceil(duration);

				return 1, auf.classColors[party[dstGUID].class]..party[dstGUID].name.."|r ", duration;
			end
		end,
		soundEffect = "weaken.wav",
		speech = "Partner School_Locked",
		excludes = {
			[ARENA_UNIT_FRAMES_SPELLS["Kick"]] = ARENA_UNIT_FRAMES_SPELLS["Kick"],
			[ARENA_UNIT_FRAMES_SPELLS["Counterspell"]] = ARENA_UNIT_FRAMES_SPELLS["Counterspell"],
			[ARENA_UNIT_FRAMES_SPELLS["Spell Lock"]] = ARENA_UNIT_FRAMES_SPELLS["Spell Lock"],
			[ARENA_UNIT_FRAMES_SPELLS["Wind Shear"]] = ARENA_UNIT_FRAMES_SPELLS["Wind Shear"],
			[ARENA_UNIT_FRAMES_SPELLS["Shield Bash"]] = ARENA_UNIT_FRAMES_SPELLS["Shield Bash"],
			[ARENA_UNIT_FRAMES_SPELLS["Pummel"]] = ARENA_UNIT_FRAMES_SPELLS["Pummel"],
			[ARENA_UNIT_FRAMES_SPELLS["Feral Charge - Bear"]] = ARENA_UNIT_FRAMES_SPELLS["Feral Charge - Bear"],
			[ARENA_UNIT_FRAMES_SPELLS["Throwing Specialization"]] = ARENA_UNIT_FRAMES_SPELLS["Throwing Specialization"],
			[ARENA_UNIT_FRAMES_SPELLS["Mind Freeze"]] = ARENA_UNIT_FRAMES_SPELLS["Mind Freeze"],
		},
	},
	{
		name = "innervateUsed",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Hostile",
		buffType = "Buff",
		func = function(srcGUID, dstGUID, spell)
			if ( spell == ARENA_UNIT_FRAMES_SPELLS["Innervate"] and opponents[dstGUID] ) then
				return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r";
			end
		end,
		soundEffect = "stimpack.wav",
	},
	{
		name = "manaTideDropped",
		combatEvent = "SPELL_CAST_START",
		objectReaction = "Hostile",
		func = function(srcGUID, dstGUID, spell)
			if ( spell == ARENA_UNIT_FRAMES_SPELLS["Mana Tide"] ) then
				return 1;
			end
		end,
		soundEffect = "stimpack.wav",
	},
	{
		name = "gainedBuff",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Hostile",
		buffType = "Buff",
		func = function(srcGUID, dstGUID, spell)

			if ( not opponents[dstGUID] or (config["Alerts"]["gainedBuff"]["excludes"] and config["Alerts"]["gainedBuff"]["excludes"][opponents[dstGUID].class]) ) then
				return
			end

			if ( config["Alerts"]["gainedBuff"]["options"] ) then
				if (	spell == config["Alerts"]["gainedBuff"]["options"]["buff1"] or
					spell == config["Alerts"]["gainedBuff"]["options"]["buff2"] or
					spell == config["Alerts"]["gainedBuff"]["options"]["buff3"]
				) then
					return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r", spell;
				end			
			end
		end,
		soundEffect = "terranunderattack.wav",
		options = {
			{
				name = "buff1",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_BUFF.." 1",
				width = 150,
				value = "",
			},
			{
				name = "buff2",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_BUFF.." 2",
				width = 150,
				value = "",
			},
			{
				name = "buff3",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_BUFF.." 3",
				width = 150,
				value = "",
			},
		},
		excludes = {
			[LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]] = "WARRIOR",
			[LOCALIZED_CLASS_NAMES_MALE["MAGE"]] = "MAGE",
			[LOCALIZED_CLASS_NAMES_MALE["ROGUE"]] = "ROGUE",
			[LOCALIZED_CLASS_NAMES_MALE["DRUID"]] = "DRUID",
			[LOCALIZED_CLASS_NAMES_MALE["HUNTER"]] = "HUNTER",
			[LOCALIZED_CLASS_NAMES_MALE["SHAMAN"]] = "SHAMAN",
			[LOCALIZED_CLASS_NAMES_MALE["PRIEST"]] = "PRIEST",
			[LOCALIZED_CLASS_NAMES_MALE["WARLOCK"]] = "WARLOCK",
			[LOCALIZED_CLASS_NAMES_MALE["PALADIN"]] = "PALADIN",
			[LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]] = "DEATHKNIGHT",
		},
	},
	{
		name = "lostBuff",
		func = function(srcGUID, dstGUID, spell)

			if ( not opponents[dstGUID] or (config["Alerts"]["lostBuff"]["excludes"] and config["Alerts"]["lostBuff"]["excludes"][opponents[dstGUID].class]) ) then
				return
			end

			if ( config["Alerts"]["lostBuff"]["options"] ) then
				if (	spell == config["Alerts"]["lostBuff"]["options"]["buff1"] or
					spell == config["Alerts"]["lostBuff"]["options"]["buff2"] or
					spell == config["Alerts"]["lostBuff"]["options"]["buff3"]
				) then
					return 0, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r", spell;
				end			
			end
		end,
		soundEffect = "valkyrieappear1.wav",
		options = {
			{
				name = "buff1",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 1",
				width = 150,
				value = "",
			},
			{
				name = "buff2",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 2",
				width = 150,
				value = "",
			},
			{
				name = "buff3",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 3",
				width = 150,
				value = "",
			},
		},
		excludes = {
			[LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]] = "WARRIOR",
			[LOCALIZED_CLASS_NAMES_MALE["MAGE"]] = "MAGE",
			[LOCALIZED_CLASS_NAMES_MALE["ROGUE"]] = "ROGUE",
			[LOCALIZED_CLASS_NAMES_MALE["DRUID"]] = "DRUID",
			[LOCALIZED_CLASS_NAMES_MALE["HUNTER"]] = "HUNTER",
			[LOCALIZED_CLASS_NAMES_MALE["SHAMAN"]] = "SHAMAN",
			[LOCALIZED_CLASS_NAMES_MALE["PRIEST"]] = "PRIEST",
			[LOCALIZED_CLASS_NAMES_MALE["WARLOCK"]] = "WARLOCK",
			[LOCALIZED_CLASS_NAMES_MALE["PALADIN"]] = "PALADIN",
			[LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]] = "DEATHKNIGHT",
		},
	},
	{
		name = "gainedDebuff",
		combatEvent = "SPELL_AURA_APPLIED",
		objectReaction = "Hostile",
		buffType = "Debuff",
		func = function(srcGUID, dstGUID, spell)

			if ( not opponents[dstGUID] or (config["Alerts"]["gainedDebuff"]["excludes"] and config["Alerts"]["gainedDebuff"]["excludes"][opponents[dstGUID].class]) ) then
				return
			end

			if ( config["Alerts"]["gainedDebuff"]["options"] ) then
				if (	spell == config["Alerts"]["gainedDebuff"]["options"]["debuff1"] or
					spell == config["Alerts"]["gainedDebuff"]["options"]["debuff2"] or
					spell == config["Alerts"]["gainedDebuff"]["options"]["debuff3"]
				) then
					return 0, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r", spell;
				end			
			end
		end,
		soundEffect = "mind.wav",
		options = {
			{
				name = "debuff1",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 1",
				width = 150,
				value = "",
			},
			{
				name = "debuff2",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 2",
				width = 150,
				value = "",
			},
			{
				name = "debuff3",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 3",
				width = 150,
				value = "",
			},
		},
		excludes = {
			[LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]] = "WARRIOR",
			[LOCALIZED_CLASS_NAMES_MALE["MAGE"]] = "MAGE",
			[LOCALIZED_CLASS_NAMES_MALE["ROGUE"]] = "ROGUE",
			[LOCALIZED_CLASS_NAMES_MALE["DRUID"]] = "DRUID",
			[LOCALIZED_CLASS_NAMES_MALE["HUNTER"]] = "HUNTER",
			[LOCALIZED_CLASS_NAMES_MALE["SHAMAN"]] = "SHAMAN",
			[LOCALIZED_CLASS_NAMES_MALE["PRIEST"]] = "PRIEST",
			[LOCALIZED_CLASS_NAMES_MALE["WARLOCK"]] = "WARLOCK",
			[LOCALIZED_CLASS_NAMES_MALE["PALADIN"]] = "PALADIN",
			[LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]] = "DEATHKNIGHT",
		},
	},
	{
		name = "lostDebuff",
		func = function(srcGUID, dstGUID, spell)

			if ( not opponents[dstGUID] or (config["Alerts"]["lostDebuff"]["excludes"] and config["Alerts"]["lostDebuff"]["excludes"][opponents[dstGUID].class]) ) then
				return
			end

			if ( config["Alerts"]["lostDebuff"]["options"] ) then
				if (	spell == config["Alerts"]["lostDebuff"]["options"]["debuff1"] or
					spell == config["Alerts"]["lostDebuff"]["options"]["debuff2"] or
					spell == config["Alerts"]["lostDebuff"]["options"]["debuff3"]
				) then
					return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r", spell;
				end			
			end
		end,
		soundEffect = "feedback.wav",
		options = {
			{
				name = "debuff1",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 1",
				width = 150,
				value = "",
			},
			{
				name = "debuff2",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 2",
				width = 150,
				value = "",
			},
			{
				name = "debuff3",
				type = "edit box",
				label = ARENA_UNIT_FRAMES_DEBUFF.." 3",
				width = 150,
				value = "",
			},
		},
		excludes = {
			[LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]] = "WARRIOR",
			[LOCALIZED_CLASS_NAMES_MALE["MAGE"]] = "MAGE",
			[LOCALIZED_CLASS_NAMES_MALE["ROGUE"]] = "ROGUE",
			[LOCALIZED_CLASS_NAMES_MALE["DRUID"]] = "DRUID",
			[LOCALIZED_CLASS_NAMES_MALE["HUNTER"]] = "HUNTER",
			[LOCALIZED_CLASS_NAMES_MALE["SHAMAN"]] = "SHAMAN",
			[LOCALIZED_CLASS_NAMES_MALE["PRIEST"]] = "PRIEST",
			[LOCALIZED_CLASS_NAMES_MALE["WARLOCK"]] = "WARLOCK",
			[LOCALIZED_CLASS_NAMES_MALE["PALADIN"]] = "PALADIN",
			[LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]] = "DEATHKNIGHT",
		},
	},
	{
		name = "groundingDropped",
		combatEvent = "SPELL_SUMMON",
		objectReaction = "Hostile",
		func = function(id, spell)
			if ( spell == ARENA_UNIT_FRAMES_SPELLS["Grounding Totem"] ) then
				return 1;
			end
		end,
		soundEffect = "spidermineplanted.wav",
	},
	{
		name = "tremorDropped",
		combatEvent = "SPELL_SUMMON",
		objectReaction = "Hostile",
		func = function(id, spell)
			if ( spell == ARENA_UNIT_FRAMES_SPELLS["Tremor Totem"] ) then
				return 1;
			end
		end,
		soundEffect = "zergplacebuilding.wav",
	},
	{
		name = "groundingDied",
		func = function(dstName)
			if ( dstName == ARENA_UNIT_FRAMES_SPELLS["Grounding Totem"] ) then
				return 1;
			end
		end,
		soundEffect = "ppwrdown.wav",
	},
	{
		name = "tremorDied",
		func = function(dstName)
			if ( dstName == ARENA_UNIT_FRAMES_SPELLS["Tremor Totem"] ) then
				return 1;
			end
		end,
		soundEffect = "ppwrdown.wav",
	},
	{
		name = "wotfUsed",
		func = function(guid)
			return 0, auf.classColors[opponents[guid].class]..opponents[guid].name.."|r";
		end,
		soundEffect = "portalenter.wav",
		speech = "$class Wotf Used",
	},
	{
		name = "wotfAvailable",
		func = function(dstGUID)
			if ( opponents[dstGUID].race == "Scourge" ) then
				return 1, auf.classColors[opponents[dstGUID].class]..opponents[dstGUID].name.."|r";
			end
		end,
		soundEffect = "amplifydamage.wav",
		speech = "$class Wotf Ready",
	},


	--[[
	{
		name = "",
		combatEvent = "",
		objectReaction = "Friendly",
		buffType = "Debuff",
		func = function(srcGUID, dstGUID, spell)

		end,
		soundEffect = ".wav",
		speech = "",
	},
	]]
};

for index, alert in ipairs(auf.alerts) do

	if ( alert.combatEvent ) then
		if ( not alertLookup[alert.combatEvent] ) then
			alertLookup[alert.combatEvent] = {};
		end
		if ( alert.objectReaction ) then
			if ( not alertLookup[alert.combatEvent][alert.objectReaction] ) then
				alertLookup[alert.combatEvent][alert.objectReaction] = {};
			end
			if ( alert.buffType ) then
				if ( not alertLookup[alert.combatEvent][alert.objectReaction][alert.buffType] ) then
					alertLookup[alert.combatEvent][alert.objectReaction][alert.buffType] = {};
				end

				alertLookup[alert.combatEvent][alert.objectReaction][alert.buffType][alert.name] = alert;
			else
				alertLookup[alert.combatEvent][alert.objectReaction][alert.name] = alert;
			end
		else
			alertLookup[alert.combatEvent][alert.name] = alert;
		end
	end

	alertLookup[alert.name] = alert;
end

local VariablesLoadedHook = auf.events.VARIABLES_LOADED;
local function VariablesLoaded()
	config = ArenaUnitFrames_Config;

	if ( not config["Alerts"] ) then
		config["Alerts"] = {};
	end
	config["alerts"] = nil;			-- delete pre-3.0 alert settings

	VariablesLoadedHook();
end
auf.events.VARIABLES_LOADED = VariablesLoaded;

function auf.AlertMsg(msg, type, ...)

	if ( not msg ) then
		return
	end

	-- 1 == red message
	if ( type == 1 ) then
		ArenaUnitFramesAlertFrame:AddMessage( format(msg, ...), 1.0, 0.5, 0.5, 1.0, 0 );
	else
		-- else green message
		ArenaUnitFramesAlertFrame:AddMessage( format(msg, ...), 0.0, 1.0, 0.0, 1.0, 0 );
	end

	return true;
end

function auf.CombatAlert(event, reaction, buffType, ...)

	local t, msgType, arg2, arg3, arg4;

	if ( event ) then

		if ( not alertLookup[event] ) then
			return
		end

		if ( reaction ) then

			if ( not alertLookup[event][reaction] ) then
				return
			end

			if ( buffType ) then
				if ( alertLookup[event][reaction][buffType] ) then
					t = alertLookup[event][reaction][buffType];
				else
					return;
				end
			else
				t = alertLookup[event][reaction];
			end
		else
			t = alertLookup[event];
		end

		for name in pairs(t) do
			auf.Alert(name, ...);
		end
	end

end

-- name == name or index
function auf.Alert(name, ...)
	local alert;

	if ( type(name) == "number" ) then
		alert = auf.alerts[name];
	else
		alert = alertLookup[name];
	end

	if ( not alert ) then
		return
	end

	if ( config["Alerts"][alert.name] ) then

		-- alert logic
		msgType, arg2, arg3, arg4 = alert.func(...);

		if ( msgType ) then

			-- display message
			if ( config["Alerts"][alert.name].displayMsg ) then
				if ( ARENA_UNIT_FRAMES_ALERTS[alert.name] ) then
					auf.AlertMsg( ARENA_UNIT_FRAMES_ALERTS[alert.name].msg, msgType, arg2, arg3, arg4 );
				else
					error("No localization entry for alert: "..alert.name);
				end
			end

			-- speech
			if ( config["Alerts"][alert.name].speech ) then
				
				local srcGUID, dstGUID, spell = ...;
				local class;

				-- try to get unit class from 2nd param (the dstGUID for combat log alerts)
				if ( dstGUID and opponents[dstGUID] ) then
					class = opponents[dstGUID].class;

				-- else try to get class from first param
				elseif ( srcGUID and opponents[srcGUID] ) then
					class = opponents[srcGUID].class;
				end

				-- pass third param as spell name
				auf.Speak(alert.speech, class, spell);
			end

			-- sound effect
			if ( config["Alerts"][alert.name].soundEffect ) then
				if ( config["Alerts"][alert.name].customSound ) then
					PlaySoundFile("Interface\\AddOns\\ArenaUnitFrames\\Sounds\\Custom\\"..config["Alerts"][alert.name].customSound);
				else
					PlaySoundFile("Interface\\AddOns\\ArenaUnitFrames\\Sounds\\"..alert.soundEffect);
				end
			end
		end

	end

end

function auf.Speak(str, class, spell)

	if ( not class ) then
		class = "WARRIOR";
	end
	if ( not spell ) then
		spell = "Polymorph";
	end

	local firstFile, rest = strmatch(str, "^(%S+)%s*(.*)");

	if ( firstFile == "$class" ) then
		firstFile = class;
	end
	if ( firstFile == "$spell" ) then
		firstFile = effectAudio[spell];
--		firstFile = gsub(firstFile, " ", "_");
	end

	if ( not voiceDurations[firstFile] ) then
		return
	end

	PlaySoundFile("Interface\\AddOns\\ArenaUnitFrames\\Sounds\\Voice\\"..firstFile..".wav");

	if ( rest and rest ~= "" ) then
		auf.timer.StartTimer(voiceDurations[firstFile], auf.Speak, rest, class, spell);
	end
end
