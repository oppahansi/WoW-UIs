if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_LeaderIcon = PitBull:NewModule("LeaderIcon", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_LeaderIcon
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show an icon on the unit frame when the unit is the group leader."] = "유닛이 그룹의 지휘자인 경우에 유닛 프레임에 아이콘을 보여줍니다.",
	["Leader"] = "지휘자",
	["Options for the leader icon for this unit."] = "이 유닛의 지휘자 아이콘을 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the leader icon, indicating who is the current group or raid leader."] = "현재 그룹 혹은 공격대 지휘자를 가리키는 지휘자 아이콘을 활성화합니다.",
} or (GetLocale() == "zhCN") and { 
	["Show an icon on the unit frame when the unit is the group leader."] = "当单位是队长时在其单位框体上显示一个图标。",
	["Leader"] = "队长",
	["Options for the leader icon for this unit."] = "针对该单位的队长图标选项。",
	["Enable"] = "启用",
	["Enables the leader icon, indicating who is the current group or raid leader."] = "启用队长图标，指示谁是当前队伍或者团队的队长。",
} or (GetLocale() == "frFR") and { 
	["Show an icon on the unit frame when the unit is the group leader."] = "Affiche une icône sur la fenêtre d'unité lorsque l'unité est le chef de groupe.",
	["Leader"] = "Chef de groupe",
	["Options for the leader icon for this unit."] = "Options pour l'icône de chef de groupe de cette unité.",
	["Enable"] = "Activer",
	["Enables the leader icon, indicating who is the current group or raid leader."] = "Active l'icône de chef de groupe, indiquant qui est le chef de groupe ou de raid actuel.",
} or (GetLocale() == "zhTW") and {
	["Show an icon on the unit frame when the unit is the group leader."] = "當此單位為團隊領隊時顯示隊長圖示.",
	["Leader"] = "隊長圖示",
	["Options for the leader icon for this unit."] = "為這個單位設置隊長圖示選項.",
	["Enable"] = "啟用",
	["Enables the leader icon, indicating who is the current group or raid leader."] = "啟用隊長圖示,指出誰是小隊或者團隊的指揮者.",
} or {}

local L = PitBull:L("PitBull-LeaderIcon", localization)

self.desc = L["Show an icon on the unit frame when the unit is the group leader."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_LeaderIcon:RegisterPitBullChildFrames('leaderIcon')
PitBull_LeaderIcon:RegisterPitBullIconLayoutHandler('leaderIcon', 1)

function PitBull_LeaderIcon:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("LeaderIcon")
	PitBull:SetDatabaseNamespaceDefaults("LeaderIcon", "profile", {
		['*'] = {
			disable = false,
		},
	})
end

function PitBull_LeaderIcon:OnEnable()
	self:AddEventListener("PARTY_LEADER_CHANGED")
	self:AddEventListener("PARTY_MEMBERS_CHANGED", "PARTY_LEADER_CHANGED")
end

local configMode = PitBull.configMode

function PitBull_LeaderIcon:OnChangeConfigMode(value)
	configMode = value
	for unit, frame in PitBull:IterateUnitFrames() do
		self:Update(unit, frame)
	end
end

function PitBull_LeaderIcon:Update(unit, frame)
	if frame.group ~= "player" and frame.group ~= "party" and frame.group ~= "raid" then
		return
	end
	local has = true
	if unit == "player" then
		if not IsPartyLeader() then
			has = false
		end
	else
		local raid = unit:match("^raid(%d%d?)$")
		if raid then
			local _, rank = GetRaidRosterInfo(tonumber(raid))
			if rank ~= 2 then
				has = false
			end
		else
			local party = unit:match("^party(%d)$")
			if party then
				if GetPartyLeaderIndex() ~= tonumber(party) then
					has = false
				end
			else
				has = false
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
		if not frame.leaderIcon then
			local leaderIcon = newFrame("Texture", frame.overlay, "ARTWORK")
			frame.leaderIcon = leaderIcon
			leaderIcon:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
			leaderIcon:SetTexCoord(0.1, 0.84, 0.14, 0.88)
			leaderIcon:Hide()
			PitBull:UpdateLayout(frame)
		end
	else
		if frame.leaderIcon then
			frame.leaderIcon = delFrame(frame.leaderIcon)
			
			PitBull:UpdateLayout(frame)
		end
	end
end

local function UpdateStuff(self)
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		self:Update(unit, frame)
	end
end

function PitBull_LeaderIcon:PARTY_LEADER_CHANGED()
	self:AddTimer("PitBull_LeaderIcon-UpdateStuff", 0, UpdateStuff, self)
end

function PitBull_LeaderIcon:OnUpdateFrame(unit, frame)
	self:Update(unit, frame)
end

function PitBull_LeaderIcon:OnClearUnitFrame(unit, frame)
	if frame.leaderIcon then
		frame.leaderIcon = delFrame(frame.leaderIcon)
	end
end

local function getEnable(group)
	return not PitBull_LeaderIcon.db.profile[group].disable
end
local function setEnable(group, value)
	PitBull_LeaderIcon.db.profile[group].disable = not value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull_LeaderIcon:Update(unit, frame)
	end
end

PitBull_LeaderIcon:RegisterPitBullOptionsMethod(function(group)
	if group ~= "player" and group ~= "party" and group ~= "raid" then
		return
	end
	return {
		type = 'group',
		name = L["Leader"],
		desc = L["Options for the leader icon for this unit."],
		args = {
			toggle = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the leader icon, indicating who is the current group or raid leader."],
				get = getEnable,
				set = setEnable,
				passValue = group,
			}
		}
	}
end)
