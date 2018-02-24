--[[
	todo:

]]

ArenaUnitFrames_Config = {};
local config = { ["options"] = {} };		-- give it a table in case VARIABLES_LOADED triggers before PLAYER_ENTERING_WORLD
ArenaUnitFrames = {};
local auf = ArenaUnitFrames;

auf.opponents = {};
local opponents = auf.opponents;
auf.pets = {};
local pets = auf.pets;
auf.party = {};
local party = auf.party;
auf.partyPets = {};
local partyPets = auf.partyPets;

auf.events = {};
auf.unitFrameLookup = {};
auf.spec = {};
auf.classColors = {};
auf.testMode = false;
auf.debugMode = false;

-- tables created later
--auf.spellRanges
--auf.buffFilter
--auf.debuffFilter

BINDING_HEADER_AUF = ARENA_UNIT_FRAMES;

setglobal("BINDING_NAME_CLICK ArenaUnitFrame1Button:LeftButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[1]..ARENA_UNIT_FRAMES_UNIT.." 1");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame2Button:LeftButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[1]..ARENA_UNIT_FRAMES_UNIT.." 2");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame3Button:LeftButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[1]..ARENA_UNIT_FRAMES_UNIT.." 3");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame4Button:LeftButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[1]..ARENA_UNIT_FRAMES_UNIT.." 4");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame5Button:LeftButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[1]..ARENA_UNIT_FRAMES_UNIT.." 5");

setglobal("BINDING_NAME_CLICK ArenaUnitFrame1Button:RightButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[2]..ARENA_UNIT_FRAMES_UNIT.." 1");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame2Button:RightButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[2]..ARENA_UNIT_FRAMES_UNIT.." 2");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame3Button:RightButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[2]..ARENA_UNIT_FRAMES_UNIT.." 3");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame4Button:RightButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[2]..ARENA_UNIT_FRAMES_UNIT.." 4");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame5Button:RightButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[2]..ARENA_UNIT_FRAMES_UNIT.." 5");

setglobal("BINDING_NAME_CLICK ArenaUnitFrame1Button:MiddleButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[3]..ARENA_UNIT_FRAMES_UNIT.." 1");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame2Button:MiddleButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[3]..ARENA_UNIT_FRAMES_UNIT.." 2");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame3Button:MiddleButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[3]..ARENA_UNIT_FRAMES_UNIT.." 3");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame4Button:MiddleButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[3]..ARENA_UNIT_FRAMES_UNIT.." 4");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame5Button:MiddleButton", ARENA_UNIT_FRAMES_BUTTON_LABELS[3]..ARENA_UNIT_FRAMES_UNIT.." 5");

setglobal("BINDING_NAME_CLICK ArenaUnitFrame1Button:Button4", ARENA_UNIT_FRAMES_BUTTON_LABELS[4]..ARENA_UNIT_FRAMES_UNIT.." 1");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame2Button:Button4", ARENA_UNIT_FRAMES_BUTTON_LABELS[4]..ARENA_UNIT_FRAMES_UNIT.." 2");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame3Button:Button4", ARENA_UNIT_FRAMES_BUTTON_LABELS[4]..ARENA_UNIT_FRAMES_UNIT.." 3");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame4Button:Button4", ARENA_UNIT_FRAMES_BUTTON_LABELS[4]..ARENA_UNIT_FRAMES_UNIT.." 4");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame5Button:Button4", ARENA_UNIT_FRAMES_BUTTON_LABELS[4]..ARENA_UNIT_FRAMES_UNIT.." 5");

setglobal("BINDING_NAME_CLICK ArenaUnitFrame1Button:Button5", ARENA_UNIT_FRAMES_BUTTON_LABELS[5]..ARENA_UNIT_FRAMES_UNIT.." 1");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame2Button:Button5", ARENA_UNIT_FRAMES_BUTTON_LABELS[5]..ARENA_UNIT_FRAMES_UNIT.." 2");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame3Button:Button5", ARENA_UNIT_FRAMES_BUTTON_LABELS[5]..ARENA_UNIT_FRAMES_UNIT.." 3");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame4Button:Button5", ARENA_UNIT_FRAMES_BUTTON_LABELS[5]..ARENA_UNIT_FRAMES_UNIT.." 4");
setglobal("BINDING_NAME_CLICK ArenaUnitFrame5Button:Button5", ARENA_UNIT_FRAMES_BUTTON_LABELS[5]..ARENA_UNIT_FRAMES_UNIT.." 5");

auf.schoolLock = {
	["WARRIOR"] = 4,
	["MAGE"] = 8,
	["ROGUE"] = 5,
	["DRUID"] = 4,
	["HUNTER"] = 0,
	["SHAMAN"] = 2,
	["PRIEST"] = 0,
	["WARLOCK"] = 6,
	["PALADIN"] = 0,
	["DEATHKNIGHT"] = 4,
	["pet"] = 6;
};

