if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
PitBull:SetModuleDefaultState("ThreatBar", false)
local PitBull_ThreatBar = PitBull:NewModule("ThreatBar", "LibRockEvent-1.0")
local self = PitBull_ThreatBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a threat bar on the unit frame."] = "유닛 프레임에 위협 바를 보여줍니다.",
	["Threat"] = "위협",
	["Threat bar"] = "위협 바",
	["Set the colors for the threat bar."] = "위협 바를 위한 색상을 설정합니다.",
	["Color"] = "색상",
	["Set the color for the threat bar."] = "위협 바를 위한 색상을 설정합니다.",
	["Background color"] = "배경 색상",
	["Set the background color for the threat bar."] = "위협 바를 위한 배경 색상을 설정합니다.",
	["Options for the units threat bar."] = "유닛의 위협 바를 위한 옵션.",
	["Enable"] = "활성화",
	["Enable the threat bar."] = "위협 바를 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show a threat bar on the unit frame."] = "在单位框体上显示一个仇恨条。",
	["Threat"] = "仇恨",
	["Threat bar"] = "仇恨条",
	["Set the colors for the threat bar."] = "设置仇恨条的颜色。",
	["Color"] = "颜色",
	["Set the color for the threat bar."] = "设置仇恨条的颜色。",
	["Background color"] = "背景颜色",
	["Set the background color for the threat bar."] = "设置仇恨条的背景颜色。",
	["Options for the units threat bar."] = "单位仇恨条的选项。",
	["Enable"] = "启用",
	["Enable the threat bar."] = "启用仇恨条。",
} or (GetLocale() == "frFR") and {
	["Show a threat bar on the unit frame."] = "Affiche une barre de menace sur la fenêtre d'unité.",
	["Threat"] = "Menace",
	["Threat bar"] = "Barre de menace",
	["Set the colors for the threat bar."] = "Définit la couleur pour la barre de menace.",
	["Color"] = "Couleur",
	["Set the color for the threat bar."] = "Définit la couleur pour la barre de menace.",
	["Background color"] = "Arrière-plan",
	["Set the background color for the threat bar."] = "Définit l'arrière-plant pour la barre de menace.",
	["Options for the units threat bar."] = "Options pour la barre de menace de l'unité.",
	["Enable"] = "Activer",
	["Enable the threat bar."] = "Activer la barre de menace.",
} or (GetLocale() == "zhTW") and {
	["Show a threat bar on the unit frame."] = "在單位框架上顯示仇恨條.",
	["Threat"] = "仇恨",
	["Threat bar"] = "仇恨條",
	["Set the colors for the threat bar."] = "設定仇恨條顏色.",
	["Color"] = "顏色",
	["Set the color for the threat bar."] = "設定仇恨條顏色.",
	["Background color"] = "背景色",
	["Set the background color for the threat bar."] = "設定仇恨條背景顏色.",
	["Options for the units threat bar."] = "仇恨條設定選項.",
	["Enable"] = "啟用",
	["Enable the threat bar."] = "啟用仇恨條",
} or {}

local L = PitBull:L("PitBull-ThreatBar", localization)

