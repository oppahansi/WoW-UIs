--[[

	myChat
	by turkoid
	
	Based on oChat and fane by haste
	http://github.com/haste
	
]]--

local addon, ns = ...
local myChat = CreateFrame('frame')
local cfg = ns.Config

--Localize this!
local _G, type, unpack, ipairs = getfenv(0), type, unpack, ipairs
local _ChatFrame_OnHyperlinkShow

--Global vars
local hooks = {}
local dummy = function() end
local LAST_SELECTED_CHAT_FRAME = ChatFrame1
local SelectChatFrame

--Register Events
myChat:RegisterEvent('ADDON_LOADED')
myChat:RegisterEvent('PLAYER_ENTERING_WORLD')
myChat:RegisterEvent('VARIABLES_LOADED')

--Functions
local hex = function(r, g, b)
	if type(r) == 'table' then
		if r.r then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
	end
	return string.format('|cff%02x%02x%02x', r*255, g*255, b*255)
end

local link = function(name, val, text)
	return '|H'..name..':'..val..'|h'..text..'|h'
end

local urlLink = function(val)
	local lnk = link('url', val, cfg.formats.brackets.url:format(val))
	if cfg.url.color then lnk = hex(cfg.url.color)..lnk..'|r' end
	return lnk
end

local safeprint = function(cf, text, ...)
	hooks[cf](cf, link('myChat','', cfg.copychat.button)..'|cff00ff00DEBUG: |r'..text, ...)
end

local AddMessage = function(cf, text, ...)
	--When you right click a channel and move it to a different window
	--Blizzard resends all the lines from that channel through AddMessage again
	--So only apply formatting if we haven't already
	if not cfg.blacklist[cf] and type(text) == 'string' then 
		--safeprint(cf, text:gsub('|', '||'), ...) --debugging
		--Tagging:  |c[01][01] --The first confirms its been formatted, the 2nd confirms its been timestamped
		--Afaik nothing uses the alpha portion of the color escape seq.
		if not text:find('^|c1') then 
			if cfg.battlenet.color then
				text = text:gsub('(|HBNplayer.-|h)%[(.-)%]|h', cfg.battlenet.color)
			end
			if not cfg.formats.brackets.name then
				text = text:gsub('(|HBNplayer.-|h)%[(.-)%]|h', '%1%2|h') --This doesnt produce any extra strings if we set a color to bnet name
				text = text:gsub('(|Hplayer.-|h)%[(.-)%]|h', '%1%2|h')
			end
			
			--Battlenet Conversations
			if cfg.formats.conversation then
				text = text:gsub('(|Hchannel:BN_CONVERSATION:)(%d+)|h%[(%d+)%. (.-)%]|h:?%s?(.+)', cfg.formats.conversation)
			end
			--Regular Channels
			if cfg.formats.channel then
				text = text:gsub('(|Hchannel:.-|h)%[(%d+)%. (.-)%]|h(.*)(|Hplayer.+)', cfg.formats.channel)
			end
			
			if cfg.url.enabled then
				for _, url in ipairs(cfg.formats.url) do
					text = text:gsub(url.match, url.replace)
				end
			end
			if not text:find('^|c[01]') then
				text = '|c10ffffff|r'..text
			else
				text = text:gsub('^|c0', '|c1')
			end
		end
		
		--Add timestamp, copybutton and tag the line
		if (cfg.timestamps.enabled or cfg.copychat.enabled) and not text:find('^|c11') then
			text = cfg.formats.tag:format(cfg.timestamps.enabled and cfg.timestamps.custom and BetterDate(cfg.timestamps.custom, time()) or '', text)
		end
	end
	return hooks[cf](cf, text, ...)
end

--TellTarget functions
local TellTarget = function(msg)
	local name, realm = UnitName('target')
	if not msg then
		if name and realm and not UnitIsSameServer('player', 'target') then
			name = name..'-'..realm:gsub(' ', '')
		end
		ChatFrame_SendTell(name and name:gsub(' ', '') or '*notarget*', SELECTED_CHAT_FRAME)
	else
		SendChatMessage(msg, 'WHISPER', nil, name)
	end
