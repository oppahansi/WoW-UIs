assert(Cartographer, "Cartographer not found!")
local Cartographer = Cartographer
local revision = tonumber(string.sub("$Revision: 56068 $", 12, -3))
if revision > Cartographer.revision then
	Cartographer.version = "r" .. revision
	Cartographer.revision = revision
	Cartographer.date = string.sub("$Date: 2007-11-26 15:54:07 -0500 (Mon, 26 Nov 2007) $", 8, 17)
end

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Cartographer_POI")
L:AddTranslations("enUS", function() return {
	["POI"] = true,

	["Module to manage points of interest."] = true,
} end)

L:AddTranslations("deDE", function() return {
	["POI"] = "PoI",

	["Module to manage points of interest."] = "Modul zur Verwaltung interessanter Orte ('Points of Interest').",
} end)

L:AddTranslations("esES", function() return {
	["POI"] = "PdI",

	["Module to manage points of interest."] = "M\195\179dulo que gestiona los puntos de inter\195\169s",
} end)

L:AddTranslations("koKR", function() return {
	["POI"] = "포인트",

	["Module to manage points of interest."] = "위치 포인트 관리 모듈을 제공합니다.",
} end)

L:AddTranslations("zhTW", function() return {
	["POI"] = "資訊點",

	["Module to manage points of interest."] = "管理資訊點的模組。",
} end)

L:AddTranslations("frFR", function() return {
	["POI"] = "POI",

	["Module to manage points of interest."] = "Module de gestion des endroits importants des villes.",
} end)
L:AddTranslations("zhCN", function() return {
	["POI"] = "信息点",

	["Module to manage points of interest."] = "管理信息点",
} end)

local path = debugstack(1, 1, 0)
if path:find("grapher\\") then
	path = "Interface\\AddOns\\Cartographer\\Cartographer_POI\\Artwork\\"
elseif path:find("grapher_POI\\") then
	path = "Interface\\AddOns\\Cartographer_POI\\Artwork\\"
else
	error("Cannot determine path of artwork")
end

-- Icon courtesy Benji Park, from Openclipart.org
local icon = {
	text = L["POI"],
	path = path .. "button-blue",
	width = 12,
	height = 12,
}
local mod = Cartographer:NewModule("POI", "LibRockEvent-1.0")
mod.L = L

function mod:OnInitialize()
	self.name    = L["POI"]
	self.title   = L["POI"]
	self.author  = "Chris 'kergoth' Larson"
	self.notes   = L["Module to manage points of interest."]
	self.email   = "clarson@kergoth.com"
	self.website = nil
	self.version = nil

	local opts = {
		name = L["POI"],
		desc = self.notes,
		type = "group",
		args = {
			toggle = {
				name = Cartographer.L["Enabled"],
				desc = Cartographer.L["Suspend/resume this module."],
				type  = "toggle",
				order = -1,
				get   = function() return Cartographer:IsModuleActive(self) end,
				set   = function() Cartographer:ToggleModuleActive(self) end,
			},
		},
		handler = self,
	}
	Cartographer.options.args.POI = opts

	self.db = Cartographer:AcquireDBNamespace("POI")
	Cartographer:RegisterDefaults("POI", "profile", { pois = {} })
	
end

function mod:OnEnable()
	self:AddEventListener("WORLD_MAP_UPDATE")

	if Cartographer_Notes then
		Cartographer_Notes:RegisterNotesDatabase("POI", self.db.profile.pois, self)
		Cartographer_Notes:RegisterIcon("POI", icon)
	else
		Cartographer:ToggleModuleActive(self, false)
	end
end

function mod:OnDisable()
	if Cartographer_Notes then
		Cartographer_Notes:UnregisterIcon("POI")
		Cartographer_Notes:UnregisterNotesDatabase("POI")
	end
end

function mod:WORLD_MAP_UPDATE()
	local zone = GetRealZoneText()
	local name, _, tex, x, y
	for landmark = 1, GetNumMapLandmarks(), 1 do
		name, _, tex, x, y = GetMapLandmarkInfo(landmark)
		if tex == 6 then
			Cartographer_Notes:SetNote(zone, x, y,
			                           "POI",
			                           "POI",
			                           "title", name,
			                           "titleR", 1.0,
			                           "titleG", 0.5,
			                           "titleB", 0.0)
		end
	end
end
