-----------------------------------------------------------------------------

if not AceLibrary:HasInstance("Threat-1.0") then return end

local AloftThreatData = Aloft:NewModule("ThreatData", "AceEvent-2.0")
local Threat 

-----------------------------------------------------------------------------

Aloft.TagData.Threat =
{
	data = "threat",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threat",
	numeric = true
}

-- This is actually defined as the maximum threat that isn't the player
Aloft.TagData.ThreatMax =
{
	data = "threat",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatMax",
	numeric = true
}

Aloft.TagData.ThreatMaxName =
{
	data = "threat",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatMaxName",
	numeric = true
}

Aloft.TagData.ThreatPercent =
{
	events = "Aloft:OnThreatDataChanged",
	method = function(aloftData, value) 
				if value and aloftData.threat and aloftData.threatMax then
					if aloftData.threatMax == 0 then
						return 100
					else
						return aloftData.threat * 100 / aloftData.threatMax
					end
				end
			 end,
	numeric = true
}

-----------------------------------------------------------------------------

function AloftThreatData:ProvidesData()
	return "threat"
end

function AloftThreatData:EnableDataSource()
	Threat = AceLibrary("Threat-1.0")
	self:RegisterEvent("Threat_ThreatUpdated", "OnThreatUpdated")
	self:RegisterEvent("Threat_ThreatCleared", "OnThreatCleared")
end

-----------------------------------------------------------------------------

local playerName = UnitName("player")
function AloftThreatData:UpdateData(aloftData)
	if aloftData.type == "hostile" or aloftData.type == "neutral" then
		aloftData.threat = Threat:GetThreat(playerName, aloftData.name)
		aloftData.threatMax = nil
		
		for	name, threat in Threat:IterateGroupThreatForTarget(aloftData.name) do
			if name ~= playerName then
				aloftData.threatMax = threat
				aloftData.threatMaxName = name
				break
			end
		end
	else
		aloftData.threat = nil
		aloftData.threatMax = nil
		aloftData.threatMaxName = nil
	end
end

function AloftThreatData:OnThreatCleared()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.threat then
			aloftData.threat = 0
			aloftData.threatMax = nil
			aloftData.threatMaxName = nil
			self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
		end
	end
end

function AloftThreatData:OnThreatUpdated(name, playerUnit, targetName)
	local threatValue = Threat:GetThreat(name, targetName)
	if targetName == Threat.GlobalTarget then
		if name == playerName then
			for aloftData in Aloft:IterateVisibleNameplates() do
				aloftData.threat = threatValue
				self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
			end
		else
			for aloftData in Aloft:IterateVisibleNameplates() do
				if threatValue > (aloftData.threatMax or 0) then
					aloftData.threatMax = threatValue
					aloftData.threatMaxName = name
					self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
				elseif aloftData.threatMaxName == name then
					aloftData.threatMax = nil
					aloftData.threatMaxName = nil
					
					for	name, threat in Threat:IterateGroupThreatForTarget(targetName) do
						if name ~= playerName then
							aloftData.threatMax = threat
							aloftData.threatMaxName = name
							break
						end
					end					
					self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
				end
			end
		end
	elseif name == playerName then
		for aloftData in Aloft:IterateVisibleNameplates() do
			if Threat:_getTargetHash(aloftData.name) == targetName then
				aloftData.threat = threatValue
				self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
			end
		end
	else
		for aloftData in Aloft:IterateVisibleNameplates() do
			if Threat:_getTargetHash(aloftData.name) == targetName then
				if threatValue > (aloftData.threatMax or 0) then
					aloftData.threatMax = threatValue
					aloftData.threatMaxName = name
					self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
				elseif aloftData.threatMaxName == name then
					aloftData.threatMax = nil
					aloftData.threatMaxName = nil
					
					for	name, threat in Threat:IterateGroupThreatForTarget(targetName) do
						if name ~= playerName then
							aloftData.threatMax = threat
							aloftData.threatMaxName = name
							break
						end
					end					
					self:TriggerEvent("Aloft:OnThreatDataChanged", aloftData)
				end
			end
		end
	end
end


-----------------------------------------------------------------------------
