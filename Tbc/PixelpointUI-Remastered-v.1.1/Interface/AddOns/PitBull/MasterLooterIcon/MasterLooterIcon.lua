if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_MasterLooterIcon = PitBull:NewModule("MasterLooterIcon", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_MasterLooterIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an icon on the unit frame when the unit is the Master Looter."] = "유닛이 전리품 담당자인 경우에 유닛 프레임에 아이콘을 표시합니다.",
	["Master looter"] = "전리품 담당자",
	["Options for the master looter icon for this unit."] = "이 유닛에 대해 전리품 담당자 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the master looter icon, indicating who in your group is the master looter."] = "그룹에서 전리품 담당자임을 가리키는 전리품 담당자 아이콘을 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Show an icon on the unit frame when the unit is the Master Looter."] = "当单位是拾取分配者时在其单位框体上显示一个图标。",
	["Master looter"] = "拾取分配者",
	["Options for the master looter icon for this unit."] = "针对该单位的拾取分配者选项。",
	["Enable"] = "启用",
	["Enables the master looter icon, indicating who in your group is the master looter."] = "启用队长图标，指示谁是当前队伍或者团队的拾取分配者。",
} or (GetLocale() == "frFR") and {
	["Show an icon on the unit frame when the unit is the Master Looter."] = "Affiche une icône sur la fenêtre d'unité lorsque l'unité est le Maître de Butin.",
	["Master looter"] = "Maître de butin",
	["Options for the master looter icon for this unit."] = "Options d'icône de Maître de Butin pour cette unité.",
	["Enable"] = "Activer",
	["Enables the master looter icon, indicating who in your group is the master looter."] = "Active l'icône de Maître de Butin, indiquant est le Maître de butin dans le groupe.",
} or (GetLocale() == "zhTW") and {
	["Show an icon on the unit frame when the unit is the Master Looter."] = "當此單位是拾取分配者時顯示拾取圖示.",
	["Master looter"] = "拾取分配者",
	["Options for the master looter icon for this unit."] = "為此單位設定拾取分配者圖示的選項.",
	["Enable"] = "啟用",
	["Enables the master looter icon, indicating who in your group is the master looter."] = "啟用拾取分配者圖示,指出誰具有小隊或者團隊的拾取物品分配權.",
} or {}

local L = PitBull:L("PitBull-MasterLooterIcon", localization)

self.desc = L["Show an icon on the unit frame when the unit is the Master Looter."]

local new, del, newHash = PitBull.new, PitBull.del, PitBull.newHash
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_MasterLooterIcon:RegisterPitBullChildFrames('masterIcon')
PitBull_MasterLooterIcon:RegisterPitBullIconLayoutHandler('masterIcon', 2)

function PitBull_MasterLooterIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("MasterLooterIcon")
	PitBull:SetDatabaseNamespaceDefaults("MasterLooterIcon", "profile", {
		['*'] = {
			disable = false,
		},
	})
end

function PitBull_MasterLooterIcon:OnEnable()
	self:AddEventListener("PARTY_LOOT_METHOD_CHANGED")
	self:AddEventListener("PARTY_MEMBERS_CHANGED", "PARTY_LOOT_METHOD_CHANGED")
end

local configMode = PitBull.configMode

function PitBull_MasterLooterIcon:OnChangeConfigMode(value)
	configMode = value
	for unit, frame in PitBull:IterateUnitFrames() do
		self:Update(unit, frame)
	end
end
function PitBull_MasterLooterIcon:Update(unit, frame)
	if frame.group ~= "player" and frame.group ~= "party" and frame.group ~= "raid" then
		return
	end
	local has = false
	if unit == "player" then
		local _, lootmaster = GetLootMethod()
		if lootmaster == 0 then
			has = true
		end
	else
		local raid = unit:match("^raid(%d%d?)$")
		if raid then
			local lootMaster = select(11, GetRaidRosterInfo(tonumber(raid)))
			if lootMaster then
				has = true
			end
		else
			local _, lootmaster = GetLootMethod()
			if lootmaster and lootmaster > 0 then
				local party = unit:match("^party(%d)$")
				if party then
					if lootmaster == tonumber(party) then
						has = true
					end
				end
			end
		end
	end
	if configMode then
		has = true
	end
	if self.db.profile[frame.group].disable then
		has = false
	end

	if has then
		if not frame.masterIcon then
			local masterIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.masterIcon = masterIcon
			masterIcon:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter")
			masterIcon:SetTexCoord(0.15, 0.9, 0.15, 0.9)
			masterIcon:Hide()
			PitBull:UpdateLayout(frame)
		end
	else
		if frame.masterIcon then
			frame.masterIcon = delFrame(frame.masterIcon)
			
			PitBull:UpdateLayout(frame)
		end
	end
end

local function UpdateStuff(self)
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		self:Update(unit, frame)
	end
end

function PitBull_MasterLooterIcon:PARTY_LOOT_METHOD_CHANGED()
	self:AddTimer("PitBull_MasterLooterIcon-UpdateStuff", 0, UpdateStuff, self)
end

function PitBull_MasterLooterIcon:OnUpdateFrame(unit, frame)
	self:Update(unit, frame)
end

function PitBull_MasterLooterIcon:OnClearUnitFrame(unit, frame)
	if frame.masterIcon then
		frame.masterIcon = delFrame(frame.masterIcon)
	end
end

local function getEnable(group)
	return not PitBull_MasterLooterIcon.db.profile[group].disable
end
local function setEnable(group, value)
	PitBull_MasterLooterIcon.db.profile[group].disable = not value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_MasterLooterIcon:Update(unit, frame)
	end
end
PitBull_MasterLooterIcon:RegisterPitBullOptionsMethod(function(group)
	if group ~= "player" and group ~= "party" and group ~= "raid" then
		return
	end
	return {
		type = 'group',
		name = L["Master looter"],
		desc = L["Options for the master looter icon for this unit."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the master looter icon, indicating who in your group is the master looter."],
				get = getEnable,
				set = setEnable,
				passValue = group,
			}
		}
	}
end)
