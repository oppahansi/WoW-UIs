--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
AtlasLoot_OnEvent(event)
AtlasLoot_ShowMenu()
AtlasLoot_OnVariablesLoaded()
AtlasLoot_SlashCommand(msg)
AtlasLootOptions_Toggle()
AtlasLoot_OnLoad()
AtlasLootBoss_OnClick()
AtlasLoot_SetItemPrice(text, icon, textData, iconData)
AtlasLoot_ShowItemsFrame()
AtlasLoot_SetupForAtlas()
AtlasLoot_SetItemInfoFrame()
AtlasLootItemsFrame_OnCloseButton()
AtlasLootMenuItem_OnClick()
AtlasLoot_NavButton_OnClick()
AtlasLoot_HeroicModeToggle()
AtlasLoot_IsLootTableAvailable(dataID)
AtlasLoot_GetLODModule(dataSource)
AtlasLoot_LoadAllModules()
AtlasLoot_ShowQuickLooks(button)
AtlasLoot_RefreshQuickLookButtons()
]]

AtlasLoot = AceLibrary("AceAddon-2.0"):new("AceDB-2.0")

--Instance required libraries
local BabbleBoss = LibStub("LibBabble-Boss-3.0"):GetLookupTable();
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

--Establish version number and compatible version of Atlas
local VERSION_MAJOR = "4";
local VERSION_MINOR = "06";
local VERSION_BOSSES = "04";
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot Enhanced v"..VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES.."|r";
ATLASLOOT_CURRENT_ATLAS = "1.12.0";
ATLASLOOT_PREVIEW_ATLAS = "1.12.1";

--Standard indent to line text up with Atlas text
ATLASLOOT_INDENT = "   ";

--Make the Dewdrop menu in the standalone loot browser accessible here
AtlasLoot_Dewdrop = AceLibrary("Dewdrop-2.0");
AtlasLoot_DewdropSubMenu = AceLibrary("Dewdrop-2.0");

--Variable to cap debug spam
ATLASLOOT_DEBUGSHOWN = false;

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 25;

--Flag so that error messages do not spam
local ATLASLOOT_POPUPSHOWN = false;

--Set the default anchor for the loot frame to the Atlas frame
AtlasLoot_AnchorFrame = AtlasFrame;

--Variables to hold hooked Atlas functions
Hooked_Atlas_Refresh = nil;
Hooked_Atlas_OnShow = nil;
Hooked_AtlasScrollBar_Update = nil;

AtlasLootCharDB={};

AtlasLoot:RegisterDB("AtlasLootDB");

AtlasLoot:RegisterDefaults('profile', {
	SavedTooltips = {},
	SafeLinks = true,
	AllLinks = true,
	DefaultTT = true,
	LootlinkTT = false,
	ItemSyncTT = false,
	EquipCompare = false,
	Opaque = false,
	ItemIDs = false,
	ItemSpam = false,
	MinimapButton = true,
	HidePanel = false,
	LastBoss = "HCRampWatchkeeper",
	LastBossText = BabbleBoss["Watchkeeper Gargolmar"],
	HeroicMode = false,
	AtlasLootVersion = "1",
	AutoQuery = false,
	LoDNotify = false,
	LoadAllLoDStartup = false,
	PartialMatching = true,
	SearchOn = {
		All = true,
	},
})

