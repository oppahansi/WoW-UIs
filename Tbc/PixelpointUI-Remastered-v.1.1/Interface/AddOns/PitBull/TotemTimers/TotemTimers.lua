if not _G.UnitClassBase then
	-- don't load if not running at least engine 2.4
	return
end

if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass("player")) ~= "SHAMAN" then
	-- don't load if player is not a shaman.
	return
end

local VERSION = tonumber(("$Revision: 70036 $"):match("%d+"))

local PitBull = PitBull
local PitBull_TotemTimers = PitBull:NewModule("TotemTimers", "LibRockEvent-1.0", "LibRockTimer-1.0")
local self = PitBull_TotemTimers
PitBull:ProvideVersion("$Revision: 70036 $", "$Date: 2008-04-16 07:10:13 -0400 (Wed, 16 Apr 2008) $")
local MetaLayout = PitBull.MetaLayout

local MAX_TOTEMS = MAX_TOTEMS or 4 -- comes from blizzard's totem frame lua
local FIRE_TOTEM_SLOT  = FIRE_TOTEM_SLOT  or 1
local EARTH_TOTEM_SLOT = EARTH_TOTEM_SLOT or 2
local WATER_TOTEM_SLOT = WATER_TOTEM_SLOT or 3
local AIR_TOTEM_SLOT   = AIR_TOTEM_SLOT   or 4
local _G = _G
local GetTime = _G.GetTime
local floor = math.floor
local ceil = math.ceil
local fmod = math.fmod
local max = math.max
local min = math.min
local fmt = string.format
local GetTotemTimeLeft = GetTotemTimeLeft
local GetTotemInfo = GetTotemInfo
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame


local border_path
do
	local path = "Interface\\AddOns\\" .. _G.debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z0-9]-%.lua")
	border_path = path .. "\\border"
end

