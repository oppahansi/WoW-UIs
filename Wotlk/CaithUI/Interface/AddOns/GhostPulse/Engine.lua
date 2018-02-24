local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local watchers = { }
local playerClass

Environment = {

	New = function()
		local frame = CreateFrame("frame")
		
		
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:RegisterEvent("RAID_ROSTER_UPDATE")
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		
		frame:SetScript("OnEvent", function(this, event, ...)
			if event == "PLAYER_REGEN_ENABLED" then
				this.inCombat = false
			elseif event == "PLAYER_REGEN_DISABLED" then
				this.inCombat = true
			elseif event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" then
				this:CheckGrouping()
			end
		end)
		
		frame.CheckGrouping = function(this)
			if GetNumRaidMembers() > 0 then
				this.groupType = "raid"
			elseif GetNumPartyMembers() > 0 then
				this.groupType = "party"
			else
				this.groupType = "solo"
			end
		end

		frame.PlayerIsInCombat = function(this)
			return this.inCombat
		end
		
		frame.GetPlayerGroupType = function(this)
			return this.groupType
		end
		
		frame.inCombat = false
		frame:CheckGrouping()
		
		return frame
	end,

	-- common functions for watchers
	SetOptions = function(watcher, options)
		watcher.settings = options
	end,
	
	CheckEnv = function(watcher, alertType)
		local rc = watcher:CheckCombat(alertType) and watcher:CheckGrouping(alertType) and
			   ( watcher.settings[alertType].whileMounted == true or not IsMounted() ) and
			   ( watcher.settings[alertType].whileDead == true or not UnitIsDead("player") )
			   
		if rc then
			if not watcher.settings[alertType].inBattlegrounds then
				local isIn, instType = IsInInstance()
				
				
				if isIn then
					if instType == "pvp" then
						rc = false
					end
				end
			end
		end
		
		return rc
	end,
	
	CheckCombat = function(watcher, alertType)
		local rc = true
		
		if watcher.settings and watcher.settings[alertType].inCombat then
			rc = watcher.environment:PlayerIsInCombat()
		end
		
		return rc
	end,

	CheckGrouping = function(watcher, alertType)
		local rc = true
		local curGroupType = watcher.environment:GetPlayerGroupType()
		
		
		if curGroupType == "solo" then
			rc = watcher.settings[alertType].solo
		elseif curGroupType == "party" then
			rc = watcher.settings[alertType].party
		elseif curGroupType == "raid" then
			rc = watcher.settings[alertType].raid
		end
		
		return rc
	end,
	
	CanShowThing = function(watcher, alertType, thing)
		local rc = true
		
		
		if thing and alertType and watcher.settings[alertType] then
			if not watcher.enabledAlerts[alertType] then
				rc = false
			else
				if watcher.settings[alertType].whitelist and table.isEmpty(watcher.settings[alertType].whitelist) == false then
					rc = watcher.settings[alertType].whitelist[thing]
				else
					if watcher.settings[alertType].blacklist then
						if watcher.settings[alertType].blacklist[thing] then
							rc = false
						end
					end
				end
			end
		end
	
		return rc
	end,
	
	GetPlayerClass = function(this)
		if playerClass == nil then
			_, playerClass = UnitClass("player")
		end
		
		return playerClass
	end,
	
	SetAlertEnabled = function(watcher, alertType, value)
		watcher.enabledAlerts[alertType] = value
	end,
		
}

--[[
	Global watcher options structure...
	
	inCombatOnly						If true, alerts of this type will only be issued if the player is in combat (default false)
	whitelist							Table (string, boolean) of the things that the pulse is restricted to showing (default empty)
	blacklist							Table (string, boolean) of the things that the pulse is not allowed to show (default empty)
	minCooldown							The number of seconds that a cooldown must be (at minimum) in order to raise an alert
	maxCooldown							The number of seconds that a cooldown must be (at most) in order to raise an alert
	color								The highlight color for the alert's pulse
]]

