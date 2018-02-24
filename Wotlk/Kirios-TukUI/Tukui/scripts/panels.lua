-- ACTION BAR PANEL
TukuiDB.buttonsize = TukuiDB.Scale(27)
TukuiDB.buttonspacing = TukuiDB.Scale(4)
TukuiDB.petbuttonsize = TukuiDB.Scale(29)
TukuiDB.petbuttonspacing = TukuiDB.Scale(4)
ChatPos = 1

local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(10))
if TukuiDB.lowversion == true or not TukuiDB.lowversion and TukuiCF.actionbar.lowversion then
	barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
else
	barbg:SetWidth((TukuiDB.buttonsize * 22) + (TukuiDB.buttonspacing * 23))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
end
--barbg:SetBackdrop(nil) --YAN
barbg:SetFrameStrata("LOW")
barbg:SetFrameLevel(2)
TukuiDB.CreateShadow(barbg)

-- INVISIBLE FRAME COVERING TukuiActionBarBackground
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
invbarbg:SetSize(barbg:GetWidth(), barbg:GetHeight())
invbarbg:SetPoint("CENTER", barbg, "CENTER", 0, 0)

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", UIParent)
TukuiDB.CreatePanel(ileft, TukuiCF["panels"].tinfowidth, 20, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(10), TukuiDB.Scale(10))
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")
TukuiDB.CreateShadow(ileft)

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", UIParent)
TukuiDB.CreatePanel(iright, TukuiCF["panels"].tinfowidth, 20, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(-10), TukuiDB.Scale(10))
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")
TukuiDB.CreateShadow(iright)

-- CHAT LEFT
local chatleft = CreateFrame("Frame", "ChatLeft", UIParent)
TukuiDB.CreatePanel(chatleft, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(126), "BOTTOMLEFT", ileft, "TOPLEFT", 0, TukuiDB.Scale(3))
chatleft:SetFrameLevel(2)
HydraDB.SetBorder(chatleft)
TukuiDB.CreateShadow(chatleft)

-- CHAT RIGHT
local chatright = CreateFrame("Frame", "ChatRight", UIParent)
TukuiDB.CreatePanel(chatright, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(126), "BOTTOMRIGHT", iright, "TOPRIGHT", 0, TukuiDB.Scale(3))
chatright:SetFrameLevel(2)
HydraDB.SetBorder(chatright)
TukuiDB.CreateShadow(chatright)

local ChatReg = CreateFrame("Frame")
ChatReg:RegisterEvent("ADDON_LOADED")
ChatReg:RegisterEvent("PLAYER_LOGOUT")
function ChatReg:OnEvent(event)
	if event == "ADDON_LOADED" then
		if SavedChatPos == nil then
			ChatPos = 1
			SavedChatPos = 1
		end
		if SavedChatPos then
			ChatPos = SavedChatPos
		else
			ChatPos = 1
		end
	elseif event == "PLAYER_LOGOUT" then
		SavedChatPos = ChatPos
	end
end
ChatReg:SetScript("OnEvent", ChatReg.OnEvent)

local ChatPanelCheck = CreateFrame("Frame")
local function UpdateChatPanels(self)
	if not ChatLeft:IsVisible() then
		ChatPos = 2
	else
		ChatPos = 1
	end
end
ChatPanelCheck:SetScript("OnUpdate", UpdateChatPanels)

local ChatPanelSaver = CreateFrame("Frame")
ChatPanelSaver:RegisterEvent("ADDON_LOADED")
ChatPanelSaver:HookScript("OnEvent", function(self, event)
	if  event == "ADDON_LOADED" then
		if ChatPos == 2 then
			ChatRight:Hide()
			ChatLeft:Hide()
		end
	end
end)

-- CHAT TAB LEFT PANEL
local ttableft = CreateFrame("Frame", "TukuiTabLeft", chatleft)
TukuiDB.CreatePanel(ttableft, TukuiCF["panels"].tinfowidth, 16, "BOTTOMLEFT", chatleft, "TOPLEFT", 0, TukuiDB.Scale(3))
ttableft:SetFrameLevel(2)
HydraDB.SetBorder(ttableft)
TukuiDB.CreateShadow(ttableft)