self.desc = L["Show a threat bar on the unit frame."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local WoW24 = not not _G.UnitClassBase

local ThreatLib

PitBull_ThreatBar:RegisterPitBullChildFrames('threatBar')
PitBull_ThreatBar:RegisterPitBullBarLayoutHandler("threatBar", L["Threat bar"], L["Threat"])

function PitBull_ThreatBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("ThreatBar")
	PitBull:SetDatabaseNamespaceDefaults("ThreatBar", "profile", {
		['**'] = {
			ignore = false,
		},
		colors = {.75, 0, 0},
		bgColors = {.25, 0, 0},
	})
end

function PitBull_ThreatBar:OnEnable(first)
	if WoW24 then
		ThreatLib = Rock("Threat-2.0", false, true)
		if not ThreatLib then
			error("PitBull_ThreatBar requires the library Threat-2.0 to be available.")
		end
		ThreatLib.RegisterCallback(self, "ThreatUpdated", "Threat_ThreatUpdated")
		ThreatLib.RegisterCallback(self, "Activate", "Threat_Activate")
		ThreatLib.RegisterCallback(self, "Deactivate", "Threat_Deactivate")
	else
		ThreatLib = Rock("Threat-1.0", false, true)
		if not ThreatLib then
			error("PitBull_ThreatBar requires the library Threat-1.0 to be available.")
		end
		self:AddEventListener("AceEvent-2.0", "Threat_ThreatUpdated")
		self:AddEventListener("AceEvent-2.0", "Threat_Activate")
		self:AddEventListener("AceEvent-2.0", "Threat_Deactivate")
	end
	self:AddEventListener("PLAYER_TARGET_CHANGED")
	self:AddEventListener("PARTY_MEMBERS_CHANGED")
	self:AddEventListener("RAID_ROSTER_UPDATE", "PARTY_MEMBERS_CHANGED")
	self:AddEventListener("UNIT_PET", "PARTY_MEMBERS_CHANGED")
	self:AddEventListener("PLAYER_PET_CHANGED", "PARTY_MEMBERS_CHANGED")
end

local playerRaidID
local petRaidID
function PitBull_ThreatBar:PARTY_MEMBERS_CHANGED()
	local raid = GetNumRaidMembers()
	playerRaidID = nil
	petRaidID = nil
	if raid > 0 then
		for i = 1, raid do
			if UnitIsUnit("player", "raid" .. i) then
				playerRaidID = "raid" .. i
				break
			end
		end
		if UnitExists("pet") then
			for i = 1, raid do
				if UnitIsUnit("pet", "raidpet" .. i) then
					petRaidID = "raidpet" .. i
					break
				end
			end
		end
	end
end

local targetName
function PitBull_ThreatBar:PLAYER_TARGET_CHANGED()
	targetName = UnitName("target")
	
	for unit, frame in PitBull:IterateUnitFrames() do
		self:UpdateThreat(unit, frame)
	end
end

if WoW24 then
	function PitBull_ThreatBar:Threat_ThreatUpdated(event, srcGuid, dstGuid)
		-- TODO: make this actually check GUIDs
		for unit, frame in PitBull:IterateUnitFrames() do
			self:UpdateThreat(unit, frame)
		end
	end
else
	function PitBull_ThreatBar:Threat_ThreatUpdated(ns, event, name, unit, hash, value)
		if not targetName then
			return
		end
	
		if ThreatLib:UnitIsUnit(targetName, hash) then
			self:UpdateThreat(unit)
		end
	end
end

function PitBull_ThreatBar:Threat_Activate()
	for unit, frame in PitBull:IterateUnitFrames() do
		self:OnPopulateUnitFrame(unit, frame)
		PitBull:UpdateLayout(frame)
	end
end

function PitBull_ThreatBar:Threat_Deactivate()
	for unit, frame in PitBull:IterateUnitFrames() do
		self:OnClearUnitFrame(unit, frame)
		PitBull:UpdateLayout(frame)
	end
end

function PitBull_ThreatBar:UpdateThreat(unit, frame)
	if not frame then
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			self:UpdateThreat(unit, frame)
		end
		if unit == "player" then
			if playerRaidID then
				self:UpdateThreat(playerRaidID)
			end
		elseif unit == "pet" then
			if petRaidID then
				self:UpdateThreat(petRaidID)
			end
		end
		return
	end
	if not frame.threatBar then
		return
	end
	
	local current, max
	if targetName then
		if WoW24 then
			local targetGuid = UnitGUID("target")
			current, max = ThreatLib:GetThreat(UnitGUID(unit), targetGuid), ThreatLib:GetMaxThreatOnTarget(targetGuid)
		else
			current, max = ThreatLib:GetThreat(UnitName(unit), targetName), ThreatLib:GetMaxThreatOnTarget(targetName)
		end
	end
	if not max or max == 0 then
		current = 0
		max = 1
	end
	frame.threatBar:SetValue(current / max)
	local r, g, b = unpack(self.db.profile.colors)
	local br, bg, bb = unpack(self.db.profile.bgColors)
	frame.threatBar:SetColor(r, g, b)
	frame.threatBar:SetBackgroundColor(br, bg, bb)
end

function PitBull_ThreatBar:OnUpdateFrame(unit, frame)
	if not unit:find("target$") then
		self:UpdateThreat(unit, frame)
	end
end

function PitBull_ThreatBar:OnPopulateUnitFrame(unit, frame)
	if frame.threatBar or self.db.profile[frame.group].ignore then
		return 
	end
	if unit:find("target$") then
		return
	end
	if not ThreatLib or not ThreatLib:IsActive() then
		return
	end
	local threatBar = newFrame("FakeStatusBar", frame)
	frame.threatBar = threatBar
	threatBar:SetTexture(PitBull:GetStatusBarTexture())
	threatBar:SetColor(unpack(self.db.profile.colors))
end

function PitBull_ThreatBar:OnClearUnitFrame(unit, frame)
	if frame.threatBar then
		frame.threatBar = delFrame(frame.threatBar)
	end
end

function PitBull_ThreatBar:OnUpdateStatusBarTexture(texture)
	for frame in PitBull:IterateUnitFramesForUnit("target") do
		if frame.threatBar then
			frame.threatBar:SetTexture(texture)
		end
	end
end

local function getDisabled(group)
	return self.db.profile[group].ignore
end
local function getEnabled(group)
	return not self.db.profile[group].ignore
end
local function setEnabled(group, value)
	self.db.profile[group].ignore = not value
	
	if not value then
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			if frame.threatBar then
				PitBull_ThreatBar:OnClearUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end
	else
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			if not frame.threatBar then
				PitBull_ThreatBar:OnPopulateUnitFrame(unit, frame)
				PitBull_ThreatBar:UpdateThreat(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end
	end
end

PitBull:RegisterGlobalSetting("colors", "args", "threatBar", function() return "@cache", {
	type = 'group',
	name = L["Threat"],
	desc = L["Set the colors for the threat bar."],
	args = {
		bar = {
			type = 'color',
			name = L["Color"],
			desc = L["Set the color for the threat bar."],
			get = function()
				return unpack(PitBull_ThreatBar.db.profile.colors)
			end,
			set = function(r, g, b)
				PitBull_ThreatBar.db.profile.colors = {r, g, b}

				for unit, frame in PitBull:IterateUnitFrames() do
					PitBull_ThreatBar:UpdateThreat(unit, frame)
				end
			end,
		},
		background = {
			type = 'color',
			name = L["Background color"],
			desc = L["Set the background color for the threat bar."],
			get = function()
				return unpack(PitBull_ThreatBar.db.profile.bgColors)
			end,
			set = function(r, g, b)
				PitBull_ThreatBar.db.profile.bgColors = {r, g, b}
				for unit, frame in PitBull:IterateUnitFrames() do
					PitBull_ThreatBar:UpdateThreat(unit, frame)
				end
			end,
		},
	},
} end)

PitBull_ThreatBar:RegisterPitBullOptionsMethod(function(group)
	if not group:find("target$") then
		return {
			name = L["Threat"],
			desc = L["Options for the units threat bar."],
			type = 'group',
			args = {
				ignore = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enable the threat bar."],
					get = getEnabled,
					set = setEnabled,
					passValue = group,
					order = 1,
				},
			}
		}
	end
end)
