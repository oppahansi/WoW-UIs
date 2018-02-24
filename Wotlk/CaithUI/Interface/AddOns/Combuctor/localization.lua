--[[
	Localization.lua
		Translations for Combuctor

	English: Default language
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("Combuctor", "enUS", true)

--these are automatically localized (aka, don't translate them :)
do
	L.All = ALL

	L.Weapon, L.Armor, L.Container, L.Consumable, L.Glyph, L.TradeGood, 
 	L.Projectile, L.Quiver, L.Recipe, L.Gem, L.Misc, L.Quest = GetAuctionItemClasses()

	L.Trinket = getglobal('INVTYPE_TRINKET')

	L.Devices, L.Explosives = select(10, GetAuctionItemSubClasses(6))

	L.SimpleGem = select(8, GetAuctionItemSubClasses(7))
end

--binding actions
L.ToggleInventory = "Toggle Inventory"
L.ToggleBank = "Toggle Bank"

--frame titles
L.InventoryTitle = "%s's Inventory"
L.BankTitle = "%s's Bank"

--panel names
L.Normal = 'Normal'
L.Equipment = 'Equipment'
L.Keys = 'Keys'
L.Trade = 'Trade'
L.Ammo = 'Ammo'
L.Shards = 'Shards'
L.SoulShard = 'Soul Shard'
L.Usable = 'Usable'

--tooltips
L.Bank = 'Bank'
L.TotalOnRealm = 'Total on %s'
L.ClickToPurchase = '<Click> to Purchase'