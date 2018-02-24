local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local pairs = _G.pairs


EnemyCastWatcher = {

	New = function(this, env, listenerFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to EnemyCastWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to EnemyCastWatcher:New()")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "EnemyCast"
		
		frame.nextCheckTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }
				
		frame.environment = env
		frame.OnDetect = listenerFunction
		
		-- functions
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		
		frame.GetAlertTypes = function()
			return {
				["enemyspellcasttarget"] = L["Enemy Spell Casts (Target)"],
				["enemyspellcastfocus"] = L["Enemy Spell Casts (Focus)"],
				["enemyspellcastboss"] = L["Enemy Spell Casts (Bosses)"],
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
					if this.enabledAlerts["enemyspellcastboss"] or
					   this.enabledAlerts["enemyspellcasttarget"] or
					   this.enabledAlerts["enemyspellcastfocus"] then
						this:NotifyCast(...)
					end
				end
			end
		end)
		
		frame.NotifyCast = function(this, timeStamp, event, srcGuid, srcName, srcFlags, destGuid, destName, destFlags, spellID, spellName, flags)
			if event == "SPELL_CAST_START" or event == "SPELL_PERIODIC_CAST_START" then
				local suffix = ""
				
				
				if this.enabledAlerts["enemyspellcastboss"] and this:CheckEnv("enemyspellcastboss") then
					if this:IsBoss(srcName) then
						suffix = "boss"
					end
				end
				
				if suffix == "" then
					if srcGuid == UnitGUID("target") then
						suffix = "target"
					elseif srcGuid == UnitGUID("focus") then
						suffix = "focus"
					end
				end
								
				if suffix ~= "" then
					if not UnitIsFriend("player", suffix) then
						local name, rank, icon, cost, isFunnel, powerType, castTime = GetSpellInfo(spellID)

						
						-- alert
						this:Alert(suffix, srcName, spellName, icon, castTime)
					end
				end
			end
		end

		frame.Alert = function(this, unit, unitName, spellName, icon, castTime)
			if this.OnDetect then
				if type(this.OnDetect) == "function" then
					local info = {
						["Unit"] = unit,
						["Name"] = unitName,
						["Spell"] = spellName,
						["CastTime"] = string.format("%0.1f", castTime / 1000),
						["Type"] = "enemyspellcast"..unit,
					}
					
					this:OnDetect(this, "enemyspellcast"..unit, spellName, icon, info)
				else
					error("EnemyCastWatcher.OnDetect must be a function")
				end
			end
		end
		
		frame.IsBoss = function(this, name)
			local rc = false
			local prefix = "raid"
			local limit = 40
			local foundUnit = ""
			
			
			if GetNumRaidMembers() == 0 then
				prefix = ""
				limit = 0
				
				if GetNumPartyMembers() > 0 then
					prefix = "party"
					limit = 4
				end
			end
			
			if prefix ~= "" then
				for i = 1, limit do
					local unit = prefix..i.."target"
					
					
					if UnitName(unit) == name then
						foundUnit = unit
						break
					end
				end
			end
			
			if foundUnit ~= "" then
				if UnitLevel(foundUnit) == -1 then
					rc = true
				end
			end
			
			return rc
		end
		
		return frame
	end,
	
}