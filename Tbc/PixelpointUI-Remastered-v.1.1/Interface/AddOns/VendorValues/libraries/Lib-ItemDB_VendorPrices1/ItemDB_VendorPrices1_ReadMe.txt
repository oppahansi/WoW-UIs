
/\_*_/\_*_/\_*_/\ -- ItemDB_VendorPrices1 ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Library
Libraries used:
	CommonParsingTooltip1
	EventsManager1



-- == -- == -- Description of Functionality -- == -- == --

This embeddable addon is a library which manages a database of item vendor prices (how much
money can be obtained by selling an item to a vendor), for use by other addons which require such
data. It loads a static database (currently comprised of 18213 entries) from the DefaultDatabase
file and then stores any new or different prices in an errata table which is saved between sessions.



-- == -- == -- History of Changes -- == -- == --

1.0.1 (Apr 19, 2008):
	- Boosted default database from 15612 to 18213.
	
	- Miscellaneous code style updates.


1.0.0 (Jan 19, 2008):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

Prices are stored in copper, indexed by item base ID. A price of 0 means the item has been
confirmed as not sellable. If a price is nil, the item's price is (obviously) completely unknown.


API functions:
	db, size = GetActiveDB()
		Returns the active database (which has had the default/static database and the
		errata merged into it) and its size. The database is indexed by base ID and all of
		its keys are prices, except prices of 0 are stored as false instead to conserve memory.
	errata = GetErrata()
		Returns the errata table, which has an identical format to the database.
	price = GetPrice(baseID)
		Given the base ID for an item, returns the price in the database for that item.
	oldPrice, newPrice = SetPrice(baseID, newPrice)
		Given the base ID for an item, sets the price in the database for that item to
		newPrice, which can be either a number or nil. Returns the old price for the
		item, and the new price that was just set.


EventsManager1 custom events:
	ItemDB_VendorPrices1_DB_LOADED
		One-time event that fires when the prices database is loaded.
		Args:
			1 - table: the database table.
	
	ItemDB_VendorPrices1_UPDATE_DB_SIZE
		Fires when the size of the prices database changes.
		Args:
			1 - integer: the old size, 0 the first time this fires.
			2 - integer: the new size.
	
	ItemDB_VendorPrices1_ITEM_UPDATED
		Fires when an existing item's price is changed.
		Args:
			1 - integer: the base ID.
			2 - integer or nil: the old price.
			3 - integer or nil: the new price.



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
