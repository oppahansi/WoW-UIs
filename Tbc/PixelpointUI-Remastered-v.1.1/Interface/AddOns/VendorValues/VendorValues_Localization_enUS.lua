

local f = VendorValues.Localization;

if (f.NOT_LOADED == nil) then return; end
-- This localization file is the fallback in case no others load, so the following line should remain commented out.
--if (GetLocale() ~= "enUS") then return; end
f.NOT_LOADED = nil;



f.DEFAULT_PREFIX = ("Vendor value:");
f.DEFAULT_PREFIX_STACK = ("Vendor value for %d:");


f.SLASH_COMMANDS = {
	PREFIX_1 = ("/veva");
	
	PREFIX = ("prefix");
	PREFIX_USAGE = ("Example: \"/veva prefix Vendor value:\"\nSet the tooltip money line prefix text for non-stackable items. The default is \"Vendor value:\".");
	PREFIX_STATUS = ("The tooltip money line prefix text for non-stackable items is #s set to \"#r\".");
	
	PREFIXSTACK = ("prefixstack");
	PREFIXSTACK_USAGE = ("Example: \"/veva prefixstack Vendor value for %d:\"\nSet the tooltip money line prefix text for stackable items. The text should contain the token \"%d\" to represent the number of items in the stack. The default is \"Vendor value for %d:\".");
	PREFIXSTACK_STATUS = ("The tooltip money line prefix text for stackable items is #s set to \"#r\".");
	
	HIDEPREFIX = ("hideprefix");
	HIDEPREFIX_USAGE = ("Example: \"/veva hideprefix\"\nToggle whether the tooltip money line prefix text is completely hidden. By default it is shown.");
	HIDEPREFIX_STATUS = ("The tooltip money line prefix text is #s set to be #r.");
	HIDEPREFIX_STATUS_TRUE = ("hidden");
	HIDEPREFIX_STATUS_FALSE = ("shown");
	
	SEPARATOR = ("separator");
	SEPARATOR_USAGE = ("Example: \"/veva separator\"\nToggle whether a separator line will be shown between the vendor price line and the rest of the tooltip.");
	SEPARATOR_STATUS = ("The separator line between the vendor price line and the rest of the tooltip is #s set to be #r.");
	SEPARATOR_STATUS_SHOWN = ("shown");
	SEPARATOR_STATUS_HIDDEN = ("hidden");
	
	RED = ("red");
	RED_USAGE = ("Example: \"/veva red 1.0\"\nSet the \"red\" portion of the RGB value of the tooltip money line prefix text and the separator line. Must be a number between 0.0 and 1.0, inclusive. 1.0 by default.");
	RED_STATUS = ("The \"red\" portion of the RGB value of the tooltip money line prefix text and the separator line is #s set to #r.");
	
	GREEN = ("green");
	GREEN_USAGE = ("Example: \"/veva green 1.0\"\nSet the \"green\" portion of the RGB value of the tooltip money line prefix text and the separator line. Must be a number between 0.0 and 1.0, inclusive. 1.0 by default.");
	GREEN_STATUS = ("The \"green\" portion of the RGB value of the tooltip money line prefix text and the separator line is #s set to #r.");
	
	BLUE = ("blue");
	BLUE_USAGE = ("Example: \"/veva blue 1.0\"\nSet the \"blue\" portion of the RGB value of the tooltip money line prefix text and the separator line. Must be a number between 0.0 and 1.0, inclusive. 1.0 by default.");
	BLUE_STATUS = ("The \"blue\" portion of the RGB value of the tooltip money line prefix text and the separator line is #s set to #r.");
};

