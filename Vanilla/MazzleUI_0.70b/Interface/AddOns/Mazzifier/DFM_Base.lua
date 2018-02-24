-- Copyright � 2006 Mazin Assanie
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

function Setup_DFM(profileName)
    
    if DFM_Settings then
        DFM_Settings[profileName] = {
		["Chat Frames"] = {
			["ChatFrame4ResizeBottomLeft"] = {
				["name"] = "ChatFrame4ResizeBottomLeft",
			},
			["ChatFrame3ResizeRight"] = {
				["name"] = "ChatFrame3ResizeRight",
			},
			["ChatFrame6ResizeTop"] = {
				["name"] = "ChatFrame6ResizeTop",
			},
			["ChatFrame2ResizeTop"] = {
				["name"] = "ChatFrame2ResizeTop",
			},
			["ChatFrame4ResizeLeft"] = {
				["name"] = "ChatFrame4ResizeLeft",
			},
			["ChatFrame6ResizeTopLeft"] = {
				["name"] = "ChatFrame6ResizeTopLeft",
			},
			["ChatFrame3DownButton"] = {
				["name"] = "ChatFrame3DownButton",
			},
			["ChatFrame6ResizeTopRight"] = {
				["name"] = "ChatFrame6ResizeTopRight",
			},
			["ChatFrame1ResizeTopLeft"] = {
				["name"] = "ChatFrame1ResizeTopLeft",
				["forceHide"] = 1,
			},
			["ChatFrame2UpButton"] = {
				["name"] = "ChatFrame2UpButton",
			},
			["ChatFrame5ResizeBottom"] = {
				["name"] = "ChatFrame5ResizeBottom",
			},
			["ChatFrame2ResizeRight"] = {
				["name"] = "ChatFrame2ResizeRight",
			},
			["ChatFrame2"] = {
				["name"] = "ChatFrame2",
			},
			["ChatFrame3ResizeBottomLeft"] = {
				["name"] = "ChatFrame3ResizeBottomLeft",
			},
			["ChatFrame1ResizeTopRight"] = {
				["name"] = "ChatFrame1ResizeTopRight",
				["forceHide"] = 1,
			},
			["ChatFrame7ResizeBottomLeft"] = {
				["name"] = "ChatFrame7ResizeBottomLeft",
			},
			["ChatFrame3ResizeTopRight"] = {
				["name"] = "ChatFrame3ResizeTopRight",
			},
			["ChatFrame4ResizeTop"] = {
				["name"] = "ChatFrame4ResizeTop",
			},
			["ChatFrameEditBox"] = {
				[5] = {
					[1] = 390,
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "ChatFrameEditBox",
				["Location"] = {
					["y"] = 231,
					["x"] = -2,
					["point"] = "BOTTOMLEFT",
					["frame"] = "UIParent",
					["to"] = "BOTTOMLEFT",
					["use"] = 1,
				},
				[18] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIChatBoxBackground",
					[2] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIChatBoxBorder",
					[4] = 32,
					[5] = 16,
					[6] = 5,
					[7] = 5,
					[8] = 5,
					[9] = 5,
					["use"] = 1,
					["lock"] = 1,
				},
				[4] = {
					[1] = 34,
					["lock"] = 1,
					["use"] = 1,
				},
			},
			["ChatFrame2DownButton"] = {
				["name"] = "ChatFrame2DownButton",
			},
			["ChatFrame5"] = {
				["name"] = "ChatFrame5",
			},
			["ChatFrame3BottomButton"] = {
				["name"] = "ChatFrame3BottomButton",
			},
			["ChatFrame2BottomButton"] = {
				["name"] = "ChatFrame2BottomButton",
			},
			["ChatFrame6"] = {
				[5] = {
					[1] = 111,
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "ChatFrame6",
				["Location"] = {
					["to"] = "BOTTOMRIGHT",
					["y"] = 21,
					["x"] = -256,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 102,
					["lock"] = 1,
					["use"] = 1,
				},
			},
			["ChatFrame7ResizeTopRight"] = {
				["name"] = "ChatFrame7ResizeTopRight",
			},
			["ChatFrame3ResizeBottomRight"] = {
				["name"] = "ChatFrame3ResizeBottomRight",
			},
			["ChatFrame1BottomButton"] = {
				["name"] = "ChatFrame1BottomButton",
			},
			["ChatFrame1DownButton"] = {
				["name"] = "ChatFrame1DownButton",
			},
			["ChatFrame6ResizeBottom"] = {
				["name"] = "ChatFrame6ResizeBottom",
			},
			["ChatFrame1ResizeTop"] = {
				["name"] = "ChatFrame1ResizeTop",
				["forceHide"] = 1,
			},
			["ChatFrame5ResizeBottomRight"] = {
				["name"] = "ChatFrame5ResizeBottomRight",
			},
			["ChatFrame1UpButton"] = {
				["name"] = "ChatFrame1UpButton",
			},
			["ChatFrame2ResizeBottomLeft"] = {
				["name"] = "ChatFrame2ResizeBottomLeft",
			},
			["ChatFrame5ResizeTopRight"] = {
				["name"] = "ChatFrame5ResizeTopRight",
			},
			["ChatFrame3UpButton"] = {
				["name"] = "ChatFrame3UpButton",
			},
			["ChatFrame3ResizeBottom"] = {
				["name"] = "ChatFrame3ResizeBottom",
			},
			["ChatFrame1"] = {
				[2] = {
					[1] = "MEDIUM",
				},
				[3] = {
					[1] = 4,
					["use"] = 1,
				},
				[4] = {
					[1] = 212,
					["lock"] = 1,
					["use"] = 1,
				},
				[5] = {
					[1] = 347,
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "ChatFrame1",
				[64] = {
				},
				["Location"] = {
					["to"] = "BOTTOMLEFT",
					["y"] = 15,
					["x"] = 20,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
					["use"] = 1,
				},
			},
			["ChatFrame1ResizeBottomRight"] = {
				["name"] = "ChatFrame1ResizeBottomRight",
				["forceHide"] = 1,
			},
			["ChatFrame6DownButton"] = {
				["name"] = "ChatFrame6DownButton",
			},
			["ChatFrame7ResizeLeft"] = {
				["name"] = "ChatFrame7ResizeLeft",
			},
			["ChatFrame3ResizeTop"] = {
				["name"] = "ChatFrame3ResizeTop",
			},
			["ChatFrame6ResizeBottomRight"] = {
				["name"] = "ChatFrame6ResizeBottomRight",
			},
			["ChatFrame6ResizeBottomLeft"] = {
				["name"] = "ChatFrame6ResizeBottomLeft",
			},
			["ChatFrame2ResizeBottom"] = {
				["name"] = "ChatFrame2ResizeBottom",
			},
			["ChatFrame6UpButton"] = {
				["name"] = "ChatFrame6UpButton",
			},
			["ChatFrame4ResizeBottomRight"] = {
				["name"] = "ChatFrame4ResizeBottomRight",
			},
			["ChatFrame5BottomButton"] = {
				["name"] = "ChatFrame5BottomButton",
			},
			["ChatFrame1ResizeBottom"] = {
				["name"] = "ChatFrame1ResizeBottom",
				["forceHide"] = 1,
			},
			["ChatFrame1ResizeRight"] = {
				["name"] = "ChatFrame1ResizeRight",
				["forceHide"] = 1,
			},
			["ChatFrame4ResizeRight"] = {
				["name"] = "ChatFrame4ResizeRight",
			},
			["ChatFrame7ResizeTop"] = {
				["name"] = "ChatFrame7ResizeTop",
			},
			["ChatFrame6BottomButton"] = {
				["name"] = "ChatFrame6BottomButton",
			},
			["ChatFrame5ResizeBottomLeft"] = {
				["name"] = "ChatFrame5ResizeBottomLeft",
			},
			["ChatFrame2ResizeTopLeft"] = {
				["name"] = "ChatFrame2ResizeTopLeft",
			},
			["ChatFrame6ResizeRight"] = {
				["name"] = "ChatFrame6ResizeRight",
			},
			["ChatFrame4ResizeTopRight"] = {
				["name"] = "ChatFrame4ResizeTopRight",
			},
			["ChatFrame7ResizeRight"] = {
				["name"] = "ChatFrame7ResizeRight",
			},
			["ChatFrame5DownButton"] = {
				["name"] = "ChatFrame5DownButton",
			},
			["ChatFrame7ResizeBottom"] = {
				["name"] = "ChatFrame7ResizeBottom",
			},
			["ChatFrame2ResizeTopRight"] = {
				["name"] = "ChatFrame2ResizeTopRight",
			},
			["ChatFrame4BottomButton"] = {
				["name"] = "ChatFrame4BottomButton",
			},
			["ChatFrame1ResizeBottomLeft"] = {
				["name"] = "ChatFrame1ResizeBottomLeft",
				["forceHide"] = 1,
			},
			["ChatFrame7DownButton"] = {
				["name"] = "ChatFrame7DownButton",
			},
			["ChatFrame6ResizeLeft"] = {
				["name"] = "ChatFrame6ResizeLeft",
			},
			["ChatFrame5ResizeLeft"] = {
				["name"] = "ChatFrame5ResizeLeft",
			},
			["ChatFrame3"] = {
				["name"] = "ChatFrame3",
			},
			["ChatFrame7BottomButton"] = {
				["name"] = "ChatFrame7BottomButton",
			},
			["ChatFrame5ResizeRight"] = {
				["name"] = "ChatFrame5ResizeRight",
			},
			["ChatFrame4DownButton"] = {
				["name"] = "ChatFrame4DownButton",
			},
			["ChatFrame7ResizeTopLeft"] = {
				["name"] = "ChatFrame7ResizeTopLeft",
			},
			["ChatFrame2ResizeLeft"] = {
				["name"] = "ChatFrame2ResizeLeft",
			},
			["ChatFrame4UpButton"] = {
				["name"] = "ChatFrame4UpButton",
			},
			["ChatFrame5ResizeTopLeft"] = {
				["name"] = "ChatFrame5ResizeTopLeft",
			},
			["ChatFrame4ResizeTopLeft"] = {
				["name"] = "ChatFrame4ResizeTopLeft",
			},
			["ChatFrame5ResizeTop"] = {
				["name"] = "ChatFrame5ResizeTop",
			},
			["ChatFrame3ResizeLeft"] = {
				["name"] = "ChatFrame3ResizeLeft",
			},
			["ChatFrame7UpButton"] = {
				["name"] = "ChatFrame7UpButton",
			},
			["ChatFrame7ResizeBottomRight"] = {
				["name"] = "ChatFrame7ResizeBottomRight",
			},
			["ChatFrame7"] = {
				[5] = {
					[1] = 217,
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "ChatFrame7",
				["Location"] = {
					["to"] = "BOTTOMRIGHT",
					["y"] = 21,
					["x"] = -22,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 102,
					["lock"] = 1,
					["use"] = 1,
				},
			},
			["ChatFrame2ResizeBottomRight"] = {
				["name"] = "ChatFrame2ResizeBottomRight",
			},
			["ChatFrame5UpButton"] = {
				["name"] = "ChatFrame5UpButton",
			},
			["ChatFrame4"] = {
				["name"] = "ChatFrame4",
			},
			["ChatFrame3ResizeTopLeft"] = {
				["name"] = "ChatFrame3ResizeTopLeft",
			},
			["ChatFrame1ResizeLeft"] = {
				["name"] = "ChatFrame1ResizeLeft",
				["forceHide"] = 1,
			},
			["ChatFrame4ResizeBottom"] = {
				["name"] = "ChatFrame4ResizeBottom",
			},
		},
		["_Hidden"] = {
			["MonkeyBuddyIconButton"] = {
				["forceHide"] = 1,
				["name"] = "MonkeyBuddyIconButton",
			},
			["xcalc_Button"] = {
				["name"] = "xcalc_Button",
				["forceHide"] = 1,
			},
		},
		["Party Frames"] = {
			["PartyMemberFrame1Debuff3"] = {
				["name"] = "PartyMemberFrame1Debuff3",
			},
			["PartyMemberFrame3DropDownButton"] = {
				["name"] = "PartyMemberFrame3DropDownButton",
			},
			["PartyMemberFrame1DropDownButton"] = {
				["name"] = "PartyMemberFrame1DropDownButton",
			},
			["PartyMemberFrame3Debuff3"] = {
				["name"] = "PartyMemberFrame3Debuff3",
			},
			["PartyMemberFrame1Debuff1"] = {
				["name"] = "PartyMemberFrame1Debuff1",
			},
			["PartyMemberFrame1PetFrameDebuff4"] = {
				["name"] = "PartyMemberFrame1PetFrameDebuff4",
			},
			["PartyMemberFrame2PetFrameDebuff3"] = {
				["name"] = "PartyMemberFrame2PetFrameDebuff3",
			},
			["PartyMemberFrame3ManaBar"] = {
				["name"] = "PartyMemberFrame3ManaBar",
			},
			["PartyMemberFrame2DropDownButton"] = {
				["name"] = "PartyMemberFrame2DropDownButton",
			},
			["PartyMemberFrame3PetFrame"] = {
				["name"] = "PartyMemberFrame3PetFrame",
			},
			["PartyMemberFrame1PetFrameDebuff3"] = {
				["name"] = "PartyMemberFrame1PetFrameDebuff3",
			},
			["PartyMemberFrame4PetFrameHealthBar"] = {
				["name"] = "PartyMemberFrame4PetFrameHealthBar",
			},
			["PartyMemberFrame4ManaBar"] = {
				["name"] = "PartyMemberFrame4ManaBar",
			},
			["PartyMemberBuffTooltip"] = {
				["name"] = "PartyMemberBuffTooltip",
			},
			["PartyMemberFrame2PetFrameDebuff2"] = {
				["name"] = "PartyMemberFrame2PetFrameDebuff2",
			},
			["PartyMemberFrame4Debuff3"] = {
				["name"] = "PartyMemberFrame4Debuff3",
			},
			["PartyMemberFrame4Debuff2"] = {
				["name"] = "PartyMemberFrame4Debuff2",
			},
			["PartyMemberFrame1Debuff2"] = {
				["name"] = "PartyMemberFrame1Debuff2",
			},
			["PartyMemberFrame4PetFrameDebuff3"] = {
				["name"] = "PartyMemberFrame4PetFrameDebuff3",
			},
			["PartyMemberFrame4PetFrameDebuff4"] = {
				["name"] = "PartyMemberFrame4PetFrameDebuff4",
			},
			["PartyMemberFrame4PetFrameDebuff1"] = {
				["name"] = "PartyMemberFrame4PetFrameDebuff1",
			},
			["PartyMemberFrame4HealthBar"] = {
				["name"] = "PartyMemberFrame4HealthBar",
			},
			["PartyMemberFrame4Debuff4"] = {
				["name"] = "PartyMemberFrame4Debuff4",
			},
			["PartyMemberFrame2ManaBar"] = {
				["name"] = "PartyMemberFrame2ManaBar",
			},
			["PartyMemberFrame4DropDownButton"] = {
				["name"] = "PartyMemberFrame4DropDownButton",
			},
			["PartyMemberFrame2PetFrame"] = {
				["name"] = "PartyMemberFrame2PetFrame",
			},
			["PartyMemberFrame4PetFrame"] = {
				["name"] = "PartyMemberFrame4PetFrame",
			},
			["PartyMemberFrame3DropDown"] = {
				["name"] = "PartyMemberFrame3DropDown",
			},
			["PartyMemberBackground"] = {
				["name"] = "PartyMemberBackground",
			},
			["PartyMemberFrame4"] = {
				["name"] = "PartyMemberFrame4",
			},
			["PartyMemberFrame2Debuff3"] = {
				["name"] = "PartyMemberFrame2Debuff3",
			},
			["PartyMemberFrame1ManaBar"] = {
				["name"] = "PartyMemberFrame1ManaBar",
			},
			["PartyMemberFrame2"] = {
				["name"] = "PartyMemberFrame2",
			},
			["PartyMemberFrame3PetFrameDebuff4"] = {
				["name"] = "PartyMemberFrame3PetFrameDebuff4",
			},
			["PartyMemberFrame2HealthBar"] = {
				["name"] = "PartyMemberFrame2HealthBar",
			},
			["PartyMemberFrame1Debuff4"] = {
				["name"] = "PartyMemberFrame1Debuff4",
			},
			["PartyMemberFrame3PetFrameDebuff2"] = {
				["name"] = "PartyMemberFrame3PetFrameDebuff2",
			},
			["PartyMemberFrame4Debuff1"] = {
				["name"] = "PartyMemberFrame4Debuff1",
			},
			["PartyMemberFrame3PetFrameDebuff1"] = {
				["name"] = "PartyMemberFrame3PetFrameDebuff1",
			},
			["PartyMemberFrame3PetFrameHealthBar"] = {
				["name"] = "PartyMemberFrame3PetFrameHealthBar",
			},
			["PartyMemberFrame4DropDown"] = {
				["name"] = "PartyMemberFrame4DropDown",
			},
			["PartyMemberFrame1"] = {
				["name"] = "PartyMemberFrame1",
			},
			["PartyMemberFrame2Debuff1"] = {
				["name"] = "PartyMemberFrame2Debuff1",
			},
			["PartyMemberFrame3Debuff4"] = {
				["name"] = "PartyMemberFrame3Debuff4",
			},
			["PartyMemberFrame3Debuff2"] = {
				["name"] = "PartyMemberFrame3Debuff2",
			},
			["PartyMemberFrame3Debuff1"] = {
				["name"] = "PartyMemberFrame3Debuff1",
			},
			["PartyMemberFrame3HealthBar"] = {
				["name"] = "PartyMemberFrame3HealthBar",
			},
			["PartyMemberFrame2Debuff2"] = {
				["name"] = "PartyMemberFrame2Debuff2",
			},
			["PartyMemberFrame1PetFrameDebuff1"] = {
				["name"] = "PartyMemberFrame1PetFrameDebuff1",
			},
			["PartyMemberFrame2DropDown"] = {
				["name"] = "PartyMemberFrame2DropDown",
			},
			["PartyMemberFrame4PetFrameDebuff2"] = {
				["name"] = "PartyMemberFrame4PetFrameDebuff2",
			},
			["PartyMemberFrame1PetFrameHealthBar"] = {
				["name"] = "PartyMemberFrame1PetFrameHealthBar",
			},
			["PartyMemberFrame3PetFrameDebuff3"] = {
				["name"] = "PartyMemberFrame3PetFrameDebuff3",
			},
			["PartyMemberFrame2Debuff4"] = {
				["name"] = "PartyMemberFrame2Debuff4",
			},
			["PartyMemberFrame1DropDown"] = {
				["name"] = "PartyMemberFrame1DropDown",
			},
			["PartyMemberFrame1PetFrameDebuff2"] = {
				["name"] = "PartyMemberFrame1PetFrameDebuff2",
			},
			["PartyMemberFrame1PetFrame"] = {
				["name"] = "PartyMemberFrame1PetFrame",
			},
			["PartyMemberFrame2PetFrameHealthBar"] = {
				["name"] = "PartyMemberFrame2PetFrameHealthBar",
			},
			["PartyMemberFrame3"] = {
				["name"] = "PartyMemberFrame3",
			},
			["PartyMemberFrame2PetFrameDebuff1"] = {
				["name"] = "PartyMemberFrame2PetFrameDebuff1",
			},
			["PartyMemberFrame1HealthBar"] = {
				["name"] = "PartyMemberFrame1HealthBar",
			},
			["PartyMemberFrame2PetFrameDebuff4"] = {
				["name"] = "PartyMemberFrame2PetFrameDebuff4",
			},
		},
		["Shapeshift Bar"] = {
			["ShapeshiftButton4"] = {
				["name"] = "ShapeshiftButton4",
			},
			["ShapeshiftButton7"] = {
				["name"] = "ShapeshiftButton7",
			},
			["ShapeshiftButton8"] = {
				["name"] = "ShapeshiftButton8",
			},
			["ShapeshiftButton10"] = {
				["name"] = "ShapeshiftButton10",
			},
			["ShapeshiftButton6"] = {
				["name"] = "ShapeshiftButton6",
			},
			["ShapeshiftButton9"] = {
				["name"] = "ShapeshiftButton9",
			},
			["ShapeshiftButton5"] = {
				["name"] = "ShapeshiftButton5",
			},
			["ShapeshiftButton2"] = {
				["name"] = "ShapeshiftButton2",
			},
			["ShapeshiftButton3"] = {
				["name"] = "ShapeshiftButton3",
			},
			["ShapeshiftButton1"] = {
				["name"] = "ShapeshiftButton1",
			},
			["ShapeshiftBarFrame"] = {
				["name"] = "ShapeshiftBarFrame",
			},
		},
		["_ClassSpecific"] = {
			["CCP_CP_3"] = {
				["Location"] = {
					["to"] = "CENTER",
					["y"] = 184,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "CENTER",
					["use"] = 1,
				},
				["name"] = "CCP_CP_3",
			},
			["NecrosisAntiFearButton"] = {
				["Location"] = {
					["to"] = "CENTER",
					["y"] = -88,
					["x"] = 109,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "CENTER",
					["use"] = 1,
				},
				["name"] = "NecrosisAntiFearButton",
			},
			["CCP_CP_2"] = {
				["Location"] = {
					["to"] = "LEFT",
					["y"] = 0,
					["x"] = -2,
					["lock"] = 1,
					["frame"] = "CCP_CP_3",
					["point"] = "RIGHT",
					["use"] = 1,
				},
				["name"] = "CCP_CP_2",
			},
			["CCP_CP_5"] = {
				["Location"] = {
					["to"] = "RIGHT",
					["y"] = 0,
					["x"] = 2,
					["lock"] = 1,
					["frame"] = "CCP_CP_4",
					["point"] = "LEFT",
					["use"] = 1,
				},
				["name"] = "CCP_CP_5",
			},
			["NecrosisButton"] = {
				["name"] = "NecrosisButton",
				[28] = {
					[1] = {
						["r"] = 0.2117647058823529,
						["g"] = 0.2078431372549019,
						["b"] = 1,
					},
					[2] = 1,
				},
				["Location"] = {
					["y"] = 181.49,
					["x"] = -212.33,
					["point"] = "BOTTOMRIGHT",
					["frame"] = "UIParent",
					["to"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
			},
			["NecrosisShadowTranceButton"] = {
				["Location"] = {
					["to"] = "CENTER",
					["y"] = -88,
					["x"] = -105,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "CENTER",
					["use"] = 1,
				},
				["name"] = "NecrosisShadowTranceButton",
			},
			["NecrosisSpellTimerButton"] = {
				["name"] = "NecrosisSpellTimerButton",
				["Location"] = {
					["y"] = 27,
					["x"] = 112,
					["point"] = "BOTTOM",
					["frame"] = "NecrosisButton",
					["to"] = "TOP",
					["use"] = 1,
				},
				["forceHide"] = 1,
			},
			["GathererUI_IconFrame"] = {
				[1] = {
					[1] = "UIParent",
					["use"] = 1,
				},
				["Location"] = {
					["y"] = -15.33,
					["x"] = 33.96,
					["to"] = "TOPRIGHT",
					["frame"] = "Minimap",
					["point"] = "LEFT",
					["use"] = 1,
				},
				["name"] = "GathererUI_IconFrame",
			},
			["CCP_CP_1"] = {
				["Location"] = {
					["to"] = "LEFT",
					["y"] = 0,
					["x"] = -2,
					["lock"] = 1,
					["frame"] = "CCP_CP_2",
					["point"] = "RIGHT",
					["use"] = 1,
				},
				["name"] = "CCP_CP_1",
			},
			["CCP_CP_4"] = {
				["Location"] = {
					["to"] = "RIGHT",
					["y"] = 0,
					["x"] = 2,
					["lock"] = 1,
					["frame"] = "CCP_CP_3",
					["point"] = "LEFT",
					["use"] = 1,
				},
				["name"] = "CCP_CP_4",
			},
		},
		["Minimap"] = {
			["MinimapBackdrop"] = {
				[2] = {
					[1] = "MEDIUM",
				},
				["Location"] = {
					["y"] = 0,
					["x"] = 0,
					["to"] = "BOTTOM",
					["frame"] = "Minimap",
					["point"] = "BOTTOM",
				},
				["name"] = "MinimapBackdrop",
			},
			["MinimapToggleButton"] = {
				["name"] = "MinimapToggleButton",
			},
			["Minimap"] = {
				[1] = {
					[1] = "UIParent",
					["use"] = 1,
				},
				[2] = {
					[1] = "LOW",
					["use"] = 1,
				},
				[4] = {
					[1] = 128,
					["use"] = 1,
				},
				[5] = {
					[1] = 129,
					["use"] = 1,
				},
				[57] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIMinimapMask",
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "Minimap",
				["Location"] = {
					["y"] = 9,
					["x"] = 0,
					["to"] = "BOTTOM",
					["frame"] = "UIParent",
					["point"] = "BOTTOM",
					["use"] = 1,
				},
				[18] = {
					[1] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					[2] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIMinimapBorder",
					[4] = 32,
					[5] = 16,
					[6] = 5,
					[7] = 5,
					[8] = 5,
					[9] = 5,
				},
			},
			["MinimapBorderTop"] = {
				["name"] = "MinimapBorderTop",
			},
			["MiniMapPing"] = {
				["name"] = "MiniMapPing",
			},
			["MiniMapBattlefieldFrame"] = {
				[6] = {
					[1] = 1.02,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "MiniMapBattlefieldFrame",
				["Location"] = {
					["y"] = -15,
					["x"] = -5,
					["to"] = "TOPLEFT",
					["frame"] = "Minimap",
					["point"] = "RIGHT",
					["use"] = 1,
				},
			},
			["MinimapBorder"] = {
				[5] = {
					[1] = 152.6,
				},
				[7] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIMinimapBorder",
					["use"] = 1,
					["lock"] = 1,
				},
				["Location"] = {
					["y"] = 0,
					["x"] = -1,
					["point"] = "TOPLEFT",
					["frame"] = "MinimapBackdrop",
					["to"] = "TOPLEFT",
				},
				["name"] = "MinimapBorder",
				[15] = {
					[1] = 0,
					[2] = 0,
					[3] = 0,
					[4] = 1,
					[5] = 1,
					[6] = 0,
					[7] = 1,
					[8] = 1,
				},
				[4] = {
					[1] = 188.9,
				},
			},
			["MiniMapBattlefieldDropDownButton"] = {
				["name"] = "MiniMapBattlefieldDropDownButton",
			},
			["MinimapZoomIn"] = {
				["name"] = "MinimapZoomIn",
			},
			["DurabilityFrame"] = {
				["name"] = "DurabilityFrame",
			},
			["MinimapCluster"] = {
				[1] = {
					[1] = "Minimap",
				},
				[2] = {
					[1] = "LOW",
				},
				[3] = {
					[1] = 0,
				},
				[4] = {
					[1] = 180,
				},
				[5] = {
					[1] = 164.5,
				},
				[6] = {
					[1] = 1,
				},
				["name"] = "MinimapCluster",
				["Location"] = {
					["y"] = -8,
					["x"] = -8,
					["to"] = "CENTER",
					["frame"] = "Minimap",
					["point"] = "CENTER",
					["use"] = 1,
				},
				[18] = {
					[1] = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",
					[2] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIMinimapBorder",
					[4] = 32,
					[5] = 16,
					[6] = 5,
					[7] = 5,
					[8] = 5,
					[9] = 5,
				},
			},
			["GameTimeFrame"] = {
				["Location"] = {
					["y"] = 87,
					["x"] = 378,
					["point"] = "BOTTOMLEFT",
					["frame"] = "UIParent",
					["to"] = "BOTTOMLEFT",
				},
				["name"] = "GameTimeFrame",
			},
			["MinimapZoomOut"] = {
				["name"] = "MinimapZoomOut",
			},
			["MinimapZoneText"] = {
				["name"] = "MinimapZoneText",
			},
			["MiniMapMailFrame"] = {
				["name"] = "MiniMapMailFrame",
			},
			["MiniMapMeetingStoneFrame"] = {
				[6] = {
					[1] = 1.02,
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "MiniMapMeetingStoneFrame",
				["Location"] = {
					["y"] = -15,
					["x"] = -27,
					["to"] = "TOPLEFT",
					["frame"] = "Minimap",
					["point"] = "RIGHT",
					["use"] = 1,
				},
			},
			["MiniMapTrackingFrame"] = {
				["name"] = "MiniMapTrackingFrame",
			},
			["MinimapZoneTextButton"] = {
				["name"] = "MinimapZoneTextButton",
			},
			["MiniMapBattlefieldDropDown"] = {
				["name"] = "MiniMapBattlefieldDropDown",
			},
		},
		["Bonus Action Bar"] = {
			["BonusActionButton7"] = {
				["name"] = "BonusActionButton7",
			},
			["BonusActionButton5"] = {
				["name"] = "BonusActionButton5",
			},
			["BonusActionButton9"] = {
				["name"] = "BonusActionButton9",
			},
			["BonusActionButton11"] = {
				["name"] = "BonusActionButton11",
			},
			["BonusActionButton6"] = {
				["name"] = "BonusActionButton6",
			},
			["BonusActionButton2"] = {
				["name"] = "BonusActionButton2",
			},
			["BonusActionButton4"] = {
				["name"] = "BonusActionButton4",
			},
			["BonusActionButton10"] = {
				["name"] = "BonusActionButton10",
			},
			["BonusActionButton1"] = {
				["name"] = "BonusActionButton1",
			},
			["BonusActionButton8"] = {
				["name"] = "BonusActionButton8",
			},
			["BonusActionBarFrame"] = {
				["name"] = "BonusActionBarFrame",
			},
			["BonusActionButton12"] = {
				["name"] = "BonusActionButton12",
			},
			["BonusActionButton3"] = {
				["name"] = "BonusActionButton3",
			},
		},
		["_StatusWindows"] = {
			["StatusWindowWindow1"] = {
				["Location"] = {
					["y"] = 0,
					["x"] = 21,
					["point"] = "RIGHT",
					["frame"] = "StatusWindowWindow4",
					["to"] = "LEFT",
					["use"] = 1,
				},
				["name"] = "StatusWindowWindow1",
			},
			["StatusWindowWindow4"] = {
				["Location"] = {
					["to"] = "BOTTOMRIGHT",
					["y"] = 186,
					["x"] = -239,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "StatusWindowWindow4",
			},
			["StatusWindowWindow2"] = {
				["Location"] = {
					["point"] = "TOPRIGHT",
					["y"] = -25,
					["x"] = 16,
					["lock"] = 1,
					["frame"] = "DART_Texture_15",
					["to"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "StatusWindowWindow2",
			},
			["StatusWindowWindow3"] = {
				["Location"] = {
					["to"] = "BOTTOM",
					["y"] = 0,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "DUF_PlayerFrame_TextBox_8",
					["point"] = "TOP",
					["use"] = 1,
				},
				["name"] = "StatusWindowWindow3",
			},
			["StatusWindowWindow5"] = {
				["Location"] = {
					["to"] = "BOTTOM",
					["y"] = 0,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOM",
					["use"] = 1,
				},
				["name"] = "StatusWindowWindow5",
			},
		},
		["_TargetButtons"] = {
			["FollowButton"] = {
				["Location"] = {
					["point"] = "BOTTOMLEFT",
					["y"] = 24,
					["x"] = 26,
					["lock"] = 1,
					["frame"] = "DART_Texture_5",
					["to"] = "BOTTOMLEFT",
					["use"] = 1,
				},
				["name"] = "FollowButton",
			},
			["InspectButton"] = {
				["Location"] = {
					["point"] = "TOPLEFT",
					["y"] = -74,
					["x"] = 38,
					["lock"] = 1,
					["frame"] = "DART_Texture_5",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "InspectButton",
			},
			["TradeButton"] = {
				["Location"] = {
					["point"] = "BOTTOMRIGHT",
					["y"] = 24,
					["x"] = -26,
					["lock"] = 1,
					["frame"] = "DART_Texture_5",
					["to"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "TradeButton",
			},
			["WhisperButton"] = {
				[2] = {
					[1] = "MEDIUM",
				},
				["Location"] = {
					["point"] = "TOPRIGHT",
					["y"] = -73.92,
					["x"] = -38.32,
					["lock"] = 1,
					["frame"] = "DART_Texture_5",
					["to"] = "TOPRIGHT",
					["use"] = 1,
				},
				["name"] = "WhisperButton",
			},
		},
		["_Blizzard"] = {
			["TicketStatusFrame"] = {
				["Location"] = {
					["y"] = -27,
					["x"] = 0,
					["point"] = "TOPRIGHT",
					["frame"] = "UIParent",
					["to"] = "TOPRIGHT",
					["use"] = 1,
				},
				["name"] = "TicketStatusFrame",
			},
			["ChatFrame7Tab"] = {
				["name"] = "ChatFrame7Tab",
				["forceHide"] = 1,
			},
			["ChatFrame2ScrollDownReminder"] = {
				[5] = {
					[1] = 32,
					["use"] = 1,
				},
				["name"] = "ChatFrame2ScrollDownReminder",
				["Location"] = {
					["y"] = -14,
					["x"] = 21,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame1",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 32,
					["use"] = 1,
				},
				[19] = {
					[1] = 1,
				},
			},
			["ChatFrame1ScrollDownReminder"] = {
				[5] = {
					[1] = 32,
					["use"] = 1,
				},
				["name"] = "ChatFrame1ScrollDownReminder",
				["Location"] = {
					["y"] = -14,
					["x"] = 21,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame1",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 32,
					["use"] = 1,
				},
				[19] = {
					[1] = 1,
				},
			},
			["ChatFrame4ScrollDownReminder"] = {
				[5] = {
					[1] = 32,
					["use"] = 1,
				},
				["name"] = "ChatFrame4ScrollDownReminder",
				["Location"] = {
					["y"] = -14,
					["x"] = 21,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame1",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 32,
					["use"] = 1,
				},
				[19] = {
					[1] = 1,
				},
			},
			["ChatFrame6ScrollDownReminder"] = {
				[19] = {
					[1] = 1,
				},
				["name"] = "ChatFrame6ScrollDownReminder",
				["Location"] = {
					["y"] = -8,
					["x"] = 4,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame6",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 16,
					["use"] = 1,
				},
				[5] = {
					[1] = 16,
					["use"] = 1,
				},
			},
			["FlightMapTimesBorder"] = {
				[7] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUICastingBarBorder",
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "FlightMapTimesBorder",
			},
			["ChatFrame6Tab"] = {
				["name"] = "ChatFrame6Tab",
				["forceHide"] = 1,
			},
			["ChatFrame3ScrollDownReminder"] = {
				[5] = {
					[1] = 32,
					["use"] = 1,
				},
				["name"] = "ChatFrame3ScrollDownReminder",
				["Location"] = {
					["y"] = -14,
					["x"] = 21,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame1",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 32,
					["use"] = 1,
				},
				[19] = {
					[1] = 1,
				},
			},
			["FlightMapTimesFlash"] = {
				[7] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUICastingBarFlash",
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "FlightMapTimesFlash",
			},
			["ChatFrame7ScrollDownReminder"] = {
				[19] = {
					[1] = 1,
				},
				["name"] = "ChatFrame7ScrollDownReminder",
				["Location"] = {
					["y"] = -8,
					["x"] = 4,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame7",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 16,
					["use"] = 1,
				},
				[5] = {
					[1] = 16,
					["use"] = 1,
				},
			},
			["ChatFrame5ScrollDownReminder"] = {
				[5] = {
					[1] = 32,
					["use"] = 1,
				},
				["name"] = "ChatFrame5ScrollDownReminder",
				["Location"] = {
					["y"] = -14,
					["x"] = 21,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "ChatFrame1",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 32,
					["use"] = 1,
				},
				[19] = {
					[1] = 1,
				},
			},
			["BattlefieldMinimapTab"] = {
				["Location"] = {
					["point"] = "TOPRIGHT",
					["y"] = 14,
					["x"] = -283,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "TOPRIGHT",
					["use"] = 1,
				},
				["name"] = "BattlefieldMinimapTab",
			},
		},
		["Error Frames"] = {
			["ScriptErrors_Message"] = {
				["name"] = "ScriptErrors_Message",
			},
			["UIErrorsFrame"] = {
				["name"] = "UIErrorsFrame",
			},
			["ScriptErrors"] = {
				["name"] = "ScriptErrors",
			},
		},
		["Buffs / Debuffs"] = {
			["BuffButton0"] = {
				["name"] = "BuffButton0",
			},
			["BuffButton7"] = {
				["name"] = "BuffButton7",
			},
			["BuffButton19"] = {
				["name"] = "BuffButton19",
			},
			["BuffButton23"] = {
				["name"] = "BuffButton23",
			},
			["TemporaryEnchantFrame"] = {
				["Location"] = {
					["to"] = "BOTTOMLEFT",
					["y"] = 275.13,
					["x"] = 2.93,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
					["use"] = 1,
				},
				["name"] = "Weapon Buffs Frame",
			},
			["BuffButton11"] = {
				["name"] = "BuffButton11",
			},
			["BuffButton16"] = {
				["name"] = "BuffButton16",
			},
			["BuffButton9"] = {
				["name"] = "BuffButton9",
			},
			["BuffButton15"] = {
				["name"] = "BuffButton15",
			},
			["BuffButton1"] = {
				["name"] = "BuffButton1",
			},
			["BuffButton13"] = {
				["name"] = "BuffButton13",
			},
			["BuffButton22"] = {
				["name"] = "BuffButton22",
			},
			["BuffButton14"] = {
				["name"] = "BuffButton14",
			},
			["BuffButton5"] = {
				["name"] = "BuffButton5",
			},
			["BuffButton21"] = {
				["name"] = "BuffButton21",
			},
			["TempEnchant1"] = {
				["name"] = "Weapon Buff 1",
			},
			["BuffButton8"] = {
				["name"] = "BuffButton8",
			},
			["BuffButton6"] = {
				["name"] = "BuffButton6",
			},
			["BuffFrame"] = {
				["name"] = "BuffFrame",
			},
			["BuffButton20"] = {
				["name"] = "BuffButton20",
			},
			["BuffButton2"] = {
				["name"] = "BuffButton2",
			},
			["BuffButton18"] = {
				["name"] = "BuffButton18",
			},
			["BuffButton17"] = {
				["name"] = "BuffButton17",
			},
			["TempEnchant2"] = {
				["Location"] = {
					["point"] = "TOP",
					["y"] = 0,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "TempEnchant1",
					["to"] = "BOTTOM",
					["use"] = 1,
				},
				["name"] = "Weapon Buff 2",
			},
			["BuffButton12"] = {
				["name"] = "BuffButton12",
			},
			["BuffButton3"] = {
				["name"] = "BuffButton3",
			},
			["BuffButton10"] = {
				["name"] = "BuffButton10",
			},
			["BuffButton4"] = {
				["name"] = "BuffButton4",
			},
		},
		["Multi Action Bars"] = {
			["MultiBarLeftButton5"] = {
				["name"] = "MultiBarLeftButton5",
			},
			["MultiBarBottomLeft"] = {
				["name"] = "MultiBarBottomLeft",
			},
			["MultiBarBottomRightButton4"] = {
				["name"] = "MultiBarBottomRightButton4",
			},
			["MultiBarRightButton10"] = {
				["name"] = "MultiBarRightButton10",
			},
			["MultiBarBottomLeftButton1"] = {
				["name"] = "MultiBarBottomLeftButton1",
			},
			["MultiBarBottomRightButton6"] = {
				["name"] = "MultiBarBottomRightButton6",
			},
			["MultiBarBottomRightButton2"] = {
				["name"] = "MultiBarBottomRightButton2",
			},
			["MultiBarRightButton9"] = {
				["name"] = "MultiBarRightButton9",
			},
			["MultiBarRightButton5"] = {
				["name"] = "MultiBarRightButton5",
			},
			["MultiBarLeft"] = {
				["name"] = "MultiBarLeft",
			},
			["MultiBarLeftButton8"] = {
				["name"] = "MultiBarLeftButton8",
			},
			["MultiBarRightButton2"] = {
				["name"] = "MultiBarRightButton2",
			},
			["MultiBarBottomRightButton9"] = {
				["name"] = "MultiBarBottomRightButton9",
			},
			["MultiBarBottomLeftButton10"] = {
				["name"] = "MultiBarBottomLeftButton10",
			},
			["MultiBarRightButton3"] = {
				["name"] = "MultiBarRightButton3",
			},
			["MultiBarBottomLeftButton4"] = {
				["name"] = "MultiBarBottomLeftButton4",
			},
			["MultiBarRightButton8"] = {
				["name"] = "MultiBarRightButton8",
			},
			["MultiBarLeftButton7"] = {
				["name"] = "MultiBarLeftButton7",
			},
			["MultiBarBottomRightButton7"] = {
				["name"] = "MultiBarBottomRightButton7",
			},
			["MultiBarLeftButton3"] = {
				["name"] = "MultiBarLeftButton3",
			},
			["MultiBarRight"] = {
				["name"] = "MultiBarRight",
			},
			["MultiBarLeftButton12"] = {
				["name"] = "MultiBarLeftButton12",
			},
			["MultiBarBottomLeftButton9"] = {
				["name"] = "MultiBarBottomLeftButton9",
			},
			["MultiBarLeftButton10"] = {
				["name"] = "MultiBarLeftButton10",
			},
			["MultiBarBottomRightButton5"] = {
				["name"] = "MultiBarBottomRightButton5",
			},
			["MultiBarRightButton7"] = {
				["name"] = "MultiBarRightButton7",
			},
			["MultiBarRightButton11"] = {
				["name"] = "MultiBarRightButton11",
			},
			["MultiBarBottomRightButton3"] = {
				["name"] = "MultiBarBottomRightButton3",
			},
			["MultiBarBottomLeftButton6"] = {
				["name"] = "MultiBarBottomLeftButton6",
			},
			["MultiBarBottomRightButton11"] = {
				["name"] = "MultiBarBottomRightButton11",
			},
			["MultiBarRightButton6"] = {
				["name"] = "MultiBarRightButton6",
			},
			["MultiBarBottomLeftButton11"] = {
				["name"] = "MultiBarBottomLeftButton11",
			},
			["MultiBarBottomLeftButton2"] = {
				["name"] = "MultiBarBottomLeftButton2",
			},
			["MultiBarBottomLeftButton5"] = {
				["name"] = "MultiBarBottomLeftButton5",
			},
			["MultiBarLeftButton6"] = {
				["name"] = "MultiBarLeftButton6",
			},
			["MultiBarRightButton1"] = {
				["name"] = "MultiBarRightButton1",
			},
			["MultiBarLeftButton9"] = {
				["name"] = "MultiBarLeftButton9",
			},
			["MultiBarBottomRightButton10"] = {
				["name"] = "MultiBarBottomRightButton10",
			},
			["MultiBarBottomRightButton1"] = {
				["name"] = "MultiBarBottomRightButton1",
			},
			["MultiBarLeftButton11"] = {
				["name"] = "MultiBarLeftButton11",
			},
			["MultiBarBottomRightButton12"] = {
				["name"] = "MultiBarBottomRightButton12",
			},
			["MultiBarBottomRightButton8"] = {
				["name"] = "MultiBarBottomRightButton8",
			},
			["MultiBarBottomLeftButton3"] = {
				["name"] = "MultiBarBottomLeftButton3",
			},
			["MultiBarRightButton12"] = {
				["name"] = "MultiBarRightButton12",
			},
			["MultiBarLeftButton2"] = {
				["name"] = "MultiBarLeftButton2",
			},
			["MultiBarBottomLeftButton8"] = {
				["name"] = "MultiBarBottomLeftButton8",
			},
			["MultiBarBottomLeftButton12"] = {
				["name"] = "MultiBarBottomLeftButton12",
			},
			["MultiBarRightButton4"] = {
				["name"] = "MultiBarRightButton4",
			},
			["MultiBarBottomRight"] = {
				["name"] = "MultiBarBottomRight",
			},
			["MultiBarLeftButton4"] = {
				["name"] = "MultiBarLeftButton4",
			},
			["MultiBarBottomLeftButton7"] = {
				["name"] = "MultiBarBottomLeftButton7",
			},
			["MultiBarLeftButton1"] = {
				["name"] = "MultiBarLeftButton1",
			},
		},
		["Raid Frames"] = {
			["RaidPullout6"] = {
				["name"] = "RaidPullout6",
			},
			["RaidGroup2"] = {
				["name"] = "RaidGroup2",
			},
			["RaidGroup1"] = {
				["name"] = "RaidGroup1",
			},
			["RaidGroupButton5"] = {
				["name"] = "RaidGroupButton5",
			},
			["RaidGroupButton40"] = {
				["name"] = "RaidGroupButton40",
			},
			["RaidPullout10"] = {
				["name"] = "RaidPullout10",
			},
			["RaidGroupButton22"] = {
				["name"] = "RaidGroupButton22",
			},
			["RaidGroupButton30"] = {
				["name"] = "RaidGroupButton30",
			},
			["RaidGroup8"] = {
				["name"] = "RaidGroup8",
			},
			["RaidPullout3"] = {
				["name"] = "RaidPullout3",
			},
			["RaidGroupButton25"] = {
				["name"] = "RaidGroupButton25",
			},
			["RaidGroupButton6"] = {
				["name"] = "RaidGroupButton6",
			},
			["RaidGroupButton12"] = {
				["name"] = "RaidGroupButton12",
			},
			["RaidGroupButton3"] = {
				["name"] = "RaidGroupButton3",
			},
			["RaidGroupButton23"] = {
				["name"] = "RaidGroupButton23",
			},
			["RaidGroupButton31"] = {
				["name"] = "RaidGroupButton31",
			},
			["RaidGroupButton2"] = {
				["name"] = "RaidGroupButton2",
			},
			["RaidGroupButton37"] = {
				["name"] = "RaidGroupButton37",
			},
			["RaidGroupButton14"] = {
				["name"] = "RaidGroupButton14",
			},
			["RaidGroupButton8"] = {
				["name"] = "RaidGroupButton8",
			},
			["RaidGroupButton13"] = {
				["name"] = "RaidGroupButton13",
			},
			["RaidGroupButton7"] = {
				["name"] = "RaidGroupButton7",
			},
			["RaidGroupButton15"] = {
				["name"] = "RaidGroupButton15",
			},
			["RaidGroupButton20"] = {
				["name"] = "RaidGroupButton20",
			},
			["RaidGroupButton24"] = {
				["name"] = "RaidGroupButton24",
			},
			["RaidGroupButton9"] = {
				["name"] = "RaidGroupButton9",
			},
			["RaidPullout5"] = {
				["name"] = "RaidPullout5",
			},
			["RaidGroupButton1"] = {
				["name"] = "RaidGroupButton1",
			},
			["RaidGroupButton10"] = {
				["name"] = "RaidGroupButton10",
			},
			["RaidGroupButton32"] = {
				["name"] = "RaidGroupButton32",
			},
			["RaidPullout9"] = {
				["name"] = "RaidPullout9",
			},
			["RaidPullout2"] = {
				["name"] = "RaidPullout2",
			},
			["RaidPullout1"] = {
				["name"] = "RaidPullout1",
			},
			["RaidGroupButton39"] = {
				["name"] = "RaidGroupButton39",
			},
			["RaidGroupButton38"] = {
				["name"] = "RaidGroupButton38",
			},
			["RaidGroupButton16"] = {
				["name"] = "RaidGroupButton16",
			},
			["RaidPullout8"] = {
				["name"] = "RaidPullout8",
			},
			["RaidGroupButton18"] = {
				["name"] = "RaidGroupButton18",
			},
			["RaidGroupButton28"] = {
				["name"] = "RaidGroupButton28",
			},
			["RaidGroupButton19"] = {
				["name"] = "RaidGroupButton19",
			},
			["RaidGroupButton35"] = {
				["name"] = "RaidGroupButton35",
			},
			["RaidGroupButton34"] = {
				["name"] = "RaidGroupButton34",
			},
			["RaidGroupButton17"] = {
				["name"] = "RaidGroupButton17",
			},
			["RaidGroupButton33"] = {
				["name"] = "RaidGroupButton33",
			},
			["RaidGroupButton29"] = {
				["name"] = "RaidGroupButton29",
			},
			["RaidGroup5"] = {
				["name"] = "RaidGroup5",
			},
			["RaidGroupButton11"] = {
				["name"] = "RaidGroupButton11",
			},
			["RaidGroupButton4"] = {
				["name"] = "RaidGroupButton4",
			},
			["RaidGroup3"] = {
				["name"] = "RaidGroup3",
			},
			["RaidGroupButton27"] = {
				["name"] = "RaidGroupButton27",
			},
			["RaidGroupButton26"] = {
				["name"] = "RaidGroupButton26",
			},
			["RaidPullout11"] = {
				["name"] = "RaidPullout11",
			},
			["RaidGroup4"] = {
				["name"] = "RaidGroup4",
			},
			["RaidGroupButton36"] = {
				["name"] = "RaidGroupButton36",
			},
			["RaidGroupButton21"] = {
				["name"] = "RaidGroupButton21",
			},
			["RaidPullout7"] = {
				["name"] = "RaidPullout7",
			},
			["RaidPullout4"] = {
				["name"] = "RaidPullout4",
			},
			["RaidPullout12"] = {
				["name"] = "RaidPullout12",
			},
			["RaidGroup6"] = {
				["name"] = "RaidGroup6",
			},
			["RaidGroup7"] = {
				["name"] = "RaidGroup7",
			},
		},
		["Quests"] = {
			["QuestTimerFrame"] = {
				["Location"] = {
					["to"] = "TOPRIGHT",
					["y"] = -25,
					["x"] = 5,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "TOPRIGHT",
					["use"] = 1,
				},
				["name"] = "QuestTimerFrame",
			},
			["QuestWatchLine30"] = {
				["name"] = "QuestWatchLine30",
			},
			["QuestWatchLine21"] = {
				["name"] = "QuestWatchLine21",
			},
			["QuestWatchLine28"] = {
				["name"] = "QuestWatchLine28",
			},
			["QuestWatchLine2"] = {
				["name"] = "QuestWatchLine2",
			},
			["QuestWatchLine15"] = {
				["name"] = "QuestWatchLine15",
			},
			["QuestWatchLine13"] = {
				["name"] = "QuestWatchLine13",
			},
			["QuestWatchLine1"] = {
				["name"] = "QuestWatchLine1",
			},
			["QuestWatchLine29"] = {
				["name"] = "QuestWatchLine29",
			},
			["QuestWatchLine5"] = {
				["name"] = "QuestWatchLine5",
			},
			["QuestWatchLine20"] = {
				["name"] = "QuestWatchLine20",
			},
			["QuestWatchLine17"] = {
				["name"] = "QuestWatchLine17",
			},
			["QuestWatchFrame"] = {
				["name"] = "QuestWatchFrame",
			},
			["QuestWatchLine10"] = {
				["name"] = "QuestWatchLine10",
			},
			["QuestWatchLine8"] = {
				["name"] = "QuestWatchLine8",
			},
			["QuestWatchLine26"] = {
				["name"] = "QuestWatchLine26",
			},
			["QuestWatchLine23"] = {
				["name"] = "QuestWatchLine23",
			},
			["QuestWatchLine3"] = {
				["name"] = "QuestWatchLine3",
			},
			["QuestWatchLine19"] = {
				["name"] = "QuestWatchLine19",
			},
			["QuestWatchLine9"] = {
				["name"] = "QuestWatchLine9",
			},
			["QuestWatchLine7"] = {
				["name"] = "QuestWatchLine7",
			},
			["QuestWatchLine6"] = {
				["name"] = "QuestWatchLine6",
			},
			["QuestWatchLine18"] = {
				["name"] = "QuestWatchLine18",
			},
			["QuestWatchLine12"] = {
				["name"] = "QuestWatchLine12",
			},
			["QuestWatchLine22"] = {
				["name"] = "QuestWatchLine22",
			},
			["QuestWatchLine27"] = {
				["name"] = "QuestWatchLine27",
			},
			["QuestWatchLine25"] = {
				["name"] = "QuestWatchLine25",
			},
			["QuestWatchLine24"] = {
				["name"] = "QuestWatchLine24",
			},
			["QuestWatchLine14"] = {
				["name"] = "QuestWatchLine14",
			},
			["QuestWatchLine11"] = {
				["name"] = "QuestWatchLine11",
			},
			["QuestWatchLine16"] = {
				["name"] = "QuestWatchLine16",
			},
			["QuestWatchLine4"] = {
				["name"] = "QuestWatchLine4",
			},
		},
		["Main Menu Bar"] = {
			["MainMenuMicroButton"] = {
				["name"] = "MainMenuMicroButton",
			},
			["MainMenuBarPerformanceBarFrameButton"] = {
				["name"] = "MainMenuBarPerformanceBarFrameButton",
			},
			["MainMenuBarExpText"] = {
				["name"] = "MainMenuBarExpText",
			},
			["CharacterBag1Slot"] = {
				["name"] = "CharacterBag1Slot",
			},
			["MainMenuBarTexture2"] = {
				["name"] = "MainMenuBarTexture2",
			},
			["ActionBarDownButton"] = {
				["name"] = "ActionBarDownButton",
			},
			["MainMenuBar"] = {
				["name"] = "MainMenuBar",
			},
			["SocialsMicroButton"] = {
				["name"] = "SocialsMicroButton",
			},
			["MainMenuBarOverlayFrame"] = {
				["name"] = "MainMenuBarOverlayFrame",
			},
			["TalentMicroButton"] = {
				["name"] = "TalentMicroButton",
			},
			["CharacterBag3Slot"] = {
				["name"] = "CharacterBag3Slot",
			},
			["SpellbookMicroButton"] = {
				["name"] = "SpellbookMicroButton",
			},
			["WorldMapMicroButton"] = {
				["name"] = "WorldMapMicroButton",
			},
			["MainMenuBarPageNumber"] = {
				["name"] = "MainMenuBarPageNumber",
			},
			["ExhaustionTickHighlight"] = {
				["name"] = "ExhaustionTickHighlight",
			},
			["MainMenuBarLeftEndCap"] = {
				["name"] = "MainMenuBarLeftEndCap",
			},
			["QuestLogMicroButton"] = {
				["name"] = "QuestLogMicroButton",
			},
			["MainMenuBarTexture0"] = {
				["name"] = "MainMenuBarTexture0",
			},
			["HelpMicroButton"] = {
				["name"] = "HelpMicroButton",
			},
			["CharacterBag0Slot"] = {
				["name"] = "CharacterBag0Slot",
			},
			["MainMenuExpBar"] = {
				["name"] = "MainMenuExpBar",
			},
			["CharacterBag2Slot"] = {
				["name"] = "CharacterBag2Slot",
			},
			["MainMenuBarPerformanceBar"] = {
				["name"] = "MainMenuBarPerformanceBar",
			},
			["ExhaustionLevelFillBar"] = {
				["name"] = "ExhaustionLevelFillBar",
			},
			["ExhaustionTick"] = {
				["name"] = "ExhaustionTick",
			},
			["MainMenuBarArtFrame"] = {
				["name"] = "MainMenuBarArtFrame",
			},
			["ActionBarUpButton"] = {
				["name"] = "ActionBarUpButton",
			},
			["MainMenuBarTexture3"] = {
				["name"] = "MainMenuBarTexture3",
			},
			["CharacterMicroButton"] = {
				["name"] = "CharacterMicroButton",
			},
			["MainMenuBarPerformanceBarFrame"] = {
				["name"] = "MainMenuBarPerformanceBarFrame",
			},
			["MainMenuBarTexture1"] = {
				["name"] = "MainMenuBarTexture1",
			},
			["ExhaustionTickNormal"] = {
				["name"] = "ExhaustionTickNormal",
			},
			["MainMenuBarRightEndCap"] = {
				["name"] = "MainMenuBarRightEndCap",
			},
			["MainMenuBarBackpackButton"] = {
				["name"] = "MainMenuBarBackpackButton",
			},
		},
		["Panels"] = {
			["QuestLogFrame"] = {
				["name"] = "QuestLogFrame",
			},
			["SkillFrame"] = {
				["name"] = "SkillFrame",
			},
			["PetPaperDollFrame"] = {
				["name"] = "PetPaperDollFrame",
			},
			["BankFrame"] = {
				["name"] = "BankFrame",
			},
			["ReputationFrame"] = {
				["name"] = "ReputationFrame",
			},
			["CharacterFrame"] = {
				["Location"] = {
					["y"] = -22,
					["x"] = 319,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "CharacterFrame",
			},
			["MailFrame"] = {
				["name"] = "MailFrame",
			},
			["GuildRegistrarFrame"] = {
				["name"] = "GuildRegistrarFrame",
			},
			["MacroFrame"] = {
				["name"] = "MacroFrame",
			},
			["ItemTextFrame"] = {
				["name"] = "ItemTextFrame",
			},
			["FriendsFrame"] = {
				["name"] = "FriendsFrame",
			},
			["GossipFrame"] = {
				["name"] = "GossipFrame",
			},
			["InspectFrame"] = {
				["name"] = "InspectFrame",
			},
			["TradeSkillFrame"] = {
				["name"] = "TradeSkillFrame",
			},
			["MerchantFrame"] = {
				["name"] = "MerchantFrame",
			},
			["PetitionFrame"] = {
				["name"] = "PetitionFrame",
			},
			["DressUpFrame"] = {
				["Location"] = {
					["point"] = "TOPLEFT",
					["y"] = -387,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "DressUpFrame",
			},
			["WorldMapFrame"] = {
				["name"] = "WorldMapFrame",
			},
			["HonorFrame"] = {
				["name"] = "HonorFrame",
			},
			["TaxiFrame"] = {
				["name"] = "TaxiFrame",
			},
			["SpellBookFrame"] = {
				["name"] = "SpellBookFrame",
			},
			["RaidFrame"] = {
				["name"] = "RaidFrame",
			},
			["TabardFrame"] = {
				["name"] = "TabardFrame",
			},
			["CraftFrame"] = {
				["name"] = "CraftFrame",
			},
			["TalentFrame"] = {
				["name"] = "TalentFrame",
			},
			["QuestFrame"] = {
				["name"] = "QuestFrame",
			},
			["TradeFrame"] = {
				["name"] = "TradeFrame",
			},
			["PaperDollFrame"] = {
				["name"] = "PaperDollFrame",
			},
			["HelpFrame"] = {
				["name"] = "HelpFrame",
			},
		},
		["_MinimapButtons"] = {
			["MazzleUI_OptionsButton"] = {
				[5] = {
					[1] = 12,
				},
				[6] = {
					[1] = 1,
				},
				["name"] = "MazzleUI_OptionsButton",
				["Location"] = {
					["point"] = "BOTTOMRIGHT",
					["y"] = 183,
					["x"] = -14,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 12,
				},
				[1] = {
					[1] = "UIParent",
				},
			},
			["CECBMiniMapButton"] = {
				[6] = {
					[1] = 0.98,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "CECBMiniMapButton",
				["Location"] = {
					["point"] = "RIGHT",
					["y"] = 0,
					["x"] = 5,
					["lock"] = 1,
					["frame"] = "ChatmanagerMenuButtonFrame",
					["to"] = "LEFT",
					["use"] = 1,
				},
			},
			["ChatmanagerMenuButtonFrame"] = {
				[5] = {
					[1] = 30,
				},
				[6] = {
					[1] = 1.08,
					["use"] = 1,
				},
				["name"] = "ChatmanagerMenuButtonFrame",
				["Location"] = {
					["point"] = "RIGHT",
					["y"] = 1,
					["x"] = 3,
					["lock"] = 1,
					["frame"] = "MazzleUI_OptionsButton",
					["to"] = "LEFT",
					["use"] = 1,
				},
				[4] = {
					[1] = 30,
				},
			},
			["IEFMinimapButton"] = {
				["name"] = "IEFMinimapButton",
				["Location"] = {
					["point"] = "RIGHT",
					["y"] = -1,
					["x"] = 2,
					["lock"] = 1,
					["frame"] = "MazzleUI_RecapButton",
					["to"] = "LEFT",
					["use"] = 1,
				},
				[3] = {
					[1] = -1,
				},
			},
			["SW_IconFrame_Button"] = {
				["name"] = "SW_IconFrame_Button",
				["forceHide"] = 1,
			},
			["ItemRack_IconFrame"] = {
				["forceHide"] = 1,
				["name"] = "ItemRack_IconFrame",
			},
			["MazzleUI_FastCastButton"] = {
				[1] = {
					[1] = "UIParent",
				},
				[4] = {
					[1] = 16,
				},
				[5] = {
					[1] = 23,
				},
				[6] = {
					[1] = 0.8909999999999999,
				},
				["Location"] = {
					["to"] = "LEFT",
					["y"] = 0,
					["x"] = 1,
					["lock"] = 1,
					["frame"] = "ChatmanagerMenuButtonFrame",
					["point"] = "RIGHT",
					["use"] = 1,
				},
				["name"] = "MazzleUI_FastCastButton",
			},
			["TrinketMenu_IconFrame"] = {
				[1] = {
					[1] = "UIParent",
					["use"] = 1,
				},
				["Location"] = {
					["point"] = "LEFT",
					["y"] = -2,
					["x"] = -1,
					["lock"] = 1,
					["frame"] = "TrinketMenu_MainFrame",
					["to"] = "RIGHT",
					["use"] = 1,
				},
				["name"] = "TrinketMenu_IconFrame",
			},
			["MazzleUI_EfficiencyButton"] = {
				[1] = {
					[1] = "UIParent",
				},
				[4] = {
					[1] = 16,
				},
				[5] = {
					[1] = 23,
				},
				[6] = {
					[1] = 0.8909999999999999,
				},
				["Location"] = {
					["to"] = "LEFT",
					["y"] = 0,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "MazzleUI_FastCastButton",
					["point"] = "RIGHT",
					["use"] = 1,
				},
				["name"] = "MazzleUI_EfficiencyButton",
			},
			["BookOfTracksFrame"] = {
				[1] = {
					[1] = "UIParent",
					["use"] = 1,
				},
				[6] = {
					[1] = 0.816,
					["lock"] = 1,
					["use"] = 1,
				},
				["name"] = "BookOfTracksFrame",
				["Location"] = {
					["y"] = -15.33,
					["x"] = 7.96,
					["to"] = "TOPRIGHT",
					["frame"] = "Minimap",
					["point"] = "LEFT",
					["use"] = 1,
				},
			},
			["MazzleUI_RecapButton"] = {
				[1] = {
					[1] = "UIParent",
				},
				[4] = {
					[1] = 16,
				},
				[5] = {
					[1] = 23,
				},
				[6] = {
					[1] = 0.8909999999999999,
				},
				["Location"] = {
					["to"] = "LEFT",
					["y"] = 0,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "MazzleUI_EfficiencyButton",
					["point"] = "RIGHT",
					["use"] = 1,
				},
				["name"] = "MazzleUI_RecapButton",
			},
		},
		["_Raiding"] = {
			["BigWigsBarAnchor"] = {
				["Location"] = {
					["y"] = 481,
					["x"] = 0,
					["point"] = "BOTTOM",
					["frame"] = "UIParent",
					["to"] = "BOTTOM",
					["use"] = 1,
				},
				["name"] = "BigWigsBarsAnchorFrame",
			},
			["FuBarPluginBig WigsFrameMinimapButton"] = {
				["Location"] = {
					["y"] = -1,
					["x"] = -2,
					["point"] = "RIGHT",
					["frame"] = "MazzleUI_RecapButton",
					["to"] = "LEFT",
					["use"] = 1,
				},
				["name"] = "FuBarPluginBig WigsFrameMinimapButton",
			},
			["DamageMetersFrame"] = {
				["Location"] = {
					["point"] = "BOTTOMRIGHT",
					["y"] = 742,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "DamageMetersFrame",
			},
			["oRAResurrectionFrame"] = {
				["Location"] = {
					["y"] = -24,
					["x"] = 24,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "oRAResurrectionFrame",
			},
			["SW_BarFrame1"] = {
				["Location"] = {
					["to"] = "BOTTOMRIGHT",
					["y"] = 742,
					["x"] = 1,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "SW_BarFrame1",
			},
			["oRA_MainTankFrameMtMain"] = {
				["Location"] = {
					["to"] = "BOTTOMRIGHT",
					["y"] = 160,
					["x"] = -136,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "oRA_MainTankFrameMtMain",
			},
			["XRSFrame"] = {
				["Location"] = {
					["y"] = -31,
					["x"] = 0,
					["point"] = "TOPRIGHT",
					["frame"] = "UIParent",
					["to"] = "TOPRIGHT",
					["use"] = 1,
				},
				["name"] = "XRSFrame",
			},
		},
		["Miscellaneous"] = {
			["StatsFrame"] = {
				["name"] = "StatsFrame",
			},
			["TutorialFrame"] = {
				["name"] = "TutorialFrame",
			},
			["StackSplitFrame"] = {
				["name"] = "StackSplitFrame",
			},
		},
		["Mirror Timers"] = {
			["MirrorTimer1"] = {
				["name"] = "MirrorTimer1",
			},
			["MirrorTimer3"] = {
				["name"] = "MirrorTimer3",
			},
			["MirrorTimer2"] = {
				["name"] = "MirrorTimer2",
			},
		},
		["Zone Text"] = {
			["ZoneTextString"] = {
				["name"] = "ZoneTextString",
			},
			["AutoFollowStatus"] = {
				["name"] = "AutoFollowStatus",
			},
			["SubZoneTextString"] = {
				["name"] = "SubZoneTextString",
			},
			["AutoFollowStatusText"] = {
				["name"] = "AutoFollowStatusText",
			},
			["ZoneTextFrame"] = {
				["name"] = "ZoneTextFrame",
			},
			["SubZoneTextFrame"] = {
				["name"] = "SubZoneTextFrame",
			},
			["PVPArenaTextString"] = {
				["name"] = "PVPArenaTextString",
			},
			["PVPInfoTextString"] = {
				["name"] = "PVPInfoTextString",
			},
		},
		["Options"] = {
			["UIOptionsFrame"] = {
				["name"] = "UIOptionsFrame",
			},
			["SoundOptionsFrame"] = {
				["name"] = "SoundOptionsFrame",
			},
			["GameMenuFrame"] = {
				["name"] = "GameMenuFrame",
			},
			["OptionsFrame"] = {
				["name"] = "OptionsFrame",
			},
		},
		["Pet Action Bar"] = {
			["PetActionButton9"] = {
				["name"] = "PetActionButton9",
			},
			["PetActionButton3"] = {
				["name"] = "PetActionButton3",
			},
			["PetActionButton6"] = {
				["name"] = "PetActionButton6",
			},
			["PetActionButton2"] = {
				["name"] = "PetActionButton2",
			},
			["PetActionButton10"] = {
				["name"] = "PetActionButton10",
			},
			["PetActionButton8"] = {
				["name"] = "PetActionButton8",
			},
			["PetActionButton4"] = {
				["name"] = "PetActionButton4",
			},
			["PetActionBarFrame"] = {
				["name"] = "PetActionBarFrame",
			},
			["PetActionButton7"] = {
				["name"] = "PetActionButton7",
			},
			["PetActionButton5"] = {
				["name"] = "PetActionButton5",
			},
			["PetActionButton1"] = {
				["name"] = "PetActionButton1",
			},
		},
		["Container Frames"] = {
			["ContainerFrame4"] = {
				["name"] = "ContainerFrame4",
			},
			["ContainerFrame1"] = {
				["name"] = "ContainerFrame1",
			},
			["ContainerFrame6"] = {
				["name"] = "ContainerFrame6",
			},
			["ContainerFrame17"] = {
				["name"] = "ContainerFrame17",
			},
			["ContainerFrame13"] = {
				["name"] = "ContainerFrame13",
			},
			["ContainerFrame8"] = {
				["name"] = "ContainerFrame8",
			},
			["ContainerFrame2"] = {
				["name"] = "ContainerFrame2",
			},
			["ContainerFrame16"] = {
				["name"] = "ContainerFrame16",
			},
			["ContainerFrame9"] = {
				["name"] = "ContainerFrame9",
			},
			["ContainerFrame12"] = {
				["name"] = "ContainerFrame12",
			},
			["ContainerFrame11"] = {
				["name"] = "ContainerFrame11",
			},
			["ContainerFrame5"] = {
				["name"] = "ContainerFrame5",
			},
			["ContainerFrame14"] = {
				["name"] = "ContainerFrame14",
			},
			["ContainerFrame15"] = {
				["name"] = "ContainerFrame15",
			},
			["ContainerFrame7"] = {
				["name"] = "ContainerFrame7",
			},
			["ContainerFrame3"] = {
				["name"] = "ContainerFrame3",
			},
			["ContainerFrame10"] = {
				["name"] = "ContainerFrame10",
			},
		},
		["Battlefield"] = {
			["BattlefieldMinimapParty3"] = {
				["name"] = "BattlefieldMinimapParty3",
			},
			["BattlefieldMinimapPOI17"] = {
				["name"] = "BattlefieldMinimapPOI17",
			},
			["WorldStateScoreFrame"] = {
				["name"] = "WorldStateScoreFrame",
			},
			["BattlefieldMinimapPOI16"] = {
				["name"] = "BattlefieldMinimapPOI16",
			},
			["BattlefieldMinimapRaid36"] = {
				["name"] = "BattlefieldMinimapRaid36",
			},
			["BattlefieldMinimapRaid29"] = {
				["name"] = "BattlefieldMinimapRaid29",
			},
			["BattlefieldMinimapPOI21"] = {
				["name"] = "BattlefieldMinimapPOI21",
			},
			["BattlefieldMinimapRaid35"] = {
				["name"] = "BattlefieldMinimapRaid35",
			},
			["BattlefieldMinimapRaid26"] = {
				["name"] = "BattlefieldMinimapRaid26",
			},
			["BattlefieldMinimapRaid16"] = {
				["name"] = "BattlefieldMinimapRaid16",
			},
			["BattlefieldMinimapRaid33"] = {
				["name"] = "BattlefieldMinimapRaid33",
			},
			["WorldStateAlwaysUpFrame"] = {
				["name"] = "WorldStateAlwaysUpFrame",
			},
			["BattlefieldMinimapPOI5"] = {
				["name"] = "BattlefieldMinimapPOI5",
			},
			["BattlefieldMinimapPOI11"] = {
				["name"] = "BattlefieldMinimapPOI11",
			},
			["BattlefieldMinimapRaid10"] = {
				["name"] = "BattlefieldMinimapRaid10",
			},
			["BattlefieldMinimapCorpse"] = {
				["name"] = "BattlefieldMinimapCorpse",
			},
			["BattlefieldMinimapRaid27"] = {
				["name"] = "BattlefieldMinimapRaid27",
			},
			["BattlefieldMinimapRaid17"] = {
				["name"] = "BattlefieldMinimapRaid17",
			},
			["BattlefieldMinimapPOI28"] = {
				["name"] = "BattlefieldMinimapPOI28",
			},
			["BattlefieldFrame"] = {
				["Location"] = {
					["y"] = 0,
					["x"] = 0,
					["point"] = "CENTER",
					["frame"] = "UIParent",
					["to"] = "CENTER",
				},
				["name"] = "BattlefieldFrame",
			},
			["BattlefieldMinimapRaid31"] = {
				["name"] = "BattlefieldMinimapRaid31",
			},
			["BattlefieldMinimapPOI15"] = {
				["name"] = "BattlefieldMinimapPOI15",
			},
			["BattlefieldMinimapRaid9"] = {
				["name"] = "BattlefieldMinimapRaid9",
			},
			["BattlefieldMinimapParty4"] = {
				["name"] = "BattlefieldMinimapParty4",
			},
			["BattlefieldMinimapRaid24"] = {
				["name"] = "BattlefieldMinimapRaid24",
			},
			["BattlefieldMinimapRaid38"] = {
				["name"] = "BattlefieldMinimapRaid38",
			},
			["BattlefieldMinimapRaid32"] = {
				["name"] = "BattlefieldMinimapRaid32",
			},
			["BattlefieldMinimapRaid34"] = {
				["name"] = "BattlefieldMinimapRaid34",
			},
			["BattlefieldMinimap"] = {
				["Location"] = {
					["y"] = -5,
					["x"] = 0,
					["point"] = "CENTER",
					["frame"] = "BattlefieldMinimapTab",
					["to"] = "CENTER",
				},
				["name"] = "BattlefieldMinimap",
			},
			["BattlefieldMinimapRaid21"] = {
				["name"] = "BattlefieldMinimapRaid21",
			},
			["BattlefieldMinimapRaid39"] = {
				["name"] = "BattlefieldMinimapRaid39",
			},
			["BattlefieldMinimapParty1"] = {
				["name"] = "BattlefieldMinimapParty1",
			},
			["BattlefieldMinimapPOI20"] = {
				["name"] = "BattlefieldMinimapPOI20",
			},
			["BattlefieldMinimapPOI8"] = {
				["name"] = "BattlefieldMinimapPOI8",
			},
			["BattlefieldMinimapRaid3"] = {
				["name"] = "BattlefieldMinimapRaid3",
			},
			["BattlefieldMinimapPOI26"] = {
				["name"] = "BattlefieldMinimapPOI26",
			},
			["BattlefieldMinimapRaid22"] = {
				["name"] = "BattlefieldMinimapRaid22",
			},
			["BattlefieldMinimapRaid19"] = {
				["name"] = "BattlefieldMinimapRaid19",
			},
			["BattlefieldMinimapRaid13"] = {
				["name"] = "BattlefieldMinimapRaid13",
			},
			["BattlefieldMinimapRaid18"] = {
				["name"] = "BattlefieldMinimapRaid18",
			},
			["BattlefieldMinimapRaid23"] = {
				["name"] = "BattlefieldMinimapRaid23",
			},
			["BattlefieldMinimapRaid12"] = {
				["name"] = "BattlefieldMinimapRaid12",
			},
			["BattlefieldMinimapPOI7"] = {
				["name"] = "BattlefieldMinimapPOI7",
			},
			["BattlefieldMinimapRaid25"] = {
				["name"] = "BattlefieldMinimapRaid25",
			},
			["BattlefieldMinimapPOI24"] = {
				["name"] = "BattlefieldMinimapPOI24",
			},
			["BattlefieldMinimapPOI27"] = {
				["name"] = "BattlefieldMinimapPOI27",
			},
			["BattlefieldMinimapFlag2"] = {
				["name"] = "BattlefieldMinimapFlag2",
			},
			["BattlefieldMinimapRaid14"] = {
				["name"] = "BattlefieldMinimapRaid14",
			},
			["BattlefieldMinimapPOI18"] = {
				["name"] = "BattlefieldMinimapPOI18",
			},
			["BattlefieldMinimapRaid5"] = {
				["name"] = "BattlefieldMinimapRaid5",
			},
			["BattlefieldMinimapPOI29"] = {
				["name"] = "BattlefieldMinimapPOI29",
			},
			["BattlefieldMinimapRaid1"] = {
				["name"] = "BattlefieldMinimapRaid1",
			},
			["BattlefieldMinimapRaid30"] = {
				["name"] = "BattlefieldMinimapRaid30",
			},
			["BattlefieldMinimapFlag1"] = {
				["name"] = "BattlefieldMinimapFlag1",
			},
			["BattlefieldMinimapRaid8"] = {
				["name"] = "BattlefieldMinimapRaid8",
			},
			["BattlefieldMinimapRaid20"] = {
				["name"] = "BattlefieldMinimapRaid20",
			},
			["BattlefieldMinimapRaid40"] = {
				["name"] = "BattlefieldMinimapRaid40",
			},
			["BattlefieldMinimapPOI1"] = {
				["name"] = "BattlefieldMinimapPOI1",
			},
			["BattlefieldMinimapParty2"] = {
				["name"] = "BattlefieldMinimapParty2",
			},
			["BattlefieldMinimapPOI23"] = {
				["name"] = "BattlefieldMinimapPOI23",
			},
			["BattlefieldMinimapRaid6"] = {
				["name"] = "BattlefieldMinimapRaid6",
			},
			["BattlefieldMinimapPOI19"] = {
				["name"] = "BattlefieldMinimapPOI19",
			},
			["BattlefieldMinimapPOI4"] = {
				["name"] = "BattlefieldMinimapPOI4",
			},
			["BattlefieldMinimapRaid15"] = {
				["name"] = "BattlefieldMinimapRaid15",
			},
			["BattlefieldMinimapRaid28"] = {
				["name"] = "BattlefieldMinimapRaid28",
			},
			["BattlefieldMinimapPOI6"] = {
				["name"] = "BattlefieldMinimapPOI6",
			},
			["BattlefieldMinimapPOI13"] = {
				["name"] = "BattlefieldMinimapPOI13",
			},
			["BattlefieldMinimapRaid2"] = {
				["name"] = "BattlefieldMinimapRaid2",
			},
			["BattlefieldMinimapPOI12"] = {
				["name"] = "BattlefieldMinimapPOI12",
			},
			["BattlefieldMinimapPOI30"] = {
				["name"] = "BattlefieldMinimapPOI30",
			},
			["BattlefieldMinimapPOI10"] = {
				["name"] = "BattlefieldMinimapPOI10",
			},
			["BattlefieldMinimapPOI22"] = {
				["name"] = "BattlefieldMinimapPOI22",
			},
			["BattlefieldMinimapRaid7"] = {
				["name"] = "BattlefieldMinimapRaid7",
			},
			["BattlefieldMinimapCloseButton"] = {
				["name"] = "BattlefieldMinimapCloseButton",
			},
			["BattlefieldMinimapRaid4"] = {
				["name"] = "BattlefieldMinimapRaid4",
			},
			["BattlefieldMinimapRaid37"] = {
				["name"] = "BattlefieldMinimapRaid37",
			},
			["BattlefieldMinimapPOI2"] = {
				["name"] = "BattlefieldMinimapPOI2",
			},
			["BattlefieldMinimapPOI14"] = {
				["name"] = "BattlefieldMinimapPOI14",
			},
			["BattlefieldMinimapPOI3"] = {
				["name"] = "BattlefieldMinimapPOI3",
			},
			["BattlefieldMinimapPOI9"] = {
				["name"] = "BattlefieldMinimapPOI9",
			},
			["BattlefieldMinimapRaid11"] = {
				["name"] = "BattlefieldMinimapRaid11",
			},
			["BattlefieldMinimapPOI25"] = {
				["name"] = "BattlefieldMinimapPOI25",
			},
		},
		["Tooltips"] = {
			["SmallTextTooltip"] = {
				["Location"] = {
					["y"] = 256.17,
					["x"] = 0,
					["to"] = "BOTTOMLEFT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
				},
				["name"] = "SmallTextTooltip",
			},
			["ShoppingTooltip1"] = {
				["name"] = "ShoppingTooltip1",
			},
			["ShoppingTooltip2"] = {
				["name"] = "ShoppingTooltip2",
			},
			["WorldMapTooltip"] = {
				["name"] = "WorldMapTooltip",
			},
			["GameTooltip"] = {
				["Location"] = {
					["y"] = 256.17,
					["x"] = 0,
					["to"] = "BOTTOMLEFT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
				},
				["name"] = "GameTooltip",
			},
			["ItemRefTooltip"] = {
				["Location"] = {
					["to"] = "TOPLEFT",
					["y"] = -115.78,
					["x"] = 39,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "ItemRefTooltip",
			},
		},
		["Target Frame"] = {
			["TargetFrameManaBar"] = {
				["name"] = "TargetFrameManaBar",
			},
			["TargetFrameDebuff8"] = {
				["name"] = "TargetFrameDebuff8",
			},
			["TargetFrameBuff5"] = {
				["name"] = "TargetFrameBuff5",
			},
			["TargetFrameDebuff3"] = {
				["name"] = "TargetFrameDebuff3",
			},
			["TargetFrameBuff1"] = {
				["name"] = "TargetFrameBuff1",
			},
			["TargetFrameDropDown"] = {
				["name"] = "TargetFrameDropDown",
			},
			["TargetFrameDebuff12"] = {
				["name"] = "TargetFrameDebuff12",
			},
			["TargetFrameDropDownButton"] = {
				["name"] = "TargetFrameDropDownButton",
			},
			["TargetFrameDebuff2"] = {
				["name"] = "TargetFrameDebuff2",
			},
			["TargetFrameBuff4"] = {
				["name"] = "TargetFrameBuff4",
			},
			["TargetFrameDebuff11"] = {
				["name"] = "TargetFrameDebuff11",
			},
			["TargetFrameDebuff7"] = {
				["name"] = "TargetFrameDebuff7",
			},
			["TargetFrameBuff3"] = {
				["name"] = "TargetFrameBuff3",
			},
			["TargetFrameDebuff16"] = {
				["name"] = "TargetFrameDebuff16",
			},
			["TargetFrameDebuff6"] = {
				["name"] = "TargetFrameDebuff6",
			},
			["TargetFrameDebuff15"] = {
				["name"] = "TargetFrameDebuff15",
			},
			["TargetFrameDebuff9"] = {
				["name"] = "TargetFrameDebuff9",
			},
			["TargetFrameDebuff14"] = {
				["name"] = "TargetFrameDebuff14",
			},
			["TargetFrameBuff2"] = {
				["name"] = "TargetFrameBuff2",
			},
			["TargetFrame"] = {
				["name"] = "TargetFrame",
			},
			["TargetFrameDebuff5"] = {
				["name"] = "TargetFrameDebuff5",
			},
			["TargetFrameDebuff1"] = {
				["name"] = "TargetFrameDebuff1",
			},
			["TargetFrameDebuff4"] = {
				["name"] = "TargetFrameDebuff4",
			},
			["TargetFrameDebuff10"] = {
				["name"] = "TargetFrameDebuff10",
			},
			["TargetFrameHealthBar"] = {
				["name"] = "TargetFrameHealthBar",
			},
			["TargetFrameDebuff13"] = {
				["name"] = "TargetFrameDebuff13",
			},
		},
		["_Custom"] = {
			["Carni_ECB_1"] = {
				["Location"] = {
					["y"] = 275,
					["x"] = 0,
					["point"] = "BOTTOM",
					["frame"] = "UIParent",
					["to"] = "BOTTOM",
					["use"] = 1,
				},
				["name"] = "Carni_ECB_1",
			},
			["NLHeader"] = {
				["Location"] = {
					["y"] = 237,
					["x"] = -384,
					["to"] = "BOTTOMRIGHT",
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
					["use"] = 1,
				},
				["name"] = "NLHeader",
			},
			["CharactersViewerBankFrame"] = {
				["Location"] = {
					["to"] = "BOTTOMLEFT",
					["y"] = 150,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
					["use"] = 1,
				},
				["name"] = "CharactersViewerBankFrame",
			},
			["MkQL_Main_Frame"] = {
				["name"] = "MkQL_Main_Frame",
				[28] = {
					[1] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					[2] = 0,
					["use"] = 1,
				},
				["Location"] = {
					["y"] = 0,
					["x"] = 0,
					["to"] = "TOPRIGHT",
					["lock"] = 1,
					["frame"] = "MonkeyQuestFrame",
					["point"] = "TOPLEFT",
				},
				[27] = {
					[1] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					[2] = 0.7,
					["use"] = 1,
				},
			},
			["AnswerFrame"] = {
				[6] = {
					[1] = 3,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "AnswerFrame",
				["Location"] = {
					["point"] = "CENTER",
					["y"] = 100,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "CENTER",
					["use"] = 1,
				},
			},
			["ItemRack_InvFrame"] = {
				["Location"] = {
					["y"] = 275,
					["x"] = 7,
					["point"] = "BOTTOMRIGHT",
					["frame"] = "UIParent",
					["to"] = "BOTTOMRIGHT",
					["use"] = 1,
				},
				["name"] = "ItemRack_InvFrame",
			},
			["WitchHunt_DragButton"] = {
				["Location"] = {
					["point"] = "TOP",
					["y"] = -67,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "TOP",
					["use"] = 1,
				},
				["name"] = "WitchHunt_DragButton",
			},
			["InspectorVariableFrame"] = {
				["Location"] = {
					["y"] = -104.85,
					["x"] = 949.04,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "InspectorVariableFrame",
			},
			["gvalley_main"] = {
				[6] = {
					[1] = 1.204,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "gvalley_main",
				["Location"] = {
					["y"] = 6,
					["x"] = 0,
					["point"] = "LEFT",
					["frame"] = "UIParent",
					["to"] = "LEFT",
					["use"] = 1,
				},
			},
			["EasyCopy_core"] = {
				[2] = {
					[1] = "HIGH",
					["use"] = 1,
				},
				[4] = {
					[1] = 34,
					["use"] = 1,
					["lock"] = 1,
				},
				[5] = {
					[1] = 390,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "EasyCopy_core",
				[64] = {
				},
				[18] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIChatBoxBackground",
					[2] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUIChatBoxBorder",
					[4] = 32,
					[5] = 22.9,
					[6] = 0,
					[7] = 0,
					[8] = 0,
					[9] = 0,
					["use"] = 1,
					["lock"] = 1,
				},
				["Location"] = {
					["point"] = "BOTTOM",
					["y"] = -6,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "ChatFrameEditBox",
					["to"] = "TOP",
					["use"] = 1,
				},
			},
			["CharactersViewer_Frame"] = {
				["Location"] = {
					["to"] = "TOPLEFT",
					["y"] = -24,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "CharactersViewer_Frame",
			},
			["SpecialTalentFrame"] = {
				[6] = {
					[1] = 1.5,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "SpecialTalentFrame",
				["Location"] = {
					["point"] = "TOP",
					["y"] = -50,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "UIParent",
					["to"] = "TOP",
					["use"] = 1,
				},
			},
			["SuperInspectFrame"] = {
				["Location"] = {
					["to"] = "TOPLEFT",
					["y"] = -28,
					["x"] = 725,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "SuperInspectFrame",
			},
			["TinyPadFrame"] = {
				[5] = {
					[1] = 500,
					["use"] = 1,
				},
				["name"] = "TinyPadFrame",
				["Location"] = {
					["to"] = "BOTTOMLEFT",
					["y"] = 234,
					["x"] = 382,
					["lock"] = 1,
					["frame"] = "UIParent",
					["point"] = "BOTTOMLEFT",
					["use"] = 1,
				},
				[4] = {
					[1] = 500,
					["use"] = 1,
				},
			},
			["RecapFrame"] = {
				["Location"] = {
					["y"] = -20,
					["x"] = -35,
					["point"] = "TOPRIGHT",
					["frame"] = "UIParent",
					["to"] = "TOPRIGHT",
					["use"] = 1,
				},
				["name"] = "RecapFrame",
			},
			["TrinketMenu_MainFrame"] = {
				[6] = {
					[1] = 0.88,
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "TrinketMenu_MainFrame",
				["Location"] = {
					["to"] = "TOPLEFT",
					["y"] = 7,
					["x"] = -2,
					["lock"] = 1,
					["frame"] = "ChatFrame6",
					["point"] = "BOTTOMLEFT",
					["use"] = 1,
				},
			},
			["FlightMapTimesFrame"] = {
				["Location"] = {
					["to"] = "TOP",
					["y"] = -75,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "DART_Texture_5",
					["point"] = "BOTTOM",
					["use"] = 1,
				},
				["name"] = "FlightMapTimesFrame",
			},
		},
		["Action Bar"] = {
			["ActionButton9"] = {
				["name"] = "ActionButton9",
			},
			["ActionButton5"] = {
				["name"] = "ActionButton5",
			},
			["ActionButton2"] = {
				["name"] = "ActionButton2",
			},
			["ActionButton6"] = {
				["name"] = "ActionButton6",
			},
			["ActionButton7"] = {
				["name"] = "ActionButton7",
			},
			["ActionButton12"] = {
				["name"] = "ActionButton12",
			},
			["ActionButton8"] = {
				["name"] = "ActionButton8",
			},
			["ActionButton3"] = {
				["name"] = "ActionButton3",
			},
			["ActionButton4"] = {
				["name"] = "ActionButton4",
			},
			["ActionButton11"] = {
				["name"] = "ActionButton11",
			},
			["ActionButton1"] = {
				["name"] = "ActionButton1",
			},
			["ActionButton10"] = {
				["name"] = "ActionButton10",
			},
		},
		["Casting Bar"] = {
			["CastingBarBorder"] = {
				[7] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUICastingBarBorder",
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "CastingBarBorder",
			},
			["CastingBarFlash"] = {
				[7] = {
					[1] = "Interface\\AddOns\\MazzleUI\\Art\\MazzleUICastingBarFlash",
					["use"] = 1,
					["lock"] = 1,
				},
				["name"] = "CastingBarFlash",
			},
			["CastingBarText"] = {
				["name"] = "CastingBarText",
			},
			["CastingBarSpark"] = {
				["name"] = "CastingBarSpark",
			},
			["CastingBarFrame"] = {
				[2] = {
					[1] = "MEDIUM",
					["lock"] = 1,
					["use"] = 1,
				},
				["Location"] = {
					["point"] = "BOTTOM",
					["y"] = -72,
					["x"] = 0,
					["lock"] = 1,
					["frame"] = "DART_Texture_5",
					["to"] = "TOP",
					["use"] = 1,
				},
				["name"] = "CastingBarFrame",
			},
		},
		["Combo Points"] = {
			["ComboPoint3"] = {
				["name"] = "ComboPoint3",
			},
			["ComboPoint5"] = {
				["name"] = "ComboPoint5",
			},
			["ComboPoint1"] = {
				["name"] = "ComboPoint1",
			},
			["ComboPoint2"] = {
				["name"] = "ComboPoint2",
			},
			["ComboFrame"] = {
				["name"] = "ComboFrame",
			},
			["ComboPoint4"] = {
				["name"] = "ComboPoint4",
			},
		},
		["Pet Frame"] = {
			["PetFrameDropDown"] = {
				["name"] = "PetFrameDropDown",
			},
			["PetDebuff1"] = {
				["name"] = "PetDebuff1",
			},
			["PetFrame"] = {
				["name"] = "PetFrame",
			},
			["PetDebuff2"] = {
				["name"] = "PetDebuff2",
			},
			["PetFrameManaBar"] = {
				["name"] = "PetFrameManaBar",
			},
			["PetFrameHappiness"] = {
				["name"] = "PetFrameHappiness",
			},
			["PetDebuff3"] = {
				["name"] = "PetDebuff3",
			},
			["PetDebuff4"] = {
				["name"] = "PetDebuff4",
			},
			["PetFrameHealthBar"] = {
				["name"] = "PetFrameHealthBar",
			},
			["PetFrameDropDownButton"] = {
				["name"] = "PetFrameDropDownButton",
			},
		},
		["Player Frame"] = {
			["PlayerFrameHealthBar"] = {
				["name"] = "PlayerFrameHealthBar",
			},
			["PlayerFrameDropDownButton"] = {
				["name"] = "PlayerFrameDropDownButton",
			},
			["PlayerFrameGroupIndicator"] = {
				["name"] = "PlayerFrameGroupIndicator",
			},
			["PlayerFrameManaBar"] = {
				["name"] = "PlayerFrameManaBar",
			},
			["PlayerFrameDropDown"] = {
				["name"] = "PlayerFrameDropDown",
			},
			["PlayerFrame"] = {
				["name"] = "PlayerFrame",
			},
		},
		["Loot Frames"] = {
			["GroupLootFrame2"] = {
				["name"] = "GroupLootFrame2",
			},
			["GroupLootFrame4"] = {
				["name"] = "GroupLootFrame4",
			},
			["GroupLootFrame3"] = {
				["name"] = "GroupLootFrame3",
			},
			["GroupLootFrame1"] = {
				["name"] = "GroupLootFrame1",
			},
			["LootFrame"] = {
				["name"] = "LootFrame",
			},
		},
		["_DebugTools"] = {
			["IG_CfgFrame"] = {
				["Location"] = {
					["y"] = -81.2,
					["x"] = 503.9,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "IG_CfgFrame",
			},
			["IG_VarFrame"] = {
				["Location"] = {
					["y"] = -104.2,
					["x"] = 1066.3,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "IG_VarFrame",
			},
			["IG_MainFrame"] = {
				["Location"] = {
					["y"] = -101,
					["x"] = 8,
					["point"] = "TOPLEFT",
					["frame"] = "UIParent",
					["to"] = "TOPLEFT",
					["use"] = 1,
				},
				["name"] = "IG_MainFrame",
			},
			["PhoenixFrame"] = {
				[5] = {
					[1] = 1000,
					["use"] = 1,
				},
				["name"] = "PhoenixFrame",
				["Location"] = {
					["y"] = -33,
					["x"] = -32,
					["point"] = "TOPRIGHT",
					["frame"] = "UIParent",
					["to"] = "TOPRIGHT",
					["use"] = 1,
				},
				[4] = {
					[1] = 800,
					["use"] = 1,
				},
			},
		},
	}
    end
end