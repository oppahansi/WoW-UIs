--Debug by Nightkiller@日落沼澤(kc10577@巴哈;Azael)

if (GetLocale() == "zhTW") then

--classes
DBM_MAGE           = "法師";
DBM_PRIEST         = "牧師";
DBM_PALADIN        = "聖騎士";
DBM_DRUID          = "德魯伊";
DBM_WARLOCK        = "術士";
DBM_ROGUE          = "盜賊";
DBM_HUNTER         = "獵人";
DBM_WARRIOR        = "戰士";
DBM_SHAMAN         = "薩滿";

--zones
DBM_NAXX           = "納克薩瑪斯";
DBM_AQ40           = "安其拉";
DBM_BWL            = "黑翼之巢";
DBM_MC             = "熔火之心";
DBM_AQ20           = "安其拉廢墟";
DBM_ZG             = "祖爾格拉布";
DBM_ONYXIAS_LAIR   = "奧妮克希亞的巢穴";
DBM_DUSKWOOD       = "暮色森林";
DBM_ASHENVALE      = "梣谷";
DBM_FERALAS        = "菲拉斯";
DBM_HINTERLANDS    = "辛特蘭";
DBM_BLASTED_LANDS  = "詛咒之地";
DBM_AZSHARA        = "艾薩拉";
DBM_HELLFIRE       = "地獄火半島";
DBM_SHADOWMOON     = "影月谷";

DBM_BLACK_MORASS	= "黑色沼澤";

DBM_BATTLEGROUND	= "戰場";
DBM_BATTLEGROUNDS	= "戰場";
DBM_ARATHI			= "阿拉希盆地";
DBM_WARSONG		= "戰歌峽谷";
DBM_ALTERAC		= "奧特蘭克山谷";
DBM_EYEOFTHESTORM = "暴風之眼";
DBM_OTHER          = "其他";

DBM_GRUULS_LAIR	= "戈魯爾之巢";
DBM_MAGS_LAIR	= "瑪瑟里頓的巢穴";

--Gui Tabs
DBMGUI_TAB_NAXX				= "Naxxramas";		-- DO NOT TRANSLATE!!!
DBMGUI_TAB_AQ40				= "Ahn'Qiraj";		-- DO NOT TRANSLATE!!!
DBMGUI_TAB_BWL					= "BlackWingLair";	-- DO NOT TRANSLATE!!!
DBMGUI_TAB_MC					= "Molten Core";	-- DO NOT TRANSLATE!!!
DBMGUI_TAB_AQ20				= "Ahn'Qiraj 20";	-- DO NOT TRANSLATE!!!
DBMGUI_TAB_ZG				= "Zul'Gurub";		-- DO NOT TRANSLATE!!!
DBMGUI_TAB_OTHER				= "Other";			-- DO NOT TRANSLATE!!!
DBMGUI_TAB_OTHER_BC				= "Other (BC)";               -- DO NOT TRANSLATE!!!
DBM_NO_GUI_TAB					= "No GUI"; 		-- DO NOT TRANSLATE!!!



--spells/buffs
DBM_CHARGE         = "衝鋒";
DBM_FERALCHARGE    = "野性衝鋒";
DBM_BLOODRAGE      = "血性狂暴";
DBM_REDEMPTION     = "救贖之魂";
DBM_FEIGNDEATH     = "假死";
DBM_MINDCONTROL    = "精神控制";

--create status bar timer localization table
DBM_SBT = {};

--key bindings
BINDING_HEADER_DBM     = "Deadly Boss Mods";
BINDING_NAME_DBMTOGGLE     = "開啟圖形界面";

--OnLoad messages
DBM_LOADED			= "Deadly Boss Mods v%s 由 DeadlyMinds|Tandanu @ EU-Aegwynn 與 La Vendetta|Nitram @ EU-Azshara 製作, 已載入.";
DBM_MODS_LOADED        = "%s %s boss mods 已載入."

--Slash command messages
DBM_MOD_ENABLED        = "Boss mod 已啟用.";
DBM_MOD_DISABLED       = "Boss mod 已禁用.";
DBM_ANNOUNCE_ENABLED   = "開啟廣播";
DBM_ANNOUNCE_DISABLED  = "關閉廣播";
DBM_MOD_STOPPED        = "計時停止";
DBM_MOD_INFO           = "Boss mod v%s 由 %s";
DBM_SLASH_HELP1        = " 開啟/關閉";
DBM_SLASH_HELP2        = " 廣播 開啟/關閉";
DBM_SLASH_HELP3        = " 停止";
DBM_SLASH_HELP4        = "你可以使用 %s 替代 /%s.";
DBM_RANGE_CHECK        = "超過30碼外: ";
DBM_FOUND_CLIENTS      = "發現 %s 個玩家使用 Deadly Boss Mods";

