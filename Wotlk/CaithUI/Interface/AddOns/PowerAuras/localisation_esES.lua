if (GetLocale() == "esES") then

PowaAuras.Anim[0] = "[Invisible]";
PowaAuras.Anim[1] = "Static";
PowaAuras.Anim[2] = "Flashing";
PowaAuras.Anim[3] = "Growing";
PowaAuras.Anim[4] = "Pulse";
PowaAuras.Anim[5] = "Bubble";
PowaAuras.Anim[6] = "Water drop";
PowaAuras.Anim[7] = "Electric";
PowaAuras.Anim[8] = "Shrinking";
PowaAuras.Anim[9] = "Flame";
PowaAuras.Anim[10] = "Orbit";

PowaAuras.BeginAnimDisplay[0] = "[None]";
PowaAuras.BeginAnimDisplay[1] = "Zoom In";
PowaAuras.BeginAnimDisplay[2] = "Zoom Out";
PowaAuras.BeginAnimDisplay[3] = "Fade In";
PowaAuras.BeginAnimDisplay[4] = "Left";
PowaAuras.BeginAnimDisplay[5] = "Top-Left";
PowaAuras.BeginAnimDisplay[6] = "Top";
PowaAuras.BeginAnimDisplay[7] = "Top-Right";
PowaAuras.BeginAnimDisplay[8] = "Right";
PowaAuras.BeginAnimDisplay[9] = "Bottom-Right";
PowaAuras.BeginAnimDisplay[10] = "Bottom";
PowaAuras.BeginAnimDisplay[11] = "Bottom-Left";
PowaAuras.BeginAnimDisplay[12] = "Bounce";

PowaAuras.EndAnimDisplay[0] = "[None]";
PowaAuras.EndAnimDisplay[1] = "Grow";
PowaAuras.EndAnimDisplay[2] = "Shrink";
PowaAuras.EndAnimDisplay[3] = "Fade Out";
PowaAuras.EndAnimDisplay[4] = "Spin";
PowaAuras.EndAnimDisplay[5] = "Spin In";

