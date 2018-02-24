
local _G = _G

_G.IgM_SV = {
	enabled = true,
	list = {},
}


local frame = CreateFrame("Frame")

frame:SetScript("OnEvent", function(self, event, ...)
	--DBG print("IGM:",event,...)
	return frame[event](frame,event,...)
end)

local list;	-- will be pointed to the relevant realm entry inside IgM_SV.list on init (if IgM is enabled)

local IndexToPlayer = {}
local SysIgnoreList = {}



local strmatch = string.match
local strupper = string.upper
local strsub = string.sub
local gsub = gsub
local pairs,ipairs,next,type = pairs,ipairs,next,type
local tonumber,tostring=tonumber,tostring
local format,print = format,print
local time,date = time,date
local tinsert,tremove,sort = tinsert,tremove,sort
local min,max = min,max
local GetTime = GetTime
local UnitName = UnitName




-----------------------------------------------------------------------
-- Utilities


local function shortDate(when)
	if time() - when < 3600*24*200 then
		return date("%d %b", when)
	else
		return date("%b %Y", when)
	end
end

local function fixname(name)
	if strmatch(name, "^[a-z]") then		-- can't just strupper first char. flat out. they can be utf-8. and hope that the user typed the rest in correct case (and the first in correct case if it isn't ASCII!)
		return strupper(strsub(name,1,1))..strsub(name,2);
	end
	return name;
end

local function splitargs(str)
	local n,r = strmatch(str, "^ *(..-) *: *(.*)");
	if not n then
		n = strmatch(str, "^ *(..-) *$")
	end
	if not n then
		print("IgnoreMore: '"..str.."' does not look like a valid player name")
		return
	end
	if strmatch(n, " ") and not strmatch(n, "^.[^ ]-%-") then
		print("IgnoreMore: '"..n.."' does not look like a valid player name")
		return
	end
	return n,r
end


-----------------------------------------------------------------------
-- Fake event generators

local function generateEvent(evtname,...)
	local a1,a2,a3,a4,a5,a6,a7,a8,a9 = _G.arg1, _G.arg2, _G.arg3, _G.arg4, _G.arg5, _G.arg6, _G.arg7, _G.arg8, _G.arg9
	local e = _G.event
	local t = _G.this
	
	--DBG print("Generating event",evtname,...)
	for i,frame in ipairs({_G.GetFramesRegisteredForEvent(evtname)}) do
		local onevent = frame:GetScript("OnEvent")
		if onevent then
			--DBG print("    '"..(frame:GetName() or tostring(frame)).."'",tostring(onevent))
			_G.this=frame
			_G.event=evtname
			_G.arg1, _G.arg2, _G.arg3, _G.arg4, _G.arg5, _G.arg6, _G.arg7, _G.arg8, _G.arg9 = ...
			onevent(frame,evtname,...)
		end
	end
	
	_G.this=t
	_G.event=e
	_G.arg1,_G.arg2,_G.arg3,_G.arg4,_G.arg5,_G.arg6,_G.arg7,_G.arg8,_G.arg9 = a1, a2, a3, a4, a5, a6, a7, a8, a9
end

local function generateSysMsg(msg)
	generateEvent("CHAT_MSG_SYSTEM", msg, "", "", "", "", "", "", "", "", "", "")
end






-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
-- API Hooks
--

local orig_AddIgnore = AddIgnore;
local orig_AddOrDelIgnore = AddOrDelIgnore;
local orig_DelIgnore = DelIgnore;
local orig_GetIgnoreName = GetIgnoreName;
local orig_GetNumIgnores = GetNumIgnores;
local orig_GetSelectedIgnore = GetSelectedIgnore;
local orig_SetSelectedIgnore = SetSelectedIgnore;


-- AddIgnore

local function IgM_AddIgnore(name, reason, quiet)
	if type(name)~="string" or #name<2 then
		return;
	end
	name=fixname(name)
	
	if name==UnitName("player") then
		if not quiet then
			generateSysMsg(_G.ERR_IGNORE_SELF);
		end
		return false
	end
	
	local entry = list[name]
	
	if not reason and type(entry)=="table" then
		if not quiet then 
			generateSysMsg(format(_G.ERR_IGNORE_ALREADY_S, name))
		end
		return false
	end
	
	if type(entry)=="table" then
		-- just an update, no creation
	else
		entry = {}
		tinsert(IndexToPlayer, name);
		list[name] = entry
	end
	
	entry.time=time();
	entry.reason=reason;
	
	if not quiet then
		if reason then 
			generateSysMsg(format(_G.ERR_IGNORE_ADDED_S, name)..' "'..reason..'"')
		else
			generateSysMsg(format(_G.ERR_IGNORE_ADDED_S, name))
		end			
	end
	
	generateEvent("IGNORELIST_UPDATE")
	return true