AtlasLoot_MenuList = {
	"ABMENU",
	"AQ20SET",
	"PRE60SET",
	"ZGSET",
	"T6SET",
	"T5SET",
	"T4SET",
	"T3SET",
	"T1T2SET",
	"T0SET",
	"PVPMENU",
	"PVPSET",
	"PVP70RepSET",
	"PVP70NONSETEPICS",
	"ARENASET",
	"ARENA2SET",
	"ARENA3SET",
	"ARENA4SET",
	"DS3SET",
	"CRAFTSET",
	"CRAFTSET2",
	"REPMENU_AZEROTHPREBC",
	"REPMENU_AZEROTHPOSTBC",
	"REPMENU_OUTLAND",
	"REPMENU_SHATTRATH",
	"REPMENU",
	"SETMENU",
	"CRAFTINGMENU",
	"SKETTISMENU",
	"70TOKENMENU",
	"WORLDEPICS",
	"WORLDEVENTMENY",
	"WSGMENU",
	"ABYSSALMENU",
	"ETHEREUMMENU",
	"HONORMENU",
	"ARENAMENU",
	"ALCHEMYMENU",
	"SMITHINGMENU",
	"ENCHANTINGMENU",
	"ENGINEERINGMENU",
	"JEWELCRAFTINGMENU",
	"LEATHERWORKINGMENU",
	"TAILORINGMENU",
	"COOKINGMENU",
};

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
  text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."].."\n\n"..AL["New feature in 4.05.00: All professions are now included in the AtlasLoot_Crafting module."].."\n\n"..AL["New feature in 4.05.00: Advanced searching functionality is now available. You can type in a partial item name, for example typing 'elixir' gives all items in the database with 'elixir' in the name.  Big thanks to Kurax for his help."].."\n",
  button1 = AL["Setup"],
  OnAccept = function()
	  AtlasLootOptions_Toggle();
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--Popup Box for an old version of Atlas
StaticPopupDialogs["ATLASLOOT_OLD_ATLAS"] = {
  text = AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("]..ATLASLOOT_CURRENT_ATLAS..AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."],
  button1 = AL["OK"],
  OnAccept = function()
	  DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Incompatible Atlas Detected"]);
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--[[
AtlasLoot_OnEvent(event):
event - Name of the event, passed from the API
Invoked whenever a relevant event is detected by the engine.  The function then
decides what action to take depending on the event.
]]
function AtlasLoot_OnEvent(event)
	--Addons all loaded
	if(event == "VARIABLES_LOADED") then
		AtlasLoot_OnVariablesLoaded();
	--Taint errors
	elseif(arg1 == "AtlasLoot") then
		--Junk command to suppress taint message
		local i=3;
	end
end

--[[
AtlasLoot_ShowMenu:
Legacy function used in Cosmos integration to open the loot browser
]]
function AtlasLoot_ShowMenu()
	AtlasLootDefaultFrame:Show();
end

--[[
AtlasLoot_OnVariablesLoaded:
Invoked by the VARIABLES_LOADED event.  Now that we are sure all the assets
the addon needs are in place, we can properly set up the mod
]]
function AtlasLoot_OnVariablesLoaded()
	if not AtlasLootCharDB then AtlasLootCharDB = {} end
	if not AtlasLootCharDB["WishList"] then AtlasLootCharDB["WishList"] = {} end
    if not AtlasLootCharDB["QuickLooks"] then AtlasLootCharDB["QuickLooks"] = {} end
	if not AtlasLootCharDB["SearchResult"] then AtlasLootCharDB["SearchResult"] = {} end
	--Add the loot browser to the special frames tables to enable closing wih the ESC key
	tinsert(UISpecialFrames, "AtlasLootDefaultFrame");
	--Set up options frame
	AtlasLootOptions_OnLoad();
	--Legacy code for those using the ultimately failed attempt at making Atlas load on demand
	if AtlasButton_LoadAtlas then
		AtlasButton_LoadAtlas();
	end
	--Hook the necessary Atlas functions
    Hooked_Atlas_Refresh = Atlas_Refresh;
    Atlas_Refresh = AtlasLoot_Refresh;
	Hooked_Atlas_OnShow = Atlas_OnShow;
	Atlas_OnShow = AtlasLoot_Atlas_OnShow;
	--Instead of hooking, replace the scrollbar driver function
    Hooked_AtlasScrollBar_Update = AtlasScrollBar_Update;
	AtlasScrollBar_Update = AtlasLoot_AtlasScrollBar_Update;
	--Disable options that don't have the supporting mods
	if( not LootLink_SetTooltip and (AtlasLoot.db.profile.LootlinkTT == true)) then
		AtlasLoot.db.profile.LootlinkTT = false;
		AtlasLoot.db.profile.DefaultTT = true;
	end
	if( not ItemSync and (AtlasLoot.db.profile.ItemSyncTT == true)) then
		AtlasLoot.db.profile.ItemSyncTT = false;
		AtlasLoot.db.profile.DefaultTT = true;
	end
	--If using an opaque items frame, change the alpha value of the backing texture
	if (AtlasLoot.db.profile.Opaque) then
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
	else
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
	end
	--If Atlas is installed, set up for Atlas
	if ( Hooked_Atlas_Refresh ) then
		AtlasLoot_SetupForAtlas();
		--If a first time user, set up options
		if( (AtlasLoot.db.profile.AtlasLootVersion == nil) or (tonumber(AtlasLoot.db.profile.AtlasLootVersion) < 40500)) then
			AtlasLoot.db.profile.SafeLinks = true;
			AtlasLoot.db.profile.AllLinks = false;
			AtlasLoot.db.profile.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
			StaticPopup_Show ("ATLASLOOT_SETUP");
		end
		--If not the expected Atlas version
		if( ATLAS_VERSION ~= ATLASLOOT_CURRENT_ATLAS and ATLAS_VERSION ~= ATLASLOOT_PREVIEW_ATLAS ) then
			StaticPopup_Show ("ATLASLOOT_OLD_ATLAS");
		end
		Hooked_Atlas_Refresh();
	else
		--If we are not using Atlas, keep the items frame out of the way
		AtlasLootItemsFrame:Hide();
	end
	--Check and migrate old WishList entry format to the newer one
	if((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < 40301)) then
		--Check if we really need to do a migration since it will load all modules
		--We also create a helper table here which store IDs that need to search for
		local idsToSearch = {};
		for i = 1, #AtlasLootCharDB["WishList"] do
			if (AtlasLootCharDB["WishList"][i][1] > 0 and not AtlasLootCharDB["WishList"][i][5]) then
				tinsert(idsToSearch, i, AtlasLootCharDB["WishList"][i][1]);
			end
		end
		if #idsToSearch > 0 then
			--Let's do this
			AtlasLoot_LoadAllModules();
			for _, dataSource in ipairs(AtlasLoot_SearchTables) do
				if AtlasLoot_Data[dataSource] then
					for dataID, lootTable in pairs(AtlasLoot_Data[dataSource]) do
						for _, entry in ipairs(lootTable) do
							for k, v in pairs(idsToSearch) do
								if(entry[1] == v)then
									AtlasLootCharDB["WishList"][k][5] = dataID.."|"..dataSource;
									break;
								end
							end
						end
					end
				end
			end
		end
		AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
	end
	if((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < 40301)) then
		AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
		AtlasLootCharDB.AutoQuery = false;
		AtlasLootOptions_Init();
	end
	--Adds an AtlasLoot button to the Feature Frame in Cosmos
	if(EarthFeature_AddButton) then
		EarthFeature_AddButton(
			{
				id = string.sub(ATLASLOOT_VERSION, 11, 28);
				name = string.sub(ATLASLOOT_VERSION, 11, 28);
				subtext = string.sub(ATLASLOOT_VERSION, 30, 39);
				tooltip = "";
				icon = "Interface\\Icons\\INV_Box_01";
				callback = AtlasLoot_ShowMenu;
				test = nil;
			}
	);
	--Adds AtlasLoot to old style Cosmos installations
	elseif(Cosmos_RegisterButton) then
		Cosmos_RegisterButton(
			string.sub(ATLASLOOT_VERSION, 11, 28),
			string.sub(ATLASLOOT_VERSION, 11, 28),
			"",
			"Interface\\Icons\\INV_Box_01",
			AtlasLoot_ShowMenu
		);
	end
	--Set up the menu in the loot browser
	AtlasLoot_DewdropRegister();
	--Enable or disable AtlasLootFu based on seleced options
	if AtlasLoot.db.profile.MinimapButton == false then
		AtlasLootFu:Hide();
	else
		AtlasLootFu:Show();
		if FuBar then
			if AtlasLootFu:IsMinimapAttached() then
				AtlasLootFu:ToggleMinimapAttached()
			end
		end
	end
	--If EquipCompare is available, use it
	if((EquipCompare_RegisterTooltip) and (AtlasLoot.db.profile.EquipCompare == true)) then
		EquipCompare_RegisterTooltip(AtlasLootTooltip);
	end
	--Position relevant UI objects for loot browser and set up menu
	AtlasLootDefaultFrame_SelectedCategory:SetPoint("TOP", "AtlasLootDefaultFrame_Menu", "BOTTOM", 0, -4);
	AtlasLootDefaultFrame_SelectedTable:SetPoint("TOP", "AtlasLootDefaultFrame_SubMenu", "BOTTOM", 0, -4);
	AtlasLootDefaultFrame_SelectedCategory:SetText(AL["Choose Table ..."]);
	AtlasLootDefaultFrame_SelectedTable:SetText("");
	AtlasLootDefaultFrame_SelectedCategory:Show();
	AtlasLootDefaultFrame_SelectedTable:Show();
	AtlasLootDefaultFrame_SubMenu:Disable();
	if (AtlasLoot.db.profile.LoadAllLoDStartup == true) then
		AtlasLoot_LoadAllModules();
	else
		collectgarbage("collect");
	end
end

--[[
AtlasLoot_SlashCommand(msg):
msg - takes the argument for the /atlasloot command so that the appropriate action can be performed
If someone types /atlasloot, bring up the options box
]]
function AtlasLoot_SlashCommand(msg)
	if msg == AL["reset"] then
		AtlasLoot.db.profile.LastBoss = "HCRampWatchkeeper";
		AtlasLoot.db.profile.LastBossText = BabbleBoss["Watchkeeper Gargolmar"];
		AtlasLootDefaultFrame:ClearAllPoints();
		AtlasLootDefaultFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		AtlasLootOptionsFrame:ClearAllPoints();
		AtlasLootOptionsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
        AtlasLootCharDB["QuickLooks"] = {};
        AtlasLoot_RefreshQuickLookButtons();
		DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Reset complete!"]);
	elseif msg == AL["options"] then
		AtlasLootOptions_Toggle();
	else
		AtlasLootDefaultFrame:Show();
	end
end

--[[
AtlasLootOptions_Toggle:
Toggle on/off the options window
]]
function AtlasLootOptions_Toggle()
	if(AtlasLootOptionsFrame:IsVisible()) then
		--Hide the options frame if already shown
		AtlasLootOptionsFrame:Hide();
	else
		AtlasLootOptionsFrame:Show();
		--Workaround for a weird quirk where tooltip settings so not immediately take effect
		if(AtlasLoot.db.profile.DefaultTT == true) then
			AtlasLootOptions_DefaultTTToggle();
		elseif(AtlasLoot.db.profile.LootlinkTT == true) then
			AtlasLootOptions_LootlinkTTToggle();
		elseif(AtlasLoot.db.profile.ItemSyncTT == true) then
			AtlasLootOptions_ItemSyncTTToggle();
		end
	end
end

--[[
AtlasLoot_OnLoad:
Performs inital setup of the mod and registers it for further setup when
the required resources are in place
]]
function AtlasLoot_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_ACTION_FORBIDDEN");
	this:RegisterEvent("ADDON_ACTION_BLOCKED");
	--Enable the use of /al or /atlasloot to open the loot browser
	SLASH_ATLASLOOT1 = "/atlasloot";
	SLASH_ATLASLOOT2 = "/al";
	SlashCmdList["ATLASLOOT"] = function(msg)
		AtlasLoot_SlashCommand(msg);
	end
end

--[[
AtlasLoot_SetItemPrice(extraFrame, data, hideExtra):
extraFrame - The Extra fontstring object
data - A data entry
hideExtra - Set to hide the extra frame (Use for WishList)
]]
local function AtlasLoot_SetItemPrice(extraFrame, data, hideExtra)
	local priceText = data[5];
	if priceText and priceText ~= "" then
		if string.find(priceText, "%%") then return end
		priceText = AtlasLoot_FixText(priceText);
		if hideExtra then
			extraFrame:SetText(priceText);
		else
			extraFrame:SetText((extraFrame:GetText() or "").."  "..priceText);
		end
	end
end

--[[
AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame):
dataID - Name of the loot table
dataSource - Table in the database where the loot table is stored
boss - Text string to use as a title for the loot page
pFrame - Data structure describing how and where to anchor the item frame (more details, see the function AtlasLoot_SetItemInfoFrame)
This fuction is not normally called directly, it is usually invoked by AtlasLoot_ShowBossLoot.
It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
]]
function AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame)
	--Set up local variables needed for GetItemInfo, etc
	local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemColor;
	local iconFrame, nameFrame, extraFrame, itemButton;
	local text, extra;
	local wlPage, wlPageMax = 1, 1;
	local isItem;
	local spellName, spellIcon;

    if dataID == "SearchResult" and dataID == "WishList" then
        AtlasLoot_IsLootTableAvailable(dataID);
    end
    
	dataSource_backup = dataSource;
	if dataSource ~= "dummy" then
		if dataID == "SearchResult" or dataID == "WishList" then
			dataSource = {};
			-- Match the page number to display
			wlPage = tonumber(dataSource_backup:match("%d+$"));
			-- Aquiring items of the page
			if dataID == "SearchResult" then
				dataSource[dataID], wlPageMax = AtlasLoot:GetSearchResultPage(wlPage);
			elseif dataID == "WishList" then
				dataSource[dataID], wlPageMax = AtlasLoot_GetWishListPage(wlPage);
			end
			-- Make page number reasonable
			if wlPage < 1 then wlPage = 1 end
			if wlPage > wlPageMax then wlPage = wlPageMax end
		else
			dataSource = AtlasLoot_Data[dataSource_backup];
		end
	end

	--If the data source has not been passed, throw up a debugging statement
	if dataSource==nil then
		DEFAULT_CHAT_FRAME:AddMessage("No dataSource!");
	end

	--If the loot table name has not been passed, throw up a debugging statement
	if dataID==nil then
		DEFAULT_CHAT_FRAME:AddMessage("No dataID!");
	end

	--Set up checks to see if we have a heroic loot table or not
	local HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
	local HeroicdataID=dataID.."HEROIC";
	local NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-6);

	--Get AtlasQuest out of the way
	if (AtlasQuestInsideFrame) then
		HideUIPanel(AtlasQuestInsideFrame);
	end

	--Hide the toggle to switch between heroic and normal loot tables, we will only show it if required
	AtlasLootItemsFrame_Heroic:Hide();
    
    --Ditch the Quicklook selector
    AtlasLoot_QuickLooks:Hide();
    AtlasLootQuickLooksButton:Hide();

	--Change the dataID to be consistant with the Heroic Mode toggle
	if dataSource then
		if((AtlasLoot.db.profile.HeroicMode == nil) or (AtlasLoot.db.profile.HeroicMode == false)) then
			if(HeroicCheck == "HEROIC") then
				if dataSource[NonHeroicdataID] then
					dataID=NonHeroicdataID;
				end
			end
		elseif(AtlasLoot.db.profile.HeroicMode == true) then
			if(HeroicCheck ~= "HEROIC") then
				if dataSource[HeroicdataID] then
					dataID=HeroicdataID;
				end
			end
		end
	end

	--Hide the menu objects.  These are not required for a loot table
	for i = 1, 30, 1 do
		getglobal("AtlasLootMenuItem_"..i):Hide();
	end

	--Escape out of this function if creating a menu, this function only handles loot tables.
	--Inserting escapes in this way allows consistant calling of data whether it is a loot table or a menu.
	if(dataID=="PRE60SET") then
		AtlasLootPRE60SetMenu();
	elseif(dataID=="ZGSET") then
		AtlasLootZGSetMenu();
	elseif(dataID=="T6SET") then
		AtlasLootT6SetMenu();
	elseif(dataID=="T5SET") then
		AtlasLootT5SetMenu();
	elseif(dataID=="T4SET") then
		AtlasLootT4SetMenu();
	elseif(dataID=="T3SET") then
		AtlasLootT3SetMenu();
	elseif(dataID=="T1T2SET") then
		AtlasLootT1T2SetMenu();
	elseif(dataID=="T0SET") then
		AtlasLootT0SetMenu();
	elseif(dataID=="PVPMENU") then
		AtlasLootPvPMenu();
	elseif(dataID=="PVPSET") then
		AtlasLootPVPSetMenu();
	elseif(dataID=="PVP70RepSET") then
		AtlasLootPVP70RepSetMenu();
	elseif(dataID=="PVP70NONSETEPICS") then
		AtlasLootPvPNonSetEpics();
	elseif(dataID=="ARENASET") then
		AtlasLootARENASetMenu();
	elseif(dataID=="ARENA2SET") then
		AtlasLootARENA2SetMenu();
	elseif(dataID=="ARENA3SET") then
		AtlasLootARENA3SetMenu();
	elseif(dataID=="ARENA4SET") then
		AtlasLootARENA4SetMenu();
	elseif(dataID=="DS3SET") then
		AtlasLootDS3SetMenu();
	elseif(dataID=="CRAFTINGMENU") then
		AtlasLoot_CraftingMenu();
	elseif(dataID=="CRAFTSET") then
		AtlasLootCraftedSetMenu();
	elseif(dataID=="CRAFTSET2") then
		AtlasLootCraftedSetMenu2();
	elseif(dataID=="REPMENU_AZEROTHPREBC") then
		AtlasLootRepMenu_AzerothPreBC();
	elseif(dataID=="REPMENU_AZEROTHPOSTBC") then
		AtlasLootRepMenu_AzerothPostBC();
	elseif(dataID=="REPMENU_OUTLAND") then
		AtlasLootRepMenu_Outland();
	elseif(dataID=="REPMENU_SHATTRATH") then
		AtlasLootRepMenu_Shattrath();
	elseif(dataID=="REPMENU") then
		AtlasLootRepMenu();
	elseif(dataID=="SETMENU") then
		AtlasLootSetMenu();
	elseif(dataID=="70TOKENMENU") then
		AtlasLoot70TokenMenu();
	elseif(dataID=="WORLDEPICS") then
		AtlasLootWorldEpicsMenu();
	elseif(dataID=="WSGMENU") then
		AtlasLootWSGRewardsMenu();
	elseif(dataID=="ABMENU") then
		AtlasLootABRewardsMenu();
	elseif(dataID=="WORLDEVENTMENU") then
		AtlasLootWorldEventMenu();
	elseif(dataID=="SKETTISMENU") then
		AtlasLootSkettisMenu();
	elseif(dataID=="ETHEREUMMENU") then
		AtlasLootEthereumPrisonMenu();
	elseif(dataID=="ABYSSALMENU") then
		AtlasLootAbyssalCouncilMenu();
	elseif(dataID=="HONORMENU") then
		AtlasLootPvPHonorSystemMenu();
	elseif(dataID=="ARENAMENU") then
		AtlasLootPvPArenaSystemMenu();
	elseif(dataID=="ALCHEMYMENU") then
		AtlasLoot_AlchemyMenu();
	elseif(dataID=="SMITHINGMENU") then
		AtlasLoot_SmithingMenu();
	elseif(dataID=="ENCHANTINGMENU") then
		AtlasLoot_EnchantingMenu();
	elseif(dataID=="ENGINEERINGMENU") then
		AtlasLoot_EngineeringMenu();
	elseif(dataID=="JEWELCRAFTINGMENU") then
		AtlasLoot_JewelcrafingMenu();
	elseif(dataID=="LEATHERWORKINGMENU") then
		AtlasLoot_LeatherworkingMenu();
	elseif(dataID=="TAILORINGMENU") then
		AtlasLoot_TailoringMenu();
	elseif(dataID=="COOKINGMENU") then
		AtlasLoot_CookingMenu();
	else
		--Iterate through each item object and set its properties
		for i = 1, 30, 1 do
			--Check for a valid object (that it exists, and that it has a name)
			if(dataSource[dataID][i] ~= nil and dataSource[dataID][i][3] ~= "") then
				if string.sub(dataSource[dataID][i][1], 1, 1) == "s" then
					isItem = false;
				else
					isItem = true;
				end
				if isItem then
					itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(dataSource[dataID][i][1]);
					--If the client has the name of the item in cache, use that instead.
					--This is poor man's localisation, English is replaced be whatever is needed
					if(GetItemInfo(dataSource[dataID][i][1])) then
						_, _, _, itemColor = GetItemQualityColor(itemQuality);
						text = itemColor..itemName;
					else
						if(GetItemInfo(dataSource[dataID][i][1])) then
							_, _, _, itemColor = GetItemQualityColor(itemQuality);
							text = itemColor..itemName;
						else
							--If the item is not in cache, use the saved value and process it
							text = dataSource[dataID][i][3];
							text = AtlasLoot_FixText(text);
						end
					end
				else
					spellName, _, spellIcon, _, _, _, _, _, _ = GetSpellInfo(string.sub(dataSource[dataID][i][1], 2));
					text = AtlasLoot_FixText(string.sub(dataSource[dataID][i][3], 1, 4)..spellName)
				end

				--Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
				AtlasLootItemsFrame.refresh = {dataID, dataSource_backup, boss, pFrame};

                --This is a valid QuickLook, so show the UI objects
                AtlasLoot_QuickLooks:Show();
                AtlasLootQuickLooksButton:Show();
                
				--Insert the item description
				extra = dataSource[dataID][i][4];
				extra = AtlasLoot_FixText(extra);

				--Use shortcuts for easier reference to parts of the item button
				itemButton = getglobal("AtlasLootItem_"..i);
				iconFrame  = getglobal("AtlasLootItem_"..i.."_Icon");
				nameFrame  = getglobal("AtlasLootItem_"..i.."_Name");
				extraFrame = getglobal("AtlasLootItem_"..i.."_Extra");

				--If there is no data on the texture an item should have, show a big red question mark
				if dataSource[dataID][i][2] == "?" then
					iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
				elseif dataSource[dataID][i][2] == "" then
					iconFrame:SetTexture(GetItemIcon(dataSource[dataID][i][1]));
				elseif (not isItem) and (spellIcon) then
					if type(dataSource[dataID][i][2]) == "number" then
						iconFrame:SetTexture(GetItemIcon(dataSource[dataID][i][2]));
					elseif type(dataSource[dataID][i][2]) == "string" then
						iconFrame:SetTexture("Interface\\Icons\\"..dataSource[dataID][i][2]);
					else
						iconFrame:SetTexture(spellIcon);
					end
				else
					--else show the texture
					iconFrame:SetTexture("Interface\\Icons\\"..dataSource[dataID][i][2]);
				end
				if iconFrame:GetTexture() == nil then
					iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
					itemButton.itemTexture = "Interface\\Icons\\INV_Misc_QuestionMark";
				else
					itemButton.itemTexture = iconFrame:GetTexture();
				end
				--Set the name and description of the item
				nameFrame:SetText(text);
				extraFrame:SetText(extra);
				extraFrame:Show();

				--Set prices for items, up to 5 different currencies can be used in combination
				--If at WishList page, display price instead of boss name
				if (dataID == "SearchResult" or dataID == "WishList") and dataSource[dataID][i][5] then
					local wishDataID, wishDataSource = strsplit("|", dataSource[dataID][i][5]);
					--Determine if need to do a price search, this may not the best way but an easy and fast one
					if wishDataSource == "AtlasLootBGItems" or wishDataSource == "AtlasLootGeneralPvPItems" or wishDataSource == "AtlasLootSetItems" or wishDataSource == "AtlasLootWorldPvPItems" then
						if wishDataID and AtlasLoot_IsLootTableAvailable(wishDataID) then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if dataSource[dataID][i][1] == v[1] then
									AtlasLoot_SetItemPrice(extraFrame, v, true);
									break;
								end
							end
						end
					end
				else
					AtlasLoot_SetItemPrice(extraFrame, dataSource[dataID][i], false);
				end

				--For convenience, we store information about the objects in the objects so that it can be easily accessed later
				itemButton.itemID = dataSource[dataID][i][1];
                itemButton.iteminfo = {};
				if isItem then
					itemButton.iteminfo.idcore = dataSource[dataID][i][1];
					itemButton.iteminfo.icontexture = GetItemIcon(dataSource[dataID][i][1]);
				    itemButton.storeID = dataSource[dataID][i][1];
                    itemButton.dressingroomID = dataSource[dataID][i][1];
                else
				    itemButton.iteminfo.idcore = dataSource[dataID][i][2];
					itemButton.iteminfo.icontexture = GetItemIcon(dataSource[dataID][i][2]);
                    itemButton.storeID = dataSource[dataID][i][2];
                    itemButton.dressingroomID = dataSource[dataID][i][2];
				end
				itemButton.droprate = nil;
				if dataID == "SearchResult" or dataID == "WishList" then
					itemButton.sourcePage = dataSource[dataID][i][5];
				else
					local droprate = dataSource[dataID][i][5];
					if droprate and string.find(droprate, "%%") then itemButton.droprate = droprate end
				end
				itemButton.i = 1;
				itemButton:Show();

				--If the item is not in cache, querying the server may cause a disconnect
				--Show a red box around the item to indicate this to the user
				if((not GetItemInfo(dataSource[dataID][i][1])) and (dataSource[dataID][i][1] ~= 0) and isItem) then
					getglobal("AtlasLootItem_"..i.."_Unsafe"):Show();
				else
					getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide();
				end

				--Decide whether to show the Heroic mode toggle
				--Checks if a heroic version of the loot table is available.
				HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
				HeroicdataID=dataID.."HEROIC";
				if dataSource[HeroicdataID] then
					AtlasLootItemsFrame_Heroic:Show();
					AtlasLootItemsFrame_Heroic:SetChecked(false);
				else
					if HeroicCheck=="HEROIC" then
						AtlasLootItemsFrame_Heroic:Show();
						AtlasLootItemsFrame_Heroic:SetChecked(true);
					end
				end
			else
				getglobal("AtlasLootItem_"..i):Hide();
			end
		end

		--Hide navigation buttons by default, only show what we need
		getglobal("AtlasLootItemsFrame_BACK"):Hide();
		getglobal("AtlasLootItemsFrame_NEXT"):Hide();
		getglobal("AtlasLootItemsFrame_PREV"):Hide();
		AtlasLoot_BossName:SetText(boss);
		--Consult the button registry to determine what nav buttons are required
		if dataID == "SearchResult" or dataID == "WishList" then
			if wlPage < wlPageMax then
				getglobal("AtlasLootItemsFrame_NEXT"):Show();
				getglobal("AtlasLootItemsFrame_NEXT").lootpage = dataID.."Page"..(wlPage + 1);
			end
			if wlPage > 1 then
				getglobal("AtlasLootItemsFrame_PREV"):Show();
				getglobal("AtlasLootItemsFrame_PREV").lootpage = dataID.."Page"..(wlPage - 1);
			end
		elseif AtlasLoot_ButtonRegistry[dataID] then
			local tablebase = AtlasLoot_ButtonRegistry[dataID];
			AtlasLoot_BossName:SetText(tablebase.Title);
			if tablebase.Next_Page then
				getglobal("AtlasLootItemsFrame_NEXT"):Show();
				getglobal("AtlasLootItemsFrame_NEXT").lootpage = tablebase.Next_Page;
				getglobal("AtlasLootItemsFrame_NEXT").title = tablebase.Next_Title;
			end
			if tablebase.Prev_Page then
				getglobal("AtlasLootItemsFrame_PREV"):Show();
				getglobal("AtlasLootItemsFrame_PREV").lootpage = tablebase.Prev_Page;
				getglobal("AtlasLootItemsFrame_PREV").title = tablebase.Prev_Title;
			end
			if tablebase.Back_Page then
				getglobal("AtlasLootItemsFrame_BACK"):Show();
				getglobal("AtlasLootItemsFrame_BACK").lootpage = tablebase.Back_Page;
				getglobal("AtlasLootItemsFrame_BACK").title = tablebase.Back_Title;
			end
		end
	end

	--For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
	if (AtlasLootItemsFrame:GetParent() == AlphaMapAlphaMapFrame or AtlasLootItemsFrame:GetParent() == AtlasFrame) then
		AtlasLootItemsFrame_CloseButton:Show();
	else
		AtlasLootItemsFrame_CloseButton:Hide();
	end

	--Anchor the item frame where it is supposed to be
	AtlasLoot_SetItemInfoFrame(pFrame);
