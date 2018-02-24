local mod = Chatter:NewModule("Channel Names", "AceHook-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Channel Names"]

local gsub = _G.string.gsub
local find = _G.string.find
local pairs = _G.pairs
local loadstring = _G.loadstring
local tostring = _G.tostring
local GetChannelList = _G.GetChannelList
local select = _G.select

local defaults = {
	profile = {
		channels = {
			[L["Guild"]] = "[G]",
			[L["Party"]] = "[P]",
			[L["Raid"]] = "[R]",
			[L["Raid Leader"]] = "[RL]",
			[L["Raid Warning"]] = "[RW]",
			[L["Officer"]] = "[O]",
			[L["LookingForGroup"]] = "[LFG]",
			[L["Battleground"]] = "[BG]",
			[L["Battleground Leader"]] = "[BL]",
			
			-- Not localized here intentionally
			["Whisper From"] = "[W:From]",
			["Whisper To"] = "[W:To]"
		},
		addSpace = true
	}	
}

local channels

local options = {
	splitter = {
		type = "header",
		name = L["Custom Channels"]
	},
	addSpace = {
		type = "toggle",
		name = L["Add space after channels"],
		desc = L["Add space after channels"],
		get = function() return mod.db.profile.addSpace end,
		set = function(info, v) mod.db.profile.addSpace = v end
	}
}

local serverChannels = {}
local function excludeChannels(...)
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		serverChannels[name] = true
	end
end
local functions = {}

local function addChannel(name)
	options[name:gsub(" ", "_")] = {
		type = "input",
		name = name,
		desc = L["Replace this channel name with..."],
		order = name:lower() == name and 101 or 98,
		get = function()
			local v = mod.db.profile.channels[name]
			return v == "" and " " or v
		end,
		set = function(info, v)
			mod.db.profile.channels[name] = #v > 0 and v or nil
			if v:match("^function%(") then
				functions[name] = loadstring("return " .. v)()
			end
		end
	}
end

function mod:OnInitialize()
	self.db = Chatter.db:RegisterNamespace("ChannelNames", defaults)
	self.db.profile.customChannels = nil
	for k, _ in pairs(self.db.profile.channels) do
		addChannel(k)
	end
	excludeChannels(EnumerateServerChannels())
	for k, v in pairs(serverChannels) do
		addChannel(k)
	end	
	self:AddCustomChannels(GetChannelList())

	for k, v in pairs(self.db.profile.channels) do
		if v:match("^function%(") then
			functions[k] = loadstring("return " .. v)()
		end
	end
end

function mod:AddCustomChannels(...)
	for i = 1, select("#", ...), 2 do
		local id, name = select(i, ...)
		if not serverChannels[name] and not options[name:gsub(" ", "_")] then
			options[name:gsub(" ", "_")] = {
				type = "input",
				name = name,
				desc = L["Replace this channel name with..."],
				order = id <= 4 and 98 or 101,
				get = function()
					local v = self.db.profile.channels[name:lower()]
					return v == "" and " " or v
				end,
				set = function(info, v)
					self.db.profile.channels[name:lower()] = #v > 0 and v or nil
					if v:match("^function%(") then
						functions[name:lower()] = loadstring("return " .. v)()
					end
				end
			}
		end
	end
end

function mod:OnEnable()
	channels = self.db.profile.channels
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
end

function mod:CHAT_MSG_CHANNEL_NOTICE()
	self:AddCustomChannels(GetChannelList())
end

local function replaceChannel(msg, num, channel)
	local v = channels[channel] or channels[channel:lower()]
	if v then
		return (v == " " and (mod.db.profile.addSpace and " " or "")) or ((functions[channel] or functions[channel:lower()] or v) .. (mod.db.profile.addSpace and " " or ""))
	end
end

function mod:AddMessage(frame, text, ...)
	if not text then 
		return self.hooks[frame].AddMessage(frame, text, ...)
	end

	local oldText = text
	text = gsub(text, "(%[([%d. ]*)([^%]]-)%]) ", replaceChannel)
	text = gsub(text, L["^To "], channels["Whisper To"] .. (mod.db.profile.addSpace and " " or ""))
	text = gsub(text, L["^(.-|h) whispers:"], channels["Whisper From"] .. (mod.db.profile.addSpace and " %1:" or "%1:"))
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function mod:GetOptions()
	return options
end

function mod:Info()
	return L["Enables you to replace channel names with your own names"]
end

mod.funcs = functions