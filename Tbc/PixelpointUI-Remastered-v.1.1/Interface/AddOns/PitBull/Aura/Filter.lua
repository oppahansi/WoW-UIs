if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 69018 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:GetModule("Aura")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 69018 $", "$Date: 2008-04-10 22:12:48 -0400 (Thu, 10 Apr 2008) $")

local newList, del = Rock:GetRecyclingFunctions("PitBull", "newList", "del")

local _G = _G
local pairs = _G.pairs
local GetSpellInfo = _G.GetSpellInfo

local canDispel, friendBuffs, friendDebuffs, selfBuffs, selfDebuffs, petBuffs, petDebuffs, enemyDebuffs
local totalSelfBuffs, totalPetBuffs, totalSelfDebuffs, totalPetDebuffs, allFriendlyBuffs, allFriendlyDebuffs
local _, playerClass = _G.UnitClass('player')
local _, playerRace = _G.UnitRace('player')
if playerClass == 'PRIEST' then
	canDispel = {
		["Magic"] = true,
		["Disease"] = true,
	}
	selfBuffs = {
		[27811] = true, -- Blessed Recovery
		[586]   = true, -- Fade
		[6347]  = playerRace == "Human" or nil, -- Feedback
		[14743] = true, -- Focused Casting
		[588]   = true, -- Inner Fire
		[14751] = true, -- Inner Focus
		[1706]  = true, -- Levitate
		[33206] = true, -- Pain Suppression
		[15473] = true, -- Shadowform
		[18137] = playerRace == "Troll" or nil, -- Shadowguard
		[2652]  = (playerRace == "BloodElf" or playerRace == "Scourge") or nil, -- Touch of Weakness
	}
	selfDebuffs = {
		[2096]  = true, -- Mind Vision
	}
	friendBuffs = {
		[552] = true, -- Abolish Disease
		[14752] = true, -- Divine Spirit
		[2651]  = playerRace == "NightElf" or nil, -- Elune's Grace
		[6346]  = true, -- Fear Ward
		[14892] = true, -- Inspiration
		[10060] = true, -- Power Infusion
		[1243]  = true, -- Power Word: Fortitude
		[17]    = true, -- Power Word: Shield
		[21562] = true, -- Prayer of Fortitude
		[33076] = true, -- Prayer of Mending
		[27683] = true, -- Prayer of Shadow Protection
		[27681] = true, -- Prayer of Spirit
		[139]   = true, -- Renew
		[976]   = true, -- Shadow Protection
		[32548] = playerRace == "Draenei" or nil, -- Symbol of Hope
	}
	enemyDebuffs = {
		[2944]  = playerRace == "Scourge" or nil, -- Devouring Plague
		[9035]  = playerRace == "Troll" or nil, -- Hex of Weakness
		[14914] = true, -- Holy Fire
		[605]   = true, -- Mind Control
		[15407] = true, -- Mind Flay
		[453]   = true, -- Mind Soothe
		[2096]  = true, -- Mind Vision
		[8122]  = true, -- Psychic Scream
		[9484]  = true, -- Shackle Undead
		[15258] = true, -- Shadow Vulnerability
		[589]   = true, -- Shadow Word: Pain
		[6726]  = true, -- Silence
		[10797] = playerRace == "NightElf" or nil, -- Starshards
		[2652]  = (playerRace == "BloodElf" or playerRace == "Scourge") or nil, -- Touch of Weakness
		[15286] = true, -- Vampiric Embrace
		[34914] = true, -- Vampiric Touch
	}
	friendDebuffs = {
		[6788]  = true, -- Weakened Soul
	}
