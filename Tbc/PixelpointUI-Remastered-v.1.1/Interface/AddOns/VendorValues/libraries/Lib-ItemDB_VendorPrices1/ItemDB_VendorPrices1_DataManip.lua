

local o = ItemDB_VendorPrices1; if (o.SHOULD_LOAD == nil) then return; end


local l_t_Init; -- ()
local l_t_GetLocals; -- activeDB, activeDBCount = ()
local l_t_UnregisterForAllEvents; -- ()

local l_GetActiveDB; -- activeDB, activeDBSize = ()
local l_GetErrata; -- errata = ()

local l_GetPrice; -- price = (baseID)
local l_SetPrice; -- oldPrice, newPrice = (baseID, newPrice)

local l_ParsePrices; -- ()

local l_LoadStaticDB; -- (staticDB)


local stringmatch = string.match; -- GetSellValue, ParsePrices
local type = type; -- GetSellValue, SetPrice
local tonumber = tonumber; -- GetPrice, SetPrice, GetSellValue


local l_activeDB;
local l_activeDBCount;
local l_errata;


do
	if (o.t_GetLocals ~= nil) then
		l_activeDB, l_activeDBCount = o.t_GetLocals();
	else
		l_activeDB = (o.activeDB or {});
		o.activeDB = nil;
		l_activeDBCount = (o.activeDBCount or 0);
		o.activeDBCount = nil;
	end
end




function l_t_Init()
	l_t_Init = nil;
	o.t_Init = nil;
	
	
	local errata = ItemDB_VendorPrices1_Errata;
	if (errata == nil) then
		errata = {};
		ItemDB_VendorPrices1_Errata = errata;
	end
	l_errata = errata;
	
	
	local em1 = o.EventsManager1;
	if (o.t_UnregisterForAllEvents ~= nil) then
		o.t_UnregisterForAllEvents();
	end
	o.t_UnregisterForAllEvents = l_t_UnregisterForAllEvents;
	
	em1.RegisterForEvent(l_ParsePrices, nil, "MERCHANT_SHOW", false, false);
	
	local ACE = em1.AddCustomEvent;
	ACE("ItemDB_VendorPrices1_DB_LOADED", true);
	ACE("ItemDB_VendorPrices1_UPDATE_DB_SIZE", false);
	ACE("ItemDB_VendorPrices1_ITEM_UPDATED", false);
	
	
	if (o.STATIC_DB ~= nil) then
		l_LoadStaticDB(o.STATIC_DB);
		o.STATIC_DB = nil;
	end
end

o.t_Init = l_t_Init;



function l_t_GetLocals()
	l_t_GetLocals = nil;
	o.t_GetLocals = nil;
	
	return l_activeDB, l_activeDBCount;
end

o.t_GetLocals = l_t_GetLocals;



function l_t_UnregisterForAllEvents()
	l_t_UnregisterForAllEvents = nil;
	o.t_UnregisterForAllEvents = nil;
	
	o.EventsManager1.UnregisterForEvent(l_ParsePrices, "MERCHANT_SHOW");
end




-- Generic function in the style of the Blizzard API, per http://www.wowwiki.com/API_GetSellValue
do
	if (o.SetUpvalueFor_GetSellValue == nil) then
		local l_GetPrice;
		
		function o.SetUpvalueFor_GetSellValue(newFunc)
			l_GetPrice = newFunc;
		end
		
		local GetItemInfo = GetItemInfo;
		local l_orig_GetSellValue = GetSellValue;
		GetSellValue = function(link)
			local baseID;
			if (link ~= nil) then
				if (type(link) == "number") then
					baseID = link;
				else
					local numberLink = tonumber(link);
					if (numberLink ~= nil) then
						baseID = numberLink;
					else
						baseID = tonumber(stringmatch(link, "item:(%d+):"));
						if (baseID == nil) then
							local _;
							_, link = GetItemInfo(link);
							if (link ~= nil) then
								baseID = tonumber(stringmatch(link, "item:(%d+):"));
							end
						end
					end
				end
			end
			
			local value = nil;
			if (baseID ~= nil) then
				value = l_GetPrice(baseID);
				if (value == nil) then
					if (l_orig_GetSellValue ~= nil) then
						value = l_orig_GetSellValue(baseID);
					end
				end
			end
			return value;
		end
	end
end




function l_GetActiveDB()
	return l_activeDB, l_activeDBCount;
end

o.GetActiveDB = l_GetActiveDB;


function l_GetErrata()
	return l_errata;
end

o.GetErrata = l_GetErrata;




function l_GetPrice(baseID)
	local value = l_activeDB[tonumber(baseID)];
	if (value == false) then
		value = 0;
	end
	return value;
end

