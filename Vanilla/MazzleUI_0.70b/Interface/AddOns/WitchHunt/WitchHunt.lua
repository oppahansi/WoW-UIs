------------------------------
--      Are you local?      --
------------------------------

local parser = ParserLib:GetInstance("1.1")
local times = {}

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("WitchHunt")

L:RegisterTranslations("enUS", function() return {
	["combatonly"] = true,
	["Combat Only"] = true,
	["Toggle combat only mode."] = true,

	["targetonly"] = true,
	["Target Only"] = true,
	["Toggle target only mode."] = true,

	["lock"] = true,
	["Lock"] = true,
	["Toggle locking of the WitchHunt frame."] = true,

	["display"] = true,
	["Display Mode"] = true,
	["Select behavior for display of messages."] =true,

	["None"] = true,
	["Default"] = true,
	["Error Frame"] = true,
	["Mik's Scrolling Battle Text"] = true,
	["Scrolling Combat Text"] = true,
	["Scrolling Combat Text Message"] = true,

	["font"] = true,
	["Font"] = true,
	["Set the font for the display of messages in the Default frame."] = true,

	["Small"] = true,
	["Normal"] = true,
	["Large"] = true,
	["Huge"] = true,

	["test"] = true,
	["Test"] = true,
	["Test with some dummy WitchHunt messages."] = true,

	["DRAG HERE"] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["combatonly"] = "combatonly",
	["Combat Only"] = "전투에 한정",
	["Toggle combat only mode."] = "전투에 한정 모드를 전환 합니다",

	["targetonly"] = "targetonly",
	["Target Only"] = "대상에 한정",
	["Toggle target only mode."] = "대상에 한정 모드를 전환 합니다",

	["lock"] = "lock",
	["Lock"] = "고정",
	["Toggle locking of the WitchHunt frame."] = "WitchHunt 프레임 고정 기능을 전환 합니다",

	["display"] = "display",
	["Display Mode"] = "표시 모드",
	["Select behavior for display of messages."] ="메시지 표시 방법을 선택합니다",

	["None"] = "없음",
	["Default"] = "기본",
	["Error Frame"] = "오류 프레임",
	["Mik's Scrolling Battle Text"] = "MSBT",
	["Scrolling Combat Text"] = "SCT",
	["Scrolling Combat Text Message"] = "SCT 메시지",

	["font"] = "font",
	["Font"] = "글꼴",
	["Set the font for the display of messages in the Default frame."] = "기본 프레임에 표시할 메시지의 글꼴을 설정합니다",

	["Small"] = "작게",
	["Normal"] = "보통",
	["Large"] = "크게",
	["Huge"] = "매우크게",

	["test"] = "test",
	["Test"] = "테스트",
	["Test with some dummy WitchHunt messages."] = "몇개의 가짜 메시지로 테스트를 합니다",

	["DRAG HERE"] = "여기를 끌면 됩니다",
} end )

local defaults = {
	combatonly = false,
	targetonly = false,
	display = L["Default"],
	font = L["Normal"],
	lock = true,
}

local consoleoptions = {
	type = "group",
	args = {
		[L["combatonly"]] = {
			name = L["Combat Only"], type = "toggle",
			desc = L["Toggle combat only mode."],
			get = function() return WitchHunt.db.profile.combatonly end,
			set = function(v)
				WitchHunt.db.profile.combatonly = v
			end,
		},
		[L["targetonly"]] = {
			name = L["Target Only"], type = "toggle",
			desc = L["Toggle target only mode."],
			get = function() return WitchHunt.db.profile.targetonly end,
			set = function(v)
				WitchHunt.db.profile.targetonly = v
			end,
		},
		[L["lock"]] = {
			name = L["Lock"], type = "toggle",
			desc = L["Toggle locking of the WitchHunt frame."],
			get = function() return WitchHunt.db.profile.lock end,
			set = function(v)
				WitchHunt.db.profile.lock = v
				WitchHunt:UpdateLock()
			end,
		},
		[L["display"]] = {
			name = L["Display Mode"], type = "text",
			desc = L["Select behavior for display of messages."],
			validate = {L["None"], L["Default"], L["Error Frame"]},
			get = function() return WitchHunt.db.profile.display end,
			set = function(v)
			        WitchHunt.db.profile.display = v
			        if v == L["None"] then
					if WitchHunt:IsEventRegistered("WitchHunt_Message") then WitchHunt:UnregisterEvent("WitchHunt_Message") end
			        else 
					if not WitchHunt:IsEventRegistered("WitchHunt_Message") then WitchHunt:RegisterEvent("WitchHunt_Message") end
			        end
			end,
		},
		[L["font"]] = {
			name = L["Font"], type = "text",
			desc = L["Set the font for the display of messages in the Default frame."],
			validate = {L["Small"], L["Normal"], L["Large"], L["Huge"]},
			get = function() return WitchHunt.db.profile.font end,
			set = function(v)
			        WitchHunt.db.profile.font = v
			        WitchHunt:SetFont()
			end,
		},
		[L["test"]] = {
			name = L["Test"], type = "execute",
			desc = L["Test with some dummy WitchHunt messages."],
			func = function()
			        WitchHunt:TriggerEvent("WitchHunt_Message", "[Ammo: See it works!]", "Orange")
			        WitchHunt:ScheduleEvent("WitchHunt_Message", 1, "*Ammo: extra code*", "Yellow")
			        WitchHunt:ScheduleEvent("WitchHunt_Message", 2, "+Ammo: Super duper strength+", "LtBlue")
			end,
		}	
	}	
}

