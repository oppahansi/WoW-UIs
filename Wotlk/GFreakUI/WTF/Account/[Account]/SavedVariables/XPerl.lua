
XPerlConfig = nil
XPerlConfig_Global = nil
XPerlConfigNew = {
	["global"] = {
		["highlight"] = {
			["enable"] = 1,
			["AGGRO"] = 1,
		},
		["highlightSelection"] = 1,
		["bar"] = {
			["fat"] = 1,
			["background"] = 1,
			["fadeTime"] = 0.5,
			["texture"] = {
				"Perl v2", -- [1]
				"Interface\\Addons\\XPerl\\Images\\XPerl_StatusBar", -- [2]
			},
		},
		["rangeFinder"] = {
			["StatsFrame"] = {
				["FadeAmount"] = 0.5,
				["item"] = "Heavy Frostweave Bandage",
				["HealthLowPoint"] = 0.85,
			},
			["Main"] = {
				["enabled"] = true,
				["item"] = "Heavy Frostweave Bandage",
				["FadeAmount"] = 0.5,
				["HealthLowPoint"] = 0.85,
			},
			["NameFrame"] = {
				["FadeAmount"] = 0.5,
				["item"] = "Heavy Frostweave Bandage",
				["HealthLowPoint"] = 0.85,
			},
		},
		["showAFK"] = 1,
		["ShowTutorials"] = true,
		["buffHelper"] = {
			["enable"] = 1,
			["sort"] = "group",
			["visible"] = 1,
		},
		["focus"] = {
			["debuffs"] = {
				["enable"] = 1,
				["big"] = 1,
				["curable"] = 0,
				["size"] = 29,
			},
			["portrait"] = 1,
			["combo"] = {
				["enable"] = 1,
				["blizzard"] = 1,
				["pos"] = "top",
			},
			["enable"] = 1,
			["mana"] = 1,
			["castBar"] = {
				["enable"] = 1,
			},
			["hitIndicator"] = 1,
			["level"] = 1,
			["sound"] = 1,
			["size"] = {
				["width"] = 0,
			},
			["threat"] = 1,
			["portrait3D"] = 1,
			["pvpIcon"] = 1,
			["mobType"] = 1,
			["highlightDebuffs"] = {
				["who"] = 2,
			},
			["raidIconAlternate"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["threatMode"] = "portraitFrame",
			["elite"] = 1,
			["scale"] = 0.8,
			["values"] = 1,
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["wrap"] = 1,
				["rows"] = 3,
				["size"] = 22,
			},
			["percent"] = 1,
			["classIcon"] = 1,
		},
		["target"] = {
			["debuffs"] = {
				["enable"] = 1,
				["big"] = 1,
				["curable"] = 0,
				["size"] = 29,
			},
			["portrait"] = 1,
			["combo"] = {
				["enable"] = 1,
				["blizzard"] = 1,
				["pos"] = "top",
			},
			["enable"] = 1,
			["mana"] = 1,
			["castBar"] = {
				["enable"] = 1,
			},
			["hitIndicator"] = 1,
			["level"] = 1,
			["sound"] = 1,
			["size"] = {
				["width"] = 0,
			},
			["threat"] = 1,
			["portrait3D"] = 1,
			["pvpIcon"] = 1,
			["mobType"] = 1,
			["highlightDebuffs"] = {
				["who"] = 2,
			},
			["raidIconAlternate"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["threatMode"] = "portraitFrame",
			["elite"] = 1,
			["scale"] = 0.8,
			["values"] = 1,
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["wrap"] = 1,
				["rows"] = 3,
				["size"] = 22,
			},
			["percent"] = 1,
			["classIcon"] = 1,
		},
		["raid"] = {
			["debuffs"] = {
				["enable"] = 1,
				["size"] = 20,
			},
			["enable"] = 1,
			["class"] = {
				{
					["enable"] = 1,
					["name"] = "WARRIOR",
				}, -- [1]
				{
					["enable"] = 1,
					["name"] = "ROGUE",
				}, -- [2]
				{
					["enable"] = 1,
					["name"] = "HUNTER",
				}, -- [3]
				{
					["enable"] = 1,
					["name"] = "MAGE",
				}, -- [4]
				{
					["enable"] = 1,
					["name"] = "WARLOCK",
				}, -- [5]
				{
					["enable"] = 1,
					["name"] = "PRIEST",
				}, -- [6]
				{
					["enable"] = 1,
					["name"] = "DRUID",
				}, -- [7]
				{
					["enable"] = 1,
					["name"] = "SHAMAN",
				}, -- [8]
				{
					["enable"] = 1,
					["name"] = "PALADIN",
				}, -- [9]
				{
					["enable"] = 1,
					["name"] = "DEATHKNIGHT",
				}, -- [10]
			},
			["group"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
				1, -- [5]
				1, -- [6]
				1, -- [7]
				1, -- [8]
				1, -- [9]
			},
			["titles"] = 1,
			["scale"] = 0.8,
			["healerMode"] = {
				["type"] = 1,
			},
			["spacing"] = 0,
			["anchor"] = "TOP",
			["buffs"] = {
				["castable"] = 0,
				["maxrows"] = 2,
				["right"] = 1,
				["size"] = 20,
				["inside"] = 1,
			},
			["percent"] = 1,
			["size"] = {
				["width"] = 0,
			},
		},
		["raidpet"] = {
			["enable"] = 1,
			["hunter"] = 1,
			["warlock"] = 1,
		},
		["colour"] = {
			["gradient"] = {
				["enable"] = 1,
				["s"] = {
					["a"] = 1,
					["b"] = 0.25,
					["g"] = 0.25,
					["r"] = 0.25,
				},
				["e"] = {
					["a"] = 0,
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 0.1,
				},
			},
			["class"] = 1,
			["reaction"] = {
				["tapped"] = {
					["b"] = 0.5,
					["g"] = 0.5,
					["r"] = 0.5,
				},
				["none"] = {
					["b"] = 1,
					["g"] = 0.5,
					["r"] = 0.5,
				},
				["neutral"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["unfriendly"] = {
					["b"] = 0,
					["g"] = 0.5,
					["r"] = 1,
				},
				["friend"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 0,
				},
				["enemy"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
			},
			["guildList"] = 1,
			["classic"] = 1,
			["frame"] = {
				["a"] = 1,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["border"] = {
				["a"] = 1,
				["b"] = 0.5,
				["g"] = 0.5,
				["r"] = 0.5,
			},
			["bar"] = {
				["rage"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["healthFull"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 0,
				},
				["focus"] = {
					["b"] = 0.25,
					["g"] = 0.5,
					["r"] = 1,
				},
				["runic_power"] = {
					["b"] = 1,
					["g"] = 0.82,
					["r"] = 0,
				},
				["mana"] = {
					["b"] = 1,
					["g"] = 0,
					["r"] = 0,
				},
				["healthEmpty"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["energy"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
			},
		},
		["minimap"] = {
			["enable"] = 1,
			["radius"] = 78,
			["pos"] = 192.5445181187431,
		},
		["targettargettarget"] = {
			["debuffs"] = {
				["enable"] = 1,
				["curable"] = 0,
				["size"] = 29,
			},
			["values"] = 1,
			["pvpIcon"] = 1,
			["scale"] = 0.7,
			["mana"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["rows"] = 3,
				["wrap"] = 1,
				["size"] = 22,
			},
			["percent"] = 1,
			["size"] = {
				["width"] = 0,
			},
		},
		["focustarget"] = {
			["debuffs"] = {
				["enable"] = 1,
				["curable"] = 0,
				["size"] = 29,
			},
			["values"] = 1,
			["pvpIcon"] = 1,
			["enable"] = 1,
			["mana"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["scale"] = 0.7,
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["rows"] = 3,
				["wrap"] = 1,
				["size"] = 22,
			},
			["percent"] = 1,
			["size"] = {
				["width"] = 0,
			},
		},
		["targettarget"] = {
			["debuffs"] = {
				["enable"] = 1,
				["curable"] = 0,
				["size"] = 29,
			},
			["values"] = 1,
			["pvpIcon"] = 1,
			["enable"] = 1,
			["mana"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["scale"] = 0.7,
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["rows"] = 3,
				["wrap"] = 1,
				["size"] = 22,
			},
			["percent"] = 1,
			["size"] = {
				["width"] = 0,
			},
		},
		["player"] = {
			["partyNumber"] = 1,
			["debuffs"] = {
				["enable"] = 1,
				["size"] = 25,
			},
			["portrait"] = 1,
			["scale"] = 0.9,
			["castBar"] = {
				["enable"] = 1,
			},
			["fullScreen"] = {
				["enable"] = 1,
				["highHP"] = 40,
				["lowHP"] = 30,
			},
			["hitIndicator"] = 1,
			["dockRunes"] = 1,
			["level"] = 1,
			["size"] = {
				["width"] = 0,
			},
			["threat"] = 1,
			["portrait3D"] = 1,
			["pvpIcon"] = 1,
			["xpDeficit"] = 1,
			["energyTicker"] = 1,
			["showRunes"] = 1,
			["xpBar"] = 1,
			["threatMode"] = "portraitFrame",
			["totems"] = {
				["enable"] = true,
				["offsetY"] = 0,
				["offsetX"] = 0,
			},
			["values"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["buffs"] = {
				["enable"] = 1,
				["wrap"] = 1,
				["flash"] = 1,
				["count"] = 40,
				["maxrows"] = 2,
				["rows"] = 2,
				["hideBlizzard"] = 1,
				["cooldown"] = 1,
				["size"] = 25,
			},
			["percent"] = 1,
			["classIcon"] = 1,
		},
		["tooltip"] = {
			["enable"] = 1,
			["enableBuffs"] = 1,
			["modifier"] = "all",
		},
		["pettarget"] = {
			["debuffs"] = {
				["enable"] = 1,
				["curable"] = 0,
				["size"] = 29,
			},
			["values"] = 1,
			["pvpIcon"] = 1,
			["enable"] = 1,
			["mana"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["scale"] = 0.7,
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["rows"] = 3,
				["wrap"] = 1,
				["size"] = 22,
			},
			["percent"] = 1,
			["size"] = {
				["width"] = 0,
			},
		},
		["partypet"] = {
			["debuffs"] = {
				["enable"] = 1,
				["curable"] = 0,
				["size"] = 12,
			},
			["name"] = 1,
			["scale"] = 0.7,
			["enable"] = 1,
			["buffs"] = {
				["enable"] = 1,
				["maxrows"] = 2,
				["size"] = 12,
				["castable"] = 0,
			},
			["healerMode"] = {
				["type"] = 1,
			},
			["size"] = {
				["width"] = 0,
			},
		},
		["highlightDebuffs"] = {
			["enable"] = 1,
			["frame"] = 1,
			["border"] = 1,
			["class"] = 1,
		},
		["transparency"] = {
			["text"] = 1,
			["frame"] = 1,
		},
		["pet"] = {
			["threat"] = 1,
			["portrait"] = 1,
			["debuffs"] = {
				["enable"] = 1,
				["size"] = 20,
			},
			["scale"] = 0.7,
			["portrait3D"] = 1,
			["buffs"] = {
				["enable"] = 1,
				["maxrows"] = 2,
				["size"] = 18,
			},
			["values"] = 1,
			["castBar"] = {
				["enable"] = 1,
			},
			["threatMode"] = "portraitFrame",
			["name"] = 1,
			["hitIndicator"] = 1,
			["happiness"] = {
				["enabled"] = 1,
				["flashWhenSad"] = 1,
				["onlyWhenSad"] = 1,
			},
			["level"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["size"] = {
				["enable"] = 1,
				["size"] = 20,
				["width"] = 0,
			},
		},
		["party"] = {
			["debuffs"] = {
				["halfSize"] = 1,
				["below"] = 1,
				["enable"] = 1,
				["curable"] = 0,
				["size"] = 32,
			},
			["portrait"] = 1,
			["scale"] = 0.8,
			["castBar"] = {
				["enable"] = 1,
				["castTime"] = 1,
			},
			["spacing"] = 74,
			["anchor"] = "TOP",
			["level"] = 1,
			["size"] = {
				["width"] = 0,
			},
			["threat"] = 1,
			["portrait3D"] = 1,
			["pvpIcon"] = 1,
			["healerMode"] = {
				["type"] = 1,
			},
			["values"] = 1,
			["threatMode"] = "portraitFrame",
			["name"] = 1,
			["target"] = {
				["enable"] = 1,
				["size"] = 120,
				["large"] = 1,
			},
			["hitIndicator"] = 1,
			["buffs"] = {
				["maxrows"] = 2,
				["castable"] = 0,
				["enable"] = 1,
				["wrap"] = 1,
				["rows"] = 2,
				["size"] = 22,
			},
			["percent"] = 1,
			["classIcon"] = 1,
		},
		["combatFlash"] = 1,
		["buffs"] = {
			["countdown"] = 1,
			["cooldown"] = 1,
			["countdownStart"] = 20,
		},
		["maximumScale"] = 1.5,
		["optionsColour"] = {
			["b"] = 0.2,
			["g"] = 0.2,
			["r"] = 0.7,
		},
	},
	["savedPositions"] = {
		["Icecrown"] = {
			["Glamrocker"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.37760069585,
					["left"] = 216.8000086468412,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 533.9999539070006,
					["height"] = 64.62743815040966,
					["left"] = 737.4443625697217,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 422.8004128213233,
					["left"] = 975.6445980671296,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 458.9999900838503,
					["height"] = 149.9999976748339,
					["left"] = 612.6666817574509,
					["width"] = 140.0000106684094,
				},
				["XPerl_Raid_TitlePets"] = {
					["top"] = 548.0001714745666,
					["left"] = 526.0000071541384,
				},
				["XPerl_OptionsAnchor"] = {
					["top"] = 870.0001125653962,
					["height"] = 540.0001737035882,
					["left"] = 707.7778249041844,
					["width"] = 717.777759389209,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 693.3333426803894,
					["left"] = 411.7000716683085,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 422.8004128213233,
					["left"] = 716.4445108270249,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 422.8004128213233,
					["left"] = 522.0444594026534,
				},
				["XPerl_Player"] = {
					["top"] = 1173.644515755014,
					["left"] = 24.03331598510612,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.644316773334,
					["left"] = 416.0332901695005,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 422.8004128213233,
					["left"] = 1040.444633882863,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1590.365651275591,
					["left"] = 282.6825925415052,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.366915135648,
					["left"] = 99.87780162710145,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 422.8004128213233,
					["left"] = 781.2444345971031,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 422.8004128213233,
					["left"] = 846.0444704128362,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 422.8004128213233,
					["left"] = 910.8445622513966,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.7332261800782,
					["left"] = 13.06666972452098,
				},
				["XPerl_AggroAnchor"] = {
					["top"] = 1006.000215966902,
					["left"] = 1055.11150641975,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 422.8004128213233,
					["left"] = 1105.244557652941,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 446.0000332361984,
					["height"] = 123.9999964438636,
					["left"] = 517.6666038643851,
					["width"] = 330.0000439046077,
				},
				["XPerl_Target"] = {
					["top"] = 1173.644396266162,
					["left"] = 221.1332763063715,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 422.8004128213233,
					["left"] = 586.8444391955591,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 422.8004128213233,
					["left"] = 651.644475011292,
				},
			},
			["Testasdfasdf"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 662.0000326891004,
					["height"] = 124.0000051974302,
					["left"] = 901.6667351678849,
					["width"] = 330.0000088903411,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 424.0000093006645,
					["height"] = 80.00000109419584,
					["left"] = 579.6666458541502,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 827.9999658895476,
					["left"] = 425.6000135636268,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 675.0000595652856,
					["height"] = 149.9999976748339,
					["left"] = 996.6666730038842,
					["width"] = 140.0000106684094,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 1039.999989510598,
					["left"] = 414.7000449598733,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 827.9999658895476,
					["left"] = 182.4000038121677,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 827.9999658895476,
					["left"] = 0,
				},
				["XPerl_Player"] = {
					["top"] = 1189.200009447236,
					["left"] = 20.70000012867092,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 827.9999658895476,
					["left"] = 486.400047514332,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 827.9999658895476,
					["left"] = 243.200023757166,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1137.70002984338,
					["left"] = 72.09999700091484,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1611.285806861378,
					["left"] = 233.4999963722936,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 827.9999658895476,
					["left"] = 304.0000296964575,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 827.9999658895476,
					["left"] = 60.8000059392915,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 1079.999999352058,
					["left"] = 0,
				},
				["XPerl_Focus"] = {
					["top"] = 1039.999924678952,
					["left"] = 216.8000086468412,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 827.9999658895476,
					["left"] = 547.2000534536235,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 827.9999658895476,
					["left"] = 364.8000076243353,
				},
				["XPerl_Target"] = {
					["top"] = 1190.399927576605,
					["left"] = 216.8000086468412,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1191.600038547553,
					["left"] = 412.9999832966964,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 827.9999658895476,
					["left"] = 121.600011878583,
				},
			},
			["Turbocancer"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.37760069585,
					["left"] = 216.8000086468412,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 533.9999539070006,
					["height"] = 64.62743815040966,
					["left"] = 737.4443625697217,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 422.8004128213233,
					["left"] = 975.6445980671296,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 458.9999900838503,
					["height"] = 149.9999976748339,
					["left"] = 612.6666817574509,
					["width"] = 140.0000106684094,
				},
				["XPerl_Raid_TitlePets"] = {
					["top"] = 548.0001714745666,
					["left"] = 526.0000071541384,
				},
				["XPerl_OptionsAnchor"] = {
					["top"] = 870.0001125653962,
					["height"] = 540.0001737035882,
					["left"] = 707.7778249041844,
					["width"] = 717.777759389209,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 693.3333426803894,
					["left"] = 411.7000716683085,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 422.8004128213233,
					["left"] = 716.4445108270249,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 422.8004128213233,
					["left"] = 522.0444594026534,
				},
				["XPerl_Player"] = {
					["top"] = 1173.644515755014,
					["left"] = 24.03331598510612,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.644316773334,
					["left"] = 416.0332901695005,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 422.8004128213233,
					["left"] = 1040.444633882863,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1590.365651275591,
					["left"] = 282.6825925415052,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.366915135648,
					["left"] = 99.87780162710145,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 422.8004128213233,
					["left"] = 781.2444345971031,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 422.8004128213233,
					["left"] = 846.0444704128362,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 422.8004128213233,
					["left"] = 910.8445622513966,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.7332261800782,
					["left"] = 13.06666972452098,
				},
				["XPerl_AggroAnchor"] = {
					["top"] = 1006.000215966902,
					["left"] = 1055.11150641975,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 422.8004128213233,
					["left"] = 1105.244557652941,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 446.0000332361984,
					["height"] = 123.9999964438636,
					["left"] = 517.6666038643851,
					["width"] = 330.0000439046077,
				},
				["XPerl_Target"] = {
					["top"] = 1173.644396266162,
					["left"] = 221.1332763063715,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 422.8004128213233,
					["left"] = 586.8444391955591,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 422.8004128213233,
					["left"] = 651.644475011292,
				},
			},
			["[character]"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.37760069585,
					["left"] = 216.8000086468412,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 533.9999539070006,
					["height"] = 64.62743815040966,
					["left"] = 737.4443625697217,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 422.8004128213233,
					["left"] = 975.6445980671296,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 458.9999900838503,
					["height"] = 149.9999976748339,
					["left"] = 612.6666817574509,
					["width"] = 140.0000106684094,
				},
				["XPerl_Raid_TitlePets"] = {
					["top"] = 585.7339547108136,
					["left"] = 619.4222175347693,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 422.8004128213233,
					["left"] = 781.2444345971031,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 693.3333426803894,
					["left"] = 411.7000716683085,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 422.8004128213233,
					["left"] = 716.4445108270249,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 422.8004128213233,
					["left"] = 522.0444594026534,
				},
				["XPerl_Player"] = {
					["top"] = 1173.644515755014,
					["left"] = 24.03331598510612,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.644316773334,
					["left"] = 416.0332901695005,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 422.8004128213233,
					["left"] = 1040.444633882863,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1590.365651275591,
					["left"] = 282.6825925415052,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.366915135648,
					["left"] = 99.87780162710145,
				},
				["XPerl_OptionsAnchor"] = {
					["top"] = 870.0001125653962,
					["height"] = 540.0001737035882,
					["left"] = 707.7778249041844,
					["width"] = 717.777759389209,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 422.8004128213233,
					["left"] = 846.0444704128362,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 422.8004128213233,
					["left"] = 910.8445622513966,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.7332261800782,
					["left"] = 13.06666972452098,
				},
				["XPerl_AggroAnchor"] = {
					["top"] = 1006.000215966902,
					["left"] = 1055.11150641975,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 422.8004128213233,
					["left"] = 1105.244557652941,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 446.0000332361984,
					["height"] = 123.9999964438636,
					["left"] = 517.6666038643851,
					["width"] = 330.0000439046077,
				},
				["XPerl_Target"] = {
					["top"] = 1173.644396266162,
					["left"] = 221.1332763063715,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 422.8004128213233,
					["left"] = 586.8444391955591,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 422.8004128213233,
					["left"] = 651.644475011292,
				},
			},
			["Alliancescum"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 662.0000326891004,
					["height"] = 124.0000051974302,
					["left"] = 901.6667351678849,
					["width"] = 330.0000088903411,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 424.0000093006645,
					["height"] = 80.00000109419584,
					["left"] = 579.6666458541502,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 827.9999658895476,
					["left"] = 425.6000135636268,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 675.0000595652856,
					["height"] = 149.9999976748339,
					["left"] = 996.6666730038842,
					["width"] = 140.0000106684094,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 1039.999989510598,
					["left"] = 414.7000449598733,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 827.9999658895476,
					["left"] = 182.4000038121677,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 827.9999658895476,
					["left"] = 0,
				},
				["XPerl_Player"] = {
					["top"] = 1189.200009447236,
					["left"] = 20.70000012867092,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 827.9999658895476,
					["left"] = 486.400047514332,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 827.9999658895476,
					["left"] = 243.200023757166,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1137.70002984338,
					["left"] = 72.09999700091484,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1611.285806861378,
					["left"] = 233.4999963722936,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 827.9999658895476,
					["left"] = 304.0000296964575,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1191.600038547553,
					["left"] = 412.9999832966964,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 1079.999999352058,
					["left"] = 0,
				},
				["XPerl_Focus"] = {
					["top"] = 1039.999924678952,
					["left"] = 216.8000086468412,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 827.9999658895476,
					["left"] = 364.8000076243353,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 827.9999658895476,
					["left"] = 547.2000534536235,
				},
				["XPerl_Target"] = {
					["top"] = 1190.399927576605,
					["left"] = 216.8000086468412,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 827.9999658895476,
					["left"] = 60.8000059392915,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 827.9999658895476,
					["left"] = 121.600011878583,
				},
			},
			["Havesomeaids"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 662.0000326891004,
					["height"] = 124.0000051974302,
					["left"] = 901.6667351678849,
					["width"] = 330.0000088903411,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 424.0000093006645,
					["height"] = 80.00000109419584,
					["left"] = 579.6666458541502,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 423.1999676263482,
					["left"] = 975.4665575216486,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 675.0000595652856,
					["height"] = 149.9999976748339,
					["left"] = 996.6666730038842,
					["width"] = 140.0000106684094,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 1051.200072807004,
					["left"] = 414.7000449598733,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 423.1999676263482,
					["left"] = 716.2666383500264,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 423.1999676263482,
					["left"] = 521.8666429484822,
				},
				["XPerl_Player"] = {
					["top"] = 1173.900021854508,
					["left"] = 24.29999929472132,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 423.1999676263482,
					["left"] = 1040.266593337382,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 423.1999676263482,
					["left"] = 781.0666181429319,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.600054124433,
					["left"] = 100.1000030345428,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1578.285855554303,
					["left"] = 273.4999997396222,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 423.1999676263482,
					["left"] = 845.866653958665,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.400099270783,
					["left"] = 415.8000041207978,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.9998948385075,
					["left"] = 12.80000106609154,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.200008332989,
					["left"] = 216.8000086468412,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 423.1999676263482,
					["left"] = 910.6665777287432,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 423.1999676263482,
					["left"] = 1105.066629153115,
				},
				["XPerl_Target"] = {
					["top"] = 1173.599914141205,
					["left"] = 220.8000245175758,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 423.1999676263482,
					["left"] = 586.6666227413878,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 423.1999676263482,
					["left"] = 651.4666025342933,
				},
			},
			["Donormourne"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 662.0000326891004,
					["height"] = 124.0000051974302,
					["left"] = 901.6667351678849,
					["width"] = 330.0000088903411,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 424.0000093006645,
					["height"] = 80.00000109419584,
					["left"] = 579.6666458541502,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 827.9999658895476,
					["left"] = 425.6000135636268,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 675.0000595652856,
					["height"] = 149.9999976748339,
					["left"] = 996.6666730038842,
					["width"] = 140.0000106684094,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 1039.999989510598,
					["left"] = 414.7000449598733,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 827.9999658895476,
					["left"] = 182.4000038121677,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 827.9999658895476,
					["left"] = 0,
				},
				["XPerl_Player"] = {
					["top"] = 1189.200009447236,
					["left"] = 20.70000012867092,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 827.9999658895476,
					["left"] = 486.400047514332,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 827.9999658895476,
					["left"] = 243.200023757166,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1137.70002984338,
					["left"] = 72.09999700091484,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1611.285806861378,
					["left"] = 233.4999963722936,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 827.9999658895476,
					["left"] = 304.0000296964575,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1191.600038547553,
					["left"] = 412.9999832966964,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 1079.999999352058,
					["left"] = 0,
				},
				["XPerl_Focus"] = {
					["top"] = 1039.999924678952,
					["left"] = 216.8000086468412,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 827.9999658895476,
					["left"] = 364.8000076243353,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 827.9999658895476,
					["left"] = 547.2000534536235,
				},
				["XPerl_Target"] = {
					["top"] = 1190.399927576605,
					["left"] = 216.8000086468412,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 827.9999658895476,
					["left"] = 60.8000059392915,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 827.9999658895476,
					["left"] = 121.600011878583,
				},
			},
			["Bubbleherth"] = {
				["XPerl_RosterTextAnchor"] = {
					["top"] = 498.0000006838724,
					["height"] = 250.0000077961453,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.37760069585,
					["left"] = 216.8000086468412,
				},
				["XPerl_MTList_Anchor"] = {
					["top"] = 533.9999539070006,
					["height"] = 64.62743815040966,
					["left"] = 737.4443625697217,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 422.8004128213233,
					["left"] = 975.6445980671296,
				},
				["XPerl_AdminFrameAnchor"] = {
					["top"] = 458.9999900838503,
					["height"] = 149.9999976748339,
					["left"] = 612.6666817574509,
					["width"] = 140.0000106684094,
				},
				["XPerl_Raid_TitlePets"] = {
					["top"] = 548.0001714745666,
					["left"] = 526.0000071541384,
				},
				["XPerl_OptionsAnchor"] = {
					["top"] = 870.0001125653962,
					["height"] = 540.0001737035882,
					["left"] = 707.7778249041844,
					["width"] = 717.777759389209,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 693.3333426803894,
					["left"] = 411.7000716683085,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 422.8004128213233,
					["left"] = 716.4445108270249,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 422.8004128213233,
					["left"] = 522.0444594026534,
				},
				["XPerl_Player"] = {
					["top"] = 1173.644515755014,
					["left"] = 24.03331598510612,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.644316773334,
					["left"] = 416.0332901695005,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 422.8004128213233,
					["left"] = 1040.444633882863,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1590.365651275591,
					["left"] = 282.6825925415052,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.366915135648,
					["left"] = 99.87780162710145,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 422.8004128213233,
					["left"] = 781.2444345971031,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 422.8004128213233,
					["left"] = 846.0444704128362,
				},
				["XPerl_CheckAnchor"] = {
					["top"] = 504.000045409127,
					["height"] = 240.0000032825875,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 422.8004128213233,
					["left"] = 910.8445622513966,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.7332261800782,
					["left"] = 13.06666972452098,
				},
				["XPerl_AggroAnchor"] = {
					["top"] = 1006.000215966902,
					["left"] = 1055.11150641975,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 422.8004128213233,
					["left"] = 1105.244557652941,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["top"] = 446.0000332361984,
					["height"] = 123.9999964438636,
					["left"] = 517.6666038643851,
					["width"] = 330.0000439046077,
				},
				["XPerl_Target"] = {
					["top"] = 1173.644396266162,
					["left"] = 221.1332763063715,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 422.8004128213233,
					["left"] = 586.8444391955591,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 422.8004128213233,
					["left"] = 651.644475011292,
				},
			},
		},
		["saved"] = {
			["Default"] = {
				["XPerl_RosterTextAnchor"] = {
					["height"] = 250.0000077961453,
					["top"] = 498.0000006838724,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.37760069585,
					["left"] = 216.8000086468412,
				},
				["XPerl_MTList_Anchor"] = {
					["height"] = 64.62743815040966,
					["top"] = 533.9999539070006,
					["left"] = 737.4443625697217,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 422.8004128213233,
					["left"] = 975.6445980671296,
				},
				["XPerl_AdminFrameAnchor"] = {
					["height"] = 149.9999976748339,
					["top"] = 458.9999900838503,
					["left"] = 612.6666817574509,
					["width"] = 140.0000106684094,
				},
				["XPerl_Raid_TitlePets"] = {
					["top"] = 548.0001714745666,
					["left"] = 526.0000071541384,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 422.8004128213233,
					["left"] = 781.2444345971031,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 693.3333426803894,
					["left"] = 411.7000716683085,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 422.8004128213233,
					["left"] = 716.4445108270249,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 422.8004128213233,
					["left"] = 522.0444594026534,
				},
				["XPerl_Player"] = {
					["top"] = 1173.644515755014,
					["left"] = 24.03331598510612,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 422.8004128213233,
					["left"] = 586.8444391955591,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 422.8004128213233,
					["left"] = 1040.444633882863,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1590.365651275591,
					["left"] = 282.6825925415052,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.366915135648,
					["left"] = 99.87780162710145,
				},
				["XPerl_OptionsAnchor"] = {
					["height"] = 540.0001737035882,
					["top"] = 870.0001125653962,
					["left"] = 707.7778249041844,
					["width"] = 717.777759389209,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 422.8004128213233,
					["left"] = 846.0444704128362,
				},
				["XPerl_CheckAnchor"] = {
					["height"] = 240.0000032825875,
					["top"] = 504.000045409127,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["height"] = 123.9999964438636,
					["top"] = 446.0000332361984,
					["left"] = 517.6666038643851,
					["width"] = 330.0000439046077,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.7332261800782,
					["left"] = 13.06666972452098,
				},
				["XPerl_AggroAnchor"] = {
					["top"] = 1006.000215966902,
					["left"] = 1055.11150641975,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 422.8004128213233,
					["left"] = 1105.244557652941,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 422.8004128213233,
					["left"] = 910.8445622513966,
				},
				["XPerl_Target"] = {
					["top"] = 1173.644396266162,
					["left"] = 221.1332763063715,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.644316773334,
					["left"] = 416.0332901695005,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 422.8004128213233,
					["left"] = 651.644475011292,
				},
			},
			["Leveling"] = {
				["XPerl_RosterTextAnchor"] = {
					["height"] = 250.0000077961453,
					["top"] = 498.0000006838724,
					["left"] = 507.6667394078937,
					["width"] = 350.0000179174567,
				},
				["XPerl_Focus"] = {
					["top"] = 1051.37760069585,
					["left"] = 216.8000086468412,
				},
				["XPerl_MTList_Anchor"] = {
					["height"] = 64.62743815040966,
					["top"] = 533.9999539070006,
					["left"] = 737.4443625697217,
					["width"] = 205.9999949393443,
				},
				["XPerl_Raid_Title8"] = {
					["top"] = 422.8004128213233,
					["left"] = 975.6445980671296,
				},
				["XPerl_AdminFrameAnchor"] = {
					["height"] = 149.9999976748339,
					["top"] = 458.9999900838503,
					["left"] = 612.6666817574509,
					["width"] = 140.0000106684094,
				},
				["XPerl_Raid_TitlePets"] = {
					["top"] = 548.0001714745666,
					["left"] = 526.0000071541384,
				},
				["XPerl_Player"] = {
					["top"] = 1173.644515755014,
					["left"] = 24.03331598510612,
				},
				["XPerl_FocusTarget"] = {
					["top"] = 693.3333426803894,
					["left"] = 411.7000716683085,
				},
				["XPerl_Raid_Title4"] = {
					["top"] = 422.8004128213233,
					["left"] = 716.4445108270249,
				},
				["XPerl_Raid_Title1"] = {
					["top"] = 422.8004128213233,
					["left"] = 522.0444594026534,
				},
				["XPerl_OptionsAnchor"] = {
					["height"] = 540.0001737035882,
					["top"] = 870.0001125653962,
					["left"] = 707.7778249041844,
					["width"] = 717.777759389209,
				},
				["XPerl_Raid_Title2"] = {
					["top"] = 422.8004128213233,
					["left"] = 586.8444391955591,
				},
				["XPerl_Raid_Title9"] = {
					["top"] = 422.8004128213233,
					["left"] = 1040.444633882863,
				},
				["XPerl_PetTarget"] = {
					["top"] = 1590.365651275591,
					["left"] = 282.6825925415052,
				},
				["XPerl_Player_Pet"] = {
					["top"] = 1114.366915135648,
					["left"] = 99.87780162710145,
				},
				["XPerl_Raid_Title5"] = {
					["top"] = 422.8004128213233,
					["left"] = 781.2444345971031,
				},
				["XPerl_Raid_Title6"] = {
					["top"] = 422.8004128213233,
					["left"] = 846.0444704128362,
				},
				["XPerl_CheckAnchor"] = {
					["height"] = 240.0000032825875,
					["top"] = 504.000045409127,
					["left"] = 432.6667405704768,
					["width"] = 500.0000155922906,
				},
				["XPerl_Assists_FrameAnchor"] = {
					["height"] = 123.9999964438636,
					["top"] = 446.0000332361984,
					["left"] = 517.6666038643851,
					["width"] = 330.0000439046077,
				},
				["XPerl_Party_Anchor"] = {
					["top"] = 975.7332261800782,
					["left"] = 13.06666972452098,
				},
				["XPerl_AggroAnchor"] = {
					["top"] = 1006.000215966902,
					["left"] = 1055.11150641975,
				},
				["XPerl_Raid_Title10"] = {
					["top"] = 422.8004128213233,
					["left"] = 1105.244557652941,
				},
				["XPerl_Raid_Title7"] = {
					["top"] = 422.8004128213233,
					["left"] = 910.8445622513966,
				},
				["XPerl_Target"] = {
					["top"] = 1173.644396266162,
					["left"] = 221.1332763063715,
				},
				["XPerl_TargetTarget"] = {
					["top"] = 1173.644316773334,
					["left"] = 416.0332901695005,
				},
				["XPerl_Raid_Title3"] = {
					["top"] = 422.8004128213233,
					["left"] = 651.644475011292,
				},
			},
		},
	},
	["ConfigVersion"] = "3.1.0",
}
XPerlConfigSavePerCharacter = nil
