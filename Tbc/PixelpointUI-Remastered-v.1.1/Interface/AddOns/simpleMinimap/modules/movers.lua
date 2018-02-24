local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap_movers")

L:RegisterTranslations("enUS", function() return({
	alpha = true,
	alpha_desc = "alpha of the mover frames",
	movers = true,
	movers_desc = "mover frames - NOTE :: lock the minimap to hide the mover frames",
	drag = "left-click to drag"
}) end)

L:RegisterTranslations("zhTW", function() return({ 
	alpha = "透明度", 
	alpha_desc = "移動框體的透明度", 
	movers = "移動", 
	movers_desc = "移動框體 - 說明:: 鎖定迷你地圖以隱藏移動框體", 
	drag = "左鍵點擊拖曳框體" 
}) end)

L:RegisterTranslations("koKR", function() return({
	alpha = "투명도",
	alpha_desc = "앵커 프레임의 투명도",
	movers = "앵커",
	movers_desc = "앵커 프레임",
	drag = "좌클릭 : 드래그"
}) end)

L:RegisterTranslations("deDE", function() return({
	alpha = "Helligkeit",
	alpha_desc = "Helligkeit der Quest-/Ankerfenster",
	movers = "Quest-/Ankerfenster",
	movers_desc = "Optionen für die Quest-/Ankerfenster - HINWEIS: Um die Quest-/Ankerfenster auszublenden Minimap sperren ('Sperre Minimap')",
	drag = "Linksklick zum ziehen"
}) end)

L:RegisterTranslations("zhCN", function() return({ 
	alpha = "透明度", 
	alpha_desc = "移动框体的透明度", 
	movers = "移动", 
	movers_desc = "移动框体 - NOTE :: 锁定迷你地图以隐藏移动框体", 
	drag = "左键点击拖动框体" 
}) end)

L:RegisterTranslations("esES", function() return({
	alpha = "Transparencia",
	alpha_desc = "Transparencia de los desplazadores",
	movers = "Desplazadores",
	movers_desc = "Desplazadores - NOTA: bloquea el minimapa para ocultarlos",
	drag = "Clic para arrastrar"
}) end)
-- Russian Translation by Ynitron, hwost, StingerSoft
L:RegisterTranslations("ruRU", function() return({
	alpha = "Прозрачность",
	alpha_desc = "Прозрачность передвигаемого фрейма",
	movers = "Перемещения",
	movers_desc = "Перемещение фреймов - Заметка :: Закрепите мини-карту для скрытия выделения фреймов перемещения",
	drag = "ЛКМ чтобы перетащить"
}) end)

local mod = simpleMinimap:NewModule("movers", "AceEvent-2.0")
mod.desc = L["movers_desc"]
mod.translatedName = L["movers"]

local movers = {
	QuestWatchFrame = { 280, 80 },
	DurabilityFrame = { 60, 65 },
	QuestTimerFrame = { 160, 72 },
	CaptureMover = { 178, 30 }
}
local framesDefault = {
	QuestWatchFrame = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=0, y=10 },
	DurabilityFrame = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=40, y=15 },
	QuestTimerFrame = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=10, y=0 },
	CaptureMover = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=10, y=15 }
}

mod.options = {
	alpha = {
		type = "range",
		order = 10,
		name = L["alpha"],
		desc = L["alpha_desc"],
		min = 0,
		max = 1,
		step = 0.05,
		isPercent = true,
		get = function() return mod.db.profile.alpha end,
		set = function(x) mod.db.profile.alpha = x mod:UpdateScreen() end
	}
}

mod.defaults = {
	enabled = false,
	alpha = 0.4,
	framePos = {}
}

local bg = { bgFile="Interface\\Tooltips\\UI-Tooltip-Background" }

local frames = {}

