local VERSION = tonumber(("$Revision: 70306 $"):match("%d+"))

local SharedMedia = Rock("LibSharedMedia-2.0")

local SharedMedia_border_None = SharedMedia:Fetch('border', "None")

PitBull = Rock:NewAddon("PitBull", "LibRockDB-1.0", "LibRockEvent-1.0", "LibRockTimer-1.0", "LibRockConsole-1.0", "LibRockModuleCore-1.0", "LibRockHook-1.0", "LibRockComm-1.0", "LibRockConfig-1.0")
local PitBull, self = PitBull, PitBull
PitBull.version = "3.0r" .. VERSION
PitBull.revision = VERSION
PitBull.date = ("$Date: 2008-04-18 05:31:05 -0400 (Fri, 18 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")

function PitBull:ProvideVersion(revision, date)
	revision = tonumber(tostring(revision):match("%d+"))
	if revision > PitBull.revision then
		PitBull.version = "3.0r" .. revision
		PitBull.revision = revision
		PitBull.date = date:match("%d%d%d%d%-%d%d%-%d%d")
	end
end

do
	local localeTables = {}
	function PitBull:L(name, defaultTable)
		if not localeTables[name] then
			localeTables[name] = setmetatable(defaultTable or {}, {__index = function(self, key)
				self[key] = key
				return key
			end})
		end
		return localeTables[name]
	end
end

local localization = (GetLocale() == "koKR") and {
	["Player"] = "플레이어",
	["Target"] = "대상",
	["Player's pet"] = "플레이어의 소환수",
	["Party"] = "파티",
	["Party pets"] = "파티원 소환수",
	["Party pet"] = "파티원 소환수",
	["Raid"] = "공격대",
	["Raid pets"] = "공격대원 소환수",
	["Raid pet"] = "공격대원 소환수",
	["Mouse-over"] = "마우스-오버",
	["Focus"] = "주시 대상",
	["Main tanks"] = "방어 전담",
	["Main tank"] = "방어 전담",
	["Main assists"] = "지원공격 전담",
	["Main assist"] = "지원공격 전담",
	["%s's target"] = "%s의 대상",
	["%s target"] = "%s의 대상",
	["%s targets"] = "%s의 대상",
	["Unit Frames of awesomeness. Woof. It'll bite your face off."] ="두려움이 없는 유닛 프레임입니다. 훕! 당신의 얼굴을 물어 뜯으려고 합니다.",
	["Modules"] = "모듈",
	["Extra units"] = "별도 유닛",
	["List of units which are not currently enabled. Click one to enable it."] = "현재 활성화되어 있지 않은 유닛의 목록입니다. 활성화할 하나를 클릭하십시오.",
	["Configuration mode"] = "설정 모드",
	["Show all frames that can be shown, for easy configuration."] = "쉬운 설정을 위해서 보여줄 수 있는 모든 프레임을 보여줍니다.",
	["Solo"] = "솔로",
	["Disabled"] = "비활성화",
	["Layouts"] = "레이아웃",
	["Choose layout options here."] = "여기서 레이아웃 옵션을 선택합니다.",
	["Import layout"] = "레이아웃 들여오기",
	["Import a layout from an external source."] = "외부 자료로 부터 레이아웃을 들여 옵니다.",
	["Import"] = "들여오기",
	["Export layout"] = "레이아웃 내보내기",
	["Export a specified layout."] = "지정한 레이아웃을 내보냅니다.",
	["Remove"] = "제거",
	["Remove a layout you no longer wish to use."] = "더 이상 사용하지 않을 레이아웃을 제거합니다.",
	["Send in-game"] = "아군에게 보내기",
	["Send a saved layout to a friend in-game."] = "저장된 레이아웃을 게임내의 아군에게 보냅니다.",
	["Send to specific player"] = "지정한 플레이어에게 보내기",
	["Send a saved layout to a specific player."] = "지정한 플레이어에게 저장된 레이아웃을 보냅니다.",
	["Name of player"] = "플레이어의 이름",
	["The name of the player you wish to send the layout to."] = "레이아웃을 보내고자 하는 플레이어의 이름을 입력합니다.",
	["Layout"] = "레이아웃",
	["The layout to send."] = "보내기 위한 레이아웃을 선택합니다.",
	["Send to guild"] = "길드원에게 보내기",
	["Send a saved layout to your guild."] = "저장된 레이아웃을 길드원에게 보냅니다.",
	["Send to group"] = "그룹원에게 보내기",
	["Send a saved layout to your party or raid."] = "저장된 레이아웃을 파티 혹은 공격대원에게 보냅니다.",
	["Global settings"] = "공통 설정",
	["Settings that apply to all PitBull frames."] = "모든 PitBull 프레임에 적용할 설정입니다.",
	["StatusBar texture"] = "상태바 텍스쳐",
	["Sets what texture to use for the statusbars, like health, power, and cast bar."] = "생명력, 마력, 시전바 같은 상태바를 위해 사용할 텍스쳐를 설정합니다.",
	["Font"] = "글꼴",
	["Font settings."] = "글꼴 설정입니다.",
	["Type"] = "유형",
	["What font face to use."] = "사용할 글꼴체를 선택합니다.",
	["Size"] = "크기",
	["Font size."] = "글꼴의 크기를 조절합니다.",
	["Locked"] = "잠금",
	["Make it so the frames cannot be moved"] = "프레임을 이동할 수 없게 만듭니다.",
	["Frame Strata"] = "창 표시 우선순위",
	["Choose the layer the unit frames are located on."] = "유닛 프레임이 위치할 우선순위를 선택합니다.",
	["Background"] = "Background",
	["Low"] = "Low",
	["Medium"] = "Medium",
	["High"] = "High",
	["Dialog"] = "Dialog",
	["Tooltip"] = "Tooltip",
	["Clamp frames to screen"] = "화면에 프레임 고정",
	["Make it so that frames cannot be dragged off-screen."] = "화면밖으로 프레임이 이동할 수 없게 만듭니다.",
	["Hide tooltips in combat"] = "전투시 툴팁 숨김",
	["Hides the unit frame tooltips while the player is in combat."] = "플레이어가 전투중인 동안에는 유닛 프레임의 툴팁을 숨깁니다.",
	["Show colored border on elite or rare unit"] = "정예나 희귀 유닛에 색상 테두리 보기",
	["Show a border specifically colored for an elite or rare unit, otherwise use the standard border."] = "정예나 희귀 유닛을 위해 특별히 색상을 입힌 테두리를 보기합니다. 그외 경우는 기본 테두리를 사용합니다.",
	["Colors"] = "색상",
	["Power"] = "마력",
	["Rage"] = "분노",
	["Mana"] = "마나",
	["Focus(Pet)"] = "집중",
	["Energy"] = "기력",
	["Classes"] = "직업",
	["Warlock"] = "흑마법사",
	["Priest"] = "사제",
	["Warrior"] = "전사",
	["Paladin"] = "성기사",
	["Shaman"] = "주술사",
	["Mage"] = "마법사",
	["Druid"] = "드루이드",
	["Rogue"] = "도적",
	["Hunter"] = "사냥꾼",
	["Reaction"] = "우호도",
	["Hostile"] = "적대적",
	["Neutral"] = "중립적",
	["Friendly"] = "우호적",
	["Civilian"] = "민간인",
	["Pet happiness"] = "소환수 만족도",
	["Happy"] = "매우 만족",
	["Neutral(Pet)"] = "만족",
	["Angry"] = "불만족",
	["Health gradient"] = "생명력 기울기",
	["No health"] = "0% 생명력",
	["50% health"] = "50% 생명력",
	["Maximum health"] = "최대 생명력",
	["Other"] = "기타",
	["Dead or Ghost"] = "죽음 혹은 유령",
	["Disconnected"] = "연결 끊김",
	["In combat"] = "전투중",
	["Resting"] = "휴식중",
	["Tapped"] = "선점됨",
	["Unknown"] = "알 수 없음",
	["Frame colors"] = "프레임 색상",
	["Border"] = "테두리",
	["Rare"] = "희귀",
	["Elite"] = "정예",
	["Other options."] = "기타 옵션입니다.",
	["All units"] = "모든 유닛",
	["Change settings for all units."] = "모든 유닛을 위한 설정을 변경합니다.",
	["|cffffffffEverything|r"] = "|cffffffff모두|r",
	["\n\nAffects: "] = "\n\n영향: ",
	["Affects: "] = "영향: ",
	["Options for %s."] = "%s|1을;를; 위한 옵션입니다.",
	["Bars"] = "바",
	["Options for bars."] = "바를 위한 옵션입니다.",
	["Texts"] = "문자",
	["Options for texts."] = "문자를 위한 옵션입니다.",
	["Icons"] = "아이콘",
	["Options for icons."] = "아이콘을 위한 옵션입니다.",
	["Options for changing the size of this unit type."] = "이 유닛 유형의 크기를 변경하기 위한 옵션입니다.",
	["Scale"] = "크기",
	["Scale of the unit frame."] = "유닛 프레임의 크기를 조절합니다.",
	["Width"] = "너비",
	["Width of the unit frame."] = "유닛 프레임의 너비를 조절합니다.",
	["Height"] = "높이",
	["Height of the unit frame."] = "유닛 프레임의 높이를 조절합니다.",
	["Position"] = "위치",
	["Options for changing the position of this unit type."] = "이 유닛 유형의 위치를 변경하기 위한 옵션입니다.",
	["Horizontal"] = "가로",
	["Horizontal position on the x-axis."] = "x-축에서의 수평적 위치를 변경합니다.",
	["Vertical"] = "세로",
	["Vertical position on the y-axis."] = "y-축에서의 수직적 위치를 변경합니다.",
	["Layout options for this unit type"] = "이 유닛 유형을 위한 레이아웃 옵션입니다.",
	["Choose"] = "선택",
	["Select the layout to use for this unit type."] = "이 유닛 유형을 위해 사용할 레이아웃을 선택합니다.",
	["Save layout"] = "레이아웃 저장",
	["Save your current settings for this unit type as a layout."] = "이 유닛 유형을 위한 현재의 설정을 레이아웃으로 저장합니다.",
	["Copy from other frame"] = "다른 프레임에서 복사",
	["Copy the layout used on another frame."] = "다른 프레임에서 사용하고 있는 레이아웃을 복사합니다.",
	["Border"] = "테두리",
	["Change the border type."] = "테두리 유형을 변경합니다.",
	["Disable"] = "비활성화",
	["Disables units of this type."] = "이 유형의 유닛을 비활성화합니다.",
	["Grouping"] = "그룹화",
	["Options for how to position the units in this group relative to eachother."] = "다른 각 그룹과 관련된 이 그룹에 속해 있는 유닛의 위치 선정 방식을 위한 옵션입니다.",
	["Enable freeform movement"] = "임의 형식 이동 활성화",
	["Direction"] = "방향",
	["What direction to group these units in."] = "이 유닛이 속해 있는 그룹의 방향을 선택합니다.",
	["Left"] = "좌측",
	["Right"] = "우측",
	["Up"] = "위",
	["Down"] = "아래",
	["Vertical Spacing"] = "세로 간격",
	["How much space there should be between each unit, in pixels."] = "각 유닛간의 픽셀당 공간 간격을 설정합니다.",
	["Horizontal Spacing"] = "가로 간격",
	["Hide party frames in raid"] = "공격대 참여시 파티 프레임 숨김",
	["Hides the party frames while the player is in a raid group."] = "플레이어가 공격대 그룹에 속해 있는 동안에는 파티 프레임을 숨김 설정합니다.",
	["Show player in party"] = "파티 참여시 플레이어 보기",
	["Shows the player in the party frames while the player is in a party."] = "플레이어가 파티에 속해 있는 동안에는 플레이어를 보여줍니다.",
	["Show 5-man raid as a party"] = "하나의 파티로 5명의 공격대원 보이기",
	["Show a 5-man, 1-party raid as a party instead of a raid. Could be useful in arena battles, for example."] = "하나의 공격대 대신에 하나의 파티로 5명, 1 파티 공격대로 보여줍니다. 예를 들면, 투기장 전투시에 유용할 수 있습니다.",
	["Sort by name"] = "이름에 따른 정렬",
	["Whether to sort the units in this group by name or index."] = "이 그룹에서 이름 혹은 색인에 따라 유닛을 정돈할 것인지의 여부를 선택합니다.",
	["Style"] = "양식",
	["Style to group by"] = "분류에 따라 그룹화하기 위한 양식입니다.",
	["Class"] = "직업에 따라",
	["Raid group"] = "공격대 그룹에 따라",
	["Flat, group by class"] = "직업에 따른 그룹으로 평범하게",
	["Flat, group by raid group"] = "공격대 그룹에 따른 그룹으로 평범하게",
	["Flat, no grouping"] = "그룹화하지 않고 평범하게",
	["Show 9 raid headers, one for each class."] = "각 직업에 대해 하나로, 9개의 공격대 머릿자로 보여줍니다.",
	["Show up to 8 raid headers, one for each raid group."] = "각 공격대 그룹에 대해 하나로, 8개 이상의 공격대 머릿자로 보여줍니다.",
	["Show a single raid header, grouping units by class."] = "직업에 따라 유닛을 그룹화해, 단일 공격대 머릿자로 보여줍니다.",
	["Show a single raid header, grouping units by raid group."] = "공격대 그룹에 따라 유닛을 그룹화해, 단일 공격대 머릿자로 보여줍니다.",
	["Show a single raid header, don't do any special grouping."] = "특별히 전체를 그룹화하지 않고, 단일 공격대 머릿자로 보여줍니다.",
	["Group Filter"] = "그룹 선별",
	["Set which groups to filter by."] = "분류에 따라 선별하기 위한 그룹을 설정합니다.",
	["Group #%d"] = "그룹 #%d",
	["Class Filter"] = "직업 선별",
	["Set which classes to filter by."] = "분류에 따라 선별하기 위한 직업을 설정합니다.",
	["Show in Battleground"] = "전장에서 보이기",
	["Show the raid frames in the given battlegrounds, otherwise only showing the party frames."] = "주어진 전장에서 공격대 프레임을 보여줍니다. 그외는 파티 프레임만 보여줍니다.",
	["Square"] = "사각형",
	["Square Layout"] = "사각형 레이아웃입니다.",
	["Enable %s."] = "%s|1을;를; 활성화합니다.",
	["Enable"] = "활성화",
	["Group %d"] = "그룹 %d",
	["Warriors"] = "전사",
	["Hunters"] = "사냥꾼",
	["Rogues"] = "도적",
	["Paladins"] = "성기사",
	["Shamans"] = "주술사",
	["Priests"] = "사제",
	["Mages"] = "마법사",
	["Warlocks"] = "흑마법사",
	["Druids"] = "드루이드",
	["%s pet"] = "%s의 소환수",
	["%s pets"] = "%s의 소환수",
	["Custom"] = "사용자",
	["Export: Press Ctrl-A to select the text, then Ctrl-C to copy."] = "내보내기: 문자 선택은 Ctrl-A를, 복사는 Ctrl-C를 누르십시오.",
	["Export: Press Cmd-A to select the text, then Cmd-C to copy."] = "내보내기: 문자 선택은 Cmd-A를, 복사는 Cmd-C를 누르십시오.",
	["Import: Copy text from an external source and press Ctrl-V to paste."] = "들여오기:외부 자료로 부터 문자를 복사하고 붙혀 넣기는 Ctrl-V를 누르십시오.",
	["Import: Copy text from an external source and press Cmd-V to paste."] = "들여오기:외부 자료로 부터 문자를 복사하고 붙혀 넣기는 Cmd-V를 누르십시오.",
    ["PitBull Raid Group Style"] = "PitBull Raid Group Style",
    ["Toggle between Class and Raid group"] = "Toggle between Class and Raid group",
} or (GetLocale() == "zhCN") and {
	["Player"] = "玩家",
	["Target"] = "目标",
	["Player's pet"] = "玩家宠物",
	["Party"] = "小队",
	["Party pets"] = "小队宠物",
	["Party pet"] = "小队宠物",
	["Raid"] = "团队",
	["Raid pets"] = "团队宠物",
	["Raid pet"] = "团队宠物",
	["Mouse-over"] = "鼠标指向",
	["Focus"] = "焦点",
	["Main tanks"] = "主坦克",
	["Main tank"] = "主坦克",
	["Main assists"] = "主助理",
	["Main assist"] = "主助理",
	["%s's target"] = "%s的目标",
	["%s target"] = "%s目标",
	["%s targets"] = "%s目标",
	["Unit Frames of awesomeness. Woof. It'll bite your face off."] = "这是很棒的单位框体插件，汪，小心它咬你脸。",
	["Modules"] = "模块",
	["Extra units"] = "未启用的框体",
	["List of units which are not currently enabled. Click one to enable it."] = "当前没有启用的框体列表，点击以启用。",
	["Configuration mode"] = "配置模式",
	["Show all frames that can be shown, for easy configuration."] = "显示所有能显示的框体，以方便配置。",
	["Solo"] = "Solo",
	["Disabled"] = "已禁用",
	["Layouts"] = "布局",
	["Choose layout options here."] = "更改布局选项。",
	["Import layout"] = "导入布局",
	["Import a layout from an external source."] = "由外部来源导入一个布局。",
	["Import"] = "导入",
	["Export layout"] = "导出布局",
	["Export a specified layout."] = "导出一个指定的布局。",
	["Remove"] = "移除",
	["Remove a layout you no longer wish to use."] = "移除一个你不打算再使用的布局。",
	["Send in-game"] = "发送给好友",
	["Send a saved layout to a friend in-game."] = "将一个已保存的布局发送给游戏好友。",
	["Send to specific player"] = "发送给玩家",
	["Send a saved layout to a specific player."] = "将一个已保存的布局发送给指定的玩家。",
	["Name of player"] = "玩家姓名",
	["The name of the player you wish to send the layout to."] = "要将布局发送给其的玩家姓名。",
	["Layout"] = "布局",
	["The layout to send."] = "要发送的布局。",
	["Send to guild"] = "发送至公会",
	["Send a saved layout to your guild."] = "将一个已保存的布局发送给你的公会。",
	["Send to group"] = "发送至队伍",
	["Send a saved layout to your party or raid."] = "将一个已保存的布局发送给你的小队或者团队。",
	["Global settings"] = "全局设定",
	["Settings that apply to all PitBull frames."] = "PitBull所有框体都共用的设置。",
	["StatusBar texture"] = "状态条纹理",
	["Sets what texture to use for the statusbars, like health, power, and cast bar."] = "设置状态条的纹理，例如生命条，能量条，施法条等。",
	["Font"] = "字体",
	["Font settings."] = "设置使用的字体。",
	["Type"] = "类型",
	["What font face to use."] = "使用那一种字体.",
	["Size"] = "大小",
	["Font size."] = "设置字体的大小。",
	["Locked"] = "已锁定",
	["Make it so the frames cannot be moved"] = "锁定后则所有的框体无法再被拖动。",
	["Frame Strata"] = "框体层级",
	["Choose the layer the unit frames are located on."] = "设定单位框体所位于的框体层级。",
	["Background"] = "背景层",
	["Low"] = "低",
	["Medium"] = "中",
	["High"] = "高",
	["Dialog"] = "对话框",
	["Tooltip"] = "提示信息",
	["Clamp frames to screen"] = "框体限制在屏幕内",
	["Make it so that frames cannot be dragged off-screen."] = "设定单位框体无法被拖动到屏幕之外。",
	["Hide tooltips in combat"] = "战斗中隐藏提示",
	["Hides the unit frame tooltips while the player is in combat."] = "当玩家进入战斗后隐藏框体的提示信息。",
	["Show colored border on elite or rare unit"] = "精英及稀有怪显示彩色边框",
	["Show a border specifically colored for an elite or rare unit, otherwise use the standard border."] = "对精英/稀有怪使用特殊的彩色边框，否则使用标准边框。",
	["Colors"] = "颜色",
	["Power"] = "能量",
	["Rage"] = "怒气",
	["Mana"] = "魔法",
	["Focus(Pet)"] = "集中(宠物)",
	["Energy"] = "能量",
	["Classes"] = "职业",
	["Warlock"] = "术士",
	["Priest"] = "牧师",
	["Warrior"] = "战士",
	["Paladin"] = "圣骑士",
	["Shaman"] = "萨满祭司",
	["Mage"] = "法师",
	["Druid"] = "德鲁伊",
	["Rogue"] = "潜行者",
	["Hunter"] = "猎人",
	["Reaction"] = "反应",
	["Hostile"] = "敌对",
	["Neutral"] = "中立",
	["Friendly"] = "友好",
	["Civilian"] = "平民",
	["Pet happiness"] = "宠物快乐度",
	["Happy"] = "高兴",
	["Neutral(Pet)"] = "一般",
	["Angry"] = "生气",
	["Health gradient"] = "生命渐变",
	["No health"] = "无生命",
	["50% health"] = "50% 生命",
	["Maximum health"] = "最大生命",
	["Other"] = "其他",
	["Dead or Ghost"] = "死亡或灵魂",
	["Disconnected"] = "离线",
	["In combat"] = "战斗",
	["Resting"] = "休息",
	["Tapped"] = "已被攻击",
	["Unknown"] = "未知",
	["Frame colors"] = "框体颜色",
	["Border"] = "边框",
	["Rare"] = "稀有",
	["Elite"] = "精英",
	["All units"] = "所有单位",
	["Change settings for all units."] = "为所有单位更改设定。",
	["|cffffffffEverything|r"] = "|cffffffff全部|r",
	["\n\nAffects: "] = "\n\n作用于：",
	["Affects: "] = "作用于：",
	["Options for %s."] = "%s的选项。",
	["Bars"] = "状态条",
	["Options for bars."] = "状态条选项。",
	["Texts"] = "文字",
	["Options for texts."] = "文字选项。",
	["Icons"] = "图标",
	["Options for icons."] = "图标选项。",
	["Other options."] = "其他选项。",
	["Options for changing the size of this unit type."] = "更改这种单位类型大小的选项。",
	["Scale"] = "缩放",
	["Scale of the unit frame."] = "设置框体的缩放。",
	["Width"] = "宽度",
	["Width of the unit frame."] = "该框体的宽度。",
	["Height"] = "高度",
	["Height of the unit frame."] = "该框体的高度。",
	["Position"] = "位置",
	["Options for changing the position of this unit type."] = "更改这种单位类型位置的选项。",
	["Horizontal"] = "横向",
	["Horizontal position on the x-axis."] = "在横向轴上的位置。",
	["Vertical"] = "纵向",
	["Vertical position on the y-axis."] = "在纵向轴上的位置。",
	["Layout options for this unit type"] = "更改这种单位类型的布局选项。",
	["Choose"] = "选择",
	["Select the layout to use for this unit type."] = "为该框体选择所使用的布局。",
	["Save layout"] = "保存布局",
	["Save your current settings for this unit type as a layout."] = "把你当前对该单位类型的设置保存为一个布局。",
	["Copy from other frame"] = "从其他框体复制",
	["Copy the layout used on another frame."] = "复制一个其他框体所使用的布局。",
	["Border"] = "边框",
	["Change the border type."] = "更改边框类型。",
	["Disable"] = "禁用",
	["Disables units of this type."] = "禁用这个单位类型。",
	["Grouping"] = "分组",
	["Options for how to position the units in this group relative to eachother."] = "设置这一组的每个单位和其他单位的相对位置。",
	["Enable freeform movement"] = "启用任意移动",
	["Direction"] = "方向",
	["What direction to group these units in."] = "将这些单位所分组的方向。",
	["Left"] = "左",
	["Right"] = "右",
	["Up"] = "上",
	["Down"] = "下",
	["Vertical Spacing"] = "垂直间距",
	["How much space there should be between each unit, in pixels."] = "每个框体之间的垂直间距，以像素为单位。",
	["Horizontal Spacing"] = "水平间距",
	["Hide party frames in raid"] = "进团队隐藏小队",
	["Hides the party frames while the player is in a raid group."] = "当进入一个团队时隐藏小队的框体。",
	["Show player in party"] = "小队中显示自己",
	["Shows the player in the party frames while the player is in a party."] = "当自己加入一个队伍时，在队伍框体中也显示自己。",
	["Show 5-man raid as a party"] = "将5人团队以小队显示",
	["Show a 5-man, 1-party raid as a party instead of a raid. Could be useful in arena battles, for example."] = "将5人小队的团队作为队伍显示，而不是以团队方式显示。在竞技场中可能十分有用。",
	["Sort by name"] = "按姓名排序",
	["Whether to sort the units in this group by name or index."] = "设置分组中的单位是按姓名还是按序号排序。",
	["Style"] = "样式",
	["Style to group by"] = "按照以下类型分组",
	["Class"] = "职业",
	["Raid group"] = "团队小队",
	["Flat, group by class"] = "整合，按职业分组",
	["Flat, group by raid group"] = "整合，按团队小队分组",
	["Flat, no grouping"] = "整合，不分组",
	["Show 9 raid headers, one for each class."] = "显示9个团队标头，每职业一个。",
	["Show up to 8 raid headers, one for each raid group."] = "显示8个团队标头，每团队小队1个。",
	["Show a single raid header, grouping units by class."] = "显示单个团队标头，单位按职业分组。",
	["Show a single raid header, grouping units by raid group."] = "显示单个团队标头，单位按团队小队分组。",
	["Show a single raid header, don't do any special grouping."] = "显示单个团队标头，不进行分组。",
	["Group Filter"] = "分组过滤",
	["Set which groups to filter by."] = "设置分组过滤条件。",
	["Group #%d"] = "分组%d",
	["Class Filter"] = "职业过滤",
	["Set which classes to filter by."] = "设置职业过滤条件。",
	["Show in Battleground"] = "战场中显示",
	["Show the raid frames in the given battlegrounds, otherwise only showing the party frames."] = "只在指定的战场中显示团队框体，否则在战场只显示小队框体。",
	["Square"] = "方形",
	["Square Layout"] = "方形布局方式",
	["Enable %s."] = "启用%s。",
	["Enable"] = "启用",
	["Group %d"] = "分组%d",
	["Warriors"] = "战士",
	["Hunters"] = "猎人",
	["Rogues"] = "潜行者",
	["Paladins"] = "圣骑士",
	["Shamans"] = "萨满祭司",
	["Priests"] = "牧师",
	["Mages"] = "法师",
	["Warlocks"] = "术士",
	["Druids"] = "德鲁伊",
	["%s pet"] = "%s的宠物",
	["%s pets"] = "%s的宠物",
	["Custom"] = "自定义",
	["Export: Press Ctrl-A to select the text, then Ctrl-C to copy."] = "导出: 按Ctrl+A选择文本，然后按Ctrl+C复制。",
	["Export: Press Cmd-A to select the text, then Cmd-C to copy."] = "导出: 按Cmd+A选择文本，然后按Cmd+C复制。",
	["Import: Copy text from an external source and press Ctrl-V to paste."] = "导入: 从外部源拷贝文本，然后按Ctrl+V粘贴。",
	["Import: Copy text from an external source and press Cmd-V to paste."] = "导入: 从外部源拷贝文本，然后按Cmd+V粘贴。",
    ["PitBull Raid Group Style"] = "PitBull Raid Group Style",
    ["Toggle between Class and Raid group"] = "Toggle between Class and Raid group",
} or (GetLocale() == "zhTW") and {
	["Player"] = "玩家",
	["Target"] = "目標",
	["Player's pet"] = "玩家的寵物",
	["Party"] = "隊伍",
	["Party pets"] = "小隊成員的寵物",
	["Party pet"] = "小隊成員的寵物",
	["Raid"] = "團隊",
	["Raid pets"] = "團隊成員的寵物",
	["Raid pet"] = "團隊成員的寵物",
	["Mouse-over"] = "滑鼠位置",
	["Focus"] = "鎖定的目標",
	["Main tanks"] = "主坦",
	["Main tank"] = "主坦",
	["Main assists"] = "主要助理",
	["Main assist"] = "主要助理",
	["%s's target"] = "%s的目標",
	["%s target"] = "%s的目標",
	["%s targets"] = "%s的目標(多個)",
	["Unit Frames of awesomeness. Woof. It'll bite your face off."] ="框架高度有誤.將導致頭像關閉.",
	["Modules"] = "模組",
	["Extra units"] = "未啟用的框體",
	["List of units which are not currently enabled. Click one to enable it."] = "列出目前未啟用的單元列表,點選啟用",
	["Configuration mode"] = "配置模式",
	["Show all frames that can be shown, for easy configuration."] = "顯示所有可顯示的框架進行配置",
	["Solo"] = "solo",
	["Disabled"] = "停用",
	["Layouts"] = "佈局",
	["Choose layout options here."] = "在這裡設定版面佈局",
	["Import layout"] = "導入佈局",
	["Import a layout from an external source."] = "從外部資源導入佈局",
	["Import"] = "導入",
	["Export layout"] = "導出佈局",
	["Export a specified layout."] = "導出一種佈局",
	["Remove"] = "移除",
	["Remove a layout you no longer wish to use."] = "刪除你不再使用的佈局",
	["Send in-game"] = "遊戲中發送",
	["Send a saved layout to a friend in-game."] = "把一個保存的佈局發送給遊戲中的朋友.",
	["Send to specific player"] = "發送給特定的玩家",
	["Send a saved layout to a specific player."] = "把這種佈局發送給一個特定的玩家.",
	["Name of player"] = "玩家名稱",
	["The name of the player you wish to send the layout to."] = "你希望發送佈局給那個玩家的名稱.",
	["Layout"] = "佈局",
	["The layout to send."] = "要發送的佈局.",
	["Send to guild"] = "發送給公會",
	["Send a saved layout to your guild."] = "把佈局發送給公會裡",
	["Send to group"] = "發送給小隊",
	["Send a saved layout to your party or raid."] = "把佈局發送給小隊裡",
	["Global settings"] = "總體設定",
	["Settings that apply to all PitBull frames."] = "套用到所有PitBull框架的配置.",
	["StatusBar texture"] = "狀態欄紋理",
	["Sets what texture to use for the statusbars, like health, power, and cast bar."] = "設定狀態欄紋理,例如生命,能量以及施法欄",
	["Font"] = "字體",
	["Font settings."] = "字體設定.",
	["Type"] = "類型",
	["What font face to use."] = "要使用的字體",
	["Size"] = "大小",
	["Font size."] = "字體大小",
	["Locked"] = "鎖定",
	["Make it so the frames cannot be moved"] = "使用該選項將使框架不能移動.",
	["Frame Strata"] = "框架層",
	["Choose the layer the unit frames are located on."] = "選擇單位框架存放的層.",
	["Background"] = "背景",
	["Low"] = "低",
	["Medium"] = "中",
	["High"] = "高",
	["Dialog"] = "對話方塊",
	["Tooltip"] = "工具提示",
	["Clamp frames to screen"] = "限制框架在螢幕內",
	["Make it so that frames cannot be dragged off-screen."] = "使用該選項將使框架不可以被移動到螢幕外.",
	["Hide tooltips in combat"] = "戰鬥中隱藏工具提示",
	["Hides the unit frame tooltips while the player is in combat."] = "當玩家戰鬥時隱藏框架提示",
	["Show colored border on elite or rare unit"] = "精英和稀有怪物顯示彩色邊框",
	["Show a border specifically colored for an elite or rare unit, otherwise use the standard border."] = "對精英和稀有怪物顯示特殊的彩色邊框,否則使用標準邊框",
	["Colors"] = "顏色",
	["Power"] = "能力",
	["Rage"] = "怒氣",
	["Mana"] = "法力",
	["Focus(Pet)"] = "鎖定目標(寵物)",
	["Energy"] = "能量",
	["Classes"] = "職業",
	["Warlock"] = "術士",
	["Priest"] = "牧師",
	["Warrior"] = "戰士",
	["Paladin"] = "聖騎士",
	["Shaman"] = "薩滿",
	["Mage"] = "法師",
	["Druid"] = "德魯伊",
	["Rogue"] = "盜賊",
	["Hunter"] = "獵人",
	["Reaction"] = "反應",
	["Hostile"] = "敵對",
	["Neutral"] = "中立",
	["Friendly"] = "友好",
	["Civilian"] = "平民",
	["Pet happiness"] = "寵物快樂值",
	["Happy"] = "高興",
	["Neutral(Pet)"] = "平靜",
	["Angry"] = "生氣",
	["Health gradient"] = "生命值比例",
	["No health"] = "無生命值",
	["50% health"] = "50%生命",
	["Maximum health"] = "最大生命值",
	["Other"] = "其他",
	["Dead or Ghost"] = "死亡或者靈魂",
	["Disconnected"] = "離線中",
	["In combat"] = "戰鬥中",
	["Resting"] = "休息中",
	["Tapped"] = "觸發",
	["Unknown"] = "未知",
	["Frame colors"] = "框架顏色",
	["Background"] = "背景",
	["Border"] = "邊框",
	["Rare"] = "稀有",
	["Elite"] = "精英",
	["|cffffffffEverything|r"] = "|cffffffff所有|r",
	["\n\nAffects: "] = "\n\n影響框架: ",
	["Affects: "] = "影響框架: ",
	["All units"] = "所有單位",
	["Change settings for all units."] = "同時改變所有單位的設定.",
	["Options for %s."] = "%s 的選項.",
	["Bars"] = "條(Bars)",
	["Options for bars."] = "條的選項.",
	["Texts"] = "文字",
	["Options for texts."] = "文字選項",
	["Icons"] = "圖示",
	["Options for icons."] = "圖示的選項.",
	["Other options."] = "其他的選項.",
	["Options for changing the size of this unit type."] = "用來改變此單位類型大小的選項.",
	["Scale"] = "縮放",
	["Scale of the unit frame."] = "單位框架縮放.",
	["Width"] = "寬",
	["Width of the unit frame."] = "框架寬度.",
	["Height"] = "高",
	["Height of the unit frame."] = "框架高度.",
	["Position"] = "定位點",
	["Options for changing the position of this unit type."] = "改變此單位類型的定位點",
	["Horizontal"] = "水平",
	["Horizontal position on the x-axis."] = "水平定位點Ｘ座標",
	["Vertical"] = "垂直",
	["Vertical position on the y-axis."] = "垂直定位點Ｙ座標",
	["Layout options for this unit type"] = "此單位類型的佈局設定.",
	["Choose"] = "選擇",
	["Select the layout to use for this unit type."] = "選擇此單位類型使用的佈局.",
	["Save layout"] = "保存佈局",
	["Save your current settings for this unit type as a layout."] = "保存目前單位類型的設定為一種佈局.",
	["Copy from other frame"] = "從其他框架複製",
	["Copy the layout used on another frame."] = "從其他的框架複製過來.",
	["Border"] = "邊框",
	["Change the border type."] = "改變邊框類型.",
	["Disable"] = "停用",
	["Disables units of this type."] = "禁止此類對象.",
	["Grouping"] = "分組",
	["Options for how to position the units in this group relative to eachother."] = "設定隊伍成員在螢幕上顯示的方法.",
	["Enable freeform movement"] = "打開自由移動",
	["Direction"] = "方向",
	["Left"] = "左",
	["Right"] = "右",
	["Up"] =  "上",
	["Down"] = "下",
	["What direction to group these units in."] = "整個編組移動的方向.",
	["Vertical Spacing"] = "垂直間距",
	["How much space there should be between each unit, in pixels."] = "各個單位間的距離,以像素為單位.",
	["Horizontal Spacing"] = "水平間距",
	["Hide party frames in raid"] = "在團隊中隱藏小隊面板",
	["Hides the party frames while the player is in a raid group."] = "當玩家在一個團隊中時隱藏小隊面板.",
	["Show player in party"] = "在小隊中顯示玩家",
	["Shows the player in the party frames while the player is in a party."] = "在小隊面板內顯示玩家(在小隊中時)",
	["Show 5-man raid as a party"] = "將5人團隊顯示為小隊",
	["Show a 5-man, 1-party raid as a party instead of a raid. Could be useful in arena battles, for example."] = "將5人的團隊顯示為小隊,在一些場合很有用,例如競技場.",
	["Sort by name"] = "按名稱排序",
	["Whether to sort the units in this group by name or index."] = "隊伍中成員按名稱或是類型排序.",
	["Style"] = "風格",
	["Style to group by"] = "該組使用的風格",
	["Class"] = "分類",
	["Raid group"] = "團隊",
	["Flat, group by class"] = "平面,以職業分組",
	["Flat, group by raid group"] = "平面,以團隊分組",
	["Flat, no grouping"] = "平面,無分組",
	["Show 9 raid headers, one for each class."] = "顯示9個團隊標頭,每種職業一個.",
	["Show up to 8 raid headers, one for each raid group."] = "顯示8個團隊標頭,每個小隊一個.",
	["Show a single raid header, grouping units by class."] = "顯示1個團隊標頭,按職業分組.",
	["Show a single raid header, grouping units by raid group."] = "顯示1個團隊標頭,按小隊分組.",
	["Show a single raid header, don't do any special grouping."] = "顯示1個團隊標頭,不分組.",
	["Group Filter"] = "分組過濾",
	["Set which groups to filter by."] = "設定小隊過濾",
	["Group #%d"] = "小隊 #%d",
	["Class Filter"] = "職業過濾",
	["Set which classes to filter by."] = "設定職業過濾",
	["Show in Battleground"] = "戰場中顯示",
	["Show the raid frames in the given battlegrounds, otherwise only showing the party frames."] = "在指定的戰場中顯示團隊框架,否則只顯示小隊框架.",
	["Square"] = "方形",
	["Square Layout"] = "方形佈局",
	["Enable %s."] = "啟用: %s",
	["Enable"] = "啟用",
	["Group %d"] = "小隊 %d",
	["Warriors"] = "戰士",
	["Hunters"] = "獵人",
	["Rogues"] = "盜賊",
	["Paladins"] = "聖騎士",
	["Shamans"] = "薩滿",
	["Priests"] = "牧師",
	["Mages"] = "法師",
	["Warlocks"] = "術士",
	["Druids"] = "德魯伊",
	["%s pet"] = "%s 的寵物",
	["%s pets"] = "%s 的寵物",
	["Custom"] = "自定",
	["Export: Press Ctrl-A to select the text, then Ctrl-C to copy."] = "導出:按Ctrl+A選擇全部文字,然後按Ctrl+C複製.",
	["Export: Press Cmd-A to select the text, then Cmd-C to copy."] = "導出:按Cmd+A選擇全部文字,然後按Cmd+C複製.",
	["Import: Copy text from an external source and press Ctrl-V to paste."] = "導入:複製外部來源文字,按Ctrl+V貼上",
	["Import: Copy text from an external source and press Cmd-V to paste."] = "導入:複製外部來源文字,按Cmd+V貼上",
    ["PitBull Raid Group Style"] = "PitBull Raid Group Style",
    ["Toggle between Class and Raid group"] = "Toggle between Class and Raid group",
} or {}

