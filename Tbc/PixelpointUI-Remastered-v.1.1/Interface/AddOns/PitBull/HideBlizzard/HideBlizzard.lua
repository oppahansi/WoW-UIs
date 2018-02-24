if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_HideBlizzard = PitBull:NewModule("HideBlizzard")
local self = PitBull_HideBlizzard
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Hide Blizzard frames that are no longer needed."] = "더 이상 필요하지 않는 블리자드 프레임을 숨깁니다.",
	["Hide Blizzard frames"] = "블리자드 프레임 숨김",
	["Toggles hiding frames provided by the default user interface.\n\nNote that it's not uncommon to have other addons that provide similar functionality, like hiding the cast bar."] = "기본 사용자 인터페이스에 의해 제공되는 프레임 숨김 기능을 전환합니다.\n\n시전 바 숨김 같은 유사한 기능을 제공하고 있는 다른 애드온에서도 갖고 있는 보기 드문 기능은 아니라는 것에 유의하십시오.",
	["Player"] = "플레이어",
	["Hides the standard player frame."] = "기본 플레이어 프레임을 숨깁니다.",
	["Party"] = "파티",
	["Hides the standard party frames."] = "기본 파티 프레임을 숨깁니다.",
	["Target"] = "대상",
	["Hides the standard target frame."] = "기본 대상 프레임을 숨깁니다.",
	["Cast bar"] = "시전바",
	["Hides the standard cast bar."] = "기본 시전바를 숨깁니다.",
	["Buffs/Debuffs"] = "버프/디버프",
	["Hides the standard buff/debuff frame in the top-right corner of the screen."] = "화면의 상단 우측 모서리에 있는 기본 버프/디버프 프레임을 숨깁니다.",
} or (GetLocale() == "zhCN") and { 
	["Hide Blizzard frames that are no longer needed."] = "隐藏不再需要的暴雪默认框体。",
	["Hide Blizzard frames"] = "隐藏暴雪框体",
	["Toggles hiding frames provided by the default user interface.\n\nNote that it's not uncommon to have other addons that provide similar functionality, like hiding the cast bar."] = "切换是否隐藏默认用户界面提供的框体。\n\n要注意有时别的插件也会提供类似的功能，例如隐藏施法计时条。",
	["Player"] = "玩家框体",
	["Hides the standard player frame."] = "隐藏默认的玩家框体。",
	["Party"] = "小队框体",
	["Hides the standard party frames."] = "隐藏默认的玩家框体。",
	["Target"] = "目标框体",
	["Hides the standard target frame."] = "隐藏默认的目标框体。",
	["Cast bar"] = "施法计时条",
	["Hides the standard cast bar."] = "隐藏默认的施法计时条。",
	["Buffs/Debuffs"] = "Buff和Debuff",
	["Hides the standard buff/debuff frame in the top-right corner of the screen."] = "隐藏位于屏幕右上角默认的Buff/Debuff框体。",
} or (GetLocale() == "frFR") and { 
	["Hide Blizzard frames that are no longer needed."] = "Cacher les fenêtres de Blizzard qui ne sont plus utiles.",
	["Hide Blizzard frames"] = "Cacher les fenêtres de Blizzard",
	["Toggles hiding frames provided by the default user interface.\n\nNote that it's not uncommon to have other addons that provide similar functionality, like hiding the cast bar."] = "Active / Désactive la suppression des fenêtres de l'interface par défaut.\n\nNotez qu'il n'est pas rare de posséder d'autres addons qui proposent une fonctionnalité similaire, comme cacher la barre de lancement de sort.",
	["Player"] = "Joueur",
	["Hides the standard player frame."] = "Cache la fenêtre standard de joueur.",
	["Party"] = "Groupe",
	["Hides the standard party frames."] = "Cache les fenêtres standard de groupe.",
	["Target"] = "Cible",
	["Hides the standard target frame."] = "Cache la fenêtre standard de cible.",
	["Cast bar"] = "Barre de lancement de sort",
	["Hides the standard cast bar."] = "Cache la barre de lancement de sort standard.",
	["Buffs/Debuffs"] = "Buff/DeBuff",
	["Hides the standard buff/debuff frame in the top-right corner of the screen."] = "Cache la fenêtre des buffs/debuffs dans le coin en haut à droite de l'écran.",
} or (GetLocale() == "zhTW") and { 
	["Hide Blizzard frames that are no longer needed."] = "隱藏不再需要的內建框架.",
	["Hide Blizzard frames"] = "隱藏內建框架",
	["Toggles hiding frames provided by the default user interface.\n\nNote that it's not uncommon to have other addons that provide similar functionality, like hiding the cast bar."] = "預設使用者介面下切換隱藏內建框架.\n\n注意! 其他插件也提供類似功能, 比如隱藏施法條.",
	["Player"] = "玩家",
	["Hides the standard player frame."] = "隱藏標準玩家框架.",
	["Party"] = "隊伍",
	["Hides the standard party frames."] = "隱藏標準隊伍框架.",
	["Target"] = "目標",
	["Hides the standard target frame."] = "隱藏標準目標框架.",
	["Cast bar"] = "施法條",
	["Hides the standard cast bar."] = "隱藏內建施法條.",
	["Buffs/Debuffs"] = "Buff/Debuff",
	["Hides the standard buff/debuff frame in the top-right corner of the screen."] = "隱藏螢幕右上角的buff/debuff框架.",
} or {}

