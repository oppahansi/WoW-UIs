Ghost: Pulse 2 - Configuration Manual
Footrot of Khaz'goroth

------------
Introduction
------------

GP2 is an alert addon for World of Warcraft.  It is designed to 'pulse' images on the screen when important things happen, to save screen space.  This document outlines how to set it up.

The addon has two parts: Alerts and Frames.  The 'Alerts' configuration section is where you tell GP2 how you want the alerts to work, such as specifying the minimum length a spell cooldown must be before you're interested in knowing about it, and what colors and early warnings you want regarding the alert.  The 'Frames' configuration section is where you tell GP2 how the alerts should look, and what alerts should appear in which frames.

This document is a brief explanation of the main options.  A more detailed ReadMe.txt will appear soon.

------
Frames
------

Without a frame, GP2 can't show you anything.  You start with a single frame that only shows your own spell/ability cooldowns.  If you want GP2 to show you when you get a buff, you need to set up a frame to show you that.  You can have a single frame show you many different alerts, or you can have a frame for each alert, or something in between.

You can move frames around by unlocking the user interface for GP2, which is done by unchecking the 'Locked' option in the GP2 configuration panel.  You will see all your configured frames appear with their names on them, and you can just drag them around to put them where you like.  Once they're all positioned correctly, you can lock the interface again.

You can add a new frame by selecting the 'Frames' entry on the list on the left side of the panel and typing in a name for your new panel under the 'Add' header on the section to the right side.  Once your frame is created, you can select the frame (which now appears underneath the 'Frames') to further configure the frame.

Your options are...

Size			How big you want the frame to be.
Show Text		If switched on, the frame will show text about the alert when an alert is given using this frame.
Font Scale		This controls how big the text will be when you are showing text.  If you have 'Show Text' switched off for this frame, you won't see this option.
Alpha			This controls how transparent the frame is when fully shown.  A setting of 0 means invisible, while 1 means 'not see-through at all'.
Fade-In Time	When an alert is shown in this frame, this setting is used to control how quickly the frame becomes visible.
Hold Time		This controls how long the frame will be shown for before it fades out.
Fade-Out Time	This tells GP2 how quickly you want the frame to fade out when it has finished alerting you to something.
Override Sound	When an alert is shown, the sound that GP2 plays is usually controlled by the type of alert, but if you prefer, all alerts shown in this frame can
				use the same sound.  If this is what you want, change the sound here.
<Alerts>		Underneath all of those settings above, you will see a big list of check boxes.  The ones you have ticked on are the alerts that will show in this
				frame.
<Whitelist>		Each frame can filter the specific things shown in it.  A whitelist is a list of things that will be shown in the frame.  If you have anything at
				all in the whitelist, then only those things listed in the whitelist will ever show in the frame.  For example, if you have a frame that shows
				'Player Buff Gains' and a whitelist containing only 'Shadow Ward', then that frame will only ever alert you when you gain Shadow Ward.
<Blacklist>		If you don't use a whitelist for a frame, then anything the frame would normally show you will be filtered using the blacklist.  Putting something
				in the blacklist tells GP2 that you don't want to see that thing in this frame.  For example, if you have an empty whitelist, and put 'Shadow Ward'
				in the blacklist (and this example frame shows 'Player Buff Gains') then this frame will show every buff put on you, except for 'Shadow Ward'.

				NOTE: Both the whitelist and the blacklist are case-sensitive.  If you mean Shadow Ward, but type in shadow ward, then you will not get what you want.
Remove			If you decide you no longer want this frame, clicking on 'Remove' will get rid of it for you.

------
Alerts
------