local localization = (GetLocale() == "koKR") and {
	["Shows Totem timers for the Pitbull player frame."] = "PitBull 플레이어 프레임에 대해 토템 타이머를 보여줍니다.",
	["Fire"] = "불",
	["Earth"] = "대지",
	["Water"] = "물",
	["Air"] = "바람",
	["Unknown Slot "] = "알 수 없는 칸",
	["ERROR: getSlotFromOrder failed to find slot for pos "] = "오류: getSlotFromOrder 스크립트 실행중에 위치를 위한 칸을 찾는데 실패하였습니다. 위치: ",
	["Position %i (Currently: %s)"] = "위치 %i (현재: %s)",
	["Totem Timers"] = "토템 타이머",
	["Totem timers for this unit type."] = "이 유닛 유형을 위한 토템 타이머를 설정합니다.",
	["Enable"] = "활성화",
	["Enables the Totem timers."] = "토템 타이머를 활성화합니다.",
	["Totem Size"] = "토템 크기",
	["Sets the size of the individual totem icons."] = "토템 아이콘의 개별적인 크기를 설정합니다.",
	["Totem Spacing"] = "토템 간격",
	["Sets the size of the gap between the totem icons."] = "각 토템 아이콘 사이의 간격 크기를 설정합니다.",
	["Totem Direction"] = "토템 방향",
	["Choose wether to grow horizontally or vertically."] = "토템의 확장 방향을 가로 또는 세로로 할것인지 선택합니다.",
	["Horizontal"] = "가로",
	["Vertical"] = "세로",
	["Totems per line"]= "열당 토템",
	["How many totems to draw per line."] = "열당 그려낼 토템의 갯수를 설정합니다.",
	["Totem Tooltips"] = "토템 툴팁",
	["Enables tooltips when hovering over the icons."] = "아이콘에 마우스-오버시 툴팁을 활성화합니다.",
	["Hide inactive"] = "비활성 토템 숨김",
	["Hides inactive totem icons completely."] = "비활성 토템 아이콘은 완전히 숨기게 합니다.",
	["Expiry pulse"] = "종료 맥박",
	["Causes the icon to pulse in the last few seconds of its lifetime."] = "완료되기 마지막 몇초전에 아이콘의 맥박을 발생시키게 합니다.",
	["Expiry time"] = "종료 시간",
	["Pulse for this many seconds before the totem runs out."] = "맥박이 발생할 토템의 완료되기전 초수를 설정합니다.",
	["Background Color"] = "배경 색상",
	["Sets the color and transparency of the background of the timers."] = "타이머 배경의 색상과 투명도를 설정합니다.",
	["Border Color"] = "테두리 색상",
	["Sets the bordercolor of the individual icons."] = "토템 아이콘의 개별적인 테두리 색상을 설정합니다.",
	["Frame Offset X"] = "프레임의 X 좌표",
	["Shifts the window to the left or to the right of the set anchorpoint."] = "설정 앵커 지점의 좌측이나 우측으로 창의 위치를 바꿉니다.",
	["Frame Offset Y"] = "프레임의 Y 좌표",
	["Shifts the window above or below the set anchorpoint."] = "설정 앵커 지점의 상단이나 하단으로 창의 위치를 바꿉니다.",
	["Spiral Timer"] = "타이머 나선형 표시",
	["Options relating to the spiral display timer."] = "타이머를 나선형으로 표시하는데 관련된 옵션입니다.",
	["Timer Spiral"] = "나선형의 타이머",
	["Shows the pie-like cooldown spiral on the icons."] = "아이콘에 블리자드의 나선형 재사용 대기시간 표시를 보여줍니다.",
	["Suppress OmniCC"] = "OmniCC 숨김",
	["Suppresses OmniCC on the spiral timer. (Requires UI reload to change the setting!)"] = "나선형의 타이머에 OmniCC의 표시를 막습니다. (설정을 변경하려면 UI 재실행이 필요합니다!)",
	["Text Timer"] = "타이머 문자",
	["Options relating to the text display timer."] = "타이머에 문자를 표시하는데 관련된 옵션입니다.",
	["Timer Text"] = "타이머 문자",
	["Shows the remaining time in as text."] = "남은 시간을 문자로 보여줍니다.",
	["Text Color"] = "문자 색상",
	["Color of the timer text."] = "타이머 문자의 색상을 설정합니다.",
	["Text Side"] = "문자 측면",
	["Which side to position the timer text at."] = "타이머 문자가 위치할 측면을 선택합니다.",
	["Top, Inside"] = "상단, 안쪽측면",
	["Top, Outside"] = "상단, 바깥측면",
	["Bottom, Inside"] = "하단, 안쪽측면",
	["Bottom, Outside"] = "하단, 바깥측면",
	["Left, Outside"] = "좌측, 바깥측면",
	["Right, Outside"] = "우측, 바깥측면",
	["Middle"] = "중간",
	["Text Scale"] = "문자 크기",
	["Change the scaling of the text timer. Note: It's relative to PitBull's font size."] = "타이머 문자의 크기를 변경합니다. 주의: 이것은 PitBull의 글꼴 크기에 비례합니다.",
	["Order"] = "순위",
	["The order in which the elements appear."] = "토템의 각 구성 요소가 나타나는 순위를 설정합니다.",
} or (GetLocale() == "deDE") and {
	["Shows Totem timers for the Pitbull player frame."] = "Zeigt Totem Timer für den Spieler-Rahmen.",
	["Totem Timers"] = "Totem Timer",
	["Totem timers for this unit type."] = "Totem Timer für diesen Einheintentyp.",
	["Enable"] = "Aktivieren",
	["Enables the Totem timers."] = "Aktiviert die Totem Timer",
	["Totem Size"] = "Totem Grösse",
	["Sets the size of the individual totem icons."] = "Setzt die Grösse der einzelnen Totem Icons",
	["Totem Spacing"] = "Totem Abstand",
	["Sets the size of the gap between the totem icons."] = "Setzt den Abstand zwischen den Totem Icons.",
	["Totem Direction"] = "Totem Richtung",
	["Choose wether to grow horizontally or vertically."] = "Setzt das Wachstum horizontal oder vertikal.",
	["Horizontal"] = "Horizontal",
	["Vertical"] = "Vertikal",
	["Totem Tooltips"] = "Totem Tooltips", -- How are tooltips called in the german client?
	["Enables tooltips when hovering over the icons."] = "Zeigt tooltips when über die Symbole gefahren wird.",
	["Background Color"] = "Hintergrundfarbe",
	["Sets the color and transparency of the background of the timers."] = "Setzt die Hintergrundfarbe und die Transparenz des Hintergrunds der Timer.",
	["Border Color"] = "Rahmenfarbe",
	["Sets the bordercolor of the individual icons."] = "Setzt die Rahmenfarbe der einzelnen Elemente.",
	["Frame Offset X"] = "Rahmenversatz X-Achse",
	["Shifts the window to the left or to the right of the set anchorpoint."] = "Verschiebt das Fenster nach Links oder Rechts des angegebenen Ankerpunktes.",
	["Frame Offset Y"] = "Rahmenversatz Y-Achse",
	["Shifts the window above or below the set anchorpoint."] = "Verschiebt das Fenster über oder unter den angegebenen Ankerpunkt.",
	["Spiral Timer"] = "Spiraltimer",
	["Options relating to the spiral display timer."] = "Optionen des Spiraltimers.",
	["Timer Spiral"] = "Spiraltimer",
	["Shows the pie-like cooldown spiral on the icons."] = "Zeigt den Kuchen-ähnlichen Spiraltimer auf den Symbolen.",
	["Suppress OmniCC"] = "OmniCC unterdrücken",
	["Suppresses OmniCC on the spiral timer. (Requires UI reload to change the setting!)"] = "Unterdrückt OmniCC auf dem Spiraltimer. (UI muss neu geladen werden um aktiv zu werden!)",
	["Text Timer"] = "Text Timer",
	["Options relating to the text display timer."] = "Optionen des textbasierten Timers.",
	["Timer Text"] = "Timer Text",
	["Shows the remaining time in as text."] = "",
	["Text Color"] = "Textfarbe",
	["Color of the timer text."] = "Farbe der Timer Texte",
	["Text Side"] = "Textseite",
	["Which side to position the timer text at."] = "",
	["Top, Inside"] = "Oben, Innen",
	["Top, Outside"] = "Oben, Aussen",
	["Bottom, Inside"] = "Unten, Innen",
	["Bottom, Outside"] = "Unten, Aussen",
	["Left, Outside"] = "Links, Aussen",
	["Right, Outside"] = "Rechts, Aussen",
	["Middle"] = "Mitte",
	["Text Scale"] = "Textskalierung",
	["Change the scaling of the text timer. Note: It's relative to PitBull's font size."] = "Ändert die Skalierung des Text Timers. Beachte: Der Wert ist relativ zu PitBull's Schriftgrösse.",
	["Order"] = "Reihenfolge",
	["The order in which the elements appear."] = "¨Die Reihenfolge in welcher die Elemente dargestellt werden.",
	["Fire"] = "Feuer",
	["Earth"] = "Erde",
	["Water"] = "Wasser",
	["Air"] = "Luft",
	["Totems per line"] = "Totems pro Linie",
	["How many totems to draw per line."] = "Wieviele Totems in einer Linie dargestellt werden.",
	["Hide inactive"] = "Inaktive verstecken",
	["Hides inactive totem icons completely."] = "Versteckt inaktive Symbole komplett.",
	["Expiry pulse"] = "Ablaufwarnung",
	["Causes the icon to pulse in the last few seconds of its lifetime."] = "Pulsiert das jeweilige Symbol in den letzten Sekunden vor dem Ablaufen.",
	["Expiry time"] = "Ablaufzeit",
	["Pulse for this many seconds before the totem runs out."] = "Pulsiert so viele Sekunden vor dem Ablaufen.",
	["Position %i (Currently: %s)"] = "Position %i (Momentan: %s)",
	["ERROR: getSlotFromOrder failed to find slot for pos "] = "FEHLER: getSlotFromOrder konnte kein Element finden für Position ",
} or (GetLocale() == "zhCN") and {
	["Shows Totem timers for the Pitbull player frame."] = "为PitBull玩家框体显示图腾计时器。",
	["Fire"] = "火",
	["Earth"] = "地",
	["Water"] = "水",
	["Air"] = "风",
	["Unknown Slot "] = "未知位置 ",
	["ERROR: getSlotFromOrder failed to find slot for pos "] = "错误: getSlotFromOrder命令无法找到位置 ",
	["Position %i (Currently: %s)"] = "位置 %i (当前: %s)",
	["Totem Timers"] = "图腾计时器",
	["Totem timers for this unit type."] = "对该单位的图腾计时器。",
	["Enable"] = "启用",
	["Enables the Totem timers."] = "启用图腾计时器。",
	["Totem Size"] = "图腾大小",
	["Sets the size of the individual totem icons."] = "设置独立的图腾图标大小。",
	["Totem Spacing"] = "图腾间距",
	["Sets the size of the gap between the totem icons."] = "设置图腾图标间的距离。",
	["Totem Direction"] = "图腾方向",
	["Choose wether to grow horizontally or vertically."] = "设置图腾延展的方向(水平或者垂直)。",
	["Horizontal"] = "水平",
	["Vertical"] = "垂直",
	["Totems per line"]= "每行图腾数",
	["How many totems to draw per line."] = "每行可以放置多少图腾。",
	["Totem Tooltips"] = "图腾提示",
	["Enables tooltips when hovering over the icons."] = "启用图腾图标的鼠标悬停提示。",
	["Hide inactive"] = "隐藏未激活",
	["Hides inactive totem icons completely."] = "完全隐藏那些不在使用的图腾图标。",
	["Allow Recasting"] = "允许重新施法",
	["This enables the *EXPERIMENTAL* recast support. Leftclick on an Icon to redrop the last totem. WARNING: When you change the type of totem during combat it will not redrop the totem you would expect until after combat ends!"] = "这个全选允许你重新施放图腾，左键点击图标施放上次施放的图腾。警告：当你在战斗中更改图腾的后，该选项将可能施放错误的图腾，直到战斗结束后方可正常（BLZ的安全模板造成的）！",
	["Expiry pulse"] = "过期警告",
	["Causes the icon to pulse in the last few seconds of its lifetime."] = "当图腾即将过期前几秒闪烁图腾图标。",
	["Expiry time"] = "过期时间",
	["Pulse for this many seconds before the totem runs out."] = "在图腾过钱前多少秒开始闪烁图标。",
	["Background Color"] = "背景色",
	["Sets the color and transparency of the background of the timers."] = "设置计时器的背景颜色和透明度。",
	["Border Color"] = "边框颜色",
	["Sets the bordercolor of the individual icons."] = "设置每个图标的边框颜色。",
	["Frame Offset X"] = "框体X轴偏移量",
	["Shifts the window to the left or to the right of the set anchorpoint."] = "设置窗体向左或者向右移动。",
	["Frame Offset Y"] = "框体Y轴偏移量",
	["Shifts the window above or below the set anchorpoint."] = "设置窗体向上或者向下移动。",
	["Spiral Timer"] = "图形计时器",
	["Options relating to the spiral display timer."] = "设置计时器图形的相关选项。",
	["Timer Spiral"] = "计时图形",
	["Shows the pie-like cooldown spiral on the icons."] = "显示饼形图式的倒计时。",
	["Suppress OmniCC"] = "禁用OmniCC",
	["Suppresses OmniCC on the spiral timer. (Requires UI reload to change the setting!)"] = "在启用饼形图式的计时器时禁用OmniCC。(需要重载插件后生效！)",
	["Text Timer"] = "文本计时器",
	["Options relating to the text display timer."] = "设置计时器文本的相关选项。",
	["Timer Text"] = "计时文本",
	["Shows the remaining time in as text."] = "以倒计时形式显示文本。",
	["Text Color"] = "文本颜色",
	["Color of the timer text."] = "计时器文字的颜色。",
	["Text Side"] = "文字位置",
	["Which side to position the timer text at."] = "设置计时器文字的放置位置。",
	["Top, Inside"] = "内侧上方",
	["Top, Outside"] = "外侧上方",
	["Bottom, Inside"] = "内侧下方",
	["Bottom, Outside"] = "外侧下方",
	["Left, Outside"] = "外侧左方",
	["Right, Outside"] = "外侧右方",
	["Middle"] = "中间",
	["Text Scale"] = "文本缩放",
	["Change the scaling of the text timer. Note: It's relative to PitBull's font size."] = "设置文本计时器文字的大小。注意：本选项相对于PitBull的字体大小选项。",
	["Order"] = "顺序",
	["The order in which the elements appear."] = "设置图腾元素的排列顺序。",
} or (GetLocale() == "zhTW") and {
	["Shows Totem timers for the Pitbull player frame."] = "PitBull圖騰計時器框架.",
	["Fire"] = "火",
	["Earth"] = "地",
	["Water"] = "水",
	["Air"] = "風",
	["Unknown Slot "] = "未知位置 ",
	["ERROR: getSlotFromOrder failed to find slot for pos "] = "錯誤: getSlotFromOrder無法找到位置 ",
	["Position %i (Currently: %s)"] = "位置 %i (當前: %s)",
	["Totem Timers"] = "圖騰計時器",
	["Totem timers for this unit type."] = "對此單位框架使用圖騰計時器.",
	["Enable"] = "啟用",
	["Enables the Totem timers."] = "啟用圖騰計時器.",
	["Totem Size"] = "圖騰大小",
	["Sets the size of the individual totem icons."] = "設定各別的圖騰圖示大小.",
	["Totem Spacing"] = "圖騰間距",
	["Sets the size of the gap between the totem icons."] = "設定圖騰圖示間的距離.",
	["Totem Direction"] = "圖騰方向",
	["Choose wether to grow horizontally or vertically."] = "設定圖騰的延展方向(水平或垂直).",
	["Horizontal"] = "水平",
	["Vertical"] = "垂直",
	["Totems per line"]= "每行圖騰數",
	["How many totems to draw per line."] = "每行可放置多少圖騰.",
	["Totem Tooltips"] = "圖騰提示",
	["Enables tooltips when hovering over the icons."] = "啟用滑鼠停留圖騰圖示時的提示訊息.",
	["Hide inactive"] = "隱藏未啟用",
	["Hides inactive totem icons completely."] = "隱藏那些未啟用的圖騰圖示.",
	["Background Color"] = "背景顏色",
	["Sets the color and transparency of the background of the timers."] = "設定計時器的背景顏色和透明度.",
	["Border Color"] = "外框顏色",
	["Sets the bordercolor of the individual icons."] = "設定各別的圖騰圖示外框顏色.",
	["Frame Offset X"] = "框體X軸偏移量",
	["Shifts the window to the left or to the right of the set anchorpoint."] = "設定框體向左或向右移動.",
	["Frame Offset Y"] = "框體Y軸偏移量",
	["Shifts the window above or below the set anchorpoint."] = "設定框體向上或向下移動.",
	["Spiral Timer"] = "圖形計時器",
	["Options relating to the spiral display timer."] = "設定圖形計時器的相關選項.",
	["Timer Spiral"] = "計時圖形",
	["Shows the pie-like cooldown spiral on the icons."] = "顯示圓餅圖式的倒數計時.",
	["Suppress OmniCC"] = "停用OmniCC",
	["Suppresses OmniCC on the spiral timer. (Requires UI reload to change the setting!)"] = "在啟用圓餅圖式的倒數計時停用OmniCC. (重載插件後生效!)",
	["Text Timer"] = "文字計時器",
	["Options relating to the text display timer."] = "設定文字計時器的相關選項.",
	["Timer Text"] = "計時文字",
	["Shows the remaining time in as text."] = "以倒數計時的方式顯示.",
	["Text Color"] = "文字顏色",
	["Color of the timer text."] = "計時器文字的顏色.",
	["Text Side"] = "文字位置",
	["Which side to position the timer text at."] = "設定計時器文字的位置.",
	["Top, Inside"] = "上, 內部",
	["Top, Outside"] = "上, 外部",
	["Bottom, Inside"] = "下, 內部",
	["Bottom, Outside"] = "下, 外部",
	["Left, Outside"] = "左, 外部",
	["Right, Outside"] = "右, 外部",
	["Middle"] = "中間",
	["Text Scale"] = "文字縮放",
	["Change the scaling of the text timer. Note: It's relative to PitBull's font size."] = "設定文字計時器的字型大小. 注意: 它與PitBull字體大小相關聯.",
	["Order"] = "順序",
	["The order in which the elements appear."] = "設定圖騰元素的排列順序.",
} 

