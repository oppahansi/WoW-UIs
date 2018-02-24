---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

------------------------------------
-- Translation by Default -> zhTW --
------------------------------------
--Add Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
if (GetLocale() == "zhTW") then
DBMGUI_DROPDOWN_LEVEL_1 = "外域";
DBMGUI_DROPDOWN_LEVEL_2 = "艾澤拉斯";

-- DBM_GUI.lua for Bossmod List Frame (DBMBossModListFrame)
DBMGUI_TAB_1_TITLE_TEXT        = "納克薩瑪斯";
DBMGUI_TAB_2_TITLE_TEXT        = "安其拉";
DBMGUI_TAB_3_TITLE_TEXT        = "黑翼之巢";
DBMGUI_TAB_4_TITLE_TEXT        = "熔火之心";
DBMGUI_TAB_5_TITLE_TEXT        = "祖爾格拉布與安其拉廢墟";
DBMGUI_TAB_6_TITLE_TEXT        = "其他";

-- Tooltips
DBMGUI_FRAMETAB_1_TT           = "納克薩瑪斯首領模組";
DBMGUI_FRAMETAB_1_TD           = "我們的納克薩瑪斯首領模組合集. 選擇一個戰役以取得額外的選項.";
DBMGUI_FRAMETAB_2_TT           = "安其拉首領模組";
DBMGUI_FRAMETAB_2_TD           = "我們的安其拉首領模組合集. 選擇一個戰役以取得額外的選項.";
DBMGUI_FRAMETAB_3_TT           = "黑翼之巢首領模組";
DBMGUI_FRAMETAB_3_TD           = "我們的黑翼之巢首領模組合集. 選擇一個戰役以取得額外的選項.";
DBMGUI_FRAMETAB_4_TT           = "熔火之心首領模組";
DBMGUI_FRAMETAB_4_TD           = "我們的熔火之心首領模組合集. 選擇一個戰役以取得額外的選項.";
DBMGUI_FRAMETAB_5_TT           = "祖爾格拉布與安其拉廢墟首領模組";
DBMGUI_FRAMETAB_5_TD           = "我們的祖爾格拉布與安其拉廢墟首領模組合集. 選擇一個戰役以取得額外的選項.";

DBMGUI_DISABLE_ADDON           = "關閉插件";
DBMGUI_ENABLE_ADDON            = "打開插件";
DBMGUI_STOP_ADDON              = "停止插件";
DBMGUI_DISABLE_ANNOUNCE        = "關閉廣播";
DBMGUI_ENABLE_ANNOUNCE         = "打開廣播";
DBMGUI_SHOW_DROPDOWNMENU       = "額外選項";
DBMGUI_DROPDOWNMENU_TITLE      = "首領模組選單";

-- DBMBossModFrame
DBMGUI_HIDE_OPTIONS            = "<<< 選項";
DBMGUI_SHOW_OPTIONS            = "選項 >>>";

-- Options Frame (DBMOptionsFrame)
if( DBM.VersionBeta ) then
    DBMGUI_OPTIONS                 = "DBM v"..DBM.Version.." - "..DBM.VersionBeta;
else
    DBMGUI_OPTIONS                 = "選項 (GUI v"..DBMGUI_VERSION.." / Boss Mod v"..(DBM.BetaVersion or DBM.Version)..")";
end
DBMGUI_SIDEFRAME_TAB1          = "一般";
DBMGUI_SIDEFRAME_TAB2          = "計時條";
DBMGUI_SIDEFRAME_TAB3          = "警告";
DBMGUI_SIDEFRAME_TAB4          = "特殊";

