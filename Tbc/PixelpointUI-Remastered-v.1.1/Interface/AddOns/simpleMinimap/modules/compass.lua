local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap_compass")

L:RegisterTranslations("enUS", function() return({
	compass = true,
	compass_desc = "NSEW markers on minimap",
	Ncolor = "N font color",
	Ncolor_desc = "set compass alpha for north",
	SEWcolor = "SEW font color",
	SEWcolor_desc = "set the compass font color for non-north",
	size = true,
	size_desc = "font size of compass markers",
	N = true,
	S = true,
	E = true,
	W = true
}) end)

L:RegisterTranslations("zhTW", function() return({ 
	compass = "啟用", 
	compass_desc = "在迷你地圖顯示指南針方位標示", 
	Ncolor = "<N>字體顏色", 
	Ncolor_desc = "設定<北方>字體顏色與透明度", 
	SEWcolor = "<S> <E> <W>字體顏色", 
	SEWcolor_desc = "設定<南方><東方><西方>的字體顏色", 
	size = "大小", 
	size_desc = "設定指南針標誌的字體大小", 
}) end)

L:RegisterTranslations("deDE", function() return({
	compass = "Kompass",
	compass_desc = "NSOW Himmelsrichtungsbuchstaben auf der Minimap",
	Ncolor = "N Schriftfarbe",
	Ncolor_desc = "Stellt Kompassfarbe für Norden ein",
	SEWcolor = "SOW Schriftfarbe",
	SEWcolor_desc = "Stellt die Schriftfarbe für die SOW Buchstaben ein",
	size = "Größe",
	size_desc = "Schriftgröße der Himmelsrichtungsbuchstaben",
	E = "O",
}) end)

L:RegisterTranslations("koKR", function() return({
	compass = "방위",
	compass_desc = "미니맵에 동서남북을 표시합니다.",
	Ncolor = "방향(북) 글꼴 색상",
	Ncolor_desc = "북쪽에 대한 방위의 글꼴 색상을 설정합니다.",
	SEWcolor = "방향(동서남) 글꼴 색상",
	SEWcolor_desc = "다른 방향에 대한 방위의 글꼴 색상을 설정합니다.",
	size = "글꼴 크기",
	size_desc = "방위 표시의 글꼴 크기를 설정합니다.",
	N = "북",
	S = "남",
	E = "동",
	W = "서",
}) end)

L:RegisterTranslations("zhCN", function() return({ 
	compass = "启用",
	compass_desc = "NSEW指南针标志于迷你地图上",
	Ncolor = "N字体颜色",
	Ncolor_desc = "设定<北>方向指南针的透明度",
	SEWcolor = "S E W字体颜色",
	SEWcolor_desc = "设定非<北>方向的指南针的字体颜色",
	size = "大小",
	size_desc = "设定指南针标志的字体大小",
}) end)

L:RegisterTranslations("esES", function() return({
	compass = "Br\195\186jula",
	compass_desc = "Marcadores NSEO en el minimapa",
	Ncolor = "Color de fuente de N",
	Ncolor_desc = "Establece el color de fuente para el norte",
	SEWcolor = "Color de fuente de SEO",
	SEWcolor_desc = "Establece el color de fuente para el resto",
	size = "Tamaño",
	size_desc = "Tamaño de fuente de los marcadores de la br\195\186jula",
	W = "O"
}) end)
-- Russian Translation by Ynitron, hwost, StingerSoft
L:RegisterTranslations("ruRU", function() return({
	compass = "Компас",
	compass_desc = "Отображает путевой знаки С.Ю.В.З на мини-карте",
	Ncolor = "Цвет шрифта направления С",
	Ncolor_desc = "Установка шрифта для путевого знака \"Севера\"",
	SEWcolor = "Цвет шрифта направлений ЮВЗ",
	SEWcolor_desc = "Установка цвета шрифта остальных путевых знаков исключая \"Севера\"",
	size = "Размер",
	size_desc = "Размер шрифта путевых знаков компаса",
	N = "C",
	S = "Ю",
	E = "В",
	W = "З"
}) end)

local mod = simpleMinimap:NewModule("compass")
mod.desc = L["compass_desc"]
mod.translatedName = L["compass"]

mod.options = {
	Ncolor = {
		type = "color",
		order = 10,
		name = L["Ncolor"],
		desc = L["Ncolor_desc"],
		hasAlpha = true,
		get = function()
			return mod.db.profile.Nr, mod.db.profile.Ng, mod.db.profile.Nb, mod.db.profile.Na
		end,
		set = function(r, g, b, a)
			mod.db.profile.Nr = r
			mod.db.profile.Ng = g
			mod.db.profile.Nb = b
			mod.db.profile.Na = a
			mod:UpdateScreen()
		end
	},
	SEWcolor = {
		type = "color",
		order = 11,
		name = L["SEWcolor"],
		desc = L["SEWcolor_desc"],
		hasAlpha = true,
		get = function()
			return mod.db.profile.SEWr, mod.db.profile.SEWg, mod.db.profile.SEWb, mod.db.profile.SEWa
		end,
		set = function(r, g, b, a)
			mod.db.profile.SEWr = r
			mod.db.profile.SEWg = g
			mod.db.profile.SEWb = b
			mod.db.profile.SEWa = a
			mod:UpdateScreen()
		end
	},
	size = {
		type = "range",
		order = 12,
		name = L["size"],
		desc = L["size_desc"],
		min = 10,
		max = 16,
		step = 1,
		get = function()
			return mod.db.profile.size
		end,
		set = function(x)
			mod.db.profile.size = x
			mod:UpdateScreen()
		end
	}
}

mod.defaults = {
	enabled = false,
	Nr = 0.9,
	Ng = 0.7,
	Nb = 0.3,
	Na = 1,
	SEWr = 1,
	SEWg = 1,
	SEWb = 0.6,
	SEWa = 0.6,
	size = 12
}

local directions = {
	N = "TOP",
	S = "BOTTOM",
	E = "RIGHT",
	W = "LEFT"
}

local frames = {}
function mod:OnEnable()
	local frame = simpleMinimap:GetFrame()
	if frame then
		for dir, anc in pairs(directions) do
			if not frames[dir] then
				local f = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
				f:SetPoint("CENTER", Minimap, anc)
				f:SetText(L[dir])
				f:SetShadowOffset(-1, -1)
				f:SetShadowColor(0, 0, 0, 1)
				frames[dir] = f
			end
		end
		self:UpdateScreen()
	end
end

function mod:OnDisable()
	for dir, f in pairs(frames) do
		f:Hide()
	end
end

function mod:UpdateScreen()
	if not simpleMinimap:IsModuleActive(self) then return end

	local p = self.db.profile
	for dir, f in pairs(frames) do
		f:Show()
		local fontName = f:GetFont()
		if dir == "N" then
			f:SetTextColor(p.Nr, p.Ng, p.Nb, p.Na)
			f:SetFont(fontName, p.size + 3, "OUTLINE")
		else
			f:SetTextColor(p.SEWr, p.SEWg, p.SEWb, p.SEWa)
			f:SetFont(fontName, p.size)
		end
	end
end