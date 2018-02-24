﻿

-- Localisation file
-- Translation by Hughman

if (GetLocale() == "zhCN") then

-- Tabs
XPERL_CONF_TITLE1   = "全局"
XPERL_CONF_TITLE2   = PLAYER	-- "玩家" Taken from WoW's FrameXML/GlobalStrings.lua
XPERL_CONF_TITLE3   = TARGET	-- "目标"
XPERL_CONF_TITLE4   = PARTY	-- "队伍"
XPERL_CONF_TITLE5   = RAID	-- "团队"
XPERL_CONF_TITLE6   = ALL
XPERL_CONF_TITLE7   = "颜色"
XPERL_CONF_TITLE8   = "助手"
XPERL_CONF_TITLE9   = "Admin"

XPERL_CONF_OPTIONS_COLOUR		= "改变选项窗颜色"

-- Titles
XPERL_CONF_PLAYER_ALIGNMENT		= "玩家框体对齐"
XPERL_CONF_PARTY_ALIGNMENT		= "队伍框体对齐"
XPERL_CONF_RAID_ALIGNMENT		= "团队框体对齐"
XPERL_CONF_FRAME_APPEARANCE		= "框体外观"
XPERL_CONF_3RD_PARTY_CLICKERS		= "第三方治疗插件支持"
XPERL_CONF_PET_OPTIONS			= "宠物选项"
XPERL_CONF_TARGETTARGET_OPTIONS		= "目标的目标选项"
XPERL_CONF_GROUPS			= "小队"
XPERL_CONF_TANK_TARGETS			= "坦克目标"
XPERL_CONF_RAID_ADMIN			= "团队管理"
XPERL_CONF_TARGET_COUNTERS		= "目标计数器"
XPERL_CONF_COLOUR_REACTIONS		= "角色阵营"
XPERL_CONF_ADDONS			= "X-Perl 插件"

-- Popups
XPERL_CONF_CONFIRM_RESET		= "你确定要重置所有选项为默认值吗？?"
XPERL_CONF_QUERY_DISABLE_TT		= "你想禁用 X-Perl 目标的目标模块吗？"
XPERL_CONF_QUERY_DISABLE_PARTY_PET	= "你想禁用 X-Perl 队友宠物模块吗？"
XPERL_CONF_QUERY_DISABLE_RAID		= "你想禁用 X-Perl 团队框体模块吗？"

-- Alignment controls
XPERL_CONF_ALIGN_SPACING		= "间距"
XPERL_CONF_ALIGN_PLAYER_TOP     	= "上下对齐"
XPERL_CONF_ALIGN_PLAYER_TOP_DESC	= "对齐玩家、目标及目标的目标框"
XPERL_CONF_ALIGN_PARTY_LEFT		= "左右对齐"
XPERL_CONF_ALIGN_PARTY_LEFT_DESC	= "各队友与队友1左右对齐"
XPERL_CONF_ALIGN_RAID_TOP		= "上下对齐"
XPERL_CONF_ALIGN_RAID_TOP_DESC		= "各团队小组与小队1上下对齐"
XPERL_CONF_ALIGN_RAID_ALL		= "所有"
XPERL_CONF_ALIGN_RAID_ALL_DESC		= "对齐所有团队框体"
XPERL_CONF_ALIGN_RAID_ODD		= "奇数队"
XPERL_CONF_ALIGN_RAID_ODD_DESC		= "对齐奇数队框体"
XPERL_CONF_ALIGN_RAID_EVEN		= "偶数队"
XPERL_CONF_ALIGN_RAID_EVEN_DESC		= "对齐偶数队框体"
XPERL_CONF_ALIGN_RAID_FIRST4		= "前4队"
XPERL_CONF_ALIGN_RAID_FIRST4_DESC	= "对齐前4队框体"
XPERL_CONF_ALIGN_RAID_LAST4		= "后4队"
XPERL_CONF_ALIGN_RAID_LAST4_DESC	= "对齐后4队框体"

-- Global options
XPERL_CONF_BAR_TEXTURES                 = "默认纹理"
XPERL_CONF_BAR_TEXTURES_ONE             = "纹理 1"
XPERL_CONF_BAR_TEXTURES_TWO             = "纹理 2"
XPERL_CONF_BAR_TEXTURES_THREE           = "纹理 3"
XPERL_CONF_BAR_TEXTURES_DESC		= "启用WoW默认纹理"
XPERL_CONF_BAR_TEXTURES_ONE_DESC	= "启用X-Perl第一种纹理"
XPERL_CONF_BAR_TEXTURES_TWO_DESC	= "启用X-Perl的第二种纹理"
XPERL_CONF_BAR_TEXTURES_THREE_DESC	= "启用X-Perl的第三种纹理"