local L = PitBull:L("PitBull-TotemTimers", localization)
self.desc = L["Shows Totem timers for the Pitbull player frame."]



self:RegisterPitBullChildFrames('totemTimersFrame')
-- We act as a PitBullIcon. why? because it makes PB give us nice alignment options
-- TODO: find a way to only get the alignment option and not the sizing one
self:RegisterPitBullIconLayoutHandler('totemTimersFrame', 7)

local unitsShown = {}


local function getVerboseSlotName(slot)
	if slot == FIRE_TOTEM_SLOT then
		return L["Fire"]
	elseif slot == EARTH_TOTEM_SLOT then
		return L["Earth"]
	elseif slot == WATER_TOTEM_SLOT then
		return L["Water"]
	elseif slot == AIR_TOTEM_SLOT then
		return L["Air"]
	else
		return L["Unknown Slot "]..tostring(slot)
	end
end

-- make tedious searching for the elements array at a central spot, happens often below.
local function returnElements()
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.totemTimersFrame and frame.totemTimersFrame.elements then
			return frame.totemTimersFrame.elements
		else 
			return nil
		end
	end
	return nil
end

---------------------------------------------------------------------------
-- CONFIGURATION FUNCTIONS
local function getHide()
	return self.db.profile.hidden
end
local function getEnabled()
	return not self.db.profile.hidden
end
local function setEnabled(value)
	value = not value
	self.db.profile.hidden = value
	
	if self:HasTimer("pbtotemtimerall") then
		self:RemoveTimer("pbtotemtimerall")
	end
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if value then
			self:OnClearUnitFrame("player", frame)
		else
			self:OnPopulateUnitFrame("player", frame)
			self:OnUpdateFrame("player", frame)
		end
		PitBull:UpdateLayout(frame)
	end
end

local function getTotemDirection()
	return self.db.profile.totemdirection
end
local function setTotemDirection(value)
	self.db.profile.totemdirection = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		self:RealignTotems(frame)
	end
	
	return true
end

local function getTotemSize()
	return self.db.profile.totemsize
end
local function setTotemSize(value)
	self.db.profile.totemsize = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.totemTimersFrame then
			local elements = frame.totemTimersFrame.elements
			for i=1, MAX_TOTEMS do
				elements[i].frame:SetHeight(value)
				elements[i].frame:SetWidth(value)
				elements[i].text:SetWidth(value)
				elements[i].text:SetHeight((value/3))
			end
			self:ResizeMainFrame(frame)
		end
	end
	
	return true
end

local function getTotemSpacing()
	return self.db.profile.totemspacing
end
local function setTotemSpacing(value)
	self.db.profile.totemspacing = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		self:RealignTotems(frame)
	end
	
	return true
end

local function getTotemLinebreak()
	return self.db.profile.linebreak
end
local function setTotemLinebreak(value)
	self.db.profile.linebreak = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		self:RealignTotems(frame)
	end
	
	return true
end

local function setOffset(k,v)
	self.db.profile[k] = v
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.totemTimersFrame then
			self:FixAnchoring(frame.totemTimersFrame)
		end
	end
	
	return true
end

local function getMainBGColor()
	return unpack(self.db.profile.mainbgcolor)
end
local function setMainBGColor(r,g,b,a)
	self.db.profile.mainbgcolor = {r, g, b, a}
	
	-- Apply color to existing background
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.totemTimersFrame then
			frame.totemTimersFrame.texture:SetTexture(r,g,b,a)
		end
	end
	return true
end

local function setIconBorderColor(k, r, g, b, a)
	self.db.profile[k] = {r, g, b, a}
	
	-- Apply color to existing borders
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.totemTimersFrame and frame.totemTimersFrame.elements then
			local elements = frame.totemTimersFrame.elements
			for i=1, MAX_TOTEMS do
				if elements[i].frame and elements[i].frame.border then
					elements[i].frame.border:SetVertexColor(r, g, b, a)
				end
			end
		end
	end
