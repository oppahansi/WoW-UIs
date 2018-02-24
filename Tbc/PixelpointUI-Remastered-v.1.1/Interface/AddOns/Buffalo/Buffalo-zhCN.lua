local L = AceLibrary("AceLocale-2.2"):new("Buffalo")

L:RegisterTranslations("zhCN", function()
    return {
    	["Lock"] = "锁定",
    	["When activated, the buff frames are locked and the reference frames are hidden"] = "激活后，buff框架将被锁定，调整锚点将被隐藏。",
    	["Buffs"] = "Buffs",
    	["Scale"] = "缩放",
    	["Scale Buff Icons"] = "缩放Buff图标",
    	["Rows"] = "行",
    	["Number of Rows. Only applies when Growth Precedence is Vertical"] = "设置行数。仅当增长方式设置为垂直时生效。",
    	["Columns"] = "列",
    	["Number of Columns. Only applies when Growth Precedence is Horizontal"] = "设置列数。仅当增长方式设置为水平时有效。",
    	["X-Padding"] = "X轴间距",
    	["Distance between columns"] = "列间距",
    	["Y-Padding"] = "Y轴间距",
    	["Distance between rows"] = "行间距",
    	["Horizontal Direction"] = "水平方向",
    	["In which horizontal direction should the display grow?"] = "Buff框架增长的水平方向。",
    	["To the left"] = "向左",
    	["To the right"]= "向右",
    	["Vertical Direction"] = "垂直方向",
    	["In which vertical direction should the display grow?"] = "Buff框架增长的垂直方向。",
    	["Upwards"] = "向上",
		["Downwards"] = "向下",
		["Growth Precedence"] = "增长优先",
		["In which direction should the display grow first (horizontally or vertically)?"] = "Buff框架优先增长方向(垂直或水平)",
		["Horizontally"] = "水平",
		["Vertically"] = "垂直",
------------------------------------------------------ 15:44
		["Manipulate Buffs Display"] = "设置Buff显示",
		["Control the distance between rows/columns"] = "设置行/列间距",
		["Padding"] = "间距",
		["Debuffs"] = "Debuffs",
		["Manipulate Debuffs Display"] = "设置Debuff显示",
		["Scale Debuff Icons"] = "缩放Debuff图标",
		["Weapon Buffs"] = "武器Buff",
		["Manipulate Weapon Buffs Display"] = "设置武器Buff显示",
		["Reset"] = "重置",
		["reset"] = "重置",
----------------------------------------------------
		["Hide"] = "隐藏",
		["Hides these buff frames"] = "隐藏这些Buff框架",
		["Verbose Timers"] = "详细时间显示",
		["Replaces the default time format for timers with HH:MM or MM:SS"] = "使用 HH:MM 或 MM:SS显示Buff剩余时间",
-------------------------------------------------------
		["Flashing"] = "闪烁",
		["Toggle flashing on fading buffs"] = "闪烁显示即将消失的Buff",
		["Timers"] = "计时器",
		["Customize buff timers"] = "自定义Buff计时器",
		["White Timers"] = "白色时间",
		["Use white timers instead of yellow ones"] = "使用白色显示剩余时间",
----------------------------------------------------
		["config"] = "设置",
		["Config"] = "设置",
-----------------------------------------------------------
    }
end)


------------
-- chinese translation 昏睡墨鱼.
-- fix bug 月色狼影