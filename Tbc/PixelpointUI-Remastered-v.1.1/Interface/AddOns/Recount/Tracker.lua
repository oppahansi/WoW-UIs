local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale( "Recount" )

local revision = tonumber(string.sub("$Revision: 901 $", 12, -3))
if Recount.Version < revision then Recount.Version = revision end

local _, _, _, tocversion =  GetBuildInfo()

--Data for Recount is tracked within this file
local Tracking={}

local UnitName = UnitName
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local GetTime = GetTime

-- Elsia: This is straight from GUIDRegistryLib-0.1 by ArrowMaster.
local bit_bor	= bit.bor
local bit_band  = bit.band

local COMBATLOG_OBJECT_AFFILIATION_MINE		= COMBATLOG_OBJECT_AFFILIATION_MINE		or 0x00000001
local COMBATLOG_OBJECT_AFFILIATION_PARTY	= COMBATLOG_OBJECT_AFFILIATION_PARTY	or 0x00000002
local COMBATLOG_OBJECT_AFFILIATION_RAID		= COMBATLOG_OBJECT_AFFILIATION_RAID		or 0x00000004
local COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	or 0x00000008
local COMBATLOG_OBJECT_AFFILIATION_MASK		= COMBATLOG_OBJECT_AFFILIATION_MASK		or 0x0000000F
-- Reaction
local COMBATLOG_OBJECT_REACTION_FRIENDLY	= COMBATLOG_OBJECT_REACTION_FRIENDLY	or 0x00000010
local COMBATLOG_OBJECT_REACTION_NEUTRAL		= COMBATLOG_OBJECT_REACTION_NEUTRAL		or 0x00000020
local COMBATLOG_OBJECT_REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE		or 0x00000040
local COMBATLOG_OBJECT_REACTION_MASK		= COMBATLOG_OBJECT_REACTION_MASK		or 0x000000F0
-- Ownership
local COMBATLOG_OBJECT_CONTROL_PLAYER		= COMBATLOG_OBJECT_CONTROL_PLAYER		or 0x00000100
local COMBATLOG_OBJECT_CONTROL_NPC			= COMBATLOG_OBJECT_CONTROL_NPC			or 0x00000200
local COMBATLOG_OBJECT_CONTROL_MASK			= COMBATLOG_OBJECT_CONTROL_MASK			or 0x00000300
-- Unit type
local COMBATLOG_OBJECT_TYPE_PLAYER			= COMBATLOG_OBJECT_TYPE_PLAYER			or 0x00000400
local COMBATLOG_OBJECT_TYPE_NPC				= COMBATLOG_OBJECT_TYPE_NPC				or 0x00000800
local COMBATLOG_OBJECT_TYPE_PET				= COMBATLOG_OBJECT_TYPE_PET				or 0x00001000
local COMBATLOG_OBJECT_TYPE_GUARDIAN		= COMBATLOG_OBJECT_TYPE_GUARDIAN		or 0x00002000
local COMBATLOG_OBJECT_TYPE_OBJECT			= COMBATLOG_OBJECT_TYPE_OBJECT			or 0x00004000
local COMBATLOG_OBJECT_TYPE_MASK			= COMBATLOG_OBJECT_TYPE_MASK			or 0x0000FC00

-- Special cases (non-exclusive)
local COMBATLOG_OBJECT_TARGET				= COMBATLOG_OBJECT_TARGET				or 0x00010000
local COMBATLOG_OBJECT_FOCUS				= COMBATLOG_OBJECT_FOCUS				or 0x00020000
local COMBATLOG_OBJECT_MAINTANK				= COMBATLOG_OBJECT_MAINTANK				or 0x00040000
local COMBATLOG_OBJECT_MAINASSIST			= COMBATLOG_OBJECT_MAINASSIST			or 0x00080000
local COMBATLOG_OBJECT_RAIDTARGET1			= COMBATLOG_OBJECT_RAIDTARGET1			or 0x00100000
local COMBATLOG_OBJECT_RAIDTARGET2			= COMBATLOG_OBJECT_RAIDTARGET2			or 0x00200000
local COMBATLOG_OBJECT_RAIDTARGET3			= COMBATLOG_OBJECT_RAIDTARGET3			or 0x00400000
local COMBATLOG_OBJECT_RAIDTARGET4			= COMBATLOG_OBJECT_RAIDTARGET4			or 0x00800000
local COMBATLOG_OBJECT_RAIDTARGET5			= COMBATLOG_OBJECT_RAIDTARGET5			or 0x01000000
local COMBATLOG_OBJECT_RAIDTARGET6			= COMBATLOG_OBJECT_RAIDTARGET6			or 0x02000000
local COMBATLOG_OBJECT_RAIDTARGET7			= COMBATLOG_OBJECT_RAIDTARGET7			or 0x04000000
local COMBATLOG_OBJECT_RAIDTARGET8			= COMBATLOG_OBJECT_RAIDTARGET8			or 0x08000000
local COMBATLOG_OBJECT_NONE					= COMBATLOG_OBJECT_NONE					or 0x80000000
local COMBATLOG_OBJECT_SPECIAL_MASK			= COMBATLOG_OBJECT_SPECIAL_MASK			or 0xFFFF0000

local LIB_FILTER_RAIDTARGET	= bit_bor(
	COMBATLOG_OBJECT_RAIDTARGET1, COMBATLOG_OBJECT_RAIDTARGET2, COMBATLOG_OBJECT_RAIDTARGET3, COMBATLOG_OBJECT_RAIDTARGET4,
	COMBATLOG_OBJECT_RAIDTARGET5, COMBATLOG_OBJECT_RAIDTARGET6, COMBATLOG_OBJECT_RAIDTARGET7, COMBATLOG_OBJECT_RAIDTARGET8
)
local LIB_FILTER_ME = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER
)
local LIB_FILTER_MY_PET = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PET
						)
local LIB_FILTER_PARTY = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_PARTY)
local LIB_FILTER_RAID  = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_RAID)
local LIB_FILTER_GROUP = bit_bor(LIB_FILTER_PARTY, LIB_FILTER_RAID)

local HotTickTimeId={
	[746]=1, -- First Aid (rank 1)
	[1159]=1,
	[3267]=1,
	[3268]=1,
	[7926]=1,
	[7927]=1,
	[23569]=1,
	[24412]=1,
	[10838]=1,
	[10839]=1,
	[23568]=1,
	[24413]=1,
	[18608]=1,
	[18610]=1,
	[23567]=1,
	[23696]=1,
	[24414]=1,
	[27030]=1,
	[27031]=1, -- First Aid (rank 12)
	[33763]=1, -- Lifebloom (rank 1) no other ranks
}

local DotTickTimeId={
	-- Mage Ticks
	[133]=2, -- Fireball (rank 1)
	[143]=2,
	[145]=2,
	[3140]=2,
	[8400]=2,
	[8401]=2,
	[8402]=2,
	[10148]=2,
	[10149]=2,
	[10150]=2,
	[10151]=2,
	[25306]=2,
	[27070]=2,
	[38692]=2, -- Fireball (rank 14)
	[11119]=2, -- Ignite (rank 1)
	[11120]=2,
	[12846]=2,
	[12847]=2,
	[12848]=2, -- Ignite (rank 5)
	[15407]=1, -- Mind Flay (rank 1)
	[17311]=1,
	[17312]=1,
	[17313]=1,
	[17314]=1,
	[18807]=1,
	[25387]=1, -- Mind Flay (rank 7)
	[980]=2, -- Curse of Agony (rank 1)
	[1014]=2,
	[6217]=2,
	[11711]=2,
	[11712]=2,
	[11713]=2,
	[27218]=2, -- Curse of Agony (rank 7)
	[603]=60, -- Curse of Doom (rank 1)
	[30910]=60, -- Curse of Doom (rank 2)
	[689]=1, -- Drain Life (rank 1) Elsia: According to wowhead it's 1. Which makes sense compared to Mind Flay...
	[699]=1,
	[709]=1,
	[7651]=1,
	[11699]=1,
	[11700]=1,
	[27219]=1,
	[27220]=1, -- Drain Life (rank 8)
	[755]=1, -- Health Funnel (rank 1)
	[3698]=1,
	[3699]=1,
	[3700]=1,
	[11693]=1,
	[11694]=1,
	[11695]=1,
	[27259]=1, -- Health Funnel (rank 8)
	[1949]=1, -- Hellfire (rank 1)
	[11683]=1,
	[11684]=1,
	[27213]=1, -- Hellfire (rank 4)
}


local CCId={
	[118]=true, -- Polymorph (rank 1)
	[12824]=true, -- Polymorph (rank 2)
	[12825]=true, -- Polymorph (rank 3)
	[12826]=true, -- Polymorph (rank 4)
	[28272]=true, -- Polymorph (rank 1:pig)
	[28271]=true, -- Polymorph (rank 1:turtle)
	[9484]=true, -- Shackle Undead (rank 1)
	[9485]=true, -- Shackle Undead (rank 2)
	[10955]=true, -- Shackle Undead (rank 3)
	[3355]=true, -- Freezing Trap Effect (rank 1)
	[14308]=true, -- Freezing Trap Effect (rank 2)
	[14309]=true, -- Freezing Trap Effect (rank 3)
	[2637]=true, -- Hibernate (rank 1)
	[18657]=true, -- Hibernate (rank 2)
	[18658]=true, -- Hibernate (rank 3)
	[6770]=true, -- Sap (rank 1)
	[2070]=true, -- Sap (rank 2)
	[11297]=true, -- Sap (rank 3)
	[6358]=true, -- Seduction (succubus)
}
	
--[[local HealBuffId={
	[33778]=true, -- Lifebloom "bloom" heal
	--[379]=true, -- Earthshield "tick" heal
}]]

local LifebloomId = 33763
local LifebloomHealId = 33778
local EarthShieldTickId = 379

local EarthShieldId = {
	[974]=true, -- Earth Shield (rank 1)
	[32593]=true, -- Earth Shield (rank 2)
	[32594]=true, -- Earth Shield (rank 3)
}


	
local PrayerOfMendingCastId = 33076 -- Prayer of Mending (rank 1)
local PrayerOfMendingAuraId = 41635 -- Prayer of Mending (when Aura is applied)
local PrayerOfMendingHealId = 33110 -- Prayer of Mending (when healing)

