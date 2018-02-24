local D = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap_gui")

L:RegisterTranslations("enUS", function() return({
	gui = "GUI",
	gui_desc = "dropdown menu options",
	mouse = "mouse button",
	mouse_desc = "mouse button that activiates the dropdown menu"
}) end)

L:RegisterTranslations("zhTW", function() return({ 
	gui = "圖形使用介面", 
	gui_desc = "顯示下拉式選單", 
	mouse = "滑鼠按鈕", 
	mouse_desc = "設定呼叫下拉式選單的滑鼠按鈕" 
}) end)

L:RegisterTranslations("koKR", function() return({
	gui = "GUI",
	gui_desc = "메뉴 설정",
	mouse = "마우스 버튼",
	mouse_desc = "마우스 버튼으로 메뉴 열기"
}) end)

L:RegisterTranslations("deDE", function() return({
	gui = "GUI",
	gui_desc = "Dropdownmenü Optionen",
	mouse = "Maustaste",
	mouse_desc = "Maustaste die das Dropdownmenü aktiviert"
}) end)

L:RegisterTranslations("zhCN", function() return({ 
	gui = "GUI", 
	gui_desc = "拖放菜单设置", 
	mouse = "鼠标按钮", 
	mouse_desc = "呼出拖放菜单的鼠标按钮" 
}) end)

L:RegisterTranslations("esES", function() return({
	gui = "Interfaz",
	gui_desc = "Opciones de men\195\186s desplegables",
	mouse = "Bot\195\179n del rat\195\179n",
	mouse_desc = "Bot\195\179n del rat\195\179n que activa el men\195\186 desplegable"
}) end)
-- Russian Translation by Ynitron, hwost, StingerSoft
L:RegisterTranslations("ruRU", function() return({
	gui = "ГИП",
	gui_desc = "Контекстное меню настроек",
	mouse = "Кнопка мыши",
	mouse_desc = "Кнопка мыши приводящая в действие контекстное меню"
}) end)

local mod = simpleMinimap:NewModule("gui", "AceHook-2.1")
mod.desc = L["gui_desc"]
mod.translatedName = L["gui"]

local buttons = { "LeftButton", "MiddleButton", "RightButton", "Button4", "Button5" }

mod.options = {
	mouse = {
		type = "group",
		order = 10,
		name = L["mouse"],
		desc = L["mouse_desc"],
		pass = true,
		get = function(key) return mod.db.profile.button == tonumber(key) end,
		set = function(key, value) mod.db.profile.button = tonumber(key) end,
		args = {
			["1"] = {
				type = "toggle",
				order = 1,
				name = buttons[1],
				desc = buttons[1],
			},
			["2"] = {
				type = "toggle",
				order = 2,
				name = buttons[2],
				desc = buttons[2],
			},
			["3"] = {
				type = "toggle",
				order = 3,
				name = buttons[3],
				desc = buttons[3],
			},
			["4"] = {
				type = "toggle",
				order = 4,
				name = buttons[4],
				desc = buttons[4],
			},
			["5"] = {
				type = "toggle",
				order = 5,
				name = buttons[5],
				desc = buttons[5],
			}
		}
	}
}

mod.defaults = {
	enabled = true,
	button = 3
}

function mod:OnEnable()
	self:HookScript(Minimap, "OnMouseUp")

	D:Register(MinimapCluster,
		'children', function()
			D:FeedAceOptionsTable(simpleMinimap:GetOptions())
		end,
		'point', function(parent)
			if parent:GetTop() < GetScreenHeight() / 2 then
				return 'BOTTOM', 'TOP'
			else
				return 'TOP', 'BOTTOM'
			end
		end,
		'cursorX', true
	)
end

function mod:OnDisable()
	D:Close()
	D:Unregister(MinimapCluster)
end

function mod:OnMouseUp(frame, button)
	if button == buttons[self.db.profile.button] then
		D:Open(MinimapCluster)
	else
		self.hooks[frame].OnMouseUp(frame, button)
	end
end

