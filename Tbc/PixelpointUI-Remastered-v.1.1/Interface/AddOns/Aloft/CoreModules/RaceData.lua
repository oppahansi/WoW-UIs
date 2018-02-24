-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftRaceData")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	-- short forms
	["Blood Elf"]	= "BE",
	["Draenei"]		= "Dr",
	["Dwarf"]		= "Dw",
	["Gnome"]		= "Gn",
	["Human"]		= "Hu",
	["Night Elf"]	= "NE",
	["Orc"]			= "Or",
	["Tauren"]		= "Ta",
	["Troll"]		= "Tr",
	["Undead"]		= "Ud",
} end)

L:RegisterTranslations("koKR", function() return {
	-- short forms
	["Blood Elf"]		= "블엘",
	["Draenei"]		= "드레",
	["Dwarf"]		= "드웦",
	["Gnome"]		= "놈",
	["Human"]		= "인간",
	["Night Elf"]		= "나엘",
	["Orc"]			= "오크",
	["Tauren"]		= "타렌",
	["Troll"]		= "트롤",
	["Undead"]		= "언데",
} end)

L:RegisterTranslations("zhTW", function() return {
	-- short forms
	["Blood Elf"]	= "血",
	["Draenei"]		= "萊",
	["Dwarf"]		= "矮",
	["Gnome"]		= "地",
	["Human"]		= "人",
	["Night Elf"]	= "夜",
	["Orc"]			= "獸",
	["Tauren"]		= "牛",
	["Troll"]		= "食",
	["Undead"]		= "不",
} end)

L:RegisterTranslations("zhCN", function() return {
	-- short forms
	["Blood Elf"]	= "血精灵",
	["Draenei"]		= "德莱尼",
	["Dwarf"]		= "矮人",
	["Gnome"]		= "侏儒",
	["Human"]		= "人类",
	["Night Elf"]	= "夜精灵",
	["Orc"]			= "兽人",
	["Tauren"]		= "牛头",
	["Troll"]		= "巨魔",
	["Undead"]		= "亡灵",
} end)

-----------------------------------------------------------------------------

local raceData = { }

-----------------------------------------------------------------------------

local AloftRaceData = Aloft:NewModule("RaceData", "AceEvent-2.0")
AloftRaceData.db = Aloft:AcquireDBNamespace("raceData")
Aloft:RegisterDefaults("raceData", "server", {	raceData = { } })
Aloft:RegisterDefaults("raceData", "profile", { save = false })

-----------------------------------------------------------------------------

Aloft.TagData.Race =
{
	data = "race",
	events = "Aloft:OnRaceDataChanged",
	tableData = "race"
}

Aloft.TagData.ShortRace =
{
	data = "race",
	events = "Aloft:OnRaceDataChanged",
	method = function(aloftData, value) return value and aloftData.race and L[aloftData.race] end
}

-----------------------------------------------------------------------------

function AloftRaceData.SetSaveData(v)
	AloftRaceData.db.profile.save = v
	AloftRaceData.db.server.raceData = v and raceData or { }
end

function AloftRaceData:ProvidesData()
	return "race"
end

function AloftRaceData:EnableDataSource()
	-- Events to update our race database
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateRaceFromMouseOver")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateRaceFromTarget")
    self:RegisterEvent("WHO_LIST_UPDATE", "UpdateRaceFromWho") 
    self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateRaceFromWho") 
end

-----------------------------------------------------------------------------

function AloftRaceData:OnEnable()
	if self.db.profile.save then
		raceData = self.db.server.raceData
	end
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateData(aloftData)
	aloftData.race = raceData[aloftData.name]
end

-----------------------------------------------------------------------------

local updateRequired = false

local function AddData(name, race)
	if race == "" then 
		race = nil 
	end
	if name and raceData[name] ~= race then
		raceData[name] = race
		updateRequired = true
	end
end

function AloftRaceData:UpdateVisibleNameplates()
	if updateRequired then
		for aloftData in Aloft:IterateVisibleNameplates() do
			local race = raceData[aloftData.name]
		
			if aloftData.race ~= race then
				aloftData.race = race
				self:TriggerEvent("Aloft:OnRaceDataChanged", aloftData)
			end
		end
	end
	updateRequired = false
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateRaceFromMouseOver()
	if UnitIsPlayer("mouseover") then
		AddData(UnitName("mouseover"), UnitRace("mouseover"))
		self:UpdateVisibleNameplates()
	end
end

function AloftRaceData:UpdateRaceFromTarget()
	if UnitIsPlayer("target") then
		AddData(UnitName("target"), UnitRace("target"))
		self:UpdateVisibleNameplates()
	end
end

function AloftRaceData:UpdateRaceFromWho()
    for i = 1, GetNumWhoResults() do
        local name, _, _, race = GetWhoInfo(i)
        AddData(name, race)
    end
	self:UpdateVisibleNameplates()
end

-----------------------------------------------------------------------------