--Sync options
DBM_SOMEONE_SET_SYNC_CHANNEL   = "%s 設置同步頻道為: %s";
DBM_SET_SYNC_CHANNEL           = "同步頻道設為: %s";
DBM_CHANNEL_NOT_SET            = "未設置頻道, 無法廣播.";
DBM_NEED_LEADER                = "你必須為助理或團長才能對頻道廣播!";
DBM_NEED_LEADER_STOP_ALL       = "你必須為助理或團長才能使用此功能!";
DBM_ALL_STOPPED                = "停止所有計時器.";
DBM_REC_STOP_ALL               = "停止接收來自 %s 的所有命令.";

--Update dialog
DBM_UPDATE_DIALOG              = "你的 Deadly Boss Mod 已經過期!\n%s 和 %s 有版本 %s.\n請參觀 www.deadlybossmods.com 以取得最新版本.";
DBM_YOUR_VERSION_SUCKS         = "你的 Deadly Boss Mod 已經過期! 請參觀 www.deadlybossmods.com 以取得最新版本.";
DBM_REQ_PATCHNOTES             = "向 %s 請求改版記錄...請稍待.";
DBM_SHOW_PATCHNOTES            = "顯示改版記錄";
DBM_PATCHNOTES                 = "改版記錄";
DBM_COPY_PASTE_URL             = "複製與貼上網址";
DBM_COPY_PASTE_NOW             = "按下 ctrl-c 複製網址到剪貼簿"

--Status Bar Timers
DBM_SBT_TIMELEFT               = "剩餘時間:"
DBM_SBT_TIMEELAPSED            = "已用時間:"
DBM_SBT_TOTALTIME              = "總時間:"
DBM_SBT_REPETITIONS            = "循環:";
DBM_SBT_INFINITE               = "無限";
DBM_SBT_BOSSMOD                = "Boss mod:"
DBM_SBT_STARTEDBY              = "開始於:"
DBM_SBT_RIGHTCLICK             = "在控制條上右鍵點擊以隱藏它.";
DBM_SBT_LEFTCLICK              = "Shift + 左鍵點擊控制條以廣播它";
DBM_TIMER_IS_ABOUT_TO_EXPIRE   = "計時器 \"%s\" 快要過期了!";
DBM_BAR_STYLE_DEFAULT          = "預設";
DBM_BAR_STYLE_MODERN           = "現代";
DBM_BAR_STYLE_CLOUDS           = "朦朧";
DBM_BAR_STYLE_PERL             = "Perl";


--Combat messages
DBM_BOSS_ENGAGED               = "%s 開戰. 祝好運與盡興! :)";
DBM_BOSS_SYNCED_BY             = "(從 %s 接收同步訊息)";
DBM_BOSS_DOWN                  = "%s 倒地, 經過 %s!";
DBM_COMBAT_ENDED               = "戰鬥經過 %s 結束.";
DBM_DEFAULT_BUSY_MSG           = "%P 正在忙碌. (正在進行戰鬥 %B - %HP - %ALIVE/%RAID 人還活著) 等戰鬥結束之後將回應你.";
DBM_RAID_STATUS_WHISPER        = "%B - %HP - %ALIVE/%RAID 人還活著.";
DBM_SEND_STATUS_INFO           = "密語 \"status\" 取得團隊的狀態.";
DBM_AUTO_RESPOND_SHORT         = "已自動回應.";
DBM_AUTO_RESPOND_LONG          = "已自動回應 %s 的密語.";
DBM_MISSED_WHISPERS            = "在戰鬥中沒有看到的密語:";
DBM_SHOW_MISSED_WHISPER        = "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
DBM_BALCONY_PHASE              = "上看台, 階段 #%s";

--Misc stuff
DBM_YOU                        = "你";
DBM_ARE                        = "了";
DBM_IS                         = "受到";
DBM_OR                         = "或";
DBM_AND                        = "和";
DBM_UNKNOWN                    = "未知";
DBM_LOCAL                      = "本地";
DBM_DEFAULT_DESCRIPTION        = "無描述.";
DBM_SEC                        = "秒";
DBM_MIN                        = "分";
DBM_SECOND                     = "秒";
DBM_SECONDS                    = "秒";
DBM_MINUTES                    = "分鐘";
DBM_MINUTE                     = "分鐘";
DBM_HIT                        = "命中";
DBM_HITS                       = "擊中";
DBM_CRIT                       = "致命一擊";
DBM_CRITS                      = "致命";
DBM_MISS                       = "未命中";
DBM_DODGE                      = "閃躲";
DBM_PARRY                      = "招架";
DBM_FROST                      = "冰霜";
DBM_ARCANE                     = "祕法";
DBM_FIRE                       = "火焰";
DBM_HOLY                       = "神聖";
DBM_NATURE                     = "自然";
DBM_SHADOW                     = "暗影";
DBM_CLOSE                      = "關閉";
DBM_AGGRO_FROM                 = "盯上你了！";
DBM_SET_ICON                   = "設定圖示";
DBM_SEND_WHISPER               = "發送密語";
DBM_DEAD                       = "死亡";
DBM_OFFLINE                    = "離線";
DBM_PHASE                      = "階段 %s";
DBM_WAVE                       = "第 %s 波";