function mod:OnEnable()
	if(self.db.profile.enabled) then
		for n, s in pairs(movers) do
			if(not self[n]) then
				local f = CreateFrame("Frame", "smm"..n, UIParent)
				f:SetWidth(s[1])
				f:SetHeight(s[2])
				f:ClearAllPoints()
				if(getglobal(n)) then
					f.smmMover = getglobal(n)
					f:SetPoint("CENTER", f.smmMover) 
				else
					f.smmMover = f
					f.smmMover:SetPoint(framesDefault[n].point, framesDefault[n].anchor, framesDefault[n].rpoint, framesDefault[n].x, framesDefault[n].y)
				end
				f.smmMover:SetMovable(true)
				f:SetBackdrop({ bgFile="Interface\\Tooltips\\UI-Tooltip-Background" })
				f:EnableMouse(true)
				f:RegisterForDrag("LeftButton")
				f:SetScript("OnDragStart", function() self:MoveFrame(n, true) end)
				f:SetScript("OnDragStop", function() self:MoveFrame(n, false) end)
				f:SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_CURSOR") GameTooltip:SetText(L.drag.." |cFFFFFF99"..n)	end)
				f:SetScript("OnLeave", function() GameTooltip:Hide() end)
				self[n] = f
			end
		end
		self:RegisterEvent("UPDATE_WORLD_STATES")
		self:UpdateScreen()
		self.loaded = true
	else
		simpleMinimap:ToggleModuleActive(self, false)
	end
end
--
function mod:OnDisable()
	if(self.loaded) then
		self:UpdateScreen()
		self.loaded = nil
	end
end
--
function mod:MoveFrame(frame, startMove)
	if(startMove and not simpleMinimap.db.profile.lock) then
		this.smmMover.isMoving = true
		this.smmMover:StartMoving()
		GameTooltip:Hide()
	elseif(this.smmMover.isMoving) then
		this.smmMover.isMoving = nil
		this.smmMover:StopMovingOrSizing()
		self.db.profile.framePos[frame] = { this.smmMover:GetCenter() }
	end
end
--
function mod:UpdateScreen()
	local p = self.db.profile
	for n, _ in pairs(movers) do
		if(self[n]) then
			local f = self[n].smmMover
			if(simpleMinimap:IsModuleActive(self) and p.framePos[n]) then
				self:Lock(f, true)
				f:smmClearAllPoints()
				f:smmSetPoint("CENTER", UIParent, "BOTTOMLEFT", p.framePos[n][1], p.framePos[n][2])
			elseif(f.smmSetPoint) then
				self:Lock(f, false)
				f:ClearAllPoints()
				f:SetPoint(framesDefault[n].point, framesDefault[n].anchor, framesDefault[n].rpoint, framesDefault[n].x, framesDefault[n].y)
				f:SetUserPlaced(false)
			end
			if(simpleMinimap:IsModuleActive(self) and not simpleMinimap.db.profile.lock) then
				self[n]:Show()
				self[n]:SetAlpha(p.alpha)
			else
				self[n]:Hide()
			end
		end
	end
end
--
function mod:UPDATE_WORLD_STATES()
	for i = 1, NUM_EXTENDED_UI_FRAMES do
		local f = getglobal("WorldStateCaptureBar"..i)
		if(f) then
			if(self.db.profile.enabled) then
				self:Lock(f, true)
				f:smmClearAllPoints()
				f:smmSetPoint("CENTER", self["CaptureMover"])
			elseif(f.smmSetPoint) then
				self:Lock(f, false)
			end
		end
	end
end
--
function mod:Lock(frame, toggle)
	if(toggle) then
		if(not frame.smmClearAllPoints) then
			frame.smmClearAllPoints = frame.ClearAllPoints
			frame.ClearAllPoints = function() end
			frame.smmSetPoint = frame.SetPoint
			frame.SetPoint = function() end
		end
	elseif(frame.smmClearAllPoints) then
		frame.ClearAllPoints = frame.smmClearAllPoints
		frame.smmClearAllPoints = nil
		frame.SetPoint = frame.smmSetPoint
		frame.smmSetPoint = nil
	end
end