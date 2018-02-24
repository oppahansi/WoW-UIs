-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameData")
local gratuity = AceLibrary("Gratuity-2.0")
local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["PetTest"] = "(.*)'s Pet",
	["MinionTest"] = "(.*)'s Minion",
} end)

L:RegisterTranslations("koKR", function() return {
	["PetTest"] = "(.*)의 소환수",
	["MinionTest"] = "(.*)의 하수인",
} end)

L:RegisterTranslations("zhTW", function() return {
	["PetTest"] = "(.*)的寵物",
	["MinionTest"] = "(.*)的僕從",
} end)

L:RegisterTranslations("zhCN", function() return {
	["PetTest"] = "(.*)的宠物",
	["MinionTest"] = "(.*)的仆从",
} end)

-----------------------------------------------------------------------------

local petOwnersNames = { }

local petTests = 
{
	[L["PetTest"]] = true,
	[L["MinionTest"]] = true,
}

-----------------------------------------------------------------------------

local AloftPetOwnersNameData = Aloft:NewModule("PetOwnersNameData", "AceEvent-2.0")

-----------------------------------------------------------------------------

Aloft.TagData.PetOwnersName =
{
	data = "petOwnersName",
	events = "Aloft:OnPetOwnersNameDataChanged",
	tableData = "petOwnersName"
}

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:ProvidesData()
	return "petOwnersName"
end

function AloftPetOwnersNameData:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePetOwnersNameFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePetOwnersNameFromTarget")
    self:RegisterEvent("RosterLib_RosterUpdated", "UpdatePetOwnersNamesFromRoster")
end

function AloftPetOwnersNameData:EnableDataSource()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:OnEnable()
end

function AloftPetOwnersNameData:UpdateData(aloftData)
	-- This is to stop players that share the same names as pets being incorrectly tagged
	if aloftData.type == "friendlyNPC" or aloftData.type == "hostile" then
		aloftData.petOwnersName = petOwnersNames[aloftData.name]
	else
		aloftData.petOwnersName = nil
	end
end

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:UpdatePetOwnersNameFromUnit(unitid)
	if UnitIsPlayer(unitid) or not UnitPlayerControlled(unitid) then return end
	
	gratuity:SetUnit(unitid)
	local petOwnersName = gratuity:GetLine(2)
	if not petOwnersName or petOwnersName == "" then return end

	local match = false
	for test in pairs(petTests) do
		local localMatch
		petOwnersName, localMatch = petOwnersName:gsub(test, "%1")
		if localMatch > 0 then match = true end
	end
	if not match then return end
	
	local key = UnitName(unitid)
	if petOwnersNames[key] == petOwnersName then return end
	
	petOwnersNames[key] = petOwnersName
	aloftData = Aloft:GetNameplate(key)
	if not aloftData then return end
	
	aloftData.petOwnersName = petOwnersName
	self:TriggerEvent("Aloft:OnPetOwnersNameDataChanged", aloftData)
end

function AloftPetOwnersNameData:UpdatePetOwnersNameFromMouseOver()
	self:UpdatePetOwnersNameFromUnit("mouseover")
end

function AloftPetOwnersNameData:UpdatePetOwnersNameFromTarget()
	self:UpdatePetOwnersNameFromUnit("target")
end

function AloftPetOwnersNameData:UpdatePetOwnersNamesFromRoster()
	for unit in roster:IterateRoster(true) do
		local owner, match = unit.unitid:gsub("pet", "")
		if match > 0 then
			if owner == "" then owner = "player" end
			
			local key = unit.name
			local petOwnersName = UnitName(owner)
			
			if petOwnersNames[key] ~= petOwnersName then
				petOwnersNames[key] = petOwnersName
				aloftData = Aloft:GetNameplate(key)
				if aloftData then
					aloftData.petOwnersName = petOwnersName
					self:TriggerEvent("Aloft:OnPetOwnersNameDataChanged", aloftData)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------
