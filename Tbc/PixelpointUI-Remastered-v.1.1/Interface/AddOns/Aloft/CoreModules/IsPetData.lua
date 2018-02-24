-----------------------------------------------------------------------------

local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

local petNames = { }

-----------------------------------------------------------------------------

local AloftIsPetData = Aloft:NewModule("IsPetData", "AceEvent-2.0")
AloftIsPetData.db = Aloft:AcquireDBNamespace("isPetData")
Aloft:RegisterDefaults("isPetData", "server", { petNames = { } })
Aloft:RegisterDefaults("isPetData", "profile", { save = false })

-----------------------------------------------------------------------------

Aloft.TagData.IsPet =
{
	data = "isPet",
	events = "Aloft:OnIsPetDataChanged",
	tableData = "isPet"
}

-----------------------------------------------------------------------------

function AloftIsPetData.SetSaveData(v)
	AloftIsPetData.db.profile.save = v
	AloftIsPetData.db.server.petNames = v and petNames or { }
end

function AloftIsPetData:ProvidesData()
	return "isPet"
end

function AloftIsPetData:EnableDataSource()
	-- Events to update our pet database
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePetFromMouseOver")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePetFromTarget")
end

-----------------------------------------------------------------------------

function AloftIsPetData:OnEnable()
	if self.db.profile.save then
		petNames = self.db.server.petNames
	end
end

-----------------------------------------------------------------------------

function AloftIsPetData:UpdateData(aloftData)
	aloftData.isPet = nil
	
	-- This is so that pets named the same as players we've encountered aren't given ispet incorrectly
	if aloftData.type == "friendlyNPC" or aloftData.type == "hostile" then
		aloftData.isPet = petNames[aloftData.name]
	end
end

-----------------------------------------------------------------------------

function AloftIsPetData:SetPet(name)
	if not name or petNames[name] then return end
	petNames[name] = true
	
	local aloftData = Aloft:GetNameplate(name)
	if aloftData then
		if not aloftData.isPet and (aloftData.type == "friendlyNPC" or aloftData.type == "hostile") then
			aloftData.isPet = true
			self:TriggerEvent("Aloft:OnIsPetDataChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

local function IsPet(unitid)
	return UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid)
end

function AloftIsPetData:UpdatePetFromMouseOver()
	if IsPet("mouseover") then
		self:SetPet(UnitName("mouseover"))
	end
end

function AloftIsPetData:UpdatePetFromTarget()
	if IsPet("target") then
		self:SetPet(UnitName("target"))
	end
end

-----------------------------------------------------------------------------
