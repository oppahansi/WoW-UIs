--[[ Postal Express: Mouse Shortcuts for Mail ]]--
--shift-click to take item/money from mail
--ctrl-click to return mail
--alt-click to add item to SendMailFrame
--mousewheel to scroll the inbox

assert( Postal, "Postal not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Postal")

local mailIndex, attachIndex
local lastmailIndex, lastattachIndex, lastmailmoneyIndex
local invFull
local lastItem

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_Express = Postal:NewModule("Express")
Postal_Express.revision = tonumber(string.sub("$Revision: 70301 $", 12, -3))
Postal_Express.defaults = {
	EnableAltClick = true,
	AutoSend = true,
	MouseWheel = true,
}

Postal_Express.consoleOptions = {
	type = 'group',
	name = L["Express options"],
	desc = L["Options for the Express module"],
	args = {
		EnableAltClick = {
			name = L["Enable Alt-Click to send mail"], type = 'toggle',
			desc = L["If this option is on, Alt-Clicking an item in your bags will send it instantly to the player in the To: field"],
			get = function() return Postal_Express.db.char.EnableAltClick end,
			set = function(v)
				local self = Postal_Express
				self.db.char.EnableAltClick = v
				self.consoleOptions.args.AutoSend.disabled = not v
				if v then
					if MailFrame:IsVisible() and not self:IsHooked(GameTooltip, "OnTooltipSetItem") then
						self:HookScript(GameTooltip, "OnTooltipSetItem")
						self:Hook("ContainerFrameItemButton_OnModifiedClick", true)
					end
				else
					if self:IsHooked(GameTooltip, "OnTooltipSetItem") then
						self:Unhook(GameTooltip, "OnTooltipSetItem")
						self:Unhook("ContainerFrameItemButton_OnModifiedClick")
					end
				end
			end,
			order = 10,
		},
		AutoSend = {
			type = 'toggle',
			name = L["Auto-Send on Alt-Click"],
			desc = L["With this option on, Postal will mail an item as soon as it is attached if there is a recipient filled in."],
			get = function() return Postal_Express.db.char.AutoSend end,
			set = function(v) Postal_Express.db.char.AutoSend = v end,
			order = 20,
		},
		MouseWheel = {
			type = 'toggle',
			name = L["Mousewheel to scroll Inbox"],
			desc = L["Scroll Inbox pages using the Mousewheel."],
			get = function() return Postal_Express.db.char.MouseWheel end,
			set = function(v)
				local self = Postal_Express
				self.db.char.MouseWheel = v
				if v then
					self:HookScript(MailFrame, "OnMouseWheel", "InboxMouseScroll")
				else
					self:Unhook(MailFrame, "OnMouseWheel")
				end
			end,
			order = 30,
		},
	},
}

function Postal_Express:MAIL_SHOW()
	if self.db.char.EnableAltClick and not self:IsHooked(GameTooltip, "OnTooltipSetItem") then
		self:HookScript(GameTooltip, "OnTooltipSetItem")
		self:Hook("ContainerFrameItemButton_OnModifiedClick", true)
	end
	self:RegisterEvent("MAIL_CLOSED", "Reset")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
end

function Postal_Express:Reset()
	if self:IsEventRegistered("Postal_Express_Next") then
		self:UnregisterEvent("Postal_Express_Next")
	end
	if self:IsEventRegistered("UI_ERROR_MESSAGE") then
		self:UnregisterEvent("UI_ERROR_MESSAGE")
	end
	if (event == "MAIL_CLOSED" or event == "PLAYER_LEAVING_WORLD") then
		if self:IsHooked(GameTooltip, "OnTooltipSetItem") then
			self:Unhook(GameTooltip, "OnTooltipSetItem")
			self:Unhook("ContainerFrameItemButton_OnModifiedClick")
		end
		self:UnregisterEvent("MAIL_CLOSED")
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	end
end
	
function Postal_Express:OnEnable()
	self:Hook("InboxFrame_OnClick", true)
	self:SecureHook("InboxFrameItem_OnEnter")

	self:RegisterEvent("MAIL_SHOW")
	self.consoleOptions.args.AutoSend.disabled = not self.db.char.EnableAltClick
	if self.db.char.MouseWheel then
		Postal_Express:HookScript(MailFrame, "OnMouseWheel", "InboxMouseScroll")
	end
end

function Postal_Express:OnDisable()
	-- Disabling modules unregisters all events/hook automatically
end

-- Ctrl-Click and Shift-Clicks Shortcuts for Mail, based on ExpressMail by Tekkub
function Postal_Express:InboxFrameItem_OnEnter()
	local tooltip = GameTooltip
	local this = this
	
	local money, COD, _, hasItem, _, wasReturned, _, canReply = select(5, GetInboxHeaderInfo(this.index))
	if hasItem and hasItem > 1 then
		for i = 1, ATTACHMENTS_MAX_RECEIVE do
			local name, itemTexture, count, quality, canUse = GetInboxItem(this.index, i);
			if name then
				local itemLink = GetInboxItemLink(this.index, i);
				if count > 1 then
					tooltip:AddLine(("%sx%d"):format(itemLink, count))
				else
					tooltip:AddLine(itemLink)
				end
				tooltip:AddTexture(itemTexture)
			end
		end
	end
	if (money > 0 or hasItem) and (0 == (COD or 0)) then
		tooltip:AddLine(L["|cffeda55fShift-Click|r to take the contents."])
	end
	if not wasReturned and canReply then
		tooltip:AddLine(L["|cffeda55fCtrl-Click|r to return it to sender."])
	end
	tooltip:Show()
