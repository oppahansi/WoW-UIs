if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local _,playerClass = UnitClass("player")
if playerClass ~= "ROGUE" and playerClass ~= "DRUID" then
	return
end

local VERSION = tonumber(("$Revision: 68199 $"):match("%d+"))

local PitBull = PitBull
local PitBull_ComboPoints = PitBull:NewModule("ComboPoints", "LibRockEvent-1.0")
local self = PitBull_ComboPoints
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-05 21:15:48 -0400 (Sat, 05 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show combo points on the unit frame if you are a Rogue or Druid in Cat form."]= "도적 혹은 드루이드의 표범 변신 상태인 경우에 유닛 프레임에 콤보 포인트를 보여줍니다.",
	["Combo points"] = "연계 점수",
	["Options for the combo point display."] = "콤보 포인트 표시를 위한 옵션",
	["Enable"] = "활성화",
	["Enable combo point display."] = "연계 점수 표시 기능을 활성화합니다.",
	["Texture"] = "텍스쳐",
	["Set what texture to use for the combo points."] = "연계 점수에 사용할 텍스쳐를 설정합니다.",
	["Default"] = "기본",
	["Bar"] = "바",
} or (GetLocale() == "zhCN") and {
	["Show combo points on the unit frame if you are a Rogue or Druid in Cat form."]= "如果你是潜行者或者是德鲁伊的猎豹形态则在单位框体上显示连击点。",
	["Combo points"] = "连击点",
	["Options for the combo point display."] = "连击点的显示选项。",
	["Enable"] = "启用",
	["Enable combo point display."] = "启用连击点显示。",
	["Texture"] = "样式",
	["Set what texture to use for the combo points."] = "设置连击点的显示样式。",
	["Default"] = "默认",
	["Bar"] = "条状",
} or (GetLocale() == "frFR") and {
	["Show combo points on the unit frame if you are a Rogue or Druid in Cat form."]= "Affiche les points de combo sur la fenêtre d'unié si vous êtes un Voleur ou un Druide en forme de Chat.",
	["Combo points"] = "Points de combo",
	["Options for the combo point display."] = "Options d'affichage des points de combo.",
	["Enable"] = "Activer",
	["Enable combo point display."] = "Active l'affiche des points de combo.",
	["Texture"] = "Texture",
	["Set what texture to use for the combo points."] = "Définit quelle texture doit être utilisée pour les points de combo.",
	["Default"] = "Défaut",
	["Bar"] = "Barre",
} or (GetLocale() == "zhTW") and {
	["Show combo points on the unit frame if you are a Rogue or Druid in Cat form."] = "如果你的職業是盜賊或者德魯伊獵豹形態時,在單位框架上顯示連擊點.",
	["Combo points"] = "連擊點",
	["Options for the combo point display."] = "連擊點顯示選項.",
	["Enable"] = "啟用",
	["Enable combo point display."] = "啟用連擊點顯示",
	["Texture"] = "材質",
	["Set what texture to use for the combo points."] = "設定使用的連擊點材質.",
	["Default"] = "預設",
	["Bar"] = "條(Bar)",
} or {}

local L = PitBull:L("PitBull-ComboPoints", localization)

self.desc = L["Show combo points on the unit frame if you are a Rogue or Druid in Cat form."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local combo_path = "Interface\\AddOns\\" .. debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z]-%.lua") .. "\\combo"

PitBull_ComboPoints:RegisterPitBullChildFrames('comboPoints')

function PitBull_ComboPoints:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("ComboPoints")
	
	PitBull:SetDatabaseNamespaceDefaults("ComboPoints", "profile", {
		texture = "default",
	})
end

function PitBull_ComboPoints:OnEnable()
	self:AddEventListener("PLAYER_COMBO_POINTS")
end

local configMode = PitBull.configMode

function PitBull_ComboPoints:OnChangeConfigMode(value)
	configMode = value
	self:UpdateComboPoints()
end

function PitBull_ComboPoints:PLAYER_COMBO_POINTS()
	return self:UpdateComboPoints()
end

