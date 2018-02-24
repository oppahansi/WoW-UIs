local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap_pings")

L:RegisterTranslations("enUS", function() return({
	show = "show in chat",
	show_desc = "show pings in chat instead of in a frame in the minimap",
	alpha = true,
	alpha_desc = "set ping name frame alpha",
	pings = true,
	pings_desc = "pinger name popup frame",
	position = true,
	position_desc = "position of pinger name popup frame on the minimap",
	scale = true,
	scale_desc = "set ping name frame scale",
	position1 = "bottom inside",
	position1_desc = "bottom of the minimap, inside the frame",
	position2 ="bottom outside",
	position2_desc = "bottom of the minimap, outside the frame",
	position3 = "top inside",
	position3_desc = "top of the minimap, inside the frame",
	position4 ="top outside",
	position4_desc = "top of the minimap, outside the frame",
	ping_by = "ping by"
}) end)

L:RegisterTranslations("zhTW", function() return({
	--show = "show in chat",
	--show_desc = "show pings in chat instead of in a frame in the minimap",
	alpha = "透明度", 
	alpha_desc = "設置標記者名字框體的透明度", 
	pings = "標記", 
	pings_desc = "標記者名字框體", 
	position = "位置", 
	position_desc = "座標框體在迷你地圖裏的位置", 
	scale = "尺度", 
	scale_desc = "設置標記者名字框體的尺度", 
	position1 = "內部底端", 
	position1_desc = "迷你地圖的底端, 在框體內部", 
	position2 = "外部底端", 
	position2_desc = "迷你地圖的底端, 在框體外部", 
	position3 = "內部頂端", 
	position3_desc = "迷你地圖的頂端, 在框體內部", 
	position4 = "外部頂端", 
	position4_desc = "迷你地圖的頂端, 在框體外部", 
	ping_by = "標記於" 
}) end)

L:RegisterTranslations("koKR", function() return({
	show = "대화창에서 보기",
	show_desc = "미니맵 대신에 대화창에서 핑 보기",
	alpha = "투명도",
	alpha_desc = "지정 이름 프레임 투명도 설정",
	pings = "지정",
	pings_desc = "지정자 이름 팝업 프레임",
	position = "위치",
	position_desc = "미니맴에 지정자 프레임의 위치",
	scale = "크기",
	scale_desc = "지정 이름 프레임 크기 설정",
	position1 = "내부 하단",
	position1_desc = "미니맵의 하단, 프레임 내부",
	position2 ="외부 하단",
	position2_desc = "미니맵의 하단, 프레임 외부",
	position3 = "내부 상단",
	position3_desc = "미니맵의 상단, 프레임 내부",
	position4 ="외부 상단",
	position4_desc = "미니맵의 상단, 프레임 외부",
	ping_by = "지정 : "
}) end)

L:RegisterTranslations("deDE", function() return({
	show = "Zeige im Chat",
	show_desc = "Zeigt Pings im Chat anstelle des Fensters in der Minimap",
	alpha = "Helligkeit",
	alpha_desc = "Stellt die Helligkeit des Pingfensters ein",
	pings = "Pings",
	pings_desc = "Fenster das die Namen der Spieler anzeigt, die auf der Minimap pingen",
	position = "Position",
	position_desc = "Position des Fensters auf der Minimap",
	scale = "Größenverhältnis",
	scale_desc = "Stellt das Größenverhältnis des Fensters ein",
	position1 = "Unten innen",
	position1_desc = "Unten auf der Minimap, innerhalb des Fensters",
	position2 ="Oben außerhalb",
	position2_desc = "Unten auf der Minimap, außerhalb des Fensters",
	position3 = "Oben innen",
	position3_desc = "Oben auf der Minimap, innerhalb des Fensters",
	position4 ="Oben außerhalb",
	position4_desc = "Oben auf der Minimap, außerhalb des Fensters",
	ping_by = "Gepingt von: "
}) end)

L:RegisterTranslations("zhCN", function() return({
	--show = "show in chat",
	--show_desc = "show pings in chat instead of in a frame in the minimap", 
	alpha = "透明度", 
	alpha_desc = "设置标记者名字框体的透明度", 
	pings = "标记", 
	pings_desc = "标记者名字框体", 
	position = "位置", 
	position_desc = "坐标框体在迷你地图里的位置", 
	scale = "尺度", 
	scale_desc = "设置标记者名字框体的尺度", 
	position1 = "内部底端", 
	position1_desc = "迷你地图的底端, 在框体内部", 
	position2 = "外部底端", 
	position2_desc = "迷你地图的底端, 在框体外部", 
	position3 = "内部顶端", 
	position3_desc = "迷你地图的顶端, 在框体内部", 
	position4 = "外部顶端", 
	position4_desc = "迷你地图的顶端, 在框体外部", 
	ping_by = "标记于" 
}) end)

