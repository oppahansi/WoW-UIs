-----------------------------------------------------------------------------
--
-- To add more presets, create your own files with their data table
-- And add them into Aloft's by using:
--   Aloft:GetModule("Presets"):AddPreset(presetName, presetDataTable)
--
-- The table contains keys which are module db namespaces, and the values
-- that they override from the default
--
-- Guideline list of interrelated variables:
--  healthText: enable, mode, format
--  guildText: enable, attachFormat, attachToName, useShort, showOwn, nameText.format
--  guildText: enable, attachToName, useShort, showOwn, format
--  levelText: enable, showRace, showClassification, showCreatureType, format
--
-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftPresets")
L:RegisterTranslations("enUS", function() return {
	["Presets"] = true,
	["Preset configurations"] = true,

	["Default"] = true,
	["Preset 1"] = true,
	["Preset 2"] = true,
	["Preset 3"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Presets"] = "프리셋",
	["Preset configurations"] = "프리셋 환경설정",

	["Default"] = "기본형",
	["Preset 1"] = "프리셋 1",
	["Preset 2"] = "프리셋 2",
	["Preset 3"] = "프리셋 3",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Presets"] = "預先設定",
	["Preset configurations"] = "預先設定",

	["Default"] = "預設",
	["Preset 1"] = "預先設定1",
	["Preset 2"] = "預先設定2",
	["Preset 3"] = "預先設定3",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Presets"] = "设置预案",
	["Preset configurations"] = "设置预案选项",

	["Default"] = "默认",
	["Preset 1"] = "设置预案1",
	["Preset 2"] = "设置预案2",
	["Preset 3"] = "设置预案3",
} end)

-----------------------------------------------------------------------------

-- it's only a module so that it can be obtained via Aloft:GetModule("Presets")
local AloftPresets = Aloft:NewModule("Presets")
local presetData = { }
local lastPreset = ""

-----------------------------------------------------------------------------

Aloft.Options.args.presets =
{
	type = 'text',
	name = L["Presets"],
	desc = L["Preset configurations"],
	order = 600,
	get = function() return lastPreset end,
	set = function(v) AloftPresets:Set(v) end,
	disabled = function() return not Aloft:IsActive() end,
	validate = { },
}

-----------------------------------------------------------------------------

function AloftPresets:AddPreset(name, data)
	presetData[name] = data
	Aloft.Options.args.presets.validate[name] = name
end

local function SetKeys(db, keys)
	for k,v in pairs(keys) do
		if type(v) == "table" then
			SetKeys(db[k], v)
		else
			db[k] = v
		end
	end
end

function AloftPresets:Set(presetName)
	lastPreset = presetName

	Aloft:ResetDB("profile")

	local data = presetData[presetName]
	for namespace, keys in pairs(data) do
		local db = Aloft:AcquireDBNamespace(namespace)
		if db then
			SetKeys(db.profile, keys)
		end
	end

	Aloft:OnProfileEnable()
end

-----------------------------------------------------------------------------

local preset1 =
{
	castBar =
	{
		texture			= "Otravi",
	},
	frame =
	{
		border		 	= "Blizzard Tooltip",
		height			= 12,
		packingHeight	= 17,
		backgroundAlpha	= 0.5,
	},
	guildText =
	{
		enable			= true,
	},
	healthBar =
	{
		texture			= "Otravi",
		offsetY			= -6,
	},
	healthText =
	{
		enable			= true,
		mode			= "SMART",
		format			= "[Select(IsFriendly, HealthDeficit:Negate:HideZero:Short:HexColor(\"ff8080\"), Select(Health, Health:Short, HealthFraction:Percent))]",
	},
	levelText =
	{
		offsetY				= 11,
		showCreatureType	= true,
		showClassification	= true,
		format				= "[Level][ShortCreatureType][ShortClassification]",
	},
	nameText =
	{
		offsets =
		{
			right		= -16,
			vertical	= 12,
		},
		format			= "[Name][ShortGuild:Prefix(\" - \")]",
	},
}

local preset2 =
{
	castBar =
	{
		texture			= "Smooth",
	},
	commentText =
	{
		enable			= true,
		shadow			= true,
		outline			= "OUTLINE",
		offsetY			= 0,
	},
	frame =
	{
		height			= 10,
		packingHeight	= 15,
		backgroundAlpha	= 0.5,
		backgroundColors =
		{
			friendlyPlayer	= { 0, 0, 0.8 },
			friendlyPet		= { 0, 0.4, 0 },
			friendlyNPC		= { 0, 0.4, 0 },
			friendlyBoss	= { 0, 0.4, 0 },
			hostilePlayer	= { 0.8, 0, 0 },
			hostilePet		= { 0.8, 0, 0 },
			hostileNPC		= { 0.8, 0, 0 },
			hostileBoss		= { 0.8, 0, 0 },
			neutral			= { 0.6, 0.6, 0 },
			pet				= { 0, 0.4, 0 },
			groupPet		= { 0, 0.4, 0 },
		},
	},
	guildText =
	{
		enable			= true,
	},
	healthBar =
	{
		texture			= "Smooth",
		offsetY			= -5,
	},
	healthText =
	{
		enable			= true,
		mode			= "SMART",
		format			= "[Select(IsFriendly, HealthDeficit:Negate:HideZero:Short:HexColor(\"ff8080\"), Select(Health, Health:Short, HealthFraction:Percent))]",
	},
	levelText =
	{
		offsetY				= 11,
		fontShadow			= true,
		outline				= "",
		shadow				= true,
		showCreatureType	= true,
		showClassification	= true,
		format				= "[Level][ShortCreatureType][ShortClassification]",
	},
	nameText =
	{
		outline			= "",
		shadow			= true,
		offsets =
		{
			right		= -16,
			vertical	= 11,
		},
		format			= "[Name][ShortGuild:Prefix(\" - \")]",
	},
}

local preset3 =
{
	castBar =
	{
		texture			= "Charcoal",
	},
	commentText =
	{
		enable			= true,
		shadow			= true,
		outline			= "OUTLINE",
		offsetY			= 0,
	},
	guildText =
	{
		enable			= true,
	},
	healthBar =
	{
		texture			= "Charcoal",
	},
	levelText =
	{
		enable			= false,
	},
	nameText =
	{
		outline			= "OUTLINE",
		shadow			= true,
		alignment		= "CENTER",
		offsets =
		{
			vertical	= 11,
		},
		format			= "[Name][ShortGuild:Prefix(\" - \")]",
	},
}

-----------------------------------------------------------------------------

AloftPresets:AddPreset(L["Default"], { })
AloftPresets:AddPreset(L["Preset 1"], preset1)
AloftPresets:AddPreset(L["Preset 2"], preset2)
AloftPresets:AddPreset(L["Preset 3"], preset3)

-----------------------------------------------------------------------------