-- DBMOptionsFramePage1
DBMGUI_TITLE_SYNCSETTINGS              = "同步設定";
DBMGUI_TITLE_MINIMAPBUTTON             = "小地圖按鈕設定";
DBMGUI_TITLE_AGGROALERT                = "目標警告設定";
DBMGUI_CHECKBOX_SYNC_ENABLE            = "開啟同步";
DBMGUI_BUTTON_VERSION_CHECK            = "版本檢查";
DBMGUI_BUTTON_VERSION_CHECK_FAILD      = "無其他 DBM 使用者";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO       = "狀態條同步信息";
DBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD = "無狀態條";
DBMGUI_SLIDER_MINIMAP_1                = "位置";
DBMGUI_SLIDER_MINIMAP_2                = "半徑";
DBMGUI_CHECKBOX_MINIMAP                = "顯示小地圖按鈕";
DBMGUI_CHECKBOX_AGGROALERT_ENABLE      = "開啟目標警告";
DBMGUI_BUTTON_AGGROALERT_TEST          = "測試目標警告";
DBMGUI_BUTTON_AGGROALERT_RESET         = "重置設定";
DBMGUI_BUTTON_AGGROALERT_RESET_DONE    = "目標警告已重置";
DBMGUI_BUTTON_AGGROALERT_ENABLE_PARTY	= "開啟5人副本的目標警告";
DBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND   = "目標轉向你時播放音效";
DBMGUI_CHECKBOX_AGGROALERT_FLASH       = "目標轉向你時閃光";
DBMGUI_CHECKBOX_AGGROALERT_SHAKE       = "目標轉向你時震動";
DBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT = "顯示特殊警告信息";
DBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING = "顯示本地警告信息";
DBMGUI_BUTTON_MOVEABLEBAR              = "改變計時條位置";
DBMGUI_BUTTON_DEFAULTS                 = "預設值";

-- DBMOptionsFramePage2
DBMGUI_TITLE_STATUSBARS                = "狀態條計時設定";
DBMGUI_TITLE_PIZZATIMER                = "創造 \"Pizza\" 計時器";
DBMGUI_CHECKBOX_STATUSBAR_ENABLE       = "開啟狀態條";
DBMGUI_CHECKBOX_STATUSBAR_FILLUP       = "填充狀態條";
DBMGUI_CHECKBOX_STATUSBAR_FLIPOVER     = "翻轉狀態條";
DBMGUI_EDITBOX_PIZZATIMER_TEXT         = "名稱";
DBMGUI_EDITBOX_PIZZATIMER_MIN          = "分";
DBMGUI_EDITBOX_PIZZATIMER_SEC          = "秒";
DBMGUI_CHECKBOX_PIZZATIMER_BROADCAST   = "向團隊廣播計時";
DBMGUI_BUTTON_PIZZATIMER_START         = "開始計時";

-- DBMOptionsFramePage3
DBMGUI_TITLE_RAIDWARNING               = "設定團隊警告";
DBMGUI_TITLE_SELFWARNING               = "本定警告";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_1   = "團隊警告 (預設音效)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_2   = "敲鐘聲 (CT_Raid音效)";
DBMGUI_DROPDOWN_RAIDWARNING_OPTION_3   = "取消警告音效";
DBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED  = "團隊警告音效已取消";
DBMGUI_RAIDWARNING_EXAMPLE             = "*** 團隊警告範例 ***";
DBMGUI_BUTTON_SOUND_TEST               = "測試音效";
DBMGUI_BUTTON_SHOW_EXAMPLE             = "顯示範例";
DBMGUI_BUTTON_RAIDWARNING_RESET        = "重置頁面";
DBMGUI_BUTTON_RAIDWARNING_RESET_DONE   = "選項已重置為預設值";

-- DBMOptionsFramePage4
DBMGUI_TITLE_SPECIALWARNING            = "設定特殊警告";
DBMGUI_TITLE_SHAKESCREEN               = "設定螢幕震動效果";
DBMGUI_TITLE_FLASHEFFECT               = "設定閃光效果";
DBMGUI_CHECKBOX_SPECWARNING_ENABLE     = "開啟特殊警告";
DBMGUI_BUTTON_SPECWARNING_TEST         = "測試警告";
DBMGUI_BUTTON_SPECWARNING_EXAMPLE      = "測試訊息 囧";
DBMGUI_SLIDER_SPECWARNING_DURATION     = "持續時間";
DBMGUI_SLIDER_SPECWARNING_FADETIME     = "消失時間";
DBMGUI_SLIDER_SPECWARNING_TEXTSIZE     = "文字大小";
DBMGUI_CHECKBOX_SHAKESCREEN_ENABLE     = "開啟螢幕震動效果";
DBMGUI_BUTTON_SHAKESCREEN_TEST         = "測試震動";
DBMGUI_SLIDER_SHAKESCREEN_DURATION     = "持續時間";
DBMGUI_SLIDER_SHAKESCREEN_INTENSITY    = "強度";
DBMGUI_CHECKBOX_FLASHEFFECT_ENABLE     = "打開閃光效果";
DBMGUI_BUTTON_FLASHEFFECT_TEST         = "測試閃光";
DBMGUI_SLIDER_FLASHEFFECT_DURATION     = "持續時間";
DBMGUI_SLIDER_FLASHEFFECT_FLASHES      = "閃光次數";

