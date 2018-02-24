-- ------------------------------------------------------------------------------------- --
-- Deadly Boss Mods - AddOn by Refuge|Tandanu @ EU-Aegwynn and Nitram @ EU-Azshara 		 --
--                           http://www.deadlybossmods.com                               --
-- ------------------------------------------------------------------------------------- --

-- ------- --
-- Changes --
-- ------- --
--
--  v3.22
--  localization/ruRU: added basic support for russian clients
--  Sunwell/Kalecgos: fixed a bug that could cause the spectral realm frame to stick to your cursor
--  Sunwell/Kalecgos: the spectral realm frame will now remember its position
--  Sunwell/Eredar Twins: added a sound warning for conflag (PVPFlagTaken + HoodWolfTransformPlayer01 ("Run away little girl!"))
--  cleaned up some localization files by removing old unused strings
--  some minor tweaks and bug fixes
--
--  v3.21
--  updated the void reaver mod
--
--  v3.20
--  updated M'uru mod
--  added Kil'jaeden mod
--  updated localizations
--  Sunwell/Kalecgos: the status command will now also show the demon's HP
--  Sunwell/Eredar Twins: the status command should work now
--  Sunwell/M'uru: fixed the status command in phase 2
--  fixed a compatibility issue with WIM
--  fixed UnitNamePlayer bug (really!)
--  added spanish battleground translations (by Herenvarno@C'thun, thank you!)
--  
--  v3.11
--  fixed some patch 2.4.x issues
--  Naxxramas: updated for 2.4
--  The Eye/Kael'thas: fixed mind control announce
--  The Eye/Void Reaver: the arcane orb announce should start working as soon as patch 2.4.2 is released
--  Molten Core: all boss mods should work now
--  Sunwell/Kalecgos: added hp frame
--  Sunwell/Brutallus: added optional (disabled by default) delayed Burn announce and timer 15 seconds before Burn expires
--  Sunwell/Felmyst: added timers for Deep Breath
--  Sunwell/Felmyst: added warning for Demonic Vapor
--  updated localizations

--  v3.10
--  updated for patch 2.4.0, but most mods are untested! So there might be bugs
--  updated old boss mods to work with the new combat log system
--  added Sunwell boss mods
--  you can now disable the flash effects in Battlegrounds
--  Black Temple/Illidan: added warning and timer for "Caged" in phase 4
--  :StartStatusBarTimer() now accepts spellIds as texture
--
--  v3.03
--  you can now use %t in /dbm timer and /dbm broadcast timer
--  the toc field X-DBM-LoadZone now supports multiple zones
--  the sync code now supports non-raid boss mods
--  increased default bar limit to 15
--  some minor bug fixes
--  removed the mod DBM_Other
--  added DBM_Azeroth and DBM_Outlands
--  Illidan: added timer for Shadow Prison
--  Illidan: added timer and warning for phase 4 enrage
--  Battlegrounds: fixed some cross-server sync issues
--  Battlegrounds: changed sync code, DBM 3.02c will not sync with older versions in BGs
--  Battlegrounds: added auto-release spirit option (disabled by default)
--  Battlegrounds: re-enabled the blue flash effect
--  Illidari Council: added timer for divine wrath
--  Bloodboil: added optional Arcing Smash announce
--  updated deDE localization
--
--  v3.02b
--  localization updates
--  minor bug fixes
--
--  v3.02
--  fixed some 2.3 issues
--  Zul'Aman/Zul'jin: Added more warnings
--  Zul'Aman/Malacrass: Updated/changed warnings/timer
--  Zul'Aman/localizations: Updated zhTW/deDE localizations
--  Battlegrounds: Fixed score frame error messages and AV timers
--  Al'ar: Timers in phase 1 should work again
--
--
--  v3.01
--	Quick update for WoW 2.3
--  Added Zul'Aman mods
--
--  v3.00
--  New features:
--    All raid warnings can now have colors. The colors are encoded in whitespaces so raid members without DBM will not see color codes in raid warnings
--    There is now an option to enlarge timers that are about to expire. The new enlarged bars will be moved to a different position and can have a completely different style than the original bars
--    Added options to disable status bar timers
--    Added an option to change the status bar font size
--    The version check (/dbm ver) will now also show beta versions (note: versions < 3.00 will sometimes not show up because this version changes some sync commands)
--    Added a raid target icon management, DBM will now remember old icons when overwriting an icon and clear icons on wipe/boss kill
--    Added smart announce management: it will choose the a player if more than one player has enabled announce for a boss mod and disable announce for other players
--    Updated zhTW translation (thx 2 Nightkiller(kc10577;Azael))
--    Updated zhCN translation (thx 2 DiabloHu)
--
--  Bug fixes:
--    Rewrote some parts of the timing system to fix a small memory leak
--    Fixed "boss dead" message for fights with more than one boss mob, it will show the correct name of the encounter instead the name of a specific mob
--    Fixed some minor bugs
--
--  Boss mod fixes:
--    Gruul: adjusted some timers
--    Anetheron: fixed "Inferno on Unknown" when he casts inferno on the main tank
--    Essence of Souls: fixed double spite announce
--    Essence of Souls: slightly adjusted deaden timer
--    Essence of Souls: fixed Fixate warning
--    Essence of Souls: fixed possible wrong enrage announce
--    Kael'Thas: fixed an error message that could show up when the weapon health frame was disabled
--    Al'ar: fixed a bug that could disable most warnings under certain circumstances
--    Supremus: fixed timer icons
--    Naj'entus: fixed spine announce
--    Leotheras: slightly adjusted the whirlwind timer
--    Solarian: updated for World of Warcraft 2.2.x
--
--  New boss mod features:
--    Netherspite: added enrage timer
--    Essence of Souls: added an option to send whispers to Spite targets
--    Essence of Souls: added optional special warning for Spite
--    Essence of Souls: added optional warning for Soul Scream
--    Essence of Souls: added timer for the first Rune Shield and Deaden
--    Supremus: added enrage timer
--    Romulo/Julianne: Poisened Thrust announce (thx 2 Nightkiller(kc10577;Azael))
--    Lady Vashj: added whisper
--    Solorian: added whisper
--    
--
--  New boss mods:
--    Hyjal Wave Timers: Shows timers and announces trash mob waves in Mount Hyjal
--    Mother Shahraz: Fatal Attraction: announce, timer, whisper, icon
--                    Beams: announce, timer (timer disabled by default)
--
--    Illidari Council: Circle of Healing: announce, timer
--                      Deadly Poison: announce
--                      Vanish: announce, timer
--                      Shields: announce, timer
--                      Resistance/Devotion Aura: announce, timer
--						
--    Illidan: Phases: announce
--             Shear: announce, timer
--             Shadowfiend: announce, timer, icon
--             Dark Barrage: announce, timer
--             Eye Blast: announce
--             Demon/Normal Form: announce, timer
--             Agonizing Flames: announce, timer (timer disabled by default)
--             Flame Burst: announce, timer
--             Shadow Demons: announce, timer
--             Enrage: announce, timer
--
--
--
--  v2.71
--  reduced cpu usage
--  some bug fixes
--  updated the version sync commands, this should improve the compatibility with certain chatmods
--  updated localizations (thanks 2 DiabloHu!)
--  you can now target the flag carrier by clicking on his name in wsg (thanks 2 DiabloHu!)
--  the option to change the combat log range is back!
--  added Mount Hyjal and Black Temple boss mods
--
--
--  v2.70
--  updated .toc file for World of Warcraft 2.1.0
--  fixed battleground win timer and class color function
--  fixed Leotheras boss mod
--  fixed Lurker boss mod
--  fixed Gruul boss mod
--  fixed Karazhan boss mods
--  updated the Serpentshrine zone localizations
--  added zhTW localization for Karazhan (thanks to Dean, kc10577 and jrkid)
--  updated esES localization (thanks to Geran from Dun Modr)
--  updated deDE localization (thanks to Xerôn)
--  /dbm stop will no longer remove custom timers
--  the Void Reaver boss mod will now detect Arcane Orb on dps warriors
--  the Maiden of Virtue mod will now use her yell to detect repentance
--  added more synchronization commands for some boss mods
--  added High Astromancer Solarian mod
--  added Lady Vashj boss mod
--  added Al'ar boss mod
--  added Kael'thas boss mod
--  
--
--  v2.60
--  fixed Lurker Below boss mod
--  fixed load on demand bug for non-english versions
--  fixed compatibility issue with certain versions of some Ace2 libraries (this will fix the SendHiddenWhisper() function and DBM.PlaySound() errors)
--  fixed compatibility issue with SW_FixLogStrings
--  DBM_RaidTools is no longer a separate addon: all useful functions are now integrated in the DBM_API mod, some functions have been removed
--  you can delete the folder DBM_RaidTools (DBM will disable this mod if you don't delete the folder)
--  you can now also use /dbm timer 5h10m4s <text> and /dbm timer 2:50:35 <text> for long timers (e.g. sc respawn)
--  updated German localization
--  added French localization for Karazhan
--  added partial Spanish localization for Karazhan
--  adjusted Tidewalker timers
--  adjusted Maiden of Virtue timers
--  added Nightbane fear timer
--  added Nightbane Rain of Bones target icon
--  updated some Karazhan boss mods
--  added Leotheras the Blind boss mod
--  added Void Reaver boss mod
--  added timer recovery system, you'll no longer lose timers on disconnects or crashes


--  v2.50
--  the load on demand system now uses GetAddOnMetadata()
--  added an option to change the color of the special warning
--  updated Maiden of Virtue mod for patch 2.0.10
--  added a warning for Maiden of Virtue's Holy Fire
--  added a warning for Moroes' Garrote
--  added a warning for Shade of Aran's Blizzard
--  added a timer for Shade of Aran's Elementals
--  adjusted Gruul timers
--  added a 15 yard range check frame (bandage range)
--  fixed "autoClearAFK CVar" bug
--  fixed status command for raid members
--  added Magtheridon boss mod
--  added Doomwalker boss mod
--  added Hydross the Unstable boss mod
--  added Fathom-Lord Karathress boss mod
--  added Morogrim Tidewalker boss mod
--  added The Lurker Below boss mod


--  v2.40
--  fixed a problem with GuildAds
--  some minor changes/fixes for Burning Crusade
--  fixed a bug that could cause sync issues with certain timers
--  fixed some issues with the aggro alert function
--  you can now enable the aggro alert function in 5 player instances
--  added Karazhan boss mods
--  added Eye of the Storm battleground mod
--  added Gruul's Lair boss mods
--  added Doom Lord Kazzak boss mod
--
--
--  v2.31
--  fixed some patch 2.0.3 issues
--  optimized memory usage in the event handler functions
--  the "Battleground starts in..." timers will no longer show up if the BG mod is disabled
--  the /dm slash command was removed
--  updated some localizations
--  the BG mod got its own tab
--  you can now remove tabs be unchecking the addon in the "Load Mods" dropdown menu
--
--
--  v2.30
--  please delete all LVBM folders before installing this version
--  LVBM was renamed to Deadly Boss Mods
--  the minimap button got a new texture (thx 2 Shayariel)
--
--  fixed some 2.0.3 issues
--  fixed SendHiddenWhisper(), whispers containing a "%" will now be hidden
--  fixed version query in battlegrounds
--  fixed a bug that killed the Twin Emp teleport timer a few seconds after it started (announce worked)
--  only one tank needs to update to the version to fix the Twin Emp teleport timer
--
--  the GUI is ready for Burning Crusade!
--  removed the Kazzak boss mod
--  rewrote the Battleground mod
--  the Battleground mods are now three separate "boss" mods
--  added icons for the battleground mod
--  added a new estimated points frame for Arathi Basin
--  the AV auto turn-in function will now select "upgrade troops" automatically
--  the Battleground and Outdoor boss mods are now load on demand
--  added a new bar texture: glaze
--  added Gluth enrage timer
--  added some Kel'thuzad cooldowns (cooldowns! they are _not_ exact)
--
--
--  v2.21
--  fixed "stack overflow" bug
--  fixed a possible bug in the ChatFrame_AddMessage function
--  fixed bad variable name for key bindings
--  fixed some minor bugs in the battleground addon

--  v2.20
--  fixed some patch 2.0 issues
--  fixed some ZG combat detections
--  fixed a bug that could produce an error message while looting
--  fixed possible bug in the function that executes scheduled functions
--  fixed a possible Heigan sync issue
--  fixed some sync issues in Battlegrounds
--  fixed some minor bugs in the combat detection code
--  fixed some bugs in some boss mods
--  fixed a bug that could cause strange errors
--  fixed the Nefarian kill counter
--  
--  removed Alliance:/Horde: prefix from BG bars, because its useless since the bars are red/blue
--  updated C'Thun mod (thanks to Tsew@EU-Kirin-Tor)
--  removed C'Thun Dark Glare target announce because it's very unreliable since patch 2.0
--  updated Sapphiron mod :)
--  updated some localizations (thanks to Navarra, Sadie, Miawen)
--
--  added a Twin Emp teleport timer that works without events! (the teleport event has been removed in patch 2.0)
--  added timers with icons
--  added some new functions to the API and moved the documentation to http://www.wowwiki.com/La_Vendetta_Boss_Mods
--  added slash commands to start timers: /lv timer <time> <name> and /lv broadcast timer <time> <name>
--  added Hakkar Mind Control announce & timer
--  added "Game starts in..." timer for Arenas
--  added a spam block feature, use /lvrt spamblock for more information
--
--




if not math.mod and math.fmod then
	math.mod = math.fmod
end

if not string.gmatch and string.gfind then
	string.gmatch = string.gfind
end

DBM_SavedVars = {
	["AddOns"] = {
	},
	["DBM"] = {
	},
}

DBM = {}

DBM.Version = "3.22" -- used for "a new version of dbm is available"-spam
DBMGUI_VERSION = "3.02"

DBM_REVISION = tonumber(("$Revision: 296 $"):sub(12, -3) or 0) + 783 -- 783 = revision number from the old SVN repository
DBM_VERSION = "3.22" -- this version is used for /dbm ver commands
DBM.BetaVersion = DBM_VERSION.." (rev "..DBM_REVISION..")" -- this will be shown in the GUI if set


DBM.Bosses = {
}

DBM.ScheduleData = {
}

DBM.TimerData = {
}

DBM.StatusBarData = {
}

DBM.Hooks = {
}

DBM.SpamProtection = {
}

DBM.HideDNDAFKMessages = {
}

DBM.HideLoadInfo = false;

DBM.InRaid = false;

DBM.SyncInfo = {
	["Clients"] = {},
	["DispVers"] = {}
};

DBM.LongMsg = "";

DBM.AddOns = {	
};

DBM.MsgQueue = {
};

DBM.AggroUpdate = 0;


DBM.SortedAddOns = {
};

DBM.HiddenWhisperMessages = {
};

DBM.CombatUpdate = 0;

DBM.Rank = 0;

DBM.CombatStartTime = GetTime();

DBM.HideWhispers = false;

DBM.StatusBarCount = 0;


DBM.Raid = {
};

DBM.RaidClasses = {
};

DBM.WhispersDuringCombat = {
};

DBM.WhisperSpamProtection = {
};

DBM.StatusSpamProtection = {
};

DBM.BossModInfo = {
};

local modSpamTable = {};

DBM.FilteredBars = {
    "Mark #%d+",
	"^Mark$",
    "First Mark",
    "ABWINALLY",
    "ABWINHORDE",
	"Cloud Poison",
	"Possible next Detonate",
	"^Frost Breath$",
	"Repentance",
	"^Grow$",
	"Spell Shield",
	"Melee Shield"
};

DBM.LastCharge = GetTime();
DBM.LastBloodrage = GetTime();
DBM.LastFeignDeath = GetTime();
DBM.AutoAttack = false;

DBMInfoFramePositions = {};

DBM.VarsNotLoaded = true;

local namesWereHidden;

local randomNumber = math.random(1, 1000)
local tempDisabledMods = {}
local justSentBarRequest = false

local function UnitNameWithServer(id)
	local name, server = UnitName(id)
	if server and server ~= "" then
		return name.."-"..server
	else
		return name
	end
end

DBM.Options = {
	["StatusBarColor"] = {
		["r"] = 1.0,
		["g"] = 0.7,
		["b"] = 0.0,
		["a"] = 0.8,
	},
	["StatusBarDesign"] = 2,
	["MaxStatusBars"] = 10,
	["StatusBarsFlippedOver"] = false,
	["FillUpStatusBars"] = true,
	["EnableStatusBars"] = true,
	["EnableSync"] = true,
	["AllowSyncFromOldVersions"] = true,
	["MinimapButton"] = {
		["Position"] = 225,
		["Radius"] = 78.1,
		["Enabled"] = true,
	},
	["SpecialWarningsEnabled"] = true,
	["ShakeIntensity"] = 30,
	["ShakeDuration"] = 0.5,
	["SpecialWarningTextDuration"] = 5,
	["SpecialWarningTextFadeTime"] = 3,
	["SpecialWarningTextSize"]	= 40,
	["FlashDuration"] = 2,
	["NumFlashes"] = 1,
	["ShakeEnabled"] = false,
	["FlashEnabled"] = true,
	["FlashColor"] = "red",
	["SpecialWarningTextColor"] = {
		["r"] = 0.0,
		["g"] = 0.0,
		["b"] = 1.0,
		["a"] = 1.0,
	},
	["StatusBarSize"] = {
		["Scale"] = 1,
		["Width"] = 205,
		["Text"] = 10,
	},
	["FlashBars"] = true,
	["BusyMessage"] = DBM_DEFAULT_BUSY_MSG.." "..DBM_SEND_STATUS_INFO,
	["AutoRespond"] = true,
	["ShowAutoRespondInfo"] = true,
	["ShowWhispersDuringCombat"] = true,
	["HideOutgoingInfoWhisper"] = true,
	["EnableStatusCommand"] = true,
	["ShowCombatInformations"] = true,
	["AutoColorBars"] = true,
	["LoadGUIOnLoad"] = false,
	["ShowPullSyncInfo"] = false,
	["IconRight"] = false,
	["ShowIcon"] = true,
	["Gui"] = {
		["Version"]			= DBMGUI_VERSION,
		["RaidWarnSound"] 		= 1,

		["PizzaTimerText"] 		= "Pizza",
		["PizzaTimerHour"] 		= 0,
		["PizzaTimerMin"] 		= 15,
		["PizzaTimerSec"] 		= 0,
		["PizzaTimerBroadcast"]		= true,
		
		["RaidWarning_Enable"]		= true,
		["RaidWarning_R"] 		= 1.000000,
		["RaidWarning_G"] 		= 0.858823,
		["RaidWarning_B"] 		= 0.717647,
		["RaidWarning_Delay"]	 	= 1,
		["RaidWarning_Font"] 		= STANDARD_TEXT_FONT,
		["RaidWarning_Height"] 		= 18,
		["RaidWarning_PosX"] 		= 0,
		["RaidWarning_PosY"] 		= -235,

		["SelfWarning_Enable"]		= false,
		["SelfWarning_R"] 		= 1.000000,
		["SelfWarning_G"] 		= 0.858823,
		["SelfWarning_B"] 		= 0.717647,
		["SelfWarning_Delay"] 		= 5,
		["SelfWarning_Font"] 		= STANDARD_TEXT_FONT,
		["SelfWarning_Height"] 		= 16,
		["SelfWarning_PosX"] 		= 0,
		["SelfWarning_PosY"] 		= 235,
		["HidePlayerNamesInRaid"]	= false,
		["CombatLogValue"] 		= 2,
	},
	["SpamBlock"] = {
		["CTRaidFrame"] = true,
		["RaidChat"] = true,
		["RaidWarningChat"] = false,
		["RaidWarningFrame"] = false,
		["Battleground"] = true,
	},
	["Level70Gui"] = true,
	["FirstTime679Loaded"] = true,
	["RaidWarningColors"] = {
		{r = 0.41, g = 0.80, b = 0.94}, -- unimportant information
		{r = 0.95, g = 0.95, b = 0.00}, -- important information
		{r = 1.00, g = 0.50, b = 0.00}, -- more important warnings
		{r = 1.00, g = 0.10, b = 0.10}, -- even more important warnings 
		{r = 0.05, g = 0.20, b = 1.00}, -- wtf! (unused)		
	},
	["HugeBars"] = {
		["ShowIcon"] = true,
		["StatusBarColor"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 0.8,
		},
		["StatusBarDesign"] = 2,
		["MaxStatusBars"] = 10,
		["StatusBarsFlippedOver"] = false,
		["FillUpStatusBars"] = true,
		["EnableStatusBars"] = false,
		["StatusBarSize"] = {
			["Scale"] = 1,
			["Width"] = 205,
			["Text"] = 11,
		},
		["AutoColorBars"] = true,
		["IconRight"] = false,
		["FlashBars"] = true,
	},
	["EnlargeBarsAfterSec"] = 7.5,
	["EnlargeBarsAfterPerc"] = 10,
	["EnlargeBarsMaxSec"] = 20,
	["FirstTimeLoaded770"] = true,
	["FirstTimeLoaded790"] = true,
	["FirstTimeLoaded879"] = true
};




DBM.Options.CharSettings = {
};

DBM.Options.CharSettings[UnitName("player")] = {
};

if UnitClass("player") == DBM_WARRIOR then
	DBM.Options.CharSettings[UnitName("player")].AggroAlert = false;
	DBM.Options.CharSettings[UnitName("player")].AggroSound = false;
	DBM.Options.CharSettings[UnitName("player")].AggroFlash = false;
	DBM.Options.CharSettings[UnitName("player")].AggroShake = false;
	DBM.Options.CharSettings[UnitName("player")].AggroSpecialWarning = false;
	DBM.Options.CharSettings[UnitName("player")].AggroLocalWarning = false;
	DBM.Options.CharSettings[UnitName("player")].AggroAlertInAllInstances = false;
else
	DBM.Options.CharSettings[UnitName("player")].AggroAlert = true;
	DBM.Options.CharSettings[UnitName("player")].AggroSound = false;
	DBM.Options.CharSettings[UnitName("player")].AggroFlash = true;
	DBM.Options.CharSettings[UnitName("player")].AggroShake = true;
	DBM.Options.CharSettings[UnitName("player")].AggroSpecialWarning = true;
	DBM.Options.CharSettings[UnitName("player")].AggroLocalWarning = false;
	DBM.Options.CharSettings[UnitName("player")].AggroAlertInAllInstances = false;
end

---------------------
--OnEvent Functions--
---------------------
function DBM.OnLoad()
	SLASH_LVNAXXRAMASBOSSMODS1 = "/lv";
	SLASH_LVNAXXRAMASBOSSMODS2 = "/bossmods";
	SLASH_LVNAXXRAMASBOSSMODS3 = "/dbm";
	SLASH_LVNAXXRAMASBOSSMODS4 = "/deadlybossmods";
	SLASH_LVNAXXRAMASBOSSMODS5 = "/deadlyboss";
	SLASH_LVNAXXRAMASBOSSMODS6 = "/deadly";
	SlashCmdList["LVNAXXRAMASBOSSMODS"] = function(msg)
		if string.lower(msg) == "unlock" then
			DBM_StatusBarTimerDrag:Show();
			DBM_StatusBarTimerDrag2:Show();
		elseif string.lower(msg) == "lock" then
			DBM_StatusBarTimerDrag:Hide();
			DBM_StatusBarTimerDrag2:Hide();
		elseif string.lower(msg) == "ver" or string.lower(msg) == "version" then
			local syncInfo = {}
			for i = 1, GetNumRaidMembers() do
				local name, server = UnitName("raid"..i)
				if server and server ~= "" then -- server is sometimes the empty string for players on your server...strange!
					name = name.."-"..server
				end

				if type(DBM.SyncInfo.DispVers[name]) == "table" and tonumber(DBM.SyncInfo.DispVers[name][1]) then
					table.insert(syncInfo, {name, DBM.SyncInfo.DispVers[name][1], DBM.SyncInfo.DispVers[name][2]})
				end
			end
			if GetNumRaidMembers() == 0 then
				for i = 1, GetNumPartyMembers() do
					local name = UnitName("party"..i)
					if type(DBM.SyncInfo.DispVers[name]) == "table" and tonumber(DBM.SyncInfo.DispVers[name][1]) then
						table.insert(syncInfo, {name, DBM.SyncInfo.DispVers[name][1], DBM.SyncInfo.DispVers[name][2]})
					end
				end
				local name = UnitName("player")
				if type(DBM.SyncInfo.DispVers[name]) == "table" and tonumber(DBM.SyncInfo.DispVers[name][1]) then
					table.insert(syncInfo, {name, DBM.SyncInfo.DispVers[name][1], DBM.SyncInfo.DispVers[name][2]})
				end
			end
			table.sort(syncInfo, function(v1, v2) return tonumber(v1[2]..(v1[3] or 0)) > tonumber(v2[2]..(v2[3] or 0)) end)
			for index, value in ipairs(syncInfo) do
				if value[3] then
					DBM.AddMsg(value[1]..": "..value[2].." (revision "..value[3]..")")
				else
					DBM.AddMsg(value[1]..": "..value[2])
				end
			end
			DBM.AddMsg(DBM_FOUND_CLIENTS:format(#syncInfo))

		elseif string.lower(msg) == "ver2" then
			local syncInfo = {};
			local msg = "";
			for i = 1, GetNumRaidMembers() do
				msg = "raid"..i.." - ";
				msg = msg.."Name: "..UnitName("raid"..i).." - ";
				if (DBM.SyncInfo.Clients[UnitName("raid"..i)] and DBM.SyncInfo.Clients[UnitName("raid"..i)] == DBM.Version) then
					msg = msg.."Version: "..DBM.SyncInfo.Clients[UnitName("raid"..i)];
				elseif (DBM.SyncInfo.Clients[UnitName("raid"..i)]) then
					msg = msg.."Version: "..DBM.SyncInfo.Clients[UnitName("raid"..i)].." OLD";
					DBM.SendHiddenWhisper("<Deadly Boss Mods> "..DBM_YOUR_VERSION_SUCKS, UnitName("raid"..i));
				else
					msg = msg.."Version: -none-";
				end

				DBM.AddMsg(msg);
			end


		elseif string.lower(msg) == "bars" or string.lower(msg) == "barinfo" or string.lower(msg) == "syncedby" or string.lower(msg) == "syncinfo" then
			local syncedBars = false;
			for index, value in pairs(DBM.StatusBarData) do
				if value.syncedBy then
					DBM.AddMsg(index..": "..value.syncedBy);
					syncedBars = true;
				end
			end
			if( syncedBars == false ) then
				DBM.AddMsg(DBM_NOSYNCBARS);
			end
		elseif string.lower(msg) == "stop" then
			if DBM.Rank >= 1 then
				DBM.AddSyncMessage("ENDALL", true);
				DBM.AddMsg(DBM_ALL_STOPPED);
			else
				DBM.AddMsg(DBM_NEED_LEADER_STOP_ALL);
			end
		elseif string.sub(msg, 0, 5) == "timer" then -- blah...
			local _, _, _, timer, name = string.find(msg, "(%w+) ([:%d]+) (.+)");
			if not timer then
				local h, m, s, stringEndh, stringEndm, stringEnds;
				_, stringEndh, h = string.find(msg, "(%d+)%s*h");
				_, stringEndm, m = string.find(msg, "(%d+)%s*m");
				_, stringEnds, s = string.find(msg, "(%d+)%s*s");
				name = string.sub(msg, math.max((stringEndh or 0), (stringEndm or 0), (stringEnds or 0)) + 1);
				timer = 3600 * (tonumber(h) or 0) + 60 * (tonumber(m) or 0) + (tonumber(s) or 0);
			end
			if timer and name and timer ~= 0 and name ~= "" then
				DBM.StartStatusBarTimer(timer, name:gsub("%%t", UnitName("target") or DBM_NO_TARGET), nil, true);
			else
				DBM.AddMsg(DBM_TIMER_SLASHCMD_HELP1);
				DBM.AddMsg(DBM_TIMER_SLASHCMD_HELP2);
			end
		elseif string.sub(msg, 0, 15) == "broadcast timer" then
			local _, _, _, _, timer, name = string.find(msg, "(%w+) (%w+) ([:%d]+) (.+)");
			if not timer then
				local h, m, s, stringEndh, stringEndm, stringEnds;
				_, stringEndh, h = string.find(msg, "(%d+)%s*h");
				_, stringEndm, m = string.find(msg, "(%d+)%s*m");
				_, stringEnds, s = string.find(msg, "(%d+)%s*s");
				name = string.sub(msg, math.max((stringEndh or 0), (stringEndm or 0), (stringEnds or 0)) + 1);
				timer = 3600 * (tonumber(h) or 0) + 60 * (tonumber(m) or 0) + (tonumber(s) or 0);
			end
			if timer and name then				
				if DBM.Rank >= 1 then
					DBM.StartStatusBarTimer(timer, name:gsub("%%t", UnitName("target") or DBM_NO_TARGET));
				else
					DBM.StartStatusBarTimer(timer, name:gsub("%%t", UnitName("target") or DBM_NO_TARGET), nil, true);
				end
			else
				DBM.AddMsg(DBM_TIMER_SLASHCMD_HELP1);
				DBM.AddMsg(DBM_TIMER_SLASHCMD_HELP2);
			end
		elseif string.sub(msg, 0, 4) == "pull" then
			if DBM.Rank >= 1 then
				local _, _, timer = string.find(msg, "%w+ (%d+)");
				if tonumber(timer) then
					DBM.Announce_Pull(tonumber(timer)); 
				else
					DBM.AddMsg(DRT_PULLCOMMAND_FAILED);
				end
			else
				DBM.AddMsg(DRT_INVITE_NOPERMISSION);
			end
		elseif string.sub(msg, 0, 7) == "recover" then
			DBM.RequestBars(true);
		elseif string.sub(msg, 0, 9) == "spamblock" then
			local _, _, xArg1, xArg2 = string.find(msg, "%w+ (%w+) (%w+)");
			xArg1, xArg2 = string.lower(tostring(xArg1)), string.lower(tostring(xArg2));
			
			if (xArg2 ~= "on" and xArg2 ~= "off") or (xArg1 ~= "raid" and xArg1 ~= "raidwarning" and xArg1 ~= "raidwarningframe" and xArg1 ~= "ctraid" and xArg1 ~= "battleground") then
				if DBM.Options.SpamBlock.RaidChat then
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[1], DBM_ENABLED_GREEN));
				else
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[1], DBM_DISABLED_RED));
				end
				if DBM.Options.SpamBlock.RaidWarningChat then
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[2], DBM_ENABLED_GREEN));
				else
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[2], DBM_DISABLED_RED));
				end
				if DBM.Options.SpamBlock.RaidWarningFrame then
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[3], DBM_ENABLED_GREEN));
				else
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[3], DBM_DISABLED_RED));
				end
				if DBM.Options.SpamBlock.CTRaidFrame then
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[4], DBM_ENABLED_GREEN));
				else
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[4], DBM_DISABLED_RED));
				end
				if DBM.Options.SpamBlock.Battleground then
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[5], DBM_ENABLED_GREEN));
				else
					DBM.AddMsg(string.format(DRT_SPAMBLOCK_SLASHHELP[5], DBM_DISABLED_RED));
				end
			else
				if xArg1 == "raid" then
					if xArg2 == "on" then
						DBM.Options.SpamBlock.RaidChat = true;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Raid Chat", DBM_ENABLED_GREEN));
					else
						DBM.Options.SpamBlock.RaidChat = false;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Raid Chat", DBM_DISABLED_RED));
					end
				elseif xArg1 == "raidwarning" then
					if xArg2 == "on" then
						DBM.Options.SpamBlock.RaidWarningChat = true;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Raid Warning Chat", DBM_ENABLED_GREEN));
					else
						DBM.Options.SpamBlock.RaidWarningChat = false;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Raid Warning Chat", DBM_DISABLED_RED));
					end
				elseif xArg1 == "raidwarningframe" then
					if xArg2 == "on" then
						DBM.Options.SpamBlock.RaidWarningFrame = true;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Raid Warning Frame", DBM_ENABLED_GREEN));
					else
						DBM.Options.SpamBlock.RaidWarningFrame = false;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Raid Warning Frame", DBM_DISABLED_RED));
					end
				elseif xArg1 == "ctraid" then
					if xArg2 == "on" then
						DBM.Options.SpamBlock.CTRaidFrame = true;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "CT Raid", DBM_ENABLED_GREEN));
					else
						DBM.Options.SpamBlock.CTRaidFrame = false;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "CT Raid", DBM_DISABLED_RED));
					end
				elseif xArg1 == "battleground" then
					if xArg2 == "on" then
						DBM.Options.SpamBlock.Battleground = true;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Battleground", DBM_ENABLED_GREEN));
					else
						DBM.Options.SpamBlock.Battleground = false;
						DBM.AddMsg(string.format(DRT_SPAMBLOCK_OPTION_SET, "Battleground", DBM_DISABLED_RED));
					end
				end
			end

		else
			DBMMinimapButton:GetScript("OnClick")();
		end
	end
	
	if select(4, GetAddOnInfo("DBM_Other")) == 1 then
		DisableAddOn("DBM_Other")
	end
	

	SLASH_LVRANGECHECK1 = "/range";
	SLASH_LVRANGECHECK2 = "/rangecheck";
	SLASH_LVRANGECHECK3 = "/checkrange";
	SlashCmdList["LVRANGECHECK"] = DBM.RangeCheck;

	SLASH_LVCLEANUP1 = "/cleanup";
	SlashCmdList["LVCLEANUP"] = DBM.CleanUp;

	SLASH_DRT_PULL1 = "/pull";
	SlashCmdList["DRT_PULL"] = function(msg) DBM.Announce_Pull(msg); end;
	
	DBM_API:RegisterEvent("VARIABLES_LOADED");
	DBM_API:RegisterEvent("PLAYER_ENTERING_WORLD");
	DBM_API:RegisterEvent("PLAYER_LEAVING_WORLD");
	DBM_API:RegisterEvent("CHAT_MSG_WHISPER");
	DBM_API:RegisterEvent("RAID_ROSTER_UPDATE");
	DBM_API:RegisterEvent("PLAYER_ENTER_COMBAT");
	DBM_API:RegisterEvent("PLAYER_LEAVE_COMBAT");
	DBM_API:RegisterEvent("CHAT_MSG_ADDON");
	DBM_API:RegisterEvent("PLAYER_REGEN_DISABLED");
	DBM_API:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	DBM_API:RegisterEvent("PLAYER_DEAD");
	DBM_API:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	DBM_API:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	DBM_API:RegisterEvent("CHAT_MSG_MONSTER_SAY");
	DBM_API:RegisterEvent("PARTY_MEMBERS_CHANGED");
	DBM_API:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
	if (tonumber(UnitLevel("player")) or 0) > 60 then
		DBM.Options.Level70Gui = true
	end
	
	for i = 1, GetNumAddOns() do
		if GetAddOnMetadata(i, "X-DBM-AddOn") then
			table.insert(DBM.BossModInfo, {
				tab	= GetAddOnMetadata(i, "X-DBM-Tab-ID"),
				bc 	= GetAddOnMetadata(i, "X-DBM-Tab-BCTab"),
				s	= GetAddOnMetadata(i, "X-DBM-Tab-Sort"),
				n 	= GetAddOnMetadata(i, "X-DBM-Name") or GetAddOnMetadata(i, "X-DBM-Name-enGB"),
				tn	= GetAddOnMetadata(i, "X-DBM-Tab-Text") or GetAddOnMetadata(i, "X-DBM-Tab-Text-enGB"),
				tt	= GetAddOnMetadata(i, "X-DBM-Tab-Title") or GetAddOnMetadata(i, "X-DBM-Tab-Title-enGB"),
				z	= GetAddOnMetadata(i, "X-DBM-Tab-LoadZone") or GetAddOnMetadata(i, "X-DBM-Tab-LoadZone-enGB"),
				i	= i,
			})
		end
	end
	table.sort(DBM.BossModInfo, function(v1, v2)
		if type(v1) == "table" and type(v2) == "table" and v1.s and v2.s then
			return tonumber(v1.s) < tonumber(v2.s)
		end
	end)
	for index, value in ipairs(DBM.BossModInfo) do
		if not value.z then
			value.z = ""
		end
		value.s = nil
		if value.bc == "1" then
			value.bc = true
		else
			value.bc = nil
		end
		if select("#", strsplit(",", value.z)) > 1 then
			local t = {}
			for i = 1, select("#", strsplit(",", value.z)) do
				local z = select(i, strsplit(",", value.z))
				z = z:gsub("^%s+", "")
				z = z:gsub("%s+$", "")
				t[z] = true
			end
			value.z = t
		end
	end
