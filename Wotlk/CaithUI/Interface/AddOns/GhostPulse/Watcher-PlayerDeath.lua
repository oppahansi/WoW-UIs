local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local inBuiltClassTextures = {
	["DRUID"] = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
	["WARLOCK"] = "Interface\\Icons\\Spell_Nature_FaerieFire",
	["HUNTER"] = "Interface\\Icons\\INV_Weapon_Bow_07",
	["MAGE"] = "Interface\\Icons\\INV_Staff_13",
	["PRIEST"] = "Interface\\Icons\\INV_Staff_30",
	["WARRIOR"] = "Interface\\Icons\\INV_Sword_27",
	["SHAMAN"] = "Interface\\Icons\\Spell_Nature_BloodLust",
}

PlayerDeathWatcher = {

	New = function(this, env, listenerFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to PlayerDeathWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to PlayerDeathWatcher:New()")
		end

		-- globals
		local frame = CreateFrame("Frame")


		frame.watcherName = "PlayerDeath"

		frame.enabled = false
		frame.enabledAlerts = { }
				
		frame.lastKnownAlive = { }
		
		frame.environment = env
		frame.OnPlayerDeath = listenerFunction
		frame.OnPlayerResurrection = listenerFunction

		frame.GetAlertTypes = function()
			return {
				["playerdeath"] = L["Player Deaths"],
				["playerresurrection"] = L["Player Resurrections"],
			}
		end
		
		-- functions
		frame:RegisterEvent("UNIT_HEALTH")
		frame:RegisterEvent("RAID_ROSTER_UPDATE")
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		
		frame:SetScript("OnEvent", function(this, event, ...)
			if this.enabled then
				if event == "UNIT_HEALTH" then
					this:CheckUnitHealth(...)
				elseif event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" then
					this:ScanGroupHealth()
				end
			end
		end)
		
		-- common configuration
		frame.SetOptions = Environment.SetOptions		
		frame.CheckEnv = Environment.CheckEnv
		frame.CheckCombat = Environment.CheckCombat
		frame.CheckGrouping = Environment.CheckGrouping
		frame.CanShowThing = Environment.CanShowThing		
		frame.SetAlertEnabled = Environment.SetAlertEnabled
		
		-- watcher-specific function
		frame.CheckUnitHealth = function(this, unit)
			if this.InterestedInUnitHealth(unit) then
				local name = UnitName(unit)
				local _, class = UnitClass(unit)
				
				if class then
					local texture = inBuiltClassTextures[class] or "Interface\\AddOns\\GhostPulse\\images\\"..class..".tga"


					if not UnitIsDead(unit) and not UnitIsGhost(unit) then
						-- alive
						if not this.lastKnownAlive[name] then
							-- alert
							if this.OnPlayerResurrection then
								if type(this.OnPlayerResurrection) == "function" then
									this:OnPlayerResurrection(this, "playerresurrection", UnitName(unit), texture, {
										["Unit"] = unit,
										["Name"] = UnitName(unit),
										["Type"] = "playerresurrection",
									})
								else
									error("PlayerDeathWatcher.OnPlayerResurrection must be a function")
								end
							end
						end
												
						this.lastKnownAlive[name] = true
					else
						-- dead
						if this.lastKnownAlive[name] then
							-- alert
							if this.OnPlayerDeath then
								if type(this.OnPlayerDeath) == "function" then
									this:OnPlayerDeath(this, "playerdeath", UnitName(unit), texture, {
										["Unit"] = unit,
										["Name"] = UnitName(unit),
										["Type"] = "playerdeath",
									})
								else
									error("PlayerDeathWatcher.OnPlayerDeath must be a function")
								end
							end
						end
																	
						this.lastKnownAlive[name] = false
					end
				end
			end
		end
		
		frame.ScanGroupHealth = function(this)
			local prefix
			local upper
			
			
			this.lastKnownAlive = { }
			
			if GetNumRaidMembers() > 0 then
				prefix = "raid"
				upper = 40
			elseif GetNumPartyMembers() > 0 then
				prefix = "party"
				upper = 5
			else
				prefix = nil
				upper = nil
			end
			
			if prefix then
				for i = 1, upper do
					local unit = prefix..i
					
					
					if UnitExists(unit) then
						local name = UnitName(unit)
						
						
						if not UnitIsDead(unit) and not UnitIsGhost(unit) then
							this.lastKnownAlive[name] = true
						else
							this.lastKnownAlive[name] = false
						end
					end
				end
			end
			
			this.lastKnownAlive[UnitName("player")] = not UnitIsDead("player") and not UnitIsGhost("player")
		end

		frame.InterestedInUnitHealth = function(unit)
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
					
					if interest then
						if string.find(unit, "pet") then
							interest = false
						end
					end
				end
			end
			
			return interest
		end
			
		frame:ScanGroupHealth()
		
		return frame
	end,
	
}