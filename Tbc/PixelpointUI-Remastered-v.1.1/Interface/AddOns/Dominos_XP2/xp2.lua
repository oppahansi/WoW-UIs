--[[
        xp2.lua
		The dominos xp bar
--]]

local XP_FORMAT = '%s / %s'
local REST_FORMAT = '%s / %s (+%s)'
local REP_FORMAT = '%s:  %s / %s (%s)'
local L = LibStub('AceLocale-3.0'):GetLocale('Dominos-XP')
local _G = getfenv(0)


--[[ Module Stuff ]]--

local DXP2 = Dominos:NewModule('xp2')
local XP2

function DXP2:Load()
	self.frame = XP2:New()
	self.frame:SetFrameStrata('BACKGROUND')
end

function DXP2:Unload()
	self.frame:Free()
end


--[[ XP Object ]]--

XP2 = Dominos:CreateClass('Frame', Dominos.Frame)

function XP2:New()
	local f = self.super.New(self, 'xp2')
	if not f.bar then
		f:Load()
	end

	f:Layout()
	f:UpdateTexture()
	f:UpdateWatch()
	f:UpdateTextShown()

	return f
end

function XP2:GetDefaults()
	return {
		alwaysShowText = true,
		point = 'TOP',
		width = 0.75,
		height = 14,
		y = -32,
		x = 0,
		texture = 'blizzard'
	}
end

function XP2:Load()
	local bg = self:CreateTexture(nil, 'BACKGROUND')
	bg:SetAllPoints(self)
	self.bg = bg

	local rest = CreateFrame('StatusBar', nil, self)
	rest:EnableMouse(false)
	rest:SetAllPoints(self)
	self.rest = rest

	local value = CreateFrame('StatusBar', nil, rest)
	value:EnableMouse(false)
	value:SetAllPoints(self)
	self.value = value

	local text = value:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
	text:SetPoint('CENTER')
	self.text = text

	local click = CreateFrame('Button', nil, value)
	click:SetScript('OnClick', function() self:OnClick() end)
	click:SetScript('OnEnter', function() self:UpdateTextShown() end)
	click:SetScript('OnLeave', function() self:UpdateTextShown() end)
	click:SetAllPoints(self)
end

function XP2:OnClick()
	self:SetAlwaysShowXP2(not self.sets.alwaysShowXP2)
end

function XP2:UpdateWatch()
	if self:ShouldWatchFaction() then
		self:WatchReputation()
	else
		self:WatchExperience()
	end
end

function XP2:ShouldWatchFaction()
	return (not self.sets.alwaysShowXP2) and GetWatchedFactionInfo()
end


--[[ Experience ]]--

function XP2:WatchExperience()
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', self.OnXPEvent2)

	if not self.sets.alwaysShowXP2 then
		self:RegisterEvent('UPDATE_FACTION')
	end
	self:RegisterEvent('UPDATE_EXHAUSTION')
	self:RegisterEvent('PLAYER_XP2_UPDATE')
	self:RegisterEvent('PLAYER_LEVEL_UP')
	self:RegisterEvent('PLAYER_LOGIN')

	self.rest:SetStatusBarColor(0.25, 0.25, 1)
	self.value:SetStatusBarColor(0.6, 0, 0.6)
	self.bg:SetVertexColor(0.3, 0, 0.3, 0.6)
	self:UpdateExperience()
end

function XP2:OnXP2Event(event)
	if event == 'UPDATE_FACTION' and self:ShouldWatchFaction() then
		self:WatchReputation()
	else
		self:UpdateExperience()
	end
end

function XP2:UpdateExperience()
	local value = UnitXP('player')
	local max = UnitXPMax('player')
	local percent = floor(value / max * 1000 + 0.5) / 10

	self.value:SetMinMaxValues(0, max)
	self.value:SetValue(value)

	local rest = GetXPExhaustion()
	self.rest:SetMinMaxValues(0, max)

	if rest then
		self.rest:SetValue(value + rest)
		self.text:SetFormattedText(REST_FORMAT, value, max, rest)
	else
		self.rest:SetValue(0)
		self.text:SetFormattedText(XP_FORMAT, value, max)
	end
