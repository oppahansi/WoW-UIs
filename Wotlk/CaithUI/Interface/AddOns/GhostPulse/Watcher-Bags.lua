local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 0.5

local GetTime = _G.GetTime
local pairs = _G.pairs
local GetContainerItemLink = _G.GetContainerItemLink
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetItemInfo = _G.GetItemInfo


BagsWatcher = {

	New = function(this, env, listenerFunction, warningFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to BagsWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to BagsWatcher:New()")
		end

		if warningFunction and type(warningFunction) ~= "function" then
			error("If a warning function is supplied to BagsWatcher, it must be a function")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "Bags"
		
		frame.nextCheckTime = 0

		frame.enabled = false		
		frame.enabledAlerts = { }
		
		frame.shouldScanItems = true
		frame.itemsWarned = { }
		frame.itemsOnCooldown = { }
		frame.lastKnownBagItems = { }		
		frame.currentBagItems = { }
		frame.textureCache = { }

		frame.environment = env
		frame.OnDetect = listenerFunction
		frame.OnWarn = warningFunction

		-- functions
		frame:RegisterEvent("BAG_UPDATE")
		frame:RegisterEvent("BAG_UPDATE_COOLDOWN")
		frame:RegisterEvent("ZONE_CHANGED")
		frame:RegisterEvent("ZONE_CHANGED_INDOORS")
		
		frame.GetAlertTypes = function()
			return {
				["bagitemcooldown"] = L["Bag Item Cooldowns"],
			}
		end
		
		-- common configuration
		frame.SetOptions = function(this, options)
			Environment.SetOptions(this, options)
			this:RefreshCurrentBagItems(this.lastKnownBagItems)	
		end
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
					this.itemsWarned = { }
					this.itemsOnCooldown = { }
				end
			end
				
			if this.enabled and this:CheckEnv("bagitemcooldown") then
				if event == "BAG_UPDATE_COOLDOWN" then
					this.shouldScanItems = true
				end
				
				this.nextCheckTime = GetTime() + CHECK_INTERVAL
				this:SetScript("OnUpdate", this.ScanBags)
			end
		end)
		
		frame.ScanBags = function(this)
			local curTime = GetTime()
			
			if this.enabled then
				if this.nextCheckTime and curTime >= this.nextCheckTime then
					if this.shouldScanItems then
						this:RefreshCurrentBagItems(this.currentBagItems)
						this:CheckForItemsOnCooldown(curTime)										
						this:RefreshCurrentBagItems(this.lastKnownBagItems)
						this.shouldScanItems = false
					end
										
					if this:CheckEnv("bagitemcooldown") then
						for i, v in pairs(this.itemsOnCooldown) do
							local info = {
								["Unit"] = "player",
								["Name"] = i,
								["Remaining"] = string.format("%0.1f", v - curTime),
								["Type"] = "bagitemcooldown",
							}
							
							-- warning
							if this.settings["bagitemcooldown"].earlyWarning then
								if v - curTime <= ( this.settings["bagitemcooldown"].earlyWarningTime or 3 ) and not this.itemsWarned[i] then
									if this.OnWarn then
										if type(this.OnWarn) == "function" then
											this:OnWarn(this, "bagitemcooldown", i, this.textureCache[i], info)
										else
											error("BagsWatcher.OnWarn must be a function")
										end
									end
			
									this.itemsWarned[i] = true
								end
							end
														
							-- alert
							if curTime >= v then
								if curTime <= v + 2 then
									if this.OnDetect then
										if type(this.OnDetect) == "function" then
											this:OnDetect(this, "bagitemcooldown", i, this.textureCache[i], info)
										else
											error("BagsWatcher.OnDetect must be a function")
										end
									end
								end
								
								this.itemsWarned[i] = nil														
								this.itemsOnCooldown[i] = nil
							end
						end
					end
					
					if table.isEmpty(this.itemsOnCooldown) == true then
						this:SetScript("OnUpdate", nil)
					end
				end
			end
		end
		
		frame.CheckForItemsOnCooldown = function(this, curTime)
			local foundItem = false
			
			
			for pass = 1, 2 do
				for i, v in pairs(this.currentBagItems) do
					if v.valid == true and this:CanShowThing(v.name) then
						local currentCount = 0
						local lastCount = 0


						if pass == 1 then
							currentCount = this:CountItem(v.name, this.currentBagItems)
							lastCount = this:CountItem(v.name, this.lastKnownBagItems)
						end	
	
						if pass == 2 or currentCount < lastCount then
							if v.available ~= nil and v.available >= curTime then						
								this.itemsOnCooldown[v.name] = v.available
								foundItem = true
								break
							end
						end
					end
				end
				
				if foundItem then
					break
				end
			end
		end
		
		frame.CountItem = function(this, name, whichTable)
			local rc = 0
			
			
			for _, v in pairs(whichTable) do
				if v.valid then
					if v.name == name then
						rc = rc + v.count
					end
				end
			end
			
			return rc
		end
		
		frame.RefreshCurrentBagItems = function(this, whichTable)
			for bag = 0, 4 do
				for slot = 1, 40 do
					local curIndex = bag * 40 + slot
					local link = GetContainerItemLink(bag, slot)
					

					whichTable[curIndex] = whichTable[curIndex] or { }
					whichTable[curIndex].valid = false
										
					if link then
						local start, duration, enabled = GetContainerItemCooldown(bag, slot)
		
		
						if enabled and enabled == 1 and 
						   duration >= this.settings["bagitemcooldown"].minCooldown and
						   duration < this.settings["bagitemcooldown"].maxCooldown then
							local name, _, _, _, _, _, _, _, loc = GetItemInfo(link)
							
							
							if loc ~= "INVTYPE_TRINKET" then
								local texture, count = GetContainerItemInfo(bag, slot)
								
								
								if texture then
									whichTable[curIndex].valid = true
									whichTable[curIndex].name = name
									whichTable[curIndex].count = count
									
									if start ~= nil and duration ~= nil then
										whichTable[curIndex].available = start + duration
									else
										whichTable[curIndex].available = nil
									end
									
									this.textureCache[name] = this.textureCache[name] or texture
								end
							end
						end
					end
				end
			end
		end
		
		return frame
	end,
	
}
