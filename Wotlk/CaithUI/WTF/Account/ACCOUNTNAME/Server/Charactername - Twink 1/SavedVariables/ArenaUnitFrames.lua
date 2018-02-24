
ArenaUnitFrames_Config = {
	["lists"] = {
		["buffs"] = {
			["which"] = 1,
			["black"] = "",
			["white"] = "",
		},
		["debuffs"] = {
			["which"] = 1,
			["black"] = "",
			["white"] = "",
		},
	},
	["options"] = {
		["colorize"] = false,
		["scale"] = 0.550000011920929,
		["showBuffs"] = false,
		["targetColor"] = {
			0, -- [1]
			0.8, -- [2]
			0.8, -- [3]
			1, -- [4]
		},
		["showCastbar"] = false,
		["drMonitor"] = false,
		["showToT"] = false,
		["lockAlerts"] = false,
		["showTrinket"] = false,
		["lockFrame"] = true,
		["showDebuffs"] = false,
		["countdownPrecision"] = false,
		["showMyDebuffsOnly"] = false,
		["focusColor"] = {
			0.5, -- [1]
			0.5, -- [2]
			0.5, -- [3]
			1, -- [4]
		},
		["rangeIndicator"] = false,
		["buffScan"] = true,
		["showStealableOnly"] = false,
	},
	["buttons"] = {
		{
			["none"] = {
				["default"] = {
					["action"] = "target",
				},
			},
		}, -- [1]
		{
			["none"] = {
				["default"] = {
					["action"] = "focus",
				},
			},
		}, -- [2]
		{
		}, -- [3]
		{
		}, -- [4]
		{
		}, -- [5]
	},
	["Alerts"] = {
		["partnerCastingCC"] = {
			["speech"] = true,
		},
		["trinketAvailable"] = {
			["speech"] = true,
			["displayMsg"] = true,
		},
		["friendlySilences"] = {
			["speech"] = true,
			["displayMsg"] = true,
		},
		["trinketUsed"] = {
			["speech"] = true,
			["displayMsg"] = true,
		},
		["ccsOnPartner"] = {
			["speech"] = true,
			["displayMsg"] = true,
		},
		["wotfUsed"] = {
			["speech"] = true,
			["displayMsg"] = true,
		},
		["opponentDeaths"] = {
			["soundEffect"] = true,
			["displayMsg"] = true,
		},
		["hostileSilences"] = {
			["speech"] = true,
			["displayMsg"] = true,
		},
		["resurrecting"] = {
			["soundEffect"] = true,
		},
	},
}
