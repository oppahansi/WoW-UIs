-----------------------------------------------------------------------------

local AloftIsGuildMemberData = Aloft:NewModule("IsGuildMemberData", "AceEvent-2.0")

local guildList = { }
local lastNumberOfGuildMembers = 0

-----------------------------------------------------------------------------

Aloft.TagData.IsGuildMember =
{
	data = "isGuildMember",
	tableData = "isGuildMember"
}

Aloft.TagData.HideGuild =
{ 
	data = "isGuildMember",
	compileString = function(dataTable, prior) return string.format("not data.isGuildMember%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.HideNotGuild =
{
	data = "isGuildMember",
	tableData = "isGuildMember"
}

-----------------------------------------------------------------------------

function AloftIsGuildMemberData:ProvidesData()
	return "isGuildMember"
end

function AloftIsGuildMemberData:EnableDataSource()
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateGuildList")
	self:UpdateGuildList()
end

-----------------------------------------------------------------------------

function AloftIsGuildMemberData:UpdateData(aloftData)
	aloftData.isGuildMember = guildList[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftIsGuildMemberData:UpdateGuildList()
    if IsInGuild() then
		local numberOfGuildMembers = GetNumGuildMembers(true)

		if numberOfGuildMembers < lastNumberOfGuildMembers then
			-- Only empty the guild list if the new list is shorter,
			-- ie. if someone has been kicked from guild.
			for name in pairs(guildList) do
				guildList[name] = nil
			end
		end

		lastNumberOfGuildMembers = numberOfGuildMembers
	
		for i = 1, numberOfGuildMembers do
			local name = GetGuildRosterInfo(i)
			guildList[name] = true
		end
	elseif lastNumberOfGuildMembers > 0 then
		lastNumberOfGuildMembers = 0
		guildList = { }
	end
end

-----------------------------------------------------------------------------
