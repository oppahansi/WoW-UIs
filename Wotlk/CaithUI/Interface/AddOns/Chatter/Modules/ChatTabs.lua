local mod = Chatter:NewModule("ChatTabs", "AceHook-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
local font = GameFontNormalSmall
mod.modName = L["Chat Tabs"]

local defaults = {
	profile = {
		height = 29
	}
}

local options = {
	height = {
		type = "range",
		name = L["Button Height"],
		desc = L["Button's height, and text offset from the frame"],
		step = 1,
		bigStep = 1,
		get = function() return mod.db.profile.height end,
		set = function(info, v)
			mod.db.profile.height = v
			for i = 1, NUM_CHAT_WINDOWS do
				local tab = _G["ChatFrame"..i.."Tab"]
				tab:SetHeight(v)
			end
		end,
		disabled = function() return not mod:IsEnabled() end
	},
	hidetabs = {
		type = "toggle",
		name = L["Hide Tabs"],
		desc = L["Hides chat frame tabs"],
		get = function() return mod.db.profile.chattabs end,
		set = function(info, v) mod.db.profile.chattabs = not mod.db.profile.chattabs; mod:ToggleTabShow() end,
	}
}

function mod:OnInitialize()
	self.db = Chatter.db:RegisterNamespace(self:GetName(), defaults)
end

local function SetFontSizes()
	for i = 1, NUM_CHAT_WINDOWS do
		local tab = _G["ChatFrame"..i.."Tab"]
		mod:OnLeave(tab)
	end
	for index,name in ipairs(self.TempChatFrames) do
		local tab = _G[name.."Tab"]
		mod:OnLeave(tab)
	end
end

function mod:Decorate(frame)
	local name = "ChatFrame"..frame:GetID();
	local tab = _G[name.."Tab"]
	tab:SetHeight(mod.db.profile.height)
	_G[name.."TabLeft"]:Hide()
	_G[name.."TabMiddle"]:Hide()
	_G[name.."TabRight"]:Hide()
	tab.leftSelectedTexture:SetAlpha(0)
	tab.rightSelectedTexture:SetAlpha(0)
	tab.middleSelectedTexture:SetAlpha(0)
	tab.leftHighlightTexture:SetTexture(nil)
	tab.rightHighlightTexture:SetTexture(nil)
	tab.middleHighlightTexture:SetTexture([[BUTTONS\CheckButtonGlow]])
	tab.middleHighlightTexture:SetWidth(76)
	tab.middleHighlightTexture:SetTexCoord(0, 0, 1, 0.5)
	tab.leftSelectedTexture:SetAlpha(0)
	tab.rightSelectedTexture:SetAlpha(0)
	tab.middleSelectedTexture:SetAlpha(0)
	tab:EnableMouseWheel(true)
	self:HookScript(tab, "OnMouseWheel")
	tab:Show()
	if (mod.db.profile.chattabs) then
		mod:HideTab(tab)
	end
end

function mod:OnEnable()
	-- self:Hook("FCF_Close", true)
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G["ChatFrame"..i]
		local tab = _G["ChatFrame"..i.."Tab"]
		tab:SetHeight(mod.db.profile.height)
		-- local flash = _G["ChatFrame"..i.."TabFlash"]
		-- flash:GetRegions():SetTexture(nil)
		_G["ChatFrame"..i.."TabLeft"]:Hide()
		_G["ChatFrame"..i.."TabMiddle"]:Hide()
		_G["ChatFrame"..i.."TabRight"]:Hide()
		tab.leftSelectedTexture:SetAlpha(0)
		tab.rightSelectedTexture:SetAlpha(0)
		tab.middleSelectedTexture:SetAlpha(0)
		tab.leftHighlightTexture:SetTexture(nil)
		tab.rightHighlightTexture:SetTexture(nil)
		tab.middleHighlightTexture:SetTexture([[BUTTONS\CheckButtonGlow]])
		tab.middleHighlightTexture:SetWidth(76)
		tab.middleHighlightTexture:SetTexCoord(0, 0, 1, 0.5)
		tab.leftSelectedTexture:SetAlpha(0)
		tab.rightSelectedTexture:SetAlpha(0)
		tab.middleSelectedTexture:SetAlpha(0)
		--[[ TODO: Grum @ 18/10/2008
		    There seems to be a bug with certain fonts/fontObjects which prevents
		    tab:GetNormalFontObject() to return anything sensible
		    The buttons now have font objects. If you change the size on one it will change on
		    the other tabs as well. However assigning a new font object seems to go wrong with
		    the default ChatFrame$Tab font-object. This will need further investigation
		
		    For now I just disabled all the font-changing mechanics.
		--]]
		tab:EnableMouseWheel(true)
		--self:HookScript(tab, "OnEnter")
		--self:HookScript(tab, "OnLeave")
		self:HookScript(tab, "OnMouseWheel")
		--self:HookScript(tab, "OnClick")
		if (mod.db.profile.chattabs) then
			mod:HideTab(tab)
		end
		-- self:RawHook(tab, "SetAlpha", true)
		-- self:RawHook(tab, "Hide", true)
		-- tab:GetTextFontObject():SetJustifyV("BOTTOM")
		--tab:SetTextColor(1, 1, 1)
		-- tab:GetHighlightTexture():SetTexture(nil)
		--[[
		if chat.isDocked or chat:IsVisible() then
			tab:Show()
		end
		]]--
	end
	for index,name in ipairs(self.TempChatFrames) do
		local chat = _G[name]
		local tab = _G[name.."Tab"]
		tab:SetHeight(mod.db.profile.height)
		_G[name.."TabLeft"]:Hide()
		_G[name.."TabMiddle"]:Hide()
		_G[name.."TabRight"]:Hide()
		tab.leftSelectedTexture:SetAlpha(0)
		tab.rightSelectedTexture:SetAlpha(0)
		tab.middleSelectedTexture:SetAlpha(0)
		tab.leftHighlightTexture:SetTexture(nil)
		tab.rightHighlightTexture:SetTexture(nil)
		tab.middleHighlightTexture:SetTexture([[BUTTONS\CheckButtonGlow]])
		tab.middleHighlightTexture:SetWidth(76)
		tab.middleHighlightTexture:SetTexCoord(0, 0, 1, 0.5)
		tab.leftSelectedTexture:SetAlpha(0)
		tab.rightSelectedTexture:SetAlpha(0)
		tab.middleSelectedTexture:SetAlpha(0)
		tab:EnableMouseWheel(true)
		if not self:IsHooked(tab,"OnMouseWheel") then
			self:HookScript(tab, "OnMouseWheel")
		end
		if (mod.db.profile.chattabs) then
			mod:HideTab(tab)
		end
	end
end

function mod:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G["ChatFrame"..i]
		local tab = _G["ChatFrame"..i.."Tab"]
		-- local flash = _G["ChatFrame"..i.."TabFlash"]
		-- flash:GetRegions():SetTexture([[Interface\ChatFrame\UI-ChatIcon-BlinkHilight]])
		tab:SetHeight(32)
		_G["ChatFrame"..i.."TabLeft"]:Show()
		_G["ChatFrame"..i.."TabMiddle"]:Show()
		_G["ChatFrame"..i.."TabRight"]:Show()
		-- tab:GetTextFontObject():SetJustifyV("MIDDLE")
		-- TODO: Check other TODO's
		--local f, s, m = font:GetFont()
		--tab:SetFont(f, s, m)
		tab:EnableMouseWheel(false)
		--tab:SetTextColor(1, 0.82, 0)
		-- tab:GetHighlightTexture():SetTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]])
		tab:Hide()
	end
	for index,name in ipairs(self.TempChatFrames) do
		local chat = _G[name]
		local tab = _G[name.."Tab"]
		tab:SetHeight(32)
		_G[name.."TabLeft"]:Show()
		_G[name.."TabMiddle"]:Show()
		_G[name.."TabRight"]:Show()
		tab:EnableMouseWheel(false)
		tab:Hide()
	end
