--[[ Postal_BlackBook: Adds a popup contact list when you mouseover the To: field. ]]--

assert( Postal, "Postal not found!")

------------------------------
--      Are you local?      --
------------------------------

local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Postal")

local Postal_BlackBookButton

----------------------------------
--      Module Declaration      --
----------------------------------

Postal_BlackBook = Postal:NewModule("BlackBook")
Postal_BlackBook.defaults = {
	contacts = {}
}

Postal_BlackBook.revision = tonumber(string.sub("$Revision: 57745 $", 12, -3))

function Postal_BlackBook:OnEnable()
	if not Postal_BlackBookButton then
		-- Create the Menu Button
		Postal_BlackBookButton = CreateFrame("Button", "Postal_BlackBookButton", SendMailFrame);
		Postal_BlackBookButton:SetWidth(25);
		Postal_BlackBookButton:SetHeight(25);
		Postal_BlackBookButton:SetPoint("LEFT", SendMailNameEditBox, "RIGHT", -2, 0);
		Postal_BlackBookButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
		Postal_BlackBookButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
		Postal_BlackBookButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
		Postal_BlackBookButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
		dewdrop:Register(Postal_BlackBookButton,
			"children", function(level, value) Postal_BlackBook:Populate(level, value) end,
			"point", function(parent) return "TOPRIGHT", "BOTTOMRIGHT" end,
			"dontHook", true
		)
		Postal_BlackBookButton:SetScript("OnClick", function(self)
			if dewdrop:IsOpen(self) then
				dewdrop:Close()
			else
				dewdrop:Open(self)
			end
		end)
		Postal_BlackBookButton:SetScript("OnHide", function()
			if dewdrop:IsOpen(self) then
				dewdrop:Close()
			end
		end)
	end
	self:RegisterEvent("MAIL_SHOW")
	-- For enabling after a disable
	Postal_BlackBookButton:Show()
end

function Postal_BlackBook:OnDisable()
	--self:Reset()	-- Disabling modules unregisters all events/hook automatically
	Postal_BlackBookButton:Hide()
end

function Postal_BlackBook:MAIL_SHOW()
	self:RegisterEvent("MAIL_CLOSED", "Reset")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
end

function Postal_BlackBook:Reset()
	dewdrop:Close()
	self:UnregisterEvent("MAIL_CLOSED")
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
end

local function SetSendMailName(name)
	SendMailNameEditBox:SetText(name)
	dewdrop:Close()
end

function Postal_BlackBook:AddContact()
	local name = strtrim(SendMailNameEditBox:GetText())
	if name == "" then return end
	local db = self.db.char.contacts
	for k = 1, #db do
		if name == db[k] then return end
	end
	tinsert(db, name)
	table.sort(db)
end

function Postal_BlackBook:RemoveContact()
	local name = strtrim(SendMailNameEditBox:GetText())
	if name == "" then return end
	local db = self.db.char.contacts
	for k = 1, #db do
                if name == db[k] then tremove(db, k) return end
	end
end

function Postal_BlackBook:Populate(level, value)
	if level == 1 then
		local db = self.db.char.contacts
		dewdrop:AddLine("text", L["Contacts"], "isTitle", true)
		for k = 1, #db do
			dewdrop:AddLine(
				"text", db[k],
				"func", SetSendMailName,
				"arg1", db[k]
			)
		end
		dewdrop:AddLine()
		dewdrop:AddLine(
			"text", L["Add Contact"],
			"func", self.AddContact,
			"arg1", self
		)
		dewdrop:AddLine(
			"text", L["Remove Contact"],
			"func", self.RemoveContact,
			"arg1", self
		)
		dewdrop:AddLine()
		dewdrop:AddLine("text", L["Friends"], "hasArrow", true, "value", "friend" )
		dewdrop:AddLine("text",  L["Guild"], "hasArrow", true, "value", "guild" )
	elseif level == 2 then
		if value == "friend" then
			local numFriends = GetNumFriends()
			if numFriends > 0 and numFriends <= 25 then
				for i = 1, numFriends do
					local name = GetFriendInfo(i)
					dewdrop:AddLine(
						"text", name,
						"func", SetSendMailName,
						"arg1", name
					)
				end
			elseif numFriends > 25 then
				-- More than 25 people, split the list into multiple sublists of 25
				local num = 0
				for i = 1, numFriends, 25 do
					num = num + 1
					dewdrop:AddLine("text", L["Part %d"]:format(num), "hasArrow", true, "value", "fpart"..num )
				end
			end
		elseif value == "guild" then
			local numFriends = GetNumGuildMembers(true)
			if numFriends > 0 and numFriends <= 25 then
				for i = 1, numFriends do
					local name, rank = GetGuildRosterInfo(i)
					dewdrop:AddLine(
						"text", name.." |cffffd200("..rank..")|r",
						"func", SetSendMailName,
						"arg1", name
					)
				end
			elseif numFriends > 25 then
				-- More than 25 people, split the list into multiple sublists of 25
				local num = 0
				for i = 1, numFriends, 25 do
					num = num + 1
					dewdrop:AddLine("text", L["Part %d"]:format(num), "hasArrow", true, "value", "gpart"..num )
				end
			end
		end
	elseif level == 3 then
		if type(value) == "string" then
			if strfind(value, "fpart") then
				local startIndex = tonumber(strmatch(value, "fpart(%d+)")) * 25 - 24
				local endIndex = min(startIndex+24, GetNumFriends())
				for i = startIndex, endIndex do
					local name = GetFriendInfo(i)
					dewdrop:AddLine(
						"text", name,
						"func", SetSendMailName,
						"arg1", name
					)
				end
			elseif strfind(value, "gpart") then
				local startIndex = tonumber(strmatch(value, "gpart(%d+)")) * 25 - 24
				local endIndex = min(startIndex+24, GetNumGuildMembers(true))
				for i = startIndex, endIndex do
					local name, rank = GetGuildRosterInfo(i)
					dewdrop:AddLine(
						"text", name.." |cffffd200("..rank..")|r",
						"func", SetSendMailName,
						"arg1", name
					)
				end
			end
		end
	end
end
