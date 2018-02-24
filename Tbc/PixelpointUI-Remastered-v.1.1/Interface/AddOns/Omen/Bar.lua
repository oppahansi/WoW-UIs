local MINOR_VERSION = tonumber(("$Revision: 74746 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local barPrototype = {}
local barCache = {}
local barPool = {}
local labelPool = {}
local barPrototype_mt = {__index = barPrototype}
local Media = LibStub("LibSharedMedia-3.0")
local Threat = LibStub("Threat-2.0")
local math_floor = _G.math.floor
local strlower = _G.strlower
local min, max = _G.min, _G.max
local pairs, ipairs = _G.pairs, _G.ipairs
local tinsert = _G.tinsert
local fmt = _G.format

local default_color = {
	r = 1,
	g = 0,
	b = 0,
	a = 0.6
}

local stretch

local function animateBar(frame, arg1)
	local self = frame.parent
	self.animatedTime = self.animatedTime + arg1
	local pct = min(1, self.animatedTime / self.totalAnimateTime)
	self.currentPct = pct
	local delta = (self.destinationWidth - self.startWidth) * pct
	self.currentWidth = self.startWidth + delta
	self.texture:SetWidth(self.currentWidth)
	if not stretch then
		local texPct = self.currentWidth / self.totalWidth
		self.texture:SetTexCoord(0, texPct, 0, 1)
	end
	if pct == 1 then
		frame:SetScript("OnUpdate", nil)
	end
end

local function animatePercent(self, pct, dPct) 
	local w = self.frame:GetWidth()
	local width = w * dPct
	self.percent = dPct
	if Omen.Options["Skin.Bars.Animate"] then
		self.totalWidth = w
		self.startWidth = self.texture:GetWidth()
		self.destinationWidth = width
		self.totalAnimateTime = 0.25
		self.animatedTime = 0
		if self.startWidth ~= self.destinationWidth then
			self.frame:SetScript("OnUpdate", animateBar)
		end
	else
		self.texture:SetWidth(width)
		if not stretch then
			self.texture:SetTexCoord(0, pct, 0, 1)
		end
	end	
end

function barPrototype:New(guid)
	local initSize = #barPool
	local obj = tremove(barPool) or setmetatable({}, barPrototype_mt)
	barCache[guid] = obj
	obj:Init(guid)
	return obj
end
	
function barPrototype:Init(guid)
	self.guid = self.guid or guid
	self.value = 0
	self.isTitle = false

	-- So we can reuse this bar
	self.labels = self.labels or {}
	self.labelLookup = self.labelLookup or {}
	
	self.class = nil
	
	if not self.frame then
		self.frame = CreateFrame("Frame", nil, Omen.BarList)
		self.frame.parent = self
		self.frame:Hide()
		
		self.texture = self.frame:CreateTexture()
		self.texture:SetPoint("TOPLEFT", self.frame, "TOPLEFT")
		self.texture:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT")
		
		self.backgroundTexture = self.frame:CreateTexture(nil, "BACKGROUND")
		self.backgroundTexture:SetAllPoints()
		-- self.backgroundTexture:SetBlendMode("ADD")
		self.backgroundTexture:Show()
		
		self.iconTexture = self.frame:CreateTexture(nil, "OVERLAY")
		self.iconTexture:SetPoint("CENTER", self.frame, "CENTER")
		-- self.iconTexture:SetPoint("BOTTOM", self.frame, "BOTTOM")
		self.iconTexture:Hide()
	end
	self:CreateLabels()
	self:UpdateLayout()
end

function barPrototype:SetClass(class)
	if not self.unit_name and class == nil then
		self.unit_name = Threat.GUIDNameLookup[self.guid]
		if self.unit_name then
			self.class = select(2, UnitClass(self.unit_name))
			self.isPlayer = UnitIsPlayer(self.unit_name)
			self.isPet = not UnitIsPlayer(self.unit_name) and (UnitPlayerOrPetInParty(self.unit_name) or UnitPlayerOrPetInRaid(self.unit_name))
		end
	elseif class then
		self.class = class
	end
	local c = RAID_CLASS_COLORS[self.class or ""] or default_color
	self.texture:SetVertexColor(c.r, c.g, c.b)
end

function barPrototype:SetColor(r,g,b,a)
	self.texture:SetVertexColor(r, g, b, a or 1)
end

function barPrototype:SetLabels(...)
	local defaultOffset = 1 / select("#", ...)
	local totalOffset = 0
	for k, v in pairs(self.labelLookup) do
		self.labelLookup[k] = nil
	end
	for i = 1, select("#", ...), 3 do
		local text, align, offset = select(i, ...)
		offset = offset or defaultOffset
		if offset > 1 then
			offset = offset / 100
		end
		totalOffset = totalOffset + offset
		if totalOffset > 1 then
			error(":SetLabels cannot accept more than 100% width combined among labels")
		end
		local t = tremove(labelPool) or {}
		t.align = align
		t.text = text
		t.offset = offset
		tinsert(self.labels, t)
		self.labelLookup[text] = t
	end
	self:CreateLabels()
	self:UpdateLayout()
	self:UpdateLabelPositions()
end

function barPrototype:CreateLabels()
	for k, v in ipairs(self.labels) do
		if not v.fontstring then
			local t = self.frame:CreateFontString(nil, nil, "GameFontNormal")
			t:SetVertexColor(1,1,1,1)
			v.fontstring = t
		else
			v.fontstring:SetParent(self.frame)
			v.fontstring:Show()
		end
		v.fontstring:SetHeight(self.frame:GetHeight() - 2)
		v.fontstring:SetNonSpaceWrap(false)
		v.fontstring:SetText(strlower(v.text) == "icon" and "" or "<" .. v.text .. ">")
		v.fontstring:SetJustifyH(v.align)
	end
end

function barPrototype:OnResize()
	if self.texture:GetWidth() > self.frame:GetWidth() then
		self.texture:SetWidth(self.frame:GetWidth())
	end
	self:UpdateLabelPositions()
end

function barPrototype:UpdateLabelPositions()
	local frameOffset = 3
	local anchorFrame = self.frame
	local tWidth = self.frame:GetWidth() - (frameOffset * 2)
	local totalOffset = frameOffset
	for k, v in ipairs(self.labels) do
		local offset = v.offset * tWidth
		v.fontstring:ClearAllPoints()
		v.fontstring:SetPoint("LEFT", anchorFrame, "LEFT", totalOffset, 0)		
		v.fontstring:SetWidth(offset)
		totalOffset = totalOffset + offset
		
		if strlower(v.text) == "icon" then
			self.maxIconWidth = offset
		end
		
		--[[
		if v.anchor and v.offset then
			v.fontstring:ClearAllPoints()
			v.fontstring:SetPoint(v.anchor, self.frame, v.anchor, v.offset, 0)
		end
		]]--
	end
	self:UpdateIconSize()
end

function barPrototype:UpdateLayout()
	local tex = Omen.Options["Skin.Bars.Texture"] or "Blizzard"
	self.texture:SetTexture(Media:Fetch("statusbar", tex))
	self.backgroundTexture:SetTexture(Media:Fetch("statusbar", tex))
	self.backgroundTexture:SetAlpha(Omen.Options["Skin.Bars.Background.Alpha"])
	local c, a = Omen.Options["Skin.Bars.Background.Color"], Omen.Options["Skin.Bars.Background.Alpha"]
	self.backgroundTexture:SetVertexColor(c, c, c, a)

	animatePercent(self, self.percent or 0, self.percent or 0)
	stretch = Omen.Options["Skin.Bars.StretchTextures"]
	if stretch then
		self.texture:SetTexCoord(0, 1, 0, 1)
	end
	self.frame:SetHeight(Omen.Options["Skin.Bars.Height"])

	-- Labels
	local size = Omen.Options["Skin.Labels.Font.Size"]
	local font = Media:Fetch("font", Omen.Options["Skin.Labels.Font.Font"])
	local color = Omen.Options["Skin.Labels.Font.Color"]
	local flags = Omen.Options["Skin.Labels.Font.Flags"]
	for k, v in pairs(self.labels) do
		v.fontstring:SetHeight(self.frame:GetHeight() - 2)
		v.fontstring:SetFont(font, size, flags)
		v.fontstring:SetTextColor(color.r, color.g, color.b, color.a)
	end
	self:UpdateIconSize()
end

function barPrototype:UpdateIconSize()
	if self.maxIconWidth then
		local h = min(self.maxIconWidth, self.frame:GetHeight())
		self.iconTexture:SetWidth(h)
		self.iconTexture:SetHeight(h)
	end	
end

function barPrototype:ConvertToK(n)
	if Omen.Options["Skin.Labels.ShortNumbers"] then
		return n > 1000 and fmt("%2.1fk", n / 1000) or fmt("%2.0f", n)
	else
		return math_floor(n)
	end
end

function barPrototype:SetPercent(p)
	p = max(0, min(1, p))
	animatePercent(self, self.currentPct or 0, p)
end

function barPrototype:SetLabel(k, text)
	if not self.labelLookup[k] then return end
	if strlower(k) == "icon" then
		if text then
			if tonumber(text) ~= nil then
				self.iconTexture:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
				SetRaidTargetIconTexture(self.iconTexture, tonumber(text))
			else
				self.iconTexture:SetTexture(text)
				self.iconTexture:SetTexCoord(0, 1, 0, 1)
			end
			self.iconTexture:ClearAllPoints()
			self.iconTexture:SetPoint("CENTER", self.labelLookup[k].fontstring, "CENTER")
			self.iconTexture:Show()
			self.maxIconWidth = self.labelLookup[k].fontstring:GetWidth()
			self.labelLookup[k].fontstring:SetText("")
			self.hasIcon = text
			self:UpdateLayout()
		else
			self.maxIconWidth = nil
			self.hasIcon = false
			self.iconTexture:Hide()
		end
	else
		self.labelLookup[k].fontstring:SetText(text)
	end
end

function barPrototype:ClearLabels()
	for k, v in ipairs(self.labels) do
		self.labels[k] = nil
		v.fontstring:ClearAllPoints()
		v.fontstring:Hide()
		tinsert(labelPool, v)
	end
end

function barPrototype:Release()
	self.unit_name = nil
	barCache[self.guid] = nil
	self.guid = nil
	self.isTitle = false
	self.value = 0
	self.real_pct = nil
	self.isTarget = nil
	self.frame:Hide()
	self.iconTexture:Hide()
	tinsert(barPool, self)
	
	self:ClearLabels()
	
	return nil
end

function Omen:GetBar(guid)
	if barCache[guid] then
		return barCache[guid]
	end
	return barPrototype:New(guid)
end

function Omen:UpdateBarLayouts()
	for k, v in pairs(barCache) do
		v:UpdateLayout()
		v:UpdateLabelPositions()
	end
end

function Omen:ResizeBars()
	for k, v in pairs(barCache) do
		v:OnResize()
	end
	for k, v in pairs(barPool) do
		v:UpdateLabelPositions()
	end
end

function Omen:ClearBars()
	for k, v in pairs(barCache) do
		v.value = 0
		v.frame:Hide()
	end
end
