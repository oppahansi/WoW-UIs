local VERSION = tonumber(("$Revision: 67479 $"):match("%d+"))

local PitBull = PitBull
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-01 06:54:47 -0400 (Tue, 01 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local _,playerClass = UnitClass("player")

local localization = (GetLocale() == "koKR") and {
	["Position"] = "위치",
	["Position of the text."] = "문자의 위치를 설정합니다.",
	["Size"] = "크기",
	["Size of the icon."] = "아이콘의 크기를 설정합니다.",
	["Blank space"] = "빈 공간",
	["Left"] = "좌측",
	["Right"] = "우측",
	["Center"] = "중앙",
	["Width"] = "너비",
	["Height"] = "높이",
	["Relative width of the bar."] = "바의 상대적인 너비를 설정합니다.",
	["Relative height of the bar."] = "바의 상대적인 높이를 설정합니다.",
	["Reverses the direction of the bar, filling it from top to bottom."] = "바의 진행 방향을 뒤집어 상단에서 하단으로 채워 나갑니다.",
	["Reverses the direction of the bar, filling it from right to left."] = "바의 진행 방향을 뒤집어 우측에서 좌측으로 채워 나갑니다.",
	["Side"] = "측면",
	["What side of the unit frame to position the bar at."] = "바가 위치할 유닛 프레임의 측면을 선택합니다.",
	["Position of the bar relative to other bars."] = "다른 바와의 상대적인 바의 위치를 설정합니다.",
	["Reverse"] = "뒤집기",
	["Deficit"] = "결손치로 보이기",
	["Drain the bar instead of filling it."] = "바를 채워 나가는 대신에 빠져 나가는 방식으로 보여줍니다.",
	["Filled opacity"] = "채워진 바 불투명도",
	["The opacity of the filled part of the bar."] = "바의 채워진 부분의 불투명도를 설정합니다.",
	["Empty opacity"] = "비워진 바 불투명도",
	["The opacity of the empty part of the bar."] = "바의 비워진 부분의 불투명도를 설정합니다.",
	["Combo points"] = "연계 점수",
	["Options for the combo point display."] = "연계 점수를 표시하기 위한 옵션입니다.",
	["What position of the unit frame to position the combo point display at."] = "연계 점수 표시가 위치할 유닛 프레임의 위치를 설정합니다.",
	["Top-left"] = "상단-좌측",
	["Bottom-left"] = "하단-좌측",
	["Top-right"] = "상단-우측",
	["Bottom-right"] = "하단-우측",
	["Top"] = "상단",
	["Bottom"] = "하단",
	["Outside, Left"] = "바깥측면, 좌측",
	["Outside, Left-top"] = "바깥측면, 좌측-상단",
	["Outside, Left-bottom"] = "바깥측면, 좌측-하단",
	["Outside, Right"] = "바깥측면, 우측",
	["Outside, Right-top"] = "바깥측면, 우측-상단",
	["Outside, Right-bottom"] = "바깥측면, 우측-하단",
	["Outside, Above"] = "바깥측면, 위",
	["Outside, Above-left"] = "바깥측면, 위-좌측",
	["Outside, Above-right"] = "바깥측면, 위-우측",
	["Outside, Below"] = "바깥측면, 아래",
	["Outside, Below-left"] = "바깥측면, 아래-좌측",
	["Outside, Below-right"] = "바깥측면, 아래-우측",
	["Inside, Left"] = "안쪽측면, 좌측",
	["Inside, Left-top"] = "안쪽측면, 좌측-상단",
	["Inside, Left-bottom"] = "안쪽측면, 좌측-하단",
	["Inside, Right"] = "안쪽측면, 우측",
	["Inside, Right-top"] = "안쪽측면, 우측-상단",
	["Inside, Right-bottom"] = "안쪽측면, 우측-하단",
	["Inside, Top"] = "안쪽측면, 상단",
	["Inside, Top-left"] = "안쪽측면, 상단-좌측",
	["Inside, Top-right"] = "안쪽측면, 상단-우측",
	["Inside, Bottom"] = "안쪽측면, 하단",
	["Inside, Bottom-left"] = "안쪽측면, 하단-좌측",
	["Inside, Bottom-right"] = "안쪽측면, 하단-우측",
	["Class"] = "직업",
	["Health"] = "생명력",
	["Name"] = "이름",
	["Power"] = "마력",
	["Druid mana"] = "드루이드 마나",
	["Threat"] = "위협",
	["Experience"] = "경험치",
	["Reputation"] = "평판",
	["Cast"] = "시전",
	["CastTime"] = "시전 시간",
	["None"] = "없음",
	["Middle"] = "중간",
	["Frame"] = "프레임",
	["Outside, Above-middle"] = "바깥측면, 위-중간",
	["Outside, Below-middle"] = "바깥측면, 아래-중간",
	["Outside, Left-middle"] = "바깥측면, 좌측-중간",
	["Outside, Right-middle"] = "바깥측면, 우측-중간",
	["Inside, Center"] = "안쪽측면, 정중앙",
	["Edge, Top-left"] = "가장자리, 상단-좌측",
	["Edge, Top"] = "가장자리, 상단",
	["Edge, Top-right"] = "가장자리, 상단-우측",
	["Edge, Left"] = "가장자리, 좌측",
	["Edge, Right"] = "가장자리, 우측",
	["Edge, Bottom-left"] = "가장자리, 하단-좌측",
	["Edge, Bottom"] = "가장자리, 하단",
	["Edge, Bottom-right"] = "가장자리, 하단-우측",
	["Hidden"] = "숨김",
	["Hide"] = "숨김", 
	["Custom"] = "사용자",
	["Choose your own custom text."] = "자신의 사용자 문자를 선택합니다.",
	["Style"] = "양식",
	["Use a preconfigured style."] = "미리 설정된 양식을 사용합니다.",
	["Style - Custom"] = "양식 - 사용자",
	["Create a custom style for this unit type."] = "이 유닛 유형을 위한 사용자 양식을 생성합니다.",
	["LibDogTag-3.0 tags. See http://www.wowace.com/wiki/LibDogTag-3.0"] = "LibDogTag-3.0 태그입니다.  http://www.wowace.com/wiki/LibDogTag-3.0을 보십시요.",
	["Style - Type"] = "양식 - 유형",
	["Choose the type of pre-made styles to work with."] = "함께 작업할 미리 만들어진 양식의 유형을 선택합니다.",
	["Position of the text."] = "문자의 위치를 설정합니다.",
	["Font size of the text."] = "문자의 글꼴 크기를 설정합니다.",
	["Enable"] = "활성화",
	["Click to disable this text from being shown."] = "보여지는 상태에서 이 문자를 비활성화하려면 클릭하십시오.",
	["DogTag help"] = "DogTag 도움말",
	["Open"] = "열기",
	["Click to pop up helpful DogTag documentation."] = "도움이 되는 DogTag 문서를 팝업하려면 클릭하십시오.",
	["Customize the %s text."] = "%s 문자를 사용자 문자로 합니다.",
	["Combat"] = "전투",
	["Name required"] = "필요한 이름",
	["Name already in use"] = "이미 사용중인 이름",
	["Other"] = "기타",
	["Create other texts."] = "기타 문자를 생성합니다.",
	["Disabled texts"] = "비활성화된 문자",
	["Show some of the disabled texts."] = "비활성화된 문자중에 몇개를 보여줍니다.",
	["New text"] = "새로운 문자",
	["Create a new text."] = "새로운 문자를 생성합니다.",
	["<Name>"] = "<이름>",
	["Change settings for the blank space."] = "빈 공간을 위한 설정을 변경합니다.",
	["Enable the blank space."] = "빈 공간을 활성화합니다.",
} or (GetLocale() == "zhCN") and {
	["Deficit"] = "亏减模式",
	["Drain the bar instead of filling it."] = "从全满状态逐渐清空计量条，而不是从全空逐渐填满它。",
	["Filled opacity"] = "填充透明度",
	["The opacity of the filled part of the bar."] = "计量条有填充部分的透明度。",
	["Empty opacity"] = "无填充透明度",
	["The opacity of the empty part of the bar."] = "计量条无填充部分的透明度。",
	["Position"] = "位置",
	["Position of the text."] = "设置文本显示的位置。",
	["Size"] = "大小",
	["Size of the icon."] = "设置图标显示的大小。",
	["Blank space"] = "空白条",
	["Left"] = "左边",
	["Right"] = "右边",
	["Center"] = "中间",
	["Width"] = "宽度",
	["Height"] = "高度",
	["Relative width of the bar."] = "设置计量条的相对宽度。",
	["Relative height of the bar."] = "设置计量条的相对高度。",
	["Reverses the direction of the bar, filling it from top to bottom."] = "将计量条从上往下填充。",
	["Reverses the direction of the bar, filling it from right to left."] = "将计量条从右往左填充。",
	["Side"] = "侧边位置",
	["What side of the unit frame to position the bar at."] = "将计量条所定位于单位框体的侧边位置。",
	["Position of the bar relative to other bars."] = "该计量条相对于其他计量条的位置。",
	["Reverse"] = "反向填充",
	["Top-left"] = "左上",
	["Bottom-left"] = "左下",
	["Top-right"] = "右上",
	["Bottom-right"] = "右下",
	["Top"] = "顶部",
	["Bottom"] = "底部",
	["Combo points"] = "连击点",
	["Options for the combo point display."] = "连击点的显示选项。",
	["What position of the unit frame to position the combo point display at."] = "连击点相对于单位框体所显示的位置。",
	["Outside, Left"] = "外侧左边",
	["Outside, Left-top"] = "外侧左上",
	["Outside, Left-bottom"] = "外侧左下",
	["Outside, Right"] = "外侧右边",
	["Outside, Right-top"] = "外侧右上",
	["Outside, Right-bottom"] = "外侧右下",
	["Outside, Above"] = "外侧上边",
	["Outside, Above-left"] = "外侧上偏左",
	["Outside, Above-right"] = "外侧上偏右",
	["Outside, Below"] = "外侧下边",
	["Outside, Below-left"] = "外侧下偏左",
	["Outside, Below-right"] = "外侧下偏右",
	["Outside, Above-middle"] = "外侧中上方",
	["Outside, Below-middle"] = "外侧中下方",
	["Outside, Left-middle"] = "外侧正左方",
	["Outside, Right-middle"] = "外侧正右方",
	["Inside, Left"] = "内侧左边",
	["Inside, Left-top"] = "内侧左上",
	["Inside, Left-bottom"] = "内侧左下",
	["Inside, Right"] = "内侧右边",
	["Inside, Right-top"] = "内侧右上",
	["Inside, Right-bottom"] = "内侧右下",
	["Inside, Top"] = "内侧上边",
	["Inside, Top-left"] = "内侧上偏左",
	["Inside, Top-right"] = "内侧上偏右",
	["Inside, Bottom"] = "内侧下边",
	["Inside, Bottom-left"] = "内侧下偏左",
	["Inside, Bottom-right"] = "内侧下偏右",
	["Inside, Center"] = "内侧正中",
	["Edge, Top-left"] = "边缘左上",
	["Edge, Top"] = "边缘上方",
	["Edge, Top-right"] = "边缘右上",
	["Edge, Left"] = "边缘左方",
	["Edge, Right"] = "边缘右方",
	["Edge, Bottom-left"] = "边缘左下",
	["Edge, Bottom"] = "边缘下方",
	["Edge, Bottom-right"] = "边缘右下",
	["Class"] = "职业",
	["Health"] = "生命",
	["Name"] = "姓名",
	["Power"] = "能量",
	["Druid mana"] = "德鲁伊法力",
	["Threat"] = "仇恨",
	["Experience"] = "经验",
	["Reputation"] = "声望",
	["Cast"] = "施法进度",
	["CastTime"] = "施法时间",
	["None"] = "无",
	["Middle"] = "中间",
	["Frame"] = "框体",
	["Hidden"] = "已隐藏",
	["Hide"] = "隐藏", 
	["Custom"] = "自定义",
	["Choose your own custom text."] = "选择你的自定义文本。",
	["Style"] = "样式",
	["Use a preconfigured style."] = "使用一个预设的样式。",
	["Style - Custom"] = "自定义样式",
	["Create a custom style for this unit type."] = "为该单位类型创建一个自定义的样式。",
	["LibDogTag-3.0 tags. See http://www.wowace.com/wiki/LibDogTag-3.0"] = "LibDogTag-3.0的标签。请参见http://www.wowace.com/wiki/LibDogTag-3.0",
	["Style - Type"] = "样式类别",
	["Choose the type of pre-made styles to work with."] = "选择一个预先设置好的类别以选择样式。",
	["Position of the text."] = "文字的位置。",
	["Font size of the text."] = "文字字体的大小。",
	["Enable"] = "启用",
	["Click to disable this text from being shown."] = "点击以关闭这个文字的显示。",
	["DogTag help"] = "DogTag 帮助",
	["Open"] = "打开",
	["Click to pop up helpful DogTag documentation."] = "点击打开DogTag的参考文档。",
	["Customize the %s text."] = "自定%s文字。",
	["Combat"] = "战斗",
	["Other"] = "其他",
	["Create other texts."] = "创建其他文字。",
	["Disabled texts"] = "关闭文字",
	["Show some of the disabled texts."] = "显示那些被关闭掉的文字。",
	["New text"] = "新文字",
	["Create a new text."] = "创建一个新的文字。",
	["<Name>"] = "<名称>",
	["Change settings for the blank space."] = "更改空白条的设置。",
	["Enable the blank space."] = "启用空白条。",
	["Name required"] = "名称是必需的",
	["Name already in use"] = "该名称已经被使用了",
} or (GetLocale() == "frFR") and {
	["DogTag help"] = "Aide de DogTag",
	["Open"] = "Ouvrir",
	["Click to pop up helpful DogTag documentation."] = "Cliquez pour ouvrir une documentation utile sur DogTag.",
	["Position"] = "Position",
	["Reverse"] = "Inverser",
	["Position of the text."] = "Position du texte.",
	["Size"] = "Taille",
	["Size of the icon."] = "Taille de l'icône.",
	["Font size of the text."] = "Taille de la police.",
	["Druid mana"] = "Mana de Druide",
	["Blank space"] = "Espace vide",
	["Position of the bar relative to other bars."] = "Position de la barre par rapport aux autres barres.",
	["Height"] = "Hauteur",
	["Relative height of the bar."] = "Hauteur relative de la barre.",
	["Reverses the direction of the bar, filling it from top to bottom."] = "Inver la direction de la barre, la remplissant du haut vers le bas.",
	["Reverses the direction of the bar, filling it from right to left."] = "Inverse la direction de la barre, la remplissant de droite à gauche.",
	["Side"] = "Côté",
	["What side of the unit frame to position the bar at."] = "Côté de la fenêtre où positionner la barre.",
	["Top"] = "Haut",
	["Bottom"] = "Bas",
	["Left"] = "Gauche",
	["Right"] = "Droite",
	["Center"] = "Centre",
	["Middle"] = "Milieu",
	["Top-left"] = "En haut à gauche",
	["Top-right"] = "En haut à droite",
	["Bottom-left"] = "En bas à gauche",
	["Bottom-right"] = "En bas à droite",
	["Outside, Right"] = "En dehors, Droite",
	["Outside, Left"] = "En dehors, Gauche",
	["Outside, Above-left"] = "En dehors, Au-dessus à gauche",
	["Outside, Above-middle"] = "En dehors, Au-dessus au milieu",
	["Outside, Above-right"] = "En dehors, Au-dessus à droite",
	["Outside, Below-left"] = "En dehors, En-dessous à gauche",
	["Outside, Below-middle"] = "En dehors, En-dessous au milieu",
	["Outside, Below-right"] = "En dehors, En-dessous à droite",
	["Outside, Left-top"] = "En dehors, A gauche en haut",
	["Outside, Left-middle"] = "En dehors, A gauche au milieu",
	["Outside, Left-bottom"] = "En dehors, A gauche en bas",
	["Outside, Right-top"] = "En dehors, A droite en haut",
	["Outside, Right-middle"] = "En dehors, A droite au milieu",
	["Outside, Right-bottom"] = "En dehors, A droite en bas",
	["Inside, Center"] = "A l'intérieur, Centre",
	["Inside, Top-left"] = "A l'intérieur, En haut à gauche",
	["Inside, Top"] = "A l'intérieur, En haut",
	["Inside, Top-right"] = "A l'intérieur, En haut à droite",
	["Inside, Bottom-left"] = "A l'intérieur, En bas à gauche",
	["Inside, Bottom"] = "A l'intérieur, En bas",
	["Inside, Bottom-right"] = "A l'intérieur, En bas à droite",
	["Inside, Left"] = "A l'intérieur, Gauche",
	["Inside, Right"] = "A l'intérieur, Droite",
	["Edge, Top-left"] = "Au bord, En haut à gauche",
	["Edge, Top"] = "Au bord, En haut",
	["Edge, Top-right"] = "Au bord, En haut à droite",
	["Edge, Left"] = "Au bord, A gauche",
	["Edge, Right"] = "Au bord, A droite",
	["Edge, Bottom-left"] = "Au bord, En bas à gauche",
	["Edge, Bottom"] = "Au bord, En bas",
	["Edge, Bottom-right"] = "Au bord, En bas à droite",
	["Combo points"] = "Points de combo",
	["Options for the combo point display."] = "Options pour l'affichage des points de combo.",
	["What position of the unit frame to position the combo point display at."] = "Position des points de combo sur la fenêtre d'unité.",
	["Class"] = "Classe",
	["Health"] = "Vie",
	["Name"] = "Nom",
	["Power"] = "Energie",
	["Threat"] = "Menace",
	["Combo points"] = "Points de combo",
	["Experience"] = "Expérience",
	["Reputation"] = "Réputation",
	["Cast"] = "Invocation",
	["CastTime"] = "Temps d'invocation",
	["None"] = "Aucun",
	["Frame"] = "Fenêtre",
	["Hidden"] = "Caché",
	["Hide"] = "Cacher", 
	["Custom"] = "Personnalisé",
	["Choose your own custom text."] = "Choisissez votre propre texte personnalisé.",
	["Style"] = "Style",
	["Use a preconfigured style."] = "Utiliser un style préconfiguré.",
	["Style - Custom"] = "Style - Personnalisé",
	["Create a custom style for this unit type."] = "Créer un style personnalisé pour ce type d'unité.",
	["LibDogTag-2.0 tags. See http://www.wowace.com/wiki/LibDogTag-2.0"] = "Balises LibDogTag-2.0. Voir http://www.wowace.com/wiki/LibDogTag-2.0",
	["Style - Type"] = "Style - Type",
	["Choose the type of pre-made styles to work with."] = "Choisissez le type de style préfabriqué à utiliser.",
	["Enable"] = "Activer",
	["Click to disable this text from being shown."] = "Cliquez pour désactiver ce texte.",
	["Customize the %s text."] = "Personnalise le texte %s.",
	["Combat"] = "Combat",
	["Other"] = "Autre",
	["Create other texts."] = "Créez d'autre textes.",
	["Disabled texts"] = "Textes désactivés",
	["Show some of the disabled texts."] = "Afficher les textes désactivés.",
	["New text"] = "Nouveau texte",
	["Create a new text."] = "Créer un nouveau texte.",
	["<Name>"] = "<Nom>",
	["Change settings for the blank space."] = "Changer les paramètres pour les espaces vides.",
	["Enable the blank space."] = "Activer l'espace vide.",
	["combatText"] = "Texte de combat",
	["**"] = "**",
	["Standard"] = "Standard",
	["Standard Name"] = "Nom standard",
	["Standard Time"] = "Temps standard",
	["Player Classes Only"] = "Classe du joueur seulement",
	["Short"] = "Court",
	["Absolute"] = "Absolut",
	["Absolute Short"] = "Court absolu",
	["Difference"] = "Différence",
	["Percent"] = "Pourcentage",
	["Mini"] = "Mini",
	["Smart"] = "Intelligent",
	["Absolute and Percent"] = "Absolu et pourcentage",
	["Informational"] = "Informationnel",
	["Hostility Colored"] = "Coloré par hostilité",
	["Class Colored"] = "Coloré par classe",
	["Long"] = "Long",
	["Long w/ Druid form"] = "Long avec la forme de Druide",
	["Fractional"] = "Fractionnel",
	["Fractional Short"] = "Fractionnel court",
	["On Mouse-over"] = "Souris au-dessus",
	[" .. name .. "] = " .. nom .. ",
	["Full"] = "Plein",
	["blankSpace-left"] = "Espace vide-Gauche",
	["blankSpace-center"] = "Espace vide-Centre",
	["blankSpace-right"] = "Espace vide-Droite",
	["blankSpace-outright"] = "Espace vide-Dehors, Droite",
	["blankSpace-outleft"] = "Espace vide-Dehors, Gauche",
	["frame-outtopleft"] = "Fenêtre-Dehors, Gauche",
	["frame-outtop"] = "Fenêtre-Dehors, Haut",
	["frame-outtopright"] = "Fenêtre-Dehors, Haut droite",
	["frame-outbottomleft"] = "Fenêtre-Dehors, Bas gauche",
	["frame-outbottom"] = "Fenêtre-Dehors, Bas",
	["frame-outbottomright"] = "Fenêtre-Dehors, Bas droite",
	["frame-outlefttop"] = "Fenêtre-Dehors, Gauche haut",
	["frame-outleft"] = "Fenêtre-Dehors, Gauche",
	["frame-outleftbottom"] = "Fenêtre-Dehors, Gauche bas",
	["frame-outrighttop"] = "Fenêtre-Dehors, Droite haut",
	["frame-outright"] = "Fenêtre-Dehors, Droite",
	["frame-outrightbottom"] = "Fenêtre-Dehors, Droite bas",
	["frame-center"] = "Fenêtre-Centre",
	["frame-intopleft"] = "Fenêtre-Dedans, Haut gauche",
	["frame-intop"] = "Fenêtre-Dedans, Haut",
	["frame-intopright"] = "Fenêtre-Dedans, Haut droite",
	["frame-inbottomleft"] = "Fenêtre-Dedans, Bas gauche",
	["frame-inbottom"] = "Fenêtre-Dedans, Bas",
	["frame-inbottomright"] = "Fenêtre-Dedans, Bas droite",
	["frame-inleft"] = "Fenêtre-Dedans, Gauche",
	["frame-inright"] = "Fenêtre-Dedans, Droite",
	["frame-edgetopleft"] = "Fenêtre-Bord, Haut gauche",
	["frame-edgetop"] = "Fenêtre-Bord, Haut",
	["frame-edgetopright"] = "Fenêtre-Bord, Haut droite",
	["frame-edgeleft"] = "Fenêtre-Bord, Gauche",
	["frame-edgeright"] = "Fenêtre-Bord, Droite",
	["frame-edgebottomleft"] = "Fenêtre-Bord, Bas gauche",
	["frame-edgebottom"] = "Fenêtre-Bord, Bas",
	["frame-edgebottomright"] = "Fenêtre-Bord, Bas droite",
} or (GetLocale() == "zhTW") and {
	["DogTag help"] = "DogTag求助",
	["Open"] = "開啟",
	["Click to pop up helpful DogTag documentation."] = "點擊開啟DogTag求助說明.",
	["Position"] = "位置",
	["Reverse"] = "反向顯示",
	["Deficit"] = "差額顯示",
	["Drain the bar instead of filling it."] = "先清空此條再以差額填充.",
	["Filled opacity"] = "不透明度填充",
	["The opacity of the filled part of the bar."] = "設定不透明度來填充此條.",
	["Empty opacity"] = "差額顯示-不透明度",
	["The opacity of the empty part of the bar."] = "啟用差額顯示時不透明度來填充此條.",
	["Position of the text."] = "文字位置.",
	["Size"] = "大小",
	["Size of the icon."] = "圖示大小",
	["Font size of the text."] = "文字大小.",
	["Druid mana"] = "德魯伊法力值",
	["Blank space"] = "空白條",
	["Position of the bar relative to other bars."] = "此條相對於其他條的位置.",
	["Height"] = "高",
	["Width"] = "寬",
	["Relative width of the bar."] = "條的相對寬度",
	["Relative height of the bar."] = "條的相對高度",
	["Reverses the direction of the bar, filling it from top to bottom."] = "由上而下, 反向填充此條.",
	["Reverses the direction of the bar, filling it from right to left."] = "由右至左, 反向填充此條.",
	["Side"] = "頭像位置",
	["What side of the unit frame to position the bar at."] = "欲將此條置放於框架的那一方.",
	["Top"] = "上",
	["Bottom"] = "下",
	["Left"] = "左",
	["Right"] = "右",
	["Center"] = "中",
	["Middle"] = "中間",
	["Top-left"] = "左-上",
	["Top-right"] = "右-上",
	["Bottom-left"] = "左-下",
	["Bottom-right"] = "右-下",
	["Outside, Above"] = "外部,上",
	["Outside, Below"] = "外部,下",
	["Outside, Right"] = "外部,右",
	["Outside, Left"] = "外部,左",
	["Outside, Above-left"] = "外部,上-左",
	["Outside, Above-middle"] = "外部,上-中",
	["Outside, Above-right"] = "外部,上-右",
	["Outside, Below-left"] = "外部,下-左",
	["Outside, Below-middle"] = "外部,下-中",
	["Outside, Below-right"] = "外部,下-右",
	["Outside, Left-top"] = "外部,左-上",
	["Outside, Left-middle"] = "外部,左-中",
	["Outside, Left-bottom"] = "外部,左-下",
	["Outside, Right-top"] = "外部,右-上",
	["Outside, Right-middle"] = "外部,右-中",
	["Outside, Right-bottom"] = "外部,右-下",
	["Inside, Left-top"] = "內部,左-上",
	["Inside, Left-bottom"] = "內部,左-下",
	["Inside, Right-top"] = "內部,右-上",
	["Inside, Right-bottom"] = "內部,右-下",
	["Inside, Center"] = "內部,中間",
	["Inside, Top-left"] = "內部,上-左",
	["Inside, Top"] = "內部,上",
	["Inside, Top-right"] = "內部,上-右",
	["Inside, Bottom-left"] = "內部,下-左",
	["Inside, Bottom"] = "內部,下",
	["Inside, Bottom-right"] = "內部,下-右",
	["Inside, Left"] = "內部,左",
	["Inside, Right"] = "內部,右",
	["Edge, Top-left"] = "邊緣,上-左",
	["Edge, Top"] = "邊緣,上",
	["Edge, Top-right"] = "邊緣,上-右",
	["Edge, Left"] = "邊緣,左",
	["Edge, Right"] = "邊緣,右",
	["Edge, Bottom-left"] = "邊緣,下-左",
	["Edge, Bottom"] = "邊緣,下",
	["Edge, Bottom-right"] = "邊緣,下-右",
	["Combo points"] = "連擊點",
	["Options for the combo point display."] = "連擊點顯示選項.",
	["What position of the unit frame to position the combo point display at."] = "單位框架上連擊點顯示的位置.",
	["Class"] = "分類",
	["Health"] = "生命值",
	["Name"] = "名字",
	["Power"] = "能力",
	["Threat"] = "仇恨",
	["Combo points"] = "連擊點",
	["Experience"] = "經驗",
	["Reputation"] = "聲望",
	["Cast"] = "施法",
	["CastTime"] = "施法時間",
	["None"] = "無",
	["Frame"] = "框架",
	["Hidden"] = "隱藏",
	["Hide"] = "隱藏",
	["Custom"] = "自定",
	["Choose your own custom text."] = "選擇你自己的自定文.",
	["Style"] = "風格",
	["Use a preconfigured style."] = "使用一個重新配置的風格.",
	["Style - Custom"] = "風格 - 自定",
	["Create a custom style for this unit type."] = "為此類物件自定一種風格.",
	["LibDogTag-2.0 tags. See http://www.wowace.com/wiki/LibDogTag-2.0"] ="LibDogTag-2.0 標籤. 詳閱 http://www.wowace.com/wiki/LibDogTag-2.0",
	["Style - Type"] = "風格 - 類型",
	["Choose the type of pre-made styles to work with."] = "選擇已做好的風格類型.",
	["Enable"] = "啟用",
	["Click to disable this text from being shown."] = "點選停用顯示這個文字?",
	["Customize the %s text."] = "自定%s文字.",
	["Combat"] = "戰鬥",
	["Other"] = "其他",
	["Create other texts."] = "建立其他文字.",
	["Disabled texts"] = "停用文字",
	["Show some of the disabled texts."] = "顯示一些停用的文字.",
	["New text"] = "新文字",
	["Create a new text."] = "建立新文字.",
	["<Name>"] = "<名稱>",
	["Change settings for the blank space."] = "為這空白區更改設置.",
	["Enable the blank space."] = "啟用空白區.",
	["combatText"] = "戰鬥文字",
	["**"] = "**",
	["Standard"] = "標準",
	["Standard Name"] = "標準名稱",
	["Standard Time"] = "標準時間",
	["Player Classes Only"] = "只有玩家職業",
	["Short"] = "短",
	["Absolute"] = "當前/總值",
	["Absolute Short"] = "當前/總值 短類型",
	["Difference"] = "差額",
	["Percent"] = "百分比",
	["Mini"] = "迷你",
	["Smart"] = "靈巧",
	["Absolute and Percent"] = "當前/總值 和 百分比",
	["Informational"] = "情報",
	["Hostility Colored"] = "友好別上色",
	["Class Colored"] = "職業別上色",
	["Long"] = "長",
	["Long w/ Druid form"] = "長 w/ 德魯伊型態",
	["Fractional"] = "少量的",
	["Fractional Short"] = "極少量的",
	["On Mouse-over"] = "滑鼠經過時",
	[" .. name .. "] = "..名稱.. ",
	["Full"] = "填滿",
	["blankSpace-left"] = "空白區-左",
	["blankSpace-center"] = "空白區-中",
	["blankSpace-right"] = "空白區-右",
	["blankSpace-outright"] = "空白區-外右",
	["blankSpace-outleft"] = "空白區-外左",
	["frame-outtopleft"] = "框架-外上左",
	["frame-outtop"] = "框架-外上",
	["frame-outtopright"] = "框架-外上右",
	["frame-outbottomleft"] = "框架-外下左",
	["frame-outbottom"] = "框架-外下",
	["frame-outbottomright"] = "框架-外下右",
	["frame-outlefttop"] = "框架-外左上",
	["frame-outleft"] = "框架-外左",
	["frame-outleftbottom"] = "框架-外左下",
	["frame-outrighttop"] = "框架-外右上",
	["frame-outright"] = "框架-外右",
	["frame-outrightbottom"] = "框架-外右下",
	["frame-center"] = "框架-中",
	["frame-intopleft"] = "框架-內上左",
	["frame-intop"] = "框架-內上",
	["frame-intopright"] = "框架-內上右",
	["frame-inbottomleft"] = "框架-內下左",
	["frame-inbottom"] = "框架-內下",
	["frame-inbottomright"] = "框架-內下右",
	["frame-inleft"] = "框架-內左",
	["frame-inright"] = "框架-內右",
	["frame-edgetopleft"] = "框架-邊緣上左",
	["frame-edgetop"] = "框架-邊緣上",
	["frame-edgetopright"] = "框架-邊緣上右",
	["frame-edgeleft"] = "框架-邊緣左",
	["frame-edgeright"] = "框架-邊緣右",
	["frame-edgebottomleft"] = "框架-邊緣下左",
	["frame-edgebottom"] = "框架-邊緣下",
	["frame-edgebottomright"] = "框架-邊緣下右",
	["Combo"] = "連擊點",
	["DruidMana"] = "德魯伊法力值",
	["Name required"] = "名稱是必需的",
	["Name already in use"] = "名稱已被使用",
} or {}

local L = PitBull:L("PitBull-MetaLayout", localization)

local PitBull_Aura = nil

local DogTag = Rock("LibDogTag-3.0")
Rock("LibDogTag-Unit-3.0")

local newFrame = PitBull.newFrame
local newList, del, unpackListAndDel, unpackDictAndDel = Rock:GetRecyclingFunctions("PitBull", "newList", "del", "unpackListAndDel", "unpackDictAndDel")
local deepCopy, deepDel = PitBull.deepCopy, PitBull.deepDel

local MetaLayout = {
	extraFrames = {},
	options = {
		name = {},
		desc = {},
	},
	positions = {},
}
PitBull.MetaLayout = MetaLayout

local MetaLayout_db = PitBull:GetDatabaseNamespace("MetaLayout")
MetaLayout.db = MetaLayout_db
PitBull:SetDatabaseNamespaceDefaults("MetaLayout", "profile", {
	["**"] = {
		texts = {
			['**'] = {
				custom = "",
				style = "Custom",
				styleType = "none",
				position = "frame-center",
				size = 1,
				hidden = true,
			},
			Class = {
				custom = "[Classification] [Level:DifficultyColor] [SmartClass:ClassColor] [DruidForm:Paren] [SmartRace]",
				style = "Standard",
				styleType = "class",
				position = "powerBar-left",
				hidden = false,
			},
			Health = {
				custom = "[HP]/[MaxHP]",
				style = "Smart",
				styleType = "health",
				position = "healthBar-right",
				hidden = false,
			},
			Name = {
				custom = "[Name]",
				style = "Standard",
				styleType = "name",
				position = "healthBar-left",
				hidden = false,
			},
			Power = {
				custom = "[MP]/[MaxMP]",
				style = "Absolute",
				styleType = "power",
				position = "powerBar-right",
				hidden = false,
			},
			DruidMana = {
				custom = "[~IsMana ? FractionalDruidMP]",
				style = "Absolute",
				styleType = "druidMana",
				position = "druidManaBar-right",
				hidden = false,
			},
			Combo = {
				style = "Standard",
				styleType = "combo",
				position = "frame-outright",
				hidden = false,
			},
			Experience = {
				style = "Standard",
				styleType = "experience",
				position = "expBar-center",
				hidden = false,
			},
			Reputation = {
				style = "Standard",
				styleType = "reputation",
				position = "repBar-center",
				hidden = false,
			},
			Threat = {
				custom = "[Threat]/[MaxThreat]",
				style = "Absolute Short",
				styleType = "threat",
				position = "threatBar-right",
				hidden = false,
			},
			Cast = {
				custom = "[CastName] [CastTarget:Paren]",
				style = "Standard Name",
				styleType = "cast",
				position = "castBar-left",
				hidden = false,
			},
			CastTime = {
				custom = "[CastDelay:Round] [CastEndDuration:Round >= 0]",
				style = "Standard Time",
				styleType = "cast",
				position = "castBar-right",
				hidden = false,
			},
			combatText = {
				position = "frame-center",
				hidden = false,
			}
		},
		
		icons = {
			['**'] = {
				position = "frame-edgebottomleft",
				size = 1,
			},
			combatIcon = {
				position = "frame-edgebottomleft",
			},
			voiceIcon = {
				position = "frame-edgetopright",
			},
			restIcon = {
				position = "frame-edgebottomleft",
			},
			pvpIcon = {
				position = "frame-edgetopright",
			},
			leaderIcon = {
				position = "frame-edgetopleft",
			},
			masterIcon = {
				position = "frame-edgetopleft",
			},
			raidTargetIcon = {
				position = "frame-edgetop",
			},
			readyCheckIcon = {
				position = "frame-edgebottomright",
			},
			totemTimersFrame = { -- hack warning: disguises as icon for automatic placement options, see PB-333
				position = "frame-outtopleft",
			},
		},
		
		bars = {
			['**'] = {
				height = 2,
				reverse = false,
				deficit = false,
				alpha = 1,
				bgAlpha = 1,
				position = 1,
				side = "center",
			},
			portrait = {
				position = 1,
				side = "left",
			},
			healthBar = {
				height = 5,
				position = 2,
			},
			powerBar = {
				height = 4,
				position = 3,
			},
			druidManaBar = {
				height = 1,
				position = 4,
			},
			expBar = {
				position = 5,
			},
			repBar = {
				position = 6,
			},
			threatBar = {
				position = 7,
			},
			blankSpace = {
				position = 8,
				hidden = true,
			},
			castBar = {
				position = 9,
			},
			fullBar = {
				height = 5,
				position = 10,
			},
		},
	},
	player = {
		texts = {
			Health = {
				style = "Informational",
			}
		}
	},
	pet = {
		texts = {
			Health = {
				style = "Informational",
			}
		}
	},
	target = {
		comboSide = "inbottomright",
		
		texts = {
			Health = {
				style = "Informational",
			}
		},
		bars = {
			portrait = {
				side = "right",
			}
		}
	}
})

local iconPriorities = { }

local function iconPriority_sort(alpha, bravo)
	return iconPriorities[alpha] < iconPriorities[bravo]
end

function MetaLayout.extraFrames.blankSpace(unit, frame)
	if MetaLayout_db.profile[frame.group].bars.blankSpace.hidden then
		return
	end
	frame.blankSpace = newFrame("Frame", frame)
end

local barList = {
	blankSpace = true,
}

local function figureHeight(multiplier, frame)
	local num = 0
	local db = MetaLayout_db.profile[frame.group].bars
	for k in pairs(barList) do
		if frame[k] and frame[k]:IsShown() and db[k].side == "center" then
			num = num + db[k].height
		end
	end
	return db[multiplier].height * frame:GetHeight() / num
end

local squareOnSide_bars = {}

local function figureWidth(multiplier, frame)
	local num = 0
	local db = MetaLayout_db.profile[frame.group].bars
	local hasCenter = false
	local numSquare = 0
	for k in pairs(barList) do
		if frame[k] and frame[k]:IsShown() then
		 	if db[k].side ~= "center" then
				if squareOnSide_bars[k] then
					-- square
					numSquare = numSquare + 1
				else
					num = num + db[k].height
				end
			else
				hasCenter = true
			end
		end
	end
	if hasCenter then
		num = num + 10
	end
	local totalHeight = frame:GetHeight()
	local totalWidth = frame:GetWidth()
	totalWidth = totalWidth - numSquare*totalHeight
	return db[multiplier].height * totalWidth / num
end

local function findClosestBar(db, frame, side)
	local bestAttach, bestAttach_num
	local db_bars = db.bars
	for k,v in pairs(db_bars) do
		local v_position = v.position
		if (not bestAttach_num or v_position > bestAttach_num) and frame[k] and db_bars[k].side == side then
			bestAttach = k
			bestAttach_num = v_position
		end
	end
	return bestAttach
end

local function barPosition_func(unit, frame, id)
	local squareOnSide = squareOnSide_bars[id]
	local db = MetaLayout_db.profile[frame.group]
	local db_bars = db.bars
	local tmp = newList()
	for k,v in pairs(db_bars) do
		local v_position = v.position
		if not v_position or tmp[v_position] then
			v_position = 1
			while tmp[v_position] do
				v_position = v_position + 1
			end
			v.position = v_position
		end
		tmp[v_position] = true
	end
	tmp = del(tmp)
	local db_bars_id = db_bars[id]
	local frameSide = db_bars_id.side
	local current_barPosition = db_bars_id.position
	local bestAttach
	local bestAttach_num
	for k,v in pairs(db_bars) do
		local v_position = v.position
		if v_position < current_barPosition and frame[k] and db_bars[k].side == frameSide then
			if not bestAttach_num or bestAttach_num < v_position then
				bestAttach = k
				bestAttach_num = v_position
			end
		end
	end
	local frame_id = frame[id]
	if frameSide == "center" then
		local height = figureHeight(id, frame)
		if bestAttach then
			frame_id:SetPoint("TOP", frame[bestAttach], "BOTTOM", 0, -1)
			frame_id:SetHeight(height - 1)
		else
			frame_id:SetPoint("TOP", frame, "TOP")
			frame_id:SetHeight(height) -- no pixel spacing, there is always 1 spacing less than bars.
		end
		if frame_id.SetOrientation then
			frame_id:SetOrientation("HORIZONTAL")
		end
		
		local left_attach = findClosestBar(db, frame, "left")
		if left_attach then
			frame_id:SetPoint("LEFT", frame[left_attach], "RIGHT", 2, 0)
		else
			frame_id:SetPoint("LEFT", frame, "LEFT")
		end
		
		local right_attach = findClosestBar(db, frame, "right")
		if right_attach then
			frame_id:SetPoint("RIGHT", frame[right_attach], "LEFT", -2, 0)
		else
			frame_id:SetPoint("RIGHT", frame, "RIGHT")
		end
	else
		local width
		if squareOnSide then
			width = frame:GetHeight()
		else
			width = figureWidth(id, frame)
		end
		if bestAttach then
			if frameSide == "left" then
				frame_id:SetPoint("LEFT", frame[bestAttach], "RIGHT", 1, 0)
			else
				frame_id:SetPoint("RIGHT", frame[bestAttach], "LEFT", -1, 0)
			end
			frame_id:SetWidth(width - 1)
		else
			if frameSide == "left" then
				frame_id:SetPoint("LEFT", frame, "LEFT", 0, 0)
			else
				frame_id:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
			end
			frame_id:SetWidth(width) -- no pixel spacing, there is always 1 spacing less than bars.
		end
		if frame_id.SetOrientation then
			frame_id:SetOrientation("VERTICAL")
		end
		
		frame_id:SetPoint("TOP", frame, "TOP")
		frame_id:SetPoint("BOTTOM", frame, "BOTTOM")
	end
	if frame_id.SetReverse then
		frame_id:SetReverse(db_bars_id.reverse)
	end
	if frame_id.SetDeficit then
		frame_id:SetDeficit(db_bars_id.deficit)
	end
	if frame_id.SetNormalAlpha then
		frame_id:SetNormalAlpha(db_bars_id.alpha)
	end
	if frame_id.SetBackgroundAlpha then
		frame_id:SetBackgroundAlpha(db_bars_id.bgAlpha)
	end
end

MetaLayout.positions.blankSpace = barPosition_func

if playerClass == "ROGUE" or playerClass == "DRUID" then
	function MetaLayout.positions.comboPoints(unit, frame)
		if frame.group ~= "target" then return end 
		local side = MetaLayout_db.profile[frame.group].comboSide
		
		local side_in = side:match("^(in)")
		local side_rest = side_in and side:sub(3) or side:sub(4)
		local side_main = side_rest:match("^(left)") or side_rest:match("^(right)") or side_rest:match("^(top)") or side_rest:match("^(bottom)")
		if not side_main then -- messed up
			return
		end
		local side_alt = side_rest:sub(side_main:len() + 1)
		
		if side_rest == "right" then
			frame.comboPoints:SetPoint(side_in and "RIGHT" or "LEFT", frame, "RIGHT")
		elseif side_rest == "left" then
			frame.comboPoints:SetPoint(side_in and "LEFT" or "RIGHT", frame, "LEFT")
		elseif side_rest == "top" then
			frame.comboPoints:SetPoint(side_in and "TOP" or "BOTTOM", frame, "TOP")
		elseif side_rest == "bottom" then
			frame.comboPoints:SetPoint(side_in and "BOTTOM" or "TOP", frame, "BOTTOM")
		elseif side_rest == "topright" or side_rest == "righttop" then
			frame.comboPoints:SetPoint(side_in and "TOPRIGHT" or side_rest == "topright" and "BOTTOMRIGHT" or "TOPLEFT", frame, "TOPRIGHT")
		elseif side_rest == "topleft" or side_rest == "lefttop" then
			frame.comboPoints:SetPoint(side_in and "TOPLEFT" or side_rest == "topleft" and "BOTTOMLEFT" or "TOPRIGHT", frame, "TOPLEFT")
		elseif side_rest == "bottomright" or side_rest == "rightbottom" then
			frame.comboPoints:SetPoint(side_in and "BOTTOMRIGHT" or side_rest == "bottomright" and "TOPRIGHT" or "BOTTOMLEFT", frame, "BOTTOMRIGHT")
		elseif side_rest == "bottomleft" or side_rest == "leftbottom" then
			frame.comboPoints:SetPoint(side_in and "BOTTOMLEFT" or side_rest == "bottomleft" and "TOPLEFT" or "BOTTOMRIGHT", frame, "BOTTOMLEFT")
		end
		
		local leftOrRight = side_main == "left" or side_main == "right"
		
		frame.comboPoints:SetWidth(leftOrRight and 10 or 50)
		frame.comboPoints:SetHeight(leftOrRight and 50 or 10)
		
		for i = 1, 5 do
			local combo = frame.comboPoints["combo"..i]
			combo:ClearAllPoints()
			if leftOrRight then
				if side_alt == "top" then
					if i == 1 then
						combo:SetPoint("TOP", frame.comboPoints, "TOP")
					else
						combo:SetPoint("TOP", frame.comboPoints["combo"..(i-1)], "BOTTOM", 0, -2)
					end
				else
					if i == 1 then
						combo:SetPoint("BOTTOM", frame.comboPoints, "BOTTOM")
					else
						combo:SetPoint("BOTTOM", frame.comboPoints["combo"..(i-1)], "TOP", 0, 2)
					end
				end
			else -- top or bottom
				if side_alt == "right" then
					if i == 1 then
						combo:SetPoint("RIGHT", frame.comboPoints, "RIGHT")
					else
						combo:SetPoint("RIGHT", frame.comboPoints["combo"..(i-1)], "LEFT", -2, 0)
					end
				else
					if i == 1 then
						combo:SetPoint("LEFT", frame.comboPoints, "LEFT")
					else
						combo:SetPoint("LEFT", frame.comboPoints["combo"..(i-1)], "RIGHT", 2, 0)
					end
				end
			end
		end
	end
end


local function findTextAtPosition(group, position, frame)
	for k, v in pairs(MetaLayout_db.profile[group].texts) do
		if v.position == position then
			local id = "layoutText" .. k
			if not frame or frame[id] then
				return id
			end
			if frame[k] then
				return k
			end
			return nil
		end
	end
end

local function findIconsAtPosition(group, position, frame)
	local t = newList()
	for k, v in pairs(MetaLayout_db.profile[group].icons) do
		if v.position == position and frame[k] then
			t[#t+1] = k
		end
	end
	table.sort(t, iconPriority_sort)
	return t
end

local function findIconAtPositionBeforeIcon(group, position, frame, icon)
	local t = findIconsAtPosition(group, position, frame)
	for i,v in ipairs(t) do
		if v == icon then
			local preicon = t[i-1]
			t = del(t)
			return preicon
		end
	end
	t = del(t)
	return nil
end

local function findLastIconAtPosition(group, position, frame)
	local t = findIconsAtPosition(group, position, frame)
	local icon = t[#t]
	t = del(t)
	return icon
end

local function findFirstIconAtPosition(group, position, frame)
	local t = findIconsAtPosition(group, position, frame)
	local icon = t[1]
	t = del(t)
	return nil
end

local function findTextOrIconAtPosition(group, position, frame, direction)
	local attach, point = ("-"):split(position)
	local approach
	if attach == "frame" then
		if point == "outtopleft" or point == "outtop" or point == "outbottomleft" or point == "outbottom" or point == "outrighttop" or point == "outright" or point == "outrightbottom" or point == "center" or point == "intopleft" or point == "intop" or point == "inbottomleft" or point == "inbottom" or point == "inleft" or point == "edgetopleft" or point == "edgetop" or point == "edgeleft" or point == "edgebottomleft" or point == "edgebottom" then
			approach = direction == "left" and "left-first" or "right-last"
		else
			approach = direction == "left" and "left-last" or "right-first"
		end
	else
		if point == "left" or point == "center" or point == "outright" then
			approach = direction == "left" and "left-first" or "right-last"
		else
			approach = direction == "left" and "left-last" or "right-first"
		end
	end
	if approach == "left-first" then
		return findFirstIconAtPosition(group, position, frame) or findTextAtPosition(group, position, frame)
	elseif approach == "left-last" then
		return findLastIconAtPosition(group, position, frame) or findTextAtPosition(group, position, frame)
	elseif approach == "right-first" then
		return findTextAtPosition(group, position, frame) or findFirstIconAtPosition(group, position, frame)
	else--if approach == "right-last" then
		return findTextAtPosition(group, position, frame) or findLastIconAtPosition(group, position, frame)
	end
end

local textPosition_id_to_name = {}
local function textPosition_func(unit, frame, id)
	local name = textPosition_id_to_name[id]
	local group = frame.group
	local position = MetaLayout_db.profile[group].texts[name].position or "hide"
	local attach, point = ("-"):split(position)
	if attach == "hide" then
		return
	end
	local frame_id = frame[id]
	if attach and point then
		if attach == "frame" then
			if point == "outtopleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMLEFT", frame[icon], "BOTTOMRIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 2, 5)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("BOTTOM")
				local center = findTextOrIconAtPosition(group, "frame-outtop", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, "frame-outtopright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "outtopright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMRIGHT", frame[icon], "BOTTOMLEFT", -3, 0)
				else
					frame_id:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -2, 5)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("BOTTOM")
				local center = findTextOrIconAtPosition(group, "frame-outtop", frame, "right")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "outtop" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMLEFT", frame[icon], "BOTTOMRIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOM", frame, "TOP", 0, 5)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("BOTTOM")
			elseif point == "outbottomleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPLEFT", frame[icon], "TOPRIGHT", 3, 0)
				else
					frame_id:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, -5)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("TOP")
				local center = findTextOrIconAtPosition(group, "frame-outbottom", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, "frame-outbottomright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "outbottomright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPRIGHT", frame[icon], "TOPLEFT", -3, 0)
				else
					frame_id:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -2, -5)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("TOP")
				local center = findTextOrIconAtPosition(group, "frame-outbottom", frame, "right")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "outbottom" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPLEFT", frame[icon], "TOPRIGHT", 3, 0)
				else
					frame_id:SetPoint("TOP", frame, "BOTTOM", 0, -5)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("TOP")
			elseif point == "outlefttop" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPRIGHT", frame[icon], "TOPLEFT", -3, 0)
				else
					frame_id:SetPoint("TOPRIGHT", frame, "TOPLEFT", -5, -2)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("TOP")
			elseif point == "outleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame, "LEFT", -5, 0)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "outleftbottom" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMRIGHT", frame[icon], "BOTTOMLEFT", -3, 0)
				else
					frame_id:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -5, -2)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("BOTTOM")
			elseif point == "outrighttop" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPLEFT", frame[icon], "TOPRIGHT", 3, 0)
				else
					frame_id:SetPoint("TOPLEFT", frame, "TOPRIGHT", 5, -2)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("TOP")
			elseif point == "outright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame, "RIGHT", 5, 0)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "outrightbottom" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMLEFT", frame[icon], "BOTTOMRIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 5, 2)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("BOTTOM")
			elseif point == "intopleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPLEFT", frame[icon], "TOPRIGHT", 3, 0)
				else
					frame_id:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -5)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("TOP")
				local center = findTextOrIconAtPosition(group, "frame-intop", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, "frame-intopright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "intopright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPRIGHT", frame[icon], "TOPLEFT", -3, 0)
				else
					frame_id:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -5)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("TOP")
				local center = findTextOrIconAtPosition(group, "frame-intop", frame, "right")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "intop" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("TOPLEFT", frame[icon], "TOPRIGHT", 3, 0)
				else
					frame_id:SetPoint("TOP", frame, "TOP", 2, -5)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("TOP")
			elseif point == "inbottomleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMLEFT", frame[icon], "BOTTOMRIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 5)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("BOTTOM")
				local center = findTextOrIconAtPosition(group, "frame-inbottom", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, "frame-inbottomright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "inbottomright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMRIGHT", frame[icon], "BOTTOMLEFT", -3, 0)
				else
					frame_id:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 5)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("BOTTOM")
				local center = findTextOrIconAtPosition(group, "frame-inbottom", frame, "right")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "inbottom" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("BOTTOMLEFT", frame[icon], "BOTTOMRIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOM", frame, "BOTTOM", 2, 5)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("BOTTOM")
			elseif point == "inleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame, "LEFT", 5, 0)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("MIDDLE")
				local center = findTextOrIconAtPosition(group, "frame-center", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, "frame-inright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "inright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("MIDDLE")
				local center = findTextOrIconAtPosition(group, "frame-center", frame, "right")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "center" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("CENTER", frame, "CENTER", 0, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgetopleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame, "TOPLEFT", -5, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgetopright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame, "TOPRIGHT", 5, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgetop" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("CENTER", frame, "TOP", 0, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgebottomleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame, "BOTTOMLEFT", -5, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgebottomright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame, "BOTTOMRIGHT", 5, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgebottom" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("CENTER", frame, "BOTTOM", 0, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgeleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame, "LEFT", -5, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "edgeright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame, "RIGHT", 5, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			end
		elseif frame[attach] then
			if point == "left" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame[attach], "LEFT", 3, 0)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("MIDDLE")
				local center = findTextOrIconAtPosition(group, attach .. "-center", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, attach .. "-right", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "center" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("CENTER", frame[attach], "CENTER", 0, 0)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "right" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame[attach], "RIGHT", -3, 0)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("MIDDLE")
				local center = findTextOrIconAtPosition(group, attach .. "-center", frame, "left")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "topleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("TOPLEFT", frame[attach], "TOPLEFT", 3, -3)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("TOP")
				local center = findTextOrIconAtPosition(group, attach .. "-top", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, attach .. "-topright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "topright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("TOPRIGHT", frame[attach], "TOPRIGHT", -3, -3)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("TOP")
				local center = findTextOrIconAtPosition(group, attach .. "-top", frame, "left")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "top" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("TOP", frame[attach], "TOP", 0, -3)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("TOP")
			elseif point == "bottomleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOMLEFT", frame[attach], "BOTTOMLEFT", 3, 3)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("BOTTOM")
				local center = findTextOrIconAtPosition(group, attach .. "-bottom", frame, "left")
				if center then
					frame_id:SetPoint("RIGHT", frame[center], "LEFT", -3, 0)
				else
					local right = findTextOrIconAtPosition(group, attach .. "-bottomright", frame, "left")
					if right then
						frame_id:SetPoint("RIGHT", frame[right], "LEFT", -3, 0)
					end
				end
			elseif point == "bottomright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("BOTTOMRIGHT", frame[attach], "BOTTOMRIGHT", 3, 3)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("BOTTOM")
				local center = findTextOrIconAtPosition(group, attach .. "-top", frame, "left")
				if center then
					frame_id:SetPoint("LEFT", frame[center], "RIGHT", 3, 0)
				end
			elseif point == "bottom" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("BOTTOM", frame[attach], "BOTTOM", 0, 3)
				end
				frame_id:SetJustifyH("CENTER")
				frame_id:SetJustifyV("BOTTOM")
			elseif point == "outright" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
				else
					frame_id:SetPoint("LEFT", frame[attach], "RIGHT", 3, 0)
				end
				frame_id:SetJustifyH("LEFT")
				frame_id:SetJustifyV("MIDDLE")
			elseif point == "outleft" then
				local icon = findLastIconAtPosition(group, position, frame)
				if icon then
					frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
				else
					frame_id:SetPoint("RIGHT", frame[attach], "LEFT", -3, 0)
				end
				frame_id:SetJustifyH("RIGHT")
				frame_id:SetJustifyV("MIDDLE")
			end
		end
	end
end
local function textPosition(id, name)
	textPosition_id_to_name[id] = name
	return textPosition_func
end

local function getHalfWidth(group, position, frame)
	local num = 0
	if findTextAtPosition(group, position, frame) then
		num = num + 20 -- assumes a width of 40
	end
	local icons = findIconsAtPosition(group, position, frame)
	local iconDB = MetaLayout_db.profile[group].icons
	for _,v in ipairs(icons) do
		num = num + 7.5 * iconDB[v].size
	end
	icons = del(icons)
	return -num
end

local function iconPosition_func(unit, frame, id)
	local group = frame.group
	local data = MetaLayout_db.profile[group].icons[id]
	local position = data.position
	if position == "hide" then
		frame[id]:SetPoint("LEFT", UIParent, "RIGHT", 10000, 0)
		return
	end
	local size = data.size * 15
	local frame_id = frame[id]
	frame_id:SetWidth(size)
	frame_id:SetHeight(size)
	local attach, point = ("-"):split(position)
	if attach and point then
		local icon = findIconAtPositionBeforeIcon(group, position, frame, id)
		if icon then
			local left = false
			if attach == "frame" then
				if point == "outtopleft" or point == "outtop" or point == "outbottomleft" or point == "outbottom" or point == "outrighttop" or point == "outright" or point == "outrightbottom" or point == "center" or point == "intopleft" or point == "intop" or point == "inbottomleft" or point == "inbottom" or point == "inleft" or point == "edgetopleft" or point == "edgetop" or point == "edgeleft" or point == "edgebottomleft" or point == "edgebottom" then
					left = true
				end
			else
				if point == "left" or point == "center" or point == "outright" or point == "topleft" or point == "top" or point == "bottomleft" or point == "bottom" then
					left = true
				end
			end
			if left then
				frame_id:SetPoint("LEFT", frame[icon], "RIGHT", 3, 0)
			else
				frame_id:SetPoint("RIGHT", frame[icon], "LEFT", -3, 0)
			end
		else
			if attach == "frame" then
				if point == "outtopleft" then
					frame_id:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 2, 5)
				elseif point == "outtopright" then
					frame_id:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -2, 5)
				elseif point == "outtop" then
					frame_id:SetPoint("BOTTOMLEFT", frame, "TOP", getHalfWidth(group, position, frame), 5)
				elseif point == "outbottomleft" then
					frame_id:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, -5)
				elseif point == "outbottomright" then
					frame_id:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -2, -5)
				elseif point == "outbottom" then
					frame_id:SetPoint("TOPLEFT", frame, "BOTTOM", getHalfWidth(group, position, frame), -5)
				elseif point == "outlefttop" then
					frame_id:SetPoint("TOPRIGHT", frame, "TOPLEFT", -5, -2)
				elseif point == "outleft" then
					frame_id:SetPoint("RIGHT", frame, "LEFT", -5, 0)
				elseif point == "outleftbottom" then
					frame_id:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -5, 2)
				elseif point == "outrighttop" then
					frame_id:SetPoint("TOPLEFT", frame, "TOPRIGHT", 5, -2)
				elseif point == "outright" then
					frame_id:SetPoint("LEFT", frame, "RIGHT", 5, 0)
				elseif point == "outrightbottom" then
					frame_id:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 5, 2)
				elseif point == "center" then
					frame_id:SetPoint("LEFT", frame, "CENTER", getHalfWidth(group, position, frame), 0)
				elseif point == "intopleft" then
					frame_id:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -5)
				elseif point == "intop" then
					frame_id:SetPoint("TOPLEFT", frame, "TOP", getHalfWidth(group, position, frame), -5)
				elseif point == "intopright" then
					frame_id:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -5)
				elseif point == "inbottomleft" then
					frame_id:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 5)
				elseif point == "inbottom" then
					frame_id:SetPoint("BOTTOMLEFT", frame, "BOTTOM", getHalfWidth(group, position, frame), 5)
				elseif point == "inbottomright" then
					frame_id:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 5)
				elseif point == "inleft" then
					frame_id:SetPoint("LEFT", frame, "LEFT", 2, 0)
				elseif point == "inright" then
					frame_id:SetPoint("RIGHT", frame, "RIGHT", -2, 0)
				elseif point == "edgetopleft" then
					frame_id:SetPoint("CENTER", frame, "TOPLEFT", 0, 0)
				elseif point == "edgetop" then
					frame_id:SetPoint("LEFT", frame, "TOP", getHalfWidth(group, position, frame), 0)
				elseif point == "edgetopright" then
					frame_id:SetPoint("CENTER", frame, "TOPRIGHT", 0, 0)
				elseif point == "edgeleft" then
					frame_id:SetPoint("CENTER", frame, "LEFT", 0, 0)
				elseif point == "edgeright" then
					frame_id:SetPoint("CENTER", frame, "RIGHT", 0, 0)
				elseif point == "edgebottomleft" then
					frame_id:SetPoint("CENTER", frame, "BOTTOMLEFT", 0, 0)
				elseif point == "edgebottom" then
					frame_id:SetPoint("LEFT", frame, "BOTTOM", getHalfWidth(group, position, frame), 0)
				elseif point == "edgebottomright" then
					frame_id:SetPoint("CENTER", frame, "BOTTOMRIGHT", 0, 0)
				end
			elseif frame[attach] then
				if point == "left" then
					frame_id:SetPoint("LEFT", frame[attach], "LEFT", 3, 0)
				elseif point == "center" then
					frame_id:SetPoint("LEFT", frame[attach], "CENTER", getHalfWidth(group, position, frame), 0)
				elseif point == "right" then
					frame_id:SetPoint("RIGHT", frame[attach], "RIGHT", -3, 0)
				elseif point == "top" then
					frame_id:SetPoint("TOPLEFT", frame[attach], "TOP", getHalfWidth(group, position, frame), -3)
				elseif point == "bottom" then
					frame_id:SetPoint("BOTTOMLEFT", frame[attach], "BOTTOM", getHalfWidth(group, position, frame), 3)
				elseif point == "topleft" then
					frame_id:SetPoint("TOPLEFT", frame[attach], "TOPLEFT", 3, -3)
				elseif point == "topright" then
					frame_id:SetPoint("TOPRIGHT", frame[attach], "TOPRIGHT", -3, -3)
				elseif point == "bottomleft" then
					frame_id:SetPoint("BOTTOMLEFT", frame[attach], "BOTTOMLEFT", 3, 3)
				elseif point == "bottomright" then
					frame_id:SetPoint("BOTTOMRIGHT", frame[attach], "BOTTOMRIGHT", -3, 3)
				elseif point == "outright" then
					frame_id:SetPoint("LEFT", frame[attach], "RIGHT", 3, 0)
				elseif point == "outleft" then
					frame_id:SetPoint("RIGHT", frame[attach], "LEFT", -3, 0)
				end
			end
		end
	end
