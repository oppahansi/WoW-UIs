if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_HealthBar = PitBull:NewModule("HealthBar", "LibRockEvent-1.0")
local self = PitBull_HealthBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a health bar on the unit frame."] = "유닛 프레임에 생명력 바를 보여줍니다.",
	["Health"] = "생명력",
	["Health bar"] = "생명력 바",
	["Health bar display options."] = "생명력 바 표시 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the health bar."] = "생명력 바를 활성화합니다.",
	["Color by class"] = "직업에 따른 색상",
	["Color the health bar by unit class."] = "생명력 바를 유닛 직업에 따라 색상화합니다.",
	["Color by class for PvP enemies"] = "PvP 적을 위한 직업에 따른 색상",
	["Color the health bar for PvP enemies by unit class."] = "PvP 적을 위한 생명력 바를 유닛 직업에 따라 색상화합니다.",
	["Color by hostility"] = "적대성에 따른 색상",
	["Color the health bar by hostility. Note that this takes precedence after color by class."] = "생명력 바를 적대성에 따라 색상화합니다. 이 옵션은 직업에 따른 색상 옵션에 선행해 취해야 한다는 것에 유의하십시오.",
	["Color NPCs by hostility"] = "적대성에 따른 NPC 색상",
	["Color the health bar by hostility for NPCs. Note that this takes precedence after color by class."] = "NPC를 위한 생명력 바를 적대성에 따라 색상화합니다. 이 옵션은 직업에 따른 색상 옵션에 선행해 취해야 한다는 것에 유의하십시오.",
	["Custom color"] = "사용자 색상",
	["Set a custom color for the health bar. Note that this is the least priority after all the color options."] = "생명력 바를 위한 사용자 색상을 설정합니다. 이 옵션은 모든 색상 옵션 다음에 최소한의 우선권이 있다는 것에 유의하십시오.",
	["Enable using a custom color for the health bar."] = "생명력 바를 위한 사용자 색상 사용을 활성화합니다.",
	["Color"] = "색상",
	["Set the custom color for the health bar."] = "생명력 바를 위한 사용자 색상을 설정합니다.",
	["Custom background color"] = "사용자 배경 색상",
	["Set a custom background color for the health bar."] = "생명력 바를 위한 사용자 배경 색상을 설정합니다.",
	["Enable using a custom background color for the health bar."] = "생명력 바를 위한 사용자 배경 색상 사용을 활성화합니다.",
	["Set the custom background color for the health bar."] = "생명력 바를 위한 사용자 배경 색상을 설정합니다.",
	["Color by happiness"] = "만족도에 따른 색상",
	["Color health bar by pet happiness status."] = "생명력 바를 소환수의 만족도 상태에 따라 색상화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show a health bar on the unit frame."] = "在单位框体上显示生命条。",
	["Health"] = "生命",
	["Health bar"] = "生命条",
	["Health bar display options."] = "生命条显示设置。",
	["Enable"] = "启用",
	["Enables the health bar."] = "启用生命条显示。",
	["Color by class"] = "按职业着色",
	["Color the health bar by unit class."] = "生命条以单位的职业颜色显示。",
	["Color by class for PvP enemies"] = "PvP按职业着色",
	["Color the health bar for PvP enemies by unit class."] = "生命条以PvP敌人的职业颜色显示。",
	["Color by hostility"] = "按敌意着色",
	["Color the health bar by hostility. Note that this takes precedence after color by class."] = "按照敌意着色生命条，注意这个比按照职业着色的优先权低。",
	["Color NPCs by hostility"] = "按NPC敌意着色",
	["Color the health bar by hostility for NPCs. Note that this takes precedence after color by class."] = "对于非玩家角色按照敌意着色生命条，注意这个比按照职业着色的优先权低。",
	["Custom color"] = "自定义颜色",
	["Set a custom color for the health bar. Note that this is the least priority after all the color options."] = "为生命条自定义颜色，注意这项的优先级在所有的颜色设置之后。",
	["Enable using a custom color for the health bar."] = "启用自定义生命条颜色。",
	["Color"] = "颜色",
	["Set the custom color for the health bar."] = "为生命条自定义颜色。",
	["Custom background color"] = "自定义背景色",
	["Set a custom background color for the health bar."] = "为生命条自定义背景色。",
	["Enable using a custom background color for the health bar."] = "启用自定义生命条背景色。",
	["Set the custom background color for the health bar."] = "为生命条自定义背景色。",
	["Color by happiness"] = "按宠物快乐度着色",
	["Color health bar by pet happiness status."] = "以宠物快乐度来决定其生命条的颜色。",
} or (GetLocale() == "zhTW") and {
	["Show a health bar on the unit frame."] = "在單位框架上顯示生命條.",
	["Health"] = "生命值",
	["Health bar"] = "生命條",
	["Health bar display options."] = "生命條顯示選項.",
	["Enable"] = "啟用",
	["Enables the health bar."] = "啟用生命條.",
	["Color by class"] = "職業分色",
	["Color the health bar by unit class."] = "根據單位的職業來劃分顏色.",
	["Color by class for PvP enemies"] = "敵對玩家職業分色",
	["Color the health bar for PvP enemies by unit class."] = "根據敵對玩家的職業來劃分顏色.",
	["Color by hostility"] = "非友善生物的顏色",
	["Color the health bar by hostility. Note that this takes precedence after color by class."] = "指定非友善生物的顏色,注意此優先權在職業分色之後.",
	["Color NPCs by hostility"] = "根據友善度著色NPC",
	["Color the health bar by hostility for NPCs. Note that this takes precedence after color by class."] = "指定非友善NPC的顏色,注意此優先權在職業分色之後.",
	["Custom color"] = "自定義顏色",
	["Set a custom color for the health bar. Note that this is the least priority after all the color options."] = "生命條顏色自定義.注意此優先權在所有著色選項之後.",
	["Enable using a custom color for the health bar."] = "啟用生命條自定義顏色.",
	["Color"] = "顏色",
	["Set the custom color for the health bar."] = "設定生命條自定義顏色.",
	["Custom background color"] = "自定義背景色",
	["Set a custom background color for the health bar."] = "設定生命條自定義背景色.",
	["Enable using a custom background color for the health bar."] = "啟用自定義生命條背景色.",
	["Set the custom background color for the health bar."] = "設定此生命條自定義背景色.",
	["Color by happiness"] = "根據快樂度著色",
	["Color health bar by pet happiness status."] = "根據寵物快樂程度設定生命條顏色.",
} or {}

