local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

L:RegisterTranslations("deDE", function() return {
	-- Core.lua
	["Console-Slash-Commands"] = { "/cdp" },
	["GUI-Slash-Commands"] = { "/gp", "/ghostpulse" },
	
	-- AE = \195\132
	-- OE = \195\150
	-- UE = \195\156
	-- ae = \195\164
	-- oe = \195\182
	-- ue = \195\188
	-- Eszett = \195\159
	
	["Ghost: Pulse 2"] = "Ghost: Pulse 2",
	["Pulses stuff on-screen."] = "Pulsiert alles M\195\182gliche auf dem Bildschirm.",
	["You will need to reload the interface to reflect this change."] = "Ben\195\182tigt ein /console reloadui um zu funktionieren.",
	
	["Locked"] = "Verriegelt",
	["Locks frames in place so they can't be moved around."] = "Verriegelt die Anzeige, so dass nichts verschoben werden kann.",
	
	["Allow Shared Frames"] = "Erlaube gemeinsam genutzte Frames",
	["Remove Shared Frames"] = "Entferne gemeinsam genutzte Frames",
	
	["Use Shared Media"] = "Benutze Shared Media",
	
	["Frames"] = "Frames",
	["Create and configure frames to show alerts."] = "Erstelle und konfiguriere Frames um Warnungen anzuzeigen",
	
	["Skinning"] = "Skinning",
	["Texture"] = "Textur",
	["<name of texture>"] = "<Name der Textur>",
	["Alpha"] = "Sichtbarkeits Level",
	["Scale"] = "Gr\195\182\195\159e",
	["Default"] = "Standard",
	
	["Reset to Defaults"] = "Auf Standard zur\195\188ckstellen",
	
	["<name of thing>"] = "<Name>",
	["<template>"] = "<Vorlage>",
	
	["Add"] = "Hinzuf\195\188gen",
	["Enter a name for the new frame."] = "Geben Sie einen Namen f\195\188r den neue Frame an",
	["<name of frame>"] = "<Name des Frames>",
	
	["Alerts"] = "Warnungen",
	["Contains the options for the different alerts you can set up."] = "Enth\195\164lt Optionen f\195\188r die verschiedenen Alarme die einegstellt werden k\195\182nnen.",
	["In-Combat Only"] = "Nur im Kampf",
	["While Mounted"] = "W\195\164hrend dem Reiten",
	["While Solo"] = "W\195\164hrend man alleine ist",
	["In Party"] = "In einer Gruppe",
	["In Raid"] = "Im Raid",
	
	["Minimum Cooldown Time"] = "Minimale Cooldown Zeit",
	["Maximum Cooldown Time"] = "Maximale Cooldown Zeit",
	["Highlight Color"] = "Hervorhebungs Farbe",
	["Show Early Warnings"] = "Zeige Vorwarnungen",
	["Early Warning Time"] = "Vorwarn Zeit",
	["Early Warning Color"] = "Vorwarn Farbe",
	["Early Warning Text"] = "Vorwarn Text",
	["Alert Text"] = "Warnungs Text",

	["Early Warning Sound"] = "Fr\195\188hwarn Sound",
	["Early Warning Method"] = "Fr\195\188hwarn Methode",
	["<method>"] = "<Methode>",
	["Floating Combat Text"] = "Kampftext",
	["UIErrorsFrame"] = "UIErrorsFrame",
	["MSBT"] = "MSBT",
	
	["None"] = "Nichts",
	
	["Specifics"] = "Besonderheiten",
	["Contains options for configuring specific things."] = "Enth\195\164lt Optionen um besondere Einstellungen vorzunehmen",
	["Enter the name of the thing you want specific settings for."] = "Geben Sie den Namen dessen ein wof\195\188r Sie besondere Einstellungen haben m\195\182chten",
	["Sound"] = "Sound",
	["<name of sound>"] = "<Name des Sound>",
	["Limit"] = "Limit",
	["Enter a numeric limit for %s"] = "Geben Sie ein Limit in Zahlen f\195\188r %s an",
	["<limit>"] = "<Limit>",
	
	["'%s' added to the whitelist for alert '%s'."] = "'%s' wurde der Whitelist als Alarm f\195\188r '%s' hinzugef\195\188gt",
	["'%s' removed from the whitelist for alert '%s'."] = "'%s' wurde von der Whitelist f\195\188r den Alarm '%s' entfernt",
	["Showing the whitelist for alert '%s'..."] = "Zeige die Whitelist f\195\188r Alarm '%s'...",
	["Whitelist cleared for alert '%s'."] = "Die Whitelist f\195\188r den Alarm '%s' wurde gel\195\182scht",

	["'%s' added to the blacklist for alert '%s'."] = "'%s' wurde der Blacklist f\195\188r '%s' hinzugef\195\188gt",
	["'%s' removed from the blacklist for alert '%s'."] = "'%s' wurde von der Blacklist f\195\188r den Alarm '%s' entfernt",
	["Showing the blacklist for alert '%s'..."] = "Zeige die Blacklist f\195\188r Alarm '%s'...",
	["Blacklist cleared for alert '%s'."] = "Die Blacklist f\195\188r den Alarm '%s' wurde gel\195\182scht",

	["Options for %s"] = "Optionen f\195\188r %s",
	["Keep"] = "Behalte",
	["Share Frame with Group"] = "Teile dieses Frame mit der Gruppe",
	
	["Size"] = "Gr\195\182\195\159e",
	["Show Text"] = "Zeige Text an",
	["Font Scale"] = "Schriftgr\195\182\195\159e",

	["Fade-in Time"] = "EInblende Zeit",
	["Hold Time"] = "Anzeige Zeit",
	["Fade-out Time"] = "Ausblende Zeit",
	
	["Override Sound"] = "\195\156berschreibe den Sound",
	["If specified, this sound will play for all alerts shown in this frame instead of the alert-specific sound.  The general 'Sounds' options can override this, however."] = "Dieser Sound wird f\195\188r alle Sounds dieses Frames genommen. Die Allgemeinen Sound Optionen k\195\182nnen dies jedoch \195\188berschreiben",

	["Whitelist"] = "Whitelist",
	["'%s' added to the whitelist for frame '%s'."] = "'%s' wurde der Whitelist f\195\188r Frame '%s' hinzugef\195\188gt.",
	["'%s' removed from the whitelist for frame '%s'."] = "'%s' wurde von der Whitelist f\195\188r Frame '%s' entfernt.",
	["List"] = "Liste",
	["Showing the whitelist for frame '%s'..."] = "Zeige die Whitelist f\195\188r Frame '%s'...",
	["*** Empty ***"] = "*** Leer ***",
	["Clear"] = "L\195\182sche",
	["Whitelist cleared for frame '%s'."] = "Whitelist f\195\188r Frame '%s' gel\195\182scht.",
	
	["Blacklist"] = "Blacklist",
	["'%s' added to the blacklist for frame '%s'."] = "%s' wurde der Blacklist f\195\188r Frame '%s' hinzugef\195\188gt.",
	["'%s' removed from the blacklist for frame '%s'."] = "'%s' wurde von der Blacklist f\195\188r Frame '%s' entfernt.",
	["Showing the blacklist for frame '%s'..."] = "Zeige die Blacklist f\195\188r Frame '%s'...",
	["Blacklist cleared for frame '%s'."] = "Blacklist f\195\188r Frame '%s' gel\195\182scht.",

	["Remove"] = "Entfernen",
	["Removes the frame."] = "Entfernt den Frame",

	-- Engine.lua
	["[Name] is ready soon"] = "[Name] ist bald bereit",
	
	-- Events.lua
	["%s shared a frame with you."] = "%s teilt einen Frame mit Dir",
	["%s tried to share a frame with you, but you are not allowing shared frames."] = "%s versuchte einen Frame mit Dir zu teilen jedoch l\195\164sst Du das teilen von Frames nicht zu",
	
	-- AuraWatcher.lua
	["Player Buff Gains"] = "Spieler erh\195\164lt St\195\164rkungszauber",
	["Player Buff Fades"] = "Spieler verliert St\195\164rkungszauber",
	["Player Debuff Gains"] = "Spieler erh\195\164lt Schw\195\164chungszauber",
	["Player Debuff Fades"] = "Spieler verliert Schw\195\164chungszauber",
	
	-- BagsWatcher.lua
	["Bag Item Cooldowns"] = "Cooldown von Gegenst\195\164nden in den Taschen",

	-- CCExpiryWatcher.lua
	["CC Expiry (Target)"] = "CC l\195\164uft aus (Ziel)",
	["CC Expiry (Focus)"] = "CC l\195\164uft aus (Fokus)",

	-- DecurseWatcher.lua
	["Decurse - Magic"] = "Entfluche - Magie",
	["Decurse - Curse"] = "Entfluche - Fluch",
	["Decurse - Poison"] = "Entfluche - Gift",
	["Decurse - Disease"] = "Entfluche - Krankheit",
	
	-- EnemyCastWatcher.lua
	["Enemy Spell Casts (Target)"] = "Gegner zaubert (Ziel)",
	["Enemy Spell Casts (Focus)"] = "Gegner zaubert (Fokus)",
	["Enemy Spell Casts (Bosses)"] = "Gegner zaubert (Bosse)",
	
	-- LifeTapWatcher.lua
	["Bottled Nethergon Energy"] = "Flasche mit Nethergonenergie",
	["The Mechanar"] = "Die Mechanar",
	["The Botanica"] = "Die Botanika",
	["The Arcatraz"] = "Die Arkatraz",
	["Tempest Keep"] = "Festung der St\195\188rme",
	
	["Cenarion Mana Salve"] = "Cenarische Manasalbe",
	["The Steamvault"] = "Die Dampfkammer",
	["The Slave Pens"] = "Die Sklavenunterk\195\188nfte",
	["Serpentshrine Cavern"] = "H\195\182hle des Schlangenschreins",
	["The Underbog"] = "Der Tiefensupmf",
	
	["Mana Potion Injector"] = "Manatrankeinspritzung",
	["Super Mana Potion"] = "Erstklassiger Manatrank",
	["Mana Emerald"] = "Manasmaragd",
	
	["Life Tap/Dark Pact"] = "Aderlass/Dunkler Pakt",
	["Mana Potions/Gems"] = "Mana Tr\195\164nke / Gems",
	["Imp"] = "Wichtel",
	["Dark Pact"] = "Dunkler Pakt",
	["Life Tap"] = "Aderlass",
	
	-- MobDebuffWatcher.lua
	["Crowd Control (Target)"] = "Crowd Control (Ziel)",
	["Crowd Control (Focus)"] = "Crowd Control (Fokus)",
	["Mob Debuffs (Target)"] = "Schw\195\164chungszauber auf Gegnern (Ziel)",
	["Mob Debuffs (Focus)"] = "Schw\195\164chungszauber auf Gegnern (Fokus)",
	
	["Hibernate"] = "Winterschlaf",
	["Cyclone"] = "Wirbelsturm",
	["Polymorph"] = "Verwandlung",
	["Seduction"] = "Verf\195\188hrung",
	["Enslave Demon"] = "D\195\164monensklave",		
	["Howl of Terror"] = "Schreckensgeheul",	
	["Banish"] = "Verbannen",									
	["Fear"] = "Furcht",											
	["Death Coil"] = "Todesmantel",						
	["Turn Evil"] = "B\195\182ses vertreiben",	
	["Freezing Trap"] = "Eisk\195\164ltefalle",	
	["Scatter Shot"] = "Streuschuss",	
	["Scare Beast"] = "Wildtier \195\164ngstigen",
	["Sap"] = "Kopfnuss",	
	["Blind"] = "Blenden",
	["Shackle Undead"] = "Untote Fesseln",
	["Mind Control"] = "Gedankenkontrolle",
	
		-- ParryWatcher.lua
	["Riposte"] = "Riposte",
	["Overpower (Target)"] = "\195\156berw\195\164ltigen (Ziel)",
	["Overpower (Focus)"] = "\195\156berw\195\164ltigen (Fokus)",
	
	-- PetWatcher.lua
	["Pet Spell Cooldowns"] = "Begleiter Spruch Cooldowns",
	
	-- PlayerDeathWatcher.lua
	["Player Deaths"] = "Spieler Tode",
	["Player Resurrections"] = "Spieler Wiederbelebungen",
	
	-- SpellWatcher.lua
	["Player Spell Cooldowns"] = "Spieler Spruch Cooldowns",
	["Player Spell Casts"] = "Spieler Zauber wirken",
	["Player Spell Resists"] = "Spieler Zauber wiederstanden",
	["Player Spell Immunity"] = "Spieler Zauber Immunit\195\164ten",

	-- ThreatGenWatcher.lua
	["Threat Resists (Target)"] = "Threat wiederstanden (Ziel)",
	["Threat Resists (Focus)"] = "Threat wiederstanden (Focus)",
	
	-- TrinkerWatcher.lua
	["Trinket Cooldowns"] = "Trinket Cooldowns",
	
} end)
