
QuartzDB = {
	["disabledModules"] = {
		["PixelpintUI"] = {
			["Pet"] = true,
			["GCD"] = true,
			["Buff"] = true,
		},
		["Default"] = {
			["Buff"] = true,
		},
	},
	["namespaces"] = {
		["Swing"] = {
			["profiles"] = {
				["Default"] = {
					["swinggap"] = -4,
					["barcolor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["swingheight"] = 4,
					["y"] = 300,
					["x"] = 300,
					["swingalpha"] = 1,
					["remainingtext"] = true,
					["swingposition"] = "Top",
					["durationtext"] = true,
				},
			},
		},
		["Buff"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["debuffsbytype"] = false,
					["bufffont"] = "Arial Narrow",
					["bufffontsize"] = 11,
					["buffcolor"] = {
						0.2392156862745098, -- [1]
						0.192156862745098, -- [2]
						0.192156862745098, -- [3]
					},
					["targetspacing"] = 2,
					["targetanchor"] = "Free",
					["bufftexture"] = "Armory",
					["timesort"] = false,
					["focus"] = false,
					["targetx"] = 1059.533203125,
					["targetwidth"] = 200,
					["debuffcolor"] = {
						0.6235294117647059, -- [1]
						0.611764705882353, -- [2]
						0.4745098039215686, -- [3]
					},
					["targety"] = 218.866943359375,
				},
				["Default"] = {
					["targetheight"] = 18,
					["bufffont"] = "Arial Narrow",
					["targetspacing"] = 2,
					["buffcolor"] = {
						0.2274509803921569, -- [1]
						0.2392156862745098, -- [2]
						0.2313725490196079, -- [3]
					},
					["debuffsbytype"] = false,
					["debuffcolor"] = {
						0.6039215686274509, -- [1]
						0.611764705882353, -- [2]
						0.6235294117647059, -- [3]
					},
					["bufffontsize"] = 12,
					["bufftexture"] = "Flat",
					["targetanchor"] = "Free",
					["focus"] = false,
					["targetx"] = 1060.244262695313,
					["targetwidth"] = 198,
					["timesort"] = false,
					["targety"] = 191.1334686279297,
				},
			},
		},
		["Flight"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["deplete"] = true,
				},
			},
		},
		["Mirror"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["mirroricons"] = false,
					["mirroranchor"] = "Free",
					["mirrorspacing"] = 0,
					["mirrory"] = "810",
					["mirrorheight"] = 18,
					["mirrortexture"] = "Flat",
					["mirrorfont"] = "BigNoodleTitling",
					["mirrorx"] = "860",
					["mirrorwidth"] = 200,
					["mirrorfontsize"] = 12,
				},
				["Default"] = {
					["mirroricons"] = false,
					["DUEL_REQUESTED"] = {
						1, -- [1]
						0.13, -- [2]
						0, -- [3]
					},
					["mirroroffset"] = 3,
					["REZTIMER"] = {
						1, -- [1]
						0, -- [2]
						0.5, -- [3]
					},
					["mirroranchor"] = "Free",
					["RESURRECT_NO_SICKNESS"] = {
						0.47, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["DEATH"] = {
						1, -- [1]
						0.1, -- [2]
						0.1, -- [3]
					},
					["mirrorspacing"] = 0,
					["mirrortimetext"] = true,
					["mirrory"] = "810",
					["GAMESTART"] = {
						0, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["mirrorgrowdirection"] = "Up",
					["hideblizzmirrors"] = true,
					["AREA_SPIRIT_HEAL"] = {
						0, -- [1]
						0.22, -- [2]
						1, -- [3]
					},
					["CONFIRM_SUMMON"] = {
						1, -- [1]
						0.3, -- [2]
						1, -- [3]
					},
					["showpvp"] = true,
					["mirrortextcolor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["mirrorheight"] = 18,
					["mirrortexture"] = "Flat",
					["mirrorfont"] = "BigNoodleTitling",
					["mirrorx"] = "860",
					["BREATH"] = {
						0, -- [1]
						0.5, -- [2]
						1, -- [3]
					},
					["INSTANCE_BOOT"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["PARTY_INVITE"] = {
						1, -- [1]
						0.9, -- [2]
						0, -- [3]
					},
					["mirroriconside"] = "Left",
					["FEIGNDEATH"] = {
						1, -- [1]
						0.7, -- [2]
						0, -- [3]
					},
					["mirrorgap"] = 1,
					["CAMP"] = {
						1, -- [1]
						0.7, -- [2]
						0, -- [3]
					},
					["mirrorwidth"] = 200,
					["DUEL_OUTOFBOUNDS"] = {
						0.2, -- [1]
						0.8, -- [2]
						0.2, -- [3]
					},
					["RESURRECT_NO_TIMER"] = {
						0.47, -- [1]
						1, -- [2]
						0, -- [3]
					},
					["showmirror"] = true,
					["mirrornametext"] = true,
					["EXHAUSTION"] = {
						1, -- [1]
						0.9, -- [2]
						0, -- [3]
					},
					["mirroralpha"] = 1,
					["showstatic"] = true,
					["mirrorfontsize"] = 12,
					["QUIT"] = {
						1, -- [1]
						0.7, -- [2]
						0, -- [3]
					},
					["mirrorposition"] = "Top Left",
				},
			},
		},
		["Player"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["timetextx"] = 2,
					["border"] = "PixelP",
					["h"] = 12,
					["fontsize"] = 10,
					["timefontsize"] = 10,
					["timetexty"] = 1,
					["texture"] = "Armory",
					["w"] = 190,
					["y"] = 148.8955841064453,
					["font"] = "BigNoodleTitling",
					["nametexty"] = 1,
					["x"] = 501.7825927734375,
					["nametextx"] = 20,
					["hidecasttime"] = true,
				},
				["Default"] = {
					["hideblizz"] = true,
					["timetextx"] = 2,
					["timetextposition"] = "Right",
					["spellrank"] = false,
					["border"] = "Blizzard Tooltip",
					["hidenametext"] = false,
					["h"] = 12,
					["fontsize"] = 10,
					["scale"] = 1,
					["timetexty"] = 1,
					["timefontsize"] = 10,
					["iconposition"] = "Left",
					["texture"] = "Flat",
					["spellrankstyle"] = "Roman",
					["casttimeprecision"] = 1,
					["nametextposition"] = "Left",
					["nametextx"] = 20,
					["nametexty"] = 1,
					["targetname"] = false,
					["alpha"] = 1,
					["w"] = 320,
					["hideicon"] = true,
					["x"] = 516.0640258789063,
					["font"] = "BigNoodleTitling",
					["iconalpha"] = 0.9,
					["y"] = 101.7823944091797,
					["icongap"] = 4,
					["hidetimetext"] = false,
					["hidecasttime"] = true,
				},
			},
		},
		["GCD"] = {
			["profiles"] = {
				["Default"] = {
					["gcdgap"] = -4,
					["gcdposition"] = "Bottom",
					["gcdalpha"] = 0.9,
					["deplete"] = false,
					["gcdheight"] = 4,
					["y"] = 300,
					["x"] = 500,
					["sparkcolor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
			},
		},
		["Focus"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["scale"] = 0.9750000000000001,
					["h"] = 11,
					["fontsize"] = 11,
					["nametextx"] = 5,
					["texture"] = "Armory",
					["w"] = 125,
					["y"] = 251.8965606689453,
					["x"] = 352.3106384277344,
					["hidenametext"] = true,
					["hidecasttime"] = true,
				},
				["Default"] = {
					["timetextx"] = 3,
					["timetextposition"] = "Right",
					["scale"] = 0.9750000000000001,
					["showhostile"] = true,
					["hidenametext"] = true,
					["iconposition"] = "Left",
					["h"] = 11,
					["fontsize"] = 11,
					["hidecasttime"] = true,
					["nametextx"] = 5,
					["timefontsize"] = 12,
					["nametextposition"] = "Left",
					["iconalpha"] = 0.9,
					["hidetimetext"] = false,
					["font"] = "Friz Quadrata TT",
					["hideicon"] = false,
					["showfriendly"] = true,
					["showtarget"] = true,
					["alpha"] = 1,
					["texture"] = "Flat",
					["y"] = 251.8965606689453,
					["x"] = 352.3106384277344,
					["w"] = 125,
					["nametexty"] = 0,
					["spellrankstyle"] = "Roman",
					["icongap"] = 4,
					["spellrank"] = false,
					["timetexty"] = 0,
				},
			},
		},
		["Target"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["timetextx"] = 2,
					["h"] = 12,
					["fontsize"] = 10,
					["font"] = "BigNoodleTitling",
					["timefontsize"] = 10,
					["texture"] = "Armory",
					["w"] = 190,
					["y"] = 149.4686584472656,
					["x"] = 828.9505615234375,
					["iconposition"] = "Left",
					["nametexty"] = 1,
					["hidecasttime"] = true,
					["nametextx"] = 20,
					["timetexty"] = 1,
				},
				["Default"] = {
					["timetextx"] = 2,
					["timetextposition"] = "Left",
					["spellrank"] = false,
					["hidenametext"] = false,
					["showhostile"] = true,
					["h"] = 10,
					["fontsize"] = 10,
					["hidecasttime"] = true,
					["spellrankstyle"] = "Roman",
					["scale"] = 1,
					["nametextposition"] = "Right",
					["hidetimetext"] = false,
					["iconalpha"] = 0.9,
					["texture"] = "Flat",
					["x"] = 577.2445678710938,
					["showfriendly"] = true,
					["hideicon"] = false,
					["alpha"] = 1,
					["nametextx"] = 20,
					["y"] = 346.9338989257813,
					["font"] = "BigNoodleTitling",
					["w"] = 190,
					["nametexty"] = 1,
					["timefontsize"] = 10,
					["icongap"] = 4,
					["iconposition"] = "Right",
					["timetexty"] = 1,
				},
			},
		},
		["Pet"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["y"] = 316.9352722167969,
					["x"] = 749.6174926757813,
					["scale"] = 0.625,
					["h"] = 10,
					["w"] = 170,
					["texture"] = "Armory",
				},
				["Default"] = {
					["hideblizz"] = true,
					["timetextx"] = 3,
					["timetextposition"] = "Right",
					["spellrank"] = false,
					["hidenametext"] = false,
					["h"] = 18,
					["fontsize"] = 14,
					["nametextx"] = 3,
					["timetexty"] = 0,
					["nametextposition"] = "Left",
					["texture"] = "LiteStep",
					["timefontsize"] = 12,
					["spellrankstyle"] = "Roman",
					["iconalpha"] = 0.9,
					["hidetimetext"] = false,
					["font"] = "Friz Quadrata TT",
					["alpha"] = 1,
					["hideicon"] = false,
					["y"] = 300,
					["x"] = 755,
					["w"] = 200,
					["nametexty"] = 0,
					["iconposition"] = "Left",
					["icongap"] = 4,
					["scale"] = 1,
					["hidecasttime"] = false,
				},
			},
		},
		["Latency"] = {
			["profiles"] = {
				["PixelpintUI"] = {
					["lagtext"] = false,
				},
				["Default"] = {
					["lagpadding"] = 0,
					["lagtextalignment"] = "Center",
					["lagtextposition"] = "Bottom",
					["lagtext"] = false,
					["lagcolor"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["lagfontsize"] = 7,
					["lagembed"] = false,
					["lagfont"] = "Friz Quadrata TT",
					["lagtextcolor"] = {
						0.7, -- [1]
						0.7, -- [2]
						0.7, -- [3]
						0.8, -- [4]
					},
					["lagalpha"] = 0.6,
				},
			},
		},
	},
	["currentProfile"] = {
		["Pixelpoint - Hellfire"] = "PixelpintUI",
		["Pxl - Smolderforge"] = "PixelpintUI",
		["Pxlmage - Smolderforge"] = "PixelpintUI",
		["Astalker - Smolderforge"] = "PixelpintUI",
		["Pixelpointxx - Bugs and Crashes"] = "PixelpintUI",
		["Pixelpoint - Outland"] = "PixelpintUI",
	},
	["profiles"] = {
		["PixelpintUI"] = {
			["channelingcolor"] = {
				0.3215686274509804, -- [1]
				0.3019607843137255, -- [2]
			},
			["completecolor"] = {
				0.1215686274509804, -- [1]
				0.8588235294117647, -- [2]
				0.1490196078431373, -- [3]
			},
			["backgroundcolor"] = {
				0.07843137254901961, -- [1]
				0.07843137254901961, -- [2]
				0.07843137254901961, -- [3]
			},
			["castingcolor"] = {
				0.8549019607843137, -- [1]
				0.7529411764705882, -- [2]
				0.6549019607843137, -- [3]
			},
			["sparkcolor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				0, -- [4]
			},
			["borderalpha"] = 0,
		},
		["Default"] = {
			["channelingcolor"] = {
				0.3215686274509804, -- [1]
				0.3019607843137255, -- [2]
			},
			["castingcolor"] = {
				0.9333333333333334, -- [1]
				0.9764705882352941, -- [2]
				1, -- [3]
			},
			["borderalpha"] = 0,
			["completecolor"] = {
				0.1215686274509804, -- [1]
				0.8588235294117647, -- [2]
				0.1490196078431373, -- [3]
			},
			["backgroundcolor"] = {
				0.1058823529411765, -- [1]
				0.1058823529411765, -- [2]
				0.1058823529411765, -- [3]
			},
			["sparkcolor"] = {
				[4] = 0,
			},
		},
	},
}
