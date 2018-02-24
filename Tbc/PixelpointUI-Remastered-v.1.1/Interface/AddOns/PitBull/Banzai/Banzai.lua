if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 68199 $"):match("%d+"))

local localization = (GetLocale() == "koKR" and {
	["Adds aggro coloring to PitBull."] = "PitBull에 어그로 색상화를 추가합니다.",
	["Aggro color"] = "어그로 색상",
	["Sets which color to use on the health bar of units that have aggro."] = "어그로를 갖고 있는 유닛의 생명력바에 사용할 색상을 설정합니다",
	["Enable aggro indicator"] = "어그로 아이콘 활성화",
	["Change the color of this unit's health bar when it gets aggro."] = "어그로를 획득한 경우 이 유닛의 생명력바의 색상을 변경합니다.",
}) or (GetLocale() == "zhCN" and {
	["Adds aggro coloring to PitBull."] = "为PitBull添加仇恨上色功能。",
	["Aggro color"] = "获得仇恨的颜色",
	["Sets which color to use on the health bar of units that have aggro."] = "设置获得仇恨的单位的生命条的颜色。",
	["Enable aggro indicator"] = "开启仇恨指示器",
	["Change the color of this unit's health bar when it gets aggro."] = "当该单位获得仇恨时改变其生命条的颜色。",
}) or (GetLocale() == "frFR" and {
	["Adds aggro coloring to PitBull."] = "Ajoute la coloration par aggro.",
	["Aggro color"] = "Couleur de l'aggro",
	["Sets which color to use on the health bar of units that have aggro."] = "Définit quelle couleur doit être utilisée pour la barre de vie des unités qui ont l'aggro.",
	["Enable aggro indicator"] = "Activer l'indicateur d'aggro",
	["Change the color of this unit's health bar when it gets aggro."] = "Changer la couleur de la barre de vie des unités quand elles prennent l'aggro.",
}) or (GetLocale() == "zhTW" and {
	["Adds aggro coloring to PitBull."] = "為PitBull增加取得仇恨時的顏色.",
	["Aggro color"] = "取得仇恨的顏色",
	["Sets which color to use on the health bar of units that have aggro."] = "設定取得仇恨時此單位的生命條顏色.",
	["Enable aggro indicator"] = "啟用仇恨指示器",
	["Change the color of this unit's health bar when it gets aggro."] = "改變當此單位取得仇恨時的生命條顏色.",
}) or {}
local L = PitBull:L("PitBull-Banzai", localization)

PitBull_Banzai = PitBull:NewModule("Banzai", "LibRockEvent-1.0", "LibRockHook-1.0")
local PitBull_Banzai = PitBull_Banzai
local self = PitBull_Banzai
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-05 21:15:48 -0400 (Sat, 05 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end
self.desc = L["Adds aggro coloring to PitBull."]

local PitBull_HealthBar = PitBull:GetModule("HealthBar")

local banzai

function PitBull_Banzai:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("Banzai")
	PitBull:SetDatabaseNamespaceDefaults("Banzai", "profile", {
		color = {1.0, 0, 0, 1.0},
		groups = {
			target = {
				ignore = true,
			},
			targettarget = {
				ignore = true,
			},
			targettargettarget = {
				ignore = true,
			},
			["*"] = {},
		}
	})
end

local function callback(aggro, name, ...)
	for frame in PitBull:IterateUnitFramesForUnitName(name) do
		if frame and not self.db.profile.groups[frame.group].ignore then
			self:UpdateHealthbarColor(PitBull_HealthBar, name, frame)
		end
	end
end

function PitBull_Banzai:OnEnable()
	banzai = Rock("LibBanzai-2.0", false, true)
	if not banzai then
		error("PitBull_Banzai requires the library LibBanzai-2.0 to be available.")
	end
	
	banzai:RegisterCallback(callback)
	self:AddHook(PitBull_HealthBar, "UpdateHealthbarColor")
end

function PitBull_Banzai:OnDisable()
	banzai:UnregisterCallback(callback)
end

function PitBull_Banzai:UpdateHealthbarColor(module, unit, frame)
	if not frame.healthBar then
		return self.hooks[module].UpdateHealthbarColor(module, unit, frame)
	end
	if not self.db.profile.groups[frame.group].ignore then
		local aggro = banzai:GetUnitAggroByUnitId(unit)
		if aggro then
			local color = self.db.profile.color
			frame.healthBar:SetColor(unpack(color))
			frame.healthBar:SetBackgroundColor(nil)
			return
		end
	end
	self.hooks[module].UpdateHealthbarColor(module, unit, frame)
end
-- Global Options
PitBull:RegisterGlobalSetting("colors", "args", "banzai", function() return "@cache", {
	type = 'color',
	name = L["Aggro color"],
	desc = L["Sets which color to use on the health bar of units that have aggro."],
	get = function()
		return unpack(PitBull_Banzai.db.profile.color)
	end,
	set = function(r, g, b, a)
		PitBull_Banzai.db.profile.color = {r, g, b, a}
		for unit,frame in PitBull:IterateUnitFrames() do
			PitBull_Banzai:UpdateHealthbarColor(PitBull_HealthBar, unit, frame)
		end
	end,
} end)
-- Unit/Group Specific Options
local function getEnabled(group)
	return not PitBull_Banzai.db.profile.groups[group].ignore
end
local function setEnabled(group, value)
	PitBull_Banzai.db.profile.groups[group].ignore = not value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_Banzai:UpdateHealthbarColor(PitBull_HealthBar, unit, frame)
	end
end
PitBull_Banzai:RegisterPitBullOptionsMethod(function(group)
	return {
		type = 'boolean',
		name = L["Enable aggro indicator"],
		desc = L["Change the color of this unit's health bar when it gets aggro."],
		get = getEnabled,
		set = setEnabled,
		passValue = group,
	}
end)

