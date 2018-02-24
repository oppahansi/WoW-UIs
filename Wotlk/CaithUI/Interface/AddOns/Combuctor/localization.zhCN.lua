--[[
	Localization.lua
		Translations for Combuctor

	English: Default language
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("Combuctor", "zhCN")
if not L then return end

--binding actions
L.ToggleInventory = "显示背包"
L.ToggleBank = "显示银行"

--frame titles
L.InventoryTitle = "%s 的背包"
L.BankTitle = "%s 的银行"

--panel names
L.Normal = '标准'
L.Equipment = '装备'
L.Keys = '钥匙'
L.Trade = '商业'
L.Ammo = '弹药'
L.Shards = '碎片'
L.Usable = '消耗品'

--tooltips
L.Bank = '银行'
L.TotalOnRealm = '在<%s>服务器上总计'
L.ClickToPurchase = '<点击>购买新背包'