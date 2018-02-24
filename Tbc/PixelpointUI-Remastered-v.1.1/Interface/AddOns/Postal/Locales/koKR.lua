if GetLocale() ~= "koKR" then return end

local L = AceLibrary("AceLocale-2.2"):new("Postal")

L:RegisterTranslations("koKR", function() return {
-- main
	["Module Options"] = "모듈 설정",
	["Opening Speed"] = "열기 속도",
	["The time in seconds between opening each mail/item/money. Setting this to a very fast speed may disconnect you while opening mail."] = "우편/아이템/금전 열 때의 속도를 설정합니다. 속도를 빠르게 하면 게임이 종료될 수 있습니다.",
-- blackbook
	["BlackBook"] = "주소록",
	["A Black Book to write down your addresses."] = "주소록(길드/친구 목록)에서 받을 사람 선택",
	["Contacts"] = "접속 목록",
	["Friends"] = "친구",
	["Guild"] = "길드",
	["Add Contact"] = "접속 목록에 추가",
	["Remove Contact"] = "접속 목록에서 제거",
	["Part %d"] = "부분 %d",
--dejavu
	["DejaVu"] = "자동 입력",
	["Autofills the last recipient in the To: field."] = "받는 사람 이름 자동 입력",
--express
	["Express"] = "빠른 우편",
	["Mouse click short cuts for mail."] = "마우스 클릭으로 빠른 우편 보내기",
	["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-Click|r 아이템 수취",
	["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-Click|r 아이템 반송",
	["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-Click|r %s님에게 아이템 보냄",
	
	["Express options"] = "빠른 우편 설정",
	["Options for the Express module"] = "빠른 우편을 위한 설정입니다.",
	["Enable Alt-Click to send mail"] = "Alt-클릭으로 우편 보내기",
	["If this option is on, Alt-Clicking an item in your bags will send it instantly to the player in the To: field"] = "이 설정을 사용하염 가방에 있는 아이템을 alt-클릭으로 쉽게 우편을 보낼 수 있습니다.",
	["Auto-Send on Alt-Click"] = "Alt+클릭으로 자동보내기",
	["With this option on, Postal will mail an item as soon as it is attached if there is a recipient filled in."] = "이 설정을 사용하면 아이템을 클릭하여 빠르게 우편을 보낼 수 있습니다.",
	["Mousewheel to scroll Inbox"] = "우편함 마우스 스크롤",
	["Scroll Inbox pages using the Mousewheel."] = "우편함 페이지를 마우스 스크롤로 전환할 수 있습니다.",
--forward
	["Forward"] = "전달",
	["Forward a message. (Currently Broken)"] = "편지를 다른 캐릭으로 바로 보내기 (현재 사용불가)",
	["FW:"] = "전달:",
--openall
	["OpenAll"] = "모두 열기",
	["A button that collects all attachments and coins from mail."] = "모든 편지의 우편물을 전부 받기",
	["Open All"] = "모두 열기",
	["Some Messages May Have Been Skipped."] = "몇몇의 메시지가 무시될 수 있습니다.",
	["In Progress"] = "처리중",
	["Insufficient Bag Space"] = "가방 공간 부족",
	["Processing Message"] = "메시지 처리중",
	
	["OpenAll options"] = "모두 열기 설정",
	["Options for the OpenAll module"] = "모두 열기 모듈을 위한 설정입니다.",
	["AH-related mail"] = "경매장 우편",
	["Options for AH-related mail"] = "경매장 우편에 관한 설정입니다.",
	["Open all Auction cancelled mail"] = "경매 취소 우편 모두 열기",
	["If this option is off, Postal will skip opening Auction cancelled mails"] = "설정을 끄면 경매가 취소된 우편을 열지 않습니다.",
	["Open all Auction expired mail"] = "기한만료 우편 모두 열기",
	["If this option is off, Postal will skip opening Auction expired mails"] = "설정을 끄면 기한 만료된 우편을 열지 않습니다.",
	["Open all Outbid on mail"] = "경매 만료 우편 모두 열기",
	["If this option is off, Postal will skip opening Outbid on mails"] = "설정을 끄면 경매가 만료된 우편을 열지 않습니다.",
	["Open all Sale Pending mail"] = "판매 보류중인 우편 모두 열기",
	["If this option is off, Postal will skip opening Sale Pending mails"] = "설정을 끄면 판매 보류중인 우편은 열지 않습니다.",
	["Open all Auction successful mail"] = "경매 판매 우편 모두 열기",
	["If this option is off, Postal will skip opening Auction successful mails"] = "설정을 끄면 경매로 판매된 우편을 열지 않습니다.",
	["Open all Auction won mail"] = "경매로 산 우편 모두 열기",
	["If this option is off, Postal will skip opening Auction won mails"] = "설정을 끄면 경매로 산 우편을 열지 않습니다.",
	["Non-AH related mail"] = "나머지 우편",
	["Options for non-AH related mail"] = "경매를 제외한 나머지 우편에 관한 설정입니다.",
	["Open all mail with attachments"] = "우편에 포함된 모든 것 열기",
	["If this option is off, Postal will skip opening mails from players that has attachments"] = "설정을 끄면 다른이에게서 온 우편을 열지 않습니다.",
	["Other options"] = "다른 설정",
	["Verbose mode"] = "대화창 메시지 표시",
	["If this option is on, Postal will spam the chat with messages while opening mail"] = "이 설정을 사용하면 우편을 열때 대화창에 메시지를 표시합니다.",
--rake
	["Rake"] = "우편 금액",
	["Prints the amount of money collect during a mail session."] = "우편함을 열고 있는동안의 총 사용/획득 금액 대화창에 출력",
	["Collected"] = "수집",
--select
	["Select"] = "우편 받기",
	["Add check boxes to the inbox for multiple mail operations."] = "동시에 우편을 여러 개 받을 수 있도록 체크박스 추가",
	["Open"] = "열기",
	["Return"] = "반송",
	["COD"] = "COD",
	["Skipping"] = "무시",

	["Select options"] = "우편 받기 설정",
	["Options for the Select module"] = "우편 받기를 위한 설정입니다.",
--tradeblock
	["TradeBlock"] = "거래 불가",
	["Block incoming trade requests while in a mail session."] = "우편함을 열고 있는 동안 거래 자동 불가",
--wire
	["Wire"] = "금액 표시",
	["Set subject field to value of coins sent if subject is blank."] = "우편으로 골드를 보낼시 제목에 자동으로 금액 표시",
	["^%[%d+g %d+s %d+c%]$"] = "^%[%d+골드 %d+실버 %d+코퍼%]$",
	["^%[%d+s %d+c%]$"] = "^%[%d+실버 %d+코퍼%]$",
	["^%[%d+c%]$"] = "^%[%d+코퍼%]$",
} end)
