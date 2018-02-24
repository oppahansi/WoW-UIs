-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftCreatureTypeData")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Beast"]			= true,
	["Demon"]			= true,
	["Dragonkin"]		= true,
	["Humanoid"]		= true,
	["Elemental"]		= true,
	["Undead"]			= true,

	-- This is checked against when we gather data. If it's not specified, don't store it.
	["Not specified"]	= true,

	-- short forms
	["ShortBeast"]		= "B",
	["ShortDemon"]		= "D",
	["ShortDragonkin"]	= "K",
	["ShortHumanoid"]	= "H",
	["ShortElemental"]	= "E",
	["ShortUndead"]		= "U",
} end)

L:RegisterTranslations("koKR", function() return {
	["Beast"]			= "야수",
	["Demon"]			= "악마형",
	["Dragonkin"]		= "용족",
	["Humanoid"]		= "인간형",
	["Elemental"]		= "정령",
	["Undead"]			= "언데드",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	["Not specified"]	= "정보 없음",

	-- short forms
	["ShortBeast"]		= "B",
	["ShortDemon"]		= "D",
	["ShortDragonkin"]	= "K",
	["ShortHumanoid"]	= "H",
	["ShortElemental"]	= "E",
	["ShortUndead"]		= "U",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Beast"]			= "野獸",
	["Demon"]			= "惡魔",
	["Dragonkin"]		= "龍類",
	["Humanoid"]		= "人型生物",
	["Elemental"]		= "元素生物",
	["Undead"]			= "不死族",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	["Not specified"]	= "未指定",

	-- short forms
	["ShortBeast"]		= "野獸",
	["ShortDemon"]		= "惡魔",
	["ShortDragonkin"]	= "龍類",
	["ShortHumanoid"]	= "人型",
	["ShortElemental"]	= "元素",
	["ShortUndead"]		= "不死",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Beast"]			= "野兽",
	["Demon"]			= "恶魔",
	["Dragonkin"]		= "龙类",
	["Humanoid"]		= "人型生物",
	["Elemental"]		= "元素生物",
	["Undead"]			= "亡灵",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	["Not specified"]	= "未指定",

	-- short forms
	["ShortBeast"]		= "野兽",
	["ShortDemon"]		= "恶魔",
	["ShortDragonkin"]	= "龙类",
	["ShortHumanoid"]	= "人型",
	["ShortElemental"]	= "元素",
	["ShortUndead"]		= "亡灵",
} end)

-----------------------------------------------------------------------------

local creatureTypeData = { }
local shortCreatureTypeTextLookup =
{
	[L["Beast"]]		= L["ShortBeast"],
	[L["Demon"]]		= L["ShortDemon"],
	[L["Dragonkin"]]	= L["ShortDragonkin"],
	[L["Elemental"]]	= L["ShortElemental"],
	[L["Humanoid"]]		= L["ShortHumanoid"],
	[L["Undead"]]		= L["ShortUndead"],
}

-----------------------------------------------------------------------------

local AloftCreatureTypeData = Aloft:NewModule("CreatureTypeData", "AceEvent-2.0")
AloftCreatureTypeData.db = Aloft:AcquireDBNamespace("creatureTypeData")
Aloft:RegisterDefaults("creatureTypeData", "account", {	creatureTypeData = { } })
Aloft:RegisterDefaults("creatureTypeData", "profile", { save = false })

-----------------------------------------------------------------------------

Aloft.TagData.CreatureType =
{ 
	data = "creatureType", 
	events = "Aloft:OnCreatureTypeDataChanged",
	tableData = "creatureType"
}

Aloft.TagData.ShortCreatureType =
{ 
	data = "creatureType", 
	events = "Aloft:OnCreatureTypeDataChanged",
	method = function(aloftData, value) return value and aloftData.creatureType and shortCreatureTypeTextLookup[aloftData.creatureType] or nil end
}

-----------------------------------------------------------------------------

function AloftCreatureTypeData.SetSaveData(v)
	AloftCreatureTypeData.db.profile.save = v
	AloftCreatureTypeData.db.server.creatureTypeData = v and creatureTypeData or { }
end

function AloftCreatureTypeData:ProvidesData()
	return "creatureType"
end

function AloftCreatureTypeData:EnableDataSource()
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateCreatureTypeFromMouseOver")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCreatureTypeFromTarget")
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:OnEnable()
	if self.db.profile.save then
		creatureTypeData = self.db.account.creatureTypeData
	end
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateData(aloftData)
	aloftData.creatureType = creatureTypeData[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end
	
	-- Don't store creature types that are empty or "not specified" to reduce the database
	local creatureType = UnitCreatureType(unitid)
	if not creatureType then return end
	if creatureType == "" or creatureType == L["Not specified"] then return end
	
	local name = UnitName(unitid)
	if creatureType == creatureTypeData[name] then return end
	creatureTypeData[name] = creatureType
	
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name == name then
			aloftData.creatureType = creatureType
			self:TriggerEvent("Aloft:OnCreatureTypeDataChanged", aloftData)
		end
	end
end

function AloftCreatureTypeData:UpdateCreatureTypeFromMouseOver()
	self:UpdateFromUnit("mouseover")
end

function AloftCreatureTypeData:UpdateCreatureTypeFromTarget()
	self:UpdateFromUnit("target")
end

-----------------------------------------------------------------------------
