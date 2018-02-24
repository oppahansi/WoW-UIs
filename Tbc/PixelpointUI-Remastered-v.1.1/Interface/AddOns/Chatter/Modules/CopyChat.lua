local mod = Chatter:NewModule("Chat Copy", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Copy Chat"]

local lines = {}
local table_concat = _G.table.concat
local CreateFrame = _G.CreateFrame
local GetSpellInfo = _G.GetSpellInfo
local select = _G.select
local tinsert = _G.tinsert
local tostring = _G.tostring

local PaneBackdrop  = {
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
}

local InsetBackdrop  = {
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
}

local buttons = {}

function mod:OnInitialize()
	local frame = CreateFrame("Frame", "ChatterCopyFrame", UIParent)
	tinsert(UISpecialFrames, "ChatterCopyFrame")
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropColor(0,0,0,1)
	frame:SetWidth(500)
	frame:SetHeight(400)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
	self.frame = frame
	
	local scrollArea = CreateFrame("ScrollFrame", "ChatterCopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)
	
	local editBox = CreateFrame("EditBox", nil, frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(400)
	editBox:SetHeight(270)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	self.editBox = editBox
	
	scrollArea:SetScrollChild(editBox)
	
	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	
	local tex = select(3, GetSpellInfo(586))
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		local button = CreateFrame("Button", nil, cf)
		button:SetPoint("BOTTOMRIGHT", cf, "BOTTOMRIGHT", 0, -5)
		button:SetHeight(10)
		button:SetWidth(10)
		button:SetNormalTexture(tex)
		button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
		button:SetScript("OnClick", function()
			mod:Copy(cf)
		end)
		button:SetScript("OnEnter", function(self)
			self:SetHeight(28)
			self:SetWidth(28)
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["Copy text from this frame."])
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function(self)
			button:SetHeight(10)
			button:SetWidth(10)
			GameTooltip:Hide()
		end)
		button:Hide()
		tinsert(buttons, button)
	end
end

function mod:OnEnable()
	for i = 1, #buttons do
		local p = buttons[i]:GetParent()
		local tab = _G["ChatFrame" .. i .. "Tab"]
		self:HookScript(tab, "OnShow")
		self:HookScript(tab, "OnHide")
		tab.copyButton = buttons[i]
	end
end

function mod:OnDisable()
	for i = 1, #buttons do
		buttons[i]:Hide()		
	end
end

function mod:OnShow(cft)
	local cfn = cft:GetName():match("ChatFrame%d")
	if cfn and _G[cfn]:IsVisible() then
		cft.copyButton:Show()
	end
end

function mod:OnHide(cft)
	local cfn = cft:GetName():match("ChatFrame%d")
	if cfn and _G[cfn]:IsVisible() then
		cft.copyButton:Hide()
	end
end

function mod:Copy(frame)
	local _, size = frame:GetFont()
	FCF_SetChatWindowFontSize(frame, 0.01)
	local lineCt = self:GetLines(frame:GetRegions())
	local text = table_concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(frame, size)
	self.frame:Show()
	self.editBox:SetText(text)
	self.editBox:HighlightText(0)
end

function mod:GetLines(...)
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

function mod:Info()
	return L["Lets you copy text out of your chat frames."]
end