-- CHAT TAB RIGHT PANEL
local ttabright = CreateFrame("Frame", "TukuiTabRight", chatright)
TukuiDB.CreatePanel(ttabright, TukuiCF["panels"].tinfowidth, 16, "BOTTOMLEFT", chatright, "TOPLEFT", 0, TukuiDB.Scale(3))
ttabright:SetFrameLevel(2)
HydraDB.SetBorder(ttabright)
TukuiDB.CreateShadow(ttabright)

-- RIGHT BAR BACKGROUND
if TukuiCF["actionbar"].enable == true then
	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
	TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-10), TukuiDB.Scale(15))
	if TukuiCF["actionbar"].rightbars == 1 then
		barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].rightbars == 2 then
		barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	elseif TukuiCF["actionbar"].rightbars == 3 then
		barbgr:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	else
		barbgr:Hide()
	end

	TukuiDB.CreateShadow(barbgr)
	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
	if TukuiCF["actionbar"].rightbars > 0 then
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", barbgr, "LEFT", TukuiDB.Scale(-6), 0)
	else
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-6), TukuiDB.Scale(-13.5))
	end
	TukuiDB.CreateShadow(petbg)
end

-- BATTLEGROUND STATS FRAME
if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
	bgframe:Hide()
	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "pvp") then
				bgframe:Show()
			else
				bgframe:Hide()
			end
		end
	end
	bgframe:RegisterEvent("PLAYER_ENTERING_WORLD")
	bgframe:SetScript("OnEvent", OnEvent)
end

-- BOTTOM BAR
local tbottombar = CreateFrame("Frame", "TukuiBottomBar", UIParent)
TukuiDB.CreatePanel(tbottombar, 1, 22, "TOP", UIParent, "TOP", 0, 0)
tbottombar:ClearAllPoints()
tbottombar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(-6), TukuiDB.Scale(-6))
tbottombar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(6), TukuiDB.Scale(-6))
tbottombar:SetFrameStrata("BACKGROUND")
tbottombar:SetFrameLevel(0)
TukuiDB.CreateShadow(tbottombar)

-- CHAT
AnimGroup(ChatLeft, TukuiDB.Scale(-375), 0, 0.4)
AnimGroup(ChatRight, TukuiDB.Scale(375), 0, 0.4)

-- ENABLE INFO BARS FOR TOGGLE
TukuiInfoLeft:EnableMouse(true)
TukuiInfoLeft:SetScript("OnMouseDown", function(self)
	if not ChatLeft:IsVisible() then
		SlideIn(ChatRight)
		SlideIn(ChatLeft)
	else
		SlideOut(ChatLeft)
		SlideOut(ChatRight)
	end
end)

TukuiInfoRight:EnableMouse(true)
TukuiInfoRight:SetScript("OnMouseDown", function(self)
	if not ChatLeft:IsVisible() then
		SlideIn(ChatRight)
		SlideIn(ChatLeft)
	else 
		SlideOut(ChatLeft)
		SlideOut(ChatRight)
	end
end)

TukuiInfoLeftBattleGround:SetScript("OnMouseDown", function(self)
	if not ChatLeft:IsVisible() then
		SlideIn(ChatRight)
		SlideIn(ChatLeft)
	else 
		SlideOut(ChatLeft)
		SlideOut(ChatRight)
	end
end)

-- COLOR INFO RIGHT SHADOW IF WE HAVE A WHISPER
local function ChatAlertSys(self)
	local HydraChatAlert = CreateFrame("Frame")
	HydraChatAlert:RegisterEvent("CHAT_MSG_WHISPER")
	HydraChatAlert:RegisterEvent("CHAT_MSG_BN_WHISPER")
	HydraChatAlert:HookScript("OnEvent", function(self, event)
		if  event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" then
			TukuiInfoLeft.shadow:SetBackdropBorderColor(0,0.7,1,0.8)
		end
	end)
end

local ChatAlert = CreateFrame("Frame")
local function UpdateChatAlert(self)
	if not ChatLeft:IsVisible() then
		return ChatAlertSys()
	elseif ChatLeft:IsVisible() then
		TukuiInfoLeft.shadow:SetBackdropBorderColor(0,0,0,0.5)
	end
end
ChatAlert:SetScript("OnUpdate", UpdateChatAlert)