end


--[[ Reputation ]]--

function XP2:WatchReputation()
	self:UnregisterAllEvents()
	self:RegisterEvent('UPDATE_FACTION')
	self:SetScript('OnEvent', self.OnRepEvent)

	self.rest:SetValue(0)
	self.rest:SetStatusBarColor(0, 0, 0, 0)
	self:UpdateReputation()
end

function XP2:OnRepEvent(event)
	if self:ShouldWatchFaction() then
		self:UpdateReputation()
	else
		self:UpdateWatch()
	end
end

function XP2:UpdateReputation()
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	max = max - min
	value = value - min

	local color = FACTION_BAR_COLORS[reaction]
	self.value:SetStatusBarColor(color.r, color.g, color.b)
	self.bg:SetVertexColor(color.r - 0.3, color.g - 0.3, color.b - 0.3, 0.6)

	self.value:SetMinMaxValues(0, max)
	self.value:SetValue(value)

	local repLevel = _G['FACTION_STANDING_LABEL' .. reaction]
	self.text:SetFormattedText(REP_FORMAT, name, value, max, repLevel)
end


--[[ Layout ]]--

function XP2:Layout()
	self:SetWidth(GetScreenWidth() * self.sets.width / 100)
	self:SetHeight(self.sets.height * 2)
end

function XP2:SetTexture(texture)
	self.sets.texture = texture
	self:UpdateTexture()
end

function XP2:UpdateTexture()
	local texture = LibStub('LibSharedMedia-3.0'):Fetch('statusbar', self.sets.texture)
	self.value:SetStatusBarTexture(texture)
	self.rest:SetStatusBarTexture(texture)
	self.bg:SetTexture(texture)
end

function XP2:SetAlwaysShowXP2(enable)
	self.sets.alwaysShowXP2 = enable
	self:UpdateWatch()
end


--[[ Text ]]--

function XP2:UpdateTextShown()
	if MouseIsOver(self) or self.sets.alwaysShowText then
		self.text:Show()
	else
		self.text:Hide()
	end
end

function XP2:ToggleText(enable)
	self.sets.alwaysShowText = enable or nil
	self:UpdateTextShown()
end


--[[
	Layout Panel
--]]

local function CreateWidthSlider(p)
	local s = p:NewSlider(L.Width, 1, 100, 1)

	s.OnShow = function(self)
		self:SetValue(self:GetParent().owner.sets.width * 100)
	end

	s.UpdateValue = function(self, value)
		local f = self:GetParent().owner
		f.sets.width = value
		f:Layout()
	end
end

local function CreateHeightSlider(p)
	local s = p:NewSlider(L.Height, 1, 100, 1, OnShow)

	s.OnShow = function(self)
		self:SetValue(self:GetParent().owner.sets.height)
	end

	s.UpdateValue = function(self, value)
		local f = self:GetParent().owner
		f.sets.height = value
		f:Layout()
	end
end

local function AddLayoutPanel(menu)
	local p = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('Dominos-Config').Layout)

	p:NewOpacitySlider()
	p:NewFadeSlider()
	p:NewScaleSlider()
	CreateHeightSlider(p)
	CreateWidthSlider(p)

	local showText = p:NewCheckButton(L.AlwaysShowText)
	showText:SetScript('OnClick', function(self) self:GetParent().owner:ToggleText(self:GetChecked()) end)
	showText:SetScript('OnShow', function(self) self:SetChecked(self:GetParent().owner.sets.alwaysShowText) end)

	local showXP2 = p:NewCheckButton(L.AlwaysShowXP2)
	showXP2:SetScript('OnClick', function(self) self:GetParent().owner:SetAlwaysShowXP2(self:GetChecked()) end)
	showXP2:SetScript('OnShow', function(self) self:SetChecked(self:GetParent().owner.sets.alwaysShowXP2) end)