local L = PitBull:L("PitBull-HealthBar", localization)

PitBull_HealthBar.desc = L["Show a health bar on the unit frame."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitClass = UnitClass

PitBull_HealthBar:RegisterPitBullChildFrames("healthBar")
PitBull_HealthBar:RegisterPitBullBarLayoutHandler("healthBar", L["Health bar"], L["Health"])

local unitsShown = {}

function PitBull_HealthBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("HealthBar")
	PitBull:SetDatabaseNamespaceDefaults("HealthBar", "profile", {
		["**"] = {
			hidden = false,
			classColor = true,
			classColorPvP = false,
			hostilityColor = false,
			hostilityColorNPCs = false,
			customColor = false,
			customColors = {1,1,1},
			customBGColor = false,
			customBGColors = {11/255, 11/255, 11/255},
		},
		focus = {
			hostilityColor = true,
		},
		target = {
			hostilityColor = true,
		},
		targettarget = {
			hostilityColor = true,
		},
		targettargettarget = {
			hostilityColor = true,
		},
		focustarget = {
			hostilityColor = true,
		},
		partytarget = {
			hostilityColor = true,
		},
		partypettarget = {
			hostilityColor = true,
		},
		raidtarget = {
			hostilityColor = true,
		},
		pet = {
			happinessColor = true,
		},
		mouseover = {
			hostilityColor = true,
		},
		mouseovertarget = {
			hostilityColor = true,
		},
	})
end

function PitBull_HealthBar:OnEnable(first)
	-- bucketed events
	self:AddEventListener({UNIT_HEALTH = true, UNIT_MAXHEALTH = true}, "UNIT_HEALTH", 0.05)
	self:AddEventListener("UNIT_FACTION", "UNIT_FACTION", 0.05)
end

function PitBull_HealthBar:UNIT_HEALTH(ns, event, units, ...)
	for unit in pairs(units) do
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			if unitsShown[frame] then
				self:UpdateHealth(unit, frame)
				self:UpdateHealthbarColor(unit, frame)
			end
		end
	end
end

function PitBull_HealthBar:UNIT_FACTION(ns, event, units)
	for unit in pairs(units) do
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			if unitsShown[frame] then
				self:UpdateHealthbarColor(unit, frame)
			end
		end
	end
end

local alerted = false
function PitBull_HealthBar:UpdateHealth(unit, frame)
	if not frame.healthBar then
		return
	end
	if not frame.group then
		return
	end
	local db = self.db.profile[frame.group]
	
	local max = UnitHealthMax(unit)
	if max > 0 then
		local value = UnitHealth(unit)
		local perc = value / max
		frame.healthBar:SetValue(perc)
	end
end

local function HealthGradient(perc)
	local r1, g1, b1
	local r2, g2, b2
	if perc <= 0.5 then
		perc = perc * 2
		r1, g1, b1 = unpack(PitBull.colorConstants.minHP)
		r2, g2, b2 = unpack(PitBull.colorConstants.midHP)
	else
		perc = perc * 2 - 1
		r1, g1, b1 = unpack(PitBull.colorConstants.midHP)
		r2, g2, b2 = unpack(PitBull.colorConstants.maxHP)
	end
	return r1 + (r2-r1)*perc, g1 + (g2-g1)*perc, b1 + (b2-b1)*perc
end

local _,class = UnitClass("player")
function PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	if not frame.healthBar then
		return
	end
	local db = self.db.profile[frame.group]
	
	local r, g, b, a
	if not UnitIsConnected(unit) then
		r, g, b = unpack(PitBull.colorConstants.disconnected)
	elseif UnitIsDeadOrGhost(unit) then
		r, g, b = unpack(PitBull.colorConstants.dead)
	elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
		r, g, b = unpack(PitBull.colorConstants.tapped)
	elseif UnitIsPlayer(unit) then
		if db.classColor and (db.classColorPvP or UnitIsFriend("player", unit)) then
			local _,class = UnitClass(unit)
			r, g, b = unpack(PitBull.colorConstants[class or "WARRIOR"])
		elseif db.hostilityColor or db.hostilityColorNPCs then
			if UnitCanAttack(unit, "player") then
				-- they can attack me
				if UnitCanAttack("player", unit) then
					-- and I can attack them
					r, g, b = unpack(PitBull.colorConstants.hostile)
				else
					-- but I can"t attack them
					r, g, b = unpack(PitBull.colorConstants.civilian)
				end
			elseif UnitCanAttack("player", unit) then
				-- they can"t attack me, but I can attack them
				r, g, b = unpack(PitBull.colorConstants.neutral)
			elseif UnitIsFriend("player", unit) and db.hostilityColor then
				-- on my team
				r, g, b = unpack(PitBull.colorConstants.friendly)
			elseif db.hostilityColor then
				-- either enemy or friend, no violence
				r, g, b = unpack(PitBull.colorConstants.civilian)
			end
		elseif db.customColor then
			r, g, b, a = unpack(db.customColors)
		end
	elseif UnitIsUnit(unit, "pet") and db.happinessColor then
		if class == "HUNTER" then
			local happy = GetPetHappiness()
			if happy == 3 then
				r, g, b = unpack(PitBull.colorConstants.petHappy)
			elseif happy == 2 then
				r, g, b = unpack(PitBull.colorConstants.petNeutral)
			elseif happy == 1 then
				r, g, b = unpack(PitBull.colorConstants.petAngry)
			end
		end
	elseif db.hostilityColor or db.hostilityColorNPCs then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				r, g, b = unpack(PitBull.colorConstants.friendly)
			elseif reaction == 4 then
				r, g, b = unpack(PitBull.colorConstants.neutral)
			else
				r, g, b = unpack(PitBull.colorConstants.hostile)
			end
		else
			r, g, b = unpack(PitBull.colorConstants.unknown)
		end
	elseif db.customColor then
		r, g, b, a = unpack(db.customColors)
	end
	if not r then
		local perc = UnitHealth(unit) / UnitHealthMax(unit)
		r, g, b = HealthGradient(perc)
	end
	frame.healthBar:SetColor(r, g, b, a)
	
	if db.customBGColor then
		frame.healthBar:SetBackgroundColor(unpack(db.customBGColors))
	else
		frame.healthBar:SetBackgroundColor(nil, nil, nil)
	end
end

function PitBull_HealthBar:OnUpdateFrame(unit, frame)
	if frame.healthBar and unitsShown[frame] then
		self:UpdateHealth(unit, frame)
		self:UpdateHealthbarColor(unit, frame)
	end
end

function PitBull_HealthBar:OnPopulateUnitFrame(unit, frame)
	if self.db.profile[frame.group].hidden then
		return
	end
	local texture = PitBull:GetStatusBarTexture()
	
	local healthBar = newFrame("FakeStatusBar", frame)
	frame.healthBar = healthBar
	healthBar:SetValue(1)
	healthBar:SetTexture(texture)
	healthBar:SetColor(0, 1, 0, 1)
end

function PitBull_HealthBar:OnClearUnitFrame(unit, frame)
	if frame.healthBar then
		frame.healthBar = delFrame(frame.healthBar)
	end
end

function PitBull_HealthBar:OnUpdateStatusBarTexture(texture)
	for _,frame in PitBull:IterateUnitFrames() do
		frame.healthBar:SetTexture(texture)
	end
end

function PitBull_HealthBar:OnUpdateLayout(unit, frame)
	local old = not unitsShown[frame]
	local now = not frame.healthBar or not frame.healthBar:IsShown()
	if old == now then
		return
	end
	unitsShown[frame] = not now
	if not now then
		self:OnUpdateFrame(unit, frame)
	end
end

local function getClassColor(group)
	return PitBull_HealthBar.db.profile[group].classColor
end
local function setClassColor(group, value)
	PitBull_HealthBar.db.profile[group].classColor = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end
local function getClassColorPvP(group)
	return PitBull_HealthBar.db.profile[group].classColorPvP
end
local function setClassColorPvP(group, value)
	PitBull_HealthBar.db.profile[group].classColorPvP = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end
local function getHostilityColor(group)
	return PitBull_HealthBar.db.profile[group].hostilityColor
end
local function setHostilityColor(group, value)
	PitBull_HealthBar.db.profile[group].hostilityColor = value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function getHostilityColorNPCs(group)
	return PitBull_HealthBar.db.profile[group].hostilityColorNPCs
end
local function setHostilityColorNPCs(group, value)
	PitBull_HealthBar.db.profile[group].hostilityColorNPCs = value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function GetPetHappiness(group)
	return PitBull_HealthBar.db.profile.pet.happinessColor
end

local function SetPetHappiness(group, value)
	PitBull_HealthBar.db.profile.pet.happinessColor = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealth(unit, frame)
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function GetCustomColorToggle(group)
	return PitBull_HealthBar.db.profile[group].customColor
end

local function SetCustomColorToggle(group, value)
	PitBull_HealthBar.db.profile[group].customColor = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealth(unit, frame)
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function GetCustomColor(group)
	return unpack(PitBull_HealthBar.db.profile[group].customColors)
end

local function SetCustomColor(group, r, g, b)
	PitBull_HealthBar.db.profile[group].customColors = {r, g, b}
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealth(unit, frame)
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function GetCustomBGColorToggle(group)
	return PitBull_HealthBar.db.profile[group].customBGColor
end

local function SetCustomBGColorToggle(group, value)
	PitBull_HealthBar.db.profile[group].customBGColor = value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealth(unit, frame)
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function GetCustomBGColor(group)
	return unpack(PitBull_HealthBar.db.profile[group].customBGColors)
end

local function SetCustomBGColor(group, r, g, b)
	PitBull_HealthBar.db.profile[group].customBGColors = {r, g, b}

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_HealthBar:UpdateHealth(unit, frame)
		PitBull_HealthBar:UpdateHealthbarColor(unit, frame)
	end
end

local function getDisabled(group)
	return PitBull_HealthBar.db.profile[group].hidden
end
local function getEnabled(group)
	return not PitBull_HealthBar.db.profile[group].hidden
end
local function setEnabled(group, value)
	value = not value
	PitBull_HealthBar.db.profile[group].hidden = value
	
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

PitBull_HealthBar:RegisterPitBullOptionsMethod(function(group)
	local hostility, petOptions = nil, nil
	if group == "focus" or group:find("target$") or group == "mouseover" then
		hostility = true
	elseif group == "pet" then
		petOptions = true
	end
	return {
		name = L["Health"],
		desc = L["Health bar display options."],
		type = 'group',
		args = {
			enable = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the health bar."],
				get = getEnabled,
				set = setEnabled,
				passValue = group,
				order = 1,
			},
			classColor = {
				type = 'boolean',
				name = L["Color by class"],
				desc = L["Color the health bar by unit class."],
				get = getClassColor,
				set = setClassColor,
				passValue = group,
				disabled = getDisabled,
			},
			classColorPvP = hostility and {
				type = 'boolean',
				name = L["Color by class for PvP enemies"],
				desc = L["Color the health bar for PvP enemies by unit class."],
				get = getClassColorPvP,
				set = setClassColorPvP,
				passValue = group,
				disabled = getDisabled,
			},
			hostilityColor = hostility and {
				type = 'boolean',
				name = L["Color by hostility"],
				desc = L["Color the health bar by hostility. Note that this takes precedence after color by class."],
				get = getHostilityColor,
				set = setHostilityColor,
				passValue = group,
				disabled = getDisabled,
			},
			hostilityColorNPCs = hostility and {
				type = 'boolean',
				name = L["Color NPCs by hostility"],
				desc = L["Color the health bar by hostility for NPCs. Note that this takes precedence after color by class."],
				get = getHostilityColorNPCs,
				set = setHostilityColorNPCs,
				passValue = group,
				disabled = getDisabled,
			},
			customColor = {
				type = 'group',
				name = L["Custom color"],
				desc = L["Set a custom color for the health bar. Note that this is the least priority after all the color options."],
				args = {
					Enable = {
						type = 'boolean',
						name = L["Enable"],
						desc = L["Enable using a custom color for the health bar."],
						get = GetCustomColorToggle,
						set = SetCustomColorToggle,
						passValue = group,
					},
					setColor = {
						type = 'color',
						name = L["Color"],
						desc = L["Set the custom color for the health bar."],
						get = GetCustomColor,
						set = SetCustomColor,
						disabled = function() return not GetCustomColorToggle(group) end,
						passValue = group,
					},
				},
				passValue = group,
				disabled = getDisabled,
			},
			customBGColor = {
				type = 'group',
				name = L["Custom background color"],
				desc = L["Set a custom background color for the health bar."],
				args = {
					Enable = {
						type = 'boolean',
						name = L["Enable"],
						desc = L["Enable using a custom background color for the health bar."],
						get = GetCustomBGColorToggle,
						set = SetCustomBGColorToggle,
						passValue = group,
					},
					setColor = {
						type = 'color',
						name = L["Color"],
						desc = L["Set the custom background color for the health bar."],
						get = GetCustomBGColor,
						set = SetCustomBGColor,
						disabled = function() return not GetCustomBGColorToggle(group) end,
						passValue = group,
					},
				},
				passValue = group,
				disabled = getDisabled,
			},
			happinessColor = petOptions and {
				name = L["Color by happiness"],
				desc = L["Color health bar by pet happiness status."],
				type = 'boolean',
				get = GetPetHappiness,
				set = SetPetHappiness,
				passValue = group,
				disabled = getDisabled,
			},
		}
	}
end)

