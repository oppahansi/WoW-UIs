
/\_*_/\_*_/\_*_/\ -- CommonParsingTooltip1 ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Library
Libraries used:
	none



-- == -- == -- Description of Functionality -- == -- == --

This embeddable addon is a library that allows for tooltip parsing. It is intended for use
by developers to increase efficiency by sharing a single parsing tooltip.



-- == -- == -- History of Changes -- == -- == --

1.1.0 (Mar 5, 2008):
	- The tooltip.currentMoneyValue key is now set to nil prior to each function call, assuring that it
		will only have a value immediately after the tooltip has been set to an item with a price.
	
	- Miscellaneous code style updates.


1.0.0 (Nov 13, 2007):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

To use the tooltip, simply call CommonParsingTooltip1:<method>(args), where <method>
is one of the tooltip methods that populates the tooltip's lines with data:
	"SetBagItem",					"SetAction",					"SetAuctionItem",			"SetAuctionSellItem",
	"SetBuybackItem",			"SetCraftItem",			"SetCraftSpell",				"SetGuildBankItem",
	"SetHyperlink",				"SetInboxItem",			"SetInventoryItem",		"SetLootItem",
	"SetLootRollItem",			"SetMerchantItem",		"SetPetAction",				"SetPlayerBuff",
	"SetQuestItem",				"SetQuestLogItem",	"SetQuestRewardSpell",	"SetSendMailItem",
	"SetShapeshift",				"SetSpell",					"SetTalent",						"SetTrackingSpell",
	"SetTradePlayerItem",		"SetTradeSkillItem",	"SetTradeTargetItem",	"SetTrainerService",
	"SetUnit",						"SetUnitBuff",				"SetUnitDebuff"
You do not need to call :SetOwner() on the tooltip, as this is handled by the underlying code.

To access the tooltip's lines, index the tooltip.leftLines or tooltip.rightLines array. However, note
that these arrays are not traversable with pairs() or ipairs(). To iterate over all shown lines in the
tooltip, use the "for i = 1, tooltip:NumLines(), 1 do" method of traversal.

To determine the amount of money present on the tooltip (such as when parsing vendor prices),
as it has been set by the OnTooltipAddMoney script handler, check tooltip.currentMoneyValue.



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
