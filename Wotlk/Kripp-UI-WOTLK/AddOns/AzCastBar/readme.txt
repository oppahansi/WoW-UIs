AzCastBar Addon
---------------
A highly customizable and lightweight casting bar replacement addon, with support for saved profiles and plugins.

The main release comes with the following plugins:
- Casting Bars (player, target, focus, pet)
- Mirror Bars (breath, feign death and fatigue)
- Player Auras (buff, debuff, tracking and weapon enchant timers)
- Target Auras (same as player auras, but for your target by default, can work as a dottimer)
The player cast bar supports safe zone indication for both cast and channeled spells. This "zone" represents your latency, when the spellcast has passed this point, you can safely cancel the cast and the spell will still fire.

The option dialog, along with the saved profiles are Load on Demand, which means it will only be loaded and take up memory when you're setting up the plugins.

The slash command for AzCastBar is "/acb". Using it will open the the option dialog.
You can clear all plugin settings and reset them to their defaults by using the slash command "/acb wipeconfig". This does not affect the saved profiles.

Plugin Support
--------------
This addon is build up around the possibility to add more bars with different functions, known as plugins.

The plugin package for this addon which you can find on WoWInterface includes the following plugins:
- Cooldown Timers (shows spell and ability cooldowns)
- Global Cooldown Timer (timer for your global cooldown)
- Loot Roll Timers (replaces the default loot roll windows)
- Battleground Timers (various battleground timers)
- Flight Timer (duration of flight path routes)
- Swing Timer (melee swing and auto shot timer)
- Totem Timers (timers for totems)
- Shaman Timers (weapon imbues, elemental shields and other things)

You can find the official plugin package here:
http://www.wowinterface.com/downloads/info8437-AzCastBarPlugins.html

Lacking Features, Ideas & Problems
----------------------------------
- CastBar: Add some kind of support for the new "not_interruptable" flag.
- CastBar: When crafting a tradeskill item, and you run out of mats or in other ways fail the craft, the cast bar may hang.
- Auras: I plan on adding a filter to this, so you can filter out any buffs you do not want to clutter up the bars.
- Core: Slash command to load saved profiles. Should initialise the Options LoD part, and load the given profile.
- LootRolls: Add option to size the buttons.
- Options: Shift clicking on a color, or right clicking, should pick the current class color.