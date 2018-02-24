local L = LibStub("AceLocale-3.0"):NewLocale("ErrorMonster", "enUS", true)

L["addon_desc"] = "ErrorMonster is a companion that throttles and redirects errors, system messages and information messages from the UI error frame to any other frame supported by LibSink-2.0.\n\nTo configure where ErrorMonster should redirect messages, please expand the tree on the side and go to the Output section.\n\nBelow you can toggle which kinds of messages to intercept. By default, ErrorMonster only deals with actual errors (the red ones).\n\n"
L["Output"] = true
L["Error"] = true
L["Information"] = true
L["System"] = true
L["Error messages."] = true
L["Information messages."] = true
L["System messages."] = true
L["Hide all messages in combat"] = true
L["Hides all the intercepted messages while you are in combat."] = true

