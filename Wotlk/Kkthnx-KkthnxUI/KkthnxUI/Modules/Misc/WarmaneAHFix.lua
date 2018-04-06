local K, C, L, _ = select(2, ...):unpack()
if IsAddOnLoaded("Warmane_AH-fix") then return end

local pairs = pairs
local IsAddOnLoaded = IsAddOnLoaded
local CreateFrame = CreateFrame

-- Fixes auction house addon functionality on Warmane wotlk realms (Anyone@Icecrown)
if K.Realm == "Icecrown" or K.Realm == "Lordaeron" then

	local frame = CreateFrame("frame")
	local origStartAuction = StartAuction
	StartAuction = function(minBid, buyoutPrice, runTime, stackSize, numStacks)
		numStacks = numStacks or 1
		stackSize = stackSize or AuctionsStackSizeEntry:GetText()
		return origStartAuction(minBid, buyoutPrice, runTime, stackSize, numStacks)
	end

	local AllianceMails = {
		"Stormwind Auction House",
		"Ironforge Auction House",
		"Darnassus Auction House",
		"Exodar Auction House"
	}

	local HordeMails = {
		"Undercity Auction House",
		"Thunder Bluff Auction House",
		"Thunder Bluff Auction House", -- Currently with 2 spaces, listing with 1 space also in case it gets changed.
		"Orgrimmar Auction House",
		"Silvermoon Auction House"
	}

	local origGetInboxHeaderInfo = GetInboxHeaderInfo
	GetInboxHeaderInfo = function(index)
		packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = origGetInboxHeaderInfo(index)

		for _,v in pairs(AllianceMails) do
			if v == sender then
				sender = "Alliance Auction House"
				break
			end
		end

		for _,v in pairs(HordeMails) do
			if v == sender then
				sender = "Horde Auction House"
				break
			end
		end

		return packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM
	end
end