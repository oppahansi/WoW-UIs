-----------------------------------------------------------------------------

local AloftHealthData = Aloft:NewModule("HealthData", "AceEvent-2.0")

-----------------------------------------------------------------------------

Aloft.TagData.Health =
{
	data = "health",
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	tableData = "health",
	numeric = true
}

Aloft.TagData.MaxHealth =
{
	data = "maxHealth",
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	tableData = "maxHealth",
	numeric = true
}

Aloft.TagData.HealthDeficit =
{
	data = { "health", "maxHealth" },
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("data.health and data.maxHealth%s%s and (data.maxHealth-data.health)", prior and " and " or "", prior or "") end,
	numeric = true
}

Aloft.TagData.HideKnownHealth =
{
	data = "health",
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("not data.health%s%s", prior and " and " or "", prior or "") end
}
 
-----------------------------------------------------------------------------

function AloftHealthData:ProvidesData()
	return "health", "maxHealth"
end

-----------------------------------------------------------------------------

function AloftHealthData:EnableDataSource()
	self:RegisterEvent("Aloft:OnHealthBarValueChanged", "OnHealthBarValueChanged")
end

-----------------------------------------------------------------------------

function AloftHealthData:UpdateData(aloftData)
    if aloftData.healthBarMaxValue ~= 100 then
        aloftData.health = aloftData.healthBarValue
        aloftData.maxHealth = aloftData.healthBarMaxValue
    elseif MobHealth3 then
        local health, maxHealth, valid = MobHealth3:GetHealth(aloftData.healthBarValue, aloftData.healthBarMaxValue, aloftData.name, aloftData.level or -1)
        if valid then
            aloftData.health = health
            aloftData.maxHealth = maxHealth
        else
            aloftData.health = nil
            aloftData.maxHealth = nil
        end
    else
        aloftData.health = nil
        aloftData.maxHealth = nil
    end
end

-----------------------------------------------------------------------------

function AloftHealthData:OnHealthBarValueChanged(aloftData)
	self:UpdateData(aloftData)
	self:TriggerEvent("Aloft:OnHealthDataChanged", aloftData)
end

-----------------------------------------------------------------------------
