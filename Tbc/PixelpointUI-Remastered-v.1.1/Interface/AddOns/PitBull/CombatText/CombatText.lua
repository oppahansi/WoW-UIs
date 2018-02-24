if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 68199 $"):match("%d+"))

local PitBull = PitBull
local PitBull_CombatText = PitBull:NewModule("CombatText", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_CombatText
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-05 21:15:48 -0400 (Sat, 05 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local SharedMedia = Rock("LibSharedMedia-2.0")

local localization = (GetLocale() == "koKR") and {
	["Show information like damage taken, healing taken, resists, etc. on the unit frame."] = "유닛 프레임에 피해 획득, 치유 획득, 저항등과 같은 정보를 보여줍니다.",
	["Combat"] = "전투 문자",
	["Options for the combat text display. Combat text shows things like damage taken, healing taken, resists, etc. on the unit frame."] = "전투 문자 표시를 위한 옵션입니다. 전투 문자는 유닛 프레임에 피해 획득, 치유 획득, 저항등과 같은 정보를 보여줍니다.",
	["Enable"] = "활성화",
	["Enable combat text for this unit."] = "이 유닛에 대해 전투 문자를 활성화합니다.",
	["Font height"] = "글꼴 높이",
	["Set the font height."] = "글꼴의 높이를 설정합니다.",
} or (GetLocale() == "zhCN") and {
	["Show information like damage taken, healing taken, resists, etc. on the unit frame."] = "在单位框体上显示承受的伤害量，获得的治疗量，法术抵抗等信息。",
	["Combat"] = "战斗文字",
	["Options for the combat text display. Combat text shows things like damage taken, healing taken, resists, etc. on the unit frame."] = "战斗文字显示的选项。战斗文字在每个单位框体上显示承受的伤害量，获得的治疗量，法术抵抗等信息。",
	["Enable"] = "启用",
	["Enable combat text for this unit."] = "为该单位类型启用战斗文字。",
	["Font height"] = "字体高度",
	["Set the font height."] = "设置战斗文字字体的高度。",
	["Font type"] = "字体类型",
	["What font face to use for combat texts."] = "设置战斗文字的字体。",
} or (GetLocale() == "frFR") and {
	["Show information like damage taken, healing taken, resists, etc. on the unit frame."] = "Affiche des informations comme les dégâts reçus, les soins reçus, les résistances aux sorts, etc. sur la fenêtre d'unité.",
	["Combat"] = "Combat",
	["Options for the combat text display. Combat text shows things like damage taken, healing taken, resists, etc. on the unit frame."] = "Options d'affichage du texte de combat. Le texte de combat affiche des informations comme les dégâts reçus, les soins reçus, les résistances, etc. sur la fenêtre d'unité.",
	["Enable"] = "Activer",
	["Enable combat text for this unit."] = "Activer le texte de combat pour cette unité.",
	["Font height"] = "Taille de la police",
	["Set the font height."] = "Définit la taille de la police.",
} or (GetLocale() == "zhTW") and {
	["Show information like damage taken, healing taken, resists, etc. on the unit frame."] = "在單位框架上顯示受到的傷害,得到的治療、抵抗、等資訊.",
	["Combat"] = "戰鬥",
	["Options for the combat text display. Combat text shows things like damage taken, healing taken, resists, etc. on the unit frame."] = "設定戰鬥文字顯示方法.在框架上顯示受到的傷害,得到的治療,抵抗,等等.",
	["Enable"] = "啟用",
	["Enable combat text for this unit."] = "此單位啟用戰鬥文字",
	["Font height"] = "字體高度",
	["Set the font height."] = "設定字體的高度.",
	["Font type"] = "字體類型",
	["What font face to use for combat texts."] = "設定戰鬥文字的字體.",
} or {}

local L = PitBull:L("PitBull-CombatText", localization)

self.desc = L["Show information like damage taken, healing taken, resists, etc. on the unit frame."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_CombatText:RegisterPitBullChildFrames('combatText')

local unitsUpdate = {}

function PitBull_CombatText:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("CombatText")
	PitBull:SetDatabaseNamespaceDefaults("CombatText", "profile", {
		groups = {
			['*'] = {
				fontheight = 13,
				font = "Friz Quadrata TT",
			},
		},
	})
end

function PitBull_CombatText:OnEnable(first)
	self:AddEventListener("UNIT_COMBAT")
end

local function config(frame)
	if not frame.combatText then
		return
	end
	if PitBull.configMode then
		local font = SharedMedia:Fetch('font', self.db.profile.groups[frame.group].font)
		frame.combatText:SetFont(font, self.db.profile.groups[frame.group].fontheight, "OUTLINE")
		frame.combatText:SetText("123")
		frame.combatText:SetTextColor(1, 1, 1)
		frame.combatText:Show()
	else
		frame.combatText:Hide()
	end
end

function PitBull_CombatText:OnChangeConfigMode(configMode)
	for unit, frame in PitBull:IterateUnitFrames() do
		if not self.db.profile.groups[frame.group].ignore and frame.combatText then
			config(frame)
		end
	end
end

-- Combat Event stuff taken almost directly from agUF, credits to ag`
function PitBull_CombatText:UNIT_COMBAT(ns, event, unit, event, flags, amount, type)
	for frame in PitBull:IterateUnitFramesForUnit(unit) do
		if not self.db.profile.groups[frame.group].ignore then
			local fontHeight = self.db.profile.groups[frame.group].fontheight
			local text = ""
			local r,g,b = 1,1,1
			if event == "IMMUNE" then
				fontHeight = fontHeight * .75
				text = CombatFeedbackText["IMMUNE"]
			elseif event == "WOUND" then
				if amount ~=0 then
					if flags == "CRITICAL" or flags == "CRUSHING" then
						fontHeight = fontHeight * 1.5
					elseif flags == "GLANCING" then
						fontHeight = fontHeight * .75
					end
					if type > 0 then
						r = 1
						g = 1
						b = 0
					end
					if UnitInParty( unit ) or UnitInRaid( unit ) then
						r = 1
						g = 0
						b = 0
					end
					text = "-"..amount
				elseif flags == "ABSORB" or flags == "BLOCK" or flags == "RESIST" then
					fontHeight = fontHeight * .75
					text = CombatFeedbackText[flags]
				else
					text = CombatFeedbackText[flags]
				end
			elseif event == "BLOCK" then
				fontHeight = fontHeight * .75
				text = CombatFeedbackText[event]
			elseif event == "HEAL" then
				text = "+"..amount
				r = 0
				g = 1
				b = 0
				if ( flags == "CRITICAL" ) then
					fontHeight = fontHeight * 1.3
				end
			elseif event == "ENERGIZE" then
				text = amount
				r = 0.41
				g = 0.8
				b = 0.94
				if flags == "CRITICAL" then
					fontHeight = fontHeight * 1.3
				end
			else
				text = CombatFeedbackText[event]
			end

			if frame.combatText then
				unitsUpdate[unit] = GetTime()

				local font = SharedMedia:Fetch('font', self.db.profile.groups[frame.group].font)
				frame.combatText:SetFont(font,fontHeight,"OUTLINE")
				frame.combatText:SetText(text)
				frame.combatText:SetTextColor(r, g, b)
				frame.combatText:SetAlpha(0)
				frame.combatText:Show()
				self:AddRepeatingTimer("PitBull_CombatTextSchedule", 0.5, "updateCombatText")
			end
		end
	end
end

function PitBull_CombatText:updateCombatText()
	local found, elapsedTime, alpha
	local maxalpha = 0.6
	local frame
	local now = GetTime()
	for unit, time in pairs(unitsUpdate) do
		local one = false
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			if frame.combatText then
				one = true
				found = true
				elapsedTime = now - time
				if ( elapsedTime < COMBATFEEDBACK_FADEINTIME ) then
					alpha = maxalpha*(elapsedTime / COMBATFEEDBACK_FADEINTIME)
					frame.combatText:SetAlpha(alpha)
				elseif ( elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) ) then
					frame.combatText:SetAlpha(maxalpha)
				elseif ( elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME) ) then
					alpha = maxalpha - maxalpha*((elapsedTime - COMBATFEEDBACK_HOLDTIME - COMBATFEEDBACK_FADEINTIME) / COMBATFEEDBACK_FADEOUTTIME)
					frame.combatText:SetAlpha(alpha)
				else
					frame.combatText:Hide()
					unitsUpdate[unit] = nil
				end
			end
		end
		if not one then
			unitsUpdate[unit] = nil
		end

		found = true
	end
	if not found then
		self:RemoveTimer("PitBull_CombatTextSchedule")
	end
end

function PitBull_CombatText:OnPopulateUnitFrame(unit, frame)
	local group = frame.group
	if group == "player" or group == "target" or group == "pet" or group == "focus" or group == "mouseover" or group == "party" or group == "partypet" or group == "raid" or group == "maintank" or group == "mainassist" then
		if not self.db.profile.groups[frame.group].ignore then
			local combatText = newFrame("FontString", frame.overlay, "OVERLAY")
			frame.combatText = combatText
			local font, fontsize = PitBull:GetFont()
			combatText:SetFont( font, fontsize )
			combatText:SetNonSpaceWrap(false)
			combatText:SetAlpha(0)
			config(frame)
		end
	end
end

function PitBull_CombatText:OnUpdateLayout(unit, frame)
	if frame.combatText then
		config(frame)
	end
end

function PitBull_CombatText:OnUpdateFont(font, fontsize)
	for _,frame in PitBull:IterateUnitFrames() do
		if frame.combatText then
			frame.combatText:SetFont( font, fontsize)
		end
	end
end

function PitBull_CombatText:OnClearUnitFrame(unit, frame)
	if frame.combatText then
		frame.combatText = delFrame(frame.combatText)
	end
end

function PitBull_CombatText:OnUnknownLayout(unit, frame, name)
	if frame.combatText then
		frame.combatText:SetPoint("CENTER", frame, "CENTER")
	end
end

local function getEnabled(group)
	return not PitBull_CombatText.db.profile.groups[group].ignore
end
local function setEnabled(group, value)
	value = not value
	PitBull_CombatText.db.profile.groups[group].ignore = value
	if value then
		for unit,frame in PitBull:IterateUnitFramesByGroup(group) do
			if frame.combatText then
				PitBull_CombatText:OnClearUnitFrame(unit, frame)
				unitsUpdate[unit] = nil
			end
		end
	else
		for unit,frame in PitBull:IterateUnitFramesByGroup(group) do
			if not frame.combatText then
				PitBull_CombatText:OnPopulateUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end
	end
end
local function getDisabled(group)
	return PitBull_CombatText.db.profile.groups[group].ignore
end
local function getFontHeight(group)
	return PitBull_CombatText.db.profile.groups[group].fontheight
end
local function setFontHeight(group, value)
	PitBull_CombatText.db.profile.groups[group].fontheight = value
end
local function getFont(group)
	return PitBull_CombatText.db.profile.groups[group].font
end
local function setFont(group, value)
	PitBull_CombatText.db.profile.groups[group].font = value
end
PitBull_CombatText:RegisterPitBullOptionsMethod(function(group)
	if group == "player" or group == "target" or group == "pet" or group == "focus" or group == "mouseover" or group == "party" or group == "partypet" or group == "raid" or group == "maintank" or group == "mainassist" then
		return {
			name = L["Combat"],
			desc = L["Options for the combat text display. Combat text shows things like damage taken, healing taken, resists, etc. on the unit frame."],
			type = 'group',
			args = {
				enable = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enable combat text for this unit."],
					get = getEnabled,
					set = setEnabled,
					passValue = group,
					order = 1,
				},
				fonttype = {
					name = L["Font type"],
					desc = L["What font face to use for combat texts."],
					type = 'choice',
					choices = SharedMedia:List('font'),
					choiceFonts = SharedMedia:HashTable('font'),
					get = getFont,
					set = setFont,
					passValue = group,
					disabled = getDisabled,
				},
				fontheight = {
					type = 'number',
					name = L["Font height"],
					desc = L["Set the font height."],
					min = 6,
					max = 30,
					step = 1,
					get = getFontHeight,
					set = setFontHeight,
					passValue = group,
					disabled = getDisabled,
				},
			}
		}
	end
end)

