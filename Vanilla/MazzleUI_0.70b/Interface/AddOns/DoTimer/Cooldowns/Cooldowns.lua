local casted = {} --governs the currently casted debuffs.  entries are 1-10 targets, which in turn are 1-20 debuffs and the target name
local sentcooldown = {} --holds data waiting for a successful cast
local cooldowns,localedata 
local sstarget --who you put the soulstone on
local timerdata = {}
local cooldownstable = { --to match the data to dotimer
	target = "Cooldowns ", --the space is in case some player named "Cooldowns" exists
	sex = 0,
	level = 0,
	icon = 0,
	type = "player",
}

function Cooldowns_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	this:RegisterEvent("BAG_UPDATE_COOLDOWN")
	this:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	SpellSystem_RegisterEvent(this,"SPELLSYSTEM_BEGIN")
	SpellSystem_RegisterEvent(this,"SPELLSYSTEM_SUCCESS")
	SLASH_COOLDOWNS1 = "/cooldowns"
	SLASH_COOLDOWNS2 = "/cd"
	SlashCmdList["COOLDOWNS"] = Cooldowns_Commands
end

function Cooldowns_OnEvent(event)
	if event == "VARIABLES_LOADED" then Cooldowns_Startup() -- when you first log in
	elseif event == "SPELLSYSTEM_SUCCESS" then Cooldowns_CheckCooldown()
	elseif event == "SPELLSYSTEM_BEGIN" then Cooldowns_PotentialCooldown()
	else Cooldowns_CheckForCooldowns(event)
	end
end

function Cooldowns_AddText(msg) --basic output function
	if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage(msg) end
end

function Cooldowns_AddMenuText(msg,fromgui) -- will output a msg if the text menu was accessed; not the GUI menu
	if not fromgui then Cooldowns_AddText(msg) end
end

function Cooldowns_OnUpdate()
	if table.getn(casted) == 0 then CooldownsFrame:SetScript("OnUpdate",nil) end
	local time = GetTime()
	for i = table.getn(casted),1,-1 do
		if time >= casted[i].time + casted[i].duration then --yep it's done all right
			Cooldowns_RemoveTimer(i)
		elseif not Cooldowns_Settings.dotimer then
			local type = casted[i].type
			if Cooldowns_Settings.format == "icons" then
				local remaining = tonumber(string.format("%d",math.floor(casted[i].duration - time + casted[i].time))) --modifying the displayed time if it needs changing
				if (not casted[i].displayed) or (remaining < casted[i].displayed) then
					getglobal("CooldownsTableCooldown"..i.."IconTime"):SetText(Cooldowns_ReturnNewDuration(remaining)) --updating the time if they aren't done
					if remaining == 5 then
						if Cooldowns_Settings.playsound then PlaySoundFile("Interface\\Addons\\DoTimer\\Extras\\expalert.wav") end
						if Cooldowns_Settings.expalert then 
							getglobal("CooldownsTableCooldown"..i.."IconButton"):LockHighlight()
							getglobal("CooldownsTableCooldown"..i.."IconTime"):SetTextColor(timerdata[type].colors.final.r,timerdata[type].colors.final.g,timerdata[type].colors.final.b)
						end
					elseif remaining == 3 then
						if Cooldowns_Settings.expalert then getglobal("CooldownsTableCooldown"..i.."IconButton"):UnlockHighlight() end
					elseif (remaining == math.floor(casted[i].duration) / 2) and remaining > 5 then
						getglobal("CooldownsTableCooldown"..i.."IconTime"):SetTextColor(timerdata[type].colors.half.r,timerdata[type].colors.half.g,timerdata[type].colors.half.b)
					end
					casted[i].displayed = remaining
				end
			else
				local remaining = casted[i].duration - time + casted[i].time
				getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetValue(remaining)
				local otherremaining = tonumber(string.format("%d",math.floor(remaining))) --modifying the displayed time if it needs changing
				if (not casted[i].displayed) or (otherremaining < casted[i].displayed) then
					getglobal("CooldownsTableCooldown"..i.."BarStatusTime"):SetText(Cooldowns_ReturnNewDuration(otherremaining).." - "..casted[i].spell) --updating the time if they aren't done
					if otherremaining == 5 then
						if Cooldowns_Settings.playsound then PlaySoundFile("Interface\\Addons\\DoTimer\\Extras\\expalert.wav") end
						if Cooldowns_Settings.expalert then 
							getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetStatusBarColor(timerdata[type].colors.final.r,timerdata[type].colors.final.g,timerdata[type].colors.final.b)
						end
					elseif (otherremaining > 5) and (otherremaining == math.floor(casted[i].duration / 2)) then
						getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetStatusBarColor(timerdata[type].colors.half.r,timerdata[type].colors.half.g,timerdata[type].colors.half.b)
					end
					casted[i].displayed = otherremaining
				end
			end
		end
	end
end

function Cooldowns_RemoveTimer(cooldownid)
	table.remove(casted,cooldownid)
	Cooldowns_CreateInterface()
