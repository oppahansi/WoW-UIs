-- Inspector (Gadget) Examine Globals Variables in WoW.
-- 
-- Display a window and examine global variables in WoW.
--
-- To display Inspector frame type '/inspt on' to hide '/inspt off'.
-- Or you can bind a key to Inspector via the 'Key Binding' in Main Menu.
--
-- Just when I was just about finished with this addon I found the addon
-- myDebug by Scheid. His is very good and I will never be able to achieve
-- the level of his program. But myDebug gave me many new ideas to add
-- to my version :-)
-- 
-- Special Thanks: I worked and worked to create my own code, but myDebug
-- by Scheid is just to good of a coder for me and I used his tree building
-- code. Thanks
--
-- The XML code is pretty bad and I hope to get better at it someday :-)
--
-- Please give me your comments and be kind this is my first addon.
--
-- Modification History:
--   Created by Sagarus 2006/07/13 version 11100-2.0.5
--     - Fixed the screen refresh problem.
--   Created by Sagarus 2006/07/10 version 11100-2.0.4
--     - Fixed the button problems with GameMenuFrame, it should now work
--       with anyone elses buttons adds.
--   Created by Sagarus 2006/07/09 version 11100-2.0.3
--     - Fixed the minimized button problem.
--     - Fixed the Script error when clicking in empty lines.
--   Created by Sagarus 2006/06/24 version 11000-2.0.2
--     - Bug fix when modifing a variable.
--   Created by Sagarus 2006/04/06 version 11000-2.0.1
--     - Covert over Inspector2 to Inspector and EOL the old Inspector.
--   Created by Sagarus 2006/04/05 version 11000-0.8.6
--     - Fixed Font issues with search editbox not showing the text typed.
--   Created by Sagarus 2006/04/02 version 11000-0.8.5
--     - Minor cleanup
--   Created by Sagarus 2006/01/21 version 10900-0.8
--     - Added the options tab and configuration (need to add more options).
--     - Added the saved variables.
--   Created by Sagarus 2006/01/19 version 10900-0.7
--     - Add Insert, modify and delete now supported.
--     - Highlight the variables
--     - Set the variable frame to a maximum width.
--     - Wrap the variable data in the variable frame for easier viewing.
--   Created by Sagarus 2006/01/08 version 10900-0.6
--     - Fixed problem with frame width in variable window.
--     - Fixed the 'myAddOns' problem.
--     - Cleanup code
--   Created by Sagarus 2006/01/07 version 10900-0.5
--     - Fixed the scrolling issues in verison 0.4
--   Created by Sagarus 2006/01/03 version 10900-0.4
--   Created by Sagarus 2006/01/02 version 1800-0.4
--     - Added a minimize button.
--     - Move the Scroll bar to the other side of the window.
--     - Allow all windows to be movable.
--     - Added a variable window.
--     - Added the starting place for an options windows.
--     - Variable window is sticky and has dynamic update.
--     - Still need to fix 'myAddOns' problem.
--   Created by Sagarus 2005/12/30 version 1800-0.3
--     - Allow other keys to work while search screen is up.
--     - Some minor clean up.
--   Created by Sagarus 2005/12/27 version 1800-0.2  Released.
--   Created by Sagarus 2005/11/16 version 1800-0.1
--
-- Thanks to Everyone:
--   Grabbed a lot of ideas from many addons LootLink, MonkeyQuest and many
--   others. I want to thank all of the developers for the great work.
--
-- Notes:
--   I tried to limit the number of global variables in this program, which
--   is one of the reasons the function ordering seems odd. Because all
--   functions are local you have to declare the function before use or
--   add it to the Inspector table at the end of the program. Not sure this
--   was a good ides, but that is how I did it.
--
-- Thanks Sagarus.
--

local AddonName = "Inspector";

-----------------------------------------------------------------------------
--
-- Helper functions.
--
local strfmt    = string.format;
local strfind   = string.find;
local strgfind  = string.gfind;
local strrep    = string.rep;
local strsub    = string.sub;
local strgsub   = string.gsub;
local strlen    = string.len;

-----------------------------------------------------------------------------
-- Holds the frame pointers and other information per frame.
--
local fName = {
  ["mName"] = "IG_MainFrame",    -- Main Frame name
  ["vName"] = "IG_VarFrame",     -- Variable Frame name
  ["cName"] = "IG_CfgFrame",     -- Config Frame name
  ["sName"] = "IG_ScriptFrame",  -- Script Frame name
}

local InspectorFrames;

igd = {};
igf = {};

local lbl = {
  ["main"]  = {
	["bTitle"]           = fName.mName.."TitleButton",
	["tTitle"]           = fName.mName.."TitleButtonText",
  },
  ["vars"]  = {
	["bTitle"]           = fName.vName.."TitleButton",
	["tTitle"]           = fName.vName.."TitleButtonText",
  },
  ["cfg"]   = {
    ["SearchTab"]       = fName.cName.."SearchTab",
    ["tEditBox"]        = fName.cName.."SearchTab_ConfigTextEditBox",
    ["allTypesCheck"]   = fName.cName.."SearchTab_AllTypesCheckButton",
    ["allVarsCheck"]    = fName.cName.."SearchTab_AllVarsCheckButton",
    ["cEditBox"]        = fName.cName.."SearchTab_ConfigCountEditBox",
    ["countLabel"]      = fName.cName.."SearchTab_ConfigCountLabel",
    ["sortCheck"]       = fName.cName.."SearchTab_SortCheckButton",
    ["rowTitleFunc"]    = function(i) return fName.cName.."SearchTabRow"..i.."Title"; end,
    ["rowCountFunc"]    = function(i) return fName.cName.."SearchTabRow"..i.."Count"; end,
    ["typeCheckFunc"]   = function(i) return fName.cName.."SearchTab_TypeCheckButton"..i; end,

    ["OptionTab"]       = fName.cName.."OptionTab",
    ["tmoEditBox"]      = fName.cName.."OptionTab_TimeoutEditBox",
    ["widthEditBox"]    = fName.cName.."OptionTab_MaxWidthEditBox",
    ["alphaEditBox"]    = fName.cName.."OptionTab_AlphaEditBox",
    ["memoryLabel"]     = fName.cName.."_MemoryLabel",
  },
  ["script"] = {
      ["sEditBox"]      = function(i) return fName.sName.."ScriptTab"..i.."ListScrollFrameChildFrameEditBox"; end,
      ["ScriptTab"]     = function(i) return fName.sName.."ScriptTab"..i; end,
  }
};

-----------------------------------------------------------------------------
-- Contains local information.
--
local isInfo            = {};
isInfo.WoWVersion       = "11100";
isInfo.CurrentVersion   = "2.0.5";
isInfo.ReleaseDate      = "2006.07.13";
isInfo.versionStr       = AddonName.." v"..isInfo.WoWVersion.."-"..isInfo.CurrentVersion;

-- Saved list of checked buttons.
isInfo.checkedList      = {
    ["thread"]      = false,
    ["function"]    = false,
    ["string"]      = false,
    ["table"]       = false,
    ["number"]      = false,
    ["userdata"]    = false,
    ["boolean"]     = false,
    ["allVars"]     = false,
    ["allTypes"]    = true,
    ["sort"]        = true
};

