function DoTimer_SetMenuData()
	DoTimerScaleSlider:SetValue(DoTimer_Settings.scale)
	DoTimerButtonScaleSlider:SetValue(DoTimer_Settings.buttonscale)
	DoTimerMaxTargetsSlider:SetValue(DoTimer_Settings.maxtargets)
	DoTimerMaxDebuffsSlider:SetValue(DoTimer_Settings.maxdebuffs)
	DoTimerFormatSlider:SetValue(DoTimerFormatSlider.values[DoTimer_Settings.format])
	DoTimerTargetLayoutSlider:SetValue(DoTimerTargetLayoutSlider.values[DoTimer_Settings.targetlayout])
	DoTimerDebuffLayoutSlider:SetValue(DoTimerDebuffLayoutSlider.values[DoTimer_Settings.debufflayout])
	DoTimerDebuffSortSlider:SetValue(DoTimerDebuffSortSlider.values[DoTimer_Settings.sortmethod])
	local debugging
	if DoTimer_DebugChannel then
		if DoTimer_DebugChannel == "" then debugging = "on" else debugging = DoTimer_DebugChannel end
	else
		debugging = "off"
	end
	DoTimerDebugEditBox:SetText(debugging)
	DoTimerLifeTapEditBox:SetText(DoTimer_Settings.lifetaprank)
	DoTimerEnabledCheckButton:SetChecked(DoTimer_Settings.status)
	DoTimerVisibleCheckButton:SetChecked(DoTimer_Settings.visible)
	DoTimerLockedCheckButton:SetChecked(DoTimer_Settings.locked)
	DoTimerNamesCheckButton:SetChecked(DoTimer_Settings.names)
	DoTimerLevelsCheckButton:SetChecked(DoTimer_Settings.levels)
	DoTimerExpAlertCheckButton:SetChecked(DoTimer_Settings.expalert)
	DoTimerClickableCheckButton:SetChecked(DoTimer_Settings.clickable)
	DoTimerDepCheckButton:SetChecked(DoTimer_Settings.dep)
	DoTimerProbableCheckButton:SetChecked(DoTimer_Settings.probable)
	DoTimerSepGhostCheckButton:SetChecked(DoTimer_Settings.sepghost)
	DoTimerManaCheckButton:SetChecked(DoTimer_Settings.manacheck)
	DoTimerAllGhostCheckButton:SetChecked(DoTimer_Settings.allghost)
	DoTimerForceConflagCheckButton:SetChecked(DoTimer_Settings.conflag)
	DoTimerOnlyTargetCheckButton:SetChecked(DoTimer_Settings.onlytarget)
	DoTimerPlaySoundsCheckButton:SetChecked(DoTimer_Settings.playsound)
	DoTimerBarLengthSlider:SetValue(DoTimer_Settings.barlength)
	DoTimerTBCCheckButton:SetChecked(DoTimer_Settings.tbc)
end