if MikSBT then
	table.insert(consoleoptions.args.display.validate, L["Mik's Scrolling Battle Text"])
end

if SCT_Display or ( SCT and SCT.DisplayText ) then
	table.insert(consoleoptions.args.display.validate, L["Scrolling Combat Text"])
	table.insert(consoleoptions.args.display.validate, L["Scrolling Combat Text Message"])
end


---------------------------------
--      Addon Declaration      --
---------------------------------

WitchHunt = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")

WitchHunt:RegisterDB("WitchHuntDB")
WitchHunt:RegisterDefaults('profile', defaults)
WitchHunt:RegisterChatCommand( { "/wh", "/witchhunt" }, consoleoptions )


------------------------------
--      Initialization      --
------------------------------

function WitchHunt:OnInitialize()
	self.colors = {
		Red    = {r=1, g=0, b=0}, Orange = {r=1, g=0.5, b=0},
		Yellow = {r=1, g=1, b=0}, Green  = {r=0, g=1, b=0},
		LtBlue = {r=0, g=1, b=1}, Blue   = {r=0, g=0, b=1},
		Purple = {r=1, g=0, b=1}, White  = {r=1, g=1, b=1},
		Black  = {r=0, g=0, b=0},
	}

	self.formats = {
		default = "$c: $e",
		emote = "[$c $e]",
		spell = "*$c: $e*",
	 	totem = "$c: $e",
		gain = "$c: +$e+",
		fade = "$c: -$e-",
	}
end

function WitchHunt:OnEnable()
	-- Setup the frame
	self:SetupFrames()

	-- Register our own events
	if self.db.profile.display ~= L["None"] then
		self:RegisterEvent("WitchHunt_Message")
	end

	-- Register the WoW events
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", function(event, info) self:EventHandler(event, info) end)
end

function WitchHunt:OnDisable()
	-- no more events to handle
	parser:UnregisterAllEvents("WitchHunt")
	self:UnregisterAllEvents()
end

function WitchHunt:SetFont()
	if self.db.profile.font == L["Huge"] then
		self.msgframe:SetFontObject(GameFontNormalHuge)
	elseif self.db.profile.font == L["Small"] then
		self.msgframe:SetFontObject(GameFontNormalSmall)
	elseif self.db.profile.font == L["Large"] then
		self.msgframe:SetFontObject(GameFontNormalLarge)
	else
		self.msgframe:SetFontObject(GameFontNormal)
	end
end

function WitchHunt:SetupFrames()
	self.dragbutton = CreateFrame("Button","WitchHunt_DragButton",UIParent)
	self.dragbutton.owner = self
	self.dragbutton:Hide()
	self.dragbutton:ClearAllPoints()
	self.dragbutton:SetWidth(200)
	self.dragbutton:SetHeight(25)
	
	if self.db.profile.x and self.db.profile.y then
		self.dragbutton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.db.profile.x, self.db.profile.y)
	else 
		self.dragbutton:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, 0)
	end	
	self.dragbutton:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = false, tileSize = 16, edgeSize = 16,
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
	self.dragbutton:SetBackdropColor(1,0,0,.4)	
	
	self.dragbutton:SetMovable(true)
	self.dragbutton:RegisterForDrag("LeftButton")
	self.dragbutton:SetScript("OnDragStart", function() this.owner.dragbutton:StartMoving() end )
	self.dragbutton:SetScript("OnDragStop",
		function()
			this.owner.dragbutton:StopMovingOrSizing()
			local _,_,_,x,y = this:GetPoint("CENTER")
			this.owner.db.profile.x = x
			this.owner.db.profile.y = y
		end
                )
	
	self.dragtext = self.dragbutton:CreateFontString(nil, "OVERLAY")
	self.dragtext.owner = self
	self.dragtext:SetFontObject(GameFontNormalSmall)
	self.dragtext:ClearAllPoints()
	self.dragtext:SetTextColor(1, 1, 1, 1)
	self.dragtext:SetWidth(200)
	self.dragtext:SetHeight(25)
	self.dragtext:SetPoint("TOPLEFT", self.dragbutton, "TOPLEFT")
	self.dragtext:SetJustifyH("CENTER")
	self.dragtext:SetJustifyV("MIDDLE")
	self.dragtext:SetText(L["DRAG HERE"])
	
	self.msgframe = CreateFrame("MessageFrame")
	self.msgframe.owner = self
	self.msgframe:ClearAllPoints()
	self.msgframe:SetWidth(600)
	self.msgframe:SetHeight(160)
	self.msgframe:SetPoint("TOP", self.dragbutton, "TOP", 0, 0)
	self.msgframe:SetInsertMode("TOP")
	self.msgframe:SetFrameStrata("HIGH")
	self.msgframe:SetToplevel(true)

	self:UpdateLock()
	self:SetFont()

	self.msgframe:Show()