isInfo.scriptCode = {
    [1]     = "InspectorAddon:chat('Hello World! (1)')",
    [2]     = "InspectorAddon:chat('Hello World! (2)')",
    [3]     = "InspectorAddon:chat('Hello World! (3)')",
    [4]     = "InspectorAddon:chat('Hello World! (4)')",
    [5]     = "InspectorAddon:chat('Hello World! (5)')",
    [6]     = "InspectorAddon:chat('Hello World! (6)')",
    [7]     = "InspectorAddon:chat('Hello World! (7)')",
    [8]     = "InspectorAddon:chat('Hello World! (8)')",
};

-- typeCount - cnt is the number of types and checked is the check box value.
local typeCount         = {
    ["thread"]   = { cnt = 0, checked = false },
    ["function"] = { cnt = 0, checked = false },
    ["string"]   = { cnt = 0, checked = false },
    ["table"]    = { cnt = 0, checked = false },
    ["number"]   = { cnt = 0, checked = false },
    ["userdata"] = { cnt = 0, checked = false },
    ["boolean"]  = { cnt = 0, checked = false }
};

-----------------------------------------------------------------------------
--
-- Some global values for the system.
--

Inspector_TITLE	                = isInfo.versionStr;
Inspector_CONFIG_TITLE          = "Configurations";
Inspector_RESET_LABEL           = "Reset";
Inspector_CONFIG_LABEL          = "Config";

Inspector_SEARCH_STRING         = "Search String";
Inspector_TYPE_STRING           = "Types To Include in Search:";
Inspector_SEARCH_TEXT           = "Search";
Inspector_OPTION_TEXT           = "Options";

Inspector_OPTION_TIMEOUT        = "Timeout in Seconds";
Inspector_OPTION_MAXWIDTH       = "Max Frame Width";
Inspector_OPTION_ALPHA          = "Background Alpha";

Inspector_SCRIPT_TITLE          = "Script Code";
Inspector_SCRIPT_LABEL          = "Script";
Inspector_SCRIPT_EXECUTE        = "Execute";
Inspector_SCRIPT1_TEXT          = "One";
Inspector_SCRIPT2_TEXT          = "Two";
Inspector_SCRIPT3_TEXT          = "Three";
Inspector_SCRIPT4_TEXT          = "Four";
Inspector_SCRIPT5_TEXT          = "Five";
Inspector_SCRIPT6_TEXT          = "Six";
Inspector_SCRIPT7_TEXT          = "Seven";
Inspector_SCRIPT8_TEXT          = "Eight";

UIPanelWindows["IG_MainFrame"]   = { area = "left",   pushable = 11 };
UIPanelWindows["IG_CfgFrame"]    = { area = "center", pushable = 0 };
UIPanelWindows["IG_ScriptFrame"] = { area = "right", pushable = 0 };

local colors        = {
    ["thread"]   = { c = "|cff40ffc0", r = 64/255,    g = 1.0,       b = 192/255 },
    ["function"] = { c = "|cff9d9d9d", r = 157/255,   g = 157/255,   b = 157/255 },
    ["string"]   = { c = "|cffffffff", r = 1.0,       g = 1.0,       b = 1.0 },
    ["table"]    = { c = "|cff1eff00", r = 30 / 255,  g = 1.0,       b = 0 },
    ["number"]   = { c = "|cff0070dd", r = 0,         g = 70 / 255,  b = 221 / 255 },
    ["userdata"] = { c = "|cffa335ee", r = 163 / 255, g = 53 / 255,  b = 238 / 255 };
    ["boolean"]  = { c = "|cffff8000", r = 1.0,       g = 128 / 255, b = 0 },
    ["nil"]      = { c = "|cffff80FF", r = 1.0,       g = 128 / 255, b = 1.0 },

    ["gold"]	 = { c = "|c00FFFF66", r = 1.0,       g = 1.0,       b = 102/255 },
    ["white"]	 = { c = "|cFFFFFFFF", r = 1.0,       g = 1.0,       b = 1.0 },
    ["yellow"]   = { c = "|cFFFFFF00", r = 1.0,       g = 1.0,       b = 0 },
    ["normal"]   = { c = "", r = NORMAL_FONT_COLOR.r,
                             g = NORMAL_FONT_COLOR.r,
                             b = NORMAL_FONT_COLOR.b },
    ["tooltip"]  = { c = "", r = TOOLTIP_DEFAULT_COLOR.r,
                             g = TOOLTIP_DEFAULT_COLOR.r,
                             b = TOOLTIP_DEFAULT_COLOR.b },
    ["tooltipBG"]= { c = "", r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
                             g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
                             b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b },
    ["title"]    = { c = "|cFFFF8000", r = 1.0,       g = 0.5,       b = 0 }
};

-- Used by the XML file to add text to the check boxes.
local TextLabel = {
    Sort    = "Sort",
    All     = "All",
    AllVars = "All Vars";
    Type1   = "Function",
    Type2   = "String",
    Type3   = "Userdata",
    Type4   = "Table",
    Type5   = "Number",
    Type6   = "Boolean"
};

local function s2b(s)
    if ( type(s) == "string" ) then
        if ((s == "1") or (s == "true") ) then
            return true;
        else
            return false;
        end
    elseif ( type(s) == "number" ) then
        if ( s > 0 ) then
            return true;
        else
            return false;
        end
    elseif ( type(s) == "boolean" ) then
        return s;
    else
        return false;
    end
end

-----------------------------------------------------------------------------
--
--
local function itemCount(f)

    if ( f.minimizeButton.state ) then
        return 0;
    else
        return f.dataTable.index - 1;
    end;
end

local function getSearchText()
    return getglobal(lbl.cfg.tEditBox):GetText();
end

local function getAllTypes()
    local v = getglobal(lbl.cfg.allTypesCheck):GetChecked();
    isInfo.checkedList.allTypes = s2b(v);
    return isInfo.checkedList.allTypes;
end

local function getMaxItems()
    local maxItems, t;
    local v = getglobal(lbl.cfg.allVarsCheck):GetChecked();

    isInfo.checkedList.allVars = s2b(v);

    if ( isInfo.checkedList.allVars ) then
        maxItems = nil;
    else
        t = getglobal(lbl.cfg.cEditBox):GetText();
        if ( (t == nil) or (t == "") or (tonumber(t) == nil) ) then
            maxItems = nil;
        else
            maxItems = tonumber(t);
        end
    end
    return maxItems;
end

local function getTimeoutText()
    return getglobal(lbl.cfg.tmoEditBox):GetText();
end

local function getMaxWidthText()
    return getglobal(lbl.cfg.widthEditBox):GetText();
end

local function getAlphaText()
    return getglobal(lbl.cfg.alphaEditBox):GetText();
end

local function getTextHeight()
    if ( this == IG_MainFrame ) then
        return igd.itemHeight;
    else
        return igd.varsHeight;
    end
end

-------------------------------------------------------------------------------
-- Tree functions
-- Code from myDebug by Scheid.
-------------------------------------------------------------------------------

