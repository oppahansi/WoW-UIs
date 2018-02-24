------------------------------------------------------------------------------------------------------------
-- ################### DATA ####################### --
------------------------------------------------------------------------------------------------------------

DoTimer_DebugChannel = nil --for debugging purposes
local Old_CSBN,Old_CS,Old_UA,preventingimmol,hasoffensive,hasdefensive --random variables i use
local lasttarget = {} --a table holding data for my last target
local casted = {} --governs the currently casted debuffs.  entries are 1-10 targets, which in turn are 1-20 debuffs and the target name
local finalspell = {} --a final table for a spell.  created when the debuff most likely lands on the target, lasts until the icon for that debuff appears
local castpetspell = {} --the table for pet spellcasts
local sentpetspell = {} --table for pet spells, to catch resists/whatever
local finalpetspell = {} --another for pet spells, to await the icon
local finalenslavespell = {} --table for player spells, where we wait for the icon of the debuff
local debuffs = {} --table for the buffs/debuffs for querying, so a new table is not created each time
local buffs = {} -- same except for buffs
local timerdata = {} --keeps information about how the different timers should be drawns on the screen
local unitids --used for scanning buffs
local petresistmsg = string.gsub(SPELLRESISTOTHEROTHER,"%%.-s","(.+)") --the chat message sent when a pet spell is resisted
local petevademsg = string.gsub(SPELLEVADEDOTHEROTHER,"%%.-s","(.+)") --the chat message sent when a pet spell is evaded
local petimmunemsg = string.gsub(SPELLIMMUNEOTHEROTHER,"%%.-s","(.+)") --the chat message sent when something is immune to pet's spell
local petreflectmsg = string.gsub(SPELLREFLECTOTHEROTHER,"%%.-s","(.+)") --the chat message sent when your pet's spell is reflected back to your pet
local spellhitmsg = string.gsub(string.gsub(SPELLLOGSCHOOLSELFOTHER,"%%.-d","%%d+"),"%%.-s","(.+)") --the chat message sent when your spell hits for some amount
local spellcritmsg = string.gsub(string.gsub(SPELLLOGCRITSCHOOLSELFOTHER,"%%d","%%d+"),"%%.-s","(.+)") --same but for crits
local diesmsg = string.gsub(UNITDIESOTHER,"%%.-s","(.+)") --the chat message sent when something dies
local fadesmsg = string.gsub(AURAREMOVEDOTHER,"%%.-s","(.+)") --the chat message sent when a debuff fades from something
local begincastmsg = string.gsub(SPELLCASTOTHERSTART,"%%.-s","(.+)") --in the pet msg for your pet beginning to cast a spell (seduction)
local slainmsg = string.gsub(SELFKILLOTHER,"%%.-s","(.+)") --when you had the killing blow for a death
local spells,petspells,healspells,enslavespells,notargetspells,localedata --spells are offensive duration spells, petspells are pet duration spells,  healspells are friendly duration spells, and enslavespells are enslaving demon spells, protect spells are ones not filtered by onupdates
local protectspells = { --spells that my onupdate functions never remove, since an icon is not created for them (or the icon mismatches the casted spell)
	["Spell Lock"] = 1,
	["Power Word: Shield"] = 1,
	["Counterspell"] = 1,
	["Pummel"] = 1,
	["Shield Bash"] = 1,
	["Kick"] = 1,
	["Judgement"] = 1,
	["Earth Shock"] = 1,
}
local uniquespells = { --spells that can only be applied once globally, but lack of cooldown allows spamming
	["Hunter's Mark"] = 1,
	["Fear"] = 1,
}
local uniquebyrank = { --spells which are unique by rank, not by spell
	["Moonfire"] = 1,
}

------------------------------------------------------------------------------------------------------------
-- ################ LOCALIZATION ################### --
------------------------------------------------------------------------------------------------------------

function DoTimer_ReturnEnglish(spellname) --returns the english name of the spell
	local tables = {BOOKTYPE_SPELL,BOOKTYPE_PET}
	local english,texture
	for index,value in ipairs(tables) do
		local i = 1
		while GetSpellName(i,value) do
			local spell = GetSpellName(i,value)
			if spell == spellname then
				texture = GetSpellTexture(i,value)
				break
			end
			i = i + 1
		end
	end
	if texture and localedata[texture] then return localedata[texture].name end
	return "unknown"
end

function DoTimer_ToLocale(spellname) -- returns the localized name of the english spell
	for index,value in pairs(localedata) do
		if value.name == spellname then
			local i = 1
			while GetSpellName(i,BOOKTYPE_SPELL) do
				local texture = GetSpellTexture(i,BOOKTYPE_SPELL)
				if texture == index then
					local spell = GetSpellName(i,BOOKTYPE_SPELL)
					return spell
				end
				i = i + 1
			end
		end
	end
	return "unknown"
end

------------------------------------------------------------------------------------------------------------
-- ############## BASIC FUNCTIONS ################### --
------------------------------------------------------------------------------------------------------------
	
function DoTimer_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	this:RegisterEvent("PLAYER_DEAD")
	this:RegisterEvent("PLAYER_REGEN_ENABLED")
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
	this:RegisterEvent("UNIT_PET")
	SpellSystem_RegisterEvent(this,"SPELLSYSTEM_SUCCESS")
	SpellSystem_RegisterEvent(this,"SPELLSYSTEM_FAILAFTER")
	SpellSystem_RegisterEvent(this,"SPELLSYSTEM_STOP")
	SLASH_DOTIMER1 = "/dotimer" --creating the slash command
	SLASH_DOTIMER2 = "/dot" --and the other one, for those who are lazy
	this.time = 0 --for limiting scanning
	SlashCmdList["DOTIMER"] = DoTimer_Commands
end

function DoTimer_OnEvent(event)
	if event == "VARIABLES_LOADED" then DoTimer_Startup() -- when you first log in
	elseif event == "PLAYER_TARGET_CHANGED" then DoTimer_ChangedTargets() --time to make the last target's timers eligible for depreciation
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then DoTimer_PotentialSpellLock()
	elseif event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then DoTimer_HostileDeath() --deletion of entries based on death: if target died, remove his entries, else: if it was a player, remove entries, else leave alone.  mob entries will be removed on exit combat
	elseif event == "PLAYER_DEAD" then DoTimer_PlayerDeath() --deleting entries because player died
	elseif event == "CHAT_MSG_SPELL_PET_DAMAGE" then DoTimer_PotentialSeduction() --for the succubus auto-casting seduce; it does not go through the normal function
	elseif event == "UNIT_PET" and arg1 == "player" then DoTimer_UpdatePet()
	elseif event == "PLAYER_REGEN_ENABLED" then DoTimer_LeftCombat()--deleting mob tables b/c left combat
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" then DoTimer_DebuffFade() --checking for debuff fades
	elseif event == "SPELLSYSTEM_SUCCESS" then DoTimer_PotentialSpellTimer()
	elseif event == "SPELLSYSTEM_STOP" then DoTimer_PotentialOtherTimer()
	elseif event == "SPELLSYSTEM_FAILAFTER" then DoTimer_CheckConflag(); DoTimer_CheckEnslave()
	end
end

function DoTimer_AddText(msg) --basic output function
	if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage(msg) end
end

function DoTimer_AddMenuText(msg,fromgui) -- will output a msg if the text menu was accessed; not the GUI menu
	if not fromgui then DoTimer_AddText(msg) end
end

function DoTimer_Debug(msg) --makes a debug msg if i have that turned on
	if DoTimer_DebugChannel then
		if DoTimer_DebugChannel ~= "" and getglobal("ChatFrame"..DoTimer_DebugChannel) then getglobal("ChatFrame"..DoTimer_DebugChannel):AddMessage(msg)
		else DoTimer_AddText(msg)
		end
	end
end

function DoTimer_Startup() --called on first login per session, creates the default settings if needed or else just hides the interface and sets the scale
	if not DoTimer_Settings then DoTimer_Settings = {} end
	if DoTimer_Settings.status == nil then
		DoTimer_Settings.status = true
		DoTimerAnchorFrameFirstUse:Show()
		DoTimerAnchorFrameFirstUse:SetText("<-- Welcome to DoTimer!  Please type \"/dotimer help new\" for first-time information.\nSimply drag the drag button to remove this display.")
	end
	local _,class = UnitClass("player")
	spells,petspells,healspells,enslavespells,notargetspells,localedata = DoTimer_DefineSpells(class)
	if DoTimer_Settings.scale == nil then DoTimer_Settings.scale = 1 end --setting the default settings
	if DoTimer_Settings.visible == nil then DoTimer_Settings.visible = true end
	if DoTimer_Settings.names == nil then DoTimer_Settings.names = true end
	if DoTimer_Settings.manacheck == nil then DoTimer_Settings.manacheck = false end
	if DoTimer_Settings.maxtargets == nil then DoTimer_Settings.maxtargets = 5 end
	if DoTimer_Settings.maxdebuffs == nil then DoTimer_Settings.maxdebuffs = 8 end
	if DoTimer_Settings.locked == nil then DoTimer_Settings.locked = false end
	if DoTimer_Settings.targetlayout == nil then DoTimer_Settings.targetlayout = "down" end
	if DoTimer_Settings.debufflayout == nil then DoTimer_Settings.debufflayout = "down" end
	if DoTimer_Settings.sortmethod == nil then DoTimer_Settings.sortmethod = "remaining" end
	if DoTimer_Settings.clickable == nil then DoTimer_Settings.clickable = true end
	if DoTimer_Settings.expalert == nil then DoTimer_Settings.expalert = true end
	if DoTimer_Settings.buttonscale == nil then DoTimer_Settings.buttonscale = 1 end
	if DoTimer_Settings.dep == nil then DoTimer_Settings.dep = true end
	if DoTimer_Settings.probable == nil then DoTimer_Settings.probable = true end
	if DoTimer_Settings.lifetaprank == nil then DoTimer_Settings.lifetaprank = "max" end
	if DoTimer_Settings.allghost == nil then DoTimer_Settings.allghost = false end
	if DoTimer_Settings.sepghost == nil then DoTimer_Settings.sepghost = true end
	if DoTimer_Settings.levels == nil then DoTimer_Settings.levels = true end
	if DoTimer_Settings.onlytarget == nil then DoTimer_Settings.onlytarget = false end
	if DoTimer_Settings.playsound == nil then DoTimer_Settings.playsound = false end
	if DoTimer_Settings.conflag == nil then DoTimer_Settings.conflag = false end
	if DoTimer_Settings.format == nil then DoTimer_Settings.format = "bars" end
	if DoTimer_Settings.barlength == nil then DoTimer_Settings.barlength = 150 end
	if DoTimer_Settings.tbc == nil then DoTimer_Settings.tbc = false end
	if DoTimer_Settings.blocked == nil then DoTimer_Settings.blocked = {} end
	if DoTimer_Settings.preventimmol == nil then DoTimer_Settings.preventimmol = { --the ones i can think of off the top of my head
		["Ragnaros"] = 1,
		["Onyxia"] = 1,
		["Nefarian"] = 1,
		["Ebonroc"] = 1,
		["Flamegor"] = 1,
		["Firemaw"] = 1,
		["Baron Geddon"] = 1,
		["Firelord"] = 1,
	}
	end
	if DoTimer_Settings.visible then DoTimerMainFrame:Show() else DoTimerMainFrame:Hide() end --obeying a couple  settings
	DoTimerMainFrame:SetScale(DoTimer_Settings.scale)
	unitids = DoTimer_ReturnUnitIDs()
	for i = 1,10 do
		getglobal("DoTimerTarget"..i):Hide()
		for id = 1,20 do
			getglobal("DoTimerTarget"..i.."Debuff"..id):Hide()
		end
	end
	DoTimer_DefineFormat()
	if DoTimer_Settings.locked then DoTimerAnchorFrame:Hide() else DoTimerAnchorFrame:Show() end
	if DoTimer_Settings.status == false then DoTimerFrame:SetScript("OnEvent",nil) end
	DoTimer_DefineInterface(DoTimer_Settings.targetlayout,DoTimer_Settings.debufflayout,1)
	if class == "ROGUE" then
		DoTimerRogueFrame:RegisterEvent("PLAYER_COMBO_POINTS")
		DoTimerRogueFrame:SetScript("OnEvent",function()
			local points = GetComboPoints()
			if points == 0 then
				this.maxpoints = this.points
			end
			this.points = points
		end)
	elseif class == "PALADIN" then
		DoTimerPaladinFrame:RegisterEvent("PLAYER_AURAS_CHANGED")
		DoTimerPaladinFrame:SetScript("OnEvent",function()
			DoTimerPaladinFrame.buff = nil
			local i = 1
			local buff = UnitBuff("player",i)
			while buff do
				if localedata[buff].group == 7 then
					DoTimerPaladinFrame.buff = buff
					break
				end
				i = i + 1
				buff = UnitBuff("player",i)
			end
		end)
	end
end

------------------------------------------------------------------------------------------------------------
-- ############ TIMER REMOVAL FUNCTIONS ############## --
------------------------------------------------------------------------------------------------------------

