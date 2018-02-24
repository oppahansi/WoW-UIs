DoTimer is a mod that displays duration timers for damage-over-time spells.  Originally intended just for warlocks, it now contains support for all classes.  It is written by Asheyla, 60 Undead Warlock, <Warcraft Gaming Faction>, Shattered Hand (Horde).  

Key Features:
- highly accurate
- separation of targets into their own sections
- icons or bars for graphics
- detection of resists, immunes, etc.
- smart removal of timers based on removal from mob, target death, etc.
- lots of macro support
- ghost timers: when clicked, they retarget; another click recasts the spell

Flaws:
- Blizzard does not give us unique target IDs.  To compensate:
-- I use a combination of name/sex/level/raid icon to ID them
-- I display timers which may be accurate for other targets of the same info, but I shrink the timers a bit
- the spellcast system is very uninformative.  To compensate:
-- I wrote a very complex spellsystem program to facilitate tracking spells.  it is highly accurate.

InGame Support:
- the /command is "/dotimer", or "/dot"
- simply typing the /command brings up the menu
- every single feature is explained indepth

Macros:
- unit defaults to target
- DoT_IsSpell(spell[,unit]): returns true if spell is on unit, else false and casts the spell
- DoT_IsPSpell(spell[,unit]): returns true if OWN PLAYER'S spell is on unit, else false and casts the spell
- others, documented ingame

Outside Support:
- send me an email or give me a comment!  i respond to everything.

EMBEDDED ADDONS:
- 1.2 brings Cooldowns and Communication, two embedded addons designed to enhance DoTimer.  IF YOU DO NOT WANT THEM, SIMPLY DELETE THEIR FOLDER.

- Cooldowns
-- functions exactly like DoTimer, except it provides cooldowns instead of durations
-- has the option of having separate timers, or ones integrated into DoTimer's target tables
-- /command: "/cooldowns" or "/cd"

- Communication
-- allows for timers from Cooldowns and DoTimer to be communicated to others in the party or raid.  by default, no timers are transmitted.
-- /command: "/comm"

1.2 CHANGES:
- refined SpellSystem for more accuracy
- Bug Fix: Growl
- New Addon: Cooldowns
- New Addon: Communication
- MUCH more memory-efficient coding
- targets separated by raid icon as well
- much more other-class support
- new DoTimer option: TBC compat mode: features TBC kills are disabled
- new option: blocking timers: in case an unwanted timer is tracked
- random bug fixes