-- DBMOptionsFramePage5
DBMGUI_ABOUTTITLE      = "關於";
DBMGUI_ABOUTTEXT   = {
    "Deadly Boss Mods API (c) by DeadlyMinds Tandanu",
    "Deadly Boss Mods GUI (c) by La Vendetta Nitram",
    " ",
    "感謝你使用我們的插件.",
    " ",
    "                                  拜訪",
    " ",
    "                   www.deadlybossmods.com",
    " ",
    "                                   與",
    " ",
    "                 www.curse-gaming.com",
    " ",
    "如果你有建議或是要回報錯誤, 可以到 www.curse-gaming.com 或是我們的論壇 www.deadlyminds.net 發表意見.",

};

--[[ Translations added v1.05
DBMGUI_DISTANCE_FRAME_TITLE        = "距離";
DBMGUI_DISTANCE_FRAME_TEXT         = "過近:";

DBMGUI_INFOFRAME_TOOLTIP_TITLE     = "資訊框";
DBMGUI_INFOFRAME_TOOLTIP_TEXT      = "右鍵拖曳移動\nShift + 右鍵隱藏";

DBMGUI_STATUSBAR_WIDTH_SLIDER      = "條寬";
DBMGUI_STATUSBAR_SCALE_SLIDER      = "條的縮放比";

DBMGUI_BUTTON_RANGECHECK           = "距離檢查";
DBMGUI_TOOLTIP_RANGECHECK_TITLE    = "距離檢查";
DBMGUI_TOOLTIP_RANGECHECK_TEXT     = "檢查誰離你超過30碼";

DBMGUI_BUTTON_DISTANCEFRAME        = "距離框";
DBMGUI_TOOLTIP_DISTANCEFRAME_TITLE = "距離框";
DBMGUI_TOOLTIP_DISTANCEFRAME_TEXT  = "顯示或關閉距離檢查框。這是檢查誰離你太近(低於10碼)用的。打類似哈霍蘭或是克蘇恩之類的王會很有用。";]]

-- Translations added v1.10
DBMGUI_SIDEFRAME_TAB5              = "其他";
DBMGUI_SIDEFRAME_TAB6              = "關於";

DBMGUI_SLIDER_STATUSBAR_COUNT          = "狀態條數量";
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_1     = "傳統設計"; --wird erfl sig mit dem Verwenden des Namens aus der Tabelle
DBMGUI_DROPDOWN_STATUSBAR_DESIGN_2     = "摩登款式";
DBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR  = "範例狀態條";

DBMGUI_TITLE_AUTORESPOND               = "自動回應設定";
DBMGUI_CHECKBOX_AUTORESPOND_ENABLE     = "在boss戰中自動回應給密語者";
DBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS  = "在戰鬥期間顯示密語者";
DBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER    = "自動回密語時通知我";
DBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY     = "隱藏自動回密";

