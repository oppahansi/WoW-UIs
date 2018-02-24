if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_ReadyCheckIcon = PitBull:NewModule("ReadyCheckIcon", "LibRockEvent-1.0","LibRockTimer-1.0")
local self = PitBull_ReadyCheckIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a ready check icon on the unit frame based on their response."] = "유닛의 응답에 따른 유닛 프레임에 준비 확인 아이콘을 보여줍니다.",
	["Ready Check"] = "준비 확인",
	["Options for the ready check icon for this unit."] = "이 유닛에 대해 준비 확인 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the ready check icon display on the unit frames for this unit type."] = "유닛 유형의 유닛 프레임에 준비 체크 아이콘의 표시를 활성화합니다",
} or (GetLocale() == "zhCN") and {
	["Show a ready check icon on the unit frame based on their response."] = "根据目标的答复在其单位框体上显示就位确认状态图标。",
	["Ready Check"] = "就位状态",
	["Options for the ready check icon for this unit."] = "该单位框体的就位状态图标的选项。",
	["Enable"] = "启用",
	["Enables the ready check icon display on the unit frames for this unit type."] = "为该单位类型启用在其单位框体上显示就位状态图标的功能。",
} or (GetLocale() == "frFR") and {
	["Show a ready check icon on the unit frame based on their response."] = "Affiche une icône de présence sur la fenêtre d'unité en fonction de sa réponse.",
	["Ready Check"] = "Vérification de présence",
	["Options for the ready check icon for this unit."] = "Options pour l'icône de présence de cette unité.",
	["Enable"] = "Activer",
	["Enables the ready check icon display on the unit frames for this unit type."] = "Active l'affichage de l'icône de présence sur les fenêtres d'unité de ce type.",
} or (GetLocale() == "zhTW") and {
	["Show a ready check icon on the unit frame based on their response."] = "在單位框架上顯示玩家是否已準備好的小圖示",
	["Ready Check"] = "確認檢查",
	["Options for the ready check icon for this unit."] = "此單位框架確認檢查的選項",
	["Enable"] = "啟用",
	["Enables the ready check icon display on the unit frames for this unit type."] = "開啟確認檢查的小圖示於此類的單位框架上",
} or {}

local L = PitBull:L("PitBull-ReadyCheckIcon", localization)

self.desc = L["Show a ready check icon on the unit frame based on their response."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_ReadyCheckIcon:RegisterPitBullChildFrames('readyCheckIcon')
PitBull_ReadyCheckIcon:RegisterPitBullIconLayoutHandler('readyCheckIcon', 8)

function PitBull_ReadyCheckIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("ReadyCheckIcon")
	PitBull:SetDatabaseNamespaceDefaults("ReadyCheckIcon", "profile", {
		['*'] = {
			disable = false,
		}
	})
end

function PitBull_ReadyCheckIcon:OnEnable()
	self:AddEventListener("READY_CHECK")
	self:AddEventListener("READY_CHECK_CONFIRM", "READY_CHECK")
	self:AddEventListener("READY_CHECK_FINISHED")
end

local configMode = PitBull.configMode

function PitBull_ReadyCheckIcon:OnChangeConfigMode(value)
	configMode = value
	for unit, frame in PitBull:IterateUnitFrames() do
		self:Update(unit, frame)
	end
end

local configMode_icons = {}

function PitBull_ReadyCheckIcon:Update(unit, frame)
	if unit:match("pet") then return end
	local isLeader = IsRaidLeader() or IsRaidOfficer() or IsPartyLeader()
	local readyCheckStatus
	if configMode then
		readyCheckStatus = configMode_icons[unit]
		if not readyCheckStatus then
			local y = math.random(1, 3)
			if y == 1 then
				readyCheckStatus = "ready"
			elseif y == 3 then
				readyCheckStatus = "waiting"
			else
				readyCheckStatus = "notready"
			end
			configMode_icons[unit] = readyCheckStatus
		end
	end
	if self.db.profile[frame.group].disable then
		readyCheckStatus = nil
	end
	if isLeader then readyCheckStatus = GetReadyCheckStatus(unit) end
	if readyCheckStatus then
		if not frame.readyCheckIcon then
			frame.readyCheckIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.readyCheckIcon:Hide()
			PitBull:UpdateLayout(frame)
		end
		if ( readyCheckStatus == "ready" ) then
			frame.readyCheckIcon:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
		elseif ( readyCheckStatus == "notready" ) then
			frame.readyCheckIcon:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady")
		elseif ( readyCheckStatus == "waiting" ) then
			frame.readyCheckIcon:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting")
		end
		frame.readyCheckIcon:SetAlpha(1)
	else
		if frame.readyCheckIcon then
			frame.readyCheckIcon = delFrame(frame.readyCheckIcon)
			PitBull:UpdateLayout(frame)
		end		
	end
end

function PitBull_ReadyCheckIcon:READY_CHECK()
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		self:Update(unit, frame)
	end
end

function PitBull_ReadyCheckIcon:READY_CHECK_FINISHED()
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		if frame.readyCheckIcon and not unit:match("pet") then
			self:AddTimer(8.5, function() UIFrameFadeOut(frame.readyCheckIcon, 1.5, 1, 0) end)
		end
	end
end

function PitBull_ReadyCheckIcon:OnUpdateFrame(unit, frame)
	self:Update(unit, frame)
end

function PitBull_ReadyCheckIcon:OnClearUnitFrame(unit, frame)
	if frame.readyCheckIcon then
		frame.readyCheckIcon = delFrame(frame.readyCheckIcon)
	end
end

function PitBull_ReadyCheckIcon:OnUnknownLayout(unit, frame)
	frame.raidTargetIcon:SetPoint("CENTER", frame, "TOP", 0, -3)
	frame.raidTargetIcon:SetWidth(18)
	frame.raidTargetIcon:SetHeight(18)
end

local function getEnable(group)
	return not PitBull_ReadyCheckIcon.db.profile[group].disable
end
local function setEnable(group, value)
	PitBull_ReadyCheckIcon.db.profile[group].disable = not value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_ReadyCheckIcon:Update(unit, frame)
	end
end

PitBull_ReadyCheckIcon:RegisterPitBullOptionsMethod(function(group)
	if group:match("pet") then return end	
	return {
		type = 'group',
		name = L["Ready Check"],
		desc = L["Options for the ready check icon for this unit."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the ready check icon display on the unit frames for this unit type."],
				get = getEnable,
				set = setEnable,
				passValue = group,
			}
		}
	}
end)