end

local TT_Send = function(eb)
	if eb:GetText():sub(1, 4) == '/tt ' then TellTarget() end
end

local InsertText = function(text, overwrite)
	local eb = LAST_ACTIVE_CHAT_EDIT_BOX
	eb:Insert(text)
	if cfg.chatstyle == 'im' then 
		overwrite = overwrite or eb:GetAlpha() < 1
		ChatEdit_ActivateChat(eb) 
	end	
	if overwrite or not eb:IsShown() then
		eb:Show()
		eb:HighlightText()
		eb:SetFocus()
	end	
end

local GetLineText = function(...)
	for l = 1, select('#', ...) do
		local obj = select(l, ...)
		if obj:GetObjectType() == 'FontString' and obj:IsMouseOver() then
			return obj:GetText()
		end
	end
end

--Update Functions
local UpdateTag = function(hook)
	cfg.timestamps.custom = not hook and cfg.timestamps.custom or (CHAT_TIMESTAMP_FORMAT and CHAT_TIMESTAMP_FORMAT:gsub('%s$', ''))
	
	local tag = '|c%d1ffffff|r%s%s'	
	local f_timestamp = cfg.timestamps.custom and cfg.formats.timestamps:format(cfg.timestamps.custom) or ''
	local timestamp = cfg.timestamps.enabled and cfg.timestamps.custom and cfg.formats.timestamps or '%s'
	local button = cfg.copychat.enabled and (cfg.copychat.showbutton or not cfg.timestamps.custom) and cfg.formats.button or ''
		
	if CHAT_TIMESTAMP_FORMAT then
		CHAT_TIMESTAMP_FORMAT = tag:format(0, button, f_timestamp)
	elseif Blizzard_CombatLog_Filters and not cfg.blacklist[ChatFrame2] then
		--Blizzard_CombatLog_Filters.filters[1].settings.timestamp = false
	end		
	if cfg.timestamps.enabled and not cfg.blacklist[ChatFrame2] then		
		TEXT_MODE_A_STRING_TIMESTAMP = tag:format(1, button, timestamp)..'%s'
	end
	
	cfg.formats.tag = tag:format(0, cfg.copychat.enabled and not cfg.timestamps.enabled and cfg.formats.button or button, timestamp)..'%s'
end

local ToggleBottomButton = function(cf)
	if cf:AtBottom() and cf.BottomButton:IsVisible() then
		cf.BottomButton:Hide()
		UIFrameFlashRemoveFrame(cf.BottomButtonFlash)
	elseif not cf:AtBottom() and not cf.BottomButton:IsVisible() then
		cf.BottomButton:Show()
		UIFrameFlash(cf.BottomButtonFlash, 0, 0, -1, false, CHAT_BUTTON_FLASH_TIME, CHAT_BUTTON_FLASH_TIME)
	end   
end

local UpdateFS = function(tab)
	local l1 = tab:GetID() == (cfg.chatstyle == 'im' and LAST_ACTIVE_CHAT_EDIT_BOX:GetParent():GetID() or SELECTED_CHAT_FRAME:GetID()) and 'current' or 'default'
	local l2 = tab:IsMouseOver() and 'hover' or (cfg.tabs.flash.text and tab.alerting and 'flash') or 'normal'
	local r, g, b, a, o = unpack(cfg.tabs.color[l1][l2])
	local font, size = GameFontNormalSmall:GetFont()
	
	local fs = tab:GetFontString()
	fs:SetFont(cfg.tabs.font.name or font, cfg.tabs.font.size or size, o and cfg.tabs.font.outline)	
	fs:SetTextColor(r, g, b, a)
end

