------------------------------
--      Are you local?      --
------------------------------
local L = AceLibrary("AceLocale-2.2"):new("Postal")
local dewdrop = AceLibrary("Dewdrop-2.0")

local COPPER_ABBR, SILVER_ABBR, GOLD_ABBR
if GOLD then -- for pre 2.4.2 compatibility, remove in next patch
	COPPER_ABBR = string.lower(string.sub(COPPER, 1, 1))
	SILVER_ABBR = string.lower(string.sub(SILVER, 1, 1))
	GOLD_ABBR = string.lower(string.sub(GOLD, 1, 1))
	if (string.byte(COPPER_ABBR) or 128) > 127 then
		-- non-western
		COPPER_ABBR = COPPER
		SILVER_ABBR = SILVER
		GOLD_ABBR = GOLD
	end
	if ( GetLocale() == "zhTW" ) then
		COPPER_ABBR = "銅"
		SILVER_ABBR = "銀"
		GOLD_ABBR = "金"
	elseif ( GetLocale() == "zhCN" ) then
		COPPER_ABBR = "铜"
		SILVER_ABBR = "银"
		GOLD_ABBR = "金"
	elseif ( GetLocale() == "koKR" ) then
		COPPER_ABBR = "코퍼"
		SILVER_ABBR = "실버"
		GOLD_ABBR = "골드"
	end
end

---------------------------------
--      Addon Declaration      --
---------------------------------

Postal = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
Postal.revision = tonumber(string.sub("$Revision: 73721 $", 12, -3))
Postal:SetModuleMixins("AceEvent-2.0", "AceHook-2.1")
Postal:RegisterDB("PostalDB", "PostalDBPerChar")
Postal:RegisterDefaults("profile", {
	OpenSpeed = 1.0,
})

-----------------------------
--	Addon Options      --
-----------------------------

Postal.moduleArgTables = {
	-- These table are aliased over to Postal.consoleOptions.args if the modules are detected OnInitialize(), since
	-- some people delete the module files they do not want, and we do not want non-existant modules to show up.
	-- For example, "Forward" module won't show up since its entirely commented out.
	BlackBook = {
		name = L["BlackBook"], type = 'toggle', --aliases = L["bb"],
		desc = L["A Black Book to write down your addresses."],
		get = function() return Postal:HasModule("BlackBook") and Postal:IsModuleActive("BlackBook") end,
		set = function(v) Postal:ToggleModuleActive("BlackBook", v) end,
	},
	DejaVu = {
		name = L["DejaVu"], type = 'toggle', --aliases = L["djv"],
		desc = L["Autofills the last recipient in the To: field."],
		get = function() return Postal:HasModule("DejaVu") and Postal:IsModuleActive("DejaVu") end,
		set = function(v) Postal:ToggleModuleActive("DejaVu", v) end,
	},
	Express = {
		name = L["Express"], type = 'toggle', --aliases = L["exp"],
		desc = L["Mouse click short cuts for mail."],
		get = function() return Postal:HasModule("Express") and Postal:IsModuleActive("Express") end,
		set = function(v) Postal:ToggleModuleActive("Express", v) end,
	},
	Forward = {
		name = L["Forward"], type = 'toggle', --aliases = L["fwd"],
		desc = L["Forward a message. (Currently Broken)"],
		get = function() return Postal:HasModule("Forward") and Postal:IsModuleActive("Forward") end,
		set = function(v) Postal:ToggleModuleActive("Forward", v) end,
	},
	OpenAll = {
		name = L["OpenAll"], type = 'toggle',-- aliases = L["oa"],
		desc = L["A button that collects all attachments and coins from mail."],
		get = function() return Postal:HasModule("OpenAll") and Postal:IsModuleActive("OpenAll") end,
		set = function(v) Postal:ToggleModuleActive("OpenAll", v) end,
	},
	Rake = {
		name = L["Rake"], type = 'toggle',
		desc = L["Prints the amount of money collect during a mail session."],
		get = function() return Postal:HasModule("Rake") and Postal:IsModuleActive("Rake") end,
		set = function(v) Postal:ToggleModuleActive("Rake", v) end,
	},
	Select = {
		name = L["Select"], type = 'toggle',-- aliases = L["slt"],
		desc = L["Add check boxes to the inbox for multiple mail operations."],
		get = function() return Postal:HasModule("Select") and Postal:IsModuleActive("Select") end,
		set = function(v) Postal:ToggleModuleActive("Select", v) end,
	},
	TradeBlock = {
		name = L["TradeBlock"], type = 'toggle',-- aliases = L["tb"],
		desc = L["Block incoming trade requests while in a mail session."],
		get = function() return Postal:HasModule("TradeBlock") and Postal:IsModuleActive("TradeBlock") end,
		set = function(v) Postal:ToggleModuleActive("TradeBlock", v) end,
	},
	Wire = {
		name = L["Wire"], type = 'toggle',
		desc = L["Set subject field to value of coins sent if subject is blank."],
		get = function() return Postal:HasModule("Wire") and Postal:IsModuleActive("Wire") end,
		set = function(v) Postal:ToggleModuleActive("Wire", v) end,
	},
}

