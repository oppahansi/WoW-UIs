local L = LibStub("AceLocale-3.0"):NewLocale("Minimap Button Frame", "zhTW")
if not L then return end

-- Bindings
BINDING_HEADER_MBF_SEP = "小地圖按鈕框架MBF"
BINDING_NAME_MBF_CONFIG = "設置開關"
BINDING_NAME_MBF_TOGGLE = "MBF開關"
BINDING_NAME_MBF_ADD = "添加按鈕"
BINDING_NAME_MBF_REMOVE = "移除按鈕"

-- Tooltips
L["ADDON"] = "小地圖按鈕框架MBF"
L["No New Mail"] = "沒有新的郵件"
L["MBF_LDB_TOOLTIP"] = "|cff1eff00點擊|r to 隱藏/顯示MBF框體 \n|cff1eff00Shift+點擊|r 打開設置"
L["MBF_TOOLTIP_FULL"] = "|cff1eff00點擊|r to 隱藏/顯示MBF框體 \n|cff1eff00Shift+點擊|r 打開設置\n|cff1eff00右鍵拖拽|r 移動位置"
L["MBF_TOOLTIP_SMALL"] = "|cff1eff00Shift+點擊|r 打開設置"
L["MBF_TOOLTIP_ROLLUP"] = "|cff1eff00點擊 + 拖拽|r 移動 MBF\n|cff1eff00右鍵|r to 隱藏/顯示 框體"

-- Error Messages
L["MBF_ERR1"] = "錯誤：移除按鈕出錯"
L["MBF_ERR2"] = "只能是MBF內按鈕，不能移除框體."
L["MBF_ERR3"] = "錯誤：移除按鈕不存在."
L["MBF_ERR4"] = "無法添加.  受保護或者已添加!"
L["MBF_ERR5"] = "錯誤：移除子事件."
L["MBF_ERR6"] = "巴頓不準備增加。  請重試。"
L["MBF_ERR7"] = "按鈕或對象不存在。"

-- Chat commands
L["MBF"] = true
L["usage"] = "用法"
L["Version"] = "版本"
L["info"] = true
L["show"] = true
L["hide"] = true
L["help"] = true
L["debug"] = true
L["config"] = true
L["remove"] = true
L["add"] = true
L["MBF_SLASH_Detail1"] = "用法 /mbf [ add | remove | info | config | show | hide | help ] "
L["MBF_SLASH_Detail2"] = "add - 增加非自動采集按鈕到MBF"
L["MBF_SLASH_Detail3"] = "remove - 移除MBF采集的按鈕"
L["MBF_SLASH_Detail4"] = "info - 顯示光標出按鈕信息"
L["MBF_SLASH_Detail5"] = "config - 顯示設置窗口."
L["MBF_SLASH_Detail6"] = "show - 顯示MBF."
L["MBF_SLASH_Detail7"] = "hide - 隱藏MBF."
L["MBF_SLASH_Detail8"] = "help - 顯示命令的幫助和信息"

-- Display Info
L["Unnamed Object"] = "無效對象"
L["Unknown Object Type"] = "未知對象類型"
L["Object Type"] = "目標對象"
L["Parent"] = "父級框體"
L["Unknown Parent Name"] = "未知父級框體名稱"
L["No Parent"] = "無父級框體"
L["Children"] = "兒童"

-- Display Options
L["Display"] = "顯示"
L["Display Settings"] = "顯示設置"

L["Locked"] = "鎖定"
L["LOCKED_DESC"] = "醫療保險基金切換幀是否已被鎖定。"

L["Hide when Locked"] = "鎖定后隱藏框體背景"
L["HIDELOCKED_DESC"] = "什麼部分的框架時，應隱藏幀是鎖定的。"

L["ALTTITLE_DESC"] = "候補標題欄的位置"
L["ALTTITLEDESC_DESC"] = "移動的標題欄的下方或右側，而不是默認的頂部或左邊。"

L["Buttonskin"] = "按鈕皮膚"
L["BUTTONSKIN_DESC"] = "選擇皮膚內的按鈕。"

L["Background Color"] = "背景顏色"
L["COLOR_DESC"] = "選擇背景顏色為醫療保險基金。"

L["Columns or Rows"] = "每行排列數"
L["CLR_DESC"] = "列數或行顯示。"

L["MBF Anchor"] = "錨"
L["MBFANCHOR_DESC"] = "在角落裡，該框架將增長到。"

L["Top Left"] = "最左"
L["Top Right"] = "右上"
L["Bottom Left"] = "底左"
L["Bottom Right"] = "右下角"

L["Padding"] = "間距"
L["PADDING_DESC"] = "多少錢之間填充的按鈕。"

