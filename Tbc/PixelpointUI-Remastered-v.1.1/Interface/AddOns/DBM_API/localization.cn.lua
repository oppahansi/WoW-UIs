-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                  2/3/2008                   --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

--classes
	DBM_MAGE		= "法师";
	DBM_PRIEST		= "牧师";
	DBM_PALADIN		= "圣骑士";
	DBM_DRUID		= "德鲁伊";
	DBM_WARLOCK		= "术士";
	DBM_ROGUE		= "潜行者";
	DBM_HUNTER		= "猎人";
	DBM_WARRIOR		= "战士";
	DBM_SHAMAN		= "萨满祭司";

--zones
	DBM_NAXX			= "纳克萨玛斯";
	DBM_AQ40			= "安其拉";
	DBM_BWL				= "黑翼之巢";
	DBM_MC				= "熔火之心";
	DBM_AQ20			= "安其拉废墟";
	DBM_ZG				= "祖尔格拉布";
	DBM_ONYXIAS_LAIR	= "奥妮克希亚的巢穴";
	DBM_DUSKWOOD		= "暮色森林";
	DBM_ASHENVALE		= "灰谷";
	DBM_FERALAS			= "菲拉斯";
	DBM_HINTERLANDS		= "辛特兰";
	DBM_BLASTED_LANDS	= "诅咒之地";
	DBM_AZSHARA			= "艾萨拉";
	DBM_HELLFIRE		= "地狱火半岛";
	DBM_SHADOWMOON		= "影月谷";

	DBM_BLACK_MORASS	= "黑色沼泽";

	DBM_BATTLEGROUND	= "战场";
	DBM_BATTLEGROUNDS	= "战场";
	DBM_ARATHI			= "阿拉希盆地";
	DBM_WARSONG			= "战歌峡谷";
	DBM_ALTERAC			= "奥特兰克山谷";
	DBM_EYEOFTHESTORM 	= "风暴之眼";
	DBM_OTHER			= "其他";

	DBM_GRUULS_LAIR		= "格鲁尔的巢穴";
	DBM_MAGS_LAIR		= "玛瑟里顿的巢穴";

--Gui Tabs
	DBMGUI_TAB_NAXX		= "Naxxramas";		-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_AQ40		= "Ahn'Qiraj";		-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_BWL		= "BlackWingLair";	-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_MC		= "Molten Core";	-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_AQ20		= "Ahn'Qiraj 20";	-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_ZG		= "Zul'Gurub";		-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_OTHER	= "Other";			-- DO NOT TRANSLATE!!!
	DBMGUI_TAB_OTHER_BC	= "Other (BC)";     -- DO NOT TRANSLATE!!!
	DBM_NO_GUI_TAB		= "No GUI"; 		-- DO NOT TRANSLATE!!!
	
	
--spells/buffs
	DBM_CHARGE		= "冲锋";
	DBM_FERALCHARGE	= "野性冲锋";
	DBM_BLOODRAGE	= "血性狂暴";
	DBM_REDEMPTION 	= "救赎之魂";
	DBM_FEIGNDEATH	= "假死";
	DBM_MINDCONTROL	= "精神控制";

--create status bar timer localization table
	DBM_SBT = {};
	DBM_SBT["Incoming Pull"] = "即将开战";

--key bindings
	BINDING_HEADER_DBM = "Deadly Boss Mods";
	BINDING_NAME_DBMTOGGLE = "打开图形界面";

--OnLoad messages
	DBM_LOADED		= "Deadly Boss Mods v%s by DeadlyMinds|Tandanu and DeadlyMinds|Nitram @ EU-Azshara loaded.";
	DBM_MODS_LOADED	= "%s %s 模块开启"

--Slash command messages
	DBM_MOD_ENABLED			= "模块开启";
	DBM_MOD_DISABLED		= "模块关闭";
	DBM_ANNOUNCE_ENABLED	= "通告开启";
	DBM_ANNOUNCE_DISABLED	= "通告关闭";
	DBM_MOD_STOPPED			= "计时停止";
	DBM_MOD_INFO			= "Boss mod v%s by %s";
	DBM_SLASH_HELP1			= " on/off - 开启/关闭";
	DBM_SLASH_HELP2			= " announce on/off - 通告开启/关闭";
	DBM_SLASH_HELP3			= " stop - 停止";
	DBM_SLASH_HELP4			= "你可以使用 %s 替代 /%s.";
	DBM_RANGE_CHECK			= "距离你超过30码的成员: ";
	DBM_FOUND_CLIENTS		= "找到%s名玩家正在使用 Deadly Boss Mods";