end

--[[
AtlasLoot_SetItemInfoFrame(pFrame):
pFrame - Data structure with anchor info.  Format: {Anchor Point, Relative Frame, Relative Point, X Offset, Y Offset }
This function anchors the item frame where appropriate.  The main Atlas frame can be passed instead of a custom pFrame.
If no pFrame is specified, the Atlas Frame is used if Atlas is installed.
]]
function AtlasLoot_SetItemInfoFrame(pFrame)
	if ( pFrame ) then
		--If a pFrame is specified, use it
		if(pFrame==AtlasFrame and AtlasFrame) then
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetParent(AtlasFrame);
			AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
		else
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetParent(pFrame[2]);
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
		end
	elseif ( AtlasFrame ) then
		--If no pFrame is specified and Atlas is installed, anchor in Atlas
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(AtlasFrame);
		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	else
		--Last resort, dump the items frame in the middle of the screen
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(UIParent);
		AtlasLootItemsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	end
	AtlasLootItemsFrame:Show();
end

--[[
AtlasLootItemsFrame_OnCloseButton:
Called when the close button on the item frame is clicked
]]
function AtlasLootItemsFrame_OnCloseButton()
	--Set no loot table as currently selected
	AtlasLootItemsFrame.activeBoss = nil;
	--Fix the boss buttons so the correct icons are displayed
    if AtlasFrame and AtlasFrame:IsVisible() then
        if ATLAS_CUR_LINES then
            for i=1,ATLAS_CUR_LINES do
                if getglobal("AtlasBossLine"..i.."_Selected"):IsVisible() then
                    getglobal("AtlasBossLine"..i.."_Selected"):Hide();
                    getglobal("AtlasBossLine"..i.."_Loot"):Show();
                end
            end
        end
    end
	--Hide the item frame
	AtlasLootItemsFrame:Hide();
