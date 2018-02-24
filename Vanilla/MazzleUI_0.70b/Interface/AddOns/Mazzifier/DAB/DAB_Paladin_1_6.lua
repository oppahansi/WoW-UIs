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

function Setup_DABPaladin16(profileName)

    if DAB_Settings then
        DAB_Settings[profileName] = {
		["defaultTexture"] = "Interface\\AddOns\\DiscordActionBars\\CustomTextures\\",
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
				["bgcolor"] = {
					["r"] = 0.2666666666666667,
					["g"] = 0.2705882352941176,
					["b"] = 0.2549019607843137,
				},
				["color"] = {
					["r"] = 0.7333333333333333,
					["g"] = 0.7333333333333333,
					["b"] = 0.7333333333333333,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "1",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 18,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["justifyH"] = "CENTER",
				["Anchor"] = {
					["y"] = 7,
					["x"] = 0,
					["point"] = "BOTTOM",
					["frame"] = "DAB_ControlBox_2",
					["to"] = "TOP",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["changePageBar"] = 7,
				["bordcolor"] = {
					["r"] = 0.5215686274509804,
					["g"] = 0.6,
					["b"] = 0.5882352941176471,
				},
				["mbgalpha"] = 1,
				["alpha"] = 1,
				["mbordalpha"] = 1,
				["mbgcolor"] = {
					["r"] = 0.1411764705882353,
					["g"] = 0.1450980392156863,
					["b"] = 0.1450980392156863,
				},
				["frameStrata"] = "LOW",
				["width"] = 14,
				["changePagePage"] = 1,
				["changePage"] = 1,
				["mcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 17.5,
				["delay"] = 0.5,
				["TextAnchor"] = {
					["y"] = 2,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
			},
			[2] = {
				["bgcolor"] = {
					["r"] = 0.2666666666666667,
					["g"] = 0.2705882352941176,
					["b"] = 0.2549019607843137,
				},
				["color"] = {
					["r"] = 0.7333333333333333,
					["g"] = 0.7333333333333333,
					["b"] = 0.7333333333333333,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Scripts"] = {
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "2",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 18,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["justifyH"] = "CENTER",
				["Anchor"] = {
					["y"] = 2,
					["x"] = -3,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_7",
					["to"] = "LEFT",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["changePageBar"] = 7,
				["bordcolor"] = {
					["r"] = 0.5215686274509804,
					["g"] = 0.6,
					["b"] = 0.5882352941176471,
				},
				["mbgalpha"] = 1,
				["alpha"] = 1,
				["mbordalpha"] = 1,
				["mbgcolor"] = {
					["r"] = 0.1411764705882353,
					["g"] = 0.1450980392156863,
					["b"] = 0.1450980392156863,
				},
				["frameStrata"] = "MEDIUM",
				["width"] = 14,
				["changePagePage"] = 2,
				["changePage"] = 1,
				["mcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 17.5,
				["delay"] = 0.5,
				["TextAnchor"] = {
					["y"] = 2,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
			},
			[3] = {
				["bgcolor"] = {
					["r"] = 0.2666666666666667,
					["g"] = 0.2705882352941176,
					["b"] = 0.2549019607843137,
				},
				["mbgcolor"] = {
					["r"] = 0.1411764705882353,
					["g"] = 0.1450980392156863,
					["b"] = 0.1450980392156863,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Scripts"] = {
					[2] = "",
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "3",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 18,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 17.5,
				["Anchor"] = {
					["y"] = -7,
					["x"] = 0,
					["point"] = "TOP",
					["frame"] = "DAB_ControlBox_2",
					["to"] = "BOTTOM",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 0.5215686274509804,
					["g"] = 0.6,
					["b"] = 0.5882352941176471,
				},
				["mbgalpha"] = 1,
				["alpha"] = 1,
				["TextAnchor"] = {
					["y"] = 3,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["color"] = {
					["r"] = 0.7333333333333333,
					["g"] = 0.7333333333333333,
					["b"] = 0.7333333333333333,
				},
				["frameStrata"] = "LOW",
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["changePagePage"] = 3,
				["changePage"] = 1,
				["width"] = 14,
				["mcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["changePageBar"] = 7,
				["justifyH"] = "CENTER",
				["delay"] = 0.5,
				["mbordalpha"] = 1,
			},
			[4] = {
				["bgcolor"] = {
					["r"] = 0.2666666666666667,
					["g"] = 0.2705882352941176,
					["b"] = 0.2549019607843137,
				},
				["mbgcolor"] = {
					["r"] = 0.1411764705882353,
					["g"] = 0.1450980392156863,
					["b"] = 0.1450980392156863,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Scripts"] = {
					[2] = "DAB_Bar_SetPage(1,2)\nDAB_Bar_SetPage(2,2)\nDAB_Bar_SetPage(3,2)\nDAB_Bar_SetPage(4,2)",
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Offensive",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["height"] = 13,
				["malpha"] = 1,
				["group"] = 10,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 13,
				["Anchor"] = {
					["y"] = -4,
					["x"] = 4,
					["point"] = "TOPLEFT",
					["frame"] = "DAB_OtherBar_Form",
					["to"] = "TOPRIGHT",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 0.5215686274509804,
					["g"] = 0.6,
					["b"] = 0.5882352941176471,
				},
				["mbordalpha"] = 1,
				["alpha"] = 1,
				["mbgalpha"] = 1,
				["color"] = {
					["r"] = 0.7333333333333333,
					["g"] = 0.7333333333333333,
					["b"] = 0.7333333333333333,
				},
				["frameStrata"] = "LOW",
				["width"] = 60,
				["mcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["changePage"] = 1,
				["changePagePage"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["changePageBar"] = 7,
				["justifyH"] = "CENTER",
				["delay"] = 0.5,
				["TextAnchor"] = {
					["y"] = 1,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
			},
			[5] = {
				["mcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["color"] = {
					["r"] = 0.7333333333333333,
					["g"] = 0.7333333333333333,
					["b"] = 0.7333333333333333,
				},
				["bgalpha"] = 1,
				["mbordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Scripts"] = {
					[2] = "DAB_Bar_SetPage(1,1)\nDAB_Bar_SetPage(2,1)\nDAB_Bar_SetPage(3,1)\nDAB_Bar_SetPage(4,1)",
				},
				["b3width"] = 1,
				["b1width"] = 1,
				["b3texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["b1texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["text"] = "Healing",
				["font"] = "Fonts\\FRIZQT__.TTF",
				["bordalpha"] = 1,
				["changePagePage"] = 1,
				["malpha"] = 1,
				["group"] = 5,
				["justifyV"] = "CENTER",
				["bgtexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["fontsize"] = 13,
				["Anchor"] = {
					["y"] = -3,
					["x"] = 0,
					["point"] = "TOP",
					["frame"] = "DAB_ControlBox_4",
					["to"] = "BOTTOM",
				},
				["b4width"] = 1,
				["changePageType"] = 3,
				["b2width"] = 1,
				["changePageBar"] = 7,
				["bordcolor"] = {
					["r"] = 0.5215686274509804,
					["g"] = 0.6,
					["b"] = 0.5882352941176471,
				},
				["height"] = 13,
				["alpha"] = 1,
				["mbgalpha"] = 1,
				["mbgcolor"] = {
					["r"] = 0.1411764705882353,
					["g"] = 0.1450980392156863,
					["b"] = 0.1450980392156863,
				},
				["frameStrata"] = "LOW",
				["width"] = 60,
				["mbordalpha"] = 1,
				["changePage"] = 1,
				["bgcolor"] = {
					["r"] = 0.2666666666666667,
					["g"] = 0.2705882352941176,
					["b"] = 0.2549019607843137,
				},
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["justifyH"] = "CENTER",
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["delay"] = 0.5,
				["TextAnchor"] = {
					["y"] = 1,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
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
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePagePage"] = 1,
				["changePageBar"] = 1,
				["frameStrata"] = "LOW",
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageType"] = 1,
				["hide"] = true,
				["delay"] = 0.5,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
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
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePagePage"] = 1,
				["changePageBar"] = 1,
				["frameStrata"] = "LOW",
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageType"] = 1,
				["hide"] = true,
				["delay"] = 0.5,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
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
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePagePage"] = 1,
				["changePageBar"] = 1,
				["frameStrata"] = "LOW",
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageType"] = 1,
				["hide"] = true,
				["delay"] = 0.5,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
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
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePagePage"] = 1,
				["changePageBar"] = 1,
				["frameStrata"] = "LOW",
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageType"] = 1,
				["hide"] = true,
				["delay"] = 0.5,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
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
				["b2width"] = 1,
				["b2texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["bordcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
				["changePagePage"] = 1,
				["changePageBar"] = 1,
				["frameStrata"] = "LOW",
				["TextAnchor"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["to"] = "CENTER",
				},
				["alpha"] = 1,
				["b4texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				["mbordalpha"] = 1,
				["bgcolor"] = {
					["r"] = 1,
					["g"] = 0,
					["b"] = 0,
				},
				["width"] = 120,
				["justifyH"] = "CENTER",
				["changePageType"] = 1,
				["hide"] = true,
				["delay"] = 0.5,
				["mbgcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0,
				},
			},
		},
		["ButtonLockOverride"] = 3,
		["UpdateSpeed"] = 10,
		["Floaters"] = {
			[12] = {
				["middleClick"] = 12,
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["Anchor"] = {
					["y"] = 5,
					["x"] = -7,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 56,
				["alpha"] = 1,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["highlight"] = "Interface\\Buttons\\ButtonHilight-Square",
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
				["rightClick"] = 12,
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
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
				["Scripts"] = {
					[10] = "",
				},
			},
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
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "3",
			},
			[4] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "4",
			},
			[5] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "5",
			},
			[6] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "6",
			},
			[7] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "7",
			},
			[8] = {
				["suboption"] = 2,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
				["key1"] = "8",
			},
			[9] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-1",
			},
			[10] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-2",
			},
			[11] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "ALT-3",
			},
			[12] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "ALT-4",
			},
			[13] = {
				["suboption"] = 3,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "ALT-5",
			},
			[14] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "ALT-6",
			},
			[15] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-7",
			},
			[16] = {
				["suboption"] = 4,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "ALT-8",
			},
			[17] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-1",
			},
			[18] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "SHIFT-2",
			},
			[19] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "SHIFT-3",
			},
			[20] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "SHIFT-4",
			},
			[21] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "SHIFT-5",
			},
			[22] = {
				["suboption"] = 5,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
				["key1"] = "SHIFT-6",
			},
			[23] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "Z",
			},
			[24] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "X",
			},
			[25] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "C",
			},
			[26] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "V",
			},
			[27] = {
				["suboption"] = 6,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "T",
			},
			[28] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "CTRL-1",
			},
			[29] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "CTRL-2",
			},
			[30] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
				["key1"] = "CTRL-3",
			},
			[31] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
				["key1"] = "CTRL-4",
			},
			[32] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
				["key1"] = "CTRL-5",
			},
			[33] = {
				["suboption"] = 7,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
				["key1"] = "CTRL-6",
			},
			[34] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[35] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[36] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
			},
			[37] = {
				["suboption"] = 8,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
			},
			[38] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "R",
			},
			[39] = {
				["suboption"] = 9,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
				["key1"] = "ALT-R",
			},
			[40] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 1,
				["down"] = 1,
			},
			[41] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 2,
				["down"] = 1,
			},
			[42] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 3,
				["down"] = 1,
			},
			[43] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 4,
				["down"] = 1,
			},
			[44] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 5,
				["down"] = 1,
			},
			[45] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 6,
				["down"] = 1,
			},
			[46] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 7,
				["down"] = 1,
			},
			[47] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 8,
				["down"] = 1,
			},
			[48] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 9,
				["down"] = 1,
			},
			[49] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 10,
				["down"] = 1,
			},
			[50] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 11,
				["down"] = 1,
			},
			[51] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 12,
				["down"] = 1,
			},
			[52] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 13,
				["down"] = 1,
			},
			[53] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 14,
				["down"] = 1,
			},
			[54] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 15,
				["down"] = 1,
			},
			[55] = {
				["suboption"] = 10,
				["option"] = 1,
				["suboption2"] = 16,
				["down"] = 1,
			},
			[56] = {
				["suboption"] = 12,
				["key1"] = "G",
				["down"] = 1,
				["option"] = 3,
			},
			[57] = {
				["suboption"] = 120,
				["option"] = 13,
				["suboption2"] = 1,
				["down"] = 1,
				["key1"] = "SHIFT-`",
			},
			[58] = {
				["option"] = 0,
				["down"] = 1,
			},
			[59] = {
				["option"] = 0,
				["down"] = 1,
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
		["DragLockOverride"] = 2,
		["OtherBar"] = {
			[12] = {
				["scale"] = 1,
				["layout"] = 1,
				["frameStrata"] = "HIGH",
				["alpha"] = 1,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 2,
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
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["alpha"] = 1,
					["top"] = 1,
					["hide"] = 1,
					["bottompadding"] = 5,
					["tileSize"] = 1,
					["rightpadding"] = 5,
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
				["hide"] = 1,
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
				["hide"] = 1,
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
					["toppadding"] = 5,
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
					["tileSize"] = 1,
					["bottompadding"] = 5,
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["hspacing"] = 1,
			},
		},
		["CDFormat"] = 1,
		["SelfCast"] = 1,
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
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[4] = {
				["action"] = 17,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 5,
			},
			[5] = {
				["action"] = 18,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 5,
			},
			[6] = {
				["action"] = 4,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 41,
				["Bar"] = 2,
			},
			[7] = {
				["action"] = 5,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[8] = {
				["action"] = 6,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 2,
			},
			[9] = {
				["action"] = 19,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 5,
			},
			[10] = {
				["action"] = 9,
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
				["Bar"] = 9,
			},
			[12] = {
				["action"] = 92,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = "F",
			},
			[13] = {
				["action"] = 20,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 5,
			},
			[14] = {
				["action"] = 21,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 24,
				["Bar"] = 5,
			},
			[15] = {
				["action"] = 46,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 8,
			},
			[16] = {
				["action"] = 47,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 8,
			},
			[17] = {
				["action"] = 48,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 8,
			},
			[18] = {
				["action"] = 49,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 8,
			},
			[19] = {
				["action"] = 19,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[20] = {
				["action"] = 22,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 41,
				["Bar"] = 5,
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
				["action"] = 10,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 3,
			},
			[24] = {
				["action"] = 14,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 16,
				["Bar"] = 4,
			},
			[25] = {
				["action"] = 25,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[26] = {
				["action"] = 28,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[27] = {
				["action"] = 50,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
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
				["action"] = 15,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 4,
			},
			[38] = {
				["action"] = 23,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 6,
			},
			[39] = {
				["action"] = 24,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 6,
			},
			[40] = {
				["action"] = 40,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
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
				["action"] = 42,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[43] = {
				["action"] = 25,
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
				["action"] = 29,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[47] = {
				["action"] = 30,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[48] = {
				["action"] = 48,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[49] = {
				["action"] = 31,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[50] = {
				["action"] = 32,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[51] = {
				["action"] = 16,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 24,
				["Bar"] = 4,
			},
			[52] = {
				["action"] = 33,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 7,
			},
			[53] = {
				["action"] = 53,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
			},
			[54] = {
				["action"] = 7,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 2,
			},
			[55] = {
				["action"] = 8,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 2,
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
				["action"] = 26,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar"] = 6,
			},
			[62] = {
				["action"] = 27,
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
				["action"] = 11,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 3,
			},
			[88] = {
				["action"] = 12,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 3,
			},
			[89] = {
				["action"] = 13,
				["Scripts"] = {
				},
				["Conditions"] = {
				},
				["Bar2"] = 1,
				["Bar"] = 3,
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
			[20] = 101,
			[21] = 100,
			[22] = 99,
			[23] = 98,
			[24] = 97,
			[25] = 96,
			[26] = 95,
			[27] = 94,
			[28] = 93,
			[29] = 92,
			[30] = 91,
			[31] = 84,
			[32] = 83,
			[33] = 82,
			[34] = 81,
			[35] = 80,
			[36] = 79,
			[37] = 78,
			[38] = 77,
			[39] = 76,
			[40] = 75,
			[41] = 74,
			[42] = 73,
			[43] = 72,
			[44] = 71,
			[45] = 70,
			[46] = 69,
			[47] = 68,
			[48] = 67,
			[49] = 66,
			[50] = 86,
			[51] = 85,
			[52] = 90,
			[53] = 65,
			[54] = 64,
			[55] = 63,
			[56] = 56,
			[57] = 53,
			[58] = 48,
			[59] = 45,
			[60] = 44,
			[61] = 42,
			[62] = 40,
			[63] = 25,
			[64] = 19,
		},
		["CustomEvents"] = {
		},
		["KBGroups"] = {
		},
		["defaultFont"] = "Interface\\AddOns\\DiscordActionBars\\CustomFonts\\",
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
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["hide"] = 1,
					["right"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Healing",
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
				["checkedcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["Scripts"] = {
				},
				["target"] = "player",
				["pages"] = {
					[1] = {
						[1] = 1,
						[2] = 2,
						[16] = 25,
						[14] = 9,
						[17] = 33,
						[13] = 1,
						[15] = 17,
						[18] = 41,
					},
					[2] = {
						[1] = 9,
						[2] = 10,
					},
				},
				["size"] = 38,
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
						[16] = {
						},
						[14] = {
						},
						[17] = {
						},
						[13] = {
						},
						[15] = {
						},
						[18] = {
						},
					},
					[2] = {
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
				["Keybinding"] = {
					["color"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["font"] = "Fonts\\FRIZQT__.TTF",
					["size"] = 10,
				},
				["disableMW"] = 1,
				["cbgroup"] = 1,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["Anchor"] = {
					["y"] = 5,
					["x"] = 16,
					["point"] = "LEFT",
					["frame"] = "Minimap",
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
					["rightpadding"] = 1,
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
					["edgeSize"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["expandHidden"] = 1,
				["skipPages"] = "",
				["numBars"] = 2,
				["middleClick"] = 1,
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
				["frameStrata"] = "DIALOG",
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
				["numButtons"] = 2,
				["vspacing"] = 0,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["page"] = 1,
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["disableMW"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 38,
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
						[6] = {
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
					},
				},
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
					["attachpoint"] = "BOTTOM",
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["right"] = 1,
					["left"] = 1,
					["hide"] = true,
					["bgalpha"] = 1,
					["edgeSize"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["bottom"] = 1,
					["top"] = 1,
					["text"] = "Purifying",
					["alpha"] = 1,
					["width"] = 100,
					["y"] = 10,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["bordalpha"] = 1,
					["x"] = 0,
					["height"] = 20,
					["fontsize"] = 15,
					["justifyH"] = "CENTER",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
				},
				["Conditions"] = {
				},
				["cbgroup"] = 2,
				["target"] = "player",
				["Anchor"] = {
					["y"] = 0,
					["x"] = 12,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_1",
					["to"] = "RIGHT",
				},
				["vspacing"] = 0,
				["numButtons"] = 6,
				["Scripts"] = {
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
				["middleClick"] = 2,
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["page"] = 1,
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
				["numBars"] = 2,
				["frameStrata"] = "LOW",
				["pages"] = {
					[1] = {
						[1] = 3,
						[2] = 4,
						[3] = 5,
						[4] = 6,
						[5] = 7,
						[6] = 8,
					},
					[2] = {
						[1] = 11,
						[2] = 12,
						[3] = 13,
						[4] = 14,
						[5] = 15,
						[6] = 16,
					},
				},
				["expandHidden"] = 1,
				["alpha"] = 1,
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
				["Scripts"] = {
				},
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 9,
						[2] = 10,
						[3] = 11,
						[4] = 12,
						[5] = 13,
					},
					[2] = {
						[1] = 1,
						[2] = 2,
						[3] = 3,
						[4] = 4,
						[5] = 5,
					},
				},
				["size"] = 38,
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
				},
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
					["text"] = "Offensive",
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
				["expandHidden"] = 1,
				["cbgroup"] = 3,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = -39,
					["x"] = 16,
					["point"] = "LEFT",
					["frame"] = "Minimap",
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
					["hide"] = 1,
					["bottompadding"] = 1,
					["tileSize"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
				},
				["numButtons"] = 5,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["Conditions"] = {
				},
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
				["numBars"] = 2,
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["page"] = 1,
				["frameStrata"] = "LOW",
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
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 14,
						[2] = 15,
						[3] = 16,
					},
					[2] = {
						[1] = 6,
						[2] = 7,
						[3] = 8,
					},
				},
				["size"] = 38,
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
				},
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
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["hide"] = 1,
					["right"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Offensive Undead",
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
				["cbgroup"] = 4,
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
					["hide"] = 1,
					["bottompadding"] = 1,
					["tileSize"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
				},
				["Anchor"] = {
					["y"] = 0,
					["x"] = 12,
					["point"] = "LEFT",
					["frame"] = "DAB_ActionBar_3",
					["to"] = "RIGHT",
				},
				["vspacing"] = 0,
				["expandHidden"] = 1,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 3,
				["Conditions"] = {
				},
				["manacolor"] = {
					["r"] = 0.2,
					["g"] = 0.2,
					["b"] = 1,
				},
				["middleClick"] = 4,
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
				["page"] = 1,
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
				["numBars"] = 2,
				["frameStrata"] = "LOW",
				["alpha"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
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
				["size"] = 32,
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
				["hspacing"] = 5,
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
						[6] = {
						},
					},
				},
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
					["bgalpha"] = 1,
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["hide"] = 1,
					["right"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Seals",
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
				["Conditions"] = {
				},
				["cbgroup"] = 5,
				["disableMW"] = 1,
				["Anchor"] = {
					["y"] = -2,
					["x"] = -39,
					["point"] = "TOPRIGHT",
					["frame"] = "Minimap",
					["to"] = "TOPLEFT",
				},
				["vspacing"] = 0,
				["expandHidden"] = 1,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
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
				["unusablerecolor"] = 1,
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
				["middleClick"] = 5,
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
				["numButtons"] = 6,
				["pages"] = {
					[1] = {
						[1] = 17,
						[2] = 18,
						[3] = 19,
						[4] = 20,
						[5] = 21,
						[6] = 22,
					},
				},
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["page"] = 1,
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
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 23,
						[2] = 24,
						[3] = 25,
						[4] = 26,
						[5] = 27,
						[13] = 145,
					},
				},
				["size"] = 38,
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
				["numBars"] = 1,
				["rows"] = 1,
				["hideEmpty"] = 1,
				["Conditions"] = {
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
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["hide"] = 1,
					["right"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Self Buffs",
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
				["cbgroup"] = 6,
				["vspacing"] = 0,
				["Anchor"] = {
					["y"] = 5,
					["x"] = -63,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
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
					["balpha"] = 0,
					["hide"] = 1,
				},
				["expandHidden"] = 1,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 5,
				["unusablerecolor"] = 1,
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
				["page"] = 1,
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
				["target"] = "player",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["alpha"] = 1,
				["frameStrata"] = "LOW",
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
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 28,
						[2] = 29,
						[3] = 30,
						[4] = 31,
						[5] = 32,
						[6] = 33,
					},
					[2] = {
						[1] = 34,
						[2] = 35,
						[3] = 36,
						[4] = 37,
						[5] = 38,
						[6] = 39,
					},
					[3] = {
						[1] = 40,
						[2] = 41,
						[3] = 42,
						[4] = 43,
						[5] = 44,
						[6] = 45,
					},
				},
				["size"] = 38,
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
				["numBars"] = 3,
				["rows"] = 3,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["font"] = "Fonts\\FRIZQT__.TTF",
					["text"] = "Blessings",
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
					["x"] = -268,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
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
				["vspacing"] = 0,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 6,
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
				["middleClick"] = 7,
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
						[6] = {
						},
					},
				},
				["frameStrata"] = "LOW",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["page"] = 1,
			},
			[8] = {
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
				["Scripts"] = {
				},
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["size"] = 38,
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
					["text"] = "Miscellaneous",
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
					["y"] = 0,
					["x"] = -6,
					["point"] = "RIGHT",
					["frame"] = "DAB_ActionBar_9",
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
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["numButtons"] = 4,
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
				["frameStrata"] = "LOW",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["pages"] = {
					[1] = {
						[1] = 46,
						[2] = 47,
						[3] = 48,
						[4] = 49,
					},
				},
				["page"] = 1,
			},
			[9] = {
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
					[2] = "",
				},
				["disableMW"] = 1,
				["pages"] = {
					[1] = {
						[1] = 52,
						[2] = 50,
					},
				},
				["size"] = 38,
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
				["hspacing"] = 8,
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
				["numButtons"] = 2,
				["cbgroup"] = 9,
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
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 0.5568627450980392,
						["g"] = 0.592156862745098,
						["b"] = 0.580392156862745,
					},
					["alpha"] = 1,
					["top"] = 1,
					["tileSize"] = 1,
					["bottompadding"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 0,
					["hide"] = 1,
				},
				["Anchor"] = {
					["y"] = -39,
					["x"] = -15,
					["point"] = "RIGHT",
					["frame"] = "Minimap",
					["to"] = "LEFT",
				},
				["vspacing"] = 100,
				["expandHidden"] = 1,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["Conditions"] = {
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
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["left"] = 1,
					["hide"] = 1,
					["right"] = 1,
					["bordcolor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["edgeSize"] = 1,
					["bottom"] = 1,
					["x"] = 0,
					["text"] = "Redemption Racial",
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
				["middleClick"] = 9,
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
				["page"] = 1,
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
			},
			[10] = {
				["middleClick"] = 10,
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
					[2] = "MazzleUI:ContextMenuClick()",
					[10] = "",
					[11] = "",
				},
				["target"] = "player",
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
				["size"] = 38,
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
					["y"] = 258.0000087188723,
					["x"] = 1228.00006765304,
					["point"] = "CENTER",
					["frame"] = "UIParent",
					["to"] = "BOTTOMLEFT",
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
					["toppadding"] = 1,
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\MazzleUIChatBoxBackground",
					["edgeSize"] = 1,
					["bottom"] = 1,
					["bcolor"] = {
						["r"] = 0.9764705882352941,
						["g"] = 1,
						["b"] = 0.9803921568627451,
					},
					["alpha"] = 1,
					["top"] = 1,
					["tileSize"] = 1,
					["bottompadding"] = 1,
					["rightpadding"] = 1,
					["balpha"] = 1,
					["hide"] = 1,
				},
				["numButtons"] = 16,
				["vspacing"] = 0,
				["unusablecolor"] = {
					["r"] = 0.6,
					["g"] = 0.6,
					["b"] = 0.6,
				},
				["Conditions"] = {
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
					["bgalpha"] = 0,
					["justifyV"] = "CENTER",
					["btexture"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
					["tileSize"] = 1,
					["attachto"] = "TOP",
					["attachpoint"] = "BOTTOM",
					["texture"] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					["left"] = 1,
					["bordcolor"] = {
						["r"] = 0.3568627450980392,
						["g"] = 0.3607843137254902,
						["b"] = 0.3647058823529412,
					},
					["right"] = 1,
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
					["edgeSize"] = 1,
					["fontsize"] = 15,
					["justifyH"] = "CENTER",
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
				["numBars"] = 2,
				["frameStrata"] = "LOW",
				["buttonbg"] = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
				["highlightcolor"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["page"] = 1,
			},
		},
	}
    end
end