local L = PitBull:L("PitBull", localization)

BINDING_HEADER_PITBULL_RAID_GROUP = L["PitBull Raid Group Style"]
BINDING_NAME_PITBULL_SET_RAID_GROUP_CLASS = L["Class"]
BINDING_NAME_PITBULL_SET_RAID_GROUP_GROUP = L["Raid group"]
BINDING_NAME_PITBULL_SET_RAID_GROUP_FLAT_CLASS = L["Flat, group by class"]
BINDING_NAME_PITBULL_SET_RAID_GROUP_FLAT_GROUP = L["Flat, group by raid group"]
BINDING_NAME_PITBULL_SET_RAID_GROUP_FLAT = L["Flat, no grouping"]
BINDING_NAME_PITBULL_TOGGLE_RAID_GROUP = L["Toggle between Class and Raid group"]

local configMode = false
PitBull.configMode = configMode

local DogTag = Rock("LibDogTag-3.0")
Rock("LibDogTag-Unit-3.0")

local BZ = Rock("LibBabble-Zone-3.0"):GetLookupTable()

local table_insert = table.insert
local table_remove = table.remove
local table_sort = table.sort
local table_concat = table.concat
local select = select
local geterrorhandler = geterrorhandler
local pairs = pairs
local type = type
local GetMouseFocus = GetMouseFocus
local error = error
local tostring = tostring
local ipairs = ipairs
local RegisterUnitWatch = RegisterUnitWatch
local UnregisterUnitWatch = UnregisterUnitWatch
local SecureGroupHeader_Update = SecureGroupHeader_Update
local _G = _G
local hooksecurefunc = hooksecurefunc
local UnitIsUnit = UnitIsUnit
local UnitPowerType = UnitPowerType
local pcall = pcall
local strsplit = strsplit
local tonumber = tonumber
local GetPartyAssignment = GetPartyAssignment
local UnitName = UnitName
local UnitClass = UnitClass
local UnitExists = UnitExists
local GetRaidRosterInfo = GetRaidRosterInfo
local math_max = math.max
local math_abs = math.abs
local math_min = math.min
local math_ceil = math.ceil
local SetupUnitButtonConfiguration = SetupUnitButtonConfiguration
local CreateFrame = CreateFrame
local next = next
local GetScreenHeight = GetScreenHeight
local GetScreenWidth = GetScreenWidth
local InCombatLockdown = InCombatLockdown
local unpack = unpack
local UnitClassification = UnitClassification
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers
local IsControlKeyDown = IsControlKeyDown
local IsAltKeyDown = IsAltKeyDown
local IsShiftKeyDown = IsShiftKeyDown
local GameTooltip = GameTooltip
local GetAddOnMetadata = GetAddOnMetadata
local LoadAddOn = LoadAddOn
local GetAddOnInfo = GetAddOnInfo
local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand
local GetAddOnDependencies = GetAddOnDependencies
local GetNumAddOns = GetNumAddOns
local loadstring = loadstring
local setmetatable = setmetatable
local rawget = rawget

local newList, del, newDict, newSet, unpackDictAndDel, unpackListAndDel = Rock:GetRecyclingFunctions("PitBull", "newList", "del", "newDict", "newSet", "unpackDictAndDel", "unpackListAndDel")
local deepCopy, deepDel
do
	function deepCopy(from)
		if type(from) ~= "table" then
			return from
		end
		local to = newList()
		for k,v in pairs(from) do
			to[k] = deepCopy(v)
		end
		return to
	end

	function deepDel(t)
		if type(t) ~= "table" then
			return nil
		end
		for k,v in pairs(t) do
			t[k] = deepDel(v)
		end
		return del(t)
	end
end

local newFrame, delFrame, newFrameType
do
	local frameCache = {}
	local frameCount = {}
	

	local madeByPitBull = {}
	local customFrameTypes = {}
	local realKindToCustom = {}
	
	function newFrame(kind, parent, ...)
		if type(kind) ~= "string" then
			error(("Bad argument #1 to `newFrame'. %s expected, got %s"):format("string", type(kind)), 2)
		end
		if type(parent) ~= "table" then
			error(("Bad argument #2 to `newFrame'. %s expected, got %s"):format("table", type(parent)), 2)
		end
		local frame
		local customKind = kind
		if customFrameTypes[customKind] then
			kind = customFrameTypes[customKind][1]
		end
		local frameCache_customKind = frameCache[customKind]
		if frameCache_customKind then
			frame = next(frameCache_customKind)
			frameCache_customKind[frame] = nil
			if not next(frameCache_customKind) then
				frameCache[customKind] = del(frameCache_customKind)
			end
			frame:SetParent(parent)
			frame:ClearAllPoints()
			frame:SetAlpha(1)
			if kind == "Texture" then
				frame:SetTexture(nil)
				frame:SetVertexColor(1, 1, 1, 1)
			end
			if kind == "Texture" or kind == "FontString" then
				frame:SetDrawLayer((...))
			end
			frame:Show()
		else
			frameCount[customKind] = (frameCount[customKind] or 0) + 1
			local name = "PitBull" .. customKind .. frameCount[customKind]
			if customKind ~= kind then
				frame = CreateFrame(kind, name, parent, customFrameTypes[customKind][5])
				frame.customKind = customKind
				customFrameTypes[customKind][2](frame) -- onCreate
			elseif kind == "Texture" then
				frame = parent:CreateTexture(name, (...))
			elseif kind == "FontString" then
				frame = parent:CreateFontString(name, (...))
				
			elseif kind == "Cooldown" then
				frame = CreateFrame("Cooldown", name, parent, "CooldownFrameTemplate")
				frame:Show()
			else
				frame = CreateFrame(kind, name, parent)
			end
			madeByPitBull[frame] = true
		end
		if customKind ~= kind then
			customFrameTypes[customKind][3](frame, ...) -- onRetrieve
		end
		return frame
	end
	
	function delFrame(frame)
		if type(frame) ~= "table" then
			error(("Bad argument #1 to `delFrame'. %q expected, got %q"):format("table", type(frame)), 2)
		elseif type(frame.GetObjectType) ~= "function" then
			error(("Bad argument #1 to `delFrame'. %q expected, got %q"):format("Frame", "table"), 2)
		end
		
		local kind = frame:GetObjectType()
		local customKind = frame.customKind or kind
		
		if not madeByPitBull[frame] then
			error(("Deleting a frame not created by PitBull of type %q"):format(kind), 2)
		end
		
		if customKind == "FontString" then
			DogTag:RemoveFontString(frame)
			frame:SetText("")
			frame:SetJustifyH("CENTER")
			frame:SetJustifyV("MIDDLE")
			frame:SetNonSpaceWrap(true)
			frame:SetTextColor(1, 1, 1, 1)
			frame:SetFontObject(nil)
		elseif customKind == "Texture" then
			frame:SetTexture([[Interface\Buttons\WHITE8X8]])
			frame:SetVertexColor(0, 0, 0, 0)
			frame:SetBlendMode("BLEND")
			frame:SetDesaturated(false)
			frame:SetTexCoord(0, 1, 0, 1)
			frame:SetTexCoordModifiesRect(false)
		elseif customKind == "StatusBar" then
			frame:SetStatusBarColor(1, 1, 1, 1)
			frame:SetStatusBarTexture(nil)
			frame:SetValue(1)
			frame:SetOrientation("HORIZONTAL")
		elseif customKind == "Cooldown" then
			frame:SetReverse(false)
		elseif customKind ~= kind then
			customFrameTypes[customKind][4](frame) -- onDelete
		end
		
		if kind ~= "Texture" and kind ~= "FontString" and not _G.OmniCC and customKind == kind and _G.UnitClassBase then
			if frame:GetNumRegions() > 0 then
				error(("Deleting a frame of type %q that still has %d regions"):format(kind, frame:GetNumRegions()), 2)
			elseif frame:GetNumChildren() > 0 then
				error(("Deleting a frame of type %q that still has %d children"):format(kind, frame:GetNumChildren()), 2)
			end
		end
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", UIParent, "RIGHT", 1e5, 0)
		frame:Hide()
		if frame.SetBackdrop then
			frame:SetBackdrop(nil)
		end
		frame:SetParent(UIParent)
		frame:SetAlpha(0)
		frame:SetHeight(0)
		frame:SetWidth(0)
		local frameCache_customKind = frameCache[customKind]
		if not frameCache_customKind then
			frameCache_customKind = newList()
			frameCache[customKind] = frameCache_customKind
		end
		if frameCache_customKind[frame] then
			error(("Double-free frame syndrome of type %q"):format(customKind), 2)
		end
		frameCache_customKind[frame] = true
		return nil
	end
	
	function newFrameType(kind, realKind, onCreate, onRetrieve, onDelete, inheritTemplate)
		if type(kind) ~= "string" then
			error(("Bad argument #1 to `newFrameType'. Expected %q, got %q."):format("string", type(kind)), 2)
		elseif customFrameTypes[kind] then
			error(("Bad argument #1 to `newFrameType'. %q has already been specified."):format(kind), 2)
		elseif type(realKind) ~= "string" then
			error(("Bad argument #2 to `newFrameType'. Expected %q, got %q."):format("string", type(realKind)), 2)
		elseif type(onCreate) ~= "function" then
			error(("Bad argument #3 to `newFrameType'. Expected %q, got %q."):format("function", type(onCreate)), 2)
		elseif type(onRetrieve) ~= "function" then
			error(("Bad argument #4 to `newFrameType'. Expected %q, got %q."):format("function", type(onRetrieve)), 2)
		elseif type(onDelete) ~= "function" then
			error(("Bad argument #5 to `newFrameType'. Expected %q, got %q."):format("function", type(onDelete)), 2)
		elseif inheritTemplate and type(inheritTemplate) ~= "string" then
			error(("Bad argument #6 to `newFrameType'. Expected %q or %q, got %q."):format("nil", "string", type(inheritTemplate)), 2)
		end
		customFrameTypes[kind] = { realKind, onCreate, onRetrieve, onDelete, inheritTemplate }
		if not realKindToCustom[realKind] then
			realKindToCustom[realKind] = {}
		end
		realKindToCustom[realKind][kind] = true
	end
end

do
	local FakeStatusBar_methods = {
		value = 1,
		extraValue = 0,
		orientation = "HORIZONTAL",
		reverse = false,
		deficit = false,
		bgR = false,
		bgG = false,
		bgB = false,
		bgA = false,
		extraR = false,
		extraG = false,
		extraB = false,
		extraA = false,
	}
	local FakeStatusBar_scripts = {}
	
	local function OnUpdate(self)
		self:SetScript("OnUpdate", nil)
		self:SetValue(self.value)
	end
	
	function FakeStatusBar_methods:SetValue(value)
		self.value = value
		if self.deficit then
			value = 1 - value
		end
		if value <= 0 then
			value = 1e-5
		elseif value >= 1 then
			value = 1
		end
		local extraValue = self.extraValue
		if extraValue <= 0 then
			extraValue = 1e-5
		elseif extraValue+value >= 1 then
			extraValue = 1 - value
		end
		if self.orientation == "VERTICAL" then
			if self:GetHeight() == 0 then
				self:SetScript("OnUpdate", OnUpdate)
			end
			self.fg:SetHeight(self:GetHeight() * value)
			self.extra:SetHeight(self:GetHeight() * extraValue)
			if not self.reverse then
				self.fg:SetTexCoord(value, 0, 0, 0, value, 1, 0, 1)
				self.extra:SetTexCoord(value+extraValue, 0, value, 0, value+extraValue, 1, value, 1)
				self.bg:SetTexCoord(1, 0, value+extraValue, 0, 1, 1, value+extraValue, 1)
			else
				self.fg:SetTexCoord(0, 0, value, 0, 0, 1, value, 1)
				self.extra:SetTexCoord(value, 0, value+extraValue, 0, value, 1, value+extraValue, 1)
				self.bg:SetTexCoord(value+extraValue, 0, 1, 0, value+extraValue, 1, 1, 1)
			end
		else
			if self:GetWidth() == 0 then
				self:SetScript("OnUpdate", OnUpdate)
			end
			self.fg:SetWidth(self:GetWidth() * value)
			self.extra:SetWidth(self:GetWidth() * extraValue)
			if not self.reverse then
				self.fg:SetTexCoord(0, 0, 0, 1, value, 0, value, 1)
				self.extra:SetTexCoord(value, 0, value, 1, value+extraValue, 0, value+extraValue, 1)
				self.bg:SetTexCoord(value+extraValue, 0, value+extraValue, 1, 1, 0, 1, 1)
			else
				self.fg:SetTexCoord(value, 0, value, 1, 0, 0, 0, 1)
				self.extra:SetTexCoord(value+extraValue, 0, value+extraValue, 1, value, 0, value, 1)
				self.bg:SetTexCoord(1, 0, 1, 1, value+extraValue, 0, value+extraValue, 1)
			end
		end
	end
	function FakeStatusBar_methods:GetValue()
		return self.value
	end
	
	function FakeStatusBar_methods:SetExtraValue(value)
		self.extraValue = value
		self:SetValue(self.value)
	end
	function FakeStatusBar_methods:GetExtraValue()
		return self.extraValue
	end
	
	local function fixOrientation(self)
		local orientation, reverse = self.orientation, self.reverse
		local fg, extra, bg = self.fg, self.extra, self.bg
		fg:ClearAllPoints()
		extra:ClearAllPoints()
		bg:ClearAllPoints()
		fg:SetWidth(0)
		fg:SetHeight(0)
		extra:SetWidth(0)
		extra:SetHeight(0)
		if orientation == "VERTICAL" then
			fg:SetHeight(1e-5)
			if not reverse then
				fg:SetPoint("BOTTOM")
				fg:SetPoint("LEFT")
				fg:SetPoint("RIGHT")
			
				extra:SetPoint("BOTTOM", fg, "TOP")
				extra:SetPoint("LEFT")
				extra:SetPoint("RIGHT")
			
				bg:SetPoint("BOTTOM", extra, "TOP")
				bg:SetPoint("LEFT")
				bg:SetPoint("RIGHT")
				bg:SetPoint("TOP")
			else
				fg:SetPoint("TOP")
				fg:SetPoint("LEFT")
				fg:SetPoint("RIGHT")
		
				extra:SetPoint("TOP", fg, "BOTTOM")
				extra:SetPoint("LEFT")
				extra:SetPoint("RIGHT")
		
				bg:SetPoint("TOP", extra, "BOTTOM")
				bg:SetPoint("LEFT")
				bg:SetPoint("RIGHT")
				bg:SetPoint("BOTTOM")
			end
		else
			fg:SetWidth(1e-5)
			if not reverse then
				fg:SetPoint("LEFT")
				fg:SetPoint("TOP")
				fg:SetPoint("BOTTOM")
			
				extra:SetPoint("LEFT", fg, "RIGHT")
				extra:SetPoint("TOP")
				extra:SetPoint("BOTTOM")
			
				bg:SetPoint("LEFT", extra, "RIGHT")
				bg:SetPoint("RIGHT")
				bg:SetPoint("TOP")
				bg:SetPoint("BOTTOM")
			else
				fg:SetPoint("RIGHT")
				fg:SetPoint("TOP")
				fg:SetPoint("BOTTOM")
		
				extra:SetPoint("RIGHT", fg, "LEFT")
				extra:SetPoint("TOP")
				extra:SetPoint("BOTTOM")
		
				bg:SetPoint("RIGHT", extra, "LEFT")
				bg:SetPoint("LEFT")
				bg:SetPoint("TOP")
				bg:SetPoint("BOTTOM")
			end
		end
		
		self:SetValue(self.value)
	end
	
	function FakeStatusBar_methods:SetOrientation(orientation)
		if self.orientation == orientation then
			return
		end
		self.orientation = orientation
		
		fixOrientation(self)
	end
	function FakeStatusBar_methods:GetOrientation()
		return self.orientation
	end
	
	function FakeStatusBar_methods:SetReverse(reverse)
		reverse = not not reverse
		if self.reverse == reverse then
			return
		end
		self.reverse = reverse
		
		fixOrientation(self)
	end
	function FakeStatusBar_methods:GetReverse()
		return self.reverse
	end

	function FakeStatusBar_methods:SetDeficit(deficit)
		deficit = not not deficit
		if self.deficit == deficit then
			return
		end
		self.deficit = deficit
		
		self:SetValue(self.value)
	end
	function FakeStatusBar_methods:GetDeficit()
		return self.deficit
	end

	function FakeStatusBar_methods:SetTexture(texture)
		self.fg:SetTexture(texture)
		self.extra:SetTexture(texture)
		self.bg:SetTexture(texture)
	end
	
	function FakeStatusBar_methods:GetTexture()
		return self.fg:GetTexture()
	end
	FakeStatusBar_methods.GetStatusBarTexture = FakeStatusBar_methods.GetTexture
	
	function FakeStatusBar_methods:SetColor(r, g, b)
		self.fg:SetVertexColor(r, g, b)
		if self.extraR then
			self.extra:SetVertexColor(self.extraR, self.extraG, self.extraB)
		else
			self.extra:SetVertexColor((r + 0.25)/1.5, (g + 0.25)/1.5, (b + 0.25)/1.5)
		end
		if self.bgR then
			self.bg:SetVertexColor(self.bgR, self.bgG, self.bgB)
		else
			self.bg:SetVertexColor((r + 0.2)/3, (g + 0.2)/3, (b + 0.2)/3)
		end
	end
	
	function FakeStatusBar_methods:GetColor()
		local r, g, b = self.fg:GetVertexColor()
		return r, g, b
	end
	FakeStatusBar_methods.GetStatusBarColor = FakeStatusBar_methods.GetColor
	
	function FakeStatusBar_methods:SetNormalAlpha(a)
		if not a then
			a = 1
		end
		self.fg:SetAlpha(a)
		if not self.extraA then
			self.extra:SetAlpha(a)
		end
		if not self.bgA then
			self.bg:SetAlpha(a)
		end
	end
	
	function FakeStatusBar_methods:GetNormalAlpha()
		return self.fg:GetAlpha()
	end
	
	function FakeStatusBar_methods:SetBackgroundColor(br, bg, bb)
		self.bgR, self.bgG, self.bgB = br or false, bg or false, bb or false
		if not br then
			local r, g, b = self.fg:GetVertexColor()
			self.bg:SetVertexColor((r + 0.2)/3, (g + 0.2)/3, (b + 0.2)/3)
		else
			self.bg:SetVertexColor(br, bg, bb)
		end
	end
	
	function FakeStatusBar_methods:GetBackgroundColor()
		local r, g, b = self.bg:GetVertexColor()
		return r, g, b
	end
	
	function FakeStatusBar_methods:SetBackgroundAlpha(a)
		if not a then
			a = self.fg:GetAlpha()
		else
			self.bgA = a
		end
		self.bg:SetAlpha(a)
	end
	
	function FakeStatusBar_methods:GetBackgroundAlpha()
		return self.bg or self.fg:GetAlpha()
	end
	
	function FakeStatusBar_methods:SetExtraColor(er, eg, eb)
		self.extraR, self.extraG, self.extraB = er or false, eg or false, eb or false
		if not er then
			local r, g, b = self.fg:GetVertexColor()
			self.extra:SetVertexColor((r + 0.25)/1.5, (g + 0.2)/1.5, (b + 0.25)/1.5)
		else
			self.extra:SetVertexColor(er, eg, eb)
		end
	end
	
	function FakeStatusBar_methods:GetExtraColor()
		return self.extra:GetVertexColor()
	end
	
	function FakeStatusBar_methods:SetExtraAlpha(a)
		if not a then
			a = self.fg:GetAlpha()
		else
			self.extraA = a
		end
		self.extra:SetAlpha(a)
	end
	
	function FakeStatusBar_methods:GetExtraAlpha()
		return self.extraA or self.fg:GetAlpha()
	end
	
	function FakeStatusBar_methods:GetMinMaxValues()
		return 0, 1
	end
	
	function FakeStatusBar_scripts:OnSizeChanged()
		self:SetValue(self.value)
	end
	
	newFrameType("FakeStatusBar", "Frame", function(frame)
		-- onCreate
		local frame_fg = newFrame("Texture", frame, "BACKGROUND")
		frame.fg = frame_fg
		frame_fg:SetPoint("LEFT")
		frame_fg:SetPoint("TOP")
		frame_fg:SetPoint("BOTTOM")
		
		local frame_extra = newFrame("Texture", frame, "BACKGROUND")
		frame.extra = frame_extra
		frame_extra:SetPoint("LEFT", frame_fg, "RIGHT")
		frame_extra:SetPoint("TOP")
		frame_extra:SetPoint("BOTTOM")
		
		local frame_bg = newFrame("Texture", frame, "BACKGROUND")
		frame.bg = frame_bg
		frame_bg:SetPoint("LEFT", frame_extra, "RIGHT")
		frame_bg:SetPoint("RIGHT")
		frame_bg:SetPoint("TOP")
		frame_bg:SetPoint("BOTTOM")
	end, function(frame)
		-- onRetrieve
		for k,v in pairs(FakeStatusBar_methods) do
			frame[k] = v
		end
		for k,v in pairs(FakeStatusBar_scripts) do
			frame:SetScript(k, v)
		end
		fixOrientation(frame)
		frame:SetColor(1, 1, 1)
		frame:SetNormalAlpha(1)
	end, function(frame)
		-- onDelete
		for k,v in pairs(FakeStatusBar_methods) do
			frame[k] = nil
		end	
		for k,v in pairs(FakeStatusBar_scripts) do
			frame:SetScript(k, nil)
		end
		frame:SetScript("OnUpdate", nil)
	end)
end

PitBull.new = newList
PitBull.newHash = newDict
PitBull.newSet = newSet
PitBull.del = del
PitBull.deepCopy = deepCopy
PitBull.deepDel = deepDel
PitBull.newFrame = newFrame
PitBull.newFrameType = newFrameType
PitBull.delFrame = delFrame

local frames = {}
local framesByUnit = {}
local framesByGroup = {}
local nonWackyFrames = {}
local allFrames = {}
local allFramesByGroup = {}
local allFramesByCluster = {}
local groupMenus = {}
local orderedGroupMenus = {}
local wackyFrames = {}
local metaLayout
local frameToModule = {}
local moduleOptionsMethods = {}
local clusters = {}

local moduleDependencies = {}

local lazyLayout = 0

local function isframe(frame)
	return type(frame) == "table" and type(rawget(frame, 0)) == "userdata" and type(frame.IsObjectType) == "function"
end

local ProfilePitBull