end

function DBM.RangeCheck()
	local name, playersOutOfRange;
	playersOutOfRange = "";
	for i = 1, GetNumRaidMembers() do
		name = GetRaidRosterInfo(i)
		if name and (not CheckInteractDistance("raid"..i, 4)) then
			playersOutOfRange = playersOutOfRange..UnitName("raid"..i)..", ";
		end						
	end
	DBM.AddMsg(DBM_RANGE_CHECK..string.sub(playersOutOfRange, 1, (string.len(playersOutOfRange) - 2)));
end
	
function DBM.CleanUp()
	if DBM.Rank >= 1 then
		for i = 1, GetNumRaidMembers() do
			SetRaidTargetIcon("raid"..i, 0);
		end
		DBM.AddMsg(DBM_MSG_CLEANICONS);
	end
end

function DBM.LoadAddOns()
	for i, v in pairs(DBM.SortedAddOns) do
		DBM.SortedAddOns[i] = nil
	end

	for index, value in pairs(DBM.AddOns) do	--load AddOn's saved variables/add new addons to the DBM_SavedVars table/set default values for missing fields		
		if not value.Initialized then
			if not value.Name then
				DBM.AddOns[index].Name = index;
			end
			if not value.Version then
				DBM.AddOns[index].Version = "1.0";
			end
			if not value.Author then
				DBM.AddOns[index].Author = DBM.Capitalize(DBM_UNKNOWN);
			end
			if not value.Description then
				DBM.AddOns[index].Description = DBM_DEFAULT_DESCRIPTION;
			end
			if not value.Instance then
				DBM.AddOns[index].Instance = DBM_OTHER;
			end
			if not value.Instance then
				DBM.AddOns[index].Instance = DBM_OTHER;
			end
			if not value.GUITab then
				DBM.AddOns[index].GUITab = (DBM_NO_GUI_TAB or "No GUI");
			end
			if not value.Sort then
				value.Sort = 9999;
			end
			if not value.Options then
				DBM.AddOns[index].Options = {
					["Enabled"] = true,
					["Announce"] = false,
				}
			end		
			if value.Options.Enabled == nil then --not value.Options.Enabled would return true if the AddOn is disabled....and the next line would enable the addon
				DBM.AddOns[index].Options.Enabled = true;
			end
			if value.Options.Announce == nil then
				DBM.AddOns[index].Options.Announce = false;
			end
			if not value.Events then
				DBM.AddOns[index].Events = {};
			end
			if type(value.OnLoad) ~= "function" then
				DBM.AddOns[index].OnLoad = function() end;
			end
			if type(value.OnEvent) ~= "function" then
				DBM.AddOns[index].OnEvent = function() end;
			end
			if not value.UpdateInterval then
				DBM.AddOns[index].UpdateInterval = 0;
			end
			if not value.elapsed then
				DBM.AddOns[index].elapsed = 0;
			end
			
			if not value.Events then
				value.Events = {};
			end			
			
			if DBM_SavedVars.AddOns[index] == nil then --load saved vars
				DBM_SavedVars.AddOns[index] = value.Options
			else
				for index2, value2 in pairs(value.Options) do				
					if DBM_SavedVars.AddOns[index][index2] == nil then					
						DBM_SavedVars.AddOns[index][index2] = value2;
					else
						DBM.AddOns[index].Options[index2] = DBM_SavedVars.AddOns[index][index2];
					end
				end
			end
					
			setglobal("SLASH_"..index.."1", "/"..string.gsub(value.Name, " ", "")); --register slash commands
			for i = 1, 10 do
				if value["Abbreviation"..i] then
					setglobal("SLASH_"..index..(i+1), "/"..value["Abbreviation"..i]);
				else
					break;
				end
			end

			SlashCmdList[index] = function(msg)  -- thx 2 nymbia
				local abbrString = ''   
				if string.lower(msg) == 'on' then   
					DBM.AddOns[index].Options.Enabled = true   
					DBM.AddMsg(DBM_MOD_ENABLED, value.Name)   
				elseif string.lower(msg) == 'off' then   
					DBM.AddOns[index].Options.Enabled = false   
					DBM.UnSchedule('DBM.AddOns.'..index..'.OnEvent')   
					DBM.UnSchedule('DBM.AddOns.'..index..':OnEvent')   
					DBM.UnSchedule('DBM.AddOns["'..index..'"]:OnEvent')
					if DBM.AddOns[index].APIVersion and DBM.AddOns[index].APIVersion >= 2.11 then
						DBM.AddOns[index]:RemoveAllIcons()
						DBM.AddOns[index]:UnScheduleAll()
					end
					DBM.AddMsg(DBM_MOD_DISABLED, value.Name)   
				elseif string.lower(msg) == 'announce on' then   
					DBM.AddOns[index].Options.Announce = true   
					DBM.AddMsg(DBM_ANNOUNCE_ENABLED, value.Name)   
				elseif string.lower(msg) == 'announce off' then   
					DBM.AddOns[index].Options.Announce = false   
					DBM.AddMsg(DBM_ANNOUNCE_DISABLED, value.Name)   
				elseif string.lower(msg) == 'stop' then   
					if type(DBM.AddOns[index].OnStop) == 'function' then   
						if DBM.AddOns[index].APIVersion and DBM.AddOns[index].APIVersion >= 2.11 then   
							DBM.AddOns[index]:OnStop()   
						else
							DBM.AddOns[index].OnStop()   
						end
					end
					DBM.UnSchedule('DBM.AddOns.'..index..'.OnEvent')   
					DBM.UnSchedule('DBM.AddOns.'..index..':OnEvent')   
					DBM.UnSchedule('DBM.AddOns["'..index..'"]:OnEvent')
					if DBM.AddOns[index].APIVersion and DBM.AddOns[index].APIVersion >= 2.11 then
						DBM.AddOns[index]:RemoveAllIcons()
						DBM.AddOns[index]:UnScheduleAll()
					end			
					for index2, value2 in pairs(DBM.StatusBarData) do   
						if index2 then   
							if DBM.AddOns[index].Name == value2.startedBy then   
								DBM.EndRepeatingStatusBarTimer(index2, true)   
							end 
						end
					end
					DBM.AddMsg(DBM_MOD_STOPPED, value.Name)   
				else   
					if type(DBM.AddOns[index].OnSlashCommand) == 'function' then   
						if DBM.AddOns[index].APIVersion and DBM.AddOns[index].APIVersion >= 2.11 then   
							if DBM.AddOns[index]:OnSlashCommand(msg) then   
								return
							end   
						else
							if DBM.AddOns[index].OnSlashCommand(msg) then   
								return   
							end
						end
					end   
					DBM.AddMsg(string.format(DBM_MOD_INFO, DBM.AddOns[index].Version, DBM.AddOns[index].Author), value.Name)   
					DBM.AddMsg('/'..string.gsub(DBM.AddOns[index].Name, ' ', '')..DBM_SLASH_HELP1, value.Name)   
					DBM.AddMsg('/'..string.gsub(DBM.AddOns[index].Name, ' ', '')..DBM_SLASH_HELP2, value.Name)   
					DBM.AddMsg('/'..string.gsub(DBM.AddOns[index].Name, ' ', '')..DBM_SLASH_HELP3, value.Name)   
					if type(DBM.AddOns[index].SlashCmdHelpText) == 'table' then   
						for k,v in pairs(DBM.AddOns[index].SlashCmdHelpText) do   
							if type(v) == 'string' then   
								DBM.AddMsg(v, value.Name)   
							end
						end   
					end
					if type(DBM.AddOns[index].Abbreviation1) == 'string' then   
						abbrString = '/'..DBM.AddOns[index].Abbreviation1   
					end   
					if type(DBM.AddOns[index].Abbreviation2) == 'string' and (not type(DBM.AddOns[index].Abbreviation3) == 'string') then   
						abbrString = abbrString..' '..DBM_OR..' /'..DBM.AddOns[index].Abbreviation2   
					elseif type(DBM.AddOns[index].Abbreviation3) == 'string' then   
						abbrString = abbrString..', /'..DBM.AddOns[index].Abbreviation2..' '..DBM_OR..' /'..DBM.AddOns[index].Abbreviation3
					end

					if abbrString ~= '' then 
						DBM.AddMsg(string.format(DBM_SLASH_HELP4, abbrString, string.gsub(DBM.AddOns[index].Name, ' ', '')), value.Name)
					end
				end
			end

			
			
			if value.APIVersion and value.APIVersion >= 2.11 then
				DBM.AddOns[index]:OnLoad();
			else
				DBM.AddOns[index].OnLoad();
			end
			
			value.Initialized = true;
		end
		
		table.insert(DBM.SortedAddOns, index);		
	end

	table.sort(DBM.SortedAddOns, function(v1, v2) return DBM.AddOns[v1].Sort < DBM.AddOns[v2].Sort; end);
	DBM.Register();
end


function DBM.OnVarsLoaded()
	DBM.Register();
	