end
_G.IgM_AddIgnore = IgM_AddIgnore

_G.AddIgnore=function(name)
	if not list then 
		return orig_AddIgnore(name)
	end
	local n,r = splitargs(name)
	if not n then return end
	return IgM_AddIgnore(n, r)
end


-- DelIgnore

local function IgM_DelIgnore(name, quiet)
	name=fixname(name);
	
	if type(list[name])~="table" then
		if not quiet then
			generateSysMsg(_G.ERR_IGNORE_NOT_FOUND);
		end
		return false
	end

	for k,v in pairs(IndexToPlayer) do
		if(v==name) then
			tremove(IndexToPlayer, k)
			break
		end
	end
	
	list[name]=0	-- flag it as unignored so that it can be removed from the system ignore list of alts also
	
	if SysIgnoreList[name] then
		orig_DelIgnore(name)
		SysIgnoreList[name]=nil
	elseif not quiet then
		generateSysMsg(format(_G.ERR_IGNORE_REMOVED_S,name));
		generateEvent("IGNORELIST_UPDATE");
	end
	return true
end
_G.IgM_DelIgnore=IgM_DelIgnore

_G.DelIgnore=function(name)
	if not list then 
		return orig_DelIgnore(name)
	end
	IgM_DelIgnore(name)
end


-- AddOrDelIgnore

local function IgM_AddOrDelIgnore(name, reason, quiet)
	name=fixname(name)
	if (reason or "")~="" or type(list[name])~="table" then
		IgM_AddIgnore(name,reason,quiet)
	else
		IgM_DelIgnore(name,quiet)
	end
end
_G.IgM_AddOrDelIgnore=IgM_AddOrDelIgnore

_G.AddOrDelIgnore=function(name)
	if not list then 
		return orig_AddOrDelIgnore(name)
	end
	local n,r = splitargs(name)
	if not n then return end
	return IgM_AddOrDelIgnore(n, r)
end


-- GetIgnoreName

_G.GetIgnoreName=function(i)
	if not list then
		return orig_GetIgnoreName(i)
	end
	return IndexToPlayer[i] or "Unknown"
end


-- GetNumIgnores

_G.GetNumIgnores=function()
	if not list then
		return orig_GetNumIgnores()
	end
	return #IndexToPlayer
end


-- GetSelectedIgnore   (god this is pointless..)

local selectedIgnore

_G.GetSelectedIgnore=function()
	if not list then
		return orig_GetSelectedIgnore()
	end
	if not selectedIgnore then
		selectedIgnore = 0
	end
	if selectedIgnore > #IndexToPlayer then
		selectedIgnore = 0
	end
	return selectedIgnore
end


-- SetSelectedIgnore   (god this is pointless..)

_G.SetSelectedIgnore=function(i)
	if not list then
		return orig_SetSelectedIgnore(i)
	end
	selectedIgnore = i
end


-- IgM_GetIgnoreReason
local function IgM_GetIgnoreReason(who)
	if not list then
		return nil
	end
	
	local i = tonumber(who)
	if i then
		who=IndexToPlayer[i];
	end
	if not who then
		return nil
	end
	local entry = list[who]
	if type(entry)~="table" then
		return nil
	end
	return entry.reason or "";
end
_G.IgM_GetIgnoreReason=IgM_GetIgnoreReason






-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
-- UI: Extend IgnoreList with time and reason info
--

-- GLOBALS: FriendsFrameIgnoreScrollFrame, FauxScrollFrame_GetOffset, IGNORES_TO_DISPLAY

local column2 = {}

