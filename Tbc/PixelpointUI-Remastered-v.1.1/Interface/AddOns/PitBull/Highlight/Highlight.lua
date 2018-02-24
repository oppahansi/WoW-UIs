if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67162 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Highlight = PitBull:NewModule("Highlight", "LibRockEvent-1.0")
local self = PitBull_Highlight
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 17:39:29 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Highlight unit frames on mouse-over or on targetting."] = "마우스를 올려 놓은 혹은 대상으로 삼은 유닛 프레임을 강조해 보여줍니다.",
	["Enable"] = "활성화",
	["Highlight this unit on mouse-over."] = "마우스를 올려 놓은 이 유닛을 강조해 보여줍니다.",
	["Highlight when targetted"] = "대상 지정의 경우 강조",
	["Highlight this unit frame when it is the same as your current target."] = "이 유닛 프레임을 현재 대상으로 지정한 경우에 강조해 보여줍니다.",
	["Highlight"] = "강조",
	["Options for highlighting this unit when selected or moused over."] = "선택된 혹은 마우스를 올려 놓은 이 유닛을 강조해 보여주기 위한 옵션입니다.",
} or (GetLocale() == "zhCN") and {
	["Highlight unit frames on mouse-over or on targetting."] = "当鼠标悬停于或者选择某单位为目标时，高亮其单位框体。",
	["Enable"] = "启用",
	["Highlight this unit on mouse-over."] = "鼠标悬停于该单位时高亮。",
	["Highlight when targetted"] = "选为目标时高亮",
	["Highlight this unit frame when it is the same as your current target."] = "当该单位和你的目标所选定的单位为同一个时高亮其单位框体。",
	["Highlight"] = "高亮",
	["Options for highlighting this unit when selected or moused over."] = "当选中或鼠标悬停在该单位上时高亮的选项。",
} or (GetLocale() == "frFR") and {
	["Highlight unit frames on mouse-over or on targetting."] = "Mise en valeur des fenêtres d'unité lorsque la souris est au-dessus ou lorsque l'unité est sélectionnée.",
	["Highlight"] = "Mise en valeur",
	["Options for highlighting this unit when selected or moused over."] = "Options de mise en valeur de cette unité lorsqu'elle est sélectionnée ou que la souris est au-dessus.",
	["Enable"] = "Activer",
	["Highlight this unit on mouse-over."] = "Mise en valeur de cette unité lorsque la souris est au-dessus.",
	["Highlight when targetted"] = "Mise en valeur quand ciblée",
	["Highlight this unit frame when it is the same as your current target."] = "Mise en valeur de cette fenêtre d'unité quand c'est la même que votre cible actuelle.",
} or (GetLocale() == "zhTW") and {
	["Highlight unit frames on mouse-over or on targetting."] = "當滑鼠停留或者為當前目標時高亮顯示單位框架.",
	["Highlight"] = "高亮",
	["Options for highlighting this unit when selected or moused over."] = "當選定或者滑鼠停留之上時高亮這個單位的選項.",
	["Enable"] = "啟用",
	["Highlight this unit on mouse-over."] = "當滑鼠停留之上時高亮這個單位.",
	["Highlight when targetted"] = "做為目標時高亮",
	["Highlight this unit frame when it is the same as your current target."] = "目標為你的目標時高亮這個單位框架.",
} or {}

local L = PitBull:L("PitBull-Highlight", localization)