end

local function getTimerTextColor()
	return unpack(self.db.profile.timertextcolor)
end
local function setTimerTextColor(r,g,b,a)
	self.db.profile.timertextcolor = {r, g, b, a}
	
	-- Apply color to existing strings
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if frame.totemTimersFrame and frame.totemTimersFrame.elements then
			local elements = frame.totemTimersFrame.elements
			for i=1, MAX_TOTEMS do
				if elements[i].text then
					elements[i].text:SetTextColor(r,g,b,a)
				end
			end
		end
	end
	return true
end

local function getTimerTextSide()
	return self.db.profile.timertextside
end
local function setTimerTextSide(value)
	self.db.profile.timertextside = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		self:RealignTimerTexts(frame)
	end
	
	return true
end

local function getHideInactive()
	return self.db.profile.hideinactive
end
local function setHideInactive(v)
	self.db.profile.hideinactive = v
	
	if (v == true) then
		setGenericSingleValue('recastenabled', false)
	end
end

local function getTimerTextScale()
	return self.db.profile.timertextscale
end
local function setTimerTextScale(value)
	self.db.profile.timertextscale = value
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		self:RealignTimerTexts(frame)
	end
	
	return true
end

local function getOrderDefault()
	-- usually 4 but this is dynamic incase blizzard adds a new family somewhen
	local order = {}
	for i=1, MAX_TOTEMS do
		order[i] = i
	end
	return order
end
local function getOrder(slot)
	return self.db.profile.order[slot]
end
local function getOrderAsString(slot)
	return tostring(getOrder(slot))
end
local function getSlotFromOrder(pos)
	for k,v in ipairs(self.db.profile.order) do
		if v == pos then
			return k
		end
	end
	PitBull:Print(L["ERROR: getSlotFromOrder failed to find slot for pos "]..tostring(pos))
	return nil -- this shouldn't ever happen
end
local function listOrder(slot)
	if not slot then
		local slot = -1
	end
	local choices = {}
	for i=1, MAX_TOTEMS do
		choices[tostring(i)] = fmt(L["Position %i (Currently: %s)"], i,getVerboseSlotName(getSlotFromOrder(i)))
	end
	return choices
end
local function setOrder(slot, neworderposstring)
	local neworderpos = tonumber(neworderposstring)
	for i=1, MAX_TOTEMS do
		if not (i == slot) then
			if self.db.profile.order[i] == neworderpos then
				-- switch the position with the element that had it earlier
				self.db.profile.order[i] = getOrder(slot)
				self.db.profile.order[slot] = neworderpos
				break
			end
		end
	end
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		self:RealignTotems(frame)
	end
	return true
end

local function getGenericOption(k)
	return self.db.profile[k]
end
local function setGenericSingleValue(k, v)
	self.db.profile[k] = v
end
local function getGenericColor(k)
	return unpack(self.db.profile[k])
end
local function setGenericColor(k,r,g,b,a)
self.db.profile[k] = {r, g, b, a}
end
--------------------------------------------------------------------------------
-- this function is borrowed from Got Wood which got it from neronix. 
function PitBull_TotemTimers:SecondsToTimeAbbrev(time)
	local m, s
	if( time < 0 ) then
		text = ""
	elseif( time < 3600 ) then
		m = floor(time / 60)
		s = fmod(time, 60)
		if (m==0) then 
			text = fmt("0:%02d", s)
		else
			text = fmt("%01d:%02d", m, s)
		end
	end
	return text
end

------------------------------------------------------------
-- Totem Logic

function PitBull_TotemTimers:OneOrMoreDown()
	--local self = PitBull_TotemTimers
	for i=1, MAX_TOTEMS do
		if ( self.totemIsDown[i] == true ) then
			return true
		end
	end
	-- none is down
	return false
end

function PitBull_TotemTimers:StartTimer()
	if not self:HasTimer("pbtotemtimerall") then
		self:AddRepeatingTimer("pbtotemtimerall", 0.25, function() PitBull_TotemTimers:UpdateAllTimes() end)
	end
end

function PitBull_TotemTimers:StopTimer()
	if self:HasTimer("pbtotemtimerall") then
		self:RemoveTimer("pbtotemtimerall")
	end
end

function PitBull_TotemTimers:StartPulse(frame) -- starts a continuous pulse
	frame.pulseStopAfterThis = false
	frame.pulseStart = true
	frame.lastUpdated = 0
	if frame:GetScript("OnUpdate") == nil then
		--PitBull:Print("DEBUG: Added OnUpdate handlder")
		frame:SetScript("OnUpdate", self.ButtonOnUpdate)
	end
end

function PitBull_TotemTimers:StartPulseOnce(frame) -- starts a single pulse
	frame.pulseStopAfterThis = true
	frame.pulseStart = true
	frame.lastUpdated = 0
	if frame:GetScript("OnUpdate") == nil then
		--PitBull:Print("DEBUG: Added OnUpdate handlder")
		frame:SetScript("OnUpdate", self.ButtonOnUpdate)
	end
end

function PitBull_TotemTimers:StopPulse(frame)
	frame.pulseStopAfterThis = false
	frame.pulseStart = false
	frame.pulseActive = false
	if frame.pulse.icon:IsVisible() then
		frame.pulse.icon:Hide()
	end
	frame.lastUpdated = 0
	if frame:GetScript("OnUpdate") ~= nil then
		--PitBull:Print("DEBUG: Removed OnUpdate handlder")
		frame:SetScript("OnUpdate", nil)
	end
end


function PitBull_TotemTimers:UpdateAllTimes()
	local mf = nil
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		mf = frame
	end
	
	if (not mf) or (not mf.totemTimersFrame) or (not mf.totemTimersFrame.elements) then
		PitBull:Print("ERROR: Update time called but no Totemtimer Frame initialized.")
		--self:StopTimer()
		return
	end
	
	local elements = mf.totemTimersFrame.elements
	
	local nowTime = floor(GetTime())
	for slot=1, MAX_TOTEMS do
		if (not elements) or (not elements[slot]) or (not elements[slot].frame) then return end
		
		--local endTime = self.startTimes[slot] + self.durations[slot]
		--local timeleft = endTime - nowTime
		local timeleft = GetTotemTimeLeft(slot)
		--PitBull:Print(string.format("now = %f, start = %f, duration = %d",nowTime,self.startTimes[slot], self.durations[slot]))
		
		if timeleft > 0 then
			-- need to update shown time
			if ( getGenericOption('timertext') ) then
				elements[slot].text:SetText(self:SecondsToTimeAbbrev(timeleft))
			else
				elements[slot].text:SetText("")
			end
			-- Hide the cooldown frame if it's shown and the user changed preference
			if ( not getGenericOption('timerspiral') and elements[slot].spiral:IsShown() ) then
				elements[slot].spiral:Hide()
			end
			
			if getGenericOption('expirypulse') and (timeleft < getGenericOption('expirypulsetime')) and (timeleft > 0) then
				--elements[slot].frame.pulseStart = true
				--elements[slot].frame.lastUpdate = 0
				self:StartPulse(elements[slot].frame)
			else
				--elements[slot].frame.pulseStart = false
				--elements[slot].frame.pulseActive = false
				--if elements[slot].frame.pulse.icon:IsVisible() then
				--	elements[slot].frame.pulse.icon:Hide()
				--end
				self:StopPulse(elements[slot].frame)
			end
		else
			-- Totem expired
			
			--elements[slot].frame.pulseStart = false
			--elements[slot].frame.pulseActive = false
			--elements[slot].frame.lastUpdate = 0
			self:StopPulse(elements[slot].frame)
			elements[slot].frame:SetAlpha(0.5)
			if getGenericOption('hideinactive') then
				elements[slot].frame:Hide()
			end
			elements[slot].text:SetText("")
			elements[slot].spiral:Hide()
		end	
	end
end

