-----------------------------------------------------------------------------

local AloftRecentlyDamagedData = Aloft:NewModule("RecentlyDamagedData", "AceEvent-2.0")

-----------------------------------------------------------------------------

Aloft.TagData.WasRecentlyDamaged =
{
	data = "recentlyDamaged",
	events = "Aloft:OnRecentlyDamagedChanged",
	tableData = "recentlyDamaged"
}

-----------------------------------------------------------------------------

function AloftRecentlyDamagedData:ProvidesData()
	return "recentlyDamaged"
end

function AloftRecentlyDamagedData:EnableDataSource()
	-- RecentlyDamaged is determined if the name text color is red.
	-- Since there are no event or scripts triggered when this changes, we have to scan for it
	self:ScheduleRepeatingEvent("AloftRecentlyDamagedUpdate", self.Update, 0.2, self)
end

-----------------------------------------------------------------------------

local function WasRecentlyDamaged(aloftData, nameTextRegion)
	local r, g, b = nameTextRegion:GetTextColor()
	aloftData.nameTextR, aloftData.nameTextG, aloftData.nameTextB = r, g, b

	r, g, b = floor(r * 256), floor(g*256), floor(b*256)
	if r == 255 and g == 0 and b == 0 then
		return true
	else
		return false
	end
end


function AloftRecentlyDamagedData:UpdateData(aloftData)
	aloftData.recentlyDamaged = WasRecentlyDamaged(aloftData, aloftData.nameTextRegion)
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedData:Update()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local nameTextRegion = aloftData.nameTextRegion

		local r, g, b = nameTextRegion:GetTextColor()
		if r ~= aloftData.nameTextR or g ~= aloftData.nameTextG or b ~= aloftData.nameTextB then
			local recentlyDamaged = WasRecentlyDamaged(aloftData, nameTextRegion)
			
			if recentlyDamaged ~= aloftData.recentlyDamaged then
				aloftData.recentlyDamaged = recentlyDamaged
				self:TriggerEvent("Aloft:OnRecentlyDamagedChanged", aloftData)
			end
		end
	end
end

-----------------------------------------------------------------------------
