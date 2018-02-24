local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_Healer", "zhCN")
if not L then return end

L["Healer Mode"] = "治疗者模式"
L["Column Spacing"] = "列间距"

L["Data source"] = "数据源"
L["Get tanks from..."] = "Tank 列表来自于……"
L["oRA2 Main Tanks"] = "oRA2"
L["Blizzard Main Tanks"] = "暴雪默认"
L["Healer Mode\n|cffffffffShows an overview of tank target threat\nTank targets come from oRA2 or the Blizzard tank settings.|r"] = "治疗者模式\n|cffffffff显示坦克目标仇恨值概况\n坦克的目标来自于 oRA2 或者暴雪默认 MT 设置。|r"