end

function Postal_Express:InboxFrame_OnClick(index)
	if IsShiftKeyDown() then
		mailIndex = index
		attachIndex = ATTACHMENTS_MAX_RECEIVE
		invFull = nil
		lastmailIndex = nil
		lastattachIndex = nil
		lastmailmoneyIndex = nil
		lastItem = GetInboxNumItems()
		if not self:IsEventRegistered("Postal_Express_Next") then
			self:RegisterEvent("Postal_Express_Next", "ProcessNext")
		end
		if not self:IsEventRegistered("UI_ERROR_MESSAGE") then
			self:RegisterEvent("UI_ERROR_MESSAGE")
		end
		self:ProcessNext()
	elseif IsControlKeyDown() then
		local wasReturned, _, canReply = select(10, GetInboxHeaderInfo(index))
		if not wasReturned and canReply then
			ReturnInboxItem(index)
		end
	else
		self.hooks["InboxFrame_OnClick"](index)
	end
end

function Postal_Express:OnTooltipSetItem(tooltip, ...)
	local recipient = SendMailNameEditBox:GetText()
	if self.db.char.AutoSend and type(recipient) == "string" and recipient:len() > 0 and SendMailFrame:IsVisible() and not CursorHasItem() then
		tooltip:AddLine(string.format(L["|cffeda55fAlt-Click|r to send this item to %s."], recipient))
	end
	return self.hooks[tooltip].OnTooltipSetItem(tooltip, ...)
end

function Postal_Express:ContainerFrameItemButton_OnModifiedClick(...)
	if select(1, ...) == "LeftButton" and IsAltKeyDown() and SendMailFrame:IsVisible() and not CursorHasItem() then
		local bag, slot = this:GetParent():GetID(), this:GetID()
		local texture, count = GetContainerItemInfo(bag, slot)
		PickupContainerItem(bag, slot)
		ClickSendMailItemButton()
		if self.db.char.AutoSend then
			for i = 1, ATTACHMENTS_MAX_SEND do
				-- get info about the attachment
				local itemName, itemTexture, stackCount, quality = GetSendMailItem(i);
				if SendMailNameEditBox:GetText() ~= "" and texture == itemTexture and count == stackCount then
					SendMailFrame_SendMail()
				end
			end
		end
	else
		self.hooks["ContainerFrameItemButton_OnModifiedClick"](...)
	end
end

function Postal_Express:ProcessNext()
	if lastItem ~= GetInboxNumItems() then
		-- the last attachment or gold taken auto deleted the mail
		mailIndex = nil
		lastItem = nil
		self:Reset()
		return
	end
	local msgSubject, msgMoney, msgCOD, _, msgItem, _, wasReturned, msgText, canReply, isGM = select(4, GetInboxHeaderInfo(mailIndex))
	local mailType = self.core:GetMailType(msgSubject)
	if msgCOD and msgCOD > 0 then
		-- Don't do anything if its a CoD
		return self:Reset() -- tail call
	end
	while not GetInboxItem(mailIndex, attachIndex) and attachIndex > 0 do
		-- Find first attachment index backwards
		attachIndex = attachIndex - 1
	end
	if attachIndex > 0 and not invFull then
		-- If there's attachments, take the item
		--self.core:Print("Getting Item from Message "..mailIndex..", "..attachIndex)
		if lastattachIndex ~= attachIndex then -- don't attempt to take more than once or it generates the "database error"
			TakeInboxItem(mailIndex, attachIndex)
			lastattachIndex = attachIndex
		end
		--attachIndex = attachIndex - 1
		self:ScheduleEvent("Postal_Express_Next", self.core.db.profile.OpenSpeed)
	elseif msgMoney > 0 then
		-- No attachments, but there is money
		--self.core:Print("Looting Message "..mailIndex)
		if lastmailmoneyIndex ~= mailIndex then -- don't attempt to take more than once or it generates the "database error"
			TakeInboxMoney(mailIndex)
			lastmailmoneyIndex = mailIndex
		end
		self:ScheduleEvent("Postal_Express_Next", self.core.db.profile.OpenSpeed)
	else
		-- Delete the message, other types of mail are auto-deleted
		if mailType == "NonAHMail" or mailType == "AHPending" then
			--self.core:Print("Deleting Message "..mailIndex.."/"..GetInboxNumItems())
			if not GetInboxItem(mailIndex) then -- Make sure there is no attachment
				DeleteInboxItem(mailIndex)
			end
		end
		self:Reset()
	end
end

function Postal_Express:UI_ERROR_MESSAGE(error_message)
	if error_message == ERR_INV_FULL then
		invFull = true
	elseif error_message == ERR_ITEM_MAX_COUNT then
		attachIndex = attachIndex - 1
	end
end

function Postal_Express:InboxMouseScroll(frame, direction)
	if direction == -1 then
		if math.ceil(GetInboxNumItems()/7) > InboxFrame.pageNum then
			InboxNextPage()
		end
	elseif InboxFrame.pageNum ~= 1 then
		InboxPrevPage()
	end
	return self.hooks[frame].OnMouseWheel(frame, direction)
end

