local mod = Chatter:NewModule("Alt Linking", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
mod.modName = L["Alt Linking"]

local NAMES
local pairs = _G.pairs
local select = _G.select
local setmetatable = _G.setmetatable
local tinsert = _G.tinsert
local tremove = _G.tremove
local type = _G.type
local unpack = _G.unpack

local defaults = { realm = {}, profile = {colorMode = "COLOR_MOD", color = {0.6, 0.6, 0.6} } }
local colorModes = {
	COLOR_MOD = L["Use PlayerNames coloring"],
	CUSTOM = L["Use custom color"],
	CHANNEL = L["Use channel color"]
}

local customColorNames = setmetatable({}, {
	__index = function(t, v)
		local r, g, b = unpack(mod.db.profile.color)
		t[v] = ("|cff%02x%02x%02x%s|r"):format(r * 255, g  * 255, b * 255, v)
		return t[v]
	end
})

local options = {
	colorMode = {
		type = "select",
		name = L["Name color"],
		desc = L["Set the coloring mode for alt names"],
		values = colorModes,
		get = function()
			return mod.db.profile.colorMode
		end,
		set = function(info, v)
			mod.db.profile.colorMode = v
		end
	},
	color = {
		type = "color",
		name = L["Custom color"],
		desc = L["Select the custom color to use for alt names"],
		get = function()
			return unpack(mod.db.profile.color)
		end,
		set = function(info, r, g, b)
			mod.db.profile.color[1] = r
			mod.db.profile.color[2] = g
			mod.db.profile.color[3] = b
			for k, v in pairs(customColorNames) do
				customColorNames[k] = nil
			end
		end,
		disabled = function() return mod.db.profile.colorMode ~= "CUSTOM" end
	}
}

local accept = function(char)
	local editBox = _G[this:GetParent():GetName().."EditBox"]
	local main = editBox:GetText()
	mod:AddAlt(char, main)
	this:GetParent():Hide()
end

StaticPopupDialogs['MENUITEM_SET_MAIN'] = {
	text		= L["Who is %s's main?"],
	button1		= TEXT(ACCEPT),
	button2		= TEXT(CANCEL),
	hasEditBox	= 1,
	maxLetters	= 128,
	exclusive	= 0,
	OnShow = function()
		_G[this:GetName().."EditBox"]:SetFocus()
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:SetFocus();
		end
		_G[this:GetName().."EditBox"]:SetText("");
	end,
	OnAccept = accept,
	EditBoxOnEnterPressed = accept,
	EditBoxOnEscapePressed = function() this:GetParent():Hide() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}	

UnitPopupButtons["SET_MAIN"] = {
	text = L["Set Main"],
	dist = 0,
	func = mod.GetMainName
}

function mod:OnInitialize()
	self.db = Chatter.db:RegisterNamespace("AltLinks", defaults)
end

function mod:OnEnable()
	NAMES = self.db.realm
	UnitPopupButtons["SET_MAIN"].func = self.GetMainName
	tinsert(UnitPopupMenus["SELF"], 	#UnitPopupMenus["SELF"] - 1,	"SET_MAIN")
	tinsert(UnitPopupMenus["PLAYER"], 	#UnitPopupMenus["PLAYER"] - 1,	"SET_MAIN")
	tinsert(UnitPopupMenus["FRIEND"],	#UnitPopupMenus["FRIEND"] - 1,	"SET_MAIN")
	tinsert(UnitPopupMenus["PARTY"], 	#UnitPopupMenus["PARTY"] - 1,	"SET_MAIN")
	self:SecureHook("UnitPopup_ShowMenu")
	
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	self.colorMod = Chatter:GetModule("Player Class Colors")
end

local types = {"SELF", "PLAYER", "FRIEND", "PARTY"}
function mod:OnDisable()
	for j = 1, #types do
		local t = types[j]
		for i = 1, #UnitPopupMenus[t] do
			if UnitPopupMenus[t][i] == "SET_MAIN" then
				tremove(UnitPopupMenus[t], i)
				break
			end
		end
	end
end

function mod.GetMainName()
	local alt = _G[UIDROPDOWNMENU_INIT_MENU].name
	local popup = StaticPopup_Show("MENUITEM_SET_MAIN", alt)
	if popup then popup.data = alt end
end

function mod:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		local button = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i];
		if button.value == "SET_MAIN" then
		    button.func = UnitPopupButtons["SET_MAIN"].func
		end
	end
end

function mod:AddAlt(alt, main)
	if #main == 0 then main = nil end
	self.db.realm[alt] = main	
end

local function pName(msg, name)
	if name and #name > 0 then
		local alt = NAMES[name]
		if alt then
			local mode = mod.db.profile.colorMode
			if mode == "CUSTOM" then				
				alt = customColorNames[alt]
			elseif mode == "COLOR_MOD" and mod.colorMod and mod.colorMod:IsEnabled() then
				alt = mod.colorMod.names[alt]
			end
			return msg .. "[" .. alt .. "]"
		end
	end
	return msg
end

function mod:AddMessage(frame, text, ...)
	if text and type(text) == "string" then 
		text = text:gsub("(|Hplayer:([^:]+)[:%d+]*|h%[.-%]|h)", pName)
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function mod:Info()
	return L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name."]
end

function mod:GetOptions()
	return options
end