local L = PitBull:L("PitBull-HideBlizzard", localization)

self.desc = L["Hide Blizzard frames that are no longer needed."]

local newList, del = Rock:GetRecyclingFunctions("PitBull", "newList", "del")
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local UnitIsUnit = UnitIsUnit

function PitBull_HideBlizzard:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("HideBlizzard")
	PitBull:SetDatabaseNamespaceDefaults("HideBlizzard", "profile", {
		player = true,
		party = true,
		target = true,
		castbar = true,
		aura = false,
	})

	PitBull:RegisterGlobalSetting("HideBlizzard", function() return "@cache", {
		type = 'group',
		order = 2,
		name = L["Hide Blizzard frames"],
		desc = L["Toggles hiding frames provided by the default user interface.\n\nNote that it's not uncommon to have other addons that provide similar functionality, like hiding the cast bar."],
		child_get = function(key)
			return self.db.profile[key]
		end,
		child_set = function(key, value)
			self.db.profile[key] = value
			self:UpdateBlizzardFrames()
		end,
		child_type = 'boolean',
		args = {
			player = {
				name = L["Player"],
				desc = L["Hides the standard player frame."],
				passValue = "player",
			},
			party = {
				name = L["Party"],
				desc = L["Hides the standard party frames."],
				passValue = "party",
			},
			target = {
				name = L["Target"],
				desc = L["Hides the standard target frame."],
				passValue = "target",
			},
			castbar = {
				name = L["Cast bar"],
				desc = L["Hides the standard cast bar."],
				passValue = "castbar",
			},
			aura = {
				name = L["Buffs/Debuffs"],
				desc = L["Hides the standard buff/debuff frame in the top-right corner of the screen."],
				passValue = "aura",
			}
		},
		hidden = function()
			return not PitBull:IsModuleActive(self)
		end,
	} end)
end

function PitBull_HideBlizzard:OnEnable(first)
	self:UpdateBlizzardFrames()
end

function PitBull_HideBlizzard:OnDisable()
	self:ShowBlizzardPlayerFrame()
	self:ShowBlizzardPartyFrames()
	self:ShowBlizzardTargetFrame()
	self:ShowBlizzardCastingBar()
	self:ShowBlizzardAuraFrame()
end

function PitBull_HideBlizzard:UpdateBlizzardFrames()
	if self.db.profile.player then
		self:HideBlizzardPlayerFrame()
	else
		self:ShowBlizzardPlayerFrame()
	end
	if self.db.profile.party then
		self:HideBlizzardPartyFrames()
	else
		self:ShowBlizzardPartyFrames()
	end
	if self.db.profile.target then
		self:HideBlizzardTargetFrame()
	else
		self:ShowBlizzardTargetFrame()
	end
	if self.db.profile.castbar then
		self:HideBlizzardCastingBar()
	else
		self:ShowBlizzardCastingBar()
	end
	if self.db.profile.aura then
		self:HideBlizzardAuraFrame()
	else
		self:ShowBlizzardAuraFrame()
	end
end

local playerFrameState = true

function PitBull_HideBlizzard:HideBlizzardPlayerFrame()
	if not playerFrameState then
		return
	end
	playerFrameState = false
	PlayerFrame:UnregisterAllEvents()
	PlayerFrameHealthBar:UnregisterAllEvents()
	PlayerFrameManaBar:UnregisterAllEvents()
	PlayerFrame:Hide()
end

