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

function Setup_DABDruid125(profileName)

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
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Potions",
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
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePageBar"] = 10,
				["frameStrata"] = "LOW",
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["changePage"] = 1,
				["width"] = 48,
				["changePagePage"] = 4,
				["fontsize"] = 11,
				["b2width"] = 1,
				["delay"] = 0.5,
				["bordalpha"] = 0,
			},
			[2] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Skills",
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["hide"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePageBar"] = 10,
				["delay"] = 0.5,
				["mbgalpha"] = 1,
			},
			[3] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Portals",
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["hide"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePageBar"] = 10,
				["delay"] = 0.5,
				["mbgalpha"] = 1,
			},
			[4] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 0,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Consume",
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["hide"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePageBar"] = 10,
				["delay"] = 0.5,
				["mbgalpha"] = 1,
			},
			[5] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageBar"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[6] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageBar"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[7] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageBar"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[8] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageBar"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[9] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageBar"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
			[10] = {
				["mcolor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["color"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
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
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["b2width"] = 1,
				["alpha"] = 1,
				["changePagePage"] = 1,
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageBar"] = 1,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["delay"] = 0.5,
				["changePageType"] = 1,
			},
		},
		["ButtonLockOverride"] = 3,
		["UpdateSpeed"] = 10,
		["Floaters"] = {
		},
		["MainMenuBar"] = {
			["xpcolor"] = {
				["r"] = 0.58,
				["g"] = 0,
				["b"] = 0.55,
			},
			["xpbcolor"] = {
				["r"] = 1,
				["g"] = 1,
				["b"] = 1,
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
				["scale"] = 1.1,
				["layout"] = 1,
				["frameStrata"] = "HIGH",
				["alpha"] = 1,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 1,
					["x"] = 62,
					["to"] = "TOPRIGHT",
					["frame"] = "Minimap",
					["point"] = "TOPLEFT",
				},
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 5,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 5,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 0.8431372549019608,
						["g"] = 0.9372549019607843,
						["b"] = 1,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 4,
			},
			[14] = {
				["scale"] = 1,
				["layout"] = 1,
				["frameStrata"] = "HIGH",
				["alpha"] = 1,
				["Anchor"] = {
					["y"] = 144,
					["x"] = 380,
					["to"] = "BOTTOMLEFT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
				},
				["vspacing"] = 0,
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["b"] = 0,
						["g"] = 0.03137254901960784,
						["r"] = 1,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 5,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["tileSize"] = 1,
					["bottompadding"] = 5,
					["rightpadding"] = 5,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["hspacing"] = -3,
			},
			[11] = {
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 5,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["alpha"] = 1,
				["Anchor"] = {
					["y"] = 146,
					["x"] = -382,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
				},
				["vspacing"] = 0,
				["Background"] = {
					["leftpadding"] = 5,
					["color"] = {
						["b"] = 0,
						["g"] = 0.0392156862745098,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 5,
					["bottompadding"] = 5,
					["rightpadding"] = 5,
					["balpha"] = 1,
					["hide"] = 1,
				},
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
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-1",
			},
			[7] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-2",
			},
			[8] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "ALT-3",
			},
			[9] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "ALT-4",
			},
			[10] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "ALT-5",
			},
			[11] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "Z",
			},
			[12] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "X",
			},
			[13] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "C",
			},
			[14] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "G",
			},
			[15] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-G",
			},
			[16] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "`",
			},
			[17] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "ALT-`",
			},
			[18] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-R",
			},
			[19] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "R",
			},
			[20] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "T",
			},
			[21] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-1",
			},
			[22] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "SHIFT-2",
			},
			[23] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "SHIFT-3",
			},
			[24] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "SHIFT-4",
			},
			[25] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "ALT-C",
			},
			[26] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "6",
			},
			[27] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "7",
			},
			[28] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-Z",
			},
			[29] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-X",
			},
			[30] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[31] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[32] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
			},
			[33] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
			},
			[34] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
			},
			[35] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
			},
			[36] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 7,
				["down"] = 1,
			},
			[37] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 8,
				["down"] = 1,
			},
			[38] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[39] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[40] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
			},
			[41] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
			},
			[42] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
			},
			[43] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
			},
			[44] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 7,
				["down"] = 1,
			},
			[45] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 8,
				["down"] = 1,
			},
			[46] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 9,
				["down"] = 1,
			},
			[47] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 10,
				["down"] = 1,
			},
			[48] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 11,
				["down"] = 1,
			},
			[49] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 12,
				["down"] = 1,
			},
			[50] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 13,
				["down"] = 1,
			},
			[51] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 14,
				["down"] = 1,
			},
			[52] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 15,
				["down"] = 1,
			},
			[53] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 16,
				["down"] = 1,
			},
			[54] = {
				["suboption"] = 120,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-`",
			},
			[55] = {
				["suboption"] = 119,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-1",
			},
			[56] = {
				["suboption"] = 118,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-2",
			},
			[57] = {
				["suboption"] = 117,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-3",
			},
			[58] = {
				["suboption"] = 116,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-4",
			},
			[59] = {
				["suboption"] = 115,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-5",
			},
			[60] = {
				["suboption"] = 114,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-6",
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
				["action"] = 16,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 41,
				["Bar"] = 2,
			},
			[7] = {
				["action"] = 17,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[8] = {
				["action"] = 18,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[9] = {
				["action"] = 44,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 5,
			},
			[10] = {
				["action"] = 31,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 3,
			},
			[11] = {
				["action"] = 52,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 7,
			},
			[12] = {
				["action"] = 45,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 5,
			},
			[13] = {
				["action"] = 19,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 2,
			},
			[14] = {
				["action"] = 46,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 24,
				["Bar"] = 5,
			},
			[15] = {
				["action"] = 53,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[16] = {
				["action"] = 54,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 8,
			},
			[17] = {
				["action"] = 55,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 8,
			},
			[18] = {
				["action"] = 56,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[19] = {
				["action"] = 57,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[20] = {
				["action"] = 58,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[21] = {
				["action"] = 59,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[22] = {
				["action"] = 60,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[23] = {
				["action"] = 32,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 3,
			},
			[24] = {
				["action"] = 40,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 4,
			},
			[25] = {
				["action"] = 91,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[26] = {
				["action"] = 92,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[27] = {
				["action"] = 93,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[28] = {
				["action"] = 61,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[29] = {
				["action"] = 62,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[30] = {
				["action"] = 63,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[31] = {
				["action"] = 64,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[32] = {
				["action"] = 65,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[33] = {
				["action"] = 66,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[34] = {
				["action"] = 67,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[35] = {
				["action"] = 68,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[36] = {
				["action"] = 69,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[37] = {
				["action"] = 41,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 4,
			},
			[38] = {
				["action"] = 47,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 6,
			},
			[39] = {
				["action"] = 48,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 6,
			},
			[40] = {
				["action"] = 94,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[41] = {
				["action"] = 70,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 10,
			},
			[42] = {
				["action"] = 95,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 9,
			},
			[43] = {
				["action"] = 49,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 6,
			},
			[44] = {
				["action"] = 44,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[45] = {
				["action"] = 45,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[46] = {
				["action"] = 46,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[47] = {
				["action"] = 47,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[48] = {
				["action"] = 48,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[49] = {
				["action"] = 49,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[50] = {
				["action"] = 50,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[51] = {
				["action"] = 42,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 24,
				["Bar"] = 4,
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
				["action"] = 71,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[58] = {
				["action"] = 72,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[59] = {
				["action"] = 73,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[60] = {
				["action"] = 74,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 10,
			},
			[61] = {
				["action"] = 50,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 6,
			},
			[62] = {
				["action"] = 51,
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
				["action"] = 97,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[98] = {
				["action"] = 98,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[99] = {
				["action"] = 20,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[100] = {
				["action"] = 33,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 3,
			},
			[101] = {
				["action"] = 43,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 4,
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
				["action"] = 104,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
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
			[17] = 104,
			[18] = 103,
			[19] = 102,
			[20] = 98,
			[21] = 97,
			[22] = 96,
			[23] = 95,
			[24] = 94,
			[25] = 93,
			[26] = 92,
			[27] = 91,
			[28] = 90,
			[29] = 89,
			[30] = 88,
			[31] = 87,
			[32] = 86,
			[33] = 85,
			[34] = 84,
			[35] = 83,
			[36] = 82,
			[37] = 81,
			[38] = 80,
			[39] = 79,
			[40] = 78,
			[41] = 77,
			[42] = 76,
			[43] = 75,
			[44] = 74,
			[45] = 73,
			[46] = 72,
			[47] = 71,
			[48] = 70,
			[49] = 69,
			[50] = 68,
			[51] = 67,
			[52] = 66,
			[53] = 65,
			[54] = 64,
			[55] = 63,
			[56] = 56,
			[57] = 55,
			[58] = 54,
			[59] = 53,
			[60] = 52,
			[61] = 50,
			[62] = 49,
			[63] = 47,
			[64] = 46,
			[65] = 45,
			[66] = 44,
			[67] = 48,
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Stance Offensive",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = 1,
				},
				["checkedcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["disableMW"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 36,
				["rightClick"] = 1,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
					},
					[3] = {
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
				["hideEmpty"] = 1,
				["Conditions"] = {
					[1] = {
						["overrides"] = {
						},
						["condition"] = 22,
						["form"] = 3,
						["page"] = 2,
						["response"] = 1,
					},
					[2] = {
						["overrides"] = {
						},
						["condition"] = 22,
						["form"] = 1,
						["page"] = 3,
						["response"] = 1,
					},
					[3] = {
						["overrides"] = {
							[1] = 2,
							[2] = 1,
						},
						["condition"] = 0,
						["page"] = 1,
						["response"] = 1,
					},
				},
				["Keybinding"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["numButtons"] = 5,
				["cbgroup"] = 1,
				["Scripts"] = {
					[2] = "",
				},
				["Anchor"] = {
					["y"] = 3,
					["x"] = 12,
					["point"] = "LEFT",
					["frame"] = "Minimap",
					["to"] = "RIGHT",
				},
				["vspacing"] = 0,
				["expandHidden"] = 1,
				["skipPages"] = "",
				["numBars"] = 3,
				["middleClick"] = 1,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["frameStrata"] = "DIALOG",
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
				["unusablerecolor"] = 1,
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
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["page"] = 1,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["target"] = "player",
				["pages"] = {
					[1] = {
						[1] = 1,
						[2] = 2,
						[3] = 3,
						[4] = 4,
						[5] = 5,
						[13] = 1,
						[14] = 9,
						[15] = 17,
						[16] = 25,
						[17] = 33,
						[18] = 41,
					},
					[2] = {
						[1] = 6,
						[2] = 7,
						[3] = 8,
						[4] = 9,
						[5] = 10,
					},
					[3] = {
						[1] = 11,
						[2] = 12,
						[3] = 13,
						[4] = 14,
						[5] = 15,
					},
				},
			},
			[2] = {
				["buttonsLocked"] = 1,
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
				["Scripts"] = {
				},
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 16,
						[2] = 17,
						[3] = 18,
						[4] = 19,
						[5] = 20,
					},
					[2] = {
						[1] = 21,
						[2] = 22,
						[3] = 23,
						[4] = 24,
						[5] = 25,
					},
					[3] = {
						[1] = 26,
						[2] = 27,
						[3] = 28,
						[4] = 29,
						[5] = 30,
					},
				},
				["size"] = 36,
				["rightClick"] = 2,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
					},
					[3] = {
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
				["hideEmpty"] = 1,
				["Conditions"] = {
					[1] = {
						["overrides"] = {
						},
						["condition"] = 22,
						["form"] = 3,
						["page"] = 2,
						["response"] = 1,
					},
					[2] = {
						["overrides"] = {
						},
						["condition"] = 22,
						["form"] = 1,
						["page"] = 3,
						["response"] = 1,
					},
					[3] = {
						["overrides"] = {
							[1] = 2,
							[2] = 1,
						},
						["condition"] = 0,
						["page"] = 1,
						["response"] = 1,
					},
				},
				["Label"] = {
					["bgcolor"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["bgalpha"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["right"] = 1,
					["edgeSize"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["bottom"] = 1,
					["y"] = 10,
					["text"] = "Stance Hybrid",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = true,
				},
				["cbgroup"] = 2,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 6,
					["x"] = 13,
					["point"] = "BOTTOMLEFT",
					["frame"] = "Minimap",
					["to"] = "BOTTOMRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 5,
				["middleClick"] = 2,
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
				["unusablerecolor"] = 1,
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
				["numBars"] = 3,
				["page"] = 1,
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
			},
			[3] = {
				["buttonsLocked"] = 1,
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 31,
						[2] = 32,
						[3] = 33,
					},
					[2] = {
						[1] = 34,
						[2] = 35,
						[3] = 36,
					},
					[3] = {
						[1] = 37,
						[2] = 38,
						[3] = 39,
					},
				},
				["size"] = 36,
				["rightClick"] = 3,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["numBars"] = 3,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
					[1] = {
						["overrides"] = {
						},
						["condition"] = 22,
						["form"] = 3,
						["page"] = 2,
						["response"] = 1,
					},
					[2] = {
						["overrides"] = {
						},
						["condition"] = 22,
						["form"] = 1,
						["page"] = 3,
						["response"] = 1,
					},
					[3] = {
						["overrides"] = {
							[1] = 2,
							[2] = 1,
						},
						["condition"] = 0,
						["page"] = 1,
						["response"] = 1,
					},
				},
				["Label"] = {
					["bgcolor"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Stance Specials",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = 1,
				},
				["cbgroup"] = 3,
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["hide"] = 1,
					["bottompadding"] = 1,
					["tileSize"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = 6,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_1",
					["to"] = "RIGHT",
				},
				["vspacing"] = 0,
				["expandHidden"] = 1,
				["Scripts"] = {
				},
				["numButtons"] = 3,
				["middleClick"] = 3,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["highlightcolor"] = {
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
				["unusablerecolor"] = 1,
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
				["pageconditions"] = {
					[1] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
					},
					[2] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
					},
					[3] = {
						[1] = {
						},
						[2] = {
						},
						[3] = {
						},
					},
				},
				["page"] = 1,
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["alpha"] = 1,
			},
			[4] = {
				["buttonsLocked"] = 1,
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
				["Scripts"] = {
				},
				["pages"] = {
					[1] = {
						[1] = 40,
						[2] = 41,
						[3] = 42,
						[4] = 43,
					},
				},
				["size"] = 36,
				["rightClick"] = 4,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["numBars"] = 1,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
				},
				["cbgroup"] = 4,
				["Label"] = {
					["bgcolor"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Crowd Control",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = 1,
				},
				["Anchor"] = {
					["y"] = 42,
					["x"] = -39,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
				},
				["vspacing"] = 0,
				["numButtons"] = 4,
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["hide"] = 1,
					["bottompadding"] = 1,
					["tileSize"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
				},
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["expandHidden"] = 1,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["rangerecolor"] = 1,
				["alpha"] = 1,
				["middleClick"] = 4,
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
				["frameStrata"] = "LOW",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["page"] = 1,
			},
			[5] = {
				["buttonsLocked"] = 1,
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
				["Scripts"] = {
				},
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 36,
				["rightClick"] = 5,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["numBars"] = 1,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Label"] = {
					["bgcolor"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Curative",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = 1,
				},
				["cbgroup"] = 5,
				["Conditions"] = {
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -10,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_4",
					["to"] = "LEFT",
				},
				["vspacing"] = 0,
				["expandHidden"] = 1,
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 3,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["middleClick"] = 5,
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
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["unusablerecolor"] = 1,
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
				["frameStrata"] = "LOW",
				["pages"] = {
					[1] = {
						[1] = 44,
						[2] = 45,
						[3] = 46,
					},
				},
				["page"] = 1,
				["alpha"] = 1,
			},
			[6] = {
				["buttonsLocked"] = 1,
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
				["Scripts"] = {
				},
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 36,
				["rightClick"] = 6,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Buffs",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = 1,
				},
				["Anchor"] = {
					["y"] = -4,
					["x"] = 24,
					["point"] = "TOPRIGHT",
					["frame"] = "DAB_ActionBar_4",
					["to"] = "BOTTOMRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 0,
					["hide"] = 1,
				},
				["expandHidden"] = 1,
				["vspacing"] = 0,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 5,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["unusablerecolor"] = 1,
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
				["middleClick"] = 6,
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
				["numBars"] = 1,
				["frameStrata"] = "LOW",
				["pages"] = {
					[1] = {
						[1] = 47,
						[2] = 48,
						[3] = 49,
						[4] = 50,
						[5] = 51,
						[13] = 145,
					},
				},
				["page"] = 1,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
			},
			[7] = {
				["buttonsLocked"] = 1,
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
				["Scripts"] = {
				},
				["pages"] = {
					[1] = {
						[1] = 52,
						[2] = 53,
					},
				},
				["size"] = 36,
				["rightClick"] = 7,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["hide"] = true,
					["right"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Heal Specials",
					["alpha"] = 1,
					["width"] = 100,
					["y"] = 10,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["bordalpha"] = 1,
					["top"] = 1,
					["height"] = 20,
					["fontsize"] = 15,
					["justifyH"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				},
				["Anchor"] = {
					["y"] = -1,
					["x"] = 5,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_2",
					["to"] = "RIGHT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["tileSize"] = 1,
					["bottompadding"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["expandHidden"] = 1,
				["vspacing"] = 0,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 2,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["numBars"] = 1,
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
				["unusablerecolor"] = 1,
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
				["middleClick"] = 7,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["frameStrata"] = "LOW",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["page"] = 1,
			},
			[8] = {
				["buttonsLocked"] = 1,
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
				["Scripts"] = {
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 36,
				["rightClick"] = 8,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 16,
				},
				["hspacing"] = 11.5,
				["ButtonBorder"] = {
					["rightpadding"] = 13,
					["leftpadding"] = 12,
					["color"] = {
						["r"] = 0.8980392156862745,
						["g"] = 0.9333333333333334,
						["b"] = 1,
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Innervate Racial",
					["alpha"] = 1,
					["width"] = 100,
					["top"] = 1,
					["x"] = 0,
					["bordalpha"] = 1,
					["y"] = 10,
					["height"] = 20,
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = true,
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = -8,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_6",
					["to"] = "LEFT",
				},
				["vspacing"] = 0,
				["numButtons"] = 2,
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 0.9176470588235294,
						["g"] = 0.984313725490196,
						["b"] = 1,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["expandHidden"] = 1,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["numBars"] = 1,
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
				["middleClick"] = 8,
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
				["page"] = 1,
				["pages"] = {
					[1] = {
						[1] = 54,
						[2] = 55,
					},
				},
				["frameStrata"] = "LOW",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
			},
			[9] = {
				["middleClick"] = 9,
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["pages"] = {
					[1] = {
						[1] = 56,
						[2] = 57,
						[3] = 58,
						[4] = 91,
						[5] = 92,
						[6] = 93,
						[7] = 94,
						[8] = 95,
					},
				},
				["size"] = 36,
				["rightClick"] = 9,
				["collapse"] = 1,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["numBars"] = 1,
				["rows"] = 1,
				["cbgroup"] = 9,
				["Label"] = {
					["bgcolor"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["attachpoint"] = "BOTTOM",
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
					["hide"] = 1,
				},
				["Anchor"] = {
					["y"] = -3,
					["x"] = 0,
					["point"] = "TOPRIGHT",
					["frame"] = "DAB_ActionBar_6",
					["to"] = "BOTTOMRIGHT",
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBorder",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 0.5568627450980392,
						["g"] = 0.592156862745098,
						["b"] = 0.580392156862745,
					},
					["alpha"] = 1,
					["top"] = 1,
					["toppadding"] = 1,
					["bottompadding"] = 1,
					["edgeSize"] = 1,
					["balpha"] = 0,
					["hide"] = 1,
				},
				["numButtons"] = 8,
				["vspacing"] = 0,
				["Scripts"] = {
					[2] = "",
				},
				["expandHidden"] = 1,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["Conditions"] = {
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
				["alpha"] = 1,
				["unusablerecolor"] = 1,
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
					},
				},
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["page"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["frameStrata"] = "LOW",
			},
			[10] = {
				["unusablerecolor"] = 1,
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 36,
				["rightClick"] = 10,
				["buttonbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Cooldown"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
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
				["numBars"] = 2,
				["rows"] = 4,
				["cbgroup"] = 10,
				["Anchor"] = {
					["y"] = 162,
					["x"] = 252,
					["point"] = "BOTTOM",
					["frame"] = "UIParent",
					["to"] = "BOTTOM",
				},
				["vspacing"] = 0,
				["numButtons"] = 16,
				["Conditions"] = {
				},
				["Background"] = {
					["leftpadding"] = 1,
					["color"] = {
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBorder",
					["tileSize"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBackground",
					["rightpadding"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 0.9764705882352941,
						["g"] = 1,
						["b"] = 0.9803921568627451,
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
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["Label"] = {
					["bgcolor"] = {
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["color"] = {
						["r"] = 1,
						["g"] = 0.3333333333333333,
						["b"] = 0.1058823529411765,
					},
					["right"] = 1,
					["left"] = 1,
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
					["fontsize"] = 15,
					["attachto"] = "TOP",
					["bgalpha"] = 0,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["justifyV"] = "CENTER",
					["edgeSize"] = 1,
					["attachpoint"] = "BOTTOM",
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
						["r"] = 0.3568627450980392,
						["g"] = 0.3607843137254902,
						["b"] = 0.3647058823529412,
					},
					["justifyH"] = "CENTER",
					["tileSize"] = 1,
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
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["middleClick"] = 10,
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
				["page"] = 1,
				["pages"] = {
					[1] = {
						[1] = 59,
						[2] = 60,
						[3] = 61,
						[4] = 62,
						[5] = 63,
						[6] = 64,
						[7] = 65,
						[8] = 66,
						[9] = 67,
						[10] = 68,
						[11] = 69,
						[12] = 70,
						[13] = 71,
						[14] = 72,
						[15] = 73,
						[16] = 74,
					},
					[2] = {
						[1] = 75,
						[2] = 76,
						[3] = 77,
						[4] = 78,
						[5] = 79,
						[6] = 80,
						[7] = 81,
						[8] = 82,
						[9] = 83,
						[10] = 84,
						[11] = 85,
						[12] = 86,
						[13] = 87,
						[14] = 88,
						[15] = 89,
						[16] = 90,
					},
				},
				["alpha"] = 1,
				["frameStrata"] = "LOW",
			},
		},
	}
    end
end
