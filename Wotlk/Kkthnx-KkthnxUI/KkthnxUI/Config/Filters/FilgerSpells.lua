local K, C, L, _ = select(2, ...):unpack()
if C.Unitframe.Enable ~= true or C.Filger.Enable ~= true then return end

COOLDOWN_Anchor = CreateFrame("Frame", "COOLDOWN_Anchor", UIParent)
PVE_PVP_CC_Anchor = CreateFrame("Frame", "PVE_PVP_CC_Anchor", UIParent)
PVE_PVP_DEBUFF_Anchor = CreateFrame("Frame", "PVE_PVP_DEBUFF_Anchor", UIParent)
P_BUFF_ICON_Anchor = CreateFrame("Frame", "P_BUFF_ICON_Anchor", UIParent)
P_PROC_ICON_Anchor = CreateFrame("Frame", "P_PROC_ICON_Anchor", UIParent)
SPECIAL_P_BUFF_ICON_Anchor = CreateFrame("Frame", "SPECIAL_P_BUFF_ICON_Anchor", UIParent)
T_BUFF_Anchor = CreateFrame("Frame", "T_BUFF_Anchor", UIParent)
T_DEBUFF_ICON_Anchor = CreateFrame("Frame", "T_DEBUFF_ICON_Anchor", UIParent)
T_DE_BUFF_BAR_Anchor = CreateFrame("Frame", "T_DE_BUFF_BAR_Anchor", UIParent)