Postal.consoleOptions = {
	type = 'group',
	args = {
		speed = {
			name = L["Opening Speed"], type = 'range',
			desc = L["The time in seconds between opening each mail/item/money. Setting this to a very fast speed may disconnect you while opening mail."],
			min = 0.3,
			max = 2.0,
			step = 0.05,
			get = function() return Postal.db.profile.OpenSpeed end,
			set = function(v) Postal.db.profile.OpenSpeed = v end,
			order = -20,
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

function Postal:OnInitialize()
	if not self.version then self.version = GetAddOnMetadata("Postal", "Version") end
	local rev = self.revision
	for name, module in self:IterateModules() do
		-- Get the highest revision number found
		rev = math.max(rev, module.revision)
		-- Alias the arg table over for each detected module
		self.consoleOptions.args[name] = self.moduleArgTables[name]

		-- Alias module options into main addon consoleOptions table
		if module.consoleOptions then
			local m = module.consoleCmd or name
			if not self.consoleOptions.args.options then
				self.consoleOptions.args.options = {
					type = 'group',
					name = L["Module Options"],
					desc = L["Module Options"],
					order = -10,
					args = {
					},
				}
			end
			self.consoleOptions.args.options.args[m] = module.consoleOptions
		end
	
	end
	self.version = (self.version or "1.0") .. " |cffff8888r" .. rev .. "|r"
	self:RegisterChatCommand({"/postal"}, self.consoleOptions, "POSTAL")

	-- Create the Menu Button
	local Postal_ModuleMenuButton = CreateFrame("Button", "Postal_ModuleMenuButton", MailFrame);
	Postal_ModuleMenuButton:SetWidth(25);
	Postal_ModuleMenuButton:SetHeight(25);
	Postal_ModuleMenuButton:SetPoint("TOPRIGHT", -53, -12);
	Postal_ModuleMenuButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
	Postal_ModuleMenuButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
	Postal_ModuleMenuButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
	Postal_ModuleMenuButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
	dewdrop:Register(Postal_ModuleMenuButton,
		"children", function() dewdrop:FeedAceOptionsTable(self.consoleOptions) end,
		"point", "TOPRIGHT",
		"relativePoint", "BOTTOMRIGHT",
		"dontHook", true
	)
	Postal_ModuleMenuButton:SetScript("OnClick", function(self)
		if dewdrop:IsOpen(self) then
			dewdrop:Close()
		else
			dewdrop:Open(self)
		end
	end)
	Postal_ModuleMenuButton:SetScript("OnHide", function()
		if dewdrop:IsOpen(self) then
			dewdrop:Close()
		end
	end)
end

function Postal:OnDisable()
	for name, module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
	end
end

--------------------------------
--      Module Prototype      --
--------------------------------

Postal.modulePrototype.core = Postal
Postal.modulePrototype.revision = 1

function Postal.modulePrototype:OnInitialize()
	-- Unconditionally register, this shouldn't happen from any other place anyway.
	self.core:RegisterModule(self.name, self)
	hooksecurefunc(self, "OnEnable", self.OnEnable_Common)
end

function Postal.modulePrototype:OnEnable_Common()
	-- If the module is enabled with the MailFrame open (at mailbox)
	-- run the MAIL_SHOW() event function
	if self.MAIL_SHOW and MailFrame:IsVisible() then
		self:MAIL_SHOW()
	end
end

function Postal.modulePrototype:IsRegistered()
	return self.registered
end

-------------------------------
--      Module Handling      --
-------------------------------

function Postal:RegisterModule(name, module)
	if module:IsRegistered() then
		error(string.format("%q is already registered.", name))
		return
	end
	if module.db and module.RegisterDefaults and type(module.RegisterDefaults) == "function" then
		module:RegisterDefaults("char", module.defaults or {})
	else
		self:RegisterDefaults(name, "char", module.defaults or {})
	end
	if not module.db then module.db = self:AcquireDBNamespace(name) end
	module.registered = true
	if module.OnRegister and type(module.OnRegister) == "function" then
		module:OnRegister()
	end
end

---------------------------
-- Common Mail Functions --
---------------------------

-- Disable Inbox Clicks
function Postal:DisableInbox(disable)
	if disable then
		if not self:IsHooked("InboxFrame_OnClick") then
			self:Hook("InboxFrame_OnClick", function() end, true)
			for i = 1, 7 do
				_G["MailItem" .. i .. "ButtonIcon"]:SetDesaturated(1)
			end
		end
	else
		if self:IsHooked("InboxFrame_OnClick") then
			self:Unhook("InboxFrame_OnClick")
			for i = 1, 7 do
				_G["MailItem" .. i .. "ButtonIcon"]:SetDesaturated(nil)
			end
		end
	end
end

-- Return the type of mail a message subject is
local SubjectPatterns = {
	AHCancelled = gsub(AUCTION_REMOVED_MAIL_SUBJECT, "%%s", ".*"),
	AHExpired = gsub(AUCTION_EXPIRED_MAIL_SUBJECT, "%%s", ".*"),
	AHOutbid = gsub(AUCTION_OUTBID_MAIL_SUBJECT, "%%s", ".*"),
	AHPending = gsub(AUCTION_INVOICE_MAIL_SUBJECT, "%%s", ".*"),
	AHSuccess = gsub(AUCTION_SOLD_MAIL_SUBJECT, "%%s", ".*"),
	AHWon = gsub(AUCTION_WON_MAIL_SUBJECT, "%%s", ".*"),
}
function Postal:GetMailType(msgSubject)
	if not msgSubject then return "NonAHMail" end
	for k, v in pairs(SubjectPatterns) do
		if msgSubject:find(v) then return k end
	end
	return "NonAHMail"
end

function Postal:GetMoneyString(money)
	local gold = floor(money / 10000)
	local silver = floor((money - gold * 10000) / 100)
	local copper = mod(money, 100)

	if gold > 0 then
		if GOLD_ABBR then
			return format("%d%s %d%s %d%s", gold, GOLD_ABBR, silver, SILVER_ABBR, copper, COPPER_ABBR)
		else
			return format(GOLD_AMOUNT, gold).." "..format(SILVER_AMOUNT, silver).." "..format(COPPER_AMOUNT, copper)
		end
	elseif silver > 0 then
		if GOLD_ABBR then
			return format("%d%s %d%s", silver, SILVER_ABBR, copper, COPPER_ABBR)
		else
			return format(SILVER_AMOUNT, silver).." "..format(COPPER_AMOUNT, copper)
		end
	else
		if GOLD_ABBR then
			return format("%d%s", copper, COPPER_ABBR)
		else
			return format(COPPER_AMOUNT, copper)
		end
	end
end