-- Get the variable of a node
local function GetVariable(f, nodeIndex)

	-- Get the node
	local node = f.dataTable[nodeIndex];
	
	if (node.pIndex == 0) then
		return getglobal(node.name);
	else
		return GetVariable(f, node.pIndex)[node.name];
	end

end

-- Build a node of the variable's tree
local function BuildNode(f, parent, pIndex, nodeName, saved)

	-- Get the current node
	local node;

	if (parent) then
		node = parent[nodeName];
	else
		node = getglobal(nodeName);
	end;

    f.dataTable.index = f.dataTable.index + 1;

    if ( f.dataTable.index >= 500 ) then
        InspectorAddon:chat("Exceeded the max number of entries");
        return;
    end

	-- Check the type of the node
    if ( type(node) == "table" ) then
        if ( not saved[node] ) then
            saved[node] = nodeName;

            table.insert(f.dataTable, {name = nodeName, pIndex = pIndex});

            local currentIndex = table.getn(f.dataTable);
            for childNode in node do
                BuildNode(f, node, currentIndex, childNode, saved);
            end
        else
            table.insert(f.dataTable,
                {name = nodeName, pIndex = pIndex, alias = "<<"..saved[node]..">>"});
        end
    else
        table.insert(f.dataTable,
                {name = nodeName, pIndex = pIndex, value = node});
	end
end

-- Build the variable's tree
local function BuildTree(f, variableName)

	-- Empty the tree
    f.dataTable = { index = 1, total = 1, xlate = {} };
		
	-- Get the variable
	local variable = getglobal(variableName);

	-- Check if the variable does exist
	if (variable) then
		BuildNode(f, nil, 0, variableName, {});
	elseif (variableName ~= "") then
		InspectorAddon:chat(variableName.." Not found Error");
	end
end
-----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- SetTitle - Display the Title to the main screen with number of globals.
--
local function SetTitle(f)
	local button = getglobal(lbl.main.bTitle);
	local text = getglobal(lbl.main.tTitle);
	local size;
    local s;

	size = itemCount(f);
    if (size <= 1) then s = "" else s = "s" end

    text:SetTextHeight(getTextHeight() + 2);
    text:SetText(strfmt(isInfo.versionStr.." - %d of %s item%s",
        size, f.dataTable.total, s));
    text:SetWidth(text:GetStringWidth() + igd.iWidthPadding);
    button:SetWidth(text:GetStringWidth());
    button:SetHeight(text:GetHeight());
    text:Show();
    button:Show();
end

----------------------------------------------------------------------------
-- SetVariableTitle - Display the Title to the Variable screen
--
local function SetVariableTitle(f)
	local button = getglobal(lbl.vars.bTitle);
	local text = getglobal(lbl.vars.tTitle);

    text:SetTextHeight(getTextHeight() + 2);
    text:SetText(strfmt("%s - %d", igd.varText , itemCount(f) - 1));
    text:SetWidth(text:GetStringWidth() + igd.iWidthPadding);
    button:SetWidth(text:GetStringWidth() + igd.iWidthPadding);
    button:SetHeight(text:GetHeight());
    text:Show();
    button:Show();
end

-----------------------------------------------------------------------------
-- UpdateCounts - Set the count text strings.
--
local function UpdateCounts(f)
    local k, v, i;

    do 
        local label = getglobal(lbl.cfg.countLabel);

        label:SetText(strfmt("Type Totals: %d of %d", itemCount(f), f.dataTable.total));
        label:Show();

        label = getglobal(lbl.cfg.memoryLabel);
        label:SetText(strfmt("Memory(MB): %.3f", gcinfo()/1024));
        label:Show();
    end

    i = 1;
    for k,v in pairs(typeCount) do
        local row;

        row = getglobal(lbl.cfg.rowTitleFunc(i));
        row:SetText(strfmt("%-10s", k));
        row:Show();

        row = getglobal(lbl.cfg.rowCountFunc(i));
        row:SetText(strfmt("%8d", v.cnt));
        row:Show();

        i = i + 1;
    end
end

-----------------------------------------------------------------------------
-- processGlobals - Create a table of all global variables.
--
local function processGlobals(f)
    local k, v;
    local i;
    local aTypes, mItems, sText;

    -- Zero out the type counts.
    i = 1;
    for k,v in pairs(typeCount) do
        local checked = getglobal(lbl.cfg.typeCheckFunc(i));

        if ( checked == nil ) then
            v.checked = false;
        else
            v.checked = checked:GetChecked();
            v.checked = s2b(v.checked);
        end
        v.cnt = 0;

        -- Update the saved list of checked boxes.
        isInfo.checkedList[k] = v.checked;

        i = i + 1;
    end

    -- grab a copy of the search options.
    sText   = igd.searchText;
    aTypes  = getAllTypes();
    mItems  = getMaxItems();

    -- Empty out the dataTable.
    f.dataTable = { index = 1, total = 1, xlate = {} };

    i = 1;
	for k,v in pairs(getfenv()) do
        -- Did we reach the maximum number of items to collect?
        if ( (mItems == nil) or (i <= mItems) ) then
            local t = type(v);

            -- Is this type selected or all types.
            if ( aTypes or isInfo.checkedList[t] ) then

                -- If the search string is valid do a compare to the name.
                if ( (sText == nil) or (strfind(k, sText) ~= nil) ) then

                    -- Add the variable name to the data table.
                    f.dataTable[i] = k;

                    -- Count each type of variable.
                    typeCount[t].cnt = typeCount[t].cnt + 1;

                    i = i + 1
                end
            end
        end
        -- Count the total number of variables not just the matching ones.
        f.dataTable.total = f.dataTable.total + 1;
    end

    -- Save the current number of items in list.
    f.dataTable.index = i;

    isInfo.checkedList.sort = s2b(getglobal(lbl.cfg.sortCheck):GetChecked());
    if ( isInfo.checkedList.sort ) then
        -- Sort the table in assending order.
        table.sort(f.dataTable, function(a, b) return (a < b); end)
    end
end

-----------------------------------------------------------------------------
-- ResizeScrollFrame - Adjust size of the global variable frame based on enteries.
--
local function ResizeScrollFrame(f, scroll, pFrame)
    local i;
    local iHeight = 0;
    local iWidth = 0;

    -- Reset the refresh timer.
    f.refreshTime = 0;

    f.setTitle(f);

    -- Get the current width of the frame.
    pFrame:SetScale(UIParent:GetEffectiveScale());
    iWidth = getglobal(pFrame:GetName().."TitleButtonText"):GetStringWidth() + 80;

    for i = 1, f.shown, 1 do
        local text = getglobal(pFrame:GetName().."Button" .. i .. "Text");
        local button = getglobal(pFrame:GetName().."Button" .. i);

        -- Figure out which is bigger text width or iWidth
        iWidth = math.max(tonumber(text:GetStringWidth()), iWidth);

        -- Make sure the max width is honored.
        iWidth = math.min(iWidth, igd.maxVarWidth);

        if ( not f.minimizeButton.state and text:IsVisible() ) then

            text:SetWidth(iWidth);
            iHeight = iHeight + text:GetHeight();

            button:SetWidth(iWidth);
            button:SetHeight(text:GetHeight());
        else
            button:SetWidth(0);
            button:SetHeight(0);
        end
    end

    -- Adjust the width of the buttons to allow for better scrolling.
    for i = 1, f.shown, 1 do
        local button = getglobal(pFrame:GetName().."Button" .. i);
        button:SetWidth(iWidth + 8);
    end

    iHeight = iHeight + getglobal(pFrame:GetName().."TitleButtonText"):GetHeight();

    this:SetHeight(iHeight + igd.iHeightPadding);

    this:SetWidth(iWidth + igd.iWidthPadding);

    scroll:SetWidth(iWidth - 8);
    scroll:SetHeight(iHeight - 8);
