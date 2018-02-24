local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local DEFAULT = "|cffFFd200";
local ParseTooltip_Enabled = false;

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
function AtlasLootItem_OnEnter()
    local isItem;
    AtlasLootTooltip:ClearLines();
    for i=1, 30, 1 do
        if (getglobal("AtlasLootTooltipTextRight"..i) ~= nil) then
            getglobal("AtlasLootTooltipTextRight"..i):SetText("");
        end
    end
    if (this.itemID ~= 0) then
        if string.sub(this.itemID, 1, 1) == "s" then
            isItem = false;
        else
            isItem = true;
        end
        if isItem then
            local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 3, 10);
            local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
            if(this.itemID ~= 0 and this.itemID ~= "" and this.itemID ~= nil and AtlasLootDKPValues and AtlasLootClassPriority) then
                Identifier = "Item"..this.itemID;
                DKP = AtlasLootDKPValues[Identifier];
                priority = AtlasLootClassPriority[Identifier];
            else
                DKP = nil;
                priority = nil;
            end
            --Lootlink tooltips
            if( AtlasLoot.db.profile.LootlinkTT ) then
                --If we have seen the item, use the game tooltip to minimise same name item problems
                if(GetItemInfo(this.itemID) ~= nil) then
                    getglobal(this:GetName().."_Unsafe"):Hide();
                    AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                    AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
                    if ( AtlasLoot.db.profile.ItemIDs ) then
                        AtlasLootTooltip:AddLine(BLUE..AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
                    end
                    if( this.droprate ~= nil) then
                        AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0);
                    end
                    if( DKP ~= nil and DKP ~= "" ) then
                        AtlasLootTooltip:AddLine(RED..DKP.." "..AL["DKP"], 1, 1, 0, 1);
                    end
                    if( priority ~= nil and priority ~= "" ) then
                        AtlasLootTooltip:AddLine(GREEN..AL["Priority:"].." "..priority, 1, 1, 0, 1);
                    end
                    AtlasLootTooltip:Show();
                    if(AtlasLoot.db.profile.EquipCompare and ((not EquipCompare_RegisterTooltip) or (not EquipCompare_Enabled))) then
                        AtlasLootItem_ShowCompareItem(); --- CALL MISSING METHOD TO SHOW 2 TOOLTIPS (Item Compare)
                    end
                    if (LootLink_AddItem) then
                        LootLink_AddItem(name, this.itemID..":0:0:0", color);
                    end
                else
                    AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                    if (LootLink_Database and LootLink_Database[this.itemID]) then
                       LootLink_SetTooltip(AtlasLootTooltip, LootLink_Database[this.itemID][1], 1);
                    else
                       LootLink_SetTooltip(AtlasLootTooltip,strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11), 1);
                    end
                    if ( AtlasLoot.db.profile.ItemIDs ) then
                        AtlasLootTooltip:AddLine(BLUE..AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
                    end
                    if( this.droprate ~= nil) then
                        AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0, 1);
                    end
                    if( DKP ~= nil and DKP ~= "" ) then
                        AtlasLootTooltip:AddLine(RED..DKP.." "..AL["DKP"], 1, 1, 0);
                    end
                    if( priority ~= nil and priority ~= "" ) then
                        AtlasLootTooltip:AddLine(GREEN..AL["Priority:"].." "..priority, 1, 1, 0);
                    end
                    AtlasLootTooltip:AddLine(" ");
                    AtlasLootTooltip:AddLine(AL["You can right-click to attempt to query the server.  You may be disconnected."], nil, nil, nil, 1);
                    AtlasLootTooltip:Show();
                end
            --Item Sync tooltips
            elseif( AtlasLoot.db.profile.ItemSyncTT ) then
                if(GetItemInfo(this.itemID) ~= nil) then
                    getglobal(this:GetName().."_Unsafe"):Hide();
                end
                ItemSync:ButtonEnter();
                if ( AtlasLoot.db.profile.ItemIDs ) then
                    GameTooltip:AddLine(BLUE..AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
                end
                if( this.droprate ~= nil) then
                    GameTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0);
                end
                if( DKP ~= nil and DKP ~= "" ) then
                    GameTooltip:AddLine(RED..DKP.." "..AL["DKP"], 1, 1, 0);
                end 
                if( priority ~= nil and priority ~= "" ) then
                    GameTooltip:AddLine(GREEN..AL["Priority:"].." "..priority, 1, 1, 0);
                end
                GameTooltip:Show();
                if(AtlasLoot.db.profile.EquipCompare and ((not EquipCompare_RegisterTooltip) or (not EquipCompare_Enabled))) then
                    GameTooltip_ShowCompareItem(); --- CALL MISSING METHOD TO SHOW 2 TOOLTIPS (Item Compare)
                end
            --Default game tooltips
            else
                if(this.itemID ~= nil) then
                    if(GetItemInfo(this.itemID) ~= nil) then
                        getglobal(this:GetName().."_Unsafe"):Hide();
                        AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
                        if ( AtlasLoot.db.profile.ItemIDs ) then
                            AtlasLootTooltip:AddLine(BLUE..AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
                        end
                        if( this.droprate ~= nil) then
                            AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0);
                        end
                        if( DKP ~= nil and DKP ~= "" ) then
                            AtlasLootTooltip:AddLine(RED..DKP.." "..AL["DKP"], 1, 1, 0);
                        end
                        if( priority ~= nil and priority ~= "" ) then
                            AtlasLootTooltip:AddLine(GREEN..AL["Priority:"].." "..priority, 1, 1, 0);
                        end
                        AtlasLootTooltip:Show();
                        if(AtlasLoot.db.profile.EquipCompare and ((not EquipCompare_RegisterTooltip) or (not EquipCompare_Enabled))) then
                            AtlasLootItem_ShowCompareItem(); --- CALL MISSING METHOD TO SHOW 2 TOOLTIPS (Item Compare)
                        end
                    else
                        AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasLootTooltip:ClearLines();
                        AtlasLootTooltip:AddLine(RED..AL["Item Unavailable"], nil, nil, nil, 1);
                        AtlasLootTooltip:AddLine(BLUE..AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
                        AtlasLootTooltip:AddLine(AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."], nil, nil, nil, 1);
                        AtlasLootTooltip:AddLine(" ");
                        AtlasLootTooltip:AddLine(AL["You can right-click to attempt to query the server.  You may be disconnected."], nil, nil, nil, 1);
                        AtlasLootTooltip:Show();
                    end
                end
            end
        else
            spellID = string.sub(this.itemID, 2);
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            AtlasLootTooltip:ClearLines();
            AtlasLootTooltip:SetHyperlink("enchant:"..spellID);
            AtlasLootTooltip:Show();            
        end
    end
end

--------------------------------------------------------------------------------
-- Item OnLeave
-- Called when the mouse cursor leaves a loot item
--------------------------------------------------------------------------------
function AtlasLootItem_OnLeave()
    --Hide the necessary tooltips
    if( AtlasLoot.db.profile.LootlinkTT ) then
        AtlasLootTooltip:Hide();
    elseif( AtlasLoot.db.profile.ItemSyncTT ) then
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
    else
        if(this.itemID ~= nil) then
		    AtlasLootTooltip:Hide();
            GameTooltip:Hide();
	    end
    end
    if ( ShoppingTooltip2:IsVisible() or ShoppingTooltip1.IsVisible) then
       ShoppingTooltip2:Hide();
       ShoppingTooltip1:Hide();
    end
end

--------------------------------------------------------------------------------
-- Item OnClick
-- Called when a loot item is clicked on
--------------------------------------------------------------------------------
function AtlasLootItem_OnClick(arg1)
    local isItem;
	local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 1, 10);
	local id = this:GetID();
	local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
    if string.sub(this.itemID, 1, 1) == "s" then
            isItem = false;
        else
            isItem = true;
        end
    if isItem then
        local iteminfo = GetItemInfo(this.itemID);
        local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(this.itemID);
        --If shift-clicked, link in the chat window
        if(arg1=="RightButton" and not iteminfo and this.itemID ~= 0) then
            AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0:0:0:0:0");
            if not AtlasLoot.db.profile.ItemSpam then
                DEFAULT_CHAT_FRAME:AddMessage(AL["Server queried for "]..color.."["..name.."]".."|r"..AL[".  Right click on any other item to refresh the loot page."]);
            end
            AtlasLootItemsFrame:Hide();
            AtlasLoot_ShowItemsFrame(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]);
        elseif(arg1=="RightButton" and iteminfo) then
            AtlasLootItemsFrame:Hide();
            AtlasLoot_ShowItemsFrame(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]);
            if not AtlasLoot.db.profile.ItemSpam then
                DEFAULT_CHAT_FRAME:AddMessage(itemLink..AL[" is safe."]);
            end
        elseif(IsShiftKeyDown() and iteminfo and (AtlasLoot.db.profile.SafeLinks or AtlasLoot.db.profile.AllLinks)) then
            ChatEdit_InsertLink(itemLink);
        elseif(IsShiftKeyDown() and AtlasLoot.db.profile.AllLinks) then
            ChatEdit_InsertLink(color.."|Hitem:"..this.itemID..":0:0:0:0:0:0:0|h["..name.."]|h|r");
        elseif(ChatFrameEditBox:IsVisible() and IsShiftKeyDown()) then
            ChatFrameEditBox:Insert(name);  -- <-- this line just inserts plain text, does not need any adjustment
        --If control-clicked, use the dressing room
        elseif(IsControlKeyDown() and iteminfo) then
            DressUpItemLink(itemLink);
        elseif(IsAltKeyDown() and (this.itemID ~= 0)) then
            if AtlasLootItemsFrame.refresh[1] == "WishList" then
                AtlasLoot_DeleteFromWishList(this.itemID);
            elseif AtlasLootItemsFrame.refresh[1] == "SearchResult" then
            	AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID));
            else
                DEFAULT_CHAT_FRAME:AddMessage(this.itemID);
                AtlasLoot_AddToWishlist(this.itemID, "", getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[1].."|"..AtlasLootItemsFrame.refresh[2]);
            end
        elseif((AtlasLootItemsFrame.refresh[1] == "SearchResult" or AtlasLootItemsFrame.refresh[1] == "WishList") and this.sourcePage) then
            local dataID, dataSource = strsplit("|", this.sourcePage);
            if(dataID and dataSource and AtlasLoot_IsLootTableAvailable(dataID)) then
                AtlasLoot_ShowItemsFrame(dataID, dataSource, AtlasLoot_TableNames[dataID][1], AtlasLootItemsFrame.refresh[4]);
            end
        end
    else
        if IsShiftKeyDown() then
            spellID = string.sub(this.itemID, 2);
            ChatEdit_InsertLink(GetSpellLink(spellID));
        elseif(IsAltKeyDown() and (this.itemID ~= 0)) then
            if AtlasLootItemsFrame.refresh[1] == "WishList" then
                AtlasLoot_DeleteFromWishList(this.itemID);
            else
                spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(string.sub(this.itemID, 2));
                --spellIcon = GetItemIcon(this.dressingroomID);
                AtlasLoot_AddToWishlist(this.itemID, this.dressingroomID, "=ds="..spellName, "=ds="..AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[1].."|"..AtlasLootItemsFrame.refresh[2]);
            end
        elseif(IsControlKeyDown()) then
            DressUpItemLink("item:"..this.dressingroomID..":0:0:0:0:0:0:0");
        elseif((AtlasLootItemsFrame.refresh[1] == "SearchResult" or AtlasLootItemsFrame.refresh[1] == "WishList") and this.sourcePage) then
            local dataID, dataSource = strsplit("|", this.sourcePage);
            if(dataID and dataSource and AtlasLoot_IsLootTableAvailable(dataID)) then
                AtlasLoot_ShowItemsFrame(dataID, dataSource, AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]);
            end
        end
    end