function DoTimer_OnUpdate(elapsed) --updating the timers onscreen, as well as checking for any finished debuffs
	if table.getn(casted) == 0 then DoTimerFrame:SetScript("OnUpdate",nil) end
	local time = GetTime()
	for index = table.getn(casted),1,-1 do --scanning all the debuffs to see if they are done
		for i = table.getn(casted[index]),1,-1 do
			local type = casted[index][i].type
			if timerdata[type].hastimer then
				if time >= casted[index][i].time + casted[index][i].duration then --yep it's done all right
					DoTimer_Debug(casted[index][i].spell.." has expired from the mob; full duration")
					DoTimer_RemoveTimer(index,i,1)
				else
					if DoTimer_Settings.format == "icons" then
						local remaining = tonumber(string.format("%d",math.floor(casted[index][i].duration - time + casted[index][i].time))) --modifying the displayed time if it needs changing
						if (not casted[index][i].displayed) or (remaining < casted[index][i].displayed) then
							getglobal("DoTimerTarget"..index.."Debuff"..i.."IconTime"):SetText(DoTimer_ReturnNewDuration(remaining)) --updating the time if they aren't done
							if remaining == 5 then
								if DoTimer_Settings.playsound then PlaySoundFile("Interface\\Addons\\DoTimer\\Extras\\expalert.wav") end
								if DoTimer_Settings.expalert then
									getglobal("DoTimerTarget"..index.."Debuff"..i.."IconButton"):LockHighlight()
									getglobal("DoTimerTarget"..index.."Debuff"..i.."IconTime"):SetTextColor(timerdata[type].colors.final.r,timerdata[type].colors.final.g,timerdata[type].colors.final.b)
								end
							elseif remaining == 3 then
								if DoTimer_Settings.expalert then getglobal("DoTimerTarget"..index.."Debuff"..i.."IconButton"):UnlockHighlight() end
							elseif (remaining > 5) and (remaining == math.floor(casted[index][i].duration / 2)) then
								getglobal("DoTimerTarget"..index.."Debuff"..i.."IconTime"):SetTextColor(timerdata[type].colors.half.r,timerdata[type].colors.half.g,timerdata[type].colors.half.b)
							end
							casted[index][i].displayed = remaining
						end
					else
						local remaining = casted[index][i].duration - time + casted[index][i].time
						getglobal("DoTimerTarget"..index.."Debuff"..i.."BarStatus"):SetValue(remaining)
						local otherremaining = tonumber(string.format("%d",math.floor(remaining))) --modifying the displayed time if it needs changing
						--if index == 1 and i == 1 then
							--DoTimer_AddText(otherremaining.." is "..(otherremaining < (casted[index][i].displayed or 0) and "" or " not ").."less than "..(casted[index][i].displayed or 0))
						--end
						if (not casted[index][i].displayed) or (otherremaining < casted[index][i].displayed) then
							getglobal("DoTimerTarget"..index.."Debuff"..i.."BarStatusTime"):SetText(DoTimer_ReturnNewDuration(otherremaining).." - "..casted[index][i].spell) --updating the time if they aren't done
							--if index == 1 and i == 1 then DoTimer_AddText(index..": "..i..": "..DoTimer_ReturnNewDuration(otherremaining).." - "..casted[index][i].spell) end
							if otherremaining == 5 then
								if DoTimer_Settings.playsound then PlaySoundFile("Interface\\Addons\\DoTimer\\Extras\\expalert.wav") end
								if DoTimer_Settings.expalert then
									getglobal("DoTimerTarget"..index.."Debuff"..i.."BarStatus"):SetStatusBarColor(timerdata[type].colors.final.r,timerdata[type].colors.final.g,timerdata[type].colors.final.b)
								end
							elseif (otherremaining > 5) and (otherremaining == math.floor(casted[index][i].duration / 2)) then
								getglobal("DoTimerTarget"..index.."Debuff"..i.."BarStatus"):SetStatusBarColor(timerdata[type].colors.half.r,timerdata[type].colors.half.g,timerdata[type].colors.half.b)
							end
							casted[index][i].displayed = otherremaining
						end
					end
				end
			end
		end
	end
	DoTimerFrame.time = DoTimerFrame.time + elapsed
	if DoTimerFrame.time >= .5 then
		if DoTimer_TypeRunning("offensive") then DoTimer_ScanDebuffs(time) end --seeing if anything has faded unexpectedly
		if DoTimer_TypeRunning("defensive") then DoTimer_ScanBuffs(time) end
		DoTimerFrame.time = 0
	end
end

function DoTimer_ScanDebuffs(time) --deletes the timers of spells which are no longer on the target
	local found = DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)
	if found then
		DoTimer_ListDebuffs("target")
		for i = table.getn(casted[found]),1,-1 do
			local spellname = casted[found][i].spell
			local english = casted[found][i].english
			if time >= casted[found][i].time + 2 then --protect them in case they haven't appeared just yet and AwaitIcon didn't catch the pause (since it can only catch it for current target)
				local ontarget
				if DoTimer_intable(spellname,protectspells) or debuffs[spellname] or (not DoTimer_TimerIsAppreciated(found,i)) then ontarget = 1 end--we will not delete spell lock
				if not ontarget then
					local wrongreason -- if a new curse or a refresh, the timer will disappear before the other code adds it.  in this case we want to delete, not depreciate
					for id = table.getn(finalspell),1,-1 do
						if (DoTimer_ReturnTargetTable(finalspell[id].target.target,finalspell[id].target.sex,finalspell[id].target.level,finalspell[id].target.icon) == found) and ((finalspell[id].spell.spell == spellname) or (localedata[casted[found][i].texture].group and localedata[casted[found][i].texture].group == localedata[finalspell[id].spell.texture].group)) then wrongreason = 1 end
					end
					if wrongreason then
						DoTimer_Debug(casted[found][i].spell.." not found on "..UnitName("target")..", but we expected that")
						DoTimer_RemoveTimer(found,i)
					else
						DoTimer_Debug(casted[found][i].spell.." not found on "..UnitName("target").."; depreciating if mob, deleting if not")
						if casted[found].type == "mob" then DoTimer_DepreciateTimer(found,i) else DoTimer_RemoveTimer(found,i,1) end --player timers are removed because they cannot be depreciated
					end
				end
			end
		end
	end
end

function DoTimer_ScanBuffs(time) --checking buffs to see if any friendly spells need to be removed
	for index,value in ipairs(unitids) do
		if UnitExists(value) then
			local found = DoTimer_ReturnTargetTable(UnitName(value),UnitSex(value),UnitLevel(value),GetRaidTargetIndex(value) or 0)
			if found then
				DoTimer_ListBuffs(value)
				for i = table.getn(casted[found]),1,-1 do
					if GetTime() >= casted[found][i].time + 2 then
						local spellname = casted[found][i].spell
						local ontarget
						if DoTimer_intable(spellname,protectspells) or buffs[spellname] or (not (casted[found][i].type == "heal")) then ontarget = 1 end --we will not delete PWF
						if not ontarget then
							DoTimer_Debug(casted[found][i].spell.." not found on target, removing it")
							DoTimer_RemoveTimer(found,i,1)
						end
					end
				end
			end
		end
	end
end

function DoTimer_TypeRunning(qtype)
	if qtype == "offensive" then
		return hasoffensive
	elseif qtype == "defensive" then
		return hasdefensive
	end
end

function DoTimer_DepreciateTimer(found,i) --depreciated the timer if the target is eligible
	--if casted[found].eligible then DoTimer_AddText("The timers for "..casted[found].target.." are eligible for depreciation.") else DoTimer_AddText("The timers for "..casted[found].target.." are not eligible for depreciation.") end
	if DoTimer_Settings.dep and (casted[found].eligible) and ((casted[found][i].displayed or 2) > 1) then
		casted[found][i].type = "depreciated"
		casted[found][i].depstart = GetTime()
		casted[found][i].index = nil
		if DoTimer_Settings.allghost then DoTimer_CreateGhostTimer(found,i) end
		DoTimer_CreateInterface()
	else
		DoTimer_RemoveTimer(found,i,1)
	end
end

function DoTimer_CheckConflag()
	if DoTimer_ReturnEnglish(arg1.spell) == "Conflagrate" then
		local found = DoTimer_ReturnTargetTable(arg2.name,arg2.sex,arg2.level,arg2.icon)
		if found then
			local removed
			for i = table.getn(casted[found]),1,-1 do --checking that target for immolate
				if DoTimer_ReturnEnglish(casted[found][i].spell) == "Immolate" and DoTimer_TimerIsAppreciated(found,i) then
					DoTimer_Debug(casted[found].target.." had an appreciated immol, removed it")
					DoTimer_RemoveTimer(found,i,1)
					removed = 1
					break
				end
			end
			if not removed then
				local id,cast
				for i = table.getn(casted[found]),1,-1 do
					if DoTimer_ReturnEnglish(casted[found][i].spell) == "Immolate" and (casted[found][i].type == "depreciated") then
						if casted[found][i].depstart >= (cast or 0) then
							cast = casted[found][i].depstart
							id = i
						end
					end
				end
				if id then
					DoTimer_Debug(casted[found].target.." had a depreciated immol, removed it")
					DoTimer_RemoveTimer(found,id,1)
				end
			end
		end
	end
end

function DoTimer_CheckEnslave()
	local name = DoTimer_ReturnEnglish(arg1.spell)
	if name == "Enslave Demon" or name == "Inferno" then
		if table.getn(finalenslavespell) > 0 then
			DoTimer_Debug("removing enslave demon potential; failed after")
			table.remove(finalenslavespell,table.getn(finalenslavespell))
		end
	end
end

function DoTimer_ChangedTargets()
	local newtarget
	if UnitName("target") then newtarget = {UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0} end
	--DoTimer_AddText("flag1") --flag
	--DoTimer_AddText(newtarget)
	--DoTimer_AddText(lasttarget)
	for i = 1,table.getn(casted) do
		if casted[i].type == "mob" then casted[i].eligible = 1 end --all mob tables are now eligible for depreciated timers
	end
	local found = DoTimer_ReturnTargetTable(lasttarget[1],lasttarget[2],lasttarget[3],lasttarget[4])
	if newtarget and newtarget[1] == lasttarget[1] and newtarget[2] == lasttarget[2] and newtarget[3] == lasttarget[3] and newtarget[4] == lasttarget[4] then
		DoTimer_Debug("new target identical to old target")
		--DoTimer_AddText("flag2") --flag
		if found then
			--DoTimer_AddText("flag3") --flag
			DoTimer_Debug("depreciating all appreciated timers for "..casted[found].target)
			for i = table.getn(casted[found]),1,-1 do
				if DoTimer_TimerIsAppreciated(found,i) then DoTimer_DepreciateTimer(found,i) end --if we are switching targets to one that is "identical" to the previous, automatically depreciate since we know they are inaccurate
			end
		end
	else
		if DoTimer_Settings.onlytarget then
			DoTimer_Debug("redoing interface to reflect target change")
			DoTimer_CreateInterface()
		end
	end
	if UnitName("target") then lasttarget = {UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0} else lasttarget = {} end
end

function DoTimer_HostileDeath()
	DoTimer_Debug(event)
	DoTimer_Debug(arg1)
	local died = SpellSystem_ParseString(arg1,diesmsg) --checking if the dead mob had any tables
	if not died then
		died = SpellSystem_ParseString(arg1,slainmsg)
	end
	if died == UnitName("target") and UnitIsDead("target") then --your target died, we will delete its entries
		DoTimer_Debug("current target died")
		local found = DoTimer_ReturnTargetTable(died,UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)
		if found then --sure enough, it did!
			DoTimer_Debug("and it had timers; removing appreciated or entire table")
			if casted[found].eligible then
				for i = table.getn(casted[found]),1,-1 do
					if DoTimer_TimerIsAppreciated(found,i) then DoTimer_RemoveTimer(found,i) end
				end
			else
				DoTimer_RemoveTarget(found)
			end
			--DoTimer_AddText(died.." died and its entries were removed.")
		end
		for i = table.getn(finalspell),1,-1 do
			if (DoTimer_ReturnTargetTable(finalspell[i].target.target,finalspell[i].target.sex,finalspell[i].target.level,finalspell[i].target.icon) == found) then table.remove(finalspell,i) end --removing pretimers for that target
		end
	else --will ignore if mob, will delete if player
		DoTimer_Debug("mob died, not current target")
		for i = table.getn(casted),1,-1 do
			if  (casted[i].target == died) and (not (casted[i].type == "mob")) then
				DoTimer_Debug("removing its timers anyway though")
				DoTimer_RemoveTarget(i) --dont bother with appreciated stuff; it has a unique name so it should be removed outright
				break
				--DoTimer_AddText(died.." died and its entries were removed.")
			end
		end
		for i = table.getn(finalspell),1,-1 do
			if (finalspell[i].target.target == died and not (finalspell[i].target.type == "mob")) then table.remove(finalspell,i) end --removing pretimers for that target
		end
	end
end

function DoTimer_PlayerDeath()
	DoTimer_Debug(event)
	DoTimerDeathFrame.time = GetTime()
	DoTimerDeathFrame:SetScript("OnUpdate",function() --we delay the combat check .5 seconds, just to make sure we are really out of combat
		if GetTime() >= this.time + 3 then
			if UnitIsDeadOrGhost("player") then
				DoTimer_Debug("still dead 3 seconds later; removing all timers")
				DoTimer_RemoveAllTimers()
			end
			this:SetScript("OnUpdate",nil)
		end
	end)
end

function DoTimer_LeftCombat()
	DoTimer_Debug("left combat")
	if preventingimmol then
		preventingimmol = nil
		DoTimer_AddText("Immolate will not be prevented anymore.")
	end
	DoTimerCombatFrame.time = GetTime()
	DoTimerCombatFrame:SetScript("OnUpdate",function() --we delay the combat check .5 seconds, just to make sure we are really out of combat
		if GetTime() >= this.time + .5 then
			if not UnitAffectingCombat("player") then
				DoTimer_Debug("still out of combat .5 seconds later; removing all non-enslave, non-player timers")
				for i = table.getn(casted),1,-1 do
					if not (casted[i].type == "player") then DoTimer_RemoveTarget(i) end
				end
				for i = table.getn(casted),1,-1 do --deleting all tables that are only ghost timers when you leave combat
					for id = 1,table.getn(casted[i]) do
						if not (casted[i][id].type == "ghost") then break end
						if id == table.getn(casted[i]) then DoTimer_RemoveTarget(i) end
					end
				end
			end
			this:SetScript("OnUpdate",nil)
		end
	end)
end

function DoTimer_DebuffFade()
	local chatspell,chattarget = SpellSystem_ParseString(arg1,fadesmsg)
	--we will delete the timer if 1) the target is our current target, and 2) there are now no occurrences of the debuff on the target
	if DoTimer_intable(chatspell,spells) then --scan target for debuffs; if no more occurrences then we can delete that timer
		DoTimer_Debug(event)
		if arg1 then DoTimer_Debug(arg1) end
		DoTimer_Debug("the spell that faded is a timer spell")
		if chattarget == UnitName("target") and DoT_OwnSpellOnTarget(chatspell) and not DoT_SpellOnTarget(chatspell) then
			local found = DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)
			if found then
				for i = table.getn(casted[found]),1,-1 do
					if casted[found][i].spell == chatspell and DoTimer_TimerIsAppreciated(found,i) then
						DoTimer_Debug("no more occurrences of the spell, so removing the timer")
						DoTimer_RemoveTimer(found,i,1)
						break
					end
				end
			end
		end
	elseif DoTimer_intable(chatspell,petspells) then --scan pettarget for pet related spells
		DoTimer_Debug(event)
		if arg1 then DoTimer_Debug(arg1) end
		DoTimer_Debug("it was a pet spell")
		if chattarget == UnitName("pettarget") and DoT_OwnSpellOnTarget(chatspell,"pettarget") and not DoT_SpellOnTarget(chatspell,"pettarget") then
			local found = DoTimer_ReturnTargetTable(UnitName("pettarget"),UnitSex("pettarget"),UnitLevel("pettarget"),GetRaidTargetIndex("pettarget") or 0)
			if found then
				for i = table.getn(casted[found]),1,-1 do
					if casted[found][i].spell == chatspell and (not (DoTimer_ReturnEnglish(chatspell) == "Spell Lock")) and DoTimer_TimerIsAppreciated(found,i) then
						DoTimer_Debug("no more occurrences, removing it")
						DoTimer_RemoveTimer(found,i,1)
						break
					end
				end
			end
		end
	end
end

