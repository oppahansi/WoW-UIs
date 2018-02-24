local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 0.25

local GetTime = _G.GetTime
local pairs = _G.pairs


DecurseWatcher = {

	New = function(this, env, listenerFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to DecurseWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to DecurseWatcher:New()")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "Decurse"
		
		frame.nextCheckTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }
				
		frame.unitsToScan = { }
		frame.groupDebuffs = { }
		frame.textureCache = { }
		
		frame.environment = env
		frame.OnDetect = listenerFunction
		
		-- functions
		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("RAID_ROSTER_UPDATE")
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		
		frame.GetAlertTypes = function()
			return {
				["decursemagic"] = L["Decurse - Magic"],
				["decursecurse"] = L["Decurse - Curse"],
				["decursepoison"] = L["Decurse - Poison"],
				["decursedisease"] = L["Decurse - Disease"],
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
				if event == "UNIT_AURA" then
					if ( this.enabledAlerts["decursemagic"] and this:CheckEnv("decursemagic") ) or
					   ( this.enabledAlerts["decursecurse"] and this:CheckEnv("decursecurse") ) or
					   ( this.enabledAlerts["decursepoison"] and this:CheckEnv("decursepoison") ) or
					   ( this.enabledAlerts["decursedisease"] and this:CheckEnv("decursedisease") ) then
						this:NotifyDecurse(...)
					end
				elseif event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" then
					this:ScanUnits()
				end
			end
		end)
		
		frame.NotifyUnits = function(this)
			if this.enabled then
				local curTime = GetTime()
				
				
				if curTime >= this.nextCheckTime then
					for i, v in pairs(this.unitsToScan) do
						this:NotifyUnit(i)
					end
					
					this:SetScript("OnUpdate", nil)
				end
			end
		end

		frame.NotifyUnit = function(this, unit)
			if UnitExists(unit) then
				local unitGuid = UnitGUID(unit)
				local curDebuffs = { }
				
				
				this.groupDebuffs[unitGuid] = this.groupDebuffs[unitGuid] or { }
				
				for i = 1, 40 do
					local name, _, texture, count, debuffType = UnitDebuff(unit, i)
					
					
					if name and texture and debuffType then
						local lType = string.lower(debuffType)
	
	
						this.textureCache[name] = this.textureCache[name] or texture
	
						curDebuffs[name] = true
	
						if not this.groupDebuffs[unitGuid][name] then
							this.groupDebuffs[unitGuid][name] = true
							
							if this:CheckEnv("decurse"..lType) then
								if this:CanShowThing("decurse"..lType, name) then
									if this.OnDetect then
										if type(this.OnDetect) == "function" then
											this:OnDetect(this, "decurse"..lType, name, this.textureCache[name], {
												["Name"] = name,
												["Player"] = UnitName(unit),
												["School"] = debuffType,
												["Type"] = "decurse"..lType,
											})
										else
											error("DecurseWatcher.OnDetect must be a function")
										end
									end
								end
							end
						end
					end
				end
				
				-- remove listings for debuffs not present
				for i, _ in pairs(this.groupDebuffs[unitGuid]) do
					if not curDebuffs[i] then
						this.groupDebuffs[unitGuid][i] = nil
					end
				end
			end
		end
				
		frame.NotifyDecurse = function(this, unit)
			if this.enabled then
				if this:InterestedInUnit(unit) then
					this.unitsToScan[unit] = true
					this.nextCheckTime = GetTime() + CHECK_INTERVAL
					this:SetScript("OnUpdate", this.NotifyUnits)
				end
			end
		end

		frame.ScanUnits = function(this)
			local prefix = "raid"
			local limit = 40
			
			
			this.groupDebuffs = { }
			
			if GetNumRaidMembers() == 0 then
				prefix = ""
				
				if GetNumPartyMembers() > 0 then
					prefix = "party"
					limit = 4
				end
			end
			
			if prefix ~= "" then
				for i = 1, limit do
					this:ScanUnit(prefix..i)
				end
			end
			
			this:ScanUnit("player")
			
			if UnitExists("playerpet") then
				this:ScanUnit("playerpet")
			end
		end
				
		frame.ScanUnit = function(this, unit)
			if UnitExists(unit) then
				local unitGuid = UnitGUID(unit)
				
				
				this.groupDebuffs[unitGuid] = { }
				
				for i = 1, 40 do
					local name, _, texture, count, debuffType = UnitDebuff(unit, i)
					
					
					if name and texture and debuffType then
						local lType = string.lower(debuffType)
	
	
						this.textureCache[name] = this.textureCache[name] or texture
						this.groupDebuffs[unitGuid][name] = true
					end
				end
			end
		end
		
		frame.InterestedInUnit = function(this, unit)
			local interest = false
			
			
			if unit then
				if unit == "player" then
					interest = true
				else
					if string.sub(unit, 1, 5) == "party" then
						interest = true
					elseif string.sub(unit, 1, 4) == "raid" then
						interest = true
					end
				end
			end
			
			return interest
		end
			
		frame:ScanUnits()
		
		return frame
	end,
	
}