By default, all alerts are enabled (but unless you have a frame to show them, they don't actually consume CPU time).  To see an alert, all you really need is a frame configured to show that alert type.  Using this section, you can control the conditions under which the alerts will 'fire'.

Your options are...

While Solo		If switched on, this alert will work while you are not in a party or raid.
In Party		If switched on, this alert will work while you are in a party.
In Raid			If switched on, this alert will work while you are in a raid.
In-Combat Only	If switched on, this alert will only work when you are actually in combat.
While Mounted	If switched on, this alert will work even when you are mounted.
Min Cooldown	For alerts that are based on cooldowns (not all are), this controls how long a cooldown must be (minimum) in order to 'fire'.  If you don't want
				to see alerts for cooldowns shorter than 5 seconds, then set this to 5, for example.
Max Cooldown	For alerts that are based on cooldowns (not all are), this controls how long a cooldown must be (maximum) in order to 'fire'.  If you don't want
				to see alerts for your hearthstone for example, set this to 3600 or lower (one hour).
Highlight Color	When this alert is shown, this color will be used to 'highlight' the frame(s) it is shown in.  Setting it to black will remove any highlight color.
Early Warning	If switched on, cooldown-based alerts will give you scrolling combat text ahead of time, letting you know that something will soon be ready for use.
Warning Time	This option is only visible if 'Early Warning' is switched on, and controls how far ahead of time you will get the SCT early warning about an
				impending cooldown alert.
Warning Color	This option is only visible if 'Early Warning' is switched on, and controls the color of the text for early warnings for this alert.
Warn Template	You can configure the actual text used to give you early warnings using this option.  The way you use this depends on the alert type...

				Player Buffs/Debuff Gains/Fades			[Name]		The name of the buff or debuff
														[Count]		Valid for debuff gains, this is 'how high' the debuff is currently stacked
				
				Bag Item Cooldowns						[Name]		The name of the item in your bags
														[Remaining]	The number of seconds until the item is available to use again
				
				Decurses								[Name]		The name of the debuff
														[Player]	The player who got the debuff
														[School]	A poor label for it, but is the type of debuff (magic, curse, poison, disease)
				
				Enemy Casts								[Name]		The name of the player/mob casting the spell
														[Spell]		The name of the spell/ability being cast
														[CastTime]	The cast time of the spell, in seconds
				
				Life Tap/Dark Pact						[Name]		Either 'Life Tap' or 'Dark Pact' depending on which spell you are advised to use
				
				Mana Potions/Gems						[Name]		The name of the mana potion or gem that you are advised to use
				
				Mob Debuffs								[Unit]		Either 'target' or 'focus'
														[Name]		The name of debuff that is about to expire
				
				Crowd Control							[Unit]		Either 'target' or 'focus'
														[Name]		The name of the crowd control effect detected
				
				Pet Spell Cooldowns						[Name]		The name of the spell/ability
														[Remaining]	The time left, in seconds, before the spell/ability will be ready again
				
				Player Death/Resurrection				[Name]		The name of the player who died, or was resurrected
				
				Player Spell Cooldowns					[Name]		The name of the spell/ability
														[Remaining]	The time left, in seconds, before the spell/ability will be ready again
				
				Player Spell Casts						[Name]		The name of the spell/ability you cast
				
				Player Spell Resist/Immune				[Name]		The name of the spell that was resisted or to which the mob/player is immune
				
				Trinket Cooldowns						[Name]		The name of the trinket
														[Remaining]	The time left, in seconds, before the trinket will be ready again
				
				Using these, you can configure your early warnings and frame text in a way that suits you.  For example, you could configure the early warning
				template for 'Player Spell Cooldowns' like this...
				
					[Name] ready in [Remaining] seconds
				
				And, is the spell that you are getting the early warning for is Shadowburn for example, the SCT would read...
				
					Shadowburn ready in 3.0 seconds
				
Text Template	Much the same as the early warning template, but instead is used to control the text for the frame itself when it shows this alert.
Sound			The sound to play when this alert is 'fired'.  If you're not using Shared Media, then you type the name of the sound in here, either from
				http://www.wowwiki.com/API_PlaySound or the name of an MP3 or WAV file in the Sounds folder of GhostPulse.  If you are using Shared Media,
				then this is a drop-down list of available sounds.
<Whitelist>		Like the frames' whitelists, this is a filter of the things you want to see.  If this list has anything in it, you will only see these things.
<Blacklist>		Like the frames' blacklists, this is a filter of the things you don't want to see.  If the whitelist is empty, then all things will show expect
				those things in the blacklist.
				
				NOTE: The filtering is done on a per-alert basis first.  Then the alert is 'given' to the frames for displaying, at which time the frame's own
				lists are used to further filter things.