function DoTimer_RemoveTimer(targetindex,debuffindex,unforced) --deletes a timer onscreen from existence
	if unforced then
		DoTimer_Debug("a timer has been removed unforcibly")
		if DoTimer_Settings.allghost and (DoTimer_TimerIsReal(targetindex,debuffindex) or (casted[targetindex][debuffindex].type == "depreciated")) then DoTimer_CreateGhostTimer(targetindex,debuffindex) end
	else
		DoTimer_Debug("a timer has been removed forcibly")
	end
	table.remove(casted[targetindex],debuffindex)
	if table.getn(casted[targetindex]) == 0 then
		table.remove(casted,targetindex)
	end
	DoTimer_CreateInterface()
end

function DoTimer_RemoveTarget(targetindex)
	DoTimer_Debug("a target table has been removed forcibly")
	table.remove(casted,targetindex)
	DoTimer_CreateInterface()
end

function DoTimer_RemoveAllTimers()
	DoTimer_Debug("the interface has been cleared")
	for i = table.getn(casted),1,-1 do
		table.remove(casted,i)
	end
	DoTimer_CreateInterface()
end

function DoTimer_CheckPreTimers() --checks all my queues to see if anything can be weeded out
	for i = table.getn(finalspell),1,-1 do
		if GetTime() >= finalspell[i].spell.time + 3 then
			DoTimer_Debug("removed "..finalspell[i].spell.spell.." from finalspell; took too long")
			table.remove(finalspell,i)
		end
	end
	for i = table.getn(finalpetspell),1,-1 do
		if GetTime() >= finalpetspell[i].spell.time + 3 then
			DoTimer_Debug("removing "..finalpetspell[i].spell.spell.." from finalpetspell; took too long")
			table.remove(finalpetspell,i)
		end
	end
	for i = table.getn(finalenslavespell),1,-1 do
		if GetTime() >= finalenslavespell[i].spell.time + 6 then
			DoTimer_Debug("removing "..finalenslavespell[i].spell.spell.." from finalenslavespell; took too long")
			table.remove(finalenslavespell,i)
		end
	end
	if table.getn(finalspell) + table.getn(finalpetspell) + table.getn(finalenslavespell) == 0 then DoTimerPreTimerFrame:SetScript("OnUpdate",nil) end
end

function DoTimer_CheckPetFailure()
	local spellname,target --looking for all the random things that would cause a failed timer
	spellname,target = SpellSystem_ParseString(arg1,petresistmsg)
	if not (spellname and target) then
		spellname,target = SpellSystem_ParseString(arg1,petevademsg)
	end
	if not (spellname and target) then
		spellname,target = SpellSystem_ParseString(arg1,petimmunemsg)
	end
	if not (spellname and target) then
		spellname,target = SpellSystem_ParseString(arg1,petreflectmsg)
	end
	if spellname and target then
		DoTimer_Debug(event)
		if arg1 then DoTimer_Debug(arg1) end
		for i = table.getn(sentpetspell),1,-1 do --figuring out the last spell cast that matches this data
			if sentpetspell[i].spell.spell == spellname and sentpetspell[i].target.target == target then
				DoTimer_Debug(sentpetspell[i].spell.spell.." was not successfully applied to mob; removing it")
				table.remove(sentpetspell,i)
				if table.getn(sentpetspell) == 0 then DoTimerPetDelayFrame:SetScript("OnUpdate",nil) end
				break
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- ########### GENERAL TIMER FUNCTIONS ############### --
-----------------------------------------------------------------------------------------------------------

function DoTimer_ListDebuffs(unit) --creates a table of all the names of the debuffs on the unit
	for index,value in pairs(debuffs) do value = 0 end
	if not unit then unit = "target" end
	local i = 1
	while UnitDebuff(unit,i) do
		DoTimerScanningFrame:ClearLines()
		DoTimerScanningFrame:SetUnitDebuff(unit,i)
		local spell = DoTimerScanningFrameTextLeft1:GetText()
		if spell then debuffs[spell] = 1 end
		i = i + 1
	end
	for index,value in pairs(debuffs) do if value == 0 then debuffs[index] = nil end end
end

function DoTimer_ListBuffs(unit)
	for index,value in pairs(buffs) do value = 0 end
	if not unit then unit = "target" end
	local i = 1
	while UnitBuff(unit,i) do
		DoTimerScanningFrame:ClearLines()
		DoTimerScanningFrame:SetUnitBuff(unit,i)
		local spell = DoTimerScanningFrameTextLeft1:GetText()
		if spell then buffs[spell] = 1 end
		i = i + 1
	end
	for index,value in pairs(buffs) do if value == 0 then buffs[index] = nil end end
end

function DoTimer_ReturnTargetTable(target,sex,level,icon) --returns the timer table for the corresponding target/sex/level information
	local found
	for i = 1,table.getn(casted) do
		if casted[i].target == target and casted[i].sex == sex and casted[i].level == level and casted[i].icon == icon then found = i end
	end
	return found
end

function DoTimer_ReturnTexture(spell) --returns the texture path for the icon of the spell
	local tables = {BOOKTYPE_SPELL,BOOKTYPE_PET}
	for index,value in ipairs(tables) do
		local i = 1
		while GetSpellName(i,value) do
			local spellname = GetSpellName(i,value)
			if spell == spellname then
				return GetSpellTexture(i,value)
			end
			i = i + 1
		end
	end
	return GetSpellTexture(1,BOOKTYPE_SPELL)
end

function DoTimer_CreateSpellTimer(spelltable) --creates a timer onscreen from nothingness
	--[[
	spelltable = {
		spell = {
			spell = its name
			rank = its rank
			texture = its texture
			type = type,
			duration = duration
		},
		target = {
			target = name,
			sex = sex,
			level = level,
			type = type,
			icon = raid icon
		},
	}
	]]
	if DoTimer_Settings.blocked[string.lower(spelltable.spell.spell)] then return end
	DoTimer_Debug("processing timer for "..spelltable.spell.spell.." on "..spelltable.target.target)
	--DoTimer_AddText(spell.." has been successfully cast on "..target..".")
	spelltable.spell.time = GetTime()
	spelltable.spell.english = DoTimer_ReturnEnglish(spelltable.spell.spell)
	if uniquespells[spelltable.spell.english] then --filtering out spells that can be cast on multiple targets
		for i = table.getn(casted),1,-1 do
			for id = table.getn(casted[i]),1,-1 do
				if casted[i][id].english == spelltable.spell.english then
					table.remove(casted[i],id)
					if table.getn(casted[i]) == 0 then table.remove(casted,i) end
				end
			end
		end
	end
	local found = DoTimer_ReturnTargetTable(spelltable.target.target,spelltable.target.sex,spelltable.target.level,spelltable.target.icon)
	--DEFAULT_CHAT_FRAME:AddMessage("number of tables: "..table.getn(casted))
	if not found then
		DoTimer_Debug("creating new target table")
		if table.getn(casted) == DoTimer_Settings.maxtargets then --deleting tables if over the  limit
			DoTimer_Debug("reached max targets; deleting one")
			table.remove(casted,1)
		end
		table.insert(casted,spelltable.target)
		found = table.getn(casted)
	end
	casted[found].type = spelltable.target.type -- in case it has been changed, like for enslave demon (mob -> player)
	--DEFAULT_CHAT_FRAME:AddMessage("table for this target: "..found)
	--DEFAULT_CHAT_FRAME:AddMessage("number of entries in this table: "..table.getn(casted[found]))
	local spelltype = localedata[spelltable.spell.texture].group
	if not (spelltable.spell.type == "ghost" or spelltable.spell.type == "fake") then
		for i = table.getn(casted[found]),1,-1 do --testing if any other spells need to be deleted: other curses, or other spells w/ same name (as in, user is refreshing a DoT)
			if ((casted[found][i].spell == spelltable.spell.spell and ((not uniquebyrank[spelltable.spell.english]) or casted[found][i].rank == spelltable.spell.rank)) or (spelltype and localedata[casted[found][i].texture].group == spelltype)) and DoTimer_TimerIsReal(found,i) then
				--DEFAULT_CHAT_FRAME:AddMessage(casted[found][i].spell.." has been removed from "..target)
				table.remove(casted[found],i)
				DoTimer_Debug("removing a duplicate timer, or a different curse")
			end
		end
	end
	if table.getn(casted[found]) == DoTimer_Settings.maxdebuffs then --deleting any extra debuffs on target
		DoTimer_Debug("reached max debuffs; deleting one")
		local ofound
		for i = 1,table.getn(casted[found]) do
			if casted[found][i].type == "depreciated" then
				table.remove(casted[found],i)
				ofound = 1
				break
			end
		end
		if not ofound then table.remove(casted[found],1) end
	end
	if spelltable.spell.type == "ghost" or DoTimer_Settings.allghost then
		for i = table.getn(casted[found]),1,-1 do
			if casted[found][i].type == "ghost" and casted[found][i].spell == spelltable.spell.spell then
				if (not DoTimer_Settings.conflag) or (not (DoTimer_ReturnEnglish(spelltable.spell.spell) == "Immolate")) or (not (DoTimer_ReturnEnglish(spelltable.spell.spell) == "Rejuvenation")) or (spelltable.spell.type == "ghost") then
					DoTimer_Debug("removing a ghost timer")
					table.remove(casted[found],i)
				end
			end
		end
	end
	table.insert(casted[found],spelltable.spell) --adding the new debuff entry
	if DoTimer_Settings.conflag and DoTimer_Settings.allghost and (DoTimer_ReturnEnglish(spelltable.spell.spell) == "Immolate" or DoTimer_ReturnEnglish(spelltable.spell.spell) == "Rejuvenation") and (not (spelltable.spell.type == "ghost")) then DoTimer_CreateGhostTimer(found,table.getn(casted[found])) end
	DoTimer_CreateInterface() --draws the interface based on the variable command given, found = table that the debuff is going to
end

function DoTimer_PotentialSpellTimer()
	if DoTimer_intable(arg1.spell,spells) then
		DoTimer_Debug("spell success: "..arg1.spell)
		local spell,target = {},{}
		for index,value in arg1 do spell[index] = value end
		for index,value in arg2 do target[index] = value end
		spell.type = "debuff"
		spell.duration = DoTimer_ReturnDuration(spell.spell,spell.rank)
		spell.time = GetTime()
		local finalspellentry = {
			spell = spell,
			target = target
		}
		table.insert(finalspell,finalspellentry)
		if table.getn(finalspell) == 1 then
			DoTimerPreTimerFrame:SetScript("OnUpdate",function() DoTimer_CheckPreTimers() end)
			DoTimerIconFrame:SetScript("OnUpdate",function() DoTimer_AwaitIcon() end)
		end
	elseif DoTimer_intable(arg1.spell,healspells) then
		DoTimer_Debug("heal success: "..arg1.spell)
		local spell,target = {},{}
		for index,value in arg1 do spell[index] = value end
		for index,value in arg2 do target[index] = value end
		spell.type = "heal"
		spell.duration = DoTimer_ReturnDuration(spell.spell,spell.rank)
		spell.time = GetTime()
		local finishedheal = {
			spell = spell,
			target = target
		}
		DoTimer_CreateSpellTimer(finishedheal)
	elseif DoTimer_intable(arg1.spell,notargetspells) then
		DoTimer_Debug("notarget success: "..arg1.spell)
		local spell,target = {},{}
		for index,value in arg1 do spell[index] = value end
		for index,value in arg2 do target[index] = value end
		spell.type = "debuff"
		spell.duration = DoTimer_ReturnDuration(spell.spell,spell.rank)
		spell.time = GetTime()
		target.target = "No Target"
		target.sex = 0
		target.level = 0
		target.icon = 0
		target.type = "player"
		local finishednotarget = {
			spell = spell,
			target = target,
		}
		DoTimer_CreateSpellTimer(finishednotarget)
	end
	DoTimer_CheckConflag()
end

function DoTimer_PotentialOtherTimer()
	if DoTimer_intable(arg1.spell,enslavespells) then
		DoTimer_Debug("enslave end: "..arg1.spell)
		local spell,target = {},{}
		for index,value in arg1 do spell[index] = value end
		for index,value in arg2 do target[index] = value end
		spell.type = "enslave"
		spell.duration = DoTimer_ReturnDuration(spell.spell,spell.rank)
		spell.time = GetTime()
		local finalenslavespellentry = {
			spell = spell,
		}
		table.insert(finalenslavespell,finalenslavespellentry)
		if table.getn(finalenslavespell) == 1 then DoTimerPreTimerFrame:SetScript("OnUpdate",function() DoTimer_CheckPreTimers() end) end
	end
end

function DoTimer_TimerIsAppreciated(targetindex,debuffindex) --will return true if the debuff is not depreciated, a ghost timer, a simulated timer, or a beneficial timer, or enslave
	--if (not casted[targetindex][debuffindex].dep) and (not casted[targetindex][debuffindex].ghost) and (not casted[targetindex][debuffindex].fake) and (not casted[targetindex][debuffindex].heal) then return true end
	local type = casted[targetindex][debuffindex].type
	if (type == "debuff") then return true end
	return false
end

function DoTimer_TimerIsReal(targetindex,debuffindex) --will return true if not dep. and either a debuff/pet/heal/enslave timer (no ghost or fake or notarget)
	local type = casted[targetindex][debuffindex].type
	if (type == "debuff" or type == "heal" or type == "enslave") then return true end
	return false
end

function DoTimer_intable(query,checkedtable) --checks a spell to see if it needs to be watched (as in, it was in that big spell list at the top)
	return checkedtable[DoTimer_ReturnEnglish(query)] --used to be longer, but code changes made it simpler.  dont feel like replacing it in the code, so it's here to stay
end

function DoTimer_ReturnDuration(spell,rank) --returns the duration of a spell
	local tables = {BOOKTYPE_SPELL,BOOKTYPE_PET}
	for index,value in ipairs(tables) do
		local i = 1
		while GetSpellName(i,value) do
			local spellname,spellrank = GetSpellName(i,value)
			if spellname == spell and ((spellrank == rank) or (rank == "") or (value == BOOKTYPE_PET)) then
				DoTimerScanningFrame:ClearLines()
				DoTimerScanningFrame:SetSpell(i,value)
				local num = DoTimerScanningFrame:NumLines()
				local text = getglobal("DoTimerScanningFrameTextLeft"..num):GetText()
				local allnumbers = {SpellSystem_ParseString(text,"(%d[%d%.]*)")}
				local basenumber = localedata[DoTimer_ReturnTexture(spell)].duration
				if basenumber == 0 then
					local _,class = UnitClass("player")
					if class == "ROGUE" then
						local english = DoTimer_ReturnEnglish(spell)
						if english == "Kidney Shot" then
							return 1 + DoTimerRogueFrame.maxpoints
						elseif english == "Rupture" then
							return 6 + (2 * DoTimerRogueFrame.maxpoints)
						end
					elseif class == "PALADIN" then
						local buff = DoTimerPaladinFrame.buff
						if buff then
							local name = localedata[buff].name
							if name == "Seal of Command" or name == "Seal of Righteousness" then
								return 0
							else								
								if name == "Seal of Light" or name == "Seal of Wisdom" then
									local talents = GetTalentInfo(1,12)
									return 10 + (10 * talents)
								else
									return 10
								end
							end
						else
							return 0
						end
					end
				end
				local multiplier = localedata[DoTimer_ReturnTexture(spell)].multiplier
				if allnumbers[1] == false then allnumbers[1] = basenumber end
				local truenumber
				for index2,value2 in ipairs(allnumbers) do
					if ((not truenumber) or (math.abs(value2 - basenumber) < math.abs(truenumber - basenumber))) then truenumber = value2 end
				end
				return truenumber * multiplier
			end
			i = i + 1
		end
	end
	return 0
