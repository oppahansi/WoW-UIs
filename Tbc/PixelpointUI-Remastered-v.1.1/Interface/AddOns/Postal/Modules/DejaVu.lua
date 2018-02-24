--[[ Remember and autofill last person mailed, based on Mailchecker/Easymail/et al ]]--

assert( Postal, "Postal not found!")

------------------------------
--      Are you local?      --
------------------------------

local lastMailed = nil

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_DejaVu = Postal:NewModule("DejaVu")
Postal_DejaVu.revision = tonumber(string.sub("$Revision: 56891 $", 12, -3))

function Postal_DejaVu:OnEnable()
	self:Hook("SendMailFrame_Reset", true)
	self:Hook("MailFrameTab_OnClick", true)
	self:Hook("SendMailFrame_SendMail", true)
	SendMailNameEditBox:SetHistoryLines(15)
end

function Postal_DejaVu:OnDisable()
	-- Disabling modules unregisters all events/hook automatically
	SendMailNameEditBox:SetHistoryLines(1)
end

function Postal_DejaVu:SendMailFrame_Reset()
	if not lastMailed then lastMailed = SendMailNameEditBox:GetText() end
	self.hooks["SendMailFrame_Reset"]()
	if lastMailed then
		SendMailNameEditBox:SetText(lastMailed)
		SendMailNameEditBox:HighlightText()
	end
end

function Postal_DejaVu:SendMailFrame_SendMail()
	lastMailed = SendMailNameEditBox:GetText()
	SendMailNameEditBox:AddHistoryLine(lastMailed)
	self.hooks["SendMailFrame_SendMail"]()
end

function Postal_DejaVu:MailFrameTab_OnClick(tab)
	self.hooks["MailFrameTab_OnClick"](tab)
	if lastMailed and not SendMailNameEditBox:GetText() then
		SendMailNameEditBox:SetText(lastMailed)
		SendMailNameEditBox:HighlightText()
	end
end

