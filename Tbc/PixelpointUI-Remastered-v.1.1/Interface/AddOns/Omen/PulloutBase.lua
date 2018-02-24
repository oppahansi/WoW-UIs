local MINOR_VERSION = tonumber(("$Revision: 78713 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local Media = LibStub("LibSharedMedia-3.0")
local Threat = LibStub("Threat-2.0")
local tinsert = _G.tinsert
local tremove = _G.tremove
local min, max = _G.min, _G.max

local frameCache = {}
local textureCache = {}

local barPrototype = {}


-- more flexible bar positioning
function barPrototype:SetPoints(width, pad_left, pad_right, pad_top, pad_bot)
	local left = (pad_left or 0) + 4
	local right = (pad_right or 0) + 4
	local w = max(min(width or 1, 1),0) * (self.parent:GetBarWidth() - left - right)
	local top = (pad_top or 0) + 4
	local bot = (pad_bot or 0) + 4
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOPLEFT", self.parent.frame, "TOPLEFT", left, -top)
	self.frame:SetPoint("BOTTOMLEFT", self.parent.frame, "BOTTOMLEFT", left, bot)
	self.frame:SetWidth(w)
end


local base = {}

function base:MakeFrame(frame)
	local frame = tremove(frameCache)
	if not frame then
		frame = CreateFrame("Frame", nil, UIParent)
	end
	frame.parent = self
	self.bars = {}
	self.textures = {}
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetWidth(200)
	frame:SetHeight(22)
	frame:ClearAllPoints()
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:SetFrameStrata("HIGH")
	frame:SetFrameLevel(0)
	frame:SetScript("OnMouseDown", function()
					       if arg1 == "LeftButton" and not Omen.Options["Lock"] then
						       frame:StartMoving()
					       elseif arg1 == "RightButton" then
						       frame.parent:OpenMenu()
					       end
				       end)
	frame:SetScript("OnMouseUp", function()
					     if arg1 == "LeftButton" then
						     frame:StopMovingOrSizing()
						     frame.parent:UpdateLayout()
					     end
				     end)
	self.frame = frame
end

function base:NewBar()
	bar = setmetatable({}, {__index=barPrototype})
	bar.frame = tremove(frameCache)
	if bar.frame then
		bar.frame:SetParent(self.frame)
	else
		bar.frame = CreateFrame("Frame", nil, self.frame)
	end
	bar.texture = self:NewTexture(bar.frame)
	local barTexture = Omen.Options["Skin.Pullout.Texture"] or "Blizzard"
	bar.texture:SetTexture(Media:Fetch("statusbar", barTexture))
	bar.texture:ClearAllPoints()
	bar.texture:SetPoint("TOPLEFT", bar.frame, "TOPLEFT")
	bar.texture:SetPoint("BOTTOMRIGHT", bar.frame, "BOTTOMRIGHT")
	bar.texture:SetVertexColor(1,1,1,1)
	bar.texture:Show()
	bar.parent = self
	bar.frame:ClearAllPoints()
	bar.frame:SetPoint("TOPLEFT", self.frame, "TOPLEFT")
	bar.frame:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT")
	bar.frame:Show()
	self.bars[bar] = true
	return bar
end

function base:NewTexture(parent)
	local tex = tremove(textureCache)
	if tex then
		tex:SetParent(parent)
	else
		tex = parent:CreateTexture()
	end
	tex:SetTexCoord(0,1,0,1)
	tex:SetVertexColor(1,1,1,1)
	self.textures[tex] = true
	return tex
end

function base:Release()
	for bar,_ in pairs(self.bars) do
		self:ReleaseBar(bar, true)
	end
	self.bars = {}
	self.frame:Hide()
	tinsert(frameCache, self.frame)
end

function base:ReleaseBar(bar, noremove)
	bar.frame:Hide()
	self:ReleaseTexture(bar.texture)
	bar.texture = nil
	if not noremove then
		self.bars[bar] = nil
	end
end

function base:ReleaseTexture(tex)
	tex:Hide()
	self.bars[tex] = nil
	tinsert(textureCache, tex)
end

function base:UpdateBars()
	local barTexture = Omen.Options["Skin.Pullout.Texture"] or "Blizzard"
	for i = 1, #self.bars do
		self.bars[i].texture:SetTexture(Media:Fetch("statusbar", barTexture))
	end
end

function base:GetBarWidth()
	return self.frame:GetWidth() - 8
end
function base:GetBarHeight()
	return self.frame:GetHeight() - 8
end

Omen.PulloutBase = base
