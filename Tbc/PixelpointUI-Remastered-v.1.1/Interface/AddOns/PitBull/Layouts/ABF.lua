local VERSION = tonumber(("$Revision: 40790 $"):match("%d+"))

local PitBull = PitBull
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2007-06-19 22:06:49 -0400 (Tue, 19 Jun 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

PitBull:RegisterLayout({
	name = "ABF",
	pbRevision = 1,
	texts = {
		Class = {
			custom = "[Classification] [Level:DifficultyColor] [SmartClass:ClassColor] [DruidForm:Paren] [SmartRace]",
			style = "Standard",
			styleType = "class",
			position = "powerBar-left",
		},
		Health = {
			custom = "[CurHP]/[MaxHP]",
			style = "Smart",
			styleType = "health",
			position = "healthBar-right",
		},
		Name = {
			custom = "[Name]",
			style = "Standard",
			styleType = "name",
			position = "healthBar-left",
		},
		Power = {
			custom = "[CurMP]/[MaxMP]",
			style = "Absolute",
			styleType = "power",
			position = "powerBar-right",
		},
		Combo = {
			style = "Standard",
			styleType = "combo",
			position = "frame-outright",
		},
		Experience = {
			style = "Standard",
			styleType = "experience",
			position = "expBar-center",
		},
		Reputation = {
			style = "Standard",
			styleType = "reputation",
			position = "repBar-center",
		},
		Threat = {
			custom = "[Threat]/[MaxThreat]",
			style = "Absolute Short",
			styleType = "threat",
			position = "threatBar-right",
		},
		combatText = {
			position = "frame-center",
		}
	},

	icons = {
		combatIcon = {
			position = "frame-edgebottomleft",
		},
		restIcon = {
			position = "frame-edgebottomleft",
		},
		pvpIcon = {
			position = "frame-edgetopright",
		},
		leaderIcon = {
			position = "frame-edgetopleft",
		},
		masterIcon = {
			position = "frame-edgetopleft",
		},
		raidTargetIcon = {
			position = "frame-edgetop",
		},
	},

	bars = {
		portrait = {
			position = 1,
			side = "left",
		},
		healthBar = {
			height = 5,
			position = 2,
		},
		powerBar = {
			height = 4,
			position = 3,
		},
		expBar = {
			position = 4,
		},
		repBar = {
			position = 5,
		},
		threatBar = {
			position = 6,
		},
		blankSpace = {
			position = 7,
			hidden = true,
		},
		castBar = {
			position = 8,
		},
	},
})