local RessesId={
	[2008]=true, -- Ancestral Spirit (Rank 1)
	[20609]=true, --Ancestral Spirit (Rank 2)
	[20610]=true, --Ancestral Spirit (Rank 3)
	[20776]=true, --Ancestral Spirit (Rank 4)
	[20777]=true, --Ancestral Spirit (Rank 5)
	[2006]=true, -- Resurrection (Rank 1)
	[2010]=true, -- Resurrection (Rank 2)
	[10880]=true, -- Resurrection (Rank 3)
	[10881]=true, -- Resurrection (Rank 4)
	[20770]=true, -- Resurrection (Rank 5)
	[25435]=true, -- Resurrection (Rank 6)
	[20484]=true, -- Rebirth (Rank 1)
	[20739]=true, -- Rebirth (Rank 2)
	[20742]=true, -- Rebirth (Rank 3)
	[20747]=true, -- Rebirth (Rank 4)
	[20748]=true, -- Rebirth (Rank 5)
	[26994]=true, -- Rebirth (Rank 6)
	[7328]=true, -- Redemption (Rank 1)
	[10322]=true, -- Redemption (Rank 2)
	[10324]=true, -- Redemption (Rank 3)
	[20772]=true, -- Redemption (Rank 4)
	[20773]=true, -- Redemption (Rank 5)
}
	
-- Base Events: SWING  These events relate to melee swings, commonly called White Damage. RANGE  These events relate to hunters shooting their bow or a warlock shooting their wand. SPELL  These events relate to spells and abilities. SPELL_CAST  These events relate to spells starting and failing. SPELL_AURA  These events relate to buffs and debuffs. SPELL_PERIODIC  These events relate to HoT, DoTs and similar effects. DAMAGE_SHIELD  These events relate to damage shields, such as Thorns ENCHANT  These events relate to temporary and permanent item buffs. ENVIRONMENTAL  This is any damage done by the world. Fires, Lava, Falling, etc.
-- Suffixes: _DAMAGE  If the event resulted in damage, here it is. _MISSED - If the event resulted in failure, such as missing, resisting or being blocked. _HEAL  If the event resulted in a heal. _ENERGIZE  If the event resulted in a power restoration. _LEECH  If the event transferred health or power. _DRAIN  If the event reduces power, but did not transfer it.
-- Special Events: PARTY_KILL  Fired when you or a party member kills something. UNIT_DIED  Fired when any nearby unit dies. 

local SPELLSCHOOL_PHYSICAL = 1
local SPELLSCHOOL_HOLY = 2
local SPELLSCHOOL_FIRE = 4
local SPELLSCHOOL_NATURE = 8
local SPELLSCHOOL_FROST = 16
local SPELLSCHOOL_SHADOW = 32
local SPELLSCHOOL_ARCANE = 64

Recount.SpellSchoolName = {
	[SPELLSCHOOL_PHYSICAL] = "Physical",
	[SPELLSCHOOL_HOLY] = "Holy",
	[SPELLSCHOOL_FIRE] = "Fire",
	[SPELLSCHOOL_NATURE] = "Nature",
	[SPELLSCHOOL_FROST] = "Frost",
	[SPELLSCHOOL_SHADOW] = "Shadow",
	[SPELLSCHOOL_ARCANE] = "Arcane",
}

local POWERTYPE_MANA = 0
local POWERTYPE_RAGE = 1
local POWERTYPE_FOCUS = 2
local POWERTYPE_ENERGY = 3
local POWERTYPE_HAPPINESS = 4;
local POWERTYPE_RUNES = 5;
local POWERTYPE_RUNIC_POWER = 6;

Recount.PowerTypeName = {
	[POWERTYPE_MANA] = "Mana",
	[POWERTYPE_RAGE] = "Rage",
	[POWERTYPE_ENERGY] = "Energy",
	[POWERTYPE_FOCUS] = "Focus",
	[POWERTYPE_HAPPINESS] = "Happiness",
	[POWERTYPE_RUNES] = "Runes",
	[POWERTYPE_RUNIC_POWER] = "Runic Power",	
}

function Recount:MatchGUID(nName,nGUID,nFlags)
	if not Recount.PlayerName or not Recount.PlayerGUID then
		if bit_band(nFlags, LIB_FILTER_ME) == LIB_FILTER_ME then
			Recount.PlayerName = nName
			Recount.GUID = nGUID
			return
		end
	end

	if bit_band(nFlags,LIB_FILTER_MY_PET) == LIB_FILTER_MY_PET then
		if not Recount.PlayerPet or not Recount.PlayerPetGUID or nGUID~=Recount.PlayerPetGUID then
			--Recount:Print("NewPet detected: "..nName.." "..nGUID.."("..(Recount.PlayerPetGUID or "nil")..")")
			Recount.PlayerPetGUID = nGUID
			if Recount.PlayerPet ~= nName then
				Recount.PlayerPet = nName
			end
			return
		end
	end
end

if tocversion == 30000 then
function Recount:SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,amount, overkill,school, resisted, blocked, absorbed, critical, glancing, crushing)
	Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,0, L["Melee"], SPELLSCHOOL_PHYSICAL, amount, overkill,school, resisted, blocked, absorbed, critical, glancing, crushing)
end
else
function Recount:SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
	Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,0, L["Melee"], SPELLSCHOOL_PHYSICAL, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
end
end

function Recount:SpellBuildingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
-- Ignoring these for now
end

if tocversion == 30000 then
function Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)

--	amount = amount - overkill -- Taking out overdamage on killing blows

	local HitType=L["Hit"]
	if critical then
		HitType=L["Crit"]
	end
	if eventtype == "SPELL_PERIODIC_DAMAGE" then
		HitType=L["Tick"]
		spellName = spellName .." ("..L["DoT"]..")"
	end
	if eventtype == "DAMAGE_SPLIT" then
		HitType=L["Split"]
	end
	if crushing then
		HitType=L["Crushing"]
	end
	if glancing	then
		HitType=L["Glancing"]
	end
--[[	if blocked then
		HitType="Block"
	end
	if absorbed then
		HitType="Absorbed"
	end--]]
	if eventtype == "RANGE_DAMAGE" then spellSchool = school end

	Recount:AddDamageData(srcName, dstName, spellName, Recount.SpellSchoolName[spellSchool], HitType, amount, resisted, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed)
end
else
function Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)

	local HitType=L["Hit"]
	if critical then
		HitType=L["Crit"]
	end
	if eventtype == "SPELL_PERIODIC_DAMAGE" then
		HitType=L["Tick"]
		spellName = spellName .." ("..L["DoT"]..")"
	end
	if eventtype == "DAMAGE_SPLIT" then
		HitType=L["Split"]
	end
	if crushing then
		HitType=L["Crushing"]
	end
	if glancing	then
		HitType=L["Glancing"]
	end
--[[	if blocked then
		HitType="Block"
	end
	if absorbed then
		HitType="Absorbed"
	end--]]
	if eventtype == "RANGE_DAMAGE" then spellSchool = school end

	Recount:AddDamageData(srcName, dstName, spellName, Recount.SpellSchoolName[spellSchool], HitType, amount, resisted, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed)
end
end

if tocversion == 30000 then
function Recount:EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,enviromentalType, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)

	local HitType = L["Hit"]
	if critical then
		HitType=L["Crit"]
	end
	if crushing then
		HitType=L["Crushing"]
	end
	if glancing	then
		HitType=L["Glancing"]
	end
	--[[if blocked then
		HitType="Block"
	end
	if absorbed then
		HitType="Absorbed"
	end--]]

	Recount:AddDamageData("Environment", dstName, Recount:FixCaps(enviromentalType), Recount.SpellSchoolName[school], HitType, amount, resisted, srcGUID, 0, dstGUID, dstFlags, spellId, blocked, absorbed)
end
else
function Recount:EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,enviromentalType, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)

	local HitType = L["Hit"]
	if critical then
		HitType=L["Crit"]
	end
	if crushing then
		HitType=L["Crushing"]
	end
	if glancing	then
		HitType=L["Glancing"]
	end
	--[[if blocked then
		HitType="Block"
	end
	if absorbed then
		HitType="Absorbed"
	end--]]

	Recount:AddDamageData("Environment", dstName, Recount:FixCaps(enviromentalType), Recount.SpellSchoolName[school], HitType, amount, resisted, srcGUID, 0, dstGUID, dstFlags, spellId, blocked, absorbed)
end
end

function Recount:FixCaps(capsstr)
	if type(capsstr)=="string" then
		return string.upper(string.sub(capsstr,1,1))..string.lower(string.sub(capsstr,2))
	else
		return nil
	end
end

if tocversion == 30000 then
function Recount:SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType, missAmount)
	
	Recount:AddDamageData(srcName, dstName, L["Melee"], nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
end

function Recount:SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType, missAmount)

	Recount:AddDamageData(srcName, dstName, spellName, nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
end
else
function Recount:SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,missType)
	
	Recount:AddDamageData(srcName, dstName, L["Melee"], nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
end

function Recount:SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)

	Recount:AddDamageData(srcName, dstName, spellName, nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
end
end

function Recount:SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overheal,critical)

	 if overheal == 1 and not critical then -- Elsia: Heuristic for detection 2.4 format. Fails if overheal is exactly 1 and the heal was not a crit (WotLK).
	    critical = overheal
	    overheal = nil
	end

	local healtype="Hit"
	if critical then
		healtype="Crit"
	end

	if eventtype == "SPELL_PERIODIC_HEAL" then
		healtype=L["Tick"]
		-- Not activated yet: spellName=spellName.." ("..L["HoT"]..")"
	end

	Recount:AddHealData(srcName, dstName, spellName, healtype, amount,overheal, srcGUID,srcFlags,dstGUID,dstFlags,spellId)-- Elsia: Overheal missing!!!
end

function Recount:SpellEnergize(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, powerType)

	Recount:AddGain(dstName, srcName, spellName, amount, Recount.PowerTypeName[powerType], dstGUID, dstFlags, srcGUID, srcFlags, spellId)
end

local extraattacks