end

-----------------------------------------------------------------------------
-- FrameUpdates - Display the global/variable frames
--
local function FrameUpdates(f, scroll, pFrame )
	local k, offset, idx;
    local name = pFrame:GetName();
    local function q(v)
            if ( type(v) == "number" ) then
                return "["..v.."] = ";
            elseif ( type(v) == "table" ) then
                return "["..InspectorAddon:serializeIt(v).."] = ";
            elseif ( type(v) == "string" ) then
                return "[\""..v.."\"] = ";
            else
                return "["..tostring(v).."] = ";
            end
        end
    local function setText( b, s, c )
        local text    = getglobal(b.."Text");
        local button  = getglobal(b);

        text:SetText(s);

        text:SetTextColor(c.r, c.g, c.b);

        text:Show();
        button:Show();
    end

    -- Set the scrolling window sizes
    FauxScrollFrame_Update(scroll, itemCount(f), f.shown, getTextHeight());
    offset = FauxScrollFrame_GetOffset(scroll);

    -- Clear the buttons and text areas.
    for k = 1, f.shown do
        local text = getglobal(name.."Button"..k.."Text");
        local button = getglobal(name.."Button"..k);

        text:SetText("");
        text:SetWidth(0);
        text:SetTextHeight(getTextHeight());
        button:SetWidth(0);
        button:Hide();
    end

    if ( pFrame == IG_MainFrame ) then

        for k=1, f.shown do
            idx = k + offset;

            if ( idx <= itemCount(f) ) then
                local var = f.dataTable[idx];
                setText(name.."Button"..k, var, colors[type( getfenv()[var] )]);
            end
        end
    else
        local j;
        local xlate = {};
        local function n2t(a, s)
                if ( not a ) then
                    return s
                else
                    return a
                end;
            end

        j = 1;
        for k=1, f.shown do
            idx = k + offset;

            if ( idx <= itemCount(f) ) then
                local node, str;
                local B = name.."Button"..j;

                node = f.dataTable[idx];
                if ( node == nil ) then
                    node = {};
                    node.name = "Unknown";
                    node.pIndex = 0;
                    node.value = "ooops";
                end

                if ( (node.value) and (node.pIndex == 0) ) then
                    -- Non-Scalar variable
                    setText(B, n2t(node.alias,InspectorAddon:serializeIt(node.value)), colors.gold);
                    getglobal(B):SetID(j);
                    xlate[j] = node;
                    j = j + 1;
                elseif ( (node.value == nil) and (node.pIndex == 0) ) then
                    setText(B, node.name, colors.gold);
                    getglobal(B):SetID(-j);
                    xlate[j] = node;
                    j = j + 1;
                else
                    local function s(n) return strrep(" ", n*2); end;
                    local function lvls(n)
                            local cnt = 0;
                            while ( f.dataTable[n].pIndex > 0 ) do
                                cnt = cnt + 1;
                                n = f.dataTable[n].pIndex;
                            end
                            return cnt;
                        end
                    local x;

                    -- Scalar variable or table
                    xlate[j] = node;

                    str = q(node.name);

                    x = lvls(node.pIndex);
                    if ( node.value ~= nil ) then
                        str = s(x) .. str .. n2t(node.alias, InspectorAddon:serializeIt(node.value));
                        getglobal(B):SetID(j);
                    else
                        str = s(x) .. str .. n2t(node.alias, "");
                        getglobal(B):SetID(-j);
                    end

                    setText(B, str, colors.gold);
                    j = j + 1;
                end
            end
        end

        -- Add the translate table to the main data table.
        f.dataTable["xlate"] = xlate;
    end

    ResizeScrollFrame(f, scroll, pFrame);
end

-----------------------------------------------------------------------------
-- UpdateFrame - Display the global variables into the scrolling frame.
--
local function UpdateFrame()
    local f = igf[this:GetParent()];

    if ( f ~= nil ) then
        f.refreshNow = true;
    else
        InspectorAddon:chat("UpdateFrame frame "..this:GetName());
    end
end

-----------------------------------------------------------------------------
-- DropDownMenu_PrepareMenu - Setup the drop down menus.
--
local function DropDownMenu_PrepareMenu()
    local info = {};

    info.text = "Edit Menu";
    info.notClickable = 1;
    info.isTitle = 1;
    UIDropDownMenu_AddButton(info, nil);
    
    info = {};
    info.text = "Insert";
    info.func = function () 
        StaticPopup_Show("INSPECTOR_VARIABLE_INSERT");
        end;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = "Modify";
    info.func = function ()
        StaticPopup_Show("INSPECTOR_VARIABLE_MODIFY");
        end;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = "Delete";
    info.func = function ()
        StaticPopup_Show("INSPECTOR_VARIABLE_DELETE");
        end;
    UIDropDownMenu_AddButton(info);
end

local function RightClickMenu_OnLoad()
    UIDropDownMenu_Initialize(this, DropDownMenu_PrepareMenu);
end

-----------------------------------------------------------------------------
-- Refresh - Update and redisplay the global variable frame.
--
local function Refresh(f)
    f.processData(f);
    f.updateCounts(f);
    f.frameUpdate(f, getglobal(this:GetName().."ListScrollFrame"), this );
end

-----------------------------------------------------------------------------
--
--	Initialization And Configuration.
--

-----------------------------------------------------------------------------
-- gameTooltip_SetOwner -  Call the save routine.
--
local function gameTooltip_SetOwner(this, owner, anchor)
    InspectorAddon.GameTooltip_SetOwner(this, owner, anchor);
end

-----------------------------------------------------------------------------
-- gameTooltip_OnHide - Hide the tooltip and call the save routine.
--
local function gameTooltip_OnHide()
    InspectorAddon.GameTooltip_OnHide();
end

-----------------------------------------------------------------------------
-- Config - Open/close the configuration frame.
--
local function Config()

    if ( IG_CfgFrame:IsVisible() ) then
        IG_CfgFrame:Hide();
    else
        IG_CfgFrame:SetScale(UIParent:GetEffectiveScale()+.55);
        getglobal(lbl.cfg.cEditBox):SetText(igd.defaultCount);
        getglobal(lbl.cfg.tEditBox):SetText(igd.searchText);
        IG_CfgFrame:Show();
    end
end

