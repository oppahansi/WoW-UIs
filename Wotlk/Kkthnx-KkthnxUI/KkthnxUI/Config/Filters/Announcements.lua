local K, C, _ = select(2, ...):unpack()

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://wotlk.openwow.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.Announcements.Spells == true then
	K.AnnounceSpells = {
		34477, -- Misdirection
		19801, -- Tranquilizing Shot
		57934, -- Tricks of the Trade
		633, -- Lay on Hands
		20484, -- Rebirth
		61999, -- Raise Ally
		20707, -- Soulstone
		2908, -- Soothe
	}
end

if C.Announcements.BadGear == true then
	K.AnnounceBadGear = {
		-- Head
		[1] = {
			33820, -- Weather-Beaten Fishing Hat
			19972, -- Lucky Fishing Hat
			46349, -- Chef's Hat
		},
		-- Neck
		[2] = {
			32757, -- Blessed Medallion of Karabor
		},
		-- Feet
		[8] = {
			50287, -- Boots of the Bay
			19969, -- Nat Pagle's Extreme Anglin' Boots
		},
		-- Main-Hand
		[16] = {
			44050, -- Mastercraft Kalu'ak Fishing Pole
			19970, -- Arcanite Fishing Pole
			45992, -- Jeweled Fishing Pole
			45991, -- Bone Fishing Pole
			6256, -- Fishing Pole
			45858, -- Nat's Lucky Fishing Pole
			6367, -- Big Iron Fishing Pole
			6366, -- Darkwood Fishing Pole
		},
	}
end

if C.Announcements.Toys == true then
	K.AnnounceToys = {
		[61031] = true, -- Toy Train Set
		[49844] = true, -- Direbrew's Remote
	}
end

if C.Announcements.Feasts == true then
	K.AnnounceBots = {
		[22700] = true,	-- Field Repair Bot 74A
		[44389] = true,	-- Field Repair Bot 110G
		[54711] = true,	-- Scrapbot
		[67826] = true,	-- Jeeves
	}
end

if C.Announcements.Portals == true then
	K.AnnouncePortals = {
		-- Alliance
		[10059] = true,	-- Stormwind
		[11416] = true,	-- Ironforge
		[11419] = true,	-- Darnassus
		[32266] = true,	-- Exodar
		[49360] = true,	-- Theramore
		[33691] = true,	-- Shattrath
		-- Horde
		[11417] = true,	-- Orgrimmar
		[11420] = true,	-- Thunder Bluff
		[11418] = true,	-- Undercity
		[32267] = true,	-- Silvermoon
		[49361] = true,	-- Stonard
		[35717] = true,	-- Shattrath
		-- Alliance/Horde
		[53142] = true, -- Dalaran
		[120146] = true, -- Ancient Dalaran
	}
end

if C.PulseCD.Enable == true then
	K.pulse_ignored_spells = {
		-- GetSpellInfo(6807), -- Maul
		-- GetSpellInfo(35395), -- Crusader Strike
	}
end