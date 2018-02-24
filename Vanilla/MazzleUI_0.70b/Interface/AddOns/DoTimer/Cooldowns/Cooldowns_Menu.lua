function Cooldowns_SetMenuData()
	CooldownsScaleSlider:SetValue(Cooldowns_Settings.scale)
	CooldownsButtonScaleSlider:SetValue(Cooldowns_Settings.buttonscale)
	CooldownsMaxDebuffsSlider:SetValue(Cooldowns_Settings.maxdebuffs)
	CooldownsFormatSlider:SetValue(CooldownsFormatSlider.values[Cooldowns_Settings.format])
	CooldownsDebuffLayoutSlider:SetValue(CooldownsDebuffLayoutSlider.values[Cooldowns_Settings.debufflayout])
	CooldownsDebuffSortSlider:SetValue(CooldownsDebuffSortSlider.values[Cooldowns_Settings.sortmethod])
	CooldownsEnabledCheckButton:SetChecked(Cooldowns_Settings.status)
	CooldownsLockedCheckButton:SetChecked(Cooldowns_Settings.locked)
	CooldownsNamesCheckButton:SetChecked(Cooldowns_Settings.names)
	CooldownsExpAlertCheckButton:SetChecked(Cooldowns_Settings.expalert)
	CooldownsClickableCheckButton:SetChecked(Cooldowns_Settings.clickable)
	CooldownsPlaySoundsCheckButton:SetChecked(Cooldowns_Settings.playsound)
	CooldownsBarLengthSlider:SetValue(Cooldowns_Settings.barlength)
	CooldownsDoTimerCheckButton:SetChecked(Cooldowns_Settings.dotimer)
end

function Cooldowns_ParseMenuData()
	Cooldowns_Commands("scale "..CooldownsScaleSlider:GetValue(),1)
	Cooldowns_Commands("button scale "..CooldownsButtonScaleSlider:GetValue(),1)
	Cooldowns_Commands("max cooldowns "..CooldownsMaxDebuffsSlider:GetValue(),1)
	Cooldowns_Commands("set format "..CooldownsFormatSlider.values[CooldownsFormatSlider:GetValue()],1)
	Cooldowns_Commands("set layout "..CooldownsDebuffLayoutSlider.values[CooldownsDebuffLayoutSlider:GetValue()],1)
	Cooldowns_Commands("sort by "..CooldownsDebuffSortSlider.values[CooldownsDebuffSortSlider:GetValue()],1)
	Cooldowns_Commands("bar length "..CooldownsBarLengthSlider:GetValue(),1)
	if CooldownsEnabledCheckButton:GetChecked() then Cooldowns_Commands("on",1) else Cooldowns_Commands("off",1) end
	if CooldownsLockedCheckButton:GetChecked() then Cooldowns_Commands("lock",1) else Cooldowns_Commands("unlock",1) end
	if CooldownsNamesCheckButton:GetChecked() then Cooldowns_Commands("header on",1) else Cooldowns_Commands("header off",1) end
	if CooldownsExpAlertCheckButton:GetChecked() then Cooldowns_Commands("expire alert",1) else Cooldowns_Commands("no expire alert",1) end
	if CooldownsClickableCheckButton:GetChecked() then Cooldowns_Commands("clickable cooldowns",1) else Cooldowns_Commands("unclickable cooldowns",1) end
	if CooldownsPlaySoundsCheckButton:GetChecked() then Cooldowns_Commands("play sounds",1) else Cooldowns_Commands("do not play sounds",1) end
	if CooldownsDoTimerCheckButton:GetChecked() then Cooldowns_Commands("integrate",1) else Cooldowns_Commands("separate",1) end
	Cooldowns_CreateInterface(1,1)
end