-- CC effects
auf.effect = {
	[ARENA_UNIT_FRAMES_SPELLS["Sap"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Polymorph"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Cyclone"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Freezing Trap Effect"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Freezing Arrow Effect"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Psychic Scream"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Fear"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Howl of Terror"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Seduction"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Blind"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Scatter Shot"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Death Coil"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Intimidating Shout"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Entangling Roots"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Frost Nova"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Hungering Cold"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Hex"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Hibernate"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Repentance"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Scare Beast"]] = true,
};

auf.invulns = {
	[ARENA_UNIT_FRAMES_SPELLS["Ice Block"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Divine Protection"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Divine Shield"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Hand of Protection"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Pain Suppression"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Shield Wall"]] = true,
};

-- silences and their durations
auf.silences = {
	[ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Counterspell"]] = 4,
	[ARENA_UNIT_FRAMES_SPELLS["Silence"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Spell Lock"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Silenced - Improved Kick"]] = 2,
	[ARENA_UNIT_FRAMES_SPELLS["Garrote - Silence"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Strangulate"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Silenced - Shield of the Templar"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Silenced - Gag Order"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Arcane Torrent"]] = 2,
	[ARENA_UNIT_FRAMES_SPELLS["Silencing Shot"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Nether Shock"]] = 2,
};

-- school lock interrupts and their durations
auf.interrupts = {
	[ARENA_UNIT_FRAMES_SPELLS["Kick"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Counterspell"]] = 8,
	[ARENA_UNIT_FRAMES_SPELLS["Spell Lock"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Wind Shear"]] = 2,
	[ARENA_UNIT_FRAMES_SPELLS["Shield Bash"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Pummel"]] = 4,
	[ARENA_UNIT_FRAMES_SPELLS["Feral Charge - Bear"]] = 4,
	[ARENA_UNIT_FRAMES_SPELLS["Throwing Specialization"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Mind Freeze"]] = 4,
};

auf.resurrections = {
	[ARENA_UNIT_FRAMES_SPELLS["Resurrection"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Revive"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Revive Pet"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Redemption"]] = true,
	[ARENA_UNIT_FRAMES_SPELLS["Ancestral Spirit"]] = true,
};

-- using GetSpellInfo() to get spell names and icon textures.  screw translating
local rangeSpells = {
	["WARRIOR"] = {
		1715,	-- hamstring rank 1
		5246,	-- intimidating shout
		20252,	-- intercept rank 1
		2764,	-- throw
	},
	["MAGE"] = {
		2136,	-- fire blast rank 1
		2139,	-- counterspell
		116,	-- frostbolt rank 1
	},
	["ROGUE"] = {
		1752,	-- sinister strike rank 1
		2094,	-- blind
		2764,	-- throw
	},
	["DRUID"] = {
		33786,	-- cyclone
		8921,	-- moonfire rank 1
	},
	["HUNTER"] = {
		2974,	-- wing clip rank 1
		19503,	-- scatter shot
		75,	-- shoot
--		1130,	-- hunter's mark rank 1
	},
	["SHAMAN"] = {
		8042,	-- earth shock rank 1
		403,	-- lightning bolt rank 1
	},
	["PRIEST"] = {
		605,	-- mind control rank 1
		589,	-- shadow word: pain rank 1
	},
	["WARLOCK"] = {
		5782,	-- fear rank 1
		980,	-- curse of agony rank 1
	},
	["PALADIN"] = {
		14517,	-- crusader strike
		853,	-- hammer of justice rank 1
		20066,	-- repentance
		24275,	-- hammer of wrath rank 1
	},
	["DEATHKNIGHT"] = {
		49020,	-- obliterate rank 1
		45524,	-- chains of ice
		49576,	-- death grip
	},
};

ARENA_UNIT_FRAMES_DR_LABELS = {
	[1] = ARENA_UNIT_FRAMES_SPELLS["Fear"].."/"..ARENA_UNIT_FRAMES_SPELLS["Blind"],
	[2] = ARENA_UNIT_FRAMES_SPELLS["Cyclone"],
	[3] = ARENA_UNIT_FRAMES_SPELLS["Polymorph"],
	[4] = ARENA_UNIT_FRAMES_ROOT,
	[5] = ARENA_UNIT_FRAMES_SPELLS["Sleep"],
	[6] = STUN,
	[7] = ARENA_UNIT_FRAMES_SPELLS["Cheap Shot"],
	[8] = ARENA_UNIT_FRAMES_SPELLS["Silence"],
	[9] = ARENA_UNIT_FRAMES_SPELLS["Disarm"],
};

local dimiTypes = {
	[1] = "Interface\\Icons\\Spell_Shadow_Possession.blp",	-- fear/blind
	[2] = "Interface\\Icons\\Spell_Nature_EarthBind.blp",	-- cyclone
	[3] = "Interface\\Icons\\Spell_Nature_Polymorph.blp",	-- polymorph/sap/gouge
	[4] = "Interface\\Icons\\Spell_Nature_StrangleVines",	-- root
	[5] = "Interface\\Icons\\Spell_Nature_Sleep",		-- sleep/freeze
	[6] = "Interface\\Icons\\Ability_Rogue_KidneyShot",	-- stuns
	[7] = "Interface\\Icons\\Ability_CheapShot",		-- cs/pounce stuns
	[8] = "Interface\\Icons\\Spell_Shadow_ImpPhaseShift",	-- silence
	[9] = "Interface\\Icons\\Ability_Warrior_Disarm",	-- disarm
};
local numDimiTypes = #dimiTypes;

local dimiEffects = {
	[ARENA_UNIT_FRAMES_SPELLS["Fear"]] = 1,
	[ARENA_UNIT_FRAMES_SPELLS["Psychic Scream"]] = 1,
	[ARENA_UNIT_FRAMES_SPELLS["Howl of Terror"]] = 1,
	[ARENA_UNIT_FRAMES_SPELLS["Seduction"]] = 1,
	[ARENA_UNIT_FRAMES_SPELLS["Intimidating Shout"]] = 1,
	[ARENA_UNIT_FRAMES_SPELLS["Blind"]] = 1,
	[ARENA_UNIT_FRAMES_SPELLS["Scare Beast"]] = 1,

	[ARENA_UNIT_FRAMES_SPELLS["Cyclone"]] = 2,

	[ARENA_UNIT_FRAMES_SPELLS["Polymorph"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Sap"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Gouge"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Hex"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Hungering Cold"]] = 3,
	[ARENA_UNIT_FRAMES_SPELLS["Repentance"]] = 3,

	[ARENA_UNIT_FRAMES_SPELLS["Entangling Roots"]] = 4,
	[ARENA_UNIT_FRAMES_SPELLS["Frost Nova"]] = 4,
	[ARENA_UNIT_FRAMES_SPELLS["Freeze"]] = 4,

	[ARENA_UNIT_FRAMES_SPELLS["Hibernate"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Freezing Trap Effect"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Freezing Arrow Effect"]] = 5,
	[ARENA_UNIT_FRAMES_SPELLS["Banish"]] = 5,

	[ARENA_UNIT_FRAMES_SPELLS["Kidney Shot"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Bash"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Maim"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Hammer of Justice"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Shadowfury"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Concussion Blow"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Charge Stun"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Intercept"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["War Stomp"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Gnaw"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Shockwave"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Deep Freeze"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Ravage"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Sonic Blast"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Demon Charge"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Glyph of Death Grip"]] = 6,
	[ARENA_UNIT_FRAMES_SPELLS["Impact"]] = 6,

	[ARENA_UNIT_FRAMES_SPELLS["Cheap Shot"]] = 7,
	[ARENA_UNIT_FRAMES_SPELLS["Pounce"]] = 7,

	[ARENA_UNIT_FRAMES_SPELLS["Disarm"]] = 9,
	[ARENA_UNIT_FRAMES_SPELLS["Dismantle"]] = 9,
	[ARENA_UNIT_FRAMES_SPELLS["Chimera Shot - Scorpid"]] = 9,
	[ARENA_UNIT_FRAMES_SPELLS["Snatch"]] = 9,
	[ARENA_UNIT_FRAMES_SPELLS["Psychic Horror"]] = 9,
};
for k in pairs(auf.silences) do
	dimiEffects[k] = 8;
end

auf.specLookup = {
	[ARENA_UNIT_FRAMES_SPELLS["Earth Shield"]] = {
		class = "SHAMAN",
		spec = ARENA_UNIT_FRAMES_SPEC["Restoration"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Leader of the Pack"]] = {
		class = "DRUID",
		spec = ARENA_UNIT_FRAMES_SPEC["Feral"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Moonkin Aura"]] = {
		class = "DRUID",
		spec = ARENA_UNIT_FRAMES_SPEC["Balance"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Soul Link"]] = {
		class = "WARLOCK",
		spec = ARENA_UNIT_FRAMES_SPEC["SL"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Shadowform"]] = {
		class = "PRIEST",
		spec = ARENA_UNIT_FRAMES_SPEC["Shadow"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Trueshot Aura"]] = {
		class = "HUNTER",
		spec = ARENA_UNIT_FRAMES_SPEC["Marksmanship"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Ice Barrier"]] = {
		class = "MAGE",
		spec = ARENA_UNIT_FRAMES_SPEC["Frost"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Combustion"]] = {
		class = "MAGE",
		spec = ARENA_UNIT_FRAMES_SPEC["Fire"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Tree of Life"]] = {
		class = "DRUID",
		spec = ARENA_UNIT_FRAMES_SPEC["Restoration"],
	},
	[ARENA_UNIT_FRAMES_SPELLS["Bone Shield"]] = {
		class = "DEATHKNIGHT",
		spec = ARENA_UNIT_FRAMES_SPEC["Unholy"],
	},
};

local updateTime = 0;
local me;
local YOU = "*"..YOU.."*";
local setStealthClassButtons = false;
local highestRankWyvernSting = 49012;

local _G = getfenv(0);
local bit_bor = _G.bit.bor;
local bit_band = _G.bit.band;
local strfind = _G.string.find;
local strmatch = _G.strmatch;

local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE;
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY;
local COMBATLOG_OBJECT_AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE;
local AURA_TYPE_DEBUFF = "DEBUFF";
local AURA_TYPE_BUFF = "BUFF";

function auf.CombatLog(_, _, _, event, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)

	if ( event == "SPELL_AURA_APPLIED" ) then

		local spell = select(2, ...);
		local type = select(4, ...);

		-- hostile unit get a buff or debuff?
		if ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			if ( type == AURA_TYPE_DEBUFF ) then
				
				-- so wyvern sting dot does not trigger alerts
				if ( spell == ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"] ) then
					local spellId = ...;
					if ( spellId ~= highestRankWyvernSting ) then
						return
					end
				end

				auf.CombatAlert(event, "Hostile", "Debuff", srcGUID, dstGUID, spell);

			elseif ( type == AURA_TYPE_BUFF ) then

				auf.CombatAlert(event, "Hostile", "Buff", srcGUID, dstGUID, spell);
			end


		-- friendly unit get a buff or debuff?
		elseif ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 and bit_band(dstFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0 ) then

			if ( type == AURA_TYPE_DEBUFF ) then

				-- so wyvern sting dot does not trigger alerts
				if ( spell == ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"] ) then
					local spellId = ...;
					if ( spellId ~= highestRankWyvernSting ) then
						return
					end
				end

				auf.CombatAlert(event, "Friendly", "Debuff", srcGUID, dstGUID, spell);

			elseif ( type == AURA_TYPE_BUFF ) then

				auf.CombatAlert(event, "Friendly", "Buff", srcGUID, dstGUID, spell);
			end
		end

	elseif ( event == "SPELL_CAST_START" ) then

		local spell = select(2, ...);

		-- hostile unit casting?
		if ( bit_band(srcFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			auf.CombatAlert(event, "Hostile", nil, srcGUID, dstGUID, spell);

		-- party member (excluding me) casting?
		elseif ( bit_band(srcFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 and (bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0 or auf.testMode) ) then

			auf.CombatAlert(event, "Friendly", nil, srcGUID, dstGUID, spell);
		end

	elseif ( event == "SPELL_CAST_SUCCESS" ) then

		local spell = select(2, ...);
		if ( opponents[srcGUID] ) then

			if ( spell == ARENA_UNIT_FRAMES_SPELLS["PvP Trinket"] ) then

				opponents[srcGUID].trinket = GetTime() + 120;
				auf.Alert("trinketUsed", srcGUID);

				-- trinket cools down wotf for 45 seconds
				if ( opponents[srcGUID].race == "Scourge" ) then

					if ( not opponents[srcGUID].wotf or opponents[srcGUID].wotf < (GetTime() + 45) ) then
						opponents[srcGUID].wotf = GetTime() + 45;
					end
				end

				if ( config["options"]["showTrinket"] ) then
					_G[opponents[srcGUID].frame:GetName().."Trinket"]:Show();
					CooldownFrame_SetTimer( _G[opponents[srcGUID].frame:GetName().."TrinketCooldown"], GetTime(), 120, 1 );
				end

			elseif ( spell == ARENA_UNIT_FRAMES_SPELLS["Will of the Forsaken"] ) then

				opponents[srcGUID].wotf = GetTime() + 120;
				auf.Alert("wotfUsed", srcGUID);

				-- wotf cools down trinket for 45 seconds
				if ( not opponents[srcGUID].trinket or opponents[srcGUID].trinket < (GetTime() + 45) ) then
					
					opponents[srcGUID].trinket = GetTime() + 45;

					if ( config["options"]["showTrinket"] ) then
						_G[opponents[srcGUID].frame:GetName().."Trinket"]:Show();
						CooldownFrame_SetTimer( _G[opponents[srcGUID].frame:GetName().."TrinketCooldown"], GetTime()-75, 120, 1 );
					end
				end

			end
		end

	elseif ( event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_DISPELLED" ) then
--[[
	elseif (	event == "SPELL_AURA_REMOVED"
			or event == "SPELL_AURA_DISPELLED"
			or event == "SPELL_PERIODIC_AURA_REMOVED"
			or event == "SPELL_AURA_REMOVED_DOSE"
			or event == "SPELL_PERIODIC_AURA_REMOVED_DOSE"
	) then
]]

		-- hostile unit?
		if ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			local spell = select(2, ...);
			local type = select(4, ...);

			if ( type == AURA_TYPE_DEBUFF ) then

				-- opponent's CC removed?
				if ( opponents[dstGUID] ) then

					-- track wyvern sting fades so we can ignore dot
					if ( spell == ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"] ) then
						opponents[dstGUID].frame.lastWyvern = GetTime() + 3;
					end

					-- diminishing returns
					if ( config["options"]["drMonitor"] and dimiEffects[spell] ) then

						if ( spell ~= ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"] or not opponents[dstGUID].frame.lastWyvern or opponents[dstGUID].frame.lastWyvern < GetTime() ) then
							auf.NewDimi(dstGUID, spell);
						end
					end
				end

				auf.Alert("lostDebuff", srcGUID, dstGUID, spell);
				auf.CombatAlert(event, "Hostile", "Debuff", srcGUID, dstGUID, spell);

			elseif ( type == AURA_TYPE_BUFF ) then

				auf.Alert("lostBuff", srcGUID, dstGUID, spell);
			end
		end


	elseif ( event == "SPELL_INTERRUPT" ) then

		local spell = select(2, ...);
		local duration;

		if ( auf.interrupts[spell] ) then
			duration = auf.interrupts[spell];
		end

		-- hostile unit interrupted
		if ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			auf.CombatAlert(event, "Hostile", nil, srcGUID, dstGUID, spell, duration);


		-- friendly interrupted
		elseif ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 and bit_band(dstFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0 ) then

			auf.CombatAlert(event, "Friendly", nil, srcGUID, dstGUID, spell, duration);
		end

	elseif ( event == "SPELL_SUMMON" ) then

		-- opponent summon something?
		if ( bit_band(srcFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			local id, spell = ...;

			auf.CombatAlert(event, "Hostile", nil, id, spell);
		end

	elseif ( event == "UNIT_DIED" ) then

		-- hostile unit died?
		if ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			auf.CombatAlert(event, "Hostile", nil, dstGUID);

			-- needed for sacrificed or time limited pets, or possibly missed party kills
			if ( opponents[dstGUID] ) then
				auf.SetOpponentDead(opponents[dstGUID].frame);
			end
			if ( pets[dstGUID] ) then
				if ( auf.debugMode ) then
					DEFAULT_CHAT_FRAME:AddMessage("--- UNIT_DIED: "..pets[dstGUID].unit, 0, 1, 1);
				end
				auf.SetOpponentDead(pets[dstGUID].frame);
			end

			auf.Alert("groundingDied", dstName);
			auf.Alert("tremorDied", dstName);
		end

	elseif ( event == "PARTY_KILL" ) then

--		if ( opponents[dstGUID] and opponents[dstGUID].class ~= "HUNTER" ) then
		if ( opponents[dstGUID] ) then
			auf.SetOpponentDead(opponents[dstGUID].frame);
			auf.Alert("opponentDeaths", dstGUID);
		end
		if ( pets[dstGUID] ) then
			if ( auf.debugMode ) then
				DEFAULT_CHAT_FRAME:AddMessage("--- PARTY_KILL: "..pets[dstGUID].unit, 0, 1, 1);
			end
			auf.SetOpponentDead(pets[dstGUID].frame);
		end

		-- totems killed?
		if ( bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 ) then

			auf.Alert("groundingDied", dstName);
			auf.Alert("tremorDied", dstName);
		end

	elseif ( event == "SPELL_INSTAKILL" ) then
		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("--- SPELL_INSTAKILL: srcName: "..srcName.."; dstName: "..dstName, 0, 1, 1);
		end
	end
end

function auf.events:UNIT_HEALTH(unit)

	local maxhp, hp = UnitHealthMax(unit), UnitHealth(unit);
	local frameName = self:GetName();

	auf.Alert("lowHealth", self.guid, hp, maxhp);

	_G[frameName.."HealthBar"]:SetMinMaxValues(0, maxhp);
	_G[frameName.."HealthBar"]:SetValue(hp);

	if ( (hp <= 0) or UnitIsDeadOrGhost(unit) ) then
		auf.SetOpponentDead(self);
	else
		_G[frameName.."DeadText"]:Hide();

		if ( self.mouseover ) then
			auf.Button_OnEnter(self);
		end
	end
end

function auf.SetOpponentDead(frame)
	local frameName = frame:GetName();

	-- blank out mage and priest pets that die/poof
	if ( frame.pet and (frame.ref.parentClass == "PRIEST" or frame.ref.parentClass == "MAGE") ) then
		pets[frame.guid] = nil;
		auf.CleanupFrame(frame);
		return
	end

	-- if pet owner dies, then blank out pet frame
	if ( not frame.pet ) then
		local petFrame = _G["ArenaUnitFramePet"..frame:GetID()];

		if ( petFrame.guid ) then
			pets[petFrame.guid] = nil;
			auf.CleanupFrame(petFrame);
		end
	end

	_G[frameName.."Name"]:SetAlpha(0.5);
	_G[frameName.."HealthBar"]:SetValue(0);
	_G[frameName.."DeadText"]:Show();
	_G[frameName.."ManaBar"]:SetValue(0);
	auf.UpdateFramePortrait(frame.unit);

	if ( not frame.pet ) then
		_G[frameName.."ToT"]:SetText("");
		for i = 1, numDimiTypes do
			_G[frameName.."Dimi"..i]:Hide();
		end
		opponents[frame.guid].dimi = {};
		for i = 1, 6 do
			_G[frameName.."Buff"..i]:Hide();
			_G[frameName.."Debuff"..i]:Hide();
		end
	end

	--auf.DisableUnitFrame(frame);
end

function auf.events:UNIT_MANA(unit)
	local maxMana, mana = UnitManaMax(unit), UnitMana(unit);
	local bar = _G[self:GetName().."ManaBar"];

	bar:SetMinMaxValues(0, maxMana);
	bar:SetValue(mana);
end
auf.events.UNIT_RAGE = auf.events.UNIT_MANA;
auf.events.UNIT_ENERGY = auf.events.UNIT_MANA;
auf.events.UNIT_FOCUS = auf.events.UNIT_MANA;
auf.events.UNIT_RUNIC_POWER = auf.events.UNIT_MANA;

function auf.events:UNIT_DISPLAYPOWER(unit)
	local type = UnitPowerType(unit);

	_G[self:GetName().."ManaBar"]:SetStatusBarColor(PowerBarColor[type].r, PowerBarColor[type].g, PowerBarColor[type].b);
	_G[self:GetName().."ManaBarBG"]:SetVertexColor(PowerBarColor[type].r, PowerBarColor[type].g, PowerBarColor[type].b, 0.2);

	auf.events.UNIT_MANA(self, unit);
end

function auf.events:UNIT_TARGET(unit)

	local path = unit.."target";
	local target = UnitName(path);

	if ( self == ArenaUnitMasterFrame ) then
		local memberNum;

		-- ugly but faster
		if ( unit == "party1" ) then
			memberNum = 1;
		elseif ( unit == "party2" ) then
			memberNum = 2;
		elseif ( unit == "party3" ) then
			memberNum = 3;
		elseif ( unit == "party4" ) then
			memberNum = 4;
		end

		if ( not memberNum ) then
			return
		end

		local targetGUID = UnitGUID(path);

		for guid, player in pairs(opponents) do
			if ( targetGUID == guid ) then
				_G[player.frame:GetName().."AssistButton"..memberNum]:SetAlpha(1);
			else
				_G[player.frame:GetName().."AssistButton"..memberNum]:SetAlpha(0);
			end
		end

	elseif ( auf.unitFrameLookup[unit] ) then

		-- handle unit frame target switches

		local label = _G[self:GetName().."ToT"];

		if ( target == me ) then
			label:SetText(YOU);
		else
			label:SetText(target);
		end
		
		if ( target ) then
			if ( UnitIsEnemy(path, "player") ) then
				label:SetTextColor(1, .5, .5);
			elseif ( UnitIsFriend("player", path) ) then
				label:SetTextColor(.5, 1, .5);
			else
				label:SetTextColor(1, 1, 0);
			end
		end
	end
end

function auf.events:PLAYER_TARGET_CHANGED()
	auf.SetHighlight();

	if ( auf.testMode ) then
		auf.events.UNIT_NAME_UPDATE(ArenaUnitFrame2, "target");
	end
end

function auf.events:PLAYER_FOCUS_CHANGED()
	auf.SetHighlight();
end

function auf.events:PLAYER_REGEN_ENABLED()
	if ( setStealthClassButtons ) then
		local frame;

		for i = 1, 5 do
			frame = _G["ArenaUnitFrame"..i];
			if ( frame.ref and frame.ref.class ) then
				auf.SetButtonClickFunctionality(frame);
			end
		end
		setStealthClassButtons = false;
	end
end

-- code here needs to be run after everybody joins but before combat
-- "The Arena battle has begun!" == system neutral
function auf.events:CHAT_MSG_BG_SYSTEM_NEUTRAL()

	-- empty the party table
	while (next(party)) do
		party[next(party)] = nil;
	end
	while (next(partyPets)) do
		partyPets[next(partyPets)] = nil;
	end

	-- put group member info into a table to look them up by GUID
	local guid, unit, class;
	for i = 1, 4 do
		unit = "party"..i;
		guid = UnitGUID(unit);
		if ( guid ) then
			_, class = UnitClass(unit);
			party[guid] = { class = class, name = UnitName(unit) };
		end

		unit = "partypet"..i;
		guid = UnitGUID(unit);
		if ( guid ) then
			partyPets[guid] = { class = "pet", name = UnitName(unit) };
		end
	end
	if ( auf.testMode ) then
		_, class = UnitClass("player");
		party[UnitGUID("player")] = { class = class, name = UnitName("player") };
	end

	-- set assist button icons
	local color, class;
	for i = 1, 5 do
		for j = 1, 4 do
			_, class = UnitClass("party"..j);
			if ( class ) then
				getglobal("ArenaUnitFrame"..i.."AssistButton"..j.."Icon"):SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]));
			end
			getglobal("ArenaUnitFrame"..i.."AssistButton"..j):SetAlpha(0);
		end
	end
end

function auf.events:PLAYER_ENTERING_WORLD()
	local frame;
	local instance, instanceType = IsInInstance();
	setStealthClassButtons = false;

	if ( instance and instanceType == "arena" ) then

		-- we're in the arena
		-- have to get team size the hard way because Blizzard's API functions are so god damn unreliable
		local status, teamSize;
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			status, _, _, _, _, teamSize = GetBattlefieldStatus(i);
			if ( status == "active" and teamSize > 0 ) then
				break;
			end
		end
		if ( not teamSize or teamSize == 0 ) then
			teamSize = 5;
		end
		auf.teamSize = teamSize;

		for i = 1, teamSize do

			auf.EnableUnitFrame(_G["ArenaUnitFrame"..i]);

			if ( config["options"]["showPetFrames"] ) then
				auf.EnableUnitFrame(_G["ArenaUnitFramePet"..i]);
			end
		end
		auf.ArrangeFrames();

		-- get spell ranges
		auf.GetSpellRanges();

		ArenaUnitMasterFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
		ArenaUnitMasterFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");
		ArenaUnitMasterFrame:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
		ArenaUnitMasterFrame:RegisterEvent("UNIT_TARGET");
		ArenaUnitMasterFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		ArenaUnitMasterFrame:RegisterEvent("UNIT_PET");

		ArenaUnitMasterFrameLogListener:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

		ArenaUnitMasterFrame:Show();

	else

		auf.teamSize = 5;
		for i = 1, 5 do
			auf.DisableUnitFrame(_G["ArenaUnitFrame"..i]);
			auf.DisableUnitFrame(_G["ArenaUnitFramePet"..i]);
			_G["ArenaUnitFrame"..i]:Hide();
			_G["ArenaUnitFramePet"..i]:Hide();
		end
		auf.ArrangeFrames();
		auf.Reset();

		if ( auf.testMode ) then
			auf.events:CHAT_MSG_BG_SYSTEM_NEUTRAL();
			auf.GetSpellRanges();

			ArenaUnitFrame1.unit = "player";
			ArenaUnitFramePet1.unit = "pet";
			ArenaUnitFrame2.unit = "target";
			auf.unitFrameLookup["player"] = ArenaUnitFrame1;
			auf.unitFrameLookup["pet"] = ArenaUnitFramePet1;
			auf.unitFrameLookup["target"] = ArenaUnitFrame2;
			auf.EnableUnitFrame(ArenaUnitFrame1);
			auf.EnableUnitFrame(ArenaUnitFrame2);
			ArenaUnitFrame1:Show();
			ArenaUnitFrame2:Show();
			if ( config["options"]["showPetFrames"] ) then
				auf.EnableUnitFrame(ArenaUnitFramePet1);
				ArenaUnitFramePet1:Show();
			end
			auf.events.UNIT_NAME_UPDATE(ArenaUnitFrame1, "player");
			
			ArenaUnitMasterFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
			ArenaUnitMasterFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");
			ArenaUnitMasterFrame:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
			ArenaUnitMasterFrame:RegisterEvent("UNIT_TARGET");
			ArenaUnitMasterFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
			ArenaUnitMasterFrame:RegisterEvent("UNIT_PET");

			ArenaUnitMasterFrameLogListener:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			ArenaUnitMasterFrame:Show();
		else

			ArenaUnitMasterFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
			ArenaUnitMasterFrame:UnregisterEvent("PLAYER_FOCUS_CHANGED");
			ArenaUnitMasterFrame:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
			ArenaUnitMasterFrame:UnregisterEvent("UNIT_TARGET");
			ArenaUnitMasterFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
			ArenaUnitMasterFrame:UnregisterEvent("UNIT_PET");

			ArenaUnitMasterFrameLogListener:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

			ArenaUnitMasterFrame:Hide();
		end
	end
end

function auf.EnableUnitFrame(frame)
	frame:RegisterEvent("UNIT_HEALTH");
	frame:RegisterEvent("UNIT_MANA");
	frame:RegisterEvent("UNIT_RAGE");
	frame:RegisterEvent("UNIT_ENERGY");
	frame:RegisterEvent("UNIT_RUNIC_POWER");
	frame:RegisterEvent("UNIT_FOCUS");
	frame:RegisterEvent("UNIT_NAME_UPDATE");
	frame:RegisterEvent("UNIT_DISPLAYPOWER");

	auf.SetButtonClickFunctionality(frame);

	if ( not frame.pet ) then

		frame:RegisterEvent("UNIT_PET");
		frame:RegisterEvent("UNIT_AURA");
		frame:RegisterEvent("UNIT_AURASTATE");

		auf.SetFrameWidgets(frame);
	end

	frame.enabled = true;
end

function auf.DisableUnitFrame(frame)

	frame:UnregisterEvent("UNIT_HEALTH");
	frame:UnregisterEvent("UNIT_AURA");
	frame:UnregisterEvent("UNIT_AURASTATE");
	frame:UnregisterEvent("UNIT_MANA");
	frame:UnregisterEvent("UNIT_RAGE");
	frame:UnregisterEvent("UNIT_ENERGY");
	frame:UnregisterEvent("UNIT_RUNIC_POWER");
	frame:UnregisterEvent("UNIT_FOCUS");
	frame:UnregisterEvent("UNIT_PET");
	frame:UnregisterEvent("UNIT_NAME_UPDATE");
	frame:UnregisterEvent("UNIT_DISPLAYPOWER");
	frame:UnregisterEvent("UNIT_TARGET");

	if ( not frame.pet ) then
		auf.UnLoadSpellBar(frame);
	end

	frame.enabled = nil;
end

function auf.CleanupFrame(frame)

	local frameName = frame:GetName();

	frame.guid = nil;
	frame.ref = nil;
	_G[frameName.."Portrait"]:SetTexture(nil);
	_G[frameName.."HealthBar"]:Hide();
	_G[frameName.."ManaBar"]:Hide();
	_G[frameName.."DeadText"]:Hide();
	_G[frameName.."RangeIconIcon"]:SetTexture(nil);
	_G[frameName.."Name"]:SetText("");
	_G[frameName.."Countdown"]:Hide();
	_G[frameName.."Cooldown"]:Hide();
	frame.r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r;
	frame.g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.g;
	frame.b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b;

	if ( not frame.pet ) then
		frame.dimi = nil;
		_G[frameName.."ToT"]:SetText("");
		for i = 1, 6 do
			_G[frameName.."Buff"..i]:Hide();
			_G[frameName.."Debuff"..i]:Hide();
		end
		for i = 1, numDimiTypes do
			_G[frameName.."Dimi"..i]:Hide();
		end
		for i = 1, 5 do
			for j = 1, 4 do
				getglobal("ArenaUnitFrame"..i.."AssistButton"..j):SetAlpha(0);
			end
		end
		_G[frameName.."Trinket"]:Hide();
		_G[frameName.."SpellBar"]:Hide();
	end
end

function auf.SetFrameWidgets(frame)

	local frameName = frame:GetName();

	if ( frame.pet ) then
		return
	end

	if ( not config["options"]["showBuffs"] ) then
		for i = 1, 6 do
			_G[frameName.."Buff"..i]:Hide();
		end
	end
	if ( not config["options"]["showDebuffs"] ) then
		for i = 1, 6 do
			_G[frameName.."Debuff"..i]:Hide();
		end
	end

	if ( not config["options"]["showToT"] ) then
		_G[frameName.."ToT"]:Hide();
		frame:UnregisterEvent("UNIT_TARGET");
		for i = 1, 4 do
			button = _G[frameName.."AssistButton"..i]:SetAlpha(0);
		end
	else
		_G[frameName.."ToT"]:Show();
		frame:RegisterEvent("UNIT_TARGET");
	end

	if ( not config["options"]["showCastbar"] ) then
		_G[frameName.."SpellBar"]:Hide();
		auf.UnLoadSpellBar(frame);
	else
		CastingBarFrame_OnLoad( _G[frame:GetName().."SpellBar"], frame.unit, false );
		_G[frameName.."SpellBarIcon"]:Show();
	end
end

function auf.ResizeUnitFrames()

	if ( InCombatLockdown() ) then
		return
	end

	local unitFrameWidth = 320;		-- constants, but keeping them here so everything is in the same place
	local unitFrameHeight = 92;

	local width = 0;

	if ( not config["options"]["showBuffs"] ) then
		width = width + 63;				-- icon width = 30 x 2 icons + spaces
	end
	if ( not config["options"]["showDebuffs"] ) then
		width = width + 63;
	end
	if ( width == 126 ) then
		width = width + 1;
	end

	local height = 0;

	-- can't shrink height if displaying buffs
	if ( width == 127 ) then
		if ( not config["options"]["showToT"] ) then
			height = height + 18;
		end
		if ( not config["options"]["showCastbar"] ) then
			height = height + 24;
		end
	end

	local frame;
	for i = 1, 5 do

		frame = _G["ArenaUnitFrame"..i];

		auf.SetFrameWidgets(frame);

		frame:SetWidth( unitFrameWidth - width );
		_G["ArenaUnitFramePet"..i]:SetWidth( unitFrameWidth - width );
		ArenaUnitMasterFrame:SetWidth( unitFrameWidth - width )
		frame:SetHeight( unitFrameHeight - height );

		-- if frame height < range indicator + dimi icons
		if ( frame:GetHeight() < 61 ) then
			_G["ArenaUnitFrame"..i.."Dimi1"]:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -1, 0);
		else
			_G["ArenaUnitFrame"..i.."Dimi1"]:SetPoint("TOPRIGHT", frame, "TOPLEFT", -1, -25);
		end
	end

	ArenaUnitMasterFrame:SetWidth( unitFrameWidth - width );
end

function auf.SetButtonClickFunctionality(frame)

	local button = _G[frame:GetName().."Button"];
	local class;
	if ( frame.ref and frame.ref.class ) then
		class = frame.ref.class;
	end
	local text, mod;

	button:SetAttribute("unit", frame.unit);

	for i = 1, 5 do
		for modifier in pairs(config["buttons"][i]) do

			text = nil;

			if (	class and config["buttons"][i][modifier][class] and
				config["buttons"][i][modifier][class].action ~= "default"
			) then
				classAction = config["buttons"][i][modifier][class];

			elseif ( config["buttons"][i][modifier]["default"] and
				 config["buttons"][i][modifier]["default"].action ~= "default"
			) then
				classAction = config["buttons"][i][modifier]["default"];
			end

			if ( classAction ) then

				if ( modifier == "none" ) then
					mod = "";
				else
					mod = modifier.."-";
				end

				if ( classAction.action == "target" ) then

					button:SetAttribute(mod.."type"..i, "target");

				elseif ( classAction.action == "focus" ) then

					button:SetAttribute(mod.."type"..i, "focus");

				elseif ( classAction.action == "cast" ) then

					button:SetAttribute(mod.."spell"..i, classAction.spell);
					button:SetAttribute(mod.."type"..i, "spell");

				elseif ( classAction.action == "macro" ) then
					button:SetAttribute(mod.."macrotext"..i, string.gsub(classAction.macro, "%$unit", frame.unit));
					button:SetAttribute(mod.."type"..i, "macro");
				end

			end
		end
	end

end

-- show frames that need to be shown and set anchors
function auf.ArrangeFrames()
	if ( not InCombatLockdown() ) then
		local frame, nextFrame, petFrame;
		for i = 1, 5 do
			frame = _G["ArenaUnitFrame"..i];
			nextFrame = _G["ArenaUnitFrame"..(i + 1)];
			petFrame = _G["ArenaUnitFramePet"..i];

			if ( i <= auf.teamSize ) then
				frame:Show();
			else
				frame:Hide();
			end

			if (	not config["options"]["showPetFrames"] or
				i > auf.teamSize or
				(frame.ref and (frame.ref.class == "WARRIOR" or frame.ref.class == "ROGUE" or frame.ref.class == "PALADIN" or frame.ref.class == "SHAMAN" or frame.ref.class == "DRUID"))
			) then
				if ( nextFrame ) then
					nextFrame:ClearAllPoints();
					nextFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0);
				end
				petFrame:Hide();
				if ( frame.ref and frame.ref.class ) then
					auf.DisableUnitFrame(petFrame);
				end
			else
				if ( nextFrame ) then
					nextFrame:ClearAllPoints();
					nextFrame:SetPoint("TOPLEFT", petFrame, "BOTTOMLEFT", 0, 0);
				end
				petFrame:Show();
				if ( not petFrame.enabled ) then
					auf.EnableUnitFrame(petFrame);
				end
			end
		end
	end
end

function auf.AddOpponent(frame, unit)
	local guid = UnitGUID(unit);

	if ( not guid ) then
		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("-- AddOpponent(): guid == nil", 0, 1, 1);
		end
		return
	end

	local name = UnitName(unit);
	
	if ( not name or name == "" or name == UNKNOWN ) then
		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("-- AddOpponent(): not name, or name is blank, or name == UNKNOWN", 0, 1, 1);
		end
		return
	end
	if ( frame.pet ) then
		auf.UpdatePet(frame, unit);
		return
	end

	if ( not opponents[guid] and (UnitIsPlayer(unit) or auf.testMode) ) then
		
		local _, class = UnitClass(unit);
		local _, race = UnitRace(unit);

		opponents[guid] = {
			unit = unit,
			name = name,
			class = class,
			race = race,
			frame = frame,
			dimi = {},
		};
		frame.guid = guid;
		frame.ref = opponents[guid];

		_G[frame:GetName().."HealthBar"]:Show();
		_G[frame:GetName().."ManaBar"]:Show();
		auf.events.UNIT_HEALTH(frame, unit);
		auf.events.UNIT_MANA(frame, unit);
		auf.events.UNIT_DISPLAYPOWER(frame, unit);
		auf.UpdateFramePortrait(unit);

		_G[frame:GetName().."Name"]:SetText(name);
		_G[frame:GetName().."Name"]:SetAlpha(1);
		auf.CheckSpec(unit);
		auf.ArrangeFrames();

		if ( config["options"]["colorize"] ) then
			frame.r = RAID_CLASS_COLORS[class].r;
			frame.g = RAID_CLASS_COLORS[class].g;
			frame.b = RAID_CLASS_COLORS[class].b;
			auf.SetHighlight();
		end

		if ( not InCombatLockdown() ) then
			auf.SetButtonClickFunctionality(frame);		-- to set class specific functionality
		else
			setStealthClassButtons = true;
		end

		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("++ "..class.." "..name.." added to "..frame:GetName(), 0, 1, 1);
		end

		if ( frame.ref.class == "HUNTER" or frame.ref.class == "WARLOCK" or frame.ref.class == "DEATHKNIGHT" or frame.ref.class == "MAGE" ) then
			local petUnit = "arenapet"..frame:GetID();
			if ( UnitGUID(petUnit) and UnitName(petUnit) ~= UNKNOWN ) then
				auf.UpdatePet(_G["ArenaUnitFramePet"..frame:GetID()], petUnit);
			else
				if ( auf.debugMode ) then
					DEFAULT_CHAT_FRAME:AddMessage("-- pet not found; starting timer to check in 5 seconds", 0, 1, 1);
				end

				auf.timer.StartTimer(5, auf.events.UNIT_PET, frame, unit);
			end
		end
	end
end

function auf.UpdatePet(frame, unit)
	local guid = UnitGUID(unit);

	if ( not guid ) then
		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("-- UpdatePet(): guid == nil", 0, 1, 1);
		end
		return
	end

	local name = UnitName(unit);
	local ownerFrame = _G["ArenaUnitFrame"..frame:GetID()];

	if ( not name or name == "" or name == UNKNOWN or not ownerFrame.guid ) then
		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("-- UpdatePet(): name == nil, or name is blank, or name == UNKNOWN, or no owner guid", 0, 1, 1);
		end
		return
	end

--	if ( not pets[guid] ) then
		
		-- new pet
		pets[guid] = {
			unit = unit,
			name = name,
			class = "pet",
			creatureFamily = UnitCreatureFamily(unit),
			parentClass = opponents[ ownerFrame.guid ].class,
			frame = frame,
		};
		frame.guid = guid;
		frame.ref = pets[guid];

		auf.events.UNIT_HEALTH(frame, unit);
		auf.events.UNIT_MANA(frame, unit);
		auf.events.UNIT_DISPLAYPOWER(frame, unit);
		_G[frame:GetName().."HealthBar"]:Show();
		_G[frame:GetName().."ManaBar"]:Show();

		if ( auf.debugMode ) then
			DEFAULT_CHAT_FRAME:AddMessage("+++ Pet "..name.." ("..(pets[guid].creatureFamily or "unknown")..") added to "..frame:GetName(), 0, 1, 1);
		end
--	end

	_G[frame:GetName().."Name"]:SetText(name);
	auf.events.UNIT_DISPLAYPOWER(frame, unit);
	auf.UpdateFramePortrait(unit);
end

function auf.events:UNIT_PET(unit)

	if ( self == ArenaUnitMasterFrame ) then
		if ( unit:find("$party") ) then
			guid = UnitGUID(unit);
			if ( guid ) then
				partyPet[guid] = { class = "pet", name = UnitName(unit) };
			end
		end
		return
	end

	if ( auf.debugMode ) then
		DEFAULT_CHAT_FRAME:AddMessage("UNIT_PET: "..unit, 0, 1, 1);
	end

	local petFrame = _G["ArenaUnitFramePet"..self:GetID()];
	if ( UnitGUID(petFrame.unit) ) then
		auf.UpdatePet(petFrame, petFrame.unit);
	end
end

function auf.events:UNIT_NAME_UPDATE(unit)

	if ( auf.debugMode ) then
		DEFAULT_CHAT_FRAME:AddMessage("UNIT_NAME_UPDATE: "..unit, 0, 1, 1);
	end

	if ( UnitGUID(unit) ) then
		auf.AddOpponent(self, unit);
	end

end

function auf.events:ARENA_OPPONENT_UPDATE(unit, arg2)

	if ( auf.debugMode ) then
		DEFAULT_CHAT_FRAME:AddMessage("ARENA_OPPONENT_UPDATE: "..arg2.."; "..unit, 0, 1, 1);
	end

	if ( arg2 == "seen" or arg2 == "destroyed") then

		if ( UnitGUID(unit) ) then
			auf.AddOpponent(self, unit);
		end

	elseif ( arg2 == "unseen" ) then
		if ( UnitGUID(unit) ) then
			auf.AddOpponent(self, unit);
		end

	elseif ( arg2 == "cleared" ) then
		auf.CleanupFrame(self);
		auf.CleanupFrame(_G["ArenaUnitFramePet"..self:GetID()]);		-- because ARENA_OPPONENT_UPDATE doesn't work for pet frames apparently
	end

end

function auf.events:VARIABLES_LOADED()

	config = ArenaUnitFrames_Config;
	me = UnitName("Player");

	auf.ResizeUnitFrames();
	ArenaUnitMasterFrame:SetScale(config["options"]["scale"]);
	auf.SetBuffFilter();
end

function auf.GetSpellRanges()
	auf.spellRanges = {};

	local i, id, x;
	local totalSpells = 0;
	local _, class = UnitClass("player");

	for i = 1, 4 do
		_, _, _, x = GetSpellTabInfo(i);
		totalSpells = totalSpells + x;
	end

	local spellName, icon;
	for _, id in ipairs(rangeSpells[class]) do
		spellName, _, icon = GetSpellInfo(id);

		for i = 1, totalSpells do
			if ( spellName == GetSpellName(i, BOOKTYPE_SPELL) ) then
				table.insert(auf.spellRanges, {
					id = i,
					icon = icon,
				} );
				break;
			end
		end
	end
end

function auf.MasterFrame_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("VARIABLES_LOADED");

	-- set trinket cooldown icons
	local icon;
	if ( UnitFactionGroup("player") == "Horde" ) then
		icon = "Interface\\ICONS\\INV_Jewelry_TrinketPVP_02.blp";
	else
		icon = "Interface\\ICONS\\INV_Jewelry_TrinketPVP_01.blp";
	end

	-- set unit frame event handlers
	for i = 1, 5 do
		_G["ArenaUnitFrame"..i]:SetScript("OnEvent", function(self, event, arg1, arg2)
			if ( arg1 == self.unit ) then
				auf.events[event](self, arg1, arg2);
			end
		end);

		_G["ArenaUnitFrame"..i.."TrinketIcon"]:SetTexture(icon);

		_G["ArenaUnitFramePet"..i]:SetScript("OnEvent", function(self, event, arg1, arg2)
			if ( arg1 == self.unit ) then
				auf.events[event](self, arg1, arg2);
			end
		end);
	end

	-- non-unit frame event handler
	self:SetScript("OnEvent", function(self, event, ...)
		auf.events[event](self, ...);
	end);

	-- combat log event gets own frame to make it as efficient as possible
	ArenaUnitMasterFrameLogListener:SetScript("OnEvent", auf.CombatLog);

	-- set class colors
	local class, v, r, g, b;
	for class, v in pairs(RAID_CLASS_COLORS) do

		r = string.format("%x", (v.r * 100) * 2.55);
		if ( #r == 1 ) then
			r = "0"..r;
		end
		g = string.format("%x", (v.g * 100) * 2.55);
		if ( #g == 1 ) then
			g = "0"..g;
		end
		b = string.format("%x", (v.b * 100) * 2.55);
		if ( #b == 1 ) then
			b = "0"..b;
		end

		auf.classColors[class] = "|cff"..r..g..b;
	end
	auf.classColors["pet"] = "|cff888888";

	local caps = string.upper(ARENA_UNIT_FRAMES_SLASHCMD);
	SlashCmdList[caps] = auf.CmdLine;
	SLASH_AUF1 = "/"..ARENA_UNIT_FRAMES_SLASHCMD;
end

function auf.Reset()

	-- clear string indexed tables
	while (next(opponents)) do
		opponents[next(opponents)] = nil;
	end
	while (next(pets)) do
		pets[next(pets)] = nil;
	end
	while (next(auf.spec)) do
		auf.spec[next(auf.spec)] = nil;
	end
end

function auf.UnLoadSpellBar(frame)
	bar = _G[frame:GetName().."SpellBar"];

	bar:UnregisterEvent("UNIT_SPELLCAST_START");
	bar:UnregisterEvent("UNIT_SPELLCAST_STOP");
	bar:UnregisterEvent("UNIT_SPELLCAST_FAILED");
	bar:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	bar:UnregisterEvent("UNIT_SPELLCAST_DELAYED");
	bar:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START");
	bar:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
	bar:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
	bar:UnregisterEvent("PLAYER_ENTERING_WORLD");
end

function auf.CmdLine(args)
	local s;
	local arg = {};
	for s in string.gmatch(args, "%S+") do
		table.insert(arg, s);
	end
	if ( arg[1] ) then
		arg[1] = string.lower(arg[1]);
	end

	if ( arg[1] == "debug" ) then
		if ( not auf.debugMode ) then
			auf.debugMode = true;
			DEFAULT_CHAT_FRAME:AddMessage("debug mode on", 0, 1, 1);
		else
			auf.debugMode = nil;
			DEFAULT_CHAT_FRAME:AddMessage("debug mode off", 0, 1, 1);
		end
	elseif ( arg[1] == "reset" ) then
		if ( arg[2] == "frame" ) then
			ArenaUnitMasterFrame:ClearAllPoints();
			ArenaUnitMasterFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		else
			auf.Reset();
		end
	else
		ArenaUnitMasterFrame:Show();
	end
end

function auf.SetHighlight()
	local targetGUID = UnitGUID("target");
	local focusGUID = UnitGUID("focus");
	local frame;

	for i = 1, 5 do
		frame = _G["ArenaUnitFrame"..i];
		frame:SetBackdropColor( frame.r, frame.g, frame.b, 1 );
--		frame:SetBackdropBorderColor( frame.r, frame.g, frame.b );
		frame:SetBackdropBorderColor( TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b );

		frame = _G["ArenaUnitFramePet"..i];
		frame:SetBackdropColor( frame.r, frame.g, frame.b, 1 );
--		frame:SetBackdropBorderColor( frame.r, frame.g, frame.b );
		frame:SetBackdropBorderColor( TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b );
	end

	local focusColor = config["options"]["focusColor"];
	local targetColor = config["options"]["targetColor"];

	if ( opponents[focusGUID] ) then
		if ( not config["options"]["colorize"] ) then
			opponents[focusGUID].frame:SetBackdropColor( unpack(focusColor) );
		end
		opponents[focusGUID].frame:SetBackdropBorderColor( unpack(focusColor) );
	end
	if ( opponents[targetGUID] ) then
		if ( not config["options"]["colorize"] ) then
			opponents[targetGUID].frame:SetBackdropColor( unpack(targetColor) );
		end
		opponents[targetGUID].frame:SetBackdropBorderColor( unpack(targetColor) );
	end
	if ( pets[focusGUID] ) then
		if ( not config["options"]["colorize"] ) then
			pets[focusGUID].frame:SetBackdropColor( unpack(focusColor) );
		end
		pets[focusGUID].frame:SetBackdropBorderColor( unpack(focusColor) );
	end
	if ( pets[targetGUID] ) then
		if ( not config["options"]["colorize"] ) then
			pets[targetGUID].frame:SetBackdropColor( unpack(targetColor) );
		end
		pets[targetGUID].frame:SetBackdropBorderColor( unpack(targetColor) );
	end
end

function auf.events:UNIT_AURA(unit)
	local frameName = self:GetName();
	local spellName, icon, cooldown, duration, expirationTime, count, show, portraitIcon, portraitDuration, portraitExpire, unitCaster, isStealable, skipWyvern;
	local now = GetTime();

	count = 0;
	for i = 1, MAX_TARGET_DEBUFFS do
		spellName, _, icon, _, _, duration, expirationTime, unitCaster = UnitAura(unit, i, "HARMFUL");

		if ( not spellName ) then
			if ( count <= 6 and config["options"]["showDebuffs"] ) then
				for i = (count + 1), 6 do
					_G[frameName.."Debuff"..i]:Hide();
					_G[frameName.."Debuff"..i.."Cooldown"]:Hide();
				end
			else
				break;
			end
		end

		-- is this debuff CC?
		if ( auf.effect[spellName] ) then

			-- ignore wyvern sting dot
			if ( spellName == ARENA_UNIT_FRAMES_SPELLS["Wyvern Sting"] ) then

				if ( self.lastWyvern and self.lastWyvern > GetTime() ) then
					skipWyvern = true;
				end
			end

			if ( not skipWyvern and (not portraitIcon or expirationTime > portraitExpire) ) then
				portraitIcon = icon;
				portraitExpire = expirationTime;
				portraitDuration = duration;
			end
		end

		-- diminishing returns
		if ( config["options"]["drMonitor"] and dimiEffects[spellName] and not skipWyvern ) then
			auf.NewDimi(self.guid, spellName, expirationTime - now);
		end
		skipWyvern = false;

		if ( config["options"]["showDebuffs"] ) then

			if ( count < 6 ) then
				show = true;

				if ( config["options"]["showMyDebuffsOnly"] and unitCaster ~= "player" ) then
					show = false;
				end

				if ( show and config["lists"]["debuffs"]["which"] == 1 ) then
					-- black list
					if ( auf.debuffFilter[spellName] ) then
						show = false;
					end
				elseif ( show ) then
					-- white list
					if ( not auf.debuffFilter[spellName] ) then
						show = false;
					end
				end

				if ( icon and show ) then
					count = count + 1;
					button = _G[frameName.."Debuff"..count];
					_G[frameName.."Debuff"..count.."Icon"]:SetTexture(icon);

					cooldown = _G[frameName.."Debuff"..count.."Cooldown"];
					if ( duration ) then
						if ( duration > 0 ) then
							cooldown:Show();
							CooldownFrame_SetTimer(cooldown, expirationTime - duration, duration, 1);
						else
							cooldown:Hide();
						end
					else
						cooldown:Hide();
					end

					button:Show();
					button.debuffName = spellName;
				end
			end
		end
	end


	-- Buffs
	count = 0;
	for i = 1, MAX_TARGET_BUFFS do
		spellName, _, icon, _, _, duration, expirationTime, _, isStealable = UnitAura(unit, i, "HELPFUL");

		if ( not spellName ) then
			if ( count <= 6 and config["options"]["showBuffs"] ) then
				for i = (count + 1), 6 do
					_G[frameName.."Buff"..i]:Hide();
				end
			else
				break;
			end
		end

		-- is this buff an invuln?
		if ( auf.invulns[spellName] ) then
			portraitIcon = icon;
			portraitExpire = expirationTime;
			portraitDuration = duration;

		-- drinking?
		elseif ( spellName == ARENA_UNIT_FRAMES_SPELLS["Drink"] ) then
			if ( self.guid and (not opponents[self.guid].drink or opponents[self.guid].drink < GetTime()) ) then

				opponents[self.guid].drink = GetTime() + 5;
				auf.Alert("drinking", self.guid);
			end
		end

		if ( config["options"]["showBuffs"] ) then

			if ( count < 6 ) then
				show = true;

				if ( config["options"]["showStealableOnly"] and not isStealable ) then
					show = false;
				end

				if ( config["lists"]["buffs"]["which"] == 1 ) then
					-- black list
					if ( auf.buffFilter[spellName] ) then
						show = false;
					end
				else
					-- white list
					if ( not auf.buffFilter[spellName] ) then
						show = false;
					end
				end

				if ( icon and show ) then
					count = count + 1;

					button = _G[frameName.."Buff"..count];
					_G[frameName.."Buff"..count.."Icon"]:SetTexture(icon);
					button:Show();
					button.buffName = spellName;

				end
			end
		end
	end

	if ( portraitIcon ) then
		auf.UpdateFramePortrait(unit, portraitIcon);

		self.countdown = portraitExpire;

		local countdown = _G[frameName.."Countdown"];
		if ( config["options"]["countdownPrecision"] ) then
			countdown:SetText(format("%.1f", portraitExpire - now));
		else
			countdown:SetText(math.ceil(portraitExpire - now));
		end
		
		countdown:Show();

		CooldownFrame_SetTimer(
			_G[frameName.."Cooldown"],
			portraitExpire - portraitDuration, 
			portraitDuration, 1
		);

	elseif ( self.tempPortrait ) then
		auf.UpdateFramePortrait(unit);
		self.countdown = 0;
		_G[frameName.."Countdown"]:Hide();
		_G[frameName.."Cooldown"]:Hide();
	end
end
auf.events.UNIT_AURASTATE = auf.events.UNIT_AURA;

function auf.BuffScanNotify(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg, 1, .5, 0);
	auf.AlertMsg(msg);
end

function auf.CheckSpec(unit)

	local numOpponents, spell;
	for i = 1, MAX_TARGET_BUFFS do
		spell = UnitBuff(unit, i);

		if ( auf.specLookup[spell] and not auf.spec[spell] ) then
			auf.BuffScanNotify(	auf.specLookup[spell].spec.." "..
						LOCALIZED_CLASS_NAMES_MALE[auf.specLookup[spell].class]..
						" "..ARENA_UNIT_FRAMES_DETECTED
			);
			auf.spec[spell] = true;
		end
	end

	numOpponents = 0;
	for _ in pairs(opponents) do
		numOpponents = numOpponents + 1;
	end

	if ( numOpponents == 1 ) then

		auf.timer.StartTimer(3, auf.CheckSpecDelay);		-- start timer to check for stealth classes in 3 seconds

	elseif ( numOpponents == auf.teamSize ) then

		-- try to determine spec by looking at opponent mana
		for guid, player in pairs(opponents) do

			if ( player.class == "PALADIN" ) then
				if ( UnitManaMax(player.unit) > 12000 ) then
					auf.BuffScanNotify(	ARENA_UNIT_FRAMES_SPEC["Holy"].." "..
								LOCALIZED_CLASS_NAMES_MALE[player.class]..
								" "..ARENA_UNIT_FRAMES_DETECTED..
								" ("..player.name..")"
					);
				end
			end
		end
	end
end

function auf.CheckSpecDelay()
	if ( InCombatLockdown() ) then
		return
	end

	local numOpponents = 0;
	local isADruid;
	for _, player in pairs(opponents) do
		numOpponents = numOpponents + 1;
		if ( player.class == "DRUID" ) then
			isADruid = true;
		end
	end

	-- if somebody isn't visible
	if ( numOpponents < auf.teamSize ) then

		local spell;
		for guid, player in pairs(opponents) do

			-- check visible player's buffs
			for i = 1, MAX_TARGET_BUFFS do

				spell = UnitBuff(player.unit, i);
				if (	not isADruid
					and spell == ARENA_UNIT_FRAMES_SPELLS["Mark of the Wild"]
					and not auf.spec[ARENA_UNIT_FRAMES_SPELLS["Leader of the Pack"]]
					and not auf.spec[ARENA_UNIT_FRAMES_SPELLS["Moonkin Aura"]]
				) then
					-- druid detected
					auf.BuffScanNotify( LOCALIZED_CLASS_NAMES_MALE["DRUID"].." "..ARENA_UNIT_FRAMES_DETECTED );
					return
				end
			end
		end
	end
end

function auf.UpdateFramePortrait(unit, icon, alpha)

	local frame = auf.unitFrameLookup[unit];
	local portrait = _G[frame:GetName().."Portrait"];

	if ( not frame.ref ) then
		return
	end
	if ( not alpha ) then
		alpha = 1;
	end
	if ( UnitIsDeadOrGhost(unit) ) then
		icon = "Interface\\ICONS\\Ability_Creature_Cursed_02.blp";
		alpha = 0.5;
	end
	if ( icon ) then
		portrait:SetTexture(icon);
		portrait:SetTexCoord(0, 1, 0, 1);
		frame.tempPortrait = true;
		portrait:SetAlpha(alpha);
		return
	end

	if ( not frame.pet ) then
		-- set portrait to class icon

		portrait:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes.blp");
		portrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[ frame.ref.class ]));
	else
		-- set pet portrait
		if ( frame.ref.parentClass == "DEATHKNIGHT" ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_DeathKnight_ArmyOfTheDead.blp");

		elseif ( frame.ref.parentClass == "MAGE" ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Frost_SummonWaterElemental_2.blp");

		elseif ( frame.ref.parentClass == "PRIEST" ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Shadow_Shadowfiend.blp");

		elseif ( frame.ref.creatureFamily == ARENA_UNIT_FRAMES_CREATURE["Voidwalker"] ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Shadow_SummonVoidWalker.blp");

		elseif ( frame.ref.creatureFamily == ARENA_UNIT_FRAMES_CREATURE["Felhunter"] ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Shadow_SummonFelHunter.blp");

		elseif ( frame.ref.creatureFamily == ARENA_UNIT_FRAMES_CREATURE["Felguard"] ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Shadow_SummonFelGuard.blp");

		elseif ( frame.ref.creatureFamily == ARENA_UNIT_FRAMES_CREATURE["Imp"] ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Shadow_SummonImp.blp");

		elseif ( frame.ref.creatureFamily == ARENA_UNIT_FRAMES_CREATURE["Succubus"] ) then
			portrait:SetTexture("Interface\\ICONS\\Spell_Shadow_SummonSuccubus.blp");

		else
			portrait:SetTexture("Interface\\ICONS\\ABILITY_DRUID_DEMORALIZINGROAR.BLP");
		end
	end
	frame.tempPortrait = nil;
	portrait:SetAlpha(alpha);
end

function auf.MasterFrame_OnUpdate(arg1)
	updateTime = updateTime + arg1;
	if ( updateTime > .1 ) then
		updateTime = 0;

		local frameName;
		local now = GetTime();

		-- players
		for guid, player in pairs(opponents) do
			
			frameName = player.frame:GetName();

			-- check target range
			if ( config["options"]["rangeIndicator"] ) then
				for _, i in ipairs(auf.spellRanges) do
					if ( IsSpellInRange(i.id, BOOKTYPE_SPELL, player.unit) == 1 ) then
						_G[frameName.."RangeIconIcon"]:SetTexture(i.icon);
						break;
					end
					_G[frameName.."RangeIconIcon"]:SetTexture("");
				end
			end

			-- check countdown
			if ( player.frame.countdown and player.frame.countdown > now ) then
				if ( config["options"]["countdownPrecision"] ) then
					_G[frameName.."Countdown"]:SetText(format("%.1f", player.frame.countdown - now));
				else
					_G[frameName.."Countdown"]:SetText(math.ceil(player.frame.countdown - now));
				end

			elseif ( _G[frameName.."Countdown"]:IsVisible() ) then
				_G[frameName.."Countdown"]:Hide();
				_G[frameName.."Cooldown"]:Hide();
			end

			-- dimi returns counters
			if ( config["options"]["drMonitor"] ) then
				auf.SetDimis(guid);
			end

			-- pvp trinket
			if ( player.trinket and player.trinket < now ) then
				player.trinket = nil;
				auf.Alert("trinketAvailable", guid);

				if ( config["options"]["showTrinket"] ) then
					_G[frameName.."Trinket"]:Hide();
				end
			end

			-- wotf
			if ( player.wotf and player.wotf < now ) then
				player.wotf = nil;
				auf.Alert("wotfAvailable", guid);
			end

		end

		-- pets
		for guid, pet in pairs(pets) do
			frameName = pet.frame:GetName();

			-- check target range
			if ( config["options"]["rangeIndicator"] ) then
				for _, i in ipairs(auf.spellRanges) do
					if ( IsSpellInRange(i.id, BOOKTYPE_SPELL, pet.unit) == 1 ) then
						_G[frameName.."RangeIconIcon"]:SetTexture(i.icon);
						break;
					end
					_G[frameName.."RangeIconIcon"]:SetTexture("");
				end
			end

			-- check countdown
			if ( pet.frame.countdown and pet.frame.countdown > now ) then
				if ( config["options"]["countdownPrecision"] ) then
					_G[frameName.."Countdown"]:SetText(format("%.1f", player.frame.countdown - now));
				else
					_G[frameName.."Countdown"]:SetText(math.ceil(player.frame.countdown - now));
				end

			elseif ( _G[frameName.."Countdown"]:IsVisible() ) then
				_G[frameName.."Countdown"]:Hide();
				_G[frameName.."Cooldown"]:Hide();
			end
		end
	end
end

function auf.SetBuffFilter()

	local buff, list;

	-- buffs

	if ( config["lists"]["buffs"]["which"] == 1 ) then
		list = "black";
	else
		list = "white";
	end

	auf.buffFilter = {};
	for buff in string.gmatch(config["lists"]["buffs"][list], "[^\n]+") do
		if ( buff and buff ~= "" ) then
			buff = strtrim(buff);
			auf.buffFilter[buff] = 1;
		end
	end


	-- debuffs

	if ( config["lists"]["debuffs"]["which"] == 1 ) then
		list = "black";
	else
		list = "white";
	end

	auf.debuffFilter = {};
	for buff in string.gmatch(config["lists"]["debuffs"][list], "[^\n]+") do
		if ( buff and buff ~= "" ) then
			buff = strtrim(buff);
			auf.debuffFilter[buff] = 1;
		end
	end

end

function auf.NewDimi(guid, spell, duration)
	local type = dimiEffects[spell];
	local player = opponents[guid];
	if ( not player ) then
		return
	end

	-- if this diminishing returns type is already counting, add spell duration to max dr time
	if ( player.dimi[type] ) then
		player.dimi[type].time = GetTime() + 16 + (duration or 0); 
	else
		-- new

		local icon;

		player.dimi[type] = {};
		icon = _G[player.frame:GetName().."Dimi"..type];
		player.dimi[type].icon = icon;

		player.dimi[type].time = GetTime() + 16 + (duration or 0);
		_G[icon:GetName().."Icon"]:SetTexture(dimiTypes[type]);
		icon:Show();

		auf.ArrangeDimiIcons(guid);
	end

end

function auf.SetDimis(guid)
	local now = GetTime();
	local dimi, nextIcon;

	local player = opponents[guid];
	if ( not player ) then
		return
	end

	for i = 1, numDimiTypes do
		dimi = player.dimi[i];

		if ( dimi ) then
			if ( dimi.time < now ) then

				-- remove expired timers
				dimi.icon:Hide();
				player.dimi[i] = nil;
				auf.ArrangeDimiIcons(guid);

				auf.Alert("drExpiration", i, guid);
				auf.Alert("drExpiration2", i, guid);
			else
				-- set countdown text
				_G[dimi.icon:GetName().."Countdown"]:SetText( floor(dimi.time - now + 1) );
			end
		end
	end
end

function auf.ArrangeDimiIcons(guid)
	local icon;
	local dimi = opponents[guid].dimi;

	for i = 2, numDimiTypes do
		
		if ( dimi[i] ) then
			
			for j = i - 1, 1, -1 do
				if ( dimi[j] ) then
					-- anchor frame to first visible
					dimi[i].icon:ClearAllPoints();
					dimi[i].icon:SetPoint("RIGHT", dimi[j].icon, "LEFT", -1, 0);
					break;

				elseif ( j == 1 ) then
					-- no visible frames after this one; anchor to unit frame itself
					dimi[i].icon:ClearAllPoints();

					-- if unit frame is shorter than the range indicator and the dimi icons, then anchor against the bottom corner
					-- and overlap the ranged and dimi icons a bit
					if ( opponents[guid].frame:GetHeight() < 61 ) then
						dimi[i].icon:SetPoint("BOTTOMRIGHT", opponents[guid].frame, "BOTTOMLEFT", -1, 0);
					else
						dimi[i].icon:SetPoint("TOPRIGHT", opponents[guid].frame, "TOPLEFT", -1, -25);
					end
				end
			end
		end
	end
end

function auf.Button_OnEnter(self)

	self.mouseover = true;

	local barText = _G[self:GetName().."HealthBarText"];
	barText:Show();
	local current, max = UnitHealth(self.unit), UnitHealthMax(self.unit);

	current = current - current % 100;
	current = current / 1000;
	max = max - max % 100;
	max = max / 1000;

	if ( current == max ) then
		barText:SetText(max.."k");
	else
		barText:SetText(current.."k / "..max.."k");
	end

	local barText = _G[self:GetName().."ManaBarText"];
	barText:Show();
	local current, max = UnitMana(self.unit), UnitManaMax(self.unit);

	if ( max > 999 ) then
		current = current - current % 100;
		current = (current / 1000).."k";

		max = max - max % 100;
		max = (max / 1000).."k";
	end

	if ( current == max ) then
		barText:SetText(max);
	else
		barText:SetText(current.." / "..max);
	end
end