-- Added 11.11.06
DBM_NOGUI_ERROR				= "抱歉, 請啟用 DBM GUI 以便存取這個函式";
DBM_NOSYNCBARS					= "現在沒有任何狀態條";




-- Added 1.12.06

DBM_LEFT	= "左";
DBM_RIGHT	= "右";

DBM_GUI_COMBATLOG_RANGE_TITLE      = "戰鬥紀錄距離";
DBM_GUI_COMBATLOG_MIN_RANGE        = "戰鬥紀錄距離設定為最短距離";
DBM_GUI_COMBATLOG_MAX_RANGE        = "戰鬥紀錄距離設定為最大距離";
DBM_GUI_COMBATLOG_LONG_RANGE       = "戰鬥紀錄距離設定為長距離";
DBM_GUI_COMBATLOG_DEFAULT_RANGE    = "戰鬥紀錄距離設定為預設距離";

DBMGUI_DISTANCE_FRAME_TITLE        = "距離";
DBMGUI_DISTANCE_FRAME_TEXT         = "過近:";
DBMGUI_DISTANCE_FRAME_TEXT_15YD	= "過近(15碼):";

DBMGUI_INFOFRAME_TOOLTIP_TITLE     = "資訊框";
DBMGUI_INFOFRAME_TOOLTIP_TEXT      = "右鍵拖曳移動\nShift + 右鍵隱藏";

DBMGUI_STATUSBAR_WIDTH_SLIDER      = "條寬";
DBMGUI_STATUSBAR_SCALE_SLIDER      = "條的縮放比";

DBMGUI_BUTTON_RANGECHECK           = "距離檢查";
DBMGUI_TOOLTIP_RANGECHECK_TITLE    = "距離檢查";
DBMGUI_TOOLTIP_RANGECHECK_TEXT     = "檢查誰離你超過30碼";

DBMGUI_BUTTON_DISTANCEFRAME        = "距離框";
DBMGUI_TOOLTIP_DISTANCEFRAME_TITLE = "距離框";
DBMGUI_TOOLTIP_DISTANCEFRAME_TEXT  = "顯示或關閉距離檢查框。這是檢查誰離你太近(低於10碼)用的。打類似哈霍蘭或是克蘇恩之類的王會很有用。";


-- Added 2.12.06

DBM_NAME			= "名字";
DBM_DURABILITY		= "耐久度";

DBM_LOAD_GUI_ERROR_FORMAT	= "當載入圖形介面時發生錯誤: %s";
DBM_LOAD_GUI_ERROR_UNKNOWN	= "當載入圖形介面時發生不明錯誤.";

-- Added 9.12.06

DBM_ERROR_INVALID_MODID	    = "錯誤: 插件的 ID 必須為字串!";
DBM_ERROR_MODID_EXISTS		= "錯誤: 插件的 ID '%s' 已經存在!";

-- Added 11.12.06
DBM_COMBAT_TABLE_WARNING	= "警告: boss mod 及這個 ID 已經註冊了, 更新資訊中..."

-- Added 13.12.06
DBM_TIMER_SLASHCMD_HELP1	= "/dbm timer <time> <text>  -  開啟一個計時器";
DBM_TIMER_SLASHCMD_HELP2	= "/dbm broadcast timer <time> <text>  -  廣播計時器";

-- Added 20.12.06
DBM_HORDE		= "部落";
DBM_ALLIANCE	= "聯盟";

-- Added 22.12.06
DBM_ENABLED_GREEN	= GREEN_FONT_COLOR_CODE.."啟用"..FONT_COLOR_CODE_CLOSE;
DBM_DISABLED_RED	= RED_FONT_COLOR_CODE.."關閉"..FONT_COLOR_CODE_CLOSE;
DBM_ERROR			= "錯誤";


-- 2.1.07
DBM_UPGRADE			= "升級";
DBM_BAR_STYLE_GLAZE = "光滑";

-- 9.1.07
DBM_BOSS_MOD_LOADED	= "'%s' boss mods 已載入!";

DBM_MISC			= "其他";

DBMGUI_TAB_NAXX_TEXT	= "Naxx";
DBMGUI_TAB_AQ40_TEXT	= "AQ40";
DBMGUI_TAB_BWL_TEXT		= "BWL";
DBMGUI_TAB_MC_TEXT		= "MC";
DBMGUI_TAB_OTHER_TEXT   = "其它";
DBMGUI_TAB_AQ20_TEXT	= "AQ20";
DBMGUI_TAB_ZG_TEXT		= "ZG";
DBMGUI_TAB_BG_TEXT		= "戰場"