local UpdateEditBoxLocation = function(cf)
	local loc = cfg.editbox.docking.location	
	local offset = cfg.editbox.docking.offset
	local anchor, targetanchor

	if loc == 'top' then
		local pos = cfg.editbox.docking.position[cf == ChatFrame1 and cfg.chatstyle or 'im']
		anchor = pos == 'below' and 'TOP' or 'BOTTOM'
		targetanchor = 'TOP'
		offset = offset + (pos == 'above' and 24 or 0)
	else
		anchor = 'TOP'
		targetanchor = 'BOTTOM'
		offset = offset - 2
	end

	cf.editBox:ClearAllPoints()
	cf.editBox:SetPoint(anchor..'LEFT', cf, targetanchor..'LEFT', -3, offset)
	cf.editBox:SetPoint(anchor..'RIGHT', cf, targetanchor..'RIGHT', 3, offset)
end

local UpdateChatStyle = function()
	cfg.chatstyle = GetCVar('chatStyle') or 'classic'
	if cfg.editbox.fix then UpdateEditBoxLocation(ChatFrame1) end
end

--Tab Initialization
local tab_OnDragStart = function(tab)
	SelectChatFrame(_G['ChatFrame'..tab:GetID()])
end
local InitializeTab = function(tab)
	if tab.myChat_initialized then return end
	
	local tabParts = {'Left', 'Middle', 'Right'}
	
	local id = tab:GetID()	
	tab:SetAlpha(1)
	tab.SetAlpha = dummy
	
	--Flashing tabs
	if not cfg.tabs.flash.texture then
		_G['ChatFrame'..id..'TabFlash']:Hide()
		_G['ChatFrame'..id..'TabFlash'].Show = dummy
	end
	if not cfg.tabs.flash.glow then
		tab.glow:SetTexture(nil)
	end
	
	for _, part in ipairs(tabParts) do
		_G['ChatFrame'..id..'Tab'..part]:SetTexture(nil)
		_G['ChatFrame'..id..'TabSelected'..part]:SetTexture(nil)
		_G['ChatFrame'..id..'TabHighlight'..part]:SetTexture(nil)
	end	
	
	tab.fs = tab:GetFontString()
	if cfg.tabs.font.shadow.enabled then
		tab.fs:SetShadowColor(unpack(cfg.tabs.font.shadow.color))
		tab.fs:SetShadowOffset(unpack(cfg.tabs.font.shadow.offset))
	end
	
	tab:HookScript('OnDragStart', tab_OnDragStart)
	tab:HookScript('OnEnter', UpdateFS)
	tab:HookScript('OnLeave', UpdateFS)

	tab.myChat_initialized = true
end

--ChatFrame Initialization
local eb_SetAlpha = function(eb, alpha)
	if alpha < 1 then eb:Hide() end
end
local cf_OnFocus = function(self)
	SelectChatFrame(self:GetParent())	
