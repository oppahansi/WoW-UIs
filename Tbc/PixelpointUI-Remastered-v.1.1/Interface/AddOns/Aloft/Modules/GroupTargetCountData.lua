-----------------------------------------------------------------------------

local AloftGroupTargetCountData = Aloft:NewModule("GroupTargetCountData", "AceEvent-2.0")

-----------------------------------------------------------------------------

Aloft.TagData.GroupTargetCount =
{
	data = "groupTargetCount",
	events = "Aloft:OnGroupTargetCountChanged",
	tableData = "groupTargetCount",
	numeric = true
}

-----------------------------------------------------------------------------

local groupTargetCount = setmetatable({ }, { __index = function() return 0 end })

-----------------------------------------------------------------------------

local function IsGrouped()
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end
Aloft.DataAvailableMethods.groupTargetCount = IsGrouped

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:ProvidesData()
	return "groupTargetCount"
end

function AloftGroupTargetCountData:EnableDataSource()
	self:ScheduleRepeatingEvent("AloftGroupTargetCountUpdate", self.Update, 0.25, self)
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:UpdateData(aloftData)
	aloftData.groupTargetCount = groupTargetCount[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:Update()
	for k in pairs(groupTargetCount) do
		groupTargetCount[k] = nil
	end

	local raidMembers = GetNumRaidMembers()
	if raidMembers > 0 then
		for i=1,raidMembers-1 do		-- Exclude the player, who is the top raid#
			local name = UnitName("raid"..i.."target")
			if name then
				groupTargetCount[name] = groupTargetCount[name] + 1
			end
		end
	else
		local partyMembers = GetNumPartyMembers()
		if partyMembers > 0 then
			for i=1,partyMembers do
				local name = UnitName("party"..i.."target")
				if name then
					groupTargetCount[name] = groupTargetCount[name] + 1
				end
			end
		end
	end
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		local count = groupTargetCount[aloftData.name]
		if count ~= aloftData.groupTargetCount then
			aloftData.groupTargetCount = count
			self:TriggerEvent("Aloft:OnGroupTargetCountChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------