DBMGUI_EDITBOX_AUTORESPOND_TITLE           = "在boss戰中密語傳送設定";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER  = "以下的字串將\n被自動置換：";
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1   = {"%P", "你的名字"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2   = {"%B", "boss名字"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3   = {"%HP", "boss hp"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4   = {"%ALIVE", "存活的團隊成員"};
DBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5   = {"%RAID", "團隊成員"};

-- Translations added v1.15
DBMGUI_CHECKBOX_ALLOW_STATUS_COMMAND       = "允許使用者取得目前戰況 (密 \"status\" 取得)";
DBMGUI_CHECKBOX_SHOWCOMBATINFO             = "顯示戰鬥資訊, 例如戰鬥長度";
DBMGUI_TITLE_COMBATSYSTEM                  = "戰鬥偵測系統";
DBMGUI_BUTTON_STATUSBAR_FLASHONEND         = "當時間結束時閃爍狀態條";
DBMGUI_BUTTON_STATUSBAR_AUTOCOLORBARS      = "動態改變狀態條顏色";

-- Translations added v1.20
DBMGUI_TITLE_RAIDOPTIONS                   = "團隊選項";
DBMGUI_CHECKBOX_HIDEPLAYERNAMESINRAIDS     = "當加入團隊時隱藏玩家的名字";
DBMGUI_CHECKBOX_ALLOWSYNCFROMOLDCLIENT     = "允許與舊的客戶端同步";

-- Translation added v1.25
DBMGUI_CHECKBOX_ENABLE_RAIDWARNINGFRAME    = "開啟團隊警告框";
DBMGUI_CHECKBOX_ENABLE_SELFWARNINGFRAME    = "開啟自我警告框";

DBMGUI_BUTTON_LOADADDON            = "載入插件";
DBMGUI_FRAME_LOADADDON_DESCRIPTION     = {
    "請進入該區域以自動載入插件. 如果你",
    "希望手動載入這個插件, 你也可以點",
    "\"載入插件\". 在這之後, 這個插件",
    "將被載入工作, 但是佔用記憶體與CPU.",
    "這個功能僅是為了效率, 因為我們",
    "不想載入沒在玩的副本插件",
};

--[[ Range stuff
DBM_GUI_COMBATLOG_RANGE_TITLE      = "戰鬥紀錄距離";
DBM_GUI_COMBATLOG_MIN_RANGE        = "戰鬥紀錄距離設定為最短距離";
DBM_GUI_COMBATLOG_MAX_RANGE        = "戰鬥紀錄距離設定為最大距離";
DBM_GUI_COMBATLOG_LONG_RANGE       = "戰鬥紀錄距離設定為長距離";
DBM_GUI_COMBATLOG_DEFAULT_RANGE    = "戰鬥紀錄距離設定為預設距離";]]

-- added @ 1.12.06
DBMGUI_CHECKBOX_SHOWPULLSYNCINFO	= "顯示戰鬥開始同步信息";

DBMGUI_TITLE_LOAD_ON_DEMAND		= "需求時載入設置";
DBMGUI_CHECKBOX_LOAD_GUI_ONLOAD	= "登入時入圖形界面(GUI)";

-- added @ 13.12.06
DBMGUI_BUTTON_STATUSBAR_SHOW_ICON	= "顯示圖標";
DBMGUI_BUTTON_STATUSBAR_ICON_SIDE	= "在右邊顯示圖標";

DBM_ERROR_TABS_FULL	= "過多的模組標籤。最舊的標籤(%s)已被移除以便添加新的標籤。該標籤下的模組仍然可用，您可以使用\"載入模組\"再次顯示。";

DBMGUI_BUTTON_LOADMODS	= "載入模組";

-- text size slider
DBMGUI_STATUSBAR_TEXTSIZE_SLIDER	= "字體大小"

DBMGUI_SIDEFRAME_TAB22 = "計時條2"

-- huge bars
DBMGUI_BARS2_TITLE_STATUSBARS			= "放大計時條"
DBMGUI_BARS2_CHECKBOX_STATUSBAR_ENABLE		= "開啟放大計時條"
DBMGUI_BARS2_SLIDER_ENLARGEAFTER_TEXT		= "在計時條剩餘%.1f秒時放大"
DBMGUI_BARS2_SLIDER_ENLARGEAFTER_PERC_TEXT	= "在計時條運行了%.0f%%時放大"
DBMGUI_BARS2_SLIDER_ENLARGMAXTIME_TEXT		= "只在剩餘小於%.0f秒才會放大"


-- bar dropdown menu
DBMGUI_DROPDOWN_BAR_OPTIONS		= "時間條"

DBMGUI_BUTTON_271_DEFAULTS		= "舊預設值"

-- raid warning colors
	DBMGUI_WARNINGCOLORS_COLOR_1	= "顔色1"
	DBMGUI_WARNINGCOLORS_COLOR_2	= "顔色2"
	DBMGUI_WARNINGCOLORS_COLOR_3	= "顔色3"
	DBMGUI_WARNINGCOLORS_COLOR_4	= "顔色4"

	DBMGUI_BUTTON_RAIDWARNING_RESET_COLOR	= "重置顔色"

	DBMGUI_RAIDWARNING_EXAMPLE_NEW	= "|cff%.2x%.2x%.2x顔色1|r |cff%.2x%.2x%.2x顔色2|r |cff%.2x%.2x%.2x顔色3|r |cff%.2x%.2x%.2x顔色4|r"

end
