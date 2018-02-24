if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 69383 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:NewModule("Aura", "LibRockTimer-1.0", "LibRockEvent-1.0")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 69383 $", "$Date: 2008-04-12 19:12:05 -0400 (Sat, 12 Apr 2008) $")

PitBull_Aura:RegisterPitBullChildFrames("auraContainer", "auraContainer2", "debuffHighlight")

local newList, newSet, del = Rock:GetRecyclingFunctions("PitBull", "newList", "newSet", "del")
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local localization = (GetLocale() == "koKR") and {
	["Show buffs and debuffs for PitBull frames as well as highlight frames that need cleansing."] = "해제할 필요가 있는 강조 프레임과 마찬가지로 PitBull 프레임에 대해 버프/디버프를 보여줍니다.",
	["Up"] = "위로",
	["Down"] = "아래로",
	["Left"] = "좌측",
	["Top-left"] = "상단-좌측",
	["Bottom-left"] = "하단-좌측",
	["Right"] = "우측",
	["Top-right"] = "상단-우측",
	["Bottom-right"] = "하단-우측",
	["Top"] = "상단",
	["Bottom"] = "하단",
	["Up then Left"] = "위로 다음에 좌측으로",
	["Up then Right"] = "위로 다음에 우측으로",
	["Down then Left"] = "아래로 다음에 좌측으로",
	["Down then Right"] = "아래로 다음에 우측으로",
	["Left then Up"] = "좌측으로 다음에 위로",
	["Left then Down"] = "좌측으로 다음에 아래로",
	["Right then Up"] = "우측으로 다음에 위로",
	["Right then Down"] = "우측으로 다음에 아래로",
	["Never"] = "안함",
	["All Debuffs"] = "모든 디버프",
	["Cureable"] = "치유 가능한",
	["Cureable by me"] = "자신이 치유 가능한",
	["Border"] = "테두리",
	["Thin Border"] = "얇은 테두리",
	["Normal"] = "보통",
	["Auras"] = "오오라",
	["Options for buff and debuff display for this unit type."] = "이 유닛 유형에 대해 버프 및 디버프 표시를 위한 옵션입니다.",
	["Snap"] = "맞춤",
	["Resize auras to fill the available row space."] = "가능한 열 공간을 채우기 위해 오오라의 크기를 조절합니다.",
	["Sort"] = "정돈",
	["Sort this unit's debuffs by type then alphabetically."] = "유형에 따라 이 유닛의 디버프를 알파벳 순으로 정돈합니다.",
	["Enable"] = "활성화",
	["Enable buffs or debuffs."] = "버프 혹은 디버프를 활성화합니다.",
	["Buffs"] = "버프",
	["Enable buffs."] = "버프를 활성화합니다.",
	["Debuffs"] = "디버프",
	["Enable debuffs."] = "디버프를 활성화합니다.",
	["Weapon Buffs"] = "무기 버프",
	["Enable weapon buffs."] = "무기 버프를 활성화합니다.",
	["Borders"] = "테두리",
	["Options for aura icon borders."] = "오오라 아이콘의 테두리를 위한 설정입니다.",
	["Enable colored buff borders"] = "버프 테두리의 색상을 활성화합니다.",
	["Buff types"] = "버프 유형",
	["Color buff borders by buff type."] = "버프 유형에 의해 버프 테두리 색상을 가집니다.",
	["Enable colored debuff borders"] = "디버프 테두리의 색상을 활성화합니다.",
	["Debuff types"] = "디버프 유형",
	["Color debuff borders by debuff type."] = "디버프 유형에 의해 버프 테두리 색상을 가집니다.",
	["Frame debuff highlight"] = "디버프 프레임 강조",
	["Highlighting the unit frame itself when the unit is debuffed."] = "유닛이 디버프에 걸린 경우에 유닛 프레임 자체를 강조합니다.",
	["Frame debuff highlight style"] = "디버프 프레임 강조 양식",
	["Set how the frame debuff highlight looks."] = "디버프 프레임 강조 외형 방식을 설정합니다.",
	["Enable buff filtering"] = "버프 선별 활성화",
	["Filter certain buffs based on your class."] = "자신의 직업에 기반해 특정 버프를 선별합니다.",
	["Enable debuff filtering"] = "디버프 선별 활성화",
	["Filter certain debuffs based on your class."] = "자신의 직업에 기반해 특정 디버프를 선별합니다.",
	["Debuff size"] = "디버프 크기",
	["Set size of debuff icons."] = "디버프 아이콘의 크기를 설정합니다.",
	["Buff size"] = "버프 크기",
	["Set size of buff icons."] = "버프 아이콘의 크기를 설정합니다.",
	["Buff spacing"] = "버프 간격 조절",
	["Set horizontal spacing between each buff."] = "각 버프간에 가로 간격을 설정합니다.",
	["Max buffs"] = "최대 버프",
	["Set the maximum number of buffs to display."] = "표시할 버프의 최대 갯수를 설정합니다.",
	["Max debuffs"] = "최대 디버프",
	["Set the maximum number of debuffs to display."] = "표시할 디버프의 최대 갯수를 설정합니다.",
	["Layout"] = "배치",
	["Options for where to place aura frames"] = "오오라 프레임의 위치를 위한 옵션입니다.",
	["Split"] = "분할",
	["Split buff and debuff positions."] = "버프 및 디버프의 위치를 분할합니다.",
	["Side"] = "측면",
	["Which side to position all aura icons at."] = "전체 오오라 아이콘이 위치할 측면을 선택합니다.",
	["Buff growth direction"] = "버프 확장 방향",
	["Set the direction in which buffs grow."] = "버프의 확장 방향을 설정합니다.",
	["Debuff growth direction"] = "디버프 확장 방향",
	["Set the direction in which debuffs grow."] = "디버프의 확장 방향을 설정합니다.",
	["Buff side"] = "버프 측면",
	["Which side to position buff icons at."] = "버프 아이콘이 위치할 측면을 선택합니다.",
	["Debuff side"] = "디버프 측면",
	["Which side to position debuff icons at."] = "디버프 아이콘이 위치할 측면을 선택합니다.",
	["Buff frame width"] = "버프 프레임 너비",
	["The width of the buff frame."] = "버프 프레임의 너비를 설정합니다.",
	["Debuff frame width"] = "디버프 프레임 너비",
	["The width of the debuff frame in split mode."] = "분할 모드에서 디버프 프레임의 너비를 설정합니다.",
	["Flip buffs/debuffs"] = "버프/디버프 뒤집기",
	["Flip the positions of buffs and debuffs."] = "버프/디버프의 위치를 뒤집습니다.",
	["Invert debuff direction"] = "디버프 방향 뒤집기",
	["Invert the direction of debuffs."] = "디버프의 방향을 뒤집습니다.",
	["Growth direction"] = "확장 방향",
	["Set the growth direction for extra rows of buffs and debuffs."] = "버프/디버프의 별도의 열을 위한 확장 방향을 설정합니다.",
	["Offsets"] = "좌표",
	["Aura frame offsets."] = "오오라 프레임의 좌표를 설정합니다.",
	["Buff horizontal offset"] = "버프의 가로 좌표",
	["Buff vertical offset"] = "버프의 세로 좌표",
	["Debuff horizontal offset"] = "디버프의 가로 좌표",
	["Debuff vertical offset"] = "디버프의 세로 좌표",
	["Font Size"] = "글꼴 크기",
	["Font size used for duration text and aura stack counter."] = "지속 문자와 오오라의 중첩 횟수에 사용하기 위한 글꼴의 크기를 설정합니다.",
	["Aura"] = "오오라",
	["Aura options for all units."] = "모든 유닛을 위한 오오라 옵션입니다.",
	["Cooldown spiral"] = "나선형 재사용 대기시간",
	["Toggle whether the cooldown spiral shows."] = "블리자드의 시계 방향 재사용 대기시간을 보여줄지 여부를 전환합니다.",
	["Cooldown text"] = "재사용 대기시간 문자",
	["Options for the cooldown text display."] = "재사용 대기시간 문자 표시를 위한 옵션입니다.",
	["Toggle"] = "전환",
	["Toggle whether to show the cooldown text."] = "재사용 대기시간 문자를 보여줄지 여부를 전환합니다.",
	["Color"] = "색상",
	["Color of the cooldown text (including opacity)."] = "재사용 대기시간 문자의 색상을 설정합니다(불투명도 포함).",
	["Zoom textures"] = "텍스쳐 확대",
	["Zoom in on aura icons slightly."] = "오오라 아이콘을 약간 확대해 보여줍니다.",
	["Use Weapon Buff Spell Icon"] = "무기 버프 주문 아이콘 사용",
	["Display weapon buffs using the spell icon rather than the weapon's icon."] = "무기 버프에 무기 아이콘이 아닌, 주문 아이콘을 표시합니다.",
	["Border Colors"] = "테두리 색상",
	["Set the border colors for the various aura types."] = "다양한 오오라 유형을 위한 테두리 색상을 설정합니다.",
	["Set the border colors for the various buff types."] = "다양한 버프 유형을 위한 테두리 색상을 설정합니다.",
	["Own"] = "자신",
	["Set the color for buffs that you cast."] = "자신이 시전한 버프에 대해 색상을 설정합니다.",
	["Other"] = "기타",
	["Set the color for buffs cast by others."] = "다른이에 의해 시전된 버프를 위한 색상을 설정합니다.",
	["Weapon"] = "무기",
	["Set the color for weapon buffs."] = "무기 버프를 위한 색상을 설정합니다.",
	["Use Weapon Item Quality"] = "무기 아이템 등급 사용",
	["Weapon buff borders will be colored by weapon quality."] = "무기 등급에 의해 무기 버프 테두리 색상을 가집니다.",
	["Set the border colors for the various debuff types."] = "다양한 디버프 유형을 위한 테두리 색상을 설정합니다.",
	["Curse"] = "저주",
	["Set color for curses."] = "저주를 위한 색상을 설정합니다.",
	["Poison"] = "독",
	["Set color for poisons."] = "독을 위한 색상을 설정합니다.",
	["Magic"] = "마법",
	["Set color for magic."] = "마법을 위한 색상을 설정합니다.",
	["Disease"] = "질병",
	["Set color for diseases."] = "질병을 위한 색상을 설정합니다.",
	["Set color for others."] = "기타 디버프 유형을 위한 색상을 설정합니다.",
	["Friend buff filtering"] = "아군 버프 선별",
	["Select buffs to be filtered for friends and yourself."] = "아군 및 자신을 위해 선별할 버프를 선택합니다.",
	["Extra friend buffs"] = "별도 아군 버프",
	["Additional buffs that will be shown on friends and yourself."] = "아군 및 자신에게 보여질 추가적인 버프를 선택합니다.",
	["Add extra friend buff"] = "별도 아군 버프 추가",
	["Add a buff to show on friends that is not listed."] = "목록에 없는 아군에게 보여질 버프를 추가합니다.",
	["<Buff name>"] = "<버프 이름>",
	["Enemy debuff filtering"] = "적군 디버프 선별",
	["Select debuffs to be filtered for enemies."] = "적군을 위해 선별할 디버프를 선택합니다.",
	["Extra enemy debuffs"] = "별도 적군 디버프",
	["Additional debuffs that will be shown on enemies."] = "적군에게 보여질 추가적인 디버프를 선택합니다.",
	["Add extra enemy debuff"] = "별도 적군 디버프 추가",
	["Add a debuff to show on enemies that is not listed."] = "목록에 없는 적군에게 보여질 디버프를 추가합니다.",
	["<Debuff name>"] = "<디버프 이름>",
	["Friend debuff filtering"] = "아군 디버프 선별",
	["Select debuffs to be filtered for friends."] = "아군을 위해 선별할 디버프를 선택합니다.",
	["Extra friend debuffs"] = "별도 아군 디버프",
	["Additional debuffs that will be shown on friends and yourself."] = "아군 및 자신에게 보여질 추가적인 디버프를 선택합니다.",
	["Add extra friend debuff"] = "별도 아군 디버프 추가",
	["Add a debuff to show on friends that is not listed."] = "목록에 없는 아군에게 보여질 디버프를 추가합니다.",
} or (GetLocale() == "zhCN") and {
	["Show buffs and debuffs for PitBull frames as well as highlight frames that need cleansing."] = "为PitBull框体显示Buff和Debuff，同时也会高亮需要驱散的框体。",
	["Up"] = "上",
	["Down"] = "下",
	["Left"] = "左",
	["Top-left"] = "左上",
	["Bottom-left"] = "左下",
	["Right"] = "右",
	["Top-right"] = "右上",
	["Bottom-right"] = "右下",
	["Top"] = "顶部",
	["Bottom"] = "底部",
	["Up then Left"] = "先上后左",
	["Up then Right"] = "先上后右",
	["Down then Left"] = "先下后左",
	["Down then Right"] = "先下后右",
	["Left then Up"] = "先左后上",
	["Left then Down"] = "先左后下",
	["Right then Up"] = "先右后上",
	["Right then Down"] = "先右后下",
	["Never"] = "从不",
	["All Debuffs"] = "所有的Debuff",
	["Cureable"] = "能解除的",
	["Cureable by me"] = "能被我解除的",
	["Border"] = "边框",
	["Thin Border"] = "细边框",
	["Normal"] = "正常",
	["Auras"] = "法术效果",
	["Options for buff and debuff display for this unit type."] = "这种单位类型的Buff和Debuff显示选项。",
	["Snap"] = "吸附",
	["Resize auras to fill the available row space."] = "调整法术效果的大小以填满可用的行空间。",
	["Sort"] = "排序",
	["Sort this unit's debuffs by type then alphabetically."] = "先按类型，然后按字母顺序排列Debuff。",
	["Enable"] = "启用",
	["Enable buffs or debuffs."] = "启用Buff以及Debuff。",
	["Buffs"] = "Buff",
	["Enable buffs."] = "启用Buff。",
	["Debuffs"] = "Debuff",
	["Enable debuffs."] = "启用Debuff。",
	["Borders"] = "边框",
	["Options for aura icon borders."] = "法术效果的图标边框的选项。",
	["Enable colored buff borders"] = "启用Buff边框染色。",
	["Weapon Buffs"] = "武器Buff",
	["Enable weapon buffs."] = "启用武器Buff。",
	["Buff types"] = "Buff类型",
	["Color buff borders by buff type."] = "以类型为基础设置不同Buff的边框颜色。",
	["Enable colored debuff borders"] = "启用Debuff边框染色",
	["Debuff types"] = "Debuff类型",
	["Color debuff borders by debuff type."] = "以类型为基础设置不同Debuff的颜色.",
	["Frame debuff highlight"] = "Debuff高亮框体",
	["Highlighting the unit frame itself when the unit is debuffed."] = "当单位中Defuff时高亮显示其框体。",
	["Frame debuff highlight style"] = "Debuff高亮框体样式",
	["Set how the frame debuff highlight looks."] = "设置中Debuff时高亮框体的外观。",
	["Enable buff filtering"] = "启用Buff过滤",
	["Filter certain buffs based on your class."] = "根据自身职业过滤部分Buff。",
	["Enable debuff filtering"] = "启用Debuff过滤",
	["Filter certain debuffs based on your class."] = "根据自身职业过滤部分Debuff。",
	["Debuff size"] = "Debuff大小",
	["Set size of debuff icons."] = "设置Debuff图标的大小。",
	["Buff size"] = "Buff大小",
	["Set size of buff icons."] = "设置Buff图标的大小。",
	["Buff spacing"] = "Buff间距",
	["Set horizontal spacing between each buff."] = "设置各个Buff的水平间隔距离。",
	["Max buffs"] = "最大Buff数量",
	["Set the maximum number of buffs to display."] = "设置显示Buff的最大数量。",
	["Max debuffs"] = "最大Debuff数量",
	["Set the maximum number of debuffs to display."] = "设置显示Debuff的最大数量。",
	["Layout"] = "布局",
	["Options for where to place aura frames"] = "设置在哪里放置法术效果框体",
	["Split"] = "分离",
	["Split buff and debuff positions."] = "分离Buff和Debuff的位置。",
	["Side"] = "位置",
	["Which side to position all aura icons at."] = "设置在哪一边放置所有的法术效果图标。",
	["Buff growth direction"] = "Buff扩展方向",
	["Set the direction in which buffs grow."] = "设置Buff图标的扩展方向。",
	["Debuff growth direction"] = "Debuff扩展方向",
	["Set the direction in which debuffs grow."] = "设置Debuff图标的扩展方向。",
	["Buff side"] = "Buff位置",
	["Which side to position buff icons at."] = "设置在哪一边放置Buff图标。",
	["Debuff side"] = "Debuff位置",
	["Which side to position debuff icons at."] = "设置在哪一边放置Debuff图标。",
	["Buff frame width"] = "Buff框体宽度",
	["The width of the buff frame."] = "Buff框体的宽度。",
	["Debuff frame width"] = "Debuff框体宽度",
	["The width of the debuff frame in split mode."] = "Debuff框体的宽度。",
	["Flip buffs/debuffs"] = "交换Buff/Debuff",
	["Flip the positions of buffs and debuffs."] = "交换Buff/Debuff的位置。",
	["Invert debuff direction"] = "反转Debuff方向",
	["Invert the direction of debuffs."] = "反转Debuff的方向。",
	["Growth direction"] = "扩展方向",
	["Set the growth direction for extra rows of buffs and debuffs."] = "设定额外的Buff/Debuff行所扩展的方向。",
	["Offsets"] = "偏移",
	["Aura frame offsets."] = "法术效果框架的偏移量。",
	["Buff horizontal offset"] = "Buff水平偏移",
	["Buff vertical offset"] = "Buff垂直偏移",
	["Debuff horizontal offset"] = "Debuff水平偏移",
	["Debuff vertical offset"] = "Debuff垂直偏移",
	["Font Size"] = "字体大小",
	["Font size used for duration text and aura stack counter."] = "法术效果持续时间以及叠加次数的字体大小。",
	["Aura"] = "法术效果",
	["Aura options for all units."] = "所有单位的法术效果选项。",
	["Cooldown spiral"] = "冷却指示",
	["Toggle whether the cooldown spiral shows."] = "是否显示顺时针冷却指示器。",
	["Cooldown text"] = "冷却文字",
	["Options for the cooldown text display."] = "关于冷却文字显示的选项。",
	["Toggle"] = "切换",
	["Toggle whether to show the cooldown text."] = "切换是否显示冷却文字。",
	["Color"] = "颜色",
	["Color of the cooldown text (including opacity)."] = "冷却文字的颜色(包括透明度)。",
	["Zoom textures"] = "放大图标",
	["Zoom in on aura icons slightly."] = "略微地放大一下法术效果图标。",
	["Use Weapon Buff Spell Icon"] = "武器Buff使用法术图标",
	["Display weapon buffs using the spell icon rather than the weapon's icon."] = "用武器Buff的法术图标取代武器自己的物品图标显示。",
	["Colors"] = "颜色",
	["Border Colors"] = "边框颜色",
	["Set the border colors for the various aura types."] = "为不同类型的法术效果设置边框颜色。",
	["Set the border colors for the various buff types."] = "为不同类型的Buff设置边框颜色。",
	["Own"] = "自身",
	["Set the color for buffs that you cast."] = "你自己施放的Buff的颜色。",
	["Other"] = "其他",
	["Set the color for buffs cast by others."] = "其他人施放的Buff的颜色。",
	["Weapon"] = "武器",
	["Set the color for weapon buffs."] = "武器上的Buff的颜色。",
	["Use Weapon Item Quality"] = "使用武器品质",
	["Weapon buff borders will be colored by weapon quality."] = "武器Buff将按照武器物品品质显示边框颜色。",
	["Set the border colors for the various debuff types."] = "为不同类型的Debuff设置边框颜色。",
	["Curse"] = "诅咒",
	["Set color for curses."] = "设置诅咒的颜色。",
	["Poison"] = "中毒",
	["Set color for poisons."] = "设置中毒的颜色。",
	["Magic"] = "魔法",
	["Set color for magic."] = "设置魔法的颜色。",
	["Disease"] = "疾病",
	["Set color for diseases."] = "设置疾病的颜色。",
	["Set color for others."] = "设置其他Debuff的颜色。",
	["Friend buff filtering"] = "友方Buff过滤",
	["Select buffs to be filtered for friends and yourself."] = "为友好目标和你自己选择要过滤的Buff。",
	["Extra friend buffs"] = "额外的友方Buff",
	["Additional buffs that will be shown on friends and yourself."] = "友好目标和你自己所要显示的额外的Buff。",
	["Add extra friend buff"] = "添加额外的友方Buff",
	["Add a buff to show on friends that is not listed."] = "为友好目标所显示的Buff添加一个列表里没有的。",
	["<Buff name>"] = "<Buff名称>",
	["Enemy debuff filtering"] = "敌方Debuff过滤",
	["Select debuffs to be filtered for enemies."] = "为敌对目标选择要过滤的Debuff。",
	["Extra enemy debuffs"] = "额外的敌方Debuff",
	["Additional debuffs that will be shown on enemies."] = "敌对目标所要显示的额外的Debuff。",
	["Add extra enemy debuff"] = "添加额外的敌方Debuff",
	["Add a debuff to show on enemies that is not listed."] = "为敌对目标所显示的Debuff添加一个列表里没有的。",
	["<Debuff name>"] = "<Debuff名称>",
	["Friend debuff filtering"] = "友方Debuff过滤",
	["Select debuffs to be filtered for friends."] = "为友好目标选择要过滤的Debuff。",
	["Extra friend debuffs"] = "额外的友方Debuff",
	["Additional debuffs that will be shown on friends and yourself."] = "友好目标所要显示的额外的Debuff。",
	["Add extra friend debuff"] = "添加额外的友方Debuff",
	["Add a debuff to show on friends that is not listed."] = "为友好目标所显示的Debuff添加一个列表里没有的。",
} or (GetLocale() == "zhTW") and {
	["Show buffs and debuffs for PitBull frames as well as highlight frames that need cleansing."] = "顯示或隱藏PitBull框架上的Buff和Debuff位置",
	["Up"] = "上",
	["Down"] = "下",
	["Left"] = "左",
	["Top-left"] = "左上",
	["Bottom-left"] = "左下",
	["Right"] = "右",
	["Top-right"] = "右上",
	["Bottom-right"] = "右下",
	["Top"] = "頂部",
	["Bottom"] = "底部",
	["Up then Left"] = "先上後左",
	["Up then Right"] = "先上後右",
	["Down then Left"] = "先下後左",
	["Down then Right"] = "先下後右",
	["Left then Up"] = "先左後上",
	["Left then Down"] = "先左後下",
	["Right then Up"] = "先右後上",
	["Right then Down"] = "先右後下",
	["Never"] = "從不",
	["All Debuffs"] = "所有的Debuff",
	["Cureable"] = "可以驅散的",
	["Cureable by me"] = "可以被我驅散的",
	["Border"] = "邊框",
	["Thin Border"] = "細邊框",
	["Normal"] = "普通",
	["Auras"] = "Buffs和Debuffs",
	["Options for buff and debuff display for this unit type."] = "指定此類單位顯示方法的選項.",
	["Snap"] = "吸附",
	["Resize auras to fill the available row space."] = "調整Buff和Debuff的大小適應此行.",
	["Sort"] = "排序",
	["Sort this unit's debuffs by type then alphabetically."] = "先按類型再按字母順序排列Debuff.",
	["Enable"] = "啟用",
	["Enable buffs or debuffs."] = "啟用Buff或者Debuff.",
	["Buffs"] = "buffs",
	["Enable buffs."] = "啟用Buff.",
	["Debuffs"] = "Debuffs",
	["Enable debuffs."] = "啟用Debuff.",
	["Weapon Buffs"] = "武器Buff",
	["Enable weapon buffs."] = "開啟武器Buff",
	["Borders"] = "外框",
	["Options for aura icon borders."] = "Buff/Debuff外框設定選項.",
	["Enable colored buff borders"] = "啟用Buff外框顏色.",
	["Buff types"] = "Buff類型",
	["Color buff borders by buff type."] = "依照Buff類型指定外框顏色.",
	["Enable colored debuff borders"] = "啟用Debuff外框顏色",
	["Debuff types"] = "DeBuffs類型",
	["Color debuff borders by debuff type."] = "依照Debuff類型指定外框顏色.",
	["Frame debuff highlight"] = "高亮顯示Debuff框架",
	["Highlighting the unit frame itself when the unit is debuffed."] = "當單位中了Debuff時,高亮顯示其框架.",
	["Frame debuff highlight style"] = "debuff框架高亮顯示風格",
	["Set how the frame debuff highlight looks."] = "設定中Debuff時高亮顯示的外觀",
	["Enable buff filtering"] = "啟用Buff過濾",
	["Filter certain buffs based on your class."] = "根據你的職業過濾特定Buff.",
	["Enable debuff filtering"] = "啟用Debuff過濾",
	["Filter certain debuffs based on your class."] = "根據你的職業過濾特定Debuff",
	["Debuff size"] = "Debuff大小",
	["Set size of debuff icons."] = "設定Debuff圖示的大小",
	["Buff size"] = "Buff大小",
	["Set size of buff icons."] = "設定Buff圖示的大小",
	["Buff spacing"] = "Buff間距",
	["Set horizontal spacing between each buff."] = "設定各個Buff的水平間距.",
	["Max buffs"] = "Buff最大值",
	["Set the maximum number of buffs to display."] = "設定顯示Buff的最大數量.",
	["Max debuffs"] = "Debuff最大值",
	["Set the maximum number of debuffs to display."] = "設定顯示Debuff的最大數量",
	["Layout"] = "風格",
	["Options for where to place aura frames"] = "Buff/Debuff圖示位置選項.",
	["Split"] = "分割",
	["Split buff and debuff positions."] = "分割Buff和Debuff的位置.",
	["Side"] = "位置",
	["Which side to position all aura icons at."] = "欲將所有的Buff/Debuff置於框架那一方.",
	["Buff growth direction"] = "Buff延展方向",
	["Set the direction in which buffs grow."] = "設定得到Buff後延展的方向.",
	["Debuff growth direction"] = "Debuff延展方向",
	["Set the direction in which debuffs grow."] = "設定得到Debuff後延展的方向.",
	["Buff side"] = "Buff位置",
	["Which side to position buff icons at."] = "欲將Buff圖示置於何方.",
	["Debuff side"] = "Debuff位置",
	["Which side to position debuff icons at."] = "欲將Debuff圖示置於何方.",
	["Buff frame width"] = "Buff框架寬度",
	["The width of the buff frame."] = "Buff框架的寬度",
	["Debuff frame width"] = "Debuff框架寬度",
	["The width of the debuff frame in split mode."] = "Debuff框架的寬度.",
	["Flip buffs/debuffs"] = "互換Buff/Debuff",
	["Flip the positions of buffs and debuffs."] = "交換Buff和Debuff的顯示位置.",
	["Invert debuff direction"] = "反轉Debuff方向",
	["Invert the direction of debuffs."] = "反轉Debuff的方向.",
	["Growth direction"] = "發展方向",
	["Set the growth direction for extra rows of buffs and debuffs."] =  "設定得到Buff/Debuff時,延展的方向.",
	["Offsets"] = "位移",
	["Aura frame offsets."] = "位移Buff/Debuff",
	["Buff horizontal offset"] = "Buff水平位移",
	["Buff vertical offset"] = "Buff垂直位移",
	["Debuff horizontal offset"] = "Debuff水平位移",
	["Debuff vertical offset"] = "Debuff垂直位移",
	["Font Size"] = "字體大小",
	["Font size used for duration text and aura stack counter."] = "冷卻字體的大小.",
	["Aura"] = "Buffs和Debuffs",
	["Aura options for all units."] = "所有單位Buff/Debuff選項",
	["Cooldown spiral"] = "系統螺旋型冷卻",
	["Toggle whether the cooldown spiral shows."] = "切換是否使用系統螺旋型冷卻方式.",
	["Cooldown text"] = "冷卻文字",
	["Options for the cooldown text display."] = "冷卻文字顯示的選項.",
	["Toggle"] = "切換",
	["Toggle whether to show the cooldown text."] = "切換是否使用文字型冷卻方式",
	["Color"] = "顏色",
	["Color of the cooldown text (including opacity)."] = "冷卻文字顏色(包括透明度)",
	["Zoom textures"] = "縮放材質",
	["Zoom in on aura icons slightly."] = "縮放Buff/DeBuff的材質.",
	["Use Weapon Buff Spell Icon"] = "使用武器Buff圖示",
	["Display weapon buffs using the spell icon rather than the weapon's icon."] = "以法術圖示代替武器圖示, 顯示武器Buff的圖示.",
	["Border Colors"] = "外框顏色",
	["Set the border colors for the various aura types."] = "依照不同類型的Buff/Debuff設定外框顏色.",
	["Set the border colors for the various buff types."] = "依照不同類型的Buff設定外框顏色.",
	["Own"] = "自己",
	["Set the color for buffs that you cast."] = "設定你施放的Buff顏色.",
	["Other"] = "其他",
	["Set the color for buffs cast by others."] = "設定其他人施放的Buff顏色.",
	["Weapon"] = "武器",
	["Set the color for weapon buffs."] = "設定武器buffs的顏色",
	["Use Weapon Item Quality"] = "使用武器品質",
	["Weapon buff borders will be colored by weapon quality."] = "武器Buff將按照其品質顯示外框顏色.",
	["Set the border colors for the various debuff types."] = "依照不同類型的Debuff設定外框顏色.",
	["Curse"] = "詛咒",
	["Set color for curses."] = "設定詛咒的顏色.",
	["Poison"] = "毒藥",
	["Set color for poisons."] = "設定中毒的顏色.",
	["Magic"] = "魔法",
	["Set color for magic."] = "設定魔法的顏色.",
	["Disease"] = "疾病",
	["Set color for diseases."] = "設定疾病的顏色.",
	["Set color for others."] = "設定其他的顏色.",
	["Friend buff filtering"] = "友方目標Buff過濾",
	["Select buffs to be filtered for friends and yourself."] = "選擇欲過濾的友方及自己的Buff.",
	["Extra friend buffs"] = "額外的友方目標Buff",
	["Additional buffs that will be shown on friends and yourself."] = "選擇你欲監看的友方及自己的特定Buff.",
	["Add extra friend buff"] = "增加額外的友方目標Buff",
	["Add a buff to show on friends that is not listed."] = "增加一個你想要對友方和自己監看的Buff, 該Buff不在列表內.",
	["<Buff name>"] = "<Buff名稱>",
	["Enemy debuff filtering"] = "敵對目標Debuff過濾",
	["Select debuffs to be filtered for enemies."] = "選擇你想要過濾的敵對目標Debuff.",
	["Extra enemy debuffs"] = "額外敵對目標Debuff",
	["Additional debuffs that will be shown on enemies."] = "選擇你欲監看敵對目標的特定Debuff.",
	["Add extra enemy debuff"] = "增加額外敵對目標Debuff",
	["Add a debuff to show on enemies that is not listed."] = "增加一個你想要對敵對目標監看的Debuff, 該Debuff不在列表內.",
	["<Debuff name>"] = "<Debuff名稱>",
	["Friend debuff filtering"] = "友方目標Debuff過濾",
	["Select debuffs to be filtered for friends."] = "選擇你想要過濾的友方目標Debuff.",
	["Extra friend debuffs"] = "額外的友方目標Debuff",
	["Additional debuffs that will be shown on friends and yourself."] = "選擇你想要對友方目標監看的特定Debuff.",
	["Add extra friend debuff"] = "增加額外的友方目標Debuff",
	["Add a debuff to show on friends that is not listed."] = "增加一個你想要對友方目標監看的Debuff, 該Debuff不在列表內.",
} or {}

