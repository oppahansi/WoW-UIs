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

BINDING_HEADER_MAZZ3D = "Mazzlefizz's 3D Characters";
BINDING_NAME_MAZZ3DSAVEMOB = "Save Mob Camera Setting";
BINDING_NAME_MAZZ3DCACHEMOB = "Cache Mob Camera Setting";
BINDING_NAME_MAZZ3DGUESSNEXT = "Guess Camera Setting Next";
BINDING_NAME_MAZZ3DGUESSPREVIOUS = "Guess Camera Setting Previous";
BINDING_NAME_MAZZ3DGUESSNEXTCACHE = "Guess Cached Camera Setting Next";
BINDING_NAME_MAZZ3DGUESSPREVIOUSCACHE = "Guess Cached Camera Setting Previous";
BINDING_NAME_MAZZ3DNEXTABSTRACT = "Next Abstract Model";
BINDING_NAME_MAZZ3DPREVIOUSABSTRACT = "Previous Abstract Model";
BINDING_NAME_MAZZ3DFORCEHUMAN = "Force Humanoid Guess";
BINDING_NAME_MAZZ3DPRINTINFO = "Print Camera Info";

unitDB = {
    ["player"] = {["petname"] = "pet",},
    ["target"] = {},
    ["party1"] = {["petname"] = "partypet1",},
    ["party2"] = {["petname"] = "partypet2",},
    ["party3"] = {["petname"] = "partypet3",},
    ["party4"] = {["petname"] = "partypet4",},
    ["partypet1"] = {},
    ["partypet2"] = {},
    ["partypet3"] = {},
    ["partypet4"] = {},
    ["pet"] = {},
}

animDB = {
    ["Death"] = { ["animNum"] = 1, ["duration"] = 2300, ["nextAnim"] = "Slain", },
    ["Slain"] = { ["animNum"] = 6, ["duration"] = nil, ["nextAnim"] = nil },
    ["Flinch"] = { ["animNum"] = 10, ["duration"] = 700, ["nextAnim"] = nil, },
    ["Flinch2"] = { ["animNum"] = 36, ["duration"] = 350, ["nextAnim"] = nil, },
    ["Wave"] = { ["animNum"] = 67, ["duration"] = 2500, ["nextAnim"] = nil, },
    ["Rude"] = { ["animNum"] = 73, ["duration"] = 2500, ["nextAnim"] = nil, },
    ["Roar"] = { ["animNum"] = 74, ["duration"] = 2500, ["nextAnim"] = nil, },
    ["Kiss"] = { ["animNum"] = 76, ["duration"] = 1400, ["nextAnim"] = nil, },
    ["Chicken"] = { ["animNum"] = 78, ["duration"] = 2800, ["nextAnim"] = nil, },
    ["Flex"] = { ["animNum"] = 82, ["duration"] = 2100, ["nextAnim"] = nil, },
}

Mazz3D_Model_Info = {
    [0] = {
    		["title"] = "Player",
    		["scale"] = {["width"] = 100,["height"] = 100,},
    		["anchor"] = {["anchorParent"] = "DUF_PlayerFrame_TextBox_8",
    			["x"] = -1, ["y"] = 5,},
    		["Character"] = {
    			["unitType"] = "player",
    			["dufparent"] = "DUF_PlayerFrame",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [1] = {
    		["title"] = "Target",
    		["scale"] = {["width"] = 120,["height"] = 120,},
    		["anchor"] = {["anchorParent"] = "DUF_TargetFrame_TextBox_6",
    			["x"] = 0,["y"] = 5,},
    		["Character"] = {
    			["unitType"] = "target",
    			["dufparent"] = "DUF_TargetFrame",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [2] = {
    		["title"] = "Party1",
    		["scale"] = {["width"] = 92,["height"] = 92,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyFrame1_TextBox_10",
    			["x"] = 0,["y"] = 5,},
    		["Character"] = {
    			["unitType"] = "party1",
    			["dufparent"] = "DUF_PartyFrame1",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [3] = {
    		["title"] = "Party2",
    		["scale"] = {["width"] = 92,["height"] = 92,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyFrame2_TextBox_10",
    			["x"] = 0,["y"] = 5,},
    		["Character"] = {
    			["unitType"] = "party2",
    			["dufparent"] = "DUF_PartyFrame2",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [4] = {
    		["title"] = "Party3",
    		["scale"] = {["width"] = 92,["height"] = 92,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyFrame3_TextBox_10",
    			["x"] = 0,["y"] = 5,},
    		["Character"] = {
    			["unitType"] = "party3",
    			["dufparent"] = "DUF_PartyFrame3",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [5] = {
    		["title"] = "Party4",
    		["scale"] = {["width"] = 92,["height"] = 92,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyFrame4_TextBox_10",
    			["x"] = 0,["y"] = 5,},
    		["Character"] = {
    			["unitType"] = "party4",
    			["dufparent"] = "DUF_PartyFrame4",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [6] = {
    		["title"] = "PartyPet1",
    		["scale"] = {["width"] = 85,["height"] = 85,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyPetFrame1_ManaBar",
    			["x"] = 0,["y"] = 24,},
    		["Character"] = {
    			["unitType"] = "partypet1",
    			["dufparent"] = "DUF_PartyPetFrame1",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [7] = {
    		["title"] = "PartyPet2",
    		["scale"] = {["width"] = 85,["height"] = 85,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyPetFrame2_ManaBar",
    			["x"] = 0,["y"] = 24,},
    		["Character"] = {
    			["unitType"] = "partypet2",
    			["dufparent"] = "DUF_PartyPetFrame2",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [8] = {
    		["title"] = "PartyPet3",
    		["scale"] = {["width"] = 85,["height"] = 85,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyPetFrame3_ManaBar",
    			["x"] = 0,["y"] = 24,},
    		["Character"] = {
    			["unitType"] = "partypet3",
    			["dufparent"] = "DUF_PartyPetFrame3",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [9] = {
    		["title"] = "PartyPet4",
    		["scale"] = {["width"] = 85,["height"] = 85,},
    		["anchor"] = {["anchorParent"] = "DUF_PartyPetFrame4_ManaBar",
    			["x"] = 0,["y"] = 24,},
    		["Character"] = {
    			["unitType"] = "partypet4",
    			["dufparent"] = "DUF_PartyPetFrame4",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	},
    },	
    [10] = {
    		["title"] = "PlayerPet",
    		["scale"] = {["width"] = 75,["height"] = 75,},
    		["anchor"] = {["anchorParent"] = "DUF_PetFrame_TextBox_10",
    			["x"] = 0,["y"] = 6,},
    		["Character"] = {
    			["unitType"] = "pet",
    			["dufparent"] = "DUF_PetFrame",
    			["isRendered"] = false,
    			["camera"] = {
            		["scale"] = 1, ["zoom"]  = 0, ["rotation"] = 0,
            		["position"] = { ["panH"] = 0, ["panV"] = 0, },
            	},},
    		["GUI"] = {
        		["isEnabled"] = false, ["active"] = nil, 
        		["LeftButton"]   = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["RightButton"]  = {["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        		["ScrollWheel"]  = {{["NOKEY"] = nil,["ALT"]   = nil,["CTRL"]  = nil,["SHIFT"] = nil,},
        	},
    	}
    }
}