C["filger_spells"] = {
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Lifebloom
			{ spellID = 33763, unitID = "player", caster = "player", filter = "BUFF" },
			-- Rejuvenation
			{ spellID = 774, unitID = "player", caster = "player", filter = "BUFF" },
			-- Regrowth
			{ spellID = 8936, unitID = "player", caster = "player", filter = "BUFF" },
			-- Abolish Poison
			{ spellID = 2893, unitID = "player", caster = "player", filter = "BUFF" },
			-- Savage roar
			{ spellID = 52610, unitID = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, unitID = "player", caster = "all", filter = "BUFF" },
			-- Barkskin
			{ spellID = 22812, unitID = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Survival Instincts
			{ spellID = 61336, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Moonfire
			{ spellID = 48463, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Insect Swarm
			{ spellID = 48468, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Faerie Fire
			{ spellID = 770, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 26989, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Earth and Moon
			{ spellID = 48511, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Rake
			{ spellID = 59886, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Rip
			{ spellID = 49800, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Lacerate
			{ spellID = 48568, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Pounce Bleed
			{ spellID = 49804, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Mangle (Cat)
			{ spellID = 48566, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Mangle (Bear)
			{ spellID = 48564, unitID = "target", caster = "all", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Eclipse (Lunar)
			{ spellID = 48518, unitID = "player", caster = "player", filter = "BUFF" },
			-- Eclipse (Solar)
			{ spellID = 48517, unitID = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 16870, unitID = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, unitID = "player", caster = "player", filter = "BUFF" },
			-- Siphoned Power
			{ spellID = 71636, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
			-- Cultivated Power
			{ spellID = 71572, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hardened Skin
			{ spellID = 71586, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Lifebloom
			{ spellID = 33763, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Rejuvenation
			{ spellID = 774, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Regrowth
			{ spellID = 8936, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Wild Growth
			{ spellID = 48438, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Demoralizing Roar
			{ spellID = 99, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Entangling Roots
			{ spellID = 53308, size = 25, barWidth = 191, unitID = "focus", caster = "all", filter = "DEBUFF" },
			-- Cyclone
			{ spellID = 33786, size = 25, barWidth = 191, unitID = "focus", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 25, barWidth = 191, unitID = "focus", caster = "all", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Wild Growth
			{ spellID = 48438, size = 30, filter = "CD" },
			-- Swiftmend
			{ spellID = 18562, size = 30, filter = "CD" },
			-- Barkskin
			{ spellID = 22812, size = 30, filter = "CD" },
			-- Mangle(Bear)
			{ spellID = 33878, size = 30, filter = "CD" },
			-- Nature's Grasp
			{ spellID = 53312, size = 30, filter = "CD" },
			-- Starfall
			{ spellID = 53201, size = 30, filter = "CD" },
			-- Growl
			{ spellID = 61676, size = 30, filter = "CD" },
			-- Enrage
			{ spellID = 5229, size = 30, filter = "CD" },
			-- Faerie Fire(Feral)
			{ spellID = 16857, size = 30, filter = "CD" },
			-- Feral Charge - Bear
			{ spellID = 16979, size = 30, filter = "CD" },
			-- Feral Charge - Cat
			{ spellID = 49376, size = 30, filter = "CD" },
			-- Bash
			{ spellID = 8983, size = 30, filter = "CD" },
			-- Maim
			{ spellID = 49802, size = 30, filter = "CD" },
			-- Cower
			{ spellID = 48575, size = 30, filter = "CD" },
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Innervate
			{ spellID = 29166, unitID = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Hunter's Mark
			{ spellID = 1130, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 49001, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Scorpid Sting
			{ spellID = 3043, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 63672, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 60053, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Lock and Load
			{ spellID = 56453, unitID = "player", caster = "player", filter = "BUFF" },
			-- Fury of the Five Flights
			{ spellID = 60314, unitID = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60233, unitID = "player", caster = "player", filter = "BUFF" },
			-- Mjolnir Runestone
			{ spellID = 65019, unitID = "player", caster = "player", filter = "BUFF" },
			-- Quick Shots
			{ spellID = 6150, unitID = "player", caster = "player", filter = "BUFF" },
			-- Master Tactician
			{ spellID = 34837, unitID = "player", caster = "player", filter = "BUFF" },
			-- Master Tactician
			{ spellID = 53224, unitID = "player", caster = "player", filter = "BUFF" },
			-- Expose Weakness
			{ spellID = 34503, unitID = "player", caster = "player", filter = "BUFF" },
			-- Exploit Weakness 2t10 proc
			{ spellID = 70728, unitID = "player", caster = "player", filter = "BUFF" },
			-- Stinger 4t10 proc
			{ spellID = 71007, unitID = "player", caster = "player", filter = "BUFF" },
			-- Power of the Taunka
			{ spellID = 71486, unitID = "player", caster = "player", filter = "BUFF" },
			-- Aim of the Iron Dwarves
			{ spellID = 71491, unitID = "player", caster = "player", filter = "BUFF" },
			-- Agility of the Vrykul
			{ spellID = 71485, unitID = "player", caster = "player", filter = "BUFF" },
			-- Icy Rage
			{ spellID = 71401, unitID = "player", caster = "player", filter = "BUFF" },
			-- Rapid Fire
			{ spellID = 3045, unitID = "player", caster = "player", filter = "BUFF" },
			-- Berserking
			{ spellID = 26297, unitID = "player", caster = "player", filter = "BUFF" },
			-- Potion of Speed
			{ spellID = 53908, unitID = "player", caster = "player", filter = "BUFF" },
			-- Potion of Wild Magic
			{ spellID = 53909, unitID = "player", caster = "player", filter = "BUFF" },
			-- Blood Fury
			{ spellID = 20572, unitID = "player", caster = "player", filter = "BUFF" },
			-- Call of the Wild
			{ spellID = 53434, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Acceleration
			{ spellID = 54758, unitID = "player", caster = "player", filter = "BUFF" },
			-- Frostforged Champion
			{ spellID = 72412, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Wyvern Sting
			{ spellID = 49012, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Explosive Shot
			{ spellID = 53301, size = 30, filter = "CD" },
			-- Aimed Shot
			{ spellID = 19434, size = 30, filter = "CD" },
			-- Kill Shot
			{ spellID = 61006, size = 30, filter = "CD" },
			-- Disengage
			{ spellID = 781, size = 30, filter = "CD" },
			-- Misdirection
			{ spellID = 34477, size = 30, filter = "CD" },
			-- Kill Command
			{ spellID = 34026, size = 30, filter = "CD" },
			-- Feign Death
			{ spellID = 28728, size = 30, filter = "CD" },
			-- Freezing Trap
			{ spellID = 14311, size = 30, filter = "CD" },
			-- Wyvern Sting
			{ spellID = 49012, size = 30, filter = "CD" },
			-- Scare Beast
			{ spellID = 14327, size = 30, filter = "CD" },
			-- Master's Call
			{ spellID = 53271, size = 30, filter = "CD" },
			-- Deterrence
			{ spellID = 19263, size = 30, filter = "CD" },
			-- Concussive Shot
			{ spellID = 5116, size = 30, filter = "CD" },
			-- Counterattack
			{ spellID = 48999, size = 30, filter = "CD" },
			-- Mongoose Bite
			{ spellID = 53339, size = 30, filter = "CD" },
			-- Intimidation
			{ spellID = 19577, size = 30, filter = "CD" },
			-- Rapid Fire
			{ spellID = 3045, size = 30, filter = "CD" },
			-- Blood Fury
			{ spellID = 20572, size =30, filter = "CD" },
			-- Readiness
			{ spellID = 23989, size = 30, filter = "CD" },
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Cultivated Power (Muradin's Spyglass)
			{ spellID = 71572, unitID = "player", caster = "player", filter = "BUFF" },
			-- Siphoned Power (Phylactery)
			{ spellID = 71636, unitID = "player", caster = "player", filter = "BUFF" },
			-- Surging Power
			{ spellID = 71643, unitID = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, unitID = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Arcane Blast
			{ spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF" },
			-- Improved Scorch
			{ spellID = 22959, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Ignite
			{ spellID = 12848, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Living Bomb
			{ spellID = 55360, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Arcane Blast
			{ spellID = 36032, unitID = "player", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Frostbite
			{ spellID = 11071, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Winter's Chill
			{ spellID = 28593, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Fingers of Frost
			{ spellID = 44544, unitID = "player", caster = "player", filter = "BUFF" },
			-- Fireball!
			{ spellID = 57761, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hot Streak
			{ spellID = 44448, unitID = "player", caster = "player", filter = "BUFF" },
			-- Missile Barrage
			{ spellID = 54490, unitID = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 12536, unitID = "player", caster = "player", filter = "BUFF" },
			-- Impact
			{ spellID = 12358, unitID = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60234, unitID = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Polymorph
			{ spellID = 118, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Blink
			{ spellID = 1953, size = 30, filter = "CD" },
			-- Frost Nova
			{ spellID = 11831, size = 30, filter = "CD" },
			-- Ice Barrier
			{ spellID = 11426, size = 30, filter = "CD" },
			-- Counterspell
			{ spellID = 2139, size = 30, filter = "CD" },
			-- Deep Freeze
			{ spellID = 44572, size = 30, filter = "CD" },
			-- Frost Ward
			{ spellID = 6143, size = 30, filter = "CD" },
			-- Presence of Mind
			{ spellID = 12043, size = 30, filter = "CD" },
			-- Arcane Power
			{ spellID = 12042, size = 30, filter = "CD" },
			-- Blast Wave
			{ spellID = 42945, size = 30, filter = "CD" },
			-- Dragon's Breath
			{ spellID = 42950, size = 30, filter = "CD" },
			-- Cone of Cold
			{ spellID = 42931, size = 30, filter = "CD" },
			-- Will of the forsaken (undead)
			{ spellID = 7744, size = 30, filter = "CD" },
			-- Cold Snap
			{ spellID = 11958, size = 30, filter = "CD" },
			-- Ice Block
			{ spellID = 45438, size = 30, filter = "CD" },
			-- Evocation
			{ spellID = 12051, size = 30, filter = "CD" },
			-- Icy Veins
			{ spellID = 12472, size = 30, filter = "CD" },
			-- Fire Blast
			{ spellID = 2136, size = 30, filter = "CD" },
			-- Mirror Image
			{ spellID = 55342, size = 30, filter = "CD" },
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Blood Reserve
			{ spellID = 64568, unitID = "player", caster = "player", filter = "BUFF" },
			-- Last Stand
			{ spellID = 12975, unitID = "player", caster = "player", filter = "BUFF" },
			-- Shield Wall
			{ spellID = 871, unitID = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Hamstring
			{ spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Rend
			{ spellID = 47465, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Sunder Armor
			{ spellID = 7386, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Expose Armor
			{ spellID = 48669, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Thunder Clap
			{ spellID = 6343, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 48485, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Frost Fever
			{ spellID = 55095, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Demoralizing Shout
			{ spellID = 1160, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Demoralizing Roar
			{ spellID = 48560, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 50511, unitID = "target", caster = "all", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Sudden Death
			{ spellID = 52437, unitID = "player", caster = "player", filter = "BUFF" },
			-- Slam!
			{ spellID = 46916, unitID = "player", caster = "all", filter = "BUFF" },
			-- Sword and Board
			{ spellID = 50227, unitID = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60229, unitID = "player", caster = "player", filter = "BUFF" },
			-- Strength of the Taunka
			{ spellID = 71561, unitID = "player", caster = "player", filter = "BUFF" },
			-- Speed of the Vrykul
			{ spellID = 71560, unitID = "player", caster = "player", filter = "BUFF" },
			-- Aim of the Iron Dwarves
			{ spellID = 71559, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Intervene
			{ spellID = 3411, size = 30, filter = "CD" },
			-- Shield Slam
			{ spellID = 47488, size = 30, filter = "CD" },
			-- Whirlwind
			{ spellID = 1680, size = 30, filter = "CD" },
			-- Mortal Strike
			{ spellID = 47486, size = 30, filter = "CD" },
			-- Thunder Clap
			{ spellID = 47502, size = 30, filter = "CD" },
			-- Revenge
			{ spellID = 57823, size = 30, filter = "CD" },
			-- Overpower
			{ spellID = 7384, size = 30, filter = "CD" },
			-- Pummel
			{ spellID = 6552, size = 30, filter = "CD" },
			-- Shield Bash
			{ spellID = 72, size = 30, filter = "CD" },
			-- Charge
			{ spellID = 11578, size = 30, filter = "CD" },
			-- Intercept
			{ spellID = 20252, size = 30, filter = "CD" },
			-- Spell Reflection
			{ spellID = 23920, size = 30, filter = "CD" },
			-- Shield Block
			{ spellID = 2565, size = 30, filter = "CD" },
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Maelstorm Weapon
			{ spellID = 51532, unitID = "player", caster = "player", filter = "BUFF" },
			-- Shamanistic rage
			{ spellID = 30823, unitID = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Lightning Shield
			{ spellID = 49281, unitID = "player", caster = "player", filter = "BUFF" },
			-- Water Shield
			{ spellID = 57960, unitID = "player", caster = "player", filter = "BUFF" },
			-- Earth Shield
			{ spellID = 49284, unitID = "player", caster = "player", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Storm Strike
			{ spellID = 17364, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Earth Shock
			{ spellID = 49231, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 49236, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Flame Shock
			{ spellID = 49233, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Clearcasting
			{ spellID = 12536, unitID = "player", caster = "player", filter = "BUFF" },
			-- Tidal Waves
			{ spellID = 51566, unitID = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Earth Shield
			{ spellID = 49284, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Riptide
			{ spellID = 61301, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Ancestral Fortitude
			{ spellID = 16237, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Hex
			{ spellID = 51514, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Earth Shock
			{ spellID = 49231, size = 30, filter = "CD" },
			-- Riptide
			{ spellID = 61301, size = 30, filter = "CD" },
			-- Thunderstorm
			{ spellID = 59159, size = 30, filter = "CD" },
			-- Lava Burst
			{ spellID = 60043, size = 30, filter = "CD" },
			-- Lava Lash
			{ spellID = 60103, size = 30, filter = "CD" },
			-- Chain Lightning
			{ spellID = 49271, size = 30, filter = "CD" },
			-- Wind Shear
			{ spellID = 57994, size = 30, filter = "CD" },
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Innervate
			{ spellID = 29166, unitID = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Hammer of Justice
			{ spellID = 10308, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Judgement of Light
			{ spellID = 20271, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Judgement of Justice
			{ spellID = 53407, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Judgement of Wisdom
			{ spellID = 20186, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Heart of the Crusader
			{ spellID = 54499, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Blood Corruption
			{ spellID = 53742, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Judgements of the Pure
			{ spellID = 54155, unitID = "player", caster = "player", filter = "BUFF" },
			-- Holy Shield
			{ spellID = 53601, unitID = "player", caster = "player", filter = "BUFF" },
			-- Infusion of Light
			{ spellID = 54149, unitID = "player", caster = "player", filter = "BUFF" },
			-- Divine Plea
			{ spellID = 54428, unitID = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, unitID = "player", caster = "player", filter = "BUFF" },
			-- Beacon of Light
			{ spellID = 53563, unitID = "player", caster = "player", filter = "BUFF" },
			-- Divine Illumination
			{ spellID = 31842, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Repentance
			{ spellID = 20066, size = 30, filter = "CD" },
			-- Hand of Reckoning
			{ spellID = 62124, size = 30, filter = "CD" },
			-- Hand of Freedom
			{ spellID = 1044, size = 30, filter = "CD" },
			-- Judgement of Light
			{ spellID = 20271, size = 30, filter = "CD" },
			-- Righteous Defense
			{ spellID = 31789, size = 30, filter = "CD" },
			-- Exorcism
			{ spellID = 48801, size = 30, filter = "CD" },
			-- Hammer of Justice
			{ spellID = 10308, size = 30, filter = "CD" },
			-- Consecration
			{ spellID = 48819, size = 30, filter = "CD" },
			-- Hammer of Wrath
			{ spellID = 48806, size = 30, filter = "CD" },
			-- Holy Shock
			{ spellID = 48825, size = 30, filter = "CD" },
			-- Holy Shield
			{ spellID = 48952, size = 30, filter = "CD" },
			-- Avenger's Shield
			{ spellID = 48827, size = 30, filter = "CD" },
			-- Divine Plea
			{ spellID = 54428, size = 30, filter = "CD" },
			-- Shield of Righteousness
			{ spellID = 61411, size = 30, filter = "CD" },
			-- Holy Wrath
			{ spellID = 48817, size = 30, filter = "CD" },
			-- Aura Mastery
			{ spellID = 31821, size = 30, filter = "CD" },
			-- Crusader Strike
			{ spellID = 35395, size = 30, filter = "CD" },
			-- Divine Favor
			{ spellID = 20216, size = 30, filter = "CD" },
			-- Divine Storm
			{ spellID = 53385, size = 30, filter = "CD" },
			-- Hammer of the Righteous
			{ spellID = 53595, size = 30, filter = "CD" },
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Power Word: Shield
			{ spellID = 48066, unitID = "player", caster = "player", filter = "BUFF" },
			-- Renew
			{ spellID = 25222, unitID = "player", caster = "player", filter = "BUFF" },
			-- Fade
			{ spellID = 586, unitID = "player", caster = "player", filter = "BUFF" },
			-- Fear Ward
			{ spellID = 6346, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hand of Protection
			{ spellID = 10278, unitID = "player", caster = "all", filter = "BUFF" },
			-- Dispersion
			{ spellID = 47585, unitID = "player", caster = "player", filter = "BUFF" },
			-- Inner Fire
			{ spellID = 48168, unitID = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, unitID = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Borrowed Time
			{ spellID = 52800, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Surge of Light
			{ spellID = 33151, unitID = "player", caster = "all", filter = "BUFF" },
			-- Serendipity
			{ spellID = 63734, unitID = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60234, unitID = "player", caster = "player", filter = "BUFF" },
			-- Essence of Life
			{ spellID = 60062, unitID = "player", caster = "player", filter = "BUFF" },
			-- Energized
			{ spellID = 67696, unitID = "player", caster = "player", filter = "BUFF" },
			-- Eye of the Broodmother
			{ spellID = 65007, unitID = "player", caster = "player", filter = "BUFF" },
			-- Frostforged Sage
			{ spellID = 72416, unitID = "player", caster = "player", filter = "BUFF" },
			-- Shadow Weaving
			{ spellID = 15258, unitID = "player", caster = "player", filter = "BUFF" },
			-- Improved Spirit Tap
			{ spellID = 59000, unitID = "player", caster = "all", filter = "BUFF" },
		},

		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Renew
			{ spellID = 139, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Prayer of Mending
			{ spellID = 41637, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Guardian spirit
			{ spellID = 47788, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Pain suspension
			{ spellID = 33206, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "BUFF" },
			-- Shadow Word: Pain
			{ spellID = 589, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Devouring Plague
			{ spellID = 2944, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Vampiric Touch
			{ spellID = 34914, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Shackle undead
			{ spellID = 10955, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
			-- Fear
			{ spellID = 10890, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Penance
			{ spellID = 53007, size = 30, filter = "CD" },
			-- Pain Suppression
			{ spellID = 33206, size = 30, filter = "CD" },
			-- Power Infusion
			{ spellID = 10060, size = 30, filter = "CD" },
			-- Psychic Scream
			{ spellID = 10890, size = 30, filter = "CD" },
			-- Circle of Healing
			{ spellID = 48089, size = 30, filter = "CD" },
			-- Guardian Spirit
			{ spellID = 47788, size = 30, filter = "CD" },
			-- Prayer of Mending
			{ spellID = 48113, size = 30, filter = "CD" },
			-- Silence
			{ spellID = 15487, size = 30, filter = "CD" },
			-- Power Word: Shield
			{ spellID = 48066, size = 30, filter = "CD" },
			-- Holy Fire
			{ spellID = 48135, size = 30, filter = "CD" },
			-- Shadow Word: Death
			{ spellID = 48158, size = 30, filter = "CD" },
			-- Berserking
			{ spellID = 26297, size = 30, filter = "CD" },
			-- Hymn of Hope
			{ spellID = 64901, size = 30, filter = "CD" },
			-- Divine Hymn
			{ spellID = 64843, size = 30, filter = "CD" },
			-- Shadowfiend
			{ spellID = 34433, size = 30, filter = "CD" },
			-- Dispersion
			{ spellID = 47585, size = 30, filter = "CD" },
			-- Psychic Horror
			{ spellID = 64044, size = 30, filter = "CD" },
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Life Tap
			{ spellID = 63321, unitID = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Phylactery of the Nameless Lich
			{ spellID = 71636, unitID = "player", caster = "player", filter = "BUFF" },
			-- Surge of Power
			{ spellID = 71644, unitID = "player", caster = "player", filter = "BUFF" },
			-- Devious Minds
			{ spellID = 70840, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Curse of the Elements
			{ spellID = 47865, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Ebon Plaguebringer
			{ spellID = 51161, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Earth and Moon
			{ spellID = 48511, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Tongues
			{ spellID = 11719, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 50511, unitID = "target", caster = "all", filter = "DEBUFF" },
			-- Shadow Embrace
			{ spellID = 32385, unitID = "target", caster = "player", filter = "BUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Essence of Life
			{ spellID = 60062, unitID = "player", caster = "player", filter = "BUFF" },
			-- Molten Core
			{ spellID = 47383, unitID = "player", caster = "player", filter = "BUFF" },
			-- Decimation
			{ spellID = 63158, unitID = "player", caster = "player", filter = "BUFF" },
			-- Backdraft
			{ spellID = 54277, unitID = "player", caster = "player", filter = "BUFF" },
			-- Backlash
			{ spellID = 34939, unitID = "player", caster = "player", filter = "BUFF" },
			-- Nether Protection
			{ spellID = 30302, unitID = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60235, unitID = "player", caster = "player", filter = "BUFF" },
			-- Greatness
			{ spellID = 60234, unitID = "player", caster = "player", filter = "BUFF" },
			-- Nightfall
			{ spellID = 18095, unitID = "player", caster = "player", filter = "BUFF" },

		},

		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Corruption
			{ spellID = 172, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Immolate
			{ spellID = 348, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Agony
			{ spellID = 980, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Doom
			{ spellID = 47867, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Unstable Affliction
			{ spellID = 47843, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Haunt
			{ spellID = 59164, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Seed of Corruption
			{ spellID = 27243, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Tongues
			{ spellID = 1714, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Fear
			{ spellID = 6215, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Enslave Demon
			{ spellID = 1098, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Demon Charge
			{ spellID = 54785, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Fear
			{ spellID = 5782, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
			-- Banish
			{ spellID = 710, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Cannibalize
			{ spellID = 20577, size = 30, filter = "CD" },
			-- Will of the Forsaken
			{ spellID = 7744, size = 30, filter = "CD" },
			-- Conflagrate
			{ spellID = 17962, size = 30, filter = "CD" },
			-- Challenging Howl
			{ spellID = 59671, size = 30, filter = "CD" },
			-- Ritual of Summoning
			{ spellID = 698, size = 30, filter = "CD" },
			-- Shadow Ward
			{ spellID = 47891, size = 30, filter = "CD" },
			-- Inferno
			{ spellID = 1122, size = 30, filter = "CD" },
			-- Demonic Empowerment
			{ spellID = 47193, size = 30, filter = "CD" },
			-- Demon Charge
			{ spellID = 54785, size = 30, filter = "CD" },
			-- Ritual of Doom
			{ spellID = 18540, size = 30, filter = "CD" },
			-- Shadow Cleave
			{ spellID = 50581, size = 30, filter = "CD" },
			-- Soulshatter
			{ spellID = 29858, size = 30, filter = "CD" },
			-- Ritual of Souls
			{ spellID = 58887, size = 30, filter = "CD" },
			-- Demonic Circle: Teleport
			{ spellID = 48020, size = 30, filter = "CD" },
			-- Howl of Terror
			{ spellID = 17928, size = 30, filter = "CD" },
			-- Death Coil
			{ spellID = 47860, size = 30, filter = "CD" },
			-- Haunt
			{ spellID = 59164, size = 30, filter = "CD" },
			-- Curse of Doom
			{ spellID = 47867, size = 30, filter = "CD" },
			-- Shadowburn
			{ spellID = 47827, size = 30, filter = "CD" },
			-- Shadowfury
			{ spellID = 47847, size = 30, filter = "CD" },
			-- Chaos Bolt
			{ spellID = 59172, size = 30, filter = "CD" },
			-- Shadowflame
			{ spellID = 61290, size = 30, filter = "CD" },
			-- Fel Domination
			{ spellID = 18708, size = 30, filter = "CD" },
			-- Phase Shift (Imp)
			{ spellID = 4511, size = 30, filter = "CD" },
			-- Sacrifice (Voidwalker)
			{ spellID = 47986, size = 30, filter = "CD" },
			-- Suffering (Voidwalker)
			{ spellID = 47990, size = 30, filter = "CD" },
			-- Spell Lock (Felhunter)
			{ spellID = 19647, size = 30, filter = "CD" },
			-- Devour Magic (Felhunter)
			{ spellID = 48011, size = 30, filter = "CD" },
			-- Intercept (Felguard)
			{ spellID = 47996, size = 30, filter = "CD" },
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Slice and Dice
			{ spellID = 5171, unitID = "player", caster = "player", filter = "BUFF" },
			-- Blade Flurry
			{ spellID = 13877, unitID = "player", caster = "player", filter = "BUFF" },
			-- Adrenaline Rush
			{ spellID = 13750, unitID = "player", caster = "player", filter = "BUFF" },
			-- Tricks of the Trade
			{ spellID = 57934, unitID = "player", caster = "player", filter = "BUFF" },
			-- Cloak of Shadows
			{ spellID = 31224, unitID = "player", caster = "player", filter = "BUFF" },
			-- Sprint
			{ spellID = 2983, unitID = "player", caster = "player", filter = "BUFF" },
			-- Evasion
			{ spellID = 5277, unitID = "player", caster = "player", filter = "BUFF" },
			-- Envenom
			{ spellID = 32645, unitID = "player", caster = "player", filter = "BUFF" },
			-- Overkill
			{ spellID = 58426, unitID = "player", caster = "player", filter = "BUFF" },
			-- Turn the Tables
			{ spellID = 51627, unitID = "player", caster = "player", filter = "BUFF" },
			-- Hunger For Blood
			{ spellID = 51662, unitID = "player", caster = "player", filter = "BUFF" },
			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Rupture
			{ spellID = 48672, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Garrote
			{ spellID = 48676, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Kidney shot
			{ spellID = 408, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Cheap shot
			{ spellID = 1833, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Expose Armor
			{ spellID = 8647, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Dismantle
			{ spellID = 51722, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Deadly Poison
			{ spellID = 57973, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Wound Poison
			{ spellID = 57978, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3408, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Mind-numbing Poison
			{ spellID = 5761, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Blind
			{ spellID = 2094, size = 25, barWidth = 191, unitID = "focus", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Kick
			{ spellID = 1766, size = 30, filter = "CD" },
			-- Gouge
			{ spellID = 1776, size = 30, filter = "CD" },
			-- Kidney shot
			{ spellID = 8643, size = 30, filter = "CD" },
			-- Killing Spree
			{ spellID = 51690, size = 30, filter = "CD" },
			-- Adrenaline Rush
			{ spellID = 13750, size = 30, filter = "CD" },
			-- Stealth
			{ spellID = 1784, size = 30, filter = "CD" },
			-- Vanish
			{ spellID = 1856, size = 30, filter = "CD" },
			-- Blade Flurry
			{ spellID = 13877, size = 30, filter = "CD" },
		},
	},
	["DEATHKNIGHT"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Bloodlust
			{ spellID = 2825, unitID = "player", caster = "all", filter = "BUFF" },
			-- Heroism
			{ spellID = 32182, unitID = "player", caster = "all", filter = "BUFF" },
			-- Hyperspeed Accelerators
			{ spellID = 54999, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Blood Plague
			{ spellID = 59879, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Fever
			{ spellID = 59921, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Unholy Blight
			{ spellID = 49194, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
			-- Summon Gargoyle
			{ spellID = 49206, size = 25, barWidth = 187, unitID = "target", caster = "player", filter = "DEBUFF" },
		},

		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.BuffsSize,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Greatness
			{ spellID = 60229, unitID = "player", caster = "player", filter = "BUFF" },
			-- Unholy Force
			{ spellID = 67383, unitID = "player", caster = "player", filter = "BUFF" },
			-- Desolation
			{ spellID = 66817, unitID = "player", caster = "player", filter = "BUFF" },
			-- Unholy Strength
			{ spellID = 53365, unitID = "player", caster = "player", filter = "BUFF" },
			-- Pyrite Infusion
			{ spellID = 65014, unitID = "player", caster = "player", filter = "BUFF" },
			-- Unholy Might
			{ spellID = 67117, unitID = "player", caster = "player", filter = "BUFF" },
			-- Dancing Rune Weapon
			{ spellID = 49028, unitID = "player", caster = "player", filter = "BUFF" },
			-- Killing machine
			{ spellID = 51124, unitID = "player", caster = "player", filter = "BUFF" },
			-- Freezing fog
			{ spellID = 59052, unitID = "player", caster = "player", filter = "BUFF" },
		},

		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.CooldownSize,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Summon Gargoyle
			{ spellID = 49206, size = 30, filter = "CD" },
			-- Gnaw
			{ spellID = 47481, size = 30, filter = "CD" },
			-- Strangulate
			{ spellID = 47476, size = 30, filter = "CD" },
			-- Mind Freeze
			{ spellID = 47528, size = 30, filter = "CD" },
		},
	},
	["ALL"] = {
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.PvPSize,
			Position = {"TOP", PVE_PVP_DEBUFF_Anchor},

			-- Death Knight
			-- Gnaw (Ghoul)
			{ spellID = 47481, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Strangulate
			{ spellID = 47476, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Chains of Ice
			{ spellID = 45524, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Desecration (no duration, lasts as long as you stand in it)
			{ spellID = 55741, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Heart Strike
			{ spellID = 58617, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Icy Clutch (Chilblains)
			{ spellID = 50436, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Hungering Cold
			{ spellID = 51209, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Druid
			-- Cyclone
			{ spellID = 33786, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Bash
			{ spellID = 5211, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Maim
			{ spellID = 22570, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Pounce
			{ spellID = 9005, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Feral Charge Effect
			{ spellID = 45334, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 58179, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Hunter
			-- Freezing Trap Effect
			{ spellID = 3355, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Freezing Arrow Effect
			{ spellID = 60210, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Scare Beast
			{ spellID = 1513, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Scatter Shot
			{ spellID = 19503, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Chimera Shot - Scorpid
			{ spellID = 53359, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Snatch (Bird of Prey)
			{ spellID = 50541, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidation
			{ spellID = 24394, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Sonic Blast (Bat)
			{ spellID = 50519, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Ravage (Ravager)
			{ spellID = 50518, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Barrage
			{ spellID = 35101, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Shot
			{ spellID = 5116, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Trap Aura
			{ spellID = 13810, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Freezing Trap
			{ spellID = 61394, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Wing Clip
			{ spellID = 2974, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Counterattack
			{ spellID = 19306, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Entrapment
			{ spellID = 19185, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Pin (Crab)
			{ spellID = 50245, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Venom Web Spray (Silithid)
			{ spellID = 54706, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Web (Spider)
			{ spellID = 4167, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Froststorm Breath (Chimera)
			{ spellID = 51209, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Tendon Rip (Hyena)
			{ spellID = 51209, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Mage
			-- Dragon's Breath
			{ spellID = 31661, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Polymorph
			{ spellID = 118, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Counterspell
			{ spellID = 18469, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Deep Freeze
			{ spellID = 44572, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze (Water Elemental)
			{ spellID = 33395, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Nova
			{ spellID = 122, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Shattered Barrier
			{ spellID = 55080, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Chilled
			{ spellID = 6136, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Cone of Cold
			{ spellID = 120, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Paladin
			-- Repentance
			{ spellID = 20066, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Turn Evil
			{ spellID = 10326, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Shield of the Templar
			{ spellID = 63529, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Hammer of Justice
			{ spellID = 853, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Holy Wrath
			{ spellID = 2812, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Stun (Seal of Justice proc)
			{ spellID = 20170, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield
			{ spellID = 31935, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Priest
			-- Psychic Horror
			{ spellID = 64058, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Control
			{ spellID = 605, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Horror
			{ spellID = 64044, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Silence
			{ spellID = 15487, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Flay
			{ spellID = 15407, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Rogue
			-- Dismantle
			{ spellID = 51722, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Garrote - Silence
			{ spellID = 1330, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Kick
			{ spellID = 18425, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Cheap Shot
			{ spellID = 1833, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Kidney Shot
			{ spellID = 408, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Blade Twisting
			{ spellID = 31125, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3409, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Deadly Throw
			{ spellID = 26679, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Shaman
			-- Hex
			{ spellID = 51514, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Earthgrab
			{ spellID = 64695, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze
			{ spellID = 63685, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Stoneclaw Stun
			{ spellID = 39796, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Earthbind
			{ spellID = 3600, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Warlock
			-- Banish
			{ spellID = 710, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Seduction (Succubus)
			{ spellID = 6358, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Spell Lock (Felhunter)
			{ spellID = 24259, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Shadowfury
			{ spellID = 30283, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept (Felguard)
			{ spellID = 30153, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Aftermath
			{ spellID = 18118, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Warrior
			-- Intimidating Shout
			{ spellID = 20511, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Disarm
			{ spellID = 676, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced (Gag Order)
			{ spellID = 18498, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Charge Stun
			{ spellID = 7922, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Concussion Blow
			{ spellID = 12809, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept
			{ spellID = 20253, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Revenge Stun
			{ spellID = 12798, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Hamstring
			{ spellID = 58373, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Hamstring
			{ spellID = 23694, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Hamstring
			{ spellID = 1715, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Piercing Howl
			{ spellID = 12323, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Racials
			-- War Stomp
			{ spellID = 20549, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },

			-- Mark of the Fallen Champion
			{ spellID = 72293, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Inoculated (Festergut)
			{ spellID = 72103, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Mutated Infection (Rotface)
			{ spellID = 71224, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Unbound Plague (Professor Putricide)
			{ spellID = 72856, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Gas Variable (Professor Putricide)
			{ spellID = 70353, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Ooze Variable (Professor Putricide)
			{ spellID = 70352, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Pact of the Darkfallen (Bloodqueen Lana'thel)
			{ spellID = 71340, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Swarming Shadows (Bloodqueen Lana'thel)
			{ spellID = 71861, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Essence of the Blood Queen (Bloodqueen Lana'thel)
			{ spellID = 71473, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Bomb (Sindragosa)
			{ spellID = 71053, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Instability (Sindragosa)
			{ spellID = 69766, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Unchained Magic (Sindragosa)
			{ spellID = 69762, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Mystic Buffet (Sindragosa)
			{ spellID = 70128, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
			-- Necrotic Plague (Arthas - The Lich King)
			{ spellID = 73912, size = 51, unitID = "player", caster = "all", filter = "DEBUFF" },
		},
		{
			Name = "T_BUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.Filger.PvPSize,
			Position = {"TOP", T_BUFF_Anchor},

			-- Aspect of the Viper
			{ spellID = 34074, size = 51, unitID = "player", caster = "player", filter = "BUFF" },
			-- Aspect of the Pack
			{ spellID = 13159, size = 51, unitID = "player", caster = "player", filter = "BUFF" },
			-- Innervate
			{ spellID = 29166, size = 51, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spell Reflection
			{ spellID = 23920, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Aura Mastery
			{ spellID = 31821, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Ice Block
			{ spellID = 45438, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Cloak of Shadows
			{ spellID = 31224, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Divine Shield
			{ spellID = 642, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Deterrence
			{ spellID = 19263, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Anti-Magic Shell
			{ spellID = 48707, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Lichborne
			{ spellID = 49039, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Hand of Freedom
			{ spellID = 1044, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Hand of Sacrifice
			{ spellID = 6940, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
			-- Grounding Totem Effect
			{ spellID = 8178, size = 51, unitID = "target", caster = "all", filter = "BUFF" },
		},
	},
}