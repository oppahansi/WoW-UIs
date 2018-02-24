local mod = Chatter:NewModule("Link Hover", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Link Hover"]

local strmatch = _G.string.match
local linkTypes = {
	item = true,
	enchant = true,
	spell = true,
	quest = true,
	-- player = true
}

function mod:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G["ChatFrame"..i]
		self:HookScript(frame, "OnHyperlinkEnter", enter)
		self:HookScript(frame, "OnHyperlinkLeave", leave)
	end
end

function mod:OnHyperlinkEnter(f, link)
	local t = strmatch(link, "^(.-):")
	if linkTypes[t] then
		ShowUIPanel(GameTooltip)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end			
end

function mod:OnHyperlinkLeave(f, link)
	local t = strmatch(link, "^(.-):")
	if linkTypes[t] then
		HideUIPanel(GameTooltip)
	end
end

function mod:Info()
	return L["Makes link tooltips show when you hover them in chat."]
end
