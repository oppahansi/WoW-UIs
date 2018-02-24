--[[notes
work out the rogue spells that have varying durations, pally script
stacking spells? (sunder armor,flare)
moonfire?
]]

function DoTimer_DefineSpells(class) --creates the lists of spells to watch for for each class.  also defines their aliases for when i implement them.  DO NOT make the names not english!! i look for english names.  only mess with the abbreviations
	local spells,petspells,healspells,enslavespells,localedata,notargetspells
	if class == "WARLOCK" then
		healspells = {}
		spells = {
			["Curse of Agony"] = 1,
			["Curse of Exhaustion"] = 1,
			["Curse of Recklessness"] = 1,
			["Curse of the Elements"] = 1,
			["Curse of Shadow"] = 1,
			["Curse of Weakness"] = 1,
			["Curse of Tongues"] = 1,
			["Corruption"] = 1,
			["Banish"] = 1,
			["Immolate"] = 1,
			["Siphon Life"] = 1,
			["Curse of Doom"] = 1,
			["Fear"] = 1,
			["Death Coil"] = 1,
		}
		notargetspells = {
			["Howl of Terror"] = 1,
		}
		petspells = {
			["Seduction"] = 1,
			["Spell Lock"] = 1,
		}
		enslavespells = {
			["Inferno"] = 1,
			["Enslave Demon"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Shadow_CurseOfTounges"] = {
				["name"] = "Curse of Tongues",
				["duration"] = 30,
				["multiplier"] = 1,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_AbominationExplosion"] = {
				["name"] = "Corruption",
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Fire_Immolation"] = {
				["name"] = "Immolate",
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_SummonInfernal"] = {
				["name"] = "Inferno",
				["duration"] = 5,
				["multiplier"] = 60,
			},
			["Interface\\Icons\\Spell_Shadow_DeathCoil"] = {
				["name"] = "Death Coil",
				["duration"] = 3,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_AuraOfDarkness"] = {
				["name"] = "Curse of Doom",
				["duration"] = 1,
				["multiplier"] = 60,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_EnslaveDemon"] = {
				["name"] = "Enslave Demon",
				["duration"] = 5,
				["multiplier"] = 60,
			},
			["Interface\\Icons\\Spell_Shadow_MindSteal"] = {
				["name"] = "Seduction",
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_CurseOfSargeras"] = {
				["name"] = "Curse of Agony",
				["duration"] = 24,
				["multiplier"] = 1,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_CurseOfMannoroth"] = {
				["name"] = "Curse of Weakness",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_UnholyStrength"] = {
				["name"] = "Curse of Recklessness",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_CurseOfAchimonde"] = {
				["name"] = "Curse of Shadow",
				["duration"] = 5,
				["multiplier"] = 60,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_Cripple"] = {
				["name"] = "Banish",
				["duration"] = 20,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_ChillTouch"] = {
				["name"] = "Curse of the Elements",
				["duration"] = 5,
				["multiplier"] = 60,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_MindRot"] = {
				["name"] = "Spell Lock",
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_Possession"] = {
				["name"] = "Fear",
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_DeathScream"] = {
				["name"] = "Howl of Terror",
				["duration"] = 16,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Fire_Fireball"] = {
				["name"] = "Conflagrate", 
			},
			["Interface\\Icons\\Spell_Shadow_Requiem"] = {
				["name"] = "Siphon Life",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_GrimWard"] = {
				["name"] = "Curse of Exhaustion",
				["duration"] = 12,
				["multiplier"] = 1,
				["group"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_BurningSpirit"] = {
				["name"] = "Life Tap",
			},
		}
	elseif class == "DRUID" then
		petspells,enslavespells = {},{}
		spells = {
			["Entangling Roots"] = 1,
			["Faerie Fire"] = 1,
			["Hibernate"] = 1,
			["Insect Swarm"] = 1,
			["Rake"] = 1,
			["Rip"] = 1,
			["Soothe Animal"] = 1,
			["Moonfire"] = 1,
			["Bash"] = 1,
			["Pounce"] = 1,
			["Growl"] = 1,
			["Feral Charge"] = 1,
		}
		notargetspells = {
			["Demoralizing Roar"] = 1,
			["Challenging Roar"] = 1,
		}
		healspells = {
			["Abolish Poison"] = 1,
			["Regrowth"] = 1,
			["Rejuvenation"] = 1,
			["Innervate"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Ability_GhoulFrenzy"] = {
				["name"] = "Rip",  
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_FaerieFire"] = {
				["name"] = "Faerie Fire",  
				["duration"] = 40,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_Rejuvenation"] = {
				["name"] = "Rejuvenation",  
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_StrangleVines"] = {
				["name"] = "Entangling Roots",  
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_NullifyPoison_02"] = {
				["name"] = "Abolish Poison",  
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Druid_Disembowel"] = {
				["name"] = "Rake",  
				["duration"] = 9,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_Sleep"] = {
				["name"] = "Hibernate",  
				["duration"] = 20,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_ResistNature"] = {
				["name"] = "Regrowth",  
				["duration"] = 21,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Hunter_BeastSoothe"] = {
				["name"] = "Soothe Animal",  
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_InsectSwarm"] = {
				["name"] = "Insect Swarm", 
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_StarFall"] = {
				["name"] = "Moonfire",
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_Lightning"] = {
				["name"] = "Innervate",
				["duration"] = 20,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Hunter_Pet_Bear"] = {
				["name"] = "Feral Charge",
				["duration"] = 4,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Druid_ChallangingRoar"] = {
				["name"] = "Challenging Roar",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Physical_Taunt"] = {
				["name"] = "Growl",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Druid_Bash"] = {
				["name"] = "Bash",
				["duration"] = 3,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Druid_DemoralizingRoar"] = {
				["name"] = "Demoralizing Roar",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Druid_SupriseAttack"] = {
				["name"] = "Pounce",
				["duration"] = 2,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\INV_Relics_IdolofRejuvenation"] = {
				["name"] = "Swiftmend",
			},
		}
	elseif class == "PRIEST" then
		petspells,enslavespells = {},{}
		spells = {
			["Devouring Plague"] = 1,
			["Hex of Weakness"] = 1,
			["Mind Soothe"] = 1,
			["Shackle Undead"] = 1,
			["Shadow Word: Pain"] = 1,
			["Vampiric Embrace"] = 1,
			["Holy Fire"] = 1,
			["Touch of Weakness"] = 1,
			["Silence"] = 1,
		}
		notargetspells = {
			["Psychic Scream"] = 1,
		}
		healspells = {
			["Abolish Disease"] = 1,
			["Power Word: Shield"] = 1,
			["Renew"] = 1,
			["Power Infusion"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Nature_Slow"] = {
				["name"] = "Shackle Undead", 
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_ImpPhaseShift"] = {
				["name"] = "Silence",
				["duration"] = 5,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_DeadofNight"] = {
				["name"] = "Touch of Weakness",
				["duration"] = 2,
				["multiplier"] = 60,
			},
			["Interface\\Icons\\Spell_Holy_SearingLight"] = {
				["name"] = "Holy Fire",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_MindSooth"] = {
				["name"] = "Mind Soothe",  
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_NullifyDisease"] = {
				["name"] = "Abolish Disease",  
				["duration"] = 20,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_ShadowWordPain"] = {
				["name"] = "Shadow Word: Pain",  
				["duration"] = 18,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_PsychicScream"] = {
				["name"] = "Psychic Scream",  
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_BlackPlague"] = {
				["name"] = "Devouring Plague",  
				["duration"] = 24,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_Renew"] = {
				["name"] = "Renew", 	 
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_PowerWordShield"] = {
				["name"] = "Power Word: Shield",  
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_FingerOfDeath"] = {
				["name"] = "Hex of Weakness", 
				["duration"] = 2,
				["multiplier"] = 60,
			},
			["Interface\\Icons\\Spell_Shadow_UnsummonBuilding"] = {
				["name"] = "Vampiric Embrace", 
				["duration"] = 1,
				["multiplier"] = 60,
			},
			["Interface\\Icons\\Spell_Holy_PowerInfusion"] = {
				["name"] = "Power Infusion",
				["duration"] = 15,
				["multiplier"] = 1,
			},
		}
	elseif class == "HUNTER" then
		petspells,enslavespells,healspells = {},{},{}
		spells = {
			["Scorpid Sting"] = 1,
			["Serpent Sting"] = 1,
			["Viper Sting"] = 1,
			["Wing Clip"] = 1,
			["Wyvern Sting"] = 1,
			["Scare Beast"] = 1,
			["Concussive Shot"] = 1,
			["Counterattack"] = 1,
			["Hunter's Mark"] = 1,
			["Scatter Shot"] = 1,
		}
		notargetspells = {
			["Flare"] = 1,
			["Freezing Trap"] = 1,
			["Immolation Trap"] = 1,
			["Explosive Trap"] = 1,
			["Frost Trap"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Frost_ChainsOfIce"] = {
				["name"] = "Freezing Trap",
				["duration"] = 1,
				["multiplier"] = 60,
				["group"] = 6,
			},
			["Interface\\Icons\\Spell_Frost_FreezingBreath"] = {
				["name"] = "Frost Trap",
				["duration"] = 1,
				["multiplier"] = 60,
				["group"] = 6,
			},
			["Interface\\Icons\\Spell_Fire_FlameShock"] = {
				["name"] = "Immolation Trap",
				["duration"] = 1,
				["multiplier"] = 60,
				["group"] = 6,
			},
			["Interface\\Icons\\Spell_Fire_SelfDestruct"] = {
				["name"] = "Explosive Trap",
				["duration"] = 1,
				["multiplier"] = 60,
				["group"] = 6,
			},
			["Interface\\Icons\\Ability_Hunter_CriticalShot"] = {
				["name"] = "Scorpid Sting", 
				["duration"] = 20,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_GolemStormBolt"] = {
				["name"] = "Scatter Shot",
				["duration"] = 4,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Fire_Flare"] = {
				["name"] = "Flare",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Hunter_Quickshot"] = {
				["name"] = "Serpent Sting", 
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\INV_Spear_02"] = {
				["name"] = "Wyvern Sting", 
				["duration"] = 12,
				["multiplier"] = 2, --because it is a 12 second sleep and a 12 second DoT
			},
			["Interface\\Icons\\Ability_Rogue_Trip"] = {
				["name"] = "Wing Clip", 
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Hunter_AimedShot"] = {
				["name"] = "Viper Sting", 
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Druid_Cower"] = {
				["name"] = "Scare Beast",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Frost_Stun"] = {
				["name"] = "Concussive Shot",
				["duration"] = 4,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_Challange"] = {
				["name"] = "Counterattack",
				["duration"] = 5,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Hunter_SniperShot"] = {
				["name"] = "Hunter's Mark",
				["duration"] = 2,
				["multiplier"] = 60,
			},
		}
	elseif class == "MAGE" then
		petspells,enslavespells,healspells = {},{},{}
		spells = {
			["Polymorph"] = 1,
			["Polymorph: Pig"] = 1,
			["Polymorph: Turtle"] = 1,
			["Counterspell"] = 1,
		}
		notargetspells = {
			["Blast Wave"] = 1,
			["Cone of Cold"] = 1,
			["Frost Nova"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Nature_Polymorph"] = {
				["name"] = "Polymorph",
				["duration"] = 50,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Frost_FrostNova"] = {
				["name"] = "Frost Nova",
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Frost_IceShock"] = {
				["name"] = "Counterspell",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Frost_Glacier"] = {
				["name"] = "Cone of Cold",
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_Excorcism_02"] = {
				["name"] = "Blast Wave",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Magic_PolymorphPig"] = {
				["name"] = "Polymorph: Pig",
				["duration"] = 50,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Hunter_Pet_Turtle"] = {
				["name"] = "Polymorph: Turtle",
				["duration"] = 50,
				["multiplier"] = 1,
			},
		}
	elseif class == "WARRIOR" then
		petspells,enslavespells,healspells = {},{},{}
		spells = {
			["Charge"] = 1,
			["Disarm"] = 1,
			["Hamstring"] = 1,
			["Intercept"] = 1,
			["Mocking Blow"] = 1,
			["Mortal Strike"] = 1,
			["Pummel"] = 1,
			["Rend"] = 1,
			["Shield Bash"] = 1,
			["Sunder Armor"] = 1,
			["Concussion Blow"] = 1,
		}
		notargetspells = {
			["Challenging Shout"] = 1,
			["Demoralizing Shout"] = 1,
			["Thunder Clap"] = 1,
			["Intimidating Shout"] = 1,
			["Piercing Howl"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Ability_BullRush"] = {
				["name"] = "Challenging Shout",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_DeathScream"] = {
				["name"] = "Piercing Howl",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_ThunderBolt"] = {
				["name"] = "Concussion Blow",
				["duration"] = 5,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_Charge"] = {
				["name"] = "Charge",
				["duration"] = 1,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_WarCry"] = {
				["name"] = "Demoralizing Shout",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_Disarm"] = {
				["name"] = "Disarm",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_ShockWave"] = {
				["name"] = "Hamstring",
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Rogue_Sprint"] = {
				["name"] = "Intercept",
				["duration"] = 3,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_GolemThunderClap"] = {
				["name"] = "Intimidating Shout",
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_PunishingBlow"] = {
				["name"] = "Mocking Blow",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_SavageBlow"] = {
				["name"] = "Mortal Strike",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\INV_Gauntlets_04"] = {
				["name"] = "Pummel",
				["duration"] = 4,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Gouge"] = {
				["name"] = "Rend",
				["duration"] = 9,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_ShieldBash"] = {
				["name"] = "Shield Bash",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_Sunder"] = {
				["name"] = "Sunder Armor",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Nature_ThunderClap"] = {
				["name"] = "Thunder Clap",
				["duration"] = 10,
				["multiplier"] = 1,
			},
		}	
	elseif class == "ROGUE" then
		petspells,enslavespells,healspells = {},{},{}
		spells = {
			["Blind"] = 1,
			["Cheap Shot"] = 1,
			["Expose Armor"] = 1,
			["Garrote"] = 1,
			["Gouge"] = 1,
			["Hemorrhage"] = 1,
			["Kick"] = 1,
			["Kidney Shot"] = 1,
			["Rupture"] = 1,
			["Sap"] = 1,
			["Riposte"] = 1,
		}
		notargetspells = {
			["Distract"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Shadow_MindSteal"] = {
				["name"] = "Blind",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_CheapShot"] = {
				["name"] = "Cheap Shot",
				["duration"] = 4,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Rogue_Distract"] = {
				["name"] = "Distract",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_Riposte"] = {
				["name"] = "Expose Armor",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Rogue_Garrote"] = {
				["name"] = "Garrote",
				["duration"] = 18,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Gouge"] = {
				["name"] = "Gouge",
				["duration"] = 4,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Shadow_LifeDrain"] = {
				["name"] = "Hemorrhage",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Warrior_Challange"] = {
				["name"] = "Riposte",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Kick"] = {
				["name"] = "Kick",
				["duration"] = 5,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Rogue_KidneyShot"] = { --note: must track duration in fancier way!
				["name"] = "Kidney Shot",
				["duration"] = 0,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Rogue_Rupture"] = { --note: must track duration in fancier way!
				["name"] = "Rupture",
				["duration"] = 0,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_Sap"] = {
				["name"] = "Sap",
				["duration"] = 40,
				["multiplier"] = 1,
			},
		}	
	elseif class == "SHAMAN" then
		petspells,enslavespells,healspells = {},{},{}
		spells = {
			["Earth Shock"] = 1,
			["Flame Shock"] = 1,
			["Frost Shock"] = 1,
			["Stormstrike"] = 1,
		}
		notargetspells = {
			["Earthbind Totem"] = 1,
			["Stoneskin Totem"] = 1,
			["Stoneclaw Totem"] = 1,
			["Strength of Earth Totem"] = 1,
			["Tremor Totem"] = 1,
			["Searing Totem"] = 1,
			["Fire Nova Totem"] = 1,
			["Magma Totem"] = 1,
			["Frost Resistance Totem"] = 1,
			["Flametongue Totem"] = 1,
			["Healing Stream Totem"] = 1,
			["Mana Spring Totem"] = 1,
			["Poison Cleansing Totem"] = 1,
			["Disease Cleansing Totem"] = 1,
			["Mana Tide Totem"] = 1,
			["Fire Resistance Totem"] = 1,
			["Grace of Air Totem"] = 1,
			["Windfury Totem"] = 1,
			["Grounding Totem"] = 1,
			["Windwall Totem"] = 1,
			["Sentry Totem"] = 1,
			["Nature Resistance Totem"] = 1,
			["Tranquil Air Totem"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02"] = {
				["name"] = "Earthbind Totem",
				["duration"] = 45,
				["multiplier"] = 1,
				["group"] = 2,
			},
			["Interface\\Icons\\Spell_Nature_StoneSkinTotem"] = {
				["name"] = "Stoneskin Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 2,
			},
			["Interface\\Icons\\Spell_Nature_StoneClawTotem"] = {
				["name"] = "Stoneclaw Totem",
				["duration"] = 15,
				["multiplier"] = 1,
				["group"] = 2,
			},
			["Interface\\Icons\\Spell_Nature_EarthBindTotem"] = {
				["name"] = "Strength of Earth Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 2,
			},
			["Interface\\Icons\\Spell_Nature_TremorTotem"] = {
				["name"] = "Tremor Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 2,
			},
			["Interface\\Icons\\Spell_Fire_SearingTotem"] = {
				["name"] = "Searing Totem",
				["duration"] = 35,
				["multiplier"] = 1,
				["group"] = 3,
			},
			["Interface\\Icons\\Spell_Fire_SealOfFire"] = {
				["name"] = "Fire Nova Totem",
				["duration"] = 5,
				["multiplier"] = 1,
				["group"] = 3,
			},
			["Interface\\Icons\\Spell_Fire_SelfDestruct"] = {
				["name"] = "Magma Totem",
				["duration"] = 20,
				["multiplier"] = 1,
				["group"] = 3,
			},
			["Interface\\Icons\\Spell_FrostResistanceTotem_01"] = {
				["name"] = "Frost Resistance Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 3,
			},
			["Interface\\Icons\\Spell_Nature_GuardianWard"] = {
				["name"] = "Flametongue Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 3,
			},
			["Interface\\Icons\\INV_Spear_04"] = {
				["name"] = "Healing Stream Totem",
				["duration"] = 60,
				["multiplier"] = 1,
				["group"] = 4,
			},
			["Interface\\Icons\\Spell_Nature_ManaRegenTotem"] = {
				["name"] = "Mana Spring Totem",
				["duration"] = 60,
				["multiplier"] = 1,
				["group"] = 4,
			},
			["Interface\\Icons\\Spell_Nature_PoisonCleansingTotem"] = {
				["name"] = "Poison Cleansing Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 4,
			},
			["Interface\\Icons\\Spell_Nature_DiseaseCleansingTotem"] = {
				["name"] = "Disease Cleansing Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 4,
			},
			["Interface\\Icons\\Spell_Frost_SummonWaterElemental"] = {
				["name"] = "Mana Tide Totem",
				["duration"] = 12,
				["multiplier"] = 1,
				["group"] = 4,
			},
			["Interface\\Icons\\Spell_FireResistanceTotem_01"] = {
				["name"] = "Fire Resistance Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 4,
			},
			["Interface\\Icons\\Spell_Nature_InvisibilityTotem"] = {
				["name"] = "Grace of Air Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_Windfury"] = {
				["name"] = "Windfury Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_GroundingTotem"] = {
				["name"] = "Grounding Totem",
				["duration"] = 45,
				["multiplier"] = 1,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_EarthBind"] = {
				["name"] = "Windwall Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_RemoveCurse"] = {
				["name"] = "Sentry Totem",
				["duration"] = 5,
				["multiplier"] = 60,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_NatureResistanceTotem"] = {
				["name"] = "Nature Resistance Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_Brilliance"] = {
				["name"] = "Tranquil Air Totem",
				["duration"] = 2,
				["multiplier"] = 60,
				["group"] = 5,
			},
			["Interface\\Icons\\Spell_Nature_EarthShock"] = {
				["name"] = "Earth Shock",
				["duration"] = 2,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_SealOfMight"] = {
				["name"] = "Stormstrike",
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Fire_FlameShock"] = {
				["name"] = "Flame Shock",
				["duration"] = 12,
				["multiplier"] = 1,
			},
			["Interface/Icons/Spell_Frost_FrostShock"] = {
				["name"] = "Frost Shock",
				["duration"] = 8,
				["multiplier"] = 1,
			},
		}	
	elseif class == "PALADIN" then
		petspells,enslavespells = {},{}
		spells = {
			["Hammer of Justice"] = 1,
			["Judgement"] = 1,
			["Turn Undead"] = 1,
			["Repentance"] = 1,
		}
		notargetspells = {
			["Consecrate"] = 1,
		}
		healspells = {
			["Blessing of Protection"] = 1,
			["Blessing of Sacrifice"] = 1,
			["Blessing of Freedom"] = 1,
		}
		localedata = {
			["Interface\\Icons\\Spell_Holy_SealOfValor"] = {
				["name"] = "Blessing of Freedom",
				["duration"] = 10,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_SealOfProtection"] = {
				["name"] = "Blessing of Protection",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_PrayerOfHealing"] = {
				["name"] = "Repentance",
				["duration"] = 6,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_InnerFire"] = {
				["name"] = "Consecration",
				["duration"] = 8,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_SealOfSacrifice"] = {
				["name"] = "Blessing of Sacrifice",
				["duration"] = 30,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Spell_Holy_SealOfMight"] = {
				["name"] = "Hammer of Justice",
				["duration"] = 5,
				["multiplier"] = 1,
			},
			["Interface/Icons/Spell_Holy_RighteousFury"] = {
				["name"] = "Judgement",
				["duration"] = 0,
				["multiplier"] = 1,
			},
			["Interface/Icons/Spell_Holy_TurnUndead"] = {
				["name"] = "Turn Undead",
				["duration"] = 15,
				["multiplier"] = 1,
			},
			["Interface\\Icons\\Ability_ThunderBolt"] = {
				["name"] = "Seal of Righteousness",
				["group"] = 7,
			},
			["Interface\\Icons\\Spell_Holy_HolySmite"] = {
				["name"] = "Seal of the Crusader",
				["group"] = 7,
			},
			["Interface\\Icons\\Spell_Holy_HealingAura"] = {
				["name"] = "Seal of Light",
				["group"] = 7,
			},
			["Interface\\Icons\\Spell_Holy_RighteousnessAura"] = {
				["name"] = "Seal of Wisdom",
				["group"] = 7,
			},
			["Interface\\Icons\\Ability_Warrior_InnerRage"] = {
				["name"] = "Seal of Command",
				["group"] = 7,
			},
			["Interface\\Icons\\Spell_Holy_SealOfWrath"] = {
				["name"] = "Seal of Justice",
				["group"] = 7,
			},
		}	
	end
	return spells,petspells,healspells,enslavespells,notargetspells,localedata
end

DoTimer_CreateTimerGroup(
	"debuff",true,true,true,1,1,{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)
DoTimer_CreateTimerGroup(
	"depreciated",true,true,true,.9,1,{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)
DoTimer_CreateTimerGroup(
	"ghost",false,true,true,1,.5,{
		begin = {
			r = 1.0,
			g = .2,
			b = 1.0,
		},
		half = {
			r = 1.0,
			g = .2,
			b = 1.0,
		},
		final = {
			r = 1.0,
			g = .2,
			b = 1.0,
		},
	}
)
DoTimer_CreateTimerGroup(
	"enslave",true,true,true,1,1,{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)
DoTimer_CreateTimerGroup(
	"blank",false,false,false,.5,0,{
		begin = {
			r = 0.0,
			g = 0.0,
			b = 0.0,
		},
		half = {
			r = 0.0,
			g = 0.0,
			b = 0.0,
		},
		final = {
			r = 0.0,
			g = 0.0,
			b = 0.0,
		},
	}
)
DoTimer_CreateTimerGroup(
	"heal",true,true,true,1,1,{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)
DoTimer_CreateTimerGroup(
	"fake",true,true,true,1,1,{
		begin = {
			r = .2,
			g = 1.0,
			b = .2,
		},
		half = {
			r = 1.0,
			g = 1.0,
			b = .2,
		},
		final = {
			r = 1.0,
			g = .2,
			b = .2,
		},
	}
)

function DoTimer_ReturnUnitIDs()
	local t = {
		"target",
		"mouseover",
	}
	for i = 1,4 do table.insert(t,"party"..i) end
	for i = 1,40 do table.insert(t,"raid"..i) end
	return t
end
