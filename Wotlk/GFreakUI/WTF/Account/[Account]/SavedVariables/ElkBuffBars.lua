
ElkBuffBarsDB = {
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
			},
			["BUFF"] = {
			},
		},
		["build"] = "12340",
	},
	["profiles"] = {
		["Default"] = {
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["minimapPosition"] = 288.1659903426505,
			["bargroups"] = {
				{
					["scale"] = 1,
					["barspacing"] = 0,
					["alpha"] = 1,
					["anchortext"] = "BUFFS & TRACKING",
					["anchorshown"] = true,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["BUFF"] = true,
							["TRACKING"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
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
						["textTL"] = "NAMERANKCOUNT",
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["timeformat"] = "CONDENSED",
						["timelessfull"] = false,
						["iconcountanchor"] = "CENTER",
						["textTLfontsize"] = 14,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["textTRfontsize"] = 14,
						["barcolor"] = {
							0.3, -- [1]
							0.5, -- [2]
							1, -- [3]
							0.8, -- [4]
						},
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["barright"] = false,
						["barbgcolor"] = {
							0, -- [1]
							0.5, -- [2]
							1, -- [3]
							0.3, -- [4]
						},
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["debufftypecolor"] = true,
						["iconcountfontsize"] = 14,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["width"] = 250,
						["bartexture"] = "Otravi",
						["spark"] = false,
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["height"] = 20,
					},
					["id"] = 1,
					["sorting"] = "timeleft",
				}, -- [1]
				{
					["anchorshown"] = false,
					["id"] = 2,
					["barspacing"] = 0,
					["alpha"] = 1,
					["stickto"] = 1,
					["anchortext"] = "DEBUFFS",
					["scale"] = 1,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["DEBUFF"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
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
						["textTL"] = "NAMERANKCOUNT",
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["timeformat"] = "CONDENSED",
						["timelessfull"] = false,
						["iconcountanchor"] = "CENTER",
						["textTLfontsize"] = 14,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["textTRfontsize"] = 14,
						["barcolor"] = {
							1, -- [1]
							0, -- [2]
							0, -- [3]
							0.8, -- [4]
						},
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["barright"] = false,
						["barbgcolor"] = {
							1, -- [1]
							0, -- [2]
							0, -- [3]
							0.3, -- [4]
						},
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["debufftypecolor"] = true,
						["iconcountfontsize"] = 14,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["width"] = 250,
						["bartexture"] = "Otravi",
						["spark"] = false,
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["height"] = 20,
					},
					["stickside"] = "",
					["sorting"] = "timeleft",
				}, -- [2]
				{
					["anchorshown"] = false,
					["id"] = 3,
					["barspacing"] = 0,
					["alpha"] = 1,
					["stickto"] = 2,
					["anchortext"] = "TENCH",
					["scale"] = 1,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["TENCH"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
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
						["textTL"] = "NAMERANKCOUNT",
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["timeformat"] = "CONDENSED",
						["timelessfull"] = false,
						["iconcountanchor"] = "CENTER",
						["textTLfontsize"] = 14,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["textTRfontsize"] = 14,
						["barcolor"] = {
							0.5, -- [1]
							0, -- [2]
							0.5, -- [3]
							0.8, -- [4]
						},
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["barright"] = false,
						["barbgcolor"] = {
							0.5, -- [1]
							0, -- [2]
							0.5, -- [3]
							0.3, -- [4]
						},
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["debufftypecolor"] = true,
						["iconcountfontsize"] = 14,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["width"] = 250,
						["bartexture"] = "Otravi",
						["spark"] = false,
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["height"] = 20,
					},
					["stickside"] = "",
					["sorting"] = "timeleft",
				}, -- [3]
			},
		},
	},
}
