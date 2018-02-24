-- Copyright © 2006 Mazin Assanie
-- All Rights Reserved.
-- 
-- Permission to use, copy, modify, and distribute this software in any way
-- is not granted without expressed written agreement.  In the case that it
-- is granted, the above copyright notice and this paragraph must appear in
-- all copies, modifications, and distributions.
--
-- To contact the author of this work, use mazzlefizz@gmail.com 
-- For more information on copyright, visit http://copyright.gov/ or http://whatiscopyright.org/
--

function Setup_SAS_GetBar(actionID)
    local theBar = floor((actionID-1)/12)
    local theIndex = actionID - (theBar *12)
    
    return theBar, theIndex 
end

function Setup_SAS_AddUniversals(theSASArray, tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex, hearthIndex)
    local theBar, theIndex

    theBar, theIndex = Setup_SAS_GetBar(tradeStart)
    theSASArray[theBar][theIndex] = {"Engineering·Trade_Engineering·", "Blacksmithing·Trade_BlackSmithing·", "Enchanting·Trade_Engraving·", "Tailoring·Trade_Tailoring·", "Alchemy·Trade_Alchemy·", "Leatherworking·INV_Misc_ArmorKit_17·","Smelting·Spell_Fire_FlameBlades·", }

    theBar, theIndex = Setup_SAS_GetBar(tradeStart+1)
    theSASArray[theBar][theIndex] = {"Smelting·Spell_Fire_FlameBlades·", "Leatherworking·INV_Misc_ArmorKit_17·", "Alchemy·Trade_Alchemy·", "Tailoring·Trade_Tailoring·", "Enchanting·Trade_Engraving·", "Blacksmithing·Trade_BlackSmithing·","Engineering·Trade_Engineering·", }
    
    theBar, theIndex = Setup_SAS_GetBar(tradeStart+2)
    theSASArray[theBar][theIndex] = {"Disenchant·Spell_Holy_RemoveCurse·",}
    
    theBar, theIndex = Setup_SAS_GetBar(skillStart)
    theSASArray[theBar][theIndex] = "First Aid·Spell_Holy_SealOfSacrifice·"

    theBar, theIndex = Setup_SAS_GetBar(skillStart+1)
    theSASArray[theBar][theIndex] = "Cooking·INV_Misc_Food_15·"    

    theBar, theIndex = Setup_SAS_GetBar(skillStart+2)
    theSASArray[theBar][theIndex] = "Basic Campfire·Spell_Fire_Fire·"

    theBar, theIndex = Setup_SAS_GetBar(skillStart+3)
    theSASArray[theBar][theIndex] = "Fishing·Trade_Fishing·"

    theBar, theIndex = Setup_SAS_GetBar(mountIndex)
    theSASArray[theBar][theIndex] = {
        "Deathcharger's Reins·Ability_Mount_MechaStrider··?·",
        "Black Qiraji Resonating Crystal·Ability_Mount_MechaStrider··?·",
        "Reins of the Black War Tiger·Ability_Mount_MechaStrider··?·",
        "Whistle of the Black War Raptor·Ability_Mount_MechaStrider··?·",
        "Reins of the Winterspring Frostsaber·Ability_Mount_MechaStrider··?·",
        "Palomino Bridle·Ability_Mount_MechaStrider··?·",
        "Swift Razzashi Raptor·Ability_Mount_MechaStrider··?·",
        "Swift Zulian Tiger·Ability_Mount_MechaStrider··?·",
        "White Stallion Bridle·Ability_Mount_MechaStrider··?·",
        "Black War Kodo·Ability_Mount_MechaStrider··?·",
        "Black War Ram·Ability_Mount_MechaStrider··?·",
        "Black War Steed Bridle·Ability_Mount_MechaStrider··?·",
        "Horn of the Swift Brown Wolf·Ability_Mount_MechaStrider··?·",
        "Horn of the Swift Gray Wolf·Ability_Mount_MechaStrider··?·",
        "Horn of the Swift Timber Wolf·Ability_Mount_MechaStrider··?·",
        "Reins of the Swift Frostsaber·Ability_Mount_MechaStrider··?·",
        "Reins of the Swift Mistsaber·Ability_Mount_MechaStrider··?·",
        "Reins of the Swift Stormsaber·Ability_Mount_MechaStrider··?·",
        "Swift Blue Raptor·Ability_Mount_MechaStrider··?·",
        "Swift Brown Ram·Ability_Mount_MechaStrider··?·",
        "Swift Brown Steed·Ability_Mount_MechaStrider··?·",
        "Swift Gray Ram·Ability_Mount_MechaStrider··?·",
        "Swift Green Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Swift Olive Raptor·Ability_Mount_MechaStrider··?·",
        "Swift Orange Raptor·Ability_Mount_MechaStrider··?·",
        "Swift Palomino·Ability_Mount_MechaStrider··?·",
        "Swift White Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Swift White Ram·Ability_Mount_MechaStrider··?·",
        "Swift White Steed·Ability_Mount_MechaStrider··?·",
        "Swift Yellow Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Great Brown Kodo·Ability_Mount_MechaStrider··?·",
        "Great Gray Kodo·Ability_Mount_MechaStrider··?·",
        "Great White Kodo·Ability_Mount_MechaStrider··?·",
        "Green Kodo·Ability_Mount_MechaStrider··?·",
        "Teal Kodo·Ability_Mount_MechaStrider··?·",
        "Black Ram·Ability_Mount_MechaStrider··?·",
        "Frost Ram·Ability_Mount_MechaStrider··?·",
        "Green Skeletal Warhorse·Ability_Mount_MechaStrider··?·",
        "Horn of the Arctic Wolf·Ability_Mount_MechaStrider··?·",
        "Horn of the Black War Wolf·Ability_Mount_MechaStrider··?·",
        "Horn of the Frostwolf Howler·Ability_Mount_MechaStrider··?·",
        "Horn of the Red Wolf·Ability_Mount_MechaStrider··?·",
        "Icy Blue Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Purple Skeletal Warhorse·Ability_Mount_MechaStrider··?·",
        "Red Skeletal Warhorse·Ability_Mount_MechaStrider··?·",
        "Reins of the Frostsaber·Ability_Mount_MechaStrider··?·",
        "Reins of the Nightsaber·Ability_Mount_MechaStrider··?·",
        "Stormpike Battle Charger·Ability_Mount_MechaStrider··?·",
        "Whistle of the Ivory Raptor·Ability_Mount_MechaStrider··?·",
        "Whistle of the Mottled Red Raptor·Ability_Mount_MechaStrider··?·",
        "White Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Summon Dreadsteed·Ability_Mount_Dreadsteed·", 
        "Summon Felsteed·Spell_Nature_Swiftness·",
        "Summon Charger·Ability_Mount_Dreadsteed·", 
        "Summon Warhorse·Ability_Mount_Dreadsteed·", 
        "Gray Ram·Ability_Mount_MechaStrider··?·",
        "Whistle of the Emerald Raptor·Ability_Mount_MechaStrider··?·",
        "Whistle of the Turquoise Raptor·Ability_Mount_MechaStrider··?·",
        "Whistle of the Violet Raptor·Ability_Mount_MechaStrider··?·",
        "Reins of the Spotted Frostsaber·Ability_Mount_MechaStrider··?·",
        "Reins of the Striped Frostsaber·Ability_Mount_MechaStrider··?·",
        "Reins of the Striped Nightsaber·Ability_Mount_MechaStrider··?·",
        "Horn of the Timber Wolf·Ability_Mount_MechaStrider··?·",
        "Horn of the Brown Wolf·Ability_Mount_MechaStrider··?·",
        "Horn of the Dire Wolf·Ability_Mount_MechaStrider··?·",
        "Unpainted Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Red Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Blue Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Green Mechanostrider·Ability_Mount_MechaStrider··?·",
        "Brown Horse Bridle·Ability_Mount_MechaStrider··?·",
        "Chestnut Mare Bridle·Ability_Mount_MechaStrider··?·",
        "Black Stallion Bridle·Ability_Mount_MechaStrider··?·",
        "Pinto Bridle·Ability_Mount_MechaStrider··?·",
        "Brown Kodo·Ability_Mount_MechaStrider··?·",
        "Gray Kodo·Ability_Mount_MechaStrider··?·",
        "White Ram·Ability_Mount_MechaStrider··?·",
        "Brown Ram·Ability_Mount_MechaStrider··?·",
        }

    theBar, theIndex = Setup_SAS_GetBar(racialIndex)
    theSASArray[theBar][theIndex] = {"Stoneform·Spell_Shadow_UnholyStrength·", "Escape Artist·Ability_Rogue_Trip·", "Shadowmeld·Ability_Ambush·", "Berserking·Racial_Troll_Berserk·",  "Will of the Forsaken·Spell_Shadow_RaiseDead·", "Blood Fury·Racial_Orc_BerserkerStrength·", "Perception·Spell_Nature_Sleep·", "War Stomp·Ability_WarStomp·",}
    
    if (racial2Index) then
        theBar, theIndex = Setup_SAS_GetBar(racial2Index)
        theSASArray[theBar][theIndex] = "Cannibalize·Ability_Racial_Cannibalize·"
    end
    if (oilIndex) then
        theBar, theIndex = Setup_SAS_GetBar(oilIndex)
        theSASArray[theBar][theIndex] = {"Brilliant Wizard Oil·INV_Potion_105··20749:0:0:1745912192·", "Brilliant Mana Oil·INV_Potion_100··20748:0:0:916077693·", "Wizard Oil·INV_Potion_104··20750:0:0:516376731·",}
    end

    if (hearthIndex) then
        theBar, theIndex = Setup_SAS_GetBar(hearthIndex)
        theSASArray[theBar][theIndex] = "Hearthstone·INV_Misc_Rune_01··6948·"
    end


    return theSASArray;
