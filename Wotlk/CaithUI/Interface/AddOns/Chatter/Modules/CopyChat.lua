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
end

function mod:OnEnable()
	Chatter:AddMenuHook(self, "Menu")
end

function mod:OnDisable()
	Chatter:RemoveMenuHook(self)
end

local menuButtons = {}
function mod:Menu(chatTab, button)
	local frame = _G["ChatFrame" .. chatTab:GetID()]
	
	local info = menuButtons[chatTab:GetID()]
	if not info then
		info = {}
		info.text = L["Copy Text"]
		info.func = function() mod:Copy(frame) end
		info.notCheckable = 1;
		menuButtons[chatTab:GetID()] = info
	end
	return info
end

function mod:Copy(frame)
	local _, size = frame:GetFont()
	FCF_SetChatWindowFontSize(frame, frame, 0.01)
	local lineCt = self:GetLines(frame:GetRegions())
	local text = table_concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(frame, frame, size)
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
