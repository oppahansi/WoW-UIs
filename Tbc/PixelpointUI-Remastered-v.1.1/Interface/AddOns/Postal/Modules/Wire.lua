--[[ Postal_Wire: Update Subject Field with Money Amount if blank ]]--

assert( Postal, "Postal not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Postal")

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_Wire = Postal:NewModule("Wire")
Postal_Wire.revision = tonumber(string.sub("$Revision: 73730 $", 12, -3))

function Postal_Wire:OnEnable()
	self:SecureHook(SendMailMoney, "onvalueChangedFunc")
end

function Postal_Wire:OnDisable()
	-- Disabling modules unregisters all events/hook automatically
end

local g, s, c
if GOLD then -- remove on next patch, for pre 2.4.2 compat
	g = L["^%[%d+g %d+s %d+c%]$"]
	s = L["^%[%d+s %d+c%]$"]
	c = L["^%[%d+c%]$"]
else
	g = "^%["..GOLD_AMOUNT.." "..SILVER_AMOUNT.." "..COPPER_AMOUNT.."%]$"
	s = "^%["..SILVER_AMOUNT.." "..COPPER_AMOUNT.."%]$"
	c = "^%["..COPPER_AMOUNT.."%]$"
	g = gsub(g, "%%d", "%%d+")
	s = gsub(s, "%%d", "%%d+")
	c = gsub(c, "%%d", "%%d+")
end
function Postal_Wire:onvalueChangedFunc()
	local subject = SendMailSubjectEditBox:GetText()
	if subject == ""
	or subject:find(g)
	or subject:find(s)
	or subject:find(c)
	then
		local copper = MoneyInputFrame_GetCopper(SendMailMoney)
		if copper and copper > 0 then
			SendMailSubjectEditBox:SetText("["..self.core:GetMoneyString(copper).."]")
		else
			SendMailSubjectEditBox:SetText("")
		end
	end
end
