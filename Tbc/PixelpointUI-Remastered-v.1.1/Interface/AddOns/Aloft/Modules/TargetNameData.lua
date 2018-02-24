-----------------------------------------------------------------------------

local AloftTargetNameData = Aloft:NewModule("TargetNameData", "AceEvent-2.0", "AceHook-2.1")

-----------------------------------------------------------------------------

Aloft.TagData.TargetName =
{
	data = "targetName",
	events = "Aloft:OnTargetNameDataChanged",
	overrideEvents = "Aloft:OnIsTargetDataChanged",
	tableData = "targetName",
}

-----------------------------------------------------------------------------

function AloftTargetNameData:ProvidesData()
	return "targetName"
end

function AloftTargetNameData:RequiresData()
	if Aloft:IsDataAvailable("unitid") then
		return "unitid", "isTarget"
	else
		return "isTarget"
	end
end

function AloftTargetNameData:EnableDataSource()
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
end

-----------------------------------------------------------------------------

local isUpdating = false
local updateList = { }

function AloftTargetNameData:StartUpdates()
	if not isUpdating then
		self:ScheduleRepeatingEvent("AloftTargetNameData:Update", self.Update, 0.2, self)
		isUpdating = true
	end
end

function AloftTargetNameData:StopUpdates()
	if isUpdating and not next(updateList) then
		self:CancelScheduledEvent("AloftTargetNameData:Update")
		isUpdating = false
	end
end

function AloftTargetNameData:UpdateData(aloftData)
	if aloftData.unitid then
		local unitid = aloftData.unitid.."target"
		aloftData.targetName = UnitName(unitid)
		updateList[aloftData] = true
		self:StartUpdates()
	elseif aloftData.isTarget then
		aloftData.targetName = UnitName("targettarget")
		updateList[aloftData] = true
		self:StartUpdates()
	else
		aloftData.targetName = nil
		updateList[aloftData] = nil
		self:StopUpdates()
	end
end

function AloftTargetNameData:OnNameplateHide(aloftData)
	updateList[aloftData] = nil
	self:StopUpdates()
end

function AloftTargetNameData:OnIsTargetDataChanged(aloftData)
	if aloftData.isTarget then
		aloftData.targetName = UnitName("targettarget")
		updateList[aloftData] = true
		self:StartUpdates()
	else
		aloftData.targetName = nil
		updateList[aloftData] = nil
		self:StopUpdates()
	end
	self:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
end

function AloftTargetNameData:OnUnitidDataChanged(aloftData)
	if aloftData.unitid then
		local unitid = aloftData.unitid.."target"
		aloftData.targetName = UnitName(unitid)
		updateList[aloftData] = true
		self:StartUpdates()
	else
		aloftData.targetName = nil
		updateList[aloftData] = nil
		self:StopUpdates()
	end
	self:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
end

function AloftTargetNameData:Update()
	for aloftData in pairs(updateList) do
		local targetName
		if aloftData.unitid then
			local unitid = aloftData.unitid.."target"
			targetName = UnitName(unitid)
		elseif aloftData.isTarget then
			targetName = UnitName("targettarget")
		end
		if targetName ~= aloftData.targetName then
			aloftData.targetName = targetName
			self:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------
