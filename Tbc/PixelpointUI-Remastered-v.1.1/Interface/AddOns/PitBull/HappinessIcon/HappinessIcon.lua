if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass("player")) ~= "HUNTER" then
	return
end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_HappinessIcon = PitBull:NewModule("HappinessIcon", "LibRockEvent-1.0")
local self = PitBull_HappinessIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an icon on the pet frame to indicate its happiness."] = "소환수 프레임에 소환수의 만족도를 나타내기 위해 아이콘을 보여줍니다.",
	["Happiness"] = "만족도",
	["Options for the happiness icon."] = "만족도 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the pet happiness icon."] = "소환수의 만족도 아이콘을 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an icon on the pet frame to indicate its happiness."] = "在宠物框体上显示一个指示快乐度的图标。",
	["Happiness"] = "快乐度",
	["Options for the happiness icon."] = "快乐度图标的相关选项。",
	["Enable"] = "启用",
	["Enables the pet happiness icon."] = "启用宠物的快乐度图标。",
} or (GetLocale() == "frFR") and {
	["Show an icon on the pet frame to indicate its happiness."] = "Affiche une icône sur la fenêtre de familier indiquant son moral.",
	["Happiness"] = "Moral",
	["Options for the happiness icon."] = "Options d'icône de moral.",
	["Enable"] = "Activer",
	["Enables the pet happiness icon."] = "Active l'icône de moral du familier.",
} or (GetLocale() == "zhTW") and {
	["Show an icon on the pet frame to indicate its happiness."] = "顯示寵物快樂度的圖示於寵物框架上",
	["Happiness"] = "寵物快樂度",
	["Options for the happiness icon."] = "寵物快樂度圖示選項.",
	["Enable"] = "啟用",
	["Enables the pet happiness icon."] = "開啟寵物快樂度圖示.",
} or {}

local L = PitBull:L("PitBull-HappinessIcon", localization)

self.desc = L["Show an icon on the pet frame to indicate its happiness."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_HappinessIcon:RegisterPitBullChildFrames('happinessIcon')
PitBull_HappinessIcon:RegisterPitBullIconLayoutHandler('happinessIcon', 1.5)

function PitBull_HappinessIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("HappinessIcon")
	PitBull:SetDatabaseNamespaceDefaults("HappinessIcon", "profile", {
		disable = false,
	})
end

function PitBull_HappinessIcon:OnEnable()
	self:AddEventListener("UNIT_HAPPINESS")
end

local configMode = PitBull.configMode

function PitBull_HappinessIcon:OnChangeConfigMode(value)
	configMode = value
	self:UNIT_HAPPINESS()
end

function PitBull_HappinessIcon:UNIT_HAPPINESS(ns, event)
	if self.db.profile.disable then return end
	
	local happiness = GetPetHappiness()

	for frame in PitBull:IterateUnitFramesForUnit("pet") do
		if not happiness and not configMode then
			if frame.happinessIcon then
				frame.happinessIcon = delFrame(frame.happinessIcon)
				PitBull:UpdateLayout(frame)
			end
			return
		end

		if not frame.happinessIcon then
			frame.happinessIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.happinessIcon:SetTexture("Interface\\PetPaperDollFrame\\UI-PetHappiness")
			PitBull:UpdateLayout(frame)
		end
		
		if happiness == 1 then
			frame.happinessIcon:SetTexCoord(0.375, 0.5625, 0, 0.359375)
		elseif happiness == 2 then
			frame.happinessIcon:SetTexCoord(0.1875, 0.375, 0, 0.359375)
		elseif happiness == 3 then
			frame.happinessIcon:SetTexCoord(0, 0.1875, 0, 0.359375)
		elseif configMode then --nonexistent pets are happy!
			frame.happinessIcon:SetTexCoord(0, 0.1875, 0, 0.359375)
		end
	end
end

function PitBull_HappinessIcon:OnUpdateFrame(unit, frame)
	if unit == "pet" then
		self:UNIT_HAPPINESS()
	end
end

function PitBull_HappinessIcon:OnPopulateUnitFrame(unit, frame)
	if unit == "pet" then
		self:UNIT_HAPPINESS()
	end
end

function PitBull_HappinessIcon:OnClearUnitFrame(unit, frame)
	if frame.happinessIcon then
		frame.happinessIcon = delFrame(frame.happinessIcon)
	end
end

PitBull_HappinessIcon:RegisterPitBullOptionsMethod(function(group)
	if group ~= "pet" then
		return
	end
	return {
		type = 'group',
		name = L["Happiness"],
		desc = L["Options for the happiness icon."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the pet happiness icon."],
				get = function()
					return not self.db.profile.disable
				end,
				set = function(value)
					self.db.profile.disable = not value
					if value then
						self:UNIT_HAPPINESS()
					else
						for frame in PitBull:IterateUnitFramesForUnit("pet") do
							if frame.happinessIcon then
								frame.happinessIcon = delFrame(frame.happinessIcon)
								PitBull:UpdateLayout(frame)
							end
						end
					end
				end,
			}
		}
	}
end)
