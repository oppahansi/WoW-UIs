local L = AceLibrary("AceLocale-2.2"):new("MoneyFu")

L:RegisterTranslations("koKR", function() return {
	["NAME"] = "FuBar - MoneyFu",
	["DESCRIPTION"] = "현재 소지금과 서버의 모든 캐릭터의 소지금을 표시합니다.",
	["COMMANDS"] = {"/monfu", "/moneyfu"},
	["TEXT_TOTAL"] = "총",
	["TEXT_SESSION_RESET"] = "세션 초기화",
	["TEXT_THIS_SESSION"] = "이번 세션",
	["TEXT_GAINED"] = "획득량",
	["TEXT_SPENT"] = "소모량",
	["TEXT_AMOUNT"] = "금액",
	["TEXT_PER_HOUR"] = "시간당",

	["ARGUMENT_RESETSESSION"] = "접속초기화",

	["MENU_RESET_SESSION"] = "세션 초기화",
	["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "캐릭터별 자산 이동 표시",
	["MENU_PURGE"] = "통합",
	["MENU_SHOW_GRAPHICAL"] = "동전 표시",
	["MENU_SHOW_FULL"] = "길게 보기",
	["MENU_SHOW_SHORT"] = "짧게 보기",
	["MENU_SHOW_CONDENSED"] = "생략해서 보기",
	["SIMPLIFIED_TOOLTIP"] = "간단한 툴팁",
	["SHOW_PER_HOUR_CASHFLOW"] = "시간당 유동량 표시",

	["TEXT_SESSION_RESET"] = "세션 초기화",
	["TEXT_CHARACTERS"] = "케릭터",
	["TEXT_PROFIT"] = "이득",
	["TEXT_LOSS"] = "손실",
	
	["HINT"] = "클릭하면 금전을 집습니다"
} end)
