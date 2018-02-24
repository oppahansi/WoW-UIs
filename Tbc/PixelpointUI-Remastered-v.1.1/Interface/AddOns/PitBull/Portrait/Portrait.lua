if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
PitBull:SetModuleDefaultState("Portrait", false)
local PitBull_Portrait = PitBull:NewModule("Portrait", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_Portrait
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a portrait on the PitBull unit frame."] = "PitBull 유닛 프레임에 초상화를 보여줍니다.",
	["Portrait"] = "초상화",
	["Options for portrait display."] = "초상화 표시를 위한 옵션입니다.",
	["Enable portrait"] = "초상화 활성화",
	["Enables the portrait for this unit type."] = "이 유닛 유형에 대해 초상화를 활성화합니다.",
	["Full body"] = "전체 신체",
	["Show the full body of the unit when in 3D mode."] = "3D 모드인 경우에 유닛의 전체 신체를 보여줍니다.",
	["Style"] = "양식",
	["Set the portrait style to use for this unit type."] = "이 유닛 유형에 사용할 초상화 양식을 설정합니다.",
	["Fallback"] = "되돌리기",
	["Set what to fall back to from the portrait style if it is not available."] = "가능하지 않다면 초상화 양식을 원래의 것으로 되돌려 설정합니다.",
	["3D"] = "3D",
	["If unit is out of range, show..."] = "유닛이 시야를 벗어난 경우에 보여줍니다...",
	["2D"] = "2D",
	["Class"] = "직업 아이콘",
	["None"] = "표시 안함",
	["If unit isn't a player, show..."] = "유닛이 플레이어가 아닌 경우에 보여줍니다...",
} or (GetLocale() == "zhCN") and {
	["Show a portrait on the PitBull unit frame."] = "在PitBull单位框体上显示头像。",
	["Portrait"] = "头像",
	["Options for portrait display."] = "头像显示设置。",
	["Enable portrait"] = "启用头像",
	["Enables the portrait for this unit type."] = "为这种单位类型启用头像显示。",
	["Full body"] = "全身像",
	["Show the full body of the unit when in 3D mode."] = "在 3D 方式下显示全身像。",
	["Style"] = "样式",
	["Set the portrait style to use for this unit type."] = "为这种单位类型设置头像的显示样式。",
	["2D"] = "2D 头像",
	["3D"] = "3D 头像",
	["Class"] = "职业图标",
	["Fallback"] = "向下兼容",
	["Set what to fall back to from the portrait style if it is not available."] = "假如某风格头像不可用，则显示更基础的头像风格。",
	["If unit is out of range, show..."] = "如果目标距离太远，则显示……",
	["None"] = "无",
	["If unit isn't a player, show..."] = "如果目标不是玩家，则显示……",
} or (GetLocale() == "frFR") and {
	["Show a portrait on the PitBull unit frame."] = "Affiche un portrait sur la fenêtre d'unité de PitBull.",
	["Portrait"] = "Portrait",
	["Options for portrait display."] = "Options pour l'affichage du portrait.",
	["Enable portrait"] = "Activer portrait",
	["Enables the portrait for this unit type."] = "Active le portrait pour ce type d'unité.",
	["Full body"] = "Tout le corps",
	["Show the full body of the unit when in 3D mode."] = "Affiche le corps en entier quand le mode 3D est utilisé.",
	["Style"] = "Style",
	["Set the portrait style to use for this unit type."] = "Définit le style de portrait à utiliser pour ce type d'unité.",
	["Fallback"] = "Choix de secours",
	["Set what to fall back to from the portrait style if it is not available."] = "Définit quel style de portrait choisir lorsque celui par défaut n'est pas disponible.",
	["3D"] = "3D",
	["If unit is out of range, show..."] = "Si l'unité est hors d'atteinte, afficher...",
	["2D"] = "2D",
	["Class"] = "Classe",
	["None"] = "Aucun",
	["If unit isn't a player, show..."] = "Si l'unité n'est pas un joueur, afficher...",
} or (GetLocale() == "zhTW") and {
	["Show a portrait on the PitBull unit frame."] = "在PitBull單位框架上顯示頭像.",
	["Portrait"] = "頭像",
	["Options for portrait display."] = "頭像顯示的選項.",
	["Enable portrait"] = "啟用頭像",
	["Enables the portrait for this unit type."] = "啟用此類單位的頭像.",
	["Full body"] = "全身",
	["Show the full body of the unit when in 3D mode."] = "當在3D模式時顯示全身.",
	["Style"] = "風格",
	["Set the portrait style to use for this unit type."] = "設置此類單位的頭像風格.",
	["Fallback"] = "應用",
	["Set what to fall back to from the portrait style if it is not available."] = "如果頭像風格不可用,則退回到前一種風格.",
	["3D"] = "3D",
	["If unit is out of range, show ..."] = "如果單位超出距離,顯示...",
	["2D"] = "2D",
	["Class"] = "職業",
	["None"] = "無",
	["If unit isn't a player, show..."] = "如果單位不是玩家, 顯示...",
} or {}

local L = PitBull:L("PitBull-Portrait", localization)