end

function Cooldowns_RemoveAllTimers()
	for i = 1,table.getn(casted) do
		table.remove(casted,1)
	end
	Cooldowns_CreateInterface()
end

function Cooldowns_Startup() --called on first login per session, creates the default settings if needed or else just hides the interface and sets the scale
	if not Cooldowns_Settings then Cooldowns_Settings = {} end
	if Cooldowns_Settings.status == nil then 
		Cooldowns_Settings.status = true 
		CooldownsAnchorFrameFirstUse:Show()
		CooldownsAnchorFrameFirstUse:SetText("<-- Welcome to Cooldowns!  Please type \"/cooldowns help new\" for first-time information.\nSimply drag the drag button to remove this display.")
	end
	if Cooldowns_Settings.scale == nil then Cooldowns_Settings.scale = 1 end --setting the default settings
	if Cooldowns_Settings.names == nil then Cooldowns_Settings.names = true end
	if Cooldowns_Settings.maxdebuffs == nil then Cooldowns_Settings.maxdebuffs = 8 end
	if Cooldowns_Settings.locked == nil then Cooldowns_Settings.locked = false end
	if Cooldowns_Settings.debufflayout == nil then Cooldowns_Settings.debufflayout = "down" end
	if Cooldowns_Settings.sortmethod == nil then Cooldowns_Settings.sortmethod = "remaining" end
	if Cooldowns_Settings.clickable == nil then Cooldowns_Settings.clickable = true end
	if Cooldowns_Settings.expalert == nil then Cooldowns_Settings.expalert = true end
	if Cooldowns_Settings.buttonscale == nil then Cooldowns_Settings.buttonscale = 1 end
	if Cooldowns_Settings.playsound == nil then Cooldowns_Settings.playsound = false end
	if Cooldowns_Settings.format == nil then Cooldowns_Settings.format = "bars" end
	if Cooldowns_Settings.barlength == nil then Cooldowns_Settings.barlength = 150 end
	if Cooldowns_Settings.dotimer == nil then Cooldowns_Settings.dotimer = false end
	if Cooldowns_Settings.blocked == nil then Cooldowns_Settings.blocked = {} end
	CooldownsMainFrame:SetScale(Cooldowns_Settings.scale)
	CooldownsTable:Hide()
	Cooldowns_DefineFormat()
	for i = 1,20 do
		getglobal("CooldownsTableCooldown"..i):Hide()
	end
	local _,class = UnitClass("player")
	cooldowns,localedata = Cooldowns_DefineSpells(class)
	Cooldowns_DefineInterface(Cooldowns_Settings.debufflayout,1)
	if Cooldowns_Settings.locked then CooldownsAnchorFrame:Hide() else CooldownsAnchorFrame:Show() end
	if Cooldowns_Settings.status == "off" then CooldownsFrame:SetScript("OnEvent",nil) end
	for i = 1,20 do
		getglobal("CooldownsTableCooldown"..i.."IconButton"):EnableMouse(Cooldowns_Settings.clickable)
		getglobal("CooldownsTableCooldown"..i.."BarButton"):EnableMouse(Cooldowns_Settings.clickable)
		getglobal("CooldownsTableCooldown"..i.."BarButton"):SetScale(Cooldowns_Settings.buttonscale)
		getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetScale(Cooldowns_Settings.buttonscale)
		getglobal("CooldownsTableCooldown"..i.."BarBackground"):SetScale(Cooldowns_Settings.buttonscale)
		getglobal("CooldownsTableCooldown"..i.."IconButton"):SetScale(Cooldowns_Settings.buttonscale)
	end
end

function Cooldowns_ReturnEnglish(texture) --returns the english name of the spell
	if localedata[texture] then return localedata[texture].name end
	return "unknown"
end

function Cooldowns_ReturnNewDuration(time) --modifies the time remaining on the debuff into a format suitable for the screen
	newtime = math.floor(time)
	local minutes = math.floor(newtime / 60)
	local seconds = math.floor(newtime - (60 * minutes))
	if seconds < 10 then seconds = "0"..seconds else seconds = tostring(seconds) end
	return string.format("%d:%s",minutes,seconds)
end 

function Cooldowns_CheckCooldown()
	if Cooldowns_intable(arg1.texture,cooldowns) then
		for i = table.getn(sentcooldown),1,-1 do
			if sentcooldown[i].texture == arg1.texture then
				sentcooldown[i].time = GetTime() - .5
				Cooldowns_CreateCooldown(sentcooldown[i])
				table.remove(sentcooldown,i)
				if table.getn(sentcooldown) == 0 then CooldownsDelayFrame:SetScript("OnUpdate",nil) end
				break
			end
		end
	end
end

