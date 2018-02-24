local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap_skins")

L:RegisterTranslations("enUS", function() return({
	border = true,
	border_desc = "minimap border texture",
	skin = true,
	skin_desc = "minimap skin and shape",
	skins = true,
	skins_desc = "minimap skin and shape module",
	skinNames = {
		"round (default)",
		"square",
		"thin square (dark)",
		"thin square (light)",
		"top right corner",
		"top left corner",
		"bottom left corner",
		"bottom right corner"
	}
}) end)

L:RegisterTranslations("zhTW", function() return({ 
	border = "邊框", 
	border_desc = "迷你地圖的邊框材質", 
	skin = "樣式", 
	skin_desc = "迷你地圖的外觀與形狀", 
	skins = "樣式集合", 
	skins_desc = "迷你地圖的外觀與形狀", 
	skinNames = { 
		"圓形 (默認)", 
		"方形", 
		"薄的方形 (暗)", 
		"薄的方形 (亮)", 
		"方形圓角-圓弧在左下方", 
		"方形圓角-圓弧在右下方", 
		"方形圓角-圓弧在右上方", 
		"方形圓角-圓弧在左上方", 
	} 
}) end)

L:RegisterTranslations("koKR", function() return({
	border = "테두리",
	border_desc = "미니맵 테두리 텍스쳐",
	skin = "스킨",
	skin_desc = "미니맵 스킨과 외형",
	skins = "스킨들",
	skins_desc = "미니맵 스킨과 외형 모듈",
	skinNames = {
		"둥근형 (기본값)",
		"사각형",
		"가는 사각형 (어두운)",
		"가는 사각형 (밝은)",
		"우측 상단 모서리",
		"좌측 상단 모서리",
		"좌측 하단 모서리",
		"우측 하단 모서리"
	}
}) end)

L:RegisterTranslations("deDE", function() return({
	border = "Rand",
	border_desc = "Randtextur",
	skin = "Skin",
	skin_desc = "Skin und Form",
	skins = "Skins",
	skins_desc = "Modul für Minimap Skins und Formen",
	skinNames = {
		"Rund (Vorgabe)",
		"Quadrat",
		"Dünnes Quadrat (dunkel)",
		"Dünnes Quadrat (hell)",
		"Ecke oben rechts",
		"Ecke oben links",
		"Ecke unten links",
		"Ecke unten rechts"
	}
}) end)

L:RegisterTranslations("zhCN", function() return({ 
	border = "边框", 
	border_desc = "迷你地图的边框材质", 
	skin = "皮肤", 
	skin_desc = "迷你地图的皮肤与外形", 
	skins = "皮肤集合", 
	skins_desc = "迷你地图的皮肤与外形单元", 
	skinNames = { 
		"圆形 (默认)", 
		"方形", 
		"薄的方形 (暗)", 
		"薄的方形 (亮)", 
		"方形圆角-圆弧在左下方", 
		"方形圆角-圆弧在右下方", 
		"方形圆角-圆弧在右上方", 
		"方形圆角-圆弧在左上方", 
	} 
}) end)

L:RegisterTranslations("esES", function() return({
	border = "Borde",
	border_desc = "Textura del borde del minimapa",
	skin = "Skin",
	skin_desc = "Skin y forma del minimapa",
	skins = "Skins",
	skins_desc = "M\195\179dulo de skin y forma del minimapa",
	skinNames = {
		"circular (por defecto)",
		"cuadrado",
		"cuadrado fino (oscuro)",
		"cuadrado fino (claro)",
		"esquina superior derecha",
		"esquina superior izquierda",
		"esquina inferior izquierda",
		"esquina inferior derecha"
	}
}) end)
-- Russian Translation by Ynitron, hwost, StingerSoft
L:RegisterTranslations("ruRU", function() return({
	border = "Текстура рамки",
	border_desc = "Текстура рамки мини-карты",
	skin = "Шкурка",
	skin_desc = "Шкурка и вид мини-карты",
	skins = "Шкурка",
	skins_desc = "Модуль шкурки и вида мини-карты",
	skinNames = {
		"Круг (По умолчанию)",
		"Квадрат",
		"Тонкий квадрат (темный)",
		"Тонкий квадрат (светлый)",
		"Верхний правый угол",
		"Верхний левый угол",
		"Нижний левый угол",
		"Нижний правый угол"
	}
}) end)