end

------------------------------------------------------------------------------------------------------------
-- ################ FUNCTION HOOKS ################# --
------------------------------------------------------------------------------------------------------------

Old_CSBN = CastSpellByName
function DoTimer_CSBN(cspell,onself)
	local spellname,spellrank
	spellrank = SpellSystem_ParseString(cspell,"%((.-)%)",-1)
	if spellrank then
		spellname = string.gsub(cspell,"%("..spellrank.."%)$","")
	else
		spellname = cspell
		spellrank = ""
	end
	local spelltype = SpellSystem_ReturnSpellType(spellname)
	if spellrank == "" then spellrank = DoTimer_ReturnRank(spellname) end
	if (not spelltype) or (not DoTimer_Settings.manacheck) or (DoTimer_EnoughMana(spellname,spellrank)) then Old_CSBN(cspell,onself) end
end
CastSpellByName = DoTimer_CSBN

Old_CS = CastSpell
function DoTimer_CS(cspell,booktype)
	local spellname,spellrank = GetSpellName(cspell,booktype)
	local spelltype
	if not (booktype == BOOKTYPE_PET) then spelltype = true end
	if (not spelltype) or (not DoTimer_Settings.manacheck) or (DoTimer_EnoughMana(spellname,spellrank)) then Old_CS(cspell,booktype) end
end
CastSpell = DoTimer_CS

Old_UA = UseAction
function DoTimer_UA(cspell,cursor,onself)
	local spellname,spellrank = SpellSystem_SetAction(cspell)
	if (GetActionCount(cspell) > 0) or (GetActionText(cspell)) or (not DoTimer_Settings.manacheck) or (DoTimer_EnoughMana(spellname,spellrank)) then Old_UA(cspell,cursor,onself) end
end
UseAction = DoTimer_UA

------------------------------------------------------------------------------------------------------------
-- ############## PLAYER TIMER FUNCTIONS ############## --
------------------------------------------------------------------------------------------------------------

function DoTimer_EnoughMana(spellname,rankname) --detects if you have enough mana for the attempted spell before you actually cast it
	if DoTimer_Settings.tbc then return true end
	if DoTimer_ReturnEnglish(spellname) == "Life Tap" then return true end
	local mana = DoTimer_ReturnManaCost(spellname,rankname)
	if not mana or mana < UnitMana("player") then return true end
	if DoTimer_Settings.lifetaprank == "max" then
		CastSpellByName(DoTimer_ToLocale("Life Tap"))
	else
		local i = 1
		while GetSpellName(i,BOOKTYPE_SPELL) do
			local spell,rank = GetSpellName(i,BOOKTYPE_SPELL)
			local ranknum = SpellSystem_ParseString(rank,"(%d+)")
			if spell == DoTimer_ToLocale("Life Tap") and ranknum == DoTimer_Settings.lifetaprank then
				CastSpell(i,BOOKTYPE_SPELL)
				break
			end
			i = i + 1
		end
	end
	return false
end

function DoTimer_ReturnManaCost(spellname,rankname) --parsing the mana cost of the spell
	local i = 1
	local found
	while GetSpellName(i,BOOKTYPE_SPELL) do
		local spell,rank = GetSpellName(i,BOOKTYPE_SPELL)
		if spell == spellname and ((rank == rankname) or (rankname == "")) then
			found = i
			break
		end
		i = i + 1
	end
	if found then
		--DoTimer_AddText("spell found at "..found)
		DoTimerScanningFrame:ClearLines()
		DoTimerScanningFrame:SetSpell(found,"spell")
		local mana = SpellSystem_ParseString(DoTimerScanningFrameTextLeft2:GetText(),"^(%d+) ")
		--DoTimer_AddText("mana: "..UnitMana("player")..", needed: "..mana)
		return (mana or false)
	else
		--DoTimer_AddText("cant find spell")
		return false
	end
end

function DoTimer_ReturnSpellType(spellname) --determining if the player or pet cast the spell
	local spelltype
	local i = 1
	while GetSpellName(i,BOOKTYPE_SPELL) do
		local spell = GetSpellName(i,BOOKTYPE_SPELL)
		if spell == spellname then
			spelltype = "player"
			break
		end
		i = i + 1
	end
	return spelltype
end

function DoTimer_SetAction(id) --used to parse information about a spell for UseAction
	DoTimerScanningFrame:ClearLines()
	DoTimerScanningFrameTextRight1:SetText("")
	DoTimerScanningFrame:SetAction(id)
	local spellname = DoTimerScanningFrameTextLeft1:GetText()
	local spellrank = (DoTimerScanningFrameTextRight1:GetText() or "")
	return spellname,spellrank
end

function DoTimer_ReturnRank(spell) --called if the spell did not have a rank from CastSpellByName, returns highest rank
	local highrank
	local i = 1
	while GetSpellName(i,BOOKTYPE_SPELL) do
		local spellname,spellrank = GetSpellName(i,BOOKTYPE_SPELL)
		if spellname == spell then highrank = spellrank end
		i = i + 1
	end
	if highrank == nil then highrank = "" end
	return highrank
end

function DoTimer_AwaitIcon() --the final stage for a timer; waiting for your target to actually have the debuff on it
	DoTimer_ListDebuffs()
	for i = table.getn(finalspell),1,-1 do
		local found
		if not (DoTimer_ReturnTargetTable(finalspell[i].target.target,finalspell[i].target.sex,finalspell[i].target.level,finalspell[i].target.icon) == DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)) then
			found = 1
		else
			if debuffs[finalspell[i].spell.spell] then found = 1 end
		end
		if found then
			DoTimer_Debug("creating a timer for "..finalspell[i].spell.spell)
			DoTimer_CreateSpellTimer(finalspell[i])
			table.remove(finalspell,i)
		end
	end
	if table.getn(finalspell) == 0 then DoTimerIconFrame:SetScript("OnUpdate",nil) end
end

------------------------------------------------------------------------------------------------------------
-- ############### PET TIMER FUNCTIONS ############### --
------------------------------------------------------------------------------------------------------------
	
function DoTimer_InitiatePetSpellTimer(spell) --begins the process of making a pet timer onscreen
	local texture,duration,casttime = DoTimer_ReturnPetInfo(spell)
	local unit = "target"
	if UnitExists("pettarget") then unit = "pettarget" end
	if UnitExists(unit) then
		local entry = {
			time = GetTime(),
			casttime = casttime,
			unit = unit,
			spell = {
				spell = spell,
				rank = "",
				time = GetTime(),
				texture = texture,
				duration = duration,
				type = "debuff",
			},
			target = {
				target = UnitName(unit),
				sex = UnitSex(unit),
				type = SpellSystem_ReturnTargetType(unit),
				level = UnitLevel(unit),
				icon = GetRaidTargetIndex(unit) or 0,
			},
		}
		table.insert(castpetspell,entry)
		if table.getn(castpetspell) == 1 then
			DoTimerPetFrame:SetScript("OnUpdate",function() DoTimer_AwaitPetCast() end)
		end
	end
end

function DoTimer_AwaitPetCast()
	--delays the pet timers an amount of time = to casttime, then sends to sentpetspell
	for i = table.getn(castpetspell),1,-1 do
		if (GetTime() >= castpetspell[i].time + castpetspell[i].casttime) then
			DoTimer_Debug("sending "..castpetspell[i].spell.spell.." to sentpetspell")
			castpetspell[i].casttime = .5
			castpetspell[i].time = GetTime()
			table.insert(sentpetspell,castpetspell[i])
			table.remove(castpetspell,i)
			if table.getn(sentpetspell) == 1 then DoTimerPetDelayFrame:SetScript("OnUpdate",function() DoTimer_DelayPetTimer() end) end
			if table.getn(castpetspell) == 0 then DoTimerPetFrame:SetScript("OnUpdate",nil) end
		end
	end
end

function DoTimer_DelayPetTimer()
	--delays the pet timers .5 seconds to wait for resists or whatever, then sends to finalpetspell
	local time = GetTime()
	for i = table.getn(sentpetspell),1,-1 do
		if time >= sentpetspell[i].time + sentpetspell[i].casttime then
			--DoTimer_CreateSpellTimer(SpellSystem_SentSpell[i])
			DoTimer_Debug("passing "..sentpetspell[i].spell.spell.." to finalpetspell")
			sentpetspell[i].spell.time = GetTime()
			if UnitExists("pettarget") and not (sentpetspell[i].unit == "pettarget") then
				sentpetspell[i].target.target = UnitName("pettarget")
				sentpetspell[i].target.sex = UnitSex("pettarget")
				sentpetspell[i].target.type = SpellSystem_ReturnTargetType("pettarget")
				sentpetspell[i].target.level = UnitLevel("pettarget")
				sentpetspell[i].target.icon = GetRaidTargetIndex("pettarget") or 0
			end
			table.insert(finalpetspell,sentpetspell[i])
			if table.getn(finalpetspell) == 1 then
				DoTimerPreTimerFrame:SetScript("OnUpdate",function() DoTimer_CheckPreTimers() end)
				DoTimerPetIconFrame:SetScript("OnUpdate",function() DoTimer_AwaitPetIcon() end)
			end
			table.remove(sentpetspell,i)
			if table.getn(sentpetspell) == 0 then DoTimerPetDelayFrame:SetScript("OnUpdate",nil) end
		end
	end
end

function DoTimer_AwaitPetIcon() --waiting for the icon to appear onits target before creating the timer
	local units = {"pettarget","target"}
	for index,value in ipairs(units) do
		DoTimer_ListDebuffs(value)
		for i = table.getn(finalpetspell),1,-1 do
			if finalpetspell[i].unit == value  then
				local found
				if not (DoTimer_ReturnTargetTable(finalpetspell[i].target.target,finalpetspell[i].target.sex,finalpetspell[i].target.level,finalpetspell[i].target.icon) == DoTimer_ReturnTargetTable(UnitName(value),UnitSex(value),UnitLevel(value),GetRaidTargetIndex(value) or 0)) then
					found = 1
				else
					if debuffs[finalpetspell[i].spell.spell] then found = 1 end
				end
				if found then
					if UnitExists("pet") and finalpetspell[i].target.target then --make sure target data has been set
						DoTimer_Debug("creating a timer for "..finalpetspell[i].spell.spell)
						DoTimer_CreateSpellTimer(finalpetspell[i])
					else
						DoTimer_Debug(finalpetspell[i].spell.spell.." finished, but pet is dead, so cancelling")
					end
					table.remove(finalpetspell,i)
				end
			end
		end
		if table.getn(finalpetspell) == 0 then DoTimerPetIconFrame:SetScript("OnUpdate",nil) end
	end
end

function DoTimer_ReturnPetCastTime(spell)
	local i = 1
	local found
	while GetSpellName(i,BOOKTYPE_PET) do --figuring out which spell it is in spellbook
		local spell,rank = GetSpellName(i,BOOKTYPE_PET)
		if spell == spellname then
			DoTimerScanningFrame:ClearLines() --parsing the cast time
			DoTimerScanningFrame:SetSpell(i,BOOKTYPE_PET)
			local casttime = SpellSystem_ParseString(DoTimerScanningFrameTextLeft3:GetText(),"^(%d[%d%.]*) ")
			return (casttime or 0) --if it couldn't find one, it assumes instant cast
		end
		i = i + 1
	end
	return 0
end

function DoTimer_ReturnPetInfo(spell) ----used to be longer; i used to save the data in tables, but due to the fact that this data sometimes changes and not b/c of talents, im gonna parse it every time
	return DoTimer_ReturnTexture(spell),DoTimer_ReturnDuration(spell),DoTimer_ReturnPetCastTime(spell)
end

function DoTimer_PotentialSpellLock()
	local i = 1
	while GetSpellName(i,BOOKTYPE_PET) do
		local name = GetSpellName(i,BOOKTYPE_PET)
		if DoTimer_ReturnEnglish(name) == "Spell Lock" then
			local start,duration = GetSpellCooldown(i,BOOKTYPE_PET)
			if (duration >= 10) and (math.abs(GetTime() - start) <= .5) then
				DoTimer_Debug(event)
				local unit = UnitExists("pettarget") and "pettarget" or "target"
				if not DoT_OwnSpellOnTarget(name,unit) then
					DoTimer_Debug("Spell Lock was cast; beginning timer")
					DoTimer_InitiatePetSpellTimer(name)
				end
			end
		end
		i = i + 1
	end
end

function DoTimer_PotentialSeduction()
	local person,spellname = SpellSystem_ParseString(arg1,begincastmsg)
	if spellname then
		DoTimer_Debug(event)
		if arg1 then DoTimer_Debug(arg1) end
		if DoTimer_ReturnEnglish(spellname) == "Seduction" then
			DoTimer_Debug("Seduction was cast; beginning a timer for it")
			DoTimer_InitiatePetSpellTimer(spellname)
		end
	end
	DoTimer_CheckPetFailure()
end

function DoTimer_UpdatePet()
	DoTimer_Debug(event)
	if arg1 then DoTimer_Debug(arg1) end
	if UnitExists("pet") then
		DoTimer_Debug("we have a pet")
		if table.getn(finalenslavespell) > 0 then DoTimer_RemoveBadEnslaves() end
		for i = table.getn(finalenslavespell),1,-1 do
			DoTimer_Debug("creating a timer for "..finalenslavespell[i].spell.spell)
			finalenslavespell[i].target = {
				target = UnitName("pet"),
				type = "player",
				level = UnitLevel("pet"),
				sex = UnitSex("pet"),
				icon = GetRaidTargetIndex("pet") or 0,
			}
			DoTimer_CreateSpellTimer(finalenslavespell[i])
			table.remove(finalenslavespell,i)
		end
	else
		DoTimer_Debug("we do not have a pet")
		DoTimer_RemoveBadEnslaves()
	end
end

function DoTimer_RemoveBadEnslaves()
	DoTimer_Debug("removing inaccurate enslave timers")
	for i = table.getn(casted),1,-1 do
		for id = table.getn(casted[i]),1,-1 do
			if casted[i][id].type == "enslave" then
				DoTimer_Debug("removing enslave timer; inaccurate")
				DoTimer_RemoveTimer(i,id,1) --removing all enslave timers whenever pet changes
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------
-- ############### MACRO FUNCTIONS ################# --
------------------------------------------------------------------------------------------------------------

