local mod = Chatter:NewModule("ChatLink", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Chat Link"]

local gsub = _G.string.gsub
local find = _G.string.find
local GetChannelName = _G.GetChannelName
local EnumerateServerChannels = _G.EnumerateServerChannels
local select = _G.select

local serverChannels = {}
local function excludeChannels(...)
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		serverChannels[name] = true
	end
end

function mod:OnEnable()
	self:RawHook("SendChatMessage", true)
	excludeChannels(EnumerateServerChannels())
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
end

function mod:OnDisable()
end

function mod:ParseLinks(text)
	if not text then return nil end
	text = gsub(text, "{CLINK:item:(%x+):([%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-):([^}]-)}", "|c%1|Hitem:%2|h[%3]|h|r")
	text = gsub(text, "{CLINK:enchant:(%x+):([%d-]-):([^}]-)}", "|c%1|Henchant:%2|h[%3]|h|r")
	text = gsub(text, "{CLINK:spell:(%x+):([%d-]-):([^}]-)}", "|c%1|Hspell:%2|h[%3]|h|r")
	text = gsub(text, "{CLINK:quest:(%x+):([%d-]-):([%d-]-):([^}]-)}", "|c%1|Hquest:%2:%3|h[%4]|h|r")
	text = gsub(text, "{CLINK:(%x+):([%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-:[%d-]-):([^}]-)}", "|c%1|Hitem:%2|h[%3]|h|r")
	return text
end

function mod:CreateLinks(text)
	if not text then return nil end
	text = gsub(text, "|c(%x+)|Hitem:(%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%1:%2:%3}")
	text = gsub(text, "|c(%x+)|H(enchant):(%-?%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%2:%1:%3:%4}")
	text = gsub(text, "|c(%x+)|H(quest):(%-?%d-):(%-?%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%2:%1:%3:%4:%5}")
	text = gsub(text, "|c(%x+)|H(spell):(%-?%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%2:%1:%3:%4}")
	return text
end

function mod:SendChatMessage(msg, chatType, language, channel)
    if msg and (chatType == "CHANNEL") then
        local _, chanName = GetChannelName(channel)
        if chanName and not find(chanName, L["Trade -"]) and not serverChannels[chanName] then
            msg = self:CreateLinks(msg)
        end
    end
    self.hooks.SendChatMessage(msg, chatType, language, channel)
end

function mod:AddMessage(frame, text, ...)
	return self.hooks[frame].AddMessage(frame, mod:ParseLinks(text), ...)
end

function mod:Info()
	return L["Lets you link items, enchants, spells, and quests in custom channels."]
end