end
local InitializeChatFrame = function(cf)
	if cf.myChat_initialized then return end
	
	local ebParts = {'Left', 'Mid', 'Right'}
	local hideButtons = {'UpButton', 'DownButton', 'BottomButton'}
	
	local id = cf:GetID()
	cf:SetFading(false)

	local b = nil
	for _, btn in ipairs(hideButtons) do
		b = _G['ChatFrame'..id..'ButtonFrame'..btn]
		b:Hide()
		if btn ~= 'BottomButton' then				
			b.Show = dummy				
		else
			b:ClearAllPoints()
			b:SetPoint('BOTTOMRIGHT', cf, 'BOTTOMRIGHT', -5, 0)
			b.SetPoint = dummy
			b:SetParent(cf)
			b:SetScript('OnShow', function(b) ToggleBottomButton(b:GetParent()) end)
			b:SetScript('OnClick', function(self) 
				self:GetParent():ScrollToBottom()
				ToggleBottomButton(self:GetParent())
			end)
			cf.BottomButton = b
			cf.BottomButtonFlash = _G['ChatFrame'..id..'ButtonFrameBottomButtonFlash']
		end				
	end
				
	local bf = _G['ChatFrame'..id..'ButtonFrame']
	bf:Hide()
	bf.show = dummy
	
	local eb = _G['ChatFrame'..id..'EditBox']
	if cfg.editbox.enabled then
		--editbox textures
		for _, ebPart in ipairs(ebParts) do
			if type(cfg.editbox.textures.normal) == 'table' then
				_G['ChatFrame'..id..'EditBox'..ebPart]:SetTexture(unpack(cfg.editbox.textures.normal))
			end
			if type(cfg.editbox.textures.focus) == 'table' then
				_G['ChatFrame'..id..'EditBoxFocus'..ebPart]:SetTexture(unpack(cfg.editbox.textures.focus))
			end
			if cfg.editbox.textures.alpha then
				_G['ChatFrame'..id..'EditBox'..ebPart]:SetAlpha(cfg.editbox.textures.alpha)
			end
		end
		
		--editbox location
		UpdateEditBoxLocation(cf)
		
		if cfg.editbox.font.shadow.enabled then
			eb:SetShadowColor(unpack(cfg.editbox.font.shadow.color))
			eb:SetShadowOffset(unpack(cfg.editbox.font.shadow.offset))
		end
		
		if cfg.tabs.enabled then 
			_G['ChatFrame'..id..'ClickAnywhereButton']:HookScript('OnClick', cf_OnFocus)
		end
	end	
	if not cfg.tweaks.im_alpha then
		eb:SetAlpha(1)
		hooksecurefunc(eb, 'SetAlpha', eb_SetAlpha)
	end
	eb:SetAltArrowKeyMode(false)
	eb:HookScript('OnTextChanged', TT_Send)	
	
	cf:SetClampedToScreen(false)
	
	if cfg.formats.enabled and not cfg.blacklist[cf] and cf ~= ChatFrame2 then
		hooks[cf] = cf.AddMessage
		cf.AddMessage = AddMessage
	end
	
	cf:HookScript('OnShow', ToggleBottomButton)
	cf.myChat_initialized = true
end

local UpdateTab = function(tab)
	InitializeTab(tab)
	InitializeChatFrame(_G['ChatFrame'..tab:GetID()])
	UpdateFS(tab)
end

SelectChatFrame = function(cf)
	if SELECTED_CHAT_FRAME ~= cf then
		FCF_Tab_OnClick(_G['ChatFrame'..cf:GetID()..'Tab'])
	end
	UpdateTab(_G['ChatFrame'..cf:GetID()..'Tab'])
	if LAST_SELECTED_CHAT_FRAME and LAST_SELECTED_CHAT_FRAME ~= cf then
		UpdateTab(_G['ChatFrame'..LAST_SELECTED_CHAT_FRAME:GetID()..'Tab'])	
	end	
	LAST_SELECTED_CHAT_FRAME = cf
end

local ValidateFontSettings = function(settings, inherit)
	local validOutlines = {
		['thick'] 	= 'THICKOUTLINE',
		['thin'] 	= 'THINOUTLINE',
		['none'] 	= '',
	}
	if settings.enabled then
		local myChatFont = myChatFont or CreateFont('myChatFont')
		if settings.name then
			local isValid = myChatFont:SetFont(settings.name, 8) --validate font		
			if not isValid then	settings.name = false end
		end
		settings.outline = validOutlines[settings.outline]	
		if not settings.name and not settings.size and not settings.outline and not settings.shadow.enabled then
			settings.enabled = false --Disable module if all options are false
		else
			--Any newly created frames will recieve the custom settings.  This happens when you have battle.net conversations open in a new tab
			local name, size, outline = inherit:GetFont()
			settings.name = settings.name or name
			settings.size = settings.size or size
			settings.outline = settings.outline or outline
		end
	else
		settings.name = false
		settings.size = false
		settings.outline = false
		settings.shadow.enabled = false
	end
end

