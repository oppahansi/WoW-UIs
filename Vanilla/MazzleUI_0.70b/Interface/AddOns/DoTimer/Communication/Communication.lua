local state = {}
local unitids

function Communication_OnLoad()
	this:RegisterEvent("CHAT_MSG_ADDON")
	this:RegisterEvent("VARIABLES_LOADED")
	SLASH_DOTCOM1 = "/comm"
	SlashCmdList["DOTCOM"] = Communication_Commands
	DoTimer_CreateTimerGroup(
		"shared",true,true,true,1,1,{
			begin = {
				r = .2,
				g = .2,
				b = 1.0,
			},
			half = {
				r = .2,
				g = .2,
				b = 1.0,
			},
			final = {
				r = .2,
				g = .2,
				b = 1.0,
			},
		}
	)
	Cooldowns_CreateTimerGroup(
		"shared",{
			begin = {
				r = .2,
				g = .2,
				b = 1.0,
			},
			half = {
				r = .2,
				g = .2,
				b = 1.0,
			},
			final = {
				r = .2,
				g = .2,
				b = 1.0,
			},
		}
	)
end

function Communication_AddText(msg) --basic output function
	if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage(msg) end
end

function Communication_AddMenuText(msg,fromgui) -- will output a msg if the text menu was accessed; not the GUI menu
	if not fromgui then Communication_AddText(msg) end
end

function Communication_OnEvent()
	if event == "VARIABLES_LOADED" then Communication_Startup()
	else
		if Communication_Settings.receiving and (arg1 == "DTMR") and (not (arg4 == UnitName("player"))) then
			if not state[arg4] then state[arg4] = {} end
			if arg2 == "cooldownheader" then 
				state[arg4].sending = "cooldowns"
				state[arg4].collected = {}
			elseif arg2 == "debuffheader" then 
				state[arg4].sending = "debuffs"
				state[arg4].collected = {}
			elseif arg2 == "footer" then Communication_SubmitData(arg4)
			else
				if state[arg4].sending then
					if state[arg4].sending == "cooldowns" then Communication_ReceiveCDData(arg2,arg4)
					elseif state[arg4].sending == "debuffs" then Communication_ReceiveDoTData(arg2,arg4)
					end
				end
			end
		end
	end
end

function Communication_Startup()
	if not Communication_Settings then Communication_Settings = {} end
	if Communication_Settings.enabled == nil then Communication_Settings.enabled = true end
	if Communication_Settings.onlyvisible == nil then Communication_Settings.onlyvisible = true end
	if Communication_Settings.newtargets == nil then Communication_Settings.newtargets = true end
	if Communication_Settings.sentdots == nil then Communication_Settings.sentdots = {} end
	if Communication_Settings.sentcds == nil then Communication_Settings.sentcds = {} end
	if Communication_Settings.recdots == nil then Communication_Settings.recdots = {} end
	if Communication_Settings.reccds == nil then Communication_Settings.reccds = {} end
	unitids = DoTimer_ReturnUnitIDs()
	if not Communication_Settings.enabled then CommunicationFrame:SetScript("OnEvent",nil) end
end

function Communication_intable(query,checkedtable)
	return checkedtable[query]
end

local old_DoT_CI = DoTimer_CreateInterface
function Communication_DoT_CI(external,frommenu)
	old_DoT_CI(external,frommenu)
	if (not external) and Communication_Settings.enabled and Communication_Settings.receiving then Communication_SendDoTData() end
end
DoTimer_CreateInterface = Communication_DoT_CI

local old_CD_CI = Cooldowns_CreateInterface
function Communication_CD_CI(external,frommenu)
	old_CD_CI(external,frommenu)
	if (not external) and Communication_Settings.enabled and Communication_Settings.receiving then Communication_SendCDData() end
end
Cooldowns_CreateInterface = Communication_CD_CI

function Communication_SendDoTData()
	if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then return end
	SendAddonMessage("DTMR","debuffheader","RAID")
	local casted = DoTimer_ReturnData()
	for i = 1,table.getn(casted) do
		SendAddonMessage("DTMR",string.format("<t><%s><%d><%d><%d><%s>",casted[i].target,casted[i].sex,casted[i].level,casted[i].icon,casted[i].type),"RAID")
		for id = 1,table.getn(casted[i]) do
			local spell = string.lower(casted[i][id].spell)
			local type = casted[i][id].type
			if Communication_intable(spell,Communication_Settings.sentdots) and (type == "debuff" or type == "depreciated" or type == "enslave") then
				SendAddonMessage("DTMR",string.format("<d><%s><%s><%d><%f><%s>",casted[i][id].spell,casted[i][id].texture,casted[i][id].duration,(GetTime() - casted[i][id].time),casted[i][id].english),"RAID")
			end
		end
	end
	SendAddonMessage("DTMR","footer","RAID")
