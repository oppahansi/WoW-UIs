local MINOR_VERSION = tonumber(("$Revision: 70383 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local lookup_table = {}
local function deepcopy(object)
	for k, v in pairs(lookup_table) do
		lookup_table[k] = v
	end
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

local defaultSkins = {
	Default = {},
	Classic = {
		["Modules"] = {
			["Hide"] = true,
		},
		["Title"] = {
			["Height"] = 13,
			["Background"] = {
				["Color"] = {
					["a"] = 0,
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
			},
			["Border"] = {
				["Color"] = {
					["a"] = 0,
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
			},
			["Hide"] = false,
		},
		["Scale"] = 100,
		["Bars"] = {
			["Autocollapse"] = true,
			["Autohide"] = false,
			["AutohideAll"] = false,
			["Texture"] = "Minimalist",
		},
		["Frames"] = {
			["Border"] = {
				["Color"] = {
					["a"] = 0.5300000011920929,
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
			},
		},
	},
	Compact = {
		["Modules"] = {
			["Hide"] = true,
		},
		["Title"] = {
			["Font"] = "TwCenMT",
			["Height"] = 3,
			["Background"] = {
				["Color"] = {
					["a"] = 0,
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
			},
			["Border"] = {
				["Color"] = {
					["a"] = 0,
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
			},
			["Hide"] = false,
		},
		["Scale"] = 100,
		["Bars"] = {
			["Autocollapse"] = true,
			["Autohide"] = false,
			["AutohideAll"] = false,
			["Height"] = 14,
			["Background"] = {
				["Color"] = 0.05,
				["Alpha"] = 0.75,
			},
			["Spacing"] = 0,
			["Texture"] = "Minimalist",
		},
		["Frames"] = {
			["Border"] = {
				["Color"] = {
					["a"] = 1,
					["r"] = 0.05098039215686274,
					["g"] = 0.07450980392156863,
					["b"] = 0.3803921568627451,
				},
				["Texture"] = "RothSquare",
			},
			["Background"] = {
				["Color"] = {
					["a"] = 0.4000000357627869,
					["b"] = 0.8823529411764706,
					["g"] = 0.5215686274509804,
					["r"] = 0.2431372549019608,
				},
				["Texture"] = "Blizzard Tooltip",
			},
		},
		["Labels"] = {
			["Font"] = {
				["Size"] = 9,
				["Font"] = "TwCenMT",
			},
		}
	}
}

function Omen:SwitchSkin(name)
	local skin = self.db.global.skins[name] or defaultSkins[name]
	self:ResetMemoizations()
	if skin then
		Omen:SetOption("ActiveSkinName", name)
		self.db.profile.LastActiveSkin = deepcopy(self.db.profile.options.Skin)
		self.db.profile.options.Skin = deepcopy(skin)
		self:UpdateDisplay()
	else
		self:Print("Unable to find skin:", name)
	end
end

local skinsLoaded = false
function Omen:PopulateSkinList()
	local skins = self.SkinList
	if skinsLoaded then return skins end
	
	for k, v in pairs(defaultSkins) do
		skins[k] = k
	end
	
	if self.db.profile.skins and type(self.db.profile.skins) == "table" then
		for k, v in pairs(self.db.profile.skins) do
			self.db.global.skins[k] = v
			self.db.profile.skins[k] = nil
		end
	end
	
	for k, v in pairs(self.db.global.skins) do
		skins[k] = k
	end
	skinsLoaded = true
end

function Omen:SaveSkin(name)
	ChatFrame1:AddMessage("Saving skin: " .. name)
	self.db.global.skins[name] = deepcopy(self.db.profile.options.Skin)
	skinsLoaded = false
	self:PopulateSkinList()
end