--	DBM.AddMsg(string.format(DBM_LOADED, DBM.BetaVersion or DBM.Version));
	
	for index, value in pairs(DBM.Options) do --load saved vars
		if DBM_SavedVars.DBM[index] == nil then
			DBM_SavedVars.DBM[index] = value;
		elseif type(DBM_SavedVars.DBM[index]) == "table" and type(DBM.Options[index]) == "table" and index ~= "CharSettings" then
			for index2, value2 in pairs(DBM.Options[index]) do
				if DBM_SavedVars.DBM[index][index2] == nil then
					DBM_SavedVars.DBM[index][index2] = value;
				elseif type(DBM_SavedVars.DBM[index][index2]) == "table" and type(DBM.Options[index][index2]) == "table" then
					for index3, value3 in pairs(DBM.Options[index][index2]) do
						if DBM_SavedVars.DBM[index][index2][index3] == nil then
							DBM_SavedVars.DBM[index][index2][index3] = value;
						else
							DBM.Options[index][index2][index3] = DBM_SavedVars.DBM[index][index2][index3];
						end				
					end
				else
					DBM.Options[index][index2] = DBM_SavedVars.DBM[index][index2];
				end				
			end
		elseif index == "CharSettings" then
			for index2, value2 in pairs(DBM.Options[index]) do
				if DBM_SavedVars.DBM[index][index2] == nil then
					DBM_SavedVars.DBM[index][index2] = DBM.Options[index][index2];
				else
					DBM.Options[index][index2] = DBM_SavedVars.DBM[index][index2];
				end
			end
			for index2, value2 in pairs(DBM_SavedVars.DBM[index]) do
				if DBM.Options[index][index2] == nil then
					DBM.Options[index][index2] = DBM_SavedVars.DBM[index][index2];
				else
					DBM_SavedVars.DBM[index][index2] = DBM.Options[index][index2];
				end
			end
		else
			DBM.Options[index] = DBM_SavedVars.DBM[index];
		end
	end	
	
	
	if DBM.Options.FirstTimeLoaded879 then
		DBM.Options.FirstTimeLoaded879 = false
		if DBM.Options.MaxStatusBars == 10 then
			DBM.Options.MaxStatusBars = 15
		end
	end
	
	local firstTimeLoadedMovableBars = false
	if DBM.Options.FirstTime679Loaded then
		firstTimeLoadedMovableBars = true
		DBM.Options.FirstTime679Loaded = false
		DBM.Options.FirstTimeLoaded790 = false
		DBM.Options.Gui.SelfWarning_Enable = false
		DBM.Options.HugeBars = {
			["ShowIcon"] = true,
			["StatusBarColor"] = {
				["r"] = 1.0,
				["g"] = 0.7,
				["b"] = 0.0,
				["a"] = 0.8,
			},
			["StatusBarDesign"] = 2,
			["MaxStatusBars"] = 10,
			["StatusBarsFlippedOver"] = false,
			["FillUpStatusBars"] = true,
			["EnableStatusBars"] = false,
			["StatusBarSize"] = {
				["Scale"] = 1.05,
				["Width"] = 218,
				["Text"] = 10,
			},
			["AutoColorBars"] = true,
			["IconRight"] = false,
			["FlashBars"] = true,
		}
		StaticPopupDialogs["DBMFirstTime679Loaded"] = {
			text = "Deadly Boss Mods added \"moving bars\" in version 3.00, do you want to reset your old bar options and load the new default options?\nNote: You can always reset to the 2.71 or 3.00 defaults by clicking on the \"Defaults\" or \"Old Defaults\" buttons in the \"Bars 1\" options tab.",
			button1 = YES,
			button2 = NO,
			OnAccept = function()
				DBM.Options.StatusBarColor = {
					["r"] = 1.0,
					["g"] = 0.7,
					["b"] = 0.0,
					["a"] = 0.8,
				}
				DBM.Options.StatusBarDesign = 2
				DBM.Options.StatusBarSize = {
					["Width"] = 255,
					["Scale"] = 0.75,
					["Text"] = 13,
				}
				DBM.Options.HugeBars.EnableStatusBars = true
			end,
--[[		OnHide = function()
				for i = 1, 4 do
					if getglobal("StaticPopup"..i) then
						if getglobal("StaticPopup"..i).which == "DBMFirstTime679Loaded" then
							getglobal("StaticPopup"..i):SetWidth(320)
							getglobal("StaticPopup"..i.."Text"):SetWidth(290)
						end
					end
				end
			end,]]--
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		StaticPopup_Show("DBMFirstTime679Loaded")
--[[	for i = 1, 4 do
			if getglobal("StaticPopup"..i) then
				if getglobal("StaticPopup"..i).which == "DBMFirstTime679Loaded" then
					getglobal("StaticPopup"..i):SetWidth(480)
					getglobal("StaticPopup"..i.."Text"):SetWidth(450)
				end
			end
		end]]--
	end
	if DBM.Options.FirstTimeLoaded770 then
		DBM.Schedule(15, ChangeChatColor, "RAID_WARNING", 1, 0.858823, 0.717647)
		
		DBM.Options["RaidWarningColors"] = {
			{r = 0.41, g = 0.80, b = 0.94}, -- unimportant information
			{r = 0.95, g = 0.95, b = 0.00}, -- important information
			{r = 1.00, g = 0.50, b = 0.00}, -- more important warnings
			{r = 1.00, g = 0.10, b = 0.10}, -- even more important warnings 
			{r = 0.05, g = 0.20, b = 1.00}, -- wtf! (unused)		
		}

		DBM.Options.FirstTimeLoaded770 = false
	end
	if DBM.Options.FirstTimeLoaded790 and not firstTimeLoadedMovableBars then
		StaticPopupDialogs["FirstTimeLoaded790"] = {
			text = "Deadly Boss Mods 3.0 introduced \"Moving Timers\", but I got mails from many people who didn't like this new feature, so I added a button to reset the options to the pre-3.00 defaults.\nDo you want to reset your bar options to the 2.71 default values now?\nNote: You can always do this by clicking on the \"Old Defaults\" button in the \"Bars 1\" options tab.",
			button1 = YES,
			button2 = NO,
			OnAccept = DBMStatusBars_SetOldDefaultValues,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		StaticPopup_Show("FirstTimeLoaded790")
		DBM.Options.FirstTimeLoaded790 = false
	end
	
	DBMSpecialWarningFrameText:SetFont(STANDARD_TEXT_FONT, DBM.Options.SpecialWarningTextSize, "THICKOUTLINE");
	DBMStatusBars_ChangeDesign(DBM.Options.StatusBarDesign, true);
	DBMHugeStatusBars_ChangeDesign(DBM.Options.HugeBars.StatusBarDesign, true);
	
	DBMMinimapButton_Move();	

	if not DBM.Options.MinimapButton.Enabled then
		DBMMinimapButton:Hide();
	else
		DBMMinimapButton:Show();
	end
	
	if DBM.Options.LoadGUIOnLoad then
		if LoadAddOn("DBM_GUI") then
			DBMBossModFrame_OnEvent("PLAYER_LOGIN");
		end
	end
	
	if GetNumRaidMembers() > 1 then
		DBM.AddSyncMessage("HI!", true);
		DBM.InRaid = true;
		DBM.Schedule(5, DBM.RequestBars);
		local name, rank, class;
		for i = 1, GetNumRaidMembers() do
			name, rank, _, _, _, class = GetRaidRosterInfo(i);
			if UnitName("player") == name then
				DBM.Rank = rank;
			end
			DBM.Raid[name] = rank;
			DBM.RaidClasses[name] = class;
		end
	elseif GetNumPartyMembers() > 0 then
		SendAddonMessage("LVBM NSP", "HI!", "PARTY")
		for i = 1, GetNumPartyMembers() do			
			local name = UnitName("party"..i)
			local _, class = UnitClass("party"..i)
			DBM.RaidClasses[name] = class
			DBM.Raid[name] = 1
		end
		local _, class = UnitClass("player")
		DBM.RaidClasses[UnitName("player")] = class
		DBM.Raid[UnitName("player")] = 1
	end
	
	DBM.LoadAddOns();
	
	if type(ForgottenChat_Blacklist) == "table" then
		local foundLVBM, foundLVPN;
		for index, value in pairs(ForgottenChat_Blacklist) do
			if value == "LVBM" then
				foundLVBM = true;
			elseif value == "LVPN" then
				foundLVPN = true;
			end
		end
		if not foundLVBM then
			table.insert(ForgottenChat_Blacklist, "LVBM")
		end
		if not foundLVPN then
			table.insert(ForgottenChat_Blacklist, "LVPN");
		end
	end
	if type(WIM_Filters) == "table" then	
		WIM_Filters["^LVBM"] = WIM_Filters["^LVBM"] or "Ignore";
		WIM_Filters["^LVPN"] = WIM_Filters["^LVPN"] or "Ignore";
	end
		
	--FIX ME
	SLASH_LVDISTANCE1 = "/distance";	-- EN
	if GetLocale() == "deDE" then -- should be moved to the localization file
		SLASH_LVDISTANCE2 = "/abstand";		-- DE
	end
	SlashCmdList["LVDISTANCE"] = DBM_Gui_DistanceFrame;
	RaidWarningFrame:ClearAllPoints();
	RaidWarningFrame:SetPoint("CENTER", "UIParent", "TOP", DBM.Options.Gui["RaidWarning_PosX"], DBM.Options.Gui["RaidWarning_PosY"]);
--	RaidWarningFrame:SetFont(DBM.Options.Gui["RaidWarning_Font"], DBM.Options.Gui["RaidWarning_Height"], "");

	DBMWarningFrame:ClearAllPoints();
	DBMWarningFrame:SetPoint("CENTER", "UIParent", "BOTTOM", DBM.Options.Gui["SelfWarning_PosX"], DBM.Options.Gui["SelfWarning_PosY"]);
	DBMWarningFrame:SetFont(DBM.Options.Gui["SelfWarning_Font"], DBM.Options.Gui["SelfWarning_Height"], "");

	if( DBM.Options.Gui["RaidWarning_Enable"] == false ) then	RaidWarningFrame:Hide();	end
	if( DBM.Options.Gui["SelfWarning_Enable"] == false ) then	DBMWarningFrame:Hide();	end

	if (DBM.Options.Gui["HidePlayerNamesInRaid"] and GetNumRaidMembers() > 0) then
--		if (tonumber(GetCVar("UnitNamePlayer")) == 1) then
--			DBM.Options.Gui["HidePlayerNames"] = true;
--			SetCVar("UnitNamePlayer", 0);
--			namesWereHidden = true
--		end
	end
	
	if IsAddOnLoaded("LVBM_API") then
		StaticPopup_Show("OLD_VERSION_DETECTED");
	end
	
	DBM.VarsNotLoaded = nil;
end

local initialized
function DBM.OnEvent(event, ...)
	if (event == "VARIABLES_LOADED") then
		DBM.OnVarsLoaded();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if not initialized then
			initialized = true;
			DBM.SetHooks();
		end

		for i, v in pairs(tempDisabledMods) do -- see PLAYER_LEAVING_WORLD...re-enable temp. disabled announces after the loading screen.
			if v and v.Options then
				v.Options.Announce = false
			end
		end
		
		DBM.OnNewZone();
	elseif (event == "PLAYER_LEAVING_WORLD") then -- PLAYER_LOGOUT seems to be fired after saving of variables in same cases (?)
		DBM_SavedVars.DBM = DBM.Options; -- DBM_SavedVars.DBM ~= DBM.Options, see load code!
		for i, v in pairs(tempDisabledMods) do -- re-enabled temp. disabled mods...they'll be disabled again on PLAYER_ENTERNING_WORLD...PLAYER_LOGIN and PLAYER_LOGOUT events can cause problems...
			if v and v.Options then
				if v.Options.Announce then -- remove them from the table if the user re-enabled it
					tempDisabledMods[i] = nil
				else
					v.Options.Announce = true
				end
			end
		end
		for index, value in pairs(DBM.AddOns) do
			DBM_SavedVars.AddOns[index] = value.Options;
		end
	elseif (event == "CHAT_MSG_ADDON") and arg1 and ((arg1 == "LVBM") or (arg1 == "LVBM NSP") or (string.sub(arg1, 1, 4) == "DBM3")) and arg2 and (arg3 == "RAID" or arg3 == "PARTY" or arg3 == "BATTLEGROUND" or arg3 == "WHISPER") and (DBM.Options.EnableSync) then
		if arg2:find("\124") then return end
		if arg1 == "LVBM NSP" or arg1 == "DBM NSP" then
			DBM.OnSyncMessage(arg2, arg4, true);
		elseif arg1 == "LVBM" or arg1 == "DBM" then
			DBM.OnSyncMessage(arg2, arg4);
		elseif string.sub(arg1, 1, 4) == "DBM3" then
			local modID = string.sub(arg1, 5);
			if DBM.AddOns and DBM.AddOns[modID] and (not modSpamTable[modID] or not modSpamTable[modID][arg2]) then
				if DBM.AddOns[modID].MinVersionToSync and (not DBM.SyncInfo.Clients or not DBM.SyncInfo.Clients[arg4] or tonumber(DBM.SyncInfo.Clients[arg4]) < tonumber(DBM.AddOns[modID].MinVersionToSync)) then
					return;
				end
				if DBM.AddOns[modID].MinRevision and (not DBM.SyncInfo.DispVers or not DBM.SyncInfo.DispVers[arg4] or not DBM.SyncInfo.DispVers[arg4][2] or (tonumber(DBM.SyncInfo.DispVers[arg4][2]) or 0) < tonumber(DBM.AddOns[modID].MinRevision)) then
					return;
				end
				
				if not modSpamTable[modID] then
					modSpamTable[modID] = {};
				end				
				modSpamTable[modID][arg2] = 3;
				
				if DBM.AddOns[modID].Options and DBM.AddOns[modID].Options.Enabled and type(DBM.AddOns[modID].OnSync) == "function" then
					DBM.AddOns[modID]:OnSync(arg2, arg4);
				end
			end		
		end
	elseif (event == "CHAT_MSG_WHISPER") and ((string.sub(arg1, 1, 4) == "LVPN") or (string.sub(arg1, 1, 5) == "LVBM ")) then
		if arg1:find("\124") then return end
		if string.sub(arg1, 1, 5) == "LVPNS" then
			DBM.OnPatchnoteMessage(string.sub(arg1, 6), false);
		elseif string.sub(arg1, 1, 5) == "LVPNL" then
			DBM.OnPatchnoteMessage(string.sub(arg1, 6), true);
		elseif string.sub(arg1, 1, 7) == "LVPNREQ" then
			local version, language;
			_, _, version, language = string.find(arg1, "LVPNREQ ([^%s]+) (%w+)");
			DBM.SendPatchnotes(arg2, version, language);
		elseif string.sub(arg1, 1, 5) == "LVBM " and string.sub(arg1, 6, 7) ~= "SC" then
			DBM.OnSyncMessage(string.sub(arg1, 6), arg2, true);
		end
	elseif event == "CHAT_MSG_WHISPER" and DBM.InCombat and string.lower(arg1) == "status" and DBM.Options.EnableStatusCommand then
		if (GetTime() - (DBM.StatusSpamProtection[arg2] or 0)) > 1 then
			DBM.StatusSpamProtection[arg2] = GetTime();
			local message = DBM_RAID_STATUS_WHISPER;
			message = string.gsub(message, "%%P", UnitName("player"));
			message = string.gsub(message, "%%B", tostring((DBM.Bosses[GetRealZoneText()][DBM.InCombat].realName or DBM.Bosses[GetRealZoneText()][DBM.InCombat].name)));
			message = string.gsub(message, "%%HP", DBM.GetBossHP(DBM.Bosses[GetRealZoneText()][DBM.InCombat].name));
			message = string.gsub(message, "%%ALIVE", DBM.GetNumRaidMembersAlive());
			message = string.gsub(message, "%%RAID", tostring(GetNumRaidMembers()));
			DBM.SendHiddenWhisper("<Deadly Boss Mods> "..message, arg2);
		end
	elseif (event == "RAID_ROSTER_UPDATE") then
		local name, rank, class;
		if GetNumRaidMembers() > 1 then
			if not DBM.InRaid then
				DBM.InRaid = true;
				DBM.AddSyncMessage("HI!", true);
				DBM.Schedule(5, DBM.RequestBars);
				if DBM.Options.Gui.HidePlayerNamesInRaid then
--					SetCVar("UnitNamePlayer", 0);
--					namesWereHidden = true
				end
			end
			DBM.Raid = {};
			DBM.RaidClasses = {}
			for i = 1, GetNumRaidMembers() do
				name, rank, _, _, _, class = GetRaidRosterInfo(i);
				if UnitName("player") == name then
					DBM.Rank = rank;
				end
				if name then --yes, name can be nil! this happens when you are in a raid grp and someone in your raid deletes his or her char oO
					DBM.Raid[name] = rank;
					DBM.RaidClasses[name] = class;
				end
			end
		else
			if DBM.InRaid then				
				DBM.InRaid = false;
				if DBM.Options.Gui.HidePlayerNamesInRaid and namesWereHidden then
--					SetCVar("UnitNamePlayer", 1);
--					namesWereHidden = false
				end
			end
		end
	elseif event == "PARTY_MEMBERS_CHANGED" and GetNumRaidMembers() == 0 then
		local name, rank, class
		if GetNumPartyMembers() > 0 then
			SendAddonMessage("LVBM NSP", "HI!", "PARTY")
			if not DBM.RaidClasses then
				DBM.RaidClasses = {}
			end
			for i = 1, GetNumPartyMembers() do
				local name = UnitName("party"..i)
				local _, class = UnitClass("party"..i)
				DBM.RaidClasses[name] = class
				DBM.Raid[name] = 1
			end
			local _, class = UnitClass("player")
			DBM.RaidClasses[UnitName("player")] = class
			DBM.Raid[UnitName("player")] = 1
		end
	elseif (event == "PLAYER_ENTER_COMBAT") then
		DBM.AutoAttack = true;
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		DBM.AutoAttack = false;
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if DBM.Bosses[GetRealZoneText()] and not DBM.InCombat then
			local bossTable = {}; -- fix me // memory leak
			local bosses = {}; -- fix me // memory leak
			
			for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "COMBAT" then
					bossTable[value.name] = {["index"] = index, ["value"] = value};
					table.insert(bosses, value.name);
				end
			end
			bosses = DBM.UnitExists(bosses);
			if bosses then
				for index, value in pairs(bosses) do
					if value then
						DBM.Schedule((bossTable[index].value.delay or 5), 	function(bossID)							
							if DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][bossID] then
								if DBM.DetectCombat(DBM.Bosses[GetRealZoneText()][bossID].name) then									
									DBM.CombatStart(bossID, (DBM.Bosses[GetRealZoneText()][bossID].delay or 5));
								end
							end
						end, bossTable[index].index);
					end
				end
			end
		end
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		DBM.CombatEnd();
		DBM.OnNewZone();
	elseif (event == "PLAYER_DEAD") then
		DBM.EndHideWhispers();
	elseif (event == "CHAT_MSG_MONSTER_YELL") then
		if DBM.Bosses[GetRealZoneText()] and not DBM.InCombat then
			for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "YELL" then
					if value.startTrigger and value.startTrigger[arg1] then
						DBM.CombatStart(index, 0);
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_SAY") then
		if DBM.Bosses[GetRealZoneText()] and not DBM.InCombat then
			for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "SAY" then
					if value.startTrigger and value.startTrigger[arg1] then
						DBM.CombatStart(index, 0);
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		if DBM.Bosses[GetRealZoneText()] and not DBM.InCombat then
			for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "EMOTE" then
					if value.startTrigger and value.startTrigger[arg1] then
						DBM.CombatStart(index, 0);
					end
				end
			end
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if arg2 == "SPELL_CAST_START" and arg4 == UnitName("player") and bit.band(arg5, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
			if arg10 == DBM_BLOODRAGE then
				DBM.LastBloodrage = GetTime()
			elseif arg10 == DBM_FEIGNDEATH then
				DBM.LastFeignDeath = GetTime()
			end
		elseif arg2 == "UNIT_DIED" or arg2 == "UNIT_DESTROYED" then 
			local mobName = arg7
			if mobName and DBM.Bosses[GetRealZoneText()] then
				for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
					if type(value.killName) == "table" then
						for index2, value2 in pairs(value.killName) do
							if value2.name == mobName then
								DBM.CombatEnd(nil, nil, mobName)
							end
						end
					else
						if (value.killName or value.name) == mobName then
							DBM.CombatEnd((value.killName or value.name));
						end
					end
				end
			end
		end
		DBM.OnCombatLogEvent(...)
	end

	
	for index, value in pairs(DBM.AddOns) do
		if value.Options.Enabled and value.Events[event] and ((value.Instance == DBM_OTHER) or (value.Instance == GetRealZoneText()) or (GetLocale() == "esES" or GetLocale() == "koKR")) then
			if value.APIVersion and value.APIVersion >= 2.11 then
				DBM.AddOns[index]:OnEvent(event, ...);
			else
				DBM.AddOns[index].OnEvent(event, ...);
			end
		end
	end
end

function DBM.OnNewZone()
	if (GetRealZoneText() == DBM_NAXX) then
		LoadAddOn("DBM_NAXX");
		DBM.LoadAddOns();
		
	elseif (GetRealZoneText() == DBM_AQ40) then
		LoadAddOn("DBM_AQ40");
		DBM.LoadAddOns();

	elseif (GetRealZoneText() == DBM_BWL) then
		LoadAddOn("DBM_BWL");
		DBM.LoadAddOns();

	elseif (GetRealZoneText() == DBM_MC) then
		LoadAddOn("DBM_MC");
		DBM.LoadAddOns();

	elseif (GetRealZoneText() == DBM_AQ20) then
		LoadAddOn("DBM_AQ20");
		DBM.LoadAddOns();

	elseif (GetRealZoneText() == DBM_ZG) then
		LoadAddOn("DBM_ZG");
		DBM.LoadAddOns();
		
	elseif (GetRealZoneText() == DBM_ARATHI)
	or (GetRealZoneText() == DBM_ALTERAC)
	or (GetRealZoneText() == DBM_WARSONG)
	or (GetRealZoneText() == DBM_EYEOFTHESTORM)	then
		LoadAddOn("DBM_Battlegrounds");
		if DBM.AddOns.Battlegrounds then DBM.AddOns.Battlegrounds:OnEvent("ZONE_CHANGED_NEW_AREA"); end
		if DBM.AddOns.Alterac then DBM.AddOns.Alterac:OnEvent("ZONE_CHANGED_NEW_AREA"); end
		if DBM.AddOns.Arathi then DBM.AddOns.Arathi:OnEvent("ZONE_CHANGED_NEW_AREA"); end
		if DBM.AddOns.Warsong then DBM.AddOns.Warsong:OnEvent("ZONE_CHANGED_NEW_AREA");	end
		if DBM.AddOns.EyeOfTheStorm then DBM.AddOns.EyeOfTheStorm:OnEvent("ZONE_CHANGED_NEW_AREA"); end
		DBM.LoadAddOns();
	
	elseif GetRealZoneText() == DBM_ONYXIAS_LAIR then
		LoadAddOn("DBM_Azeroth")
		DBM.LoadAddOns()	
	elseif GetRealZoneText() == DBM_GRUULS_LAIR
	or GetRealZoneText() == DBM_MAGS_LAIR then
		LoadAddOn("DBM_Outlands")
		DBM.LoadAddOns()
	end

	for index, value in ipairs(DBM.BossModInfo) do
		if ((GetRealZoneText() == value.z)
		or (type(value.z) == "table" and value.z[GetRealZoneText()]))
		and not IsAddOnLoaded(value.i) then
			local loaded, reason = LoadAddOn(value.i);
			if not loaded then
				DBM.AddMsg(string.format("Error while loading boss mods for '%s': %s", tostring(value.n), tostring(reason)));
			else
				DBM.AddGuiTab(value.tab, value.tn, value.tt, value.bc);
				DBM.AddMsg(string.format(DBM_BOSS_MOD_LOADED, tostring(value.n)));
				DBM.LoadAddOns();
			end
		end
	end
end

function DBM.UpdateTimerData(elapsed)
	for i = #DBM.ScheduleData, 1, -1 do
		local v = DBM.ScheduleData[i]
		if v then
			v.elapsed = v.elapsed + elapsed
			if v.elapsed >= v.timer then
				if type(v.func) == "function" then
					table.remove(DBM.ScheduleData, i) -- remove the entry before we execute the function to prevent bugs when the called function raises an error (using pcall would also be possible to prevent this)
					v.func(unpack(v.args))
				elseif type(v.func) == "string" then -- sucks...don't use it! (it's supported for compatibility reasons)
					DBM.ScheduleFunc = loadstring(v.func.."(unpack(DBM.ScheduleFuncArgs))")
					DBM.ScheduleFuncArgs = v.args
					table.remove(DBM.ScheduleData, i)
					if type(DBM.ScheduleFunc) == "function" then
						DBM.ScheduleFunc()
					end
					DBM.ScheduleFunc = nil;
					DBM.ScheduleFuncArgs = nil;
				else --invalid entry, delete it
					table.remove(DBM.ScheduleData, i)
				end
			end
		end
	end
end

local msgQueueElapsed = 0
function DBM.OnUpdate(elapsed)
	for index, value in pairs(DBM.TimerData) do
		if not value.stopped then
			DBM.TimerData[index].elapsed = DBM.TimerData[index].elapsed + elapsed;
		end
	end
	DBM.UpdateTimerData(elapsed);
	for index, value in pairs(DBM.SpamProtection) do
		DBM.SpamProtection[index] = DBM.SpamProtection[index] - elapsed;
		if DBM.SpamProtection[index] <= 0 then
			DBM.SpamProtection[index] = nil;
		end
	end	
	msgQueueElapsed = msgQueueElapsed + elapsed;
	if msgQueueElapsed >= 0.1 then
		msgQueueElapsed = 0;
		if DBM.MsgQueue[1] then
			local oldValue = GetCVar("autoClearAFK");
			SendChatMessage(DBM.MsgQueue[1].msg, "WHISPER", nil, DBM.MsgQueue[1].target);
			SetCVar("autoClearAFK", oldValue);
			table.remove(DBM.MsgQueue, 1)			
		end
	end	
	for index, value in pairs(DBM.AddOns) do 
		--execute the OnUpdate functions of the addons

		if value.Options.Enabled and type(value.OnUpdate) == "function" then
			if value.Instance == GetRealZoneText() 
			or value.Instance == DBM_OTHER 
			or (GetLocale() == "esES" or GetLocale() == "koKR") then --unsupported languages :<

				DBM.AddOns[index].elapsed = DBM.AddOns[index].elapsed + elapsed;
				if value.elapsed > value.UpdateInterval then
					if value.APIVersion and value.APIVersion >= 2.11 then
						DBM.AddOns[index]:OnUpdate(DBM.AddOns[index].elapsed);
					else
						DBM.AddOns[index].OnUpdate(DBM.AddOns[index].elapsed);
					end
					DBM.AddOns[index].elapsed = 0;
				end
			end
		end
	end
	for i = 1, DBM.StatusBarCount do
		local frame = getglobal("DBM_StatusBarTimer"..i);
		if frame:IsShown() and not frame:IsVisible() then
			local frameBar = getglobal("DBM_StatusBarTimer"..i.."Bar");
			if frame.isUsed and DBM.StatusBarData[frame.usedBy] then
				DBM.StatusBarData[frame.usedBy].elapsed = DBM.StatusBarData[frame.usedBy].elapsed + elapsed;
				if DBM.Options.FillUpStatusBars then
					frameBar:SetValue(DBM.StatusBarData[frame.usedBy].elapsed);
				else
					frameBar:SetValue(DBM.StatusBarData[frame.usedBy].timer - DBM.StatusBarData[frame.usedBy].elapsed);
				end
				getglobal(frameBar:GetName().."Timer"):SetText(DBM.SecondsToTime(DBM.StatusBarData[frame.usedBy].timer - DBM.StatusBarData[frame.usedBy].elapsed));
				if DBM.StatusBarData[frame.usedBy].elapsed >= DBM.StatusBarData[frame.usedBy].timer then
					if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(frameBar:GetName().."Text"):GetText() and ((not DBM.StatusBarData[frame.usedBy].repetitions) or DBM.StatusBarData[frame.usedBy].repetitions <= 1) then
						GameTooltip:Hide();
					end
					DBM.EndStatusBarTimer(frame.usedBy, true);
				end
			end
		end
	end
	local hugeBarCounter = 1
	while getglobal("DBM_HugeBar"..hugeBarCounter) do
		local frame = getglobal("DBM_HugeBar"..hugeBarCounter);
		if frame:IsShown() and not frame:IsVisible() then
			local frameBar = getglobal("DBM_HugeBar"..hugeBarCounter.."Bar");
			if frame.isUsed and frame.table then
				frame.table.elapsed = frame.table.elapsed + elapsed;
				if DBM.Options.HugeBars.FillUpStatusBars then
					frameBar:SetValue(frame.table.elapsed);
				else
					frameBar:SetValue(frame.table.timer - frame.table.elapsed);
				end
				getglobal(frameBar:GetName().."Timer"):SetText(DBM.SecondsToTime(frame.table.timer - frame.table.elapsed));
				if frame.table.elapsed >= frame.table.timer then
					if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(frameBar:GetName().."Text"):GetText() then
						GameTooltip:Hide();
					end
					DBMStatusBars_EndImportantBar(frame);
				end
			end
		end
		hugeBarCounter = hugeBarCounter + 1
	end
	
	DBM.AggroUpdate = DBM.AggroUpdate + elapsed;
	if DBM.AggroUpdate > 1 and DBM.Options.CharSettings[UnitName("player")].AggroAlert then
		local isInInstance, instanceType = IsInInstance();

		DBM.AggroUpdate = 0;
		if isInInstance and ((instanceType == "raid") or (instanceType ~= "pvp" and instanceType ~= "none" and DBM.Options.CharSettings[UnitName("player")].AggroAlertInAllInstances)) then
			for i = 1, GetNumRaidMembers() do
				if UnitName("raid"..i.."targettarget") == UnitName("player") and not UnitIsPlayer("raid"..i.."target") then
					if DBM.LastAggroTarget ~= UnitName("raid"..i.."target") then
						DBM.HasAggro(UnitName("raid"..i.."target"));
						DBM.LastAggroTarget = UnitName("raid"..i.."target");
						DBM.AggroUpdate = -12.5
						DBM.Schedule(25, function(target) if DBM.LastAggroTarget == target then DBM.LastAggroTarget = nil; end end, DBM.LastAggroTarget)
					end
					break;
				end
			end
			for i = 1, GetNumPartyMembers() do
				if UnitName("party"..i.."targettarget") == UnitName("player") and not UnitIsPlayer("party"..i.."target") then
					if DBM.LastAggroTarget ~= UnitName("party"..i.."target") then
						DBM.HasAggro(UnitName("party"..i.."target"));
						DBM.LastAggroTarget = UnitName("party"..i.."target");
						DBM.AggroUpdate = -12.5
						DBM.Schedule(25, function(target) if DBM.LastAggroTarget == target then DBM.LastAggroTarget = nil; end end, DBM.LastAggroTarget)
					end
					break;
				end
			end
			if UnitName("targettarget") == UnitName("player") and not UnitIsPlayer("target") then
				if DBM.LastAggroTarget ~= UnitName("target") then
					DBM.HasAggro(UnitName("target"));
					DBM.LastAggroTarget = UnitName("target");
					DBM.AggroUpdate = -12.5
					DBM.Schedule(25, function(target) if DBM.LastAggroTarget == target then DBM.LastAggroTarget = nil; end end, DBM.LastAggroTarget)
				end
			end
		end
	end
	DBM.CombatUpdate = DBM.CombatUpdate + elapsed; --REWRITE ME
	if DBM.CombatUpdate > 2 then
		DBM.CombatUpdate = 0;
		if DBM.InCombat and not UnitAffectingCombat("player") and not UnitIsDead("player") and not DBM.GetScheduleTimeLeft(DBM.CheckForCombatEnd) then
			if DBM.InCombat then
				if DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][DBM.InCombat] then
					if not DBM.Bosses[GetRealZoneText()][DBM.InCombat].minCombatTime or (GetTime() - DBM.CombatStartTime) > DBM.Bosses[GetRealZoneText()][DBM.InCombat].minCombatTime then
						if DBM.InCombat == "Souls" then
							DBM.Schedule(20, DBM.CheckForCombatEnd);
						else
							DBM.Schedule(10, DBM.CheckForCombatEnd);
						end
					end
				else
					DBM.Schedule(10, DBM.CheckForCombatEnd);
				end
			end
		end
		
		if (GetRealZoneText() == DBM_ASHENVALE)
		or (GetRealZoneText() == DBM_FERALAS)
		or (GetRealZoneText() == DBM_DUSKWOOD)
		or (GetRealZoneText() == DBM_HINTERLANDS)
		or (GetRealZoneText() == DBM_AZSHARA) then		
			if DBM.UnitExists(DBM_AZUREGOS_NAME)
			or DBM.UnitExists(DBM_OUTDOOR_YSONDRE)
			or DBM.UnitExists(DBM_OUTDOOR_EMERISS)
			or DBM.UnitExists(DBM_OUTDOOR_TAERAR)
			or DBM.UnitExists(DBM_OUTDOOR_LETHON) then
				LoadAddOn("DBM_Azeroth");
				DBM.LoadAddOns();
			end
		end
		
		if (GetRealZoneText() == DBM_SHADOWMOON)
		or (GetRealZoneText() == DBM_HELLFIRE) then
			if DBM.UnitExists(DBM_DOOMW_NAME)
			or DBM.UnitExists(DBM_KAZZAK_NAME) then
				LoadAddOn("DBM_Outlands");
				DBM.LoadAddOns();
			end
		end
	end
	for index, value in pairs(DBM.HideDNDAFKMessages) do
		if type(value) == "number" then
			DBM.HideDNDAFKMessages[index] = value - elapsed;
			if DBM.HideDNDAFKMessages[index] <= 0 then
				DBM.HideDNDAFKMessages[index] = false;
			end
		end
	end
	for index, value in pairs(DBM.HiddenWhisperMessages) do
		for index2, value2 in pairs(DBM.HiddenWhisperMessages[index]["targets"]) do
			if type(value2) == "number" then
				DBM.HiddenWhisperMessages[index]["targets"][index2] = value2 - elapsed;
				if DBM.HiddenWhisperMessages[index]["targets"][index2] <= 0 then
					DBM.HiddenWhisperMessages[index]["targets"][index2] = nil;
					local tableSize = 0;
					for index3, value3 in pairs(DBM.HiddenWhisperMessages[index]["targets"]) do
						tableSize = tableSize + 1;
					end
					if tableSize == 0 then
						DBM.HiddenWhisperMessages[index] = nil;
					end
				end
			end
		end
	end
	
	for index, value in pairs(modSpamTable) do
		if type(value) == "table" then
			for index2, value2 in pairs(value) do
				if type(value2) ~= "number" or (type(value2) == "number" and value2 <= 0) then
					value[index2] = nil;
				else
					value[index2] = value2 - elapsed;
				end
			end
		end
	end
	
	if not DBM.AddOns.Battlegrounds and MAX_BATTLEFIELD_QUEUES and PVP_TEAMSIZE then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status = GetBattlefieldStatus(i);
			if status == "confirm" then
				if LoadAddOn("DBM_Battlegrounds") then
					DBM.LoadAddOns()
					if DBM.AddOns.Battlegrounds and DBM.AddOns.Battlegrounds.OnUpdate then
						DBM.AddOns.Battlegrounds:OnUpdate(0)
					end
				end
			end
		end
	end