function PitBull_ComboPoints:UpdateComboPoints(frame)
	if not frame then
		for frame in PitBull:IterateUnitFramesForUnit("target") do
			self:UpdateComboPoints(frame)
		end
		return
	end
	if frame.comboPoints then
		local p = configMode and 5 or GetComboPoints()
		for i = 1, 5 do
			if p >= i then
				frame.comboPoints["combo"..i]:Show()
			else
				frame.comboPoints["combo"..i]:Hide()
			end
		end
		frame.comboPoints:Show()
	end
end

function PitBull_ComboPoints:OnUpdateFrame(unit, frame)
	if unit == "target" then
		self:UpdateComboPoints(frame)
	end
end

function PitBull_ComboPoints:OnPopulateUnitFrame(unit, frame)
	if not self.db.profile.ignore and unit == "target" then
		local comboPoints = newFrame("Frame", frame.overlay, "OVERLAY")
		frame.comboPoints = comboPoints
		for i = 1, 5 do
			local combo = newFrame("Texture", frame.comboPoints, "OVERLAY")
			comboPoints["combo"..i] = combo
			if self.db.profile.texture == "default" then
				combo:SetTexture(combo_path)
				combo:SetWidth(10)
				combo:SetHeight(10)
			else
				combo:SetTexture(PitBull:GetStatusBarTexture())
				combo:SetWidth(5)
				combo:SetHeight(8)
			end
		end
	end
end

function PitBull_ComboPoints:OnClearUnitFrame(unit, frame)
	if frame.comboPoints then
		for i = 1, 5 do
			frame.comboPoints["combo"..i] = delFrame( frame.comboPoints["combo"..i] )
		end
		frame.comboPoints = delFrame(frame.comboPoints)
	end
end

function PitBull_ComboPoints:OnUnknownLayout(unit, frame, combo)
	if frame.comboPoints and combo == "comboPoints" then
		frame.comboPoints:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 0)
		frame.comboPoints:SetWidth( 50 )
		frame.comboPoints:SetHeight( 10 )
		for i = 1, 5 do
			local combo = frame.comboPoints["combo"..i]
			combo:ClearAllPoints()
			if i == 1 then
				combo:SetPoint("RIGHT", frame.comboPoints, "RIGHT")
			else
				combo:SetPoint("RIGHT", frame.comboPoints["combo"..(i-1)], "LEFT")
			end			
		end
	end
end

local function comboTexture_get()
	return self.db.profile.texture
end
local function comboTexture_set(value)
	self.db.profile.texture = value
	for unit, frame in PitBull:IterateUnitFramesByGroup("target") do
		if frame.comboPoints then
			for i = 1, 5 do
				local combo = frame.comboPoints["combo" .. i]
				if combo then
					if value == "default" then
						combo:SetTexture(combo_path)
						combo:SetWidth(10)
						combo:SetHeight(10)
					else
						combo:SetTexture(PitBull:GetStatusBarTexture())
						combo:SetWidth(5)
						combo:SetHeight(8)
					end
				end
			end
		end
		PitBull:UpdateLayout(frame)
	end
end

local function getDisabled(group)
	return self.db.profile.ignore
end
local function getEnabled(group)
	return not self.db.profile.ignore
end
local function setEnabled(group, value)
	value = not value
	self.db.profile.ignore = value
	if value then
		for unit, frame in PitBull:IterateUnitFramesByGroup("target") do
			self:OnClearUnitFrame(unit, frame)
		end
	else
		for unit, frame in PitBull:IterateUnitFramesByGroup("target") do
			if not frame.combatText then
				self:OnPopulateUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end
	end
end

PitBull_ComboPoints:RegisterPitBullOptionsMethod(function(group)
	if group == "target" then
		return {
			type = 'group',
			name = L["Combo points"],
			desc = L["Options for the combo point display."],
			args = {
				enable = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enable combo point display."],
					get = getEnabled,
					set = setEnabled,
					passValue = group,
					order = 1,
				},			
				texture = {
					name = L["Texture"],
					desc = L["Set what texture to use for the combo points."],
					type = 'choice',
					choices = {
						default = L["Default"],
						bar = L["Bar"],
					},
					get = comboTexture_get,
					set = comboTexture_set,
					disabled = getDisabled,
				}
			}
		}
	end
end)