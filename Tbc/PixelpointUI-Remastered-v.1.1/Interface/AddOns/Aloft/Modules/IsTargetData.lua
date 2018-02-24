-----------------------------------------------------------------------------

local AloftIsTargetData = Aloft:NewModule("IsTargetData", "AceEvent-2.0", "AceHook-2.1")

-----------------------------------------------------------------------------

Aloft.TagData.IsTarget =
{
	data = "isTarget",
	events = "Aloft:OnIsTargetDataChanged",
	tableData = "isTarget"
}

-----------------------------------------------------------------------------

function AloftIsTargetData:ProvidesData()
	return "isTarget"
end

function AloftIsTargetData:EnableDataSource()
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
	
	self:UnhookAll()
	self:Hook("ShowNameplates", "ShowNameplates", true)
	self:Hook("ShowFriendNameplates", "ShowFriendNameplates", true)
end

-----------------------------------------------------------------------------

local lastTarget = nil

function AloftIsTargetData:UpdateData(aloftData)
	aloftData.isTarget = aloftData:IsTarget()
	if aloftData.isTarget then
		if lastTarget and lastTarget ~= aloftData then
			lastTarget.isTarget = nil
			self:TriggerEvent("Aloft:OnIsTargetDataChanged", lastTarget)
		end
		lastTarget = aloftData
	end
end

function AloftIsTargetData:OnPlayerTargetChanged()
	if lastTarget then
		lastTarget.isTarget = nil
		self:TriggerEvent("Aloft:OnIsTargetDataChanged", lastTarget)
		lastTarget = nil
	end
	-- At this stage, the nameplates still haven't updated their alpha, so we have to do it on next frame
	self:ScheduleEvent("AloftIsTargetDataUpdate", self.Update, 0, self)
end

function AloftIsTargetData:Update()
	lastTarget = Aloft:GetTargetNameplate()
	if lastTarget then
		lastTarget.isTarget = true
		self:TriggerEvent("Aloft:OnIsTargetDataChanged", lastTarget)
	end
end

function AloftIsTargetData:OnNameplateHide(aloftData)
	if lastTarget == aloftData then
		lastTarget = nil
	end
end

-----------------------------------------------------------------------------

function AloftIsTargetData:ShowNameplates()
	self:ScheduleEvent("AloftIsTargetDataNameplatesShown", self.OnPlayerTargetChanged, 0, self)
	self.hooks["ShowNameplates"]()
end

function AloftIsTargetData:ShowFriendNameplates()
	self:ScheduleEvent("AloftIsTargetDataNameplatesShown", self.OnPlayerTargetChanged, 0, self)
	self.hooks["ShowFriendNameplates"]()
end

-----------------------------------------------------------------------------
