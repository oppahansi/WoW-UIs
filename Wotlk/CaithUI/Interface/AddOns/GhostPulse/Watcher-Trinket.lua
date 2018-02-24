local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 0.5

local GetTime = _G.GetTime
local pairs = _G.pairs
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown


TrinketWatcher = {

	New = function(this, env, listenerFunction, warningFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to TrinketWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to TrinketWatcher:New()")
		end
		
		if warningFunction and type(warningFunction) ~= "function" then
			error("If a warning function is supplied to TrinketWatcher, it must be a function")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "Trinket"

		frame.nextCheckTime = 0

		frame.enabled = false
		frame.enabledAlerts = { }
		
		frame.trinketsToScan = { }
		frame.trinketsWarned = { }
		frame.trinketNextAvailable = { }		
		
		frame.environment = env
		frame.OnDetect = listenerFunction
		frame.OnWarn = warningFunction
		
		-- functions
		frame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
		frame:RegisterEvent("ZONE_CHANGED")
		frame:RegisterEvent("ZONE_CHANGED_INDOORS")
		
		frame.GetAlertTypes = function()
			return {
				["trinketcooldown"] = L["Trinket Cooldowns"],
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
			if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" then
				local isIn, instType = IsInInstance()
				
				
				-- reset cooldowns
				if isIn and instType == "arena" then
					this:SetScript("OnUpdate", nil)
					this.trinketsToScan = { }
					this.trinketsWarned = { }
					this.trinketNextAvailable = { }		
				end
			end
			
			if this.enabled then
				if event == "ACTIONBAR_UPDATE_COOLDOWN" then
					this:RecordTrinkets()
				elseif event == "UNIT_INVENTORY_CHANGED" then
					if select(1, ...) == "player" then
						this:RecordTrinkets()
					end
				end
			end
		end)
		
		frame.CheckCooldowns = function(this)
			local curTime = GetTime()
			
			
			if this.enabled and curTime >= this.nextCheckTime then
				-- find out when the recently used trinkets are next available
				-- and record them if they have a noticable cooldown
				this:ScanTrinkets(curTime)
				
				-- scan the list of trinkets known to be on cooldown and
				-- notify if they're now ready to be cast again
				this:NotifyTrinkets(curTime)
				
				if table.isEmpty(this.trinketsToScan) == true and table.isEmpty(this.trinketNextAvailable) then
					this:SetScript("OnUpdate", nil)
				end
	
				-- record when we next scan
				this.nextCheckTime = this.nextCheckTime + CHECK_INTERVAL
			end
		end
		
		frame.RecordTrinkets = function(this)
			for i = 13, 14 do
				this.trinketsToScan[i] = GetTime()
			end

			this:SetScript("OnUpdate", this.CheckCooldowns)
		end
		
		frame.ScanTrinkets = function(this, curTime)
			-- update the list of trinkets recently cast and on cooldown
			for i, v in pairs(this.trinketsToScan) do
				-- has enough time passed to correctly get the cooldown?
				if curTime >= v + 0.5 then
					-- see if this trinket has a cooldown
					local nextAvailable = this:TrinketNextAvailable(i)
					
					
					if nextAvailable then
						local diff = nextAvailable - curTime
						
						
						if diff >= 1.5 then							
							this.trinketNextAvailable[i] = nextAvailable
						end
						
						this.trinketsToScan[i] = nil
					end
				end
			end
		end
		
		frame.NotifyTrinkets = function(this, curTime)
			if this:CheckEnv("trinketcooldown") then
				for i, v in pairs(this.trinketNextAvailable) do
					local link = GetInventoryItemLink("player", i)
					local name
					local texture
					
					
					if link then
						name, _, _, _, _, _, _, _, _, texture = GetItemInfo(link)
					end
					
					if link and name and texture then
						local info = {
							["Unit"] = "player",
							["Name"] = name,
							["Remaining"] = string.format("%0.1f", v - curTime),
							["Type"] = "trinketcooldown",
						}

						-- warning
						if this.settings["trinketcooldown"].earlyWarning then
		 					if v - curTime <= ( this.settings["trinketcooldown"].earlyWarningTime or 3 ) and not this.trinketsWarned[i] then
								if this.OnWarn then
									if type(this.OnWarn) == "function" then
										this:OnWarn(this, "trinketcooldown", name, texture, info)
									else
										error("TrinketWatcher.OnWarn must be a function")
									end
								end
		
								this.trinketsWarned[i] = true
							end
						end
												
						-- alert
						if curTime >= v then
							if curTime <= v + 2 then
								if this.OnDetect then
									if type(this.OnDetect) == "function" then
										this:OnDetect(this, "trinketcooldown", name, texture, info)
									else
										error("TrinketWatcher.OnDetect must be a function")
									end
								end
							end
							
							this.trinketsWarned[i] = nil
							this.trinketNextAvailable[i] = nil
						end
					end
				end				
			end
		end		
		
		frame.TrinketNextAvailable = function(this, actionIndex)
			local nextAvail = nil
			local curTime = GetTime()
			
			
			if actionIndex ~= nil and actionIndex >= 1 then
				local start, duration, enabled = GetInventoryItemCooldown("player", actionIndex)
				
				
				if duration ~= nil then
					if duration > 1.5 then
						nextAvail = start + duration
					else
						nextAvail = curTime
					end
				else
					nextAvail = curTime + 600
				end		
			end
			
			return nextAvail
		end

		frame.trinketsToScan[13] = GetTime()
		frame.trinketsToScan[14] = GetTime()
		
		return frame
	end,
	
}