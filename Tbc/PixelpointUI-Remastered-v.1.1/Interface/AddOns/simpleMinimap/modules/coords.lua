local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap_coords")

L:RegisterTranslations("enUS", function() return({
	alpha = true,
	alpha_desc = "set coordinates frame alpha",
	backdrop = true,
	backdrop_desc = "show or hide coords frame backdrop",
	border = true,
	border_desc = "show or hide coords frame border",
	coords = true,
	coords_desc = "minimap coordinates frame",
	fontColor = true,
	fontColor_desc = "change the coordinate font color",
	instanceHide = true,
	instanceHide_desc = "hide coords frame when no coords are available",
	position = true,
	position_desc = "position of coordinates frame on the minimap",
	precision = true,
	precision_desc = "precision of the minimap coords",
	scale = true,
	scale_desc = "set minimap coordinates scale",
	separator = true,
	separator_desc = "character(s) that seperate X and Y readings",
	time = true,
	time_desc = "delay, in seconds, between coordinate updates",
	positions = {
		"bottom inside",
		"bottom outside",
		"top inside",
		"top outside",
		"top left",
		"bottom left",
		"top right",
		"bottom right"
	}
}) end)

L:RegisterTranslations("zhTW", function() return({
	alpha = "透明度",
	alpha_desc = "設置座標框體透明度",
	backdrop = "背景",
	backdrop_desc = "顯示或隱藏座標框體背景",
	border = "邊框",
	border_desc = "顯示或隱藏座標框體邊框",
	coords = "座標",
	coords_desc = "迷你地圖座標框體",
	fontColor = "字體顏色",
	fontColor_desc = "改變座標的字體顏色",
	instanceHide = "隱藏",
	instanceHide_desc = "在無可用座標的時候自動隱藏座標框體",
	position = "位置",
	position_desc = "座標框體位置",
	precision = "精密",
	precision_desc = "座標精密度",
	scale = "尺度",
	scale_desc = "設置迷你地圖座標的尺度大小",
	time = "刷新時間",
	time_desc = "座標更新的延遲秒數",
	positions = {
		"內部底端",
		"外部底端",
		"內部頂端",
		"外部頂端",
		"頂端左側",
		"底端左側",
		"頂端右側",
		"底端右側"
	}
}) end)

L:RegisterTranslations("koKR", function() return({
	alpha = "투명도",
	alpha_desc = "좌표표시 프레임 투명도 설정",
	backdrop = "배경",
	backdrop_desc = "좌표 프레임 배경 표시 혹은 숨김",
	border = "테두리",
	border_desc = "좌표 프레임 테두리 표시 혹은 숨김",
	coords = "좌표표시",
	coords_desc = "미니맵 좌표표시 프레임",
	fontColor = "글꼴 색상",
	fontColor_desc = "좌표표시 글꼴 색상 변경",
	instanceHide = "인스턴스숨김",
	instanceHide_desc = "이용가능한 좌표가 없을 때 좌표 프레임 숨김",
	position = "위치",
	position_desc = "미니맵에 좌표표시의 위치",
	precision = "소수점",
	precision_desc = "미니맵 좌표의 소수점 자릿수를 선택",
	scale = "크기",
	scale_desc = "미니맵 좌표표시 크기 설정",
	separator = "구분자",
	separator_desc = "X좌표와 Y좌표를 구분하는 구분자를 입력",
	time = "시간",
	time_desc = "지연시간, 초 단위, 좌표 갱싱 간격",
	positions = {
		"내부 하단",
		"외부 하단",
		"내부 상단",
		"외부 상단",
		"좌측 상단",
		"좌측 하단",
		"우측 상단",
		"우측 하단"
	}
}) end)