local L = PitBull:L("PitBull-Aura", localization)

self.desc = L["Show buffs and debuffs for PitBull frames as well as highlight frames that need cleansing."]

local _G = _G
local pairs = _G.pairs
local ipairs = _G.ipairs
local setmetatable = _G.setmetatable
local GetTime = _G.GetTime
local math_abs = _G.math.abs
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local GetWeaponEnchantInfo = _G.GetWeaponEnchantInfo

PitBull_Aura.OnInitialize_funcs = {}
function PitBull_Aura:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("Aura")
	PitBull:SetDatabaseNamespaceDefaults("Aura", "profile", {
		['**'] = {
			hidden = false,
			hiddenBuffs = false,
			hiddenDebuffs = false,
			hiddenWeaponBuffs = false,
			--[[
			highlight = { Buffs = true, Debuffs = true},
			highlightType = { Buffs = true, Debuffs = true},
			--]]
			border = { Buffs = true, Debuffs = true},
			borderType = { Buffs = true, Debuffs = true},
			split = false,
			snap = true,
			buffFilter = true,
			debuffFilter = true,
			maxbuffs = 6,
			maxdebuffs = 6,
			buffsize = 16,
			debuffsize = 16,
			buffSpacing = 0,
			flip = false,
			invert = true,
			grow = -1,
			buffdirection = "Right then Down",
			debuffdirection = "Right then Down",
			frameHighlight = "Cureable by me",
			highlightStyle = "border",
			frameWidth = 160,
			frame2Width = 160,
			auraOffsetX = 0,
			auraOffsetY = 0,
			aura2OffsetX = 0,
			aura2OffsetY = 0,
			sort = true,
			--[[
			cooldownTextSize = 8,
			--]]
			fontSize = 8,
			
			auraSide = "bottom",
			--note, these are only used when debuffs are split
			buffSide = "bottom",
			debuffSide = "right",
		},
		target = {
			maxbuffs = 40,
			maxdebuffs = 40,
			buffFilter = false,
			debuffFilter = false,
		},
		colors = {
			buffs = {
				Own = {1, 1, 0, 1},
                Weapon = {1, 0, 0, 1},
				["nil"] = {0, 1, 0, 1},
			},
			debuffs = {
				Poison = {0, 1, 0, 1},
				Magic = {0, 0, 1, 1},
				Disease = {.55, .15, 0, 1},
				Curse = {5, 0, 5, 1},
				["nil"] = {1, 0, 0, 1},
			},
			weaponBuffItemQuality = true
		},
		cooldown = true,
		cooldownText = false,
		cooldownTextColor = {1, 1, 1, 1},
		zoomAura = true,
		weaponBuffSpellIcon = true,
		filter = {
			buffs = {
				['*'] = true,
			},	
			enemyDebuffs = {
				['*'] = true,
			},
			friendDebuffs = {
				['*'] = true,
			},
			extraBuffs = {
				['*'] = false,
			},
			extraEnemyDebuffs = {
				['*'] = false,
			},
			extraFriendDebuffs = {
				['*'] = false,
			},
		}
	})
	--TODO: remove this  conversion code when 2.4 goes live
	if not UnitClassBase then
		for k, v in pairs(self.db.profile) do
			if type(v) == "table" then
				if v.highlight then
					v.border, v.highlight = v.highlight, nil
				end
				if v.highlightType then
					v.borderType, v.highlightType = v.highlightType, nil
				end
				if v.cooldownTextSize then
					v.fontSize, v.cooldownTextSize = v.cooldownTextSize, nil
				end
			end
		end
	end
	
	for i,v in ipairs(self.OnInitialize_funcs) do
		v()
	end
	self.OnInitialize_funcs = nil
