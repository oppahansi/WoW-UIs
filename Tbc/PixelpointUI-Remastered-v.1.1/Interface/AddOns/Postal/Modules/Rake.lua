--[[ Postal_Rake: Display summary of money gained from opening mail. ]]--

assert( Postal, "Postal not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Postal")

local mod, floor, format = mod, floor, format
local GOLD, SILVER, COPPER = GOLD, SILVER, COPPER
local money

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_Rake = Postal:NewModule("Rake")
Postal_Rake.revision = tonumber(string.sub("$Revision: 73721 $", 12, -3))

function Postal_Rake:OnEnable()
	self:RegisterEvent("MAIL_SHOW")
end

function Postal_Rake:OnDisable()
	-- Disabling modules unregisters all events/hook automatically
end

function Postal_Rake:MAIL_SHOW()
	money = GetMoney()
	self:RegisterEvent("MAIL_CLOSED")
end

function Postal_Rake:MAIL_CLOSED()
	self:UnregisterEvent("MAIL_CLOSED")
	money = GetMoney() - money
	if money > 0 then
		self.core:Print(L["Collected"].." "..self.core:GetMoneyString(money))
	end
end
