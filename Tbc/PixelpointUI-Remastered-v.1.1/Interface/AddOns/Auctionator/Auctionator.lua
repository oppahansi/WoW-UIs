
local AuctionatorVersion = "1.1.1";
local AuctionatorAuthor  = "Zirco";

local AuctionatorLoaded = false;
local AuctionatorInited = false;

local recommendElements		= {};
local auctionsTabElements	= {};

AUCTIONATOR_ENABLE_ALT	= 1;
AUCTIONATOR_OPEN_FIRST	= 0;

local AUCTIONATOR_TAB_INDEX = 4;

-----------------------------------------

local auctionator_orig_AuctionFrameTab_OnClick;
local auctionator_orig_ContainerFrameItemButton_OnClick;
local auctionator_orig_AuctionFrameAuctions_Update;
local auctionator_orig_AuctionsCreateAuctionButton_OnClick;

local KM_NULL_STATE	= 0;
local KM_PREQUERY	= 1;
local KM_INQUERY	= 2;
local KM_POSTQUERY	= 3;
local KM_ANALYZING	= 4;

local processing_state	= KM_NULL_STATE;
local current_page;
local forceMsgAreaUpdate = true;


local SETTLED				= 1;
local AUCTION_POST_PENDING	= 2;
local STACK_MERGE_PENDING	= 3;
local STACK_SPLIT_PENDING	= 4;


local gAutoSelling = false;
local gAutoSellState;

local gAutoSell_ItemName;
local gAutoSell_GoodStackSize;
local gAutoSell_FullStackSize;
local gAutoSell_StartPrice;
local gAutoSell_BuyoutPrice;
local gAutoSell_Hours;
local gAutoSell_targetBS;
local gAutoSell_targetCount;
local gAutoSell_AuctionNum;
local gAutoSell_NumAuctionsToCreate;
local gAutoSell_TotalItems;

local cslots = {};
local gEmptyBScached = nil;


local scandata;
local sorteddata = {};
local basedata;

local currentAuctionItemName = "";
local currentAuctionStackSize = 0;

local currentAuctionClass;
local currentAuctionSubclass;

local auctionator_last_buyoutprice;
local auctionator_last_item_posted = nil;
local auctionator_last_item_count;
local auctionator_pending_message = nil;

local kFirstBag, kLastBag = 0, 4;

local Auctionator_Confirm_Proc_Yes = nil;

-----------------------------------------

local	BoolToString, BoolToNum, NumToBool, pluralizeIf, pluralize, round, chatmsg, calcNewPrice, roundPriceDown;
local	val2gsc, priceToString, ItemType2AuctionClass, SubType2AuctionSubclass;

local BS_GetCount, BS_InCslots, BS_GetEmptySlot, BS_PostAuction, BS_FindGoodStack, BS_MergeSmallStacks, BS_SplitLargeStack;

-----------------------------------------


function Auctionator_EventHandler()

--	chatmsg (event);

	if (event == "VARIABLES_LOADED")			then	Auctionator_OnLoad(); 					end; 
	if (event == "ADDON_LOADED")				then	Auctionator_OnAddonLoaded(); 			end; 
	if (event == "AUCTION_ITEM_LIST_UPDATE")	then	Auctionator_OnAuctionUpdate(); 			end; 
	if (event == "AUCTION_OWNED_LIST_UPDATE")	then	Auctionator_OnAuctionOwnedUpdate(); 	end; 
	if (event == "AUCTION_HOUSE_SHOW")			then	Auctionator_OnAuctionHouseShow(); 		end; 
	if (event == "AUCTION_HOUSE_CLOSED")		then	Auctionator_OnAuctionHouseClosed(); 	end; 
	if (event == "NEW_AUCTION_UPDATE")			then	Auctionator_OnNewAuctionUpdate(); 		end; 
--	if (event == "BAG_UPDATE")					then	Auctionator_OnBagUpdate(); 				end; 

end

-----------------------------------------


function Auctionator_OnLoad()

	chatmsg("Auctionator Loaded");

	AuctionatorLoaded = true;

	if ( IsAddOnLoaded("Blizzard_AuctionUI") ) then		-- need this for AH_QuickSearch since that mod forces Blizzard_AuctionUI to load at a startup
		Auctionator_Init();
	end

end

-----------------------------------------

function Auctionator_OnAddonLoaded()

	if (arg1:lower() == "blizzard_auctionui") then
		Auctionator_Init();
	end
end

-----------------------------------------

function Auctionator_Init()

	if (AuctionatorInited) then
		return;
	end
	
	AuctionatorInited = true;

	Auctionator_AddSellTab ();
	Auctionator_AddSellPanel ();
	
	Auctionator_SetupHookFunctions ();
	
	auctionsTabElements[1]  = AuctionsScrollFrame;
	auctionsTabElements[2]  = AuctionsButton1;
	auctionsTabElements[3]  = AuctionsButton2;
	auctionsTabElements[4]  = AuctionsButton3;
	auctionsTabElements[5]  = AuctionsButton4;
	auctionsTabElements[6]  = AuctionsButton5;
	auctionsTabElements[7]  = AuctionsButton6;
	auctionsTabElements[8]  = AuctionsButton7;
	auctionsTabElements[9]  = AuctionsButton8;
	auctionsTabElements[10] = AuctionsButton9;
	auctionsTabElements[11] = AuctionsQualitySort;
	auctionsTabElements[12] = AuctionsDurationSort;
	auctionsTabElements[13] = AuctionsHighBidderSort;
	auctionsTabElements[14] = AuctionsBidSort;
	auctionsTabElements[15] = AuctionsCancelAuctionButton;

	recommendElements[1] = getglobal ("Auctionator_Recommend_Text");
	recommendElements[2] = getglobal ("Auctionator_RecommendPerItem_Text");
	recommendElements[3] = getglobal ("Auctionator_RecommendPerItem_Price");
	recommendElements[4] = getglobal ("Auctionator_RecommendPerStack_Text");
	recommendElements[5] = getglobal ("Auctionator_RecommendPerStack_Price");
	recommendElements[6] = getglobal ("Auctionator_Recommend_Basis_Text");
	recommendElements[7] = getglobal ("Auctionator_RecommendItem_Tex");