end

local totalAuraFrames
_G.table.insert(PitBull_Aura.OnInitialize_funcs, function()
	totalAuraFrames = PitBull_Aura.totalAuraFrames
end)

local playerName = _G.UnitName('player')

PitBull_Aura.OnEnable_funcs = {}
function PitBull_Aura:OnEnable(first)
	self:AddEventListener("UNIT_AURA")
	self:AddEventListener("COMBAT_LOG_EVENT_UNFILTERED")
	self:AddEventListener("UNIT_TARGET")
	
	self:AddRepeatingTimer(0.1, "OnUpdateAllFrames")
	self:AddRepeatingTimer(0.2, "RecheckItemBuffs")
	for i,v in ipairs(self.OnEnable_funcs) do
		v()
	end
end

local namesToUpdate = {}
local unitsToUpdate = {}

local auraEvents = {
	SPELL_AURA_DISPELLED = true,
	SPELL_AURA_STOLEN = true,
	SPELL_AURA_APPLIED = true,
	SPELL_AURA_REMOVED = true,
	SPELL_AURA_APPLIED_DOSE = true,
	SPELL_AURA_REMOVED_DOSE = true,
}
function PitBull_Aura:COMBAT_LOG_EVENT_UNFILTERED(ns, event, timestamp, combatEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, ...)
	if not auraEvents[combatEvent] then
		return
	end
	
	namesToUpdate[destName] = true
	--[[
	"SPELL_AURA_DISPELLED"
	spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType

	"SPELL_AURA_STOLEN"
	spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType

	"SPELL_AURA_APPLIED"
	spellId, spellName, spellSchool, auraType
	(source arguments are nil)

	"SPELL_AURA_REMOVED"
	spellId, spellName, spellSchool, auraType
	(source arguments are nil)

	"SPELL_AURA_APPLIED_DOSE"
	spellId, spellName, spellSchool, auraType, amount
	(source arguments are nil)

	"SPELL_AURA_REMOVED_DOSE"
	spellId, spellName, spellSchool, auraType, amount
	(source arguments are nil)
	]]