self.desc = L["Show a portrait on the PitBull unit frame."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_Portrait:RegisterPitBullChildFrames("portrait")
PitBull_Portrait:RegisterPitBullBarLayoutHandler("portrait", L["Portrait"], L["Portrait"], true)

function PitBull_Portrait:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("Portrait")
	PitBull:SetDatabaseNamespaceDefaults("Portrait", "profile", {
		["**"] = {
			style = "3D",
			fallback3D = "3D",
			fallback2D = "2D",
			fallbackClass = "Class",
			fullBody = false,
		},
	})
end

function PitBull_Portrait:OnEnable()
	self:AddEventListener("UNIT_PORTRAIT_UPDATE")
	self:AddEventListener("PARTY_MEMBERS_CHANGED")
	self:AddEventListener("PARTY_LEADER_CHANGED", "PARTY_MEMBERS_CHANGED")
	self:AddEventListener("RAID_ROSTER_UPDATE", "PARTY_MEMBERS_CHANGED")
end

function PitBull_Portrait:UNIT_PORTRAIT_UPDATE(ns, event, unit)
	for frame in PitBull:IterateUnitFramesForUnit(unit) do
		self:Update(unit, frame, true)
	end
end

local function UpdateStuff(self)
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		self:Update(unit, frame, true)
	end
end

function PitBull_Portrait:PARTY_MEMBERS_CHANGED()
	self:AddTimer("PitBull_Portrait-UpdateStuff", 0, UpdateStuff, self)
end

local classIcons = {
	["WARRIOR"] = {0, 0.25, 0, 0.25},
	["MAGE"] = {0.25, 0.49609375, 0, 0.25},
	["ROGUE"] = {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"] = {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"] = {0, 0.25, 0.25, 0.5},
	["SHAMAN"] = {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"] = {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"] = {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"] = {0, 0.25, 0.5, 0.75},
}
function PitBull_Portrait:Update(unit, frame, override)
	if frame.portrait then
		local style = PitBull_Portrait.db.profile[frame.group].style
		local fallback = PitBull_Portrait.db.profile[frame.group]["fallback"..style]
		local portrait = frame.portrait
		if portrait.fallback then
			portrait.fallback = delFrame(portrait.fallback)
		end
		if (style ~= fallback) and ((style ~= "Class" and (not UnitExists(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit))) or (style == "Class" and not UnitIsPlayer(unit))) then
			if fallback == "None" then
				if style == '3D' then
					portrait:ClearModel()
				else
					portrait:SetTexture(nil)
				end
				return
			elseif fallback == "3D" then
				portrait.fallback = newFrame("PlayerModel", frame)
			else
				if style == '3D' then
					portrait:ClearModel()
				end
				portrait.fallback = newFrame("Texture", frame, "ARTWORK")
			end
			portrait.fallback:SetAllPoints(portrait)
			portrait = portrait.fallback
			style = fallback
		end
		if style == "3D" then
			if not UnitExists(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit) then
				local name = "question"
				if name == portrait.lastName and PitBull.IsWackyUnit[unit] and not override then
					return
				end
				portrait.lastName = name
				portrait:SetModelScale(4.25)
				portrait:SetPosition(0,0,-1.5)
				portrait:SetModel("Interface\\Buttons\\talktomequestionmark.mdx")
			else
				local name = UnitName(unit)
				if name == portrait.lastName and PitBull.IsWackyUnit[unit] and not override then
					return
				end
				portrait.lastName = name
				portrait:SetUnit(unit)
				portrait:SetCamera(1)
				if not PitBull_Portrait.db.profile[frame.group].fullBody then
					self:AddTimer(0, portrait.SetCamera, portrait, 0)
				end
				portrait:Show()
			end
		elseif style == "2D" then
			portrait:SetTexCoord(0.14644660941, 0.85355339059, 0.14644660941, 0.85355339059)
			SetPortraitTexture(portrait, unit)
		elseif style == "Class" then
			--"SetPortraitToTexture("texture", icon)" useful here?  Investigate.
			--Note that if unit is a mob, the class icon seems to be WARRIOR, MAGE, or PALADIN, which isn"t very helpful.
			--Hunt down in-game icons for the output of UnitClassification, maybe?
			local classname = select(2,UnitClass(unit))
			if classname then
				local class = classIcons[classname]
				portrait:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
				portrait:SetTexCoord(class[1], class[2], class[3], class[4])
			else
				-- Pets. Work out a better icon?
				portrait:SetTexture("Interface\\Icons\\Ability_Hunter_BeastCall")
				portrait:SetTexCoord(0,1,0,1)
			end
		end
	end
end

function PitBull_Portrait:OnUpdateFrame(unit, frame)
	self:Update(unit, frame)
end

function PitBull_Portrait:OnPopulateUnitFrame(unit, frame)
	if not self.db.profile[frame.group].hidden then
		local style = self.db.profile[frame.group].style
		local portrait
		if style == "3D" then
			portrait = newFrame("PlayerModel", frame)
		else
			portrait = newFrame("Texture", frame, "ARTWORK")
		end
		frame.portrait = portrait
		local portraitBG = newFrame("Texture", frame, "BACKGROUND")
		frame.portrait.bg = portraitBG
		portraitBG:SetTexture(0, 0, 0, 0.25)
		portraitBG:SetAllPoints(portrait)
	end
end

function PitBull_Portrait:OnClearUnitFrame(unit, frame)
	if frame.portrait then
		if frame.portrait.fallback then
			frame.portrait.fallback = delFrame(frame.portrait.fallback)
		end
		frame.portrait.bg = delFrame(frame.portrait.bg)
		frame.portrait.lastName = nil
		frame.portrait = delFrame(frame.portrait)
	end
end

--[[
function PitBull_Portrait:OnUpdateLayout(unit, frame)
	if frame.portrait then
		self:Update(unit,frame)
	end
end

function PitBull_Portrait:OnUnknownLayout(unit, frame, name)
	if name == "portrait" then
		if unit == "target" then
			frame.portrait:SetPoint("LEFT", frame, "RIGHT", 5, 0)
		else
			frame.portrait:SetPoint("RIGHT", frame, "LEFT", -5, 0)
		end
	end
end
]]
local function updateGroup(group)
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		self:OnClearUnitFrame(unit, frame)
		self:OnPopulateUnitFrame(unit, frame)
		self:OnUpdateFrame(unit, frame)
		
		PitBull:UpdateLayout(frame)
	end
end
local function getDisabled(group)
	return PitBull_Portrait.db.profile[group].hidden
end
local function getEnabled(group)
	return not PitBull_Portrait.db.profile[group].hidden
end
local function setEnabled(group, value)
	value = not value
	PitBull_Portrait.db.profile[group].hidden = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if value then
			self:OnClearUnitFrame(unit, frame)
		else
			self:OnPopulateUnitFrame(unit, frame)
			self:OnUpdateFrame(unit, frame)
		end
		PitBull:UpdateLayout(frame)
	end
end
local function getStyle(group)
	return PitBull_Portrait.db.profile[group].style
end
local function setStyle(group, value)
	if value ~= PitBull_Portrait.db.profile[group].style then
		PitBull_Portrait.db.profile[group].style = value
		updateGroup(group)
	end
end
local function getFullBody(group)
	return PitBull_Portrait.db.profile[group].fullBody
end
local function setFullBody(group, value)
	if value ~= PitBull_Portrait.db.profile[group].fullBody then
		PitBull_Portrait.db.profile[group].fullBody = value
		updateGroup(group)
	end
end
PitBull_Portrait:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["Portrait"],
		desc = L["Options for portrait display."],
		type = 'group',
		args = {
			hide = {
				type = 'boolean',
				name = L["Enable portrait"],
				desc = L["Enables the portrait for this unit type."],
				get = getEnabled,
				set = setEnabled,
				passValue = group,
				order = 1,
			},
			fullBody = {
				type = 'boolean',
				name = L["Full body"],
				desc = L["Show the full body of the unit when in 3D mode."],
				get = getFullBody,
				set = setFullBody,
				passValue = group,
				disabled = getDisabled,
			},
			style = {
				type = 'choice',
				name = L["Style"],
				desc = L["Set the portrait style to use for this unit type."],
				get = getStyle,
				set = setStyle,
				passValue = group,
				choices = {
					["2D"] = L["2D"],
					["3D"] = L["3D"],
					["Class"] = L["Class"],
				},
				disabled = getDisabled,
			},
			fallback = {
				type = 'group',
				groupType = 'inline',
				name = L["Fallback"],
				desc = L["Set what to fall back to from the portrait style if it is not available."],
				disabled = getDisabled,
				passValue = group,
				args = {
					["3D"] = {
						type = 'choice',
						name = L["3D"],
						desc = L["If unit is out of range, show..."],
						get = function(group) return self.db.profile[group].fallback3D end,
						set = function(group, value)
							self.db.profile[group].fallback3D = value
							updateGroup(group)
						end,
						passValue = group,
						choices = {
							["2D"] = L["2D"],
							["3D"] = L["3D"],
							["Class"] = L["Class"],
							["None"] = L["None"],
						},
					},
					["2D"] = {
						type = 'choice',
						name = L["2D"],
						desc = L["If unit is out of range, show..."],
						get = function(group) return self.db.profile[group].fallback2D end,
						set = function(group, value)
							self.db.profile[group].fallback2D = value
							updateGroup(group)
						end,
						passValue = group,
						choices = {
							["2D"] = L["2D"],
							["3D"] = L["3D"],
							["Class"] = L["Class"],
							["None"] = L["None"],
						},
					},
					["Class"] = {
						type = 'choice',
						name = L["Class"],
						desc = L["If unit isn't a player, show..."],
						get = function(group) return self.db.profile[group].fallbackClass end,
						set = function(group, value)
							self.db.profile[group].fallbackClass = value
							updateGroup(group)
						end,
						passValue = group,
						choices = {
							["2D"] = L["2D"],
							["3D"] = L["3D"],
							["Class"] = L["Class"],
							["None"] = L["None"],
						},
					},
				},
			},
		}
	}
end)