function PitBull_HideBlizzard:ShowBlizzardPlayerFrame()
	if playerFrameState then
		return
	end
	playerFrameState = true
	PlayerFrame:RegisterEvent("UNIT_LEVEL")
	PlayerFrame:RegisterEvent("UNIT_COMBAT")
	PlayerFrame:RegisterEvent("UNIT_SPELLMISS")
	PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_MAXMANA")
	PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
	PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
	PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
	PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
	PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH")
	PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
	PlayerFrameManaBar:RegisterEvent("UNIT_MANA")
	PlayerFrameManaBar:RegisterEvent("UNIT_RAGE")
	PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS")
	PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY")
	PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
	PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:Show()
end

local partyFrameState = true

function PitBull_HideBlizzard:HideBlizzardPartyFrames()
	if not partyFrameState then
		return
	end
	partyFrameState = false
	for i = 1, 4 do
		local frame = _G["PartyMemberFrame"..i]
		frame:UnregisterAllEvents()
		frame:Hide()
		frame.Show = function() end
	end
	
	UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")
end

function PitBull_HideBlizzard:ShowBlizzardPartyFrames()
	if partyFrameState then
		return
	end
	partyFrameState = true
	for i = 1, 4 do
		local frame = _G["PartyMemberFrame"..i]
		frame.Show = nil
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		frame:RegisterEvent("PARTY_LEADER_CHANGED")
		frame:RegisterEvent("PARTY_MEMBER_ENABLE")
		frame:RegisterEvent("PARTY_MEMBER_DISABLE")
		frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
		frame:RegisterEvent("UNIT_PVP_UPDATE")
		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("UNIT_PET")
		frame:RegisterEvent("VARIABLES_LOADED")
		frame:RegisterEvent("UNIT_NAME_UPDATE")
		frame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		frame:RegisterEvent("UNIT_DISPLAYPOWER")

		UnitFrame_OnEvent("PARTY_MEMBERS_CHANGED")
		
		_G.this = frame
		PartyMemberFrame_UpdateMember()
	end
	
	UIParent:RegisterEvent("RAID_ROSTER_UPDATE")
end

local targetFrameState = true

function PitBull_HideBlizzard:HideBlizzardTargetFrame()
	if not targetFrameState then
		return
	end
	targetFrameState = false
	TargetFrame:UnregisterAllEvents()
	TargetFrame:Hide()

	ComboFrame:UnregisterAllEvents()
end

function PitBull_HideBlizzard:ShowBlizzardTargetFrame()
	if targetFrameState then
		return
	end
	targetFrameState = true
	TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
	TargetFrame:RegisterEvent("UNIT_HEALTH")
	TargetFrame:RegisterEvent("UNIT_LEVEL")
	TargetFrame:RegisterEvent("UNIT_FACTION")
	TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
	TargetFrame:RegisterEvent("UNIT_AURA")
	TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
	TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	if UnitExists("target") then
		TargetFrame:Show()
	end

	ComboFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
	ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
end

local castingBarState = true
function PitBull_HideBlizzard:HideBlizzardCastingBar()
	if not castingBarState then
		return
	end
	castingBarState = false
	CastingBarFrame:UnregisterAllEvents()
	PetCastingBarFrame:UnregisterAllEvents()
end

function PitBull_HideBlizzard:ShowBlizzardCastingBar()
	if castingBarState then
		return
	end
	castingBarState = true
	local t = newList(CastingBarFrame, PetCastingBarFrame)
	for i,v in ipairs(t) do
		v:RegisterEvent("UNIT_SPELLCAST_START")
		v:RegisterEvent("UNIT_SPELLCAST_STOP")
		v:RegisterEvent("UNIT_SPELLCAST_FAILED")
		v:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
		v:RegisterEvent("UNIT_SPELLCAST_DELAYED")
		v:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
		v:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
		v:RegisterEvent("PLAYER_ENTERING_WORLD")
	end
	t = del(t)
	
	PetCastingBarFrame:RegisterEvent("UNIT_PET")
end

local auraFrameState = true
function PitBull_HideBlizzard:HideBlizzardAuraFrame()
	if not auraFrameState then
		return
	end
	auraFrameState = false
	BuffFrame:Hide()
	TemporaryEnchantFrame:Hide()
	BuffFrame:UnregisterAllEvents()
end

function PitBull_HideBlizzard:ShowBlizzardAuraFrame()
	if auraFrameState then
		return
	end
	auraFrameState = true
	BuffFrame:Show()
	TemporaryEnchantFrame:Show()
	BuffFrame:RegisterEvent("PLAYER_AURAS_CHANGED")
	
	BuffFrame_Update()
end