function GhostPulse:InitializeWatchers()
	if #watchers == 0 then
		local env = Environment:New()
		local _, playerClass = UnitClass("player")
		
		
		table.insert(watchers, SpellWatcher:New(env, GhostPulse.Listener, GhostPulse.Warner))
		table.insert(watchers, PetCooldownWatcher:New(env, GhostPulse.Listener, GhostPulse.Warner))
		table.insert(watchers, BagsWatcher:New(env, GhostPulse.Listener, GhostPulse.Warner))
		table.insert(watchers, TrinketWatcher:New(env, GhostPulse.Listener, GhostPulse.Warner))
		table.insert(watchers, MobDebuffWatcher:New(env, GhostPulse.Listener, GhostPulse.Warner, watchers[1]))
		table.insert(watchers, CCExpiryWatcher:New(env, GhostPulse.Listener))
		table.insert(watchers, ThreatGenWatcher:New(env, GhostPulse.Listener))
		table.insert(watchers, EnemyCastWatcher:New(env, GhostPulse.Listener))
		table.insert(watchers, LifeTapWatcher:New(env, GhostPulse.Listener))
		table.insert(watchers, AuraWatcher:New(env, GhostPulse.Listener))
		table.insert(watchers, PlayerDeathWatcher:New(env, GhostPulse.Listener))
		table.insert(watchers, DecurseWatcher:New(env, GhostPulse.Listener))
	end	
end

function GhostPulse:KickstartWatchers()		
	for _, v in pairs(watchers) do
		v:SetOptions(self:CreateWatcherOptions(v:GetAlertTypes()))
	end

	self:EnableActiveAlerts()
end

function GhostPulse:EnableActiveAlerts()
	for _, v in pairs(watchers) do
		local types = v:GetAlertTypes()
		local anyForThisWatcher = false


		for i, _ in pairs(types) do
			local anyForThisAlert = false

			
			-- now scan the frames to see if any frame show this alert
			for j, w in pairs(self.db.profile.frames) do
				if w.alertTypes[i] then
					anyForThisWatcher = true
					anyForThisAlert = true
					break
				end
			end
			
			v:SetAlertEnabled(i, anyForThisAlert)
		end
		
		v.enabled = anyForThisWatcher
	end
end

function GhostPulse:CreateWatcherOptions(alertTypes)
	local rc = { }
	
	for i, _ in pairs(alertTypes) do
		rc[i] = self.db.profile.alerts[i] or {
			inCombat = false,
			whileCounted = false,
			solo = true,
			party = true,
			raid = true,
			inBattlegrounds = true,
			
			minCooldown = 1.5,
			maxCooldown = 3600,
		}
	end
	
	return rc
end

function GhostPulse:SetWatchersEnabled(enable)
	for _, v in pairs(watchers) do
		v.enabled = enable
	end
end

function GhostPulse:Warner(watcher, alertType, name, texture, info)
	if watcher:CheckEnv(alertType) and watcher.enabledAlerts[alertType] and watcher:CanShowThing(alertType, name) and
	   ( info == nil or ( info.Remaining ~= nil and tonumber(info.Remaining) > 0 ) ) then
		-- central dispatch
		local msg = name
		local color = GhostPulse.db.profile.alerts[alertType].earlyWarningColor or { 0, 0, 0 }
		local template = GhostPulse.db.profile.alerts[alertType].earlyWarningTemplate or L["[Name] is ready soon"]
	
		local specificInfo = GhostPulse.db.profile.specifics[name] or { sound = L["None"], limit = 0 }
		local threshold = specificInfo.limit
		local thresholdOkay = false
		
		
		-- check the thresholds to ensure that we are allowed to alert
		if info ~= nil and info["Count"] ~= nil and threshold > 0 then
			if info["Count"] >= threshold then
				thresholdOkay = true
			end
		else
			thresholdOkay = true
		end
	
		if thresholdOkay then
			local sound = GhostPulse.db.profile.alerts[alertType].earlyWarningSound or ""
			local specificInfo = GhostPulse.db.profile.specifics[name] or { sound = L["None"], earlyWarningSound = L["None"], limit = 0 }
			local globalSound = specificInfo.earlyWarningSound
			local shouldPlaySound = false
			local announce = GhostPulse.db.profile.alerts[alertType].announceWarning
			local method = GhostPulse.db.profile.earlyWarningMethod or L["Floating Combat Text"]
			
			
			if globalSound ~= nil and globalSound ~= "" and globalSound ~= L["None"] then
				sound = globalSound
			end
			
			msg = GhostPulse:FormatAlertMessage(template, info)
			
			if method == L["Floating Combat Text"] then
				if CombatText_AddMessage ~= nil then
					CombatText_AddMessage(msg, CombatText_StandardScroll, color[1], color[2], color[3], nil, false)
					shouldPlaySound = true
				end
			elseif method == L["UIErrorsFrame"] then
				UIErrorsFrame:AddMessage(msg, color[1], color[2], color[3])
				shouldPlaySound = true
			elseif method == L["MSBT"] then
				if MikSBT and not MikSBT.IsModDisabled() then
					MikSBT.DisplayMessage(msg, MikSBT.DISPLAYTYPE_NOTIFICATION, false, color[1] * 255, color[2] * 255, color[3] * 255, nil, nil, nil, texture)
					shouldPlaySound = true
				end
			end
			
			if shouldPlaySound then
				if announce then
					GhostPulse:Announce(msg)
				end
				
				if sound and sound ~= "" then
					GhostPulse:PlayPulseSound(sound)
				end
			end
		end
	end
