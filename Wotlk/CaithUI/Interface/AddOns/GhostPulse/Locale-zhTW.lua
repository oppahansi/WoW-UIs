local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

L:RegisterTranslations("zhTW", function() return {
	-- Core.lua
	["Console-Slash-Commands"] = { "/cdp" },
	["GUI-Slash-Commands"] = { "/gp", "/ghostpulse" },
	
	["Ghost: Pulse 2"] = "Ghost: Pulse 2",
	["Pulses stuff on-screen."] = "一些有用的東西的彈出提示",
	["You will need to reload the interface to reflect this change."] = "你需要重載介面來使改變生效",
	
	["Locked"] = "鎖定",
	["Locks frames in place so they can't be moved around."] = "鎖定框體使其無法被移動",
	
	["Allow Shared Frames"] = "允許共用框體",
	["Remove Shared Frames"] = "刪除共用框體",
	
	["Use Shared Media"] = "使用SharedMedia",
	
	["Frames"] = "框體",
	["Create and configure frames to show alerts."] = "創建和設置警示框體",
	
	["Skinning"] = "皮膚",
	["Texture"] = "材質",
	["<name of texture>"] = "材質名",
	["Alpha"] = "透明度",
	["Scale"] = "縮放",
	["Default"] = "默認",
	
	["Reset to Defaults"] = "重置為默認",
	
	["<name of thing>"] = "<名稱>",
	["<template>"] = "<範本>",
	
	["Add"] = "添加",
	["Enter a name for the new frame."] = "輸入新框體的名稱",
	["<name of frame>"] = "<框體名稱>",
	
	["Alerts"] = "警報",
	["Contains the options for the different alerts you can set up."] = "各種警報資訊的設置",
	["In-Combat Only"] = "僅在戰鬥中使用",
	["While Mounted"] = "坐騎上啟用",
	["While Solo"] = "單人時啟用",
	["While Dead"] = "死亡時啟用",
	["In Party"] = "小隊中時啟用",
	["In Raid"] = "團隊中時啟用",
	
	["Minimum Cooldown Time"] = "冷卻最小時間",
	["Maximum Cooldown Time"] = "冷卻最大時間",
	["Highlight Color"] = "高亮顏色",
	["Show Early Warnings"] = "顯示提前預警",
	["Early Warning Time"] = "提前預警時間",
	["Early Warning Color"] = "提前預警顏色",
	["Early Warning Text"] = "提前預警文字",
	["Alert Text"] = "提示文字",
	
	["Early Warning Sound"] = "提前預警聲音",
	["Announce Alerts to Group"] = "向小隊發送預警",
	["Announce Warnings to Group"] = "向小隊發送警報",	
	["Early Warning Method"] = "提前預警方式",
	["<method>"] = "<方式>",
	["Floating Combat Text"] = "浮動戰斗文字",
	["UIErrorsFrame"] = "UI錯誤框體",
	["MSBT"] = "MSBT",
	
	["None"] = "無",
	
	["Specifics"] = "特殊事件",
	["Contains options for configuring specific things."] = "特殊事件的設置",
	["Enter the name of the thing you want specific settings for."] = "輸入你想要使用的特殊事件名",
	["Sound"] = "聲音",
	["<name of sound>"] = "<聲音名>",
	["Limit"] = "限制",
	["Enter a numeric limit for %s"] = "輸入%s的最大值",
	["<limit>"] = "<值>",
	
	["'%s' added to the whitelist for alert '%s'."] = "%s被加入%s的白名單",
	["'%s' removed from the whitelist for alert '%s'."] = "%s被從%s的白名單中移除",
	["Showing the whitelist for alert '%s'..."] = "顯示%s警報的白名單",
	["Whitelist cleared for alert '%s'."] = "%s警報的白名單被清除",

	["'%s' added to the blacklist for alert '%s'."] = "%s被加入%s的黑名單",
	["'%s' removed from the blacklist for alert '%s'."] = "%s被從%s的黑名單中移除",
	["Showing the blacklist for alert '%s'..."] = "顯示%s警報的黑名單",
	["Blacklist cleared for alert '%s'."] = "%s警報的黑名單被清除",

	["Options for %s"] = "%s設置",
	["Keep"] = "保持",
	["Share Frame with Group"] = "和小隊成員共用框體設置",
	
	["Size"] = "大小",
	["Show Text"] = "顯示文字",
	["Font Scale"] = "字體縮放",

	["Fade-in Time"] = "淡入時間",
	["Hold Time"] = "保持時間",
	["Fade-out Time"] = "淡出時間",
	
	["Override Sound"] = "全域聲音",
	["If specified, this sound will play for all alerts shown in this frame instead of the alert-specific sound.  The general 'Sounds' options can override this, however."] = "設置後所有的警報都會使用這一聲音而非各個警報自身設定的聲音，不過綜合的聲音設置高於這個選項。",

	["Whitelist"] = "白名單",
	["'%s' added to the whitelist for frame '%s'."] = "%s被加入%s框體的白名單",
	["'%s' removed from the whitelist for frame '%s'."] = "%s被從%s框體的白名單中移除",
	["List"] = "列出",
	["Showing the whitelist for frame '%s'..."] = "顯示%s框體的白名單",
	["*** Empty ***"] = "***空***",
	["Clear"] = "清空",
	["Whitelist cleared for frame '%s'."] = "%s框體的白名單被清除",
	
	["Blacklist"] = "黑名單",
	["'%s' added to the blacklist for frame '%s'."] = "%s被加入%s框體的黑名單",
	["'%s' removed from the blacklist for frame '%s'."] = "%s被從%s框體的黑名單中移除",
	["Showing the blacklist for frame '%s'..."] = "顯示%s框體的黑名單",
	["Blacklist cleared for frame '%s'."] = "%s框體的黑名單被清除",

	["Remove"] = "刪除",
	["Removes the frame."] = "刪除該框體",

	-- Engine.lua
	["[Name] is ready soon"] = "[Name]即將冷卻結束",
	
	-- Events.lua
	["%s shared a frame with you."] = "%s向你共用了一個框體",
	["%s tried to share a frame with you, but you are not allowing shared frames."] = "%s向你共用了一個框體，但是你並沒有開啟共用框體顯示",
	
	-- AuraWatcher.lua
	["Player Buff Gains"] = "玩家獲得buff",
	["Player Buff Fades"] = "玩家buff消失",
	["Player Debuff Gains"] = "玩家獲得debuff",
	["Player Debuff Fades"] = "玩家debuff消失",
	
	-- BagsWatcher.lua
	["Bag Item Cooldowns"] = "背包內物品冷卻",
	
	-- CCExpiryWatcher.lua
	["CC Expiry (Target)"] = "目標控場效果消失",
	["CC Expiry (Focus)"] = "焦點控場效果消失",
	
	-- DecurseWatcher.lua
	["Decurse - Magic"] = "解除 - 魔法",
	["Decurse - Curse"] = "解除 - 詛咒",
	["Decurse - Poison"] = "解除 - 毒藥",
	["Decurse - Disease"] = "解除 - 疾病",
	
	-- EnemyCastWatcher.lua
	["Enemy Spell Casts (Target)"] = "敵對施法（目標）",
	["Enemy Spell Casts (Focus)"] = "敵對施法（焦點）",
	["Enemy Spell Casts (Bosses)"] = "敵對施法（首領）",
	
	-- LifeTapWatcher.lua
	["Bottled Nethergon Energy"] = "角瓶虛空能量劑",
	["The Mechanar"] = "麥克納爾",
	["The Botanica"] = "波塔尼卡",
	["The Arcatraz"] = "亞克崔茲",
	["Tempest Keep"] = "風暴要塞",	
	
	["Cenarion Mana Salve"] = "塞納里奧法力藥膏",
	["The Steamvault"] = "蒸汽洞窟",
	["The Slave Pens"] = "奴隸監獄",
	["Serpentshrine Cavern"] = "毒蛇神殿洞穴",
	["The Underbog"] = "深幽泥沼",
	
	["Mana Potion Injector"] = "法力藥水注射器",
	["Super Mana Potion"] = "超強效法力藥水",
	["Mana Emerald"] = "法力綠寶石",
	
	["Life Tap/Dark Pact"] = "生命分流/黑暗契約",
	["Mana Potions/Gems"] = "法力藥水/寶石",
	["Imp"] = "小鬼",
	["Dark Pact"] = "黑暗契約",
	["Life Tap"] = "生命分流",		
	
	-- MobDebuffWatcher.lua
	["Crowd Control (Target)"] = "控場效果（目標）",
	["Crowd Control (Focus)"] = "控場效果（焦點）",
	["Mob Debuffs (Target)"] = "怪物debuff（目標）",
	["Mob Debuffs (Focus)"] = "怪物debuff（焦點）",
	
	["Hibernate"] = "休眠",
	["Cyclone"] = "颶風術",
	["Polymorph"] = "變形術",	
	["Seduction"] = "誘惑",
	["Enslave Demon"] = "奴役惡魔",
	["Howl of Terror"] = "恐懼嚎叫",
	["Banish"] = "放逐術",
	["Fear"] = "恐懼術",
	["Death Coil"] = "死亡纏繞",
	["Turn Evil"] = "退邪術",
	["Freezing Trap"] = "冰凍陷阱效果",
	["Scatter Shot"] = "驅散射擊",
	["Scare Beast"] = "恐嚇野獸",
	["Sap"] = "悶棍",
	["Blind"] = "致盲",
	["Shackle Undead"] = "束縛不死生物",
	["Mind Control"] = "精神控制",

	-- ParryWatcher.lua
	["Riposte"] = "還擊",
	["Overpower (Target)"] = "壓制（目標）",
	["Overpower (Focus)"] = "壓制（焦點）",
	-- PetWatcher.lua
	["Pet Spell Cooldowns"] = "寵物技能冷卻",
	
	-- PlayerDeathWatcher.lua
	["Player Deaths"] = "玩家死亡",
	["Player Resurrections"] = "玩家復活",
	
	-- SpellWatcher.lua
	["Player Spell Cooldowns"] = "玩家技能冷卻",
	["Player Spell Casts"] = "玩家施法",
	["Player Spell Resists"] = "玩家法術被抵抗",
	["Player Spell Immunity"] = "玩家法術被免疫",
	
	-- ThreatGenWatcher.lua
	["Threat Resists (Target)"] = "仇恨變化技能抵抗（目標）",
	["Threat Resists (Focus)"] = "仇恨變化技能抵抗（焦點）",
	
	-- TrinkerWatcher.lua
	["Trinket Cooldowns"] = "飾品冷卻",
	
} end)
