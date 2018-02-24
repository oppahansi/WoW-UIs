local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 0.5

local GetTime = _G.GetTime
local pairs = _G.pairs
local GetPetActionInfo = _G.GetPetActionInfo
local GetPetActionCooldown = _G.GetPetActionCooldown


PetCooldownWatcher = {

	New = function(this, env, listenerFunction, warningFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to PetCooldownWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to PetCooldownWatcher:New()")
		end
		
		if warningFunction and type(warningFunction) ~= "function" then
			error("If a warning function is supplied to PetCooldownWatcher, it must be a function")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "PetCooldown"
		
		frame.nextCheckTime = 0

		frame.enabled = false
		frame.enabledAlerts = { }
		
		frame.spellsToScan = { }
		frame.spellsWarned = { }
		frame.spellNextAvailable = { }		

		frame.environment = env		
		frame.OnDetect = listenerFunction
		frame.OnWarn = warningFunction
		
		-- functions
		frame:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
		frame:RegisterEvent("ZONE_CHANGED")
		frame:RegisterEvent("ZONE_CHANGED_INDOORS")
		
		frame.GetAlertTypes = function()
			return {
				["petcooldown"] = L["Pet Spell Cooldowns"],
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
			if this.enabled  and this:CheckEnv("petcooldown") then
				if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" then
					local isIn, instType = IsInInstance()
					
					
					-- reset cooldowns
					if isIn and instType == "arena" then
						this:SetScript("OnUpdate", nil)
						this.spellsToScan = { }
						this.spellsWarned = { }
						this.spellNextAvailable = { }
					end
				elseif event == "PET_BAR_UPDATE_COOLDOWN" then
					this:RecordSpells()
				end
			end
		end)
		
		frame.CheckCooldowns = function(this)
			local curTime = GetTime()

			
			if this.enabled and curTime >= this.nextCheckTime and this:CheckEnv("petcooldown") then
				-- find out when the recently cast spells are next available
				-- and record them if they have a noticable cooldown
				this:ScanSpells(curTime)
				
				-- scan the list of spells known to be on cooldown and
				-- notify if they're now ready to be cast again
				this:NotifySpells(curTime)
				
				if table.isEmpty(this.spellsToScan) == true and table.isEmpty(this.spellNextAvailable) then
					this:SetScript("OnUpdate", nil)
				end

				-- record when we next scan
				this.nextCheckTime = this.nextCheckTime + CHECK_INTERVAL
			end
		end
		
		frame.RecordSpells = function(this)
			for i = 4, 7 do
				this.spellsToScan[i] = GetTime()
			end

			this:SetScript("OnUpdate", this.CheckCooldowns)
		end
		
		frame.ScanSpells = function(this, curTime)
			-- update the list of spells recently cast and on cooldown
			for i, v in pairs(this.spellsToScan) do
				-- has enough time passed to correctly get the cooldown?
				if curTime >= v + 0.5 then
					-- see if this spell has a cooldown
					local nextAvailable = this:SpellNextAvailable(i)
					
					
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
		
		frame.NotifySpells = function(this, curTime)
			for i, v in pairs(this.spellNextAvailable) do
				local name, _, texture = GetPetActionInfo(i)
				local info = {
					["Unit"] = "playerpet",
					["Name"] = name,
					["Spell"] = name,
					["Remaining"] = string.format("%0.1f", v - curTime),
					["Type"] = "petcooldown",
				}			
			

				-- warning			
				if this.settings["petcooldown"].earlyWarning then
					if v - curTime <= ( this.settings["petcooldown"].earlyWarningTime or 3 ) and not this.spellsWarned[i] then
						if this.OnWarn then
							if type(this.OnWarn) == "function" then
								this:OnWarn(this, "petcooldown", name, texture, info)
							else
								error("PetCooldownWatcher.OnWarn must be a function")
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
								this:OnDetect(this, "petcooldown", name, texture, info)
							else
								error("PetCooldownWatcher.OnDetect must be a function")
							end
						end
					end
					
					this.spellsWarned[i] = nil					
					this.spellNextAvailable[i] = nil
				end
			end
		end		
		
		frame.SpellNextAvailable = function(this, actionIndex)
			local nextAvail = nil
			local curTime = GetTime()
			
			
			if actionIndex ~= nil and actionIndex >= 1 then
				local start, duration, enabled = GetPetActionCooldown(actionIndex)
				
				
				if enabled == 1 then
					if duration ~= nil then
						if duration > 1.5 then
							nextAvail = start + duration
						else
							nextAvail = curTime
						end
					else
						nextAvail = curTime + 600
					end		
				else
					nextAvail = curTime
				end
			end
			
			return nextAvail
		end

		return frame
	end,
	
}