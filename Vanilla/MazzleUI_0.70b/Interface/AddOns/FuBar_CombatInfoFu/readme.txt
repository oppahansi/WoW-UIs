FuBar - CombatInfoFu
by Dire of Ravencrest

Installation: Unzip to your WoW\Interface\Addons folder, enable in FuBar
Note: Due to the name changing, old settings won't load

Based on Titan Combat Info 1.51 and used several FuBar plugins as base.
Added weapon skills, since it was missing.

Thanks to Neriak for helping with several optimizations.

ChangeLog
0.61
	- Added semi-accurate ranged crit% for Hunters (melee crit+Lethal Shot talent)
0.6
	- Upgraded (hastily) to FuBar 102 compatibility
	- self.tooltip changed to TabletLib-style
	- dropdownmenu changed to DewdropLib-style
	- backwards compatibility not tested nor guaranteed
0.52
	- Per character savedvariables now
	- FuBarTooltip changed to self.tooltip
	- Added avoidance to display options
0.51
	- Name changed to reflect BossPanel's name changing
	- Added colorization to display
	- Some minor optimizations
0.50
	- Some random fixes
	- Added "Total avoidance"
	- Added check for Parry skill; WoW reports parry chance
		even for characters that can't parry
	- No longer "load on demand"; tooltip scanning broken otherwise
0.44
	- Hacked own tooltip
0.43
	- Quick fix for the 1.10 tooltip scanning bug
0.42
	- Yet more tooltip and update fixing; functions should no
		longer fire every registered event
0.41
	- Added a delay to hopefully remove tooltip hiding bug (?)
0.4
	- Separated localizations to different files
	- Optimized code (memory usage atleast)
0.3
	- Added melee and ranged AP displays
	- Added armor display (value and reduction %)
	- Added defense to tooltip
0.2
	- Fixed ranged AP display
	- GetCritChance() changed slightly
0.1
	- Initial release