XPERL_CONF_FATHEALTHBARS		= "生命条加粗显示"
XPERL_CONF_FATHEALTHBARS_DESC		= "粗大的生命条(和窄小的魔法条)"
XPERL_CONF_COLOUR_NAMES			= "姓名按职业着色"
XPERL_CONF_COLOUR_NAMES_DESC		= "玩家的名字颜色匹配相应的职业颜色"
XPERL_CONF_COMBAT_FLASH			= "战斗时闪烁框体"
XPERL_CONF_COMBAT_FLASH_DESC		= "受到伤害或治疗时闪烁边框"
XPERL_CONF_FADING_FRAMES		= "框体渐隐"
XPERL_CONF_FADING_FRAMES_DESC		= "启用框体渐隐"
XPERL_CONF_HEALER_MODE			= "治疗者模式"
XPERL_CONF_HEALER_MODE_DESC		= "显示生命损失值而不是当前的生命值"
XPERL_CONF_HEALERMODE_DEFICIT		= "损失值"
XPERL_CONF_HEALERMODE_DEFICIT_DESC      = "只显示生命损失值"
XPERL_CONF_HEALERMODE_DEFICITMAX        = "损失值/最大值"
XPERL_CONF_HEALERMODE_DEFICITMAX_DESC   = "同时显示生命损失值和最大值"
XPERL_CONF_ARCANE_BAR                   = "施法进度条"
XPERL_CONF_ARCANE_BAR_DESC              = "在玩家状态框名字栏显示施法进度条"
XPERL_CONF_ORIGINAL_CASTBAR             = "原始施法进度条"
XPERL_CONF_ORIGINAL_CASTBAR_DESC        = "启用系统默认施法进度条"
XPERL_CONF_CAST_TIME                    = "施法时间"
XPERL_CONF_CAST_TIME_DESC               = "显示具体施法时间"
XPERL_CONF_SELECTION_HIGHLIGHT		= "高亮选择"
XPERL_CONF_SELECTION_HIGHLIGHT_DESC     = "被选中的框体高亮显示"
XPERL_CONF_MINIMAP_ICON			= "迷你地图图标"
XPERL_CONF_MINIMAP_ICON_DESC		= "显示迷你地图图标 （右击图标移动）"
XPERL_CONF_SAVEPERCHARACTER		= "角色独立保存设置"
XPERL_CONF_SAVEPERCHARACTER_DESC	= "启用后，设置基于每个角色独立保存，而不是全局"
XPERL_CONF_HIGHLIGHTDEBUFFS		= "高亮减益魔法"
XPERL_CONF_HIGHLIGHTDEBUFFS_DESC	= "高亮显示玩家的减益魔法"
XPERL_CONF_HIGHLIGHTDEBUFFSBORDER	= "醒目的高亮边框"
XPERL_CONF_HIGHLIGHTDEBUFFSBORDER_DESC	= "获得减益魔法时玩家状态框周围显示更加醒目的高亮边框"
XPERL_CONF_BUFFTOOLTIPHELPER		= "增益魔法提示助手"
XPERL_CONF_BUFFTOOLTIPHELPER_DESC	= "鼠标滑过一个增益魔法时列出团队中没有该魔法的成员（按住ALT显示已经获得该魔法的成员）"
XPERL_CONF_FADINGTOOLTIP		= "提示渐隐"
XPERL_CONF_FADINGTOOLTIP_DESC		= "启用buff提示渐隐"
XPERL_CONF_MAXIMUM_SCALE		= "最大框体比例"
XPERL_CONF_MAXIMUM_SCALE_DESC		= "调整框体可以缩放的最大比例"
XPERL_CONF_CLEAR_BLIZZ			= "清除 Blizzard 框体"
XPERL_CONF_CLEAR_BLIZZ_DESC		= "清除 (nil out) 所有 Blizzard 玩家状态框以及相关的功能调用。 \r|c00FF0000警告! 该设置可能使某些依赖游戏默认状态框的插件报错，尽管它会提示你加载了什么不必要的插件。该功能只在X-Perl载入的时候执行，所有你至少需要重置一次插件。"
XPERL_CONF_RESET_DEFAULTS		= "重置为默认"
XPERL_CONF_RESET_DEFAULTS_DESC		= "重置所有选项为默认值"
XPERL_CONF_LOAD_SETTINGS		= "复制设置自..."
XPERL_CONF_LOAD_SETTINGS_DESC		= "从其他角色复制设置"

XPERL_CONF_CASTPARTY_FEATURES           = "第三方治疗插件支持"
XPERL_CONF_CASTPARTY_FEATURES_DESC      = "启用 Cast Party, Genesis Clicks, Smart Heal 框体点击治疗特性"
XPERL_CONF_CASTPARTY_RAID		= "只在团队启用"
XPERL_CONF_CASTPARTY_RAID_DESC		= "只对团队框点击加血"

