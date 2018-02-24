local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_AOE", "enUS", true)
if not L then return end

L["AOE Mode"] = true
L["Indicate target"] = true
L["Indicate focus"] = true
L["Show raid icons"] = true
L["AOE Mode\n|cffffffffShows your threat on all targets|r"] = true
L["Tank mode"] = true
L["Show threat relative to #2, and an increased maximum threat"] = true
L["Tank mode maximum threat %"] = true
L["Show up to this threat value, relative to current #2"] = true