--This only sets some default values as well as sets up some values I use later on, just saves me If...Then statements
--It doesnt provide type checking (ie. You assign a string to a font size). 
local SetupConfigFile = function()	
	UpdateChatStyle()
	
	--Validates chatframe fonts	
	ValidateFontSettings(cfg.font, ChatFontNormal)
		
	--Validate editbox config
	if cfg.editbox.enabled then --no need to validate if module disabled	
		cfg.editbox.docking.location = cfg.editbox.docking.location or 'bottom'		
		if cfg.editbox.docking.location == 'top' then
			local validPositions = {
				im = {
					default = 'above',
					['above'] = 'above',
					['below'] = 'below',
				},
				classic = {
					default = 'center',
					['above'] = 'above',
					['center'] = 'center',
					['below'] = 'below',
				},
			}
			for chatstyle, positions in pairs(validPositions) do
				cfg.editbox.docking.position[chatstyle] = positions[cfg.editbox.docking.position[chatstyle]] or positions.default
			end			
			if cfg.editbox.docking.position.classic ~= cfg.editbox.docking.position.im then
				cfg.editbox.fix = true --No need to hook setting chatstyle in interface options if both positions are the same
			end
		end			
		cfg.editbox.docking.offset = cfg.editbox.docking.offset or 0
		
		--validate editbox font config
		ValidateFontSettings(cfg.editbox.font, ChatFontNormal)
		
		--Show mr. and mrs. nil to their table
		cfg.editbox.textures.normal = cfg.editbox.textures.normal or {cfg.editbox.textures.normal}
		cfg.editbox.textures.focus = cfg.editbox.textures.focus or {cfg.editbox.textures.focus}
	end
	
	--Validate tab config
	if cfg.tabs.enabled then
		--I only need to validate fonts
		ValidateFontSettings(cfg.tabs.font, GameFontNormalSmall)
	end
	
	--Setup a few format strings
	cfg.formats.button = cfg.copychat.enabled and link('myChat', '', '|TInterface\\BUTTONS\\UI-SpellbookIcon-NextPage-Up:20|t') or ''
	cfg.formats.link = '|H%s:%s|h%s|h'	
	cfg.formats.brackets.channel = cfg.formats.brackets.channel and '[%s]' or '%s'
	cfg.formats.brackets.name = cfg.formats.brackets.name and '[%s]'
	cfg.timestamps.seperator = cfg.timestamps.enabled and (cfg.timestamps.seperator or '|'):gsub('|', '||'):gsub('%%', '%%%%') or ' '--Oh hi percent sign
	cfg.timestamps.color = cfg.timestamps.enabled and cfg.timestamps.color and hex(cfg.timestamps.color)..'%s|r' or '%s'
	cfg.formats.timestamps = cfg.timestamps.color:format((cfg.copychat.enabled and link('myChat', '', '%s') or '%s')..cfg.timestamps.seperator)
	cfg.timestamps.custom = cfg.timestamps.enabled and cfg.timestamps.custom
	if cfg.formats.seperator == ':' then cfg.formats.seperator = false end --So we dont produce more strings
	cfg.formats.seperator = cfg.formats.seperator and cfg.formats.seperator:gsub('|', '||'):gsub('%%', '%%%%%%%%')..' ' --WILL THE ESCAPING EVER END	
	cfg.battlenet.color = cfg.battlenet.color and '%1'..(cfg.formats.brackets.name or '%s'):format(hex(cfg.battlenet.color)..'%2|r')..'|h'
	cfg.formats.linkable = {
		['party'] = link('channel', 'PARTY', '%s'),
		['party_leader'] = link('channel', 'PARTY', '%s'),
		['party_guide'] = link('channel', 'PARTY', '%s'),
		['guild'] = link('channel', 'GUILD', '%s'),
		['officer'] = link('channel', 'OFFICER', '%s'),
		['raid'] = link('channel', 'RAID', '%s'),
		['raid_leader'] = link('channel', 'RAID', '%s'),
		['battleground'] = link('channel', 'BATTLEGROUND', '%s'),
		['battleground_leader'] = link('channel', 'BATTLEGROUND', '%s'),
	}
	if cfg.replaces['channel'] == '' then
		cfg.formats.channel = '%5'
	elseif cfg.replaces['channel'] then
		cfg.formats.channel = '%1'..cfg.formats.brackets.channel:format(cfg.replaces['channel']:gsub('#', '%%2'))..'|h%4%5'
	end
	if cfg.replaces['channel'] == '' then
		cfg.formats.conversation = '%5'
	elseif cfg.replaces['channel'] then
		cfg.formats.conversation = '%1%2|h'..cfg.formats.brackets.channel:format(cfg.replaces['bn_conversation']:gsub('%?', '%%2'):gsub('#', '%%3'))..'|h %5'
	end
	if cfg.url.enabled then
		cfg.formats.brackets.url = cfg.formats.brackets.url and '[%s]' or '%s'
		cfg.formats.url = {
			{
				match = 'www%.([_A-Za-z0-9-%%]+)%.([A-Za-z0-9/%?&%%=%-%.]+)',
				replace = 'www.%1.%2',
			},
			{
				match = '(%a+)://(%S+)',
				replace = '%1://%2',
			},
			{
				match = '([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-%.]+)%.([A-Za-z0-9%-]+)',
				replace = '%1@%2.%3',
			},
			{
				match = '(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)',
				replace = '%1.%2.%3.%4:%5',
			},
			{
				match = '(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)',
				replace = '%1.%2.%3.%4',
			},
		}
		local inc = function(n) return '%'..(n + 1) end
		for _, url in ipairs(cfg.formats.url) do
			url.match = '([%s,])'..url.match
			url.replace = '%1'..urlLink(url.replace:gsub('%%(%d)', inc))
		end
	end
	
	if cfg.timestamps.enabled or cfg.copychat.enabled then
		UpdateTag()
	end
	
	if cfg.url.enabled or cfg.copychat.enabled then		
		cfg.insert = {}
		_ChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow
		ChatFrame_OnHyperlinkShow = function(cf, link, text, button, ...)
			if link:sub(1, 6) == 'myChat' then
				if not cfg.copychat.enabled then return end
				local text = GetLineText(cf:GetRegions())
				if text then
					--Clean up text so you can paste it.
					if IsControlKeyDown() then 
						--copys the full text string with escape characters
						text = text:gsub('|', '||')
					else
						text = text:gsub('|c%x%x%x%x%x%x%x%x(.-)|r', '%1')
						text = text:gsub('|Hurl:(.-)|h.-|h', '%1')
						text = text:gsub('|H.-|h(.-)|h', '%1')
						if not IsShiftKeyDown() then
							text = text:gsub('|TInterface\\TargetingFrame\\UI%-RaidTargetingIcon_(%d+).-|t', '{rt%1}')
						end
						text = text:gsub('|T.-|t', '')
					end

					cfg.insert.enabled = true
					cfg.insert.text = text
					cfg.insert.overwrite = true
				end
			elseif link:sub(1,3) == 'url' then 
				if not cfg.url.enabled then return end
				cfg.insert.enabled = true
				cfg.insert.text = strsub(link, 5)
				cfg.insert.overwrite = false
			else
				cfg.insert.enabled = false
				return _ChatFrame_OnHyperlinkShow(cf, link, text, button, ...)
			end
		end
		hooksecurefunc('ChatFrame_OnHyperlinkShow', function(cf)			
			if cfg.insert.enabled then 
				if not LAST_ACTIVE_CHAT_EDIT_BOX:IsShown() then
					FCF_Tab_OnClick(_G['ChatFrame'..cf:GetID()..'Tab'], 'LeftButton')
				end
				InsertText(cfg.insert.text, cfg.insert.overwrite) 
			else
				SelectChatFrame(cfg.chatstyle == 'im' and LAST_ACTIVE_CHAT_EDIT_BOX:GetParent() or SELECTED_DOCK_FRAME)
			end
		end)
	end
	
	if cfg.timestamps.enabled then
		BetterDate = function(formatString, timeVal)
			local ampm = _G['TIMEMANAGER_'..date('%p', timeVal)]
			return date(formatString:gsub('%%p', ampm), timeVal)
		end
	end
	
	--If statment of doom:  If there is anything to format then enable hooking of AddMessage, otherwise don't hook
	if cfg.url.enabled or cfg.copychat.enabled or cfg.timestamps.enabled or cfg.battlenet.enabled or cfg.formats.channel or cfg.formats.conversation or cfg.formats.brackets.name == '%s' then
		cfg.formats.enabled = true
	else
		cfg.formats.enabled = false
	end