XPERL_CONF_PLAYER_PORTRAIT              = "玩家头像"
XPERL_CONF_PLAYER_PORTRAIT_DESC         = "显示玩家头像"
XPERL_CONF_PLAYER_PORTRAIT3D            = "3D 头像"
XPERL_CONF_PLAYER_PORTRAIT3D_DESC       = "显示3D头像"
XPERL_CONF_PLAYER_LEVEL                 = "玩家等级"
XPERL_CONF_PLAYER_LEVEL_DESC            = "显示玩家等级"
XPERL_CONF_PLAYER_VALUES		= "玩家生命魔法值"
XPERL_CONF_PLAYER_VALUES_DESC		= "在玩家生命条和魔法条上显示具体的数值"
XPERL_CONF_PLAYER_PERCENT		= "玩家生命魔法百分比"
XPERL_CONF_PLAYER_PERCENT_DESC		= "显示玩家生命值和魔法值的百分比"
XPERL_CONF_PLAYER_ICON                  = "玩家职业图标"
XPERL_CONF_PLAYER_ICON_DESC             = "显示玩家的职业图标"
XPERL_CONF_PLAYER_XP                    = "玩家经验条"
XPERL_CONF_PLAYER_XP_DESC               = "显示玩家的经验条。如果玩家已经满级则显示当前关注的声望。"
XPERL_CONF_PLAYER_PVP                   = "玩家PVP军衔"
XPERL_CONF_PLAYER_PVP_DESC              = "显示玩家的PVP军衔"
XPERL_CONF_PLAYER_PVPICON		= "玩家PVP标志"
XPERL_CONF_PLAYER_PVPICON_DESC		= "显示玩家的PVP状态"
XPERL_CONF_PLAYER_ENERGY		= "能量回复"
XPERL_CONF_PLAYER_ENERGY_DESC		= "在盗贼或猎豹形态的德鲁伊的能量条下方显示能量回复"
XPERL_CONF_PARTY_FULLSCREEN		= "全屏警告"
XPERL_CONF_PARTY_FULLSCREEN_DESC	= "生命值过低或被精神控制时启用Blizzard全屏警告"

XPERL_CONF_PLAYER_PET_NAME		= "宠物名字"
XPERL_CONF_PLAYER_PET_NAME_DESC		= "显示玩家的宠物名字"
XPERL_CONF_PLAYER_PET_PORTRAIT		= "宠物头像"
XPERL_CONF_PLAYER_PET_PORTRAIT_DESC	= "显示你的宠物的头像"
XPERL_CONF_PLAYER_PET_PORTRAIT3D        = "3D 头像"
XPERL_CONF_PLAYER_PET_PORTRAIT3D_DESC	= "显示宠物的3D头像"
XPERL_CONF_PLAYER_PET_HAPPINESS         = "宠物快乐度"
XPERL_CONF_PLAYER_PET_HAPPINESS_DESC    = "显示宠物的快乐度"
XPERL_CONF_PLAYER_PET_ONLYSAD		= "只在不快乐时显示"
XPERL_CONF_PLAYER_PET_ONLYSAD_DESC	= "只在不快乐时显示宠物的快乐度指示器"
XPERL_CONF_PLAYER_PET_FLASHSAD		= "不快乐时闪烁"
XPERL_CONF_PLAYER_PET_FLASHSAD_DESC	= "宠物不快乐时闪烁快乐度指示器"
XPERL_CONF_PLAYER_PET_LEVEL             = "宠物等级"
XPERL_CONF_PLAYER_PET_LEVEL_DESC        = "显示宠物等级"
XPERL_CONF_PLAYER_PET_XP                = "宠物经验条"
XPERL_CONF_PLAYER_PET_XP_DESC           = "显示宠物经验条"
XPERL_CONF_PLAYER_PET_SCALE             = "宠物框比例"
XPERL_CONF_PLAYER_PET_SCALE_DESC        = "调整宠物框比例"
XPERL_CONF_PLAYER_PET_BUFF_SIZE		= "宠物增减益魔法大小"
XPERL_CONF_PLAYER_PET_BUFF_SIZE_DESC	= "调整你的宠物的增益和减益魔法的图标大小"

