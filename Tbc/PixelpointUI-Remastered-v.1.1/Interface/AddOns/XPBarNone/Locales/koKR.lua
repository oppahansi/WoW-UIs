local L = AceLibrary("AceLocale-2.2"):new("XPBarNone")
L:RegisterTranslations("koKR", function() return {
	["Lightweight XP Bar."] = "경험치를 바 형태로 표시해주는 애드온",
	["General"] = "일반",
	["General options"] = "일반 설정",
	["Lock"] = "바 잠금",
	["Toggle the locking."] = "선택하면 경험치바를 고정합니다.",
	["Border"] = "테두리 표시",
	["Toggle the border."] = "선택하면 바의 테두리를 표시합니다.",
	["Bubbles"] = "단락 표시",
	["Toggle bubbles on the XP bar."] = "선택하면 바의 단락을 표시합니다.",
	["Scale"] = "크기",
	["Set the bar scale."] = "바의 크기를 변경합니다.",
	["Width"] = "길이",
	["Set the bar width."] = "바의 길이를 변경합니다.",
	["Height"] = "높이",
	["Set the bar height."] = "바의 높이를 변경합니다.",
	["Font Size"] = "글자 크기",
	["Change the size of the text."] = "글자 크기를 변경합니다.",
	["Font Outline"] = "글자 윤곽선",
	["Toggles the font outline."] = "선택하면 글자에 윤곽선을 표시합니다.",
	["Mouse Over"] = "마우스 오버",
	["Toggles switching between XP bar and Rep bar when you mouse over XPBarNone."] = "마우스를 가져다 대면 경험치바와 평판바가 번갈아 표시됩니다.",
	["Frame Strata"] = "프레임 레벨",
	["Set the frame strata."] = "바의 프레임 레벨을 변경합니다.",
	["Texture"] = "텍스처",
	["Set the bar texture."] = "바 텍스처를 변경합니다.",
	["Hide Text"] = "글자 숨기기",
	["Hide the text on the XP and Rep bars."] = "선택하면 바 위의 글자를 표시하지 않습니다.",
	["Experience"] = "경험치바",
	["Experience Bar related options"] = "경험치바 설정",
	--["Text"] = "글자 설정",
	--["Toggle various parts of the XP Bar text."] = "경험치 바에 표시될 글자를 변경합니다.",
	--["Current XP"] = "현재 경험치",
	--["Toggle showing the 'curxp/maxxp/(restxp)' text."] = "선택하면 경험치 글자를 변경해서 보여줍니다.",
	--["Kills to Level"] = "레벨업까지 남은 횟수",
	--["Toggle showing kills to level."] = "레벨업까지 잡아야하는 몬스터 수를 표시합니다.",
	--["Percent through level"] = "현재 경험치 %로 표시",
	--["Toggle showing the '% through level ?' text."] = "선택하면 현재 경험치를 백분율로 표시합니다.",
	--["XP left"] = "남은 경험치",
	--["Toggle showing the '??? XP Left' text."] = "선택하면 다음 레벨까지 얻어야할 경험치 글자를 표시합니다.",
	--["Rested Percentage"] = "휴식 경험치 % 표시",
	--["Toggle between showing the raw rested XP value or showing it as a percentage."] = "선택하면 휴식 경험치를 백분율로 표시합니다.",
	["Remaining Rested XP"] = "남은 휴식 경험치",
	["Toggle the display of remaining rested XP."] = "선택하면 다음 레벨까지 얻어야할 경험치를 바에 표시합니다.",
	["Rest Indication"] = "휴식 상태 표시",
	["Toggle the rest indication."] = "선택하면 휴식 경험치의 위치를 표시합니다.",
	["Colours"] = "색깔",
	["Set the various bar colours."] = "바의 색상을 변경합니다.",
	["Normal"] = "평상시 경험치",
	["Set the colour of the normal bar."] = "평상시 경험치 색깔을 변경합니다.",
	["Rested"] = "현재(비휴식 상태) 경험치",
	["Set the colour of the rested bar."] = "휴식 중이 아닐 때 휴식 경험치가 포함된 현재 경험치의 색깔을 변경합니다.",
	["Resting"] = "현재(휴식 상태) 경험치",
	["Set the colour of the resting bar."] = "휴식 중일 때 현재 경험치의 색깔을 변경합니다.",
	["Remaining"] = "남은 휴식 경험치",
	["Set the colour of the remaining bar."] = "남은 휴식 경험치의 색깔을 변경합니다.",
	["Reputation"] = "평판바",
	["Reputation Bar related options"] = "평판바 설정",
	["Show Reputation"] = "평판바 보기",
	["Show the reputation bar instead of the XP bar."] = "경험치바 대신 평판바를 표시합니다.",
	--["Dynamic Bars"] = true,
	--["Show Rep bar on max level, XP bar on lower levels."] = true,
	["Hint: Click to set watched faction."] = "힌트: 클릭하여 표시할 평판을 선택합니다.",
	["Faction Listing"] = "평판 리스트",
	["You need to select a faction to watch."] = "평판바에 표시할 평판을 선택합니다.",
	--["Customise Text"] = true,
	--["Customise the XP text string."] = true,
	--["Customise the Reputation text string."] = true,
	--["(more)"] = true,
} end)