function DoTimer_ParseMenuData()
	DoTimer_Commands("scale "..DoTimerScaleSlider:GetValue(),1)
	DoTimer_Commands("button scale "..DoTimerButtonScaleSlider:GetValue(),1)
	DoTimer_Commands("max targets "..DoTimerMaxTargetsSlider:GetValue(),1)
	DoTimer_Commands("max debuffs "..DoTimerMaxDebuffsSlider:GetValue(),1)
	DoTimer_Commands("set format "..DoTimerFormatSlider.values[DoTimerFormatSlider:GetValue()],1)
	DoTimer_Commands("set layout "..DoTimerTargetLayoutSlider.values[DoTimerTargetLayoutSlider:GetValue()].." "..DoTimerDebuffLayoutSlider.values[DoTimerDebuffLayoutSlider:GetValue()],1)
	DoTimer_Commands("sort by "..DoTimerDebuffSortSlider.values[DoTimerDebuffSortSlider:GetValue()],1)
	DoTimer_Commands("debug "..DoTimerDebugEditBox:GetText(),1)
	DoTimer_Commands("life tap rank "..DoTimerLifeTapEditBox:GetText(),1)
	DoTimer_Commands("bar length "..DoTimerBarLengthSlider:GetValue(),1)
	if DoTimerEnabledCheckButton:GetChecked() then DoTimer_Commands("on",1) else DoTimer_Commands("off",1) end
	if DoTimerVisibleCheckButton:GetChecked() then DoTimer_Commands("ui on",1) else DoTimer_Commands("ui off",1) end
	if DoTimerLockedCheckButton:GetChecked() then DoTimer_Commands("lock",1) else DoTimer_Commands("unlock",1) end
	if DoTimerNamesCheckButton:GetChecked() then DoTimer_Commands("names on",1) else DoTimer_Commands("names off",1) end
	if DoTimerLevelsCheckButton:GetChecked() then DoTimer_Commands("show levels",1) else DoTimer_Commands("no levels",1) end
	if DoTimerExpAlertCheckButton:GetChecked() then DoTimer_Commands("expire alert",1) else DoTimer_Commands("no expire alert",1) end
	if DoTimerClickableCheckButton:GetChecked() then DoTimer_Commands("clickable debuffs",1) else DoTimer_Commands("unclickable debuffs",1) end
	if DoTimerDepCheckButton:GetChecked() then DoTimer_Commands("old timers",1) else DoTimer_Commands("no old timers",1) end
	if DoTimerProbableCheckButton:GetChecked() then DoTimer_Commands("include probable",1) else DoTimer_Commands("do not include probable",1) end
	if DoTimerSepGhostCheckButton:GetChecked() then DoTimer_Commands("separate ghosts",1) else DoTimer_Commands("do not separate ghosts",1) end
	if DoTimerManaCheckButton:GetChecked() then DoTimer_Commands("mana check on",1) else DoTimer_Commands("mana check off",1) end
	if DoTimerAllGhostCheckButton:GetChecked() then DoTimer_Commands("all ghost on",1) else DoTimer_Commands("all ghost off",1) end
	if DoTimerForceConflagCheckButton:GetChecked() then DoTimer_Commands("force conflag",1) else DoTimer_Commands("do not force conflag",1) end
	if DoTimerOnlyTargetCheckButton:GetChecked() then DoTimer_Commands("show only target",1) else DoTimer_Commands("do not show only target",1) end
	if DoTimerPlaySoundsCheckButton:GetChecked() then DoTimer_Commands("play sounds",1) else DoTimer_Commands("do not play sounds",1) end
	if DoTimerTBCCheckButton:GetChecked() then DoTimer_Commands("tbc on",1) else DoTimer_Commands("tbc off",1) end
	DoTimer_CreateInterface(1,1)
end

