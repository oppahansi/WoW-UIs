local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local SCAN_FREQUENCY = 0.5
local PURGE_FREQUENCY = 60
local PURGE_AGE = 300
local ALERT_MAX_FADE_SECONDS = 5

local GetTime = _G.GetTime
local pairs = _G.pairs
local UnitExists = _G.UnitExists
local UnitDebuff = _G.UnitDebuff
local UnitIsFriend = _G.UnitIsFriend

local ccList = {
	[L["Hibernate"]] = true,
	[L["Cyclone"]] = true,
	[L["Polymorph"]] = true,		-- tested
	[L["Seduction"]] = true,		-- tested
	[L["Enslave Demon"]] = true,
	[L["Howl of Terror"]] = true,	-- tested
	[L["Banish"]] = true,			-- tested
	[L["Fear"]] = true,				-- tested
	[L["Death Coil"]] = true,		-- tested
	[L["Turn Evil"]] = true,
	[L["Freezing Trap"]] = true,
	[L["Scatter Shot"]] = true,
	[L["Scare Beast"]] = true,		-- tested
	[L["Sap"]] = true,				-- tested
	[L["Blind"]] = true,			-- tested
	[L["Shackle Undead"]] = true,	-- tested
	[L["Mind Control"]] = true,
}


MobDebuffWatcher = {

	-- functions
	New = function(this, env, listenerFunction, warningFunction, spellMonitor)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to SpellWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to MobDebuffWatcher:New()")
		end
			
		if warningFunction and type(warningFunction) ~= "function" then
			error("If a warning function is supplied to BagsWatcher, it must be a function")
		end
			
		if not spellMonitor or type(spellMonitor) ~= "table" then
			error("Must supply a SpellWatcher to MobDebuffWatcher:New()")
		end
		
		-- create the watcher
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "MobDebuff"
		
		frame.spellCooldownWatcher = spellMonitor
		
		frame.nextScanTime = 0
		frame.nextPurgeTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }
		
		frame.curCCOnUnit = { }
		frame.itemsWarned = { }
		frame.debuffCache = { }
		frame.textureCache = { }
		
		frame:RegisterEvent("PLAYER_TARGET_CHANGED")
		frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
		frame:RegisterEvent("PLAYER_DEAD")
		frame:RegisterEvent("ZONE_CHANGED")
		
		frame.environment = env
		frame.OnDetect = listenerFunction
		frame.OnWarn = warningFunction
		
		frame.GetAlertTypes = function()
			return {
				["mobdebufftarget"] = L["Mob Debuffs (Target)"],
				["mobdebufffocus"] = L["Mob Debuffs (Focus)"],
				["cctarget"] = L["Crowd Control (Target)"],
				["ccfocus"] = L["Crowd Control (Focus)"],
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
				if event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_FOCUS_CHANGED" then
					local shouldSetScript = false
					
					
					if this.enabledAlerts["mobdebufftarget"] or this.enabledAlerts["cctarget"] then
						if UnitExists("target") then
							shouldSetScript = true
						else
							Pulse:Release("cctarget")
						end
					end
					
					if this.enabledAlerts["mobdebufffocus"] or this.enabledAlerts["ccfocus"] then
						if UnitExists("focus") then
							shouldSetScript = true
						else
							Pulse:Release("ccfocus")
						end
					end
					
					if shouldSetScript then
						this:SetScript("OnUpdate", this.CheckDebuffs)
					else
						this:SetScript("OnUpdate", nil)
					end
				elseif event == "PLAYER_DEAD" or event == "ZONE_CHANGED" then
					this.debuffCache = { }
				end
			else
				Pulse:Release("cctarget")
				Pulse:Release("ccfocus")
				this:SetScript("OnUpdate", nil)
			end
		end)
		
		frame.CheckDebuffs = function(this)
			local curTime = GetTime()


			if curTime >= this.nextScanTime then
				this:Scan(curTime)
				this.nextScanTime = this.nextScanTime + SCAN_FREQUENCY
			end
			
			if curTime >= this.nextPurgeTime then
				this:PurgeOldGuids(curTime)
				this.nextPurgeTime = this.nextPurgeTime + PURGE_FREQUENCY
			end
		end
		
		frame.PurgeOldGuids = function(this, curTime)
			for i, v in pairs(this.debuffCache) do
				if curTime - v.lastSeen >= PURGE_AGE then
					this.debuffCache[i] = nil
				end
			end
		end
		
		frame.Scan = function(this, curTime)
			if this.enabledAlerts["mobdebufftarget"] or this.enabledAlerts["cctarget"] then
				this:ScanUnit("target", curTime)
			end
			
			if this.enabledAlerts["mobdebufffocus"] or this.enabledAlerts["ccfocus"] then
				this:ScanUnit("focus", curTime)
			end
		end
		
		frame.ScanUnit = function(this, unit, curTime)
			if unit then
				local curGuid = UnitGUID(unit)
				

				if UnitExists(unit) and ( UnitIsDead(unit) or UnitIsFriend("player", unit) ) then
					this.debuffCache[curGuid] = nil
					this.curCCOnUnit[unit] = nil
					Pulse:Release("cc"..unit)
					
				elseif UnitExists(unit) then
					local lastSeenDebuffs = this.debuffCache[curGuid] and this.debuffCache[curGuid].debuffs
					local curDebuffs = this:GetDebuffs(unit)
					local recentDebuffs = { }
					local anyCC = false
					

					for i, v in pairs(curDebuffs) do
						this.textureCache[i] = this.textureCache[i] or v.texture
						
						if v.playerCast then
							recentDebuffs[i] = v.expiryTime
							
							-- pre-warning
							if this.settings["mobdebuff"..unit].earlyWarning and not this.itemsWarned[i] and this:CheckEnv("mobdebuff"..unit) then
								if v.expiryTime - curTime > 0 then
									if v.expiryTime - curTime <= ( this.settings["mobdebuff"..unit].earlyWarningTime or 3 ) then
										if frame.spellCooldownWatcher:IsSpellOnCooldown(name) == false and frame.spellCooldownWatcher:HasSpell(name) == true then
											if this.OnWarn then
												if type(this.OnWarn) == "function" then
													this:OnWarn(this, "mobdebuff"..unit, i, this.textureCache[i], {
														["Unit"] = unit,
														["Name"] = i,
														["Type"] = "mobdebuff"..unit,
														["Remaining"] = string.format("%0.1f", v.expiryTime - curTime)
													})
												else
													error("BagsWatcher.OnWarn must be a function")
												end
											end
										end
										
										this.itemsWarned[i] = true
									end
								end
							end
						end
						
						-- check for CC
						if ccList[i] and this:CheckEnv("cc"..unit) then
							anyCC = true
							
							-- we have one
							if this.curCCOnUnit[unit] ~= i then
								this.curCCOnUnit[unit] = i
								this:Alert(unit, i, this.textureCache[i], "cc")
							end
						end
					end

					if anyCC == false and this.curCCOnUnit[unit]  then
						this.curCCOnUnit[unit] = nil
						Pulse:Release("cc"..unit)
					end
					
					if lastSeenDebuffs and this:CheckEnv("mobdebuff"..unit) then
						for i, v in pairs(lastSeenDebuffs) do
							if curDebuffs[i] == nil then
								if curTime >= v - SCAN_FREQUENCY then
									-- alert
									this:Alert(unit, i, this.textureCache[i])
								end
								
								this.itemsWarned[i] = false
							else
								-- forget about the debuff if it faded too long ago
								local diff = curTime - v
								
								
								if diff > 0 and diff < ALERT_MAX_FADE_SECONDS then
									recentDebuffs[i] = v
								end
							end							
						end
					end
					
					-- save the entry
					local entry = { }
					
					
					entry.lastSeen = curTime
					entry.debuffs = recentDebuffs
					
					this.debuffCache[curGuid] = entry
				else
					this.curCCOnUnit[unit] = nil
					Pulse:Release("cc"..unit)
				end
			end
		end
		
		frame.GetDebuffs = function(this, unit)
			local rc = { }
			local curTime = GetTime()
			
			
			for i = 1, 40 do
				local name, _, texture, _, _, _, expirationTime, isMine = UnitDebuff(unit, i)

				
				if name and texture then
					-- valid debuff
					local curDebuff = { }
					
					
					curDebuff.name = name
					curDebuff.texture = texture
					curDebuff.playerCast = false
					
					rc[name] = curDebuff

					if isMine then
						curDebuff.expiryTime = expirationTime
						curDebuff.playerCast = true
					end				
				else
					break
				end
			end
			
			return rc
		end
		
		frame.Alert = function(this, unit, name, icon, alertType)
			local aType = alertType or "mobdebuff"
			
			
			if this.OnDetect then
				if type(this.OnDetect) == "function" then
					alerted = true
					
					if frame.spellCooldownWatcher:IsSpellOnCooldown(name) == false and
					  ( alertType == "cc" or frame.spellCooldownWatcher:HasSpell(name) == true ) then
						local info = {
							["Unit"] = unit,
							["Name"] = name,
							["Type"] = aType..unit,
						}
						
						if aType == "cc" then
							info["Hold"] = true
						end
						
						this:OnDetect(this, aType..unit, name, icon, info)
					end
				else
					error("MobDebuffWatcher.OnDetect must be a function")
				end
			end
		end
		
		return frame
	end,
	
}