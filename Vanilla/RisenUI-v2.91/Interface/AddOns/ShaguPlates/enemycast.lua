if ( GetLocale() == "deDE" ) then
	-- use deDE locales
	ShaguPlatesCastBar_Spells = {
		-- All Classes
			-- General
		["Ruhestein"] = {t=10.0, icon="INV_Misc_Rune_01" };
		["Rauhe Kupferbombe"] = {t=1, ni=1};
		["Gro\195\159e Kupferbombe"] = {t=1, ni=1};
		["Kleine Bronzebombe"] = {t=1, ni=1};
		["Gro\195\159e Bronzebombe"] = {t=1, ni=1};
		["Eisengranate"] = {t=1, ni=1};
		["Gro\195\159e Eisenbombe"] = {t=1, ni=1};
		["Mithrilschrapnellbombe"] = {t=1, ni=1};
		["Hochexplosive Bombe"] = {t=1, ni=1};
		["Thoriumgranate"] = {t=1, ni=1};
		["Dunkeleisenbombe"] = {t=1, ni=1};
		["Arkane Bombe"] = {t=1, ni=1};
		["Schlaf"] = {t=1.5, ni=1};
		["Tollk\195\188hner Ansturm"] = {t=0};
		["Dunkle Besserung"] = {t=2, icon="Spell_Shadow_ChillTouch" };

			-- First Aid
		["Erste Hilfe"] = {t=8.0, icon="Spell_Holy_Heal" };
		["Leinenstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_15" };
		["Schwerer Leinenstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_15" };
		["Wollstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_14" };
		["Schwerer Wollstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_14" };
		["Seidenstoffverbannd"] = {t=3.0, icon="INV_Misc_Bandage_01" };
		["Schwerer Seidenstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_02" };
		["Magiestoffverbannd"] = {t=3.0, icon="INV_Misc_Bandage_19" };
		["Schwerer Magiestoffverband"] = {t=3.0, icon="INV_Misc_Bandage_20" };
		["Runenstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_11" };
		["Schwerer Runenstoffverband"] = {t=3.0, icon="INV_Misc_Bandage_11" };
		
		-- Druid
		["Heilende Ber\195\188hrung"] = {t=3.0, icon="Spell_Nature_HealingTouch" };
		["Nachwachsen"] = {t=2.0, g=21.0, icon="Spell_Nature_ResistNature" };
		["Wiedergeburt"] = {t=2.0, d=1800.0, icon="Spell_Nature_Reincarnation" };
		["Sternenfeuer"] = {t=3, icon="Spell_Arcane_StarFire" };
		["Zorn"] = {t=1.5, icon="Spell_Nature_AbolishMagic" };
		["Wucherwurzeln"] = {t=1.5, icon="Spell_Nature_StrangleVines" };
		["Winterschlaf"] = {t=1.5, icon="Spell_Nature_Sleep" };
		["Tier bes\195\164nftigen"] = {t=1.5, icon="Ability_Hunter_BeastSoothe" };
		["Baumrinde"] = {t=0, icon="Spell_Nature_StoneClawTotem" };
		["Teleportieren: Moonglade"] = {t=10.0, icon="Spell_Arcane_TeleportMoonglade" };
		["Reisegestalt"] = {t=0};
		["Terrorb\195\164rengestalt"] = {t=0};
		["Katzengestalt"] = {t=0};
		["B\195\164rengestalt"] = {t=0};
		["Moonkingestalt"] = {t=0};
		["Wassergestalt"] = {t=0};
		["Wilde Attacke"] = {t=0, icon="Ability_Hunter_Pet_Bear" };
		["Hieb"] = {t=0, icon="Ability_Druid_Bash" };
		["Sternenfeuerbet\195\164ubung"] = {t=0, icon="Spell_Arcane_StarFire" };
		["Anspringen"] = {t=0, icon="Ability_Druid_SupriseAttack" };
		["Schnelligkeit der Natur"] = {t=0};
		
		-- Hunter
		["Gezielter Schuss"] = {t=3.0, icon="INV_Spear_07" };
		["Wildtier \195\164ngstigen"] = {t=1.5, icon="Ability_Druid_Cower" };
		["Tier freigeben"] = {t=5.0, icon="Spell_Nature_SpiritWolf" };
		["Tier wiederbeleben"] = {t=10.0, icon="Ability_Hunter_BeastSoothe" };
		["Augen des Wildtiers"] = {t=2.0, icon="Ability_EyeOfTheOwl" };
		["Streuschuss"] = {t=0, icon="Ability_GolemStormBolt" };
		["Eisk\195\164ltefalle"] = {t=0, icon="Spell_Frost_ChainsOfIce" };
		["Einsch\195\188chterung"] = {t=0};
		["Wyverngift"] = {t=0};
		
		-- Mage
		["Frostblitz"] = {t=2.5, icon="Spell_Frost_FrostBolt02" };
		["Feuerball"] = {t=3.0, icon="Spell_Fire_FlameBolt" };
		["Wasser herbeizaubern"] = {t=3.0, icon="INV_Drink_18" };
		["Essen herbeizaubern"] = {t=3.0, icon="INV_Misc_Food_33" };
		["Manarubin herbeizaubern"] = {t=3.0, icon="INV_Misc_Gem_Ruby_01" };
		["Manacitrin herbeizaubern"] = {t=3.0, icon="INV_Misc_Gem_Opal_01" };
		["Manajade herbeizaubern"] = {t=3.0, icon="INV_Misc_Gem_Emerald_02" };
		["Manaachat herbeizaubern"] = {t=3.0, icon="INV_Misc_Gem_Emerald_01" };
		["Verwandlung"] = {t=1.5, icon="Spell_Nature_Polymorph" };
		["Verwandlung: Schwein"] = {t=1.5, icon="Spell_Nature_Polymorph" };
		["Verwandlung: Schildkr\195\182te"] = {t=1.5, icon="Spell_Nature_Polymorph" };
		["Pyroschlag"] = {t=6.0, d=60.0, icon="Spell_Fire_Fireball02" };
		["Versenegen"] = {t=1.5, icon="Spell_Fire_SoulBurn" };
		["Flammensto\195\159"] = {t=3.0, r="Death Talon Hatcher", a=2.5, icon="Spell_Fire_SelfDestruct" };
		["Langsamer Fall"] = {t=0, c="gains", icon="Spell_Magic_FeatherFall" };
		["Portal: Darnassus"] = {t=10.0, icon="Spell_Arcane_PortalDarnassus" };
		["Portal: Thunder Bluff"] = {t=10.0, icon="Spell_Arcane_PortalThunderBluff" };
		["Portal: Ironforge"] = {t=10.0, icon="Spell_Arcane_PortalIronForge" };
		["Portal: Orgrimmar"] = {t=10.0, icon="Spell_Arcane_PortalOrgrimmar" };
		["Portal: Stormwind"] = {t=10.0, icon="Spell_Arcane_PortalStormWind" };
		["Portal: Undercity"] = {t=10.0, icon="Spell_Arcane_PortalUnderCity" };
		["Teleportieren: Darnassus"] = {t=10.0, icon="Spell_Arcane_TeleportDarnassus" };
		["Teleportieren: Thunder Bluff"] = {t=10.0, icon="Spell_Arcane_TeleportThunderBluff" };
		["Teleportieren: Ironforge"] = {t=10.0, icon="Spell_Arcane_TeleportIronForge" };
		["Teleportieren: Orgrimmar"] = {t=10.0, icon="Spell_Arcane_TeleportOrgrimmar" };
		["Teleportieren: Stormwind"] = {t=10.0, icon="Spell_Arcane_TeleportStormWind" };
		["Teleportieren: Undercity"] = {t=10.0, icon="Spell_Arcane_TeleportUnderCity" };
		["Impact"] = {t=0};
		["Feuerzauberschutz"] = {t=0.0, icon="Spell_Fire_FireArmor" };
		["Frostzauberschutz"] = {t=0.0, icon="Spell_Frost_FrostWard" };
		["Frostr\195\188stung"] = {t=0.0};
		["Eisr\195\188stung"] = {t=0.0};
		["Magische R\195\188stung"] = {t=0.0};
		["Gegenzauber - zum Schweigen gebracht"] = {t=0.0, ni=1, icon="Spell_Frost_IceShock" };
		["Eisbarriere"] = {t=0.0, icon="Spell_Ice_Lament" };
		["Manaschild"] = {t=0.0};
		["Blinzeln"] = {t=0, icon="Spell_Arcane_Blink" };
		["Eisblock"] = {t=0, icon="Spell_Frost_Frost" };
		
		-- Paladin
		["Siegel der Weisheit"] = {t=0};
		["Siegel des Lichts"] = {t=0};
		["Siegel der Rechtschaffenheit"] = {t=0};
		["Siegel des Befehls"] = {t=0};
		["Siegel des Kreuzfahrers"] = {t=0};
		["Siegel der Gerechtigkeit"] = {t=0};
		["Zorn der Gerechtigkeit"] = {t=0, icon="Spell_Nature_AbolishMagic" };
		["Heiliges Licht"] = {t=2.5, icon="Spell_Holy_HolyBolt" };
		["Lichtblitz"] = {t=1.5, icon="Spell_Holy_FlashHeal" };
		["Streitross beschw\195\182ren"] = {t=3.0, g=0.0, icon="Ability_Mount_Charger" };
		["Schlachtross beschw\195\182ren"] = {t=3.0, g=0.0, icon="Spell_Nature_Swiftness" };
		["Hammer des Zorns"] = {t=1.0, d=6.0, icon="Spell_Nature_AbolishMagic" };
		["Heiliger Zorn"] = {t=2.0, d=60.0, icon="Spell_Nature_AbolishMagic" };
		["Untote vertreiben"] = {t=1.5, d=30.0, icon="Spell_Holy_TurnUndead" };
		["Erl\195\182sung"] = {t=10.0, icon="Spell_Holy_Resurrection" };
		["G\195\182ttlicher Schutz"] = {t=0, icon="Spell_Holy_Restoration" };
		["Gottesschild"] = {t=0, icon="Spell_Holy_DivineIntervention" };
		["Hammer der Gerechtigkeit"] = {t=0, icon="Spell_Holy_SealOfMight" };
		
		-- Priest
		["Gro\195\159e Heilung"] = {t=2.5, icon="Spell_Holy_GreaterHeal" };
		["Blitzheilung"] = {t=1.5, icon="Spell_Holy_FlashHeal" };
		["Geringes Heilen"] = {t=1.5, icon="Spell_Holy_LesserHeal" };
		["Heilen"] = {t=2.5, icon="Spell_Nature_HealingTouch" };
		["Auferstehung"] = {t=10.0, icon="Spell_Holy_Resurrection" };
		["G\195\182ttliche Pein"] = {t=2, icon="Spell_Holy_HolySmite" };
		["Gedankenschlag"] = {t=1.5, d=8.0, icon="Spell_Shadow_UnholyFrenzy" };
		["Gedankenkontrolle"] = {t=3.0, icon="Spell_Shadow_ShadowWordDominate" };
		["Manabrand"] = {t=2.5, icon="Spell_Shadow_ManaBurn" };
		["Heiliges Feuer"] = {t=3.0, d=15.0, icon="Spell_Holy_SearingLight" };
		["Gedankenbes\195\164nftigung"] = {t=0, icon="Spell_Holy_MindSooth" };
		["Gebet der Heilung"] = {t=3.0, icon="Spell_Holy_PrayerOfHealing02" };
		["Untote fesseln"] = {t=1.5, icon="Spell_Nature_Slow" };
		["Verblassen"] = {t=0, icon="Spell_Magic_LesserInvisibilty" };
		["Psychischer Schrei"] = {t=0.0, icon="Spell_Shadow_PsychicScream" };
		["Stille"] = {t=0.0, ni = 1, icon="Spell_Shadow_ImpPhaseShift" };
		["Blackout"] = {t=0.0};
		
		-- Rogue
		["Falle entsch\195\164rfen"] = {t=5.0, icon="Spell_Shadow_GrimWard" };
		["Gedankenbenebelndes Gift"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Gedankenbenebelndes Gift II"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Gedankenbenebelndes Gift III"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Sofort wirkendes Gift"] = {t=3.0, icon="Ability_Poisons" };
		["Sofort wirkendes Gift II"] = {t=3.0, icon="Ability_Poisons" };
		["Sofort wirkendes Gift III"] = {t=3.0, icon="Ability_Poisons" };
		["Sofort wirkendes Gift IV"] = {t=3.0, icon="Ability_Poisons" };
		["Sofort wirkendes Gift V"] = {t=3.0, icon="Ability_Poisons" };
		["Sofort wirkendes Gift VI"] = {t=3.0, icon="Ability_Poisons" };
		["T\195\182dliches Gift"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["T\195\182dliches Gift II"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["T\195\182dliches Gift III"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["T\195\182dliches Gift IV"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["T\195\182dliches Gift V"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["Verkr\195\188ppelndes Gift"] = {t=3.0, icon="Ability_PoisonSting" };
		["Schloss knacken"] = {t=5.0, icon="Spell_Nature_MoonKey" };
		["Blenden"] = {t=0, icon="Spell_Shadow_MindSteal" };
		["Solarplexus"] = {t=0, icon="Ability_Gouge" };
		["Nierenhieb"] = {t=0, icon="Ability_Rogue_KidneyShot" };
		["Tritt - zum Schweigen gebracht"] = {t=0, ni=1, icon="Ability_Kick" };
		["Tritt"] = {t=0, ni=1, icon="Ability_Kick" };
		
		-- Shaman
		["Geringe Welle der Heilung"] = {t=1.5, icon="Spell_Nature_HealingWaveLesser" };
		["Welle der Heilung"] = {t=3.0, icon="Spell_Nature_HealingWaveLesser" };
		["Geist der Ahnen"] = {t=10.0, icon="Spell_Nature_Regenerate" };
		["Kettenblitzschlag"] = {t=1.5, d=6.0, icon="Spell_Nature_ChainLightning" };
		["Geisterwolf"] = {t=3.0, icon="Spell_Nature_SpiritWolf" };
		["Astraler R\195\188ckruf"] = {t=10.0, icon="Spell_Nature_AstralRecal" };
		["Kettenheilung"] = {t=2.5, icon="Spell_Nature_HealingWaveGreater" };
		["Blitzschlag"] = {t=2.0, icon="Spell_Nature_Lightning" };
		["Fernsicht"] = {t=2.0, icon="Spell_Nature_FarSight" };
		["Erdschock"] = {t=0, ni=1};
		
		-- Warlock
		["Schattenblitz"] = {t=2.5, icon="Spell_Shadow_ShadowBolt" };
		["Feuerbrand"] = {t=1.5, icon="Spell_Fire_Immolation" };
		["Seelenfeuer"] = {t=4.0, icon="Spell_Fire_Fireball02" };
		["Sengender Schmerz"] = {t=1.5, icon="Spell_Fire_SoulBurn" };
		["Schreckensross herbeirufen"] = {t=3.0, icon="Ability_Mount_Dreadsteed" };
		["Teufelsross beschw\195\182ren"] = {t=3.0, icon="Spell_Nature_Swiftness" };
		["Wichtel beschw\195\182ren"] = {t=6.0, icon="Spell_Shadow_Imp" };
		["Sukkubus beschw\195\182ren"] = {t=6.0, icon="Spell_Shadow_SummonSuccubus" };
		["Leerwandler beschw\195\182ren"] = {t=6.0, icon="Spell_Shadow_SummonVoidWalker" };
		["Teufelsj\195\164ger beschw\195\182ren"] = {t=6.0, icon="Spell_Shadow_SummonFelHunter" };
		["Furcht"] = {t=1.5, icon="Spell_Shadow_Possession" };
		["Schreckensgeheul"] = {t=2.0, icon="Spell_Shadow_DeathScream" };
		["Verbannen"] = {t=1.5, icon="Spell_Shadow_Cripple" };
		["Ritual der Beschw\195\182rung"] = {t=5.0, icon="Spell_Shadow_Twilight" };
		["Ritual der Verdammnis"] = {t=10.0, icon="Spell_Shadow_AntiMagicShell" };
		["Zauberstein herstellen"] = {t=5.0, icon="INV_Misc_Gem_Sapphire_01" };
		["Seelenstein herstellen"] = {t=3.0, icon="Spell_Shadow_SoulGem" };
		["Gesundheitsstein herstellen"] = {t=3.0, icon="INV_Stone_04" };
		["Feuerstein herstellen"] = {t=3.0, icon="INV_Ammo_FireTar" };
		["D\195\164monensklave"] = {t=3.0, icon="Spell_Shadow_EnslaveDemon" };
		["Inferno"] = {t=2.0, icon="Spell_Fire_Incinerate" };
		["Inferno Effect"] = {t=0, icon="Spell_Fire_Incinerate" }; -- test
		["Schatten-Zauberschutz"] = {t=0, icon="Spell_Shadow_AntiShadow" };
		["Todesmantel"] = {t=0.0};
		["Verderbnis"] = {t=0, icon="Spell_Shadow_AbominationExplosion" };
		["D\195\164monenr\195\188stung"] = {t=0};
		["D\195\164monenhaut"] = {t=0};

			-- Succubus
			["Verf\195\188hrung"] = {t=1.5, icon="Spell_Shadow_MindSteal" };
			
			-- Felhunter
			["Zaubersperre"] = {t=0.0, ni=1};

		-- Warrior
		["Sturmangriffsbet\195\164ubung"] = {t=0, icon="Ability_Warrior_Charge" };
		["Bet\195\164ubung abfangen"] = {t=0, icon="Ability_Rogue_Sprint" };
		["Rachebet\195\164ubung"] = {t=0, icon="Ability_Warrior_Revenge" };
		["Streitkolbenbet\195\164ubung"] = {t=0};
		["Durchdringendes Heulen"] = {t=0, icon="Spell_Shadow_DeathScream" };
		["Schildhieb - zum Schweigen gebracht"] = {t=0, icon="Ability_Warrior_ShieldBash" };
		["Schildhieb"] = {t=0, ni=1, icon="Ability_Warrior_ShieldBash" };
		["Zuschlagen"] = {t=0, ni=1};
		
		-- Mobs
		["Schrumpfen"] = {t=3.0, icon="Spell_Ice_MagicDamage" };
		["Bansheefluch"] = {t=2.0, icon="Spell_Nature_Drowsy" };
		["Schattenblitz-Salve"] = {t=3.0, icon="Spell_Shadow_ShadowBolt" };
		["Verkr\195\188ppeln"] = {t=3.0, icon="Ability_PoisonSting" };
		["Dunkle Besserung"] = {t=3.5, icon="Spell_Shadow_ChillTouch" };
		["Willensverfall"] = {t=2.0, icon="Spell_Holy_HarmUndeadAura" };
		["Windsto\195\159"] = {t=2.0, icon="Spell_Nature_EarthBind" };
		["Schwarzer Schlamm"] = {t=3.0, icon="Spell_Shadow_CallofBone" };
		["Toxischer Blitz"] = {t=2.5, icon="Spell_Nature_CorrosiveBreath" };
		["Giftspucke"] = {t=2.0, icon="Spell_Nature_CorrosiveBreath" };
		["Wilde Regeneration"] = {t=3.0, icon="Spell_Nature_Rejuvenation" };
		["Fluch der Totenwaldfelle"] = {t=2.0, icon="Spell_Shadow_GatherShadows" };
		["Blutfluch"] = {t=2.0, icon="Spell_Shadow_RitualOfSacrifice" };
		["Dunkler Schlamm"] = {t=5.0, icon="Spell_Shadow_CreepingPlague" };
		["Seuchenwolke"] = {t=2.0, icon="Spell_Shadow_CallofBone" };
		["Wandernde Seuche"] = {t=2.0, icon="Spell_Shadow_CallofBone" };
		["Welkber\195\188hrung"] = {t=2.0, icon="Spell_Nature_Drowsy" };
		["Fieberhafte Ersch\195\182pfung"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Umschlie\195\159ende Gespinste"] = {t=2.0, icon="Spell_Nature_EarthBind" };
		["Kristallblick"] = {t=2.0, icon="Ability_GolemThunderClap" };
		["Flammenspeien"] = {t=3.0, icon="Spell_Fire_FlameBolt" };
		["Echsenschlag"] = {t=2.0, icon="Spell_Nature_Lightning" };
		["Gedanken verseuchen"] = {t=4.0, icon="Spell_Shadow_CallofBone" };
	}
	ShaguPlatesCastBar_Raids = {
		-- Ahn'Qiraj
			-- 20 Man Trash
			["Explodieren"] = {t=6.0, icon="Spell_Fire_SelfDestruct" };
		-- Blackwing Lair
			-- Firemaw/Flamegor/Ebonroc
			["Schattenflamme"] = {t=2.0, c="hostile", icon="Spell_Fire_Incinerate" };
			["Fl\195\188gelsto\195\159"] = {t=1.0, c="hostile", icon="INV_Misc_MonsterScales_14" };
			-- Neferian/Onyxia
			["Dr\195\182hnendes Gebr\195\188ll"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, icon="Spell_Shadow_Charm" };
	}
	ShaguPlatesCastBar_NonAfflictions = {
		["Frostblitz"] = true;
		["Feuerball"] = true;
		["Pyroschlag"] = true;
		["Wucherwurzeln"] = true;
		["Tier bes\195\164nftigen"] = true;
		["Gedankenbes\195\164nftigung"] = true;
		["Feuerbrand"] = true;
		["Verderbnis"] = true;
		["Nachwachsen"] = true;
		["Gedankenkontrolle"] = true;
		["Heiliges Feuer"] = true;
		["Gro\195\159e Heilung"] = true;
	}
	ShaguPlatesCastBar_Interrupts = {
		["Schildhieb"] = true;
		["Zuschlagen"] = true;
		["Tritt"] = true;
		["Erdschock"] = true;
	}

	ShaguPlatesCastBar_SPELL_GAINS 				= "(.+) bekommt (.+)."
	ShaguPlatesCastBar_SPELL_CAST 				= "(.+) beginnt (.+) zu wirken."
	ShaguPlatesCastBar_SPELL_PERFORM				= "(.+) beginnt (.+) auszuf\195\188hren."
	ShaguPlatesCastBar_SPELL_AFFLICTED			= "(.+) ist von (.+) betroffen."
	ShaguPlatesCastBar_SPELL_HIT					= "(.+) von Euch trifft (.+) f\195\188r %d+\."
	ShaguPlatesCastBar_OTHER_SPELL_HIT			= "%a+'s (.+) trifft (.+) f\195\188r %d+\."

else
	-- fallack to enGB
	ShaguPlatesCastBar_Spells = {
		-- All Classes
			-- General
		["Hearthstone"] = {t=10.0, icon="INV_Misc_Rune_01" };
		["Rough Copper Bomb"] = {t=1, ni=1};
		["Large Copper Bomb"] = {t=1, ni=1};
		["Small Bronze Bomb"] = {t=1, ni=1};
		["Big Bronze Bomb"] = {t=1, ni=1};
		["Iron Grenade"] = {t=1, ni=1};
		["Big Iron Bomb"] = {t=1, ni=1};
		["Mithril Frag Bomb"] = {t=1, ni=1};
		["Hi-Explosive Bomb"] = {t=1, ni=1};
		["Thorium Grenade"] = {t=1, ni=1};
		["Dark Iron Bomb"] = {t=1, ni=1};
		["Arcane Bomb"] = {t=1, ni=1};
		["Sleep"] = {t=1.5, ni=1, icon="Spell_Nature_Sleep" };
		["Reckless Charge"] = {t=0};
		["Dark Mending"] = {t=2, icon="Spell_Shadow_ChillTouch" };

			-- First Aid
		["First Aid"] = {t=8.0, icon="Spell_Holy_Heal" };
		["Linen Bandage"] = {t=3.0, icon="INV_Misc_Bandage_15" };
		["Heavy Linen Bandage"] = {t=3.0, icon="INV_Misc_Bandage_15" };
		["Wool Bandage"] = {t=3.0, icon="INV_Misc_Bandage_14" };
		["Heavy Wool Bandage"] = {t=3.0, icon="INV_Misc_Bandage_14" };
		["Silk Bandage"] = {t=3.0, icon="INV_Misc_Bandage_01" };
		["Heavy Silk Bandage"] = {t=3.0, icon="INV_Misc_Bandage_01" };
		["Mageweave Bandage"] = {t=3.0, icon="INV_Misc_Bandage_19" };
		["Heavy Mageweave Bandage"] = {t=3.0, icon="INV_Misc_Bandage_19" };
		["Runecloth Bandage"] = {t=3.0, icon="INV_Misc_Bandage_11" };
		["Heavy Runecloth Bandage"] = {t=3.0, icon="INV_Misc_Bandage_11" };
		
		-- Druid
		["Healing Touch"] = {t=3.0, icon="Spell_Nature_HealingTouch" };
		["Regrowth"] = {t=2.0, g=21.0, icon="Spell_Nature_ResistNature" };
		["Rebirth"] = {t=2.0, d=1800.0, icon="Spell_Nature_Reincarnation" };
		["Starfire"] = {t=3, icon="Spell_Arcane_StarFire" };
		["Wrath"] = {t=1.5, icon="Spell_Nature_NaturesWrath" };
		["Entangling Roots"] = {t=1.5, icon="Spell_Nature_StrangleVines" };
		["Hibernate"] = {t=1.5, icon="Spell_Nature_Sleep" };
		["Soothe Animal"] = {t=1.5, icon="Ability_Hunter_BeastSoothe" };
		["Barkskin"] = {t=0, icon="Spell_Nature_StoneClawTotem" };
		["Teleport: Moonglade"] = {t=10.0, icon="Spell_Arcane_TeleportMoonglade" };
		["Travel Form"] = {t=0};
		["Dire Bear Form"] = {t=0};
		["Cat Form"] = {t=0};
		["Bear Form"] = {t=0};
		["Moonkin Form"] = {t=0};
		["Aquatic Form"] = {t=0};
		["Feral Charge Effect"] = {t=0};
		["Bash"] = {t=0, icon="Ability_Warrior_ShieldBash" };
		["Starfire Stun"] = {t=0, icon="Spell_Arcane_StarFire" };
		["Pounce"] = {t=0, icon="Ability_Druid_SupriseAttack" };
		["Nature's Swiftness"] = {t=0};
		
		-- Hunter
		["Aimed Shot"] = {t=3.0, icon="INV_Spear_07" };
		["Scare Beast"] = {t=1.5, icon="Ability_Druid_Cower" };
		["Dismiss Pet"] = {t=5.0, icon="Spell_Nature_SpiritWolf" };
		["Revive Pet"] = {t=10.0, icon="Ability_Hunter_BeastSoothe" };
		["Eyes of the Beast"] = {t=2.0, icon="Ability_EyeOfTheOwl" };
		["Scatter Shot"] = {t=0, icon="Ability_GolemStormBolt" };
		["Freezing Trap Effect"] = {t=0, icon="Spell_Frost_ChainsOfIce" };
		["Intimidation"] = {t=0};
		["Wyvern Sting"] = {t=0, icon="INV_Spear_02" };
		
		-- Mage
		["Frostbolt"] = {t=2.5, icon="Spell_Frost_FrostBolt02" };
		["Fireball"] = {t=3.0, icon="Spell_Fire_Fireball02" };
		["Conjure Water"] = {t=3.0, icon="INV_Drink_18" };
		["Conjure Food"] = {t=3.0, icon="INV_Misc_Food_33" };
		["Conjure Mana Ruby"] = {t=3.0, icon="INV_Misc_Gem_Ruby_01" };
		["Conjure Mana Citrine"] = {t=3.0, icon="INV_Misc_Gem_Opal_01" };
		["Conjure Mana Jade"] = {t=3.0, icon="INV_Misc_Gem_Emerald_02" };
		["Conjure Mana Agate"] = {t=3.0, icon="INV_Misc_Gem_Emerald_01" };
		["Polymorph"] = {t=1.5, icon="Spell_Nature_Polymorph" };
		["Polymorph: Pig"] = {t=1.5, icon="Spell_Nature_Polymorph" };
		["Polymorph: Turtle"] = {t=1.5, icon="Spell_Nature_Polymorph" };
		["Pyroblast"] = {t=6.0, d=60.0, icon="Spell_Fire_Fireball02" };
		["Scorch"] = {t=1.5, icon="Spell_Fire_SoulBurn" };
		["Flamestrike"] = {t=3.0, r="Death Talon Hatcher", a=2.5, icon="Spell_Fire_SelfDestruct" };
		["Slow Fall"] = {t=0, c="gains", icon="Spell_Magic_FeatherFall" };
		["Portal: Darnassus"] = {t=10.0, icon="Spell_Arcane_PortalDarnassus" };
		["Portal: Thunder Bluff"] = {t=10.0, icon="Spell_Arcane_PortalThunderBluff" };
		["Portal: Ironforge"] = {t=10.0, icon="Spell_Arcane_PortalIronForge" };
		["Portal: Orgrimmar"] = {t=10.0, icon="Spell_Arcane_PortalOrgrimmar" };
		["Portal: Stormwind"] = {t=10.0, icon="Spell_Arcane_PortalStormWind" };
		["Portal: Undercity"] = {t=10.0, icon="Spell_Arcane_PortalUnderCity" };
		["Teleport: Darnassus"] = {t=10.0, icon="Spell_Arcane_TeleportDarnassus" };
		["Teleport: Thunder Bluff"] = {t=10.0, icon="Spell_Arcane_TeleportThunderBluff" };
		["Teleport: Ironforge"] = {t=10.0, icon="Spell_Arcane_TeleportIronForge" };
		["Teleport: Orgrimmar"] = {t=10.0, icon="Spell_Arcane_TeleportOrgrimmar" };
		["Teleport: Stormwind"] = {t=10.0, icon="Spell_Arcane_TeleportStormWind" };
		["Teleport: Undercity"] = {t=10.0, icon="Spell_Arcane_TeleportUnderCity" };
		["Impact"] = {t=0};
		["Fire Ward"] = {t=0.0, icon="Spell_Fire_FireArmor" };
		["Frost Ward"] = {t=0.0, icon="Spell_Frost_FrostWard" };
		["Frost Armor"] = {t=0.0};
		["Ice Armor"] = {t=0.0};
		["Mage Armor"] = {t=0.0};
		["Counterspell - Silenced"] = {t=0.0, ni=1, icon="Spell_Frost_IceShock" };
		["Ice Barrier"] = {t=0.0, icon="Spell_Ice_Lament" };
		["Mana Shield"] = {t=0.0};
		["Blink"] = {t=0, icon="Spell_Arcane_Blink" };
		["Ice Block"] = {t=0, icon="Spell_Frost_Frost" };
		
		-- Paladin
		["Seal of Wisdom"] = {t=0};
		["Seal of Light"] = {t=0};
		["Seal of Righteousness"] = {t=0};
		["Seal of Command"] = {t=0};
		["Seal of the Crusader"] = {t=0};
		["Seal of Justice"] = {t=0};
		["Righteous Fury"] = {t=0};
		["Holy Light"] = {t=2.5, icon="Spell_Holy_HolyBolt" };
		["Flash of Light"] = {t=1.5, icon="Spell_Holy_FlashHeal" };
		["Summon Charger"] = {t=3.0, g=0.0, icon="Ability_Mount_Charger" };
		["Summon Warhorse"] = {t=3.0, g=0.0, icon="Spell_Nature_Swiftness" };
		["Hammer of Wrath"] = {t=1.0, d=6.0, icon="Spell_Nature_NaturesWrath" };
		["Holy Wrath"] = {t=2.0, d=60.0, icon="Spell_Nature_NaturesWrath" };
		["Turn Undead"] = {t=1.5, d=30.0, icon="Spell_Holy_TurnUndead" };
		["Redemption"] = {t=10.0, icon="Spell_Holy_Resurrection" };
		["Divine Protection"] = {t=0, icon="Spell_Holy_Restoration" };
		["Divine Shield"] = {t=0, icon="Spell_Holy_DivineIntervention" };
		["Hammer of Justice"] = {t=0, icon="Spell_Holy_SealOfMight" };
		
		-- Priest
		["Greater Heal"] = {t=2.5, icon="Spell_Holy_GreaterHeal" };
		["Flash Heal"] = {t=1.5, icon="Spell_Holy_FlashHeal" };
		["Lesser Heal"] = {t=1.5, icon="Spell_Holy_LesserHeal" };
		["Heal"] = {t=2.5, icon="Spell_Holy_Heal" };
		["Resurrection"] = {t=10.0, icon="Spell_Holy_Resurrection" };
		["Smite"] = {t=2, icon="Spell_Holy_HolySmite" };
		["Mind Blast"] = {t=1.5, d=8.0, icon="Spell_Shadow_UnholyFrenzy" };
		["Mind Control"] = {t=3.0, icon="Spell_Shadow_ShadowWordDominate" };
		["Mana Burn"] = {t=2.5, icon="Spell_Shadow_ManaBurn" };
		["Holy Fire"] = {t=3.0, d=15.0, icon="Spell_Holy_SearingLight" };
		["Mind Soothe"] = {t=0, icon="Spell_Holy_MindSooth" };
		["Prayer of Healing"] = {t=3.0, icon="Spell_Holy_Heal" };
		["Shackle Undead"] = {t=1.5, icon="Spell_Nature_Slow" };
		["Fade"] = {t=0, icon="Spell_Magic_LesserInvisibilty" };
		["Psychic Scream"] = {t=0.0, icon="Spell_Shadow_PsychicScream" };
		["Silence"] = {t=0.0, ni = 1, icon="Ability_Warrior_ShieldBash" };
		["Blackout"] = {t=0.0};
		
		-- Rogue
		["Disarm Trap"] = {t=5.0, icon="Spell_Shadow_GrimWard" };
		["Mind-numbing Poison"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Mind-numbing Poison II"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Mind-numbing Poison III"] = {t=3.0, icon="Spell_Nature_NullifyDisease" };
		["Instant Poison"] = {t=3.0, icon="Ability_Poisons" };
		["Instant Poison II"] = {t=3.0, icon="Ability_Poisons" };
		["Instant Poison III"] = {t=3.0, icon="Ability_Poisons" };
		["Instant Poison IV"] = {t=3.0, icon="Ability_Poisons" };
		["Instant Poison V"] = {t=3.0, icon="Ability_Poisons" };
		["Instant Poison VI"] = {t=3.0, icon="Ability_Poisons" };
		["Deadly Poison"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["Deadly Poison II"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["Deadly Poison III"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["Deadly Poison IV"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["Deadly Poison V"] = {t=3.0, icon="Ability_Rogue_DualWeild" };
		["Crippling Poison"] = {t=3.0, icon="Ability_PoisonSting" };
		["Pick Lock"] = {t=5.0, icon="Spell_Nature_MoonKey" };
		["Blind"] = {t=0, icon="Spell_Shadow_MindSteal" };
		["Gouge"] = {t=0, icon="Ability_Gouge" };
		["Kidney Shot"] = {t=0, icon="Ability_Rogue_KidneyShot" };
		["Kick - Silenced"] = {t=0, ni=1, icon="Ability_Warrior_ShieldBash" };
		["Kick"] = {t=0, ni=1, icon="Ability_Kick" };
		
		-- Shaman
		["Lesser Healing Wave"] = {t=1.5, icon="Spell_Holy_Heal" };
		["Healing Wave"] = {t=3.0, icon="Spell_Holy_Heal" };
		["Ancestral Spirit"] = {t=10.0, icon="Spell_Nature_Regenerate" };
		["Chain Lightning"] = {t=1.5, d=6.0, icon="Spell_Nature_ChainLightning" };
		["Ghost Wolf"] = {t=3.0, icon="Spell_Nature_SpiritWolf" };
		["Astral Recall"] = {t=10.0, icon="Spell_Nature_AstralRecal" };
		["Chain Heal"] = {t=2.5, icon="Spell_Holy_Heal" };
		["Lightning Bolt"] = {t=2.0, icon="Spell_Nature_Lightning" };
		["Far Sight"] = {t=2.0, icon="Spell_Nature_FarSight" };
		["Earth Shock"] = {t=0, ni=1};
		
		-- Warlock
		["Shadow Bolt"] = {t=2.5, icon="Spell_Shadow_ShadowBolt" };
		["Immolate"] = {t=1.5, icon="Spell_Fire_Immolation" };
		["Soul Fire"] = {t=4.0, icon="Spell_Fire_Fireball02" };
		["Searing Pain"] = {t=1.5, icon="Spell_Fire_SoulBurn" };
		["Summon Dreadsteed"] = {t=3.0, icon="Ability_Mount_Dreadsteed" };
		["Summon Felsteed"] = {t=3.0, icon="Spell_Nature_Swiftness" };
		["Summon Imp"] = {t=6.0, icon="Spell_Shadow_Imp" };
		["Summon Succubus"] = {t=6.0, icon="Spell_Shadow_SummonSuccubus" };
		["Summon Voidwalker"] = {t=6.0, icon="Spell_Shadow_SummonVoidWalker" };
		["Summon Felhunter"] = {t=6.0, icon="Spell_Shadow_SummonFelHunter" };
		["Fear"] = {t=1.5, icon="Ability_Devour" };
		["Howl of Terror"] = {t=2.0, icon="Spell_Shadow_DeathScream" };
		["Banish"] = {t=1.5, icon="Spell_Shadow_Cripple" };
		["Ritual of Summoning"] = {t=5.0, icon="Spell_Shadow_Twilight" };
		["Ritual of Doom"] = {t=10.0, icon="Spell_Shadow_AntiMagicShell" };
		["Create Spellstone"] = {t=5.0, icon="INV_Misc_Gem_Sapphire_01" };
		["Create Soulstone"] = {t=3.0, icon="Spell_Shadow_SoulGem" };
		["Create Healthstone"] = {t=3.0, icon="Spell_Holy_Heal" };
		["Create Firestone"] = {t=3.0, icon="INV_Ammo_FireTar" };
		["Enslave Demon"] = {t=3.0, icon="Spell_Shadow_EnslaveDemon" };
		["Inferno"] = {t=2.0, icon="Spell_Fire_Incinerate" };
		["Inferno Effect"] = {t=0, icon="Spell_Fire_Incinerate" };
		["Shadow Ward"] = {t=0, icon="Spell_Shadow_AntiShadow" };
		["Death Coil"] = {t=0.0};
		["Corruption"] = {t=0, icon="Spell_Shadow_AbominationExplosion" };
		["Demon Armor"] = {t=0};
		["Demon Skin"] = {t=0};

			-- Succubus
			["Seduction"] = {t=1.5, icon="Spell_Shadow_MindSteal" };
			
			-- Felhunter
			["Spell Lock"] = {t=0.0, ni=1};

		-- Warrior
		["Charge Stun"] = {t=0, icon="Ability_Warrior_Charge" };
		["Intercept Stun"] = {t=0, icon="Ability_Rogue_Sprint" };
		["Revenge Stun"] = {t=0, icon="Ability_Warrior_Revenge" };
		["Mace Stun Effect"] = {t=0};
		["Intimidating Shout"] = {t=0, icon="Ability_GolemThunderClap" };
		["Shield Bash - Silenced"] = {t=0, icon="Ability_Warrior_ShieldBash" };
		["Shield Bash"] = {t=0, ni=1, icon="Ability_Warrior_ShieldBash" };
		["Pummel"] = {t=0, ni=1};	
	}
	ShaguPlatesCastBar_Raids = {
		-- Ahn'Qiraj
			-- 20 Man Trash
			["Explode"] = {t=6.0, icon="Spell_Fire_Fire" };
		-- Blackwing Lair
			-- Firemaw/Flamegor/Ebonroc
			["Shadow Flame"] = {t=2.0, c="hostile", icon="Spell_Fire_Incinerate" };
			["Wing Buffet"] = {t=1.0, c="hostile", icon="INV_Misc_MonsterScales_14" };
			-- Neferian/Onyxia
			["Bellowing Roar"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, icon="Spell_Shadow_Charm" };
	}
	ShaguPlatesCastBar_NonAfflictions = {
		["Frostbolt"] = true;
		["Fireball"] = true;
		["Pyroblast"] = true;
		["Entangling Roots"] = true;
		["Soothe Animal"] = true;
		["Mind Soothe"] = true;
		["Immolate"] = true;
		["Corruption"] = true;
		["Regrowth"] = true;
		["Mind Control"] = true;
		["Holy Fire"] = true;
		["Greater Heal"] = true;
	}
	ShaguPlatesCastBar_Interrupts = {
		["Shield Bash"] = true;
		["Pummel"] = true;
		["Kick"] = true;
		["Earth Shock"] = true;
	}

	ShaguPlatesCastBar_SPELL_GAINS 				= "(.+) gains (.+)."
	ShaguPlatesCastBar_SPELL_CAST 				= "(.+) begins to cast (.+)."
	ShaguPlatesCastBar_SPELL_PERFORM				= "(.+) begins to perform (.+)."
	ShaguPlatesCastBar_SPELL_AFFLICTED			= "(.+) (.+) afflicted by (.+)."
	ShaguPlatesCastBar_SPELL_HIT					= "Your (.+) %a%a?its (.+) for %d+\."
	ShaguPlatesCastBar_OTHER_SPELL_HIT			= "%a+'s (.+) %a%a?its (.+) for %d+\."
end


ShaguPlates.CasterDB = {}
ShaguPlates.Enemycastbar = CreateFrame("Frame")

ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
ShaguPlates.Enemycastbar:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");

ShaguPlates.Enemycastbar:SetScript("OnEvent", function()
	if (arg1 ~= nil) then
		for mob, spell in string.gfind(arg1, ShaguPlatesCastBar_SPELL_CAST) do
			ShaguPlatesCastBar_Control(mob, spell, "casts")
			return
		end	
		for mob, spell in string.gfind(arg1, ShaguPlatesCastBar_SPELL_PERFORM) do
			ShaguPlatesCastBar_Control(mob, spell, "performs")
			return
		end
		for mob, spell in string.gfind(arg1, ShaguPlatesCastBar_SPELL_GAINS) do
			ShaguPlatesCastBar_Control(mob, spell, "gains")
			return
		end
		if ( GetLocale() == "deDE") then
			for mob, spell in string.gfind(arg1, ShaguPlatesCastBar_SPELL_AFFLICTED) do
				ShaguPlatesCastBar_Control(mob, spell, "afflicted")
				return
			end
		else
			for mob, crap, spell in string.gfind(arg1, ShaguPlatesCastBar_SPELL_AFFLICTED) do
				ShaguPlatesCastBar_Control(mob, spell, "afflicted")
				return
			end
		end
		for spell, mob in string.gfind(arg1, ShaguPlatesCastBar_SPELL_HIT) do
			ShaguPlatesCastBar_Control(mob, spell, "hit")
			return
		end
		for spell, mob in string.gfind(arg1, ShaguPlatesCastBar_OTHER_SPELL_HIT) do
			ShaguPlatesCastBar_Control(mob, spell, "hit")
			return
		end
	end
end)

function ShaguPlatesCastBar_Control(mob, spell, special)
	if ShaguPlatesCastBar_Raids[spell] ~= nil then
		castime = ShaguPlatesCastBar_Raids[spell].t
		-- Spell might have the same name but a different cast time on another mob, ie. Onyxia/Nefarian on Bellowing Roar
		if ShaguPlatesCastBar_Raids[spell].r then
			if (mob == ShaguPlatesCastBar_Raids[spell].r) then
				castime = ShaguPlatesCastBar_Raids[spell].a
			end
		end
		if ShaguPlatesCastBar_Raids[spell].m then
			mob = ShaguPlatesCastBar_Raids[spell].m
		end
    if ShaguPlatesCastBar_Raids[spell].icon then
      icon = ShaguPlatesCastBar_Raids[spell].icon
    else
			icon = nil
		end
		ShaguPlatesCastBar_Show(mob, spell, castime, icon)
	else
		if ShaguPlatesCastBar_Spells[spell] ~= nil and special ~= "hit" then
			if special == "afflicted" then
				if not ShaguPlatesCastBar_NonAfflictions[spell] then
					ShaguPlatesCastBar_Hide(mob, spell)
				end
				return
			end
			castime = ShaguPlatesCastBar_Spells[spell].t
			if special == "gains" then
				if not ShaguPlatesCastBar_NonAfflictions[spell] then
					ShaguPlatesCastBar_Hide(mob, spell)
				end
				return
			end
			-- Spell might have the same name but a different cast time on another mob, ie. Death Talon Hatchers/Players on Bellowing Roar
			if ShaguPlatesCastBar_Spells[spell].r then
				if mob == ShaguPlatesCastBar_Spells[spell].r then
					castime = ShaguPlatesCastBar_Spells[spell].a
				end
			end
	      if ShaguPlatesCastBar_Spells[spell].icon then
		icon = ShaguPlatesCastBar_Spells[spell].icon
	      else
				icon = nil
			end
			ShaguPlatesCastBar_Show(mob, spell, castime, icon)
		elseif ShaguPlatesCastBar_Interrupts[spell] then
			if ShaguPlates.CasterDB[mob] and ShaguPlates.CasterDB[mob].ct > 0 then
				ShaguPlatesCastBar_Hide(mob, spell)
				return
			end
		end
	end
end

function ShaguPlatesCastBar_Show(mob, spell, castime, icon)
	ShaguPlates.CasterDB[mob] = {sp = spell, st = GetTime(), ct = castime, ic = icon}
end

function ShaguPlatesCastBar_Hide(mob, spell)
	if ShaguPlates.CasterDB[mob] and not (ShaguPlatesCastBar_Spells[spell].ni and ShaguPlatesCastBar_Spells[ShaguPlates.CasterDB[mob].sp].ni) then
		ShaguPlates.CasterDB[mob]["ct"] = 0
	end
end