function DoT_IsPSpell(spellname,unit) --the function for macros to test for own debuffs on target
	if DoTimer_Settings.tbc then return end
	unit = unit or "target"
	DoTimer_Debug("DoT_IsPSpell")
	if not UnitName(unit) then return true end -- sigh
	if DoTimer_ReturnEnglish(spellname) == "Immolate" and (DoTimer_Settings.preventimmol[UnitName(unit)] or preventingimmol) then  --prevents immolate on certain mobs
		DoTimer_Debug("immolate prevented")
		return true
	end
	if not DoT_OwnSpellOnTarget(spellname,unit) then
		CastSpellByName(spellname)
		if SpellIsTargeting() then SpellTargetUnit(unit) end
		return false
	end
	return true
end

function DoT_CastGhostSpell(unit) --the function for macros to test for own debuffs on target
	if DoTimer_Settings.tbc then return end
	unit = unit or "target"
	DoTimer_Debug("DoT_CastGhostSpell")
	if not UnitName(unit) then return true end -- sigh
	local found = DoTimer_ReturnTargetTable(UnitName(unit),UnitSex(unit),UnitLevel(unit),GetRaidTargetIndex(unit) or 0)
	if found then
		for i = 1,table.getn(casted[found]) do
			if casted[found][i].type == "ghost" then
				CastSpellByName(casted[found][i].spell.."("..casted[found][i].rank..")")
				return false
			end
		end
	end
	return true
end

function DoT_OwnSpellOnTarget(spellname,unit) --do you have that spell on your target?	
	DoTimer_Debug("DoT_OwnSpellOnTarget")
	unit = unit or "target"
	if DoT_SpellInAir(spellname,unit) or (DoT_TimerOnTarget(spellname,unit) and DoT_SpellIconOnTarget(spellname,unit)) then return true end
	return false
end

function DoT_SpellInAir(spellname,unit) --if the spell is in any of the holding tables (cast, but not applied as a timer yet)
	DoTimer_Debug("DoT_SpellInAir")
	unit = unit or "target"
	local found = DoTimer_ReturnTargetTable(UnitName(unit),UnitSex(unit),UnitLevel(unit),GetRaidTargetIndex(unit) or 0)
	for index,value in {finalspell,castpetspell,sentpetspell,finalpetspell} do
		for i = table.getn(value),1,-1 do
			if value[i].spell.spell == spellname and DoTimer_ReturnTargetTable(value[i].target.target,value[i].target.sex,value[i].target.level,value[i].target.icon) == found then
				DoTimer_Debug(spellname.." was in a pretable")
				return true
			end
		end
	end
	for i = table.getn(finalenslavespell),1,-1 do
		if finalenslavespell[i].spell == spellname then
			DoTimer_Debug(spellname.." was in a pretable")
			return true
		end
	end
	DoTimer_Debug(spellname.." not in any pretables")
	return false
end

function DoT_SpellIconOnTarget(spellname,unit) --if that spell is actually on the target
	DoTimer_Debug("DoT_SpellIconOnTarget")
	unit = unit or "target"
	DoTimer_ListDebuffs(unit)
	if debuffs[spellname] then
		DoTimer_Debug(spellname.." was on target")
		return true
	end
	DoTimer_ListBuffs(unit)
	if buffs[spellname] then
		DoTimer_Debug(spellname.." was on target")
		return true
	end	
	DoTimer_Debug(spellname.." not found on target")
	return false
end

function DoT_TimerOnTarget(spellname,unit) --if we currently have a timer for that spell on that unit
	DoTimer_Debug("DoT_TimerOnTarget")
	unit = unit or "target"
	local found = DoTimer_ReturnTargetTable(UnitName(unit),UnitSex(unit),UnitLevel(unit),GetRaidTargetIndex(unit) or 0)
	if not found then --there wasn't one
		--DEFAULT_CHAT_FRAME:AddMessage("No debuffs on "..UnitName("target"))
		DoTimer_Debug(spellname.." had no timer table")
		return false
	end
	for i = 1,table.getn(casted[found]) do --oh there was one! is that debuff in the debuff table for that target?
		if casted[found][i].spell == spellname and (DoTimer_TimerIsReal(found,i) or (DoTimer_Settings.probable and casted[found][i].type == "depreciated")) then --only want real debuffs or heal timers (not ghost or depreciated or fake), but includes dep. if probable setting is on
			--DEFAULT_CHAT_FRAME:AddMessage(spellname.." found on "..UnitName("target"))
			DoTimer_Debug(spellname.." had an associated timer in target's table")
			return found,i  --seems as though it was
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage("There were debuffs on "..UnitName("target")..", but not "..spellname)
	DoTimer_Debug(spellname.." was not one of the timers on the target")
	return false
end

function DoT_ReturnElapsed(spellname,unit) --returns how long ago spell was cast on unit
	DoTimer_Debug("DoT_ReturnElapsed")
	unit = unit or "target"
	local found,i = DoT_TimerOnTarget(spellname,unit)
	if found and i then return GetTime() - casted[found][i].time end --seems as though it was, return how many seconds ago it was cast
	return 0 --there were debuffs, but not that spell
end

function DoT_ReturnRemaining(spellname,unit) --returns how much time a spell has left on unit
	DoTimer_Debug("DoT_ReturnRemaining")
	unit = unit or "target"
	local found,i = DoT_TimerOnTarget(spellname,unit)
	if found and i then return casted[found][i].duration - GetTime() + casted[found][i].time end --seems as though it was, return how many seconds it has left
	return DoTimer_ReturnDuration(spellname,DoTimer_ReturnRank(spellname))  --there were debuffs, but not that spell
end

function DoT_IsSpell(spellname,unit) --the function for macros to test for any occurences of debuffs on target
	if DoTimer_Settings.tbc then return end
	unit = unit or "target"
	DoTimer_Debug("DoT_IsSpell")
	if not UnitName(unit) then return true end -- sigh
	if DoTimer_ReturnEnglish(spellname) == "Immolate" and (DoTimer_Settings.preventimmol[UnitName(unit)] or preventingimmol) then  --prevents immolate on certain mobs
		DoTimer_Debug("immolate prevented")
		return true
	end
	if not DoT_SpellOnTarget(spellname,unit) then
		CastSpellByName(spellname)
		if SpellIsTargeting() then SpellTargetUnit(unit) end
		return false
	end
	return true
end

function DoT_SpellOnTarget(spellname,unit) --is the spell on your target?
	DoTimer_Debug("DoT_SpellOnTarget")
	if not unit then unit = "target" end
	if DoT_SpellInAir(spellname,unit) or DoT_SpellIconOnTarget(spellname,unit) then return true end
	return false
end

function DoT_DetermineSpell(spell1,spell2,unit) --another macro function with some more complicated logic
	if DoTimer_Settings.tbc then return end
	unit = unit or "target"
	DoTimer_Debug("DoT_DetermineSpell")
	if not UnitName(unit) then return true end -- sigh
	if not DoT_SpellOnTarget(spell1) then
		CastSpellByName(spell1)
		if SpellIsTargeting() then SpellTargetUnit(unit) end
		return false
	end
	if (not DoT_OwnSpellOnTarget(spell1)) and (not DoT_OwnSpellOnTarget(spell2)) then
		CastSpellByName(spell2)
		if SpellIsTargeting() then SpellTargetUnit(unit) end
		return false
	end
	return true
end

------------------------------------------------------------------------------------------------------------
-- ############## INTERFACE FUNCTIONS ################ --
------------------------------------------------------------------------------------------------------------

function DoTimer_CreateInterface(external,frommenu) --defines the major portion of writing to the screen; it is called when something drastic has to happen to the interface (i.e., not just updating a timer)
	DoTimer_Debug("redoing interface to add/remove timers")
	if DoTimer_Settings.visible then
		DoTimer_SortTimers()
		local time = GetTime()
		if table.getn(casted) == 0 then DoTimerFrame:SetScript("OnUpdate",nil) end 
		if table.getn(casted) == 1 then DoTimerFrame:SetScript("OnUpdate",function() DoTimer_OnUpdate(arg1) end) end --restoring that OnUpdate
		local targetindex = DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)
		for i = 1,table.getn(casted) do --displaying the information onscreen for each target
			if (not DoTimer_Settings.onlytarget) or (i == (targetindex or ((not UnitExists("target")) and i or 0))) then
				getglobal("DoTimerTarget"..i):Show()
				local targettext
				if DoTimer_Settings.levels then
					targettext = ((casted[i].target == "No Target" or casted[i].target == "Cooldowns ") and casted[i].target or "["..casted[i].level.."] "..casted[i].target)
				else
					targettext = (casted[i].target == "No Target" and casted[i].target or casted[i].target)
				end
				getglobal("DoTimerTarget"..i.."Name").target = targettext
				if DoTimer_Settings.names then --set the target name if you have them on, else hide it
					getglobal("DoTimerTarget"..i.."Name"):Show()
					local targettext
					if DoTimer_Settings.levels then
						targettext = ((casted[i].target == "No Target" or casted[i].target == "Cooldowns ") and casted[i].target or "["..casted[i].level.."] "..string.gsub(casted[i].target," ","\n"))
					else
						targettext = (casted[i].target == "No Target" and casted[i].target or string.gsub(casted[i].target," ","\n"))
					end
					getglobal("DoTimerTarget"..i.."NameText"):SetText(targettext)
					getglobal("DoTimerTarget"..i.."Name"):SetHeight(getglobal("DoTimerTarget"..i.."NameText"):GetHeight())
					getglobal("DoTimerTarget"..i.."Name"):SetWidth(getglobal("DoTimerTarget"..i.."NameText"):GetWidth())
				else
					getglobal("DoTimerTarget"..i.."Name"):Hide()
				end
				for id = 1,table.getn(casted[i]) do --for each debuff on the target
					local debuffframe = getglobal("DoTimerTarget"..i.."Debuff"..id)
					if frommenu or not (debuffframe.data and debuffframe.data == casted[i][id]) then
						debuffframe.data = casted[i][id]
						local type = casted[i][id].type
						if DoTimer_Settings.format == "icons" then
							getglobal("DoTimerTarget"..i.."Debuff"..id):Show()
							getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton").spell = casted[i][id].spell
							getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton").rank = casted[i][id].rank
							getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton"):UnlockHighlight()
							getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButtonTexture"):SetTexture(casted[i][id].texture) --setting the icon
							if timerdata[type].hastimer then
								local remaining = casted[i][id].duration - time + casted[i][id].time
								getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):SetText(DoTimer_ReturnNewDuration(remaining))
								local displayed = casted[i][id].displayed
								if (displayed == 5 or displayed == 4) and DoTimer_Settings.expalert then getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton"):LockHighlight() end
								local half = math.floor(casted[i][id].duration / 2)
								local color
								if remaining <= 5 then
									color = timerdata[type].colors.final
								elseif remaining <= half then
									color = timerdata[type].colors.half
								else
									color = timerdata[type].colors.begin
								end
								getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):SetTextColor(color.r,color.g,color.b)
							else
								getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):SetText("")
							end													
							getglobal("DoTimerTarget"..i.."Debuff"..id.."Icon"):SetAlpha(timerdata[type].alpha) --setting the alpha of the icon
							getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton"):SetScale(DoTimer_Settings.buttonscale * timerdata[type].scale)
							local enablemouse = DoTimer_Settings.clickable
							if not timerdata[type].clickable then enablemouse = false end
							getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton"):EnableMouse(enablemouse)
						else
							getglobal("DoTimerTarget"..i.."Debuff"..id):Show()
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton").spell = casted[i][id].spell
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton").rank = casted[i][id].rank
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButtonTexture"):SetTexture(casted[i][id].texture) --setting the icon
							if timerdata[type].hastimer then
								local remaining = casted[i][id].duration - time + casted[i][id].time
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetMinMaxValues(0,casted[i][id].duration)
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetValue(remaining)
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatusTime"):SetText(DoTimer_ReturnNewDuration(remaining).." - "..casted[i][id].spell) 							
								local half = casted[i][id].duration / 2
								local color
								if remaining <= 5 then
									color = timerdata[type].colors.final
								elseif remaining <= half then
									color = timerdata[type].colors.half
								else
									color = timerdata[type].colors.begin
								end
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetStatusBarColor(color.r,color.g,color.b)
							elseif timerdata[type].hasspell then
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatusTime"):SetText(casted[i][id].spell)
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetMinMaxValues(0,1)
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetValue(1)
								local color = timerdata[type].colors.begin
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetStatusBarColor(color.r,color.g,color.b)
							else
								getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatusTime"):SetText("")
							end
							getglobal("DoTimerTarget"..i.."Debuff"..id.."Bar"):SetAlpha(timerdata[type].alpha)
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton"):SetScale(DoTimer_Settings.buttonscale * timerdata[type].scale)
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetScale(DoTimer_Settings.buttonscale * timerdata[type].scale)
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarBackground"):SetScale(DoTimer_Settings.buttonscale * timerdata[type].scale)							
							local enablemouse = DoTimer_Settings.clickable
							if not timerdata[type].clickable then enablemouse = false end
							getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton"):EnableMouse(enablemouse)							
						end
					end
				end
			end
		end
		for i = 1,10 do
			if (not casted[i]) or (DoTimer_Settings.onlytarget and not (i == (targetindex or ((not UnitExists("target")) and i or 0)))) then
				getglobal("DoTimerTarget"..i):Hide() --hiding unused targets
				for id = 1,20 do
					getglobal("DoTimerTarget"..i.."Debuff"..id).data = nil
				end
			else
				for id = table.getn(casted[i]) + 1,20 do
					local debuffframe = getglobal("DoTimerTarget"..i.."Debuff"..id)
					debuffframe:Hide() --hiding unused debuffs in used targets
					debuffframe.data = nil
				end
			end
		end
		DoTimer_ResizeInterface()
		hasoffensive,hasdefensive = nil,nil
		for i = 1,table.getn(casted) do
			for id = 1,table.getn(casted[i]) do
				local type = casted[i][id].type
				if type == "debuff" then hasoffensive = 1 
				elseif type == "heal" then hasdefensive = 1
				end
			end
		end
	end
end

