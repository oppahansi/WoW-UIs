if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))
local DURATION = 0.5

local localization = (GetLocale() == "koKR") and {
	["Adds alpha changes based on combat."] = "전투 상태에 근거해 투명도가 변경되는 기능을 추가합니다.",
	["Combat fade time"] = "전투 상태 투명도 시간",
	["Set how long frames should be faded when combat status changes."] = "전투 상태가 변경된 경우에 프레임의 투명도가 변경되는 시간을 설정합니다.",
	["Combat fader"] = "전투 투명도 변경",
	["Change the alpha of the unit frame based on the units combat status."] = "유닛의 전투 상태에 근거해 유닛 프레임의 투명도가 변경됩니다.",
	["In Combat alpha"] = "전투중의 투명도",
	["What alpha to have while in combat."] = "전투중인 동안에 갖게 될 투명도를 설정합니다.",
	["Target Selected alpha"] = "대상 선택시 투명도",
	["What alpha to have while target is selected."] = "대상이 선택된 동안에 갖게 될 투명도를 설정합니다.",
	["Health / Mana not at max alpha"] = "최대 생명력/마나가 아닐 때의 투명도",
	["What alpha to have while health or mana is not at maximum."] = "생명력 혹은 마나가 최대가 아닌 동안에 갖게 될 투명도를 설정합니다.",
	["Out of Combat alpha"] = "비전투중의 투명도",
	["What alpha to have while out of combat."] = "비전투중인 동안에 갖게 될 투명도를 설정합니다.",
	["Enable"] = "활성화",
	["Enable changing the alpha based on combat status."] = "전투 상태에 근거해 투명도가 변경되는 기능을 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Adds alpha changes based on combat."] = "依据战斗状态更改透明度。",
	["Combat fade time"] = "战斗渐隐时间",
	["Set how long frames should be faded when combat status changes."] = "设置当战斗状态更改时渐隐变换所持续的时间。",
	["Combat fader"] = "战斗渐隐",
	["Change the alpha of the unit frame based on the units combat status."] = "依据战斗状态更改单位框体的透明度。",
	["In Combat alpha"] = "进入战斗后的透明度",
	["What alpha to have while in combat."] = "设置进入战斗后所采用的透明度。",
	["Target Selected alpha"] = "选定目标时的透明度",
	["What alpha to have while target is selected."] = "设置当选定了一个目标时所采用的透明度。",
	["Health / Mana not at max alpha"] = "生命/能量不满时的透明度",
	["What alpha to have while health or mana is not at maximum."] = "设置自己的生命或者能量值不满时所采用的透明度。",
	["Out of Combat alpha"] = "脱离战斗后的透明度",
	["What alpha to have while out of combat."] = "设置脱离战斗后所采用的透明度。",
	["Enable"] = "启用",
	["Enable changing the alpha based on combat status."] = "开启依据战斗状态更改透明度功能。",
} or (GetLocale() == "frFR") and {
	["Adds alpha changes based on combat."] = "Ajoute une transparence basée sur le mode de combat.",
	["Combat fade time"] = "Temps de fondu (Combat)",
	["Set how long frames should be faded when combat status changes."] = "Définit le temps de rendement de fondu d'une fenêtre d'unité quand le mode de combat change.",
	["Combat fader"] = "Fondu de combat",
	["Change the alpha of the unit frame based on the units combat status."] = "Change la transparence d'une fenêtre en fonction du mode combat de l'unité.",
	["Target Selected alpha"] = "Transparence de la sélection de la cible",
	["What alpha to have while in combat."] = "La transparence à utiliser en combat.",
	["Health / Mana not at max alpha"] = "Transparence quand la vie / le mana n'est pas au maximum",
	["What alpha to have while in combat."] = "Quelle transparence utiliser en combat.",
	["Out of Combat alpha"] = "Transparence à utilser hors combat",
	["What alpha to have while out of combat."] = "La transparence à utiliser hors de tout combat.",
	["Enable"] = "Activer",
	["Enable changing the alpha based on combat status."] = "Activer le changement de transparence basé sur le mode de combat.",
	["In Combat alpha"] = "Transparence en combat",
} or (GetLocale() == "zhTW") and {
	["Adds alpha changes based on combat."] = "進入或離開戰鬥時改變框架的淡出",
	["Combat fade time"] = "戰鬥淡出時間",
	["Set how long frames should be faded when combat status changes."] = "當戰鬥狀態改變時,框架淡出的時間.",
	["Combat fader"] = "戰鬥淡出",
	["Change the alpha of the unit frame based on the units combat status."] = "基於單位的戰鬥狀態改變框架的淡出.",
	["Target Selected alpha"] = "當選定目標時改變框架的淡出",
	["What alpha to have while target is selected."] = "當選定目標時框架淡出要如何變化?",
	["Health / Mana not at max alpha"] = "生命力/法力值不在最大時改變框架淡出",
	["What alpha to have while in combat."] = "進入戰鬥時的淡出程度",
	["Out of Combat alpha"] = "離開戰鬥的淡出程度",
	["What alpha to have while out of combat."] = "離開戰鬥時的淡出程度",
	["Enable"] = "啟用",
	["Enable changing the alpha based on combat status."] = "啟用根據戰鬥狀態來改變框架的淡出.",
	["In Combat alpha"] = "進入戰鬥時淡出",
} or {}