function Recount:SpellExtraAttacks(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount)
--[[	source = Recount.curr_srcName
	victim = Recount.curr_dstName

	local healtype="Hit"

	Recount:Print(Recount.curr_type.." "..spellName.." "..amount)
	Recount:AddDamageData(source, victim, spellName, Recount.SpellSchoolName[spellSchool], HitType, amount)--]]

	-- Elsia: Don't have use for extra attacks currently, amount is number of extra attacks it seems from combat log traces.
	
	extraattacks = extraattacks or {}
	if extraattacks[srcName] then
		Recount:DPrint("Double proc: "..spellName.." "..extraattacks[srcName].spellName)
	else
		extraattacks[srcName] = {}
		extraattacks[srcName].spellName = spellName
		extraattacks[srcName].amount = amount
		extraattacks[srcName].proctime = GetTime()
	end
end

function Recount:SpellInterrupt(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)

	if not spellName   then
		spellName = "Melee"
	end
	local ability = extraSpellName .. " (" .. spellName .. ")"
	Recount:AddInterruptData(srcName, dstName, ability, srcGUID, srcFlags, dstGUID, dstFlags, extraSpellId) -- Elsia: Keep both interrupting spell and interrupted spell
end

function Recount:SpellDrainLeech(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, powerType, extraAmount)

-- Currently unused.
end

function Recount:SpellAuraBroken(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)
	if not spellName then
		spellName = "Melee"
	end
	
	local ability
	if extraSpellName then 
	        ability = spellName .. " (" .. extraSpellName .. ")"
	else
		ability = spellName .." (Melee)"
	end

	if CCId[spellId] then
		Recount:AddCCBreaker(srcName, dstName, ability, srcGUID, srcFlags, dstGUID, dstFlags, extraSpellId)
	end
end

function Recount:SpellAuraDispelledStolen(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)

	if eventtype == "SPELL_DISPEL_FAILED" then
		return -- Not covering failures.
	end

	if not spellName then
		spellName = "Melee"
	end
	local ability = extraSpellName .. " (" .. spellName .. ")"

	Recount:AddDispelData(srcName, dstName, ability, srcGUID, srcFlags, dstGUID, dstFlags, extraSpellId)
end

function Recount:SpellAuraAppliedRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType)
	
	if eventtype == "SPELL_AURA_APPLIED" then
--		if spellName==PrayerOfMending then
		if spellId==PrayerOfMendingAuraId then
			Recount.HealBuffs.POM_Gained(dstName)
		end
	elseif eventtype == "SPELL_AURA_REMOVED" then
		if EarthShieldId[spellId] then
			Recount:RemoveEarthShieldSource(dstName,dstGUID,dstFlags)
		end
	end
end

function Recount:SpellAuraAppliedRemovedDose(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType, amount)
-- Not sure yet how to handle this

end

