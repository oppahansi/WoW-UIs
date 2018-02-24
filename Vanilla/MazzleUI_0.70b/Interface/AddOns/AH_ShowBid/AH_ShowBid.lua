----------------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------------

local AH_ShowBid_OldGetAuctionItemInfo;
local AH_ShowBid_AlreadyHooked;

----------------------------------------------------------------------
-- OnFoo
----------------------------------------------------------------------

function AH_ShowBid_OnLoad()

        --Register events
        this:RegisterEvent("VARIABLES_LOADED");
        this:RegisterEvent("AUCTION_HOUSE_SHOW");

        --Load-message
        --if ( DEFAULT_CHAT_FRAME ) then
                --DEFAULT_CHAT_FRAME:AddMessage("AH_ShowBid".." ".."1800 R.1".." Loaded");
        --end

end

function AH_ShowBid_OnEvent(event, arg1)

        if ( event == "VARIABLES_LOADED" ) then
                AH_ShowBid_AlreadyHooked = false;
        end

        --Hook into GetAuctionItemInfo
        if ( (event == "AUCTION_HOUSE_SHOW") and not AH_ShowBid_AlreadyHooked ) then
                AH_ShowBid_AlreadyHooked = true;
                AH_ShowBid_OldGetAuctionItemInfo = GetAuctionItemInfo;
                GetAuctionItemInfo = AH_ShowBid_GetAuctionItemInfo;
        end

end

----------------------------------------------------------------------
-- Other Functions
----------------------------------------------------------------------

-- function based on code from ShowBid by DarkStarX
function AH_ShowBid_GetAuctionItemInfo(list, offset_p1)

        local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  AH_ShowBid_OldGetAuctionItemInfo(list, offset_p1);

        if ( (list == "list") and (bidAmount > 0) ) then
                name = name.."|cffffff00".." ("..AH_SHOWBID_BID..")".."|r";
        end

        return name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner;

end