o.GetPrice = l_GetPrice;
o.SetUpvalueFor_GetSellValue(l_GetPrice);



function l_SetPrice(baseID, newPrice)
	baseID = tonumber(baseID);
	if (baseID == nil) then
		error("baseID is nil");
	end
	if (newPrice ~= nil and type(newPrice) ~= "number") then
		error(("ItemDB_VendorPrices1.SetPrice: Bad argument #2: expected number or nil, received %s"):format(type(newPrice)));
	end
	
	local oldPrice = l_activeDB[baseID];
	if (newPrice == 0) then
		newPrice = false;
	end
	
	if (newPrice ~= oldPrice) then
		l_activeDB[baseID] = newPrice;
		l_errata[baseID] = newPrice;
		
		local change = ((oldPrice == nil and newPrice ~= nil and 1) or (oldPrice ~= nil and newPrice == nil and -1) or 0);
		if (change ~= 0) then
			local oldSize = l_activeDBCount;
			local newSize = (oldSize + change);
			l_activeDBCount = newSize;
			o.EventsManager1.DispatchEvent("ItemDB_VendorPrices1_UPDATE_DB_SIZE", oldSize, newSize);
		end
		
		if (newPrice == false) then
			newPrice = 0;
		end
		if (oldPrice == false) then
			oldPrice = 0;
		end
		o.EventsManager1.DispatchEvent("ItemDB_VendorPrices1_ITEM_UPDATED", baseID, oldPrice, newPrice);
		return oldPrice, newPrice;
	else
		if (oldPrice == false) then
			oldPrice = 0;
		end
		return oldPrice, oldPrice;
	end
end

o.SetPrice = l_SetPrice;




do
	local GetContainerNumSlots = GetContainerNumSlots;
	local GetContainerItemLink = GetContainerItemLink;
	local GetContainerItemInfo = GetContainerItemInfo;
	local CommonParsingTooltip1 = CommonParsingTooltip1;
	
	function l_ParsePrices()
		local link, _, repairCost, baseID, value, quantity;
		
		for bag = 4, 0, -1 do
			for slot = GetContainerNumSlots(bag), 1, -1 do
				link = GetContainerItemLink(bag, slot);
				
				if (link ~= nil) then
					baseID = stringmatch(link, "[^:]+", 18);
					
					_, repairCost = CommonParsingTooltip1:SetBagItem(bag, slot);
					-- Read the value now that the OnTooltipAddMoney script has had the chance to set it.
					value = (CommonParsingTooltip1.currentMoneyValue or 0);
					
					if (value ~= 0) then
						-- Item is sellable, so now check repair cost to avoid storing damaged items, unless there is no previous price associated with the item.
						if (repairCost == 0 or l_activeDB[baseID] == nil) then
							-- Item is valid for storage, so divide the value by the stack count to get the price for a single item.
							_, quantity = GetContainerItemInfo(bag, slot);
							value = (value / quantity);
						else
							-- Item is damaged and already has an entry in the database. Do not store this price.
							value = nil;
						end
					end
					
					if (value ~= nil) then
						l_SetPrice(baseID, value);
					end
				end
			end
		end
	end
end

if (o.SetUpvalueFor_h_RepairAllItems == nil) then
	local l_ParsePrices;
	function o.SetUpvalueFor_h_RepairAllItems(newFunc)
		l_ParsePrices = newFunc;
	end
	local l_orig_RepairAllItems = RepairAllItems;
	RepairAllItems = function()
		l_orig_RepairAllItems();
		l_ParsePrices();
	end
end
o.SetUpvalueFor_h_RepairAllItems(l_ParsePrices);

o.ParsePrices = l_ParsePrices;




function l_LoadStaticDB(staticDB)
	-- If this is the first static DB being loaded, we want to clean the errata and set the data directly.
	-- Otherwise, we should just use SetData as normal to add prices.
	
	if (next(l_activeDB) == nil) then
		for baseID, price in pairs(l_errata) do
			if (price == 0) then
				price = false;
				l_errata[baseID] = false;
			end
			if (staticDB[baseID] == price) then
				l_errata[baseID] = nil;
			else
				staticDB[baseID] = price;
			end
		end
		
		local count = 0;
		for baseID, price in pairs(staticDB) do
			l_activeDB[baseID] = price;
			count = (count + 1);
		end
		l_activeDBCount = count;
		o.EventsManager1.DispatchEvent("ItemDB_VendorPrices1_DB_LOADED");
		o.EventsManager1.DispatchEvent("ItemDB_VendorPrices1_UPDATE_DB_SIZE", 0, count);
		
	else
		for baseID, price in pairs(staticDB) do
			l_SetPrice(baseID, price);
		end
	end
end

o.LoadStaticDB = l_LoadStaticDB;