XPERL_CONF_TARGET_PORTRAIT              = "目标头像"
XPERL_CONF_TARGET_PORTRAIT_DESC         = "显示目标的头像。\r|c00FF0000注意: 伤害指示器依赖于它"
XPERL_CONF_TARGET_PORTRAIT3D            = "3D 头像"
XPERL_CONF_TARGET_PORTRAIT3D_DESC       = "显示目标的3D头像"
XPERL_CONF_TARGET_BUFFSABOVE		= "Buffs在上方"
XPERL_CONF_TARGET_BUFFSABOVE_DESC	= "在目标状态框上方显示Buffs"
XPERL_CONF_TARGET_ICON                  = "目标职业图标"
XPERL_CONF_TARGET_ICON_DESC             = "显示目标的职业图标"
XPERL_CONF_TARGET_MOBTYPE               = "目标生物类型"
XPERL_CONF_TARGET_MOBTYPE_DESC          = "显示目标的生物类型"
XPERL_CONF_TARGET_LEVEL                 = LEVEL		-- "Level"	Uses WoW Localization
XPERL_CONF_TARGET_LEVEL_DESC            = "显示目标的等级"
XPERL_CONF_TARGET_ELITE                 = "精英标志"
XPERL_CONF_TARGET_ELITE_DESC            = "显示目标的精英标志"
XPERL_CONF_TARGET_MANA                  = MANA		-- "Mana"	Uses WoW Localization
XPERL_CONF_TARGET_MANA_DESC             = "显示目标的魔法"
XPERL_CONF_TARGET_VALUES		= "数值"
XPERL_CONF_TARGET_VALUES_DESC		= "在目标生命条和魔法条上显示具体的数值"
XPERL_CONF_TARGET_PERCENT		= "百分比"
XPERL_CONF_TARGET_PERCENT_DESC		= "显示目标生命值和魔法值的百分比"
XPERL_CONF_TARGET_CPBLIZZ		= "Blizzard 连击点"
XPERL_CONF_TARGET_CPBLIZZ_DESC		= "显示游戏默认的连击点"
XPERL_CONF_TARGET_CPBLIZZ_POSTOP	= "上边"
XPERL_CONF_TARGET_CPBLIZZ_POSTOP_DESC	= "在头像上边显示Blizzard连击点"
XPERL_CONF_TARGET_CPBLIZZ_POSLEFT	= "左边"
XPERL_CONF_TARGET_CPBLIZZ_POSLEFT_DESC	= "在头像左边显示Blizzard连击点"
XPERL_CONF_TARGET_CPBLIZZ_POSRIGHT	= "右边"
XPERL_CONF_TARGET_CPBLIZZ_POSRIGHT_DESC	= "在头像右边显示Blizzard连击点"
XPERL_CONF_TARGET_CPBLIZZ_POSBOTTOM	= "下边"
XPERL_CONF_TARGET_CPBLIZZ_POSBOTTOM_DESC= "在头像下边显示Blizzard连击点"
XPERL_CONF_TARGET_CP                    = "显示连击点条"
XPERL_CONF_TARGET_CP_DESC               = "在目标框上显示连击点进度条。也可以显示破甲、暗影易伤、火焰易伤的个数)"
XPERL_CONF_TARGET_PVP                   = "目标PVP军衔"
XPERL_CONF_TARGET_PVP_DESC              = "显示目标的PVP军衔"
XPERL_CONF_TARGET_PVPICON		= "PVP 标志"
XPERL_CONF_TARGET_PVPICON_DESC		= "显示目标的PVP状态"
XPERL_CONF_TARGET_RAIDICON_ALT		= "队长标记图标位置"
XPERL_CONF_TARGET_RAIDICON_ALT_DESC	= "在头像边上显示队长标记。默认显示在名字栏中间"
XPERL_CONF_TARGET_30YD			= "30码距离指示器"
XPERL_CONF_TARGET_30YD_DESC		= "目标在30码以外显示一只手的图形，30码以内则消失"
XPERL_CONF_HIT_INDICATOR		= "伤害指示器"
XPERL_CONF_HIT_INDICATOR_DESC		= "在玩家和目标的头像上显示受到的伤害"
XPERL_CONF_TARGET_BUFF_SIZE		= "目标增减益魔法大小"
XPERL_CONF_TARGET_BUFF_SIZE_DESC	= "调整目标增益和减益魔法的图标大小"
XPERL_CONF_TARGET_BUFF_ROWS		= "目标增减益魔法排列"
XPERL_CONF_TARGET_BUFF_ROWS_DESC	= "调整每行可以显示的增益或减益魔法的最大个数"
XPERL_CONF_TARGET_CASTABLE		= "可施放的增益魔法"
XPERL_CONF_TARGET_CASTABLE_DESC		= "只显示你可以施法的增益魔法"
XPERL_CONF_TARGET_CURABLE		= "可解除的减益魔法"
XPERL_CONF_TARGET_CURABLE_DESC		= "只显示你可以解除的减益魔法"

XPERL_CONF_TARGETS_TARGET               = "目标的目标"
XPERL_CONF_TARGETS_TARGET_DESC          = "显示目标的目标"
XPERL_CONF_TARGETS_HISTORY		= "目标的目标历史"
XPERL_CONF_TARGETS_HISTORY_DESC		= "显示目标的目标历史"
XPERL_CONF_TARGETTARGET_BUFFS		= "目标的目标增益魔法"
XPERL_CONF_TARGETTARGET_BUFFS_DESC	= "显示目标的目标的增益和减益魔法"
XPERL_CONF_TARGETTARGET_BUFFSABOVE	= "Buffs在上方"
XPERL_CONF_TARGETTARGET_BUFFSABOVE_DESC	= "在目标的目标（以及目标的目标的目标）框上方显示buffs"
XPERL_CONF_TARGETS_TARGETS_TARGET	= "目标的目标的目标"
XPERL_CONF_TARGETS_TARGETS_TARGET_DESC	= "显示目标的目标的目标"
XPERL_CONF_TARGETTARGETTARGET_BUFFS	= "目标的目标的目标的增益魔法"
XPERL_CONF_TARGETTARGETTARGET_BUFFS_DESC	= "显示目标的目标的目标的增益和减益魔法"
XPERL_CONF_TARGETTARGET_VALUES		= XPERL_CONF_TARGET_VALUES
XPERL_CONF_TARGETTARGET_VALUES_DESC     = XPERL_CONF_TARGET_VALUES_DESC
XPERL_CONF_TARGETTARGET_PERCENT         = XPERL_CONF_TARGET_PERCENT
XPERL_CONF_TARGETTARGET_PERCENT_DESC    = XPERL_CONF_TARGET_PERCENT_DESC
XPERL_CONF_TARGETTARGET_LEVEL		= XPERL_CONF_TARGET_LEVEL
XPERL_CONF_TARGETTARGET_LEVEL_DESC	= XPERL_CONF_TARGET_LEVEL_DESC
XPERL_CONF_TARGETTARGET_MANA		= XPERL_CONF_TARGET_MANA
XPERL_CONF_TARGETTARGET_MANA_DESC	= XPERL_CONF_TARGET_MANA_DESC

