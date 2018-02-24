if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 70475 $"):match("%d+"))

local PitBull = PitBull
local PitBull_RaidTargetIcon = PitBull:NewModule("RaidTargetIcon", "LibRockEvent-1.0")
local self = PitBull_RaidTargetIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-19 11:52:20 -0400 (Sat, 19 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an icon on the unit frame based on which Raid Target it is."] = "공격대 전술 목표에 근거해 유닛 프레임에 아이콘을 보여줍니다.",
	["Raid target"] = "공격대 전술 목표",
	["Options for the raid target icon for this unit."] = "이 유닛에 대한 공격대 전술 목표 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the raid target icon display on the unit frames for this unit type."] = "이 유닛 유형에 대해 유닛 프레임에 공격대 전술 목표 아이콘 표시를 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an icon on the unit frame based on which Raid Target it is."] = "依据指定单位是哪个团队目标而显示一个图标。",
	["Raid target"] = "团队标记",
	["Options for the raid target icon for this unit."] = "针对该单位的团队标记的选项。",
	["Enable"] = "启用",
	["Enables the raid target icon display on the unit frames for this unit type."] = "为该单位类型启用在其单位框体上显示团队图标的功能。",
} or (GetLocale() == "frFR") and {
	["Show an icon on the unit frame based on which Raid Target it is."] = "Affiche une icône sur la fenêtre d'unité si c'est une cible de raid.",
	["Raid target"] = "Cible de raid",
	["Options for the raid target icon for this unit."] = "Options d'icône de cible de raid pour cette unité.",
	["Enable"] = "Activer",
	["Enables the raid target icon display on the unit frames for this unit type."] = "Active l'affichage de l'icône de cible de raid pour les fenêtres d'unité de ce type.",
} or (GetLocale() == "zhTW") and {
	["Show an icon on the unit frame based on which Raid Target it is."] = "在單位框架上顯示團隊鎖定目標的標記.",
	["Raid target"] = "團隊鎖定目標",
	["Options for the raid target icon for this unit."] = "為此單位設定團隊鎖定目標的選項.",
	["Enable"] = "啟用",
	["Enables the raid target icon display on the unit frames for this unit type."] = "為此類單位啟用在框架上顯示團隊鎖定目標圖示.",
} or {}

local L = PitBull:L("PitBull-RaidTargetIcon", localization)

self.desc = L["Show an icon on the unit frame based on which Raid Target it is."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_RaidTargetIcon:RegisterPitBullChildFrames('raidTargetIcon')
PitBull_RaidTargetIcon:RegisterPitBullIconLayoutHandler('raidTargetIcon', 3)

function PitBull_RaidTargetIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("RaidTargetIcon")
	PitBull:SetDatabaseNamespaceDefaults("RaidTargetIcon", "profile", {
		['*'] = {
			disable = false,
		}
	})
end

function PitBull_RaidTargetIcon:OnEnable()
	self:AddEventListener("RAID_TARGET_UPDATE")
	self:AddEventListener("PARTY_MEMBERS_CHANGED", "RAID_TARGET_UPDATE")
end

local configMode = PitBull.configMode

function PitBull_RaidTargetIcon:OnChangeConfigMode(value)
	configMode = value
	for unit, frame in PitBull:IterateUnitFrames() do
		self:Update(unit, frame)
	end
end

local configMode_icons = {}

function PitBull_RaidTargetIcon:Update(unit, frame)
	local index = GetRaidTargetIndex(unit)
	if configMode then
		if not UnitExists(unit) or not index then
			index = configMode_icons[unit]
			if not index then
				index = math.random(1, 8)
				configMode_icons[unit] = index
			end
		end
	end
	if self.db.profile[frame.group].disable then
		index = nil
	end
	if index then
		if not frame.raidTargetIcon then
			frame.raidTargetIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.raidTargetIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
			frame.raidTargetIcon:Hide()
			PitBull:UpdateLayout(frame)
		end
		
		SetRaidTargetIconTexture(frame.raidTargetIcon, index)
	else
		if frame.raidTargetIcon then
			frame.raidTargetIcon = delFrame(frame.raidTargetIcon)
			
			PitBull:UpdateLayout(frame)
		end
	end
end

function PitBull_RaidTargetIcon:RAID_TARGET_UPDATE()
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		self:Update(unit, frame)
	end
end

function PitBull_RaidTargetIcon:OnUpdateFrame(unit, frame)
	self:Update(unit, frame)
end

function PitBull_RaidTargetIcon:OnClearUnitFrame(unit, frame)
	if frame.raidTargetIcon then
		frame.raidTargetIcon = delFrame(frame.raidTargetIcon)
	end
end

local function getEnable(group)
	return not PitBull_RaidTargetIcon.db.profile[group].disable
end
local function setEnable(group, value)
	PitBull_RaidTargetIcon.db.profile[group].disable = not value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_RaidTargetIcon:Update(unit, frame)
	end
end

PitBull_RaidTargetIcon:RegisterPitBullOptionsMethod(function(group)
	return {
		type = 'group',
		name = L["Raid target"],
		desc = L["Options for the raid target icon for this unit."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the raid target icon display on the unit frames for this unit type."],
				get = getEnable,
				set = setEnable,
				passValue = group,
			}
		}
	}
end)
