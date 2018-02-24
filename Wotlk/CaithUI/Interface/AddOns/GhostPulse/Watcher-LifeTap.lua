local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

local CHECK_INTERVAL = 5.0

local GetTime = _G.GetTime
local pairs = _G.pairs

LifeTapWatcher = {

	New = function(this, env, listenerFunction)
		-- check arguments
		if not env or type(env) ~= "table" then
			error("Must supply an environment tracker to DecurseWatcher:New()")
		end
		
		if not listenerFunction or type(listenerFunction) ~= "function" then
			error("Must supply a listener function to LifeTapWatcher:New()")
		end
			
		-- globals
		local frame = CreateFrame("Frame")
		
		
		frame.watcherName = "LifeTap"
		
		frame.nextCheckTime = 0
		frame.lastShowedAlert = nil
		
		frame.enabled = false		
		frame.enabledAlerts = { }
		
		frame.environment = env
		frame.OnDetect = listenerFunction
		
		-- functions
		frame:RegisterEvent("UNIT_MANA")
		frame:RegisterEvent("UNIT_HEALTH")
		
		frame.GetAlertTypes = function()
			return {
				["lifetap"] = L["Life Tap/Dark Pact"],
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
				if event == "UNIT_MANA" or event == "UNIT_HEALTH" then
					if this.enabledAlerts["lifetap"] and Environment:GetPlayerClass() == "WARLOCK" then
						this:NotifyLifeTap(...)
					end
				end
			end
		end)
		
		frame.NotifyLifeTap = function(this, unit)
			local curTime = GetTime()
			
			
			if this.enabled and this.lastShowedAlert == nil or ( curTime >= this.lastShowedAlert + CHECK_INTERVAL ) then
				if unit == "player" then
					local showLT = false
					local showDP = false
					local hasDarkPact = (select(5, GetTalentInfo(1, 21)) == 1)
					local pointsImpLifetap = select(5, GetTalentInfo(1, 6))
					local ltAmount = this:GetLifetapValue(pointsImpLifetap)
					local ltHealthCost = this:GetLifetapHealthCost(pointsImpLifetap)
					local dpAmount = this:GetDarkPactValue()
					local maxMana = UnitManaMax("player")
					local curMana = UnitMana("player")
					local currentManaPercent = curMana / maxMana
					local diff = maxMana - curMana
					local showedAlert = false
					local info = {
						["Unit"] = "player",
						["Type"] = "lifetap",
					}


					if hasDarkPact and diff >= dpAmount and this:PetMeetsReqs(dpAmount) then
						showDP = true
					end
					
					if showDP == false then
						if diff >= ltAmount and this:PlayerMeetsReqs(ltHealthCost) then
							showLT = true
						end
					end

					if showDP then
						info.Name = L["Dark Pact"]
						info.Spell = info.Name
						
						if this.OnDetect then
							if type(this.OnDetect) == "function" then
								this:OnDetect(this, "lifetap", L["Dark Pact"], "Interface\\Icons\\Spell_Shadow_DarkRitual", info)
							else
								error("LifeTapWatcher.OnDetect must be a function")
							end
						end
						
						showedAlert = true
					end
					
					if showLT then
						info.Name = L["Life Tap"]
						info.Spell = info.name
						
						if this.OnDetect then
							if type(this.OnDetect) == "function" then
								this:OnDetect(this, "lifetap", L["Life Tap"], "Interface\\Icons\\Spell_Shadow_BurningSpirit", info)
							else
								error("LifeTapWatcher.OnDetect must be a function")
							end
						end

						showedAlert = true
					end
									
					if showedAlert == false then
						this.lastShowedAlert = nil
					else
						this.lastShowedAlert = GetTime()
					end
				end
			end
		end
			
		frame.GetLifetapValue = function(this, pointsImpLT)
			local rc = 710
			local spi = UnitStat("player", 5)
			
			
			rc = rc + spi * 3.0
			rc = rc * ( 1 + ( 0.1 * pointsImpLT ) )
			
			return rc
		end
		
		frame.GetLifetapHealthCost = function(this, pointsImpLT)
			return this:GetLifetapValue(pointsImpLT)
		end
		
		frame.GetDarkPactValue = function(this)
			local rc = 700
			local plusShad = GetSpellBonusDamage(6)
			
			
			rc = rc + plusShad * 0.96
			
			return rc
		end
		
		frame.PlayerMeetsReqs = function(this, ltHealthCost)
			local rc = false
			
			
			if UnitHealth("player") >= ltHealthCost + 1 then
				rc = true
			end
			
			return rc
		end
		
		frame.PetMeetsReqs = function(this, dpAmount)
			local rc = false
			
			
			if UnitExists("playerpet") then
				if UnitCreatureFamily("playerpet") == L["Imp"] then
					local petMana = UnitMana("playerpet")
					
					
					if petMana >= dpAmount then
						rc = true
					end
				end
			end
				
			return rc
		end

		frame.HasAlchemistStone = function()
			local rc = false
			local link
			
			
			for i = 13, 14 do
				link = GetInventoryItemLink("player", i)
				
				if link then
					link = string.lower(link)
					
					
					if string.find(link, "alchemist's stone") then
						rc = true
						break
					elseif string.find(link, "alchemist stone") then
						rc = true
						break
					end
				end
			end
		
			return rc
		end

		frame.InZone = function(this, zoneList)
			local rc = false
			
		
			if table.isEmpty(zoneList) then
				rc = true
			else
				local curZone = GetRealZoneText()
				

				for i, _ in pairs(zoneList) do
					if curZone == i then
						rc = true
						break
					end
				end
			end
			
			return rc
		end
		
		return frame
	end,
	
}