end

function Setup_SAS_MageMazzle()
    local testSASInfo = {
				[1] = {
					[1] = "Frost Ward·Spell_Frost_FrostWard·20·",
					[2] = "Mana Shield·Spell_Shadow_DetectLesserInvisibility·20·",
					[3] = "Fire Ward·Spell_Fire_FireArmor·20·",
					[4] = "Ice Barrier·Spell_Ice_Lament·",
					[5] = "Cold Snap·Spell_Frost_WizardMark·",
					[6] = "Slow Fall·Spell_Magic_FeatherFall·",
					[7] = "Arcane Intellect·Spell_Holy_MagicalSentry·20·",
					[8] = "Dampen Magic·Spell_Nature_AbolishMagic·20·",
					[9] = "Amplify Magic·Spell_Holy_FlashHeal·20·",
					[10] = "Arcane Brilliance·Spell_Holy_ArcaneIntellect·20·",
					[11] = "Remove Lesser Curse·Spell_Nature_RemoveCurse·",
					[12] = "Blink·Spell_Arcane_Blink·",
				},
				[2] = {
					[1] = "Counterspell·Spell_Frost_IceShock·",
					[2] = {"Combustion·Spell_Fire_SealOfFire·", "Arcane Power·Spell_Nature_Lightning·",},
					[3] = "Presence of Mind·Spell_Nature_EnchantArmor·",
					[4] = "Ice Block·Spell_Frost_Frost·",
					[5] = "Teleport: Ironforge·Spell_Arcane_TeleportIronForge·",
					[6] = "Teleport: Stormwind·Spell_Arcane_TeleportStormWind·",
					[7] = "Teleport: Darnassus·Spell_Arcane_TeleportDarnassus·",
					[8] = "Hearthstone·INV_Misc_Rune_01··6948·",
					[9] = "Portal: Ironforge·Spell_Arcane_PortalIronForge·",
					[10] = "Portal: Stormwind·Spell_Arcane_PortalStormWind·",
					[11] = "Portal: Darnassus·Spell_Arcane_PortalDarnassus·",
				},
				[3] = {
					[1] = "Conjure Mana Ruby·INV_Misc_Gem_Ruby_01·",
					[2] = "Conjure Mana Citrine·INV_Misc_Gem_Opal_01·",
					[3] = "Conjure Mana Jade·INV_Misc_Gem_Emerald_02·",
					[4] = "Conjure Mana Agate·INV_Misc_Gem_Emerald_01·",
					[5] = "Conjure Water·INV_Drink_18·20·",
					[6] = "Conjure Food·INV_Misc_Food_33·20·",
					[7] = "Ice Armor·Spell_Frost_FrostArmor02·20·",
					[8] = "Mage Armor·Spell_MageArmor·20·",
				},
				[4] = {
				},
				[5] = {
					[2] = "Evocation·Spell_Nature_Purge·",
					[4] = "Blast Wave·Spell_Holy_Excorcism_02·20·",
					[12] = "Pyroblast·Spell_Fire_Fireball02·20·",
				},
				[6] = {
					[1] = "Pyroblast·Spell_Fire_Fireball02·20·",
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[11] = "Shoot·INV_Wand_06·",
				},
				[0] = {
					[1] = {"Polymorph: Turtle·Ability_Hunter_Pet_Turtle·", "Polymorph: Pig·Spell_Magic_PolymorphPig·", "Polymorph·Spell_Nature_Polymorph·20·"},
					[2] = "Blizzard·Spell_Frost_IceStorm·20·",
					[3] = "Arcane Missiles·Spell_Nature_StarFall·20·",
					[4] = "Frostbolt·Spell_Frost_FrostBolt02·20·",
					[5] = "Fire Blast·Spell_Fire_Fireball·20·",
					[6] = "Detect Magic·Spell_Holy_Dizzy·",
					[7] = "Flamestrike·Spell_Fire_SelfDestruct·20·",
					[8] = "Scorch·Spell_Fire_SoulBurn·20·",
					[9] = "Fireball·Spell_Fire_FlameBolt·20·",
					[10] = "Frost Nova·Spell_Frost_FrostNova·1·",
					[11] = "Cone of Cold·Spell_Frost_Glacier·20·",
					[12] = "Arcane Explosion·Spell_Nature_WispSplode·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 53, 57, 120, 61, nil, 63)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_PriestMazzle()
    local testSASInfo = {
				[1] = {
					[1] = "Power Word: Shield·Spell_Holy_PowerWordShield·20·",
					[2] = {"Fear Ward·Spell_Holy_Excorcism·", "Feedback·Spell_Holy_PowerWordShield·20·", "Shadowguard·Spell_Holy_PowerWordShield·20·", "Elune's Grace·Spell_Holy_PowerWordShield·20·", "Touch of Weakness·Spell_Holy_PowerWordShield·20·",},
					[3] = "Divine Spirit·Spell_Holy_PowerWordShield·20·",
					[4] = "Shadow Protection·Spell_Shadow_AntiShadow·20·",
					[5] = "Prayer of Shadow Protection·Spell_Holy_PrayerofShadowProtection·20·",
					[6] = "Power Word: Fortitude·Spell_Holy_WordFortitude·20·",
					[7] = "Shackle Undead·Spell_Nature_Slow·20·",
					[8] = "Mind Control·Spell_Shadow_ShadowWordDominate·20·",
					[9] = "Mind Vision·Spell_Holy_MindVision·20·",
					[10] = "Mind Soothe·Spell_Holy_MindSooth·20·",
					[11] = "Psychic Scream·Spell_Shadow_PsychicScream·20·",
					[12] = "Dispel Magic·Spell_Holy_DispelMagic·20·",
				},
				[2] = {
					[1] = {"Abolish Disease·Spell_Nature_NullifyDisease·", "Cure Disease·Spell_Holy_NullifyDisease·",},
					[2] = "Levitate·Spell_Holy_LayOnHands·",
					[3] = "Inner Fire·Spell_Holy_InnerFire·20·",
					[4] = "Prayer of Fortitude·Spell_Holy_PrayerOfFortitude·20·",
					[8] = "Hearthstone·INV_Misc_Rune_01··6948·",
				},
				[3] = {
				},
				[4] = {
				},
				[5] = {
					[1] = {"Shadowform·Spell_Shadow_Shadowform·", "Power Infusion·Spell_Shadow_Shadowform·", "Lightwell·Spell_Shadow_Shadowform·"},
					[2] = "Vampiric Embrace·Spell_Shadow_UnsummonBuilding·",
					[3] = "Resurrection·Spell_Holy_Resurrection·20·",
					[4] = "Fade·Spell_Magic_LesserInvisibilty·20·",
					[5] = "Inner Focus·Spell_Frost_WindWalkOn·",
					[6] = "Silence·Spell_Shadow_ImpPhaseShift·",
				},
				[6] = {
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[11] = "Shoot·INV_Wand_05·",
				},
				[0] = {
					[1] = "Renew·Spell_Holy_Renew·20·",
					[2] = "Flash Heal·Spell_Holy_FlashHeal·20·",
					[3] = {"Heal·Spell_Holy_Heal02·20·", "Lesser Heal·Spell_Holy_GreaterHeal·20·",},
					[4] = {"Greater Heal·Spell_Holy_GreaterHeal·20·", "Heal·Spell_Holy_Heal02·20·",},
					[5] = "Prayer of Healing·Spell_Holy_PrayerOfHealing02·20·",
					[6] = {"Desperate Prayer·Spell_Holy_Restoration·20·", "Hex of Weakness·Spell_Holy_Restoration·20·", "Starshards·Spell_Holy_Restoration·20·", "Devouring Plague·Spell_Holy_Restoration·20·",},
					[7] = "Shadow Word: Pain·Spell_Shadow_ShadowWordPain·20·",
					[8] = "Mind Blast·Spell_Shadow_UnholyFrenzy·20·",
					[9] = "Smite·Spell_Holy_HolySmite·20·",
					[10] = "Mana Burn·Spell_Shadow_ManaBurn·20·",
					[11] = "Mind Flay·Spell_Shadow_SiphonMana·20·",
					[12] = "Holy Nova·Spell_Holy_HolyNova·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 37, 41, 120, 67, 68, 69)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_HunterMazzle()
			    local testSASInfo = {
				[1] = {
				    [2] = "Counterattack·Ability_Warrior_Challange·20·",
					[3] = "Aspect of the Monkey·Ability_Hunter_AspectOfTheMonkey·",
					[4] = "Aspect of the Hawk·Spell_Nature_RavenForm·20·",
					[5] = "Aspect of the Cheetah·Ability_Mount_JungleTiger·",
					[6] = "Aspect of the Beast·Ability_Mount_PinkTiger·",
					[7] = "Aspect of the Pack·Ability_Mount_WhiteTiger·",
					[8] = "Aspect of the Wild·Spell_Nature_ProtectionformNature·20·",
					[9] = "Serpent Sting·Ability_Hunter_Quickshot·20·",
					[10] = "Scorpid Sting·Ability_Hunter_CriticalShot·20·",
					[11] = "Viper Sting·Ability_Hunter_AimedShot·20·",
					[12] = "Scatter Shot·Ability_GolemStormBolt·",
				},
				[2] = {
					[1] = "Volley·Ability_Marksmanship·20·",
					[2] = "Flare·Spell_Fire_Flare·",
					[3] = "Tranquilizing Shot·Spell_Nature_Drowsy·",
					[4] = "Explosive Trap·Spell_Fire_SelfDestruct·20·",
					[5] = "Immolation Trap·Spell_Fire_FlameShock·20·",
					[6] = "Frost Trap·Spell_Frost_FreezingBreath·",
					[7] = "Freezing Trap·Spell_Frost_ChainsOfIce·20·",
					[8] = "Eyes of the Beast·Ability_EyeOfTheOwl·",
					[9] = "Mend Pet·Ability_Hunter_MendPet·20·",
					[10] = "Call Pet·Ability_Hunter_BeastCall·",
					[11] = "Dismiss Pet·Spell_Nature_SpiritWolf·",
					[12] = "Revive Pet·Ability_Hunter_BeastSoothe·",
				},
				[3] = {
					[1] = "Tame Beast·Ability_Hunter_BeastTaming·",
					[2] = "Intimidation·Ability_Devour·",
					[3] = "Bestial Wrath·Ability_Druid_FerociousBite·",
					[6] = "Eagle Eye·Ability_Hunter_EagleEye·",
					[7] = "Deterrence·Ability_Whirlwind·",
					[8] = "Beast Lore·Ability_Physical_Taunt·",
					[9] = "Beast Training·Ability_Hunter_BeastCall02·",
					[11] = "Hearthstone·INV_Misc_Rune_01··6948·",
				},
				[4] = {
				},
				[5] = {
				},
				[6] = {
					[4] = "Hunter's Mark·Ability_Hunter_SniperShot·20·",
					[5] = "Rapid Fire·Ability_Druid_Cower·20·",
					[6] = "Scare Beast·Ability_Druid_Cower·20·",
					[7] = "Feign Death·Ability_Rogue_FeignDeath·",
					[8] = "Trueshot Aura·Ability_Hunter_AspectOfTheMonkey·",
					[10] = "Feed Pet·Ability_Hunter_BeastTraining·",
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[10] = "Wing Clip·Ability_Rogue_Trip·1·",
				},
				[0] = {
					[1] = "Auto Shot·INV_Weapon_Crossbow_04·",
					[2] = "Aimed Shot·INV_Spear_07·20·",
					[3] = "Concussive Shot·Spell_Frost_Stun·",
					[4] = "Arcane Shot·Ability_ImpalingBolt·20·",
					[5] = "Multi-Shot·Ability_UpgradeMoonGlaive·20·",
					[6] = "Distracting Shot·Spell_Arcane_Blink·20·",
					[7] = "Wyvern Sting·Ability_Hunter_AimedShot·20·",
					[8] = "Attack·INV_Axe_12·",
					[9] = "Raptor Strike·Ability_MeleeDamage·20·",
					[10] = "Mongoose Bite·Ability_Hunter_SwiftStrike·20·",
					[11] = "Disengage·Ability_Rogue_Feint·20·",
					[12] = "Wing Clip·Ability_Rogue_Trip·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 52, 56, 120, 81, nil, nil)
    Mazzify_SASLoad(testSASInfo)
    
end

function Setup_SAS_WarlockMazzle()
    local testSASInfo = {
				[1] = {
					[1] = "Curse of Exhaustion·Spell_Shadow_GrimWard·",
					[2] = "Drain Soul·Spell_Shadow_Haunting·20·",
					[3] = "Drain Life·Spell_Shadow_LifeDrain02·20·",
					[4] = "Drain Mana·Spell_Shadow_SiphonMana·20·",
					[5] = "Siphon Life·Spell_Shadow_Requiem·20·",
					[6] = "Hellfire·Spell_Fire_Incinerate·20·",
					[7] = "Rain of Fire·Spell_Shadow_RainOfFire·20·",
					[8] = "Shadowburn·Spell_Shadow_ScourgeBuild·20·",
					[9] = "Soul Fire·Spell_Fire_Fireball02·20·",
					[10] = {"Demon Armor·Spell_Shadow_RagingScream·20·", "Demon Skin·Spell_Shadow_RagingScream·20·",},
					[11] = "Shadow Ward·Spell_Shadow_AntiShadow·20·",
					[12] = "Unending Breath·Spell_Shadow_DemonBreath·",
				},
				[2] = {
					[1] = {"Detect Greater Invisibility·Spell_Shadow_DetectInvisibility·", "Detect Lesser Invisibility·Spell_Shadow_DetectLesserInvisibility·",},
					[2] = "Demonic Sacrifice·Spell_Shadow_PsychicScream·",
					[3] = "Amplify Curse·Spell_Shadow_Contagion·",
					[4] = "Soul Link·Spell_Shadow_GatherShadows·20·",
					[5] = "Death Coil·Spell_Shadow_DeathCoil·20·",
					[6] = "Fear·Spell_Shadow_Possession·20·",
					[7] = "Howl of Terror·Spell_Shadow_DeathScream·20·",
					[8] = "Enslave Demon·Spell_Shadow_EnslaveDemon·20·",
					[9] = "Banish·Spell_Shadow_Cripple·20·",
					[10] = "Life Tap·Spell_Shadow_BurningSpirit·20·",
					[11] = "Health Funnel·Spell_Shadow_LifeDrain·20·",
					[12] = "Dark Pact·Spell_Shadow_DarkRitual·20·",
				},
				[3] = {
					[1] = "Create Healthstone (Major)·INV_Stone_04·",
					[2] = "Create Firestone (Major)·INV_Ammo_FireTar·",
					[3] = "Create Soulstone (Major)·Spell_Shadow_SoulGem·",
					[4] = "Create Spellstone (Major)·INV_Misc_Gem_Sapphire_01·",
					[8] = "Hearthstone·INV_Misc_Rune_01··6948·",
					[9] = "Fel Domination·Spell_Nature_RemoveCurse·",
					[12] = "Eye of Kilrogg·Spell_Shadow_EvilEye·",
				},
				[4] = {
					[1] = "Summon Imp·Spell_Shadow_SummonImp·",
					[2] = "Summon Voidwalker·Spell_Shadow_SummonVoidWalker·",
					[3] = "Summon Succubus·Spell_Shadow_SummonSuccubus·",
					[4] = "Summon Felhunter·Spell_Shadow_SummonFelHunter·",
				},
				[5] = {
					[9] = "Ritual of Summoning·Spell_Shadow_Twilight·",
				},
				[6] = {
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[11] = "Shoot·INV_Wand_06·",
				},
				[0] = {
					[1] = "Shadow Bolt·Spell_Shadow_ShadowBolt·20·",
					[2] = "Immolate·Spell_Fire_Immolation·20·",
					[3] = "Corruption·Spell_Shadow_AbominationExplosion·20·",
					[4] = "Searing Pain·Spell_Fire_SoulBurn·20·",
					[5] = "Conflagrate·Spell_Fire_Fireball·20·",
					[6] = "Curse of Shadow·Spell_Shadow_CurseOfAchimonde·20·",
					[7] = "Curse of the Elements·Spell_Shadow_ChillTouch·20·",
					[8] = "Curse of Recklessness·Spell_Shadow_UnholyStrength·20·",
					[9] = "Curse of Agony·Spell_Shadow_CurseOfSargeras·20·",
					[10] = "Curse of Doom·Spell_Shadow_AuraOfDarkness·",
					[11] = "Curse of Tongues·Spell_Shadow_CurseOfTounges·20·",
					[12] = "Curse of Weakness·Spell_Shadow_CurseOfMannoroth·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 41, 65, 120, 70, nil, nil)
    Mazzify_SASLoad(testSASInfo)
end


function Setup_SAS_DruidMazzle()
    local testSASInfo = {
				[1] = {
					[1] = "Growl·Ability_Physical_Taunt·",
					[2] = "Challenging Roar·Ability_Druid_ChallangingRoar·",
					[3] = "Demoralizing Roar·Ability_Druid_DemoralizingRoar·20·",
					[4] = "Attack·INV_Staff_13·",
					[5] = "Starfire·Spell_Arcane_StarFire·20·",
					[6] = "Hurricane·Spell_Nature_Cyclone·20·",
					[7] = "Tranquility·Spell_Nature_Tranquility·20·",
					[8] = "Insect Swarm·Spell_Nature_InsectSwarm·20·",
					[9] = "Prowl·Ability_Ambush·20·",
					[10] = "Dash·Ability_Druid_Dash·20·",
					[11] = "Tiger's Fury·Ability_Mount_JungleTiger·20·",
					[12] = "Cower·Ability_Druid_Cower·20·",
				},
				[2] = {
					[2] = "Frenzied Regeneration·Ability_BullRush·20·",
					[3] = "Enrage·Ability_Druid_Enrage·",
					[7] = "Nature's Swiftness·Spell_Nature_RavenForm·",
					[8] = "Swiftmend·INV_Relics_IdolofRejuvenation·",
					[10] = "Ferocious Bite·Ability_Druid_FerociousBite·20·",
					[9] = "Faerie Fire·Spell_Nature_FaerieFire·20·",
					[11] = "Rip·Ability_GhoulFrenzy·20·",
				},
				[3] = {
					[1] = "Bash·Ability_Druid_Bash·20·",
					[2] = "Feral Charge·Ability_Hunter_Pet_Bear·",
					[3] = "Faerie Fire (Feral)·Spell_Nature_FaerieFire·20·",
					[4] = "Hibernate·Spell_Nature_Sleep·20·",
					[5] = "Soothe Animal·Ability_Hunter_BeastSoothe·20·",
					[6] = "Entangling Roots·Spell_Nature_StrangleVines·20·",
					[7] = "Nature's Grasp·Spell_Nature_NaturesWrath·20·",
					[8] = "Rebirth·Spell_Nature_Reincarnation·20·",
					[9] = "Remove Curse·Spell_Holy_RemoveCurse·",
					[10] = "Abolish Poison·Spell_Nature_NullifyPoison_02·",
					[11] = "Gift of the Wild·Spell_Nature_Regeneration·20·",
					[12] = "Mark of the Wild·Spell_Nature_Regeneration·20·",
				},
				[4] = {
					[1] = "Thorns·Spell_Nature_Thorns·20·",
					[2] = "Barkskin·Spell_Nature_StoneClawTotem·",
					[3] = "Omen of Clarity·Spell_Nature_CrystalBall·",
					[4] = "Healing Touch·Spell_Nature_HealingTouch·5·",
					[5] = "Healing Touch·Spell_Nature_HealingTouch·7·",
					[7] = "Innervate·Spell_Nature_Lightning·",
				},
				[5] = {
					[1] = "Teleport: Moonglade·Spell_Arcane_TeleportMoonglade·",
					[2] = "Hearthstone·INV_Misc_Rune_01··6948·",
				},
				[6] = {
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[10] = "Aquatic Form·Ability_Druid_AquaticForm·",
					[9] = "Cat Form·Ability_Druid_CatForm·",
					[11] = {"Dire Bear Form·Ability_Racial_BearForm·", "Bear Form·Ability_Racial_BearForm·",},
					[8] = "Travel Form·Ability_Druid_TravelForm·",
					[7] = "Moonkin Form·Ability_Druid_CatForm·",
					[6] = "Tree Form·Ability_Druid_CatForm·",
				},
				[0] = {
					[1] = "Rejuvenation·Spell_Nature_Rejuvenation·20·",
					[2] = "Regrowth·Spell_Nature_ResistNature·20·",
					[3] = "Healing Touch·Spell_Nature_HealingTouch·20·",
					[4] = "Moonfire·Spell_Nature_StarFall·20·",
					[5] = "Wrath·Spell_Nature_AbolishMagic·20·",
					[6] = "Claw·Ability_Druid_Rake·20·",
					[7] = "Rake·Ability_Druid_Disembowel·20·",
					[8] = "Shred·Spell_Shadow_VampiricAura·20·",
					[9] = "Ravage·Ability_Druid_Ravage·20·",
					[10] = "Pounce·Ability_Druid_SupriseAttack·20·",
					[11] = "Swipe·INV_Misc_MonsterClaw_03·20·",
					[12] = "Maul·Ability_Druid_Maul·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 67, 71, 120, 54, nil, nil)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_RogueMazzle()
    local testSASInfo = {
				[1] = {
					[1] = {"Ghostly Strike·Ability_Rogue_Eviscerate·20·", "Hemorrhage·Ability_Rogue_Eviscerate·20·",},
					[2] = "Eviscerate·Ability_Rogue_Eviscerate·20·",
					[3] = "Slice and Dice·Ability_Rogue_SliceDice·20·",
					[4] = "Expose Armor·Ability_Warrior_Riposte·20·",
					[5] = "Kidney Shot·Ability_Rogue_KidneyShot·20·",
					[6] = "Rupture·Ability_Rogue_Rupture·20·",
					[7] = {"Adrenaline Rush·Spell_Shadow_ShadowWordDominate·", "Premeditation·Spell_Shadow_ShadowWordDominate·",},
					[8] = "Cold Blood·Spell_Ice_Lament·",
					[9] = "Preparation·Spell_Ice_Lament·",
					[12] = "Distract·Ability_Rogue_Distract·",
				},
				[2] = {
					[1] = "Pick Pocket·INV_Misc_Bag_11·",
					[2] = "Disarm Trap·Spell_Shadow_GrimWard·",
					[4] = "Instant Poison VI·Ability_Poisons··8928:0:0:536905668·",
					[5] = "Crippling Poison II·INV_Potion_19··3776:0:0:493057390·",
					[6] = "Deadly Poison V·Ability_Rogue_DualWeild··20844:0:0:455018542·",
					[7] = "Mind-numbing Poison III·Spell_Nature_NullifyDisease··9186:0:0:922815083·",
					[8] = "Wound Poison IV·Ability_PoisonSting··10922:0:0:439628374·",
					[10] = "Blade Flurry·Ability_Warrior_PunishingBlow·",
					[9] = "Poisons·Trade_BrewPoison·",
					[11] = "Poisons·Trade_BrewPoison·",
				},
				[3] = {
					[2] = "Hemorrhage·Ability_Rogue_Eviscerate·20·",
					[4] = "Evasion·Spell_Shadow_ShadowWard·",
					[8] = "Hearthstone·INV_Misc_Rune_01··6948·",
				},
				[4] = {
					[4] = "Pick Lock·Spell_Nature_MoonKey·",
				},
				[5] = {
				},
				[6] = {
					[1] = "Blind·Spell_Shadow_MindSteal·",
					[2] = "Shoot Gun·Ability_Marksmanship·",
					[3] = "Sprint·Ability_Rogue_Sprint·20·",
					[5] = "Dense Sharpening Stone·INV_Stone_SharpeningStone_05··12404:0:0:179795402·",
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[11] = "Stealth·Ability_Stealth·3·",
				},
				[0] = {
					[1] = "Vanish·Ability_Vanish·20·",
					[2] = "Feint·Ability_Rogue_Feint·20·",
					[3] = "Kick·Ability_Kick·20·",
					[5] = "Sap·Ability_Sap·20·",
					[6] = "Ambush·Ability_Rogue_Ambush·20·",
					[7] = "Cheap Shot·Ability_CheapShot·",
					[8] = "Garrote·Ability_Rogue_Garrote·20·",
					[9] = "Sinister Strike·Spell_Shadow_RitualOfSacrifice·20·",
					[10] = "Backstab·Ability_BackStab·20·",
					[11] = "Gouge·Ability_Gouge·20·",
					[12] = {"Riposte·Ability_Warrior_Challange·", "Ghostly Strike·Ability_Rogue_Eviscerate·20·",},
				},
			}
			
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 49, 53, 120, 76, 39, nil)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_PaladinMazzle()
    local testSASInfo = {
				[1] = {
					[1] = {"Repentance·Spell_Holy_InnerFire·20·", "Holy Shock·Spell_Holy_InnerFire·20·", },
					[2] = "Exorcism·Spell_Holy_Excorcism_02·20·",
					[3] = "Holy Wrath·Spell_Holy_Excorcism·20·",
					[4] = "Turn Undead·Spell_Holy_TurnUndead·20·",
					[5] = "Seal of Righteousness·Ability_ThunderBolt·20·",
					[6] = "Seal of the Crusader·Spell_Holy_HolySmite·20·",
					[7] = "Seal of Justice·Spell_Holy_SealOfWrath·",
					[8] = "Seal of Wisdom·Spell_Holy_RighteousnessAura·20·",
					[9] = "Seal of Light·Spell_Holy_HealingAura·20·",
					[10] = "Seal of Command·Ability_Warrior_InnerRage·20·",
					[11] = "Divine Shield·Spell_Holy_DivineIntervention·20·",
					[12] = "Divine Protection·Spell_Holy_Restoration·20·",
				},
				[2] = {
					[1] = "Righteous Fury·Spell_Holy_SealOfFury·",
					[2] = {"Divine Favor·Spell_Holy_InnerFire·20·", "Holy Shield·Spell_Holy_InnerFire·20·", },
					[2] = "Holy Shield·Spell_Holy_InnerFire·20·", 
					[4] = "Blessing of Wisdom·Spell_Holy_SealOfWisdom·20·",
					[5] = "Blessing of Salvation·Spell_Holy_SealOfSalvation·",
					[6] = "Blessing of Might·Spell_Holy_FistOfJustice·20·",
					[7] = "Blessing of Kings·Spell_Magic_MageArmor·",
					[8] = "Blessing of Freedom·Spell_Holy_SealOfValor·",
					[9] = "Blessing of Protection·Spell_Holy_SealOfProtection·20·",
					[10] = "Greater Blessing of Wisdom·Spell_Holy_GreaterBlessingofWisdom·20·",
					[11] = "Greater Blessing of Salvation·Spell_Holy_GreaterBlessingofSalvation·",
					[12] = "Greater Blessing of Might·Spell_Holy_GreaterBlessingofKings·20·",
				},
				[3] = {
					[1] = "Greater Blessing of Kings·Spell_Magic_GreaterBlessingofKings·",
					[2] = "Blessing of Light·Spell_Holy_PrayerOfHealing02·20·",
					[3] = "Greater Blessing of Light·Spell_Holy_GreaterBlessingofLight·20·",
					[4] = "Blessing of Sanctuary·Spell_Nature_LightningShield·20·",
				},
				[4] = {
					[4] = "Redemption·Spell_Holy_Resurrection·20·",
				},
				[5] = {
					[2] = "Hearthstone·INV_Misc_Rune_01··6948·",
				},
				[6] = {
				},
				[7] = {
					[8] = "Judgement·Spell_Holy_RighteousFury·",
				},
				[8] = {
				},
				[9] = {
				},
				[0] = {
					[1] = "Flash of Light·Spell_Holy_FlashHeal·20·",
					[2] = "Holy Light·Spell_Holy_HolyBolt·20·",
					[3] = "Cleanse·Spell_Holy_Renew·",
					[4] = "Purify·Spell_Holy_Purify·",
					[5] = "Lay on Hands·Spell_Holy_LayOnHands·20·",
					[6] = "Divine Intervention·Spell_Nature_TimeStop·",
					[9] = "Attack·INV_Weapon_Halberd_09·",
					[10] = "Hammer of Justice·Spell_Holy_SealOfMight·20·",
					[11] = "Hammer of Wrath·Ability_ThunderClap·20·",
					[12] = {"Consecration·Spell_Holy_InnerFire·20·", "Holy Shock·Spell_Holy_InnerFire·20·", "Repentance·Spell_Holy_InnerFire·20·",},
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 67, 71, 120, 50, nil, nil)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_WarriorJoyluck()
    local testSASInfo = {
				[1] = {
					[1] = "Shield Block·Ability_Defend·",
					[2] = "Disarm·Ability_Warrior_Disarm·",
					[3] = "Intercept·Ability_Rogue_Sprint·20·",
					[4] = "Berserker Rage·Spell_Nature_AncestralGuardian·",
					[5] = "Hamstring·Ability_ShockWave·20·",
					[6] = "Sunder Armor·Ability_Warrior_Sunder·20·",
					[7] = "Pummel·INV_Gauntlets_04·20·",
					[8] = "Whirlwind·Ability_Whirlwind·",
					[9] = "Slam·Ability_Warrior_DecisiveStrike·20·",
					[10] = {"Mortal Strike·Ability_Warrior_SavageBlow·20·", "Bloodthirst·Ability_Warrior_SavageBlow·20·", "Shield Slam·Ability_Warrior_SavageBlow·20·",},
					[11] = "Execute·INV_Sword_48·20·",
					[12] = "Heroic Strike·Ability_Rogue_Ambush·20·",
				},
				[2] = {
					[1] = "Cleave·Ability_Warrior_Cleave·20·",
					[2] = "Sweeping Strikes·Ability_Rogue_SliceDice·",
					[3] = "Bloodrage·Ability_Racial_BloodRage·",
					[4] = {"Last Stand·Spell_Holy_AshesToAshes·", "Death Wish·Spell_Holy_AshesToAshes·",},
					[5] = {"Death Wish·Spell_Holy_AshesToAshes·","Last Stand·Spell_Holy_AshesToAshes·",},
					[6] = "Concussion Blow·Ability_Warrior_ShieldWall·",
					[10] = "Shield Wall·Ability_Warrior_ShieldWall·",
					[12] = "Shoot Bow·Ability_Marksmanship·",
					[9] = "Retaliation·Ability_Warrior_Challange·",
					[11] = "Recklessness·Ability_CriticalStrike·",
					[12] = {"Shoot Gun·Ability_Marksmanship·", "Shoot Crossbow·Ability_Marksmanship·", "Shoot Bow·Ability_Marksmanship·",},
				},
				[3] = {
					[1] = "Attack·INV_Sword_56·",
					[2] = "Battle Shout·Ability_Warrior_BattleShout·20·",
					[3] = "Demoralizing Shout·Ability_Warrior_WarCry·20·",
					[4] = "Intimidating Shout·Ability_GolemThunderClap·",
					[5] = "Challenging Shout·Ability_BullRush·",
					[6] = "Piercing Howl·Spell_Shadow_DeathScream·",
				},
				[4] = {
					[9] = "Hearthstone·INV_Misc_Rune_01··6948·",
				},
				[5] = {
				},
				[6] = {
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
					[10] = "Battle Stance·Ability_Warrior_OffensiveStance·",
					[9] = "Defensive Stance·Ability_Warrior_DefensiveStance·",
					[11] = "Overpower·Ability_MeleeDamage·20·",
					[8] = "Berserker Stance·Ability_Racial_Avatar·",
				},
				[0] = {
					[1] = "Charge·Ability_Warrior_Charge·20·",
					[2] = "Rend·Ability_Gouge·20·",
					[3] = "Hamstring·Ability_ShockWave·20·",
					[4] = "Sunder Armor·Ability_Warrior_Sunder·20·",
					[5] = "Shield Bash·Ability_Warrior_ShieldBash·20·",
					[6] = "Thunder Clap·Spell_Nature_ThunderClap·20·",
					[7] = "Mocking Blow·Ability_Warrior_PunishingBlow·20·",
					[8] = "Taunt·Spell_Nature_Reincarnation·",
					[9] = "Rend·Ability_Gouge·20·",
					[10] = "Revenge·Ability_Warrior_Revenge·20·",
					[11] = "Sunder Armor·Ability_Warrior_Sunder·20·",
					[12] = "Shield Bash·Ability_Warrior_ShieldBash·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 62, 66, 120, 50, 49, nil)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_Shaman()
    local testSASInfo = {
				[1] = {
					[1] = "Ghost Wolf·Spell_Nature_SpiritWolf·",
					[2] = "Lightning Shield·Spell_Nature_LightningShield·20·",
					[3] = "Water Breathing·Spell_Shadow_DemonBreath·",
					[4] = "Water Walking·Spell_Frost_WindWalkOn·",
					[5] = "Flametongue Weapon·Spell_Fire_FlameTounge·20·",
					[6] = "Frostbrand Weapon·Spell_Frost_FrostBrand·20·",
					[7] = "Rockbiter Weapon·Spell_Nature_RockBiter·20·",
					[8] = "Windfury Weapon·Spell_Nature_Cyclone·20·",
					[9] = "Windwall Totem·Spell_Nature_EarthBind·20·",
					[10] = "Tranquil Air Totem·Spell_Nature_Brilliance·",
					[11] = "Stoneskin Totem·Spell_Nature_StoneSkinTotem·20·",
					[12] = "Stoneclaw Totem·Spell_Nature_StoneClawTotem·20·",
				},
				[2] = {
					[1] = "Sentry Totem·Spell_Nature_RemoveCurse·",
					[2] = "Earthbind Totem·Spell_Nature_StrengthOfEarthTotem02·",
					[3] = "Flametongue Totem·Spell_Nature_GuardianWard·20·",
					[4] = "Fire Nova Totem·Spell_Fire_SealOfFire·20·",
					[5] = "Magma Totem·Spell_Fire_SelfDestruct·20·",
					[6] = "Searing Totem·Spell_Fire_SearingTotem·20·",
					[7] = "Windfury Totem·Spell_Nature_Windfury·20·",
					[8] = "Mana Tide Totem·Spell_Nature_Windfury·20·",
					[10] = "Fire Resistance Totem·Spell_FireResistanceTotem_01·20·",
					[11] = "Nature Resistance Totem·Spell_Nature_NatureResistanceTotem·20·",
					[12] = "Frost Resistance Totem·Spell_FrostResistanceTotem_01·20·",
				},
				[3] = {
					[1] = "Healing Stream Totem·INV_Spear_04·20·",
					[2] = "Mana Spring Totem·Spell_Nature_ManaRegenTotem·20·",
					[3] = "Poison Cleansing Totem·Spell_Nature_PoisonCleansingTotem·",
					[4] = "Disease Cleansing Totem·Spell_Nature_DiseaseCleansingTotem·",
					[5] = "Tremor Totem·Spell_Nature_TremorTotem·",
					[6] = "Grounding Totem·Spell_Nature_GroundingTotem·",
					[7] = "Far Sight·Spell_Nature_FarSight·",
					[10] = "Astral Recall·Spell_Nature_AstralRecal·",
				},
				[4] = {
				},
				[5] = {
				},
				[6] = {
					[3] = {"Elemental Mastery·Spell_Nature_WispHeal·", "Stormstrike·Spell_Nature_WispHeal·",},
					[4] = "Nature's Swiftness·Spell_Nature_RavenForm·",
					[6] = "Purge·Spell_Nature_Purge·20·",
					[7] = "Grace of Air Totem·Spell_Nature_InvisibilityTotem·20·",
					[8] = "Strength of Earth Totem·Spell_Nature_EarthBindTotem·20·",
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
				},
				[0] = {
					[1] = "Attack·INV_Mace_14·",
					[2] = "Lightning Bolt·Spell_Nature_Lightning·20·",
					[3] = "Chain Lightning·Spell_Nature_ChainLightning·20·",
					[4] = "Earth Shock·Spell_Nature_EarthShock·20·",
					[5] = "Flame Shock·Spell_Fire_FlameShock·20·",
					[6] = "Frost Shock·Spell_Frost_FrostShock·20·",
					[7] = "Healing Wave·Spell_Nature_MagicImmunity·20·",
					[8] = "Lesser Healing Wave·Spell_Nature_HealingWaveLesser·20·",
					[9] = "Chain Heal·Spell_Nature_HealingWaveGreater·20·",
					[10] = "Cure Disease·Spell_Nature_RemoveDisease·",
					[11] = "Cure Poison·Spell_Nature_NullifyPoison·",
					[12] = "Ancestral Spirit·Spell_Nature_Regenerate·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 51, 55, 120, 77, nil, nil)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_ShamanDurzil()
    local testSASInfo = {
				[1] = {
					[1] = "Earthbind Totem·Spell_Nature_StrengthOfEarthTotem02·",
					[2] = "Fire Nova Totem·Spell_Fire_SealOfFire·20·",
					[3] = "Magma Totem·Spell_Fire_SelfDestruct·20·",
					[4] = "Searing Totem·Spell_Fire_SearingTotem·20·",
					[5] = "Flametongue Totem·Spell_Nature_GuardianWard·20·",
					[6] = "Mana Tide Totem·Spell_Nature_Windfury·20·",
					[7] = "Water Walking·Spell_Frost_WindWalkOn·",
					[8] = "Water Breathing·Spell_Shadow_DemonBreath·",
					[9] = "Sentry Totem·Spell_Nature_RemoveCurse·",
					[10] = "Nature Resistance Totem·Spell_Nature_NatureResistanceTotem·20·",
					[11] = "Frost Resistance Totem·Spell_FrostResistanceTotem_01·20·",
					[12] = "Fire Resistance Totem·Spell_FireResistanceTotem_01·20·",
				},
				[2] = {
					[1] = "Tranquil Air Totem·Spell_Nature_Brilliance·",
					[2] = "Nature's Swiftness·Spell_Nature_RavenForm·",
					[4] = "Flametongue Weapon·Spell_Fire_FlameTounge·20·",
					[5] = "Frostbrand Weapon·Spell_Frost_FrostBrand·20·",
					[6] = "Rockbiter Weapon·Spell_Nature_RockBiter·20·",
					[7] = "Windfury Weapon·Spell_Nature_Cyclone·20·",
					[8] = "Stoneclaw Totem·Spell_Nature_StoneClawTotem·20·",
					[9] = "Stoneskin Totem·Spell_Nature_StoneSkinTotem·20·",
					[10] = "Strength of Earth Totem·Spell_Nature_EarthBindTotem·20·",
					[11] = "Grace of Air Totem·Spell_Nature_InvisibilityTotem·20·",
					[12] = "Windfury Totem·Spell_Nature_Windfury·20·",
				},
				[3] = {
					[1] = "Healing Stream Totem·INV_Spear_04·20·",
					[2] = "Mana Spring Totem·Spell_Nature_ManaRegenTotem·20·",
					[3] = "Grounding Totem·Spell_Nature_GroundingTotem·",
					[5] = "Poison Cleansing Totem·Spell_Nature_PoisonCleansingTotem·",
					[6] = "Tremor Totem·Spell_Nature_TremorTotem·",
					[7] = "Far Sight·Spell_Nature_FarSight·",
					[10] = "Astral Recall·Spell_Nature_AstralRecal·",
				},
				[4] = {
				},
				[5] = {
				},
				[6] = {
					[3] = "Purge·Spell_Nature_Purge·20·",
					[4] = "Lightning Shield·Spell_Nature_LightningShield·20·",
					[6] = "Lightning Bolt·Spell_Nature_Lightning·20·",
					[10] = "Ghost Wolf·Spell_Nature_SpiritWolf·",
					[9] = "Lightning Bolt·Spell_Nature_Lightning·20·",
					[11] = "Disease Cleansing Totem·Spell_Nature_DiseaseCleansingTotem·",
				},
				[7] = {
				},
				[8] = {
				},
				[9] = {
s				},
				[0] = {
					[1] = "Attack·INV_Hammer_22·",
					[2] = {"Elemental Mastery·Spell_Nature_WispHeal·", "Stormstrike·Spell_Nature_WispHeal·",},
					[3] = "Chain Lightning·Spell_Nature_ChainLightning·20·",
					[4] = "Frost Shock·Spell_Frost_FrostShock·20·",
					[5] = "Earth Shock·Spell_Nature_EarthShock·20·",
					[6] = "Flame Shock·Spell_Fire_FlameShock·20·",
					[7] = "Lesser Healing Wave·Spell_Nature_HealingWaveLesser·20·",
					[8] = "Healing Wave·Spell_Nature_MagicImmunity·20·",
					[9] = "Chain Heal·Spell_Nature_HealingWaveGreater·20·",
					[10] = "Cure Disease·Spell_Nature_RemoveDisease·",
					[11] = "Cure Poison·Spell_Nature_NullifyPoison·",
					[12] = "Ancestral Spirit·Spell_Nature_Regenerate·20·",
				},
			}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 51, 55, 120, 77, nil, nil)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_Basic()
    local testSASInfo = { [0] = {}, [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {},}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
	if (MazzleUI_LastAspect == 3) then
        testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 93, 97, 120, 84, 83, nil, 88)
	elseif (MazzleUI_LastAspect == 2) then
        testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 79, 83, 120, 70, 69, nil, 74)
	else
        testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 79, 83, 120, 70, 69, nil, 74)
	end
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_Big()
    local testSASInfo = { [0] = {}, [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {},}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
	if (MazzleUI_LastAspect == 3) then
        testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 109, 113, 120, 70, 69, nil, 104)
	elseif (MazzleUI_LastAspect == 2) then
        testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 89, 93, 120, 80, 79, nil, 84)
	else
        testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 79, 83, 120, 70, 69, nil, 74)
	end
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_SimpleRogue()
    local testSASInfo = { [0] = {}, [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {},}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo[9][11] = "Stealth·Ability_Stealth·3·"
    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 69, 73, 120, 59, 60, nil,64)
    Mazzify_SASLoad(testSASInfo)
end

function Setup_SAS_SimpleWarriorDruid()
    local testSASInfo = { [0] = {}, [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {},}
	-- tradeStart, skillStart, mountIndex, racialIndex, racial2Index, oilIndex
    testSASInfo[9] = {
					[9] = {"Berserker Stance·Ability_Racial_Avatar·", "Cat Form·Ability_Druid_CatForm·",},
					[10] = {"Defensive Stance·Ability_Warrior_DefensiveStance·", "Aquatic Form·Ability_Druid_AquaticForm·",},
					[11] = {"Battle Stance·Ability_Warrior_OffensiveStance·", "Dire Bear Form·Ability_Racial_BearForm·", "Bear Form·Ability_Racial_BearForm·",},
					[8] = "Travel Form·Ability_Druid_TravelForm·",
					[7] = "Moonkin Form·Ability_Druid_CatForm·",
					[6] = "Tree Form·Ability_Druid_CatForm·",
					}

    testSASInfo = Setup_SAS_AddUniversals(testSASInfo, 105, 109, 120, 95, 96, nil,100)
    Mazzify_SASLoad(testSASInfo)
end