DBMGUI_TAB_1_TITLE_TEXT		= "納克薩瑪斯 Boss Mods";
DBMGUI_TAB_2_TITLE_TEXT		= "安其拉神廟 Boss Mods";
DBMGUI_TAB_3_TITLE_TEXT		= "黑翼之巢 Boss Mods";
DBMGUI_TAB_4_TITLE_TEXT		= "熔火之心 Boss Mods";
DBMGUI_TAB_6_TITLE_TEXT		= "其他 Boss Mods";
DBMGUI_TAB_ZG_TITLE_TEXT	= "祖爾格拉布 Boss Mods";
DBMGUI_TAB_AQ20_TITLE_TEXT	= "安其拉廢墟 Boss Mods";
DBMGUI_TAB_BG_TITLE_TEXT	= "戰場";

-- 10.1.07
-- outdoor boss names for load on demand
DBM_OUTDOOR_YSONDRE    = "伊索德雷";
DBM_OUTDOOR_EMERISS    = "艾莫莉絲";
DBM_OUTDOOR_TAERAR     = "泰拉爾";
DBM_OUTDOOR_LETHON     = "雷索";
DBM_AZUREGOS_NAME                  = "艾索雷葛斯";

DBM_ERROR_LVBM_STILL_LOADED	= "你尚未刪除舊版的目錄, 現在有兩個版本的 DBM 正在執行!\n點下 \"確定\" 按鈕以關閉舊版, 同時重新載入插件.\n在做完這個步驟之後, 你不需要刪除舊版的目錄.";
DBM_DISABLE_AND_RELOAD		= "確定";

-- event abstraction layer
DBM_EAL_MOBCASTSTART_EXPR	= "(.+)開始施放(.+)。";
DBM_EAL_MOBCAST_EXPR		= "(.+)施放了(.+)。";
DBM_EAL_DEBUFF_EXPR			= "(.+)受到了(.+)效果的影響。";
DBM_EAL_MOB_BUFF_EXPR		= "(.+)獲得了(.+)的效果。";
DBM_EAL_MOBDEAD_EXPR		= "(.+)死亡了。";

--new tabs
DBM_KARAZHAN_TAB	= "卡拉贊"
DBM_KARAZHAN_TAB_TEXT	= "卡拉贊"
DBM_KARAZHAN_TAB_TITLE	= "卡拉贊"

--20.2.07
DBM_MSG_CLEANICONS = "已經清除團隊標記";

--18.3.07
DBM_HEAVY_NW_BANDAGE			= "厚幽紋繃帶";
DBM_RANGE_FRAME_BANDAGE_MISSING	= "再設置距離檢測窗口檢測距離為15碼時發生錯誤。請確定有攜帶厚幽紋繃帶。"

-- copied from "drt"

DRT_SPAMBLOCK_SLASHHELP	= {
	"/dbm spamblock Raid on||off (%s)",
	"/dbm spamblock RaidWarning on||off (%s)",
	"/dbm spamblock RaidWarningFrame on||off (%s)",
	"/dbm spamblock CTRaid on||off (%s)",
	"/dbm spamblock Battleground on||off (%s)",
};

DRT_PULLCOMMAND_ANNOUNCE	= "*** 即將開戰 ***";
DRT_PULLCOMMAND_SELFWARN	= "戰鬥開始";
DRT_PULLCOMMAND_PREWARN		= "*** %d秒後開戰 ***";
DRT_PULLCOMMAND_FAILED		= "請使用 /dbm pull 10";	
DBM_SBT["Incoming Pull"] = "戰鬥開始";

DRT_INVITE_NOPERMISSION		= "對不起，你必需為團隊領袖或是助理才能使用該功能";
DRT_SPAMBLOCK_OPTION_SET	= "過濾選項\"%s\"已設置為\"%s\"";

-- 28.4.07
DBM_REQUEST_BARS_FROM	= "%s請求計時的訊息...";
DBM_REQUEST_BARS_FAILED	= "錯誤：計時條恢復系統需要團隊內置約有1名其他成員使用2.60或以上版本的DBM。";

-- 20.9.07
DBM_GENERIC_ENRAGE_WARN	= "%s %s後狂暴";

-- 6.10.07
DBM_GENERIC_PHASE_MSG	= "階段 %s"
DBM_GENERIC_PHASE_MSG2	= "%s 階段"

DBM_KAZZAK_NAME = "毀滅領主卡札克";
DBM_DOOMW_NAME = "厄運行者";

DBM_HP_UNKNOWN			= "未知血量"

DBMGUI_OPTIONS_BAR_TARGET	= "<目標>"

DBM_NO_TARGET			= "<沒有目標>"

end
