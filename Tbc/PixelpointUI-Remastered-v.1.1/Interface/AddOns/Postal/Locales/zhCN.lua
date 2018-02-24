if GetLocale() ~= "zhCN" then return end

local L = AceLibrary("AceLocale-2.2"):new("Postal")

L:RegisterTranslations("zhCN", function() return {
-- main
	["Module Options"] = "模块选项",
	["Opening Speed"] = "收信速度",
	["The time in seconds between opening each mail/item/money. Setting this to a very fast speed may disconnect you while opening mail."] = "批量打开邮件/物品/金钱之间的时间间隔，如收取邮件时设置速度过快可能造成与服务器断开连接。",
-- blackbook
	["BlackBook"] = "黑皮书",
	["A Black Book to write down your addresses."] = "记录地址的黑皮书。",
	["Contacts"] = "联系人",
	["Friends"] = "好友",
	["Guild"] = "公会",
	["Add Contact"] = "添加联系人",
	["Remove Contact"] = "删除联系人",
	["Part %d"] = "第 %d 组",
--dejavu
	["DejaVu"] = "自动填充",
	["Autofills the last recipient in the To: field."] = "自动填入上一个收件人的名字。",
--express
	["Express"] = "快件",
	["Mouse click short cuts for mail."] = "鼠标快捷方式。",
	["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-点击|r 获得该邮件的内容副本。",
	["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-点击|r 将信退给发件人。",
	["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-点击|r 将该物品发送给%s。",
	
	["Express options"] = "快件选项",
	["Options for the Express module"] = "快件模块的选项",
	["Enable Alt-Click to send mail"] = "允许 Alt-点击 发送邮件",
	["If this option is on, Alt-Clicking an item in your bags will send it instantly to the player in the To: field"] = "如果这个选项被激活，Alt-点击 一个物品将会立刻被发送给收件人",
	["Auto-Send on Alt-Click"] = "Alt-点击 自动发送",
	["With this option on, Postal will mail an item as soon as it is attached if there is a recipient filled in."] = "如果选中这个选项，邮件助手会在物品被附加至邮件时直接发送给收件人。",
	["Mousewheel to scroll Inbox"] = "鼠标滚动收件箱",
	["Scroll Inbox pages using the Mousewheel."] = "使用鼠标滚动收件箱页面。",
--forward
	["Forward"] = "转发",
	["Forward a message. (Currently Broken)"] = "转发信息（当前不可用）",
	["FW:"] = "转发:",
--openall
	["OpenAll"] = "打开所有",
	["A button that collects all attachments and coins from mail."] = "收取所有邮件的附件和金币。",
	["Open All"] = "打开所有",
	["Some Messages May Have Been Skipped."] = "部分邮件可能被忽略。",
	["In Progress"] = "处理中",
	["Insufficient Bag Space"] = "背包空间不足",
	["Processing Message"] = "正在处理邮件",
	
	["OpenAll options"] = "打开所有选项",
	["Options for the OpenAll module"] = "打开所有模块的选项",
	["AH-related mail"] = "拍卖相关邮件",
	["Options for AH-related mail"] = "拍卖相关邮件的选项",
	["Open all Auction cancelled mail"] = "打开所有取消拍卖的邮件",
	["If this option is off, Postal will skip opening Auction cancelled mails"] = "如果这个选项被关闭，邮件助手将会跳过取消拍卖的邮件",
	["Open all Auction expired mail"] = "打开所有拍卖过期的邮件",
	["If this option is off, Postal will skip opening Auction expired mails"] = "如果这个选项被关闭，邮件助手将会跳过拍卖过期的邮件",
	["Open all Outbid on mail"] = "打开所有超过出价的邮件",
	["If this option is off, Postal will skip opening Outbid on mails"] = "如果这个选项被关闭，邮件助手将会跳过超过出价的邮件",
	["Open all Sale Pending mail"] = "打开所有等待收款的邮件",
	["If this option is off, Postal will skip opening Sale Pending mails"] = "如果这个选项被关闭，邮件助手将会跳过等待收款的邮件",
	["Open all Auction successful mail"] = "打开所有拍卖成功的邮件",
	["If this option is off, Postal will skip opening Auction successful mails"] = "如果这个选项被关闭，邮件助手将会跳过拍卖成功的邮件",
	["Open all Auction won mail"] = "打开所有赢得拍卖的邮件",
	["If this option is off, Postal will skip opening Auction won mails"] = "如果这个选项被关闭，邮件助手将会跳过赢得拍卖的邮件",
	["Non-AH related mail"] = "非拍卖相关邮件",
	["Options for non-AH related mail"] = "非拍卖相关邮件的选项",
	["Open all mail with attachments"] = "打开所有带有附件的邮件",
	["If this option is off, Postal will skip opening mails from players that has attachments"] = "如果这个选项被关闭，邮件助手将会跳过来自其他玩家，带有附件的邮件",
	["Other options"] = "其他选项",
	["Verbose mode"] = "消息模式",
	["If this option is on, Postal will spam the chat with messages while opening mail"] = "如果打开这个选项，邮件助手将会在聊天窗口中发送打开邮件的信息",
--rake
	["Rake"] = "收款显示",
	["Prints the amount of money collect during a mail session."] = "显示在一次邮件操作中所收到的金币。",
	["Collected"] = "已收取",
--select
	["Select"] = "选择",
	["Add check boxes to the inbox for multiple mail operations."] = "增加可选框以便于对多个邮件进行操作",
	["Open"] = "打开",
	["Return"] = "退信",
	["COD"] = "付费邮件",
	["Skipping"] = "忽略",

	["Select options"] = "选择选项",
	["Options for the Select module"] = "选择模块的选项",
--tradeblock
	["TradeBlock"] = "阻止交易",
	["Block incoming trade requests while in a mail session."] = "在进行邮件操作中阻止交易请求。",
--wire
	["Wire"] = "填充标题",
	["Set subject field to value of coins sent if subject is blank."] = "在主题为空时将主题自动填充为金币数量。",
	["^%[%d+g %d+s %d+c%]$"] = "^%[%d+金 %d+银 %d+铜%]$",
	["^%[%d+s %d+c%]$"] = "^%[%d+银 %d+铜%]$",
	["^%[%d+c%]$"] = "^%[%d+铜%]$",
} end)