end

--[[
AtlasLootMenuItem_OnClick:
Requests the relevant loot page from a menu screen
]]
function AtlasLootMenuItem_OnClick()
	if this.isheader == nil or this.isheader == false then
		AtlasLoot_ShowBossLoot(this.lootpage, getglobal(this:GetName().."_Name"):GetText(), AtlasLoot_AnchorFrame);
	end
end

--[[
AtlasLoot_NavButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot_NavButton_OnClick()
	if AtlasLootItemsFrame.refresh and AtlasLootItemsFrame.refresh[2] and AtlasLootItemsFrame.refresh[4] then
		if strsub(this.lootpage, 1, 16) == "SearchResultPage" then
			AtlasLoot_ShowItemsFrame("SearchResult", this.lootpage, (AL["Search Result: %s"]):format(AtlasLootCharDB.LastSearchedText or ""), AtlasLootItemsFrame.refresh[4]);
		elseif strsub(this.lootpage, 1, 12) == "WishListPage" then
			AtlasLoot_ShowItemsFrame("WishList", this.lootpage, AL["WishList"], AtlasLootItemsFrame.refresh[4]);
		else
			AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItemsFrame.refresh[2], this.title, AtlasLootItemsFrame.refresh[4]);
		end
	elseif AtlasLootItemsFrame.refresh and AtlasLootItemsFrame.refresh[2] then
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItemsFrame.refresh[2], this.title, AtlasFrame);
    else
		--Fallback for if the requested loot page is a menu and does not have a .refresh instance
		AtlasLoot_ShowItemsFrame(this.lootpage, "dummy", this.title, AtlasFrame);
	end
