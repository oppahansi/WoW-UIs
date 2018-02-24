--[[
Functions:
AtlasLoot_DewDropClick(tablename, text, tabletype)
AtlasLoot_DewDropSubMenuClick(tablename, text)
AtlasLoot_DefaultFrame_OnShow()
AtlasLootDefaultFrame_OnHide()
AtlasLoot_DewdropSubMenuRegister(loottable)
AtlasLoot_DewdropRegister()
]]

--Include all needed libraries
local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local BabbleZone = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BabbleFaction = LibStub("LibBabble-Faction-3.0"):GetLookupTable();
local BabbleClass = LibStub("LibBabble-Class-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

--Load the 2 dewdrop menus
AtlasLoot_Dewdrop = AceLibrary("Dewdrop-2.0");
AtlasLoot_DewdropSubMenu = AceLibrary("Dewdrop-2.0");

AtlasLoot_Data["AtlasLootFallback"] = {
    EmptyInstance = {};
};

--[[
AtlasLoot_DewDropClick(tablename, text, tabletype):
tablename - Name of the loot table in the database
text - Heading for the loot table
tabletype - Whether the tablename indexes an actual table or needs to generate a submenu
Called when a button in AtlasLoot_Dewdrop is clicked
]]
function AtlasLoot_DewDropClick(tablename, text, tabletype)
    --Definition of where I want the loot table to be shown
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    
    --If the button clicked was linked to a loot table
    if tabletype == "Table" then
        --Show the loot table
        AtlasLoot_ShowBossLoot(tablename, text, pFrame);
        --Save needed info for fuure re-display of the table
        AtlasLoot.db.profile.LastBoss = tablename;
        AtlasLoot.db.profile.LastBossText = text;
        --Purge the text label for the submenu and disable the submenu
        AtlasLootDefaultFrame_SubMenu:Disable();
        AtlasLootDefaultFrame_SelectedTable:SetText("");
        AtlasLootDefaultFrame_SelectedTable:Show();
    --If the button links to a sub menu definition
    else
        --Enable the submenu button
        AtlasLootDefaultFrame_SubMenu:Enable();
        --Show the first loot table associated with the submenu
        AtlasLoot_ShowBossLoot(AtlasLoot_DewDropDown_SubTables[tablename][1][2], AtlasLoot_DewDropDown_SubTables[tablename][1][1], pFrame);
        --Save needed info for fuure re-display of the table
        AtlasLoot.db.profile.LastBoss = AtlasLoot_DewDropDown_SubTables[tablename][1][2];
        AtlasLoot.db.profile.LastBossText = AtlasLoot_DewDropDown_SubTables[tablename][1][1];
        --Load the correct submenu and associated with the button
        AtlasLoot_DewdropSubMenu:Unregister(AtlasLootDefaultFrame_SubMenu);
        AtlasLoot_DewdropSubMenuRegister(AtlasLoot_DewDropDown_SubTables[tablename]);
        --Show a text label of what has been selected
        AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_DewDropDown_SubTables[tablename][1][1]);
        AtlasLootDefaultFrame_SelectedTable:Show();
    end
    --Show the category that has been selected
    AtlasLootDefaultFrame_SelectedCategory:SetText(text);
    AtlasLootDefaultFrame_SelectedCategory:Show();
    AtlasLoot_Dewdrop:Close(1);
end 

--[[
AtlasLoot_DewDropSubMenuClick(tablename, text):
tablename - Name of the loot table in the database
text - Heading for the loot table
Called when a button in AtlasLoot_DewdropSubMenu is clicked
]]
function AtlasLoot_DewDropSubMenuClick(tablename, text)
    --Definition of where I want the loot table to be shown
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    --Show the select loot table
    AtlasLoot_ShowBossLoot(tablename, text, pFrame);
    --Save needed info for fuure re-display of the table
    AtlasLoot.db.profile.LastBoss = tablename;
    AtlasLoot.db.profile.LastBossText = text;
    --Show the table that has been selected
    AtlasLootDefaultFrame_SelectedTable:SetText(text);
    AtlasLootDefaultFrame_SelectedTable:Show();
    AtlasLoot_DewdropSubMenu:Close(1);
end

--[[
AtlasLootDefaultFrame_OnShow:
Called whenever the loot browser is shown and sets up buttons and loot tables
]]
function AtlasLootDefaultFrame_OnShow()
    --Definition of where I want the loot table to be shown    
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    --Having the Atlas and loot browser frames shown at the same time would
    --cause conflicts, so I hide the Atlas frame when the loot browser appears
    if AtlasFrame then
        AtlasFrame:Hide();
    end
    --Remove the selection of a loot table in Atlas
    AtlasLootItemsFrame.activeBoss = nil;
    --Set the item table to the loot table
    AtlasLoot_SetItemInfoFrame(pFrame);
    --Show the last displayed loot table
    if AtlasLoot_IsLootTableAvailable(AtlasLoot.db.profile.LastBoss) then
        AtlasLoot_ShowBossLoot(AtlasLoot.db.profile.LastBoss, AtlasLoot.db.profile.LastBossText, pFrame);
    else
        AtlasLoot_ShowBossLoot("EmptyInstance", AL["AtlasLoot"], pFrame);
    end