-----------------------------------------------------------------------------
-- ConfigFrame_Okay -
--
local function ConfigFrame_Okay()

    local timeout = tonumber(getTimeoutText());
    if ( timeout == nil ) then
        timeout = 5;
    end

    igf[IG_MainFrame].refreshTimeout    = timeout;
    igf[IG_VarFrame].refreshTimeout     = timeout;

    igd.searchText = getSearchText();
    igd.maxVarWidth = tonumber(getMaxWidthText());
    if ( igd.maxVarWidth == nil ) then
        igd.maxVarWidth = 550;
    end

    igd.iAlpha = tonumber(getAlphaText());
    if ( igd.iAlpha == nil ) then
        igd.iAlpha = 0.5;
    end

    local it = colors.tooltipBG;
    IG_MainFrame:SetBackdropColor(it.r, it.g, it.b, igd.iAlpha);
    IG_VarFrame:SetBackdropColor(it.r, it.g, it.b, igd.iAlpha);

    igf[IG_MainFrame].refreshNow = true;
    igf[IG_VarFrame].refreshNow = true;
end

-----------------------------------------------------------------------------
-- ConfigFrameTab_OnClick
--
local function ConfigFrameTab_OnClick(tab)

    PanelTemplates_SetTab(this:GetParent(), tab);

    if ( this:GetID() == 1 ) then
        getglobal(lbl.cfg.OptionTab):Hide();
        getglobal(lbl.cfg.SearchTab):Show();
    else
        getglobal(lbl.cfg.tmoEditBox):SetText(igd.timeout);
        getglobal(lbl.cfg.widthEditBox):SetText(igd.maxVarWidth);
        getglobal(lbl.cfg.alphaEditBox):SetText(igd.iAlpha);

        getglobal(lbl.cfg.SearchTab):Hide();
        getglobal(lbl.cfg.OptionTab):Show();
    end
end

-----------------------------------------------------------------------------
-- Script - Open/close the Script frame.
--
local function Script()

    if ( IG_ScriptFrame:IsVisible() ) then
        IG_ScriptFrame:Hide();
    else
        local   i;
        IG_ScriptFrame:SetScale(UIParent:GetEffectiveScale()+.55);

        for i=1,igd.maxScriptTabs do
            getglobal(lbl.script.sEditBox(i)):SetText(
                isInfo.scriptCode[i] or "InspectorAddon:chat('Hello World! ("..i..")')");
        end
        IG_ScriptFrame:Show();
    end
end

-----------------------------------------------------------------------------
-- button_OnEnter - Display the tooltip when search button is entered.
--
local function button_OnEnter( bType )

    GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
    GameTooltip:SetText("Open/Close "..bType.." Window",
        colors.normal.r, colors.normal.g, colors.normal.b, 1);
end

-----------------------------------------------------------------------------
-- ScriptFrame_Save -
--
local function ScriptFrame_Save()

    local   i;
    local timeout = tonumber(getTimeoutText());
    if ( timeout == nil ) then
        timeout = 5;
    end

    igf[IG_MainFrame].refreshTimeout    = timeout;
    igf[IG_VarFrame].refreshTimeout     = timeout;

    igd.searchText = getSearchText();
    igd.maxVarWidth = tonumber(getMaxWidthText());
    if ( igd.maxVarWidth == nil ) then
        igd.maxVarWidth = 550;
    end

    igd.iAlpha = tonumber(getAlphaText());
    if ( igd.iAlpha == nil ) then
        igd.iAlpha = 0.5;
    end

    local it = colors.tooltipBG;
    IG_MainFrame:SetBackdropColor(it.r, it.g, it.b, igd.iAlpha);
    IG_VarFrame:SetBackdropColor(it.r, it.g, it.b, igd.iAlpha);

    igf[IG_MainFrame].refreshNow = true;
    igf[IG_VarFrame].refreshNow = true;

    isInfo.scriptCode = {};
    for i=1,igd.maxScriptTabs do
        isInfo.scriptCode[i] = getglobal(lbl.script.sEditBox(i)):GetText();
    end
end

local function ScriptFrame_Execute()
    local   id = igd.scriptIndex;
    isInfo.scriptCode[id] = getglobal(lbl.script.sEditBox(id)):GetText();
    RunScript(isInfo.scriptCode[id] or "");
end

-----------------------------------------------------------------------------
-- ScriptFrameTab_OnClick
--
local function ScriptFrameTab_OnClick(tab)

    local   i;

    PanelTemplates_SetTab(this:GetParent(), tab);

    for i=1,igd.maxScriptTabs do
        getglobal(lbl.script.ScriptTab(i)):Hide();
    end

    getglobal(lbl.script.ScriptTab(this:GetID())):Show();

    igd.scriptIndex = this:GetID();
end

local function ScriptFrameEdit_OnUpdate()
    ScrollingEdit_OnUpdate(this:GetParent():GetParent());
end

-----------------------------------------------------------------------------
-- SetLabel - Set the text for the correct label.
--
local function SetLabel( labeltext )
    getglobal(this:GetName().."_Label"):SetText(labeltext);
end

-----------------------------------------------------------------------------
--
--	Slash Command Handlers
--
local function SlashHandler(command, options)

    if ( command == "on" ) then
        if ( not IG_MainFrame:IsVisible() ) then
            IG_MainFrame:Show();
        end
    elseif ( command == "off" ) then
        if ( IG_MainFrame:IsVisible() ) then
            IG_MainFrame:Hide();
            if (IG_CfgFrame:IsVisible() ) then
                IG_CfgFrame:Hide();
            end

            -- Release the table information to reclaim memory.
            igf[IG_MainFrame].dataTable = { index = 1, total = 1, xlate = {} };
            igf[IG_VarFrame].dataTable  = { index = 1, total = 1, xlate = {} };
        end
    end

    -- Force an update on the windows.
    igf[IG_MainFrame].refreshNow  = true;
    igf[IG_VarFrame].refreshNow   = true;
end

local function OnMouseWheel(value)
    local scrollBar = getglobal(this:GetName().."ListScrollFrameScrollBar");

    if ( value > 0 ) then
        scrollBar:SetValue(scrollBar:GetValue() - (scrollBar:GetHeight()/2));
    else
        scrollBar:SetValue(scrollBar:GetValue() + (scrollBar:GetHeight()/2));
    end
end

local function scriptFrame_Clear()
    local   id = igd.scriptIndex;
    isInfo.scriptCode[id]    = "";
    getglobal(lbl.script.sEditBox(id)):SetText("");
end

local function scriptFrame_Execute()
    local   id = igd.scriptIndex;
    isInfo.scriptCode[id] = getglobal(lbl.script.sEditBox(id)):GetText();
    if ( strlen(isInfo.scriptCode[id]) > 0 ) then
        RunScript(isInfo.scriptCode[id]);
    else
        InspectorAddon:chat("Script is empty!!");
    end
end

-----------------------------------------------------------------------------
-- Dialog box information
--
local INSPECTOR_SCRIPT_CLEAR   = "Script Clear";
local INSPECTOR_SCRIPT_YES     = "Yes";