end

function PitBull_Aura:UNIT_AURA(ns, event, unit)
	unitsToUpdate[unit] = true
end

function PitBull_Aura:UNIT_TARGET(ns, event, unit)
	if unit == "player" then
		unit = ''
	end
	unitsToUpdate[unit .. "target"] = true
	unitsToUpdate[unit .. "targettarget"] = true
end

local mainhandItemBuff, mainhandFinishTime, mainhandCount
local offhandItemBuff, offhandFinishTime, offhandCount

function PitBull_Aura:GetMainHandItemBuffInfo()
	if mainhandItemBuff then
		return mainhandItemBuff, mainhandFinishTime - GetTime(), mainhandCount
	end
end

function PitBull_Aura:GetOffHandItemBuffInfo()
	if offhandItemBuff then
		return offhandItemBuff, offhandFinishTime - GetTime(), offhandCount
	end
end
do
	local tt = _G.CreateFrame("GameTooltip", "PitBull_Aura_Tooltip", _G.UIParent)
	tt:SetOwner(_G.UIParent, "ANCHOR_NONE")
	local left = {}
	
	local g = tt:CreateFontString()
	g:SetFontObject(_G.GameFontNormal)
	for i = 1, 30 do
		local f = tt:CreateFontString()
		f:SetFontObject(_G.GameFontNormal)
		tt:AddFontStrings(f, g)
		left[i] = f
	end
	local function getItemBuffName(slot)
		tt:ClearLines()
		if not tt:IsOwned(_G.UIParent) then
			tt:SetOwner(_G.UIParent, "ANCHOR_NONE")
		end
		tt:SetInventoryItem("player", slot)
		
		for i = 1, 30 do
			local text = left[i]:GetText()
			if text then
				local buffName = text:match("^([^%(]+) %(%d+ [^%)]+%)$")
				if buffName then
					local buffNameNoRank = buffName:match("^(.*) %d+$")
					return buffNameNoRank or buffName
				end
			else
				break
			end
		end
	end
	
	local function refreshItemBuffs()
		local mainhand, offhand, mainhandTimeLeft, offhandTimeLeft
		mainhand, mainhandTimeLeft, mainhandCount, offhand, offhandTimeLeft, offhandCount = GetWeaponEnchantInfo()
		mainhandItemBuff = mainhand and getItemBuffName(GetInventorySlotInfo("MainHandSlot"))
		offhandItemBuff = offhand and getItemBuffName(GetInventorySlotInfo("SecondaryHandSlot"))
		mainhandFinishTime = mainhandTimeLeft and mainhandTimeLeft / 1000 + GetTime()
		offhandFinishTime = offhandTimeLeft and offhandTimeLeft / 1000 + GetTime()
	end
	
	function PitBull_Aura:RecheckItemBuffs()
		local oldMainhandItemBuff, oldMainhandFinishTime, oldMainhandCount = mainhandItemBuff, mainhandFinishTime, mainhandCount
		local oldOffhandItemBuff, oldOffhandFinishTime, oldOffhandCount = offhandItemBuff, offhandFinishTime, offhandCount
		refreshItemBuffs()
		if mainhandItemBuff ~= oldMainhandItemBuff or
		   offhandItemBuff ~= oldOffhandItemBuff or
		   mainhandCount ~= oldMainhandCount or
		   offhandCount ~= oldOffhandCount or
		   (mainhandFinishTime and math_abs(oldMainhandFinishTime - mainhandFinishTime) > 0.2) or
		   (offhandFinishTime and math_abs(oldOffhandFinishTime - offhandFinishTime) > 0.2) then
			namesToUpdate[playerName] = true
		end
	end
