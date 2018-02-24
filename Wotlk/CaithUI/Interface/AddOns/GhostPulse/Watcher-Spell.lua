local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 0.2

local GetTime = _G.GetTime
local pairs = _G.pairs
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellInfo = _G.GetSpellInfo
local GetSpellName = _G.GetSpellName


SpellWatcher = {

	New = function(this, env, listenerFunction, warningFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to SpellWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to SpellWatcher:New()")
		end
			
		if warningFunction and type(warningFunction) ~= "function" then
			error("If a warning function is supplied to SpellWatcher, it must be a function")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "Spell"

		frame.nextCheckTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }
				
		frame.spellsToScan = { }
		frame.spellsWarned = { }
		frame.spellNextAvailable = { }
		
		frame.spellNumbers = { }
		frame.textureCache = { }
		
		frame.environment = env
		frame.OnDetect = listenerFunction
		frame.OnWarn = warningFunction
		
		-- functions
		frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		frame:RegisterEvent("ZONE_CHANGED")
		frame:RegisterEvent("ZONE_CHANGED_INDOORS")
		
		frame.GetAlertTypes = function()
			return {
				["playercooldown"] = L["Player Spell Cooldowns"],
				["spellcast"] = L["Player Spell Casts"],
				["spellresist"] = L["Player Spell Resists"],				
				["spellimmune"] = L["Player Spell Immunity"],
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
				if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" then
					local isIn, instType = IsInInstance()
				
					-- reset cooldowns
					if isIn and instType == "arena" then
						this:SetScript("OnUpdate", nil)
						this.spellsToScan = { }
						this.spellsWarned = { }
						this.spellNextAvailable = { }
					end
					
				elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
					if this.enabledAlerts["playercooldown"] and this:CheckEnv("playercooldown") then
						if table.isEmpty(this.spellNumbers) == true then
							this:GenerateSpellCache()		
						end

						this:RecordSpell(...)
					end
					
					if this.enabledAlerts["spellcast"] and this:CheckEnv("spellcast") then
						this:NotifySpellCast(...)
					end
				elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
					if ( this.enabledAlerts["spellresist"] and this:CheckEnv("spellresist") ) or
					   ( this.enabledAlerts["spellimmune"] and this:CheckEnv("spellimmune") ) then
						this:NotifyMiss(...)
					end
				end
			end
		end)
		
		frame.CheckCooldowns = function(this)
			local curTime = GetTime()
			

			if this.enabled and curTime >= this.nextCheckTime then
				if this.enabledAlerts["playercooldown"] then
					-- find out when the recently cast spells are next available
					-- and record them if they have a noticable cooldown
					this:ScanSpells(curTime)
					
					-- scan the list of spells known to be on cooldown and
					-- notify if they're now ready to be cast again
					this:NotifySpells(curTime)
				end				
			
				if table.isEmpty(this.spellsToScan) == true and table.isEmpty(this.spellNextAvailable) then
					this:SetScript("OnUpdate", nil)
				end

				-- record when we next scan
				this.nextCheckTime = this.nextCheckTime + CHECK_INTERVAL
			end
		end
 
		frame.RecordSpell = function(this, unit, spellName)
			if unit == "player" and this:CanShowThing("playercooldown", spellName) then
				this.spellsToScan[spellName] = GetTime()
				this:SetScript("OnUpdate", this.CheckCooldowns)
			end
		end
		
		frame.ScanSpells = function(this, curTime)
			-- update the list of spells recently cast and on cooldown
			for i, v in pairs(this.spellsToScan) do
				-- has enough time passed to correctly get the cooldown?
				if curTime >= v + 0.5 then
					-- see if this spell has a cooldown
					local nextAvailable = this:SpellNextAvailable(i, curTime)
					
					
					if nextAvailable then
						local diff = nextAvailable - curTime
						
						
						if diff >= 1.5 then
							this.spellNextAvailable[i] = nextAvailable
						end
						
						this.spellsToScan[i] = nil
					end
				end
			end
		end
		
		frame.SpellNextAvailable = function(this, spellName, curTime)
			local nextAvail = nil
			local spellNumber = this.spellNumbers[spellName]
			
			
			if spellNumber ~= nil and spellNumber >= 1 then
				local start, duration, enabled = GetSpellCooldown(spellNumber, BOOKTYPE_SPELL)
				
				
				if enabled == 1 then
					if duration ~= nil then
						if duration >= this.settings["playercooldown"].minCooldown and
						   duration < this.settings["playercooldown"].maxCooldown then
							nextAvail = start + duration
						else
							nextAvail = curTime
						end
					else
						nextAvail = curTime + 600
					end
				end
			end

			return nextAvail
		end
		
		frame.NotifySpells = function(this, curTime)
			if this.enabledAlerts["playercooldown"] and this:CheckEnv("playercooldown") then
				for i, v in pairs(this.spellNextAvailable) do
					local info = {
						["Unit"] = "",
						["Name"] = i,
						["Spell"] = i,
						["Remaining"] = string.format("%0.1f", v - curTime),
						["Type"] = "playercooldown",
					}

					-- warning
					if this.settings["playercooldown"].earlyWarning then
						if v - curTime <= ( this.settings["playercooldown"].earlyWarningTime or 3 ) and not this.spellsWarned[i] then
							if this.OnWarn then
								if type(this.OnWarn) == "function" then
									this:OnWarn(this, "playercooldown", i, this.textureCache[i], info)
								else
									error("SpellWatcher.OnWarn must be a function")
								end
							end
	
							this.spellsWarned[i] = true
						end
					end
										
					-- alert
					if curTime >= v then
						if curTime <= v + 2 then
							if this.OnDetect then
								if type(this.OnDetect) == "function" then
									this:OnDetect(this, "playercooldown", i, this.textureCache[i], info)
								else
									error("SpellWatcher.OnDetect must be a function")
								end
							end
						end
						
						this.spellsWarned[i] = nil
						this.spellNextAvailable[i] = nil
					end
				end
			end
		end
		
		-- used by mob debuffs so it doesn't prompt you to re-apply a debuff that is on cooldown for you
		frame.IsSpellOnCooldown = function(this, spellName)
			local rc = false
			
			
			if this.spellNextAvailable[spellName] and this.spellNextAvailable[spellName] > GetTime() then
				rc = true
			end
			
			return rc
		end
		
		frame.HasSpell = function(this, spellName)
			return ( this.spellNumbers[spellName] ~= nil )
		end
		
		frame.NotifySpellCast = function(this, unit, spellName)
			-- alert
			if this.OnDetect then
				if type(this.OnDetect) == "function" then
					this:OnDetect(this, "spellcast", spellName, this.textureCache[spellName], {
						["Unit"] = unit,
						["Name"] = spellName,
						["Spell"] = spellName,
						["Type"] = "spellcast",
					})
				else
					error("SpellWatcher.OnDetect must be a function")
				end
			end
		end
		
		frame.NotifyMiss = function(this, timeStamp, event, srcGuid, srcName, srcFlags, destGuid, destName, destFlags, spellID, spellName, flags, missType)
			if event == "SPELL_MISSED" then
				local suffix = ""

				
				if missType == "RESIST" then
					suffix = "resist"
				elseif missType == "IMMUNE" then
					suffix = "immune"
				end
				
				if suffix ~= "" then
					if srcGuid == UnitGUID("player") then
						-- alert
						if this.OnDetect then
							if type(this.OnDetect) == "function" then
								this:OnDetect(this, "spell"..suffix, spellName, this.textureCache[spellName], {
									["Unit"] = destName,
									["Name"] = destName,
									["Spell"] = spellName,
									["Type"] = "spell"..suffix,
								})
							else
								error("SpellWatcher.OnDetect must be a function")
							end
						end
					end
				end
			end
		end

		frame.GenerateSpellCache = function(this)
			local i = 1
			local curTime = GetTime()
						
			
			while true do
				local name = GetSpellName(i, BOOKTYPE_SPELL)
				local texture
				
				
				if not name then
					break
				end
		
				_, _, texture = GetSpellInfo(name)
				
				-- Some abilities like "Farie Fire (Feral)" and "Mangle (Cat)" confuse
				-- GetSpellInfo() into returning garbage because it's probably misinterpreting
				-- the parens as a rank. Appending "()" fixes things.
				if not texture then
					_, _, texture = GetSpellInfo(name.."()")
				end
				
				if texture then
					this.textureCache[name] = texture
					this.spellNumbers[name] = i
				end
				
				i = i + 1
			end
		end
		
		return frame
	end,
	
}