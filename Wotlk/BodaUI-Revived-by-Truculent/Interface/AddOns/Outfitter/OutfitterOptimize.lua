----------------------------------------
-- Specialty items for outfit optimization
----------------------------------------

Outfitter.cArgentDawnTrinkets = 
{
	{Code = 13209, SubCode = 0}, -- Seal of the Dawn
	{Code = 19812, SubCode = 0}, -- Rune of the Dawn
	{Code = 12846, SubCode = 0}, -- Argent Dawn Commission
}

Outfitter.cStatIDItems =
{
	ArgentDawn = Outfitter.cArgentDawnTrinkets,
}

----------------------------------------
-- Linear optimization (item-to-item comparisons)
----------------------------------------

function Outfitter:GenerateSmartOutfit(pName, pStat, pInventoryCache, pAllowEmptyOutfit, pStatParams, pCompletionFunc)
	local vStat
	
	pInventoryCache:ResetIgnoreItemFlags()
	
	if type(pStat) == "table" then
		vStat = pStat
	elseif type(pStat) == "string" then
		-- Backward compatibility (pre-LibStatLogic)
		
		if pStat == "Fishing" then
			pStat = "FISHING"
		end
		
		--
		
		vStat = self:GetStatByID(pStat)
		
		if not vStat then
			vStat = self:GetStatByID(pStat:upper()) -- Handle external addons using the older mixed-case stat IDs (FishingBuddy)
		end
	end
	
	if not vStat then
		self:ErrorMessage("Unknown stat optmization %s", tostring(pStat))
		self:DebugStack()
		return
	end
	
	local vStatID = vStat.ID
	local vOutfit
	
	if vStat.CompareOutfits then
		vOutfit = self:FindOutfitCombination(
							pName,
							pInventoryCache,
							vStat.GetFilterStats and vStat:GetFilterStats(),
							vStat, pStatParams, pCompletionFunc)
	else
		vOutfit = self:NewEmptyOutfit(pName)
		
		local vStatIDItems = self.cStatIDItems[vStatID]
		
		if vStatIDItems then
			--self:TestMessage("Adding static items for stat %s", tostring(vStatID))
			self:FindAndAddItemsToOutfit(vOutfit, nil, vStatIDItems, pInventoryCache)
		end
		
		self:AddItemsWithStatToOutfit(vOutfit, vStat, pInventoryCache)
		
		if not pAllowEmptyOutfit
		and vOutfit:IsEmpty() then
			return nil
		end
	end
	
	if vOutfit then
		vOutfit.StatID = vStatID
		
		if pCompletionFunc then
			pCompletionFunc(vOutfit)
		end
	end
	
	return vOutfit
end

function Outfitter:AddItemsWithStatToOutfit(pOutfit, pStat, pInventoryCache)
	local vItemStats
	
	if not pInventoryCache then
		return
	end
	
	for vInventorySlot, vItems in pairs(pInventoryCache.ItemsBySlot) do
		for vIndex, vItem in ipairs(vItems) do
			local vScore = pStat:GetItemScore(vItem)
			
			if vScore then
				local vSlotName = vItem.MetaSlotName
				
				if not vSlotName then
					vSlotName = vItem.ItemSlotName
				end
				
				if vItem.InvType == "INVTYPE_2HWEAPON"
				and not self:ItemUsesBothWeaponSlots(vItem) then
					vSlotName = "Weapon0Slot"
				end
				
				self:AddOutfitStatItemIfBetter(pOutfit, vSlotName, vItem, pStat, vScore)
			end
		end
	end
	
	-- Collapse the meta slots (currently just 2H vs. 1H/OH)
	
	self:CollapseMetaSlotsIfBetter(pOutfit, pStat)
end

