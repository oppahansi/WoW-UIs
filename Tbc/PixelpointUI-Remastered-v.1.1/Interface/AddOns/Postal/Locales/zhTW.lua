if GetLocale() ~= "zhTW" then return end

local L = AceLibrary("AceLocale-2.2"):new("Postal")

L:RegisterTranslations("zhTW", function() return {
-- main
	["Module Options"] = "模組選項",
	["Opening Speed"] = "收取速度",
	["The time in seconds between opening each mail/item/money. Setting this to a very fast speed may disconnect you while opening mail."] = "收取信件/物品/金錢的時間間隔，收取信件時設定過快的速度可能導致斷線。",
-- blackbook
	["BlackBook"] = "聯絡人名冊",
	["A Black Book to write down your addresses."] = "記錄聯絡人名稱。",
	["Contacts"] = "聯絡人",
	["Friends"] = "好友",
	["Guild"] = "公會",
	["Add Contact"] = "新增聯絡人",
	["Remove Contact"] = "移除聯絡人",
	["Part %d"] = "分組%d",
--dejavu
	["DejaVu"] = "自動填寫",
	["Autofills the last recipient in the To: field."] = "在「收件人:」欄位自動填寫上次的收件人名稱。",
--express
	["Express"] = "快速收發",
	["Mouse click short cuts for mail."] = "點擊快速收發信件。",
	["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-點擊: |r收取信件。",
	["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-點擊: |r返回信件。",
	["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-點擊: |r將物品寄給%s。",
	
	["Express options"] = "快速收發選項",
	["Options for the Express module"] = "快速收發模組的選項",
	["Enable Alt-Click to send mail"] = "開啟Alt-點選 發送信件",
	["If this option is on, Alt-Clicking an item in your bags will send it instantly to the player in the To: field"] = "如果這個選項被開啟，Alt-點選 一個物品將會被發送至收件人",
	["Auto-Send on Alt-Click"] = "Alt-點選 自動發送",
	["With this option on, Postal will mail an item as soon as it is attached if there is a recipient filled in."] = "如果選取這個選項，Postal會在物品被附加至信件時發送给收件人。",
	["Mousewheel to scroll Inbox"] = "滑鼠滾動收件欄",
	["Scroll Inbox pages using the Mousewheel."] = "使用滑鼠滾動收件欄頁面",
--forward
	["Forward"] = "轉寄",
	["Forward a message. (Currently Broken)"] = "轉寄信件。 (現在失效)",
	["FW:"] = "轉寄:",
--openall
	["OpenAll"] = "收取全部",
	["A button that collects all attachments and coins from mail."] = "一個收取全部附件及金錢的按鈕。",
	["Open All"] = "收取全部",
	["Some Messages May Have Been Skipped."] = "部份訊息可能會被略過。",
	["In Progress"] = "正在處理",
	["Insufficient Bag Space"] = "背包空間不足",
	["Processing Message"] = "正在處理訊息",
	
	["OpenAll options"] = "打開所有選項",
	["Options for the OpenAll module"] = "打開所有模組的選項",
	["AH-related mail"] = "拍賣相關信件",
	["Options for AH-related mail"] = "拍賣相關信件的選項",
	["Open all Auction cancelled mail"] = "打開所有取消拍賣的信件",
	["If this option is off, Postal will skip opening Auction cancelled mails"] = "如果這個選項被關閉，Postal將會跳過取消拍賣的信件",
	["Open all Auction expired mail"] = "打開所有拍賣過期的信件",
	["If this option is off, Postal will skip opening Auction expired mails"] = "如果這個選項被關閉，Postal將會跳過拍賣過期的信件",
	["Open all Outbid on mail"] = "打開所有超過出價的信件",
	["If this option is off, Postal will skip opening Outbid on mails"] = "如果這個選項被關閉，Postal將會跳過超過出價的信件",
	["Open all Sale Pending mail"] = "打開所有等待收款的信件",
	["If this option is off, Postal will skip opening Sale Pending mails"] = "如果這個選項被關閉，Postal將會跳過等待收款的信件",
	["Open all Auction successful mail"] = "打開所有拍賣成功的信件",
	["If this option is off, Postal will skip opening Auction successful mails"] = "如果這個選項被關閉，Postal將會跳過拍賣成功的信件",
	["Open all Auction won mail"] = "打開所有赢得拍賣的信件",
	["If this option is off, Postal will skip opening Auction won mails"] = "如果這個選項被關閉，Postal將會跳過赢得拍賣的信件",
	["Non-AH related mail"] = "非拍賣相關信件",
	["Options for non-AH related mail"] = "非拍賣相關信件的選項",
	["Open all mail with attachments"] = "打開所有帶有附件的信件",
	["If this option is off, Postal will skip opening mails from players that has attachments"] = "如果這個選項被關閉，Postal將會跳過来自其他玩家，帶有附件的信件",
	["Other options"] = "其他選項",
	["Verbose mode"] = "消息模式",
	["If this option is on, Postal will spam the chat with messages while opening mail"] = "如果打開這個選項，Postal將會在聊天視窗中顯示打開信件的訊息",
--rake
	["Rake"] = "報告",
	["Prints the amount of money collect during a mail session."] = "列印這次收取的金錢。",
	["Collected"] = "領取",
--select
	["Select"] = "選擇",
	["Add check boxes to the inbox for multiple mail operations."] = "增加鉤選框以供多重信件指令使用。",
	["Open"] = "開啟",
	["Return"] = "返回",
	["COD"] = "貨到付款",
	["Skipping"] = "略過",
	
	["Select options"] = "選擇選項",
	["Options for the Select module"] = "選擇模組的選項",
--tradeblock
	["TradeBlock"] = "攔阻交易",
	["Block incoming trade requests while in a mail session."] = "在處理信件期間攔阻交易要求。",
--wire
	["Wire"] = "自動填寫金額",
	["Set subject field to value of coins sent if subject is blank."] = "在「主題:」欄位自動填寫寄件金額。",
	["^%[%d+g %d+s %d+c%]$"] = "^%[%d+金 %d+銀 %d+銅%]$",
	["^%[%d+s %d+c%]$"] = "^%[%d+銀 %d+銅%]$",
	["^%[%d+c%]$"] = "^%[%d+銅%]$",
} end)