PitBull:SetDatabase("PitBullDB")
do
	local colors = {
		rage = { 226/255, 45/255, 75/255 },
		energy = { 1, 220/255, 25/255 },
		focus = { 1, 210/255, 0 },
		mana = { 48/255, 113/255, 191/255 },
		
		unknown = { 0.8, 0.8, 0.8 },
		
		hostile = { 226/255, 45/255, 75/255 },
		neutral = { 1, 1, 34/255 },
		friendly = { 0.2, 0.8, 0.15 },
		civilian = { 48/255, 113/255, 191/255 },
		
		dead = { 0.6, 0.6, 0.6 },
		disconnected = { 0.7, 0.7, 0.7 },
		inCombat = { 1, 0, 0 },
		resting = { 1, 1, 0 },
		tapped = { 0.5, 0.5, 0.5 },
		
		petHappy = { 0, 1, 0 },
		petNeutral = { 1, 1, 0 },
		petAngry = { 1, 0, 0 },
		
		frameBG = { 0, 0, 0, 0.5 },
		frameBorder = { 1, 0.7, 1, 1 },
		rare = { 0.7, 0.7, 0.7 },
		elite = { 1, 1, 0 },
		
		minHP = { 1, 0, 0 },
		midHP = { 1, 1, 0 },
		maxHP = { 0, 1, 0 },
	}
	
	for k, v in pairs(_G.RAID_CLASS_COLORS) do
		colors[k] = { v.r, v.g, v.b }
	end
	
	PitBull:SetDatabaseDefaults('account', {
		customLayouts = {}
	})
	
	PitBull:SetDatabaseDefaults('profile', {
		settings = {
			texture = "Blizzard",
			font = "Friz Quadrata TT",
			fontsize = 12,
			locked = false,
			clamped = true,
			colors = colors,
			hideTooltipInCombat = false,
			showEliteBorder = false,
			strata = "MEDIUM",
		},
		groups = {
			['**'] = {
				scale = 1,
				width = 200,
				height = 60,
				border = "None",
				hidden = false,
				direction = "down",
				spacing = 10,
				hspacing = 10,
				freeform = false,
			},
			player = {
			},
			target = {
			},
			targettarget = {
				height = 20,
			},
			targettargettarget = {
				height = 20,
				hidden = true,
			},
			pet = {
			},
			pettarget = {
			},
			party = {
				nameSort = false,
				square = false,
				hidePartyInRaid = true,
				showPlayerInParty = false,
			},
			partytarget = {
				square = false,
			},
			partypet = {
				square = false,
			},
			partypettarget = {
				hidden = true,
				square = false,
			},
			raid = {
				groupStyle = "group",
				nameSort = true,
				show5manAsParty = true,
				groupFilter = {
					['*'] = true,
				},
				classFilter = {
					['*'] = true,
				},
				hideInBG = {
					wsg = false,
					av = false,
					ab = false,
					eots = false,
				}
			},
			raidtarget = {
				hidden = true,
			},
			raidpet = {
				hidden = true,
			},
			mouseover = {
				hidden = true,
			},
			mouseovertarget = {
				hidden = true,
			},
			focus = {
			},
			focustarget = {
			},
			focustargettarget = {
				hidden = true,
			},
			maintank = {
				nameSort = false,
			},
			maintanktarget = {
			},
			maintanktargettarget = {
			},
			mainassist = {
				nameSort = false,
			},
			mainassisttarget = {
			},
			mainassisttargettarget = {
			},
		},
		units = {
			['*'] = {
				x = 0,
				y = 0,
			}
		},
		clusters = {
			['*'] = {
				x = 0,
				y = 0,
			}
		}
	})
end

local NumRaidMembers, NumPartyMembers = 0, 0

local function IsInNonRaidBG()
	local zone = GetRealZoneText()
	if zone == BZ["Warsong Gulch"] then
		return PitBull.db.profile.groups.raid.hideInBG.wsg
	elseif zone == BZ["Arathi Basin"] then
		return PitBull.db.profile.groups.raid.hideInBG.ab
	elseif zone == BZ["Alterac Valley"] then
		return PitBull.db.profile.groups.raid.hideInBG.av
	elseif zone == BZ["Eye of the Storm"] then
		return PitBull.db.profile.groups.raid.hideInBG.eots
	end
	return false
end

local function ShouldShowParty(dontCheckConfigMode)
	if configMode == "raid" and not dontCheckConfigMode then
		return not PitBull.db.profile.groups.party.hidePartyInRaid
	end
	if NumRaidMembers > 0 then
		if NumRaidMembers == NumPartyMembers+1 and PitBull.db.profile.groups.raid.show5manAsParty then
			return true
		end
		if IsInNonRaidBG() then
			return true
		end
		return not PitBull.db.profile.groups.party.hidePartyInRaid
	end
	if (configMode == "party" and not dontCheckConfigMode) or NumPartyMembers > 0 then
		return true
	end
	return false
end

local function ShouldShowRaid(dontCheckConfigMode)
	if configMode == "raid" and not dontCheckConfigMode then
		return true
	end
	if NumRaidMembers > 0 then
		if NumRaidMembers == NumPartyMembers+1 and PitBull.db.profile.groups.raid.show5manAsParty then
			return false
		end
		if IsInNonRaidBG() then
			return false
		end
		return true
	end
	return false
end

local function ShouldShowUnit(unit)
	if unit then
		if unit:find("^raid") or unit:find("^maintank") or unit:find("^mainassist") then
			return ShouldShowRaid()
		elseif unit:find("^party") then
			return ShouldShowParty()
		end
		return true
	end
end

