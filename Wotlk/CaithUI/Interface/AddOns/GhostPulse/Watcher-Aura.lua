local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 0.25

AuraWatcher = {

	New = function(this, env, listenerFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to AuraWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to AuraWatcher:Connect()")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "Aura"

		frame.nextCheckTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }

		frame.buffCache = { }
		frame.debuffCache = { }
		frame.textureCache = { }
		
		frame.environment = env
		frame.OnBuffGain = listenerFunction
		frame.OnBuffFade = listenerFunction
		frame.OnDebuffGain = listenerFunction
		frame.OnDebuffFade = listenerFunction
		
		-- functions
		frame:RegisterEvent("UNIT_AURA")
		
		frame.GetAlertTypes = function()
			return {
				["buffgain"] = L["Player Buff Gains"],
				["bufffade"] = L["Player Buff Fades"],
				["debuffgain"] = L["Player Debuff Gains"],
				["debufffade"] = L["Player Debuff Fades"],
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
		frame:SetScript("OnEvent", function(this, event, unit)
			if this.enabled and event == "UNIT_AURA" and unit == "player" then
				this.nextCheckTime = GetTime() + CHECK_INTERVAL
				this:SetScript("OnUpdate", this.Scan)
			end
		end)
		
		frame.Scan = function(this)
			local curTime = GetTime()
			
			
			if curTime >= this.nextCheckTime then
				if this.enabledAlerts["buffgain"] or this.enabledAlerts["bufffade"] then
					this:ScanBuffs()
				end
				
				if this.enabledAlerts["debuffgain"] or this.enabledAlerts["debufffade"] then
					this:ScanDebuffs()
				end
				
				this:SetScript("OnUpdate", nil)
			end
		end
		
		frame.ScanBuffs = function(this)
			local recentBuffs = { }


			-- check for new buffs
			for i = 1, 40 do
				local name, _, texture = UnitAura("player", i)
				
				
				if name and texture then
					recentBuffs[name] = true
					this.textureCache[name] = this.textureCache[name] or texture
					
					-- was this buff here last time we checked?
					if not this.buffCache[name]  then
						-- alert
						if this.OnBuffGain then
							if type(this.OnBuffGain) == "function" then
								this:OnBuffGain(this, "buffgain", name, this.textureCache[name], {
									["Unit"] = "player",
									["Name"] = name,
									["Type"] = "buff",
									["Subtype"] = "gain",
								})
							else
								error("AuraWatcher.OnBuffGain must be a function")
							end
						end
					end
				end
			end
			
			-- check for buffs that have faded
			if this:CheckEnv("bufffade") then
				for i, _ in pairs(this.buffCache) do
					if recentBuffs[i] == nil then
						-- alert
						if this.OnBuffFade then
							if type(this.OnBuffFade) == "function" then
								this:OnBuffFade(this, "bufffade", i, this.textureCache[i], {
									["Unit"] = "player",
									["Name"] = i,
									["Type"] = "buff",
									["Subtype"] = "fade",
								})
							else
								error("AuraWatcher.OnBuffFade must be a function")
							end
						end
					end
				end
			end
						
			this.buffCache = recentBuffs
		end
		
		frame.ScanDebuffs = function(this)
			local recentDebuffs = { }

			for i = 1, 40 do
				local name, _, texture, count = UnitDebuff("player", i)
				
				if name and texture then
					count = count or 0
					recentDebuffs[name] = count
					this.textureCache[name] = this.textureCache[name] or texture
						
					if this.debuffCache[name] == nil or this.debuffCache[name] < count then
						-- alert
						if this.OnDebuffGain then
							if type(this.OnDebuffGain) == "function" then
								this:OnDebuffGain(this, "debuffgain", name, this.textureCache[name], {
									["Unit"] = "player",
									["Name"] = name,
									["Type"] = "debuff",
									["Subtype"] = "gain",
									["Count"] = count,
								})
							else
								error("AuraWatcher.OnDebuffGain must be a function")
							end
						end
					end
				else
					break
				end
			end
			
			-- check for debuffs falling off
			if this:CheckEnv("debufffade") then
				for i, _ in pairs(this.debuffCache) do
					if recentDebuffs[i] == nil then
						-- alert
						if this.OnDebuffFade then
							if type(this.OnDebuffFade) == "function" then
								this:OnDebuffFade(this, "debufffade", i, this.textureCache[i], {
									["Unit"] = "player",
									["Name"] = i,
									["Type"] = "debuff",
									["Subtype"] = "fade",
								})
							else
								error("AuraWatcher.OnDebuffFade must be a function")
							end
						end
					end
				end
			end
			
			this.debuffCache = recentDebuffs
		end
		
		return frame
	end,
	
}