elseif playerClass == 'SHAMAN' then
	canDispel = {
		["Poison"] = true,
		["Disease"] = true,
	}
	selfBuffs = {
		[12536] = true, -- Clearcasting
		[29177] = true, -- Elemental Devastation
		[16166] = true, -- Elemental Mastery
		[6196]  = true, -- Far Sight
		[14743] = true, -- Focused Casting
		[2645]  = true, -- Ghost Wolf
		[324]   = true, -- Lightning Shield
		[16188] = true, -- Nature's Swiftness
		[6495]  = true, -- Sentry Totem
		[30823] = true, -- Shamanistic Rage
		[23575] = true, -- Water Shield
	}
	friendBuffs = {
		[16177] = true, -- Ancestral Fortitude
		[2825]  = (playerRace == "Troll" or playerRace == "Tauren" or playerRace == "Orc") or nil, -- Bloodlust
		[379]   = true, -- Earth Shield
		[4057]  = true, -- Fire Resistance
		[4077]  = true, -- Frost Resistance
		[8836]  = true, -- Grace of Air
		[8178]  = true, -- Grounding Totem Effect
		[5672]  = true, -- Healing Stream
		[29202] = true, -- Healing Way
		[23682] = playerRace == "Draenei" or nil, -- Heroism
		[5677]  = true, -- Mana Spring
		[16191] = true, -- Mana Tide
		[4081]  = true, -- Nature Resistance
		[8072]  = true, -- Stoneskin
		[8076]  = true, -- Strength of Earth
		[30706] = true, -- Totem of Wrath
		[25909] = true, -- Tranquil Air
		[131]   = true, -- Water Breathing
		[546]   = true, -- Water Walking
		[15108] = true, -- Windwall
		[2895]  = true, -- Wrath of Air Totem
	}
	enemyDebuffs = {
		[3600]  = true, -- Earthbind
		[8050]  = true, -- Flame Shock
		[8056]  = true, -- Frost Shock
		[8034]  = true, -- Frostbrand Attack
		[39796] = true, -- Stoneclaw Stun
		[17364] = true, -- Stormstrike
	}
elseif playerClass == 'PALADIN' then
	canDispel = {
		["Magic"] = true,
		["Poison"] = true,
		["Disease"] = true,
	}
	selfBuffs = {
		[31884] = true, -- Avenging Wrath
		[20216] = true, -- Divine Favor
		[31842] = true, -- Divine Illumination
		[498]   = true, -- Divine Protection
		[642]   = true, -- Divine Shield
		[9800]  = true, -- Holy Shield
		[25780] = true, -- Righteous Fury
		[31892] = playerRace == "BloodElf" or nil, -- Seal of Blood
		[20375] = true, -- Seal of Command
		[20164] = true, -- Seal of Justice
		[20165] = true, -- Seal of Light
		[20154] = true, -- Seal of Righteousness
		[31801] = true, -- Seal of Vengeance
		[20166] = true, -- Seal of Wisdom
		[20162] = true, -- Seal of the Crusader
		[5502]  = true, -- Sense Undead
		[23214] = true, -- Summon Charger
		[13819] = true, -- Summon Warhorse
		[8602]  = true, -- Vengeance
	}
	friendBuffs = {
		[1044]  = true, -- Blessing of Freedom
		[20217] = true, -- Blessing of Kings
		[19977] = true, -- Blessing of Light
		[19740] = true, -- Blessing of Might
		[1022]  = true, -- Blessing of Protection
		[6940]  = true, -- Blessing of Sacrifice
		[1038]  = true, -- Blessing of Salvation
		[20911] = true, -- Blessing of Sanctuary
		[19742] = true, -- Blessing of Wisdom
		[19746] = true, -- Concentration Aura
		[32223] = true, -- Crusader Aura
		[465]   = true, -- Devotion Aura
		[19752] = true, -- Divine Intervention
		[19891] = true, -- Fire Resistance Aura
		[19888] = true, -- Frost Resistance Aura
		[25898] = true, -- Greater Blessing of Kings
		[25890] = true, -- Greater Blessing of Light
		[25782] = true, -- Greater Blessing of Might
		[25895] = true, -- Greater Blessing of Salvation
		[25899] = true, -- Greater Blessing of Sanctuary
		[25894] = true, -- Greater Blessing of Wisdom
		[7294]  = true, -- Retribution Aura
		[20218] = true, -- Sanctity Aura
		[19876] = true, -- Shadow Resistance Aura
	}
	enemyDebuffs = {
		[31935] = true, -- Avenger's Shield
		[20116] = true, -- Consecration
		[853]   = true, -- Hammer of Justice
		[31803] = true, -- Holy Vengeance
		[20184] = true, -- Judgement of Justice
		[20185] = true, -- Judgement of Light
		[20186] = true, -- Judgement of Wisdom
		[20188] = true, -- Judgement of the Crusader
		[20066] = true, -- Repentance
		[25]    = true, -- Stun, from Seal of Justice
		[2878]  = true, -- Turn Undead
	}
	friendDebuffs = {
		[25771] = true, -- Forbearance
	}