end

function WitchHunt:UpdateLock()
	if not self.msgframe then self:SetupFrames() end
	if self.db.profile.lock then
		self.dragbutton:SetMovable(false)
		self.dragbutton:RegisterForDrag()
		self.msgframe:SetBackdrop(nil)
		self.msgframe:SetBackdropColor(0,0,0,0)
		self.dragbutton:Hide()
	else
		self.dragbutton:Show()
		self.dragbutton:SetMovable(true)
		self.dragbutton:RegisterForDrag("LeftButton")
		self.msgframe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = false, tileSize = 16, edgeSize = 16,
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
		self.msgframe:SetBackdropColor(1,0,0,.4)
	end
end

function WitchHunt:IsFriendly( name )
	local i,n,unit
	if name == UnitName("player") then
		return true
	end
	if name == UnitName("pet") and UnitIsFriend("player", "pet") then
		return true
	end
	for i = 1, 4 do 
		unit = "party"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end
		unit = "partypet"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end			
	end
	n = GetNumRaidMembers()
	if n > 0 then
		for i = 1, n do
			unit = "raid"..i
			if name == UnitName(unit) and UnitIsFriend("player", unit) then
				return true
			end
			unit = "raidpet"..i
                        if name == UnitName(unit) and UnitIsFriend("player", unit) then
                                return true
			end
		end
	end
end

function WitchHunt:GetColor( color )
	local c = (type(color) == "string" and self.colors[color]) or color
	if type(c) == "table" then
		if c[1] then return c[1], c[2], c[3]
		elseif c.r and c.g and c.b then return c.r, c.g, c.b end
	end
end

-- Burn the witch!
function WitchHunt:Burn(caster, effect, format, color)
	if not caster or not effect then return end

	-- Are we even on a hunt?
	if self.db.profile.combatonly and not UnitAffectingCombat("player") then return end

	-- Check if this witch requires burning
	if self:IsFriendly(caster) then return end
	if self.db.profile.targetonly then
		if not UnitExists("target") then return
		elseif UnitName("target") ~= caster then return end		
	end

	-- Can we build this pyre?
	if not self.formats[format] then format = L["Default"] end

	-- Prepare the pyre!
	local text = string.gsub( string.gsub( self.formats[format], "$c", caster), "$e", effect )

	-- Light the Fire!
	local t = GetTime()
	if ( not times[text] ) or ( times[text] and (times[text] + 3) <= t ) then
		times[text] = t
		self:TriggerEvent("WitchHunt_Message", text, color)
	end
end


-- -- -- -- -- -- -- -- -- -- -- -- -- --
-- All events we watch out for         --
-- -- -- -- -- -- -- -- -- -- -- -- -- --

function WitchHunt:WitchHunt_Message(msg, color)
	if not msg then return end
	local red, green, blue = self:GetColor(color)
	local display = self.db.profile.display

	local frame = nil

	if MikSBT and display == L["Mik's Scrolling Battle Text"] then
		MikSBT.DisplayMessage(msg, MikSBT.DISPLAYTYPE_NOTIFICATION, false, red * 255, green * 255, blue * 255)
		return
	elseif ( SCT_Display or ( SCT and SCT.DisplayText ) ) and display == L["Scrolling Combat Text"] then
		if SCT_Display then
			SCT_Display( msg, self.colors[color] )
		else 
			SCT:DisplayText( msg, self.colors[color] )
		end
		return
	elseif ( SCT_Display or ( SCT and SCT.DisplayText ) ) and display == L["Scrolling Combat Text Message"] then
		if SCT_Display then
			SCT_Display_Message( msg, self.colors[color] )
		else
			SCT:DisplayMessage( msg, self.colors[color] )
		end
		return
	elseif display == L["Error Frame"] then
		frame = UIErrorsFrame
	elseif display == L["Default"] then
		frame = self.msgframe
	end

	if frame then frame:AddMessage(msg, red or 1, green or 1, blue or 1, 1, UIERRORS_HOLD_TIME) end
end


function WitchHunt:CHAT_MSG_MONSTER_EMOTE(msg, monster)
	msg = string.gsub( msg, "%%s", "")
	self:Burn( monster, msg, "emote", "Orange")
end


function WitchHunt:EventHandler(event, info)
    if info.type == "cast" then
        if info.isBegin then
            self:Burn( info.source, info.skill, "spell", "Yellow")
        else 
            if string.find(info.skill, "Totem") then
                self:Burn( info.source, info.skill, "totem", "Green")
            else
                self:Burn( info.source, info.skill, "spell", "Purple")
            end
        end
    elseif info.type == "buff" and not info.amount then 
        self:Burn( info.victim, info.skill, "gain", "LtBlue")
    end
end