L:RegisterTranslations("deDE", function() return({
	alpha = "Helligkeit",
	alpha_desc = "Stellt die Helligkeit des Fensters ein",
	backdrop = "Hintergrund",
	backdrop_desc = "Zeigt oder versteckt den Hintergrund",
	border = "Rahmen",
	border_desc = "Zeigt oder versteckt den Fensterrahmen",
	coords = "Koordinaten",
	coords_desc = "Minimap Koordinatenfenster",
	fontColor = "Schriftfarbe",
	fontColor_desc = "Ändert die Schriftfarbe der Koordinaten",
	instanceHide = "Instanz aus",
	instanceHide_desc = "Verstecke das Koordinatenfenster wenn keine Koordinaten (wie z.B. in Instanzen) verfügbar sind",
	position = "Position",
	position_desc = "Position des Koordinatenfensters an der Minimap",
	precision = "Genauigkeit",
	precision_desc = "Genauigkeit der Minimap Koordinaten",
	scale = "Größenverhältnis",
	scale_desc = "Stellt das Größenverhältnis des Fensters ein",
	separator = "Abstandhalter",
	separator_desc = "Satzzeichen das die X and Y Koordinaten trennt",
	time = "Intervall zwischen Aktualisierungen",
	time_desc = "Verzögerung (in Sekunden), zwischen den Aktualisierungen der Koordinaten",
	positions = {
		"Unten innen",
		"Unten außerhalb",
		"Oben innen",
		"Oben außerhalb",
		"Oben links",
		"Unten links",
		"Oben recht",
		"Unten rechts"
	}
}) end)

L:RegisterTranslations("zhCN", function() return({
	alpha = "透明度",
	alpha_desc = "设置坐标框体的透明度",
	backdrop = "背景",
	backdrop_desc = "显示或隐藏坐标框体的背景",
	border = "边框",
	border_desc = "显示或隐藏坐标框体的边框",
	coords = "坐标",
	coords_desc = "迷你地图坐标框体",
	fontColor = "字体颜色",
	fontColor_desc = "改变坐标的字体颜色",
	instanceHide = "隐藏",
	instanceHide_desc = "在无可用坐标的时候隐藏坐标框体",
	position = "位置",
	position_desc = "坐标框体在迷你地图里的位置",
	precision = "精密",
	precision_desc = "迷你地图坐标的精密度",
	scale = "尺度",
	scale_desc = "设置迷你地图坐标的尺度大小",
	separator = "分列方式",
	separator_desc = "字符按照（XML中给出的）x，y值来排列 ",
	time = "刷新时间",
	time_desc = "坐标刷新延迟，即两次坐标刷新之间的延迟（以秒为单位）",
	positions = {
		"内部底端",
		"外部底端",
		"内部顶端",
		"外部顶端",
		"顶端左侧",
		"底端左侧",
		"顶端右侧",
		"底端右侧"
	}
}) end)

L:RegisterTranslations("esES", function() return({
	alpha = "Transparencia",
	alpha_desc = "Establece la transparencia del marco de coordenadas",
	backdrop = "Fondo",
	backdrop_desc = "Muestra u oculta el fondo del marco de coordenadas",
	border = "Borde",
	border_desc = "Muestra u oculta el borde del marco de coordenadas",
	coords = "Coordenadas",
	coords_desc = "Marco de coordenadas del minimapa",
	fontColor = "Color de fuente",
	fontColor_desc = "Cambia el color de la fuente de las coordenadas",
	instanceHide = "Ocultar en instancia",
	instanceHide_desc = "Oculta el marco de coordenadas cuando no hay coordenadas disponibles",
	position = "Posici\195\179n",
	position_desc = "Posici\195\179n del marco de coordenadas en el minimapa",
	precision = "Precisi\195\179n",
	precision_desc = "Precisi\195\179n de las coordenadas del minimapa",
	scale = "Escala",
	scale_desc = "Establece la escala de las coordenadas del minimapa",
	time = "Tiempo",
	time_desc = "Retraso, en segundos, entre las actualizaciones de coordenadas",
	positions = {
		"abajo dentro",
		"abajo fuera",
		"arriba dentro",
		"arriba fuera",
		"superior izquierda",
		"inferior izquierda",
		"superior derecha",
		"inferior derecha"
	}
}) end)
-- Russian Translation by Ynitron, hwost, StingerSoft
L:RegisterTranslations("ruRU", function() return({
	alpha = "Прозрачность",
	alpha_desc = "Установить прозрачность фреймов координат",
	backdrop = "Фон",
	backdrop_desc = "Показать/Скрыть фон фрейма координат",
	border = "Рамка",
	border_desc = "Показать/Скрыть рамку фреймов координат",
	coords = "Координаты",
	coords_desc = "Фрейм координат у мини-карты",
	fontColor = "Цвет шрифта",
	fontColor_desc = "Изменить цвет шрифта координат",
	instanceHide = "Скрывать в подземельях",
	instanceHide_desc = "Скрыть фреймы координат когда нет доступных координат",
	position = "Позиция",
	position_desc = "Позиция фрейма координат у мини-карты",
	precision = "Воспроизводимость",
	precision_desc = "Воспроизводимость координат мини-карты",
	scale = "Масштаб",
	scale_desc = "Установить масштаб координат у мини-карты",
	separator = "Разделитель",
	separator_desc = "Знак препинания разделяющие направления X и Y",
	time = "Время",
	time_desc = "Задержка(в секундах) между обновлением координат",
	positions = {
		"Снизу внутри",
		"Снизу снаружи",
		"Сверху внутри",
		"Сверху снаружи",
		"Сверху слева",
		"Снизу слева",
		"Сверху справа",
		"Снизу справа"
	}
}) end)