end


-----------------------------------------


function Auctionator_AuctionFrameTab_OnClick (index)

	if ( not index ) then
		index = this:GetID();
	end

	getglobal("Auctionator_Sell_Panel"):Hide();

	if (index == 3) then		
		Auctionator_ShowElems (auctionsTabElements);
	end
	
	if (index ~= AUCTIONATOR_TAB_INDEX) then
		auctionator_orig_AuctionFrameTab_OnClick (index);
		auctionator_last_item_posted = nil;
		forceMsgAreaUpdate = true;
		Auctionator_HideAllDialogs();
		gAutoSelling = false;
		
	elseif (index == AUCTIONATOR_TAB_INDEX) then
		AuctionFrameTab_OnClick(3);
		
		PanelTemplates_SetTab(AuctionFrame, AUCTIONATOR_TAB_INDEX);
		
		AuctionFrameTopLeft:SetTexture	("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopLeft");
		AuctionFrameTop:SetTexture		("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Top");
		AuctionFrameTopRight:SetTexture	("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopRight");
		AuctionFrameBotLeft:SetTexture	("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-BotLeft");
		AuctionFrameBot:SetTexture		("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot");
		AuctionFrameBotRight:SetTexture	("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-BotRight");

		Auctionator_HideElems (auctionsTabElements);
		
		getglobal("Auctionator_Sell_Panel"):Show();

		Auctionator_HideElems (recommendElements);

		OpenAllBags(true);
		
		if (currentAuctionItemName ~= "") then
			Auctionator_CalcBaseData();
		end
	
	
	end

end

-----------------------------------------


function Auctionator_ContainerFrameItemButton_OnModifiedClick (button)
	
	if (	AUCTIONATOR_ENABLE_ALT == 0
		or  not	AuctionFrame:IsShown()
		or	not	IsAltKeyDown())
	then
		return auctionator_orig_ContainerFrameItemButton_OnModifiedClick (button);
	end;

	if (not Auctionator_TabSelected()) then
	
		AuctionFrameTab_OnClick (AUCTIONATOR_TAB_INDEX);
	
	end
	
	local bagID  = this:GetParent():GetID();
	local slotID = this:GetID();

	PickupContainerItem(bagID, slotID);

	local infoType = GetCursorInfo()

	if (infoType == "item") then
		ClickAuctionSellItemButton();
		ClearCursor();
	end

end


-----------------------------------------

function BeginAutoSell ()

	local maxStacks = math.floor (gAutoSell_TotalItems / gAutoSell_GoodStackSize);

	if (Auctionator_Batch_NumAuctions:GetNumber() > maxStacks) then
		Auctionator_Error_Text:SetText ("You can create at most "..maxStacks.." auctions");
		Auctionator_Error_Frame:Show ();
		return;
	end

	Auctionator_Batch_Frame:Hide();
	
--	chatmsg ("BeginAutoSell");
		
	gAutoSell_NumAuctionsToCreate = Auctionator_Batch_NumAuctions:GetNumber();

	auctionator_last_item_posted = gAutoSell_ItemName;
	auctionator_last_buyoutprice = gAutoSell_BuyoutPrice;
	auctionator_last_item_count  = gAutoSell_GoodStackSize


	local bagID, slotID, numslots;

	-- build a table of all the slots that contain the item
	
	cslots			= {};
	gEmptyBScached	= nil;
	
	for bagID = kFirstBag, kLastBag do
		numslots = GetContainerNumSlots (bagID);
		for slotID = 1,numslots do
			local itemLink = GetContainerItemLink(bagID, slotID);
			if (itemLink) then
				local itemName = GetItemInfo(itemLink);
				if (itemName == gAutoSell_ItemName) then
					local bs = {};
					bs.bagID  = bagID;
					bs.slotID = slotID;
					tinsert (cslots, bs);
				end
			end
		end
	end
	
	-- get it going (see the idle loop)
	
	gAutoSellState			= SETTLED
	gAutoSelling			= true;
	gAutoSell_AuctionNum	= 1;
end




-----------------------------------------

function Auctionator_AuctionFrameAuctions_Update()
	
	auctionator_orig_AuctionFrameAuctions_Update();

	if (Auctionator_TabSelected()  and	AuctionFrame:IsShown()) then
		Auctionator_HideElems (auctionsTabElements);
	end

	
end

-----------------------------------------
-- Intercept the Create Auction click so
-- that we can note the auction values
-----------------------------------------

function Auctionator_AuctionsCreateAuctionButton_OnClick()
	
	if (Auctionator_TabSelected() and AuctionFrame:IsShown()) then
		
		if (MoneyInputFrame_GetCopper(BuyoutPrice) == 0) then
			Auctionator_Confirm_Text:SetText ("Are you sure you want to create\nan auction with no buyout price?");
			Auctionator_Confirm_Frame:Show ();
			Auctionator_Confirm_Proc_Yes = Auctionator_CreateAuction_Click;
		else
			Auctionator_CreateAuction_Click()
		end

	else
		auctionator_orig_AuctionsCreateAuctionButton_OnClick();
	end
	

end

-----------------------------------------

function Auctionator_CreateAuction_Click()
	
	auctionator_last_buyoutprice = MoneyInputFrame_GetCopper(BuyoutPrice);
	auctionator_last_item_posted = currentAuctionItemName;
	auctionator_last_item_count  = currentAuctionStackSize;
	
	auctionator_orig_AuctionsCreateAuctionButton_OnClick();
end

-----------------------------------------

