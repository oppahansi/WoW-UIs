local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

L:RegisterTranslations("zhCN", function() return {
	-- Core.lua
	["Console-Slash-Commands"] = { "/cdp" },
	["GUI-Slash-Commands"] = { "/gp", "/ghostpulse" },
	
	["Ghost: Pulse 2"] = "Ghost: Pulse 2",
	["Pulses stuff on-screen."] = "一些有用的东西的弹出提示",
	["You will need to reload the interface to reflect this change."] = "你需要重载界面来使改变生效",
	
	["Locked"] = "锁定",
	["Locks frames in place so they can't be moved around."] = "锁定框体使其无法被移动",
	
	["Allow Shared Frames"] = "允许共享框体",
	["Remove Shared Frames"] = "删除共享框体",
	
	["Use Shared Media"] = "使用SharedMedia",
	
	["Frames"] = "框体",
	["Create and configure frames to show alerts."] = "创建和设置警示框体",
	
	["Skinning"] = "皮肤",
	["Texture"] = "材质",
	["<name of texture>"] = "材质名",
	["Alpha"] = "透明度",
	["Scale"] = "缩放",
	["Default"] = "默认",
	
	["Reset to Defaults"] = "重置为默认",
	
	["<name of thing>"] = "<名称>",
	["<template>"] = "<模板>",
	
	["Add"] = "添加",
	["Enter a name for the new frame."] = "输入新框体的名称",
	["<name of frame>"] = "<框体名称>",
	
	["Alerts"] = "警报",
	["Contains the options for the different alerts you can set up."] = "各种警报信息的设置",
	["In-Combat Only"] = "仅在战斗中使用",
	["While Mounted"] = "坐骑上启用",
	["While Solo"] = "单人时启用",
	["While Dead"] = "死亡时启用",
	["In Party"] = "小队中时启用",
	["In Raid"] = "团队中时启用",
	
	["Minimum Cooldown Time"] = "冷却最小时间",
	["Maximum Cooldown Time"] = "冷却最大时间",
	["Highlight Color"] = "高亮颜色",
	["Show Early Warnings"] = "显示提前预警",
	["Early Warning Time"] = "提前预警时间",
	["Early Warning Color"] = "提前预警颜色",
	["Early Warning Text"] = "提前预警文字",
	["Alert Text"] = "提示文字",
	
	["Early Warning Sound"] = "提前预警声音",
	["Announce Alerts to Group"] = "向小队发送预警",
	["Announce Warnings to Group"] = "想小队发送警报",	
	["Early Warning Method"] = "提前预警方式",
	["<method>"] = "<方法名>",
	["Floating Combat Text"] = "浮动战斗文字",
	["UIErrorsFrame"] = "UI错误框体",
	["MSBT"] = "MSBT框体",
	
	["None"] = "无",
	
	["Specifics"] = "特殊事件",
	["Contains options for configuring specific things."] = "特殊事件的设置",
	["Enter the name of the thing you want specific settings for."] = "输入你想要使用的特殊事件名",
	["Sound"] = "声音",
	["<name of sound>"] = "<声音名>",
	["Limit"] = "限制",
	["Enter a numeric limit for %s"] = "输入%s的最大值",
	["<limit>"] = "<值>",
	
	["'%s' added to the whitelist for alert '%s'."] = "%s被加入%s的白名单",
	["'%s' removed from the whitelist for alert '%s'."] = "%s被从%s的白名单中移除",
	["Showing the whitelist for alert '%s'..."] = "显示%s警报的白名单",
	["Whitelist cleared for alert '%s'."] = "%s警报的白名单被清除",

	["'%s' added to the blacklist for alert '%s'."] = "%s被加入%s的黑名单",
	["'%s' removed from the blacklist for alert '%s'."] = "%s被从%s的黑名单中移除",
	["Showing the blacklist for alert '%s'..."] = "显示%s警报的黑名单",
	["Blacklist cleared for alert '%s'."] = "%s警报的黑名单被清除",

	["Options for %s"] = "%s设置",
	["Keep"] = "保持",
	["Share Frame with Group"] = "和小队成员共享框体设置",
	
	["Size"] = "大小",
	["Show Text"] = "显示文字",
	["Font Scale"] = "字体缩放",

	["Fade-in Time"] = "淡入时间",
	["Hold Time"] = "保持时间",
	["Fade-out Time"] = "淡出时间",
	
	["Override Sound"] = "全局声音",
	["If specified, this sound will play for all alerts shown in this frame instead of the alert-specific sound.  The general 'Sounds' options can override this, however."] = "设置后所有的警报都会使用这一声音而非各个警报自身设定的声音，不过综合的声音设置高于这个选项。",

	["Whitelist"] = "白名单",
	["'%s' added to the whitelist for frame '%s'."] = "%s被加入%s框体的白名单",
	["'%s' removed from the whitelist for frame '%s'."] = "%s被从%s框体的白名单中移除",
	["List"] = "列出",
	["Showing the whitelist for frame '%s'..."] = "显示%s框体的白名单",
	["*** Empty ***"] = "***空***",
	["Clear"] = "清空",
	["Whitelist cleared for frame '%s'."] = "%s框体的白名单被清除",
	
	["Blacklist"] = "黑名单",
	["'%s' added to the blacklist for frame '%s'."] = "%s被加入%s框体的黑名单",
	["'%s' removed from the blacklist for frame '%s'."] = "%s被从%s框体的黑名单中移除",
	["Showing the blacklist for frame '%s'..."] = "显示%s框体的黑名单",
	["Blacklist cleared for frame '%s'."] = "%s框体的黑名单被清除",

	["Remove"] = "删除",
	["Removes the frame."] = "删除该框体",

	-- Engine.lua
	["[Name] is ready soon"] = "[Name]即将冷却结束",
	
	-- Events.lua
	["%s shared a frame with you."] = "%s向你共享了一个框体",
	["%s tried to share a frame with you, but you are not allowing shared frames."] = "%s向你共享了一个框体，但是你并没有开启共享框体显示",
	
	-- AuraWatcher.lua
	["Player Buff Gains"] = "玩家获得buff",
	["Player Buff Fades"] = "玩家buff消失",
	["Player Debuff Gains"] = "玩家获得debuff",
	["Player Debuff Fades"] = "玩家debuff消失",
	
	-- BagsWatcher.lua
	["Bag Item Cooldowns"] = "背包内物品冷却",
	
	-- CCExpiryWatcher.lua
	["CC Expiry (Target)"] = "目标控场效果消失",
	["CC Expiry (Focus)"] = "焦点控场效果消失",

	-- DecurseWatcher.lua
	["Decurse - Magic"] = "解除 - 魔法",
	["Decurse - Curse"] = "解除 - 诅咒",
	["Decurse - Poison"] = "解除 - 毒药",
	["Decurse - Disease"] = "解除 - 疾病",
	
	-- EnemyCastWatcher.lua
	["Enemy Spell Casts (Target)"] = "敌对施法（目标）",
	["Enemy Spell Casts (Focus)"] = "敌对施法（焦点）",
	["Enemy Spell Casts (Bosses)"] = "敌对施法（首领）",
	
	-- LifeTapWatcher.lua
	["Bottled Nethergon Energy"] = "虚空精华能量饮料",
	["The Mechanar"] = "能源舰",
	["The Botanica"] = "生态船",
	["The Arcatraz"] = "禁魔监狱",
	["Tempest Keep"] = "风暴要塞",	
	
	["Cenarion Mana Salve"] = "塞纳里奥法力药膏",
	["The Steamvault"] = "蒸汽地窟",
	["The Slave Pens"] = "奴隶围栏",
	["Serpentshrine Cavern"] = "毒蛇神殿",
	["The Underbog"] = "幽暗沼泽",
	
	["Mana Potion Injector"] = "法力药水注射器",
	["Super Mana Potion"] = "超级法力药水",
	["Mana Emerald"] = "法力刚玉",
	
	["Life Tap/Dark Pact"] = "生命分流/黑暗契约",
	["Mana Potions/Gems"] = "法力药水/宝石",
	["Imp"] = "小鬼",
	["Dark Pact"] = "黑暗契约",
	["Life Tap"] = "生命分流",
	
	-- MobDebuffWatcher.lua
	["Crowd Control (Target)"] = "控场效果（目标）",
	["Crowd Control (Focus)"] = "控场效果（焦点）",
	["Mob Debuffs (Target)"] = "怪物debuff（目标）",
	["Mob Debuffs (Focus)"] = "怪物debuff（焦点）",
	
	["Hibernate"] = "休眠",
	["Cyclone"] = "	飓风术",
	["Polymorph"] = "变形术",	
	["Seduction"] = "诱惑",
	["Enslave Demon"] = "奴役恶魔",
	["Howl of Terror"] = "恐惧嚎叫",
	["Banish"] = "放逐术",
	["Fear"] = "恐惧",
	["Death Coil"] = "死亡缠绕",
	["Turn Evil"] = "超度邪恶",
	["Freezing Trap"] = "冰冻陷阱效果",
	["Scatter Shot"] = "驱散射击",
	["Scare Beast"] = "恐吓野兽",
	["Sap"] = "闷棍",
	["Blind"] = "致盲",
	["Shackle Undead"] = "束缚亡灵",
	["Mind Control"] = "心灵控制",	

	-- ParryWatcher.lua
	["Riposte"] = "还击",
	["Overpower (Target)"] = "压制（目标）",
	["Overpower (Focus)"] = "压制（焦点）",
	-- PetWatcher.lua
	["Pet Spell Cooldowns"] = "宠物技能冷却",
	
	-- PlayerDeathWatcher.lua
	["Player Deaths"] = "玩家死亡",
	["Player Resurrections"] = "玩家复活",
	
	-- SpellWatcher.lua
	["Player Spell Cooldowns"] = "玩家技能冷却",
	["Player Spell Casts"] = "玩家施法",
	["Player Spell Resists"] = "玩家法术被抵抗",
	["Player Spell Immunity"] = "玩家法术被免疫",
	
	-- ThreatGenWatcher.lua
	["Threat Resists (Target)"] = "仇恨变化技能抵抗（目标）",
	["Threat Resists (Focus)"] = "仇恨变化技能抵抗（焦点）",
	
	-- TrinkerWatcher.lua
	["Trinket Cooldowns"] = "饰品冷却",
	
} end)