end

function GhostPulse:Listener(watcher, alertType, name, texture, info)
	if watcher:CheckEnv(alertType) and watcher.enabledAlerts[alertType] and watcher:CanShowThing(alertType, name) then
		-- central dispatch
		local msg = name
		local color = GhostPulse.db.profile.alerts[alertType].color or { 0, 0, 0 }
		local template = GhostPulse.db.profile.alerts[alertType].textTemplate or "[Name]"

		local specificInfo = GhostPulse.db.profile.specifics[name] or { sound = L["None"], earlyWarningSound = L["None"], limit = 0 }
		local globalSound = specificInfo.sound
		local forceSound = false
		local threshold = specificInfo.limit
		local thresholdOkay = false

		local sound = GhostPulse.db.profile.alerts[alertType].sound or ""
		local announce = GhostPulse.db.profile.alerts[alertType].announceAlert
		
		
		-- check the thresholds to ensure that we are allowed to alert
		if info ~= nil and info["Count"] ~= nil and threshold > 0 then
			if info["Count"] >= threshold then
				thresholdOkay = true
			end
		else
			thresholdOkay = true
		end

		if info ~= nil and info["Count"] ~= nil and info["Count"] == 0 then
			info["Count"] = ""
		end
		
		if thresholdOkay then
			local holdFrame = info["Hold"] or false
			
			
			if globalSound ~= nil and globalSound ~= "" and globalSound ~= L["None"] then
				sound = globalSound
				forceSound = true
			end
			
			if info["Count"] ~= nil and info["Count"] == 0 then
				info["Count"] = ""
			end
			
			msg = GhostPulse:FormatAlertMessage(template, info)
			Pulse:Alert(alertType, name, texture, msg, sound, forceSound, color[1], color[2], color[3], holdFrame)
			
			if announce then
				GhostPulse:Announce(msg)
			end
		end
	end
end

function GhostPulse:FormatAlertMessage(template, alertFields)
	return string.gsub(template, "%[(%w+)%]", function(v)
		return alertFields[v]
	end)
end

function GhostPulse:Announce(msg)
	local chan
	
	
	if GetNumRaidMembers() > 0 then
		chan = "RAID"
	elseif GetNumPartyMembers() > 0 then
		chan = "PARTY"
	end
	
	if chan then
		SendChatMessage(msg, chan)
	end
end

function GhostPulse:GetAlertTypes()
	local rc = { }
	local all = { }
	local xref = { }
	local names = { }
	
	
	for _, v in pairs(watchers) do
		local cur = v:GetAlertTypes()


		for j, w in pairs(cur) do
			all[j] = w
			xref[w] = j
			
			table.insert(names, w)
		end
	end
	
	table.sort(names)
	
	for _, v in pairs(names) do
		local cur = {
			["name"] = all[xref[v]],
			["key"] = xref[v],
		}
		
		table.insert(rc, cur)
	end
	
	return rc
end
