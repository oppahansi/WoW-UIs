local L = AceLibrary("AceLocale-2.2"):new("Mendeleev")

L:RegisterTranslations("deDE", function() return {
-- 	["KCI Integration"] = "KCI 적용",
-- 	["Integrate into the KCI tooltip"] = "KCI 툴팁에 적용합니다.",
-- --	["integrate"] = true,
-- --	["sets"] = true,
-- --	["toggle"] = true,
-- 	["Toggle Sets"] = "설정 전환",
-- 
-- 	["Crafted by"] = true,
-- 	["Crafted by: "] = true,
-- 
-- 	["Recipe source"] = true,
-- 	["Recipe source: "] = true,
-- 	["Seasonal recipe"] = true,
-- 	["Recipe faction"] = true,
-- 	["Vendor faction"] = true,
-- 
-- 	["Gathering skills"] = true,
-- 	["Mine Gems"] = true,
-- 	["Trade Skills"] = true,
-- 	["Class Reagents"] = true,
-- 	["Zul'Gurub Enchants"] = true,
-- 	["Zul'Gurub Classes"] = true,
-- 	["Zul'Gurub Coins"] = true,
-- 	["Ahn'Qiraj CC Classes"] = true,
-- 	["Ahn'Qiraj BoN Classes"] = true,
-- 	["Food type"] = true,
-- 	["Booze"] = true,
-- 	["Lockpick value"] = true,
-- 	["World Drops"] = true,
-- 	["World Boss Drops"] = true,
-- 	["Raid Zones"] = true,
-- 	["Raid Bosses"] = true,
-- 	["Instance zones"] = true,
-- 	["Instance bosses"] = true,
-- 	["Elemental bosses"] = true,
-- 	["Outdoor bosses"] = true,
-- 	["Four Dragons"] = true,
-- 
-- 	["Gathered by"] = true,
-- 	["Zul'Gurub Enchant"] = true,
-- 	["Used by"] = true,
-- 	["Classes"] = true,
-- 	["Darkmoon Faire"] = true,
-- 	["Darkmoon Faire Card"] = true,
-- 	["World Drop"] = true,
-- 	["World Boss Drop"] = true,
-- 	["Found in"] = true,
-- 	["Dropped by"] = true,
-- 	["Used in"] = true,
-- 	["Reputaton item"] = true,

	["Copper"]        = "Kupfer",
	["Tin"]           = "Zinn",
	["Silver"]        = "Silber",
	["Iron"]          = "Eisen",
	["Gold"]          = "Gold",
	["Mithril"]       = "Mithril",
	["Truesilver"]    = "Echtsilber",
	["Small Thorium"] = "Kleines Thorium",
	["Hakkari Thorium"]                 = "Hakkari Thorium",
	["Rich Thorium"]  = "Reiches Thorium",
	["Dark Iron"]     = "Dunkeleisen",

	["Fishing"]       = "Angeln",
	["Disenchant"]    = "Entzaubern",
	["Herbalism"]     = "Kr\195\164uterkunde",
	["Mining"]        = "Bergbau",
	["Skinning"]      = "K\195\188rschnerei",
	["Alchemy"]       = "Alchimie",
	["Blacksmithing"] = "Schmiedekunst",
	["Cooking"]       = "Kochkunst",
	["Enchanting"]    = "Verzauberkunst",
	["Engineering"]   = "Ingenieurskunst",
	["Firstaid"]      = "Erste Hilfe",
	["Leatherworking"]= "Lederverarbeitung",
	["Tailoring"]     = "Schneiderei",

	["Fish"]          = "Fisch",
	["Meat"]          = "Fleisch",
	["Bread"]         = "Brot",
	["Conjured"]      = "Herbeigezaubert",
	["Cheese"]        = "K\195\164se",
	["Fruit"]         = "Frucht",
	["Misc"]          = "Sonstiges",
	["Fungus"]        = "Pilz",

	["Junk Items"]    = "Junk Items",
	["Leather"]       = "Leder",
-- 	["Blue Dragon Card"]                = true,
-- 	["Heroism Card"]  = true,
-- 	["Twisting Nether Card"]            = true,
-- 	["Maelstrom Card"]= true,

	["Lockpicking"]   = "Schlossknacken",
	[" (Enchant)"]    = " (Verzauberung)",
	["Trash Mobs"]    = "Trash Mobs",
	["Item ID"]        = "Gegenstands-Id",
	["Stacksize"]     = "Stapelgr\195\182\195\159e",
	["NoClue"]        = "Unbekannt",

-- 	-- Factions
-- 	["Alliance"] = true,
-- 	["Horde"] = true,
-- 	["Neutral"] = true,
-- 	["Argent Dawn"] = true,
-- 	["Cenarion Circle"] = true,
-- 	["Thorium Brotherhood"] = true,
-- 	["Timbermaw Hold"] = true,
-- 	["Zandalar Tribe"] = true,
-- 	["Ravenholdt"] = true,
-- 
-- 	-- Crafted by
-- 	["Alchemy"] = true,
-- 	["Blacksmithing"] = true,
-- 	["Armorsmithing"] = true,
-- 	["Axesmithing"] = true,
-- 	["Hammersmithing"] = true,
-- 	["Swordsmithing"] = true,
-- 	["Weaponsmithing"] = true,
-- 	["Cooking"] = true,
-- 	["Engineering"] = true,
-- 	["Gnomish Engineering"] = true,
-- 	["Goblin Engineering"] = true,
-- 	["First Aid"] = true,
-- 	["Leatherworking"] = true,
-- 	["Draconscale Leatherworking"] = true,
-- 	["Elemental Leatherworking"] = true,
-- 	["Tribal Leatherworking"] = true,
-- 	["Tailoring"] = true,
-- 
-- 	-- Sources
-- 	["Drop"] = true,
-- 	["Vendor"] = true,
-- 	["Quest"] = true,
-- 	["Crafted"] = true,
-- 
-- 	["UBRS"] = true,
-- 	["LBRS"] = true,
}end)

if GetLocale() == "deDE" then

	--Localized strings
	--This has a slightly different structure because of the way the closure in the cats works
    MendeleevLocals.Rep = {}
    MendeleevLocals.Rep[1] 		= " (Hasserf\195\188llt)"
    MendeleevLocals.Rep[2] 		= " (Feindselig)"
    MendeleevLocals.Rep[3] 		= " (Unfreundlich)"
    MendeleevLocals.Rep[4] 		= " (Neutral)"
    MendeleevLocals.Rep[5] 		= " (Freundlich)"
    MendeleevLocals.Rep[6] 		= " (Wohlwollend)"
    MendeleevLocals.Rep[7] 		= " (Respektvoll)"
    MendeleevLocals.Rep[8] 		= " (Ehrf\195\188rchtig)"

    MendeleevLocals.Dif= {}
    MendeleevLocals.Dif[0] 		= "(Trivial)"
    MendeleevLocals.Dif[1] 		= "(Leicht)"
    MendeleevLocals.Dif[2] 		= "(Mittel)"
    MendeleevLocals.Dif[3] 		= "(Optimal)"
    MendeleevLocals.Dif[4] 		= "(Schwierig)"


end
