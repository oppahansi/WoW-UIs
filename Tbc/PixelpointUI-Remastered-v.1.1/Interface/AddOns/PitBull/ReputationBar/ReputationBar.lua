if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_ReputationBar = PitBull:NewModule("ReputationBar", "LibRockHook-1.0")
local self = PitBull_ReputationBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an reputation bar on the unit frame."] = "유닛 프레임에 평판 바를 보여줍니다.",
	["Reputation"] = "평판",
	["Reputation bar"] = "평판 바",
	["Options for the units reputation bar."] = "유닛의 평판 바를 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enable the reputation bar."] = "평판 바를 활성화합니다.",
	["Auto hide"] = "자동 숨김",
	["Hide the reputation bar when no faction is selected."] = "진영이 선택되지 않은 경우에 평판 바를 숨깁니다.",
	["Custom color"] = "사용자 색상",
	["Set a custom color for the reputation bar."] = "평판 바를 위한 사용자 색상을 설정합니다.",
	["Enable using a custom color for the reputation bar."] = "평판 바를 위한 사용자 색상의 사용을 활성화합니다.",
	["Color"] = "색상",
	["Set the custom color for the reputation bar."] = "평판 바를 위한 사용자 색상을 설정합니다.",
	["Custom background color"] = "사용자 배경 색상",
	["Set a custom background color for the reputation bar."] = "평판 바를 위한 사용자 배경 색상을 설정합니다.",
	["Enable using a custom background color for the reputation bar."] = "평판 바를 위한 사용자 배경 색상의 사용을 활성화합니다.",
	["Set the custom background color for the reputation bar."] = "평판 바를 위한 사용자 배경 색상을 설정합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an reputation bar on the unit frame."] = "在单位框体上显示一个声望条。",
	["Reputation"] = "声望",
	["Reputation bar"] = "声望条",
	["Options for the units reputation bar."] = "单位声望条的选项。",
	["Enable"] = "启用",
	["Enable the reputation bar."] = "启用声望条显示。",
	["Auto hide"] = "自动隐藏",
	["Hide the reputation bar when no faction is selected."] = "当没有选择声望时自动隐藏声望条的显示。",
	["Custom color"] = "自定义颜色",
	["Set a custom color for the reputation bar."] = "设置声望条的颜色。",
	["Enable using a custom color for the reputation bar."] = "启用声望条自定义颜色。",
	["Color"] = "颜色",
	["Set the custom color for the reputation bar."] = "设置声望条的颜色。",
	["Custom background color"] = "自定义背景色",
	["Set a custom background color for the reputation bar."] = "设置声望条背景的颜色。",
	["Enable using a custom background color for the reputation bar."] = "启用设置声望条背景的颜色。",
	["Set the custom background color for the reputation bar."] = "设置声望条背景的颜色。",
} or (GetLocale() == "frFR") and {
	["Show an reputation bar on the unit frame."] = "Affiche une barre de réputation sur la fenêtre d'unité.",
	["Reputation"] = "Réputation",
	["Reputation bar"] = "Barre de réputation",
	["Options for the units reputation bar."] = "Options pour la barre de réputation de l'unité.",
	["Enable"] = "Activer",
	["Enable the reputation bar."] = "Activer la barre de réputation.",
	["Auto hide"] = "Disparition automatique",
	["Hide the reputation bar when no faction is selected."] = "Cache la barre de réputation lorsqu'aucune factio n'est sélectionnée.",
	["Custom color"] = "Couleur personnalisée",
	["Set a custom color for the reputation bar."] = "Définit une couleur personnalisée pour la barre de réputation.",
	["Enable using a custom color for the reputation bar."] = "Active l'utilisation d'une couleur personnalisée pour la barre de réputation.",
	["Color"] = "Couleur",
	["Set the custom color for the reputation bar."] = "Définit la couleur personnalisée pour la barre de réputation.",
	["Custom background color"] = "Couleur d'arrière-plan personnalisée",
	["Set a custom background color for the reputation bar."] = "Définit une couleur d'arrière-plan personnalisée pour la barre de réputation.",
	["Enable using a custom background color for the reputation bar."] = "Active l'utilisation d'une couleur d'arrière-plan personnalisée pour la barre de réputation.",
	["Set the custom background color for the reputation bar."] = "Définit la couleur d'arrière-plan personnalisée pour la barre de réputation.",
} or (GetLocale() == "zhTW") and {
	["Show an reputation bar on the unit frame."] = "在單位框架上顯示聲望條.",
	["Reputation"] = "聲望",
	["Reputation bar"] = "聲望條",
	["Options for the units reputation bar."] = "此物件聲望條選項.",
	["Enable"] = "啟用",
	["Enable the reputation bar."] = "啟用聲望條.",
	["Auto hide"] = "自動隱藏",
	["Hide the reputation bar when no faction is selected."] = "當沒有陣營選中時隱藏聲望條.",
	["Custom color"] = "自定義顏色",
	["Set a custom color for the reputation bar."] = "聲望條使用自定義顏色.",
	["Enable using a custom color for the reputation bar."] = "啟用聲望條自定義顏色顯示.",
	["Color"] = "顏色",
	["Set the custom color for the reputation bar."] = "聲望條使用自定義顏色.",
	["Custom background color"] = "自定義背景顏色",
	["Set a custom background color for the reputation bar."] = "聲望條背景色使用自定義顏色.",
	["Enable using a custom background color for the reputation bar."] = "啟用聲望條背景色使用自定義顏色.",
	["Set the custom background color for the reputation bar."] = "聲望條背景色使用自定義顏色.",
} or {}