function Cooldowns_PotentialCooldown()
	if Cooldowns_intable(arg1.texture,cooldowns) then
		local spell = {}
		for index,value in arg1 do spell[index] = value end
		spell.type = "cooldown"
		spell.duration = localedata[spell.texture].duration
		spell.time = GetTime()
		spell.english = Cooldowns_ReturnEnglish(spell.texture)
		table.insert(sentcooldown,spell)
		if spell.english == "Soulstone" then 
			sstarget = arg2.name 
		end
		if table.getn(sentcooldown) == 1 then CooldownsDelayFrame:SetScript("OnUpdate",function() Cooldowns_CheckPreTimers() end) end
	end
end

function Cooldowns_CheckForCooldowns(event)
	if event == "ACTIONBAR_UPDATE_COOLDOWN" then
		for i = 1,18 do
			local spellname,spellrank = SpellSystem_SetInventoryItem(i)
			local texture = GetInventoryItemTexture("player",i)
			if spellname and Cooldowns_intable(texture,cooldowns) then
				local start,duration = GetInventoryItemCooldown("player",i)
				if start > 0 and duration > 10 then
					local found
					for i = table.getn(sentcooldown),1,-1 do
						if sentcooldown[i].texture == texture then
							found = 1
							sentcooldown[i].time = start
							sentcooldown[i].duration = duration
							Cooldowns_CreateCooldown(sentcooldown[i])
							table.remove(sentcooldown,i)
						end
					end
					if not found then
						local entry = {
							spell = spellname,
							rank = spellrank, 
							texture = texture, 
							duration = duration, 
							time = start,
							type = "cooldown",
							english = Cooldowns_ReturnEnglish(texture)
						}
						Cooldowns_CreateCooldown(entry)
					end
				elseif start == 0 then
					Cooldowns_RemoveCooldown(texture)
				end
			end
		end
	elseif event == "BAG_UPDATE_COOLDOWN" then
		for b = 0,4 do
			for s = 1,GetContainerNumSlots(b) do
				local spellname,spellrank = SpellSystem_SetBagItem(i)
				local texture = GetContainerItemInfo(b,s)
				if spellname and Cooldowns_intable(texture,cooldowns) then
					local start,duration = GetContainerItemCooldown(b,s)
					if start > 0 and duration > 10 then
						local found
						for i = table.getn(sentcooldown),1,-1 do
							if sentcooldown[i].texture == texture then
								found = 1
								sentcooldown[i].time = start
								sentcooldown[i].duration = duration
								Cooldowns_CreateCooldown(sentcooldown[i])
								table.remove(sentcooldown,i)
							end
						end
						if not found then
							local entry = {
								spell = spellname,
								rank = spellrank, 
								texture = texture, 
								duration = duration, 
								time = start,
								type = "cooldown",
								english = Cooldowns_ReturnEnglish(texture)
							}
							Cooldowns_CreateCooldown(entry)
						end
					elseif start == 0 then
						Cooldowns_RemoveCooldown(texture)
					end
				end
			end
		end
	elseif event == "SPELL_UPDATE_COOLDOWN" then
		local types = {BOOKTYPE_SPELL,BOOKTYPE_PET}
		for index,value in types do
			local i = 1
			local name = GetSpellName(i,value)
			while name do
				local spellname,spellrank = GetSpellName(i,value)
				local texture = GetSpellTexture(i,value)
				if spellname and Cooldowns_intable(texture,cooldowns) then
					local start,duration = GetSpellCooldown(i,value)
					if start > 0 and duration > 10 then
						local found
						for i = table.getn(sentcooldown),1,-1 do
							if sentcooldown[i].texture == texture then
								found = 1
								sentcooldown[i].time = start
								sentcooldown[i].duration = duration
								Cooldowns_CreateCooldown(sentcooldown[i])
								table.remove(sentcooldown,i)
							end
						end
						if not found then
							local entry = {
								spell = spellname,
								rank = spellrank, 
								texture = texture, 
								duration = duration, 
								time = start,
								type = "cooldown",
								english = Cooldowns_ReturnEnglish(texture)
							}
							Cooldowns_CreateCooldown(entry)
						end
					elseif start == 0 then
						Cooldowns_RemoveCooldown(texture)
					end
				end
				i = i + 1
				name = GetSpellName(i,value)
			end
		end
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		for i = 1,10 do
			local spellname = GetPetActionInfo(i)
			local _,_,texture = GetPetActionInfo(i)
			if spellname and Cooldowns_intable(texture,cooldowns) then
				local start,duration = GetPetActionCooldown(i)
				if start > 0 and duration > 10 then
					local entry = {
						spell = spellname,
						rank = "", 
						texture = texture, 
						duration = duration, 
						time = start,
						type = "cooldown",
						english = Cooldowns_ReturnEnglish(texture)
					}
					Cooldowns_CreateCooldown(entry)
				elseif start == 0 then
					Cooldowns_RemoveCooldown(texture)
				end
			end
		end
	end
	if table.getn(sentcooldown) == 0 then CooldownsDelayFrame:SetScript("OnUpdate",nil) end
end

function Cooldowns_RemoveCooldown(texture)
	for i = table.getn(casted),1,-1 do
		if casted[i].texture == texture then
			Cooldowns_RemoveTimer(i)
		end
	end
end