L["Opacity"] = "透明度"
L["OPACITY_DESC"] = "設置不透明的框架。"

L["Scale"] = "縮放"
L["SCALE_DESC"] = "設定的規模範圍內。"

L["Name"] = "姓名"
L["Nothing"] = "--------"
L["Border"] = "隱藏邊框"
L["Background"] = "隱藏背景"
L["All"] = "背景與邊框"

L["Blizzard"] = "暴雪"
L["Blizzard Square"] = "暴雪廣場"

-- Gathering Options

L["Gathering"] = "采集"
L["Gathering Settings"] = "採集設置"

L["GATHERHEAD1_DESC"] = "醫療保險基金的迷你按鈕設置"
L["GATHERDESC1_DESC"] = "設置醫療保險基金迷你按鈕"

L["Show Minimap Button"] = "顯示小地圖按鈕"
L["SHOWBUTTON_DESC"] = "顯示，醫療保險基金迷你按鈕。"

L["Collect Button"] = "收納MBF小地圖按鈕"
L["COLLECT1_DESC"] = "收集的醫療保險基金迷你按鈕。"

L["GATHERHEAD2_DESC"] = "暴雪迷你按鈕設置"
L["GATHERDESC2_DESC"] = "設置為暴雪迷你按鈕"

L["Collect Buttons"] = "收納小地圖系統按鈕"
L["COLLECT2_DESC"] = "收集的暴雪迷你按鈕"

L["Hide Mail"] = "隱藏系統郵件圖標"
L["HIDEMAIL_DESC"] = "隱藏的暴雪新郵件圖標"

L["Show No Mail Icon"] = "顯示無新郵件圖標"
L["NOMAIL_DESC"] = "顯示的任何郵件圖標時，您沒有郵件。"

L["Hide Tracking"] = "隱藏系統追蹤按鈕"
L["TRACKING_DESC"] = "隱藏的暴雪追踪按鈕"

L["Hide Voice Chat"] = "隱藏系統語音聊天按鈕"
L["VOICECHAT_DESC"] = "隱藏的暴雪語音聊天按鈕"

L["Hide Calendar"] = "隱藏日曆"
L["CALENDAR_DESC"] = "隱藏的暴雪日曆"

L["Hide Zoom Buttons"] = "隱藏系統小地圖縮放按鈕"
L["ZOOM_DESC"] = "隱藏的暴雪迷你變焦按鈕"

L["Hide World Map"] = "隱藏世界地圖按鈕"
L["WORLDMAP_DESC"] = "隱藏的暴雪世界地圖按鈕"

-- Exceptions Options

L["Exceptions"] = "例外"
L["Exceptions Settings"] = "例外設置"

L["Protected Items"] = "保護項目"
L["ICONSDESC_DESC"] = "錯誤地收集項目。當然 ..收集器節點，用戶界面項目。"

L["CURRENTEXCEPTIONS_DESC"] = "目前的保護項目。"

L["Remove"] = "刪除"
L["ICONREMOVE_DESC"] = "刪除選定的保護項目。"

L["ICONADDTITLE_DESC"] = "添加受保護的項目"
L["ICONADD_DESC"] = "廣義名稱項目得到保護。"

L["Button Override"] = "巴頓覆蓋"
L["OVERRIDEDESC_DESC"] = "按鈕的醫療保險基金認為是迷你圖標，但真正的按鈕。"

L["Current Button Overrides"] = "當前按鈕覆蓋"

L["OVERRIDEREMOVE_DESC"] = "刪除選定的按鈕覆寫的例外"

L["Add Button Override"] = "添加按鈕覆蓋"
L["OVERRIDEADD_DESC"] = "的確切名稱的按鈕添加到該按鈕覆寫表。"

-- Sorting Options

L["Sorting"] = "排序"
L["Sorting Settings"] = "排序設置"

L["Sort By Rows"] = "排列方向"
L["SBR_DESC"] = "醫療保險基金的方向變化各種各樣的迷你按鈕。"

L["Grow Buttons Up"] = "成長扣"
L["GROWUP_DESC"] = "填充幀的按鈕從下往上。"

L["Sort Order"] = "排序"
L["SORTORDER_DESC"] = "選擇以便迷你按鈕排序"

L["Alphabetical"] = "字母排序"
L["Blizzard First"]  = "系統鈕優先"
L["Blizzard Last"]  = "系統鈕最后"
L["Custom"]  = "自定義"

L["UP"] = "向上"
L["DOWN"] = "向下的"
L["UP_DESC"] = "移動選定的迷你按鈕的命令行動"
L["DOWN_DESC"] = "移動選定的迷你按鈕的命令下跌"

-- Profile Options

L["Profiles"] = "概況"