end

local lastUpdated = setmetatable({}, {__index = function(self, key)
	self[key] = 0
	return 0
end})

local UpdateAuraType, UpdateAuraLayout, UpdateFrameHighlight
_G.table.insert(PitBull_Aura.OnInitialize_funcs, function()
	UpdateAuraType = PitBull_Aura.UpdateAuraType
	UpdateAuraLayout = PitBull_Aura.UpdateAuraLayout
	UpdateFrameHighlight = PitBull_Aura.UpdateFrameHighlight
end)
function PitBull_Aura:UpdateAuras(unit, frame)
	lastUpdated[frame] = GetTime()
	
	local db = self.db.profile[frame.group]
	
	if db.frameHighlight == "Never" then
		if frame.debuffHighlight then
			frame.debuffHighlight = delFrame(frame.debuffHighlight)
		end
	else
		UpdateFrameHighlight(unit, frame)
	end
	
	if db.hidden or not frame.auraContainer then
		return
	end
	
	if not db.hiddenBuffs then
		UpdateAuraType(unit, frame, true)
	end
	if not db.hiddenDebuffs then
		UpdateAuraType(unit, frame, false)
	end
	UpdateAuraLayout(frame)
end

function PitBull_Aura:ClearAuras(frame)
	local unit = frame:GetUnit()
	self:OnClearUnitFrame(unit, frame)
	self:OnPopulateUnitFrame(unit, frame)
