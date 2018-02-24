-- Translated by wowui.cn

if( GetLocale() ~= "zhTW" ) then
	return
end

AfflictedLocals = setmetatable({

	["ALT + Drag to move the frame anchor."] = "ALT + 拖動 來移動框體錨點.",
	["Reset Afflicted configuration as you were using Afflicted2."] = "重置Afflicted配置當妳已使用過Afflicted2.",
	["Interrupted %s"] = "打斷 %s",
	["Interrupted %s's %s"] = "打斷 %s的 %s",
	["FAILED %s's %s"] = "失敗 %s的 %s",
	["Removed %s"] = "移除 %s",
	["Removed %s's %s"] = "移除 %s的 %s",

	-- Cmd
	["Slash commands"] = "Afflicted命令行",
	["- clear - Clears all running timers."] = "- clear - 清除所有運行的計時條.",
	["- ui - Opens the configuration for Afflicted."] = "- ui - 打開Afflicted的配置.",
	["- test - Shows test timers in Afflicted."] = "- test - 顯示Afflicted測試計時條.",
	
	-- GUI
	["General"] = "壹般選項",
	
	["None"] = "無",
	["Combat text"] = "戰鬥文本",
	["Party"] = "小隊",
	["Raid"] = "團隊",
	["Raid warning"] = "團隊警報",
	["Middle of screen"] = "屏幕中間",
	["Chat frame #%d"] = "聊天框 #%d",

	["Everywhere else"] = "任何地方",
	["Battlegrounds"] = "戰場",
	["Arenas"] = "競技場",
	["Raid instances"] = "團隊副本",
	["Party instances"] = "小隊副本",
	
	["Enable inside"] = "在這些情況下啟用",
	
	["Bars"] = "計時條",
	["Icons"] = "圖標",
	
	["Display"] = "顯示選項",
	
	["Font name"] = "字體名字",
	["Font size"] = "字體大小",
	["Texture"] = "材質",
	["Width"] = "寬",
	["Only timers of people you have targeted, or focused will be triggered. They will not be removed if you change targets however."] = "僅有妳的已設為目標或焦點的人物將觸發計時條.計時條不會因妳改變目標而被移除.",
	["Only show target/focus timers"] = "僅顯示目標/焦點的計時條",
	["Only show triggered name in text"] = "僅顯示觸發的名字文本",
	["Bar only"] = "僅顯示計時條",
	["Show timer anchors"] = "顯示計時條錨點",
	["Show the anchors that lets you drag timer groups around."] = "顯示可以拖動計時條分組的錨點.",
	["Global display setting, changing these will change all the anchors settings.\nNOTE: These values do not reflect each anchors configuration, this is just a quick way to set all of them to the same thing."] = "全局顯示設置, 更改這些設置將影響到所有錨點的設置.\n註意: 這些選項值不代表是每個錨點的真實配置, 這僅是壹個快捷的方式來設置每個錨點為統壹的選項值.",
	["Grow up"] = "向上增長",
	["Instead of adding everything from top to bottom, timers will be shown from bottom to top."] = "計時條的顯示將從下到上增長而不是從上到下.",
	["Display style"] = "顯示樣式",
	["Scale"] = "縮放",
	["How big the actual timers should be."] = "設置計時條的大小.",
	["Max timers"] = "最大計時條數量",
	["Maximum amount of timers that should be ran per an anchor at the same time, if too many are running at the same time then the new ones will simply be hidden until older ones are removed."] = "每個錨點在同壹時間顯示的最大計時條數量, 如果同壹時間有太多的計時條運行,那麽新的計時條將被隱藏直到之前的計時條被移除.",
	["Configuration that only applies to bar displays."] = "僅用來計時條顯示的配置.",
	["Instead of showing both the spell name and the triggered name, only the name will be shown in the bar."] = "僅在計時條內顯示名字而不是法術名字和觸發者的名字.",
	
	["Spells"] = "法術選項",
	["Spell categories"] = "法術分類",
	["Search spells"] = "搜索法術",
	
	["All"] = "所有",
	
	["Duration disabled"] = "持續時間已禁用",
	["Duration: %d (%s)"] = "持續時間: %d (%s)",
	["Cooldown disabled"] = "冷卻已禁用",
	["Cooldown: %d (%s)"] = "冷卻: %d (%s)",
	
	["Disable duration"] = "禁用持續時間",
	["Duration"] = "持續時間",
	
	["Disable cooldown"] = "禁用冷卻",
	["Cooldown"] = "冷卻",
	["Spell cooldown"] = "法術冷卻",
	["Anchor"] = "錨點",
	["Spell timer"] = "法術計時器",
	["Spell data"] = "法術數據庫",
	["Type"] = "類型",
	["Spell type, buffs are things that the player actually gains, casts are anything thats an instant cast spell, summoned objects are things such as totems, and created objects are traps."] = "法術類型, 增益效果為玩家獲得的Buff, 可施法的為壹個可立即施放的法術, 召喚的物體為類似於圖騰等, 制造的物體為類似於陷阱等.",
	["Casts"] = "可施法的",
	["Summoned objects"] = "召喚的物體",
	["Created objects"] = "制造的物體",
	["Buffs"] = "增益效果",
	["Class from"] = "按職業",
	["The class that actually casts this spell, used for categorization."] = "施放這個法術的職業,用做分類.",
	["Cooldown anchor"] = "冷卻錨點",
	["Spells linked to this one"] = "法術鏈接到這個",
	["Spells that are specifically linked to this one by a spell id. This is basically lower ranked spells, and you only need to set this if you're adding by spell id... and even then you don't really have to."] = "特定的按法術ID鏈接到這壹個的法術. 這個基本上是較低等級的法術, 並僅在妳按法術ID增加時需要設置這個... and 並且盡管妳不是真的必須那麽做.",
	["Advanced configuration linked to more internal functions.\nValues are separated by commas.\nDO NOT edit these if you do not know what you are doing, you do not have to touch them 99% of the time."] = "鏈接到更多內置函數的高級配置.\n數值用逗號分開.\n如果妳不知道妳在做什麽請不要編輯這些參數值, 妳有99%的時間不要接觸到他們.",
	["Reset when this is used"] = "當這個已被使用時重置",
	["Spells that should have there cooldown reset when this one is used, think Preparation or Iceblock."] = "當這壹個法術已用時必須重置冷卻的法術, 預先想好或者凍結.",
	["Advanced"] = "高級",
	["Delete"] = "刪除",
	["Spells that were added manually will be deleted, however spells that are added by default are simply reset next update."] = "手動增加的法術將被刪除, 默認增加的法術將在下次刷新時重置.",
	["Are you REALLY sure you want to delete this spell?"] = "妳真的想刪除這個法術嗎?",
	["Add new spell by name or spell id"] = "增加壹個新的法術,按名字或者法術ID.",
	["A spell with that name already exists."] = "這個名字的法術已經存在.",
	["No spell name entered."] = "沒有輸入法術名字.",
	["Add a new spell to Afflicted, you can add it either by the spell name or spell id. However, if you add it by spell name then you must match the casing Blizzard uses as it is case sensitive."] = "增加壹個新的法術到Afflicted, 妳可以按照法術名字或者法術ID來增加. 如果妳按照法術名字來添加,妳必須精確匹配.",
	["New spell"] = "新的法術",
	["New anchor"] = "新的錨點",
	["Anchors"] = "錨點",
	["Add a new anchor to Afflicted that timers can be displayed in."] = "增加壹個新的錨點到Afflicted來顯示計時器.",
	["Anchor name"] = "錨點名字",
	["No anchor name entered."] = "沒有輸入錨點名字.",
	["An anchor with that name already exists."] = "錨點名字已存在.",

	["Announcement text for when timers are triggered in this anchor. You can use *spell for the spell name, and *target for the person who triggered it (if any)."] = "當這個錨點下的計時器被觸發時的通報文本. 妳可以使用 *spell 參數來調用法術名字, 使用 *target 參數來調用誰觸發了這個計時器 (如果有的話).",
	["Announce text"] = "通報文本",
	["Destination"] = "通報到",
	["Text color"] = "文本顏色",
	["Announcements"] = "通報",
	["Group name to redirect bars to, this lets you show Afflicted timers under another addons bar group. Requires the bars to be created using GTB, and the bar display to be enabled for this anchor."] = "重定向計時條到的分組名字, 這個可以讓妳在其他插件的計時條分組下顯示Afflicted計時器. 需要這些計時條是使用GTB創建的, 並且在這個錨點下計時條顯示已被啟用.",
	["Redirection"] = "重定向",
	["Fade time"] = "淡出時間",
	["How many seconds it should take after a bar is finished for it to fade out."] = "壹個計時條結束後的淡出秒數.",
	["Scale"] = "縮放",
	["Icon position"] = "圖標位置",
	["Display type"] = "顯示類型",
	["Enable anchor"] = "啟用錨點",
	["Allows timers to be shown under this anchor, if the anchor is disabled you won't see any timers."] = "允許計時器顯示在這個錨點下, 如果這個錨點被禁用妳將看不到任何計時器.",
	["Display"] = "顯示",
	["Grow up"] = "向上增長",
	["Instead of adding everything from top to bottom, timers will be shown from bottom to top."] = "計時條的顯示將從下到上增長而不是從上到下.",
	["Max timers"] = "最大計時條數量",
	["Maximum amount of timers that should be ran per an anchor at the same time, if too many are running at the same time then the new ones will simply be hidden until older ones are removed."] = "每個錨點在同壹時間顯示的最大計時條數量, 如果同壹時間有太多的計時條運行,那麽新的計時條將被隱藏直到之前的計時條被移除.",
	["Redirect bars to group"] = "重定向計時條到分組",
	["Enable announcements"] = "啟用通報",
	["Alert text color, only applies to local outputs."] = "警報文本的顏色, 僅用來本地輸出.",
	["Start message"] = "計時開始的信息",
	["Message to show when a timer is started in this anchor."] = "當這個錨點下的計時器開始計時時的信息.",
	["Ended message"] = "計時結束的信息",
	["Message to show when a timer ends inside this anchor."] = "當這個錨點下的計時器結束計時時的信息.",
	["Left"] = "左",
	["Right"] = "右",
	["Anchors that were added manually will be deleted, default anchors will be reset to default settings if you delete them. Disable default anchors to stop timers from showing."] = "手動增加的錨點將被刪除, 默認的錨點將被重置為默認設置如果妳刪除他們的話. 禁用默認錨點來阻止計時條的顯示.",
	["Are you REALLY sure you want to delete this anchor?"] = "妳真的想刪除這個錨點?",
	["Move spells in this anchor to"] = "移動這個錨點裏的法術到",
	["You have to choose which anchor spells should be moved to when this one is deleted."] = "當這個錨點被刪除後妳必須選擇壹個法術要移動到的錨點.",
	
	["Arena spells"] = "競技場法術",
	["2 vs 2"] = "2 vs 2",
	["3 vs 3"] = "3 vs 3",
	["5 vs 5"] = "5 vs 5",
	["Spells that should be enabled inside a specific arena bracket."] = "需要在不同競技場啟用的法術.",

	["Announcements"] = "通報",
	["Color"] = "顏色",
	["Dispel announcements"] = "驅散通報",
	["Interrupt announcements"] = "打斷通報",

	-- Class localization
	["classes"] = {
		["DEATHKNIGHT"] = "死亡騎士",
		["WARRIOR"] = "戰士",
		["SHAMAN"] = "薩滿",
		["MAGE"] = "法師",
		["PRIEST"] = "牧師",
		["WARLOCK"] = "術士",
		["ROGUE"] = "盜賊",
		["DRUID"] = "德魯伊",
		["HUNTER"] = "獵人",
		["PALADIN"] = "聖騎士",
	},

	-- New strings
	["Show icons in alerts"] = "在警報中顯示圖示",
	["Any announcement into a local channel, will show the icon of the spell that was announced."] = "任何通報到本地頻道的警報, 都將顯示警報法術的圖示.",
	["Help"] = "幫助",
	["Settings for all anchors can be changed below, if you want to set specific settings for each anchor you will need to do it in the anchor menu on the top left."] = "所有錨點的設置都可以通過下面的選項來改變, 如果你想要為每個錨點進行特定的設置,你需要在左邊的錨點菜單中設置.",
	["You cannot delete a spell that is included with Afflicted by default, you will need to disable it if you don't want to use it."] = "你不能刪除一個Afflicted默認內置的法術, 如果你不想要到它請將它禁用.",
	["You can manually set slider values by clicking the number in the middle below the slider bar."] = "你可以通過點擊滑動條下的數字來手動設置數值.",
	["Click the number between the 0 and 900 to set the time to a specific number of seconds."] = "點擊從0到900的數字來設置特定的時間.",
	["You cannot delete anchors that are included with Afflicted by default, you will need to disable it if you don't want to use the anchor."] = "你不能刪除一個Afflicted默認內置的錨點, 如果你不想要到它請將它禁用.",
	["Stole %s"] = "竊取 %s",
	["Stole %s's %s"] = "竊取 %s的 %s",

}, {__index = AfflictedLocals})