function PitBull_TotemTimers:ActivateTotem(slot)
	--local self = PitBull_TotemTimers
	local haveTotem, name, startTime, duration, icon = GetTotemInfo(slot)
	-- queried seperately because GetTotemInfo apprears to give less reliable results (wtf?!)
	local timeleft = GetTotemTimeLeft(slot)
	
	if ( name == "" ) then
		PitBull:Print("WARNING: Can't activate a nondropped totem")
		return
	end
	
	self.totemIsDown[slot] = true
	self.startTimes[slot] = startTime
	self.durations[slot] = duration
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if not frame.totemTimersFrame then
			return
		end

		local tframe = frame.totemTimersFrame.elements[slot].frame
		local ttext = frame.totemTimersFrame.elements[slot].text
		local tspiral = frame.totemTimersFrame.elements[slot].spiral
		
		tframe:SetNormalTexture(icon)
		tframe.totemIcon = icon
		tframe:SetAlpha(1)
		tframe:Show()
		
		--tframe.pulse.icon:Hide()
		self:StopPulse(tframe)
		
		--tframe.border:SetVertexColor(getGenericColor("iconbordercolor"))
		tframe.border:Show()
		if ( getGenericOption('timertext') ) then
			ttext:SetText(self:SecondsToTimeAbbrev(timeleft))
		end
		tspiral:SetCooldown(startTime, timeleft)
		if ( getGenericOption('timerspiral') ) then
			tspiral:Show()
		else
			tspiral:Hide()
		end
		
		self:StartTimer()
	end
end



function PitBull_TotemTimers:DeactivateTotem(slot)
	--local self = PitBull_TotemTimers
	local haveTotem, name, startTime, duration, icon = GetTotemInfo(slot)
	
	if ( name ~= "" ) then
		PitBull:Print("WARNING: Can't deactivate a dropped totem")
		return
	end
	
	self.totemIsDown[slot] = false
	self.startTimes[slot] = 0
	self.durations[slot] = 0
	
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if not frame.totemTimersFrame then
			return
		end

		local tframe = frame.totemTimersFrame.elements[slot].frame
		local ttext = frame.totemTimersFrame.elements[slot].text
		local tspiral = frame.totemTimersFrame.elements[slot].spiral
		
		-- cleanup timer event if no totems are down
		if not self:OneOrMoreDown() then
			self:StopTimer()
		end
		tspiral:Hide()
		
		--tframe.pulseStart = true
		--tframe.lastUpdate = 0
		self:StopPulse(tframe)
		
		
		tframe:SetAlpha(0.5)
		if getGenericOption('hideinactive') then
			tframe:Hide()
		end
		ttext:SetText("")
	end
end


function PitBull_TotemTimers:GetTotemStatus()
	--local self = PitBull_TotemTimers
	for i=1, MAX_TOTEMS do
		local haveTotem, name, startTime, duration, icon = GetTotemInfo(i)
		if (name ~= "") then
			self.totemIsDown[i] = true
			self.startTimes[i] = startTime
			self.durations[i] = duration
			-- TODO: Must run the rest of the enabling stuff also to be useful (frame modifications, etc.)
		else
			self.totemIsDown[i] = false
			self.startTimes[i] = 0
			self.durations[i] = 0
		end
	end
end

-----------------------------------------------------
-- General addon logic

function PitBull_TotemTimers:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("TotemTimers")
	PitBull:SetDatabaseNamespaceDefaults("TotemTimers", "profile", {
		hidden = false,
		totemsize = 25,
		totemspacing = 0,
		totemdirection = "h",
		totemtooltips = true,
		timerspiral = true,
		suppressocc = true,
		timertext = true,
		timertextcolor = {0, 1, 0, 1},
		timertextside = "bottominside",
		timertextscale = 0.75,
		mainbgcolor = {0, 0, 0, 0.5},
		linebreak = MAX_TOTEMS,
		hideinactive = false,
		order = getOrderDefault(), -- this is the order _by_slot_ not by position!
		iconbordercolor = {0, 0, 0, 0.5},
		mainoffsetx = 0,
		mainoffsety = 0,
		expirypulse = true,
		expirypulsetime = 5,
		recastenabled = false,
	})
	
	-- Initialize Timer variables
	self.startTimes = {}
	self.durations = {}
	self.totemIsDown = {}
	for i=1,MAX_TOTEMS do
		self.startTimes[i] = 0
		self.durations[i] = 0
		self.totemIsDown[i] = false
	end
	
	-- Get initial status
	self:GetTotemStatus()
	
	-- Register a slash handler to directly open the totemtimer options
	SlashCmdList["PBTT"] = function() PitBull:OpenConfigMenu("player", "other", "PitBull_TotemTimers") end
	SLASH_PBTT1 = "/pbtt"
end

function PitBull_TotemTimers:OnEnable(first)
	self:AddEventListener("PLAYER_TOTEM_UPDATE")
	self:AddEventListener("PLAYER_ENTERING_WORLD")
end

function PitBull_TotemTimers:PLAYER_TOTEM_UPDATE(something, event, slot)
	--PitBull:Print(string.format("Got %s and %s", tostring(event), tostring(slot)))
	local haveTotem, name, startTime, duration, icon = GetTotemInfo(slot)
	local sSlot = tostring(slot)

	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if not frame.totemTimersFrame then
			self:OnPopulateUnitFrame("player", frame)
			if frame.totemTimersFrame then
				PitBull:UpdateLayout(frame)
			end
		end
		
		if ( haveTotem and name ~= "") then
			-- New totem created
			--PitBull:Print("Activating Totem")
			self:ActivateTotem(slot)
		elseif ( haveTotem ) then
			-- Totem just got removed or killed.
			--PitBull:Print("Deactivating Totem")
			self:DeactivateTotem(slot)
		end
	end
end

function PitBull_TotemTimers:PLAYER_ENTERING_WORLD(...)
	-- we simulate totem events whenever a player zones to make sure totems left back in the instance hide properly.
	for i=1, MAX_TOTEMS do
		self:PLAYER_TOTEM_UPDATE(nil, nil, i)
	end
end

function PitBull_TotemTimers:OnUpdateFrame(unit, frame)
	if frame.totemTimersFrame then
		self:Update(unit, frame)
	end
end

function PitBull_TotemTimers:Update(unit, frame)
	if frame.totemTimersFrame then
		PitBull:UpdateLayout(frame)
	end
end

function PitBull_TotemTimers:ResizeMainFrame(frame)
	if not frame.totemTimersFrame then
		return
	end
	local tSize = getTotemSize()
	local tSpacing = getTotemSpacing()
	local lbreak = getTotemLinebreak()
	local nlines = ceil(MAX_TOTEMS / lbreak)
	local ttf = frame.totemTimersFrame
	if (getTotemDirection() == "h") then
		ttf:SetWidth((lbreak*tSize)+((lbreak-1)*tSpacing))
		ttf:SetHeight((nlines*tSize)+((nlines-1)*tSpacing))
	else
		ttf:SetWidth((nlines*tSize)+((nlines-1)*tSpacing))
		ttf:SetHeight((lbreak*tSize)+((lbreak-1)*tSpacing))
	end
	--PitBull:Print(string.format("Set the size of the main frame to: %d and %d",ttf:GetWidth(),ttf:GetHeight()))
end

function PitBull_TotemTimers:RealignTotems(frame)
	local lbreak = getTotemLinebreak()

	if frame.totemTimersFrame then
		self:ResizeMainFrame(frame)

		local elements = frame.totemTimersFrame.elements
		for i=1, MAX_TOTEMS do
			local o = getSlotFromOrder(i)
			
			
			if (not o) then
				return
			end
			
			if i==1 then
				elements[o].frame:ClearAllPoints()
				elements[o].frame:SetPoint("TOPLEFT", frame.totemTimersFrame, "TOPLEFT", 0, 0)
			else
				elements[o].frame:ClearAllPoints()
				-- Attach the button to the previous one
				if (getTotemDirection() == "h") then
					-- grow horizontally
					if (fmod(i - 1, lbreak) == 0) then
						-- Reached a linebreak
						local o3 = getSlotFromOrder(i-lbreak)
						elements[o].frame:SetPoint("TOPLEFT", elements[o3].frame, "BOTTOMLEFT", 0, 0-getTotemSpacing())
					else
						local o2 = getSlotFromOrder(i-1)
						elements[o].frame:SetPoint("TOPLEFT", elements[o2].frame, "TOPRIGHT", getTotemSpacing(), 0)
					end
				else
					--grow vertically
					if (fmod(i - 1, lbreak) == 0) then
						local o3 = getSlotFromOrder(i-lbreak)
						elements[o].frame:SetPoint("TOPLEFT", elements[o3].frame, "TOPRIGHT", getTotemSpacing(), 0)
					else
						local o2 = getSlotFromOrder(i-1)
						elements[o].frame:SetPoint("TOPLEFT", elements[o2].frame, "BOTTOMLEFT", 0, 0-getTotemSpacing())
					end
				end
			end
		end
		self:RealignTimerTexts(frame)
	end
