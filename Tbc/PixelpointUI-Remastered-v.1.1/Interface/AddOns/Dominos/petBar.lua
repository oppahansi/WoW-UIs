--[[
	Dominos
		Because sometimes I feel bad about doing to much
--]]

--libs and omgspeed
local _G = getfenv(0)
local format = string.format

local KeyBound = LibStub('LibKeyBound-1.0')
local LBF = LibStub('LibButtonFacade', true)


--[[ Pet Button ]]--

local PetButton = Dominos:CreateClass('CheckButton')

function PetButton:New(id)
	local b = PetButton:Restore(id) or PetButton:Create(id)
	b:UpdateHotkey()
	
	return b
end

function PetButton:Create(id)
	local b = self:Bind(_G['PetActionButton' .. id])
	b:SetScript('OnEnter', self.OnEnter)

	if LBF then
		LBF:Group('Dominos', 'Pet Bar'):AddButton(b)
	else
		_G[b:GetName() .. 'Icon']:SetTexCoord(0.06, 0.94, 0.06, 0.94)
		b:GetNormalTexture():SetVertexColor(1, 1, 1, 0.5)
	end
	return b
end

function PetButton:Restore(id)
	local unused = self.unused
	if unused then
		b = unused[id]
		if b then
			unused[id] = nil
			b:Show()
			return b
		end
	end
end

function PetButton:Free()
	local unused = PetButton.unused or {}
	unused[self:GetID()] = self
	PetButton.unused = unused

	self:SetParent(nil)
	self:Hide()
end

--keybound support
function PetButton:OnEnter()
	if Dominos:ShowTooltips() then
		self:RCall(PetActionButton_OnEnter)
	end
	KeyBound:Set(self)
end

function PetButton:UpdateHotkey()
	local hotkey = _G[self:GetName() .. 'HotKey']
	local key = KeyBound:ToShortKey(GetBindingKey('BONUSACTIONBUTTON'..self:GetID()) or GetBindingKey(format('CLICK %s:LeftButton', self:GetName()))) 
	hotkey:SetText(key)

	if key ~= ''  and Dominos:ShowBindingText() then
		hotkey:Show()
	else
		hotkey:Hide()
	end
end

function PetButton:GetHotkey()
	return KeyBound:ToShortKey(GetBindingKey(format('CLICK %s:LeftButton', self:GetName())))
end

--you can hopefully guess what the 'R' stands for
function PetButton:RCall(f, ...)
	local pThis = this
	this = self
	f(...)
	this = pThis
end

PetActionButton_SetHotkeys = function() PetButton.UpdateHotkey(this) end


--[[ Pet Bar ]]--

local PetBar = Dominos:CreateClass('Frame', Dominos.Frame)
Dominos.PetBar  = PetBar

function PetBar:New()
	local f = self.super.New(self, 'pet')
	f:LoadButtons()
	f:Layout()
	f:UpdateStateDriver()

	return f
end

function PetBar:UpdateStateDriver()
	if self == Dominos:GetPossessBar() then
		self:SetShowStates('[target=pet,nodead,exists]')
	else
		self:SetShowStates('[target=pet,nodead,exists,nobonusbar:5]')
	end
end

function PetBar:GetDefaults()
	return {
		point = 'CENTER',
		x = 0,
		y = -32,
		numButtons = 10,
		spacing = 6
	}
end

function PetBar:AddButton(i)
	local b = PetButton:New(i)
	b:SetParent(self.header)
	self.buttons[i] = b
end

function PetBar:RemoveButton(i)
	local b = self.buttons[i]
	self.buttons[i] = nil
	b:Free()
end


--[[ keybound  support ]]--

function PetBar:KEYBOUND_ENABLED()
	self:SetShowStates(nil)
	for _,button in pairs(self.buttons) do
		button:Show()
	end
end

function PetBar:KEYBOUND_DISABLED()
	self:UpdateStateDriver()

	local petBarShown = PetHasActionBar()
	for _,button in pairs(self.buttons) do
		if petBarShown and GetPetActionInfo(button:GetID()) then
			button:Show()
		else
			button:Hide()
		end
	end
end