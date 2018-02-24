local mod = Chatter:NewModule("Mousewheel Scroll", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Mousewheel Scroll"]

local IsShiftKeyDown = _G.IsShiftKeyDown
local IsControlKeyDown = _G.IsControlKeyDown

local scrollFunc = function(self, arg1)
	if arg1 > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		elseif IsControlKeyDown() then
			self:PageUp()
		else
			for i = 1, mod.db.profile.scrollLines do
				self:ScrollUp()
			end
		end
	elseif arg1 < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		elseif IsControlKeyDown() then
			self:PageDown()
		else
			for i = 1, mod.db.profile.scrollLines do
				self:ScrollDown()
			end
		end
	end
end

local defaults = { profile = { scrollLines = 1 } }
local options = {
	lines = {
		type = "range",
		name = L["Scroll lines"],
		desc = L["How many lines to scroll per mouse wheel click"],
		min = 1,
		max = 20,
		step = 1,
		bigStep = 1,
		get = function() return mod.db.profile.scrollLines end,
		set = function(info, v) mod.db.profile.scrollLines = v end
	}
}

function mod:OnInitialize()
	self.db = Chatter.db:RegisterNamespace(self:GetName(), defaults)
end

function mod:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[("%s%d"):format("ChatFrame", i)]
		cf:SetScript("OnMouseWheel", scrollFunc)
		cf:EnableMouseWheel(true)
	end
end

function mod:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[("%s%d"):format("ChatFrame", i)]
		cf:SetScript("OnMouseWheel", nil)
		cf:EnableMouseWheel(false)
	end
end

function mod:Info()
	return L["Lets you use the mousewheel to page up and down chat."]
end

function mod:GetOptions()
	return options
end