local skins = {
	{
		shape="ROUND",
		texture="Interface\\Minimap\\UI-Minimap-Border",
		mask="Textures\\MinimapMask"
	},{
		shape="SQUARE",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimap",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\smmSquareMask"
	},{
		shape="SQUARE",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\smmSkin",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\smmSquareMask"
	},{
		shape="SQUARE",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\thinSquare2",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\smmSquareMask"
	},{
		shape="CORNER-BOTTOMLEFT",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\dLxTopRight",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\dLxTopRightMask"
	},{
		shape="CORNER-BOTTOMRIGHT",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\dLxTopLeft",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\dLxTopLeftMask"
	},{
		shape="CORNER-TOPRIGHT",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\dLxBottomLeft",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\dLxBottomLeftMask"
	},{
		shape="CORNER-TOPLEFT",
		texture="Interface\\AddOns\\simpleMinimap\\skins\\dLxBottomRight",
		mask="Interface\\AddOns\\simpleMinimap\\skins\\dLxBottomRightMask"
	}
}

local mod = simpleMinimap:NewModule("skins")
mod.desc = L["skins_desc"]
mod.translatedName = L["skins"]

mod.options = {
	border = {
		type = "toggle",
		order = 10,
		name = L.border,
		desc = L.border_desc,
		get = function() return mod.db.profile.border end,
		set = function(x) mod.db.profile.border=x mod:OnEnable() end
	},
	skin = {
		type = "group",
		order = 10,
		name = L.skin,
		desc = L.skin_desc,
		args = {}
	}
}

for i in ipairs(skins) do
	mod.options.skin.args[tostring(i)] = {
		type = "toggle",
		order = i,
		name = i..". "..L.skinNames[i],
		desc = L.skinNames[i],
		get = function() return mod.db.profile.skin == i end,
		set = function() mod.db.profile.skin = i simpleMinimap:UpdateScreen() end
	}
end

mod.defaults = {
	enabled = true,
	skin = 1,
	border = true
}

function mod:OnEnable()
	simpleMinimap.GetButtonPos = function(simpleMinimap, vector)
		local r = true
		local v = math.rad(vector)
		local x, y = math.cos(v), math.sin(v)
		local o = 80 + simpleMinimap.db.profile.radius
		if simpleMinimap:IsModuleActive('skins') then
			local s = self:GetShape()
			if(s and ((s=="SQUARE") or
					(s=="CORNER-BOTTOMLEFT" and (x>0 or y>0)) or
					(s=="CORNER-BOTTOMRIGHT" and (x<0 or y>0)) or
					(s=="CORNER-TOPLEFT" and (x>0 or y<0)) or
					(s=="CORNER-TOPRIGHT" and (x<0 or y<0)))) then
				r = false
			end
		end
		if r then
			return x * o, y * o
		else
			x = math.max(o * -1, math.min(110 * x, o))
			y = math.max(o * -1, math.min(110 * y, o))
			return x, y
		end
	end
	simpleMinimap:UpdateScreen()
end

function mod:OnDisable()
	MinimapBorder:SetTexture("Interface\\Minimap\\UI-Minimap-Border")
	Minimap:SetMaskTexture("Textures\\MinimapMask")
	Minimap.smmSkinned = nil
end

function mod:UpdateScreen()
	if self.db.profile.border then
		MinimapBorder:SetTexture(skins[self.db.profile.skin].texture)
	else
		MinimapBorder:SetTexture(nil)
	end
	Minimap:SetMaskTexture(skins[self.db.profile.skin].mask)
end

function mod:GetShape()
	if self and self.db.profile.enabled then
		return skins[self.db.profile.skin].shape
	end
end

-- used for Fubar and Gatherer
function GetMinimapShape() return mod:GetShape() end