end



-------------------
--Timer Functions--
-------------------
function DBM.Schedule(timer, func, ...)
	if (type(timer) ~= "number") or (not func) then
		return
	end
	
	table.insert(DBM.ScheduleData, {
		["elapsed"] = 0,
		["timer"] = timer,
		["func"] = func,
		["args"] = {...},
	})
end


function DBM.UnSchedule(func, ...)
	if not func then
		return
	end
	
	for i = #DBM.ScheduleData, 1, -1 do
		local v = DBM.ScheduleData[i]
		if v.func == func then
			local match = true
			for j = 1, select("#", ...) do
				if not v.args[j] or v.args[j] ~= select(j, ...) then
					match = false
				end
			end
			if match then
				table.remove(DBM.ScheduleData, i)
			end
		end
	end	
end


function DBM.GetScheduleTimeLeft(func, ...)
	if not func then
		return
	end
	
	for i = #DBM.ScheduleData, 1, -1 do
		local v = DBM.ScheduleData[i]
		if v.func == func then
			local match = true
			for j = 1, select("#", ...) do
				if not v.args[j] or v.args[j] ~= select(j, ...) then
					match = false
				end
			end
			if match then
				return v.timer - v.elapsed
			end
		end
	end
	return false
end

function DBM.FunctionIsScheduled(func)
	return DBM.GetScheduleTimeLeft(func)
end

function DBM.StartTimer(name)
	if not name then
		return;
	end
	
	DBM.TimerData[name] = {
		["elapsed"] = 0,
		["stopped"] = false,
	};	
end


function DBM.GetTimer(name)
	if (not name) or (not DBM.TimerData[name]) then
		return 0;
	end
	
	return DBM.TimerData[name].elapsed;
end


function DBM.StopTimer(name)
	if (not name) or (not DBM.TimerData[name]) then
		return 0;
	end
	
	DBM.TimerData[name].stopped = true;
	return DBM.TimerData[name].elapsed;
end


function DBM.ResumeTimer(name)
	if (not name) or (not DBM.TimerData[name]) then
		return 0;
	end
	
	DBM.TimerData[name].stopped = false;
	return DBM.TimerData[name].elapsed;
end


function DBM.EndTimer(name)
	if (not name) or (not DBM.TimerData[name]) then
		return 0;
	end
	
	local elapsed = DBM.TimerData[name].elapsed;
	DBM.TimerData[name] = nil;
	return elapsed;
end


function DBM.StartStatusBarTimer(timer, name, icon, noBroadcast, syncedBy, startedBy, repeatingTimer, repetitions, colorR, colorG, colorB, colorA)
	if event == "CHAT_MSG_ADDON" and arg3 == "WHISPER" and not justSentBarRequest then
		return
	end
	
	--support for old API
	if (type(icon) == "boolean") or type(noBroadcast) == "string" or type(startedBy) == "number" or type(repeatingTimer) == "number" then
		local tmp, tmp2;
		tmp = noBroadcast;
		noBroadcast = icon;
		
		tmp2 = syncedBy;
		syncedBy = tmp;
		
		tmp = startedBy
		startedBy = tmp2;
		
		tmp2 = repeatingTimer;		
		repeatingTimer = tmp;

		repetitions = tmp2;
		icon = nil;
	end
	local _
	if type(icon) == "number" then
		_, _, icon = GetSpellInfo(icon)
	end

	timer = tonumber(timer) or timer;
	if type(timer) == "string" then
		local h, m, s, _;
		_, _, h, m, s = string.find(timer, "(%d+):(%d+):(%d+)");
		if not h or not m or not s then
			_, _, m, s = string.find(timer, "(%d+):(%d+)");
		end
		if not m or not s then
			_, _, h = string.find(timer, "(%d+)%s*h");
			_, _, m = string.find(timer, "(%d+)%s*m");
			_, _, s = string.find(timer, "(%d+)%s*s");
		end

		timer = 3600 * (tonumber(h) or 0) + 60 * (tonumber(m) or 0) + (tonumber(s) or 0);
		if timer == 0 then
			return;
		end
	end
	--
	
	if (type(timer) ~= "number") or (not name) or (name == "") or not DBM.Options.EnableStatusBars then
		return;
	end
	name = tostring(name);
	if syncedBy and select(2, IsInInstance()) == "pvp" then
		if not justSentBarRequest or not IsAddOnLoaded("DBM_Battlegrounds") then
			return
		end
	end
	if type(syncedBy) ~= "string" then
		syncedBy = DBM_LOCAL;
	else
        for index, value in pairs(DBM.FilteredBars) do
            if string.find(name, value) then
                return;
            end
        end
    end
	local barId, addon, newAddon;
	if DBM.StatusBarData[name] then
		barId = DBM.StatusBarData[name].barId;
	else
		for i=1, DBM.StatusBarCount do
			if not getglobal("DBM_StatusBarTimer"..i).isUsed then
				barId = i;
				break;
			end
		end	
		if not barId then
			barId = DBMStatusBars_CreateNewBar();
			if not barId then
				return;
			end
		end
	end	
	if not startedBy then
        _, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
        if type(addon) == "string" then
            addon = string.gsub(addon, "LV", "");
        else
            _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
            if type(addon) == "string" then
                addon = string.gsub(addon, "LV", "");
            else
                _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
                if type(addon) == "string" then
                    addon = string.gsub(addon, "LV", "");
                else
                    addon = "UNKNOWN";
                end
            end
        end
	else
		addon = startedBy;
	end
	addon = string.gsub(addon, " ", "");
	if addon == "ChatFrame" or addon == "API" or addon == "GUI" or addon == "StatusBars" or addon == "LootLink" then
		addon = "UNKNOWN";
	end
	local i = 1
	while getglobal("DBM_HugeBar"..i) do
		if getglobal("DBM_HugeBar"..i).usedBy == name then
			DBMStatusBars_EndImportantBar(getglobal("DBM_HugeBar"..i))
		end
		i = i + 1
	end
	if addon and addon ~= "UNKNOWN" and addon ~= "" then
		if DBM.AddOns[addon] and not DBM.AddOns[addon].Options.Enabled then
			return;
		elseif DBM.AddOns[addon] and DBM.AddOns[addon].Name then
			if DBM.AddOns[addon]["MinVersionToSync"] and syncedBy ~= DBM_LOCAL then	-- by Nitram!
				if not DBM.SyncInfo.Clients[syncedBy] or (tonumber(DBM.SyncInfo.Clients[syncedBy]) < tonumber(DBM.AddOns[addon]["MinVersionToSync"])) then
					return;
				end
			end
			if DBM.AddOns[addon]["MinRevision"] and syncedBy ~= DBM_LOCAL then	-- by Nitram!
--				DBM.AddMsg(DBM.AddOns[addon]["MinRevision"])
				if not DBM.SyncInfo.DispVers[syncedBy] or not DBM.SyncInfo.DispVers[syncedBy][2] or (tonumber(DBM.SyncInfo.DispVers[syncedBy][2]) < tonumber(DBM.AddOns[addon]["MinRevision"])) then
					return;
				end
			end
			if DBM.AddOns[addon].BarMenu then
				for i, v in ipairs(DBM.AddOns[addon].BarMenu) do
					if not DBM.AddOns[addon].Options[v.variable] then
						local exp = "^"..v.variable:sub(4).."$"
						if name:find(exp) then
							return
						end
					end					
				end
			end
			newAddon = DBM.AddOns[addon].Name;
		end
	end
	local specialColor, color;
	specialColor = false;
	if tonumber(colorR) and tonumber(colorG) and tonumber(colorB) then
		specialColor = true;
		color = {};
		color.R = tonumber(colorR);
		color.G = tonumber(colorG);
		color.B = tonumber(colorB);
		color.A = tonumber(colorA) or DBM.Options.StatusBarColor.a;
	end

	if getglobal("DBM_StatusBarTimer"..barId) then
		local syncedBar;
		if not noBroadcast or syncedBy ~= DBM_LOCAL then
			syncedBar = true;
		end
		if addon == "Battlegrounds"
		or addon == "Alterac"
		or addon == "Warsong"
		or addon == "Arathi"
		or addon == "Arenas"
		or addon == "EyeOfTheStorm" then
			syncedBar = true
		end
		DBM.StatusBarData[name] = {
			["elapsed"]	= 0,
			["timer"]	= timer,
			["barId"]	= barId,
			["syncedBy"]	= syncedBy,
			["startedBy"]	= newAddon,
			["isRepeating"]	= repeatingTimer or false,
			["repetitions"]	= repetitions or 300,
			["infinite"]	= (repetitions or 300) > 299,
			["bossModID"]	= addon,
			["color"] 	= color,
			["icon"] = icon,
			["syncedBar"] = syncedBar,
			["frame"]	= getglobal("DBM_StatusBarTimer"..barId),
		};
	
		if DBM.StatusBarData[name].frame.specialColor and not specialColor then 
			--we need to reset the color if we restart a timer with the same name...but without a specific color
			getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetStatusBarColor(
											DBM.Options.StatusBarColor.r, 
											DBM.Options.StatusBarColor.g, 
											DBM.Options.StatusBarColor.b, 
											DBM.Options.StatusBarColor.a
										   );
		end
		DBM.StatusBarData[name].frame.isUsed = true;
		DBM.StatusBarData[name].frame.usedBy = name;
		DBM.StatusBarData[name].frame.syncedBy = syncedBy;
		DBM.StatusBarData[name].frame.startedBy = newAddon;
		DBM.StatusBarData[name].frame.isRepeating = repeatingTimer or false;
		DBM.StatusBarData[name].frame.repetitions = repetitions or 1;
		DBM.StatusBarData[name].frame.specialColor = specialColor;
		getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetMinMaxValues(0, timer);
		DBM.StatusBarData[name].frame.table = DBM.StatusBarData[name];
		if type(DBM_SBT[name]) == "string" then
			getglobal(DBM.StatusBarData[name].frame:GetName().."BarText"):SetText(DBM_SBT[name]);

		elseif type(DBM_SBT[addon]) == "table" then
			-- Translation System for Bars with Dynamic Content "Injection: xxxx"
            local newName = name;
			for index, value in pairs(DBM_SBT[addon]) do
				newName = string.gsub(newName, value[1], value[2]);
			end
			getglobal(DBM.StatusBarData[name].frame:GetName().."BarText"):SetText(newName);

		else
			getglobal(DBM.StatusBarData[name].frame:GetName().."BarText"):SetText(name);
		end

		getglobal(DBM.StatusBarData[name].frame:GetName().."BarTimer"):SetText(DBM.SecondsToTime(timer));
		if specialColor then
			getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetStatusBarColor(color.R, color.G, color.B, color.A);
		end
		
		if icon and DBM.Options.ShowIcon and getglobal(DBM.StatusBarData[name].frame:GetName().."Icon") then
			getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):SetTexture(""); --clear texture because we don't want to see the old icon if the new texture does not exist
			getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):SetTexture(icon);
			getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):Show();
		end
		
		getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetAlpha(1);
		DBM.StatusBarData[name].frame:SetAlpha(1);
		DBM.StatusBarData[name].frame:Show();

	end
	if not noBroadcast then
		if icon then
			
			if specialColor then
				if repeatingTimer then
					DBM.AddSyncMessage("SIRPCSBT "..timer.." "..DBM.StatusBarData[name].repetitions.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." #"..icon.."# "..name);
				else
					DBM.AddSyncMessage("SICSBT "..timer.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." #"..icon.."# "..name);
				end
			else
				if repeatingTimer then
					DBM.AddSyncMessage("SIRPSBT "..timer.." "..DBM.StatusBarData[name].repetitions.." "..addon.." #"..icon.."# "..name);
				else
					DBM.AddSyncMessage("STISBT "..timer.." "..addon.." #"..icon.."# "..name);
				end
			end
		else
			if specialColor then
				if repeatingTimer then
					DBM.AddSyncMessage("STRPCSBT "..timer.." "..DBM.StatusBarData[name].repetitions.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." "..name);
				else
					DBM.AddSyncMessage("STCSBT "..timer.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." "..name);
				end
			else
				if repeatingTimer then
					DBM.AddSyncMessage("STRPSBT "..timer.." "..DBM.StatusBarData[name].repetitions.." "..addon.." "..name);
				else
					DBM.AddSyncMessage("STSBT "..timer.." "..addon.." "..name);
				end
			end
		end
	end	
end

function DBM.StartRepeatingStatusBarTimer(timer, name, icon, repetitions, noBroadcast, syncedBy, startedBy)
	DBM.StartStatusBarTimer(timer, name, icon, noBroadcast, syncedBy, startedBy, true, repetitions)
end

function DBM.StartColoredStatusBarTimer(timer, name, icon, colorR, colorG, colorB, colorA, noBroadcast, syncedBy, startedBy)
	colorR = tonumber(colorR);
	colorG = tonumber(colorG);
	colorB = tonumber(colorB);
	colorA = tonumber(colorA) or DBM.Options.StatusBarColor.a;
	DBM.StartStatusBarTimer(timer, name, icon, noBroadcast, syncedBy, startedBy, nil, nil, colorR, colorG, colorB, colorA);
end

function DBM.StartRepeatingColoredStatusBarTimer(timer, name, icon, repetitions, colorR, colorG, colorB, colorA, noBroadcast, syncedBy, startedBy)
	colorR = tonumber(colorR);
	colorG = tonumber(colorG);
	colorB = tonumber(colorB);
	colorA = tonumber(colorA) or 1;
	DBM.StartStatusBarTimer(timer, name, icon, noBroadcast, syncedBy, startedBy, true, repetitions, colorR, colorG, colorB, colorA);
end

function DBM.EndRepeatingStatusBarTimer(name, noBroadcast, syncedBy)
	if type(syncedBy) == "string" and DBM.SyncInfo.Clients and DBM.SyncInfo.Clients[syncedBy] and tonumber(DBM.SyncInfo.Clients[syncedBy]) < 2.61 then
		return;
	end
	DBM.EndStatusBarTimer(name, noBroadcast, syncedBy, true)
end

function DBM.GetStatusBarTimerTimeLeft(name)
	if (not name) or (not DBM.StatusBarData[name]) then
		return false;
	end
	
	return (DBM.StatusBarData[name].timer - DBM.StatusBarData[name].elapsed), DBM.StatusBarData[name].elapsed, DBM.StatusBarData[name].syncedBy;
end


function DBM.EndStatusBarTimer(name, noBroadcast, syncedBy, endRepeating, dontEndHugeBar)
	if event == "CHAT_MSG_ADDON" and arg3 == "WHISPER" and not justSentBarRequest then
		return
	end
	
	if not dontEndHugeBar then
		local i = 1
		while getglobal("DBM_HugeBar"..i) do
			if getglobal("DBM_HugeBar"..i).usedBy == name then
				DBMStatusBars_EndImportantBar(getglobal("DBM_HugeBar"..i))
			end
			i = i + 1
		end
	end
	if (not name) or (not DBM.StatusBarData[name]) then
		return;
	end
	

	
	if syncedBy and (not DBM.SyncInfo.Clients[syncedBy]) then
		return;
	end
	
	local timeLeft, elapsed = DBM.GetStatusBarTimerTimeLeft(name);
	if syncedBy and elapsed < 3 and (not (endRepeating or DBM.StatusBarData[name].isRepeating)) then --don't stop new timers on sync!
		return;
	end
	
	if syncedBy and DBM.StatusBarData[name].isRepeating 
	and (not endRepeating) 
	and ((not DBM.SyncInfo.Clients[syncedBy]) or (DBM.SyncInfo.Clients[syncedBy] 
	and tonumber(DBM.SyncInfo.Clients[syncedBy]) < 1.60)) then
		return;
	end
	
	if DBM.StatusBarData[name].isRepeating and not endRepeating then
		DBM.StatusBarData[name].repetitions = DBM.StatusBarData[name].repetitions - 1
		if DBM.StatusBarData[name].repetitions <= 0 then
			DBM.EndStatusBarTimer(name, true, nil, true);
			return;
		else
			getglobal("DBM_StatusBarTimer"..DBM.StatusBarData[name].barId).repetitions = DBM.StatusBarData[name].repetitions;
			DBM.StatusBarData[name].elapsed = 0;
		end
	else
		if DBM.StatusBarData[name].frame then
			if DBM.StatusBarData[name].isFlashing then
				UIFrameFadeRemoveFrame(DBM.StatusBarData[name].frame);
				UIFrameFlashRemoveFrame(DBM.StatusBarData[name].frame);
				DBM.StatusBarData[name].frame:SetAlpha(1.0);
				DBM.StatusBarData[name].frame.flashTimer = nil;
				DBM.StatusBarData[name].frame.fadeInTime = nil;
				DBM.StatusBarData[name].frame.fadeOutTime = nil;
				DBM.StatusBarData[name].frame.flashDuration = nil;
				DBM.StatusBarData[name].frame.showWhenDone = nil;
				DBM.StatusBarData[name].frame.flashTimer = nil;
				DBM.StatusBarData[name].frame.flashMode = nil;
				DBM.StatusBarData[name].frame.flashInHoldTime = nil;
				DBM.StatusBarData[name].frame.flashOutHoldTime = nil;
				DBM.StatusBarData[name].frame.fadeInfo = nil;
				DBM.StatusBarData[name].isFlashing = nil;
				DBM.StatusBarData[name].frame.fading = nil;
			end
			DBM.StatusBarData[name].frame:Hide();
			DBM.StatusBarData[name].frame.isUsed = false;
			DBM.StatusBarData[name].frame.syncedBy = "UNKNOWN";
			DBM.StatusBarData[name].frame.startedBy = "UNKNOWN";
			DBM.StatusBarData[name].frame.usedBy = "";
			DBM.StatusBarData[name].frame.isRepeating = false;
			DBM.StatusBarData[name].frame.repetitions = 0;
			DBM.StatusBarData[name].frame.table = nil;
			DBM.StatusBarData[name].frame.specialColor = false;	
			DBM.StatusBarData[name].frame.fading = nil;
			getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a);
			getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):Hide();
			DBM.StatusBarData[name] = nil;
		end
		
		if not noBroadcast then
			if endRepeating then
				DBM.AddSyncMessage("ENDRPSBT "..name);
			else
				DBM.AddSyncMessage("ENDSBT "..name);
			end
		end
		
		DBMStatusBars_PullTogether();
	end
