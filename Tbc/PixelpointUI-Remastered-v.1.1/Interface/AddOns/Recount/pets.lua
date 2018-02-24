
local revision = tonumber(string.sub("$Revision: 664 $", 12, -3))
if Recount.Version < revision then Recount.Version = revision end

local Pets={}
Pets.Pets={}

Recount.Pets=Pets

function Pets:AddPet(owner,name)
	Pets.Pets[owner]=name
end

function Pets:RemovePet(owner)
	if owner and Pets.Pets[owner] then
		Pets.Pets[owner]=nil
	end
end

function Pets:PetCheck(unit)

	if not unit then
		Recount:Print("Nil unit")
		return
	end

	local PetUnit=unit.."pet"
	if UnitExists(unit) and UnitExists(PetUnit) then
		local PetName=UnitName(PetUnit)
		if PetName=="Unknown" then
		
			Pets:ScheduleTimer("PetCheck",0.1,unit)
		else
			Pets:AddPet(UnitName(unit),PetName)
		end
	else
		Pets:RemovePet(UnitName(unit))
	end
end

function Recount:UNIT_PET()
	if arg1~="target" and arg1~="focus" and arg1~="npc" and arg1~="mouseover" then
		Pets:PetCheck(arg1)
	end
end

function Recount:PLAYER_PET_CHANGED()
	Pets:PetCheck("player")
end

function Pets:IsUniquePet(petName, petGUID,petFlags)
	local owner=nil

	for k,v in pairs(Pets.Pets) do
		if v==petName then
			if owner then
				return false
			else
				owner=k
			end
		end
	end
	return owner
end

function Pets:ScanRoster()	
	local Num=GetNumRaidMembers() 
	if Num>0 then
		for i=1,Num do
			Pets:PetCheck("raid"..i)
		end
	else
		Num=GetNumPartyMembers()
		if Num>0 then
			for i=1,Num do
				Pets:PetCheck("party"..i)
			end
		else
			for k in pairs(Pets.Pets) do
				Pets.Pets[k]=nil
			end
		end
	end	
	Pets:PetCheck("player")
end

function Pets:DumpList()
	Recount:Print("Pet List")
	for k, v in pairs(Pets.Pets) do
		Recount:Print(UnitName(k),v)
	end
end

LibStub("AceTimer-3.0"):Embed(Pets)