XPERL_CONF_PARTY_NAMES                  = "队友名字"
XPERL_CONF_PARTY_NAMES_DESC             = "显示小队成员的名字。注意：战斗指示、队长标志、拾取方式、 charm warning、距离指示均依赖于此框体。"
XPERL_CONF_PARTY_PORTRAIT		= "队友头像"
XPERL_CONF_PARTY_PORTRAIT_DESC		= "显示小队成员的头像"
XPERL_CONF_PARTY_PORTRAIT3D             = "3D 头像"
XPERL_CONF_PARTY_PORTRAIT3D_DESC        = "显示队友的3D头像"
XPERL_CONF_PARTY_LEVEL                  = "队友等级"
XPERL_CONF_PARTY_LEVEL_DESC             = "显示小队成员的头像"
XPERL_CONF_PARTY_TARGET			= "队友目标"
XPERL_CONF_PARTY_TARGET_DESC		= "显示小队成员的目标"
XPERL_CONF_PARTY_ICON                   = "队友职业图标"
XPERL_CONF_PARTY_ICON_DESC              = "消失小队成员的职业图标"
XPERL_CONF_PARTY_PVPICON		= "队友PVP标志"
XPERL_CONF_PARTY_PVPICON_DESC		= "显示队友的PVP状态"
XPERL_CONF_PARTY_VALUES			= "队友生命魔法值"
XPERL_CONF_PARTY_VALUES_DESC            = "显示小队成员的生命值和魔法值"
XPERL_CONF_PARTY_PERC                   = "队友生命魔法百分比"
XPERL_CONF_PARTY_PERC_DESC              = "显示小队成员的生命值和魔法值的百分比"
XPERL_CONF_PARTY_PETS                   = "队友宠物"
XPERL_CONF_PARTY_PETS_DESC              = "显示小队成员的宠物"
XPERL_CONF_PARTY_PETNAME		= "队友宠物名字"
XPERL_CONF_PARTY_PETNAME_DESC		= "显示小队成员的宠物的名字"
XPERL_CONF_PARTY_PETBUFFS		= "队友宠物Buffs"
XPERL_CONF_PARTY_PETBUFFS_DESC		= "显示队友宠物的buffs"
XPERL_CONF_PARTY_INRAID                 = "团队中不隐藏小队界面"
XPERL_CONF_PARTY_INRAID_DESC            = "在团队中仍显示小队界面"
XPERL_CONF_PARTY_BUFFS			= "队友增益魔法"
XPERL_CONF_PARTY_BUFFS_DESC		= "显示小队成员的增益魔法"
XPERL_CONF_PARTY_DEBUFFS		= "队友减益魔法"
XPERL_CONF_PARTY_DEBUFFS_DESC		= "显示小队成员的减益魔法"
XPERL_CONF_PARTY_DEBUFFSBELOW           = "队友减益魔法在框体下方"
XPERL_CONF_PARTY_DEBUFFSBELOW_DESC      = "切换小队成员的减益魔法是显示在框体下方还是右边"
XPERL_CONF_PARTY_30YD			= "30码距离指示器"
XPERL_CONF_PARTY_30YD_DESC		= "队友在30码以外显示一只手的图形，30码以内则消失"
XPERL_CONF_PARTY_BUFF_SIZE		= "队友增减益魔法大小"
XPERL_CONF_PARTY_BUFF_SIZE_DESC		= "调整小队成员的增益和减益魔法的图标大小"
XPERL_CONF_PARTY_CASTABLE		= "可施放的增益魔法"
XPERL_CONF_PARTY_CASTABLE_DESC		= "只显示你可以施放的增益魔法"
XPERL_CONF_PARTY_CURABLE		= "可解除的减益魔法"
XPERL_CONF_PARTY_CURABLE_DESC		= "只显示你可以解除的减益魔法"