end

function DBM.UpdateStatusBarTimer(name, elapsed, timer, newName, newIcon, noBroadcast)
	if event == "CHAT_MSG_ADDON" and arg3 == "WHISPER" and not justSentBarRequest then
		return
	end
	
	if type(newIcon) == "boolean" and noBroadcast == nil then
		noBroadcast = newIcon;
		newIcon = nil;
	end
	
	if (not name) or (not DBM.StatusBarData[name]) or (not DBM.StatusBarData[name].frame) then
		return;
	end
	if newName and DBM.StatusBarData[newName] then
		return;
	end
	local addon;
	if not startedBy then
		_, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
        if type(addon) == "string" then
            addon = string.gsub(addon, "LV", "");
        else
            _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
            if type(addon) == "string" then
                addon = string.gsub(addon, "LV", "");
            else
                _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
                if type(addon) == "string" then
                    addon = string.gsub(addon, "LV", "");
                else
                    addon = "UNKNOWN";
                end
            end
        end
	else
		addon = startedBy;
	end
	addon = string.gsub(addon, " ", "");
	if addon == "ChatFrame" or addon == "DBM_API" or addon == "DBM_GUI" or addon == "DBM_StatusBars" or addon == "LootLink" then
		addon = "UNKNOWN";
	end

	if addon and addon ~= "UNKNOWN" and addon ~= "" then
		if DBM.AddOns[addon] and not DBM.AddOns[addon].Options.Enabled then
			return;
		end
	end
	

	if type(newName) == "string" then
		DBM.StatusBarData[name].frame.usedBy = newName;
		if type(DBM_SBT[newName]) == "string" then
			getglobal(DBM.StatusBarData[name].frame:GetName().."BarText"):SetText(DBM_SBT[newName]);

		elseif type(DBM_SBT[addon]) == "table" then
			-- Translation System for Bars with Dynamic Content "Injection: xxxx"
			for index, value in pairs(DBM_SBT[addon]) do
				newName = string.gsub(newName, value[1], value[2]);
			end
			getglobal(DBM.StatusBarData[name].frame:GetName().."BarText"):SetText(newName);

		else
			getglobal(DBM.StatusBarData[name].frame:GetName().."BarText"):SetText(newName);
		end
	end
	if tonumber(timer) then		
		getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetMinMaxValues(0, timer);			
		DBM.StatusBarData[name].timer = timer;
	else
		timer = DBM.StatusBarData[name].timer;
	end
	if tonumber(elapsed) then		
		getglobal(DBM.StatusBarData[name].frame:GetName().."BarTimer"):SetText(DBM.SecondsToTime(elapsed));
		getglobal(DBM.StatusBarData[name].frame:GetName().."Bar"):SetValue(tonumber(elapsed));
		DBM.StatusBarData[name].elapsed = tonumber(elapsed);
	end	
	if type(newIcon) == "string" and newIcon ~= "nil" then
		getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):SetTexture("");
		getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):SetTexture(newIcon);
		getglobal(DBM.StatusBarData[name].frame:GetName().."Icon"):Show();
		DBM.StatusBarData[name].icon = newIcon;
	end
	if type(newName) == "string" then
		DBM.StatusBarData[newName] = DBM.StatusBarData[name];
		DBM.StatusBarData[name] = nil;
		if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == (DBM_SBT[name] or name) then
			GameTooltip:Hide();
			GameTooltip:ClearLines();
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
			GameTooltip:SetText(getglobal("DBM_StatusBarTimer"..DBM.StatusBarData[newName].barId.."BarText"):GetText());
			GameTooltip:AddDoubleLine(DBM_SBT_TIMELEFT, DBM.SecondsToTime(tonumber(timer) - DBM.StatusBarData[newName].elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddDoubleLine(DBM_SBT_TIMEELAPSED, DBM.SecondsToTime(DBM.StatusBarData[newName].elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddDoubleLine(DBM_SBT_TOTALTIME, DBM.SecondsToTime(timer), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			if DBM.StatusBarData[newName].isRepeating and DBM.StatusBarData[newName].repetitions then
				if DBM.StatusBarData[newName].infinite then
					GameTooltip:AddDoubleLine(DBM_SBT_REPETITIONS, DBM_SBT_INFINITE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				else
					GameTooltip:AddDoubleLine(DBM_SBT_REPETITIONS, DBM.StatusBarData[newName].repetitions, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				end
			end
			if DBM.StatusBarData[newName].startedBy and DBM.StatusBarData[newName].startedBy ~= "UNKNOWN" then
				GameTooltip:AddDoubleLine(DBM_SBT_BOSSMOD, DBM.StatusBarData[newName].startedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if DBM.StatusBarData[newName].syncedBy and DBM.StatusBarData[newName].syncedBy ~= DBM_LOCAL then	
				GameTooltip:AddDoubleLine(DBM_SBT_STARTEDBY, DBM.StatusBarData[newName].syncedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			else
				GameTooltip:AddDoubleLine(DBM_SBT_STARTEDBY, UnitName("player"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			GameTooltip:AddLine(DBM_SBT_RIGHTCLICK, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			GameTooltip:Show();
		end
	end
	
	if not noBroadcast then
		DBM.AddSyncMessage("UPDISBT #"..tostring(name).."# "..tostring(elapsed).." "..tostring(timer).." #"..tostring(newIcon).."# "..tostring((newName or name)));
	end
end



---------------------
--Message Functions--
---------------------
local lastWarning
local lastWarningTime = GetTime()
function DBM.Announce(Warning, localWarning, addon, forceAnnounce, color)
	if Warning == lastWarning then
		if (GetTime() - lastWarningTime) < 1 then
			return;
		end
	end
	if not color then
		color = 1
	end
	lastWarning = Warning;
	lastWarningTime = GetTime();
	if type(addon) ~= "string" then -- support for old mods (most pre Burning Crusade mods)
		_, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
		if type(addon) == "string" then
			addon = string.gsub(addon, "LV", "");
		else
			_, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
			if type(addon) == "string" then
				addon = string.gsub(addon, "LV", "");
			else
				_, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
				if type(addon) == "string" then
					addon = string.gsub(addon, "LV", "");
				else
					addon = "";
				end
			end
		end
	end

	Warning = Warning:gsub("^%*%*%*%*? ", "")
	Warning = Warning:gsub(" %*%*%*%*?$", "")
	if color == 1 then
		Warning = ("*** %s ***"):format(Warning)
	elseif color == 2 then
		Warning = ("***  %s  ***"):format(Warning)
	elseif color == 3 then
		Warning = (" *** %s *** "):format(Warning)
	elseif color == 4 then
		Warning = ("  *** %s ***  "):format(Warning)
	elseif color == 5 then
		Warning = ("  ***  %s  ***  "):format(Warning)
	end

	if (DBM.AddOns[addon] and DBM.AddOns[addon].Options.Announce and (DBM.Rank >= 1 or (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0)) and not localWarning) or (forceAnnounce and (DBM.Rank >= 1 or IsPartyLeader())) then
		SendChatMessage(Warning, "RAID_WARNING");
	end
	
	if DBM.Options.Gui["SelfWarning_Enable"] then
		RaidWarningFrames_AddLocalMessages(Warning, true);
	end
end


function DBM.AddMsg(msg, addon, noHookedChatFrame)
	if type(addon) ~= "string" then
		_, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
		if type(addon) == "string" then
			addon = string.gsub(addon, "LV", "");
		else        
			_, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
			if type(addon) == "string" then
				addon = string.gsub(addon, "LV", "");
			else
				_, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
				if type(addon) == "string" then
					addon = string.gsub(addon, "LV", "");
				else
					addon = "Deadly Boss Mods";
				end
			end
		end
	end
	if addon == "ChatFrame" or addon == "API" or addon == "Load" or addon == "GUI" or addon == "StatusBars" or addon == "LootLink" then
		addon = "Deadly Boss Mods";
	end
	if noHookedChatFrame and DBM.Hooks.oldChatFrame_AddMessage and DEFAULT_CHAT_FRAME then
		DBM.Hooks.oldChatFrame_AddMessage(ChatFrame1, "|cffff7d0a<|r|cffffd200"..addon.."|r|cffff7d0a>|r "..tostring(msg), 0.41, 0.8, 0.94);
	elseif DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage("|cffff7d0a<|r|cffffd200"..addon.."|r|cffff7d0a>|r "..tostring(msg), 0.41, 0.8, 0.94);
	end	
end

function DBM.SendHiddenWhisper(msg, target)
	if not msg or not target then return; end
	if msg == "" or target == "" then return; end
	DBM.HiddenWhisperMessages[string.gsub(msg, "%%", "")] = DBM.HiddenWhisperMessages[string.gsub(msg, "%%", "")] or {["targets"] = {}};
	DBM.HiddenWhisperMessages[string.gsub(msg, "%%", "")]["targets"][target] = 1;
	DBM.HideDNDAFKMessages[target] = 1;
	SendChatMessage(msg, "WHISPER", nil, target);
end

function DBM.InterceptWhisper(msg, player, flag)
	if not DBM.InCombat 
	or not DBM.HideWhispers 	
	or not DBM.Options.AutoRespond 
	or string.sub(msg, 1, 18) == "<Deadly Boss Mods>"
	or string.sub(msg, 1, 20) == "<Vendetta Boss Mods>"
	or string.sub(msg, 1, 4) == "GA\\t"
	or flag == "GM"	then
		return "SHOW";
	end
	if string.lower(msg) == "status" and DBM.Options.EnableStatusCommand then
		return "FORCE_HIDE";
	end
	if not DBM.Raid[player] then
		if DBM.WhisperSpamProtection[player] and (GetTime() - DBM.WhisperSpamProtection[player]) < 60 then
			DBM.WhisperSpamProtection[player] = GetTime();
			
			if not DBM.WhispersDuringCombat[table.getn(DBM.WhispersDuringCombat)] or not (DBM.WhispersDuringCombat[table.getn(DBM.WhispersDuringCombat)].name == player and DBM.WhispersDuringCombat[table.getn(DBM.WhispersDuringCombat)].msg == msg and (time() - DBM.WhispersDuringCombat[table.getn(DBM.WhispersDuringCombat)].time) <= 2) then
				table.insert(DBM.WhispersDuringCombat, {["name"] = player, ["msg"] = msg, ["time"] = time(), ["hidden"] = not DBM.Options.ShowWhispersDuringCombat})
			end
			return "HIDE";
		end
		if DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][DBM.InCombat] then
			DBM.WhisperSpamProtection[player] = GetTime();
			local message = DBM.Options.BusyMessage;
			message = string.gsub(message, "%%P", UnitName("player"));
			message = string.gsub(message, "%%B", tostring((DBM.Bosses[GetRealZoneText()][DBM.InCombat].realName or DBM.Bosses[GetRealZoneText()][DBM.InCombat].name)));
			message = string.gsub(message, "%%HP", DBM.GetBossHP(DBM.Bosses[GetRealZoneText()][DBM.InCombat].name));
			message = string.gsub(message, "%%ALIVE", DBM.GetNumRaidMembersAlive());
			message = string.gsub(message, "%%RAID", tostring(GetNumRaidMembers()));
			if DBM.Options.EnableStatusCommand then
				message = message;
			end
			if DBM.Options.HideOutgoingInfoWhisper then		
				DBM.SendHiddenWhisper("<Deadly Boss Mods> "..message, player);
			else
				SendChatMessage("<Deadly Boss Mods> "..message, "WHISPER", nil, player);
			end
			table.insert(DBM.WhispersDuringCombat, {["name"] = player, ["msg"] = msg, ["time"] = time(), ["hidden"] = not DBM.Options.ShowWhispersDuringCombat})
			return "AUTO_RESPONDED";
		else
			return "SHOW";
		end
	else
		return "SHOW";
	end
end

function DBM.EndHideWhispers(bossName)
	if not DBM.HideWhispers then
		return;
	end
	local playersToInform = {};
	local infoString = "";	
	local missedWhispersInfoShown = false;	

	for index, value in pairs(DBM.WhispersDuringCombat) do
		if value.name and not playersToInform[value.name] then
			playersToInform[value.name] = true;
		end
		if value.hidden then
			if not missedWhispersInfoShown then
				DBM.AddMsg(DBM_MISSED_WHISPERS);
				missedWhispersInfoShown = true;
			end
			DBM.AddMsg(string.format(DBM_SHOW_MISSED_WHISPER, value.name, value.msg), date("%H:%M:%S", value.time));
		end
	end
	
	if DBM.InCombat and not bossName and DBM.Options.ShowCombatInformations and DBM.SecondsToTime(GetTime() - DBM.CombatStartTime) and DBM.SecondsToTime(GetTime() - DBM.CombatStartTime) ~= "" then
		DBM.AddMsg(string.format(DBM_COMBAT_ENDED, DBM.SecondsToTime((GetTime() - DBM.CombatStartTime), true)));
	end
	
	if bossName then
		if DBM.InCombat and DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][DBM.InCombat] and DBM.Bosses[GetRealZoneText()][DBM.InCombat].realName then
			infoString = string.format(DBM_BOSS_DOWN, DBM.Bosses[GetRealZoneText()][DBM.InCombat].realName, DBM.SecondsToTime((GetTime() - DBM.CombatStartTime), true))
		else
			infoString = string.format(DBM_BOSS_DOWN, bossName, DBM.SecondsToTime((GetTime() - DBM.CombatStartTime), true))
		end
	else
		infoString = string.format(DBM_COMBAT_ENDED, DBM.SecondsToTime((GetTime() - DBM.CombatStartTime), true));
	end
	
	for index, value in pairs(playersToInform) do		
		DBM.SendHiddenWhisper("<Deadly Boss Mods> "..infoString, index);
	end
	
	for i, v in pairs(DBM.WhispersDuringCombat) do
		DBM.WhispersDuringCombat[i] = nil
	end
	DBM.HideWhispers = false;
end

--------------------
--Special Warnings--
--------------------
function DBM.AddSpecialWarning(text, shake, flash)
	if not DBM.Options.SpecialWarningsEnabled then
		return;
	end
	if type(text) ~= "string" then
		text = "";
	end
	if shake == nil then
		shake = true;
	end
	if flash == nil then
		flash = true;
	end
	if shake and DBM.Options.ShakeEnabled then
		DBM.ShakeScreen()
	end
	if flash and DBM.Options.FlashEnabled then
		DBM.IsFlashing = DBM.Options.FlashDuration * DBM.Options.NumFlashes;
		if DBM.Options.FlashColor == "red" then
			DBM.RedFlash = DBM.Options.FlashDuration;
			DBM.BlueFlash = false;
			LowHealthFrame:SetAlpha(0);
		elseif DBM.Options.FlashColor == "blue" then
			DBM.BlueFlash = DBM.Options.FlashDuration;
			DBM.RedFlash = false;
			DBMBlueFlashFrame:SetAlpha(0);
		end
	end
	if text ~= "" then
		DBMSpecialWarningFrameText:SetTextColor(DBM.Options.SpecialWarningTextColor.r, DBM.Options.SpecialWarningTextColor.g, DBM.Options.SpecialWarningTextColor.b, DBM.Options.SpecialWarningTextColor.a);
		DBMSpecialWarningFrameText:SetText(text);
		DBM.SpecialWarningTextIsFadingIn = 1;
		DBMSpecialWarningFrame:SetAlpha(0);
		DBMSpecialWarningFrame:Show();
		DBM.SpecialWarningTextIsShown = DBM.Options.SpecialWarningTextDuration;
		DBM.SpecialWarningTextIsFading = false;
	end
end

local oldWorldFramePoints = {}
function DBM.ShakeScreen()
	if not DBM.IsShaking then
		for i, v in pairs(oldWorldFramePoints) do
			oldWorldFramePoints[i] = nil
		end
		for i = 1, WorldFrame:GetNumPoints() do
			local point, frame, relPoint, xOffset, yOffset = WorldFrame:GetPoint(i);
			oldWorldFramePoints[i] = {
				["point"] = point,
				["frame"] = frame,
				["relPoint"] = relPoint,
				["xOffset"] = xOffset,
				["yOffset"] = yOffset,
			}
		end
		DBM.IsShaking = DBM.Options.ShakeDuration;
	end
end

function DBM.SpecialWarningsOnUpdate(elapsed)
	if type(DBM.IsShaking) == "number" then
		DBM.IsShaking = DBM.IsShaking - elapsed;
		if DBM.IsShaking <= 0 then
			DBM.IsShaking = false;
			WorldFrame:ClearAllPoints();
			for index, value in pairs(oldWorldFramePoints) do
				WorldFrame:SetPoint(value.point, value.xOffset, value.yOffset);
			end
		else
			WorldFrame:ClearAllPoints();
			local moveBy;
			moveBy = math.random(-100, 100)/(101 - DBM.Options.ShakeIntensity);
			for index, value in pairs(oldWorldFramePoints) do
				WorldFrame:SetPoint(value.point, value.xOffset + moveBy, value.yOffset + moveBy);
			end
		end
	end
	if type(DBM.SpecialWarningTextIsShown) == "number" then
		DBM.SpecialWarningTextIsShown = DBM.SpecialWarningTextIsShown - elapsed;
		if DBM.SpecialWarningTextIsShown <= DBM.Options.SpecialWarningTextFadeTime then
			DBM.SpecialWarningTextIsShown = false;
			DBM.SpecialWarningTextIsFading = DBM.Options.SpecialWarningTextFadeTime;
		end
	end
	if type(DBM.SpecialWarningTextIsFading) == "number" then
		DBM.SpecialWarningTextIsFading = DBM.SpecialWarningTextIsFading - elapsed;		
		if DBM.SpecialWarningTextIsFading <= 0 then
			DBMSpecialWarningFrame:Hide();
			DBMSpecialWarningFrameText:SetText("");
			DBMSpecialWarningFrame:SetAlpha(1);
			DBM.SpecialWarningTextIsFading = false;
			DBM.SpecialWarningTextIsShown = false;
		else
			DBMSpecialWarningFrame:SetAlpha(DBMSpecialWarningFrame:GetAlpha() - 1/(DBM.SpecialWarningTextIsFading * GetFramerate()));
		end
	end
	if type(DBM.IsFlashing) == "number" then
		DBM.IsFlashing = DBM.IsFlashing - elapsed;		
		if DBM.IsFlashing <= 0 then
			DBM.IsFlashing = false;
			DBM.RedFlash = false;
			DBM.BlueFlash = false;
			LowHealthFrame:Hide();
			LowHealthFrame:SetAlpha(1);
			DBMBlueFlashFrame:Hide();
			DBMBlueFlashFrame:SetAlpha(1);
		end
	end
	if type(DBM.RedFlash) == "number" then
		DBM.RedFlash = DBM.RedFlash - elapsed;		
		if DBM.RedFlash <= 0 then
			DBM.RedFlash = DBM.Options.FlashDuration;
			LowHealthFrame:SetAlpha(0);
		elseif DBM.RedFlash >= (DBM.Options.FlashDuration*(2/3)) then
			if not LowHealthFrame:IsShown() then
				LowHealthFrame:SetAlpha(0);
				LowHealthFrame:Show();
			end
			LowHealthFrame:SetAlpha(LowHealthFrame:GetAlpha() + 1/((DBM.RedFlash - (DBM.Options.FlashDuration*(2/3))) * GetFramerate()));
		elseif DBM.RedFlash < (DBM.Options.FlashDuration/3) then
			LowHealthFrame:SetAlpha(LowHealthFrame:GetAlpha() - 1/(DBM.RedFlash * GetFramerate()));
		else
			LowHealthFrame:SetAlpha(1)
		end
	end
	if type(DBM.BlueFlash) == "number" then
		DBM.BlueFlash = DBM.BlueFlash - elapsed;		
		if DBM.BlueFlash <= 0 then
			DBM.BlueFlash = DBM.Options.FlashDuration;
			DBMBlueFlashFrame:SetAlpha(0);
		elseif DBM.BlueFlash >= (DBM.Options.FlashDuration*(2/3)) then
			if not DBMBlueFlashFrame:IsShown() then
				DBMBlueFlashFrame:SetAlpha(0);
				DBMBlueFlashFrame:Show();
			end
			DBMBlueFlashFrame:SetAlpha(DBMBlueFlashFrame:GetAlpha() + 1/((DBM.BlueFlash - (DBM.Options.FlashDuration*(2/3))) * GetFramerate()));
		elseif DBM.BlueFlash < (DBM.Options.FlashDuration/2) then
			DBMBlueFlashFrame:SetAlpha(DBMBlueFlashFrame:GetAlpha() - 1/(DBM.BlueFlash * GetFramerate()));
		else
			DBMBlueFlashFrame:SetAlpha(1);
		end
	end
	if type(DBM.SpecialWarningTextIsFadingIn) == "number" then
		DBM.SpecialWarningTextIsFadingIn = DBM.SpecialWarningTextIsFadingIn - elapsed;
		if DBM.SpecialWarningTextIsFadingIn <= 0 then
			DBM.SpecialWarningTextIsFadingIn = false;
			DBMSpecialWarningFrame:SetAlpha(1);
		else
			DBMSpecialWarningFrame:SetAlpha(DBMSpecialWarningFrame:GetAlpha() + 1/(DBM.SpecialWarningTextIsFadingIn * GetFramerate()));
		end
	end
end

function DBM.HasAggro(mob)
	if DBM.Options.CharSettings[UnitName("player")].AggroSound then
		PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav");
	end
	
	if DBM.Options.CharSettings[UnitName("player")].AggroSpecialWarning then
		DBM.AddSpecialWarning(DBM_AGGRO_FROM..mob, DBM.Options.CharSettings[UnitName("player")].AggroShake, DBM.Options.CharSettings[UnitName("player")].AggroFlash)
	else
		DBM.AddSpecialWarning("", DBM.Options.CharSettings[UnitName("player")].AggroShake, DBM.Options.CharSettings[UnitName("player")].AggroFlash)
	end
	
	if DBM.Options.CharSettings[UnitName("player")].AggroLocalWarning then
		if (DBM.Options.Gui ~= nil) then
			DBMWarningFrame:AddMessage(DBM_AGGRO_FROM..mob, DBM.Options.Gui["SelfWarning_R"], DBM.Options.Gui["SelfWarning_G"], DBM.Options.Gui["SelfWarning_B"], DBM.Options.Gui["SelfWarning_Delay"]);
		else
			DBMWarningFrame:AddMessage(DBM_AGGRO_FROM..mob);
		end
	end
end

-----------------------------
--Synchronization Functions--
-----------------------------

function DBM.AddSyncMessage(msg, noSpamProt)
	if not DBM.Options.EnableSync and not string.find(msg, "VER") then
		return;
	end
	local _, instanceType = IsInInstance()
	
	if type(msg) == "string" and (not DBM.SpamProtection[msg]) then		
		if noSpamProt then
			if instanceType == "pvp" then
				SendAddonMessage("LVBM NSP", msg, "BATTLEGROUND")
			else
				if GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 then
					SendAddonMessage("LVBM NSP", msg, "PARTY")
				else
					SendAddonMessage("LVBM NSP", msg, "RAID")
				end
			end
		else
			if instanceType == "pvp" then
				SendAddonMessage("LVBM", msg, "BATTLEGROUND")
			else
				if GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 then
					SendAddonMessage("LVBM", msg, "PARTY")
				else
					SendAddonMessage("LVBM", msg, "RAID")
				end
			end
			DBM.SpamProtection[msg] = 1.5
		end
	end
end

local syncArgs = {}
function DBM.OnSyncMessage(msg, player, noSpamProt)
	if msg:find("\124") then return end
	if not DBM.Options.EnableSync and not (string.find(msg, "VER") or string.find(msg, "ENDALL")) then
		return;
	end
	if not player or not DBM.Raid[player] then -- only accept syncs from players in the raid group
		return;
	end
	
	if not DBM.Options.AllowSyncFromOldVersions then
		if ((tonumber(DBM.SyncInfo.Clients[player]) or 0) < (tonumber(DBM.Version) or 0)) and msg ~= "ENDALL" and not msg:find("VER") then
			return;
		end
	end
	
	if type(msg) == "string" and msg ~= "" and msg ~= " " and (not DBM.SpamProtection[msg]) then		
		if not noSpamProt then
			DBM.SpamProtection[msg] = 1.5;
		end	
		
		local name, color, colorR, colorG, colorB, colorA, icon;
		for i, v in pairs(syncArgs) do
			syncArgs[i] = nil
		end
		for value in string.gmatch(msg, "([^%s]+)") do
			table.insert(syncArgs, value);
		end
		
		if not DBM.SyncInfo.Clients[player] then
			DBM.SyncInfo.Clients[player] = "2.10";
		end

		if syncArgs[1] == "STSBT" then
			_, _, _, _, _, name = string.find(msg, "([^%s]+) ([%d%.]+) ([^%s]+) (.*)");
			if not name then
				return;
			end
			
			local timeLeft, timeElapsed = DBM.GetStatusBarTimerTimeLeft(name);
			local totalTime = (timeLeft or 0) + (timeElapsed or 0);
			if tonumber(syncArgs[2]) and syncArgs[3] and (not DBM.GetStatusBarTimerTimeLeft(name) or (timeElapsed or 0)/(totalTime or 0) > 0.85) then
				DBM.StartStatusBarTimer(tonumber(syncArgs[2]), name, nil, true, player, syncArgs[3]);
			end
		elseif syncArgs[1] == "STISBT" then
			_, _, _, _, _, icon, name = string.find(msg, "([^%s]+) ([%d%.]+) ([^%s]+) #(.+)# (.+)");
			if not name or not icon then
				return;
			end
			
			local timeLeft, timeElapsed = DBM.GetStatusBarTimerTimeLeft(name);
			local totalTime = (timeLeft or 0) + (timeElapsed or 0);
			if tonumber(syncArgs[2]) and syncArgs[3] and (not DBM.GetStatusBarTimerTimeLeft(name) or (timeElapsed or 0)/(totalTime or 0) > 0.85) then
				DBM.StartStatusBarTimer(tonumber(syncArgs[2]), name, icon, true, player, syncArgs[3]);
			end
		elseif syncArgs[1] == "ENDSBT" then
			_, _, _, name = string.find(msg, "([^%s]+) (.*)");
			
			local timeLeft, timeElapsed = DBM.GetStatusBarTimerTimeLeft(name or "");

			if name and (timeElapsed or 0) > 2 then
				DBM.EndStatusBarTimer(name, true, player);
			end
		elseif syncArgs[1] == "STRPSBT" then
			_, _, _, _, _, _, name = string.find(msg, "([^%s]+) ([%d%.]+) ([%d%.]+) ([^%s]+) (.*)");
			if not name then
				return;
			end
			if tonumber(syncArgs[2]) and tonumber(syncArgs[3]) and syncArgs[4] and (not DBM.GetStatusBarTimerTimeLeft(name)) then
				DBM.StartRepeatingStatusBarTimer(tonumber(syncArgs[2]), name, nil, tonumber(syncArgs[3]), true, player, syncArgs[4]);
			end
		elseif syncArgs[1] == "SIRPSBT" then
			_, _, _, _, _, _, icon, name = string.find(msg, "([^%s]+) ([%d%.]+) ([%d%.]+) ([^%s]+) #(.+)# (.*)");
			if not name or not icon then
				return;
			end
			if tonumber(syncArgs[2]) and tonumber(syncArgs[3]) and syncArgs[4] and (not DBM.GetStatusBarTimerTimeLeft(name)) then
				DBM.StartRepeatingStatusBarTimer(tonumber(syncArgs[2]), name, icon, tonumber(syncArgs[3]), true, player, syncArgs[4]);
			end
		elseif syncArgs[1] == "ENDRPSBT" then
			_, _, _, name = string.find(msg, "([^%s]+) (.*)");
			
			local timeLeft, timeElapsed = DBM.GetStatusBarTimerTimeLeft(name or "");

			if name and (timeElapsed or 0) > 2 then
				DBM.EndRepeatingStatusBarTimer(name, true, player);
			end
		elseif syncArgs[1] == "STCSBT" then
			_, _, _, _, _, color, name = string.find(msg, "([^%s]+) ([%d%.]+) ([^%s]+) ([^%s]+) (.*)");
			if not name or not color then
				return;
			end
			_, _, colorR, colorG, colorB, colorA = string.find(color, "([%d%.]+)~([%d%.]+)~([%d%.]+)~([%d%.]+)");
			
			if tonumber(syncArgs[2]) and syncArgs[3] and (not DBM.GetStatusBarTimerTimeLeft(name)) and tonumber(colorR) and tonumber(colorG) and tonumber(colorB) and tonumber(colorA) then
				DBM.StartColoredStatusBarTimer(tonumber(syncArgs[2]), name, nil, tonumber(colorR), tonumber(colorG), tonumber(colorB), tonumber(colorA), true, player, syncArgs[3]);
			end
		elseif syncArgs[1] == "SICSBT" then
			_, _, _, _, _, color, icon, name = string.find(msg, "([^%s]+) ([%d%.]+) ([^%s]+) ([^%s]+) #(.+)# (.*)");
			if not name or not color or not icon then
				return;
			end
			_, _, colorR, colorG, colorB, colorA = string.find(color, "([%d%.]+)~([%d%.]+)~([%d%.]+)~([%d%.]+)");
			
			if tonumber(syncArgs[2]) and syncArgs[3] and (not DBM.GetStatusBarTimerTimeLeft(name)) and tonumber(colorR) and tonumber(colorG) and tonumber(colorB) and tonumber(colorA) then
				DBM.StartColoredStatusBarTimer(tonumber(syncArgs[2]), name, icon, tonumber(colorR), tonumber(colorG), tonumber(colorB), tonumber(colorA), true, player, syncArgs[3]);
			end
		elseif syncArgs[1] == "STRPCSBT" then
			_, _, _, _, _, _, color, name = string.find(msg, "([^%s]+) ([%d%.]+) ([%d%.]+) ([^%s]+) ([^%s]+) (.*)");
			if not name or not color then
				return;
			end
			_, _, colorR, colorG, colorB, colorA = string.find(color, "([%d%.]+)~([%d%.]+)~([%d%.]+)~([%d%.]+)");
			
			if tonumber(syncArgs[2]) and tonumber(syncArgs[3]) and syncArgs[4] and (not DBM.GetStatusBarTimerTimeLeft(name)) and tonumber(colorR) and tonumber(colorG) and tonumber(colorB) and tonumber(colorA) then
				DBM.StartRepeatingColoredStatusBarTimer(tonumber(syncArgs[2]), name, nil, tonumber(syncArgs[3]), tonumber(colorR), tonumber(colorG), tonumber(colorB), tonumber(colorA), true, player, syncArgs[4]);
			end
		elseif syncArgs[1] == "SIRPCSBT" then
			_, _, _, _, _, _, color, icon, name = string.find(msg, "([^%s]+) ([%d%.]+) ([%d%.]+) ([^%s]+) ([^%s]+) #(.+)# (.*)");
			if not name or not color or not icon then
				return;
			end
			_, _, colorR, colorG, colorB, colorA = string.find(color, "([%d%.]+)~([%d%.]+)~([%d%.]+)~([%d%.]+)");
			
			if tonumber(syncArgs[2]) and tonumber(syncArgs[3]) and syncArgs[4] and (not DBM.GetStatusBarTimerTimeLeft(name)) and tonumber(colorR) and tonumber(colorG) and tonumber(colorB) and tonumber(colorA) then
				DBM.StartRepeatingColoredStatusBarTimer(tonumber(syncArgs[2]), name, icon, tonumber(syncArgs[3]), tonumber(colorR), tonumber(colorG), tonumber(colorB), tonumber(colorA), true, player, syncArgs[4]);
			end
		elseif syncArgs[1] == "UPDISBT" then
			local elapsed, timer, newName;
			_, _, name, elapsed, timer, newIcon, newName = string.find(msg, "UPDISBT #(.+)# (%w+) (%w+) #(.+)# (.*)");
			if newName == name then
				newName = nil;
			end
			DBM.UpdateStatusBarTimer(name, tonumber(elapsed), tonumber(timer), newName, newIcon, true);
		elseif syncArgs[1] == "HI!" then
			if arg3 == "PARTY" then
				SendAddonMessage("LVBM NSP", "VER "..DBM.Version.." "..DBM_VERSION.." "..DBM_REVISION, "PARTY")
			else
				DBM.AddSyncMessage("VER "..DBM.Version.." "..DBM_VERSION.." "..DBM_REVISION, true)
			end
		elseif syncArgs[1] == "REQ" and syncArgs[2] == "VER" then
			DBM.AddSyncMessage("VER "..DBM.Version.." "..DBM_VERSION.." "..DBM_REVISION, true);
		elseif syncArgs[1] == "SC" then
			if not DBM.InCombat then
				DBM.CombatStart(syncArgs[3], tonumber(syncArgs[2] or 0) or 0, true, player);
			end
		elseif syncArgs[1] == "EC" then
			if DBM.InCombat and DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][syncArgs[2]] then
				if type(DBM.Bosses[GetRealZoneText()][syncArgs[2]].killName) == "table" then
					for index, value in pairs(DBM.Bosses[GetRealZoneText()][syncArgs[2]].killName) do
						if value.notKilled then
							return;
						end
					end
					DBM.CombatEnd((DBM.Bosses[GetRealZoneText()][syncArgs[2]].realName or DBM.Bosses[GetRealZoneText()][syncArgs[2]].name), true);
				else
					DBM.CombatEnd((DBM.Bosses[GetRealZoneText()][syncArgs[2]].killName or DBM.Bosses[GetRealZoneText()][syncArgs[2]].name), true);
				end
			end
		elseif syncArgs[1] == "ECS" then
			if DBM.InCombat and DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][syncArgs[2]] and type(DBM.Bosses[GetRealZoneText()][syncArgs[2]].killName) == "table" and DBM.Bosses[GetRealZoneText()][syncArgs[2]].killName[syncArgs[3]] then
				DBM.CombatEnd(nil, true, DBM.Bosses[GetRealZoneText()][syncArgs[2]].killName[syncArgs[3]].name);
			end
		elseif syncArgs[1] == "VER" and tonumber(syncArgs[2]) then
			DBM.SyncInfo.Clients[player] = syncArgs[2];
			if tonumber(syncArgs[3]) and tonumber(syncArgs[4]) then
				DBM.SyncInfo.DispVers[player] = {syncArgs[3], syncArgs[4]}
			else
				DBM.SyncInfo.DispVers[player] = {syncArgs[2]}
			end
			if tonumber(syncArgs[2]) > tonumber(DBM.Version) then
				local player1, player2;
				player1 = player;
				for index, value in pairs(DBM.SyncInfo.Clients) do
					if (value == syncArgs[2]) and (index ~= player1) then
						player2 = index;
						break;
					end
				end
				if player1 and player2 and (not DBM.UpdateDialogShown) then
					DBM.UpdateDialogShown = syncArgs[2];
					DBMUpdateDialogText:SetText(string.format(DBM_UPDATE_DIALOG, player1, player2, syncArgs[2]));
					DBMUpdateDialog:Show();
				end
			end
		elseif syncArgs[1] == "ENDALL" then
			for i = 1, GetNumRaidMembers() do
				local name, rank;
				name, rank = GetRaidRosterInfo(i);
				if (name == player) and (rank >= 1) then
					DBM.AddMsg(string.format(DBM_REC_STOP_ALL, player));
					for index, value in pairs(DBM.AddOns) do
						if type(value.OnStop) == "function" then
							if value.APIVersion and value.APIVersion >= 2.11 then
								value:OnStop();
							else
								value.OnStop();
							end
						end
						if value.APIVersion and value.APIVersion >= 2.11 then
							value:RemoveAllIcons()
							value:UnScheduleAll()
						end
					end
					DBM.ScheduleData = {};
					DBM.TimerData = {};
					for index, value in pairs(DBM.StatusBarData) do
						if index then
							if DBM.StatusBarData[index].bossModID ~= "UNKNOWN" then
								DBM.EndRepeatingStatusBarTimer(index, true);
							end
						end
					end
				end
			end
		elseif syncArgs[1] == "REQBARS" then
			DBM.SendBarsToPlayer(player);
		elseif syncArgs[1]:sub(0, 4) == "SAM#" then

			if player == UnitName("player") then
				return
			end
			for i = 1, GetNumRaidMembers() do -- filter out old bugged syncs
				local name, rank = GetRaidRosterInfo(i)
				if name == player and rank == 0 then
					return
				end
			end
			local msg = syncArgs[1]:sub(5)
			local _, _, bossID, locale, bossModVer, dbmVer, random = msg:find("([^%s]+)#(%w+)#([%d%.]+)#(%d+)#(%d+)")
			if DBM.AddOns[bossID] and DBM.AddOns[bossID].Options.Announce then
				local disableAnnounce
				if locale:sub(0, 2) == "en" and GetLocale():sub(0, 2) ~= "en" then
					disableAnnounce = true -- other player is using an english client
				elseif locale:sub(0, 2) ~= "en" and GetLocale():sub(0, 2) == "en" then
					return -- we are using an english client, the other guy not, so we can return here...the remote dbm client must disable announce
				
				elseif tonumber(bossModVer) and tonumber(bossModVer) > tonumber(DBM.AddOns[bossID].Version) then -- both players have english clients or both have non-english clients
					disableAnnounce = true -- remote dbm client got a newer version
				elseif tonumber(bossModVer) and tonumber(bossModVer) < tonumber(DBM.AddOns[bossID].Version) then
					return -- we are using a later version than the other guy
				
				elseif tonumber(dbmVer) and tonumber(dbmVer) > tonumber(DBM_REVISION) then -- both players are using the same version
					disableAnnounce = true -- he got a newer version of deadly boss mods, we'll disable announce
				elseif tonumber(dbmVer) and tonumber(dbmVer) < tonumber(DBM_REVISION) then
					return -- he will disable announce
				
				elseif player and player:len() < UnitName("player"):len() then -- prefer player with the shortest name
					disableAnnounce = true
				elseif player and player:len() > UnitName("player"):len() then
					return
					
				elseif tonumber(random) and tonumber(random) > randomNumber then 
					disableAnnounce = true 
				elseif tonumber(random) and tonumber(random) < randomNumber then
					return
					
				elseif player and player > UnitName("player") then -- we both rolled the same number!
					disableAnnounce = true
				elseif player and player < UnitName("player") then
					return
				end
				
				if disableAnnounce then -- should always be true here since two players cannot have the same name!
					DBM.AddOns[bossID].Options.Announce = false
					table.insert(tempDisabledMods, DBM.AddOns[bossID]) -- to re-enable it after the boss is dead/player logout
				end
			end
		end
	end
end

------------------
--Buff Functions--
------------------
function DBM.GetBuff(unitID, buff)
	if not UnitExists(unitID) then
		return nil;
	end
	local i = 1;

	while UnitBuff(unitID, i) ~= nil do
		if UnitBuff(unitID, i) == buff then
			return i
		end
		i = i + 1;
	end
end

function DBM.GetDebuff(unitID, buff)
	if not UnitExists(unitID) then
		return nil;
	end
	local i = 1;
	
	while UnitDebuff(unitID, i) ~= nil do
		if UnitDebuff(unitID, i) == buff then
			return i
		end
		i = i + 1;
	end
end

-- -------------- --
-- Icon Functions --
-- -------------- --

function DBM.SetIconByName(name, icon)
	if DBM.Rank == 0 then
		return;
	end
	
	if (icon == nil or tonumber(icon) < 1 or tonumber(icon) > 8) then
		icon = 8;
	else
		icon = tonumber(icon);
	end
	
	for i = 1, GetNumRaidMembers() do
		if (UnitName("raid"..i) == name) then
			if GetRaidTargetIndex("raid"..i) ~= icon then
				SetRaidTargetIcon("raid"..i, icon);
			end
			break;
		end
	end
end

function DBM.ClearIconByName(name)
	if DBM.Rank == 0 then
		return;
	end
	
	for i=1, GetNumRaidMembers() do
		if (UnitName("raid"..i) == name) then
			SetRaidTargetIcon("raid"..i, 0);
			break;
		end
	end
end


--------------------
--Combat Functions--
--------------------
function DBM.DetectCombat(name)
	local unitID
	if UnitName("target") == name and not UnitIsPlayer("target") then
		unitID = "target";
	else
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
				unitID = "raid"..i.."target";
				break;
			end
		end
	end
	if unitID and UnitAffectingCombat(unitID) then
		return unitID;		
	else
		return nil;		
	end
end

function DBM.UnitExists(name)
	if type(name) ~= "string" and type(name) ~= "table" then
		return false;
	end	
	
	if DBM.GetBuff("player", DBM_REDEMPTION) or ((GetTime() - DBM.LastBloodrage) < 7.5) then		
		return false;
	end	
	if DBM.GetBuff("player", DBM_FEIGNDEATH) or ((GetTime() - DBM.LastFeignDeath) < 20) then
		return false;
	end	
	if (GetTime() - DBM.LastBloodrage) < 7.5 then
		return false;
	end
	if type(name) == "table" then
		local unitTable = {};
		for index, value in pairs(name) do
			unitTable[value] = false; --it would look much better if I would call DBM.UnitExists(value) here, but I want to iterate only one time over the raid's targets...
		end
		if unitTable[UnitName("target")] ~= nil and not UnitIsPlayer("target") then
			unitTable[UnitName("target")] = true;
		end
		for i = 1, GetNumRaidMembers() do
			local raidTarget = UnitName("raid"..i.."target");
			if raidTarget ~= nil and unitTable[raidTarget] ~= nil and not UnitIsPlayer("raid"..i.."target") then
				unitTable[raidTarget] = true;
			end
		end
		return unitTable;
	else	
		if UnitName("target") == name and not UnitIsPlayer("target") then
			return true;
		end
		
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
				return true;
			end
		end
		return false;
	end
end

function DBM.CombatStart(bossID, delay, noBroadcast, syncedBy)
	if DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][bossID] and not DBM.InCombat then
		
		local bossModVer = "1.0"
		local announce

		for index, value in pairs(DBM.Bosses[GetRealZoneText()][bossID].BossMods) do
			if DBM.AddOns[value] then
				DBM.AddOns[value].InCombat = true;
				bossModVer = DBM.AddOns[value].Version or "1.0"
				announce = DBM.AddOns[value].Options.Announce
				if type(DBM.AddOns[value].OnCombatStart) == "function" then
					if DBM.AddOns[value].APIVersion and DBM.AddOns[value].APIVersion >= 2.11 then
						DBM.AddOns[value]:OnCombatStart(delay);
					else
						DBM.AddOns[value].OnCombatStart(delay);
					end
				end				
			end
		end
		DBM.InCombat = bossID;
		DBM.HideWhispers = true;
		DBM.CombatStartTime = GetTime() - delay;

		if( DBM.Options.ShowCombatInformations ) then
			DBM.AddMsg(string.format(DBM_BOSS_ENGAGED, (DBM.Bosses[GetRealZoneText()][bossID].realName or DBM.Bosses[GetRealZoneText()][bossID].name)));
			if type(syncedBy) == "string" and DBM.Options.ShowPullSyncInfo then
				DBM.AddMsg(string.format(DBM_BOSS_SYNCED_BY, syncedBy));
			end
		end
		
		if not noBroadcast then
			DBM.AddSyncMessage("SC "..tostring(delay).." "..bossID)
		end
		
		if announce and (DBM.Rank >= 1 or (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0)) then
			DBM.AddSyncMessage("SAM#"..bossID.."#"..GetLocale().."#"..bossModVer.."#"..DBM_REVISION.."#"..randomNumber, true)
		end
	end
end

function DBM.CombatEnd(bossName, noBroadcast, subBossName)
	-- need some hard-coded stuff because of the stupid Romulo and Julianne encounter :<
	if subBossName == DBM_RJ_ROMULO or subBossName == DBM_RJ_JULIANNE then
		if DBM.AddOns.RomuloAndJulianne and DBM.AddOns.RomuloAndJulianne.Phase ~= 2 then
			return;
		end
	end	
	
	
	if not subBossName then
		for index, value in pairs(DBM.AddOns) do
			if value.InCombat then
				value.InCombat = false;
				if type(value.OnCombatEnd) == "function" then
					if value.APIVersion and value.APIVersion >= 2.11 then
						value:OnCombatEnd();
					else
						value.OnCombatEnd();
					end
				end
				DBM.UnSchedule("DBM.AddOns."..index..".OnEvent");
				DBM.UnSchedule("DBM.AddOns."..index..":OnEvent");
				DBM.UnSchedule("DBM.AddOns[\""..index.."\"]:OnEvent");
				if value.APIVersion and value.APIVersion >= 2.11 then
					value:RemoveAllIcons()
					value:UnScheduleAll()
				end
				local i = 1
				while getglobal("DBM_HugeBar"..i) do
					if getglobal("DBM_HugeBar"..i):IsShown() then
						DBMStatusBars_EndImportantBar(getglobal("DBM_HugeBar"..i))
					end
					i = i + 1
				end
				for index2, value2 in pairs(DBM.StatusBarData) do
					if value2 and value2.bossModID then
						if value2.bossModID == index then
							DBM.EndRepeatingStatusBarTimer(index2, true);
						end
					end
				end
			end
		end
		for index, value in pairs(DBM.Bosses) do
			for index2, value2 in pairs(value) do
				if type(value2.killName) == "table" then
					for index3, value3 in pairs(value2.killName) do
						value3.notKilled = true;
					end
				end
			end
		end
	end
	
	if bossName or subBossName then
		if DBM.Bosses[GetRealZoneText()] then
			if subBossName then
				for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
					if type(value.killName) == "table" then
						for index2, value2 in pairs(value.killName) do
							if value2.name == subBossName then
								value2.notKilled = false;
								if not noBroadcast then
									DBM.AddSyncMessage("ECS "..index.." "..index2);
								end
							end
						end
					end
				end
			else
				if not noBroadcast then
					for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
						local killName
						if type(value.killName) == "string" then
							killName = value.killName
						end
						if (value.killName or value.name) == bossName or value.realName == bossName then
							DBM.AddSyncMessage("EC "..index);
						end
					end
				end
			end
		end
		if bossName then
			for i, v in pairs(tempDisabledMods) do
				if v and v.Options then
					v.Options.Announce = true
				end
				tempDisabledMods[i] = nil
			end
			if DBM.Options.ShowCombatInformations and DBM.InCombat then
				if DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][DBM.InCombat] and DBM.Bosses[GetRealZoneText()][DBM.InCombat].realName then
					DBM.AddMsg(string.format(DBM_BOSS_DOWN, DBM.Bosses[GetRealZoneText()][DBM.InCombat].realName, DBM.SecondsToTime((GetTime() - DBM.CombatStartTime), true)));
				else
					DBM.AddMsg(string.format(DBM_BOSS_DOWN, bossName, DBM.SecondsToTime((GetTime() - DBM.CombatStartTime), true)));
				end
			end
		end
		if subBossName and DBM.Bosses[GetRealZoneText()] then
			local allBossesDown = true;
			for index, value in pairs(DBM.Bosses[GetRealZoneText()]) do
				if type(value.killName) == "table" then					
					for index2, value2 in pairs(value.killName) do
						if value2.name == subBossName then
							for index3, value3 in pairs(DBM.Bosses[GetRealZoneText()][index].killName) do
								if value3.notKilled then
									allBossesDown = false;
								end
							end
							if allBossesDown then
								DBM.CombatEnd(DBM.Bosses[GetRealZoneText()][index].realName or DBM.Bosses[GetRealZoneText()][index].name);
							end
							break;
						end
					end
				end
			end
		end
	end
	
	if not subBossName then
		DBM.EndHideWhispers(bossName);
		DBM.InCombat = false;
	end
end

function DBM.CheckForCombatEnd()
	if not UnitAffectingCombat("player") and not UnitIsDead("player") then
		DBM.CombatEnd();
	end
end

function DBM.GetHPByName(name)
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
			return math.floor((UnitHealth("raid"..i.."target")/UnitHealthMax("raid"..i.."target")) * 100).."%%"
		end
	end
	return DBM_HP_UNKNOWN
end

function DBM.GetBossHP(name)
	local hitpoints;
	
	if name == DBM_FOURHORSEMEN_THANE and DBM.AddOns.FourHorsemen and DBM.AddOns.FourHorsemen.InCombat then
		return "Mograine "..DBM.AddOns.FourHorsemen[DBM_FOURHORSEMEN_MOGRAINE].."%%, Thane Korth'azz "..DBM.AddOns.FourHorsemen[DBM_FOURHORSEMEN_THANE].."%%, Blaumeux "..DBM.AddOns.FourHorsemen[DBM_FOURHORSEMEN_LADY].."%%, Zeliek "..DBM.AddOns.FourHorsemen[DBM_FOURHORSEMEN_ZELIEK].."%%";
	elseif name == DBM_RJ_JULIANNE and DBM.AddOns.RomuloAndJulianne and DBM.AddOns.RomuloAndJulianne.InCombat then
		local RHP, JHP
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == DBM_RJ_ROMULO and not UnitIsPlayer("raid"..i.."target") then
				RHP = tostring(math.floor((UnitHealth("raid"..i.."target")/UnitHealthMax("raid"..i.."target")) * 100)).."%%";
				if JHP then
					break;
				end
			elseif UnitName("raid"..i.."target") == DBM_RJ_JULIANNE and not UnitIsPlayer("raid"..i.."target") then
				JHP = tostring(math.floor((UnitHealth("raid"..i.."target")/UnitHealthMax("raid"..i.."target")) * 100)).."%%";
				if RHP then
					break;
				end
			end
		end
		
		if RHP and JHP then
			return DBM_RJ_ROMULO.." "..RHP..", "..DBM_RJ_JULIANNE.." "..JHP
		elseif RHP then
			return DBM_RJ_ROMULO.." "..RHP;
		elseif JHP then
			return DBM_RJ_JULIANNE.." "..JHP;
		end
	end
	
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
			hitpoints = tostring(math.floor((UnitHealth("raid"..i.."target")/UnitHealthMax("raid"..i.."target")) * 100)).."%%";
			break;
		end
	end
	if not hitpoints then
		if name == DBM_THADDIUS_NAME then
			hitpoints = string.format(DBM_PHASE, 1);
		elseif name == DBM_GOTH_NAME and DBM.AddOns.Gothik then
			hitpoints = string.format(DBM_WAVE, DBM.AddOns.Gothik.Wave);
		elseif name == DBM_NTP_NAME and DBM.AddOns.Noth then
			hitpoints = string.format(DBM_BALCONY_PHASE, DBM.AddOns.Noth.Phase);
		elseif name == DBM_KELTHUZAD_NAME and DBM.AddOns.Kelthuzad and DBM.GetStatusBarTimerTimeLeft("Phase 2") then
			local timeLeft = DBM.GetStatusBarTimerTimeLeft("Phase 2");
			hitpoints = string.format(DBM_PHASE, 1)..", "..DBM.SecondsToTime(timeLeft);
		end
	end
	if DBM.Bosses and DBM.InCombat and DBM.Bosses[GetRealZoneText()] and DBM.Bosses[GetRealZoneText()][DBM.InCombat] and DBM.Bosses[GetRealZoneText()][DBM.InCombat].BossMods
	and DBM.Bosses[GetRealZoneText()][DBM.InCombat].BossMods[1] and DBM.AddOns[DBM.Bosses[GetRealZoneText()][DBM.InCombat].BossMods[1]] and DBM.AddOns[DBM.Bosses[GetRealZoneText()][DBM.InCombat].BossMods[1]].GetBossHP then
		return DBM.AddOns[DBM.Bosses[GetRealZoneText()][DBM.InCombat].BossMods[1]]:GetBossHP() or hitpoints or DBM_HP_UNKNOWN
	end
	
	return hitpoints or DBM_HP_UNKNOWN;
end

function DBM.GetNumRaidMembersAlive()
	local alive = 0;
	for i = 1, GetNumRaidMembers() do
		if not UnitIsDeadOrGhost("raid"..i) then
			alive = alive + 1;
		end
	end
	return tostring(alive);
end

-----------------------
--Patchnote Functions--
-----------------------
function DBM.OnPatchnoteMessage(msg, longMsg)
	if longMsg then
		DBM.LongMsg = DBM.LongMsg..msg;
	else
		msg = DBM.LongMsg..msg;
		DBM.LongMsg = "";
		if DBMPatchnoteFrame:IsShown() then
			DBMPatchnoteFrameMessageFrame:AddMessage(msg);
			for i = 1, DBMPatchnoteFrameMessageFrame:GetNumMessages() do
				DBMPatchnoteFrameMessageFrame:ScrollUp();
			end
		end
	end
end

function DBM.AddPatchnoteMessage(msg, target, longMsg)
	if type(target) ~= "string" or type(msg) ~= "string" then
		return;
	end
	if longMsg == nil then
		local longMsg = false;
	end
	if string.len(msg) > 240 then		
		DBM.AddPatchnoteMessage(string.sub(msg, 1, 240), target, true);
		msg = string.sub(msg, 241);
		DBM.AddPatchnoteMessage(msg, target);
	else
		if longMsg then
			msg = "LVPNL"..msg;
		else
			msg = "LVPNS"..msg;
		end
		table.insert(DBM.MsgQueue, {["msg"] = msg, ["target"] = target});
	end
end

function DBM.SendPatchnotes(target, version, lang)
	if type(target) ~= "string" or not version or not lang then
		return;
	end
	version = string.gsub(version, ",", ".");
	if tonumber(version) >= tonumber(DBM.Version) then
		DBM.AddPatchnoteMessage("I don't have a newer version than you.", target);
		return;
	end
	
	if not DBM_PN[lang] then
		DBM.AddPatchnoteMessage("Patchnotes in your language are not available. Sending english notes.", target);
		lang = "en";
	end
	local notesToSend = {};
	
	version = string.gsub(version, "%.", "");
	version = tonumber(version);
	for index, value in pairs(DBM_PN[lang]) do
		table.insert(notesToSend, {["ver"] = index, ["notes"] = value});
	end
	table.sort(notesToSend, function(v1, v2) return v1.ver > v2.ver; end);
	for index, value in ipairs(notesToSend) do
		if value.ver > version then
			for index2, value2 in ipairs(notesToSend[index].notes) do
				DBM.AddPatchnoteMessage(value2, target);
			end
		end
	end	
end

function DBM.RequestPatchnotes(version)
	local clientTable = {};
	for index, value in pairs(DBM.SyncInfo.Clients) do
		if value == version then
			table.insert(clientTable, index);
		end
	end
	if not clientTable[1] then return; end
	local player = clientTable[random(1, table.getn(clientTable))];
	DBM.OnPatchnoteMessage(string.format(DBM_REQ_PATCHNOTES, player));
	
	
	local oldValue = GetCVar("autoClearAFK");
	SendChatMessage("LVPNREQ "..DBM.Version.." "..string.sub(GetLocale(), 1, 2), "WHISPER", nil, player);	-- it's not possible to use SendAddonMessage here because sending a whisper-addon-message is bugged in battlegrounds... (fixed? needs tests)
	SetCVar("autoClearAFK", oldValue);
end


---------------------------------
--Register/Unregister Functions--
---------------------------------
function DBM.Register()
	for index, value in pairs(DBM.AddOns) do
		for index2, value2 in pairs(value.Events) do
			DBM_API:RegisterEvent(index2);
		end
	end	
end

function DBM.Unregister()
	DBM_API:UnregisterAllEvents();
end



----------------------
-- Boss Mod Methods --
----------------------

function DBM:NewBossMod(modID, modName, modDescription, modInstance, modGUITab, modGUISort)
	if type(modID) ~= "string" then
		DBM.AddMsg(DBM_ERROR_INVALID_MODID);
		return;
	end
	
	if string.find(modID, " ") then
		DBM.AddMsg("The mod's ID must not contain spaces!", "ERROR");
	end
	
	if DBM.AddOns[modID] then
		DBM.AddMsg(string.format(DBM_ERROR_MODID_EXISTS, modID));
		return;
	end
	
	DBM.AddOns[modID] = setmetatable({
		ModID		= modID,
		Name 		= modName,		
		Description	= modDescription,
		Instance	= modInstance or DBM_OTHER,
		GUITab		= modGUITab,
		Sort		= modGUISort,
		Events		= {},
		Options		= {},
		APIVersion	= tonumber(DBM.Version) or 2.11,
	},
	{
		__index = DBM.BossModMetatable
	});
	
	return DBM.AddOns[modID];
end

function DBM:GetMod(modID)
	return DBM.AddOns[modID];
end

DBM.BossModMetatable = {};

function DBM.BossModMetatable:AddOption(optionName, optionDefault, optionGUIText, optionGUIFunc, optionButtonAttributes)
	if type(optionName) ~= "string" or optionDefault == nil then
		return;
	end

	self.Options[optionName] = optionDefault;
	
	if optionGUIText then
		if not self.DropdownMenu then
			self.DropdownMenu = {};
		end
		table.insert(self.DropdownMenu, {
			variable	= optionName,
			text		= optionGUIText,
			func		= optionGUIFunc or function() self.Options[optionName] = not self.Options[optionName] end
		});
		if type(optionButtonAttributes) == "table" then
			for index, value in pairs(optionButtonAttributes) do
				self.DropdownMenu[table.getn(self.DropdownMenu)][index] = value;
			end
		end
	end
end

function DBM.BossModMetatable:AddBarOption(optionName, optionDefault, optionGUIText, optionButtonAttributes)
	if type(optionName) ~= "string" then
		return;
	end
	if optionDefault == nil then
		optionDefault = true
	end

	self.Options["BAR"..optionName] = optionDefault;
	
	if not self.BarMenu then
		self.BarMenu = {};
	end
	if not optionGUIText then
		if type(DBM_SBT[optionName]) == "string" then
			optionGUIText = DBM_SBT[optionName]
		elseif type(DBM_SBT[self.ModID]) == "table" then
			for i, v in ipairs(DBM_SBT[self.ModID]) do
				if v[1] == optionName then
					optionGUIText = v[2]:gsub("%%1", DBMGUI_OPTIONS_BAR_TARGET)
					break
				end
			end
			if not optionGUIText then
				optionGUIText = optionName:gsub("%(%.%*%)", DBMGUI_OPTIONS_BAR_TARGET)
			end
		else
			optionGUIText = optionName:gsub("%(%.%*%)", DBMGUI_OPTIONS_BAR_TARGET)
		end
	end
	table.insert(self.BarMenu, {
		variable	= "BAR"..optionName,
		text		= optionGUIText,
		func		= function() self.Options["BAR"..optionName] = not self.Options["BAR"..optionName] end
	});
	if type(optionButtonAttributes) == "table" then
		for index, value in pairs(optionButtonAttributes) do
			self.DropdownMenu[#self.BarMenu][index] = value;
		end
	end
end

function DBM.BossModMetatable:RegisterCombat(startMethod, delayOrTrigger, bossName, realName, killName, minCombatTime)
	if not DBM.Bosses then
		DBM.Bosses = {};
	end
	
	
	if not DBM.Bosses[self.Instance] then
		DBM.Bosses[self.Instance] = {};
	end
	if DBM.Bosses[self.Instance][self.ModID] then
		self:AddMsg(DBM_COMBAT_TABLE_WARNING);
	end
	
	DBM.Bosses[self.Instance][self.ModID] = {
		startMethod		= startMethod,
		name			= bossName or self.Name,
		realName		= realName,
		minCombatTime	= minCombatTime,
		BossMods = {
			self.ModID,
		}
	};
	
	
	if type(delayOrTrigger) == "table" then
		DBM.Bosses[self.Instance][self.ModID].startTrigger = {};
		for index, value in pairs(delayOrTrigger) do
			DBM.Bosses[self.Instance][self.ModID].startTrigger[value] = true;
		end
	elseif type(delayOrTrigger) == "string" then
		DBM.Bosses[self.Instance][self.ModID].startTrigger = {
			[delayOrTrigger] = true;
		};
	elseif type(delayOrTrigger) == "number" then
		DBM.Bosses[self.Instance][self.ModID].delay = delayOrTrigger;
	else
		DBM.Bosses[self.Instance][self.ModID].delay = 5;
	end
	
	if type(killName) == "string" then
		DBM.Bosses[self.Instance][self.ModID].killName = killName;
	elseif type(killName) == "table" then
		DBM.Bosses[self.Instance][self.ModID].killName = {};
		local i = 1;
		for index, value in pairs(killName) do
			DBM.Bosses[self.Instance][self.ModID].killName[self.ModID..i] = {
				name = value,
				notKilled = true,
			};
			i = i + 1;
		end
	end
end

function DBM.BossModMetatable:RegisterEvents(...)
	if not self.Events then self.Events = {}; end
	
	for i = 1, select("#", ...) do
		self.Events[select(i, ...)] = true;
		DBM_API:RegisterEvent(select(i, ...));
	end
end


function DBM.BossModMetatable:AddMsg(msg, prefix)
	DBM.AddMsg(msg, prefix or self.Name);
end

function DBM.BossModMetatable:Announce(msg, color, noBroadcast)
	if type(color) == "boolean" then -- support for mods < v3.0
		noBroadcast = color
		color = nil
	end
	if not color then
		color = 1
	end
	DBM.Announce(msg, noBroadcast, self.ModID, nil, color);
end

function DBM.BossModMetatable:AddSpecialWarning(text, flash, shake)
	DBM.AddSpecialWarning(text, shake, flash)
end

function DBM.BossModMetatable:SendHiddenWhisper(msg, player)
	if DBM.Rank >= 1 and self.Options.Announce then
		DBM.SendHiddenWhisper(msg, player)
	end
end

function DBM.BossModMetatable:Schedule(timer, func, ...)
	local i = #DBM.ScheduleData
	DBM.Schedule(timer, func, ...)
	if #DBM.ScheduleData > i then
		DBM.ScheduleData[#DBM.ScheduleData].scheduledBy = self
	end
end

function DBM.BossModMetatable:ScheduleEvent(timer, ...)
	local i = #DBM.ScheduleData
	DBM.Schedule(timer, self.OnEvent, self, ...)
	if #DBM.ScheduleData > i then
		DBM.ScheduleData[#DBM.ScheduleData].scheduledBy = self
	end
end
DBM.BossModMetatable.ScheduleSelf = DBM.BossModMetatable.ScheduleEvent

function DBM.BossModMetatable:ScheduleAnnounce(timer, ...)
	local i = #DBM.ScheduleData
	DBM.Schedule(timer, self.Announce, self, ...)
	if #DBM.ScheduleData > i then
		DBM.ScheduleData[#DBM.ScheduleData].scheduledBy = self
	end
end

function DBM.BossModMetatable:ScheduleMethod(timer, method, ...)
	if not method or type(self[method]) ~= "function" then
		return
	end
	local i = #DBM.ScheduleData
	DBM.Schedule(timer, self[method], self, ...)
	if #DBM.ScheduleData > i then
		DBM.ScheduleData[#DBM.ScheduleData].scheduledBy = self
	end
end

function DBM.BossModMetatable:UnSchedule(func, ...)
	DBM.UnSchedule(func, ...)
end

function DBM.BossModMetatable:UnScheduleEvent(...)
	DBM.UnSchedule(self.OnEvent, self, ...)
end
DBM.BossModMetatable.UnScheduleSelf = DBM.BossModMetatable.UnScheduleEvent

function DBM.BossModMetatable:UnScheduleAnnounce(...)
	DBM.UnSchedule(self.Announce, self, ...)
end

function DBM.BossModMetatable:UnScheduleMethod(method, ...)
	if not method or type(self[method]) ~= "function" then
		return
	end
	DBM.UnSchedule(self[method], self, ...)
end

function DBM.BossModMetatable:GetEventScheduleTimeLeft(...)
	DBM.GetScheduleTimeLeft(self.OnEvent, self, ...)
end
DBM.BossModMetatable.GetSelfScheduleTimeLeft = DBM.BossModMetatable.GetEventScheduleTimeLeft

function DBM.BossModMetatable:GetAnnounceScheduleTimeLeft(...)
	DBM.GetScheduleTimeLeft(self.Announce, self, ...)
end

function DBM.BossModMetatable:GetMethodScheduleTimeLeft(method, ...)
	if not method or type(self[method]) ~= "function" then
		return
	end
	DBM.GetScheduleTimeLeft(self[method], self, ...)
end

function DBM.BossModMetatable:UnScheduleAll()
	for i = #DBM.ScheduleData, 1, -1 do
		if DBM.ScheduleData[i].scheduledBy == self then
			table.remove(DBM.ScheduleData, i)
		end
	end
end

function DBM.BossModMetatable:StartStatusBarTimer(timer, name, icon, noBroadcast, repetitions, colorR, colorG, colorB, colorA)
	local repeatingTimer;
	if repetitions then
		repeatingTimer = true;
	end
	colorR = tonumber(colorR);
	colorG = tonumber(colorG);
	colorB = tonumber(colorB);
	colorA = tonumber(colorA);
	
	DBM.StartStatusBarTimer(timer, name, icon, noBroadcast, nil, self.ModID, repeatingTimer, repetitions, colorR, colorG, colorB, colorA);
end

function DBM.BossModMetatable:UpdateStatusBarTimer(name, elapsed, timer, newName, newIcon, noBroadcast)
	DBM.UpdateStatusBarTimer(name, elapsed, timer, newName, newIcon, noBroadcast)
end

function DBM.BossModMetatable:GetStatusBarTimerTimeLeft(name)
	return DBM.GetStatusBarTimerTimeLeft(name);
end

function DBM.BossModMetatable:EndStatusBarTimer(name, noBroadcast)
	DBM.EndStatusBarTimer(name, noBroadcast, nil, true)
end

function DBM.BossModMetatable:SendSync(msg)
	if type(msg) ~= "string" then
		return;
	end
	
	if not modSpamTable[self.ModID] or not modSpamTable[self.ModID][msg] then
		if not modSpamTable[self.ModID] then
			modSpamTable[self.ModID] = {}
		end
		modSpamTable[self.ModID][msg] = 3
		
		if type(self.OnSync) == "function" then
			self:OnSync(msg, UnitName("player"))
		end
		
		local _, instanceTyp = IsInInstance()
		if instanceTyp == "pvp" then
			SendAddonMessage("DBM3"..self.ModID, msg, "BATTLEGROUND")
		else
			if GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 then
				SendAddonMessage("DBM3"..self.ModID, msg, "PARTY")
			else
				SendAddonMessage("DBM3"..self.ModID, msg, "RAID")
			end
		end
	end
end



do
	local getIconByName = function(name)
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i) == name then
				return GetRaidTargetIndex("target")
			end
		end
	end
	
	function DBM.BossModMetatable:SetIcon(target, timer, icon, dontRemember)
		if not self.Options.Announce or DBM.Rank < 1 then return end
		local oldIcon = getIconByName(target)
		DBM.SetIconByName(target, icon)
		
		self:UnScheduleMethod("SetIcon", target) -- unschedule old scheduled icon remove stuff
		self:UnScheduleMethod("RemoveIcon", target)
		if tonumber(timer) and oldIcon then			
			self:ScheduleMethod(tonumber(timer), "SetIcon", target, nil, oldIcon, true)
		elseif tonumber(timer) then
			self:ScheduleMethod(tonumber(timer), "RemoveIcon", target)
		end
		
		if not self.icons then
			self.icons = {}
		end
		if not dontRemember then
			self.icons[icon or 8] = target
		else
			self.icons[icon or 8] = nil
		end
		if oldIcon and self.icons[oldIcon] then
			self.icons[oldIcon] = nil
		end
	end
	
	function DBM.BossModMetatable:RemoveIcon(target, ...)
		if not self.Options.Announce or DBM.Rank < 1 then return end
		self:UnScheduleMethod("SetIcon", target)
		self:UnScheduleMethod("RemoveIcon", target)
		if self.icons then
			for i, v in pairs(self.icons) do
				if v == target then
					self.icons[i] = nil
					break
				end
			end
		end
		DBM.ClearIconByName(target, ...)
	end
	
	function DBM.BossModMetatable:RemoveAllIcons()
		if not self.icons or DBM.Rank < 1 or not self.Options.Announce then return end
		for i, v in pairs(self.icons) do
			if getIconByName(v) == i then
				self:RemoveIcon(v)
			end
		end
	end
end

function DBM.BossModMetatable:IsWipe()
	local wipeCounter = 0;
	if DBM.Bosses[self.Instance] and DBM.Bosses[self.Instance][self.ModID] then
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == DBM.Bosses[self.Instance][self.ModID].name and not UnitAffectingCombat("raid"..i.."target") then
				return true;
			end
			if UnitIsDeadOrGhost("raid"..i) then
				wipeCounter = wipeCounter + 1;
			end
		end
		if wipeCounter >= 20 then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end


------------------
--Misc Functions--
------------------
function DBM.Capitalize(text, xall)
	text = tostring(text);
	if xall == nil and (GetLocale() == "krKR" or GetLocale() == "zhCN" or GetLocale() == "zhTW"  or GetLocale() == "ruRU") then
		return text;
	else
		return string.upper(string.sub(text, 0, 1))..string.sub(text, 2);
	end
end

function DBM.CutText(tstring, len)
	if( string.len(tstring) < len ) then return tstring; end
	local last = 0;
	local i = 0
	while true do
		i = string.find(tstring, " ", i + 1) 
		if (i == nil) then 
			break;

		elseif( i < len) then
			last = i - 1;
			
		elseif( i > len) then
			break;
		end
	end

	return string.sub(tstring, 1, last).."...";
end


DBM.math = {};
function DBM.math.round(num, idp)
    if (idp == nil or idp < 0 or idp > 20 ) then idp = 1; end
    idp = 10 ^ idp;
    return math.floor((num * idp) + 0.5) / idp;
end


function DBM.SecondsToTime(seconds, longFormat, forceMinutes)
	local time, min, sec;
	if longFormat then
		if not tonumber(seconds) then
			return "0 "..DBM_MINUTES.." "..DBM_AND.." 0 "..DBM_SECONDS;
		else
			seconds = tonumber(seconds);
		end
		
		min = math.floor(seconds / 60);
		sec = string.format("%.0f", math.mod(seconds, 60));
		if sec == "60" then
			sec = "0";
			min = min + 1;
		end
		if min == 1 then
			time = min.." "..DBM_MINUTE.." "..DBM_AND.." ";
		elseif min == 0 then
			time = "";
		else
			time = min.." "..DBM_MINUTES.." "..DBM_AND.." ";
		end
		if sec == "1" then
			time = time..sec.." "..DBM_SECOND;
		elseif sec == "0" then
			time = string.gsub(time, " and ", "");
		else
			time = time..sec.." "..DBM_SECONDS
		end
	else
		if not tonumber(seconds) then
			return "0.00";
		else
			seconds = tonumber(seconds);
		end		
		if (seconds > 60) or forceMinutes then
			min = math.floor(seconds / 60);
			sec = string.format("%02.0f", math.mod(seconds, 60));
			if sec == "60" then
				sec = "00";
				min = min + 1;
			end
			time = min..":"..sec;
		else
			time = string.format("%.1f", seconds);
		end
	end

	return time;
end


---------
--Hooks--
---------

function DBM.SetHooks()
	DBM.Hooks.oldChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler;
	
	function DBM.Hooks.newChatFrame_MessageEventHandler(event)
		if event and arg1 then
			if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM") then
				if (string.sub(arg1, 1, 4) == "LVPN") or (string.sub(arg1, 1, 4) == "LVBM") then
					if event == "CHAT_MSG_WHISPER_INFORM" then
						DBM.HideDNDAFKMessages[arg2] = 1.5;
					end
					return;
				elseif event == "CHAT_MSG_WHISPER_INFORM" and DBM.HiddenWhisperMessages[string.gsub(arg1, "%%", "")] and DBM.HiddenWhisperMessages[string.gsub(arg1, "%%", "")]["targets"] and DBM.HiddenWhisperMessages[string.gsub(arg1, "%%", "")]["targets"][arg2] then
					return;
				elseif event == "CHAT_MSG_WHISPER" then
					local whisperCheck = DBM.InterceptWhisper(arg1, arg2, arg6);
					if whisperCheck == "AUTO_RESPONDED" then
						if DBM.Options.ShowWhispersDuringCombat then
							DBM.Hooks.oldChatFrame_MessageEventHandler(event);
							if DBM.Options.ShowAutoRespondInfo and DBM.Options.HideOutgoingInfoWhisper then
								DBM.AddMsg(DBM_AUTO_RESPOND_SHORT, nil, true);
							end
						else
							if DBM.Options.ShowAutoRespondInfo and DBM.Options.HideOutgoingInfoWhisper then
								DBM.AddMsg(string.format(DBM_AUTO_RESPOND_LONG, arg2), nil, true);
							end
							return;
						end
					elseif whisperCheck == "HIDE" then
						if DBM.Options.ShowWhispersDuringCombat then
							DBM.Hooks.oldChatFrame_MessageEventHandler(event);
						else
							return;
						end
					elseif whisperCheck == "FORCE_HIDE" then
						return;
					elseif whisperCheck == "SHOW" then
						DBM.Hooks.oldChatFrame_MessageEventHandler(event);
					end
				else
					DBM.Hooks.oldChatFrame_MessageEventHandler(event);
				end		
			elseif (event == "CHAT_MSG_AFK") or (event == "CHAT_MSG_DND") then
				if DBM.HideDNDAFKMessages[arg2] then
					return;
				else
					DBM.Hooks.oldChatFrame_MessageEventHandler(event);
				end
			elseif ((event == "CHAT_MSG_RAID_WARNING") or (event == "CHAT_MSG_RAID") or (event == "CHAT_MSG_RAID_LEADER") or (event == "CHAT_MSG_BATTLEGROUND") or (event == "CHAT_MSG_BATTLEGROUND_LEADER")) then
				if DBM.CheckForSpam(event, arg1, arg2) then
					return;
				else
					if event == "CHAT_MSG_RAID_WARNING" then
						local colorCode = ""
						if arg1:find("^%*%*%*%s%s.+%s%s%*%*%*$") then -- color 2		
							colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[2]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[2]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[2]["b"])
						elseif arg1:find("^%*%*%*%s.+%s%*%*%*$") then -- color 1
							colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[1]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[1]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[1]["b"])
						elseif arg1:find("^%s%*%*%*%s.+%s%*%*%*%s$") then  -- color 3
							colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[3]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[3]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[3]["b"])
						elseif arg1:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then -- color 5
							colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[5]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[5]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[5]["b"])
						elseif arg1:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then -- color 4
							colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[4]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[4]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[4]["b"])
						end
						
						arg1 = arg1:gsub(">[^%s]+<", function(capture)
							capture = capture:sub(2, -2)
							if DBM.RaidClasses[capture] then
								capture = "|r|cff"..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].r)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].g)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].b)..capture.."|r"..colorCode
							end
							return capture
						end)
						
						if arg1:find("^%*%*%*%s%s.+%s%s%*%*%*$") then -- color 2		
							arg1 = colorCode..arg1:sub(6, -6).."|r"
						elseif arg1:find("^%*%*%*%s.+%s%*%*%*$") then -- color 1
							arg1 = colorCode..arg1:sub(5, -5).."|r"
						elseif arg1:find("^%s%*%*%*%s.+%s%*%*%*%s$") then  -- color 3
							arg1 = colorCode..arg1:sub(6, -6).."|r"
						elseif arg1:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then -- color 5
							arg1 = colorCode..arg1:sub(8, -8).."|r"
						elseif arg1:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then -- color 4
							arg1 = colorCode..arg1:sub(7, -7).."|r"
						end
					end					
					DBM.Hooks.oldChatFrame_MessageEventHandler(event);
				end
			else
				DBM.Hooks.oldChatFrame_MessageEventHandler(event);
			end
		else
			DBM.Hooks.oldChatFrame_MessageEventHandler(event);
		end
	end

	ChatFrame_MessageEventHandler = DBM.Hooks.newChatFrame_MessageEventHandler;
	
	if CT_RAMessageFrame and CT_RAMessageFrame.AddMessage then
		DBM.Hooks.oldCT_RAMessageFrame_AddMessage = CT_RAMessageFrame.AddMessage;
		function DBM.Hooks.newCT_RAMessageFrame_AddMessage(frame, text, r, g, b, id)
			if DBM.CheckForSpam("CHAT_MSG_CTRAID_WARNING", text) then
				return;
			else
				DBM.Hooks.oldCT_RAMessageFrame_AddMessage(frame, text, r, g, b, id);
			end
		end
		CT_RAMessageFrame.AddMessage = DBM.Hooks.newCT_RAMessageFrame_AddMessage;
	end	

	

	if type(FC_IsValidWhisper) == "function" then
		DBM.Hooks.oldFC_IsValidWhisper = FC_IsValidWhisper;
		function DBM.Hooks.newFC_IsValidWhisper(Text, Name)
			if DBM.HiddenWhisperMessages[string.gsub(Text, "%%", "")] and DBM.HiddenWhisperMessages[string.gsub(Text, "%%", "")]["targets"] and DBM.HiddenWhisperMessages[string.gsub(Text, "%%", "")]["targets"][Name] then
				return 0;
			end
			return DBM.Hooks.oldFC_IsValidWhisper(Text, Name);	
		end
		FC_IsValidWhisper = DBM.Hooks.newFC_IsValidWhisper;
	end

	if type(WIM_FilterResult) == "function" then
		local oldWIM_FilterResult = WIM_FilterResult
		function WIM_FilterResult(theMSG, theUser, isInbound, ...)
			local t = DBM.HiddenWhisperMessages[theMSG:gsub("%%", "")]
			if not isInbound and t and t.targets and t.targets[theUser] then
				return 1
			elseif isInbound then
				local whisperCheck = DBM.InterceptWhisper(theMSG, theUser)
				if whisperCheck == "AUTO_RESPONDED" then
					if DBM.Options.ShowWhispersDuringCombat then
						if DBM.Options.ShowAutoRespondInfo and DBM.Options.HideOutgoingInfoWhisper then
							DBM.AddMsg(DBM_AUTO_RESPOND_SHORT, nil, true)
						end
						return oldWIM_FilterResult(theMSG, theUser, isInbound, ...)
					else
						if DBM.Options.ShowAutoRespondInfo and DBM.Options.HideOutgoingInfoWhisper then
							DBM.AddMsg(string.format(DBM_AUTO_RESPOND_LONG, arg2), nil, true)
						end
						return 1
					end
				elseif whisperCheck == "HIDE" then
					if DBM.Options.ShowWhispersDuringCombat then
						return oldWIM_FilterResult(theMSG, theUser, isInbound, ...)
					else
						return 1
					end
				elseif whisperCheck == "FORCE_HIDE" then
					return 1
				elseif whisperCheck == "SHOW" then
					return oldWIM_FilterResult(theMSG, theUser, isInbound, ...)
				end
			else
				return oldWIM_FilterResult(theMSG, theUser, isInbound, ...)
			end
		end
	end	
