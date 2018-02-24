local L = LibStub("AceLocale-3.0"):NewLocale("ErrorMonster", "zhTW")
if not L then return end

L["addon_desc"] = "ErrorMonster 能夠停止和調節像錯誤訊息,系統訊息和UI 錯誤的提示訊息框架至被 LibSink-2.0 所支援框架. \n\n 要設定ErrorMonster應該調節哪些訊息, 請從邊展開節點然後選擇輸出部位. \n\n 下方你可以開啟哪些訊息需要被停止. 預設ErrorMonster只處理 Blizzard 錯誤框架.\n\n"
L["Output"] = "輸出"
L["Error"] = "錯誤"
L["Information"] = "提示"
L["System"] = "系統"
L["Error messages."] = "錯誤訊息"
L["Information messages."] = "提示訊息"
L["System messages."] = "系統訊息"
L["Hide all messages in combat"] = "戰鬥中隱藏所有訊息"
L["Hides all the intercepted messages while you are in combat."] = "隱藏所有被打斷訊息當你在戰鬥時"