function Cooldowns_intable(query,checkedtable)
	return checkedtable[Cooldowns_ReturnEnglish(query)]
end

function Cooldowns_CheckPreTimers()
	local time = GetTime()
	for i = table.getn(sentcooldown),1,-1 do
		if time >= sentcooldown[i].time + 10 then
			table.remove(sentcooldown,i)
			if table.getn(sentcooldown) == 0 then CooldownsDelayFrame:SetScript("OnUpdate",nil) end
		end
	end
end

function Cooldowns_CreateCooldown(spelltable)
	if Cooldowns_Settings.blocked[string.lower(spelltable.spell)] then return end
	for i = 1,table.getn(casted) do
		if casted[i].texture == spelltable.texture and math.abs(casted[i].duration - spelltable.duration) <= 1 and math.abs(casted[i].time - spelltable.time) <= 1 then return end
	end
	if spelltable.english == "Soulstone" then 
		spelltable.rank = sstarget or "" 
	end
	for i = table.getn(casted),1,-1 do
		if casted[i].spell == spelltable.spell then
			table.remove(casted,i)
		end
	end
	if table.getn(casted) == Cooldowns_Settings.maxdebuffs then
		table.remove(casted,1)
	end
	table.insert(casted,spelltable)
	Cooldowns_CreateInterface()
end

function Cooldowns_DefineFormat()
	if Cooldowns_Settings.format == "icons" then
		for i = 1,20 do
			getglobal("CooldownsTableCooldown"..i.."Icon"):Show()
			getglobal("CooldownsTableCooldown"..i.."Bar"):Hide()
		end
	else
		for i = 1,20 do
			getglobal("CooldownsTableCooldown"..i.."Icon"):Hide()
			getglobal("CooldownsTableCooldown"..i.."Bar"):Show()
			getglobal("CooldownsTableCooldown"..i.."Bar"):SetWidth(Cooldowns_Settings.barlength + 25)
			getglobal("CooldownsTableCooldown"..i.."BarStatusTime"):SetWidth(Cooldowns_Settings.barlength - 5)
			getglobal("CooldownsTableCooldown"..i.."BarButton"):SetWidth(Cooldowns_Settings.barlength + 25)
			getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetWidth(Cooldowns_Settings.barlength)
			getglobal("CooldownsTableCooldown"..i.."BarBackground"):SetWidth(Cooldowns_Settings.barlength)
		end
	end
	Cooldowns_ResizeInterface()
end

function Cooldowns_ResizeInterface() --resizes the frames that hold the debuffs so that they are more tightly compacted on the screen
	local maxwidth,maxheight,otherwidth,otherheight,debuffheight,debuffwidth,timerheight,timerwidth
	if Cooldowns_Settings.format == "icons" then
		debuffheight = CooldownsTableCooldown1IconButton:GetHeight() * Cooldowns_Settings.buttonscale
		debuffwidth = CooldownsTableCooldown1IconButton:GetWidth() * Cooldowns_Settings.buttonscale
		timerheight = CooldownsTableCooldown1IconTime:GetHeight()
		timerwidth = CooldownsTableCooldown1IconTime:GetWidth()
	else
		debuffheight = CooldownsTableCooldown1BarButton:GetHeight() * Cooldowns_Settings.buttonscale
		debuffwidth = (CooldownsTableCooldown1BarButton:GetWidth() * Cooldowns_Settings.buttonscale) + 20
	end
	local d = Cooldowns_Settings.debufflayout
	if d == "up" or d == "down" then -- wider than they are tall
		if Cooldowns_Settings.format == "icons" then
			maxwidth = debuffwidth + timerwidth + 5
			maxheight = math.max(debuffheight,timerheight)
			otherwidth = debuffwidth + timerwidth + 5
			otherheight = debuffheight
		else
			maxwidth = debuffwidth
			maxheight = debuffheight
			otherwidth = debuffwidth
			otherheight = debuffheight
		end
	else --taller than they are wide
		if Cooldowns_Settings.format == "icons" then
			maxwidth = math.max(debuffwidth,timerwidth)
			maxheight = debuffheight + timerheight + 5
			otherwidth = debuffwidth
			otherheight = debuffheight + timerheight + 5
		else
			maxwidth = debuffwidth
			maxheight = debuffheight
			otherwidth = debuffwidth
			otherheight = debuffheight
		end
	end
	CooldownsTable:SetWidth(maxwidth)
	CooldownsTable:SetHeight(maxheight)
	for i = 1,20 do
		getglobal("CooldownsTableCooldown"..i):SetWidth(maxwidth)
		getglobal("CooldownsTableCooldown"..i):SetHeight(maxheight)
		local frame
		if DoTimer_Settings.format == "icons" then
			frame = getglobal("CooldownsTableCooldown"..i.."Icon")
		else
			frame = getglobal("CooldownsTableCooldown"..i.."Bar")
		end
		frame:SetWidth(otherwidth)
		frame:SetHeight(otherheight)
	end
end 