end

--[[
AtlasLoot_HeroicModeToggle:
Switches between the heroic and normal versions of a loot page
]]
function AtlasLoot_HeroicModeToggle()
	local Heroic = AtlasLootItemsFrame.refresh[1].."HEROIC";
	local dataID = AtlasLootItemsFrame.refresh[1];
	local HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
	local Lootpage;
	if HeroicCheck=="HEROIC" then
		Lootpage=string.sub(dataID, 1, string.len(dataID)-6);
		AtlasLoot.db.profile.HeroicMode = false;
	else
		Lootpage=Heroic;
		AtlasLoot.db.profile.HeroicMode = true;
	end
	AtlasLoot_ShowItemsFrame(Lootpage, AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]);
end

--[[
AtlasLoot_IsLootTableAvailable(dataID):
Checks if a loot table is in memory and attempts to load the correct LoD module if it isn't
dataID: Loot table dataID
]]
function AtlasLoot_IsLootTableAvailable(dataID)

	local menu_check=false;

	local moduleName=nil;

	for k,v in pairs(AtlasLoot_MenuList) do
		if v == dataID then
			menu_check=true;
		end
	end

	if menu_check then
		return true;
	else
		if not AtlasLoot_TableNames[dataID] then
			DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..dataID..AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"]);
			return false;
		end

		local dataSource = AtlasLoot_TableNames[dataID][2];

		moduleName = AtlasLoot_GetLODModule(dataSource);

		if AtlasLoot_Data[dataSource] then
			if AtlasLoot_Data[dataSource][dataID] then
				return true;
			end
		else
			if not IsAddOnLoaded(moduleName) then
				loaded, reason=LoadAddOn(moduleName);
				if not loaded then
					if (reason == "MISSING") or (reason == "DISABLED") then
						DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..AtlasLoot_TableNames[dataID][1]..WHITE..AL[" is unavailable, the following load on demand module is required: "]..ORANGE..moduleName);
						return false;
					else
						DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..AL["Status of the following module could not be determined: "]..ORANGE..moduleName);
						return false;
					end
				end
			end
			if AtlasLoot_Data[dataSource][dataID] then
				if AtlasLoot.db.profile.LoDNotify then
					DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..moduleName..WHITE.." "..AL["sucessfully loaded."]);
				end
				collectgarbage("collect");
				return true;
			else
				DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..ORANGE..AtlasLoot_TableNames[dataID][1]..WHITE..AL[" could not be accessed, the following module may be out of date: "]..ORANGE..moduleName);
				return false;
			end
		end
	end