function Outfitter:AddOutfitStatItemIfBetter(pOutfit, pSlotName, pItemInfo, pStat, pScore)
	local vCurrentItem = pOutfit:GetItem(pSlotName)
	local vAlternateSlotName = Outfitter.cHalfAlternateStatSlot[pSlotName]
	
	local vCurrentScore = vCurrentItem and pStat:GetItemScore(vCurrentItem)
	
	if self.Debug.Optimize then
		self:DebugMessage("AddOutfitStatItemIfBetter for %s: %s (%s) compared to %s (%s)", tostring(pSlotName), tostring(vCurrentItem and vCurrentItem.Name), tostring(vCurrentScore), tostring(pItemInfo.Name), tostring(pScore))
	end
	
	if not vCurrentScore
	or pScore > vCurrentScore then
		-- If we're bumping the current item, see if it should be moved to the alternate slot
		
		if vCurrentScore
		and vAlternateSlotName then
			Outfitter:AddOutfitStatItemIfBetter(pOutfit, vAlternateSlotName, vCurrentItem, pStat, vCurrentScore)
		end
		
		Outfitter:AddOutfitStatItem(pOutfit, pSlotName, pItemInfo, pStat, pScore)
	else
		if not vAlternateSlotName then
			return
		end
		
		return Outfitter:AddOutfitStatItemIfBetter(pOutfit, vAlternateSlotName, pItemInfo, pStat, pScore)
	end
end

function Outfitter:AddOutfitStatItem(pOutfit, pSlotName, pItemInfo, pStat, pScore)
	if not pSlotName then
		Outfitter:ErrorMessage("AddOutfitStatItem: SlotName is nil for %s", tostring(pItemName))
		return
	end
	
	if not pStat then
		Outfitter:ErrorMessage("AddOutfitStatItem: Stat is nil for %s", tostring(pItemName))
		return
	end
	
	pOutfit:AddItem(pSlotName, pItemInfo)
end