XPERL_CONF_RAID_PARTY_NUM		= "显示所在小队"
XPERL_CONF_RAID_PARTY_NUM_DESC		= "在团队中则显示所在小队编号"
XPERL_CONF_RAID_SHOW                    = "显示团队框体"
XPERL_CONF_RAID_SHOW_DESC               = "显示团队框体（如果此选项关闭，则进游戏时不加载团队模块）"
XPERL_CONF_RAID_TITLES			= "团队小队编号"
XPERL_CONF_RAID_TITLES_DESC		= "显示在团队中的小队编号"
XPERL_CONF_RAID_UPWARD			= "向上扩展"
XPERL_CONF_RAID_UPWARD_DESC		= "从小队编号开始向上扩展团队成员框"
XPERL_CONF_RAID_MANA			= "团队成员魔法"
XPERL_CONF_RAID_MANA_DESC		= "显示团队成员的魔法条"
XPERL_CONF_RAID_PERCENTS		= "团队成员生命魔法百分比"
XPERL_CONF_RAID_PERCENTS_DESC		= "显示团队成员的生命值和魔法值的百分比"
XPERL_CONF_RAID_SORTBYCLASS             = "按职业排列"
XPERL_CONF_RAID_SORTBYCLASS_DESC        = "团队框体按职业排列"
XPERL_CONF_RAID_TANKER			= "高亮坦克"
XPERL_CONF_RAID_TANKER_DESC		= "团队中高亮被你的目标（敌对的）或你的目标（友好的）的目标盯住的玩家"
XPERL_CONF_RAID_SPACING			= "垂直间距"
XPERL_CONF_RAID_SPACING_DESC		= "设置团队框体的垂直间距"
XPERL_CONF_RAID_PERC                    = "团队成员生命魔法百分比"
XPERL_CONF_RAID_PERC_DESC               = "显示团队成员的生命值和魔法值的百分比"
XPERL_CONF_RAID_BUFFS			= "团队增益魔法"
XPERL_CONF_RAID_BUFFS_DESC		= "显示前4个团队增益魔法"
XPERL_CONF_RAID_DEBUFFS			= "团队减益魔法"
XPERL_CONF_RAID_DEBUFFS_DESC		= "显示前4个团队减益魔法"
XPERL_CONF_RAID_CASTABLE		= "只显示可施加或解除的"
XPERL_CONF_RAID_CASTABLE_DESC		= "只显示玩家可以施加的增益魔法或可以解除的减益魔法"
XPERL_CONF_RAID_BUFFSRIGHT		= "增益魔法显示在框体右边"
XPERL_CONF_RAID_BUFFSRIGHT_DESC		= "团队增益或减益魔法显示在团队成员框的右边"
XPERL_CONF_RAID_BUFFSINSIDE		= "增益魔法显示在框体内"
XPERL_CONF_RAID_BUFFSINSIDE_DESC	= "团队增益或减益魔法显示在团队成员框体内"
XPERL_CONF_RAID_MOTION			= "框体移动轨迹"
XPERL_CONF_RAID_MOTION_DESC		= "动态显示框体移动轨迹，否则立即改变位置"
XPERL_CONF_RAID_GROUP1                  = "小队 1 (战士)"
XPERL_CONF_RAID_GROUP1_DESC             = "显示团队第1小队"
XPERL_CONF_RAID_GROUP2                  = "小队 2 (魔法)"
XPERL_CONF_RAID_GROUP2_DESC             = "显示团队第2小队"
XPERL_CONF_RAID_GROUP3                  = "小队 3 (牧师)"
XPERL_CONF_RAID_GROUP3_DESC             = "显示团队第3小队"
XPERL_CONF_RAID_GROUP4                  = "小队 4 (术士)"
XPERL_CONF_RAID_GROUP4_DESC             = "显示团队第4小队"
XPERL_CONF_RAID_GROUP5                  = "小队 5 (德鲁依)"
XPERL_CONF_RAID_GROUP5_DESC             = "显示团队第5小队"
XPERL_CONF_RAID_GROUP6                  = "小队 6 (盗贼)"
XPERL_CONF_RAID_GROUP6_DESC             = "显示团队第6小队"
XPERL_CONF_RAID_GROUP7                  = "小队 7 (猎人)"
XPERL_CONF_RAID_GROUP7_DESC             = "显示团队第7小队"
XPERL_CONF_RAID_GROUP8                  = "小队 8 (萨满祭司/圣骑士)"
XPERL_CONF_RAID_GROUP8_DESC             = "显示团队第8小队"

XPERL_CONF_ALL_PORTRAIT			= "头像"
XPERL_CONF_ALL_PORTRAIT_DESC		= "显示所有头像"
XPERL_CONF_ALL_PORTRAIT3D		= "3D 头像"
XPERL_CONF_ALL_PORTRAIT3D_DESC		= "显示所有3D头像"
XPERL_CONF_ALL_LEVEL			= "等级"
XPERL_CONF_ALL_LEVEL_DESC		= "显示所有等级"
XPERL_CONF_ALL_ICON			= "职业图标"
XPERL_CONF_ALL_ICON_DESC		= "显示所有职业图标"
XPERL_CONF_ALL_PVP			= "PVP 军衔"
XPERL_CONF_ALL_PVP_DESC			= "显示所有PVP军衔"
XPERL_CONF_ALL_PVPFLAG			= "PVP 标志"
XPERL_CONF_ALL_PVPFLAG_DESC		= "显示所有PVP标志"
XPERL_CONF_ALL_VALUES			= "生命魔法值"
XPERL_CONF_ALL_VALUES_DESC		= "显示所有生命魔法值"
XPERL_CONF_ALL_PERCENT			= "生命魔法百分比"
XPERL_CONF_ALL_PERCENT_DESC		= "显示所有生命魔法百分比"