end

function Communication_SendCDData()
	if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then return end
	SendAddonMessage("DTMR","cooldownheader","RAID")
	local casted = Cooldowns_ReturnData()
	for i = 1,table.getn(casted) do
		local spell = string.lower(casted[i].english)
		local type = casted[i].type
		if Communication_intable(spell,Communication_Settings.sentcds) and type == "cooldown" then
			SendAddonMessage("DTMR",string.format("<%s><%s><%d><%f><%s>",(english == "Soulstone" and casted[i].rank or casted[i].spell),casted[i].texture,casted[i].duration,(GetTime() - casted[i].time),casted[i].english),"RAID")
		end
	end
	SendAddonMessage("DTMR","footer","RAID")
end

function Communication_ReceiveDoTData(msg,sender)
	local type,info1,info2,info3,info4,info5 = SpellSystem_ParseString(msg,"<(.-)>")
	if type == "t" then --target data
		local timertable = {
			target = info1,
			sex = info2,
			level = info3,
			icon = info4,
			type = info5,
		}
		table.insert(state[sender].collected,timertable)
	elseif type == "d" and Communication_intable(string.lower(info1),Communication_Settings.recdots) then --debuff data
		local newdebuff = {
			spell = info1,
			rank = sender,
			texture = info2,
			duration = info3,
			time = GetTime() - info4,
			english = info5,
			type = "shared",
		}
		table.insert(state[sender].collected[table.getn(state[sender].collected)],newdebuff)
	end
end

function Communication_ReceiveCDData(msg,sender)
	local info1,info2,info3,info4,info5 = SpellSystem_ParseString(msg,"<(.-)>")
	if Communication_intable(string.lower(info1),Communication_Settings.reccds) then
		local newcooldown = {
			spell = info1,
			rank = sender,
			texture = info2,
			duration = info3,
			time = GetTime() - info4,
			english = info5,
			type = "shared",
		}
		table.insert(state[sender].collected,newcooldown)
	end
end

function Communication_IsVisible(query)
	for _,unit in unitids do
		if UnitName(unit) == query then
			if UnitIsVisible(unit) then return true else return false end
		end
	end
	return true
end

function Communication_SubmitData(sender)
	if Communication_Settings.onlyvisible and not (Communication_IsVisible(sender)) then return end
	if state[sender].collected then
		local casted
		if state[sender].sending == "debuffs" then
			casted = DoTimer_ReturnData()
			for i = table.getn(casted),1,-1 do
				for id = table.getn(casted[i]),1,-1 do
					if casted[i][id].type == "shared" and casted[i][id].rank == sender then table.remove(casted[i],id) end
				end
				if table.getn(casted[i]) == 0 then table.remove(casted,i) end
			end
			for i = 1,table.getn(state[sender].collected) do
				local t = state[sender].collected[i]
				if table.getn(t) > 0 then
					local targetindex = DoTimer_ReturnTargetTable(t.target,t.sex,t.level,t.icon)
					if targetindex then
						for i = 1,table.getn(t) do
							table.insert(casted[targetindex],t[i])
						end
					else
						if Communication_Settings.newtargets then table.insert(casted,t) end
					end
				end
			end
		else
			casted = Cooldowns_ReturnData()
			for i = table.getn(casted),1,-1 do
				if casted[i].type == "shared" and casted[i].rank == arg2 then table.remove(casted,i) end
			end		
			local t = state[sender].collected
			if table.getn(t) > 0 then
				for i = 1,table.getn(t) do
					table.insert(casted,t[i])
				end
			end
		end
		if state[sender].sending == "debuffs" then DoTimer_CreateInterface(1) else Cooldowns_CreateInterface(1) end
	end
	state[sender].sending = nil
	state[sender].collected = nil
end