function DoTimer_AddHelpMenu(msg) --the help menu displayed ingame
	if msg == "help general" then
		DoTimer_AddText("|cff00ffffDoTimer General Help:|r")
		DoTimer_AddText("|cff00ff00[on, off]|r: enables or disables the addon")
		DoTimer_AddText("|cff00ff00status|r: displays all the current settings")
		DoTimer_AddText("|cff00ff00ui [on, off]|r: toggles the graphical displaying of timers on/off, default on")
		DoTimer_AddText("|cff00ff00[un]lock|r: toggles the visibility of the dragging button, used to move around the timers, default shown")
	elseif msg == "help sizing" then
		DoTimer_AddText("|cff00ffffDoTimer Sizing Help:|r")
		DoTimer_AddText("|cff00ff00scale #|r: set UI scale to that number, default 1")
		DoTimer_AddText("|cff00ff00button scale #|r: set the button scale to that number, default 1")
	elseif msg == "help basic interface" then
		DoTimer_AddText("|cff00ffffDoTimer Basic Interface Help:|r")
		DoTimer_AddText("|cff00ff00names [on, off]|r: toggles the graphical displaying of the names of units who you have debuffed, default on")
		DoTimer_AddText("|cff00ff00[show, no] levels|r: toggles the displaying of the levels of units who you have debuffed, default on")
		DoTimer_AddText("|cff00ff00max targets #|r: sets number of unique target tables created by the addon, max 10, default 5")
		DoTimer_AddText("|cff00ff00max debuffs #|r: sets number of debuffs per target table, max 20, default 8")
	elseif msg == "help advanced interface" then
		DoTimer_AddText("|cff00ffffDoTimer Advanced Interface Help:|r")
		DoTimer_AddText("|cff00ff00set layout [2 of: left,right,up,down]|r: sets the direction targets/debuffs expand, respectively, default \"left down\"")
		DoTimer_AddText("|cff00ff00show [#1 #2]|r: shows the interface for #1 targets and #2 debuffs, if not specified shows the max defined by your settings")
		DoTimer_AddText("|cff00ff00hide|r: hides all visible timers (note: used to hide those shown by previous command)")
		DoTimer_AddText("|cff00ff00sort by [added,remaining]|r: sorts the visible timers by either time added or time remaining, default added")
		DoTimer_AddText("|cff00ff00[no ]expire alert|r: determines if timers will highlight for 2 seconds and turn red at 5 seconds, default on")
		DoTimer_AddText("|cff00ff00[un]clickable debuffs|r: determines if the debuff icons can be clicked (shiftclick to erase, click to target),default off")
		DoTimer_AddText("|cff00ff00[no ]old timers|r: determines if timers which may not be accurate for your current target will be shown (see help info), default on")
		DoTimer_AddText("|cff00ff00[do not ]include probable|r: determines if probable timers will be counted in the corresponding macro functions (see help info), default on")
		DoTimer_AddText("|cff00ff00[do not ]separate ghosts|r: determines if ghost timers will be separated a bit from normal timers, default on")
		DoTimer_AddText("|cff00ff00[do not ]show only target|r: determines if only timers for your current target will be shown (though more will be tracked), default off")
		DoTimer_AddText("|cff00ff00[do not ]force conflag|r: determines if Conflagrate will be casted from the Immolate ghost timer instead, or Swiftmend from Rejuvenation, default off")
		DoTimer_AddText("|cff00ff00[do not ]play sounds|r: determines if a sound will be played when a timer hits 5 seconds left, default off")
		DoTimer_AddText("|cff00ff00set format [bars,icons]|r: determines if timers will be displayed as bars or icons, default icons")
		DoTimer_AddText("|cff00ff00bar length #|r: sets the length of timer bars to be #, default 150")
		DoTimer_AddText("|cff00ff00[un]block spellname|r: determines if spellname will be blocked from having timers displayed.")
		DoTimer_AddText("|cff00ff00show blocked|r: shows all blocked timers")
		elseif msg == "help misc" then
		DoTimer_AddText("|cff00ffffDoTimer Misc Help:|r")
		DoTimer_AddText("|cff00ff00mana check [on, off]|r: determines if Life Tap will be cast instead of the spell attempting to be cast if you don't have enough mana to cast it, default off")
		DoTimer_AddText("|cff00ff00sim Spell on Target|r: creates a fake timer for Spell on Target (you must capitalize the spell correctly!)")
		DoTimer_AddText("|cff00ff00life tap rank [number or \"max\"]|r: sets the rank of Life Tap to use for the mana-check feature; max will cast the highest you have health for, default \"max\"")
		DoTimer_AddText("|cff00ff00prevent immol on mobname|r: makes macro functions DoT_IsSpell and DoT_IsPSpell not cast immolate on mobname")
		DoTimer_AddText("|cff00ff00unprevent immol on mobname|r: undoes what the above command did")
		DoTimer_AddText("|cff00ff00show preventing immols|r: shows all the mobs that immolate will be ignored on")
		DoTimer_AddText("|cff00ff00immol|r: toggles the preventing of immolate for duration of combat")
		DoTimer_AddText("|cff00ff00debug #}r: outputs debug messages to chat frame # (default shat frame if no number)")
		DoTimer_AddText("|cff00ff00debug off|r: turns off the debug messages")
		DoTimer_AddText("|cff00ff00all ghost [on,off]|r: determines if every created timer will automatically have a ghost timer created for it, default off")
		DoTimer_AddText("|cff00ff00tbc [on,off]|r: determines if TBC compatibility mode is enabled, which disables features blocked in the expansion, default off")
	elseif msg == "help resetting" then
		DoTimer_AddText("|cff00ffffDoTimer Resetting Help:|r")
		DoTimer_AddText("|cff00ff00reset position|r: resets the position of the interface the the default middle of the screen")
		DoTimer_AddText("|cff00ff00reset|r: flushes all user data to create a brand new installation")
	elseif msg == "help version" then
		DoTimer_AddText("|cff00ffffDoTimer Version/Author Info:|r")
		DoTimer_AddText("|cff00ff00Current version|r: "..SpellSystem_ReturnVersion())
		DoTimer_AddText("|cff00ff00Date Uploaded|r: "..SpellSystem_ReturnDateUploaded())
		DoTimer_AddText("|cff00ff00Author|r: Asheyla <Warcraft Gaming Faction>, Shattered Hand (Horde)")
		DoTimer_AddText("|cff00ff00Contact info|r: ross456@gmail.com")
	elseif msg == "help info" then
		DoTimer_AddText("|cff00ffffDoTimer Information:|r")
		DoTimer_AddText("|cff00ff00Macro function DoT_IsPSpell(spell[,unit])|r: Tests your target for your own debuff.  If it cannot find it, casts it and returns false.  Else returns true.")
		DoTimer_AddText("|cff00ff00Macro function DoT_IsSpell(spell[,unit])|r: Tests your target for any of that debuff.  If it cannot find it, casts it and returns false.  Else returns true.")
		DoTimer_AddText("|cff00ff00Macro function DoT_DetermineCast(spell1,spell2[,unit])|r: If spell1 is not on target, casts it and returns false.  Else, if your own spell2 is not on target, casts it and returns false.  Else returns true.")
		DoTimer_AddText("|cff00ff00Macro function DoT_SpellOnTarget(spell[,unit])|r: Tests your target for any of that debuff.  If it cannot find it, return false.  Else returns true.  Does not cast.")
		DoTimer_AddText("|cff00ff00Macro function DoT_OwnSpellOnTarget(spell[,unit])|r: Tests your target for your own debuff.  If it cannot find it, return false.  Else returns true.  Does not cast.")
		DoTimer_AddText("|cff00ff00Macro function DoT_ReturnElapsed(spell[,unit])|r: Returns how long that spell has been on your target, or 0 if you don't have it on the mob.")
		DoTimer_AddText("|cff00ff00Macro function DoT_ReturnRemaining(spell[,unit])|r: Returns how much longer that spell will be on your target, or its max duration if you don't have it on the mob.")
		DoTimer_AddText("|cff00ff00Macro function DoT_CastGhostSpell([unit])|r: Casts the spell of any ghost timer you have running on the mob.  ")		
		DoTimer_AddText("|cff00ff00Old timers|r: they appear as faded icons and are debuffs the addon deems inaccurate for whatever reason.  No functions interact with them; they are for your own benefit.")
		DoTimer_AddText("|cff00ff00Ghost timers|r: Made by control+clicking a timer.  When you click on them, it attempts to target the target of its originator debuff.  A subsequent click will cast the spell of the originator debuff.")
		DoTimer_AddText("|cff00ff00Including probable timers|r: If on, the macro functions that check for your own debuffs will also cycle through depreciated timers if it cannot find a suitable timer.  Good unless there are multiple warlocks fighting mobs.  Use wisely.")
	elseif msg == "help new" then
		DoTimer_AddText("|cff00ffffDoTimer Beginner's Guide:|r")
		DoTimer_AddText("|cff00ff00Please Note|r: The information in this subsection will not detail any other commands.  Please explore all help menus for a full understanding of all the features of this addon.")
		DoTimer_AddText("|cff00ff00First Installation|r: You will notice a small black circle in the middle of your screen.  It is to this box that the timers are anchored.  Move it around by dragging it.")
		DoTimer_AddText("|cff00ff00DoTimers|r: When you go out into the world and DoT a mob, timers will automatically appear.  There is no configuration required for this basic step.")
		DoTimer_AddText("|cff00ff00Troubleshooting|r: If you ever have any errors, please contact me.  It would be best if you include a way to duplicate the problem.  Before doing this, try disabling your other addons and seeing if the problem goes away.  If it does, figure out the conflicting addon and tell me.")
		DoTimer_AddText("|cff00ff00Features|r: Many features of this addon have been direct requests by other players.  If you ever have any suggestions, feel free to contact me about them.")
	elseif msg == "help macros" then
		DoTimer_AddText("|cff00ffffDoTimer Example Macros:|r")
		DoTimer_AddText("|cff00ff00Cast your own corruption if it is not on the mob, else Shadow Bolt|r: /script if DoT_IsPSpell(\"Corruption\") then CastSpellByName(\"Shadow Bolt()\") end")
		DoTimer_AddText("|cff00ff00Cast own corruption / immolate, then Shadow Bolt|r: /script if DoT_IsPSpell(\"Corruption\") then if DoT_IsPSpell(\"Immolate\") then CastSpellByName(\"Shadow Bolt()\") end")
		DoTimer_AddText("|cff00ff00Cast Curse of Shadows if it is not on the mob, then Shoot wand|r: /script if DoT_IsSpell(\"Curse of Shadow\") then CastSpellByName(\"Shoot\") end")
		DoTimer_AddText("|cff00ff00Cast CoS, or if someone else did then CoA, then Corruption, then Shadow Bolt|r: /script if DoT_DetermineSpell(\"Curse of Shadow\",\"Curse of Agony\") then if DoT_IsPSpell(\"Corruption\") then CastSpellByName(\"Shadow Bolt()\") end end")
		DoTimer_AddText("|cff00ff00Cast Swiftmend if possible, else Rejuvenation|r: /script local s,c,r = DoT_SpellOnTarget,CastSpellByName,\"Rejuvenation\" if (s(r) or s(\"Regrowth\")) then c(\"Swiftmend\") else c(r) end")
	elseif msg == "help other cmds" then
		DoTimer_AddText("|cff00ffffDoTimer Other Commands:|r")
		DoTimer_AddText("|cff00ff00immol|r: toggles the preventing of immolate for duration of combat")
		DoTimer_AddText("|cff00ff00sim Spell on Target|r: creates a fake timer for Spell on Target (you must capitalize the spell correctly!)")
		DoTimer_AddText("|cff00ff00show #1 #2|r: shows the interface for #1 targets and #2 debuffs, if not specified shows the max defined by your settings")
		DoTimer_AddText("|cff00ff00hide|r: hides all visible timers (note: used to hide those shown by previous command)")
	else
		DoTimer_AddText("|cff00ffffDoTimer Help Menu:|r")
		DoTimer_AddText("|cff00ff00help new|r: information for first-time users")
		DoTimer_AddText("|cff00ff00help general|r: basic addon features")
		DoTimer_AddText("|cff00ff00help sizing|r: changing the size of the interface")
		DoTimer_AddText("|cff00ff00help basic interface|r: controls for a few elements of the interface")
		DoTimer_AddText("|cff00ff00help advanced interface|r: more advanced options for the interface")
		DoTimer_AddText("|cff00ff00help misc|r: other random features")
		DoTimer_AddText("|cff00ff00help resetting|r: for resetting things")
		DoTimer_AddText("|cff00ff00help version|r: displays some version/author info")
		DoTimer_AddText("|cff00ff00help info|r: describes a few features of the addon")
		DoTimer_AddText("|cff00ff00help macros|r: displays a few example macros to get you started")
	end
end
