local L = LibStub("AceLocale-3.0"):GetLocale("ErrorMonster")
ErrorMonster = CreateFrame("Frame")
local addon = ErrorMonster
LibStub("LibSink-2.0"):Embed(addon)

local throttle = {}
local colors = {
	UI_INFO_MESSAGE = { r = 1.0, g = 1.0, b = 0.0, a = 1.0 },
	UI_ERROR_MESSAGE = { r = 1.0, g = 0.1, b = 0.1, a = 1.0 },
}

local function flush(message, r, g, b, a)
	if addon.db.profile.sink20OutputSink == "None" then return end
	if addon.db.profile.combat and InCombatLockdown() then return end
	if throttle[message] and (throttle[message] + 10 > GetTime()) then return end
	throttle[message] = GetTime()
	addon:Pour(message, r, g, b)
end

local map = {
	SYSMSG = "system",
	UI_INFO_MESSAGE = "information",
	UI_ERROR_MESSAGE = "errors",
}
local originalOnEvent = UIErrorsFrame:GetScript("OnEvent")
UIErrorsFrame:SetScript("OnEvent", function(self, event, message, r, g, b, ...)
	if addon.db.profile[map[event]] then
		if event ~= "SYSMSG" then r, g, b = colors[event].r, colors[event].g, colors[event].b end
		flush(message, r or 1.0, g or 0.1, b or 0.1, 1.0)
	else
		return originalOnEvent(self, event, message, r, g, b, ...)
	end
end)

addon:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" and addon == "ErrorMonster" then
		self.db = LibStub("AceDB-3.0"):New("ErrorMonsterDB", {
			profile = {
				sink20OutputSink = "UIErrorsFrame",
				errors = true,
				information = false,
				system = false,
				combat = false,
			},
		}, "Default")

		local args = {
			type = "group",
			handler = self,
			get = function(info) return self.db.profile[info[1]] end,
			set = function(info, v) self.db.profile[info[1]] = v end,
			args = {
				desc = {
					type = "description",
					name = L["addon_desc"],
					order = 1,
					fontSize = "medium",
				},
				errors = {
					type = "toggle",
					name = L["Error"],
					desc = L["Error messages."],
					order = 2,
					width = "full",
				},
				information = {
					type = "toggle",
					name = L["Information"],
					desc = L["Information messages."],
					order = 3,
					width = "full",
				},
				system = {
					type = "toggle",
					name = L["System"],
					desc = L["System messages."],
					order = 4,
					width = "full",
				},
				spacer = {
					type = "description",
					name = "\n",
					order = 10,
				},
				combat = {
					type = "toggle",
					name = L["Hide all messages in combat"],
					desc = L["Hides all the intercepted messages while you are in combat."],
					order = 20,
					width = "full",
				},
			},
		}
		self:SetSinkStorage(self.db.profile)
		local output = self:GetSinkAce3OptionsDataTable()

		LibStub("AceConfig-3.0"):RegisterOptionsTable("ErrorMonster", args)
		LibStub("AceConfig-3.0"):RegisterOptionsTable("ErrorMonster-Output", output)
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ErrorMonster", "ErrorMonster")
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ErrorMonster-Output", L["Output"], "ErrorMonster")
	elseif event == "PLAYER_ENTERING_WORLD" then
		for i in pairs(throttle) do throttle[i] = nil end
	end
end)

addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")