--Sync options
	DBM_SOMEONE_SET_SYNC_CHANNEL	= "%s设置同步频道为: %s";
	DBM_SET_SYNC_CHANNEL			= "同步频道设为: %s";
	DBM_CHANNEL_NOT_SET				= "未设置频道。无法广播";
	DBM_NEED_LEADER					= "你必须为助理或团长才能广播频道！";
	DBM_NEED_LEADER_STOP_ALL		= "你必须为助理或团长才能使用此功能！";
	DBM_ALL_STOPPED					= "所有计时停止";
	DBM_REC_STOP_ALL				= "停止接收来自%s的所有命令";

--Update dialog
	DBM_UPDATE_DIALOG		= "你的 Deadly Boss Mods 已经过期！\n%s 和 %s 有版本 %s。\n请访问 www.dreamgen.cn 或 www.deadlybossmods.com 获取最新版本。";
	DBM_YOUR_VERSION_SUCKS	= "你的 Deadly Boss Mods 已经过期！\n请访问 www.dreamgen.cn 或  www.deadlybossmods.com 获取最新版本。";
	DBM_REQ_PATCHNOTES		= "向%s请求更新记录...请等待";
	DBM_SHOW_PATCHNOTES		= "显示更新记录";
	DBM_PATCHNOTES			= "更新记录";
	DBM_COPY_PASTE_URL		= "复制并粘贴地址";
	DBM_COPY_PASTE_NOW		= "按下 CTRL-C 以复制地址到剪贴板";

--Status Bar Timers
	DBM_SBT_TIMELEFT				= "剩余时间:"
	DBM_SBT_TIMEELAPSED				= "已用时间:"
	DBM_SBT_TOTALTIME				= "总时间:"
	DBM_SBT_REPETITIONS				= "循环:";
	DBM_SBT_INFINITE				= "无限";
	DBM_SBT_BOSSMOD					= "模块:"
	DBM_SBT_STARTEDBY				= "发起者:"
	DBM_SBT_RIGHTCLICK				= "右键点击以隐藏"
	DBM_SBT_LEFTCLICK				= "Shift + 单击以公布计时";
	DBM_TIMER_IS_ABOUT_TO_EXPIRE	= "计时器“%s”即将到期";
	DBM_BAR_STYLE_DEFAULT			= "默认";
	DBM_BAR_STYLE_MODERN			= "现代";
	DBM_BAR_STYLE_CLOUDS			= "云雾";
	DBM_BAR_STYLE_PERL				= "Perl";

--Combat messages
	DBM_BOSS_ENGAGED		= "%s战斗开始。祝你好运！ :)";
	DBM_BOSS_SYNCED_BY		= "(从%s接收到同步指令)";
	DBM_BOSS_DOWN			= "%s被击杀！用时%s";
	DBM_COMBAT_ENDED		= "战斗结束。用时%s";
	DBM_DEFAULT_BUSY_MSG	= "%P正在忙禄。(%B作战中 - %HP - %ALIVE/%RAID幸存)。在战斗结束后我会通知你。请等待。";
	DBM_RAID_STATUS_WHISPER	= "%B - %HP - %ALIVE/%RAID幸存";
	DBM_SEND_STATUS_INFO	= "对我密语“status”可查询战斗状况。";
	DBM_AUTO_RESPOND_SHORT	= "自动回复。";
	DBM_AUTO_RESPOND_LONG	= "已自动回复%s";
	DBM_MISSED_WHISPERS		= "战斗中收到的密语:";
	DBM_SHOW_MISSED_WHISPER	= "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
	DBM_BALCONY_PHASE		= "平台阶段 #%s";

--Misc stuff
	DBM_YOU					= "你";
	DBM_ARE					= "到了";
	DBM_IS					= "is";
	DBM_OR					= "或";
	DBM_AND					= "和";
	DBM_UNKNOWN			 	= "未知";
	DBM_LOCAL				= "本地";
	DBM_DEFAULT_DESCRIPTION	= "无描述";
	DBM_MIN					= "分";
	DBM_SEC					= "秒";
	DBM_SECOND				= "秒";
	DBM_SECONDS				= "秒";
	DBM_MINUTES				= "分钟";
	DBM_MINUTE				= "分钟";
	DBM_HIT					= "击中";
	DBM_HITS				= "击中";
	DBM_CRIT				= "爆击对";
	DBM_CRITS				= "爆击对";
	DBM_MISS				= "没有击中";
	DBM_DODGE				= "闪躲";
	DBM_PARRY				= "招架";
	DBM_FROST				= "冰霜";
	DBM_ARCANE				= "奥术";
	DBM_FIRE				= "火焰";
	DBM_HOLY				= "神圣";
	DBM_NATURE				= "自然";
	DBM_SHADOW				= "暗影";
	DBM_CLOSE				= "关闭";
	DBM_AGGRO_FROM			= "获得仇恨: ";
	DBM_SET_ICON			= "添加标注";
	DBM_SEND_WHISPER		= "密语玩家";
	DBM_DEAD				= "死亡";
	DBM_OFFLINE				= "离线";
	DBM_PHASE				= "第%s阶段";
	DBM_WAVE				= "第%s波";
	
