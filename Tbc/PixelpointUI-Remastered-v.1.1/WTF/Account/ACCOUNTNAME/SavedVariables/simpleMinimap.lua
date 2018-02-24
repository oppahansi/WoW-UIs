
smmConfig = {
	["disabledModules"] = {
		["Default"] = {
			["pings"] = false,
			["skins"] = false,
			["compass"] = false,
			["autozoom"] = false,
			["gui"] = false,
		},
	},
	["namespaces"] = {
		["coords"] = {
			["profiles"] = {
				["Default"] = {
					["enabled"] = false,
					["backdrop"] = false,
					["position"] = 1,
					["border"] = false,
				},
				["char/Pixelpoint - Outland"] = {
					["enabled"] = true,
					["fontB"] = 0.6,
					["fontR"] = 0.8,
					["scale"] = 0.9,
					["border"] = true,
					["fontG"] = 0.8,
					["backdrop"] = true,
					["time"] = 1,
					["separator"] = ", ",
					["instanceHide"] = false,
					["precision"] = 1,
					["alpha"] = 1,
					["position"] = 6,
				},
			},
		},
		["pings"] = {
			["profiles"] = {
				["char/Pixelpoint - Outland"] = {
					["enabled"] = true,
					["position"] = 3,
					["scale"] = 0.85,
					["alpha"] = 0.9,
					["chat"] = false,
				},
			},
		},
		["movers"] = {
			["profiles"] = {
				["char/Pixelpoint - Outland"] = {
					["enabled"] = false,
					["alpha"] = 0.4,
					["framePos"] = {
					},
				},
			},
		},
		["skins"] = {
			["profiles"] = {
				["Default"] = {
					["border"] = false,
					["skin"] = 2,
				},
				["char/Pixelpoint - Outland"] = {
					["enabled"] = true,
					["border"] = true,
					["skin"] = 1,
				},
			},
		},
		["compass"] = {
			["profiles"] = {
				["Default"] = {
					["enabled"] = true,
				},
				["char/Pixelpoint - Outland"] = {
					["enabled"] = false,
					["Ng"] = 0.7,
					["Na"] = 1,
					["Nb"] = 0.3,
					["SEWb"] = 0.6,
					["Nr"] = 0.9,
					["SEWg"] = 1,
					["SEWa"] = 0.6,
					["SEWr"] = 1,
					["size"] = 12,
				},
			},
		},
		["autozoom"] = {
			["profiles"] = {
				["char/Pixelpoint - Outland"] = {
					["enabled"] = true,
					["time"] = 20,
				},
			},
		},
		["gui"] = {
			["profiles"] = {
				["char/Pixelpoint - Outland"] = {
					["button"] = 3,
					["enabled"] = true,
				},
			},
		},
	},
	["profiles"] = {
		["char/Pixelpoint - Outland"] = {
		},
		["Default"] = {
			["mapPosition"] = {
				1137.099243164063, -- [1]
				557.7427368164063, -- [2]
			},
			["scale"] = 0.95,
			["detachedTooltip"] = {
			},
			["buttonPos"] = {
				["track"] = 147.5268049027388,
				["mail"] = 206.3489139446945,
				["bgs"] = 255.8138179379961,
			},
			["show"] = {
				["direction"] = false,
				["time"] = false,
				["map"] = false,
				["zoom"] = false,
			},
			["locationText"] = false,
			["lock"] = true,
			["locationShow"] = false,
			["direction"] = true,
		},
	},
}