L:RegisterTranslations("esES", function() return({
	--show = "show in chat",
	--show_desc = "show pings in chat instead of in a frame in the minimap",
	alpha = "Transparencia",
	alpha_desc = "Establece la transparencia del marco de ping",
	pings = "Pings",
	pings_desc = "Marco del nombre del que activ\195\179 el ping",
	position = "Posici\195\179n",
	position_desc = "Posici\195\179n en el minimapa de la visualizaci\195\179n del nombre del que activ\195\179 el ping",
	scale = "Escala",
	scale_desc = "Establece la escala del nombre del ping",
	position1 = "Abajo dentro",
	position1_desc = "Abajo en el minimapa, dentro del marco",
	position2 ="Abajo fuera",
	position2_desc = "Abajo en el minimapa, fuera del marco",
	position3 = "Arriba dentro",
	position3_desc = "Arriba en el minimapa, dentro del marco",
	position4 ="Arriba fuera",
	position4_desc = "Arriba en el minimapa, fuera del marco",
	ping_by = "ping por"
}) end)
-- Russian Translation by Ynitron, hwost, StingerSoft
L:RegisterTranslations("ruRU", function() return({
	show = "Показывать в чате",
	show_desc = "Показывать пинг в чате вместо фреймов на мини-карте",
	alpha = "Прозрачность",
	alpha_desc = "Установить прозрачность фрейма имени пинга",
	pings = "Пинг",
	pings_desc = "Имя пингера во всплывающем окне",
	position = "Позиция",
	position_desc = "Позиция всплывающего оккна имени пингера на мини-карте",
	scale = "Масштаб",
	scale_desc = "Установить масштаб фреймов имени пингера",
	position1 = "В нижней части-внутри",
	position1_desc = "В нижней части мини-карты, внутри фрейма мини-карты",
	position2 ="В нижней части-снаружы",
	position2_desc = "В нижней части мини-карты, снаружы фрейма мини-карты",
	position3 = "В верхней части-внутри",
	position3_desc = "В верхней части мини-карты, внутри фрейма мини-карты",
	position4 = "В верхней части-снаружы",
	position4_desc = "В верхней части мини-карты, снаружы фрейма мини-карты",
	ping_by = "Пинг"
}) end)

local positions = {
	{ "BOTTOM", "BOTTOM" },
	{ "TOP", "BOTTOM" },
	{ "TOP", "TOP" },
	{ "BOTTOM", "TOP" }
}

local mod = simpleMinimap:NewModule("pings", "AceEvent-2.0")
mod.desc = L["pings_desc"]
mod.translatedName = L["pings"]

mod.options = {
	chat = {
		type = "toggle",
		order = 10,
		name = L["show"],
		desc = L["show_desc"],
		get = function() return mod.db.profile.chat end,
		set = function(x)
			mod.db.profile.chat = x
		end
	},
	alpha = {
		type = "range",
		order = 11,
		name = L["alpha"],
		desc = L["alpha_desc"],
		disabled = function() return mod.db.profile.chat end,
		min = 0,
		max = 1,
		step = 0.05,
		isPercent = true,
		get = function() return mod.db.profile.alpha end,
		set = function(x)
			mod.db.profile.alpha = x
			mod:UpdateScreen()
		end
	},
	position = {
		type = "group",
		order = 12,
		name = L["position"],
		desc = L["position_desc"],
		disabled = function() return mod.db.profile.chat end,
		pass = true,
		get = function(key)
			return mod.db.profile.position == tonumber(key)
		end,
		set = function(key, val)
			mod.db.profile.position = tonumber(key)
			mod:UpdateScreen()
		end,
		args = {
			["1"] = {
				type = "toggle",
				order = 1,
				name = L["position1"],
				desc = L["position1_desc"],
			},
			["2"] = {
				type = "toggle",
				order = 2,
				name = L["position2"],
				desc = L["position2_desc"],
			},
			["3"] = {
				type = "toggle",
				order = 3,
				name = L["position3"],
				desc = L["position3_desc"],
			},
			["4"] = {
				type = "toggle",
				order = 4,
				name = L["position4"],
				desc = L["position4_desc"],
			}
		}
	},
	scale = {
		type = "range",
		order = 13,
		name = L["scale"],
		desc = L["scale_desc"],
		disabled = function() return mod.db.profile.chat end,
		min = 0.5,
		max = 2,
		step = 0.05,
		get = function() return mod.db.profile.scale end,
		set = function(x)
			mod.db.profile.scale = x
			mod:UpdateScreen()
		end
	}
}

mod.defaults = {
	enabled = true,
	position = 3,
	alpha = 0.9,
	scale = 0.85,
	chat = false
}

local frame = nil
local frameText = nil

function mod:OnEnable()
	if not frame then
		frame = CreateFrame("Frame", nil, MiniMapPing)
		frame:SetFrameStrata("TOOLTIP")
		frame:SetBackdrop({
			bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
			tile="true", tileSize=16, edgeSize=16,
			insets={ left=5, right=5, top=5, bottom=5 }})
		frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
		frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
		frame:SetScale(self.db.profile.scale)
		frame:SetAlpha(self.db.profile.alpha)
		frameText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frameText:SetPoint("CENTER")
	end
	self:RegisterEvent("MINIMAP_PING")
end

function mod:UpdateScreen()
	if frame and not mod.db.profile.chat then
		frame:ClearAllPoints()
		frame:SetPoint(positions[self.db.profile.position][1], "Minimap", positions[self.db.profile.position][2])
		frame:SetScale(self.db.profile.scale)
		frame:SetAlpha(self.db.profile.alpha)
	end
end

function mod:MINIMAP_PING()
	if not UnitIsUnit(arg1, "player") then
		if mod.db.profile.chat then
			DEFAULT_CHAT_FRAME:AddMessage("Minimap pinged by: |cFFFFFFCC"..UnitName(arg1))
		else
			frameText:SetText(L.ping_by.." |cFFFFFFCC"..UnitName(arg1))
			frame:SetWidth(frameText:GetWidth() + 16)
			frame:SetHeight(frameText:GetHeight() + 12)
			frame:Show()
		end
	elseif frame and not mod.db.profile.chat then
		frame:Hide()
	end
end

