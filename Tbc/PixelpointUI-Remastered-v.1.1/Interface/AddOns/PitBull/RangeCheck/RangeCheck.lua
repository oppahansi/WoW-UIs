if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 69009 $"):match("%d+"))

local localization = (GetLocale() == "koKR") and {
	["Range checking for PitBull unit frames."] = "PitBull 유닛 프레임을 위해 사정 거리를 확인합니다.",
	["Range checking"] = "사정 거리 확인",
	["Options for range checking between you and other units."] = "자신과 다른 유닛간의 사정 거리 확인을 위한 옵션입니다.",
	["Opacity"] = "투명도",
	["Set the opacity to use on units that are not in range of you."] = "자신의 사정 거리 밖에 있는 유닛에 사용할 투명도를 설정합니다.",
	["Enabled"] = "활성화",
	["Enable range checking."] = "사정 거리 확인을 활성화합니다.",
	["Interval"] = "간격",
	["Set how often the range should be checked."] = "사정 거리 확인 빈도를 설정합니다.",
	["Enable range check"] = "사정 거리 확인 활성화",
	["Range check turns units which are out of range slightly transparent."] = "사정 거리 밖에 있는 유닛은 약간 투명하게 전환해 사정 거리를 확인합니다.",
} or (GetLocale() == "zhCN") and {
	["Range checking for PitBull unit frames."] = "PitBull单位框体距离侦测功能。",
	["Range checking"] = "距离侦测",
	["Options for range checking between you and other units."] = "侦测你同其他单位之间距离的选项。",
	["Opacity"] = "透明度",
	["Set the opacity to use on units that are not in range of you."] = "为不在你范围内的单位设置透明度。",
	["Enabled"] = "启用",
	["Enable range checking."] = "启用距离侦测。",
	["Interval"] = "间隔时间",
	["Set how often the range should be checked."] = "设置检测距离的频繁度。",
	["Enable range check"] = "启用距离检测",
	["Range check turns units which are out of range slightly transparent."] = "距离检测会将那些不在有效范围内的单位的框体变得稍微透明一点。",
} or (GetLocale() == "frFR") and {
	["Range checking for PitBull unit frames."] = "Vérification de la distance pour les fenêtres d'unités de PitBull.",
	["Range checking"] = "Vérification de la distance",
	["Options for range checking between you and other units."] = "Options pour la vérification de la distance entre les autres unités et vous.",
	["Opacity"] = "Opacité",
	["Set the opacity to use on units that are not in range of you."] = "Définit l'opacité à utiliser sur les unités qui ne sont pas à distance.",
	["Enabled"] = "Activé",
	["Enable range checking."] = "Activer la vérification de la distance.",
	["Interval"] = "Intervalle",
	["Set how often the range should be checked."] = "Définit la fréquence à laquelle la distance doit être vérifiée.",
	["Enable range check"] = "Activer la vérification de distance",
	["Range check turns units which are out of range slightly transparent."] = "La vérification de distance affiche les unités qui sont trop loin un peu en transparence.",
} or (GetLocale() == "zhTW") and {
	["Range checking for PitBull unit frames."] = "PitBull單位框架射程檢測.",
	["Range checking"] = "射程檢測",
	["Options for range checking between you and other units."] = "為你和其他單位之間的距離檢測進行設置.",
	["Opacity"] = "不透明度",
	["Set the opacity to use on units that are not in range of you."] = "如果目標不在你的射程內,設定不透明性的使用方法.",
	["Enabled"] = "啟用",
	["Enable range checking."] = "啟用射程檢測.",
	["Interval"] = "間隔時間",
	["Set how often the range should be checked."] = "設定進行檢測的間隔時間.",
	["Enable range check"] = "啟用射程檢測",
	["Range check turns units which are out of range slightly transparent."] = "射程檢測使單位能更清楚地看到對方是否在射程之內.",
} or {}

local L = PitBull:L("PitBull-RangeCheck", localization)

local distanceCheckFunction
local distanceCheckFunctionLow
local running
do
	local _,class = UnitClass("player")
	if class == "PRIEST" then
		distanceCheckFunction = function(unit) return IsSpellInRange(GetSpellInfo(29170), unit) == 1 or not UnitIsFriend("player", unit) end
	elseif class == "DRUID" then
		distanceCheckFunction = function(unit) return IsSpellInRange(GetSpellInfo(5185), unit) == 1 or not UnitIsFriend("player", unit) end
	elseif class == "PALADIN" then
		distanceCheckFunction = function(unit) return IsSpellInRange(GetSpellInfo(635), unit) == 1 or not UnitIsFriend("player", unit) end
	elseif class == "SHAMAN" then
		distanceCheckFunction = function(unit) return IsSpellInRange(GetSpellInfo(331), unit) == 1 or not UnitIsFriend("player", unit) end
	elseif class == "WARLOCK" then
		distanceCheckFunction = function(unit) return IsSpellInRange(GetSpellInfo(172), unit) == 1 or IsSpellInRange(GetSpellInfo(686), unit) == 1 or CheckInteractDistance(unit, 4) end
		distanceCheckFunctionLow = function(unit) return IsSpellInRange(GetSpellInfo(5782), unit) == 1 or UnitIsFriend("player", unit) end
	elseif class == "MAGE" then
		distanceCheckFunction = function(unit) return IsSpellInRange(GetSpellInfo(133), unit) == 1 or CheckInteractDistance(unit, 4) end
		distanceCheckFunctionLow = function(unit) return IsSpellInRange(GetSpellInfo(2136), unit) == 1 or UnitIsFriend("player", unit) end
	elseif class == "HUNTER" then
		distanceCheckFunction = function(unit) 
			return IsSpellInRange(UnitIsUnit(unit, "pet") == 1 and GetSpellInfo(136) or GetSpellInfo(75), unit) == 1 or CheckInteractDistance(unit, 4)
		end 
	else
		distanceCheckFunction = function(unit) return CheckInteractDistance(unit, 4) end
	end
	running = false
