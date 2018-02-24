local mod = Chatter:NewModule("Disable Buttons", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")

mod.modName = L["Disable Buttons"]

local fmt = _G.string.format
local function hide(self)
	if not self.override then
		self:Hide()
	end
	self.override = nil
end

local options = {
	bottomButton = {
		type = "toggle",
		name = L["Show bottom when scrolled"],
		desc = L["Show bottom button when scrolled up"],
		get = function()
			return mod.db.profile.scrollReminder
		end,
		set = function(info, v)
			mod.db.profile.scrollReminder = v
			if v then
				mod:EnableBottomButton()
			else
				mod:DisableBottomButton()
			end
		end
	}
}

local defaults = { profile = {} }
function mod:OnInitialize()
	self.db = Chatter.db:RegisterNamespace("Buttons", defaults)
end

function mod:OnEnable()
	ChatFrameMenuButton:Hide()
	local upButton, downButton, bottomButton
	for i = 1, NUM_CHAT_WINDOWS do
		upButton = _G[fmt("%s%d%s", "ChatFrame", i, "UpButton")]
		upButton:SetScript("OnShow", hide)
		upButton:Hide()
		downButton = _G[fmt("%s%d%s", "ChatFrame", i, "DownButton")]
		downButton:SetScript("OnShow", hide)
		downButton:Hide()
		bottomButton = _G[fmt("%s%d%s", "ChatFrame", i, "BottomButton")]
		bottomButton:SetScript("OnShow", hide)
		bottomButton:Hide()
		self:FCF_SetButtonSide(_G["ChatFrame" .. i])
	end
	
	local v = self.db.profile.scrollReminder
	if v then
		mod:EnableBottomButton()
	elseif self.buttonsEnabled then
		mod:DisableBottomButton()
	end
	self:RawHook("FCF_SetButtonSide", true)
end

function mod:OnDisable()
	self:Unhook("FCF_SetButtonSide")
	ChatFrameMenuButton:Show()
	local upButton, downButton, bottomButton
	self:DisableBottomButton()
	for i = 1, NUM_CHAT_WINDOWS do
		upButton = _G[fmt("%s%d%s", "ChatFrame", i, "UpButton")]
		upButton:SetScript("OnShow", nil)
		upButton:Show()
		downButton = _G[fmt("%s%d%s", "ChatFrame", i, "DownButton")]
		downButton:SetScript("OnShow", nil)
		downButton:Show()
		bottomButton = _G[fmt("%s%d%s", "ChatFrame", i, "BottomButton")]
		bottomButton:SetScript("OnShow", nil)
		bottomButton:Show()
		
		local f = _G["ChatFrame" .. i]
		f.buttonSide = nil
		bottomButton:ClearAllPoints()
		bottomButton:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -32, -4);
		FCF_UpdateButtonSide(f)
	end
end

function mod:FCF_SetButtonSide(chatFrame, buttonSide)
	local f = _G[chatFrame:GetName().."BottomButton"]
	f:ClearAllPoints()
	f:SetPoint("TOPRIGHT", chatFrame, "TOPRIGHT", 2, 2)
end

function mod:Info()
	return L["Hides the buttons attached to the chat frame"]
end

function mod:EnableBottomButton()
	if self.buttonsEnabled then return end
	self.buttonsEnabled = true
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame" .. i]
		if f then
			self:Hook(f, "ScrollUp", true)
			self:Hook(f, "ScrollToTop", "ScrollUp", true)
			self:Hook(f, "PageUp", "ScrollUp", true)
						
			self:Hook(f, "ScrollDown", true)
			self:Hook(f, "ScrollToBottom", "ScrollDownForce", true)
			self:Hook(f, "PageDown", "ScrollDown", true)

			if f:GetCurrentScroll() ~= 0 then
				local button = _G[f:GetName() .. "BottomButton"]
				button.override = true
				button:Show()	
			end
			
			if f ~= COMBATLOG then
				self:Hook(f, "AddMessage", true)
			end
		end
	end
end

function mod:DisableBottomButton()
	if not self.buttonsEnabled then return end
	self.buttonsEnabled = false
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame" .. i]
		if f then
			self:Unhook(f, "ScrollUp")
			self:Unhook(f, "ScrollToTop")
			self:Unhook(f, "PageUp")					
			self:Unhook(f, "ScrollDown")
			self:Unhook(f, "ScrollToBottom")
			self:Unhook(f, "PageDown")
			
			if f ~= COMBATLOG then
				self:Unhook(f, "AddMessage")
			end
			local button = _G["ChatFrame" .. i .. "BottomButton"]
			button:Hide()
		end
	end
end

function mod:ScrollUp(frame)
	local button = _G[frame:GetName() .. "BottomButton"]
	button.override = true
	button:Show()
end

function mod:ScrollDown(frame)
	if frame:GetCurrentScroll() == 0 then
		local button = _G[frame:GetName() .. "BottomButton"]
		button:Hide()	
	end
end

function mod:ScrollDownForce(frame)
	local button = _G[frame:GetName() .. "BottomButton"]
	button:Hide()	
end

function mod:AddMessage(frame, text, ...)
	local button = _G[frame:GetName() .. "BottomButton"]
	if frame:GetCurrentScroll() > 0 then
		button.override = true
		button:Show()
	else
		button:Hide()	
	end
end

function mod:GetOptions()
	return options
end
