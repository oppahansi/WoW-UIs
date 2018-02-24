assert( Postal, "Postal not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Postal")
local dewdrop = AceLibrary("Dewdrop-2.0")

local mailIndex, attachIndex
local lastmailIndex, lastattachIndex, lastmailmoneyIndex
local lastItem
local button
local Postal_OpenAllMenuButton
local skipFlag = false
local openAll = function() this.owner:OpenAll() end
local invFull
local DeleteTheseTypes = {
	AHPending = true,
}

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_OpenAll = Postal:NewModule("OpenAll")
Postal_OpenAll.revision = tonumber(string.sub("$Revision: 61025 $", 12, -3))
Postal_OpenAll.defaults = {
	AHCancelled = true,
	AHExpired = true,
	AHOutbid = true,
	AHPending = true,
	AHSuccess = true,
	AHWon = true,
	Attachments = true,
	SpamChat = true,
}

Postal_OpenAll.consoleOptions = {
	type = 'group',
	name = L["OpenAll options"],
	desc = L["Options for the OpenAll module"],
	args = {
		AHMail = {
			type = 'group',
			name = L["AH-related mail"],
			desc = L["Options for AH-related mail"],
			args = {
				AHCancelled = {
					name = L["Open all Auction cancelled mail"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening Auction cancelled mails"],
					get = function() return Postal_OpenAll.db.char.AHCancelled end,
					set = function(v) Postal_OpenAll.db.char.AHCancelled = v end,
				},
				AHExpired = {
					name = L["Open all Auction expired mail"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening Auction expired mails"],
					get = function() return Postal_OpenAll.db.char.AHExpired end,
					set = function(v) Postal_OpenAll.db.char.AHExpired = v end,
				},
				AHOutbid = {
					name = L["Open all Outbid on mail"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening Outbid on mails"],
					get = function() return Postal_OpenAll.db.char.AHOutbid end,
					set = function(v) Postal_OpenAll.db.char.AHOutbid = v end,
				},
				AHPending = {
					name = L["Open all Sale Pending mail"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening Sale Pending mails"],
					get = function() return Postal_OpenAll.db.char.AHPending end,
					set = function(v) Postal_OpenAll.db.char.AHPending = v end,
				},
				AHSuccess = {
					name = L["Open all Auction successful mail"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening Auction successful mails"],
					get = function() return Postal_OpenAll.db.char.AHSuccess end,
					set = function(v) Postal_OpenAll.db.char.AHSuccess = v end,
				},
				AHWon = {
					name = L["Open all Auction won mail"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening Auction won mails"],
					get = function() return Postal_OpenAll.db.char.AHWon end,
					set = function(v) Postal_OpenAll.db.char.AHWon = v end,
				},
			},
		},
		NonAHMail = {
			type = 'group',
			name = L["Non-AH related mail"],
			desc = L["Options for non-AH related mail"],
			args = {
				Attachments = {
					name = L["Open all mail with attachments"], type = 'toggle',
					desc = L["If this option is off, Postal will skip opening mails from players that has attachments"],
					get = function() return Postal_OpenAll.db.char.Attachments end,
					set = function(v) Postal_OpenAll.db.char.Attachments = v end,
				},
			},
		},
		Options = {
			type = 'group',
			name = L["Other options"],
			desc = L["Other options"],
			args = {
				SpamChat = {
					name = L["Verbose mode"], type = 'toggle',
					desc = L["If this option is on, Postal will spam the chat with messages while opening mail"],
					get = function() return Postal_OpenAll.db.char.SpamChat end,
					set = function(v) Postal_OpenAll.db.char.SpamChat = v end,
				},
			},
		},
	},
}

function Postal_OpenAll:OnEnable()
	if not button then
		button = CreateFrame("Button", "PostalOpenAllButton", InboxFrame, "UIPanelButtonTemplate")
		button:SetWidth(120)
		button:SetHeight(25)
		if GetLocale() == "frFR" then
			button:SetPoint("CENTER", InboxFrame, "TOP", -32, -410)
		else
			button:SetPoint("CENTER", InboxFrame, "TOP", -22, -410)
		end
		button:SetText(L["Open All"])
		button.owner = self
		button:SetScript("OnClick", openAll)
	end
	if not Postal_OpenAllMenuButton then
		-- Create the Menu Button
		Postal_OpenAllMenuButton = CreateFrame("Button", "Postal_OpenAllMenuButton", InboxFrame);
		Postal_OpenAllMenuButton:SetWidth(30);
		Postal_OpenAllMenuButton:SetHeight(30);
		Postal_OpenAllMenuButton:SetPoint("LEFT", button, "RIGHT", -2, 0);
		Postal_OpenAllMenuButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
		Postal_OpenAllMenuButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
		Postal_OpenAllMenuButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
		Postal_OpenAllMenuButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
		dewdrop:Register(Postal_OpenAllMenuButton,
			"children", function() dewdrop:FeedAceOptionsTable(self.consoleOptions) end,
			"point", "TOPRIGHT",
			"relativePoint", "BOTTOMRIGHT",
			"dontHook", true
		)
		Postal_OpenAllMenuButton:SetScript("OnClick", function(self)
			if dewdrop:IsOpen(self) then
				dewdrop:Close()
			else
				dewdrop:Open(self)
			end
		end)
		Postal_OpenAllMenuButton:SetScript("OnHide", function()
			if dewdrop:IsOpen(self) then
				dewdrop:Close()
			end
		end)
	end

	self:RegisterEvent("MAIL_SHOW")
	-- For enabling after a disable
	button:Show()
	Postal_OpenAllMenuButton:Show()
end

function Postal_OpenAll:OnDisable()
	self:Reset()
	button:Hide()
	Postal_OpenAllMenuButton:Hide()
end

function Postal_OpenAll:MAIL_SHOW()
	self:RegisterEvent("MAIL_CLOSED", "Reset")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
end

function Postal_OpenAll:OpenAll()
	mailIndex = GetInboxNumItems() or 0
	attachIndex = ATTACHMENTS_MAX_RECEIVE
	invFull = nil
	skipFlag = false
	lastmailIndex = nil
	lastattachIndex = nil
	lastmailmoneyIndex = nil
	lastItem = nil
	if mailIndex == 0 then
		return
	end

	self.core:DisableInbox(1)
	--button:SetScript("OnClick", nil)
	button:SetText(L["In Progress"])

	if not self:IsEventRegistered("Postal_OpenAll_Next") then
		self:RegisterEvent("Postal_OpenAll_Next", "ProcessNext")
	end
	if not self:IsEventRegistered("UI_ERROR_MESSAGE") then
		self:RegisterEvent("UI_ERROR_MESSAGE")
	end
	self:ProcessNext()
end

function Postal_OpenAll:ProcessNext()
	local _, msgSubject, msgMoney, msgCOD, msgItem, msgText, isGM
	if mailIndex > 0 then
		msgSubject, msgMoney, msgCOD, _, msgItem, _, _, msgText, _, isGM = select(4, GetInboxHeaderInfo(mailIndex))
		if (msgCOD and msgCOD > 0) or (isGM) then
			-- Skip mail if it contains a CoD or if its from a GM
			skipFlag = true
			mailIndex = mailIndex - 1
			attachIndex = ATTACHMENTS_MAX_RECEIVE
			lastItem = nil
			return self:ProcessNext() -- tail call
		end
		local mailType = self.core:GetMailType(msgSubject)
		if mailType == "NonAHMail" then
			-- Skip player sent mail with attachments according to user options
			if (not self.db.char.Attachments) and msgItem then
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				lastItem = nil
				return self:ProcessNext() -- tail call
			end
		else
			-- Skip AH mail types according to user options
			if (not self.db.char[mailType]) then
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				lastItem = nil
				return self:ProcessNext() -- tail call
			end
		end
		if self.db.char.SpamChat and attachIndex == ATTACHMENTS_MAX_RECEIVE then
			-- Print message on next mail
			local moneyString = msgMoney > 0 and " ["..self.core:GetMoneyString(msgMoney).."]" or ""
			self.core:Print(format("%s %d: %s%s", L["Processing Message"], mailIndex, msgSubject, moneyString))
		end
		while not GetInboxItemLink(mailIndex, attachIndex) and attachIndex > 0 do
			-- Find first attachment index backwards
			attachIndex = attachIndex - 1
		end
		if attachIndex > 0 and not invFull then
			-- If there's attachments, take the item
			--self.core:Print("Getting Item from Message "..mailIndex..", "..attachIndex)
			if lastmailIndex ~= mailIndex or lastattachIndex ~= attachIndex then -- don't attempt to take more than once or it generates the "database error"
				--self.core:Print("Actually getting it")
				lastItem = GetInboxNumItems()
				TakeInboxItem(mailIndex, attachIndex)
				lastmailIndex = mailIndex
				lastattachIndex = attachIndex
			else
				if lastItem ~= GetInboxNumItems() then
					mailIndex = mailIndex - 1
					attachIndex = ATTACHMENTS_MAX_RECEIVE
					lastItem = nil
					return self:ProcessNext() -- tail call
				end
			end
			--attachIndex = attachIndex - 1
			self:ScheduleEvent("Postal_OpenAll_Next", self.core.db.profile.OpenSpeed)
		elseif msgMoney > 0 then
			-- No attachments, but there is money
			if lastItem and lastItem ~= GetInboxNumItems() then
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				lastItem = nil
				return self:ProcessNext() -- tail call
			end
			--self.core:Print("Looting Message "..mailIndex)
			if lastmailmoneyIndex ~= mailIndex then -- don't attempt to take more than once or it generates the "database error"
				TakeInboxMoney(mailIndex)
				lastmailmoneyIndex = mailIndex
				lastItem = GetInboxNumItems()
			end
			self:ScheduleEvent("Postal_OpenAll_Next", self.core.db.profile.OpenSpeed)
		else
			if lastItem and lastItem ~= GetInboxNumItems() then
				-- the last attachment or gold taken auto deleted the mail so move on to the next mail
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				lastItem = nil
				return self:ProcessNext() -- tail call
			end
			-- Delete the AH Pending messages, leave other messages alone, mails with no messages gets auto-deleted
			if DeleteTheseTypes[mailType] then
				--self.core:Print("Deleting Message "..mailIndex.."/"..GetInboxNumItems())
				if not GetInboxItem(mailIndex) then -- Make sure there is no attachment
					DeleteInboxItem(mailIndex)
				end
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				lastItem = nil
				self:RegisterEvent("MAIL_INBOX_UPDATE")
				-- Can't delete 2 mails at a go between 1 MAIL_INBOX_UPDATE events
				--self:ScheduleEvent("Postal_OpenAll_Next", .5)
			else
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				lastItem = nil
				return self:ProcessNext() -- tail call
			end
		end
	else
		if IsAddOnLoaded("MrPlow") then MrPlow:ParseInventory() end
		if skipFlag then self.core:Print(L["Some Messages May Have Been Skipped."]) end
		self:Reset()
	end
end

function Postal_OpenAll:Reset()
	if self:IsEventRegistered("Postal_OpenAll_Next") then
		self:UnregisterEvent("Postal_OpenAll_Next")
	end
	if self:IsEventRegistered("MAIL_INBOX_UPDATE") then
		self:UnregisterEvent("MAIL_INBOX_UPDATE")
	end
	if self:IsEventRegistered("UI_ERROR_MESSAGE") then
		self:UnregisterEvent("UI_ERROR_MESSAGE")
	end
	--button:SetScript("OnClick", openAll)
	button:SetText(L["Open All"])
	self.core:DisableInbox()
	InboxFrame_Update()
	if (event == "MAIL_CLOSED" or event == "PLAYER_LEAVING_WORLD") then
		self:UnregisterEvent("MAIL_CLOSED")
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	end
end

function Postal_OpenAll:MAIL_INBOX_UPDATE()
	--self.core:Print("update")
	self:UnregisterEvent("MAIL_INBOX_UPDATE")
	self:ScheduleEvent("Postal_OpenAll_Next", self.core.db.profile.OpenSpeed)
end

function Postal_OpenAll:UI_ERROR_MESSAGE(error_message)
	if error_message == ERR_INV_FULL then
		invFull = true
	elseif error_message == ERR_ITEM_MAX_COUNT then
		attachIndex = attachIndex - 1
	end
end
