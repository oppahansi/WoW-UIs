if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local localization = (GetLocale() == "koKR") and {
	["Show an icon based on whether or not the unit is in combat."] = "유닛의 전투 참여 여부에 근거해 아이콘을 보여줍니다.",
	["Combat"] = "전투중",
	["Options for the in-combat indicator for this unit."] = "이 유닛의 전투중 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the in-combat indicator for this unit."] = "이 유닛에 대해 전투중 아이콘을 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an icon based on whether or not the unit is in combat."] = "依据指定单位是否位于战斗状态中而显示一个图标。",
	["Combat"] = "战斗",
	["Options for the in-combat indicator for this unit."] = "针对该单位的“战斗中”指示器的选项。",
	["Enable"] = "启用",
	["Enables the in-combat indicator for this unit."] = "启用该单位的“战斗中”指示器。",
} or (GetLocale() == "frFR") and {
	["Show an icon based on whether or not the unit is in combat."] = "Affiche une icône basée sur le mode de combat de l'unité.",
	["Combat"] = "Combat",
	["Options for the in-combat indicator for this unit."] = "Options d'indicateur de mode de combat pour cette unité.",
	["Enable"] = "Activer",
	["Enables the in-combat indicator for this unit."] = "Active l'indicateur de mode de combat pour cette unité.",
} or (GetLocale() == "zhTW") and {
	["Show an icon based on whether or not the unit is in combat."] = "顯示此單位是否正在戰鬥中的小圖示.",
	["Combat"] = "戰鬥",
	["Options for the in-combat indicator for this unit."] = "設置此單位戰鬥中指示器的選項.",
	["Enable"] = "啟用",
	["Enables the in-combat indicator for this unit."] = "於此單位啟用戰鬥中指示器",
} or {}

local L = PitBull:L("PitBull-CombatIcon", localization)

local PitBull = PitBull
local PitBull_CombatIcon = PitBull:NewModule("CombatIcon", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_CombatIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end
self.desc = L["Show an icon based on whether or not the unit is in combat."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_CombatIcon:RegisterPitBullChildFrames('combatIcon')
PitBull_CombatIcon:RegisterPitBullIconLayoutHandler('combatIcon', 6)

function PitBull_CombatIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("CombatIcon")
	PitBull:SetDatabaseNamespaceDefaults("CombatIcon", "profile", {
		groups = {
			['**'] = { disable = true },
			["player"] = {
				disable = false,
			},
			["target"] = {
				disable = false,
			},
			["party"] = {
				disable = false,
			},
		},
	})
end

function PitBull_CombatIcon:OnEnable()
	self:AddEventListener("PLAYER_REGEN_ENABLED")
	self:AddEventListener("PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED")
	
	self:AddRepeatingTimer(0.5, "UpdateAllNonWacky")
end

function PitBull_CombatIcon:PLAYER_REGEN_ENABLED()
	for frame in PitBull:IterateUnitFramesForUnit('player') do
		self:Update('player', frame)
	end
end

local configMode = PitBull.configMode

function PitBull_CombatIcon:OnChangeConfigMode(value)
	configMode = value
	for unit, frame in PitBull:IterateUnitFrames() do
		self:Update(unit, frame)
	end
end

local alerted = false
function PitBull_CombatIcon:Update(unit, frame)
	if not frame.group then
		if not alerted then
			AceLibrary("AceConsole-2.0"):Print("Error in PitBull_CombatIcon, please report this to ckknight:", debugstack())
			alerted = true
		end
		return
	end
	if self.db.profile.groups[frame.group].disable then return end

	local inCombat = configMode or UnitAffectingCombat(unit)
	
	if inCombat then
		if not frame.combatIcon then
			frame.combatIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.combatIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
			frame.combatIcon:SetTexCoord(0.57, 0.90, 0.08, 0.41)
			frame.combatIcon:Hide()
			PitBull:UpdateLayout(frame)
		end
	else
		if frame.combatIcon then
			frame.combatIcon = delFrame(frame.combatIcon)
			
			PitBull:UpdateLayout(frame)
		end
	end
end

function PitBull_CombatIcon:UpdateAllNonWacky()
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		self:Update(unit, frame)
	end
end

function PitBull_CombatIcon:OnUpdateFrame(unit, frame)
	self:Update(unit, frame)
end

function PitBull_CombatIcon:OnClearUnitFrame(unit, frame)
	if frame.combatIcon then
		frame.combatIcon = delFrame(frame.combatIcon)
	end
end

-- Unit/Group Specific Options
local function getEnabled(group)
	return not PitBull_CombatIcon.db.profile.groups[group].disable
end
local function setEnabled(group, value)
	value = not value
	PitBull_CombatIcon.db.profile.groups[group].disable = value
	if value then
		for unit,frame in PitBull:IterateUnitFramesByGroup(group) do
			if frame.combatIcon then
				frame.combatIcon = delFrame(frame.combatIcon)
				PitBull:UpdateLayout(frame)
			end
		end
	else
		for unit,frame in PitBull:IterateUnitFramesByGroup(group) do
			if not frame.combatIcon then
				self:Update(unit, frame)
			end
		end
	end
end

PitBull_CombatIcon:RegisterPitBullOptionsMethod(function(group)
	return {
		type = 'group',
		name = L["Combat"],
		desc = L["Options for the in-combat indicator for this unit."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the in-combat indicator for this unit."],
				get = getEnabled,
				set = setEnabled,
				passValue = group,
			}
		}
	}
end)