self.desc = L["Highlight unit frames on mouse-over or on targetting."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local UnitIsUnit = UnitIsUnit

PitBull_Highlight:RegisterPitBullChildFrames('highlight')

function PitBull_Highlight:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("Highlight")
	PitBull:SetDatabaseNamespaceDefaults("Highlight", "profile", {
		['**'] = {
			hidden = false,
			showTarget = true,
		},
		target = {
			showTarget = false,
		},
		targettarget = {
			showTarget = false,
		},
		targettargettarget = {
			showTarget = false,
		}
	})
end

function PitBull_Highlight:OnEnable(first)
	self:AddEventListener("PLAYER_TARGET_CHANGED")
end

function PitBull_Highlight:PLAYER_TARGET_CHANGED()
	if UnitExists('target') then
		for unit, frame in PitBull:IterateUnitFrames() do
			if frame.highlight and self.db.profile[frame.group].showTarget then
				if UnitIsUnit(unit, 'target') then
					frame.highlight:Show()
				elseif frame ~= GetMouseFocus() then
					frame.highlight:Hide()
				end
			end
		end
	else
		for unit, frame in PitBull:IterateUnitFrames() do
			if frame ~= GetMouseFocus() and frame.highlight then
				frame.highlight:Hide()
			end
		end
	end
end

function PitBull_Highlight:OnPopulateUnitFrame(unit, frame)
	if not PitBull_Highlight.db.profile[frame.group].hidden then
		local highlight = newFrame("Texture", frame.overlay, "OVERLAY")
		frame.highlight = highlight
		highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		highlight:SetBlendMode("ADD")
		highlight:SetAlpha(0.5)
		highlight:Hide()
		highlight:SetAllPoints(frame)
	end
end

function PitBull_Highlight:OnClearUnitFrame(unit, frame)
	if frame.highlight then
		frame.highlight = delFrame(frame.highlight)
	end
end

function PitBull_Highlight:OnFrameOnEnter(unit, frame)
	if frame.highlight then
		frame.highlight:Show()
	end
end

function PitBull_Highlight:OnFrameOnLeave(unit, frame)
	if frame.highlight and (not UnitIsUnit(unit, "target") or not self.db.profile[frame.group].showTarget) then
		frame.highlight:Hide()
	end
end

function PitBull_Highlight:OnUpdateFrame(unit, frame)
	if not frame.highlight then return end
	if frame == GetMouseFocus() or (UnitIsUnit(unit, "target") and self.db.profile[frame.group].showTarget) then
		frame.highlight:Show()
	else
		frame.highlight:Hide()
	end
end

function PitBull_Highlight:OnUnknownLayout(unit, frame, name)
	frame.highlight:SetAllPoints(frame)
	if frame == GetMouseFocus() or (UnitIsUnit(unit, "target") and self.db.profile[frame.group].showTarget) then
		frame.highlight:Show()
	else
		frame.highlight:Hide()
	end
end

local function getDisabled(group)
	return PitBull_Highlight.db.profile[group].hidden
end
local function getEnabled(group)
	return not PitBull_Highlight.db.profile[group].hidden
end
local function setEnabled(group, value)
	value = not value
	PitBull_Highlight.db.profile[group].hidden = value
	
	if value then
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			PitBull_Highlight:OnClearUnitFrame(unit, frame)
			
			PitBull:UpdateLayout(frame)
		end
	else
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			PitBull_Highlight:OnPopulateUnitFrame(unit, frame)
		
			PitBull:UpdateLayout(frame)
			
			PitBull_Highlight:PLAYER_TARGET_CHANGED()
		end
	end
end
local function getShowTarget(group)
	return PitBull_Highlight.db.profile[group].showTarget
end
local function setShowTarget(group, value)
	PitBull_Highlight.db.profile[group].showTarget = value

	if value then
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			if frame.highlight and UnitIsUnit(unit, "target") then
				frame.highlight:Show()
			end
		end
	else
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			if frame.highlight and frame ~= GetMouseFocus() then
				frame.highlight:Hide()
			end
		end
	end
end

PitBull_Highlight:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["Highlight"],
		desc = L["Options for highlighting this unit when selected or moused over."],
		type = "group",
		args = {
			enable = {
				name = L["Enable"],
				desc = L["Highlight this unit on mouse-over."],
				type = 'boolean',
				get = getEnabled,
				set = setEnabled,
				passValue = group,
				order = 1,
			},
			showTarget = {
				name = L["Highlight when targetted"],
				desc = L["Highlight this unit frame when it is the same as your current target."],
				type = 'boolean',
				get = getShowTarget,
				set = setShowTarget,
				passValue = group,
				disabled = getDisabled,
			}
		}
	}
end)