function DoTimer_SortTimers() --separated the timers by their type then arranges by time added or time remaining
	for i = table.getn(casted),1,-1 do
		local regtimers = {} --the 5 different types that timers can be, and a table to catch all blank timers
		local deptimers = {}
		local ghosttimers = {}
		local faketimers = {}
		local enslavetimers = {}
		local othertimers = {}
		if DoTimer_Settings.sepghost then --filtering out all blank timers first
			for id = table.getn(casted[i]),1,-1 do
				if casted[i][id].type == "blank" then table.remove(casted[i],id) end
			end
		end
		local total = table.getn(casted[i])
		for id = total,1,-1 do --sorting into correct table
			local intable,type
			type = casted[i][id].type
			if type == "debuff" or type == "heal" then intable = regtimers
			elseif type == "depreciated" then intable = deptimers
			elseif type == "ghost" then intable = ghosttimers
			elseif type == "fake" then intable = faketimers
			elseif type == "enslave" then intable = enslavetimers
			else intable = othertimers
			end
			table.insert(intable,casted[i][id])
			table.remove(casted[i],id)
		end
		local time = GetTime()
		local tables = {regtimers,deptimers,ghosttimers,faketimers,enslavetimers,othertimers}
		if DoTimer_Settings.sortmethod == "remaining" then --sorting the temp tables by time added or time remaining
			for index,value in ipairs(tables) do
				table.sort(value,function(a,b) return (a.duration - time + a.time) < (b.duration - time + b.time) end)
			end
		else
			for index,value in ipairs(tables) do
				table.sort(value,function(a,b) return (a.time) < (b.time) end)
			end		
		end
		for id = 1,table.getn(enslavetimers) do table.insert(casted[i],enslavetimers[id]) end --inserting them back into the main table in the order i want them displayed onscreen
		for id = 1,table.getn(regtimers) do table.insert(casted[i],regtimers[id]) end
		for id = 1,table.getn(deptimers) do table.insert(casted[i],deptimers[id]) end
		if DoTimer_Settings.sepghost and (table.getn(casted[i]) > 0) and (total - table.getn(casted[i]) > 0) then DoTimer_InsertBlankTimer(i) end
		for id = 1,table.getn(ghosttimers) do table.insert(casted[i],ghosttimers[id]) end
		if DoTimer_Settings.sepghost and (table.getn(casted[i]) > 0) and (total - table.getn(casted[i]) > 0) then DoTimer_InsertBlankTimer(i) end
		for id = 1,table.getn(faketimers) do table.insert(casted[i],faketimers[id]) end
		for id = 1,table.getn(othertimers) do table.insert(casted[i],othertimers[id]) end
	end
	if DoTimer_Settings.onlytarget and UnitExists("target") then --moving the table for current target to 1st position if necessary
		local targetindex = DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)
		if targetindex then
			local castedentry = casted[targetindex]
			table.remove(casted,targetindex)
			table.insert(casted,1,castedentry)
		end
	end
	local notargetindex = DoTimer_ReturnTargetTable("No Target",0,0,0)
	if notargetindex then
		local castedentry = casted[notargetindex]
		table.remove(casted,notargetindex)
		table.insert(casted,castedentry)
	end
	local cooldownsindex = DoTimer_ReturnTargetTable("Cooldowns ",0,0,0)
	if cooldownsindex then
		local castedentry = casted[cooldownsindex]
		table.remove(casted,cooldownsindex)
		table.insert(casted,castedentry)
	end
end

function DoTimer_TargetClicked(index)
	if DoTimer_Settings.tbc then return end
	if not (DoTimer_ReturnTargetTable(casted[index].target,casted[index].sex,casted[index].level,casted[index].icon) == DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)) then TargetByName(casted[index].target) end
end

function DoTimer_ButtonClicked(index,indexid) --the script for when an icon is clicked
	if DoTimer_Settings.tbc then return end
	if IsControlKeyDown() then --make it a ghost timer
		if DoTimer_TimerIsReal(index,indexid) then DoTimer_CreateGhostTimer(index,indexid) end
	else --target the mob, or, if ghost, target or cast spell
		if casted[index][indexid].type == "ghost" then
			if DoTimer_ReturnTargetTable(casted[index].target,casted[index].sex,casted[index].level,casted[index].icon) == DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0) then
				local spell = casted[index][indexid].spell
				local rank = casted[index][indexid].rank
				if DoTimer_ReturnEnglish(spell) == "Seduction" then
					PetFollow()
					PetAttack()
				end
				if DoTimer_ReturnEnglish(spell) == "Inferno" then
					spell = DoTimer_ToLocale("Enslave Demon")
					rank = ""
				end
				if DoTimer_Settings.conflag then
					if DoTimer_ReturnEnglish(spell) == "Immolate" and DoT_OwnSpellOnTarget(DoTimer_ToLocale("Immolate")) then
						spell = DoTimer_ToLocale("Conflagrate")
						rank = ""
					elseif DoTimer_ReturnEnglish(spell) == "Rejuvenation" and DoT_SpellOnTarget(DoTimer_ToLocale("Rejuvenation")) then
						spell = DoTimer_ToLocale("Swiftmend")
						rank = ""
					end
				end
				CastSpellByName(spell.."("..rank..")")
			else
				TargetByName(casted[index].target)
			end
		else
			if not (DoTimer_ReturnTargetTable(casted[index].target,casted[index].sex,casted[index].level,casted[index].icon) == DoTimer_ReturnTargetTable(UnitName("target"),UnitSex("target"),UnitLevel("target"),GetRaidTargetIndex("target") or 0)) then TargetByName(casted[index].target) end
		end
	end
end

function DoTimer_AddTimers(numtargets,numdebuffs) --used to view different interface layouts
	DoTimer_DelTimers()
	for i = 1,(numtargets or DoTimer_Settings.maxtargets) do
		getglobal("DoTimerTarget"..i):Show()
		if DoTimer_Settings.names then
			local targettext
			if DoTimer_Settings.levels then
				targettext = "[60] Target\nName\nNumber "..i
			else
				targettext = "Target\nName\nNumber "..i
			end
			getglobal("DoTimerTarget"..i.."Name"):Show()
			getglobal("DoTimerTarget"..i.."NameText"):SetText(targettext)
			getglobal("DoTimerTarget"..i.."Name"):SetHeight(getglobal("DoTimerTarget"..i.."NameText"):GetHeight())
			getglobal("DoTimerTarget"..i.."Name"):SetWidth(getglobal("DoTimerTarget"..i.."NameText"):GetWidth())
			getglobal("DoTimerTarget"..i.."Name").target = "Target Name Number "..i
			getglobal("DoTimerTarget"..i.."Name").level = 60
		end
		for id = 1,(numdebuffs or DoTimer_Settings.maxdebuffs) do
			getglobal("DoTimerTarget"..i.."Debuff"..id):Show()
			if DoTimer_Settings.format == "icons" then
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButtonTexture"):SetTexture(GetSpellTexture(id,BOOKTYPE_SPELL))
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):SetText("0:00")
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton").spell = "Fake Spell"
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton").rank = "Fake Rank"
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):SetTextColor(COLOR_WHITE.r,COLOR_WHITE.g,COLOR_WHITE.b)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Icon"):SetAlpha(1)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton"):SetScale(DoTimer_Settings.buttonscale)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconButton"):EnableMouse(DoTimer_Settings.clickable)
			else
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton").spell = "Fake Spell"
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton").rank = "Fake Rank"
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetMinMaxValues(0,1)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetValue(1)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetStatusBarColor(COLOR_GREEN.r,COLOR_GREEN.g,COLOR_GREEN.b)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatusTime"):SetText("0:00 - Fake Spell")
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButtonTexture"):SetTexture(GetSpellTexture(id,BOOKTYPE_SPELL))
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Bar"):SetAlpha(1)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton"):SetScale(DoTimer_Settings.buttonscale)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetScale(DoTimer_Settings.buttonscale)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarBackground"):SetScale(DoTimer_Settings.buttonscale)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton"):EnableMouse(DoTimer_Settings.clickable)
			end
		end
	end
	DoTimer_ResizeInterface()
end

function DoTimer_DelTimers() --used to hide the "fake" timers created by the above function
	for i = 1,10 do
		getglobal("DoTimerTarget"..i):Hide()
		getglobal("DoTimerTarget"..i.."Name"):Hide()
		for id = 1,20 do
			getglobal("DoTimerTarget"..i.."Debuff"..id):Hide()
		end
	end
end

function DoTimer_DefineInterface(targetsetup,debuffsetup,startup) --the controller behind the 16 different interface layouts
	local oldtargetsetup = DoTimer_Settings.targetlayout
	local olddebuffsetup = DoTimer_Settings.debufflayout
	DoTimer_Settings.targetlayout = targetsetup
	DoTimer_Settings.debufflayout = debuffsetup
	local ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10
	local num1,num2,num3,num4,num5,num6,num7,num8,num9,num10
	--ref1/2: name string to target frame: the name is anchored by (1) to the target's (2)
	--ref3/4: time string to debuff texture: the timer is anchored by (3) to the texture's (4)
	--ref5/6 the anchor corner/its opposite: the 1st target is anchored by (5) to the drag icon's (6)
	--ref7: corner for the other targets: the next target is anchored by (5) to the current's (7)
	--ref8/9: anchors for the debuffs: the next debuff is anchored by its (9) to the previous's (8) (reversed order than usual)
	--ref10: anchor for the 1st debuff; it is connected by its (10) to the target frame's (10)
	--num1/2: dist. between name string and target: you go left (1) and up (2) to go from target to name
	--num3/4: dist. between time string and texture: you go left (3) and up (4) to go from texture to timer
	--num5/6: dist. between debuffs: you go left (5) and up (6) to go from one debuff to the next
	--num7/8: dist. between targets: you go left (7) and up (8) to go from one target to the next
	--num9/10: from main frame to 1st target, for a bit of room: you go left (9) and up (10) to go from main frame to 1st target
	if targetsetup == "up" and debuffsetup == "left" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "LEFT","RIGHT","TOP","BOTTOM","BOTTOMRIGHT","TOPLEFT","TOPRIGHT","LEFT","RIGHT","BOTTOMRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 5,0,0,-5,-5,0,0,5,-5,5
	elseif targetsetup == "down" and debuffsetup == "left" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "LEFT","RIGHT","TOP","BOTTOM","TOPRIGHT","BOTTOMLEFT","BOTTOMRIGHT","LEFT","RIGHT","TOPRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 5,0,0,-5,-5,0,0,-5,-5,-5
	elseif targetsetup == "left" and debuffsetup == "up" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "TOP","BOTTOM","LEFT","RIGHT","BOTTOMRIGHT","TOPLEFT","BOTTOMLEFT","TOP","BOTTOM","BOTTOMRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,-5,5,0,0,5,-5,0,-5,5
	elseif targetsetup == "right" and debuffsetup == "up" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "TOP","BOTTOM","LEFT","RIGHT","BOTTOMLEFT","TOPRIGHT","BOTTOMRIGHT","TOP","BOTTOM","BOTTOMLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,-5,5,0,0,5,5,0,5,5
	elseif targetsetup == "up" and debuffsetup == "right" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "RIGHT","LEFT","TOP","BOTTOM","BOTTOMLEFT","TOPRIGHT","TOPLEFT","RIGHT","LEFT","BOTTOMLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = -5,0,0,-5,5,0,0,5,5,5
	elseif targetsetup == "down" and debuffsetup == "right" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "RIGHT","LEFT","TOP","BOTTOM","TOPLEFT","BOTTOMRIGHT","BOTTOMLEFT","RIGHT","LEFT","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = -5,0,0,-5,5,0,0,-5,5,-5
	elseif targetsetup == "left" and debuffsetup == "down" then --default!
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOM","TOP","LEFT","RIGHT","TOPRIGHT","BOTTOMLEFT","TOPLEFT","BOTTOM","TOP","TOPRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,5,5,0,0,-5,-5,0,-5,-5
	elseif targetsetup == "right" and debuffsetup == "down" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOM","TOP","LEFT","RIGHT","TOPLEFT","BOTTOMRIGHT","TOPRIGHT","BOTTOM","TOP","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,5,5,0,0,-5,5,0,5,-5
	elseif targetsetup == "right" and debuffsetup == "right" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOMLEFT","TOPLEFT","TOP","BOTTOM","TOPLEFT","BOTTOMRIGHT","TOPRIGHT","RIGHT","LEFT","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,5,0,-5,5,0,5,0,5,-5
	elseif targetsetup == "down" and debuffsetup == "down" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "TOPRIGHT","TOPLEFT","LEFT","RIGHT","TOPLEFT","BOTTOMRIGHT","BOTTOMLEFT","BOTTOM","TOP","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = -5,0,5,0,0,-5,0,-5,5,-5
	elseif targetsetup == "left" and debuffsetup == "left" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOMRIGHT","TOPRIGHT","TOP","BOTTOM","TOPRIGHT","BOTTOMLEFT","TOPLEFT","LEFT","RIGHT","TOPRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,5,0,-5,-5,0,-5,0,-5,-5
	elseif targetsetup == "up" and debuffsetup == "up" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOMRIGHT","BOTTOMLEFT","LEFT","RIGHT","BOTTOMLEFT","TOPRIGHT","TOPLEFT","TOP","BOTTOM","BOTTOMLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = -5,0,5,0,0,5,0,5,5,5
	elseif targetsetup == "up" and debuffsetup == "down" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "TOPRIGHT","TOPLEFT","LEFT","RIGHT","BOTTOMLEFT","TOPRIGHT","TOPLEFT","BOTTOM","TOP","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = -5,0,5,0,0,-5,0,5,5,5
	elseif targetsetup == "down" and debuffsetup == "up" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOMRIGHT","BOTTOMLEFT","LEFT","RIGHT","TOPLEFT","BOTTOMRIGHT","BOTTOMLEFT","TOP","BOTTOM","BOTTOMLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = -5,0,5,0,0,5,0,-5,5,-5
	elseif targetsetup == "left" and debuffsetup == "right" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOMLEFT","TOPLEFT","TOP","BOTTOM","TOPRIGHT","BOTTOMLEFT","TOPLEFT","RIGHT","LEFT","TOPLEFT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,5,0,-5,5,0,-5,0,5,-5
	elseif targetsetup == "right" and debuffsetup == "left" then
		ref1,ref2,ref3,ref4,ref5,ref6,ref7,ref8,ref9,ref10 = "BOTTOMRIGHT","TOPRIGHT","TOP","BOTTOM","TOPLEFT","BOTTOMRIGHT","TOPRIGHT","LEFT","RIGHT","TOPRIGHT"
		num1,num2,num3,num4,num5,num6,num7,num8,num9,num10 = 0,5,0,-5,-5,0,5,0,-5,-5
	else
		DoTimer_AddText("Failure to change interface design! No changes made.")
		DoTimer_Settings.targetlayout = oldtargetsetup
		DoTimer_Settings.debufflayout = olddebuffsetup
	end
	if (not (DoTimer_Settings.targetlayout == oldtargetsetup)) or (not (DoTimer_Settings.debufflayout == olddebuffsetup)) or (startup) then
		for i = 1,10 do
			getglobal("DoTimerTarget"..i):ClearAllPoints()
			getglobal("DoTimerTarget"..i.."Name"):ClearAllPoints()
			getglobal("DoTimerTarget"..i.."Name"):SetPoint(ref1,"DoTimerTarget"..i,ref2,num1,num2)
			for id = 1,20 do
				getglobal("DoTimerTarget"..i.."Debuff"..id):ClearAllPoints()
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):ClearAllPoints()
				getglobal("DoTimerTarget"..i.."Debuff"..id.."IconTime"):SetPoint(ref3,"DoTimerTarget"..i.."Debuff"..id.."IconButton",ref4,num3,num4)
			end
		end
		for i = 1,10 do
			getglobal("DoTimerTarget"..i.."Debuff1"):SetPoint(ref10,"DoTimerTarget"..i,ref10)
			for id = 2,20 do
				getglobal("DoTimerTarget"..i.."Debuff"..id):SetPoint(ref9,"DoTimerTarget"..i.."Debuff"..(id-1),ref8,num5,num6)
			end
		end
		getglobal("DoTimerTarget1"):SetPoint(ref5,"DoTimerMainFrame",ref6,num9,num10)
		for i = 2,10 do
			getglobal("DoTimerTarget"..i):SetPoint(ref5,"DoTimerTarget"..(i-1),ref7,num7,num8)
		end
		DoTimer_ResizeInterface()
	end