elseif playerClass == 'MAGE' then
	canDispel = {
		["Curse"] = true,
	}
	selfBuffs = {
		[12042] = true, -- Arcane Power
		[31641] = true, -- Blazing Speed
		[1953]  = true, -- Blink
		[12536] = true, -- Clearcasting
		[11129] = true, -- Combustion
		[12051] = true, -- Evocation
		[543]   = true, -- Fire Ward
		[168]   = true, -- Frost Armor
		[6143]  = true, -- Frost Ward
		[7302]  = true, -- Ice Armor
		[11426] = true, -- Ice Barrier
		[27619] = true, -- Ice Block
		[66]    = true, -- Invisibility
		[6117]  = true, -- Mage Armor
		[1463]  = true, -- Mana Shield
		[30482] = true, -- Molten Armor
		[12043] = true, -- Presence of Mind
		[130]   = true, -- Slow Fall
	}
	selfDebuffs = {
		[10833] = true, -- Arcane Blast
		[41425] = true, -- Hypothermia
	}
	friendBuffs = {
		[1008]  = true, -- Amplify Magic
		[23028] = true, -- Arcane Brilliance
		[1459]  = true, -- Arcane Intellect
		[604]   = true, -- Dampen Magic
	}
	enemyDebuffs = {
		[1831]  = true, -- Blast Wave
		[10]    = true, -- Blizzard
		[6136]  = true, -- Chilled
		[120]   = true, -- Cone of Cold
		[2855]  = true, -- Detect Magic
		[29964] = true, -- Dragon's Breath
		[22959] = true, -- Fire Vulnerability
		[133]   = true, -- Fireball
		[2120]  = true, -- Flamestrike
		[168]   = true, -- Frost Armor
		[122]   = true, -- Frost Nova
		[11071] = true, -- Frostbite
		[116]   = true, -- Frostbolt
		[7302]  = true, -- Ice Armor
		[3261]  = true, -- Ignite
		[11103] = true, -- Impact
		[118]   = true, -- Polymorph
		[11366] = true, -- Pyroblast
		[246]   = true, -- Slow
		[11180] = true, -- Winter's Chill
	}
elseif playerClass == 'DRUID' then
	canDispel = {
		["Curse"] = true,
		["Poison"] = true,
	}
	selfBuffs = {
		[1066]  = true, -- Aquatic Form
		[20655] = true, -- Barkskin
		[5487]  = true, -- Bear Form
		[768]   = true, -- Cat Form
		[12536] = true, -- Clearcasting
		[1850]  = true, -- Dash
		[9634]  = true, -- Dire Bear Form
		[3019]  = true, -- Enrage
		[33943] = true, -- Flight Form
		[22842] = true, -- Frenzied Regeneration
		[24858] = true, -- Moonkin Form
		[16689] = true, -- Nature's Grasp
		[16188] = true, -- Nature's Swiftness
		[16864] = true, -- Omen of Clarity
		[5215]  = true, -- Prowl
		[40120] = true, -- Swift Flight Form
		[5217]  = true, -- Tiger's Fury
		[5225]  = true, -- Track Humanoids
		[783]   = true, -- Travel Form
	}
	friendBuffs = {
		[2893]  = true, -- Abolish Poison
		[21849] = true, -- Gift of the Wild
		[29166] = true, -- Innervate
		[17007] = true, -- Leader of the Pack
		[33763] = true, -- Lifebloom
		[1126]  = true, -- Mark of the Wild
		[24907] = true, -- Moonkin Aura
		[8936]  = true, -- Regrowth
		[774]   = true, -- Rejuvenation
		[467]   = true, -- Thorns
		[740]   = true, -- Tranquility
		[5420]  = true, -- Tree of Life
	}
	enemyDebuffs = {
		[5211]  = true, -- Bash
		[5209]  = true, -- Challenging Roar
		[29538] = true, -- Cyclone
		[99]    = true, -- Demoralizing Roar
		[339]   = true, -- Entangling Roots
		[770]   = true, -- Faerie Fire
		[16857] = true, -- Faerie Fire (Feral)
		[16979] = true, -- Feral Charge
		[2637]  = true, -- Hibernate
		[16914] = true, -- Hurricane
		[5570]  = true, -- Insect Swarm
		[5422]  = true, -- Lacerate
		[22570] = true, -- Maim
		[33878] = true, -- Mangle (Bear)
		[33876] = true, -- Mangle (Cat)
		[563]   = true, -- Moonfire
		[9005]  = true, -- Pounce
		[1822]  = true, -- Rake
		[1079]  = true, -- Rip
		[2908]  = true, -- Soothe Animal
	}
