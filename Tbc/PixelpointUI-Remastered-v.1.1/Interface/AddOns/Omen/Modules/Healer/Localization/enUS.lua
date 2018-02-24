local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_Healer", "enUS", true)
if not L then return end

L["Healer Mode"] = true
L["Column Spacing"] = true

L["Data source"] = true
L["Get tanks from..."] = true
L["oRA2 Main Tanks"] = true
L["Blizzard Main Tanks"] = true
L["Healer Mode\n|cffffffffShows an overview of tank target threat\nTank targets come from oRA2 or the Blizzard tank settings.|r"] = true