-- Added 11.11.06
	DBM_NOGUI_ERROR	= "对不起，请开启 DBM GUI 来进行操作";
	DBM_NOSYNCBARS	= "目前没有计时条";

-- Added 1.12.06
	DBM_LEFT	= "左";
	DBM_RIGHT	= "右";
	
	DBM_GUI_COMBATLOG_RANGE_TITLE      = "战斗记录距离";
	DBM_GUI_COMBATLOG_MIN_RANGE        = "战斗记录侦测距离设置为最小";
	DBM_GUI_COMBATLOG_MAX_RANGE        = "战斗记录侦测距离设置为最大";
	DBM_GUI_COMBATLOG_LONG_RANGE       = "战斗记录侦测距离设置为长";
	DBM_GUI_COMBATLOG_DEFAULT_RANGE    = "战斗记录侦测距离设置为默认";	
	
	DBMGUI_DISTANCE_FRAME_TITLE		= "距离";
	DBMGUI_DISTANCE_FRAME_TEXT		= "距离过近:";
	DBMGUI_DISTANCE_FRAME_TEXT_15YD	= "距离过近(15码):";
	
	DBMGUI_INFOFRAME_TOOLTIP_TITLE	= "信息框体";
	DBMGUI_INFOFRAME_TOOLTIP_TEXT	= "右键点击以移动\nShift+右键单击以隐藏";
	
	DBMGUI_STATUSBAR_WIDTH_SLIDER	= "宽度";
	DBMGUI_STATUSBAR_SCALE_SLIDER	= "缩放";
	
	DBMGUI_BUTTON_RANGECHECK		= "距离侦测";
	DBMGUI_TOOLTIP_RANGECHECK_TITLE	= "距离侦测";
	DBMGUI_TOOLTIP_RANGECHECK_TEXT	= "侦测距离你超过30码的队友。";
	
	DBMGUI_BUTTON_DISTANCEFRAME			= "距离框体";
	DBMGUI_TOOLTIP_DISTANCEFRAME_TITLE	= "距离框体";
	DBMGUI_TOOLTIP_DISTANCEFRAME_TEXT	= "显示隐藏距离侦测框体。它将显示距离你过近(10码)的队友。这个功能在诸如克苏恩或哈霍兰公主的作战中相当实用。";

-- Added 2.12.06
	DBM_NAME		= "名字";
	DBM_DURABILITY	= "耐久度";

	DBM_LOAD_GUI_ERROR_FORMAT	= "读取图形界面(GUI)时发生错误: %s";
	DBM_LOAD_GUI_ERROR_UNKNOWN	= "读取图形界面(GUI)时发生未知错误";

-- Added 9.12.06
	DBM_ERROR_INVALID_MODID	= "错误：模块ID必须是字符！";
	DBM_ERROR_MODID_EXISTS	= "错误：以'%s'为ID的模块已经存在！";

-- Added 11.12.06
	DBM_COMBAT_TABLE_WARNING	= "警告：以此为ID的模块已经注册，更新信息中……"

-- Added 13.12.06
	DBM_TIMER_SLASHCMD_HELP1	= "/lv timer <时间> <文字>  -  开始一个计时条";
	DBM_TIMER_SLASHCMD_HELP2	= "/lv broadcast timer <时间> <文字>  -  广播一个计时条";

-- Added 20.12.06
	DBM_HORDE		= "部落";
	DBM_ALLIANCE	= "联盟";

-- Added 22.12.06
	DBM_ENABLED_GREEN	= GREEN_FONT_COLOR_CODE.."开启"..FONT_COLOR_CODE_CLOSE;
	DBM_DISABLED_RED	= RED_FONT_COLOR_CODE.."关闭"..FONT_COLOR_CODE_CLOSE;
	DBM_ERROR			= "错误";

-- 2.1.07
	DBM_UPGRADE			= "更新";
	DBM_BAR_STYLE_GLAZE = "Glaze";
	