end


--[[
	Texture Picker
--]]

--yeah I know I'm bad in that I didn't capitialize some constants
local NUM_ITEMS = 9
local width, height, offset = 140, 20, 2

local function TextureButton_OnClick(self)
	DXP2.frame:SetTexture(self:GetText())
	self:GetParent():UpdateList()
end

local function TextureButton_OnMouseWheel(self, direction)
	local scrollBar = _G[self:GetParent().scroll:GetName() .. 'ScrollBar']
	scrollBar:SetValue(scrollBar:GetValue() - direction * (scrollBar:GetHeight()/2))
	parent:UpdateList()
end

local function TextureButton_Create(name, parent)
	local button = CreateFrame('Button', name, parent)
	button:SetWidth(width)
	button:SetHeight(height)

	button.bg = button:CreateTexture()
	button.bg:SetAllPoints(button)

	local r, g, b = max(random(), 0.2), max(random(), 0.2), max(random(), 0.2)
	button.bg:SetVertexColor(r, g, b)
	button:EnableMouseWheel(true)
	button:SetScript('OnClick', TextureButton_OnClick)
	button:SetScript('OnMouseWheel', TextureButton_OnMouseWheel)
	button:SetTextColor(1, 0.82, 0)
	button:SetHighlightTextColor(1, 1, 1)

	local text = button:CreateFontString()
	text:SetFontObject('GameFontNormal')
	text:SetJustifyH('LEFT')
	text:SetAllPoints(button)
	button:SetFontString(text)

	return button
end

local function Panel_UpdateList(self)
	local SML = LibStub('LibSharedMedia-3.0')
	local textures = LibStub('LibSharedMedia-3.0'):List('statusbar')
	local currentTexture = DXP2.frame.sets.texture

	local scroll = self.scroll
	FauxScrollFrame_Update(scroll, #textures, #self.buttons, height + offset)
	
	for i,button in pairs(self.buttons) do
		local index = i + scroll.offset
	
		if index <= #textures then
			button:SetText(textures[index])
			button.bg:SetTexture(SML:Fetch('statusbar', textures[index]))
			button:Show()
		else
			button:Hide()
		end
	end
end

local function AddTexturePanel(menu)
	local p = menu:NewPanel(L.Texture)
	p.UpdateList = Panel_UpdateList
	p:SetScript('OnShow', function() p:UpdateList() end)
	p.textures = LibStub('LibSharedMedia-3.0'):List('statusbar')

	local name = p:GetName()
	local scroll = CreateFrame('ScrollFrame', name .. 'ScrollFrame', p, 'FauxScrollFrameTemplate')
	scroll:SetScript('OnVerticalScroll', function() FauxScrollFrame_OnVerticalScroll(height + offset, function() p:UpdateList() end) end)
	scroll:SetScript('OnShow', function() p.buttons[1]:SetWidth(width) end)
	scroll:SetScript('OnHide', function() p.buttons[1]:SetWidth(width + 20) end)
	scroll:SetPoint('TOPLEFT', 8, 0)
	scroll:SetPoint('BOTTOMRIGHT', -24, 2)
	p.scroll = scroll

	--add list buttons
	p.buttons = {}
	for i = 1, NUM_ITEMS do
		local b = TextureButton_Create(name .. i, p)
		if i == 1 then
			b:SetPoint('TOPLEFT', 4, 0)
		else
			b:SetPoint('TOPLEFT', name .. i-1, 'BOTTOMLEFT', 0, -offset)
			b:SetPoint('TOPRIGHT', name .. i-1, 'BOTTOMRIGHT', 0, -offset)
		end
		p.buttons[i] = b
	end

	p.height = 200
end


--[[ Menu Code ]]--

function XP2:CreateMenu()
	local menu = Dominos:NewMenu(self.id)
	AddLayoutPanel(menu)
	AddTexturePanel(menu)

	self.menu = menu
end