XPERL_CONF_GLOBAL_BORDERS		= EMBLEM_BORDER	-- "Borders"		Generic WoW lozalization
XPERL_CONF_GLOBAL_BORDERS_DESC		= "设置所有边框的颜色和透明度"
XPERL_CONF_GLOBAL_BACKGROUND		= BACKGROUND	-- "Background"		Generic WoW lozalization
XPERL_CONF_GLOBAL_BACKGROUND_DESC	= "设置所有框体背景的颜色和透明度"
XPERL_CONF_FRAME_TRANSPARENCY           = "框体透明度"
XPERL_CONF_FRAME_TRANSPARENCY_DESC      = "调整框体的透明度"
XPERL_CONF_TEXT_TRANSPARENCY            = "文本透明度"
XPERL_CONF_TEXT_TRANSPARENCY_DESC       = "调整文本的透明度"

XPERL_CONF_RAID_SCALE                   = "团队框比例"
XPERL_CONF_RAID_SCALE_DESC              = "调整团队框比例"
XPERL_CONF_TARGET_SCALE                 = "目标框比例"
XPERL_CONF_TARGET_SCALE_DESC            = "调整目标框比例"
XPERL_CONF_TARGETTARGET_SCALE           = "目标的目标框比例"
XPERL_CONF_TARGETTARGET_SCALE_DESC      = "调整目标的目标框比例"
XPERL_CONF_PLAYER_SCALE                 = "玩家框比例"
XPERL_CONF_PLAYER_SCALE_DESC            = "调整玩家框比例"
XPERL_CONF_PARTY_SCALE                  = "队友框比例"
XPERL_CONF_PARTY_SCALE_DESC             = "调整队友框比例"
XPERL_CONF_PARTYPET_SCALE		= "队友宠物框比例"
XPERL_CONF_PARTYPET_SCALE_DESC		= "调整队友宠物框比例"

XPERL_CONF_COLOUR_CLASSIC		= "经典的生命条颜色"
XPERL_CONF_COLOUR_CLASSIC_DESC		= "覆盖所选生命条颜色，使用经典的绿/红色外观"
XPERL_CONF_COLOUR_HEALTHEMPTY		= "空生命条"
XPERL_CONF_COLOUR_HEALTHEMPTY_DESC	= "改变所有空生命条的颜色"
XPERL_CONF_COLOUR_HEALTHFULL		= "满生命条"
XPERL_CONF_COLOUR_HEALTHFULL_DESC	= "改变所有满生命条的颜色"
XPERL_CONF_COLOUR_MANA			= MANA		-- "Mana"	Generic WoW localization
XPERL_CONF_COLOUR_MANA_DESC		= "改变所有魔法条的颜色"
XPERL_CONF_COLOUR_ENERGY		= ENERGY	-- "Energy"	Generic WoW localization
XPERL_CONF_COLOUR_ENERGY_DESC		= "改变所有能量条的颜色"
XPERL_CONF_COLOUR_RAGE			= RAGE		-- "Rage"	Generic WoW localization
XPERL_CONF_COLOUR_RAGE_DESC		= "改变所有怒气条的颜色"
XPERL_CONF_COLOUR_FOCUS			= FOCUS		-- "Focus"	Generic WoW localization
XPERL_CONF_COLOUR_FOCUS_DESC		= "改变所有集中条的颜色"
XPERL_CONF_ALPHA			= "透明度"
XPERL_CONF_ALPHA_DESC			= "改变透明度"
XPERL_CONF_COLOUR_RESET_MAIN		= RESET		-- "Reset"	Generic WoW localization
XPERL_CONF_COLOUR_RESET_MAIN_DESC	= "重置状态条颜色为默认"
XPERL_CONF_COLOUR_FRIEND		= "友好单位"
XPERL_CONF_COLOUR_FRIEND_DESC		= "设置友好单位的颜色(注意：对于玩家，名字按职业着色选项会覆盖此设置)"
XPERL_CONF_COLOUR_NEUTRAL		= "中立单位"
XPERL_CONF_COLOUR_NEUTRAL_DESC		= "设置中立单位的颜色 (注意：对于玩家，名字按职业着色选项会覆盖此设置)"
XPERL_CONF_COLOUR_UNFRIENDLY		= "非友好单位"
XPERL_CONF_COLOUR_UNFRIENDLY_DESC	= "设置非友好单位的颜色 (注意：对于玩家，名字按职业着色选项会覆盖此设置)"
XPERL_CONF_COLOUR_ENEMY			= "敌对单位"
XPERL_CONF_COLOUR_ENEMY_DESC		= "设置敌对单位的颜色 (注意：对于玩家，名字按职业着色选项会覆盖此设置)"
XPERL_CONF_COLOUR_NONE			= "无阵营单位"
XPERL_CONF_COLOUR_NONE_DESC		= "设置非PVP标志的单位的颜色 (注意：对于玩家，名字按职业着色选项会覆盖此设置)"
XPERL_CONF_COLOUR_TAPPED		= "已被攻击单位"
XPERL_CONF_COLOUR_TAPPED_DESC		= "设置已被 攻击的单位的颜色"
XPERL_CONF_COLOUR_RESET_REACTION	= RESET		-- "Reset"	Generic WoW localization
XPERL_CONF_COLOUR_RESET_REACTION_DESC	= "重置所有颜色为默认"

