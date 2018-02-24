if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 69651 $"):match("%d+"))

local PitBull = PitBull
local PitBull_PowerBar = PitBull:NewModule("PowerBar", "LibRockEvent-1.0")
local self = PitBull_PowerBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-13 19:58:38 -0400 (Sun, 13 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a mana/rage/energy/focus bar on the PitBull unit frames."] = "PitBull 유닛 프레임에 마나/분노/기력/집중 바를 보여줍니다.",
	["Power bar"] = "마력 바",
	["Power"] = "마력",
	["Power bar display settings for this unit type."] = "이 유닛 유형을 위한 마력 바 표시 설정입니다.",
	["Enable"] = "활성화",
	["Enables the power bar."] = "마력 바를 활성화합니다.",
	["Hide non-mana"] = "비-마나 숨김",
	["Hides the power bar if energy, rage, or focus is showing."] = "기력, 분노, 혹은 집중이 보여지고 있으면 마나 바를 숨김 설정합니다.",
	["Hide non-power"] = "비-마력 숨김",
	["Hides the power bar if the unit has no power."] = "유닛이 마력을 갖고 있지 않으면 마력 바를 숨김 설정합니다.",
	["Color by class"] = "직업별 색상",
	["Color the power bar by class instead of power type. Note: only colors if the unit is a player."] = "마력 유형 대신에 직업에 따라 마력 바를 색상화 합니다. 주의: 유닛이 플레이어인 경우에만 색상화 합니다.",
	["Custom Color"] = "사용자 색상",
	["Use custom colors for the power bars on this unit."] = "이 유닛에 대해 마력 바를 위한 사용자 색상을 사용합니다.",
	["Power Colors"] = "마력 색상",
	["Custom power bar colors."] = "사용자 마력 바 색상을 설정합니다.",
	["Rage"] = "분노",
	["Mana"] = "마나",
	["Focus(Pet)"] = "집중",
	["Energy"] = "기력",
	["Custom background color"] = "사용자 배경 색상",
	["Override dynamic background color calculation."] = "동적인 배경 색상 산출은 무시합니다.",
	["Power background colors"] = "마력 배경 색상",
	["Custom power bar background colors."] = "사용자 마력 바 배경 색상을 설정합니다.",
	["Rage Background"] = "분노 배경",
	["Mana Background"] = "마나 배경",
	["Focus Background"] = "집중 배경",
	["Energy Background"] = "기력 배경",
} or (GetLocale() == "zhCN") and { 
	["Show a mana/rage/energy/focus bar on the PitBull unit frames."] = "在单位框体上显示法力/怒气/能量/集中条。",
	["Power"] = "能量",
	["Power bar"] = "能量条",
	["Power bar display settings for this unit type."] = "能量条显示设置。",
	["Enable"] = "启用",
	["Enables the power bar."] = "启用能量条显示。",
	["Hide non-mana"] = "非法力类型隐藏",
	["Hides the power bar if energy, rage, or focus is showing."] = "当其能力类型为能量，怒气或者集中时隐藏能量条。",
	["Hide non-power"] = "无能量类型时隐藏",
	["Hides the power bar if the unit has no power."] = "当此单位没有能量类型的时候隐藏能量条。",
	["Color by class"] = "按职业着色",
	["Color the power bar by class instead of power type. Note: only colors if the unit is a player."] = "能量条以单位的职业颜色显示。注意：只有在单位为玩家时有效。",
	["Custom Color"] = "自定义颜色",
	["Use custom colors for the power bars on this unit."] = "为该单位自定义能量条颜色。",
	["Power Colors"] = "能量颜色",
	["Custom power bar colors."] = "自定义能量条颜色。",
	["Rage"] = "怒气",
	["Mana"] = "法力",
	["Focus(Pet)"] = "集中",
	["Energy"] = "能量",
	["Custom background color"] = "自定义背景色",
	["Override dynamic background color calculation."] = "覆盖掉动态背景色计算。",
	["Power background colors"] = "能量条背景色",
	["Custom power bar background colors."] = "自定义能量条背景色。",
	["Rage Background"] = "怒气背景色",
	["Mana Background"] = "法力背景色",
	["Focus Background"] = "集中背景色",
	["Energy Background"] = "能量背景色",
} or (GetLocale() == "frFR") and { 
	["Show a mana/rage/energy/focus bar on the PitBull unit frames."] = "Affiche une barre de mana/rage/énergie/focalisation sur les fenêtres d'unité de PitBul.",
	["Power"] = "Puissance",
	["Power bar"] = "Barre de puissance",
	["Power bar display settings for this unit type."] = "Paramètres de barre de puissance pour ce type d'unité.",
	["Enable"] = "Activer",
	["Enables the power bar."] = "Active la barre de puissance.",
	["Hide non-mana"] = "Cacher autres que mana",
	["Hides the power bar if energy, rage, or focus is showing."] = "Cache la barre de puissance si ce qu'elle affiche est de l'énergie, de la rage ou de la focalisation.",
	["Hide non-power"] = "Cacher autres que puissance",
	["Hides the power bar if the unit has no power."] = "Cache la barre de puissance si l'unité n'a pas de puissance.",
	["Color by class"] = "Coloriser par classe",
	["Color the power bar by class instead of power type. Note: only colors if the unit is a player."] = "Colorise la barre de puissance par classe au lieu de par type de puissance. Note: la colorisation ne sera effective que si l'unité est un joueur.",
	["Custom Color"] = "Couleur personnalisée",
	["Use custom colors for the power bars on this unit."] = "Utiliser des couleurs personnalisées pour les barres de puissance de cette unité.",
	["Power Colors"] = "Couleurs de puissance",
	["Custom power bar colors."] = "Couleurs personnalisées de barre de puissance.",
	["Rage"] = "Rage",
	["Mana"] = "Mana",
	["Focus(Pet)"] = "Focalisation(Familier)",
	["Energy"] = "Energie",
	["Custom background color"] = "Couleur d'arrière-plan personnalisée",
	["Override dynamic background color calculation."] = "Remplace le calcul dynamique de la couleur d'arrière-plan.",
	["Power background colors"] = "Couleurs d'arrière-plan de puissance",
	["Custom power bar background colors."] = "Couleurs personnalisées de l'arrière-plan de la barre de puissance.",
	["Rage Background"] = "Arrière-plan pour la rage",
	["Mana Background"] = "Arrière-plan pour le mana",
	["Focus Background"] = "Arrière-plan pour la focalisation",
	["Energy Background"] = "Arrière-plan pour l'énergie",
} or (GetLocale() == "zhTW") and {
	["Show a mana/rage/energy/focus bar on the PitBull unit frames."] = "在PitBull單位框架上顯示 法力/怒氣/能量/集中值 條",
	["Power"] = "能力",
	["Power bar"] = "能力條",
	["Power bar display settings for this unit type."] = "此種類型單位使用的能力條顯示設置.",
	["Enable"] = "啟用",
	["Enables the power bar."] = "啟用能力條",
	["Hide non-mana"] = "無法力時隱藏",
	["Hides the power bar if energy, rage, or focus is showing."] = "如果能量,怒氣,或者焦點顯示時隱藏能力條.",
	["Hide non-power"] = "無能力時隱藏",
	["Hides the power bar if the unit has no power."] = "如果物件無能力時隱藏.",
	["Color by class"] = "職業分色",
	["Color the power bar by class instead of power type. Note: only colors if the unit is a player."] = "將能力值按職業著色而不是能力類型.注意:只對玩家有效.",
	["Custom Color"] = "自定義顏色",
	["Use custom colors for the power bars on this unit."] = "為此單位的能力條使用自訂的顏色.",
	["Power Colors"] = "能力顏色",
	["Custom power bar colors."] = "自定義能力條的顏色.",
	["Rage"] = "怒氣",
	["Mana"] = "法力",
	["Focus(Pet)"] = "鎖定目標(寵物)",
	["Energy"] = "能量",
	["Custom background color"] = "自定義背景色",
	["Override dynamic background color calculation."] = "不考慮動態背景色的計算.",
	["Power background colors"] = "能力背景顏色",
	["Custom power bar background colors."] = "定制能力條背景色.",
	["Rage Background"] = "怒氣背景",
	["Mana Background"] = "法力背景",
	["Focus Background"] = "集中值背景",
	["Energy Background"] = "能量背景",
} or {}