function Recount:SpellResurrect(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)
			Recount:AddRes(srcName, dstName, spellName, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
end

function Recount:SpellCastStartSuccess(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)

	if eventtype == "SPELL_CAST_SUCCESS" then
		
--		if spellName==PrayerOfMending then
		if spellId==PrayerOfMendingCastId then
			Recount.HealBuffs.POM_Casted(srcName,dstName,srcGUID,srcFlags)
--		elseif Resses[spellName] and  victim then
		elseif RessesId[spellId] and  dstName then
			Recount:AddRes(srcName, dstName, spellName, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
		elseif EarthShieldId[spellId] then
			Recount:AddEarthShieldSource(srcName, dstName, srcGUID, srcFlags, dstGUID, dstFlags)
		elseif LifebloomId == spellId then
			Recount.HealBuffs.LB_Casted(srcName,dstName,srcGUID,srcFlags)
			--Recount:Print("Eek5")
			--local missType = "Hit"
			--Recount:Print(spellName.." "..Recount.SpellSchoolName[spellSchool].." "..victim)
			--Recount:AddDamageData(srcName, dstName, spellName, Recount.SpellSchoolName[spellSchool], Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
			-- Elsia: Currently disabled adding success casts to damage details. 
		end
		
	elseif eventtype == "SPELL_INSTAKILL" then

		--Recount:Print(Recount.curr_type .." "..source.." "..victim)
		Recount:AddDeathData(srcName, dstName, nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
	end
end

-- Note: GetSpellLink(id) gets spell name from ID.
--  GetSpellInfo(id)

function Recount:SpellCastFailed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, failedType)
-- Not sure yet how to handle this, are these interrupts?
end

function Recount:EnchantAppliedRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellName, itemId, itemName)
-- Not sure yet how to handle this, 
end

function Recount:PartyKill(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
	--Recount:AddDeathData(srcName , dstName, nil, srcGUID, srcFlags, dstGUID, dstFlags, nil)
-- Could be killing blow tracker
end

function Recount:UnitDied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
	Recount:AddDeathData(nil , dstName, nil, srcGUID, srcFlags, dstGUID, dstFlags, nil)
end

function Recount:SpellSummon(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)
	Recount:AddPetCombatant(dstGUID,dstName,dstFlags,srcGUID,srcName,srcFlags)
end

function Recount:SpellCreate(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)
-- Elsia: We do nothing for these yet.
end

local EventParse =
{
	["SWING_DAMAGE"] = Recount.SwingDamage, -- Elsia: Melee swing damage
	["RANGE_DAMAGE"] = Recount.SpellDamage, -- Elsia: Ranged and spell damage types
	["SPELL_DAMAGE"] = Recount.SpellDamage,
	["SPELL_PERIODIC_DAMAGE"] = Recount.SpellDamage,
	["DAMAGE_SHIELD"] = Recount.SpellDamage,
	["DAMAGE_SPLIT"] = Recount.SpellDamage,
	["ENVIRONMENTAL_DAMAGE"] = Recount.EnvironmentalDamage, -- Elsia: Environmental damage
	["SWING_MISSED"] = Recount.SwingMissed, -- Elsia: Misses
	["RANGE_MISSED"] = Recount.SpellMissed,
	["SPELL_MISSED"] = Recount.SpellMissed,
	["SPELL_PERIODIC_MISSED"] = Recount.SpellMissed,
	["DAMAGE_SHIELD_MISSED"] = Recount.SpellMissed,
	["SPELL_HEAL"] = Recount.SpellHeal, -- Elsia: heals
	["SPELL_PERIODIC_HEAL"] = Recount.SpellHeal,
	["SPELL_ENERGIZE"] = Recount.SpellEnergize, -- Elsia: Energize
	["SPELL_PERIODIC_ENERGIZE"] = Recount.SpellEnergize,
	["SPELL_EXTRA_ATTACKS"] = Recount.SpellExtraAttacks, -- Elsia: Extra attacks
	["SPELL_INTERRUPT"] = Recount.SpellInterrupt, -- Elsia: Interrupts
	["SPELL_DRAIN"] = Recount.SpellDrainLeech, -- Elsia: Drains and leeches.
	["SPELL_LEECH"] = Recount.SpellDrainLeech,
	["SPELL_PERIODIC_DRAIN"] = Recount.SpellDrainLeech,
	["SPELL_PERIODIC_LEECH"] = Recount.SpellDrainLeech,
	["SPELL_DISPEL_FAILED"] = Recount.SpellAuraDispelledStolen, -- Elsia: Failed dispell
	["SPELL_AURA_DISPELLED"] = Recount.SpellAuraDispelledStolen, -- Removed with 2.4.3
	["SPELL_AURA_STOLEN"] = Recount.SpellAuraDispelledStolen, -- Removed with 2.4.3
	["SPELL_AURA_APPLIED"] = Recount.SpellAuraAppliedRemoved, -- Elsia: Auras
	["SPELL_AURA_REMOVED"] = Recount.SpellAuraAppliedRemoved,
	["SPELL_AURA_APPLIED_DOSE"] = Recount.SpellAuraAppliedRemovedDose, -- Elsia: Aura doses
	["SPELL_AURA_REMOVED_DOSE"] = Recount.SpellAuraAppliedRemovedDose,
	["SPELL_CAST_START"] = Recount.SpellCastStartSuccess, -- Elsia: Spell casts
	["SPELL_CAST_SUCCESS"] = Recount.SpellCastStartSuccess,
	["SPELL_INSTAKILL"] = Recount.SpellCastStartSuccess,
	["SPELL_DURABILITY_DAMAGE"] = Recount.SpellCastStartSuccess,
	["SPELL_DURABILITY_DAMAGE_ALL"] = Recount.SpellCastStartSuccess,
	["SPELL_CAST_FAILED"] = Recount.SpellCastFailed, -- Elsia: Spell aborts/fails
	["ENCHANT_APPLIED"] = Recount.EnchantAppliedRemoved, -- Elsia: Enchants
	["ENCHANT_REMOVED"] = Recount.EnchantAppliedRemoved,
	["PARTY_KILL"] = Recount.PartyKill, -- Elsia: Party killing blow
	["UNIT_DIED"] = Recount.UnitDied, -- Elsia: Unit died
	["UNIT_DESTROYED"] = Recount.UnitDied,
	["SPELL_SUMMON"] = Recount.SpellSummon, -- Elsia: Summons
	["SPELL_CREATE"] = Recount.SpellCreate, -- Elsia: Creations
	["SPELL_AURA_BROKEN"] = Recount.SpellAuraBroken, -- New with 2.4.3
	["SPELL_AURA_BROKEN_SPELL"] = Recount.SpellAuraBroken, -- New with 2.4.3
	["SPELL_AURA_REFRESH"] = Recount.SpellAuraAppliedRemoved, -- New with 2.4.3
	["SPELL_DISPEL"] = Recount.SpellAuraDispelledStolen, -- Post 2.4.3
	["SPELL_STOLEN"] = Recount.SpellAuraDispelledStolen, -- Post 2.4.3
	["SPELL_RESURRECT"] = Recount.SpellResurrect, -- Post WotLK
	["SPELL_BUILDING_DAMAGE"] = Recount.SpellBuildingDamage -- Post WotLK
}

function Recount:CheckRetentionFromFlags(nameFlags)

	if Recount.db.profile.Filters.Data["Grouped"] and bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 then
		return true -- Grouped
	elseif Recount.db.profile.Filters.Data["Self"] and bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_TYPE_PLAYER)==COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_TYPE_PLAYER then
		return true -- Self
	elseif Recount.db.profile.Filters.Data["Ungrouped"] and bit_band(nameFlags, COMBATLOG_OBJECT_TYPE_PLAYER+COMBATLOG_OBJECT_REACTION_FRIENDLY) ~= COMBATLOG_OBJECT_TYPE_PLAYER+COMBATLOG_OBJECT_REACTION_FRIENDLY then
		return true -- Ungrouped
	elseif Recount.db.profile.Filters.Data["Hostile"] and bit_band(nameFlags, COMBATLOG_OBJECT_CONTROL_PLAYER)~=0 then
		return true
	elseif (Recount.db.profile.Filters.Data["Trivial"] or Recount.db.profile.Filters.Data["Nontrivial"] or Recount.db.profile.Filters.Data["Boss"]) and bit_band(nameFlags, COMBATLOG_OBJECT_CONTROL_NPC)~=0 then
		return true
	elseif Recount.db.profile.Filters.Data["Pet"] and bit_band(nameFlags, COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 then
		if Recount.db.profile.Filters.Data["Self"] and bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_MINE)~=0 then
			return true
		elseif Recount.db.profile.Filters.Data["Grouped"] and  bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 then
			return true
		elseif Recount.db.profile.Filters.Data["Ungrouped"] and bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER+COMBATLOG_OBJECT_REACTION_FRIENDLY) == COMBATLOG_OBJECT_AFFILIATION_OUTSIDER+COMBATLOG_OBJECT_REACTION_FRIENDLY then
			return true
		end
	else
		return false
	end
end

local Blizzard_CombatLog_CurrentSettings
function Recount:CombatLogEvent(_,timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	if not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	if not Recount:CheckRetentionFromFlags(srcFlags) and not Recount:CheckRetentionFromFlags(dstFlags) then
		return
	end

	--Blizzard_CombatLog_CurrentSettings = _G.Blizzard_CombatLog_CurrentSettings or _G.Blizzard_CombatLog_Filters.filters[_G.Blizzard_CombatLog_Filters.currentFilter]
	--Recount.cleventtext = "" --_G.CombatLog_OnEvent(Blizzard_CombatLog_CurrentSettings, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	
	if srcName == nil then
		srcName = "No One"
	else
		Recount:MatchGUID(srcName,srcGUID,srcFlags)
	end
	if dstName == nil then
		dstName = "No One"
	else
		Recount:MatchGUID(dstName,dstGUID,dstFlags)
	end

	local parsefunc = EventParse[eventtype]
	
	if parsefunc then
		parsefunc(self, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	else
		Recount:Print("Unknown combat log event type: "..eventtype)
	end

	-- Elsia: Damage block
	-- Elsia: This is if-chain parsing. table lookup has shown to be much faster in experiments, especially because we use function calls here too. Leaving this here for documentation.
--[[	if eventtype == "SWING_DAMAGE" then
		Recount:SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "RANGE_DAMAGE" or eventtype == "SPELL_DAMAGE" or eventtype == "SPELL_PERIODIC_DAMAGE" or eventtype == "DAMAGE_SHIELD" or eventtype == "DAMAGE_SPLIT" then
		Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "ENVIRONMENTAL_DAMAGE" then
		Recount:EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SWING_MISSED" then -- Elsia: Missed block
		Recount:SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "RANGE_MISSED" or eventtype == "SPELL_MISSED" or eventtype == "SPELL_PERIODIC_MISSED" or eventtype == "DAMAGE_SHIELD_MISSED" then
		Recount:SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_HEAL" or eventtype == "SPELL_PERIODIC_HEAL" then -- Elsia: Heals
		Recount:SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_ENERGIZE" or eventtype == "SPELL_PERIODIC_ENERGIZE" then -- Elsia: Power gains
		Recount:SpellEnergize(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_EXTRA_ATTACKS" then
		Recount:SpellExtraAttacks(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_INTERRUPT" then
		Recount:SpellInterrupt(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_DRAIN" or eventtype == "SPELL_LEECH" or eventtype == "SPELL_PERIODIC_DRAIN" or eventtype == "SPELL_PERIODIC_LEECH" then -- Elsia: Drains & Leeches
		Recount:SpellDrainLeech(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_DISPEL_FAILED" or eventtype == "SPELL_AURA_DISPELLED" or eventtype == "SPELL_AURA_STOLEN" then -- Elsia: Failed dispell
		Recount:SpellAuraDispelledStolen(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_AURA_APPLIED" or eventtype == "SPELL_AURA_REMOVED" then
		Recount:SpellAuraAppliedRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_AURA_APPLIED_DOSE" or eventtype == "SPELL_AURA_REMOVED_DOSE" then
		Recount:SpellAuraAppliedRemovedDose(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_CAST_START" or eventtype == "SPELL_CAST_SUCCESS" or eventtype == "SPELL_INSTAKILL" or eventtype == "SPELL_DURABILITY_DAMAGE" or eventtype == "SPELL_DURABILITY_DAMAGE_ALL" then
		Recount:SpellCastStartSuccess(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_CAST_FAILED" then -- Elsia: Spell aborts/fails
		Recount:SpellCastFailed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "ENCHANT_APPLIED" or eventtype == "ENCHANT_REMOVED" then 
		Recount:EnchantAppliedRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "PARTY_KILL" then
		Recount:PartyKill(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
	elseif eventtype == "UNIT_DIED" or eventtype == "UNIT_DESTROYED" then
		Recount:UnitDied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
	elseif eventtype == "SPELL_SUMMON" then
		Recount:SpellSummon(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_CREATE" then
		Recount:SpellCreate(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	else
		Recount:Print("Unknown combat log event type: "..eventtype)
	end]]
end

function Recount:SetActive(who)
	if not who then return end

	who.LastActive=Recount.CurTime
end

function Recount:AddTimeEvent(who, onWho, ability, friendly)

	if not who then return end

	local Time=GetTime()
	who.LastAbility = who.LastAbility or 0
	local Adding=Time-who.LastAbility
	
	who.LastAbility=Time
	
	if Adding>3.5 then
		Adding=3.5
	end

	Adding=math.floor(100*Adding+0.5)/100

	Recount:AddOwnerPetLazySyncAmount(who,"ActiveTime", Adding)
	--Recount:AddSyncAmount(who,"ActiveTime", Adding)
	

	Recount:AddAmount(who,"ActiveTime",Adding)
	Recount:AddTableDataSum(who,"TimeSpent",onWho,ability,Adding)

	if friendly then
		Recount:AddAmount(who,"TimeHeal",Adding)
		Recount:AddTableDataSum(who,"TimeHealing",onWho,ability,Adding)
	else
		Recount:AddAmount(who,"TimeDamage",Adding)
		Recount:AddTableDataSum(who,"TimeDamaging",onWho,ability,Adding)
	end
end


--Only care about event tracking for those we want to track deaths for
function Recount:AddCurrentEvent(who, eventType, incoming, number, event)
	if not who then return end
	if Recount.db.profile.Filters.TrackDeaths[who.type] then
		who.LastEvents = who.LastEvents or {}
		who.LastEventTimes = who.LastEventTimes or {}
		who.LastEventType = who.LastEventType or {}
		who.LastEventIncoming = who.LastEventIncoming or {}
		who.NextEventNum = who.NextEventNum or 1
		who.LastEventTimes[who.NextEventNum]=GetTime()
		who.LastEventType[who.NextEventNum]=eventType
		who.LastEventIncoming[who.NextEventNum]=incoming
		who.LastEvents[who.NextEventNum]=event --(eventType or "").." "..(abiliy or "").." "..(number or "")

		if (not who.unit) or (UnitName(who.unit)~=who.Name) and who.UnitLockout<Recount.UnitLockout then
			who.unit=Recount:FindUnit(who.Name)
			who.UnitLockout=Recount.CurTime
		end
		
		if who.unit then
			if UnitHealthMax(who.unit)~=100 then
				who.LastEventHealth = who.LastEventHealth or {}
				who.LastEventHealth[who.NextEventNum]=UnitHealth(who.unit).." ("..math.floor(100*UnitHealth(who.unit)/UnitHealthMax(who.unit)).."%)"
				if number then
					who.LastEventNum = who.LastEventNum or {}
					who.LastEventNum[who.NextEventNum]=100*number/UnitHealthMax(who.unit)
				elseif who.LastEventNum then
					who.LastEventNum[who.NextEventNum]=nil
				end
			else
				who.LastEventHealth = who.LastEventHealth or {}
				who.LastEventHealth[who.NextEventNum]=UnitHealth(who.unit).."%"
				if who.LastEventNum then
					who.LastEventNum[who.NextEventNum]=nil
				end
			end
			who.LastEventHealthNum = who.LastEventHealthNum or {}
			who.LastEventHealthNum[who.NextEventNum]=100*UnitHealth(who.unit)/UnitHealthMax(who.unit)
		else
			who.LastEventHealth = who.LastEventHealth or {}
			who.LastEventHealthNum = who.LastEventHealthNum or {}
			who.LastEventHealth[who.NextEventNum]="???"
			who.LastEventHealthNum[who.NextEventNum]=0
			if who.LastEventNum then
				who.LastEventNum[who.NextEventNum]=nil
			end
		end		
		
		who.NextEventNum=who.NextEventNum+1

		if who.NextEventNum>Recount.db.profile.MessagesTracked then
			who.NextEventNum=who.NextEventNum-Recount.db.profile.MessagesTracked
		end
	end
end

--Functions for adding data 

function Recount:AddAmount(who,datatype,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	Recount.NewData = true -- Inform MainWindow that we got new data stored.

	--We add the data to both overall & current fight data
	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or 0
	who.Fights.OverallData[datatype]=who.Fights.OverallData[datatype]+amount
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or 0
	who.Fights.CurrentFightData[datatype]=who.Fights.CurrentFightData[datatype]+amount

	--Now add the time data
--	if who.TimeWindows[datatype] then
	who.TimeWindows = who.TimeWindows or {}
	who.TimeWindows[datatype] = who.TimeWindows[datatype] or {}
	who.TimeWindows[datatype][Recount.TimeStep] = who.TimeWindows[datatype][Recount.TimeStep] or 0
	who.TimeWindows[datatype][Recount.TimeStep]=who.TimeWindows[datatype][Recount.TimeStep]+amount

	who.TimeLast = who.TimeLast or {}
	who.TimeLast[datatype]=Recount.CurTime
	who.TimeLast["OVERALL"]=Recount.CurTime
--	end
end

--Meant for like elemental data and this type isn't expected to be initialized 
function Recount:AddAmount2(who,datatype,secondary,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type]  or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end
	if not secondary then
		Recount:DPrint("Empty secondary: "..datatype)
		return
	end
	
	--We add the data to both overall & current fight data
	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	who.Fights.OverallData[datatype][secondary]=(who.Fights.OverallData[datatype][secondary] or 0)+amount
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	who.Fights.CurrentFightData[datatype][secondary]=(who.Fights.CurrentFightData[datatype][secondary] or 0)+amount
end

--Two Different Types of table functions
--First type tracks min/max & count while the other only counts the total sum in the count column
function Recount:AddTableDataStats(who,datatype,secondary,detailtype,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	local CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end	

	CurTable.count=CurTable.count+1
	CurTable.amount=CurTable.amount+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	local Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
	Details.amount=Details.amount+amount

	if Details.max then
		if amount>Details.max then
			Details.max=amount
		elseif amount<Details.min then
			Details.min=amount
		end
	else--If no max has been set time to initialize
		Details.max=amount
		Details.min=amount
	end
	
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	--Now for the current fight data
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	

	CurTable.count=CurTable.count+1
	CurTable.amount=CurTable.amount+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
	Details.amount=Details.amount+amount

	if Details.max then
		if amount>Details.max then
			Details.max=amount
		elseif amount<Details.min then
			Details.min=amount
		end
	else--If no max has been set time to initialize
		Details.max=amount
		Details.min=amount
	end
end
local first=false
function Recount:CorrectTableData(who,datatype,secondary,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type]   or Recount.db.profile.GlobalDataCollect == false  or not Recount.CurrentDataCollect then
		return
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	local CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end	
--[[	if not CurTable.count and not first then
		Recount:Print(datatype,secondary,amount)
		Recount:Print(debugstack())
	end]]
	if CurTable.count then
		CurTable.count=CurTable.count-1
	end
	CurTable.amount=CurTable.amount-amount

	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	--Now for the current fight data
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	
	if CurTable.count then
		CurTable.count=CurTable.count-1
	end
	CurTable.amount=CurTable.amount-amount
end



function Recount:AddTableDataStatsNoAmount(who,datatype,secondary,detailtype)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	local CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end


	
	CurTable.count=CurTable.count+1

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	local Details=CurTable.Details[detailtype]

	Details.count=Details.count+1

	--Now for the current fight data
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end



	CurTable.count=CurTable.count+1

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
end

function Recount:AddTableDataSum(who,datatype,secondary,detailtype,amount)
	if not who then return end
	if (not Recount.db.profile.Filters.Data[who.type]) or not Recount.db.profile.GlobalDataCollect  or not Recount.CurrentDataCollect then
		--Have to make sure this won't be used by something that needs to have data recorded for it
		
		if Recount.db2.combatants[secondary] then
			if not Recount.db.profile.Filters.Data[Recount.db2.combatants[secondary].type] or Recount.db.profile.GlobalDataCollect == false then
				return
			end
		else		
			return
		end
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	
	local CurTable=who.Fights.OverallData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	CurTable.amount=(CurTable.amount or 0)+amount

	if detailtype == nil then
		Recount:DPrint("DEBUG at: ".. (who or "nil").." "..(datatype or "nil").." ".. (secondary or "nil"))
	end

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
	end

	local Details=CurTable.Details[detailtype]
	Details.count=Details.count+amount

	--Now for the current fight data
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	CurTable.amount=(CurTable.amount or 0)+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
	end

	Details=CurTable.Details[detailtype]

	Details.count=Details.count+amount
end

-- Elsia: Borrowed shamelessly from Threat-2.0
function Recount:NPCID(guid)
	return tonumber(guid:sub(-12,-7),16)
end

function Recount:DetectPet(name, nGUID, nFlags)
	local isspecial=false
	local ownerID
	local owner
	local petName
	
	petName, owner = name:match("(.-) <(.*)>")
	
	if not petName then
		petName = name
	else
		name = petName
	end
	
	if nFlags and bit_band(nFlags, COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 then
		if bit_band(nFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~=0 then
			isspecial=true
			name = name.." <"..Recount.PlayerName..">"
			owner = Recount.PlayerName -- Elsia: Fix up so that owner properly gets set
			ownerID = Recount.PlayerGUID
			if bit_band(nFlags, COMBATLOG_OBJECT_TYPE_PET) ~=0 then
				Recount.PlayerPetGUID = nGUID
			else -- Guardians
				Recount.LatestGuardian = Recount.LatestGuardian + 1
				Recount.GuardiansGUIDs[Recount.LatestGuardian]=nGUID
				if Recount.LatestGuardian > 6 then -- Elsia: Max guardians set to 5 for now
					Recount.LatestGuardian = 0
				end
--[[				if Recount.NPCID then
					local npcid = Recount:NPCID(nGUID) -- Elsia: 15438 and 15352 are mobids of shaman's greater elementals
					if (npcid == 15438 or npcid == 15352) and (not Recount.db2.combatants[name] or Recount.db2.combatants[name].GUID ~= nGUID) then -- Elsia: Only Sync new elementals
						Recount:AnnouncePetGUID(owner,petName,nGUID)
					end
				end]]
			end
		elseif bit_band(nFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 then
--[[				if bit_band(nFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~=0 and Recount.NPCID then
			local npcid = Recount:NPCID(nGUID)
				if npcid == 15438 or npcid == 15352 then
					local elemname = Recount:ActiveElementalName(nGUID)
					if elemname then
						owner = elemname:match("<(.-)>")
						if Recount.db2.combatants[owner] then
							ownerID = Recount.db2.combatants[owner].GUID
						end
						return elemname, owner, ownerID, isspecial
					end
				end
			end]]
			if nFlags and bit_band(nFlags, COMBATLOG_OBJECT_TYPE_PET)~=0 then
				owner, ownerID = Recount:FindOwnerPetFromGUID(name,nGUID)
			
				if owner == nil then
					owner,ownerID=Recount.Pets:IsUniquePet(name,nGUID,nFlags)
				end
				if owner then
					name=name.." <"..owner..">"
				else
					--Recount:Print("NoOwner")
				end
			elseif nFlags and bit_band(nFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 then
				owner = Recount:GetGuardianOwnerByGUID(nGUID)
				ownerID = owner and Recount.db2.combatants[owner] and Recount.db2.combatants[owner].GUID
				if owner then name = name.." <"..owner..">" end
				--Recount:DPrint("Party guardian: "..name.." "..(nGUID or "nil").." "..(owner or "nil").." "..(ownerID or "nil"))
			end
		end
	end
	return name, owner, ownerID, isspecial
end

function Recount:RemoveEarthShieldSource(victim, dstGUID, dstFlags)

	local SpecialEvent=false
	local owner, ownerID
	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)
	local victimData=Recount.db2.combatants[victim]
	if victimData then

		victimData.EarthShieldSource = nil
		victimData.EarthShieldSourceGUID = nil
		victimData.EarthShieldSourceFlags = nil
	end
end

--[[function Recount:AddLifebloomSource(source, victim, srcGUID, srcFlags, dstGUID, dstFlags)
	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
	end
		
	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID)
	end

	if source == victim then
		--Recount:Print("self-shields: "..source)
		return -- Elsia: No need to store anything for self-blooming.
	end
	
	local victimData=Recount.db2.combatants[victim]

	--Recount:Print("shields: "..victim.." by "..source)
	victimData.EarthShieldSource = source
	victimData.EarthShieldSourceGUID = srcGUID
	victimData.EarthShieldSourceFlags = srcFlags

	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end]]


function Recount:AddEarthShieldSource(source, victim, srcGUID, srcFlags, dstGUID, dstFlags)
	local SpecialEvent=false
	local owner, ownerID
	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
	end
		
	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID)
	end

	if source == victim then
		--Recount:Print("self-shields: "..source)
		return -- Elsia: No need to store anything for self-shielding.
	end
	
	local victimData=Recount.db2.combatants[victim]

	--Recount:Print("shields: "..victim.." by "..source)
	victimData.EarthShieldSource = source
	victimData.EarthShieldSourceGUID = srcGUID
	victimData.EarthShieldSourceFlags = srcFlags

	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

function Recount:AddDamageData(source, victim, ability, element, hittype, damage, resist, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed)
	--See if both the source & victim are in the tables
	local SpecialEvent=false
	local owner, ownerID

	--Recount:Print((source or "nil") .." "..(victim or "nil").." "..(ability or "nil").." "..(element or "nil"))
	
	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
	end
		
	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID)
	end

	if not Recount:TestRetention(source) and not Recount:TestRetention(victim) then
		Recount:CheckRetention(source)
		Recount:CheckRetention(victim)
		return
	end
	
	local sourceData=Recount.db2.combatants[source]
	local victimData=Recount.db2.combatants[victim]

	if not sourceData then
		Recount:DPrint("Missing source: "..source)
		return
	end
	
	if not victimData then
		Recount:DPrint("Missing target: "..victim)
		return
	end

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	if extraattacks and extraattacks[source] then
		if extraattacks[source].proctime < GetTime()-5 then -- This is an outdated proc of which we never saw damage contributions. Timeout at 5 seconds
			extraattacks[source] = nil
		else
			ability = ability .. " ("..extraattacks[source].spellName..")"
			extraattacks[source].amount = extraattacks[source].amount - 1
			if extraattacks[source].amount == 0 then
				extraattacks[source] = nil
			end
		end
	end
	
	--Need to add events for potential deaths
	local DPass=damage
	if DPass==0 then
		DPass=nil
	end
	Recount.cleventtext = source.." "..ability.." "..victim.." "..hittype
	if damage then
		Recount.cleventtext = Recount.cleventtext.." -"..damage
	end
	if resist and resist > 0 then
		Recount.cleventtext = Recount.cleventtext .." ("..resist.." resisted)"
	end
	if element then
		Recount.cleventtext = Recount.cleventtext.." ("..element..")"
	end
	Recount:AddCurrentEvent(sourceData, "DAMAGE", false, nil,Recount.cleventtext)
	Recount:AddCurrentEvent(victimData, "DAMAGE", true, DPass, Recount.cleventtext)

	--Is this friendly fire?
	local FriendlyFire=(sourceData.isFriend==victimData.isFriend) and (sourceData.isPlayer and victimData.isPlayer) -- We only care for friendly fire between players now
	
	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			Recount:CheckRetention(source)
			Recount:CheckRetention(victim)
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.db2.FightNum
	victimData.LastFightIn=Recount.db2.FightNum

	--Need to set the source as active
	Recount:AddTimeEvent(sourceData,victim,ability,false)
	

	--Stats for keeping track of DOT Uptime
	if hittype=="Tick" then
		--3 is default time since most abilities have 3 seconds inbetween ticks
		local time=3
--[[		if TickTime[ability] then
			time=TickTime[ability]
		end--]]
		if DotTickTimeId[spellId] then
			time=DotTickTimeId[spellId]
		end
		Recount:AddAmount(sourceData,"DOT_Time",time)
		Recount:AddTableDataSum(sourceData,"DOTs",ability,victim,time)
	end

	--Melee is always considered Melee since its handled differently from specials keep it seperate
	if ability=="Melee" then
		element="Melee"
	end

	if damage then
		--Victim always cares
		Recount:AddAmount(victimData,"DamageTaken",damage)		
		Recount:AddTableDataSum(victimData,"WhoDamaged",source,ability,damage)	

		--Sync Data
		Recount:AddOwnerPetLazySyncAmount(victimData,"DamageTaken", damage)
		--Recount:AddSyncAmount(victimData, "DamageTaken", damage)

		Recount:AddAmount2(victimData,"ElementTaken",element,damage)
		
		if resist then -- Elsia: Fixed bug, source has to "take" resists, blocks and absorbs.
			if hittype=="Crit" then
				resist=resist*2
			end
			Recount:AddAmount2(victimData,"ElementTakenResist",element,resist)
		end
		
		if blocked or hittype=="Block" then
			Recount:AddAmount2(victimData,"ElementTakenBlock",element,blocked)
		end
		
		if absorbed then
			Recount:AddAmount2(victimData,"ElementTakenAbsorb",element,absorbed)
		end
	end

	if damage then
		--Record the element type
		sourceData.AbilityType = sourceData.AbilityType or {}
		sourceData.AbilityType[ability]=element
			
		--Alright now if there was a friendly damage done or not decides where this data goes for the source
		if not FriendlyFire then
			Recount:AddOwnerPetLazySyncAmount(sourceData,"Damage", damage)
			--Recount:AddSyncAmount(sourceData, "Damage", damage)
			Recount:AddAmount(sourceData,"Damage",damage)	
			Recount:AddTableDataStats(sourceData,"Attacks",ability,hittype,damage)
			Recount:AddAmount2(sourceData,"ElementDone",element,damage)
		else
			--Recount:AddOwnerPetLazySyncAmount(sourceData,"FDamage", damage) -- We don't currently sync friendly damage
			--Recount:AddSyncAmount(sourceData, "FDamage", damage)
			Recount:AddAmount(sourceData,"FDamage",damage)
			Recount:AddTableDataStats(sourceData,"FAttacks",ability,hittype,damage)
			Recount:AddTableDataSum(sourceData,"FDamagedWho",victim,ability,damage)
		end

		-- Elsia: Moved this out because we want this recorded regardless whether it was friendly damage or not
		-- Elsia: Also removed bug, victims resist/block/absorb!
		if resist then
			Recount:AddAmount2(sourceData,"ElementDoneResist",element,resist)
			if resist<(damage/2.5) then
				--25% Resist
				Recount:AddTableDataStats(victimData,"PartialResist",ability,"25% Resist",resist)
			elseif resist<(1.25*damage) then
				--50% Resist
				Recount:AddTableDataStats(victimData,"PartialResist",ability,"50% Resist",resist)
			else
				--75% Resist
				Recount:AddTableDataStats(victimData,"PartialResist",ability,"75% Resist",resist)
			end
		else
			Recount:AddTableDataStats(victimData,"PartialResist",ability,"No Resist",0)
		end

		if blocked then
			Recount:AddAmount2(sourceData,"ElementDoneBlock",element,blocked)
			Recount:AddTableDataStats(victimData,"PartialBlock",ability,"Blocked",blocked)
		else
			Recount:AddTableDataStats(victimData,"PartialBlock",ability,"No Block",0)
		end
			
		if absorbed then
			Recount:AddAmount2(sourceData,"ElementDoneAbsorb",element,absorbed)
			Recount:AddTableDataStats(victimData,"PartialAbsorb",ability,"Absorbed",absorbed)
		else
			Recount:AddTableDataStats(victimData,"PartialAbsorb",ability,"No Absorb",0)
		end
			
		Recount:AddTableDataSum(sourceData,"DamagedWho",victim,ability,damage)	

		--Needs to be here for tracking so we don't add Friendly Damage as well
		if Tracking["DAMAGE"] then
			if Tracking["DAMAGE"][source] then
				for _, v in pairs(Tracking["DAMAGE"][source]) do
					v.func(v.pass,damage)
				end
			end

			if sourceData.inGroup and Tracking["DAMAGE"]["!RAID"] then
				for _, v in pairs(Tracking["DAMAGE"]["!RAID"]) do
					v.func(v.pass,damage)
				end
			end
		end
		
		
		--For identifying who killed when no message is triggered
		victimData.LastAttackedBy=source
		victimData.LastDamageTaken=damage
		victimData.LastDamageAbility=ability
		

		--Tracking for passing data to other functions	
		if Tracking["DAMAGETAKEN"] then 
			if Tracking["DAMAGETAKEN"][victim] then
				for _, v in pairs(Tracking["DAMAGETAKEN"][victim]) do
					v.func(v.pass,damage)
				end
			end

			if victimData.inGroup and Tracking["DAMAGETAKEN"]["!RAID"] then
				for _, v in pairs(Tracking["DAMAGETAKEN"]["!RAID"]) do
					v.func(v.pass,damage)
				end
			end
		end
	else
		Recount:AddTableDataStatsNoAmount(sourceData,"Attacks",ability,hittype)
	end


	if sourceData.inGroup and not victimData.isFriend then
		if not victimData.level then
			--Recount:Print(victimData.Name.." lacks level, please report") -- This happens for freezing traps intriguingly enough
			victimData.level = 1
		end
		if (victimData.level==-1) or ((Recount.FightingLevel~=-1) and (victimData.level>Recount.FightingLevel)) then
			Recount.FightingWho=victim
			Recount.FightingLevel=victimData.level
		end
	elseif victimData.inGroup and not sourceData.isFriend then
		if not sourceData.level then
			--Recount:Print(sourceData.Name.." lacks level, please report")
			sourceData.level = 1
		end
		if (sourceData.level==-1) or ((Recount.FightingLevel~=-1) and (sourceData.level>Recount.FightingLevel)) then
			Recount.FightingWho=source
			Recount.FightingLevel=sourceData.level
		end
	end

	--Alright if we have an element type for this ability add its hit type data
	element=sourceData.AbilityType and sourceData.AbilityType[ability] or element

	if element then
		Recount:AddTableDataSum(sourceData,"ElementHitsDone",element,hittype,1)
		Recount:AddTableDataSum(victimData,"ElementHitsTaken",element,hittype,1)
	end	

	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

function Recount:AddHealData(source, victim, ability, healtype, amount, overheal,srcGUID,srcFlags,dstGUID,dstFlags,spellId)
	--First lets figure if there was overhealing
	--Get the tables	
	local SpecialEvent=false
	local owner, ownerID
	local sourceowner
	local sourceownerID
	

	source, sourceowner, sourceownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID) -- Elsia: Bug, owner was missing here
	end
	local victimData=Recount.db2.combatants[victim]

	--Might need to change who the source is here
	local oldSource=nil
	local oldsrcGUID=nil
	local oldsrcFlags=nil
	local oldowner=nil
	local oldownerID=nil
	local SpecialEvent=false
	if (source==victim) and EarthShieldTickId == spellId  then -- Elsia: source should always be victim for this spellId btw.
		source = victimData.EarthShieldSource or source
		srcGUID = victimData.EarthShieldSourceGUID or srcGUID
		srcFlags = victimData.EarthShieldSourceFlags or srcFlags
		--Recount:Print("Earthshieldtick! "..spellId.." "..source.." "..victim)
		if victimData.EarthShieldSource then
			owner = nil
			ownerID = nil
		end
	elseif (source==victim) and LifebloomHealId == spellId then -- Elsia: source should always be victim for this spellId btw.
		local tempsource, tempsourceId, tempsourceFlags = Recount.HealBuffs.LB_Healed(source)
		if tempsource then
			source = tempsource
			srcGUID = tempsourceId
			srcFlags = tempsourceFlags
			owner = nil
			ownerID = nil
		end
	end
--[[	(source==victim) and source~=Recount.PlayerName and HealBuffId[spellId]  then
		if Recount.HealBuffs:IsMyHealBuff(victimData,ability) then
			oldSource=source
			oldsrcGUID=srcGUID
			oldsrcFlags=srcFlags
			oldowner=owner
			oldownerID=ownerID
			source=Recount.PlayerName
			srcGUID=Recount.PlayerGUID
			owner = nil
			ownerID = nil
			SpecialEvent=true
		end
	end]]

	if spellId==PrayerOfMendingHealId then
		local tempsource, tempsourceId, tempsourceFlags = Recount.HealBuffs.POM_Healed(source)
		if tempsource then
			source = tempsource
			srcGUID = tempsourceId
			srcFlags = tempsourceFlags
			owner = nil
			ownerID = nil
		end
	end

	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,sourceowner,srcGUID,srcFlags,sourceownerID)
	end

	local sourceData=Recount.db2.combatants[source]

	if not Recount:TestRetention(source) and not Recount:TestRetention(victim) then
		Recount:CheckRetention(source)
		Recount:CheckRetention(victim)
		return
	end

	if not sourceData then
		Recount:DPrint("Missing source: "..source)
		return
	end
	
	if not victimData then
		Recount:DPrint("Missing target: "..victim)
		return
	end

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	--Need to add events for potential deaths
	Recount.cleventtext = source.." "..ability.." "..victim
	if healtype then
		Recount.cleventtext = Recount.cleventtext.." "..healtype
	end
	if amount then
		Recount.cleventtext = Recount.cleventtext.." +"..amount
	end
	
	if overheal and overheal ~= 0 then 
		Recount.cleventtext = Recount.cleventtext .." ("..overheal.." overheal)"
	end
	Recount:AddCurrentEvent(victimData, "HEAL", true, amount,Recount.cleventtext)
	if source~=victim then
		Recount:AddCurrentEvent(sourceData, "HEAL", false, nil,Recount.cleventtext)
	end

	--Before any further processing need to check if we are in combat 
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		return
	end

	--Fight tracking purposes to speed up leaving combat
	
	--if not sourceData then Recount:DPrint("Source-less heal: "..(ability or "nil")..(source or "nil").." "..(victim or "nil").." Please report!") end
	
	if source and sourceData then sourceData.LastFightIn=Recount.db2.FightNum end
	victimData.LastFightIn=Recount.db2.FightNum

	local VictimUnit=victimData.unit

	if (not VictimUnit or victim~=UnitName(VictimUnit)) and (victimData.UnitLockout>Recount.UnitLockout) then
		victimData.UnitLockout=Recount.CurTime
		VictimUnit=Recount:FindUnit(victim)
		victimData.unit=VictimUnit
	end


	

	if VictimUnit and UnitHealthMax(VictimUnit)~=100 and overheal==nil then
		local HealthMissing = UnitHealthMax(VictimUnit)-UnitHealth(VictimUnit)
		if HealthMissing<amount then
			overheal=amount-HealthMissing
			amount=HealthMissing --Adjust healing considered to the correct number
		else
			overheal=0
		end
	elseif overheal == nil then
		overheal=0
	end
	Recount:AddOwnerPetLazySyncAmount(sourceData,"Healing", amount)
	Recount:AddOwnerPetLazySyncAmount(victimData,"HealingTaken", amount)
	Recount:AddOwnerPetLazySyncAmount(sourceData,"Overhealing", overheal)
	--Recount:AddSyncAmount(sourceData,"Healing", amount)
	--Recount:AddSyncAmount(victimData,"HealingTaken", amount)
	--Recount:AddSyncAmount(sourceData,"Overhealing", overheal)

--[[	if oldSource then
		if not Recount.db2.combatants[oldSource] then
			Recount:AddCombatant(oldSource,oldowner,oldsrcGUID,oldsrcFlags,oldownerID)
		end
		local old=Recount.db2.combatants[oldSource]
		Recount:AddSyncAmount(old,"Healing", amount)
		Recount:AddSyncAmount(old,"Overhealing", overheal)
		--Recount:SendHealCorrection(old.Name,amount,overheal,ability) -- Elsia: Old sync also sync'd details
		Recount:SendHealCorrection(old.Name,amount,overheal) -- Elsia: Old sync also sync'd details
	end]] -- Elsia: Healing correction should now be obsolete

	--Tracking for passing data to other functions
	if Tracking["HEALING"] then
		if Tracking["HEALING"][source] then
			for _, v in pairs(Tracking["HEALING"][source]) do
				v.func(v.pass,amount)
			end
		end

		if sourceData and sourceData.inGroup and Tracking["HEALING"]["!RAID"] then
			for _, v in pairs(Tracking["HEALING"]["!RAID"]) do
				v.func(v.pass,amount)
			end
		end
	end

	if Tracking["HEALINGTAKEN"] then
		if Tracking["HEALINGTAKEN"][victim] then
			for _, v in pairs(Tracking["HEALINGTAKEN"][victim]) do
				v.func(v.pass,amount)
			end
		end

		if victimData.inGroup and Tracking["HEALINGTAKEN"]["!RAID"] then
			for _, v in pairs(Tracking["HEALINGTAKEN"]["!RAID"]) do
				v.func(v.pass,amount)
			end
		end
	end

	

	--Need to set the source as active
	Recount:AddTimeEvent(sourceData,victim,ability,true)

	--Stats for keeping track of HOT Uptime
	if healtype=="Tick" then
		--3 is default time since most abilities have 3 seconds inbetween ticks
		local time=3
		if HotTickTimeId[spellId] then
			time=HotTickTimeId[spellId]
		end
		Recount:AddAmount(sourceData,"HOT_Time",time)
		Recount:AddTableDataSum(sourceData,"HOTs",ability,victim,time)
	end

	--No reason to add information if everything was overhealing
	if amount>0 then
		Recount:AddAmount(sourceData,"Healing",amount)
		Recount:AddAmount(victimData,"HealingTaken",amount)

		Recount:AddTableDataStats(sourceData,"Heals",ability,healtype,amount)
		Recount:AddTableDataSum(sourceData,"HealedWho",victim,ability,amount)
		Recount:AddTableDataSum(victimData,"WhoHealed",source,ability,amount)
	end

	--Now if there was overhealing lets add that data in
	if overheal>0 then
		Recount:AddAmount(sourceData,"Overhealing",overheal)
		Recount:AddTableDataStats(sourceData,"OverHeals",ability,healtype,overheal)
	end

	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

function Recount:AddInterruptData(source, victim, ability, srcGUID,srcFlags, dstGUID,dstFlags, spellId)
	--Get the tables	
	local SpecialEvent=false
	local owner
	local ownerID

	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
	end -- Elsia: Until here is if pets interupts anybody.

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim, owner,dstGUID,dstFlags, ownerID) -- Elsia: Bug, owner missing here
	end

	if not Recount:TestRetention(source) and not Recount:TestRetention(victim) then
		Recount:CheckRetention(source)
		Recount:CheckRetention(victim)
		return
	end
	
	local sourceData=Recount.db2.combatants[source]
	local victimData=Recount.db2.combatants[victim]

	if not sourceData then
		Recount:DPrint("Missing source: "..source)
		return
	end
	
	if not victimData then
		Recount:DPrint("Missing target: "..victim)
		return
	end
	
	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	--Need to add events for potential deaths	
	Recount.cleventtext = source.." interrupts "..victim.." "..ability
	Recount:AddCurrentEvent(victimData,"MISC", true,nil,Recount.cleventtext)
	Recount:AddCurrentEvent(sourceData,"MISC", false,nil,Recount.cleventtext)

	--Friendly fire interrupt? (Duels)
	local FriendlyFire=(sourceData.isFriend==victimData.isFriend) and (sourceData.isPlayer and victimData.isPlayer) -- We only care for friendly fire between players now
	--local FriendlyFire=sourceData.isFriend==victimData.isFriend

	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			Recount:CheckRetention(source)
			Recount:CheckRetention(victim)
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.db2.FightNum
	victimData.LastFightIn=Recount.db2.FightNum

	Recount:AddAmount(sourceData,"Interrupts",1)
	Recount:AddTableDataSum(sourceData,"InterruptData",victim,ability,1)
	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

function Recount:AddDispelData(source, victim, ability,srcGUID,srcFlags,dstGUID,dstFlags,spellId)
	--Get the tables	
	local SpecialEvent=false
	local owner
	local ownerID
	
	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
	end -- Elsia: Until here is if pets dispelled anybody.

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID) -- Elsia: Bug owner missing
	end

	if not Recount:TestRetention(source) and not Recount:TestRetention(victim) then
		Recount:CheckRetention(source)
		Recount:CheckRetention(victim)
		return
	end
	
	local victimData=Recount.db2.combatants[victim]
	local sourceData=Recount.db2.combatants[source]

	if not sourceData then
		Recount:DPrint("Missing source: "..source)
		return
	end
	
	if not victimData then
		Recount:DPrint("Missing target: "..victim)
		return
	end
	
	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)
	
	local FriendlyFire=(sourceData.isFriend==victimData.isFriend) and (sourceData.isPlayer and victimData.isPlayer) -- We only care for friendly fire between players now
	--local FriendlyFire=sourceData.isFriend==victimData.isFriend

	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			Recount:CheckRetention(source)
			Recount:CheckRetention(victim)
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.db2.FightNum
	victimData.LastFightIn=Recount.db2.FightNum

	--Need to add events for potential deaths	
	Recount.cleventtext = source.." dispels "..victim.." "..ability
	Recount:AddCurrentEvent(victimData, "MISC", true,nil,Recount.cleventtext)
	Recount:AddCurrentEvent(sourceData, "MISC", false,nil,Recount.cleventtext)

	--if FriendlyFire then
		Recount:AddAmount(sourceData,"Dispels",1)
		Recount:AddTableDataSum(sourceData,"DispelledWho",victim,ability,1)
		Recount:AddAmount(victimData,"Dispelled",1)
		Recount:AddTableDataSum(victimData,"WhoDispelled",source,ability,1)
	--end
	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

local deathargs={}

function Recount:AddDeathData(source, victim, skill,srcGUID,srcFlags,dstGUID,dstFlags,spellId)
	--Before any further processing need to check if we are in combat 
	local SpecialEvent=false
	local owner
	local ownerID
	
	Recount:DPrint("Add Death: "..victim)
	
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		--Recount:Print("Death out of combat, not recorded")
		return
	end

	if source and type(source) == "string" then -- Elsia: Fix bug when death doesn't have a killer
	
		source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

		if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
			Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
		end -- Elsia: Until here is if pets heal anybody.
	end
		
	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	--Get the tables	
	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim, owner,dstGUID,dstFlags, ownerID) -- Elsia: Bug owner missing
	end

	local victimData=Recount.db2.combatants[victim]
	local sourceData

	if not victimData then return end
	
	--Fight tracking purposes to speed up leaving combat
	victimData.LastFightIn=Recount.db2.FightNum

	--Need to add events for potential deaths	
	if source and source~=victim then -- Elsia: May be worth removing the source~=victim check
		if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
			Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID) -- Elsia: Potential owner bug here
		end
		sourceData=Recount.db2.combatants[source]
		sourceData.LastFightIn=Recount.db2.FightNum
		Recount:AddCurrentEvent(sourceData, "MISC", false)
	end	
	
	Recount.cleventtext = victim..L[" dies."]
	Recount:AddCurrentEvent(victimData, "MISC", true,nil,Recount.cleventtext)

	--This saves who/what killed the victim
	if source then
		victimData.LastKilledBy=source
		victimData.LastKilledAt=GetTime()
	elseif skill then
		victimData.LastKilledBy=skill
		victimData.LastKilledAt=GetTime()
	else
		--The case where we actually add a deathcount
		Recount:AddAmount(victimData,"DeathCount",1)
	end

	--We delay the saving of the event logs just in case more messages come later
	if Recount.db.profile.Filters.TrackDeaths[victimData.type] then
		--Recount:ScheduleTimer(Recount.HandleDeath,2,Recount,victim,GetTime(),dstGUID,dstFlags)
		deathargs={} -- Elsia: Make sure we create new ones in case of overlapping deaths!
		deathargs[1]=victim
		deathargs[2]=GetTime()
		deathargs[3]=dstGUID
		deathargs[4]=dstFlags
		Recount:ScheduleTimer("HandleDeath",2,deathargs)
		--Recount:HandleDeath(deathargs)
	else
			Recount:CheckRetention(victim)
	end
	Recount:CheckRetention(source)
end

function Recount:HandleDeath(arg)
	local SpecialEvent=false
	local owner
	local ownerID

	local victim,DeathTime,dstGUID,dstFlags = unpack(arg)
	
	Recount:DPrint("death: "..victim)
	
--[[	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim].Init then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID)
	end]]
	
	if not Recount.db2.combatants[victim] then
		return
	end

	local who=Recount.db2.combatants[victim]

	
	local num=Recount.db.profile.MessagesTracked
	local DeathLog=Recount:GetTable()

	DeathLog.DeathAt=Recount.CurTime
	DeathLog.Messages=Recount:GetTable()
	DeathLog.MessageTimes=Recount:GetTable()
	DeathLog.MessageType=Recount:GetTable()
	DeathLog.MessageIncoming=Recount:GetTable()
	DeathLog.Health=Recount:GetTable()
	DeathLog.HealthNum=Recount:GetTable()
	DeathLog.EventNum=Recount:GetTable()

	if who.LastKilledBy and math.abs(who.LastKilledAt-DeathTime)<2 then
		DeathLog.KilledBy=who.LastKilledBy
	elseif who.LastAttackedBy then
		DeathLog.KilledBy=who.LastAttackedBy
		who.LastAttackedBy=nil
	end
			
	local offset
	for i=1,num do
		offset=math.fmod(who.NextEventNum+i+num-2,num)+1
		if who.LastEvents[offset] and (who.LastEventTimes[offset]-DeathTime)>-15 then
			DeathLog.MessageTimes[#DeathLog.MessageTimes+1]=who.LastEventTimes[offset]-DeathTime
			DeathLog.Messages[#DeathLog.Messages+1]=who.LastEvents[offset] or ""
			DeathLog.MessageType[#DeathLog.MessageType+1]=who.LastEventType[offset] or "MISC"
			DeathLog.MessageIncoming[#DeathLog.MessageIncoming+1]=who.LastEventIncoming[offset] or false
			DeathLog.Health[#DeathLog.Health+1]=who.LastEventHealth[offset] or 0
			DeathLog.HealthNum[#DeathLog.HealthNum+1]=who.LastEventHealthNum[offset] or 0
			DeathLog.EventNum[#DeathLog.HealthNum]=who.LastEventNum and who.LastEventNum[offset] or 0
		end
	end

	who.DeathLogs = who.DeathLogs or {}
	tinsert(who.DeathLogs,1,DeathLog)

	if RecountDeathTrack then
		--Recount:DPrint(who.LastDamageTaken)
		RecountDeathTrack:AddDeath(victim, DeathTime-Recount.InCombatT2, who.LastDamageTaken , who, who.DeathLogs)--[[who.LastDamageAbility.." "..who.LastDamageTaken]]--
	end

	--who.DeathLogs[#who.DeathLogs+1]=DeathLog
	Recount:CheckRetention(victim)
end

function Recount:AddMiscData(source, victim,srcGUID,srcFlags,dstGUID,dstFlags)
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		return
	end

	local SpecialEvent=false
	local owner
	local ownerID

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	--Get the tables
	if not Recount.db2.combatants[victim].Init then
		--If the victim doesn't exist we don't care
		return
	end

	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)
	
	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags,ownerID)
	end

	local sourceData=Recount.db2.combatants[source]
	local victimData=Recount.db2.combatants[victim]

	--Need to add events for potential deaths
	Recount.cleventtext = source.." misc "..victim
	Recount:AddCurrentEvent(sourceData, "MISC", false,nil,Recount.cleventtext)
	Recount:AddCurrentEvent(victimData, "MISC", true,nil,Recount.cleventtext)
	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

function Recount:AddMiscVictimData(victim)
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		return
	end

	--Get the tables
	if not Recount.db2.combatants[victim] then
		--Lets not add events for someone who doesn't exist
		return
	end

	local victimData=Recount.db2.combatants[victim]

	--Need to add events for potential deaths
	Recount.cleventtext = victim.." misc."
	Recount:AddCurrentEvent(victimData, "MISC", true,nil,Recount.cleventtext)
	Recount:CheckRetention(victim)
end

function Recount:AddCCBreaker(source, victim, ability,srcGUID,srcFlags,dstGUID,dstFlags)
	--Get the tables
	local SpecialEvent=false
	local owner
	local ownerID

	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags, ownerID)
	end -- Elsia: Until here is if pets heal anybody.

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags, ownerID)
	end

	local sourceData=Recount.db2.combatants[source]
	local victimData=Recount.db2.combatants[victim]

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	if not victimData then return end -- Elsia: No victim around?
	--Is this friendly fire?
	local FriendlyFire=(sourceData.isFriend==victimData.isFriend) and (sourceData.isPlayer and victimData.isPlayer) -- We only care for friendly fire between players now
	--local FriendlyFire=sourceData.isFriend==victimData.isFriend
	
	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			Recount:CheckRetention(source)
			Recount:CheckRetention(victim)
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.db2.FightNum
	victimData.LastFightIn=Recount.db2.FightNum
	
	if not FriendlyFire then
		Recount:AddAmount(sourceData,"CCBreak",1)
		Recount:AddTableDataSum(sourceData,"CCBroken",ability,victim,1)
	end
	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end


function Recount:AddGain(source, victim, ability, amount, attribute,srcGUID,srcFlags,dstGUID,dstFlags,spellId)
	--Get the tables
	
	local SpecialEvent=false
	local owner
	local ownerID

	source, owner, ownerID, SpecialEvent = Recount:DetectPet(source, srcGUID, srcFlags)

	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source,owner,srcGUID,srcFlags,ownerID)
	end -- Elsia: Until here is if pets heal anybody.

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)
	if not Recount.db2.combatants[victim] then
		Recount:AddCombatant(victim,owner,dstGUID,dstFlags,ownerID)
	end -- Elsia: Until here is if pets heal anybody.

	local sourceData=Recount.db2.combatants[source]

	Recount:SetActive(sourceData)

	local DataAmount, DataTable, DataTable2

	if attribute=="Mana" then
		DataAmount="ManaGain"
		DataTable="ManaGained"
		DataTable2="ManaGainedFrom"
	elseif attribute=="Energy" or attribute=="Focus" then -- Elsia: Focus for pet.
		DataAmount="EnergyGain"
		DataTable="EnergyGained"
		DataTable2="EnergyGainedFrom"
	elseif attribute=="Rage" then
		DataAmount="RageGain"
		DataTable="RageGained"
		DataTable2="RageGainedFrom"
	elseif attribute=="Runic Power" then
		DataAmount="RunicPowerGain"
		DataTable="RunicPowerGained"
		DataTable2="RunicPowerGainedFrom"
	else
		Recount:CheckRetention(source)
		Recount:CheckRetention(victim)
		return
	end

	Recount:AddAmount(sourceData,DataAmount,amount)
	Recount:AddTableDataSum(sourceData,DataTable,ability,victim,amount)
	Recount:AddTableDataSum(sourceData,DataTable2,victim,ability,amount)
	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

function Recount:AddRes(source, victim, ability,srcGUID,srcFlags, dstGUID,dstFlags,spellId)
	--Get the tables

	if not Recount.db2.combatants[source] or not Recount.db2.combatants[source] then
		Recount:AddCombatant(source, nil, srcGUID,srcFlags)
	end

	
	local sourceData=Recount.db2.combatants[source]

	Recount:SetActive(sourceData)

	local SpecialEvent=false
	local owner
	local ownerID

	victim, owner, ownerID, SpecialEvent = Recount:DetectPet(victim, dstGUID, dstFlags)

	Recount:AddAmount(sourceData,"Ressed",1)
	Recount:AddTableDataSum(sourceData,"RessedWho",victim,ability,1)
	Recount:CheckRetention(source)
	Recount:CheckRetention(victim)
end

--Potential Tracking
--"DAMAGE"
--"DAMAGETAKEN"
--"HEALING"
--"HEALINGTAKEN"

--function Recount:FPSUpdate(pass)
--end

function Recount:RegisterTracking(id, who, stat, func, pass)
	--Special trackers handled first
	
	local idtoken
	
	if stat=="FPS" then
		idtoken=Recount:ScheduleRepeatingTimer(function() func(pass,GetFramerate()*0.1) end,0.1) -- id.."_TRACKER",
		--return -- Elsia: Removed this so we store tokens
	elseif stat=="LAG" then
		idtoken=Recount:ScheduleRepeatingTimer(function() local _, _, lag = GetNetStats(); func(pass,lag*0.1) end,0.1)
	elseif stat=="UP_TRAFFIC" then
		idtoken=Recount:ScheduleRepeatingTimer(function() local _, up  = GetNetStats(); func(pass,1024*up*0.1) end,0.1)
	elseif stat=="DOWN_TRAFFIC" then
		idtoken=Recount:ScheduleRepeatingTimer(function() local down  = GetNetStats(); func(pass,1024*down*0.1) end,0.1)
	elseif stat=="AVAILABLE_BANDWIDTH" then
		idtoken=Recount:ScheduleRepeatingTimer(function() func(pass,ChatThrottleLib:UpdateAvail()*0.1) end,0.1)
	end
	
	if type(Tracking[stat])~="table" then
		Tracking[stat]=Recount:GetTable()
	end

	if type(Tracking[stat][who])~="table" then
		Tracking[stat][who]=Recount:GetTable()
	end

	if type(Tracking[stat][who][id])~="table" then
		Tracking[stat][who][id]=Recount:GetTable()
	end

	Tracking[stat][who][id].func=func
	Tracking[stat][who][id].pass=pass
	Tracking[stat][who][id].token=idtoken
end	

function Recount:UnregisterTracking(id, who, stat)
	if stat=="FPS" or stat=="LAG" or stat=="UP_TRAFFIC" or stat=="DOWN_TRAFFIC" or stat=="AVAILABLE_BANDWIDTH" then
		Recount:CancelTimer(Tracking[stat][who][id].token) -- Was id.."_TRACKER"
		return
	end

	if type(Tracking[stat])~="table" or type(Tracking[stat][who])~="table"  then
		return
	end

	Tracking[stat][who][id]=nil
end