function Outfitter:CollapseMetaSlotsIfBetter(pOutfit, pStat)
	if self.Debug.Optimize then
		self:DebugMessage("CollapseMetaSlotsIfBetter: %s", tostring(pStat.ID))
		self:DebugOutfitTable(pOutfit)
	end
	
	-- Compare the weapon slot with the 1H/OH slots
	
	local vWeapon0Item = pOutfit:GetItem("Weapon0Slot")
	local vWeapon1Item = pOutfit:GetItem("Weapon1Slot")
	
	if vWeapon0Item or vWeapon1Item then
		-- Try the various combinations of MH/OH/W0/W1
		
		local v1HItem = pOutfit:GetItem("MainHandSlot")
		local vOHItem = pOutfit:GetItem("SecondaryHandSlot")
		
		local vCombinations
		
		if pStat.ID ~= "ITEM_LEVEL" then
			vCombinations =
			{
				{MainHand = v1HItem, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
				{MainHand = v1HItem, SecondaryHand = vWeapon0Item, AllowEmptyMainHand = false},
				{MainHand = v1HItem, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
				{MainHand = vWeapon0Item, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
				{MainHand = vWeapon1Item, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
				{MainHand = vWeapon0Item, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
			}
		else
			vCombinations =
			{
				{MainHand = v1HItem, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
				{MainHand = vWeapon0Item, SecondaryHand = vOHItem, AllowEmptyMainHand = false},
				{MainHand = vWeapon1Item, SecondaryHand = vOHItem, AllowEmptyMainHand = false},
			}
		end
		
		local vBestCombinationIndex = nil
		local vBestCombinationValue = nil
		
		for vIndex, vCombination in ipairs(vCombinations) do
			local vCombination = vCombinations[vIndex]
			
			-- Ignore combinations where the main hand is empty if
			-- that's not allowed with this combination
			
			if vCombination.AllowEmptyMainHand
			or vCombination.MainHand then
				local vCombinationValue = self:AddScores(vCombination.MainHand, vCombination.SecondaryHand, pStat)
				
				if not vBestCombinationIndex
				or vCombinationValue > vBestCombinationValue then
					vBestCombinationIndex = vIndex
					vBestCombinationValue = vCombinationValue
				end
			end
		end
		
		if vBestCombinationIndex then
			local vCombination = vCombinations[vBestCombinationIndex]
			
			pOutfit:SetItem("MainHandSlot", vCombination.MainHand)
			pOutfit:SetItem("SecondaryHandSlot", vCombination.SecondaryHand)
		end
		
		pOutfit:RemoveItem("Weapon0Slot")
		pOutfit:RemoveItem("Weapon1Slot")
	end
	
	-- Compare the 2H slot with the 1H/OH slots
	
	local v2HItem = pOutfit:GetItem("TwoHandSlot")
	
	if v2HItem then
		local v1HItem = pOutfit:GetItem("MainHandSlot")
		local vOHItem = pOutfit:GetItem("SecondaryHandSlot")
		local v1HOHScore = (v1HItem and pStat:GetItemScore(v1HItem) or 0) + (vOHItem and pStat:GetItemScore(vOHItem) or 0)
		
		local v2HScore = pStat:GetItemScore(v2HItem)
		
		if v2HScore
		and v2HScore > v1HOHScore then
			pOutfit:SetItem("MainHandSlot", v2HItem)
			pOutfit:RemoveItem("SecondaryHandSlot")
		end
		
		pOutfit:RemoveItem("TwoHandSlot")
	end
end

function Outfitter:AddScores(pItem1, pItem2, pStat)
	return (pItem1 and pStat:GetItemScore(pItem1) or 0)
	     + (pItem2 and pStat:GetItemScore(pItem2) or 0)
end

----------------------------------------
-- Combinatorial optimization (outfit-to-outfit comparisons)
----------------------------------------

function Outfitter:TestOutfitCombinations()
	local vInventoryCache = self:GetInventoryCache()
	local vFilterStats = {Outfitter:GetStatByID("INT")}
	local vOutfit = self:FindOutfitCombination("Test", vInventoryCache, vFilterStats, self.MultiStatEval, {})
end

function Outfitter:TestMultiStat()
	local vInventoryCache = self:GetInventoryCache()
	local vFilterStats = {Outfitter:GetStatByID("SPELL_HIT_RATING"), Outfitter:GetStatByID("SPELL_DMG")}
	local vOutfit = self:FindOutfitCombination("Test", vInventoryCache, vFilterStats, self.MultiStatEval,
	{
		{Stat = Outfitter:GetStatByID("SPELL_HIT_RATING"), MinValue = 368},
		{Stat = Outfitter:GetStatByID("SPELL_DMG")},
	})
end

function Outfitter:MultiStatCompare(pPreviousOutfit, pNewOutfit, pParams)
	-- Return true if NewOutfit is better than PreviousOutfit
	-- PreviousOutfit has already been seen, so it will have the scores already calculated
	
	-- Calculate the scores for the new outfit
	-- and quickly discard outfits that don't meet minimums
	
	pNewOutfit.CombiScores = {}
	
	for vIndex, vStatInfo in ipairs(pParams) do
		local vNewScore = Outfitter:CalcOutfitScore(pNewOutfit, vStatInfo.Stat)
		
		-- If the stat specified a minimum, ensure the outfit
		-- meets the requirement
		
		if vStatInfo.MinValue
		and (not vNewScore or vNewScore < vStatInfo.MinValue) then
			return false
		end
		
		pNewOutfit.CombiScores[vIndex] = vStatScore
	end
	
	if not pPreviousOutfit then
		return true -- Something is better than nothing
	end
	
	-- Compare the scores
	
	for vIndex, vStatInfo in ipairs(pParams) do
		if not vStatInfo.MinValue then
			local vOldScore = pPreviousOutfit.CombiScores[vIndex]
			local vNewScore = pNewOutfit.CombiScores[vIndex]
			
			if vOldScore
			and (not vNewScore or vNewScore <= vOldScore) then
				return false
			end
			
			if vNewScore then
				return true
			end
		end
	end
end

function Outfitter.MultiStatEval(pOpcode, pParams, pPreviousOutfit, pNewOutfit)
	if pOpcode == "COMPARE" then
		-- Return true if NewOutfit is better than PreviousOutfit
		-- PreviousOutfit has already been seen, so it will have the scores already calculated
		
		-- Calculate the scores for the new outfit
		-- and quickly discard outfits that don't meet minimums
		
		pNewOutfit.CombiScores = {}
		
		for vIndex, vStatInfo in ipairs(pParams) do
			local vNewScore = Outfitter:CalcOutfitScore(pNewOutfit, vStatInfo.Stat)
			
			-- If the stat specified a minimum, ensure the outfit
			-- meets the requirement
			
			if vStatInfo.MinValue
			and (not vNewScore or vNewScore < vStatInfo.MinValue) then
				return false
			end
			
			pNewOutfit.CombiScores[vIndex] = vStatScore
		end
		
		-- Compare the scores
		
		for vIndex, vStatInfo in ipairs(pParams) do
			if not vStatInfo.MinValue then
				local vOldScore = pPreviousOutfit.CombiScores[vIndex]
				local vNewScore = pNewOutfit.CombiScores[vIndex]
				
				if vOldScore
				and (not vNewScore or vNewScore <= vOldScore) then
					return false
				end
				
				if vNewScore then
					return true
				end
			end
		end
	end
end

function Outfitter:BeginCombiProgress(pName, pNumCombos, pCancelFunc, pHighSpeedFunc)
	if not self.CombiProgressDialog then
		self.CombiProgressDialog = Outfitter:New(self._CombiProgressDialog)
	end
	
	self.NumCombos = pNumCombos
	
	self.CombiProgressDialog:SetTitle(pName)
	self.CombiProgressDialog:SetCancelFunc(pCancelFunc)
	self.CombiProgressDialog:SetHighSpeedFunc(pHighSpeedFunc)
	self.CombiProgressDialog:SetHighSpeed(false)
	
	self.CombiProgressDialog:Show()
end

function Outfitter:FormatThousands(pNumber)
	local vResult = tostring(math.floor(pNumber + 0.5)):reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return vResult:sub(1, 1) == "," and vResult:sub(2) or vResult
end

function Outfitter:UpdateCombiProgress(pComboIndex)
	self.CombiProgressDialog:SetProgress(pComboIndex / self.NumCombos)
	self.CombiProgressDialog:SetProgressText(format("%s of %s", self:FormatThousands(pComboIndex), self:FormatThousands(self.NumCombos)))
end

function Outfitter:EndCombiProgress()
	Outfitter.CombiProgressDialog:Hide()
end

function Outfitter:FindOutfitCombination(pName, pInventoryCache, pFilterStats, pStat, pStatParams, pCompletionFunc)
	assert(pCompletionFunc)
	
	self.FindOutfitCombinationCoroutineRef = coroutine.create(self.FindOutfitCombinationThread)
	
	local vResult, vMessage = coroutine.resume(self.FindOutfitCombinationCoroutineRef, self, pName, pInventoryCache, pFilterStats, pStat, pStatParams, pCompletionFunc)
	
	if not vResult then
		self:ErrorMessage(vMessage)
	end
	
	self.SchedulerLib:ScheduleRepeatingTask(0, self.RunComboThread, self)
end

function Outfitter:RunComboThread()
	local vResult, vMessage = coroutine.resume(self.FindOutfitCombinationCoroutineRef, self)
	
	if not vResult then
		self:ErrorMessage(vMessage)
	end
	
	if not vResult
	or not self.FindOutfitCombinationCoroutineRef then
		self.FindOutfitCombinationCoroutineRef = nil
		self.SchedulerLib:UnscheduleTask(self.RunComboThread, self)
	end
end

function Outfitter:FindOutfitCombinationThread(pName, pInventoryCache, pFilterStats, pStat, pStatParams, pCompletionFunc)
	assert(pCompletionFunc)
	
	pInventoryCache:ResetIgnoreItemFlags()
	
	local vOutfitIterator = Outfitter:New(self._OutfitIterator, pName, pInventoryCache, pFilterStats)
	
	local vBestOutfit = nil
	local vNumIterations = 0
	local vCancel
	
	local vMaxYieldTime = 0.02
	
	self:BeginCombiProgress(
		string.format("Optimizing %s for %s", pName, pStat.Name),
		vOutfitIterator.NumCombinations,
		function ()
			vCancel = true
		end,
		function (pSet)
			if pSet then
				vMaxYieldTime = 0.1
			else
				vMaxYieldTime = 0.02
			end
		end)
	
	-- HACK: Modify LibStatLogic to cache values for vastly better performance
	
	local vOrig_GetStatMod = Outfitter.LibStatLogic.GetStatMod
	local vGetStatModCache = {}
	
	Outfitter.LibStatLogic.GetStatMod = function (pLibrary, pStatID, ...)
		local vCacheEntry = vGetStatModCache[pStatID]
		local vNumParams = select("#", ...)
		
		if vCacheEntry
		and vNumParams == #vCacheEntry.Params then
			local vIgnoreCache
			
			for vParamIndex = 1, vNumParams do
				if vCacheEntry.Params[vParamIndex] ~= select(vParamIndex, ...) then
					vIgnoreCache = true
					break
				end
			end
			
			if not vIgnoreCache then
				return vCacheEntry.Result
			end
		end
		
		if not vCacheEntry then
			vCacheEntry = {}
			vGetStatModCache[pStatID] = vCacheEntry
		end
		
		vCacheEntry.Result = vOrig_GetStatMod(pLibrary, pStatID, ...)
		vCacheEntry.Params = {...}
		
		return vCacheEntry.Result
	end
	
	--
	
	local vStartTime = GetTime()
	
	if pStat.Begin then
		pStat:Begin(pInventoryCache)
	end
	
	local vYieldTime = GetTime() + vMaxYieldTime
	local vBestMessage
	
	for vOutfitIndex, vOutfit in vOutfitIterator:Outfits() do
		local vBetter, vMessage = pStat:CompareOutfits(vBestOutfit, vOutfit, pStatParams)
		
		if vBetter then
			self.CombiProgressDialog:SetDescription(vMessage or "")
			
			vBestMessage = vMessage
			vBestOutfit = vOutfit
		end
		
		vNumIterations = vNumIterations + 1
		
		self:UpdateCombiProgress(vNumIterations)
		
		if vCancel then
			break
		end
		
		if GetTime() >= vYieldTime then
			coroutine.yield()
			vYieldTime = GetTime() + vMaxYieldTime
		end
	end
	
	if pStat.End then
		pStat:End(pInventoryCache)
	end
	
	local vEndTime = GetTime()
	
	-- HACK: Unhook the patch from LSL

	Outfitter.LibStatLogic.GetStatMod = vOrig_GetStatMod
	
	--
	
	self:EndCombiProgress()
	
	self.FindOutfitCombinationCoroutineRef = nil
	
	if not vCancel then
		Outfitter:NoteMessage(
			"Checked %s outfits in %s seconds (%s outfits per second)",
			Outfitter:FormatThousands(vNumIterations),
			math.floor(vEndTime - vStartTime),
			Outfitter:FormatThousands(vNumIterations / (vEndTime - vStartTime)))
		
		if vBestMessage then
			Outfitter:NoteMessage("Best outfit: %s", vBestMessage)
		end
		
		pCompletionFunc(vBestOutfit)
	end
end

function Outfitter:ItemContainsStats(pItem, pFilterStats)
	for vStatID, _ in pairs(pFilterStats) do
		if pItem.Stats[vStatID] then
			return true
		end
	end
	
	return false
end

----------------------------------------
Outfitter._CombiProgressDialog = {}
----------------------------------------

function Outfitter._CombiProgressDialog:New()
	return Outfitter:New(Outfitter.UIElementsLib._FloatingWindow)
end

function Outfitter._CombiProgressDialog:Construct()
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	self:SetWidth(300)
	self:SetHeight(60)
	
	local vMargin = 8
	
	self.CancelButton = Outfitter:New(Outfitter.UIElementsLib._PushButton, self.ContentFrame, CANCEL, 80)
	self.CancelButton:SetPoint("TOPRIGHT", self.ContentFrame, "TOPRIGHT", -vMargin, -vMargin)
	self.CancelButton:SetScript("OnClick", function ()
		self.CancelFunc()
	end)
	
	self.ProgressBar = Outfitter:New(Outfitter.UIElementsLib._ProgressBar, self.ContentFrame)
	self.ProgressBar:SetPoint("TOPLEFT", self.ContentFrame, "TOPLEFT", vMargin, -vMargin)
	self.ProgressBar:SetPoint("RIGHT", self.CancelButton, "LEFT", -4, 0)
	
	self.HighSpeed = Outfitter:New(Outfitter.UIElementsLib._CheckButton, self.ContentFrame, "High speed")
	self.HighSpeed:SetPoint("TOPLEFT", self.ProgressBar, "BOTTOMLEFT", 0, -4)
	self.HighSpeed:SetScript("OnClick", function (pButton)
		self.HighSpeedFunc(pButton:GetChecked())
	end)
	
	self.Description = self.ContentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.Description:SetJustifyH("RIGHT")
	self.Description:SetJustifyV("TOP")
	self.Description:SetPoint("LEFT", self.HighSpeed.Title, "RIGHT", 4, 0)
	self.Description:SetPoint("RIGHT", self.ContentFrame, "RIGHT", -vMargin, 0)
	
	self.TitleBar:SetCloseFunc(function () self.CancelFunc() end)
end

function Outfitter._CombiProgressDialog:SetDescription(pDescription)
	self.Description:SetText(pDescription)
end

function Outfitter._CombiProgressDialog:SetCancelFunc(pCancelFunc)
	self.CancelFunc = pCancelFunc
end

function Outfitter._CombiProgressDialog:SetHighSpeed(pHighSpeed)
	self.HighSpeed:SetChecked(pHighSpeed)
end

function Outfitter._CombiProgressDialog:SetHighSpeedFunc(pHighSpeedFunc)
	self.HighSpeedFunc = pHighSpeedFunc
end

function Outfitter._CombiProgressDialog:SetProgress(pProgress)
	self.ProgressBar:SetProgress(pProgress)
end

function Outfitter._CombiProgressDialog:SetProgressText(pText)
	self.ProgressBar:SetText(pText)
end

----------------------------------------
Outfitter._OutfitIterator = {}
----------------------------------------

function Outfitter._OutfitIterator:Construct(pName, pInventoryCache, pFilterStats)
	self.Name = pName
	
	self.Slots = {}
	self.NumCombinations = 1
	
	for vInventorySlot, vItems in pairs(pInventoryCache.ItemsBySlot) do
		local vNumSlotItems = 0
		local vNumItems = #vItems
		
		if vInventorySlot ~= "AmmoSlot"
		and vNumItems > 0 then
			-- Filter the items by stat
			
			local vFilteredItems = nil
			
			if pFilterStats then
				vNumItems = 0
				
				for vItemIndex, vItem in ipairs(vItems) do
					for _, vStat in ipairs(pFilterStats) do
						if vStat:GetItemScore(vItem) then
							if not vFilteredItems then
								vFilteredItems = {}
							end
							
							table.insert(vFilteredItems, vItem)
							vNumItems = vNumItems + 1
							vNumSlotItems = vNumSlotItems + 1
							
							break
						end
					end
				end
			else
				vFilteredItems = vItems
			end
			
			-- Add the filtered list
			
			if vFilteredItems then
				table.insert(self.Slots, {ItemSlotName = vInventorySlot, Items = vFilteredItems, Index = 1, MaxIndex = vNumItems})
				
				self.NumCombinations = self.NumCombinations * vNumItems
				
				-- Duplicate the list for slots with alternates (finger, weapon, trinket)
				
				local vAltInventorySlot = Outfitter.cHalfAlternateStatSlot[vInventorySlot]
				
				if vAltInventorySlot then
					table.insert(self.Slots, {ItemSlotName = vAltInventorySlot, Items = vFilteredItems, Index = 1, MaxIndex = vNumItems})
					
					self.NumCombinations = self.NumCombinations * vNumItems
				end
			end
			
			Outfitter:DebugMessage("%s has %s items", vInventorySlot, vNumSlotItems)
		end
	end
end

function Outfitter._OutfitIterator:Outfits()
	-- Reset the slots
	
	for vSlotIndex, vSlotIterator in ipairs(self.Slots) do
		vSlotIterator.Index = 1
	end
	
	return self.Next, self, 0, nil
end

function Outfitter._OutfitIterator:Next(pPreviousIndex)
	if not self.Slots[1] then
		return nil
	end
	
	if pPreviousIndex == 0 then
		return 1, self:GetOutfit()
	end
	
	for vSlotIndex, vSlotIterator in ipairs(self.Slots) do
		vSlotIterator.Index = vSlotIterator.Index + 1
		
		if vSlotIterator.Index <= vSlotIterator.MaxIndex then
			return pPreviousIndex + 1, self:GetOutfit()
		end
		
		vSlotIterator.Index = 1
	end
	
	return nil -- Couldn't increment
end

function Outfitter._OutfitIterator:GetOutfit()
	local vOutfit = Outfitter:NewEmptyOutfit(self.Name)

	for _, vItems in ipairs(self.Slots) do
		if vItems.Index > 0 then
			local vItem = vItems.Items[vItems.Index]
			local vAltSlotName = Outfitter.cFullAlternateStatSlot[vItems.ItemSlotName]
			
			-- Only include the item if it isn't already being tried in an alternate slot (ie, trinket0 vs. trinket1)
			
			if not vAltSlotName
			or vOutfit.Items[vAltSlotName] ~= vItem then
				vOutfit.Items[vItems.ItemSlotName] = vItem
			end
		end
	end
	
	if vOutfit.Items.MainHandSlot
	and vOutfit.Items.MainHandSlot.InvType == "INVTYPE_2HWEAPON"
	and not Outfitter.CanDualWield2H then
		vOutfit.Items.SecondaryHandSlot = nil
	end
	
	return vOutfit
end

local gOutfitter_CompareStat

function Outfitter._OutfitIterator:SortItemsByStat(pStat)
	gOutfitter_CompareStat = pStat
	
	for _, vSlotInfo in ipairs(self.Slots) do
		table.sort(vSlotInfo.Items,
			function (pItem1, pItem2)
				local vStat1, vStat2 = pItem1[gOutfitter_CompareStat], pItem2[gOutfitter_CompareStat]
				
				if vStat1 == nil then
					return vStat2 ~= nil
				elseif not vStat2 then
					return false
				else
					return vStat1 < vStat2
				end
			end
		)
	end
end

function Outfitter._OutfitIterator:CalcMinNumSlotsByStat(pStat, pMinValue)
	local vStatValues = {}

	for _, vSlotInfo in ipairs(self.Slots) do
		local vNumItems = #vSlotInfo.Items
		
		if vNumItems > 0 then
			local vValue = vSlotInfo.Items[1].Stats[pStat]
			
			if vValue then
				table.insert(vStatValues, vValue)
			end

			if vNumItems > 1
			and (vSlotInfo.ItemSlotName == "Trinket0Slot"
			or vSlotInfo.ItemSlotName == "Finger0Slot"
			or vSlotInfo.ItemSlotName == "WeaponSlot") then
				local vValue = vSlotInfo.Items[2].Stats[pStat]
				
				if vValue then
					table.insert(vStatValues, vValue)
				end
			end
		end
	end
	
	table.sort(vStatValues, function (pValue1, pValue2) return pValue1 > pValue2 end)
	
	local vTotal = 0
	
	for vIndex, vValue in ipairs(vStatValues) do
		vTotal = vTotal + vValue
		
		if vTotal >= pMinValue then
			return vIndex
		end
	end
	
	return #vStatValues
end
