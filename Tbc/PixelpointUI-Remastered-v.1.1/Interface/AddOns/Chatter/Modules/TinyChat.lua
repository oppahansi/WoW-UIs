local mod = Chatter:NewModule("Tiny Chat")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Tiny Chat"]

function mod:Info()
	return L["Allows you to make the chat frames much smaller than usual."]
end

function mod:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		cf:SetMinResize(50, 20)
		cf:SetMaxResize(5000, 5000)
	end
end

function mod:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		cf:SetMinResize(296, 75)
		cf:SetMaxResize(608, 400)
	end
end
