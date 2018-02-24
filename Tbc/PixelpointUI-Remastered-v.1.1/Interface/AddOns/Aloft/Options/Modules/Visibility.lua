-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("Visibility") then return end
local AloftVisibility = Aloft:GetModule("Visibility")
local L = AceLibrary("AceLocale-2.2"):new("AloftVisibilityOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Visibility"] = true,
	["Extra visibility options"] = true,

	["Show Hostile Players"] = true,
	["Shows nameplates for hostile players"] = true,
	["Show Hostile Pets"] = true,
	["Shows nameplates for hostile pets"] = true,
	["Show Hostile NPCs"] = true,
	["Show hostile NPCs"] = true,

	["Friendly Players"] = true,
	["Selects which friendly players to show"] = true,
	["Show Pet"] = true,
	["Shows nameplates for your pets"] = true,
	["Show Group Pets"] = true,
	["Shows nameplates for group pets"] = true,
	["Show Friendly Pets"] = true,
	["Shows nameplates for friendly pets"] = true,
	["Show Friendly NPCs"] = true,
	["Show friendly NPCs"] = true,
	
	["Show Critters"] = true,
	["Shows nameplates for critters"] = true,

	["Show Neutral Units"] = true,
	["Show neutral units"] = true,

	["All"] = true,
	["Group Only"] = true,
	["Guild Only"] = true,
	["None"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Visibility"] = "표시",
	["Extra visibility options"] = "추가 표시 설정",

	["Show Hostile Players"] = "적대적 플레이어 표시",
	["Shows nameplates for hostile players"] = "적대적 플레이어의 이름표를 표시합니다.",
	["Show Hostile Pets"] = "적대적 소환수 표시",
	["Shows nameplates for hostile pets"] = "적대적 소환수의 이름표를 표시합니다.",
	["Show Hostile NPCs"] = "적대적 NPC 표시",
	["Show hostile NPCs"] = "적대적 NPC를 표시합니다.",

	["Friendly Players"] = "우호적 플레이어",
	["Selects which friendly players to show"] = "우호적 플레이어의 표시를 선택합니다.",
	["Show Pet"] = "소환수 표시",
	["Shows nameplates for your pets"] = "소환수의 이름표를 표시합니다.",
	["Show Group Pets"] = "파티 소환수 표시",
	["Shows nameplates for group pets"] = "파티 소환수의 이름표를 표시합니다.",
	["Show Friendly Pets"] = "우호적 소환수 표시",
	["Shows nameplates for friendly pets"] = "우호적 소환수의 이름표를 표시합니다.",
	["Show Friendly NPCs"] = "우호적 NPC 표시",
	["Show friendly NPCs"] = "우호적 NPC를 표시합니다.",

	["Show Critters"] = "동물 표시",
	["Shows nameplates for critters"] = "동물에 대한 이름표를 표시합니다.",

	["Show Neutral Units"] = "중립적 대상 표시",
	["Show neutral units"] = "중립적 대상을 표시합니다.",

	["All"] = "모두",
	["Group Only"] = "파티",
	["Guild Only"] = "길드",
	["None"] = "없음",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Visibility"] = "能見度",
	["Extra visibility options"] = "額外能見度選項",

	["Show Hostile Players"] = "顯示敵對玩家",
	["Shows nameplates for hostile players"] = "顯示敵對玩家的名牌",
	["Show Hostile Pets"] = "顯示敵對寵物",
	["Shows nameplates for hostile pets"] = "顯示敵對寵物的名牌",
	["Show Hostile NPCs"] = "顯示敵對NPC",
	["Show hostile NPCs"] = "顯示敵對NPC的名牌",

	["Friendly Players"] = "顯示友好玩家",
	["Selects which friendly players to show"] = "選擇顯示哪一些友好玩家",
	["Show Pet"] = "顯示寵物",
	["Shows nameplates for your pets"] = "顯示你的寵物的名牌",
	["Show Group Pets"] = "顯示團體寵物",
	["Shows nameplates for group pets"] = "顯示團體寵物的名牌",
	["Show Friendly Pets"] = "顯示友好寵物",
	["Shows nameplates for friendly pets"] = "顯示友好寵物的名牌",
	["Show Friendly NPCs"] = "顯示友好NPC",
	["Show friendly NPCs"] = "顯示友好NPC的名牌",
	
	["Show Critters"] = "顯示小動物",
	["Shows nameplates for critters"] = "顯示小動物的名牌",

	["Show Neutral Units"] = "顯示中立單位",
	["Show neutral units"] = "顯示中立單位的名牌",

	["All"] = "全部",
	["Group Only"] = "唯有團體",
	["Guild Only"] = "唯有公會",
	["None"] = "無",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Visibility"] = "能见度",
	["Extra visibility options"] = "额外能见度相关设置",

	["Show Hostile Players"] = "显示敌对方玩家",
	["Shows nameplates for hostile players"] = "显示敌对方玩家的姓名板",
	["Show Hostile Pets"] = "显示敌对方宠物",
	["Shows nameplates for hostile pets"] = "显示敌对方宠物的姓名板",
	["Show Hostile NPCs"] = "显示敌对方NPC",
	["Show hostile NPCs"] = "显示敌对方NPC的姓名板",

	["Friendly Players"] = "显示友好方玩家",
	["Selects which friendly players to show"] = "选择显示哪些友好方玩家",
	["Show Pet"] = "显示宠物",
	["Shows nameplates for your pets"] = "显示你的宠物的姓名板",
	["Show Group Pets"] = "显示队友宠物",
	["Shows nameplates for group pets"] = "显示队友的宠物的姓名板",
	["Show Friendly Pets"] = "显示友好方宠物",
	["Shows nameplates for friendly pets"] = "显示友好方宠物的姓名板",
	["Show Friendly NPCs"] = "显示友好方NPC",
	["Show friendly NPCs"] = "显示友好方NPC的姓名板",
	
	["Show Critters"] = "显示小动物",
	["Shows nameplates for critters"] = "显示小动物的姓名板",

	["Show Neutral Units"] = "显示中立方单位",
	["Show neutral units"] = "显示中立方单位的姓名板",

	["All"] = "全部",
	["Group Only"] = "仅显示队友",
	["Guild Only"] = "仅显示公会成员",
	["None"] = "无",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.visibility =
{
	type = 'group',
	name = L["Visibility"],
	desc = L["Extra visibility options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		friendlyPlayers =
		{
			type = 'text',
			name = L["Friendly Players"],
			desc = L["Selects which friendly players to show"],
			get = function() return AloftVisibility.db.profile.friendlyPlayers end,
			set = function(v) AloftVisibility.db.profile.friendlyPlayers = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			validate = { ["ALL"] = L["All"], ["GUILDONLY"] = L["Guild Only"], ["GROUPONLY"] = L["Group Only"], ["NONE"] = L["None"] },
			order = 1,
		},
		showPet =
		{
			type = 'toggle',
			name = L["Show Pet"],
			desc = L["Shows nameplates for your pets"],
			get = function() return AloftVisibility.db.profile.showPet end,
			set = function(v) AloftVisibility.db.profile.showPet = v AloftVisibility:Update() end,
			order = 2,
		},
		showGroupPets =
		{
			type = 'toggle',
			name = L["Show Group Pets"],
			desc = L["Shows nameplates for group pets"],
			get = function() return AloftVisibility.db.profile.showGroupPets end,
			set = function(v) AloftVisibility.db.profile.showGroupPets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 3,
		},
		showFriendlyPets =
		{
			type = 'toggle',
			name = L["Show Friendly Pets"],
			desc = L["Shows nameplates for friendly pets"],
			get = function() return AloftVisibility.db.profile.showFriendlyPets end,
			set = function(v) AloftVisibility.db.profile.showFriendlyPets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 4,
		},
		showFriendlyNPCs =
		{
			type = 'toggle',
			name = L["Show Friendly NPCs"],
			desc = L["Show friendly NPCs"],
			get = function() return AloftVisibility.db.profile.showFriendlyNPCs end,
			set = function(v) AloftVisibility.db.profile.showFriendlyNPCs= v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 5,
		},
		showHostilePlayers =
		{
			type = 'toggle',
			name = L["Show Hostile Players"],
			desc = L["Shows nameplates for hostile players"],
			get = function() return AloftVisibility.db.profile.showHostilePlayers end,
			set = function(v) AloftVisibility.db.profile.showHostilePlayers = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 6,
		},
		showHostilePets =
		{
			type = 'toggle',
			name = L["Show Hostile Pets"],
			desc = L["Shows nameplates for hostile pets"],
			get = function() return AloftVisibility.db.profile.showHostilePets  end,
			set = function(v) AloftVisibility.db.profile.showHostilePets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 7,
		},
		showHostileNPCs =
		{
			type = 'toggle',
			name = L["Show Hostile NPCs"],
			desc = L["Show hostile NPCs"],
			get = function() return AloftVisibility.db.profile.showHostileNPCs end,
			set = function(v) AloftVisibility.db.profile.showHostileNPCs = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 8,
		},
		showNeutralUnits =
		{
			type = 'toggle',
			name = L["Show Neutral Units"],
			desc = L["Show neutral units"],
			get = function() return AloftVisibility.db.profile.showNeutralUnits end,
			set = function(v) AloftVisibility.db.profile.showNeutralUnits = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 9,
		},
		showCritters =
		{
			type = 'toggle',
			name = L["Show Critters"],
			desc = L["Shows nameplates for critters"],
			disabled = function() return not AloftVisibility.db.profile.showNeutralUnits end,
			get = function() return AloftVisibility.db.profile.showCritters end,
			set = function(v) AloftVisibility.db.profile.showCritters = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 10
		},
	},
}

-----------------------------------------------------------------------------