end

function DoTimer_ResizeInterface() --resizes the frames that hold the debuffs so that they are more tightly compacted on the screen
	local maxwidth,maxheight,otherwidth,otherheight,nameheight,namewidth,targetwidth,targetheight,debuffheight,debuffwidth,timerheight,timerwidth
	local text
	if DoTimer_Settings.levels then
		text = "[-1] Vaelastrasz\nthe\nCorrupt"
	else
		text = "Vaelastrasz\nthe\nCorrupt"
	end
	DoTimerFontTestText:SetText(text) --the target names will be normalized to this name; as it is exceedingly long
	if DoTimer_Settings.names then nameheight,namewidth = DoTimerFontTestText:GetHeight(),DoTimerFontTestText:GetWidth() else nameheight,namewidth = 0,0 end
	if DoTimer_Settings.format == "icons" then
		debuffheight = DoTimerTarget1Debuff1IconButton:GetHeight() * DoTimer_Settings.buttonscale
		debuffwidth = DoTimerTarget1Debuff1IconButton:GetWidth() * DoTimer_Settings.buttonscale
		timerheight = DoTimerTarget1Debuff1IconTime:GetHeight()
		timerwidth = DoTimerTarget1Debuff1IconTime:GetWidth()
	else
		debuffheight = DoTimerTarget1Debuff1BarButton:GetHeight() * DoTimer_Settings.buttonscale
		debuffwidth = DoTimerTarget1Debuff1BarButton:GetWidth() * DoTimer_Settings.buttonscale
	end
	local d = DoTimer_Settings.debufflayout
	if d == "up" or d == "down" then -- wider than they are tall
		if DoTimer_Settings.format == "icons" then
			maxwidth = math.max(namewidth,debuffwidth + timerwidth + 5)
			maxheight = math.max(debuffheight,timerheight)
			otherwidth = debuffwidth + timerwidth + 5
			otherheight = debuffheight
			targetwidth = maxwidth
			targetheight = math.max(nameheight,maxheight)
		else
			maxwidth = debuffwidth
			maxheight = debuffheight
			otherwidth = debuffwidth
			otherheight = debuffheight
			targetwidth = maxwidth
			targetheight = math.max(nameheight,maxheight)
		end
	else --taller than they are wide
		if DoTimer_Settings.format == "icons" then
			maxwidth = math.max(debuffwidth,timerwidth)
			maxheight = math.max(nameheight,debuffheight + timerheight + 5)
			otherwidth = debuffwidth
			otherheight = debuffheight + timerheight + 5
			targetwidth = math.max(namewidth,maxwidth)
			targetheight = maxheight
		else
			maxwidth = debuffwidth
			maxheight = debuffheight
			otherwidth = debuffwidth
			otherheight = debuffheight
			targetwidth = math.max(maxwidth,namewidth)
			targetheight = maxheight
		end
	end
	for i = 1,10 do
		local num = DoTimer_GetNumTimers(i)
		if d == "up" or d == "down" then
			getglobal("DoTimerTarget"..i):SetWidth(targetwidth)
			getglobal("DoTimerTarget"..i):SetHeight(math.max(targetheight + 5,(num * (maxheight + 5))))
		else
			getglobal("DoTimerTarget"..i):SetWidth(math.max(targetwidth + 5,(num * (maxwidth + 5))))
			getglobal("DoTimerTarget"..i):SetHeight(targetheight)		
		end
		for id = 1,20 do
			getglobal("DoTimerTarget"..i.."Debuff"..id):SetWidth(maxwidth)
			getglobal("DoTimerTarget"..i.."Debuff"..id):SetHeight(maxheight)
			local frame
			if DoTimer_Settings.format == "icons" then
				frame = getglobal("DoTimerTarget"..i.."Debuff"..id.."Icon")
			else
				frame = getglobal("DoTimerTarget"..i.."Debuff"..id.."Bar")
			end
			frame:SetWidth(otherwidth)
			frame:SetHeight(otherheight)
		end
	end
end

function DoTimer_GetNumTimers(query)
	for i = 20,1,-1 do
		if getglobal("DoTimerTarget"..query.."Debuff"..i):IsVisible() then return i end
	end
	return 0
end

function DoTimer_SimulateTimer(spell,target) --used to make a fake timer, no real reason for it
	local rank = DoTimer_ReturnRank(spell)
	local sex,level,type
	sex = 0
	level = 60
	type = "player"
	local texture = SpellSystem_ReturnSpellTexture(spell,rank)
	local duration = DoTimer_ReturnDuration(spell,rank)
	local spelltable = {spell = {spell = spell, rank = rank, texture = texture, duration = duration, type = "fake"}, target = {target = target, sex = sex, level = level, type = type,icon = 0}}
	DoTimer_CreateSpellTimer(spelltable)
end

function DoTimer_CreateGhostTimer(found,i) --makes the ghost timer once a spell is control+clicked
	if DoTimer_Settings.tbc then return end
	local basedspell = casted[found][i]
	local basedtarget = casted[found]
	local spelltable = {spell = basedspell.spell, rank = basedspell.rank, texture = basedspell.texture, duration = 0, target = basedtarget.target, targetsex = basedtarget.sex, targetlevel = basedtarget.level, targettype = basedtarget.type, targeticon = basedtarget.icon, timertype = "ghost"}
	DoTimer_CreateSpellTimer(spelltable)
end

function DoTimer_DefineFormat()
	if DoTimer_Settings.format == "icons" then
		for i = 1,10 do
			for id = 1,20 do
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Icon"):Show()
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Bar"):Hide()
			end
		end
	else
		for i = 1,10 do
			for id = 1,20 do
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Icon"):Hide()
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Bar"):Show()
				getglobal("DoTimerTarget"..i.."Debuff"..id.."Bar"):SetWidth(DoTimer_Settings.barlength + 25)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatusTime"):SetWidth(DoTimer_Settings.barlength - 5)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarButton"):SetWidth(DoTimer_Settings.barlength + 25)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarStatus"):SetWidth(DoTimer_Settings.barlength)
				getglobal("DoTimerTarget"..i.."Debuff"..id.."BarBackground"):SetWidth(DoTimer_Settings.barlength)
			end
		end	
	end
	DoTimer_ResizeInterface()
end

function DoTimer_InsertBlankTimer(targetindex)
	local list = {spell = "Blank Spot", rank = "", texture = GetSpellTexture(1,BOOKTYPE_SPELL), duration = 0, time = 0, type = "blank", english = "Blank Spot"}
	table.insert(casted[targetindex],list)
end

function DoTimer_ReturnNewDuration(time) --modifies the time remaining on the debuff into a format suitable for the screen
	newtime = math.floor(time)
	local minutes = math.floor(newtime / 60)
	local seconds = math.floor(newtime - (60 * minutes))
	if seconds < 10 then seconds = "0"..seconds else seconds = tostring(seconds) end
	return string.format("%d:%s",minutes,seconds)
end

function DoTimer_ReturnData()
	return casted
end

------------------------------------------------------------------------------------------------------------
-- ############### OTHER FUNCTIONS ################# --
------------------------------------------------------------------------------------------------------------

