
ElkBuffBarsDB = {
	["profiles"] = {
		["Default"] = {
			["hidetrackingframe"] = false,
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["groupspacing"] = 1,
			["minimapPosition"] = 177.2996363506193,
			["typeoverride"] = {
				["DEBUFF"] = {
					["Hemorrhage"] = "BUFF",
				},
			},
			["hidetenchframe"] = false,
			["bargroups"] = {
				{
					["sorting"] = "none",
					["growup"] = true,
					["id"] = 1,
					["barspacing"] = 2,
					["y"] = 205.0726623535156,
					["x"] = 855.9989624023438,
					["anchortext"] = "debuffs",
					["filter"] = {
						["type"] = {
							["DEBUFF"] = true,
							["BUFF"] = true,
						},
						["names_exclude"] = {
							["DEBUFF"] = {
								["Enrage"] = true,
								["Intimidating Shout"] = true,
								["Geyser"] = true,
								["Intimidation"] = true,
								["Corruption"] = true,
								["Immolate"] = true,
								["Concussion Blow"] = true,
								["Taunt"] = true,
								["Thunder Clap"] = true,
								["Scorpid Sting"] = true,
								["Sonic Burst"] = true,
								["Hunter's Mark"] = true,
								["Challenging Shout"] = true,
								["Battle Shout"] = true,
								["Explosive Trap Effect"] = true,
								["Frost Nova"] = true,
								["Siphon Life"] = true,
								["Net"] = true,
								["Demoralizing Shout"] = true,
								["Drain Life"] = true,
								["Unstable Affliction"] = true,
								["Curse of Doom"] = true,
								["Psychic Scream"] = true,
								["Charge Stun"] = true,
								["Shadowburn"] = true,
								["Drain Soul"] = true,
								["Weakened Soul"] = true,
								["Sunder Armor"] = true,
								["War Stomp"] = true,
								["Curse of Agony"] = true,
							},
						},
						["timemax_max"] = 60,
						["untilcancelled"] = "hide",
						["names_include"] = {
							["DEBUFF"] = {
								["Kidney Shot"] = true,
								["Garrote"] = true,
								["Gouge"] = true,
								["Hemorrhage"] = true,
								["Deadly Poison IV"] = true,
								["Rupture"] = true,
								["Sap"] = true,
								["Cheap Shot"] = true,
								["Blind"] = true,
							},
							["BUFF"] = {
								["Renew"] = true,
								["Power Word: Shield"] = true,
								["Pain Suppression"] = true,
								["Prayer of Mending"] = true,
							},
						},
					},
					["target"] = "target",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Arial Narrow",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "LEFT",
						["abbreviate_name"] = 0,
						["bgbar"] = true,
						["iconcount"] = true,
						["textTLalign"] = "LEFT",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = "TIMELEFT",
						["bar"] = true,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["barbgcolor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							0.7300000190734863, -- [4]
						},
						["textTLcolor"] = {
							0.9764705882352941, -- [1]
							1, -- [2]
							0.9568627450980392, -- [3]
							1, -- [4]
						},
						["timeformat"] = "FULL",
						["textTLfont"] = "Arial Narrow",
						["iconcountfont"] = "Arial Narrow",
						["textTL"] = "NAME",
						["iconcountanchor"] = "CENTER",
						["height"] = 15,
						["timelessfull"] = false,
						["textTRfontsize"] = 10,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["textTLfontsize"] = 10,
						["barright"] = false,
						["bartexture"] = "Flat",
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["alpha"] = 1,
						["iconcountfontsize"] = 9,
						["debufftypecolor"] = false,
						["textBLfontsize"] = 14,
						["textBLfont"] = "Friz Quadrata TT",
						["width"] = 220,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["padding"] = 2,
						["textBLalign"] = "LEFT",
						["barcolor"] = {
							1, -- [1]
							0, -- [2]
							0.3372549019607843, -- [3]
							1, -- [4]
						},
					},
					["stickside"] = "LEFT",
					["anchorshown"] = false,
				}, -- [1]
				{
					["anchorshown"] = false,
					["growup"] = true,
					["barspacing"] = 2,
					["anchortext"] = "buffs",
					["x"] = 508.0947570800781,
					["id"] = 2,
					["filter"] = {
						["type"] = {
							["BUFF"] = true,
						},
						["untilcancelled"] = "hide",
						["names_include"] = {
							["BUFF"] = {
								["Blade Flurry"] = true,
								["Slice and Dice"] = true,
								["Adrenaline Rush"] = true,
								["Evasion"] = true,
								["Sprint"] = true,
							},
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Arial Narrow",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "LEFT",
						["abbreviate_name"] = 0,
						["bgbar"] = true,
						["iconcount"] = true,
						["textTLalign"] = "LEFT",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = "TIMELEFT",
						["bar"] = true,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["barbgcolor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							0.7300000190734863, -- [4]
						},
						["barcolor"] = {
							0.407843137254902, -- [1]
							0.984313725490196, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["timeformat"] = "FULL",
						["textTLfont"] = "Arial Narrow",
						["iconcountfont"] = "Arial Narrow",
						["height"] = 15,
						["iconcountanchor"] = "CENTER",
						["textTL"] = "NAME",
						["timelessfull"] = false,
						["textTLcolor"] = {
							0.9764705882352941, -- [1]
							1, -- [2]
							0.9568627450980392, -- [3]
							1, -- [4]
						},
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["textTLfontsize"] = 10,
						["bartexture"] = "Flat",
						["barright"] = false,
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["alpha"] = 1,
						["iconcountfontsize"] = 9,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["debufftypecolor"] = false,
						["width"] = 220,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["padding"] = 2,
						["textBLalign"] = "LEFT",
						["textTRfontsize"] = 10,
					},
					["y"] = 203.9928894042969,
					["sorting"] = "none",
				}, -- [2]
			},
		},
	},
	["account"] = {
		["maxcharges"] = {
			["TENCH"] = {
			},
			["DEBUFF"] = {
			},
			["BUFF"] = {
			},
		},
		["maxtimes"] = {
			["TENCH"] = {
			},
			["DEBUFF"] = {
				["Rupture Rank 6"] = 12,
				["Garrote Rank 6"] = 18,
			},
			["BUFF"] = {
				["Blue Skeletal Horse "] = 0,
				["Stealth Rank 4"] = 0,
			},
		},
		["build"] = "8606",
	},
}