XPERL_CONF_TARGET_COUNTERS		= "目标计数器"
XPERL_CONF_TARGET_COUNTERS_DESC		= "计数以你或你的目标为目标的人"
XPERL_CONF_TARGET_COUNTERSSELF		= "以你为目标的治疗者"
XPERL_CONF_TARGET_COUNTERSSELF_DESC	= "只包括以你为目标的治疗职业"
XPERL_CONF_TARGET_COUNTERSENEMY		= "以你为目标的敌人"
XPERL_CONF_TARGET_COUNTERSENEMY_DESC    = "包括已知的以你为目标的敌人"
XPERL_CONF_ASSIST_SCALE			= "关注框比例"
XPERL_CONF_ASSIST_SCALE_DESC		= "改变关注框框的大小"
XPERL_CONF_ASSIST_ALPHA			= "关注框透明度"
XPERL_CONF_ASSIST_ALPHA_DESC		= "改变关注框的透明度"
XPERL_CONF_ASSIST_BACKALPHA		= "背景透明度"
XPERL_CONF_ASSIST_BACKALPHA_DESC	= "改变关注框的背景透明度"

XPERL_CONF_RAIDHELP_ENABLE		= "启用"
XPERL_CONF_RAIDHELP_ENABLE_DESC		= "显示坦克目标窗"
XPERL_CONF_RAIDHELP_CTTARGETS		= "调用CTRA（或oRA）的MT目标"
XPERL_CONF_RAIDHELP_CTTARGETS_DESC	= "调用CTRA或者oRA的坦克列表来代替内建的战士目标"
XPERL_CONF_RAIDHELP_COLLECTOTHERS	= "显示其他目标"
XPERL_CONF_RAIDHELP_COLLECTOTHERS_DESC	= "启用对非坦克目标的扫描"
XPERL_CONF_RAIDHELP_THREATBAR		= "威胁条"
XPERL_CONF_RAIDHELP_THREATBAR_DESC	= "在坦克目标窗显示威胁条（需要安装KTM）"
XPERL_CONF_RAIDHELP_SCALEOTHER		= "其他目标框比例"
XPERL_CONF_RAIDHELP_SCALEOTHER_DESC	= "改变非坦克目标框的比例"
XPERL_CONF_RAIDHELP_SCALE                = "目标框比例"
XPERL_CONF_RAIDHELP_SCALE_DESC		= "改变目标框的比例"
XPERL_CONF_RAIDHELP_ALPHA		= "目标框透明度"
XPERL_CONF_RAIDHELP_ALPHA_DESC		= "改变目标框的透明度"
XPERL_CONF_RAIDHELP_BACKALPHA		= "背景透明度"
XPERL_CONF_RAIDHELP_BACKALPHA_DESC	= "只改变目标框的背景透明度"
XPERL_CONF_RAIDHELP_TOOLTIPS		= "提示"
XPERL_CONF_RAIDHELP_TOOLTIPS_DESC	= "鼠标划过MT目标窗时显示提示"
XPERL_CONF_RAIDHELP_UNITHEIGHT		= "单位框高度"
XPERL_CONF_RAIDHELP_UNITHEIGHT_DESC	= "改变基础单位框高度"
XPERL_CONF_RAIDHELP_UNITWIDTH		= "单位框宽度"
XPERL_CONF_RAIDHELP_UNITWIDTH_DESC	= "改变基础单位框宽度"

XPERL_CONF_ADMIN_AUTOHIDESHOW		= "自动隐藏/显示"
XPERL_CONF_ADMIN_AUTOHIDESHOW_DESC	= "根据你在团队中的等级自动隐藏或显示团队管理窗"

XPERL_CONF_ADDON_PLAYER			= PLAYER
XPERL_CONF_ADDON_PLAYER_DESC		= "启用X-Perl玩家模块"
XPERL_CONF_ADDON_PET			= PET
XPERL_CONF_ADDON_PET_DESC		= "启用X-Perl玩家宠物模块"
XPERL_CONF_ADDON_TARGET			= TARGET
XPERL_CONF_ADDON_TARGET_DESC		= "启用X-Perl目标模块"
XPERL_CONF_ADDON_TARGETTARGET		= "目标的目标"
XPERL_CONF_ADDON_TARGETTARGET_DESC	= "启用X-Perl目标的目标模块"
XPERL_CONF_ADDON_PARTY			= PARTY
XPERL_CONF_ADDON_PARTY_DESC		= "启用X-Perl队伍模块"
XPERL_CONF_ADDON_PARTYPET		= "队友宠物"
XPERL_CONF_ADDON_PARTYPET_DESC		= "启用X-Perl队友宠物模块"
XPERL_CONF_ADDON_RAID			= RAID
XPERL_CONF_ADDON_RAID_DESC		= "启用X-Perl团队模块"
XPERL_CONF_ADDON_RAIDHELP		= "团队助手"
XPERL_CONF_ADDON_RAIDHELP_DESC		= "启用X-Perl团队助手模块"
XPERL_CONF_ADDON_RAIDADMIN		= "团队管理"
XPERL_CONF_ADDON_RAIDADMIN_DESC		= "启用X-Perl团队管理模块"

XPERL_CONF_RELOADUI			= "重载插件"
XPERL_CONF_RELOADUI_DESC		= "重载用户界面使设置生效"

end
