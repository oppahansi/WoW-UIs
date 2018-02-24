local revision = tonumber(string.sub("$Revision: 753 $", 12, -3))
if Recount.Version < revision then Recount.Version = revision end

local HealBuffs={}
Recount.HealBuffs=HealBuffs

local HealBuffID={
	[33763]=true, -- Lifebloom (rank 1) no other ranks
	[33076]=true, -- Prayer of Mending (rank 1)
--[[	[974]=true, -- Earth Shield (rank 1)
	[32593]=true, -- Earth Shield (rank 2)
	[32594]=true, -- Earth Shield (rank 3)]]
}

local LifebloomId=33763
local LifebloomBoomId=33778
local PoMId=33076

--[[function HealBuffs:HasMyHealBuffExpiring(unit,buffName)
	local i=1
	local name, TimeLeft

	while (UnitBuff(unit,i) ~= nil) do
		name, _, _, _, _, TimeLeft =  UnitBuff(unit,i)

		if name==buffName and TimeLeft and TimeLeft<0.16 then
			return true
		end
		i=i+1
	end
	return false
end]]

--[[function HealBuffs:HasMyHealBuff(unit,buffName)
	local i=1
	local Name, Duration
	while (UnitBuff(unit,i) ~= nil) do
		name, _, _, _, Duration =  UnitBuff(unit,i)

		if name==buffName and Duration then
			return true
		end
		i=i+1
	end
	return false
end]]

--[[function HealBuffs:IsMyHealBuff(victim,ability)
	--first confirm the unitid is correct
	if not UnitExists(victim.unit) or UnitName(victim.unit)~=victim.Name then
		local unit=Recount:FindUnit(victim.Name)
		if unit then
			victim.unit=unit
		else
			--can't find the unit so no idea whats happening
			return false
		end
	end
	
	if spellId==LifebloomId then
		--Might not be ours
		if HealBuffs:HasMyHealBuffExpiring(victim.unit,ability) then
			--its ours!
			return true
		end
		return false]]
--[[	elseif spellId == EarthShieldTickId then
		if HealBuffs:HasMyHealBuff(victim.unit,ability) then
			return true
		end
		return false]]
--[[	end

	return false
end]]

--Lifebloom Tracking for 2.4

local LB_Queue = {}

function HealBuffs.LB_Casted(who,dest,whoId,whoFlags)
	local mytime = GetTime()
	
	if not LB_Queue[dest] then
		LB_Queue[dest] = {{who, mytime,whoId,whoFlags}}
	else
		for i,v in ipairs(LB_Queue[dest]) do
			if v[1] == who and mytime-v[2]<7.0 then
				v[2]=mytime
				return -- We have a rolling lifebloom
			end
		end
	
		local destqueue = LB_Queue[dest]
		destqueue[#destqueue+1]={who, mytime,whoId,whoFlags}
	end
end

function HealBuffs.LB_Healed(dest)
	if LB_Queue[dest] and LB_Queue[dest][1] then
		local who = LB_Queue[dest][1][1]
		local whoId = LB_Queue[dest][1][3]
		local whoFlags = LB_Queue[dest][1][4]
		table.remove(LB_Queue[dest],1)
		return who, whoId, whoFlags
	else
		return nil
	end
end


--POM Tracking is based on Roartindon's work in Assessment
-- Sequence is:

-- A casts Prayer of Mending
-- B gains Prayer of Mending
-- B's Prayer of mending heals B for x
-- B casts Prayer of Mending
-- B loses Prayer of Mending
-- C gains Prayer of mending

--local POM_CastQueue={}
--local POM_AboutToCast={}

-- Elsia: Additions: Using cast success to contain original caster
-- Added 30 second buff length to streamline heuristics. Less false positives
-- Added 5 buff stack size to tracking, again less false positives

local POM_OwnerData={}
local POM_OwnerTable={}
local POM_TransitionQueue={}
local POM_Jumps={}
local POM_BuffTime={}

function HealBuffs.POM_Casted(who,dest,whoId,whoFlags)
	POM_OwnerTable[dest]=who
	POM_OwnerData[who] = POM_OwnerData[who] or {whoId, whoFlags}
	POM_Jumps[dest]=5
	POM_BuffTime[who]=GetTime()
	POM_TransitionQueue[#POM_TransitionQueue+1]=dest
end

function HealBuffs.POM_Healed(dest)
	if POM_OwnerTable[dest] then
		POM_TransitionQueue[#POM_TransitionQueue+1]=dest
		POM_BuffTime[POM_OwnerTable[dest]]=GetTime()
		
		local who = POM_OwnerTable[dest]
		local whoId = POM_OwnerData[who][1]
		local whoFlags = POM_OwnerData[who][2]
		return who, whoId, whoFlags
	else
		return nil
	end
end

function HealBuffs.POM_Gained(dest)
	local mytime = GetTime()
	while POM_TransitionQueue[1] and (POM_Jumps[POM_TransitionQueue[1]]<=0 or (mytime-POM_BuffTime[POM_OwnerTable[POM_TransitionQueue[1]]])>30.5) do -- Buff lasts only 30 seconds
		table.remove(POM_TransitionQueue,1) -- Remove expired POMs
	end
		
	if POM_TransitionQueue[1] then
		POM_OwnerTable[dest] = POM_OwnerTable[POM_TransitionQueue[1]]
		POM_Jumps[dest] = POM_Jumps[POM_TransitionQueue[1]] - 1
		POM_BuffTime[POM_OwnerTable[dest]]=mytime
		table.remove(POM_TransitionQueue,1)
	else
		POM_OwnerTable[dest]=nil
	end
end

--[[function HealBuffs.POM_Casted(who)
	if POM_AboutToCast[who] and (GetTime()-POM_AboutToCast[who])<0.5 then
		POM_CastQueue[#POM_CastQueue+1]=POM_OwnerTable[who]
		POM_AboutToCast[who]=nil
	else
		POM_CastQueue[#POM_CastQueue+1]=who
	end
end
function HealBuffs.POM_Gained(who)
	if POM_CastQueue[1] then		
		POM_OwnerTable[who]=POM_CastQueue[1]
		table.remove(POM_CastQueue,1)
	else
		POM_OwnerTable[who]="No One"
	end
end

function HealBuffs:WhosPOM(who)
	if POM_OwnerTable[who] then
		POM_AboutToCast[who]=GetTime()
		return POM_OwnerTable[who]
	else
		return "No One"
	end
end
]]