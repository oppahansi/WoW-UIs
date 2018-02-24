if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_ExperienceBar = PitBull:NewModule("ExperienceBar", "LibRockEvent-1.0")
local self = PitBull_ExperienceBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an experience bar on the unit frame."] = "유닛 프레임에 경험치 바를 보여줍니다.",
	["Experience"] = "경험치",
	["Experience bar"] = "경험치 바",
	["Set the colors for the experience bar."] = "경험치 바를 위한 색상을 설정합니다.",
	["Color"] = "색상",
	["Set the color for the experience bar."] = "경험치 바를 위한 색상을 설정합니다.",
	["Background color"] = "배경 색상",
	["Set the background color for the experience bar."] = "경험치 바를 위한 배경 색상을 설정합니다.",
	["Rest color"] = "휴식 색상",
	["Set the color for rested experience on the bar."] = "바에 휴식 경험치를 위한 색상을 설정합니다.",
	["Options for the units experience bar."] = "유닛의 경험치 바를 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enable the experience bar."] = "경험치 바를 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an experience bar on the unit frame."] = "在单位框体上显示一个经验条。",
	["Experience"] = "经验",
	["Experience bar"] = "经验条",
	["Set the colors for the experience bar."] = "设置经验条的颜色。",
	["Color"] = "颜色",
	["Set the color for the experience bar."] = "设置经验条的颜色。",
	["Background color"] = "背景颜色",
	["Set the background color for the experience bar."] = "设置经验条的背景颜色。",
	["Rest color"] = "双倍颜色",
	["Set the color for rested experience on the bar."] = "设置经验条上双倍经验部分的颜色。",
	["Options for the units experience bar."] = "单位经验条的选项。",
	["Enable"] = "启用",
	["Enable the experience bar."] = "启用经验条显示。",
} or (GetLocale() == "zhTW") and {
	["Show an experience bar on the unit frame."] = "在單位框架上顯示經驗條.",
	["Experience"] = "經驗",
	["Experience bar"] = "經驗條",
	["Set the colors for the experience bar."] = "設定經驗條的顏色.",
	["Color"] = "顏色",
	["Set the color for the experience bar."] = "設定經驗條的顏色.",
	["Background color"] = "背景色",
	["Set the background color for the experience bar."] = "設定經驗條的背景顏色.",
	["Rest color"] = "充份休息的顏色",
	["Set the color for rested experience on the bar."] = "設定經驗條上充份休息部分的顏色.",
	["Options for the units experience bar."] = "單位經驗條設置選項.",
	["Enable"] = "啟用",
	["Enable the experience bar."] = "啟用經驗條.",
} or {}

local L = PitBull:L("PitBull-ExperienceBar", localization)

self.desc = L["Show an experience bar on the unit frame."]

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

PitBull_ExperienceBar:RegisterPitBullChildFrames('expBar')
PitBull_ExperienceBar:RegisterPitBullBarLayoutHandler("expBar", L["Experience bar"], L["Experience"])

local showPet = select(2, UnitClass("player")) == "HUNTER"

function PitBull_ExperienceBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("ExperienceBar")
	PitBull:SetDatabaseNamespaceDefaults("ExperienceBar", "profile", {
		['**'] = {
			ignore = false,
		},
		player = {
			ignore = true,
		},
		colors = {0, 0, 1},
		restColors = {1, 0, 1},
		bgColors = {0, 0, 0},
	})
end

function PitBull_ExperienceBar:OnEnable(first)
	self:AddEventListener("PLAYER_XP_UPDATE")
	self:AddEventListener("UPDATE_EXHAUSTION", "PLAYER_XP_UPDATE")
	self:AddEventListener("PLAYER_LEVEL_UP", "PLAYER_XP_UPDATE")
end

function PitBull_ExperienceBar:PLAYER_XP_UPDATE()
	self:UpdateExperience("player")
	if showPet then
		self:UpdateExperience("pet")
	end
end

