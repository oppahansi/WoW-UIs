

local didLoad, o = LoadLibrary1("ItemDB_VendorPrices", 101, nil, nil, "CommonParsingTooltip1", "EventsManager1");



if (didLoad == true) then
	o.EventsManager1 = EventsManager1;
	
	do
		local success, reason = LoadAddOn("Lib-ItemDB_VendorPrices1_SavedVariables");
		
	end
end

