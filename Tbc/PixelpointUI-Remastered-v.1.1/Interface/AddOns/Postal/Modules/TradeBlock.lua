assert( Postal, "Postal not found!")

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_TradeBlock = Postal:NewModule("TradeBlock")
Postal_TradeBlock.revision = tonumber(string.sub("$Revision: 56891 $", 12, -3))

function Postal_TradeBlock:OnEnable()
	self:RegisterEvent("MAIL_SHOW")
end

function Postal_TradeBlock:OnDisable()
	-- Disabling modules unregisters all events/hook automatically
	SetCVar("BlockTrades", 0)
end

function Postal_TradeBlock:MAIL_SHOW()
	if IsAddOnLoaded("Lexan") then return end
	if ( GetCVar("BlockTrades") == "0" ) then
		self:RegisterEvent("MAIL_CLOSED", "Reset")
		self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
		SetCVar("BlockTrades", 1)
	end
end

function Postal_TradeBlock:Reset()
	self:UnregisterEvent("MAIL_CLOSED")
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	SetCVar("BlockTrades", 0)
end