local L = PitBull:L("PitBull_CombatFader", localization)

local PitBull = PitBull
PitBull:SetModuleDefaultState("CombatFader", false)
local PitBull_CombatFader = PitBull:NewModule("CombatFader", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_CombatFader
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end
self.desc = L["Adds alpha changes based on combat."]
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame
local _abs, _floor, _cos, _pi = math.abs, math.floor, math.cos, math.pi
local activeframes = {}
local IsWackyUnit = PitBull.IsWackyUnit

function PitBull_CombatFader:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("CombatFader")
	PitBull:SetDatabaseNamespaceDefaults("CombatFader", "profile", {
		fadetime = 5,
		groups = {
			['**'] = { 
				disable = true,
				inAlpha = 1,
				outAlpha = 0.25,
				hasTargetAlpha = 0.75,
				notFullAlpha = 0.75,
			},
			["player"] = {
				disable = true,
				inAlpha = 1,
				outAlpha = 0.25,
				hasTargetAlpha = 0.75,
				notFullAlpha = 0.75,
			},			
			["target"] = {
				disable = true,
				inAlpha = 1,
				outAlpha = 0.5,
				hasTargetAlpha = 0.75,
				notFullAlpha = 0.75,
			},			
			["party"] = {
				disable = true,
				inAlpha = 1,
				outAlpha = 0.25,
				hasTargetAlpha = 0.75,
				notFullAlpha = 0.75,
			},			
		}
	})
end

function PitBull_CombatFader:OnEnable()
	self:AddEventListener("PLAYER_REGEN_ENABLED", "OnFadeEvent")
	self:AddEventListener("PLAYER_REGEN_DISABLED", "OnFadeEvent")
	self:AddEventListener("PLAYER_TARGET_CHANGED", "OnFadeEvent")
	self:AddEventListener("UNIT_HEALTH", "OnPlayerHealthManaEvent")
	self:AddEventListener("UNIT_MANA", "OnPlayerHealthManaEvent")
	self:AddRepeatingTimer(0, "UpdateAlphas")
end

function PitBull_CombatFader:OnPlayerHealthManaEvent(namespace, event, unit)
	if unit == "player" then
		self:OnFadeEvent()
	end
end

function PitBull_CombatFader:OnFadeEvent()
	local db = self.db.profile.groups
	local inCombat = UnitAffectingCombat('player')
	local hasTarget = UnitExists('target')
	local notFull = UnitHealth('player') ~= UnitHealthMax('player') or
		(UnitPowerType("player") == 1 and UnitMana('player') > 0) or
		(UnitPowerType("player") ~= 1 and UnitMana('player') ~= UnitManaMax('player'))
	local stop = GetTime() + self.db.profile.fadetime

	if inCombat then
		for unit, frame in PitBull:IterateUnitFrames() do
			if (frame and frame.group and not db[frame.group].ignore) then
				frame.cfstop = stop
				activeframes[frame] = db[frame.group].inAlpha
			end
		end
	elseif hasTarget then
		for unit, frame in PitBull:IterateUnitFrames() do
			if (frame and frame.group and not db[frame.group].ignore) then
				frame.cfstop = stop
				activeframes[frame] = db[frame.group].hasTargetAlpha
			end
		end
	elseif notFull then
		for unit, frame in PitBull:IterateUnitFrames() do
			if (frame and frame.group and not db[frame.group].ignore) then
				frame.cfstop = stop
				activeframes[frame] = db[frame.group].notFullAlpha
			end
		end
	else
		for unit, frame in PitBull:IterateUnitFrames() do
			if (frame and frame.group and not db[frame.group].ignore) then
				frame.cfstop = stop
				activeframes[frame] = db[frame.group].outAlpha
			end
		end
	end
end

function PitBull_CombatFader:OnClearUnitFrame(unit, frame)
	frame.cfstop = nil
	activeframes[frame] = nil
	frame:SetAlpha(1)
end

function PitBull_CombatFader:OnUpdateFrame(unit, frame)
	local stop = GetTime() + self.db.profile.fadetime
	local inCombat = UnitAffectingCombat('player')
	local hasTarget = UnitExists('target')
	local notFull = UnitHealth('player') ~= UnitHealthMax('player') or UnitMana('player') ~= UnitManaMax('player')
	if (frame and frame.group and not self.db.profile.groups[frame.group].ignore) then
		if (IsWackyUnit[unit]) then
			if (not frame.cfstop) then frame.cfstop = stop end -- only set the stop time if it hasn't been set
		else
			frame.cfstop = stop -- always set the stop if it's not wacky
		end
		if inCombat then
			local finalAlpha = self.db.profile.groups[frame.group].inAlpha
			local currentAlpha = frame:GetAlpha()
			if (_floor(_abs(currentAlpha - finalAlpha)*100) > 0) then
				activeframes[frame] = finalAlpha
			end
		elseif hasTarget then
			local finalAlpha = self.db.profile.groups[frame.group].hasTargetAlpha
			local currentAlpha = frame:GetAlpha()
			if (_floor(_abs(currentAlpha - finalAlpha)*100) > 0) then
				activeframes[frame] = finalAlpha
			end
		elseif notFull then
			local finalAlpha = self.db.profile.groups[frame.group].notFullAlpha
			local currentAlpha = frame:GetAlpha()
			if (_floor(_abs(currentAlpha - finalAlpha)*100) > 0) then
				activeframes[frame] = finalAlpha
			end
		else
			local finalAlpha = self.db.profile.groups[frame.group].outAlpha
			local currentAlpha = frame:GetAlpha()
			if (_floor(_abs(currentAlpha - finalAlpha)*100) > 0) then
				activeframes[frame] = finalAlpha
			end
		end
	end
end

local function CosineInterpolate(y1, y2, mu)
	local mu2 = (1-_cos(mu*_pi))/2
	return y1*(1-mu2)+y2*mu2
end

function PitBull_CombatFader:UpdateAlphas()
	local now, fadeTime, currentAlpha, finalAlpha, tSteps = GetTime(), self.db.profile.fadetime
	for frame, finalAlpha in pairs(activeframes) do
		tSteps = frame.cfstop - now
		currentAlpha = frame:GetAlpha()
		if (_floor(_abs(currentAlpha - finalAlpha)*100) > 0) then
			tSteps = 1 - (tSteps / fadeTime)
			if (finalAlpha) then
				currentAlpha = CosineInterpolate(currentAlpha,finalAlpha,tSteps)
				if (currentAlpha > 1) then currentAlpha = 1 end
				if (currentAlpha < 0) then currentAlpha = 0 end
				frame:SetAlpha(currentAlpha)
			end
		else
			activeframes[frame] = nil
			frame.cfstop = nil
		end
	end
end

-- Global Options
PitBull:RegisterGlobalSetting("combatfader", function() return "@cache", {
	type = 'number',
	name = L["Combat fade time"],
	desc = L["Set how long frames should be faded when combat status changes."],
	min = 0.1,
	max = 10,
	step = 0.1,
	get = function()
		return PitBull_CombatFader.db.profile.fadetime
	end,
	set = function(value)
		PitBull_CombatFader.db.profile.fadetime = value
	end,
} end)

-- Unit/Group Specific Options
local function getOOC(group)
	return PitBull_CombatFader.db.profile.groups[group].outAlpha
end
local function setOOC(group, value)
	PitBull_CombatFader.db.profile.groups[group].outAlpha = value
end
local function getNotFull(group)
	return PitBull_CombatFader.db.profile.groups[group].notFullAlpha
end
local function setNotFull(group, value)
	PitBull_CombatFader.db.profile.groups[group].notFullAlpha = value
end
local function getHasTarget(group)
	return PitBull_CombatFader.db.profile.groups[group].hasTargetAlpha
end
local function setHasTarget(group, value)
	PitBull_CombatFader.db.profile.groups[group].hasTargetAlpha = value
end
local function getInCombat(group)
	return PitBull_CombatFader.db.profile.groups[group].inAlpha
end
local function setInCombat(group, value)
	PitBull_CombatFader.db.profile.groups[group].inAlpha = value
end
local function getEnabled(group)
	return not PitBull_CombatFader.db.profile.groups[group].ignore
end
local function getDisabled(group)
	return PitBull_CombatFader.db.profile.groups[group].ignore
end
local function setEnabled(group, value)
	PitBull_CombatFader.db.profile.groups[group].ignore = not value
end

PitBull_CombatFader:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["Combat fader"],
		desc = L["Change the alpha of the unit frame based on the units combat status."],
		type = 'group',
		args = {
			incombat = {
				type = 'number',
				name = L["In Combat alpha"],
				desc = L["What alpha to have while in combat."],
				get = getInCombat,
				set = setInCombat,
				isPercent = true,
				min = 0,
				max = 1,
				step = 0.05,
				disabled = getDisabled,
				passValue = group,
			},
			hastarget = {
				type = 'range',
				name = L["Target Selected alpha"],
				desc = L["What alpha to have while target is selected."],
				get = getHasTarget,
				set = setHasTarget,
				isPercent = true,
				min = 0,
				max = 1,
				step = 0.05,
				disabled = getDisabled,
				passValue = group,
			},
			notfull = {
				type = 'range',
				name = L["Health / Mana not at max alpha"],
				desc = L["What alpha to have while health or mana is not at maximum."],
				get = getNotFull,
				set = setNotFull,
				isPercent = true,
				min = 0,
				max = 1,
				step = 0.05,
				disabled = getDisabled,
				passValue = group,
			},
			ooc = {
				type = 'number',
				name = L["Out of Combat alpha"],
				desc = L["What alpha to have while out of combat."],
				get = getOOC,
				set = setOOC,
				isPercent = true,
				min = 0,
				max = 1,
				step = 0.05,
				disabled = getDisabled,
				passValue = group,
			},
			enable = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enable changing the alpha based on combat status."],
				get = getEnabled,
				set = setEnabled,
				order = 1,
				passValue = group,
			},
		}
	}
end)
