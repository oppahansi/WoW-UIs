if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass("player")) ~= "DRUID" then
	return
end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_DruidManaBar = PitBull:NewModule("DruidManaBar", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_DruidManaBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a mana bar for your Druid when in Cat or Bear form."] = "드루이드가 표범 혹은 곰 변신 상태일 때를 위한 마나 바를 보여줍니다.",
	["Druid mana"] = "드루이드 마나",
	["Druid mana bar"] = "드루이드 마나 바",
	["Druid mana display settings for this unit type."] = "이 유닛 유형을 위한 드루이드 마나 표시 설정입니다.",
	["Enable"] = "활성화",
	["Enables the druid mana bar."] = "드루이드 마나 바를 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show a mana bar for your Druid when in Cat or Bear form."] = "当你的德鲁伊在猎豹或者熊形态下时显示一条法力条。",
	["Druid mana"] = "德鲁伊法力",
	["Druid mana bar"] = "德鲁伊法力监视条",
	["Druid mana display settings for this unit type."] = "为该单位类型设置德鲁伊法力条。",
	["Enable"] = "启用",
	["Enables the druid mana bar."] = "启用德鲁伊法力监视条。",
} or (GetLocale() == "zhTW") and {
	["Show a mana bar for your Druid when in Cat or Bear form."] = "當德魯伊在獵豹或者熊形態時顯示法力條.",
	["Druid mana"] = "德魯伊法力值",
	["Druid mana bar"] = "德魯伊法力條",
	["Druid mana display settings for this unit type."] = "此單位框架的德魯伊法力條設置.",
	["Enable"] = "啟用",
	["Enables the druid mana bar."] = "啟用德魯伊法力條.",
} or {}

local L = PitBull:L("PitBull-DruidManaBar", localization)

self.desc = L["Show a mana bar for your Druid when in Cat or Bear form."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local UnitPowerType = UnitPowerType

PitBull_DruidManaBar:RegisterPitBullModuleDependencies("PowerBar")
PitBull_DruidManaBar:RegisterPitBullChildFrames('druidManaBar')
PitBull_DruidManaBar:RegisterPitBullBarLayoutHandler("druidManaBar", L["Druid mana bar"], L["Druid mana"])

local unitsShown = {}

local LibDruidMana

function PitBull_DruidManaBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("DruidManaBar")
	PitBull:SetDatabaseNamespaceDefaults("DruidManaBar", "profile", {
		hidden = false,
	})
end

function PitBull_DruidManaBar:OnEnable(first)
	LibDruidMana = Rock("LibDruidMana-1.0", false, true)
	if not LibDruidMana then
		error("PitBull_DruidManaBar requires LibDruidMana-1.0 to be available.")
	end
	self:AddEventListener("UNIT_DISPLAYPOWER")
	if first then
		LibDruidMana:AddListener(function(currMana, maxMana)
			if self:IsActive() then
				self:Update(nil, currMana, maxMana)
			end
		end)
	end
end

function PitBull_DruidManaBar:UNIT_DISPLAYPOWER(ns, event, arg1)
	if arg1 ~= "player" then
		return
	end
	if UnitPowerType("player") ~= 0 then
		for frame in PitBull:IterateUnitFramesForUnit("player") do
			if not frame.druidManaBar then
				self:OnPopulateUnitFrame("player", frame)
				if frame.druidManaBar then
					PitBull:UpdateLayout(frame)
				end
			end
		end
	else	
		for frame in PitBull:IterateUnitFramesForUnit("player") do
			if frame.druidManaBar then
				self:OnClearUnitFrame("player", frame)
				PitBull:UpdateLayout(frame)
			end
		end
	end
end

function PitBull_DruidManaBar:UpdateColor(frame)
	if not frame then
		for frame in PitBull:IterateUnitFramesForUnit("player") do
			self:UpdateColor(frame)
		end
		return
	end
	
	local r,g,b = unpack(PitBull.colorConstants.mana)
	
	frame.druidManaBar:SetColor(r, g, b)
end

function PitBull_DruidManaBar:Update(frame, currMana, maxMana)
	if not frame then
		for frame in PitBull:IterateUnitFramesForUnit("player") do
			if frame.druidManaBar then
				self:Update(frame, currMana, maxMana)
			end
		end
		return
	end
	
	local db = self.db.profile
	
	if maxMana ~= 0 then
		local perc = currMana / maxMana
		frame.druidManaBar:SetValue(perc)
	end
end

function PitBull_DruidManaBar:OnUpdateFrame(unit, frame)
	if frame.druidManaBar then
		self:Update(frame, LibDruidMana:GetCurrentMana(), LibDruidMana:GetMaximumMana())
		self:UpdateColor(frame)
	end
end

function PitBull_DruidManaBar:OnPopulateUnitFrame(unit, frame)
	if unit ~= "player" or frame.druidManaBar or PitBull_DruidManaBar.db.profile.hidden or UnitPowerType("player") == 0 then
		return
	end
	local druidManaBar = newFrame("FakeStatusBar", frame)
	frame.druidManaBar = druidManaBar
	druidManaBar:SetTexture(PitBull:GetStatusBarTexture())
	druidManaBar:SetColor(0, 0, 1, 1)

	self:UpdateColor(frame)
end

function PitBull_DruidManaBar:OnClearUnitFrame(unit, frame)
	if frame.druidManaBar then
		frame.druidManaBar = delFrame(frame.druidManaBar)
	end
end

function PitBull_DruidManaBar:OnUpdateStatusBarTexture(texture)
	for _,frame in PitBull:IterateUnitFrames() do
		if frame.druidManaBar then
			frame.druidManaBar:SetTexture(texture)
		end
	end
end

function PitBull_DruidManaBar:OnUpdateLayout(unit, frame)
	local old = not unitsShown[frame]
	local now = not frame.druidManaBar or not frame.druidManaBar:IsShown()
	if old == now then
		return
	end
	unitsShown[frame] = not now
	if not now then
		self:OnUpdateFrame(unit, frame)
	end
end

local function getHide()
	return PitBull_DruidManaBar.db.profile.hidden
end
local function getEnabled()
	return not PitBull_DruidManaBar.db.profile.hidden
end
local function setEnabled(value)
	value = not value
	PitBull_DruidManaBar.db.profile.hidden = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if value then
			self:OnClearUnitFrame("player", frame)
		else
			self:OnPopulateUnitFrame("player", frame)
			self:OnUpdateFrame("player", frame)
		end
		PitBull:UpdateLayout(frame)
	end
end
PitBull_DruidManaBar:RegisterPitBullOptionsMethod(function(group)
	if group == "player" then
		return {
			name = L["Druid mana"],
			desc = L["Druid mana display settings for this unit type."],
			type = 'group',
			args = {
				hide = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enables the druid mana bar."],
					get = getEnabled,
					set = setEnabled,
					order = 1,
				},
			}
		}
	end
end)