end

function DBM.PlaySound(snd)
	if (snd == "RaidWarning") and DBM.Options.Gui then
		if DBM.Options.Gui.RaidWarnSound == 1 or DBM.Options.Gui.RaidWarnSound == 2 or DBM.Options.Gui.RaidWarnSound == 3 then
			if DBM.Options.Gui.RaidWarnSound == 1 then
				PlaySound(snd);
				return;
			elseif DBM.Options.Gui.RaidWarnSound == 2 then
				PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
				return;
			elseif DBM.Options.Gui.RaidWarnSound == 3 then
				return;
			end
		else
			PlaySound(snd);
		end
	else
		PlaySound(snd);
	end
end



--load on demand stuff ---FIX ME----
-- stolen from DBM_GUI >_<

function DBMGuiUpdateStatusbars()
	if( getglobal("DBM_StatusBarTimer1") == nil ) then return false; end		-- return if there are no bars
	for i = 1, DBM.StatusBarCount do
		if not getglobal("DBM_StatusBarTimer"..i).specialColor then
			getglobal("DBM_StatusBarTimer"..i.."Bar"):SetStatusBarColor(	DBM.Options.StatusBarColor.r, 
										DBM.Options.StatusBarColor.g, 
										DBM.Options.StatusBarColor.b, 
										DBM.Options.StatusBarColor.a	);
		end
	end
	DBM_StatusBarTimerDragBar:SetStatusBarColor(DBM.Options.StatusBarColor.r, 
							DBM.Options.StatusBarColor.g, 
							DBM.Options.StatusBarColor.b, 
							DBM.Options.StatusBarColor.a);	
	DBM_StatusBarTimerDrag2Bar:SetStatusBarColor(DBM.Options.StatusBarColor.r, 
							DBM.Options.StatusBarColor.g, 
							DBM.Options.StatusBarColor.b, 
							DBM.Options.StatusBarColor.a);
