--Korean by papertiger of wildhammer

local L = AceLibrary("AceLocale-2.2"):new("ErrorMonster")

L:RegisterTranslations("koKR", function() return {
	["Shows the current filters and their ID."] = "현재 필터 및 그것의 ID를 표시합니다",
	["Adds the given filter to the ignore list."] = "주어진 필터를 무시 목록에 추가합니다",
	["<filter>"] = "필터",
	["Removes the given filter or ID from the filter list."] = "필터 목록에서 주어진 필터 및 그것의 ID를 제거합니다",
	["Adding filter: "] = "필터 추가: ",
	["Removing filter: "] = "필터 제거: ",
	["Filter not found: "] = "필터가 없습니다",
	["Active filters:"] = "활성화 필터: ",
	["Throttle errors at the given rate in seconds."] = "주어진 초당률로 오류의 목을 조입니다",
	["Go berserk and eat all the errors."] = "광분해서 모든 오류를 먹어치웁니다",
	["Teach your ErrorMonster to aggro on other message types."] = "다른 메세지 유형에도 공세를 취하도록 ErrorMonster를 가르칩니다",
	["Error messages."] = "오류 메세지",
	["Information messages."] = "정보 메세지",
	["System messages."] = "시스템 메세지",
	["System messages"] = "시스템 메세지",
	["|cffff0000Ignore|r"] = "|cffff0000무시|r",
	["|cff00ff00Aggro|r"] = "|cff00ff00공세|r",

	["list"] = "목록",
	["add"] = "추가",
	["remove"] = "제거",
	["throttle"] = "조르기",
	["berserk"] = "광분",
	["aggro"] = "공세",
	["error"] = "오류",
	["information"] = "정보",
	["system"] = "시스템",
} end)

