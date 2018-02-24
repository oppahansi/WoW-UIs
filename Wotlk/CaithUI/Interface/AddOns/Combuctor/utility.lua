--[[
	CombuctorUtil
		A library of functions for accessing bag data
--]]

CombuctorUtil = CreateFrame('Frame')
CombuctorUtil:SetScript('OnEvent', function(self, event)
	self.atBank = (event == 'BANKFRAME_OPENED')
end)
CombuctorUtil:RegisterEvent('BANKFRAME_OPENED')
CombuctorUtil:RegisterEvent('BANKFRAME_CLOSED')

local currentPlayer = UnitName('player')
local typeContainer = select(3, GetAuctionItemClasses())
local typeQuiver = select(7, GetAuctionItemClasses())
local subTypeBag = GetAuctionItemSubClasses(3)
local subTypeSoulBag = select(2, GetAuctionItemSubClasses(3))


--[[ Bank ]]--

function CombuctorUtil:AtBank()
	return self.atBank
end


--[[ Item/Bag Info Wrapper Functions ]]--

function CombuctorUtil:GetInvSlot(bag)
	return bag > 0 and ContainerIDToInventoryID(bag)
end

function CombuctorUtil:GetBagSize(bag, player)
	if self:IsCachedBag(bag, player) then
		return (BagnonDB and BagnonDB:GetBagData(bag, player)) or 0
	end
	return (bag == KEYRING_CONTAINER and GetKeyRingSize()) or GetContainerNumSlots(bag)
end

function CombuctorUtil:GetBagLink(bag, player)
	if self:IsCachedBag(bag, player) then
		return BagnonDB and (select(2, BagnonDB:GetBagData(bag, player)))
	end
	return GetInventoryItemLink('player', self:GetInvSlot(bag))
end

function CombuctorUtil:GetItemLink(bag, slot, player)
	if self:IsCachedBag(bag, player) then
		return BagnonDB and (BagnonDB:GetItemData(bag, slot, player))
	end
	return GetContainerItemLink(bag, slot)
end

function CombuctorUtil:GetItemCount(bag, slot, player)
	if self:IsCachedBag(bag, player) then
		if BagnonDB then
			local link, count = BagnonDB:GetItemData(bag, slot, player)
			if link then
				return count or 1
			end
		else
			return 0
		end
	end
	return select(2, GetContainerItemInfo(bag, slot))
end


--[[ Bag Type Comparisons ]]--

--returns true if the given bag is cached AND we have a way of reading data for it
function CombuctorUtil:IsCachedBag(bag, player)
	return currentPlayer ~= (player or currentPlayer) or (self:IsBankBag(bag) and not self:AtBank())
end

function CombuctorUtil:IsInventoryBag(bag)
	return bag == KEYRING_CONTAINER or (bag > -1 and bag < 5)
end

function CombuctorUtil:IsBankBag(bag)
	return (bag == BANK_CONTAINER or bag > 4)
end

--returns true if the given bag is a normal bag
function CombuctorUtil:IsNormalBag(bag, player)
	if bag == BANK_CONTAINER or bag == BACKPACK_CONTAINER then
		return true
	end

	if bag > 0 then
		local link = self:GetBagLink(bag, player)
		if link then
			return select(7, GetItemInfo(link)) == subTypeBag
		end
	end
end

--returns true if the given bag is an ammo bag/soul bag
function CombuctorUtil:IsAmmoBag(bag, player)
	--bankslots, the main bag, and the keyring cannot be ammo slots
	if bag > 0 then
		local link = self:GetBagLink(bag, player)
		if link then
			return select(6, GetItemInfo(link)) == typeQuiver
		end
	end
end

--returns true if the given bag is a soul bag
function CombuctorUtil:IsShardBag(bag, player)
	--bankslots, the main bag, and the keyring cannot be shard slots
	if bag > 0 then
		local link = self:GetBagLink(bag, player)
		if link then
			return select(7, GetItemInfo(link)) == subTypeSoulBag
		end
	end
end

--returns true if the given bag is a profession bag (herb bag, engineering bag, etc)
function CombuctorUtil:IsProfessionBag(bag, player)
	--bankslots, the main bag, and the keyring cannot be profession bag slots
	if bag > 0 then
		local link = self:GetBagLink(bag, player)
		if link then
			local type, subType = select(6, GetItemInfo(link))
			return type == typeContainer and not(subType == subTypeBag or subType == subTypeSoulBag)
		end
	end
end


--[[ Non bag related stuff ]]--

--creates a new class of objects that inherits from objects of <type>, ex 'Frame', 'Button', 'StatusBar'
--does not chain inheritance
function CombuctorUtil:CreateWidgetClass(type)
	local class = CreateFrame(type)
	local mt = {__index = class}

	function class:New(o)
		if o then
			local type, cType = o:GetFrameType(), self:GetFrameType()
			assert(type == cType, format("'%s' expected, got '%s'", cType, type))
		end
		return setmetatable(o or CreateFrame(type), mt)
	end

	return class
end