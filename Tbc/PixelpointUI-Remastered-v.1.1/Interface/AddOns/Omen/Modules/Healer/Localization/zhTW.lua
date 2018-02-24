local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_Healer", "zhTW")
if not L then return end

L["Healer Mode"] = "治療者模式"
L["Column Spacing"] = "行的間隔"

L["Data source"] = "資料來源"
L["Get tanks from..."] = "取得主坦資料的來源"
L["oRA2 Main Tanks"] = "oRA2 設置的主坦"
L["Blizzard Main Tanks"] = "Blizzard 內建設定的主坦"
L["Healer Mode\n|cffffffffShows an overview of tank target threat\nTank targets come from oRA2 or the Blizzard tank settings.|r"] = "治療者模式\n|cffffffff顯示坦克目標仇恨預估值\n坦克的目標來自於 oRA2 或者 Blizzard 坦克設定|r"