local mod = simpleMinimap:NewModule("coords", "AceEvent-2.0")
mod.desc = L["coords_desc"]
mod.translatedName = L["coords"]

local positions = {
	{ "BOTTOM", "BOTTOM" },
	{ "TOP", "BOTTOM" },
	{ "TOP", "TOP" },
	{ "BOTTOM", "TOP" },
	{ "TOPLEFT", "TOPLEFT" },
	{ "BOTTOMLEFT", "BOTTOMLEFT" },
	{ "TOPRIGHT", "TOPRIGHT" },
	{ "BOTTOMRIGHT", "BOTTOMRIGHT" }
}

local coordString
local frame = nil
local frameText = nil

local function updateCoords()
	local x, y = GetPlayerMapPosition("player")
	frameText:SetText(coordString:format(x*100, y*100))
end

local function updateEvent()
	local p = mod.db.profile
	local x, y = GetPlayerMapPosition("player")
	if p.instanceHide and x == 0 and y == 0 then
		frame:Hide()
		frame:SetScript("OnUpdate", nil)
		mod:CancelAllScheduledEvents()
		mod:ScheduleEvent("smmCoords", updateEvent, 10)
	else
		frame:Show()
		if p.time > 0 then
			frame:SetScript("OnUpdate", nil)
			mod:ScheduleRepeatingEvent("smmCoords", updateCoords, p.time)
		else
			mod:CancelAllScheduledEvents()
			frame:SetScript("OnUpdate", updateCoords)
		end
	end
end

local function get(key)
	if key == "fontColor" then
		return mod.db.profile.fontR, mod.db.profile.fontG, mod.db.profile.fontB
	elseif key == "separator" then
		return mod.db.profile.separator:gsub('|','||')
	else
		return mod.db.profile[key]
	end
end

local function set(key, value, g, b)
	if key == "fontColor" then
		mod.db.profile.fontR=value
		mod.db.profile.fontG=g
		mod.db.profile.fontB=b
		mod:UpdateScreen()
	elseif key == "separator" then
		mod.db.profile.separator=value:gsub('||','|')
		mod:UpdateScreen()
	else
		mod.db.profile[key] = value
		if key == "instanceHide" or key == "time" then
			updateEvent()
		else
			mod:UpdateScreen()
		end
	end
end

