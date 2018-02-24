if not TukuiCF.databars.enable == true then return end

BarBackground = CreateFrame("Frame", "BarBackground", UIParent)
for i = 1, 2 do
	BarBackground[i] = CreateFrame("Button", "BarBackground"..i, UIParent)
	TukuiDB.CreatePanel(BarBackground[i], TukuiDB.Scale(111), TukuiDB.Scale(18), "CENTER", UIParent, "CENTER", 0, 0)
	if i == 1 then
		BarBackground[i]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", TukuiDB.Scale(10), TukuiDB.Scale(-10))
	else
		BarBackground[i]:SetPoint("LEFT", BarBackground[i-1], "RIGHT", TukuiDB.Scale(5), 0)
	end
	BarBackground[i]:SetFrameLevel(2)
	HydraDB.SetBorder(BarBackground[i])
	TukuiDB.CreateShadow(BarBackground[i])
end

DatabarToggle = CreateFrame("Frame", "DatabarToggle", UIParent)
for i = 1, 2 do
	DatabarToggle[i] = CreateFrame("Button", "DatabarToggle"..i, UIParent)
	TukuiDB.CreatePanel(DatabarToggle[i], TukuiDB.Scale(111), TukuiDB.Scale(18), "CENTER", UIParent, "CENTER", 0, 0)
	if i == 1 then
		DatabarToggle[i]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", TukuiDB.Scale(10), TukuiDB.Scale(-10))
	else
		DatabarToggle[i]:SetPoint("LEFT", DatabarToggle[i-1], "RIGHT", TukuiDB.Scale(5), 0)
	end
	DatabarToggle[i]:SetAlpha(0)
	DatabarToggle[i]:SetFrameStrata("HIGH")
	DatabarToggle[i]:EnableMouse(true)
	AnimGroup(BarBackground[i], 0, TukuiDB.Scale(30), 0.4)
	DatabarToggle[i]:SetScript("OnMouseDown", function(self)
		if not BarBackground[i]:IsVisible() then
			SlideIn(BarBackground[i])
		else
			SlideOut(BarBackground[i])
		end
	end)
end

StatusBar = CreateFrame("Frame", "StatusBar", UIParent)
StatusBarTex = StatusBar:CreateTexture(nil, 'BORDER')
Text = StatusBar:CreateFontString(nil, "LOW")
for i = 1, 2 do
	StatusBar[i] = CreateFrame("Button", "StatusBar"..i, UIParent)
	TukuiDB.CreatePanel(StatusBar[i], BarBackground1:GetWidth() - TukuiDB.Scale(4), BarBackground1:GetHeight() - TukuiDB.Scale(4), "CENTER", UIParent, "CENTER", 0, 0)
	if i == 1 then
		StatusBar[i]:SetPoint("LEFT", BarBackground[1], "LEFT", TukuiDB.Scale(2), 0)
	elseif i == 2 then
		StatusBar[i]:SetPoint("LEFT", BarBackground[2], "LEFT", TukuiDB.Scale(2), 0)
	elseif i == 3 then
		StatusBar[i]:SetPoint("LEFT", BarBackground[3], "LEFT", TukuiDB.Scale(2), 0)
	elseif i == 4 then
		StatusBar[i]:SetPoint("LEFT", BarBackground[4], "LEFT", TukuiDB.Scale(2), 0)
	end
	StatusBar[i]:SetParent(BarBackground[i])
	StatusBar[i]:SetFrameLevel(2)
	StatusBar[i]:SetBackdropBorderColor(0,0,0,0)
	StatusBarTex[i] = StatusBar[i]:CreateTexture(nil, 'BORDER')
	StatusBarTex[i]:SetAllPoints(StatusBar[i])
	StatusBarTex[i]:SetVertexColor(.3, .3, .3, 1)
	StatusBarTex[i]:SetTexture(TukuiCF.media.normTex)
	StatusBarTex[i].multiplier = 0.3
	Text[i] = StatusBar[i]:CreateFontString(nil, "LOW")
	Text[i]:SetFont(TukuiCF.media.minimal, 10, "OUTLINE")
	Text[i]:SetPoint("LEFT", BarBackground[i], TukuiDB.Scale(6), 0)
	Text[i]:SetShadowColor(0, 0, 0)
	Text[i]:SetShadowOffset(1.25, -1.25)
end

-- FPS
local FPS = CreateFrame("Frame")
local int = 1
local function UpdateFPS(self, t)
	int = int - t
	if int < 0 then
		value = (floor(GetFramerate()))
		StatusBar[1]:SetWidth(value / 1.5)
		Text[1]:SetText(tukuilocal.databar_fps..hexa..value..hexb)
		-- limit
		if (value / 1.5) > 116 then
			StatusBar[1]:SetWidth(BarBackground[1]:GetWidth() - TukuiDB.Scale(4))
		end
		int = 1
	end
end
FPS:SetScript("OnUpdate", UpdateFPS)
UpdateFPS(FPS, 10)

-- MS
local MS = CreateFrame("Frame")
local int = 1
local function UpdateMS(self, t, event)
	int = int - t
	if int < 0 then
		value = (select(3, GetNetStats()))
		StatusBar[2]:SetWidth(value/2.5)
		--limit
		if (value/2.5) > 116 then
			StatusBar[2]:SetWidth(BarBackground[2]:GetWidth() - TukuiDB.Scale(4))
		end
		Text[2]:SetText(tukuilocal.databar_ms..hexa..value..hexb)
		int = 1
	end	
end
MS:SetScript("OnUpdate", UpdateMS)
MS:RegisterEvent("PLAYER_ENTERING_WORLD")
UpdateMS(MS, 10)

-- Durability
--local Dura = CreateFrame("Frame")
--local Total = 0
--local current, max
--local function OnEventDura(self)
--	for i = 1, 11 do
--		if GetInventoryItemLink("player", tukuilocal.Slots[i][1]) ~= nil then
--			current, max = GetInventoryItemDurability(tukuilocal.Slots[i][1])
--			if current then 
--				tukuilocal.Slots[i][3] = current/max
--				Total = Total + 1
--			end
--		end
--	end
--	table.sort(tukuilocal.Slots, function(a, b) return a[3] < b[3] end)
--	value = (floor((tukuilocal.Slots[1][3]*100)))
--	Text[3]:SetText(tukuilocal.databar_dura..hexa..value..hexb.." %")
--	StatusBar[3]:SetWidth(value * 1.2 - TukuiDB.Scale(4))
--end
--Dura:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
--Dura:RegisterEvent("MERCHANT_SHOW")
--Dura:RegisterEvent("PLAYER_ENTERING_WORLD")
--Dura:SetScript("OnEvent", OnEventDura)

-- Bags
-- local Bags = CreateFrame("Frame")
-- local function OnEventBags(self, event, ...)
	-- local free, total,used = 0, 0, 0
	-- for i = 0, NUM_BAG_SLOTS do
		-- free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
	-- end
	-- used = total - free
	-- value = (used*120/total - TukuiDB.Scale(4))
	-- Text[4]:SetText(tukuilocal.datatext_bags..hexa..used..hexb.." / "..hexa..total..hexb)
	-- StatusBar[4]:SetWidth(value)
-- end
-- Bags:RegisterEvent("PLAYER_LOGIN")
-- Bags:RegisterEvent("BAG_UPDATE")
-- Bags:SetScript("OnEvent", OnEventBags)