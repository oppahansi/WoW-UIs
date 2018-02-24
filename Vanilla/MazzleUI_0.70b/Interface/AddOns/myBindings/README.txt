_____________________________________________________________________________________

myBindings

Author:   Turan (turan@wowace.com)
Version:  1.3
Release:  10/11/2005
Website:  http://www.wowace.com
_____________________________________________________________________________________


myBindings is a two-pane key-bindings browser that replaces the standard WoW key
bindings interface. Manage your key bindings through an easy-to-use categorized
interface.

_____________________________________________________________________________________

	FEATURES
_____________________________________________________________________________________

- Two-pane viewing of bindings, a left-side menu with the binding buttons on the
  right.
- Bindings are separated into categories. (Most will appear in the "Others" category
  until AddOns are updated to place themselves into another category.)
- Confirmation when you are about to bind an already bound key.
- The addition of an "Unbind" button.
- Per profile (e.g., class and character) bindings through Ace.
- myBindings replaces the "Key Bindings" button already on your game menu.

_____________________________________________________________________________________

PER CHARACTER/CLASS BINDINGS
_____________________________________________________________________________________

myBindings uses Ace's profile system to allow for per character or class bindings.
To use either, enter one of the following commands:

/ace profile char mybindings
/ace profile class mybindings

_____________________________________________________________________________________

	CATEGORIZE YOUR BINDINGS
_____________________________________________________________________________________

myBindings lets you categorize your own addons, but be warned that it is not an
entirely simple process. You need to know the addon's binding header for starters.
This will be found in its Bindings.xml file. You may see several binding lines with
header="<somevalue>" and you'll need them all. Once you've looked these up, there
are three ways to categorize the addon.

----------
 Method 1
----------

This method requires editing the addon's lua file. Generally this option will be
used by the addon author. It involves simply placing a line in the addon's lua file
somewhere to set a global variable of the format: BINDING_CATEGORY_<HEADER> where
<HEADER> matches the header used in the Bindings.xml file.

For example, myBindings would set its category like this:

	BINDING_CATEGORY_MYBINDINGS = "interface"

----------
 Method 2
----------

This method is available to allow you to categorize your addons in a file without
needing to update each individual addon every time you upgrade.

First copy the stub category file from myBindings\extras\myBindingsCategories.lua to
myBindings\myBindingsCategories.lua. If this file is in the root myBindings folder,
myBindings will load it on startup. This ensures that your categories override those
embedded in the individual addons.

Next open the file in a text editor and create as many binding lines as you need to.
There are further instructions in the file.

----------
 Method 3
----------

The third method is to use the myBindings chat command in game. For that you just
need to know the header, or headers, and the category. The format is:
/mybindings setcat <header> <category>

For example, to change myBindings in game to the "Others" category, you would enter
the following:

	/mybindings setcat mybindings others

Note that case is important on the header, but myBindings will try full uppercase
and lowercase combinations to find the header. Also, any categories you set here
will override those set in the addon and in your categories file, if you have one.

_____________________________________________________________________________________

	CATEGORY LIST
_____________________________________________________________________________________

bars			: Interface Bars
chat			: Chat/Communications
class			: Class Enhancement
combat			: Combat/Casting
compilations	: Compilations
interface		: Interface Enhancements
inventory		: Inventory/Item Enhancements
map				: Map Enhancements
others			: Others
professions		: Professions
quests			: Quest Enhancements
raid			: Raid Assistance

_____________________________________________________________________________________

	CREDITS
_____________________________________________________________________________________

- Scheid and his myAddOns tool, which I both support and borrowed a great deal from
  to create myBindings.
- SyIG for the French translation.
- Worrel for the German translation.

_____________________________________________________________________________________

	VERSION HISTORY
_____________________________________________________________________________________

[2005-10-11] v1.3
- Updated for game patch 1.8.
- Fixed an error introduced by the on demand nature of the default key binding UI.
  myBindings made use of one of the functions of that UI. The quick fix was to copy
  that function directly into myBindings.

[2005-08-26] v1.2
- Added categorization options.

[2005-08-22] v1.1
- myBindings is now based on Ace, giving it the ability to store bindings in
  the currently loaded Ace profile.