mod.options = {
	alpha = {
		type = "range",
		order = 10,
		name = L.alpha,
		desc = L.alpha_desc,
		min = 0,
		max = 1,
		step = 0.05,
		set = set,
		get = get,
		passValue = "alpha",
		isPercent = true,
	},
	backdrop = {
		type = "toggle",
		order = 10,
		name = L.backdrop,
		desc = L.backdrop_desc,
		set = set,
		get = get,
		passValue = "backdrop",
	},
	border = {
		type = "toggle",
		order = 10,
		name = L.border,
		desc = L.border_desc,
		set = set,
		get = get,
		passValue = "border",
	},
	fontColor = {
		type = "color",
		order = 10,
		name = L.fontColor,
		desc = L.fontColor_desc,
		set = set,
		get = get,
		passValue = "fontColor",
	},
	instanceHide = {
		type = "toggle",
		order = 10,
		name = L.instanceHide,
		desc = L.instanceHide_desc,
		set = set,
		get = get,
		passValue = "instanceHide",
	},
	position = {
		type = "group",
		order = 10,
		name = L.position,
		desc = L.position_desc,
		args = {}
	},
	precision = {
		type = "range",
		order = 10,
		name = L.precision,
		desc = L.precision_desc,
		set = set,
		get = get,
		passValue = "precision",
		min = 0,
		max = 3,
		step = 1,
	},
	scale = {
		type = "range",
		order = 10,
		name = L.scale,
		desc = L.scale_desc,
		set = set,
		get = get,
		passValue = "scale",
		min = 0.5,
		max = 2,
		step = 0.05,
	},
	separator = {
		type = "text",
		order = 10,
		name = L.separator,
		desc = L.separator_desc,
		usage = "\"<"..L.separator..">\"",
		set = set,
		get = get,
		passValue = "separator",
	},
	time = {
		type = "range",
		order = 10,
		name = L.time,
		desc = L.time_desc,
		min = 0,
		max = 5,
		step = 1,
		set = set,
		get = get,
		passValue = "time",
	},
}
for i,_ in pairs(positions) do
	mod.options.position.args[tostring(i)] = {
		type = "toggle",
		order = i,
		name = L.positions[i],
		desc = L.positions[i],
		get = function()
			return mod.db.profile.position == i
		end,
		set = function()
			mod.db.profile.position = i
			mod:UpdateScreen()
		end
	}
end

mod.defaults = {
	enabled = true,
	alpha = 1,
	backdrop = true,
	border = true,
	fontR = 0.8, fontG = 0.8, fontB = 0.6,
	instanceHide = false,
	position = 6,
	precision = 1,
	scale = 0.9, 
	separator = ", ",
	time = 1
}

local backdrop = {
	bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
	tile="true", tileSize=16, edgeSize=16,
	insets={ left=5, right=5, top=5, bottom=5 }
}

function mod:OnEnable()
	if not frame then
		frame = CreateFrame("Frame", nil, Minimap)
		frame:SetBackdrop(backdrop)
		frameText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frameText:SetPoint("CENTER")
	end
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	updateEvent()
	self:UpdateScreen()
end

function mod:OnDisable()
	if frame then
		frame:SetScript("OnUpdate", nil)
		frame:Hide()
	end
end

local stratas = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"FULLSCREEN",
	"FULLSCREEN_DIALOG",
	"TOOLTIP"
}
function mod:UpdateScreen()
	if not simpleMinimap:IsModuleActive(self) then return end

	if frame then
		local p = self.db.profile
		coordString = "%."..p.precision.."f"..p.separator.."%."..p.precision.."f"

		local f, t = frame, frameText
		f:ClearAllPoints()
		f:SetPoint(positions[p.position][1], "Minimap", positions[p.position][2])
		f:SetAlpha(p.alpha)
		f:SetScale(p.scale)
		f:SetFrameStrata(stratas[simpleMinimap.db.profile.strata + 1])
		t:SetTextColor(p.fontR, p.fontG, p.fontB)
		t:SetText(coordString:format(99, 99))
		f:SetWidth(t:GetWidth() + 12)
		f:SetHeight(t:GetHeight() + 12)
		if p.backdrop then
			f:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 1)
		else
			f:SetBackdropColor(0, 0, 0, 0)
		end
		if p.border then
			f:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1)
		else
			f:SetBackdropBorderColor(0, 0, 0, 0)
		end
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone()
	self:ScheduleEvent("smmCoords", updateEvent, 1, self)
end

