local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");
local modules = { "AtlasLoot_BCInstances", "AtlasLoot_Crafting", "AtlasLoot_OldInstances", "AtlasLoot_RepFactions", "AtlasLoot_SetsandPvP", "AtlasLoot_WorldLoot" };
local currentPage = 1;
local SearchResult = nil;

function AtlasLoot:ShowSearchResult()
	AtlasLoot_ShowItemsFrame("SearchResult", "SearchResultPage"..currentPage, (AL["Search Result: %s"]):format(AtlasLootCharDB.LastSearchedText or ""), pFrame);
end

function AtlasLoot:Search(Text)
	if not Text then return end
	Text = strtrim(Text);
	if Text == "" then return end
	
	-- Decide if we need load all modules or just specified ones
	local allDisabled = not self.db.profile.SearchOn.All;
	if allDisabled then
		for _, module in ipairs(modules) do
			if self.db.profile.SearchOn[module] == true then
				allDisabled = false;
				break;
			end
		end
	end
	if allDisabled then
		DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..WHITE..AL["You don't have any module selected to search on."]);
		return;
	end
	if self.db.profile.SearchOn.All then
		AtlasLoot_LoadAllModules();
	else
		for k, v in pairs(self.db.profile.SearchOn) do
			if k ~= "All" and v == true and not IsAddOnLoaded(k) and LoadAddOn(k) and self.db.profile.LoDNotify then
				DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..k..WHITE.." "..AL["sucessfully loaded."]);
			end
		end
	end
	
	local text = string.lower(Text);
	local search = function(dataSource)
		if dataSource == "AtlasLootFallback" then return end
		if not self.db.profile.SearchOn.All then
			local module = AtlasLoot_GetLODModule(dataSource);
			if not module or self.db.profile.SearchOn[module] ~= true then return end
		end
		local partial = self.db.profile.PartialMatching;
		for dataID, data in pairs(AtlasLoot_Data[dataSource]) do
			for _, v in ipairs(data) do
				if type(v[1]) == "number" and v[1] > 0 then
					local itemName = GetItemInfo(v[1]);
					if not itemName then itemName = gsub(v[3], "=q%d=", "") end
					local found;
					if partial then
						found = string.find(string.lower(itemName), text);
					else
						found = string.lower(itemName) == text;
					end
					if found then
						local _, _, quality = string.find(v[3], "=q(%d)=");
						if quality then itemName = "=q"..quality.."="..itemName end
						table.insert(AtlasLootCharDB["SearchResult"], { v[1], v[2], itemName, v[4], dataID.."|"..dataSource });
					end
                elseif (v[1] ~= nil) and (v[1] ~= "") and (string.sub(v[1], 1, 1) == "s") then 
                    local spellName = GetSpellInfo(string.sub(v[1], 2));
                    if not spellName then
                        if (string.sub(v[3], 1, 2) == "=d") then  
                            spellName = gsub(v[3], "=ds=", "");
                        else
                            spellName = gsub(v[3], "=q%d=", ""); 
                        end
                    end
                    local found;
                    if partial then
						found = string.find(string.lower(spellName), text);
					else
						found = string.lower(spellName) == text;
					end
                    if found then
						spellName = string.sub(v[3], 1, 4)..spellName;
						table.insert(AtlasLootCharDB["SearchResult"], { v[1], v[2], spellName, v[4], dataID.."|"..dataSource });
					end
				end
			end
		end
	end
	
	AtlasLootCharDB["SearchResult"] = {};
	AtlasLootCharDB.LastSearchedText = Text;
	for dataSource in pairs(AtlasLoot_Data) do search(dataSource) end
	
	if #AtlasLootCharDB["SearchResult"] == 0 then
		DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..WHITE..AL["No match found for"].." \""..Text.."\".");
	else
		currentPage = 1;
		SearchResult = AtlasLoot_CategorizeWishList(AtlasLootCharDB["SearchResult"]);
		AtlasLoot_ShowItemsFrame("SearchResult", "SearchResultPage1", (AL["Search Result: %s"]):format(AtlasLootCharDB.LastSearchedText or ""), pFrame);
	end
end

function AtlasLoot:ShowSearchOptions(button)
	local dewdrop = AceLibrary("Dewdrop-2.0");
	if dewdrop:IsOpen(button) then
		dewdrop:Close(1);
	else
		local setOptions = function()
			dewdrop:AddLine(
				"text", AL["Search on"],
				"isTitle", true,
				"notCheckable", true
			);
			dewdrop:AddLine(
				"text", AL["All modules"],
				"checked", self.db.profile.SearchOn.All,
				"tooltipTitle", AL["All modules"],
				"tooltipText", AL["If checked, AtlasLoot will load and search across all the modules."],
				"func", function()
					self.db.profile.SearchOn.All = not self.db.profile.SearchOn.All;
				end
			);
			for _, module in ipairs(modules) do
				if IsAddOnLoadOnDemand(module) then
					local title = GetAddOnMetadata(module, "title");
					local notes = GetAddOnMetadata(module, "notes");
					dewdrop:AddLine(
						"text", title,
						"checked", self.db.profile.SearchOn.All or self.db.profile.SearchOn[module],
						"disabled", self.db.profile.SearchOn.All,
						"tooltipTitle", title,
						"tooltipText", notes,
						"func", function()
							if self.db.profile.SearchOn[module] == nil then
								self.db.profile.SearchOn[module] = true;
							else
								self.db.profile.SearchOn[module] = nil;
							end
						end
					);
				end
			end
			dewdrop:AddLine(
				"text", AL["Search options"],
				"isTitle", true,
				"notCheckable", true
			);
			dewdrop:AddLine(
				"text", AL["Partial matching"],
				"checked", self.db.profile.PartialMatching,
				"tooltipTitle", AL["Partial matching"],
				"tooltipText", AL["If checked, AtlasLoot search item names for a partial match."],
				"func", function() self.db.profile.PartialMatching = not self.db.profile.PartialMatching end
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

function AtlasLoot:GetOriginalDataFromSearchResult(itemID)
	for i, v in ipairs(AtlasLootCharDB["SearchResult"]) do
		if v[1] == itemID then return unpack(v) end
	end
end

-- Copied and modified from AtlasLoot_GetWishListPage
function AtlasLoot:GetSearchResultPage(page)
	if not SearchResult then SearchResult = AtlasLoot_CategorizeWishList(AtlasLootCharDB["SearchResult"]) end
	-- Calc for maximal pages
	local pageMax = math.ceil(#SearchResult / 30);
	if page < 1 then page = 1 end
	if page > pageMax then page = pageMax end
	currentPage = page;

	-- Table copy
	local result = {};
	local start = (page - 1) * 30 + 1;
	for i = start, start + 29 do
		if not SearchResult[i] then break end
		table.insert(result, SearchResult[i]);
	end
	return result, pageMax;
end
