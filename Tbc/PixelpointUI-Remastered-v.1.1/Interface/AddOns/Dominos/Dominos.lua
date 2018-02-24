--[[
	Dominos.lua
		Driver for Dominos Frames
--]]

Dominos = LibStub('AceAddon-3.0'):NewAddon('Dominos', 'AceEvent-3.0', 'AceConsole-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('Dominos')
local CURRENT_VERSION = GetAddOnMetadata('Dominos', 'Version')


--[[ Startup ]]--

function Dominos:OnInitialize()
	--register database events
	self.db = LibStub('AceDB-3.0'):New('DominosDB', self:GetDefaults(), 'Default')
	self.db.RegisterCallback(self, 'OnNewProfile')
	self.db.RegisterCallback(self, 'OnProfileChanged')
	self.db.RegisterCallback(self, 'OnProfileCopied')
	self.db.RegisterCallback(self, 'OnProfileReset')
	self.db.RegisterCallback(self, 'OnProfileDeleted')

	--version update
	if DominosVersion then
		if DominosVersion ~= CURRENT_VERSION then
			self:UpdateSettings(DominosVersion:match('(%w+)%.(%w+)%.(%w+)'))
			self:UpdateVersion()
		end
	--new user
	else
		DominosVersion = CURRENT_VERSION
	end

	--slash command support
	self:RegisterSlashCommands()

	--create a loader for the options menu
	local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
	f:SetScript('OnShow', function(self)
		self:SetScript('OnShow', nil)
		LoadAddOn('Dominos_Config')
	end)

	--keybound support
	local kb = LibStub('LibKeyBound-1.0')
	kb.RegisterCallback(self, 'LIBKEYBOUND_ENABLED')
	kb.RegisterCallback(self, 'LIBKEYBOUND_DISABLED')

	--button facade support
	local LBF = LibStub('LibButtonFacade', true)
	if LBF then
		LBF:RegisterSkinCallback('Dominos', self.OnSkin, self)
	end

	--hide blizzard junk
	self:HideBlizzard()
end

function Dominos:OnEnable()
	self:Load()
end

--[[ Version Updating ]]--

function Dominos:GetDefaults()
	return {
		profile = {
			possessBar = 1,

			showMacroText = true,
			showBindingText = true,
			showTooltips = true,

			ab = {
				count = 10,
				showgrid = true,
				style = {'Entropy: Copper', 0.5, true},
			},

			petStyle  = {'Entropy: Silver', 0.5, nil},

			classStyle = {'Entropy: Silver', 0.5, nil},

--			bagStyle = {'Entropy: Bronze', 0.5, nil},

			frames = {}
		}
	}
end

function Dominos:UpdateSettings(major, minor, bugfix)
	--do stuff
end

function Dominos:UpdateVersion()
	DominosVersion = CURRENT_VERSION
	self:Print(format(L.Updated, DominosVersion))
end


--Load is called  when the addon is first enabled, and also whenever a profile is loaded
local function HasClassBar()
	local _,class = UnitClass('player')
	return class == 'PALADIN' or class == 'DRUID' or class == 'WARRIOR' or class == 'ROGUE'
end

function Dominos:Load()
	for i = 1, self:NumBars() do
		self.ActionBar:New(i)
	end
	if HasClassBar() then
		self.ClassBar:New()
	end
	self.PetBar:New()
	self.BagBar:New()
	self.MenuBar:New()

	--button facade support
	local bf = LibStub('LibButtonFacade', true)
	if bf then
		bf:Group('Dominos', 'Action Bar'):Skin(unpack(self.db.profile.ab.style))
		bf:Group('Dominos', 'Pet Bar'):Skin(unpack(self.db.profile.petStyle))
		bf:Group('Dominos', 'Class Bar'):Skin(unpack(self.db.profile.classStyle))
--		bf:Group('Dominos', 'Bag Bar'):Skin(unpack(self.db.profile.bagStyle))
	end

	--load in extra functionality
	for _,module in self:IterateModules() do
		module:Load()
	end

	--anchor everything
	self.Frame:ForAll('Reanchor')
end

--unload is called when we're switching profiles
function Dominos:Unload()
	self.ActionBar:ForAll('Free')
	self.Frame:ForFrame('pet', 'Free')
	self.Frame:ForFrame('class', 'Free')
	self.Frame:ForFrame('menu', 'Free')
	self.Frame:ForFrame('bags', 'Free')

	--unload any module stuff
	for _,module in self:IterateModules() do
		module:Unload()
	end
end


--[[ Blizzard Stuff Hiding ]]--

function Dominos:HideBlizzard()
	RANGE_INDICATOR = ''
	MultiActionBar_UpdateGrid = Multibar_EmptyFunc

	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarRight'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarLeft'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarBottomLeft'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarBottomRight'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MainMenuBar'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['ShapeshiftBarFrame'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['PossessBarFrame'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['PETACTIONBAR_YPOS'] = nil

	MainMenuBar:UnregisterAllEvents()
	MainMenuBar:Hide()

	MainMenuBarArtFrame:UnregisterAllEvents()
	MainMenuBarArtFrame:Hide()

	MainMenuExpBar:UnregisterAllEvents()
	MainMenuExpBar:Hide()

	ShapeshiftBarFrame:UnregisterAllEvents()
	ShapeshiftBarFrame:Hide()

	BonusActionBarFrame:UnregisterAllEvents()
	BonusActionBarFrame:Hide()

	PossessBarFrame:UnregisterAllEvents()
	PossessBarFrame:Hide()
end


--[[ Button Facade Events ]]--

function Dominos:OnSkin(skin, glossAlpha, gloss, group, _, colors)
	local styleDB
	if group == 'Action Bar' then
		styleDB = self.db.profile.ab.style
	elseif group == 'Pet Bar' then
		styleDB = self.db.profile.petStyle
	elseif group == 'Class Bar' then
		styleDB = self.db.profile.classStyle
	end

	if styleDB then
		styleDB[1] = skin
		styleDB[2] = glossAlpha
		styleDB[3] = gloss
		styleDB[4] = colors
	end
end


--[[ Keybound Events ]]--

function Dominos:LIBKEYBOUND_ENABLED()
	for _,frame in self.Frame:GetAll() do
		if frame.KEYBOUND_ENABLED then
			frame:KEYBOUND_ENABLED()
		end
	end
end

function Dominos:LIBKEYBOUND_DISABLED()
	for _,frame in self.Frame:GetAll() do
		if frame.KEYBOUND_DISABLED then
			frame:KEYBOUND_DISABLED()
		end
	end
end


--[[ Profile Functions ]]--

function Dominos:SaveProfile(name)
	local toCopy = self.db:GetCurrentProfile()
	if name and name ~= toCopy then
		self:Unload()
		self.db:SetProfile(name)
		self.db:CopyProfile(toCopy)
		self.isNewProfile = nil
		self:Load()
	end
end

function Dominos:SetProfile(name)
	local profile = self:MatchProfile(name)
	if profile and profile ~= self.db:GetCurrentProfile() then
		self:Unload()
		self.db:SetProfile(profile)
		self.isNewProfile = nil
		self:Load()
	else
		self:Print(format(L.InvalidProfile, name or 'null'))
	end
end

function Dominos:DeleteProfile(name)
	local profile = self:MatchProfile(name)
	if profile and profile ~= self.db:GetCurrentProfile() then
		self.db:DeleteProfile(profile)
	else
		self:Print(L.CantDeleteCurrentProfile)
	end
end

function Dominos:CopyProfile(name)
	if name and name ~= self.db:GetCurrentProfile() then
		self:Unload()
		self.db:CopyProfile(name)
		self.isNewProfile = nil
		self:Load()
	end
end

function Dominos:ResetProfile()
	self:Unload()
	self.db:ResetProfile()
	self.isNewProfile = true
	self:Load()
end

function Dominos:ListProfiles()
	self:Print(L.AvailableProfiles)

	local current = self.db:GetCurrentProfile()
	for _,k in ipairs(self.db:GetProfiles()) do
		if k == current then
			DEFAULT_CHAT_FRAME:AddMessage(' - ' .. k, 1, 1, 0)
		else
			DEFAULT_CHAT_FRAME:AddMessage(' - ' .. k)
		end
	end
end

function Dominos:MatchProfile(name)
	local name = name:lower()
	local nameRealm = name .. ' - ' .. GetRealmName():lower()
	local match

	for i, k in ipairs(self.db:GetProfiles()) do
		local key = k:lower()
		if key == name then
			return k
		elseif key == nameRealm then
			match = k
		end
	end
	return match
end


--[[ Profile Events ]]--

function Dominos:OnNewProfile(msg, db, name)
	self.isNewProfile = true
	self:Print(format(L.ProfileCreated, name))
end

function Dominos:OnProfileDeleted(msg, db, name)
	self:Print(format(L.ProfileDeleted, name))
end

function Dominos:OnProfileChanged(msg, db, name)
	self:Print(format(L.ProfileLoaded, name))
end

function Dominos:OnProfileCopied(msg, db, name)
	self:Print(format(L.ProfileCopied, name))
end

function Dominos:OnProfileReset(msg, db)
	self:Print(format(L.ProfileReset, db:GetCurrentProfile()))
end


--[[ Settings...Setting ]]--

function Dominos:SetFrameSets(id, sets)
	local id = tonumber(id) or id
	self.db.profile.frames[id] = sets

	return self.db.profile.frames[id]
end

function Dominos:GetFrameSets(id)
	return self.db.profile.frames[tonumber(id) or id]
end


--[[ Options Menu Display ]]--

function Dominos:ShowOptions()
	if LoadAddOn('Dominos_Config') then
		InterfaceOptionsFrame_OpenToFrame('Dominos')
		return true
	end
	return false
end

function Dominos:NewMenu(id)
	if not self.Menu then
		LoadAddOn('Dominos_Config')
	end
	return self.Menu:New(id)
end


--[[ Slash Commands ]]--

function Dominos:RegisterSlashCommands()
	self:RegisterChatCommand('dominos', 'OnCmd')
	self:RegisterChatCommand('dom', 'OnCmd')
end

function Dominos:OnCmd(args)
	local cmd = string.split(' ', args):lower() or args:lower()

	--frame functions
	if cmd == 'config' or cmd == 'lock' then
		self:ToggleLockedFrames()
	elseif cmd == 'scale' then
		self:ScaleFrames(select(2, string.split(' ', args)))
	elseif cmd == 'setalpha' then
		self:SetOpacityForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'fade' then
		self:SetFadeForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'setcols' then
		self:SetColumnsForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'pad' then
		self:SetPaddingForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'space' then
		self:SetSpacingForFrame(select(2, string.split(' ', args)))
	elseif cmd == 'show' then
		self:ShowFrames(select(2, string.split(' ', args)))
	elseif cmd == 'hide' then
		self:HideFrames(select(2, string.split(' ', args)))
	elseif cmd == 'toggle' then
		self:ToggleFrames(select(2, string.split(' ', args)))
	--actionbar functions
	elseif cmd == 'numbars' then
		self:SetNumBars(tonumber(select(2, string.split(' ', args))))
	--profile functions
	elseif cmd == 'save' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:SaveProfile(profileName)
	elseif cmd == 'set' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:SetProfile(profileName)
	elseif cmd == 'copy' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:CopyProfile(profileName)
	elseif cmd == 'delete' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:DeleteProfile(profileName)
	elseif cmd == 'reset' then
		self:ResetProfile()
	elseif cmd == 'list' then
		self:ListProfiles()
	elseif cmd == 'version' then
		self:PrintVersion()
	elseif cmd == 'help' or cmd == '?' then
		self:PrintHelp()
	--options stuff
	else
		if not self:ShowOptions() then
			self:PrintHelp()
		end
	end
end

function Dominos:PrintHelp(cmd)
	local function PrintCmd(cmd, desc)
		DEFAULT_CHAT_FRAME:AddMessage(format(' - |cFF33FF99%s|r: %s', cmd, desc))
	end

	self:Print('Commands (/dom, /dominos)')
	PrintCmd('config', L.ConfigDesc)
	PrintCmd('scale <frameList> <scale>', L.SetScaleDesc)
	PrintCmd('setalpha <frameList> <opacity>', L.SetAlphaDesc)
	PrintCmd('fade <frameList> <opacity>', L.SetFadeDesc)
	PrintCmd('setcols <frameList> <columns>', L.SetColsDesc)
	PrintCmd('pad <frameList> <padding>', L.SetPadDesc)
	PrintCmd('space <frameList> <spacing>', L.SetSpacingDesc)
	PrintCmd('show <frameList>', L.ShowFramesDesc)
	PrintCmd('hide <frameList>', L.HideFramesDesc)
	PrintCmd('toggle <frameList>', L.ToggleFramesDesc)
	PrintCmd('save <profile>', L.SaveDesc)
	PrintCmd('set <profile>', L.SetDesc)
	PrintCmd('copy <profile>', L.CopyDesc)
	PrintCmd('delete <profile>', L.DeleteDesc)
	PrintCmd('reset', L.ResetDesc)
	PrintCmd('list', L.ListDesc)
	PrintCmd('version', L.PrintVersionDesc)
end

--version info
function Dominos:PrintVersion()
	self:Print(DominosVersion)
end


--[[ Configuration Functions ]]--

--moving
Dominos.locked = true

function Dominos:SetLock(enable)
	self.locked = enable or false
	if self.locked then
		self.Frame:ForAll('Lock')
	else
		self.Frame:ForAll('Unlock')
	end
end

function Dominos:Locked()
	return self.locked
end

function Dominos:ToggleLockedFrames()
	self:SetLock(not self:Locked())
end

--scale
function Dominos:ScaleFrames(...)
	local numArgs = select('#', ...)
	local scale = tonumber(select(numArgs, ...))

	if scale and scale > 0 and scale <= 10 then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetFrameScale', scale)
		end
	end
end

--opacity
function Dominos:SetOpacityForFrames(...)
	local numArgs = select('#', ...)
	local alpha = tonumber(select(numArgs, ...))

	if alpha and alpha >= 0 and alpha <= 1 then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetFrameAlpha', alpha)
		end
	end
end

--faded opacity
function Dominos:SetFadeForFrames(...)
	local numArgs = select('#', ...)
	local alpha = tonumber(select(numArgs, ...))

	if alpha and alpha >= 0 and alpha <= 1 then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetFadeAlpha', alpha)
		end
	end
end

--columns
function Dominos:SetColumnsForFrames(...)
	local numArgs = select('#', ...)
	local cols = tonumber(select(numArgs, ...))

	if cols then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetColumns', cols)
		end
	end
end

--spacing
function Dominos:SetSpacingForFrame(...)
	local numArgs = select('#', ...)
	local spacing = tonumber(select(numArgs, ...))

	if spacing then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetSpacing', spacing)
		end
	end
end

--padding
function Dominos:SetPaddingForFrames(...)
	local numArgs = select('#', ...)
	local pW, pH = select(numArgs - 1, ...)

	if tonumber(pW) and tonumber(pH) then
		for i = 1, numArgs - 2 do
			self.Frame:ForFrame(select(i, ...), 'SetPadding', tonumber(pW), tonumber(pH))
		end
	end
end

--visibility
function Dominos:ShowFrames(...)
	for i = 1, select('#', ...) do
		self.Frame:ForFrame(select(i, ...), 'ShowFrame')
	end
end

function Dominos:HideFrames(...)
	for i = 1, select('#', ...) do
		self.Frame:ForFrame(select(i, ...), 'HideFrame')
	end
end

function Dominos:ToggleFrames(...)
	for i = 1, select('#', ...) do
		self.Frame:ForFrame(select(i, ...), 'ToggleFrame')
	end
end

--empty button display
function Dominos:ToggleGrid()
	self:SetShowGrid(not self:ShowGrid())
end

function Dominos:SetShowGrid(enable)
	self.db.profile.showgrid = enable or false
	self.ActionBar:ForAll('UpdateGrid')
end

function Dominos:ShowGrid()
	return self.db.profile.showgrid
end

--right click selfcast
function Dominos:SetRightClickUnit(unit)
	self.db.profile.ab.rightClickUnit = unit
	self.ActionBar:ForAll('UpdateRightClickUnit')
end

function Dominos:GetRightClickUnit()
	return self.db.profile.ab.rightClickUnit
end

--binding text
function Dominos:SetShowBindingText(enable)
	self.db.profile.showBindingText = enable or false

	for _,f in self.Frame:GetAll() do
		if f.buttons then
			for _,b in pairs(f.buttons) do
				if b.UpdateHotkey then
					b:UpdateHotkey()
				end
			end
		end
	end
end

function Dominos:ShowBindingText()
	return self.db.profile.showBindingText
end

--macro text
function Dominos:SetShowMacroText(enable)
	self.db.profile.showMacroText = enable or false

	for _,f in self.Frame:GetAll() do
		if f.buttons then
			for _,b in pairs(f.buttons) do
				if b.UpdateMacro then
					b:UpdateMacro()
				end
			end
		end
	end
end

function Dominos:ShowMacroText()
	return self.db.profile.showMacroText
end

--possess bar settings
function Dominos:SetPossessBar(id)
	local prevBar = self:GetPossessBar()
	self.db.profile.possessBar = id
	local newBar = self:GetPossessBar()

	prevBar:UpdateStateDriver()
	newBar:UpdateStateDriver()
end

function Dominos:GetPossessBar()
	return self.Frame:Get(self.db.profile.possessBar)
end

--action bar numbers
function Dominos:SetNumBars(count)
	count = max(min(count, 120), 1) --sometimes, I do entertaininig things

	if count ~= self:NumBars() then
		self.ActionBar:ForAll('Delete')
		self.db.profile.ab.count = count

		for i = 1, self:NumBars() do
			self.ActionBar:New(i)
		end
	end
end

function Dominos:NumBars()
	return self.db.profile.ab.count
end

--tooltips
function Dominos:ShowTooltips()
	return self.db.profile.showTooltips
end

function Dominos:SetShowTooltips(enable)
	self.db.profile.showTooltips = enable or false
end


--[[ Utility Functions ]]--

--utility function: create a widget class
function Dominos:CreateClass(type, parentClass)
	local class = CreateFrame(type)
	class.mt = {__index = class}

	if parentClass then
		class = setmetatable(class, {__index = parentClass})
		class.super = parentClass
	end

	function class:Bind(o)
		return setmetatable(o, self.mt)
	end

	return class
end