local mod = Chatter:NewModule("Disable Fading")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Disable Fading"]
mod.toggleLabel = L["Disable Fading"]

function mod:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		cf:SetFading(nil)
	end
end

function mod:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		cf:SetFading(true)
	end
end

function mod:Info()
	return L["Makes old text disappear rather than fade out"]
end