local orig_IgnoreList_Update = _G.IgnoreList_Update
_G.IgnoreList_Update=function(...)
	
	orig_IgnoreList_Update(...)
	if not list or not FriendsFrameIgnoreScrollFrame then
		return
	end
	
	local ignoreOffset = FauxScrollFrame_GetOffset(FriendsFrameIgnoreScrollFrame)
	local maxwid=0;
	local buttonwid=0;
	for i=1, IGNORES_TO_DISPLAY, 1 do
		local ignoreIndex = i + ignoreOffset
		local nameText = _G["FriendsFrameIgnoreButton"..i].name
		local ignoreButton = _G["FriendsFrameIgnoreButton"..i]
		if nameText and ignoreButton then
			buttonwid = ignoreButton:GetWidth()
			if not column2[i] then
				column2[i] = ignoreButton:CreateFontString("FontString", "OVERLAY", "GameFontHighlightSmall")
				column2[i]:SetJustifyH("LEFT")
				column2[i]:SetPoint("BOTTOMRIGHT", ignoreButton)
				column2[i]:SetPoint("TOP", ignoreButton)
			end
			
			local txt=""
			maxwid = max(maxwid, nameText:GetStringWidth())
			local entry = list[nameText:GetText()]
			if type(entry)=="table" then
				if entry.time then 
					txt=txt..shortDate(entry.time)
				end
				if entry.reason then
					txt=txt..": "..entry.reason;
				end
			end
			column2[i]:SetText(txt)
		end
	end
	
	for i=1, IGNORES_TO_DISPLAY, 1 do
		if column2[i] then
			column2[i]:SetWidth(buttonwid-maxwid-30)
		end
	end
	
end


local lastOnClick_button
local lastOnClick_time = 0

local orig_FriendsFrameIgnoreButton_OnClick = _G.FriendsFrameIgnoreButton_OnClick
_G.FriendsFrameIgnoreButton_OnClick = function(self,...)
	orig_FriendsFrameIgnoreButton_OnClick(self,...)
	if not list then
		return
	end
	if lastOnClick_button == self and GetTime() - lastOnClick_time < 0.3 then
-- GLOBALS: StaticPopup_Show
		StaticPopup_Show("EDIT_IGNORE_REASON")
	end
	
	lastOnClick_button = self
	lastOnClick_time = GetTime()
end


-- Make a popup dialog for editing ignore reasons
local dlg = {}
for k,v in pairs(StaticPopupDialogs["SET_FRIENDNOTE"]) do
	dlg[k] = v
end
dlg.maxLetters=256
dlg.text = "Reason for ignoring this player:"
dlg.OnAccept = function(self)
-- GLOBALS: GetIgnoreName, GetSelectedIgnore
	IgM_AddIgnore(GetIgnoreName(GetSelectedIgnore()), self.wideEditBox:GetText());
end
dlg.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	dlg.OnAccept(parent)
	parent:Hide()
end
dlg.OnShow = function(self)
	self.wideEditBox:SetText(IgM_GetIgnoreReason(GetSelectedIgnore()))
	self.wideEditBox:SetFocus()
end

StaticPopupDialogs["EDIT_IGNORE_REASON"] = dlg





-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
-- The actual filtering!
--


-----------------------------------------------------------------------
-- Our chat filtering function, installed via ChatFrame_AddMessageEventFilter

local function chatFilter(self,event,msg,source,...)
	-- print("Message: ", msg, "  Source: ", source)
	if list and type(source)=="string" and source~="" and type(list[source])=="table" then
		if event=="CHAT_MSG_WHISPER_INFORM" then
			return false, msg.."  (NOTE: You are ignoring this player!)", source, ...
		end
		return true
	end
end


-----------------------------------------------------------------------
-- System message filtering

local function pattern(str)
	str = gsub(str, "[%[%]%(%)%%%.%-%+%*]", function(ch) return "%"..ch end)
	return gsub(str, "%%%%s", "(.-)")
end

local _ERR_INVITED_TO_GROUP_SS = "^"..pattern(ERR_INVITED_TO_GROUP_SS)
local _ERR_INVITED_ALREADY_IN_GROUP_SS = "^"..pattern(ERR_INVITED_ALREADY_IN_GROUP_SS)

local notifiedInvite={}

local function sysmsgFilter(self,event,msg,...)

	-- Group invites:
	local player = strmatch(msg, _ERR_INVITED_TO_GROUP_SS) or strmatch(msg, _ERR_INVITED_ALREADY_IN_GROUP_SS)
	if player and type(list[player])=="table" then
		if notifiedInvite[player] then
			return true
		else
			local entry = list[player]
			notifiedInvite[player] = true
			msg = msg.."  (Ignored: "..shortDate(entry.time)..": \""..(entry.reason or "").."\". Further attempts will not be shown.)"
			--DBG print(msg)
			return false, msg, ...
		end
	end
end





-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
-- Other events
--

-- Invites:

