LOOT_ROW_HEIGHT = 38;

function LootScrollFrame_OnLoad()
	ScrollFrame_OnLoad();
	LootFrameUpButton:Hide();
	LootFramePrev:Hide();
	LootFrameDownButton:Hide();
	LootFrameNext:Hide();
	this:RegisterEvent("LOOT_SLOT_CLEARED");
	for i=1, LOOTFRAME_NUMBUTTONS do
		local button=getglobal("LootButton"..i);
		button:SetScript("OnEnter", LootScrollFrame_OnEnter);
	end
end

function LootScrollFrame_OnEvent()
	if ( event=="LOOT_SLOT_CLEARED" ) then
		LootFrame_Update();
	end
end

function LootFrame_Update()
	local lootTable=SortLoot();
	local numLootItems=getn(lootTable);
	if ( numLootItems <= LOOTFRAME_NUMBUTTONS ) then
		LootScrollFrame:Hide();
	else
		LootScrollFrame:Show();
	end

	local offset = FauxScrollFrame_GetOffset(LootScrollFrame);
	local texture, item, quantity, quality;
	local button, countString, color;
	for index = 1, LOOTFRAME_NUMBUTTONS do
		button = getglobal("LootButton"..index);
		local id = offset + index;
		if ( id <= numLootItems ) then
			local slot=lootTable[id];
			texture, item, quantity, quality = GetLootSlotInfo(slot);
			color = ITEM_QUALITY_COLORS[quality];
			getglobal("LootButton"..index.."IconTexture"):SetTexture(texture);
			getglobal("LootButton"..index.."Text"):SetText(item);
			getglobal("LootButton"..index.."Text"):SetVertexColor(color.r, color.g, color.b);
			countString = getglobal("LootButton"..index.."Count");
			if ( quantity > 1 ) then
				countString:SetText(quantity);
				countString:Show();
			else
				countString:SetText('');
				countString:Hide();
			end
			button:SetSlot(slot);
			button.slot = slot;
			button.quality = quality;
			button:Show();
		else
			button:Hide();
		end
	end

	-- Scroll frame stuff
	FauxScrollFrame_Update( LootScrollFrame, numLootItems, LOOTFRAME_NUMBUTTONS, LOOT_ROW_HEIGHT );
end

function SortLoot()
	local lootTable={};
	for slot=1, GetNumLootItems() do
		if ( LootSlotIsItem(slot) or LootSlotIsCoin(slot)) then
			tinsert(lootTable, slot);
		end
	end
	return lootTable;
end

function LootScrollFrame_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetLootItem(this.slot);
	CursorUpdate();
end