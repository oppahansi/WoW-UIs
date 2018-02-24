-- Copyright © 2006 Mazin Assanie
-- All Rights Reserved.
-- 
-- Permission to use, copy, modify, and distribute this software in any way
-- is not granted without expressed written agreement.  In the case that it
-- is granted, the above copyright notice and this paragraph must appear in
-- all copies, modifications, and distributions.
--
-- To contact the author of this work, use mazzlefizz@gmail.com 
-- For more information on copyright, visit http://copyright.gov/ or http://whatiscopyright.org/
--

function Mazzify_ClearActions()
	MazzifySS_ClearCursor();
	for i = 0, 9 do
		for j = 1, 12 do
    		local id = j + i*12;
			MazzifySS_ClearSlot(id);
        end
    end
end

function Mazzify_SASLoad(actions)
	MazzifySS_ClearCursor();
	local actionList, closedList = {}, {}
	for i = 0, 9 do
		for j = 1, 12 do
			local id = j + i*12;
			local msg = "Action "..id;
			if ( actions[i][j]  ) then
			    if (type(actions[i][j]) == "table") then
			        actionList = actions[i][j]
			    else
			        actionList = {}
			        actionList[1] = actions[i][j]
			    end
			    actionPlaced = false
			    for _,theAction in actionList do
			        if (not actionPlaced) then
        				local ename, etexture, erank, elink, emacro = MazzifySS_GetActionInfo(id, 1);
        				local name, texture, rank, link, macro = MazzifySS_ParseActionInfo( theAction ); --actions[i][j][1], actions[i][j][2], actions[i][j][3], actions[i][j][4], actions[i][j][5];
        				if ( (name == ename and (( rank == erank ) or ( macro and emacro ) or ( link and elink ))) ) then
        					msg = msg.." is the same as the one trying to be swapped.";
        				else
        					if ( macro ) then
        						msg = msg.." is a macro.";
        						local macroID = MazzifySS_FindMacro( name, texture, macro )
        						if ( macroID ) then
        							PickupMacro( macroID );
        							PlaceAction(id);
                    			    actionPlaced = true
        						else
        							msg = msg.." |wCouldn't find macro."
        							MazzifySS_ClearSlot(id);
        						end
        					elseif ( link ) then
        						msg = msg.." is an item.";
        						if ( not MazzifySS_PlaceItem( id, link, name, set ) ) then
        							msg = msg.." |wCouldn't find item."
        							--MazzifySS_MissingItem( id, {name, texture, link, set} );
        						else actionPlaced = true; end
        					elseif ( name ) then
        						msg = msg.." is a spell.";
        						local spellNum, highest = MazzifySS_FindSpell( name, rank );
        						if ( spellNum and (not closedList[spellNum])) then
        							PickupSpell( spellNum, BOOKTYPE_SPELL );
        							PlaceAction(id);
        							closedList[spellNum] = true;
                    			    actionPlaced = true
        						elseif ( highest and (not closedList[highest])) then
        							closedList[highest] = true;
        							local spellName, spellRank = GetSpellName( highest, BOOKTYPE_SPELL );
        							if ( rank ~= spellRank ) then
        								msg = msg.." Can't find rank, using highest found instead.";
        								PickupSpell( highest, BOOKTYPE_SPELL );
        								PlaceAction(id);
        							else
        								msg = msg.." Action is highest rank found, won't swap.";
        							end
                    			    actionPlaced = true
        						else
        							msg = msg.." |wCoulnd't find spell."
        							MazzifySS_ClearSlot(id);
        						end
        					else
        						msg = msg.." is has no name, link, macro?";
        					end
        				end
        				MazzifySS_ClearCursor();
                    end
    			end
			else
				msg = msg.." is empty.";
				MazzifySS_ClearSlot(id);
			end
			--ace:print(msg);
		end
	end
	MazzifySS_ClearCursor();
end