function PitBull_ExperienceBar:UpdateExperience(unit, frame)
	if not unit then
		self:PLAYER_XP_UPDATE()
		return
	end
	if not frame then
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			self:UpdateExperience(unit, frame)
		end
		return
	end
	
	if self.db.profile[unit].ignore or UnitLevel(unit) == MAX_PLAYER_LEVEL or (unit == "pet" and UnitLevel("pet") == UnitLevel("player")) then
		if frame.expBar then
			PitBull_ExperienceBar:OnClearUnitFrame(unit, frame)
			PitBull:UpdateLayout(frame)
		end
		return
	else
		if not frame.expBar then
			PitBull_ExperienceBar:OnPopulateUnitFrame(unit, frame)
			PitBull:UpdateLayout(frame)
		end
	end
	
	local current, max
	if unit == "player" then
		current, max = UnitXP(unit), UnitXPMax(unit)
	else
		current, max = GetPetExperience()
	end
	if max == 0 then
		current = 0
		max = 1
	end
	local rest = unit == "player" and GetXPExhaustion() or 0
	frame.expBar:SetValue(current / max)
	frame.expBar:SetExtraValue(rest / max)
	local r, g, b = unpack(self.db.profile.colors)
	local br, bg, bb = unpack(self.db.profile.bgColors)
	local rr, rg, rb = unpack(self.db.profile.restColors)
	frame.expBar:SetColor(r, g, b)
	frame.expBar:SetBackgroundColor(br, bg, bb)
	frame.expBar:SetExtraColor(rr, rg, rb)
end

function PitBull_ExperienceBar:OnUpdateFrame(unit, frame)
	if unit == "player" or (showPet and unit == "pet") then
		self:UpdateExperience(unit, frame)
	end
end

function PitBull_ExperienceBar:OnPopulateUnitFrame(unit, frame)
	if frame.expBar or self.db.profile[unit].ignore or UnitLevel(unit) == MAX_PLAYER_LEVEL then
		return 
	end
	if unit == "player" or (showPet and unit == "pet") then
		local expBar = newFrame("FakeStatusBar", frame)
		frame.expBar = expBar
		expBar:SetTexture(PitBull:GetStatusBarTexture())
		expBar:SetColor(0, 0, 1, 1)
	end
end

function PitBull_ExperienceBar:OnClearUnitFrame(unit, frame)
	if frame.expBar then
		frame.expBar = delFrame(frame.expBar)
	end
end

function PitBull_ExperienceBar:OnUpdateStatusBarTexture(texture)
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.expBar then
			frame.expBar:SetTexture(texture)
		end
	end
	if showPet then
		for frame in PitBull:IterateUnitFramesForUnit("pet") do
			if frame.expBar then
				frame.expBar:SetTexture(texture)
			end
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
	PitBull_ExperienceBar:UpdateExperience(group)
end

PitBull:RegisterGlobalSetting("colors", "args", "experiencebar", function() return "@cache", {
	type = 'group',
	name = L["Experience"],
	desc = L["Set the colors for the experience bar."],
	args = {
		bar = {
			type = 'color',
			name = L["Color"],
			desc = L["Set the color for the experience bar."],
			get = function()
				return unpack(PitBull_ExperienceBar.db.profile.colors)
			end,
			set = function(r, g, b)
				PitBull_ExperienceBar.db.profile.colors = {r, g, b}

				PitBull_ExperienceBar:UpdateExperience()
			end,
		},
		background = {
			type = 'color',
			name = L["Background color"],
			desc = L["Set the background color for the experience bar."],
			get = function()
				return unpack(PitBull_ExperienceBar.db.profile.bgColors)
			end,
			set = function(r, g, b)
				PitBull_ExperienceBar.db.profile.bgColors = {r, g, b}

				PitBull_ExperienceBar:UpdateExperience()
			end,
		},
		resting = {
			type = 'color',
			name = L["Rest color"],
			desc = L["Set the color for rested experience on the bar."],
			get = function()
				return unpack(PitBull_ExperienceBar.db.profile.restColors)
			end,
			set = function(r, g, b)
				PitBull_ExperienceBar.db.profile.restColors = {r, g, b}

				PitBull_ExperienceBar:UpdateExperience()
			end,
		},
	},
} end)

PitBull_ExperienceBar:RegisterPitBullOptionsMethod(function(group)
	if group == "player" or (showPet and group == "pet") then 
		return {
			name = L["Experience"],
			desc = L["Options for the units experience bar."],
			type = 'group',
			args = {
				ignore = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enable the experience bar."],
					get = getEnabled,
					set = setEnabled,
					passValue = group,
					order = 1,
				},
			}
		}
	end
end)

