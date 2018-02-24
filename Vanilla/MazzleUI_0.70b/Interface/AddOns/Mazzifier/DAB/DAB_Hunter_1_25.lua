-- Copyright © 2006 Mazin Assanie
-- All Rights Reserved.
-- 
-- Permission to use, copy, modify, and distribute this software in any way
-- is not granted without expressed written agreement.  In the case that it
-- is granted, the above copyright notice and this paragraph must appear in
-- all copies, modifications, and distributions.
--
-- To contact the author of this work, use mazzlefizz@gmail.com 
-- For more information on copyright, visit http://copyright.gov/ or http://whatiscopyright.org/
--

function Setup_DABHunter125(profileName)

    if DAB_Settings then
        DAB_Settings[profileName] = {
		["defaultFont"] = "Interface\\AddOns\\DiscordActionBars\\CustomFonts\\",
		["EventMacros"] = {
		},
		["FrameLocs"] = {
		},
		["INITIALIZED3.1i"] = 1,
		["INITIALIZED3.1g"] = 1,
		["INITIALIZED3.1"] = 1,
		["INITIALIZED3.0H"] = 1,
		["optionsScale"] = 100,
		["ControlBox"] = {
			[1] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 1",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["mbordalpha"] = 1,
				["height"] = 13,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["justifyH"] = "CENTER",
				["changePageType"] = 3,
				["Anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "BOTTOM",
					["frame"] = "DAB_ControlBox_4",
					["to"] = "TOP",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = 1,
				["changePageBar"] = 10,
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["frameStrata"] = "LOW",
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePagePage"] = 4,
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["changePage"] = 1,
				["width"] = 48,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 11,
				["b2width"] = 1,
				["delay"] = 0.5,
				["bordalpha"] = 0,
			},
			[2] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 2",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 0,
				["height"] = 13,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 11,
				["changePagePage"] = 3,
				["Anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "BOTTOM",
					["frame"] = "DAB_ControlBox_3",
					["to"] = "TOP",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["justifyH"] = "CENTER",
				["alpha"] = 1,
				["width"] = 48,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["changePage"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["hide"] = 1,
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 10,
				["delay"] = 0.5,
				["mbgalpha"] = 1,
			},
			[3] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 3",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 0,
				["height"] = 13,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 11,
				["changePagePage"] = 2,
				["Anchor"] = {
					["y"] = 3,
					["x"] = 26,
					["point"] = "BOTTOM",
					["frame"] = "DAB_ActionBar_10",
					["to"] = "TOP",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["justifyH"] = "CENTER",
				["alpha"] = 1,
				["width"] = 48,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["changePage"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["hide"] = 1,
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 10,
				["delay"] = 0.5,
				["mbgalpha"] = 1,
			},
			[4] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 4",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 0,
				["height"] = 13,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 11,
				["changePagePage"] = 1,
				["Anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "RIGHT",
					["frame"] = "DAB_ControlBox_3",
					["to"] = "LEFT",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["justifyH"] = "CENTER",
				["alpha"] = 1,
				["width"] = 63,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["changePage"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["hide"] = 1,
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 10,
				["delay"] = 0.5,
				["mbgalpha"] = 1,
			},
			[5] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["onclick"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 5",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 25,
				["malpha"] = 1,
				["group"] = 5,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 14,
				["Anchor"] = {
					["y"] = -200,
					["x"] = 100,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = true,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 1,
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[6] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["onclick"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 6",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 25,
				["malpha"] = 1,
				["group"] = 6,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 14,
				["Anchor"] = {
					["y"] = -240,
					["x"] = 100,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = true,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 1,
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[7] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["onclick"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 7",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 25,
				["malpha"] = 1,
				["group"] = 7,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 14,
				["Anchor"] = {
					["y"] = -280,
					["x"] = 100,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = true,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 1,
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[8] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["onclick"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 8",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 25,
				["malpha"] = 1,
				["group"] = 8,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 14,
				["Anchor"] = {
					["y"] = -320,
					["x"] = 100,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = true,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 1,
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[9] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["onclick"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 9",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 25,
				["malpha"] = 1,
				["group"] = 9,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 14,
				["Anchor"] = {
					["y"] = -360,
					["x"] = 100,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = true,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 1,
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[10] = {
				["mcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["color"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["onclick"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Control Box 10",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 25,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 14,
				["Anchor"] = {
					["y"] = -400,
					["x"] = 100,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
				},
				["b4width"] = 1,
				["mbgalpha"] = 1,
				["hide"] = true,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["changePageBar"] = 1,
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 1,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["mbgcolor"] = {
					["b"] = 0,
					["g"] = 1,
					["r"] = 1,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
		},
		["ButtonLockOverride"] = 3,
		["UpdateSpeed"] = 10,
		["Floaters"] = {
			[43] = {
				["middleClick"] = 43,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["cbgroup"] = 1,
				["Scripts"] = {
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -8,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_4",
					["to"] = "RIGHT",
				},
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["expandHidden"] = 1,
				["size"] = 52,
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["alpha"] = 1,
				["Macro"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["frameStrata"] = "LOW",
				["rightClick"] = 43,
				["rangecolor"] = {
					["r"] = 1,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["unusablerecolor"] = 1,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["buttonLocked"] = 1,
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
			},
			[44] = {
				["middleClick"] = 44,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["Keybinding"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["cbgroup"] = 1,
				["Scripts"] = {
				},
				["Anchor"] = {
					["y"] = 48,
					["x"] = -38,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
				},
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["expandHidden"] = 1,
				["size"] = 52,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["alpha"] = 1,
				["Macro"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["frameStrata"] = "LOW",
				["rightClick"] = 44,
				["rangecolor"] = {
					["r"] = 1,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["unusablerecolor"] = 1,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["buttonLocked"] = 1,
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
			},
			[46] = {
				["middleClick"] = 46,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["cbgroup"] = 1,
				["Scripts"] = {
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -7,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionButton_43",
					["to"] = "RIGHT",
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 52,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["alpha"] = 1,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Macro"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["frameStrata"] = "LOW",
				["rightClick"] = 46,
				["rangecolor"] = {
					["r"] = 1,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["unusablerecolor"] = 1,
				["buttonLocked"] = 1,
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
			},
			[39] = {
				["middleClick"] = 39,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["Keybinding"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["cbgroup"] = 1,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -7,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_1",
					["to"] = "RIGHT",
				},
				["Scripts"] = {
				},
				["expandHidden"] = 1,
				["size"] = 52,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["frameStrata"] = "LOW",
				["Macro"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["alpha"] = 1,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["rangecolor"] = {
					["r"] = 1,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["unusablerecolor"] = 1,
				["rightClick"] = 39,
				["buttonLocked"] = 1,
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
			},
			[7] = {
				["middleClick"] = 7,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["cbgroup"] = 16,
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["Anchor"] = {
					["y"] = 10,
					["x"] = -1,
					["point"] = "LEFT",
					["frame"] = "Minimap",
					["to"] = "RIGHT",
				},
				["Scripts"] = {
				},
				["expandHidden"] = 1,
				["size"] = 52,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["frameStrata"] = "LOW",
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["alpha"] = 1,
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["unusablerecolor"] = 1,
				["rightClick"] = 7,
				["buttonLocked"] = 1,
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
			},
		},
		["MainMenuBar"] = {
			["xpcolor"] = {
				["b"] = 0.55,
				["g"] = 0,
				["r"] = 0.58,
			},
			["xpbcolor"] = {
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["keyringscale"] = 1,
			["hideXPborder"] = 1,
			["xpscale"] = 0.9375,
			["xpalpha"] = 1,
			["hideEverything"] = 1,
			["latencyscale"] = 0.9375,
		},
		["SelfCast"] = 1,
		["DragLockOverride"] = 2,
		["OtherBar"] = {
			[12] = {
				["scale"] = 0.8,
				["layout"] = 4,
				["frameStrata"] = "HIGH",
				["alpha"] = 1,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 14,
					["x"] = -7,
					["to"] = "TOPLEFT",
					["frame"] = "ChatFrame6",
					["point"] = "TOPRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 5,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 5,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["hide"] = 1,
					["bottompadding"] = 5,
					["tileSize"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
			},
			[14] = {
				["scale"] = 1,
				["layout"] = 1,
				["frameStrata"] = "HIGH",
				["hide"] = 1,
				["alpha"] = 1,
				["Anchor"] = {
					["y"] = 144,
					["x"] = 380,
					["to"] = "BOTTOMLEFT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
				},
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["r"] = 1,
						["g"] = 0.03137254901960784,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 5,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["tileSize"] = 1,
					["bottompadding"] = 5,
					["rightpadding"] = 5,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["vspacing"] = 0,
				["hspacing"] = -3,
			},
			[11] = {
				["scale"] = 0.75,
				["layout"] = 1,
				["frameStrata"] = "HIGH",
				["alpha"] = 1,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 6,
					["x"] = -80,
					["to"] = "TOPLEFT",
					["frame"] = "Minimap",
					["point"] = "TOPRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 5,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 5,
					["bottompadding"] = 5,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
			},
			[13] = {
				["scale"] = 1,
				["layout"] = 1,
				["frameStrata"] = "HIGH",
				["hide"] = 1,
				["alpha"] = 1,
				["Anchor"] = {
					["y"] = 146,
					["x"] = -382,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["r"] = 1,
						["g"] = 0.0392156862745098,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 5,
					["bottompadding"] = 5,
					["rightpadding"] = 5,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["vspacing"] = 0,
				["hspacing"] = 1,
			},
		},
		["CDFormat"] = 1,
		["Keybindings"] = {
			[1] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "1",
			},
			[2] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "2",
			},
			[3] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "3",
			},
			[4] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "4",
			},
			[5] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "5",
			},
			[6] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
				["key1"] = "ALT-D",
			},
			[7] = {
				["suboption"] = 1,
				["option"] = 1,
				["suboption2"] = 7,
				["down"] = 1,
				["key1"] = "T",
			},
			[8] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-1",
			},
			[9] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "SHIFT-2",
			},
			[10] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "SHIFT-3",
			},
			[11] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "SHIFT-4",
			},
			[12] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "SHIFT-5",
			},
			[13] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
				["key1"] = "SHIFT-6",
			},
			[14] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "Z",
			},
			[15] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "X",
			},
			[16] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "C",
			},
			[17] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "V",
			},
			[18] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "SHIFT-V",
			},
			[19] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "ALT-T",
			},
			[20] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "F1",
			},
			[21] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "F2",
			},
			[22] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "F3",
			},
			[23] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "F4",
			},
			[24] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-X",
			},
			[25] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-C",
			},
			[26] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[27] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[28] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
			},
			[29] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
			},
			[30] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-`",
			},
			[31] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-B",
			},
			[32] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[33] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[34] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "ALT-E",
			},
			[35] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "SHIFT-D",
			},
			[36] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[37] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[38] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
			},
			[39] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
			},
			[40] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
			},
			[41] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
			},
			[42] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 7,
				["down"] = 1,
			},
			[43] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 8,
				["down"] = 1,
			},
			[44] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 9,
				["down"] = 1,
			},
			[45] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 10,
				["down"] = 1,
			},
			[46] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 11,
				["down"] = 1,
			},
			[47] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 12,
				["down"] = 1,
			},
			[48] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 13,
				["down"] = 1,
			},
			[49] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 14,
				["down"] = 1,
			},
			[50] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 15,
				["down"] = 1,
			},
			[51] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 16,
				["down"] = 1,
			},
			[52] = {
				["suboption"] = 7,
				["option"] = 3,
				["down"] = 1,
				["key1"] = "H",
			},
			[53] = {
				["suboption"] = 39,
				["option"] = 3,
				["down"] = 1,
				["key1"] = "R",
			},
			[54] = {
				["suboption"] = 43,
				["option"] = 3,
				["down"] = 1,
				["key1"] = "ALT-G",
			},
			[55] = {
				["suboption"] = 44,
				["option"] = 3,
				["down"] = 1,
				["key1"] = "F5",
			},
			[56] = {
				["suboption"] = 46,
				["option"] = 3,
				["down"] = 1,
				["key1"] = "ALT-R",
			},
			[57] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "G",
			},
			[58] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "ALT-A",
			},
			[59] = {
				["suboption"] = 120,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-`",
			},
			[60] = {
				["option"] = 0,
				["down"] = 1,
			},
			[61] = {
				["option"] = 0,
				["down"] = 1,
			},
			[62] = {
				["option"] = 0,
				["down"] = 1,
			},
			[63] = {
				["option"] = 0,
				["down"] = 1,
			},
			[64] = {
				["option"] = 0,
				["down"] = 1,
			},
			[65] = {
				["option"] = 0,
				["down"] = 1,
			},
			[66] = {
				["option"] = 0,
				["down"] = 1,
			},
			[67] = {
				["option"] = 0,
				["down"] = 1,
			},
			[68] = {
				["option"] = 0,
				["down"] = 1,
			},
			[69] = {
				["option"] = 0,
				["down"] = 1,
			},
			[70] = {
				["option"] = 0,
				["down"] = 1,
			},
			[71] = {
				["option"] = 0,
				["down"] = 1,
			},
			[72] = {
				["option"] = 0,
				["down"] = 1,
			},
			[73] = {
				["option"] = 0,
				["down"] = 1,
			},
			[74] = {
				["option"] = 0,
				["down"] = 1,
			},
			[75] = {
				["option"] = 0,
				["down"] = 1,
			},
			[76] = {
				["option"] = 0,
				["down"] = 1,
			},
			[77] = {
				["option"] = 0,
				["down"] = 1,
			},
			[78] = {
				["option"] = 0,
				["down"] = 1,
			},
			[79] = {
				["option"] = 0,
				["down"] = 1,
			},
			[80] = {
				["option"] = 0,
				["down"] = 1,
			},
			[81] = {
				["option"] = 0,
				["down"] = 1,
			},
			[82] = {
				["option"] = 0,
				["down"] = 1,
			},
			[83] = {
				["option"] = 0,
				["down"] = 1,
			},
			[84] = {
				["option"] = 0,
				["down"] = 1,
			},
			[85] = {
				["option"] = 0,
				["down"] = 1,
			},
			[86] = {
				["option"] = 0,
				["down"] = 1,
			},
			[87] = {
				["option"] = 0,
				["down"] = 1,
			},
			[88] = {
				["option"] = 0,
				["down"] = 1,
			},
			[89] = {
				["option"] = 0,
				["down"] = 1,
			},
			[90] = {
				["option"] = 0,
				["down"] = 1,
			},
			[91] = {
				["option"] = 0,
				["down"] = 1,
			},
			[92] = {
				["option"] = 0,
				["down"] = 1,
			},
			[93] = {
				["option"] = 0,
				["down"] = 1,
			},
			[94] = {
				["option"] = 0,
				["down"] = 1,
			},
			[95] = {
				["option"] = 0,
				["down"] = 1,
			},
			[96] = {
				["option"] = 0,
				["down"] = 1,
			},
			[97] = {
				["option"] = 0,
				["down"] = 1,
			},
			[98] = {
				["option"] = 0,
				["down"] = 1,
			},
			[99] = {
				["option"] = 0,
				["down"] = 1,
			},
			[100] = {
				["option"] = 0,
				["down"] = 1,
			},
			[101] = {
				["option"] = 0,
				["down"] = 1,
			},
			[102] = {
				["option"] = 0,
				["down"] = 1,
			},
			[103] = {
				["option"] = 0,
				["down"] = 1,
			},
			[104] = {
				["option"] = 0,
				["down"] = 1,
			},
			[105] = {
				["option"] = 0,
				["down"] = 1,
			},
			[106] = {
				["option"] = 0,
				["down"] = 1,
			},
			[107] = {
				["option"] = 0,
				["down"] = 1,
			},
			[108] = {
				["option"] = 0,
				["down"] = 1,
			},
			[109] = {
				["option"] = 0,
				["down"] = 1,
			},
			[110] = {
				["option"] = 0,
				["down"] = 1,
			},
			[111] = {
				["option"] = 0,
				["down"] = 1,
			},
			[112] = {
				["option"] = 0,
				["down"] = 1,
			},
			[113] = {
				["option"] = 0,
				["down"] = 1,
			},
			[114] = {
				["option"] = 0,
				["down"] = 1,
			},
			[115] = {
				["option"] = 0,
				["down"] = 1,
			},
			[116] = {
				["option"] = 0,
				["down"] = 1,
			},
			[117] = {
				["option"] = 0,
				["down"] = 1,
			},
			[118] = {
				["option"] = 0,
				["down"] = 1,
			},
			[119] = {
				["option"] = 0,
				["down"] = 1,
			},
			[120] = {
				["option"] = 0,
				["down"] = 1,
			},
		},
		["Buttons"] = {
			[1] = {
				["action"] = 1,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 1,
			},
			[2] = {
				["action"] = 2,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 1,
			},
			[3] = {
				["action"] = 3,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 1,
			},
			[4] = {
				["action"] = 4,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 1,
			},
			[5] = {
				["action"] = 5,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 1,
			},
			[6] = {
				["action"] = 15,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 41,
				["Bar"] = 2,
			},
			[7] = {
				["action"] = 76,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = "F",
			},
			[8] = {
				["action"] = 16,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[9] = {
				["action"] = 28,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 5,
			},
			[10] = {
				["action"] = 21,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 3,
			},
			[11] = {
				["action"] = 38,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 8,
			},
			[12] = {
				["action"] = 34,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 7,
			},
			[13] = {
				["action"] = 17,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 2,
			},
			[14] = {
				["action"] = 18,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 2,
			},
			[15] = {
				["action"] = 19,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 2,
			},
			[16] = {
				["action"] = 35,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 7,
			},
			[17] = {
				["action"] = 39,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 8,
			},
			[18] = {
				["action"] = 22,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 3,
			},
			[19] = {
				["action"] = 40,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 9,
			},
			[20] = {
				["action"] = 29,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 41,
				["Bar"] = 5,
			},
			[21] = {
				["action"] = 60,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[22] = {
				["action"] = 61,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[23] = {
				["action"] = 23,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 3,
			},
			[24] = {
				["action"] = 25,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 4,
			},
			[25] = {
				["action"] = 26,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 4,
			},
			[26] = {
				["action"] = 41,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 9,
			},
			[27] = {
				["action"] = 6,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 1,
			},
			[28] = {
				["action"] = 62,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[29] = {
				["action"] = 63,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[30] = {
				["action"] = 64,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[31] = {
				["action"] = 65,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[32] = {
				["action"] = 66,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[33] = {
				["action"] = 67,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[34] = {
				["action"] = 68,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[35] = {
				["action"] = 69,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[36] = {
				["action"] = 70,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[37] = {
				["action"] = 27,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 4,
			},
			[38] = {
				["action"] = 24,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 4,
			},
			[39] = {
				["action"] = 77,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = "F",
			},
			[40] = {
				["action"] = 42,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 9,
			},
			[41] = {
				["action"] = 71,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[42] = {
				["action"] = 43,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 9,
			},
			[43] = {
				["action"] = 78,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = "F",
			},
			[44] = {
				["action"] = 79,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = "F",
			},
			[45] = {
				["action"] = 7,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 1,
			},
			[46] = {
				["action"] = 81,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = "F",
			},
			[47] = {
				["action"] = 80,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[48] = {
				["action"] = 36,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 7,
			},
			[49] = {
				["action"] = 30,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 5,
			},
			[50] = {
				["action"] = 31,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 5,
			},
			[51] = {
				["action"] = 20,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[52] = {
				["action"] = 52,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[53] = {
				["action"] = 53,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[54] = {
				["action"] = 54,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[55] = {
				["action"] = 55,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[56] = {
				["action"] = 56,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[57] = {
				["action"] = 72,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[58] = {
				["action"] = 73,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[59] = {
				["action"] = 74,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[60] = {
				["action"] = 75,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[61] = {
				["action"] = 32,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 6,
			},
			[62] = {
				["action"] = 33,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 6,
			},
			[63] = {
				["action"] = 63,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[64] = {
				["action"] = 64,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[65] = {
				["action"] = 65,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[66] = {
				["action"] = 66,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[67] = {
				["action"] = 67,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[68] = {
				["action"] = 68,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[69] = {
				["action"] = 69,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[70] = {
				["action"] = 70,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[71] = {
				["action"] = 71,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[72] = {
				["action"] = 72,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[73] = {
				["action"] = 73,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[74] = {
				["action"] = 74,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[75] = {
				["action"] = 75,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[76] = {
				["action"] = 76,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[77] = {
				["action"] = 77,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[78] = {
				["action"] = 78,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[79] = {
				["action"] = 79,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[80] = {
				["action"] = 80,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[81] = {
				["action"] = 81,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[82] = {
				["action"] = 82,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[83] = {
				["action"] = 83,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[84] = {
				["action"] = 84,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[85] = {
				["action"] = 85,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[86] = {
				["action"] = 86,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[87] = {
				["action"] = 87,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[88] = {
				["action"] = 88,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[89] = {
				["action"] = 89,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[90] = {
				["action"] = 90,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[91] = {
				["action"] = 91,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[92] = {
				["action"] = 92,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[93] = {
				["action"] = 93,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[94] = {
				["action"] = 94,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[95] = {
				["action"] = 95,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[96] = {
				["action"] = 96,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[97] = {
				["action"] = 37,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[98] = {
				["action"] = 98,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[99] = {
				["action"] = 99,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[100] = {
				["action"] = 100,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[101] = {
				["action"] = 101,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[102] = {
				["action"] = 102,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[103] = {
				["action"] = 103,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[104] = {
				["action"] = 82,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[105] = {
				["action"] = 105,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[106] = {
				["action"] = 106,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[107] = {
				["action"] = 107,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[108] = {
				["action"] = 108,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[109] = {
				["action"] = 109,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[110] = {
				["action"] = 110,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[111] = {
				["action"] = 111,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[112] = {
				["action"] = 112,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[113] = {
				["action"] = 113,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[114] = {
				["action"] = 114,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[115] = {
				["action"] = 115,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[116] = {
				["action"] = 116,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[117] = {
				["action"] = 117,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[118] = {
				["action"] = 118,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[119] = {
				["action"] = 119,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[120] = {
				["action"] = 120,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
		},
		["INITIALIZED3.16"] = 1,
		["CustomEvents"] = {
		},
		["FreeButtons"] = {
			[1] = 120,
			[2] = 119,
			[3] = 118,
			[4] = 117,
			[5] = 116,
			[6] = 115,
			[7] = 114,
			[8] = 113,
			[9] = 112,
			[10] = 111,
			[11] = 110,
			[12] = 109,
			[13] = 108,
			[14] = 107,
			[15] = 106,
			[16] = 105,
			[17] = 103,
			[18] = 102,
			[19] = 101,
			[20] = 100,
			[21] = 99,
			[22] = 98,
			[23] = 96,
			[24] = 95,
			[25] = 94,
			[26] = 93,
			[27] = 92,
			[28] = 91,
			[29] = 90,
			[30] = 89,
			[31] = 88,
			[32] = 87,
			[33] = 86,
			[34] = 85,
			[35] = 84,
			[36] = 83,
			[37] = 82,
			[38] = 81,
			[39] = 80,
			[40] = 79,
			[41] = 78,
			[42] = 77,
			[43] = 76,
			[44] = 75,
			[45] = 74,
			[46] = 73,
			[47] = 72,
			[48] = 71,
			[49] = 70,
			[50] = 69,
			[51] = 68,
			[52] = 67,
			[53] = 66,
			[54] = 65,
			[55] = 64,
			[56] = 63,
			[57] = 56,
			[58] = 55,
			[59] = 54,
			[60] = 53,
			[61] = 52,
		},
		["KBGroups"] = {
		},
		["defaultTexture"] = "Interface\\AddOns\\DiscordActionBars\\CustomTextures\\",
		["Bar"] = {
			[1] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Attacks",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = 1,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["disableMW"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 33,
				["rightClick"] = 1,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
						[6] = {
						},
						[7] = {
						},
						[13] = {
						},
						[14] = {
						},
						[15] = {
						},
						[16] = {
						},
						[17] = {
						},
						[18] = {
						},
					},
					[2] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
						[6] = {
						},
						[7] = {
						},
					},
				},
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
					[1] = {
						["action"] = 118,
						["page"] = 2,
						["response"] = 1,
						["overrides"] = {
						},
						["unit"] = "player",
						["condition"] = 2,
						["unit2"] = "player",
					},
					[2] = {
						["overrides"] = {
							[1] = 1,
						},
						["condition"] = 0,
						["page"] = 1,
						["response"] = 1,
					},
				},
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["numButtons"] = 7,
				["cbgroup"] = 1,
				["pages"] = {
					[1] = {
						[1] = 1,
						[2] = 2,
						[3] = 3,
						[4] = 4,
						[5] = 5,
						[6] = 6,
						[7] = 7,
						[13] = 1,
						[14] = 9,
						[15] = 17,
						[16] = 25,
						[17] = 33,
						[18] = 41,
					},
					[2] = {
						[1] = 8,
						[2] = 9,
						[3] = 10,
						[4] = 11,
						[5] = 12,
						[6] = 13,
						[7] = 14,
					},
				},
				["Anchor"] = {
					["y"] = 9,
					["x"] = 45,
					["point"] = "LEFT",
					["frame"] = "Minimap",
					["to"] = "RIGHT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["expandHidden"] = 1,
				["alpha"] = 1,
				["numBars"] = 2,
				["unusablerecolor"] = 1,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["frameStrata"] = "DIALOG",
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["middleClick"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["skipPages"] = "",
				["page"] = 1,
				["vspacing"] = 0,
				["Scripts"] = {
				},
				["trimEdges"] = 1,
			},
			[2] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["pages"] = {
					[1] = {
						[1] = 15,
						[2] = 16,
						[3] = 17,
						[4] = 18,
						[5] = 19,
						[6] = 20,
					},
				},
				["size"] = 29,
				["rightClick"] = 2,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
						[6] = {
						},
					},
				},
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 2,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["edgeSize"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["bottom"] = 1,
					["y"] = 10,
					["text"] = "Aspects",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = true,
				},
				["Anchor"] = {
					["y"] = -13,
					["x"] = 72,
					["point"] = "LEFT",
					["frame"] = "Minimap",
					["to"] = "TOPRIGHT",
				},
				["vspacing"] = 0,
				["expandHidden"] = 1,
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["Scripts"] = {
				},
				["numButtons"] = 6,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["numBars"] = 1,
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablerecolor"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["middleClick"] = 2,
				["alpha"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["page"] = 1,
				["frameStrata"] = "LOW",
			},
			[3] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 33,
				["rightClick"] = 3,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["numBars"] = 1,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 3,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Stings",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = true,
				},
				["Anchor"] = {
					["y"] = 28,
					["x"] = 7,
					["point"] = "LEFT",
					["frame"] = "Minimap",
					["to"] = "BOTTOMRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["hide"] = 1,
					["bottompadding"] = 1,
					["tileSize"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
				},
				["numButtons"] = 3,
				["Scripts"] = {
				},
				["vspacing"] = 0,
				["unusablerecolor"] = 1,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
					},
				},
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["alpha"] = 1,
				["middleClick"] = 3,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["pages"] = {
					[1] = {
						[1] = 21,
						[2] = 22,
						[3] = 23,
					},
				},
				["page"] = 1,
				["frameStrata"] = "LOW",
				["expandHidden"] = 1,
			},
			[4] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 33,
				["rightClick"] = 4,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["numBars"] = 1,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Special Shots",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = true,
				},
				["cbgroup"] = 4,
				["Conditions"] = {
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = 2,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_3",
					["to"] = "RIGHT",
				},
				["vspacing"] = 0,
				["numButtons"] = 4,
				["Scripts"] = {
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["hide"] = 1,
					["bottompadding"] = 1,
					["tileSize"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
				},
				["unusablerecolor"] = 1,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
					},
				},
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["alpha"] = 1,
				["middleClick"] = 4,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["pages"] = {
					[1] = {
						[1] = 25,
						[2] = 26,
						[3] = 27,
						[4] = 24,
					},
				},
				["page"] = 1,
				["frameStrata"] = "LOW",
				["expandHidden"] = 1,
			},
			[5] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 33,
				["rightClick"] = 5,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
					},
				},
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 5,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Traps",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = true,
				},
				["Anchor"] = {
					["y"] = 28,
					["x"] = -10,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "BOTTOMLEFT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["expandHidden"] = 1,
				["Scripts"] = {
				},
				["vspacing"] = 0,
				["numBars"] = 1,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["middleClick"] = 5,
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["frameStrata"] = "LOW",
				["unusablerecolor"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["alpha"] = 1,
				["numButtons"] = 4,
				["page"] = 1,
				["pages"] = {
					[1] = {
						[1] = 28,
						[2] = 29,
						[3] = 30,
						[4] = 31,
					},
				},
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
			},
			[6] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["pages"] = {
					[1] = {
						[1] = 32,
						[2] = 33,
						[13] = 145,
					},
				},
				["size"] = 33,
				["rightClick"] = 6,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[13] = {
						},
					},
				},
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 6,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Pet Specials",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = 1,
				},
				["Anchor"] = {
					["y"] = 9,
					["x"] = -9,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
				},
				["vspacing"] = 0,
				["numButtons"] = 2,
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 0,
					["hide"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["middleClick"] = 6,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["numBars"] = 1,
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["page"] = 1,
				["unusablerecolor"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["alpha"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["frameStrata"] = "LOW",
				["expandHidden"] = 1,
			},
			[7] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Scripts"] = {
				},
				["pages"] = {
					[1] = {
						[1] = 34,
						[2] = 35,
						[3] = 36,
						[4] = 37,
						[5] = 82,
					},
				},
				["size"] = 33,
				["rightClick"] = 7,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["numBars"] = 1,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 8,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["right"] = 1,
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["left"] = 1,
					["hide"] = true,
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Pet Basics",
					["alpha"] = 1,
					["width"] = 100,
					["y"] = 10,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["bordalpha"] = 1,
					["top"] = 1,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -2,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_6",
					["to"] = "LEFT",
				},
				["vspacing"] = 0,
				["numButtons"] = 5,
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["tileSize"] = 1,
					["bottompadding"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["middleClick"] = 7,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
					},
				},
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["alpha"] = 1,
				["unusablerecolor"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["frameStrata"] = "LOW",
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["page"] = 1,
				["expandHidden"] = 1,
			},
			[8] = {
				["buttonsLocked"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 33,
				["rightClick"] = 8,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
					},
				},
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 8,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Beast Mastery",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = true,
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -2,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_7",
					["to"] = "LEFT",
				},
				["vspacing"] = 0,
				["numButtons"] = 2,
				["Scripts"] = {
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["middleClick"] = 8,
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["numBars"] = 1,
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablerecolor"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["page"] = 1,
				["alpha"] = 1,
				["pages"] = {
					[1] = {
						[1] = 38,
						[2] = 39,
					},
				},
				["frameStrata"] = "LOW",
				["expandHidden"] = 1,
			},
			[9] = {
				["middleClick"] = 9,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["pages"] = {
					[1] = {
						[1] = 40,
						[2] = 41,
						[3] = 42,
						[4] = 43,
						[5] = 80,
					},
				},
				["size"] = 33,
				["rightClick"] = 9,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
					},
				},
				["rows"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 9,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 0,
					["x"] = -4,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_5",
					["to"] = "LEFT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBorder",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0.580392156862745,
						["g"] = 0.592156862745098,
						["r"] = 0.5568627450980392,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 0,
					["hide"] = 1,
				},
				["numButtons"] = 5,
				["Scripts"] = {
					[2] = "",
				},
				["page"] = 1,
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["bgalpha"] = 1,
					["bordcolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Miscellaneous",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["tileSize"] = 1,
					["fontsize"] = 15,
					["hide"] = 1,
				},
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["numBars"] = 1,
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["buttonsLocked"] = 1,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["alpha"] = 1,
				["expandHidden"] = 1,
				["unusablerecolor"] = 1,
				["frameStrata"] = "LOW",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
			},
			[10] = {
				["unusablerecolor"] = 1,
				["checked"] = "Interface\\Buttons\\CheckButtonHilight",
				["Keybinding"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["checkedcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["unusablecolor"] = {
					["b"] = 0.6,
					["g"] = 0.6,
					["r"] = 0.6,
				},
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 36,
				["rightClick"] = 10,
				["buttonbgcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 0,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["alpha"] = 1,
					["ecolor"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["bottompadding"] = 13,
					["toppadding"] = 12,
					["etexture"] = "Interface\\Buttons\\ButtonHilight-Square",
					["texture"] = "Interface\\Buttons\\UI-Quickslot2",
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
						[6] = {
						},
						[7] = {
						},
						[8] = {
						},
						[9] = {
						},
						[10] = {
						},
						[11] = {
						},
						[12] = {
						},
						[13] = {
						},
						[14] = {
						},
						[15] = {
						},
						[16] = {
						},
					},
					[2] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
						[4] = {
						},
						[5] = {
						},
						[6] = {
						},
						[7] = {
						},
						[8] = {
						},
						[9] = {
						},
						[10] = {
						},
						[11] = {
						},
						[12] = {
						},
						[13] = {
						},
						[14] = {
						},
						[15] = {
						},
						[16] = {
						},
					},
				},
				["rows"] = 4,
				["cbgroup"] = 10,
				["Anchor"] = {
					["y"] = 292.9999850168824,
					["x"] = 1024.999983794987,
					["point"] = "CENTER",
					["frame"] = "UIParent",
					["to"] = "BOTTOMLEFT",
				},
				["vspacing"] = 0,
				["numButtons"] = 16,
				["Conditions"] = {
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBorder",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBackground",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["b"] = 0.9803921568627451,
						["g"] = 1,
						["r"] = 0.9764705882352941,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["Scripts"] = {
					[2] = "MazzleUI:ContextMenuClick()",
					[10] = "",
					[11] = "",
				},
				["manacolor"] = {
					["b"] = 1,
					["g"] = 0.2,
					["r"] = 0.2,
				},
				["Label"] = {
					["bgcolor"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["color"] = {
						["b"] = 0.1058823529411765,
						["g"] = 0.3333333333333333,
						["r"] = 1,
					},
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
					["justifyH"] = "CENTER",
					["attachto"] = "TOP",
					["right"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyV"] = "CENTER",
					["edgeSize"] = 1,
					["bgalpha"] = 0,
					["bottom"] = 1,
					["top"] = 1,
					["text"] = "Context Menu",
					["alpha"] = 0.79,
					["width"] = 102,
					["y"] = 0,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["bordalpha"] = 0,
					["x"] = 0,
					["height"] = 20,
					["bordcolor"] = {
						["b"] = 0.3647058823529412,
						["g"] = 0.3607843137254902,
						["r"] = 0.3568627450980392,
					},
					["tileSize"] = 1,
					["fontsize"] = 15,
				},
				["Macro"] = {
					["color"] = {
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["frameStrata"] = "LOW",
				["numBars"] = 2,
				["rangecolor"] = {
					["b"] = 0.1,
					["g"] = 0.1,
					["r"] = 1,
				},
				["manarecolor"] = 1,
				["Count"] = {
					["color"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["middleClick"] = 10,
				["highlightcolor"] = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["pages"] = {
					[1] = {
						[1] = 44,
						[2] = 45,
						[3] = 46,
						[4] = 47,
						[5] = 48,
						[6] = 49,
						[7] = 50,
						[8] = 51,
						[9] = 52,
						[10] = 53,
						[11] = 54,
						[12] = 55,
						[13] = 56,
						[14] = 57,
						[15] = 58,
						[16] = 59,
					},
					[2] = {
						[1] = 60,
						[2] = 61,
						[3] = 62,
						[4] = 63,
						[5] = 64,
						[6] = 65,
						[7] = 66,
						[8] = 67,
						[9] = 68,
						[10] = 69,
						[11] = 70,
						[12] = 71,
						[13] = 72,
						[14] = 73,
						[15] = 74,
						[16] = 75,
					},
				},
				["page"] = 2,
				["alpha"] = 1,
			},
		},
	}
    end
end