end

--[[
AtlasLoot_GetLODModule(dataSource)
Returns the name of the module that needs to be loaded
dataSource: Location of the loot table
]]
function AtlasLoot_GetLODModule(dataSource)
	if (dataSource=="AtlasLootItems") then
		return "AtlasLoot_OldInstances";
	elseif (dataSource=="AtlasLootExpansionItems") then
		return "AtlasLoot_BCInstances";
	elseif (dataSource=="AtlasLootCrafting") then
		return "AtlasLoot_Crafting";
	elseif (dataSource=="AtlasLootBGItems") or (dataSource=="AtlasLootGeneralPvPItems") or (dataSource=="AtlasLootWorldPvPItems") or (dataSource=="AtlasLootSetItems") then
		return "AtlasLoot_SetsandPvP";
	elseif (dataSource=="AtlasLootRepItems") then
		return "AtlasLoot_RepFactions";
	elseif (dataSource=="AtlasLootWBItems") or (dataSource=="AtlasLootWorldEvents") then
		return "AtlasLoot_WorldLoot";
	end
end

--[[
AtlasLoot_LoadAllModules()
Used to load all available LoD modules
]]
function AtlasLoot_LoadAllModules()
	local flag=0;
	if not AtlasLoot_Data["AtlasLootItems"] then
		LoadAddOn("AtlasLoot_OldInstances");
		flag=1;
	end
	if not AtlasLoot_Data["AtlasLootExpansionItems"] then
		LoadAddOn("AtlasLoot_BCInstances");
		flag=1;
	end
	if not AtlasLoot_Data["AtlasLootBGItems"] then
		LoadAddOn("AtlasLoot_SetsandPvP");
		flag=1;
	end
	if not AtlasLoot_Data["AtlasLootRepItems"] then
		LoadAddOn("AtlasLoot_RepFactions");
		flag=1;
	end
	if not AtlasLoot_Data["AtlasLootWBItems"] then
		LoadAddOn("AtlasLoot_WorldLoot");
		flag=1;
	end
	if not AtlasLoot_Data["AtlasLootCrafting"] then
		LoadAddOn("AtlasLoot_Crafting");
		flag=1;
	end
	if flag == 1 then
		if AtlasLoot.db.profile.LoDNotify then
			DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..WHITE..AL["All Available Modules Loaded"]);
		end
		collectgarbage("collect");
	end