end

-------
-- Missing GameToolTip method
-- Enables item comparing. I've ripped this method directly from GameTooltip.lua and modified to work with AtlasLootTooltip /siena
-------
function AtlasLootItem_ShowCompareItem()
   local item,link= AtlasLootTooltip:GetItem();
    if ( not link ) then
      return;
   end
   
   local item1 = nil;
   local item2 = nil;
   local side = "left";
   if ( ShoppingTooltip1:SetHyperlinkCompareItem(link, 1) ) then
      item1 = true;
   end
   if ( ShoppingTooltip2:SetHyperlinkCompareItem(link, 2) ) then
      item2 = true;
   end
   local rightDist = GetScreenWidth() - AtlasLootTooltip:GetRight();
   if (rightDist < AtlasLootTooltip:GetLeft()) then
      side = "left";
   else
      side = "right";
   end
   if ( AtlasLootTooltip:GetAnchorType() ) then
      local totalWidth = 0;
      if ( item1  ) then
         totalWidth = totalWidth + ShoppingTooltip1:GetWidth();
      end
      if ( item2  ) then
         totalWidth = totalWidth + ShoppingTooltip2:GetWidth();
      end

      if ( (side == "left") and (totalWidth > AtlasLootTooltip:GetLeft()) ) then
         AtlasLootTooltip:SetAnchorType(AtlasLootTooltip:GetAnchorType(), (totalWidth - AtlasLootTooltip:GetLeft()), 0);
      elseif ( (side == "right") and (AtlasLootTooltip:GetRight() + totalWidth) >  GetScreenWidth() ) then
         AtlasLootTooltip:SetAnchorType(AtlasLootTooltip:GetAnchorType(), -((AtlasLootTooltip:GetRight() + totalWidth) - GetScreenWidth()), 0);
      end
   end

   -- anchor the compare tooltips
   if ( item1 ) then
      ShoppingTooltip1:SetOwner(AtlasLootTooltip, "ANCHOR_NONE");
      ShoppingTooltip1:ClearAllPoints();
      if ( side and side == "left" ) then
         ShoppingTooltip1:SetPoint("TOPRIGHT", "AtlasLootTooltip", "TOPLEFT", 0, -10);
      else
         ShoppingTooltip1:SetPoint("TOPLEFT", "AtlasLootTooltip", "TOPRIGHT", 0, -10);
      end
      ShoppingTooltip1:SetHyperlinkCompareItem(link, 1);
      ShoppingTooltip1:Show();

      if ( item2 ) then
         ShoppingTooltip2:SetOwner(ShoppingTooltip1, "ANCHOR_NONE");
         ShoppingTooltip2:ClearAllPoints();
         if ( side and side == "left" ) then
            ShoppingTooltip2:SetPoint("TOPRIGHT", "ShoppingTooltip1", "TOPLEFT", 0, 0);
         else
            ShoppingTooltip2:SetPoint("TOPLEFT", "ShoppingTooltip1", "TOPRIGHT", 0, 0);
         end
         ShoppingTooltip2:SetHyperlinkCompareItem(link, 2);
         ShoppingTooltip2:Show();
      end
   end   
end

   