local L = PitBull:L("PitBull-PowerBar", localization)

self.desc = L["Show a mana/rage/energy/focus bar on the PitBull unit frames."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local UnitMana = UnitMana
local UnitManaMax = UnitManaMax
local UnitClass = UnitClass
local UnitIsPlayer = UnitIsPlayer
local old_UnitPowerType = UnitPowerType
local function UnitPowerType(unit)
	local power = old_UnitPowerType(unit)
	if power ~= 0 then
		return power
	end
	local _,c = UnitClass(unit)
	if c == "ROGUE" then
		return 3
	elseif c == "WARRIOR" then
		return 1
	end
	return power
end
local ManaBarColor = ManaBarColor

PitBull_PowerBar:RegisterPitBullChildFrames('powerBar')
PitBull_PowerBar:RegisterPitBullBarLayoutHandler("powerBar", L["Power bar"], L["Power"])

local unitsShown = {}

function PitBull_PowerBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("PowerBar")
	PitBull:SetDatabaseNamespaceDefaults("PowerBar", "profile", {
		['**'] = {
			hidden = false,
			
			colorByClass = false,
			
			customColor = false,
			customBGColor = false,
			customColors = {
				rage = PitBull.colorConstants.rage,
				energy = PitBull.colorConstants.energy,
				focus = PitBull.colorConstants.focus,
				mana = PitBull.colorConstants.mana,

				rageBG = { 11/255, 11/255, 11/255 },
				energyBG = { 11/255, 11/255, 11/255 },
				focusBG = { 11/255, 11/255, 11/255 },
				manaBG = { 11/255, 11/255, 11/255 },
			},
			
			hideNoMana = false,
			hideNoPower = false,
		},
		targettarget = {
			hidden = true,
		},
		targettargettarget = {
			hidden = true,
		},
		raid = {
			hideNoMana = true,
		},
	})
end

function PitBull_PowerBar:OnEnable(first)
	-- bucketed events
	self:AddEventListener({UNIT_MANA=true, UNIT_RAGE=true, UNIT_FOCUS=true, UNIT_ENERGY=true, UNIT_MAXMANA=true, UNIT_MAXRAGE=true, UNIT_MAXFOCUS=true, UNIT_MAXENERGY=true }, "UNIT_MANA", 0.05)
	self:AddEventListener("UNIT_DISPLAYPOWER", "UNIT_DISPLAYPOWER", 0.05)
end

function PitBull_PowerBar:UNIT_MANA(ns, event, units)
	for unit in pairs(units) do
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			if unitsShown[frame] then
				self:UpdatePowerValue(unit, frame)
			end
		end
	end
end

function PitBull_PowerBar:UNIT_DISPLAYPOWER(ns, event, units)
	for unit in pairs(units) do
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			if self.db.profile[frame.group].hideNoMana then
				if UnitPowerType(unit) == 0 then -- mana
					if not frame.powerBar then
						self:OnPopulateUnitFrame(unit, frame)
						PitBull:UpdateLayout(frame)
					end
				else -- not mana
					if frame.powerBar then
						self:OnClearUnitFrame(unit, frame)
						PitBull:UpdateLayout(frame)
					end
				end
			elseif self.db.profile[frame.group].hideNoPower then
				if UnitManaMax(unit) > 0 then -- has power
					if not frame.powerBar then
						self:OnPopulateUnitFrame(unit, frame)
						PitBull:UpdateLayout(frame)
					end
				else -- no power
					if frame.powerBar then
						self:OnClearUnitFrame(unit, frame)
						PitBull:UpdateLayout(frame)
					end
				end
			end
			self:UpdatePowerValue(unit, frame)
			self:UpdatePowerColor(unit, frame)
		end
	end
end

function PitBull_PowerBar:UpdatePowerValueAndColor(group)
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_PowerBar:UpdatePowerValue(unit, frame)
		PitBull_PowerBar:UpdatePowerColor(unit, frame)
	end
end

function PitBull_PowerBar:UpdatePowerValue(unit, frame)
	if not frame.powerBar then
		return
	end
	local db = self.db.profile[frame.group]
	
	local max = UnitManaMax(unit)
	if max > 0 then
		local value = UnitMana(unit)
		local perc = value / max
		frame.powerBar:SetValue(perc)
	else	
		frame.powerBar:SetValue(0)
	end
end

function PitBull_PowerBar:UpdatePowerColor(unit, frame)
	if not frame.powerBar then
		return
	end
	local db = self.db.profile[frame.group]
	
	local powerType = UnitPowerType(unit)
	local r,g,b
	local br, bg, bb
	local customColor = db.customColor
	local customBGColor = db.customBGColor
	local colorByClass = db.colorByClass
	if colorByClass and UnitIsPlayer(unit) then
		local _,class = UnitClass(unit)
		if not PitBull.colorConstants[class] then error("Class color not found for: " .. class .. ". Please report to Ellipsis.") end
		r,g,b = unpack(PitBull.colorConstants[class])
	elseif powerType == 0 then
		if customColor then
			r,g,b = unpack(db.customColors.mana)
		else
			r,g,b = unpack(PitBull.colorConstants.mana)
		end
		if customBGColor then
			br,bg,bb = unpack(db.customColors.manaBG)
		end
	elseif powerType == 1 then
		if UnitManaMax(unit) == 0 then
			r,g,b = 0.2, 0.2, 0.2
		else
			if customColor then
				r,g,b = unpack(db.customColors.rage)
			else
				r,g,b = unpack(PitBull.colorConstants.rage)
			end
			if customBGColor then
				br,bg,bb = unpack(db.customColors.rageBG)
			end
		end
	elseif powerType == 2 then
		if customColor then
			r,g,b = unpack(db.customColors.focus)
		else
			r,g,b = unpack(PitBull.colorConstants.focus)
		end
		if customBGColor then
			br,bg,bb = unpack(db.customColors.focusBG)
		end
	elseif powerType == 3 then
		if customColor then
			r,g,b = unpack(db.customColors.energy)
		else
			r,g,b = unpack(PitBull.colorConstants.energy)
		end
		if customBGColor then
			br,bg,bb = unpack(db.customColors.energyBG)
		end
	else
		r,g,b = unpack(PitBull.colorConstants.unknown)
	end
	
	frame.powerBar:SetColor(r, g, b)
	
	if br then
		frame.powerBar:SetBackgroundColor(br, bg, bb)
	else
		frame.powerBar:SetBackgroundColor(nil, nil, nil)
	end
end

function PitBull_PowerBar:OnUpdateFrame(unit, frame)
	if self.db.profile[frame.group].hideNoMana then
		if UnitPowerType(unit) == 0 then -- mana
			if not frame.powerBar then
				self:OnPopulateUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		else -- not mana
			if frame.powerBar then
				self:OnClearUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end	
	elseif self.db.profile[frame.group].hideNoPower then
		if UnitManaMax(unit) > 0 then -- has power
			if not frame.powerBar then
				self:OnPopulateUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		else -- no power
			if frame.powerBar then
				self:OnClearUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end
	end
	if frame.powerBar and unitsShown[frame] then
		self:UpdatePowerValue(unit, frame)
		self:UpdatePowerColor(unit, frame)
	end
end

function PitBull_PowerBar:OnPopulateUnitFrame(unit, frame)
	if frame.powerBar or self.db.profile[frame.group].hidden then
		return
	end
	if self.db.profile[frame.group].hideNoMana then
	 	if UnitPowerType(unit) ~= 0 then
			return
		end
	elseif self.db.profile[frame.group].hideNoPower then
		if UnitManaMax(unit) == 0 then
			return
		end
	end
	local powerBar = newFrame("FakeStatusBar", frame)
	frame.powerBar = powerBar
	powerBar:SetTexture(PitBull:GetStatusBarTexture())
	powerBar:SetColor(0, 0, 1, 1)
end

function PitBull_PowerBar:OnClearUnitFrame(unit, frame)
	if frame.powerBar then
		frame.powerBar = delFrame(frame.powerBar)
	end
	unitsShown[frame] = nil
end

function PitBull_PowerBar:OnUpdateStatusBarTexture(texture)
	for _,frame in PitBull:IterateUnitFrames() do
		if frame.powerBar then
			frame.powerBar:SetTexture(texture)
		end
	end
end

function PitBull_PowerBar:OnUpdateLayout(unit, frame)
	local old = not unitsShown[frame]
	local now = not frame.powerBar or not frame.powerBar:IsShown()
	if old == now then
		return
	end
	unitsShown[frame] = not now
	if not now then
		self:OnUpdateFrame(unit, frame)
	end
end

local function getDisabled(group)
	return PitBull_PowerBar.db.profile[group].hidden
end
local function getEnabled(group)
	return not PitBull_PowerBar.db.profile[group].hidden
end
local function setEnabled(group, value)
	value = not value
	PitBull_PowerBar.db.profile[group].hidden = value
	
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

local function getColorByClass(group)
	return PitBull_PowerBar.db.profile[group].colorByClass
end

local function setColorByClass(group, value)
	PitBull_PowerBar.db.profile[group].colorByClass = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		self:UpdatePowerColor(unit, frame)
	end
end

local function getHideNoMana(group)
	return PitBull_PowerBar.db.profile[group].hideNoMana
end
local function setHideNoMana(group, value)
	PitBull_PowerBar.db.profile[group].hideNoMana = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if UnitPowerType(unit) ~= 0 then
			if value then
				self:OnClearUnitFrame(unit, frame)
			else
				self:OnPopulateUnitFrame(unit, frame)
				self:OnUpdateFrame(unit, frame)
			end
			PitBull:UpdateLayout(frame)
		end
	end
end

local function getHideNoPower(group)
	return PitBull_PowerBar.db.profile[group].hideNoPower
end
local function setHideNoPower(group, value)
	PitBull_PowerBar.db.profile[group].hideNoPower = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if UnitManaMax(unit) == 0 then
			if value then
				self:OnClearUnitFrame(unit, frame)
			else
				self:OnPopulateUnitFrame(unit, frame)
				self:OnUpdateFrame(unit, frame)
			end
			PitBull:UpdateLayout(frame)
		end
	end
end

local function getColor(group, kind)
	return unpack(PitBull_PowerBar.db.profile[group].customColors[kind])
end
local function setColor(group, kind, r, g, b, a)
	local t = PitBull_PowerBar.db.profile[group].customColors[kind]
	t[1] = r
	t[2] = g
	t[3] = b
	t[4] = a
	PitBull_PowerBar:UpdatePowerValueAndColor(group)
end
PitBull_PowerBar:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["Power"],
		desc = L["Power bar display settings for this unit type."],
		type = 'group',
		args = {
			enable = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the power bar."],
				get = getEnabled,
				set = setEnabled,
				passValue = group,
				order = 1,
			},
			hideNoMana = {
				type = 'boolean',
				name = L["Hide non-mana"],
				desc = L["Hides the power bar if energy, rage, or focus is showing."],
				get = getHideNoMana,
				set = setHideNoMana,
				passValue = group,
				disabled = getDisabled,
			},
			hideNoPower = group:find("target$") and {
				type = 'boolean',
				name = L["Hide non-power"],
				desc = L["Hides the power bar if the unit has no power."],
				get = getHideNoPower,
				set = setHideNoPower,
				passValue = group,
				disabled = getDisabled,
			} or nil,
			colorByClass = {
				type = 'boolean',
				name = L["Color by class"],
				desc = L["Color the power bar by class instead of power type. Note: only colors if the unit is a player."],
				get = getColorByClass,
				set = setColorByClass,
				passValue = group,
				disabled = getDisabled,
			},
			customColor = {
				name = L["Custom Color"],
				desc = L["Use custom colors for the power bars on this unit."],
				type = 'boolean',
				order = 1200,
				get = function(group) return PitBull_PowerBar.db.profile[group].customColor end,
				set = function(group, value)
					PitBull_PowerBar.db.profile[group].customColor = value
					PitBull_PowerBar:UpdatePowerValueAndColor(group)
				end,
				passValue = group,
				disabled = getDisabled,
			},
			customColors = {
				name = L["Power Colors"],
				desc = L["Custom power bar colors."],
				type = 'group',
				order = 1201,
				disabled = function(group) return getDisabled(group) or not PitBull_PowerBar.db.profile[group].customColor end,
				passValue = group,
				args = {
					rage = {
						passValue = group,
						passValue2 = "rage",
						get = getColor,
						set = setColor,
						name = L["Rage"],
						desc = L["Rage"],
						type = 'color'
					},
					mana = {
						passValue = group,
						passValue2 = "mana",
						get = getColor,
						set = setColor,
						name = L["Mana"],
						desc = L["Mana"],
						type = 'color'
					},
					focus = {
						passValue = group,
						passValue2 = "focus",
						get = getColor,
						set = setColor,
						name = L["Focus(Pet)"],
						desc = L["Focus(Pet)"],
						type = 'color'
					},
					energy = {
						passValue = group,
						passValue2 = "energy",
						get = getColor,
						set = setColor,
						name = L["Energy"],
						desc = L["Energy"],
						type = 'color'
					},
				},
			},
			customBGColor = {
				name = L["Custom background color"],
				desc = L["Override dynamic background color calculation."],
				type = 'boolean',
				order = 1202,
				get = function(group) return PitBull_PowerBar.db.profile[group].customBGColor end,
				set = function(group, value)
					PitBull_PowerBar.db.profile[group].customBGColor = value
					PitBull_PowerBar:UpdatePowerValueAndColor(group)
				end,
				disabled = getDisabled,
				passValue = group
			},
			customBGColors = {
				name = L["Power background colors"],
				desc = L["Custom power bar background colors."],
				type = 'group',
				order = 1203,
				disabled = function(group) return getDisabled(group) or not PitBull_PowerBar.db.profile[group].customBGColor end,
				passValue = group,
				args = {
					rageBG = {
						passValue = group,
						passValue2 = "rageBG",
						get = getColor,
						set = setColor,
						name = L["Rage Background"],
						desc = L["Rage Background"],
						type = 'color'
					},
					manaBG = {
						passValue = group,
						passValue2 = "manaBG",
						get = getColor,
						set = setColor,
						name = L["Mana Background"],
						desc = L["Mana Background"],
						type = 'color'
					},
					focusBG = {
						passValue = group,
						passValue2 = "focusBG",
						get = getColor,
						set = setColor,
						name = L["Focus Background"],
						desc = L["Focus Background"],
						type = 'color'
					},
					energyBG = {
						passValue = group,
						passValue2 = "energyBG",
						get = getColor,
						set = setColor,
						name = L["Energy Background"],
						desc = L["Energy Background"],
						type = 'color'
					},
				},
			},
		}
	}
end)

