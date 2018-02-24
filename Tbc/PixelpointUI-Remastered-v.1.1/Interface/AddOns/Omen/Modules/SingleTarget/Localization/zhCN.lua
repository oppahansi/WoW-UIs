local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_SingleTarget", "zhCN")
if not L then return end

L["Single Target Mode"] = "单目标模式"
L["Warnings"] = "警报"
L["Enable Warnings"] = "启用报警"
L["Enable Sound"] = "使用音效"
L["Enable Screen Flash"] = "启用闪屏"
L["Enable Screen Shake"] = "启用屏幕振动"
L["Sound to play"] = "播放声音"
L["Aggro Bars"] = "仇恨计量条"
L["Show bar"] = "显示计量条"
L["Warning Threshold"] = "警报阀值"
L["Pull Aggro"] = "OT！"
L["Color"] = "颜色"
L["The color of the aggro gain bar"] = "设置 OT 计量条颜色"
L["Always show self"] = "总是显示自己"
L["Always show yourself on the meter"] = "总是在表中显示你自己"
L["Enable Warning Message"] = "启用警报信息"
L["Print a message to screen when you accumulate too much threat"] = "当你的威胁值过高时将在屏幕上显示警报信息"
L["Test warnings"] = "测试警报"

L["Columns"] = "列"
L["Select which columns to show"] = "选择需要显示的列"

L["Name"] = "姓名"
L["TPS"] = "TPS"
L["Threat"] = "威胁值"
L["Percent"] = "百分比"

L["Show the Name column"] = "显示姓名列"
L["Show the TPS column"] = "显示 TPS 列"
L["Show the Threat column"] = "显示威胁值列"
L["Show the Percent column"] = "显示百分比列"
L["TPS Update Frequency"] = "TPS 更新频率"

L["Single Target Mode\n|cffffffffShows raid threat on your target|r"] = "单目标模式\n|cffffffff显示当前目标的仇恨值（你的目标）|r"

L["Show tank as 100%"] = "将 Tank 显示为100%"
L["Show tank as 100%, rather than 0%"] = "将 Tank 显示为100%，而非0%"

L["Disable while tanking"] = "当 Tank 时禁用"
L["Disable warnings while you are tanking"] = "当你为 Tank 时禁用警报"

L["Passed %s%% of %s's threat!"] = "超过>%2$s<%1$s%%的威胁值！"

L["The color of your bar's background"] = "你的计量条背景色"
L["Use custom color"] = "使用自定义颜色"
L["Use a custom color for your bar in the display list"] = "让你的计量条在列表里面以一个自定的背景色显示"
L["Your Bar"] = "你的计量条"

L["Show title bar"] = "显示标题条"
L["Show column headers on a title bar"] = "显示一个长条为标题"