local function GetRaidAssistMainTankNameList()
	local maintanktable
	if oRA then
		maintanktable = oRA.maintanktable
	else
		maintanktable = CT_RA_MainTanks
	end	
	if maintanktable then
		local t = newList()
		for i = 1, 10 do
			local v = maintanktable[i]
			if v then
				t[#t+1] = v
			end
		end
		local s = table.concat(t, ',')
		t = del(t)
		if s ~= "" then
			return s
		end
	end
end

local IsLegitimateUnit = {player=true,pet=true,target=true,focus=true,mouseover=true}
for i = 1, 4 do
	IsLegitimateUnit['party' .. i] = true
	IsLegitimateUnit['partypet' .. i] = true
end
for i = 1, 40 do
	IsLegitimateUnit['raid' .. i] = true
	IsLegitimateUnit['raidpet' .. i] = true
end
setmetatable(IsLegitimateUnit, {__index=function(self, unit)
	if not unit:find("target$") then
		self[unit] = false
		return false
	end
	local nonTarget = unit:sub(1, -7)
	local good = self[nonTarget]
	self[unit] = good
	return good
end})
PitBull.IsLegitimateUnit = IsLegitimateUnit

local IsWackyUnit = setmetatable({player=false, target=false, pet=false, mouseover=false}, {__index=function(self, unit)
	if not unit then
		error("Argument #1 to `IsWackyUnit' should be a string, got nil.", 2)
	end
	local party = unit:match("^party(%d)$") or unit:match("^partypet(%d)$")
	if party then
		party = tonumber(party)
		if party and party >= 1 and party <= 4 then
			self[unit] = false
			return false
		end
		self[unit] = true
		return true
	end
	local raid = unit:match("^raid(%d%d?)$")
	if raid then
		raid = tonumber(raid)
		if raid and raid >= 1 and raid <= 40 then
			self[unit] = false
			return false
		end
		self[unit] = true
		return true
	end
	self[unit] = true
	return true
end})
PitBull.IsWackyUnit = IsWackyUnit
local IsWackyGroup = setmetatable({player=false, target=false, pet=false, mouseover=false, party=false, partypet=false, raid=false, maintank=false, mainassist=false}, {__index=function(self, group)
	self[group] = true
	return true
end})
PitBull.IsWackyGroup = IsWackyGroup

local GroupToLocale = {player = L["Player"], target = L["Target"], pet = L["Player's pet"], party = L["Party"], party_sing = L["Party"], partypet = L["Party pets"], partypet_sing = L["Party pet"], raid = L["Raid"], raid_sing = L["Raid"], raidpet = L["Raid pets"], raidpet_sing = L["Raid pet"], mouseover = L["Mouse-over"], focus = L["Focus"], maintank = L["Main tanks"], maintank_sing = L["Main tank"], mainassist = L["Main assists"], mainassist_sing = L["Main assist"]}
setmetatable(GroupToLocale, {__index=function(self, group)
	local nonTarget
	local singular = false
	if group:find("target$") then
		nonTarget = group:sub(1, -7)
	elseif group:find("target_sing$") then
		singular = true
		nonTarget = group:sub(1, -12)
	else
		self[group] = group
		return group
	end
	local good
	if group:find("^player") or group:find("^pet") or group:find("^mouseover") or group:find("^target") or group:find("^focus") then
		good = L["%s's target"]:format(self[nonTarget])
	elseif singular then
		good = L["%s target"]:format(self[nonTarget .. "_sing"])
	else
		good = L["%s targets"]:format(self[nonTarget .. "_sing"])
	end
	self[group] = good
	return good
end})
PitBull.GroupToLocale = GroupToLocale

local initCustomLayouts
function PitBull:OnInitialize()
	assert(metaLayout, "Error, Meta-layout not provided.")
	if not self.db.account.firstTimeWoW21 then
		self.db.account.firstTimeWoW21 = true
		SetCVar("scriptErrors", "1")
	end
	self.colorConstants = self.db.profile.settings.colors
	
	if not self:IsActive() then
		self:ToggleActive(true)
	end

	initCustomLayouts()
	
	if metaLayout.OnInitialize then
		metaLayout:OnInitialize()
	end
	
	self:SetCommPrefix("Pit")
	self:AddCommListener("Pit", "GUILD")
	self:AddCommListener("Pit", "GROUP")
	self:AddCommListener("Pit", "WHISPER")
	
	self:SetConfigTable(self.options)
	self:SetConfigSlashCommand("/PitBull", "/Pit")
	self.options.extraArgs.active = nil
end

PitBull.OnCommReceive = {}

local removableLayoutNames = {}

local AddGroupToAceOptions_todo = {}
local UpdateLayoutSettings_todo = {}
local ProfilePitBull_open = false
local options = setmetatable({}, {__mode='v'})
do
	local function colorSet(key, r, g, b, a)
		local t = self.db.profile.settings.colors[key]
		t[1] = r
		t[2] = g
		t[3] = b
		t[4] = a
		self:UpdateAll()
	end

	local function colorGet(key)
		return unpack(self.db.profile.settings.colors[key])
	end
	
	local function get_Active(name)
		if self:HasModule(name) then
			return self:IsModuleActive(name)
		else
			return false
		end
	end
	local function set_Active(name, value)
		if not self:HasModule(name) then
			local _,_,_,enabled,loadable = GetAddOnInfo("PitBull_" .. name)
			if not enabled and value then
				EnableAddOn("PitBull_" .. name)
				_,_,_,enabled,loadable = GetAddOnInfo("PitBull_" .. name)
				if not loadable then
					DisableAddOn("PitBull_" .. name)
				end
			end
			if enabled and loadable then
				LoadAddOn("PitBull_" .. name)
			else
				return
			end
		end
		self:ToggleModuleActive(name, value)
	end
	
	local sendToPlayerName
	
	local moduleArgs = setmetatable({}, {__index=function(self,key)
		local desc
		if PitBull:HasModule(key) then
			desc = PitBull:GetModule(key).desc
		end
		if not desc then
			desc = GetAddOnMetadata("PitBull_" .. key, "Notes")
		end
		if not desc then
			desc = key
		end
		self[key] = {
			type = 'boolean',
			name = key,
			desc = desc,
			passValue = key,
			get = get_Active,
			set = set_Active,
			disabled = InCombatLockdown,
		}
		return self[key]
	end, __mode='kv'})
	
	local globalSettings = {}
	function PitBull:RegisterGlobalSetting(...)
		if type(options.args) == "table" then
			local current = options.args.global.args
			local n = select('#', ...)
			for i = 1, n - 2 do
				local v = select(i, ...)
				current = current[v]
			end
			current[select(n-1, ...)] = select(n, ...)
			return
		end
		local path = newList(...)
		path[#path] = nil
		local data = select(select('#', ...), ...)
		globalSettings[path] = data
	end
	
	local recurseCheck
	PitBull.options = {
		type = 'group',
		name = L["PitBull"],
		desc = L["Unit Frames of awesomeness. Woof. It'll bite your face off."],
		handler = PitBull,
		icon = [[Interface\Addons\PitBull\media\icon]],
		args = function()
			local args; args = {
				modules = {
					name = L["Modules"],
					desc = L["Modules"],
					type = 'group',
					args = function()
						local args = newList()
						for i = 1, GetNumAddOns() do
							local deps = newSet(GetAddOnDependencies(i))
							if deps["PitBull"] and IsAddOnLoadOnDemand(i) then
								local name = GetAddOnInfo(i)
								if name:find("^PitBull_") then
									local modName = name:sub(9)
									local condition = GetAddOnMetadata(name, "X-PitBull-Condition")
									local good = true
									if condition then
										local func, err = loadstring(condition)
										if func then
											local success, ret = pcall(func)
											if success then
												good = ret
											end
										end
									end
									if good then
										args[modName] = moduleArgs[modName]
									end
								end
							end
							deps = del(deps)
						end
						for name in PitBull:IterateModules() do
							args[name] = moduleArgs[name]
						end
						return "@dict", unpackDictAndDel(args)
					end,
					order = 3,
				},
				disabledUnits = {
					name = L["Extra units"],
					desc = L["List of units which are not currently enabled. Click one to enable it."],
					type = "group",
					args = {},
					disabled = function() return not next(args.disabledUnits.args) end,
					order = 5,
				},
	--			spacer = {
	--				name = L[" "],
	--				type = "header",
	--				order = 45,
	--			},
				configMode = {
					name = L["Configuration mode"],
					desc = L["Show all frames that can be shown, for easy configuration."],
					type = 'choice',
					choices = function()
						if ShouldShowParty(true) then
							return '@dict', 'party', L["Party"], 'disabled', L["Disabled"]
						elseif ShouldShowRaid(true) then
							return '@dict', 'raid', L["Raid"], 'disabled', L["Disabled"]
						else
							return '@dict', 'raid', L["Raid"], 'party', L["Party"], 'solo', L["Solo"], 'disabled', L["Disabled"]
						end
					end,
					choiceOrder = function()
						if ShouldShowParty(true) then
							return '@list', 'disabled', 'party'
						elseif ShouldShowRaid(true) then
							return '@list', 'disabled', 'raid'
						else
							return '@list', 'disabled', 'solo', 'party', 'raid'
						end
					end,
					get = function()
						return configMode or "disabled"
					end,
					set = "ChangeConfigMode",
					handler = self,
					disabled = InCombatLockdown,
					order = 2,
				},
				layout = {
					name = L["Layouts"],
					desc = L["Choose layout options here."],
					type = 'group',
					args = {
						import = {
							name = L["Import layout"],
							desc = L["Import a layout from an external source."],
							buttonText = L["Import"],
							type = 'execute',
							func = "OpenImportLayoutFrame",
							handler = PitBull,
							order = 50,
						},
						export = {
							name = L["Export layout"],
							desc = L["Export a specified layout."],
							type = 'choice',
							choices = removableLayoutNames,
							get = false,
							set = "ExportLayout",
							disabled = function()
								return not next(removableLayoutNames)
							end,
							handler = PitBull,
							order = 51,
						},
						remove = {
							name = L["Remove"],
							desc = L["Remove a layout you no longer wish to use."],
							type = 'choice',
							choices = removableLayoutNames,
							get = false,
							set = "RemoveLayout",
							disabled = function()
								return not next(removableLayoutNames)
							end,
							handler = PitBull,
							order = 52,
						},
						sendTo = {
							name = L["Send in-game"],
							desc = L["Send a saved layout to a friend in-game."],
							type = 'group',
							disabled = function()
								return not next(removableLayoutNames)
							end,
							args = {
								whisper = {
									name = L["Send to specific player"],
									desc = L["Send a saved layout to a specific player."],
									type = 'group',
									args = {
										player = {
											name = L["Name of player"],
											desc = L["The name of the player you wish to send the layout to."],
											type = 'string',
											usage = "<Name of player>",
											get = function()
												return sendToPlayerName
											end,
											set = function(value)
												sendToPlayerName = value
											end,
										},
										layout = {
											name = L["Layout"],
											desc = L["The layout to send."],
											type = 'choice',
											choices = removableLayoutNames,
											get = false,
											set = function(...)
												PitBull:SendLayoutToPlayer(sendToPlayerName, ...)
											end,
											disabled = function()
												return not sendToPlayerName
											end
										}
									}
								},
								guild = {
									name = L["Send to guild"],
									desc = L["Send a saved layout to your guild."],
									disabled = function()
										return not IsInGuild()
									end,
									type = 'choice',
									choices = removableLayoutNames,
									get = false,
									set = "SendLayoutToGuild",
									handler = PitBull,
								},
								group = {
									name = L["Send to group"],
									desc = L["Send a saved layout to your party or raid."],
									disabled = function()
										return GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0
									end,
									type = 'choice',
									choices = removableLayoutNames,
									get = false,
									set = "SendLayoutToGroup",
									handler = PitBull,
								},
							}
						}
					},
					order = 4,
				},
				global = {
					order = 1,
					name = L["Global settings"],
					desc = L["Settings that apply to all PitBull frames."],
					type = "group",
					args = {
						texture = {
							name = L["StatusBar texture"],
							desc = L["Sets what texture to use for the statusbars, like health, power, and cast bar."],
							type = 'choice',
							choices = SharedMedia:List('statusbar'),
							choiceTextures = SharedMedia:HashTable('statusbar'),
							get = function()
								return self.db.profile.settings.texture
							end,
							set = function(value)
								self.db.profile.settings.texture = value
								self:UpdateAllStatusBarTextures()
							end,
						},
						font = {
							type = "group",
							name = L["Font"],
							desc = L["Font settings."],
							args = {
								fonttype = {
									name = L["Type"],
									desc = L["What font face to use."],
									type = 'choice',
									choices = SharedMedia:List('font'),
									choiceFonts = SharedMedia:HashTable('font'),
									get = function()
										return self.db.profile.settings.font
									end,
									set = function(value)
										self.db.profile.settings.font = value
										self:UpdateAllFonts()
									end,
								},
								fontsize = {
									name = L["Size"],
									desc = L["Font size."],
									type = 'number',
									get = function()
										return self.db.profile.settings.fontsize
									end,
									set = function(value)
										self.db.profile.settings.fontsize = value
										self:UpdateAllFonts()
									end,
									min = 8,
									max = 32,
									step = 1,
								},
							},
						},			
						locked = {
							name = L["Locked"],
							desc = L["Make it so the frames cannot be moved"],
							type = 'boolean',
							get = function()
								return self.db.profile.settings.locked
							end,
							set = function(value)
								self.db.profile.settings.locked = value
							end,
						},
						strata = {
							name = L["Frame Strata"],
							desc = L["Choose the layer the unit frames are located on."],
							type = 'text',
							validate = {
								L["Background"],
								L["Low"],
								L["Medium"],
								L["High"],
								L["Dialog"],
								L["Tooltip"],
							},
							get = function()
								local strata = self.db.profile.settings.strata
								if strata == "BACKGROUND" then
									return L["Background"]
								elseif strata == "LOW" then
									return L["Low"]
								elseif strata == "MEDIUM" then
									return L["Medium"]
								elseif strata == "HIGH" then
									return L["High"]
								elseif strata == "DIALOG" then
									return L["Dialog"]
								elseif strata == "TOOLTIP" then
									return L["Tooltip"]
								else
									return strata
								end
							end,
							set = function(value)
								local strata = "MEDIUM"
								if value == L["Background"] then
									strata = "BACKGROUND"
								elseif value == L["Low"] then
									strata = "LOW"
								elseif value == L["Medium"] then
									strata = "MEDIUM"
								elseif value == L["High"] then
									strata = "HIGH"
								elseif value == L["Dialog"] then
									strata = "DIALOG"
								elseif value == L["Tooltip"] then
									strata = "TOOLTIP"
								end
								self.db.profile.settings.strata = strata
								PitBull:UpdateAllFrameStratas()
							end,
							disabled = InCombatLockdown,
						},
						clamped = {
							name = L["Clamp frames to screen"],
							desc = L["Make it so that frames cannot be dragged off-screen."],
							type = 'boolean',
							get = "AreUnitFramesClampedToScreen",
							set = "ToggleUnitFramesClampedToScreen",
							handler = self,
							disabled = InCombatLockdown,
						},
						hideTooltipInCombat = {
							name = L["Hide tooltips in combat"],
							desc = L["Hides the unit frame tooltips while the player is in combat."],
							type = 'boolean',
							get = function()
								return self.db.profile.settings.hideTooltipInCombat
							end,
							set = function(value)
								self.db.profile.settings.hideTooltipInCombat = value
							end,
						},
						showEliteBorder = {
							name = L["Show colored border on elite or rare unit"],
							desc = L["Show a border specifically colored for an elite or rare unit, otherwise use the standard border."],
							type = 'boolean',
							get = function()
								return self.db.profile.settings.showEliteBorder
							end,
							set = function(value)
								self.db.profile.settings.showEliteBorder = value
								self:UpdateAllBackdropsAndBorders(true)
							end,
						},
						colors = {
							name = L["Colors"],
							desc = L["Colors"],
							type = 'group',
							args = {
								power = {
									name = L["Power"],
									desc = L["Power"],
									type = 'group',
									child_get = colorGet,
									child_set = colorSet,
									child_type = 'color',
									args = {
										rage = {
											name = L["Rage"],
											desc = L["Rage"],
											passValue = 'rage',
										},
										mana = {
											name = L["Mana"],
											desc = L["Mana"],
											passValue = 'mana',
										},
										focus = {
											name = L["Focus(Pet)"],
											desc = L["Focus(Pet)"],
											passValue = 'focus',
										},
										energy = {
											name = L["Energy"],
											desc = L["Energy"],
											passValue = 'energy',
										},
									}
								},
								class = {
									name = L["Classes"],
									desc = L["Classes"],
									type = 'group',
									child_get = colorGet,
									child_set = colorSet,
									child_type = 'color',
									args = {
										WARLOCK = {
											name = L["Warlock"],
											desc = L["Warlock"],
											passValue = 'WARLOCK',
										},
										PRIEST = {
											name = L["Priest"],
											desc = L["Priest"],
											passValue = 'PRIEST',
										},
										WARRIOR = {
											name = L["Warrior"],
											desc = L["Warrior"],
											passValue = 'WARRIOR',
										},
										PALADIN = {
											name = L["Paladin"],
											desc = L["Paladin"],
											passValue = 'PALADIN',
										},
										SHAMAN = {
											name = L["Shaman"],
											desc = L["Shaman"],
											passValue = 'SHAMAN',
										},
										MAGE = {
											name = L["Mage"],
											desc = L["Mage"],
											passValue = 'MAGE',
										},
										DRUID = {
											name = L["Druid"],
											desc = L["Druid"],
											passValue = 'DRUID',
										},
										ROGUE = {
											name = L["Rogue"],
											desc = L["Rogue"],
											passValue = 'ROGUE',
										},
										HUNTER = {
											name = L["Hunter"],
											desc = L["Hunter"],
											passValue = 'HUNTER',
										},
									}
								},
								reaction = {
									name = L["Reaction"],
									desc = L["Reaction"],
									type = 'group',
									child_get = colorGet,
									child_set = colorSet,
									child_type = 'color',
									args = {
										hostile = {
											color = 90,
											name = L["Hostile"],
											desc = L["Hostile"],
											passValue = 'hostile',
										},
										neutral = {
											color = 91,
											name = L["Neutral"],
											desc = L["Neutral"],
											passValue = 'neutral',
										},
										friendly = {
											color = 92,
											name = L["Friendly"],
											desc = L["Friendly"],
											passValue = 'friendly',
										},
										civilian = {
											color = 93,
											name = L["Civilian"],
											desc = L["Civilian"],
											passValue = 'civilian',
										},
									}
								},
								petHappiness = {
									name = L["Pet happiness"],
									desc = L["Pet happiness"],
									type = 'group',
									child_get = colorGet,
									child_set = colorSet,
									child_type = 'color',
									args = {
										petHappy = {
											order = 90,
											name = L["Happy"],
											desc = L["Happy"],
											passValue = 'petHappy',
										},
										petNeutral = {
											order = 91,
											name = L["Neutral(Pet)"],
											desc = L["Neutral(Pet)"],
											passValue = 'petNeutral',
										},
										petAngry = {
											order = 92,
											name = L["Angry"],
											desc = L["Angry"],
											passValue = 'petAngry',
										},
									}
								},
								health = {
									name = L["Health gradient"],
									desc = L["Health gradient"],
									type = 'group',
									child_get = colorGet,
									child_set = colorSet,
									child_type = 'color',
									args = {
										minHP = {
											order = 90,
											name = L["No health"],
											desc = L["No health"],
											passValue = 'minHP',
										},
										midHP = {
											order = 91,
											name = L["50% health"],
											desc = L["50% health"],
											passValue = 'midHP',
										},
										maxHP = {
											order = 92,
											name = L["Maximum health"],
											desc = L["Maximum health"],
											passValue = 'maxHP',
										}
									}
								},
								other = {
									name = L["Other"],
									desc = L["Other"],
									type = 'group',
									child_get = colorGet,
									child_set = colorSet,
									child_type = 'color',
									args = {
										dead = {
											name = L["Dead or Ghost"],
											desc = L["Dead or Ghost"],
											passValue = 'dead',
										},
										disconnected = {
											name = L["Disconnected"],
											desc = L["Disconnected"],
											passValue = 'disconnected',
										},
										inCombat = {
											name = L["In combat"],
											desc = L["In combat"],
											passValue = 'inCombat',
										},
										resting = {
											name = L["Resting"],
											desc = L["Resting"],
											passValue = 'resting',
										},
										tapped = {
											name = L["Tapped"],
											desc = L["Tapped"],
											passValue = 'tapped',
										},
										unknown = {
											name = L["Unknown"],
											desc = L["Unknown"],
											passValue = 'unknown',
										},
									}
								},
								frame = {
									name = L["Frame colors"],
									desc = L["Frame colors"],
									type = 'group',
									args = {
										background = {
											name = L["Background"],
											desc = L["Background"],
											type = 'color',
											get = function()
												return unpack(self.db.profile.settings.colors.frameBG)
											end,
											set = function(r, g, b, a)
												local t = self.db.profile.settings.colors.frameBG
												t[1] = r
												t[2] = g
												t[3] = b
												t[4] = a
												self:UpdateAllBackdropsAndBorders(true)
											end,
											hasAlpha = true,
										},
										border = {
											name = L["Border"],
											desc = L["Border"],
											type = 'color',
											get = function()
												return unpack(self.db.profile.settings.colors.frameBorder)
											end,
											set = function(r, g, b, a)
												local t = self.db.profile.settings.colors.frameBorder
												t[1] = r
												t[2] = g
												t[3] = b
												t[4] = a
												self:UpdateAllBackdropsAndBorders(true)
											end,
											hasAlpha = true,
										},
										rare = {
											name = L["Rare"],
											desc = L["Rare"],
											type = 'color',
											get = function()
												return unpack(self.db.profile.settings.colors.rare)
											end,
											set = function(r, g, b)
												local t = self.db.profile.settings.colors.rare
												t[1] = r
												t[2] = g
												t[3] = b
												self:UpdateAllBackdropsAndBorders(true)
											end,
										},
										elite = {
											name = L["Elite"],
											desc = L["Elite"],
											type = 'color',
											get = function()
												return unpack(self.db.profile.settings.colors.elite)
											end,
											set = function(r, g, b)
												local t = self.db.profile.settings.colors.elite
												t[1] = r
												t[2] = g
												t[3] = b
												self:UpdateAllBackdropsAndBorders(true)
											end,
										},
									},
								},
							},
						},
					},
				},
			}
			options.args = args
			for path, data in pairs(globalSettings) do
				local current = args.global.args
				for i = 1, #path-1 do
					local v = path[i]
					current = current[v]
				end
				current[path[#path]] = data
			end
			for group in pairs(AddGroupToAceOptions_todo) do
				PitBull:AddGroupToAceOptions(group)
			end
			for group in pairs(UpdateLayoutSettings_todo) do
				PitBull:UpdateLayoutSettings(group)
			end
		
			local nextCheck = 0
			local allUnits_args; allUnits_args = {
				other = {
					type = 'group',
					name = L["Other"],
					desc = L["Other options."],
					order = 50,
					args = function()
						allUnits_args.other = nil
						args.allUnits.args = function()
							if nextCheck <= GetTime() then
								nextCheck = GetTime() + 5
								for _, group in ipairs(orderedGroupMenus) do
									recurseCheck(args[group].args, allUnits_args)
								end
							end
							return allUnits_args
						end
						args.allUnits.args()
						local RockConfig = Rock("LibRockConfig-1.0")
						self:AddTimer(0, RockConfig.RefreshConfigMenu, RockConfig, self)
						return {}
					end
				}
			}
			args.allUnits = {
				name = L["All units"],
				desc = L["Change settings for all units."],
				type = 'group',
				order = 49,
				args = allUnits_args,
			}
			return "@cache", args
		end
	}
	
	local convertSingleToMultiple
	do
		local function findPath(...)
			local opt = options
			for i = 1, select('#', ...) do
				local args = opt.args
				opt = type(args) == "table" and args[select(i, ...)]
				if not opt then
					return nil
				end
			end
			return opt
		end

		local function unpackPlus(t, start, val)
			if not val then
				val = start
				start = 1
			end
			if start > #t then
				return val
			end
			return t[start], unpackPlus(t, start+1, val)
		end

		local function select2(start, finish, ...)
			if start > finish then
				return
			end
			return (...), select2(start+1, finish, ...)
		end

		local function figureHandler(...)
			local n = select('#', ...)
			if n == 0 then
				return nil
			end
			local opt = findPath(...)
			if opt.handler then
				return opt.handler
			end
			return figureHandler(select2(1, n-1, ...))
		end

		local function figurePassValue(t, ...)
			local i = 0
			while true do
				i = i + 1
				local k = "passValue"
				if i > 1 then
					k = k .. i
				end
				for _ = 1, 1 do
					local opt = findPath(...)
					if opt[k] then
						t[#t+1] = opt[k]
						break
					end
					opt = findPath(select2(1, select('#', ...)-1, ...))
					if not opt then
						return
					end
					if opt["child_" .. k] then
						t[#t+1] = opt["child_" .. k]
						break
					end
					if i == 1 and opt.pass then
						t[#t+1] = select(select('#', ...), ...)
						break
					end
					return
				end
			end
			return
		end

		local function figurePassFunc(funcName, ...)
			local opt = findPath(...)
			if opt[funcName] then
				return opt[funcName]
			end
			opt = findPath(select2(1, select('#', ...)-1, ...))
			if not opt then
				return nil
			end
			if opt.pass then
				return opt[funcName]
			end
			return nil
		end

		local function figureSimpleFunc(funcName, ...)
			local opt = findPath(...)
			if opt and opt[funcName] then
				local t = newList()
				local func
				if type(opt[funcName]) == "string" then
					local handler = figureHandler(...)
					func = handler[opt[funcName]]
					t[#t+1] = handler
				else
					func = opt[funcName]
				end
				if type(func) == "boolean" then
					return func
				end
				figurePassValue(t, ...)
				local value = func(unpack(t))
				t = del(t)
				if value then
					return true
				end
			end
			return false
		end

		local function figureHiddenOrDisabled(...)
			return figureSimpleFunc('hidden', ...) or figureSimpleFunc('disabled', ...)
		end

		function convertSingleToMultiple(k, v, ...)
			local path = newList(...)
			local function disabled()
				for _, group in ipairs(orderedGroupMenus) do
					if figureSimpleFunc('disabled', group, unpackPlus(path, k)) then
						return true
					end
				end
				return false
			end
			local function hidden()
				for _, group in ipairs(orderedGroupMenus) do
					if figureSimpleFunc('hidden', group, unpackPlus(path, k)) then
						return true
					end
				end
				return false
			end
			local function wrapFunction(kind)
				return function()
					for _, group in ipairs(orderedGroupMenus) do
						local p = findPath(group, unpackPlus(path, k))
						if p then
							local value = p[kind]
							if type(value) == "function" then
								local t = newList()
								figurePassValue(t, group, unpackPlus(path, k))
								value = newList(value(unpack(t)))
								t = del(t)
								return unpackListAndDel(value)
							end
							return value
						end
					end
					return nil
				end
			end
			if v.type == 'boolean' then
				local function get()
					for _, group in ipairs(orderedGroupMenus) do
						local opt = findPath(group, unpackPlus(path, k))
						if opt then
							local get = figurePassFunc('get', group, unpackPlus(path, k))
							if get then
								local t = newList()
								if type(get) == "string" then
									local handler = figureHandler(group, unpackPlus(path, k))
									get = handler[get]
									t[#t+1] = handler
								end
								figurePassValue(t, group, unpackPlus(path, k))
								local value = get(unpack(t))
								t = del(t)
								if not value then
									return false
								end
							end
						end
					end
					return true
				end
				local function set(value)
					for _, group in ipairs(orderedGroupMenus) do
						if not figureHiddenOrDisabled(group, unpackPlus(path, k)) then
							local opt = findPath(group, unpackPlus(path, k))
							if opt then
								local get = figurePassFunc('get', group, unpackPlus(path, k))
								if get then
									local t = newList()
									if type(get) == "string" then
										local handler = figureHandler(group, unpackPlus(path, k))
										get = handler[get]
										t[#t+1] = handler
									end
									figurePassValue(t, group, unpackPlus(path, k))
									local old_value = get(unpack(t))
									t = del(t)
									if not value ~= not old_value then
										t = newList()
										local set = figurePassFunc('set', group, unpackPlus(path, k))
										if type(set) == "string" then
											local handler = figureHandler(group, unpackPlus(path, k))
											set = handler[set]
											t[#t+1] = handler
										end
										figurePassValue(t, group, unpackPlus(path, k))
										t[#t+1] = value
										set(unpack(t))
										t = del(t)
									end
								end
							end
						end
					end
				end
				return {
					type = 'boolean',
					name = wrapFunction("name"),
					desc = wrapFunction("desc"),
					get = get,
					set = set,
					order = v.order,
					map = v.map,
					message = v.message,
					current = v.current,
					isRadio = v.isRadio,
					guiNameIsMap = v.guiNameIsMap,
					disabled = disabled,
					hidden = hidden,
				}
			elseif v.type == 'header' then	
				return v
			elseif v.type == 'string' or v.type == 'choice' or v.type == 'multichoice' or v.type == 'keybinding' then
				local function get(...)
					for _, group in ipairs(orderedGroupMenus) do
						local opt = findPath(group, unpackPlus(path, k))
						if opt then
							local get = figurePassFunc('get', group, unpackPlus(path, k))
							if get then
								local t = newList()
								if type(get) == "string" then
									local handler = figureHandler(group, unpackPlus(path, k))
									get = handler[get]
									t[#t+1] = handler
								end
								figurePassValue(t, group, unpackPlus(path, k))
								for i = 1, select('#', ...) do
									t[#t+1] = select(i, ...)
								end
								local value = get(unpack(t))
								t = del(t)
								return value
							end
						end
					end
				end
				local function set(...)
					for _, group in ipairs(orderedGroupMenus) do
						if not figureHiddenOrDisabled(group, unpackPlus(path, k)) then
							local opt = findPath(group, unpackPlus(path, k))
							if opt then
								local get = figurePassFunc('get', group, unpackPlus(path, k))
								if get then
									local t = newList()
									if type(get) == "string" then
										local handler = figureHandler(group, unpackPlus(path, k))
										get = handler[get]
										t[#t+1] = handler
									end
									figurePassValue(t, group, unpackPlus(path, k))
									for i = 1, select('#', ...)-1 do
										t[#t+1] = select(i, ...)
									end
									local old_value = get(unpack(t))
									t = del(t)
									if not value ~= not old_value then
										t = newList()
										local set = figurePassFunc('set', group, unpackPlus(path, k))
										if type(opt.set) == "string" then
											local handler = figureHandler(group, unpackPlus(path, k))
											set = handler[set]
											t[#t+1] = handler
										end
										figurePassValue(t, group, unpackPlus(path, k))
										for i = 1, select('#', ...) do
											t[#t+1] = select(i, ...)
										end
										set(unpack(t))
										t = del(t)
									end
								end
							end
						end
					end
				end
				local syntaxHighlighter, multiline
				if v.type == 'string' then
					function syntaxHighlighter(...)
						for _, group in ipairs(orderedGroupMenus) do
							if not figureHiddenOrDisabled(group, unpackPlus(path, k)) then
								local opt = findPath(group, unpackPlus(path, k))
								if opt then
									local syntaxHighlighter = figurePassFunc('syntaxHighlighter', group, unpackPlus(path, k))
									if syntaxHighlighter then
										local t = newList()
										if type(syntaxHighlighter) == "string" then
											local handler = figureHandler(group, unpackPlus(path, k))
											syntaxHighlighter = handler[syntaxHighlighter]
											t[#t+1] = handler
										end
										figurePassValue(t, group, unpackPlus(path, k))
										for i = 1, select('#', ...) do
											t[#t+1] = select(i, ...)
										end
										local value = syntaxHighlighter(unpack(t))
										t = del(t)
										return value
									end
								end
							end
						end
					end
					function multiline()
						for _, group in ipairs(orderedGroupMenus) do
							return figureSimpleFunc('multiline', group, unpackPlus(path, k))
						end
					end
				end
				return {
					type = v.type,
					name = wrapFunction("name"),
					desc = wrapFunction("desc"),
					input = v.input,
					validate = v.validate,
					validateDesc = v.validateDesc,
					choices = wrapFunction("choices"),
					choiceDescs = wrapFunction("choiceDescs"),
					choiceFonts = wrapFunction("choiceFonts"),
					choiceIcons = wrapFunction("choiceIcons"),
					choiceIconSizes = wrapFunction("choiceIconSizes"),
					keybindingOnly = v.keybindingOnly,
					keybindingExcept = v.keybindingExcept,
					syntaxHighlighter = syntaxHighlighter,
					multiline = multiline,
					usage = v.usage,
					error = v.error,
					message = v.message,
					current = v.current,
					icon = v.icon,
					iconSize = v.iconSize,
					order = v.order,
					get = get,
					set = set,
					disabled = disabled,
					hidden = hidden,
				}
			elseif v.type == 'number' then
				local function get(...)
					for _, group in ipairs(orderedGroupMenus) do
						local opt = findPath(group, unpackPlus(path, k))
						if opt then
							local get = figurePassFunc('get', group, unpackPlus(path, k))
							if get then
								local t = newList()
								if type(get) == "string" then
									local handler = figureHandler(group, unpackPlus(path, k))
									get = handler[get]
									t[#t+1] = handler
								end
								figurePassValue(t, group, unpackPlus(path, k))
								for i = 1, select('#', ...) do
									t[#t+1] = select(i, ...)
								end
								local value = get(unpack(t))
								t = del(t)
								return value
							end
						end
					end
				end
				local function set(...)
					lazyLayout = lazyLayout + 1
					for _, group in ipairs(orderedGroupMenus) do
						if not figureHiddenOrDisabled(group, unpackPlus(path, k)) then
							local opt = findPath(group, unpackPlus(path, k))
							if opt then
								local get = figurePassFunc('get', group, unpackPlus(path, k))
								if get then
									local t = newList()
									if type(get) == "string" then
										local handler = figureHandler(group, unpackPlus(path, k))
										get = handler[get]
										t[#t+1] = handler
									end
									figurePassValue(t, group, unpackPlus(path, k))
									for i = 1, select('#', ...)-1 do
										t[#t+1] = select(i, ...)
									end
									local old_value = get(unpack(t))
									t = del(t)
									if old_value ~= select(select('#', ...), ...) then
										t = newList()
										local set = figurePassFunc('set', group, unpackPlus(path, k))
										if type(set) == "string" then
											local handler = figureHandler(group, unpackPlus(path, k))
											set = handler[set]
											t[#t+1] = handler
										end
										figurePassValue(t, group, unpackPlus(path, k))
										for i = 1, select('#', ...) do
											t[#t+1] = select(i, ...)
										end
										set(unpack(t))
										t = del(t)
									end
								end
							end
						end
					end
					lazyLayout = lazyLayout - 1
					self:AddTimer("PitBull-UpdateLayouts", 0, "_UpdateLayouts")
				end
				return {
					type = 'number',
					name = wrapFunction("name"),
					desc = wrapFunction("desc"),
					order = v.order,
					min = v.min,
					max = v.max,
					step = v.step,
					bigStep = v.bigStep,
					stepBasis = v.stepBasis,
					isPercent = v.isPercent,
					error = v.error,
					message = v.message,
					current = v.current,
					icon = v.icon,
					iconWidth = v.iconWidth,
					iconHeight = v.iconHeight,
					order = v.order,
					get = get,
					set = set,
					disabled = disabled,
					hidden = hidden,
				}
			elseif v.type == "color" then
				local function get(...)
					for _, group in ipairs(orderedGroupMenus) do
						local opt = findPath(group, unpackPlus(path, k))
						if opt then
							local get = figurePassFunc('get', group, unpackPlus(path, k))
							if get then
								local t = newList()
								if type(get) == "string" then
									local handler = figureHandler(group, unpackPlus(path, k))
									get = handler[get]
									t[#t+1] = handler
								end
								figurePassValue(t, group, unpackPlus(path, k))
								for i = 1, select('#', ...) do
									t[#t+1] = select(i, ...)
								end
								local r, g, b, a = get(unpack(t))
								t = del(t)
								return r, g, b, a
							end
						end
					end
				end
				local function set(...)
					for _, group in ipairs(orderedGroupMenus) do
						if not figureHiddenOrDisabled(group, unpackPlus(path, k)) then
							local opt = findPath(group, unpackPlus(path, k))
							if opt then
								local set = figurePassFunc('set', group, unpackPlus(path, k))
								if set then
									t = newList()
									if type(set) == "string" then
										local handler = figureHandler(group, unpackPlus(path, k))
										set = handler[set]
										t[#t+1] = handler
									end
									figurePassValue(t, group, unpackPlus(path, k))
									for i = 1, select('#', ...) do
										t[#t+1] = select(i, ...)
									end
									set(unpack(t))
									t = del(t)
								end
							end
						end
					end
				end
				return {
					type = 'color',
					name = wrapFunction("name"),
					desc = wrapFunction("desc"),
					order = v.order,
					hasAlpha = v.hasAlpha,
					colorType = v.colorType,
					error = v.error,
					message = v.message,
					current = v.current,
					order = v.order,
					get = get,
					set = set,
					disabled = disabled,
					hidden = hidden,
				}
			elseif v.type == "group" then
				local t; t = {
					type = 'group',
					groupType = v.groupType,
					name = wrapFunction("name"),
					desc = wrapFunction("desc"),
					args = function()
						local t_args = {}
						local good = true
						for _, group in ipairs(orderedGroupMenus) do
							local opt = findPath(group, unpackPlus(path, k))
							local args = opt and opt.args
							if args then
								if type(args) == "table" then
									for l, u in pairs(args) do
										if not t_args[l] then
											t_args[l] = convertSingleToMultiple(l, u, unpackPlus(path, k))
										end
									end
--[[								elseif type(args) == "function" then
									good = false
									local t = newList()
									figurePassValue(t, group, unpackPlus(path, k))
									args = args(unpack(t))
									t = del(t)
									
									for l, u in pairs(args) do
										if not t_args[l] then
											t_args[l] = convertSingleToMultiple(l, u, unpackPlus(path, k))
										end
									end]]
								end
							end
						end
						if good then
							t.args = t_args
						end
						return t_args
					end,
					icon = v.icon,
					iconWidth = v.iconWidth,
					iconHeight = v.iconHeight,
					order = v.order,
					disabled = disabled,
					hidden = hidden,
				}
				return t
			else -- execute	
				local function func(...)
					for _, group in ipairs(orderedGroupMenus) do
						if not figureHiddenOrDisabled(group, unpackPlus(path, k)) then
							local opt = findPath(group, unpackPlus(path, k))
							if opt then
								local func = figurePassFunc('func', group, unpackPlus(path, k))
								if func then
									t = newList()
									if type(opt.func) == "string" then
										local handler = figureHandler(group, unpackPlus(path, k))
										func = handler[func]
										t[#t+1] = handler
									end
									figurePassValue(t, group, unpackPlus(path, k))
									for i = 1, select('#', ...) do
										t[#t+1] = select(i, ...)
									end
									func(unpack(t))
									t = del(t)
								end
							end
						end
					end
				end
				return {
					type = 'execute',
					buttonText = v.buttonText,
					name = wrapFunction("name"),
					desc = wrapFunction("desc"),
					func = func,
					icon = v.icon,
					iconWidth = v.iconWidth,
					iconHeight = v.iconHeight,
					confirmText = v.confirmText,
					order = v.order,
					disabled = disabled,
					hidden = hidden,
				}
			end
		end

		function recurseCheck(stealArgs, args, ...)
			if type(stealArgs) ~= "table" or type(args) ~= "table" then
				return
			end
			for k,v in pairs(stealArgs) do
				if not args[k] and k ~= "disable" then
					args[k] = convertSingleToMultiple(k, v, ...)
				end
				if args[k] then
					if args[k].type == "group" then
						local t = newList(...)
						if type(stealArgs[k].args) == "function" then
							stealArgs[k].args(stealArgs[k].passValue)
						end
						recurseCheck(stealArgs[k].args, args[k].args, unpackPlus(t, k))
						t = del(t)
					elseif args[k].desc then
						local desc = v.desc
						if desc == v.name or desc == "" or desc == " " then
							desc = nil
						end
						local t = newList()
						for _, group in ipairs(orderedGroupMenus) do
							local a = options.args[group]
							for i = 1, select('#', ...) do
								if a and type(a.args) == "function" then
									a.args(a.passValue)
								end
								a = a and type(a.args) == "table" and a.args[select(i, ...)]
							end
							if a and type(a.args) == "function" then
								a.args(a.passValue)
							end
							a = a and type(a.args) == "table" and a.args[k]
							if a then
								t[#t+1] = "|cffffffff"
								t[#t+1] = GroupToLocale[group]
								t[#t+1] = "|r"
								t[#t+1] = ", "
							end
						end
						if #t == #orderedGroupMenus*4 then
							t = del(t)
							t = newList(L["|cffffffffEverything|r"], '')
						end
						if t[1] then
							t[#t] = nil
							local s = table.concat(t)
							if desc then
								if type(desc) == "string" then
									args[k].desc = desc .. L["\n\nAffects: "] .. s
								end
							else
								args[k].desc = L["Affects: "] .. s
							end
						else
							args[k].desc = v.desc or " "
						end
						t = del(t)
					end
					if not args[k].order then
						args[k].order = v.order
					end
				end
			end
		end
	end
end
--PitBull.OnMenuRequest = PitBull.options

local function InitializeExternalModules()
	for i = 1, GetNumAddOns() do
		local deps = newSet(GetAddOnDependencies(i))
		if deps["PitBull"] and IsAddOnLoadOnDemand(i) and not IsAddOnLoaded(i) then
			local name = GetAddOnInfo(i)
			if name:find("^PitBull_") then
				local modName = name:sub(9)
				local condition = GetAddOnMetadata(name, "X-PitBull-Condition")
				local good = true
				if condition then
					local func, err = loadstring(condition)
					if func then
						local success, ret = pcall(func)
						if success then
							good = ret
						end
					end
				end
				if good then
					local defaultState = tonumber(GetAddOnMetadata(name, "X-PitBull-DefaultState"))
					self:SetModuleDefaultState(modName, defaultState ~= 0)
					if self:IsModuleActive(modName, true) then
						local _,_,_,enabled,loadable = GetAddOnInfo(i)
						if enabled and loadable then
							LoadAddOn(i)
						end
					end
				end
			end
		end
		deps = del(deps)
	end
end

local fullyInited = false
function PitBull:OnEnable(first)
	local t = {}
	if not ClickCastFrames then
		ClickCastFrames = {}
	end
	
	for group, data in pairs(self.db.profile.groups) do
		data.layout = nil -- remove this later
	end
	
--	Dewdrop:InjectAceOptionsTable(self, self.options)
	--self.options.args.standby.hidden = true
	
	self:AddSecureHook("SecureGroupHeader_Update")
	SecureGroupHeader_Update = _G.SecureGroupHeader_Update
	
	self:AddGroupToAceOptions("player")
	if not self.db.profile.groups.player.hidden then
		self:CreateUnitFrame("player")
	end
	self:AddGroupToAceOptions("pet")
	if not self.db.profile.groups.pet.hidden then
		self:CreateUnitFrame("pet")
	end
	self:AddGroupToAceOptions("pettarget")
	if not self.db.profile.groups.pettarget.hidden then
		self:CreateUnitFrame("pettarget")
	end
	self:AddGroupToAceOptions("target")
	if not self.db.profile.groups.target.hidden then
		self:CreateUnitFrame("target")
	end
	self:AddGroupToAceOptions("targettarget")
	if not self.db.profile.groups.targettarget.hidden then
		self:CreateUnitFrame("targettarget")
	end
	self:AddGroupToAceOptions("targettargettarget")
	if not self.db.profile.groups.targettargettarget.hidden then
		self:CreateUnitFrame("targettargettarget")
	end
	self:AddGroupToAceOptions("focus")
	if not self.db.profile.groups.focus.hidden then
		self:CreateUnitFrame("focus")
	end
	self:AddGroupToAceOptions("focustarget")
	if not self.db.profile.groups.focustarget.hidden then
		self:CreateUnitFrame("focustarget")
	end
	self:AddGroupToAceOptions("focustargettarget")
	if not self.db.profile.groups.focustargettarget.hidden then
		self:CreateUnitFrame("focustargettarget")
	end
	self:AddGroupToAceOptions("party")
	self:AddGroupToAceOptions("partypet")
	self:AddGroupToAceOptions("partytarget")
	self:AddGroupToAceOptions("partypettarget")
	self:AddGroupToAceOptions("raid")
	self:AddGroupToAceOptions("raidpet")
	self:AddGroupToAceOptions("raidtarget")
	self:AddGroupToAceOptions("maintank")
	self:AddGroupToAceOptions("maintanktarget")
	self:AddGroupToAceOptions("maintanktargettarget")
	self:AddGroupToAceOptions("mainassist")
	self:AddGroupToAceOptions("mainassisttarget")
	self:AddGroupToAceOptions("mainassisttargettarget")
	self:AddGroupToAceOptions("mouseover")
	if not self.db.profile.groups.mouseover.hidden then
		self:CreateUnitFrame("mouseover")
	end
	self:AddGroupToAceOptions("mouseovertarget")
	if not self.db.profile.groups.mouseovertarget.hidden then
		self:CreateUnitFrame("mouseovertarget")
	end
	
	InitializeExternalModules()
	
	self:AddEventListener("PLAYER_TARGET_CHANGED")
	self:AddEventListener("PLAYER_FOCUS_CHANGED")
	self:AddEventListener("UPDATE_MOUSEOVER_UNIT")
	self:AddEventListener("LibRockEvent-1.0", "FullyInitialized")
	self:AddEventListener("PLAYER_LEAVING_WORLD")
	self:AddEventListener("PLAYER_ENTERING_WORLD")
	self:AddEventListener("PLAYER_PET_CHANGED")
	SharedMedia:RegisterCallback(self.SharedMedia_Registered)
	self:AddEventListener("PLAYER_REGEN_ENABLED")
	self:AddEventListener("PLAYER_REGEN_DISABLED")
	self:AddEventListener("UNIT_HAPPINESS")
	self:AddEventListener("UNIT_CLASSIFICATION_CHANGED")
	self:AddEventListener("PLAYER_ALIVE")
	self:AddEventListener("PLAYER_UNGHOST", "PLAYER_ALIVE")
	self:AddEventListener("PLAYER_DEAD", "PLAYER_ALIVE")
	self:AddEventListener("ADDON_LOADED")
	self:ADDON_LOADED()

	self:AddEventListener("AceEvent-2.0", "oRA_MainTankUpdate")
	
	self:AddRepeatingTimer(0.15, "UpdateWackyFrames")
	
--	if not WoW24 then
--		DogTag:SetColorConstantTable(self.colorConstants)
--	end
end

SLASH_PB1 = '/pb'

function SlashCmdList.PB(msg, editbox) -- 4.
	PitBull:SetProfile("PixelpointUI")
end

function PitBull:FullyInitialized()
	if fullyInited then
		return
	end
	self:RemoveEventListener("LibRockEvent-1.0", "FullyInitialized")
	fullyInited = true
	self:AddEventListener("PARTY_MEMBERS_CHANGED")
	self:AddEventListener("UNIT_PET")
	self:PARTY_MEMBERS_CHANGED()
end

local ScheduleDestroyCluster
local leftWorld = false
function PitBull:PLAYER_LEAVING_WORLD()
	leftWorld = true
	
	for cluster in pairs(clusters) do
		ScheduleDestroyCluster(cluster)
	end
end

local function func()
	leftWorld = false
	self:PARTY_MEMBERS_CHANGED()
end
function PitBull:PLAYER_ENTERING_WORLD()
	if leftWorld then
		self:AddTimer(5, func)
	end
end

function PitBull:OpenMenu(...)
	self:UpdateAllUnitsMenu()
	Rock("FuBarPlugin-2.0").OpenMenu(self, ...)
end

function PitBull:OnDisable()
	self:ToggleActive(true)
end

local function getScale(group)
	return self.db.profile.groups[group].scale
end
local function getWidth(group)
	return self.db.profile.groups[group].width
end
local function getHeight(group)
	return self.db.profile.groups[group].height
end
local function getMaxPositionX()
	return math.ceil(GetScreenWidth()/20) * 10
end
local function getMinPositionX()
	return -math.ceil(GetScreenWidth()/20) * 10
end
local function getMaxPositionY()
	return math.ceil(GetScreenHeight()/20) * 10
end
local function getMinPositionY()
	return -math.ceil(GetScreenHeight()/20) * 10
end
local function getPositionX(group)
	return self.db.profile.units[group].x
end
local function getPositionY(group)
	return self.db.profile.units[group].y
end
local function getBorder(group)
	return self.db.profile.groups[group].border
end
local function getHidden(group)
	return self.db.profile.groups[group].hidden
end
local function getDirection(group)
	return self.db.profile.groups[group].direction
end
local function getSpacing(group)
	return self.db.profile.groups[group].spacing
end
local function getHSpacing(group)
	return self.db.profile.groups[group].hspacing
end
local function getFreeform(group)
	return self.db.profile.groups[group].freeform
end
local function enableDisabledUnit(group)
	PitBull:ChangeHidden(group, false)
end
local function getSpacingVisible(group)
	local direction = self.db.profile.groups[group].direction
	local square = self.db.profile.groups[group].square
	return not (direction == "up" or direction == "down" or square)
end
local function getHSpacingVisible(group)
	local direction = self.db.profile.groups[group].direction
	local square = self.db.profile.groups[group].square
	return not (direction == "left" or direction == "right" or square)
end

local function figureSubgroup(name)
	local subgroup
	if name:find("[tT][eE][xX][tT]") then
		subgroup = "texts"
	elseif name:find("[iI][cC][oO][nN]") then
		subgroup = "icons"
	elseif name:find("[bB][aA][rR]") then
		subgroup = "bars"
	else
		subgroup = "other"
	end
	return subgroup
end

local function addModuleOptionsMethod(group, module, method)
	local name = module.name
	
	local subgroup = figureSubgroup(name)
	
	local options = options.args[group].args[subgroup].args
	if type(options) == "function" then
		return
	end
	if type(method) == "function" then
		options[name] = method(group)
	else
		options[name] = module[method](module, group)
	end
	if options[name] and not options[name].handler then
		options[name].handler = module
	end
	if options[name] then
		local old_hidden = options[name].hidden
		if type(old_hidden) == "function" then
			options[name].hidden = function(...)
				if not PitBull:IsModuleActive(module) then
					return true
				end
				return old_hidden(...)
			end
		elseif type(old_hidden) == "string" then
			options[name].hidden = function(...)
				if not PitBull:IsModuleActive(module) then
					return true
				end
				local handler = options[name].handler
				if not handler or type(handler[old_hidden]) ~= "function" then
					return true
				end
				return handler[old_hidden](handler, ...)
			end
		else
			options[name].hidden = function()
				return not PitBull:IsModuleActive(module)
			end
		end
	end
	for k, v in pairs(options) do
		--if not v.order then
		--	if (v.type == "group" or (v.type == 'choice' and type(v.validate) == "table")) then
				v.order = 100
		--	elseif not v.order then
		--		v.order = 200
		--	end
		--end
	end
end

local function mySort(alpha, bravo)
	return options.args[alpha].order < options.args[bravo].order
end

local validateLayoutName
local layoutNames

local groupCopyFromValidate = {}

function PitBull:AddGroupToAceOptions(group)
	AddGroupToAceOptions_todo[group] = true
	if type(options.args) ~= "table" then
		return
	end
	if options.args[group] then
		return
	end
	groupCopyFromValidate[group] = GroupToLocale[group]
	local order
	if group:find("^player") then
		order = 50 + group:len()/1000
	elseif group:find("^pet") then
		order = 51 + group:len()/1000
	elseif group:find("^target") then
		order = 52 + group:len()/1000
	elseif group:find("^partypet") then
		order = 54 + group:len()/1000
	elseif group:find("^party") then
		order = 53 + group:len()/1000
	elseif group:find("^raidpet") then
		order = 56 + group:len()/1000
	elseif group:find("^raid") then
		order = 55 + group:len()/1000
	elseif group:find("^maintank") then
		order = 57 + group:len()/1000
	elseif group:find("^mainassist") then
		order = 58 + group:len()/1000
	elseif group:find("^focus") then
		order = 59 + group:len()/1000
	elseif group:find("^mouseover") then
		order = 60 + group:len()/1000
	else
		order = 61 + group:len()/1000
	end
	
	local cluster = group:match("^party") or group:match("^raid") or group:match("^maintank") or group:match("^mainassist")
	
	options.args[group] = {
		order = order,
		name = GroupToLocale[group],
		desc = (L["Options for %s."]):format(GroupToLocale[group]),
		type = "group",
		args = {
			header = {
				order = 1,
				name = GroupToLocale[group],
				type = 'header',
			},
			bars = {
				type = 'group',
				name = L["Bars"],
				desc = L["Options for bars."],
				args = {
					
				},
				order = 50
			},
			texts = {
				type = 'group',
				name = L["Texts"],
				desc = L["Options for texts."],
				args = {
					
				},
				order = 50
			},
			icons = {
				type = 'group',
				name = L["Icons"],
				desc = L["Options for icons."],
				args = function()
					local args = {}
					options.args[group].args.icons.args = args
					
					for module, method in pairs(moduleOptionsMethods) do
						addModuleOptionsMethod(group, module, method)
					end
					
					if UpdateLayoutSettings_todo[group] then
						PitBull:UpdateLayoutSettings(group)
					end
					
					local RockConfig = Rock("LibRockConfig-1.0")
					self:AddTimer(0, RockConfig.RefreshConfigMenu, RockConfig, self)
					return args
				end,
				order = 50
			},
			other = {
				type = 'group',
				name = L["Other"],
				desc = L["Other options."],
				order = 50,
				args = {
					size = {
						name = L["Size"],
						desc = L["Options for changing the size of this unit type."],
						type = 'group',
						args = {
							scale = {
								name = L["Scale"],
								desc = L["Scale of the unit frame."],
								type = 'number',
								isPercent = true,
								min = 0.5,
								max = 2,
								step = 0.01,
								bigStep = 0.05,
								get = getScale,
								set = "ChangeScale",
								passValue = group,
								handler = PitBull,
								disabled = InCombatLockdown,
							},
							width = {
								name = L["Width"],
								desc = L["Width of the unit frame."],
								type = 'number',
								min = 20,
								max = 400,
								step = 1,
								bigStep = 5,
								get = getWidth,
								set = "ChangeWidth",
								passValue = group,
								handler = PitBull,
								disabled = InCombatLockdown,
							},
							height = {
								name = L["Height"],
								desc = L["Height of the unit frame."],
								type = 'number',
								min = 5,
								max = 400,
								step = 1,
								bigStep = 5,
								get = getHeight,
								set = "ChangeHeight",
								passValue = group,
								handler = PitBull,
								disabled = InCombatLockdown,
							},
						},
						disabled = InCombatLockdown,
					},
					position = not cluster and {
						name = L["Position"],
						desc = L["Options for changing the position of this unit type."],
						type = 'group',
						args = {
							x = {
								name = L["Horizontal"],
								desc = L["Horizontal position on the x-axis."],
								type = 'number',
								min = getMinPositionX,
								max = getMaxPositionX,
								step = 1,
								bigStep = 5,
								get = getPositionX,
								set = "ChangePositionX",
								passValue = group,
								handler = PitBull,
								disabled = InCombatLockdown,
							},
							y = {
								name = L["Vertical"],
								desc = L["Vertical position on the y-axis."],
								type = 'number',
								min = getMinPositionY,
								max = getMaxPositionY,
								step = 1,
								bigStep = 5,
								get = getPositionY,
								set = "ChangePositionY",
								passValue = group,
								handler = PitBull,
								disabled = InCombatLockdown,
							},
						},
						disabled = InCombatLockdown,
					} or nil,
					layout = {
						name = L["Layout"],
						desc = L["Layout options for this unit type"],
						type = 'group',
						args = {
							choose = {
								name = L["Choose"],
								desc = L["Select the layout to use for this unit type."],
								type = 'choice',
								choices = layoutNames,
								get = "GetCurrentLayout",
								set = "ChangeLayout",
								passValue = group,
								handler = PitBull,
							},
							save = {
								name = L["Save layout"],
								desc = L["Save your current settings for this unit type as a layout."],
								type = 'string',
								validate = validateLayoutName,
								get = false,
								set = "SaveLayout",
								disabled = "IsCurrentLayoutNotCustom",
								passValue = group,
								handler = PitBull,
								usage = "<Layout Name>",
							},
							copy = {
								name = L["Copy from other frame"],
								desc = L["Copy the layout used on another frame."],
								type = 'choice',
								choices = groupCopyFromValidate,
								passValue = group,
								handler = PitBull,
								get = false,
								set = "CopyLayout",
							},
						},
					},
					border = {
						name = L["Border"],
						desc = L["Change the border type."],
						type = 'choice',
						choices = SharedMedia:List('border'),
						get = getBorder,
						set = "ChangeBorder",
						passValue = group,
						handler = PitBull,
					},
				}
			},
			disable = {
				name = L["Disable"],
				desc = L["Disables units of this type."],
				order = -1,
				type = 'boolean',
				get = getHidden,
				set = "ChangeHidden",
				passValue = group,
				handler = PitBull,
				disabled = InCombatLockdown
			}
		},
	}
	
	for k in pairs(groupMenus) do
		groupMenus[k] = nil
	end
	for k in pairs(AddGroupToAceOptions_todo) do
		if options.args[k] then
			groupMenus[k] = true
		end
	end
	for i = 1, #orderedGroupMenus do
		orderedGroupMenus[i] = nil
	end
	for k in pairs(groupMenus) do
		orderedGroupMenus[#orderedGroupMenus+1] = k
	end
	table.sort(orderedGroupMenus, mySort)
	
	if group:find("^party") or group:find("^raid") or group:find("^maintank") or group:find("^mainassist") then
		options.args[group].args.other.args.grouping = {
			name = L["Grouping"],
			desc = L["Options for how to position the units in this group relative to eachother."],
			type = 'group',
			args = {
--[[				freeform = {
					name = L["Enable freeform movement"],
					desc = L["Enable freeform movement"],
					type = 'boolean',
					get = getFreeform,
					set = "ChangeGroupFreeform",
					passValue = group,
					handler = PitBull,
					disabled = InCombatLockdown,
				},]]
				direction = {
					name = L["Direction"],
					desc = L["What direction to group these units in."],
					type = 'choice',
					choices = {
						left = L["Left"],
						right = L["Right"],
						up = L["Up"],
						down = L["Down"],
					},
					order = 1,
					get = getDirection,
					set = "ChangeGroupDirection",
					passValue = group,
					handler = PitBull,
					disabled = InCombatLockdown
				},
				spacing = {
					name = L["Vertical Spacing"],
					desc = L["How much space there should be between each unit, in pixels."],
					type = 'number',
					min = 0,
					max = 200,
					step = 1,
					bigStep = 5,
					order = 2,
					get = getSpacing,
					set = "ChangeGroupSpacing",
					passValue = group,
					handler = PitBull,
					disabled = InCombatLockdown,
					hidden = getSpacingVisible,
				},
				hspacing = {
					name = L["Horizontal Spacing"],
					desc = L["How much space there should be between each unit, in pixels."],
					type = 'number',
					min = 0,
					max = 300,
					step = 1,
					bigStep = 5,
					order = 3,
					get = getHSpacing,
					set = "ChangeGroupHSpacing",
					passValue = group,
					handler = PitBull,
					disabled = InCombatLockdown,
					hidden = getHSpacingVisible,
				},
			}
		}
	end


	if group == "party" then
		options.args[group].args.other.args.hidePartyInRaid = {
			name = L["Hide party frames in raid"],
			desc = L["Hides the party frames while the player is in a raid group."],
			type = 'boolean',
			get = function()
				return self.db.profile.groups.party.hidePartyInRaid
			end,
			set = "ChangeHidePartyInRaid",
			handler = self,
			disabled = InCombatLockdown,
		}
		options.args[group].args.other.args.showPlayerInParty = {
			name = L["Show player in party"],
			desc = L["Shows the player in the party frames while the player is in a party."],
			type = 'boolean',
			get = function()
				return self.db.profile.groups.party.showPlayerInParty
			end,
			set = "ChangeShowPlayerInParty",
			handler = self,
			disabled = InCombatLockdown,
		}
	end
	if group == "raid" or group == "party" then
		options.args[group].args.other.args.show5manAsParty = {
			name = L["Show 5-man raid as a party"],
			desc = L["Show a 5-man, 1-party raid as a party instead of a raid. Could be useful in arena battles, for example."],
			type = 'boolean',
			get = function()
				return self.db.profile.groups.raid.show5manAsParty
			end,
			set = "ChangeShow5manAsParty",
			handler = self,
			disabled = InCombatLockdown,
		}
	end
	if group == "raid" or group == "party" or group == "maintank" or group == "mainassist" then
		options.args[group].args.other.args.grouping.args.nameSort = {
			name = L["Sort by name"],
			desc = L["Whether to sort the units in this group by name or index."],
			type = 'boolean',
			get = function(group)
				return self.db.profile.groups[group].nameSort
			end,
			set = "ChangeNameSort",
			passValue = group,
			disabled = InCombatLockdown,
			handler = PitBull,
		}
	end
	
	if group == "raid" then
		options.args[group].args.other.args.grouping.args.groupStyle = {
			name = L["Style"],
			desc = L["Style to group by"],
			type = 'choice',
			choices = {
				class = L["Class"],
				group = L["Raid group"],
				flatClass = L["Flat, group by class"],
				flatGroup = L["Flat, group by raid group"],
				flat = L["Flat, no grouping"],
			},
			choiceDescs = {
				class = L["Show 9 raid headers, one for each class."],
				group = L["Show up to 8 raid headers, one for each raid group."],
				flatClass = L["Show a single raid header, grouping units by class."],
				flatGroup = L["Show a single raid header, grouping units by raid group."],
				flat = L["Show a single raid header, don't do any special grouping."],
			},
			get = function()
				return self.db.profile.groups.raid.groupStyle
			end,
			set = "ChangeRaidGroupStyle",
			disabled = InCombatLockdown,
			handler = PitBull,
		}
		options.args[group].args.other.args.grouping.args.groupFilter = {
			name = L["Group Filter"],
			desc = L["Set which groups to filter by."],
			type = 'multichoice',
			get = function(key)
				return self.db.profile.groups.raid.groupFilter[tonumber(key)]
			end,
			set = "ChangeRaidGroupFilter",
			choices = {
				["1"] = L["Group #%d"]:format(1),
				["2"] = L["Group #%d"]:format(2),
				["3"] = L["Group #%d"]:format(3),
				["4"] = L["Group #%d"]:format(4),
				["5"] = L["Group #%d"]:format(5),
				["6"] = L["Group #%d"]:format(6),
				["7"] = L["Group #%d"]:format(7),
				["8"] = L["Group #%d"]:format(8),
			},
			handler = PitBull,
		}
		options.args[group].args.other.args.grouping.args.classFilter = {
			name = L["Class Filter"],
			desc = L["Set which classes to filter by."],
			type = 'multichoice',
			get = function(key)
				return self.db.profile.groups.raid.classFilter[key]
			end,
			set = "ChangeRaidClassFilter",
			choices = {
				WARRIOR = L["Warrior"],
				PRIEST = L["Priest"],
				ROGUE = L["Rogue"],
				HUNTER = L["Hunter"],
				WARLOCK = L["Warlock"],
				MAGE = L["Mage"],
				SHAMAN = L["Shaman"],
				PALADIN = L["Paladin"],
				DRUID = L["Druid"],
			},
			handler = PitBull,
		}
		options.args[group].args.other.args.showInBG = {
			name = L["Show in Battleground"],
			desc = L["Show the raid frames in the given battlegrounds, otherwise only showing the party frames."],
			type = 'multichoice',
			get = function(key)
				return not self.db.profile.groups.raid.hideInBG[key]
			end,
			set = "ChangeRaidShowInBattleground",
			choices = {
				wsg = BZ["Warsong Gulch"],
				ab = BZ["Arathi Basin"],
				av = BZ["Alterac Valley"],
				eots = BZ["Eye of the Storm"],
			},
			handler = PitBull,
		}
	end
	
	if group:find("^party") then
		options.args[group].args.other.args.grouping.args.square = {
			name = L["Square"],
			desc = L["Square Layout"],
			type = 'boolean',
			get = function()
				return self.db.profile.groups[group].square
			end,
			set = "ChangeSquareLayout",
			passValue = group,
			disabled = InCombatLockdown,
			handler = PitBull,
		}
	end
--	if not options.args.sep then
--		options.args.sep = {
--			order = 60,
--			type = 'header'
--		}
--	end

	if getHidden(group) then
		-- Hide the group and create a new toggle in disabledUnits
		options.args[group].hidden = true
		options.args.disabledUnits.args[group] = {
			type = 'execute',
			name = GroupToLocale[group],
			desc = L["Enable %s."]:format(GroupToLocale[group]),
			buttonText = L["Enable"],
			func = enableDisabledUnit,
			passValue = group,
		}
	end
end

local pendingModules = {}
function PitBull:OnModuleCreated(name, module)
	pendingModules[name] = module
end

local CT_RAOptions_UpdateMTs

function PitBull:ADDON_LOADED()
	for name, module in pairs(pendingModules) do
		pendingModules[name] = nil
	end
	
	if not CT_RAOptions_UpdateMTs and _G.CT_RAOptions_UpdateMTs then
		hooksecurefunc("CT_RAOptions_UpdateMTs", function()
			self:oRA_MainTankUpdate()
		end)
		CT_RAOptions_UpdateMTs = _G.CT_RAOptions_UpdateMTs
	end
end

function PitBull:ReorganizeCluster(cluster)
	local header = clusters[cluster]
	local direction = self.db.profile.groups[header.group].direction
	local spacing = self.db.profile.groups[header.group].spacing
	local hspacing = self.db.profile.groups[header.group].hspacing
	local square = self.db.profile.groups[header.group].square
	local point, columnpoint
	
	header:SetAttribute("maxColumns", square and 2 or 1)
	header:SetAttribute("unitsPerColumn", square and 2 or nil)

	if direction == "up" then
		header:SetAttribute("xOffset", 0)
		header:SetAttribute("yOffset", spacing)
		header:SetAttribute("columnSpacing", hspacing)
		columnpoint = "RIGHT"
		point = "BOTTOM"
	elseif direction == "left" then
		header:SetAttribute("xOffset", -hspacing)
		header:SetAttribute("yOffset", 0)
		header:SetAttribute("columnSpacing", spacing)
		columnpoint = "BOTTOM"
		point = "RIGHT"
	elseif direction == "right" then
		header:SetAttribute("xOffset", hspacing)
		header:SetAttribute("yOffset", 0)
		header:SetAttribute("columnSpacing", spacing)
		columnpoint = "TOP"
		point = "LEFT"
	else
		header:SetAttribute("xOffset", 0)
		header:SetAttribute("yOffset", -spacing)
		header:SetAttribute("columnSpacing", hspacing)
		columnpoint = "LEFT"
		point = "TOP"
	end
	header:SetAttribute("columnAnchorPoint", columnpoint)
	header:SetAttribute("point", point)
	local uis = UIParent:GetScale()
	local s = header:GetEffectiveScale()
	local db = self.db.profile.clusters[cluster]
	header:ClearAllPoints()
	header:SetPoint(point, UIParent, "CENTER", db.x*uis/s, db.y*uis/s)
end

function PitBull:PLAYER_TARGET_CHANGED()
	for frame in self:IterateUnitFramesForUnit("target") do
		if configMode or UnitExists('target') then
			if frame:IsShown() then
				self:PopulateUnitFrame(frame, true)
			end
		elseif frames[frame] then
			self:ClearUnitFrame(frame)
		end
	end
end

function PitBull:PLAYER_FOCUS_CHANGED()
	for frame in self:IterateUnitFramesForUnit("focus") do
		if configMode or UnitExists('focus') then
			if frame:IsShown() then
				self:PopulateUnitFrame(frame, true)
			end
		elseif frames[frame] then
			self:ClearUnitFrame(frame)
		end
	end
end

function PitBull:UPDATE_MOUSEOVER_UNIT()
	for frame in self:IterateUnitFramesForUnit("mouseover") do
		if configMode or UnitExists('mouseover') then
			if frame:IsShown() then
				self:PopulateUnitFrame(frame, true)
			end
		elseif frames[frame] then
			self:ClearUnitFrame(frame)
		end
	end
end

local framesByUnit_needsUpdate = false

local function updateFramesByUnit()
	framesByUnit_needsUpdate = false
	for unit, data in pairs(framesByUnit) do
		framesByUnit[unit] = del(data)
	end
	for frame in pairs(frames) do
		local unit = frame:GetUnit()
		if not framesByUnit[unit] then
			framesByUnit[unit] = newList()
		end
		framesByUnit[unit][frame] = true
	end
end

local lastDestroyTime = 0

local clustersToCreateOrDestroy
local function handleCreateDestroyClusters()
	if not clustersToCreateOrDestroy then
		return
	end
	for k,v in pairs(clustersToCreateOrDestroy) do
		if v == 'destroy' then
			lastDestroyTime = GetTime()
			PitBull:DestroyUnitCluster(k)
			clustersToCreateOrDestroy[k] = nil
		end
	end
	if lastDestroyTime >= GetTime() - 3 then
		PitBull:AddTimer(3, handleCreateDestroyClusters)
		return
	end
	for k,v in pairs(clustersToCreateOrDestroy) do
		PitBull:CreateUnitCluster(k)
	end
	clustersToCreateOrDestroy = del(clustersToCreateOrDestroy)
end

function ScheduleDestroyCluster(cluster)
	if not InCombatLockdown() then
		lastDestroyTime = GetTime()
		PitBull:DestroyUnitCluster(cluster)
		return
	end
	local made = false
	if not clustersToCreateOrDestroy then
		clustersToCreateOrDestroy = newList()
		made = true
	end
	
	clustersToCreateOrDestroy[cluster] = 'destroy'
	
	if made then
		PitBull:ScheduleLeaveCombatAction(handleCreateDestroyClusters)
	end
end

local function ScheduleCreateCluster(cluster)
	if not InCombatLockdown() and lastDestroyTime < GetTime() - 3 then
		PitBull:CreateUnitCluster(cluster)
		return
	end
	local made = false
	if not clustersToCreateOrDestroy then
		clustersToCreateOrDestroy = newList()
		made = true
	end
	
	clustersToCreateOrDestroy[cluster] = 'create'
	
	if made then
		PitBull:ScheduleLeaveCombatAction(handleCreateDestroyClusters)
	end
end

local function GetNameAndServer(unit)
	local name, server = UnitName(unit)
	if server then
		return name .. '-' .. server
	else
		return name
	end
end	

local framesWithChangedUnit = {}

local function swapAroundRaidFrames(header)
	local cluster = header.cluster
	if not cluster then
		return
	end
	local oldData = newList()
	local newData = newList()
	if (cluster:find("^raid") or cluster:find("^party")) and not cluster:find("pet$") and not cluster:find("target$") and not cluster:find("MAINTANK") and not cluster:find("MAINASSIST") then
		local petheader = clusters[cluster .. "pet"]
		for i = 1, 40 do
			local child = header:GetAttribute("child" .. i)
			if not child then
				break
			end
			local name = child.__name
			if not name then
				break
			end
			oldData[name] = child
			if petheader then
				local petchild = petheader:GetAttribute("child" .. i)
				if petchild then
					oldData[name .. "-pet"] = petchild
				end
			end
		end
		for i = 1, 40 do
			local child = header:GetAttribute("child" .. i)
			if not child then
				break
			end
			if UnitExists(child:GetUnit()) then
				local name = GetNameAndServer(child:GetUnit())
				newData[name] = child
				if petheader then
					newData[name .. "-pet"] = petheader:GetAttribute("child" .. i)
				end
			end
		end
	end
	
	for k, v in pairs(oldData) do
		if newData[k] == v or not newData[k] then
			oldData[k] = nil
			newData[k] = nil
		end
	end
	
	framesByUnit_needsUpdate = true
	
	local updateList = newList()
	for _,v in pairs(oldData) do
		updateList[v] = v
	end
	
	local updateBorderList = newList()
	
	lazyLayout = lazyLayout + 1
	for key, alpha in pairs(oldData) do
		local bravo = newData[key]
		oldData[key] = nil
		newData[key] = nil
		for k,v in pairs(oldData) do
			if v == bravo then
				oldData[k] = alpha
			end
		end
		for k,v in pairs(updateList) do
			if v == alpha then
				updateList[k] = bravo
			elseif v == bravo then
				updateList[k] = alpha
			end
		end
		local tmp = newList()
		for k in pairs(alpha) do
			tmp[k] = true
		end
		for k in pairs(bravo) do
			tmp[k] = true
		end
		tmp[0] = nil
		if alpha.backdrop then
			alpha.backdrop = delFrame(alpha.backdrop)
			if alpha.border1 then
				for i = 1, 8 do
					alpha["border" .. i] = delFrame(alpha["border" .. i])
				end
			end
		end
		if bravo.backdrop then
			bravo.backdrop = delFrame(bravo.backdrop)
			if bravo.border1 then
				for i = 1, 8 do
					bravo["border" .. i] = delFrame(bravo["border" .. i])
				end
			end
		end
		updateBorderList[alpha] = true
		updateBorderList[bravo] = true
		
		for k in pairs(tmp) do
			local alpha_k, bravo_k = bravo[k], alpha[k]
			alpha[k], bravo[k] = alpha_k, bravo_k
		end
		tmp = del(tmp)
		
		local alpha_children, bravo_children = newList(bravo:GetChildren()), newList(alpha:GetChildren())
		for _,v in ipairs(alpha_children) do
			local strata, level = v:GetFrameStrata(), v:GetFrameLevel()
			local shown = v:IsShown()
			v:SetParent(alpha)
			v:SetFrameStrata(strata)
			v:SetFrameLevel(level)
			if shown then
				v:Show()
			else
				v:Hide()
			end
		end
		for _,v in ipairs(bravo_children) do
			local strata, level = v:GetFrameStrata(), v:GetFrameLevel()
			local shown = v:IsShown()
			v:SetParent(bravo)
			v:SetFrameStrata(strata)
			v:SetFrameLevel(level)
			if shown then
				v:Show()
			else
				v:Hide()
			end
		end
		alpha_children, bravo_children = del(alpha_children), del(bravo_children)
		local alpha_regions, bravo_regions = newList(bravo:GetRegions()), newList(alpha:GetRegions())
		for _,v in ipairs(alpha_regions) do
			v:SetParent(alpha)
		end
		for _,v in ipairs(bravo_regions) do
			v:SetParent(bravo)
		end
		alpha_regions, bravo_regions = del(alpha_regions), del(bravo_regions)
		
		frames[alpha], frames[bravo] = frames[bravo], frames[alpha]
		local alpha_group, bravo_group = alpha.group, bravo.group
		if alpha_group and framesByGroup[alpha_group] then
			framesByGroup[alpha_group][alpha], framesByGroup[alpha_group][bravo] = framesByGroup[alpha_group][bravo], framesByGroup[alpha_group][alpha]
		end
		if bravo_group and bravo_group ~= alpha_group and framesByGroup[bravo_group] then
			framesByGroup[bravo_group][alpha], framesByGroup[bravo_group][bravo] = framesByGroup[bravo_group][bravo], framesByGroup[bravo_group][alpha]
		end
		
		local alpha_trans, bravo_trans = bravo:GetAlpha(), alpha:GetAlpha()
		alpha:SetAlpha(alpha_trans)
		bravo:SetAlpha(bravo_trans)
		
		self:UpdateLayout(alpha)
		self:UpdateLayout(bravo)
	end
	for frame in pairs(updateBorderList) do
		self:UpdateBackdropAndBorder(frame)
		
		if not frame.overlay then
			local overlay = newFrame("Frame", frame)
			frame.overlay = overlay
			overlay:SetFrameLevel(frame:GetFrameLevel()+3)
		end
	end
	updateBorderList = del(updateBorderList)
	
	for key, alpha in pairs(newData) do
		framesWithChangedUnit[alpha] = nil
		self:PopulateUnitFrame(alpha)
		self:UpdateLayout(alpha)
	end
	
	for k,v in pairs(updateList) do
		self:CallMethodOnAllModules(true, "OnSwapUnitFrame", v:GetUnit(), v, k)
	end
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
	
	updateList = del(updateList)
	oldData = del(oldData)
	newData = del(newData)
end

local actionsToPerform = {}
function PitBull:PLAYER_REGEN_ENABLED()
	for i, v in ipairs(actionsToPerform) do
		local func = v[1]
		if type(func) == "table" then
			v[1], v[2] = func[v[2]], func
		end
		local success, ret = pcall(unpack(v))
		if not success then
			geterrorhandler()(ret)
		end
		actionsToPerform[i] = del(v)
	end
end

function PitBull:ScheduleLeaveCombatAction(...)
	if InCombatLockdown() then
		actionsToPerform[#actionsToPerform+1] = newList(...)
		return
	end
	local func = (...)
	if type(func) == "table" then
		local method = select(2, ...)
		return self:ScheduleLeaveCombatAction(func[method], func, select(3, ...))
	end
	local success, ret = pcall(...)
	if not success then
		geterrorhandler()(ret)
	end
end

local currentMovingFrame

function PitBull:PLAYER_REGEN_DISABLED()
	if configMode then
		self:Print("Turning off config mode due to entering combat. Feel free to re-enable it once you are out of combat.")
		
		self:ChangeConfigMode(nil)
	end
	if not fullyInited then
		self:FullyInitialized()
	end
	if leftWorld then
		leftWorld = false
		self:PARTY_MEMBERS_CHANGED()
	end
	
	lastDestroyTime = 0
	handleCreateDestroyClusters()
end

local offlineUnits = {}

function PitBull:PARTY_MEMBERS_CHANGED()
	NumRaidMembers = GetNumRaidMembers()
	NumPartyMembers = GetNumPartyMembers()
	if not fullyInited or leftWorld then
		return
	end
	if configMode and _G.event then
		if configMode == "raid" then
			if not ShouldShowRaid() then
				self:Print("Turning off Configuration mode, due to real group change. Feel free to re-enable.")
				self:ChangeConfigMode(nil)
			end
		elseif configMode == "party" then
			if not ShouldShowParty() then
				self:Print("Turning off Configuration mode, due to real group change. Feel free to re-enable.")
				self:ChangeConfigMode(nil)
			end
		elseif configMode == "solo" then
			if ShouldShowParty() or ShouldShowRaid() then
				self:Print("Turning off Configuration mode, due to real group change. Feel free to re-enable.")
				self:ChangeConfigMode(nil)
			end
		end
	end
	
	if currentMovingFrame then
		currentMovingFrame:StopMovingOrSizing()
		currentMovingFrame = nil
	end
	
	framesByUnit_needsUpdate = true
	
	local showparty, showraid = ShouldShowParty(), ShouldShowRaid()
	local somethingDisabled = false
	if not showparty then
		for cluster in pairs(clusters) do
			if cluster:find("^party") then
				ScheduleDestroyCluster(cluster)
			end
		end
	end
	if not showraid then
		for cluster in pairs(clusters) do
			if cluster:find("^raid") then
				ScheduleDestroyCluster(cluster)
			end
		end
	end
	if showparty then
		for group, db in pairs(self.db.profile.groups) do
			if not db.hidden and group:find("^party") then
				ScheduleCreateCluster(group)
			end
		end
	end
	if showraid then
		for group, db in pairs(self.db.profile.groups) do
			if not db.hidden then
				if group:find("^raid") or group:find("^maintank") or group:find("^mainassist") then
					ScheduleCreateCluster(group)
				end
			end
		end
	end
	
	framesByUnit_needsUpdate = true
	
	for i = 1, NumPartyMembers do
		local unit = "party" .. i
		local disconnected = not UnitIsConnected(unit)
		if disconnected ~= (offlineUnits[unit] or false) then
			offlineUnits[unit] = disconnected
			for frame in self:IterateUnitFramesForUnit(unit) do
				self:UpdateFrame(frame)
			end
		end
	end
	for i = 1, NumRaidMembers do
		local unit = "raid" .. i
		local disconnected = not UnitIsConnected(unit)
		if disconnected ~= (offlineUnits[unit] or false) then
			offlineUnits[unit] = disconnected
			for frame in self:IterateUnitFramesForUnit(unit) do
				self:UpdateFrame(frame)
			end
		end
	end
	
	self:_UpdateLayouts()
end

function PitBull:UNIT_PET(ns, event, unit)
	if unit == "player" then
		for frame in self:IterateUnitFramesForUnit("pet") do
			if not self.db.profile.groups['pet'].hidden and (configMode or UnitExists('pet')) then
				if frame:IsShown() then
					self:PopulateUnitFrame(frame, true)
				end
			elseif frames[frame] then
				self:ClearUnitFrame(frame)
			end
		end
	else
		self:PARTY_MEMBERS_CHANGED()
	end
end

function PitBull:SecureGroupHeader_Update(this)
	framesByUnit_needsUpdate = true
	swapAroundRaidFrames(this)
end

function PitBull:UNIT_HAPPINESS()
	for frame in self:IterateUnitFramesForUnit("pet") do
		self:UpdateFrame(frame)
	end
end

function PitBull:UNIT_CLASSIFICATION_CHANGED(ns, event, unit)
	for frame in self:IterateUnitFramesForUnit(unit) do
		self:UpdateBackdropAndBorder(frame)
	end
end

function PitBull:PLAYER_ALIVE()
	for frame in self:IterateUnitFramesForUnit("player") do
		self:UpdateFrame(frame)
	end
end

function PitBull:oRA_MainTankUpdate()
	for cluster in pairs(clusters) do
		if cluster:find("^raidMAINTANK") then
			self:ScheduleLeaveCombatAction(self, 'DestroyUnitCluster', cluster)
			self:ScheduleLeaveCombatAction(self, 'CreateUnitCluster', cluster)
		end
	end
end

function PitBull:UpdateAll()
	lazyLayout = lazyLayout + 1
	for frame in pairs(frames) do
		local unit = frame:GetUnit()
		if (configMode or UnitExists(unit)) and ShouldShowUnit(unit) and not self.db.profile.groups[frame.group].hidden then
			self:UpdateLayout(frame)
			self:UpdateFrame(frame)
		end
	end
	self:UpdateAllStatusBarTextures()
	self:UpdateAllFonts()
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
end

function PitBull:UpdateWackyFrames()
	-- this is to update frames that are not handled by Blizzard's standard events, e.g. targettarget, targettargettarget
	for frame in pairs(wackyFrames) do
		local unit = frame:GetUnit()
		if configMode or UnitExists(unit) then
			self:UpdateFrame(frame, true)
		end
	end
end

local framesByUnitName_needsUpdate = false

function PitBull:UpdateFrame(frame, nonCrucial)
	-- update everything about a frame
	if not isframe(frame) then
		error(("Bad argument #2 to `UpdateFrame'. Expected %s, got %s"):format("frame", type(frame)), 2)
	end
	if not frames[frame] then
		return
	end
	local unit = frame:GetUnit()
	if not frame.group or not unit or (not configMode and not UnitExists(unit)) then
		self:ClearUnitFrame(frame)
		return
	end
	local oldName = frame.__name
	frame.__name = nil
	local newName = frame:GetUnitName()
	if oldName ~= newName then
		framesByUnitName_needsUpdate = true
	end
	
	if not frame.overlay then
		local overlay = newFrame("Frame", frame)
		frame.overlay = overlay
		overlay:SetFrameLevel(frame:GetFrameLevel()+3)
	end
	
	lazyLayout = lazyLayout + 1
	self:CallMethodOnAllModules(true, "OnUpdateFrame", unit, frame, nonCrucial and oldName == newName)
	lazyLayout = lazyLayout - 1
	
	DogTag:UpdateAllForFrame(frame)
	
	self:_UpdateLayout(frame)
	
	self:UpdateBackdropAndBorder(frame)
end

local function updateFrameStrata(frame, strata)
	frame:SetFrameStrata(strata)
	local list = newList(frame:GetChildren())
	for _,v in ipairs(list) do
		updateFrameStrata(v, strata)
	end
	list = del(list)
end

local strataFramesToUpdate = {}
local scheduled = false
local function _UpdateAllFrameStratas()
	scheduled = false
	local strata = PitBull.db.profile.settings.strata
	local toUpdate = strataFramesToUpdate
	if toUpdate[true] then
		toUpdate = allFrames
	end
	for frame in pairs(toUpdate) do
		if frame:GetFrameStrata() ~= strata then
			updateFrameStrata(frame, strata)
		end
	end
	for k in pairs(strataFramesToUpdate) do
		strataFramesToUpdate[k] = nil
	end
end

function PitBull:UpdateAllFrameStratas(frame)
	if frame then
		strataFramesToUpdate[frame] = true
	else
		strataFramesToUpdate[true] = true
	end
	if scheduled then
		return
	end
	scheduled = true
	PitBull:ScheduleLeaveCombatAction(_UpdateAllFrameStratas)
end

local ignore = { overlay = true, db = true, group = true, unit = true, backdrop = true, border1 = true, border2 = true, border3 = true, border4 = true, border5 = true, border6 = true, border7 = true, border8 = true }
local layoutsToUpdate
function PitBull:_UpdateLayout(frame, force)
	if not frames[frame] or (not force and (lazyLayout ~= 0 or not layoutsToUpdate or not layoutsToUpdate[frame])) then
		return
	end
	if not force then
		layoutsToUpdate[frame] = nil
	end
	local unit = frame:GetUnit()

	if metaLayout.extraFrames then
		for k, v in pairs(metaLayout.extraFrames) do
			if frame[k] then
				frame[k] = delFrame(frame[k])
			end
		end
	end

	local tmp, tmp2 = newList(), newList()

	for k, v in pairs(frame) do
		if not ignore[k] and type(k) == "string" and isframe(v) then
			tmp2[k] = v
			tmp[k] = v:IsShown()
			v:Show()
			v:ClearAllPoints()
			v:SetWidth(0)
			v:SetHeight(0)
			if v.SetScale then
				v:SetScale(1)
			end
			local objectType = v:GetObjectType()
			if objectType == "FontString" then
				local fontObject = v:GetFontObject()
				if fontObject then
					v:SetFont(fontObject:GetFont())
				end
				v:SetJustifyH("CENTER")
				v:SetJustifyV("MIDDLE")
				v:SetHeight(1)
			elseif objectType == "StatusBar" then
				v:SetOrientation("HORIZONTAL")
			end
		end
	end

	if metaLayout.extraFrames then
		for k, v in pairs(metaLayout.extraFrames) do
			v(unit, frame, k)
			if frame[k] then
				tmp2[k] = frame[k]
				tmp[k] = frame[k]:IsShown()
			end
		end
	end
	
	for k, v in pairs(tmp2) do
		tmp2[k] = nil
		local func = metaLayout.positions[k]
		if type(func) == "function" then
			local success, ret = pcall(func, unit, frame, k)
			if not success then
--				self:Print("There was an error with the layout %q, preventing the frame for %q to be shown properly. Please inform the author: %s", layoutName, unit, ret)
				geterrorhandler()(ret)
				v:Hide()
			end
		else
			local module = frameToModule[k]
			if module and type(module.OnUnknownLayout) == "function" then
				local success, ret = pcall(module.OnUnknownLayout, module, unit, frame, k)
				if not success then
					geterrorhandler()(ret)
					v:Hide()
				end
			end
		end
		if tmp[k] ~= v:IsShown() then
			-- change of visibility
			if v:IsObjectType("FontString") and v:IsShown() then
				DogTag:UpdateFontString(v)
			end
		end
		tmp[k] = nil
	end
	tmp, tmp2 = del(tmp), del(tmp2)
	
	if type(metaLayout.positions.always) == "function" then
		local success, ret = pcall(metaLayout.positions.always, unit, frame)
		if not success then
			self:Print("There was an error with the layout %q, preventing the function \"always\" for %q from being called properly. Please inform the author: %s", layoutName, unit, ret)
		end
	end
	
	self:CallMethodOnAllModules(true, "OnUpdateLayout", unit, frame)
	
	self:UpdateLayoutSettings(frame.group)
end

function PitBull:_UpdateLayouts()
	if lazyLayout ~= 0 or not layoutsToUpdate then
		return
	end
	local f = layoutsToUpdate
	layoutsToUpdate = nil
	for frame in pairs(f) do
		self:_UpdateLayout(frame, true)
	end
	f = del(f)
	Rock("LibRockConfig-1.0"):RefreshConfigMenu(self)
--	Dewdrop:Refresh(1)
--	Dewdrop:Refresh(2)
--	Dewdrop:Refresh(3)
--	Dewdrop:Refresh(4)
--	Dewdrop:Refresh(5)
end

function PitBull:UpdateLayout(frame)
	if not isframe(frame) then
		error(("Bad argument #2 to `UpdateLayout'. Expected %s, got %s"):format("frame", type(frame)), 2)
	end

--	if lazyLayout == 0 then
--		self:_UpdateLayout(frame, true)
--		return
--	end
	
	if not layoutsToUpdate then
		layoutsToUpdate = newList()
	end
	
	layoutsToUpdate[frame] = true
	if lazyLayout == 0 then
		self:AddTimer("PitBull-UpdateLayouts", 0, "_UpdateLayouts")
	end
end

function PitBull:UpdateAllLayouts()
	lazyLayout = lazyLayout + 1
	for unit, frame in self:IterateUnitFrames() do
		self:UpdateLayout(frame)
	end
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
end

function PitBull:UpdateBackdropAndBorder(frame, force)
	if not isframe(frame) then
		error(("Bad argument #2 to `UpdateBackdropAndBorder'. Expected %s, got %s"):format("frame", type(frame)), 2)
	end
	local unit = frame:GetUnit()
	local classification = self.db.profile.settings.showEliteBorder and UnitClassification(unit)
	local border
	local r, g, b, a
	if classification == "worldboss" or classification == "elite" then
		border = SharedMedia:Fetch('border', "Blizzard Tooltip") or SharedMedia_border_None
		r, g, b = unpack(self.colorConstants.elite)
		a = self.colorConstants.frameBorder[4]
	elseif classification == "rare" or classification == "rareelite" then
		border = SharedMedia:Fetch('border', "Blizzard Tooltip") or SharedMedia_border_None
		r, g, b = unpack(self.colorConstants.rare)
		a = self.colorConstants.frameBorder[4]
	else
		border = SharedMedia:Fetch('border', self.db.profile.groups[frame.group].border) or SharedMedia_border_None
		r, g, b, a = unpack(self.colorConstants.frameBorder)
	end
	if not force and frame.backdrop and frame.backdrop.classification == classification and frame.backdrop.border == border then
		return
	end
	if frame.backdrop then
		frame.backdrop.classification = nil
		frame.backdrop.border = nil
		frame.backdrop = delFrame(frame.backdrop)
	end
	if frame.border1 then
		for i = 1, 8 do
			frame['border' .. i] = delFrame(frame['border' .. i])
		end
	end
	local edgeSize, inset
	if border == SharedMedia_border_None then
		edgeSize = 0
		inset = 3
	else
		edgeSize = 16
		inset = 4
	end
	local bg = newFrame("Texture", frame, "BACKGROUND")
	frame.backdrop = bg
	frame.backdrop.classification = classification
	frame.backdrop.border = border
	bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	bg:SetVertexColor(unpack(self.db.profile.settings.colors.frameBG))
	bg:SetHeight(16)
	bg:SetWidth(16)
	bg:SetPoint("TOPLEFT", frame, "TOPLEFT", inset - 5, -inset + 5)
	bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -inset + 5, inset - 5)
	if border ~= SharedMedia_border_None then
		local edgeFile = border
		local border = newFrame("Texture", frame, "BORDER")
		frame.border1 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize)
		border:SetHeight(edgeSize)
		border:SetPoint("TOPLEFT", frame, "TOPLEFT", -5, -edgeSize + 5)
		border:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -5, edgeSize - 5)
		border:SetTexCoord(0, 0, 0, 1.948, 0.125, 0, 0.125, 1.948)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border2 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize)
		border:SetHeight(edgeSize)
		border:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 5, -edgeSize + 5)
		border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, edgeSize - 5)
		border:SetTexCoord(0.125, 0, 0.125, 1.948, 0.25, 0, 0.25, 1.948)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border3 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize*8)
		border:SetHeight(edgeSize)
		border:SetPoint("TOPLEFT", frame, "TOPLEFT", edgeSize - 5, 5)
		border:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -edgeSize + 5, 5)
		border:SetTexCoord(0.25, 9.2808, 0.375, 9.2808, 0.25, 0, 0.375, 0)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border4 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize*8)
		border:SetHeight(edgeSize)
		border:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", edgeSize - 5, -5)
		border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -edgeSize + 5, -5)
		border:SetTexCoord(0.375, 9.2808, 0.5, 9.2808, 0.375, 0, 0.5, 0)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border5 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize)
		border:SetHeight(edgeSize)
		border:SetPoint("TOPLEFT", frame, "TOPLEFT", -5, 5)
		border:SetTexCoord(0.5, 0, 0.5, 1, 0.625, 0, 0.625, 1)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border6 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize)
		border:SetHeight(edgeSize)
		border:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 5, 5)
		border:SetTexCoord(0.625, 0, 0.625, 1, 0.75, 0, 0.75, 1)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border7 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize)
		border:SetHeight(edgeSize)
		border:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -5, -5)
		border:SetTexCoord(0.75, 0, 0.75, 1, 0.875, 0, 0.875, 1)
		local border = newFrame("Texture", frame, "BORDER")
		frame.border8 = border
		border:SetTexture(edgeFile)
		border:SetVertexColor(r, g, b, a)
		border:SetWidth(edgeSize)
		border:SetHeight(edgeSize)
		border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, -5)
		border:SetTexCoord(0.875, 0, 0.875, 1, 1, 0, 1, 1)
	end
end

function PitBull:UpdateAllBackdropsAndBorders(force)
	for unit, frame in self:IterateUnitFrames() do
		self:UpdateBackdropAndBorder(frame, force)
	end
end

function PitBull:AreUnitFramesClampedToScreen()
	return self.db.profile.settings.clamped
end

function PitBull:ToggleUnitFramesClampedToScreen(value)
	if value == nil then
		value = not self.db.profile.settings.clamped
	end
	self.db.profile.settings.clamped = value
	for frame in pairs(allFrames) do
		frame:SetClampedToScreen(value)
	end
end

function PitBull:_PopulateUnitFrame(frame)
	if frames[frame] then
		local oldName = frame.__name
		frame.__name = nil
		if frame:GetUnitName() ~= oldName then
			framesByUnitName_needsUpdate = true
			lazyLayout = lazyLayout + 1
			self:UpdateLayout(frame)
			self:UpdateFrame(frame)
			lazyLayout = lazyLayout - 1

			self:_UpdateLayout(frame)
		end
		return
	else
		if not allFrames[frame] then
			return
		end
	end
	local unit = frame:GetUnit()
	
	local group = frame.group
	if not unit or not group or self.db.profile.groups[group].hidden or (not UnitExists(unit) and not configMode) then
		self:ClearUnitFrame(frame)
		return
	end
	self:AddGroupToAceOptions(group)
	
	if not frame.overlay then
		local overlay = newFrame("Frame", frame)
		frame.overlay = overlay
		overlay:SetFrameLevel(frame:GetFrameLevel()+3)
	end
	
	lazyLayout = lazyLayout + 1
	self:CallMethodOnAllModules(true, "OnPopulateUnitFrame", unit, frame)
	
	frames[frame] = true
	framesByUnit_needsUpdate = true
	if not framesByGroup[group] then
		framesByGroup[group] = newList()
	end
	framesByGroup[group][frame] = true
	if not IsWackyGroup[group] then
		nonWackyFrames[frame] = true
	end
	
	self:UpdateLayout(frame)
	self:UpdateBackdropAndBorder(frame)
	self:UpdateFrame(frame)
	lazyLayout = lazyLayout - 1
	
	self:_UpdateLayout(frame)
	
	if frame.cluster then
		local header = clusters[frame.cluster]
		if configMode then
			local child1 = header:GetAttribute("child1")
			if child1 and child1:IsShown() then
				header.label:Show()
			else
				header.label:Hide()
			end
		else
			header.label:Hide()
		end
	end
end

function PitBull:_ClearUnitFrame(frame)
	if currentMovingFrame then
		currentMovingFrame:StopMovingOrSizing()
		currentMovingFrame = nil
	end
	if not frames[frame] then
		return
	end
	local unit = frame:GetUnit()
	
	local oldName = frame.__name
	frame.__name = nil
	if oldName then
		framesByUnitName_needsUpdate = true
	end
	
	local group = frame.group
	if not group then
		error(("Frame <%s> does not have the necessary .group"):format(frame:GetName()))
	end

	if metaLayout.extraFrames then
		for k, v in pairs(metaLayout.extraFrames) do
			if frame[k] then
				frame[k] = delFrame(frame[k])
			end
		end
	end
	
	self:CallMethodOnAllModules(true, "OnClearUnitFrame", unit, frame)

	frame.overlay = delFrame(frame.overlay)

	if frame.backdrop then
		frame.backdrop = delFrame(frame.backdrop)
	end
	if frame.border1 then
		for i = 1, 8 do
			frame['border' .. i] = delFrame(frame['border' .. i])
		end
	end

	if not unit then
		unit = 'dummy'
	end

	frames[frame] = nil
	framesByUnit_needsUpdate = true
	framesByGroup[group][frame] = nil
	if not next(framesByGroup[group]) then
		framesByGroup[group] = del(framesByGroup[group])
	end
	nonWackyFrames[frame] = nil
	
	if frame.cluster then
		local header = clusters[frame.cluster]
		if configMode then
			local child1 = header:GetAttribute("child1")
			if not child1 or not child1:IsShown() then
				header.label:Hide()
			else
				header.label:Show()
			end
		else
			header.label:Hide()
		end
	end
end

local framesToPopulate, framesToClear

function PitBull:_ClearAndPopulateUnitFrames()
	if framesToClear then
		local f = framesToClear
		framesToClear = nil
		for frame in pairs(f) do
			self:_ClearUnitFrame(frame)
		end
		f = del(f)
	end
	if framesToPopulate then
		local f = framesToPopulate
		framesToPopulate = nil
		for frame in pairs(f) do
			self:_PopulateUnitFrame(frame)
		end
		f = del(f)
	end
end

function PitBull:PopulateUnitFrame(frame, force)
	if not isframe(frame) then
		error(("Bad argument #2 to `PopulateUnitFrame'. Expected %s, got %s"):format("frame", type(frame)), 2)
	end
	if framesToClear and framesToClear[frame] then
		framesToClear[frame] = nil
		return
	end
	if frames[frame] then
		local oldName = frame.__name
		frame.__name = nil
		if force or oldName ~= frame:GetUnitName() then
			framesByUnitName_needsUpdate = true
			lazyLayout = lazyLayout + 1
			self:UpdateLayout(frame)
			self:UpdateFrame(frame)
			lazyLayout = lazyLayout - 1

			self:_UpdateLayout(frame)
		end
		return
	else
		if not allFrames[frame] then
			return
		end
	end
	if not framesToPopulate then
		framesToPopulate = newList()
		self:AddTimer("PitBull-ClearAndPopulateUnitFrames", 0, "_ClearAndPopulateUnitFrames")
	end
	
	framesToPopulate[frame] = true
end

function PitBull:ClearUnitFrame(frame)
--	do return end
	if not isframe(frame) then
		error(("Bad argument #2 to `ClearUnitFrame'. Expected %s, got %s"):format("frame", type(frame)), 2)
	end
	if framesToPopulate and framesToPopulate[frame] then
		framesToPopulate[frame] = nil
		return
	end
	if not frames[frame] then
		return
	end
	if not framesToClear then
		framesToClear = newList()
		self:AddTimer("PitBull-ClearAndPopulateUnitFrames", 0, "_ClearAndPopulateUnitFrames")
	end
	
	framesToClear[frame] = true
end

local function frame_custom_menu(this, unit)
	PitBull:OpenConfigMenu(this.group)
end

local function frame_menu(this, unit)
	local type, num
	
	if unit == "player" then
		type = PlayerFrameDropDown
	elseif unit == "target" then
		type = TargetFrameDropDown
	elseif unit == "pet" then
		type = PetFrameDropDown
	else
		num = unit:match("^party(%d)$")
		if num then
			type = _G["PartyMemberFrame" .. num .. "DropDown"]
		else
			num = unit:match("^raid(%d%d?)$")
			if num then
				type = FriendsDropDown
				this.unit = unit
				this.name = UnitName(unit)
				this.id = this:GetID()
				FriendsDropDown.displayMode = "MENU"
				FriendsDropDown.initialize = RaidFrameDropDown_Initialize
			else
				return-- frame_custom_menu(this, unit)
			end
		end
	end
	
	if num then
		PitBull:ScheduleLeaveCombatAction(this, "SetID", tonumber(num))
	end

	if type then
		HideDropDownMenu(1)
		type.unit = unit
		type.name = UnitName(unit)
		ToggleDropDownMenu(1, nil, type, "cursor")
		return true
	end
end

local function frame_OnEnter(this)
	if not frames[this] then
		return
	end
	local unit = this:GetUnit()
	self:CallMethodOnAllModules(true, "OnFrameOnEnter", unit, this)
	if not PitBull.db.profile.settings.hideTooltipInCombat or not InCombatLockdown() then
		this.unit = unit
		UnitFrame_OnEnter(this)
		this.unit = nil
	end
end

local function frame_OnLeave(this)
	if not frames[this] then
		return
	end
	local unit = this:GetUnit()
	self:CallMethodOnAllModules(true, "OnFrameOnLeave", unit, this)
	UnitFrame_OnLeave(this)
end

local function frame_OnDragStart(this)
	if PitBull.db.profile.settings.locked then
		return
	end
	if not frames[this] then
		return
	end
	
	if currentMovingFrame then
		currentMovingFrame:StopMovingOrSizing()
		currentMovingFrame = nil
	end
	
	-- also want to move group if grouped
	local cluster = this.cluster
	if cluster --[[ and not PitBull.db.profile.groups[this.group].freeform ]] then
		currentMovingFrame = clusters[cluster]
		clusters[cluster]:StartMoving()
	else
		currentMovingFrame = this
		this:StartMoving()
	end
end

local function frame_OnDragStop(this)
	if not frames[this] then
		return
	end
	
	local cluster = this.cluster
	local freeform = false --PitBull.db.profile.groups[this.group].freeform
	local db
	if cluster and not freeform then
		this = clusters[cluster]
		db = self.db.profile.clusters[cluster]
	else
		local unit = this:GetUnit()
		db = self.db.profile.units[unit]
	end
	
	if currentMovingFrame then
		currentMovingFrame:StopMovingOrSizing()
		currentMovingFrame = nil
	end
	
	local x, y = this:GetCenter()
	local s = this:GetEffectiveScale()
	local uis = UIParent:GetScale()
	local incombat = InCombatLockdown()
	if not incombat then
		this:ClearAllPoints()
	end
	local point
	if cluster and not freeform then
		local direction = self.db.profile.groups[this.group].direction
		if direction == "up" then
			point = "BOTTOM"
			y = this:GetBottom()
		elseif direction == "right" then
			point = "LEFT"
			x = this:GetLeft()
		elseif direction == "left" then
			point = "RIGHT"
			x = this:GetRight()
		else
			point = "TOP"
			y = this:GetTop()
		end
	else
		point = "CENTER"
	end
	x = x*s - GetScreenWidth()*uis/2
	y = y*s - GetScreenHeight()*uis/2
	db.x, db.y = x/uis, y/uis
	if not incombat then
		this:SetPoint(point, UIParent, "CENTER", x/s, y/s)
	end
	
	if cluster and not freeform then
		PitBull:ReorganizeCluster(cluster)
	end
	
	Rock("LibRockConfig-1.0"):RefreshConfigMenu(self)
end

local function frame_OnShow(this)
	local unit = this:GetUnit()
	if not unit then
		return
	end
	
	if not ShouldShowUnit(unit) then
		return
	elseif PitBull.db.profile.groups[this.group].hidden then
		return
	end
	
	framesByUnit_needsUpdate = true
	PitBull:PopulateUnitFrame(this)
end

local function frame_OnHide(this)
	local unit = this:GetUnit()
	if not unit then
		return
	end
	framesByUnit_needsUpdate = true
	
	PitBull:ClearUnitFrame(this)
end

local last_frameToUnit = {}

local function update_framesWithChangedUnits()
	for this, lastUnit in pairs(framesWithChangedUnit) do
		self:CallMethodOnAllModules(true, "OnUnitFrameUnitChange", this:GetUnit(), this, lastUnit)
	end
end

local function frame_OnAttributeChanged(this, key, value)
	if key ~= "unit" and key ~= "unitsuffix" then
		return
	end
	
	local lastUnit = last_frameToUnit[this]
--	this.__unit = nil
	local unit = this:GetUnit()
--	this.__unit = unit
	if unit == lastUnit then
		return
	end
	if not UnitExists(unit) then
		last_frameToUnit[this] = nil
		return
	end	
	last_frameToUnit[this] = unit
	PitBull:UpdateLayout(this)
	framesWithChangedUnit[this] = lastUnit
	
	PitBull:AddTimer("Pitbull-Check-update_framesWithChangedUnits", 0, update_framesWithChangedUnits)
end

local function UnitFrame_GetUnit(self)
	if self.__unit then
		return self.__unit
	end
	local unit = self:GetAttribute("unit")
	if unit then
		local suffix = self:GetAttribute("unitsuffix")
		if suffix then
			unit = unit .. suffix
			unit = unit:gsub("^([^%d]+)([%d]+)pet", "%1pet%2")
		end
		if unit:find("^player.") then
			unit = unit:sub(7)
		end
		return unit
	else
		local group = self.group
		if group then
			if group:find("^raidpet") then
				return "raidpet" .. (NumRaidMembers+1) .. group:sub(8)
			elseif group:find("^raid") then
				return "raid" .. (NumRaidMembers+1) .. group:sub(5)
			elseif group:find("^partypet") then
				return "partypet" .. (NumPartyMembers+1) .. group:sub(9)
			elseif group:find("^party") then
				return "party" .. (NumPartyMembers+1) .. group:sub(6)
			elseif group:find("^maintankpet") then
				return "raidpet" .. (NumRaidMembers+1) .. group:sub(12)
			elseif group:find("^mainassistpet") then
				return "raidpet" .. (NumRaidMembers+1) .. group:sub(14)
			elseif group:find("^maintank") then
				return "raid" .. (NumRaidMembers+1) .. group:sub(9)
			elseif group:find("^mainassist") then
				return "raid" .. (NumRaidMembers+1) .. group:sub(11)
			else
				return group
			end
		end
		return nil
	end
end

local function UnitFrame_GetUnitName(self)
	if self.__name then
		return self.__name
	end
	local name, server = UnitName(self:GetUnit())
	if server and server ~= "" then
		name = name .. "-" .. server
	end
	self.__name = name
	return name
end

local count = 0
local cache = {}
local function configFrame_OnMouseDown(this, button)
	local unit = this:GetUnit()
	if not UnitExists(unit) and button == "RightButton" then
		this:custom_menu(unit)
	end
end
function PitBull:CreateUnitFrame(unit, secure)
	local preframe
	if type(unit) == "table" then
		preframe = unit
		unit = nil
	elseif type(unit) ~= "string" then
		error(("Bad argument #2 to `CreateUnitFrame'. Expected %s, got %s"):format("string or table", type(unit)), 2)
	end
	local frame
	if not preframe then
		if framesByUnit_needsUpdate then
			updateFramesByUnit()
		end
		local frame = framesByUnit[unit] and next(framesByUnit[unit])
		if frame then
			lazyLayout = lazyLayout + 1
			self:UpdateLayout(frame)
			self:UpdateFrame(frame)
			lazyLayout = lazyLayout - 1

			self:_UpdateLayout(frame)
			return frame
		end
	elseif frames[preframe] then
		lazyLayout = lazyLayout + 1
		self:UpdateLayout(preframe)
		self:UpdateFrame(preframe)
		lazyLayout = lazyLayout - 1

		self:_UpdateLayout(preframe)
		return preframe
	end
	
	if not preframe and not IsLegitimateUnit[unit] then
		error(("Bad argument #2 to `CreateUnitFrame': %q is not a legitimate unit"):format(unit), 2)
	end
	
	local setup = false
	if not preframe then
		if #cache == 0 then
			count = count + 1
			local name = "PitBullUnitFrame" .. count
			frame = CreateFrame("Button", name, UIParent, "SecureUnitButtonTemplate")
			frame:Hide()
			setup = true
		else
			frame = table_remove(cache, 1)
		end
	else
		frame = preframe
		if frame:GetScript("OnEnter") ~= frame_OnEnter then
			setup = true
		end
	end
	
	if setup then
		frame.GetUnit = UnitFrame_GetUnit
		frame.GetUnitName = UnitFrame_GetUnitName
		frame:EnableMouse(true)
		frame:SetScript("OnEnter", frame_OnEnter)
		frame:SetScript("OnLeave", frame_OnLeave)
		frame:SetScript("OnDragStart", frame_OnDragStart)
		frame:SetScript("OnDragStop", frame_OnDragStop)
		frame:SetScript("OnHide", frame_OnHide)
		frame:SetScript("OnShow", frame_OnShow)
		frame:SetMovable(true)
		frame:RegisterForDrag("LeftButton")
		frame:RegisterForClicks("LeftButtonUp","RightButtonUp","MiddleButtonUp","Button4Up","Button5Up")
		frame:SetAttribute("*type1", "target")
		frame:SetAttribute("type2", "menu")
		frame:SetAttribute("*type2", "custom_menu")
		frame.menu = frame_menu
		frame.custom_menu = frame_custom_menu
		frame:SetClampedToScreen(self.db.profile.settings.clamped)
	end
	
	local group, cluster
	if not preframe then
		group = unit:gsub("%d", "")
		frame.group = group
	else
		group = frame.group
		cluster = frame.cluster
	end
	
	allFrames[frame] = true
	if not allFramesByGroup[group] then
		allFramesByGroup[group] = newList()
	end
	allFramesByGroup[group][frame] = true
	if secure then
		frame:SetAttribute("initial-width", self.db.profile.groups[group].width)
		frame:SetAttribute("initial-height", self.db.profile.groups[group].height)
		frame:SetAttribute("initial-scale", self.db.profile.groups[group].scale)
	else
		frame:SetWidth(self.db.profile.groups[group].width)
		frame:SetHeight(self.db.profile.groups[group].height)
		frame:SetScale(self.db.profile.groups[group].scale)
	end

	-- db.{x,y} are scaled coordinates, in the UIParent scale.  Switch from
	-- that scale to the frame's scale.
	if cluster then
		if not allFramesByCluster[clusters[cluster]] then
			allFramesByCluster[clusters[cluster]] = newList()
		end
		allFramesByCluster[clusters[cluster]][frame] = true
	else
		if not preframe then
			local db = self.db.profile.units[unit]
			local uis = UIParent:GetScale()
			local s = frame:GetEffectiveScale()
			frame:SetPoint("CENTER", db.x*uis/s, db.y*uis/s)
		end
	end
	
	if IsWackyGroup[group] or unit == "focus" then
		wackyFrames[frame] = true
	else
		wackyFrames[frame] = nil
	end
	
	if not preframe then
		frame:SetAttribute("unit", unit)
		
		if configMode or UnitExists(unit) then
			self:PopulateUnitFrame(frame)
		end
	else
		frame:SetScript("OnAttributeChanged", frame_OnAttributeChanged)
	end
	
	ClickCastFrames[frame] = true
	
	if not secure then
		if not configMode then
			RegisterUnitWatch(frame)
		else
			frame:Show()
			frame:SetScript("OnMouseDown", configFrame_OnMouseDown)
		end
	else
		frame:SetAttribute("initial-unitWatch", true)
	end
	
	framesByUnit_needsUpdate = true
	
	self:UpdateAllFrameStratas(frame)
	
	return frame
end

function PitBull:DestroyUnitFrame(frame)
	if not isframe(frame) then
		error(("Bad argument #2 to `DestroyUnitFrame'. Expected %s, got %s"):format("frame", type(frame)), 2)
	end
	local group = frame.group
	if not allFramesByGroup[group] then
		return
	end
	local unit = frame:GetUnit() or 'dummy'
	self:_ClearUnitFrame(frame)
	cache[#cache+1] = frame
	UnregisterUnitWatch(frame)
	frame:Hide()
	frame:SetAttribute("unit", nil)
	frame.group = nil
	frames[frame] = nil
	framesByUnit_needsUpdate = true
	allFrames[frame] = nil
	if framesByGroup[group] then
		framesByGroup[group][frame] = nil
		if not next(framesByGroup[group]) then
			framesByGroup[group] = del(framesByGroup[group])
		end
	end
	allFramesByGroup[group][frame] = nil
	if not next(allFramesByGroup[group]) then
		allFramesByGroup[group] = del(allFramesByGroup[group])
	end
	if frame.cluster then
		local cluster = frame.cluster
		frame.cluster = nil
		allFramesByCluster[clusters[cluster]][frame] = nil
		if not next(allFramesByCluster[clusters[cluster]]) then
			allFramesByCluster[clusters[cluster]] = del(allFramesByCluster[clusters[cluster]])
		end
	end
	nonWackyFrames[frame] = nil
	wackyFrames[frame] = nil
end

local count = 0
local groupCache = {}
local function GetClusterGroupSuffixKind(name)
	local base = name:match("^(raid)") or name:match("^(party)") or nil
	local suffix = name:match("^raid(.*)$") or name:match("^party(.*)$") or nil
	local clusterKind
	if suffix == "" then
		suffix = nil
	end
	if suffix then
		local goodsuffix = ''
		while suffix:find("target$") do
			suffix = suffix:sub(1, -7)
			goodsuffix = "target" .. goodsuffix
		end
		if suffix:find("pet$") then
			suffix = suffix:sub(1, -4)
			goodsuffix = "pet" .. goodsuffix
		end
		clusterKind = suffix
		suffix = goodsuffix
	end
	local group = base
	if clusterKind == "MAINTANK" then
		group = "maintank"
	elseif clusterKind == "MAINASSIST" then
		group = "mainassist"
	end
	if suffix then
		group = group .. suffix
	end
	return name, group, suffix, tonumber(clusterKind) or (clusterKind ~= "" and clusterKind or nil)
end

local classes = {"WARRIOR", "HUNTER", "ROGUE", "PALADIN", "SHAMAN", "PRIEST", "MAGE", "WARLOCK", "DRUID"}
local function figureClusterLabel(baseGroup, clusterKind, suffix)
	if suffix == "" then
		suffix = nil
	end
	local s
	if type(clusterKind) == "number" then
		s = L["Group %d"]:format(clusterKind)
	elseif clusterKind then
		if clusterKind == "MAINTANK" then
			s = suffix and L["Main tank"] or L["Main tanks"]
		elseif clusterKind == "MAINASSIST" then
			s = suffix and L["Main assist"] or L["Main assists"]
		elseif clusterKind == "WARRIOR" then
			s = suffix and L["Warrior"] or L["Warriors"]
		elseif clusterKind == "HUNTER" then
			s = suffix and L["Hunter"] or L["Hunters"]
		elseif clusterKind == "ROGUE" then
			s = suffix and L["Rogue"] or L["Rogues"]
		elseif clusterKind == "PALADIN" then
			s = suffix and L["Paladin"] or L["Paladins"]
		elseif clusterKind == "SHAMAN" then
			s = suffix and L["Shaman"] or L["Shamans"]
		elseif clusterKind == "PRIEST" then
			s = suffix and L["Priest"] or L["Priests"]
		elseif clusterKind == "MAGE" then
			s = suffix and L["Mage"] or L["Mages"]
		elseif clusterKind == "WARLOCK" then
			s = suffix and L["Warlock"] or L["Warlocks"]
		elseif clusterKind == "DRUID" then
			s = suffix and L["Druid"] or L["Druids"]
		else
			s = ("%q"):format(clusterKind)
		end
	else
		if baseGroup == "party" then
			s = L["Party"]
		else
			s = L["Raid"]
		end
	end
	while suffix do
		if suffix:find("^pet") then
			suffix = suffix:sub(4)
			if suffix == "" then
				suffix = nil
			end
			s = (suffix and L["%s pet"] or L["%s pets"]):format(s)
		elseif suffix:find("^target") then
			suffix = suffix:sub(7)
			if suffix == "" then
				suffix = nil
			end
			s = (suffix and L["%s target"] or L["%s targets"]):format(s)
		else
			break
		end
	end
	return s
end

local classes = {"WARRIOR", "HUNTER", "ROGUE", "PALADIN", "SHAMAN", "PRIEST", "MAGE", "WARLOCK", "DRUID"}
function PitBull:CreateUnitCluster(cluster)
	if not fullyInited or leftWorld then
		return
	end
	if lastDestroyTime >= GetTime() - 3 then
		return ScheduleCreateCluster(cluster)
	end
	if type(cluster) ~= "string" then
		error(("Bad argument #2 to `CreateUnitCluster'. Expected %s, got %s"):format("string", type(cluster)), 2)
	end
	if cluster:find("^maintank") then
		cluster = "raidMAINTANK" .. cluster:sub(9)
	elseif cluster:find("^mainassist") then
		cluster = "raidMAINASSIST" .. cluster:sub(11)
	end
	local raidGroupStyle = self.db.profile.groups.raid.groupStyle
	if cluster == "raid" or cluster == "raidpet" or cluster == "raidtarget" or cluster == "raidpettarget" then
		if raidGroupStyle == "class" then
			for i, v in ipairs(classes) do
				self:CreateUnitCluster("raid" .. v .. cluster:sub(5))
			end
			return
		elseif raidGroupStyle == "group" then
			for i = 1, 8 do
				self:CreateUnitCluster("raid" .. i .. cluster:sub(5))
			end
			return
		end
	end
	if clusters[cluster] then
		return
	end
	local baseGroup
	if cluster:find("^raidMAINTANK") then
		baseGroup = "maintank"
	elseif cluster:find("^raidMAINASSIST") then
		baseGroup = "mainassist"
	elseif cluster:find("^raid") then
		baseGroup = "raid"
	elseif cluster:find("^party") then
		baseGroup = "party"
	else
		error(("Bad argument #3 to `CreateUnitCluster'. Expected %s, got %q"):format('"^party" or "^raid"', cluster), 2)
	end
	local cluster, group, suffix, clusterKind = GetClusterGroupSuffixKind(cluster)
	local header
	if #groupCache > 0 then
		header = table_remove(groupCache, 1)
		if baseGroup == "party" then
			header:SetAttribute("showRaid", nil)
			header:SetAttribute("showParty", true)
		else
			header:SetAttribute("showRaid", true)
			header:SetAttribute("showParty", nil)
		end
	else
		count = count + 1
		header = CreateFrame("Frame", "PitBullCluster" .. count, UIParent, "SecureGroupHeaderTemplate")
		header:UnregisterEvent("UNIT_NAME_UPDATE")
		if baseGroup == "party" then
			header:SetAttribute("showParty", true)
		else
			header:SetAttribute("showRaid", true)
		end
	end
	if baseGroup == "party" and self.db.profile.groups.party.showPlayerInParty then
		header:SetAttribute("showPlayer", true)
	else
		header:SetAttribute("showPlayer", nil)
	end
	local label = newFrame("FontString", header, "OVERLAY")
	header.label = label
	local font, size = PitBull:GetFont()
	label:SetFont(font, size * 1.5)
	label:SetText(figureClusterLabel(baseGroup, clusterKind, suffix))
	label:SetPoint("BOTTOM", header, "TOP")
	clusters[cluster] = header
	header:SetMovable(true)
	header.group = group
	header.cluster = cluster
	local db = self.db.profile.clusters[cluster]
	header.initialConfigFunction = function(child)
		child.group = group
		child.cluster = cluster
		child:SetAttribute("unitsuffix", suffix)
		PitBull:CreateUnitFrame(child, true)
	end
	header:SetAttribute("template", "SecureUnitButtonTemplate")
	
	if self.db.profile.groups[baseGroup].nameSort then
		header:SetAttribute("sortMethod", "NAME")
	else
		header:SetAttribute("sortMethod", nil)
	end
	header:SetAttribute("groupBy", nil)
	header:SetAttribute("groupingOrder", nil)
	header:SetAttribute("groupFilter", nil)
	header:SetAttribute("strictFiltering", nil)
	if baseGroup == "maintank" or baseGroup == "mainassist" then
		local nameList = clusterKind == "MAINTANK" and GetRaidAssistMainTankNameList()
		if nameList then
			header:SetAttribute("nameList", nameList)
		else
			header:SetAttribute("groupFilter", clusterKind)
		end
	elseif baseGroup == "raid" then
		if raidGroupStyle == "class" or raidGroupStyle == "group" then
			header:SetAttribute("groupBy", nil)
		elseif raidGroupStyle == "flatGroup" then
			header:SetAttribute("groupBy", "GROUP")
			header:SetAttribute("groupingOrder", "1,2,3,4,5,6,7,8")
		elseif raidGroupStyle == "flatClass" then
			header:SetAttribute("groupBy", "CLASS")
			header:SetAttribute("groupingOrder", "WARRIOR,PALADIN,HUNTER,PRIEST,ROGUE,SHAMAN,WARLOCK,DRUID,MAGE")
		end
		if clusterKind then
			header:SetAttribute("strictFiltering", true)
			local t = newList()
			t[#t+1] = clusterKind
			if type(clusterKind) == "number" then
				if not self.db.profile.groups.raid.groupFilter[clusterKind] then
					t = del(t)
					self:DestroyUnitCluster(cluster)
					return
				end
				local classFilter = self.db.profile.groups.raid.classFilter
				for _,v in ipairs(classes) do
					if classFilter[v] then
						t[#t+1] = v
					end
				end
			else
				if not self.db.profile.groups.raid.classFilter[clusterKind] then
					t = del(t)
					self:DestroyUnitCluster(cluster)
					return
				end
				local groupFilter = self.db.profile.groups.raid.groupFilter
				for i = 1, 8 do
					if groupFilter[i] then
						t[#t+1] = i
					end
				end
			end
		
			header:SetAttribute("groupFilter", table_concat(t, ','))
			t = del(t)
		else
			header:SetAttribute("strictFiltering", true)
			local t = newList()
			local classFilter = self.db.profile.groups.raid.classFilter
			for _,v in ipairs(classes) do
				if classFilter[v] then
					t[#t+1] = v
				end
			end
			local groupFilter = self.db.profile.groups.raid.groupFilter
			for i = 1, 8 do
				if groupFilter[i] then
					t[#t+1] = i
				end
			end
			header:SetAttribute("groupFilter", table_concat(t, ','))
			t = del(t)
		end
	else -- party
		header:SetAttribute("groupFilter", "WARRIOR,PALADIN,HUNTER,PRIEST,ROGUE,SHAMAN,WARLOCK,DRUID,MAGE,1,2,3,4,5,6,7,8")
	end
	self:ReorganizeCluster(cluster)
	for i = 1, 40 do
		local child = header:GetAttribute('child' .. i)
		if child then
			child.group = group
			child.cluster = cluster
			child:SetAttribute("unitsuffix", suffix)
			PitBull:CreateUnitFrame(child)
		else
			break
		end
	end
	header:Show()
	
	label:Hide()
	if configMode then
		local child1 = header:GetAttribute("child1")
		if child1 and child1:IsShown() then
			label:Show()
		end
	end
end

function PitBull:DestroyUnitCluster(cluster)
	if type(cluster) ~= "string" then
		error(("Bad argument #2 to `DestroyUnitCluster'. Expected %s, got %s"):format("string", type(cluster)), 2)
	end
	local header = clusters[cluster]
	if not header then
		return
	end
	for i = 40, 1, -1 do
		local child = header:GetAttribute("child" .. i)
		if child then
			self:_ClearUnitFrame(child)
			wackyFrames[child] = nil
			child.group = nil
			child.cluster = nil
			child:SetAttribute("unit", nil)
			child:SetAttribute("unitsuffix", nil)
		end
	end
	groupCache[#groupCache+1] = header
	header.label = delFrame(header.label)
	if currentMovingFrame then
		currentMovingFrame:StopMovingOrSizing()
		currentMovingFrame = nil
	end
	header:Hide()
	header:SetAttribute("template", nil)
	header:SetAttribute("sortMethod", nil)
	header:SetAttribute("groupBy", nil)
	header:SetAttribute("groupFilter", nil)
	clusters[cluster] = nil
end

function PitBull:ChangePositionX(group, value)
	if self.db.profile.units[group].x == value then
		return
	end
	self.db.profile.units[group].x = value
	local y = self.db.profile.units[group].y
	
	if allFramesByGroup[group] then
		local uis = UIParent:GetScale()
		for frame in pairs(allFramesByGroup[group]) do
			local s = frame:GetEffectiveScale()
			frame:SetPoint("CENTER", UIParent, "CENTER", value*uis/s, y*uis/s)
		end
	end
end

function PitBull:ChangePositionY(group, value)
	if self.db.profile.units[group].y == value then
		return
	end
	self.db.profile.units[group].y = value
	local x = self.db.profile.units[group].x
	
	if allFramesByGroup[group] then
		local uis = UIParent:GetScale()
		for frame in pairs(allFramesByGroup[group]) do
			local s = frame:GetEffectiveScale()
			frame:SetPoint("CENTER", UIParent, "CENTER", x*uis/s, value*uis/s)
		end
	end
end

function PitBull:ChangeScale(group, value)
	if self.db.profile.groups[group].scale == value then
		return
	end
	self.db.profile.groups[group].scale = value
	
	lazyLayout = lazyLayout + 1
	if allFramesByGroup[group] then
		for frame in pairs(allFramesByGroup[group]) do
			frame:SetScale(value)
			
			if frames[frame] then
				self:UpdateLayout(frame)
			end
		end
	end
	lazyLayout = lazyLayout - 1
	
	self:AddTimer("PitBull-UpdateLayouts", 0, "_UpdateLayouts")
end

function PitBull:ChangeWidth(group, value)
	if self.db.profile.groups[group].width == value then
		return
	end
	self.db.profile.groups[group].width = value
	
	lazyLayout = lazyLayout + 1
	if allFramesByGroup[group] then
		for frame in pairs(allFramesByGroup[group]) do
			frame:SetWidth(value)
			
			if frames[frame] then
				self:UpdateLayout(frame)
			end
		end
	end
	lazyLayout = lazyLayout - 1
	
	self:AddTimer("PitBull-UpdateLayouts", 0, "_UpdateLayouts")
end

function PitBull:ChangeHeight(group, value)
	if self.db.profile.groups[group].height == value then
		return
	end
	self.db.profile.groups[group].height = value
	
	lazyLayout = lazyLayout + 1
	if allFramesByGroup[group] then
		for frame in pairs(allFramesByGroup[group]) do
			frame:SetHeight(value)
			
			if frames[frame] then
				self:UpdateLayout(frame)
			end
		end
	end
	lazyLayout = lazyLayout - 1
	
	self:AddTimer("PitBull-UpdateLayouts", 0, "_UpdateLayouts")
end

function PitBull:GetStatusBarTexture()
	return SharedMedia:Fetch('statusbar', self.db.profile.settings.texture)
end

function PitBull:GetFont()
	return SharedMedia:Fetch('font', self.db.profile.settings.font), self.db.profile.settings.fontsize
end

function PitBull:UpdateAllStatusBarTextures()
	local texture = PitBull:GetStatusBarTexture()
	self:CallMethodOnAllModules(true, "OnUpdateStatusBarTexture", texture)
end

function PitBull:UpdateAllFonts()
	local font, fontsize = PitBull:GetFont()
	self:CallMethodOnAllModules(true, "OnUpdateFont", font, fontsize)
	lazyLayout = lazyLayout + 1
	for frame in pairs(frames) do
		self:UpdateLayout(frame)
	end
	lazyLayout = lazyLayout - 1
	
	self:AddTimer("PitBull-UpdateLayouts", 0, "_UpdateLayouts")
end

function PitBull.SharedMedia_Registered(kind, name)
	local self = PitBull
	if kind == "statusbar" then
		if self.db.profile and name == self.db.profile.settings.texture then
			self:UpdateAllStatusBarTextures()
		end
	elseif kind == "font" then
		if self.db.profile and name == self.db.profile.settings.font then
			self:UpdateAllFonts()
		end
	end
end

local function iter(tmp)
	local n = tmp.n + 1
	tmp.n = n
	local frame = tmp[n]
	if not frame then
		tmp = del(tmp)
		return
	end
	tmp[n] = nil
	if frame:IsShown() then
		return frame:GetUnit(), frame
	else
		return iter(tmp)
	end
end
function PitBull:IterateUnitFrames()
	local tmp = newList()
	for frame in pairs(frames) do
		tmp[#tmp+1] = frame
	end
	tmp.n = 0
	return iter, tmp
end

local function blankIter() end
function PitBull:IterateUnitFramesByGroup(group)
	local g = framesByGroup[group]
	if not g then
		return blankIter
	else
		local tmp = newList()
		for frame in pairs(g) do
			tmp[#tmp+1] = frame
		end
		tmp.n = 0
		return iter, tmp
	end
end

do
	local extraFramesByUnit = {}
	local extraFramesByUnit_nextUpdate = 0

	function PitBull:IterateUnitFramesForUnit(unit, includeTargetFrames)
		if not unit then
			return blankIter
		end
		if framesByUnit_needsUpdate then
			updateFramesByUnit()
			for k,v in pairs(extraFramesByUnit) do
				extraFramesByUnit[k] = del(v)
			end
			extraFramesByUnit_nextUpdate = GetTime() + 0.15
		end
		local g = framesByUnit[unit]
		if not includeTargetFrames then
			if not g then
				return blankIter
			else
			 	return pairs(g)
			end
		else
			local now = GetTime()
			if extraFramesByUnit_nextUpdate <= now then
				for k,v in pairs(extraFramesByUnit) do
					extraFramesByUnit[k] = del(v)
				end
				extraFramesByUnit_nextUpdate = now + 0.15
			elseif extraFramesByUnit[unit] then
				return pairs(extraFramesByUnit[unit])
			end
			local t = newList()
			extraFramesByUnit[unit] = t
			if g then
				for k,v in pairs(g) do
					t[k] = v
				end
			end
			for frame in pairs(wackyFrames) do
				local u = frame:GetUnit()
				if u:match("target$") and UnitIsUnit(unit, u) then
					t[frame] = true
				end
			end
			return pairs(t)
		end
	end
end

do
	local framesByUnitName = {}

	function PitBull:IterateUnitFramesForUnitName(name)
		if not name then
			return blankIter
		end
		if framesByUnitName_needsUpdate then
			framesByUnitName_needsUpdate = false
			for k,v in pairs(framesByUnitName) do
				framesByUnitName[k] = del(v)
			end
			for frame in pairs(frames) do
				local name = frame:GetUnitName()
				if not framesByUnitName[name] then
					framesByUnitName[name] = newList()
				end
				framesByUnitName[name][frame] = true
			end
		end
	
		local g = framesByUnitName[name]
		if not g then
			return blankIter
		else
		 	return pairs(g)
		end
	end
end

function PitBull:IterateNonWackyUnitFrames()
	local tmp = newList()
	for frame in pairs(nonWackyFrames) do
		tmp[#tmp+1] = frame
	end
	tmp.n = 0
	return iter, tmp
end

function PitBull:IterateWackyUnitFrames()
	local tmp = newList()
	for frame in pairs(wackyFrames) do
		tmp[#tmp+1] = frame
	end
	tmp.n = 0
	return iter, tmp
end

function PitBull:OnProfileEnable()
	self.colorConstants = self.db.profile.settings.colors
	self:UpdateAllStatusBarTextures()
	self:CallMethodOnAllModules(true, "OnPitBullProfileEnable")
	
	self:UpdateAll()
	
--	if not WoW24 then
--		DogTag:SetColorConstantTable(self.colorConstants)
--	end
end

function PitBull:RegisterMetaLayout(data)
	if metaLayout then
		error("Cannot call `RegisterMetaLayout' more than once.", 2)
	end
	metaLayout = data
	if type(metaLayout.positions) ~= "table" then
		metaLayout.positions = {}
	end
	if type(metaLayout.extraFrames) ~= "table" then
		metaLayout.extraFrames = {}
	end
	if type(metaLayout.options) ~= "table" then
		metaLayout.options = {}
	end
	if type(metaLayout.options.name) ~= "table" then
		metaLayout.options.name = {}
	end
	if type(metaLayout.options.desc) ~= "table" then
		metaLayout.options.desc = {}
	end
	
	lazyLayout = lazyLayout + 1
	for unit, frame in self:IterateUnitFrames() do
		self:UpdateLayout(frame)
	end
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
end

function PitBull:UpdateLayoutSettings(group)
	UpdateLayoutSettings_todo[group] = true
	if type(options.args) ~= "table" or type(options.args[group].args.icons.args) ~= "table" then
		return
	end
	for k, v in pairs(metaLayout.options) do
		if type(k) == "string" and type(v) == "function" then
			local name = k
			local baseOptions = options.args[group].args
			local results
			local always = name == "always" or name == "alwaysText" or name == "alwaysIcon" or name == "alwaysBar" or name == "alwaysOther"
			if name and not always then
				local modname = frameToModule[name] and frameToModule[name].name
				local subgroup
				if modname then
					for l, u in pairs(baseOptions) do
						if u.args and u.args[modname] then
							subgroup = l
							break
						end
					end
					if not subgroup then
						subgroup = figureSubgroup(modname)
					end
				else
					subgroup = figureSubgroup(name)
				end
				baseOptions = baseOptions[subgroup].args
				if modname and baseOptions[modname] and baseOptions[modname].args then
					if baseOptions[name] and name ~= modname then
						baseOptions[name] = nil
					end
					baseOptions = baseOptions[modname].args
				elseif not baseOptions[name] then
					results = newList(v(group, k))
					if #results == 0 then
						results = del(results)
					elseif #results > 1 or results[1].type ~= "boolean" then
						local args = {}
						baseOptions[name] = {
							type = 'group',
							name = metaLayout.options.name[k] or name,
							desc = metaLayout.options.desc[k] or name,
							args = args,
							hidden = function()
								if not next(args) then
									return true
								end
								for unit, frame in self:IterateUnitFramesByGroup(group) do
									if frame[name] then
										return false
									end
								end
								return true
							end,
						}
						baseOptions = baseOptions[name].args
					end
				elseif baseOptions[name].args then
					baseOptions = baseOptions[name].args
				else
					name = nil
				end
			elseif always then
				local subgroup
				if name == "alwaysText" then
					subgroup = "texts"
				elseif name == "alwaysBar" then
					subgroup = "bars"
				elseif name == "alwaysIcon" then
					subgroup = "icons"
				elseif name == "alwaysOther" then
					subgroup = "other"
				end
				if subgroup then
					baseOptions = baseOptions[subgroup].args
				end
			end
			if name and not baseOptions[name .. 1] then
				if not results then
					results = newList(v(group, k))
				end
				if #results == 1 and baseOptions[name] then
					results = del(results)
				else
					for i, options in ipairs(results) do
						if #results == 1 then
							baseOptions[name] = options
							if not options.order then
								options.order = 200
							end
						else
							baseOptions[name .. i] = options
						end
						if not options.handler then
							options.handler = metaLayout
						end
						if not always then
							local function func()
								local good = false
								for unit, frame in self:IterateUnitFramesByGroup(group) do
									if frame[name] then
										good = true
										break
									end
								end
								return not good
							end
							if options.disabled then
								if type(options.disabled) == "function" then
									local options_disabled = options.disabled
									function options.disabled(...)
										if options_disabled(...) then
											return true
										end
										return func()
									end
								elseif type(options.disabled) == "string" then
									local options_disabled = options.disabled
									function options.disabled(...)
										local handler = options.handler
										if handler[options_disabled](handler, ...) then
											return true
										end
										return func()
									end
								end
							else
								options.disabled = func
							end
						end
					end
				end
			end
			if results then
				results = del(results)
			end
		end
	end
end


function PitBull:ChangeBorder(group, value)
	if self.db.profile.groups[group].border == value then
		return
	end

	self.db.profile.groups[group].border = value
	
	for unit, frame in self:IterateUnitFramesByGroup(group) do
		self:UpdateBackdropAndBorder(frame)
	end
end

function PitBull:ChangeHidden(group, value)
	if value == nil then
		value = not self.db.profile.groups[group].hidden
	elseif self.db.profile.groups[group].hidden == value then
		return
	end

	self.db.profile.groups[group].hidden = value
	
	local old_configMode = configMode
	self:ChangeConfigMode(nil, true)
	
	if value then
		if allFramesByGroup[group] then
			local destroyClusters = newList()
			local destroyFrames = newList()
			for frame in pairs(allFramesByGroup[group]) do
				local cluster = frame.cluster
				if cluster then
					destroyClusters[cluster] = true
				else
					destroyFrames[frame] = true
				end
			end
			for frame in pairs(destroyFrames) do
				self:DestroyUnitFrame(frame)
			end
			destroyFrames = del(destroyFrames)
			for cluster in pairs(destroyClusters) do
				self:DestroyUnitCluster(cluster)
			end
			destroyClusters = del(destroyClusters)
		end
		
		-- Hide the group and create a new toggle in disabledUnits
		options.args[group].hidden = true
		options.args.disabledUnits.args[group] = {
			type = 'execute',
			name = GroupToLocale[group],
			desc = L["Enable %s."]:format(GroupToLocale[group]),
			buttonText = L["Enable"],
			func = enableDisabledUnit,
			passValue = group,
		}
	else
		-- Show the group and remove the toggle from disabledUnits
		options.args[group].hidden = nil
		options.args.disabledUnits.args[group] = nil

		if ShouldShowUnit(group) then
			if group:find("^party") then
				if configMode == "party" or configMode == "raid" or NumPartyMembers > 0 then
					self:CreateUnitCluster(group)
				end
			elseif group:find("^raid") or group:find("^maintank") or group:find("^mainassist") then
				if configMode == "raid" or NumRaidMembers > 0 then
					self:CreateUnitCluster(group)
				end
			else
				self:CreateUnitFrame(group)
			end	
		end
	end
	
	self:ChangeConfigMode(old_configMode)
end

function PitBull:ChangeGroupFreeform(group, value)
	if self.db.profile.groups[group].freeform == value then
		return
	end

	self.db.profile.groups[group].freeform = value
	
	for cluster in pairs(clusters) do
		if cluster:gsub("[0-9]", ""):find("^" .. group) then
			self:ReorganizeCluster(cluster)
		end
	end
end

function PitBull:ChangeGroupDirection(group, value)
	if self.db.profile.groups[group].direction == value then
		return
	end

	self.db.profile.groups[group].direction = value
	
	for cluster in pairs(clusters) do
		if cluster:gsub("[0-9]", ""):find("^" .. group) then
			self:ReorganizeCluster(cluster)
		end
	end
end

function PitBull:ChangeGroupSpacing(group, value)
	if self.db.profile.groups[group].spacing == value then
		return
	end

	self.db.profile.groups[group].spacing = value
	
	for cluster in pairs(clusters) do
		if cluster:gsub("[0-9]", ""):find("^" .. group) then
			self:ReorganizeCluster(cluster)
		end
	end
end

function PitBull:ChangeGroupHSpacing(group, value)
	if self.db.profile.groups[group].hspacing == value then
		return
	end

	self.db.profile.groups[group].hspacing = value
	
	for cluster in pairs(clusters) do
		if cluster:gsub("[0-9]", ""):find("^" .. group) then
			self:ReorganizeCluster(cluster)
		end
	end
end

function PitBull:ChangeSquareLayout(group, value)
	if self.db.profile.groups[group].square == value then
		return
	end
	
	self.db.profile.groups[group].square = value
	
	for cluster in pairs(clusters) do
		if cluster:gsub("[0-9]", ""):find("^" .. group) then
			self:ReorganizeCluster(cluster)
		end
	end
end

function PitBull:ChangeHidePartyInRaid(value)
	if self.db.profile.groups.party.hidePartyInRaid == value then
		return
	end

	self.db.profile.groups.party.hidePartyInRaid = value
	
	local config = configMode
	self:ChangeConfigMode(nil, true)
	
	self:PARTY_MEMBERS_CHANGED()
	
	self:ChangeConfigMode(config)
end

function PitBull:ChangeShowPlayerInParty(value)
	if self.db.profile.groups.party.showPlayerInParty == value then
		return
	end
	
	self.db.profile.groups.party.showPlayerInParty = value
	
	for name, header in pairs(clusters) do
		local showPlayer = header:GetAttribute("showPlayer")
		local new_showPlayer
		if name:find("^party") and self.db.profile.groups.party.showPlayerInParty then
			new_showPlayer = true
		end
		if showPlayer ~= new_showPlayer then
			header:SetAttribute("showPlayer", new_showPlayer)
			
			for i = 1, 40 do
				local child = header:GetAttribute("child" .. i)
				if not child then
					break
				end
				self:UpdateFrame(child)
			end
		end
	end
end

function PitBull:ChangeShow5manAsParty(value)
	if self.db.profile.groups.raid.show5manAsParty == value then
		return
	end

	self.db.profile.groups.raid.show5manAsParty = value
	
	local config = configMode
	self:ChangeConfigMode(nil, true)
	
	self:PARTY_MEMBERS_CHANGED()

	self:ChangeConfigMode(config)
end

function PitBull:ChangeNameSort(group, value)
	if self.db.profile.groups[group].nameSort == value then
		return
	end

	self.db.profile.groups[group].nameSort = value
	
	for cluster, header in pairs(clusters) do
		local baseGroup
		if cluster:find("^raidMAINTANK") then
			baseGroup = "maintank"
		elseif cluster:find("^raidMAINASSIST") then
			baseGroup = "mainassist"
		elseif cluster:find("^raid") then
			baseGroup = "raid"
		elseif cluster:find("^party") then
			baseGroup = "party"
		end
		if baseGroup == group then
			self:DestroyUnitCluster(cluster)
			self:CreateUnitCluster(cluster)
		end
	end
end

function PitBull:ChangeRaidGroupStyle(value)
	if self.db.profile.groups.raid.groupStyle == value then
		return
	end
	
	local old_configMode = configMode
	self:ChangeConfigMode(nil, true)
	
	for cluster in pairs(clusters) do
		if cluster:find("^raid") then
			self:DestroyUnitCluster(cluster)
		end
	end
	
	self.db.profile.groups.raid.groupStyle = value
	PitBull:_ClearAndPopulateUnitFrames()
	
	for group, db in pairs(self.db.profile.groups) do
		if not db.hidden and (group:find("^raid") or group:find("^maintank") or group:find("^mainassist")) then
			self:CreateUnitCluster(group)
		end
	end
	
	self:ChangeConfigMode(old_configMode)
end

function PitBull:ChangeRaidGroupFilter(key, value)
	key = tonumber(key)
	if self.db.profile.groups.raid.groupFilter[key] == value then
		return
	end
	
	local old_configMode = configMode
	self:ChangeConfigMode(nil, true)

	for cluster in pairs(clusters) do
		if cluster:find("^raid") then
			self:DestroyUnitCluster(cluster)
		end
	end
	
	self.db.profile.groups.raid.groupFilter[key] = value
	PitBull:_ClearAndPopulateUnitFrames()
	
	for group, db in pairs(self.db.profile.groups) do
		if not db.hidden and (group:find("^raid") or group:find("^maintank") or group:find("^mainassist")) then
			self:CreateUnitCluster(group)
		end
	end
	
	self:ChangeConfigMode(old_configMode)
end

function PitBull:ChangeRaidClassFilter(key, value)
	if self.db.profile.groups.raid.classFilter[key] == value then
		return
	end
	
	local old_configMode = configMode
	self:ChangeConfigMode(nil, true)

	for cluster in pairs(clusters) do
		if cluster:find("^raid") then
			self:DestroyUnitCluster(cluster)
		end
	end
	
	self.db.profile.groups.raid.classFilter[key] = value
	PitBull:_ClearAndPopulateUnitFrames()
	
	for group, db in pairs(self.db.profile.groups) do
		if not db.hidden and (group:find("^raid") or group:find("^maintank") or group:find("^mainassist")) then
			self:CreateUnitCluster(group)
		end
	end
	
	self:ChangeConfigMode(old_configMode)
end

function PitBull:ChangeRaidShowInBattleground(key, value)
	value = not value
	if self.db.profile.groups.raid.hideInBG[key] == value then
		return
	end
	self.db.profile.groups.raid.hideInBG[key] = value
	
	if key == "wsg" then
		if GetRealZoneText() ~= BZ["Warsong Gulch"] then
			return
		end
	elseif key == "ab" then
		if GetRealZoneText() ~= BZ["Arathi Basin"] then
			return
		end
	elseif key == "av" then
		if GetRealZoneText() ~= BZ["Alterac Valley"] then
			return
		end
	else -- eots
		if GetRealZoneText() ~= BZ["Eye of the Storm"] then
			return
		end
	end
	
	local old_configMode = configMode
	self:ChangeConfigMode(nil, true)
	
	self:PARTY_MEMBERS_CHANGED()
	
	self:ChangeConfigMode(old_configMode)
end

local mySecureGroupHeader_Update
do
	-- relativePoint, xMultiplier, yMultiplier = getRelativePointAnchor( point )
	-- Given a point return the opposite point and which axes the point
	-- depends on.
	local function getRelativePointAnchor( point )
		point = point:upper();
		if (point == "TOP") then
			return "BOTTOM", 0, -1;
		elseif (point == "BOTTOM") then
			return "TOP", 0, 1;
		elseif (point == "LEFT") then
			return "RIGHT", 1, 0;
		elseif (point == "RIGHT") then
			return "LEFT", -1, 0;
		elseif (point == "TOPLEFT") then
			return "BOTTOMRIGHT", 1, -1;
		elseif (point == "TOPRIGHT") then
			return "BOTTOMLEFT", -1, -1;
		elseif (point == "BOTTOMLEFT") then
			return "TOPRIGHT", 1, 1;
		elseif (point == "BOTTOMRIGHT") then
			return "TOPLEFT", -1, 1;
		else
			return "CENTER", 0, 0;
		end
	end
	
	-- empties tbl and assigns the value true to each key passed as part of ...
	local function fillTable( tbl, ... )
		for key in pairs(tbl) do
			tbl[key] = nil;
		end
		for i = 1, select("#", ...), 1 do
			local key = select(i, ...);
			key = tonumber(key) or key;
			tbl[key] = true;
		end
	end

	-- same as fillTable() except that each key is also stored in 
	-- the array portion of the table in order
	local function doubleFillTable( tbl, ... )
		fillTable(tbl, ...);
		for i = 1, select("#", ...), 1 do
			tbl[i] = select(i, ...);
		end
	end

	--working tables
	local tokenTable = {};
	local sortingTable = {};
	local groupingTable = {};
	local tempTable = {};

	-- creates child frames and finished configuring them
	local function configureChildren(self)
		local point = self:GetAttribute("point") or "TOP"; --default anchor point of "TOP"
		local relativePoint, xOffsetMult, yOffsetMult = getRelativePointAnchor(point);
		local xMultiplier, yMultiplier =  math_abs(xOffsetMult), math_abs(yOffsetMult);
		local xOffset = self:GetAttribute("xOffset") or 0; --default of 0
		local yOffset = self:GetAttribute("yOffset") or 0; --default of 0
		local sortDir = self:GetAttribute("sortDir") or "ASC"; --sort ascending by default
		local columnSpacing = self:GetAttribute("columnSpacing") or 0;
		local startingIndex = self:GetAttribute("startingIndex") or 1;
	
		local unitCount = #sortingTable;
		local numDisplayed = unitCount - (startingIndex - 1);
		local unitsPerColumn = self:GetAttribute("unitsPerColumn");
		local numColumns;
		if ( unitsPerColumn and numDisplayed > unitsPerColumn ) then
			numColumns = math_min( math_ceil(numDisplayed / unitsPerColumn), (self:GetAttribute("maxColumns") or 1) );
		else
			unitsPerColumn = numDisplayed;
			numColumns = 1;
		end
		local loopStart = startingIndex;
		local loopFinish = math_min((startingIndex - 1) + unitsPerColumn * numColumns, unitCount)
		local step = 1;
	
		numDisplayed = loopFinish - (loopStart - 1);
	
		if ( sortDir == "DESC" ) then
			loopStart = unitCount - (startingIndex - 1);
			loopFinish = loopStart - (numDisplayed - 1);
			step = -1;
		end
	
		-- ensure there are enough buttons
		local needButtons = math_max(1, numDisplayed);
		if not ( self:GetAttribute("child"..needButtons) ) then
			local buttonTemplate = self:GetAttribute("template");
			local templateType = self:GetAttribute("templateType") or "Button";
			local name = self:GetName();
			if not ( name ) then
				self:Hide();
				return;
			end
			for i = 1, needButtons, 1 do
				if not ( self:GetAttribute("child"..i) ) then
					local newButton = CreateFrame(templateType, name.."UnitButton"..i, self, buttonTemplate);
					SetupUnitButtonConfiguration(self, newButton);
					self:SetAttribute("child"..i, newButton);
				end
			end
		end
	
		local columnAnchorPoint, columnRelPoint, colxMulti, colyMulti;
		if ( numColumns > 1 ) then
			columnAnchorPoint = self:GetAttribute("columnAnchorPoint");
			columnRelPoint, colxMulti, colyMulti = getRelativePointAnchor(columnAnchorPoint);
		end
	
		local buttonNum = 0;
		local columnNum = 1;
		local columnUnitCount = 0;
		local currentAnchor = self;
		for i = loopStart, loopFinish, step do
			buttonNum = buttonNum + 1;
			columnUnitCount = columnUnitCount + 1;
			if ( columnUnitCount > unitsPerColumn ) then
				columnUnitCount = 1;
				columnNum = columnNum + 1;
			end
		
			local unitButton = self:GetAttribute("child"..buttonNum);
			unitButton:Hide();
			unitButton:ClearAllPoints();
			if ( buttonNum == 1 ) then
				unitButton:SetPoint(point, currentAnchor, point, 0, 0);
				if ( columnAnchorPoint ) then
					unitButton:SetPoint(columnAnchorPoint, currentAnchor, columnAnchorPoint, 0, 0);
				end
		
			elseif ( columnUnitCount == 1 ) then
				local columnAnchor = self:GetAttribute("child"..(buttonNum - unitsPerColumn));
				unitButton:SetPoint(columnAnchorPoint, columnAnchor, columnRelPoint, colxMulti * columnSpacing, colyMulti * columnSpacing);
		
			else
				unitButton:SetPoint(point, currentAnchor, relativePoint, xMultiplier * xOffset, yMultiplier * yOffset);
			end
			unitButton:SetAttribute("unit", sortingTable[sortingTable[i]]);
			unitButton:Show();
		
			currentAnchor = unitButton;
		end
		repeat
			buttonNum = buttonNum + 1;
			local unitButton = self:GetAttribute("child"..buttonNum);
			if ( unitButton ) then
				unitButton:Hide();
				unitButton:SetAttribute("unit", nil);
			end
		until not ( unitButton )
	
		local unitButton = self:GetAttribute("child1");
		local unitButtonWidth = unitButton:GetWidth();
		local unitButtonHeight = unitButton:GetHeight();
		if ( numDisplayed > 0 ) then
			local width = xMultiplier * (unitsPerColumn - 1) * unitButtonWidth + ( (unitsPerColumn - 1) * (xOffset * xOffsetMult) ) + unitButtonWidth;
			local height = yMultiplier * (unitsPerColumn - 1) * unitButtonHeight + ( (unitsPerColumn - 1) * (yOffset * yOffsetMult) ) + unitButtonHeight;
		
			if ( numColumns > 1 ) then
				width = width + ( (numColumns -1) * math_abs(colxMulti) * (width + columnSpacing) );
				height = height + ( (numColumns -1) * math_abs(colyMulti) * (height + columnSpacing) );
			end
		
			self:SetWidth(width);
			self:SetHeight(height);
		else
			local minWidth = self:GetAttribute("minWidth") or (yMultiplier * unitButtonWidth);
			local minHeight = self:GetAttribute("minHeight") or (xMultiplier * unitButtonHeight);
			self:SetWidth( math_max(minWidth, 0.1) );
			self:SetHeight( math_max(minHeight, 0.1) );
		end
	end

	local function GetGroupHeaderType(self)
		local type, start, stop;

		local nRaid = NumRaidMembers;
		local nParty = NumPartyMembers;
		-- my addition
		if configMode == "raid" then
			nRaid = 40
			nParty = 4
		elseif configMode == "party" then
			nParty = 4
		end
		-- end my addition
		if ( nRaid > 0 and self:GetAttribute("showRaid") ) then
			type = "RAID";
		elseif ( (nRaid > 0 or nParty > 0) and self:GetAttribute("showParty") ) then
			type = "PARTY";
		elseif ( self:GetAttribute("showSolo") ) then
			type = "SOLO";
		end
		if ( type ) then
			if ( type == "RAID" ) then
				start = 1;
				stop = nRaid;
			else
				if ( type == "SOLO" or self:GetAttribute("showPlayer") ) then
					start = 0;
				else
					start = 1;
				end
				stop = nParty;
			end
		end
		return type, start, stop;
	end
	
	local englishClasses = { "WARRIOR", "HUNTER", "ROGUE", "PALADIN", "SHAMAN", "PRIEST", "MAGE", "WARLOCK", "DRUID" }
	local englishRoles = { "MAINTANK", "MAINASSIST" }
	local function GetGroupRosterInfo(type, index)
		local _, unit, name, subgroup, className, role;
		if ( type == "RAID" ) then
			unit = "raid"..index;
			if UnitExists(unit) then
				name, _, subgroup, _, _, className, _, _, _, role = GetRaidRosterInfo(index);
			else
				name = ("raid%02d"):format(index)
				-- my addition
				local groupNums = newList()
				for i = 1, 8 do
					groupNums[i] = 0
				end
				local classNums = newList()
				for _,v in ipairs(englishClasses) do
					classNums[v] = 0
				end
				local roleNums = newList()
				for _,v in ipairs(englishRoles) do
					roleNums[v] = 0
				end
				for i = 1, NumRaidMembers do
					local _, _, sg, _, _, cn, _, _, _, r = GetRaidRosterInfo(i)
					groupNums[sg] = groupNums[sg] + 1
					classNums[cn] = classNums[cn] + 1
					if r then
						roleNums[r] = roleNums[r] + 1
					end
				end
				local index2 = index - NumRaidMembers
				local num = 0
				for i = 1, 8 do
					num = num + (5 - groupNums[i])
					if index2 <= num then
						subgroup = i
						break
					end
				end
				num = 0
				for j = 1, 5 do
					for _,v in ipairs(englishClasses) do
						if j > classNums[v] then
							num = num + 1
							if index2 <= num then
								className = v
								break
							end
						end
					end
					if className then
						break
					end
				end
				num = 0
				for j = 1, 5 do
					for _,v in ipairs(englishRoles) do
						if j > roleNums[v] then
							num = num + 1
							if index2 <= num then
								role = v
								break
							end
						end
					end
					if role then
						break
					end
				end
				groupNums = del(groupNums)
				classNums = del(classNums)
				roleNums = del(roleNums)
				-- end my addition
			end
		else
			if ( index > 0 ) then
				unit = "party"..index;
			else
				unit = "player";
			end
			if ( UnitExists(unit) ) then
				name = UnitName(unit);
				_, className = UnitClass(unit);
				if ( GetPartyAssignment("MAINTANK", unit) ) then
					role = "MAINTANK";
				elseif ( GetPartyAssignment("MAINASSIST", unit) ) then
					role = "MAINASSIST";
				end
			else
				-- my addition
				name = unit
				className = englishClasses[index]
				-- end my addition
			end
			subgroup = 1;
		end
		return unit, name, subgroup, className, role;
	end
	
	function mySecureGroupHeader_Update(self)
		if not configMode then
			return
		end
		local nameList = self:GetAttribute("nameList");
		local groupFilter = self:GetAttribute("groupFilter");
		local sortMethod = self:GetAttribute("sortMethod");
		local groupBy = self:GetAttribute("groupBy");

		for key in pairs(sortingTable) do
			sortingTable[key] = nil;
		end

		-- See if this header should be shown
		local type, start, stop = GetGroupHeaderType(self);
		if ( not type ) then
			configureChildren(self);
			return;
		end

		if ( not groupFilter and not nameList ) then
			groupFilter = "1,2,3,4,5,6,7,8";
		end

		if ( groupFilter ) then
			-- filtering by a list of group numbers and/or classes
			fillTable(tokenTable, strsplit(",", groupFilter));
			local strictFiltering = self:GetAttribute("strictFiltering"); -- non-strict by default
			for i = start, stop, 1 do
				local unit, name, subgroup, className, role = GetGroupRosterInfo(type, i);
				if ( name and
				     ((not strictFiltering) and 
				      (tokenTable[subgroup] or tokenTable[className] or (role and tokenTable[role])) -- non-strict filtering
				     ) or 
				      (tokenTable[subgroup] and tokenTable[className]) -- strict filtering
				) then
					table_insert(sortingTable, name);
					sortingTable[name] = unit;
					if ( groupBy == "GROUP" ) then
						groupingTable[name] = subgroup;

					elseif ( groupBy == "CLASS" ) then
						groupingTable[name] = className;

					elseif ( groupBy == "ROLE" ) then
						groupingTable[name] = role;

					end
				end
			end

			if ( groupBy ) then
				local groupingOrder = self:GetAttribute("groupingOrder");
				doubleFillTable(tokenTable, strsplit(",", groupingOrder));
				for k in pairs(tempTable) do
					tempTable[k] = nil;
				end
				for _, grouping in ipairs(tokenTable) do
					grouping = tonumber(grouping) or grouping;
					for k in ipairs(groupingTable) do
						groupingTable[k] = nil;
					end
					for index, name in ipairs(sortingTable) do
						if ( groupingTable[name] == grouping ) then
							table_insert(groupingTable, name);
							tempTable[name] = true;
						end
					end
					if ( sortMethod == "NAME" ) then -- sort by ID by default
						table_sort(groupingTable);
					end
					for _, name in ipairs(groupingTable) do
						table_insert(tempTable, name);
					end
				end
				-- handle units whose group didn't appear in groupingOrder
				for k in ipairs(groupingTable) do
					groupingTable[k] = nil;
				end
				for index, name in ipairs(sortingTable) do
					if not ( tempTable[name] ) then
						table_insert(groupingTable, name);
					end
				end
				if ( sortMethod == "NAME" ) then -- sort by ID by default
					table_sort(groupingTable);
				end
				for _, name in ipairs(groupingTable) do
					table_insert(tempTable, name);
				end

				--copy the names back to sortingTable
				for index, name in ipairs(tempTable) do
					sortingTable[index] = name;
				end

			elseif ( sortMethod == "NAME" ) then -- sort by ID by default
				table_sort(sortingTable);

			end

		else
			-- filtering via a list of names
			doubleFillTable(sortingTable, strsplit(",", nameList));
			local numUnknown = GetNumRaidMembers()
			for i = start, stop, 1 do
				local unit, name = GetGroupRosterInfo(type, i);
				if ( sortingTable[name] ) then
					sortingTable[name] = unit;
				else -- my addition
					numUnknown = numUnknown + 1
					sortingTable[name] = "raid" .. numUnknown
				end
			end
			for i = #sortingTable, 1, -1 do
				local name = sortingTable[i];
				if ( sortingTable[name] == true ) then
					table_remove(sortingTable, i);
				end
			end
			if ( sortMethod == "NAME" ) then
				table_sort(sortingTable);
			end

		end

		configureChildren(self);
	end
end

function PitBull:ChangeConfigMode(value, resettingLater)
	if InCombatLockdown() then
		value = nil
	end
	if value == "disabled" or not value then
		value = nil
	else
		if NumRaidMembers > 0 then
			if NumRaidMembers == NumPartyMembers+1 and self.db.profile.groups.raid.show5manAsParty then
				value = "party"
			else
				value = "raid"
			end
		elseif NumPartyMembers > 0 then
			value = "party"
		end
	end
	if configMode == value then
		return
	end
	
	if currentMovingFrame then
		currentMovingFrame:StopMovingOrSizing()
		currentMovingFrame = nil
	end
	
	self.configMode = value
	configMode = value
	
	lazyLayout = lazyLayout + 1
	if configMode == "raid" then
		if mySecureGroupHeader_Update then
			hooksecurefunc("SecureGroupHeader_Update", mySecureGroupHeader_Update)
			mySecureGroupHeader_Update = nil
			SecureGroupHeader_Update = _G.SecureGroupHeader_Update
		end
		for group, db in pairs(self.db.profile.groups) do
			if group:find("^party") or group:find("^raid") or group:find("^maintank") or group:find("^mainassist") then
				if db.hidden or not ShouldShowUnit(group) then
					self:DestroyUnitCluster(group)
				end
			end
		end
		for group, db in pairs(self.db.profile.groups) do
			if group:find("^party") or group:find("^raid") or group:find("^maintank") or group:find("^mainassist") then
				if not db.hidden and ShouldShowUnit(group) then
					self:CreateUnitCluster(group)
				end
			end
		end
		for cluster, header in pairs(clusters) do
			SecureGroupHeader_Update(header)
		end
	elseif configMode == "party" then
		if mySecureGroupHeader_Update then
			hooksecurefunc("SecureGroupHeader_Update", mySecureGroupHeader_Update)
			mySecureGroupHeader_Update = nil
			SecureGroupHeader_Update = _G.SecureGroupHeader_Update
		end
		for group, db in pairs(self.db.profile.groups) do
			if group:find("^party") or group:find("^raid") or group:find("^maintank") or group:find("^mainassist") then
				if db.hidden or not group:find("^party") then
					self:DestroyUnitCluster(group)
				end
			end
		end
		for cluster, header in pairs(clusters) do
			if cluster:find("^raid") then
				self:DestroyUnitCluster(cluster)
			end
		end
		for group, db in pairs(self.db.profile.groups) do
			if not db.hidden and group:find("^party") then
				self:CreateUnitCluster(group)
			end
		end
		for cluster, header in pairs(clusters) do
			if cluster:find("^party") then
				SecureGroupHeader_Update(header)
			end
		end
	end
	
	for frame in pairs(allFrames) do
		local unit = frame:GetUnit()
		if unit then
			if configMode and ShouldShowUnit(unit)then
				UnregisterUnitWatch(frame)
				if not frame.cluster then
					frame:Show()
				end
				frame:SetScript("OnMouseDown", configFrame_OnMouseDown)
			else
				RegisterUnitWatch(frame)
				frame:SetScript("OnMouseDown", nil)
			end
		end
	end
	
	self:CallMethodOnAllModules(true, "OnChangeConfigMode", value)
	
	for cluster, header in pairs(clusters) do
		if configMode then
			local child1 = header:GetAttribute("child1")
			if child1 and child1:IsShown() then
				header.label:Show()
			else
				header.label:Hide()
			end
		else
			header.label:Hide()
		end
	end
	
	for frame in pairs(frames) do
		self:UpdateLayout(frame)
	end
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
	
	if not configMode and not resettingLater then
		self:PARTY_MEMBERS_CHANGED()
	end
end

function PitBull.modulePrototype:RegisterPitBullModuleDependencies(...)
	if moduleDependencies[self] then
		error("Cannot call `RegisterPitBullModuleDependencies' more than once.", 2)
	end
	for i = 1, select('#', ...) do
		local v = select(i, ...)
		if type(v) ~= "string" then
			error(("Bad argument #%d to `RegisterPitBullModuleDependencies'. Expected \"string\", got %q"):format(i, type(v)), 2)
		end
		
		if not moduleDependencies[self] then
			moduleDependencies[self] = newList()
		end
		moduleDependencies[self][v] = true
	end
end

function PitBull.modulePrototype:RegisterPitBullChildFrames(...)
	for i = 1, select('#', ...) do
		local v = select(i, ...)
		if type(v) ~= "string" then
			error(("Bad argument #%d to `RegisterPitBullChildFrames'. Expected \"string\", got %q"):format(i, type(v)), 2)
		end
		if frameToModule[v] and frameToModule[v] ~= self then
			error(("Frame %q provided twice to `RegisterPitBullChildFrames'. Previously by %q and now by %q"):format(v, tostring(frameToModule[v]), tostring(self)), 2)
		end
		frameToModule[v] = self
	end
end

function PitBull.modulePrototype:RegisterPitBullOptionsMethod(method)
	local kind = type(method)
	if kind ~= "string" and kind ~= "function" then
		error(("Bad argument #2 to `RegisterPitBullOptionsMethod'. %s expected, got %s."):format("string or function", kind), 2)
	end
	if kind == "string" then
		if type(self[method]) ~= "function" then
			error(("Cannot find handler %q for `RegisterPitBullOptionsMethod'"):format(method), 2)
		end
	end

	if moduleOptionsMethods[self] then
		error("Cannot call `RegisterPitBullOptionsMethod' more than once from the same module.", 2)
	end
	
	local name = self.name
	
	for _, group in ipairs(orderedGroupMenus) do
		addModuleOptionsMethod(group, self, method)
	end
	
	moduleOptionsMethods[self] = method
end

function PitBull.modulePrototype:RegisterPitBullIconLayoutHandler(key, priority)
	if type(key) ~= "string" then
		error(("Bad argument #2 to `RegisterPitBullIconLayoutHandler'. Expected %q, got %q."):format("string", type(key)), 2)
	elseif type(priority) ~= "number" then
		error(("Bad argument #3 to `RegisterPitBullIconLayoutHandler'. Expected %q, got %q."):format("number", type(priority)), 2)
	end
	
	return metaLayout:CreateIconHandler(key, priority)
end

function PitBull.modulePrototype:RegisterPitBullBarLayoutHandler(key, name, smallName, squareOnSide)
	if type(key) ~= "string" then
		error(("Bad argument #2 to `RegisterPitBullBarLayoutHandler'. Expected %q, got %q."):format("string", type(key)), 2)
	elseif type(name) ~= "string" then
		error(("Bad argument #3 to `RegisterPitBullBarLayoutHandler'. Expected %q, got %q."):format("string", type(name)), 2)
	elseif type(smallName) ~= "string" then
		error(("Bad argument #4 to `RegisterPitBullBarLayoutHandler'. Expected %q, got %q."):format("string", type(smallName)), 2)
	end
	
	return metaLayout:CreateBarHandler(key, name, smallName, squareOnSide)
end

function PitBull:OnModuleEnable(module, first)
	if type(module.OnPopulateUnitFrame) == "function" then
		for frame in pairs(frames) do
			local success, ret = pcall(module.OnPopulateUnitFrame, module, frame:GetUnit(), frame)
			if not success then
				geterrorhandler()(ret)
			end
			PitBull:UpdateLayout(frame)
		end
	end
	if type(module.OnUpdateFrame) == "function" then
		for frame in pairs(frames) do
			local success, ret = pcall(module.OnUpdateFrame, module, frame:GetUnit(), frame)
			if not success then
				geterrorhandler()(ret)
			end
			PitBull:UpdateLayout(frame)
		end
	end
end

function PitBull:OnModuleDisable(module)
	for mod, data in pairs(moduleDependencies) do
		if data[module.name] then
			self:ToggleModuleActive(mod, false)
		end
	end
	if type(module.OnFrameOnLeave) == "function" then
		local frame = GetMouseFocus()
		if frames[frame] then
			local success, ret = pcall(module.OnFrameOnLeave, module, frame:GetUnit(), frame)
			if not success then
				geterrorhandler()(ret)
			end
			PitBull:UpdateLayout(frame)
		end
	end
	if type(module.OnClearUnitFrame) == "function" then
		for frame in pairs(frames) do
			local success, ret = pcall(module.OnClearUnitFrame, module, frame:GetUnit(), frame)
			if not success then
				geterrorhandler()(ret)
			end
			PitBull:UpdateLayout(frame)
		end
	end
end

local layouts = {}
layoutNames = { Custom = L["Custom"]}
local registeredLayouts = {}

function initCustomLayouts()
	for name, data in pairs(self.db.account.customLayouts) do
		if not registeredLayouts[name] then
			layouts[name] = data
			layoutNames[name] = name
			removableLayoutNames[name] = name
		else
			self.db.account.customLayouts[name] = nil
		end
	end
	initCustomLayouts = nil
end
function PitBull:GetCurrentLayout(group)
	for k, v in pairs(layouts) do
		if metaLayout:IsCurrentLayout(group, v) then
			return k
		end
	end
	return "Custom"
end

function PitBull:IsCurrentLayoutNotCustom(group)
	return self:GetCurrentLayout(group) ~= "Custom"
end

function validateLayoutName(value)
	if value == "Custom" then
		return false
	end
	if value == "" then
		return false
	end
	
	if registeredLayouts[value] then
		return false
	end
	
	return true
end

function PitBull:SaveLayout(group, value)
	local data = metaLayout:ExportLayout(group)
	data.name = value
	
	if registeredLayouts[value] then
		return
	end
	
	layouts[value] = data
	layoutNames[value] = value
	removableLayoutNames[value] = value
	
	self.db.account.customLayouts[value] = data
	
	assert(metaLayout:IsCurrentLayout(group, data))
end

function PitBull:ChangeLayout(group, value)
	if value == "Custom" then
		return
	end
	
	if value == self:GetCurrentLayout(group) then
		return
	end
	
	local data = layouts[value]
	
	local success, ret = metaLayout:ImportLayout(group, data)
	if not success then
		self:Print(ret)
	end
	
	lazyLayout = lazyLayout + 1
	for unit, frame in self:IterateUnitFramesByGroup(group) do
		self:UpdateLayout(frame)
	end
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
end

function PitBull:RegisterLayout(data)
	if type(data) ~= "table" then
		error(("Bad argument #2 to `RegisterLayout'. Expected %q, got %q."):format("table", type(data)), 2)
	end
	local name = data.name
	if type(name) ~= "string" then
		error(("Bad argument #2 to `RegisterLayout'. .name expected to be %q, got %q."):format("string", type(name)), 2)
	end
	if name == "Custom" then
		error(("Bad argument #2 to `RegisterLayout'. .name cannot be %q."):format("Custom"), 2)
	end
	
	layouts[name] = data
	layoutNames[name] = name
	registeredLayouts[name] = true
end

function PitBull:RemoveLayout(name)
	if registeredLayouts[name] then
		return
	end
	
	layouts[name] = nil
	layoutNames[name] = nil
	removableLayoutNames[name] = nil
	self.db.account.customLayouts[name] = nil
end

local function escapeChar(c)
    return ("\\%03d"):format(c:byte())
end

local function specialSort(alpha, bravo)
	if alpha == nil or bravo == nil then
		return false
	end
	local type_alpha, type_bravo = type(alpha), type(bravo)
	if type_alpha ~= type_bravo then
		return type_alpha < type_bravo
	end
	if type_alpha == "string" then
		return alpha:lower() < bravo:lower()
	elseif type_alpha == "number" then
		return alpha < bravo
	elseif type_alpha == "table" then
		return #alpha < #bravo
	elseif type_alpha == "boolean" then
		return not alpha
	else
		return false
	end
end

local tab = "    "

local getkeystring
local function toLiteralString(value, depth, t)
	if type(value) == "string" then
		local s = ("%q"):format((value:gsub("|", "||"))):gsub("[\001-\012\014-\031\128-\255]", escapeChar)
		if t then
			t[#t+1] = s
			return
		else
			return s
		end
	elseif type(value) ~= "table" then
		local s = tostring(value)
		if t then
			t[#t+1] = s
			return
		else
			return s
		end
	end
	if next(value) == nil then
		local s = "{}"
		if t then
			t[#t+1] = s
			return
		else
			return s
		end
	end
	if not depth then
		depth = 0
	end
	
	local madeT = not t
	if madeT then
		t = newList()
	end
	t[#t+1] = "{\n"
	
	local tmp = newList()
	for k in pairs(value) do
		if depth > 0 or (k ~= "name" and k ~= "pbRevision") then
			tmp[#tmp+1] = k
		end
	end
	table_sort(tmp, specialSort)
	if depth == 0 then
		table_insert(tmp, 1, "name")
		table_insert(tmp, 2, "pbRevision")
	end
	for i,k in ipairs(tmp) do
		tmp[i] = nil
		local v = value[k]
		for i = 1, depth+1 do
			t[#t+1] = tab
		end
		getkeystring(k, depth+1, t)
		t[#t+1] = " = "
		toLiteralString(v, depth+1, t)
		if tmp[i+1] == nil then
			t[#t+1] = "\n"
		else
			t[#t+1] = ",\n"
		end
	end
	tmp = del(tmp)
	
	for i = 1, depth do
		t[#t+1] = tab
	end
	t[#t+1] = "}"
	if madeT then
		local s = table_concat(t)
		t = del(t)
		return s
	end
	return
end

function getkeystring(value, depth, t)
	if type(value) == "string" then
		if value:find("^[%a_][%a%d_]*$") then
			t[#t+1] = value
			return
		end
	end
	t[#t+1] = "["
	toLiteralString(value, depth, t)
	t[#t+1] = "]"
end

local exportFrame
local function createExportFrame()
	exportFrame = CreateFrame("Frame", "PitBullLayoutExportFrame", UIParent, "DialogBoxFrame")

	exportFrame:SetWidth(500)
	exportFrame:SetHeight(400)
	exportFrame:SetPoint("CENTER")
	exportFrame:SetBackdrop({
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]], 
	    edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], 
	    tile = true, tileSize = 16, edgeSize = 16, 
	    insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	exportFrame:SetBackdropColor(0,0,0,1)

	local text = exportFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	exportFrame.text = text
	text:SetPoint("TOP", 0, -5)
	text:SetPoint("LEFT")
	
	local closeButton = CreateFrame("Button", "PitBullLayoutExportFrameCloseButton", exportFrame, "UIPanelCloseButton")
	closeButton:SetPoint("TOPRIGHT", 5, 5)
	closeButton:SetScript("OnClick", function()
		exportFrame:Hide()
	end)
	text:SetPoint("RIGHT", closeButton)
	
	local scrollFrame = CreateFrame("ScrollFrame", "PitBullLayoutExportFrameScrollFrame", exportFrame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetToplevel(true)
	scrollFrame:SetPoint("TOP", -10, -16)
	scrollFrame:SetWidth(455)
	scrollFrame:SetHeight(330)

	local editBox = CreateFrame("EditBox", nil, scrollFrame)
	exportFrame.editBox = editBox
	scrollFrame:SetScrollChild(editBox)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:SetWidth(450)
	editBox:SetHeight(314)
	editBox:SetPoint("BOTTOM", 5, 0)
	editBox:SetJustifyH("LEFT")
	editBox:SetJustifyV("TOP")
	editBox:SetAutoFocus(false)
	editBox:SetScript("OnTextChanged", function(this)
		if exportFrame.style == "import" then
			return
		end
		
		if this:GetText() ~= this.text then
			this:SetText(this.text)
		end
	
		local s = _G.PitBullLayoutExportFrameScrollFrameScrollBar
		_G.PitBullLayoutExportFrameScrollFrame:UpdateScrollChildRect()
		local _, m = s:GetMinMaxValues()
		if m > 0 and this.max ~= m then
			this.max = m
			s:SetValue(m)
		end
	end)
	editBox:SetScript("OnEscapePressed", function(this)
		this:ClearFocus()
	end)
	_G.PitBullLayoutExportFrameButton:SetScript("OnClick", function(this)
		if exportFrame.style == "export" then
			exportFrame:Hide()
			return
		end
		local code = editBox:GetText()
		local func, ret = loadstring("return " .. code)
		if not func then
			PitBull:Print("Error importing layout:", ret)
			return
		end
		local new_G = newList()
		setfenv(func, new_G)
		local success, ret = pcall(func)
		new_G = del(new_G)
		if not success then
			PitBull:Print("Error importing layout:", ret)
			return
		end
		local layout = ret
		
		local success, ret = metaLayout:IsValidLayout(layout)
		if not success then
			PitBull:Print("Error importing layout:", ret)
			return
		end
		
		local name = layout.name
		if type(name) ~= "string" then
			PitBull:Print("Error importing layout:", "name not specified properly.")
			return
		end
		
		if registeredLayouts[name] then
			PitBull:Print(("Error importing layout %q:"):format(name), "Cannot import a pre-registered layout.")
			return
		end
		
		layouts[name] = layout
		layoutNames[name] = name
		removableLayoutNames[name] = name

		self.db.account.customLayouts[name] = data
		
		PitBull:Print("Successfully imported layout %q", name)
		
		exportFrame:Hide()
		return
	end)
	createExportFrame = nil
end
function PitBull:ExportLayout(name)
	if createExportFrame then
		createExportFrame()
	end
	exportFrame.style = "export"
	if not IsMacClient() then
		-- Windows or Linux
		exportFrame.text:SetText(L["Export: Press Ctrl-A to select the text, then Ctrl-C to copy."])
	else
		exportFrame.text:SetText(L["Export: Press Cmd-A to select the text, then Cmd-C to copy."])
	end
	
--	Dewdrop:Close()
	
	local editBox = exportFrame.editBox
	editBox.text = toLiteralString(layouts[name])
	editBox:SetText(editBox.text)
	
	exportFrame:Show()
	editBox:SetFocus()
end

function PitBull:OpenImportLayoutFrame()
	if createExportFrame then
		createExportFrame()
	end
	exportFrame.style = "import"
	if not IsMacClient() then
		-- Windows or Linux
		exportFrame.text:SetText(L["Import: Copy text from an external source and press Ctrl-V to paste."])
	else
		exportFrame.text:SetText(L["Import: Copy text from an external source and press Cmd-V to paste."])
	end
--	Dewdrop:Close()
	
	local editBox = exportFrame.editBox
	editBox.text = nil
	editBox:SetText("")
	
	exportFrame:Show()
	editBox:SetFocus()
end

local function deepEqual(alpha, bravo)
	local type_alpha = type(alpha)
	if type_alpha ~= type(bravo) then
		return false
	end
	if type_alpha == "table" then
		local num = 0
		for k,v in pairs(alpha) do
			if not deepEqual(v, bravo[k]) then
				return false
			end
			num = num + 1
		end
		for _ in pairs(bravo) do
			num = num - 1
		end
		if num ~= 0 then
			return false
		end
		return true
	end
	return alpha == bravo
end

function PitBull.OnCommReceive:LAYOUT(prefix, distribution, sender, layout)
	local success, ret = metaLayout:IsValidLayout(layout)
	if not success then
		self:Print("Error importing layout from %s: %s", sender, ret)
		return
	end
	
	local name = layout.name
	if type(name) ~= "string" then
		self:Print("Error importing layout from %s: %s", sender, "name not specified properly.")
		return
	end
	
	if registeredLayouts[name] then
		self:Print("Error importing layout %q from %s: %s", name, sender, "Cannot import a pre-registered layout.")
		return
	end
	
	if layouts[name] then
		if deepEqual(layout, layouts[name]) then
			if distribution == "WHISPER" then
				self:Print("Successfully received layout %q from %s.", name, sender)
			end
			return
		end
		self:Print("Error importing layout %q from %s: %s", name, sender, ("Layout already imported. You can remove it and ask %s to resend."):format(sender))
		return
	end
	
	layouts[name] = deepCopy(layout)
	layoutNames[name] = name
	removableLayoutNames[name] = name
	
	self.db.account.customLayouts[name] = data
	
	self:Print("Successfully received layout %q from %s.", name, sender)
end

function PitBull:SendLayoutToGuild(layoutName)
	if not IsInGuild() then
		return
	end
	local layout = layouts[layoutName]
	if not layout then
		return
	end
	
	self:SendCommMessage("GUILD", "LAYOUT", layout)
	
	self:Print("Sent layout %q to guild", layoutName)
end

function PitBull:SendLayoutToGroup(layoutName)
	if NumPartyMembers == 0 and NumRaidMembers == 0 then
		return
	end
	local layout = layouts[layoutName]
	if not layout then
		return
	end
	
	self:SendCommMessage("GROUP", "LAYOUT", layout)
	
	self:Print("Sent layout %q to group", layoutName)
end

function PitBull:SendLayoutToPlayer(player, layoutName)
	local layout = layouts[layoutName]
	if not layout then
		return
	end
	
	self:SendCommMessage("WHISPER", player, "LAYOUT", layout)
	
	self:Print("Sent layout %q to %q", layoutName, player)
end

function PitBull:CopyLayout(toGroup, fromGroup)
	if toGroup == fromGroup then
		return
	end
	local layout = metaLayout:ExportLayout(fromGroup)
	metaLayout:ImportLayout(toGroup, layout)
	deepDel(layout)
	
	lazyLayout = lazyLayout + 1
	for unit, frame in self:IterateUnitFramesByGroup(toGroup) do
		self:UpdateLayout(frame)
	end
	lazyLayout = lazyLayout - 1
	self:_UpdateLayouts()
end