end

--[[
AtlasLootDefaultFrame_OnHide:
When we close the loot browser, re-bind the item table to Atlas
and close all Dewdrop menus
]]
function AtlasLootDefaultFrame_OnHide()
    if AtlasFrame then
        AtlasLoot_SetupForAtlas();
    end
    AtlasLoot_Dewdrop:Close(1);
    AtlasLoot_DewdropSubMenu:Close(1);
end   

--[[
AtlasLoot_DewdropSubMenuRegister(loottable):
loottable - Table defining the sub menu
Generates the sub menu needed by passing a table of loot tables and titles
]]
function AtlasLoot_DewdropSubMenuRegister(loottable)
    AtlasLoot_DewdropSubMenu:Register(AtlasLootDefaultFrame_SubMenu,
        'point', function(parent)
            return "TOP", "BOTTOM"
        end,
        'children', function(level, value)
            if level == 1 then
                for k,v in pairs(loottable) do
                    AtlasLoot_DewdropSubMenu:AddLine(
                        'text', v[1],
                        'func', AtlasLoot_DewDropSubMenuClick,
                        'arg1', v[2],
                        'arg2', v[1],
                        'notCheckable', true
                    )
                end
                AtlasLoot_DewdropSubMenu:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_DewdropSubMenu:Close() end,
					'notCheckable', true
				)
            end
		end,
		'dontHook', true
	)
end

--[[
AtlasLoot_DewdropRegister:
Constructs the main category menu from a tiered table
]]
function AtlasLoot_DewdropRegister()
	AtlasLoot_Dewdrop:Register(AtlasLootDefaultFrame_Menu,
        'point', function(parent)
            return "TOP", "BOTTOM"
        end,
		'children', function(level, value)
			if level == 1 then
				if AtlasLoot_DewDropDown then
                    for k,v in ipairs(AtlasLoot_DewDropDown) do
                        --If a link to show a submenu
                        if (type(v[1]) == "table") and (type(v[1][1]) == "string") then
                            local checked = false;
                            if v[1][3] == "Submenu" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[1][2],
                                    'arg2', v[1][1],
                                    'arg3', v[1][3],
                                    'notCheckable', true
                                )
                            end
                        else
                            local lock=0;
                            --If an entry linked to a subtable
                            for i,j in pairs(v) do
                                if lock==0 then
                                    AtlasLoot_Dewdrop:AddLine(
                                        'text', i,
                                        'textR', 1,
                                        'textG', 0.82,
                                        'textB', 0,
                                        'hasArrow', true,
                                        'value', j,
                                        'notCheckable', true
                                    )
                                    lock=1;
                                end
                            end
                        end
                    end
                end
                --Close button
				AtlasLoot_Dewdrop:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_Dewdrop:Close() end,
					'notCheckable', true
				)
			elseif level == 2 then
				if value then
                    for k,v in ipairs(value) do
                        if type(v) == "table" then
                            if (type(v[1]) == "table") and (type(v[1][1]) == "string") then
                                local checked = false;
                                --If an entry to show a submenu
                                if v[1][3] == "Submenu" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[1][2],
                                    'arg2', v[1][1],
                                    'arg3', v[1][3],
                                    'notCheckable', true
                                )
                                --An entry to show a specific loot page
                                else
                                    AtlasLoot_Dewdrop:AddLine(
                                        'text', v[1][1],
                                        'func', AtlasLoot_DewDropClick,
                                        'arg1', v[1][2],
                                        'arg2', v[1][1],
                                        'arg3', v[1][3],
                                        'notCheckable', true
                                    )
                                end
                            else
                                local lock=0;
                                --Entry to link to a sub table
                                for i,j in pairs(v) do
                                    if lock==0 then
                                        AtlasLoot_Dewdrop:AddLine(
                                            'text', i,
                                            'textR', 1,
                                            'textG', 0.82,
                                            'textB', 0,
                                            'hasArrow', true,
                                            'value', j,
                                            'notCheckable', true
                                        )
                                        lock=1;
                                    end
                                end
                            end
                        end
                    end
                end
                AtlasLoot_Dewdrop:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_Dewdrop:Close() end,
					'notCheckable', true
				)
            elseif level == 3 then
                --Essentially the same as level == 2
                if value then
                    for k,v in pairs(value) do
                        if type(v[1]) == "string" then
                            local checked = false;
                            if v[3] == "Submenu" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[2],
                                    'arg2', v[1],
                                    'arg3', v[3],
                                    'notCheckable', true
                                )
                            else
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1],
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[2],
                                    'arg2', v[1],
                                    'arg3', v[3],
                                    'notCheckable', true
                                )
                            end
                        elseif type(v) == "table" then
                            AtlasLoot_Dewdrop:AddLine(
                                'text', k,
                                'textR', 1,
                                'textG', 0.82,
                                'textB', 0,
                                'hasArrow', true,
                                'value', v,
                                'notCheckable', true
                            )
                        end
                    end
                end
                AtlasLoot_Dewdrop:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_Dewdrop:Close() end,
					'notCheckable', true
				)
			end
		end,
		'dontHook', true
	)
end
