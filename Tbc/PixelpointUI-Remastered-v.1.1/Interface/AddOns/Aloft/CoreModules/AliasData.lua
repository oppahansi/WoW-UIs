-----------------------------------------------------------------------------

local aliasList = { }

-----------------------------------------------------------------------------

local AloftAliasData = Aloft:NewModule("AliasData", "AceEvent-2.0")
AloftAliasData.db = Aloft:AcquireDBNamespace("aliasData")
Aloft:RegisterDefaults("aliasData", "account", { aliasList = { } })

-----------------------------------------------------------------------------

Aloft.TagData.Alias =
{
	data = "alias",
	events = "Aloft:OnAliasDataChanged",
	tableData = "alias"
}

-----------------------------------------------------------------------------

function AloftAliasData:ProvidesData()
	return "alias"
end

-----------------------------------------------------------------------------

function AloftAliasData:OnEnable()
	aliasList = self.db.account.aliasList
end

-----------------------------------------------------------------------------

function AloftAliasData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local alias = aliasList[aloftData.name] or aloftData.name

		if aloftData.alias ~= alias then
			aloftData.alias = alias
			self:TriggerEvent("Aloft:OnAliasDataChanged", aloftData)
		end
	end
end

function AloftAliasData:SetAlias(name, alias)
	if not name then return end

	aliasList[name] = alias ~= "" and alias or nil
	alias = aliasList[name] or name

	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name == name then
			aloftData.alias = alias
			self:TriggerEvent("Aloft:OnAliasDataChanged", aloftData)
		end
	end
end

function AloftAliasData:ClearAllData()
	for k in pairs(aliasList) do
		aliasList[k] = nil
	end
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftAliasData:UpdateData(aloftData)
	aloftData.alias = aliasList[aloftData.name] or aloftData.name
end

-----------------------------------------------------------------------------
