-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftShortGuildData")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["ShortSubstitutions"] =
	{
		[" [Aa][Nn][Dd] "]	= " & ",
		[" [Oo][Ff] "]		= " of ",		-- Forces shortened form "o" to go lower case
		[" [Oo][Nn] "]		= " on ",		-- Forces shortened form "o" to go lower case
		[" [Tt][Hh][Ee] "]	= " the ",
		[" [Ii][Nn] "]		= " in ",
	}
} end)

-----------------------------------------------------------------------------

local shortGuildList = { }
local shortGuildCache = { }

-----------------------------------------------------------------------------

local AloftShortGuildData = Aloft:NewModule("ShortGuildData", "AceEvent-2.0")
AloftShortGuildData.db = Aloft:AcquireDBNamespace("shortGuildData")
Aloft:RegisterDefaults("shortGuildData", "server", { shortGuildList = { } })

-----------------------------------------------------------------------------

Aloft.TagData.ShortGuild =
{
	data = "shortGuild",
	events = "Aloft:OnShortGuildDataChanged",
	overrideEvents = "Aloft:OnGuildDataChanged",
	tableData = "shortGuild"
}

-----------------------------------------------------------------------------

function AloftShortGuildData:ProvidesData()
	return "shortGuild"
end

function AloftShortGuildData:RequiresData()
	return "guild"
end

function AloftShortGuildData:EnableDataSource()
	self:RegisterEvent("Aloft:OnGuildDataChanged", "OnGuildDataChanged")
end

-----------------------------------------------------------------------------

function AloftShortGuildData:OnEnable()
	shortGuildList = self.db.server.shortGuildList
end

-----------------------------------------------------------------------------

local updateRequired = false

local function AddData(name, guild)
	if name and guild and playerGuilds[name] ~= guild then
		playerGuilds[name] = guild
		updateRequired = true
	end
end

function AloftShortGuildData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local guild = aloftData.guild

		if guild then
			local shortGuild = shortGuildList[guild] or shortGuildCache[guild]
			if aloftData.shortGuild ~= shortGuild then
				aloftData.shortGuild = shortGuild
				self:TriggerEvent("Aloft:OnShortGuildDataChanged", aloftData)
			end
		end
	end
end

function AloftShortGuildData:AddData(guild, abbreviation)
	shortGuildList[guild] = abbreviation
	self:UpdateAll()
end

function AloftShortGuildData:ClearAllData()
	for k in pairs(shortGuildList) do
		shortGuildList[k] = nil
	end
	self:UpdateAll()
end

function AloftShortGuildData:CreateShortName(guild)
	local _, numberOfSpaces = guild:gsub(" ", "")
	
	if numberOfSpaces == 0 then
		return guild:sub(1, 4)
	end

	-- This code replaces 2-word guild names with the first two characters of each word
	-- In practise I preferred not having the extra chars, than having the more obvious distinction
--	if numberOfSpaces == 1 then
--		return guild:gsub("(%a%a?)%a*%A*", "%1")
--	end

	for k,v in pairs(L["ShortSubstitutions"]) do
		guild = guild:gsub(k, v)
	end

	return guild:gsub("(%a)%a*%A*", "%1")
end

-----------------------------------------------------------------------------

function AloftShortGuildData:UpdateData(aloftData)
	aloftData.shortGuild = nil
	
	local guild = aloftData.guild	
	if guild then
		local shortGuild = shortGuildList[guild] or shortGuildCache[guild]
		
		if not shortGuild then
			shortGuild = self:CreateShortName(guild)
			shortGuildCache[guild] = shortGuild
		end
		
		aloftData.shortGuild = shortGuild
	end
end

function AloftShortGuildData:OnGuildDataChanged(aloftData)
	self:UpdateData(aloftData)
	self:TriggerEvent("Aloft:OnShortGuildDataChanged", aloftData)
end

-----------------------------------------------------------------------------