elseif playerClass == 'WARRIOR' then
	selfBuffs = {
		[18499] = true, -- Berserker Rage
		[16487] = true, -- Blood Craze
		[2687]  = true, -- Bloodrage
		[12331] = true, -- Bloodthirst
		[3019]  = true, -- Enrage
		[12319] = true, -- Flurry
		[12975] = true, -- Last Stand
		[8285]  = true, -- Rampage
		[1719]  = true, -- Recklessness
		[20230] = true, -- Retaliation
		[15604] = true, -- Second Wind
		[2565]  = true, -- Shield Block
		[871]   = true, -- Shield Wall
		[9941]  = true, -- Spell Reflection
		[12328] = true, -- Sweeping Strikes
		-- T4, Tank, 2/4 piece bonus
		[37514] = true, -- Blade Turning
		[6572]  = true, -- Revenge
		-- T5, Tank, 2/4 piece bonus
		[37525] = true, -- Battle Rush
		[37523] = true, -- Reinforced Shield
		-- T5, DPS, 2 piece bonus
		[7384]  = true, -- Overpower
	}
	selfDebuffs = {
		[12292] = true, -- Death Wish
	}
	friendBuffs = {
		[2048]  = true, -- Battle Shout
		[469]   = true, -- Commanding Shout
		[3411]  = true, -- Intervene
	}
	enemyDebuffs = {
		[16952] = true, -- Blood Frenzy
		[1161]  = true, -- Challenging Shout
		[7922]  = true, -- Charge Stun
		[12809] = true, -- Concussion Blow
		[1604]  = true, -- Dazed
		[12721] = true, -- Deep Wound
		[1160]  = true, -- Demoralizing Shout
		[676]   = true, -- Disarm
		[1715]  = true, -- Hamstring
		[12289] = true, -- Improved Hamstring
		[20253] = true, -- Intercept Stun
		[5246]  = true, -- Intimidating Shout
		[5530]  = true, -- Mace Stun Effect
		[694]   = true, -- Mocking Blow
		[9347]  = true, -- Mortal Strike
		[10576] = true, -- Piercing Howl
		[772]   = true, -- Rend
		[12798] = true, -- Revenge Stun
		[18498] = true, -- Shield Bash - Silenced
		[7386]  = true, -- Sunder Armor
		[355]   = true, -- Taunt
		[6343]  = true, -- Thunder Clap
	}