end

--[[
AtlasLoot_ShowQuickLooks(button)
button: Identity of the button pressed to trigger the function
Shows the GUI for setting Quicklooks
]]
function AtlasLoot_ShowQuickLooks(button)
	local dewdrop = AceLibrary("Dewdrop-2.0");
	if dewdrop:IsOpen(button) then
		dewdrop:Close(1);
	else
		local setOptions = function()
			dewdrop:AddLine(
				"text", AL["QuickLook"].." 1",
				"tooltipTitle", AL["QuickLook"].." 1",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 1",
				"func", function()
                    AtlasLootCharDB["QuickLooks"][1]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
			dewdrop:AddLine(
				"text", AL["QuickLook"].." 2",
				"tooltipTitle", AL["QuickLook"].." 2",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 2",
				"func", function()
					AtlasLootCharDB["QuickLooks"][2]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
            dewdrop:AddLine(
				"text", AL["QuickLook"].." 3",
				"tooltipTitle", AL["QuickLook"].." 3",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 3",
				"func", function()
					AtlasLootCharDB["QuickLooks"][3]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
            dewdrop:AddLine(
				"text", AL["QuickLook"].." 4",
				"tooltipTitle", AL["QuickLook"].." 4",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 4",
				"func", function()
					AtlasLootCharDB["QuickLooks"][4]={AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
                    AtlasLoot_RefreshQuickLookButtons();
                    dewdrop:Close(1);
				end
			);
		end;
		dewdrop:Open(button,
			'point', function(parent)
				return "BOTTOMLEFT", "BOTTOMRIGHT";
			end,
			"children", setOptions
		);
	end
end

--[[
AtlasLoot_RefreshQuickLookButtons()
Enables/disables the quicklook buttons depending on what is assigned
]]
function AtlasLoot_RefreshQuickLookButtons()
    i=1;
    while i<5 do
        if ((not AtlasLootCharDB["QuickLooks"][i]) or (not AtlasLootCharDB["QuickLooks"][i][1])) or (AtlasLootCharDB["QuickLooks"][i][1]==nil) then
            getglobal("AtlasLootPanel_Preset"..i):Disable();
            getglobal("AtlasLootDefaultFrame_Preset"..i):Disable();
        else
            getglobal("AtlasLootPanel_Preset"..i):Enable();
            getglobal("AtlasLootDefaultFrame_Preset"..i):Enable();
        end
        i=i+1;
    end
end

--[[
AtlasLoot_QueryLootPage()
Querys all valid items on the current loot page.
]]
function AtlasLoot_QueryLootPage()
    i=1;
    while i<31 do
        button = getglobal("AtlasLootItem_"..i);
        queryitem = button.itemID;
        if (queryitem) and (queryitem ~= nil) and (queryitem ~= "") and (queryitem ~= 0) and (string.sub(queryitem, 1, 1) ~= "s") then
            GameTooltip:SetHyperlink("item:"..queryitem..":0:0:0:0:0:0:0");
        end
        i=i+1;
    end
end

