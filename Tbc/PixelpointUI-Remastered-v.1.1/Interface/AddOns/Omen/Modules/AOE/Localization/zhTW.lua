local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_AOE", "zhTW")
if not L then return end

L["AOE Mode"] = "AOE 模式"
L["Indicate target"] = "標示目標"
L["Indicate focus"] = "標示鎖定目標"
L["Show raid icons"] = "顯示團隊標記"
L["AOE Mode\n|cffffffffShows your threat on all targets|r"] = "AOE 模式\n|cffffffff在所有目標中顯示你的仇恨值|r"
L["Tank mode"] = "Tank 模式"
L["Show threat relative to #2, and an increased maximum threat"] = "顯示相對 #2 仇恨，以及增加的最大仇恨"
L["Tank mode maximum threat %"] = "Tank 模式最大仇恨 %"
L["Show up to this threat value, relative to current #2"] = "顯露此仇恨值，相對於目前 #2"
