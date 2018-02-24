local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_AOE", "zhCN")
if not L then return end

L["AOE Mode"] = "AOE 模式"
L["Indicate target"] = "标记目标"
L["Indicate focus"] = "标记焦点"
L["Show raid icons"] = "显示团队标记"
L["AOE Mode\n|cffffffffShows your threat on all targets|r"] = "AOE 模式\n|cffffffff显示你对于所有目标的仇恨值|r"
L["Tank mode"] = "Tank 模式"
L["Show threat relative to #2, and an increased maximum threat"] = "显示与第二拍名仇恨比较，以增加的最大仇恨"
L["Tank mode maximum threat %"] = "Tank 模式最大仇恨"
L["Show up to this threat value, relative to current #2"] = "显示此仇恨值，相对于当前第二排名"