-- 9.1.07
	DBM_BOSS_MOD_LOADED	= "已载入“%s”模块。";

	DBM_MISC	= "其他";

	DBMGUI_TAB_NAXX_TEXT	= "Naxx";
	DBMGUI_TAB_AQ40_TEXT	= "AQ40";
	DBMGUI_TAB_BWL_TEXT		= "BWL";
	DBMGUI_TAB_MC_TEXT		= "MC";
	DBMGUI_TAB_OTHER_TEXT	= "其他";
	DBMGUI_TAB_AQ20_TEXT	= "AQ20";
	DBMGUI_TAB_ZG_TEXT		= "ZG";
	DBMGUI_TAB_BG_TEXT		= "战场"

	DBMGUI_TAB_1_TITLE_TEXT		= "纳克萨玛斯";
	DBMGUI_TAB_2_TITLE_TEXT		= "安其拉神殿";
	DBMGUI_TAB_3_TITLE_TEXT		= "黑翼之巢";
	DBMGUI_TAB_4_TITLE_TEXT		= "熔火之心";
	DBMGUI_TAB_6_TITLE_TEXT		= "其他";
	DBMGUI_TAB_ZG_TITLE_TEXT	= "祖尔格拉布";
	DBMGUI_TAB_AQ20_TITLE_TEXT	= "安其拉废墟";
	DBMGUI_TAB_BG_TITLE_TEXT	= "战场";

-- 10.1.07
-- outdoor boss names for load on demand
	DBM_OUTDOOR_YSONDRE	= "伊森德雷";
	DBM_OUTDOOR_EMERISS	= "艾莫莉丝";
	DBM_OUTDOOR_TAERAR	= "泰拉尔";
	DBM_OUTDOOR_LETHON	= "莱索恩";
	DBM_AZUREGOS_NAME	= "艾索雷葛斯";
	DBM_KAZZAK_NAME		= "末日领主卡扎克";
	DBM_DOOMW_NAME		= "末日行者";

	DBM_ERROR_LVBM_STILL_LOADED	= "未删除旧有的版本，目前有2个版本的DBM正在运行！\n单击“运行”按钮以禁用旧有的版本并重载界面。\n这样的话您不必删除旧有的版本。";
	DBM_DISABLE_AND_RELOAD		= "确认";

-- event abstraction layer
	DBM_EAL_MOBCASTSTART_EXPR	= "([^%s]+)开始施放([^%s]+)。";
	DBM_EAL_MOBCAST_EXPR		= "([^%s]+)施放了([^%s]+)。";
	DBM_EAL_DEBUFF_EXPR			= "([^%s]+)受到了([^%s]+)效果的影响。";
	DBM_EAL_MOB_BUFF_EXPR		= "([^%s]+)获得了([^%s]+)的效果。";
	DBM_EAL_MOBDEAD_EXPR		= "([^%s]+)死亡了。";

--new tabs
	DBM_KARAZHAN_TAB		= "卡拉赞"
	DBM_KARAZHAN_TAB_TEXT	= "卡拉赞"
	DBM_KARAZHAN_TAB_TITLE	= "卡拉赞"
	
--20.2.07
	DBM_MSG_CLEANICONS = "已清除团队标记";

--18.3.07
	DBM_HEAVY_NW_BANDAGE			= "厚灵纹布绷带";
	DBM_RANGE_FRAME_BANDAGE_MISSING	= "在设置距离检测窗口检测距离为15码时发生错误。请确定携带有厚灵纹布绷带。"

-- drt
	DRT_PULLCOMMAND_ANNOUNCE	= "*** 即将开战 ***";
	DRT_PULLCOMMAND_SELFWARN	= "战斗开始";
	DRT_PULLCOMMAND_PREWARN		= "*** %d秒后开战 ***";
	DRT_PULLCOMMAND_FAILED		= "请使用 /dbm pull 10";	

	DRT_INVITE_NOPERMISSION		= "对不起，你必须为团队领袖或助理才可以使用该功能";
	DRT_SPAMBLOCK_OPTION_SET	= "过滤选项“%s”已设置为“%s”";

-- 28.4.07
	DBM_REQUEST_BARS_FROM	= "从%s处请求计时条信息...";
	DBM_REQUEST_BARS_FAILED	= "错误：计时条恢复系统需要团队内制药有1名其他成员使用2.60或以上版本的DBM。";
	
-- 20.9.07
	DBM_GENERIC_ENRAGE_WARN	= "%s%s后激怒"

-- 6.10.07
	DBM_GENERIC_PHASE_MSG	= "第%s阶段"
	DBM_GENERIC_PHASE_MSG2	= "%s阶段"

	DBM_HP_UNKNOWN			= "生命值未知"

	DBMGUI_OPTIONS_BAR_TARGET	= "<目标>"

	DBM_NO_TARGET				= "<没有目标>"
end
