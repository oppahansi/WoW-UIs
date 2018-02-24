local last_search = 0;
local version = "1.2";

local frame = CreateFrame("FRAME");
frame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
frame:RegisterEvent("AUCTION_HOUSE_SHOW");

local origCanSendAuctionQuery = CanSendAuctionQuery;
CanSendAuctionQuery = function(...)
	if (last_search + 1.2 > GetTime()) then
		return false, false;
	else
		return origCanSendAuctionQuery(...);
	end
end

local origQueryAuctionItems = QueryAuctionItems;
QueryAuctionItems = function(...)
	while (last_search + 1.2 > GetTime()) do
    end
	last_search = GetTime();
	return origQueryAuctionItems(...);
end

local eventHandler = function()
	if (event == "AUCTION_ITEM_LIST_UPDATE") then
		if (last_search + 0.2 < GetTime()) then
			last_search = GetTime() - 0.2;
		end
	elseif (event == "AUCTION_HOUSE_SHOW") then
		DEFAULT_CHAT_FRAME:AddMessage("Molten AH-fix v"..version.." loaded.", 0.5, 0.5, 1);
		frame:UnregisterEvent("AUCTION_HOUSE_SHOW");
	end
end
frame:SetScript("OnEvent", eventHandler);