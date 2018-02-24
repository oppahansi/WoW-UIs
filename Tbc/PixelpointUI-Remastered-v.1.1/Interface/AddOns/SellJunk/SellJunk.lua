local options = {
	type = 'group',
	args = {
		list = {
			type = 'execute',
			name = 'list',
			desc = 'Lists all exceptions',
			func = 'List'
		},
		auto = {
			type = 'toggle',
			name = 'auto',
			desc = 'Toggles the automatic selling of junk when the merchant window is opened.',
			get = 'IsAuto',
			set = 'ToggleAuto'
		},
		add = {
			type = 'text',
			name = 'add',
			desc = 'Add an exception for all characters.',
			usage = '<Item Link>',
			get = false,
			set = 'Add'
		},
		rem = {
			type = 'text',
			name = 'rem',
			desc = 'Remove an exception for all characters.',
			usage = '<Item Link>',
			get = false,
			set = 'Rem'
		},
		me = {
			type = 'group',
			name = 'me',
			desc = 'Contains the ability to add/remove exceptions for this character.',
			args = {
				add = {
					type = 'text',
					name = 'add',
					desc = 'Add an exception for this characters.',
					usage = '<Item Link>',
					get = false,
					set = 'AddMe'
				},
				rem = {
					type = 'text',
					name = 'rem',
					desc = 'Remove an exception for this characters.',
					usage = '<Item Link>',
					get = false,
					set = 'RemMe'
				},
		}
	}
}
}

SellJunk = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0","AceDB-2.0","AceEvent-2.0")
SellJunk:RegisterChatCommand({"/SellJunk","/sj"},options)
SellJunk:RegisterDB("SellJunkDB","SellJunkDBPC")
SellJunk:RegisterDefaults("char", {exception = {}, auto = false })
SellJunk:RegisterDefaults("account", {exception = {} })

function SellJunk:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
end

function SellJunk:MERCHANT_SHOW()
	if self.db.char.auto then
		SellJunk:Sell()
	end
end

function SellJunk:IsAuto()
	return self.db.char.auto
end

function SellJunk:ToggleAuto()
	self.db.char.auto = not self.db.char.auto
end

function SellJunk:Sell()
	for bag = 0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local item = GetContainerItemLink(bag,slot)
			if item then
				local found = string.find(item,"|cff9d9d9d")
				if ((found) and (not SellJunk:isException(item))) or ((not found) and (SellJunk:isException(item))) then
					-- PickupContainerItem(bag,slot)
					-- MerchantItemButton_OnClick("LeftButton")
					UseContainerItem(bag,slot)
					self:Print("Sold " .. item)
				end
			end
		end
	end
end

function SellJunk:List()
	local test
	if self.db.account.exception then
		self:Print("Global exception list:")
		for k,v in pairs(self.db.account.exception) do
			self:Print(v)
		end
	end

	if self.db.char.exception then
		self:Print("Character exception list:")
		for k,v in pairs(self.db.char.exception) do
			self:Print(v)
		end
	end
end

function SellJunk:Add(link)
	self.db.account.exception[table.getn(self.db.account.exception) + 1] = link
	self:Print(link .. " added to global exception list.")	
end

function SellJunk:Rem(link)
	local found = false
	local exception
	local _, _, linkID = string.find(link,"item:(%d+)")
	for k,v in pairs(self.db.account.exception) do
		_, _, exception = string.find(v,"item:(%d+)")
		if (exception == linkID) then
			found = true
		end
		if found then
			if self.db.account.exception[k+1] then
				self.db.account.exception[k] = self.db.account.exception[k+1]
			else
				self.db.account.exception[k] = nil
			end
		end
	end
	if found then
		self:Print("Removed " .. link .. " from global exception list.")
	end
	found = false

	for k,v in pairs(self.db.char.exception) do
		_, _, exception = string.find(v,"item:(%d+)")
		if (exception == linkID) then
			found = true
		end
		if found then
			if self.db.char.exception[k+1] then
				self.db.char.exception[k] = self.db.char.exception[k+1]
			else
				self.db.char.exception[k] = nil
			end
		end
	end
	if found then
		self:Print("Removed " .. link .. " from exception exception list.")
	end
end

function SellJunk:AddMe(link)
	self.db.char.exception[table.getn(self.db.char.exception) + 1] = link
	self:Print(link .. " added to character exception list.")
end

function SellJunk:RemMe(link)
	local exception
	local _, _, linkID = string.find(link,"item:(%d+)")
	local found = false
	for k,v in pairs(self.db.char.exception) do
		_, _, exception = string.find(v,"item:(%d+)")
		if (exception == linkID) then
			found = true
		end
		if found then
			if self.db.char.exception[k+1] then
				self.db.char.exception[k] = self.db.char.exception[k+1]
			else
				self.db.char.exception[k] = nil
			end
		end
	end
	if found then
		self:Print("Removed " .. link .. " from exception exception list.")
	end
end

function SellJunk:isException(link)
	local exception
	_, _, link = string.find(link,"item:(%d+)")
	if self.db.account.exception then
		for k,v in pairs(self.db.account.exception) do
			_, _, exception = string.find(v,"item:(%d+)")
			if exception == link then
				return true
			end
		end
	end
	if self.db.char.exception then
		for k,v in pairs(self.db.char.exception) do
			_, _, exception = string.find(v,"item:(%d+)")
			if exception == link then
				return true
			end
		end
	end
	return false
end