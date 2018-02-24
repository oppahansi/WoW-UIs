--[[---------------------------------------------------------------------------------
  Who Favorites
  Saves searches from who panel in a favorites list
  
  $Revision: 1.9 $
  $Date: 2005/10/26 11:59:43 $
------------------------------------------------------------------------------------]]

--[[
	Globals:

--]]

local DEFAULT_OPTIONS = {
	autoQuery = true
};

-- Chat commands

WHOFAV_OPTIONS = {
	{
		option = WHO_FAV.AUTOQUERY,
		desc = WHO_FAV.AUTOQUERY_DESC,
		method = "ToggleAutoQuery"
	}
};

ACE_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"};

StaticPopupDialogs["WHOF_SAVESEARCH"] = {
	text = WHO_FAV.POPUP_TEXT,
	button1 = WHO_FAV.SAVE,
	button2 = WHO_FAV.CANCEL,
	hasEditBox = 1,
	maxLetters = 40,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		WhoFav:SaveSearch(editBox:GetText());
		this:GetParent():Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
		getglobal(this:GetName().."EditBox"):SetText(WhoFrameEditBox:GetText());
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		WhoFav:SaveSearch(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

--[[
	Class Setup

--]]

    WhoFav = AceAddon:new({
        name          = WHO_FAV.NAME,
        description   = WHO_FAV.DESCRIPTION,
        version       = "1800.2",
        releaseDate   = "12-04-2005",
        aceCompatible = "102",
        author        = "Rizzle",
        email         = "rizzle@twisting-nether.horde",
        website       = "http://",
        category      = "others",
        optionsFrame  = nil,
        db            = AceDatabase:new("WhoFavDB"),
        defaults      = DEFAULT_OPTIONS,
        cmd           = AceChatCmd:new(WHO_FAV.COMMANDS, WHOFAV_OPTIONS),
    })

    function WhoFav:Initialize()
		self.GetOpt = function(var) local v=self.db:get(self.profilePath,var) return v end
		self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)	end
		self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
		
		if (self.GetOpt("autoQuery") == nil) then
			self.SetOpt("autoQuery", DEFAULT_OPTIONS.autoQuery);
		end
		
		-- setup search accessor/setter
		self.GetSearch = function(key)
			local v=self.db:get({self.profilePath, "WhoFavSearches"}, key)
			return v 
		end
		self.SetSearch = function(key, val) self.db:set({self.profilePath, "WhoFavSearches"}, key, val) end;
		self.AllSearches = function() 
			local v = self.db:get(self.profilePath, "WhoFavSearches");
			if (v == nill) then
				return {}
			end
			return v;
		end
		
		-- register to be notified when who interface comes up
		self:RegisterEvent("FRIENDLIST_SHOW", "Position")
		
		-- Tell the user we're initialized
		--DEFAULT_CHAT_FRAME:AddMessage(WHO_FAV.INITMSG, 0.8, 0.8, 0.2);
    end

	-- Enable disable simply show or hide the frame
    function WhoFav:Enable()
		DEFAULT_CHAT_FRAME:AddMessage(WHO_FAV.ENABLE_MSG, 0.8, 0.8, 0.2);
		WhoFavs:Show();
    end

    function WhoFav:Disable()
		DEFAULT_CHAT_FRAME:AddMessage(WHO_FAV.DISABLE_MSG, 0.8, 0.8, 0.2);
		WhoFavs:Hide();
    end

	-- Toggle AutoQuery
	function WhoFav:ToggleAutoQuery()
		self.TogOpt("autoQuery");
		if (self.GetOpt("autoQuery")) then
			DEFAULT_CHAT_FRAME:AddMessage(WHO_FAV.AUTOQUERY_ENABLE_MSG, 0.8, 0.8, 0.2);
		else
			DEFAULT_CHAT_FRAME:AddMessage(WHO_FAV.AUTOQUERY_DISABLE_MSG, 0.8, 0.8, 0.2);
		end
	end
		
	-- Save the current search criteria
	function WhoFav:SaveSearch(searchName)

		-- Gather up the fields
		local lastSearch = { 
			name = WhoFrameEditBox:GetText(), 
		}

		DEFAULT_CHAT_FRAME:AddMessage("added search \"" .. WhoFrameEditBox:GetText() .. "\" to Who Favorites.", 0.8, 0.8, 0.2);
		
		-- now save them
		self.SetSearch(searchName, lastSearch);
		
		-- reinitialize the popup to set the new value in the proper place
		UIDropDownMenu_Initialize(WhoFavs, WhoFavSearchesDropDown_Initialize);

		-- set the popup list to the newly saved entry
		
		-- This is the way to do it looking at the API, but when
		-- a pseudo dropdown is being used, an internal call
		-- to SetText in UIDropDown.lua fails because there
		-- is no currently selected label.
--		UIDropDownMenu_SetSelectedName(WhoFavs, searchName);

		-- Instead, set the internal vars directly.  This may blow up at
		-- some point in the future, but oh well.
		WhoFavs.selectedName = searchName;
		WhoFavs.selectedID = nil;
		WhoFavs.selectedValue = nil;

		-- run it
		SendWho(searchName);

	end
	
	function WhoFav:LoadSearch(searchName, clear)

		-- initialize for a blank search
		local lastSearch = { 
			name = "",
		};
		
		-- Get the selected search		
		if (not clear) then 
			lastSearch = self.GetSearch(searchName);
		end
				
		-- Load the fields
		WhoFrameEditBox:SetText(lastSearch["name"]);
		
		-- Update the popup to the current search, or clear it
		if (not clear) then
			-- See notes in SaveSearch
--			UIDropDownMenu_SetSelectedName(WhoFavs, searchName);
			WhoFavs.selectedName = searchName;
			WhoFavs.selectedID = nil;
			WhoFavs.selectedValue = nil;
		else
			-- See notes in SaveSearch
--			UIDropDownMenu_ClearAll(WhoFavs);
			WhoFavs.selectedName = nil;
			WhoFavs.selectedID = nil;
			WhoFavs.selectedValue = nil;
		end
		
		-- run it
		SendWho(lastSearch["name"]);
	end
	
	function WhoFav:DeleteSearch(searchName)
	
		-- check if nothing is selected, return if so
		if (searchName == nil) then
			return
		end
		
		-- Remove the search
		self.SetSearch(searchName, nil);
		
		-- Clear the previously selected search
		-- See notes in SaveSearch
--		UIDropDownMenu_ClearAll(WhoFavs);
		WhoFavs.selectedName = nil;
		WhoFavs.selectedID = nil;
		WhoFavs.selectedValue = nil;
	end

	
	-- Ace report
	function WhoFav:Report()
		self.cmd:report({
			{text=WHO_FAV.AUTOQUERY, val=self.GetOpt("autoQuery"), map=ACE_MAP_ONOFF},
		})
	end
	
	-- GUI Functions
	
	function WhoFav:SearchesDropDown_OnLoad()
		UIDropDownMenu_Initialize(this:GetParent(), WhoFavSearchesDropDown_Initialize);
		UIDropDownMenu_SetAnchor(-124, 0, this:GetParent(), "TOPLEFT", this:GetName(), "BOTTOMRIGHT")
	end
	
	function WhoFavSearchesDropDown_Initialize()
	
		-- Skip everything if WhoFav object hasn't loaded yet
		if (not WhoFav) then
			return
		end
		
		local info = {};
		local searches = {};

		-- Add a title item
		local favoritesTitle = {};
		favoritesTitle.text = WHO_FAV.FAVORITES;
		favoritesTitle.notClickable = true;
		favoritesTitle.notCheckable = true;		
		UIDropDownMenu_AddButton(favoritesTitle);

		-- Add a "hint"
		local favoritesHint = {};
		favoritesHint.text = WHO_FAV.HINTINFO;
		favoritesHint.notClickable = true;
		favoritesHint.notCheckable = true;		
		UIDropDownMenu_AddButton(favoritesHint);

		
		-- Add all the saved searches
		if (WhoFav.AllSearches) then
			searches = WhoFav:AllSearches();
		end
						
		for i,v in pairsByKeys(searches) do
			info.text = i;
			local staticText = i;
			info.func = function () WhoFav:LoadSearch(staticText); end;
			info.checked = false;
			UIDropDownMenu_AddButton(info);
		end
		
		-- Separator
		local separator = {};
		separator.text = "--------";
		separator.notClickable = true;
		separator.notCheckable = true;
		
		UIDropDownMenu_AddButton(separator);
		
		-- Save Button
		info.text = WHO_FAV.SAVE;
		info.func = function () StaticPopup_Show("WHOF_SAVESEARCH"); end;
		info.notCheckable = true;
		info.checked = false;

		UIDropDownMenu_AddButton(info);
		
		-- Delete Button
		info.text = WHO_FAV.DELETE;
		info.func = function ()
			currentSearch = UIDropDownMenu_GetSelectedName(WhoFavs);
			WhoFav:DeleteSearch(currentSearch); 
		end;
		info.notCheckable = true;
		info.checked = false;
		
		UIDropDownMenu_AddButton(info);

		-- Clear Button
		info.text = WHO_FAV.CLEAR;
		info.func = function ()
			WhoFav:LoadSearch(nil, true); 
		end;
		info.notCheckable = true;
		info.checked = false;
		
		UIDropDownMenu_AddButton(info);

	end
	
	-- repositions WhoFav dropdown with dynamic loaded friends interface
	function WhoFav:Position()
		WhoFavs:ClearAllPoints()
		WhoFavs:SetParent("WhoFrameEditBox")
		WhoFavs:SetFrameStrata("HIGH")
		WhoFavs:SetPoint("TOPLEFT", "WhoFrameEditBox", "TOPLEFT", 195, -45)
		WhoFavsButton:Show()
		WhoFavs:Show()
	end
	
	-- Utility function to sort searches
	-- Lifted from LUA book online
	function pairsByKeys (t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if a[i] == nil then return nil
			else return a[i], t[a[i]]
			end
		end
		return iter
    end

--[[
	register the class

--]]

    WhoFav:RegisterForLoad()

