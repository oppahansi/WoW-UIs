function Communication_SetMenuData()
	CommunicationEnabledCheckButton:SetChecked(Communication_Settings.enabled)
	CommunicationNewTargetsCheckButton:SetChecked(Communication_Settings.newtargets)
	CommunicationOnlyVisibleCheckButton:SetChecked(Communication_Settings.onlyvisible)
	CommunicationSendDataCheckButton:SetChecked(Communication_Settings.sending)
	CommunicationReceiveDataCheckButton:SetChecked(Communication_Settings.receiving)
end

function Communication_ParseMenuData()
	if DoTimerEnabledCheckButton:GetChecked() then Communication_Commands("on",1) else Communication_Commands("off",1) end
	if CommunicationNewTargetsCheckButton:GetChecked() then Communication_Commands("add new targets",1) else Communication_Commands("no new targets",1) end
	if CommunicationOnlyVisibleCheckButton:GetChecked() then Communication_Commands("only visible people",1) else Communication_Commands("all people",1) end
	if CommunicationSendDataCheckButton:GetChecked() then Communication_Commands("send data",1) else Communication_Commands("do not send data",1) end
	if CommunicationReceiveDataCheckButton:GetChecked() then Communication_Commands("receive data",1) else Communication_Commands("do not receive data",1) end
end

function Communication_AddHelpMenu(msg)
	if msg == "help version" then
		Communication_AddText("|cff00ffffCommunication Version/Author Info:|r")
		Communication_AddText("|cff00ff00Current version|r: "..SpellSystem_ReturnVersion())
		Communication_AddText("|cff00ff00Date Uploaded|r: "..SpellSystem_ReturnDateUploaded())
		Communication_AddText("|cff00ff00Author|r: Asheyla <Warcraft Gaming Faction>, Shattered Hand (Horde)")
		Communication_AddText("|cff00ff00Contact info|r: ross456@gmail.com")
	elseif msg == "help general" then
		Communication_AddText("|cff00ffffCommunication Help Menu:|r")
		Communication_AddText("|cff00ff00[on, off]|r: enables or disables the addon")
		Communication_AddText("|cff00ff00status|r: displays the status of the addon")
		Communication_AddText("|cff00ff00[only visible,all] people|r: determines if timers will only be shown for people you can see, or all people, default only visible")
		Communication_AddText("|cff00ff00[add,no] new targets|r: determines if new target tables will be added if necessary, default added")
		Communication_AddText("|cff00ff00[un][send,rec] [cd,dot] name|r: determines if the cooldown/dot <name> should or should not be sent/received.  all lists start empty.")
		Communication_AddText("|cff00ff00[do not ]send data|r: determines if any data will be sent at all, default yes")
		Communication_AddText("|cff00ff00[do not ]receive data|r: determines if any data will be received at all, default yes")
		Communication_AddText("|cff00ff00show shared timers|r: shows a list of all sent or received timers.")
	else
		Communication_AddText("|cff00ffffCommunication Help Menu:|r")
		Communication_AddText("|cff00ff00help general|r: addon features")
		Communication_AddText("|cff00ff00help version|r: displays some version/author info")
	end
end
