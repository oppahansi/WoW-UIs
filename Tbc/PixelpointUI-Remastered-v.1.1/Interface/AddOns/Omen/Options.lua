local MINOR_VERSION = tonumber(("$Revision: 70598 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local rawset, rawget = _G.rawset, _G.rawget
local string_split = string.split
local skinDefaults = {
	Opacity = 1,
	Scale = 100,
	Clamp = true,
	Show = true,
	Bars = {
		Height = 16,
		Spacing = 1,
		StretchTextures = false,
		Animate = true,
		Texture = "Blizzard",
		NumBars = 10,
		Background = {
			Alpha = 0.25,
			Color = 0.2
		}		
	},
	Labels = {
		Positions = {
			Name = { anchor = "LEFT", offset = 10 },
			Threat = { anchor = "RIGHT", offset = -10 },
			TPS = { anchor = "RIGHT", offset = -100 }
		},
		Font = {
			Size = 10,
			Font = "Fritz Quadrata",
			Color = {r = 1, g = 1, b = 1, a = 1},
			Flags = ""
		},
		ShortNumbers = true
	},
	Frames = {
		Background = {
			Color = {r = 0, g = 0, b = 0, a = 1},
			Texture = "Blizzard Tooltip"
		},
		Border = {
			Color = {r = 0.15, g = 0.3, b = 0.65, a = 1},
			Texture = "Blizzard Tooltip"
		},
		Opacity = 1
	},
	Modules = {
		Height = 40,
		Hide = false
	},
	Title = {
		Hide = false,
		HideVersion = false,
		Height = 25
	},
}

local optionDefaults = {
	ActiveSkinName = "Default",
	Skin = skinDefaults,
	HideWhenNotActive = true,
	Lock = false,
	ShowWith = {
		Pet = true,
		Alone = false,
		Party = true,
		Raid = true,
		Resting = false,
		PVP = false,
		Dungeon = true
	},
	Classes = {
		["DRUID"] = true, 
		["HUNTER"] = true, 
		["MAGE"] = true, 
		["PALADIN"] = true, 
		["PET"] = true, 
		["PRIEST"] = true, 
		["ROGUE"] = true, 
		["SHAMAN"] = true, 
		["WARLOCK"] = true, 
		["WARRIOR"] = true
	},
	FuBar = {
		HideMinimapButton = false
	}
}

local function lookupTableValue(t, k)
	if not t then return nil end
	local tt, sk = string_split(".", k, 2)
	local st = t[tt]
	if tt == k then
		return st
	elseif sk and type(st) == "table" then
		if st then
			return lookupTableValue(st, sk)
		else
			return nil
		end
	else
		return nil
	end
end

local function setTableValue(t, k, v)
	if not t then return end
	local tt, sk = string_split(".", k, 2)
	if not sk then
		t[tt] = v
	elseif t[tt] then
		setTableValue(t[tt], sk, v)
	else
		t[tt] = {}
		setTableValue(t[tt], sk, v)
	end
end

local optionsStub = {}
Omen.optionsStub = optionsStub
Omen.Options = setmetatable({}, {
	__index = function(t, k)
		if optionsStub[k] ~= nil then return optionsStub[k] end
		local v = Omen:GetOption(k)
		if v == nil and k:find("^Skin.") and not k:find("^Skin.Frames") then
			v = Omen:GetOption(k:gsub("^Skin%.[^.]+%.", "Skin.Frames."))
		end
		optionsStub[k] = v
		return v
	end,
	__newindex = function(t, k, v)
		rawset(optionsStub, k, v)
		setTableValue(Omen.db.profile.options, k, v)
	end
})

function Omen:RegisterConfigDefaults(n, t)
	optionDefaults[n] = t
end

function Omen:RegisterOptions(n, t)
	assert(Omen.configOptions.args.modules[n] == nil)
	Omen.configOptions.args.modules.args[n] = t
end

function Omen:GetOption(k)
	local opt = lookupTableValue(self.db.profile.options, k)
	if opt ~= nil then
		self.Options[k] = opt
		return opt
	end
	opt = lookupTableValue(optionDefaults, k)
	if opt ~= nil then
		return opt
	end
	return nil
end

function Omen:SetOption(k, v)
	Omen.Options[k] = v
end

function Omen:ResetMemoizations()
	for key, _ in pairs(optionsStub) do
		optionsStub[key] = nil
	end
end

function Omen:ResetOption(k)
	local lv, lt
	local t = self.db.profile.options
	for key, _ in pairs(optionsStub) do
		if key:find(k) == 1 then
			optionsStub[key] = nil
		end
	end
	for v in k:gmatch("([^.]+)") do
		lt = t
		t = t[v]
		lv = v
		if not t then return end
	end
	lt[lv] = nil
end
