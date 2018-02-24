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

Mazz3D_ImportVersion = 0.50

function Setup_Mazz3D()

Mazz3D_ModelDB = {
	["Creature.FelBat.BatTaxi"] = 1,
	["Creature.GnomeSpidertank.GnomeBomBot"] = 2,
	["Creature.NIAN.Nian"] = 3,
	["Creature.UndeadHorse.UndeadHorse"] = 4,
	["Creature.ReinDeer.ReinDeer"] = 5,
	["Creature.Salamander.SalamanderMale"] = 6,
	["Creature.CryptLord.CryptLord"] = 7,
	["Creature.Troll.TrollForestCaster"] = 8,
	["Creature.Gazelle.Gazelle"] = 9,
	["Creature.Felhound.FelHound"] = 238,
	["Creature.SilithidTankBoss.SilithidTankBoss"] = 11,
	["Creature.MountainGiant.MountainGiant"] = 236,
	["Creature.BODYOFKATHUNE.BodyofKathune"] = 13,
	["Creature.ThunderLizard.ThunderLizard"] = 14,
	["Creature.GRYPHON.Gryphon_Ghost"] = 15,
	["Creature.DruidCat.DruidCat"] = 16,
	["Creature.EyeStalkofKathune.EyeStalkofKathune"] = 17,
	["Creature.Succubus.Succubus"] = 18,
	["Creature.GRYPHON.Gryphon"] = 19,
	["Creature.Wight.Wight"] = 20,
	["Creature.DireWolf.DireWolf"] = 221,
	["Creature.Murloc.BabyMurloc"] = 22,
	["Creature.QuirajProphet.QuirajProphet"] = 23,
	["Creature.HumanMaleFarmer.HumanMaleFarmer"] = 220,
	["Creature.FaerieDragon.FaerieDragon_Ghost"] = 25,
	["Creature.FrostSabre.FrostSabre"] = 212,
	["Creature.SILITHID.Silithid"] = 27,
	["Creature.FireElemental.FireElemental"] = 28,
	["Creature.SteamTonk.SteamTonk"] = 214,
	["Creature.Centaur.CentaurWarrior"] = 30,
	["Creature.Satyr.Satyr"] = 31,
	["Creature.MechaStrider.GnomeMechaStrider"] = 32,
	["Creature.HordeRider.HordeRider"] = 33,
	["Creature.Gryphon.Gryphon"] = 205,
	["Creature.HUMLUpperCitizen.HUMLUpperCitizen"] = 35,
	["Creature.HumanFemaleWarriorMedium.HumanFemaleWarriorMedium"] = 36,
	["Creature.SeaLion.SeaLion"] = 37,
	["Creature.ObsidianDestroyer.ObsidianDestroyer"] = 38,
	["Character.Goblin.Female.GoblinFemale"] = 201,
	["Creature.HumanFemaleWarriorHeavy.HumanFemaleWarriorHeavy"] = 166,
	["Creature.HUMSMerchant.HUMSMerchant"] = 41,
	["Creature.Unicorn.Unicorn"] = 42,
	["Creature.HumanMaleWarriorMedium.HumanMaleWarriorMedium"] = 43,
	["Creature.Silithidwasp.SilithidWasp"] = 44,
	["Creature.HumanFemaleBlacksmith.HumanFemaleBlacksmith"] = 45,
	["Creature.Troll.TrollWhelp"] = 46,
	["Creature.Shark.Shark"] = 47,
	["Creature.HumanFemaleMerchantFat.HumanFemaleMerchantFat"] = 48,
	["Creature.ChineseDragon.ChineseDragon"] = 49,
	["Creature.Grell.Grell"] = 50,
	["Creature.SlimeGiant.GiantSlime"] = 196,
	["Creature.HumanMaleGuard.HumanMaleGuard"] = 52,
	["Creature.SkeletalSerpent.SkeletalSerpent"] = 53,
	["Creature.Squirrel.Squirrel"] = 54,
	["Creature.Centaur.Centaur"] = 162,
	["Creature.Tallstrider.TallStrider"] = 183,
	["Creature.RIDINGHORSE.PackMule"] = 57,
	["Creature.Serpent.Serpent"] = 58,
	["Creature.Spells.SentryTotem"] = 59,
	["Creature.HUFMCitizenLow.HUFMCitizenLow"] = 60,
	["Creature.InvisibleStalker.InvisibleStalker"] = 180,
	["Creature.Larva.Larva"] = 62,
	["Creature.Worgen.Worgen"] = 161,
	["Creature.FleshGiant.FleshGiant"] = 64,
	["Creature.PortalofKathune.PortalofKathune"] = 65,
	["Creature.RidingHorse.RidingHorsePvPT2"] = 66,
	["Creature.HumanMaleBlacksmith.HumanMaleBlacksmith"] = 67,
	["Creature.HumanMaleWizard.HumanMaleWizard"] = 68,
	["Creature.tigon.TigonFemale"] = 69,
	["Creature.Troglodyte.Troglodyte"] = 70,
	["Creature.HumanMaleMarshal.HumanMaleMarshal"] = 71,
	["Creature.GolemStone.GolemCannonStone"] = 72,
	["Creature.TempScarletCrusaderHeavy.ScarletCrusaderHeavy"] = 73,
	["Creature.GnollMelee.GnollMelee"] = 74,
	["Creature.Cat.Cat"] = 75,
	["Creature.FrostSabre.RidingFrostSabre"] = 193,
	["Creature.Spells.BattleStandard_Horde"] = 77,
	["Creature.Centaur.CentaurCaster"] = 78,
	["Creature.ClawofKathune.ClawofKathune"] = 79,
	["Creature.MountedDeathKnight.RidingUndeadWarHorse"] = 80,
	["Creature.Murloc.Murloc"] = 81,
	["Creature.DragonSpawnCaster.DragonSpawnCaster"] = 82,
	["Creature.DragonFootSoldier.DragonFootSoldier"] = 198,
	["Creature.Spells.WaterElementalTotem"] = 84,
	["Creature.RidingTurtle.RidingTurtle"] = 85,
	["Creature.SilithidTank.SilithidTank"] = 86,
	["Creature.GnomeSpidertank.GnomePounder"] = 87,
	["Creature.MechaStrider.PvPMechaStrider"] = 88,
	["Character.Human.Female.HumanFemale"] = 89,
	["Creature.MechaStrider.MechaStrider"] = 90,
	["Creature.SILITHIDSCARAB.SilithidScarab"] = 91,
	["Creature.Troll.TrollJungleBoss"] = 92,
	["Creature.bear.Bear"] = 93,
	["Creature.FelBat.BatRider"] = 94,
	["Creature.Hydra.Hydra"] = 95,
	["Creature.Tarantula.Tarantula"] = 96,
	["Creature.DragonSpawn.DragonSpawnGreater"] = 97,
	["Creature.spirithealer.SpiritHealer"] = 98,
	["Creature.HumanMalePeasant.HumanMalePeasantAxe"] = 99,
	["Creature.HumanMalePirateCrewman.HumanMalePirateCrewman"] = 100,
	["Creature.HighElf.HighElfFemale_Mage"] = 101,
	["Creature.ForceOfNature.ForceofNature"] = 102,
	["Creature.GoblinRocketCar.GoblinRocketCar"] = 103,
	["Creature.HumanMaleNoble.HumanMaleNoble"] = 104,
	["Creature.HumanFemaleMerchantThin.HumanFemaleMerchantThin"] = 105,
	["Creature.Dragon.DragonOnyxia"] = 106,
	["Creature.HumanMaleWarriorLight.HumanMaleWarriorLight"] = 107,
	["Creature.AncientOfWar.AncientofWar"] = 108,
	["Creature.FlyingMachineCreature.FlyingMachineCreature"] = 146,
	["Creature.RidingSilithid.RidingSilithid"] = 110,
	["Creature.HumanMalePirateCaptain.HumanMalePirateCaptain"] = 160,
	["Creature.Crab.Crab"] = 153,
	["Creature.Tiger.Tigercub"] = 159,
	["Creature.Hakkar.Hakkar"] = 114,
	["Creature.Necromancer.Necromancer"] = 115,
	["Creature.Horisath.Horisath"] = 116,
	["Creature.GnomeSpidertank.GnomeBot"] = 117,
	["Creature.RidingHorse.RidingHorse"] = 118,
	["Creature.Ogre.OgreWarlord"] = 119,
	["Creature.Shade.ShadeWhite"] = 120,
	["Creature.Spells.BattleStandard_Stormpike_A_01"] = 121,
	["Creature.FelBat.FelBat"] = 122,
	["Creature.tigon.TigonMale"] = 123,
	["Creature.WISP.WispRed"] = 124,
	["Creature.Dragon.DragonNefarian"] = 144,
	["Creature.Ram.RidingRam"] = 126,
	["Creature.Sheep.Sheep"] = 127,
	["Creature.Shade.Shade"] = 128,
	["Character.Orc.Female.OrcFemale"] = 129,
	["Creature.Spells.InvisibilityTotem"] = 130,
	["Creature.Orca.Orca"] = 131,
	["Creature.PrarieDog.PrarieDog"] = 132,
	["Creature.Kodobeast.KodoBeastPvPT2"] = 407,
	["Creature.Snowman.SnowMan"] = 134,
	["Creature.CryptScarab.Crypt_Scarab"] = 135,
	["Character.NightElf.Male.NightElfMale"] = 406,
	["Creature.Cocoon.Cocoon"] = 141,
	["Creature.MouthofKathune01.MouthofKathune01"] = 138,
	["Creature.TitanFemale.TitanFemale"] = 139,
	["Creature.Goblin.Goblin"] = 140,
	["Creature.SkeletonNaked.SkeletonNaked"] = 405,
	["Creature.demonhunter.DemonHunter"] = 142,
	["Creature.Thunderaan.Thunderaan"] = 143,
	["Creature.StormCrow.StormCrow"] = 403,
	["Creature.Owl.Owl"] = 145,
	["Creature.Boar.Boar"] = 402,
	["Creature.RidingRaptor.PvPRidingRaptor"] = 158,
	["Creature.SPELLS.MonsterLure01"] = 133,
	["Creature.NagaMale.NagaMale"] = 149,
	["Creature.GiantSpider.GiantSpider"] = 150,
	["Creature.HUFMCitizenMid.HUFMCitizenMid"] = 151,
	["Creature.BogBeast.BogBeast"] = 113,
	["Creature.SkeletonMage.SkeletonMage"] = 399,
	["Creature.Crocodile.Crocodile"] = 154,
	["Creature.OrcFemaleKid.OrcFemaleKid"] = 111,
	["Creature.FrostWurm.FrostWurm"] = 109,
	["Creature.Dragon.Taerar"] = 253,
	["Creature.Anubisath.Anubisath"] = 396,
	["Creature.MadScientist.MadScientist"] = 173,
	["Creature.BoneGolem.BoneGolem"] = 394,
	["Creature.Diemetradon.Diemetradon"] = 393,
	["Creature.Quillboar.QuillBoarCaster"] = 392,
	["Character.Tauren.Male.TaurenMale"] = 163,
	["Creature.Stag.Stag"] = 194,
	["Creature.ElementalPoison.PoisonElemental"] = 390,
	["Creature.Spells.BattleStandard_Frostwolf_A_01"] = 389,
	["Creature.DragonSpawn.DragonSpawnArmored"] = 167,
	["Creature.SandWorm.SandWorm"] = 76,
	["Creature.Object.ArcheryTarget"] = 239,
	["Creature.Ghost.Ghost"] = 203,
	["Creature.Slime.SlimeLesser"] = 171,
	["Creature.UndeadBeast.UndeadBeast"] = 206,
	["Creature.TwinEmperor.TwinEmperor"] = 156,
	["Creature.DruidOwlbear.DruidOwlBear"] = 174,
	["Character.NightElf.Female.NightElfFemale"] = 175,
	["Creature.Rabbit.Rabbit"] = 234,
	["Creature.NagaFemale.Siren"] = 385,
	["Creature.GnollCaster.GnollCaster"] = 63,
	["Creature.DruidBear.DruidBearTauren"] = 233,
	["Creature.UndeadHorse.RidingUndeadHorse"] = 215,
	["Creature.Goblin.GoblinShredder"] = 228,
	["Creature.Rat.Rat"] = 61,
	["Creature.panda.PandaCub"] = 381,
	["Creature.Zombie.Zombie"] = 380,
	["Creature.Chicken.Chicken"] = 379,
	["Creature.FelBoar.FelBoar"] = 186,
	["Creature.DragonSpawn.DragonSpawnOverlord"] = 187,
	["Creature.Wendigo.Wendigo"] = 188,
	["Creature.LostOne.LostOne"] = 242,
	["Character.Goblin.Male.GoblinMale"] = 190,
	["Character.Human.Male.HumanMale"] = 191,
	["Creature.Pig.Pig"] = 192,
	["Creature.Ogre.OgreMage"] = 223,
	["Creature.Spells.EarthElementalTotem"] = 164,
	["Creature.Manafiend.ManaFiend"] = 83,
	["Creature.Hippogryph.HippogryphPet"] = 376,
	["Creature.WindSerpent.WindSerpent"] = 218,
	["Creature.ElementalEarth.ElementalEarth"] = 375,
	["Creature.MOUNTEDDEATHKNIGHT.MountedDeathKnight_Zeliek"] = 199,
	["Creature.Harpy.Harpy"] = 374,
	["Creature.Slime.Slime"] = 373,
	["Creature.QuestObjects.Creature_ScourgeCrystal"] = 202,
	["Creature.Zombie.ZombieSword"] = 237,
	["Creature.TitanMale.TitanMale"] = 204,
	["Creature.Gnome.Gnome"] = 371,
	["Creature.TRex.trex"] = 370,
	["Creature.Troll.Troll"] = 369,
	["Creature.Hippogryph.Hippogryph"] = 368,
	["Character.Scourge.Male.ScourgeMale"] = 209,
	["Creature.GolemHarvest.GolemHarvest"] = 210,
	["Creature.Lasher.Lasher"] = 211,
	["Creature.HighElf.HighElfFemale_Priest"] = 243,
	["Creature.Nightmare.Nightmare"] = 213,
	["Creature.Drakeadon.Drakeadon"] = 366,
	["Creature.DarkHound.DarkHound"] = 365,
	["Creature.Cow.Cow"] = 216,
	["Character.Gnome.Male.GnomeMale"] = 217,
	["Creature.Kodobeast.KodoBeastTame"] = 364,
	["Creature.Turtle.Turtle"] = 219,
	["Creature.Kobold.Kobold"] = 363,
	["Creature.Troll.TrollJungleCaster"] = 21,
	["Creature.RidingRaptor.RidingRaptor"] = 222,
	["Creature.TempDeathGuard.DeathGuard"] = 182,
	["Creature.HighElf.HighElfMale_Mage"] = 224,
	["Creature.voidterror.VoidTerror"] = 361,
	["Creature.HUMSCitizenMid.HUMSCitizenMid"] = 226,
	["Creature.Scorpion.Scorpion"] = 360,
	["Creature.Quillboar.QuillBoar"] = 359,
	["Creature.GnomeSpidertank.GnomeAlertBot"] = 229,
	["Creature.Spells.AirElementalTotem"] = 230,
	["Creature.Lord Kezzak.LordKezzak"] = 231,
	["Character.Dwarf.Female.DwarfFemale"] = 232,
	["Creature.Quillboar.QuillBoarWarrior"] = 179,
	["Creature.DruidOwlbear.DruidOwlBearTauren"] = 176,
	["Character.Gnome.Female.GnomeFemale"] = 356,
	["Creature.Hyena.Hyena"] = 355,
	["Creature.Drake.OrcDrakeRider"] = 195,
	["Creature.HumanFemalePeasant.HumanFemalePeasant"] = 354,
	["Creature.Object.Cannon"] = 169,
	["Creature.Worm.Worm"] = 240,
	["Creature.Banshee.Banshee"] = 251,
	["Creature.Nightmare.Gorgon101"] = 351,
	["Creature.SPELLS.ValentinesDummy"] = 172,
	["Creature.Spells.ManaTotem"] = 244,
	["Creature.Dryder.Dryder"] = 245,
	["Creature.DireWolf.PvPRidingDireWolf"] = 246,
	["Creature.HumanFemaleCaster.HumanFemaleCaster"] = 247,
	["Creature.KeeperOfTheGrove.KeeperOfTheGrove"] = 248,
	["Creature.Spells.BattleStandard_Alliance"] = 249,
	["Creature.OrcMaleKid.OrcMaleKid"] = 250,
	["Creature.HUMNGuardBig.HUMNGuardBig"] = 208,
	["Creature.FleshTitan.FleshTitan"] = 350,
	["Character.Troll.Female.TrollFemale"] = 157,
	["Creature.Spells.Creature_SpellPortal"] = 254,
	["Creature.WarHorse.WarHorse"] = 255,
	["Creature.Lion.Lion"] = 256,
	["Creature.OrcMaleWarriorHeavy.OrcMaleWarriorHeavy"] = 257,
	["Creature.Bear.PolarBearCub"] = 258,
	["Character.Troll.Male.TrollMale"] = 259,
	["Creature.DoomGuard.DoomGuard"] = 260,
	["Creature.TrollDire.TrollDire"] = 347,
	["Character.Scourge.Female.ScourgeFemale"] = 262,
	["Creature.MineSpider.MineSpider"] = 263,
	["Creature.giraffe.Giraffe"] = 345,
	["Creature.Wyvern.Wyvern"] = 265,
	["Creature.Pterrordax.Pterrordax"] = 266,
	["Creature.Object.WoodenDummy"] = 267,
	["Creature.HumanMalePeasant.HumanMalePeasantGold"] = 269,
	["Creature.HumanMalePeasant.HumanMalePeasantWood"] = 342,
	["Creature.TitanMale.TitanMale_Ghost"] = 341,
	["Creature.FaerieDragon.FaerieDragon"] = 340,
	["Creature.DragonSpawn.DragonSpawn"] = 272,
	["Creature.DruidCatTauren.DruidCatTauren"] = 339,
	["Creature.WarHorse.PVPWarHorse"] = 276,
	["Creature.Wolf.Wolf_ghost"] = 337,
	["Creature.Frog.Frog"] = 274,
	["Creature.MountedDeathKnight.MountedDeathKnight"] = 277,
	["Creature.Imp.FireImp"] = 278,
	["Creature.Dragon.Lethon"] = 279,
	["Creature.HumanMalePirateSwashbuckler.HumanMalePirateSwashbuckler"] = 288,
	["Creature.furbolg.Furbolg"] = 275,
	["Creature.Dryad.Dryad"] = 282,
	["Creature.HumanFemaleWarriorLight.HumanFemaleWarriorLight"] = 283,
	["Creature.Ram.Ram"] = 284,
	["Creature.Basilisk.Basilisk"] = 335,
	["Creature.Spells.FireLightTotem"] = 286,
	["Creature.Spells.FireElementalTotem"] = 287,
	["Creature.Troll.TrollMelee"] = 280,
	["Creature.Spells.HealingTotem"] = 334,
	["Creature.FelBeast.FelBeast"] = 290,
	["Creature.Wisp.Wisp"] = 333,
	["Creature.CarrionBird.CarrionBird"] = 292,
	["Creature.DruidBear.DruidBear"] = 332,
	["Creature.Egg.EggCreature"] = 297,
	["Creature.HumanMaleCaster.HumanMaleCaster"] = 295,
	["Creature.SandReaver.SandReaver"] = 293,
	["Creature.Turkey.Turkey"] = 294,
	["Creature.KelThuzad.KelThuzad"] = 330,
	["Creature.Horse.Horse"] = 298,
	["Creature.DireWolf.RidingDireWolf"] = 300,
	["Creature.MOUNTEDDEATHKNIGHT.MountedDeathKnight_Blaumeux"] = 301,
	["Creature.Ghoul.Ghoul"] = 329,
	["Creature.Ragnaros.Ragnaros"] = 302,
	["Creature.HUMLMerchant.HUMLMerchant"] = 304,
	["Creature.MountedKnight.MountedKnight"] = 305,
	["Creature.Shark.HammerHead"] = 306,
	["Creature.Raptor.Raptor"] = 326,
	["Creature.QuestObjects.Creature_ScourgeCrystalDamaged"] = 308,
	["Creature.InvisibleStalker.InvisibleStalkerNoName"] = 309,
	["Creature.Landro.Landro"] = 324,
	["Creature.HumanMaleWarriorHeavy.HumanMaleWarriorHeavy"] = 323,
	["Creature.SporeCreature.SporeCreature"] = 311,
	["Creature.Drake.Drake"] = 313,
	["Creature.ReinDeer.ReinDeerMount"] = 322,
	["Character.Tauren.Female.TaurenFemale"] = 321,
	["Character.Dwarf.Male.DwarfMale"] = 316,
	["Creature.EyeOfKathune.EyeofKathune"] = 318,
	["Creature.GolemStone.GolemStone"] = 315,
	["Creature.GolemHarvestStage2.GolemHarvestStage2"] = 319,
	["Creature.HumanFemaleFarmer.HumanFemaleFarmer"] = 320,
	["Creature.Spells.StasisTotem"] = 317,
	["Creature.HighElf.HighElfMale_Priest"] = 314,
	["Creature.OrcMaleWarriorLight.OrcMaleWarriorLight"] = 312,
	["Creature.Fish.Fish"] = 310,
	["Creature.Lich.Lich"] = 325,
	["Creature.TempScarletCrusaderLight.ScarletCrusaderLight"] = 307,
	["Creature.SpiritofRedemption.SpiritOfRedemption"] = 327,
	["Creature.MineSpider.MineSpiderBoss"] = 328,
	["Creature.zergling.ZerglingPet"] = 303,
	["Creature.mobat.Mobat"] = 299,
	["Creature.Spells.LandMine01"] = 331,
	["Creature.Wolf.Wolf"] = 296,
	["Creature.FrostSabre.PVPRidingFrostSabre"] = 291,
	["Creature.HumanMalePeasant.HumanMalePeasantPick"] = 289,
	["Creature.Lobstrok.Lobstrok"] = 285,
	["Creature.HUFMMerchant.HUFMMerchant"] = 336,
	["Creature.Gnoll.gnoll"] = 281,
	["Creature.SilithidWaspBoss.SilithidWaspBoss"] = 338,
	["Creature.Gargoyle.Gargoyle"] = 273,
	["Creature.HumanFemaleKid.HumanFemaleKid"] = 271,
	["Creature.HUMLMagicSmith.HUMLMagicSmith"] = 270,
	["Creature.Zombie.ZombieArm"] = 268,
	["Creature.FleshGolem.FleshGolem"] = 343,
	["Creature.Kodobeast.KodoBeastPack"] = 344,
	["Creature.Kodobeast.KodoBeast"] = 264,
	["Creature.HumanMaleKid.HumanMaleKid"] = 346,
	["Creature.Cupid.Cupid"] = 261,
	["Creature.AncientProtector.AncientProtector"] = 348,
	["Creature.SeaGiant.SeaGiant"] = 349,
	["Creature.HighElf.HighElfFemale_Hunter"] = 225,
	["Creature.FireElemental.FireElementalGreen"] = 252,
	["Creature.VoidWalker.VoidWalker"] = 352,
	["Creature.Ogre.Ogre"] = 353,
	["Creature.Chimera.Chimera"] = 10,
	["Creature.WaterElemental.WaterElemental"] = 12,
	["Creature.Tiger.Tiger"] = 235,
	["Creature.HUMLBlackSmith.HUMLBlackSmith"] = 357,
	["Creature.SilithidTankBoss.SilithidTankBoss_Damaged"] = 358,
	["Creature.SeaTurtle.SeaTurtle"] = 181,
	["Creature.ZigguratCrystal.ZigguratCrystal"] = 227,
	["Creature.Tharazun.Tharazun"] = 189,
	["Creature.HumanThief.HumanThief"] = 362,
	["Creature.AllianceRider.AllianceRider"] = 24,
	["Creature.GnomeRocketCar.GnomeRocketCar"] = 197,
	["Creature.Infernal.Infernal"] = 26,
	["Creature.FungalMonster.FungalMonster"] = 29,
	["Creature.DragonWhelp.DragonWhelp"] = 367,
	["Creature.Gorilla.Gorilla"] = 241,
	["Creature.Centaur.CentaurKhan"] = 207,
	["Creature.InvisibleMan.InvisibleMan"] = 170,
	["Creature.Dragon.Dragon"] = 34,
	["Creature.QuirajGladiator.QuirajGladiator"] = 372,
	["Creature.snake.snake"] = 39,
	["Creature.diablo.DiabloFunSized"] = 40,
	["Creature.slith.Slith"] = 168,
	["Creature.Imp.Imp"] = 51,
	["Creature.threshadon.Threshadon"] = 377,
	["Creature.MOUNTEDDEATHKNIGHT.MountedDeathKnight_Mograine"] = 378,
	["Creature.GnomeSpidertank.GnomeSpiderTank"] = 185,
	["Creature.AirElemental.AirElemental"] = 55,
	["Creature.Dreadlord.DreadLord"] = 56,
	["Creature.Kodobeast.RidingKodo"] = 382,
	["Creature.AncientOfLore.AncientofLore"] = 383,
	["Creature.HighElf.HighElfMale_Warrior"] = 384,
	["Creature.Ram.PVPRidingRam"] = 177,
	["Creature.Deer.Deer"] = 386,
	["Creature.cockroach.Cockroach"] = 387,
	["Creature.HighElf.HighElfMale_Hunter"] = 388,
	["Creature.Spells.Serpent_Totem"] = 200,
	["Creature.HighElf.HighElfFemale_Warrior"] = 165,
	["Creature.OrcMaleMerchantLight.OrcMaleMerchantLight"] = 391,
	["Creature.HalfBodyofKathune.HalfBodyofKathune"] = 184,
	["Creature.DwarfMaleWarriorLight.DwarfMaleWarriorLight"] = 178,
	["Creature.Ent.Ent"] = 152,
	["Creature.CrystalPortal.CrystalPortal"] = 395,
	["Creature.Frenzy.Frenzy"] = 147,
	["Creature.Skeleton.Skeleton"] = 397,
	["Character.Orc.Male.OrcMale"] = 398,
	["Creature.QuirajBattleguard.BattleGuard"] = 112,
	["Creature.HumanMalePeasant.HumanMalePeasant"] = 400,
	["Creature.Spells.EyeOfKilrog"] = 401,
	["Creature.Dragon.DragonAzurgoz"] = 155,
	["Creature.Troll.TrollForestBoss"] = 125,
	["Creature.StoneKeeper.StoneKeeper"] = 404,
	["Creature.MOUNTEDDEATHKNIGHT.MountedDeathKnight_Korthazz"] = 137,
	["Creature.Parrot.Parrot"] = 136,
	["Creature.CryptFiend.CryptFiend"] = 148,
	["Creature.FelGuard.FelGuard"] = 408,
}
Mazz3D_CameraDB = {
	[1] = {
		["rotation"] = 0.4124981536000345,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3074996322347178,
			["panH"] = -0.2049963926832698,
		},
		["scale"] = 0.7499999999999998,
	},
	[2] = {
		["rotation"] = 0.2749997999667237,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.998750491359843,
			["panH"] = -0.2818750831493085,
		},
		["scale"] = 0.4999999999999996,
	},
	[3] = {
		["rotation"] = 0.3575006677667615,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.870624143640073,
			["panH"] = 0.1025010781758142,
		},
		["scale"] = 0.3999999999999996,
	},
	[4] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.306875418258547,
			["panH"] = -0.7431241712721115,
		},
		["scale"] = 0.7999999999999998,
	},
	[5] = {
		["rotation"] = 0.385000957033451,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.588750141178584,
			["panH"] = -1.025002136255606,
		},
		["scale"] = 0.7499999999999998,
	},
	[6] = {
		["rotation"] = 0.4400015355668171,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6662498035573411,
			["panH"] = -0.07687869046604776,
		},
		["scale"] = 0.8999999999999999,
	},
	[7] = {
		["rotation"] = 0.3850009570334509,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537501763466327,
			["panH"] = 0.6662512444744266,
		},
		["scale"] = 1,
	},
	[8] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6150007053865243,
			["panH"] = -0.3331227404030364,
		},
		["scale"] = 1,
	},
	[9] = {
		["rotation"] = 0.4949990214000811,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.665624869122625,
			["panH"] = -0.9481292094579257,
		},
		["scale"] = 0.7499999999999998,
	},
	[10] = {
		["rotation"] = 0.2749997999667237,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.04999958953066,
			["panH"] = -0.1281292295539481,
		},
		["scale"] = 0.4999999999999996,
	},
	[11] = {
		["rotation"] = 0.1924958394665797,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1793747254320398,
			["panH"] = -0.02562815137813846,
		},
		["scale"] = 0.6999999999999997,
	},
	[12] = {
		["rotation"] = 0.05499748583326893,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.050625604653193,
			["panH"] = 0.2818722013151224,
		},
		["scale"] = 0.7999999999999998,
	},
	[13] = {
		["rotation"] = -0.08249777509994952,
		["zoom"] = -1.749999547095079,
		["position"] = {
			["panV"] = -1.742501398213035,
			["panH"] = -0.02562815137813884,
		},
		["scale"] = 0.1,
	},
	[14] = {
		["rotation"] = 0.3025000892334043,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.793749775925305,
			["panH"] = -0.1025010781758187,
		},
		["scale"] = 0.3499999999999996,
	},
	[15] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.511874692775996,
			["panH"] = -0.2306245440613992,
		},
		["scale"] = 0.6999999999999997,
	},
	[16] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = -0.174999790702685,
		["position"] = {
			["panV"] = -0.3587505315518963,
			["panH"] = -0.230628866812676,
		},
		["scale"] = 1.2,
	},
	[17] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.973124141128072,
			["panH"] = 0.3331256222372223,
		},
		["scale"] = 0.6499999999999997,
	},
	[18] = {
		["rotation"] = 1.072502003300306,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1024985565709076,
			["panH"] = 0.05124621633662785,
		},
		["scale"] = 1.05,
	},
	[19] = {
		["rotation"] = 0.3850009570334511,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.588750141178584,
			["panH"] = -0.05125053908790934,
		},
		["scale"] = 0.6499999999999997,
	},
	[20] = {
		["rotation"] = -0.9075018140502611,
		["zoom"] = -2.216666612342041,
		["position"] = {
			["panV"] = 0.6662501637866118,
			["panH"] = 2.280620171070067,
		},
		["scale"] = 0.5999999999999996,
	},
	[21] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6149999849279798,
			["panH"] = -0.4356267004130363,
		},
		["scale"] = 1,
	},
	[22] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319519,
			["panH"] = -0.1537487354295465,
		},
		["scale"] = 1.3,
	},
	[23] = {
		["rotation"] = 0.08250086780004175,
		["zoom"] = -1.049999974267283,
		["position"] = {
			["panV"] = 2.972500287381176,
			["panH"] = -0.1793682413051358,
		},
		["scale"] = 0.3999999999999996,
	},
	[24] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.665624148664082,
			["panH"] = -0.05125053908790034,
		},
		["scale"] = 0.5499999999999996,
	},
	[25] = {
		["rotation"] = 0.4125012463001316,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.4868750781253021,
			["panH"] = -0.2306274258955853,
		},
		["scale"] = 1.3,
	},
	[26] = {
		["rotation"] = 0.08999953523404433,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.358123795970819,
			["panH"] = 0.1793768868076761,
		},
		["scale"] = 0.4999999999999996,
	},
	[27] = {
		["rotation"] = 0.1925020248667791,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.768124866610624,
			["panH"] = -0.2306303077297623,
		},
		["scale"] = 0.5999999999999996,
	},
	[28] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.614374330034721,
			["panH"] = -0.2306245440613992,
		},
		["scale"] = 0.6999999999999997,
	},
	[29] = {
		["rotation"] = -0.1100011570667225,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.127499972367962,
			["panH"] = 0.2818693194809409,
		},
		["scale"] = 0.6999999999999997,
	},
	[30] = {
		["rotation"] = 0.302496996533307,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9481256071651942,
			["panH"] = 0.8200014208210548,
		},
		["scale"] = 0.7999999999999998,
	},
	[31] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7431248917306546,
			["panH"] = 0.3843790431593041,
		},
		["scale"] = 0.7999999999999998,
	},
	[32] = {
		["rotation"] = 0.1374983536333111,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.563124871634628,
			["panH"] = 0.2818837286518531,
		},
		["scale"] = 0.95,
	},
	[33] = {
		["rotation"] = 0.1649986428999963,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9481248867066495,
			["panH"] = 0.02562238770976618,
		},
		["scale"] = 0.7499999999999998,
	},
	[34] = {
		["rotation"] = 1.622501603233753,
		["zoom"] = -1.48750047606664,
		["position"] = {
			["panV"] = 11.1468755373355,
			["panH"] = 0.2562483726882626,
		},
		["scale"] = 0.1999999999999997,
	},
	[35] = {
		["rotation"] = -0.3300034712001823,
		["zoom"] = -0.7291661362754011,
		["position"] = {
			["panV"] = -0.2818758036078563,
			["panH"] = 0.1537458535953513,
		},
		["scale"] = 1.25,
	},
	[36] = {
		["rotation"] = 0,
		["zoom"] = -0.2041663541502892,
		["position"] = {
			["panV"] = 0.5893754358425722,
			["panH"] = -0.07687292679768476,
		},
		["scale"] = 1.2,
	},
	[37] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.0768754484025902,
			["panH"] = 0.05125342092208639,
		},
		["scale"] = 0.7499999999999998,
	},
	[38] = {
		["rotation"] = 0.02749719656658343,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.716873607064172,
			["panH"] = 0.5125025090448846,
		},
		["scale"] = 0.6499999999999997,
	},
	[39] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687508817331637,
			["panH"] = 0.05125053908790479,
		},
		["scale"] = 1.3,
	},
	[40] = {
		["rotation"] = 0.3300003785000895,
		["zoom"] = -1.633333703321719,
		["position"] = {
			["panV"] = -0.4099999899519872,
			["panH"] = -0.07687580863186175,
		},
		["scale"] = 1.15,
	},
	[41] = {
		["rotation"] = -0.3300034712001823,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.076874007485496,
			["panH"] = 0.1793740049734852,
		},
		["scale"] = 1.15,
	},
	[42] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319519,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.8999999999999999,
	},
	[43] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.8200003401332464,
			["panH"] = 0.07687580863185264,
		},
		["scale"] = 1.1,
	},
	[44] = {
		["rotation"] = 0.2749997999667238,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.613750116058551,
			["panH"] = 0.3331299449884811,
		},
		["scale"] = 0.5999999999999998,
	},
	[45] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.07687508817331411,
			["panH"] = 0.05124477541953718,
		},
		["scale"] = 1.25,
	},
	[46] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7431252519599289,
			["panH"] = -0.2306245440614037,
		},
		["scale"] = 1,
	},
	[47] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3074985515468975,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.7499999999999998,
	},
	[48] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.07687400748549658,
			["panH"] = -5.763668372200242e-006,
		},
		["scale"] = 1.15,
	},
	[49] = {
		["rotation"] = 0.5224962179666646,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -2.741874662631957,
			["panH"] = 0.2049935108490836,
		},
		["scale"] = 1.65,
	},
	[50] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.768125226839897,
			["panH"] = -0.3331256222372224,
		},
		["scale"] = 1.2,
	},
	[51] = {
		["rotation"] = 0.9075002677002128,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3843754408665807,
			["panH"] = 0.05125342092208637,
		},
		["scale"] = 1.1,
	},
	[52] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3074996322347156,
			["panH"] = -4.551914400963142e-015,
		},
		["scale"] = 1,
	},
	[53] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.152499226789385,
			["panH"] = -0.1281263477197621,
		},
		["scale"] = 0.5499999999999996,
	},
	[54] = {
		["rotation"] = 0.3575053068169123,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.9225010580797872,
			["panH"] = 0.2818750831493039,
		},
		["scale"] = 5.949999999999987,
	},
	[55] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.22999996985596,
			["panH"] = -0.179374004973499,
		},
		["scale"] = 0.8999999999999999,
	},
	[56] = {
		["rotation"] = -0.03499895670167254,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 5.765626930018128,
			["panH"] = 1.024999254421415,
		},
		["scale"] = 0.6999999999999995,
	},
	[57] = {
		["rotation"] = 0.467501824833498,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.306875778487819,
			["panH"] = -0.6406288567646693,
		},
		["scale"] = 0.6499999999999997,
	},
	[58] = {
		["rotation"] = 0.6324973750333918,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2562501738346288,
			["panH"] = -0.05124765725372781,
		},
		["scale"] = 1,
	},
	[59] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.050625244423919,
			["panH"] = 0.05125342092209091,
		},
		["scale"] = 1.15,
	},
	[60] = {
		["rotation"] = -0.1100042497668247,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281245465734059,
			["panH"] = -0.1537544990979051,
		},
		["scale"] = 1.2,
	},
	[61] = {
		["rotation"] = 0.3850009570334511,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3587498110933534,
			["panH"] = 0.1025010781758096,
		},
		["scale"] = 3.749999999999995,
	},
	[62] = {
		["rotation"] = 0.3574975750666729,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.12687539816252,
			["panH"] = -1.229999969855958,
		},
		["scale"] = 0.5499999999999996,
	},
	[63] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2562505340638993,
			["panH"] = -0.4099985490349026,
		},
		["scale"] = 1.3,
	},
	[64] = {
		["rotation"] = 0,
		["zoom"] = -12.39583404818044,
		["position"] = {
			["panV"] = 3.126250463727808,
			["panH"] = 1.204376141229096,
		},
		["scale"] = 0.7499999999999998,
	},
	[65] = {
		["rotation"] = 0.1649986428999959,
		["zoom"] = -11.22916710899941,
		["position"] = {
			["panV"] = -1.66562631003972,
			["panH"] = -0.9993725439603769,
		},
		["scale"] = 0.1,
	},
	[66] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.409374695287998,
			["panH"] = -0.9225010580797873,
		},
		["scale"] = 0.7499999999999998,
	},
	[67] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3587494508640761,
			["panH"] = -0.05124477541955083,
		},
		["scale"] = 1.05,
	},
	[68] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3843761613251216,
			["panH"] = -0.05124477541954628,
		},
		["scale"] = 1.05,
	},
	[69] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.51187541323454,
			["panH"] = 0.409998549034898,
		},
		["scale"] = 0.95,
	},
	[70] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125017885863552,
			["panH"] = -4.551914400963142e-015,
		},
		["scale"] = 1,
	},
	[71] = {
		["rotation"] = 0.1650017356000935,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2306252645199457,
			["panH"] = -4.551914400963142e-015,
		},
		["scale"] = 1.1,
	},
	[72] = {
		["rotation"] = 0.2749997999667237,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.383750866661136,
			["panH"] = 0.2050021563516283,
		},
		["scale"] = 0.6499999999999997,
	},
	[73] = {
		["rotation"] = 0.1650017356000886,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2562498136053539,
			["panH"] = 0.1281205840514035,
		},
		["scale"] = 1.1,
	},
	[74] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.179375445890583,
			["panH"] = -0.5381248967546646,
		},
		["scale"] = 1.35,
	},
	[75] = {
		["rotation"] = 0.3024969965333118,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4868754383545756,
			["panH"] = 0.2562440499369885,
		},
		["scale"] = 2.599999999999999,
	},
	[76] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6149999849279781,
			["panH"] = 0.02562526954394773,
		},
		["scale"] = 0.6499999999999997,
	},
	[77] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 5.048124786226515,
			["panH"] = -0.1025010781758188,
		},
		["scale"] = 0.5999999999999996,
	},
	[78] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.050625244423919,
			["panH"] = 0.8200057435723362,
		},
		["scale"] = 0.7499999999999998,
	},
	[79] = {
		["rotation"] = 0.2199961287332651,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.306874337570729,
			["panH"] = 0.2306274258955853,
		},
		["scale"] = 0.7999999999999998,
	},
	[80] = {
		["rotation"] = 0.2749967072666265,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.137978600240786e-015,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 0.8499999999999999,
	},
	[81] = {
		["rotation"] = 0.2474995107000381,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.05124981862936056,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 1.700000000000001,
	},
	[82] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9993750655652843,
			["panH"] = 0.8200057435723362,
		},
		["scale"] = 0.7999999999999998,
	},
	[83] = {
		["rotation"] = 0.2749997999667236,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.8968743476187439,
			["panH"] = 2.42861286636753e-017,
		},
		["scale"] = 0.8999999999999999,
	},
	[84] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.768124866610621,
			["panH"] = -3.469446951953614e-018,
		},
		["scale"] = 1.2,
	},
	[85] = {
		["rotation"] = 0.0550005785333612,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2306245440614026,
			["panH"] = 0.02562526954394784,
		},
		["scale"] = 1,
	},
	[86] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.17874907053878,
			["panH"] = 1.204374700312009,
		},
		["scale"] = 0.6999999999999997,
	},
	[87] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.664376441170289,
			["panH"] = 0.8200043026552499,
		},
		["scale"] = 0.4499999999999996,
	},
	[88] = {
		["rotation"] = 0.3025000892334093,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.28125086917314,
			["panH"] = 0.3843747204080274,
		},
		["scale"] = 0.95,
	},
	[89] = {
		["rotation"] = -0.02749719656659319,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1025003577172711,
			["panH"] = -4.53109771925142e-015,
		},
		["scale"] = 0.95,
	},
	[90] = {
		["rotation"] = 0.2475026034001404,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.101874702824009,
			["panH"] = 0.128123465885585,
		},
		["scale"] = 1,
	},
	[91] = {
		["rotation"] = 0.1099949716665328,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4100003501812594,
			["panH"] = -0.07687580863186175,
		},
		["scale"] = 0.7499999999999998,
	},
	[92] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6662498035573404,
			["panH"] = -0.3587508917811746,
		},
		["scale"] = 0.95,
	},
	[93] = {
		["rotation"] = 0.164995550199899,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125017885863553,
			["panH"] = -2.881834186070631e-006,
		},
		["scale"] = 0.8999999999999999,
	},
	[94] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.408749400624013,
			["panH"] = -0.05125053908790031,
		},
		["scale"] = 0.5499999999999996,
	},
	[95] = {
		["rotation"] = 0.4949897432997798,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.53750140323704,
			["panH"] = 1.1018721812191,
		},
		["scale"] = 0.4499999999999996,
	},
	[96] = {
		["rotation"] = 0.02750028926668554,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.5637505265278897,
			["panH"] = 0.0768786904660433,
		},
		["scale"] = 1,
	},
	[97] = {
		["rotation"] = 0.1650017356000935,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.460624874146634,
			["panH"] = 0.1793725640563945,
		},
		["scale"] = 0.6499999999999997,
	},
	[98] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.562499216741369,
			["panH"] = -0.05124765725372324,
		},
		["scale"] = 0.3999999999999996,
	},
	[99] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.07687508817331409,
			["panH"] = -0.1281263477197711,
		},
		["scale"] = 1.2,
	},
	[100] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7174996221867033,
			["panH"] = -0.05125053908790934,
		},
		["scale"] = 1.1,
	},
	[101] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024999974879967,
			["panH"] = -4.555383847915095e-015,
		},
		["scale"] = 0.6999999999999997,
	},
	[102] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -3.602292726959111e-007,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 0.95,
	},
	[103] = {
		["rotation"] = 0.1650017356000934,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.5893743551547531,
			["panH"] = -0.2562469317711837,
		},
		["scale"] = 0.4499999999999996,
	},
	[104] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.4356252594959379,
			["panH"] = -0.05124477541955083,
		},
		["scale"] = 1.05,
	},
	[105] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.07687580863186064,
			["panH"] = 0.1281177022172174,
		},
		["scale"] = 1.25,
	},
	[106] = {
		["rotation"] = 1.622501603233753,
		["zoom"] = -1.48750047606664,
		["position"] = {
			["panV"] = 9.891249217247763,
			["panH"] = 0.5893754358425667,
		},
		["scale"] = 0.1999999999999997,
	},
	[107] = {
		["rotation"] = 0.1374983536333106,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7687505215038835,
			["panH"] = 0.07687292679768029,
		},
		["scale"] = 1.1,
	},
	[108] = {
		["rotation"] = 0,
		["zoom"] = -0.6125002925020425,
		["position"] = {
			["panV"] = 4.279376065868996,
			["panH"] = 1.332498166197595,
		},
		["scale"] = 0.2999999999999997,
	},
	[109] = {
		["rotation"] = 1.155004417450402,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 9.814376650679353,
			["panH"] = -0.4099956672007163,
		},
		["scale"] = 0.2499999999999997,
	},
	[110] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.768125226839896,
			["panH"] = -0.3587537736153518,
		},
		["scale"] = 0.6999999999999997,
	},
	[111] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4099999899519854,
			["panH"] = -0.05125053908790935,
		},
		["scale"] = 2.000000000000001,
	},
	[112] = {
		["rotation"] = -4.878042414446782e-015,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.126875037933248,
			["panH"] = 0.2306216622272269,
		},
		["scale"] = 0.6999999999999997,
	},
	[113] = {
		["rotation"] = -0.3575006677667753,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7943757910478365,
			["panH"] = 0.384374720408032,
		},
		["scale"] = 0.6499999999999997,
	},
	[114] = {
		["rotation"] = 0.05500057853336616,
		["zoom"] = 5,
		["position"] = {
			["panV"] = -2.946875738295768,
			["panH"] = -4.612499526730575,
		},
		["scale"] = 6.099999999999986,
	},
	[115] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.153749816117359,
			["panH"] = 0.0256223877097663,
		},
		["scale"] = 0.8999999999999999,
	},
	[116] = {
		["rotation"] = 0.3024969965333071,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.5893743551547523,
			["panH"] = -0.02563103321231123,
		},
		["scale"] = 0.7499999999999998,
	},
	[117] = {
		["rotation"] = -0.2125005539993646,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 7.303127252567351,
			["panH"] = 1.07624979350932,
		},
		["scale"] = 0.7499999999999996,
	},
	[118] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.409374695287997,
			["panH"] = -0.9225010580797873,
		},
		["scale"] = 0.7999999999999998,
	},
	[119] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562454908540702,
			["panH"] = 0.02562526954395695,
		},
		["scale"] = 0.8499999999999999,
	},
	[120] = {
		["rotation"] = 0.2749997999667237,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1024999974879972,
			["panH"] = -0.4099985490348936,
		},
		["scale"] = 1,
	},
	[121] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.971874992717191,
			["panH"] = -0.02562526954395693,
		},
		["scale"] = 0.5999999999999996,
	},
	[122] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319519,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.8999999999999999,
	},
	[123] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319508,
			["panH"] = -4.551914400963142e-015,
		},
		["scale"] = 0.8999999999999999,
	},
	[124] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[125] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6662505240158859,
			["panH"] = -0.3587480099469887,
		},
		["scale"] = 0.8999999999999999,
	},
	[126] = {
		["rotation"] = 0.6049970857667113,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.511876133693087,
			["panH"] = -1.229998528938867,
		},
		["scale"] = 0.7499999999999998,
	},
	[127] = {
		["rotation"] = 0.2475026034001451,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3587508917811703,
			["panH"] = -2.881834181529125e-006,
		},
		["scale"] = 1.900000000000001,
	},
	[128] = {
		["rotation"] = -0.02749719656658849,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2818747229200381,
			["panH"] = -0.2306187803930497,
		},
		["scale"] = 1.05,
	},
	[129] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.01208641232737137,
			["panH"] = -0.02562526954395241,
		},
		["scale"] = 0.8999999999999999,
	},
	[130] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.153125602141188,
			["panH"] = 6.938893903907228e-018,
		},
		["scale"] = 1.15,
	},
	[131] = {
		["rotation"] = 0.2749997999667237,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3843750806373058,
			["panH"] = -0.4356238185788506,
		},
		["scale"] = 1,
	},
	[132] = {
		["rotation"] = 0.5500042389835892,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.8968757885358337,
			["panH"] = 0.1281263477197619,
		},
		["scale"] = 5.949999999999987,
	},
	[133] = {
		["rotation"] = 0.08250086780004678,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4868747178960305,
			["panH"] = -0.07687580863185718,
		},
		["scale"] = 1.900000000000001,
	},
	[134] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.6406248942426619,
			["panH"] = 0.02562815137812939,
		},
		["scale"] = 2.050000000000001,
	},
	[135] = {
		["rotation"] = 0.3575006677667655,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3074999924639905,
			["panH"] = -0.1025039600100002,
		},
		["scale"] = 3.199999999999997,
	},
	[136] = {
		["rotation"] = 0.1924989321666769,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.563750886757163,
			["panH"] = 0.1025010781758142,
		},
		["scale"] = 1,
	},
	[137] = {
		["rotation"] = -0.2199992214333624,
		["zoom"] = -0.4375000917822993,
		["position"] = {
			["panV"] = 0.9993736246481964,
			["panH"] = 0.281875083149299,
		},
		["scale"] = 0.2104167432743444,
	},
	[138] = {
		["rotation"] = 0.1649986428999959,
		["zoom"] = -1.749999547095079,
		["position"] = {
			["panV"] = -1.02500285671415,
			["panH"] = -0.2818722013151316,
		},
		["scale"] = 1.05,
	},
	[139] = {
		["rotation"] = 0,
		["zoom"] = -2.304166302684853,
		["position"] = {
			["panV"] = 3.587499191621336,
			["panH"] = 0.5893682312571157,
		},
		["scale"] = 0.3999999999999996,
	},
	[140] = {
		["rotation"] = 0.3025000892334092,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2306256247492206,
			["panH"] = -0.07687580863186173,
		},
		["scale"] = 1.550000000000001,
	},
	[141] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3331256222372168,
			["panH"] = -0.0512505390879139,
		},
		["scale"] = 0.8499999999999999,
	},
	[142] = {
		["rotation"] = 0.1099980643666305,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.819374325010711,
			["panH"] = 0.1281263477197667,
		},
		["scale"] = 0.8499999999999999,
	},
	[143] = {
		["rotation"] = 1.155002871100348,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 18.06562698880701,
			["panH"] = -9.91687124472827,
		},
		["scale"] = 0.1499999999999997,
	},
	[144] = {
		["rotation"] = 1.622501603233753,
		["zoom"] = -1.48750047606664,
		["position"] = {
			["panV"] = 10.94187518213023,
			["panH"] = 0.1281249068026731,
		},
		["scale"] = 0.1999999999999997,
	},
	[145] = {
		["rotation"] = 0.247499510700043,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3587501713226238,
			["panH"] = 0.07687869046603871,
		},
		["scale"] = 0.8999999999999999,
	},
	[146] = {
		["rotation"] = 0.6325004677334891,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.101250488847839,
			["panH"] = -2.126875758391792,
		},
		["scale"] = 0.4999999999999996,
	},
	[147] = {
		["rotation"] = 0.2475026034001352,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2050003552052681,
			["panH"] = 2.881834177008436e-006,
		},
		["scale"] = 1.05,
	},
	[148] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.254998864048107,
			["panH"] = 0.2306245440614082,
		},
		["scale"] = 0.4999999999999996,
	},
	[149] = {
		["rotation"] = 0.5224993106667618,
		["zoom"] = -0.1458332272550794,
		["position"] = {
			["panV"] = -0.4612501688106223,
			["panH"] = -0.1793740049734989,
		},
		["scale"] = 0.95,
	},
	[150] = {
		["rotation"] = 0.2200023141334547,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3843758010958501,
			["panH"] = -0.02561950587559384,
		},
		["scale"] = 0.3499999999999996,
	},
	[151] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319519,
			["panH"] = -0.1537487354295465,
		},
		["scale"] = 1.3,
	},
	[152] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.40937505551727,
			["panH"] = -0.1281205840514035,
		},
		["scale"] = 0.6499999999999997,
	},
	[153] = {
		["rotation"] = 6.185400194327895e-006,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.461251609727714,
			["panH"] = 0.05125342092208181,
		},
		["scale"] = 1.05,
	},
	[154] = {
		["rotation"] = -0.05500057853336596,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4100007104105321,
			["panH"] = 0.1024953145074419,
		},
		["scale"] = 0.7999999999999998,
	},
	[155] = {
		["rotation"] = 1.622501603233753,
		["zoom"] = -1.48750047606664,
		["position"] = {
			["panV"] = 11.58250043660216,
			["panH"] = 0.3074989117761626,
		},
		["scale"] = 0.1999999999999997,
	},
	[156] = {
		["rotation"] = 0,
		["zoom"] = 0.991666847372075,
		["position"] = {
			["panV"] = 2.562501017887735,
			["panH"] = 0.2050021563516147,
		},
		["scale"] = 0.2999999999999996,
	},
	[157] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.10250035771727,
			["panH"] = -0.1024981963416372,
		},
		["scale"] = 0.8999999999999999,
	},
	[158] = {
		["rotation"] = 0.4124981536000346,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.716874327522716,
			["panH"] = 0.2818693194809455,
		},
		["scale"] = 0.6499999999999997,
	},
	[159] = {
		["rotation"] = 0.1924989321666769,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4868747178960302,
			["panH"] = 0.2562469317711746,
		},
		["scale"] = 2.449999999999999,
	},
	[160] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7431245315013841,
			["panH"] = -0.05124189358536471,
		},
		["scale"] = 1.05,
	},
	[161] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6406248942426597,
			["panH"] = 0.358755214532438,
		},
		["scale"] = 0.95,
	},
	[162] = {
		["rotation"] = 0.4399984428667151,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9737497960213304,
			["panH"] = 0.8199970980697873,
		},
		["scale"] = 0.7499999999999998,
	},
	[163] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281245465734055,
			["panH"] = 2.881834181546472e-006,
		},
		["scale"] = 0.95,
	},
	[164] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.511874692775994,
			["panH"] = 0.05124765725372779,
		},
		["scale"] = 1.15,
	},
	[165] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024996372587228,
			["panH"] = 2.881834176994558e-006,
		},
		["scale"] = 0.6999999999999997,
	},
	[166] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.5637498060693436,
			["panH"] = -0.02561950587559378,
		},
		["scale"] = 1.2,
	},
	[167] = {
		["rotation"] = 0.3299972857999877,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.050624884194647,
			["panH"] = 0.9737487153335064,
		},
		["scale"] = 0.5999999999999996,
	},
	[168] = {
		["rotation"] = 0.4400046282669048,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3843754408665784,
			["panH"] = -0.07687292679767566,
		},
		["scale"] = 1.05,
	},
	[169] = {
		["rotation"] = 0.6124988459008054,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.151873571896125,
			["panH"] = -0.5381248967546651,
		},
		["scale"] = 0.3499999999999996,
	},
	[170] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[171] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1025007179465426,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[172] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.588749420720039,
			["panH"] = -2.881834190494176e-006,
		},
		["scale"] = 1.750000000000001,
	},
	[173] = {
		["rotation"] = 0.2749997999667236,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537505365759044,
			["panH"] = -0.025628151378134,
		},
		["scale"] = 0.95,
	},
	[174] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3075003526932633,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 1,
	},
	[175] = {
		["rotation"] = -0.05500057853336134,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281245465734065,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.95,
	},
	[176] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2050003552052648,
			["panH"] = 0.07687580863186175,
		},
		["scale"] = 0.7499999999999998,
	},
	[177] = {
		["rotation"] = 0.4399984428667151,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.665624508893355,
			["panH"] = -0.8968729067016532,
		},
		["scale"] = 0.7999999999999998,
	},
	[178] = {
		["rotation"] = 0.5775029819002252,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562490931467914,
			["panH"] = -0.05124765725373236,
		},
		["scale"] = 0.6999999999999997,
	},
	[179] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.743125251959929,
			["panH"] = 0.1793740049734898,
		},
		["scale"] = 0.95,
	},
	[180] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[181] = {
		["rotation"] = 0.1099980643666248,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2049999949759927,
			["panH"] = 0.05125342092208636,
		},
		["scale"] = 0.6499999999999997,
	},
	[182] = {
		["rotation"] = 0.1374983536333059,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.02562454908540757,
			["panH"] = 5.763668363155394e-006,
		},
		["scale"] = 0.7999999999999998,
	},
	[183] = {
		["rotation"] = 0.5499995999334473,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1793754458905851,
			["panH"] = 0.0256252695439524,
		},
		["scale"] = 0.95,
	},
	[184] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.870624864098621,
			["panH"] = 0.6149978235523452,
		},
		["scale"] = 0.5499999999999996,
	},
	[185] = {
		["rotation"] = 0.2750028926668161,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.5637501662986172,
			["panH"] = -0.1025010781758187,
		},
		["scale"] = 0.7999999999999998,
	},
	[186] = {
		["rotation"] = 0.3574975750666682,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.02562490931468195,
			["panH"] = -3.469446951953614e-017,
		},
		["scale"] = 0.95,
	},
	[187] = {
		["rotation"] = 0.1649986428999963,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.973124501357342,
			["panH"] = 0.9737472744164198,
		},
		["scale"] = 0.5499999999999996,
	},
	[188] = {
		["rotation"] = 0.08250396050014404,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.40937505551727,
			["panH"] = 0.05124765725372325,
		},
		["scale"] = 0.5999999999999996,
	},
	[189] = {
		["rotation"] = 0,
		["zoom"] = -3.062499822441977,
		["position"] = {
			["panV"] = 0.6406259749304776,
			["panH"] = -0.0256310332123155,
		},
		["scale"] = 0.7499999999999998,
	},
	[190] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.0512498186293628,
			["panH"] = -2.881834186101856e-006,
		},
		["scale"] = 0.7999999999999998,
	},
	[191] = {
		["rotation"] = 0.014528039190842,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.09573002853579703,
			["panH"] = 0,
		},
		["scale"] = 0.95,
	},
	[192] = {
		["rotation"] = 0.1100011570667372,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3587498110933522,
			["panH"] = 0.07687292679767567,
		},
		["scale"] = 1.950000000000001,
	},
	[193] = {
		["rotation"] = 0.3025031819335016,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.640624534013387,
			["panH"] = 0.2049963926832652,
		},
		["scale"] = 1.2,
	},
	[194] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.434999604602679,
			["panH"] = -1.153125602141187,
		},
		["scale"] = 0.7499999999999998,
	},
	[195] = {
		["rotation"] = 0.4949928359998918,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.844999234325393,
			["panH"] = 2.881834186126142e-006,
		},
		["scale"] = 0.4499999999999996,
	},
	[196] = {
		["rotation"] = 0.4400015355668124,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024999974879961,
			["panH"] = 0.4868743576667506,
		},
		["scale"] = 0.7999999999999998,
	},
	[197] = {
		["rotation"] = 0.6124988459008054,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.895623758290769,
			["panH"] = -0.05124909817081916,
		},
		["scale"] = 0.3499999999999996,
	},
	[198] = {
		["rotation"] = 1.292498132033575,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3074992720054451,
			["panH"] = -0.179374004973499,
		},
		["scale"] = 0.8999999999999999,
	},
	[199] = {
		["rotation"] = 0.3024969965333071,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7943747103600184,
			["panH"] = -0.2562555772737103,
		},
		["scale"] = 0.6499999999999997,
	},
	[200] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.614374330034718,
			["panH"] = 0.02562815137812941,
		},
		["scale"] = 0.6999999999999997,
	},
	[201] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125089931718092,
			["panH"] = 2.881834177022313e-006,
		},
		["scale"] = 0.7499999999999998,
	},
	[202] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.229999969855961,
			["panH"] = 2.881834181574228e-006,
		},
		["scale"] = 0.5999999999999996,
	},
	[203] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.332500687802502,
			["panH"] = -2.881834186087978e-006,
		},
		["scale"] = 0.8499999999999999,
	},
	[204] = {
		["rotation"] = 0,
		["zoom"] = -1.866667440953728,
		["position"] = {
			["panV"] = 3.971875713175733,
			["panH"] = -0.05125342092209545,
		},
		["scale"] = 0.3999999999999996,
	},
	[205] = {
		["rotation"] = 0.3850009570334511,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.768124866610624,
			["panH"] = -0.05125053908790934,
		},
		["scale"] = 0.5499999999999996,
	},
	[206] = {
		["rotation"] = 0.2749997999667145,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687472794404425,
			["panH"] = -0.2818779649834946,
		},
		["scale"] = 0.8999999999999999,
	},
	[207] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9481241662481046,
			["panH"] = 0.871256282660241,
		},
		["scale"] = 0.7999999999999998,
	},
	[208] = {
		["rotation"] = 0.1924989321666769,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1793754458905835,
			["panH"] = 0.1025010781758051,
		},
		["scale"] = 1.05,
	},
	[209] = {
		["rotation"] = 0.2199992214333625,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1024996372587258,
			["panH"] = -0.02563103321231096,
		},
		["scale"] = 0.8999999999999999,
	},
	[210] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.076249793509327,
			["panH"] = -0.02562815137813397,
		},
		["scale"] = 0.6499999999999997,
	},
	[211] = {
		["rotation"] = -0.1100011570667225,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.845624889218654,
			["panH"] = 0.4099927853665304,
		},
		["scale"] = 0.7499999999999998,
	},
	[212] = {
		["rotation"] = 0.05499748583326879,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6406256147012053,
			["panH"] = 0.1793725640563946,
		},
		["scale"] = 1.2,
	},
	[213] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6918736321842031,
			["panH"] = 0.05125630275626786,
		},
		["scale"] = 0.7999999999999998,
	},
	[214] = {
		["rotation"] = 0.6325004677334893,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2818750831493085,
			["panH"] = -0.05124765725372781,
		},
		["scale"] = 1.1,
	},
	[215] = {
		["rotation"] = 0.522499310666762,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.281249068026776,
			["panH"] = -0.6662570081428035,
		},
		["scale"] = 0.7999999999999998,
	},
	[216] = {
		["rotation"] = 0.4399984428667199,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1793750856613113,
			["panH"] = -0.07687292679768487,
		},
		["scale"] = 1,
	},
	[217] = {
		["rotation"] = 0.02750028926668063,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687472794404365,
			["panH"] = -4.544975507059235e-015,
		},
		["scale"] = 0.95,
	},
	[218] = {
		["rotation"] = 0.4125012463001317,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.5637501662986183,
			["panH"] = 0.1025010781758096,
		},
		["scale"] = 1,
	},
	[219] = {
		["rotation"] = 0.2474995107000333,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537508968051776,
			["panH"] = -2.881834186153898e-006,
		},
		["scale"] = 0.6499999999999997,
	},
	[220] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3331252620079429,
			["panH"] = 0.6406245340133879,
		},
		["scale"] = 1.1,
	},
	[221] = {
		["rotation"] = 0.2200023141334598,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537505365759043,
			["panH"] = -0.0768786904660433,
		},
		["scale"] = 1,
	},
	[222] = {
		["rotation"] = 0.4399984428667198,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.768124866610622,
			["panH"] = 0.4356252594959368,
		},
		["scale"] = 0.6499999999999997,
	},
	[223] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562454908540702,
			["panH"] = -6.938893903907228e-018,
		},
		["scale"] = 0.8499999999999999,
	},
	[224] = {
		["rotation"] = -0.4949990214000812,
		["zoom"] = -0.4375000917822993,
		["position"] = {
			["panV"] = 1.358123795970818,
			["panH"] = 0.4100014308690703,
		},
		["scale"] = 0.2604167432743444,
	},
	[225] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024999974879955,
			["panH"] = -4.558853294867049e-015,
		},
		["scale"] = 0.6999999999999997,
	},
	[226] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.05125053908790597,
			["panH"] = 0.1537458535953558,
		},
		["scale"] = 1.15,
	},
	[227] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -2.51125047879983,
			["panH"] = 0.7431270531062885,
		},
		["scale"] = 0.1,
	},
	[228] = {
		["rotation"] = -0.137501446333408,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.357499942223923,
			["panH"] = 0.5637516072157123,
		},
		["scale"] = 0.4999999999999996,
	},
	[229] = {
		["rotation"] = 0.1299950471481713,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.434998884144131,
			["panH"] = -4.600486658290492e-015,
		},
		["scale"] = 0.4999999999999996,
	},
	[230] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.716874327522715,
			["panH"] = 0.02562526954395239,
		},
		["scale"] = 1.2,
	},
	[231] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 5.022500597370379,
			["panH"] = 0.5893667903400247,
		},
		["scale"] = 0.2499999999999997,
	},
	[232] = {
		["rotation"] = 0.02750028926668063,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687508817331637,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 1,
	},
	[233] = {
		["rotation"] = 0.2749997999667236,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1793750856613113,
			["panH"] = -0.02562526954395696,
		},
		["scale"] = 0.7999999999999998,
	},
	[234] = {
		["rotation"] = 0.4124981536000343,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2562498136053549,
			["panH"] = -0.02562526954395696,
		},
		["scale"] = 1.650000000000001,
	},
	[235] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[236] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 4.253751516783588,
			["panH"] = -0.2306245440614037,
		},
		["scale"] = 0.2999999999999997,
	},
	[237] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.307500352693262,
			["panH"] = 0.2562526954395377,
		},
		["scale"] = 1.35,
	},
	[238] = {
		["rotation"] = 0.8799999784335368,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562454908540816,
			["panH"] = 0.1537516172637189,
		},
		["scale"] = 1,
	},
	[239] = {
		["rotation"] = 0.6600007570001698,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.845001035471759,
			["panH"] = 0.07687580863185722,
		},
		["scale"] = 0.4999999999999996,
	},
	[240] = {
		["rotation"] = 0.3850009570334565,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.07687544840258678,
			["panH"] = -1.040834085586084e-017,
		},
		["scale"] = 0.7999999999999998,
	},
	[241] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281249068026781,
			["panH"] = -4.53109771925142e-015,
		},
		["scale"] = 1.05,
	},
	[242] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.5381241762961178,
			["panH"] = -0.7943747103600253,
		},
		["scale"] = 1.15,
	},
	[243] = {
		["rotation"] = 0,
		["zoom"] = -0.1166674838415919,
		["position"] = {
			["panV"] = 0.07687400748549655,
			["panH"] = 2.881834176994558e-006,
		},
		["scale"] = 0.6999999999999997,
	},
	[244] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.02562490931468198,
			["panH"] = 0.05125053908790481,
		},
		["scale"] = 1.05,
	},
	[245] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.2293743149627,
			["panH"] = 0.153751617263728,
		},
		["scale"] = 0.4999999999999996,
	},
	[246] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024996372587223,
			["panH"] = -0.2049992745174514,
		},
		["scale"] = 1,
	},
	[247] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -3.60229273813073e-007,
			["panH"] = 0.07687869046603875,
		},
		["scale"] = 1.15,
	},
	[248] = {
		["rotation"] = 0.3025000892334043,
		["zoom"] = -0.7875004932217861,
		["position"] = {
			["panV"] = 1.409377216892907,
			["panH"] = -1.691244735227498,
		},
		["scale"] = 0.6999999999999997,
	},
	[249] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.792500627514422,
			["panH"] = 0.02562526954395237,
		},
		["scale"] = 0.5999999999999996,
	},
	[250] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3843750806373059,
			["panH"] = 0.02562815137813395,
		},
		["scale"] = 1.800000000000001,
	},
	[251] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2050003552052671,
			["panH"] = -4.551914400963142e-015,
		},
		["scale"] = 0.7999999999999998,
	},
	[252] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.460624513917361,
			["panH"] = 0.3331227404030319,
		},
		["scale"] = 0.8999999999999999,
	},
	[253] = {
		["rotation"] = 1.622501603233753,
		["zoom"] = -1.48750047606664,
		["position"] = {
			["panV"] = 8.53312398035985,
			["panH"] = 0.02562526954394969,
		},
		["scale"] = 0.2,
	},
	[254] = {
		["rotation"] = -0.08249777509994952,
		["zoom"] = -1.749999547095079,
		["position"] = {
			["panV"] = -2.58812628743169,
			["panH"] = 0.05124765725372289,
		},
		["scale"] = 0.8500000000000002,
	},
	[255] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125017885863666,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.8999999999999999,
	},
	[256] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1025003577172699,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.8999999999999999,
	},
	[257] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2818743626907621,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 1,
	},
	[258] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = -1.283333301882234,
		["position"] = {
			["panV"] = -0.4868754383545758,
			["panH"] = 0.05125053908790937,
		},
		["scale"] = 0.7499999999999998,
	},
	[259] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125053908790717,
			["panH"] = -0.05125053908791394,
		},
		["scale"] = 0.8499999999999999,
	},
	[260] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562454908540702,
			["panH"] = -6.938893903907228e-018,
		},
		["scale"] = 0.8499999999999999,
	},
	[261] = {
		["rotation"] = 0.7149982428334435,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562454908540816,
			["panH"] = 0.1537516172637189,
		},
		["scale"] = 1,
	},
	[262] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537494558880885,
			["panH"] = 5.763668358575724e-006,
		},
		["scale"] = 0.8999999999999999,
	},
	[263] = {
		["rotation"] = 0.1374983536333205,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.6918743526427499,
			["panH"] = 0.02562815137813839,
		},
		["scale"] = 0.8499999999999999,
	},
	[264] = {
		["rotation"] = 0.275002892666821,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.819375405698532,
			["panH"] = 0.3587508917811748,
		},
		["scale"] = 0.3499999999999996,
	},
	[265] = {
		["rotation"] = 0.3575006677667704,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.435000325061225,
			["panH"] = -0.1025010781758233,
		},
		["scale"] = 0.5999999999999996,
	},
	[266] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.358124156200091,
			["panH"] = -0.05125053908790034,
		},
		["scale"] = 0.5499999999999996,
	},
	[267] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.4099999899519853,
			["panH"] = -0.05125053908791392,
		},
		["scale"] = 0.95,
	},
	[268] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3843754408665785,
			["panH"] = 0.05124765725372781,
		},
		["scale"] = 1.3,
	},
	[269] = {
		["rotation"] = 0.3850009570334464,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1537508968051737,
			["panH"] = -0.128120584051408,
		},
		["scale"] = 1.2,
	},
	[270] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3331249017786703,
			["panH"] = -0.230624544061399,
		},
		["scale"] = 1.05,
	},
	[271] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.4356252594959389,
			["panH"] = 0,
		},
		["scale"] = 2.100000000000001,
	},
	[272] = {
		["rotation"] = 0.1924989321666769,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9481248867066501,
			["panH"] = 0.8199985389868827,
		},
		["scale"] = 0.7499999999999998,
	},
	[273] = {
		["rotation"] = 0.4124981536000347,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3843758010958501,
			["panH"] = -0.05125053908790935,
		},
		["scale"] = 0.8999999999999999,
	},
	[274] = {
		["rotation"] = 0.5224993106667667,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1793747254320408,
			["panH"] = 0.2050021563516238,
		},
		["scale"] = 4.099999999999993,
	},
	[275] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.131039706336878e-015,
			["panH"] = -0.05125053908790936,
		},
		["scale"] = 0.8499999999999999,
	},
	[276] = {
		["rotation"] = 0.43999844286672,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687508817331638,
			["panH"] = -0.2562498136053606,
		},
		["scale"] = 0.8999999999999999,
	},
	[277] = {
		["rotation"] = 0.4949990214000812,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.8712501587626075,
			["panH"] = -0.2562498136053606,
		},
		["scale"] = 0.6999999999999997,
	},
	[278] = {
		["rotation"] = 0.1374983536333111,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.511875053005267,
			["panH"] = 0.1281321113881251,
		},
		["scale"] = 1.1,
	},
	[279] = {
		["rotation"] = 1.265000935466984,
		["zoom"] = -6.679167835533423,
		["position"] = {
			["panV"] = 15.75937722544171,
			["panH"] = 0.3331227404030275,
		},
		["scale"] = 0.3499999999999996,
	},
	[280] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6150003451572514,
			["panH"] = -0.3587508917811746,
		},
		["scale"] = 1,
	},
	[281] = {
		["rotation"] = 0.2750028926668161,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.02562490931468084,
			["panH"] = 0.07687580863185721,
		},
		["scale"] = 0.95,
	},
	[282] = {
		["rotation"] = 0.467501824833498,
		["zoom"] = -0.1166666638074765,
		["position"] = {
			["panV"] = 0.6406245340133868,
			["panH"] = 0.2306259849784901,
		},
		["scale"] = 1,
	},
	[283] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6406259749304782,
			["panH"] = -0.07687292679768476,
		},
		["scale"] = 1.2,
	},
	[284] = {
		["rotation"] = 0.4675018248334978,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.486250143690586,
			["panH"] = -1.204376141229105,
		},
		["scale"] = 0.7999999999999998,
	},
	[285] = {
		["rotation"] = 0.4950021141001835,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.691875073101294,
			["panH"] = -0.2562469317711747,
		},
		["scale"] = 0.6499999999999997,
	},
	[286] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.537500322549221,
			["panH"] = 2.881834181529125e-006,
		},
		["scale"] = 1.15,
	},
	[287] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.691251219354397,
			["panH"] = -0.02562526954395694,
		},
		["scale"] = 1.35,
	},
	[288] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7431245315013841,
			["panH"] = -0.05125053908790934,
		},
		["scale"] = 1.1,
	},
	[289] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1537498161173578,
			["panH"] = -0.1281263477197711,
		},
		["scale"] = 1.25,
	},
	[290] = {
		["rotation"] = 0.1724973103339891,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.716248312400184,
			["panH"] = -0.02562382862686221,
		},
		["scale"] = 0.4999999999999996,
	},
	[291] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.8199999799039713,
			["panH"] = 0.2306259849784855,
		},
		["scale"] = 1.2,
	},
	[292] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537494558880863,
			["panH"] = -0.02562815137813846,
		},
		["scale"] = 0.95,
	},
	[293] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125089931718091,
			["panH"] = -0.05124765725372778,
		},
		["scale"] = 0.7499999999999998,
	},
	[294] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3331252620079452,
			["panH"] = 0.07687869046603875,
		},
		["scale"] = 2.050000000000001,
	},
	[295] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7431252519599304,
			["panH"] = 0.07687580863186173,
		},
		["scale"] = 1.05,
	},
	[296] = {
		["rotation"] = 0.1374998999833594,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562454908540816,
			["panH"] = -0.05125342092209551,
		},
		["scale"] = 1,
	},
	[297] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.5381248967546647,
			["panH"] = -0.02562526954395693,
		},
		["scale"] = 1.550000000000001,
	},
	[298] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.383751226890408,
			["panH"] = -0.7431241712721115,
		},
		["scale"] = 0.7999999999999998,
	},
	[299] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3843747204080308,
			["panH"] = 0.05125342092208629,
		},
		["scale"] = 1,
	},
	[300] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1281245465734031,
			["panH"] = -0.2049992745174514,
		},
		["scale"] = 1,
	},
	[301] = {
		["rotation"] = 0.8249963072000683,
		["zoom"] = -2.625001780744966,
		["position"] = {
			["panV"] = 0.6662505240158854,
			["panH"] = -1.691250498895861,
		},
		["scale"] = 0.7499999999999998,
	},
	[302] = {
		["rotation"] = 0.1099980643666302,
		["zoom"] = -8.458336201169939,
		["position"] = {
			["panV"] = 17.21999957798343,
			["panH"] = -1.94749743066703,
		},
		["scale"] = 0.2,
	},
	[303] = {
		["rotation"] = 0.3025000892334043,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.076250513967874,
			["panH"] = 0.07687580863186173,
		},
		["scale"] = 0.6999999999999997,
	},
	[304] = {
		["rotation"] = -0.2200023141334548,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562599000249782,
			["panH"] = 0.1537458535953604,
		},
		["scale"] = 1.15,
	},
	[305] = {
		["rotation"] = 0.4125012463001365,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.332499967343956,
			["panH"] = -0.8199999799039822,
		},
		["scale"] = 0.6499999999999997,
	},
	[306] = {
		["rotation"] = 0.2199992214333575,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.07687508817331354,
			["panH"] = 0.05124189358535551,
		},
		["scale"] = 0.5999999999999996,
	},
	[307] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2562501738346276,
			["panH"] = 0.2562483726882608,
		},
		["scale"] = 1.15,
	},
	[308] = {
		["rotation"] = -1.347494071516785,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 11.88999970860762,
			["panH"] = 0.1025082827612636,
		},
		["scale"] = 3.099999999999997,
	},
	[309] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[310] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2306245440613982,
			["panH"] = 1.383747264368404,
		},
		["scale"] = 1.25,
	},
	[311] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1281245465734042,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 0.7499999999999998,
	},
	[312] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562526954395241,
			["panH"] = 0.02562238770976629,
		},
		["scale"] = 0.7499999999999998,
	},
	[313] = {
		["rotation"] = 0.494999021400086,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.075624859074612,
			["panH"] = -9.083012120214562e-015,
		},
		["scale"] = 0.4499999999999996,
	},
	[314] = {
		["rotation"] = -0.5774967965000306,
		["zoom"] = -4.229167690567909,
		["position"] = {
			["panV"] = 0.07687508817331473,
			["panH"] = 3.22875226236216,
		},
		["scale"] = 1.3,
	},
	[315] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.665625589581171,
			["panH"] = 0.2050021563516238,
		},
		["scale"] = 0.6499999999999997,
	},
	[316] = {
		["rotation"] = 0.1100042497668247,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687544840258909,
			["panH"] = -6.938893903907228e-018,
		},
		["scale"] = 0.8999999999999999,
	},
	[317] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.306875058029274,
			["panH"] = 2.881834181546472e-006,
		},
		["scale"] = 1,
	},
	[318] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.280000640074438,
			["panH"] = -0.128123465885585,
		},
		["scale"] = 0.5499999999999996,
	},
	[319] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.614375410722538,
			["panH"] = 0.3331241813201271,
		},
		["scale"] = 0.6999999999999997,
	},
	[320] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -7.204585459677504e-007,
			["panH"] = -0.2306245440614083,
		},
		["scale"] = 1.2,
	},
	[321] = {
		["rotation"] = -0.1100011570667324,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1537494558880896,
			["panH"] = -4.524158825347513e-015,
		},
		["scale"] = 0.95,
	},
	[322] = {
		["rotation"] = 0.385000957033451,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.640000680266491,
			["panH"] = -0.9737515971676968,
		},
		["scale"] = 0.7499999999999998,
	},
	[323] = {
		["rotation"] = 0.1374983536333106,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7431252519599289,
			["panH"] = -0.0768758086318662,
		},
		["scale"] = 1.1,
	},
	[324] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3075003526932632,
			["panH"] = -0.05125053908790934,
		},
		["scale"] = 1.700000000000001,
	},
	[325] = {
		["rotation"] = 0.330000378500085,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.306249042906742,
			["panH"] = -0.05124765725372331,
		},
		["scale"] = 0.6999999999999997,
	},
	[326] = {
		["rotation"] = 0.3300003785000849,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1793743652027659,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 0.7999999999999998,
	},
	[327] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3587498110933511,
			["panH"] = -0.1024981963416372,
		},
		["scale"] = 0.7999999999999998,
	},
	[328] = {
		["rotation"] = 2.742499332232235,
		["zoom"] = 0.4958344487286827,
		["position"] = {
			["panV"] = 12.09500078427141,
			["panH"] = 0.9993711030432793,
		},
		["scale"] = 0.15,
	},
	[329] = {
		["rotation"] = 0.3575006677667704,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.4868757985838461,
			["panH"] = 0.02562526954394785,
		},
		["scale"] = 1.1,
	},
	[330] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 5.227499511658556,
			["panH"] = -0.1537516172637234,
		},
		["scale"] = 0.8999999999999999,
	},
	[331] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687508817331637,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 1,
	},
	[332] = {
		["rotation"] = 0.2200023141334548,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1024992770294507,
			["panH"] = -0.05125053908790933,
		},
		["scale"] = 0.8499999999999999,
	},
	[333] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[334] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.20437542077055,
			["panH"] = 0.05125053908790024,
		},
		["scale"] = 1,
	},
	[335] = {
		["rotation"] = 0.4399999892167686,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.306249763365289,
			["panH"] = -0.7175061063136128,
		},
		["scale"] = 0.5499999999999996,
	},
	[336] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319519,
			["panH"] = -0.1537487354295465,
		},
		["scale"] = 1.2,
	},
	[337] = {
		["rotation"] = 0.08249777509994936,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.614999624698705,
			["panH"] = 0.3331256222372132,
		},
		["scale"] = 1,
	},
	[338] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125089931718091,
			["panH"] = -0.05124765725372778,
		},
		["scale"] = 0.7499999999999998,
	},
	[339] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1281252670319519,
			["panH"] = -0.02562238770977538,
		},
		["scale"] = 0.8999999999999999,
	},
	[340] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3331259824664862,
			["panH"] = -0.07687292679768475,
		},
		["scale"] = 1.35,
	},
	[341] = {
		["rotation"] = 0.1925020248667742,
		["zoom"] = 0.233332507580835,
		["position"] = {
			["panV"] = 2.99812555692513,
			["panH"] = -0.6662541263086081,
		},
		["scale"] = 0.2999999999999997,
	},
	[342] = {
		["rotation"] = 0.3300003785000898,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3331249017786714,
			["panH"] = -0.6662541263086219,
		},
		["scale"] = 1.1,
	},
	[343] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.870625224327893,
			["panH"] = -0.3587537736153427,
		},
		["scale"] = 0.6999999999999997,
	},
	[344] = {
		["rotation"] = 0.3025031819335016,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.357500302453195,
			["panH"] = 0.3843732794909316,
		},
		["scale"] = 0.3499999999999996,
	},
	[345] = {
		["rotation"] = 0.4124981536000345,
		["zoom"] = -0.1458336372721389,
		["position"] = {
			["panV"] = -0.3587505315518976,
			["panH"] = -0.1281292295539526,
		},
		["scale"] = 0.8999999999999999,
	},
	[346] = {
		["rotation"] = 0.3025000892334042,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3587494508640785,
			["panH"] = 0.02562526954395697,
		},
		["scale"] = 1.750000000000001,
	},
	[347] = {
		["rotation"] = -0.1100011570667225,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.101875063053283,
			["panH"] = 0.1793682413051268,
		},
		["scale"] = 0.6999999999999997,
	},
	[348] = {
		["rotation"] = 0.4950021141001831,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -2.280625214279881,
			["panH"] = -2.56249525421938,
		},
		["scale"] = 0.4499999999999994,
	},
	[349] = {
		["rotation"] = -0.1374983536333108,
		["zoom"] = -6.504167839822218,
		["position"] = {
			["panV"] = 4.40749917152531,
			["panH"] = 0.7943747103600207,
		},
		["scale"] = 0.5499999999999996,
	},
	[350] = {
		["rotation"] = 0.3575006677667705,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3843739999494866,
			["panH"] = 0.02562815137813395,
		},
		["scale"] = 0.7999999999999998,
	},
	[351] = {
		["rotation"] = 0.3849978643333538,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.845000675242484,
			["panH"] = -0.6918765140183837,
		},
		["scale"] = 0.7499999999999998,
	},
	[352] = {
		["rotation"] = 0.467501824833498,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.02562599000250002,
			["panH"] = 0.05123901175117414,
		},
		["scale"] = 0.95,
	},
	[353] = {
		["rotation"] = 0,
		["zoom"] = 0.3499999914224269,
		["position"] = {
			["panV"] = 0.1024992770294507,
			["panH"] = 0.07687292679767566,
		},
		["scale"] = 0.7999999999999998,
	},
	[354] = {
		["rotation"] = 0,
		["zoom"] = 0.4083331183176366,
		["position"] = {
			["panV"] = 0.3587505315518948,
			["panH"] = 0.05124765725372781,
		},
		["scale"] = 1.1,
	},
	[355] = {
		["rotation"] = 0.02750338196677767,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024989168001769,
			["panH"] = -0.02561950587560294,
		},
		["scale"] = 0.95,
	},
	[356] = {
		["rotation"] = 0.05500057853336616,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.07687508817331637,
			["panH"] = 0,
		},
		["scale"] = 1,
	},
	[357] = {
		["rotation"] = -0.1650017356000935,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1024996372587257,
			["panH"] = -0.1024981963416371,
		},
		["scale"] = 1.15,
	},
	[358] = {
		["rotation"] = 0.2749967072666266,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.204375780999824,
			["panH"] = -0.2049992745174467,
		},
		["scale"] = 0.6999999999999997,
	},
	[359] = {
		["rotation"] = -0.1099980643666301,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2306252645199473,
			["panH"] = -0.1024981963416371,
		},
		["scale"] = 1.15,
	},
	[360] = {
		["rotation"] = 0.02749719656658324,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1793750856613136,
			["panH"] = 0.02562815137813397,
		},
		["scale"] = 0.7999999999999998,
	},
	[361] = {
		["rotation"] = 0.330003471200187,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.844376101037042,
			["panH"] = 0.128129229553939,
		},
		["scale"] = 0.4499999999999996,
	},
	[362] = {
		["rotation"] = 0.6325004677334941,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.384375440866578,
			["panH"] = 0.1793740049734898,
		},
		["scale"] = 1.3,
	},
	[363] = {
		["rotation"] = 0.05500367123346341,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2050007154345399,
			["panH"] = 0.02562526954394786,
		},
		["scale"] = 1.800000000000001,
	},
	[364] = {
		["rotation"] = 0.275002892666821,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.793750496383851,
			["panH"] = 0.4099985490349026,
		},
		["scale"] = 0.3999999999999996,
	},
	[365] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3075007129225327,
			["panH"] = -0.07687292679768475,
		},
		["scale"] = 1.35,
	},
	[366] = {
		["rotation"] = 0.1100011570667324,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 2.485625929714418,
			["panH"] = 0.2049963926832652,
		},
		["scale"] = 0.3999999999999996,
	},
	[367] = {
		["rotation"] = 0.5225024033668593,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -3.602292734036783e-007,
			["panH"] = 0.4356223776617553,
		},
		["scale"] = 1.5,
	},
	[368] = {
		["rotation"] = 0.2200023141334548,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.537500322549221,
			["panH"] = -0.1024981963416371,
		},
		["scale"] = 0.6999999999999997,
	},
	[369] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.6662498035573404,
			["panH"] = -0.3587508917811746,
		},
		["scale"] = 0.95,
	},
	[370] = {
		["rotation"] = 0.4749973995673926,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.279998838928076,
			["panH"] = -0.9993739848774684,
		},
		["scale"] = 0.2999999999999996,
	},
	[371] = {
		["rotation"] = 0.3025000892334042,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.3587498110933511,
			["panH"] = -0.02562238770976627,
		},
		["scale"] = 2.3,
	},
	[372] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.896249773413303,
			["panH"] = -0.768755204484431,
		},
		["scale"] = 0.4499999999999996,
	},
	[373] = {
		["rotation"] = 0.632500467733494,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.640000320037219,
			["panH"] = 0.2818722013151224,
		},
		["scale"] = 1,
	},
	[374] = {
		["rotation"] = 0.5774983428500791,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.7687501612746094,
			["panH"] = 0.02562526954395239,
		},
		["scale"] = 0.95,
	},
	[375] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 3.280000640074438,
			["panH"] = -0.128123465885585,
		},
		["scale"] = 0.5499999999999996,
	},
	[376] = {
		["rotation"] = 0.1650017356000936,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.793750136154576,
			["panH"] = -0.05125342092209097,
		},
		["scale"] = 0.5999999999999996,
	},
	[377] = {
		["rotation"] = 0.275002892666821,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.127499612138692,
			["panH"] = 0.307497470859084,
		},
		["scale"] = 0.4999999999999996,
	},
	[378] = {
		["rotation"] = 0.4949990214000812,
		["zoom"] = 0.4083331183176366,
		["position"] = {
			["panV"] = 1.050625604653192,
			["panH"] = -0.281875083149313,
		},
		["scale"] = 0.5999999999999996,
	},
	[379] = {
		["rotation"] = 0.08250241415009138,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.6406259749304776,
			["panH"] = 0.05125342092209096,
		},
		["scale"] = 5.04999999999999,
	},
	[380] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.2818747229200352,
			["panH"] = 0.3075061163616285,
		},
		["scale"] = 1.25,
	},
	[381] = {
		["rotation"] = 0.3575006677667703,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.02562454908540815,
			["panH"] = 0.0512476572537187,
		},
		["scale"] = 0.6499999999999997,
	},
	[382] = {
		["rotation"] = 0.275002892666821,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.409375055517273,
			["panH"] = 0.4099985490348981,
		},
		["scale"] = 0.4499999999999996,
	},
	[383] = {
		["rotation"] = 0,
		["zoom"] = 0.1458324072209628,
		["position"] = {
			["panV"] = 3.561875723223746,
			["panH"] = 1.050628846716641,
		},
		["scale"] = 0.2499999999999997,
	},
	[384] = {
		["rotation"] = -0.6050001784668035,
		["zoom"] = -2.829166904844084,
		["position"] = {
			["panV"] = 0.5637505265278885,
			["panH"] = 2.17812917931388,
		},
		["scale"] = 0.8499999999999999,
	},
	[385] = {
		["rotation"] = 0.1924958394665795,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.4612498085813472,
			["panH"] = 0.07687869046604325,
		},
		["scale"] = 0.95,
	},
	[386] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.1537501763466294,
			["panH"] = -0.4612490881228074,
		},
		["scale"] = 1.35,
	},
	[387] = {
		["rotation"] = 0,
		["zoom"] = 2.012500668208809,
		["position"] = {
			["panV"] = 1.306875058029274,
			["panH"] = 0.2818779649834901,
		},
		["scale"] = 4.199999999999993,
	},
	[388] = {
		["rotation"] = -0.5774967965000306,
		["zoom"] = -2.158334715498007,
		["position"] = {
			["panV"] = 0.7687490805867946,
			["panH"] = 1.691251939812928,
		},
		["scale"] = 0.7604167432743446,
	},
	[389] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 4.868750781253024,
			["panH"] = -0.05125053908790932,
		},
		["scale"] = 0.6499999999999997,
	},
	[390] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.101875063053285,
			["panH"] = 2.88183418156035e-006,
		},
		["scale"] = 0.7999999999999998,
	},
	[391] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562490931468086,
			["panH"] = -4.551914400963142e-015,
		},
		["scale"] = 0.7999999999999998,
	},
	[392] = {
		["rotation"] = 0.02749719656658325,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.3587498110933499,
			["panH"] = 2.881834176932108e-006,
		},
		["scale"] = 1,
	},
	[393] = {
		["rotation"] = 0.08249777509994952,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.486250143690586,
			["panH"] = 0.8968772294529255,
		},
		["scale"] = 0.4999999999999996,
	},
	[394] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9225003376212411,
			["panH"] = 0.5124996272107124,
		},
		["scale"] = 1.2,
	},
	[395] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -2.178124856562611,
			["panH"] = -2.881834186084509e-006,
		},
		["scale"] = 1,
	},
	[396] = {
		["rotation"] = 0.2475026034001355,
		["zoom"] = 1.5166674495313,
		["position"] = {
			["panV"] = 3.946251524319601,
			["panH"] = 0.02562238770976643,
		},
		["scale"] = 0.2499999999999997,
	},
	[397] = {
		["rotation"] = 0.3024969965333069,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.5893750756132982,
			["panH"] = 0.02562526954395246,
		},
		["scale"] = 1.1,
	},
	[398] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125017885863663,
			["panH"] = 0.02562238770977085,
		},
		["scale"] = 0.8999999999999999,
	},
	[399] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2050007154345398,
			["panH"] = 0.02562526954394787,
		},
		["scale"] = 1.05,
	},
	[400] = {
		["rotation"] = 0.1924989321666768,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.02562490931467972,
			["panH"] = -0.1793768868076804,
		},
		["scale"] = 1.3,
	},
	[401] = {
		["rotation"] = 0.1100011570667272,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -1.460625954834452,
			["panH"] = -0.02562526954395245,
		},
		["scale"] = 2.449999999999999,
	},
	[402] = {
		["rotation"] = 0.2200023141334548,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05124837771227208,
			["panH"] = -0.0768786904660432,
		},
		["scale"] = 0.95,
	},
	[403] = {
		["rotation"] = 0.6049970857667113,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.2049996347467206,
			["panH"] = -0.1793740049734989,
		},
		["scale"] = 1,
	},
	[404] = {
		["rotation"] = 0.2200023141334597,
		["zoom"] = -2.01250107822587,
		["position"] = {
			["panV"] = 4.048750080890503,
			["panH"] = 0.07687580863185262,
		},
		["scale"] = 0.3999999999999996,
	},
	[405] = {
		["rotation"] = 0,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.05125017885863549,
			["panH"] = -0.02562526954395695,
		},
		["scale"] = 0.8499999999999999,
	},
	[406] = {
		["rotation"] = 3.092700097184764e-006,
		["zoom"] = 0,
		["position"] = {
			["panV"] = -0.1025003577172716,
			["panH"] = -0.02561950587558928,
		},
		["scale"] = 0.95,
	},
	[407] = {
		["rotation"] = 0.275002892666821,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 1.614374690263994,
			["panH"] = 0.1281234658855897,
		},
		["scale"] = 0.3999999999999996,
	},
	[408] = {
		["rotation"] = 0.3025031819335015,
		["zoom"] = 0,
		["position"] = {
			["panV"] = 0.9737490755627857,
			["panH"] = 0.5124981862936124,
		},
		["scale"] = 0.7499999999999998,
	},
}

end