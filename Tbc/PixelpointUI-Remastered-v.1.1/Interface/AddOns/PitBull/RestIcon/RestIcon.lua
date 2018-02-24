if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_RestIcon = PitBull:NewModule("RestIcon", "LibRockEvent-1.0")
local self = PitBull_RestIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an icon on the unit frame when the unit is resting in an inn or city."] = "유닛이 여관 혹은 대도시에서 휴식중인 경우에 유닛 프레임에 아이콘을 표시합니다.",
	["Resting"] = "휴식중",
	["Options for the resting icon."] = "휴식중 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the icon indicating whether or not the player is currently resting."] = "플레이어의 현재 휴식 여부를 가리키는 아이콘을 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an icon on the unit frame when the unit is resting in an inn or city."] = "当单位处于旅店或者主城时在其单位框体上显示一个图标。",
	["Resting"] = "休息状态",
	["Options for the resting icon."] = "休息状态图标的设置。",
	["Enable"] = "启用",
	["Enables the icon indicating whether or not the player is currently resting."] = "启用指示玩家是否正处于休息状态的图标。",
} or (GetLocale() == "frFR") and {
	["Show an icon on the unit frame when the unit is resting in an inn or city."] = "Afficher une icône sur la fenêtre d'unité lorsque celle-ci est au repos dans une auberge ou une ville.",
	["Resting"] = "Au repos",
	["Options for the resting icon."] = "Options pour l'icône de repos.",
	["Enable"] = "Activer",
	["Enables the icon indicating whether or not the player is currently resting."] = "Active l'icône indiquant si le joueur est actuellement au repos.",
} or (GetLocale() == "zhTW") and {
	["Show an icon on the unit frame when the unit is resting in an inn or city."] = "當玩家在旅館內或在城市裡時顯示休息圖示.",
	["Resting"] = "休息中",
	["Options for the resting icon."] = "休息圖示的選項.",
	["Enable"] = "啟用",
	["Enables the icon indicating whether or not the player is currently resting."] = "啟用顯示玩家是否在休息狀態的圖示.",
} or {}

local L = PitBull:L("PitBull-RestIcon", localization)

self.desc = L["Show an icon on the unit frame when the unit is resting in an inn or city."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_RestIcon:RegisterPitBullChildFrames('restIcon')
PitBull_RestIcon:RegisterPitBullIconLayoutHandler('restIcon', 4)

function PitBull_RestIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("RestIcon")
	PitBull:SetDatabaseNamespaceDefaults("RestIcon", "profile", {
		disable = false,
	})
end

function PitBull_RestIcon:OnEnable()
	self:AddEventListener("PLAYER_UPDATE_RESTING")
	self:AddEventListener("PLAYER_ENTERING_WORLD", "PLAYER_UPDATE_RESTING")
end

local configMode = PitBull.configMode

function PitBull_RestIcon:OnChangeConfigMode(value)
	configMode = value
	self:PLAYER_UPDATE_RESTING()
end

function PitBull_RestIcon:PLAYER_UPDATE_RESTING(ns, event, frame)
	if not frame then
		for frame in PitBull:IterateUnitFramesForUnit("player") do
			self:PLAYER_UPDATE_RESTING(ns, event, frame)
		end
		return
	end
	
	local resting = configMode or IsResting()
	if resting and not self.db.profile.disable then
		if not frame.restIcon then
			frame.restIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.restIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
			frame.restIcon:SetTexCoord(0.09, 0.43, 0.08, 0.42)
			frame.restIcon:Hide()
			PitBull:UpdateLayout(frame)
		end
	else
		if frame.restIcon then
			frame.restIcon = delFrame(frame.restIcon)
			
			PitBull:UpdateLayout(frame)
		end
	end
end

function PitBull_RestIcon:OnUpdateFrame(unit, frame)
	if unit == "player" then
		self:PLAYER_UPDATE_RESTING(ns, event, frame)
	end
end

function PitBull_RestIcon:OnClearUnitFrame(unit, frame)
	if frame.restIcon then
		frame.restIcon = delFrame(frame.restIcon)
	end
end

PitBull_RestIcon:RegisterPitBullOptionsMethod(function(group)
	if group ~= "player" then
		return
	end
	return {
		type = 'group',
		name = L["Resting"],
		desc = L["Options for the resting icon."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the icon indicating whether or not the player is currently resting."],
				get = function()
					return not self.db.profile.disable
				end,
				set = function(value)
					self.db.profile.disable = not value
					self:PLAYER_UPDATE_RESTING()
				end,
			}
		}
	}
end)