StaticPopupDialogs["INSPECTOR_SCRIPT_CLEAR"] = {
	text = TEXT(INSPECTOR_SCRIPT_CLEAR),
	button1 = TEXT(INSPECTOR_SCRIPT_YES),
	OnAccept = function()
		scriptFrame_Clear();
	end,
	OnCancel = function()
		-- scriptsFrame_Clear();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

local INSPECTOR_VARIABLE_INSERT_DATA = "Variable Data";
StaticPopupDialogs["INSPECTOR_VARIABLE_INSERT_DATA"] = {
	text = TEXT(INSPECTOR_VARIABLE_INSERT_DATA),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 256,
	hasWideEditBox = 1,
	OnAccept = function(parameters)
        local f = igf[IG_VarFrame];
        local node;
        local var = igd.varName;
        local data = getglobal(this:GetParent():GetName().."WideEditBox"):GetText(); 

        if ( data == "{}" ) then
            data = {};
        end

        node = f.dataTable.xlate[math.abs(igd.dropDownIndex)];

        if ( node.pIndex == 0 ) then
            if ( type(getglobal(node.name)) == "table" ) then
                getglobal(node.name)[var] = data;
            else
                setglobal(node.name, data);
            end
        else
            if ( node.value ) then
                GetVariable(f, node.pIndex)[var] = data;
            else
                GetVariable(f, node.pIndex)[node.name][var] = data;
            end
        end

        igf[IG_MainFrame].refreshNow = true;
        f.refreshNow = true;
	end,
	OnShow = function()
        this:SetWidth(420);
        this:SetPoint("TOP", "UIParent", "TOP", 0, -128);
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function(parameters)
		StaticPopup_OnClick(getglobal(this:GetParent():GetName()), 1);
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	whileDead = 1
};

local INSPECTOR_VARIABLE_INSERT = "Variable Name to Insert";
StaticPopupDialogs["INSPECTOR_VARIABLE_INSERT"] = {
	text = TEXT(INSPECTOR_VARIABLE_INSERT),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 100,
	OnAccept = function(parameters)
        local f = igf[IG_VarFrame];

        igd.varName = getglobal(this:GetParent():GetName().."EditBox"):GetText();

        StaticPopup_Show("INSPECTOR_VARIABLE_INSERT_DATA");

        igf[IG_MainFrame].refreshNow = true;
        f.refreshNow = true;
	end,
	OnShow = function()
		this:SetPoint("TOP", "UIParent", "TOP", 0, -128);
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function(parameters)
		StaticPopup_OnClick(getglobal(this:GetParent():GetName()), 1);
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	whileDead = 1
};

local INSPECTOR_VARIABLE_MODIFY = "Modify Variable";
StaticPopupDialogs["INSPECTOR_VARIABLE_MODIFY"] = {
	text = TEXT(INSPECTOR_VARIABLE_MODIFY),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 100,
	OnAccept = function(parameters)
        local f = igf[IG_VarFrame];
        local node;
        local data = getglobal(this:GetParent():GetName().."EditBox"):GetText(); 
        local function t2d(v, z)
                if ( d == "{}" ) then
                    return {};
                end
                t = type(v);
                if ( t == "number" ) then
                    return tonumber(z);
                elseif ( t == "string" ) then
                    return z;
                elseif ( t == "boolean" ) then
                    if ( z == "true" ) then
                        return true;
                    else
                        return false;
                    end
                end
            end

        node = f.dataTable.xlate[math.abs(igd.dropDownIndex)];
        if ( node.pIndex == 0 ) then
            setglobal(node.name, t2d(node.value, data));
        else
            GetVariable(f, node.pIndex)[node.name] = t2d(node.value, data);
        end

        igf[IG_MainFrame].refreshNow = true;
        f.refreshNow = true;
	end,
	OnShow = function()
        local f = igf[IG_VarFrame];
        local node;

        node = f.dataTable.xlate[math.abs(igd.dropDownIndex)];

        this:SetPoint("TOP", "UIParent", "TOP", 0, -128);
        getglobal(this:GetName().."EditBox"):SetFocus();
        if ( node.value ) then
            getglobal(this:GetName().."EditBox"):SetText(node.value);
        else
            getglobal(this:GetName().."EditBox"):SetText(node.name);
        end
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function(parameters)
		StaticPopup_OnClick(getglobal(this:GetParent():GetName()), 1);
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	whileDead = 1
};

local INSPECTOR_VARIABLE_DELETE = "Delete";
StaticPopupDialogs["INSPECTOR_VARIABLE_DELETE"] = {
	text = TEXT(INSPECTOR_VARIABLE_DELETE),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
        local f = igf[IG_VarFrame];
        local node;

        node = f.dataTable.xlate[math.abs(igd.dropDownIndex)];
        if ( node.pIndex == 0 ) then
            setglobal(node.name, nil);
        else
            GetVariable(f, node.pIndex)[node.name] = nil;
        end

        igf[IG_MainFrame].refreshNow = true;
        f.refreshNow = true;
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	showAlert = 1
};

local function UpgradeFromSaved( ver )
    InspectorSaved = {};
    isInfo.CurrentVersion = ver;
    InspectorSaved = isInfo;
end

local function SaveSetup()
    -- Point the InspectorSaved table to the local isInfo table.
    InspectorSaved = {};
    InspectorSaved = isInfo;
end

-----------------------------------------------------------------------------
-- Load - Standard load routine for this addon.
--
local function Load(addon)

    --addon:printf(colors.title.c..isInfo.versionStr.." Addon Loaded");

    -- Setup the saved information for next time. InspectorSaved is global.
    if ( InspectorSaved == nil ) then
        SaveSetup();
    end

    -- If the saved data needs to be upgraded from old version.
    if ( InspectorSaved.CurrentVersion ~= isInfo.CurrentVersion ) then
        UpgradeFromSaved( isInfo.CurrentVersion );
    end

    -- Use the saved variables for this run.
    isInfo = InspectorSaved;

    -- Setup the slash command values.
    addon:AddCommands(AddonName, "inspt", SlashHandler);

    -- Hook into the GameTooltip.SetOwner routine
    addon:GameTooltip_SetOwnerHook( gameTooltip_SetOwner );

    -- Hook into the GameTooltip_OnHide routine.
    addon:GameTooltip_OnHideHook( gameTooltip_OnHide );

    -- Output a message to the center of the screen when load done.
	addon:msg(isInfo.versionStr.." Addon Loaded")
end

local function varsLoaded(addon, f)

    addon:AddFrame(f);

    if ( f == getglobal("IG_MainFrame") ) then

        addon:AddFrameFunc(f, "frameUpdate",    FrameUpdates);
        addon:AddFrameFunc(f, "processData",    processGlobals);
        addon:AddFrameFunc(f, "updateCounts",   UpdateCounts);
        addon:AddFrameFunc(f, "onShowFunc");
        addon:AddFrameFunc(f, "setTitle",       SetTitle);
        addon:AddFrameFunc(f, "refreshFunc",    Refresh);
        addon:AddFrameFunc(f, "refreshEnabled", true);
        addon:AddFrameFunc(f, "onHideFunc",     function(f)
                f.dataTable = { index = 1,total = 1, xlate = {} }; end );

        addon:AddFrameFunc(f, "initScrollFrame", function (f)
                local scroll = getglobal(f:GetName().."ListScrollFrame");
                FauxScrollFrame_SetOffset(scroll, 0);
                getglobal(scroll:GetName().."ScrollBar"):SetValue(0);
            end);

        addon:AddFrameData(f, "minimizeButton", {
            ["state"] = false,
            ["down"]  = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Down",
            ["up"]    = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Up",
            ["color"] = colors.title,; 
            ["anchor"]= "ANCHOR_TOPLEFT",
            ["text"]  = "Minimize "..AddonName } );

        addon:AddFrameData(f, "titleButton", {
            ["lines"]    = {
                [1] = { text = isInfo.versionStr, color = colors.title },
                [2] = { text = igd.longDesc, color = GRAY_FONT_COLOR }
            }
        } );

        addon:AddFrameData(f, "OnButtonClick", {
            ["LeftButton"] = function (fd)
                igd.varText  = getglobal(this:GetName().."Text"):GetText();

                if ( not IG_VarFrame:IsVisible() ) then
                    IG_VarFrame:Show();
                end

                igf[IG_VarFrame].refreshNow = true;
            end,
            ["RightButton"] = function (fd) end
        });

        addon:AddFrameData(f, "OnButtonEnter", function ()
            local f = igf[this:GetParent()];
            local text = getglobal(this:GetName().."Text"):GetText();

            if ( text == nil ) then
                return;
            end

            GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");

            local i, j, str, val;

            val = getfenv()[text];

            str = InspectorAddon:Serialize(text);
            i, j = strfind(str, "%s=%s");
            if ( strsub(str, 1, 2) == "[\"" ) then
                var = strsub(str, 3, i-3);
            else
                var = strsub(str, 1, i);
            end
            if ( type(val) == "function" ) then
                GameTooltip:SetText(
                    strfmt("%s %s%s()", type(val), colors.title.c, var),
                    colors.normal.r, colors.normal.g, colors.normal.b, 1);
            else
                GameTooltip:SetText(
                    strfmt("%s %s%s=", type(val), colors.title.c, var),
                    colors.normal.r, colors.normal.g, colors.normal.b, 1);
                GameTooltip:AddLine( strsub(str, j+1, -1),
                        colors.gold.r, colors.gold.g, colors.gold.b, 1);
            end
            GameTooltip:Show();
        end );

        local it = colors.tooltip;
        f:SetBackdropBorderColor(it.r, it.g, it.b, 1.0);

        it = colors.tooltipBG;
        f:SetBackdropColor(it.r, it.g, it.b, igd.iAlpha);

    elseif ( f == getglobal("IG_VarFrame") ) then

        addon:AddFrameFunc(f, "frameUpdate",    FrameUpdates);
        addon:AddFrameFunc(f, "processData",
            function (f) BuildTree(f, igd.varText); end);
        addon:AddFrameFunc(f, "updateCounts");
        addon:AddFrameFunc(f, "onShowFunc");
        addon:AddFrameFunc(f, "setTitle",       SetVariableTitle);
        addon:AddFrameFunc(f, "refreshFunc",    Refresh);
        addon:AddFrameFunc(f, "refreshEnabled", true);
        addon:AddFrameFunc(f, "onHideFunc",     function(f)
                f.dataTable = { index = 1,total = 1, xlate = {} }; end );

        addon:AddFrameFunc(f, "initScrollFrame", function (f)
                local scroll = getglobal(f:GetName().."ListScrollFrame");
                FauxScrollFrame_SetOffset(scroll, 0);
                getglobal(scroll:GetName().."ScrollBar"):SetValue(0);
            end);

        addon:AddFrameData(f, "minimizeButton", {
            ["state"] = false,
            ["down"]  = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Down",
            ["up"]    = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Up",
            ["color"] = colors.title,; 
            ["anchor"]= "ANCHOR_TOPLEFT",
            ["text"]  = "Minimize Variables" } );

        addon:AddFrameData(f, "titleButton", {
            ["lines"]    = {
                [1] = { text = AddonName.." Variable window", color = colors.title },
            }
        } );

        addon:AddFrameData(f, "OnButtonClick", {
            ["LeftButton"] = function (fd) end,
            ["RightButton"] = function (fd)
                local menu = getglobal(this:GetParent():GetName().."RightClickMenu");

                igd.dropDownIndex = getglobal(this:GetName()):GetID();

                menu.point  = "TOPLEFT";
                menu.relativePoint = "BOTTOMLEFT";

                ToggleDropDownMenu(1, nil, menu, this:GetName(), 0, 0);
            end
        });

        addon:AddFrameData(f, "OnButtonEnter", function ()
                local f = igf[this:GetParent()];
                local text = getglobal(this:GetName().."Text"):GetText();

                if ( text == nil ) then
                    return;
                end

                GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");

                local node, idx, val;

                idx = math.abs(getglobal(this:GetName()):GetID());
                node = f.dataTable.xlate[idx];

                if ( node.pIndex == 0 ) then
                    val = getglobal(node.name);
                else
                    val = GetVariable(f, node.pIndex)[node.name];
                end

                GameTooltip:SetText( strfmt("%s: %sRight Click to Edit",
                                            type(val), colors.gold.c),
                        colors.title.r, colors.title.g, colors.title.b, 1);
                GameTooltip:Show();
            end );

        local it = colors.tooltip;
        f:SetBackdropBorderColor(it.r, it.g, it.b, 1.0);

        it = colors.tooltipBG;
        f:SetBackdropColor(it.r, it.g, it.b, igd.iAlpha);

    elseif ( f == getglobal("IG_CfgFrame") ) then

        addon:AddFrameFunc(f, "frameUpdate");
        addon:AddFrameFunc(f, "processData");
        addon:AddFrameFunc(f, "updateCounts");
        addon:AddFrameFunc(f, "onShowFunc",
            function () 
                local count = getglobal(lbl.cfg.cEditBox);

                PanelTemplates_SetNumTabs(this, 2);
                PanelTemplates_SetTab(this, 1);

                if ( count:GetText() == "" ) then
                    count:SetText(igd.defaultCount);
                    count:Show();
                end
            end);
        addon:AddFrameFunc(f, "onHideFunc");
        addon:AddFrameFunc(f, "setTitle");
        addon:AddFrameFunc(f, "refreshFunc");
        addon:AddFrameFunc(f, "initScrollFrame");

        addon:AddFrameData(f, "minimizeButton", {
            ["state"] = false,
            ["down"]  = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Down",
            ["up"]    = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Up",
            ["color"] = colors.title,; 
            ["anchor"]= "ANCHOR_TOPLEFT",
            ["text"]  = "Configuration" } );

        addon:AddFrameData(f, "titleButton", {
            ["lines"]    = {
                [1] = { text = AddonName.." Configuration window", color = colors.title },
            }
        } );

        addon:AddFrameData(f, "OnCheckBoxEnter", function (fd) end );
        addon:AddFrameData(f, "OnCheckBoxClick", function (fd)
                igf[IG_MainFrame].refreshNow = true;
                igf[IG_VarFrame].refreshNow = true;
            end );

    elseif ( f == getglobal("IG_ScriptFrame") ) then

        addon:AddData("maxScriptTabs",  8);
        addon:AddData("scriptIndex",  1);

        addon:AddFrameFunc(f, "frameUpdate");
        addon:AddFrameFunc(f, "processData");
        addon:AddFrameFunc(f, "updateCounts");
        addon:AddFrameFunc(f, "onShowFunc",
            function () 
                PanelTemplates_SetNumTabs(this, igd.maxScriptTabs);
                PanelTemplates_SetTab(this, igd.scriptIndex);
            end);
        addon:AddFrameFunc(f, "onHideFunc");
        addon:AddFrameFunc(f, "setTitle");
        addon:AddFrameFunc(f, "refreshFunc");

        addon:AddFrameFunc(f, "initScrollFrame", function (f)
                local i;

                for i=1,igd.maxScriptTabs do
                    local name = f:GetName().."ScriptTab"..i;
                    local scroll = getglobal(name.."ListScrollFrame");
                    local txt;
                    FauxScrollFrame_SetOffset(scroll, 0);
                    getglobal(scroll:GetName().."ScrollBar"):SetValue(0);
                    txt = "InspectorAddon:chat('Hello World! ("..i..")')";
                    getglobal(lbl.script.sEditBox(i)):SetText(txt);
                end
            end);

        addon:AddFrameData(f, "minimizeButton", {
            ["state"] = false,
            ["down"]  = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Down",
            ["up"]    = "Interface\\AddOns\\"..AddonName.."\\MinimizeButton-Up",
            ["color"] = colors.title,; 
            ["anchor"]= "ANCHOR_TOPLEFT",
            ["text"]  = "Script Code" } );

        addon:AddFrameData(f, "titleButton", {
            ["lines"]    = {
                [1] = { text = AddonName.." Script window", color = colors.title },
            }
        } );

        addon:AddFrameData(f, "OnCheckBoxEnter", function (fd) end );
        addon:AddFrameData(f, "OnCheckBoxClick", function (fd)
                igf[IG_MainFrame].refreshNow = true;
                igf[IG_VarFrame].refreshNow = true;
            end );

    end

    addon:AddFrameData(f, "shown", 40);
    addon:AddFrameData(f, "refreshNow", false );
    addon:AddFrameData(f, "refreshTime", 0 );
    addon:AddFrameData(f, "refreshTimeout", 5 );
    addon:AddFrameData(f, "dataTable", { index = 1,total = 1, xlate = {} } );

end

local function initOnce(addon)
    local k, v;

    addon:AddData( "AddonInfo", {
        ["Author"]            = "Sagarus",
        ["WoWVersion"]        = "11100",
        ["CurrentVersion"]    = isInfo.CurrentVersion,
        ["ReleaseDate"]       = isInfo.ReleaseDate,
        ["shortDesc"]         = "Inspect Global Variables",
        ["longDesc"]          = "Add/Edit/Delete Global variables in the game",
        });

    addon:AddData("maxVarWidth",    550);
    addon:AddData("iAlpha",         0.5);
    addon:AddData("defaultCount",   4096);
    addon:AddData("itemHeight",     16);
    addon:AddData("varsHeight",     16);
    addon:AddData("searchText",     "");
    addon:AddData("varText",        "");
    addon:AddData("varName",        "");
    addon:AddData("dropDownIndex",  1);
    addon:AddData("iHeightPadding", 25);
    addon:AddData("iWidthPadding",  120);
    addon:AddData("timeout",        5);

    igd = addon:GetGlobalData();

    -- Used for key binding and with Binding.xml
    addon:SetBindingData( AddonName, function ()
                            if ( IG_MainFrame:IsVisible() ) then
                                IG_MainFrame:Hide();
                                if ( IG_CfgFrame:IsVisible() ) then
                                    IG_CfgFrame:Hide();
                                end
                            else
                                IG_MainFrame:Show();
                            end
                           end );

    addon:SetUsageFunc( function()
            InspectorAddon:chat("Available Commands: ");
            InspectorAddon:chat(" on|off -- " .. colors.yellow.c .. "Display/Hide Global Variables");
        end );

    for k,v in pairs(InspectorFrames) do
        varsLoaded(addon, k);
    end

    igf = addon:GetFrameData(nil);  -- When nil get frameData table.

    -- Call all of the scroll frame inits.
    for k,v in pairs(InspectorFrames) do
        igf[k].initScrollFrame(k);
    end

    -- Delete the temp variable.
    InspectorFrames = nil;

    Load(addon);

    addon:InitFinished();
end

-----------------------------------------------------------------------------
-- Inspector_OnEvent - Call the load routine if event is valid.
--
function Inspector_OnEvent(event)

	if ( event == "VARIABLES_LOADED" ) then 
	    InspectorAddon = addonClass:Register(AddonName,
                                            isInfo.CurrentVersion,
                                            initOnce);
    end
end

-----------------------------------------------------------------------------
--
--	Global OnLoad routine for Inspector called from the XML file.
--
function Inspector_OnLoad()

    if ( InspectorFrames == nil ) then
        InspectorFrames = {};

    	this:RegisterEvent("VARIABLES_LOADED");
    end

    InspectorFrames[this] = this:GetName();

end

-----------------------------------------------------------------------------
-- Allow only the Inspector table to be global, would like to have all addons
-- use more local variables. This method is OK, but it does require functions
-- to be ordered by usage. If you have a depend symbol loop then you have to
-- use Inspector.xxxx() to call the function along with adding it to this table.
--
Inspector = {
    MinimizeButton_OnClick  = MinimizeButton_OnClick,
    MinimizeButton_OnEnter  = MinimizeButton_OnEnter,
    OnMouseWheel            = OnMouseWheel,
    RightClickMenu_OnLoad   = RightClickMenu_OnLoad,

    Config                  = Config,
    ConfigButton_OnEnter    = function() button_OnEnter("Config"); end,
    ConfigFrame_Cancel      = function()
                                    PlaySound("gsTitleOptionExit");
                                    IG_CfgFrame:Hide();
                                end,
    ConfigFrame_Okay        = ConfigFrame_Okay,
    ConfigFrameTab_OnClick  = ConfigFrameTab_OnClick,

    Script                  = Script,
    ScriptButton_OnEnter    = function() button_OnEnter("Script"); end,
    ScriptFrame_Cancel      = function()
                                    PlaySound("gsTitleOptionExit");
                                    IG_ScriptFrame:Hide();
                                end,
    ScriptFrame_Save        = ScriptFrame_Save,
    ScriptFrame_Clear       = function() 
                                StaticPopup_Show("INSPECTOR_SCRIPT_CLEAR");
                              end,
    ScriptFrame_Execute     = ScriptFrame_Execute,
    ScriptFrameTab_OnClick  = ScriptFrameTab_OnClick,
    ScriptFrame_OnTextChanged = function()
                                    ScrollingEdit_OnTextChanged(this:GetParent():GetParent());
                                end,
    ScriptFrameEdit_OnUpdate = function ()
                                    ScrollingEdit_OnUpdate(this:GetParent():GetParent());
                               end,

    Toggle                   = function ()
                                if ( IG_MainFrame:IsVisible() ) then
                                    IG_MainFrame:Hide();
                                    if ( IG_CfgFrame:IsVisible() ) then
                                        IG_CfgFrame:Hide();
                                    end
                                else
                                    IG_MainFrame:Show();
                                end
                               end,
    SetLabel                = SetLabel,
    TextLabel               = TextLabel,
    UpdateFrame             = UpdateFrame,
    getTextHeight           = getTextHeight
};