end

local function TimerTextAlignmentLogic(frame, parent, side, offsetX, offsetY) 
	if ((not frame) or (not parent)) then
		return
	end
	
	local offX = offsetX or 0
	local offY = offsetY or 0
	frame:ClearAllPoints()
	if side == "topinside" then
		frame:SetPoint("TOP", parent, "TOP", offX, offY)
	elseif side == "topoutside" then
		frame:SetPoint("BOTTOM", parent, "TOP", offX, offY)
	elseif side == "bottominside" then
		frame:SetPoint("BOTTOM", parent, "BOTTOM", offX, offY)
	elseif side == "bottomoutside" then
		frame:SetPoint("TOP", parent, "BOTTOM", offX, offY)
	elseif side == "leftoutside" then
		frame:SetPoint("RIGHT", parent, "LEFT", offX, offY)
	elseif side == "rightoutside" then
		frame:SetPoint("LEFT", parent, "RIGHT", offX, offY)
	elseif side == "middle" then
		frame:SetPoint("CENTER", parent, "CENTER", offX, offY)
	else
		return
	end
	
end

function PitBull_TotemTimers:RealignTimerTexts(frame)
	if frame.totemTimersFrame then
		local elements = frame.totemTimersFrame.elements
		for i=1, MAX_TOTEMS do
			if (elements[i].text) then
				TimerTextAlignmentLogic(elements[i].text, elements[i].textFrame, getTimerTextSide(), 0, 0)
				local font, fontsize = PitBull:GetFont()
				elements[i].text:SetFont(font, fontsize * getTimerTextScale(), "OUTLINE")
			end
		end
	end
end

function PitBull_TotemTimers:ButtonOnClick(mousebutton)
	if (mousebutton == "RightButton" and this.slot ) then
		DestroyTotem( this.slot )
	end
end

function PitBull_TotemTimers:ButtonOnEnter()
	if ( this.slot and getGenericOption('totemtooltips') ) then
		-- setting the tooltip
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
		GameTooltip:SetTotem(this.slot)
	end
end

function PitBull_TotemTimers:ButtonOnLeave()
	if ( getGenericOption('totemtooltips') ) then
		-- hiding the tooltip
		GameTooltip:Hide()
	end
end

-- inline credits: Parts of the following function were heavily inspired by the addon CooldownButtons by Dodge (permission given)
function PitBull_TotemTimers:ButtonOnUpdate(elapsed)
	if not this:IsVisible() then 
		return -- nothing to do when we aren't visible
	end
	
	if this.lastUpdate > elapsed then
		this.lastUpdate = this.lastUpdate - elapsed
		return
	else
		this.lastUpdate = 0.75
	end

	-- start a pulse if it isn't active yet, if it is, do the animation as normal
	if this.pulseStart then
		this.pulse.icon:Hide()
		this.lastUpdate = 0
		if not this.pulseActive then
			-- Pulse isn't active yet so we start it
			local icon = this.texture
			if this:IsVisible() then
				local pulse = this.pulse
				if pulse then
					pulse.scale = 1
					--local normtex = this:GetNormalTexture()
					--pulse.icon:SetTexture(normtex)
					--local r, g, b = normtex:GetVertexColor()
					--pulse.icon:SetVertexColor(r, g, b, 0.7)
					pulse.icon:SetTexture(this.totemIcon)
					--pulse.icon:SetVertexColor(0.5,0.5,0.5,0.7)
					this.pulseActive = true
					--PitBull:Print(fmt("DEBUG: Starting pulse on slot %i, elapsed is: %s", this.slot, tostring(elapsed)))
				end
			end
		else
			-- Pulse is already active, do the animation...
			local pulse = this.pulse
			if pulse.scale >= 2 then
				pulse.dec = 1
			elseif pulse.scale <= 1 then
				pulse.dec = nil
			end
			pulse.scale = max(min(pulse.scale + (pulse.dec and -1 or 1) * pulse.scale * (elapsed/0.5), 2), 1)
			
			
			if this.pulseStopAfterThis and pulse.scale <= 1 then
				-- Pulse animation is to be stopped now.
				pulse.icon:Hide()
				pulse.dec = nil
				this.pulseActive = false
				this.pulseStart = false
				this.pulseStopAfterThis = false
				if getGenericOption('hideinactive') then
					this:Hide()
				end
				--PitBull:Print(fmt("DEBUG: Stopping pulse on slot %i", this.slot))
			else
				-- Applying the new scaling (animation frame)
				--PitBull:Print(fmt("DEBUG: Showing with scale %s", tostring(pulse.scale)))
				pulse.icon:Show()
				pulse.icon:SetHeight(pulse:GetHeight() * pulse.scale)
				pulse.icon:SetWidth(pulse:GetWidth() * pulse.scale)
			end
		end
		
	end
end