end

--Initialization
function myChat:Initialize()
	SetupConfigFile()
	
	--Chatframe stuff
	if not cfg.tweaks.fadeframe then
		FCF_FadeInChatFrame = dummy
	end

	ChatFrameMenuButton:HookScript('OnShow', function(self) self:Hide() end)
	ChatFrameMenuButton:Hide()
	FCF_ValidateChatFramePosition = dummy 
	
	for channel, doSticky in pairs(cfg.stickyChannels) do
		ChatTypeInfo[string.upper(channel)].sticky = doSticky and 1 or 0
	end
	
	for channel, replace in pairs(cfg.replaces) do
		if replace and channel ~= 'bn_conversation' and channel ~= 'channel' then
			if replace == '' then
				_G['CHAT_'..channel:upper()..'_GET'] = '%s: '
			else
				_G['CHAT_'..channel:upper()..'_GET'] = (cfg.formats.linkable[channel] or '%s'):format(cfg.formats.brackets.channel:format(replace))..' %s: '
			end
		end
		if cfg.formats.seperator then
			_G['CHAT_'..channel:upper()..'_GET'] = _G['CHAT_'..channel:upper()..'_GET']:gsub(':%s?$', cfg.formats.seperator)			
		end
	end

	for i = 1, MAX_WOW_CHAT_CHANNELS do
		ChatTypeInfo['CHANNEL'..i].flashTab = cfg.tweaks.channelflash
	end
	
	FriendsMicroButton:UnregisterAllEvents()
	FriendsMicroButton:HookScript('OnShow', function(self) self:Hide() end)
	FriendsMicroButton:Hide()
		
	--Imroved scrolling
	hooksecurefunc('FloatingChatFrame_OnMouseScroll', function(self, dir)
		if dir > 0 then
			if IsShiftKeyDown() then
				self:ScrollToTop()
			elseif IsControlKeyDown() then
				--only need to scroll twice because of blizzards scroll
				self:ScrollUp()
				self:ScrollUp()
			end
		elseif dir < 0 then
			if IsShiftKeyDown() then
				self:ScrollToBottom()
			elseif IsControlKeyDown() then
				--only need to scroll twice because of blizzards scroll
				self:ScrollDown()
				self:ScrollDown()
			end
		end
		ToggleBottomButton(self)
	end)

	--Initialize all the chat frames
	local cf = ChatFrame1
	while cf do
		InitializeChatFrame(cf)
		cf = _G['ChatFrame'..cf:GetID() + 1]
	end

	--Fancy Tabs
	if cfg.tabs.enabled then
		hooksecurefunc('FCFTab_UpdateColors', UpdateTab)
		hooksecurefunc('FCF_Tab_OnClick', function(tab, btn)
			if btn == 'LeftButton' then 
				if cfg.chatstyle == 'im' then LAST_ACTIVE_CHAT_EDIT_BOX = _G['ChatFrame'..tab:GetID()].editBox end
				SelectChatFrame(_G['ChatFrame'..tab:GetID()]) 
			end
		end)
		hooksecurefunc('FCF_Close', function(cf)
			SelectChatFrame(cf == SELECTED_DOCK_FRAME and ChatFrame1 or SELECTED_DOCK_FRAME)
		end)
		if cfg.tweaks.channelflash and cfg.tabs.flash.texture or cfg.tabs.flash.text then
			hooksecurefunc('FCF_StartAlertFlash', function(cf)	
				if cfg.tabs.flash.text then UpdateFS(_G['ChatFrame'..cf:GetID()..'Tab']) end
				if cfg.tabs.flash.texture then FCF_FlashTab(cf) end --for some reason custom channels dont trigger this
			end)
		end
		hooksecurefunc('FCF_DockFrame', SelectChatFrame)
		local tab = ChatFrame1Tab
		while tab do
			UpdateTab(tab)
			tab = _G['ChatFrame'..(tab:GetID() + 1)..'Tab']
		end
	end

	--Tell Target
	SLASH_TELLTARGET1 = "/tt"
	SlashCmdList.TELLTARGET = TellTarget
	
	--Timestamp control
	if cfg.timestamps.enabled or cfg.copychat.enabled then
		hooksecurefunc('InterfaceOptionsSocialPanelTimestamps_OnClick', UpdateTag)	
	end
	
	--ChatStyle hooking
	if cfg.editbox.enabled or cfg.tabs.enabled then
		hooksecurefunc('InterfaceOptionsSocialPanelChatStyle_OnClick', UpdateChatStyle)
	end
