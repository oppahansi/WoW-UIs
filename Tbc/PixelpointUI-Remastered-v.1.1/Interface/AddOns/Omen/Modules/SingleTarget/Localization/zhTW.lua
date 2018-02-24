local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_SingleTarget", "zhTW")
if not L then return end

L["Single Target Mode"] = "單一目標模式"
L["Warnings"] = "警告"
L["Enable Warnings"] = "啟動警告"
L["Enable Sound"] = "啟動警告聲"
L["Enable Screen Flash"] = "啟動螢幕閃爍"
L["Enable Screen Shake"] = "啟動螢幕震動"
L["Sound to play"] = "使用的警告聲"
L["Aggro Bars"] = "仇恨長條棒"
L["Show bar"] = "顯示長條棒"
L["Warning Threshold"] = "警告門檻值"
L["Pull Aggro"] = "拉到仇恨"
L["Color"] = "顏色"
L["The color of the aggro gain bar"] = "仇恨界限長條棒的顏色"
L["Always show self"] = "總是顯示自己"
L["Always show yourself on the meter"] = "總是將自己顯示在仇恨計量器"
L["Enable Warning Message"] = "啟動警告訊息"
L["Print a message to screen when you accumulate too much threat"] = "當你累積太多仇恨時在螢幕上顯示訊息"
L["Test warnings"] = "測試警告"

L["Columns"] = "列"
L["Select which columns to show"] = "選擇需要顯示的列"

L["Name"] = "姓名"
L["TPS"] = "TPS"
L["Threat"] = "仇恨值"
L["Percent"] = "百分比"

L["Show the Name column"] = "顯示姓名列"
L["Show the TPS column"] = "顯示 TPS 列"
L["Show the Threat column"] = "顯示仇恨值列"
L["Show the Percent column"] = "顯示百分比列"
L["TPS Update Frequency"] = "TPS 更新頻率"

L["Single Target Mode\n|cffffffffShows raid threat on your target|r"] = "單一目標模式\n|cffffffff顯示當前目標的仇恨值 (你的目標)|r"

L["Show tank as 100%"] = "顯示坦克為 100%"
L["Show tank as 100%, rather than 0%"] = "顯示坦克為 100%, 而不是 0%"

L["Disable while tanking"] = "當 Tank 時禁用"
L["Disable warnings while you are tanking"] = "當你是 Tank 時禁用警告"

L["Passed %s%% of %s's threat!"] = "已超過「%2$s」的 %1$2.0f%% 仇恨值!"

L["The color of your bar's background"] = "你的仇恨條的背景色"
L["Use custom color"] = "使用自定義顏色"
L["Use a custom color for your bar in the display list"] = "讓你的仇恨條在列表裡面以一個自定的背景色顯示"
L["Your Bar"] = "你的仇恨條"

L["Show title bar"] = "顯示標題長條棒"
L["Show column headers on a title bar"] = "使用一個長條棒為標題"