function MazzifySS_GetActionInfo( id, quick )
	-- Scans an action button to attempt to determine if it's a spell, macro, or item
	if ( HasAction(id) ) then
		MazzifySSToolTip:SetOwner(WorldFrame, "ANCHOR_NONE");
		MazzifySSToolTip:SetAction(id);
		local name = MazzifySSToolTipTextLeft1:GetText();
		local rank, macro, link;
		local texture = GetActionTexture(id);

		local count = GetActionCount(id);

		if ( name and name ~= "" ) then
			if ( MazzifySSToolTipTextRight1:IsShown() ) then
			 	rank = tRank(MazzifySSToolTipTextRight1:GetText())
			end
			local spellNum = MazzifySS_FindSpell( name, rank );
			if ( spellNum ) then
				-- is ActionButton a spell
				texture = GetSpellTexture( spellNum, BOOKTYPE_SPELL ); -- auras don't have correct texture on action bar
			elseif ( GetActionText(id) ) then
				-- is ActionButton a macro
				macro = GetMacroIndexByName(name); -- will find first macro with name by creation date
			else
				-- is ActionButton an item
				if ( quick ) then -- avoid slow item check
					link = "?";
				else
					if ( count > 0 ) then
						link = MazzifySS_ItemLink( name );
						--if ( not link ) then ace:print("|wItem "..name.." on action button "..id.." not found."); end
					else
						--ace:print("|wItem "..name.." on action button "..id.." is an item not on this character.");
						link = "?";
					end
				end
			end
			return name, texture, rank, link, macro; --{ name, rank, macro, link, texture };
		else
			--ace:print("|wAction "..id.." HasAction() but doesn't have anything in it.");
		end
	end
end

function MazzifySS_ParseActionInfo( action, ... )
	if not action then return; end
	if type(action)~="string" then return action; end
	local a = {};
	for val in string.gfind( action, "(.-)·" ) do
		tinsert( a, val );
	end
	for k, v in a do if v == "" then v = nil; end end
	if ( arg.n > 0 ) then
		local b = {};
		for i=1, arg.n do
			tinsert( b, a[arg[i]] );
		end
		return unpack(b);
	else
		return a[1], a[2], tonumber(a[3]), a[4], tonumber(a[5]), a[6]; --name, texture, rank, link, macro, ?;
	end
end

function MazzifySS_FindMacro( name, texture, macro )
	-- Check saved macro id
	local macroName, macroTexture, bestguess;
	if ( macro ) then
		macroName, macroTexture = GetMacroInfo(macro);
		if ( macroName == name ) then
			if ( texture and macroTexture == texture ) then
				return macro;
			end
			bestguess = macro;
		end
	end
	
	-- If no direct match, iterate over macros and return matching index
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	numCharacterMacros = numCharacterMacros + 18;
	for i=1, 36 do
		if ( i > numAccountMacros and i < 19 ) then
			-- no more global macros, skip to local
			i = 19;
		end
		if ( i > numCharacterMacros ) then
			-- no more macros
			break;
		end
		macroName, macroTexture = GetMacroInfo(i)
		if ( macroName and macroName == name ) then
			if ( texture and macroTexture == texture ) then
				return i;
			end
			bestguess = i;
		end
	end
	
	return bestguess;
end
function MazzifySS_ClearSlot(id)
	-- Clear an action slot
	if ( HasAction(id)) then
		PickupAction(id);
		MazzifySS_ClearCursor();
	end
end

function MazzifySS_PlaceItem( id, link, name, set )
	-- Place an item, update set link id if found
	local itemLink, bag, slot, inv;
	if ( link == "?" or link == "1" ) then
		itemLink, bag, slot, inv = MazzifySS_CheckItem( name, id, set );
	else
		itemLink, bag, slot, inv = MazzifySS_FindItem( link );
	end
	if ( bag ) then
		PickupContainerItem( bag, slot );
		PlaceAction(id);
		return 1;
	elseif ( inv ) then
		PickupInventoryItem( inv );
		PlaceAction(id);
		return 1;
	end
end

