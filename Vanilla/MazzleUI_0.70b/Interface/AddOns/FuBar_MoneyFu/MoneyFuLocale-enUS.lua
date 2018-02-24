local L = AceLibrary("AceLocale-2.2"):new("MoneyFu")

L:RegisterTranslations("enUS", function() return {
	["NAME"] = "FuBar - MoneyFu",
	["DESCRIPTION"] = "Keeps track of current money and all your characters on one realm.",
	["COMMANDS"] = {"/monfu", "/moneyfu"},
	["TEXT_TOTAL"] = "Total",
	["TEXT_SESSION_RESET"] = "Session reset",
	["TEXT_THIS_SESSION"] = "This session",
	["TEXT_GAINED"] = "Gained",
	["TEXT_SPENT"] = "Spent",
	["TEXT_AMOUNT"] = "Amount",
	["TEXT_PER_HOUR"] = "Per hour",

	["ARGUMENT_RESETSESSION"] = "resetSession",

	["MENU_RESET_SESSION"] = "Reset Session",
	["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Show character-specific cashflow",
	["MENU_PURGE"] = "Purge",
	["MENU_SHOW_GRAPHICAL"] = "Show with coins",
	["MENU_SHOW_FULL"] = "Show full style",
	["MENU_SHOW_SHORT"] = "Show short style",
	["MENU_SHOW_CONDENSED"] = "Show condensed style",
	["SIMPLIFIED_TOOLTIP"] = "Simplified Tooltip",
	["SHOW_PER_HOUR_CASHFLOW"] = "Show per hour cashflow",

	["TEXT_SESSION_RESET"] = "Session reset.",
	["TEXT_CHARACTERS"] = "Characters",
	["TEXT_PROFIT"] = "Profit",
	["TEXT_LOSS"] = "Loss",

	["HINT"] = "Click to pick up money"
} end)