end

function myChat:ADDON_LOADED(e, addon)
	if not cfg.tweaks.filterbar and addon == 'Blizzard_CombatLog' then
		local filterbar = _G["CombatLogQuickButtonFrame_Custom"]
		filterbar:HookScript('OnShow', function(self) self:Hide() end)
		filterbar:Hide()
		filterbar:SetHeight(0)
	elseif addon == 'myChat' then
		self:Initialize()
	end
	if IsAddOnLoaded('myChat') and (cfg.tweaks.filterbar or IsAddOnLoaded('Blizzard_CombatLog')) then
		self:UnregisterEvent(e)
	end		
end

function myChat:PLAYER_ENTERING_WORLD(e)
	self:UnregisterEvent(e)
	
	--Update the fonts in case a font replacement addon is being used.  Hopefully this doesnt break any of them
	local cf = ChatFrame1
	while cf do		
		if cfg.font.enabled then
		cf:SetFont(cfg.font.name, cfg.font.size, cfg.font.outline)
		if cfg.font.shadow.enabled then
			cf:SetShadowColor(unpack(cfg.font.shadow.color))
			cf:SetShadowOffset(unpack(cfg.font.shadow.offset))
		end
		end
		if cfg.editbox.font.enabled then
			cf.editBox:SetFont(cfg.editbox.font.name, cfg.editbox.font.size, cfg.editbox.font.outline)
			if cfg.editbox.font.shadow.enabled then
				cf.editBox:SetShadowColor(unpack(cfg.editbox.font.shadow.color))
				cf.editBox:SetShadowOffset(unpack(cfg.editbox.font.shadow.offset))
			end
		end	
		cf = _G['ChatFrame'..cf:GetID() + 1]
	end
	
	--Do color by class on set channels
	for channel, option in pairs(cfg.colorByClass) do
		if channel ~= 'channel' then
			ToggleChatColorNamesByClassGroup(option, channel:upper())
		end
	end
	
	--Do color by class on custom channels
	if cfg.colorByClass.channel then
		for i = 1, MAX_WOW_CHAT_CHANNELS do
			ToggleChatColorNamesByClassGroup(true, 'CHANNEL'..i)
		end
	end
	
	if cfg.tabs.enabled then --ugly hack to make sure ChatFrame1 is the selected frame when logging in.
		FCF_Tab_OnClick(ChatFrame1Tab, 'LeftButton')
		LAST_SELECTED_CHAT_FRAME = ChatFrame1
	end
end

function myChat:VARIABLES_LOADED(e)
	UpdateTag()
	UpdateChatStyle()
	self:UnregisterEvent(e)
end

myChat:SetScript('OnEvent', function(self, e, ...)
	if self[e] then self[e](self, e, ...) end
end)