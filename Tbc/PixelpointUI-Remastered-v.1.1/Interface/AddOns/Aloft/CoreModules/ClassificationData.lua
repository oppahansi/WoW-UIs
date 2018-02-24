-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftClassificationData")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["rare"]		= "Rare",
	["elite"]		= "Elite",
	["rareelite"]	= "Rare-Elite",
	["worldboss"]	= "Boss",
	
	["shortrare"]		= "r",
	["shortelite"]		= "+",
	["shortrareelite"]	= "r+",
	["shortworldboss"]	= "b",
} end)

L:RegisterTranslations("koKR", function() return {
	["rare"]		= "희귀",
	["elite"]		= "정예",
	["rareelite"]	= "희귀-정예",
	["worldboss"]	= "보스",
	
	["shortrare"]		= "r",
	["shortelite"]		= "+",
	["shortrareelite"]	= "r+",
	["shortworldboss"]	= "b",
} end)

L:RegisterTranslations("zhTW", function() return {
	["rare"]		= "稀有",
	["elite"]		= "精英",
	["rareelite"]	= "稀有-精英",
	["worldboss"]	= "首領",
	
	["shortrare"]		= "稀",
	["shortelite"]		= "+",
	["shortrareelite"]	= "稀+",
	["shortworldboss"]	= "首",
} end)

L:RegisterTranslations("zhCN", function() return {
	["rare"]		= "稀有",
	["elite"]		= "精英",
	["rareelite"]	= "稀有精英",
	["worldboss"]	= "首领",
	
	["shortrare"]		= "-",
	["shortelite"]		= "+",
	["shortrareelite"]	= "++",
	["shortworldboss"]	= "boss",
} end)

-----------------------------------------------------------------------------

local unitClassifications = { }

local classificationText =
{
	rare		= L["rare"],
	elite		= L["elite"],
	rareelite	= L["rareelite"],
	worldboss	= L["worldboss"],
}

local shortClassificationText =
{
	rare		= L["shortrare"],
	elite		= L["shortelite"],
	rareelite	= L["shortrareelite"],
	worldboss	= L["shortworldboss"],
}

-----------------------------------------------------------------------------

local AloftClassificationData = Aloft:NewModule("ClassificationData", "AceEvent-2.0")
AloftClassificationData.db = Aloft:AcquireDBNamespace("classificationData")
Aloft:RegisterDefaults("classificationData", "account", { unitClassifications = { } })
Aloft:RegisterDefaults("classificationData", "profile", { save = false })

-----------------------------------------------------------------------------

Aloft.TagData.Classification =
{
	data = "classification",
	events = "Aloft:OnClassificationDataChanged",
	method = function(aloftData, value)
				return value and aloftData.classification and classificationText[aloftData.classification]
			 end
}

Aloft.TagData.ShortClassification =
{
	data = "classification",
	events = "Aloft:OnClassificationDataChanged",
	method = function(aloftData, value)
				return value and aloftData.classification and shortClassificationText[aloftData.classification]
			 end
}

-----------------------------------------------------------------------------

function AloftClassificationData.SetSaveData(v)
	AloftClassificationData.db.profile.save = v
	AloftClassificationData.db.account.unitClassifications = v and unitClassifications or { }
end

function AloftClassificationData:ProvidesData()
	return "classification"
end

function AloftClassificationData:EnableDataSource()
	-- Events to update our unit classification database
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateClassificationFromMouseOver")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateClassificationFromTarget")
end

-----------------------------------------------------------------------------

function AloftClassificationData:OnEnable()
	if self.db.profile.save then
		unitClassifications = self.db.account.unitClassifications
	end
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateData(aloftData)
	aloftData.classification = unitClassifications[(aloftData.level or -1)..aloftData.name]
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateFrom(unitid)
	-- Don't store normal unit classifications to reduce the database
	local classification = UnitClassification(unitid)
	if not classification then return end
	if classification == "normal" then return end
	
	local level = UnitLevel(unitid)
	local name = UnitName(unitid)
	local key = level..name
	if classification == unitClassifications[key] then return end
	unitClassifications[key] = classification
	
	-- AloftData uses level as nil for tag purposes if its indeterminate
	if level == -1 then level = nil end
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name == name and aloftData.level == level then
			aloftData.classification = classification
			self:TriggerEvent("Aloft:OnClassificationDataChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateClassificationFromMouseOver()
	self:UpdateFrom("mouseover")
end

function AloftClassificationData:UpdateClassificationFromTarget()
	self:UpdateFrom("target")
end

-----------------------------------------------------------------------------