-- GLOBALS: DeclineGroup, UIParent
frame:RegisterEvent("PARTY_INVITE_REQUEST")
UIParent:UnregisterEvent("PARTY_INVITE_REQUEST")
function frame:PARTY_INVITE_REQUEST(event,arg1)
	if list and type(list[arg1])=="table" then
		DeclineGroup()
	else
		StaticPopup_Show("PARTY_INVITE", arg1)
	end
end


-- Trades:  unfortunately this doesn't keep ignored people from interrupting Vendors/Bank

-- GLOBALS: TradeFrame, CloseTrade
frame:RegisterEvent("TRADE_SHOW")
TradeFrame:UnregisterEvent("TRADE_SHOW")
function frame:TRADE_SHOW(...)
	local player = UnitName("NPC")
	if list and player and type(list[player])=="table" then
		CloseTrade()
	else
		TradeFrame:GetScript("OnEvent")(TradeFrame,...)
	end
end


-- Duels:

-- GLOBALS: CancelDuel
frame:RegisterEvent("DUEL_REQUESTED")
UIParent:UnregisterEvent("DUEL_REQUESTED")
function frame:DUEL_REQUESTED(event,arg1)
	if list and type(list[arg1])=="table" then
		CancelDuel()
	else
		StaticPopup_Show("DUEL_REQUESTED", arg1)
	end
end


-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
-- Initialization
--

-- GLOBALS: IgM_SV, GetRealmName, UnitFactionGroup

frame:Show()
frame:SetScript("OnUpdate", function()
	frame:Hide()

	if(not IgM_SV.enabled) then
		list = nil;
		return;
	end
	
	local realm = GetRealmName() .. "-" .. UnitFactionGroup("player");
	
	if(not IgM_SV.list[realm]) then
		IgM_SV.list[realm] = {}
	end
	
	list = IgM_SV.list[realm];
	
	-- Loop through the system ignore list and import entries to our list. Remember which ones were on the system ignore list! (So we know to remove them if removal is requested)
	local UNKNOWN = _G.UNKNOWN
	for i=(orig_GetNumIgnores()),1,-1 do
		local name = orig_GetIgnoreName(i)

		if type(name)~="string" or name=="" then
			-- arf, wth... (apparently some user has managed to have this happen, i don't know through which mechanism, but ..)
		elseif name==UNKNOWN then
			-- recently-deleted/transferred user showing up temporarily in the system ignore list; skip it
		elseif not list[name] then
			-- Ignoremore was not aware of this system entry, so add it to the SV!
			list[name] = {
				time=time(), 
				reason="From "..UnitName("player").."'s system ignore list"
			};
			SysIgnoreList[name] = true;
		elseif type(list[name])~="table" then
			-- This user is no longer ignored. So remove from system ignore list.
			orig_DelIgnore(name)
		else
			SysIgnoreList[name] = true
		end
	end
	
	-- Make an indexed list of our entries (several of the APIs work by indices)
	for k,v in pairs(list) do
		if type(k)~="string" or k=="" then
			list[k] = nil  -- arf, wth... (apparently some user has managed to have this happen, i don't know through which mechanism, but ..)
		end
		if type(v)=="table" then
			tinsert(IndexToPlayer, k)
		end
	end
	
	sort(IndexToPlayer)	-- sort it by alpha for easier navigation
	
	-- Install our chat filter
	for _,event in pairs({
		"CHAT_MSG_ACHIEVEMENT",
		"CHAT_MSG_BATTLEGROUND",
		"CHAT_MSG_BATTLEGROUND_LEADER",
		"CHAT_MSG_CHANNEL",
		"CHAT_MSG_CHANNEL_JOIN",
		"CHAT_MSG_CHANNEL_LEAVE",
		"CHAT_MSG_EMOTE",
		"CHAT_MSG_GUILD",
		"CHAT_MSG_GUILD_ACHIEVEMENT",
		"CHAT_MSG_OFFICER",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_RAID_LEADER",
		"CHAT_MSG_RAID_WARNING",
		"CHAT_MSG_SAY",
		"CHAT_MSG_TEXT_EMOTE",
		"CHAT_MSG_WHISPER",
		"CHAT_MSG_WHISPER_INFORM",
		"CHAT_MSG_YELL",
		})
	do
-- GLOBALS: ChatFrame_AddMessageEventFilter
		ChatFrame_AddMessageEventFilter(event, chatFilter)
	end
	
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", sysmsgFilter)
end)