local L = PitBull:L("PitBull-ReputationBar", localization)

self.desc = L["Show an reputation bar on the unit frame."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local repColor = {
	[1] = {r = 226/255, g = 45/255, b = 75/255}, -- Hated
	[2] = {r = 226/255, g = 45/255, b = 75/255}, -- Hostile
	[3] = {r = 0.75, g = 0.27, b = 0}, -- unfriendly
	[4] = {r = 1, g = 1, b = 34/255}, -- neutral
	[5] = {r = 0.2, g = 0.8, b = 0.15}, -- friendly
	[6] = {r = 0.2, g = 0.8, b = 0.15}, -- honored
	[7] = {r = 0.2, g = 0.8, b = 0.15}, -- revered
	[8] = {r = 0.2, g = 0.8, b = 0.15}, -- exalted
}

PitBull_ReputationBar:RegisterPitBullChildFrames('repBar')
PitBull_ReputationBar:RegisterPitBullBarLayoutHandler("repBar", L["Reputation bar"], L["Reputation"])

function PitBull_ReputationBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("ReputationBar")
	PitBull:SetDatabaseNamespaceDefaults("ReputationBar", "profile", {
		ignore = true,
		autoHide = false,
		backgroundColor = { 1, 0, 0 },
		customColor = false,
		customColors = {1,1,1},
		customBGColor = false,
		customBGColors = {11/255, 11/255, 11/255},
	})
end

local repname, repreaction, repmin, repmax, repvalue = nil, 0, 0, 0, 0

function PitBull_ReputationBar:UpdateReputation(frame)
	if type(frame) ~= "table" then
		for frame in PitBull:IterateUnitFramesForUnit("player") do
			self:UpdateReputation(frame)
		end
		return
	end
	if self.db.profile.ignore then
		if frame.repBar then
			PitBull_ReputationBar:OnClearUnitFrame("player", frame)
			PitBull:UpdateLayout(frame)
		end
		return
	else
		if not frame.repBar then
			PitBull_ReputationBar:OnPopulateUnitFrame("player", frame)
			PitBull:UpdateLayout(frame)
		end
	end
	repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
	if repname then
		if not frame.repBar then
			self:OnPopulateUnitFrame("player", frame)
			PitBull:UpdateLayout(frame)
		end
		repmax = repmax - repmin
		repvalue = repvalue - repmin
		repmin = 0
		frame.repBar:SetValue(repvalue / (repmax - repmin))
		local color = repColor[repreaction]
		local r, g, b
		if self.db.profile.customColor then
			r, g, b = unpack(self.db.profile.customColors)
		else
			r, g, b = color.r, color.g, color.b
		end
		frame.repBar:SetColor(r, g, b, 1)
		local br, bg, bb
		if self.db.profile.customBGColor then
			frame.repBar:SetBackgroundColor(unpack(self.db.profile.customBGColors))
		else
			frame.repBar:SetBackgroundColor(nil, nil, nil)
		end
	else
		if self.db.profile.autoHide then
			if frame.repBar then
				PitBull_ReputationBar:OnClearUnitFrame("player", frame)
				PitBull:UpdateLayout(frame)
			end
		else
			if frame.repBar then
				self:OnPopulateUnitFrame("player", frame)
				PitBull:UpdateLayout(frame)
			end
			frame.repBar:SetBackgroundColor(unpack(self.db.profile.backgroundColor))
			frame.repBar:SetValue(0)
		end
	end
end

function PitBull_ReputationBar:OnEnable(first)
	if not self:HasHook("ReputationWatchBar_Update") then
		self:AddSecureHook("ReputationWatchBar_Update", "UpdateReputation")
	end
end

function PitBull_ReputationBar:OnUpdateFrame(unit, frame)
	if unit == "player" then
		self:UpdateReputation(frame)
	end
end

function PitBull_ReputationBar:OnPopulateUnitFrame(unit, frame)
	if frame.repBar or self.db.profile.ignore then
		return 
	end
	if unit == "player" then
		local repBar = newFrame("FakeStatusBar", frame)
		frame.repBar = repBar
		repBar:SetTexture(PitBull:GetStatusBarTexture())
		repBar:SetColor(0, 1, 0, 1)
	end
end

function PitBull_ReputationBar:OnClearUnitFrame(unit, frame)
	if frame.repBar then
		frame.repBar = delFrame(frame.repBar)
	end
end

function PitBull_ReputationBar:OnUpdateStatusBarTexture(texture)
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.repBar and frame.repBar.bg then
			frame.repBar:SetTexture(texture)
		end
	end
end

local function getDisabled()
	return self.db.profile.ignore
end

local function getEnabled()
	return not self.db.profile.ignore
end

local function setEnabled(value)
	self.db.profile.ignore = not value
	PitBull_ReputationBar:UpdateReputation()
end

local function getAutoHide()
	return self.db.profile.autoHide
end

local function setAutoHide(value)
	self.db.profile.autoHide = value
	PitBull_ReputationBar:UpdateReputation()
end

local function GetCustomColorToggle()
	return PitBull_ReputationBar.db.profile.customColor
end

local function SetCustomColorToggle(value)
	PitBull_ReputationBar.db.profile.customColor = value
	
	PitBull_ReputationBar:UpdateReputation()
end

local function GetCustomColor()
	return unpack(PitBull_ReputationBar.db.profile.customColors)
end

local function SetCustomColor(r, g, b)
	PitBull_ReputationBar.db.profile.customColors = {r, g, b}
	
	PitBull_ReputationBar:UpdateReputation()
end

local function GetCustomBGColorToggle()
	return PitBull_ReputationBar.db.profile.customBGColor
end

local function SetCustomBGColorToggle(value)
	PitBull_ReputationBar.db.profile.customBGColor = value
	
	PitBull_ReputationBar:UpdateReputation()
end

local function GetCustomBGColor()
	return unpack(PitBull_ReputationBar.db.profile.customBGColors)
end

local function SetCustomBGColor(r, g, b)
	PitBull_ReputationBar.db.profile.customBGColors = {r, g, b}
	
	PitBull_ReputationBar:UpdateReputation()
end

PitBull_ReputationBar:RegisterPitBullOptionsMethod(function(group)
	if group == "player" then 
		return {
			name = L["Reputation"],
			desc = L["Options for the units reputation bar."],
			type = 'group',
			args = {
				ignore = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enable the reputation bar."],
					get = getEnabled,
					set = setEnabled,
					order = 1,
				},
				autoHide = {
					type = 'boolean',
					name = L["Auto hide"],
					desc = L["Hide the reputation bar when no faction is selected."],
					get = getAutoHide,
					set = setAutoHide,
					disabled = getDisabled,
				},
				customColor = {
					type = 'group',
					name = L["Custom color"],
					desc = L["Set a custom color for the reputation bar."],
					disabled = getDisabled,
					args = {
						Enable = {
							type = 'boolean',
							name = L["Enable"],
							desc = L["Enable using a custom color for the reputation bar."],
							get = GetCustomColorToggle,
							set = SetCustomColorToggle,
						},
						setColor = {
							type = 'color',
							name = L["Color"],
							desc = L["Set the custom color for the reputation bar."],
							get = GetCustomColor,
							set = SetCustomColor,
							disabled = function() return not GetCustomColorToggle() end,
						},
					},
				},
				customBGColor = {
					type = 'group',
					name = L["Custom background color"],
					desc = L["Set a custom background color for the reputation bar."],
					disabled = getDisabled,
					args = {
						Enable = {
							type = 'boolean',
							name = L["Enable"],
							desc = L["Enable using a custom background color for the reputation bar."],
							get = GetCustomBGColorToggle,
							set = SetCustomBGColorToggle,
						},
						setColor = {
							type = 'color',
							name = L["Color"],
							desc = L["Set the custom background color for the reputation bar."],
							get = GetCustomBGColor,
							set = SetCustomBGColor,
							disabled = function() return not GetCustomBGColorToggle() end,
						},
					},
				},
			}
		}
	else
		return
	end
end)