end

local function iconSize_get(group, name)
	return MetaLayout_db.profile[group].icons[name].size
end
local function iconSize_set(group, name, value)
	MetaLayout_db.profile[group].icons[name].size = value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

local positionArgs
local function iconOptions_func(group, name)
	return {
		type = 'group',
		groupType = 'inline',
		name = L["Position"],
		desc = L["Position of the text."],
		args = positionArgs,
		child_passValue = group,
		child_passValue2 = name,
		child_passValue3 = true,
		child_child_passValue = group,
		child_child_passValue2 = name,
		child_child_passValue3 = true,
	}, {
		type = 'number',
		name = L["Size"],
		desc = L["Size of the icon."],
		get = iconSize_get,
		set = iconSize_set,
		passValue = group,
		passValue2 = name,
		min = 0.5,
		max = 4,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
	}
end

local barNameToLocal = {
	blankSpace = L["Blank space"],
}

local mySort__t
local function mySort(alpha, bravo)
	if not alpha or not bravo then
		return false
	end
	return mySort__t[alpha] < mySort__t[bravo]
end
local function position_choices(group, id)
	local t = newList()
	local t_keys = newList()
	local id_side = MetaLayout_db.profile[group].bars[id].side
	for k, v in pairs(MetaLayout_db.profile[group].bars) do
		if v.side == id_side then
			local good = false
			for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
				if frame[k] then
					good = true
					break
				end
			end
			if good then
				local barNameToLocal_k = barNameToLocal[k]
				t[barNameToLocal_k] = v.position
				t_keys[#t_keys+1] = barNameToLocal_k
			end
		end
	end
	mySort__t = t
	table.sort(t_keys, mySort)
	mySort__t = nil
	t = del(t)
	
	return '@list', unpackListAndDel(t_keys)
end

local function position_get(group, id)
	return barNameToLocal[id]
end
local function position_set(group, id, value)
	local barName
	for k,v in pairs(barNameToLocal) do
		if value == v then
			barName = k
			break
		end
	end
	assert(barName)
	local barDB = MetaLayout_db.profile[group].bars
	local new_position = barDB[barName].position
	local old_position = barDB[id].position
	local step = 1
	if new_position < old_position then
		step = -1
	end
	for k, v in pairs(barDB) do
		local v_position = v.position
		if (new_position <= v_position and v_position < old_position) or (old_position < v_position and v_position <= new_position) then
			barDB[k].position = v_position - step
		end
	end
	barDB[id].position = new_position
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local function side_get(group, id)
	return MetaLayout_db.profile[group].bars[id].side
end
local function side_set(group, id, value)
	MetaLayout_db.profile[group].bars[id].side = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local side_choices = {
	left = L["Left"],
	right = L["Right"],
	center = L["Center"],
}
local function side_isLeftOrRight(group, id)
	local side = MetaLayout_db.profile[group].bars[id].side
	return side == "left" or side == "right"
end
local function height_get(group, id)
	return MetaLayout_db.profile[group].bars[id].height
end
local function height_set(group, id, value)
	MetaLayout_db.profile[group].bars[id].height = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local function height_name(group, id)
	if MetaLayout_db.profile[group].bars[id].side ~= "center" then
		return L["Width"]
	else
		return L["Height"]
	end
end
local function height_desc(group, id)
	if MetaLayout_db.profile[group].bars[id].side ~= "center" then
		return L["Relative width of the bar."]
	else
		return L["Relative height of the bar."]
	end
end
local function reverse_set(group, id, value)
	MetaLayout_db.profile[group].bars[id].reverse = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local function reverse_get(group, id, value)
	return MetaLayout_db.profile[group].bars[id].reverse
end
local function reverse_desc(group, id)
	if MetaLayout_db.profile[group].bars[id].side ~= "center" then
		return L["Reverses the direction of the bar, filling it from top to bottom."]
	else
		return L["Reverses the direction of the bar, filling it from right to left."]
	end
end
local function alpha_set(group, id, value)
	MetaLayout_db.profile[group].bars[id].alpha = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local function alpha_get(group, id, value)
	return MetaLayout_db.profile[group].bars[id].alpha
end
local function bgAlpha_set(group, id, value)
	MetaLayout_db.profile[group].bars[id].bgAlpha = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local function bgAlpha_get(group, id, value)
	return MetaLayout_db.profile[group].bars[id].bgAlpha
end
local function deficit_set(group, id, value)
	MetaLayout_db.profile[group].bars[id].deficit = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local function deficit_get(group, id, value)
	return MetaLayout_db.profile[group].bars[id].deficit
end
local barOptions_id_to_squareOnSide = {}
local function barOptions_func(group, id, extraDisableFunc)
	local squareOnSide = barOptions_id_to_squareOnSide[id]
	return {
		name = L["Side"],
		desc = L["What side of the unit frame to position the bar at."],
		type = 'choice',
		choices = side_choices,
		get = side_get,
		set = side_set,
		passValue = group,
		passValue2 = id,
		disabled = extraDisableFunc,
	}, {
		name = height_name,
		desc = height_desc,
		type = 'number',
		passValue = group,
		passValue2 = id,
		get = height_get,
		set = height_set,
		min = 1,
		max = 12,
		step = 1,
		disabled = squareOnSide and side_isLeftOrRight or extraDisableFunc,
	}, 	{
		name = L["Position"],
		desc = L["Position of the bar relative to other bars."],
		type = 'choice',
		choices = position_choices,
		passValue = group,
		passValue2 = id,
		get = position_get,
		set = position_set,
		disabled = extraDisableFunc,
	}, 	{
		type = 'boolean',
		name = L["Reverse"],
		desc = reverse_desc,
		get = reverse_get,
		set = reverse_set,
		passValue = group,
		passValue2 = id,
		disabled = extraDisableFunc,
	}, {
		type = 'boolean',
		name = L["Deficit"],
		desc = L["Drain the bar instead of filling it."],
		get = deficit_get,
		set = deficit_set,
		passValue = group,
		passValue2 = id,
		disabled = extraDisableFunc,
	}, {
		type = 'number',
		name = L["Filled opacity"],
		desc = L["The opacity of the filled part of the bar."],
		get = alpha_get,
		set = alpha_set,
		passValue = group,
		passValue2 = id,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		disabled = extraDisableFunc,
	}, {
		type = 'number',
		name = L["Empty opacity"],
		desc = L["The opacity of the empty part of the bar."],
		get = bgAlpha_get,
		set = bgAlpha_set,
		passValue = group,
		passValue2 = id,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		disabled = extraDisableFunc,
	}
end
local function barOptions(id, squareOnSide)
	barOptions_id_to_squareOnSide[id] = squareOnSide
	return barOptions_func
end

if playerClass == "ROGUE" or playerClass == "DRUID" then
	local function comboSide_get(group)
		return MetaLayout_db.profile[group].comboSide
	end
	local function comboSide_set(group, value)
		MetaLayout_db.profile[group].comboSide = value
		for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
			PitBull:UpdateLayout(frame)
		end
	end

	MetaLayout.options.name.comboPoints = L["Combo points"]
	MetaLayout.options.desc.comboPoints = L["Options for the combo point display."]
	function MetaLayout.options.comboPoints(group)
		if group == "target" then
			return {
				name = L["Position"],
				desc = L["What position of the unit frame to position the combo point display at."],
				type = 'choice',
				choices = {
					outleft = L["Outside, Left"],
					outlefttop = L["Outside, Left-top"],
					outleftbottom = L["Outside, Left-bottom"],
					outright = L["Outside, Right"],
					outrighttop = L["Outside, Right-top"],
					outrightbottom = L["Outside, Right-bottom"],
					outtop = L["Outside, Above"],
					outtopleft = L["Outside, Above-left"],
					outtopright = L["Outside, Above-right"],
					outbottom = L["Outside, Below"],
					outbottomleft = L["Outside, Below-left"],
					outbottomright = L["Outside, Below-right"],
					
					inleft = L["Inside, Left"],
					inlefttop = L["Inside, Left-top"],
					inleftbottom = L["Inside, Left-bottom"],
					inright = L["Inside, Right"],
					inrighttop = L["Inside, Right-top"],
					inrightbottom = L["Inside, Right-bottom"],
					intop = L["Inside, Top"],
					intopleft = L["Inside, Top-left"],
					intopright = L["Inside, Top-right"],
					inbottom = L["Inside, Bottom"],
					inbottomleft = L["Inside, Bottom-left"],
					inbottomright = L["Inside, Bottom-right"],
				},
				get = comboSide_get,
				set = comboSide_set,
				passValue = group,
			}
		end
	end
end

local textStyles = {
	class = {
		["Standard"]            = "[Classification] [Level:DifficultyColor] [(if (IsPlayer or (IsEnemy and not IsPet)) then Class):ClassColor] [DruidForm:Paren] [SmartRace]",
		["Player Classes Only"] = "[Classification] [Level:DifficultyColor] [(if IsPlayer then Class):ClassColor] [DruidForm:Paren] [SmartRace]",
		["Short"]               = "[(Level (if Classification then '+')):DifficultyColor] [SmartRace]",
	},
	health = {
		["Absolute"]       = "[Status or FractionalHP(known=true) or PercentHP:Percent]",
		["Absolute Short"] = "[Status or FractionalHP(known=true):Short or PercentHP:Percent]",
		["Difference"]     = "[Status or -MissingHP:Hide(0)]",
		["Percent"]        = "[Status or PercentHP:Percent]",
		["Mini"]           = "[HP:VeryShort]",
		["Smart"]          = "[Status or (if IsFriend then MissingHP:Hide(0):Short:Color('ff7f7f') else FractionalHP(known=true):Short or PercentHP:Percent)]",
		["Absolute and Percent"]  = "[Status or (FractionalHP:Short ' || ' PercentHP:Percent)]",
		["Informational"]  = "[Status or (Concatenate((if IsFriend then MissingHP:Hide(0):Short:Color('ff7f7f')), ' || ') FractionalHP:Short ' || ' PercentHP:Percent)]",
	},
	name = {
		["Standard"]             = "[Name] [(AFK or DND):Angle]",
		["Hostility Colored"]    = "[Name:HostileColor] [(AFK or DND):Angle]",
		["Class Colored"]        = "[Name:ClassColor] [(AFK or DND):Angle]",
		["Long"]                 = "[Level] [Name:ClassColor] [(AFK or DND):Angle]",
		["Long w/ Druid form"]   = "[Level] [Name:ClassColor] [DruidForm:Paren] [(AFK or DND):Angle]",
	},
	power = {
		["Absolute"]       = "[if HasMP then FractionalMP]",
		["Absolute Short"] = "[if HasMP then FractionalMP:Short]",
		["Difference"]     = "[-MissingMP]",
		["Percent"]        = "[PercentMP:Percent]",
		["Mini"]           = "[if HasMP then CurMP:VeryShort]",
		["Smart"]          = "[MissingMP:HideZero:Short:Color('7f7fff')]",
	},
	druidMana = playerClass == "DRUID" and {
		["Absolute"]       = "[if not IsMana then FractionalDruidMP]",
		["Absolute Short"] = "[if not IsMana then FractionalDruidMP:Short]",
		["Difference"]     = "[if not IsMana then -MissingDruidMP]",
		["Percent"]        = "[if not IsMana then PercentDruidMP:Percent]",
		["Mini"]           = "[if not IsMana then DruidMP:VeryShort]",
		["Smart"]          = "[if not IsMana then MissingDruidMP:Hide(0):Short:Color('7f7fff')]",
	} or nil,
	threat = {
		["Absolute"]       = "[if HasThreat then Threat]",
		["Absolute Short"] = "[if HasThreat then Threat:Short]",
		["Fractional"]     = "[if HasThreat then FractionalThreat]",
		["Fractional Short"] = "[if HasThreat then FractionalThreat:Short]",
		["Difference"]     = "[if HasThreat then -MissingThreat]",
		["Percent"]        = "[if HasThreat then PercentThreat:Percent]",
		["Mini"]           = "[if HasThreat then Threat:VeryShort]",
	},
	cast = {
		["Standard Name"] = "[Alpha((-CastStopDuration or 0) + 1) CastStopMessage or (CastName ' ' CastTarget:Paren)]",
		["Standard Time"] = "[if not CastStopDuration then Concatenate('+', CastDelay:Round(1):Hide(0)):Red ' ' [CastEndDuration >= 0 ? '%.1f':Format(CastEndDuration)]]",
	},
	combo = (playerClass == "DRUID" or playerClass == "ROGUE") and {
		["Standard"]       = playerClass == "DRUID" and "[if IsEnergy(unit='player') then Combos:Hide(0)]" or "[Combos:Hide(0)]",
	} or nil,
	experience = {
		["Standard"]       = "[FractionalXP] [PercentXP:Percent:Paren] [Concatenate('R: ', PercentRestXP:Hide(0):Percent)]",
		["On Mouse-over"]       = "[if IsMouseOver then FractionalXP ' ' PercentXP:Percent:Paren ' ' Concatenate('R: ', PercentRestXP:Hide(0):Percent)]",
	},
	reputation = {
		["Standard"]       = "[if IsMouseOver then ReputationName else if ReputationName then FractionalReputation ' ' PercentReputation:Percent:Paren]"
	},
}

local styleType_choices = {
	class = L["Class"],
	health = L["Health"],
	name = L["Name"],
	power = L["Power"],
	druidMana = playerClass == "DRUID" and L["Druid mana"] or nil,
	threat = L["Threat"],
	combo = (playerClass == "DRUID" or playerClass == "ROGUE") and L["Combo points"] or nil,
	experience = L["Experience"],
	reputation = L["Reputation"],
	cast = L["Cast"],
	castTime = L["CastTime"],
	none = L["None"],
}

local styleType_choiceDescs = {}

local defaultShownTexts = {
	Health = true,
	Class = true,
	Name = true,
	Power = true,
	Cast = true,
	CastTime = true,
	DruidMana = playerClass == "DRUID" and function(group) return group == "player" end or nil,
	Threat = function(group) return not group:find("target$") end,
	Combo = (playerClass == "DRUID" or playerClass == "ROGUE") and function(group) return group == "target" end or nil,
	Experience = function(group) return group == "player" or group == "pet" end,
	Reputation = function(group) return group == "player" end,
}

local textExtraFrameCreation_id_to_name = {}
local textExtraFrameCreation_id_to_func = {}
local function textExtraFrameCreation_func(unit, frame, id)
	local name = textExtraFrameCreation_id_to_name[id]
	local func = textExtraFrameCreation_id_to_func[id]
	local group = frame.group
	if func and not func(group) then
		return
	end
	if type(defaultShownTexts[name]) == "function" and not defaultShownTexts[name](group) then
		return
	end
	local db = MetaLayout_db.profile[group].texts[name]
	if db.hidden then
		return
	end
	local text = newFrame("FontString", frame.overlay, "OVERLAY")
	frame[id] = text
	local font, fontsize = PitBull:GetFont()
	text:SetFont(font, fontsize * db.size)
	text:SetShadowColor(0, 0, 0, 1)
	text:SetShadowOffset(0.8, -0.8)
	text:SetNonSpaceWrap(false)
	text:SetJustifyH("LEFT")
	local code
	if db.style == "Custom" then
		code = db.custom
	else
		local styles = textStyles[db.styleType]
		code = styles and styles[db.style] or ''
	end
	
	local position = db.position or "hide"
	local attach = ("-"):split(position, 2)
	if attach == "blankSpace" then
		if MetaLayout_db.profile[group].bars.blankSpace.hidden then
			return
		end
	elseif attach == "hide" or (attach ~= "frame" and not frame[attach]) then
		return
	end
	if not PitBull.configMode or name == "Name" or code:find("[Nn][Aa][Mm][Ee]") then
		local kwargs = newList()
		kwargs.unit = unit
		DogTag:AddFontString(text, frame, code or '', "Unit", kwargs)
		kwargs = del(kwargs)
	else
		text:SetText("[" .. name .. "]")
	end
end
local function textExtraFrameCreation(id, name, func)
	assert(type(name) == "string")
	textExtraFrameCreation_id_to_name[id] = name
	textExtraFrameCreation_id_to_func[id] = func
	return textExtraFrameCreation_func
end

local function textStyle_get(group, name)
	return MetaLayout_db.profile[group].texts[name].style
end
local function textStyle_set(group, name, value)
	local id = "layoutText" .. name
	local db = MetaLayout_db.profile[group].texts[name]
	db.style = value

	local code
	if value == "Custom" then
		code = db.custom
	else
		local styles = textStyles[db.styleType]
		code = styles and styles[value] or ''
		db.custom = code
	end
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if not PitBull.configMode or name == "Name" or code:find("[Nn][Aa][Mm][Ee]") then
			local kwargs = newList()
			kwargs.unit = unit
			DogTag:AddFontString(frame[id], frame, code or '', "Unit", kwargs)
			kwargs = del(kwargs)
		else
			frame[id]:SetText("[" .. name .. "]")
		end
	end
end

local function textCustom_get(group, name)
	local db = MetaLayout_db.profile[group].texts[name]
	local value
	if db.style == "Custom" then
		value = db.custom
	else
		local styles = textStyles[db.styleType]
		value = styles and styles[db.style] or ''
		db.custom = value
	end
	return DogTag:CleanCode(value)
end
local function textCustom_set(group, name, value)
	local id = "layoutText" .. name
	local db = MetaLayout_db.profile[group].texts[name]
	
	if db.style ~= "Custom" then
		return
	end
	value = DogTag:CleanCode(value)
	db.custom = value
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if not PitBull.configMode or name == "Name" or value:find("[Nn][Aa][Mm][Ee]") then
			local kwargs = newList()
			kwargs.unit = unit
			DogTag:AddFontString(frame[id], frame, value, "Unit", kwargs)
			kwargs = del(kwargs)
		else
			frame[id]:SetText("[" .. name .. "]")
		end
		
	end
end
local function syntaxHighlighter(_, _, text)
	return DogTag:ColorizeCode(text)
end

local function textSize_get(group, name)
	return MetaLayout_db.profile[group].texts[name].size
end
local function textSize_set(group, name, value)
	MetaLayout_db.profile[group].texts[name].size = value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

local function textEnabled_set(group, name, value)
	MetaLayout_db.profile[group].texts[name].hidden = not value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end

	Rock("LibRockConfig-1.0"):RefreshConfigMenu(PitBull)
end

local basePositionValidate = {
	["blankSpace-left"] = ("%s/%s"):format(L["Blank space"], L["Left"]),
	["blankSpace-center"] = ("%s/%s"):format(L["Blank space"], L["Middle"]),
	["blankSpace-right"] = ("%s/%s"):format(L["Blank space"], L["Right"]),
	["blankSpace-outright"] = ("%s/%s"):format(L["Blank space"], L["Outside, Right"]),
	["blankSpace-outleft"] = ("%s/%s"):format(L["Blank space"], L["Outside, Left"]),
	
	["frame-outtopleft"] = ("%s/%s"):format(L["Frame"], L["Outside, Above-left"]),
	["frame-outtop"] = ("%s/%s"):format(L["Frame"], L["Outside, Above-middle"]),
	["frame-outtopright"] = ("%s/%s"):format(L["Frame"], L["Outside, Above-right"]),
	["frame-outbottomleft"] = ("%s/%s"):format(L["Frame"], L["Outside, Below-left"]),
	["frame-outbottom"] = ("%s/%s"):format(L["Frame"], L["Outside, Below-middle"]),
	["frame-outbottomright"] = ("%s/%s"):format(L["Frame"], L["Outside, Below-right"]),
	["frame-outlefttop"] = ("%s/%s"):format(L["Frame"], L["Outside, Left-top"]),
	["frame-outleft"] = ("%s/%s"):format(L["Frame"], L["Outside, Left-middle"]),
	["frame-outleftbottom"] = ("%s/%s"):format(L["Frame"], L["Outside, Left-bottom"]),
	["frame-outrighttop"] = ("%s/%s"):format(L["Frame"], L["Outside, Right-top"]),
	["frame-outright"] = ("%s/%s"):format(L["Frame"], L["Outside, Right-middle"]),
	["frame-outrightbottom"] = ("%s/%s"):format(L["Frame"], L["Outside, Right-bottom"]),
	
	["frame-center"] = ("%s/%s"):format(L["Frame"], L["Inside, Center"]),
	["frame-intopleft"] = ("%s/%s"):format(L["Frame"], L["Inside, Top-left"]),
	["frame-intop"] = ("%s/%s"):format(L["Frame"], L["Inside, Top"]),
	["frame-intopright"] = ("%s/%s"):format(L["Frame"], L["Inside, Top-right"]),
	["frame-inbottomleft"] = ("%s/%s"):format(L["Frame"], L["Inside, Bottom-left"]),
	["frame-inbottom"] = ("%s/%s"):format(L["Frame"], L["Inside, Bottom"]),
	["frame-inbottomright"] = ("%s/%s"):format(L["Frame"], L["Inside, Bottom-right"]),
	["frame-inleft"] = ("%s/%s"):format(L["Frame"], L["Inside, Left"]),
	["frame-inright"] = ("%s/%s"):format(L["Frame"], L["Inside, Right"]),
	
	["frame-edgetopleft"] = ("%s/%s"):format(L["Frame"], L["Edge, Top-left"]),
	["frame-edgetop"] = ("%s/%s"):format(L["Frame"], L["Edge, Top"]),
	["frame-edgetopright"] = ("%s/%s"):format(L["Frame"], L["Edge, Top-right"]),
	["frame-edgeleft"] = ("%s/%s"):format(L["Frame"], L["Edge, Left"]),
	["frame-edgeright"] = ("%s/%s"):format(L["Frame"], L["Edge, Right"]),
	["frame-edgebottomleft"] = ("%s/%s"):format(L["Frame"], L["Edge, Bottom-left"]),
	["frame-edgebottom"] = ("%s/%s"):format(L["Frame"], L["Edge, Bottom"]),
	["frame-edgebottomright"] = ("%s/%s"):format(L["Frame"], L["Edge, Bottom-right"]),
	
	["hide"] = L["Hidden"],
}

local function textOrIconPosition_get(group, name, isIcon, _, k)
	local value = MetaLayout_db.profile[group][isIcon and "icons" or "texts"][name].position
	if k then
		return value == k
	else
		return value
	end
end
local function textOrIconPosition_set(group, name, isIcon, _, value)
	if not isIcon then
		if value ~= "hide" then
			local frame = findTextAtPosition(group, value)
			if frame then
				frame = frame:gsub("^layoutText", "")
				MetaLayout_db.profile[group].texts[frame].position = MetaLayout_db.profile[group].texts[name].position
			end
		end
	end
	MetaLayout_db.profile[group][isIcon and "icons" or "texts"][name].position = value

	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end

local function positionArgs_hidden(group, name, isIcon, attach)
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if frame[attach] then
			return false
		end
	end
	return true
end

local _positionArgs = {}
function positionArgs()
	local attaches = newList()
	for k, v in pairs(basePositionValidate) do
		local attach, point = ('-'):split(k)
		if not _positionArgs[attach] then
			attaches[attach] = true
		end
	end
	if next(attaches) then
		for k, v in pairs(basePositionValidate) do
			local attach, point = ('-'):split(k)
			if attaches[attach] then
				local attachName, pointName = ('/'):split(v)
				if point then
					if not _positionArgs[attach] then
						_positionArgs[attach] = {
							type = 'choice',
							name = attachName,
							desc = attachName,
							choices = {},
							get = textOrIconPosition_get,
							set = textOrIconPosition_set,
							passValue4 = attach,
							hidden = attach ~= "frame" and positionArgs_hidden,
						}
					end
					_positionArgs[attach].choices[k] = pointName
				else
					_positionArgs[attach] = {
						type = 'boolean',
						name = v,
						desc = v,
						get = textOrIconPosition_get,
						set = textOrIconPosition_set,
						passValue4 = attach,
						passValue5 = k,
					}
				end
			end
		end
	end
	attaches = del(attaches)
	return _positionArgs
end

local function style_choices(group, name)
	local db = MetaLayout_db.profile[group].texts[name]
	local styleType = db.styleType
	local styles = textStyles[styleType]
	local t = newList()
	t["Hide"] = L["Hide"]
	t["Custom"] = L["Custom"]
	if styles then
		for k, v in pairs(styles) do
			t[k] = L[k]
		end
	end
	return "@dict", unpackDictAndDel(t)
end
local function style_choiceDescs(group, name)
	local db = MetaLayout_db.profile[group].texts[name]
	local styleType = db.styleType
	local styles = textStyles[styleType]
	local t = newList()
	t["Hide"] = ""
	t["Custom"] = L["Choose your own custom text."]
	if styles then
		for k, v in pairs(styles) do
			t[k] = v
		end
	end
	return "@dict", unpackDictAndDel(t)
end

local function textStyleType_get(group, name)
	return MetaLayout_db.profile[group].texts[name].styleType
end
local function textStyleType_set(group, name, value)
	local id = "layoutText" .. name
	local db = MetaLayout_db.profile[group].texts[name]
	db.styleType = value
	
	if db.style == "Custom" then
		return
	end
	
	local styles = textStyles[db.styleType]
	if not styles then
		db.style = "Custom"
	elseif not styles[db.style] then
		if styles["Standard"] then
			db.style = "Standard"
		elseif styles["Absolute"] then
			db.style = "Absolute"
		else
			db.style = "Custom"
		end
	end
	local code
	if db.style == "Custom" then
		code = db.custom
	else
		code = styles[db.style] or ''
		db.custom = code
	end
	
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if not PitBull.configMode or name == "Name" or code:find("[Nn][Aa][Mm][Ee]") then
			local kwargs = newList()
			kwargs.unit = unit
			DogTag:AddFontString(frame[id], frame, code or '', "Unit", kwargs)
			kwargs = del(kwargs)
		else
			frame[id]:SetText("[" .. name .. "]")
		end
	end
end

local function retTrue() return true end
local function retFalse() return false end

local function DogTag_OpenHelp()
	DogTag:OpenHelp()
end

local textOptions_id_to_name = {}
local function textOptions_func(group, id)
	local name = textOptions_id_to_name[id]
	return {
		type = 'choice',
		name = L["Style"],
		desc = L["Use a preconfigured style."],
		choices = style_choices,
		choiceDescs = style_choiceDescs,
		get = textStyle_get,
		set = textStyle_set,
		passValue = group,
		passValue2 = name,
	}, {
		type = 'string',
		name = L["Style - Custom"],
		desc = L["Create a custom style for this unit type."],
		get = textCustom_get,
		set = textCustom_set,
		syntaxHighlighter = syntaxHighlighter,
		multiline = true,
		usage = L["LibDogTag-3.0 tags. See http://www.wowace.com/wiki/LibDogTag-3.0"],
		passValue = group,
		passValue2 = name,
	}, {
		type = 'choice',
		name = L["Style - Type"],
		desc = L["Choose the type of pre-made styles to work with."],
		get = textStyleType_get,
		set = textStyleType_set,
		passValue = group,
		passValue2 = name,
		choices = styleType_choices,
		choiceDescs = styleType_choiceDescs,
	}, {
		type = 'group',
		groupType = 'inline',
		name = L["Position"],
		desc = L["Position of the text."],
		args = positionArgs,
		child_passValue = group,
		child_passValue2 = name,
		child_passValue3 = false,
		child_child_passValue = group,
		child_child_passValue2 = name,
		child_child_passValue3 = false,
	}, {
		type = 'number',
		name = L["Size"],
		desc = L["Font size of the text."],
		get = textSize_get,
		set = textSize_set,
		passValue = group,
		passValue2 = name,
		min = 0.25,
		max = 3,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
	}, {
		type = 'boolean',
		name = L["Enable"],
		desc = L["Click to disable this text from being shown."],
		get = retTrue,
		set = textEnabled_set,
		passValue = group,
		passValue2 = name,
	}, {
		type = 'execute',
		name = L["DogTag help"],
		buttonText = L["Open"],
		desc = L["Click to pop up helpful DogTag documentation."],
		func = DogTag_OpenHelp,
		order = -1,
	}
end
local function textOptions_smallFunc(group, id)
	local name = textOptions_id_to_name[id]
	return {
		type = 'group',
		groupType = 'inline',
		name = L["Position"],
		desc = L["Position of the text."],
		args = positionArgs,
		child_passValue = group,
		child_passValue2 = name,
		child_passValue3 = false,
		child_child_passValue = group,
		child_child_passValue2 = name,
		child_child_passValue3 = false,
	}
end
local function textOptions(id, name, noStyle)
	assert(type(name) == "string")
	textOptions_id_to_name[id] = name
	if not noStyle then
		return textOptions_func
	else
		return textOptions_smallFunc
	end
end

local function createArbitraryText(name, extraFrameFunc)
	if name == "Combo" then
		if playerClass ~= "DRUID" and playerClass ~= "ROGUE" then
			return
		end
	elseif name == "DruidMana" then
		if playerClass ~= "DRUID" then
			return
		end
	end
	local textOptionsArg
	if extraFrameFunc == true then
		extraFrameFunc = nil
		textOptionsArg = true
	end
	local id = textOptionsArg and name or "layoutText" .. name
	if MetaLayout.positions[id] or (MetaLayout.positions[name] and name:find("[Tt][Ee][Xx][Tt]")) then
		return
	end
	MetaLayout.positions[id] = textPosition(id, name)
	if not textOptionsArg then
		MetaLayout.extraFrames[id] = textExtraFrameCreation(id, name, extraFrameFunc)
	end
	-- L[name] should be changed to L:HasTranslation(id) and L[id]
	MetaLayout.options.name[id] = L[name]
	MetaLayout.options.desc[id] = L["Customize the %s text."]:format(L[name])
	MetaLayout.options[id] = textOptions(id, name, textOptionsArg)
end

createArbitraryText('combatText', true)

local function otherTexts_hidden_choices(group)
	local t = newList()
	for k,v in pairs(defaultShownTexts) do
		if MetaLayout_db.profile[group].texts[k].hidden then
			t[k] = L[k]
			if type(v) == "function" then
				if not v(group) then
					t[k] = nil
				end
			end
		end
	end
	for k,v in pairs(MetaLayout_db.profile[group].texts) do
		if v.hidden then
			t[k] = L[k]
			if type(defaultShownTexts[k]) == "function" then
				if not defaultShownTexts[k](group) then
					t[k] = nil
				end
			end
		end
	end
	return "@dict", unpackDictAndDel(t)
end

local function otherTexts_hidden_set(group, name)
	MetaLayout_db.profile[group].texts[name].hidden = false
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
	Rock("LibRockConfig-1.0"):RefreshConfigMenu(PitBull)
end

local function otherTexts_hidden_disabled(group)
	return select('#', otherTexts_hidden_choices(group)) == 1
end

local function otherTexts_new_set(group, name)
	local db = MetaLayout_db.profile[group].texts[name]
	if not db.hidden then
		return
	end
	if name == "Combat" or name == L["Combat"] then
		return
	end
	db.hidden = false
	if db.custom == "" then
		db.custom = name
	end
	createArbitraryText(name)
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end	
	Rock("LibRockConfig-1.0"):RefreshConfigMenu(PitBull)
end

local function otherTexts_new_validate(group, name)
	if name == "" then
		return false, L["Name required"]
	elseif rawget(MetaLayout_db.profile[group].texts, name)then
		return false, L["Name already in use"]
	end
	return true
end

function MetaLayout.options.alwaysText(group)
	return {
		type = 'group',
		name = L["Other"],
		desc = L["Create other texts."],
		order = 101,
		args = {
			hidden = {
				type = 'choice',
				name = L["Disabled texts"],
				desc = L["Show some of the disabled texts."],
				get = retFalse,
				set = otherTexts_hidden_set,
				choices = otherTexts_hidden_choices,
				passValue = group,
				disabled = otherTexts_hidden_disabled
			},
			new = {
				type = 'string',
				name = L["New text"],
				desc = L["Create a new text."],
				validate = otherTexts_new_validate,
				get = false,
				set = otherTexts_new_set,
				passValue = group,
				usage = L["<Name>"]
			}
		},
	}
end

local function blankSpace_enable_get(group)
	return not MetaLayout_db.profile[group].bars.blankSpace.hidden
end
local function blankSpace_disable_get(group)
	return MetaLayout_db.profile[group].bars.blankSpace.hidden
end
local function blankSpace_enable_set(group, value)
	MetaLayout_db.profile[group].bars.blankSpace.hidden = not value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		PitBull:UpdateLayout(frame)
	end
end
local blankSpace_optionsFunc = barOptions('blankSpace')
function MetaLayout.options.alwaysBar(group)
	return {
		type = 'group',
		name = L["Blank space"],
		desc = L["Change settings for the blank space."],
		args = {
			{
				name = L["Enable"],
				desc = L["Enable the blank space."],
				type = 'boolean',
				passValue = group,
				get = blankSpace_enable_get,
				set = blankSpace_enable_set,
			}, blankSpace_optionsFunc(group, 'blankSpace', blankSpace_disable_get)
		},
		order = 50,
	}
end

PitBull:RegisterMetaLayout(MetaLayout)

function MetaLayout:OnInitialize()
	for k in pairs(defaultShownTexts) do
		createArbitraryText(k)
	end
	for group, data in pairs(MetaLayout_db.profile) do
		for k in pairs(data.texts) do
			createArbitraryText(k)
		end
		if data.bars.portrait.side == "top" then
			data.bars.portrait.side = "center"
		end
	end
end

local function nilDefault(value, default, setToDefault)
	if value == default or value == nil or type(value) ~= type(default) then
		if setToDefault then
			return default
		else
			return nil
		end
	else
		return value
	end
end

function MetaLayout:ExportLayout(group)
	local layout = newList()
	layout.pbRevision = PitBull.revision
	
	local db = MetaLayout_db.profile[group]
	
	layout.texts = newList()
	for k,v in pairs(db.texts) do
		local hidden = nilDefault(v.hidden, false) or v.position == "hide"
		if not hidden then
			local t = newList()
			layout.texts[k] = t
			t.size = nilDefault(v.size, 1)
			t.style = nilDefault(v.style, "Custom")
			t.styleType = nilDefault(v.styleType, "none")
			t.position = nilDefault(v.position, "frame-center", true)
			t.custom = nilDefault(v.custom, "")
		end
	end
	
	layout.icons = newList()
	for k,v in pairs(db.icons) do
		local t = newList()
		layout.icons[k] = t
		t.size = nilDefault(v.size, 1)
		t.position = nilDefault(v.position, "frame-edgebottomleft", true)
	end
	
	layout.bars = newList()
	for k,v in pairs(db.bars) do
		local t = newList()
		layout.bars[k] = t
		t.height = nilDefault(v.height, 2)
		t.position = nilDefault(v.position, 1, true)
		t.reverse = not not v.reverse
		t.deficit = not not v.deficit
		t.side = v.side
		if type(t.side) ~= "string" then
			t.side = nil
		end
		t.hidden = not not v.hidden
	end
	
	return layout
end

local function toDefault(value, default)
	if value == nil or type(value) ~= type(default) then
		return default
	else
		return value
	end
end

local function recurseCheckNonKosher(t)
	-- only tables, strings, numbers, and booleans are kosher values.
	local type_t = type(t)
	if type_t == "table" then
		for k, v in pairs(t) do
			if recurseCheckNonKosher(k) or recurseCheckNonKosher(v) then
				return true
			end
		end
		return false
	end
	return type_t ~= "number" and type_t ~= "string" and type_t ~= "boolean" and type_t ~= "nil"
end

local function handleLayout(layout)
	if type(layout) ~= "table" then
		return nil, "Error, Layout must be a table."
	end
	local pbRevision = layout.pbRevision
	if type(pbRevision) ~= "number" then
		return nil, ("Error, %q must be a number."):format("pbRevision")
	end

	if pbRevision > PitBull.revision then
		return nil, ("Error importing layout made with a newer version of PitBull: %d > %d."):format(pbRevision, PitBull.revision)
	end
	
	if type(layout.texts) ~= "table" then
		return nil, ("Error, %q must be a table."):format("texts")
	elseif type(layout.icons) ~= "table" then
		return nil, ("Error, %q must be a table."):format("icons")
	elseif type(layout.bars) ~= "table" then
		return nil, ("Error, %q must be a table."):format("bars")
	end
	
	layout = deepCopy(layout)
	
	if recurseCheckNonKosher(layout) then
		return nil, "Error, improper values found in resultant table."
	end
	
	for k,v in pairs(layout.texts) do
		if type(k) == "string" and type(v) == "table" then
			v.size = toDefault(v.size, 1)
			v.style = toDefault(v.style, "Custom")
			v.styleType = toDefault(v.styleType, "none")
			v.position = toDefault(v.position, "frame-center")
			v.custom = toDefault(v.custom, "")
		else
			layout.texts[k] = deepDel(v)
		end
	end

	for k,v in pairs(layout.icons) do
		if type(k) == "string" and type(v) == "table" then
			v.size = toDefault(v.size, 1)
			v.position = toDefault(v.position, "frame-edgebottomleft")
		else
			layout.icons[k] = deepDel(v)
		end
	end

	for k,v in pairs(layout.bars) do
		if type(k) == "string" and type(v) == "table" then
			v.height = toDefault(v.height, 2)
			v.position = toDefault(v.position, 1)
			v.side = v.side -- handle later
			v.hidden = toDefault(v.hidden, false) or nil
		else
			layout.bars[k] = deepDel(v)
		end
	end
	
	-- check for syntax errors maybe
	return layout
end

function MetaLayout:IsValidLayout(layout)
	layout, problem = handleLayout(layout)
	if not layout then
		return layout, problem
	end
	
	layout = deepDel(layout)
	return true
end

function MetaLayout:ImportLayout(group, layout)
	layout, problem = handleLayout(layout)
	if not layout then
		return layout, problem
	end
	
	local db = MetaLayout_db.profile[group]
	for k,v in pairs(db.texts) do
		db.texts[k] = del(v)
	end
	for k,v in pairs(layout.texts) do
		local t = newList()
		db.texts[k] = t
		t.size = v.size
		t.style = v.style
		t.styleType = v.styleType
		t.position = v.position
		t.custom = v.custom
		t.hidden = false
	end
	for k,v in pairs(MetaLayout_db.defaults.profile['**'].texts) do
		if not layout.texts[k] and k ~= '*' and k ~= '**' then
			local t = newList()
			db.texts[k] = t
			for l,u in pairs(v) do
				t[l] = u
			end
			if MetaLayout_db.defaults.profile[group] and MetaLayout_db.defaults.profile[group].texts then
				for l,u in pairs(MetaLayout_db.defaults.profile[group].texts) do
					t[l] = u
				end
			end
			t.hidden = true
		end
	end
	
	for k,v in pairs(db.icons) do
		db.icons[k] = del(v)
	end
	for k,v in pairs(layout.icons) do
		local t = newList()
		db.icons[k] = t
		t.size = v.size
		t.position = v.position
	end
	
	for k,v in pairs(db.bars) do
		db.bars[k] = del(v)
	end
	for k,v in pairs(layout.bars) do
		local t = newList()
		db.bars[k] = t
		t.height = v.height
		t.position = v.position
		t.side = v.side
		t.hidden = v.hidden
		t.reverse = v.reverse
		t.deficit = v.deficit
	end
	
	layout = deepDel(layout)
	
	return true
end

function MetaLayout:IsCurrentLayout(group, layout, debug)
	layout, problem = handleLayout(layout)
	if not layout then
		return layout, problem
	end
	
	local good = true
	local db = MetaLayout_db.profile[group]
	for k,v in pairs(layout.texts) do
		local t = db.texts[k]
		if type(t) ~= "table" or t.size ~= v.size or t.style ~= v.style or t.styleType ~= v.styleType or t.position ~= v.position or t.custom ~= v.custom or not t.hidden ~= not v.hidden then
			layout = deepDel(layout)
			return false
		end
	end
	for k, v in pairs(db.texts) do
		if not v.hidden and not layout.texts[k] then
			layout = deepDel(layout)
			return false
		end
	end
	
	for k,v in pairs(layout.icons) do
		local t = db.icons[k]
		if type(t) ~= "table" or t.size ~= v.size or t.position ~= v.position then
			layout = deepDel(layout)
			return false
		end
	end
	
	for k,v in pairs(layout.bars) do
		local t = db.bars[k]
		if type(t) ~= "table" or t.height ~= v.height or t.position ~= v.position or t.side ~= v.side or not t.hidden ~= not v.hidden then
			layout = deepDel(layout)
			return false
		end
	end
	
	layout = deepDel(layout)
	
	return true
end

function MetaLayout:CreateIconHandler(key, priority)
	MetaLayout.positions[key] = iconPosition_func
	MetaLayout.options[key] = iconOptions_func
	iconPriorities[key] = priority
end

function MetaLayout:CreateBarHandler(key, name, smallName, squareOnSide)
	MetaLayout.positions[key] = barPosition_func
	barList[key] = true
	if squareOnSide then
		squareOnSide_bars[key] = true
	end
	barNameToLocal[key] = name
	MetaLayout.options[key] = barOptions(key, squareOnSide)
	if squareOnSide then
		basePositionValidate[key .. "-left"] = ("%s/%s"):format(smallName, L["Left"])
		basePositionValidate[key .. "-center"] = ("%s/%s"):format(smallName, L["Middle"])
		basePositionValidate[key .. "-right"] = ("%s/%s"):format(smallName, L["Right"])
		basePositionValidate[key .. "-top"] = ("%s/%s"):format(smallName, L["Top"])
		basePositionValidate[key .. "-bottom"] = ("%s/%s"):format(smallName, L["Bottom"])
		basePositionValidate[key .. "-topleft"] = ("%s/%s"):format(smallName, L["Top-left"])
		basePositionValidate[key .. "-bottomleft"] = ("%s/%s"):format(smallName, L["Bottom-left"])
		basePositionValidate[key .. "-topright"] = ("%s/%s"):format(smallName, L["Top-right"])
		basePositionValidate[key .. "-bottomright"] = ("%s/%s"):format(smallName, L["Bottom-right"])
	else
		basePositionValidate[key .. "-left"] = ("%s/%s"):format(smallName, L["Left"])
		basePositionValidate[key .. "-center"] = ("%s/%s"):format(smallName, L["Middle"])
		basePositionValidate[key .. "-right"] = ("%s/%s"):format(smallName, L["Right"])
		basePositionValidate[key .. "-outright"] = ("%s/%s"):format(smallName, L["Outside, Right"])
		basePositionValidate[key .. "-outleft"] = ("%s/%s"):format(smallName, L["Outside, Left"])
	end
end
