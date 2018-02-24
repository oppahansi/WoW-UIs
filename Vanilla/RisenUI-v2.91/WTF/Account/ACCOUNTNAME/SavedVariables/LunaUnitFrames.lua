
LunaDB = {
	["profiles"] = {
		["Default"] = {
			["blizzard"] = {
				["weaponbuffs"] = false,
				["buffs"] = false,
			},
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["hidden"] = true,
			["units"] = {
				["targettargettarget"] = {
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
						},
						["vertical"] = {
						},
					},
					["enabled"] = false,
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["center"] = "",
							},
							["healthBar"] = {
								["center"] = "",
							},
						},
					},
				},
				["partytarget"] = {
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
						},
						["vertical"] = {
						},
					},
					["size"] = {
						["y"] = 20,
					},
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["center"] = "",
							},
							["healthBar"] = {
								["center"] = "",
							},
						},
					},
				},
				["pet"] = {
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
							[5] = "xpBar",
						},
						["vertical"] = {
						},
					},
					["enabled"] = false,
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["center"] = "",
							},
							["healthBar"] = {
								["center"] = "",
							},
						},
					},
				},
				["partypet"] = {
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
						},
						["vertical"] = {
						},
					},
					["size"] = {
						["y"] = 20,
					},
					["enabled"] = false,
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["center"] = "",
							},
							["healthBar"] = {
								["center"] = "",
							},
						},
					},
				},
				["player"] = {
					["indicators"] = {
						["icons"] = {
							["raidTarget"] = {
								["y"] = 8,
								["size"] = 15,
							},
							["pvprank"] = {
								["enabled"] = false,
							},
							["class"] = {
								["enabled"] = false,
							},
							["leader"] = {
								["enabled"] = false,
							},
							["status"] = {
								["enabled"] = false,
							},
							["rezz"] = {
								["enabled"] = false,
							},
							["masterLoot"] = {
								["enabled"] = false,
							},
							["pvp"] = {
								["enabled"] = false,
							},
						},
					},
					["auras"] = {
						["timerspinenabled"] = false,
						["timertextbigsize"] = 22,
						["AurasPerRow"] = 9,
						["timertextsmallsize"] = 10,
					},
					["castBar"] = {
						["enabled"] = false,
						["size"] = 4,
					},
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
							[5] = "druidBar",
							[6] = "totemBar",
							[7] = "xpBar",
						},
						["vertical"] = {
						},
					},
					["size"] = {
						["y"] = 45,
						["x"] = 211,
					},
					["tags"] = {
						["bartags"] = {
							["castBar"] = {
								["size"] = 12,
							},
							["healthBar"] = {
								["center"] = "",
								["right"] = "[perhp]%[br][smarthealth]",
								["size"] = 12,
							},
							["druidBar"] = {
								["right"] = "",
								["left"] = "",
							},
							["powerBar"] = {
								["center"] = "",
								["size"] = 11,
							},
						},
					},
					["combatText"] = {
						["enabled"] = false,
					},
					["highlight"] = {
						["onmouse"] = true,
					},
					["powerBar"] = {
						["size"] = 3,
					},
					["position"] = {
						["y"] = -541.9329454217647,
						["x"] = 416.0442147053761,
					},
				},
				["target"] = {
					["indicators"] = {
						["icons"] = {
							["raidTarget"] = {
								["x"] = -10,
								["y"] = 8,
								["size"] = 15,
							},
							["pvprank"] = {
								["enabled"] = false,
							},
							["class"] = {
								["enabled"] = false,
							},
							["status"] = {
								["enabled"] = false,
							},
							["rezz"] = {
								["enabled"] = false,
							},
							["pvp"] = {
								["enabled"] = false,
							},
						},
					},
					["auras"] = {
						["AurasPerRow"] = 9,
					},
					["castBar"] = {
						["size"] = 4,
					},
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
							[5] = "comboPoints",
						},
						["vertical"] = {
						},
					},
					["size"] = {
						["y"] = 45,
						["x"] = 211,
					},
					["healthBar"] = {
						["invert"] = false,
					},
					["tags"] = {
						["bartags"] = {
							["castBar"] = {
								["size"] = 12,
							},
							["healthBar"] = {
								["center"] = "",
								["size"] = 12,
							},
							["powerBar"] = {
								["center"] = "",
								["size"] = 11,
							},
						},
					},
					["comboPoints"] = {
						["size"] = 2,
						["growth"] = "RIGHT",
						["hide"] = false,
					},
					["position"] = {
						["y"] = -541.9337787612747,
						["x"] = 769.5543944749123,
					},
					["powerBar"] = {
						["size"] = 3,
					},
					["combatText"] = {
						["enabled"] = false,
					},
					["highlight"] = {
						["ondebuff"] = false,
						["onmouse"] = true,
					},
				},
				["raid"] = {
					[1] = {
						["position"] = {
							["y"] = -545.1020375222911,
							["x"] = 23.73582337655019,
						},
					},
					[2] = {
						["position"] = {
							["y"] = -356.8679313151301,
							["x"] = 94.78007450242642,
						},
					},
					[3] = {
						["position"] = {
							["y"] = -356.8676512009973,
							["x"] = 159.3638980069975,
						},
					},
					[4] = {
						["position"] = {
							["y"] = -356.8676512009973,
							["x"] = 223.1111343931669,
						},
					},
					[5] = {
						["position"] = {
							["y"] = -539.9913551687771,
							["x"] = -2.791564652851669,
						},
					},
					[6] = {
						["position"] = {
							["y"] = -539.9911450831776,
							["x"] = 94.9776162410393,
						},
					},
					[7] = {
						["position"] = {
							["y"] = -539.9911450831776,
							["x"] = 158.724642541609,
						},
					},
					[8] = {
						["position"] = {
							["y"] = -539.9908649690447,
							["x"] = 222.4723516203775,
						},
					},
					["incheal"] = {
						["cap"] = 0.04,
					},
					["highlight"] = {
						["ondebuff"] = false,
						["onmouse"] = true,
					},
					["interlock"] = true,
					["showalways"] = true,
					["powerBar"] = {
						["vertical"] = false,
						["invert"] = false,
						["size"] = 2,
					},
					["size"] = {
						["y"] = 32,
						["x"] = 45,
					},
					["healthBar"] = {
						["vertical"] = false,
						["invert"] = false,
					},
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["right"] = "",
								["left"] = "",
							},
							["healthBar"] = {
								["center"] = "[name][br]",
								["right"] = "",
								["left"] = "",
							},
						},
					},
					["squares"] = {
						["aggro"] = false,
						["dispellabledebuffs"] = true,
						["innersize"] = 9,
						["hottracker"] = false,
						["outersize"] = 9,
					},
					["titles"] = false,
					["padding"] = 2,
					["indicators"] = {
						["icons"] = {
							["raidTarget"] = {
								["y"] = 9,
								["x"] = -17,
								["enabled"] = true,
								["size"] = 11,
							},
							["masterLoot"] = {
								["y"] = 20,
							},
							["rezz"] = {
								["x"] = -5,
								["y"] = -5,
								["size"] = 11,
							},
						},
					},
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "castBar",
							[3] = "healthBar",
							[4] = "powerBar",
						},
						["vertical"] = {
						},
					},
				},
				["party"] = {
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
						},
						["vertical"] = {
						},
					},
					["enabled"] = false,
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["center"] = "",
							},
							["healthBar"] = {
								["center"] = "",
							},
						},
					},
				},
				["targettarget"] = {
					["indicators"] = {
						["icons"] = {
							["raidTarget"] = {
								["x"] = -27,
								["size"] = 14,
							},
							["pvprank"] = {
								["enabled"] = false,
							},
							["class"] = {
								["enabled"] = false,
							},
							["leader"] = {
								["enabled"] = false,
							},
							["status"] = {
								["enabled"] = false,
							},
							["masterLoot"] = {
								["enabled"] = false,
							},
							["pvp"] = {
								["enabled"] = false,
							},
						},
					},
					["scale"] = 0.9,
					["castBar"] = {
						["enabled"] = false,
					},
					["powerBar"] = {
						["enabled"] = false,
					},
					["size"] = {
						["y"] = 23,
						["x"] = 90,
					},
					["healthBar"] = {
						["size"] = 5,
					},
					["tags"] = {
						["bartags"] = {
							["powerBar"] = {
								["center"] = "",
							},
							["healthBar"] = {
								["center"] = "[name]",
								["right"] = "",
								["left"] = "",
								["size"] = 12,
							},
						},
					},
					["position"] = {
						["y"] = -568.9537734874298,
						["x"] = 647.2892270409113,
					},
					["portrait"] = {
						["enabled"] = false,
					},
					["barorder"] = {
						["horizontal"] = {
							[1] = "portrait",
							[2] = "healthBar",
							[3] = "powerBar",
							[4] = "castBar",
						},
						["vertical"] = {
						},
					},
					["highlight"] = {
						["ondebuff"] = false,
						["onmouse"] = true,
					},
				},
			},
			["minimapPosition"] = 184.2448043211565,
		},
	},
}
LunaBuffDB = {
	["Merylbank of Kronos"] = {
	},
	["Vashin of Kronos"] = {
	},
	["Marelle of Kronos"] = {
		["Arcane Intellect"] = 1800,
	},
	["Tarzdan of Kronos"] = {
	},
	["Visenda of Kronos"] = {
	},
	["Vesenya of Kronos"] = {
	},
}
