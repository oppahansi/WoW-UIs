local K, C, L, _ = select(2, ...):unpack()

local _G = _G
local unpack = unpack
local select = select
local sort = table.sort
local GetAddOnInfo = GetAddOnInfo
local CreateFrame = CreateFrame
local UIParent = UIParent
local GetNumAddOns = GetNumAddOns
local GetAddOnDependencies = GetAddOnDependencies

local AddonList = CreateFrame("frame", "Addons", UIParent)
AddonList:SetSize(350, 450)
AddonList:SetPoint("CENTER")
AddonList:EnableMouse(true)
AddonList:SetMovable(true)
AddonList:SetUserPlaced(true)
AddonList:SetClampedToScreen(true)
AddonList:SetScript("OnMouseDown", function(self) self:StartMoving() end)
AddonList:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
AddonList:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "Addons")

local CloseButton = CreateFrame("Button", "CloseButton", AddonList, "UIPanelCloseButton")
CloseButton:SetSize(26, 26)
CloseButton:SetPoint("BOTTOMRIGHT", AddonList, "TOPRIGHT", 0, -26)
CloseButton:SetScript("OnClick", function() AddonList:Hide() end)

local ReloadButton = CreateFrame("Button", "ReloadButton", AddonList, "UIPanelButtonTemplate")
ReloadButton:SetSize(105, 20)
ReloadButton:SetPoint("BOTTOM", AddonList, "BOTTOM", 0, 10)
ReloadButton:SetText(L_ADDON_RELOAD)
ReloadButton:SetScript("OnClick", function() ReloadUI() end)

AddonList:Hide()
AddonList:SetScript("OnHide", function(self) end)
AddonList:SetBackdrop(K.Backdrop)
AddonList:SetBackdropColor(unpack(C.Media.Backdrop_Color))

local title = AddonList:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -8)
title:SetText("|cff2eb6ffAddonList|r")

local ScrollFrame = CreateFrame("ScrollFrame", "AddonsScrollFrame", AddonList, "UIPanelScrollFrameTemplate")
local MainAddonFrame = CreateFrame("frame", "AddonsFrame", ScrollFrame)

ScrollFrame:SetPoint("TOPLEFT", AddonList, "TOPLEFT", 10, -30)
ScrollFrame:SetPoint("BOTTOMRIGHT", AddonList, "BOTTOMRIGHT", -28, 40)
ScrollFrame:SetScrollChild(MainAddonFrame)

local makeList = function()
	local self = MainAddonFrame
	self:SetPoint("TOPLEFT")
	self:SetWidth(ScrollFrame:GetWidth())
	self:SetHeight(ScrollFrame:GetHeight())
	self.addons = {}
	for i = 1, GetNumAddOns() do
		self.addons[i] = select(1, GetAddOnInfo(i))
	end
	sort(self.addons)

	local oldb

	for i,v in pairs(self.addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)

		if name then
			local CheckButton = _G[v.."_cCheckButton"] or CreateFrame("CheckButton", v.."_cCheckButton", self, "OptionsCheckButtonTemplate")
			CheckButton:EnableMouse(true)
			CheckButton.title = title.."|n"
			if notes then CheckButton.title = CheckButton.title.."|cffffffff"..notes.."|r|n" end
			if (GetAddOnDependencies(v)) then
				CheckButton.title = "|cffff4400Dependencies: |r"
				for i=1, select("#", GetAddOnDependencies(v)) do
					CheckButton.title = CheckButton.title..select(i,GetAddOnDependencies(v))
					if (i>1) then CheckButton.title=CheckButton.title..", " end
				end
				CheckButton.title = CheckButton.title.."|r"
			end

			if i==1 then
				CheckButton:SetPoint("TOPLEFT",self, "TOPLEFT", 10, -10)
			else
				CheckButton:SetPoint("TOP", oldb, "BOTTOM", 0, 6)
			end

			CheckButton:SetScript("OnEnter", function(self)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
				GameTooltip:AddLine(self.title)
				GameTooltip:Show()
			end)

			CheckButton:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)

			CheckButton:SetScript("OnClick", function()
				local _, _, _, enabled = GetAddOnInfo(name)
				if enabled then
					DisableAddOn(name)
				else
					EnableAddOn(name)
				end
			end)
			CheckButton:SetChecked(enabled)

			_G[v.."_cCheckButtonText"]:SetText(title)
			oldb = CheckButton
		end
	end
end

makeList()

-- Credits to Bunny67
local EnableAllButton = CreateFrame("Button", "EnableAllButton", AddonList, "UIPanelButtonTemplate")
EnableAllButton:SetSize(105, 20)
EnableAllButton:SetPoint("RIGHT" , ReloadButton, "LEFT", 0, 0)
EnableAllButton:SetText(L_ADDON_ENABLE_ALL)
EnableAllButton:SetScript("OnClick", function() EnableAllAddOns() makeList() end)

local DisableAllButton = CreateFrame("Button", "DisableAllButton", AddonList, "UIPanelButtonTemplate")
DisableAllButton:SetSize(105, 20)
DisableAllButton:SetPoint("LEFT" , ReloadButton, "RIGHT", 0, 0)
DisableAllButton:SetText(L_ADDON_DISABLE_ALL)
DisableAllButton:SetScript("OnClick", function() DisableAllAddOns() makeList() end)

-- Slash command
SLASH_ADDONLIST1 = "/addons"
SlashCmdList.ADDONLIST = function(msg)
	if InCombatLockdown() and not IsShown then K.Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return end
	PlaySound("igMainMenuOption")
	if GameMenuFrame:IsShown() then
		HideUIPanel(GameMenuFrame)
	end
	AddonList:Show()
end

local AddonListButton = CreateFrame("Button", "AddonListButton", GameMenuFrame, "GameMenuButtonTemplate")
AddonListButton:SetText(L_ADDON_LIST)
AddonListButton:SetPoint("TOP", GameMenuButtonMacros, "BOTTOM", 0, -1)

AddonListButton:SetScript("OnClick", function()
	if InCombatLockdown() and not IsShown then K.Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return end
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not AddonList or not AddonList:IsShown() then
		AddonList:Show()
	else
		AddonList:Hide()
	end
end)

GameMenuButtonLogout:SetPoint("TOP", AddonListButton, "BOTTOM", 0, -16)

if(IsMacClient()) then
	GameMenuFrame:SetHeight(292)
else
	GameMenuFrame:SetHeight(266)
end