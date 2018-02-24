local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_SingleTarget", "enUS", true)
if not L then return end

L["Single Target Mode"] = true
L["Warnings"] = true
L["Enable Warnings"] = true
L["Enable Sound"] = true
L["Enable Screen Flash"] = true
L["Enable Screen Shake"] = true
L["Sound to play"] = true
L["Aggro Bars"] = true
L["Show bar"] = true
L["Warning Threshold"] = true
L["Pull Aggro"] = true
L["Color"] = true
L["The color of the aggro gain bar"] = true
L["Always show self"] = true
L["Always show yourself on the meter"] = true
L["Enable Warning Message"] = true
L["Print a message to screen when you accumulate too much threat"] = true
L["Test warnings"] = true

L["Columns"] = true
L["Select which columns to show"] = true

L["Name"] = true
L["TPS"] = true
L["Threat"] = true
L["Percent"] = "%"

L["Show the Name column"] = true
L["Show the TPS column"] = true
L["Show the Threat column"] = true
L["Show the Percent column"] = true
L["TPS Update Frequency"] = true

L["Single Target Mode\n|cffffffffShows raid threat on your target|r"] = true

L["Show tank as 100%"] = true
L["Show tank as 100%, rather than 0%"] = true

L["Disable while tanking"] = true
L["Disable warnings while you are tanking"] = true

L["Passed %s%% of %s's threat!"] = true

L["The color of your bar's background"] = true
L["Use custom color"] = true
L["Use a custom color for your bar in the display list"] = true
L["Your Bar"] = true

L["Show title bar"] = true
L["Show column headers on a title bar"] = true
