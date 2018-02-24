function Gladdy:GetAuraList()
	return {
		-- Crowd control
		[GetSpellInfo(33786)] 	= 3, 	-- Cyclone
		[GetSpellInfo(18658)] 	= 3,	-- Hibernate
		[GetSpellInfo(14309)] 	= 3, 	-- Freezing Trap Effect
		[GetSpellInfo(6770)]	= 3, 	-- Sap
		[GetSpellInfo(2094)]	= 3, 	-- Blind
		[GetSpellInfo(5782)]	= 3, 	-- Fear
		[GetSpellInfo(27223)]	= 3,	-- Death Coil Warlock
		[GetSpellInfo(6358)] 	= 3, 	-- Seduction (Succubus)
		[GetSpellInfo(5484)] 	= 3, 	-- Howl of Terror
		[GetSpellInfo(5246)] 	= 3, 	-- Intimidating Shout
		[GetSpellInfo(8122)] 	= 3,	-- Psychic Scream
		[GetSpellInfo(12826)] 	= 3,	-- Polymorph
		[GetSpellInfo(28272)] 	= 3,	-- Polymorph pig
		[GetSpellInfo(28271)] 	= 3,	-- Polymorph turtle
		[GetSpellInfo(18647)]	= 3,	-- Banish

		-- Roots
		[GetSpellInfo(26989)] 	= 3, 	-- Entangling Roots
		[GetSpellInfo(27088)]	= 3,	-- Frost Nova
		[GetSpellInfo(16979)] 	= 3, 	-- Feral Charge

		-- Stuns and incapacitates
		[GetSpellInfo(8983)] 	= 3, 	-- Bash
		[GetSpellInfo(1833)] 	= 3,	-- Cheap Shot
		[GetSpellInfo(8643)] 	= 3, 	-- Kidney Shot
		[GetSpellInfo(1776)]	= 3, 	-- Gouge
		[GetSpellInfo(19503)] 	= 3, 	-- Scatter Shot
		[GetSpellInfo(10308)]	= 3, 	-- Hammer of Justice
		[GetSpellInfo(20066)] 	= 3, 	-- Repentance

		-- Silences
		[GetSpellInfo(18469)] 	= 1,	-- Improved Counterspell
		[GetSpellInfo(15487)] 	= 1, 	-- Silence
		[GetSpellInfo(34490)] 	= 1, 	-- Silencing Shot
		[GetSpellInfo(18425)]	= 1,	-- Improved Kick
		[GetSpellInfo(19647)] 	= 1,	-- Spell Lock (Felhunter)

		-- Buffs
		[GetSpellInfo(10278)] 	= 1,	-- Hand of Protection
		[GetSpellInfo(1044)] 	= 1, 	-- Blessing of Freedom
		[GetSpellInfo(33206)] 	= 1, 	-- Pain Suppression
		[GetSpellInfo(29166)] 	= 1,	-- Innervate
		[GetSpellInfo(18708)]  	= 1,	-- Fel Domination

		-- Turtling abilities
		[GetSpellInfo(31224)]	= 1,	-- Cloak of Shadows

		-- Immunities
		[GetSpellInfo(34692)] 	= 2, 	-- The Beast Within
		[GetSpellInfo(45438)] 	= 2, 	-- Ice Block
		[GetSpellInfo(642)] 	= 2,	-- Divine Shield
	}
end

local durations =  {
	-- Crowd control
	[GetSpellInfo(33786)] 	= 6, 	-- Cyclone
	[GetSpellInfo(18658)] 	= 10,	-- Hibernate
	[GetSpellInfo(14309)] 	= 10, 	-- Freezing Trap Effect
	[GetSpellInfo(6770)]	= 10, 	-- Sap
	[GetSpellInfo(2094)]	= 10, 	-- Blind
	[GetSpellInfo(5782)]	= 10, 	-- Fear
	[GetSpellInfo(27223)]	= 3,	-- Death Coil Warlock
	[GetSpellInfo(6358)] 	= 10, 	-- Seduction (Succubus)
	[GetSpellInfo(5484)] 	= 8, 	-- Howl of Terror
	[GetSpellInfo(5246)] 	= 8, 	-- Intimidating Shout
	[GetSpellInfo(8122)] 	= 8,	-- Psychic Scream
	[GetSpellInfo(12826)] 	= 10,	-- Polymorph
	[GetSpellInfo(28272)] 	= 10,	-- Polymorph pig
	[GetSpellInfo(28271)] 	= 10,	-- Polymorph turtle
	[GetSpellInfo(18647)]	= 10,	-- Banish

	-- Roots
	[GetSpellInfo(26989)] 	= 10, 	-- Entangling Roots
	[GetSpellInfo(27088)]	= 8,	-- Frost Nova
	[GetSpellInfo(16979)] 	= 4, 	-- Feral Charge

	-- Stuns and incapacitates
	[GetSpellInfo(8983)] 	= 5, 	-- Bash
	[GetSpellInfo(1833)] 	= 4,	-- Cheap Shot
	[GetSpellInfo(8643)] 	= 6, 	-- Kidney Shot
	[GetSpellInfo(1776)]	= 4, 	-- Gouge
	[GetSpellInfo(19503)] 	= 4, 	-- Scatter Shot
	[GetSpellInfo(10308)]	= 6, 	-- Hammer of Justice
	[GetSpellInfo(20066)] 	= 6, 	-- Repentance

	-- Silences
	[GetSpellInfo(18469)] 	= 4,	-- Improved Counterspell
	[GetSpellInfo(15487)] 	= 5, 	-- Silence
	[GetSpellInfo(34490)] 	= 3, 	-- Silencing Shot
	[GetSpellInfo(18425)]	= 2,	-- Improved Kick
	[GetSpellInfo(19647)] 	= 3,	-- Spell Lock (Felhunter)

	-- Buffs
	[GetSpellInfo(10278)] 	= 10,	-- Hand of Protection
	[GetSpellInfo(1044)] 	= 14, 	-- Blessing of Freedom
	[GetSpellInfo(33206)] 	= 8, 	-- Pain Suppression
	[GetSpellInfo(29166)] 	= 20,	-- Innervate
	[GetSpellInfo(18708)]  	= 15,	-- Fel Domination

	-- Turtling abilities
	[GetSpellInfo(31224)]	= 5,	-- Cloak of Shadows

		-- Immunities
	[GetSpellInfo(34692)] 	= 18, 	-- The Beast Within
	[GetSpellInfo(45438)] 	= 10, 	-- Ice Block
	[GetSpellInfo(642)] 	= 12,	-- Divine Shield
}

function Gladdy:GetDuration(spellName)
	return durations[spellName] or 0
end

local buffs = setmetatable({
    [GetSpellInfo(10278)] 	= true,	    -- Hand of Protection
	[GetSpellInfo(1044)] 	= true, 	-- Blessing of Freedom
	[GetSpellInfo(33206)] 	= true, 	-- Pain Suppression
	[GetSpellInfo(29166)] 	= true,	    -- Innervate
	[GetSpellInfo(18708)]  	= true,	    -- Fel Domination
	[GetSpellInfo(31224)]	= true,	    -- Cloak of Shadows
	[GetSpellInfo(34692)] 	= true, 	-- The Beast Within
	[GetSpellInfo(45438)] 	= true, 	-- Ice Block
	[GetSpellInfo(642)] 	= true,	    -- Divine Shield
},{
    __index = function()
        return false
    end
})

function Gladdy:IsBuff(spellName)
    return buffs[spellName]
end