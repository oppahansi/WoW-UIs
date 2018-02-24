﻿local L = AceLibrary("AceLocale-2.2"):new("PallyPower")

L:RegisterTranslations("zhCN", function() return 
{
	AURAS = "Auras", -- Requires localization
	AURAS_DESC = "Auras monitoring enable/disable", -- Requires localization
	AUTOASSIGN = "Auto-Assign", -- Requires localization
	AUTOBTN = "显示自动祝福按钮",
	AUTOBTN_DESC = "显示/隐藏自动祝福按钮",
	AUTOBUFF = "自动祝福",
	AUTOBUFF_DESC = "自动祝福设置",
	AUTOKEY1 = "自动施放弱效祝福按键",
	AUTOKEY1_DESC = "为自动施加弱效祝福功能绑定按键。",
	AUTOKEY2 = "自动施放强效祝福按键",
	AUTOKEY2_DESC = "为自动施加强效祝福功能绑定按键。",
	BAS = "祝福管理",
	BAS_DESC = "打开祝福管理窗口",
	BRPT = "祝福分配报告",
	BRPT_DESC = "向团队/小队报告祝福分配情况",
	BSC = "主窗口大小",
	BSC_DESC = "设置祝福施加窗口的大小",
	CSC = "选项窗口大小",
	CSC_DESC = "设置选项窗口的大小",
	DISABLED = "禁用",
	DISP = "显示设置",
	DISPCL = "职业按钮",
	DISPCL_DESC = "职业按钮方向设置",
	DISPCOL = "列数",
	DISPCOL_DESC = "设置列数",
	DISP_DESC = "祝福施加窗口的设置",
	DISPEDGES = "Display Button Edges", -- Requires localization
	DISPEDGES_DESC = "Display Edges for Player Buttons", -- Requires localization
	DISPGAP = "间隔",
	DISPGAP_DESC = "设置按钮间距",
	DISPPL = "玩家按钮",
	DISPPL_DESC = "玩家按钮方向设置",
	DISPROWS = "行数",
	DISPROWS_DESC = "设置行数",
	DRAGHANDLE = [=[左键拖动以移动
单击以锁定或解锁
右键单击以打开设置]=],
	ENABLED = "启用",
	FREEASSIGN = "自由配置",
	FREEASSIGN_DESC = "允许其他非团队领袖/助理人员更改你的祝福配置",
	GREATER = "强效祝福",
	GREATER_DESC = "启用/禁用强效祝福",
	HIDECB = "Auto-Hide Class Buttons", -- Requires localization
	HIDECB_DESC = "Auto-Hide Class Buttons", -- Requires localization
	HIDEDH = "隐藏拖动柄",
	HIDEDH_DESC = "显示/隐藏拖动柄",
	HIDEPB = "隐藏玩家按钮",
	HIDEPB_DESC = "显示/隐藏玩家按钮",
	IGNOREEXTRA = "Ignore groups 6-8", -- Requires localization
	IGNOREEXTRADESC = "Ignore people on stand-by placed in groups 6 to 8", -- Requires localization
	LAYOUT = "Layout", -- Requires localization
	LAYOUT_DESC = "Custom Layout", -- Requires localization
	PP_CLEAR = "清除",
	PP_OPTIONS = "设置",
	PP_RAS1 = "--- 圣骑士祝福分配 ---",
	PP_RAS2 = "--- 分配通告结束 ---",
	PP_REFRESH = "刷新",
	RESET = "重置位置",
	RESET_DESC = "将所有PallyPower窗口的位置重置回屏幕中央",
	RFBUFF = "正义之怒",
	RFBUFF_DESC = "启用/禁用正义之怒监视器",
	RFUSE = "Righteous Fury", -- Requires localization
	RFUSE_DESC = "Righteous Fury on/off", -- Requires localization
	SBUFF = "智能选择祝福",
	SBUFF_DESC = "在选择祝福时为某些职业忽略特定的祝福",
	SEAL = "Seal", -- Requires localization
	SEAL_DESC = "Seal", -- Requires localization
	SHOWPARTY = "在小队时显示",
	SHOWPARTY_DESC = "当加入一个小队后显示/隐藏祝福施加窗口",
	SHOWSINGLE = "在单独时显示",
	SHOWSINGLE_DESC = "当单独一人显示/隐藏祝福施加窗口",
	SKIN = "Skin", -- Requires localization
	SKIN_DESC = "Apply a custom background to buff buttons", -- Requires localization
	WAIT = "等待所有队友",
	WAIT_DESC = "是否等待所有队友都在线且都在祝福范围内才施放祝福",
}
 
end)