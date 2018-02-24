
/\_*_/\_*_/\_*_/\ -- TooltipItemQuantities1 ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Library
Libraries used:
	none



-- == -- == -- Description of Functionality -- == -- == --

This embeddable addon is a library that tracks item quantities for tooltip Set<place>Item
methods, so that other addons which require quantity information to display appropriate
additional tooltip information will not have to hook those tooltip methods themselves.



-- == -- == -- History of Changes -- == -- == --

1.2.1 (Mar 6, 2008):
	- Miscellaneous code style updates.


1.2.0 (Jan 28, 2008):
	- Now supports the :SetGuildBankItem() tooltip method.


1.1.0 (Jan 19, 2008):
	- Miscellaneous efficiency updates.
	
	- Now hooks :SetHyperlink() as well so that tooltip.TooltipItemQuantities1:GetItemQuantity()
		will return the proper default quantity of 1 instead of whatever quantity was present on the
		tooltip prior to the :SetHyperlink() call.


1.0.0 (6/19/07):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

API functions:
	TooltipItemQuantities1.RegisterTooltip (tooltip)
		Usage:
			Embeds an object called "TooltipItemQuantities1" into the tooltip and hooks all of its
			item methods to cache the quantity for later retrieval through the method called
			tooltip.TooltipItemQuantitites1:GetItemQuantity().
		Args:
			1 - GameTooltip: the tooltip object to be registered.
		Returns:
			none
	
	tooltip.TooltipItemQuantities1:GetItemQuantity ()
		Args:
			none
		Returns:
			1 - integer: the quantity of items in the stack; can be 0.
			2 - string: the source tooltip method, such as "SetBagItem", for the quantity number.



-- == -- == -- License and Contact Information -- == -- == --

This addon may be used or modified in any way which exhibits full compliance with the
World of Warcraft Terms of Service (TOS) and End User License Agreement (EULA), as well
as the rules of the website from which the files were downloaded. You may redistribute this
addon, but only if it is completely unchanged from the way it was found in the zip file. If you
wish to distribute a modified version, you must first obtain permission directly from me.

If you found a bug in this addon, want to provide feedback, want to help translate it, or even
just want to ask a question, please contact me using one of these methods:

Email address: saeris.sanoora@gmail.com
ICQ number: 119161819
AIM screenname: SaerisSanoora
Penny Arcade forums name: Saeris

If you use any other method, it might take me significantly longer to see your message and reply.

If you wish to support my efforts, you can donate via PayPal by following this link:
http://tinyurl.com/yo4asg



-- == -- == -- Addon Type System -- == -- == --

This addon uses a system in which there are three distinct types:
	Interface - These addons actually provide functionality to the user. They may be entirely self-
		contained, or they may make use of Library-type and Plugin-type. They are always top-level,
		meaning that they appear in the addons configuration menu at the character selection screen.
	
	Library - These addons exist simply to provide functionality to other addons of any type, and
		as their type name suggests, they may be shared between multiple other addons as a single,
		efficient source of the aforementioned functionality. A Library type addon may be embedded
		(included in a subdirectory folder with the client addon, usually "\libraries\" or something similar)
		or non-embedded (existing as a top-level addon, such that it appears in the addons configuration
		menu at the character selection screen). Both types have their advantages, but if you wish to
		reduce login time and monitor memory and CPU usage properly, you must use non-embedded
		Libraries. To do this, simply ensure that only a single copy of the Library is present in the entirety
		of the "Interface\AddOns" directory structure, and that this single copy is at the top level, as
		explained before. For convenience, all Library-type addons are prefixed with "Lib-" to identify
		them from the other types of addons.
	
	Plugin - These addons are generally optional, and "plug in" to Interface-type addons to provide
		additional functionality. They are always top-level, meaning that they appear in the addons
		configuration menu at the character selection screen. Most Interface-type addons which use
		plugins will not actually provide any significant functionality on their own. Generally, Plugins
		will include the name of their parent Interface addon in their own name to help identify them.

An addon's type and any libraries it uses are listed at the top of its readme file.



-- == -- == -- Versioning System -- == -- == --

This addon adheres to a #.#.# versioning format:

The first number (the 1 in 1.2.3) denotes the current major version. This number is
incremented when the addon's functionality or style of code changes so significantly
as to barely resemble previous versions. For Library-type addons, which provide
functionality to client addons, this number is also a guarantee that every release
within this major version will be backwards compatible with previous releases that
are also within this major version. In these cases, this number is actually a suffix on the
library's name. This is done so newer major versions of libraries will not overwrite
older ones, since those may still be in use by other clients.

The second number (the 2 in 1.2.3) denotes the current minor version. This number
is incremented when functionality is added, modified, or removed.

The third number (the 3 in 1.2.3) denotes the current subminor version. This number is
incremented when a release's purpose is to fix bugs or errors, or to increase efficiency
in some way, or to make a minor cosmetic adjustment.