function Cooldowns_DefineInterface(debuffsetup,startup) --the controller behind the 16 different interface layouts
	local olddebuffsetup = Cooldowns_Settings.debufflayout
	Cooldowns_Settings.debufflayout = debuffsetup
	local ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9
	local num1,num2,num3,num4,num5,num6,num7,num8
	--ref1/2: name string to target frame: the name is anchored by (1) to the target's (2)
	--ref3/4: time string to debuff texture: the timer is anchored by (3) to the texture's (4)
	--ref5/6 the anchor corner/its opposite: the 1st target is anchored by (5) to the drag icon's (6)
	--ref7/8: anchors for the debuffs: the next debuff is anchored by its (8) to the previous's (7) (reversed order than usual)
	--ref9: anchor for the 1st debuff; it is connected by its (9) to the target frame's (9)
	--num1/2: dist. between name string and target: you go left (1) and up (2) to go from target to name
	--num3/4: dist. between time string and texture: you go left (3) and up (4) to go from texture to timer
	--num5/6: dist. between debuffs: you go left (5) and up (6) to go from one debuff to the next
	--num7/8: from main frame to 1st target, for a bit of room: you go left (7) and up (8) to go from main frame to 1st target
	if debuffsetup == "left" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9 = "LEFT","RIGHT","TOP","BOTTOM","TOPRIGHT","BOTTOMLEFT","LEFT","RIGHT","TOPRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8 = 5,0,0,-5,-5,0,-5,-5
	elseif debuffsetup == "up" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9 = "TOP","BOTTOM","LEFT","RIGHT","BOTTOMRIGHT","TOPLEFT","TOP","BOTTOM","BOTTOMRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8 = 0,-5,5,0,0,5,-5,5
	elseif debuffsetup == "right" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9 = "RIGHT","LEFT","TOP","BOTTOM","TOPLEFT","BOTTOMRIGHT","RIGHT","LEFT","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8 = -5,0,0,-5,5,0,5,-5
	elseif debuffsetup == "down" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9 = "BOTTOM","TOP","LEFT","RIGHT","TOPLEFT","BOTTOMRIGHT","BOTTOM","TOP","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8 = 0,5,5,0,0,-5,5,-5
	else
		Cooldowns_AddText("Failure to change interface design! No changes made.")
		Cooldowns_Settings.debufflayout = olddebuffsetup
	end
	if (not (Cooldowns_Settings.debufflayout == olddebuffsetup)) or (startup) then 
		getglobal("CooldownsTable"):ClearAllPoints()
		getglobal("CooldownsTableName"):ClearAllPoints()
		getglobal("CooldownsTableName"):SetPoint(ref1,"CooldownsTableCooldown1",ref2,num1,num2)
		for i = 1,20 do
			getglobal("CooldownsTableCooldown"..i):ClearAllPoints()
			getglobal("CooldownsTableCooldown"..i.."IconTime"):ClearAllPoints()
			getglobal("CooldownsTableCooldown"..i.."IconTime"):SetPoint(ref3,"CooldownsTableCooldown"..i.."IconButton",ref4,num3,num4)
		end
		getglobal("CooldownsTableCooldown1"):SetPoint(ref9,"CooldownsTable",ref9)
		for i = 2,20 do
			getglobal("CooldownsTableCooldown"..i):SetPoint(ref8,"CooldownsTableCooldown"..(i-1),ref7,num5,num6)
		end
		getglobal("CooldownsTable"):SetPoint(ref5,"CooldownsMainFrame",ref6,num7,num8)
		DoTimer_ResizeInterface() 
	end
end