PowaAuras.Sound[0] = NONE;

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "Type /powa to view the options.",

	aucune = "None",
	aucun = "None",
	largeur = "Width",
	hauteur = "Height",
	mainHand = "main",
	offHand = "off",
	bothHands = "both",

	DebuffType =
	{
		Magic   = "Magic",
		Disease = "Disease",
		Curse   = "Curse",
		Poison  = "Poison",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC] = "CC",
		[PowaAuras.DebuffCatType.Silence] = "Silence",
		[PowaAuras.DebuffCatType.Snare] = "Snare",
		[PowaAuras.DebuffCatType.Stun] = "Stun",
		[PowaAuras.DebuffCatType.Root] = "Root",
		[PowaAuras.DebuffCatType.Disarm] = "Disarm",
		[PowaAuras.DebuffCatType.PvE] = "PvE",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "Buff",
		[PowaAuras.BuffTypes.Debuff] = "Debuff",
		[PowaAuras.BuffTypes.AoE] = "AOE Debuff",
		[PowaAuras.BuffTypes.TypeDebuff] = "Debuff type",
		[PowaAuras.BuffTypes.Enchant] = "Weapon Enchant",
		[PowaAuras.BuffTypes.Combo] = "Combo Points",
		[PowaAuras.BuffTypes.ActionReady] = "Action Usable",
		[PowaAuras.BuffTypes.Health] = "Health",
		[PowaAuras.BuffTypes.Mana] = "Mana",
		[PowaAuras.BuffTypes.EnergyRagePower] = "Rage/Energy/Runic",
		[PowaAuras.BuffTypes.Aggro] = "Aggro",
		[PowaAuras.BuffTypes.PvP] = "PvP",
		[PowaAuras.BuffTypes.Stance] = "Stance",
		[PowaAuras.BuffTypes.SpellAlert] = "Spell Alert", 
		[PowaAuras.BuffTypes.OwnSpell] = "My Spell Cooldown", 
		[PowaAuras.BuffTypes.StealableSpell] = "Stealable Spell",
		[PowaAuras.BuffTypes.PurgeableSpell] = "Purgeable Spell",
	},

	-- main
	nomEnable = "Activate Power Auras",
	aideEnable = "Enable all Power Auras effects",

	nomDebug = "Activate Debug Messages",
	aideDebug = "Enable Debug Messages",
	ListePlayer = "Page",
	ListeGlobal = "Global",
	aideMove = "Move the effect here.",
	aideCopy = "Copy the effect here.",
	nomRename = "Rename",
	aideRename = "Rename the selected effect's page.",
	nomTest = "Test",
	nomHide = "Hide all",
	nomEdit = "Edit",
	nomNew = "New",
	nomDel = "Delete",
	nomImport = "Import", 
	nomExport = "Export", 
	nomImportSet = "Import Set", 
	nomExportSet = "Export Set", 
	aideImport = "Press Ctrl-V to paste the Aura-string and press \'Accept\'",
	aideExport = "Press Ctrl-C to copy the Aura-string for sharing.",
	aideImportSet = "Press Ctrl-V to paste the Aura-Set-string and press \'Accept\' this will erase all auras on this page",
	aideExportSet = "Press Ctrl-C to copy all the Auras on this page for sharing.",
	aideDel = "Remove the selected effect (Hold CTRL to allow this button to work)",
	nomMove = "Move",
	nomCopy = "Copy",
	nomPlayerEffects = "Character effects",
	nomGlobalEffects = "Global\neffects",
	aideEffectTooltip = "(Shift-click to toggle effect ON or OFF)",

	-- editor
	nomSound = "Sound to play",
	aideSound = "Plays a sound at the beginning.",
	nomCustomSound = "OR soundfile:",
	aideCustomSound = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3' ;)",

	nomTexture = "Texture",
	aideTexture = "The texture to be shown. You can easily replace textures by changing the files Aura#.tga in the Addon's directory.",

	nomAnim1 = "Main Animation",
	nomAnim2 = "Secondary Animation",
	aideAnim1 = "Animate the texture or not, with various effects.",
	aideAnim2 = "This animation will be shown with less opacity than the main animaton. Attention, to not overload the screen.",

	nomDeform = "Deformation",
	aideDeform = "Stretch the texture in height or in width.",

	aideColor = "Click here to change the color of the texture.",
	aideFont = "Click here to pick Font. Press OK to apply the selection.",
	aideMultiID = "Enter here other Aura IDs to combine checks. Multiple IDs must be separated with '/'. Aura ID can be found as [#] on first line of Aura tooltip.", 
	aideTooltipCheck = "Also check the tooltip contains this text",

	aideBuff = "Enter here the name of the buff, or a part of the name, which must activate/deactivate the effect. You can enter several names (ex: Super Buff/Power)",
	aideBuff2 = "Enter here the name of the debuff, or a part of the name, which must activate/deactivate the effect. You can enter several names (ex: Dark Disease/Plague)",
	aideBuff3 = "Enter here the type of the debuff which must activate or deactivate the effect (Poison, Disease, Curse, Magic, CC, Silence, Stun, Snare, Root or None). You can enter several types (ex: Disease/Poison)",
	aideBuff4 = "Enter here the name of area of effect that must trigger this effect (like a rain of fire for example, the name of this AOE can be found in the combat log)",
	aideBuff5 = "Enter here the temporary enchant which must activate this effect : optionally prepend it with 'main/' or 'off/ to designate mainhand or offhand slot. (ex: main/crippling)",
	aideBuff6 = "Enter here the number of combo points that must activate this effect (ex : 1 or 1/2/3 or 0/4/5 etc...) ",
	aideBuff7 = "Enter here the name, or a part of the name, of an action in your action bars. The effect will be active when this action is usable.",
	aideBuff8 = "Enter here the name, or a part of the name, of a spell from your spellbook. You can enter a spell id [12345].",
	
	aideSpells = "Enter here the Spell Name that will trigger a spell alert Aura.",
	aideStacks = "Enter here the operator and the amount of stacks, required activate/deactivate the effect. Operator is required ex: '<5' '>3' '=11' '!5' '>=0' '<=6' '2-8'",

	aideStealableSpells = "Enter here the Stealable Spell Name that will trigger the Aura (use * for any stealable spell).", 
	aidePurgeableSpells = "Enter here the Purgeable Spell Name that will trigger the Aura (use * for any purgeable spell).", 

	aideUnitn = "Enter here the name of the unit, which must activate/deactivate the effect. You can enter only names, if they are in your raid or group.",
	aideUnitn2 = "Only for raid/group.",

	aideMaxTex = "Define the maximum number of textures available on the Effect Editor. If you add textures on the Mod directory (with the names AURA1.tga to AURA50.tga), you must indicate the correct number here.",
	aideAddEffect = "Add an effect for edition.",
	aideWowTextures = "Check this to use the texture of WoW instead of textures in the Power Auras directory for this effect.",
	aideTextAura = "Check this to type text instead of texture.",
	aideRealaura = "Real Aura",
	aideCustomTextures = "Check this to use textures in the 'Custom' subdirectory. Put the name of the texture below (ex: myTexture.tga). You can also use a Spell Name (ex: Feign Death) or SpellID (ex: 5384).",
	aideRandomColor = "Check this to tell this effect to use random color each time it will be activated.",

	aideTexMode = "Uncheck this to use the texture opacity. By default, the darkest colors will be more transparent.",

	nomActivationBy = "Activation by :",

	nomOwnTex = "Use own Texture",
	aideOwnTex = "Use the De/Buff or Ability Texture instead.",
	nomStacks = "Stacks",

	nomUpdateSpeed = "Update speed",
	nomSpeed = "Animation speed",
	nomFPS = "Global Animation FPS",
	nomTimerUpdate = "Timer update speed",
	nomBegin = "Begin Animation",
	nomEnd = "End Animation",
	nomSymetrie = "Symmetry",
	nomAlpha = "Opacity",
	nomPos = "Position",
	nomTaille = "Size",

	nomExact = "Exact Name",
	nomThreshold = "Threshold",
	aideThreshInv = "Check this to invert the threshold logic. Unchecked = Low Warning / Checked = High Warning.",
	nomThreshInv = "</>",
	nomStance = "Stance",

	nomMine = "Cast by me",
	aideMine = "Check this to test only buffs/debuffs cast by the player",
	nomDispellable = "I can dispell",
	aideDispellable = "Check to show only buffs that are dispellable",
	nomCanInterrupt = "Can be Interrupted",
	aideCanInterrupt = "Check to show only for spells that can be Interrupted",

	nomPlayerSpell = "Player Casting",
	aidePlayerSpell = "Check if Player is casting a spell",

	nomCheckTarget = "Enemy Target",
	nomCheckFriend = "Friendly Target",
	nomCheckParty = "Partymember",
	nomCheckFocus = "Focus",
	nomCheckRaid = "Raidmember",
	nomCheckGroupOrSelf = "Raid/Party or self",
	nomCheckGroupAny = "Any", 
	nomCheckOptunitn = "Unitname",

	aideTarget = "Check this to test an enemy target only.",
	aideTargetFriend = "Check this to test a friendly target only.",
	aideParty = "Check this to test a party member only.",
	aideGroupOrSelf = "Check this to test a party or raid member or self.",
	aideFocus = "Check this to test the focus only.",
	aideRaid = "Check this to test a raid member only.",
	aideGroupAny = "Check this to test buff on 'Any' party/raid member. Unchecked: Test that 'All' are buffed.",
	aideOptunitn = "Check this to test a special char in raid/group only.",	
	aideExact = "Check this to test the exact name of the buff/debuff/action.",
	aideStance = "Select which Stance,Aura or Form trigger the event.",

	aideShowSpinAtBeginning= "At the end of the begin animation show a 360 degree spin",
	nomCheckShowSpinAtBeginning = "Show Spin after begin animation ends",

	nomCheckShowTimer = "Show",
	nomTimerDuration = "Duration",
	aideTimerDuration = "Show a timer to simulate buff/debuff duration on the target (0 to deactivate)",
	aideShowTimer = "Check this to show the timer of this effect.",
	aideSelectTimer = "Select which timer will show the duration",
	aideSelectTimerBuff = "Select which timer will show the duration (this one is reserved for player's buffs)",
	aideSelectTimerDebuff = "Select which timer will show the duration (this one is reserved for player's debuffs)",

	nomCheckShowStacks = "Show",

	nomCheckInverse = "Invert",
	aideInverse = "Invert the logic to show this effect only when buff/debuff is not active.",	

	nomCheckIgnoreMaj = "Ignore uppercase",	
	aideIgnoreMaj = "Check this to ignore upper/lowercase of buff/debuff names.",

	nomDuration = "Anim. duration",
	aideDuration = "After this time, this effect will disapear (0 to deactivate)",

	nomCentiemes = "Show hundredth",
	nomDual = "Show two timers",
	nomHideLeadingZeros = "Hide Leading Zeros",
	nomTransparent = "Use transparent textures",
	nomUpdatePing = "Animate on refresh",
	nomClose = "Close",
	nomEffectEditor = "Effect Editor",
	nomAdvOptions = "Options",
	nomMaxTex = "Maximum of textures available",
	nomTabAnim = "Animation",
	nomTabActiv = "Activation",
	nomTabSound = "Sound",
	nomTabTimer = "Timer",
	nomTabStacks = "Stacks",
	nomWowTextures = "WoW Textures",
	nomCustomTextures = "Custom Textures",
	nomTextAura = "Text Aura",
	nomRealaura = "Real Aura",
	nomRandomColor = "Random Colors",
	nomTexMode = "Glow",

	nomTalentGroup1 = "Spec 1",
	aideTalentGroup1 = "Show this effect only when you are in your primary talent spec.",
	nomTalentGroup2 = "Spec 2",
	aideTalentGroup2 = "Show this effect only when you are in your secondary talent spec.",

	nomReset = "Reset Editor Positions",	
	nomPowaShowAuraBrowser = "Show Aura Browser",
	
	nomDefaultTimerTexture = "Default Timer Texture",
	nomTimerTexture = "Timer Texture",
	nomDefaultStacksTexture = "Default Stacks Texture",
	nomStacksTexture = "Stacks Texture",
	
	Enabled = "Enabled",
	Default = "Default",

	Ternary = {
		combat = "In Combat",
		inRaid = "In Raid",
		inParty = "In Party",
		isResting = "Resting",
		ismounted = "Mounted",
		inVehicle = "In Vehicle",
		isAlive= "Alive",
	},

	nomWhatever = "Ignored",
	aideTernary = "Sets how the status effects how this aura is shown.",
	TernaryYes = {
		combat = "Only When In Combat",
		inRaid = "Only When In Raid",
		inParty = "Only When In Party",
		isResting = "Only When Resting",
		ismounted = "Only When Mounted",
		inVehicle = "Only When In Vehicle",
		isAlive= "Only When Alive",
	},
	TernaryNo = {
		combat = "Only When Not in Combat",
		inRaid = "Only When Not in Raid",
		inParty = "Only When Not in Party",
		isResting = "Only When Not Resting",
		ismounted = "Only When Not Mounted",
		inVehicle = "Only When Not in Vehicle",
		isAlive= "Only When Dead",
	},
	TernaryAide = {
		combat = "Effect modified by Combat status.",
		inRaid = "Effect modified by Raid status.",
		inParty = "Effect modified by Party status.",
		isResting = "Effect modified by Resting status.",
		ismounted = "Effect modified by Mounted status.",
		inVehicle = "Effect modified by Vehicle status.",
		isAlive= "Effect modified by Alive status.",
	},

	nomTimerInvertAura = "Invert Aura When Time Below",
	aidePowaTimerInvertAuraSlider = "Invert the aura when the duration is less than this limit (0 to deactivate)",
	nomTimerHideAura = "Hide Aura & Timer Until Time Above",
	aidePowaTimerHideAuraSlider = "Hide the aura and timer when the duration is greater than this limit (0 to deactivate)",

	aideTimerRounding = "When checked will round the timer up",
	nomTimerRounding = "Round Timer Up",

	aideGTFO = "Use GTFO (Boss) spell matches for AoE detection",
	nomGTFO = "Use GTFO for AoE",

	nomIgnoreUseable = "Display Only Depends on Cooldown",
	aideIgnoreUseable = "Ignores if spell is usable (just uses cooldown)",

	-- Diagnostic reason text, these have substitutions (using $1, $2 etc) to allow for different sententance constructions
	nomReasonShouldShow = "Should show because $1",
	nomReasonWontShow   = "Won't show because $1",
	
	nomReasonMulti = "All multiples match $1", --$1=Multiple match ID list
	
	nomReasonDisabled = "Power Auras Disabled",
	nomReasonGlobalCooldown = "Ignore Global Cooldown",
	
	nomReasonBuffPresent = "$1 has $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 has Debuff Misery")
	nomReasonBuffMissing = "$1 doesn't have $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 doesn't have Debuff Misery")
	nomReasonBuffFoundButIncomplete = "$2 $3 found for $1 but\n$4", --$1=Target $2=BuffType, $3=BuffName, $4=IncompleteReason (e.g. "Debuff Sunder Armor found for Target but\nStacks<=2")
	
	nomReasonOneInGroupHasBuff     = "$1 has $2 $3",            --$1=GroupId   $2=BuffType, $3=BuffName (e.g. "Raid23 has Buff Blessing of Kings")
	nomReasonNotAllInGroupHaveBuff = "Not all in $1 have $2 $3", --$1=GroupType $2=BuffType, $3=BuffName (e.g. "Not all in Raid have Buff Blessing of Kings")
	nomReasonAllInGroupHaveBuff    = "All in $1 have $2 $3",     --$1=GroupType $2=BuffType, $3=BuffName (e.g. "All in Raid have Buff Blessing of Kings")
	nomReasonNoOneInGroupHasBuff   = "No one in $1 has $2 $3",  --$1=GroupType $2=BuffType, $3=BuffName (e.g. "No one in Raid has Buff Blessing of Kings")

	nomReasonBuffPresentTimerInvert = "Buff present, timer invert",
	nomReasonBuffFound              = "Buff present",
	nomReasonStacksMismatch         = "Stacks = $1 expecting $2", --$1=Actual Stack count, $2=Expected Stack logic match (e.g. ">=0")

	nomReasonAuraMissing = "Aura missing",
	nomReasonAuraOff     = "Aura off",
	nomReasonAuraBad     = "Aura bad",
	
	nomReasonNotForTalentSpec = "Aura not active for this talent spec",
	
	nomReasonPlayerDead     = "Player is DEAD",
	nomReasonPlayerAlive    = "Player is Alive",
	nomReasonNoTarget       = "No Target",
	nomReasonTargetPlayer   = "Target is you",
	nomReasonTargetDead     = "Target is Dead",
	nomReasonTargetAlive    = "Target is Alive",
	nomReasonTargetFriendly = "Target is Friendly",
	nomReasonTargetNotFriendly = "Target not Friendly",
	
	nomReasonNotInCombat = "Not in combat",
	nomReasonInCombat = "In combat",
	
	nomReasonInParty = "In Party",
	nomReasonInRaid = "In Raid",
	nomReasonNotInParty = "Not in Party",
	nomReasonNotInRaid = "Not in Raid",
	nomReasonNoFocus = "No focus",	
	nomReasonNoCustomUnit = "Can't find custom unit not in party, raid or with pet unit=$1",

	nomReasonNotMounted = "Not Mounted",
	nomReasonMounted = "Mounted",		
	nomReasonNotInVehicle = "Not In Vehicle",
	nomReasonInVehicle = "In Vehicle",		
	nomReasonNotResting = "Not Resting",
	nomReasonResting = "Resting",		
	nomReasonStateOK = "State OK",

	nomReasonInverted        = "$1 (inverted)", -- $1 is the reason, but the inverted flag is set so the logic is reversed
	
	nomReasonSpellUsable     = "Spell $1 usable",
	nomReasonSpellNotUsable  = "Spell $1 not usable",
	nomReasonSpellNotReady   = "Spell $1 Not Ready, on cooldown, timer invert",
	nomReasonSpellNotEnabled = "Spell $1 not enabled ",
	nomReasonSpellNotFound   = "Spell $1 not found",
	nomReasonSpellOnCooldown = "Spell $1 on Cooldown",
	
	nomReasonStealablePresent = "$1 has Stealable spell $2", --$1=Target $2=SpellName (e.g. "Focus has Stealable spell Blessing of Wisdom")
	nomReasonNoStealablePresent = "Nobody has Stealable spell $1", --$1=SpellName (e.g. "Nobody has Stealable spell Blessing of Wisdom")
	nomReasonRaidTargetStealablePresent = "Raid$1Target has has Stealable spell $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Stealable spell Blessing of Wisdom")
	nomReasonPartyTargetStealablePresent = "Party$1Target has has Stealable spell $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Stealable spell Blessing of Wisdom")
	
	nomReasonPurgeablePresent = "$1 has Purgeable spell $2", --$1=Target $2=SpellName (e.g. "Focus has Purgeable spell Blessing of Wisdom")
	nomReasonNoPurgeablePresent = "Nobody has Purgeable spell $1", --$1=SpellName (e.g. "Nobody has Purgeable spell Blessing of Wisdom")
	nomReasonRaidTargetPurgeablePresent = "Raid$1Target has has Purgeable spell $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Purgeable spell Blessing of Wisdom")
	nomReasonPartyTargetPurgeablePresent = "Party$1Target has has Purgeable spell $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Purgeable spell Blessing of Wisdom")

	nomReasonAoETrigger = "AoE $1 triggered", -- $1=AoE spell name
	nomReasonAoENoTrigger = "AoE no trigger for $1", -- $1=AoE spell match
	
	nomReasonEnchantMainInvert = "Main Hand $1 enchant found, timer invert", -- $1=Enchant match
	nomReasonEnchantMain = "Main Hand $1 enchant found", -- $1=Enchant match
	nomReasonEnchantOffInvert = "Off Hand $1 enchant found, timer invert"; -- $1=Enchant match
	nomReasonEnchantOff = "Off Hand $1 enchant found", -- $1=Enchant match
	nomReasonNoEnchant = "No enchant found on weapons for $1", -- $1=Enchant match

	nomReasonNoUseCombo = "You do not use combo points",
	nomReasonComboMatch = "Combo points $1 match $2",-- $1=Combo Points, $2=Combo Match
	nomReasonNoComboMatch = "Combo points $1 no match with $2",-- $1=Combo Points, $2=Combo Match

	nomReasonActionNotFound = "not found on Action Bar",
	nomReasonActionReady = "Action Ready",
	nomReasonActionNotReadyInvert = "Action Not Ready (on cooldown), timer invert",
	nomReasonActionNotReady = "Action Not Ready (on cooldown)",
	nomReasonActionlNotEnabled = "Action not enabled",
	nomReasonActionNotUsable = "Action not usable",

	nomReasonYouAreCasting = "You are casting $1", -- $1=Casting match
	nomReasonYouAreNotCasting = "You are not casting $1", -- $1=Casting match
	nomReasonTargetCasting = "Target casting $1", -- $1=Casting match
	nomReasonFocusCasting = "Focus casting $1", -- $1=Casting match
	nomReasonRaidTargetCasting = "Raid$1Target casting $2", --$1=RaidId $2=Casting match
	nomReasonPartyTargetCasting = "Party$1Target casting $2", --$1=PartyId $2=Casting match
	nomReasonNoCasting = "Nobody's target casting $1", -- $1=Casting match
	
	nomReasonStance = "Current Stance $1, matches $2", -- $1=Current Stance, $2=Match Stance
	nomReasonNoStance = "Current Stance $1, does not match $2", -- $1=Current Stance, $2=Match Stance

	ReasonStat = {
		Health     = {MatchReason="$1 Health low",          NoMatchReason="$1 Health not low enough"},
		Mana       = {MatchReason="$1 Mana low",            NoMatchReason="$1 Mana not low enough"},
		RageEnergy = {MatchReason="$1 EnergyRagePower low", NoMatchReason="$1 EnergyRagePower not low enough"},
		Aggro      = {MatchReason="$1 has aggro",           NoMatchReason="$1 does not have aggro"},
		PvP        = {MatchReason="$1 PvP flag set",        NoMatchReason="$1 PvP flag not set"},
	},

});

end
