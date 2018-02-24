local L = AceLibrary("AceLocale-2.2"):new("Buffalo")

L:RegisterTranslations("zhTW", function()
    return {
    	["Lock"] = "鎖定",
    	["When activated, the buff frames are locked and the reference frames are hidden"] = "啟用時，buff框架會鎖定，參照框架會隱藏。",
    	["Buffs"] = "Buffs",
    	["Scale"] = "縮放",
    	["Scale Buff Icons"] = "縮放 Buff 圖示",
    	["Rows"] = "列",
    	["Number of Rows. Only applies when Growth Precedence is Vertical"] = "指定顯示列數。只在顯示順序為縱向時有效。",
    	["Columns"] = "行",
    	["Number of Columns. Only applies when Growth Precedence is Horizontal"] = "指定顯示行數。只在顯示順序為橫向時有效。",
    	["X-Padding"] = "橫向間距",
    	["Distance between columns"] = "行與行間的間距",
    	["Y-Padding"] = "縱向間距",
    	["Distance between rows"] = "列與列間的間距",
    	["Horizontal Direction"] = "橫向成長方向",
    	["In which horizontal direction should the display grow?"] = "往橫向顯示時 buff 要向哪個方向增長。",
    	["To the left"] = "向左",
    	["To the right"]="向右",
    	["Vertical Direction"] = "縱向成長方向",
    	["In which vertical direction should the display grow?"] = "往縱向方向顯示時 buff 要向哪個方向增長。",
    	["Upwards"] = "向上",
		["Downwards"] = "向下",
		["Growth Precedence"] = "成長順序",
		["In which direction should the display grow first (horizontally or vertically)?"] = "buff 增加時，要向哪個方向增加圖示（橫向或是縱向）",
		["Horizontally"] = "橫向",
		["Vertically"] = "縱向",
------------------------------------------------------ 15:44
		["Manipulate Buffs Display"] = "增益效果顯示控制",
		["Control the distance between rows/columns"] = "控制行列間的距離",
		["Padding"] = "間距",
		["Debuffs"] = "減益效果",
		["Manipulate Debuffs Display"] = "減益效果顯示控制",
		["Scale Debuff Icons"] = "縮放減益圖示",
		["Weapon Buffs"] = "武器增益",
		["Manipulate Weapon Buffs Display"] = "武器增益效果顯示控制",
		["Reset"] = "重置",
		["reset"] = "重置",
----------------------------------------------------
		["Hide"] = "隱藏",
		["Hides these buff frames"] = "隱藏 buff 框架",
		["Verbose Timers"] = "檢查計時器",
		["Replaces the default time format for timers with HH:MM or MM:SS"] = "將預設的時間格式，以 HH:MM 或是 MM:SS 取代",
-------------------------------------------------------
		["Flashing"] = "閃爍",
		["Toggle flashing on fading buffs"] = "以閃爍方式表示快消失的 buff",
		["Timers"] = "計時器",
		["Customize buff timers"] = "自訂 buff 計時器",
		["White Timers"] = "白色計時器",
		["Use white timers instead of yellow ones"] = "使用白色來取代黃色的計時器",
----------------------------------------------------
		["config"] = "設定",
		["Config"] = "設定",
-----------------------------------------------------------
    }
end)


-- 2007/Oct/04 Chinese zhTW by 蕾艾莎塔@奧妮克希亞