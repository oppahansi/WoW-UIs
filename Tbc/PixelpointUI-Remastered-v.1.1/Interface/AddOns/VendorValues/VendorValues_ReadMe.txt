
/\_*_/\_*_/\_*_/\ -- VendorValues ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Interface
Libraries used:
	ConfigManager1
	ItemDB_VendorPrices1 (or any vendor price library which implements the GetSellValue() function)
	SimpleSlash1
	TooltipItemQuantities1



-- == -- == -- Description of Functionality -- == -- == --

This addon displays in the game tooltip and chat tooltip the vendor prices of any items which you have
brought to a merchant. Type "/veva" for configuration options, including the text, color, and visibility of
the tooltip's money line prefix, and whether or not to include a separator line between the price line
and the rest of the tooltip.



-- == -- == -- History of Changes -- == -- == --

4.1.0 (Apr 19, 2008):
	- Fixed a bug where, if the tooltip was set to an item that wasn't yet cached, two lines of the tooltip
		would be improperly hidden.
	
	- Now uses ConfigManager1.
	
	- Miscellaneous code style updates.


4.0.1 (Jan 28, 2008):
	- Now uses version 1.2.0 of the TooltipItemQuantities1 library, which adds support for quantity
		information on guild bank item tooltips.


4.0.0 (Jan 19, 2008):
	- Rewritten for efficiency.
	
	- Now uses new library system.
	
	- Added :UpdateQuantity() method for clients with custom buttons with item tooltips.
	
	- Now uses the generic GetSellValue() developer-defined method to get vendor prices, instead
		of using a specific vendor price addon. Regardless, ItemDB_VendorPrices1 is still included in
		the distribution, since it participates in propagating the aforementioned function.


3.0.0 (6/24/07):
	- Rewritten to use the OnTooltipSetItem widget handler for GameTooltip objects, combined
		with the TooltipItemQuantities1 library, to improve efficiency.


2.1.0 (6/12/07):
	- Restructured all tooltip-individual data to reside within a table called VendorValues in the
		given tooltip, to avoid using so much of the tooltip object's base namespace. As a result
		of this, for example, the tooltip:VendorValues_AddVendorPrice() method is now instead
		accessed as tooltip.VendorValues:AddVendorPrice().


2.0.0 (6/7/07):
	- Rewritten to use the ItemsDB_VendorPrices library instead of maintaining its own database.
	
	- Now uses the EventsManager library to handle events.
	
	- Now uses the :GetItem() method on GameTooltip objects to obtain the link for the item being
		displayed, instead of using unique functions to do that within each individual hooked method.
		This increases efficiency and maintainability by reducing complexity.


1.4.2 (2/5/07):
	- Fixed an error that occurred when clicking on links in chat.


1.4.1 (2/1/07):
	- No longer attempts to send data messages through the guild addon channel when you are not in a guild.
	
	- Fixed a bug where the hidden parsing tooltip would occasionally erroneously not be hidden and appear
		at the top left corner of the screen.
	
	- Now forcibly hooks ChatFrame_MessageEventHandler to ensure that no data from the hidden channel
		is displayed. This is inefficient, but as of 2.0.6 it is the only way to block the channel with certainty.


1.4.0 (1/29/07):
	- Now broadcasts through the built-in guild addon data channel when broadcasting is enabled, in addition
		to the existing method of a hidden global chat channel.
	
	- Fixed a bug where the hidden global chat channel was not actually being hidden upon first login.
	
	- Updated TOC number to 20003.


1.3.0 (1/7/07):
	- Added about 2,000 more items to the static database.
	
	- Imported the new, more efficient vendor price parsing code from LootLink 7.8.3.


1.2.0 (12/28/06):
	- Fixed a bug where price data from the hidden channel could overwrite your existing data. Values from
		the channel will now only be stored if you have no value at all for the given item in your database.
		This is to prevent the proliferation of invalid values by spoofers.
	
	- As a result of the above, there is a new slash command option to accept data from specific players whom
		you have deemed trustworthy. Type "/veva trust [name]" to toggle trusting data from player [name].
	
	- Expanded the premade database from ~4,000 items to ~11,000 items, presumably thanks to "Colalight".
	
	- Fixed an error that sometimes popped up while parsing vendor prices, which occurred as a result of a
		Blizzard bug wherein tooltips do not create their needed FontString text lines until the tooltip is shown.


1.1.0 (12/26/06):
	- Changed the name of the hidden chat channel from "vendorvaluesdata" to "lootlinkdatasharing", which is
		the channel that LootLink uses now.
	
	- Imported the new, more efficient, more accurate vendor price parsing algorithm which appears in versions
		7.3.0 and later of my (Saeris's) LootLink, as well as the functionality changes from versions 7.6.0 and later,
		which are described below.
	
	- The vendor price line of the tooltip will now always be visible, and will display "<none>" for items which
		have been confirmed unsellable, or "<unknown>" for items with no known sell value.
	
	- As a corollary to the above, the Tooltips_AddVendorPrice method now returns two values: the
		monetary value which was added to the tooltip (either the amount of copper as an integer, false
		for unsellable, or nil for unknown), and the FontString object in the tooltip which contains the text
		which was just added.
	
	- Fixed a bug where the money frame of GameTooltip would remain colored non-white even after VendorValues
		was finished using it to display stored vendor price.


1.0.0 (12/12/06):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

API functions:
	VendorValues.Tooltips_RegisterTooltip (tooltip)
		Usage:
			Embeds an object called "VendorValues" into the tooltip. Through this object, one
			can access the methods described below. By default, only GameTooltip and
			ItemRefTooltip are registered.
		Args:
			1 - GameTooltip: the object which should have a "VendorValues" object embedded.
		Returns:
			none
	
	money, moneyLine, sepLine, moneyFrame = tooltip.VendorValues:AddVendorValue ([baseID || itemLink] [, quantity] [, r, g, b])
		Args:
			1a - integer: the base item ID of the item for which a vendor value should be displayed.
				If absent, the tooltip's :GetItem() method is used.
			1b - string: a standard item link from which the base ID can be extracted.
				If absent, the tooltip's :GetItem() method is used.
			2 - integer: the number of items in the "stack" upon which the tooltip is set; defaults to 1.
			3, 4, 5 - float, float, float: the RGB of the tooltip's money frame's text; defaults to the values
				in the saved variables config file, as specified by the user.
		Returns:
			tooltip.VendorValues:GetVendorValue()
	
	money, moneyLine, sepLine, moneyFrame = tooltip.VendorValues.GetVendorValue ()
		Args:
			none
		Returns:
			1 - integer: the amount of money on the tooltip.
			2 - FontString: the line of the tooltip to which the money frame is anchored.
			3 - FontString: the separator line, if one was added.
			4 - Frame: the money frame being used.
	
	tooltip.VendorValues.UpdateQuantity (newQuantity)
		Usage:
			Client addons with custom buttons with item tooltips can use this method to update
			just the quantity in the tooltip, since the TooltipItemQuantities1 library cannot usually
			detect quantities from tooltip:SetHyperlink().
		Args:
			1 - integer: the updated quantity to display in the tooltip.
		Returns:
			none



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
