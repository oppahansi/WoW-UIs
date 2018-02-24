This is a list of the runes you can use to customise XPBarNone.

XP BAR
The default string used to create the XP Bar is:
Exp: [curXP]/[maxXP] ([restPC]) :: [curPC] through level [pLVL] :: [needXP] XP left :: [KTL] kills to level

This would be displayed as something like the following:
Exp: 10000/20000 (15.2%) :: 50.0% through level 27 :: 10000 XP left :: 4 kills to level

The available replacements are:

[curXP]		Current amount of XP.
[maxXP]		XP  needed to progress to the next level.
[restXP]	Amount of rested XP.
[restPC]	Amount of rested XP displayed as a percentage, the maximum amount of rested XP is 150%.
[curPC]		Your progress through the current level, displayed as a percentage.
[needPC]	The amount of XP you need to progress to the next level.  As a percentage.
[pLVL]		Your current level.
[needXP]	The amount of XP remaining until you level.
[KTL]		The amount of kills needed to level. (Can be inaccurate, for example, if you just got 10000 XP for handing a quest in)
[BTL]		Bars/Bubbles to level.  Since some people like to announce their progress this way.

REP BAR
The default string used to create the Reputation bar is:
Rep: [faction] ([standing]) [curRep]/[maxRep] :: [repPC]

This would be displayed as something like the following:
Rep: Sporeggar (Honored) 9000/12000 :: 75.0%

The available replacements are:

[faction]	Name of the current watched faction, eg.  Stormwing City, Sporeggar, The Consortium
[standing]	Current standing with the watched faction, eg. Hated, Friendly, Exalted.
[curRep]	Amount of reputation you have earned at the current standing.
[maxRep]	Reputation needed to progress to the next level.
[repPC]		Your progress through the current standing, displayed as a percentage.
[needRep]	Shows how many more rep points you need for the next rep level.
[needPC]	Shows how much more reputation you need to progress to the next level as a percentage.