function Cooldowns_CreateInterface(external,frommenu)
	local time = GetTime()
	if table.getn(casted) == 0 then CooldownsFrame:SetScript("OnUpdate",nil) end
	if table.getn(casted) == 1 then CooldownsFrame:SetScript("OnUpdate",function() Cooldowns_OnUpdate() end) end
	if Cooldowns_Settings.dotimer then
		local dotimer_casted = DoTimer_ReturnData()
		local cooldownsindex = DoTimer_ReturnTargetTable("Cooldowns ",0,0,0)
		if cooldownsindex then table.remove(dotimer_casted,cooldownsindex) end
		for i = 1,table.getn(cooldownstable) do table.remove(cooldownstable,1) end
		for i = 1,table.getn(casted) do
			table.insert(cooldownstable,casted[i])
		end
		if table.getn(cooldownstable) > 0 then
			table.insert(dotimer_casted,cooldownstable)
			DoTimer_CreateInterface(1)
		end
	else	
		if table.getn(casted) > 0 then
			Cooldowns_SortTimers()
			CooldownsTable:Show()
			if Cooldowns_Settings.names then --set the target name if you have them on, else hide it
				getglobal("CooldownsTableName"):Show()
				getglobal("CooldownsTableNameText"):SetText("Cooldowns")
				getglobal("CooldownsTableName"):SetHeight(getglobal("CooldownsTableNameText"):GetHeight())
				getglobal("CooldownsTableName"):SetWidth(getglobal("CooldownsTableNameText"):GetWidth())
			else
				getglobal("CooldownsTableName"):Hide()
			end
			for i = 1,table.getn(casted) do --for each debuff on the target
				local cooldownframe = getglobal("CooldownsTableCooldown"..i)
				if frommenu or not (cooldownframe.data and cooldownframe.data == casted[i]) then
					cooldownframe.data = casted[i]
					local type = casted[i].type
					if Cooldowns_Settings.format == "icons" then
						getglobal("CooldownsTableCooldown"..i):Show()
						getglobal("CooldownsTableCooldown"..i.."IconButton").spell = casted[i].spell
						getglobal("CooldownsTableCooldown"..i.."IconButton").rank = casted[i].rank
						getglobal("CooldownsTableCooldown"..i.."IconButton"):UnlockHighlight()
						getglobal("CooldownsTableCooldown"..i.."IconButtonTexture"):SetTexture(casted[i].texture) --setting the icon
						local remaining = casted[i].duration - time + casted[i].time
						getglobal("CooldownsTableCooldown"..i.."IconTime"):SetText(Cooldowns_ReturnNewDuration(remaining)) --setting the time remaining
						local displayed = casted[i].displayed
						if displayed and (displayed == 5 or displayed == 4) and Cooldowns_Settings.expalert then getglobal("CooldownsTableCooldown"..i.."IconButton"):LockHighlight() end
						local color
						local half = casted[i].duration / 2						
						if remaining <= 5 then
							color = timerdata[type].colors.final
						elseif remaining <= half then
							color = timerdata[type].colors.half
						else
							color = timerdata[type].colors.begin
						end
						getglobal("CooldownsTableCooldown"..i.."IconTime"):SetTextColor(color.r,color.g,color.b) --setting the color of the time remaining
					else
						getglobal("CooldownsTableCooldown"..i):Show()
						getglobal("CooldownsTableCooldown"..i.."BarButton").spell = casted[i].spell
						getglobal("CooldownsTableCooldown"..i.."BarButton").rank = casted[i].rank
						getglobal("CooldownsTableCooldown"..i.."BarButtonTexture"):SetTexture(casted[i].texture) --setting the icon
						local remaining = casted[i].duration - time + casted[i].time
						getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetMinMaxValues(0,casted[i].duration)
						getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetValue(remaining)
						getglobal("CooldownsTableCooldown"..i.."BarStatusTime"):SetText(Cooldowns_ReturnNewDuration(remaining).." - "..casted[i].spell) --setting the time remaining
						local color
						local half = casted[i].duration / 2
						if remaining <= 5 then
							color = timerdata[type].colors.final
						elseif remaining <= half then
							color = timerdata[type].colors.half
						else
							color = timerdata[type].colors.begin	
						end
						getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetStatusBarColor(color.r,color.g,color.b) --setting the color of the time remaining
					end
				end
			end
		else
			CooldownsTable:Hide()
		end
		for i = table.getn(casted) + 1,20 do
			local cooldownframe = getglobal("CooldownsTableCooldown"..i)
			cooldownframe:Hide() --hiding unused targets
			cooldownframe.data = nil
		end
	end
end

function Cooldowns_SortTimers() --separated the timers by their type then arranges by time added or time remaining
	local regtimers = {} --the 5 different types that timers can be, and a table to catch all blank timers
	local othertimers = {}
	local total = table.getn(casted)
	for i = total,1,-1 do --sorting into correct table
		local intable
		if casted[i].type == "cooldown" then intable = regtimers
		else intable = othertimers
		end
		table.insert(intable,casted[i])
		table.remove(casted,i)
	end
	local time = GetTime()
	local tables = {regtimers,othertimers}
	for index,value in tables do
		if Cooldowns_Settings.sortmethod == "remaining" then --sorting the temp tables by time added or time remaining
			local time = GetTime()
			table.sort(value,function(a,b) return (a.duration - time + a.time) < (b.duration - time + b.time) end)
		else
			table.sort(value,function(a,b) return (a.time) < (b.time) end)
		end
	end
	for i = 1,table.getn(regtimers) do table.insert(casted,regtimers[i]) end
	for i = 1,table.getn(othertimers) do table.insert(casted,othertimers[i]) end
end

