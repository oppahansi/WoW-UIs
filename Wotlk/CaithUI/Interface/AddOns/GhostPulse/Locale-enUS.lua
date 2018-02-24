local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

L:RegisterTranslations("enUS", function() return {
	-- Core.lua
	["Console-Slash-Commands"] = { "/cdp" },
	["GUI-Slash-Commands"] = { "/gp", "/ghostpulse" },
	
	["Ghost: Pulse 2"] = true,
	["Pulses stuff on-screen."] = true,
	["You will need to reload the interface to reflect this change."] = true,
	
	["Locked"] = true,
	["Locks frames in place so they can't be moved around."] = true,
	
	["Allow Shared Frames"] = true,
	["Remove Shared Frames"] = true,
	
	["Use Shared Media"] = true,
	
	["Frames"] = true,
	["Create and configure frames to show alerts."] = true,
	
	["Skinning"] = true,
	["Texture"] = true,
	["<name of texture>"] = true,
	["Alpha"] = true,
	["Scale"] = true,
	["Default"] = true,
	
	["Reset to Defaults"] = true,
	
	["<name of thing>"] = true,
	["<template>"] = true,
	
	["Add"] = true,
	["Enter a name for the new frame."] = true,
	["<name of frame>"] = true,
	
	["Alerts"] = true,
	["Contains the options for the different alerts you can set up."] = true,
	["In-Combat Only"] = true,
	["While Mounted"] = true,
	["While Solo"] = true,
	["While Dead"] = true,
	["In Battlegrounds"] = true,
	["In Party"] = true,
	["In Raid"] = true,
	
	["Minimum Cooldown Time"] = true,
	["Maximum Cooldown Time"] = true,
	["Highlight Color"] = true,
	["Show Early Warnings"] = true,
	["Early Warning Time"] = true,
	["Early Warning Color"] = true,
	["Early Warning Text"] = true,
	["Alert Text"] = true,
	["Early Warning Sound"] = true,
	["Announce Alerts to Group"] = true,
	["Announce Warnings to Group"] = true,	
	["Early Warning Method"] = true,
	["<method>"] = true,
	["Floating Combat Text"] = true,
	["UIErrorsFrame"] = true,
	["MSBT"] = true,
	
	["None"] = true,
	
	["Specifics"] = true,
	["Contains options for configuring specific things."] = true,
	["Enter the name of the thing you want specific settings for."] = true,
	["Sound"] = true,
	["<name of sound>"] = true,
	["Limit"] = true,
	["Enter a numeric limit for %s"] = true,
	["<limit>"] = true,
	
	["'%s' added to the whitelist for alert '%s'."] = true,
	["'%s' removed from the whitelist for alert '%s'."] = true,
	["Showing the whitelist for alert '%s'..."] = true,
	["Whitelist cleared for alert '%s'."] = true,

	["'%s' added to the blacklist for alert '%s'."] = true,
	["'%s' removed from the blacklist for alert '%s'."] = true,
	["Showing the blacklist for alert '%s'..."] = true,
	["Blacklist cleared for alert '%s'."] = true,

	["Options for %s"] = true,
	["Keep"] = true,
	["Share Frame with Group"] = true,
	
	["Size"] = true,
	["Show Text"] = true,
	["Font Scale"] = true,

	["Fade-in Time"] = true,
	["Hold Time"] = true,
	["Fade-out Time"] = true,
	
	["Override Sound"] = true,
	["If specified, this sound will play for all alerts shown in this frame instead of the alert-specific sound.  The general 'Sounds' options can override this, however."] = true,

	["Whitelist"] = true,
	["'%s' added to the whitelist for frame '%s'."] = true,
	["'%s' removed from the whitelist for frame '%s'."] = true,
	["List"] = true,
	["Showing the whitelist for frame '%s'..."] = true,
	["*** Empty ***"] = true,
	["Clear"] = true,
	["Whitelist cleared for frame '%s'."] = true,
	
	["Blacklist"] = true,
	["'%s' added to the blacklist for frame '%s'."] = true,
	["'%s' removed from the blacklist for frame '%s'."] = true,
	["Showing the blacklist for frame '%s'..."] = true,
	["Blacklist cleared for frame '%s'."] = true,

	["Remove"] = true,
	["Removes the frame."] = true,

	-- Engine.lua
	["[Name] is ready soon"] = true,
	
	-- Events.lua
	["%s shared a frame with you."] = true,
	["%s tried to share a frame with you, but you are not allowing shared frames."] = true,
	
	-- AuraWatcher.lua
	["Player Buff Gains"] = true,
	["Player Buff Fades"] = true,
	["Player Debuff Gains"] = true,
	["Player Debuff Fades"] = true,
	
	-- BagsWatcher.lua
	["Bag Item Cooldowns"] = true,
	
	-- CCExpiryWatcher.lua
	["CC Expiry (Target)"] = true,
	["CC Expiry (Focus)"] = true,
	
	-- DecurseWatcher.lua
	["Decurse - Magic"] = true,
	["Decurse - Curse"] = true,
	["Decurse - Poison"] = true,
	["Decurse - Disease"] = true,
	
	-- EnemyCastWatcher.lua
	["Enemy Spell Casts (Target)"] = true,
	["Enemy Spell Casts (Focus)"] = true,
	["Enemy Spell Casts (Bosses)"] = true,
	
	-- LifeTapWatcher.lua
	["Bottled Nethergon Energy"] = true,
	["The Mechanar"] = true,
	["The Botanica"] = true,
	["The Arcatraz"] = true,
	["Tempest Keep"] = true,
	
	["Cenarion Mana Salve"] = true,
	["The Steamvault"] = true,
	["The Slave Pens"] = true,
	["Serpentshrine Cavern"] = true,
	["The Underbog"] = true,
	
	["Mana Potion Injector"] = true,
	["Super Mana Potion"] = true,
	["Mana Emerald"] = true,
	
	["Life Tap/Dark Pact"] = true,
	["Mana Potions/Gems"] = true,
	["Imp"] = true,
	["Dark Pact"] = true,
	["Life Tap"] = true,
	
	-- MobDebuffWatcher.lua
	["Crowd Control (Target)"] = true,
	["Crowd Control (Focus)"] = true,
	["Mob Debuffs (Target)"] = true,
	["Mob Debuffs (Focus)"] = true,
	
	["Hibernate"] = true,
	["Cyclone"] = true,
	["Polymorph"] = true,
	["Seduction"] = true,
	["Enslave Demon"] = true,
	["Howl of Terror"] = true,
	["Banish"] = true,
	["Fear"] = true,
	["Death Coil"] = true,
	["Turn Evil"] = true,
	["Freezing Trap"] = true,
	["Scatter Shot"] = true,
	["Scare Beast"] = true,
	["Sap"] = true,
	["Blind"] = true,
	["Shackle Undead"] = true,
	["Mind Control"] = true,

	-- ParryWatcher.lua
	["Riposte"] = true,
	["Overpower (Target)"] = true,
	["Overpower (Focus)"] = true,
	
	-- PetWatcher.lua
	["Pet Spell Cooldowns"] = true,
	
	-- PlayerDeathWatcher.lua
	["Player Deaths"] = true,
	["Player Resurrections"] = true,
	
	-- SpellWatcher.lua
	["Player Spell Cooldowns"] = true,
	["Player Spell Casts"] = true,
	["Player Spell Resists"] = true,
	["Player Spell Immunity"] = true,
	
	-- ThreatGenWatcher.lua
	["Threat Resists (Target)"] = true,
	["Threat Resists (Focus)"] = true,
	
	-- TrinkerWatcher.lua
	["Trinket Cooldowns"] = true,
	
} end)
