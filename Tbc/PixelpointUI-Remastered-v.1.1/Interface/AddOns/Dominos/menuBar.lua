--[[
	Dominos
		Because sometimes I feel bad about doing to much
--]]

local menuButtons = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	QuestLogMicroButton,
	SocialsMicroButton,
	LFGMicroButton,
	MainMenuMicroButton,
	HelpMicroButton
}

do
	--mess with the talent button to make it hide properly, it causes layout issues otherwise
	TalentMicroButton.UpdateShown = function(self)
		if UnitLevel('player') < 10 then
			self:Hide()
		elseif Dominos.Frame:Get('menu') then
			self:Show()
		end
	end

	TalentMicroButton:SetScript('OnEvent', function(self, event)
		if event == 'PLAYER_LEVEL_UP' then
			self:UpdateShown()
			if not CharacterFrame:IsShown() then
				SetButtonPulse(self, 60, 1)
			end
		elseif event == 'UNIT_LEVEL' or event == 'PLAYER_ENTERING_WORLD' then
			self:UpdateShown()
		elseif event == 'UPDATE_BINDINGS' then
			self.tooltipText =  MicroButtonTooltipText(TALENTS_BUTTON, 'TOGGLETALENTS')
		end
	end)
end


--[[ Menu Bar ]]--

local MenuBar = Dominos:CreateClass('Frame', Dominos.Frame)
Dominos.MenuBar  = MenuBar

function MenuBar:New()
	local f = self.super.New(self, 'menu')
	f:LoadButtons()
	f:Layout()

	return f
end

function MenuBar:GetDefaults()
	return {
		point = 'BOTTOMRIGHT',
		x = -244,
		y = 0,
		numButtons = #menuButtons,
	}
end

function MenuBar:AddButton(i)
	local b = menuButtons[i]
	b:SetParent(self.header)

	if b.UpdateShown then
		b:UpdateShown()
	else
		b:Show()
	end

	self.buttons[i] = b
end

function MenuBar:RemoveButton(i)
	local b = self.buttons[i]
	b:SetParent(nil)
	b:Hide()

	self.buttons[i] = nil
end

--override, because the menu bar has weird button sizes
local WIDTH_OFFSET = 2
local HEIGHT_OFFSET = 20

function MenuBar:Layout()
	if #self.buttons > 0 then
		local cols = min(self:NumColumns(), #self.buttons)
		local rows = ceil(#self.buttons / cols)
		local pW, pH = self:GetPadding()
		local spacing = self:GetSpacing()

		local b = self.buttons[1]
		local w = b:GetWidth() + spacing - WIDTH_OFFSET
		local h = b:GetHeight() + spacing - HEIGHT_OFFSET

		for i,b in pairs(self.buttons) do
			local col = (i-1) % cols
			local row = ceil(i / cols) - 1
			b:ClearAllPoints()
			b:SetPoint('TOPLEFT', w*col + pW, -(h*row + pH) + HEIGHT_OFFSET)
		end

		self:SetWidth(w*cols - spacing + pW*2 + WIDTH_OFFSET)
		self:SetHeight(h*ceil(#self.buttons/cols) - spacing + pH*2)
	else
		self:SetWidth(30); self:SetHeight(30)
	end
end