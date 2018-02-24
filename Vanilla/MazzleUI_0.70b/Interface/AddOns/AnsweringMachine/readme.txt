What it does:
Answering Machine stores your tells while you are AFK or DND and plays them back to you when you return.

Version history:
1.11 -	Removed a bug when returning from DND
	Added French localization - Thanks Sasmira of Curse-Gaming!
	Switching to and from AFK and DND while one or the other is not set to record appears to be working properly now

1.10 -	Frame wasn't correctly docked to the player frame, this has been corrected
	Changed /answer to /answer default
	Added /answer frame - toggles and frame on and off
	Added /answer afk - toggles whether or not to record while afk
	Added /answer dnd - toggles whether or not to record while dnd

	Known issues:
	A bug exists while going AFK in the battlegrounds. Let's just say I'm not going to fix this because I don't condone deserting.  The real reason is it's just too much effort to fix for this.  If you need to /afk out of BGs just make sure you flag /afk again when you zone out.

	There are some problems when moving directly to and from /afk and /dnd status when one or the other is not set to record.  Example:
	You are not recording DND messages.  You go AFK.  You move straight from AFK to DND.  You return from DND.  You will have missed all messages you received while DND

	Support for french and german is implemented, but translations are needed

1.00 -	Movable frame now displays missed tells, originally docked above player portrait
	Corrected some french translations

0.80 -	Fixed a bug with the german clients
	Added translations to french and german clients
	Made playback of messages less confusing

0.70 -	Rewrote code to be more compatible with changes by blizzard, localization
	Added support for DND
	Allows for customized default AFK messages (/answer)
	Should work for non-english clients now; however, all messages are currently in english

0.65 -	Answering Machine v0.60 only worked with the default away message, now it works with custom away messages

0.60 -	initial release

Installation instructions:
Extract to your World of Warcraft\Interface\AddOns directory

Configuration:
/answer changes your default away message
Syntax: /answer <new away message>

Example:
You want to farm things until you pass out
/answer I passed out
when you're AFK flags comes on due to idling, it will use that message.  your default /afk will also display that
the default away message is restored next time you log into the game