end

function mod:FCF_Close(f)
	_G[f:GetName() .. "Tab"]:Hide()
end

function mod:OnClick(f, button, ...)
	if button == "LeftButton" then
		SetFontSizes(f)		
	end
end

function mod:ToggleTabShow()
	for i = 1, NUM_CHAT_WINDOWS do
		local tab = _G["ChatFrame"..i.."Tab"]
		if (mod.db.profile.chattabs) then
			tab:SetScript("OnShow", function(...) tab:Hide() end)
		else
			tab:SetScript("OnShow", function(...) tab:Show() end)
		end
		tab:Show()
		tab:Hide()
	end
	for index,name in ipairs(self.TempChatFrames) do
		local tab = _G[name.."Tab"]
		if (mod.db.profile.chattabs) then
			tab:SetScript("OnShow", function(...) tab:Hide() end)
		else
			tab:SetScript("OnShow", function(...) tab:Show() end)
		end
		tab:Show()
		tab:Hide()
	end
end

function mod:HideTab(tab)
	tab:SetScript("OnShow", function(...) tab:Hide() end)
end

function mod:OnMouseWheel(frame, dir)
	local chat = _G["ChatFrame" .. frame:GetID()]
	if not chat.isDocked then return end
	
	local t
	for i = 1, #GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES do
		if GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES[i]:IsVisible() then
			t = i
			break
		end
	end
	
	if t == 1 and dir > 0 then
		t = #GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES
	elseif t == #GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES and dir < 0 then
		t = 1
	elseif t then
		t = t + (dir < 0 and 1 or -1)
	end
	if t then
		_G[GENERAL_CHAT_DOCK.DOCKED_CHAT_FRAMES[t]:GetName() .. "Tab"]:Click()
	end
	--SetFontSizes()
end

function mod:OnEnter(frame)
	local f, s = font:GetFont()
	frame:SetFont(f, s + 2)
end

function mod:OnLeave(frame)
	local f, s = font:GetFont()
	if(_G["ChatFrame" .. frame:GetID()]:IsVisible()) then
		frame:SetFont(f, s + 2)
	else
		frame:SetFont(f, s - 1)
	end
end

function mod:GetOptions()
	return options
end