function Auctionator_OnAuctionOwnedUpdate ()

	if (gAutoSelling) then
		if (gAutoSellState == AUCTION_POST_PENDING) then
			gAutoSellState = SETTLED;
			gAutoSell_AuctionNum = gAutoSell_AuctionNum + 1;
		end
	end


	if (gAutoSelling) then
	
		Auctionator_Recommend_Text:SetText ("Auction #"..(gAutoSell_AuctionNum-1).." created for "..gAutoSell_ItemName);
		MoneyFrame_Update ("Auctionator_RecommendPerStack_Price", gAutoSell_BuyoutPrice);
		Auctionator_SetTextureButton ("Auctionator_RecommendItem_Tex", gAutoSell_ItemName, gAutoSell_GoodStackSize);

	elseif (auctionator_last_item_posted) then
	
		Auctionator_Recommend_Text:SetText ("Auction created for "..auctionator_last_item_posted);
		MoneyFrame_Update ("Auctionator_RecommendPerStack_Price", auctionator_last_buyoutprice);
		Auctionator_SetTextureButton ("Auctionator_RecommendItem_Tex", auctionator_last_item_posted, auctionator_last_item_count);

	
	else
		return;
	end


	Auctionator_ShowElems (recommendElements);

	AuctionatorMessageFrame:Hide();
	Auctionator_RecommendPerItem_Price:Hide();
	Auctionator_RecommendPerItem_Text:Hide();
	Auctionator_Recommend_Basis_Text:Hide();

	Auctionator_Col1_Heading:Hide();
	Auctionator_Col2_Heading:Hide();
	Auctionator_Col3_Heading:Hide();
	Auctionator_Col4_Heading:Hide();

end

-----------------------------------------

function Auctionator_OnNewAuctionUpdate()


end

-----------------------------------------

function Auctionator_SetupHookFunctions ()
	
	auctionator_orig_AuctionFrameTab_OnClick = AuctionFrameTab_OnClick;
	AuctionFrameTab_OnClick = Auctionator_AuctionFrameTab_OnClick;
	
	auctionator_orig_ContainerFrameItemButton_OnModifiedClick = ContainerFrameItemButton_OnModifiedClick;
	ContainerFrameItemButton_OnModifiedClick = Auctionator_ContainerFrameItemButton_OnModifiedClick;
	
	auctionator_orig_AuctionFrameAuctions_Update = AuctionFrameAuctions_Update;
	AuctionFrameAuctions_Update = Auctionator_AuctionFrameAuctions_Update;
	
	auctionator_orig_AuctionsCreateAuctionButton_OnClick = AuctionsCreateAuctionButton_OnClick;
	AuctionsCreateAuctionButton_OnClick = Auctionator_AuctionsCreateAuctionButton_OnClick;
	
end

-----------------------------------------

function Auctionator_AddSellPanel ()
	
	local frame = CreateFrame("Frame", "Auctionator_Sell_Panel", AuctionFrame, "Auctionator_Sell_Template");
	frame:Hide();

end

-----------------------------------------

function Auctionator_AddSellTab ()
	
	local n = AuctionFrame.numTabs+1;
	
	AUCTIONATOR_TAB_INDEX = n;

	local framename = "AuctionFrameTab"..n;

	local frame = CreateFrame("Button", framename, AuctionFrame, "AuctionTabTemplate");

	frame:SetID(n);
	frame:SetText("Auctionator");

	frame:SetPoint("LEFT", getglobal("AuctionFrameTab"..n-1), "RIGHT", -8, 0);

	PanelTemplates_SetNumTabs (AuctionFrame, n);
	PanelTemplates_EnableTab  (AuctionFrame, n);
end

-----------------------------------------

function Auctionator_HideElems (tt)

	if (not tt) then
		return;
	end
	
	for i,x in ipairs(tt) do
		x:Hide();
	end
end

-----------------------------------------

function Auctionator_ShowElems (tt)

	for i,x in ipairs(tt) do
		x:Show();
	end
end

-----------------------------------------

