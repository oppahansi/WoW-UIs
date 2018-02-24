-----------------------------------------------------------------------------

local AloftManaData = Aloft:NewModule("ManaData", "AceEvent-2.0")

-----------------------------------------------------------------------------

Aloft.TagData.Mana =
{
	data = "mana",
	events = "Aloft:OnManaDataChanged",
	tableData = "mana",
	numeric = true
}

Aloft.TagData.MaxMana =
{
	data = "maxMana",
	events = "Aloft:OnManaDataChanged",
	tableData = "maxMana",
	numeric = true
}

Aloft.TagData.ManaDeficit =
{
	data = { "mana", "maxMana" },
	events = "Aloft:OnManaDataChanged",
	compileString = function(dataTable, prior) return string.format("data.mana and %s%s(data.maxMana - data.mana)", prior or "", prior and " and " or "") end,
	numeric = true
}

Aloft.TagData.ManaFraction =
{
	data = { "mana", "maxMana" },
	events = "Aloft:OnManaDataChanged",
	compileString = function(dataTable, prior) return string.format("data.mana and %s%s(data.mana / data.maxMana)", prior or "", prior and " and " or "") end,
	numeric = true
}

Aloft.TagData.PowerType =
{
	data = "powerType",
	events = "Aloft:OnManaDataChanged",
	tableData = "powerType",
	numeric = true
}

local colorTable =
{
	[0] = "c0c0ff",	-- Mana
	[1] = "ff8080",	-- Rage
	[2] = "ffd100", -- Focus
	[3] = "ffff80",	-- Energy
	[4] = "80ffff", -- Happiness
}
Aloft.TagData.PowerTypeColor =
{
	data = "powerType",
	events = "Aloft:OnManaDataChanged",
	method = function(aloftData, value) return value and aloftData.powerType and ("|cff%s%s|r"):format(colorTable[aloftData.powerType], value or "") end,
	noGuaranteeChange = true
}

-----------------------------------------------------------------------------

function AloftManaData:ProvidesData()
	return "mana", "maxMana", "powerType"
end

function AloftManaData:RequiresData()
	if GetNumPartyMembers() + GetNumRaidMembers() > 0 then
		return "unitid", "isTarget"
	else
		return "isTarget"
	end
end

function AloftManaData:EnableDataSource()
	self:RegisterEvent("UNIT_MANA", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_RAGE", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_FOCUS", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_ENERGY", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_DISPLAYPOWER", "OnUnitManaChanged")
	self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
end

-----------------------------------------------------------------------------

function AloftManaData:ClearManaData(aloftData)
	if aloftData.mana then
		aloftData.mana = nil
		aloftData.maxMana = nil
		aloftData.powerType = nil
		self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
	end
end

function AloftManaData:SetManaData(aloftData, unitid)
	aloftData.mana = UnitMana(unitid)
	aloftData.maxMana = UnitManaMax(unitid)
	aloftData.powerType = UnitPowerType(unitid)
	self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
end

function AloftManaData:OnIsTargetDataChanged(aloftData)
	if aloftData.isTarget then
		if not aloftData.mana then
			self:SetManaData(aloftData, "target")
		end
	elseif not aloftData.unitid then
		self:ClearManaData(aloftData);
	end
end

function AloftManaData:OnUnitManaChanged(unitid)
	if unitid == "target" then
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData and aloftData.isTarget then
			self:SetManaData(aloftData, unitid)
		end
	else
		local aloftData = Aloft:GetUnitNameplate(unitid)
		if not aloftData then return end
		self:SetManaData(aloftData, unitid)
	end
end

-----------------------------------------------------------------------------

function AloftManaData:UpdateData(aloftData)
	aloftData.mana = nil
	aloftData.maxMana = nil
	aloftData.powerType = nil

	if aloftData:IsTarget() then
		aloftData.mana = UnitMana("target")
		aloftData.maxMana = UnitManaMax("target")
		aloftData.powerType = UnitPowerType("target")
	elseif aloftData.unitid then
		aloftData.mana = UnitMana(aloftData.unitid)
		aloftData.maxMana = UnitManaMax(aloftData.unitid)
		aloftData.powerType = UnitPowerType(aloftData.unitid)
	end
end

function AloftManaData:OnUnitidDataChanged(aloftData)
	self:UpdateData(aloftData)
	self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
end

-----------------------------------------------------------------------------
