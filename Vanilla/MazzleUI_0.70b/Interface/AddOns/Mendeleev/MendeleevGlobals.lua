local L = AceLibrary("AceLocale-2.2"):new("Mendeleev")

L:RegisterTranslations("enUS", function() return {
	["KCI Integration"] = true,
	["Integrate into the KCI tooltip"] = true,
	["integrate"] = true,
	["sets"] = true,
	["toggle"] = true,
	["Toggle Sets"] = true,

	["Crafted by"] = true,
	["Crafted by: "] = true,

	["Recipe source"] = true,
	["Recipe source: "] = true,
	["Seasonal recipe"] = true,
	["Recipe faction"] = true,
	["Vendor faction"] = true,

	["Gathering skills"] = true,
	["Mine Gems"] = true,
	["Trade Skills"] = true,
	["Class Reagents"] = true,
	["Zul'Gurub Enchants"] = true,
	["Zul'Gurub Classes"] = true,
	["Zul'Gurub Coins"] = true,
	["Ahn'Qiraj CC Classes"] = true,
	["Ahn'Qiraj BoN Classes"] = true,
	["Food type"] = true,
	["Booze"] = true,
	["Lockpick value"] = true,
	["World Drops"] = true,
	["World Boss Drops"] = true,
	["Raid Zones"] = true,
	["Raid Bosses"] = true,
	["Instance zones"] = true,
	["Instance bosses"] = true,
	["Elemental bosses"] = true,
	["Outdoor bosses"] = true,
	["Four Dragons"] = true,

	["Gathered by"] = true,
	["Zul'Gurub Enchant"] = true,
	["Used by"] = true,
	["Classes"] = true,
	["Darkmoon Faire"] = true,
	["Darkmoon Faire Card"] = true,
	["World Drop"] = true,
	["World Boss Drop"] = true,
	["Found in"] = true,
	["Dropped by"] = true,
	["Used in"] = true,
	["Reputaton item"] = true,

	["Copper"]        = true,
	["Tin"]           = true,
	["Silver"]        = true,
	["Iron"]          = true,
	["Gold"]          = true,
	["Mithril"]       = true,
	["Truesilver"]    = true,
	["Small Thorium"] = true,
	["Hakkari Thorium"]                 = true,
	["Rich Thorium"]  = true,
	["Dark Iron"]     = true,

	["Fishing"]       = true,
	["Disenchant"]    = true,
	["Herbalism"]     = true,
	["Mining"]        = true,
	["Skinning"]      = true,
	["Alchemy"]       = true,
	["Blacksmithing"] = true,
	["Cooking"]       = true,
	["Enchanting"]    = true,
	["Engineering"]   = true,
	["Firstaid"]      = true,
	["Leatherworking"]= true,
	["Tailoring"]     = true,

	["Fish"]          = true,
	["Meat"]          = true,
	["Bread"]         = true,
	["Conjured"]      = true,
	["Cheese"]        = true,
	["Fruit"]         = true,
	["Misc"]          = true,
	["Fungus"]        = true,

	["Junk Items"]    = true,
	["Leather"]       = true,
	["Blue Dragon Card"]                = true,
	["Heroism Card"]  = true,
	["Twisting Nether Card"]            = true,
	["Maelstrom Card"]= true,

	["Lockpicking"]   = true,
	[" (Enchant)"]    = true,
	["Trash Mobs"]    = true,
	["Item ID"]        = true,
	["Stacksize"]     = true,
	["NoClue"]        = "I don't know ",

	-- Factions
	["Alliance"] = true,
	["Horde"] = true,
	["Neutral"] = true,
	["Argent Dawn"] = true,
	["Cenarion Circle"] = true,
	["Thorium Brotherhood"] = true,
	["Timbermaw Hold"] = true,
	["Zandalar Tribe"] = true,
	["Ravenholdt"] = true,

	-- Crafted by
	["Alchemy"] = true,
	["Blacksmithing"] = true,
	["Armorsmithing"] = true,
	["Axesmithing"] = true,
	["Hammersmithing"] = true,
	["Swordsmithing"] = true,
	["Weaponsmithing"] = true,
	["Cooking"] = true,
	["Engineering"] = true,
	["Gnomish Engineering"] = true,
	["Goblin Engineering"] = true,
	["First Aid"] = true,
	["Leatherworking"] = true,
	["Draconscale Leatherworking"] = true,
	["Elemental Leatherworking"] = true,
	["Tribal Leatherworking"] = true,
	["Tailoring"] = true,

	-- Sources
	["Drop"] = true,
	["Vendor"] = true,
	["Quest"] = true,
	["Crafted"] = true,

	["UBRS"] = true,
	["LBRS"] = true,
}end)

MendeleevLocals = {}

--Localized strings
--This has a slightly different structure because of the way the closure in the cats works
MendeleevLocals.Rep = {}
MendeleevLocals.Rep[1] = " (Hated)"
MendeleevLocals.Rep[2] = " (Hostile)"
MendeleevLocals.Rep[3] = " (Unfriendly)"
MendeleevLocals.Rep[4] = " (Neutral)"
MendeleevLocals.Rep[5] = " (Friendly)"
MendeleevLocals.Rep[6] = " (Honored)"
MendeleevLocals.Rep[7] = " (Revered)"
MendeleevLocals.Rep[8] = " (Exalted)"

MendeleevLocals.Dif = {}
MendeleevLocals.Dif[0] = "(Trivial)"
MendeleevLocals.Dif[1] = "(Easy)"
MendeleevLocals.Dif[2] = "(Medium)"
MendeleevLocals.Dif[3] = "(Optimal)"
MendeleevLocals.Dif[4] = "(Difficult)"