function Cooldowns_AddHelpMenu(msg) --the help menu displayed ingame
	if msg == "help general" then
		Cooldowns_AddText("|cff00ffffCooldowns General Help:|r")
		Cooldowns_AddText("|cff00ff00[on, off]|r: enables or disables the addon")
		Cooldowns_AddText("|cff00ff00status|r: displays all the current settings")
		Cooldowns_AddText("|cff00ff00[un]lock|r: toggles the visibility of the dragging button, used to move around the timers, default shown")
	elseif msg == "help sizing" then
		Cooldowns_AddText("|cff00ffffCooldowns Sizing Help:|r")
		Cooldowns_AddText("|cff00ff00scale #|r: set UI scale to that number, default 1")
		Cooldowns_AddText("|cff00ff00button scale #|r: set the button scale to that number, default 1")
	elseif msg == "help basic interface" then
		Cooldowns_AddText("|cff00ffffCooldowns Basic Interface Help:|r")
		Cooldowns_AddText("|cff00ff00names [on, off]|r: toggles the displaying of a header for the cooldowns, default on")
		Cooldowns_AddText("|cff00ff00max debuffs #|r: sets number of cooldowns, max 20, default 8")
		Cooldowns_AddText("|cff00ff00[separate,integrate]|r: determines if the cooldowns will be integrated into DoTimer, default separated")
	elseif msg == "help advanced interface" then
		Cooldowns_AddText("|cff00ffffCooldowns Advanced Interface Help:|r")
		Cooldowns_AddText("|cff00ff00set layout [left,right,up,down]|r: sets the direction new cooldowns are added, default \"left down\"")
		Cooldowns_AddText("|cff00ff00sort by [added,remaining]|r: sorts the visible timers by either time added or time remaining, default added")
		Cooldowns_AddText("|cff00ff00[no ]expire alert|r: determines if timers will highlight for 2 seconds and turn red at 5 seconds, default on")
		Cooldowns_AddText("|cff00ff00[un]clickable debuffs|r: determines if the timers can be clicked to remove them,default off")
		Cooldowns_AddText("|cff00ff00[do not ]play sounds|r: determines if a sound will be played when a timer hits 5 seconds left, default off")
		Cooldowns_AddText("|cff00ff00set format [bars,icons]|r: determines if timers will be displayed as bars or icons, default icons")
		Cooldowns_AddText("|cff00ff00bar length #|r: sets the length of timer bars to be #, default 150")
		Cooldowns_AddText("|cff00ff00[un]block spellname|r: determines if spellname will be blocked from having timers displayed.")
		Cooldowns_AddText("|cff00ff00show blocked|r: shows all blocked timers")
	elseif msg == "help resetting" then
		Cooldowns_AddText("|cff00ffffCooldowns Resetting Help:|r")
		Cooldowns_AddText("|cff00ff00reset position|r: resets the position of the interface the the default middle of the screen")
		Cooldowns_AddText("|cff00ff00reset|r: flushes all user data to create a brand new installation")
	elseif msg == "help version" then
		Cooldowns_AddText("|cff00ffffCooldowns Version/Author Info:|r")
		Cooldowns_AddText("|cff00ff00Current version|r: "..SpellSystem_ReturnDateUploaded())
		Cooldowns_AddText("|cff00ff00Date Uploaded|r: "..SpellSystem_ReturnDateUploaded())
		Cooldowns_AddText("|cff00ff00Author|r: Asheyla <Warcraft Gaming Faction>, Shattered Hand (Horde)")
		Cooldowns_AddText("|cff00ff00Contact info|r: ross456@gmail.com")
	elseif msg == "help new" then
		Cooldowns_AddText("|cff00ffffCooldowns Beginner's Guide:|r")
		Cooldowns_AddText("|cff00ff00Please Note|r: The information in this subsection will not detail any other commands.  Please explore all help menus for a full understanding of all the features of this addon.")
		Cooldowns_AddText("|cff00ff00First Installation|r: You will notice a small black circle in the middle of your screen.  It is to this box that the timers are anchored.  Move it around by dragging it.")
		Cooldowns_AddText("|cff00ff00Cooldowns|r: When a tracked ability begins a cooldown, timers will automatically appear.  There is no configuration required for this basic step.")
		Cooldowns_AddText("|cff00ff00Troubleshooting|r: If you ever have any errors, please contact me.  It would be best if you include a way to duplicate the problem.  Before doing this, try disabling your other addons and seeing if the problem goes away.  If it does, figure out the conflicting addon and tell me.")
		Cooldowns_AddText("|cff00ff00Features|r: Many features of this addon have been direct requests by other players.  If you ever have any suggestions, feel free to contact me about them.")
	else
		Cooldowns_AddText("|cff00ffffCooldowns Help Menu:|r")
		Cooldowns_AddText("|cff00ff00help new|r: information for first-time users")
		Cooldowns_AddText("|cff00ff00help general|r: basic addon features")
		Cooldowns_AddText("|cff00ff00help sizing|r: changing the size of the interface")
		Cooldowns_AddText("|cff00ff00help basic interface|r: controls for a few elements of the interface")
		Cooldowns_AddText("|cff00ff00help advanced interface|r: more advanced options for the interface")
		Cooldowns_AddText("|cff00ff00help resetting|r: for resetting things")
		Cooldowns_AddText("|cff00ff00help version|r: displays some version/author info")
	end
end