end

function DBMMinimapButton_Move()
	DBMMinimapButton:SetPoint("CENTER", "Minimap", "CENTER", (DBM.Options.MinimapButton.Radius * cos(DBM.Options.MinimapButton.Position)), 
							(DBM.Options.MinimapButton.Radius * sin(DBM.Options.MinimapButton.Position)));
end


function RaidWarningFrame_OnEvent(self, event, message)
	if event == "CHAT_MSG_RAID_WARNING" then
		if DBM.CheckForSpam("CHAT_MSG_RAID_WARNING_FRAME", message) then
			return
		end
		
		message = message:gsub(">[^%s]+<", function(capture)
			capture = capture:sub(2, -2)
			if DBM.RaidClasses[capture] then
				capture = "|cff"..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].r)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].g)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].b)..capture.."|r"
			end
			return capture
		end)
-- bugged! it doesn't support two different colors!		
--[[	if message:find("^%*%*%*%s%s.+%s%s%*%*%*$") then -- color 2
			RaidNotice_AddMessage(self, message:sub(6, -6), DBM.Options.RaidWarningColors[2])
		elseif message:find("^%*%*%*%s.+%s%*%*%*$") then -- color 1
			RaidNotice_AddMessage(self, message:sub(5, -5), DBM.Options.RaidWarningColors[1])
		elseif message:find("^%s%*%*%*%s.+%s%*%*%*%s$") then  -- color 3
			RaidNotice_AddMessage(self, message:sub(6, -6), DBM.Options.RaidWarningColors[3])
		elseif message:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then -- color 5
			RaidNotice_AddMessage(self, message:sub(8, -8), DBM.Options.RaidWarningColors[5])
		elseif message:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then -- color 4
			RaidNotice_AddMessage(self, message:sub(7, -7), DBM.Options.RaidWarningColors[4])
		else
			RaidNotice_AddMessage(self, message, ChatTypeInfo["RAID_WARNING"])
		end]]--
		
		if message:find("^%*%*%*%s%s.+%s%s%*%*%*$") then -- color 2
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[2].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[2].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[2].b)..
			message:sub(6, -6).."|r"
		elseif message:find("^%*%*%*%s.+%s%*%*%*$") then -- color 1
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[1].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[1].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[1].b)..
			message:sub(5, -5).."|r"
		elseif message:find("^%s%*%*%*%s.+%s%*%*%*%s$") then  -- color 3
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[3].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[3].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[3].b)..
			message:sub(6, -6).."|r"
		elseif message:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then -- color 5
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[5].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[5].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[5].b)..
			message:sub(8, -8).."|r"
		elseif message:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then -- color 4
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[4].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[4].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[4].b)..
			message:sub(7, -7).."|r"
		else
			message = "|cff"..
			("%.2x"):format(255 * ChatTypeInfo["RAID_WARNING"].r)..
			("%.2x"):format(255 * ChatTypeInfo["RAID_WARNING"].g)..
			("%.2x"):format(255 * ChatTypeInfo["RAID_WARNING"].b)..
			message.."|r"
		end
		RaidNotice_AddMessage(self, message, ChatTypeInfo["RAID_WARNING"])
		
		DBM.PlaySound("RaidWarning")
	end