function Auctionator_OnAuctionUpdate ()

	if (processing_state ~= KM_POSTQUERY) then
		return;
	end
	
	if (not Auctionator_TabSelected()) then
		return;
	end;
	
	processing_state = KM_ANALYZING;
	
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	
--	chatmsg("auctions:"..numBatchAuctions.." out of  "..totalAuctions)

	if (totalAuctions >= 50) then
		Auctionator_SetMessage ("Scanning auctions: page "..current_page);
	end
	
	if (numBatchAuctions > 0) then
	
		local x;
		
		for x = 1, numBatchAuctions do
		
			local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo("list", x);

			if (name == currentAuctionItemName and buyoutPrice >= 0) then
			
				local sd = {};
				
				sd["stackSize"]		= count;
				sd["buyoutPrice"]	= buyoutPrice;
				sd["owner"]			= owner;
				
				tinsert (scandata, sd);
				
				
			end
		end
	end


	if (numBatchAuctions == 50) then
				
		processing_state = KM_PREQUERY;	
		
	else
	
		if (#scandata > 0) then
			Auctionator_Process_Scandata ();
			Auctionator_CalcBaseData();
		else
			Auctionator_SetMessage ("No auctions were found for \n\n"..currentAuctionItemName);
			Auctionator_CheckForMultiples();
		end
		
		processing_state = KM_NULL_STATE;

	end
	
	
	
end

-----------------------------------------

function Auctionator_SetMessage (msg)
	Auctionator_HideElems (recommendElements);
	Auctionator_HideElems (overallElements);

	AuctionatorMessageFrame:SetText (msg);
	AuctionatorMessageFrame:Show();
end

-----------------------------------------

function Auctionator_Process_Scandata ()

	sorteddata = {};
	
	if (scandata == nil) then
		return;
	end;
   
	----- Condense the scan data into a table that has only a single entry per stacksize/price combo

	local i,sd;
	local conddata = {};

	for i,sd in ipairs (scandata) do
	
		local key = "_"..sd.stackSize.."_"..sd.buyoutPrice;
		
	
		if (conddata[key]) then
			conddata[key].count = conddata[key].count + 1;	
		else
			local data = {};
			
			data.stackSize 		= sd.stackSize;
			data.buyoutPrice	= sd.buyoutPrice;
			data.itemPrice		= sd.buyoutPrice / sd.stackSize;
			data.count			= 1;
			data.numYours		= 0;
			
			conddata[key] = data;
		end

		if (sd.owner == UnitName("player")) then
			conddata[key].numYours = conddata[key].numYours + 1;
		end
	
	end


	----- create a table of these entries sorted by itemPrice


	local n = 1;
	for i,v in pairs (conddata) do
		sorteddata[n] = v;
		n = n + 1;
	end

	table.sort (sorteddata, function(a,b) return a.itemPrice < b.itemPrice; end);

end

-----------------------------------------

local bestPriceOurStackSize;
local absoluteBest;				-- the overall cheapest auction

-----------------------------------------

function Auctionator_CalcBaseData ()

	local bestPrice		= {};		-- a table with one entry per stacksize that is the cheapest auction for that particular stacksize
	
	absoluteBest = nil;				
	
	local j, sd;

	----- find the best price per stacksize and overall -----
	
	for j,sd in ipairs(sorteddata) do
	
		if (sd.itemPrice > 0) then
		
			if (bestPrice[sd.stackSize] == nil or bestPrice[sd.stackSize].itemPrice >= sd.itemPrice) then
				bestPrice[sd.stackSize] = sd;
			end
		
			if (absoluteBest == nil or absoluteBest.itemPrice > sd.itemPrice) then
				absoluteBest = sd;
			end
		end
	
	end
	
	basedata = absoluteBest;

	if (bestPrice[currentAuctionStackSize]) then
		basedata				= bestPrice[currentAuctionStackSize];
		bestPriceOurStackSize	= bestPrice[currentAuctionStackSize];
	end

	Auctionator_UpdateRecommendation();
end

-----------------------------------------

function Auctionator_UpdateRecommendation ()

	if (basedata) then
		local newBuyoutPrice = math.floor (basedata.itemPrice * currentAuctionStackSize);

		if (basedata.numYours < basedata.count) then
			newBuyoutPrice = calcNewPrice (newBuyoutPrice);
		end
		
		local newStartPrice = calcNewPrice(math.floor(newBuyoutPrice *0.95)); 
		
		Auctionator_ShowElems (recommendElements);
		AuctionatorMessageFrame:Hide();
		
		Auctionator_Recommend_Text:SetText ("Recommended Buyout Price");
		Auctionator_RecommendPerStack_Text:SetText ("for your stack of "..currentAuctionStackSize);
		
		Auctionator_SetTextureButton ("Auctionator_RecommendItem_Tex", currentAuctionItemName, currentAuctionStackSize);
		
		MoneyFrame_Update ("Auctionator_RecommendPerItem_Price",  round(newBuyoutPrice / currentAuctionStackSize));
		MoneyFrame_Update ("Auctionator_RecommendPerStack_Price", round(newBuyoutPrice));
		
		MoneyInputFrame_SetCopper (BuyoutPrice, newBuyoutPrice);
		MoneyInputFrame_SetCopper (StartPrice,  newStartPrice);

		Auctionator_ScrollbarUpdate();
		
		if (absoluteBest and basedata.stackSize == absoluteBest.stackSize and basedata.buyoutPrice == absoluteBest.buyoutPrice) then
			Auctionator_Recommend_Basis_Text:SetText ("(based on cheapest)");
		elseif (bestPriceOurStackSize and basedata.stackSize == bestPriceOurStackSize.stackSize and basedata.buyoutPrice == bestPriceOurStackSize.buyoutPrice) then
			Auctionator_Recommend_Basis_Text:SetText ("(based on cheapest stack of the same size)");
		else
			Auctionator_Recommend_Basis_Text:SetText ("(based on auction selected below)");
		end
		
		Auctionator_CheckForMultiples();
	end
end

-----------------------------------------

function Auctionator_CheckForMultiples ()

	if (Auctionator_Find_More (currentAuctionItemName, currentAuctionStackSize)) then
		Auctionator_BatchButton:Enable();
	else
		Auctionator_BatchButton:Disable();
	end

end

-----------------------------------------

function Auctionator_Find_More (pItemName, pItemCount)

	local bagID, slotID, numslots;
	local foundSoFar = 0;

	for bagID = kFirstBag, kLastBag do
		numslots = GetContainerNumSlots (bagID);
		for slotID = 1,numslots do
			local itemLink = GetContainerItemLink(bagID, slotID);
			if (itemLink) then
				local itemName				= GetItemInfo(itemLink);
				local texture, itemCount	= GetContainerItemInfo(bagID, slotID);
				
				if (itemName == pItemName) then
					foundSoFar = foundSoFar + itemCount;
					if (foundSoFar >= pItemCount * 2) then
						return true;
					end
				end
			end
		end
	end

	return false;

end

-----------------------------------------

function Auctionator_SetTextureButton(elementName, itemname, count)

	local a, b, c, d, e, f, g, h, i, texture = GetItemInfo (itemname);

	local textureElement = getglobal (elementName);
	local countElement   = getglobal (elementName.."Count");

	if (texture) then
		textureElement:SetNormalTexture (texture);
		if (count > 1) then
			countElement:SetText (count);
			countElement:Show();
		else
			countElement:Hide();
		end
	else
		textureElement:Hide();
	end

end


-----------------------------------------

function Auctionator_OnAuctionHouseShow()

	if (AUCTIONATOR_OPEN_FIRST ~= 0) then
		AuctionFrameTab_OnClick (AUCTIONATOR_TAB_INDEX);
	end

end

-----------------------------------------

function Auctionator_OnAuctionHouseClosed()

	Auctionator_HideAllDialogs();
	gAutoSelling = false;
end

-----------------------------------------

function Auctionator_HideAllDialogs()

	AuctionatorOptionsFrame:Hide();
	AuctionatorDescriptionFrame:Hide();
	Auctionator_Batch_Frame:Hide();
	Auctionator_Error_Frame:Hide();
	Auctionator_Mask:Hide();
	
end



-----------------------------------------

function Auctionator_OnUpdate(self, elapsed)

	if (Auctionator_TabSelected()) then
		Auctionator_Idle (self, elapsed);
	end

end


-----------------------------------------

function Auctionator_Idle(self, elapsed)

	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
	
	if (AuctionatorMessageFrame == nil) then
		return;
	end
	
	if (self.TimeSinceLastUpdate > 0.25) then
	
		self.TimeSinceLastUpdate = 0;

		Auctionator_Idle_CheckNewIfQueryNeeded (self); 	------- check whether to send a new auction query to get the next page -------

		if (gAutoSelling) then
			Auctionator_Idle_AutoSelling (self);
		end

	end

	Auctionator_Idle_CheckForNewAuctionItem (self);		------- check whether the "sell" item has changed -------
end
	
---------------------------------------------------------

function Auctionator_Idle_CheckNewIfQueryNeeded (self)

	if (processing_state == KM_PREQUERY) then
		if (CanSendAuctionQuery()) then
			processing_state = KM_IN_QUERY;
			QueryAuctionItems (currentAuctionItemName, "", "", nil, currentAuctionClass, currentAuctionSubclass, current_page, nil, nil);
			processing_state = KM_POSTQUERY;
			current_page = current_page + 1;
		end
	end
end

---------------------------------------------------------

function Auctionator_Idle_CheckForNewAuctionItem (self)


	local auctionItemName, auctionTexture, auctionCount = GetAuctionSellItemInfo(); 

	if (auctionItemName == nil) then
		auctionItemName = "";
		auctionCount	= 0;
	end

	if (currentAuctionItemName ~= auctionItemName or currentAuctionStackSize ~= auctionCount or forceMsgAreaUpdate) then
		
		forceMsgAreaUpdate = false;
		
		sorteddata = {};
		Auctionator_ScrollbarUpdate();

		currentAuctionItemName  = auctionItemName;
		currentAuctionStackSize = auctionCount;
		
		Auctionator_RecommendPerItem_Price:Hide();
		Auctionator_RecommendPerStack_Price:Hide();
		Auctionator_BatchButton:Disable();
		
		processing_state = KM_NULL_STATE;
		
		basedata = nil;
		
		if (currentAuctionItemName == "") then
		
			Auctionator_Update_MessageArea();
			
		else
			local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(currentAuctionItemName);
		
			currentAuctionClass		= ItemType2AuctionClass (sType);
			currentAuctionSubclass	= SubType2AuctionSubclass (currentAuctionClass, sSubType);

			SortAuctionItems("list", "buyout");

			if (IsAuctionSortReversed("list", "buyout")) then
				SortAuctionItems("list", "buyout");
			end
		 
			current_page = 0;
			processing_state = KM_PREQUERY;

			scandata = {};
		end

	end

end

-----------------------------------------

function Auctionator_Update_MessageArea()
			
	if (auctionator_pending_message) then
		Auctionator_SetMessage (auctionator_pending_message);
		auctionator_pending_message = nil;
	elseif (auctionator_last_item_posted == nil) then
		Auctionator_SetMessage ("Drag an item to the Auction Item area\n\nto see recommended pricing information");
	end
end

-----------------------------------------

function BS_GetCount(bs)

	local texture, count = GetContainerItemInfo (bs.bagID, bs.slotID);
	if (texture ~= nil) then
		return count;
	end
	
	return 0;
		
end

-----------------------------------------

function BS_InCslots(xbs)

	local i, bs;
	
	for i,bs in pairs(cslots) do
		if (xbs.bagID == bs.bagID and xbs.slotID == bs.slotID) then
			return true;
		end
	end

	return false;
	
end

-----------------------------------------

function BS_GetEmptySlot()


	if (gEmptyBScached == nil or BS_GetCount (gEmptyBScached) ~= 0) then
	
		gEmptyBScached = nil;
		
		for bagID = kFirstBag, kLastBag do
			numslots = GetContainerNumSlots (bagID);
			for slotID = 1,numslots do
				local itemLink = GetContainerItemLink(bagID, slotID);
				if (itemLink == nil) then
					gEmptyBScached = {};
					gEmptyBScached.bagID  = bagID;
					gEmptyBScached.slotID = slotID;
					
					-- add to cslots if not already there
					
					if (not BS_InCslots (gEmptyBScached)) then
--						chatmsg ("Inserting "..bagID.."/"..slotID);
						tinsert (cslots, gEmptyBScached);
					end
					
					return gEmptyBScached;
				end
			end
		end
	end
	
	return gEmptyBScached;
end



-----------------------------------------

function BS_PostAuction(bs)

	PickupContainerItem (bs.bagID, bs.slotID);

	local infoType = GetCursorInfo()

	if (infoType == "item") then
		ClickAuctionSellItemButton();
		ClearCursor();
	end
	
	StartAuction (gAutoSell_StartPrice, gAutoSell_BuyoutPrice, gAutoSell_Hours * 60);
		
end

-----------------------------------------

function BS_FindGoodStack()

	local dstr = "";
	local i;
	
	for i, bs in pairs (cslots) do
	
		dstr = dstr..BS_GetCount (bs).." ";
		
		if (BS_GetCount (bs) == gAutoSell_GoodStackSize) then
--			chatmsg ("FindGood: "..dstr);
			return bs
		end
	
	end
	
--	chatmsg ("FindGoodx: "..dstr);
	
	return nil;
	
end

-----------------------------------------

function BS_MergeSmallStacks()			-- find the 2 smallest stacks and merge them together if possible

	if (#cslots < 2) then
		return false;
	end
	
	local i, bs;
	
	local zbs	= nil;		-- smallest
	local ybs	= nil;		-- second smallest
	
	local zcount = 10000;
	local ycount = 10000;
	
	for i, bs in pairs (cslots) do
		local count = BS_GetCount (bs);
	
		if (count > 0) then
			if (count < zcount) then
				ybs = zbs;	ycount = zcount;
				zbs = bs;	zcount = count;
			elseif (count < ycount) then
				ybs = bs;	ycount = count;
			end
		end
	end
	
	if (zcount == 10000 or ycount == 10000) then
		return false;
	end
		
	-- try to make a "good" stack

	if (zcount < gAutoSell_GoodStackSize and ycount + zcount >= gAutoSell_GoodStackSize) then
		SplitContainerItem  (ybs.bagID, ybs.slotID, gAutoSell_GoodStackSize - zcount);
		PickupContainerItem (zbs.bagID, zbs.slotID);
	
		gAutoSell_targetBS		= zbs;
		gAutoSell_targetCount	= gAutoSell_GoodStackSize;
		
		return true;
	
	end
			
	-- merge them best as possible
	
	local numToMove = zcount;
	if (zcount + ycount > gAutoSell_FullStackSize) then
		numToMove = gAutoSell_FullStackSize - ycount;
	end
	
	if (numToMove > 0) then
		SplitContainerItem  (zbs.bagID, zbs.slotID, numToMove);
		PickupContainerItem (ybs.bagID, ybs.slotID);

		gAutoSell_targetBS		= ybs;
		gAutoSell_targetCount	= ycount + numToMove;

		return true;
	end
	
	return false;
	
end


-----------------------------------------

function BS_SplitLargeStack()

	local i, bs;
	
	local emptyBS = BS_GetEmptySlot ();

	for i, bs in pairs (cslots) do
		local count = BS_GetCount (bs);
	
		if (count > gAutoSell_GoodStackSize) then
			if (emptyBS) then
				SplitContainerItem  (bs.bagID, bs.slotID, gAutoSell_GoodStackSize);
				PickupContainerItem (emptyBS.bagID, emptyBS.slotID);

				gAutoSell_targetBS		= emptyBS;
				gAutoSell_targetCount	= gAutoSell_GoodStackSize;
				return true;
			end
		end
	
	end
			
	return false;

end

-----------------------------------------

function Auctionator_Idle_AutoSelling()

--	if (gAutoSellState == SETTLED)				then AuctionatorMessage2Frame:SetText("SETTLED"); end;
--	if (gAutoSellState == AUCTION_POST_PENDING)	then AuctionatorMessage2Frame:SetText("AUCTION_POST_PENDING"); end;
--	if (gAutoSellState == STACK_SPLIT_PENDING)	then AuctionatorMessage2Frame:SetText("STACK_SPLIT_PENDING"); end;
--	if (gAutoSellState == STACK_MERGE_PENDING)	then AuctionatorMessage2Frame:SetText("STACK_MERGE_PENDING"); end;


	if (CursorHasItem()) then
		return;
	end
	
	if (gAutoSellState == AUCTION_POST_PENDING) then
		return;
	end
	
	if (gAutoSellState == STACK_MERGE_PENDING or gAutoSellState == STACK_SPLIT_PENDING) then
		
		if (BS_GetCount (gAutoSell_targetBS) == gAutoSell_targetCount) then
			ClearCursor();
			gAutoSellState = SETTLED;
		else
			return;
		end
	end

	if (gAutoSellState ~= SETTLED) then
		return
	end
	
	-- let's see if we're done
	
	if (gAutoSell_AuctionNum > gAutoSell_NumAuctionsToCreate) then
		gAutoSelling = false;
		return;
	end
	
	
	-- if there's a stack that's ready to sell, sell it
	
	local goodBS = BS_FindGoodStack();
	
	if (goodBS) then
		BS_PostAuction (goodBS);
		gAutoSellState = AUCTION_POST_PENDING;
		return;
	end
		
	-- see if we can split a larger stack to get a sellable stack
	
	local success = BS_SplitLargeStack();
	if (success) then
		gAutoSellState = STACK_SPLIT_PENDING;
		return;
	end
	
	-- see if we can merge two smaller stacks
	
	local success = BS_MergeSmallStacks();
	if (success) then
		gAutoSellState = STACK_MERGE_PENDING;
		return;
	end

	
	-- nothing left to do - we're done
	
	gAutoSelling = false;

end

-----------------------------------------

function Auctionator_ScrollbarUpdate()

	local line;				-- 1 through 12 of our window to scroll
	local dataOffset;		-- an index into our data calculated from the scroll offset

	local numrows = #sorteddata;

	if (numrows > 0) then
		Auctionator_Col1_Heading:Show();
		Auctionator_Col2_Heading:Show();
		Auctionator_Col3_Heading:Show();
		Auctionator_Col4_Heading:Show();
	end
	
	FauxScrollFrame_Update (AuctionatorScrollFrame, numrows, 12, 16);

	for line = 1,12 do

		dataOffset = line + FauxScrollFrame_GetOffset (AuctionatorScrollFrame);
		
		local lineEntry = getglobal ("AuctionatorEntry"..line);
		
		lineEntry:SetID(dataOffset);
		
		if dataOffset <= numrows and sorteddata[dataOffset] then
			
			local data = sorteddata[dataOffset];

			local lineEntry_item_tag = "AuctionatorEntry"..line.."_PerItem_Price";
			
			local lineEntry_item	= getglobal(lineEntry_item_tag);
			local lineEntry_avail	= getglobal("AuctionatorEntry"..line.."_Availability");
			local lineEntry_comm	= getglobal("AuctionatorEntry"..line.."_Comment");
			local lineEntry_stack	= getglobal("AuctionatorEntry"..line.."_StackPrice");

			if (data.itemPrice == basedata.itemPrice and data.stackSize == basedata.stackSize) then
				lineEntry:LockHighlight();
			else
				lineEntry:UnlockHighlight();
			end

			if ( data.stackSize == currentAuctionStackSize ) then	lineEntry_avail:SetTextColor (0.2, 0.9, 0.2);
			else													lineEntry_avail:SetTextColor (1.0, 1.0, 1.0);
			end;

			
			if		(data.numYours == 0) then			lineEntry_comm:SetText ("");
			elseif	(data.numYours == data.count) then	lineEntry_comm:SetText ("yours");
			else										lineEntry_comm:SetText ("yours: "..data.numYours);
			end;
				
		
			local tx = string.format ("%i %s of %i", data.count, pluralizeIf ("stack", data.count), data.stackSize);
			lineEntry_avail:SetText (tx);

			if (data.buyoutPrice == 0) then
				lineEntry_item:Hide();
				lineEntry_stack:SetText ("no buyout price");
			else
				lineEntry_item:Show();
				MoneyFrame_Update (lineEntry_item_tag, round(data.buyoutPrice/data.stackSize) );
				lineEntry_stack:SetText (priceToString(data.buyoutPrice));
			end
			
			lineEntry:Show();
		else
			lineEntry:Hide();
		end
	end
end

-----------------------------------------

function Auctionator_EntryOnClick()
	
	if (Auctionator_Batch_Frame:IsShown()) then
		return;
	end

	local entryIndex = this:GetID();
	
--	chatmsg (entryIndex);
	
	basedata = sorteddata[entryIndex];

	Auctionator_UpdateRecommendation();

	PlaySound ("igMainMenuOptionCheckBoxOn");
end

-----------------------------------------

function AuctionatorMoneyFrame_OnLoad()

	this.small = 1;
	MoneyFrame_SetType("AUCTION");
end


-----------------------------------------

function Auctionator_ShowBatchFrame()

	gAutoSell_ItemName			= currentAuctionItemName;
	gAutoSell_GoodStackSize		= currentAuctionStackSize;
	gAutoSell_StartPrice		= MoneyInputFrame_GetCopper(StartPrice);
	gAutoSell_BuyoutPrice		= MoneyInputFrame_GetCopper(BuyoutPrice);
	gAutoSell_Hours				= AuctionFrameAuctions.duration / 60;

	local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo (gAutoSell_ItemName);

	gAutoSell_FullStackSize = iStackCount;
	gAutoSell_TotalItems	= 0;
	
	for bagID = kFirstBag, kLastBag do
		numslots = GetContainerNumSlots (bagID);
		for slotID = 1,numslots do
			local itemLink = GetContainerItemLink(bagID, slotID);
			if (itemLink) then
				local itemName				= GetItemInfo(itemLink);
				local texture, itemCount	= GetContainerItemInfo(bagID, slotID);

				if (itemName == gAutoSell_ItemName) then
					gAutoSell_TotalItems = gAutoSell_TotalItems + itemCount;
				end
			end
		end		
	end

	local numStacks = math.floor (gAutoSell_TotalItems / gAutoSell_GoodStackSize);


	local text =  "You have "..gAutoSell_TotalItems.." "..pluralizeIf (gAutoSell_ItemName).." in your bags.";

	
	Auctionator_SetTextureButton ("Auctionator_Batch_Texture", gAutoSell_ItemName, gAutoSell_GoodStackSize);

	MoneyFrame_Update ("Auctionator_Batch_Start_Price",  gAutoSell_StartPrice);
	MoneyFrame_Update ("Auctionator_Batch_Buyout_Price", gAutoSell_BuyoutPrice);

	Auctionator_Batch_Duration:SetText (gAutoSell_Hours.." hours");
	Auctionator_Batch_Itemname:SetText (gAutoSell_ItemName);
	
	Auctionator_Batch_NumAuctions:SetText (numStacks);
	
	Auctionator_Batch_Frame:Show();
end

-----------------------------------------

function Auctionator_ShowOptionsFrame()

	AuctionatorOptionsFrame:Show();
	AuctionatorOptionsFrame:SetBackdropColor(0,0,0,100);
	
	AuctionatorConfigFrameTitle:SetText ("Auctionator Options for "..UnitName("player"));
	
	local expText = "<html><body>"
					.."<h1>What is Auctionator?</h1><br/>"
					.."<p>"
					.."Figuring out a good buyout price when posting auctions can be tedious and time-consuming.  If you're like most people, you first browse the current "
					.."auctions to get a sense of how much your item is currently selling for.  Then you undercut the lowest price by a bit.  If you're creating multiple auctions "
					.."you're bouncing back and forth between the Browse tab and the Auctions tab, doing lots of division in "
					.."your head, and doing lots of clicking and typing."
					.."</p><br/><h1>How it works</h1><br/><p>"
					.."Auctionator makes this whole process easy and streamlined.  When you select an item to auction, Auctionator displays a summary of all the current auctions for "
					.."that item sorted by per-item price.  Auctionator also calculates a recommended buyout price based on the cheapest per-item price for your item.  If you're "
					.."selling a stack rather than a single item, Auctionator bases its recommended buyout price on the cheapest stack of the same size."
					.."</p><br/><p>"
					.."If you don't like Auctionator's recommendation, you can click on any line in the summary and Auctionator will recalculate the recommended buyout price based "
					.."on that auction.  Of course, you can always override Auctionator's recommendation by just typing in your own buyout price."
					.."</p><br/><p>"
					.."With Auctionator, creating an auction is usually just a matter of picking an item to auction and clicking the Create Auction button."
					.."</p>"
					.."</body></html>"
					;



	AuctionatorExplanation:SetText ("Auctionator is an addon designed to make it easier and faster to setup your auctions at the auction house.");
	AuctionatorDescriptionHTML:SetText (expText);
	AuctionatorDescriptionHTML:SetSpacing (3);

	AuctionatorVersionText:SetText ("Version: "..AuctionatorVersion);

	
	AuctionatorOption_Enable_Alt:SetChecked (NumToBool(AUCTIONATOR_ENABLE_ALT));
	AuctionatorOption_Open_First:SetChecked (NumToBool(AUCTIONATOR_OPEN_FIRST));
end

-----------------------------------------

function AuctionatorOptionsSave()

	AUCTIONATOR_ENABLE_ALT = BoolToNum(AuctionatorOption_Enable_Alt:GetChecked ());
	AUCTIONATOR_OPEN_FIRST = BoolToNum(AuctionatorOption_Open_First:GetChecked ());
	
end

-----------------------------------------

function Auctionator_ShowTooltip_EnableAlt()

	GameTooltip:SetOwner(this, "ANCHOR_BOTTOM");
	GameTooltip:SetText("Enable alt-key shortcut", 0.9, 1.0, 1.0);
	GameTooltip:AddLine("If this option is checked, holding the Alt key down while clicking an item in your bags will switch to the Auctionator panel, place the item in the Auction Item area, and start the scan.", 0.5, 0.5, 1.0, 1);
	GameTooltip:Show();

end

-----------------------------------------

function Auctionator_ShowTooltip_OpenFirst()

	GameTooltip:SetOwner(this, "ANCHOR_BOTTOM");
	GameTooltip:SetText("Automatically open Auctionator panel", 0.9, 1.0, 1.0);
	GameTooltip:AddLine("If this option is checked, the Auctionator panel will display first whenever you open the Auction House window.", 0.5, 0.5, 1.0, 1);
	GameTooltip:Show();

end

-----------------------------------------

function Auctionator_TabSelected()

	if (not AuctionFrame or not AuctionFrame:IsShown()) then
		return false;
	end

	return (PanelTemplates_GetSelectedTab (AuctionFrame) == AUCTIONATOR_TAB_INDEX);
end

-----------------------------------------

function Auctionator_Confirm_Yes()

	if (Auctionator_Confirm_Proc_Yes) then
		Auctionator_Confirm_Proc_Yes();
		Auctionator_Confirm_Proc_Yes = nil;
	end
	
	Auctionator_Confirm_Frame:Hide();
	
end


-----------------------------------------

function Auctionator_Confirm_No()

	Auctionator_Confirm_Frame:Hide();
	
end



--[[***************************************************************

	All function below here are local utility functions.
	These should be declared local at the top of this file.

--*****************************************************************]]


function BoolToString (b)
	if (b) then
		return "true";
	end
	
	return "false";
end

-----------------------------------------

function BoolToNum (b)
	if (b) then
		return 1;
	end
	
	return 0;
end

-----------------------------------------

function NumToBool (n)
	if (n == 0) then
		return false;
	end
	
	return true;
end

-----------------------------------------

function pluralizeIf (word, count)

	if (count and count == 1) then
		return word;
	else
		return pluralize(word);
	end
end

-----------------------------------------

function pluralize (word)

	return word.."s";

end

-----------------------------------------

function round (v)
	return math.floor (v + 0.5);
end

-----------------------------------------

function chatmsg (msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage (msg);
	end
end

-----------------------------------------

function calcNewPrice (price)

	if	(price > 2000000)	then return roundPriceDown (price, 10000, 10000);	end;
	if	(price > 1000000)	then return roundPriceDown (price,  2500,  2500);	end;
	if	(price >  500000)	then return roundPriceDown (price,  1000,  1000);	end;
	if	(price >   50000)	then return roundPriceDown (price,   500,   500);	end;
	if	(price >   10000)	then return roundPriceDown (price,   500,   200);	end;
	if	(price >    2000)	then return roundPriceDown (price,   100,    50);	end;
	if	(price >     100)	then return roundPriceDown (price,    10,     5);	end;
	if	(price >       0)	then return math.floor (price - 1);	end;

	return 0;
end

-----------------------------------------
-- roundPriceDown - rounds a price down to the next lowest multiple of a.
--				  - if the result is not at least b lower, rounds down by a again.
--
--	examples:  	(128790, 500, 250)  ->  128500 
--				(128700, 500, 250)  ->  128000 
--				(128400, 500, 250)  ->  128000
-----------------------------------------

function roundPriceDown (price, a, b)
	
	local newprice = math.floor(price / a) * a;
	
	if ((price - newprice) < b) then
		newprice = newprice - a;
	end
	
	return newprice;
	
end

-----------------------------------------

function val2gsc (v)
	local rv = round(v)
	
	local g = math.floor (rv/10000);
	
	rv = rv - g*10000;
	
	local s = math.floor (rv/100);
	
	rv = rv - s*100;
	
	local c = rv;
			
	return g, s, c
end

-----------------------------------------

function priceToString (val)

	local gold, silver, copper  = val2gsc(val);

	local st = "";
	

	if (gold ~= 0) then
		st = gold.."g ";
	end


	if (st ~= "") then
		st = st..format("%02is ", silver);
	elseif (silver ~= 0) then
		st = st..silver.."s ";
	end

		
	if (st ~= "") then
		st = st..format("%02ic", copper);
	elseif (copper ~= 0) then
		st = st..copper.."c";
	end
	
	return st;
end

-----------------------------------------

function ItemType2AuctionClass(itemType)
	local itemClasses = { GetAuctionItemClasses() };
	if #itemClasses > 0 then
	local itemClass;
		for x, itemClass in pairs(itemClasses) do
			if (itemClass == itemType) then
				return x;
			end
		end
	end
end


-----------------------------------------

function SubType2AuctionSubclass(auctionClass, itemSubtype)
	local itemClasses = { GetAuctionItemSubClasses(auctionClass) };
	if #itemClasses > 0 then
	local itemClass;
		for x, itemClass in pairs(itemClasses) do
			if (itemClass == itemSubtype) then
				return x;
			end
		end
	end
end