elseif playerClass == 'WARLOCK' then
	canDispel = {
		["Magic"] = true,
	}
	selfBuffs = {
		[18288] = true, -- Amplify Curse
		[34935] = true, -- Backlash
		[706]   = true, -- Demon Armor
		[687]   = true, -- Demon Skin
		[35691] = true, -- Demonic Knowledge
		[18788] = true, -- Demonic Sacrifice
		[28176] = true, -- Fel Armor
		[18708] = true, -- Fel Domination
		[23759] = true, -- Master Demonologist
		[30299] = true, -- Nether Protection
		[1050]  = true, -- Sacrifice
		[5500]  = true, -- Sense Demons
		[17941] = true, -- Shadow Trance
		[6229]  = true, -- Shadow Ward
		[19028] = true, -- Soul Link
		[23161] = true, -- Summon Dreadsteed
		[1710]  = true, -- Summon Felsteed
	}
	friendBuffs = {
		[6307]  = true, -- Blood Pact
		[132]   = true, -- Detect Invisibility
		[134]   = true, -- Fire Shield
		[19480] = true, -- Paranoia
		[20707] = true, -- Soulstone Resurrection
		[5697]  = true, -- Unending Breath
	}
	enemyDebuffs = {
		[18118] = true, -- Aftermath
		[710]   = true, -- Banish
		[172]   = true, -- Corruption
		[89]    = true, -- Cripple
		[980]   = true, -- Curse of Agony
		[603]   = true, -- Curse of Doom
		[18223] = true, -- Curse of Exhaustion
		[704]   = true, -- Curse of Recklessness
		[17862] = true, -- Curse of Shadow
		[1714]  = true, -- Curse of Tongues
		[702]   = true, -- Curse of Weakness
		[1490]  = true, -- Curse of the Elements
		[6789]  = true, -- Death Coil
		[689]   = true, -- Drain Life
		[5138]  = true, -- Drain Mana
		[1120]  = true, -- Drain Soul
		[5782]  = true, -- Fear
		[1949]  = true, -- Hellfire
		[5484]  = true, -- Howl of Terror
		[348]   = true, -- Immolate
		[1122]  = true, -- Inferno
		[18073] = true, -- Pyroclasm
		[4629]  = true, -- Rain of Fire
		[6358]  = true, -- Seduction
		[27243] = true, -- Seed of Corruption
		[32385] = true, -- Shadow Embrace
		[15258] = true, -- Shadow Vulnerability
		[17877] = true, -- Shadowburn
		[30283] = true, -- Shadowfury
		[6726]  = true, -- Silence
		[18265] = true, -- Siphon Life
		[6360]  = true, -- Soothing Kiss
		[19244] = true, -- Spell Lock
		[17735] = true, -- Suffering
		[19478] = true, -- Tainted Blood
		[30108] = true, -- Unstable Affliction
	}
	petBuffs = {
		[23257] = true, -- Demonic Frenzy
		[19705] = true, -- Well Fed
	}
elseif playerClass == 'HUNTER' then
	canDispel = {
		["Magic"] = true,
	}
	selfBuffs = {
		[13161] = true, -- Aspect of the Beast
		[5118]  = true, -- Aspect of the Cheetah
		[13165] = true, -- Aspect of the Hawk
		[13163] = true, -- Aspect of the Monkey
		[34074] = true, -- Aspect of the Viper
		[19263] = true, -- Deterrence
		[6197]  = true, -- Eagle Eye
		[1002]  = true, -- Eyes of the Beast
		[5384]  = true, -- Feign Death
		[34506] = true, -- Master Tactician
		[6150]  = true, -- Quick Shots
		[3045]  = true, -- Rapid Fire
		[34948] = true, -- Rapid Killing
		[34471] = true, -- The Beast Within
	}
	friendBuffs = {
		[13159] = true, -- Aspect of the Pack
		[20043] = true, -- Aspect of the Wild
		[34455] = true, -- Ferocious Inspiration
		[34477] = true, -- Misdirection
		[19578] = true, -- Spirit Bond
		[19506] = true, -- Trueshot Aura
	}
	enemyDebuffs = {
		[19434] = true, -- Aimed Shot
		[1462]  = true, -- Beast Lore
		[3385]  = true, -- Boar Charge
		[35100] = true, -- Concussive Barrage
		[5116]  = true, -- Concussive Shot
		[19306] = true, -- Counterattack
		[3408]  = true, -- Crippling Poison
		[2818]  = true, -- Deadly Poison
		[19184] = true, -- Entrapment
		[13812] = true, -- Explosive Trap Effect
		[7140]  = true, -- Expose Weakness
		[34889] = true, -- Fire Breath
		[1543]  = true, -- Flare
		[3355]  = true, -- Freezing Trap Effect
		[13810] = true, -- Frost Trap Aura
		[1853]  = true, -- Growl
		[1130]  = true, -- Hunter's Mark
		[19407] = true, -- Improved Concussive Shot
		[19228] = true, -- Improved Wing Clip
		[7093]  = true, -- Intimidation
		[5760]  = true, -- Mind-numbing Poison
		[32093] = true, -- Poison Spit
		[1513]  = true, -- Scare Beast
		[19503] = true, -- Scatter Shot
		[6411]  = true, -- Scorpid Poison
		[3043]  = true, -- Scorpid Sting
		[24423] = true, -- Screech
		[1978]  = true, -- Serpent Sting
		[34490] = true, -- Silencing Shot
		[1515]  = true, -- Tame Beast
		[3034]  = true, -- Viper Sting
		[2974]  = true, -- Wing Clip
		[19386] = true, -- Wyvern Sting
	}
	petBuffs = {
		[19574] = true, -- Bestial Wrath
		[3385]  = true, -- Boar Charge
		[1850]  = true, -- Dash
		[23145] = true, -- Dive
		[1539]  = true, -- Feed Pet Effect
		[19451] = true, -- Frenzy
		[3149]  = true, -- Furious Howl
		[136]   = true, -- Mend Pet
		[5215]  = true, -- Prowl
		[26064] = true, -- Shell Shield
		[32920] = true, -- Warp
		[19705] = true, -- Well Fed
	}