end
function RaidWarningFrames_AddLocalMessages(message, notRW)
	message = message:gsub(">[^%s]+<", function(capture)
		capture = capture:sub(2, -2)
		if DBM.RaidClasses[capture] then
			capture = "|cff"..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].r)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].g)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].b)..capture.."|r"
		end
		return capture
	end)

	if message:find("^%*%*%*%s%s.+%s%s%*%*%*$") then -- color 2		
		DBMWarningFrame:AddMessage(message:sub(6, -6), DBM.Options.RaidWarningColors[2]["r"],  DBM.Options.RaidWarningColors[2]["g"],  DBM.Options.RaidWarningColors[2]["b"], DBM.Options.Gui["RaidWarning_Delay"])
	elseif message:find("^%*%*%*%s.+%s%*%*%*$") then -- color 1
		DBMWarningFrame:AddMessage(message:sub(5, -5), DBM.Options.RaidWarningColors[1]["r"],  DBM.Options.RaidWarningColors[1]["g"],  DBM.Options.RaidWarningColors[1]["b"], DBM.Options.Gui["RaidWarning_Delay"])
	elseif message:find("^%s%*%*%*%s.+%s%*%*%*%s$") then  -- color 3
		DBMWarningFrame:AddMessage(message:sub(6, -6), DBM.Options.RaidWarningColors[3]["r"],  DBM.Options.RaidWarningColors[3]["g"],  DBM.Options.RaidWarningColors[3]["b"], DBM.Options.Gui["RaidWarning_Delay"])
	elseif message:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then -- color 5
		DBMWarningFrame:AddMessage(message:sub(8, -8), DBM.Options.RaidWarningColors[5]["r"],  DBM.Options.RaidWarningColors[5]["g"],  DBM.Options.RaidWarningColors[5]["b"], DBM.Options.Gui["RaidWarning_Delay"])
	elseif message:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then -- color 4
		DBMWarningFrame:AddMessage(message:sub(7, -7), DBM.Options.RaidWarningColors[4]["r"],  DBM.Options.RaidWarningColors[4]["g"],  DBM.Options.RaidWarningColors[4]["b"], DBM.Options.Gui["RaidWarning_Delay"])
	else
		DBMWarningFrame:AddMessage(message,
				DBM.Options.Gui["SelfWarning_R"], 
				DBM.Options.Gui["SelfWarning_G"],
				DBM.Options.Gui["SelfWarning_B"],
				DBM.Options.Gui["SelfWarning_Delay"])
	end
		
	if not notRW then
		if message:find("^%*%*%*%s%s.+%s%s%*%*%*$") then -- color 2
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[2].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[2].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[2].b)..
			message:sub(6, -6).."|r"
		elseif message:find("^%*%*%*%s.+%s%*%*%*$") then -- color 1
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[1].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[1].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[1].b)..
			message:sub(5, -5).."|r"
		elseif message:find("^%s%*%*%*%s.+%s%*%*%*%s$") then  -- color 3
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[3].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[3].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[3].b)..
			message:sub(6, -6).."|r"
		elseif message:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then -- color 5
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[5].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[5].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[5].b)..
			message:sub(8, -8).."|r"
		elseif message:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then -- color 4
			message = "|cff"..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[4].r)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[4].g)..
			("%.2x"):format(255 * DBM.Options.RaidWarningColors[4].b)..
			message:sub(7, -7).."|r"
		else
			message = "|cff"..
			("%.2x"):format(255 * ChatTypeInfo["RAID_WARNING"].r)..
			("%.2x"):format(255 * ChatTypeInfo["RAID_WARNING"].g)..
			("%.2x"):format(255 * ChatTypeInfo["RAID_WARNING"].b)..
			message.."|r"
		end
		RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
	end
	
	DBM.PlaySound("RaidWarning")

end


function DBM.AddGuiTab(tab, text, title, bcTab)
	if DBM_Gui_AddTab and not DBM.VarsNotLoaded then
		DBM_Gui_AddTab(tab, text, title, bcTab);
	else
		if not DBM.GuiTabsToLoad then
			DBM.GuiTabsToLoad = {};
		end
		table.insert(DBM.GuiTabsToLoad, {tab, text, title, bcTab});
	end
end

function DBM.RemoveGuiTab(tab)
	if DBM_Gui_RemoveTab and not DBM.VarsNotLoaded then
		DBM_Gui_RemoveTab(tab, notActive);
	else
		if not DBM.GuiTabsToLoad then
			DBM.GuiTabsToLoad = {};
		end
		for i = table.maxn(DBM.GuiTabsToLoad), 1, -1 do
			if DBM.GuiTabsToLoad.tab == tab then
				table.remove(DBM.GuiTabsToLoad, i);
				break;
			end
		end		
	end
end

-- custom events

function DBM.FireEvent(event, arg1)
	if type(event) ~= "string" then
		return;
	end

	for index, value in pairs(DBM.AddOns) do
		if value.Options.Enabled and value.Events[event] and ((value.Instance == DBM_OTHER) or (value.Instance == GetRealZoneText()) or (GetLocale() == "esES" or GetLocale() == "koKR")) then
			if value.APIVersion and value.APIVersion >= 2.11 then
				DBM.AddOns[index]:OnEvent(event, arg1);
			else
				DBM.AddOns[index].OnEvent(event, arg1);
			end
		end
	end
end

function DBM_Gui_TabExists(tab)
	for index, value in pairs(DBM.GuiTabsToLoad) do
		if value.Tab == tab then
			return true;
		end
	end
	
	return false;
end

-- copied from "RaidTools" addon (removed in 2.60)

function DBM.CheckForSpam(event, msg, author)
	if not DBM.Options.SpamBlock or not event or not msg then return false; end
	
	local spamExpression = "^%s*([%*]+) (.+) ([%*]+)%s*$";
	local BGspamExpression = "^%w+: %w+[%s%w]*%s+%-%s+%d+:%d%d$"
	if (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER") and DBM.Options.SpamBlock.RaidChat and string.find(msg, spamExpression) then
		return true;
	elseif event == "CHAT_MSG_RAID_WARNING" and DBM.Options.SpamBlock.RaidWarningChat and string.find(msg, spamExpression) then
		return true;
	elseif event == "CHAT_MSG_CTRAID_WARNING" and DBM.Options.SpamBlock.CTRaidFrame and string.find(msg, spamExpression) then
		return true;
	elseif event == "CHAT_MSG_RAID_WARNING_FRAME" and DBM.Options.SpamBlock.RaidWarningFrame and string.find(msg, spamExpression) then
		return true;
	elseif (event == "CHAT_MSG_BATTLEGROUND" or event == "CHAT_MSG_BATTLEGROUND_LEADER") and author ~= UnitName("player") and DBM.Options.SpamBlock.Battleground and string.find(msg, BGspamExpression) then
		return true;
	else
		return false;
	end
end

function DBM.Announce_Pull(msg, announce)
	if msg == nil and type(announce) == "number" then
		DBM.Announce(string.format(DRT_PULLCOMMAND_PREWARN, announce), nil, nil, true);
	elseif msg == "pull" then
		DBM.Announce(DRT_PULLCOMMAND_ANNOUNCE, nil, nil, true);
		DBM.AddSpecialWarning(DRT_PULLCOMMAND_SELFWARN);
	else
		DBM.UnSchedule(DBM.Announce_Pull);

		local time = tonumber(msg);
		if time == nil or time > 30 then time = 15;	end

		for i = 1, (time-1), 1 do
			DBM.Schedule(time-i, DBM.Announce_Pull, nil, i);
		end
		DBM.Schedule(time, DBM.Announce_Pull, "pull");
		DBM.StartStatusBarTimer(time, "Incoming Pull");
	end
end

local function resetBarReqVar()
	justSentBarRequest = false
end
function DBM.RequestBars(verbose)
	local foundClients = 0;
	local randomNumber = math.random(1, 25);

	justSentBarRequest = true
	DBM.Schedule(4, resetBarReqVar)
	for i = randomNumber, GetNumRaidMembers() do
		if DBM.SyncInfo.Clients and UnitNameWithServer("raid"..i) ~= UnitName("player") and DBM.SyncInfo.Clients[UnitNameWithServer("raid"..i)] and tonumber(DBM.SyncInfo.Clients[UnitNameWithServer("raid"..i)]) >= 2.60 then
			if verbose and foundClients == 0 then
				DBM.AddMsg(string.format(DBM_REQUEST_BARS_FROM, UnitNameWithServer("raid"..i)));
			end
			SendAddonMessage("LVBM", "REQBARS", "WHISPER", UnitNameWithServer("raid"..i));
			foundClients = foundClients + 1;
			if foundClients >= 2 then
				break;
			end
		end
	end
	if foundClients < 2 then
		for i = randomNumber - 1, 1, -1 do
			if DBM.SyncInfo.Clients and UnitNameWithServer("raid"..i) ~= UnitName("player") and DBM.SyncInfo.Clients[UnitNameWithServer("raid"..i)] and tonumber(DBM.SyncInfo.Clients[UnitNameWithServer("raid"..i)]) >= 2.60 then
				if verbose and foundClients == 0 then
					DBM.AddMsg(string.format(DBM_REQUEST_BARS_FROM, UnitNameWithServer("raid"..i)));
				end
				SendAddonMessage("LVBM", "REQBARS", "WHISPER", UnitNameWithServer("raid"..i));
				foundClients = foundClients + 1;
				if foundClients >= 2 then
					break;
				end
			end
		end
	end
	
	if not foundClients == 0 and verbose then
		DBM.AddMsg(DBM_REQUEST_BARS_FAILED);
	end
end

function DBM.SendBarsToPlayer(target)
	if type(target) ~= "string" then
		return;
	end
	
	for index, value in pairs(DBM.StatusBarData) do
		if value then
			if value.syncedBar then
				DBM.SendBar(index, target);
			end
		end
	end
end

function DBM.SendBar(bar, target)
	if type(target) ~= "string" or type(bar) ~= "string" or type(DBM.StatusBarData[bar]) ~= "table" then
		return;
	end
	local barData = DBM.StatusBarData[bar];

	if barData.icon then
		table.insert(DBM.MsgQueue, {["msg"] = "LVBM STISBT "..barData.timer.." "..(barData.bossModID or "UNKNOWN").." #"..barData.icon.."# "..bar, ["target"] = target});
	else
		table.insert(DBM.MsgQueue, {["msg"] = "LVBM STSBT "..barData.timer.." "..(barData.bossModID or "UNKNOWN").." "..bar, ["target"] = target});
	end
	table.insert(DBM.MsgQueue, {["msg"] = "LVBM UPDISBT #"..bar.."# "..math.floor(tonumber(barData.elapsed)).." "..math.floor(tonumber(barData.timer)).." #".."nil".."# "..bar, ["target"] = target});
end


do
	local args = {}
	local function clearArgs()
		for i, v in pairs(args) do
			args[i] = nil
		end
	end
	
	function DBM.OnCombatLogEvent(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		if not event then return end
		
		local eventNeeded = false
		for i, v in pairs(DBM.AddOns) do
			if v.Options.Enabled and v.Events[event] and ((v.Instance == DBM_OTHER) or (v.Instance == GetRealZoneText()) or (GetLocale() == "esES" or GetLocale() == "koKR")) then
				eventNeeded = true
				break
			end
		end
		if not eventNeeded then
			return
		end
		
		clearArgs()

		args.timestamp = timestamp
		args.event = event
		args.sourceGUID = sourceGUID
		args.sourceName = sourceName
		args.sourceFlags = sourceFlags
		args.destGUID = destGUID
		args.destName = destName
		args.destFlags = destFlags
		-- taken from Blizzard_CombatLog.lua
		if event == "SWING_DAMAGE" then 
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(1, ...)
		elseif event == "SWING_MISSED" then 
			args.spellName = ACTION_SWING
			args.missType = select(1, ...)
		elseif event:sub(1, 5) == "RANGE" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "RANGE_DAMAGE" then 
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "RANGE_MISSED" then 
				args.missType = select(4, ...)
			end
		elseif event:sub(1, 5) == "SPELL" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "SPELL_DAMAGE" then
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "SPELL_MISSED" then 
				args.missType = select(4, ...)
			elseif event == "SPELL_HEAL" then 
				args.amount, args.critical = select(4, ...)
				args.school = args.spellSchool
			elseif event == "SPELL_ENERGIZE" then 
				args.valueType = 2
				args.amount, args.powerType = select(4, ...)
			elseif event:sub(1, 14) == "SPELL_PERIODIC" then
				if event == "SPELL_PERIODIC_MISSED" then
					args.missType = select(4, ...)
				elseif event == "SPELL_PERIODIC_DAMAGE" then
					args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
				elseif event == "SPELL_PERIODIC_HEAL" then
					args.amount, args.critical = select(4, ...)
					args.school = args.spellSchool
				elseif event == "SPELL_PERIODIC_DRAIN" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_LEECH" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_ENERGIZE" then 
					args.amount, args.powerType = select(4, ...)
					args.valueType = 2			
				end
			elseif event == "SPELL_DRAIN" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_LEECH" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_INTERRUPT" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
			elseif event == "SPELL_EXTRA_ATTACKS" then
				args.amount = select(4, ...)
			elseif event == "SPELL_INSTAKILL" then
			elseif event == "SPELL_DURABILITY_DAMAGE" then
			elseif event == "SPELL_DURABILITY_DAMAGE_ALL" then
			elseif event == "SPELL_DISPEL_FAILED" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
			elseif event == "SPELL_AURA_DISPELLED" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				args.auraType = select(7, ...)
			elseif event == "SPELL_AURA_STOLEN" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				args.auraType = select(7, ...)
			elseif event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED" then
				args.auraType = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
				args.auraType, args.amount = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_CAST_START" then
			elseif event == "SPELL_CAST_SUCCESS" then
			elseif event == "SPELL_CAST_FAILED" then 
				args.missType = select(4, ...)
			end
		elseif event == "DAMAGE_SHIELD" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
		elseif event == "DAMAGE_SHIELD_MISSED" then 
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.missType = select(4, ...)
		elseif event == "PARTY_KILL" then
		elseif event == "ENCHANT_APPLIED" then
			args.spellName = select(1,...)
			args.itemId, args.itemName = select(2,...)
		elseif event == "ENCHANT_REMOVED" then
			args.spellName = select(1,...)
			args.itemId, args.itemName = select(2,...)
		elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
			args.sourceName = args.destName
			args.sourceGUID = args.destGUID
			args.sourceFlags = args.destFlags
		elseif event == "ENVIRONMENTAL_DAMAGE" then
			args.environmentalType = select(1,...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(2, ...)
			args.spellName = getglobal("ACTION_"..event.."_"..args.environmentalType)
			args.spellSchool = args.school
		elseif event == "DAMAGE_SPLIT" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
		end

		for i, v in pairs(DBM.AddOns) do
			if v.Options.Enabled and v.Events[event] and ((v.Instance == DBM_OTHER) or (v.Instance == GetRealZoneText()) or (GetLocale() == "esES" or GetLocale() == "koKR")) then
				if v.APIVersion and v.APIVersion >= 2.11 then
					v:OnEvent(event, args)
				else
					v.OnEvent(event, args)
				end
			end
		end
	end
end