function DoTimer_Commands(msg,fromgui) --governs the /command
	local bypass
	if msg == "" then DoTimerMenuFrame:Show()
	elseif msg == "on" then
		DoTimer_Settings.status = true
		DoTimer_AddMenuText("DoTimer by Asheyla now activated!",fromgui)
		DoTimerFrame:SetScript("OnEvent",function() DoTimer_OnEvent(event) end)
		DoTimerFrame:SetScript("OnUpdate",function() DoTimer_OnUpdate(arg1) end)
		DoTimerMainFrame:Show()
		DoTimer_Settings.visible = true		
	elseif msg == "off" then
		DoTimer_Settings.status = false
		DoTimer_AddMenuText("DoTimer by Asheyla is now deactivated.",fromgui)
		DoTimerFrame:SetScript("OnEvent",nil)
		DoTimerFrame:SetScript("OnUpdate",nil)
		DoTimerMainFrame:Hide()
		DoTimer_Settings.visible = false
	elseif msg == "debug off" then
		DoTimer_DebugChannel = nil
		DoTimer_AddMenuText("No longer printing debug messages.",fromgui)
	elseif msg == "reset" then
		DoTimer_Settings = {}
		DoTimer_Startup()
		DoTimerAnchorFrame:ClearAllPoints()
		DoTimerAnchorFrame:SetPoint("CENTER","UIParent","CENTER")
		DoTimer_AddMenuText("All user data is now reset.",fromgui)
	elseif msg == "set format bars" then
		DoTimer_Settings.format = "bars"
		DoTimer_DefineFormat()
		DoTimer_AddMenuText("Timers will now be displayed as bars.",fromgui)
	elseif msg == "set format icons" then
		DoTimer_Settings.format = "icons"
		DoTimer_DefineFormat()
		DoTimer_AddMenuText("Timers will now be displayed as icons.",fromgui)		
	elseif msg == "reset position" then
		DoTimerAnchorFrame:ClearAllPoints()
		DoTimerAnchorFrame:SetPoint("CENTER","UIParent","CENTER")
		DoTimer_AddMenuText("The position of the UI is now reset.",fromgui)		
	elseif msg == "ui off" then
		DoTimer_Settings.visible = false
		DoTimerMainFrame:Hide()
		DoTimer_AddMenuText("The interface is now hidden.",fromgui)
	elseif msg == "ui on" then
		DoTimer_Settings.visible = true
		DoTimerMainFrame:Show()
		DoTimer_AddMenuText("The interface is now shown.",fromgui)
	elseif msg == "play sounds" then
		DoTimer_Settings.playsound = true
		DoTimer_AddMenuText("A sound will be played at 5 seconds.",fromgui)
	elseif msg == "do not play sounds" then
		DoTimer_Settings.playsound = false
		DoTimer_AddMenuText("No sounds will be played.",fromgui)
	elseif msg == "force conflag" then
		DoTimer_Settings.conflag = true
		DoTimer_AddMenuText("Conflagrate will replace immolate, or Swiftmend Rejuvnation, in ghost timers.",fromgui)
	elseif msg == "do not force conflag" then
		DoTimer_Settings.conflag = false
		DoTimer_AddMenuText("Immolate's and Rejuvenation's ghost timers will be unchanged.",fromgui)
	elseif msg == "show only target" then
		DoTimer_Settings.onlytarget = true
		DoTimer_AddMenuText("Only timers your current target will be shown.",fromgui)
	elseif msg == "do not show only target" then
		DoTimer_Settings.onlytarget = false
		DoTimer_AddMenuText("All timers will be shown.",fromgui)
	elseif msg == "names off" then
		DoTimer_Settings.names = false
		DoTimer_AddMenuText("Names will not be shown.",fromgui)
		DoTimer_ResizeInterface()
	elseif msg == "names on" then
		DoTimer_Settings.names = true
		DoTimer_AddMenuText("Names will  be shown.",fromgui)
		DoTimer_ResizeInterface()
	elseif msg == "mana check on" then
		DoTimer_Settings.manacheck = true
		DoTimer_AddMenuText("Life tap will be cast instead of the casted spell if not enough mana for it.",fromgui)
	elseif msg == "mana check off" then
		DoTimer_Settings.manacheck = false
		DoTimer_AddMenuText("Spell casts will behave normally.",fromgui)
	elseif msg == "lock" then
		DoTimer_Settings.locked = true
		DoTimerAnchorFrame:Hide()
		DoTimer_AddMenuText("The timers are now locked in place.",fromgui)
	elseif msg == "unlock" then
		DoTimer_Settings.locked = false
		DoTimerAnchorFrame:Show()
		DoTimer_AddMenuText("The timers can now be moved by dragging the little button around.",fromgui)
	elseif msg == "immol" then
		if preventingimmol then
			preventingimmol = nil
			DoTimer_AddMenuText("Immolate will be not anymore.",fromgui)
		else
			preventingimmol = 1
			DoTimer_AddMenuText("Immolate will be prevented for the duration of combat.",fromgui)
		end
	elseif msg == "hide" then
		DoTimer_DelTimers()
	elseif msg == "tbc on" then
		DoTimer_AddMenuText("TBC compatibility mode is on.  No targeting / casting!",fromgui)
		DoTimer_Settings.tbc = true
	elseif msg == "tbc off" then
		DoTimer_Settings.tbc = false
		DoTimer_AddMenuText("TBC compatibility mode is off.  All features are functional.",fromgui)
	elseif msg == "show levels" then
		DoTimer_Settings.levels = true
		DoTimer_AddMenuText("Levels will be shown with the target name.",fromgui)
	elseif msg == "no levels" then
		DoTimer_Settings.levels = false
		DoTimer_AddMenuText("Levels will not be shown with the target name.",fromgui)
	elseif msg == "sort by remaining" then
		DoTimer_AddMenuText("Timers will now be ordered by their time remaining.",fromgui)
		DoTimer_Settings.sortmethod = "remaining"
	elseif msg == "sort by added" then
		DoTimer_AddMenuText("Timers will now be ordered by when they were cast. ",fromgui)
		DoTimer_Settings.sortmethod = "added"
	elseif msg == "clickable debuffs" then
		DoTimer_Settings.clickable = true
		DoTimer_AddMenuText("The debuffs can now be clicked.  Shift+click to delete, click to target, control+click to create ghost timer.",fromgui)
	elseif msg == "unclickable debuffs" then
		DoTimer_Settings.clickable = false
		DoTimer_AddMenuText("The debuffs can no longer be clicked.",fromgui)
	elseif msg == "no expire alert" then
		DoTimer_Settings.expalert = false
		DoTimer_AddMenuText("The timers will not change color or highlight.",fromgui)
	elseif msg == "expire alert" then
		DoTimer_Settings.expalert = true
		DoTimer_AddMenuText("The timers will change to red and highlight at 5 seconds.",fromgui)
	elseif msg == "show preventing immols" then
		DoTimer_AddText("The macro functions will prevent Immolate being cast on the following mobs: ")
		for index,value in pairs(DoTimer_Settings.preventimmol) do DoTimer_AddText(index) end
	elseif msg == "old timers" then
		DoTimer_Settings.dep = true
		DoTimer_AddMenuText("Timers which may no longer be accurate for your current target will still be shown.",fromgui)
	elseif msg == "no old timers" then
		DoTimer_Settings.dep = false
		DoTimer_AddMenuText("Timers which may no longer be accurate for your current target will be deleted.",fromgui)
	elseif msg == "do not include probable" then
		DoTimer_Settings.probable = false
		DoTimer_AddMenuText("The macro functions scanning for your own debuffs will ignore depreciated timers.",fromgui)
	elseif msg == "include probable" then
		DoTimer_Settings.probable = true
		DoTimer_AddMenuText("The macro functions scanning for your own debuffs will include depreciated timers.",fromgui)
	elseif msg == "all ghost on" then
		DoTimer_Settings.allghost = true
		DoTimer_AddMenuText("Every timer created will automatically make a ghost timer.",fromgui)
	elseif msg == "all ghost off" then
		DoTimer_Settings.allghost = false
		DoTimer_AddMenuText("Ghost timers will not be automatically created.",fromgui)
	elseif msg == "separate ghosts" then
		DoTimer_Settings.sepghost = true
		DoTimer_AddMenuText("Ghost timers will be separated from regular timers.",fromgui)
	elseif msg == "do not separate ghosts" then
		DoTimer_Settings.sepghost = false
		DoTimer_AddMenuText("Ghost timers will not be separated from regular timers.",fromgui)
	elseif msg == "show blocked" then
		DoTimer_AddText("Blocked timers:")
		for index,value in DoTimer_Settings.blocked do DoTimer_AddText(index) end
	elseif msg == "status" then
		DoTimer_AddText("|cff00ffffDoTimer Status:|r")
		DoTimer_AddText("Addon enabled: |cff00ff00"..tostring(DoTimer_Settings.status).."|r")
		DoTimer_AddText("UI scale: |cff00ff00"..tostring(DoTimer_Settings.scale).."|r")
		DoTimer_AddText("UI visible: |cff00ff00"..tostring(DoTimer_Settings.visible).."|r")
		DoTimer_AddText("showing names: |cff00ff00"..tostring(DoTimer_Settings.names).."|r")
		DoTimer_AddText("checking for mana before spellcasts: |cff00ff00"..tostring(DoTimer_Settings.manacheck).."|r")
		DoTimer_AddText("max target tables: |cff00ff00"..tostring(DoTimer_Settings.maxtargets).."|r")
		DoTimer_AddText("max debuffs per target table: |cff00ff00"..tostring(DoTimer_Settings.maxdebuffs).."|r")
		DoTimer_AddText("locked timers in place: |cff00ff00"..tostring(DoTimer_Settings.locked).."|r")
		DoTimer_AddText("target expansion direction: |cff00ff00"..tostring(DoTimer_Settings.targetlayout).."|r")
		DoTimer_AddText("debuff expansion direction: |cff00ff00"..tostring(DoTimer_Settings.debufflayout).."|r")
		DoTimer_AddText("debuffs sort method: |cff00ff00"..tostring(DoTimer_Settings.sortmethod).."|r")
		DoTimer_AddText("clickable debuffs: |cff00ff00"..tostring(DoTimer_Settings.clickable).."|r")
		DoTimer_AddText("button scale: |cff00ff00"..tostring(DoTimer_Settings.buttonscale).."|r")
		DoTimer_AddText("expiration alerts: |cff00ff00"..tostring(DoTimer_Settings.expalert).."|r")
		DoTimer_AddText("showing depreciated timers: |cff00ff00"..tostring(DoTimer_Settings.dep).."|r")
		DoTimer_AddText("including probable timers in functions: |cff00ff00"..tostring(DoTimer_Settings.probable).."|r")
		DoTimer_AddText("mana check lifetap rank: |cff00ff00"..tostring(DoTimer_Settings.lifetaprank).."|r")
		DoTimer_AddText("automatic ghost timer creation: |cff00ff00"..tostring(DoTimer_Settings.allghost).."|r")
		DoTimer_AddText("separated ghost timers: |cff00ff00"..tostring(DoTimer_Settings.sepghost).."|r")
		DoTimer_AddText("showing levels: |cff00ff00"..tostring(DoTimer_Settings.levels).."|r")
		DoTimer_AddText("showing only target: |cff00ff00"..tostring(DoTimer_Settings.onlytarget).."|r")
		DoTimer_AddText("playing sounds: |cff00ff00"..tostring(DoTimer_Settings.playsound).."|r")
		DoTimer_AddText("forcing conflag / swiftmend: |cff00ff00"..tostring(DoTimer_Settings.conflag).."|r")
		DoTimer_AddText("timer format: |cff00ff00"..tostring(DoTimer_Settings.format).."|r")
		DoTimer_AddText("bar length: |cff00ff00"..tostring(DoTimer_Settings.barlength).."|r")
		DoTimer_AddText("TBC compat mode: |cff00ff00"..tostring(DoTimer_Settings.tbc).."|r")
	elseif string.sub(msg,1,6) == "block " then
		local spell = string.lower(string.sub(msg,7))
		DoTimer_Settings.blocked[spell] = 1
		DoTimer_AddMenuText(spell.." will not be shown as a timer.",fromgui)
	elseif string.sub(msg,1,8) == "unblock " then
		local spell = string.lower(string.sub(msg,9))
		DoTimer_Settings.blocked[spell] = nil
		DoTimer_AddMenuText(spell.." will be shown again as a timer.",fromgui)
	elseif string.sub(msg,1,11) == "set layout " then
		local targetlayout,debufflayout = SpellSystem_ParseString(msg,"(%a+)",-2)
		DoTimer_AddMenuText("Target tables will be added "..(targetlayout or "<cannot parse!>").." and debuffs will be added "..(debufflayout or "<cannot parse!>")..".",fromgui)
		DoTimer_DefineInterface(targetlayout,debufflayout)
	elseif string.sub(msg,1,4) == "show" then
		local num1,num2 = SpellSystem_ParseString(msg,"(%d+)",2)
		DoTimer_AddTimers(num1,num2)
		bypass = 1
	elseif string.sub(msg,1,5) == "debug" then
		DoTimer_DebugChannel = SpellSystem_ParseString(msg,"(%d+)")
		if not DoTimer_DebugChannel then DoTimer_DebugChannel = "" end
		DoTimer_AddMenuText("Now printing debug messages.",fromgui)
	elseif string.sub(msg,1,5) == "scale" then
		local scale = string.sub(msg,7)
		if type(tonumber(scale)) == "number" then
			scale = tonumber(string.format("%.2f",scale))
			DoTimerMainFrame:SetScale(scale)
			DoTimer_Settings.scale = scale
			DoTimer_AddMenuText("New scale: "..scale,fromgui)
			DoTimer_ResizeInterface()
		end
	elseif string.sub(msg,1,11) == "bar length " then
		local number = tonumber(string.sub(msg,12))
		if type(number) == "number" and number >= 50 and number <= 250 then
			DoTimer_Settings.barlength = number
			DoTimer_DefineFormat()
			DoTimer_AddMenuText("Timer bars will now have length "..number,fromgui)
		end
	elseif string.sub(msg,1,11) == "max targets" then
		local number = tonumber(string.sub(msg,12))
		if type(number) == "number" and number > 0 and number < 11 then
			DoTimer_Settings.maxtargets = number
			DoTimer_AddMenuText("Max number of target tables is now "..number,fromgui)
		end
	elseif string.sub(msg,1,4) == "sim " then
		local spell,target = SpellSystem_ParseString(msg,"sim (.+) on (.+)")
		if spell and target and DoTimer_intable(spell,spells) then DoTimer_SimulateTimer(spell,target) end
	elseif string.sub(msg,1,12) == "max debuffs " then
		local number = tonumber(string.sub(msg,13))
		if type(number) == "number" and number > 0 and number < 21 then
			DoTimer_Settings.maxdebuffs = number
			DoTimer_AddMenuText("Max number of debuffs per target table is now "..number,fromgui)
		end
	elseif string.sub(msg,1,13) == "button scale " then
		local scale = string.sub(msg,14)
		if type(tonumber(scale)) == "number" then
			scale = tonumber(string.format("%.2f",scale))
			DoTimer_Settings.buttonscale = scale
			DoTimer_AddMenuText("The new button scale is now "..scale,fromgui)
		end	
	elseif string.sub(msg,1,14) == "life tap rank " then
		local rank = string.sub(msg,15)
		if type(tonumber(rank)) == "number" or rank == "max" then
			DoTimer_Settings.lifetaprank = rank
			DoTimer_AddMenuText("The mana check feature will now use the following rank: "..rank,fromgui)
		end
	elseif string.sub(msg,1,17) == "prevent immol on " then
		local target = string.sub(msg,18)
		DoTimer_Settings.preventimmol[target] = 1
		DoTimer_AddMenuText("Macro functions will prevent Immolate being cast on "..target,fromgui)
	elseif string.sub(msg,1,19) == "unprevent immol on " then
		local target = string.sub(msg,20)
		DoTimer_Settings.preventimmol[target] = nil
		DoTimer_AddMenuText("Macro functions will not prevent Immolate being cast on"..target,fromgui)
	elseif string.sub(msg,1,4) == "help" then DoTimer_AddHelpMenu(msg)
	else
		DoTimer_AddMenuText("Type |cff00ff00/dotimer help|r for more options, or |cff00ff00/dotimer|r to open the menu!",fromgui)
	end
	if not (fromgui or bypass) then DoTimer_CreateInterface(1,1) end
end

function DoTimer_FakeInterface() -- used to make the screenshot, yay!
	casted = {
		[1] = {
			["target"] = "Scary Mob",
			["level"] = 63,
			["sex"] = 0,
			["type"] = "mob",
			[1] = {
				["spell"] = "Curse of Agony",
				["rank"] = "Rank 6",
				["duration"] = 24,
				["time"] = GetTime() - 15,
				["texture"] = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras",
				["type"] = "debuff",
				["english"] = "Curse of Agony",
			},
			[2] = {
				["spell"] = "Corruption",
				["rank"] = "Rank 7",
				["duration"] = 18,
				["time"] = GetTime(),
				["texture"] = "Interface\\Icons\\Spell_Shadow_AbominationExplosion",
				["type"] = "debuff",
				["english"] = "Corruption",
			},
			[3] = {
				["spell"] = "Immolate",
				["rank"] = "Rank 8",
				["duration"] = 15,
				["time"] = GetTime() - 11,
				["texture"] = "Interface\\Icons\\Spell_Fire_Immolation",
				["type"] = "debuff",
				["english"] = "Immolate",
				["dep"] = 1,
			},
		},
		[2] = {
			["target"] = "Scary Player",
			["level"] = 60,
			["sex"] = 0,
			["type"] = "player",
			[1] = {
				["spell"] = "Curse of Shadow",
				["rank"] = "Rank 2",
				["duration"] = 300,
				["time"] = GetTime() - 120,
				["texture"] = "Interface\\Icons\\Spell_Shadow_CurseOfAchimonde",
				["type"] = "debuff",
				["english"] = "Curse of Shadow",
			},
			[2] = {
				["spell"] = "Corruption",
				["rank"] = "Rank 7",
				["duration"] = 0,
				["time"] = GetTime(),
				["texture"] = "Interface\\Icons\\Spell_Shadow_AbominationExplosion",
				["type"] = "ghost",
				["english"] = "Corruption",
			},
			[3] = {
				["spell"] = "Spell Lock",
				["rank"] = "",
				["duration"] = 8,
				["time"] = GetTime() - 2,
				["texture"] = "Interface\\Icons\\Spell_Shadow_MindRot",
				["type"] = "debuff",
				["english"] = "Spell Lock",
			},
		},
	}
	DoTimer_CreateInterface()
end

function DoTimer_DebugSS()
	local f = CreateFrame("Frame")
	f:SetScript("OnEvent",function()
		DoTimer_Debug(event..": "..arg1)
	end)
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_TIMEOUT")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_NEEDTARGET")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_BEGIN")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_FAILBEFORE")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_STOP")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_SUCCESS")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_FAILAFTER")
	SpellSystem_RegisterEvent(f,"SPELLSYSTEM_NOTARGET")
end
function DoTimer_PrintUpdates()
	local frames = {
		"DoTimerFrame",
		"DoTimerDelayFrame",
		"DoTimerIconFrame",
		"DoTimerPetFrame",
		"DoTimerPetDelayFrame",
		"DoTimerPetIconFrame",
		"DoTimerCombatFrame",
		"DoTimerPreTimerFrame",
		"DoTimerHealDelayFrame",
		"DoTimerDeathFrame",
	}
	for index,value in ipairs(frames) do
		if getglobal(value):GetScript("OnUpdate") then DoTimer_AddText(value) end
	end
end

function DoTimer_ReturnGroup(i,id)
	return localedata[casted[i][id].texture].group or 0
end

function DoTimer_CreateTimerGroup(name,hastimer,hasspell,clickable,scale,alpha,colors)
	timerdata[name] = {
		hastimer = hastimer,
		hasspell = hasspell,
		clickable = clickable,
		scale = scale,
		alpha = alpha,
		colors = colors
	}
end

function DoTimer_DefineSpell(texture,name,duration,multiplier,group)
	localedata[texture] = {
		name = name,
		duration = duration,
		multiplier = multiplier,
		group = group,
	}
end

function DoTimer_TestNewTimers()
	-- in theory, this will register the "fancy" timer type, which changes from red to green to blue as it progresses, and then makes a timer lasting 10 seconds
	DoTimer_CreateTimerGroup(
		"fancy",true,true,true,1,1,{
			begin = {
				r = 1.0,
				g = .2,
				b = .2,
			},
			half = {
				r = .2,
				g = 1.0,
				b = .2,
			},
			final = {
				r = .2,
				g = .2,
				b = 1.0,
			},
		}
	)
	DoTimer_DefineSpell("Interface\\Icons\\INV_Misc_Food_59","Fancy Spell",30,1,0)
	DoTimer_CreateSpellTimer({
		spell = {
			spell = "Fancy Spell",
			rank = "Fancy Rank",
			texture = "Interface\\Icons\\INV_Misc_Food_59", --its a pumpkin
			type = "fancy",
			duration = 30,
		},
		target = {
			target = "Fancy Target",
			sex = 0,
			level = 60,
			type = "player",
			icon = 0,
		},
	})
end

function DoTimer_Flush()
	for i = 1,table.getn(casted) do
		DoTimer_AddText("target number "..i)
		for id = 1,table.getn(casted[i]) do
			DoTimer_AddText("debuff number "..id)
			DoTimer_AddText(casted[i][id].spell)
		end
	end
end
