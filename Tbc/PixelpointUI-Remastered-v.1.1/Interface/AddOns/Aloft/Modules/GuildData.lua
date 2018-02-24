-----------------------------------------------------------------------------

local playerGuilds = { }

-----------------------------------------------------------------------------

local AloftGuildData = Aloft:NewModule("GuildData", "AceEvent-2.0")
AloftGuildData.db = Aloft:AcquireDBNamespace("guildData")
Aloft:RegisterDefaults("guildData", "server", {	playerGuilds = { } })
Aloft:RegisterDefaults("guildData", "profile", { save = true })

-----------------------------------------------------------------------------

Aloft.TagData.Guild =
{
	data = "guild",
	events = "Aloft:OnGuildDataChanged",
	tableData = "guild"
}

-----------------------------------------------------------------------------

function AloftGuildData.SetSaveData(v)
	AloftGuildData.db.profile.save = v
	AloftGuildData.db.server.playerGuilds = v and playerGuilds or { }
end

function AloftGuildData:ProvidesData()
	return "guild"
end

function AloftGuildData:EnableDataSource()
	-- Events to update our guild database
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateGuildFromMouseOver")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateGuildFromTarget")
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateGuildFromGuild")
    self:RegisterEvent("WHO_LIST_UPDATE", "UpdateGuildFromWho") 
    self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateGuildFromWho") 

	self:UpdateGuildFromGuild()
end

-----------------------------------------------------------------------------

function AloftGuildData:OnEnable()
	if self.db.profile.save then
		playerGuilds = self.db.server.playerGuilds
	end
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateData(aloftData)
	aloftData.guild = nil
	
	-- This is so that pets named the same as players we've encountered aren't given a class incorrectly
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostile" then
		aloftData.guild = playerGuilds[aloftData.name]
	end
end

-----------------------------------------------------------------------------

local updateRequired = false

local function AddData(name, guild)
	if guild == "" then 
		guild = nil 
	end
	if name and playerGuilds[name] ~= guild then
		playerGuilds[name] = guild
		updateRequired = true
	end
end

function AloftGuildData:UpdateVisibleNameplates()
	if updateRequired then
		for aloftData in Aloft:IterateVisibleNameplates() do
			local guild = playerGuilds[aloftData.name]
		
			if aloftData.guild ~= guild then
				aloftData.guild = guild
				self:TriggerEvent("Aloft:OnGuildDataChanged", aloftData)
			end
		end
	end
	updateRequired = false
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateGuildFromMouseOver()
	if UnitIsPlayer("mouseover") then
		AddData(UnitName("mouseover"), GetGuildInfo("mouseover"))
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromTarget()
	if UnitIsPlayer("target") then
		AddData(UnitName("target"), GetGuildInfo("target"))
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromGuild()
    if IsInGuild() then
		local guild = GetGuildInfo("player")
		for i = 1, GetNumGuildMembers(true) do
			local name = GetGuildRosterInfo(i)
			AddData(name, guild)
		end
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromWho()
    for i = 1, GetNumWhoResults() do
        local name, guild = GetWhoInfo(i)
        AddData(name, guild)
    end
	self:UpdateVisibleNameplates()
end

-----------------------------------------------------------------------------