end

function PitBull_Aura:OnUpdateFont(font, fontsize)
	for frame in pairs(totalAuraFrames) do
		frame.applicationText:SetFont(font, fontsize, "OUTLINE")
	end
end

function PitBull_Aura:OnUpdateFrame(unit, frame, notCrucial)
	if not notCrucial then
		self:UpdateAuras(unit, frame)
	end
end

function PitBull_Aura:OnUpdateAllFrames()
	local currentTime = GetTime()
	local currentTime_1 = currentTime - 1
	local db = self.db.profile
	for unit, frame in PitBull:IterateNonWackyUnitFrames() do
		if unitsToUpdate[unit] or namesToUpdate[frame:GetUnitName()] then
			self:UpdateAuras(unit, frame)
		end
	end
	for unit, frame in PitBull:IterateWackyUnitFrames() do
		if (lastUpdated[frame] < currentTime_1 or unitsToUpdate[unit] or namesToUpdate[frame:GetUnitName()]) then
			self:UpdateAuras(unit, frame)
		end
	end
	for k,v in pairs(unitsToUpdate) do
		unitsToUpdate[k] = nil
	end
	for k,v in pairs(namesToUpdate) do
		namesToUpdate[k] = nil
	end
end

function PitBull_Aura:OnClearUnitFrame(unit, frame)
	if frame.auraContainer then
		frame.auraContainer = delFrame(frame.auraContainer)
	end
	if frame.auraContainer2 then
		frame.auraContainer2 = delFrame(frame.auraContainer2)
	end
	if frame.debuffHighlight then
		frame.debuffHighlight = delFrame(frame.debuffHighlight)
	end
end

function PitBull_Aura:OnPopulateUnitFrame(unit, frame)
	local db = self.db.profile[frame.group]
	if not db.hidden then
		frame.auraContainer = newFrame("AuraContainer", frame)
		if db.split then
			frame.auraContainer2 = newFrame("AuraContainer", frame)
		end
	end
	
	lastUpdated[frame] = 0
end