function MazzifySS_ClearCursor()
	-- Clear the cursor of anything
	local i = 500
	while GetSpellName( i, BOOKTYPE_SPELL ) do
		i = i+1;
	end
	PickupSpell( i+1, BOOKTYPE_SPELL );
end

function tRank( rank )
	-- truncate ranks to just numerical data
	if ( not rank ) then return; end
	for i in string.gfind( rank, "%d+" ) do return tonumber(i); end
end

function MazzifySS_FindSpell( spell, rank )
	-- Iterate over spells the player has and return location
	if ( not spell ) then return; end
	local i = 1;
	local highest;
	local spellName, spellRank = GetSpellName( i, BOOKTYPE_SPELL );
	--if ( any and PlrClass == "WARRIOR" and PlrClass == "ROGUE" ) then
	--	rank = nil;
	--end
	local name, texture, offset, numSpells = nil, nil, 0, 0;
	--if ( not strict and PlrClass == "DRUID" and GetNumSpellTabs() == 4 ) then
	--	name, texture, offset, numSpells = GetSpellTabInfo(3)
	--	numSpells = numSpells+offset;
	--end
	while spellName do
		if ( spellName == spell ) then
			highest = i;
			if ( rank ) then
				if ( tRank(spellRank) == tonumber(rank) ) then
					return i;
				end
			else
				return i;
			end
		end
		i = i+1;
		spellName, spellRank = GetSpellName( i, BOOKTYPE_SPELL );
	end
	
	return nil, highest;
end

function MazzifySS_ItemLink( item )
	-- Return an item's link
	local itemLink = MazzifySS_FindItem( item );
	if ( itemLink ) then
		return MazzifySS_FindLink( itemLink );
	end
end

function MazzifySS_FindLink( item )
	-- Find an item's link number from it's item link
	if ( item ) then
		for link in string.gfind( item, "(%d+:%d+:%d+:%d+)" ) do
			return MazzifySS_tLink(link);
		end
	end
end

function MazzifySS_tLink( itemLink )
	-- truncate item links to item ids
	if ( not itemLink ) then return; end
	for num in string.gfind( itemLink, "(%d+):0:0:0" ) do return num; end
	return itemLink;
end

function MazzifySS_FindItem( item )
	-- Iterate over items the player has and return it's link and location --
	if ( not item ) then return; end
	
	item = tostring(item);
	
	-- Iterate over bags
	for i=0, 4 do
		local bagSlots = GetContainerNumSlots(i);
		if ( bagSlots ) then
			for j=1, bagSlots do
				--SASDebug("Doing GetContainerItemLink() on "..i.." "..j);
				local itemLink = GetContainerItemLink(i,j);
				if ( itemLink ) then
					if ( item == MazzifySS_FindLink( itemLink ) or item == MazzifySS_FindName( itemLink ) ) then
						return itemLink, i, j;
					end
				end
			end
		end
	end
	
	-- Iterate over paper doll
	for i=0, 23 do
		--SASDebug("Doing GetInventoryItemLink() on "..i);
		local itemLink = GetInventoryItemLink("player",i);
		if ( itemLink ) then
			if ( itemLink ) then
				if ( item == MazzifySS_FindLink( itemLink ) or item == MazzifySS_FindName( itemLink ) ) then
					return itemLink, nil, nil, i;
				end
			end
		end
	end
end

function MazzifySS_FindName( item )
	-- Find an item's name from it's item link
	if ( item ) then
		for name in string.gfind( item, "%[(.+)%]") do
			return name;
		end
	end
end

function MazzifySS_CheckItem( name, id, set )
	if ( name ) then
		itemLink, bag, slot, inv = MazzifySS_FindItem( name );
		itemLink = MazzifySS_FindLink(itemLink)
		if ( not itemLink ) then
			itemLink = "?";
		end
		if ( itemLink and itemLink ~= "?" and itemLink ~= "1" ) then
			local slot = math.mod( id, 12 );
			local bar = (id-slot) / 12;
		end
	end
	return itemLink, bag, slot, inv;
end