function Cooldowns_Commands(msg,fromgui) --governs the /command
	if msg == "" then CooldownsMenuFrame:Show() return
	elseif msg == "on" then 
		Cooldowns_Settings.status = "on"
		Cooldowns_AddMenuText("Cooldowns by Asheyla now activated!",fromgui)
		CooldownsFrame:SetScript("OnEvent",function() Cooldowns_OnEvent(event) end)
		CooldownsFrame:SetScript("OnUpdate",function() Cooldowns_OnUpdate() end)
		CooldownsMainFrame:Show()	
	elseif msg == "off" then
		Cooldowns_Settings.status = "off"
		Cooldowns_AddMenuText("Cooldowns by Asheyla is now deactivated.",fromgui)
		CooldownsFrame:SetScript("OnEvent",nil)
		CooldownsFrame:SetScript("OnUpdate",nil)
		CooldownsMainFrame:Hide()
	elseif msg == "reset" then
		Cooldowns_Settings = {}
		Cooldowns_Startup()
		CooldownsAnchorFrame:ClearAllPoints()
		CooldownsAnchorFrame:SetPoint("CENTER","UIParent","CENTER")
		Cooldowns_AddMenuText("All user data is now reset.",fromgui)
	elseif msg == "set format bars" then
		Cooldowns_Settings.format = "bars"
		Cooldowns_DefineFormat()
		Cooldowns_AddMenuText("Timers will now be displayed as bars.",fromgui)
	elseif msg == "set format icons" then
		Cooldowns_Settings.format = "icons"
		Cooldowns_DefineFormat()
		Cooldowns_AddMenuText("Timers will now be displayed as icons.",fromgui)		
	elseif msg == "reset position" then
		CooldownsAnchorFrame:ClearAllPoints()
		CooldownsAnchorFrame:SetPoint("CENTER","UIParent","CENTER")
		Cooldowns_AddMenuText("The position of the UI is now reset.",fromgui)		
	elseif msg == "play sounds" then
		Cooldowns_Settings.playsound = true
		Cooldowns_AddMenuText("A sound will be played at 5 seconds.",fromgui)
	elseif msg == "do not play sounds" then
		Cooldowns_Settings.playsound = false
		Cooldowns_AddMenuText("No sounds will be played.",fromgui)
	elseif msg == "header off" then
		Cooldowns_Settings.names = false
		Cooldowns_AddMenuText("The header will not be shown.",fromgui)
		Cooldowns_ResizeInterface()
	elseif msg == "header on" then
		Cooldowns_Settings.names = true
		Cooldowns_AddMenuText("The header will  be shown.",fromgui)
		Cooldowns_ResizeInterface()
	elseif msg == "lock" then
		Cooldowns_Settings.locked = true
		CooldownsAnchorFrame:Hide()
		Cooldowns_AddMenuText("The timers are now locked in place.",fromgui)
	elseif msg == "unlock" then
		Cooldowns_Settings.locked = false
		CooldownsAnchorFrame:Show()
		Cooldowns_AddMenuText("The timers can now be moved by dragging the little button around.",fromgui)
	elseif msg == "sort by remaining" then
		Cooldowns_AddMenuText("Timers will now be ordered by their time remaining.",fromgui)
		Cooldowns_Settings.sortmethod = "remaining"
	elseif msg == "sort by added" then
		Cooldowns_AddMenuText("Timers will now be ordered by when they were cast. ",fromgui)
		Cooldowns_Settings.sortmethod = "added"
	elseif msg == "clickable cooldowns" then
		Cooldowns_Settings.clickable = true
		for i = 1,20 do
			getglobal("CooldownsTableCooldown"..i.."IconButton"):EnableMouse(true)
			getglobal("CooldownsTableCooldown"..i.."BarButton"):EnableMouse(true)
		end
		Cooldowns_AddMenuText("The timers can now be clicked to remove them.",fromgui)
	elseif msg == "unclickable cooldowns" then
		Cooldowns_Settings.clickable = false
		Cooldowns_AddMenuText("The timers can no longer be clicked.",fromgui)
		for i = 1,20 do
			getglobal("CooldownsTableCooldown"..i.."IconButton"):EnableMouse(false)
			getglobal("CooldownsTableCooldown"..i.."BarButton"):EnableMouse(false)
		end
	elseif msg == "integrate" then
		Cooldowns_Settings.dotimer = true
		Cooldowns_AddMenuText("The cooldowns will be displayed in DoTimer's tables.",fromgui)
		CooldownsTable:Hide()
	elseif msg == "separate" then
		Cooldowns_Settings.dotimer = false
		Cooldowns_AddMenuText("The cooldowns will be displayed separate from DoTimer's tables.",fromgui)
		local dotimer_casted = DoTimer_ReturnData()
		local targetindex = DoTimer_ReturnTargetTable("Cooldowns ",0,0,0)
		if targetindex then 
			table.remove(dotimer_casted,targetindex)
			DoTimer_CreateInterface(1)
		end
	elseif msg == "no expire alert" then
		Cooldowns_Settings.expalert = false
		Cooldowns_AddMenuText("The timers will not change color or highlight.",fromgui)
	elseif msg == "expire alert" then
		Cooldowns_Settings.expalert = true
		Cooldowns_AddMenuText("The timers will change to red and highlight at 5 seconds.",fromgui)
	elseif msg == "show blocked" then
		Cooldowns_AddText("Blocked timers:")
		for index,value in Cooldowns_Settings.blocked do Cooldowns_AddText(index) end
	elseif msg == "status" then
		Cooldowns_AddText("|cff00ffffCooldowns Status:|r")
		Cooldowns_AddText("Status of addon: |cff00ff00"..tostring(Cooldowns_Settings.status).."|r")
		Cooldowns_AddText("UI scale: |cff00ff00"..tostring(Cooldowns_Settings.scale).."|r")
		Cooldowns_AddText("showing names: |cff00ff00"..tostring(Cooldowns_Settings.names).."|r")
		Cooldowns_AddText("max cooldowns: |cff00ff00"..tostring(Cooldowns_Settings.maxdebuffs).."|r")
		Cooldowns_AddText("locked timers in place: |cff00ff00"..tostring(Cooldowns_Settings.locked).."|r")
		Cooldowns_AddText("timer addition direction: |cff00ff00"..tostring(Cooldowns_Settings.debufflayout).."|r")
		Cooldowns_AddText("timers sort method: |cff00ff00"..tostring(Cooldowns_Settings.sortmethod).."|r")
		Cooldowns_AddText("clickable timers: |cff00ff00"..tostring(Cooldowns_Settings.clickable).."|r")
		Cooldowns_AddText("button scale: |cff00ff00"..tostring(Cooldowns_Settings.buttonscale).."|r")
		Cooldowns_AddText("changing color of timers: |cff00ff00"..tostring(Cooldowns_Settings.expalert).."|r")
		Cooldowns_AddText("playing sounds: |cff00ff00"..tostring(Cooldowns_Settings.playsound).."|r")
		Cooldowns_AddText("timer format: |cff00ff00"..tostring(Cooldowns_Settings.format).."|r")
		Cooldowns_AddText("bar length: |cff00ff00"..tostring(Cooldowns_Settings.barlength).."|r")
		Cooldowns_AddText("integrating into DoTimer: |cff00ff00"..tostring(Cooldowns_Settings.dotimer).."|r")
	elseif string.sub(msg,1,6) == "block " then
		local spell = string.lower(string.sub(msg,7))
		Cooldowns_Settings.blocked[spell] = 1
		Cooldowns_AddMenuText(spell.." will not be shown as a timer.",fromgui)
	elseif string.sub(msg,1,8) == "unblock " then
		local spell = string.lower(string.sub(msg,9))
		Cooldowns_Settings.blocked[spell] = nil
		Cooldowns_AddMenuText(spell.." will be shown again as a timer.",fromgui)
	elseif string.sub(msg,1,11) == "set layout " then
		local debufflayout = SpellSystem_ParseString(msg,"(%a+)",-1)
		Cooldowns_AddMenuText("Cooldowns will be added "..(debufflayout or "<cannot parse!>")..".",fromgui)
		Cooldowns_DefineInterface(debufflayout)
	elseif string.sub(msg,1,5) == "scale" then
		local scale = string.sub(msg,7)
		if type(tonumber(scale)) == "number" then
			scale = tonumber(string.format("%.2f",scale))
			CooldownsMainFrame:SetScale(scale)
			Cooldowns_Settings.scale = scale
			Cooldowns_AddMenuText("New scale: "..scale,fromgui)
			Cooldowns_ResizeInterface()
		end
	elseif string.sub(msg,1,11) == "bar length " then
		local number = tonumber(string.sub(msg,12))
		if type(number) == "number" and number >= 50 and number <= 250 then
			Cooldowns_Settings.barlength = number
			Cooldowns_DefineFormat()
			Cooldowns_AddMenuText("Timer bars will now have length "..number,fromgui)
		end
	elseif string.sub(msg,1,12) == "max cooldowns " then
		local number = tonumber(string.sub(msg,13))
		if type(number) == "number" and number > 0 and number < 21 then
			Cooldowns_Settings.maxdebuffs = number
			Cooldowns_AddMenuText("Max number of cooldowns is now "..number,fromgui)
		end
	elseif string.sub(msg,1,13) == "button scale " then
		local scale = string.sub(msg,14)
		if type(tonumber(scale)) == "number" then 
			scale = tonumber(string.format("%.2f",scale))
			Cooldowns_Settings.buttonscale = scale
			Cooldowns_AddMenuText("The new button scale is now "..scale,fromgui)
			for i = 1,10 do
				getglobal("CooldownsTableCooldown"..i.."BarButton"):SetScale(Cooldowns_Settings.buttonscale)
				getglobal("CooldownsTableCooldown"..i.."BarStatus"):SetScale(Cooldowns_Settings.buttonscale)
				getglobal("CooldownsTableCooldown"..i.."BarBackground"):SetScale(Cooldowns_Settings.buttonscale)
				getglobal("CooldownsTableCooldown"..i.."IconButton"):SetScale(Cooldowns_Settings.buttonscale)
			end
		end	
	elseif string.sub(msg,1,4) == "help" then Cooldowns_AddHelpMenu(msg)
	else
		Cooldowns_AddMenuText("Type |cff00ff00/cooldowns help|r for more options, or |cff00ff00/cooldowns|r to open the menu!",fromgui)
	end
	if not fromgui then Cooldowns_CreateInterface(1,1) end
end

function Cooldowns_ReturnData()
	return casted
end

function Cooldowns_CreateTimerGroup(name,colors)
	timerdata[name] = {
		colors = colors
	}
end