function Communication_Commands(msg,fromgui)
	if msg == "" then CommunicationMenuFrame:Show()
	elseif string.sub(msg,1,4) == "help" then
		Communication_AddHelpMenu(msg)
	elseif msg == "on" then
		Communication_Settings.enabled = true
		CommunicationFrame:SetScript("OnEvent",function() Communication_OnEvent(event) end)
		Communication_AddMenuText("Communication is now enabled!",fromgui)
	elseif msg == "off" then
		Communication_Settings.enabled = false
		CommunicationFrame:SetScript("OnEvent",nil)
		Communication_AddMenuText("Communication is now disabled.",fromgui)
	elseif msg == "only visible people" then
		Communication_Settings.onlyvisible = true
		Communication_AddMenuText("You will only see communicated timers for players visible to you.",fromgui)
	elseif msg == "all people" then
		Communication_Settings.onlyvisible = false
		Communication_AddMenuText("All communicated timers will be shown.",fromgui)
	elseif msg == "add new targets" then
		Communication_Settings.newtargets = true
		Communication_AddMenuText("New target tables might be created.",fromgui)
	elseif msg == "no new targets" then
		Communication_Settings.newtargets = false
		Communication_AddMenuText("New target tables will not be added.",fromgui)
	elseif msg == "status" then
		Communication_AddText("|cff00ffffCommunication Status:|r")
		Communication_AddText("Addon enabled: |cff00ff00"..tostring(Communication_Settings.status).."|r")
		Communication_AddText("Only visible people: |cff00ff00"..tostring(Communication_Settings.onlyvisible).."|r")
		Communication_AddText("Adding new targets: |cff00ff00"..tostring(Communication_Settings.newtargets).."|r")
		Communication_AddText("Sending Data: |cff00ff00"..tostring(Communication_Settings.sending).."|r")
		Communication_AddText("Receiving Data: |cff00ff00"..tostring(Communication_Settings.receiving).."|r")
	elseif msg == "reset" then
		Communication_AddMenuText("All user data is now reset.")
		Communication_Settings = {}
		Communication_Startup()
	elseif msg == "do not send data" then
		Communication_Settings.sending = false
		Communication_AddMenuText("Data will not be sent.",fromgui)
	elseif msg == "do not receive data" then
		Communication_Settings.receiving = false
		Communication_AddMenuText("Data will not be received.",fromgui)
	elseif msg == "send data" then
		Communication_Settings.sending = true
		Communication_AddMenuText("Data will be sent.",fromgui)
	elseif msg == "receive data" then
		Communication_Settings.receiving = true
		Communication_AddMenuText("Data will be received.",fromgui)
	elseif msg == "show shared timers" then
		Communication_AddText("Sent DoTs:")
		for index,value in Communication_Settings.sentdots do Communication_AddText(index) end
		Communication_AddText("Received DoTs:")
		for index,value in Communication_Settings.recdots do Communication_AddText(index) end
		Communication_AddText("Sent Cooldowns:")
		for index,value in Communication_Settings.sentcds do Communication_AddText(index) end
		Communication_AddText("Received Cooldowns:")
		for index,value in Communication_Settings.sentcds do Communication_AddText(index) end
	elseif string.sub(msg,1,9) == "send dot " then
		local query = string.lower(string.sub(msg,10))
		Communication_Settings.sentdots[query] = 1
		Communication_AddMenuText("The DoT for "..query.." will be shared.",fromgui)
	elseif string.sub(msg,1,8) == "rec dot " then
		local query = string.lower(string.sub(msg,9))
		Communication_Settings.recdots[query] = 1
		Communication_AddMenuText("The DoT for "..query.." will be displayed from others.",fromgui)
	elseif string.sub(msg,1,8) == "send cd " then
		local query = string.lower(string.sub(msg,9))
		Communication_Settings.sentcds[query] = 1
		Communication_AddMenuText("The cooldown for "..query.." will be shared.",fromgui)
	elseif string.sub(msg,1,7) == "rec cd " then
		local query = string.lower(string.sub(msg,8))
		Communication_Settings.reccds[query] = 1
		Communication_AddMenuText("The cooldown for "..query.." will be displayed from others.",fromgui)
	elseif string.sub(msg,1,11) == "unsend dot " then
		local query = string.lower(string.sub(msg,12))
		Communication_Settings.sentdots[query] = nil
		Communication_AddMenuText("The DoT for "..query.." will not be shared.",fromgui)
	elseif string.sub(msg,1,10) == "unrec dot " then
		local query = string.lower(string.sub(msg,11))
		Communication_Settings.recdots[query] = nil
		Communication_AddMenuText("The DoT for "..query.." will not be displayed from others.",fromgui)
	elseif string.sub(msg,1,10) == "unsend cd " then
		local query = string.lower(string.sub(msg,11))
		Communication_Settings.sentcds[query] = nil
		Communication_AddMenuText("The cooldown for "..query.." will not be shared.",fromgui)
	elseif string.sub(msg,1,9) == "unrec cd " then
		local query = string.lower(string.sub(msg,10))
		Communication_Settings.reccds[query] = nil
		Communication_AddMenuText("The cooldown for "..query.." will not be displayed from others.",fromgui)
	else
		Communication_AddMenuText("Type |cff00ff00/comm help|r for more options, or |cff00ff00/comm|r to open the menu!",fromgui)
	end
end
