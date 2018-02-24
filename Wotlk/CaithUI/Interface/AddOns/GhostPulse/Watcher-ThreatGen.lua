local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local GetTime = _G.GetTime
local pairs = _G.pairs

local threatGens = {
	-- druid
	[6795] = "Ability_Physical_Taunt",			-- growl
	[5209] = "Ability_Druid_ChallangingRoar",	-- challenging roar
	[33878] = "Ability_Druid_Mangle2",			-- Mangle(Bear)
	[33986] = "Ability_Druid_Mangle2",			-- Mangle(Bear)
	[33987] = "Ability_Druid_Mangle2",			-- Mangle(Bear)
	
	-- warrior
	[355] = "Spell_Nature_Reincarnation",		-- taunt
	[1161] = "Ability_BullRush",				-- challenging shout
	[23922] = "Spell_Fire_FireArmor",			-- shield slam
	[23923] = "Spell_Fire_FireArmor",			-- shield slam
	[23924] = "Spell_Fire_FireArmor",			-- shield slam
	[23925] = "Spell_Fire_FireArmor",			-- shield slam
	[25258] = "Spell_Fire_FireArmor",			-- shield slam
	[30356] = "Spell_Fire_FireArmor",			-- shield slam
	
	[20243] = "INV_2H_Auchindoun_01",			-- devastate
	[30016] = "INV_2H_Auchindoun_01",			-- devastate
	[30022] = "INV_2H_Auchindoun_01",			-- devastate
	[7386] = "Ability_Warrior_Sunder",			-- sunder
	[7405] = "Ability_Warrior_Sunder",			-- sunder
	[8380] = "Ability_Warrior_Sunder",			-- sunder
	[11596] = "Ability_Warrior_Sunder",			-- sunder
	[11597] = "Ability_Warrior_Sunder",			-- sunder
	[25225] = "Ability_Warrior_Sunder",			-- sunder
	
	-- paladin
	[31935] = "Spell_Holy_AvengersShield",		-- avenger's shield
	[32699] = "Spell_Holy_AvengersShield",		-- avenger's shield
	[32700] = "Spell_Holy_AvengersShield",		-- avenger's shield
	
	[20187] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20280] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20281] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20282] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20283] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20284] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20285] = "Ability_ThunderBolt",			-- judgement of righteousness
	[20286] = "Ability_ThunderBolt",			-- judgement of righteousness
	[27157] = "Ability_ThunderBolt",			-- judgement of righteousness
}

ThreatGenWatcher = {

	New = function(this, env, listenerFunction, warningFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to ThreatGenWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to ThreatGenWatcher:New()")
		end
			
		if warningFunction and type(warningFunction) ~= "function" then
			error("If a warning function is supplied to ThreatGenWatcher, it must be a function")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "ThreatGen"
		
		frame.nextCheckTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }
			
		frame.groupGuids = { }
		
		frame.environment = env
		frame.OnDetect = listenerFunction
		frame.OnWarn = warningFunction
		
		-- functions
		frame:RegisterEvent("RAID_ROSTER_UPDATE")
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		
		frame.GetAlertTypes = function()
			return {
				["threatgentarget"] = L["Threat Resists (Target)"],
				["threatgenfocus"] = L["Threat Resists (Focus)"],
			}
		end
		
		-- common configuration
		frame.SetOptions = Environment.SetOptions		
		frame.CheckEnv = Environment.CheckEnv
		frame.CheckCombat = Environment.CheckCombat
		frame.CheckGrouping = Environment.CheckGrouping
		frame.CanShowThing = Environment.CanShowThing		
		frame.SetAlertEnabled = Environment.SetAlertEnabled
		
		-- watcher-specific function
		frame:SetScript("OnEvent", function(this, event, ...)
			if this.enabled then
				if event == "COMBAT_LOG_EVENT_UNFILTERED" then
					if table.isEmpty(this.groupGuids) then
						this:RecacheGuids()
					end
					
					this:NotifyMiss(...)
				else
					this:RecacheGuids()
				end
			end
		end)		
		
		frame.NotifyMiss = function(this, timeStamp, event, srcGuid, srcName, srcFlags, destGuid, destName, destFlags, spellID, spellName, flags, missType)
			if event == "SPELL_MISSED" then
				-- if the source is in the group
				if this.groupGuids[srcGuid] then
					-- and it's a spell we care about (a threat generator)
					if threatGens[spellID] ~= nil then
						local destUnit = this:DestinationUnit(destGuid)
						
						
						-- and the destination is the current target or focus
						if destUnit then
							this:Alert(destUnit, srcName, spellName, spellID)
							
							if UnitIsUnit("target", "focus") then
								this:Alert("focus", srcName, spellName, spellID)
							end
						end
					end
				end
			end
		end
		
		frame.Alert = function(this, unit, player, spellName, spellID)
			-- alert
			if this.OnDetect then
				if type(this.OnDetect) == "function" then
					this:OnDetect(this, "threatgen"..unit, spellName, "Interface\\Icons\\"..threatGens[spellID], {
						["Unit"] = unit,
						["Player"] = player,
						["Name"] = UnitName(unit),
						["Spell"] = spellName,
						["Type"] = "threatgen"..unit,
					})
				else
					error("ThreatGenWatcher.OnDetect must be a function")
				end
			end
		end
		
		frame.DestinationUnit = function(this, destGuid)
			local rc = nil
			
			
			if UnitExists("target") and destGuid == UnitGUID("target") then
				rc = "target"
			elseif UnitExists("focus") and destGuid == UnitGUID("focus") then
				rc = "focus"
			end
			
			return rc
		end
		
		frame.RecacheGuids = function(this)
			local prefix = "raid"
			local limit = 40
			
			
			this.groupGuids = { }
			
			if GetNumRaidMembers() == 0 then
				prefix = ""
				
				if GetNumPartyMembers() > 0 then
					prefix = "party"
					limit = 4
				end
			end
			
			if prefix ~= "" then
				for i = 1, limit do
					local unit = prefix..i
					
					
					if UnitExists(unit) and not UnitIsUnit("player", unit) then
						local cur = UnitGUID(unit)
						
					
						this.groupGuids[cur] = true
					end
				end
			end
			
			if UnitExists("player") then
				this.groupGuids[UnitGUID("player")] = true
			end
		end
		
		frame:RecacheGuids()
		
		return frame
	end,
	
}