local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local GetTime = _G.GetTime
local pairs = _G.pairs

local ccList = {
	[L["Hibernate"]] = true,
	[L["Cyclone"]] = true,
	[L["Polymorph"]] = true,
	[L["Seduction"]] = true,
	[L["Enslave Demon"]] = true,
	[L["Howl of Terror"]] = true,
	[L["Banish"]] = true,
	[L["Fear"]] = true,
	[L["Death Coil"]] = true,
	[L["Turn Evil"]] = true,
	[L["Freezing Trap"]] = true,
	[L["Scatter Shot"]] = true,
	[L["Scare Beast"]] = true,
	[L["Sap"]] = true,
	[L["Blind"]] = true,
	[L["Shackle Undead"]] = true,
	[L["Mind Control"]] = true,
}

CCExpiryWatcher = {

	New = function(this, env, listenerFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to CCExpiryWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to CCExpiryWatcher:New()")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "CCExpiry"
		
		frame.nextCheckTime = 0
		
		frame.enabled = false		
		frame.enabledAlerts = { }
			
		frame.environment = env
		frame.OnDetect = listenerFunction
		
		-- functions
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		
		frame.GetAlertTypes = function()
			return {
				["ccexpirytarget"] = L["CC Expiry (Target)"],
				["ccexpiryfocus"] = L["CC Expiry (Focus)"],
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
					if this.enabledAlerts["ccexpirytarget"] or this.enabledAlerts["ccexpiryfocus"] then
						this:NotifyExpiry(...)
					end
				end
			end
		end)		
		
		frame.NotifyExpiry = function(this, timeStamp, event, srcGuid, srcName, srcFlags, destGuid, destName, destFlags, spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool)
			local nameOfSpell = nil
			local idOfSpell

			
			if event == "SPELL_AURA_REMOVED" then
				if ccList[spellName] then
					nameOfSpell = spellName
					idOfSpell = spellID
				end
			elseif event == "SPELL_AURA_DISPELLED" then
				if ccList[extraSpellName] then
					nameOfSpell = extraSpellName
					idOfSpell = extraSpellID
				end
			end
			
			if nameOfSpell and idOfSpell then
				local destUnit = this:DestinationUnit(destGuid)
				
				
				-- and the destination is the current target or focus
				if destUnit then
					local _, _, texture = GetSpellInfo(idOfSpell)
					
					
					if texture then
						this:Alert(destUnit, nameOfSpell, texture)
						
						if UnitIsUnit("target", "focus") then
							this:Alert("focus", nameOfSpell, texture)
						end
					end
				end
			end
		end
		
		frame.Alert = function(this, unit, spellName, texture)
			-- alert
			if this.OnDetect then
				if type(this.OnDetect) == "function" then
					this:OnDetect(this, "ccexpiry"..unit, spellName, texture, {
						["Unit"] = unit,
						["Name"] = UnitName(unit),
						["Spell"] = spellName,
						["Type"] = "ccexpiry"..unit,
					})
				else
					error("CCExpiryWatcher.OnDetect must be a function")
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
		
		return frame
	end,
	
}