elseif playerClass == 'ROGUE' then
	selfBuffs = {
		[13750] = true, -- Adrenaline Rush
		[13877] = true, -- Blade Flurry
		[31224] = true, -- Cloak of Shadows
		[14177] = true, -- Cold Blood
		[4086]  = true, -- Evasion
		[31233] = true, -- Find Weakness
		[14278] = true, -- Ghostly Strike
		[14143] = true, -- Remorseless
		[36554] = true, -- Shadowstep
		[5171]  = true, -- Slice and Dice
		[2983]  = true, -- Sprint
		[1784]  = true, -- Stealth
		[1856]  = true, -- Vanish
	}
	enemyDebuffs = {
		[2094]  = true, -- Blind
		[1833]  = true, -- Cheap Shot
		[3408]  = true, -- Crippling Poison
		[3421]  = true, -- Crippling Poison II
		[2818]  = true, -- Deadly Poison
		[2819]  = true, -- Deadly Poison II
		[11353] = true, -- Deadly Poison III
		[11354] = true, -- Deadly Poison IV
		[25347] = true, -- Deadly Poison V
		[26967] = true, -- Deadly Poison VI
		[27186] = true, -- Deadly Poison VII
		[26679] = true, -- Deadly Throw
		[8647]  = true, -- Expose Armor
		[703]   = true, -- Garrote
		[1330]  = true, -- Garrote - Silence
		[1776]  = true, -- Gouge
		[16511] = true, -- Hemorrhage
		[18425] = true, -- Kick - Silenced
		[408]   = true, -- Kidney Shot
		[5530]  = true, -- Mace Stun Effect
		[5760]  = true, -- Mind-numbing Poison
		[8692]  = true, -- Mind-numbing Poison II
		[11398] = true, -- Mind-numbing Poison III
		[14251] = true, -- Riposte
		[1943]  = true, -- Rupture
		[2070]  = true, -- Sap
		[13218] = true, -- Wound Poison
		[13228] = true, -- Wound Poison II
		[13229] = true, -- Wound Poison III
		[13230] = true, -- Wound Poison IV
		[27283] = true, -- Wound Poison V
		-- PvP Gloves
		[32747] = true, -- Deadly Interrupt Effect
	}
end

if not canDispel then
	canDispel = {}
end
if not selfBuffs then
	selfBuffs = {}
end
if not selfDebuffs then
	selfDebuffs = {}
end
if not friendBuffs then
	friendBuffs = {}
end
if not enemyDebuffs then
	enemyDebuffs = {}
end
if not friendDebuffs then
	friendDebuffs = {}