end

local PitBull = PitBull
local PitBull_RangeCheck = PitBull:NewModule("RangeCheck", "LibRockTimer-1.0")
local self = PitBull_RangeCheck
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-10 19:39:36 -0400 (Thu, 10 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end
self.desc = L["Range checking for PitBull unit frames."]

function PitBull_RangeCheck:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("RangeCheck")
	PitBull:SetDatabaseNamespaceDefaults("RangeCheck", "profile", {
		opacity = 0.6,
		interval = 0.7,
		enabled = true,
		groups = {
			player = {
				ignore = true,
			},
			target = {
				ignore = true,
			},
			targettarget = {
				ignore = true,
			},
			targettargettarget = {
				ignore = true,
			},
			['*'] = {},
		}
	})
end

function PitBull_RangeCheck:OnEnable()
	self:Enable()
end

function PitBull_RangeCheck:OnDisable()
	self:Disable()
end

function PitBull_RangeCheck:Enable()
	if self.db.profile.enabled and not running then
		self:AddRepeatingTimer("PitBull_RangeCheck", self.db.profile.interval, "RangeCheck")
		running = true
	end
end

function PitBull_RangeCheck:Disable()
	if running then
		self:RemoveTimer("PitBull_RangeCheck")
	
		for unit, frame in PitBull:IterateUnitFrames() do
			frame:SetAlpha(1)
		end
		running = false
	end
end

function PitBull_RangeCheck:RangeCheck()
	local opacity = self.db.profile.opacity
	for unit, frame in PitBull:IterateUnitFrames() do
		if frame:IsVisible() and not self.db.profile.groups[frame.group].ignore then
			if distanceCheckFunction(unit) then
				if distanceCheckFunctionLow then
					if distanceCheckFunctionLow( unit ) then
						frame:SetAlpha(1)
					else
						frame:SetAlpha(opacity+(1-opacity)/2)
					end
				else
					frame:SetAlpha(1)
				end
			else
				frame:SetAlpha(opacity)
			end
		end
	end
end


-- Global Options
PitBull:RegisterGlobalSetting("rangecheck", function() return "@cache", {
	name = L["Range checking"],
	desc = L["Options for range checking between you and other units."],
	type = 'group',
	hidden = function() return not PitBull_RangeCheck:IsActive() end,
	args = {
		opacity = {
			type = 'number',
			name = L["Opacity"],
			desc = L["Set the opacity to use on units that are not in range of you."],
			get = function()
				return (PitBull_RangeCheck.db.profile.opacity)
			end,
			set = function(opacity)
				PitBull_RangeCheck.db.profile.opacity = opacity
			end,
			step = 0.01,
			bigStep = 0.05,
			disabled = function()
				return not PitBull_RangeCheck.db.profile.enabled
			end,
		},
		enabled = {
			type = 'boolean',
			name = L["Enabled"],
			desc = L["Enable range checking."],
			get = function()
				return (PitBull_RangeCheck.db.profile.enabled)
			end,
			set = function(enabled)
				PitBull_RangeCheck.db.profile.enabled = enabled
				if enabled then
					PitBull_RangeCheck:Enable()
				else
					PitBull_RangeCheck:Disable()
				end
			end,
		},
		interval = {
			type = 'number',
			name = L["Interval"],
			desc = L["Set how often the range should be checked."],
			get = function()
				return (PitBull_RangeCheck.db.profile.interval)
			end,
			set = function(interval)
				PitBull_RangeCheck.db.profile.interval = interval
				if running then
					PitBull_RangeCheck:Disable()
					PitBull_RangeCheck:Enable()
				end
			end,
			min = 0.1,
			max = 10,
			step = 0.1,
			disabled = function()
				return not PitBull_RangeCheck.db.profile.enabled
			end,
		},
	},
} end)

-- Unit/Group Specific Options
local function getEnabled(group)
	return not PitBull_RangeCheck.db.profile.groups[group].ignore
end
local function setEnabled(group, value)
	PitBull_RangeCheck.db.profile.groups[group].ignore = not value
	if not value then
		for unit, frame in PitBull:IterateUnitFrames() do
			if frame.group ==  group then
				frame:SetAlpha(1)
			end
		end
	end
end
PitBull_RangeCheck:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["Enable range check"],
		desc = L["Range check turns units which are out of range slightly transparent."],
		type = 'boolean',
		get = getEnabled,
		set = setEnabled,
		passValue = group,
	}
end)

