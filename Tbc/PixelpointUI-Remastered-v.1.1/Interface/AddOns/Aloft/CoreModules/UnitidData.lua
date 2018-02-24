-----------------------------------------------------------------------------

local roster = AceLibrary("Roster-2.1")
local AloftUnitidData = Aloft:NewModule("UnitidData", "AceEvent-2.0")

-----------------------------------------------------------------------------

local lastGrouped = false

-----------------------------------------------------------------------------

Aloft.TagData.UnitID =
{
	data = "unitid",
	events = "Aloft:OnUnitidDataChanged",
	tableData = "unitid"
}

-----------------------------------------------------------------------------

local function IsGrouped()
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end
Aloft.DataAvailableMethods.unitid = IsGrouped

function AloftUnitidData:ProvidesData()
	return "unitid"
end

-----------------------------------------------------------------------------

function AloftUnitidData:OnEnable()
	self:RegisterEvent("RosterLib_RosterUpdated", "RosterUpdated")
	lastGrouped = IsGrouped()
end

function AloftUnitidData:OnDisable()
	self:UnregisterAllEvents()
end

-- This data source overrides DisableDataSource because we still want RosterUpdated events to be caught even if this data source isn't used at the moment
function AloftUnitidData:DisableDataSource()
	self:RemoveAloftData("unitid")
end

function AloftUnitidData:RosterUpdated()
	local grouped = IsGrouped()
	if grouped ~= lastGrouped then
		lastGrouped = grouped
	
		-- DetermineDataSources updates all data. We want to trigger events if data has changed
		-- so we iterate the frames before calling DetermineDataSources
		--
		-- Some modules determine which events to listen to depending on the availability of unitid
		-- So if we are now grouped, determine which have changed, then call DetermineDataSources, then trigger the events
		-- Otherwise we trigger the events before calling DetermineDataSources

		local updateList = nil

		for aloftData in Aloft:IterateVisibleNameplates() do
			local unitid = roster:GetUnitIDFromName(aloftData.name)
			if aloftData.unitid ~= unitid then
				if grouped then
					updateList = updateList or { }
					table.insert(updateList, aloftData)
				else
					aloftData.unitid = unitid
					self:TriggerEvent("Aloft:OnUnitidDataChanged", aloftData)
				end
			end
		end

		Aloft:DetermineDataSources()

		if updateList then
			for _,aloftData in pairs(updateList) do
				self:TriggerEvent("Aloft:OnUnitidDataChanged", aloftData)
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftUnitidData:UpdateData(aloftData)
	if aloftData.type == "friendlyPlayer" or aloftData.type == "friendlyNPC" then
		aloftData.unitid = roster:GetUnitIDFromName(aloftData.name)
	else
		aloftData.unitid = nil
	end
end

-----------------------------------------------------------------------------