function PitBull_TotemTimers:OnPopulateUnitFrame(unit, frame)
	if unit ~= "player" or self.db.profile.hidden then
		return
	end
	
	if frame.totemTimersFrame then
		-- make sure the timer is still running (it gets deactivated if the frame is gone for a moment
		self:StartTimer()
		return
	end
	
	local font, fontsize = PitBull:GetFont()
	local tSize = getTotemSize()
	local tSpacing = getTotemSpacing()
	local totemTimersFrame = nil

	-- ttf shouldn't ever exist at this point but if it does, make sure we don't leak frames.
	if not frame.totemTimersFrame then
		totemTimersFrame = newFrame("Frame", frame)
	else
		totemTimersFrame = frame.totemTimersFrame
	end

	
	if (getTotemDirection() == "h") then
		totemTimersFrame:SetWidth((MAX_TOTEMS*tSize)+((MAX_TOTEMS-1)*tSpacing))
		totemTimersFrame:SetHeight(tSize)
	else
		totemTimersFrame:SetWidth(tSize)
		totemTimersFrame:SetHeight((MAX_TOTEMS*tSize)+((MAX_TOTEMS-1)*tSpacing))
	end
	--totemTimersFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT")
	--totemTimersFrame:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT")
	totemTimersFrame:Show()
	
	if not totemTimersFrame.texture then
		totemTimersFrame.texture = newFrame("Texture", totemTimersFrame, nil, "BACKGROUND")
	end
	totemTimersFrame.texture:SetTexture(getMainBGColor())
	totemTimersFrame.texture:SetAllPoints(totemTimersFrame)
	
	frame.totemTimersFrame = totemTimersFrame
	--frame.totemTimersFrame:Hide()
	local elements = {}
	for i=1, MAX_TOTEMS do
		-------------------------------
		-- Main totem slot frame
		elements[i] = {}
		if not elements[i].frame then
			elements[i].frame = newFrame("Button", frame.totemTimersFrame)
			--elements[i].frame = newFrame("Button", frame.totemTimersFrame, "SecureActionButtonTemplate")
			
		end
		local frame = elements[i].frame
		
		frame:SetWidth(tSize)
		frame:SetHeight(tSize)
		--elements[i].frame:SetNormalTexture(getMainBGColor()) -- buttons start with the same texture as the background
		frame:Hide()
		frame.slot = i
		
		-------------------------------
		-- Border frame
		if not frame.border then
			frame.border = newFrame("Texture", frame)
		end
		local border = frame.border
		border:SetDrawLayer("OVERLAY")
		border:SetAlpha(1)
		border:ClearAllPoints()
		border:SetAllPoints(frame)
		border:SetTexture(border_path)
		border:SetVertexColor(getGenericColor('iconbordercolor'))
		border:Show()
		
		----------------------------
		-- Spiral cooldown frame
		if not elements[i].spiral then
			elements[i].spiral = newFrame("Cooldown", frame)
		end
		local spiral = elements[i].spiral
		spiral:SetReverse(true)
		spiral:SetAllPoints(frame)
		if ( getGenericOption('suppressocc') ) then
			-- user wishes to suppress omnicc on his timer spiral, requires recent (post-2.4) omnicc version!
			spiral.noomnicc = true
		end
		
		--------------------
		-- Text frame
		if not elements[i].textFrame then
			elements[i].textFrame = newFrame("Frame", frame)
		end
		local textFrame = elements[i].textFrame
		textFrame:SetAllPoints(frame)
		--textFrame:SetFrameLevel(spiral:GetFrameLevel() + 7)
		
		if not elements[i].text then
			elements[i].text = newFrame("FontString", frame, "OVERLAY")
		end
		local text = elements[i].text
		text:SetDrawLayer("OVERLAY")
		text:SetWidth(tSize)
		text:SetHeight((tSize/3))
		text:ClearAllPoints()
		text:SetPoint("BOTTOM", textFrame, "BOTTOM", 0, 0)
		text:SetFont(font, fontsize * getTimerTextScale(), "OUTLINE")
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(0.8, -0.8)
		if ( getTimerTextColor() ) then
			text:SetTextColor(getTimerTextColor())
		end
		text:Show()
		
		--------------------
		-- Pulse frame
		if not frame.pulse then
			frame.pulse = newFrame("Frame", frame)
		end
		local pulse = frame.pulse
		pulse:SetAllPoints(frame)
		pulse:SetToplevel(true)
		--pulse.icon = newFrame("Texture", frame, "OVERLAY")
		pulse.icon = newFrame("Texture", frame)
		pulse.icon:SetDrawLayer("OVERLAY")
		pulse.icon:SetPoint("CENTER")
		pulse.icon:SetBlendMode("ADD")
		pulse.icon:SetVertexColor(0.5,0.5,0.5,0.7)
		pulse.icon:SetHeight(frame:GetHeight())
		pulse.icon:SetWidth(frame:GetWidth())
		pulse.icon:Hide()
		frame.pulseActive = false
		frame.pulseStart = false
		
		-----------------
		-- Click handling
		-- click handling for destroying single totems
		frame:RegisterForClicks("RightButtonUp")
		frame:SetScript("OnClick", self.ButtonOnClick)
		--PitBull:Print("DEBUG: Using new attributes now!")
		--frame:SetAttribute("type1", "spell")
		--frame:SetAttribute("spell1", "Tremor Totem")
		--frame:SetAttribute("type2", "macro")
		--frame:SetAttribute("macrotext2", "/say test")
		--frame:SetAttribute("macrotext2", "/script DestroyTotem("..tostring(i)..")")
		-- tooltip handling
		frame:SetScript("OnEnter", self.ButtonOnEnter)
		frame:SetScript("OnLeave", self.ButtonOnLeave)
		frame.lastUpdate = 1
		frame:SetScript("OnUpdate", self.ButtonOnUpdate)
		
	end
	
	frame.totemTimersFrame.elements = elements
	self:RealignTotems(frame)
end



function PitBull_TotemTimers:OnUnknownLayout(unit, frame, name)
	--PitBull:Print(string.format("OnUnknownLayout called for %s", name))
	if name == "totemTimersFrame" then
		if not frame.totemTimersFrame then
			return nil
		end
		frame.totemTimersFrame:SetHeight(getTotemSize())
		frame.totemTimersFrame:ClearAllPoints()
		frame.totemTimersFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT")
		--frame.totemTimersFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT")
	end
end


function PitBull_TotemTimers:OnClearUnitFrame(unit, frame)
	-- this event is called when the frame is temporarily being hidden.
	-- reports indicate that this happens at least when showing the worldmap or pressing alt-z
	-- we try to stop all timed events from accessing our frames in that time
	if unit ~= "player" or self.db.profile.hidden then
		return
	end
	self:StopTimer()
	
	--[[
	---------------------------------------------------------------
	-- this inactive codeblock here would need to be put into a proper cleanup function should we ever have one.
	if frame.totemTimersFrame then
		if frame.totemTimersFrame.elements then
			for i=1, MAX_TOTEMS do
				if frame.totemTimersFrame.elements and frame.totemTimersFrame.elements[i] then
					-- subframes to delete .text, .textFrame, .spiral, .border, .frame
					if frame.totemTimersFrame.elements[i].text then
						frame.totemTimersFrame.elements[i].text = delFrame(frame.totemTimersFrame.elements[i].text)
					end
					if frame.totemTimersFrame.elements[i].textFrame then
						frame.totemTimersFrame.elements[i].textFrame = delFrame(frame.totemTimersFrame.elements[i].textFrame)
					end
					if frame.totemTimersFrame.elements[i].spiral then
						frame.totemTimersFrame.elements[i].spiral = delFrame(frame.totemTimersFrame.elements[i].spiral)
					end
					if frame.totemTimersFrame.elements[i].border then
						frame.totemTimersFrame.elements[i].border = delFrame(frame.totemTimersFrame.elements[i].border)
					end
					if frame.totemTimersFrame.elements[i].frame then
						frame.totemTimersFrame.elements[i].frame = delFrame(frame.totemTimersFrame.elements[i].frame)
					end
				end
			end
			if frame.totemTimersFrame.elements[i] then
				frame.totemTimersFrame.elements[i] = nil
			end
		end
		if frame.totemTimersFrame.texture then
			frame.totemTimersFrame.texture = delFrame(frame.totemTimersFrame.texture)
		end
		frame.totemTimersFrame = delFrame(frame.totemTimersFrame)
	end
	]]--
	---------------------------------------------------------------
end

-- this function reads what PB tried to anchor us at and applies some fixing
function PitBull_TotemTimers:FixAnchoring(frame)
	if not frame then
		return
	end
	
	local tos = tostring

	local oldpoints = {}
	local newpoints = {}

	if not frame:GetNumPoints() then return end

	local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint(1)
	local npoint, nrelativeTo, nrelativePoint, nxOfs, nyOfs = frame:GetPoint(1)
	
	if relativePoint == "TOP" then
		-- when pitbull anchors to top (middle) we force our point to be bottom (middle)
		npoint = "BOTTOM"
	elseif relativePoint == "BOTTOM" then
		npoint = "TOP"
	elseif relativePoint == "LEFT" then
		npoint = "RIGHT"
	elseif relativePoint == "RIGHT" then
		npoint = "LEFT"
	end
	--PitBull:Print(fmt("DEBUG: FixAnchoring: Found: %s connected to parent %s. Changed to: %s connected to parent %s.",tos(point),tos(relativePoint),tos(npoint),tos(nrelativePoint)))

	-- add the configured offsets while we're at it
	nxOfs = getGenericOption('mainoffsetx') or 0
	nyOfs = getGenericOption('mainoffsety') or 0
	
	frame:ClearAllPoints()
	frame:SetPoint(npoint, nrelativeTo, nrelativePoint, nxOfs, nyOfs)
	
end

function PitBull_TotemTimers:OnUpdateLayout(unit, frame)
	if unit ~= "player" then
		return
	end
	
	self:ResizeMainFrame(frame)
	
	if frame.totemTimersFrame then
		self:FixAnchoring(frame.totemTimersFrame)
	end
	local old = not unitsShown[frame]
	local now = not frame.totemTimersFrame or not frame.totemTimersFrame:IsShown()
	if old == now then
		return
	end
	unitsShown[frame] = not now
	if not now then
		self:OnUpdateFrame(unit, frame)
	end
end

function PitBull_TotemTimers:OnUpdateFont(font, size)
	for frame in PitBull:IterateUnitFramesForUnit("player") do
		if (not frame.totemTimersFrame) or (not frame.totemTimersFrame.elements) then
			return
		end
		local el = frame.totemTimersFrame.elements
		
		for i=1, MAX_TOTEMS do
			if el[i] and el[i].text then
				el[i].text:SetFont(font, size * getTimerTextScale(), "OUTLINE")
			end
		end
    end
end

----------------------------------------------
-- Configuration registration

local function getOrderOptionGroup()
	local oo = {}
	for i=1, MAX_TOTEMS do
		local verboseName = getVerboseSlotName(i)
		local slot = { 
			name = verboseName,
			desc = verboseName,
			type = "choice",
			choices = listOrder,
			get = getOrderAsString,
			set = setOrder,
			passValue = i,
			order = i,
			disabled = getHide,
		}
		oo["slot"..tostring(i)] = slot
	end
	return oo
end

PitBull_TotemTimers:RegisterPitBullOptionsMethod(function(group)
	if group == "player" then
		return {
			name = L["Totem Timers"],
			desc = L["Totem timers for this unit type."],
			type = 'group',
			args = {
				hide = {
					type = 'boolean',
					name = L["Enable"],
					desc = L["Enables the Totem timers."],
					get = getEnabled,
					set = setEnabled,
					order = 1,
				},
				totemsize = {
					type = 'number',
					name = L["Totem Size"],
					desc = L["Sets the size of the individual totem icons."],
					min = 5,
					max = 100,
					step = 1,
					get = getTotemSize,
					set = setTotemSize,
					order = 2,
					disabled = getHide,
				},
				totemspacing = {
					type = 'number',
					name = L["Totem Spacing"],
					desc = L["Sets the size of the gap between the totem icons."],
					min = 0,
					max = 100,
					step = 1,
					get = getTotemSpacing,
					set = setTotemSpacing,
					order = 3,
					disabled = getHide,
				},
				totemdirection = {
					type = 'choice',
					name = L["Totem Direction"],
					desc = L["Choose wether to grow horizontally or vertically."],
					get = getTotemDirection,
					set = setTotemDirection,
					choices = {
						["h"] = L["Horizontal"],
						["v"] = L["Vertical"]
					},
					order = 4,
					disabled = getHide,
				},
				linebreak = {
					type = 'number',
					name = L["Totems per line"],
					desc = L["How many totems to draw per line."],
					min = 1,
					max = MAX_TOTEMS,
					step = 1,
					get = getTotemLinebreak,
					set = setTotemLinebreak,
					order = 5,
					disabled = getHide,
				},
				totemtooltips = {
					type = 'boolean',
					name = L["Totem Tooltips"],
					desc = L["Enables tooltips when hovering over the icons."],
					get = getGenericOption,
					set = setGenericSingleValue,
					passValue = 'totemtooltips',
					order = 6,
					disabled = getHide,
				},
				hideinactive = {
					type = 'boolean',
					name = L["Hide inactive"],
					desc = L["Hides inactive totem icons completely."],
					get = getHideInactive,
					set = setHideInactive,
					order = 7,
					disabled = getHide,
				},
				--[[
				recastenabled = {
					type = 'boolean',
					name = L["Allow Recasting"],
					desc = L["This enables the *EXPERIMENTAL* recast support. Leftclick on an Icon to redrop the last totem. WARNING: When you change the type of totem during combat it will not redrop the totem you would expect until after combat ends!"],
					get = getGenericOption,
					set = setGenericSingleValue,
					passValue = 'recastenabled',
					order = 8,
					disabed = function() return getHide() or getHideInactive() end
				},
				]]--
				expirypulse = {
					type = 'boolean',
					name = L["Expiry pulse"],
					desc = L["Causes the icon to pulse in the last few seconds of its lifetime."],
					get = getGenericOption,
					set = setGenericSingleValue,
					passValue = 'expirypulse',
					order = 8,
					disabled = getHide,
				},
				expirypulsetime = {
					type = 'number',
					name = L["Expiry time"],
					desc = L["Pulse for this many seconds before the totem runs out."],
					min = 0.5,
					max = 60,
					step = 0.5,
					get = getGenericOption,
					set = setGenericSingleValue,
					passValue = 'expirypulsetime',
					order = 9,
					disabled = function() return getHide() or (not getGenericOption('expirypulse')) end,
				},
				mainbgcolor = {
					type = 'color',
					name = L["Background Color"],
					desc = L["Sets the color and transparency of the background of the timers."],
					hasAlpha = true,
					get = getMainBGColor,
					set = setMainBGColor,
					order = 10,
					disabled = getHide,
				},
				iconbordercolor = {
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the bordercolor of the individual icons."],
					hasAlpha = true,
					get = getGenericColor,
					set = setIconBorderColor,
					passValue = "iconbordercolor",
					order = 11,
					disabled = getHide,
				},
				mainoffsetx = {
					type = 'number',
					name = L["Frame Offset X"],
					desc = L["Shifts the window to the left or to the right of the set anchorpoint."],
					min = -690,
					max = 690,
					step = 1,
					get = getGenericOption,
					set = setOffset,
					passValue = 'mainoffsetx',
					order = 12,
					disabled = getHide,
				},
				mainoffsety = {
					type = 'number',
					name = L["Frame Offset Y"],
					desc = L["Shifts the window above or below the set anchorpoint."],
					min = -430,
					max = 430,
					step = 1,
					get = getGenericOption,
					set = setOffset,
					passValue = 'mainoffsety',
					order = 13,
					disabled = getHide,
				},
				grptimerspiral = {
					type = 'group',
					name = L["Spiral Timer"],
					desc = L["Options relating to the spiral display timer."],
					args = {
						timerspiral = {
							type = 'boolean',
							name = L["Timer Spiral"],
							desc = L["Shows the pie-like cooldown spiral on the icons."],
							get = getGenericOption,
							set = setGenericSingleValue,
							passValue = 'timerspiral',
							order = 1,
							disabled = getHide,
						},
						suppressocc = {
							type = 'boolean',
							name = L["Suppress OmniCC"],
							desc = L["Suppresses OmniCC on the spiral timer. (Requires UI reload to change the setting!)"],
							get = getGenericOption,
							set = setGenericSingleValue,
							passValue = 'suppressocc',
							order = 2,
							disabled = function() return not getGenericOption('timerspiral') or getHide() end,
						},
					},
					disabled = getHide,
				},
				grptimertext = {
					type = 'group',
					name = L["Text Timer"],
					desc = L["Options relating to the text display timer."],
					args = {
						timertext = {
							type = 'boolean',
							name = L["Timer Text"],
							desc = L["Shows the remaining time in as text."],
							get = getGenericOption,
							set = setGenericSingleValue,
							passValue = 'timertext',
							order = 1,
							disabled = getHide,
						},
						timertextcolor = {
							type = 'color',
							name = L["Text Color"],
							desc = L["Color of the timer text."],
							hasAlpha = true,
							get = getTimerTextColor,
							set = setTimerTextColor,
							disabled = function() return not getGenericOption('timertext')or getHide() end
						},
						timertextside = {
							name = L["Text Side"],
							desc = L["Which side to position the timer text at."],
							type = "choice",
							choices = {
								topinside = L["Top, Inside"],
								topoutside = L["Top, Outside"],
								bottominside = L["Bottom, Inside"],
								bottomoutside = L["Bottom, Outside"],
								leftoutside = L["Left, Outside"],
								rightoutside = L["Right, Outside"],
								middle = L["Middle"],
							},
							get = getTimerTextSide,
							set = setTimerTextSide,
							disabled = function() return not getGenericOption('timertext') or getHide() end,
						},
						timertextscale = {
							name = L["Text Scale"],
							desc = L["Change the scaling of the text timer. Note: It's relative to PitBull's font size."],
							type = 'number',
							min = 0.1,
							max = 2,
							step = 0.01,
							get = getTimerTextScale,
							set = setTimerTextScale,
							disabled = function() return not getGenericOption('timertext')or getHide() end,
						},
					},
					disabled = getHide,
				},
				grptotemorder = {
					type = "group",
					name = L["Order"],
					desc= L["The order in which the elements appear."],
					args = function() return getOrderOptionGroup() end,
					disabled = getHide,
				},
			}
		}
	end
end)
