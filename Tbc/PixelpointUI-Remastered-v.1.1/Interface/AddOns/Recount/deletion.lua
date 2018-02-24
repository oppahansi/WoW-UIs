-- Elsia: For delete on instance entry
-- Deletes data whenever a new, not the same instance is entered. This should safe-guard against corpse-run-reenters and the like.
local revision = tonumber(string.sub("$Revision: 890 $", 12, -3))
if Recount.Version < revision then Recount.Version = revision end

function Recount:DetectInstanceChange() -- Elsia: With thanks to Loggerhead

	local zone = GetRealZoneText()

	if zone == nil or zone == "" then
		-- zone hasn't been loaded yet, try again in 5 secs.
		self:ScheduleTimer("DetectInstanceChange",5)
		return
	end

	local inInstance, instanceType = IsInInstance()
	if Recount.SetZoneFilter and not UnitIsGhost(Recount.PlayerName) then Recount:SetZoneFilter(instanceType) end -- Use zone-based filters.

	if not Recount.db.profile.AutoDeleteNewInstance then return end
	
	local ct = 0; for k,v in pairs(Recount.db2.combatants) do ct = ct + 1; break; end
	if ct==0 then -- Elsia: Already deleted
		return
	end
	
	if inInstance and (not Recount.db.profile.DeleteNewInstanceOnly or Recount.db.profile.LastInstanceName ~= zone) and Recount.CurrentDataCollect then
	   
		if Recount.db.profile.ConfirmDeleteInstance == true then
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
		Recount.db.profile.LastInstanceName = zone -- Elsia: We'll set the instance even if the user opted to not delete...
	end
end

-- Elsia: For delete on join raid/group

function Recount:PartyMembersChanged()

	local ct = 0; for k,v in pairs(Recount.db2.combatants) do ct = ct + 1; break; end
	if ct==0 then -- Elsia: Already deleted
		return
	end

	local NumRaidMembers = GetNumRaidMembers()
	local NumPartyMembers = GetNumPartyMembers()

	if Recount.db.profile.DeleteJoinRaid and not Recount.inRaid and NumRaidMembers > 0 then
		if Recount.db.profile.ConfirmDeleteRaid then
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
		
		if Recount.RequestVersion then Recount:RequestVersion() end -- Elsia: If LazySync is present request version when entering raid
	end

	if Recount.db.profile.DeleteJoinGroup and not Recount.inGroup and NumPartyMembers > 0 and NumRaidMembers == 0 then
		if Recount.db.profile.ConfirmDeleteGroup then
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end

		if Recount.RequestVersion then Recount:RequestVersion() end -- Elsia: If LazySync is present request version when entering party
	end
	
	Recount.inGroup = false
	Recount.inRaid = false
	
	if NumRaidMembers == 0 and NumPartyMembers > 0 or UnitInParty("player") then
	   Recount.inGroup = true
	end

	if NumRaidMembers > 0 or UnitInRaid("player") then
	   Recount.inRaid = true
	end
	
	if Recount.GroupCheck then Recount:GroupCheck() end -- Elsia: Reevaluate group flagging on group changes.
end

function Recount:InitPartyBasedDeletion()
	local NumRaidMembers = GetNumRaidMembers()
	local NumPartyMembers = GetNumPartyMembers()

	Recount.inGroup = false
	Recount.inRaid = false

	if NumPartyMembers > 0 and NumRaidMembers == 0 then Recount.inGroup = true end
	if NumRaidMembers > 0 then Recount.inRaid = true end

	Recount:RegisterEvent("PARTY_MEMBERS_CHANGED","PartyMembersChanged")
	
	Recount:RegisterEvent("RAID_ROSTER_UPDATE","PartyMembersChanged")
end

function Recount:ReleasePartyBasedDeletion()
	if Recount.db.profile.DeleteJoinGroup == false and Recount.db.profile.DeleteJoinRaid == false then
		Recount:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		Recount:UnregisterEvent("RAID_ROSTER_UPDATE")
	end
end