end
if not petBuffs then
	petBuffs = {}
end
if not petDebuffs then
	petDebuffs = {}
end
if playerRace == "BloodElf" then
	enemyDebuffs[25046] = true -- Arcane Torrent
	selfBuffs[28734] = true -- Mana Tap
elseif playerRace == "Troll" then
	selfBuffs[20554] = true -- Berserking
elseif playerRace == "Orc" then
	selfBuffs[20572] = true -- Blood Fury
	selfDebuffs[20572] = true -- Blood Fury
elseif playerRace == "Scourge" then
	selfBuffs[20577] = true -- Cannibalize
	selfBuffs[7744] = true -- Will of the Forsaken
elseif playerRace == "Tauren" then
	enemyDebuffs[45] = true -- War Stomp
elseif playerRace == "Dwarf" then
	selfBuffs[2481] = true -- Find Treasure
	selfBuffs[7020] = true -- Stoneform
elseif playerRace == "Draenei" then
	friendBuffs[28880] = true -- Gift of the Naaru
elseif playerRace == "Human" then
	selfBuffs[20600] = true -- Perception
elseif playerRace == "NightElf" then
	selfBuffs[20580] = true -- Shadowmeld
end
if playerRace == "BloodElf" or playerRace == "Troll" or playerRace == "Orc" or playerRace == "Scourge" or playerRace == "Tauren" then
	-- horde
	friendBuffs[23335] = true -- Silverwing Flag
else
	-- alliance
	friendBuffs[23333] = true -- Warsong Flag
end
friendBuffs[34976] = true -- Netherstorm Flag

local function turn(t)
	local tmp = newList()
	for k in pairs(t) do
		local spell = (GetSpellInfo(k))
		if not spell then
			error(("Unknown spell ID: %d"):format(k))
		end
		tmp[spell] = true
		t[k] = nil
	end
	for k in pairs(tmp) do
		t[k] = true
		tmp[k] = nil
	end
	tmp = del(tmp)
end
turn(friendBuffs)
turn(friendDebuffs)
turn(selfBuffs)
turn(selfDebuffs)
turn(petBuffs)
turn(petDebuffs)
turn(enemyDebuffs)

totalSelfBuffs, totalPetBuffs, totalSelfDebuffs, totalPetDebuffs, allFriendlyBuffs, allFriendlyDebuffs = {}, {}, {}, {}, {}, {}
for k in pairs(selfBuffs) do
	totalSelfBuffs[k] = true
	allFriendlyBuffs[k] = true
end
for k in pairs(selfDebuffs) do
	totalSelfDebuffs[k] = true
	allFriendlyDebuffs[k] = true
end
for k in pairs(petBuffs) do
	totalPetBuffs[k] = true
	allFriendlyBuffs[k] = true
end
for k in pairs(petDebuffs) do
	totalPetDebuffs[k] = true
	allFriendlyDebuffs[k] = true
end
for k in pairs(friendBuffs) do
	totalSelfBuffs[k] = true
	totalPetBuffs[k] = true
	allFriendlyBuffs[k] = true
end
for k in pairs(friendDebuffs) do
	totalSelfDebuffs[k] = true
	totalPetDebuffs[k] = true
	allFriendlyDebuffs[k] = true
end

PitBull_Aura.canDispel = canDispel
PitBull_Aura.friendBuffs = friendBuffs
PitBull_Aura.friendDebuffs = friendDebuffs
PitBull_Aura.selfDebuffs = selfDebuffs
PitBull_Aura.petBuffs = petBuffs
PitBull_Aura.petDebuffs = petDebuffs
PitBull_Aura.enemyDebuffs = enemyDebuffs
PitBull_Aura.totalSelfBuffs = totalSelfBuffs
PitBull_Aura.totalPetBuffs = totalPetBuffs
PitBull_Aura.totalSelfDebuffs = totalSelfDebuffs
PitBull_Aura.totalPetDebuffs = totalPetDebuffs
PitBull_Aura.allFriendlyBuffs = allFriendlyBuffs
PitBull_Aura.allFriendlyDebuffs = allFriendlyDebuffs